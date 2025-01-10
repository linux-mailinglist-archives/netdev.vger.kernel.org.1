Return-Path: <netdev+bounces-156929-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6149AA08503
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 02:48:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29F16188C09E
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 01:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3C7713DDAE;
	Fri, 10 Jan 2025 01:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="YltssnMN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3323442A99
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 01:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736473720; cv=none; b=peWjud25jF8e3dPVUIKgCa8C37b3U7LK3CUiLCaBittV0W4mukbMS8Bio9HobR9wFBuvR0+FysrdMKCbA3Tr1hSkJ4b5yL6lfZhJuak8xXYZS+Z3CUFQkXR11j18SYx7s5WVPdjaV57vTLN5FFvoxu5LMyaxgtAQsMgzlOM7zhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736473720; c=relaxed/simple;
	bh=50m2pC9NuA/0XhngWGXrvw+rDKZyM6Ad/aJ7t6JcUhw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sU3wrTcLVZiyRa0kwJG0DfnMMoFtRTSXt0d21tHAFktyfdK9w/CYqc3kGQ5+LhsPCy7c0orzUpT2NUNhPWJviSTokZNvI6p/awsPfSGHx5ZScGotDkCmH/QSWXhnHGzlXb26RLC+58P9DiVjTW0x19FzfKB0nd9xmXQcsv/GCmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=YltssnMN; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1736473719; x=1768009719;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3UUFt//l67m4OlxLv2LFPNm5Aug5HU0n9eHT9CMvQfQ=;
  b=YltssnMNin86L4rP1zbbv5z66k1ukfg9wAhHGLKZcwrdPEw2aseKP3p3
   2bx9/zNjTXwV1yHMIDFW8K5Hh7gbqWrKq0E+2sdpxf1ys4JE8IRKPBzh3
   6SVgJstKQpniCV7xJRilw9sHMGb9mhPSQ9bnk9nH2AWCDuSkiAMtEG5Q6
   c=;
X-IronPort-AV: E=Sophos;i="6.12,302,1728950400"; 
   d="scan'208";a="163107389"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2025 01:48:37 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.7.35:31334]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.0.73:2525] with esmtp (Farcaster)
 id fbf35876-19e5-44ac-add9-e3875af74a57; Fri, 10 Jan 2025 01:48:37 +0000 (UTC)
X-Farcaster-Flow-ID: fbf35876-19e5-44ac-add9-e3875af74a57
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 10 Jan 2025 01:48:36 +0000
Received: from 6c7e67c6786f.amazon.com (10.118.252.101) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 10 Jan 2025 01:48:32 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman
	<horms@kernel.org>
CC: Xiao Liang <shaw.leon@gmail.com>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net 1/3] gtp: Use for_each_netdev_rcu() in gtp_genl_dump_pdp().
Date: Fri, 10 Jan 2025 10:47:52 +0900
Message-ID: <20250110014754.33847-2-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250110014754.33847-1-kuniyu@amazon.com>
References: <20250110014754.33847-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D043UWC001.ant.amazon.com (10.13.139.202) To
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
v2:
  * Fix uninit variable (gtp) and remove unused var (gn) in gtp_genl_dump_pdp().

v1: https://lore.kernel.org/netdev/20250108062834.11117-2-kuniyu@amazon.com/
---
 drivers/net/gtp.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index 89a996ad8cd0..0f9cb0c378af 100644
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
 
@@ -2271,16 +2271,19 @@ static int gtp_genl_dump_pdp(struct sk_buff *skb,
 	struct gtp_dev *last_gtp = (struct gtp_dev *)cb->args[2], *gtp;
 	int i, j, bucket = cb->args[0], skip = cb->args[1];
 	struct net *net = sock_net(skb->sk);
+	struct net_device *dev;
 	struct pdp_ctx *pctx;
-	struct gtp_net *gn;
-
-	gn = net_generic(net, gtp_net_id);
 
 	if (cb->args[4])
 		return 0;
 
 	rcu_read_lock();
-	list_for_each_entry_rcu(gtp, &gn->gtp_dev_list, list) {
+	for_each_netdev_rcu(net, dev) {
+		if (dev->rtnl_link_ops != &gtp_link_ops)
+			continue;
+
+		gtp = netdev_priv(dev);
+
 		if (last_gtp && last_gtp != gtp)
 			continue;
 		else
@@ -2475,9 +2478,9 @@ static void __net_exit gtp_net_exit_batch_rtnl(struct list_head *net_list,
 
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


