Return-Path: <netdev+bounces-43596-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 324FF7D3FCC
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 21:05:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 559A51C2042A
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 19:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7F021A1C;
	Mon, 23 Oct 2023 19:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="dGStBpaC"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B91521A09
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 19:05:44 +0000 (UTC)
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB71894
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 12:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1698087944; x=1729623944;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fuhpqdF0zvwJ2a89IJq/ZVymDZ44Q//8qPehYej/egw=;
  b=dGStBpaCFTGDraK+/dYD5ahdtuAQ0rBQbX7Nvq5IT4Xc5pCGC7NjeIzK
   do3m0+CSDejtrrNw0GhPUxDegDmZpjGVTDnwj4NWHWedaupkqVKfCxs3l
   8iqIo7D5Let6iDqibBVslHTJtEmjqizLaKBnbvqCSHstMVBrMr3M/yVUG
   4=;
X-IronPort-AV: E=Sophos;i="6.03,246,1694736000"; 
   d="scan'208";a="611676091"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1d-m6i4x-25ac6bd5.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 19:05:43 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan2.iad.amazon.com [10.32.235.34])
	by email-inbound-relay-iad-1d-m6i4x-25ac6bd5.us-east-1.amazon.com (Postfix) with ESMTPS id 607ED46910;
	Mon, 23 Oct 2023 19:05:36 +0000 (UTC)
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:16693]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.17.71:2525] with esmtp (Farcaster)
 id 503abbcd-af6a-4629-b603-a6148a4f2a14; Mon, 23 Oct 2023 19:05:35 +0000 (UTC)
X-Farcaster-Flow-ID: 503abbcd-af6a-4629-b603-a6148a4f2a14
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Mon, 23 Oct 2023 19:05:35 +0000
Received: from 88665a182662.ant.amazon.com (10.119.77.134) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.39;
 Mon, 23 Oct 2023 19:05:33 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Coco Li <lixiaoyan@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 06/12] tcp: Link bhash2 to bhash.
Date: Mon, 23 Oct 2023 12:02:49 -0700
Message-ID: <20231023190255.39190-7-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D035UWA003.ant.amazon.com (10.13.139.86) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

bhash2 added a new member sk_bind2_node in struct sock to link
sockets to bhash2 in addition to bhash.

bhash is still needed to search conflicting sockets efficiently
from a port for the wildcard address.  However, bhash itself need
not have sockets.

If we link each bhash2 bucket to the corresponding bhash bucket,
we can iterate the same set of the sockets from bhash2 via bhash.

This patch links bhash2 to bhash only, and the actual use will be
in the later patches.  Finally, we will remove sk_bind2_node.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/net/inet_hashtables.h   |  4 +++-
 net/ipv4/inet_connection_sock.c |  2 +-
 net/ipv4/inet_hashtables.c      | 21 +++++++++++----------
 3 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/include/net/inet_hashtables.h b/include/net/inet_hashtables.h
