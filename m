Return-Path: <netdev+bounces-113823-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E523094002B
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 23:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 226961C20A5A
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 21:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98EBB13A88D;
	Mon, 29 Jul 2024 21:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="L3V7G12y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B245218C324
	for <netdev@vger.kernel.org>; Mon, 29 Jul 2024 21:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722287432; cv=none; b=OXbK5ptXh9f7Nv4x+yb4usu+tGSR+ly7wpGDAq+bdpIhAX0NlmyARCh6BIFptatRrDPNqAPGEnWBukpZRS4aVUB2QzlTuVa1JiX2d0gykuxKztZlIGs0Z9S1WA12U5+zD1IiqgRI4xJQPlkaMRxm0xrv+GEYaKpG9gJ52zD1w6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722287432; c=relaxed/simple;
	bh=reN6f9zL3aDWkr1XnKKiwK1VxbfMlg6Q+UxjZyUV1Ds=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MWv8VXvtPgbDSYDoV+/gGSqqSfp55iC5cec91wYreoIsJX3jM2o3rslVbO0od4cp9a9QUaSROv0Zw7GBgx5x0Ytd4HsTlc21K+nDyW9BElhtPJV4p4x8RicFzo0G9yWYMnRncMkfVfCTw+x3Aa9Bo6QwyZrYtQULUpz/e5AQV0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=L3V7G12y; arc=none smtp.client-ip=207.171.188.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1722287431; x=1753823431;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=EcHiu0o6OKMqdx6QiCq/RKw5zWQLNL/8kbbPKAyluFU=;
  b=L3V7G12yx0FoCtmyzZtpY8zcDjYOtocZWF5r2GqYpZCZN8HdXV43qDKJ
   dmBAxxG8/C2kppvZPBnz848BSNL09J0XTMMsAahPDDAiMG9lGbclpS66y
   KYUmXNLa+sbkwr4qG/P/ipu5q6uHcYmmUlWDoL6Zia1OjobJxSciVjkMi
   E=;
X-IronPort-AV: E=Sophos;i="6.09,246,1716249600"; 
   d="scan'208";a="746185599"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2024 21:10:24 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.38.20:44793]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.49.198:2525] with esmtp (Farcaster)
 id 35ced50c-5f4f-49f0-aef3-a7de4c5e76aa; Mon, 29 Jul 2024 21:10:23 +0000 (UTC)
X-Farcaster-Flow-ID: 35ced50c-5f4f-49f0-aef3-a7de4c5e76aa
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 29 Jul 2024 21:10:23 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.101.6) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 29 Jul 2024 21:10:20 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 5/6] net: Slim down setup_net().
Date: Mon, 29 Jul 2024 14:08:00 -0700
Message-ID: <20240729210801.16196-6-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240729210801.16196-1-kuniyu@amazon.com>
References: <20240729210801.16196-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D032UWB004.ant.amazon.com (10.13.139.136) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Most initialisations in setup_net() do not require pernet_ops_rwsem
and can be moved to preinit_net().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/core/net_namespace.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index f1b6cea7a9b6..7498f2cebbfe 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -310,16 +310,26 @@ struct net *get_net_ns_by_id(const struct net *net, int id)
 EXPORT_SYMBOL_GPL(get_net_ns_by_id);
 
 /* init code that must occur even if setup_net() is not called. */
-static __net_init void preinit_net(struct net *net)
+static __net_init void preinit_net(struct net *net, struct user_namespace *user_ns)
 {
 	refcount_set(&net->passive, 1);
+	refcount_set(&net->ns.count, 1);
+	ref_tracker_dir_init(&net->refcnt_tracker, 128, "net refcnt");
 	ref_tracker_dir_init(&net->notrefcnt_tracker, 128, "net notrefcnt");
+
+	get_random_bytes(&net->hash_mix, sizeof(u32));
+	net->dev_base_seq = 1;
+	net->user_ns = user_ns;
+
+	idr_init(&net->netns_ids);
+	spin_lock_init(&net->nsid_lock);
+	mutex_init(&net->ipv4.ra_mutex);
 }
 
 /*
  * setup_net runs the initializers for the network namespace object.
  */
-static __net_init int setup_net(struct net *net, struct user_namespace *user_ns)
+static __net_init int setup_net(struct net *net)
 {
 	/* Must be called with pernet_ops_rwsem held */
 	const struct pernet_operations *ops, *saved_ops;
@@ -327,18 +337,9 @@ static __net_init int setup_net(struct net *net, struct user_namespace *user_ns)
 	LIST_HEAD(dev_kill_list);
 	int error = 0;
 
-	refcount_set(&net->ns.count, 1);
-	ref_tracker_dir_init(&net->refcnt_tracker, 128, "net refcnt");
-
-	get_random_bytes(&net->hash_mix, sizeof(u32));
 	preempt_disable();
 	net->net_cookie = gen_cookie_next(&net_cookie);
 	preempt_enable();
-	net->dev_base_seq = 1;
-	net->user_ns = user_ns;
-	idr_init(&net->netns_ids);
-	spin_lock_init(&net->nsid_lock);
-	mutex_init(&net->ipv4.ra_mutex);
 
 	list_for_each_entry(ops, &pernet_list, list) {
 		error = ops_init(ops, net);
@@ -497,7 +498,7 @@ struct net *copy_net_ns(unsigned long flags,
 		goto dec_ucounts;
 	}
 
-	preinit_net(net);
+	preinit_net(net, user_ns);
 	net->ucounts = ucounts;
 	get_user_ns(user_ns);
 
@@ -505,7 +506,7 @@ struct net *copy_net_ns(unsigned long flags,
 	if (rv < 0)
 		goto put_userns;
 
-	rv = setup_net(net, user_ns);
+	rv = setup_net(net);
 
 	up_read(&pernet_ops_rwsem);
 
@@ -1199,10 +1200,10 @@ void __init net_ns_init(void)
 #ifdef CONFIG_KEYS
 	init_net.key_domain = &init_net_key_domain;
 #endif
-	preinit_net(&init_net);
+	preinit_net(&init_net, &init_user_ns);
 
 	down_write(&pernet_ops_rwsem);
-	if (setup_net(&init_net, &init_user_ns))
+	if (setup_net(&init_net))
 		panic("Could not setup the initial network namespace");
 
 	init_net_initialized = true;
-- 
2.30.2


