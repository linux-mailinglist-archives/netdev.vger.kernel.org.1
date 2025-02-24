Return-Path: <netdev+bounces-169159-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA945A42C1F
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 19:58:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5E3A7A5D1F
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 18:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E600226139E;
	Mon, 24 Feb 2025 18:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="SpaDFfXo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E423D10E4
	for <netdev@vger.kernel.org>; Mon, 24 Feb 2025 18:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740423472; cv=none; b=ryG8wByVOWGDg2J264/bDwYihOMUdu7Hekj4hNK1xb3ewspSUM2o7M6i4MWzbh7mzL0w4k54abxDHEr/PenpbpekI2Wiii9btQv4/foZCoQb8RWbtGNtBsb2SPbH2pELbzDWuvaeZXwZU2hotMUQm98rPvGrn6EUXZd1w0UJC8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740423472; c=relaxed/simple;
	bh=/HsJPSNZ8uCzLZAt5O5uy1H6E5vVFOxhA/N7L7NIUG4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JPTeFqUd4mlkrMvVaCZCO1REs/m1u2dYfgjcmSWLpy5EayWh/wMldSQffh7APMdMIzDrkwZ65+FnuWbXW/uZcT7iV4SqgQq+y+O7UT0TOEpO/E1uZjBGVm30hmxW92tarNcdH0JumhXl0V4+L/XrmLBJkRVUl+x/V1hp/CMu8Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=SpaDFfXo; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1740423471; x=1771959471;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LYT2zOqjFLeCDOZGIkFpB5sRaslgpfFq/2iQsPTtWyI=;
  b=SpaDFfXodh1zTYL1YYz/Yfh3V73XLlFEGRh+XQikk/XBjaj9qJ8PVIwK
   JvsvApr5gf+Wj+vEuq6rJwbnADbnGIAJ7PvcV3b50caJZoP1E+f4TbV2z
   TuNAzHxMzfThNHmdAcoVUcKrh1Y7HUvCNTK2CZSBJzGu7VXOq4ZnTdIQN
   A=;
X-IronPort-AV: E=Sophos;i="6.13,312,1732579200"; 
   d="scan'208";a="474901419"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 18:57:48 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:2270]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.11.69:2525] with esmtp (Farcaster)
 id d07f6826-f469-48d0-a19b-2c87d7f9b6eb; Mon, 24 Feb 2025 18:57:47 +0000 (UTC)
X-Farcaster-Flow-ID: d07f6826-f469-48d0-a19b-2c87d7f9b6eb
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 24 Feb 2025 18:57:46 +0000
Received: from 6c7e67bfbae3.amazon.com (10.119.221.99) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 24 Feb 2025 18:57:44 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <leitao@debian.org>
CC: <kernel-team@meta.com>, <netdev@vger.kernel.org>, <saeedm@nvidia.com>,
	<tariqt@nvidia.com>, <thevlad@meta.com>
Subject: Re: mlx5: WARNING: register_netdevice_notifier_dev_net
Date: Mon, 24 Feb 2025 10:57:36 -0800
Message-ID: <20250224185736.76447-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250224-noisy-cordial-roadrunner-fad40c@leitao>
References: <20250224-noisy-cordial-roadrunner-fad40c@leitao>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D031UWC003.ant.amazon.com (10.13.139.252) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Breno Leitao <leitao@debian.org>
Date: Mon, 24 Feb 2025 10:04:23 -0800
> Hello,
> 
> I've begun noticing these messages in version 6.14, and they persist in
> 6.14-rc4 as in 082ecbc71e9 (“Linux 6.14-rc4"). As I haven't found any
> reports about this issue, I'm bringing it to your attention.
> 
> 	WARNING: CPU: 25 PID: 849 at net/core/dev.c:2150 register_netdevice_notifier_dev_net (net/core/dev.c:2150)
> 	
> 	<TASK>
> 	? __warn (kernel/panic.c:242 kernel/panic.c:748)
> 	? register_netdevice_notifier_dev_net (net/core/dev.c:2150)
> 	? register_netdevice_notifier_dev_net (net/core/dev.c:2150)
> 	? report_bug (lib/bug.c:? lib/bug.c:219)
> 	? handle_bug (arch/x86/kernel/traps.c:285)
> 	? exc_invalid_op (arch/x86/kernel/traps.c:309)
> 	? asm_exc_invalid_op (./arch/x86/include/asm/idtentry.h:621)
> 	? register_netdevice_notifier_dev_net (net/core/dev.c:2150)
> 	19:02:13 ? register_netdevice_notifier_dev_net (./include/net/net_namespace.h:406 ./include/linux/netdevice.h:2663 net/core/dev.c:2144)
> 	mlx5e_mdev_notifier_event+0x9f/0xf0 mlx5_ib
> 	notifier_call_chain.llvm.12241336988804114627 (kernel/notifier.c:85)
> 	blocking_notifier_call_chain (kernel/notifier.c:380)
> 	mlx5_core_uplink_netdev_event_replay (drivers/net/ethernet/mellanox/mlx5/core/main.c:352)
> 	mlx5_ib_roce_init.llvm.12447516292400117075+0x1c6/0x550 mlx5_ib
> 	mlx5r_probe+0x375/0x6a0 mlx5_ib
> 	? kernfs_put (./include/linux/instrumented.h:96 ./include/linux/atomic/atomic-arch-fallback.h:2278 ./include/linux/atomic/atomic-instrumented.h:1384 fs/kernfs/dir.c:557)
> 	? auxiliary_match_id (drivers/base/auxiliary.c:174)
> 	? mlx5r_mp_remove+0x160/0x160 mlx5_ib
> 	really_probe (drivers/base/dd.c:? drivers/base/dd.c:658)
> 	driver_probe_device (drivers/base/dd.c:830)
> 	__driver_attach (drivers/base/dd.c:1217)
> 	bus_for_each_dev (drivers/base/bus.c:369)
> 	? driver_attach (drivers/base/dd.c:1157)
> 	bus_add_driver (drivers/base/bus.c:679)
> 	driver_register (drivers/base/driver.c:249)
> 	__auxiliary_driver_register (drivers/ba

Looks like my assumption was simply wrong...

I'll post a patch with this diff:

---8<---
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
---8<---

Thanks!

