Return-Path: <netdev+bounces-222776-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CE5DB55FFE
	for <lists+netdev@lfdr.de>; Sat, 13 Sep 2025 12:09:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B81B8583379
	for <lists+netdev@lfdr.de>; Sat, 13 Sep 2025 10:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95AE12EB87B;
	Sat, 13 Sep 2025 10:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="ZWrg3Haf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6576384A3E
	for <netdev@vger.kernel.org>; Sat, 13 Sep 2025 10:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757758183; cv=none; b=YNXTIHY5aHlGMfVjABjYU9mgPfJ/dFztindBFS/jkIyB1ddqZPKRUfFXHOh0z4bbWD8XoYCig5UCiT5/1rzkZ3JemKICwM/tjvDE7XKyoqjbKzOUWke4ng00JaXdDKsoPlbrf356rOKhykkGrsDDa0mgV3gE5BjexyE3+vlZESQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757758183; c=relaxed/simple;
	bh=XseRz49x06GL+f9kevxE2MPfOIXpM3I/ZW5WqcW40FU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V0YUCVhaWP+bIOTsfkZm1CFuKQx+t9sjfstPDsGSaMrXvzm5Zu4zyiWW7nJRgbVq597U12DWUrINq9U7TPEB5WTwLl0J31Li/oygic8QaaJCj2p6mbv/D/449ARdPCPFicTwI1sI2/dTUkoJ6WECZ/ld76NnzoldFOAgrv1zKic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=ZWrg3Haf; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-62ee43b5e5bso2529967a12.1
        for <netdev@vger.kernel.org>; Sat, 13 Sep 2025 03:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1757758180; x=1758362980; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5UDzo4tCJfwk/VIWQ7mhz/9h6Wr9YvMdDJ0pHVa/MFM=;
        b=ZWrg3HafW6X9uBA1GNyjI7rm6zcNIK8ijVUEYVlW6Bz4mxe/EBTODjGggpZfboI23H
         ecjqIISqR/OdqFiuuMWWgKiPtKFCIc3n+MZDOSX6OjtGwHoPzu3DU5BhouBh80+R6Smu
         E9UbY1yJUrvzc/jaTBGb3ahsef3oP+fJk5qVDJ+BYTdSFRKEetsaCxLWybHqM/wEnJdD
         lQAdelkqhv3770XlsGKcFnfvdTpzhpm60enJ2m21pAaLwM1jinQVxvzrpRQm+5nG7rE9
         6+lRmpvc6WmqeuBatmurojrMJdXlqxyvAzuSUO+SPVAjflE2Uv91Lug6s1Ut14ebKnum
         qF5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757758180; x=1758362980;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5UDzo4tCJfwk/VIWQ7mhz/9h6Wr9YvMdDJ0pHVa/MFM=;
        b=o7f5c036xfozofjeFh+xbqaoKN0qA5wghXM8zXQ6+N0w2+PKv3D6x53KkMtBFAZZRq
         djX8ejcuAOlHfSTOvGAkOtVA+SEd5oyNDpzOr+yAwRMN856lfe6rMfR+vIApd/Q26W9I
         cee3xVuXsG9QkBEsIjIxaAAMtr3erFCrJb9ZSjG0Ov7EsLyxO8PnMwzMTej1x34DiXSv
         Ku2fVWmnZvA87w+hkL4ZJ5kRtgpYSvLyVzps0kw3fm54UboF4MGfAn8/75aKjsNrV+jF
         Y8GntDKYvuOXicoB05/ATGYOzmYjqCo5QEJAWLDyz12xCa1W1bazFy3BFLJogougzsbl
         SzsA==
X-Gm-Message-State: AOJu0Yz6v3FpOswRg9/x1Ez0WtR34SSMFZylQsJ5TgjCJEeUE3/+wUzk
	XUzJVt8Fd6c833sllUB45mSY1BU6cuDkgY78yNqwtv4+ZtLtTwaE93y4L7+yOGuw43w=
