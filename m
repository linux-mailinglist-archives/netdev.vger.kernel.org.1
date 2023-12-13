Return-Path: <netdev+bounces-56757-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C0C810C46
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 09:22:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BC16B20B63
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 08:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77D671D6A1;
	Wed, 13 Dec 2023 08:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="J6iUBazQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73B208E
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 00:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1702455729; x=1733991729;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sPfRchpJr/X89w1/dTax5HzPR5TR6SQXEiwEaLPC018=;
  b=J6iUBazQf+4PiJf1neSj5lfymRp3v2c6MM8Apt2sjlX0LkLuLYBE0zp6
   3smpjfxCqu9E4xPJL8UGYhgJtnYNpbDdQyQd+JHITMuLCjIMZzoFZj0JN
   khxJo7vFziGfTmyP2MRGTVj+2i7ixpBbcvWlwGWjxX7zXoFK6IAL7e/P+
   I=;
X-IronPort-AV: E=Sophos;i="6.04,272,1695686400"; 
   d="scan'208";a="50424573"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-14781fa4.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 08:22:06 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan3.pdx.amazon.com [10.39.38.70])
	by email-inbound-relay-pdx-2b-m6i4x-14781fa4.us-west-2.amazon.com (Postfix) with ESMTPS id A5C871600C5;
	Wed, 13 Dec 2023 08:22:06 +0000 (UTC)
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:60042]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.11.243:2525] with esmtp (Farcaster)
 id c37656da-f1a8-499f-a920-39913a642d58; Wed, 13 Dec 2023 08:22:06 +0000 (UTC)
X-Farcaster-Flow-ID: c37656da-f1a8-499f-a920-39913a642d58
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 13 Dec 2023 08:22:05 +0000
Received: from 88665a182662.ant.amazon.com (10.119.5.2) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.40;
 Wed, 13 Dec 2023 08:22:02 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 03/12] tcp: Save v4 address as v4-mapped-v6 in inet_bind2_bucket.v6_rcv_saddr.
Date: Wed, 13 Dec 2023 17:20:20 +0900
Message-ID: <20231213082029.35149-4-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D035UWB004.ant.amazon.com (10.13.138.104) To
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
index d82b701ad65e..80d7c8f92d77 100644
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


