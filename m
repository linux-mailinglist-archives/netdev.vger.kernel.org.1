Return-Path: <netdev+bounces-165420-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B39A31F48
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 07:43:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEAAC3A3431
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 06:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA9C1FCF62;
	Wed, 12 Feb 2025 06:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="pHs3umhK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543411FCD1A
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 06:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739342600; cv=none; b=k9FaJTkKwBUHbC8rdQ+iD3H0DVQGjUNL+DQV3KiIO1qLvGfDtDsBswnzOukmUW5pU4Yhq4ed3eK/74nHnl9KolmMfLCtcqzRmM2/PKmgCRJwfSklapURfV44WHAa/WiUYl0Xu2kyzrBV0+97feEXH7Ol8Fr9qy3kMDN3TUqZsPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739342600; c=relaxed/simple;
	bh=+QmYwpn9CydnrQqx3iZPlcEAc6lfOfCzx1VajA/CWyY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gcu5uiUC0B3GlnXHq3Ru3i6Hs4AdXfxxoBZUdJ/1/JXW8eLrFr8H7yPX0OgxHdf8KVfkONfCDquf1m5bGJI/g8YYAtgUh+5X93g/0PmXAkwPOSeqEwWnyC51XxdOqoeOsg2Fg64yv42Ef/1q4OtrODHWN54gIg7K3jCZBgHUlsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=pHs3umhK; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1739342598; x=1770878598;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=20QeVk9otJA1I3F675YzQzYTcgESVwJNXhWW0lV7hAU=;
  b=pHs3umhKBQKOxdw8dXqHofJga1OWd9zQtKQkSb7N3i0YPBXy8PTAeFyH
   qzIcKmWDHC9xdzRaugbp4QBm4P8zAHDN2hBcBF0e6L1FoyEtg2kN2v/5W
   HvY6UZlVhgNUYnxrEfOLWcjn2KkqXMgcKuaTncEhHIoVt5/8tjLAgIyN/
   k=;
X-IronPort-AV: E=Sophos;i="6.13,279,1732579200"; 
   d="scan'208";a="696412943"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 06:43:15 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:48651]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.32.208:2525] with esmtp (Farcaster)
 id 9a4b6576-91b9-4918-9456-0fab23d373f4; Wed, 12 Feb 2025 06:43:14 +0000 (UTC)
X-Farcaster-Flow-ID: 9a4b6576-91b9-4918-9456-0fab23d373f4
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Wed, 12 Feb 2025 06:43:14 +0000
Received: from 6c7e67bfbae3.amazon.com (10.118.243.86) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 12 Feb 2025 06:43:10 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>, Yael Chemla
	<ychemla@nvidia.com>
Subject: [PATCH v4 net 2/3] net: Fix dev_net(dev) race in unregister_netdevice_notifier_dev_net().
Date: Wed, 12 Feb 2025 15:42:05 +0900
Message-ID: <20250212064206.18159-3-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250212064206.18159-1-kuniyu@amazon.com>
References: <20250212064206.18159-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWC002.ant.amazon.com (10.13.139.242) To
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
---
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
 net/core/dev.c | 45 +++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 41 insertions(+), 4 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 55e356a68db6..6a39fb5baa92 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -2070,6 +2070,39 @@ static void __move_netdevice_notifier_net(struct net *src_net,
 	__register_netdevice_notifier_net(dst_net, nb, true);
 }
 
+static void rtnl_net_dev_lock(struct net_device *dev)
+{
+	struct net *net;
+
+#ifdef CONFIG_NET_NS
+again:
+#endif
+	/* netns might be being dismantled. */
+	rcu_read_lock();
+	net = dev_net_rcu(dev);
+	net_passive_inc(net);
+	rcu_read_unlock();
+
+	rtnl_net_lock(net);
+
+#ifdef CONFIG_NET_NS
+	/* dev might have been moved to another netns. */
+	if (!net_eq(net, rcu_access_pointer(dev->nd_net.net))) {
+		rtnl_net_unlock(net);
+		net_passive_dec(net);
+		goto again;
+	}
+#endif
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
@@ -2077,6 +2110,11 @@ int register_netdevice_notifier_dev_net(struct net_device *dev,
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
@@ -2093,13 +2131,12 @@ int unregister_netdevice_notifier_dev_net(struct net_device *dev,
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


