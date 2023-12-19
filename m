Return-Path: <netdev+bounces-58728-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9A69817EBB
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 01:21:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 759461F21700
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 00:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF71188;
	Tue, 19 Dec 2023 00:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="eL/akRi5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F75179
	for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 00:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1702945289; x=1734481289;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WPFfO9lIdacrXAoTbWaaivr8HvltNXvJQisYmbvAYh0=;
  b=eL/akRi5hbsdkeGDutcWmV8Tbgg22eUKnhahnifrkXm6ozUEI7cQZlC5
   QkhJqwUrpD8/dbp/DfSbeuacRhFqpevJV0iYtIp74Tsk2k+idPmK6pVK0
   Mxa+0faXZzyQxh1G66I9oh9GHzExr8qfXpqoXcNCshqBt8j3ZnsxhktH/
   w=;
X-IronPort-AV: E=Sophos;i="6.04,286,1695686400"; 
   d="scan'208";a="52179479"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-86a02d5e.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 00:21:28 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan2.iad.amazon.com [10.32.235.34])
	by email-inbound-relay-iad-1a-m6i4x-86a02d5e.us-east-1.amazon.com (Postfix) with ESMTPS id 50410E05E4;
	Tue, 19 Dec 2023 00:21:26 +0000 (UTC)
Received: from EX19MTAUWC002.ant.amazon.com [10.0.7.35:54472]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.19.109:2525] with esmtp (Farcaster)
 id 0619aa73-6ea0-4992-953c-e574830d8224; Tue, 19 Dec 2023 00:21:25 +0000 (UTC)
X-Farcaster-Flow-ID: 0619aa73-6ea0-4992-953c-e574830d8224
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 19 Dec 2023 00:21:24 +0000
Received: from 88665a182662.ant.amazon.com (10.118.248.48) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.40;
 Tue, 19 Dec 2023 00:21:21 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH RESEND v2 net-next 06/12] tcp: Link bhash2 to bhash.
Date: Tue, 19 Dec 2023 09:18:27 +0900
Message-ID: <20231219001833.10122-7-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D036UWB004.ant.amazon.com (10.13.139.170) To
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
index d48255875f60..8b29056f454d 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -572,7 +572,7 @@ int inet_csk_get_port(struct sock *sk, unsigned short snum)
 
 	if (!tb2) {
 		tb2 = inet_bind2_bucket_create(hinfo->bind2_bucket_cachep,
-					       net, head2, port, l3mdev, sk);
+					       net, head2, tb, sk);
 		if (!tb2)
 			goto fail_unlock;
 		bhash2_created = true;
diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index 0a9919755709..7dc33dd1ba35 100644
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
@@ -1101,7 +1102,7 @@ int __inet_hash_connect(struct inet_timewait_death_row *death_row,
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


