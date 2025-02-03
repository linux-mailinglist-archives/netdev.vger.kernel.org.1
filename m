Return-Path: <netdev+bounces-162276-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB1CA265C7
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 22:37:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A8CD18864EC
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 21:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EAC020FA81;
	Mon,  3 Feb 2025 21:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cuIlqkix"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2052.outbound.protection.outlook.com [40.107.95.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0074720FA9D
	for <netdev@vger.kernel.org>; Mon,  3 Feb 2025 21:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738618639; cv=fail; b=TLIAkiEtNd3D6pGEfLUmVKc7fhZDe3CjPWwUHba/SDPzWNgyX8HFtRM9+V2Im3gFtrPMm7jZH8mDwHA7nRbms3B2G/10VXnRhdopybgBpqG1vZMC2YuOwfMXfgbnchyqfsSqsEB/pQp8SMj+oDr+RT/g2urd4T+zMCkVUhojIrg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738618639; c=relaxed/simple;
	bh=kjcXwjKWJbhb/6MaziZ9sMI9/EB1H1PeokThx3MRtqs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ONbGwiUvlOSS7uXzVF89E3wNGRQDJ33rxtFgmNNhrybkuLyvFeGsr4CcDMjZUcbwkYIsigHIeDbb6IGjFqtUKvxSL54fOWmAZNie7BBbcuo7OqVFqoTSYF9gXf72h7MW1xxMJyDtyQIHmAIWjFW6ux1NOcks1NvaanqBpUuLAe8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cuIlqkix; arc=fail smtp.client-ip=40.107.95.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EuSWiDFFaxtGadkoy0dpK+7wq1qTSz5kTMyJPUZW/uYazwebSBTEkT3hy00IJGY0PxxEiP4Qbaib9HSMVV/ltDqgra+NA+uZaKZ59UhBOOSINE9Jic+cmNmJYtK8bKxWHaLzGjbXBnERJ1JBRZLEdauyrMnyF/9G0lvTGmdt1ZKn+5bDehkeD++911FUUM0dgzjUUidyKeZNc83giuG1iB9s1D36Kzjskhy51FMCWOYBlxqLE8Xmyopx47Swmx9bsSNTbWhaFrftdMcEA2Zmrz88CamP/wRT5mhQ8H/aOF15B+ZZl3tBEPX66d7FMOhCRGK84UC2zXWg/0TAYFFQqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7H7ShBvXIo467GNEbz4/Y+643IoRznURs99LWHsDl9Q=;
 b=Zgs3J12GJSQxvaqlEvIUBgTrGhroKIzyt/CklQ7yni+gwvk/JLOv1Cc7yrZTIPoLs9z3YUC+sH8UJ9U6eNH40OhwgqpqKM5vzubJL+OkOMl8V8+urDGeblzCWHgbZLr3X8lYOltlP+iY/iGAOtozVynHPgKGvZfjTvoo79n1h1CCj7IhNjM5KWTGiNGEP1b7HU8K/MQj37RuLireHszfhN5LkAS3gAzpyTO/jbFbKbbIBFWVRNsDS4uneaOpSE+lUFfs+9EBDJxNqbxtp1j9hGnT47kRxa0U9vngMX8codlMZNH2XQpQPNnaichzvp/HlN84RH+uJlqdBv+NQ12E2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7H7ShBvXIo467GNEbz4/Y+643IoRznURs99LWHsDl9Q=;
 b=cuIlqkix4kcJFZ6V4fzOtyVCRzrNMbV7SoylsvRt8sHMdahKOMx/WVJ6L6EQetosqG0FaKU9ooSiBMpG3D4ZrqbNG/7Gv1SAX0QWe2LUmziQmVuQfDAmrvB85nLjih/ZCIGGv4QgtiIuAQVg3SSzoohQy58ltwPJsea1SzvFapo96Ja9z3sfAp+MaYvApuUbA3ZMZaYBnDmcaLOHTbCLb/Qz0odV5JoiVOIvz/SaQvKvBQnZNZqjJITHZ7XBNWiq7rWR7WdkYPG3MSnLfiVQHmXI9M7r6N/F/KbcsmNiqfAqv0sDpzztmHKIws0l5J7yOH3i85a9Me1tivF4u0ZJBQ==
