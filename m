Return-Path: <netdev+bounces-212139-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06B1FB1E55A
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 11:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 242103BB212
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 09:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B286D26B74D;
	Fri,  8 Aug 2025 09:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="TkI0StW3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E15266584
	for <netdev@vger.kernel.org>; Fri,  8 Aug 2025 09:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754644221; cv=none; b=lqeXBVMVqDFT19W71X7bYaVaeJrXS8zWHQznnnpJz9JFW9EywkiGIoS+g2JIXH0ChoI0J6egAmxogDj81aBQSMTG6ZaJYk/qu0/jsECrjeeYavXxRG73HNzck9b+vGhoz3TwiTdJXr6GN7KaVRAHZSRl9xIKqqIcFUV7ZWHM/r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754644221; c=relaxed/simple;
	bh=OmpHUcoEHAK7WIH4Qf8EsM/SvHPeTX1wC/Gy4XibPTM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DI2c2AANou4qpWv9r3Z2Q3x9z6Uu48KwQKsCwxJ0OYx+YzdoC+tiExbD30L+q2AHlYh+YEl2usYMkvwiKzwdVNRJhPndEW10nL8eHqHddZLSdqPhVxBeRUsyI6j2QAumheE4OuJLyGoR0zu1VAFP0iw1/xC03HiN1vhur4OKXiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=TkI0StW3; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6154655c8aeso2777159a12.3
        for <netdev@vger.kernel.org>; Fri, 08 Aug 2025 02:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1754644216; x=1755249016; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KOnTZyTYmrf41aI6MpwVG2HodiqGpQ01slDlWwqoer4=;
        b=TkI0StW37rJoP27xcvVivlAQltNJOsynd8y57HsTXiqy9PpacHw/UFWGKmOMingAzr
         pqIgVjsuAcq6wl2y8s9qmy42TMdB97gU57uU62wJmoPca/cu7Z5nX2tbZB+/klLR4OID
         Mlj/oGXc21mUiAv9K6YpehTSjVAegrJKsR+2iIKZPlqDzra4OJHXy5+l0FsYOJ7+bH1l
         YNvNhG4FNiDdeMUagP1P6eSMw4Kcan2l9tu3K12b9DxgzqNmeRobQz8aBNRcgQeVd1ab
         D0fWxAwzbGHGn8vX+9nIrFGRHusMj8yU0IailMt4jMyTFbW0P+F29BcgDw8To6UNiJ0S
         k5Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754644216; x=1755249016;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KOnTZyTYmrf41aI6MpwVG2HodiqGpQ01slDlWwqoer4=;
        b=AZECEPP/Ew+QpmuNjyNK4r9tjKk+iwQ+ia1dKb7FllDjCy57amNgldEgYaPGcLOlE9
         6rAooa/7hlf2Tf9fFouHvFUNIOUKU8ZYzlcI4bequFYv5DtyKYPGDJC8M8aFEVLFAWvO
         +TyWa4/5Lz2RIgw/XKPEnWTzu+4Ty9rgjhVNyXxzoKzBiO4H9Tc05bN/Xhue/4U1zKLK
         BIlv+YX+092A4iLi4lPgEih6lW7x1Nb2BDZ2T4HMxyDsEXOSbiy0dPYNT+i4cw8UON7o
         rO0w5Htg27FlVJUzWtizQbp3RJKNzlZD5UsfLnl8mX8az1tgaBYloqZUjvItLSICMEys
         3b1A==
X-Gm-Message-State: AOJu0YxtPYSrpNNDzLBw+oF4GPYgXSqwUeFeePzCDRW12wTuBaI8vjni
	rJYmQhH+Q9arZjlFtQRrZmCBdvGqaQTGWacetlp5K6thdh+9CbaX0CetMbNg5a9kmVU=
