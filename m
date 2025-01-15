Return-Path: <netdev+bounces-158494-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D56FA122DB
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 12:41:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 934AC7A392E
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 11:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0F4241682;
	Wed, 15 Jan 2025 11:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tGHSWe+m"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2041.outbound.protection.outlook.com [40.107.93.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE3802139C6
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 11:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736941282; cv=fail; b=NLcZly/KzUU6wqIj4goqCpD15EFp+7DU3DdVhrQbW0ns3TtCDPkSJU90nZZtYblmFwr9lQz0JRjrlwLwdsw2JRldSJvAcWoIqgOXAI8QkYfwYQKnRemIfdFujkgd9O3DdEFBL5ttiH4Ed0F9VBjDiLBoBFCuwQWz94PwTwQCuSM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736941282; c=relaxed/simple;
	bh=CR/SrlWU4dCDcGLQ83jBL65Y5rw1RKVBUN+vdWMr9rg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pRRknKJwrGm8x8F1EflPig0U8w5yJXL1DWzZEErxoH7iOKEd/LuSuLniHWZ5c+3wgTV4ZoBt3WACRRXnuc72ZcB09ZtDqKbuwbZbvrQlrN+ssSNGwx7qdLEH5xiVSqrAe6XpWoq9oWdL6qRwfec4VcPnLYCzzuehNB5R9erjhRI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tGHSWe+m; arc=fail smtp.client-ip=40.107.93.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AZeItylayJUlVVDk3T2JtW5nfYZX9c6+lKfjotIIRIIwtgYxUXz8W22pGT4WLFDQXmp97BiFbP9cOz3jLzvN72Gutz+EJvQHl8t5mMQblhrWxWdxHMZZqu3U+fire/UNNJyhCF3xQ6qWIqTfo7v1pjiDqukFPpOuDMFIrnj2xz6kPx9dlq2ON9E7wLT9p2HZa1Q6RzHJymnYLIwHHuUO9g8FKDavDd15j3CDNQPv/8pdxDOcAyaQcAOxfgy5K2cVQcZXFlJbHyW1KV+2kjCr7Q9I2KPhFYFwql5CzmOmohFQoCizPbcSbgjR+tzWH0JLESaoSiCOEapxFcpJpv0oHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CeIK93Pmu9mL/W3mtrj5lPrcbI64gTivwTBhWzn6b2s=;
 b=xKNLZT/0842Yh80N01pUCftqzqwe9qkxSVBqv/JnyXwkM/8qZ+NfH/zQK32S3sop2B84jhW7L+htBumjEr8NeJQRg683sxmGoFgP9ROTsnIn53cB2PA8w0CS3/Tv2LaYJDZWsJHE64ElfgRrR/wr0gp1cixenZpOw1G9rzYimr7e2h91PGFU8zelMKm5rFMRhDm+tOwPQUfQwG5BV5v3kBUTlAuZ3vlOfrrpZtpA26an+nxSh4KLyUItXvLFCTVI5v4crSzYAVqKfr9BOYxTbK1clwbZVRpb1TJS+XmAuWvQhtklmBMjHKW2AIEbkDqZoFjcmOXcJ8eYV1kiafb0Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CeIK93Pmu9mL/W3mtrj5lPrcbI64gTivwTBhWzn6b2s=;
 b=tGHSWe+mYFYlhzss54Cbvjy2BOMMxZcCPN2uGFtEkwNQXTXWfLqHAVwLa+8j6FBTsqMomkkZzF5PGzcfUYyVumclDSyQlocVDir8whQVLvvo/IPdac91jkAzlUMQO9LxXTTlwy70xmeeDh6EnGJioAsK2bxFWLXkmm463eXqW5+TSb5hbSH2M+DDdw7PXXsGu4eOGwTmrLiGcukGe1i51kkHkhzaLHNz/a3S9JM1Ls3QQfLEoBuXdftp9b20qLLEhumSNqm5lg2vktz1//87LJaMgKMJ5RPfoRgw8Wwtnimf1m9AbckVfCe8AjcWTYPl/GPOLSXXI0ZkaqPG2D9GvA==
