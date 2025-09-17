Return-Path: <netdev+bounces-224033-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F184B7F2C8
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 15:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EDF044E314B
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 13:22:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427E2283FD6;
	Wed, 17 Sep 2025 13:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Je70SqG7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BA81E25EF
	for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 13:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758115340; cv=none; b=o0hHnkg0X4qrnMalFhJoY38vVPTWfYxVChcvLzPQTypZqYw/1KUCdV+wSLwk53vqpKWAJ/93/ZQHIouBfimRdPFNdGWqcP7nKBmbOPT5bRtEE8ODRZGsftogB185jc6RvVe4NAHjQl4rmWxMGpzzIqctnG01kd7MjliM4pJ0hUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758115340; c=relaxed/simple;
	bh=XgW0B9LKZhxor2JJEYL+n5zVPVGQN1BX+rPfv6v+2Fs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SI+yXWmK8kE/JTfswB5A6hEebvs2Z08yLtcP6QbvioQwtukJr8rRIuj6rZsl7+AqqrsWvS6chA8lSDmOhTKDwTZtJfFtHwJs9Zx4wlm4SXbK5yIknLx5p9jV9/zG42EfAZaLkWPTRNc9DPoixCDHiTJythWYX327ci6mdW9nKFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Je70SqG7; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-62105d21297so12887486a12.0
        for <netdev@vger.kernel.org>; Wed, 17 Sep 2025 06:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1758115333; x=1758720133; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2sZ7IXMKmXJa2eJmlNkOzVCF8zHbYbZahJ05OIujADI=;
        b=Je70SqG78pdW+WS324gKbtDv0OWJme4ayZ0ZvKIDq0UoRyjyQy7cUG73CFZre+GlZa
         PKzlQmsweSJl+vH5fGfdIvtTwX5HW8MKoJsqzN0dpqtjrlS8eDV4Dg5IiOjfVyUpBqh6
         B+0ICn+ZkZal1r15qI/GcmG+CaVGed4tiX4+qWW5hf/4lq3LQikuOkPgC/9sj8NXJMqx
         R0nX0R9xaZgHImqTj1L0faslho30Mk8egMs1963wwNaPfPPB5MrddOCAPOKgdAQxImNY
         7IDAStoLL2Ie7T9AnHduecS+4CyArwAoDbzk/5sOgjeH4DaNxLV2cvy/4rkUVJAbstgV
         BBfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758115333; x=1758720133;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2sZ7IXMKmXJa2eJmlNkOzVCF8zHbYbZahJ05OIujADI=;
        b=BmsNAOXKskvgxag2DUeqU7PClQ21iPYn/QJ1RgSIiz51GBSL3I0L3RkjckQG6fKf+r
         6PMYfsfWIttSaa2PxMEohyyg9DApyyNdNUc+gkAT6M2J/fnNCoJsoGCEhz2equEFB9ft
         DpqzgZshSYdB1wSSKkv6ikh4j9giE7kQ7zt21t15u57BZ3otpHJP+tBCw9G7GjRDzV/L
         nOcNT5QT+tAkB1GA1vEunrrTN0C3u/krx9ZoLLIRXrck0r0xKncgq/31UY5f4fgTMSyh
         tr6swvqGOe4Ojdq/Pcaz6FddFcQH5rxkgEvsLPS0FJOINS1L5PDf3ss47ZUxm1gAYVJ3
         tz8w==
X-Gm-Message-State: AOJu0YxU5FIP3sF/512dEI8f3kXgRM2swwZ6QNTTJwMQbxMwsh8Wo90q
	vHns9jITfdF6Nh+Wj891/bhxHGbebtYTpdiXNZvLtrJGvXH3Nsjpj+EtLMODhTfyW3k=
X-Gm-Gg: ASbGncsMQL4ruSw7fRlGOcl9EQHFDvnZj9RvfemBdqxkVX6MunzJazu3YuSa4h6WaBF
	PBla0HFClrDoChfM8JGKeRYBKoabrLp6spsUVJX/f+VJthfpnRqEfCEK1KV7/VHufDQomQbkXkl
	Mlf8KZZq97hT5pFd1/C37eKLK+J0rLg03AQTnKjWUCefYA1Sit2xGIumVQDZJcKqjvBQCnEszXR
	kaq2bxRy4+1IWn8V3TiEwqUKBg3Ab3q4Iuzc23jnj5gFTD3LZo2ZNAhG/jAN8sxcyhpBPpc3TgL
	pJkGnZZgk6XGdahkfRsEaVe3Wkm2hRtn/pR9ROCh950GytJLIs4tY5PmYKRnTKqZTac2J9sAfjI
	fpz1PvfJchvKY8xY=
X-Google-Smtp-Source: AGHT+IF7NrGor5r5XQA2bFkuFWEkG/TlvyGsM430f7FNzJ7JDL1cGQ33TOioWB4Lc9+tfQVRcVWqrA==
X-Received: by 2002:a17:907:3e1a:b0:b09:48c6:b7ad with SMTP id a640c23a62f3a-b1bba5d1046mr268914566b.57.1758115333083;
        Wed, 17 Sep 2025 06:22:13 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:506a:295f::41f:64])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b07b30da327sm1384011066b.11.2025.09.17.06.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Sep 2025 06:22:12 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Wed, 17 Sep 2025 15:22:05 +0200
Subject: [PATCH net-next v5 2/2] selftests/net: Test tcp port reuse after
 unbinding a socket
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250917-update-bind-bucket-state-on-unhash-v5-2-57168b661b47@cloudflare.com>
References: <20250917-update-bind-bucket-state-on-unhash-v5-0-57168b661b47@cloudflare.com>
In-Reply-To: <20250917-update-bind-bucket-state-on-unhash-v5-0-57168b661b47@cloudflare.com>
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

Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
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


