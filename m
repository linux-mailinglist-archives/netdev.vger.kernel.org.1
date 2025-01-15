Return-Path: <netdev+bounces-158451-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 613E4A11EB3
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 10:57:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 639A9188E8CA
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 09:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA6A248166;
	Wed, 15 Jan 2025 09:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="CgG3R4pE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0227E1D5143
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 09:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736935046; cv=none; b=glt9/rwAo4R+Vif26q25toq290MH23xoAHaVqEAfe7n9k3ZhV54Chvv58KzNaNYx5Jdcq317zjj+vKFr4e+j/aeDP/e1a+xdZnpRzhTKEI+wy0TbHDiAzSn/yQDzitvMf/6DULd2QM67puKjAxRK7UPDbaNL/v+JrRwioKuD6w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736935046; c=relaxed/simple;
	bh=0I4OBVmhhJomA4TOCaunpRjTIH68FXRYY5o6Eie5GBo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gIRYubC2yeXVeEZ50nwiUwraQxHP5vuDQ0PB0rEfvUzFdhIyXfjt4c8fVjJEmcrEmP59YmVj3Bkvn2I4gK1bgF5IMqtqEZrO+MwN7VAFAnJivmtFvmZ0q7MhwSw949oxMATyIJ85fH8ly0n4Z1QrJFdUTgdm7NlqAsE1udb5GxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=CgG3R4pE; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1736935045; x=1768471045;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=91+Ka3To7MbtpgWeG4s1K2uGOZ13NvxRQlQJVaCkVm0=;
  b=CgG3R4pExUHFEkpJrGJyv83BaD5qokQNdRh3Z0ikToY8VSskbxUh1obW
   oJnh2T10xPD40IHMU9tKmL2t1QwFudF6/Ipj3tMZ1QgohrBDwWxHglNs3
   sdVNtNA3BTs342puoGvhI9m+hvHP0z0sy0Loaaif+MMqNFQAc8j2fr0Zn
   k=;
X-IronPort-AV: E=Sophos;i="6.12,316,1728950400"; 
   d="scan'208";a="454366754"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2025 09:57:23 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:62341]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.14.236:2525] with esmtp (Farcaster)
 id dae0fdf6-bfa9-4943-ba2a-14260dfb0122; Wed, 15 Jan 2025 09:57:23 +0000 (UTC)
X-Farcaster-Flow-ID: dae0fdf6-bfa9-4943-ba2a-14260dfb0122
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Wed, 15 Jan 2025 09:57:22 +0000
Received: from 6c7e67c6786f.amazon.com (10.119.2.246) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Wed, 15 Jan 2025 09:57:18 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 3/3] dev: Hold rtnl_net_lock() for dev_ifsioc().
Date: Wed, 15 Jan 2025 18:55:45 +0900
Message-ID: <20250115095545.52709-4-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250115095545.52709-1-kuniyu@amazon.com>
References: <20250115095545.52709-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWA003.ant.amazon.com (10.13.139.43) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Basically, dev_ifsioc() operates on the passed single netns (except
for netdev notifier chains with lower/upper devices for which we will
need more changes).

Let's hold rtnl_net_lock() for dev_ifsioc().

