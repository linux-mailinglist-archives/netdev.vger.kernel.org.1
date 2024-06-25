Return-Path: <netdev+bounces-106309-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4EBB915BBB
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 03:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 144381C213C8
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 01:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94CD417C73;
	Tue, 25 Jun 2024 01:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ntBOmGjQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61BC17BA3
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 01:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719279475; cv=none; b=Uyt3a1orft6sPmQnloB9L5I1dBdmSYhUAaODck9OdAMWvEo933geds9/1IWMFDgi3UUy1oSOJ4hACBRjvsc0L59wa1XnbbObUBADc/gJdGu+LBgYyTLRkx91GXM2NnJMDGQIhFo3uWw7/CgEJDYcHpw9yuYxG+jHU3x9vAs61zg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719279475; c=relaxed/simple;
	bh=Ilfn+CF79ZiOEMP5ze7KHdgfvoyyfbreh9wdDht+G54=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SW87644hRv4hrLyl7hRxk8pyBOFRxZui1IffhOrB9cqO3M6OFfR4ipAxVK10UQvGBucNjhfkQpbsK+qKhvTlUSoQv1dzT3dC12C5XzL7Q2N3OL7AunKxQ82vleVOvnvF6/ZTtH+xUwJTtdJ7hEAe4s8ligprEXP0TU6t8w+LkJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=ntBOmGjQ; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1719279473; x=1750815473;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ALPSD15Tq0bOA/dM19kQtlfJUVARJ7KQiWS9jOqRs/M=;
  b=ntBOmGjQnBqcQuBmYvBjDarWddKse+Q91fx+Dqxqkmi2HUDKteegVWEy
   G6HJiAcwJxNCu7qClC4EGbHYbxNQjQ0H2iP2ODGfIJ8eQEKEV/huniWwj
   vr++2o9NIsqPeaxB7lJLEgfCywYyyDfoAuCURXHGQa9SW9DaaCWypwMZx
   A=;
X-IronPort-AV: E=Sophos;i="6.08,263,1712620800"; 
   d="scan'208";a="405471002"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2024 01:37:50 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.7.35:6039]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.55.158:2525] with esmtp (Farcaster)
 id da2522f6-20ec-47a2-81a1-ee405d1fe54e; Tue, 25 Jun 2024 01:37:50 +0000 (UTC)
X-Farcaster-Flow-ID: da2522f6-20ec-47a2-81a1-ee405d1fe54e
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 25 Jun 2024 01:37:49 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.42) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 25 Jun 2024 01:37:47 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Rao Shoaib <Rao.Shoaib@oracle.com>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net 02/11] selftest: af_unix: Add msg_oob.c.
Date: Mon, 24 Jun 2024 18:36:36 -0700
Message-ID: <20240625013645.45034-3-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240625013645.45034-1-kuniyu@amazon.com>
References: <20240625013645.45034-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWA004.ant.amazon.com (10.13.139.76) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

AF_UNIX's MSG_OOB functionality lacked thorough testing, and we found
some bizarre behaviour.

The new selftest validates every MSG_OOB operation against TCP as a
reference implementation.

This patch adds only a few tests with basic send() and recv() that
do not fail.

The following patches will add more test cases for SO_OOBINLINE, SIGURG,
EPOLLPRI, and SIOCATMARK.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 tools/testing/selftests/net/af_unix/Makefile  |   2 +-
 tools/testing/selftests/net/af_unix/msg_oob.c | 220 ++++++++++++++++++
 2 files changed, 221 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/net/af_unix/msg_oob.c

diff --git a/tools/testing/selftests/net/af_unix/Makefile b/tools/testing/selftests/net/af_unix/Makefile
index a25845251eed..50584479540b 100644
--- a/tools/testing/selftests/net/af_unix/Makefile
+++ b/tools/testing/selftests/net/af_unix/Makefile
@@ -1,4 +1,4 @@
 CFLAGS += $(KHDR_INCLUDES)
-TEST_GEN_PROGS := diag_uid scm_pidfd scm_rights unix_connect
+TEST_GEN_PROGS := diag_uid msg_oob scm_pidfd scm_rights unix_connect
 
 include ../../lib.mk