index 260e673ede22..25ba471ba161 100644
--- a/include/net/inet_hashtables.h
+++ b/include/net/inet_hashtables.h
@@ -89,6 +89,7 @@ struct inet_bind_bucket {
 	bool			fast_ipv6_only;
 	struct hlist_node	node;
 	struct hlist_head	owners;
+	struct hlist_head	bhash2;
 };
 
 struct inet_bind2_bucket {
@@ -104,6 +105,7 @@ struct inet_bind2_bucket {
 #endif
 	/* Node in the bhash2 inet_bind_hashbucket chain */
 	struct hlist_node	node;
+	struct hlist_node	bhash_node;
 	/* List of sockets hashed to this bucket */
 	struct hlist_head	owners;
 	/* bhash has twsk in owners, but bhash2 has twsk in
@@ -239,7 +241,7 @@ bool inet_bind_bucket_match(const struct inet_bind_bucket *tb,
 struct inet_bind2_bucket *
 inet_bind2_bucket_create(struct kmem_cache *cachep, struct net *net,
 			 struct inet_bind_hashbucket *head,
-			 unsigned short port, int l3mdev,
+			 struct inet_bind_bucket *tb,
 			 const struct sock *sk);
 
 void inet_bind2_bucket_destroy(struct kmem_cache *cachep,
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 0c78d135d82d..26d386e14f19 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -570,7 +570,7 @@ int inet_csk_get_port(struct sock *sk, unsigned short snum)
 
 	if (!tb2) {
 		tb2 = inet_bind2_bucket_create(hinfo->bind2_bucket_cachep,
-					       net, head2, port, l3mdev, sk);
+					       net, head2, tb, sk);
 		if (!tb2)
 			goto fail_unlock;
 		bhash2_created = true;
diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index 38406a69853b..7a2e5f4bd8e3 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -77,6 +77,7 @@ struct inet_bind_bucket *inet_bind_bucket_create(struct kmem_cache *cachep,
 		tb->fastreuse = 0;
 		tb->fastreuseport = 0;
 		INIT_HLIST_HEAD(&tb->owners);
+		INIT_HLIST_HEAD(&tb->bhash2);
 		hlist_add_head(&tb->node, &head->chain);
 	}
 	return tb;
@@ -103,12 +104,12 @@ bool inet_bind_bucket_match(const struct inet_bind_bucket *tb, const struct net
 static void inet_bind2_bucket_init(struct inet_bind2_bucket *tb2,
 				   struct net *net,
 				   struct inet_bind_hashbucket *head,
-				   unsigned short port, int l3mdev,
+				   struct inet_bind_bucket *tb,
 				   const struct sock *sk)
 {
 	write_pnet(&tb2->ib_net, net);
-	tb2->l3mdev = l3mdev;
-	tb2->port = port;
+	tb2->l3mdev = tb->l3mdev;
+	tb2->port = tb->port;
 #if IS_ENABLED(CONFIG_IPV6)
 	BUILD_BUG_ON(USHRT_MAX < (IPV6_ADDR_ANY | IPV6_ADDR_MAPPED));
 	if (sk->sk_family == AF_INET6) {
@@ -124,19 +125,19 @@ static void inet_bind2_bucket_init(struct inet_bind2_bucket *tb2,
 	INIT_HLIST_HEAD(&tb2->owners);
 	INIT_HLIST_HEAD(&tb2->deathrow);
 	hlist_add_head(&tb2->node, &head->chain);
+	hlist_add_head(&tb2->bhash_node, &tb->bhash2);
 }
 
 struct inet_bind2_bucket *inet_bind2_bucket_create(struct kmem_cache *cachep,
 						   struct net *net,
 						   struct inet_bind_hashbucket *head,
-						   unsigned short port,
-						   int l3mdev,
+						   struct inet_bind_bucket *tb,
 						   const struct sock *sk)
 {
 	struct inet_bind2_bucket *tb2 = kmem_cache_alloc(cachep, GFP_ATOMIC);
 
 	if (tb2)
-		inet_bind2_bucket_init(tb2, net, head, port, l3mdev, sk);
+		inet_bind2_bucket_init(tb2, net, head, tb, sk);
 
 	return tb2;
 }
@@ -146,6 +147,7 @@ void inet_bind2_bucket_destroy(struct kmem_cache *cachep, struct inet_bind2_buck
 {
 	if (hlist_empty(&tb->owners) && hlist_empty(&tb->deathrow)) {
 		__hlist_del(&tb->node);
+		__hlist_del(&tb->bhash_node);
 		kmem_cache_free(cachep, tb);
 	}
 }
@@ -273,8 +275,7 @@ int __inet_inherit_port(const struct sock *sk, struct sock *child)
 		tb2 = inet_bind2_bucket_find(head2, net, port, l3mdev, child);
 		if (!tb2) {
 			tb2 = inet_bind2_bucket_create(table->bind2_bucket_cachep,
-						       net, head2, port,
-						       l3mdev, child);
+						       net, head2, tb, child);
 			if (!tb2)
 				goto error;
 		}
@@ -954,7 +955,7 @@ static int __inet_bhash2_update_saddr(struct sock *sk, void *saddr, int family,
 	tb2 = inet_bind2_bucket_find(head2, net, port, l3mdev, sk);
 	if (!tb2) {
 		tb2 = new_tb2;
-		inet_bind2_bucket_init(tb2, net, head2, port, l3mdev, sk);
+		inet_bind2_bucket_init(tb2, net, head2, inet_csk(sk)->icsk_bind_hash, sk);
 	}
 	sk_add_bind2_node(sk, &tb2->owners);
 	inet_csk(sk)->icsk_bind2_hash = tb2;
@@ -1096,7 +1097,7 @@ int __inet_hash_connect(struct inet_timewait_death_row *death_row,
 	tb2 = inet_bind2_bucket_find(head2, net, port, l3mdev, sk);
 	if (!tb2) {
 		tb2 = inet_bind2_bucket_create(hinfo->bind2_bucket_cachep, net,
-					       head2, port, l3mdev, sk);
+					       head2, tb, sk);
 		if (!tb2)
 			goto error;
 	}
-- 
2.30.2


