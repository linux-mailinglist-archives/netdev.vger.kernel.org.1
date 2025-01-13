Return-Path: <netdev+bounces-157792-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47DD8A0BC48
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 16:42:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4475165CFF
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 15:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 369871C5D4A;
	Mon, 13 Jan 2025 15:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GHTIlcMO"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2063.outbound.protection.outlook.com [40.107.92.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9871C5D61
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 15:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736782933; cv=fail; b=LGavFXM+GZI3/l8WtEiYrWeqdhNSint311HAkJj6cpYFgqudHxDBx8ou077r+YIALfFCvruDgmaoo7KfGhEIkJ1WQnceJz0DM9bzzonv8wvzlIUBXv0MRB3oDIvFq3aS3jE/A7xnSUTRwYheM+iIf0ImtIlvlqgFjEe9XYOKDqo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736782933; c=relaxed/simple;
	bh=+zqz4HuVAWkcNHTB5UT5htYWeczxSV8xiQJ4JzHlmYo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rAzKywWykOVUjbHLbNzhhvPW/RQoEMpBRZATutD58o5W+TCePH4xmiBc7RBF/U4xIjxWabFaD2fSz2mLppknFuLbK35i8ItTwb7yn86KhsunWnm2D77vCYgeGX2fN5sloJtcZXPyMZDwBTxuCEzEFty8mWElfuS15JKMhg/HNDY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GHTIlcMO; arc=fail smtp.client-ip=40.107.92.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XSBWtnmeNWL2GOTIbSIj6Mj2EBZ6r1U769MthK71poZSa+xSq7qwBKvidp6LVmPZInTPQhfF/wKR3QzyZ7VtO27nj+fZVhgsNNEOkqwhJHCwQeMQA1sY19AqBv3IA0emRIhlCVeAcJB2DLVRhQ59UrxWDQyiFmEVf6aSORqaJvVSQBFWYZ4XyUs+s4gyJftfUmJOpEOtspNw0HaxRHsJmWvpTfI0hPfuXPypsT+zlz8jbjZo0lcdToGWOoNI4hIt++Rpmuk4r0ci4MNw++nVZ+11PTHT4pJCq0LZiyvYa7HRryD6AaUrJvGEfWRUAruOSFwklJ0Bksr0ao15NWXi1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=do8ysFwtLGczCy8E8ae7gaiLJ9ikuqjydVfc0YntmZ8=;
 b=xH/jb8MoG6Zp/1ffzDQUZrGop2mutQSUXLXREnbVqq+ZDHpxIZ6Er5HtppF2wwEAb9YVTNiOBy9/muUlwe4AAbyOD5eK5GO1iE/m1SQjE/QdLrwtMM80C0Z8m+mrWlnuQYCQl+MAjkhQeenWlrc472tnGOLyI91nGUMLWHwyyuuvpAD8koN0AchWUXLUYs5yZvb27iQIqSHwHmxFxAIhm303EmEjlDuFod9Y/2JIuF/tqBjWFvD8YpwRwjvM28H0OVkHUJV+HLIt7GqvmIniI8BYjf+UPZjtNJavdiAKrnL8xL9qux4TPxlvcAAL/lplCxv7WT9KkBmp8OsyVO69OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=do8ysFwtLGczCy8E8ae7gaiLJ9ikuqjydVfc0YntmZ8=;
 b=GHTIlcMO8eid7YUjJW40Sp1kQ0chtw8fEO8z3WpVhMDjCCyfyRz31RbRRTK4+jVU2XCXPO3WMypi+EdnDXsGwRa+ywmwl0228owABIAVnl0UDU50xFg3hg3wH7uvZIoHCsgXbARVOXBwVkIRwyrBvsmUkckXt7hD9V2cKerOy0JxdLO1UTBdq4ENHJYaxmv7GS5bu/rXDoGnw7xpBv69GOMfDeb+TC0OR6mEroF3SdrDeArCM0Eus3tt1hQGvZTdovskL902xZZTcs16avCJkCYzWoSKpWaUAzNzMVcd3vMt6xEXAYF/224TOTZhRozFz5Xbih8hfwpuH/01v4KdVQ==
