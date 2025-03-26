Return-Path: <netdev+bounces-177863-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C714A7248A
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 23:35:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 815373B3351
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 22:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8D51B040B;
	Wed, 26 Mar 2025 22:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="RI9+MmP7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791304430
	for <netdev@vger.kernel.org>; Wed, 26 Mar 2025 22:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743028366; cv=none; b=Z+Nj/JUKFKj/lb2uE9AnQLVzw2qABywav19gy3KkwAm7RwlBDfgj7BuggYTC4gRL7DoUOry8WsYP1IWjoTzXmpVsuZV+c8+S3tgP9MtIQf7smXssqDBlz5uIX8LZiTdvEz4zPbWaA1eUITSdZUmJG7KhIZPYYb9oMxzehIu4cyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743028366; c=relaxed/simple;
	bh=oAMSsSPds/gWBlaQb2LKpgYngks7cLyUzbzF/zVI/uI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XmPTXhS3yBOiWYc2QgitsHJ3CRcuVoa5gNsw+o/OlVeAJwdeRWmPI9hNq7MTr/ZavFKvEjrf1ByIVGLM9bVhnloxsL9I9A0/B497QXipHASZw1wx8h017pygCrgqo7gVZ6XVt7/EeHyq4laAZVLNCkegyckWa5Oe/jP7pUT+qZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=RI9+MmP7; arc=none smtp.client-ip=207.171.188.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1743028365; x=1774564365;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yAk8F/PJC9T7530JvemzNAmUNfJIoloHfseGuAbR7jM=;
  b=RI9+MmP7Lig7wbC5Ag3LwMxXur4akHg1NARdkxINiUWj0WcoucxefjDl
   h6v5yftHxd2cRRP5yzr2bdhXx2cTx4nXH9fmbQ2PiYL33V3wmICOwLUgX
   1hQQ9te0rH36pTZTPPZhjioCbChpjC7eRzmW3WajNfMLbuDv0ZjAwg7+u
   w=;
X-IronPort-AV: E=Sophos;i="6.14,279,1736812800"; 
   d="scan'208";a="4859523"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2025 22:32:38 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:52134]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.41.16:2525] with esmtp (Farcaster)
 id 347b25d1-47c8-4622-8e2d-6c89abc0bfc7; Wed, 26 Mar 2025 22:32:37 +0000 (UTC)
X-Farcaster-Flow-ID: 347b25d1-47c8-4622-8e2d-6c89abc0bfc7
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 26 Mar 2025 22:32:36 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.100.44) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 26 Mar 2025 22:32:33 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <horms@kernel.org>, <kuba@kernel.org>,
	<kuni1840@gmail.com>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <ychemla@nvidia.com>
