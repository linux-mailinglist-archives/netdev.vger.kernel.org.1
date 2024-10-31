Return-Path: <netdev+bounces-140719-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6569B7B3C
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 14:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AEDA2860CF
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 13:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7286119D89E;
	Thu, 31 Oct 2024 13:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GTybwIMh"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2069.outbound.protection.outlook.com [40.107.244.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BDC19D091
	for <netdev@vger.kernel.org>; Thu, 31 Oct 2024 13:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730379620; cv=fail; b=rNT2K0tUc0tzGHILl6vM7MOI4Fv48mxxheCRgaaX9Lmuv92wC5195WD13FfbuMuwnZLw7XTCjuvulG147vDf6fmd47zGlrk0XkxbMcwZjPkRSjqva36/faF5yz1vCYjVKqIHp2Mite0n/4Y3m5GLPDW3C3ZTNN1yWkjFyB4JuY4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730379620; c=relaxed/simple;
	bh=y+DH2EfvsfwmMteBTTwqSrIhzKqABHI6FBB03FgoyPk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NRFOA6L6UI9DM8oEGqKVJBbLyqLEcFU/cre+xeiQ/2q6Ojy+gfwou2it7PMyBNiKuKdRx7hqAu62Z5bo0YajMCgAJzNDpwATu7BhPRisv+mmxf4Ywfeq7D0ZXuCeyaRX+67BkdIjw4JR6Crq9a1q641XtcQlPMhlBLQO3M/L9as=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GTybwIMh; arc=fail smtp.client-ip=40.107.244.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P9vlXL49L5fX3PHM4fQx9/2TolJLXzctdFZWuVQjtoFRRkPzbj1XJxozBkuypAstLXQ9xOW+ZCNoE3gHMUYivlct4+doGz9fETFE94b87i/uajl0LlHa0e1uTjw9+r9CEV1W2mWQeEoR+ElNKt1Mn9ejHaBbHpSrMRrk0GCdIFYffyDbuzPttRtkVU18fv/3xw6VtjeUHzLaRqFmOl8L8fhXDF5Wtf9uiGOP25JSQ+3BhJnQU/lXNdxe9egjMpDynyzCfkP8/3pRLWEcv4Wzbf3IUSVuLDfxNcmm+McY4iSsip5t23d7eSMhPrYxiGGrZUXU+6W/33JgRYJXuiBmjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nt2FsRATwimwLze+s3f7Xb4wQwEhRZ35tBEc7ilZsQ0=;
 b=CXci1yWLqNSpYyV8bLX1mEH+64oxqX9sNRFydoznwFiC/HDDRJyLCjJ+mcdbdfZHVguatINdb+y/cGpxkdccdkZzROvYbg4V48ljgBbpyLvs4cogTE5tfvSIpAA4q5jQJx4KQve8oJ46qAKNP/FNaCOZKVYoi6jKXlomZvxBzUT0gCNnRFguQ5Eu4L0h4Rnh6+aumz8uhfHeipk2x0GdgxyWUw4PZXiVtaoPDvQL4bnMgizI0/p8itU2NaQOMicAAVYfTSFVEy5Ow//n8227jU89OKYcdcyg9ngjM1jnQCEKRRZTcQHngbJBB8Hsin3se4sbiFfdmY4tE5A7DjYdSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nt2FsRATwimwLze+s3f7Xb4wQwEhRZ35tBEc7ilZsQ0=;
 b=GTybwIMhpouE3wYRWw6aQ/GtUx5JGvh/wWtTjCLYWdpwqlKKsqbgXsJ9gBbTLxiLb93WtxIM3ZvoBnpG2aFp9gD/kylAPq3+hgpJ/6LKACyn9yEck2DMpKCjdjz3FlD6ei5sGczt6tT9tnQjnPcI/Vj1PM0Fxf8qrKy/n832AzDOUnVF1tPeswGs8bLMHukjft7khefflBHJuUa/zXsLYTYZ/nuzeAj5EnJ2ZQx7lWgKxRvtaWd8hhoosG8BhQ4xh+0L1H7roZa0uL57IGKOCFVYWToK/z5hkv1u1axQVCbGlJC1z/ERwKj8T6s0Vj7PJX+N7grXd3eU5k2XyahIQg==
