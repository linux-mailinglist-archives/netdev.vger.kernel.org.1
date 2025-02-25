Return-Path: <netdev+bounces-169633-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CCAA7A44E75
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 22:11:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 887D4188BC37
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 21:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AABE01A2392;
	Tue, 25 Feb 2025 21:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Fc1G2cBo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FD4C1A0BCD
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 21:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740517842; cv=none; b=TD0Igl/b/j9iF/fgz4xcjWgvHMQcFYeyKHDmRXDP4fr8oufxdeQ5O4l+9FME76XJVfqI82sy18NfIoAefA6+5OZYgLxo14N/Mk/sz5gf5GTIsmnHp7B0o0lUeBHWSuePmv80jD4LUy15juNhfZ/qjAj+zj9e8qLxnAIEMMh+lX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740517842; c=relaxed/simple;
	bh=6dprDHN+SCFUF0U2fdxnIeTe38NLwITDcuIDXLLNULE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HoiGuRvF6DZfhY2OOONs/POf8fa4gtQiXHCv5pWNVUkpWDoTOTKMQzxv9blyVjODMTLl0nVLzDHaWLrSOr1zeR1VjGzHYODnFvq/2AY8+2Tni9UrUsW//lYVsI0liL+j9gTjTfwppv7NBUBfEXR3/N3x8P+ynLwULow6lntJu34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Fc1G2cBo; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1740517842; x=1772053842;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qaGNJ2cIdd4i6EslMnG00QzilPkJVKYuTbJrGIJfP9g=;
  b=Fc1G2cBoeKa1MwNgEeW6dopiw3Ied7skofyTX7rsohMZS1uU1zEV7sQ7
   irtYW3vuC2ywcjqsE1/wjEZv2n2IEi3/simCMqNN1xZaQ4BYorMcGWAZ/
   /fKeJ4IGc4Syv9BpUcKNe+Sr+lh8qJqRTa5xI+K0JJsfdU6neKWR1LbVf
   0=;
X-IronPort-AV: E=Sophos;i="6.13,314,1732579200"; 
   d="scan'208";a="380762879"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 21:10:38 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:12061]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.48.97:2525] with esmtp (Farcaster)
 id 10b98729-a9e5-49a4-b649-3f11dae61f5f; Tue, 25 Feb 2025 21:10:36 +0000 (UTC)
X-Farcaster-Flow-ID: 10b98729-a9e5-49a4-b649-3f11dae61f5f
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 25 Feb 2025 21:10:35 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.100.5) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 25 Feb 2025 21:10:32 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>, Breno Leitao
	<leitao@debian.org>
Subject: [PATCH v1 net] net: Use rtnl_net_dev_lock() in register_netdevice_notifier_dev_net().
Date: Tue, 25 Feb 2025 13:10:23 -0800
Message-ID: <20250225211023.96448-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWB003.ant.amazon.com (10.13.139.174) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Breno Leitao reported the splat below. [0]

Commit 65161fb544aa ("net: Fix dev_net(dev) race in
unregister_netdevice_notifier_dev_net().") added the
DEBUG_NET_WARN_ON_ONCE(), assuming that the netdev is not
registered before register_netdevice_notifier_dev_net().

But the assumption was simply wrong.

Let's use rtnl_net_dev_lock() in register_netdevice_notifier_dev_net().

[0]:
WARNING: CPU: 25 PID: 849 at net/core/dev.c:2150 register_netdevice_notifier_dev_net (net/core/dev.c:2150)
 <TASK>
 ? __warn (kernel/panic.c:242 kernel/panic.c:748)
 ? register_netdevice_notifier_dev_net (net/core/dev.c:2150)
 ? register_netdevice_notifier_dev_net (net/core/dev.c:2150)
 ? report_bug (lib/bug.c:? lib/bug.c:219)
 ? handle_bug (arch/x86/kernel/traps.c:285)
 ? exc_invalid_op (arch/x86/kernel/traps.c:309)
 ? asm_exc_invalid_op (./arch/x86/include/asm/idtentry.h:621)
 ? register_netdevice_notifier_dev_net (net/core/dev.c:2150)
 ? register_netdevice_notifier_dev_net (./include/net/net_namespace.h:406 ./include/linux/netdevice.h:2663 net/core/dev.c:2144)
 mlx5e_mdev_notifier_event+0x9f/0xf0 mlx5_ib
 notifier_call_chain.llvm.12241336988804114627 (kernel/notifier.c:85)
 blocking_notifier_call_chain (kernel/notifier.c:380)
 mlx5_core_uplink_netdev_event_replay (drivers/net/ethernet/mellanox/mlx5/core/main.c:352)
 mlx5_ib_roce_init.llvm.12447516292400117075+0x1c6/0x550 mlx5_ib
 mlx5r_probe+0x375/0x6a0 mlx5_ib
 ? kernfs_put (./include/linux/instrumented.h:96 ./include/linux/atomic/atomic-arch-fallback.h:2278 ./include/linux/atomic/atomic-instrumented.h:1384 fs/kernfs/dir.c:557)
 ? auxiliary_match_id (drivers/base/auxiliary.c:174)
 ? mlx5r_mp_remove+0x160/0x160 mlx5_ib
 really_probe (drivers/base/dd.c:? drivers/base/dd.c:658)
 driver_probe_device (drivers/base/dd.c:830)
 __driver_attach (drivers/base/dd.c:1217)
 bus_for_each_dev (drivers/base/bus.c:369)
 ? driver_attach (drivers/base/dd.c:1157)
 bus_add_driver (drivers/base/bus.c:679)
 driver_register (drivers/base/driver.c:249)

Fixes: 7fb1073300a2 ("net: Hold rtnl_net_lock() in (un)?register_netdevice_notifier_dev_net().")
Reported-by: Breno Leitao <leitao@debian.org>
Closes: https://lore.kernel.org/netdev/20250224-noisy-cordial-roadrunner-fad40c@leitao/
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/core/dev.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 1b252e9459fd..70c01bd1799e 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -2141,21 +2141,15 @@ int register_netdevice_notifier_dev_net(struct net_device *dev,
 					struct notifier_block *nb,
 					struct netdev_net_notifier *nn)
 {
-	struct net *net = dev_net(dev);
 	int err;
 
-	/* rtnl_net_lock() assumes dev is not yet published by
-	 * register_netdevice().
-	 */
-	DEBUG_NET_WARN_ON_ONCE(!list_empty(&dev->dev_list));
-
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
-- 
2.39.5 (Apple Git-154)


