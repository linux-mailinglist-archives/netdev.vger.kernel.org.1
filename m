Return-Path: <netdev+bounces-58732-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E77B817EBF
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 01:23:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1DA71F23A2C
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 00:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4F5368;
	Tue, 19 Dec 2023 00:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ZwqyCvmr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5177F
	for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 00:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1702945394; x=1734481394;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dCilemGS4DkDlSpC+44EAnmjvAZ78/J+CylgGmpHUD0=;
  b=ZwqyCvmrDudVo+8xRP/VbDeMmnWie8fylTGilMA7btyJDgEpW5fNLCXM
   LsGsEZMg7/myZFvVu16VMdN6RyMTtq2jvLfY20fpmoXlpUKo65Rj/bDzY
   wt7nYmGrwtdX5UuESzle5h/+QTEzqyJraxMCvOaxGNMDXkA6Ovac7CUUE
   Q=;
X-IronPort-AV: E=Sophos;i="6.04,286,1695686400"; 
   d="scan'208";a="626306846"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-21d8d9f4.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 00:23:13 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan2.pdx.amazon.com [10.39.38.66])
	by email-inbound-relay-pdx-2a-m6i4x-21d8d9f4.us-west-2.amazon.com (Postfix) with ESMTPS id 3E6168036F;
	Tue, 19 Dec 2023 00:23:11 +0000 (UTC)
Received: from EX19MTAUWC002.ant.amazon.com [10.0.7.35:17597]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.54.233:2525] with esmtp (Farcaster)
 id a9baa56e-a6b3-4d78-835f-acd439135a6f; Tue, 19 Dec 2023 00:23:10 +0000 (UTC)
X-Farcaster-Flow-ID: a9baa56e-a6b3-4d78-835f-acd439135a6f
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 19 Dec 2023 00:23:10 +0000
Received: from 88665a182662.ant.amazon.com (10.118.248.48) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 19 Dec 2023 00:23:07 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH RESEND v2 net-next 10/12] tcp: Unlink sk from bhash.
Date: Tue, 19 Dec 2023 09:18:31 +0900
Message-ID: <20231219001833.10122-11-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D041UWB001.ant.amazon.com (10.13.139.132) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

Now we do not use tb->owners and can unlink sockets from bhash.

sk_bind_node/tw_bind_node are available for bhash2 and will be
used in the following patch.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/net/inet_hashtables.h | 1 -
 net/ipv4/inet_hashtables.c    | 3 ---
 net/ipv4/inet_timewait_sock.c | 8 --------
 3 files changed, 12 deletions(-)

diff --git a/include/net/inet_hashtables.h b/include/net/inet_hashtables.h
index 25ba471ba161..98ba728aec08 100644
--- a/include/net/inet_hashtables.h
+++ b/include/net/inet_hashtables.h
@@ -88,7 +88,6 @@ struct inet_bind_bucket {
 	unsigned short		fast_sk_family;
 	bool			fast_ipv6_only;
 	struct hlist_node	node;
-	struct hlist_head	owners;
 	struct hlist_head	bhash2;
 };
 
diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index 355cc6c0eaab..5c3ad37624f1 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -76,7 +76,6 @@ struct inet_bind_bucket *inet_bind_bucket_create(struct kmem_cache *cachep,
 		tb->port      = snum;
 		tb->fastreuse = 0;
 		tb->fastreuseport = 0;
-		INIT_HLIST_HEAD(&tb->owners);
 		INIT_HLIST_HEAD(&tb->bhash2);
 		hlist_add_head(&tb->node, &head->chain);
 	}
@@ -169,7 +168,6 @@ void inet_bind_hash(struct sock *sk, struct inet_bind_bucket *tb,
 		    struct inet_bind2_bucket *tb2, unsigned short port)
 {
 	inet_sk(sk)->inet_num = port;
-	sk_add_bind_node(sk, &tb->owners);
 	inet_csk(sk)->icsk_bind_hash = tb;
 	sk_add_bind2_node(sk, &tb2->owners);
 	inet_csk(sk)->icsk_bind2_hash = tb2;
@@ -192,7 +190,6 @@ static void __inet_put_port(struct sock *sk)
 
 	spin_lock(&head->lock);
 	tb = inet_csk(sk)->icsk_bind_hash;
-	__sk_del_bind_node(sk);
 	inet_csk(sk)->icsk_bind_hash = NULL;
 	inet_sk(sk)->inet_num = 0;
 
diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_sock.c
index 466d4faa9272..547583a87bd3 100644
--- a/net/ipv4/inet_timewait_sock.c
+++ b/net/ipv4/inet_timewait_sock.c
@@ -35,7 +35,6 @@ void inet_twsk_bind_unhash(struct inet_timewait_sock *tw,
 	if (!tb)
 		return;
 
-	__hlist_del(&tw->tw_bind_node);
 	tw->tw_tb = NULL;
 
 	__hlist_del(&tw->tw_bind2_node);
@@ -94,12 +93,6 @@ static void inet_twsk_add_node_rcu(struct inet_timewait_sock *tw,
 	hlist_nulls_add_head_rcu(&tw->tw_node, list);
 }
 
-static void inet_twsk_add_bind_node(struct inet_timewait_sock *tw,
-				    struct hlist_head *list)
-{
-	hlist_add_head(&tw->tw_bind_node, list);
-}
-
 static void inet_twsk_add_bind2_node(struct inet_timewait_sock *tw,
 				     struct hlist_head *list)
 {
@@ -133,7 +126,6 @@ void inet_twsk_hashdance(struct inet_timewait_sock *tw, struct sock *sk,
 
 	tw->tw_tb = icsk->icsk_bind_hash;
 	WARN_ON(!icsk->icsk_bind_hash);
-	inet_twsk_add_bind_node(tw, &tw->tw_tb->owners);
 
 	tw->tw_tb2 = icsk->icsk_bind2_hash;
 	WARN_ON(!icsk->icsk_bind2_hash);
-- 
2.30.2


