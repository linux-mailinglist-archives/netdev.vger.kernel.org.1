Return-Path: <netdev+bounces-58734-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F97F817EC3
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 01:24:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37D9E1C20A1E
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 00:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99601368;
	Tue, 19 Dec 2023 00:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="P56zq6sB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17292179
	for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 00:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1702945454; x=1734481454;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=q7gfrCqBr8+dHmrQmhv1EpwqXNt2r6wHcb3xu0oPlUA=;
  b=P56zq6sB8Dixcx/0qFqXLM9gZhWc1Ms2WBP/02t92PHXSEThCrU+Zx+t
   g7UkuAQcsDyIwKvZRtnSBejKE7j9FMUvlki635nVKfy2FPifyoNjIRVrs
   FG+1v1OVmdKyus6z5gsDQJDo0viVB4SL3TeGCvNU9ZyMqQ2myvIeu9GHs
   k=;
X-IronPort-AV: E=Sophos;i="6.04,286,1695686400"; 
   d="scan'208";a="691649309"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-edda28d4.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 00:24:08 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan3.iad.amazon.com [10.32.235.38])
	by email-inbound-relay-iad-1a-m6i4x-edda28d4.us-east-1.amazon.com (Postfix) with ESMTPS id D539A803E3;
	Tue, 19 Dec 2023 00:24:05 +0000 (UTC)
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:20149]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.54.233:2525] with esmtp (Farcaster)
 id 80946305-755c-47e8-a85a-d7eb72e1b10e; Tue, 19 Dec 2023 00:24:05 +0000 (UTC)
X-Farcaster-Flow-ID: 80946305-755c-47e8-a85a-d7eb72e1b10e
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 19 Dec 2023 00:24:03 +0000
Received: from 88665a182662.ant.amazon.com (10.118.248.48) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 19 Dec 2023 00:23:59 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH RESEND v2 net-next 12/12] tcp: Remove dead code and fields for bhash2.
Date: Tue, 19 Dec 2023 09:18:33 +0900
Message-ID: <20231219001833.10122-13-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D040UWA001.ant.amazon.com (10.13.139.22) To
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
index 45b9010251e9..35d9518d2d11 100644
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
index 1e19f85bce20..8e2eb1793685 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -216,7 +216,6 @@ static bool inet_bhash2_conflict(const struct sock *sk,
 				 bool relax, bool reuseport_cb_ok,
 				 bool reuseport_ok)
 {
-	struct inet_timewait_sock *tw2;
 	struct sock *sk2;
 
 	sk_for_each_bound(sk2, &tb2->owners) {
@@ -225,14 +224,6 @@ static bool inet_bhash2_conflict(const struct sock *sk,
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
 
@@ -240,10 +231,6 @@ static bool inet_bhash2_conflict(const struct sock *sk,
 	hlist_for_each_entry(__tb2, &(__tb)->bhash2, bhash_node)	\
 		sk_for_each_bound(sk2, &(__tb2)->owners)
 
-#define twsk_for_each_bound_bhash(__sk, __tb2, __tb)			\
-	hlist_for_each_entry(__tb2, &(__tb)->bhash2, bhash_node)	\
-		sk_for_each_bound_bhash2(sk2, &(__tb2)->deathrow)
-
 /* This should be called only when the tb and tb2 hashbuckets' locks are held */
 static int inet_csk_bind_conflict(const struct sock *sk,
 				  const struct inet_bind_bucket *tb,
@@ -283,14 +270,6 @@ static int inet_csk_bind_conflict(const struct sock *sk,
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
index 4ca726a71b9d..93e9193df544 100644
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


