Return-Path: <netdev+bounces-94882-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0CD48C0EDA
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 13:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3820B220D2
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 11:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B46B1311BA;
	Thu,  9 May 2024 11:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IJ/1BSSz"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221761311BC
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 11:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715254299; cv=fail; b=UtDukflP4HS+v64RkOq9vmrbkd3Rh9Hk5IM9us0bEdfuK9lR0z+r2SpBy6LyQ7vLC821PVqe5ViH2reRoPKqasSIJLprxn+Yt/5iJGyUxTcqbsOxx+TK8QSfu7vs/xKRQBqX5uRrQoHCdqbqqkjWqm6eFA17Zu5DYZylH/Rg6xY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715254299; c=relaxed/simple;
	bh=UpqT9vV2gRAMrcoLvBDlSS5U1yp6aQofkhodpv7+PHM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LMp9xgbT5yjzpLwoLh+jd9uJINVfvTLvD0lTIesaelgvAKo6TeB6YhkmuR3kIpQE5WRnzGvo3FJIN6rrLZ86wtBCXEr1+LrI28PX9z1TCa938mqEsT/kFmf2komgV3o0CtXZ45OZp1bkhGZIgOjIY4JX/ROl3MoaXypGmQU9ZUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IJ/1BSSz; arc=fail smtp.client-ip=40.107.237.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J/8Rpqz0aJmfmcY4u/Qup0er/32c7aZ1sj39Rpgs43kVxmxWpnqJqMKZhFxC0nV34ZZQ9vBmnWa0z8tWCi0yeXz3YBGn0D6D5MEVsgLGRSufjS4DuxRejG/bsQEbredRatGDlkInrwJl5TU4YNVPoHACjVTve+pNOrg7otg2QYBUEN6zfml/xZ2DRXn+noKmywbGXs9GGwhQIE1zF6YLRwKzwwJabu8Zl/gfLF5MoosTwZ9ueEP+a18aMzd0CUT4NSm0THb2bqk4RnFT0Usz0ANuCy1YPLsl2jygmcUhUMECBvinUhQHVCHlmWURyGo/XbEtjLBdpUykVDVV6H1MtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=noMMNVCftQKYLIrLwGv7Yny8dZSDXz0o5ejBmleXBQQ=;
 b=hiU+BwODQEzCBlWWw+dZDK3EmvF4TdXwF2MxLiPKOf0gwKs1TErEp8vh5d+QEkvkVHKd7Ah+hkzxZXk55N/B30AIR5dJvd+LBJ9zonooI2MbqkYXU5RVMHegDFkCyCpeLs5ExmwmLpCP+2zSWw/BheV6TChbVIF7kxPjOA/85R0Qdvm5r8gSEb+dP+muAJyHaRCncuiJLSitomXhTBOQxqlUpQVRpvITVDUzMY3LmWPPJgThVuSiDw6GSXrX7BsCS59fDrcmHxubctu1xF9XRpIPf0Gwfj99pHis0y0jsUdrLGSlRagik77RZcZQxSEv+doGF/x+3EWOOVP0lBZNxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=noMMNVCftQKYLIrLwGv7Yny8dZSDXz0o5ejBmleXBQQ=;
 b=IJ/1BSSzEbUEAYd6zoeGzNyRWGGbdVIgrwBMHrS4IQdZGrH3BsAA2f4/nKazt5sqc5q0tA+GBChz+CDk7YZplgBd4AFQUovdcGcJthXiGPeAqMZTOYDHEJPQ4SxfbG4pTEIfCGzuLC7/VUbAZapSXB7P5KfVoMc8MH6SY+WUFGZdR13qW22zYI05FUFoV4ymraAK/Q+PrcUcDSuBxWEDDj5Qt9luEVKZGRTFgOHplvyKh06ggsqOijA6H/WGLk598jOxYeQjoRgvem21cgzWP1s62CLZTbAsPAhQnBqHI5ZTST8lSBKwPtBIp33jWh8Dle90PWtqZZXQSyKlFwvJQQ==
