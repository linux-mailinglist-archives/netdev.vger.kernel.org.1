Return-Path: <netdev+bounces-167084-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7A98A38C23
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 20:12:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD6B33ADE7F
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 19:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA9F23644D;
	Mon, 17 Feb 2025 19:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="HVw1eT1Z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5B6236421
	for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 19:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739819564; cv=none; b=WcNVDpPB+D/ntxHnytnvBtaPKglV9+IloZlgP5bLg1MiYfgVGQcx/BgYj3lUbZ7T1vDki6XmZBWqjW4cdWMF9AzswZmgyphx6bOWkQPm26hcIFICFuauCKkXhtzaL1MlXczCbUnUF1KQ59KXZMHsybuiHqm/aOA1TgKfjgtfJBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739819564; c=relaxed/simple;
	bh=HZqruoREHJNQnLd8DM8/kK5DC9buAXkc/haqXV/Vrw8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uCSDn8ltejXOiAGaU8lNLtZ9Szk2F6QSAUi53ZiwJ8T0vpz7fpGL2v7N/6vc2BzWr+jPZmbNku3yzrTk70k9UTeQ0GoIL/ra1UWZLGVTS2o6GelmxgoUlmqxzOcaqK8AxFVYMu5eoMgBcJTW7uQCyv3UUsdXfdI0jfWxqJxw524=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=HVw1eT1Z; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1739819563; x=1771355563;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dyLrA8EK+wdA4cbdKs01qg0SRvX9nyywRNjpmLivr/0=;
  b=HVw1eT1ZkYHo73nonXvkzYhd8Ye2kZWpfxoaLrNWzELeBTlJzLURG4nH
   c/6HIzYUfnARR0DoHMC3OIgUZprYS3sih5+IEjRKnM7TJHMpt0FRihf6U
   Dd3Ql75g/+7eYSq5hTr21eqTEFWs+kOmKf1I3sTyRXHlQa40YsLHD4iwN
   w=;
X-IronPort-AV: E=Sophos;i="6.13,293,1732579200"; 
   d="scan'208";a="799544155"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2025 19:12:36 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:35767]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.3.186:2525] with esmtp (Farcaster)
 id 75329157-9358-44c8-97e1-7cc1afa61dee; Mon, 17 Feb 2025 19:12:35 +0000 (UTC)
X-Farcaster-Flow-ID: 75329157-9358-44c8-97e1-7cc1afa61dee
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Mon, 17 Feb 2025 19:12:35 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.11) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 17 Feb 2025 19:12:32 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>, Yael Chemla
	<ychemla@nvidia.com>
Subject: [PATCH v5 net 2/3] net: Fix dev_net(dev) race in unregister_netdevice_notifier_dev_net().
Date: Mon, 17 Feb 2025 11:11:28 -0800
Message-ID: <20250217191129.19967-3-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250217191129.19967-1-kuniyu@amazon.com>
References: <20250217191129.19967-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D045UWA004.ant.amazon.com (10.13.139.91) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

After the cited commit, dev_net(dev) is fetched before holding RTNL
and passed to __unregister_netdevice_notifier_net().

However, dev_net(dev) might be different after holding RTNL.

In the reported case [0], while removing a VF device, its netns was
being dismantled and the VF was moved to init_net.

So the following sequence is basically illegal when dev was fetched
without lookup:

  net = dev_net(dev);
  rtnl_net_lock(net);

Let's use a new helper rtnl_net_dev_lock() to fix the race.

It fetches dev_net_rcu(dev), bumps its net->passive, and checks if
dev_net_rcu(dev) is changed after rtnl_net_lock().

