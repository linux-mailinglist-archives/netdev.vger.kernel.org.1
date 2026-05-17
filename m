Return-Path: <netdev+bounces-288767-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mB2iDIQNCmqPwQQAu9opvQ
	(envelope-from <netdev+bounces-288767-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 20:48:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C76465635B9
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 20:48:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AA1E23003364
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 18:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15CD13CD8C9;
	Sun, 17 May 2026 18:48:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from passt.top (passt.top [88.198.0.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250A43BB12E;
	Sun, 17 May 2026 18:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.198.0.164
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779043701; cv=none; b=FsoF62spSvOPiWvjJ2IvqCePWH/eWbloB+ZQTQG7yZiXedO3yeja0XYDu/h64rtt3tnYdM8fFbKK8sX8yN/9kd81dBWQliIHsIRgo/utkybGapw9amYUDygKUU9HsMHjNEyRpSTiwRl3eeZmHxltY1MntoqUUDG8E4mUGiA1h1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779043701; c=relaxed/simple;
	bh=+MypbuIEfLMl4PKjMXEMqONpWrswGgRkBYEzylkgilU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g4PiptnJRr7xwrLC6fd5Xxg/YeeZqKYGBC17Xb2wy2Aqh/fYJc2oIxawxCvSphlw9jpzVuEcBgY9U3BHnH6jYohXA5tNkpymLK4FlaOtLYb46EOaagqEwHjVmckCtK4mDMWodB/R8vAh6dqOk+Yz374+1r3fRPG2y0RFC1PHEeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=passt.top; arc=none smtp.client-ip=88.198.0.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=passt.top
Received: by passt.top (Postfix, from userid 1000)
	id CFC7B5A061B; Sun, 17 May 2026 20:41:58 +0200 (CEST)
From: Stefano Brivio <sbrivio@redhat.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Pavel Emelyanov <xemul@scylladb.com>,
	Laurent Vivier <lvivier@redhat.com>,
	Jon Maloy <jmaloy@redhat.com>,
	Dmitry Safonov <dima@arista.com>,
	Andrei Vagin <avagin@google.com>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Subject: [PATCH net 2/2] selftests: Add data path tests for TCP_REPAIR mode
Date: Sun, 17 May 2026 20:41:58 +0200
Message-ID: <20260517184158.2757505-3-sbrivio@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260517184158.2757505-1-sbrivio@redhat.com>
References: <20260517184158.2757505-1-sbrivio@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C76465635B9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.54 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[redhat.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-288767-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sbrivio@redhat.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

The new tests check that, once TCP_REPAIR is enabled on a socket:

- additional incoming data queued to it don't increase the sequence
  number dumped via TCP_QUEUE_SEQ socket option

- a connected endpoint will not receive ACK segments after sending
  more data

These tests are implemented by a client, sending data and commands
(accept connection, enter repair mode, dump sequences, receive data,
and exit) describing the test sequence, and a server receiving data
and implementing those commands.

This way, the client can accurately synchronise repair modes with
data exchanges.

In order to avoid using loopback connections, where data would be
immediately acknowledged by the server side without packets being
actually sent or received, the client resides in a separate network
namespace ("inner") compared to the server, and a veth interface pair
connects them.

The tests can be run unprivileged as the outer network and user
namespaces are also detached as a first step, so that the veth
interfaces can be created in outer and inner namespaces without
capabilities.

Signed-off-by: Stefano Brivio <sbrivio@redhat.com>
---
 tools/testing/selftests/Makefile              |   1 +
 .../selftests/net/tcp_repair/.gitignore       |   3 +
 .../testing/selftests/net/tcp_repair/Makefile |  23 ++
 .../testing/selftests/net/tcp_repair/client.c | 273 ++++++++++++++++++
 .../testing/selftests/net/tcp_repair/inner.sh |  32 ++
 .../testing/selftests/net/tcp_repair/outer.sh |  44 +++
 tools/testing/selftests/net/tcp_repair/run.sh |  12 +
 .../testing/selftests/net/tcp_repair/server.c | 155 ++++++++++
 tools/testing/selftests/net/tcp_repair/talk.h |  26 ++
 9 files changed, 569 insertions(+)
 create mode 100644 tools/testing/selftests/net/tcp_repair/.gitignore
 create mode 100644 tools/testing/selftests/net/tcp_repair/Makefile
 create mode 100644 tools/testing/selftests/net/tcp_repair/client.c
 create mode 100755 tools/testing/selftests/net/tcp_repair/inner.sh
 create mode 100755 tools/testing/selftests/net/tcp_repair/outer.sh
 create mode 100755 tools/testing/selftests/net/tcp_repair/run.sh
 create mode 100644 tools/testing/selftests/net/tcp_repair/server.c
 create mode 100644 tools/testing/selftests/net/tcp_repair/talk.h

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index 6e59b8f63e41..e119abe5c78e 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -84,6 +84,7 @@ TARGETS += net/packetdrill
 TARGETS += net/ppp
 TARGETS += net/rds
 TARGETS += net/tcp_ao
+TARGETS += net/tcp_repair
 TARGETS += nolibc
 TARGETS += nsfs
 TARGETS += pci_endpoint
diff --git a/tools/testing/selftests/net/tcp_repair/.gitignore b/tools/testing/selftests/net/tcp_repair/.gitignore
new file mode 100644
index 000000000000..9756c86770b9
--- /dev/null
+++ b/tools/testing/selftests/net/tcp_repair/.gitignore
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+client
+server
diff --git a/tools/testing/selftests/net/tcp_repair/Makefile b/tools/testing/selftests/net/tcp_repair/Makefile
new file mode 100644
index 000000000000..d01d0a20b6df
--- /dev/null
+++ b/tools/testing/selftests/net/tcp_repair/Makefile
@@ -0,0 +1,23 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# selftests/net/tcp_repair: TCP_REPAIR connection tests
+#
+# Makefile - Build test client and server, declare run.sh entrypoint
+#
+# Copyright (c) 2026 Red Hat GmbH
+#
+# Author: Stefano Brivio <sbrivio@redhat.com>
+
+top_srcdir = ../../../../..
+
+CFLAGS += -Wall -Wextra -pedantic
+
+TEST_PROGS := \
+	run.sh
+
+TEST_GEN_FILES := \
+	client \
+	server \
+# end of TEST_GEN_FILES
+
+include ../../lib.mk
diff --git a/tools/testing/selftests/net/tcp_repair/client.c b/tools/testing/selftests/net/tcp_repair/client.c
new file mode 100644
index 000000000000..b5106bf922b1
--- /dev/null
+++ b/tools/testing/selftests/net/tcp_repair/client.c
@@ -0,0 +1,273 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/* selftests/net/tcp_repair: TCP_REPAIR connection tests
+ *
+ * client.c - Run list of tests, send commands and data to server
+ *
+ * Copyright (c) 2026 Red Hat GmbH
+ *
+ * Author: Stefano Brivio <sbrivio@redhat.com>
+ */
+
+#include <errno.h>
+#include <fcntl.h>
+#include <stdlib.h>
+#include <stdint.h>
+#include <stdio.h>
+#include <unistd.h>
+#include <sys/socket.h>
+#include <arpa/inet.h>
+#include <sys/types.h>
+#include <sys/socket.h>
+#include <netdb.h>
+
+#include <linux/tcp.h>		/* latest and greatest struct tcp_info, but */
+#define SOL_TCP		6	/* we can't include netinet/tcp.h as a result */
+
+#include "talk.h"
+
+/**
+ * srv() - Send command to server, return received value (not for ACCEPT)
+ * @ctl:	Control socket
+ * @op:		Command type
+ * @arg:	Optional argument (always sent, might be zero)
+ *
+ * Return: integer value received by client as response
+ */
+int srv(int ctl, enum op op, int arg)
+{
+	int cmd[2] = { op, arg }, ret;
+
+	send(ctl, cmd, sizeof(cmd), 0);
+	if (op != ACCEPT)
+		recv(ctl, &ret, sizeof(ret), 0);
+
+	return ret;
+}
+
+/**
+ * test_seq_slow_path() - Sequence doesn't change after sending one byte
+ * @ctl:	Control socket
+ * @data:	Data socket
+ *
+ * Return: 0 if the test passes, -1 if it fails
+ */
+int test_seq_slow_path(int ctl, int data)
+{
+	uint32_t seq1, seq2;
+
+	(void)ctl;
+	(void)data;
+
+	srv(ctl, REPAIR, TCP_REPAIR_ON);
+	seq1 = (uint32_t)srv(ctl, DUMP_RECV_SEQ, 0);
+
+	send(data, (char *)("a"), 1, 0);
+
+	seq2 = (uint32_t)srv(ctl, DUMP_RECV_SEQ, 0);
+
+	if (seq1 != seq2) {
+		fprintf(stderr, "Sequence changed in repair mode, %u -> %u\n",
+			seq1, seq2);
+		return -1;
+	}
+
+	return 0;
+}
+
+/**
+ * test_seq_fast_path() - Sequence doesn't change after a large transfer
+ * @ctl:	Control socket
+ * @data:	Data socket
+ *
+ * Return: 0 if the test passes, -1 if it fails
+ */
+int test_seq_fast_path(int ctl, int data)
+{
+	char buf[1000] = { 0 };
+	uint32_t seq1, seq2;
+	int i;
+
+	(void)ctl;
+	(void)data;
+
+	for (i = 0; i < 50; i++) {
+		send(data, buf, sizeof(buf), 0);
+		srv(ctl, RECV, sizeof(buf));
+	}
+
+	srv(ctl, REPAIR, TCP_REPAIR_ON);
+	seq1 = (uint32_t)srv(ctl, DUMP_RECV_SEQ, 0);
+
+	fcntl(data, F_SETFL, O_NONBLOCK);
+	for (i = 0; i < 50; i++)
+		send(data, buf, sizeof(buf), 0);
+
+	seq2 = (uint32_t)srv(ctl, DUMP_RECV_SEQ, 0);
+
+	if (seq1 != seq2) {
+		fprintf(stderr, "Sequence changed in repair mode, %u -> %u\n",
+			seq1, seq2);
+		return -1;
+	}
+
+	return 0;
+}
+
+/**
+ * test_acked_slow_path() - Our ACK sequence doesn't change after sending byte
+ * @ctl:	Control socket
+ * @data:	Data socket
+ *
+ * Return: 0 if the test passes, -1 if it fails
+ */
+int test_acked_slow_path(int ctl, int data)
+{
+	unsigned long acked1, acked2;
+	struct tcp_info tinfo;
+	socklen_t sl;
+
+	(void)ctl;
+	(void)data;
+
+	srv(ctl, REPAIR, TCP_REPAIR_ON);
+
+	sl = sizeof(tinfo);
+	getsockopt(data, SOL_TCP, TCP_INFO, &tinfo, &sl);
+	acked1 = tinfo.tcpi_bytes_acked;
+
+	send(data, (char *)("a"), 1, 0);
+
+	getsockopt(data, SOL_TCP, TCP_INFO, &tinfo, &sl);
+	acked2 = tinfo.tcpi_bytes_acked;
+
+	if (acked1 != acked2) {
+		fprintf(stderr, "ACK received in repair mode, %lu -> %lu\n",
+			acked1, acked2);
+		return -1;
+	}
+
+	return 0;
+}
+
+/**
+ * test_acked_fast_path() - Our ACK sequence doesn't change after large transfer
+ * @ctl:	Control socket
+ * @data:	Data socket
+ *
+ * Return: 0 if the test passes, -1 if it fails
+ */
+int test_acked_fast_path(int ctl, int data)
+{
+	unsigned long acked1, acked2;
+	char buf[1000] = { 0 };
+	struct tcp_info tinfo;
+	socklen_t sl;
+	int i;
+
+	(void)ctl;
+	(void)data;
+
+	for (i = 0; i < 50; i++) {
+		send(data, buf, sizeof(buf), 0);
+		srv(ctl, RECV, sizeof(buf));
+	}
+
+	srv(ctl, REPAIR, TCP_REPAIR_ON);
+
+	sl = sizeof(tinfo);
+	getsockopt(data, SOL_TCP, TCP_INFO, &tinfo, &sl);
+	acked1 = tinfo.tcpi_bytes_acked;
+
+	fcntl(data, F_SETFL, O_NONBLOCK);
+	for (i = 0; i < 50; i++)
+		send(data, buf, sizeof(buf), 0);
+
+	getsockopt(data, SOL_TCP, TCP_INFO, &tinfo, &sl);
+	acked2 = tinfo.tcpi_bytes_acked;
+
+	if (acked1 != acked2) {
+		fprintf(stderr, "ACK received in repair mode, %lu -> %lu\n",
+			acked1, acked2);
+		return -1;
+	}
+
+	return 0;
+}
+
+/**
+ * struct test - List of tests
+ * @desc:	Test description
+ * @f:		Function executing the test
+ */
+struct {
+	char *desc;
+	int (*f)(int ctl, int data);
+} test[] = {
+	{
+		"Sequence freezes in repair mode, slow path TCP input",
+		test_seq_slow_path,
+	},
+	{
+		"Sequence freezes in repair mode, fast path TCP input",
+		test_seq_fast_path,
+	},
+	{
+		"No ACKs in repair mode, slow path TCP input",
+		test_acked_slow_path,
+	},
+	{
+		"No ACKs in repair mode, fast path TCP input",
+		test_acked_fast_path,
+	},
+};
+
+/**
+ * main() - Entry point, connect control socket to server and run list of tests
+ * @argc:	Argument count, must be 3 (two options)
+ * @argv:	Options: server address and port
+ *
+ * Return: -1 on bad usage, 0 on success, 1 if at least one test fails
+ */
+int main(int argc, char **argv)
+{
+	struct addrinfo hints = { 0, AF_UNSPEC, SOCK_STREAM, 0, 0,
+				  NULL, NULL, NULL };
+	int ctl, data, ret = 0;
+	struct addrinfo *r;
+	unsigned i;
+
+	if (argc != 3) {
+		fprintf(stderr, "%s DST_ADDR DST_PORT\n", argv[0]);
+		return -1;
+	}
+
+	getaddrinfo(argv[1], argv[2], &hints, &r);
+
+	ctl = socket(r->ai_family, SOCK_STREAM, IPPROTO_TCP);
+	setsockopt(ctl, SOL_SOCKET, SO_REUSEADDR, &((int){ 1 }), sizeof(int));
+	connect(ctl, r->ai_addr, r->ai_addrlen);
+
+	for (i = 0; i < sizeof(test) / sizeof(test[0]); i++) {
+		int rc;
+
+		data = socket(r->ai_family, SOCK_STREAM, IPPROTO_TCP);
+		setsockopt(data, SOL_SOCKET, SO_REUSEADDR,
+			   &((int){ 1 }), sizeof(int));
+		srv(ctl, ACCEPT, 0);
+		connect(data, r->ai_addr, r->ai_addrlen);
+
+		rc = test[i].f(ctl, data);
+
+		close(data);
+
+		if (rc) {
+			fprintf(stdout, "TEST: %-60s  [FAIL]\n", test[i].desc);
+			ret = 1;
+		} else {
+			fprintf(stdout, "TEST: %-60s  [ OK ]\n", test[i].desc);
+		}
+	}
+
+	return ret;
+}
diff --git a/tools/testing/selftests/net/tcp_repair/inner.sh b/tools/testing/selftests/net/tcp_repair/inner.sh
new file mode 100755
index 000000000000..3987dc0514a8
--- /dev/null
+++ b/tools/testing/selftests/net/tcp_repair/inner.sh
@@ -0,0 +1,32 @@
+#!/bin/sh -euf
+# SPDX-License-Identifier: GPL-2.0
+#
+# selftests/net/tcp_repair: TCP_REPAIR connection tests
+#
+# inner.sh - Set up link to outer namespace, run test client in inner namespace
+#
+# Copyright (c) 2026 Red Hat GmbH
+#
+# Author: Stefano Brivio <sbrivio@redhat.com>
+
+ns_inner_dir="${1}"
+
+# Tell the parent shell about our PID
+echo "${$}" > "${ns_inner_dir}/pid"
+mkdir "${ns_inner_dir}/pid_ready"
+
+# Wait for veth to appear
+while [ -z "$(sed -n '4p' /proc/net/dev)" ]; do
+	sleep 0.1 || sleep 1
+done
+
+# Set up link to outer namespace
+ip link set dev veth0 up
+ip addr add 169.254.2.2 dev veth0
+ip ro add default dev veth0
+
+# Finally run tests
+set +e
+./client 169.254.2.1 1024
+echo "${?}" > "${ns_inner_dir}/result"
+mkdir "${ns_inner_dir}/result_ready"
diff --git a/tools/testing/selftests/net/tcp_repair/outer.sh b/tools/testing/selftests/net/tcp_repair/outer.sh
new file mode 100755
index 000000000000..17ae1230f0e5
--- /dev/null
+++ b/tools/testing/selftests/net/tcp_repair/outer.sh
@@ -0,0 +1,44 @@
+#!/bin/sh -euf
+# SPDX-License-Identifier: GPL-2.0
+#
+# selftests/net/tcp_repair: TCP_REPAIR connection tests
+#
+# outer.sh - Set up outer namespace, run test server there
+#
+# Copyright (c) 2026 Red Hat GmbH
+#
+# Author: Stefano Brivio <sbrivio@redhat.com>
+
+ns_inner_dir="$(mktemp -d)"
+
+cleanup() {
+	rm -rf "${ns_inner_dir}"
+}
+
+trap cleanup EXIT
+
+# Detach inner namespace in a subshell, tests start from there
+unshare -rUn -- ./inner.sh "${ns_inner_dir}" &
+
+# Wait for inner namespace
+while [ ! -d "${ns_inner_dir}/pid_ready" ]; do
+	sleep 0.1 || sleep 1
+done
+
+# Set up link to inner namespace
+ip link add veth0 type veth peer name veth0 netns "$(cat "${ns_inner_dir}/pid")"
+ip link set dev veth0 up
+ip addr add 169.254.2.1 dev veth0
+ip ro add default dev veth0
+
+# Run test server
+./server 1024
+
+# Wait for test results
+while [ ! -d "${ns_inner_dir}/result_ready" ]; do
+	sleep 0.1 || sleep 1
+done
+
+# Clean up and return results
+ret="$(cat "${ns_inner_dir}/result")"
+exit "${ret}"
diff --git a/tools/testing/selftests/net/tcp_repair/run.sh b/tools/testing/selftests/net/tcp_repair/run.sh
new file mode 100755
index 000000000000..f87ff0a8a6f6
--- /dev/null
+++ b/tools/testing/selftests/net/tcp_repair/run.sh
@@ -0,0 +1,12 @@
+#!/bin/sh -euf
+# SPDX-License-Identifier: GPL-2.0
+#
+# selftests/net/tcp_repair: TCP_REPAIR connection tests
+#
+# run.sh - Test entry point: detach outer namespace and run outer.sh in it
+#
+# Copyright (c) 2026 Red Hat GmbH
+#
+# Author: Stefano Brivio <sbrivio@redhat.com>
+
+unshare -rUn -- ./outer.sh
diff --git a/tools/testing/selftests/net/tcp_repair/server.c b/tools/testing/selftests/net/tcp_repair/server.c
new file mode 100644
index 000000000000..256c321320b7
--- /dev/null
+++ b/tools/testing/selftests/net/tcp_repair/server.c
@@ -0,0 +1,155 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* selftests/net/tcp_repair: TCP_REPAIR connection tests
+ *
+ * server.c - Receive commands and data, set TCP_REPAIR options on data socket
+ *
+ * Copyright (c) 2026 Red Hat GmbH
+ *
+ * Author: Stefano Brivio <sbrivio@redhat.com>
+ */
+
+#include <errno.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <unistd.h>
+#include <sys/socket.h>
+#include <arpa/inet.h>
+
+#include <linux/tcp.h>		/* needed for TCP_REPAIR constants but */
+#define SOL_TCP		6	/* we can't include netinet/tcp.h as a result */
+
+#include "talk.h"
+
+/**
+ * cmd_accept() - Accept data connection (must be first command in test)
+ * @unused:	Not used
+ * @listen:	Listening socket
+ * @data:	Return value from accept(), set on return
+ *
+ * Return: 0
+ */
+int cmd_accept(int unused, int listen, int *data)
+{
+	(void)unused;
+
+	if (*data != -1)
+		close(*data);
+
+	*data = accept(listen, NULL, NULL);
+
+	return 0;
+}
+
+/**
+ * cmd_dump_recv_seq() - Dump receive sequence of data socket
+ * @unused:	Not used
+ * @unused2:	Not used
+ * @data:	File descriptor for data socket
+ *
+ * Return: receive sequence of data socket
+ */
+int cmd_dump_recv_seq(int unused, int unused2, int *data)
+{
+	socklen_t sl;
+	int v;
+
+	(void)unused;
+	(void)unused2;
+
+	v = TCP_RECV_QUEUE;
+	setsockopt(*data, SOL_TCP, TCP_REPAIR_QUEUE, &v, sizeof(v));
+
+	sl = sizeof(v);
+	getsockopt(*data, SOL_TCP, TCP_QUEUE_SEQ, &v, &sl);
+	return v;
+}
+
+/**
+ * cmd_exit() - Exit successfully
+ * @unused:	Not used
+ * @unused2:	Not used
+ * @unused3:	Not used
+ *
+ * Return: this function doesn't actually return
+ */
+int cmd_exit(int unused, int unused2, int *unused3)
+{
+	(void)unused;
+	(void)unused2;
+	(void)unused3;
+
+	exit(EXIT_SUCCESS);
+	return 0;
+}
+
+/**
+ * cmd_recv() - Receive (discard) a given amount of bytes
+ * @len:	Amount of bytes the client wants us to receive
+ * @unused:	Not used
+ * @data:	File descriptor for data socket
+ *
+ * Return: return code from recv()
+ */
+int cmd_recv(int len, int unused, int *data)
+{
+	(void)unused;
+
+	return recv(*data, NULL, len, MSG_TRUNC);
+}
+
+/**
+ * cmd_repair() - Set repair mode to mode supplied by client
+ * @mode:	Value for socket option provided by the client
+ * @unused:	Not used
+ * @data:	File descriptor for data socket
+ *
+ * Return: return code from setsockopt()
+ */
+int cmd_repair(int mode, int unused, int *data)
+{
+	(void)unused;
+
+	return setsockopt(*data, SOL_TCP, TCP_REPAIR, &mode, sizeof(mode));
+}
+
+/* List of commands and their handlers */
+int (*fn[])(int arg, int listen, int *data) = {
+	[ACCEPT]	= cmd_accept,
+	[DUMP_RECV_SEQ]	= cmd_dump_recv_seq,
+	[EXIT]		= cmd_exit,
+	[RECV]		= cmd_recv,
+	[REPAIR]	= cmd_repair,
+};
+
+/**
+ * main() - Entry point, accept control connection and dispatch commands
+ * @argc:	Argument count, must be 2 (one option)
+ * @argv:	Options: server port
+ *
+ * Return: 0 on success, exit on failure
+ */
+int main(int argc, char **argv)
+{
+	struct sockaddr_in a = { AF_INET, htons(atoi(argv[1])), { 0 }, { 0 } };
+	int s, ctl, data = -1, cmd[2];
+
+	s = socket(AF_INET, SOCK_STREAM, IPPROTO_TCP);
+	setsockopt(s, SOL_SOCKET, SO_REUSEADDR, &((int){ 1 }), sizeof(int));
+
+	if (argc != 2) {
+		fprintf(stderr, "%s PORT\n", argv[0]);
+		exit(EXIT_FAILURE);
+	}
+
+	bind(s, (struct sockaddr *)&a, sizeof(a));
+	listen(s, 0);
+	ctl = accept(s, NULL, NULL);
+
+	while (recv(ctl, cmd, sizeof(cmd), 0) == sizeof(cmd)) {
+		int ret = fn[cmd[0]](cmd[1], s, &data);
+		if (cmd[0] != ACCEPT)
+			send(ctl, &ret, sizeof(ret), 0);
+	}
+
+	return 0;
+}
diff --git a/tools/testing/selftests/net/tcp_repair/talk.h b/tools/testing/selftests/net/tcp_repair/talk.h
new file mode 100644
index 000000000000..e2fbad7fae07
--- /dev/null
+++ b/tools/testing/selftests/net/tcp_repair/talk.h
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/* selftests/net/tcp_repair: TCP_REPAIR connection tests
+ *
+ * talk.h - Communication protocol for client and server
+ *
+ * Copyright (c) 2026 Red Hat GmbH
+ *
+ * Author: Stefano Brivio <sbrivio@redhat.com>
+ */
+
+/**
+ * enum op - Server command type (taking optional int argument, returning int)
+ * @ACCEPT		Accept connection on data socket (doesn't return int)
+ * @DUMP_RECV_SEQ	Dump receive sequence, return it to the client
+ * @EXIT		Exit, return 0 to the client
+ * @RECV		Try receiving given amount of bytes, return received
+ * @REPAIR		Set repair mode to argument, return setsockopt() value
+ */
+enum op {
+	ACCEPT,
+	DUMP_RECV_SEQ,
+	EXIT,
+	RECV,
+	REPAIR,
+};
-- 
2.43.0


