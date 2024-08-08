Return-Path: <netdev+bounces-116895-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66EFF94C01E
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 16:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E13861F29ECB
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 14:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1058194AF4;
	Thu,  8 Aug 2024 14:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Opk1CswE"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2087.outbound.protection.outlook.com [40.107.94.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C1F19408B
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 14:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723128191; cv=fail; b=hQNvYA5UiZb0dnRC37KB03tqlXmT5Ns90HfBU93GU525j9sucJup3Kk4T2WWq2Vp4IPCmDD5QAzGsYWOGSgp5b84kmODVWk23P+74Om9VaIGHLMP++DyA/Pm/1fEwcE2QDpb4OGxbs78Tnq7ueJ7E66eBjjw1KhMxnK6248r5wk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723128191; c=relaxed/simple;
	bh=udGNX7Auecv20KAjpCF9huXYBZKyEFRXONnL/aSbzOI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T3IiwhM8e1ebDZ84adZuRSsbwXS6O6E1qwcNN4T4AnHe/WutOqbpFLLrdycNHS5IcRwtWKIBkoNY+3PFgJNsG7BtkvbO4dPtWGBdIN/dGnmGS0cH67etvYf6Bc5NpM2Di8nJjS+ZNwKtBAF2lxTZ4AV/zl0zj+lBGXIPtWgcbKk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Opk1CswE; arc=fail smtp.client-ip=40.107.94.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fzfwia8g9W+9vCfV9QiiqMpwkg5rpWzoWDljxH3BH7RDOyMKSGgAjGeT6B4JWUOhaUl7QgrxnJzj6TqWYi29yio8be0U4rbeY2vOMMCS4/o/9bgejkDFAxahJOfIAKZHV6TGbI3Y1U9f45+QE08lsZaECbCfFDlI1qzq+ntR2iWdPSDQtUh0w67aCX+9wykOOnGrRG6VDcSf8MQkBPgc9oaBOqhuuMS4rTGqKzRzDo3tzr89aD3oHzcYwwJ5BtgDJsOvfjPzYOU3tShH90+Uhxf+LMyKHCMBbaBobRTIdN7iW44Isa4epZT+O682aY2fmjD/pbyFmoge4Nudb6psZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MZsAObQ7SCV53OepEW86ksiOFEfVVSO0V4HXkF/tHhw=;
 b=jueP2bmElVE2ctIFYCkAxf10hlCoM+gq5aPhN4DmHJl4CVviX4B67ZQOqO0N2DZVEBpGPKHeqnzBOzkcXm/egpWtnzfUpSQgl/nUfWxak+PMHcvWE7SggSASDPVIVLWmBItGQ+md5/Q/BQnNbQEYHK8MYiqWPdZA8Q9hYKgENtxHrSFesc/1xbqsfkPNydC1DigSxmhnTbDD5SFEtLN8Kj9SsXrhvxDZKrHOb+t6Du4fQUTqqHLs49bPWGBjWryGvzcRje3ztDitEFD+qsyQzjpI00FWOoGYtUotW3xHr7mufva5Ug/4vgrnsMcwZ4G1b1XmevsUme1e+iVRyCvN5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MZsAObQ7SCV53OepEW86ksiOFEfVVSO0V4HXkF/tHhw=;
 b=Opk1CswEHe9B4QuIb1kfQ2kSTLWwmadRFT0evqICPE9AAqj38COYlQaLKkBhL2+fACa/ndvPOL1xHAHmSsKDTwqy2J7XiaRMOIgzwvXLL3LdtoctB/HCtPJPYcQFGeD5FBshKpn/mX/opVNMZJOcJqmhKreV42S/Vg4/jKw7qb3paJWvrl3ac/NYYhqMHzFSTIU5wCY/OGDQHyqG9QUawHyX9FBN9pZkvCyIRZ+RSBGANaxyInqOleRykcBi3xtmXo42apC4GYt2Usw4xw543SbCuHJ6Cp0kD5n/0eNYlkKophVry27wQzHywmLxSk+4AT/5ClmLAei6QRtLWUYWAg==
