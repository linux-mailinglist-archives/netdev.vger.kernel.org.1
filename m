Return-Path: <netdev+bounces-81721-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A46DD88AE8D
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 19:38:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BF821F3A7F1
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 18:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC2996D1A1;
	Mon, 25 Mar 2024 18:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="uddyJoAD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147756BFA5
	for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 18:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711390872; cv=none; b=oCRmA+PCyYZsS1gWqhnXda5tcGkuxZEGYwUHsriDtBpO++wZKy4CJ36fP2+O+Y2O7FzHeQSrzOmpeDm3jtZHSVHZ6KfSXRwmVXkxYTjIzgUpQLimJ3nuwGdP9Kj5S0eV5QPYLG18idUiZu/kOv4hovMB8uxD7JWYMPgDbESvvyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711390872; c=relaxed/simple;
	bh=B2To9Vd/ev2bj+yFI9DaRe7appQcDYekr3mIfLrgtj8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZJQ5jaFlTSiogiT0bajjc98fVp/UwhWF3f1SKOjkAWAXViFBRpwLMneTPNKnTZRWCs1RU98rxtzC33HT+i6uZajDcau6Ocf6j96iEAA5S+3+v+d2LfRGUbCknXo26VwYUTJ0hnxgo8ARgIL6d8P0ugNTn0KR8lGWByn57/n+JjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=uddyJoAD; arc=none smtp.client-ip=207.171.188.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1711390871; x=1742926871;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jMcOz+cfn/yo8iz6rodYGYMyuIDasv7xdItNyPg+dpo=;
  b=uddyJoADNq4ERyi0n6FKUOABIrvfdaHL9aSFJFd2Lkn0gdz2i5zn0dKv
   K0hXV5otkbZjNXbokqEG+4mwwlLq+KL9HrBqNitKQ4CZzTeS6MQdR24WX
   Jl2HAqcB641zI+HX7V+WhI7V+RnSbRLx0YE2zz2D58TYWGOJ5ICKHYQAU
   g=;
X-IronPort-AV: E=Sophos;i="6.07,153,1708387200"; 
   d="scan'208";a="714254339"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 18:21:04 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.7.35:51972]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.58.246:2525] with esmtp (Farcaster)
 id e210f4a7-9964-444c-bf13-82b8190e0414; Mon, 25 Mar 2024 18:21:03 +0000 (UTC)
X-Farcaster-Flow-ID: e210f4a7-9964-444c-bf13-82b8190e0414
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 25 Mar 2024 18:21:03 +0000
Received: from 88665a182662.ant.amazon.com (10.187.171.62) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 25 Mar 2024 18:21:00 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Joanne Koong <joannelkoong@gmail.com>, Jianguo Wu <wujianguo106@163.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net 3/8] selftest: tcp: Make bind() selftest flexible.
Date: Mon, 25 Mar 2024 11:19:18 -0700
Message-ID: <20240325181923.48769-4-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240325181923.48769-1-kuniyu@amazon.com>
References: <20240325181923.48769-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWB004.ant.amazon.com (10.13.139.150) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Currently, bind_wildcard.c tests only (IPv4, IPv6) pairs, but we will
add more tests for the same protocol pairs.

This patch makes it possible by changing the address pointer to void.

No functional changes are intended.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 tools/testing/selftests/net/bind_wildcard.c | 92 +++++++++++++--------
 1 file changed, 58 insertions(+), 34 deletions(-)

diff --git a/tools/testing/selftests/net/bind_wildcard.c b/tools/testing/selftests/net/bind_wildcard.c
index a2662348cdb1..d65c3bb6ba13 100644
--- a/tools/testing/selftests/net/bind_wildcard.c
+++ b/tools/testing/selftests/net/bind_wildcard.c
@@ -6,7 +6,9 @@
 
 #include "../kselftest_harness.h"
 
