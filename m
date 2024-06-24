Return-Path: <netdev+bounces-106019-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A44F9143BB
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 09:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48E391C2134C
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 07:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6EF45024;
	Mon, 24 Jun 2024 07:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="f9YNMKLh"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182903EA90
	for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 07:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719214292; cv=fail; b=aYCWoLu3m/U9rPtSDSJ9RN4uia+MxxE+ZEEQhtSXdg9mp1WOupnq9bWt1JQYI9XRBuqDfoIGrTqrprWpXpP134Tc7v/NG9tNkL6EhgOgMqutQFakvUDkAj3s1HOfWszeUK/wXUt5e6WwwpkeQJ4EnOp0bZRpkH04GXh50nFCeE4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719214292; c=relaxed/simple;
	bh=LStAbE9vpO/sIAT/4See3RWQmxNTtiVg9lDExW0cLOQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jGtD24SrzKojpKoorksCXwQ9pADjyaUjz5oVRZgwe619eMHBt8FhgaSjL3cpR7qQimP/w9JLRE5vGU1mzKhm54FM/oF7yd/0dTCmH0RaKXiy8gC+FpPgz+asO9eO6tzfOxmFvXm+MZT44EEHOI0Vp0p/fhmggcfi4R2QkV/OTTY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=f9YNMKLh; arc=fail smtp.client-ip=40.107.244.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mDz1xrE/B/+NrJKe7OY/UMrviKMdSD5cW5d/RfFKHeiJ1I7KkV7aAYk/27DqJDdd4dNEdhYBkjLG+1zT/tqO95LyVDr4IuYWCt5AeQocj6esX/jPT4NMIh19yktOKkLndQHiQCri9rkLDPgmZxyQxBbxton7/dWwP/B6eHEljqBWx8tC+n9AXTG7uoFP6jvytu5TMN1S2Kh3ND61sO7e9vLAG41BxUxonjEijTBPVB6wZjkxRumMKqwrmlGOTKhPNVFBUJ2seeFn2IY5UNTlC9nXb4wIJ1HTk6ekkl2d/0rS8pZJ9pW31NOCMfgObDAkh2lRvw3XrhkUVahV2MuOIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s3PKK+BN3vPx9Db4iy/hS26Whh5E64+zPiV3w2Wl4vA=;
 b=d+CFODT7btHXy+VQphZ8DFtix13RzXM5+Rr7iSb0vamlFWx8oWg1OUkuBYLP+HTel/0WV5lPGG58IuH69hxkc6FpKJ2Z0Kt7PDwfGBCskZl5oObnt8KS9HTQ1l0Vi46gQPFEbP0dk08sSngfuB7A7daa7I0EcMYJUnNRM8I9dpIgC3dhGDa/+lMLufylK0cNwfplmOoJwL90TM2YgJvKkj2I7HDLRjEwJcAqoosTmd8Or007yI3EFKqLoa1wP0LjkJXxgV20Yw+dFJu2OUSHbSbbRW1VbndHnNdMFtfVIDXl/uILflJ1q/sS7/fmLzSAXoRHipS+j9Vm97+Uworo7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s3PKK+BN3vPx9Db4iy/hS26Whh5E64+zPiV3w2Wl4vA=;
 b=f9YNMKLh6t9TRAJq7RPlOIUFeD4azK7gvCY1lGb0440AmvRMWUunhyK0k6OrY4965LoPssflxY+t4sy5F9XjL5gmYs/LbtdEfG8hm/Zu0s6cerdFOpp08mV2dw/ZjLk0F17YVmEh5GUZJ0kuRdtG4gRUPKdOKCr3deQnh4VZQ6zz4IPncJmhUydCprF+31FJ/nMG8lhk1eJHzVwa6p6TzYP7oVWvbCHkBgsez7Gd4cNUyxVNijNngKcm6BM8IOy0OVdlnPQoQK6pE6FiztHf+x0wFqx8QMCx+6jvrSlhYQ9igNi3nKY7wLrIFFVO+H7Cj1gwEm8kt6LpQxOB0k/fmA==