X-Gm-Gg: ASbGncvHgYyWnXK7235rNIbKIgCdOIR462ZVX72VVMM6WCrHDKci+RTj99tmAbqG11j
	55Vm/G8decEmzJmodfA/bJY+YLo8uya+X7PmJ//XkmFeC7RAFZTNl/GeTzU7e4tPKOxR+19llnB
	0noBdybokAnm3g5Z40jQ3C438bz9g2y737qV9Mh8aqdkpgvBZMOqTW1IJpoetCK3fSjRWk+v3qn
	6smk5Xnobv3rkUdG3SLmS5SP8WCzUOlF6prNjtTclu/XdttClQsbjDGDJu6PiGE0iHnItWsUCJC
	IC5ELRMMTRUpFYbWLxTZ3OnFbn4exli8VCT3R5LSst0rAW1YYhLfSsJO/xdXQilBhARVAQrbUPa
	zeHnmE2oxxPFRaMxnBZbgNHUE32y/MCgRPgnkeeKLaBm9eE0oy2hMFrL0dSsxswmBu2aP8RE/QU
	M+V7U=
X-Google-Smtp-Source: AGHT+IFlU2UvD6MpCJs97AE39ERULlHf8m7BZQkRAwqt9M+0inKC1NgvFhBdGbEKP4p3LhjXFuBI6g==
X-Received: by 2002:a05:6402:40c5:b0:626:f217:e746 with SMTP id 4fb4d7f45d1cf-62ed82f1169mr6056272a12.26.1757758179591;
        Sat, 13 Sep 2025 03:09:39 -0700 (PDT)
Received: from cloudflare.com (79.184.140.27.ipv4.supernova.orange.pl. [79.184.140.27])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62ec833c4f0sm4617700a12.8.2025.09.13.03.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Sep 2025 03:09:38 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Sat, 13 Sep 2025 12:09:29 +0200
Subject: [PATCH net-next v4 2/2] selftests/net: Test tcp port reuse after
 unbinding a socket
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250913-update-bind-bucket-state-on-unhash-v4-2-33a567594df7@cloudflare.com>
References: <20250913-update-bind-bucket-state-on-unhash-v4-0-33a567594df7@cloudflare.com>
In-Reply-To: <20250913-update-bind-bucket-state-on-unhash-v4-0-33a567594df7@cloudflare.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Kuniyuki Iwashima <kuniyu@google.com>, Neal Cardwell <ncardwell@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, kernel-team@cloudflare.com, 
 Lee Valentine <lvalentine@cloudflare.com>
X-Mailer: b4 0.15-dev-07fe9

Exercise the scenario described in detail in the cover letter:

  1) socket A: connect() from ephemeral port X
  2) socket B: explicitly bind() to port X
  3) check that port X is now excluded from ephemeral ports
  4) close socket B to release the port bind
  5) socket C: connect() from ephemeral port X

As well as a corner case to test that the connect-bind flag is cleared:

  1) connect() from ephemeral port X
  2) disconnect the socket with connect(AF_UNSPEC)
  3) bind() it explicitly to port X
  4) check that port X is now excluded from ephemeral ports

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 tools/testing/selftests/net/Makefile         |   1 +
 tools/testing/selftests/net/tcp_port_share.c | 258 +++++++++++++++++++++++++++
 2 files changed, 259 insertions(+)

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index ae1afe75bc86..5d9d96515c4a 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -122,6 +122,7 @@ TEST_PROGS += broadcast_pmtu.sh
 TEST_PROGS += ipv6_force_forwarding.sh
 TEST_GEN_PROGS += ipv6_fragmentation
 TEST_PROGS += route_hint.sh
+TEST_GEN_PROGS += tcp_port_share
 
 # YNL files, must be before "include ..lib.mk"
 YNL_GEN_FILES := busy_poller
