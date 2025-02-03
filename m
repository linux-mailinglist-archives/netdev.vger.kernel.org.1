Return-Path: <netdev+bounces-162270-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B212BA265C2
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 22:37:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D17018862D9
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 21:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2941FECDD;
	Mon,  3 Feb 2025 21:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="noI3QFZw"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2086.outbound.protection.outlook.com [40.107.236.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FF820FA81
	for <netdev@vger.kernel.org>; Mon,  3 Feb 2025 21:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738618615; cv=fail; b=NgfiZ2ok8DSU5GKDjjiESZ0S52ECZRM9Gsk3n3to+OQixRBq+PozNSM7coOL9GknbpAVej/UAtsMWCQWznvjr9mGJIPNJ2ExUBsts6aKrjfU4gr2qyg71hIFAhDlJtaYQLOoe8BAuBBaJfr/AuhUnpnsvlH6eTK5YhUEBb+yrKk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738618615; c=relaxed/simple;
	bh=VVLbK5MAZoYm1Mo/3uNFUAiOiSvfx6ycUiyU3FYbixA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NehdaKgl1u1Mub85YEOM5GQMQddTWjbz1a476T63F9eLiLvp6klUJwJpGxLS6AdFB0sVynZT0rbT+RBvWv3Ne6lwVJLee4KcaX603jM7AALKr3O1O6P/b/B/Y1SE1rfMOdI9BB/NJ3z6r97rfEFM59uPp9jXyF/CInN27qBR/o0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=noI3QFZw; arc=fail smtp.client-ip=40.107.236.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JEzWxT5ZHncUXvzvApJkm+NjOnin7jt3XPMyg7QScd5CZ9Z9SN8SItdQ4qFh/K4+qRMyvRy6OUZCHC6Ar9Kicu2PxyYTbzDEqxRfMRDnKobbvo2ANsrgtPPJRuuCvnA+7kJbTSIARAASWaWTrF6FgaFVnv67nfVojwpQpVZbk0fm9eZtqYLi5K6cLjDFySUbtn5FFXW5Fqi+xmxCGFwB+u/Upix6wNnakhFLGvdG9Rt4kbv7f4muXUBhwMdl/Rp+8OEl0ZLqnZ0kwdz9vkK5r0FSOIcAcPDtD85gGL6vG0CqQ8Fh+VefLiPN+t6KE4VK/bqg+vzKp9lwKBTKBW4Q3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vv1fTujPMz3sJemtBaD/2IBx5kohm9oLWUGh8LZt6v0=;
 b=a6/x6tmvRTuDRlx9ijL4V3IS4xY4QN1d4s3Qpp2jm3ojk8BGZd+vkUSBXrXVKRjiNjdtGLIC1ibRFLZP5VhYtxEYVu04CgtztDoyh4M06bygOpp4vHfBkYvgPZoZbScN26gWiH6z1ASJAwizsBE/362EWhzI18wpJBS1B4JPWBMArEzexeHC5vM7rEiIAkvFtAfD3YKJ2E94QHHos0FAHtv/Mng72LDxmIyc9YNpdm3S7u8YLOsSGdplODUmS3uABGuknMA9yJ621kKRgolVS90+2VpgFXh/U3FRZfmYxE9um6QvtD3GM8OqkEjQSp1+AW809+2MMwvOJEaDyNAzwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vv1fTujPMz3sJemtBaD/2IBx5kohm9oLWUGh8LZt6v0=;
 b=noI3QFZwHhB5PyNaoJ6T6ikWecPdUVpgTY89XqEzL4mammAbmIbZaEuGBuFu5z2FOG4h/RBtuo82viNlL16VhvjyZQFBduwsBSJeNXtvl034V/N9UbGaboJrrRbzPUHX4xBa4hlP+jLh2AQTVDAN8aDL/o3XRe4a9JibKdpfSrICbK4FV8W1s4Q1Vhs+TTS2ppcg5NqANdNBCT40R2UJpmnGGkP9iJLZ54lnqWF0Nr3EIon2drc279zw7PWQBHY2GaJDxMUYL0IpRqbVy4zUDWByPQvAbSQH2pJsvES+iaxa0wTijLhSejkq5kP8f6kxo8ffz0lF9QHnWOE8qRrttQ==
Received: from BYAPR02CA0011.namprd02.prod.outlook.com (2603:10b6:a02:ee::24)
 by IA1PR12MB6186.namprd12.prod.outlook.com (2603:10b6:208:3e6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.20; Mon, 3 Feb
 2025 21:36:45 +0000
Received: from SJ1PEPF00002324.namprd03.prod.outlook.com
 (2603:10b6:a02:ee:cafe::4) by BYAPR02CA0011.outlook.office365.com
 (2603:10b6:a02:ee::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.24 via Frontend Transport; Mon,
 3 Feb 2025 21:36:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00002324.mail.protection.outlook.com (10.167.242.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Mon, 3 Feb 2025 21:36:45 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 3 Feb 2025
 13:36:29 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 3 Feb
 2025 13:36:28 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Mon, 3 Feb
 2025 13:36:25 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 05/15] net/mlx5: Change clock in mlx5_core_dev to mlx5_clock pointer
Date: Mon, 3 Feb 2025 23:35:06 +0200
Message-ID: <20250203213516.227902-6-tariqt@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250203213516.227902-1-tariqt@nvidia.com>
References: <20250203213516.227902-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002324:EE_|IA1PR12MB6186:EE_
X-MS-Office365-Filtering-Correlation-Id: d54230ae-4330-4e59-4b2c-08dd449adb47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SoO90I7xgFjGca3DcKFospTh2xsxlr+RIqMMFez18QMwsJpS1hL3pbqrxy3q?=
 =?us-ascii?Q?a74rOkEjs2U4aO2nMrftO/KWB/FnP9mQbqWNGNw8RZzF1c7RzxRaV+IUg92V?=
 =?us-ascii?Q?z5D8ywlSOuQ5TmSIKXCJLE9Xb+nZ9sDFD/7I2RQP+YXgsZY1t5lOhiB361F6?=
 =?us-ascii?Q?+W60r/u2bzxlSGxj0WZzxXQbz5LRZzm0bd81Yvp1GS+QmGJ6rojFVqwmTIxJ?=
 =?us-ascii?Q?F5HEp8hnCdfSpjNXVs31b2ve7h0w+syZEwzDwPpP05HTe8RcA6hcm5kLSpVh?=
 =?us-ascii?Q?EvKGylE7ArIMVFEKxyyps1ZNIi3YpvJ7nlTVTePf/Kt+wIjr2lXNwmWAeKJO?=
 =?us-ascii?Q?L5t3/J834Mq8XRy8kJYksLAhOkC3qyuEBIPVO21X3AizEPI0dKqVN2x7XQWT?=
 =?us-ascii?Q?tOhXq0M81pBD3gJ2Mzoic2A/i2nHmQ7ZEiRwfzHOipuEwX5S76b1CUdVtO+s?=
 =?us-ascii?Q?dlkEARy2KvOpGmSOun0g6IcU/WuFwiV6rTkVO3TcbN2F6kZIlRVMchazEh3o?=
 =?us-ascii?Q?hJm+Pvb/Si/14jzrVnWyVvWfFvDgh/DUpap/Ac3zRa5gP5JH5OahkdH85DHM?=
 =?us-ascii?Q?NNvjDdouA4jpDY97bVbBEHOn9+9hdCJCa0JCqj8EHZu+YpNo/20WY+qrhUx7?=
 =?us-ascii?Q?fBWrlySpDtWHsKe5heXC68np5ixGxYN8YMxX1tOA0Z/wm1kcAJRaW664Wd/o?=
 =?us-ascii?Q?0QhNFv3+IB9dG4rZ3X0koKGZ9obtG0SArnQoklOiDiRncRIXhnuIcv/3f+xH?=
 =?us-ascii?Q?/ZUEY1AoMDje4cLl7nda/nKiwHQmJmSZqyvAniNyTqsaf/brO1daJLvTEzPY?=
 =?us-ascii?Q?feyfB9S9O+2iH0+7Tznyq50GYtDuY002dfmKtUjxQS+mVfPjGHbt03WnlyEB?=
 =?us-ascii?Q?30qR9jESORcx/VDDAbE66i2Sxkut0dfe7/RvMvxEi0sgjfK/YZ7iQLvdIxph?=
 =?us-ascii?Q?FbQ1id2FGhfLlKjYhYAl2tNGSi2KMVgPEJYCvbmREFA7niRcNvviXO5VLG7z?=
 =?us-ascii?Q?WAHtIGACXaA3yUomJY4rxo/bY+/Xp+D2HbY8GIPtVFb6IJXyOokIASIkp5hA?=
 =?us-ascii?Q?aAeVHP917RZGZrgI6SltfVAtMXaQ1MytXi/2o2FFMyJW6ANzB/KlKum9YOW7?=
 =?us-ascii?Q?oijokKHnZBX5vDedp0L6yq/tXHokCnPnQ3fWX+kZC7qSZoFBgTXj6osmItsK?=
 =?us-ascii?Q?gjqpgE8Dibf3ptUFEmeNaTRIHl7NgKTS2ddamXyE55CrWvFW5h7STEEqCt8k?=
 =?us-ascii?Q?uf1167SYJ9m2Vs7LYtuCdMOieCMeh43HsP47CdvM7Yz2HAxngcMExca1KWwx?=
 =?us-ascii?Q?+frCDRz+/RQDFISNKGrez4ieY3oQq5eUsk7+yMWWF3B7PVPgLsZmd7G2xbVm?=
 =?us-ascii?Q?AHCfSI8E6dHmoAnvT2hJdFaWJTsB7MQ2/j/8MuxhvNi2nx1qdBT1tnQ6FJcj?=
 =?us-ascii?Q?Q3rw/meAZOMbe0PUcIY/TR8s/LHgj1Hqb21Cd0YHVcMGHmAjy/Pk4pIEfENQ?=
 =?us-ascii?Q?uJ9WHjvHc3oR2fw=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2025 21:36:45.0388
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d54230ae-4330-4e59-4b2c-08dd449adb47
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002324.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6186

From: Jianbo Liu <jianbol@nvidia.com>

Change clock member in mlx5_core_dev to a pointer, so it can point to
a clock shared by multiple functions in later patch.

For now, each function has its own clock, so mdev in mlx5_clock_priv
is the back pointer to the function. Later it points to one (normally
the first one) of the multiple functions sharing the same clock.

Change mlx5_init_clock() to return error if mlx5_clock is not
allocated. Besides, a null clock is defined and used when hardware
clock is not supported. So, the clock pointer is always pointing to
something valid.

Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en/ptp.c  |  4 +-
 .../net/ethernet/mellanox/mlx5/core/en/trap.c |  2 +-
 .../net/ethernet/mellanox/mlx5/core/en/xdp.c  |  4 +-
 .../mellanox/mlx5/core/en/xsk/setup.c         |  2 +-
 .../net/ethernet/mellanox/mlx5/core/en_main.c |  4 +-
 .../ethernet/mellanox/mlx5/core/lib/clock.c   | 87 ++++++++++++++-----
 .../ethernet/mellanox/mlx5/core/lib/clock.h   | 35 +++++++-
 .../net/ethernet/mellanox/mlx5/core/main.c    | 11 ++-
 include/linux/mlx5/driver.h                   | 31 +------
 9 files changed, 116 insertions(+), 64 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c b/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
index afd654583b6b..131ed97ca997 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
@@ -326,7 +326,7 @@ static int mlx5e_ptp_alloc_txqsq(struct mlx5e_ptp *c, int txq_ix,
 	int node;
 
 	sq->pdev      = c->pdev;
-	sq->clock     = &mdev->clock;
+	sq->clock     = mdev->clock;
 	sq->mkey_be   = c->mkey_be;
 	sq->netdev    = c->netdev;
 	sq->priv      = c->priv;
@@ -696,7 +696,7 @@ static int mlx5e_init_ptp_rq(struct mlx5e_ptp *c, struct mlx5e_params *params,
 	rq->pdev         = c->pdev;
 	rq->netdev       = priv->netdev;
 	rq->priv         = priv;
-	rq->clock        = &mdev->clock;
+	rq->clock        = mdev->clock;
 	rq->tstamp       = &priv->tstamp;
 	rq->mdev         = mdev;
 	rq->hw_mtu       = MLX5E_SW2HW_MTU(params, params->sw_mtu);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/trap.c b/drivers/net/ethernet/mellanox/mlx5/core/en/trap.c
index 53ca16cb9c41..140606fcd23b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/trap.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/trap.c
@@ -46,7 +46,7 @@ static void mlx5e_init_trap_rq(struct mlx5e_trap *t, struct mlx5e_params *params
 	rq->pdev         = t->pdev;
 	rq->netdev       = priv->netdev;
 	rq->priv         = priv;
-	rq->clock        = &mdev->clock;
+	rq->clock        = mdev->clock;
 	rq->tstamp       = &priv->tstamp;
 	rq->mdev         = mdev;
 	rq->hw_mtu       = MLX5E_SW2HW_MTU(params, params->sw_mtu);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
index 94b291662087..3cc4d55613bf 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
@@ -289,9 +289,9 @@ static u64 mlx5e_xsk_fill_timestamp(void *_priv)
 	ts = get_cqe_ts(priv->cqe);
 
 	if (mlx5_is_real_time_rq(priv->cq->mdev) || mlx5_is_real_time_sq(priv->cq->mdev))
-		return mlx5_real_time_cyc2time(&priv->cq->mdev->clock, ts);
+		return mlx5_real_time_cyc2time(priv->cq->mdev->clock, ts);
 
-	return  mlx5_timecounter_cyc2time(&priv->cq->mdev->clock, ts);
+	return  mlx5_timecounter_cyc2time(priv->cq->mdev->clock, ts);
 }
 
 static void mlx5e_xsk_request_checksum(u16 csum_start, u16 csum_offset, void *priv)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/setup.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/setup.c
index 9240cfe25d10..d743e823362a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/setup.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xsk/setup.c
@@ -72,7 +72,7 @@ static int mlx5e_init_xsk_rq(struct mlx5e_channel *c,
 	rq->netdev       = c->netdev;
 	rq->priv         = c->priv;
 	rq->tstamp       = c->tstamp;
-	rq->clock        = &mdev->clock;
+	rq->clock        = mdev->clock;
 	rq->icosq        = &c->icosq;
 	rq->ix           = c->ix;
 	rq->channel      = c;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index a814b63ed97e..c754e0c75934 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -737,7 +737,7 @@ static int mlx5e_init_rxq_rq(struct mlx5e_channel *c, struct mlx5e_params *param
 	rq->netdev       = c->netdev;
 	rq->priv         = c->priv;
 	rq->tstamp       = c->tstamp;
-	rq->clock        = &mdev->clock;
+	rq->clock        = mdev->clock;
 	rq->icosq        = &c->icosq;
 	rq->ix           = c->ix;
 	rq->channel      = c;
@@ -1614,7 +1614,7 @@ static int mlx5e_alloc_txqsq(struct mlx5e_channel *c,
 	int err;
 
 	sq->pdev      = c->pdev;
-	sq->clock     = &mdev->clock;
+	sq->clock     = mdev->clock;
 	sq->mkey_be   = c->mkey_be;
 	sq->netdev    = c->netdev;
 	sq->mdev      = c->mdev;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
index b2c88050ba36..da2a21ce8060 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
@@ -77,9 +77,19 @@ enum {
 	MLX5_MTUTC_OPERATION_ADJUST_TIME_EXTENDED_MAX = 200000,
 };
 
+struct mlx5_clock_priv {
+	struct mlx5_clock clock;
+	struct mlx5_core_dev *mdev;
+};
+
+static struct mlx5_clock_priv *clock_priv(struct mlx5_clock *clock)
+{
+	return container_of(clock, struct mlx5_clock_priv, clock);
+}
+
 static struct mlx5_core_dev *mlx5_clock_mdev_get(struct mlx5_clock *clock)
 {
-	return container_of(clock, struct mlx5_core_dev, clock);
+	return clock_priv(clock)->mdev;
 }
 
 static bool mlx5_real_time_mode(struct mlx5_core_dev *mdev)
@@ -219,7 +229,7 @@ static int mlx5_mtctr_syncdevicetime(ktime_t *device_time,
 	if (real_time_mode)
 		*device_time = ns_to_ktime(REAL_TIME_TO_NS(device >> 32, device & U32_MAX));
 	else
-		*device_time = mlx5_timecounter_cyc2time(&mdev->clock, device);
+		*device_time = mlx5_timecounter_cyc2time(mdev->clock, device);
 
 	return 0;
 }
@@ -281,7 +291,7 @@ static u64 read_internal_timer(const struct cyclecounter *cc)
 static void mlx5_update_clock_info_page(struct mlx5_core_dev *mdev)
 {
 	struct mlx5_ib_clock_info *clock_info = mdev->clock_info;
-	struct mlx5_clock *clock = &mdev->clock;
+	struct mlx5_clock *clock = mdev->clock;
 	struct mlx5_timer *timer;
 	u32 sign;
 
@@ -599,7 +609,7 @@ static int mlx5_extts_configure(struct ptp_clock_info *ptp,
 
 static u64 find_target_cycles(struct mlx5_core_dev *mdev, s64 target_ns)
 {
-	struct mlx5_clock *clock = &mdev->clock;
+	struct mlx5_clock *clock = mdev->clock;
 	u64 cycles_now, cycles_delta;
 	u64 nsec_now, nsec_delta;
 	struct mlx5_timer *timer;
@@ -658,7 +668,7 @@ static int mlx5_perout_conf_out_pulse_duration(struct mlx5_core_dev *mdev,
 					       struct ptp_clock_request *rq,
 					       u32 *out_pulse_duration_ns)
 {
-	struct mlx5_pps *pps_info = &mdev->clock.pps_info;
+	struct mlx5_pps *pps_info = &mdev->clock->pps_info;
 	u32 out_pulse_duration;
 	struct timespec64 ts;
 
@@ -691,7 +701,7 @@ static int perout_conf_npps_real_time(struct mlx5_core_dev *mdev, struct ptp_clo
 				      u32 *field_select, u32 *out_pulse_duration_ns,
 				      u64 *period, u64 *time_stamp)
 {
-	struct mlx5_pps *pps_info = &mdev->clock.pps_info;
+	struct mlx5_pps *pps_info = &mdev->clock->pps_info;
 	struct ptp_clock_time *time = &rq->perout.start;
 	struct timespec64 ts;
 
@@ -901,7 +911,7 @@ static int mlx5_get_pps_pin_mode(struct mlx5_core_dev *mdev, u8 pin)
 
 static void mlx5_init_pin_config(struct mlx5_core_dev *mdev)
 {
-	struct mlx5_clock *clock = &mdev->clock;
+	struct mlx5_clock *clock = mdev->clock;
 	int i;
 
 	if (!clock->ptp_info.n_pins)
@@ -929,8 +939,8 @@ static void mlx5_init_pin_config(struct mlx5_core_dev *mdev)
 
 static void mlx5_get_pps_caps(struct mlx5_core_dev *mdev)
 {
-	struct mlx5_clock *clock = &mdev->clock;
 	u32 out[MLX5_ST_SZ_DW(mtpps_reg)] = {0};
+	struct mlx5_clock *clock = mdev->clock;
 
 	mlx5_query_mtpps(mdev, out, sizeof(out));
 
@@ -1025,7 +1035,7 @@ static int mlx5_pps_event(struct notifier_block *nb,
 
 static void mlx5_timecounter_init(struct mlx5_core_dev *mdev)
 {
-	struct mlx5_clock *clock = &mdev->clock;
+	struct mlx5_clock *clock = mdev->clock;
 	struct mlx5_timer *timer = &clock->timer;
 	u32 dev_freq;
 
@@ -1044,7 +1054,7 @@ static void mlx5_timecounter_init(struct mlx5_core_dev *mdev)
 static void mlx5_init_overflow_period(struct mlx5_core_dev *mdev)
 {
 	struct mlx5_ib_clock_info *clock_info = mdev->clock_info;
-	struct mlx5_clock *clock = &mdev->clock;
+	struct mlx5_clock *clock = mdev->clock;
 	struct mlx5_timer *timer = &clock->timer;
 	u64 overflow_cycles;
 	u64 frac = 0;
@@ -1077,7 +1087,7 @@ static void mlx5_init_overflow_period(struct mlx5_core_dev *mdev)
 
 static void mlx5_init_clock_info(struct mlx5_core_dev *mdev)
 {
-	struct mlx5_clock *clock = &mdev->clock;
+	struct mlx5_clock *clock = mdev->clock;
 	struct mlx5_ib_clock_info *info;
 	struct mlx5_timer *timer;
 
@@ -1100,7 +1110,7 @@ static void mlx5_init_clock_info(struct mlx5_core_dev *mdev)
 
 static void mlx5_init_timer_max_freq_adjustment(struct mlx5_core_dev *mdev)
 {
-	struct mlx5_clock *clock = &mdev->clock;
+	struct mlx5_clock *clock = mdev->clock;
 	u32 out[MLX5_ST_SZ_DW(mtutc_reg)] = {};
 	u32 in[MLX5_ST_SZ_DW(mtutc_reg)] = {};
 	u8 log_max_freq_adjustment = 0;
@@ -1119,7 +1129,7 @@ static void mlx5_init_timer_max_freq_adjustment(struct mlx5_core_dev *mdev)
 
 static void mlx5_init_timer_clock(struct mlx5_core_dev *mdev)
 {
-	struct mlx5_clock *clock = &mdev->clock;
+	struct mlx5_clock *clock = mdev->clock;
 
 	/* Configure the PHC */
 	clock->ptp_info = mlx5_ptp_clock_info;
@@ -1156,7 +1166,7 @@ static void mlx5_init_pps(struct mlx5_core_dev *mdev)
 
 static void mlx5_init_clock_dev(struct mlx5_core_dev *mdev)
 {
-	struct mlx5_clock *clock = &mdev->clock;
+	struct mlx5_clock *clock = mdev->clock;
 
 	seqlock_init(&clock->lock);
 
@@ -1180,7 +1190,7 @@ static void mlx5_init_clock_dev(struct mlx5_core_dev *mdev)
 
 static void mlx5_destroy_clock_dev(struct mlx5_core_dev *mdev)
 {
-	struct mlx5_clock *clock = &mdev->clock;
+	struct mlx5_clock *clock = mdev->clock;
 
 	if (clock->ptp) {
 		ptp_clock_unregister(clock->ptp);
@@ -1195,25 +1205,60 @@ static void mlx5_destroy_clock_dev(struct mlx5_core_dev *mdev)
 	kfree(clock->ptp_info.pin_config);
 }
 
-void mlx5_init_clock(struct mlx5_core_dev *mdev)
+static void mlx5_clock_free(struct mlx5_core_dev *mdev)
+{
+	struct mlx5_clock_priv *cpriv = clock_priv(mdev->clock);
+
+	mlx5_destroy_clock_dev(mdev);
+	kfree(cpriv);
+	mdev->clock = NULL;
+}
+
+static int mlx5_clock_alloc(struct mlx5_core_dev *mdev)
 {
-	struct mlx5_clock *clock = &mdev->clock;
+	struct mlx5_clock_priv *cpriv;
+	struct mlx5_clock *clock;
+
+	cpriv = kzalloc(sizeof(*cpriv), GFP_KERNEL);
+	if (!cpriv)
+		return -ENOMEM;
+
+	cpriv->mdev = mdev;
+	clock = &cpriv->clock;
+	mdev->clock = clock;
+	mlx5_init_clock_dev(mdev);
+
+	return 0;
+}
+
+static struct mlx5_clock null_clock;
+
+int mlx5_init_clock(struct mlx5_core_dev *mdev)
+{
+	struct mlx5_clock *clock;
+	int err;
 
 	if (!MLX5_CAP_GEN(mdev, device_frequency_khz)) {
+		mdev->clock = &null_clock;
 		mlx5_core_warn(mdev, "invalid device_frequency_khz, aborting HW clock init\n");
-		return;
+		return 0;
 	}
 
-	mlx5_init_clock_dev(mdev);
+	err = mlx5_clock_alloc(mdev);
+	if (err)
+		return err;
+	clock = mdev->clock;
 
 	INIT_WORK(&clock->pps_info.out_work, mlx5_pps_out);
 	MLX5_NB_INIT(&clock->pps_nb, mlx5_pps_event, PPS_EVENT);
 	mlx5_eq_notifier_register(mdev, &clock->pps_nb);
+
+	return 0;
 }
 
 void mlx5_cleanup_clock(struct mlx5_core_dev *mdev)
 {
-	struct mlx5_clock *clock = &mdev->clock;
+	struct mlx5_clock *clock = mdev->clock;
 
 	if (!MLX5_CAP_GEN(mdev, device_frequency_khz))
 		return;
@@ -1221,5 +1266,5 @@ void mlx5_cleanup_clock(struct mlx5_core_dev *mdev)
 	mlx5_eq_notifier_unregister(mdev, &clock->pps_nb);
 	cancel_work_sync(&clock->pps_info.out_work);
 
-	mlx5_destroy_clock_dev(mdev);
+	mlx5_clock_free(mdev);
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.h b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.h
index bd95b9f8d143..eca1dd9039be 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.h
@@ -33,6 +33,35 @@
 #ifndef __LIB_CLOCK_H__
 #define __LIB_CLOCK_H__
 
+#include <linux/ptp_clock_kernel.h>
+
+#define MAX_PIN_NUM	8
+struct mlx5_pps {
+	u8                         pin_caps[MAX_PIN_NUM];
+	struct work_struct         out_work;
+	u64                        start[MAX_PIN_NUM];
+	u8                         enabled;
+	u64                        min_npps_period;
+	u64                        min_out_pulse_duration_ns;
+};
+
+struct mlx5_timer {
+	struct cyclecounter        cycles;
+	struct timecounter         tc;
+	u32                        nominal_c_mult;
+	unsigned long              overflow_period;
+};
+
+struct mlx5_clock {
+	struct mlx5_nb             pps_nb;
+	seqlock_t                  lock;
+	struct hwtstamp_config     hwtstamp_config;
+	struct ptp_clock          *ptp;
+	struct ptp_clock_info      ptp_info;
+	struct mlx5_pps            pps_info;
+	struct mlx5_timer          timer;
+};
+
 static inline bool mlx5_is_real_time_rq(struct mlx5_core_dev *mdev)
 {
 	u8 rq_ts_format_cap = MLX5_CAP_GEN(mdev, rq_ts_format);
@@ -54,12 +83,12 @@ static inline bool mlx5_is_real_time_sq(struct mlx5_core_dev *mdev)
 typedef ktime_t (*cqe_ts_to_ns)(struct mlx5_clock *, u64);
 
 #if IS_ENABLED(CONFIG_PTP_1588_CLOCK)
-void mlx5_init_clock(struct mlx5_core_dev *mdev);
+int mlx5_init_clock(struct mlx5_core_dev *mdev);
 void mlx5_cleanup_clock(struct mlx5_core_dev *mdev);
 
 static inline int mlx5_clock_get_ptp_index(struct mlx5_core_dev *mdev)
 {
-	return mdev->clock.ptp ? ptp_clock_index(mdev->clock.ptp) : -1;
+	return mdev->clock->ptp ? ptp_clock_index(mdev->clock->ptp) : -1;
 }
 
 static inline ktime_t mlx5_timecounter_cyc2time(struct mlx5_clock *clock,
@@ -87,7 +116,7 @@ static inline ktime_t mlx5_real_time_cyc2time(struct mlx5_clock *clock,
 	return ns_to_ktime(time);
 }
 #else
-static inline void mlx5_init_clock(struct mlx5_core_dev *mdev) {}
+static inline int mlx5_init_clock(struct mlx5_core_dev *mdev) { return 0; }
 static inline void mlx5_cleanup_clock(struct mlx5_core_dev *mdev) {}
 static inline int mlx5_clock_get_ptp_index(struct mlx5_core_dev *mdev)
 {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index ec956c4bcebd..996773521aee 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -1038,7 +1038,11 @@ static int mlx5_init_once(struct mlx5_core_dev *dev)
 
 	mlx5_init_reserved_gids(dev);
 
-	mlx5_init_clock(dev);
+	err = mlx5_init_clock(dev);
+	if (err) {
+		mlx5_core_err(dev, "failed to initialize hardware clock\n");
+		goto err_tables_cleanup;
+	}
 
 	dev->vxlan = mlx5_vxlan_create(dev);
 	dev->geneve = mlx5_geneve_create(dev);
@@ -1046,7 +1050,7 @@ static int mlx5_init_once(struct mlx5_core_dev *dev)
 	err = mlx5_init_rl_table(dev);
 	if (err) {
 		mlx5_core_err(dev, "Failed to init rate limiting\n");
-		goto err_tables_cleanup;
+		goto err_clock_cleanup;
 	}
 
 	err = mlx5_mpfs_init(dev);
@@ -1123,10 +1127,11 @@ static int mlx5_init_once(struct mlx5_core_dev *dev)
 	mlx5_mpfs_cleanup(dev);
 err_rl_cleanup:
 	mlx5_cleanup_rl_table(dev);
-err_tables_cleanup:
+err_clock_cleanup:
 	mlx5_geneve_destroy(dev->geneve);
 	mlx5_vxlan_destroy(dev->vxlan);
 	mlx5_cleanup_clock(dev);
+err_tables_cleanup:
 	mlx5_cleanup_reserved_gids(dev);
 	mlx5_cq_debugfs_cleanup(dev);
 	mlx5_fw_reset_cleanup(dev);
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index af86097641b0..5dab3d8d05e4 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -54,7 +54,6 @@
 #include <linux/mlx5/doorbell.h>
 #include <linux/mlx5/eq.h>
 #include <linux/timecounter.h>
-#include <linux/ptp_clock_kernel.h>
 #include <net/devlink.h>
 
 #define MLX5_ADEV_NAME "mlx5_core"
@@ -679,33 +678,7 @@ struct mlx5_rsvd_gids {
 	struct ida ida;
 };
 
-#define MAX_PIN_NUM	8
-struct mlx5_pps {
-	u8                         pin_caps[MAX_PIN_NUM];
-	struct work_struct         out_work;
-	u64                        start[MAX_PIN_NUM];
-	u8                         enabled;
-	u64                        min_npps_period;
-	u64                        min_out_pulse_duration_ns;
-};
-
-struct mlx5_timer {
-	struct cyclecounter        cycles;
-	struct timecounter         tc;
-	u32                        nominal_c_mult;
-	unsigned long              overflow_period;
-};
-
-struct mlx5_clock {
-	struct mlx5_nb             pps_nb;
-	seqlock_t                  lock;
-	struct hwtstamp_config     hwtstamp_config;
-	struct ptp_clock          *ptp;
-	struct ptp_clock_info      ptp_info;
-	struct mlx5_pps            pps_info;
-	struct mlx5_timer          timer;
-};
-
+struct mlx5_clock;
 struct mlx5_dm;
 struct mlx5_fw_tracer;
 struct mlx5_vxlan;
@@ -789,7 +762,7 @@ struct mlx5_core_dev {
 #ifdef CONFIG_MLX5_FPGA
 	struct mlx5_fpga_device *fpga;
 #endif
-	struct mlx5_clock        clock;
+	struct mlx5_clock       *clock;
 	struct mlx5_ib_clock_info  *clock_info;
 	struct mlx5_fw_tracer   *tracer;
 	struct mlx5_rsc_dump    *rsc_dump;
-- 
2.45.0


