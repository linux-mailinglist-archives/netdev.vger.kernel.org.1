Return-Path: <netdev+bounces-81783-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EEA388B168
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 21:30:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43EC82947A2
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 20:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE288C0B;
	Mon, 25 Mar 2024 20:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="BT6gCAhZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066EC28E7
	for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 20:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711398653; cv=none; b=ZXPcMGdageOHKIHOzkdJqpqJa5c7JIkPqj27VxhZrLbuHX68AiCeiDh+JUcaBVAlQcTW5B2wu/cU2njWWOwq4aAQNtc6Lm+8EFiDM81XNgORsOVp3U1VSi3p0SkzLdPXQgfm6DJCMGt2G8BuUpvWOyJayIzqW7J41nygQwL9vvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711398653; c=relaxed/simple;
	bh=ZuRdZHLz50uFNXbgNZaAm/C6KqlpRhYt39V0cu7ic4E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yg3A5XZOb4ZDIqjZYP6JvK+B9bmLDDkubGvNG3Hbz0QJi2xcrvKNw+XPCCLZ80umEJT/R1eG1r2wgyxps3JmRFMowb9nVtALL9LT+xFvGDlLnbZ9VTJjS+pT7xy2FPwPBLxBP82YOehxvk8S5V3xdNj1BcZoPywbnV4/MjwnFak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=BT6gCAhZ; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1711398652; x=1742934652;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Iq/zFFFJ8V14KK9QW8av9KdokGOaG8yduusDkCXibtE=;
  b=BT6gCAhZukmK2OZgtr+mWfilylXZy4erl+yEIwbOu8UKUq+5/Ep2nw9Z
   QxfHtzt9em4/hk7uPNUlzrvawRuioNj7ZcqYUdy37JNXEIiORaqzEiEoA
   jDoAXW2iFjRwf6LhUCmuRIDnThVV/EM54wQ0XopS8ws0mh1YDoJyf77zn
   I=;
X-IronPort-AV: E=Sophos;i="6.07,154,1708387200"; 
   d="scan'208";a="647498815"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 20:30:50 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:3511]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.34.239:2525] with esmtp (Farcaster)
 id dd3acbfe-ff28-4911-9849-47268fb2da2d; Mon, 25 Mar 2024 20:30:49 +0000 (UTC)
X-Farcaster-Flow-ID: dd3acbfe-ff28-4911-9849-47268fb2da2d
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 25 Mar 2024 20:30:40 +0000
Received: from 88665a182662.ant.amazon.com (10.187.171.62) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 25 Mar 2024 20:30:38 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v5 net-next 15/15] selftest: af_unix: Test GC for SCM_RIGHTS.
Date: Mon, 25 Mar 2024 13:24:25 -0700
Message-ID: <20240325202425.60930-16-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240325202425.60930-1-kuniyu@amazon.com>
References: <20240325202425.60930-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWA004.ant.amazon.com (10.13.139.9) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

This patch adds test cases to verify the new GC.

We run each test for the following cases:

  * SOCK_DGRAM
  * SOCK_STREAM without embryo socket
  * SOCK_STREAM without embryo socket + MSG_OOB
  * SOCK_STREAM with embryo sockets
  * SOCK_STREAM with embryo sockets + MSG_OOB

Before and after running each test case, we ensure that there is
no AF_UNIX socket left in the netns by reading /proc/net/protocols.

We cannot use /proc/net/unix and UNIX_DIAG because the embryo socket
does not show up there.

Each test creates multiple sockets in an array.  We pass sockets in
the even index using the peer sockets in the odd index.

