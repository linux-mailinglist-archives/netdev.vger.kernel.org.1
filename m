Return-Path: <netdev+bounces-148682-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C3BE9E2E77
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 22:55:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10883B345C0
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 20:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAEF3205E1C;
	Tue,  3 Dec 2024 20:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Mt+K7SKA"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE2B1D79A0
	for <netdev@vger.kernel.org>; Tue,  3 Dec 2024 20:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733259037; cv=fail; b=M9EyEawF7GMepH8nJFPy58zFC6jv27U/mrRWjlzpTD01CCUXdLWzq6cyH4CA3I1Jrq9jUTuL63t0NrNNGRUVY3zE54j/1JGnLwXD/snPVN3MX7a0wF86+Wu4/SpvzvShxoTEmlCB18sKGmZxuAES9nxIfnSCUMd3ZTn+FdTN/Mc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733259037; c=relaxed/simple;
	bh=dIy19cxv1jY8jGSsADt+UmVp+zkSj2+DGqjhFyDqh2s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CWbYcU03bQvkNy4O3vqDN+F2q+wq8Nj+gDkbzvMTm+XavNBxCxSknyJzWz+ljUGVv5zO4bwWHSrhuU2KtsPK5iSMcccVHbO5RUpQw0NBdf4S81R4tw65pBKbWDIewE7FxL2sawLhw95PO/3/G5Ow110oh3+dFwJfQzf5f/YDwks=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Mt+K7SKA; arc=fail smtp.client-ip=40.107.220.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MTmKg02wscwQGtyzifS6MflILAo1Iqwc+lqO1/8T0Ww7o4W/o+6puH0ub43brjirPd/PDxMBk9y+Z8mW2JdHn/Z3VdHzGOzbemOpjl0fLFOjHmuO5z6mHDqIakDDi+uAOAncmSImjqchvYnqxfR8y8FL5T70xob13taw6oDTDNOgBs6eMAXr3HJLFV+6wIKMk66coLZiTwA9WoPqJXdHQTw1mt1ooSlmRefoq/WA3Qqbqe0hHjkgQ5YPMiIhApXprCvKf4OCdWJ9rvJ/RgZ+y1NVXbb25TvfM/QbMa39sXm8VAP5BWMu0oDJt/ysoLD0mXM3Ef5aRGw298NXqkS7Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EfiUDM1/vy9D7v2Z/solIi9QNNAH0ekD3nAFAcRaHYk=;
 b=LPBD4k4XmKHwfm4B9EFX3pFrNKpMqHfk3Pq92ackPUkU+fxVFKShPYlTSQOKwuXNYD3bYqSLUXHWF5z1v0cRdAh7y/2kBu28xrnmRlw4/riImV0VMhfgBiHmHSqXjUa+Vvc87XPw9mBgqEN3v9JMV4pqVDkFY+NgiwxQqsOkpws8Hj+G11K/FQdox5vZEsT3W/xwYK9xbBTzsX1kEmA+uKyoUc2TekzLj/CqtHLxN3mbLc/IIMQPIjnibs0/q0NEWgw2OxWCTgf+hOyIS9iVSNXe69EjDGitdQekU/3nF3LXphWqgXLnTnlcs87uE2NipW/GLtJ7Oc/zjuX8OK0aqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EfiUDM1/vy9D7v2Z/solIi9QNNAH0ekD3nAFAcRaHYk=;
 b=Mt+K7SKAk0351KRt8ZceKCzlZHVx8oZeIK81JKDMY213hJ3QmhjsiaJLwjxh3wi01n/pisRWQNf223ACXS9vh4lrY/q68q3cQWRcgXi3hq40q3DOYMrLFsshYeVgK11TGyM/Pxdte6FYcS285qO/r5YGurtYV9+04yyYcQqQ9pRagZNzhmVU3FuO8St0IGM9Bp6d6RIsZyu+/8DKGezmqKr0OcPdmP50olqFNTJxQTiwbyrvg2capHDQPM8EIsCQg7JuR4kGp1vykz+OSkR11WOVOXhPubUsAeh0Cn9CH1R22mLFDMzdXtg9GepTCnu8thuRmb10k3tbvhRX8JOoAQ==