Now that NETDEV_CHANGENAME is always triggered under rtnl_net_lock()
of the device's netns. (do_setlink() and dev_ifsioc())

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/core/dev.c            |  7 ++-----
 net/core/dev_ioctl.c      | 26 +++++++++++++++++---------
 net/core/rtnl_net_debug.c | 15 +++------------
 3 files changed, 22 insertions(+), 26 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 7d30129bf2a0..01b6e1b1f983 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -1236,16 +1236,13 @@ static int dev_get_valid_name(struct net *net, struct net_device *dev,
  */
 int dev_change_name(struct net_device *dev, const char *newname)
 {
+	struct net *net = dev_net(dev);
 	unsigned char old_assign_type;
 	char oldname[IFNAMSIZ];
 	int err = 0;
 	int ret;
-	struct net *net;
-
-	ASSERT_RTNL();
-	BUG_ON(!dev_net(dev));
 
-	net = dev_net(dev);
+	ASSERT_RTNL_NET(net);
 
 	if (!strncmp(newname, dev->name, IFNAMSIZ))
 		return 0;
diff --git a/net/core/dev_ioctl.c b/net/core/dev_ioctl.c
index 087a57b7e4fa..4c2098ac9d72 100644
--- a/net/core/dev_ioctl.c
+++ b/net/core/dev_ioctl.c
@@ -543,7 +543,7 @@ static int dev_siocwandev(struct net_device *dev, struct if_settings *ifs)
 }
 
 /*
- *	Perform the SIOCxIFxxx calls, inside rtnl_lock()
+ *	Perform the SIOCxIFxxx calls, inside rtnl_net_lock()
  */
 static int dev_ifsioc(struct net *net, struct ifreq *ifr, void __user *data,
 		      unsigned int cmd)
@@ -620,11 +620,14 @@ static int dev_ifsioc(struct net *net, struct ifreq *ifr, void __user *data,
 			return -ENODEV;
 		if (!netif_is_bridge_master(dev))
 			return -EOPNOTSUPP;
+
 		netdev_hold(dev, &dev_tracker, GFP_KERNEL);
-		rtnl_unlock();
+		rtnl_net_unlock(net);
+
 		err = br_ioctl_call(net, netdev_priv(dev), cmd, ifr, NULL);
+
 		netdev_put(dev, &dev_tracker);
-		rtnl_lock();
+		rtnl_net_lock(net);
 		return err;
 
 	case SIOCDEVPRIVATE ... SIOCDEVPRIVATE + 15:
@@ -770,9 +773,11 @@ int dev_ioctl(struct net *net, unsigned int cmd, struct ifreq *ifr,
 		dev_load(net, ifr->ifr_name);
 		if (!ns_capable(net->user_ns, CAP_NET_ADMIN))
 			return -EPERM;
-		rtnl_lock();
+
+		rtnl_net_lock(net);
 		ret = dev_ifsioc(net, ifr, data, cmd);
-		rtnl_unlock();
+		rtnl_net_unlock(net);
+
 		if (colon)
 			*colon = ':';
 		return ret;
@@ -816,9 +821,11 @@ int dev_ioctl(struct net *net, unsigned int cmd, struct ifreq *ifr,
 	case SIOCBONDSLAVEINFOQUERY:
 	case SIOCBONDINFOQUERY:
 		dev_load(net, ifr->ifr_name);
-		rtnl_lock();
+
+		rtnl_net_lock(net);
 		ret = dev_ifsioc(net, ifr, data, cmd);
-		rtnl_unlock();
+		rtnl_net_unlock(net);
+
 		if (need_copyout)
 			*need_copyout = false;
 		return ret;
@@ -841,9 +848,10 @@ int dev_ioctl(struct net *net, unsigned int cmd, struct ifreq *ifr,
 		    (cmd >= SIOCDEVPRIVATE &&
 		     cmd <= SIOCDEVPRIVATE + 15)) {
 			dev_load(net, ifr->ifr_name);
-			rtnl_lock();
+
+			rtnl_net_lock(net);
 			ret = dev_ifsioc(net, ifr, data, cmd);
-			rtnl_unlock();
+			rtnl_net_unlock(net);
 			return ret;
 		}
 		return -ENOTTY;
diff --git a/net/core/rtnl_net_debug.c b/net/core/rtnl_net_debug.c
index f406045cbd0e..7ecd28cc1c22 100644
--- a/net/core/rtnl_net_debug.c
+++ b/net/core/rtnl_net_debug.c
@@ -27,7 +27,6 @@ static int rtnl_net_debug_event(struct notifier_block *nb,
 	case NETDEV_CHANGEADDR:
 	case NETDEV_PRE_CHANGEADDR:
 	case NETDEV_GOING_DOWN:
-	case NETDEV_CHANGENAME:
 	case NETDEV_FEAT_CHANGE:
 	case NETDEV_BONDING_FAILOVER:
 	case NETDEV_PRE_UP:
@@ -60,18 +59,10 @@ static int rtnl_net_debug_event(struct notifier_block *nb,
 		ASSERT_RTNL();
 		break;
 
-	/* Once an event fully supports RTNL_NET, move it here
-	 * and remove "if (0)" below.
-	 *
-	 * case NETDEV_XXX:
-	 *	ASSERT_RTNL_NET(net);
-	 *	break;
-	 */
-	}
-
-	/* Just to avoid unused-variable error for dev and net. */
-	if (0)
+	case NETDEV_CHANGENAME:
 		ASSERT_RTNL_NET(net);
+		break;
+	}
 
 	return NOTIFY_DONE;
 }
-- 
2.39.5 (Apple Git-154)


