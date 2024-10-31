Return-Path: <netdev+bounces-140718-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 13D8E9B7B3B
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 14:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70446B21F38
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 13:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E966419C56C;
	Thu, 31 Oct 2024 13:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SoVY6J0u"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2040.outbound.protection.outlook.com [40.107.95.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B5F19DFA4
	for <netdev@vger.kernel.org>; Thu, 31 Oct 2024 13:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730379615; cv=fail; b=fI04cjFsBLoOzECSpDez60oFZi/TvPwS+ZC+KkZAhvLfVQCJa4RbcASFT/j/ft474RNYQRilc+FdoYUNeX0FKYMEJAt1FAqFK58ij0HdTlB4uh0GjKXgfJwg1PouYWhs7axe+72NC1Wv2QoM6OIAT9vxGUDIzoDRtz1fSNrag3w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730379615; c=relaxed/simple;
	bh=ao5UXs+XgmqyytN6QQhu8NA9um46yaUMUeao8OJELCQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tBJ9MIyUoOY39GDLHyjYz1oPY0whHNrbyDHXgtvWyeO+qO/+RR670KbB8Ut8491o/4KE/LlKNrIFg08qbKB9sa+FmYSHy3lW+vDzAdHO3P49ZFYlweFZKuzKOXlXo1s+IGOHi23Cjc81aSmm+V6fPn677tFeOIWfs5az8Shgh/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SoVY6J0u; arc=fail smtp.client-ip=40.107.95.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c6j5PnXAENKsc/V8RM24d7HGwk/lZ7wf5vGTyyJk63UX4MdaL07BXLnPQ9YqvBaCGpMnmuKOklbWzQS9+gT4iHP7wSNRH8vC5joZTtqBjXKqs9pU7RaUcAd+piEg7SW4gBB06dDF42Wm3uRdGHbWAkonm529gc6uNzvY9uN3ycJChA08/W2j5/OsBX53mmsDpI9pRV8i2DqsUjZasEXqk9+RQB/aCziuyV1bFFLtr9k4+y6HuMMXEYr1DQrPL1hk15dhXcub2N/U2op4ej5n2GgTAJ1itRSrPaZM5J1IeDnN1QbCyACy24RvfkwMKnUh7musttggwExKCko1vl2vqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fmDqfN5HpKTXnZp5AxPQ6xIvMDbx1E/RNa4Jbet3TO4=;
 b=ZU8KuuEOv86sjrQ8jfSiye4kIxyVtzUMNImmbTO5LRxiCWKi33xqItKVlc4iPP8/IJgRKNdVbxiBfXoEU+6fv6QSzfVE1W4byZY2xC8TG525CHvAc7RrH4o84MaHmTcw/FuY6benmipZVmq0+AzTDecNjHgBdJuvfYjZL2NHF8NIXtXv50otYUomNnZ/msVmmPUlWvj4DkIdmPOkEsj1BaxTpWryvyWNLTrKeY0jVPg8kTZPpZCackblkNuGv4UMTQERcrGo7jWrXaIiHGg1vmRVLqvGmYFE3o2VB/nY8NmGEZYXovszxZ9ce0ZoBF8/DJIc66T8qnKwJchMHkkbNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fmDqfN5HpKTXnZp5AxPQ6xIvMDbx1E/RNa4Jbet3TO4=;
 b=SoVY6J0uovIFBH/D0bMtavcY5oKHSBLEtD/jzFailrXxKEXi62XzISB5/Q/Cm1KFdIS9lTjE7AYiRdvjd59JckAFrUlbh48x6ZjLFk5ErafTGKh0cSct4wPYezoOndehSaF/36vU2+K08VjhohJ1Upxppabs1nA/CkQJfpcix9mgYrMsBHGQXfZDSw7JYZ4/IojYk94ABDMyI7wXT/uJvpPypvaf9PRFlFYthBn+5Mg8J0tPun6GwXMVkGPQAhGbOmFjXsx8i3RhurxW1hnzvmEq27ooV6IqWq7dg1L+243QDlbIjkWCK9VXQ7M5d6uJf+kcRBJ7QrUapxJD6Rb9dQ==