Received: from SA1P222CA0148.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c2::14)
 by MW4PR12MB7481.namprd12.prod.outlook.com (2603:10b6:303:212::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.47; Thu, 9 May
 2024 11:31:34 +0000
Received: from SA2PEPF00003AE8.namprd02.prod.outlook.com
 (2603:10b6:806:3c2:cafe::39) by SA1P222CA0148.outlook.office365.com
 (2603:10b6:806:3c2::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.43 via Frontend
 Transport; Thu, 9 May 2024 11:31:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00003AE8.mail.protection.outlook.com (10.167.248.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.18 via Frontend Transport; Thu, 9 May 2024 11:31:33 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 9 May 2024
 04:31:11 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 9 May 2024
 04:31:11 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Thu, 9 May
 2024 04:31:08 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Shay Drory
	<shayd@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net 2/5] net/mlx5: Fix peer devlink set for SF representor devlink port
Date: Thu, 9 May 2024 14:29:48 +0300
Message-ID: <20240509112951.590184-3-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240509112951.590184-1-tariqt@nvidia.com>
References: <20240509112951.590184-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE8:EE_|MW4PR12MB7481:EE_
X-MS-Office365-Filtering-Correlation-Id: 21a1f99b-7414-46ba-9aa3-08dc701b945c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|1800799015|376005|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BkNOi6eoHhTEkg+DlieuFbl7sngfeRZb5Tnolq3IrC6fPKBFK7pPGYqoZ2e2?=
 =?us-ascii?Q?ZbxGZSAZAyJ4Ylz4SSZOjrV8KRpz5ppOBLj8DK22WG43UCerKGxbH9bCpv3f?=
 =?us-ascii?Q?eKnbL0vfWwitRwmZF6aSmZK03A5sGikn5Sce/MP11GmYlGqB8C/dV0TBP1vJ?=
 =?us-ascii?Q?nWW/jmZ2/GgRKlX6Pzl/RYDNHfi2xMPBWmMsKlKvKrIWpM1eiP+f91bZ+oFy?=
 =?us-ascii?Q?8fmr9dk61mz/Sdw0zjjPGQqTiCrhjwdx1MZDZsAPsTCqlgOyKM/ijF6/doES?=
 =?us-ascii?Q?smso5DB7EvquRjb9WnVoUtD7tRnypJwJur2UiDL56OHMn4Miqfq6ZicOrZUo?=
 =?us-ascii?Q?5Rz1CukhZP6Yb26K6B2DHouIznHfi3o9BFtWZtAYxO2eAnvnwgnZgt7ksf93?=
 =?us-ascii?Q?RD52sXgxEjx1hrtoHWhn1HZHj+vM5XWtzeGn/EyWErtfi7DFgUvWQCzxCcKd?=
 =?us-ascii?Q?ckZ2br17wDswe3hEnDuM7sKnVA/Jm6hc/YeVi+l96iKFw5nxmtJPBIHCtoTN?=
 =?us-ascii?Q?6GdwKatV5GiELz27gox0K6tjDmCws8vZ/pT/svWDKB+F8Mq/r1MtFfI4wtNi?=
 =?us-ascii?Q?LV7ydEsUXdFZLHjYNXPjNXSETbBIMstVkj0GMjBBRz8IZhcaaOr/kRrKaZZz?=
 =?us-ascii?Q?s1ehKFbUSQu/Ug6mxYk/nlbkxJbQqlC3oLXM4e56QiTKxmrnBqcfLG4B4jh0?=
 =?us-ascii?Q?CMYVQR3MEXzZrQR5xVLz6s6ckJAH9Ed8GbyAKB4fZv0iADkQ8OyyC+6+Z452?=
 =?us-ascii?Q?N+iErf4+IsR6J47ueWO5apWGUOB2B9j+4kLm2n9rvtyISYhlKTVe4X9sq8M9?=
 =?us-ascii?Q?blMSSrfRv2APu98yoVx5CoGd7/dlZxkxIXPCN0WwxybdT4d2W/0ElAv+3dc2?=
 =?us-ascii?Q?aT1KtlfjCgRaFaN4gBdSSn9njbvcFAn97o97h+t1JHIJvgnq3m9l15/CPEUQ?=
 =?us-ascii?Q?3nQnCEYIWCq+H1Vp2wk0MiWWsTZr482LU9FTD8MJBMJJ4mVbSp3lC2Z/a9BV?=
 =?us-ascii?Q?18nP4AQDj69RGAAocFJfdqpxGWymDIOGqbkEk9sgfGeFPOV6GZNy+JhvI3lz?=
 =?us-ascii?Q?Sqs+81n3O7/3tJPkX7Bdr56OliOTwSnCLkQWQyAjYUIBkKXQ6sA+evWXrneM?=
 =?us-ascii?Q?0+JmNW+fGt49wNuzLCwabehlEfl8P+4cSa7TQuTu1f5XlA3sz+9/Wq6F2ior?=
 =?us-ascii?Q?VqEvojwmdSuYppSE4nlSlBdDd+VK8+nL0smb9IRKZvFP87REKYa7jvI3nbb4?=
 =?us-ascii?Q?j6zJ2+VAuKse/uUfWMYP6ZeuDY3tXf4HVID7NsEfIiPIWhVvzDaZozDoMq9u?=
 =?us-ascii?Q?j9WdWECyCa7CRtN63qYu+DMg1Ea/OVuW8nSGRawJxvWCWLj1Qx6LsD8q66vH?=
 =?us-ascii?Q?UpE7J/sLoOo0Jo6xch2ZRNGHUG06?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(1800799015)(376005)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 11:31:33.3886
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21a1f99b-7414-46ba-9aa3-08dc701b945c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7481

From: Shay Drory <shayd@nvidia.com>

The cited patch change register devlink flow, and neglect to reflect
the changes for peer devlink set logic. Peer devlink set is
triggering a call trace if done after devl_register.[1]

Hence, align peer devlink set logic with register devlink flow.

[1]
WARNING: CPU: 4 PID: 3394 at net/devlink/core.c:155 devlink_rel_nested_in_add+0x177/0x180
CPU: 4 PID: 3394 Comm: kworker/u40:1 Not tainted 6.9.0-rc4_for_linust_min_debug_2024_04_16_14_08 #1
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
Workqueue: mlx5_vhca_event0 mlx5_vhca_state_work_handler [mlx5_core]
RIP: 0010:devlink_rel_nested_in_add+0x177/0x180
Call Trace:
 <TASK>
 ? __warn+0x78/0x120
 ? devlink_rel_nested_in_add+0x177/0x180
 ? report_bug+0x16d/0x180
 ? handle_bug+0x3c/0x60
 ? exc_invalid_op+0x14/0x70
 ? asm_exc_invalid_op+0x16/0x20
 ? devlink_port_init+0x30/0x30
 ? devlink_port_type_clear+0x50/0x50
 ? devlink_rel_nested_in_add+0x177/0x180
 ? devlink_rel_nested_in_add+0xdd/0x180
 mlx5_sf_mdev_event+0x74/0xb0 [mlx5_core]
 notifier_call_chain+0x35/0xb0
 blocking_notifier_call_chain+0x3d/0x60
 mlx5_blocking_notifier_call_chain+0x22/0x30 [mlx5_core]
 mlx5_sf_dev_probe+0x185/0x3e0 [mlx5_core]
 auxiliary_bus_probe+0x38/0x80
 ? driver_sysfs_add+0x51/0x80
 really_probe+0xc5/0x3a0
 ? driver_probe_device+0x90/0x90
 __driver_probe_device+0x80/0x160
 driver_probe_device+0x1e/0x90
 __device_attach_driver+0x7d/0x100
 bus_for_each_drv+0x80/0xd0
 __device_attach+0xbc/0x1f0
 bus_probe_device+0x86/0xa0
 device_add+0x64f/0x860
 __auxiliary_device_add+0x3b/0xa0
 mlx5_sf_dev_add+0x139/0x330 [mlx5_core]
 mlx5_sf_dev_state_change_handler+0x1e4/0x250 [mlx5_core]
 notifier_call_chain+0x35/0xb0
 blocking_notifier_call_chain+0x3d/0x60
 mlx5_vhca_state_work_handler+0x151/0x200 [mlx5_core]
 process_one_work+0x13f/0x2e0
 worker_thread+0x2bd/0x3c0
 ? rescuer_thread+0x410/0x410
 kthread+0xc4/0xf0
 ? kthread_complete_and_exit+0x20/0x20
 ret_from_fork+0x2d/0x50
 ? kthread_complete_and_exit+0x20/0x20
 ret_from_fork_asm+0x11/0x20
 </TASK>

Fixes: bf729988303a ("net/mlx5: Restore mistakenly dropped parts in register devlink flow")
Fixes: c6e77aa9dd82 ("net/mlx5: Register devlink first under devlink lock")
Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/main.c    | 14 +++++---------
 .../mellanox/mlx5/core/sf/dev/driver.c        | 19 ++++++++-----------
 2 files changed, 13 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index 331ce47f51a1..6574c145dc1e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -1680,6 +1680,8 @@ int mlx5_init_one_light(struct mlx5_core_dev *dev)
 	struct devlink *devlink = priv_to_devlink(dev);
 	int err;
 
+	devl_lock(devlink);
+	devl_register(devlink);
 	dev->state = MLX5_DEVICE_STATE_UP;
 	err = mlx5_function_enable(dev, true, mlx5_tout_ms(dev, FW_PRE_INIT_TIMEOUT));
 	if (err) {
@@ -1693,27 +1695,21 @@ int mlx5_init_one_light(struct mlx5_core_dev *dev)
 		goto query_hca_caps_err;
 	}
 
-	devl_lock(devlink);
-	devl_register(devlink);
-
 	err = mlx5_devlink_params_register(priv_to_devlink(dev));
 	if (err) {
 		mlx5_core_warn(dev, "mlx5_devlink_param_reg err = %d\n", err);
-		goto params_reg_err;
+		goto query_hca_caps_err;
 	}
 
 	devl_unlock(devlink);
 	return 0;
 
-params_reg_err:
-	devl_unregister(devlink);
-	devl_unlock(devlink);
 query_hca_caps_err:
-	devl_unregister(devlink);
-	devl_unlock(devlink);
 	mlx5_function_disable(dev, true);
 out:
 	dev->state = MLX5_DEVICE_STATE_INTERNAL_ERROR;
+	devl_unregister(devlink);
+	devl_unlock(devlink);
 	return err;
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/driver.c b/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/driver.c
index 7ebe71280827..b2986175d9af 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/driver.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/sf/dev/driver.c
@@ -60,6 +60,13 @@ static int mlx5_sf_dev_probe(struct auxiliary_device *adev, const struct auxilia
 		goto remap_err;
 	}
 
+	/* Peer devlink logic expects to work on unregistered devlink instance. */
+	err = mlx5_core_peer_devlink_set(sf_dev, devlink);
+	if (err) {
+		mlx5_core_warn(mdev, "mlx5_core_peer_devlink_set err=%d\n", err);
+		goto peer_devlink_set_err;
+	}
+
 	if (MLX5_ESWITCH_MANAGER(sf_dev->parent_mdev))
 		err = mlx5_init_one_light(mdev);
 	else
@@ -69,20 +76,10 @@ static int mlx5_sf_dev_probe(struct auxiliary_device *adev, const struct auxilia
 		goto init_one_err;
 	}
 
-	err = mlx5_core_peer_devlink_set(sf_dev, devlink);
-	if (err) {
-		mlx5_core_warn(mdev, "mlx5_core_peer_devlink_set err=%d\n", err);
-		goto peer_devlink_set_err;
-	}
-
 	return 0;
 
-peer_devlink_set_err:
-	if (mlx5_dev_is_lightweight(sf_dev->mdev))
-		mlx5_uninit_one_light(sf_dev->mdev);
-	else
-		mlx5_uninit_one(sf_dev->mdev);
 init_one_err:
+peer_devlink_set_err:
 	iounmap(mdev->iseg);
 remap_err:
 	mlx5_mdev_uninit(mdev);
-- 
2.31.1


