Return-Path: <netdev+bounces-109369-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D72928291
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 09:15:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40C14287B67
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 07:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D04144D3C;
	Fri,  5 Jul 2024 07:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="E7X3E1wI"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01764144D22
	for <netdev@vger.kernel.org>; Fri,  5 Jul 2024 07:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720163752; cv=fail; b=BDXHhS89brgRmwKOWCdfiHwaT6OjWemJebPM3Le8pX5hyhvB1/6ctI6S31ABF10zIllfVG64+/12DJmqcF8MvUE34yHAwb9oajo9rVRwjqm8txn+FB1BXHW8Goamb7Fm1d3O/4ZnWpj1DMCB3GbvKPlGbaGR+M5Tizek3fiqouk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720163752; c=relaxed/simple;
	bh=NAg7blGlM+IidWttZZ/NTJcgPctLv9P18VuBvtEv70s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=paDTdbMbrRaQcumDYk1Ko8SKJJ9aFd55jFEkECHegs9Mp1h/mwOEduNjjO1fLcsW5ESFBdkrXBGjA8YxWNmapYAX07Tn79zZk80OG7rm8EcMoYgjP17gRkfVNgbvbcgW5pJiYBbtyNcjWDAWbD08JtkvJRcv8IUFgl3FjgvtlqI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=E7X3E1wI; arc=fail smtp.client-ip=40.107.94.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U6V+IcKLV4IKxMIrTdYqmmGosTsQvvRpGy97snjbgRgxYtyueWt4L76ptlSh+sMjS4ISSg169exV8DJJ8E10IAnDP+5M+o5uCn9MtdRzI3WDLy91N+CgtzJQ/1oiSVtgdtdijAJzft3Wn7jiGBwOLWsTmDXZd4GjXPOD6pYuDV78uAO4TtHZbOhH8q0uTtGYxjXke7wlrWhymZ9DakyG3YirR8eGukab5ukPGsm8iKOM6bBTF2jCpWU0FRnr8OFPf/G05mYcxJ3mKzEk2Ov9dBR2zDtxGoXFYZJuq7XJR+5bunSNx3oLzVFIzf+EbXp7TeDm5+aWQdRP2OSiOuflVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1t6st82wRO0osuqWhjejfcvfk0VJ+4vdfP2KwEkD7Ts=;
 b=fTcmXRB5W4fUbIDwbnS/kq/gr46Ktk19+07Ez6JShRhfAXufWyGeNgcGAWnddbyvOScXTog9ByejwcjBirvWv2cB0oNSlEb+onxkPXvw0z5+wgd9MO/bXi2g2VNz0ErPl44o9QM4LRXyoqP5CJC4IZnV1FJ3sv6pd6bEDu7mWh0AIpg9744+brdcSb96r/DeTZA6C+OXeQg+IGi4ElIftB2Fo3pdYWdMEsfoQE50CjEn0xVhN5cgRaT1nMEHMZJXXym8aiytZ5vC11C4RpqrVtck11H8YGy7EtjZA0M5N+j5/7Jz+f75eqNdl1TgX/hyeLUCiQvirLJnPaUij3HOXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1t6st82wRO0osuqWhjejfcvfk0VJ+4vdfP2KwEkD7Ts=;
 b=E7X3E1wIhq/LU0ZDYus/fFaF1/da/62S+9j6f9lxa2zHMVmbM/JYSb0L2zMB30/IHLFmWUmAaruMZNf9V37oHZBKjEFV+esjz3EMD0Y83hR2+8JZ5GVCv4DCItnsznrMK68fFq+j0i8QlaFDGzvYg5HswNeMn3o49FyMcxUJ7cL9xv5Iz/O6al33HaF7D9db+ss/O2oJ43+/IIJfvboxojbpWIR8ROkD91wDnTXJaZcONTUQtI/xFCtuZv9NiZRAGFDS9uklvF56oN08P6fwWEDVB13X+lmwhNv3n92ioo6WTteWM11TwwOEnruxifrzaqyCkRLu/XugAKmSeo7k2w==
