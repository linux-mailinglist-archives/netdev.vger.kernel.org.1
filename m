Return-Path: <netdev+bounces-56766-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C3B810C5F
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 09:26:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CBA91C209DD
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 08:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A3A1DFC3;
	Wed, 13 Dec 2023 08:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Cq5F851b"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD1FEDC
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 00:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1702455971; x=1733991971;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mB/0BdIk9aG+uEy8MftPRICImQUU3atwG2v8CIJ7owU=;
  b=Cq5F851beTkBa6rW6uJcEVu1sHOUl21ROSrx+k9wYuKxZFakAdfU1eUW
   gLSu9KhaLR9iShdFbpU6oZhTHDgqdYuhdtRcIieHLlVlkDlt8ZkD5UMDI
   GCUWSUzP75hhKVwYUtyf7ZGhoTyuoz6f2TR0Hf5lKX2Be1EBvicz3fto2
   w=;
X-IronPort-AV: E=Sophos;i="6.04,272,1695686400"; 
   d="scan'208";a="259363162"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-0aba4706.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 08:26:08 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan2.iad.amazon.com [10.32.235.34])
	by email-inbound-relay-iad-1e-m6i4x-0aba4706.us-east-1.amazon.com (Postfix) with ESMTPS id 742BAA26DA;
	Wed, 13 Dec 2023 08:26:05 +0000 (UTC)
Received: from EX19MTAUWA001.ant.amazon.com [10.0.7.35:20919]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.11.243:2525] with esmtp (Farcaster)
 id 5a3c2553-41eb-449b-ad04-5fe7eec5c1dc; Wed, 13 Dec 2023 08:26:04 +0000 (UTC)
X-Farcaster-Flow-ID: 5a3c2553-41eb-449b-ad04-5fe7eec5c1dc
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 13 Dec 2023 08:26:04 +0000
Received: from 88665a182662.ant.amazon.com (10.119.5.2) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 13 Dec 2023 08:26:00 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 12/12] tcp: Remove dead code and fields for bhash2.
Date: Wed, 13 Dec 2023 17:20:29 +0900
Message-ID: <20231213082029.35149-13-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D032UWA002.ant.amazon.com (10.13.139.81) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

Now all sockets including TIME_WAIT are linked to bhash2 using
sock_common.skc_bind_node.

We no longer use inet_bind2_bucket.deathrow, sock.sk_bind2_node,
and inet_timewait_sock.tw_bind2_node.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/net/inet_hashtables.h    |  4 ----
 include/net/inet_timewait_sock.h |  4 ----
 include/net/sock.h               |  4 ----
 net/ipv4/inet_connection_sock.c  | 21 ---------------------
 net/ipv4/inet_hashtables.c       |  3 +--
 5 files changed, 1 insertion(+), 35 deletions(-)

diff --git a/include/net/inet_hashtables.h b/include/net/inet_hashtables.h
index 98ba728aec08..7f1b38458743 100644
--- a/include/net/inet_hashtables.h
+++ b/include/net/inet_hashtables.h
@@ -107,10 +107,6 @@ struct inet_bind2_bucket {
 	struct hlist_node	bhash_node;
 	/* List of sockets hashed to this bucket */
 	struct hlist_head	owners;
-	/* bhash has twsk in owners, but bhash2 has twsk in
-	 * deathrow not to add a member in struct sock_common.
-	 */
-	struct hlist_head	deathrow;
 };
 
 static inline struct net *ib_net(const struct inet_bind_bucket *ib)
diff --git a/include/net/inet_timewait_sock.h b/include/net/inet_timewait_sock.h
index b14999ff55db..f28da08a37b4 100644
--- a/include/net/inet_timewait_sock.h
+++ b/include/net/inet_timewait_sock.h
@@ -75,13 +75,9 @@ struct inet_timewait_sock {
 	struct timer_list	tw_timer;
 	struct inet_bind_bucket	*tw_tb;
 	struct inet_bind2_bucket	*tw_tb2;
-	struct hlist_node		tw_bind2_node;
 };
 #define tw_tclass tw_tos
 
