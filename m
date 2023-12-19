Return-Path: <netdev+bounces-58727-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E323817EB8
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 01:21:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 142791F243B8
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 00:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF4A368;
	Tue, 19 Dec 2023 00:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="r02tyO1y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D7C10E3
	for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 00:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1702945262; x=1734481262;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dvy5ikWRRrGUkEuODhIkM1sva37WXIQBLcAAF8ntuss=;
  b=r02tyO1yY4/bcYPoH/bv53unv+P0H861YIZBJ2uigRfQFM3tW+ksbFma
   vLt+YWMIJI5b/NVooVhiZzgnG5GDWwNGHeacJWHiHx/r5lLT6/R2HoZpZ
   NS3OzXj68wCTLfaWEOu5UpjQpcu7yQar6OQOV4Np0Zl0voNLfUnIBlebh
   4=;
X-IronPort-AV: E=Sophos;i="6.04,286,1695686400"; 
   d="scan'208";a="377241973"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-44b6fc51.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2023 00:21:01 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan2.pdx.amazon.com [10.39.38.66])
	by email-inbound-relay-pdx-2a-m6i4x-44b6fc51.us-west-2.amazon.com (Postfix) with ESMTPS id 7492DA02BD;
	Tue, 19 Dec 2023 00:20:59 +0000 (UTC)
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:33887]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.33.64:2525] with esmtp (Farcaster)
 id 501a4171-dd55-4a69-962a-24cad8393c0b; Tue, 19 Dec 2023 00:20:59 +0000 (UTC)
X-Farcaster-Flow-ID: 501a4171-dd55-4a69-962a-24cad8393c0b
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 19 Dec 2023 00:20:58 +0000
Received: from 88665a182662.ant.amazon.com (10.118.248.48) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 19 Dec 2023 00:20:55 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH RESEND v2 net-next 05/12] tcp: Rename tb in inet_bind2_bucket_(init|create)().
Date: Tue, 19 Dec 2023 09:18:26 +0900
Message-ID: <20231219001833.10122-6-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D031UWC004.ant.amazon.com (10.13.139.246) To
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
index 4e39e3f905b4..0a9919755709 100644
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


