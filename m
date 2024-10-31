Return-Path: <netdev+bounces-140716-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 723059B7B38
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 14:00:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2559B2445F
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 13:00:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D841A19D892;
	Thu, 31 Oct 2024 13:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RcJ01zsh"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF311974F4
	for <netdev@vger.kernel.org>; Thu, 31 Oct 2024 13:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730379609; cv=fail; b=Q7oVv+wTzWvFYOBmZ2Abt+bZ6Is1THdryEyGza+JmNgIe83TvlNaZBBN+3Zcn3PvK3njpXJrSi4NDp0Gwrrc3yrMnrd1/axNXBPH3S2HeZl22qf5YMPonVDynjtPRhnILdlATZNsxsud5LvtWQGgE1ZSAVu31c4H5/QlAR0Nt8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730379609; c=relaxed/simple;
	bh=IzBA21ZoUNWRSmEhzaqMsSKfu/H7uAmX5jeilR+1fo0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nPkhSlEUmRYuLNbXXS+VIyBrcGC5BhRvKipis3D/3NakmhC5+2UeeLfPHblQpOFNouBopE/kDDRCtOHjukQTmaka//FrBQwI8uHD80o+qXtQcibn9QIKnhW2g5QZ+SoUtzj3SxEaA/qGwMC8ENgSdlKNxNqyfvdUGaS+FWXcxPk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RcJ01zsh; arc=fail smtp.client-ip=40.107.92.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hE4AvTFfQNmlj2JxtD58b4hwx74XHc0d0pR1adB2C4tPFfB+L02c761gN5IvV7H8bP9r8sBo45SA50/L86OK4y7cDBNvY5tBxZsffVo7TxgXzJY9H//JmVN9+XJO0gPm62xbcMkHdUIzSqqagaVRppO9NkXZ8PgFOg5YlJTSkQKy/mSrLPuuS2MbmPjQQWEtq/h/YznIriP89t9kZd8/eUiZwusRPPXWyQG/oj27McGWvLlOsSRwxlBEIO4g93EcPmfvp352KWkPvIxW2xczlwhxPRFAAlMMJ/he7epaIjV00MR1A+g0ihHbWKbiRnlXR9Y9VVIxrXWfQwWekRnwsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gY4hlquz3YL9+qExnqbiMea5By00s5wrPkZU6MffK7I=;
 b=fF9pFBG4Kmd1gftj/eSTC+reOdk1t60UvIXJLxuBO7b+KlFzZVvEBl0p5ApdikStkuMPzCEm50QGQz0kmu1iycDiJse2j6F0CDZVo6ituA+tPFaP8MIz1WF2X7GIiQL45E4X9zb6ZLhKyrXC3GOo84LJ4mDPh6EwMitVNI+IWiHHF9T2oxXCwoTser9pDy+9nHjNXg/Dw1CYAmCbC/LT+7ToYHqv9FQ8M2MHpqFOcDHxa4mNWeKuRfllHNEoga4ixc/230QI5j5LuXbIxV9sr0UrAvxR/2aQjR5CEUUNtb5g0tnQgrCSQ8x5oncZ6c5o7jZMa789F1g/2wg/I3psOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gY4hlquz3YL9+qExnqbiMea5By00s5wrPkZU6MffK7I=;
 b=RcJ01zshv132cVlTX/Sg4PsWaPzFCWlJVishqHBAngV4AnxWVDkB4xSMpEjCqxPoS+UZy0ZpCTAQlRNGUbvC1Ib3mQF8ZbpFYqfmVpoD6RViu2SKer2PL9BmweOvVYfx6k116hKETOnTk2w/GDhv9xX1Vdxf/NkGhKPgXR54ajs2H6BhwVE1ZMwyJBse+CQex/w6XfSyDgvX96QHnPclthoLySsS/K7eUG057mBJTigyCn6lXX31COk/h1wf/cLUzBILmolTTVrQDy6w+39Ehb0bGfX4A5Fe066naT9Hcnp1IGVet524bA+0BwVHBApkCjaholadlJV6llIa8CH14Q==