Received: from BYAPR02CA0034.namprd02.prod.outlook.com (2603:10b6:a02:ee::47)
 by SN7PR12MB7275.namprd12.prod.outlook.com (2603:10b6:806:2ae::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.17; Mon, 3 Feb
 2025 21:37:12 +0000
Received: from SJ1PEPF00002324.namprd03.prod.outlook.com
 (2603:10b6:a02:ee:cafe::b) by BYAPR02CA0034.outlook.office365.com
 (2603:10b6:a02:ee::47) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.24 via Frontend Transport; Mon,
 3 Feb 2025 21:37:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00002324.mail.protection.outlook.com (10.167.242.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8398.14 via Frontend Transport; Mon, 3 Feb 2025 21:37:11 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 3 Feb 2025
 13:36:57 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 3 Feb
 2025 13:36:57 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Mon, 3 Feb
 2025 13:36:53 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Shahar Shitrit <shshitrit@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net-next 12/15] net/mlx5e: Support FEC settings for 200G per lane link modes
Date: Mon, 3 Feb 2025 23:35:13 +0200
Message-ID: <20250203213516.227902-13-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002324:EE_|SN7PR12MB7275:EE_
X-MS-Office365-Filtering-Correlation-Id: a2d167e5-bca6-443d-d682-08dd449aeb3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PjvBl0ZAc8xw0spOSxlZD9RTg77c41VbZBroyYBbCfjCIQiEhCcDl2D+K07+?=
 =?us-ascii?Q?BSuH50moHpwt0DWSpUlKQST6WNJo+DXFICT2i3y0wPcV4tgnxHPglHscYCM6?=
 =?us-ascii?Q?0MYkspSSsu7lPmrCMKs69v+OtywvaRTbm7cd1gcYfa4YqWa+LcZYlH2s/NwI?=
 =?us-ascii?Q?EeILEfRoiGX1L23v+dDaHBrLcZxa39Df6dly1L1A5kd5C3OFYzccI/o+toru?=
 =?us-ascii?Q?9rLentJ7tL32QogEsGPacB8TdGP4EmBqHq1g2C8YCkMvA8KVq2tpso1bKmC7?=
 =?us-ascii?Q?7FCStTr3yZYo2rgzgQK4hbtKLEQ4FyCUNOZ5JP0uqxsADPcN1/+btKk2l4Ci?=
 =?us-ascii?Q?7+BMfWxQXj47nAGAX0+cs5cC9W3eggL7bGXpVJ8x3yC2BO93Infpy2BTK99+?=
 =?us-ascii?Q?GpA6K+pmdnXmLRt1awoH7cwRKpRQHPkmFOMc+6Cb+XSjfWvUHsfFHNxlDpWD?=
 =?us-ascii?Q?JNbA0paPGe0eHbJ5qIhwpfXOXP8yQkI64TEJBBFEzHTbaxcxuqsdJ7PodPui?=
 =?us-ascii?Q?kj0rysxfcNi4c/kl9eE3vAvKcP/KGpHdCfAyAdZSu8kDcXvacfX396vM08Hw?=
 =?us-ascii?Q?20HiAY7kXC9m0T3x4XJvjLF3HBXVe4tNGNUHhjDdqT896Y5/IKcfbpkIZPy5?=
 =?us-ascii?Q?TrxsdGBGEXbk8u51VG7U2hqu6U1yxEVwTfqyOUeUqsi5gyPkjowJYQAXyAqT?=
 =?us-ascii?Q?JAC4z3AD2rmo0MRlmGDiYldohP69BY6bHS9PeZbvEF63qU0589elLs9a19Uz?=
 =?us-ascii?Q?FUNK5B2UFqlh2+OgToXHeJHfaaSsQpWdsHb9luAd2wMAGvi7u0fOQHFwNvsT?=
 =?us-ascii?Q?VOeuM/0zlwLROoJ+C1S85Gtm1XUqraXJLEQ6SdWVWriab+I0t0YP6syyq///?=
 =?us-ascii?Q?vygodShpJCVaMQePOnOLo4w1sgtlbUt1pCncihTFiyXimdqh+n+g8BjdnwpB?=
 =?us-ascii?Q?9pyG3xy5Erm7gSVDucPyP8OcWZNtMcbNNx38gGG79+Qlkhd0Zbs5cy41q7kf?=
 =?us-ascii?Q?2bT54DZQuvasDV0XFB4MCw/OY3I9aysnRwXJKM4Bk3G7mPeuFZefpBHjLqn+?=
 =?us-ascii?Q?hRKfF6UWcBA/ekDjV1LY6as23FmBNDg9Ec+6mTWNtIZz3BCCz0yGmwm++awG?=
 =?us-ascii?Q?+BaXVe2hP7lyOmMCbnlsHyL5ZV3CBlj/2Elq5GCXR/z+FRa7qU4lwtjg/LJr?=
 =?us-ascii?Q?YezrsKBj6ZF/1gfrcAU6r8o6lbURxPmWo151Tv9QFAa+3EyIizkNdJfZSGoi?=
 =?us-ascii?Q?IH5DwS47MCDOqZ1oRphWuUbaXZPb/h2C6O84oFHCDvsD3Nlu/JAgVfWNd7qY?=
 =?us-ascii?Q?tjjTn1EoVBVWKNoeAJ4vJFjqwpLjtILqRm0Ik5Omkc3JnWS1vvrKOkjQdU/W?=
 =?us-ascii?Q?AvUDPEYbMpxkrXNETlWprIT1xAwec8fQGn5i4adv8rm8wjPmmavMGTMaUFgj?=
 =?us-ascii?Q?Lk8s1kIS5iMiT0VHM/W/V17w1Bdd+YrLGcx6Fa9749NO2HOQFdPK58qhAtT9?=
 =?us-ascii?Q?8OFpJAvImRJ2TRs=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2025 21:37:11.8672
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2d167e5-bca6-443d-d682-08dd449aeb3d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002324.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7275

From: Jianbo Liu <jianbol@nvidia.com>

Add support to show and config FEC by ethtool for 200G/lane link
modes. The RS encoding setting is mapped, and can be overridden to
FEC_RS_544_514_INTERLEAVED_QUAD for these modes.

Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en/port.c | 64 ++++++++++++++++---
 .../net/ethernet/mellanox/mlx5/core/en/port.h |  1 +
 .../ethernet/mellanox/mlx5/core/en_ethtool.c  |  1 +
 3 files changed, 56 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/port.c b/drivers/net/ethernet/mellanox/mlx5/core/en/port.c
index 5f6a0605e4ae..f62fbfb67a1b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/port.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/port.c
@@ -296,11 +296,16 @@ enum mlx5e_fec_supported_link_mode {
 	MLX5E_FEC_SUPPORTED_LINK_MODE_200G_2X,
 	MLX5E_FEC_SUPPORTED_LINK_MODE_400G_4X,
 	MLX5E_FEC_SUPPORTED_LINK_MODE_800G_8X,
+	MLX5E_FEC_SUPPORTED_LINK_MODE_200G_1X,
+	MLX5E_FEC_SUPPORTED_LINK_MODE_400G_2X,
+	MLX5E_FEC_SUPPORTED_LINK_MODE_800G_4X,
+	MLX5E_FEC_SUPPORTED_LINK_MODE_1600G_8X,
 	MLX5E_MAX_FEC_SUPPORTED_LINK_MODE,
 };
 
 #define MLX5E_FEC_FIRST_50G_PER_LANE_MODE MLX5E_FEC_SUPPORTED_LINK_MODE_50G_1X
 #define MLX5E_FEC_FIRST_100G_PER_LANE_MODE MLX5E_FEC_SUPPORTED_LINK_MODE_100G_1X
+#define MLX5E_FEC_FIRST_200G_PER_LANE_MODE MLX5E_FEC_SUPPORTED_LINK_MODE_200G_1X
 
 #define MLX5E_FEC_OVERRIDE_ADMIN_POLICY(buf, policy, write, link)			\
 	do {										\
@@ -320,8 +325,10 @@ static bool mlx5e_is_fec_supported_link_mode(struct mlx5_core_dev *dev,
 	return link_mode < MLX5E_FEC_FIRST_50G_PER_LANE_MODE ||
 	       (link_mode < MLX5E_FEC_FIRST_100G_PER_LANE_MODE &&
 		MLX5_CAP_PCAM_FEATURE(dev, fec_50G_per_lane_in_pplm)) ||
-	       (link_mode >= MLX5E_FEC_FIRST_100G_PER_LANE_MODE &&
-		MLX5_CAP_PCAM_FEATURE(dev, fec_100G_per_lane_in_pplm));
+	       (link_mode < MLX5E_FEC_FIRST_200G_PER_LANE_MODE &&
+		MLX5_CAP_PCAM_FEATURE(dev, fec_100G_per_lane_in_pplm)) ||
+	       (link_mode >= MLX5E_FEC_FIRST_200G_PER_LANE_MODE &&
+		MLX5_CAP_PCAM_FEATURE(dev, fec_200G_per_lane_in_pplm));
 }
 
 /* get/set FEC admin field for a given speed */
@@ -368,6 +375,18 @@ static int mlx5e_fec_admin_field(u32 *pplm, u16 *fec_policy, bool write,
 	case MLX5E_FEC_SUPPORTED_LINK_MODE_800G_8X:
 		MLX5E_FEC_OVERRIDE_ADMIN_POLICY(pplm, *fec_policy, write, 800g_8x);
 		break;
+	case MLX5E_FEC_SUPPORTED_LINK_MODE_200G_1X:
+		MLX5E_FEC_OVERRIDE_ADMIN_POLICY(pplm, *fec_policy, write, 200g_1x);
+		break;
+	case MLX5E_FEC_SUPPORTED_LINK_MODE_400G_2X:
+		MLX5E_FEC_OVERRIDE_ADMIN_POLICY(pplm, *fec_policy, write, 400g_2x);
+		break;
+	case MLX5E_FEC_SUPPORTED_LINK_MODE_800G_4X:
+		MLX5E_FEC_OVERRIDE_ADMIN_POLICY(pplm, *fec_policy, write, 800g_4x);
+		break;
+	case MLX5E_FEC_SUPPORTED_LINK_MODE_1600G_8X:
+		MLX5E_FEC_OVERRIDE_ADMIN_POLICY(pplm, *fec_policy, write, 1600g_8x);
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -421,6 +440,18 @@ static int mlx5e_get_fec_cap_field(u32 *pplm, u16 *fec_cap,
 	case MLX5E_FEC_SUPPORTED_LINK_MODE_800G_8X:
 		*fec_cap = MLX5E_GET_FEC_OVERRIDE_CAP(pplm, 800g_8x);
 		break;
+	case MLX5E_FEC_SUPPORTED_LINK_MODE_200G_1X:
+		*fec_cap = MLX5E_GET_FEC_OVERRIDE_CAP(pplm, 200g_1x);
+		break;
+	case MLX5E_FEC_SUPPORTED_LINK_MODE_400G_2X:
+		*fec_cap = MLX5E_GET_FEC_OVERRIDE_CAP(pplm, 400g_2x);
+		break;
+	case MLX5E_FEC_SUPPORTED_LINK_MODE_800G_4X:
+		*fec_cap = MLX5E_GET_FEC_OVERRIDE_CAP(pplm, 800g_4x);
+		break;
+	case MLX5E_FEC_SUPPORTED_LINK_MODE_1600G_8X:
+		*fec_cap = MLX5E_GET_FEC_OVERRIDE_CAP(pplm, 1600g_8x);
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -494,6 +525,26 @@ int mlx5e_get_fec_mode(struct mlx5_core_dev *dev, u32 *fec_mode_active,
 	return 0;
 }
 
+static u16 mlx5e_remap_fec_conf_mode(enum mlx5e_fec_supported_link_mode link_mode,
+				     u16 conf_fec)
+{
+	/* RS fec in ethtool is originally mapped to MLX5E_FEC_RS_528_514.
+	 * For link modes up to 25G per lane, the value is kept.
+	 * For 50G or 100G per lane, it's remapped to MLX5E_FEC_RS_544_514.
+	 * For 200G per lane, remapped to MLX5E_FEC_RS_544_514_INTERLEAVED_QUAD.
+	 */
+	if (conf_fec != BIT(MLX5E_FEC_RS_528_514))
+		return conf_fec;
+
+	if (link_mode >= MLX5E_FEC_FIRST_200G_PER_LANE_MODE)
+		return BIT(MLX5E_FEC_RS_544_514_INTERLEAVED_QUAD);
+
+	if (link_mode >= MLX5E_FEC_FIRST_50G_PER_LANE_MODE)
+		return BIT(MLX5E_FEC_RS_544_514);
+
+	return conf_fec;
+}
+
 int mlx5e_set_fec_mode(struct mlx5_core_dev *dev, u16 fec_policy)
 {
 	bool fec_50g_per_lane = MLX5_CAP_PCAM_FEATURE(dev, fec_50G_per_lane_in_pplm);
@@ -530,14 +581,7 @@ int mlx5e_set_fec_mode(struct mlx5_core_dev *dev, u16 fec_policy)
 		if (!mlx5e_is_fec_supported_link_mode(dev, i))
 			break;
 
-		/* RS fec in ethtool is mapped to MLX5E_FEC_RS_528_514
-		 * to link modes up to 25G per lane and to
-		 * MLX5E_FEC_RS_544_514 in the new link modes based on
-		 * 50G or 100G per lane
-		 */
-		if (conf_fec == (1 << MLX5E_FEC_RS_528_514) &&
-		    i >= MLX5E_FEC_FIRST_50G_PER_LANE_MODE)
-			conf_fec = (1 << MLX5E_FEC_RS_544_514);
+		conf_fec = mlx5e_remap_fec_conf_mode(i, conf_fec);
 
 		mlx5e_get_fec_cap_field(out, &fec_caps, i);
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/port.h b/drivers/net/ethernet/mellanox/mlx5/core/en/port.h
index d1da225f35da..fa2283dd383b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/port.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/port.h
@@ -61,6 +61,7 @@ enum {
 	MLX5E_FEC_NOFEC,
 	MLX5E_FEC_FIRECODE,
 	MLX5E_FEC_RS_528_514,
+	MLX5E_FEC_RS_544_514_INTERLEAVED_QUAD = 4,
 	MLX5E_FEC_RS_544_514 = 7,
 	MLX5E_FEC_LLRS_272_257_1 = 9,
 };
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
index 9c5fcc699515..f9113cb13a0c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -952,6 +952,7 @@ static const u32 pplm_fec_2_ethtool[] = {
 	[MLX5E_FEC_RS_528_514] = ETHTOOL_FEC_RS,
 	[MLX5E_FEC_RS_544_514] = ETHTOOL_FEC_RS,
 	[MLX5E_FEC_LLRS_272_257_1] = ETHTOOL_FEC_LLRS,
+	[MLX5E_FEC_RS_544_514_INTERLEAVED_QUAD] = ETHTOOL_FEC_RS,
 };
 
 static u32 pplm2ethtool_fec(u_long fec_mode, unsigned long size)
-- 
2.45.0


