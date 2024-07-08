Return-Path: <netdev+bounces-109766-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 284F1929DE4
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 10:02:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5F5F1F21C4F
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 08:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE573BB50;
	Mon,  8 Jul 2024 08:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LxYlhQYP"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2071.outbound.protection.outlook.com [40.107.236.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02A9B2F2E
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 08:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720425737; cv=fail; b=gIUm5UNGgpLPg9EPtNpjtT9f+bcIa3WQ4uRFFhQnGudU/yw4G1+St4FSh8+SDDj6z67iJ9kDYvI5zAVdH+woc9hfy3bYfKeGCODFVgFCAPpi6ioL2LkzZeT4bMnlQnOihNWZC8QAv/xqp2e9MkN/+tNv/J1UGYOa2uAaaFAxJsI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720425737; c=relaxed/simple;
	bh=NAg7blGlM+IidWttZZ/NTJcgPctLv9P18VuBvtEv70s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h182Ee5MZ9cygNIn+MYS2wNvfE9Lj7XH2KI86Oi6+REirNYwSfcadrNK2Zxkl//lgLjrvRKqlGzNTjZvMJtI+WtVotwX0QviDqE58NdTIE32feNmexMNudeIRb5yV5F6X+zKabzURbq8wRmdPmQFYS7uf02Zw7Yi3fEbtSY5E6A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LxYlhQYP; arc=fail smtp.client-ip=40.107.236.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HgzGbUS7kRgu7w3bsQSjgnUd27600fwmSCpNIPVgPGR6s0IBcTGIxB++l/BrDRszjkwLiZwIyUcVi7fuKUAbmHBSUXaDxvIfKmZPrJUabjJflDtJHaSpjwhMDgXhDbO/S9ao9yK44QZ9eZ7TF0eaQuqWeRSUF+DR6ugVLRvQmOM2zkEcELtF0xVJy+QGjijFmSmXdm/hdMwD4vik5GblZkxT9reGbMJwoo9h3LdZCU/56m9sphz5GeLo7idZYEB816SdGq12glikXRfyMBXLrT4CskZY766t4tSDlvL7mqEbtHKXKK0C9IGCMJhmg2XKvISiLmEndxim4Mjw3IvGng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1t6st82wRO0osuqWhjejfcvfk0VJ+4vdfP2KwEkD7Ts=;
 b=F/9PQUuHYZL7Y7HB8ctEnjTe+2XTzFIgjAEstSMs8BrD68HS0qouupg/bC3upuwXnOPiAc+NurLT/T+4QFi+MI1OrZUQI2HD4/85BbrYJuiEpEd6tSSGFl7fT5E2y2ib0r8GDIMMqbvKzf7yu0mHrZ45dXNdS950OeorSuzQsq0F3JFaZXGLZzDhbuwmnVAf5sMndXFljiUKcnMPEVTGH2HJlGLGX6BBcmdpKnXqhvMwjGHSHNBrRSqW9WUIcKV61bEAykfjpbNBPLzPNIAwlKZ5U5xqjWZJumplDfj9G2SZz1dhyAOiXkXwlLisq0OxxWllAs++rg2xkuz5FDf70g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1t6st82wRO0osuqWhjejfcvfk0VJ+4vdfP2KwEkD7Ts=;
 b=LxYlhQYP3/ysNVCaN9Ff3QHxMbkqvXlmq/tnMuZcSYYHADsC/3//A7R3kENqWYKiZScvzmOe26EoIEBFjWjts/35cKR68+EhzZ4yT330eYPk9+jcziEBKjRs/WdaRwwkAOla3gNB42C0jkZnMfF168r4p0aLgI0Uki8jjDlz7FEpaUjjtdDiVXZlKZ2BBrBwZeeBdFpP+gRMe30zaP/WFsXIle39xRVqnrcK21yRDsq6+NtUet+MtqfUL3pmfTr9plyjRP/0dvilZwQWTcORbpSX/egGnBlIB+OUA7tmg8+KJ9M7Su+O7PQc8Jek2yLME9U/RSKkjSvAhGx3ZRnPvQ==