Received: from CH2PR18CA0036.namprd18.prod.outlook.com (2603:10b6:610:55::16)
 by MW4PR12MB7165.namprd12.prod.outlook.com (2603:10b6:303:21b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.15; Thu, 8 Aug
 2024 14:42:59 +0000
Received: from CH2PEPF0000009C.namprd02.prod.outlook.com
 (2603:10b6:610:55:cafe::21) by CH2PR18CA0036.outlook.office365.com
 (2603:10b6:610:55::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.14 via Frontend
 Transport; Thu, 8 Aug 2024 14:42:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH2PEPF0000009C.mail.protection.outlook.com (10.167.244.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Thu, 8 Aug 2024 14:42:58 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 8 Aug 2024
 07:42:45 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 8 Aug 2024 07:42:45 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 8 Aug 2024 07:42:42 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net 2/5] net/mlx5e: SHAMPO, Increase timeout to improve latency
Date: Thu, 8 Aug 2024 17:41:03 +0300
Message-ID: <20240808144107.2095424-3-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240808144107.2095424-1-tariqt@nvidia.com>
References: <20240808144107.2095424-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009C:EE_|MW4PR12MB7165:EE_
X-MS-Office365-Filtering-Correlation-Id: d3b8716a-405f-45bd-e663-08dcb7b86563
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?s8mza7akTtJQAHCdPgZBsRgO/g9pAhZwzZ0+zYg01F4XTW2O6hGwUMmnYpua?=
 =?us-ascii?Q?EGek0iA42OjDx/eXFR4HeFYTDZ1wFj6kE/QP5/d/Q1/hNp491v65t+YEtHOl?=
 =?us-ascii?Q?9xkGv0kF33Q4Mf/GiXIoGLqjmpm/JvAKcTMEfWzZ38uqWgmbWfsBA121tFCJ?=
 =?us-ascii?Q?fcdIz4Bozzt++1Kger6MxUuPgc2BixNRa3mvcLqbc4sDL8h2THCgUwZnE61i?=
 =?us-ascii?Q?xYpHo7QBQvUsSjgPmkkES4w+hAlK3gVtgzvsYYMIF3IGO/LqNjpvjE5cJYcM?=
 =?us-ascii?Q?yF0BrgAgvUdg4gZokDDsrdNukOs7HyFbHD9B+Tqg4hWWWGllC9/+Lu5peZH2?=
 =?us-ascii?Q?as0W4J3F0dMRV/E/+M9sBPkGamduPdutkKl10u75zAK9yXiKVUUkE89/X8Bf?=
 =?us-ascii?Q?L2eyL6/20WrWcBbL9eohxcLT+haPYSj/1AG7PLYIcII42L8yWqHYXy0BgK+Z?=
 =?us-ascii?Q?a+Fp6ACDsJGQcvzKzTKCSHCcOb9Sb9zyCp0L+Lwsb7awlOQHBYwIA5L9668Z?=
 =?us-ascii?Q?FuMikRm0hkT9Mp+jKC8lccCaZNp3rbbQgaJtDjTHEawd9nrnSNZwgk6VdQBt?=
 =?us-ascii?Q?OnSpVGQooCz0yXm5z76MCSkVKm+6v3leoDX5CLVwXCL2Nk1AGQVUcht99/lX?=
 =?us-ascii?Q?2NcVdFsF5CvQm71aOWwYYbDT5l80Hr9lDPo0XH57qCnpozTuaicYGGpGd5Ot?=
 =?us-ascii?Q?VvVcwIAFyMFaOtf1pCzLZMEKKA9OvVw3OnYC9GB7KRvOnfMY+nBwTAsQcCQg?=
 =?us-ascii?Q?17S468HNGGTxlL14jeY7QUo9XLtriTbZIzxt2xyTkZn7VzwlX9gwaQWURqzC?=
 =?us-ascii?Q?UWJfci4I/E8X1fxhRQ0YOch64S2uQxylvv8dwldVJI2V4WvRgdHthKI+4Cqw?=
 =?us-ascii?Q?dQY4at+SGjvlbhCgGONlc6XZa5j6Y2gG/1i2uQXhkUon58egaNr/ObjIjoyq?=
 =?us-ascii?Q?Y+syBKUXdxTE77KJfDmcXfvnUENbZ64E4TWjVQbAZmY6vQiciM/M+LmVgXBe?=
 =?us-ascii?Q?iX4S/RflGuIUMtUDUwfKxONrcvwYSiYHUQ1JPIBfBnAndKbpRwx8lO1cNths?=
 =?us-ascii?Q?8iKk8+04NrIYro1fbvF94TXm7zHgxY37BO4gx0KWbCpXAgo/9sB17Yt2wJcW?=
 =?us-ascii?Q?RRBWL/k4PQ12jshDx5L3vGYwM8GztRQnU7Sk7J2MpEzADpLs/Q9YvDQehjVP?=
 =?us-ascii?Q?q6B03ffgwpSSuDvFYAOM3T++DlpGWWq+nmjiiDF5OTp0yxSaxuWNIE9e7/jY?=
 =?us-ascii?Q?Cn6HmrtkbxUQRyZEUs6XNUo/JLjBLV1A4OL7GINR9CyQiue4g42yhbyd8j3X?=
 =?us-ascii?Q?Ki9lPpM0oSkQmHL65VAQ/GaL//psGz7dpCvxJezXtWhY1FwfPjo0l9d5Z7BH?=
 =?us-ascii?Q?W1PTSJFlFEWRrA6mu01M6rUaTcR81W+F9inIgmZ4J7BduTIeXlWtMSRHUl+Y?=
 =?us-ascii?Q?iHFxX73zPS1q07GAEUEAHgkb9UgyBelH?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2024 14:42:58.1116
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3b8716a-405f-45bd-e663-08dcb7b86563
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7165

From: Dragos Tatulea <dtatulea@nvidia.com>

During latency tests (netperf TCP_RR) a 30% degradation of HW GRO vs SW
GRO was observed. This is due to SHAMPO triggering timeout filler CQEs
instead of delivering the CQE for the packet.

Having a short timeout for SHAMPO doesn't bring any benefits as it is
the driver that does the merging, not the hardware. On the contrary, it
can have a negative impact: additional filler CQEs are generated due to
the timeout. As there is no way to disable this timeout, this change
sets it to the maximum value.

Instead of using the packet_merge.timeout parameter which is also used
for LRO, set the value directly when filling in the rest of the SHAMPO
parameters in mlx5e_build_rq_param().

Fixes: 99be56171fa9 ("net/mlx5e: SHAMPO, Re-enable HW-GRO")
Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h     |  2 +-
 .../net/ethernet/mellanox/mlx5/core/en/params.c  | 16 +++++++++++++++-
 .../net/ethernet/mellanox/mlx5/core/en/params.h  |  1 +
 .../net/ethernet/mellanox/mlx5/core/en_main.c    | 12 ------------
 4 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index 5fd82c67b6ab..bb5da42edc23 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -130,7 +130,7 @@ struct page_pool;
 #define MLX5E_PARAMS_MINIMUM_LOG_RQ_SIZE_MPW            0x2
 
 #define MLX5E_DEFAULT_LRO_TIMEOUT                       32
-#define MLX5E_LRO_TIMEOUT_ARR_SIZE                      4
+#define MLX5E_DEFAULT_SHAMPO_TIMEOUT			1024
 
 #define MLX5E_PARAMS_DEFAULT_RX_CQ_MODERATION_USEC      0x10
 #define MLX5E_PARAMS_DEFAULT_RX_CQ_MODERATION_USEC_FROM_CQE 0x3
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
index 6c9ccccca81e..64b62ed17b07 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
@@ -928,7 +928,7 @@ int mlx5e_build_rq_param(struct mlx5_core_dev *mdev,
 			MLX5_SET(wq, wq, log_headers_entry_size,
 				 mlx5e_shampo_get_log_hd_entry_size(mdev, params));
 			MLX5_SET(rqc, rqc, reservation_timeout,
-				 params->packet_merge.timeout);
+				 mlx5e_choose_lro_timeout(mdev, MLX5E_DEFAULT_SHAMPO_TIMEOUT));
 			MLX5_SET(rqc, rqc, shampo_match_criteria_type,
 				 params->packet_merge.shampo.match_criteria_type);
 			MLX5_SET(rqc, rqc, shampo_no_match_alignment_granularity,
@@ -1087,6 +1087,20 @@ static u32 mlx5e_shampo_icosq_sz(struct mlx5_core_dev *mdev,
 	return wqebbs;
 }
 
+#define MLX5E_LRO_TIMEOUT_ARR_SIZE                      4
+
+u32 mlx5e_choose_lro_timeout(struct mlx5_core_dev *mdev, u32 wanted_timeout)
+{
+	int i;
+
+	/* The supported periods are organized in ascending order */
+	for (i = 0; i < MLX5E_LRO_TIMEOUT_ARR_SIZE - 1; i++)
+		if (MLX5_CAP_ETH(mdev, lro_timer_supported_periods[i]) >= wanted_timeout)
+			break;
+
+	return MLX5_CAP_ETH(mdev, lro_timer_supported_periods[i]);
+}
+
 static u32 mlx5e_mpwrq_total_umr_wqebbs(struct mlx5_core_dev *mdev,
 					struct mlx5e_params *params,
 					struct mlx5e_xsk_param *xsk)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/params.h b/drivers/net/ethernet/mellanox/mlx5/core/en/params.h
index 749b2ec0436e..3f8986f9d862 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/params.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/params.h
@@ -108,6 +108,7 @@ u32 mlx5e_shampo_hd_per_wqe(struct mlx5_core_dev *mdev,
 u32 mlx5e_shampo_hd_per_wq(struct mlx5_core_dev *mdev,
 			   struct mlx5e_params *params,
 			   struct mlx5e_rq_param *rq_param);
+u32 mlx5e_choose_lro_timeout(struct mlx5_core_dev *mdev, u32 wanted_timeout);
 u8 mlx5e_mpwqe_get_log_stride_size(struct mlx5_core_dev *mdev,
 				   struct mlx5e_params *params,
 				   struct mlx5e_xsk_param *xsk);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 6f686fabed44..f04decca39f2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -5167,18 +5167,6 @@ const struct net_device_ops mlx5e_netdev_ops = {
 #endif
 };
 
-static u32 mlx5e_choose_lro_timeout(struct mlx5_core_dev *mdev, u32 wanted_timeout)
-{
-	int i;
-
-	/* The supported periods are organized in ascending order */
-	for (i = 0; i < MLX5E_LRO_TIMEOUT_ARR_SIZE - 1; i++)
-		if (MLX5_CAP_ETH(mdev, lro_timer_supported_periods[i]) >= wanted_timeout)
-			break;
-
-	return MLX5_CAP_ETH(mdev, lro_timer_supported_periods[i]);
-}
-
 void mlx5e_build_nic_params(struct mlx5e_priv *priv, struct mlx5e_xsk *xsk, u16 mtu)
 {
 	struct mlx5e_params *params = &priv->channels.params;
-- 
2.44.0


