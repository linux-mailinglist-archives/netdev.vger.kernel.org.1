Return-Path: <netdev+bounces-203874-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8500AF7D16
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 18:01:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E8164E7732
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 16:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB60423BCFF;
	Thu,  3 Jul 2025 15:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="GJ2e0pB6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55AF12F002D
	for <netdev@vger.kernel.org>; Thu,  3 Jul 2025 15:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751558387; cv=none; b=t+eoo+qmC4NqIPlREd1iDn860QChe6fkJihYwZuHxaTizxhKAFH6rpyP6bFajbTNXmA+kJHtpn2LHmX3ZOtEccGASZlewP+nFElM21HZA/l8BV3tgrUJDAWR2xRlv2HcCqulRqgPgeWmGYV9t4nxSn2ZC8aWnUDDL1z6x6fSrqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751558387; c=relaxed/simple;
	bh=U2+amGx3sCguwAh7IndQ65ofujYhNkNl9b/ttqK/5ec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DAjVllbrCY0QiB+BM+elUP12flQ7R1ZpYPoB8ZioeCmbej2FjyljNqkyhrNzAkezeQs7ij4xH6+O0GeYyICskv2Rdd3mcUjM0urc+G2VptP384CqMg9LWhQpNi/lL9kCnaYZuSalDge2AhRrgYy6+jKQubd6gjEb02aqxGo1HFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=GJ2e0pB6; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-607cc1a2bd8so13922a12.2
        for <netdev@vger.kernel.org>; Thu, 03 Jul 2025 08:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1751558382; x=1752163182; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mEDKDHPRddWVdNOZNFpFOkWBp4im61e/BUKjEk6P/ek=;
        b=GJ2e0pB6nw49zNhOK/Eqc4zOqtTc0ZX0Q4FthMtRYAEgliHqsWIzNHuAHZCP533m04
         yz1tOqOBe4G97RziK7KN5gWBcvF+CrZfCEF4ku+LX7gFQ907zYY8PgTM9CTM4X2KjFXE
         Mjg+7gQjuT9xG/FLRMkZtVI8isTb8xFgR/k/PBReWA+cYKaT5TL2iUzoVUmMrphirVru
         PpLHdhFcDq/UjGrQqOaF05s2Ef6Cv/VZp4jlYbFp1H9JVN+78sr2C/AntLfdtA10y6H+
         eSEcWLHeZPi4UfMkkdxUXBRMWHUrMYJ/Mbl/j+vtBIykdXDrHyNwRufpu4HgBsLWKENx
         3WGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751558382; x=1752163182;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mEDKDHPRddWVdNOZNFpFOkWBp4im61e/BUKjEk6P/ek=;
        b=dwPMCCOnKchUipI8Banu6dHlS2pffRr03UVchNOHlFjXsVPvwkRehM6eI92/wWq3dg
         9aJptdYNajsVJkk1k6lSclfOzaLJMhS/9XDwOt4ex1+U/A2CsMewui8xc1ZRXNP+ylfz
         j61kQ/RET9QVLjU2rQxDrW9EfBS+ozEwbZ2ZGCHvKq50RDGzWuyGUDc94X6Aug5HgqiD
         pejSmokS4Pjl1TQoAw35dyyOJ6oVclbwEpoblaTrAcqiIY++Vq0yk2Ft+4hAcLixpglb
         MH017z+2+8OWPiMZ9P6T4uvzRWAt6hbZTmXKK7eZfj1WC93srToDrXZfFhmoRyz9GEyh
         rLQA==
X-Gm-Message-State: AOJu0Yw9q7iUkEE09r2s3+BCxvQN0yTYnhUUiaANh1p6NgfobyAwtHAD
	ocHyNBbj+xhNwm4hPbjHYNtAAWOJSxaW4qqhXozeNVhL1hPTM8WiHtht6x7+Q4RZ378oqCiI5wo
	KHc80
X-Gm-Gg: ASbGncvqYw70G6ILWB6xEDZakBqJHa8ZnjFBpxVXSJ2oKL5d/trhL7q1RbXsywRZAZ8
	31NMxnD04EBkhKpcaPvcrgcDMlMOe8xmXnpcQ+RdFBMz40DCZBLj1nBvT30Q5uUedj3RvZXL34P
	jznHBKKa0FR4JtYroV+0h32SIow9bNxWfDpKQwcPpsXkZ+EtR9RKeZjYwn2TlWDXOfU3KhgQqkJ
	7y5YySsB/LOtCv+ES+wlf5mAF2RzDDLuAqdm8SLqhFgTLjF8saKnMZz1RudKu1s+gYopoWdwixZ
	GCHOfCOO7lhyvocQX6by7+iViwuJR1SBAV8AsPttTzutEk2iYdrrqBM=
