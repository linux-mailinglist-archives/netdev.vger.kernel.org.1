Return-Path: <netdev+bounces-109761-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA731929DDE
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 10:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34B391F2329B
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 08:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9138F3BBDE;
	Mon,  8 Jul 2024 08:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sFToV2q4"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC82525634
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 08:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720425719; cv=fail; b=ETMw7xCN7iWB4bk4RJ/PonGZCXgNTB2c1I6kXgd7MvgdqYpm9pTjiXeUCRnVHxR+yefF8W4NJa1yEmOicQXtNst+P+JR3QmgEIspwhMZ6L+ymb37BwYK1CDw4QfE8N18kFhcG5y7pyIGv1Tikb//gEQllEPn2yOb85n3HgSp8qk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720425719; c=relaxed/simple;
	bh=qLW87sf90SxjtLcIOWhTe8TqRhMRydL5V7X1kg52cG0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R5ONG8ex2pe7clsyG5TlbFwmjTFBa6FiBqzDUGYhe5Woa3F+u5PuEcjrN6FtT4ySbadjxlho7k3W11lWlMGz1gcHDhBA1r+7siTHV0Inj1au/hqvP0d/kix8PR8sxDSrfiw/JK2J6r1zTIVLjdT7u1kTFtaJAGYRd40zacuTXFU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sFToV2q4; arc=fail smtp.client-ip=40.107.244.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TSODc5pVlMrdVIe/QXrvoMkfpHGQSSmrea5pmp4DCgozNy7b4fNrNu6Csf0Jl/90ObzrX1J6qK+mif6f6A9agTgOK2tQcZwkIT4Efh5PPSmp+KILF8NiArMYb21ftMx3anC48liqDUWX7XcXB1bpjwzKA+It5QV0eZ10O+tkhj0l+mCNeeuegKysvYS3hEpsky3jrIynYdokH+Lsdu45mzFOUz4TNJS4wlK62/CHVwcmbO0wYJi0lXX35N1Jcg4B1V2vtx1YWVwnZItjNLftiRrgaTFUFOXNnvCCL6lyMAVqSfU9aTNKhNNAak/tJH3+j/jPohUMxtoEzWI8pGmyqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0qDoyakM3nv53e9IIBozTjfPT6bA8ClYVo6mzNpuJzM=;
 b=WAmFLUFFZ+6at4Mm50nDp3zwYS2p7JePEv70p1mddYenyGOsExGSjpu7kVmhv35emqSb5jlffME9iwOEonocF9TWjsqB65nl5MLVonQaWDU+O+t6arRM+2osuKCvIwD7j+MILP3UGWvzRnLGzn72xV5I5QCIo2ASFjZRcsyNucbaFsv7aMJ5/lUwiHYnp46txXZzm00qAgkkW9HkdrtIl4gJkMQKkQmcTM8x30jkvjER1EMgiqrqLtlMP0wvVXsVpG95657SKj+myJP5iOMdKpiIzSxvyXtfNwwL5gVTqZhiWZtg8/pa0f1HqsbUU6UjbnOWJ1qun+EG5X+2nFYXBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0qDoyakM3nv53e9IIBozTjfPT6bA8ClYVo6mzNpuJzM=;
 b=sFToV2q4Qj10fo5yYGMTCY+tvZeXy6wFKklw/xeGs4mlRa62TiohH65JnBh10jKRijp/HIYYCKteHFPyPIhBVi68dRE7JXb3UF6UvAQV0Xoci4837nfRg93h5M5z8+xQ7aZJYYGezu9PBFIj2vC/Vd6uLqtqwZqnmHCXBv3Xnqe3j4wtD6UxQq1DRcVs2Q0YRFHma01FSn+gScgFA9npYr1G8h+lQ86pZeseCww0oc5ssPSosKO2DLn0ysoonQamLEawjBlpZBn15AQbHMfw2cTLaZnbDK7vo6yBv73ZUGpvpvmr/jMvtTglhq2etW88avIjrBTcfQ/fKt5G5MkfZg==
