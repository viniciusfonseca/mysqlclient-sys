#!/bin/bash
set -euox pipefail

# this script should be invoked by vagga

# script made by https://github.com/Diggsey - https://github.com/sgrif/mysqlclient-sys/issues/17
cd /tmp
curl -LO https://downloads.mariadb.com/Connectors/c/connector-c-3.1.0/mariadb-connector-c-3.1.0-src.tar.gz
tar xzf mariadb-connector-c-3.1.0-src.tar.gz
mkdir build
cd build
sed 's/STRING(STRIP ${extra_dynamic_LDFLAGS} extra_dynamic_LDFLAGS)//' -i ../mariadb-connector-c-3.1.0-src/mariadb_config/CMakeLists.txt
sed 's/LIST(REMOVE_DUPLICATES extra_dynamic_LDFLAGS)//' -i ../mariadb-connector-c-3.1.0-src/mariadb_config/CMakeLists.txt
LDFLAGS=-L/usr/local/musl/lib cmake -DOPENSSL_USE_STATIC_LIBS=1 -DWITH_SSL=/usr/local/musl -DWITH_CURL=0 ../mariadb-connector-c-3.1.0-src
make mariadbclient
cp libmariadb/libmariadbclient.a /work/native/libmysqlclient.a