diff --git a/tools/testing/selftests/net/af_unix/msg_oob.c b/tools/testing/selftests/net/af_unix/msg_oob.c
new file mode 100644
index 000000000000..d427d39d0806
--- /dev/null
+++ b/tools/testing/selftests/net/af_unix/msg_oob.c
@@ -0,0 +1,220 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright Amazon.com Inc. or its affiliates. */
+
+#include <fcntl.h>
+#include <string.h>
+#include <unistd.h>
+
+#include <netinet/in.h>
+#include <sys/socket.h>
+
+#include "../../kselftest_harness.h"
+
+#define BUF_SZ	32
+
+FIXTURE(msg_oob)
+{
+	int fd[4];		/* 0: AF_UNIX sender
+				 * 1: AF_UNIX receiver
+				 * 2: TCP sender
+				 * 3: TCP receiver
+				 */
+};
+
+static void create_unix_socketpair(struct __test_metadata *_metadata,
+				   FIXTURE_DATA(msg_oob) *self)
+{
+	int ret;
+
+	ret = socketpair(AF_UNIX, SOCK_STREAM | SOCK_NONBLOCK, 0, self->fd);
+	ASSERT_EQ(ret, 0);
+}
+
+static void create_tcp_socketpair(struct __test_metadata *_metadata,
+				  FIXTURE_DATA(msg_oob) *self)
+{
+	struct sockaddr_in addr;
+	socklen_t addrlen;
+	int listen_fd;
+	int ret;
+
+	listen_fd = socket(AF_INET, SOCK_STREAM, 0);
+	ASSERT_GE(listen_fd, 0);
+
+	ret = listen(listen_fd, -1);
+	ASSERT_EQ(ret, 0);
+
+	addrlen = sizeof(addr);
+	ret = getsockname(listen_fd, (struct sockaddr *)&addr, &addrlen);
+	ASSERT_EQ(ret, 0);
+
+	self->fd[2] = socket(AF_INET, SOCK_STREAM, 0);
+	ASSERT_GE(self->fd[2], 0);
+
+	ret = connect(self->fd[2], (struct sockaddr *)&addr, addrlen);
+	ASSERT_EQ(ret, 0);
+
+	self->fd[3] = accept(listen_fd, (struct sockaddr *)&addr, &addrlen);
+	ASSERT_GE(self->fd[3], 0);
+
+	ret = fcntl(self->fd[3], F_SETFL, O_NONBLOCK);
+	ASSERT_EQ(ret, 0);
+}
+
+static void close_sockets(FIXTURE_DATA(msg_oob) *self)
+{
+	int i;
+
+	for (i = 0; i < 4; i++)
+		close(self->fd[i]);
+}
+
+FIXTURE_SETUP(msg_oob)
+{
+	create_unix_socketpair(_metadata, self);
+	create_tcp_socketpair(_metadata, self);
+}
+
+FIXTURE_TEARDOWN(msg_oob)
+{
+	close_sockets(self);
+}
+
+static void __sendpair(struct __test_metadata *_metadata,
+		       FIXTURE_DATA(msg_oob) *self,
+		       const void *buf, size_t len, int flags)
+{
+	int i, ret[2];
+
+	for (i = 0; i < 2; i++)
+		ret[i] = send(self->fd[i * 2], buf, len, flags);
+
+	ASSERT_EQ(ret[0], len);
+	ASSERT_EQ(ret[0], ret[1]);
+}
+
+static void __recvpair(struct __test_metadata *_metadata,
+		       FIXTURE_DATA(msg_oob) *self,
+		       const void *expected_buf, int expected_len,
+		       int buf_len, int flags)
+{
+	int i, ret[2], recv_errno[2], expected_errno = 0;
+	char recv_buf[2][BUF_SZ] = {};
+
+	ASSERT_GE(BUF_SZ, buf_len);
+
+	errno = 0;
+
+	for (i = 0; i < 2; i++) {
+		ret[i] = recv(self->fd[i * 2 + 1], recv_buf[i], buf_len, flags);
+		recv_errno[i] = errno;
+	}
+
+	if (expected_len < 0) {
+		expected_errno = -expected_len;
+		expected_len = -1;
+	}
+
+	if (ret[0] != expected_len || recv_errno[0] != expected_errno) {
+		TH_LOG("AF_UNIX :%s", ret[0] < 0 ? strerror(recv_errno[0]) : recv_buf[0]);
+		TH_LOG("Expected:%s", expected_errno ? strerror(expected_errno) : expected_buf);
+
+		ASSERT_EQ(ret[0], expected_len);
+		ASSERT_EQ(recv_errno[0], expected_errno);
+	}
+
+	if (ret[0] != ret[1] || recv_errno[0] != recv_errno[1]) {
+		TH_LOG("AF_UNIX :%s", ret[0] < 0 ? strerror(recv_errno[0]) : recv_buf[0]);
+		TH_LOG("TCP     :%s", ret[1] < 0 ? strerror(recv_errno[1]) : recv_buf[1]);
+
+		ASSERT_EQ(ret[0], ret[1]);
+		ASSERT_EQ(recv_errno[0], recv_errno[1]);
+	}
+
+	if (expected_len >= 0) {
+		int cmp;
+
+		cmp = strncmp(expected_buf, recv_buf[0], expected_len);
+		if (cmp) {
+			TH_LOG("AF_UNIX :%s", ret[0] < 0 ? strerror(recv_errno[0]) : recv_buf[0]);
+			TH_LOG("Expected:%s", expected_errno ? strerror(expected_errno) : expected_buf);
+
+			ASSERT_EQ(cmp, 0);
+		}
+
+		cmp = strncmp(recv_buf[0], recv_buf[1], expected_len);
+		if (cmp) {
+			TH_LOG("AF_UNIX :%s", ret[0] < 0 ? strerror(recv_errno[0]) : recv_buf[0]);
+			TH_LOG("TCP     :%s", ret[1] < 0 ? strerror(recv_errno[1]) : recv_buf[1]);
+
+			ASSERT_EQ(cmp, 0);
+		}
+	}
+}
+
+#define sendpair(buf, len, flags)					\
+	__sendpair(_metadata, self, buf, len, flags)
+
+#define recvpair(expected_buf, expected_len, buf_len, flags)		\
+	__recvpair(_metadata, self,					\
+		   expected_buf, expected_len, buf_len, flags)
+
+TEST_F(msg_oob, non_oob)
+{
+	sendpair("x", 1, 0);
+
+	recvpair("", -EINVAL, 1, MSG_OOB);
+}
+
+TEST_F(msg_oob, oob)
+{
+	sendpair("x", 1, MSG_OOB);
+
+	recvpair("x", 1, 1, MSG_OOB);
+}
+
+TEST_F(msg_oob, oob_drop)
+{
+	sendpair("x", 1, MSG_OOB);
+
+	recvpair("", -EAGAIN, 1, 0);		/* Drop OOB. */
+	recvpair("", -EINVAL, 1, MSG_OOB);
+}
+
+TEST_F(msg_oob, oob_ahead)
+{
+	sendpair("hello", 5, MSG_OOB);
+
+	recvpair("o", 1, 1, MSG_OOB);
+	recvpair("hell", 4, 4, 0);
+}
+
+TEST_F(msg_oob, oob_break)
+{
+	sendpair("hello", 5, MSG_OOB);
+
+	recvpair("hell", 4, 5, 0);		/* Break at OOB even with enough buffer. */
+	recvpair("o", 1, 1, MSG_OOB);
+}
+
+TEST_F(msg_oob, oob_ahead_break)
+{
+	sendpair("hello", 5, MSG_OOB);
+	sendpair("world", 5, 0);
+
+	recvpair("o", 1, 1, MSG_OOB);
+	recvpair("hell", 4, 9, 0);		/* Break at OOB even after it's recv()ed. */
+	recvpair("world", 5, 5, 0);
+}
+
+TEST_F(msg_oob, oob_break_drop)
+{
+	sendpair("hello", 5, MSG_OOB);
+	sendpair("world", 5, 0);
+
+	recvpair("hell", 4, 10, 0);		/* Break at OOB even with enough buffer. */
+	recvpair("world", 5, 10, 0);		/* Drop OOB and recv() the next skb. */
+	recvpair("", -EINVAL, 1, MSG_OOB);
+}
+
+TEST_HARNESS_MAIN
-- 
2.30.2