Received: from CH3P221CA0005.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1e7::29)
 by BL1PR12MB5970.namprd12.prod.outlook.com (2603:10b6:208:399::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Thu, 31 Oct
 2024 13:00:00 +0000
Received: from DS2PEPF0000343F.namprd02.prod.outlook.com
 (2603:10b6:610:1e7:cafe::1c) by CH3P221CA0005.outlook.office365.com
 (2603:10b6:610:1e7::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.23 via Frontend
 Transport; Thu, 31 Oct 2024 13:00:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS2PEPF0000343F.mail.protection.outlook.com (10.167.18.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.16 via Frontend Transport; Thu, 31 Oct 2024 12:59:59 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 31 Oct
 2024 05:59:40 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 31 Oct 2024 05:59:39 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 31 Oct 2024 05:59:37 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net-next 1/5] net/mlx5: Rework esw qos domain init and cleanup
Date: Thu, 31 Oct 2024 14:58:52 +0200
Message-ID: <20241031125856.530927-2-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241031125856.530927-1-tariqt@nvidia.com>
References: <20241031125856.530927-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343F:EE_|BL1PR12MB5970:EE_
X-MS-Office365-Filtering-Correlation-Id: ea0d5e5e-cc18-449f-ad70-08dcf9abeda2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qJ92a7wBivO8RDVobl9MNMGTBf9n7/QM2hnBg/Nza9ghsWrlPj5l9YGwfy0r?=
 =?us-ascii?Q?4EM3dXj9eavsm+OPBukMOi28TNpTkIJPf5YdFjUPA+acT+g81eI/vW7rWxdJ?=
 =?us-ascii?Q?yZeWZA+IU01dE9AyEJ8j1yD4tRLEEgEfUPwqpi48mJclkNPos3Nja0l2hF8/?=
 =?us-ascii?Q?nWyy7k3ArsPWnZg5/qNqI6djR8kVmSN7Xb8iWoJi6CdMSKnDQU4O2VVETQKZ?=
 =?us-ascii?Q?9xlcoSh0Eps4ORDIKanXBeFYQY07Uz2443Zv0oqag1AZfMPWmgfRo5B8sAKL?=
 =?us-ascii?Q?ykJE37dnZ1TgTGtswB8/i4O3Rs/wdUzSZ3/iVkcmYqmw3MMLwbAMJLEGJE+O?=
 =?us-ascii?Q?7cyT4qleu9Jrtt07GvWL/8CFtYKC+H1JQ6F6ajHxGCGvq3MKq3v8B09m2MJK?=
 =?us-ascii?Q?JEwVfRyAZCpdijM0wsZQKPSs7Zd6+F3W7QTQdNxbGZCCnPNGaHdb4IeB8Aai?=
 =?us-ascii?Q?mfkApzK87RPUKzR9plJ1WyPSzO+tueAYewHRVnz1PDvhkpnnrSA0WQX7XxvR?=
 =?us-ascii?Q?f+xDpobb1C0eZMbFj2B1IPBvvGvUagXwjFntnwUghMl+YXXNzMa0elNbLX1b?=
 =?us-ascii?Q?KIFwT7sxL2MKI1P1cQa+aTqbaqW5+gI/Sb4lU4IgFStlkiQcSJG8kzAXQTVN?=
 =?us-ascii?Q?/91Xe28m5HxsHWvH679ZD0hUX80I3Us6GDUYJv3wwLHvOFzREUuOhU+/wzVJ?=
 =?us-ascii?Q?1eXrUi3ZWB/FJzaPYewUJ1q1iWLGQaXFDLUXTU5rLxjXJJAP9+YG8m5y6MMQ?=
 =?us-ascii?Q?d6Amw8INXFVUNKytwGbqBi9NiV8/2NRRgB0eoNQO+l7vSPvKHq13H2bmWLYa?=
 =?us-ascii?Q?p1OlYTWACQNhqTQ66H/cWbccIss5kK+980z/DrNGYpqYvSbedrDFlua31DmG?=
 =?us-ascii?Q?66gJ2IEsMEBm5m/z/3L44FueEkWn7I7A4qtCoNGlvXv+UFBCodCy6lzc3pKZ?=
 =?us-ascii?Q?ueCTAyaOuovqeFqoKwvQ2WvpOAgIQT4H2vYN777A+Mi551liXVUq7CYBIDIh?=
 =?us-ascii?Q?PGltgkxbBH+N9acHfrBD3Yn9t3UrxwgkgQUNAR2Jo/Lv+bAj8a+zdPWBzCZi?=
 =?us-ascii?Q?7YlBXiCsvwre0R9ON8ydWqqdV5P9PNtvr3oPLMrI4T7nNMoz++bpIQzpsxph?=
 =?us-ascii?Q?Vt9Onlb4v58zaU9xhc/CcHvIyICOyjdH6RKO6oSnCWg39VCKtIsWqA7a9UI1?=
 =?us-ascii?Q?TwfTSR+UOPYNdCLw7Wjdlzsb6VeySCyj0psc0ynxClkMDpq1744l7pjFbelR?=
 =?us-ascii?Q?RM/JYVK1jpf0lhA4xfUQQwsJ56yr8VyRdcCsY7bPpfwiSPYmDPwZZDsxvgh1?=
 =?us-ascii?Q?+HweDCfyVufkKPyB90M5ntjzfk0WRl8IZQ3/Qa2o2yb8O/4DNKj94X4maXh0?=
 =?us-ascii?Q?Vzp7MRTU1mRMWKgrqFvQRpG9qBKRuv6Sg7FOOLX/KrtkKYAp5Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 12:59:59.9946
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea0d5e5e-cc18-449f-ad70-08dcf9abeda2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5970

From: Cosmin Ratiu <cratiu@nvidia.com>

The first approach was flawed, because there are situations where the
esw mode change fails, leaving the qos domain as NULL. Various calls
into the QoS infra then trigger a NULL pointer access and unhappiness.

Improve that by a combination of:
- Allocating the QoS domain on esw init and cleaning it up on teardown.
- Refactoring mode change to only call qos domain init but not cleanup.
- Making qos domain init idempotent - not change anything if nothing
  needs changing.

Together, these should guarantee that, as long as the memory allocations
succeed, there should always be a valid qos domain until the esw
cleanup, no matter what mode changes happen (or failures thereof).

Fixes: 107a034d5c1e ("net/mlx5: qos: Store rate groups in a qos domain")
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/esw/qos.c    |  3 +++
 .../net/ethernet/mellanox/mlx5/core/eswitch.c    | 16 +++++++++-------
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index 7e7f99b38a37..940e1c2d1e39 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
@@ -951,6 +951,9 @@ static int esw_qos_devlink_rate_to_mbps(struct mlx5_core_dev *mdev, const char *
 
 int mlx5_esw_qos_init(struct mlx5_eswitch *esw)
 {
+	if (esw->qos.domain)
+		return 0;  /* Nothing to change. */
+
 	return esw_qos_domain_init(esw);
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
index 09719e9b8611..cead41ddbc38 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
@@ -1485,7 +1485,7 @@ int mlx5_eswitch_enable_locked(struct mlx5_eswitch *esw, int num_vfs)
 
 	err = mlx5_esw_qos_init(esw);
 	if (err)
-		goto err_qos_init;
+		goto err_esw_init;
 
 	if (esw->mode == MLX5_ESWITCH_LEGACY) {
 		err = esw_legacy_enable(esw);
@@ -1495,7 +1495,7 @@ int mlx5_eswitch_enable_locked(struct mlx5_eswitch *esw, int num_vfs)
 	}
 
 	if (err)
-		goto err_esw_enable;
+		goto err_esw_init;
 
 	esw->fdb_table.flags |= MLX5_ESW_FDB_CREATED;
 
@@ -1509,9 +1509,7 @@ int mlx5_eswitch_enable_locked(struct mlx5_eswitch *esw, int num_vfs)
 
 	return 0;
 
-err_esw_enable:
-	mlx5_esw_qos_cleanup(esw);
-err_qos_init:
+err_esw_init:
 	mlx5_eq_notifier_unregister(esw->dev, &esw->nb);
 	mlx5_esw_acls_ns_cleanup(esw);
 	return err;
@@ -1640,7 +1638,6 @@ void mlx5_eswitch_disable_locked(struct mlx5_eswitch *esw)
 
 	if (esw->mode == MLX5_ESWITCH_OFFLOADS)
 		devl_rate_nodes_destroy(devlink);
-	mlx5_esw_qos_cleanup(esw);
 }
 
 void mlx5_eswitch_disable(struct mlx5_eswitch *esw)
@@ -1884,6 +1881,11 @@ int mlx5_eswitch_init(struct mlx5_core_dev *dev)
 	if (err)
 		goto reps_err;
 
+	esw->mode = MLX5_ESWITCH_LEGACY;
+	err = mlx5_esw_qos_init(esw);
+	if (err)
+		goto reps_err;
+
 	mutex_init(&esw->offloads.encap_tbl_lock);
 	hash_init(esw->offloads.encap_tbl);
 	mutex_init(&esw->offloads.decap_tbl_lock);
@@ -1897,7 +1899,6 @@ int mlx5_eswitch_init(struct mlx5_core_dev *dev)
 	refcount_set(&esw->qos.refcnt, 0);
 
 	esw->enabled_vports = 0;
-	esw->mode = MLX5_ESWITCH_LEGACY;
 	esw->offloads.inline_mode = MLX5_INLINE_MODE_NONE;
 	if (MLX5_CAP_ESW_FLOWTABLE_FDB(dev, reformat) &&
 	    MLX5_CAP_ESW_FLOWTABLE_FDB(dev, decap))
@@ -1934,6 +1935,7 @@ void mlx5_eswitch_cleanup(struct mlx5_eswitch *esw)
 
 	esw_info(esw->dev, "cleanup\n");
 
+	mlx5_esw_qos_cleanup(esw);
 	destroy_workqueue(esw->work_queue);
 	WARN_ON(refcount_read(&esw->qos.refcnt));
 	mutex_destroy(&esw->state_lock);
-- 
2.44.0