Received: from BYAPR05CA0074.namprd05.prod.outlook.com (2603:10b6:a03:e0::15)
 by SJ2PR12MB9241.namprd12.prod.outlook.com (2603:10b6:a03:57b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Mon, 24 Jun
 2024 07:31:28 +0000
Received: from MWH0EPF000971E5.namprd02.prod.outlook.com
 (2603:10b6:a03:e0:cafe::8d) by BYAPR05CA0074.outlook.office365.com
 (2603:10b6:a03:e0::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.19 via Frontend
 Transport; Mon, 24 Jun 2024 07:31:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MWH0EPF000971E5.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Mon, 24 Jun 2024 07:31:28 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 24 Jun
 2024 00:31:20 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 24 Jun 2024 00:31:20 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 24 Jun 2024 00:31:17 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Daniel Jurgens
	<danielj@nvidia.com>, Parav Pandit <parav@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net 3/7] net/mlx5: Use max_num_eqs_24b when setting max_io_eqs
Date: Mon, 24 Jun 2024 10:29:57 +0300
Message-ID: <20240624073001.1204974-4-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240624073001.1204974-1-tariqt@nvidia.com>
References: <20240624073001.1204974-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E5:EE_|SJ2PR12MB9241:EE_
X-MS-Office365-Filtering-Correlation-Id: 001a3588-afe3-4683-1859-08dc941fa93b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|36860700010|376011|1800799021|82310400023;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7DmITXeEAcH8HY1KYu9/l3jl02D8SSzHzeFrWhMQeFzTwIlGEgszzP4L9IzA?=
 =?us-ascii?Q?TPGwdizKjYFFJihazi0XdltG/r+4KZW2XKTZF76UVwbAU94vKnTiN2GIJ8BV?=
 =?us-ascii?Q?blM3SxI21o0274iLRHmP4uLiSqCXTsXAn0ZJ2qS5JX9MdGPCpeWguyG1LAW0?=
 =?us-ascii?Q?ywa5Wmosv1DXXpDJmWuykfTQn7+ODg81J4Sv6WI5R7Azh8HAp3MoECUwEYxD?=
 =?us-ascii?Q?xeDp5vLm8bk3NYJ21Tr4C1BzZSjBQFtRGeTT1YUh4PS9fCWEu29IoFPEF8IE?=
 =?us-ascii?Q?lRgIxp0HADkOqC/wMaTmUUERyMrtZiTBRN6JUUWDiVDjPJf5vmzgVdDliUHg?=
 =?us-ascii?Q?7y7ua5P/bR6sV5tGOBl4KEFs7GMuDrrJP1MGpKKAc9GcNCMCr/KDPFABKLdD?=
 =?us-ascii?Q?41LlYnropHhdFMXgtn0IU70YjcLNiq2qIHVEa1tUdyPF0G+ZxSaVzaypfByi?=
 =?us-ascii?Q?e8AA8EXzY+CwYYs9Fh5MHnhy4Veq9R6xkBOA+X3JRwGUvKLyItnuV3fdTt2n?=
 =?us-ascii?Q?XORTPFwI1KsW24FMeb8jcfWvVITxAgF+LdWHxHe5huJ2lGEZpX0KS89oVPf1?=
 =?us-ascii?Q?0Zm5Gsq8KH2EOMGbYa9Eylbp4F1wXASHQrrmHWYINhv7tSLVDed8FTr0gOEL?=
 =?us-ascii?Q?ImoFiycHTab69vxBvvEFcszecHMbDO0X4veMi8/BCoQthcGDsb56Kxnongmb?=
 =?us-ascii?Q?/FNfw+CBgsmoDZYNvSEJhNPNUdzCBw6wosg/ZC0FUk1Jb+lEp89xLMFcdX4P?=
 =?us-ascii?Q?HC2eEnVDluwTflPVVIwygmjsJtAeAWeOIPz3NLmGgd3e4LPypDP1TJKKfNWe?=
 =?us-ascii?Q?gw+YZdnglTZ2k7W/filgCkB+UoMb4NcWynQ/6GFtA/zdD0gmvOX/VrFy2zr4?=
 =?us-ascii?Q?lvx7Wsc11GhH/apOQtsp/+Zy0GG7uq2H3XvI8sYSectzrbo9kDLKeRsm1vOe?=
 =?us-ascii?Q?BINOYSJKbbK4y7y1cq7o3PWYovy/rII+gNPrJq+X3bmK9H1aNYkh7cfAy4t3?=
 =?us-ascii?Q?CqC0P/cHg47n5pvORF/fd4HMstIFSP2CAkARs2lNFbAXT4Rzl6Bd+FDrD6xe?=
 =?us-ascii?Q?Rt6yYj/BfEhZcfntdDJNnrTbXkzvV9LzWnzbx4yE8bERQ98EgAa993NfMXhw?=
 =?us-ascii?Q?9gLt/2jktrfDpYe3s9qOJVE+Tv/IG9QrIQpUzkS5uEsCac+F45bAMvQV3PS6?=
 =?us-ascii?Q?W4vI2uuleARYyJLccqvIhFiFyacdRxbVYi96DK15FUDN1OkZ02HVwEV/NNc0?=
 =?us-ascii?Q?9zSRTAN66ufvtfD9+fefBSv7ZF+hAkyoT9uS+IxsXfU0LeRHffQLBg04FXdP?=
 =?us-ascii?Q?sXj58pq/hNl4pl1mTyh8gUI1eBtPMXkAiDfPUr8WKjt4HU04ZOIpS3gcmXPF?=
 =?us-ascii?Q?YHS0+orH1CwDJ1qHTdNDklSViMB2/rGuUrdxR2t/fMfAHH3mTA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230037)(36860700010)(376011)(1800799021)(82310400023);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 07:31:28.2949
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 001a3588-afe3-4683-1859-08dc941fa93b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9241

