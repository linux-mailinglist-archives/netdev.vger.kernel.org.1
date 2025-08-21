Return-Path: <netdev+bounces-215591-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AF07B2F5EC
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 13:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8181E4E592F
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 11:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83C730DEC5;
	Thu, 21 Aug 2025 11:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="ORks36oR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D9C30C36D
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 11:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755774570; cv=none; b=rlZ34E5aE4jn3Ja4+WgNtgpziQfgi0q3luXpekcOUJmHsmHS8iPMGRVt9QKMr2jrYCY1ibcCwzCy7Q/BR4/3tFxQfBVndN2Srd70zX4LlYKwMjH/x1m4IOXoKrWcraf462OSmPIUfh+D7HGRpQJKHUZswmRvCcFEJrNZ35mH1Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755774570; c=relaxed/simple;
	bh=XzPZcXY0YTkIhMP83ZWO7rzxFDbIn8WeOS388pQBXL0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ba42eVcSolM8LAR7/7vnKxwN6BNvvx1ZFlCCmaw0Od3Dl6PV9K3HwDb+o2VDVOLainIdFIz8c7aeY+zkz84v2rUPxmE2nlJzHPE9Tv0t3hHzHwy2gkdp/iRi8ovpUHFiROCd79IR1VFfVxRVn+3O+Rq9dA3eriDMuTQuML6IgvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=ORks36oR; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-afcb7a7bad8so125921866b.3
        for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 04:09:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1755774567; x=1756379367; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GoqnbEkRXBkWrsCjkFNGjiQQ1Fw1V+wGKZaLMCnp0gM=;
        b=ORks36oRQAk1MxiF9qvvwBn5so/FJ5dUhdZ2hSSjXI2zfmi1D5FxuOlclNgkRzX/DG
         U5XZj6eJrijvPeA7X9PyrpPJ0cwg+d4KErUrnTc0Ma+WXGExmfIQEFe7lR/7vjpkPJ1q
         rzo80NCaJ6HMWg/jw6iitDX3L72UeYNXCwRuFltvxlpgryy+EO9ic5A9rpJuz+wtoZtw
         xoe8KPUePZM0Bp7hDvOqsGvSXf4EnJsE+vdgN8fnBtjqEuHchYqbplDlDIdjcY79m6SG
         uB5iwAGL7EwqZTrEz/O3Uodh5yolkSft35Z0tvzBTLu+izgLFYZYwNi2VUolQ4YyVPqI
         cgmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755774567; x=1756379367;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GoqnbEkRXBkWrsCjkFNGjiQQ1Fw1V+wGKZaLMCnp0gM=;
        b=p8rUPAnmPnuxYaqyEP8VVECg6zMYqIYyPA/ifrUTmNpJSVvCmzBSOTlpmdDNpSL7xk
         Q0AUZCBn4fJ8jhHTgQb2RfG82Lh6e63fLkFi3wqp9tDBvgiW8c/fLuhI+6kglRsYF6y9
         zWPxsUNGfgSKVVjtl7dWag8O5432W0A7di0Qqx35BzQnklqKPjxC0jxp9qusebmp62Tb
         S0mB9Bm9rvXQdG2eFcstSQu5hKneHs3q7+vstuW6SjnQqnoNIw1FeOKR3Qgb5eBJ10YJ
         7dNUCLGzRySXUIr0H7BYSBUuPE6jvGhbx1EErHX3mvnuQi0L28keMNJA8HPf8B/bDP8z
         wpCQ==
X-Gm-Message-State: AOJu0YyPDolxPjR7EdaWUIeDlokjzq6hi/NPP0wdoBT+c49fh/pOoGEy
	qXsR7rqKWDQVrcfh5V6j1TT2uLQwRtWdXNQWUpNdJPZ0Btla3j4HcXLu2yGeq77W8hc=
X-Gm-Gg: ASbGncuGkFD0LScReO1QVTvoTYwnUmOjmMJOfjHyDNca9+GS8BMe9ANCiXXa7s9TC97
	vO5HK5xU29gs5OxoDeWtrNNAMQpvKGZ2fHPx61hWZCK2baf+bUm82o0+ZE0arI32JZPA7AJtUwp
	eK8G0r0VkcCV6sR2K+zaBQoVWHO4fI5ywKvbauqV9aocCMFHz7AsuKZvRiQpwcCcMYjT7FfIgpt
	90x+5j0rQk91Sf3SGyhV87qhVpjsG3gY+ddCDdKf8L1feK6NXJkTw+ugYYASFMoyHqfIvj/xv1X
	NGeKbec0H/6CmA+JrWjyPWFf0p0E+j4LmGYzOTzgEWCyy7JZQ9YVbH76AXkNyzGELWJHfhwy5WJ
	O604wOfgKA+zej7cPvvak20sEVYNu1L7yIXdJlSDEQXdYNhfXWiofRslYZ9dblqkmYGc5
X-Google-Smtp-Source: AGHT+IH4+icCSQhOqS39cJWIWE37U4evxqORNDv3E7n9rivI9JKSoAtKgKlNhHtNvZOK8RCb7H0Rdg==
X-Received: by 2002:a17:906:f59f:b0:adb:229f:6b71 with SMTP id a640c23a62f3a-afe0781c763mr188734566b.5.1755774566699;
        Thu, 21 Aug 2025 04:09:26 -0700 (PDT)
Received: from cloudflare.com (79.191.55.218.ipv4.supernova.orange.pl. [79.191.55.218])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afded2bc310sm367875766b.5.2025.08.21.04.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 04:09:25 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Thu, 21 Aug 2025 13:09:15 +0200
Subject: [PATCH net-next v2 2/2] selftests/net: Test tcp port reuse after
 unbinding a socket
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-update-bind-bucket-state-on-unhash-v2-2-0c204543a522@cloudflare.com>
References: <20250821-update-bind-bucket-state-on-unhash-v2-0-0c204543a522@cloudflare.com>
In-Reply-To: <20250821-update-bind-bucket-state-on-unhash-v2-0-0c204543a522@cloudflare.com>
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

As well as a corner case to test that the autobind flag is cleared:

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
index b31a71f2b372..b317ec5e6aec 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -117,6 +117,7 @@ TEST_GEN_FILES += tfo
 TEST_PROGS += tfo_passive.sh
 TEST_PROGS += broadcast_pmtu.sh
 TEST_PROGS += ipv6_force_forwarding.sh
+TEST_GEN_PROGS += tcp_port_share
 
 # YNL files, must be before "include ..lib.mk"
 YNL_GEN_FILES := busy_poller netlink-dumps
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


