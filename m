Return-Path: <netdev+bounces-143037-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B31579C0F3A
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 20:45:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72E11285044
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 19:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA3B217F4E;
	Thu,  7 Nov 2024 19:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tk6wZQfI"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2043.outbound.protection.outlook.com [40.107.95.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908E82178E3
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 19:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731008741; cv=fail; b=A1SXFWTYWl+zuYawiWlP8QkePjgsnVEfG1iTugoRGwaK9ax0mJwYE0oNxBMHGICGyNTQa3ZdErHX40nIy8zJNB7caovrecwmc6fCHv0qCatLAW8VifOWZRaYTWDxCtb1hakbN3C3rPlv6X3cbUZwXE4PJj+YB1Oa+Q35KG4VAEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731008741; c=relaxed/simple;
	bh=vZGLG701nIsfPGXOatFMvtM9U1pVEI76JV3gMHpjAk8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uRfiKoBDvxd/xYlpLTMF2GxTlFBz5MQ+pmSCMj+sCwfiUJHybx7isFodxDgHl31GhUUtVhaUNihX8OUKPkkCzYMAROTUNc7/dgEEvMAJe/H2LHQc18O/LaLiMTwC/LhbRd9SI4rVnib0VDTG2PM4Gls3bOJc1HjVXXvQleiKzeg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tk6wZQfI; arc=fail smtp.client-ip=40.107.95.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nNYiVAqzOQ6KVJHMoC1jP5rvju+fNG1OtLCFdGaIzdmwaFFTPINTj9W8d2Z9n6MZO3MNHyXk3invc0+bvVU9mszq3sXo8feuaqSgCwgnCPWC6pXFNy6M1SLnQ78jBuhQYwYBVTa99KwuQagjiT7GeSHMd6UIlVE2vvfz7/PHhoMK4jHrpD/lgDPr8F/dGW36v4NeNYjiQS0CeegtYner1jQIiVpfr38Jv8/MJv/X5GfABDlWS3j7zoffFt1+8qysSiwWYWbSP7qib58ArbywyhNwWLDtydMtD39mfShYhNxdl033WQYGPtnTtcDt7KPHaVrpKA66QA7Fob3S5NRpJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ze/YAgOiT3f7xxmxctjgl3k/R1013GOZ8rgNsTKJLWM=;
 b=ZYAPhk+HBdkNwPRR0JENJAGKwfokAKXXLNoKoRD/kB4AWeWjawrey8bkIGugEP9ZGCOqy8vofdBZOE9EyU95Ib1PHyRrmpLXMbMXt6r/uILrXeAVsvuv99hl/Hh+QQxoU1cR+UYwWRwyETUiMzahQQXfIpnKLs3LrEnoXgdQ1WLu+B5RzBBMABciq/eOtQQcoSytrVysZFG7Uu1tkQ4CzEUafbzloiL3UOq6f4D/dcwJw31Dvtu5ciEnej2uFQNbwDx5EWCnZvomHkz9b1ieBp1b7UHx6wIQEyL6+w0DIPv67nuepJF1/sABkrtf0LQL5PDICBAJ9muMyszS3cR89w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ze/YAgOiT3f7xxmxctjgl3k/R1013GOZ8rgNsTKJLWM=;
 b=tk6wZQfIES2pDx0Ln1ogNbV5A24yzGArJ4U/wPIlRSRHdZFgsKNw36SvJjpU6mnot+HEKkY1/B9JyPvaDVAcW4hagLv+K30fXz1oRQBHM0yzJm3VcCSDgPB7iUHzlz2S6D8t70G/Ngz+KlU6NbKCCKpv9DKgQ3LXNcPfpiiA6vk1O2a5VOwNu/tTQa5ipI4asIbIvqz6tZYemTScd8TkJYkrLW89rwHOUfrINPtUN0QsRaXnI3KwMET5+dX8xTWyMpsek+HRPBvM0WwYHYKe/PZWDtFCzmH5lGUTs4yx9yyuyr+6P+uj7lS8cleI0m1bdwXCPZNIsNqBW1gPsA710w==
