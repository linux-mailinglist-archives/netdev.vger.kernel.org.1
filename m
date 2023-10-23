Return-Path: <netdev+bounces-43593-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 028E27D3FC7
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 21:04:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0B85281256
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 19:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91E221A05;
	Mon, 23 Oct 2023 19:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="fm2ylfth"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2912D219F4
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 19:04:31 +0000 (UTC)
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB34398
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 12:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1698087871; x=1729623871;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cQVITcz0smFC86rguqXPZJWNLu5B+BO0Jwf4ae6UYHk=;
  b=fm2ylfthcERvzYQ8qBks6d8ECBziEzEI0gotvzPig++yq0WOIy1+XEkc
   4qTpPBB94NnPVERDJPHASV8RmClpY6+BwQNyXWUj0AEEjul1wH32/eQ+o
   1Ykj3u4WXUgYCVJv9/AjT9mZeBWMfHiPAUdzxG503LVmshAhG9r60TAPh
   o=;
X-IronPort-AV: E=Sophos;i="6.03,246,1694736000"; 
   d="scan'208";a="363570122"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-b538c141.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 19:04:25 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan2.iad.amazon.com [10.32.235.34])
	by email-inbound-relay-iad-1e-m6i4x-b538c141.us-east-1.amazon.com (Postfix) with ESMTPS id 6328BA0F78;
	Mon, 23 Oct 2023 19:04:22 +0000 (UTC)
Received: from EX19MTAUWC002.ant.amazon.com [10.0.7.35:63013]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.12.125:2525] with esmtp (Farcaster)
 id c7c4d90e-b046-485d-ac48-50581f788ef7; Mon, 23 Oct 2023 19:04:21 +0000 (UTC)
X-Farcaster-Flow-ID: c7c4d90e-b046-485d-ac48-50581f788ef7
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Mon, 23 Oct 2023 19:04:21 +0000
Received: from 88665a182662.ant.amazon.com (10.119.77.134) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.39;
 Mon, 23 Oct 2023 19:04:18 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Coco Li <lixiaoyan@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 03/12] tcp: Save v4 address as v4-mapped-v6 in inet_bind2_bucket.v6_rcv_saddr.
Date: Mon, 23 Oct 2023 12:02:46 -0700
Message-ID: <20231023190255.39190-4-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231023190255.39190-1-kuniyu@amazon.com>
References: <20231023190255.39190-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.119.77.134]
X-ClientProxiedBy: EX19D037UWC003.ant.amazon.com (10.13.139.231) To
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
index 63032522c5d7..58900565c6ed 100644
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


