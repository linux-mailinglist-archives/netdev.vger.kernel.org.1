Return-Path: <netdev+bounces-56759-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 952FC810C4B
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 09:23:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 509962818D1
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 08:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925D61DDDC;
	Wed, 13 Dec 2023 08:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="P/wIcinH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3A8FB2
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 00:23:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1702455783; x=1733991783;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JVXbchgxJmRRpE/zcaT5kNcujYXWY/nRRcnvYEYSPDw=;
  b=P/wIcinHzFCT8ci8wxg26+M4Gqy7oK+BG82R2PTBj6TfdrHnpdlEZICm
   QgRZmok0YyYg8rE6QKVrgcYIKWGZ35MeOXJgxez1DDbvCEc0rYhxSMMeh
   vOBk2uQNIDptftpCBZBsYRsbcMUh93+vaOmvZw2vr99hzKeXUtOnE6p5S
   s=;
X-IronPort-AV: E=Sophos;i="6.04,272,1695686400"; 
   d="scan'208";a="624928269"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-d2040ec1.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 08:23:01 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan2.pdx.amazon.com [10.39.38.66])
	by email-inbound-relay-pdx-2c-m6i4x-d2040ec1.us-west-2.amazon.com (Postfix) with ESMTPS id 51AF140D5E;
	Wed, 13 Dec 2023 08:22:59 +0000 (UTC)
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:21304]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.27.95:2525] with esmtp (Farcaster)
 id 163a67cf-540a-4f4c-ba70-f7e1fddaf45d; Wed, 13 Dec 2023 08:22:58 +0000 (UTC)
X-Farcaster-Flow-ID: 163a67cf-540a-4f4c-ba70-f7e1fddaf45d
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 13 Dec 2023 08:22:58 +0000
Received: from 88665a182662.ant.amazon.com (10.119.5.2) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.40;
 Wed, 13 Dec 2023 08:22:55 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 05/12] tcp: Rename tb in inet_bind2_bucket_(init|create)().
Date: Wed, 13 Dec 2023 17:20:22 +0900
Message-ID: <20231213082029.35149-6-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D037UWC002.ant.amazon.com (10.13.139.250) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

Later, we no longer link sockets to bhash.  Instead, each bhash2
bucket is linked to the corresponding bhash bucket.

Then, we pass the bhash bucket to bhash2 allocation functions as
tb.  However, tb is already used in inet_bind2_bucket_create() and
inet_bind2_bucket_init() as the bhash2 bucket.

To make the following diff clear, let's use tb2 for the bhash2 bucket
there.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv4/inet_hashtables.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/net/ipv4/inet_hashtables.c b/net/ipv4/inet_hashtables.c
index 465469de19bf..547b28e63db4 100644
--- a/net/ipv4/inet_hashtables.c
+++ b/net/ipv4/inet_hashtables.c
@@ -100,30 +100,30 @@ bool inet_bind_bucket_match(const struct inet_bind_bucket *tb, const struct net
 		tb->l3mdev == l3mdev;
 }
 
-static void inet_bind2_bucket_init(struct inet_bind2_bucket *tb,
+static void inet_bind2_bucket_init(struct inet_bind2_bucket *tb2,
 				   struct net *net,
 				   struct inet_bind_hashbucket *head,
 				   unsigned short port, int l3mdev,
 				   const struct sock *sk)
 {
-	write_pnet(&tb->ib_net, net);
-	tb->l3mdev    = l3mdev;
-	tb->port      = port;
+	write_pnet(&tb2->ib_net, net);
+	tb2->l3mdev = l3mdev;
+	tb2->port = port;
 #if IS_ENABLED(CONFIG_IPV6)
 	BUILD_BUG_ON(USHRT_MAX < (IPV6_ADDR_ANY | IPV6_ADDR_MAPPED));
 	if (sk->sk_family == AF_INET6) {
-		tb->addr_type = ipv6_addr_type(&sk->sk_v6_rcv_saddr);
-		tb->v6_rcv_saddr = sk->sk_v6_rcv_saddr;
+		tb2->addr_type = ipv6_addr_type(&sk->sk_v6_rcv_saddr);
+		tb2->v6_rcv_saddr = sk->sk_v6_rcv_saddr;
 	} else {
-		tb->addr_type = IPV6_ADDR_MAPPED;
-		ipv6_addr_set_v4mapped(sk->sk_rcv_saddr, &tb->v6_rcv_saddr);
+		tb2->addr_type = IPV6_ADDR_MAPPED;
+		ipv6_addr_set_v4mapped(sk->sk_rcv_saddr, &tb2->v6_rcv_saddr);
 	}
 #else
-	tb->rcv_saddr = sk->sk_rcv_saddr;
+	tb2->rcv_saddr = sk->sk_rcv_saddr;
 #endif
-	INIT_HLIST_HEAD(&tb->owners);
-	INIT_HLIST_HEAD(&tb->deathrow);
-	hlist_add_head(&tb->node, &head->chain);
+	INIT_HLIST_HEAD(&tb2->owners);
+	INIT_HLIST_HEAD(&tb2->deathrow);
+	hlist_add_head(&tb2->node, &head->chain);
 }
 
 struct inet_bind2_bucket *inet_bind2_bucket_create(struct kmem_cache *cachep,
@@ -133,12 +133,12 @@ struct inet_bind2_bucket *inet_bind2_bucket_create(struct kmem_cache *cachep,
 						   int l3mdev,
 						   const struct sock *sk)
 {
-	struct inet_bind2_bucket *tb = kmem_cache_alloc(cachep, GFP_ATOMIC);
+	struct inet_bind2_bucket *tb2 = kmem_cache_alloc(cachep, GFP_ATOMIC);
 
-	if (tb)
-		inet_bind2_bucket_init(tb, net, head, port, l3mdev, sk);
+	if (tb2)
+		inet_bind2_bucket_init(tb2, net, head, port, l3mdev, sk);
 
-	return tb;
+	return tb2;
 }
 
 /* Caller must hold hashbucket lock for this tb with local BH disabled */
-- 
2.30.2


