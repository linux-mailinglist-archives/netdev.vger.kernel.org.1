Return-Path: <netdev+bounces-201543-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2207AE9D39
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 14:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCBA2188F884
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 12:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26FB4275AE4;
	Thu, 26 Jun 2025 12:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="e3cO+YOx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9CE275870
	for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 12:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750939379; cv=none; b=G6YOXOmKjyYtFeLLWHdJm3f6RfV4EBzkaLGrIzUypPpPoZy37pB0DGrR5UGDY81b7ZLMbmiscTDXXFGYmSGsDQ7KwleS1m0gg3WWUXHyTrh9oLJ4NWaV/yORlnY0mrf439nZG0eKIq8wmIj578Vz7MG17n+PYuCRkNsRsZkel0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750939379; c=relaxed/simple;
	bh=PJ9PNTkJvSiJfT8M9NHwDmsrHLOkFUlLzjC6tuo+XIA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l61XhmU2l5qVYMjpyoNkJY1uicLmK/HZkMnSW828ApPCm+5TRvgs9zuKGQ8jXvX+fudXbGX4+207Y6H+wGF921QdByMvUlpLdQLpg8jMTT3nyBkSis8u85aFwTTF2k2oKlzIEpwI4rZcQEOxnERAJ7XQ69bMxcVA+ZbQo2mDTGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=e3cO+YOx; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ae0de0c03e9so62016666b.2
        for <netdev@vger.kernel.org>; Thu, 26 Jun 2025 05:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1750939375; x=1751544175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xHPaudebi42YUKzNDGzO0TOdLpcd9GftG9LHUF0H25c=;
        b=e3cO+YOxh5w1nVoUYEhLtSMb2RRZQW0hAaMXlqsZTggScLgvsTVOZaWA1/MG6mhlRz
         fVu4TvO9/4rlNeCigoQpXGp7LA9tpo1oxi/sOr8Som3yFERWTefbFosL3QJiVXrdj5by
         Nv1BNoVDbrkIp1RzOsmAL1cIftYsTZmcb99QKWByjxPKxKwaHOlWkJrJXsCxjt5zWBlM
         52BmHV6nP1xCZ8TXsngCEUJ+OLTWr1kuwi40cXlzG3yMh1QUoplwLeF/zANyE78ESlYL
         KR9vNFD6ActhJxMDys2rTYeFL1HQUf3iDIfUH261wNmQsuIakbuhWFZ0Ui1O4s0wek6V
         4lkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750939375; x=1751544175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xHPaudebi42YUKzNDGzO0TOdLpcd9GftG9LHUF0H25c=;
        b=ejdM/3eXL6goRAOJu1ZGmmcu307dEZ4e8zOgWIqOjQZXdRsMmEDSYV32xCikvBbJVy
         Nae1KQFo2TY2D2liqapAn4Rnmv2awb0cFxN+/G5s6QnDVD/d0PlfZLddDk/hWCZF5lUt
         QHNGLIOZ01ItOsOx1rUGvhsYiT214um6i3h4R+qUiz6R4Qr9hAFbIDlDtZBQgXxLLMQF
         JwA0WA9kvbm3rmyvaRqlpK/lOC0+iyPain0QvRChtiw/oBUq87u+ZSHY+nDiSyh1IpjE
         cKQD/idur1411L/CTeD7KddWxT2xqEOhTpAF/mU9f8/eC1IlEd5ZOSXK8cPJhWpjstSl
         FtBQ==
X-Gm-Message-State: AOJu0Yy7uJrcriXQ7561U3iVy+p5FU3uvjV6SpuFzD7lWRFRL+KIRXJd
	1bMJrQpllKefiNicyFbJ70XRq3dUZ7UThryyJ7F1PLhBGvectAdP97q9ZYSzqmCutf0=
X-Gm-Gg: ASbGncuDhNPopWCPk4W4Oy9Q0i/4S2FcFH9Z/LiLvAgN5T+4Yoon/YJfu1aiKdQ1Ro7
	iZGUZdrMRIrad/6REacYAT23XRj7/Onp1UOFp1CQnOkf1STOTPuobUo5ZsYI0R4j147QgOXuP9D
	NTiLN8I9vuC3tRLLnA3gQyu1nDqA3SOATKtLw0qRRY7bS0AwMgU8b1W9VIcJoIXgtbWzMTKAqBE
	YuDz5fmmQslUx/qHac7glpt2jtBSqVbYEidQXE7JDrV3xpjc+qIXoYdKvpSDrgmmC+uc2oz3whK
	sba1O/4yOTBky8nYgcSIPue51RVMHRcO/jUFEltSumOXvbBrLWeaAJU=
X-Google-Smtp-Source: AGHT+IFY3b7YsK7IsZM8qmTqDAjDLga9meZKqMoEJyO8BUDOwvF3f0ADBOUJqpbGATevA4yqs3lhxQ==
X-Received: by 2002:a17:907:7b85:b0:ae0:c477:880d with SMTP id a640c23a62f3a-ae0c4779491mr649236666b.4.1750939373965;
        Thu, 26 Jun 2025 05:02:53 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2432::39b:b5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae0a0aa1d27sm549235166b.76.2025.06.26.05.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 05:02:52 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>
Cc: netdev@vger.kernel.org,
	kernel-team@cloudflare.com,
	Lee Valentine <lvalentine@cloudflare.com>
Subject: [PATCH net-next 2/2] selftests/net: Cover port sharing scenarios with IP_LOCAL_PORT_RANGE
Date: Thu, 26 Jun 2025 14:02:46 +0200
Message-ID: <20250626120247.1255223-2-jakub@cloudflare.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250626120247.1255223-1-jakub@cloudflare.com>
References: <20250626120247.1255223-1-jakub@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
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
 .../selftests/net/ip_local_port_range.c       | 525 ++++++++++++++++++
 .../selftests/net/ip_local_port_range.sh      |  14 +-
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


