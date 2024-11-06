Return-Path: <netdev+bounces-142191-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD6E89BDB77
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 02:52:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 775651F23E6F
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 01:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F161618C036;
	Wed,  6 Nov 2024 01:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ubjz7Z0R"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB4D18C01D
	for <netdev@vger.kernel.org>; Wed,  6 Nov 2024 01:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730857963; cv=none; b=pkziKW9L/87Pqpk6FrINeKPlEjt7RvDe9ssqPfxoUQ2Q0HsLJhqu5ExPzi3axra/r9yENYKvbpYcxSKIG4YLDWA96R+HRutFXt2hoQnEYVZyOK1qBb6lk8EQlIHg5mC/BQPSWVY3XQLN4vtDkLFMokiK4lpJXXE8NlDiw6a3JdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730857963; c=relaxed/simple;
	bh=eWka6g86lV+wcHW+J32xIlMGPgLxGMi8jJLOOJ7LLuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cOt3FCI+W/Sdq9zAc1yWZ3HyaN2jPaoZo2GEye9Y7UBF8HORd6IyvCyUnaH6k82tUYthzDm0xhRJHkR+v/ryqq4kI4E8c6h2OiYpjiVgA1nQfaSxMceChPrZ5OuxyXBFK2yvGpgB1GG/pAhg3HHLi2DZZJvmPyJQ4+EK5jS+kCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ubjz7Z0R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CFECC4CED3;
	Wed,  6 Nov 2024 01:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730857963;
	bh=eWka6g86lV+wcHW+J32xIlMGPgLxGMi8jJLOOJ7LLuA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ubjz7Z0R8NXTvTHMu4QVZzI4xr7obdw0V7YMN1GvT2QjfV6q13VnKhx3s/i5pkcc2
	 0kgfm2j7ooQ85fdV02krVvDPgtwkKLXVifU38pQBQbrYR5UzXaZVYE/g1LJI+6QtRz
	 LIX2Z5CXgZeJIBK3gqvU63+EsnCjXlc3l6oIlQGwEjiGt6Llc39WaCwwHvxEPTrr87
	 1wZdDBo+BSjAnjiw3WCnK2RvZQXX67hjaMI/WOSVI6sQlb1wryuc5k9sxdenX17IP0
	 SCyPZWjZ7QQQ8Ev76wsrGOkEMnwY1TTBAFwXG4By0tQSa14G/Y9zkRlvoPA0Senem3
	 bRtxij1y4EIKQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	johannes@sipsolutions.net,
	pablo@netfilter.org,
	Jakub Kicinski <kuba@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: [PATCH net v2 2/2] selftests: net: add a test for closing a netlink socket ith dump in progress
Date: Tue,  5 Nov 2024 17:52:35 -0800
Message-ID: <20241106015235.2458807-2-kuba@kernel.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106015235.2458807-1-kuba@kernel.org>
References: <20241106015235.2458807-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Close a socket with dump in progress. We need a dump which generates
enough info not to fit into a single skb. Policy dump fits the bill.

Use the trick discovered by syzbot for keeping a ref on the socket
longer than just close, with mqueue.

  TAP version 13
  1..3
  # Starting 3 tests from 1 test cases.
  #  RUN           global.test_sanity ...
  #            OK  global.test_sanity
  ok 1 global.test_sanity
  #  RUN           global.close_in_progress ...
  #            OK  global.close_in_progress
  ok 2 global.close_in_progress
  #  RUN           global.close_with_ref ...
  #            OK  global.close_with_ref
  ok 3 global.close_with_ref
  # PASSED: 3 / 3 tests passed.
  # Totals: pass:3 fail:0 xfail:0 xpass:0 skip:0 error:0

Note that this test is not expected to fail but rather crash
the kernel if we get the cleanup wrong.

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - fix the Makefile inclusion
v1: https://lore.kernel.org/20241105010347.2079981-2-kuba@kernel.org
---
 tools/testing/selftests/net/Makefile        |   1 +
 tools/testing/selftests/net/netlink-dumps.c | 110 ++++++++++++++++++++
 2 files changed, 111 insertions(+)
 create mode 100644 tools/testing/selftests/net/netlink-dumps.c

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 649f1fe0dc46..5e86f7a51b43 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -78,6 +78,7 @@ TEST_PROGS += test_vxlan_vnifiltering.sh
 TEST_GEN_FILES += io_uring_zerocopy_tx
 TEST_PROGS += io_uring_zerocopy_tx.sh
 TEST_GEN_FILES += bind_bhash
