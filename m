Return-Path: <netdev+bounces-158402-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C30EDA11B83
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 09:07:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFD9E18885F1
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 08:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4523595D;
	Wed, 15 Jan 2025 08:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="TWtOQkeC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5284B673
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 08:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736928448; cv=none; b=COiANkPArv+voBs8Z7YDI8Tjz+svGSey6nQIB657f5601x94eS5UiLRFwB52l2lCGSRMs+M8M6J43N2l6YD8Ia8LGTDO3cOHcyHA0H3FZDvJbcta99zZ6+59PEBEZBrpOcPDTUyYkQMZ29FPFzEqO/yLPgZVnoxw2KL3OseoQTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736928448; c=relaxed/simple;
	bh=vogxXtgJHG5N72EI26oIipWTzeHBedO1Rs5I7Pe9sqo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dfWMSXtJrdBmxzF7sylFjxqb67Enc+pACfpiFja5j24HEvRF/cEC8FT0HdOj/VMdoKpaiHWox/h3rWwCwyieyG/vGTW63a2WJ6y4W1If/KmbsWuRcTv6GXO+YFzrnr/UVYFMSPw9ZMWWC4B4/LLdNYSrXhmB3zLlbIhuTxu/1ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=TWtOQkeC; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1736928447; x=1768464447;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=t5WfnDvpNWpU1sjtWygp7n4yaxgGttzH0cB5N+DGSOo=;
  b=TWtOQkeCr054NarzhXbcLf+DwQEGyFrtDfNYydvXD3Pzi6uUdPSb84G4
   WP9ZhIAlw4PQ58BAQ4a0UovMN2u+CRyJAZBZYc1hE7H1SVQaXuZsiWksu
   dfW8uIA/UFbbCcixdTtnRYj08v3+Og8ZRoVVyd64bLgiGpt5BwOojkZ5B
   E=;
X-IronPort-AV: E=Sophos;i="6.12,316,1728950400"; 
   d="scan'208";a="486094556"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2025 08:07:20 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:26066]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.31.27:2525] with esmtp (Farcaster)
 id c88cb799-2709-4d48-a32d-12c8eec4abd7; Wed, 15 Jan 2025 08:07:19 +0000 (UTC)
X-Farcaster-Flow-ID: c88cb799-2709-4d48-a32d-12c8eec4abd7
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Wed, 15 Jan 2025 08:07:18 +0000
Received: from 6c7e67c6786f.amazon.com (10.118.248.178) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Wed, 15 Jan 2025 08:07:14 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 02/11] ipv6: Convert net.ipv6.conf.${DEV}.XXX sysctl to per-netns RTNL.
Date: Wed, 15 Jan 2025 17:05:59 +0900
Message-ID: <20250115080608.28127-3-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250115080608.28127-1-kuniyu@amazon.com>
References: <20250115080608.28127-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D045UWC002.ant.amazon.com (10.13.139.230) To
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