X-Google-Smtp-Source: AGHT+IHt+1f1GvRP13vz/cTnQfh2vKvPRP5SvGV43xWzVqyXCpwLYdERMv2gKrfK6hDiij8lgeYEaQ==
X-Received: by 2002:a50:8a98:0:b0:5f7:f55a:e5e1 with SMTP id 4fb4d7f45d1cf-60e5350159cmr5332167a12.24.1751558382010;
        Thu, 03 Jul 2025 08:59:42 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2432::39b:c2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60c828bbea9sm10851963a12.1.2025.07.03.08.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 08:59:41 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: netdev@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>
Cc: kernel-team@cloudflare.com
Subject: [PATCH net-next v2 2/2] selftests/net: Cover port sharing scenarios with IP_LOCAL_PORT_RANGE
Date: Thu,  3 Jul 2025 17:59:37 +0200
Message-ID: <20250703-connect-port-search-harder-v2-2-d51bce6bd0a6@cloudflare.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250703-connect-port-search-harder-v2-1-d51bce6bd0a6@cloudflare.com>
References: <20250703-connect-port-search-harder-v2-1-d51bce6bd0a6@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-07fe9
Content-Transfer-Encoding: 8bit

Expand the ip_local_port_range tests to check that when using
IP_LOCAL_PORT_RANGE socket option:

1) We can share the local port as long as there is no IP address conflict
   with any other socket. Covered by tcp_port_reuse__no_ip_conflict* tests.

2) We cannot share the local port with wildcard sockets or when there is a
   local IP conflict. Covered by tcp_port_reuse__ip_conflict* tests.

3) We cannot share the local IP and port to connect to different remote IPs
   if the port bucket is in non-reuseable state, Corner case covered by
   tcp_port_reuse__ip_port_conflict_with_unique_dst_after_bind test.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 tools/testing/selftests/net/ip_local_port_range.c  | 525 +++++++++++++++++++++
 tools/testing/selftests/net/ip_local_port_range.sh |  14 +-
 2 files changed, 534 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/ip_local_port_range.c b/tools/testing/selftests/net/ip_local_port_range.c
index 29451d2244b7..33288732dc1b 100644
--- a/tools/testing/selftests/net/ip_local_port_range.c
+++ b/tools/testing/selftests/net/ip_local_port_range.c
@@ -9,6 +9,7 @@
 
 #include <fcntl.h>
 #include <netinet/ip.h>
+#include <arpa/inet.h>
 
 #include "../kselftest_harness.h"
 
@@ -20,6 +21,15 @@
 #define IPPROTO_MPTCP 262
 #endif
 
+static const int ONE = 1;
+
+__attribute__((nonnull)) static inline void close_fd(int *fd)
+{
+	close(*fd);
+}
+
+#define __close_fd __attribute__((cleanup(close_fd)))
+
 static __u32 pack_port_range(__u16 lo, __u16 hi)
 {
 	return (hi << 16) | (lo << 0);
@@ -116,6 +126,81 @@ static int get_ip_local_port_range(int fd, __u32 *range)
 	return 0;
 }
 