Received: from SN7PR04CA0164.namprd04.prod.outlook.com (2603:10b6:806:125::19)
 by PH7PR12MB6977.namprd12.prod.outlook.com (2603:10b6:510:1b7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25; Fri, 5 Jul
 2024 07:15:44 +0000
Received: from SN1PEPF000252A2.namprd05.prod.outlook.com
 (2603:10b6:806:125:cafe::bd) by SN7PR04CA0164.outlook.office365.com
 (2603:10b6:806:125::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.30 via Frontend
 Transport; Fri, 5 Jul 2024 07:15:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF000252A2.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7741.18 via Frontend Transport; Fri, 5 Jul 2024 07:15:44 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 5 Jul 2024
 00:15:26 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 5 Jul 2024
 00:15:26 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Fri, 5 Jul
 2024 00:15:23 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Rahul Rameshbabu
	<rrameshbabu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 05/10] net/mlx5: Add support for MTPTM and MTCTR registers
Date: Fri, 5 Jul 2024 10:13:52 +0300
Message-ID: <20240705071357.1331313-6-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240705071357.1331313-1-tariqt@nvidia.com>
References: <20240705071357.1331313-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A2:EE_|PH7PR12MB6977:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fa2bbc3-ea97-49a6-7244-08dc9cc248fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0kmwMi9nQU7zpHRIGiGrRKEaqDk5HHcLmCwHphLVQKPbOEUjdhlIN1kthH+f?=
 =?us-ascii?Q?kVEgmkVQi46sXq4w3ERPMAXLISi6BgNyKGuWezS46PbNNQKIvDQCzKtufHVt?=
 =?us-ascii?Q?uCb4r8jNm+vW8tHK/96+ZxJC+37Iig40pP1721r5xWamtXwEjlcz8Lkm/I1E?=
 =?us-ascii?Q?QJ++/BkFk+3Co8GUO1hIqyfwsMTSXLu7US5ra7zBQfTvJ1dSnF9N+UCOO9/4?=
 =?us-ascii?Q?BHunbRnix2lXR4DQYhnCDpDX9b0iymIa4Tw27HI+BuTDpaYkgMLAyFaJlhlW?=
 =?us-ascii?Q?KbjtQUZb4RIMQ5bgENBllYLhS4d/hgUzyiPQpMeqSLyu2IjE6Q2Ng0XjJFud?=
 =?us-ascii?Q?DuGlCB/mTe2PiCAcFdljR6A93y1twuaF19i1nf62WEkQJ9t6i6FGJR+hcJVT?=
 =?us-ascii?Q?4FIJlxtvwavUyBDfDR5ivcMH5TbC37wUPMp+rze/3uBt3HJYF61zbGzHA7Zq?=
 =?us-ascii?Q?RB2nT0PSRIWs978DEWwoDaNM7OHjgmJMV53mF0i8GEDK7ruy51td2SD4QLKC?=
 =?us-ascii?Q?EnG7kBOM463KemsUCQ/L64jzdt/ssDP/8MkLFOkHiJ8IMSUSGXPGER1AQDov?=
 =?us-ascii?Q?XBvZITlahLQYTcEbsE0Ol5iIsEXEkU/vm5iWZRizvj8RwcIn4L6FfIEaKTdP?=
 =?us-ascii?Q?75VoGm2Pw+rGN+cA6j5hMPRthHnSFFvgfPh4EjwfkOaFYYYRV3nFGL6WpDnN?=
 =?us-ascii?Q?HpvSobeL+V9gt/9OfXQ+mv+SfyPLXQTLfTDjtJd/dTbmCPWDg5/bGHOFmnXo?=
 =?us-ascii?Q?2LqDYhypDQHqlrkq0o+RCoGdUn3GhRFYyL0FYM2a1ndSQBWl1x6n9b/KVRhB?=
 =?us-ascii?Q?pucxlnO0pHV8MbhA9IQTh/Em6F8bOip9SOGwSzaSIXS7JZE5bnRl8ZseA7Bf?=
 =?us-ascii?Q?jbpv0EJJPY1pss/gmOnDspA+VgH4tjkt5J0ivys2G0JMjAz1MUFbmUJ5J22S?=
 =?us-ascii?Q?5/YryDSI9LvxrsAz6YsyO9bR4yOoDw+Q8tfOT9U1lfqrrZdU5T5+HaUtZQB8?=
 =?us-ascii?Q?dNRzxLZHA6Sdl0VCViWmpdmncsApOmsRr61PSBLOqrY4gRvDYVqh648YBAjP?=
 =?us-ascii?Q?ZW9jeYtSgCUH7rF0ka8OUAhZuDHc+OwiUK7Vx8gcNe8VK7iBNj63dBd4ku5q?=
 =?us-ascii?Q?AJp84LhJ3//gDajj9Tm2xu5ERvQmkFWe8RmCiqbwdsnUTQXQvG1Wo7qbTD42?=
 =?us-ascii?Q?ByyArinL3qbi/Mu0KdupJgSgAIsjJ/0xaruNpkFlqj1obp34xz/+vgfTA6V5?=
 =?us-ascii?Q?hbhYfxjfH1JjgD8ZdNLn4SfFeKsF0948FsBNsl+pvNVJP3aD2M0qbt9DPwlF?=
 =?us-ascii?Q?9wojCsh25xEfuCMVDrlCOtraJFyGHuXxf6PPTKBrp9Azm0fihMFFzePRs0AK?=
 =?us-ascii?Q?BVXukdJIhWfo5vtWZfAY2ovnE31qXpuNf4PZJx5CJ7YvKr09nFaSQWjzPRac?=
 =?us-ascii?Q?ugeWtQcy44F3VjediE2oEJ4/2uUFY34b?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 07:15:44.0519
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fa2bbc3-ea97-49a6-7244-08dc9cc248fd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6977

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


