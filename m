Return-Path: <netdev+bounces-43600-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 751D47D3FD4
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 21:07:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A64EB1C20974
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 19:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC692231D;
	Mon, 23 Oct 2023 19:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="SocH0dfr"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FEB21A17
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 19:07:19 +0000 (UTC)
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9604C100
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 12:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1698088039; x=1729624039;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8zNE1RtqHyA04O8SpEjU++1DyoQROogwn56rwMWakME=;
  b=SocH0dfrDNJuJaZMLgg4x3nwob1HmISjChwFlqKL8T75SwN2iu2dbQ5r
   uGpcb/EIb8mJ6iIjED50B6bOBRZSHNsRD2NLpnm/Vbz80Epj+ge3FZPD4
   THL3EyIijuuMLgHcLDYnh1qRW6G7zcv+bkz55had3cCBOXi/U48VTe9TD
   g=;
X-IronPort-AV: E=Sophos;i="6.03,246,1694736000"; 
   d="scan'208";a="363570737"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-a893d89c.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 19:07:18 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan2.pdx.amazon.com [10.39.38.66])
	by email-inbound-relay-pdx-2b-m6i4x-a893d89c.us-west-2.amazon.com (Postfix) with ESMTPS id 9F29B40DA0;
	Mon, 23 Oct 2023 19:07:15 +0000 (UTC)
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:26832]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.29.249:2525] with esmtp (Farcaster)
 id 2942c1b7-47e2-4adb-8b19-737ef98ee7f3; Mon, 23 Oct 2023 19:07:15 +0000 (UTC)
X-Farcaster-Flow-ID: 2942c1b7-47e2-4adb-8b19-737ef98ee7f3
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Mon, 23 Oct 2023 19:07:14 +0000
Received: from 88665a182662.ant.amazon.com (10.119.77.134) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Mon, 23 Oct 2023 19:07:11 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Coco Li <lixiaoyan@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 10/12] tcp: Unlink sk from bhash.
Date: Mon, 23 Oct 2023 12:02:53 -0700
Message-ID: <20231023190255.39190-11-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D032UWA001.ant.amazon.com (10.13.139.62) To
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
index 72a0767e95d3..f77e57f6e109 100644
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