-struct in6_addr in6addr_v4mapped_any = {
+static const __u32 in4addr_any = INADDR_ANY;
+static const __u32 in4addr_loopback = INADDR_LOOPBACK;
+static const struct in6_addr in6addr_v4mapped_any = {
 	.s6_addr = {
 		0, 0, 0, 0,
 		0, 0, 0, 0,
@@ -14,8 +16,7 @@ struct in6_addr in6addr_v4mapped_any = {
 		0, 0, 0, 0
 	}
 };
-
-struct in6_addr in6addr_v4mapped_loopback = {
+static const struct in6_addr in6addr_v4mapped_loopback = {
 	.s6_addr = {
 		0, 0, 0, 0,
 		0, 0, 0, 0,
@@ -26,82 +27,105 @@ struct in6_addr in6addr_v4mapped_loopback = {
 
 FIXTURE(bind_wildcard)
 {
-	struct sockaddr_in addr4;
-	struct sockaddr_in6 addr6;
+	socklen_t addrlen[2];
+	union {
+		struct sockaddr addr;
+		struct sockaddr_in addr4;
+		struct sockaddr_in6 addr6;
+	} addr[2];
 };
 
 FIXTURE_VARIANT(bind_wildcard)
 {
-	const __u32 addr4_const;
-	const struct in6_addr *addr6_const;
+	sa_family_t family[2];
+	const void *addr[2];
 	int expected_errno;
 };
 
 FIXTURE_VARIANT_ADD(bind_wildcard, v4_any_v6_any)
 {
-	.addr4_const = INADDR_ANY,
-	.addr6_const = &in6addr_any,
+	.family = {AF_INET, AF_INET6},
+	.addr = {&in4addr_any, &in6addr_any},
 	.expected_errno = EADDRINUSE,
 };
 
 FIXTURE_VARIANT_ADD(bind_wildcard, v4_any_v6_local)
 {
-	.addr4_const = INADDR_ANY,
-	.addr6_const = &in6addr_loopback,
+	.family = {AF_INET, AF_INET6},
+	.addr = {&in4addr_any, &in6addr_loopback},
 	.expected_errno = 0,
 };
 
 FIXTURE_VARIANT_ADD(bind_wildcard, v4_any_v6_v4mapped_any)
 {
-	.addr4_const = INADDR_ANY,
-	.addr6_const = &in6addr_v4mapped_any,
+	.family = {AF_INET, AF_INET6},
+	.addr = {&in4addr_any, &in6addr_v4mapped_any},
 	.expected_errno = EADDRINUSE,
 };
 
 FIXTURE_VARIANT_ADD(bind_wildcard, v4_any_v6_v4mapped_local)
 {
-	.addr4_const = INADDR_ANY,
-	.addr6_const = &in6addr_v4mapped_loopback,
+	.family = {AF_INET, AF_INET6},
+	.addr = {&in4addr_any, &in6addr_v4mapped_loopback},
 	.expected_errno = EADDRINUSE,
 };
 
 FIXTURE_VARIANT_ADD(bind_wildcard, v4_local_v6_any)
 {
-	.addr4_const = INADDR_LOOPBACK,
-	.addr6_const = &in6addr_any,
+	.family = {AF_INET, AF_INET6},
+	.addr = {&in4addr_loopback, &in6addr_any},
 	.expected_errno = EADDRINUSE,
 };
 
 FIXTURE_VARIANT_ADD(bind_wildcard, v4_local_v6_local)
 {
-	.addr4_const = INADDR_LOOPBACK,
-	.addr6_const = &in6addr_loopback,
+	.family = {AF_INET, AF_INET6},
+	.addr = {&in4addr_loopback, &in6addr_loopback},
 	.expected_errno = 0,
 };
 
 FIXTURE_VARIANT_ADD(bind_wildcard, v4_local_v6_v4mapped_any)
 {
-	.addr4_const = INADDR_LOOPBACK,
-	.addr6_const = &in6addr_v4mapped_any,
+	.family = {AF_INET, AF_INET6},
+	.addr = {&in4addr_loopback, &in6addr_v4mapped_any},
 	.expected_errno = EADDRINUSE,
 };
 
 FIXTURE_VARIANT_ADD(bind_wildcard, v4_local_v6_v4mapped_local)
 {
-	.addr4_const = INADDR_LOOPBACK,
-	.addr6_const = &in6addr_v4mapped_loopback,
+	.family = {AF_INET, AF_INET6},
+	.addr = {&in4addr_loopback, &in6addr_v4mapped_loopback},
 	.expected_errno = EADDRINUSE,
 };
 
-FIXTURE_SETUP(bind_wildcard)
+static void setup_addr(FIXTURE_DATA(bind_wildcard) *self, int i,
+		       int family, const void *addr_const)
 {
-	self->addr4.sin_family = AF_INET;
-	self->addr4.sin_port = htons(0);
-	self->addr4.sin_addr.s_addr = htonl(variant->addr4_const);
+	if (family == AF_INET) {
+		struct sockaddr_in *addr4 = &self->addr[i].addr4;
+		const __u32 *addr4_const = addr_const;
+
+		addr4->sin_family = AF_INET;
+		addr4->sin_port = htons(0);
+		addr4->sin_addr.s_addr = htonl(*addr4_const);
+
+		self->addrlen[i] = sizeof(struct sockaddr_in);
+	} else {
+		struct sockaddr_in6 *addr6 = &self->addr[i].addr6;
+		const struct in6_addr *addr6_const = addr_const;
+
+		addr6->sin6_family = AF_INET6;
+		addr6->sin6_port = htons(0);
+		addr6->sin6_addr = *addr6_const;
 
-	self->addr6.sin6_family = AF_INET6;
-	self->addr6.sin6_port = htons(0);
-	self->addr6.sin6_addr = *variant->addr6_const;
+		self->addrlen[i] = sizeof(struct sockaddr_in6);
+	}
+}
+
+FIXTURE_SETUP(bind_wildcard)
+{
+	setup_addr(self, 0, variant->family[0], variant->addr[0]);
+	setup_addr(self, 1, variant->family[1], variant->addr[1]);
 }
 
 FIXTURE_TEARDOWN(bind_wildcard)
@@ -146,15 +170,15 @@ void bind_sockets(struct __test_metadata *_metadata,
 TEST_F(bind_wildcard, v4_v6)
 {
 	bind_sockets(_metadata, self, variant->expected_errno,
-		     (struct sockaddr *)&self->addr4, sizeof(self->addr4),
-		     (struct sockaddr *)&self->addr6, sizeof(self->addr6));
+		     &self->addr[0].addr, self->addrlen[0],
+		     &self->addr[1].addr, self->addrlen[1]);
 }
 
 TEST_F(bind_wildcard, v6_v4)
 {
 	bind_sockets(_metadata, self, variant->expected_errno,
-		     (struct sockaddr *)&self->addr6, sizeof(self->addr6),
-		     (struct sockaddr *)&self->addr4, sizeof(self->addr4));
+		     &self->addr[1].addr, self->addrlen[1],
+		     &self->addr[0].addr, self->addrlen[0]);
 }
 
 TEST_HARNESS_MAIN
-- 
2.30.2


