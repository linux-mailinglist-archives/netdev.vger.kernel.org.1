Return-Path: <netdev+bounces-302821-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +f+KMMjLQmr0CQoAu9opvQ
	(envelope-from <netdev+bounces-302821-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 21:47:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A71A6DE7CF
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 21:47:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=xs4all.nl header.s=xs4all01 header.b=HLQmjI2c;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302821-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-302821-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=xs4all.nl;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EEAD430ACE4E
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 19:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E492E3BED1F;
	Mon, 29 Jun 2026 19:42:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B7A3EA947
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 19:42:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782762165; cv=none; b=bX9WmeEXg2xytpM2yGHfwMWi9TRav48AdcxMB+CstoYtf3VUHtkndUWN5+iG1HQ6PYaROPst1wNlhzgoH1+1JwbSdWfJ20kYOo8Ekur8JKO9fXKQCD0aR+YNbsLkpjSlowRrZ/svLmFAvppV5JikkOiLfj3ljzfIU4rUf2pYz+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782762165; c=relaxed/simple;
	bh=771913KNEgAmcUzG6I55O2cBXCoV58ZG5cTsyqxEKP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=knR46hDaBeBw+woVhfR0zhMnZE5/4dI7Qd4x32gpWg4/+96tAWx2uHak+5m5By7tIl2aX94x60Nz+JkOpHhQFZ4dbquo4Y8EBONkH7oPU5aGI2Xedu8Vgfy+3JGOviNydmxoHpjzlv71rZAdqC2dCqP9gQqeI94AltKfcTd4dZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=HLQmjI2c; arc=none smtp.client-ip=195.121.94.185
X-KPN-MessageId: ac195578-73f2-11f1-9e8e-005056999439
Received: from smtp.kpnmail.nl (unknown [10.31.155.7])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id ac195578-73f2-11f1-9e8e-005056999439;
	Mon, 29 Jun 2026 21:42:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=mime-version:message-id:date:subject:to:from;
	bh=KVLNbAqFFCG8rwDMRhT8CoQ0eu3LivfXB93/2AHA5VY=;
	b=HLQmjI2cmifG/y9rH5mpRb0NdJvsowAfK7t8obqQpyVRhsL4O/0Sxh/bx+QEcfoFZsKV9ae8Njo57
	 gMcurozM5v9qgBhR/Cg2xE8v40BOFa0IHKZVqpHT+G2PA2qqWu7ONw2t42BpVxGWlHrkcyI4rXFptk
	 sl/qKTdK0Yso/PXX3hz+k8Z1c4fyXq+3nAOOLeUuIyTTZCwBkgqPrA4EFzyM4ScU4cu/qnXOhhZh0F
	 8NaLWYc8qJIskBHnaoOf3upAC7HzKK7qCoK6DyrP+O09mRMMU1biPRADh/bHV76vZGVJaN1h0K52qs
	 IiyyOfSbzjoEGnJJqkUFTiAUkKrU3KA==
X-KPN-MID: 33|WIsaJIEUAEB7BvzjQuPc3Bzgwys8unxdIUOszHw7dcg7PdFo6qesJykeTxMRrNa
 jI1wiPvzd0Vp/FVjrURD/AF/PHmSOScmatQSplxwgu+w=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|i//pJlOhFUi5Z1DfDdgx9RLRbAVjrqcJMejy62y1lrjdngY/uLQTObok7MBCuMk
 aSUWx+azEhxlqSmVMsfSTkw==
Received: from daedalus.home (unknown [178.231.11.185])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id abd0ad6c-73f2-11f1-8076-005056998788;
	Mon, 29 Jun 2026 21:42:33 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>,
	Aleksa Sarai <cyphar@cyphar.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jori Koolstra <jkoolstra@xs4all.nl>
Subject: [PATCH net-next v3 5/5] selftest: Add tests for useful handling of LSM denials on SCM_RIGHTS
Date: Mon, 29 Jun 2026 21:43:27 +0200
Message-ID: <20260629194327.2270798-6-jkoolstra@xs4all.nl>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260629194327.2270798-1-jkoolstra@xs4all.nl>
References: <20260629194327.2270798-1-jkoolstra@xs4all.nl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[xs4all.nl,reject];
	R_DKIM_ALLOW(-0.20)[xs4all.nl:s=xs4all01];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,xs4all.nl];
	FREEMAIL_FROM(0.00)[xs4all.nl];
	TAGGED_FROM(0.00)[bounces-302821-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:brauner@kernel.org,m:cyphar@cyphar.com,m:kuniyu@google.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:jkoolstra@xs4all.nl,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[jkoolstra@xs4all.nl,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jkoolstra@xs4all.nl,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[xs4all.nl:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,scm_rights_denial.sh:url,xs4all.nl:dkim,xs4all.nl:email,xs4all.nl:mid,xs4all.nl:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1A71A6DE7CF

Tests SCM_RIGHTS fd passing on a socket with the new socket option
SO_RIGHTS_NOTRUNC turned on.

The test uses the following Smack labels:

   "Sender"   - label for the sending process
   "Receiver" - label for the receiving process
   "SecretX"   - labels for the files being passed

Socket communication (Sender <-> Receiver) is always allowed.
The tests control whether Receiver can access "SecretX"-labeled fds.
When the LSM blocks an fd, we should see a sentinel that corresponds to
the error returned by the LSM, such as -EACCES.

Signed-off-by: Jori Koolstra <jkoolstra@xs4all.nl>
---
 .../testing/selftests/net/af_unix/.gitignore  |   3 +
 tools/testing/selftests/net/af_unix/Makefile  |   4 +
 .../selftests/net/af_unix/scm_rights_denial.c |  20 ++
 .../selftests/net/af_unix/scm_rights_denial.h |  38 ++++
 .../net/af_unix/scm_rights_denial.sh          | 174 ++++++++++++++++
 .../net/af_unix/scm_rights_denial_receiver.c  | 195 ++++++++++++++++++
 .../net/af_unix/scm_rights_denial_sender.c    | 126 +++++++++++
 7 files changed, 560 insertions(+)
 create mode 100644 tools/testing/selftests/net/af_unix/scm_rights_denial.c
 create mode 100644 tools/testing/selftests/net/af_unix/scm_rights_denial.h
 create mode 100755 tools/testing/selftests/net/af_unix/scm_rights_denial.sh
 create mode 100644 tools/testing/selftests/net/af_unix/scm_rights_denial_receiver.c
 create mode 100644 tools/testing/selftests/net/af_unix/scm_rights_denial_sender.c

diff --git a/tools/testing/selftests/net/af_unix/.gitignore b/tools/testing/selftests/net/af_unix/.gitignore
index 240b26740c9e..2e14b025a6e8 100644
--- a/tools/testing/selftests/net/af_unix/.gitignore
+++ b/tools/testing/selftests/net/af_unix/.gitignore
@@ -3,6 +3,9 @@ msg_oob
 scm_inq
 scm_pidfd
 scm_rights
+scm_rights_denial
+scm_rights_denial_receiver
+scm_rights_denial_sender
 so_peek_off
 unix_connect
 unix_connreset
diff --git a/tools/testing/selftests/net/af_unix/Makefile b/tools/testing/selftests/net/af_unix/Makefile
index 4c0375e28bbe..86c5588caf28 100644
--- a/tools/testing/selftests/net/af_unix/Makefile
+++ b/tools/testing/selftests/net/af_unix/Makefile
@@ -11,9 +11,13 @@ TEST_GEN_PROGS := \
 	scm_inq \
 	scm_pidfd \
 	scm_rights \
+	scm_rights_denial \
 	so_peek_off \
 	unix_connect \
 	unix_connreset \
 # end of TEST_GEN_PROGS
 
+TEST_GEN_FILES := scm_rights_denial_sender scm_rights_denial_receiver
+TEST_FILES := scm_rights_denial.sh
+
 include ../../lib.mk
diff --git a/tools/testing/selftests/net/af_unix/scm_rights_denial.c b/tools/testing/selftests/net/af_unix/scm_rights_denial.c
new file mode 100644
index 000000000000..3566f1d28b9a
--- /dev/null
+++ b/tools/testing/selftests/net/af_unix/scm_rights_denial.c
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <stdlib.h>
+#include <sys/wait.h>
+
+#include "kselftest_harness.h"
+
+TEST(scm_rights_denial)
+{
+	int ret = system("./scm_rights_denial.sh");
+
+	ASSERT_NE(-1, ret);
+	ASSERT_TRUE(WIFEXITED(ret));
+
+	if (WEXITSTATUS(ret) == KSFT_SKIP)
+		SKIP(return, "scm_rights_denial.sh prerequisites not met");
+
+	EXPECT_EQ(0, WEXITSTATUS(ret));
+}
+
+TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/net/af_unix/scm_rights_denial.h b/tools/testing/selftests/net/af_unix/scm_rights_denial.h
new file mode 100644
index 000000000000..2ecdf2b8b973
--- /dev/null
+++ b/tools/testing/selftests/net/af_unix/scm_rights_denial.h
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <unistd.h>
+#include <fcntl.h>
+
+#ifndef SO_RIGHTS_NOTRUNC
+#define SO_RIGHTS_NOTRUNC 85
+#endif
+
+#define CMSG_IS_SCM_RIGHTS(cmsg) ({		\
+	typeof(cmsg) _cmsg = (cmsg);		\
+	_cmsg &&				\
+	_cmsg->cmsg_level == SOL_SOCKET &&	\
+	_cmsg->cmsg_type == SCM_RIGHTS;		\
+})
+
+#define MIN(a, b) ({ \
+	typeof(a) _a = (a); \
+	typeof(b) _b = (b); \
+	_a < _b ? _a : _b; \
+})
+
+#define MAX_FDS 10
+
+static inline int read_current_label(char *label, size_t size)
+{
+	int fd = open("/proc/self/attr/current", O_RDONLY);
+	if (fd < 0)
+		return fd;
+
+	ssize_t r = read(fd, label, size - 1);
+	close(fd);
+	if (r < 0)
+		return r;
+
+	label[r] = '\0';
+
+	return 0;
+}
diff --git a/tools/testing/selftests/net/af_unix/scm_rights_denial.sh b/tools/testing/selftests/net/af_unix/scm_rights_denial.sh
new file mode 100755
index 000000000000..74cafe1dfc62
--- /dev/null
+++ b/tools/testing/selftests/net/af_unix/scm_rights_denial.sh
@@ -0,0 +1,174 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+#
+# scm_rights_denial.sh - Test SCM_RIGHTS fd passing using Smack LSM blocking
+#
+# Must be run as root on a kernel with Smack enabled (security=smack).
+# Requires: capsh (libcap), setfattr/getfattr (attr)
+#
+# We use the following Smack labels:
+#   "Sender"   - label for the sending process
+#   "Receiver" - label for the receiving process
+#   "SecretX"   - labels for the files being passed
+#
+# Socket communication (Sender <-> Receiver) is always allowed.
+# The tests control whether Receiver can access "SecretX"-labeled fds.
+#
+
+set -e
+
+readonly KSFT_SKIP=4
+
+readonly SENDER="./scm_rights_denial_sender"
+readonly RECEIVER="./scm_rights_denial_receiver"
+
+readonly TESTDIR="$(mktemp -d)"
+readonly SOCK="$TESTDIR/scm_test.sock"
+readonly TESTFILE1="$TESTDIR/secret_1"
+readonly TESTFILE2="$TESTDIR/secret_2"
+
+trap 'rm -rf "$TESTDIR"' EXIT
+
+run_tests() {
+
+	preflight
+	setup
+
+	run_test "TEST 1" \
+		"Receiver should NOT have access to Secret1." \
+		"Receiver Secret1 ---
+Receiver Secret2 ---" \
+		"$TESTFILE1" \
+		"BLOCKED"
+
+	run_test "TEST 2" \
+		"Receiver should have access to Secret1." \
+		"Receiver Secret1 r--
+Receiver Secret2 ---" \
+		"$TESTFILE1" \
+		"PASSED"
+
+	run_test "TEST 3" \
+		"Receiver should have access to Secret2, but NOT Secret1." \
+		"Receiver Secret1 ---
+Receiver Secret2 r--" \
+		"$TESTFILE1 $TESTFILE2" \
+		"BLOCKED PASSED"
+}
+
+run_test() {
+	local name="$1"
+	local description="$2"
+	local rules="$3"
+	local files="$4"
+	local expected="$5"
+
+	echo ""
+	echo "$name: $description"
+	echo "Rules:"
+	echo "$rules"
+	echo "Expected: $expected"
+	echo ""
+
+	while IFS= read -r rule; do
+		[ -n "$rule" ] && echo "$rule" > /sys/fs/smackfs/load2
+	done <<< "$rules"
+
+	local output status last_line
+	output=$(send_fds "$SOCK" $files)
+	status=$?
+	echo "$output"
+	last_line=$(echo "$output" | tail -n 1 | xargs)
+
+	if [ "$status" -ne 0 ]; then
+		echo "TEST FAILED: receiver returned $status"
+		return 1
+	fi
+
+	if [[ "$last_line" == "$expected" ]]; then
+		echo "TEST PASSED: outcome was $expected as expected"
+		return 0
+	else
+		echo "TEST FAILED: expected $expected, got '$last_line'"
+		return 1
+	fi
+}
+
+setup() {
+
+	printf "Secret 1" > "$TESTFILE1"
+	printf "Secret 2" > "$TESTFILE2"
+
+	setfattr -n security.SMACK64 -v "Secret1" "$TESTFILE1"
+	setfattr -n security.SMACK64 -v "Secret2" "$TESTFILE2"
+	setfattr -n security.SMACK64 -v "Tmp" /tmp
+	setfattr -n security.SMACK64 -v "Tmp" "$TESTDIR"
+
+	echo "Sender	Receiver	-w-" > /sys/fs/smackfs/load2
+	echo "Receiver	Sender		-w-" > /sys/fs/smackfs/load2
+	echo "Sender	Tmp 		rwx" > /sys/fs/smackfs/load2
+	echo "Receiver	Tmp		rwx" > /sys/fs/smackfs/load2
+	echo "Sender	Secret1		r--" > /sys/fs/smackfs/load2
+	echo "Sender	Secret2		r--" > /sys/fs/smackfs/load2
+}
+
+send_fds() {
+
+	local sk="$1"
+	shift
+	local files="$*"
+
+	(
+	    echo "Receiver" > /proc/self/attr/current
+	    exec capsh --drop=cap_mac_override,cap_mac_admin -- -c "$RECEIVER $sk"
+	) &
+	local recv_pid=$!
+	sleep 1
+
+	(
+	    echo "Sender" > /proc/self/attr/current
+	    exec capsh --drop=cap_mac_override,cap_mac_admin -- -c "$SENDER $sk $files"
+	) || true
+
+	local recv_status=0
+	wait "$recv_pid" || recv_status=$?
+
+	if [ "$recv_status" -ne 0 ]; then
+	    echo "receiver exited with $recv_status"
+	fi
+	return "$recv_status"
+}
+
+preflight() {
+
+	if [ "$(id -u)" -ne 0 ]; then
+	    echo "SKIP: must be run as root"
+	    exit $KSFT_SKIP
+	fi
+
+	if ! grep -q smack /sys/kernel/security/lsm 2>/dev/null; then
+	    echo "SKIP: Smack is not active"
+	    echo "  Check: cat /sys/kernel/security/lsm"
+	    echo "  Boot with: security=smack"
+	    exit $KSFT_SKIP
+	fi
+
+	if ! mountpoint -q /sys/fs/smackfs 2>/dev/null; then
+	    echo "Mounting smackfs..."
+	    mount -t smackfs smackfs /sys/fs/smackfs
+	fi
+
+	if ! command -v capsh &>/dev/null; then
+	    echo "SKIP: capsh not found (install libcap)"
+	    exit $KSFT_SKIP
+	fi
+
+	if [ ! -x "$SENDER" ] || [ ! -x "$RECEIVER" ]; then
+	    echo "ERROR: $SENDER / $RECEIVER not built (run 'make' first)"
+	    exit 1
+	fi
+
+}
+
+run_tests
diff --git a/tools/testing/selftests/net/af_unix/scm_rights_denial_receiver.c b/tools/testing/selftests/net/af_unix/scm_rights_denial_receiver.c
new file mode 100644
index 000000000000..2965980f96ef
--- /dev/null
+++ b/tools/testing/selftests/net/af_unix/scm_rights_denial_receiver.c
@@ -0,0 +1,195 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * scm_rights_denial_receiver.c - Receive fds over a Unix socket via SCM_RIGHTS
+ *
+ * Usage: ./scm_rights_denial_receiver <socket_path>
+ *
+ * Listens on the given Unix socket path, accepts a connection, and
+ * attempts to receive file descriptors via SCM_RIGHTS. Reports
+ * whether the fds were delivered or blocked.
+ *
+ * Used for testing LSM (Smack) blocking of fd passing.
+ */
+
+#include <sys/socket.h>
+#include <sys/un.h>
+#include <sys/xattr.h>
+#include <unistd.h>
+#include <string.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <fcntl.h>
+
+#include "scm_rights_denial.h"
+
+#define RECV_LOG(fmt, ...) printf("receiver: " fmt, ##__VA_ARGS__)
+#define RECV_ERR(fmt, ...) fprintf(stderr, "receiver: " fmt, ##__VA_ARGS__)
+
+static int recv_fds(int sock, int *fds)
+{
+	char buf[1];
+	char ctrl[CMSG_SPACE(MAX_FDS * sizeof(int))];
+
+	struct iovec iov = {
+		.iov_base = buf,
+		.iov_len  = sizeof(buf),
+	};
+	struct msghdr msg = {
+		.msg_iov        = &iov,
+		.msg_iovlen     = 1,
+		.msg_control    = ctrl,
+		.msg_controllen = sizeof(ctrl),
+	};
+
+	ssize_t bytes_read = recvmsg(sock, &msg, 0);
+	if (bytes_read < 0) {
+		perror("receiver: recvmsg");
+		return -1;
+	}
+	if (bytes_read == 0) {
+		RECV_ERR("connection closed, no data received\n");
+		return -1;
+	}
+
+	struct cmsghdr *cmsg = CMSG_FIRSTHDR(&msg);
+	if (!CMSG_IS_SCM_RIGHTS(cmsg)) {
+		RECV_ERR("no SCM_RIGHTS in control message\n");
+		return -1;
+	}
+
+	int num_fd_slots = (cmsg->cmsg_len - CMSG_LEN(0)) / sizeof(int);
+	memcpy(fds, CMSG_DATA(cmsg), num_fd_slots  * sizeof(int));
+
+	RECV_LOG("got %d fd slot(s):", num_fd_slots);
+	for (int i = 0; i < num_fd_slots ; i++) {
+		if (fds[i] < 0)
+			printf(" %s", strerrorname_np(-fds[i]));
+		else
+			printf(" %d", fds[i]);
+	}
+	putchar('\n');
+
+	return num_fd_slots;
+}
+
+static inline int print_current_label(void)
+{
+	char label[256];
+	if (!read_current_label(label, sizeof(label))) {
+		RECV_LOG("running with Smack label '%s'\n", label);
+		return 0;
+	}
+	return -1;
+}
+
+int main(int argc, char *argv[])
+{
+	if (argc != 2) {
+		fprintf(stderr, "Usage: %s <socket_path>\n", argv[0]);
+		return -1;
+	}
+
+	if (print_current_label()) {
+		RECV_ERR("cannot read process Smack label");
+		return -1;
+	}
+
+	int listen_sock = socket(AF_UNIX, SOCK_STREAM, 0);
+	if (listen_sock < 0) {
+		perror("receiver: socket");
+		return -1;
+	}
+
+	struct sockaddr_un addr = {};
+	addr.sun_family = AF_UNIX;
+	strncpy(addr.sun_path, argv[1], sizeof(addr.sun_path) - 1);
+
+	/* Remove any stale socket file */
+	unlink(argv[1]);
+
+	if (bind(listen_sock, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
+		perror("receiver: bind");
+		return -1;
+	}
+
+	if (listen(listen_sock, 1) < 0) {
+		perror("receiver: listen");
+		return -1;
+	}
+
+	RECV_LOG("listening on '%s'\n", argv[1]);
+
+	int conn_sock = accept(listen_sock, NULL, NULL);
+	if (conn_sock < 0) {
+		perror("receiver: accept");
+		return -1;
+	}
+
+	RECV_LOG("connection accepted\n");
+
+	int one = 1;
+	if (setsockopt(conn_sock, SOL_SOCKET, SO_RIGHTS_NOTRUNC,
+		       &one, sizeof(one)) < 0) {
+		perror("receiver: setsockopt(SO_RIGHTS_NOTRUNC)");
+		goto out_sock;
+	}
+
+	/* Try to receive the fds */
+	int fds[MAX_FDS];
+	int num_fds = recv_fds(conn_sock, fds);
+	if (num_fds < 0)
+		goto out_sock;
+
+	/* Try to use the received fds -- read and print their contents */
+	RECV_LOG("attempting to read from received fds...\n");
+	int i;
+	for (i = 0; i < num_fds; ++i) {
+		char readbuf[256];
+
+		if (fds[i] < 0) {
+			RECV_LOG("fd in position %i blocked\n", i);
+			continue;
+		} else if (fds[i] == 0) {
+			RECV_LOG("bad fd in position %i\n", i);
+			goto out_recv;
+		}
+
+		ssize_t n = read(fds[i], readbuf, sizeof(readbuf) - 1);
+		if (n < 0) {
+			perror("receiver: read from received fd");
+			goto out_recv;
+		}
+
+		readbuf[n] = '\0';
+		RECV_LOG("read %zd bytes from fd at position %i: '%s'\n", n, i, readbuf);
+	}
+
+	RECV_LOG("final result:\n");
+	for (int j = 0; j < num_fds; ++j) {
+		if (fds[j] < 0) {
+			printf("BLOCKED");
+		} else {
+			printf("PASSED");
+			close(fds[j]);
+		}
+		putchar(' ');
+	}
+
+	close(conn_sock);
+	close(listen_sock);
+	unlink(argv[1]);
+	return 0;
+
+out_recv:
+	for (int j = 0; j < num_fds; ++j) {
+		if (fds[j] > 0)
+			close(fds[j]);
+	}
+
+out_sock:
+	close(conn_sock);
+	close(listen_sock);
+	unlink(argv[1]);
+	return -1;
+}
diff --git a/tools/testing/selftests/net/af_unix/scm_rights_denial_sender.c b/tools/testing/selftests/net/af_unix/scm_rights_denial_sender.c
new file mode 100644
index 000000000000..9742eb25f0b5
--- /dev/null
+++ b/tools/testing/selftests/net/af_unix/scm_rights_denial_sender.c
@@ -0,0 +1,126 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/*
+ * scm_rights_denial_sender.c - Send fds over a Unix socket via SCM_RIGHTS
+ *
+ * Usage: ./scm_rights_denial_sender <socket_path> <file_to_send> [<file_to_send>...]
+ *
+ * Opens the specified files and sends their fds to a receiver connected
+ * on the given Unix socket path. Used for testing LSM blocking of fd
+ * passing.
+ */
+
+#include <sys/socket.h>
+#include <sys/un.h>
+#include <unistd.h>
+#include <string.h>
+#include <stdio.h>
+#include <fcntl.h>
+
+#include "scm_rights_denial.h"
+
+#define SEND_LOG(fmt, ...) fprintf(stdout, "sender: " fmt, ##__VA_ARGS__)
+#define SEND_ERR(fmt, ...) fprintf(stderr, "sender: " fmt, ##__VA_ARGS__)
+
+static int send_fds(int sock, int *fds, int num_fds)
+{
+	if (num_fds > MAX_FDS)
+		return -1;
+
+	char buf[1] = { 'X' };
+	char ctrl[CMSG_SPACE(MAX_FDS * sizeof(int))] = { 0 };
+
+	struct iovec iov = {
+		.iov_base = buf,
+		.iov_len  = sizeof(buf),
+	};
+	struct msghdr msg = {
+		.msg_iov        = &iov,
+		.msg_iovlen     = 1,
+		.msg_control    = ctrl,
+		.msg_controllen = CMSG_SPACE(num_fds * sizeof(int)),
+	};
+
+	struct cmsghdr *cmsg = CMSG_FIRSTHDR(&msg);
+	cmsg->cmsg_level = SOL_SOCKET;
+	cmsg->cmsg_type  = SCM_RIGHTS;
+	cmsg->cmsg_len   = CMSG_LEN(num_fds * sizeof(int));
+	memcpy(CMSG_DATA(cmsg), fds, num_fds * sizeof(int));
+
+	ssize_t bytes_send = sendmsg(sock, &msg, 0);
+	if (bytes_send < 0) {
+		perror("sender: sendmsg");
+		return -1;
+	}
+
+	return 0;
+}
+
+static inline int print_current_label(void)
+{
+	char label[256];
+	if (!read_current_label(label, sizeof(label))) {
+		SEND_LOG("running with Smack label '%s'\n", label);
+		return 0;
+	}
+	return -1;
+}
+
+int main(int argc, char *argv[])
+{
+	if (argc < 3 || argc > 2 + MAX_FDS) {
+		fprintf(stderr, "Usage: %s <socket_path> <file_to_send> [<file_to_send>...]\\n",
+			argv[0]);
+		fprintf(stderr, "Up to a maximum of %d files", MAX_FDS);
+		return -1;
+	}
+
+	if (print_current_label()) {
+		SEND_ERR("cannot read process Smack label");
+		return -1;
+	}
+
+	int sock = socket(AF_UNIX, SOCK_STREAM, 0);
+	if (sock < 0) {
+		perror("sender: socket");
+		return -1;
+	}
+
+	struct sockaddr_un addr = {};
+	addr.sun_family = AF_UNIX;
+	strncpy(addr.sun_path, argv[1], sizeof(addr.sun_path) - 1);
+
+	if (connect(sock, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
+		perror("sender: connect");
+		goto out_sock;
+	}
+
+	SEND_LOG("connected to '%s'\n", argv[1]);
+
+	int num_files = argc - 2;
+	int fds[MAX_FDS];
+	int i;
+	for (i = 0; i < num_files; i++) {
+		fds[i] = open(argv[2 + i], O_RDONLY);
+		if (fds[i] < 0) {
+			perror("sender: open file");
+			goto out_opened;
+		}
+		SEND_LOG("opened '%s' as fd %d\n", argv[2 + i], fds[i]);
+	}
+
+	if (send_fds(sock, fds, num_files) < 0)
+		goto out_opened;
+
+	SEND_LOG("fds successfully sent:");
+	for (int j = 0; j < num_files; j++)
+		printf(" %d", fds[j]);
+	putchar('\n');
+
+out_opened:
+	for (int j = 0; j < i; j++)
+		close(fds[j]);
+out_sock:
+	close(sock);
+	return -1;
+}
-- 
2.54.0


