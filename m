Return-Path: <netdev+bounces-56765-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E1E6810C5E
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 09:25:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0567B1F2116B
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 08:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47D01DDDC;
	Wed, 13 Dec 2023 08:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="FJfK6cQA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED4E193
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 00:25:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1702455948; x=1733991948;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CAR5bGtYHiLYsd58D0LlZ4eNldfSEgu0pG8NSmLjyKA=;
  b=FJfK6cQA/h/O/Qr5vk3J9mGR6YZ3VbNyrAdrOYh5NaEL+mbQe2RCwvKC
   Oj25CBdmTReZRpYNdtou3OPJ5Yd/k55t+DIs6SlW9rDhir9P57sNBomNW
   wMVLaD/fd5RgEdx6d/2PjanJSZVBFmS/KSHytq11srbPuMqQt1SkKOpef
   k=;
X-IronPort-AV: E=Sophos;i="6.04,272,1695686400"; 
   d="scan'208";a="600300657"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-b538c141.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 08:25:41 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan2.iad.amazon.com [10.32.235.34])
	by email-inbound-relay-iad-1e-m6i4x-b538c141.us-east-1.amazon.com (Postfix) with ESMTPS id 3742EA0BD8;
	Wed, 13 Dec 2023 08:25:38 +0000 (UTC)
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:63826]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.54.233:2525] with esmtp (Farcaster)
 id 0d3bddd0-9f22-445d-9eb5-55a71bce8996; Wed, 13 Dec 2023 08:25:38 +0000 (UTC)
X-Farcaster-Flow-ID: 0d3bddd0-9f22-445d-9eb5-55a71bce8996
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 13 Dec 2023 08:25:37 +0000
Received: from 88665a182662.ant.amazon.com (10.119.5.2) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.40;
 Wed, 13 Dec 2023 08:25:34 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 11/12] tcp: Link sk and twsk to tb2->owners using skc_bind_node.
Date: Wed, 13 Dec 2023 17:20:28 +0900
Message-ID: <20231213082029.35149-12-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D045UWA002.ant.amazon.com (10.13.139.12) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

Now we can use sk_bind_node/tw_bind_node for bhash2, which means
we need not link TIME_WAIT sockets separately.

The dead code and sk_bind2_node will be removed in the next patch.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/net/sock.h              | 10 ----------
 net/ipv4/inet_connection_sock.c |  4 ++--
 net/ipv4/inet_diag.c            |  2 +-
 net/ipv4/inet_hashtables.c      |  8 ++++----
 net/ipv4/inet_timewait_sock.c   | 11 ++---------
 5 files changed, 9 insertions(+), 26 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 1d6931caf0c3..e0de49533361 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -873,16 +873,6 @@ static inline void sk_add_bind_node(struct sock *sk,
 	hlist_add_head(&sk->sk_bind_node, list);
 }
 
