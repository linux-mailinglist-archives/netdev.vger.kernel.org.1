Return-Path: <netdev+bounces-43595-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41BE47D3FCB
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 21:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD776B20B5E
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 19:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B0E21A09;
	Mon, 23 Oct 2023 19:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="QYgJ3tzR"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F7B219F4
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 19:05:18 +0000 (UTC)
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F08DB3
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 12:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1698087918; x=1729623918;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=D7AG6imKIVTPG6w1n0Qw7Y26gS++BFPYfT61MTm2KoY=;
  b=QYgJ3tzRMmH+lwBC/mqlOZBAgVtkiLWfp7XgQdkPUj9Qk4Mb9JU1Ixc2
   z+8HiLi16evqfYk/qfhlbKC1ykY6Z5tm5T4atRAucty3N1NuL8icIM66Y
   eNL0bmYU1k0NPwMSXAtKCHdCBYnNrBrg+18k1gqEmtQrGbPYe/XvpAhK/
   A=;
X-IronPort-AV: E=Sophos;i="6.03,246,1694736000"; 
   d="scan'208";a="611676002"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-96feee09.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 19:05:16 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan2.iad.amazon.com [10.32.235.34])
	by email-inbound-relay-iad-1a-m6i4x-96feee09.us-east-1.amazon.com (Postfix) with ESMTPS id 858DD40E0C;
	Mon, 23 Oct 2023 19:05:12 +0000 (UTC)
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:21595]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.61.148:2525] with esmtp (Farcaster)
 id 7d0bc177-48f0-4bb7-ba35-e7609e0a27b0; Mon, 23 Oct 2023 19:05:11 +0000 (UTC)
X-Farcaster-Flow-ID: 7d0bc177-48f0-4bb7-ba35-e7609e0a27b0
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Mon, 23 Oct 2023 19:05:11 +0000
Received: from 88665a182662.ant.amazon.com (10.119.77.134) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Mon, 23 Oct 2023 19:05:08 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Coco Li <lixiaoyan@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 05/12] tcp: Rename tb in inet_bind2_bucket_(init|create)().
Date: Mon, 23 Oct 2023 12:02:48 -0700
Message-ID: <20231023190255.39190-6-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D044UWA003.ant.amazon.com (10.13.139.43) To
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
index 129e4ab4042b..38406a69853b 100644
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


