Return-Path: <netdev+bounces-58725-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A3918817EB4
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 01:20:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14FA71F244F5
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 00:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18017368;
	Tue, 19 Dec 2023 00:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="kS7/1la2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5352D188
	for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 00:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1702945210; x=1734481210;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qOtyQBThYUvgglpieYFQTXCwhbvOSAhMpcmJok5BNmw=;
  b=kS7/1la2yodiSi20h6s5HL+B9Sf2Z4G8b+PSDbq6ZudCiHBR7lcBovMD
   2oYupPsWEUBn9fCkMBCMOvyoHn980ysgEbypumBcfqaLyY6u3qIM2r2GF
   N31AbuvCzZpr/oOKbZ1zT8uS6wlUtVlNG5laaJ9WdaANY0bYPtdXgTur8
   Y=;
X-IronPort-AV: E=Sophos;i="6.04,286,1695686400"; 
   d="scan'208";a="377241808"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-a893d89c.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 00:20:07 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan2.pdx.amazon.com [10.39.38.66])
	by email-inbound-relay-pdx-2b-m6i4x-a893d89c.us-west-2.amazon.com (Postfix) with ESMTPS id 89DC340D55;
	Tue, 19 Dec 2023 00:20:06 +0000 (UTC)
Received: from EX19MTAUWB001.ant.amazon.com [10.0.7.35:9596]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.19.109:2525] with esmtp (Farcaster)
 id 7d67f458-7826-4ea2-ba89-b6e1b2d24bbd; Tue, 19 Dec 2023 00:20:06 +0000 (UTC)
X-Farcaster-Flow-ID: 7d67f458-7826-4ea2-ba89-b6e1b2d24bbd
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 19 Dec 2023 00:20:05 +0000
Received: from 88665a182662.ant.amazon.com (10.118.248.48) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 19 Dec 2023 00:20:02 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH RESEND v2 net-next 03/12] tcp: Save v4 address as v4-mapped-v6 in inet_bind2_bucket.v6_rcv_saddr.
Date: Tue, 19 Dec 2023 09:18:24 +0900
Message-ID: <20231219001833.10122-4-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231219001833.10122-1-kuniyu@amazon.com>
References: <20231219001833.10122-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWA003.ant.amazon.com (10.13.139.44) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

In bhash2, IPv4/IPv6 addresses are saved in two union members,
which complicate address checks in inet_bind2_bucket_addr_match()
and inet_bind2_bucket_match_addr_any() considering uninitialised
memory and v4-mapped-v6 conflicts.

Let's simplify that by saving IPv4 address as v4-mapped-v6 address
and defining tb2.rcv_saddr as tb2.v6_rcv_saddr.s6_addr32[3].

Then, we can compare v6 address as is, and after checking v4-mapped-v6,
we can compare v4 address easily.  Also, we can remove tb2->family.

Note these functions will be further refactored in the next patch.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
 include/net/inet_hashtables.h | 11 ++++-------
 include/net/ipv6.h            |  5 -----
 net/ipv4/inet_hashtables.c    | 34 +++++++++++++++++-----------------
 3 files changed, 21 insertions(+), 29 deletions(-)

diff --git a/include/net/inet_hashtables.h b/include/net/inet_hashtables.h
index 3ecfeadbfa06..171cc235d045 100644
--- a/include/net/inet_hashtables.h
+++ b/include/net/inet_hashtables.h
@@ -96,14 +96,11 @@ struct inet_bind2_bucket {
 	int			l3mdev;
 	unsigned short		port;
 #if IS_ENABLED(CONFIG_IPV6)
-	unsigned short		family;
-#endif
-	union {
-#if IS_ENABLED(CONFIG_IPV6)
-		struct in6_addr		v6_rcv_saddr;
+	struct in6_addr		v6_rcv_saddr;
+#define rcv_saddr		v6_rcv_saddr.s6_addr32[3]
+#else
+	__be32			rcv_saddr;
 #endif
-		__be32			rcv_saddr;
-	};
 	/* Node in the bhash2 inet_bind_hashbucket chain */
 	struct hlist_node	node;
 	/* List of sockets hashed to this bucket */
diff --git a/include/net/ipv6.h b/include/net/ipv6.h
index 78d38dd88aba..cf25ea21d770 100644
--- a/include/net/ipv6.h
+++ b/include/net/ipv6.h
@@ -784,11 +784,6 @@ static inline bool ipv6_addr_v4mapped(const struct in6_addr *a)
 					cpu_to_be32(0x0000ffff))) == 0UL;
 }
 