+TEST_GEN_PROGS += netlink-dumps
 TEST_GEN_PROGS += sk_bind_sendto_listen
 TEST_GEN_PROGS += sk_connect_zero_addr
 TEST_GEN_PROGS += sk_so_peek_off
diff --git a/tools/testing/selftests/net/netlink-dumps.c b/tools/testing/selftests/net/netlink-dumps.c
new file mode 100644
index 000000000000..7ee6dcd334df
--- /dev/null
+++ b/tools/testing/selftests/net/netlink-dumps.c
@@ -0,0 +1,110 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define _GNU_SOURCE
+
+#include <fcntl.h>
+#include <stdio.h>
+#include <string.h>
+#include <sys/socket.h>
+#include <sys/stat.h>
+#include <sys/syscall.h>
+#include <sys/types.h>
+#include <unistd.h>
+
+#include <linux/genetlink.h>
+#include <linux/netlink.h>
+#include <linux/mqueue.h>
+
+#include "../kselftest_harness.h"
+
+static const struct {
+	struct nlmsghdr nlhdr;
+	struct genlmsghdr genlhdr;
+	struct nlattr ahdr;
+	__u16 val;
+	__u16 pad;
+} dump_policies = {
+	.nlhdr = {
+		.nlmsg_len	= sizeof(dump_policies),
+		.nlmsg_type	= GENL_ID_CTRL,
+		.nlmsg_flags	= NLM_F_REQUEST | NLM_F_ACK | NLM_F_DUMP,
+		.nlmsg_seq	= 1,
+	},
+	.genlhdr = {
+		.cmd		= CTRL_CMD_GETPOLICY,
+		.version	= 2,
+	},
+	.ahdr = {
+		.nla_len	= 6,
+		.nla_type	= CTRL_ATTR_FAMILY_ID,
+	},
+	.val = GENL_ID_CTRL,
+	.pad = 0,
+};
+
+// Sanity check for the test itself, make sure the dump doesn't fit in one msg
+TEST(test_sanity)
+{
+	int netlink_sock;
+	char buf[8192];
+	ssize_t n;
+
+	netlink_sock = socket(AF_NETLINK, SOCK_RAW, NETLINK_GENERIC);
+	ASSERT_GE(netlink_sock, 0);
+
+	n = send(netlink_sock, &dump_policies, sizeof(dump_policies), 0);
+	ASSERT_EQ(n, sizeof(dump_policies));
+
+	n = recv(netlink_sock, buf, sizeof(buf), MSG_DONTWAIT);
+	ASSERT_GE(n, sizeof(struct nlmsghdr));
+
+	n = recv(netlink_sock, buf, sizeof(buf), MSG_DONTWAIT);
+	ASSERT_GE(n, sizeof(struct nlmsghdr));
+
+	close(netlink_sock);
+}
+
+TEST(close_in_progress)
+{
+	int netlink_sock;
+	ssize_t n;
+
+	netlink_sock = socket(AF_NETLINK, SOCK_RAW, NETLINK_GENERIC);
+	ASSERT_GE(netlink_sock, 0);
+
+	n = send(netlink_sock, &dump_policies, sizeof(dump_policies), 0);
+	ASSERT_EQ(n, sizeof(dump_policies));
+
+	close(netlink_sock);
+}
+
+TEST(close_with_ref)
+{
+	char cookie[NOTIFY_COOKIE_LEN] = {};
+	int netlink_sock, mq_fd;
+	struct sigevent sigev;
+	ssize_t n;
+
+	netlink_sock = socket(AF_NETLINK, SOCK_RAW, NETLINK_GENERIC);
+	ASSERT_GE(netlink_sock, 0);
+
+	n = send(netlink_sock, &dump_policies, sizeof(dump_policies), 0);
+	ASSERT_EQ(n, sizeof(dump_policies));
+
+	mq_fd = syscall(__NR_mq_open, "sed", O_CREAT | O_WRONLY, 0600, 0);
+	ASSERT_GE(mq_fd, 0);
+
+	memset(&sigev, 0, sizeof(sigev));
+	sigev.sigev_notify		= SIGEV_THREAD;
+	sigev.sigev_value.sival_ptr	= cookie;
+	sigev.sigev_signo		= netlink_sock;
+
+	syscall(__NR_mq_notify, mq_fd, &sigev);
+
+	close(netlink_sock);
+
+	// give mqueue time to fire
+	usleep(100 * 1000);
+}
+
+TEST_HARNESS_MAIN
-- 
2.47.0