Received: from BL0PR1501CA0017.namprd15.prod.outlook.com
 (2603:10b6:207:17::30) by MN0PR12MB6104.namprd12.prod.outlook.com
 (2603:10b6:208:3c8::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Mon, 8 Jul
 2024 08:02:07 +0000
Received: from BL6PEPF00020E61.namprd04.prod.outlook.com
 (2603:10b6:207:17:cafe::1c) by BL0PR1501CA0017.outlook.office365.com
 (2603:10b6:207:17::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35 via Frontend
 Transport; Mon, 8 Jul 2024 08:02:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00020E61.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.17 via Frontend Transport; Mon, 8 Jul 2024 08:02:07 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 8 Jul 2024
 01:01:48 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 8 Jul 2024
 01:01:48 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Mon, 8 Jul
 2024 01:01:45 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Rahul Rameshbabu
	<rrameshbabu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next V2 05/10] net/mlx5: Add support for MTPTM and MTCTR registers
Date: Mon, 8 Jul 2024 11:00:20 +0300
Message-ID: <20240708080025.1593555-6-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240708080025.1593555-1-tariqt@nvidia.com>
References: <20240708080025.1593555-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E61:EE_|MN0PR12MB6104:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f06130b-2d8d-40e5-00e6-08dc9f24435f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?H/xljWQvdv0ArTzlXDMfNMypONmYxgklZMKDYMrL+D/P6lfNItU6lcNtShLg?=
 =?us-ascii?Q?Rjr9IwxCP7h3SWctmVTVkwyoGflDrOQZDPP1ui3cIKr5ldfSNdoOHY+P1bi0?=
 =?us-ascii?Q?0XhZfCOC+Ss7kNMRsA//L1z5Ndk361TIV8VKKmkBl/0JHC0ALRiIbIYZb9T6?=
 =?us-ascii?Q?D7H1MWJP2XWUYkXiB1+RLrVK2i26kUVq3uBLX2XeQgG/ki5CAXXBo0ABYKtP?=
 =?us-ascii?Q?IaJj/CQqv3fZUujFIU1OYtGb4Ua0hHRXT0F+nmC6r2B4Z32iMVK8W/jCZLqe?=
 =?us-ascii?Q?EpzKhG3rKMAYSnGs/WbtGPfShVixeaFGlQf1TWTn8RDFssBp0/wTsht9yKN5?=
 =?us-ascii?Q?x85Cj+LP7AX5zxREhnOE51uS0XExKT1FEu+eHkberbSkYaCEtLyRk2mb+bSM?=
 =?us-ascii?Q?bykwiuxMZYxamBPgokLgD5JQS/cJDEJCn3d17/M+gVnT8TKs4pCQHee2Vw/H?=
 =?us-ascii?Q?IO70QlQNnbFG8wX7jZLwMdI/SI1F/3A2MKaqvhiiHmiC+KyBmhFwMbEn6/NN?=
 =?us-ascii?Q?aE7wYjHvPAmlmm0GKcvu7CAfFuF8YshYJRJJbR3CEsu45Zh4zlFu960XDQR+?=
 =?us-ascii?Q?SFifVtzhY0nvfWpY8LwKOooTOV9NvXswbEDeKjrJCfp6o5ThOy7RaJVx4IUq?=
 =?us-ascii?Q?Avctb9ozWAAOUY268ukfWZdmcYy5nBvS4DYqHhBaPLeOGx6PPtnx7oyPuXbk?=
 =?us-ascii?Q?jyJ7kb5c6jTZXtrk6yek9RT0V0rlck/uZL1b2FdErYBKX6xbHZmLXWY/2kuw?=
 =?us-ascii?Q?Ti1Zh1qxfGaCfK0lOlznAMnbNI9khTIoLYbBQDQ07mEQ7rLR7Q7O65oBqDEO?=
 =?us-ascii?Q?4m8trN1SbXwGCOmFOvCDG6W3/C+zUm1s+ESYK7OyvK60n4PffFH8w+hxXQxm?=
 =?us-ascii?Q?iLDPk4XK37kcIhOoWFGfe2XSQhgvWyVEKRBIDAD6uljsFPHhjCWvIXZk9b8y?=
 =?us-ascii?Q?eBiMYjZrm3E36AhpgMDlIWtaEKyBBp5ySv/nVoi2XmVY3pur/+ZD4g8Tf/Tk?=
 =?us-ascii?Q?jbCP8mHfSDqRs+RhY3bygCJW49yO70mdEnZIkKRJQoQoO+7kWMdpALCNjwjy?=
 =?us-ascii?Q?hyNBqlnsINEsIJxUltdHhANRLhGVhlhbfu3+NQ927DeViUJvk+0peYeMFChp?=
 =?us-ascii?Q?v0Tf6so5zEXSk9UThLY7PdqpvhIsHc9IN/hZ865gQoqVvT3l0/ZVJc0bT4xH?=
 =?us-ascii?Q?SgiMw6NPEHPc7m48BeEqgavOVtV28cRA/bc4A8lbwUHjmqqWmfihN8LSINco?=
 =?us-ascii?Q?4Urcp1groeaImsgdcsQbZV9wc5GeYNmQo1QPPXQxR4VgBATCLmtCwW3+6coM?=
 =?us-ascii?Q?JuHBvSCqVOtqRWOv7hAD5Fdv2IWPN+q0fGeVfyTyg/GKZYS4qbcd/gzoNQNx?=
 =?us-ascii?Q?1lEJjXkp2xHeeXp9A59exro0UH30cGI3ujSpmsB3rrrdAJicpI32kPDRJs5U?=
 =?us-ascii?Q?37uchv6fGfcWypFYWJZT+I3PP3MuDEip?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 08:02:07.5675
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f06130b-2d8d-40e5-00e6-08dc9f24435f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6104

From: Rahul Rameshbabu <rrameshbabu@nvidia.com>

Make Management Precision Time Measurement (MTPTM) register and Management
Cross Timestamp (MTCTR) register usable in mlx5 driver.

Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/fw.c |  1 +
 include/linux/mlx5/device.h                  |  7 +++-
 include/linux/mlx5/driver.h                  |  2 +
 include/linux/mlx5/mlx5_ifc.h                | 43 ++++++++++++++++++++
 4 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fw.c b/drivers/net/ethernet/mellanox/mlx5/core/fw.c
index b61b7d966114..76ad46bf477d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fw.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fw.c
@@ -224,6 +224,7 @@ int mlx5_query_hca_caps(struct mlx5_core_dev *dev)
 	if (MLX5_CAP_GEN(dev, mcam_reg)) {
 		mlx5_get_mcam_access_reg_group(dev, MLX5_MCAM_REGS_FIRST_128);
 		mlx5_get_mcam_access_reg_group(dev, MLX5_MCAM_REGS_0x9100_0x917F);
+		mlx5_get_mcam_access_reg_group(dev, MLX5_MCAM_REGS_0x9180_0x91FF);
 	}
 
 	if (MLX5_CAP_GEN(dev, qcam_reg))
diff --git a/include/linux/mlx5/device.h b/include/linux/mlx5/device.h
index da09bfaa7b81..76ce76f13e5e 100644
--- a/include/linux/mlx5/device.h
+++ b/include/linux/mlx5/device.h
@@ -1243,7 +1243,8 @@ enum mlx5_pcam_feature_groups {
 enum mlx5_mcam_reg_groups {
 	MLX5_MCAM_REGS_FIRST_128                    = 0x0,
 	MLX5_MCAM_REGS_0x9100_0x917F                = 0x2,
-	MLX5_MCAM_REGS_NUM                          = 0x3,
+	MLX5_MCAM_REGS_0x9180_0x91FF                = 0x3,
+	MLX5_MCAM_REGS_NUM                          = 0x4,
 };
 
 enum mlx5_mcam_feature_groups {
@@ -1392,6 +1393,10 @@ enum mlx5_qcam_feature_groups {
 	MLX5_GET(mcam_reg, (mdev)->caps.mcam[MLX5_MCAM_REGS_0x9100_0x917F], \
 		 mng_access_reg_cap_mask.access_regs2.reg)
 
+#define MLX5_CAP_MCAM_REG3(mdev, reg) \
+	MLX5_GET(mcam_reg, (mdev)->caps.mcam[MLX5_MCAM_REGS_0x9180_0x91FF], \
+		 mng_access_reg_cap_mask.access_regs3.reg)
+
 #define MLX5_CAP_MCAM_FEATURE(mdev, fld) \
 	MLX5_GET(mcam_reg, (mdev)->caps.mcam, mng_feature_cap_mask.enhanced_features.fld)
 
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index 779cfdf2e9d6..4c95bcfb76ca 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -159,6 +159,8 @@ enum {
 	MLX5_REG_MSECQ		 = 0x9155,
 	MLX5_REG_MSEES		 = 0x9156,
 	MLX5_REG_MIRC		 = 0x9162,
+	MLX5_REG_MTPTM		 = 0x9180,
+	MLX5_REG_MTCTR		 = 0x9181,
 	MLX5_REG_SBCAM		 = 0xB01F,
 	MLX5_REG_RESOURCE_DUMP   = 0xC000,
 	MLX5_REG_DTOR            = 0xC00E,
diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index 360d42f041b0..0726022a2ecd 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -10350,6 +10350,18 @@ struct mlx5_ifc_mcam_access_reg_bits2 {
 	u8         regs_31_to_0[0x20];
 };
 
+struct mlx5_ifc_mcam_access_reg_bits3 {
+	u8         regs_127_to_96[0x20];
+
+	u8         regs_95_to_64[0x20];
+
+	u8         regs_63_to_32[0x20];
+
+	u8         regs_31_to_2[0x1e];
+	u8         mtctr[0x1];
+	u8         mtptm[0x1];
+};
+
 struct mlx5_ifc_mcam_reg_bits {
 	u8         reserved_at_0[0x8];
 	u8         feature_group[0x8];
@@ -10362,6 +10374,7 @@ struct mlx5_ifc_mcam_reg_bits {
 		struct mlx5_ifc_mcam_access_reg_bits access_regs;
 		struct mlx5_ifc_mcam_access_reg_bits1 access_regs1;
 		struct mlx5_ifc_mcam_access_reg_bits2 access_regs2;
+		struct mlx5_ifc_mcam_access_reg_bits3 access_regs3;
 		u8         reserved_at_0[0x80];
 	} mng_access_reg_cap_mask;
 
@@ -11115,6 +11128,34 @@ struct mlx5_ifc_mtmp_reg_bits {
 	u8         sensor_name_lo[0x20];
 };
 
+struct mlx5_ifc_mtptm_reg_bits {
+	u8         reserved_at_0[0x10];
+	u8         psta[0x1];
+	u8         reserved_at_11[0xf];
+
+	u8         reserved_at_20[0x60];
+};
+
+enum {
+	MLX5_MTCTR_REQUEST_NOP = 0x0,
+	MLX5_MTCTR_REQUEST_PTM_ROOT_CLOCK = 0x1,
+	MLX5_MTCTR_REQUEST_FREE_RUNNING_COUNTER = 0x2,
+	MLX5_MTCTR_REQUEST_REAL_TIME_CLOCK = 0x3,
+};
+
+struct mlx5_ifc_mtctr_reg_bits {
+	u8         first_clock_timestamp_request[0x8];
+	u8         second_clock_timestamp_request[0x8];
+	u8         reserved_at_10[0x10];
+
+	u8         first_clock_valid[0x1];
+	u8         second_clock_valid[0x1];
+	u8         reserved_at_22[0x1e];
+
+	u8         first_clock_timestamp[0x40];
+	u8         second_clock_timestamp[0x40];
+};
+
 union mlx5_ifc_ports_control_registers_document_bits {
 	struct mlx5_ifc_bufferx_reg_bits bufferx_reg;
 	struct mlx5_ifc_eth_2819_cntrs_grp_data_layout_bits eth_2819_cntrs_grp_data_layout;
@@ -11179,6 +11220,8 @@ union mlx5_ifc_ports_control_registers_document_bits {
 	struct mlx5_ifc_mrtc_reg_bits mrtc_reg;
 	struct mlx5_ifc_mtcap_reg_bits mtcap_reg;
 	struct mlx5_ifc_mtmp_reg_bits mtmp_reg;
+	struct mlx5_ifc_mtptm_reg_bits mtptm_reg;
+	struct mlx5_ifc_mtctr_reg_bits mtctr_reg;
 	u8         reserved_at_0[0x60e0];
 };
 
-- 
2.44.0


