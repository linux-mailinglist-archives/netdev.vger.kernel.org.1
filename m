Return-Path: <netdev+bounces-68772-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C5F847FD5
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 04:08:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 712DB1F2712C
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 03:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B3C7483;
	Sat,  3 Feb 2024 03:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="kI0Mf/DA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C37A79C0
	for <netdev@vger.kernel.org>; Sat,  3 Feb 2024 03:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706929673; cv=none; b=pkJSiceqJdIEbpUCFNPMRAvHoNB4CZA8bTisxPaQ7ngUWeBPMb7HQAow4G/BfsoIRdDml5rhrgjK//cgL3zjNGWK8WYHbsZbBIB6Tn/fxv+nbyg4i6h9bqZlB4X0lRN2Qzs44ajjHCZxCv7EdPi3b4SgUymXlDTIYm6WnhusXe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706929673; c=relaxed/simple;
	bh=efw5X8SfUgPcoSlFXosnOJdT+r8yEy5e5KY4lpxlLWk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dRlcrA2Vhw98c5qhwsffv370/lHUc/b2cVWtiRLRyBxAf+d4EzvBHtKL3wLKPH2G0dPCHg5QxEuKEFPagWhMY4dTKH/zRF/7ghDISrMxB+xTtj1S/NPGFc8fTqd89WkRlUdkkhO9Lo3QcehpcjXGw04dT0GaEeGBbfu83lq5RfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=kI0Mf/DA; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1706929672; x=1738465672;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=S44bcrviAt7c3Ci2JmDiDomjLiGDdcR5Jr8CWWo5IMU=;
  b=kI0Mf/DAHXYWVGcY/K0DQVumxg9xhTkCwvMzNQrvDz0MrW2aG8/Lyxqf
   XogFKoNW2d8lqkro00qlugbFZqee+5jpAZX+kI92Jf8n9yMD56F82kF0N
   e+R3HJYX5brGdyvO/l5mkPr3Hq327ms4Efy88wkFKjXq/qWMO90PeO7+T
   g=;
X-IronPort-AV: E=Sophos;i="6.05,238,1701129600"; 
   d="scan'208";a="635436111"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2024 03:07:51 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:45330]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.4.177:2525] with esmtp (Farcaster)
 id 2f66b581-12a0-4c1a-afc1-73e8a50cf011; Sat, 3 Feb 2024 03:07:50 +0000 (UTC)
X-Farcaster-Flow-ID: 2f66b581-12a0-4c1a-afc1-73e8a50cf011
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sat, 3 Feb 2024 03:07:50 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.101.14) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sat, 3 Feb 2024 03:07:47 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 16/16] selftest: af_unix: Test GC for SCM_RIGHTS.
Date: Fri, 2 Feb 2024 19:00:58 -0800
Message-ID: <20240203030058.60750-17-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240203030058.60750-1-kuniyu@amazon.com>
References: <20240203030058.60750-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC001.ant.amazon.com (10.13.139.241) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

This patch adds test cases to verify the new GC.

We run each test for 3 types of sockets.

  * SOCK_DGRAM
  * SOCK_STREAM with no embryo socket
  * SOCK_STREAM with embryo sockets

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
 .../selftests/net/af_unix/scm_rights.c        | 242 ++++++++++++++++++
 3 files changed, 244 insertions(+), 1 deletion(-)
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
index 000000000000..2f21a6e12cb8
--- /dev/null
+++ b/tools/testing/selftests/net/af_unix/scm_rights.c
@@ -0,0 +1,242 @@
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
+	int type;
+	char name[16];
+	bool test_listener;
+};
+
+FIXTURE_VARIANT_ADD(scm_rights, dgram)
+{
+	.type = SOCK_DGRAM,
+	.name = "UNIX ",
+	.test_listener = false,
+};
+
+FIXTURE_VARIANT_ADD(scm_rights, stream)
+{
+	.type = SOCK_STREAM,
+	.name = "UNIX-STREAM ",
+	.test_listener = false,
+};
+
+FIXTURE_VARIANT_ADD(scm_rights, stream_listener)
+{
+	.type = SOCK_STREAM,
+	.name = "UNIX-STREAM ",
+	.test_listener = true,
+};
+
+static int count_sockets(struct __test_metadata *_metadata,
+			 const FIXTURE_VARIANT(scm_rights) *variant)
+{
+	int sockets = -1, len, ret;
+	size_t unused;
+	char *line;
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
+	for (i = 0; i < n * 2; i++) {
+		ret = close(self->fd[i]);
+		ASSERT_EQ(0, ret);
+	}
+}
+
+void __send_fd(struct __test_metadata *_metadata,
+	       const FIXTURE_DATA(scm_rights) *self,
+	       int inflight, int receiver)
+{
+#define MSG "nop"
+#define MSGLEN 3
+	struct {
+		struct cmsghdr cmsghdr;
+		int fd;
+	} cmsg = {
+		.cmsghdr = {
+			.cmsg_len = CMSG_LEN(sizeof(cmsg.fd)),
+			.cmsg_level = SOL_SOCKET,
+			.cmsg_type = SCM_RIGHTS,
+		},
+		.fd = self->fd[inflight * 2],
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
+	ret = sendmsg(self->fd[receiver * 2 + 1], &msg, 0);
+	ASSERT_EQ(MSGLEN, ret);
+}
+
+#define create_sockets(n)				\
+	__create_sockets(_metadata, self, variant, n)
+#define close_sockets(n)				\
+	__close_sockets(_metadata, self, n)
+#define send_fd(inflight, receiver)			\
+	__send_fd(_metadata, self, inflight, receiver)
+
+TEST_F(scm_rights, self_ref)
+{
+	create_sockets(1);
+
+	send_fd(0, 0);
+
+	close_sockets(1);
+}
+
+TEST_F(scm_rights, triangle)
+{
+	create_sockets(3);
+
+	send_fd(0, 1);
+	send_fd(1, 2);
+	send_fd(2, 0);
+
+	close_sockets(3);
+}
+
+TEST_F(scm_rights, cross_edge)
+{
+	create_sockets(4);
+
+	send_fd(0, 1);
+	send_fd(1, 2);
+	send_fd(2, 0);
+	send_fd(1, 3);
+	send_fd(3, 2);
+
+	close_sockets(4);
+}
+
+TEST_HARNESS_MAIN
-- 
2.30.2


