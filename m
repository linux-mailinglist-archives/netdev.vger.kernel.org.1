Return-Path: <netdev+bounces-56756-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E0BC810C45
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 09:21:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D3B1B20B65
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 08:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECDDF1D69B;
	Wed, 13 Dec 2023 08:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="k+kAgeOU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 833C98E
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 00:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1702455705; x=1733991705;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=T7AL7TWFv0dHkFZBawgjuTBt9SkrosdOWVyPH2fYQ9w=;
  b=k+kAgeOUU2APXe271Mb0i1p0sClbv9A30b9Zw0ZIOckCk2b/DuNQWlKd
   tU4J45fy9hPLR7Ad+iDiio8CeM3qQT7Q4gCpqsoqMsyIaET85rRE/xpOS
   cNOyeZVLouwFvit0XPU+IBRvUCRSDq85dI1rAHDsCyNplB6rviXmpdY//
   E=;
X-IronPort-AV: E=Sophos;i="6.04,272,1695686400"; 
   d="scan'208";a="171649529"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-617e30c2.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 08:21:43 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan2.iad.amazon.com [10.32.235.34])
	by email-inbound-relay-iad-1a-m6i4x-617e30c2.us-east-1.amazon.com (Postfix) with ESMTPS id E30DA634EA;
	Wed, 13 Dec 2023 08:21:40 +0000 (UTC)
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:29840]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.18.147:2525] with esmtp (Farcaster)
 id a9e50f2e-4afd-4c0c-9697-47858f873806; Wed, 13 Dec 2023 08:21:39 +0000 (UTC)
X-Farcaster-Flow-ID: a9e50f2e-4afd-4c0c-9697-47858f873806
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 13 Dec 2023 08:21:39 +0000
Received: from 88665a182662.ant.amazon.com (10.119.5.2) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.40;
 Wed, 13 Dec 2023 08:21:35 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 02/12] tcp: Rearrange tests in inet_bind2_bucket_(addr_match|match_addr_any)().
Date: Wed, 13 Dec 2023 17:20:19 +0900
Message-ID: <20231213082029.35149-3-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231213082029.35149-1-kuniyu@amazon.com>
References: <20231213082029.35149-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D037UWC002.ant.amazon.com (10.13.139.250) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

The protocol family tests in inet_bind2_bucket_addr_match() and
inet_bind2_bucket_match_addr_any() are ordered as follows.

  if (sk->sk_family != tb2->family)
  else if (sk->sk_family == AF_INET6)
  else

This patch rearranges them so that AF_INET6 socket is handled first
to make the following patch tidy, where tb2->family will be removed.

  if (sk->sk_family == AF_INET6)
  else if (tb2->family == AF_INET6)
  else

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv4/inet_hashtables.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index 8fb58ee32a25..d82b701ad65e 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -149,18 +149,17 @@ static bool inet_bind2_bucket_addr_match(const struct inet_bind2_bucket *tb2,
 					 const struct sock *sk)
 {
 #if IS_ENABLED(CONFIG_IPV6)
-	if (sk->sk_family != tb2->family) {
-		if (sk->sk_family == AF_INET)
-			return ipv6_addr_v4mapped(&tb2->v6_rcv_saddr) &&
-				tb2->v6_rcv_saddr.s6_addr32[3] == sk->sk_rcv_saddr;
+	if (sk->sk_family == AF_INET6) {
+		if (tb2->family == AF_INET6)
+			return ipv6_addr_equal(&tb2->v6_rcv_saddr, &sk->sk_v6_rcv_saddr);
 
 		return ipv6_addr_v4mapped(&sk->sk_v6_rcv_saddr) &&
 			sk->sk_v6_rcv_saddr.s6_addr32[3] == tb2->rcv_saddr;
 	}
 
-	if (sk->sk_family == AF_INET6)
-		return ipv6_addr_equal(&tb2->v6_rcv_saddr,
-				       &sk->sk_v6_rcv_saddr);
+	if (tb2->family == AF_INET6)
+		return ipv6_addr_v4mapped(&tb2->v6_rcv_saddr) &&
+			tb2->v6_rcv_saddr.s6_addr32[3] == sk->sk_rcv_saddr;
 #endif
 	return tb2->rcv_saddr == sk->sk_rcv_saddr;
 }
@@ -836,17 +835,17 @@ bool inet_bind2_bucket_match_addr_any(const struct inet_bind2_bucket *tb, const
 		return false;
 
 #if IS_ENABLED(CONFIG_IPV6)
-	if (sk->sk_family != tb->family) {
-		if (sk->sk_family == AF_INET)
-			return ipv6_addr_any(&tb->v6_rcv_saddr) ||
-				ipv6_addr_v4mapped_any(&tb->v6_rcv_saddr);
+	if (sk->sk_family == AF_INET6) {
+		if (tb->family == AF_INET6)
+			return ipv6_addr_any(&tb->v6_rcv_saddr);
 
 		return ipv6_addr_v4mapped(&sk->sk_v6_rcv_saddr) &&
 			tb->rcv_saddr == 0;
 	}
 
-	if (sk->sk_family == AF_INET6)
-		return ipv6_addr_any(&tb->v6_rcv_saddr);
+	if (tb->family == AF_INET6)
+		return ipv6_addr_any(&tb->v6_rcv_saddr) ||
+			ipv6_addr_v4mapped_any(&tb->v6_rcv_saddr);
 #endif
 	return tb->rcv_saddr == 0;
 }
-- 
2.30.2