So, send_fd(0, 1) actually sends fd[0] to fd[2] via fd[0 + 1].

  Test 1 : A <-> A
  Test 2 : A <-> B
  Test 3 : A -> B -> C <- D
           ^.___|___.'    ^
                `---------'

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 tools/testing/selftests/net/.gitignore        |   1 +
 tools/testing/selftests/net/af_unix/Makefile  |   2 +-
 .../selftests/net/af_unix/scm_rights.c        | 286 ++++++++++++++++++
 3 files changed, 288 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/net/af_unix/scm_rights.c

diff --git a/tools/testing/selftests/net/.gitignore b/tools/testing/selftests/net/.gitignore
index 2f9d378edec3..d996a0ab0765 100644
--- a/tools/testing/selftests/net/.gitignore
+++ b/tools/testing/selftests/net/.gitignore
@@ -31,6 +31,7 @@ reuseport_dualstack
 rxtimestamp
 sctp_hello
 scm_pidfd
+scm_rights
 sk_bind_sendto_listen
 sk_connect_zero_addr
 socket
diff --git a/tools/testing/selftests/net/af_unix/Makefile b/tools/testing/selftests/net/af_unix/Makefile
index 221c387a7d7f..3b83c797650d 100644
--- a/tools/testing/selftests/net/af_unix/Makefile
+++ b/tools/testing/selftests/net/af_unix/Makefile
@@ -1,4 +1,4 @@
 CFLAGS += $(KHDR_INCLUDES)
-TEST_GEN_PROGS := diag_uid test_unix_oob unix_connect scm_pidfd
+TEST_GEN_PROGS := diag_uid test_unix_oob unix_connect scm_pidfd scm_rights
 
 include ../../lib.mk
diff --git a/tools/testing/selftests/net/af_unix/scm_rights.c b/tools/testing/selftests/net/af_unix/scm_rights.c
new file mode 100644
index 000000000000..bab606c9f1eb
--- /dev/null
+++ b/tools/testing/selftests/net/af_unix/scm_rights.c
@@ -0,0 +1,286 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright Amazon.com Inc. or its affiliates. */
+#define _GNU_SOURCE
+#include <sched.h>
+
+#include <stdio.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/types.h>
+#include <sys/socket.h>
+#include <sys/un.h>
+
+#include "../../kselftest_harness.h"
+
+FIXTURE(scm_rights)
+{
+	int fd[16];
+};
+
+FIXTURE_VARIANT(scm_rights)
+{
+	char name[16];
+	int type;
+	int flags;
+	bool test_listener;
+};
+
+FIXTURE_VARIANT_ADD(scm_rights, dgram)
+{
+	.name = "UNIX ",
+	.type = SOCK_DGRAM,
+	.flags = 0,
+	.test_listener = false,
+};
+
+FIXTURE_VARIANT_ADD(scm_rights, stream)
+{
+	.name = "UNIX-STREAM ",
+	.type = SOCK_STREAM,
+	.flags = 0,
+	.test_listener = false,
+};
+
+FIXTURE_VARIANT_ADD(scm_rights, stream_oob)
+{
+	.name = "UNIX-STREAM ",
+	.type = SOCK_STREAM,
+	.flags = MSG_OOB,
+	.test_listener = false,
+};
+
+FIXTURE_VARIANT_ADD(scm_rights, stream_listener)
+{
+	.name = "UNIX-STREAM ",
+	.type = SOCK_STREAM,
+	.flags = 0,
+	.test_listener = true,
+};
+
+FIXTURE_VARIANT_ADD(scm_rights, stream_listener_oob)
+{
+	.name = "UNIX-STREAM ",
+	.type = SOCK_STREAM,
+	.flags = MSG_OOB,
+	.test_listener = true,
+};
+
+static int count_sockets(struct __test_metadata *_metadata,
+			 const FIXTURE_VARIANT(scm_rights) *variant)
+{
+	int sockets = -1, len, ret;
+	char *line = NULL;
+	size_t unused;
+	FILE *f;
+
+	f = fopen("/proc/net/protocols", "r");
+	ASSERT_NE(NULL, f);
+
+	len = strlen(variant->name);
+
+	while (getline(&line, &unused, f) != -1) {
+		int unused2;
+
+		if (strncmp(line, variant->name, len))
+			continue;
+
+		ret = sscanf(line + len, "%d %d", &unused2, &sockets);
+		ASSERT_EQ(2, ret);
+
+		break;
+	}
+
+	free(line);
+
+	ret = fclose(f);
+	ASSERT_EQ(0, ret);
+
+	return sockets;
+}
+
+FIXTURE_SETUP(scm_rights)
+{
+	int ret;
+
+	ret = unshare(CLONE_NEWNET);
+	ASSERT_EQ(0, ret);
+
+	ret = count_sockets(_metadata, variant);
+	ASSERT_EQ(0, ret);
+}
+
+FIXTURE_TEARDOWN(scm_rights)
+{
+	int ret;
+
+	sleep(1);
+
+	ret = count_sockets(_metadata, variant);
+	ASSERT_EQ(0, ret);
+}
+
+static void create_listeners(struct __test_metadata *_metadata,
+			     FIXTURE_DATA(scm_rights) *self,
+			     int n)
+{
+	struct sockaddr_un addr = {
+		.sun_family = AF_UNIX,
+	};
+	socklen_t addrlen;
+	int i, ret;
+
+	for (i = 0; i < n * 2; i += 2) {
+		self->fd[i] = socket(AF_UNIX, SOCK_STREAM, 0);
+		ASSERT_LE(0, self->fd[i]);
+
+		addrlen = sizeof(addr.sun_family);
+		ret = bind(self->fd[i], (struct sockaddr *)&addr, addrlen);
+		ASSERT_EQ(0, ret);
+
+		ret = listen(self->fd[i], -1);
+		ASSERT_EQ(0, ret);
+
+		addrlen = sizeof(addr);
+		ret = getsockname(self->fd[i], (struct sockaddr *)&addr, &addrlen);
+		ASSERT_EQ(0, ret);
+
+		self->fd[i + 1] = socket(AF_UNIX, SOCK_STREAM, 0);
+		ASSERT_LE(0, self->fd[i + 1]);
+
+		ret = connect(self->fd[i + 1], (struct sockaddr *)&addr, addrlen);
+		ASSERT_EQ(0, ret);
+	}
+}
+
+static void create_socketpairs(struct __test_metadata *_metadata,
+			       FIXTURE_DATA(scm_rights) *self,
+			       const FIXTURE_VARIANT(scm_rights) *variant,
+			       int n)
+{
+	int i, ret;
+
+	ASSERT_GE(sizeof(self->fd) / sizeof(int), n);
+
+	for (i = 0; i < n * 2; i += 2) {
+		ret = socketpair(AF_UNIX, variant->type, 0, self->fd + i);
+		ASSERT_EQ(0, ret);
+	}
+}
+
+static void __create_sockets(struct __test_metadata *_metadata,
+			     FIXTURE_DATA(scm_rights) *self,
+			     const FIXTURE_VARIANT(scm_rights) *variant,
+			     int n)
+{
+	if (variant->test_listener)
+		create_listeners(_metadata, self, n);
+	else
+		create_socketpairs(_metadata, self, variant, n);
+}
+
+static void __close_sockets(struct __test_metadata *_metadata,
+			    FIXTURE_DATA(scm_rights) *self,
+			    int n)
+{
+	int i, ret;
+
+	ASSERT_GE(sizeof(self->fd) / sizeof(int), n);
+
+	for (i = 0; i < n * 2; i++) {
+		ret = close(self->fd[i]);
+		ASSERT_EQ(0, ret);
+	}
+}
+
+void __send_fd(struct __test_metadata *_metadata,
+	       const FIXTURE_DATA(scm_rights) *self,
+	       const FIXTURE_VARIANT(scm_rights) *variant,
+	       int inflight, int receiver)
+{
+#define MSG "nop"
+#define MSGLEN 3
+	struct {
+		struct cmsghdr cmsghdr;
+		int fd[2];
+	} cmsg = {
+		.cmsghdr = {
+			.cmsg_len = CMSG_LEN(sizeof(cmsg.fd)),
+			.cmsg_level = SOL_SOCKET,
+			.cmsg_type = SCM_RIGHTS,
+		},
+		.fd = {
+			self->fd[inflight * 2],
+			self->fd[inflight * 2],
+		},
+	};
+	struct iovec iov = {
+		.iov_base = MSG,
+		.iov_len = MSGLEN,
+	};
+	struct msghdr msg = {
+		.msg_name = NULL,
+		.msg_namelen = 0,
+		.msg_iov = &iov,
+		.msg_iovlen = 1,
+		.msg_control = &cmsg,
+		.msg_controllen = CMSG_SPACE(sizeof(cmsg.fd)),
+	};
+	int ret;
+
+	ret = sendmsg(self->fd[receiver * 2 + 1], &msg, variant->flags);
+	ASSERT_EQ(MSGLEN, ret);
+}
+
+#define create_sockets(n)					\
+	__create_sockets(_metadata, self, variant, n)
+#define close_sockets(n)					\
+	__close_sockets(_metadata, self, n)
+#define send_fd(inflight, receiver)				\
+	__send_fd(_metadata, self, variant, inflight, receiver)
+
+TEST_F(scm_rights, self_ref)
+{
+	create_sockets(2);
+
+	send_fd(0, 0);
+
+	send_fd(1, 1);
+
+	close_sockets(2);
+}
+
+TEST_F(scm_rights, triangle)
+{
+	create_sockets(6);
+
+	send_fd(0, 1);
+	send_fd(1, 2);
+	send_fd(2, 0);
+
+	send_fd(3, 4);
+	send_fd(4, 5);
+	send_fd(5, 3);
+
+	close_sockets(6);
+}
+
+TEST_F(scm_rights, cross_edge)
+{
+	create_sockets(8);
+
+	send_fd(0, 1);
+	send_fd(1, 2);
+	send_fd(2, 0);
+	send_fd(1, 3);
+	send_fd(3, 2);
+
+	send_fd(4, 5);
+	send_fd(5, 6);
+	send_fd(6, 4);
+	send_fd(5, 7);
+	send_fd(7, 6);
+
+	close_sockets(8);
+}
+
+TEST_HARNESS_MAIN
-- 
2.30.2