Received: from CH3P220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1e8::26)
 by CH0PR12MB8577.namprd12.prod.outlook.com (2603:10b6:610:18b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Tue, 3 Dec
 2024 20:50:29 +0000
Received: from CH1PEPF0000AD7A.namprd04.prod.outlook.com
 (2603:10b6:610:1e8:cafe::53) by CH3P220CA0011.outlook.office365.com
 (2603:10b6:610:1e8::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.18 via Frontend Transport; Tue,
 3 Dec 2024 20:50:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000AD7A.mail.protection.outlook.com (10.167.244.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.7 via Frontend Transport; Tue, 3 Dec 2024 20:50:28 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 3 Dec 2024
 12:50:10 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 3 Dec 2024
 12:50:10 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Tue, 3 Dec
 2024 12:50:06 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>, Lama Kayal <lkayal@nvidia.com>
Subject: [PATCH net 5/6] net/mlx5e: SD, Use correct mdev to build channel param
Date: Tue, 3 Dec 2024 22:49:19 +0200
Message-ID: <20241203204920.232744-6-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241203204920.232744-1-tariqt@nvidia.com>
References: <20241203204920.232744-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7A:EE_|CH0PR12MB8577:EE_
X-MS-Office365-Filtering-Correlation-Id: d1081bf0-caaf-4ee2-349e-08dd13dc1f02
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bcdGCyNrJxipp522y9TdxukbTQ0wIYQSfGh17ROk9qlRtX/ifmKqJQ5gt32m?=
 =?us-ascii?Q?9WoQ94sxQLF9tupb6srINrD1UGgw3KXrp3l2Trxf/q+ztSCsZzZlq2nMGXxg?=
 =?us-ascii?Q?MtF346GYn4t0McJIGNjOOX+n+xsINDnkYrdsJHVVcE+Pmu9avlUUL2Pv2bKN?=
 =?us-ascii?Q?DjRheL6dJoIjhAR/RkXJtRNCmaGJQyUQ5SRWI44LxdkVn/doQpIbA1FVOTkN?=
 =?us-ascii?Q?fvh5gSOxnWvFdaGx97uQfqiczCdRJNbAppvhCfcEjBw4tCWiUtDEDBC2HJU3?=
 =?us-ascii?Q?1yDMSAFqzwEA6to3NwRZLky+G47gwAGIV4WQTa7rqHq9p1gMIoTsJpUzn1uP?=
 =?us-ascii?Q?leu43V/NZQQ8ZGrx8DYXB/xMdu0iXDKY3cQP08iMSXGI87XN1KJko6VEzC6q?=
 =?us-ascii?Q?j/QRMdz/EJ6v4XevkvZ+r/ro1X0G7jAGEb3CDJrF58U8OaM/BQXa0NzeTV7Y?=
 =?us-ascii?Q?oMP5b47l9T8CWgIK5h7AUoud8Bvh8vu2hnOU86PJQokkCpjp8hnv13vZXDsN?=
 =?us-ascii?Q?NSh9ZJztfOn5mDLicJzGYUtDFW6Rnb3wKKHWKU+slaSoRx6QjsiViEpHqye+?=
 =?us-ascii?Q?3pdc8l9pqUu95YdnIctXHllroQoipWB6I2YiIOSGnyvhqyxFAuzLTPxn28iN?=
 =?us-ascii?Q?NtiO0IkRj4/k9fuBXdvjUXqcBnP8gdsWG184ngjOUoBGTCIc2gHUv0awYXNV?=
 =?us-ascii?Q?I5QoHT3rOMCwhkQa7dAFXoKrRCzafcDjoA9Uhs1APRKu5amtcdRSsFSlCceA?=
 =?us-ascii?Q?/ry/To8CpclBsXdaArs/ATn+OLi5L2FWKTjvWACexPJj34vfhd8CFn7XRl1z?=
 =?us-ascii?Q?oWscV+FjGKBom/SvfRRC1pM2Eemq4Pd4VoqFPlZriDg2mL8UOFTFipSOgP2g?=
 =?us-ascii?Q?RjMzF1nboTqEvkCfXR6mGHeDxk5N5oHXTetXYs/ND8HZR3R4yDfJEoQhGkIb?=
 =?us-ascii?Q?fDeLZjsmXoppy6J/oV4ouXZvGSXsne62MWmuXkwmkp/XtqrB5o9GR3zRjD8Z?=
 =?us-ascii?Q?YUBKnQFiJ6WguPInT0NqNKevd1BllK4WUbkIfxBsRTyRJiU5M5KS0DlI01/Y?=
 =?us-ascii?Q?lUilPAcO6qdMAo10UYwK1/o9GwozJCbW46D4KamK4nOh+ANH833Tb9NYM2No?=
 =?us-ascii?Q?79UQsQff17AFBkRZJoT896AbPHYrJ1XlLUvQNU+mrfz+Q4dODUS6GQ5SPGEM?=
 =?us-ascii?Q?BTUoAlCW4kNXy4BTjgNw6zmbpwpnCw6tsgEx3uP3A/oqiMXkrhnPqjd2RB5l?=
 =?us-ascii?Q?VS9ETGJxClRPdllUG3HnWX0c/mjuIxONeXqNVaxyh1wNzNLSvEok/330XG8o?=
 =?us-ascii?Q?Gm+CEJo974CpdaUcAcGXIgMpEaJgBQSCvii+0LrhDtLnDI8OBVUrdeNM7Uh5?=
 =?us-ascii?Q?C6cN/PAYY1i0YGppzOXkbzcTmHda0BewdvPiXHVrIXOUqOWBSZVyMb3C0vSh?=
 =?us-ascii?Q?e4j1XOuxuzEzuWrsSHkNKAsUP33Q5wxU?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 20:50:28.8262
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1081bf0-caaf-4ee2-349e-08dd13dc1f02
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8577

In a multi-PF netdev, each traffic channel creates its own resources
against a specific PF.
In the cited commit, where this support was added, the channel_param
logic was mistakenly kept unchanged, so it always used the primary PF
which is found at priv->mdev.
In this patch we fix this by moving the logic to be per-channel, and
passing the correct mdev instance.

This bug happened to be usually harmless, as the resulting cparam
structures would be the same for all channels, due to identical FW logic
and decisions.
However, in some use cases, like fwreset, this gets broken.

This could lead to different symptoms. Example:
Error cqe on cqn 0x428, ci 0x0, qn 0x10a9, opcode 0xe, syndrome 0x4,
vendor syndrome 0x32

Fixes: e4f9686bdee7 ("net/mlx5e: Let channels be SD-aware")
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Lama Kayal <lkayal@nvidia.com>
Reviewed-by: Gal Pressman <gal@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 32 ++++++++++---------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index d0b80b520397..dd16d73000c3 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -2680,11 +2680,11 @@ void mlx5e_trigger_napi_sched(struct napi_struct *napi)
 
 static int mlx5e_open_channel(struct mlx5e_priv *priv, int ix,
 			      struct mlx5e_params *params,
-			      struct mlx5e_channel_param *cparam,
 			      struct xsk_buff_pool *xsk_pool,
 			      struct mlx5e_channel **cp)
 {
 	struct net_device *netdev = priv->netdev;
+	struct mlx5e_channel_param *cparam;
 	struct mlx5_core_dev *mdev;
 	struct mlx5e_xsk_param xsk;
 	struct mlx5e_channel *c;
@@ -2706,8 +2706,15 @@ static int mlx5e_open_channel(struct mlx5e_priv *priv, int ix,
 		return err;
 
 	c = kvzalloc_node(sizeof(*c), GFP_KERNEL, cpu_to_node(cpu));
-	if (!c)
-		return -ENOMEM;
+	cparam = kvzalloc(sizeof(*cparam), GFP_KERNEL);
+	if (!c || !cparam) {
+		err = -ENOMEM;
+		goto err_free;
+	}
+
+	err = mlx5e_build_channel_param(mdev, params, cparam);
+	if (err)
+		goto err_free;
 
 	c->priv     = priv;
 	c->mdev     = mdev;
@@ -2741,6 +2748,7 @@ static int mlx5e_open_channel(struct mlx5e_priv *priv, int ix,
 
 	*cp = c;
 
+	kvfree(cparam);
 	return 0;
 
 err_close_queues:
@@ -2749,6 +2757,8 @@ static int mlx5e_open_channel(struct mlx5e_priv *priv, int ix,
 err_napi_del:
 	netif_napi_del(&c->napi);
 
+err_free:
+	kvfree(cparam);
 	kvfree(c);
 
 	return err;
@@ -2807,20 +2817,14 @@ static void mlx5e_close_channel(struct mlx5e_channel *c)
 int mlx5e_open_channels(struct mlx5e_priv *priv,
 			struct mlx5e_channels *chs)
 {
-	struct mlx5e_channel_param *cparam;
 	int err = -ENOMEM;
 	int i;
 
 	chs->num = chs->params.num_channels;
 
 	chs->c = kcalloc(chs->num, sizeof(struct mlx5e_channel *), GFP_KERNEL);
-	cparam = kvzalloc(sizeof(struct mlx5e_channel_param), GFP_KERNEL);
-	if (!chs->c || !cparam)
-		goto err_free;
-
-	err = mlx5e_build_channel_param(priv->mdev, &chs->params, cparam);
-	if (err)
-		goto err_free;
+	if (!chs->c)
+		goto err_out;
 
 	for (i = 0; i < chs->num; i++) {
 		struct xsk_buff_pool *xsk_pool = NULL;
@@ -2828,7 +2832,7 @@ int mlx5e_open_channels(struct mlx5e_priv *priv,
 		if (chs->params.xdp_prog)
 			xsk_pool = mlx5e_xsk_get_pool(&chs->params, chs->params.xsk, i);
 
-		err = mlx5e_open_channel(priv, i, &chs->params, cparam, xsk_pool, &chs->c[i]);
+		err = mlx5e_open_channel(priv, i, &chs->params, xsk_pool, &chs->c[i]);
 		if (err)
 			goto err_close_channels;
 	}
@@ -2846,7 +2850,6 @@ int mlx5e_open_channels(struct mlx5e_priv *priv,
 	}
 
 	mlx5e_health_channels_update(priv);
-	kvfree(cparam);
 	return 0;
 
 err_close_ptp:
@@ -2857,9 +2860,8 @@ int mlx5e_open_channels(struct mlx5e_priv *priv,
 	for (i--; i >= 0; i--)
 		mlx5e_close_channel(chs->c[i]);
 
-err_free:
 	kfree(chs->c);
-	kvfree(cparam);
+err_out:
 	chs->num = 0;
 	return err;
 }
-- 
2.44.0