-static inline bool ipv6_addr_v4mapped_any(const struct in6_addr *a)
-{
-	return ipv6_addr_v4mapped(a) && ipv4_is_zeronet(a->s6_addr32[3]);
-}
-
 static inline bool ipv6_addr_v4mapped_loopback(const struct in6_addr *a)
 {
 	return ipv6_addr_v4mapped(a) && ipv4_is_loopback(a->s6_addr32[3]);
diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index 896fcefc06c0..15594424e9f5 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -110,12 +110,13 @@ static void inet_bind2_bucket_init(struct inet_bind2_bucket *tb,
 	tb->l3mdev    = l3mdev;
 	tb->port      = port;
 #if IS_ENABLED(CONFIG_IPV6)
-	tb->family    = sk->sk_family;
 	if (sk->sk_family == AF_INET6)
 		tb->v6_rcv_saddr = sk->sk_v6_rcv_saddr;
 	else
+		ipv6_addr_set_v4mapped(sk->sk_rcv_saddr, &tb->v6_rcv_saddr);
+#else
+	tb->rcv_saddr = sk->sk_rcv_saddr;
 #endif
-		tb->rcv_saddr = sk->sk_rcv_saddr;
 	INIT_HLIST_HEAD(&tb->owners);
 	INIT_HLIST_HEAD(&tb->deathrow);
 	hlist_add_head(&tb->node, &head->chain);
@@ -149,17 +150,11 @@ static bool inet_bind2_bucket_addr_match(const struct inet_bind2_bucket *tb2,
 					 const struct sock *sk)
 {
 #if IS_ENABLED(CONFIG_IPV6)
-	if (sk->sk_family == AF_INET6) {
-		if (tb2->family == AF_INET6)
-			return ipv6_addr_equal(&tb2->v6_rcv_saddr, &sk->sk_v6_rcv_saddr);
-
-		return ipv6_addr_v4mapped(&sk->sk_v6_rcv_saddr) &&
-			sk->sk_v6_rcv_saddr.s6_addr32[3] == tb2->rcv_saddr;
-	}
+	if (sk->sk_family == AF_INET6)
+		return ipv6_addr_equal(&tb2->v6_rcv_saddr, &sk->sk_v6_rcv_saddr);
 
-	if (tb2->family == AF_INET6)
-		return ipv6_addr_v4mapped(&tb2->v6_rcv_saddr) &&
-			tb2->v6_rcv_saddr.s6_addr32[3] == sk->sk_rcv_saddr;
+	if (!ipv6_addr_v4mapped(&tb2->v6_rcv_saddr))
+		return false;
 #endif
 	return tb2->rcv_saddr == sk->sk_rcv_saddr;
 }
@@ -836,16 +831,21 @@ bool inet_bind2_bucket_match_addr_any(const struct inet_bind2_bucket *tb, const
 
 #if IS_ENABLED(CONFIG_IPV6)
 	if (sk->sk_family == AF_INET6) {
-		if (tb->family == AF_INET6)
-			return ipv6_addr_any(&tb->v6_rcv_saddr);
+		if (ipv6_addr_any(&tb->v6_rcv_saddr))
+			return true;
+
+		if (!ipv6_addr_v4mapped(&tb->v6_rcv_saddr))
+			return false;
 
 		return ipv6_addr_v4mapped(&sk->sk_v6_rcv_saddr) &&
 			tb->rcv_saddr == 0;
 	}
 
-	if (tb->family == AF_INET6)
-		return ipv6_addr_any(&tb->v6_rcv_saddr) ||
-			ipv6_addr_v4mapped_any(&tb->v6_rcv_saddr);
+	if (ipv6_addr_any(&tb->v6_rcv_saddr))
+		return true;
+
+	if (!ipv6_addr_v4mapped(&tb->v6_rcv_saddr))
+		return false;
 #endif
 	return tb->rcv_saddr == 0;
 }
-- 
2.30.2


