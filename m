Return-Path: <netdev+bounces-172013-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B4BBA4FE6A
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 13:16:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9446E7A7BAA
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 12:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2A2243387;
	Wed,  5 Mar 2025 12:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AFEFd0nU"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2081.outbound.protection.outlook.com [40.107.212.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B854524337D
	for <netdev@vger.kernel.org>; Wed,  5 Mar 2025 12:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741176960; cv=fail; b=NFfEP7SmIwNnJeBRAPDi4zKBeQPJ3V3JkLzWEw7Peav0kj9CPkmkum9HaqBoh5uqthgmpCih2voe+DNcfbFR3sMoPomQENKwZNhBk+j0ZaeguHAKsco788IkjXMBQ0Lkn2CVVe+CIG9bozJhL9WDmuIvbQYWMaOXyBxvvRlUXPY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741176960; c=relaxed/simple;
	bh=JnJGFFrkwmyBHZoCNWBhDfVJRNVoEKyYNAtV1gSqwnY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QCIAiLRqCWv44JVTVC+PRia6RhEHfi20lyBjZ9OJ3DW0W5zh7j6QHgoiJhRrqNb0dD/gDoui45DD3KBNApdjVhYowC0IjLmRUtz+vUTwOnEPo4AFdwIRf391MF5/ADrx3MEBlsuPx36iwXOS+NK/PJe5r1B4PfUlUkrp5EHWbF4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AFEFd0nU; arc=fail smtp.client-ip=40.107.212.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MANTwMIgnD6n22d4dh6X0aPbB6uyq8Fry1wwu9J7Ap/3HYt/cqk4NA7oUJyi5NlPFGTwflJXCcdryvGilruvc3LBGbd4gBjn1a3QMR2RmF7mIb3cuxiplnDhGdmv4f+RG2fDg3VeNMCbOj43maY/QmBwX5pz7fwbQQUENJCjPiKXnCJlUmJyt7paMK8lIfwUSEMH21l+2IHGFqe+NBanba66nPMdyfHPyn9sbAKmI0+cZTt1RsXKAfDPUkzVNvcjPx1NRzzoj83LAMYhyEr0dR1wxa8n7nT5yHy6Pa0UhF1hOCj+cJI1oHXJwEHcxZ4RKCRHQk/v1aKaGY0Ptszhng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CF+08ZyOdvcdPeF/mOxQhMJ3U00lc/sBV387AXxuAZ8=;
 b=hhTk+A+4+v4hm3t2znUSv9/7JaeRvGlAX9dt6wcddYtgpvT04IZEDG/ftmr9P1VUyRj+oSD8IfUXGV5ENVQ51joHDT7U+e8ioMHQ318bsEbaF3wdnIAXkjtBrEvtNNVF7jvdppW+2f/VCou3YyuZiLnwndoGf5k8SAFhHIFqSQPGXgBhyiWBUUi/CqxGpqiPegBq2QU5F369yYrax2HUcSzyIrybTXvyTeGDjstL6hvqHUIO3cOHtSzVLTp7msinnCauIyGkG/MreSHS/13Tgl88w3+RPFf+yFL01HKFs1QMNYxZQ/0CvyAQ6Nktj5P0C73tAJhN6c9Ulzy4c010Uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CF+08ZyOdvcdPeF/mOxQhMJ3U00lc/sBV387AXxuAZ8=;
 b=AFEFd0nUksYYx89CEINY1HOdfzpI98seWIDDtBWlNzr+R8cCDR8gJMq2un9wbRQYMHQsEiRzOmdgBuC/5YiqeCsJW0XWiqYp+Zr1W1KXh215r3/+5UJ/BxGhiaCgauViTLUcfg4nkudTkDIDhvgj7ZHE3AZ45++maXiItEpEwfCxorod4No0AFKItrV5ZOLmToggGOgGDRSJ7S7j/53Vj5lx7kQY3ew/BxqTDpa7coXyu+F/PpKWdPTWwontLSYKdWKBOqesukgPIooAxU/AUKHtf60vOg/92wsdU07WF5QpVn8dVgNaCrj+wij/BcQeTsLW74sCVGf5DX6N1fTcxg==