[0]:
BUG: KASAN: slab-use-after-free in notifier_call_chain (kernel/notifier.c:75 (discriminator 2))
Read of size 8 at addr ffff88810cefb4c8 by task test-bridge-lag/21127
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl (lib/dump_stack.c:123)
 print_report (mm/kasan/report.c:379 mm/kasan/report.c:489)
 kasan_report (mm/kasan/report.c:604)
 notifier_call_chain (kernel/notifier.c:75 (discriminator 2))
 call_netdevice_notifiers_info (net/core/dev.c:2011)
 unregister_netdevice_many_notify (net/core/dev.c:11551)
 unregister_netdevice_queue (net/core/dev.c:11487)
 unregister_netdev (net/core/dev.c:11635)
 mlx5e_remove (drivers/net/ethernet/mellanox/mlx5/core/en_main.c:6552 drivers/net/ethernet/mellanox/mlx5/core/en_main.c:6579) mlx5_core
 auxiliary_bus_remove (drivers/base/auxiliary.c:230)
 device_release_driver_internal (drivers/base/dd.c:1275 drivers/base/dd.c:1296)
 bus_remove_device (./include/linux/kobject.h:193 drivers/base/base.h:73 drivers/base/bus.c:583)
 device_del (drivers/base/power/power.h:142 drivers/base/core.c:3855)
 mlx5_rescan_drivers_locked (./include/linux/auxiliary_bus.h:241 drivers/net/ethernet/mellanox/mlx5/core/dev.c:333 drivers/net/ethernet/mellanox/mlx5/core/dev.c:535 drivers/net/ethernet/mellanox/mlx5/core/dev.c:549) mlx5_core
 mlx5_unregister_device (drivers/net/ethernet/mellanox/mlx5/core/dev.c:468) mlx5_core
 mlx5_uninit_one (./include/linux/instrumented.h:68 ./include/asm-generic/bitops/instrumented-non-atomic.h:141 drivers/net/ethernet/mellanox/mlx5/core/main.c:1563) mlx5_core
 remove_one (drivers/net/ethernet/mellanox/mlx5/core/main.c:965 drivers/net/ethernet/mellanox/mlx5/core/main.c:2019) mlx5_core
 pci_device_remove (./include/linux/pm_runtime.h:129 drivers/pci/pci-driver.c:475)
 device_release_driver_internal (drivers/base/dd.c:1275 drivers/base/dd.c:1296)
 unbind_store (drivers/base/bus.c:245)
 kernfs_fop_write_iter (fs/kernfs/file.c:338)
 vfs_write (fs/read_write.c:587 (discriminator 1) fs/read_write.c:679 (discriminator 1))
 ksys_write (fs/read_write.c:732)
 do_syscall_64 (arch/x86/entry/common.c:52 (discriminator 1) arch/x86/entry/common.c:83 (discriminator 1))
 entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
RIP: 0033:0x7f6a4d5018b7

Fixes: 7fb1073300a2 ("net: Hold rtnl_net_lock() in (un)?register_netdevice_notifier_dev_net().")
Reported-by: Yael Chemla <ychemla@nvidia.com>
Closes: https://lore.kernel.org/netdev/146eabfe-123c-4970-901e-e961b4c09bc3@nvidia.com/
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
---
v5:
  * Use do-while loop

v4:
  * Fix build failure when !CONFIG_NET_NS
  * Use net_passive_dec()

v3:
  * Bump net->passive instead of maybe_get_net()
  * Remove msleep(1) loop
  * Use rcu_access_pointer() instead of rcu_read_lock().

v2:
  * Use dev_net_rcu().
  * Use msleep(1) instead of cond_resched() after maybe_get_net()
  * Remove cond_resched() after net_eq() check

v1: https://lore.kernel.org/netdev/20250130232435.43622-2-kuniyu@amazon.com/
---
 net/core/dev.c | 48 ++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 44 insertions(+), 4 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index b91658e8aedb..19e268568282 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -2070,6 +2070,42 @@ static void __move_netdevice_notifier_net(struct net *src_net,
 	__register_netdevice_notifier_net(dst_net, nb, true);
 }
 
+static void rtnl_net_dev_lock(struct net_device *dev)
+{
+	bool again;
+
+	do {
+		struct net *net;
+
+		again = false;
+
+		/* netns might be being dismantled. */
+		rcu_read_lock();
+		net = dev_net_rcu(dev);
+		net_passive_inc(net);
+		rcu_read_unlock();
+
+		rtnl_net_lock(net);
+
+#ifdef CONFIG_NET_NS
+		/* dev might have been moved to another netns. */
+		if (!net_eq(net, rcu_access_pointer(dev->nd_net.net))) {
+			rtnl_net_unlock(net);
+			net_passive_dec(net);
+			again = true;
+		}
+#endif
+	} while (again);
+}
+
+static void rtnl_net_dev_unlock(struct net_device *dev)
+{
+	struct net *net = dev_net(dev);
+
+	rtnl_net_unlock(net);
+	net_passive_dec(net);
+}
+
 int register_netdevice_notifier_dev_net(struct net_device *dev,
 					struct notifier_block *nb,
 					struct netdev_net_notifier *nn)
@@ -2077,6 +2113,11 @@ int register_netdevice_notifier_dev_net(struct net_device *dev,
 	struct net *net = dev_net(dev);
 	int err;
 
+	/* rtnl_net_lock() assumes dev is not yet published by
+	 * register_netdevice().
+	 */
+	DEBUG_NET_WARN_ON_ONCE(!list_empty(&dev->dev_list));
+
 	rtnl_net_lock(net);
 	err = __register_netdevice_notifier_net(net, nb, false);
 	if (!err) {
@@ -2093,13 +2134,12 @@ int unregister_netdevice_notifier_dev_net(struct net_device *dev,
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
-- 
2.39.5 (Apple Git-154)


