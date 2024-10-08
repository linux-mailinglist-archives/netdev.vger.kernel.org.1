Return-Path: <netdev+bounces-133281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8475799571C
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 20:49:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39DBC28A745
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 18:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85723212D19;
	Tue,  8 Oct 2024 18:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="V8/d545o"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0792521263C
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 18:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728413345; cv=none; b=saVT4wE6T0sDLBbbr/PQpiEij6qZRcnCiMRc1rNIsLnEjggjbiEAJOYSeEJr5u3uwJlxHnINLrFDwryhfGtZzVz/uKuaXAQ+kZ3lHJJjLsnZOZ9KAUxHk+1cXLoSBaydKpZze185hQPwgW+znGgaDwLyuBK3SeyLoNrn25/Ca10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728413345; c=relaxed/simple;
	bh=OwGh8MA8pLemWFC3sOze3ryhGwij3MYcPe1BITIMFSQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I7Lclss0JVLEGvnefbMRcB+dUvFaYjsDz0hbtGRaPAjbGqvWx4DHhnc4bFCAh3QyFBrHfWpbYhoouAUkzn9AKvI/5r0vWm7tfSMtTu1xfOnJ3EslEWeDdpxqC71aNClI8rtzIMmtc1Zo2V82ccLIxsrQah7UgFu3g0H+lM4vSCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=V8/d545o; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728413344; x=1759949344;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iYSSflwZIecHgAVpq5mdBRyV+0LcZVBOTxgMimYT0sc=;
  b=V8/d545oJlRpiXDkuiC9BC/IZa0XrklnCM74iU5qav+fl79MAb9bRR+C
   Z1zx4vPwAc7VcRpsPdHAuC0Qk8ZLO2tI6wSbuHB/nPHMcgyGnSanSsK6Z
   nD8nus2ZBW5rbyXVTqCfFdagggmlWwuiwqTXJQGZqD26/CbJcxUjmyfQn
   4=;
X-IronPort-AV: E=Sophos;i="6.11,187,1725321600"; 
   d="scan'208";a="136231692"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 18:49:02 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:60234]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.20.142:2525] with esmtp (Farcaster)
 id 6515524e-fe03-4dcf-80da-c2a9a38bc463; Tue, 8 Oct 2024 18:49:02 +0000 (UTC)
X-Farcaster-Flow-ID: 6515524e-fe03-4dcf-80da-c2a9a38bc463
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 8 Oct 2024 18:49:01 +0000
Received: from 88665a182662.ant.amazon.com (10.187.170.17) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Tue, 8 Oct 2024 18:48:59 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>, Nikolay Aleksandrov
	<razor@blackwall.org>, Roopa Prabhu <roopa@nvidia.com>
Subject: [PATCH v4 net 3/6] bridge: Handle error of rtnl_register_module().
Date: Tue, 8 Oct 2024 11:47:34 -0700
Message-ID: <20241008184737.9619-4-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20241008184737.9619-1-kuniyu@amazon.com>
References: <20241008184737.9619-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWB002.ant.amazon.com (10.13.138.97) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Since introduced, br_vlan_rtnl_init() has been ignoring the returned
value of rtnl_register_module(), which could fail silently.

Handling the error allows users to view a module as an all-or-nothing
thing in terms of the rtnetlink functionality.  This prevents syzkaller
from reporting spurious errors from its tests, where OOM often occurs
and module is automatically loaded.

Let's handle the errors by rtnl_register_many().

Fixes: 8dcea187088b ("net: bridge: vlan: add rtm definitions and dump support")
Fixes: f26b296585dc ("net: bridge: vlan: add new rtm message support")
Fixes: adb3ce9bcb0f ("net: bridge: vlan: add del rtm message support")
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
---
Cc: Roopa Prabhu <roopa@nvidia.com>

v3: Add more context in changelog
v2: Make rtnl_msg_handler const
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
index 9c2fffb827ab..89f51ea4cabe 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -2296,19 +2296,18 @@ static int br_vlan_rtm_process(struct sk_buff *skb, struct nlmsghdr *nlh,
 	return err;
 }
 
-void br_vlan_rtnl_init(void)
+static const struct rtnl_msg_handler br_vlan_rtnl_msg_handlers[] = {
+	{THIS_MODULE, PF_BRIDGE, RTM_NEWVLAN, br_vlan_rtm_process, NULL, 0},
+	{THIS_MODULE, PF_BRIDGE, RTM_DELVLAN, br_vlan_rtm_process, NULL, 0},
+	{THIS_MODULE, PF_BRIDGE, RTM_GETVLAN, NULL, br_vlan_rtm_dump, 0},
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
+	return rtnl_register_many(br_vlan_rtnl_msg_handlers);
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