X-Gm-Gg: ASbGncsBLs4LKFSuY1Li1jSrmXfNeBgD9nddCeeLfIAL/ZtRfOC5pRprjij3290JfP0
	1EW5VnuKDDH6du+2wLH9DIBwqXhVN629rUOBYQofBzG/N1k1ruEfbPhMmtol5hD4qOxGHtFLSKv
	26stCrO1qYGclqOfJGlQgRS7zC1irnIdU38KIdZELzJEzcJKl5ASEKqEkk+WYztD2255dpf1L3S
	JOoYx5eZh687iHuYo1Tr8FR+N3ChVVco16XMMdPIF2+4N2kyULo4O3dyJYEqoAzFNaQLE/TTHYu
	OR8e8sZEOxPvUmXMPRT2MMjGQcxakI4tkQc+9B1cq8nKuZUIOLAn39xLkFHUJfAAbf0Ya9nbQBk
	UkD2oGcZyi8SqX1B74pOiyU/ZeZlmL91jf+wY8ZIH0sQtY43qcw37hpEIFs21BoGC8IvhfHA=
X-Google-Smtp-Source: AGHT+IHetM+f8305lk7VEuqHcd6wH0TnEK2zaTXtdDVjJw7YKkuv0EBvKhVso73xOndyIPFlMI7yiA==
X-Received: by 2002:a17:907:3ea8:b0:ad8:a935:b905 with SMTP id a640c23a62f3a-af9c647db5dmr161673766b.22.1754644215796;
        Fri, 08 Aug 2025 02:10:15 -0700 (PDT)
Received: from cloudflare.com (79.184.123.100.ipv4.supernova.orange.pl. [79.184.123.100])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-af91a0771f9sm1474864466b.16.2025.08.08.02.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 02:10:14 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Fri, 08 Aug 2025 11:10:02 +0200
Subject: [PATCH RFC net-next 2/2] selftests/net: Test tcp port reuse after
 unbinding a socket
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250808-update-bind-bucket-state-on-unhash-v1-2-faf85099d61b@cloudflare.com>
References: <20250808-update-bind-bucket-state-on-unhash-v1-0-faf85099d61b@cloudflare.com>
In-Reply-To: <20250808-update-bind-bucket-state-on-unhash-v1-0-faf85099d61b@cloudflare.com>
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

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 tools/testing/selftests/net/Makefile         |   1 +
 tools/testing/selftests/net/tcp_port_share.c | 182 +++++++++++++++++++++++++++
 2 files changed, 183 insertions(+)

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
index 000000000000..d6db89affbc9
--- /dev/null
+++ b/tools/testing/selftests/net/tcp_port_share.c
@@ -0,0 +1,182 @@
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
+	/* IP to bind to to block the source port */
+	const char *bind_ip;
+};
+
+#define DST_PORT 30000
+#define SRC_PORT 40000
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
+	ASSERT_EQ(unshare(CLONE_NEWNET), 0);
+	ASSERT_EQ(system("ip link set dev lo up"), 0);
+	ASSERT_EQ(system("ip addr add dev lo 2001:db8::1/32 nodad"), 0);
+	ASSERT_EQ(system("ip addr add dev lo 2001:db8::2/32 nodad"), 0);
+	ASSERT_EQ(system("ip addr add dev lo 2001:db8::3/32 nodad"), 0);
+	ASSERT_EQ(system("sysctl -wq net.ipv4.ip_local_port_range='40000 40000'"), 0);
+}
+
+FIXTURE_TEARDOWN(tcp_port_share) {}
+
+/* Check that an ephemeral port can be used again as soon as the socket bound to
+ * the port, blocking it from reuse, releases it.
+ */
+TEST_F(tcp_port_share, can_reuse_port_after_unbind)
+{
+	const typeof(variant) v = variant;
+	int c1, c2, ln, port_block;
+	struct sockaddr_inet addr;
+	const int one = 1;
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
+	port_block = socket(v->domain, SOCK_STREAM, 0);
+	ASSERT_GE(port_block, 0) TH_LOG("socket(): %m");
+	ASSERT_EQ(setsockopt(port_block, SOL_SOCKET, SO_REUSEADDR, &one, sizeof(one)), 0);
+
+	make_inet_addr(v->domain, v->bind_ip, SRC_PORT, &addr);
+	ASSERT_EQ(bind(port_block, &addr.sa, addr.len), 0) TH_LOG("bind(%s): %m", addr.str);
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
+	ASSERT_EQ(close(port_block), 0);
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
+TEST_HARNESS_MAIN

-- 
2.43.0


