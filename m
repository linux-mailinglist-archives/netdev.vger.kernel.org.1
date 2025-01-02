Return-Path: <netdev+bounces-154823-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7813E9FFDA7
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 19:16:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92D8E162C9D
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 18:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A8561917ED;
	Thu,  2 Jan 2025 18:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="allhAcVX"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4E0169AE6
	for <netdev@vger.kernel.org>; Thu,  2 Jan 2025 18:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735841785; cv=fail; b=iH5TY0EKXGdVm8UWH3Wvg1cIt7gVQoQMliJsXKLCu2sFV/knXZh8l6xD4z4LNz1LMci4W6JXoCDF0grVl5Xuy7SbiPFX/jFwVi/EjKkqB3H0k5mc3gN7M96ohul7vxtABLB1IbnzP/mWivhivaDlXOJA741Jh0UHAcM1JbuPOEU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735841785; c=relaxed/simple;
	bh=D5zxA/IIiQPrCsywbeYyGNb4LmNdDghiyXc36sjFLGc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HGXC+4OVOvPAQXQJun8kIGL2lkRidighHZDOidcL8XbLqhGMlYY6C9j1VBGPBXUwRVlSwQwtgKXdQFVOf55Dvy3JBzENDg+C9RCFguasXjgo0W47tedjkHWNZsh4V6tEoXmk2LVGl3XwPEtVndfa/8hL4pQhl53MfytsJGkYZxk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=allhAcVX; arc=fail smtp.client-ip=40.107.243.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WYj2GscvtiXEa/GZIbIjywzk6moJSmx3qua66ANQKxBpN15Zx43yvtV9fOsAFU+6Tom+yZS4n6vhSUtr24zxCJV+bdljTfPat2ZQhe/n5j/9P9Df6fyTg6pNCcbiSw6DVKVMjXXy15nyr/TV2lihCXT83/kwEhFpcxO750XsupRJXR8tsSDPpc44XyTtp+J+pMzFvOEQL+7FjUMeibiyF/idSMyeE4MQlD2TWLpX2/izSJcZj01y0DycPep0NtWADabhJ3k8ckJ6I97doNhX+wxwIPakjOCdapzBzM3rXhb9K4fYyFRAjxhBtLr0B+wxJYvk17e7/BOS2SzFouABag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mGz2YoOt43Pp3P6yaCi1KdpSVsPFuC9ljvcjamlD8iI=;
 b=XsZdkCzkPxzmu+cfbcnziefX60vIt7Hxhtnzt4rtPtnMoyJRex4c6tTzxxz2X2GZgD3H8LW+4RXZQE3SkB+HgrEKqU6/pfdDzrX9mlyK2hgWB8CAYw1BEx67huDixb9pg3OC14XGQPW04GEEsZuAXu5T8JqQMlU8i/8hvBs9WCi99tuBVAVwBx+Fu2rfLn4sApUo/v1/nzhPquu6QR3z7pvZWo7sfyqTWkX5v/VEjBqT+PxObuDDbCiamDrBwcfHw27rJPwer8lY1i+XRpegr8I6rctk9lYW4+BAihtE2pP9boIfNDWI35+RNqiigjgs+HLtOdiXfiPFbx3hSldZ8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mGz2YoOt43Pp3P6yaCi1KdpSVsPFuC9ljvcjamlD8iI=;
 b=allhAcVXhaSzMqiU4w9vHf6inwPD5NJseeqIOkK+VPdeLcgc8DIivwCKi/Z/egM6eSRvyUglOuPCE+HhDMLo4cBgsEj68KZFAGZPdMgu1JvwiBJWXaHja2MzwAOiIlZ/Q21+0gaJ+RAWz0OqlGu9gDI4RIXRHuyrsjkKpAeT7V+Yz7LppYWPU6TuJcedBkoX6hXmY06v/jDKh0UjTMnZ14we8BTrtPz3mvtt1nx1CpnJ/kqPWJiv+Nn4k/VsYS+GORaO82TkpnXY0kRDoig8c08z79QYr0xa/IXIcb5aBbdlZwHWyxzCK76093zb+AIoSGaQFZcF0CgXf8e0OSy+Hw==