Received: from BY5PR17CA0061.namprd17.prod.outlook.com (2603:10b6:a03:167::38)
 by MW6PR12MB8913.namprd12.prod.outlook.com (2603:10b6:303:247::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Wed, 15 Jan
 2025 11:41:16 +0000
Received: from SJ1PEPF00001CE5.namprd03.prod.outlook.com
 (2603:10b6:a03:167:cafe::66) by BY5PR17CA0061.outlook.office365.com
 (2603:10b6:a03:167::38) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.13 via Frontend Transport; Wed,
 15 Jan 2025 11:41:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00001CE5.mail.protection.outlook.com (10.167.242.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.11 via Frontend Transport; Wed, 15 Jan 2025 11:41:15 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 15 Jan
 2025 03:40:59 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 15 Jan
 2025 03:40:58 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Wed, 15 Jan
 2025 03:40:55 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Yishai Hadas
	<yishaih@nvidia.com>, Michael Guralnik <michaelgur@nvidia.com>, "Larysa
 Zaremba" <larysa.zaremba@intel.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net V2 2/7] net/mlx5: Fix a lockdep warning as part of the write combining test
Date: Wed, 15 Jan 2025 13:39:05 +0200
Message-ID: <20250115113910.1990174-3-tariqt@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250115113910.1990174-1-tariqt@nvidia.com>
References: <20250115113910.1990174-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE5:EE_|MW6PR12MB8913:EE_
X-MS-Office365-Filtering-Correlation-Id: 63657de8-5361-45b5-8d4b-08dd355984e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?denur1cEGd6SuTsGB+Bb4y6OPoxl+xIVdZ7cwKY4a7/vr8TBYrkunn7hb6so?=
 =?us-ascii?Q?MfiZ6KRcNKZ448ZGdyZZy0aa6lBW7952U/OTYbXwTOzbyB6MLWZEH0dyzg0h?=
 =?us-ascii?Q?yCViBv28polskZdzz8MU0MsA2w9JlpxbH7D1g4xgNG9oGUApHdNi6PJG3iAV?=
 =?us-ascii?Q?995QQqji6TJ51f7qZnoVxSKvSFSHaioekLYO2d2qGY2Bm5JAZNZlOqNySGN1?=
 =?us-ascii?Q?jn0Fwnase2f8TJitaIxoRT2laXmBMN5doD0FRPEnMYsOLm3tFc3dgu0ov8il?=
 =?us-ascii?Q?wqnuxdMe2Y2pN1uJSYBEdGF3ylCnlVv2v8jrkeKJibJIwhov1n7HjCwjzmmI?=
 =?us-ascii?Q?8fKqE03B4awU3IcgxoluYJbE+3M8H4OLYCKTvGE7ike2DYlT1UukmCYZ1UHS?=
 =?us-ascii?Q?HV5OQnKtihushhe/PYIytsaIo6CQDWmQIWjEh8IRvQPRfswApbYpzCisRwlf?=
 =?us-ascii?Q?IyJ01oL//GCMav7lHBqPth38yOS5LSXmMShZMUGvRaZN25jG6aHo0TjvDbuL?=
 =?us-ascii?Q?K0kM4lufXPdxOxGKJI0Sj7BT45txxGqArWPEqHb3qoGVOhM/N60qmGts62jt?=
 =?us-ascii?Q?8D24ixi7QRFT8l8d5MCnbyRY8xzRQpK/Tk99j9nSwXUpJKxcl5PkMmAGfl19?=
 =?us-ascii?Q?CIHg19w4dUEo1sQv0kJe6P+gS7QgBvJvS9NWbJcdi2qD2SsDr4voars9jKWO?=
 =?us-ascii?Q?N1ERb4drWgOdpwOg+ld2HRRVuyW4Yz66GIOte4eJ17yM72D6HJcxfIGLw7jB?=
 =?us-ascii?Q?157d5uOrrexYYfsrOFgW18iUb2o9ixlzkwrCtAVo41HsUaiu2JrdHuF5aYU+?=
 =?us-ascii?Q?mWyJQxlk+PezT6GU2ra0Uk4k3xJq3egxO4NwCrBqnm1vst9dYy7jaS85t2B1?=
 =?us-ascii?Q?YS9lt5pKNKgiFTkDrE7xZjsO2Gu5lNjPxA5GNxKMFvPEPW/9HPRWWPB2ArQQ?=
 =?us-ascii?Q?706q49cPE7tJN5GlJ3IzSXdKT00cz7VBvKkt+6grjMnOlrJn/gw/YZBf+aLk?=
 =?us-ascii?Q?kxH9bO6oyqFSZwP6nMUgCKhsLvjongmoS3PlfdA/o92bDr/qabcHjGuNBORC?=
 =?us-ascii?Q?TuDFCRfYngEyZkY3/HtilliDYG/ipYiEC7FuQEMH1Jc4/7ua41byRJJlh1rb?=
 =?us-ascii?Q?g9LL8LX5pfUnoaBqH4ClmxpR500x6rd/wkmNqZqDxE5Vg4C1pCGWklDOkyjK?=
 =?us-ascii?Q?SQ0cPOGBK7Og7zdRzy8HAINMbuywH9/D9qGv8GFXF2G+/ZIcuCcYyfv+1741?=
 =?us-ascii?Q?K1t2TJvSBru/zRiipPHjJ5b+H5FwZfpJZqs7FamYDItZN0m6P3CYYl57dnud?=
 =?us-ascii?Q?4rldQtoqnMX3yJX6dctC6OrDUKda78coXP115TrJSSlFQt6LR4R+YdSOvMLW?=
 =?us-ascii?Q?dEgShpAyJ2Ux4ZA02Hh9PbzVkSK4Lzq0I8Le+exy1JmXtEkFxwAFkTdPJOg1?=
 =?us-ascii?Q?mNWQT+Fh7Zv2iM1pX9zQ9atZFgUF1NgyB0szTgIcbmFNIxCUTCYttfB56RUk?=
 =?us-ascii?Q?aqI0KBMgQKzYovQ=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 11:41:15.3029
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63657de8-5361-45b5-8d4b-08dd355984e2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8913

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
Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>
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


