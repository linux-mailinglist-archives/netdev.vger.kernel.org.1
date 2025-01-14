Return-Path: <netdev+bounces-158011-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10CE2A101B6
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 09:07:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5944B3A8988
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 08:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91CA024635B;
	Tue, 14 Jan 2025 08:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="CLSC7G5p"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09E6243356
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 08:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.190.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736841997; cv=none; b=U98iMvCwVpoo5yr6ZqHs5byddGRQpikYpvArgTwQF0yW+QkR+aONRFdCCldmgw2Wj69s5jpMfOHXF+2ZEz5JIdTn3502vv656TbCEjwHJ3LJD4Y1DRiTETeu1+RYrnMW8rx6q/BET+M5lejHVp/5+ex6gNQ58yxQhmbQvUvjvg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736841997; c=relaxed/simple;
	bh=vogxXtgJHG5N72EI26oIipWTzeHBedO1Rs5I7Pe9sqo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sV5qxNloNSEh+QH+1SVI7xSt6jLvexHU3yqrbBLk2XDxAmNBtfQbp16dHKhm78Hwuj4yCaJ0XBVgCanTe14nMMa0tC18jUB4zpdovuz9yrLFgfneUhvbUEM3ajpD67mgGb+ZIGWHYPJdm+oAKox9/hiDUgb+JejM7bvm/OHov+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=CLSC7G5p; arc=none smtp.client-ip=207.171.190.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1736841996; x=1768377996;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=t5WfnDvpNWpU1sjtWygp7n4yaxgGttzH0cB5N+DGSOo=;
  b=CLSC7G5pYSj7M//KLzPPfkd8cI5q+LgELk+orpCOke3uxRbHUhg79Ix7
   WgLHC6Njy6iAaH20UtEbDD0Oc7iL2uH2ZoP1aTxEfQnfAO82YH/j0x31M
   kF5GHKAQs1FQswFQ0dXZfU3ZTBXHa3EN2nTTsxBVecpJ/6JyzEx3n9G/q
   I=;
X-IronPort-AV: E=Sophos;i="6.12,313,1728950400"; 
   d="scan'208";a="400675540"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 08:06:31 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:55005]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.47.5:2525] with esmtp (Farcaster)
 id bf89928e-4799-412a-aaad-8ef572b63e7c; Tue, 14 Jan 2025 08:06:30 +0000 (UTC)
X-Farcaster-Flow-ID: bf89928e-4799-412a-aaad-8ef572b63e7c
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Tue, 14 Jan 2025 08:06:29 +0000
Received: from 6c7e67c6786f.amazon.com (10.119.11.99) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Tue, 14 Jan 2025 08:06:24 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 02/11] ipv6: Convert net.ipv6.conf.${DEV}.XXX sysctl to per-netns RTNL.
Date: Tue, 14 Jan 2025 17:05:07 +0900
Message-ID: <20250114080516.46155-3-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250114080516.46155-1-kuniyu@amazon.com>
References: <20250114080516.46155-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWA001.ant.amazon.com (10.13.139.103) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

net.ipv6.conf.${DEV}.XXX sysctl are changed under RTNL:

  * forwarding
  * ignore_routes_with_linkdown
  * disable_ipv6
  * proxy_ndp
  * addr_gen_mode
  * stable_secret
  * disable_policy

