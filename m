Return-Path: <netdev+bounces-43602-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 234F47D3FD6
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 21:08:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D79292812CB
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 19:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB3D921A1A;
	Mon, 23 Oct 2023 19:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="aef0kBj7"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE8D125B0
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 19:08:11 +0000 (UTC)
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2EAFFD
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 12:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1698088090; x=1729624090;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=x9CvyC0Wsyv8IwKdzwe6/Em1rhlUxlGbl8Quw5tuZek=;
  b=aef0kBj7QLj+lfU0HIfih4vMxK8oEPLkuA64JQc0pG5VhW5i8HRPMnLn
   CZpu/TgBugjTOMNwICVPSm3ttBirMbn3QIT/2+SFfJ/JdYEF3D4FZFX61
   /DyLgdG38nKnvAyQGtze5eF08b86SnFjijf10x/6o8AExUFIIkDaMzEsD
   c=;
X-IronPort-AV: E=Sophos;i="6.03,246,1694736000"; 
   d="scan'208";a="365849321"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-cadc3fbd.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 19:08:06 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan2.pdx.amazon.com [10.39.38.66])
	by email-inbound-relay-pdx-2b-m6i4x-cadc3fbd.us-west-2.amazon.com (Postfix) with ESMTPS id 219A2A0789;
	Mon, 23 Oct 2023 19:08:03 +0000 (UTC)
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:35251]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.29.249:2525] with esmtp (Farcaster)
 id 3322d7c6-5663-47dd-9128-8e8a0f1b356f; Mon, 23 Oct 2023 19:08:03 +0000 (UTC)
X-Farcaster-Flow-ID: 3322d7c6-5663-47dd-9128-8e8a0f1b356f
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Mon, 23 Oct 2023 19:08:03 +0000
Received: from 88665a182662.ant.amazon.com (10.119.77.134) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Mon, 23 Oct 2023 19:08:00 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Coco Li <lixiaoyan@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 12/12] tcp: Remove dead code and fields for bhash2.
Date: Mon, 23 Oct 2023 12:02:55 -0700
Message-ID: <20231023190255.39190-13-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D044UWB003.ant.amazon.com (10.13.139.168) To
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
index ce18c73de743..ff6ad9e25581 100644
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
index 39bd4ffca0c0..4f8530919563 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -214,7 +214,6 @@ static bool inet_bhash2_conflict(const struct sock *sk,
 				 bool relax, bool reuseport_cb_ok,
 				 bool reuseport_ok)
 {
-	struct inet_timewait_sock *tw2;
 	struct sock *sk2;
 
 	sk_for_each_bound(sk2, &tb2->owners) {
@@ -223,14 +222,6 @@ static bool inet_bhash2_conflict(const struct sock *sk,
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
 
@@ -238,10 +229,6 @@ static bool inet_bhash2_conflict(const struct sock *sk,
 	hlist_for_each_entry(__tb2, &__tb->bhash2, bhash_node) \
 		sk_for_each_bound(sk2, &__tb2->owners)
 
-#define twsk_for_each_bound_bhash(__sk, __tb2, __tb)	       \
-	hlist_for_each_entry(__tb2, &__tb->bhash2, bhash_node) \
-		sk_for_each_bound_bhash2(sk2, &__tb2->deathrow)
-
 /* This should be called only when the tb and tb2 hashbuckets' locks are held */
 static int inet_csk_bind_conflict(const struct sock *sk,
 				  const struct inet_bind_bucket *tb,
@@ -281,14 +268,6 @@ static int inet_csk_bind_conflict(const struct sock *sk,
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
index e8f920a92545..0afccc57936f 100644
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