-#define twsk_for_each_bound_bhash2(__tw, list) \
-	hlist_for_each_entry(__tw, list, tw_bind2_node)
-
 static inline struct inet_timewait_sock *inet_twsk(const struct sock *sk)
 {
 	return (struct inet_timewait_sock *)sk;
diff --git a/include/net/sock.h b/include/net/sock.h
index e0de49533361..dbc01ce74ef2 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -352,7 +352,6 @@ struct sk_filter;
   *	@sk_txtime_report_errors: set report errors mode for SO_TXTIME
   *	@sk_txtime_unused: unused txtime flags
   *	@ns_tracker: tracker for netns reference
-  *	@sk_bind2_node: bind node in the bhash2 table
   */
 struct sock {
 	/*
@@ -544,7 +543,6 @@ struct sock {
 #endif
 	struct rcu_head		sk_rcu;
 	netns_tracker		ns_tracker;
-	struct hlist_node	sk_bind2_node;
 };
 
 enum sk_pacing {
@@ -890,8 +888,6 @@ static inline void sk_add_bind_node(struct sock *sk,
 	hlist_for_each_entry_safe(__sk, tmp, list, sk_node)
 #define sk_for_each_bound(__sk, list) \
 	hlist_for_each_entry(__sk, list, sk_bind_node)
-#define sk_for_each_bound_bhash2(__sk, list) \
-	hlist_for_each_entry(__sk, list, sk_bind2_node)
 
 /**
  * sk_for_each_entry_offset_rcu - iterate over a list at a given struct offset
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 35ce1decc47a..1a7f08719de9 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -205,7 +205,6 @@ static bool inet_bhash2_conflict(const struct sock *sk,
 				 bool relax, bool reuseport_cb_ok,
 				 bool reuseport_ok)
 {
-	struct inet_timewait_sock *tw2;
 	struct sock *sk2;
 
 	sk_for_each_bound(sk2, &tb2->owners) {
@@ -214,14 +213,6 @@ static bool inet_bhash2_conflict(const struct sock *sk,
 			return true;
 	}
 
-	twsk_for_each_bound_bhash2(tw2, &tb2->deathrow) {
-		sk2 = (struct sock *)tw2;
-
-		if (__inet_bhash2_conflict(sk, sk2, sk_uid, relax,
-					   reuseport_cb_ok, reuseport_ok))
-			return true;
-	}
-
 	return false;
 }
 
@@ -229,10 +220,6 @@ static bool inet_bhash2_conflict(const struct sock *sk,
 	hlist_for_each_entry(__tb2, &(__tb)->bhash2, bhash_node)	\
 		sk_for_each_bound(sk2, &(__tb2)->owners)
 
-#define twsk_for_each_bound_bhash(__sk, __tb2, __tb)			\
-	hlist_for_each_entry(__tb2, &(__tb)->bhash2, bhash_node)	\
-		sk_for_each_bound_bhash2(sk2, &(__tb2)->deathrow)
-
 /* This should be called only when the tb and tb2 hashbuckets' locks are held */
 static int inet_csk_bind_conflict(const struct sock *sk,
 				  const struct inet_bind_bucket *tb,
@@ -272,14 +259,6 @@ static int inet_csk_bind_conflict(const struct sock *sk,
 			return true;
 	}
 
-	twsk_for_each_bound_bhash(sk2, tb2, tb) {
-		if (!inet_bind_conflict(sk, sk2, uid, relax, reuseport_cb_ok, reuseport_ok))
-			continue;
-
-		if (inet_rcv_saddr_equal(sk, sk2, true))
-			return true;
-	}
-
 	return false;
 }
 
diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index a6652104b70e..a5038351388a 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -122,7 +122,6 @@ static void inet_bind2_bucket_init(struct inet_bind2_bucket *tb2,
 	tb2->rcv_saddr = sk->sk_rcv_saddr;
 #endif
 	INIT_HLIST_HEAD(&tb2->owners);
-	INIT_HLIST_HEAD(&tb2->deathrow);
 	hlist_add_head(&tb2->node, &head->chain);
 	hlist_add_head(&tb2->bhash_node, &tb->bhash2);
 }
@@ -144,7 +143,7 @@ struct inet_bind2_bucket *inet_bind2_bucket_create(struct kmem_cache *cachep,
 /* Caller must hold hashbucket lock for this tb with local BH disabled */
 void inet_bind2_bucket_destroy(struct kmem_cache *cachep, struct inet_bind2_bucket *tb)
 {
-	if (hlist_empty(&tb->owners) && hlist_empty(&tb->deathrow)) {
+	if (hlist_empty(&tb->owners)) {
 		__hlist_del(&tb->node);
 		__hlist_del(&tb->bhash_node);
 		kmem_cache_free(cachep, tb);
-- 
2.30.2