-static inline void __sk_del_bind2_node(struct sock *sk)
-{
-	__hlist_del(&sk->sk_bind2_node);
-}
-
-static inline void sk_add_bind2_node(struct sock *sk, struct hlist_head *list)
-{
-	hlist_add_head(&sk->sk_bind2_node, list);
-}
-
 #define sk_for_each(__sk, list) \
 	hlist_for_each_entry(__sk, list, sk_node)
 #define sk_for_each_rcu(__sk, list) \
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 5f641e5dff55..35ce1decc47a 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -208,7 +208,7 @@ static bool inet_bhash2_conflict(const struct sock *sk,
 	struct inet_timewait_sock *tw2;
 	struct sock *sk2;
 
-	sk_for_each_bound_bhash2(sk2, &tb2->owners) {
+	sk_for_each_bound(sk2, &tb2->owners) {
 		if (__inet_bhash2_conflict(sk, sk2, sk_uid, relax,
 					   reuseport_cb_ok, reuseport_ok))
 			return true;
@@ -227,7 +227,7 @@ static bool inet_bhash2_conflict(const struct sock *sk,
 
 #define sk_for_each_bound_bhash(__sk, __tb2, __tb)			\
 	hlist_for_each_entry(__tb2, &(__tb)->bhash2, bhash_node)	\
-		sk_for_each_bound_bhash2(sk2, &(__tb2)->owners)
+		sk_for_each_bound(sk2, &(__tb2)->owners)
 
 #define twsk_for_each_bound_bhash(__sk, __tb2, __tb)			\
 	hlist_for_each_entry(__tb2, &(__tb)->bhash2, bhash_node)	\
diff --git a/net/ipv4/inet_diag.c b/net/ipv4/inet_diag.c
index 46b13962ad02..8e6b6aa0579e 100644
--- a/net/ipv4/inet_diag.c
+++ b/net/ipv4/inet_diag.c
@@ -1104,7 +1104,7 @@ void inet_diag_dump_icsk(struct inet_hashinfo *hashinfo, struct sk_buff *skb,
 				if (!net_eq(ib2_net(tb2), net))
 					continue;
 
-				sk_for_each_bound_bhash2(sk, &tb2->owners) {
+				sk_for_each_bound(sk, &tb2->owners) {
 					struct inet_sock *inet = inet_sk(sk);
 
 					if (num < s_num)
diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index 7a78b8691365..a6652104b70e 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -169,8 +169,8 @@ void inet_bind_hash(struct sock *sk, struct inet_bind_bucket *tb,
 {
 	inet_sk(sk)->inet_num = port;
 	inet_csk(sk)->icsk_bind_hash = tb;
-	sk_add_bind2_node(sk, &tb2->owners);
 	inet_csk(sk)->icsk_bind2_hash = tb2;
+	sk_add_bind_node(sk, &tb2->owners);
 }
 
 /*
@@ -197,7 +197,7 @@ static void __inet_put_port(struct sock *sk)
 	if (inet_csk(sk)->icsk_bind2_hash) {
 		struct inet_bind2_bucket *tb2 = inet_csk(sk)->icsk_bind2_hash;
 
-		__sk_del_bind2_node(sk);
+		__sk_del_bind_node(sk);
 		inet_csk(sk)->icsk_bind2_hash = NULL;
 		inet_bind2_bucket_destroy(hashinfo->bind2_bucket_cachep, tb2);
 	}
@@ -937,7 +937,7 @@ static int __inet_bhash2_update_saddr(struct sock *sk, void *saddr, int family,
 	spin_lock_bh(&head->lock);
 
 	spin_lock(&head2->lock);
-	__sk_del_bind2_node(sk);
+	__sk_del_bind_node(sk);
 	inet_bind2_bucket_destroy(hinfo->bind2_bucket_cachep, inet_csk(sk)->icsk_bind2_hash);
 	spin_unlock(&head2->lock);
 
@@ -954,8 +954,8 @@ static int __inet_bhash2_update_saddr(struct sock *sk, void *saddr, int family,
 		tb2 = new_tb2;
 		inet_bind2_bucket_init(tb2, net, head2, inet_csk(sk)->icsk_bind_hash, sk);
 	}
-	sk_add_bind2_node(sk, &tb2->owners);
 	inet_csk(sk)->icsk_bind2_hash = tb2;
+	sk_add_bind_node(sk, &tb2->owners);
 	spin_unlock(&head2->lock);
 
 	spin_unlock_bh(&head->lock);
diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_sock.c
index 547583a87bd3..5befa4de5b24 100644
--- a/net/ipv4/inet_timewait_sock.c
+++ b/net/ipv4/inet_timewait_sock.c
@@ -35,9 +35,8 @@ void inet_twsk_bind_unhash(struct inet_timewait_sock *tw,
 	if (!tb)
 		return;
 
+	__sk_del_bind_node((struct sock *)tw);
 	tw->tw_tb = NULL;
-
-	__hlist_del(&tw->tw_bind2_node);
 	tw->tw_tb2 = NULL;
 	inet_bind2_bucket_destroy(hashinfo->bind2_bucket_cachep, tb2);
 	inet_bind_bucket_destroy(hashinfo->bind_bucket_cachep, tb);
@@ -93,12 +92,6 @@ static void inet_twsk_add_node_rcu(struct inet_timewait_sock *tw,
 	hlist_nulls_add_head_rcu(&tw->tw_node, list);
 }
 
-static void inet_twsk_add_bind2_node(struct inet_timewait_sock *tw,
-				     struct hlist_head *list)
-{
-	hlist_add_head(&tw->tw_bind2_node, list);
-}
-
 /*
  * Enter the time wait state. This is called with locally disabled BH.
  * Essentially we whip up a timewait bucket, copy the relevant info into it
@@ -129,7 +122,7 @@ void inet_twsk_hashdance(struct inet_timewait_sock *tw, struct sock *sk,
 
 	tw->tw_tb2 = icsk->icsk_bind2_hash;
 	WARN_ON(!icsk->icsk_bind2_hash);
-	inet_twsk_add_bind2_node(tw, &tw->tw_tb2->deathrow);
+	sk_add_bind_node((struct sock *)tw, &tw->tw_tb2->owners);
 
 	spin_unlock(&bhead2->lock);
 	spin_unlock(&bhead->lock);
-- 
2.30.2


