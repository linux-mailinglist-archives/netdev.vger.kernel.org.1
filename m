Return-Path: <netdev+bounces-43601-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 29C137D3FD5
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 21:07:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20E65B20B80
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 19:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097A021A17;
	Mon, 23 Oct 2023 19:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="rB9pvqIk"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F55125B0
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 19:07:48 +0000 (UTC)
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26871C5
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 12:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1698088068; x=1729624068;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jUpkhTKHyoWiApfnRTjydvn388zXJ8ixMgyyLIi0/7g=;
  b=rB9pvqIkkzgFr4uVi4lsECKLOvdrimvZCSMBwBHIbVUrup6BmW9Y84ot
   haL2mw0WrHSY6m7F66f0UXsmD9JYjGvcAbfmd3ukOi5eODD6O9B+HC1Kh
   JuwuwDsz0k78T/lOapPaHxo0VxexnH/ZN8NBGALP5LzqPyImFgBfWOLXc
   U=;
X-IronPort-AV: E=Sophos;i="6.03,246,1694736000"; 
   d="scan'208";a="247512435"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-366646a6.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 19:07:44 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan2.iad.amazon.com [10.32.235.34])
	by email-inbound-relay-iad-1a-m6i4x-366646a6.us-east-1.amazon.com (Postfix) with ESMTPS id 9ACE7A0343;
	Mon, 23 Oct 2023 19:07:40 +0000 (UTC)
Received: from EX19MTAUWB001.ant.amazon.com [10.0.7.35:50759]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.17.71:2525] with esmtp (Farcaster)
 id 53099e02-a36b-4e73-9727-3b0fa1d356e6; Mon, 23 Oct 2023 19:07:39 +0000 (UTC)
X-Farcaster-Flow-ID: 53099e02-a36b-4e73-9727-3b0fa1d356e6
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Mon, 23 Oct 2023 19:07:39 +0000
Received: from 88665a182662.ant.amazon.com (10.119.77.134) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Mon, 23 Oct 2023 19:07:36 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Coco Li <lixiaoyan@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 11/12] tcp: Link sk and twsk to tb2->owners using skc_bind_node.
Date: Mon, 23 Oct 2023 12:02:54 -0700
Message-ID: <20231023190255.39190-12-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D038UWC003.ant.amazon.com (10.13.139.209) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

Now we can use sk_bind_node/tw_bind_node for bhash2, which means
we need not link TIME_WAIT sockets separately.

The dead code and sk_bind2_node will be removed in the next patch.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/net/sock.h              | 10 ----------
 net/ipv4/inet_connection_sock.c |  4 ++--
 net/ipv4/inet_hashtables.c      |  8 ++++----
 net/ipv4/inet_timewait_sock.c   | 11 ++---------
 4 files changed, 8 insertions(+), 25 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 242590308d64..ce18c73de743 100644
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
index 4d4c3a0d8c20..39bd4ffca0c0 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -217,7 +217,7 @@ static bool inet_bhash2_conflict(const struct sock *sk,
 	struct inet_timewait_sock *tw2;
 	struct sock *sk2;
 
-	sk_for_each_bound_bhash2(sk2, &tb2->owners) {
+	sk_for_each_bound(sk2, &tb2->owners) {
 		if (__inet_bhash2_conflict(sk, sk2, sk_uid, relax,
 					   reuseport_cb_ok, reuseport_ok))
 			return true;
@@ -236,7 +236,7 @@ static bool inet_bhash2_conflict(const struct sock *sk,
 
 #define sk_for_each_bound_bhash(__sk, __tb2, __tb)	\
 	hlist_for_each_entry(__tb2, &__tb->bhash2, bhash_node) \
-		sk_for_each_bound_bhash2(sk2, &__tb2->owners)
+		sk_for_each_bound(sk2, &__tb2->owners)
 
 #define twsk_for_each_bound_bhash(__sk, __tb2, __tb)	       \
 	hlist_for_each_entry(__tb2, &__tb->bhash2, bhash_node) \
diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index f77e57f6e109..e8f920a92545 100644
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