From: Daniel Jurgens <danielj@nvidia.com>

Due a bug in the device max_num_eqs doesn't always reflect a written
value. As a result, setting max_io_eqs may not work but appear
successful. Instead write max_num_eqs_24b, which reflects correct
value.

Fixes: 93197c7c509d ("mlx5/core: Support max_io_eqs for a function")
Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/eswitch_offloads.c     | 22 ++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index 592143d5e1da..72949cb85244 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -4600,20 +4600,26 @@ mlx5_devlink_port_fn_max_io_eqs_get(struct devlink_port *port, u32 *max_io_eqs,
 		return -EOPNOTSUPP;
 	}
 
+	if (!MLX5_CAP_GEN_2(esw->dev, max_num_eqs_24b)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Device doesn't support getting the max number of EQs");
+		return -EOPNOTSUPP;
+	}
+
 	query_ctx = kzalloc(query_out_sz, GFP_KERNEL);
 	if (!query_ctx)
 		return -ENOMEM;
 
 	mutex_lock(&esw->state_lock);
 	err = mlx5_vport_get_other_func_cap(esw->dev, vport_num, query_ctx,
-					    MLX5_CAP_GENERAL);
+					    MLX5_CAP_GENERAL_2);
 	if (err) {
 		NL_SET_ERR_MSG_MOD(extack, "Failed getting HCA caps");
 		goto out;
 	}
 
 	hca_caps = MLX5_ADDR_OF(query_hca_cap_out, query_ctx, capability);
-	max_eqs = MLX5_GET(cmd_hca_cap, hca_caps, max_num_eqs);
+	max_eqs = MLX5_GET(cmd_hca_cap_2, hca_caps, max_num_eqs_24b);
 	if (max_eqs < MLX5_ESW_MAX_CTRL_EQS)
 		*max_io_eqs = 0;
 	else
@@ -4644,6 +4650,12 @@ mlx5_devlink_port_fn_max_io_eqs_set(struct devlink_port *port, u32 max_io_eqs,
 		return -EOPNOTSUPP;
 	}
 
+	if (!MLX5_CAP_GEN_2(esw->dev, max_num_eqs_24b)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Device doesn't support changing the max number of EQs");
+		return -EOPNOTSUPP;
+	}
+
 	if (check_add_overflow(max_io_eqs, MLX5_ESW_MAX_CTRL_EQS, &max_eqs)) {
 		NL_SET_ERR_MSG_MOD(extack, "Supplied value out of range");
 		return -EINVAL;
@@ -4655,17 +4667,17 @@ mlx5_devlink_port_fn_max_io_eqs_set(struct devlink_port *port, u32 max_io_eqs,
 
 	mutex_lock(&esw->state_lock);
 	err = mlx5_vport_get_other_func_cap(esw->dev, vport_num, query_ctx,
-					    MLX5_CAP_GENERAL);
+					    MLX5_CAP_GENERAL_2);
 	if (err) {
 		NL_SET_ERR_MSG_MOD(extack, "Failed getting HCA caps");
 		goto out;
 	}
 
 	hca_caps = MLX5_ADDR_OF(query_hca_cap_out, query_ctx, capability);
-	MLX5_SET(cmd_hca_cap, hca_caps, max_num_eqs, max_eqs);
+	MLX5_SET(cmd_hca_cap_2, hca_caps, max_num_eqs_24b, max_eqs);
 
 	err = mlx5_vport_set_other_func_cap(esw->dev, hca_caps, vport_num,
-					    MLX5_SET_HCA_CAP_OP_MOD_GENERAL_DEVICE);
+					    MLX5_SET_HCA_CAP_OP_MOD_GENERAL_DEVICE2);
 	if (err)
 		NL_SET_ERR_MSG_MOD(extack, "Failed setting HCA caps");
 
-- 
2.31.1