Let's use rtnl_net_lock() there.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv6/addrconf.c | 60 ++++++++++++++++++++++-----------------------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index c3729382be3b..fb0ef98c79b0 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -852,7 +852,7 @@ static void addrconf_forward_change(struct net *net, __s32 newf)
 	struct inet6_dev *idev;
 
 	for_each_netdev(net, dev) {
-		idev = __in6_dev_get(dev);
+		idev = __in6_dev_get_rtnl_net(dev);
 		if (idev) {
 			int changed = (!idev->cnf.forwarding) ^ (!newf);
 
@@ -865,13 +865,12 @@ static void addrconf_forward_change(struct net *net, __s32 newf)
 
 static int addrconf_fixup_forwarding(const struct ctl_table *table, int *p, int newf)
 {
-	struct net *net;
+	struct net *net = (struct net *)table->extra2;
 	int old;
 
-	if (!rtnl_trylock())
+	if (!rtnl_net_trylock(net))
 		return restart_syscall();
 
-	net = (struct net *)table->extra2;
 	old = *p;
 	WRITE_ONCE(*p, newf);
 
@@ -881,7 +880,7 @@ static int addrconf_fixup_forwarding(const struct ctl_table *table, int *p, int
 						     NETCONFA_FORWARDING,
 						     NETCONFA_IFINDEX_DEFAULT,
 						     net->ipv6.devconf_dflt);
-		rtnl_unlock();
+		rtnl_net_unlock(net);
 		return 0;
 	}
 
@@ -903,7 +902,7 @@ static int addrconf_fixup_forwarding(const struct ctl_table *table, int *p, int
 						     net->ipv6.devconf_all);
 	} else if ((!newf) ^ (!old))
 		dev_forward_change((struct inet6_dev *)table->extra1);
-	rtnl_unlock();
+	rtnl_net_unlock(net);
 
 	if (newf)
 		rt6_purge_dflt_routers(net);
@@ -916,7 +915,7 @@ static void addrconf_linkdown_change(struct net *net, __s32 newf)
 	struct inet6_dev *idev;
 
 	for_each_netdev(net, dev) {
-		idev = __in6_dev_get(dev);
+		idev = __in6_dev_get_rtnl_net(dev);
 		if (idev) {
 			int changed = (!idev->cnf.ignore_routes_with_linkdown) ^ (!newf);
 
@@ -933,13 +932,12 @@ static void addrconf_linkdown_change(struct net *net, __s32 newf)
 
 static int addrconf_fixup_linkdown(const struct ctl_table *table, int *p, int newf)
 {
-	struct net *net;
+	struct net *net = (struct net *)table->extra2;
 	int old;
 
-	if (!rtnl_trylock())
+	if (!rtnl_net_trylock(net))
 		return restart_syscall();
 
-	net = (struct net *)table->extra2;
 	old = *p;
 	WRITE_ONCE(*p, newf);
 
@@ -950,7 +948,7 @@ static int addrconf_fixup_linkdown(const struct ctl_table *table, int *p, int ne
 						     NETCONFA_IGNORE_ROUTES_WITH_LINKDOWN,
 						     NETCONFA_IFINDEX_DEFAULT,
 						     net->ipv6.devconf_dflt);
-		rtnl_unlock();
+		rtnl_net_unlock(net);
 		return 0;
 	}
 
@@ -964,7 +962,8 @@ static int addrconf_fixup_linkdown(const struct ctl_table *table, int *p, int ne
 						     NETCONFA_IFINDEX_ALL,
 						     net->ipv6.devconf_all);
 	}
-	rtnl_unlock();
+
+	rtnl_net_unlock(net);
 
 	return 1;
 }
@@ -6370,7 +6369,7 @@ static void addrconf_disable_change(struct net *net, __s32 newf)
 	struct inet6_dev *idev;
 
 	for_each_netdev(net, dev) {
-		idev = __in6_dev_get(dev);
+		idev = __in6_dev_get_rtnl_net(dev);
 		if (idev) {
 			int changed = (!idev->cnf.disable_ipv6) ^ (!newf);
 
@@ -6391,7 +6390,7 @@ static int addrconf_disable_ipv6(const struct ctl_table *table, int *p, int newf
 		return 0;
 	}
 
-	if (!rtnl_trylock())
+	if (!rtnl_net_trylock(net))
 		return restart_syscall();
 
 	old = *p;
@@ -6400,10 +6399,11 @@ static int addrconf_disable_ipv6(const struct ctl_table *table, int *p, int newf
 	if (p == &net->ipv6.devconf_all->disable_ipv6) {
 		WRITE_ONCE(net->ipv6.devconf_dflt->disable_ipv6, newf);
 		addrconf_disable_change(net, newf);
-	} else if ((!newf) ^ (!old))
+	} else if ((!newf) ^ (!old)) {
 		dev_disable_change((struct inet6_dev *)table->extra1);
+	}
 
-	rtnl_unlock();
+	rtnl_net_unlock(net);
 	return 0;
 }
 
@@ -6446,20 +6446,20 @@ static int addrconf_sysctl_proxy_ndp(const struct ctl_table *ctl, int write,
 	if (write && old != new) {
 		struct net *net = ctl->extra2;
 
-		if (!rtnl_trylock())
+		if (!rtnl_net_trylock(net))
 			return restart_syscall();
 
-		if (valp == &net->ipv6.devconf_dflt->proxy_ndp)
+		if (valp == &net->ipv6.devconf_dflt->proxy_ndp) {
 			inet6_netconf_notify_devconf(net, RTM_NEWNETCONF,
 						     NETCONFA_PROXY_NEIGH,
 						     NETCONFA_IFINDEX_DEFAULT,
 						     net->ipv6.devconf_dflt);
-		else if (valp == &net->ipv6.devconf_all->proxy_ndp)
+		} else if (valp == &net->ipv6.devconf_all->proxy_ndp) {
 			inet6_netconf_notify_devconf(net, RTM_NEWNETCONF,
 						     NETCONFA_PROXY_NEIGH,
 						     NETCONFA_IFINDEX_ALL,
 						     net->ipv6.devconf_all);
-		else {
+		} else {
 			struct inet6_dev *idev = ctl->extra1;
 
 			inet6_netconf_notify_devconf(net, RTM_NEWNETCONF,
@@ -6467,7 +6467,7 @@ static int addrconf_sysctl_proxy_ndp(const struct ctl_table *ctl, int write,
 						     idev->dev->ifindex,
 						     &idev->cnf);
 		}
-		rtnl_unlock();
+		rtnl_net_unlock(net);
 	}
 
 	return ret;
@@ -6487,7 +6487,7 @@ static int addrconf_sysctl_addr_gen_mode(const struct ctl_table *ctl, int write,
 		.mode = ctl->mode,
 	};
 
-	if (!rtnl_trylock())
+	if (!rtnl_net_trylock(net))
 		return restart_syscall();
 
 	new_val = *((u32 *)ctl->data);
@@ -6517,7 +6517,7 @@ static int addrconf_sysctl_addr_gen_mode(const struct ctl_table *ctl, int write,
 
 			WRITE_ONCE(net->ipv6.devconf_dflt->addr_gen_mode, new_val);
 			for_each_netdev(net, dev) {
-				idev = __in6_dev_get(dev);
+				idev = __in6_dev_get_rtnl_net(dev);
 				if (idev &&
 				    idev->cnf.addr_gen_mode != new_val) {
 					WRITE_ONCE(idev->cnf.addr_gen_mode,
@@ -6531,7 +6531,7 @@ static int addrconf_sysctl_addr_gen_mode(const struct ctl_table *ctl, int write,
 	}
 
 out:
-	rtnl_unlock();
+	rtnl_net_unlock(net);
 
 	return ret;
 }
@@ -6553,7 +6553,7 @@ static int addrconf_sysctl_stable_secret(const struct ctl_table *ctl, int write,
 	lctl.maxlen = IPV6_MAX_STRLEN;
 	lctl.data = str;
 
-	if (!rtnl_trylock())
+	if (!rtnl_net_trylock(net))
 		return restart_syscall();
 
 	if (!write && !secret->initialized) {
@@ -6583,7 +6583,7 @@ static int addrconf_sysctl_stable_secret(const struct ctl_table *ctl, int write,
 		struct net_device *dev;
 
 		for_each_netdev(net, dev) {
-			struct inet6_dev *idev = __in6_dev_get(dev);
+			struct inet6_dev *idev = __in6_dev_get_rtnl_net(dev);
 
 			if (idev) {
 				WRITE_ONCE(idev->cnf.addr_gen_mode,
@@ -6598,7 +6598,7 @@ static int addrconf_sysctl_stable_secret(const struct ctl_table *ctl, int write,
 	}
 
 out:
-	rtnl_unlock();
+	rtnl_net_unlock(net);
 
 	return err;
 }
@@ -6682,7 +6682,7 @@ int addrconf_disable_policy(const struct ctl_table *ctl, int *valp, int val)
 		return 0;
 	}
 
-	if (!rtnl_trylock())
+	if (!rtnl_net_trylock(net))
 		return restart_syscall();
 
 	WRITE_ONCE(*valp, val);
@@ -6691,7 +6691,7 @@ int addrconf_disable_policy(const struct ctl_table *ctl, int *valp, int val)
 		struct net_device *dev;
 
 		for_each_netdev(net, dev) {
-			idev = __in6_dev_get(dev);
+			idev = __in6_dev_get_rtnl_net(dev);
 			if (idev)
 				addrconf_disable_policy_idev(idev, val);
 		}
@@ -6700,7 +6700,7 @@ int addrconf_disable_policy(const struct ctl_table *ctl, int *valp, int val)
 		addrconf_disable_policy_idev(idev, val);
 	}
 
-	rtnl_unlock();
+	rtnl_net_unlock(net);
 	return 0;
 }
 
-- 
2.39.5 (Apple Git-154)


