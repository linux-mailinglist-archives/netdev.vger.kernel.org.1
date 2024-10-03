Return-Path: <netdev+bounces-131773-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C639A98F855
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 22:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40CB9B21FE5
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 20:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F451A7AF6;
	Thu,  3 Oct 2024 20:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="CejUEVDA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84C912EBDB
	for <netdev@vger.kernel.org>; Thu,  3 Oct 2024 20:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727989135; cv=none; b=T8yCGwWaTzWI3F/grhPSPAaSkxjOE6i9rBSmdleSYmOW4RavV2tLpWF3Z+W837KKO0+boGxZfU2nx+cLOKGxMGgtIHhJXMgMYq7L2pIqGVqw+rO8uioek+PdXhXOVtIxNq+quwwOPC5ypXLe/IOMISL7ibA0NSl6jKDGVsOOcgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727989135; c=relaxed/simple;
	bh=DoYHM5EB6pZkyhbwuxrVTCMFKPSezGGsWKo7i+noN7w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oBsG8bkTRpiF2f3OppOQFOsejwqR9rJGF2OfhkTu+uoXoauzSsv84yOhb5It2RNAimOoSVbwP2vPq/4MgSj0iK8wlX8W6oxvfZO8hd7jkkM8j6UmFW3/WA1OJad9OlXptN3t8BwW40fU/koCMCDXrjGJ/YNBA0zrE9YS7MC0zH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=CejUEVDA; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1727989134; x=1759525134;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OTB5nJR3EjIJ1YjlFz4A7YqKJObwtjuQmwmzlF/CqxM=;
  b=CejUEVDAha+f1q63LijDpmHBrfTPL11RBALGkII92oPJ9lwoCuuUcfn7
   K4LwEgyM0oddfPXBnUa1KmAPflqUNWEAVguG9CCzNtX/SUSbh33yeg5ic
   KMxHWhmWPjy8NkGhrfmz6dQ0DbE21z+MHpBxntZg4BWyupcEGEKqGgOvh
   A=;
X-IronPort-AV: E=Sophos;i="6.11,175,1725321600"; 
   d="scan'208";a="236583996"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 20:58:51 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:33522]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.22.18:2525] with esmtp (Farcaster)
 id 027bc79e-0094-4707-8a05-0d03ff340685; Thu, 3 Oct 2024 20:58:49 +0000 (UTC)
X-Farcaster-Flow-ID: 027bc79e-0094-4707-8a05-0d03ff340685
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 3 Oct 2024 20:58:48 +0000
Received: from 88665a182662.ant.amazon.com (10.187.171.32) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Thu, 3 Oct 2024 20:58:46 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>, Roopa Prabhu
	<roopa@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH v1 net 3/6] bridge: Handle error of rtnl_register_module().
Date: Thu, 3 Oct 2024 13:57:22 -0700
Message-ID: <20241003205725.5612-4-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20241003205725.5612-1-kuniyu@amazon.com>
References: <20241003205725.5612-1-kuniyu@amazon.com>
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