diff --git a/tools/testing/selftests/net/tcp_port_share.c b/tools/testing/selftests/net/tcp_port_share.c
new file mode 100644
index 000000000000..4c39d599dfce
--- /dev/null
+++ b/tools/testing/selftests/net/tcp_port_share.c
@@ -0,0 +1,258 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+// Copyright (c) 2025 Cloudflare, Inc.
+
+/* Tests for TCP port sharing (bind bucket reuse). */
+
+#include <arpa/inet.h>
+#include <net/if.h>
+#include <sys/ioctl.h>
+#include <fcntl.h>
+#include <sched.h>
+#include <stdlib.h>
+
+#include "../kselftest_harness.h"
+
+#define DST_PORT 30000
+#define SRC_PORT 40000
+
+struct sockaddr_inet {
+	union {
+		struct sockaddr_storage ss;
+		struct sockaddr_in6 v6;
+		struct sockaddr_in v4;
+		struct sockaddr sa;
+	};
+	socklen_t len;
+	char str[INET6_ADDRSTRLEN + __builtin_strlen("[]:65535") + 1];
+};
+
+const int one = 1;
+
+static int disconnect(int fd)
+{
+	return connect(fd, &(struct sockaddr){ AF_UNSPEC }, sizeof(struct sockaddr));
+}
+
+static int getsockname_port(int fd)
+{
+	struct sockaddr_inet addr = {};
+	int err;
+
+	addr.len = sizeof(addr);
+	err = getsockname(fd, &addr.sa, &addr.len);
+	if (err)
+		return -1;
+
+	switch (addr.sa.sa_family) {
+	case AF_INET:
+		return ntohs(addr.v4.sin_port);
+	case AF_INET6:
+		return ntohs(addr.v6.sin6_port);
+	default:
+		errno = EAFNOSUPPORT;
+		return -1;
+	}
+}
+
+static void make_inet_addr(int af, const char *ip, __u16 port,
+			   struct sockaddr_inet *addr)
+{
+	const char *fmt = "";
+
+	memset(addr, 0, sizeof(*addr));
+
+	switch (af) {
+	case AF_INET:
+		addr->len = sizeof(addr->v4);
+		addr->v4.sin_family = af;
+		addr->v4.sin_port = htons(port);
+		inet_pton(af, ip, &addr->v4.sin_addr);
+		fmt = "%s:%hu";
+		break;
+	case AF_INET6:
+		addr->len = sizeof(addr->v6);
+		addr->v6.sin6_family = af;
+		addr->v6.sin6_port = htons(port);
+		inet_pton(af, ip, &addr->v6.sin6_addr);
+		fmt = "[%s]:%hu";
+		break;
+	}
+
+	snprintf(addr->str, sizeof(addr->str), fmt, ip, port);
+}
+
+FIXTURE(tcp_port_share) {};
+
+FIXTURE_VARIANT(tcp_port_share) {
+	int domain;
+	/* IP to listen on and connect to */
+	const char *dst_ip;
+	/* Primary IP to connect from */
+	const char *src1_ip;
+	/* Secondary IP to connect from */
+	const char *src2_ip;
+	/* IP to bind to in order to block the source port */
+	const char *bind_ip;
+};
+
+FIXTURE_VARIANT_ADD(tcp_port_share, ipv4) {
+	.domain = AF_INET,
+	.dst_ip = "127.0.0.1",
+	.src1_ip = "127.1.1.1",
+	.src2_ip = "127.2.2.2",
+	.bind_ip = "127.3.3.3",
+};
+
+FIXTURE_VARIANT_ADD(tcp_port_share, ipv6) {
+	.domain = AF_INET6,
+	.dst_ip = "::1",
+	.src1_ip = "2001:db8::1",
+	.src2_ip = "2001:db8::2",
+	.bind_ip = "2001:db8::3",
+};
+
+FIXTURE_SETUP(tcp_port_share)
+{
+	int sc;
+
+	ASSERT_EQ(unshare(CLONE_NEWNET), 0);
+	ASSERT_EQ(system("ip link set dev lo up"), 0);
+	ASSERT_EQ(system("ip addr add dev lo 2001:db8::1/32 nodad"), 0);
+	ASSERT_EQ(system("ip addr add dev lo 2001:db8::2/32 nodad"), 0);
+	ASSERT_EQ(system("ip addr add dev lo 2001:db8::3/32 nodad"), 0);
+
+	sc = open("/proc/sys/net/ipv4/ip_local_port_range", O_WRONLY);
+	ASSERT_GE(sc, 0);
+	ASSERT_GT(dprintf(sc, "%hu %hu\n", SRC_PORT, SRC_PORT), 0);
+	ASSERT_EQ(close(sc), 0);
+}
+
+FIXTURE_TEARDOWN(tcp_port_share) {}
+
+/* Verify that an ephemeral port becomes available again after the socket
+ * bound to it and blocking it from reuse is closed.
+ */
+TEST_F(tcp_port_share, can_reuse_port_after_bind_and_close)
+{
+	const typeof(variant) v = variant;
+	struct sockaddr_inet addr;
+	int c1, c2, ln, pb;
+
+	/* Listen on <dst_ip>:<DST_PORT> */
+	ln = socket(v->domain, SOCK_STREAM, 0);
+	ASSERT_GE(ln, 0) TH_LOG("socket(): %m");
+	ASSERT_EQ(setsockopt(ln, SOL_SOCKET, SO_REUSEADDR, &one, sizeof(one)), 0);
+
+	make_inet_addr(v->domain, v->dst_ip, DST_PORT, &addr);
+	ASSERT_EQ(bind(ln, &addr.sa, addr.len), 0) TH_LOG("bind(%s): %m", addr.str);
+	ASSERT_EQ(listen(ln, 2), 0);
+
+	/* Connect from <src1_ip>:<SRC_PORT> */
+	c1 = socket(v->domain, SOCK_STREAM, 0);
+	ASSERT_GE(c1, 0) TH_LOG("socket(): %m");
+	ASSERT_EQ(setsockopt(c1, SOL_IP, IP_BIND_ADDRESS_NO_PORT, &one, sizeof(one)), 0);
+
+	make_inet_addr(v->domain, v->src1_ip, 0, &addr);
+	ASSERT_EQ(bind(c1, &addr.sa, addr.len), 0) TH_LOG("bind(%s): %m", addr.str);
+
+	make_inet_addr(v->domain, v->dst_ip, DST_PORT, &addr);
+	ASSERT_EQ(connect(c1, &addr.sa, addr.len), 0) TH_LOG("connect(%s): %m", addr.str);
+	ASSERT_EQ(getsockname_port(c1), SRC_PORT);
+
+	/* Bind to <bind_ip>:<SRC_PORT>. Block the port from reuse. */
+	pb = socket(v->domain, SOCK_STREAM, 0);
+	ASSERT_GE(pb, 0) TH_LOG("socket(): %m");
+	ASSERT_EQ(setsockopt(pb, SOL_SOCKET, SO_REUSEADDR, &one, sizeof(one)), 0);
+
+	make_inet_addr(v->domain, v->bind_ip, SRC_PORT, &addr);
+	ASSERT_EQ(bind(pb, &addr.sa, addr.len), 0) TH_LOG("bind(%s): %m", addr.str);
+
+	/* Try to connect from <src2_ip>:<SRC_PORT>. Expect failure. */
+	c2 = socket(v->domain, SOCK_STREAM, 0);
+	ASSERT_GE(c2, 0) TH_LOG("socket");
+	ASSERT_EQ(setsockopt(c2, SOL_IP, IP_BIND_ADDRESS_NO_PORT, &one, sizeof(one)), 0);
+
+	make_inet_addr(v->domain, v->src2_ip, 0, &addr);
+	ASSERT_EQ(bind(c2, &addr.sa, addr.len), 0) TH_LOG("bind(%s): %m", addr.str);
+
+	make_inet_addr(v->domain, v->dst_ip, DST_PORT, &addr);
+	ASSERT_EQ(connect(c2, &addr.sa, addr.len), -1) TH_LOG("connect(%s)", addr.str);
+	ASSERT_EQ(errno, EADDRNOTAVAIL) TH_LOG("%m");
+
+	/* Unbind from <bind_ip>:<SRC_PORT>. Unblock the port for reuse. */
+	ASSERT_EQ(close(pb), 0);
+
+	/* Connect again from <src2_ip>:<SRC_PORT> */
+	EXPECT_EQ(connect(c2, &addr.sa, addr.len), 0) TH_LOG("connect(%s): %m", addr.str);
+	EXPECT_EQ(getsockname_port(c2), SRC_PORT);
+
+	ASSERT_EQ(close(c2), 0);
+	ASSERT_EQ(close(c1), 0);
+	ASSERT_EQ(close(ln), 0);
+}
+
+/* Verify that a socket auto-bound during connect() blocks port reuse after
+ * disconnect (connect(AF_UNSPEC)) followed by an explicit port bind().
+ */
+TEST_F(tcp_port_share, port_block_after_disconnect)
+{
+	const typeof(variant) v = variant;
+	struct sockaddr_inet addr;
+	int c1, c2, ln, pb;
+
+	/* Listen on <dst_ip>:<DST_PORT> */
+	ln = socket(v->domain, SOCK_STREAM, 0);
+	ASSERT_GE(ln, 0) TH_LOG("socket(): %m");
+	ASSERT_EQ(setsockopt(ln, SOL_SOCKET, SO_REUSEADDR, &one, sizeof(one)), 0);
+
+	make_inet_addr(v->domain, v->dst_ip, DST_PORT, &addr);
+	ASSERT_EQ(bind(ln, &addr.sa, addr.len), 0) TH_LOG("bind(%s): %m", addr.str);
+	ASSERT_EQ(listen(ln, 2), 0);
+
+	/* Connect from <src1_ip>:<SRC_PORT> */
+	c1 = socket(v->domain, SOCK_STREAM, 0);
+	ASSERT_GE(c1, 0) TH_LOG("socket(): %m");
+	ASSERT_EQ(setsockopt(c1, SOL_IP, IP_BIND_ADDRESS_NO_PORT, &one, sizeof(one)), 0);
+
+	make_inet_addr(v->domain, v->src1_ip, 0, &addr);
+	ASSERT_EQ(bind(c1, &addr.sa, addr.len), 0) TH_LOG("bind(%s): %m", addr.str);
+
+	make_inet_addr(v->domain, v->dst_ip, DST_PORT, &addr);
+	ASSERT_EQ(connect(c1, &addr.sa, addr.len), 0) TH_LOG("connect(%s): %m", addr.str);
+	ASSERT_EQ(getsockname_port(c1), SRC_PORT);
+
+	/* Disconnect the socket and bind it to <bind_ip>:<SRC_PORT> to block the port */
+	ASSERT_EQ(disconnect(c1), 0) TH_LOG("disconnect: %m");
+	ASSERT_EQ(setsockopt(c1, SOL_SOCKET, SO_REUSEADDR, &one, sizeof(one)), 0);
+
+	make_inet_addr(v->domain, v->bind_ip, SRC_PORT, &addr);
+	ASSERT_EQ(bind(c1, &addr.sa, addr.len), 0) TH_LOG("bind(%s): %m", addr.str);
+
+	/* Trigger port-addr bucket state update with another bind() and close() */
+	pb = socket(v->domain, SOCK_STREAM, 0);
+	ASSERT_GE(pb, 0) TH_LOG("socket(): %m");
+	ASSERT_EQ(setsockopt(pb, SOL_SOCKET, SO_REUSEADDR, &one, sizeof(one)), 0);
+
+	make_inet_addr(v->domain, v->bind_ip, SRC_PORT, &addr);
+	ASSERT_EQ(bind(pb, &addr.sa, addr.len), 0) TH_LOG("bind(%s): %m", addr.str);
+
+	ASSERT_EQ(close(pb), 0);
+
+	/* Connect from <src2_ip>:<SRC_PORT>. Expect failure. */
+	c2 = socket(v->domain, SOCK_STREAM, 0);
+	ASSERT_GE(c2, 0) TH_LOG("socket: %m");
+	ASSERT_EQ(setsockopt(c2, SOL_IP, IP_BIND_ADDRESS_NO_PORT, &one, sizeof(one)), 0);
+
+	make_inet_addr(v->domain, v->src2_ip, 0, &addr);
+	ASSERT_EQ(bind(c2, &addr.sa, addr.len), 0) TH_LOG("bind(%s): %m", addr.str);
+
+	make_inet_addr(v->domain, v->dst_ip, DST_PORT, &addr);
+	EXPECT_EQ(connect(c2, &addr.sa, addr.len), -1) TH_LOG("connect(%s)", addr.str);
+	EXPECT_EQ(errno, EADDRNOTAVAIL) TH_LOG("%m");
+
+	ASSERT_EQ(close(c2), 0);
+	ASSERT_EQ(close(c1), 0);
+	ASSERT_EQ(close(ln), 0);
+}
+
+TEST_HARNESS_MAIN

-- 
2.43.0


