Return-Path: <netdev+bounces-132265-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E6D99124C
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 00:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 455F21C22658
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 22:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 465681AE009;
	Fri,  4 Oct 2024 22:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="gIjI48Em"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A775231C80
	for <netdev@vger.kernel.org>; Fri,  4 Oct 2024 22:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728080726; cv=none; b=metwNA9jIk0y3eYW+s7pfxVInuBCPvWq2aZ8IIvkFvDIzrIVa5DoKL/uDrCNukJkwNfKQ6M7Y66BzXGqw9eedUkauUnpmTTE3dJF+O2nZxH+oKyh18Tap4LhEcK+IoW7xcInBwsO0Tak8lH1usr+8UizSt+yrIhN8N4YMfhiSrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728080726; c=relaxed/simple;
	bh=DoYHM5EB6pZkyhbwuxrVTCMFKPSezGGsWKo7i+noN7w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BWzUQEOIjafBiczWCSZdVBSnq8pzjUJPUaHzgzYJflwtypX3VTF5ByK9qYLS51sbVBVcP2biQzVBtP21heyYvV8FQns5qYa9pBOux7kWWtG7P2yzQlbGuo/OvKZAIxuiukoqy0e1NUaFSyJGPS6oN25lj7IWyHRxkhM/Wcs9uMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=gIjI48Em; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728080725; x=1759616725;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OTB5nJR3EjIJ1YjlFz4A7YqKJObwtjuQmwmzlF/CqxM=;
  b=gIjI48EmYW8GDxt6MCGeMoeOWmGXzIf4V3TZ/5oq2eWmjI/TkK3zTMqz
   X5kLNio7vb1KnllV6G8nui0fPrqud/7qIB13NZA7ON4TawrujQqDaTDff
   oAjk3reBQDDCruEca9CExe3k9wdkT/vDem7gln8wOnnFqSEdZWqduJXhb
   Q=;
X-IronPort-AV: E=Sophos;i="6.11,178,1725321600"; 
   d="scan'208";a="663830981"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 22:25:23 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:33558]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.41.198:2525] with esmtp (Farcaster)
 id 1ff42ff3-3ec6-4257-8c78-656f1f25115a; Fri, 4 Oct 2024 22:25:22 +0000 (UTC)
X-Farcaster-Flow-ID: 1ff42ff3-3ec6-4257-8c78-656f1f25115a
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 4 Oct 2024 22:25:21 +0000
Received: from 88665a182662.ant.amazon.com (10.88.184.239) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Fri, 4 Oct 2024 22:25:19 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>, Roopa Prabhu
	<roopa@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH v2 net 3/6] bridge: Handle error of rtnl_register_module().
Date: Fri, 4 Oct 2024 15:23:55 -0700
Message-ID: <20241004222358.79129-4-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20241004222358.79129-1-kuniyu@amazon.com>
References: <20241004222358.79129-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWB003.ant.amazon.com (10.13.138.93) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Since introduced, br_vlan_rtnl_init() has been ignoring the returned
value of rtnl_register_module(), which could fail.

Let's handle the errors by rtnl_register_module_many().

Fixes: 8dcea187088b ("net: bridge: vlan: add rtm definitions and dump support")
Fixes: f26b296585dc ("net: bridge: vlan: add new rtm message support")
Fixes: adb3ce9bcb0f ("net: bridge: vlan: add del rtm message support")
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
Cc: Roopa Prabhu <roopa@nvidia.com>
Cc: Nikolay Aleksandrov <razor@blackwall.org>
---
 net/bridge/br_netlink.c |  6 +++++-
 net/bridge/br_private.h |  5 +++--
 net/bridge/br_vlan.c    | 19 +++++++++----------
 3 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
index f17dbac7d828..6b97ae47f855 100644
--- a/net/bridge/br_netlink.c
+++ b/net/bridge/br_netlink.c
@@ -1920,7 +1920,10 @@ int __init br_netlink_init(void)
 {
 	int err;
 
-	br_vlan_rtnl_init();
+	err = br_vlan_rtnl_init();
+	if (err)
+		goto out;
+
 	rtnl_af_register(&br_af_ops);
 
 	err = rtnl_link_register(&br_link_ops);
@@ -1931,6 +1934,7 @@ int __init br_netlink_init(void)
 
 out_af:
 	rtnl_af_unregister(&br_af_ops);
+out:
 	return err;
 }
 
diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index d4bedc87b1d8..041f6e571a20 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -1571,7 +1571,7 @@ void br_vlan_get_stats(const struct net_bridge_vlan *v,
 void br_vlan_port_event(struct net_bridge_port *p, unsigned long event);
 int br_vlan_bridge_event(struct net_device *dev, unsigned long event,
 			 void *ptr);
-void br_vlan_rtnl_init(void);
+int br_vlan_rtnl_init(void);
 void br_vlan_rtnl_uninit(void);
 void br_vlan_notify(const struct net_bridge *br,
 		    const struct net_bridge_port *p,
@@ -1802,8 +1802,9 @@ static inline int br_vlan_bridge_event(struct net_device *dev,
 	return 0;
 }
 
-static inline void br_vlan_rtnl_init(void)
+static inline int br_vlan_rtnl_init(void)
 {
+	return 0;
 }
 
 static inline void br_vlan_rtnl_uninit(void)
diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index 9c2fffb827ab..a9f00d72fe18 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -2296,19 +2296,18 @@ static int br_vlan_rtm_process(struct sk_buff *skb, struct nlmsghdr *nlh,
 	return err;
 }
 
-void br_vlan_rtnl_init(void)
+static struct rtnl_msg_handler br_vlan_rtnl_msg_handlers[] = {
+	{PF_BRIDGE, RTM_NEWVLAN, br_vlan_rtm_process, NULL, 0},
+	{PF_BRIDGE, RTM_DELVLAN, br_vlan_rtm_process, NULL, 0},
+	{PF_BRIDGE, RTM_GETVLAN, NULL, br_vlan_rtm_dump, 0},
+};
+
+int br_vlan_rtnl_init(void)
 {
-	rtnl_register_module(THIS_MODULE, PF_BRIDGE, RTM_GETVLAN, NULL,
-			     br_vlan_rtm_dump, 0);
-	rtnl_register_module(THIS_MODULE, PF_BRIDGE, RTM_NEWVLAN,
-			     br_vlan_rtm_process, NULL, 0);
-	rtnl_register_module(THIS_MODULE, PF_BRIDGE, RTM_DELVLAN,
-			     br_vlan_rtm_process, NULL, 0);
+	return rtnl_register_module_many(br_vlan_rtnl_msg_handlers);
 }
 
 void br_vlan_rtnl_uninit(void)
 {
-	rtnl_unregister(PF_BRIDGE, RTM_GETVLAN);
-	rtnl_unregister(PF_BRIDGE, RTM_NEWVLAN);
-	rtnl_unregister(PF_BRIDGE, RTM_DELVLAN);
+	rtnl_unregister_many(br_vlan_rtnl_msg_handlers);
 }
-- 
2.30.2


