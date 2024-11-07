Return-Path: <netdev+bounces-142618-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3F79BFC8C
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 03:29:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFCE02831D9
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 02:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D20114293;
	Thu,  7 Nov 2024 02:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="BGE2i9nJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CD380C02
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 02:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730946579; cv=none; b=MPvY2oA+9PvxhwC3HG07TbL5ORLGB04uSfRgnOUVQ81JWXabs34M3nfdfNnI1CuPw1SzlKMjsghzv/quYXCNELMOa/L5Azsu+1nOEBCzpmZGMzXc+JWaQf/dD9x5T8mIfzzQnU7ZuJKEEcn7J0kskQGCqlbWl1oAh1bR6W8WUlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730946579; c=relaxed/simple;
	bh=A5yFrHuYHZNaGzCLsJV6QufPnyI+DOOweGlzQKf349U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J7Q1uyy11r2K/RL+Xc4wLP7QtGsCCMJwQyA+T0HNKtkKS1jqeD9wjzxuIJSj8agBVxw2oD+400KdibU3LbxCNdgTzmQLXarGJsk8SOJ3Sc2vzIap/fBouPb/mmOFQSg2a0L0DwWGJFKQbPwEytrXHysSNFf1Jtkm5A8fy0NqYg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=BGE2i9nJ; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1730946578; x=1762482578;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ve8WOZGB8tbWPwPK4Glo+DzhyKEPszzokK41pqMDMe8=;
  b=BGE2i9nJowcGRN1aHPTksOMarCevlyItQd3ov5SWA4YcFa4KvBCW3TNJ
   aFV/1p9UJUYABmaUA/0i+FaisVmcOAubnXEarsiLMP9RFbVqAtBlXoBZ4
   zwg0M/IesRfesUiSCvlUFnhdeFk2PsSHvshAtkwrR50CVKLS9MNTBiPJq
   U=;
X-IronPort-AV: E=Sophos;i="6.11,264,1725321600"; 
   d="scan'208";a="467798814"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 02:29:32 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:34071]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.54.53:2525] with esmtp (Farcaster)
 id 738ee042-4e68-4743-9505-02e6a61eed57; Thu, 7 Nov 2024 02:29:31 +0000 (UTC)
X-Farcaster-Flow-ID: 738ee042-4e68-4743-9505-02e6a61eed57
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 7 Nov 2024 02:29:31 +0000
Received: from 6c7e67c6786f.amazon.com (10.106.101.27) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Thu, 7 Nov 2024 02:29:27 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, Marc Kleine-Budde
	<mkl@pengutronix.de>, Vincent Mailhol <mailhol.vincent@wanadoo.fr>, "Daniel
 Borkmann" <daniel@iogearbox.net>, Nikolay Aleksandrov <razor@blackwall.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v3 net-next 01/10] rtnetlink: Remove __rtnl_link_unregister().
Date: Wed, 6 Nov 2024 18:28:51 -0800
Message-ID: <20241107022900.70287-2-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241107022900.70287-1-kuniyu@amazon.com>
References: <20241107022900.70287-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWA003.ant.amazon.com (10.13.139.18) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

rtnl_link_unregister() holds RTNL and calls __rtnl_link_unregister(),
where we call synchronize_srcu() to wait inflight RTM_NEWLINK requests
for per-netns RTNL.

We put synchronize_srcu() in __rtnl_link_unregister() due to ifb.ko
and dummy.ko.

However, rtnl_newlink() will acquire SRCU before RTNL later in this
series.  Then, lockdep will detect the deadlock:

   rtnl_link_unregister()       rtnl_newlink()
   ----                         ----
   lock(rtnl_mutex);
                                lock(&ops->srcu);
                                lock(rtnl_mutex);
   sync(&ops->srcu);

To avoid the problem, we must call synchronize_srcu() before RTNL in
rtnl_link_unregister().

As a preparation, let's remove __rtnl_link_unregister().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 drivers/net/dummy.c     |  6 +++++-
 drivers/net/ifb.c       |  6 +++++-
 include/net/rtnetlink.h |  1 -
 net/core/rtnetlink.c    | 32 ++++++++++----------------------
 4 files changed, 20 insertions(+), 25 deletions(-)

