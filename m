Return-Path: <netdev+bounces-58733-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC37817EC1
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 01:23:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66AC9285F03
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 00:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C71B7F;
	Tue, 19 Dec 2023 00:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="m9E5TR1B"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8962E620
	for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 00:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1702945423; x=1734481423;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Do0ZrEV6ssJ7NmzmaCxGNAbGBqkmq3KvfWZLIWW4sDo=;
  b=m9E5TR1BvvHXpfdJgZMi4JLs2h4PNTWCCuDFqpwlUwS3gR3YmqjWdYJn
   I9RTWXLZ1NfigH8j8xUsbNzg1rnOP/Ov8vRMrA9CW4QY74eMu//+FOGtF
   vPPDJhQhgnS1JiIlonYHadZroQwgvAvTO8loXpq/7I462W18VFG4uLWOn
   I=;
X-IronPort-AV: E=Sophos;i="6.04,286,1695686400"; 
   d="scan'208";a="692266850"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-21d8d9f4.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 00:23:37 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan2.pdx.amazon.com [10.39.38.66])
	by email-inbound-relay-pdx-2a-m6i4x-21d8d9f4.us-west-2.amazon.com (Postfix) with ESMTPS id 5F9618036F;
	Tue, 19 Dec 2023 00:23:37 +0000 (UTC)
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:50961]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.27.95:2525] with esmtp (Farcaster)
 id 86cd1054-745e-4358-ab20-190c44f3ac67; Tue, 19 Dec 2023 00:23:36 +0000 (UTC)
X-Farcaster-Flow-ID: 86cd1054-745e-4358-ab20-190c44f3ac67
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 19 Dec 2023 00:23:36 +0000
Received: from 88665a182662.ant.amazon.com (10.118.248.48) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 19 Dec 2023 00:23:33 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH RESEND v2 net-next 11/12] tcp: Link sk and twsk to tb2->owners using skc_bind_node.
Date: Tue, 19 Dec 2023 09:18:32 +0900
Message-ID: <20231219001833.10122-12-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D042UWB002.ant.amazon.com (10.13.139.175) To
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
index 8b6fe164b218..45b9010251e9 100644
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
index 1bd13dcd45ae..1e19f85bce20 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -219,7 +219,7 @@ static bool inet_bhash2_conflict(const struct sock *sk,
 	struct inet_timewait_sock *tw2;
 	struct sock *sk2;
 
-	sk_for_each_bound_bhash2(sk2, &tb2->owners) {
+	sk_for_each_bound(sk2, &tb2->owners) {
 		if (__inet_bhash2_conflict(sk, sk2, sk_uid, relax,
 					   reuseport_cb_ok, reuseport_ok))
 			return true;
@@ -238,7 +238,7 @@ static bool inet_bhash2_conflict(const struct sock *sk,
 
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
index 5c3ad37624f1..4ca726a71b9d 100644
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


