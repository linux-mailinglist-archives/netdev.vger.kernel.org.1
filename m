Return-Path: <netdev+bounces-56764-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C675F810C5D
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 09:25:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B501B20BCD
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 08:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E2F11DDD7;
	Wed, 13 Dec 2023 08:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="u47eqXV7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A75F2
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 00:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1702455915; x=1733991915;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6KgLAgK58xBUN1wSTI5+SaOJOuqHOrmR57vOV0B+IzQ=;
  b=u47eqXV7m22J74M2Q1JzOaF4nrRsPbTVRZHOBRZwbkP56gtgfz6w4l7i
   YEjDteqXXlF0HlwGB9WELXl9CnoNU7Ur/UCchHhZ7P288/dYqI5CKpPYU
   4VyzSJsd+Mlde+DZi8THQTQhAJJufi2u7TyEYg/cKa4csjp5LMes0AWes
   E=;
X-IronPort-AV: E=Sophos;i="6.04,272,1695686400"; 
   d="scan'208";a="624928634"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-617e30c2.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 08:25:14 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan2.iad.amazon.com [10.32.235.34])
	by email-inbound-relay-iad-1a-m6i4x-617e30c2.us-east-1.amazon.com (Postfix) with ESMTPS id 2E62A634EA;
	Wed, 13 Dec 2023 08:25:11 +0000 (UTC)
Received: from EX19MTAUWA001.ant.amazon.com [10.0.7.35:37728]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.54.233:2525] with esmtp (Farcaster)
 id 020a7700-fa50-4b8c-98fa-654f8c5f6c8a; Wed, 13 Dec 2023 08:25:11 +0000 (UTC)
X-Farcaster-Flow-ID: 020a7700-fa50-4b8c-98fa-654f8c5f6c8a
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 13 Dec 2023 08:25:11 +0000
Received: from 88665a182662.ant.amazon.com (10.119.5.2) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 13 Dec 2023 08:25:07 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 10/12] tcp: Unlink sk from bhash.
Date: Wed, 13 Dec 2023 17:20:27 +0900
Message-ID: <20231213082029.35149-11-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D044UWA003.ant.amazon.com (10.13.139.43) To
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
index 1e9b16a00a75..7a78b8691365 100644
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


