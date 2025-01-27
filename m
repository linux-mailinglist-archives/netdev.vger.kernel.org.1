Return-Path: <netdev+bounces-161231-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AAFCA201AB
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 00:28:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 080983A7640
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 23:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D153E1DC747;
	Mon, 27 Jan 2025 23:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="imba4Wyn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960BC1DDC37
	for <netdev@vger.kernel.org>; Mon, 27 Jan 2025 23:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738020412; cv=none; b=Cg3zvnzpEi62lCa7c0yiQo7wal33stm7wWNlxeEAwT9L66JSOxMkEbYWVwTfKFILLGEKtb1D1Weh0nsjtZUFC04ALZUqwwsaLkVC0jJcWQyIlGeFk+5K8m5zrxs0d3OnAQ1NNMx39pqrlxlsmEhYWR0n57/WZExAiSrugZrNVno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738020412; c=relaxed/simple;
	bh=tgLL7aM1S+PkwZjoj38fQGGIrHqu5FvKs/dqYLg8p0I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FD1iapzC6fy3SE4eCKmxf/3jjATPMPAj0hIBMxgPLiF70/4CONt+wJXCXZwQbctxYusPq5uIZFp3CTgNiNE+PCThP4rRSuXb2tsh5NEwkaPA1RnUFH2NkABmeD7JfgQapVSOXEQsXhDijXvYFAhtTzuByhOSZyCh2LTWeveMknQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=imba4Wyn; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1738020411; x=1769556411;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=++hCVDbW24qbhp3ef9pxQmPtuuaFfHMuJpjwZYCKoDc=;
  b=imba4Wynd31mhgXmO8nPtWR4GppBA/4AXTdzH7JADCV98EtzlC3O4ka8
   qb26YxwzeZKH3cl62JvsB+gcjYY7Qoy+EdwZ1tcCS0YbdbcpGiOJL0Fws
   kLrG9KEtXEmjNfq5kNX0UpjCbIZ8VuXDBTXUVJ7+fKv/mM2xN/hUpDu/T
   w=;
X-IronPort-AV: E=Sophos;i="6.13,239,1732579200"; 
   d="scan'208";a="457521666"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2025 23:26:47 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:7704]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.26.122:2525] with esmtp (Farcaster)
 id 857bbd32-95d5-4ca9-a187-10fcd0299531; Mon, 27 Jan 2025 23:26:46 +0000 (UTC)
X-Farcaster-Flow-ID: 857bbd32-95d5-4ca9-a187-10fcd0299531
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Mon, 27 Jan 2025 23:26:45 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.100.32) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Mon, 27 Jan 2025 23:26:42 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <ychemla@nvidia.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <horms@kernel.org>,
	<kuba@kernel.org>, <kuni1840@gmail.com>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH v1 net-next 4/4] net: Hold rtnl_net_lock() in (un)?register_netdevice_notifier_dev_net().
Date: Mon, 27 Jan 2025 15:26:34 -0800
Message-ID: <20250127232634.83744-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <dc118ae9-4ec0-4180-b7aa-90eba5283010@nvidia.com>
References: <dc118ae9-4ec0-4180-b7aa-90eba5283010@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D039UWB002.ant.amazon.com (10.13.138.79) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Yael Chemla <ychemla@nvidia.com>
Date: Mon, 20 Jan 2025 20:55:07 +0200
> >>> diff --git a/net/core/dev.c b/net/core/dev.c
> >>> index f6c6559e2548..a0dd34463901 100644
> >>> --- a/net/core/dev.c
> >>> +++ b/net/core/dev.c
> >>> @@ -1943,15 +1943,17 @@ int register_netdevice_notifier_dev_net(struct net_device *dev,
> >>>    					struct notifier_block *nb,
> >>>    					struct netdev_net_notifier *nn)
> >>>    {
> >>> +	struct net *net = dev_net(dev);
> >>
> >> it seems to happen since the net pointer is acquired here without a lock.
> >> Note that KASAN issue is not triggered when executing with rtnl_lock()
> >> taken before this line. and our kernel .config expands
> >> rtnl_net_lock(net) to rtnl_lock() (CONFIG_DEBUG_NET_SMALL_RTNL is not set).
> > 
> > It sounds like the device was being moved to another netns while
> > unregister_netdevice_notifier_dev_net() was called.
> > 
> > Could you check if dev_net() is changed before/after rtnl_lock() in
> > 
> >    * register_netdevice_notifier_dev_net()
> >    * unregister_netdevice_notifier_dev_net()
> > 
> > ?
> 
> When checking dev_net before and after taking the lock the issue won’t 
> reproduce.
> note that when issue reproduce we arrive to 
> unregister_netdevice_notifier_dev_net with an invalid net pointer 
> (verified it with prints of its value, and it's not the same consistent 
> value as is throughout rest of the test).

Does an invalid net pointer means a dead netns pointer ?
dev_net() and dev_net_set() use rcu_dereference() and rcu_assign_pointer(),
so I guess it should not be an invalid address at least.


> we suspect the issue related to the async ns deletion.

I think async netns change would trigger the issue too.

Could you try this patch ?

---8<---
diff --git a/net/core/dev.c b/net/core/dev.c
index afa2282f2604..f4438ec24683 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -2070,20 +2070,50 @@ static void __move_netdevice_notifier_net(struct net *src_net,
 	__register_netdevice_notifier_net(dst_net, nb, true);
 }
 
+static void rtnl_net_dev_lock(struct net_device *dev)
+{
+	struct net *net;
+
+again:
+	/* netns might be being dismantled. */
+	net = maybe_get_net(dev_net(dev));
+	if (!net) {
+		cond_resched();
+		goto again;
+	}
+
+	rtnl_net_lock(net);
+
+	/* dev might be moved to another netns. */
+	if (!net_eq(net, dev_net(dev))) {
+		rtnl_net_unlock(net);
+		put_net(net);
+		cond_resched();
+		goto again;
+	}
+}
+
+static void rtnl_net_dev_unlock(struct net_device *dev)
+{
+	struct net *net = dev_net(dev);
+
+	rtnl_net_unlock(net);
+	put_net(net);
+}
+
 int register_netdevice_notifier_dev_net(struct net_device *dev,
 					struct notifier_block *nb,
 					struct netdev_net_notifier *nn)
 {
-	struct net *net = dev_net(dev);
 	int err;
 
-	rtnl_net_lock(net);
-	err = __register_netdevice_notifier_net(net, nb, false);
+	rtnl_net_dev_lock(dev);
+	err = __register_netdevice_notifier_net(dev_net(dev), nb, false);
 	if (!err) {
 		nn->nb = nb;
 		list_add(&nn->list, &dev->net_notifier_list);
 	}
-	rtnl_net_unlock(net);
+	rtnl_net_dev_unlock(dev);
 
 	return err;
 }
@@ -2093,13 +2123,12 @@ int unregister_netdevice_notifier_dev_net(struct net_device *dev,
 					  struct notifier_block *nb,
 					  struct netdev_net_notifier *nn)
 {
-	struct net *net = dev_net(dev);
 	int err;
 
-	rtnl_net_lock(net);
+	rtnl_net_dev_lock(dev);
 	list_del(&nn->list);
-	err = __unregister_netdevice_notifier_net(net, nb);
-	rtnl_net_unlock(net);
+	err = __unregister_netdevice_notifier_net(dev_net(dev), nb);
+	rtnl_net_dev_unlock(dev);
 
 	return err;
 }
---8<---