Received: from CH0PR03CA0378.namprd03.prod.outlook.com (2603:10b6:610:119::33)
 by PH7PR12MB8425.namprd12.prod.outlook.com (2603:10b6:510:240::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.28; Wed, 5 Mar
 2025 12:15:55 +0000
Received: from CH2PEPF00000140.namprd02.prod.outlook.com
 (2603:10b6:610:119:cafe::bd) by CH0PR03CA0378.outlook.office365.com
 (2603:10b6:610:119::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.16 via Frontend Transport; Wed,
 5 Mar 2025 12:15:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF00000140.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.15 via Frontend Transport; Wed, 5 Mar 2025 12:15:54 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 5 Mar 2025
 04:15:40 -0800
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 5 Mar 2025 04:15:37 -0800
From: Amit Cohen <amcohen@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <idosch@nvidia.com>, <petrm@nvidia.com>, <jiri@resnulli.us>,
	<ivecera@redhat.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
	<olteanv@gmail.com>, <tobias@waldekranz.com>, Amit Cohen <amcohen@nvidia.com>
Subject: [PATCH net] net: switchdev: Convert blocking notification chain to a raw one
Date: Wed, 5 Mar 2025 14:15:09 +0200
Message-ID: <20250305121509.631207-1-amcohen@nvidia.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000140:EE_|PH7PR12MB8425:EE_
X-MS-Office365-Filtering-Correlation-Id: 6437e205-36c6-4163-bc97-08dd5bdf7aae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zYIkefz7c59rsFXguTgoH/iPUpQwo9QX4jRhQa+l9fG065Dhax6lZMYC3kJP?=
 =?us-ascii?Q?8VDCt4j8D8vuclFKnhciM4iAXnINE6BMTJY/Xk6E9YYZjsRyihem6OGFuTTL?=
 =?us-ascii?Q?S5SBZMgDvFTEsWqHxb08i/HZjEb9UQXaMRWCcwGUmJkqja8dxkvDusMgSXyI?=
 =?us-ascii?Q?/fQMEbHyz48wzL8vemcLbByEVyhxKdvzwzCMMTFCd+AjyygN+qtKo6JyDZ+Y?=
 =?us-ascii?Q?/WHwsLTOejMui2d6Ro6fNhZDqMOPZ0NvlxKi+aLJ/rfQ5DX1HHn9XpwqoJ10?=
 =?us-ascii?Q?lxf0asG6Mp4xzJ2VebHH8iUPuF4x8FmhAcUMw67Me1LBIo5mr3o06VBhGQrB?=
 =?us-ascii?Q?dOeP7f8ZUCYN2YyOFl8jjOS3gpEojMIXLJPckLbUAKTmmo7auOAH1y+aM627?=
 =?us-ascii?Q?uGjmhI9mUKBEXrT2LR5ipkOtwne3TskNXA1LtvaO7hr1/cCVbob0iK3Z4xMB?=
 =?us-ascii?Q?Z7uV18XjmawAtSczgzA9p60s/wrq3bdsxZkK1eaweqfJ3/j+VpUmsP7GRA7p?=
 =?us-ascii?Q?/1d9y5a5+TShkyK222Z7koYbWVQPBxRgQwnhQnb8WHksmoMZw71IMD4qdR5x?=
 =?us-ascii?Q?c/8gCnqcgq8lR6we2nDEa9MA3fntoMTWtt9hz1rp70J7k9MEHZvs5M4OztS+?=
 =?us-ascii?Q?0iaaArQGFy62HzwSJnncR/ltCQrNGCpALdWPc3YSGEaVdbHS1T8/gYv1jMgs?=
 =?us-ascii?Q?OodiN1yZ0YmqYERGdl6SCR/tB1fc7cLHirZ7/g5neVsSr0xWXTmTGYFYbubV?=
 =?us-ascii?Q?eKP4WoPM4Epe7LzKqEni9fDM1OuLVf4yl7wVs8/QZBdx48iJ7UHjwNeP5QsX?=
 =?us-ascii?Q?nIdw+xPLaBUCqRT4odUdiMVI1o4IHJZDP+0ps5o9OSR4Y3aBj/s7oPmcgV12?=
 =?us-ascii?Q?0JE8Am2dTEuO/UkIPFLiTYCyt2y5dRhgPAp2yKCooGc+5PXdfQbaJkdimh1o?=
 =?us-ascii?Q?Tdjk2p0wXgTKLirpRY9GbnRSZA3gR2grtURjo+yww6Yk/0fssdS6Lqq0clNl?=
 =?us-ascii?Q?egixS74NUItLiyHXu43TU0hCoDGn86jb5+7/orGrMXT8fI/WRb8QBHPlwu1s?=
 =?us-ascii?Q?haDcuw+9QTu4URdrDgaqfAKuVpwWuPVp26YFgzKLXJdfcO5HpZ0D0wNDOC+X?=
 =?us-ascii?Q?hrA3VOxwXvCG1bihQ+Kmkt3KUAOT1E2zrsuBiU2V//vFEXzMeXJ/lrGvV5Sf?=
 =?us-ascii?Q?dq29eYPXXyLV0erSWw50zWjhsnoDH0CFU4emHGrlEDTuiwKHZ9qCYo0OdEqW?=
 =?us-ascii?Q?gHi20yOjJcYXumNjIUrbtLMLFkk/paCddLSrSd5XTxAZ808mESBYErLWToiP?=
 =?us-ascii?Q?KNWMc1ScGJqCYygpKgGN3JsuTk7BKbD+9+2sKIPU5idNKT8FdC8f1uA7fq0d?=
 =?us-ascii?Q?trQQl1/IsFCGwadDc4+/OZDnQ4a3b1gRC0cavnWshXafkygzNNO7Q/koJOB2?=
 =?us-ascii?Q?9jfdZhQVDO0NAn0aS/tr4cF11P5cECAUpb1kh5y2qAoprhU6BIWqLEYzmidT?=
 =?us-ascii?Q?oimqXVJ9/UeUdG4=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 12:15:54.9022
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6437e205-36c6-4163-bc97-08dd5bdf7aae
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000140.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8425

A blocking notification chain uses a read-write semaphore to protect the
integrity of the chain. The semaphore is acquired for writing when
adding / removing notifiers to / from the chain and acquired for reading
when traversing the chain and informing notifiers about an event.

In case of the blocking switchdev notification chain, recursive
notifications are possible which leads to the semaphore being acquired
twice for reading and to lockdep warnings being generated [1].

Specifically, this can happen when the bridge driver processes a
SWITCHDEV_BRPORT_UNOFFLOADED event which causes it to emit notifications
about deferred events when calling switchdev_deferred_process().

Fix this by converting the notification chain to a raw notification
chain in a similar fashion to the netdev notification chain. Protect
the chain using the RTNL mutex by acquiring it when modifying the chain.
Events are always informed under the RTNL mutex, but add an assertion in
call_switchdev_blocking_notifiers() to make sure this is not violated in
the future.

Maintain the "blocking" prefix as events are always emitted from process
context and listeners are allowed to block.

[1]:
WARNING: possible recursive locking detected
6.14.0-rc4-custom-g079270089484 #1 Not tainted
--------------------------------------------
ip/52731 is trying to acquire lock:
ffffffff850918d8 ((switchdev_blocking_notif_chain).rwsem){++++}-{4:4}, at: blocking_notifier_call_chain+0x58/0xa0

but task is already holding lock:
ffffffff850918d8 ((switchdev_blocking_notif_chain).rwsem){++++}-{4:4}, at: blocking_notifier_call_chain+0x58/0xa0

other info that might help us debug this:
Possible unsafe locking scenario:
CPU0
----
lock((switchdev_blocking_notif_chain).rwsem);
lock((switchdev_blocking_notif_chain).rwsem);

*** DEADLOCK ***
May be due to missing lock nesting notation
3 locks held by ip/52731:
 #0: ffffffff84f795b0 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_newlink+0x727/0x1dc0
 #1: ffffffff8731f628 (&net->rtnl_mutex){+.+.}-{4:4}, at: rtnl_newlink+0x790/0x1dc0
 #2: ffffffff850918d8 ((switchdev_blocking_notif_chain).rwsem){++++}-{4:4}, at: blocking_notifier_call_chain+0x58/0xa0

stack backtrace:
...
? __pfx_down_read+0x10/0x10
? __pfx_mark_lock+0x10/0x10
? __pfx_switchdev_port_attr_set_deferred+0x10/0x10
blocking_notifier_call_chain+0x58/0xa0
switchdev_port_attr_notify.constprop.0+0xb3/0x1b0
? __pfx_switchdev_port_attr_notify.constprop.0+0x10/0x10
? mark_held_locks+0x94/0xe0
? switchdev_deferred_process+0x11a/0x340
switchdev_port_attr_set_deferred+0x27/0xd0
switchdev_deferred_process+0x164/0x340
br_switchdev_port_unoffload+0xc8/0x100 [bridge]
br_switchdev_blocking_event+0x29f/0x580 [bridge]
notifier_call_chain+0xa2/0x440
blocking_notifier_call_chain+0x6e/0xa0
switchdev_bridge_port_unoffload+0xde/0x1a0
...

Fixes: f7a70d650b0b6 ("net: bridge: switchdev: Ensure deferred event delivery on unoffload")
Signed-off-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 net/switchdev/switchdev.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/net/switchdev/switchdev.c b/net/switchdev/switchdev.c
index 6488ead9e464..4d5fbacef496 100644
--- a/net/switchdev/switchdev.c
+++ b/net/switchdev/switchdev.c
@@ -472,7 +472,7 @@ bool switchdev_port_obj_act_is_deferred(struct net_device *dev,
 EXPORT_SYMBOL_GPL(switchdev_port_obj_act_is_deferred);
 
 static ATOMIC_NOTIFIER_HEAD(switchdev_notif_chain);
-static BLOCKING_NOTIFIER_HEAD(switchdev_blocking_notif_chain);
+static RAW_NOTIFIER_HEAD(switchdev_blocking_notif_chain);
 
 /**
  *	register_switchdev_notifier - Register notifier
@@ -518,17 +518,27 @@ EXPORT_SYMBOL_GPL(call_switchdev_notifiers);
 
 int register_switchdev_blocking_notifier(struct notifier_block *nb)
 {
-	struct blocking_notifier_head *chain = &switchdev_blocking_notif_chain;
+	struct raw_notifier_head *chain = &switchdev_blocking_notif_chain;
+	int err;
+
+	rtnl_lock();
+	err = raw_notifier_chain_register(chain, nb);
+	rtnl_unlock();
 
-	return blocking_notifier_chain_register(chain, nb);
+	return err;
 }
 EXPORT_SYMBOL_GPL(register_switchdev_blocking_notifier);
 
 int unregister_switchdev_blocking_notifier(struct notifier_block *nb)
 {
-	struct blocking_notifier_head *chain = &switchdev_blocking_notif_chain;
+	struct raw_notifier_head *chain = &switchdev_blocking_notif_chain;
+	int err;
 
-	return blocking_notifier_chain_unregister(chain, nb);
+	rtnl_lock();
+	err = raw_notifier_chain_unregister(chain, nb);
+	rtnl_unlock();
+
+	return err;
 }
 EXPORT_SYMBOL_GPL(unregister_switchdev_blocking_notifier);
 
@@ -536,10 +546,11 @@ int call_switchdev_blocking_notifiers(unsigned long val, struct net_device *dev,
 				      struct switchdev_notifier_info *info,
 				      struct netlink_ext_ack *extack)
 {
+	ASSERT_RTNL();
 	info->dev = dev;
 	info->extack = extack;
-	return blocking_notifier_call_chain(&switchdev_blocking_notif_chain,
-					    val, info);
+	return raw_notifier_call_chain(&switchdev_blocking_notif_chain,
+				       val, info);
 }
 EXPORT_SYMBOL_GPL(call_switchdev_blocking_notifiers);
 
-- 
2.47.0