diff --git a/drivers/net/dummy.c b/drivers/net/dummy.c
index e9c5e1e11fa0..72618b6af44e 100644
--- a/drivers/net/dummy.c
+++ b/drivers/net/dummy.c
@@ -166,6 +166,7 @@ static int __init dummy_init_one(void)
 
 static int __init dummy_init_module(void)
 {
+	bool need_unregister = false;
 	int i, err = 0;
 
 	down_write(&pernet_ops_rwsem);
@@ -179,12 +180,15 @@ static int __init dummy_init_module(void)
 		cond_resched();
 	}
 	if (err < 0)
-		__rtnl_link_unregister(&dummy_link_ops);
+		need_unregister = true;
 
 out:
 	rtnl_unlock();
 	up_write(&pernet_ops_rwsem);
 
+	if (need_unregister)
+		rtnl_link_unregister(&dummy_link_ops);
+
 	return err;
 }
 
diff --git a/drivers/net/ifb.c b/drivers/net/ifb.c
index 2c1b5def4a0b..a4b9ec4e8f30 100644
--- a/drivers/net/ifb.c
+++ b/drivers/net/ifb.c
@@ -424,6 +424,7 @@ static int __init ifb_init_one(int index)
 
 static int __init ifb_init_module(void)
 {
+	bool need_unregister = false;
 	int i, err;
 
 	down_write(&pernet_ops_rwsem);
@@ -437,12 +438,15 @@ static int __init ifb_init_module(void)
 		cond_resched();
 	}
 	if (err)
-		__rtnl_link_unregister(&ifb_link_ops);
+		need_unregister = true;
 
 out:
 	rtnl_unlock();
 	up_write(&pernet_ops_rwsem);
 
+	if (need_unregister)
+		rtnl_link_unregister(&ifb_link_ops);
+
 	return err;
 }
 
diff --git a/include/net/rtnetlink.h b/include/net/rtnetlink.h
index b260c0cc9671..3ebfcc6e56fd 100644
--- a/include/net/rtnetlink.h
+++ b/include/net/rtnetlink.h
@@ -165,7 +165,6 @@ struct rtnl_link_ops {
 };
 
 int __rtnl_link_register(struct rtnl_link_ops *ops);
-void __rtnl_link_unregister(struct rtnl_link_ops *ops);
 
 int rtnl_link_register(struct rtnl_link_ops *ops);
 void rtnl_link_unregister(struct rtnl_link_ops *ops);
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 3b33810d92a8..634732fe4c64 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -568,27 +568,6 @@ static void __rtnl_kill_links(struct net *net, struct rtnl_link_ops *ops)
 	unregister_netdevice_many(&list_kill);
 }
 
-/**
- * __rtnl_link_unregister - Unregister rtnl_link_ops from rtnetlink.
- * @ops: struct rtnl_link_ops * to unregister
- *
- * The caller must hold the rtnl_mutex and guarantee net_namespace_list
- * integrity (hold pernet_ops_rwsem for writing to close the race
- * with setup_net() and cleanup_net()).
- */
-void __rtnl_link_unregister(struct rtnl_link_ops *ops)
-{
-	struct net *net;
-
-	list_del_rcu(&ops->list);
-	synchronize_srcu(&ops->srcu);
-	cleanup_srcu_struct(&ops->srcu);
-
-	for_each_net(net)
-		__rtnl_kill_links(net, ops);
-}
-EXPORT_SYMBOL_GPL(__rtnl_link_unregister);
-
 /* Return with the rtnl_lock held when there are no network
  * devices unregistering in any network namespace.
  */
@@ -617,10 +596,19 @@ static void rtnl_lock_unregistering_all(void)
  */
 void rtnl_link_unregister(struct rtnl_link_ops *ops)
 {
+	struct net *net;
+
 	/* Close the race with setup_net() and cleanup_net() */
 	down_write(&pernet_ops_rwsem);
 	rtnl_lock_unregistering_all();
-	__rtnl_link_unregister(ops);
+
+	list_del_rcu(&ops->list);
+	synchronize_srcu(&ops->srcu);
+	cleanup_srcu_struct(&ops->srcu);
+
+	for_each_net(net)
+		__rtnl_kill_links(net, ops);
+
 	rtnl_unlock();
 	up_write(&pernet_ops_rwsem);
 }
-- 
2.39.5 (Apple Git-154)


