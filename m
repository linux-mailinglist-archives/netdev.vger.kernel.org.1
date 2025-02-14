Return-Path: <netdev+bounces-166333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F3D8A358C1
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 09:21:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AC351892C74
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 08:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 579C82222A9;
	Fri, 14 Feb 2025 08:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="fMbvZUP4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E70221D8B
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 08:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739521172; cv=none; b=Ik0/2hBINRJSq0xVf38HFO8BxQKf6VAAZV6ZiPraOIEFWSqGI5hNwf0We1KgOnC3EihiEyu1LsFjR2cH22JYibH5ZhfryDTgCxQxZ4AjWYc5AtrB+iYh5CxeoknD3T/LyG4XbD9QjohdThBD8b9uNCHWGAb1xfNVqiRxj++Yph8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739521172; c=relaxed/simple;
	bh=0DF0tiBuRLg1cqw2/GAeKCP6a9i9+E5SheSUZ5PEjZc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OmyTJLgUr7X7nruQJcRfl4kO6tWr0YJUmu+U3NzxmmL2f+4S/X5knidzRVVrZXjjZAShUqjUIUhT1Ap5CJ+Y7JepKo7gOYdFGnk9KFbT2rOWyYUjaSJudaLlm0X3AMFL2700GoGZmPWMhubsA1M+vCoRUvEMVQULcAYFgkvtt0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=fMbvZUP4; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1739521171; x=1771057171;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OcIfFwdjbRLcEEr6/YWi/r3QPaIXQWMNeM5vm/mrTrQ=;
  b=fMbvZUP4gJXJtu8Us1OF0/+ND4DXoKcEP0/dpAeXh1dJe69YmT8D/7lR
   fOGDn+fFmotSFKato0syb1lf4Jn9YtqjwMEpvG5iOAC91RSMy8iH2Y1g3
   yXMiubMsLAwOoPoVKstTArxyz0F/hVq8p5Of8hKUpDHV3DeYc2SdnC6pA
   s=;
X-IronPort-AV: E=Sophos;i="6.13,285,1732579200"; 
   d="scan'208";a="718726583"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 08:19:29 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:29327]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.41.245:2525] with esmtp (Farcaster)
 id e693f473-31d9-40ee-a022-1f5ee1a2a83c; Fri, 14 Feb 2025 08:19:28 +0000 (UTC)
X-Farcaster-Flow-ID: e693f473-31d9-40ee-a022-1f5ee1a2a83c
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 14 Feb 2025 08:19:27 +0000
Received: from 6c7e67bfbae3.amazon.com (10.118.254.117) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 14 Feb 2025 08:19:24 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 2/3] ppp: Split ppp_exit_net() to ->exit_batch_rtnl().
Date: Fri, 14 Feb 2025 17:18:17 +0900
Message-ID: <20250214081818.81658-3-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250214081818.81658-1-kuniyu@amazon.com>
References: <20250214081818.81658-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWA004.ant.amazon.com (10.13.139.85) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

ppp_exit_net() unregisters devices related to the netns under RTNL and
destroys lists and IDR.

Let's move the device unregistration to ->exit_batch_rtnl() to save RTNL
dances for each netns.

While at it, unregister_netdevice_queue() is replaced with ppp_nl_dellink()
to avoid a potential issue like the one recently found in geneve. [0]

Note that ppp_nl_dellink() is bare unregister_netdevice_queue().

Link: https://lore.kernel.org/netdev/20250213043354.91368-1-kuniyu@amazon.com/ [0]
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 drivers/net/ppp/ppp_generic.c | 33 ++++++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.c
index 4583e15ad03a..560fcc495cd8 100644
--- a/drivers/net/ppp/ppp_generic.c
+++ b/drivers/net/ppp/ppp_generic.c
@@ -1134,28 +1134,38 @@ static __net_init int ppp_init_net(struct net *net)
 	return 0;
 }
 
-static __net_exit void ppp_exit_net(struct net *net)
+static void ppp_nl_dellink(struct net_device *dev, struct list_head *head);
+
+static __net_exit void ppp_destroy_links(struct net *net,
+					 struct list_head *dev_kill_list)
 {
 	struct ppp_net *pn = net_generic(net, ppp_net_id);
-	struct net_device *dev;
-	struct net_device *aux;
+	struct net_device *dev, *aux;
 	struct ppp *ppp;
-	LIST_HEAD(list);
 	int id;
 
-	rtnl_lock();
-	for_each_netdev_safe(net, dev, aux) {
+	for_each_netdev_safe(net, dev, aux)
 		if (dev->netdev_ops == &ppp_netdev_ops)
-			unregister_netdevice_queue(dev, &list);
-	}
+			ppp_nl_dellink(dev, dev_kill_list);
 
 	idr_for_each_entry(&pn->units_idr, ppp, id)
 		/* Skip devices already unregistered by previous loop */
 		if (!net_eq(dev_net(ppp->dev), net))
-			unregister_netdevice_queue(ppp->dev, &list);
+			ppp_nl_dellink(ppp->dev, dev_kill_list);
+}
 
-	unregister_netdevice_many(&list);
-	rtnl_unlock();
+static __net_exit void ppp_exit_net_batch_rtnl(struct list_head *net_exit_list,
+					       struct list_head *dev_kill_list)
+{
+	struct net *net;
+
+	list_for_each_entry(net, net_exit_list, exit_list)
+		ppp_destroy_links(net, dev_kill_list);
+}
+
+static __net_exit void ppp_exit_net(struct net *net)
+{
+	struct ppp_net *pn = net_generic(net, ppp_net_id);
 
 	mutex_destroy(&pn->all_ppp_mutex);
 	idr_destroy(&pn->units_idr);
@@ -1165,6 +1175,7 @@ static __net_exit void ppp_exit_net(struct net *net)
 
 static struct pernet_operations ppp_net_ops = {
 	.init = ppp_init_net,
+	.exit_batch_rtnl = ppp_exit_net_batch_rtnl,
 	.exit = ppp_exit_net,
 	.id   = &ppp_net_id,
 	.size = sizeof(struct ppp_net),
-- 
2.39.5 (Apple Git-154)