Received: from BL0PR1501CA0024.namprd15.prod.outlook.com
 (2603:10b6:207:17::37) by MW3PR12MB4410.namprd12.prod.outlook.com
 (2603:10b6:303:5b::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Mon, 8 Jul
 2024 08:01:55 +0000
Received: from BL6PEPF00020E61.namprd04.prod.outlook.com
 (2603:10b6:207:17:cafe::66) by BL0PR1501CA0024.outlook.office365.com
 (2603:10b6:207:17::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35 via Frontend
 Transport; Mon, 8 Jul 2024 08:01:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00020E61.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.17 via Frontend Transport; Mon, 8 Jul 2024 08:01:54 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 8 Jul 2024
 01:01:38 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 8 Jul 2024
 01:01:37 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Mon, 8 Jul
 2024 01:01:34 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Daniel Jurgens
	<danielj@nvidia.com>, William Tu <witu@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net-next V2 02/10] net/mlx5: Set sf_eq_usage for SF max EQs
Date: Mon, 8 Jul 2024 11:00:17 +0300
Message-ID: <20240708080025.1593555-3-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E61:EE_|MW3PR12MB4410:EE_
X-MS-Office365-Filtering-Correlation-Id: fa5a93fa-ce03-4e8d-631b-08dc9f243b9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1uXeyHwjPxZSFu3LtGf+TIgJik9wJINMQgQGRFB2HRy/Beu1SuhSar9+34o0?=
 =?us-ascii?Q?g0uUigc+75p0TDyBoOPqAV87CSBrGea5o04yTRypaM9d854NY1/GcsRAPlgO?=
 =?us-ascii?Q?HUUmZqxMyf4+IEzq+knnZFCm1qr1yhfIUVlT+cMKDLmR8LwOs3bpP0xwblyv?=
 =?us-ascii?Q?m2KWv6y3vWNR6//CrRpFM8zlpElUQiCYDUAG/3H9Qkrbs/L9K1JUhIE5g301?=
 =?us-ascii?Q?NURMAgFGiR+6hvrQx3INZLJ3ehUe7VWIQ1MvidOuH/HxBnB0ANkY/axv6PhR?=
 =?us-ascii?Q?FgeHaAqgvRsUjBcfQWxN70SlnZJFiK2Kpii1dZICikq6TKyekn9/xFC5Kd0x?=
 =?us-ascii?Q?j1vuJraGrRwDLd8qoaxiVoxuhhLf2t7DxBf++q60xTV+I6M5XA7LnvsCy5yd?=
 =?us-ascii?Q?1h4tGTX21jmBsi+m+xcQ0IC2wAVPLFxn9sGihPaEBFuHKEcNHp8svULlbXxI?=
 =?us-ascii?Q?vD3R1H43V1h5y9GBITudu3/QR9zxd/Z5Uigs3Y4vewy7b0etWezLbfHtwtbf?=
 =?us-ascii?Q?mMrv3+J8VontF4H6PfWVm6m7a6fxBVAd+GC4fk1rkPHS2cG3Jg49wkAiDXkn?=
 =?us-ascii?Q?QhrLBPwYXEZKPGh+f7dDzjvzXgf0XypznROndQlWHKFgYcW13v05vsO9otL/?=
 =?us-ascii?Q?CKYnCix5dcXwFm+3lfu285cHkAeuR4Kmy0uLt5W7ghYFAjliNYhbSWJnuBGa?=
 =?us-ascii?Q?8VDnN6pPm6UWwLiMx2DlS12diaJKzyDlu+c+g66DSKbFIBeTMhHH8ZC88GCM?=
 =?us-ascii?Q?xCln09GGe88nZfD5TRMoYbme3lZUZ/QeI7gHF5gGSV8DG0yRpgtdhwhVcbbW?=
 =?us-ascii?Q?mZKkUuDqDg0BW7kEbiKXLyBFyhzwOYrz/ZXYRuW8gyDMxjdTzQzc9WiLQSro?=
 =?us-ascii?Q?hbXPm6/YKt1KAClCd60YC1R+L1igtzhZzyWFQ04fsAGdhbqlcEfAkpPJ/Wzf?=
 =?us-ascii?Q?Hue6oUG/rXdbCSKOJOR/kfB67tCfsX8/n850XbW9h3qhrz1j+iooentnuJum?=
 =?us-ascii?Q?7tIVheR70D1gPOmyOb3T6i3Bl2NVVu0DrLH9eduBwAOICuD1uHjbcccZzWJN?=
 =?us-ascii?Q?Zhs8pt0goWtxc2sFw0WUwlJPsCHlJ5G2CZioAgenbwV0/LF15bjAJS2L413J?=
 =?us-ascii?Q?fwkbzolZCELr2H3wR5bh4YW2Qk2CNJ2YeUDpCPRizzqnH0fdGmtYNrJM/fgW?=
 =?us-ascii?Q?19V65v/VsN3JnGJp3UJujlhtgVV/kyA7vW/oLAlZoixgfBkfjDYzvCqON3ck?=
 =?us-ascii?Q?jSQEJiglLycfCbLmwuTaZbHwUGtPqXFkW74kQQKO+tv8LO2I+bzAUw+jA6a9?=
 =?us-ascii?Q?nr+MddHjUE3RshS4zZJ3P/NigK8A3sO/xzr6LsScpZNUIZxJw3kYt+Wuv8Yg?=
 =?us-ascii?Q?SXF20dWuG3xej83jGiMEuvHHT0GqKFXGs84Ju9Gs9n1hX4HYL9wvAh+Vhd/d?=
 =?us-ascii?Q?vT07kZXCyuzuGA5Bcy1t4LjR2zalKlfV?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 08:01:54.5520
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa5a93fa-ce03-4e8d-631b-08dc9f243b9f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4410

From: Daniel Jurgens <danielj@nvidia.com>

When setting max_io_eqs for an SF function also set the sf_eq_usage_cap.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: William Tu <witu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index 72949cb85244..099a716f1784 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -4676,6 +4676,9 @@ mlx5_devlink_port_fn_max_io_eqs_set(struct devlink_port *port, u32 max_io_eqs,
 	hca_caps = MLX5_ADDR_OF(query_hca_cap_out, query_ctx, capability);
 	MLX5_SET(cmd_hca_cap_2, hca_caps, max_num_eqs_24b, max_eqs);
 
+	if (mlx5_esw_is_sf_vport(esw, vport_num))
+		MLX5_SET(cmd_hca_cap_2, hca_caps, sf_eq_usage, 1);
+
 	err = mlx5_vport_set_other_func_cap(esw->dev, hca_caps, vport_num,
 					    MLX5_SET_HCA_CAP_OP_MOD_GENERAL_DEVICE2);
 	if (err)
-- 
2.44.0