+struct sockaddr_inet {
+	union {
+		struct sockaddr_storage ss;
+		struct sockaddr_in6 v6;
+		struct sockaddr_in v4;
+		struct sockaddr sa;
+	};
+	socklen_t len;
+};
+
+static void make_inet_addr(int af, const char *ip, __u16 port,
+			   struct sockaddr_inet *addr)
+{
+	memset(addr, 0, sizeof(*addr));
+
+	switch (af) {
+	case AF_INET:
+		addr->len = sizeof(addr->v4);
+		addr->v4.sin_family = af;
+		addr->v4.sin_port = htons(port);
+		inet_pton(af, ip, &addr->v4.sin_addr);
+		break;
+	case AF_INET6:
+		addr->len = sizeof(addr->v6);
+		addr->v6.sin6_family = af;
+		addr->v6.sin6_port = htons(port);
+		inet_pton(af, ip, &addr->v6.sin6_addr);
+		break;
+	}
+}
+
+static bool is_v4mapped(const struct sockaddr_inet *a)
+{
+	return (a->sa.sa_family == AF_INET6 &&
+		IN6_IS_ADDR_V4MAPPED(&a->v6.sin6_addr));
+}
+
+static void v4mapped_to_ipv4(struct sockaddr_inet *a)
+{
+	in_port_t port = a->v6.sin6_port;
+	in_addr_t ip4 = *(in_addr_t *)&a->v6.sin6_addr.s6_addr[12];
+
+	memset(a, 0, sizeof(*a));
+	a->len = sizeof(a->v4);
+	a->v4.sin_family = AF_INET;
+	a->v4.sin_port = port;
+	a->v4.sin_addr.s_addr = ip4;
+}
+
+static void ipv4_to_v4mapped(struct sockaddr_inet *a)
+{
+	in_port_t port = a->v4.sin_port;
+	in_addr_t ip4 = a->v4.sin_addr.s_addr;
+
+	memset(a, 0, sizeof(*a));
+	a->len = sizeof(a->v6);
+	a->v6.sin6_family = AF_INET6;
+	a->v6.sin6_port = port;
+	a->v6.sin6_addr.s6_addr[10] = 0xff;
+	a->v6.sin6_addr.s6_addr[11] = 0xff;
+	memcpy(&a->v6.sin6_addr.s6_addr[12], &ip4, sizeof(ip4));
+}
+
+static __u16 inet_port(const struct sockaddr_inet *a)
+{
+	switch (a->sa.sa_family) {
+	case AF_INET:
+		return ntohs(a->v4.sin_port);
+	case AF_INET6:
+		return ntohs(a->v6.sin6_port);
+	default:
+		return 0;
+	}
+}
+
 FIXTURE(ip_local_port_range) {};
 
 FIXTURE_SETUP(ip_local_port_range)
@@ -460,4 +545,444 @@ TEST_F(ip_local_port_range, get_port_range)
 	ASSERT_TRUE(!err) TH_LOG("close failed");
 }
 