Subject: Re: [PATCH v5 net 2/3] net: Fix dev_net(dev) race in unregister_netdevice_notifier_dev_net().
Date: Wed, 26 Mar 2025 15:32:22 -0700
Message-ID: <20250326223225.75860-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <CANn89iJt72meYXVex-K4JyQ-tR+J4bgHFR5PbcN7EYRGfcL5Tw@mail.gmail.com>
References: <CANn89iJt72meYXVex-K4JyQ-tR+J4bgHFR5PbcN7EYRGfcL5Tw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D041UWB001.ant.amazon.com (10.13.139.132) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Wed, 26 Mar 2025 23:10:04 +0100
> On Wed, Mar 26, 2025 at 10:55 PM Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
> >
> > From: Yael Chemla <ychemla@nvidia.com>
> > Date: Wed, 26 Mar 2025 15:46:40 +0200
> > > On 17/02/2025 21:11, Kuniyuki Iwashima wrote:
> > > > After the cited commit, dev_net(dev) is fetched before holding RTNL
> > > > and passed to __unregister_netdevice_notifier_net().
> > > >
> > > > However, dev_net(dev) might be different after holding RTNL.
> > > >
> > > > In the reported case [0], while removing a VF device, its netns was
> > > > being dismantled and the VF was moved to init_net.
> > > >
> > > > So the following sequence is basically illegal when dev was fetched
> > > > without lookup:
> > > >
> > > >   net = dev_net(dev);
> > > >   rtnl_net_lock(net);
> > > >
> > > > Let's use a new helper rtnl_net_dev_lock() to fix the race.
> > > >
> > > > It fetches dev_net_rcu(dev), bumps its net->passive, and checks if
> > > > dev_net_rcu(dev) is changed after rtnl_net_lock().
> > > >
> > > > [0]:
> > > > BUG: KASAN: slab-use-after-free in notifier_call_chain (kernel/notifier.c:75 (discriminator 2))
> > > > Read of size 8 at addr ffff88810cefb4c8 by task test-bridge-lag/21127
> > > > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
> > > > Call Trace:
> > > >  <TASK>
> > > >  dump_stack_lvl (lib/dump_stack.c:123)
> > > >  print_report (mm/kasan/report.c:379 mm/kasan/report.c:489)
> > > >  kasan_report (mm/kasan/report.c:604)
> > > >  notifier_call_chain (kernel/notifier.c:75 (discriminator 2))
> > > >  call_netdevice_notifiers_info (net/core/dev.c:2011)
> > > >  unregister_netdevice_many_notify (net/core/dev.c:11551)
> > > >  unregister_netdevice_queue (net/core/dev.c:11487)
> > > >  unregister_netdev (net/core/dev.c:11635)
> > > >  mlx5e_remove (drivers/net/ethernet/mellanox/mlx5/core/en_main.c:6552 drivers/net/ethernet/mellanox/mlx5/core/en_main.c:6579) mlx5_core
> > > >  auxiliary_bus_remove (drivers/base/auxiliary.c:230)
> > > >  device_release_driver_internal (drivers/base/dd.c:1275 drivers/base/dd.c:1296)
> > > >  bus_remove_device (./include/linux/kobject.h:193 drivers/base/base.h:73 drivers/base/bus.c:583)
> > > >  device_del (drivers/base/power/power.h:142 drivers/base/core.c:3855)
> > > >  mlx5_rescan_drivers_locked (./include/linux/auxiliary_bus.h:241 drivers/net/ethernet/mellanox/mlx5/core/dev.c:333 drivers/net/ethernet/mellanox/mlx5/core/dev.c:535 drivers/net/ethernet/mellanox/mlx5/core/dev.c:549) mlx5_core
> > > >  mlx5_unregister_device (drivers/net/ethernet/mellanox/mlx5/core/dev.c:468) mlx5_core
> > > >  mlx5_uninit_one (./include/linux/instrumented.h:68 ./include/asm-generic/bitops/instrumented-non-atomic.h:141 drivers/net/ethernet/mellanox/mlx5/core/main.c:1563) mlx5_core
> > > >  remove_one (drivers/net/ethernet/mellanox/mlx5/core/main.c:965 drivers/net/ethernet/mellanox/mlx5/core/main.c:2019) mlx5_core
> > > >  pci_device_remove (./include/linux/pm_runtime.h:129 drivers/pci/pci-driver.c:475)
> > > >  device_release_driver_internal (drivers/base/dd.c:1275 drivers/base/dd.c:1296)
> > > >  unbind_store (drivers/base/bus.c:245)
> > > >  kernfs_fop_write_iter (fs/kernfs/file.c:338)
> > > >  vfs_write (fs/read_write.c:587 (discriminator 1) fs/read_write.c:679 (discriminator 1))
> > > >  ksys_write (fs/read_write.c:732)
> > > >  do_syscall_64 (arch/x86/entry/common.c:52 (discriminator 1) arch/x86/entry/common.c:83 (discriminator 1))
> > > >  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
> > > > RIP: 0033:0x7f6a4d5018b7
> > > >
> > > > Fixes: 7fb1073300a2 ("net: Hold rtnl_net_lock() in (un)?register_netdevice_notifier_dev_net().")
> > > > Reported-by: Yael Chemla <ychemla@nvidia.com>
> > > > Closes: https://lore.kernel.org/netdev/146eabfe-123c-4970-901e-e961b4c09bc3@nvidia.com/
> > > > Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> > > > Reviewed-by: Eric Dumazet <edumazet@google.com>
> > > > ---
> > > > v5:
> > > >   * Use do-while loop
> > > >
> > > > v4:
> > > >   * Fix build failure when !CONFIG_NET_NS
> > > >   * Use net_passive_dec()
> > > >
> > > > v3:
> > > >   * Bump net->passive instead of maybe_get_net()
> > > >   * Remove msleep(1) loop
> > > >   * Use rcu_access_pointer() instead of rcu_read_lock().
> > > >
> > > > v2:
> > > >   * Use dev_net_rcu().
> > > >   * Use msleep(1) instead of cond_resched() after maybe_get_net()
> > > >   * Remove cond_resched() after net_eq() check
> > > >
> > > > v1: https://lore.kernel.org/netdev/20250130232435.43622-2-kuniyu@amazon.com/
> > > > ---
> > > >  net/core/dev.c | 48 ++++++++++++++++++++++++++++++++++++++++++++----
> > > >  1 file changed, 44 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/net/core/dev.c b/net/core/dev.c
> > > > index b91658e8aedb..19e268568282 100644
> > > > --- a/net/core/dev.c
> > > > +++ b/net/core/dev.c
> > > > @@ -2070,6 +2070,42 @@ static void __move_netdevice_notifier_net(struct net *src_net,
> > > >     __register_netdevice_notifier_net(dst_net, nb, true);
> > > >  }
> > > >
> > > > +static void rtnl_net_dev_lock(struct net_device *dev)
> > > > +{
> > > > +   bool again;
> > > > +
> > > > +   do {
> > > > +           struct net *net;
> > > > +
> > > > +           again = false;
> > > > +
> > > > +           /* netns might be being dismantled. */
> > > > +           rcu_read_lock();
> > > > +           net = dev_net_rcu(dev);
> > > > +           net_passive_inc(net);
> > >
> > > Hi Kuniyuki,
> > > It seems we are still encountering the previously reorted issue,
> > > even when running with your latest fix. However, the problem has become
> > > less frequent, now requiring multiple test iterations to reproduce.
> >
> > Thanks for reporting!
> >
> >
> > >
> > > 1) we identified the following warnings (each accompanied by a call
> > > trace; only one is detailed below, though others are similar):
> > >
> > > refcount_t: addition on 0; use-after-free.
> > > WARNING: CPU: 6 PID: 1105 at lib/refcount.c:25 refcount_warn_saturate
> > > (/usr/work/linux/lib/refcount.c:25 (discriminator 1))
> > >
> > > and also
> > >
> > > refcount_t: underflow; use-after-free.
> > > WARNING: CPU: 6 PID: 1105 at lib/refcount.c:28 refcount_warn_saturate
> > > (/usr/work/linux/lib/refcount.c:28 (discriminator 1))
> > >
> > >
> > > 2) test scenario:
> > > sets up a network topology of two VFs on different eSwitch, performs
> > > ping tests between them, verifies traffic rules offloading, and cleans
> > > up the environment afterward.
> > >
> > > 3) the warning is triggered upon reaching the
> > > unregister_netdevice_notifier_dev_net when both net->ns.count and
> > > net->passive reference counts are zero.
> >
> > It looks unlikely but I missed there is still a race window.
> >
> > If dev_net_rcu() is called between synchronize_net() and dev_net_set()
> > in netif_change_net_namespace(), there might be no synchronize_rcu()
> > called after that and net_passive_dec() could be called in cleanup_net()
> > earlier than net_passive_inc() ... ?
> >
> > Could you test this ?
> >
> > ---8<---
> > diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
> > index bd57d8fb54f1..c275e95c83ab 100644
> > --- a/include/net/net_namespace.h
> > +++ b/include/net/net_namespace.h
> > @@ -337,9 +337,9 @@ static inline void net_passive_dec(struct net *net)
> >  }
> >  #endif
> >
> > -static inline void net_passive_inc(struct net *net)
> > +static inline bool net_passive_inc(struct net *net)
> >  {
> > -       refcount_inc(&net->passive);
> > +       return refcount_inc_not_zero(&net->passive);
> 
> Hmm
> 
> We want the two oher net_passive_inc() callers to have refcount safety.
> 
> Please add a new net_passive_inc_not_zero()

Sure, will do.

Also, I'll remove the weird do-while {} and do everything under
ifdef CONFIG_NET_NS guard.  If it's disabled, just calling
rtnl_net_lock() for &init_net is fine.

---8<---
diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
index bd57d8fb54f1..c91b13e6fb12 100644
--- a/include/net/net_namespace.h
+++ b/include/net/net_namespace.h
@@ -342,6 +342,11 @@ static inline void net_passive_inc(struct net *net)
 	refcount_inc(&net->passive);
 }
 
