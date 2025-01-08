Return-Path: <netdev+bounces-156165-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9EFA05332
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 07:29:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23D767A22F8
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 06:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 270EB1A4F1B;
	Wed,  8 Jan 2025 06:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="TJlkn+vB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7BB38389
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 06:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736317775; cv=none; b=Q7X+/ghHauDS4mhUmyJzG4D5k3nTJN853TYEUOR5802CEY7YXuSgacJNEKnZaoAHvtjQ8VsbkxkTSkBNR/hdp2dfldVi8J+BVhT5zSP4ESL/FMNg4nGTcpchsRR3eQJ2VMtMF71wgMxhs+YLTnAmyf4AkJ8LtCC7ebwhl3f35PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736317775; c=relaxed/simple;
	bh=Nxj0hl0OPFXBacpdHSg6ovA6GH4jzl4c8ay1VhwW590=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rgqRkW4hK+aqkyNH2XKvvdlVmhSwsxmpT57RNNfxZdnhmGk6BaBFpMvyckx8a/KCHQA7IARMl2MOkY6bdisovLw+8lVhxwFe4TLCkTS3cadcZ7NaMCtCCN/6OSNrLWtDuYdgd0gRRyq4ZDzmx+xbmPqUxXJZtQAbShjLP4GN4Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=TJlkn+vB; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1736317772; x=1767853772;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GqwVe1zn1ET65C4qioY4ezbos/U9viUXr1Md0+QqIY4=;
  b=TJlkn+vBrwf7aDMkl44cgueOd0mAFIDBHc3g+RxbZUm6EJwgvY8hNgeB
   7ehMPOy9TYpkAzQ4gyCWk8Jk5l/bap7ZYKDKv6wpAT4HE3dTbKQf6yoB3
   /zJBIuL8juT2n2DbOOFwQt9atQokzv1OGpy/0c5QudZbrQnBG2c3quGtx
   s=;
X-IronPort-AV: E=Sophos;i="6.12,297,1728950400"; 
   d="scan'208";a="261482426"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2025 06:29:28 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:32308]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.18.128:2525] with esmtp (Farcaster)
 id 88dd9e75-3e7f-4b1d-b316-ceed29fec157; Wed, 8 Jan 2025 06:29:16 +0000 (UTC)
X-Farcaster-Flow-ID: 88dd9e75-3e7f-4b1d-b316-ceed29fec157
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Wed, 8 Jan 2025 06:29:16 +0000
Received: from 6c7e67c6786f.amazon.com (10.37.244.7) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Wed, 8 Jan 2025 06:29:12 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman
	<horms@kernel.org>
CC: Xiao Liang <shaw.leon@gmail.com>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>, "Pablo
 Neira Ayuso" <pablo@netfilter.org>, Harald Welte <laforge@gnumonks.org>
Subject: [PATCH v1 net 1/3] gtp: Use for_each_netdev_rcu() in gtp_genl_dump_pdp().
Date: Wed, 8 Jan 2025 15:28:32 +0900
Message-ID: <20250108062834.11117-2-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250108062834.11117-1-kuniyu@amazon.com>
References: <20250108062834.11117-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWB004.ant.amazon.com (10.13.139.150) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

gtp_newlink() links the gtp device to a list in dev_net(dev).

However, even after the gtp device is moved to another netns,
it stays on the list but should be invisible.

Let's use for_each_netdev_rcu() for netdev traversal in
gtp_genl_dump_pdp().

Note that gtp_dev_list is no longer used under RCU, so list
helpers are converted to the non-RCU variant.

Fixes: 459aa660eb1d ("gtp: add initial driver for datapath of GPRS Tunneling Protocol (GTP-U)")
Reported-by: Xiao Liang <shaw.leon@gmail.com>
Closes: https://lore.kernel.org/netdev/CABAhCOQdBL6h9M2C+kd+bGivRJ9Q72JUxW+-gur0nub_=PmFPA@mail.gmail.com/
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
Cc: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Harald Welte <laforge@gnumonks.org>
---
 drivers/net/gtp.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index 89a996ad8cd0..8e456d09d173 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -1525,7 +1525,7 @@ static int gtp_newlink(struct net *src_net, struct net_device *dev,
 	}
 
 	gn = net_generic(dev_net(dev), gtp_net_id);
-	list_add_rcu(&gtp->list, &gn->gtp_dev_list);
+	list_add(&gtp->list, &gn->gtp_dev_list);
 	dev->priv_destructor = gtp_destructor;
 
 	netdev_dbg(dev, "registered new GTP interface\n");
@@ -1551,7 +1551,7 @@ static void gtp_dellink(struct net_device *dev, struct list_head *head)
 		hlist_for_each_entry_safe(pctx, next, &gtp->tid_hash[i], hlist_tid)
 			pdp_context_delete(pctx);
 
-	list_del_rcu(&gtp->list);
+	list_del(&gtp->list);
 	unregister_netdevice_queue(dev, head);
 }
 
@@ -2271,6 +2271,7 @@ static int gtp_genl_dump_pdp(struct sk_buff *skb,
 	struct gtp_dev *last_gtp = (struct gtp_dev *)cb->args[2], *gtp;
 	int i, j, bucket = cb->args[0], skip = cb->args[1];
 	struct net *net = sock_net(skb->sk);
+	struct net_device *dev;
 	struct pdp_ctx *pctx;
 	struct gtp_net *gn;
 
@@ -2280,7 +2281,10 @@ static int gtp_genl_dump_pdp(struct sk_buff *skb,
 		return 0;
 
 	rcu_read_lock();
-	list_for_each_entry_rcu(gtp, &gn->gtp_dev_list, list) {
+	for_each_netdev_rcu(net, dev) {
+		if (dev->rtnl_link_ops != &gtp_link_ops)
+			continue;
+
 		if (last_gtp && last_gtp != gtp)
 			continue;
 		else
@@ -2475,9 +2479,9 @@ static void __net_exit gtp_net_exit_batch_rtnl(struct list_head *net_list,
 
 	list_for_each_entry(net, net_list, exit_list) {
 		struct gtp_net *gn = net_generic(net, gtp_net_id);
-		struct gtp_dev *gtp;
+		struct gtp_dev *gtp, *gtp_next;
 
-		list_for_each_entry(gtp, &gn->gtp_dev_list, list)
+		list_for_each_entry_safe(gtp, gtp_next, &gn->gtp_dev_list, list)
 			gtp_dellink(gtp->dev, dev_to_kill);
 	}
 }
-- 
2.39.5 (Apple Git-154)


