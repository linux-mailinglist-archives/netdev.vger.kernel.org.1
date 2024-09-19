Return-Path: <netdev+bounces-128875-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2155997C3ED
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 07:53:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5E05282488
	for <lists+netdev@lfdr.de>; Thu, 19 Sep 2024 05:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E397172F;
	Thu, 19 Sep 2024 05:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="VEmm4mbI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78416F099
	for <netdev@vger.kernel.org>; Thu, 19 Sep 2024 05:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726725201; cv=none; b=QTtvIEwKMI/TsNnrcMPahBcXvoTa5kdZROfGLWeXNTXTzLMYdaOViOwK9ERcctmPTug3e2Bvht+5q/D1OHuXQ1LRiSFoukMi/J3JQzATCMHxLlxovkxDtwdQUN2hsN2rctmPt1a3jVLayJlKERz2K3rVkTN/u/sWzWXnlsZ8tfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726725201; c=relaxed/simple;
	bh=GwLIALm8ZjuuYaEcLNjccCE3QLOamceAjZD0miqHMvU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dB/WPDSlCV/kymUYMjs9UZPOOVYs1jEz/hu2BEmSBlTggbOD3sUk9h7CnxCcQxMgcU1MzwGEbw7P1dAoymIoRpPjPbLO9RYFYyqwdyBEgE4mRcIJXQ7FvxrF1IYszWzrYn2pUYRMDobjBSVyOKptuL6LqPSAQ/SzYj//VOAK3yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=VEmm4mbI; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1726725199; x=1758261199;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DTaOdCW4glKiO8ftEkhDvgJ8xhBWXRcGQ/Gke4wkDzE=;
  b=VEmm4mbIi+isDbQNyJ/0+Ha3QgGw0evxWFd5t2l2p4Jc74hjPsbZ09pz
   hGWFoACDh8MB7N8zT745rXVamShSVuaN5KH4E8vUWLIk7ZIE9MqBCzZ3g
   5Bk3a8Smgb9YkYJb3OF1sLq3m2CkRrzuonLtkG9v0nxoOCp0r0UHhjHJr
   c=;
X-IronPort-AV: E=Sophos;i="6.10,240,1719878400"; 
   d="scan'208";a="127466920"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2024 05:53:16 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:3281]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.31.232:2525] with esmtp (Farcaster)
 id 68ddfcf0-f0a9-40f5-8562-c89df18a8ce2; Thu, 19 Sep 2024 05:53:16 +0000 (UTC)
X-Farcaster-Flow-ID: 68ddfcf0-f0a9-40f5-8562-c89df18a8ce2
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 19 Sep 2024 05:53:14 +0000
Received: from 88665a182662.ant.amazon.com.com (10.95.68.124) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Thu, 19 Sep 2024 05:53:10 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <antonio@openvpn.net>
CC: <andrew@lunn.ch>, <antony.antony@secunet.com>, <edumazet@google.com>,
	<kuba@kernel.org>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<ryazanov.s.a@gmail.com>, <sd@queasysnail.net>,
	<steffen.klassert@secunet.com>, <kuniyu@amazon.com>
Subject: Re: [PATCH net-next v7 03/25] net: introduce OpenVPN Data Channel Offload (ovpn)
Date: Thu, 19 Sep 2024 07:52:59 +0200
Message-ID: <20240919055259.17622-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240917010734.1905-4-antonio@openvpn.net>
References: <20240917010734.1905-4-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWA004.ant.amazon.com (10.13.139.76) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Antonio Quartulli <antonio@openvpn.net>
Date: Tue, 17 Sep 2024 03:07:12 +0200
> +/* we register with rtnl to let core know that ovpn is a virtual driver and
> + * therefore ifaces should be destroyed when exiting a netns
> + */
> +static struct rtnl_link_ops ovpn_link_ops = {
> +};

This looks like abusing rtnl_link_ops.

Instead of a hack to rely on default_device_exit_batch()
and rtnl_link_unregister(), this should be implemented as
struct pernet_operations.exit_batch_rtnl().

Then, the patch 2 is not needed, which is confusing for
all other rtnl_link_ops users.

If we want to avoid extra RTNL in default_device_exit_batch(),
I can post this patch after merge window.

