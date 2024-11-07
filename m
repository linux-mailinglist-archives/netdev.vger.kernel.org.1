Return-Path: <netdev+bounces-143032-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19BB39C0F35
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 20:45:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CD901F23F4C
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 19:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C7E4217F37;
	Thu,  7 Nov 2024 19:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Nd2FDUop"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974651822E5
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 19:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731008721; cv=fail; b=ZP6pJRuEdaeRjFz9thzzJxoR8xXdU3aFSV0R78kIcsiZGaIJ4VDtpWIoNPOcCscyierZeL7m8/asXwc/sElpwwQjx1TpbWJisKe2PVLeX89NTGauf4CqjZxKL+zMIrhxEtyWtaI1KC9/BNpO8WjmIdn96hReBwRcO3xB3jDRLiU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731008721; c=relaxed/simple;
	bh=DdelfkmubBJEmNATz3+Nj978FzIbYvMVd30hmw4Ot3w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mTqwIbvPQacovShQIb/u0k6QfuuX5IKV2x+eFsfQNN+BXCDus7iYjd6l4xh9uX64cwZ1nQYazCosZB5yRVCtHG2Oyne95K6JXFbhTxE0Z2qQUUsDaAth9tyKpokoA8mtiMtRFlzp2R17241tVLJO8OR5HK9Sylu2Tl393auZe6Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Nd2FDUop; arc=fail smtp.client-ip=40.107.243.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b+TKSKyUndAxMFoyi9DUEi8d5joWOVQGxqxKV3Yqrq6gq9ZUNY6AFOG5iBTI18nrWMVKBY42O4dcIB7atz4G4T3AGEFhya3Dusy1b8KhTMmFx+OkjV6Hfurox37/0RO/VVTV7zfu8xLuUr6v3z8n6+0WjulNHLxW1xhrpuqL9RtCewS5wT3w6+PIZ3Ii2VP/V2te9J0tCwwWdwLg5leN47Z/oHxH8wCY+5rk0GqCeKC93akHlDwv80wHLRjgbeAGXOooiPHLC69Rz7+Z8IY+MPmKItO+gwTH7mowg+Gsjlnb2beLBoYmyGtj8YeamWDccjV39vEvfX/IKEMmLhcBGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6UeVmXYoBmhIBNMH0TB4hFAoyV4oon7vS+c9jvkxuDI=;
 b=Fr0qEhyEbP3zqwiQ0lJm9HDNU+RAmGx168EwVnPsryC/HK0pnmQceYFA09cUCt5Jqt+tlVl4+yfFFWG6jQpTfJW76OgLjwJ6EXV6mj5sh+xe1x50RLIiYEbyMUqgDkNXvu8TGvfMhPs4xI3J9evlKCZ2TsdhhFQ26FzMcGSb5SVE74KLzUajNkgc42CniZlwQ+4sV0QX3eIXx5eakx5mouR5PApnNO/hl6j9JHJ+Teq+S9pQqYGsz+qQ5j/oWHxkJWTCrQ0RIEYsrvNKcSBmODM8Gsaf41V0sYOrZimGFDn1sdqZApU4mDQAYWgpCsspNdW0kWD3MnP6zEffxZi/vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6UeVmXYoBmhIBNMH0TB4hFAoyV4oon7vS+c9jvkxuDI=;
 b=Nd2FDUop6UOgdyALu8SN7AmNEVXgqI/+3uFHv9kRpQcpIHFG+hOBIa1Mu7KgpU4aqonEYdUFl1AxhGtKKggCYvPcbFQVi0VkOO3djeVFyn/3y81IwEipuqBo2Ym+W86o/V1yRWJ7j/qyUC/cbBR5iFmz9hP7K81AfiVg3r1pp5aHYw3HEZMUA22FZsUfrKNh22U7osPLc2RykJcylpKR49nSnR3e99LXjEtbXfM3odn4Jero3KzvOdUcvvIZPMLK8PpVMw0qlQiwE2BVa/frKR/7FFdzZBtbuB7CUkgvZKLiX0fup+VS3ZOt8ANtFaqNyjx3f/8kfY0XXG2Oh6FZBA==