+FIXTURE(tcp_port_reuse__no_ip_conflict) {};
+FIXTURE_SETUP(tcp_port_reuse__no_ip_conflict) {}
+FIXTURE_TEARDOWN(tcp_port_reuse__no_ip_conflict) {}
+
+FIXTURE_VARIANT(tcp_port_reuse__no_ip_conflict) {
+	int af_one;
+	const char *ip_one;
+	int af_two;
+	const char *ip_two;
+};
+
+FIXTURE_VARIANT_ADD(tcp_port_reuse__no_ip_conflict, ipv4) {
+	.af_one = AF_INET,
+	.ip_one = "127.0.0.1",
+	.af_two = AF_INET,
+	.ip_two = "127.0.0.2",
+};
+
+FIXTURE_VARIANT_ADD(tcp_port_reuse__no_ip_conflict, ipv6_v4mapped) {
+	.af_one = AF_INET6,
+	.ip_one = "::ffff:127.0.0.1",
+	.af_two = AF_INET,
+	.ip_two = "127.0.0.2",
+};
+
+FIXTURE_VARIANT_ADD(tcp_port_reuse__no_ip_conflict, ipv6) {
+	.af_one = AF_INET6,
+	.ip_one = "2001:db8::1",
+	.af_two = AF_INET6,
+	.ip_two = "2001:db8::2",
+};
+
+/* Check that a connected socket, which is using IP_LOCAL_PORT_RANGE to relax
+ * port search restrictions at connect() time, can share a local port with a
+ * listening socket bound to a different IP.
+ */
+TEST_F(tcp_port_reuse__no_ip_conflict, share_port_with_listening_socket)
+{
+	const typeof(variant) v = variant;
+	struct sockaddr_inet addr;
+	__close_fd int ln = -1;
+	__close_fd int c = -1;
+	__close_fd int p = -1;
+	__u32 range;
+	int r;
+
+	/* Listen on <ip one>:40000 */
+	ln = socket(v->af_one, SOCK_STREAM, 0);
+	ASSERT_GE(ln, 0) TH_LOG("socket");
+
+	r = setsockopt(ln, SOL_SOCKET, SO_REUSEADDR, &ONE, sizeof(ONE));
+	ASSERT_EQ(r, 0) TH_LOG("setsockopt(SO_REUSEADDR)");
+
+	make_inet_addr(v->af_one, v->ip_one, 40000, &addr);
+	r = bind(ln, &addr.sa, addr.len);
+	ASSERT_EQ(r, 0) TH_LOG("bind(<ip_one>:40000)");
+
+	r = listen(ln, 1);
+	ASSERT_EQ(r, 0) TH_LOG("listen");
+
+	/* Connect from <ip two>:40000 to <ip one>:40000 */
+	c = socket(v->af_two, SOCK_STREAM, 0);
+	ASSERT_GE(c, 0) TH_LOG("socket");
+
+	r = setsockopt(c, SOL_IP, IP_BIND_ADDRESS_NO_PORT, &ONE, sizeof(ONE));
+	ASSERT_EQ(r, 0) TH_LOG("setsockopt(IP_BIND_ADDRESS_NO_PORT)");
+
+	range = pack_port_range(40000, 40000);
+	r = setsockopt(c, SOL_IP, IP_LOCAL_PORT_RANGE, &range, sizeof(range));
+	ASSERT_EQ(r, 0) TH_LOG("setsockopt(IP_LOCAL_PORT_RANGE)");
+
+	make_inet_addr(v->af_two, v->ip_two, 0, &addr);
+	r = bind(c, &addr.sa, addr.len);
+	ASSERT_EQ(r, 0) TH_LOG("bind(<ip_two>:0)");
+
+	make_inet_addr(v->af_one, v->ip_one, 40000, &addr);
+	if (is_v4mapped(&addr))
+		v4mapped_to_ipv4(&addr);
+	r = connect(c, &addr.sa, addr.len);
+	EXPECT_EQ(r, 0) TH_LOG("connect(<ip_one>:40000)");
+	EXPECT_EQ(get_sock_port(c), 40000);
+}
+
+/* Check that a connected socket, which is using IP_LOCAL_PORT_RANGE to relax
+ * port search restrictions at connect() time, can share a local port with
+ * another connected socket bound to a different IP without
+ * IP_BIND_ADDRESS_NO_PORT enabled.
+ */
+TEST_F(tcp_port_reuse__no_ip_conflict, share_port_with_connected_socket)
+{
+	const typeof(variant) v = variant;
+	struct sockaddr_inet dst = {};
+	struct sockaddr_inet src = {};
+	__close_fd int ln = -1;
+	__close_fd int c1 = -1;
+	__close_fd int c2 = -1;
+	__u32 range;
+	__u16 port;
+	int r;
+
+	/* Listen on wildcard. Same family as <ip_two>. */
+	ln = socket(v->af_two, SOCK_STREAM, 0);
+	ASSERT_GE(ln, 0) TH_LOG("socket");
+
+	r = setsockopt(ln, SOL_SOCKET, SO_REUSEADDR, &ONE, sizeof(ONE));
+	ASSERT_EQ(r, 0) TH_LOG("setsockopt(SO_REUSEADDR");
+
+	r = listen(ln, 2);
+	ASSERT_EQ(r, 0) TH_LOG("listen");
+
+	dst.len = sizeof(dst.ss);
+	r = getsockname(ln, &dst.sa, &dst.len);
+	ASSERT_EQ(r, 0) TH_LOG("getsockname");
+
+	/* Connect from <ip one> but without IP_BIND_ADDRESS_NO_PORT */
+	c1 = socket(v->af_one, SOCK_STREAM, 0);
+	ASSERT_GE(c1, 0) TH_LOG("socket");
+
+	make_inet_addr(v->af_one, v->ip_one, 0, &src);
+	r = bind(c1, &src.sa, src.len);
+	ASSERT_EQ(r, 0) TH_LOG("bind");
+
+	if (src.sa.sa_family == AF_INET6 && dst.sa.sa_family == AF_INET)
+		ipv4_to_v4mapped(&dst);
+	r = connect(c1, &dst.sa, dst.len);
+	ASSERT_EQ(r, 0) TH_LOG("connect");
+
+	src.len = sizeof(src.ss);
+	r = getsockname(c1, &src.sa, &src.len);
+	ASSERT_EQ(r, 0) TH_LOG("getsockname");
+
+	/* Connect from <ip two>:<c1 port> with IP_BIND_ADDRESS_NO_PORT */
+	c2 = socket(v->af_two, SOCK_STREAM, 0);
+	ASSERT_GE(c2, 0) TH_LOG("socket");
+
+	r = setsockopt(c2, SOL_IP, IP_BIND_ADDRESS_NO_PORT, &ONE, sizeof(ONE));
+	ASSERT_EQ(r, 0) TH_LOG("setsockopt(IP_BIND_ADDRESS_NO_PORT)");
+
+	port = inet_port(&src);
+	range = pack_port_range(port, port);
+	r = setsockopt(c2, SOL_IP, IP_LOCAL_PORT_RANGE, &range, sizeof(range));
+	ASSERT_EQ(r, 0) TH_LOG("setsockopt(IP_LOCAL_PORT_RANGE)");
+
+	make_inet_addr(v->af_two, v->ip_two, 0, &src);
+	r = bind(c2, &src.sa, src.len);
+	ASSERT_EQ(r, 0) TH_LOG("bind");
+
+	if (is_v4mapped(&dst))
+		v4mapped_to_ipv4(&dst);
+	r = connect(c2, &dst.sa, dst.len);
+	EXPECT_EQ(r, 0) TH_LOG("connect");
+	EXPECT_EQ(get_sock_port(c2), port);
+}
+
+/* Check that a connected socket, which is using IP_LOCAL_PORT_RANGE to relax
+ * port search restrictions at connect() time, can share a local port with an
+ * IPv6 wildcard socket which is not dualstack (v6-only).
+ */
+TEST(tcp_port_reuse__no_ip_conflict_wildcard_v6only)
+{
+	struct sockaddr_inet addr;
+	__close_fd int ln4 = -1;
+	__close_fd int ln6 = -1;
+	__close_fd int c = -1;
+	__u32 range;
+	int r;
+
+	/* Listen on [::]:40000 (v6only) */
+	ln6 = socket(AF_INET6, SOCK_STREAM, 0);
+	ASSERT_GE(ln6, 0) TH_LOG("socket");
+
+	r = setsockopt(ln6, SOL_SOCKET, SO_REUSEADDR, &ONE, sizeof(ONE));
+	ASSERT_EQ(r, 0) TH_LOG("setsockopt(SO_REUSEADDR)");
+
+	r = setsockopt(ln6, IPPROTO_IPV6, IPV6_V6ONLY, &ONE, sizeof(ONE));
+	ASSERT_EQ(r, 0) TH_LOG("setsockopt(IPV6_V6ONLY)");
+
+	make_inet_addr(AF_INET6, "::", 40000, &addr);
+	r = bind(ln6, &addr.sa, addr.len);
+	ASSERT_EQ(r, 0) TH_LOG("bind([::]:40000)");
+
+	r = listen(ln6, 1);
+	ASSERT_EQ(r, 0) TH_LOG("listen");
+
+	/* Listen on 127.0.0.1:30000 */
+	ln4 = socket(AF_INET, SOCK_STREAM, 0);
+	ASSERT_GE(ln4, 0) TH_LOG("socket");
+
+	r = setsockopt(ln4, SOL_SOCKET, SO_REUSEADDR, &ONE, sizeof(ONE));
+	ASSERT_EQ(r, 0) TH_LOG("setsockopt(SO_REUSEADDR)");
+
+	make_inet_addr(AF_INET, "127.0.0.1", 30000, &addr);
+	r = bind(ln4, &addr.sa, addr.len);
+	ASSERT_EQ(r, 0) TH_LOG("bind(127.0.0.1:30000)");
+
+	r = listen(ln4, 1);
+	ASSERT_EQ(r, 0) TH_LOG("listen");
+
+	/* Connect from 127.0.0.1:40000 to 127.0.0.1:30000*/
+	c = socket(AF_INET, SOCK_STREAM, 0);
+	ASSERT_GE(c, 0) TH_LOG("socket");
+
+	range = pack_port_range(40000, 40000);
+	r = setsockopt(c, SOL_IP, IP_LOCAL_PORT_RANGE, &range, sizeof(range));
+	ASSERT_EQ(r, 0) TH_LOG("setsockopt(IP_LOCAL_PORT_RANGE)");
+
+	r = connect(c, &addr.sa, addr.len);
+	EXPECT_EQ(r, 0) TH_LOG("connect(127.0.0.1:30000)");
+	EXPECT_EQ(get_sock_port(c), 40000);
+}
+
+/* Check that two sockets can share the local IP and the ephemeral port when the
+ * destination address differs.
+ */
+TEST(tcp_port_reuse__no_ip_conflict_with_unique_dst)
+{
+	struct sockaddr_inet addr;
+	__close_fd int ln = -1;
+	__close_fd int c1 = -1;
+	__close_fd int c2 = -1;
+	__u32 range;
+	int r;
+
+	/* Listen on 0.0.0.0:30000 */
+	ln = socket(AF_INET, SOCK_STREAM, 0);
+	ASSERT_GE(ln, 0) TH_LOG("socket");
+
+	r = setsockopt(ln, SOL_SOCKET, SO_REUSEADDR, &ONE, sizeof(ONE));
+	ASSERT_EQ(r, 0) TH_LOG("setsockopt(SO_REUSEADDR)");
+
+	make_inet_addr(AF_INET, "0.0.0.0", 30000, &addr);
+	r = bind(ln, &addr.sa, addr.len);
+	ASSERT_EQ(r, 0) TH_LOG("bind");
+
+	r = listen(ln, 2);
+	ASSERT_EQ(r, 0) TH_LOG("listen");
+
+	/* Connect from 127.0.0.1:40000 to 127.1.1.1:30000 */
+	c1 = socket(AF_INET, SOCK_STREAM, 0);
+	ASSERT_GE(c1, 0) TH_LOG("socket");
+
+	range = pack_port_range(40000, 40000);
+	r = setsockopt(c1, SOL_IP, IP_LOCAL_PORT_RANGE, &range, sizeof(range));
+	ASSERT_EQ(r, 0) TH_LOG("setsockopt(IP_LOCAL_PORT_RANGE)");
+
+	make_inet_addr(AF_INET, "127.1.1.1", 30000, &addr);
+	r = connect(c1, &addr.sa, addr.len);
+	ASSERT_EQ(r, 0) TH_LOG("connect(127.1.1.1:30000)");
+	ASSERT_EQ(get_sock_port(c1), 40000);
+
+	/* Connect from 127.0.0.1:40000 to 127.2.2.2:30000 */
+	c2 = socket(AF_INET, SOCK_STREAM, 0);
+	ASSERT_GE(c2, 0) TH_LOG("socket");
+
+	range = pack_port_range(40000, 40000);
+	r = setsockopt(c2, SOL_IP, IP_LOCAL_PORT_RANGE, &range, sizeof(range));
+	ASSERT_EQ(r, 0) TH_LOG("setsockopt(IP_LOCAL_PORT_RANGE)");
+
+	make_inet_addr(AF_INET, "127.2.2.2", 30000, &addr);
+	r = connect(c2, &addr.sa, addr.len);
+	EXPECT_EQ(r, 0) TH_LOG("connect(127.1.1.1:30000)");
+	EXPECT_EQ(get_sock_port(c2), 40000);
+}
+
+FIXTURE(tcp_port_reuse__ip_conflict) {};
+FIXTURE_SETUP(tcp_port_reuse__ip_conflict) {}
+FIXTURE_TEARDOWN(tcp_port_reuse__ip_conflict) {}
+
+FIXTURE_VARIANT(tcp_port_reuse__ip_conflict) {
+	int af_one;
+	const char *ip_one;
+	int af_two;
+	const char *ip_two;
+};
+
+FIXTURE_VARIANT_ADD(tcp_port_reuse__ip_conflict, ipv4) {
+	.af_one = AF_INET,
+	.ip_one = "127.0.0.1",
+	.af_two = AF_INET,
+	.ip_two = "127.0.0.1",
+};
+
+FIXTURE_VARIANT_ADD(tcp_port_reuse__ip_conflict, ipv6_v4mapped) {
+	.af_one = AF_INET6,
+	.ip_one = "::ffff:127.0.0.1",
+	.af_two = AF_INET,
+	.ip_two = "127.0.0.1",
+};
+
+FIXTURE_VARIANT_ADD(tcp_port_reuse__ip_conflict, ipv6) {
+	.af_one = AF_INET6,
+	.ip_one = "2001:db8::1",
+	.af_two = AF_INET6,
+	.ip_two = "2001:db8::1",
+};
+
+FIXTURE_VARIANT_ADD(tcp_port_reuse__ip_conflict, ipv4_wildcard) {
+	.af_one = AF_INET,
+	.ip_one = "0.0.0.0",
+	.af_two = AF_INET,
+	.ip_two = "127.0.0.1",
+};
+
+FIXTURE_VARIANT_ADD(tcp_port_reuse__ip_conflict, ipv6_v4mapped_wildcard) {
+	.af_one = AF_INET6,
+	.ip_one = "::ffff:0.0.0.0",
+	.af_two = AF_INET,
+	.ip_two = "127.0.0.1",
+};
+
+FIXTURE_VARIANT_ADD(tcp_port_reuse__ip_conflict, ipv6_wildcard) {
+	.af_one = AF_INET6,
+	.ip_one = "::",
+	.af_two = AF_INET6,
+	.ip_two = "2001:db8::1",
+};
+
+FIXTURE_VARIANT_ADD(tcp_port_reuse__ip_conflict, dualstack_wildcard) {
+	.af_one = AF_INET6,
+	.ip_one = "::",
+	.af_two = AF_INET6,
+	.ip_two = "127.0.0.1",
+};
+
+/* Check that a socket, which using IP_LOCAL_PORT_RANGE to relax local port
+ * search restrictions at connect() time, can't share a local port with a
+ * listening socket when there is IP address conflict.
+ */
+TEST_F(tcp_port_reuse__ip_conflict, cannot_share_port)
+{
+	const typeof(variant) v = variant;
+	struct sockaddr_inet dst, src;
+	__close_fd int ln = -1;
+	__close_fd int c = -1;
+	__u32 range;
+	int r;
+
+	/* Listen on <ip_one>:40000 */
+	ln = socket(v->af_one, SOCK_STREAM, 0);
+	ASSERT_GE(ln, 0) TH_LOG("socket");
+
+	r = setsockopt(ln, SOL_SOCKET, SO_REUSEADDR, &ONE, sizeof(ONE));
+	ASSERT_EQ(r, 0) TH_LOG("setsockopt(SO_REUSEADDR)");
+
+	make_inet_addr(v->af_one, v->ip_one, 40000, &dst);
+	r = bind(ln, &dst.sa, dst.len);
+	ASSERT_EQ(r, 0) TH_LOG("bind(<ip_one>:40000)");
+
+	r = listen(ln, 1);
+	ASSERT_EQ(r, 0) TH_LOG("listen");
+
+	/* Attempt to connect from <ip two>:40000 */
+	c = socket(v->af_two, SOCK_STREAM, 0);
+	ASSERT_GE(c, 0) TH_LOG("socket");
+
+	r = setsockopt(c, SOL_IP, IP_BIND_ADDRESS_NO_PORT, &ONE, sizeof(ONE));
+	ASSERT_EQ(r, 0) TH_LOG("setsockopt(IP_BIND_ADDRESS_NO_PORT)");
+
+	range = pack_port_range(40000, 40000);
+	r = setsockopt(c, SOL_IP, IP_LOCAL_PORT_RANGE, &range, sizeof(range));
+	ASSERT_EQ(r, 0) TH_LOG("setsockopt(IP_LOCAL_PORT_RANGE)");
+
+	make_inet_addr(v->af_two, v->ip_two, 0, &src);
+	r = bind(c, &src.sa, src.len);
+	ASSERT_EQ(r, 0) TH_LOG("bind(<ip_two>:40000)");
+
+	if (is_v4mapped(&dst))
+		v4mapped_to_ipv4(&dst);
+	r = connect(c, &dst.sa, dst.len);
+	EXPECT_EQ(r, -1) TH_LOG("connect(*:40000)");
+	EXPECT_EQ(errno, EADDRNOTAVAIL);
+}
+
+/* Demonstrate that a local IP and port can't be shared any more, even when the
+ * remote address is unique, after explicitly binding to that port.
+ */
+TEST(tcp_port_reuse__ip_port_conflict_with_unique_dst_after_bind)
+{
+	struct sockaddr_inet addr;
+	__close_fd int ln = -1;
+	__close_fd int c1 = -1;
+	__close_fd int c2 = -1;
+	__u32 range;
+	int s, r;
+
+	/* Listen on 0.0.0.0:30000 */
+	ln = socket(AF_INET, SOCK_STREAM, 0);
+	ASSERT_GE(ln, 0) TH_LOG("socket");
+
+	r = setsockopt(ln, SOL_SOCKET, SO_REUSEADDR, &ONE, sizeof(ONE));
+	ASSERT_EQ(r, 0) TH_LOG("setsockopt(SO_REUSEADDR)");
+
+	make_inet_addr(AF_INET, "0.0.0.0", 30000, &addr);
+	r = bind(ln, &addr.sa, addr.len);
+	ASSERT_EQ(r, 0) TH_LOG("bind(0.0.0.0:30000)");
+
+	r = listen(ln, 2);
+	ASSERT_EQ(r, 0) TH_LOG("listen");
+
+	/* Connect from 127.0.0.1:40000 to 127.1.1.1:30000 */
+	c1 = socket(AF_INET, SOCK_STREAM, 0);
+	ASSERT_GE(c1, 0) TH_LOG("socket");
+
+	range = pack_port_range(40000, 40000);
+	r = setsockopt(c1, SOL_IP, IP_LOCAL_PORT_RANGE, &range, sizeof(range));
+	ASSERT_EQ(r, 0) TH_LOG("setsockopt(IP_LOCAL_PORT_RANGE)");
+
+	make_inet_addr(AF_INET, "127.1.1.1", 30000, &addr);
+	r = connect(c1, &addr.sa, addr.len);
+	ASSERT_EQ(r, 0) TH_LOG("connect(127.1.1.1:30000)");
+	ASSERT_EQ(get_sock_port(c1), 40000);
+
+	/* Block the port. Bind to 127.9.9.9:40000 and unbind immediately */
+	s = socket(AF_INET, SOCK_STREAM, 0);
+	ASSERT_GE(s, 0) TH_LOG("socket");
+
+	r = setsockopt(s, SOL_SOCKET, SO_REUSEADDR, &ONE, sizeof(ONE));
+	ASSERT_EQ(r, 0) TH_LOG("setsockopt(SO_REUSEADDR)");
+
+	make_inet_addr(AF_INET, "127.9.9.9", 40000, &addr);
+	r = bind(s, &addr.sa, addr.len);
+	ASSERT_EQ(r, 0) TH_LOG("bind(127.9.9.9:40000)");
+
+	r = close(s);
+	ASSERT_EQ(r, 0) TH_LOG("close");
+
+	/* Connect from 127.0.0.1:40000 to 127.2.2.2:30000 */
+	c2 = socket(AF_INET, SOCK_STREAM, 0);
+	ASSERT_GE(c2, 0) TH_LOG("socket");
+
+	range = pack_port_range(40000, 40000);
+	r = setsockopt(c2, SOL_IP, IP_LOCAL_PORT_RANGE, &range, sizeof(range));
+	ASSERT_EQ(r, 0) TH_LOG("setsockopt(IP_LOCAL_PORT_RANGE)");
+
+	make_inet_addr(AF_INET, "127.2.2.2", 30000, &addr);
+	r = connect(c2, &addr.sa, addr.len);
+	EXPECT_EQ(r, -1) TH_LOG("connect(127.1.1.1:30000)");
+	EXPECT_EQ(errno, EADDRNOTAVAIL);
+}
+
 TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/net/ip_local_port_range.sh b/tools/testing/selftests/net/ip_local_port_range.sh
index 4ff746db1256..3fc151545b2d 100755
--- a/tools/testing/selftests/net/ip_local_port_range.sh
+++ b/tools/testing/selftests/net/ip_local_port_range.sh
@@ -1,7 +1,11 @@
-#!/bin/sh
+#!/bin/bash
 # SPDX-License-Identifier: GPL-2.0
 
-./in_netns.sh \
-  sh -c 'sysctl -q -w net.mptcp.enabled=1 && \
-         sysctl -q -w net.ipv4.ip_local_port_range="40000 49999" && \
-         ./ip_local_port_range'
+./in_netns.sh sh <(cat <<-EOF
+        sysctl -q -w net.mptcp.enabled=1
+        sysctl -q -w net.ipv4.ip_local_port_range="40000 49999"
+        ip -6 addr add dev lo 2001:db8::1/32 nodad
+        ip -6 addr add dev lo 2001:db8::2/32 nodad
+        exec ./ip_local_port_range
+EOF
+)

-- 
2.43.0


