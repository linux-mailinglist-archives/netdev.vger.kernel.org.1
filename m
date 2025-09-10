Return-Path: <netdev+bounces-221667-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C1CB5179D
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 15:09:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DC931899183
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 13:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F4828C5D9;
	Wed, 10 Sep 2025 13:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="XAE7sytJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DC43191C8
	for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 13:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757509743; cv=none; b=LAubSFeerdp5KIlWbHPLpli+OsBYyweSCyv2XHdxHtLgBFqULgCG/mnkrvmzPcYIWx54U/zR5QBSQSpUBAMq2usQ2EPmpT64jkw/HHn38TxA+TaDtKOom3IDgqU6LlHMs07WuBa2JyzP0ylh4fWAd/kF+w7n9TlXs/a0XOM43b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757509743; c=relaxed/simple;
	bh=AtY3mTXZBpJquZOFCG+dlqJzDvE8LjEsS5VEPdw5nBc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RROle91sn0OSlUyCOL/IRGEDsRPDewIeN33x7XI4UnlbhwsA/Ms2fO+/vWesbSU17UTWQNv7RBQ2dVHWykkL2TLTEPW1dVPRIh5HifPnl8uK/6MYU4lWEbLnjU5ZVezJ5YLy6mlygL/MphpLpP4X6PdCZDX104vQxQIy7SbI9lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=XAE7sytJ; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6188b72b7caso7490013a12.2
        for <netdev@vger.kernel.org>; Wed, 10 Sep 2025 06:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1757509737; x=1758114537; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SDfOQ5/CQYYyOkNQxSp0F3VV1HQxjXWapoqY+ceQn40=;
        b=XAE7sytJoaVqpwAmWxZNBbOU30C9gheABXeIrLU3fMFMA6KROgWBVeJzH3KeJbEUdV
         czXDvb7ZrDmWdnz+ohZNj0b4QUm27mhmxHPmaw3mNZEfWvl7WQID8DJTIR08rPtljUIF
         FJkiyhCDtor/jD+KAuLJrMmEGMqOg9AdRVqPaUt6PUPJHBKbKQvHA62/3Gtf1m76OEK/
         TbwZngWVycCjL/Y1tBO4No8fBNqq8k9FAIwkZ/EugTg2dMNT8N6cj4ReX3R49zkaibOx
         Cx4/W+xyuJ3aSXYneR+mbdJ6zlFanplBYESi4snGJD2T0o8xOcCIkXVbTEZjloG8ne3C
         E7SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757509737; x=1758114537;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SDfOQ5/CQYYyOkNQxSp0F3VV1HQxjXWapoqY+ceQn40=;
        b=jrPdICvFy5YEaIbO/OnJZR7rk9DfmRs9pKuDnImYbKGLJU9Qb/yL52JjwSoE+BpaDT
         0FgchqhKss2SrDaipdwbVBKSx1wIVwO5lJST1ZXM8MgOgWz5WXgvFDtIT7Pddv5gFSZy
         JvcKpfxDxNFYVhkVDWafGIdBas5rNDVx2p9xPeE9CJiKfvhjj4o9VWZ8ecBVZh1ybiji
         BHwHNIrGbEwfoDhiLavRR0vkniiszL49/haoBsdQxnpYhezVkWkvShp/fdjzEBa2n0a1
         EtSoyMLmEysAMlovsqur1U04O/nGhNClUeNsc+zKvrq4hdixL/jQ+ry0arv7ODx0PGCk
         6k6g==
X-Gm-Message-State: AOJu0YzZjrv23qVjpyUeFWyZkVRNIzHBetPSWt/PFprXWY84+KLaL/eQ
	/N0ePkPVhXmUHv8TC5KXd4EaeWQTSyEPjYJK6dy25u7yGj9G8JRh7gWQURUfVINmcPs=
X-Gm-Gg: ASbGncuSLt2yfv5eXnKkpGFMX/aga+gZNV6VgZArG0uPZYMcZ9SuCQutyepYDNWgngC
	pR8H04qp3q2MarN3OugED6TGXPr2PSQ4tVXNoQbVT8mmskaSnvKV+huLPaG5RBnkZmpKV6H3DQY
	6RsB0DwOd+r3d3X0raYTnGe1Zhd64tF1THAkeHt2IrinXWl3XY2krsa+huYrCy8dAz3DQkpbTHx
	HojI50f8+hNj6101I5fwbCtScPT6zetFwlAmn6O5x8+dO8U2vqax7ceyCpUuG+X+adQMPgze8DJ
	DvbISuSAR4r+3R7SYVqASs873bFUbrXu1cGtW37NZJhYwvGXNR2eBuO29F0B+tOufscs1Os1k0l
	m42pQqPsUKKdukqo4T5qstReoXIKPRglHAFzLpwu0oCmtZE/85IwjLzBDDx7dgH+c41am
X-Google-Smtp-Source: AGHT+IGxzBrXCMxGipMsbJXQD096/f0lZgcrz+uO5SFF21t/pC8V+LBWcMHLCdN0shxUCgSV/OUqng==
X-Received: by 2002:a05:6402:1ecf:b0:61a:9385:c77e with SMTP id 4fb4d7f45d1cf-62bbfbd1763mr6809409a12.35.1757509736892;
        Wed, 10 Sep 2025 06:08:56 -0700 (PDT)
Received: from cloudflare.com (79.184.140.27.ipv4.supernova.orange.pl. [79.184.140.27])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-62bfef6861esm3219454a12.16.2025.09.10.06.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 06:08:55 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Wed, 10 Sep 2025 15:08:32 +0200
Subject: [PATCH net-next v3 2/2] selftests/net: Test tcp port reuse after
 unbinding a socket
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-update-bind-bucket-state-on-unhash-v3-2-023caaf4ae3c@cloudflare.com>
References: <20250910-update-bind-bucket-state-on-unhash-v3-0-023caaf4ae3c@cloudflare.com>
In-Reply-To: <20250910-update-bind-bucket-state-on-unhash-v3-0-023caaf4ae3c@cloudflare.com>
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
index c9d5b0339e8d..bca54fa2d42c 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -120,6 +120,7 @@ TEST_PROGS += broadcast_pmtu.sh
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