Received: from MW4P222CA0005.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::10)
 by DS0PR12MB8575.namprd12.prod.outlook.com (2603:10b6:8:164::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.29; Thu, 7 Nov
 2024 19:45:13 +0000
Received: from SJ5PEPF000001ED.namprd05.prod.outlook.com
 (2603:10b6:303:114:cafe::36) by MW4P222CA0005.outlook.office365.com
 (2603:10b6:303:114::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19 via Frontend
 Transport; Thu, 7 Nov 2024 19:45:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001ED.mail.protection.outlook.com (10.167.242.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.17 via Frontend Transport; Thu, 7 Nov 2024 19:45:12 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 7 Nov 2024
 11:44:57 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 7 Nov 2024
 11:44:57 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Thu, 7 Nov
 2024 11:44:54 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Patrisious Haddad
	<phaddad@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net-next 01/12] net/mlx5: E-switch, refactor eswitch mode change
Date: Thu, 7 Nov 2024 21:43:46 +0200
Message-ID: <20241107194357.683732-2-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241107194357.683732-1-tariqt@nvidia.com>
References: <20241107194357.683732-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001ED:EE_|DS0PR12MB8575:EE_
X-MS-Office365-Filtering-Correlation-Id: ec065232-509e-4975-eabb-08dcff64b1f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Qf1XXRC/bXc6VvSdkiofMkkPx1IVj1CQGp3ikvsDSQF4PFx5KhjyP4wYXln3?=
 =?us-ascii?Q?Dx6DD8IJ767coawb8eLGyxtfbm/Kt1GdwA/EHhT4Rm6w0ShibMDgIdRbHSe7?=
 =?us-ascii?Q?U+1WT2FPF7ibH8I9KTRNya3wEpT3L/oEoCnHeNKrQGa4bUIKlftqNQiBLhkJ?=
 =?us-ascii?Q?7+uNvYGXXPNd+R4H0wZyiJ6gl1CDyUDdPnuXL2iy+9aa/kc7SvU9SxnpV+8X?=
 =?us-ascii?Q?DlpUDI6TIKS/FNn60dCk2xRk635g0jQRmLXk9ePbSuFKktqtzjpuOu5e6wjD?=
 =?us-ascii?Q?KTs0Y4qY1bvAIUkGhnREGiL4J0Do6AmOBDfBbIVoD5GbvV5JZCWzE6adUgg2?=
 =?us-ascii?Q?FzVHaaQVMju/pUupZCeROms4SStzUwcZsXb3Q9Qo96lDwYAx1GuXh98bHREx?=
 =?us-ascii?Q?3JZo3MJ37vAd+s5bpOGZVvp2srwzN7/8GxUct0s2G1YO6jWcL3+XKNfennlS?=
 =?us-ascii?Q?iCU8uK/9hmxLQQzRseMoGUfNQbRGfXDxavVpQIs+AAt3Li/+4/ybqYws3cQJ?=
 =?us-ascii?Q?I9mwDBJ4jWS6PgiXKAkM8K5YNPSJ2qWhmGsGe17T6Nhyt52fMRu12bfxmYRQ?=
 =?us-ascii?Q?92caKticoTAtlUKhowbiWeIASixO36MqnCld4HFhDcHLhc6B/kpvxf+anb69?=
 =?us-ascii?Q?efo7t7h2OQIVE/knshTZBBRWOFCcno6tehIfdhHP08Yt3RhncfFVWqR314h+?=
 =?us-ascii?Q?udzR9HtjW+fR6zIz5qJ54RJvW7xnzHyzfiV+PjujAyAyjTIqqsclu8gOe5JU?=
 =?us-ascii?Q?qyCqXiZmSUXpi1Nbnee2RDKHqeRHCmn6nQeCAMLTDO0ncz0XUFqsZtOP1pn3?=
 =?us-ascii?Q?Q24kK9t4ozCw/ANkWBgBi6seTgyceAgNX1YPeH8qbqUh6ejZ4zG/LYsqGivG?=
 =?us-ascii?Q?4O7GspQLPvlsP8hE3xyLHOoxTgPq4YWq5lNm7vg1ju6hyc06/HJD7dqDE64N?=
 =?us-ascii?Q?lZ3UUWd76TU6fq3K8hIGs9NeMVJgthIENOztXMK9l/gMbTstEzVJGSTIioKL?=
 =?us-ascii?Q?LKtGC4Ii9f6WHbgaFC+az3oXSxC7gV/jPB9cqGstoJHtBGdHvMi/JpuxJpD5?=
 =?us-ascii?Q?M59/T/FKwULHYEjNE7xTc3t7guI7k8zB6F6WmLXyRVaL6Nsc+dHVgS5aPc8k?=
 =?us-ascii?Q?EaIDq+ES6+CG7N1Po/R4fcUL2K9E5WbWyotOsCj8TTOmqMmHCxRUCgGYlTWj?=
 =?us-ascii?Q?7DbApEhU6Ebodyfd+KbkcadWtyBgyKxPwhpUtPBtfLnyrR3l6NoaXL//4GU4?=
 =?us-ascii?Q?dRpcYVOLkVcRaTVXwukO5hMYsaGLrKND8qRZJRNMW05HsTcBCe1a2k68ivWF?=
 =?us-ascii?Q?eoXvMEPvNUyA5P3/G4ZPVh2SXbhCXmFCuoKgtzAGh/sWljnRWf0XeWRthKt4?=
 =?us-ascii?Q?kFd9cihvddKpo2XThnvPLW/CHOc1TwapbLVG03yBVi8i4iJs7A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 19:45:12.5817
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec065232-509e-4975-eabb-08dcff64b1f2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8575

From: Patrisious Haddad <phaddad@nvidia.com>

The E-switch mode was previously updated before removing and re-adding the
IB device, which could cause a temporary mismatch between the E-switch mode
and the IB device configuration.

To prevent this discrepancy, the IB device is now removed first, then
the E-switch mode is updated, and finally, the IB device is re-added.
This sequence ensures consistent alignment between the E-switch mode and
the IB device whenever the mode changes, regardless of the new mode value.

Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/eswitch.c |  1 -
 .../mellanox/mlx5/core/eswitch_offloads.c     | 26 +++++++++++++++----
 2 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
index cead41ddbc38..d0dab8f4e1a3 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
@@ -1490,7 +1490,6 @@ int mlx5_eswitch_enable_locked(struct mlx5_eswitch *esw, int num_vfs)
 	if (esw->mode == MLX5_ESWITCH_LEGACY) {
 		err = esw_legacy_enable(esw);
 	} else {
-		mlx5_rescan_drivers(esw->dev);
 		err = esw_offloads_enable(esw);
 	}
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index fd34f43d18d5..5f1adebd9669 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -2332,18 +2332,35 @@ static int esw_create_restore_table(struct mlx5_eswitch *esw)
 	return err;
 }
 
+static void esw_mode_change(struct mlx5_eswitch *esw, u16 mode)
+{
+	mlx5_devcom_comp_lock(esw->dev->priv.hca_devcom_comp);
+
+	if (esw->dev->priv.flags & MLX5_PRIV_FLAGS_DISABLE_IB_ADEV) {
+		esw->mode = mode;
+		mlx5_devcom_comp_unlock(esw->dev->priv.hca_devcom_comp);
+		return;
+	}
+
+	esw->dev->priv.flags |= MLX5_PRIV_FLAGS_DISABLE_IB_ADEV;
+	mlx5_rescan_drivers_locked(esw->dev);
+	esw->mode = mode;
+	esw->dev->priv.flags &= ~MLX5_PRIV_FLAGS_DISABLE_IB_ADEV;
+	mlx5_rescan_drivers_locked(esw->dev);
+	mlx5_devcom_comp_unlock(esw->dev->priv.hca_devcom_comp);
+}
+
 static int esw_offloads_start(struct mlx5_eswitch *esw,
 			      struct netlink_ext_ack *extack)
 {
 	int err;
 
-	esw->mode = MLX5_ESWITCH_OFFLOADS;
+	esw_mode_change(esw, MLX5_ESWITCH_OFFLOADS);
 	err = mlx5_eswitch_enable_locked(esw, esw->dev->priv.sriov.num_vfs);
 	if (err) {
 		NL_SET_ERR_MSG_MOD(extack,
 				   "Failed setting eswitch to offloads");
-		esw->mode = MLX5_ESWITCH_LEGACY;
-		mlx5_rescan_drivers(esw->dev);
+		esw_mode_change(esw, MLX5_ESWITCH_LEGACY);
 		return err;
 	}
 	if (esw->offloads.inline_mode == MLX5_INLINE_MODE_NONE) {
@@ -3584,7 +3601,7 @@ static int esw_offloads_stop(struct mlx5_eswitch *esw,
 {
 	int err;
 
-	esw->mode = MLX5_ESWITCH_LEGACY;
+	esw_mode_change(esw, MLX5_ESWITCH_LEGACY);
 
 	/* If changing from switchdev to legacy mode without sriov enabled,
 	 * no need to create legacy fdb.
@@ -3770,7 +3787,6 @@ int mlx5_devlink_eswitch_mode_set(struct devlink *devlink, u16 mode,
 		err = esw_offloads_start(esw, extack);
 	} else if (mode == DEVLINK_ESWITCH_MODE_LEGACY) {
 		err = esw_offloads_stop(esw, extack);
-		mlx5_rescan_drivers(esw->dev);
 	} else {
 		err = -EINVAL;
 	}
-- 
2.44.0