Received: from CH0P221CA0035.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11d::22)
 by DM4PR12MB6640.namprd12.prod.outlook.com (2603:10b6:8:8f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Thu, 31 Oct
 2024 13:00:08 +0000
Received: from DS2PEPF0000343D.namprd02.prod.outlook.com
 (2603:10b6:610:11d:cafe::fe) by CH0P221CA0035.outlook.office365.com
 (2603:10b6:610:11d::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.17 via Frontend
 Transport; Thu, 31 Oct 2024 13:00:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS2PEPF0000343D.mail.protection.outlook.com (10.167.18.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.16 via Frontend Transport; Thu, 31 Oct 2024 13:00:07 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 31 Oct
 2024 05:59:49 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 31 Oct 2024 05:59:49 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 31 Oct 2024 05:59:46 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, William Tu
	<witu@nvidia.com>, Parav Pandit <parav@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net-next 4/5] net/mlx5e: move XDP_REDIRECT sq to dynamic allocation
Date: Thu, 31 Oct 2024 14:58:55 +0200
Message-ID: <20241031125856.530927-5-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343D:EE_|DM4PR12MB6640:EE_
X-MS-Office365-Filtering-Correlation-Id: 80f62d16-e034-4418-a843-08dcf9abf20b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+cI4/UNh9xx1kvU+bC/pEy0eQZ7KhOP+5R14en92nhIaDSTMhePFB+n3DPdW?=
 =?us-ascii?Q?4xG61wrOtGWutkgCsVrnTE5ky4B9B0IhbOd1HbaLn7o6FydA94gmAfOqH70d?=
 =?us-ascii?Q?93Au82VEH6UY+DJQqM+a4vCpUGW8ZbFchJs5Kygfpd851Rp87qQF0rvHhZfq?=
 =?us-ascii?Q?sXCqpDWhMwZO5+SY48zR85eDm4u2QEJSLf0sB0TkZAa+CNCwXbTbMam0Obih?=
 =?us-ascii?Q?VruHTRZKU3Ym+Xzu5sJr+Y4S9yR7iwKgEzcCBrc+LR2LtFL871hX9ETfkUy+?=
 =?us-ascii?Q?vditRPnZbGWw+q8ng9IfRCDuAy+g/bo7M3QMqcp5PUg1cWnlgltFFeDkk1oN?=
 =?us-ascii?Q?1IFHmSdOZ5eunE6am4mJ1clgGO2LPSY3AF5WBORspmzLWOSngGcvknEzw8wf?=
 =?us-ascii?Q?xirGfw0gh51zrrhF6gK0qSrjSondooEykE282/CfdByv3+Nr1mQJd2kyF/d8?=
 =?us-ascii?Q?Sxnd0lfJ8W66I6hCFWgsHEAEEeTDBzzEsyKsCPYPZdXBSlqgjFW2vnyijtYX?=
 =?us-ascii?Q?nFbJhs9DaGTbRDC56aaQ1TYKW9+s32lUyzo5Guu0HNjwFwQR3icVAOJZEVec?=
 =?us-ascii?Q?v8AFjAa0bcvujtynKIRXz2PE5FSkjmdbm7osTSw/7cGlu+Z7s6NMXS2XGTK2?=
 =?us-ascii?Q?oej4anwIU/2RFt6eVNHxEvr5XeyvrA0ddJAgjjVHCU4++nVfqMNeebK/rzir?=
 =?us-ascii?Q?2O9FxvkfSz0eLQVMV97C8JD/6TqF7pdnvwv8WO2q76dqy/nXBdyJmsXqVBxg?=
 =?us-ascii?Q?1opWsrIm3o0tGnpyH4E/lzz6bB7EQEtHRwdKlCifLjaDesuMbqTF60fSoJnJ?=
 =?us-ascii?Q?mc4jFX+QC1z5Z6xXJrxR2xocopFlCtUjJF+UwxjnB4bBxuiFybQ0cqOvpWbN?=
 =?us-ascii?Q?p/QY23zOO2MVR+b1HpC6ytDgVitXVBkbnbJtKKaEgQklGZh8NI76WIVODVrG?=
 =?us-ascii?Q?qMZCWwFe7EkuLt35nE1AW30qqYbLhLqRRfvF7AEPun0oYynvXXAHFrU1pwTc?=
 =?us-ascii?Q?NMUIaQRNg/8LhiyRWPJQHa8YIX5gU7hrC/r/c0fLAYr1UivU7+B2GDrtYJh1?=
 =?us-ascii?Q?nLfUFhYwcYje5oszCkDKr7G69IF3H2eKnbSfcYhXPLDzP0ZjuhL2FVBHlbGu?=
 =?us-ascii?Q?IguWQ0QrfkFG3sRV4jHyI3ycUeNQInvucnIAkTGGQX0cu/XCWcvYswup+s4F?=
 =?us-ascii?Q?rNg8uiTA8fcCTb6C+z1r33A8HPZGBSAo2H8qSiUnJocZ1PZGpYv045WyzONz?=
 =?us-ascii?Q?ul45HJuI1ipqvjDlE+nev59aJwqqP2+VnnthKvCdLzF9zmBw7y7oKg9+tyVk?=
 =?us-ascii?Q?pSF+kKFlD56os8AY6uDqUXDtktyzE+jS5lRPDk1x5E35CcovJoGhnoZ/gmhj?=
 =?us-ascii?Q?Vl9s2mbZ9xuFoYDABUy3buA6L9TIfvXVzNoZC1sOyw3e/L4GJw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 13:00:07.3935
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80f62d16-e034-4418-a843-08dcf9abf20b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6640

From: William Tu <witu@nvidia.com>

Dynamically allocating xdpsq, used by egress side XDP_REDIRECT.
mlx5 has multiple XDP sqs. Under struct mlx5e_channel:
1. rx_xdpsq: used for XDP_TX, an XDP prog handles the rx packet and
transmits using the same queue as rx.
2. xdpsq: used by egress side XDP_REDIRECT. This is for another interface
to redirect packet to the mlx5 interface, using ndo_xdp_xmit .
3. xsksq: used by XSK. XSK has its own dedicated channel, and it also
has resources of 1 and 2.

The patch changes only the 2. xdpsq.

Signed-off-by: William Tu <witu@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |  2 +-
 .../net/ethernet/mellanox/mlx5/core/en/xdp.c  |  2 +-
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 66 ++++++++++++++-----
 .../net/ethernet/mellanox/mlx5/core/en_rep.c  |  3 +-
 .../net/ethernet/mellanox/mlx5/core/en_txrx.c |  6 +-
 5 files changed, 56 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index 57b7298a0e79..58f3df784ded 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -755,7 +755,7 @@ struct mlx5e_channel {
 	u8                         lag_port;
 
 	/* XDP_REDIRECT */
-	struct mlx5e_xdpsq         xdpsq;
+	struct mlx5e_xdpsq        *xdpsq;
 
 	/* AF_XDP zero-copy */
 	struct mlx5e_rq            xskrq;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
index 4610621a340e..94b291662087 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c
@@ -865,7 +865,7 @@ int mlx5e_xdp_xmit(struct net_device *dev, int n, struct xdp_frame **frames,
 	if (unlikely(sq_num >= priv->channels.num))
 		return -ENXIO;
 
-	sq = &priv->channels.c[sq_num]->xdpsq;
+	sq = priv->channels.c[sq_num]->xdpsq;
 
 	for (i = 0; i < n; i++) {
 		struct mlx5e_xmit_data_frags xdptxdf = {};
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index f37afa52e2b8..2f609b92d29b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -2086,6 +2086,44 @@ void mlx5e_close_xdpsq(struct mlx5e_xdpsq *sq)
 	mlx5e_free_xdpsq(sq);
 }
 
+static struct mlx5e_xdpsq *mlx5e_open_xdpredirect_sq(struct mlx5e_channel *c,
+						     struct mlx5e_params *params,
+						     struct mlx5e_channel_param *cparam,
+						     struct mlx5e_create_cq_param *ccp)
+{
+	struct mlx5e_xdpsq *xdpsq;
+	int err;
+
+	xdpsq = kvzalloc_node(sizeof(*xdpsq), GFP_KERNEL, c->cpu);
+	if (!xdpsq)
+		return ERR_PTR(-ENOMEM);
+
+	err = mlx5e_open_cq(c->mdev, params->tx_cq_moderation,
+			    &cparam->xdp_sq.cqp, ccp, &xdpsq->cq);
+	if (err)
+		goto err_free_xdpsq;
+
+	err = mlx5e_open_xdpsq(c, params, &cparam->xdp_sq, NULL, xdpsq, true);
+	if (err)
+		goto err_close_xdpsq_cq;
+
+	return xdpsq;
+
+err_close_xdpsq_cq:
+	mlx5e_close_cq(&xdpsq->cq);
+err_free_xdpsq:
+	kvfree(xdpsq);
+
+	return ERR_PTR(err);
+}
+
+static void mlx5e_close_xdpredirect_sq(struct mlx5e_xdpsq *xdpsq)
+{
+	mlx5e_close_xdpsq(xdpsq);
+	mlx5e_close_cq(&xdpsq->cq);
+	kvfree(xdpsq);
+}
+
 static int mlx5e_alloc_cq_common(struct mlx5_core_dev *mdev,
 				 struct net_device *netdev,
 				 struct workqueue_struct *workqueue,
@@ -2496,15 +2534,16 @@ static int mlx5e_open_queues(struct mlx5e_channel *c,
 	if (err)
 		goto err_close_icosq_cq;
 
-	err = mlx5e_open_cq(c->mdev, params->tx_cq_moderation, &cparam->xdp_sq.cqp, &ccp,
-			    &c->xdpsq.cq);
-	if (err)
+	c->xdpsq = mlx5e_open_xdpredirect_sq(c, params, cparam, &ccp);
+	if (IS_ERR(c->xdpsq)) {
+		err = PTR_ERR(c->xdpsq);
 		goto err_close_tx_cqs;
+	}
 
 	err = mlx5e_open_cq(c->mdev, params->rx_cq_moderation, &cparam->rq.cqp, &ccp,
 			    &c->rq.cq);
 	if (err)
-		goto err_close_xdp_tx_cqs;
+		goto err_close_xdpredirect_sq;
 
 	err = c->xdp ? mlx5e_open_cq(c->mdev, params->tx_cq_moderation, &cparam->xdp_sq.cqp,
 				     &ccp, &c->rq_xdpsq.cq) : 0;
@@ -2516,7 +2555,7 @@ static int mlx5e_open_queues(struct mlx5e_channel *c,
 	err = mlx5e_open_icosq(c, params, &cparam->async_icosq, &c->async_icosq,
 			       mlx5e_async_icosq_err_cqe_work);
 	if (err)
-		goto err_close_xdpsq_cq;
+		goto err_close_rq_xdpsq_cq;
 
 	mutex_init(&c->icosq_recovery_lock);
 
@@ -2540,16 +2579,8 @@ static int mlx5e_open_queues(struct mlx5e_channel *c,
 			goto err_close_rq;
 	}
 
-	err = mlx5e_open_xdpsq(c, params, &cparam->xdp_sq, NULL, &c->xdpsq, true);
-	if (err)
-		goto err_close_xdp_sq;
-
 	return 0;
 
-err_close_xdp_sq:
-	if (c->xdp)
-		mlx5e_close_xdpsq(&c->rq_xdpsq);
-
 err_close_rq:
 	mlx5e_close_rq(&c->rq);
 
@@ -2562,15 +2593,15 @@ static int mlx5e_open_queues(struct mlx5e_channel *c,
 err_close_async_icosq:
 	mlx5e_close_icosq(&c->async_icosq);
 
-err_close_xdpsq_cq:
+err_close_rq_xdpsq_cq:
 	if (c->xdp)
 		mlx5e_close_cq(&c->rq_xdpsq.cq);
 
 err_close_rx_cq:
 	mlx5e_close_cq(&c->rq.cq);
 
-err_close_xdp_tx_cqs:
-	mlx5e_close_cq(&c->xdpsq.cq);
+err_close_xdpredirect_sq:
+	mlx5e_close_xdpredirect_sq(c->xdpsq);
 
 err_close_tx_cqs:
 	mlx5e_close_tx_cqs(c);
@@ -2586,7 +2617,6 @@ static int mlx5e_open_queues(struct mlx5e_channel *c,
 
 static void mlx5e_close_queues(struct mlx5e_channel *c)
 {
-	mlx5e_close_xdpsq(&c->xdpsq);
 	if (c->xdp)
 		mlx5e_close_xdpsq(&c->rq_xdpsq);
 	/* The same ICOSQ is used for UMRs for both RQ and XSKRQ. */
@@ -2599,7 +2629,7 @@ static void mlx5e_close_queues(struct mlx5e_channel *c)
 	if (c->xdp)
 		mlx5e_close_cq(&c->rq_xdpsq.cq);
 	mlx5e_close_cq(&c->rq.cq);
-	mlx5e_close_cq(&c->xdpsq.cq);
+	mlx5e_close_xdpredirect_sq(c->xdpsq);
 	mlx5e_close_tx_cqs(c);
 	mlx5e_close_cq(&c->icosq.cq);
 	mlx5e_close_cq(&c->async_icosq.cq);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
index 92094bf60d59..554f9cb5b53f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
@@ -600,7 +600,8 @@ mlx5e_add_sqs_fwd_rules(struct mlx5e_priv *priv)
 			if (c->xdp)
 				sqs[num_sqs++] = c->rq_xdpsq.sqn;
 
-			sqs[num_sqs++] = c->xdpsq.sqn;
+			if (c->xdpsq)
+				sqs[num_sqs++] = c->xdpsq->sqn;
 		}
 	}
 	if (ptp_sq) {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
index 5873fde65c2e..3a12a933ed87 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
@@ -165,7 +165,8 @@ int mlx5e_napi_poll(struct napi_struct *napi, int budget)
 	if (unlikely(!budget))
 		goto out;
 
-	busy |= mlx5e_poll_xdpsq_cq(&c->xdpsq.cq);
+	if (c->xdpsq)
+		busy |= mlx5e_poll_xdpsq_cq(&c->xdpsq->cq);
 
 	if (c->xdp)
 		busy |= mlx5e_poll_xdpsq_cq(&c->rq_xdpsq.cq);
@@ -236,7 +237,8 @@ int mlx5e_napi_poll(struct napi_struct *napi, int budget)
 	mlx5e_cq_arm(&rq->cq);
 	mlx5e_cq_arm(&c->icosq.cq);
 	mlx5e_cq_arm(&c->async_icosq.cq);
-	mlx5e_cq_arm(&c->xdpsq.cq);
+	if (c->xdpsq)
+		mlx5e_cq_arm(&c->xdpsq->cq);
 
 	if (xsk_open) {
 		mlx5e_handle_rx_dim(xskrq);
-- 
2.44.0