---8<---
diff --git a/net/core/dev.c b/net/core/dev.c
index 1e740faf9e78..eacf6f5a6ace 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -11916,7 +11916,8 @@ static void __net_exit default_device_exit_net(struct net *net)
 	}
 }
 
-static void __net_exit default_device_exit_batch(struct list_head *net_list)
+void __net_exit default_device_exit_batch(struct list_head *net_list,
+					  struct list_head *dev_kill_list)
 {
 	/* At exit all network devices most be removed from a network
 	 * namespace.  Do this in the reverse order of registration.
@@ -11925,9 +11926,7 @@ static void __net_exit default_device_exit_batch(struct list_head *net_list)
 	 */
 	struct net_device *dev;
 	struct net *net;
-	LIST_HEAD(dev_kill_list);
 
-	rtnl_lock();
 	list_for_each_entry(net, net_list, exit_list) {
 		default_device_exit_net(net);
 		cond_resched();
@@ -11936,19 +11935,13 @@ static void __net_exit default_device_exit_batch(struct list_head *net_list)
 	list_for_each_entry(net, net_list, exit_list) {
 		for_each_netdev_reverse(net, dev) {
 			if (dev->rtnl_link_ops && dev->rtnl_link_ops->dellink)
-				dev->rtnl_link_ops->dellink(dev, &dev_kill_list);
+				dev->rtnl_link_ops->dellink(dev, dev_kill_list);
 			else
-				unregister_netdevice_queue(dev, &dev_kill_list);
+				unregister_netdevice_queue(dev, dev_kill_list);
 		}
 	}
-	unregister_netdevice_many(&dev_kill_list);
-	rtnl_unlock();
 }
 
-static struct pernet_operations __net_initdata default_device_ops = {
-	.exit_batch = default_device_exit_batch,
-};
-
 static void __init net_dev_struct_check(void)
 {
 	/* TX read-mostly hotpath */
@@ -12140,9 +12133,6 @@ static int __init net_dev_init(void)
 	if (register_pernet_device(&loopback_net_ops))
 		goto out;
 
-	if (register_pernet_device(&default_device_ops))
-		goto out;
-
 	open_softirq(NET_TX_SOFTIRQ, net_tx_action);
 	open_softirq(NET_RX_SOFTIRQ, net_rx_action);
 
diff --git a/net/core/dev.h b/net/core/dev.h
index 5654325c5b71..d1feecab9c4a 100644
--- a/net/core/dev.h
+++ b/net/core/dev.h
@@ -99,6 +99,9 @@ void __dev_notify_flags(struct net_device *dev, unsigned int old_flags,
 void unregister_netdevice_many_notify(struct list_head *head,
 				      u32 portid, const struct nlmsghdr *nlh);
 
+void default_device_exit_batch(struct list_head *net_list,
+			       struct list_head *dev_kill_list);
+
 static inline void netif_set_gso_max_size(struct net_device *dev,
 					  unsigned int size)
 {
diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index 11e4dd4f09ed..0a9bce599d54 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -27,6 +27,8 @@
 #include <net/net_namespace.h>
 #include <net/netns/generic.h>
 
+#include "dev.h"
+
 /*
  *	Our network namespace constructor/destructor lists
  */
@@ -380,6 +382,7 @@ static __net_init int setup_net(struct net *net)
 		if (ops->exit_batch_rtnl)
 			ops->exit_batch_rtnl(&net_exit_list, &dev_kill_list);
 	}
+	default_device_exit_batch(&net_exit_list, &dev_kill_list);
 	unregister_netdevice_many(&dev_kill_list);
 	rtnl_unlock();
 
@@ -618,6 +621,7 @@ static void cleanup_net(struct work_struct *work)
 		if (ops->exit_batch_rtnl)
 			ops->exit_batch_rtnl(&net_exit_list, &dev_kill_list);
 	}
+	default_device_exit_batch(&net_exit_list, &dev_kill_list);
 	unregister_netdevice_many(&dev_kill_list);
 	rtnl_unlock();
 
@@ -1214,6 +1218,7 @@ static void free_exit_list(struct pernet_operations *ops, struct list_head *net_
 
 		rtnl_lock();
 		ops->exit_batch_rtnl(net_exit_list, &dev_kill_list);
+		default_device_exit_batch(net_exit_list, &dev_kill_list);
 		unregister_netdevice_many(&dev_kill_list);
 		rtnl_unlock();
 	}
---8<---