Received: from SA9PR13CA0008.namprd13.prod.outlook.com (2603:10b6:806:21::13)
 by DS0PR12MB7725.namprd12.prod.outlook.com (2603:10b6:8:136::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Mon, 13 Jan
 2025 15:42:07 +0000
Received: from SA2PEPF00003F65.namprd04.prod.outlook.com
 (2603:10b6:806:21:cafe::4d) by SA9PR13CA0008.outlook.office365.com
 (2603:10b6:806:21::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.10 via Frontend Transport; Mon,
 13 Jan 2025 15:42:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00003F65.mail.protection.outlook.com (10.167.248.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.11 via Frontend Transport; Mon, 13 Jan 2025 15:42:07 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 13 Jan
 2025 07:41:50 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 13 Jan
 2025 07:41:50 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Mon, 13 Jan
 2025 07:41:46 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Yishai Hadas
	<yishaih@nvidia.com>, Michael Guralnik <michaelgur@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net 2/8] net/mlx5: Fix a lockdep warning as part of the write combining test
Date: Mon, 13 Jan 2025 17:40:48 +0200
Message-ID: <20250113154055.1927008-3-tariqt@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250113154055.1927008-1-tariqt@nvidia.com>
References: <20250113154055.1927008-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F65:EE_|DS0PR12MB7725:EE_
X-MS-Office365-Filtering-Correlation-Id: 0475407a-3116-4dd8-aeda-08dd33e8d604
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rFOaTb9Rvbrj9GitzUtfKw20Usbn6/ySno9tdElMb0y7H6ya/beesyXHkqXN?=
 =?us-ascii?Q?OyFVE+31JZs4ddBWyM9TbYPBSOYVlZQYmbxwQC//7WAIWq2/qg6kOOdDOBXI?=
 =?us-ascii?Q?aSarU3GiCBS+XHpRY90rWl1F+ff2qCUR8xIkSIOBw9qO3PW2ezpR3Hd1fotk?=
 =?us-ascii?Q?tM+zwUFj/gd1h/a3hS6yTqpTWCduGcUKzGvj9NNBYwLqBMTx/PvITfAJjdie?=
 =?us-ascii?Q?Ezmo2+RKWpDwOlAgPUzPK/+NNAZL7UY4qoMMAQ42cGZqIWN8o+lJX0fcmMWq?=
 =?us-ascii?Q?b1XsmiZRxpGCPkdbje+mw3QX1WakHIAc0+EHMBLv8XFY1J+vOnLc6vnIv+s6?=
 =?us-ascii?Q?Oo2owoh5x/JNIw5gKiAD60JveDKtJFE7f7FnB5/SrBHLxmhvk3+It6k2rzzD?=
 =?us-ascii?Q?VdAE1qukcHNuRUtrX1WNuNFmvdlhJgek2EmeYVn0ocRImw26823B0h/YBxgF?=
 =?us-ascii?Q?KyNEE+Op452PGHZ5DLroH+F8z9ICi7qhUMJW2h2/mqPZg84y9xqO3T/xk6yA?=
 =?us-ascii?Q?vatsJbOz36B1mficHbNR4j7+Ex2NrSXkl+PyEoSVZMgm1itKIiLjHM1eMd0T?=
 =?us-ascii?Q?ebhFe0AUTLoIdZFwEdjkjISKL+99hKoqNN7MEZ+c4pzDlWLEmdapNgeGVivr?=
 =?us-ascii?Q?39n3yniBXBPcMHFHURV78u8xYBYrn6FRtAwRf0ii8KdNQEfCZlPAPtQPKlVT?=
 =?us-ascii?Q?ixAglprO3uo7ubUuosRhTVf1uB8j8V3NZ4CKEQo4/qgZIqHXLbrG34qgqqWR?=
 =?us-ascii?Q?slcRHLhrRH9GHntv6CYrKVaTcRea+/4WmAvojOCNQacbkbSDxX9cYVftjplJ?=
 =?us-ascii?Q?n0C6pUrhVIO7vw67Eg4dw/TFSQt+LL3OZ1jmZYxpzlu4SUIP5I2RpzU1ZvEc?=
 =?us-ascii?Q?6Ek9eAVphp0nXNnF70B8DCbjxPFIGCyZ4fJxMWAPCm8/TWjPrzr0wqANI1HD?=
 =?us-ascii?Q?KtjmmLZT9YtQVqXJxTxp3r4eDmn/a0MjKvBUFlpXVs5Rym9Lta8tukLgCUUs?=
 =?us-ascii?Q?a7BQCM+1FMTll5yHVGEqE4vOKX5D3w2HlnCpVRTpJPDs1lNMsdZLuh0VFxAY?=
 =?us-ascii?Q?Wq8GVrKsclZcrpsSdpTkTclivWo/bHM+2otMgc0hHZ9F8Oky039orTHPZKNt?=
 =?us-ascii?Q?hVO6bH9BvrAqZlrVZ/FAXTRULRUKlFkj205YEcFzcMZaG5TOndrqxR/cJg3V?=
 =?us-ascii?Q?dFGRYRUsRUW+wye+QoTOZERmB+XYqwhVXlKuiCmFJpgzOqvpOS8Qgktbfx4x?=
 =?us-ascii?Q?8u4GaNdlJZURDXTP+pIHw36S4w9oJHUDFPdTcEPIETqsnl+T9wnfO2YABwnf?=
 =?us-ascii?Q?fujedwIQ9Bqrhmzdor71AJol2bFJ0OMxfDuyJiQtGWODRAupGRIIJprkNy21?=
 =?us-ascii?Q?VsfhDqM46t80m6RhNsAeNj+VdU/BIB+6VU1m5MIwXXjTPNC8jwr/RNks8a6I?=
 =?us-ascii?Q?w5bDtd2+cRaqkrl6Sc75onk2EWpjFkMoJE6My7ecCUPlxfJtkdW0W6MRSp74?=
 =?us-ascii?Q?2A6Kxq8INvdzgKI=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2025 15:42:07.1132
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0475407a-3116-4dd8-aeda-08dd33e8d604
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7725

From: Yishai Hadas <yishaih@nvidia.com>

Fix a lockdep warning [1] observed during the write combining test.

The warning indicates a potential nested lock scenario that could lead
to a deadlock.

However, this is a false positive alarm because the SF lock and its
parent lock are distinct ones.

The lockdep confusion arises because the locks belong to the same object
class (i.e., struct mlx5_core_dev).

To resolve this, the code has been refactored to avoid taking both
locks. Instead, only the parent lock is acquired.

[1]
raw_ethernet_bw/2118 is trying to acquire lock:
[  213.619032] ffff88811dd75e08 (&dev->wc_state_lock){+.+.}-{3:3}, at:
               mlx5_wc_support_get+0x18c/0x210 [mlx5_core]
[  213.620270]
[  213.620270] but task is already holding lock:
[  213.620943] ffff88810b585e08 (&dev->wc_state_lock){+.+.}-{3:3}, at:
               mlx5_wc_support_get+0x10c/0x210 [mlx5_core]
[  213.622045]
[  213.622045] other info that might help us debug this:
[  213.622778]  Possible unsafe locking scenario:
[  213.622778]
[  213.623465]        CPU0
[  213.623815]        ----
[  213.624148]   lock(&dev->wc_state_lock);
[  213.624615]   lock(&dev->wc_state_lock);
[  213.625071]
[  213.625071]  *** DEADLOCK ***
[  213.625071]
[  213.625805]  May be due to missing lock nesting notation
[  213.625805]
[  213.626522] 4 locks held by raw_ethernet_bw/2118:
[  213.627019]  #0: ffff88813f80d578 (&uverbs_dev->disassociate_srcu){.+.+}-{0:0},
                at: ib_uverbs_ioctl+0xc4/0x170 [ib_uverbs]
[  213.628088]  #1: ffff88810fb23930 (&file->hw_destroy_rwsem){.+.+}-{3:3},
                at: ib_init_ucontext+0x2d/0xf0 [ib_uverbs]
[  213.629094]  #2: ffff88810fb23878 (&file->ucontext_lock){+.+.}-{3:3},
                at: ib_init_ucontext+0x49/0xf0 [ib_uverbs]
[  213.630106]  #3: ffff88810b585e08 (&dev->wc_state_lock){+.+.}-{3:3},
                at: mlx5_wc_support_get+0x10c/0x210 [mlx5_core]
[  213.631185]
[  213.631185] stack backtrace:
[  213.631718] CPU: 1 UID: 0 PID: 2118 Comm: raw_ethernet_bw Not tainted
               6.12.0-rc7_internal_net_next_mlx5_89a0ad0 #1
[  213.632722] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
               rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
[  213.633785] Call Trace:
[  213.634099]
[  213.634393]  dump_stack_lvl+0x7e/0xc0
[  213.634806]  print_deadlock_bug+0x278/0x3c0
[  213.635265]  __lock_acquire+0x15f4/0x2c40
[  213.635712]  lock_acquire+0xcd/0x2d0
[  213.636120]  ? mlx5_wc_support_get+0x18c/0x210 [mlx5_core]
[  213.636722]  ? mlx5_ib_enable_lb+0x24/0xa0 [mlx5_ib]
[  213.637277]  __mutex_lock+0x81/0xda0
[  213.637697]  ? mlx5_wc_support_get+0x18c/0x210 [mlx5_core]
[  213.638305]  ? mlx5_wc_support_get+0x18c/0x210 [mlx5_core]
[  213.638902]  ? rcu_read_lock_sched_held+0x3f/0x70
[  213.639400]  ? mlx5_wc_support_get+0x18c/0x210 [mlx5_core]
[  213.640016]  mlx5_wc_support_get+0x18c/0x210 [mlx5_core]
[  213.640615]  set_ucontext_resp+0x68/0x2b0 [mlx5_ib]
[  213.641144]  ? debug_mutex_init+0x33/0x40
[  213.641586]  mlx5_ib_alloc_ucontext+0x18e/0x7b0 [mlx5_ib]
[  213.642145]  ib_init_ucontext+0xa0/0xf0 [ib_uverbs]
[  213.642679]  ib_uverbs_handler_UVERBS_METHOD_GET_CONTEXT+0x95/0xc0
                [ib_uverbs]
[  213.643426]  ? _copy_from_user+0x46/0x80
[  213.643878]  ib_uverbs_cmd_verbs+0xa6b/0xc80 [ib_uverbs]
[  213.644426]  ? ib_uverbs_handler_UVERBS_METHOD_INVOKE_WRITE+0x130/0x130
               [ib_uverbs]
[  213.645213]  ? __lock_acquire+0xa99/0x2c40
[  213.645675]  ? lock_acquire+0xcd/0x2d0
[  213.646101]  ? ib_uverbs_ioctl+0xc4/0x170 [ib_uverbs]
[  213.646625]  ? reacquire_held_locks+0xcf/0x1f0
[  213.647102]  ? do_user_addr_fault+0x45d/0x770
[  213.647586]  ib_uverbs_ioctl+0xe0/0x170 [ib_uverbs]
[  213.648102]  ? ib_uverbs_ioctl+0xc4/0x170 [ib_uverbs]
[  213.648632]  __x64_sys_ioctl+0x4d3/0xaa0
[  213.649060]  ? do_user_addr_fault+0x4a8/0x770
[  213.649528]  do_syscall_64+0x6d/0x140
[  213.649947]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
[  213.650478] RIP: 0033:0x7fa179b0737b
[  213.650893] Code: ff ff ff 85 c0 79 9b 49 c7 c4 ff ff ff ff 5b 5d 4c
               89 e0 41 5c c3 66 0f 1f 84 00 00 00 00 00 f3 0f 1e fa b8
               10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d
               7d 2a 0f 00 f7 d8 64 89 01 48
[  213.652619] RSP: 002b:00007ffd2e6d46e8 EFLAGS: 00000246 ORIG_RAX:
               0000000000000010
[  213.653390] RAX: ffffffffffffffda RBX: 00007ffd2e6d47f8 RCX:
               00007fa179b0737b
[  213.654084] RDX: 00007ffd2e6d47e0 RSI: 00000000c0181b01 RDI:
               0000000000000003
[  213.654767] RBP: 00007ffd2e6d47c0 R08: 00007fa1799be010 R09:
               0000000000000002
[  213.655453] R10: 00007ffd2e6d4960 R11: 0000000000000246 R12:
               00007ffd2e6d487c
[  213.656170] R13: 0000000000000027 R14: 0000000000000001 R15:
               00007ffd2e6d4f70

Fixes: d98995b4bf98 ("net/mlx5: Reimplement write combining test")
Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
Reviewed-by: Michael Guralnik <michaelgur@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/wc.c | 24 ++++++++++----------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/wc.c b/drivers/net/ethernet/mellanox/mlx5/core/wc.c
index 1bed75eca97d..740b719e7072 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/wc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/wc.c
@@ -382,6 +382,7 @@ static void mlx5_core_test_wc(struct mlx5_core_dev *mdev)
 
 bool mlx5_wc_support_get(struct mlx5_core_dev *mdev)
 {
+	struct mutex *wc_state_lock = &mdev->wc_state_lock;
 	struct mlx5_core_dev *parent = NULL;
 
 	if (!MLX5_CAP_GEN(mdev, bf)) {
@@ -400,32 +401,31 @@ bool mlx5_wc_support_get(struct mlx5_core_dev *mdev)
 		 */
 		goto out;
 
-	mutex_lock(&mdev->wc_state_lock);
-
-	if (mdev->wc_state != MLX5_WC_STATE_UNINITIALIZED)
-		goto unlock;
-
 #ifdef CONFIG_MLX5_SF
-	if (mlx5_core_is_sf(mdev))
+	if (mlx5_core_is_sf(mdev)) {
 		parent = mdev->priv.parent_mdev;
+		wc_state_lock = &parent->wc_state_lock;
+	}
 #endif
 
-	if (parent) {
-		mutex_lock(&parent->wc_state_lock);
+	mutex_lock(wc_state_lock);
 
+	if (mdev->wc_state != MLX5_WC_STATE_UNINITIALIZED)
+		goto unlock;
+
+	if (parent) {
 		mlx5_core_test_wc(parent);
 
 		mlx5_core_dbg(mdev, "parent set wc_state=%d\n",
 			      parent->wc_state);
 		mdev->wc_state = parent->wc_state;
 
-		mutex_unlock(&parent->wc_state_lock);
+	} else {
+		mlx5_core_test_wc(mdev);
 	}
 
-	mlx5_core_test_wc(mdev);
-
 unlock:
-	mutex_unlock(&mdev->wc_state_lock);
+	mutex_unlock(wc_state_lock);
 out:
 	mlx5_core_dbg(mdev, "wc_state=%d\n", mdev->wc_state);
 
-- 
2.45.0