Received: from BLAPR03CA0099.namprd03.prod.outlook.com (2603:10b6:208:32a::14)
 by BY5PR12MB4066.namprd12.prod.outlook.com (2603:10b6:a03:207::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.13; Thu, 2 Jan
 2025 18:16:10 +0000
Received: from MN1PEPF0000F0DF.namprd04.prod.outlook.com
 (2603:10b6:208:32a:cafe::a7) by BLAPR03CA0099.outlook.office365.com
 (2603:10b6:208:32a::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.14 via Frontend Transport; Thu,
 2 Jan 2025 18:16:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000F0DF.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8314.11 via Frontend Transport; Thu, 2 Jan 2025 18:16:09 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 2 Jan 2025
 10:15:51 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 2 Jan 2025
 10:15:51 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Thu, 2 Jan
 2025 10:15:47 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Yevgeny Kliteynik
	<kliteyn@nvidia.com>, Vlad Dogaru <vdogaru@nvidia.com>, Itamar Gozlan
	<igozlan@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 13/15] net/mlx5: HWS, use the right size when writing arg data
Date: Thu, 2 Jan 2025 20:14:12 +0200
Message-ID: <20250102181415.1477316-14-tariqt@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250102181415.1477316-1-tariqt@nvidia.com>
References: <20250102181415.1477316-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DF:EE_|BY5PR12MB4066:EE_
X-MS-Office365-Filtering-Correlation-Id: 48f7d090-9dbd-49c5-9bd3-08dd2b59882f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zNauqgzTRKwE7eGHGDPw58NHXrTchP/omwpIeXV9YE14e23jopzosQIqEMN1?=
 =?us-ascii?Q?KdRuZfGbQBCRhlckl3MJU0Y5S3sT5DMwLA5jG8VPLmwcscNJ3YIa2qgVpig+?=
 =?us-ascii?Q?wkncPxptEax8KFlown9aNqlPkPUWvzkUaDx4sN4eECdMnm3p3xHtLBoaq1bI?=
 =?us-ascii?Q?xIjpZnDYH43cvd4vn45/xKueuPr3bEfAtk5dIUkwsfLvj0usFkorPku+3TnU?=
 =?us-ascii?Q?0+JIXEjWgs9DdzKIeVKKfPx4vDGA7Xu6edDfbKlW99zpMsDtGNNhmCJvI6T3?=
 =?us-ascii?Q?5Y67JDMBKdAm17E8sAjzIyLh+SLwWliWTPIW7TEJLabxVQaZHZ3RrYhSF9vL?=
 =?us-ascii?Q?Jhxu8Pgre3Bze0YSJncN8y8HwE/LDWz7vdPue85apsG9Lc+DKzrACJvtiMGg?=
 =?us-ascii?Q?PcCnn9mITUEy5cifxzRaAhMo6OmFkhQo3gc2QsUn+0/NEUZeA+dMPSCzvndQ?=
 =?us-ascii?Q?JdNKkFNrHKXCrHjNK1VQnyZBdAKbBeYhapKAajKoA4bMV7+HwPsNv7AL95BZ?=
 =?us-ascii?Q?BqS1W+Vbs0SPRe0oSG9KmdqkzHG+/XTXRAobxO71DZIIR6+c7MRSIG7vOAWN?=
 =?us-ascii?Q?mE/0ellgNG1Hn0BEouCWcaW05i5L1wfUd/72FHUOPfeLTnsTmVe/E9r9BpSf?=
 =?us-ascii?Q?ssd9+6Gz8K1kQWIzORORucn4ggosyNq9NvnaHy/sFYcQhMUEp9pwsSHqjftX?=
 =?us-ascii?Q?o50fS0TPBSekoxGcFV5obv7gVa4a117fxeoNIVVKctXJhAKqGEU3I8UVqs6S?=
 =?us-ascii?Q?+pj1q+w475+5Pud+F3yFSsxxRngAYlvhbY1fzDqVCgbK/usEwddg4o8xSfLw?=
 =?us-ascii?Q?XXg3Y0fOzwAui6p8rX3xYsY3rpPrDZ2/hh0Z5LPzjJl4w25mn/ZFsqDp2ib+?=
 =?us-ascii?Q?+vX9GB6el/FxPhuZmwrc2HkDco2zIP1WINaoQx9OFlBf60RvmYhuFKz3sPUZ?=
 =?us-ascii?Q?tyOu8xDD2OvdeS9Il5AHGKvjugOeKr2evnoNxTg1K4gbqeN8FHwpvirWzDV4?=
 =?us-ascii?Q?vdIyT6mBFlpOQb5mMF2EbzPmWA/2GVfpDRUtGhw3Z3QcF1FC9uYR7tExQaEC?=
 =?us-ascii?Q?e+iZzoNzWc1uDLBgXufpxjIdwJScS5/iv59FXL85+WSLKynRUagkhLDBW+F5?=
 =?us-ascii?Q?EOPPREb9wZKNTzc5mj+RcL+1AhjSDABGiMD4inhXItg3Aa/ixpZm+2bQ/ERW?=
 =?us-ascii?Q?qT0iSOJSjl2jMGEDtyav9Yr8cj/RBviVaZsbyu+piTOfKoYc0sb0D1CSjLFi?=
 =?us-ascii?Q?1evVfoM0gf5H0CFBdNPYwImbZ5GwSdZEOCHvhUp7yrLM8Xcwnjjmd3HC2qtu?=
 =?us-ascii?Q?kFpGMZG1qjtrq23xnh/uDtEfJL3gbwulBmeGt0s1psGSmoiHiiXH8G+VAk2S?=
 =?us-ascii?Q?pu8w4K0vEdoZ862XvVVztYlo66HyPDtO67hwkbwgO5yTAwhY5pTsp7+zu216?=
 =?us-ascii?Q?/LHnVK5zgAD20SpyRq20Cj9QFmsu/iquP7ywj+NnXVRiQEaylLbS2A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2025 18:16:09.1508
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48f7d090-9dbd-49c5-9bd3-08dd2b59882f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4066

From: Yevgeny Kliteynik <kliteyn@nvidia.com>

When writing arg data, wrong size was used - fixing this.

Signed-off-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Reviewed-by: Itamar Gozlan <igozlan@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pat_arg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pat_arg.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pat_arg.c
index 06db5e4726ae..d9dc4f2d0dc6 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pat_arg.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pat_arg.c
@@ -344,7 +344,7 @@ void mlx5hws_arg_write(struct mlx5hws_send_engine *queue,
 		mlx5hws_send_engine_post_req_wqe(&ctrl, (void *)&wqe_ctrl, &wqe_len);
 		memset(wqe_ctrl, 0, wqe_len);
 		mlx5hws_send_engine_post_req_wqe(&ctrl, (void *)&wqe_arg, &wqe_len);
-		memcpy(wqe_arg, arg_data, wqe_len);
+		memcpy(wqe_arg, arg_data, MLX5HWS_ARG_DATA_SIZE);
 		send_attr.id = arg_idx++;
 		mlx5hws_send_engine_post_end(&ctrl, &send_attr);
 
-- 
2.45.0