Received: from CH2PR11CA0026.namprd11.prod.outlook.com (2603:10b6:610:54::36)
 by DM4PR12MB8452.namprd12.prod.outlook.com (2603:10b6:8:184::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.23; Thu, 31 Oct
 2024 13:00:08 +0000
Received: from CH2PEPF00000147.namprd02.prod.outlook.com
 (2603:10b6:610:54:cafe::3d) by CH2PR11CA0026.outlook.office365.com
 (2603:10b6:610:54::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20 via Frontend
 Transport; Thu, 31 Oct 2024 13:00:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH2PEPF00000147.mail.protection.outlook.com (10.167.244.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.16 via Frontend Transport; Thu, 31 Oct 2024 13:00:07 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 31 Oct
 2024 05:59:53 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 31 Oct 2024 05:59:52 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 31 Oct 2024 05:59:49 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, William Tu
	<witu@nvidia.com>, Parav Pandit <parav@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net-next 5/5] net/mlx5e: do not create xdp_redirect for non-uplink rep
Date: Thu, 31 Oct 2024 14:58:56 +0200
Message-ID: <20241031125856.530927-6-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000147:EE_|DM4PR12MB8452:EE_
X-MS-Office365-Filtering-Correlation-Id: 31cf640e-6249-44d5-cc21-08dcf9abf235
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6hdXyia+4hrDhVmUB+Ip/01PeSuLhQp2vXNkJNuGXKJl9bO15lI6eiReldO/?=
 =?us-ascii?Q?fP6R1NePXp1C9Kox+b0KIDP9RtRlyzGK5HwMRtYY8YUjaftMWOa8h3a69jAF?=
 =?us-ascii?Q?p22djIxIPF8cwc/WcTskO7Efnwwqe+xKzaWetRyk8T9+q596hF6AhnntvQfo?=
 =?us-ascii?Q?qlFUUG7+t+G4ICKK/CaIKAFbo3Ci+2kkI/CgVxlXrcnlpQP+lgaZt7e2+Z1X?=
 =?us-ascii?Q?cH+CsBUjQzWYsn1WA7nwJSJKYxCpwfGDfG2Kya/Z7tZ2hwJKSKWy58HtOqea?=
 =?us-ascii?Q?f0PS+xff8cyqdpD0htqLh/AZ/PxbiMhSHwujM4F78rnqlj28izF9t/2UpigI?=
 =?us-ascii?Q?MXcd5y2Zg3KtH/XndN9EaJ/+BhMuR+ZrMAEVa9iF3tmBUv13vuqG2PyPs/qC?=
 =?us-ascii?Q?kB24qGUt80/hIgTNT/YtG7Rx4xlLH6L3nSXGBZQy8J/UHN7OKn/Tuh5g71JH?=
 =?us-ascii?Q?NNUs/yoRILnCN0j0CGcoFEoFkOKx3THC8Omm0VzSj1Ctpl7DAF+NTEcHiGDM?=
 =?us-ascii?Q?F7NglMnvUwe7K9M54f5d3psPGvZUJGIcqBRR9UlO8KwNsTCC6JXjDa0rgRmH?=
 =?us-ascii?Q?iPWJEV14eLEGLjN7B71+Jn989XCxT3USYR5aJ+eZgBvUlJr8wQr7zLWaEcFs?=
 =?us-ascii?Q?tEfTo/sw63mxbGBZZVskPeRHDn2QDl7pJsDLySqscqWrIe88t4eDdPsU/HlI?=
 =?us-ascii?Q?+nFkYJn6zt0ehZPq28qDmvyhWLKYMiWjt4UWWbbQUIeMuG+KBy0wEehO0cXw?=
 =?us-ascii?Q?6r4JvSI7KtrLVraPJCWlrZ7iLUtAVQfW7xLNXLYu4uI8BEw6dwyrEv4Wyb05?=
 =?us-ascii?Q?lVL6jxRb1RTsNr+w0N87ET36MhaAnPQ8ZOe/BaI/vUCdWO/taRCH+g8ryT5Z?=
 =?us-ascii?Q?QNjpMKDCWtqC+MVEXX2Tgnza7j96Yp+iVJ/1x6GGkTAwF/+9+pGfWJwqxN81?=
 =?us-ascii?Q?wInVZmSwsjdKfOZyPYysbMPDSe0TFoxbLKYMMfsNVt8kM8NFne4wOC16dwcN?=
 =?us-ascii?Q?ghCjkMl1VIJ4bJ7EV3b3hOZihDIQWT8BsT41yue/7E1CdtT695KbRZHv97eb?=
 =?us-ascii?Q?KfF0JD0WVVih/vzlGjzsThUyAYt3xEVOJc+WP0XdzVcPX70mRddYQMAW19cC?=
 =?us-ascii?Q?/s2T4evar9qUosbtSMW4GKP80o5HEwG6cOP1UZEE1qPxOk/ANfT12ZZ28glh?=
 =?us-ascii?Q?HAGVp9e6T3SP0xwKEeS0ZzIu59D/VCsijWK0MjMHkxHxOn0CmliEUbgLV7bk?=
 =?us-ascii?Q?l1uQqaFig6i7xIkXzpVADs/J8Vcn6ul600X1QsPkR7PcWSS4tUSqZBkmYbwu?=
 =?us-ascii?Q?d3dkAcS9GglTiNKjrcbeIuf6X9GyvXtVd3PERacS7PpvRJdOiSa3pvbgrcV8?=
 =?us-ascii?Q?efVT2cXWKtSwKILi8S5eDb5EeAfTjkIJsppFS05Exjajp8Cbew=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 13:00:07.6697
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31cf640e-6249-44d5-cc21-08dcf9abf235
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000147.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8452

From: William Tu <witu@nvidia.com>

XDP and XDP socket require extra SQ/RQ/CQs. Most of these resources
are dynamically created: no XDP program loaded, no resources are
created. One exception is the SQ/CQ created for XDP_REDRIECT, used
for other netdev to forward packet to mlx5 for transmit. The patch
disables creation of SQ and CQ used for egress XDP_REDIRECT, by
checking whether ndo_xdp_xmit is set or not.

For netdev without XDP support such as non-uplink representor, this
saves around 0.35MB of memory, per representor netdevice per channel.

Signed-off-by: William Tu <witu@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en_main.c   | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 2f609b92d29b..59d7a0e28f24 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -2514,6 +2514,7 @@ static int mlx5e_open_queues(struct mlx5e_channel *c,
 			     struct mlx5e_params *params,
 			     struct mlx5e_channel_param *cparam)
 {
+	const struct net_device_ops *netdev_ops = c->netdev->netdev_ops;
 	struct dim_cq_moder icocq_moder = {0, 0};
 	struct mlx5e_create_cq_param ccp;
 	int err;
@@ -2534,10 +2535,12 @@ static int mlx5e_open_queues(struct mlx5e_channel *c,
 	if (err)
 		goto err_close_icosq_cq;
 
-	c->xdpsq = mlx5e_open_xdpredirect_sq(c, params, cparam, &ccp);
-	if (IS_ERR(c->xdpsq)) {
-		err = PTR_ERR(c->xdpsq);
-		goto err_close_tx_cqs;
+	if (netdev_ops->ndo_xdp_xmit) {
+		c->xdpsq = mlx5e_open_xdpredirect_sq(c, params, cparam, &ccp);
+		if (IS_ERR(c->xdpsq)) {
+			err = PTR_ERR(c->xdpsq);
+			goto err_close_tx_cqs;
+		}
 	}
 
 	err = mlx5e_open_cq(c->mdev, params->rx_cq_moderation, &cparam->rq.cqp, &ccp,
@@ -2601,7 +2604,8 @@ static int mlx5e_open_queues(struct mlx5e_channel *c,
 	mlx5e_close_cq(&c->rq.cq);
 
 err_close_xdpredirect_sq:
-	mlx5e_close_xdpredirect_sq(c->xdpsq);
+	if (c->xdpsq)
+		mlx5e_close_xdpredirect_sq(c->xdpsq);
 
 err_close_tx_cqs:
 	mlx5e_close_tx_cqs(c);
@@ -2629,7 +2633,8 @@ static void mlx5e_close_queues(struct mlx5e_channel *c)
 	if (c->xdp)
 		mlx5e_close_cq(&c->rq_xdpsq.cq);
 	mlx5e_close_cq(&c->rq.cq);
-	mlx5e_close_xdpredirect_sq(c->xdpsq);
+	if (c->xdpsq)
+		mlx5e_close_xdpredirect_sq(c->xdpsq);
 	mlx5e_close_tx_cqs(c);
 	mlx5e_close_cq(&c->icosq.cq);
 	mlx5e_close_cq(&c->async_icosq.cq);
-- 
2.44.0