Received: from DS7PR05CA0060.namprd05.prod.outlook.com (2603:10b6:8:2f::13) by
 MW4PR12MB6802.namprd12.prod.outlook.com (2603:10b6:303:20f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31; Thu, 7 Nov
 2024 19:45:35 +0000
Received: from DS3PEPF000099DE.namprd04.prod.outlook.com
 (2603:10b6:8:2f:cafe::9b) by DS7PR05CA0060.outlook.office365.com
 (2603:10b6:8:2f::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18 via Frontend
 Transport; Thu, 7 Nov 2024 19:45:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF000099DE.mail.protection.outlook.com (10.167.17.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.17 via Frontend Transport; Thu, 7 Nov 2024 19:45:35 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 7 Nov 2024
 11:45:15 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 7 Nov 2024
 11:45:14 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Thu, 7 Nov
 2024 11:45:11 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Carolina Jubran
	<cjubran@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net-next 06/12] net/mlx5: Integrate esw_qos_vport_enable logic into rate operations
Date: Thu, 7 Nov 2024 21:43:51 +0200
Message-ID: <20241107194357.683732-7-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241107194357.683732-1-tariqt@nvidia.com>
References: <20241107194357.683732-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DE:EE_|MW4PR12MB6802:EE_
X-MS-Office365-Filtering-Correlation-Id: 60f5a85e-0f8e-4fe1-4499-08dcff64bf68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eKHU8FQ+2K1gUQrkEDBnkdn2EjvzSBlTwh1CkN8fzUgS3huQAfPk5nPiuEuD?=
 =?us-ascii?Q?sSIEY6CN0cdWyDURX1PgTa/nIxwHk+rqn+ktLh8Tlw7rEg4ktER/p1zDoVWq?=
 =?us-ascii?Q?5AIdFtsUDC7RegBQBCrXKxIse5MVKNGsVAjCX0uSXciOXkSPdjD52dquzoHw?=
 =?us-ascii?Q?atY4WfLRnN7zCzCpBmf92beRG+qCEAOhC5s+GGYHCp4phBQB8VoSzMtu249g?=
 =?us-ascii?Q?HPcMlpH+VBJT7kHoUPiyB2xTqmdHMaz8YzMcLi2t/Ok/OkqydWS581ycmbP0?=
 =?us-ascii?Q?IGfCNyRNnoWeBwl62aiGcmT/2etyGjcK0M2G6u33mPRTNN3bDssX7k8nx07W?=
 =?us-ascii?Q?UffAvPfW7dcY2P2e5T5EOMqnbKQCjPR9Dy3OHB9zEIXRgQjL1J4L/1m/v6vZ?=
 =?us-ascii?Q?w43tFhM1h6KQVEwBqK4SMOWq9KUlFIirT2zeEAzByrEoN6fOQzaFgoowTz43?=
 =?us-ascii?Q?EIHPsFqAP9DkUZZKSKt+xCDDgoixEECszB5r7Q9fSn3FHM8q69P24EUWD9aM?=
 =?us-ascii?Q?YLcq858ogi5fa87iK+y2/hSgUvmSVfMg9w2x9a8U/5cxFKpXVWhkOhNWvE8A?=
 =?us-ascii?Q?9xB6RcGSSQLopeWjZtizQXlBz0dHKWCammr9gbXede04I59N4uBtcRp3ef8c?=
 =?us-ascii?Q?k2pJyw5A27t/foJNc/06AP9RYlfrDwLBZaCAYN5GbhhVE4QotKB7ROfvtsDX?=
 =?us-ascii?Q?tA0CQq6Kne1rkS8wIsawm9Zb2DuffFWX5CHLDQuoLQw+FXGUv7CBPaKDnpA5?=
 =?us-ascii?Q?Xx3bFoDikJqQAurqLqQckaip50tQ08Y433AaRf3f5Exmy7MJHZFMChoIxf1a?=
 =?us-ascii?Q?15wOm80AYNlBvobhZVtPY8QrIn3/6HlDcnYYnzShYyROz61H0lEqmoaaAmQe?=
 =?us-ascii?Q?0wKU0T42kP7/8WSzOUWNjnCWmAvZyGnYcDfwUAdcfPYaYTlAh1e3D50N6KhK?=
 =?us-ascii?Q?Ul5P5QhhO++tq5PDcbdlBCKt+N29Cb8s2OCKIehat1z27Vi66BJw62IzRiEy?=
 =?us-ascii?Q?LOXfTLIm+hpGx3cYje0KGfYnDkxleeQiiJ1ZazipH9JOsh+hqLtfKFbPftej?=
 =?us-ascii?Q?ctiGovatzchozYuVDm4QFwC1d+x0+XIopzfJAXz8Cm5XZwucaLranZ4gO7Th?=
 =?us-ascii?Q?9x/qUgWMZEkJSvqDuAzitH9iHFaAdzsLu5lk4y3vTSXQQk5rISO2pXcTVg7e?=
 =?us-ascii?Q?EGFOiGhdWD6FvzJWFMTrc3cVktoYOcKES+F0xJITxhWcLQAvtTBjcwbvnEmP?=
 =?us-ascii?Q?THHAD5QfmVcjysbyMuLUepB2YpPjQbV9+Z3/7XhzFEVWhYZtvpzMh3WM1CHi?=
 =?us-ascii?Q?yOw9QVsJ6g6i+K9qHI/zdred1BjeNhaTlWjWg4PIPf/1Lfhszy3LUE3dEu2y?=
 =?us-ascii?Q?/gARNapulXhFRZiWbc2ocqfR88/7BXczlmGhG7a9t/9Fxf96wg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 19:45:35.1455
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60f5a85e-0f8e-4fe1-4499-08dcff64bf68
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6802

From: Carolina Jubran <cjubran@nvidia.com>

Fold the esw_qos_vport_enable function into operations for configuring
maximum and minimum rates, simplifying QoS logic. This change
consolidates enabling and updating the scheduling element
configuration, streamlining how vport QoS is initialized and adjusted.

Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/esw/qos.c | 87 +++++++++----------
 1 file changed, 39 insertions(+), 48 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index 155400d36a1e..35e493924c09 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
@@ -590,22 +590,21 @@ static void esw_qos_put(struct mlx5_eswitch *esw)
 		esw_qos_destroy(esw);
 }
 
-static int esw_qos_vport_enable(struct mlx5_vport *vport, u32 max_rate, u32 bw_share,
-				struct netlink_ext_ack *extack)
+static int esw_qos_vport_enable(struct mlx5_vport *vport, struct mlx5_esw_sched_node *parent,
+				u32 max_rate, u32 bw_share, struct netlink_ext_ack *extack)
 {
 	struct mlx5_eswitch *esw = vport->dev->priv.eswitch;
 	struct mlx5_esw_sched_node *sched_node;
 	int err;
 
 	esw_assert_qos_lock_held(esw);
-	if (vport->qos.sched_node)
-		return 0;
 
 	err = esw_qos_get(esw, extack);
 	if (err)
 		return err;
 
-	sched_node = __esw_qos_alloc_node(esw, 0, SCHED_NODE_TYPE_VPORT, esw->qos.node0);
+	parent = parent ?: esw->qos.node0;
+	sched_node = __esw_qos_alloc_node(parent->esw, 0, SCHED_NODE_TYPE_VPORT, parent);
 	if (!sched_node) {
 		err = -ENOMEM;
 		goto err_alloc;
@@ -657,21 +656,42 @@ void mlx5_esw_qos_vport_disable(struct mlx5_vport *vport)
 	esw_qos_unlock(esw);
 }
 
+static int mlx5_esw_qos_set_vport_max_rate(struct mlx5_vport *vport, u32 max_rate,
+					   struct netlink_ext_ack *extack)
+{
+	struct mlx5_esw_sched_node *vport_node = vport->qos.sched_node;
+
+	esw_assert_qos_lock_held(vport->dev->priv.eswitch);
+
+	if (!vport_node)
+		return esw_qos_vport_enable(vport, NULL, max_rate, 0, extack);
+	else
+		return esw_qos_sched_elem_config(vport_node, max_rate, vport_node->bw_share,
+						 extack);
+}
+
+static int mlx5_esw_qos_set_vport_min_rate(struct mlx5_vport *vport, u32 min_rate,
+					   struct netlink_ext_ack *extack)
+{
+	struct mlx5_esw_sched_node *vport_node = vport->qos.sched_node;
+
+	esw_assert_qos_lock_held(vport->dev->priv.eswitch);
+
+	if (!vport_node)
+		return esw_qos_vport_enable(vport, NULL, 0, min_rate, extack);
+	else
+		return esw_qos_set_node_min_rate(vport_node, min_rate, extack);
+}
+
 int mlx5_esw_qos_set_vport_rate(struct mlx5_vport *vport, u32 max_rate, u32 min_rate)
 {
 	struct mlx5_eswitch *esw = vport->dev->priv.eswitch;
 	int err;
 
 	esw_qos_lock(esw);
-	err = esw_qos_vport_enable(vport, 0, 0, NULL);
-	if (err)
-		goto unlock;
-
-	err = esw_qos_set_node_min_rate(vport->qos.sched_node, min_rate, NULL);
+	err = mlx5_esw_qos_set_vport_min_rate(vport, min_rate, NULL);
 	if (!err)
-		err = esw_qos_sched_elem_config(vport->qos.sched_node, max_rate,
-						vport->qos.sched_node->bw_share, NULL);
-unlock:
+		err = mlx5_esw_qos_set_vport_max_rate(vport, max_rate, NULL);
 	esw_qos_unlock(esw);
 	return err;
 }
@@ -757,10 +777,8 @@ static int mlx5_esw_qos_link_speed_verify(struct mlx5_core_dev *mdev,
 
 int mlx5_esw_qos_modify_vport_rate(struct mlx5_eswitch *esw, u16 vport_num, u32 rate_mbps)
 {
-	u32 ctx[MLX5_ST_SZ_DW(scheduling_context)] = {};
 	struct mlx5_vport *vport;
 	u32 link_speed_max;
-	u32 bitmask;
 	int err;
 
 	vport = mlx5_eswitch_get_vport(esw, vport_num);
@@ -779,20 +797,7 @@ int mlx5_esw_qos_modify_vport_rate(struct mlx5_eswitch *esw, u16 vport_num, u32
 	}
 
 	esw_qos_lock(esw);
-	if (!vport->qos.sched_node) {
-		/* Eswitch QoS wasn't enabled yet. Enable it and vport QoS. */
-		err = esw_qos_vport_enable(vport, rate_mbps, 0, NULL);
-	} else {
-		struct mlx5_core_dev *dev = vport->qos.sched_node->parent->esw->dev;
-
-		MLX5_SET(scheduling_context, ctx, max_average_bw, rate_mbps);
-		bitmask = MODIFY_SCHEDULING_ELEMENT_IN_MODIFY_BITMASK_MAX_AVERAGE_BW;
-		err = mlx5_modify_scheduling_element_cmd(dev,
-							 SCHEDULING_HIERARCHY_E_SWITCH,
-							 ctx,
-							 vport->qos.sched_node->ix,
-							 bitmask);
-	}
+	err = mlx5_esw_qos_set_vport_max_rate(vport, rate_mbps, NULL);
 	esw_qos_unlock(esw);
 
 	return err;
@@ -863,12 +868,7 @@ int mlx5_esw_devlink_rate_leaf_tx_share_set(struct devlink_rate *rate_leaf, void
 		return err;
 
 	esw_qos_lock(esw);
-	err = esw_qos_vport_enable(vport, 0, 0, extack);
-	if (err)
-		goto unlock;
-
-	err = esw_qos_set_node_min_rate(vport->qos.sched_node, tx_share, extack);
-unlock:
+	err = mlx5_esw_qos_set_vport_min_rate(vport, tx_share, extack);
 	esw_qos_unlock(esw);
 	return err;
 }
@@ -889,13 +889,7 @@ int mlx5_esw_devlink_rate_leaf_tx_max_set(struct devlink_rate *rate_leaf, void *
 		return err;
 
 	esw_qos_lock(esw);
-	err = esw_qos_vport_enable(vport, 0, 0, extack);
-	if (err)
-		goto unlock;
-
-	err = esw_qos_sched_elem_config(vport->qos.sched_node, tx_max,
-					vport->qos.sched_node->bw_share, extack);
-unlock:
+	err = mlx5_esw_qos_set_vport_max_rate(vport, tx_max, extack);
 	esw_qos_unlock(esw);
 	return err;
 }
@@ -991,13 +985,10 @@ int mlx5_esw_qos_vport_update_node(struct mlx5_vport *vport,
 	}
 
 	esw_qos_lock(esw);
-	if (!vport->qos.sched_node && !node)
-		goto unlock;
-
-	err = esw_qos_vport_enable(vport, 0, 0, extack);
-	if (!err)
+	if (!vport->qos.sched_node && node)
+		err = esw_qos_vport_enable(vport, node, 0, 0, extack);
+	else if (vport->qos.sched_node)
 		err = esw_qos_vport_update_node(vport, node, extack);
-unlock:
 	esw_qos_unlock(esw);
 	return err;
 }
-- 
2.44.0