+static inline bool net_passive_inc_not_zero(struct net *net)
+{
+	return refcount_inc_not_zero(&net->passive);
+}
+
 /* Returns true if the netns initialization is completed successfully */
 static inline bool net_initialized(const struct net *net)
 {
diff --git a/net/core/dev.c b/net/core/dev.c
index b597cc27a115..408659d238b8 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -2077,38 +2077,43 @@ static void __move_netdevice_notifier_net(struct net *src_net,
 
 static void rtnl_net_dev_lock(struct net_device *dev)
 {
-	bool again;
-
-	do {
-		struct net *net;
-
-		again = false;
+#ifdef CONFIG_NET_NS
+	struct net *net;
 
-		/* netns might be being dismantled. */
-		rcu_read_lock();
-		net = dev_net_rcu(dev);
-		net_passive_inc(net);
+again:
+	/* netns might be being dismantled. */
+	rcu_read_lock();
+	net = dev_net_rcu(dev);
+	if (!net_passive_inc_not_zero(net)) {
 		rcu_read_unlock();
+		msleep(1);
+		goto again;
+	}
+	rcu_read_unlock();
 
-		rtnl_net_lock(net);
+	rtnl_net_lock(net);
 
-#ifdef CONFIG_NET_NS
-		/* dev might have been moved to another netns. */
-		if (!net_eq(net, rcu_access_pointer(dev->nd_net.net))) {
-			rtnl_net_unlock(net);
-			net_passive_dec(net);
-			again = true;
-		}
+	/* dev might have been moved to another netns. */
+	if (!net_eq(net, rcu_access_pointer(dev->nd_net.net))) {
+		rtnl_net_unlock(net);
+		net_passive_dec(net);
+		goto again;
+	}
+#else
+	rtnl_net_lock(&init_net);
 #endif
-	} while (again);
 }
 
 static void rtnl_net_dev_unlock(struct net_device *dev)
 {
+#ifdef CONFIG_NET_NS
 	struct net *net = dev_net(dev);
 
 	rtnl_net_unlock(net);
 	net_passive_dec(net);
+#else
+	rtnl_net_unlock(&init_net);
+#endif
 }
 
 int register_netdevice_notifier_dev_net(struct net_device *dev,
---8<---

