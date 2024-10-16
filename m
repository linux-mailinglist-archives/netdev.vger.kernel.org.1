Return-Path: <netdev+bounces-136218-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A48869A10D0
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 19:38:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 294471F21201
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 17:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C387212F05;
	Wed, 16 Oct 2024 17:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AUgJHMqE"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56C8212624
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 17:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729100288; cv=fail; b=XO8wdvSSm2ObmU+uY0KCnsVC+If+TYmXvraGRixlvcKTa0A4F4vqGX3UatgLVFrndFVEr0IeVdjgafH5DthEdeouFDEpZpZuPWKCrsyYVKhBdygllWw9s2OjtX5xIs05sdMx8fq9l+yilCY2OrIJq7LU0vNeHgTWZ4nZndB42os=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729100288; c=relaxed/simple;
	bh=lXyVHNZmgcoiv9iofLEDlcGJOkM0GyE4zd29NQSOBT8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RBdunQ2FmoHxfh3Q+SqGBNQKBitXfaPmQyK3Q+PYrBLvwdoJgKyG1acYMSTVuoMPHgwLTFDTe5FAX6uz3v4RlXV8gI1VALfGeapXkIdOQNZYKZxT3mevSClNeYoIwcGfmNwVodPlDOq84ws9wOVYVXDqMcwNlVsmB+JRIyGOLSA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AUgJHMqE; arc=fail smtp.client-ip=40.107.94.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RDcClbofjmERSVVbyzxLLlUzt2saCPt50Ro2vX59bb74pAD/kEJK/9t8nqp5uwAq3OqSuuQD2oU+MBaxX31ur7hOERVzf7PUAnpbw7LIFdfxyDjy7KQtQtvfbfIRq4EHCEy10TIIl6EmcMyWLaZJAKuTK7wJCIcf6ya74IcvO22gRBuTJVOMQbQVftTK2BeP9cco1E/ckpk3kjIF85Vpk6jXrgdc5Qh3TnfwPACwOzjbAL+FelN7270baQPZ29ZHB2hzZCN9E6fnYg+KsoY6GA+1al4GpSr0H62/Zkfc/quyW67MckEhemgGSw0NBM0iAiQG9aY8ELpxK0o1JxFh3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6n2LtC9mXc06Qw18q+BGc0xyUZzjccrqRR0HOwsP7NI=;
 b=QTJchKL7ybB7McsG7DNxe/BHzPEM4V+Mt0g43Ygh53ouWAFmnFPGAJUCY82nEuCFviAt+BAm3zlepYwYiGI+jz/RtvJN8ki2Pd0Y60jguL5XZk9SIxIvgrXCP3dTbYjrlXhGbBdIZnpY+D2kcRTND9UU1JCc2X3lAJ895f82Z/+aXphTCDIoONusm6rLN6NmiYFZF/e+9unvX/f8BWFQBhcLHvIE3+Xio3HvomwSdx5+14Cl30QwNWmn85GFL4cufINH3CFvZ3k/F3qhEY25wVR6CIsosbbjJD+zfT2+i1uy0GOpmwR/8SzO/tIvMdnphsshwH4dJpOVB0LDyZQ4aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6n2LtC9mXc06Qw18q+BGc0xyUZzjccrqRR0HOwsP7NI=;
 b=AUgJHMqESbEEm97+LhjUynM/Mc7LcHIDdCNfSj9WyO+2ZRV4vPfzuCpQOnS1CbazE38wHtdf7W7t35u0JjYsmyf4Nyh78FSUAUfAZB439vdxWlQ51juI8EvtD1L4NtcYwbk/fqHsneV0/JTndqMQ9XiLbqzWTBl6WU3HSRtxpZBUY236aAkIFEGf0gGsi+S5yuKr4RbOZ35liofyje/hPgMCE7FcC59pBNjZ2So6ACsvzmKi+ddXgXAYEiD691W3FTGSu1i03TJ/o81WI6UZp8aZCNRBmQW/xbDc7ZLp51Zhu4GopmMPSEwJIoXxwep25CzsYGZ49QpPGsKWyjO+yA==
Received: from BL1PR13CA0418.namprd13.prod.outlook.com (2603:10b6:208:2c2::33)
 by PH0PR12MB5648.namprd12.prod.outlook.com (2603:10b6:510:14b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Wed, 16 Oct
 2024 17:38:03 +0000
Received: from BN1PEPF0000467F.namprd03.prod.outlook.com
 (2603:10b6:208:2c2:cafe::27) by BL1PR13CA0418.outlook.office365.com
 (2603:10b6:208:2c2::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.8 via Frontend
 Transport; Wed, 16 Oct 2024 17:38:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN1PEPF0000467F.mail.protection.outlook.com (10.167.243.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Wed, 16 Oct 2024 17:38:03 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 16 Oct
 2024 10:37:44 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 16 Oct 2024 10:37:43 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 16 Oct 2024 10:37:40 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, <cjubran@nvidia.com>,
	<cratiu@nvidia.com>, Simon Horman <horms@kernel.org>, Daniel Machon
	<daniel.machon@microchip.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next V3 11/15] net/mlx5: Generalize QoS operations for nodes and vports
Date: Wed, 16 Oct 2024 20:36:13 +0300
Message-ID: <20241016173617.217736-12-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241016173617.217736-1-tariqt@nvidia.com>
References: <20241016173617.217736-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000467F:EE_|PH0PR12MB5648:EE_
X-MS-Office365-Filtering-Correlation-Id: 46401c90-2c24-41ab-bbd6-08dcee09496f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TfcExRdqEWv2aM4ZnzC0SAW/BO66TVKFdd/u8xryRfuyS3ozLuu5e1rmlgqj?=
 =?us-ascii?Q?ddqNqqKkHa0DCXgUE7POKmAqs8czgFNjTQ6Tmq7EIZXhYbsXrmbouYn4vvL+?=
 =?us-ascii?Q?1cCmhLMqKGwcHD+4TL319sZ8bBI+dnxN72M4fvpTvyzOi20Pa0wrJNRio3Pw?=
 =?us-ascii?Q?s+1/i3ZXU7rvjHgp672M5lwwP/7YCDcQloHDjnKFRT4FA7eHOIZTlz9oXQ7G?=
 =?us-ascii?Q?lYupSLnICwq15UKDW0HGRwhpygOBT4oaMwnYa1K8Kxhcfn28K0eU+lZr0/P6?=
 =?us-ascii?Q?A9ltzoKSvp/eK3QNYtRLn+kqYcd4PshX44U/1UCsvqz+50mJ2HS3i/BQgp1o?=
 =?us-ascii?Q?DMRSQtuAuedA+hlXbuc3lfTLsqESVM9qu6iP2JbCPxtufs4jXOcJ/Z7oirju?=
 =?us-ascii?Q?KjRrHtuaiu7Y+M7QMQ+RE1Iq6T1khzys7gXKqNkPK5jn/Kd17hGFWnK2o2Z5?=
 =?us-ascii?Q?jN8fgwONkvif0Y9Ibn0fOFdHeWsSxBLttpFk1ZV1PFDS+cHoQQGAJpnbQSBk?=
 =?us-ascii?Q?BOdngTIWdKuZStYNbADR+b77fagsfQtzjOAYUJtnWnxOtWupIz1NbKd9fd+U?=
 =?us-ascii?Q?IsISscFZWD+9aJ5UhTLHHt5woFmAqn07SG4tWKw7mO1hcGyGBdknJD8uN3Fc?=
 =?us-ascii?Q?pThURAQHqf5nKYrl+BwYhX2s6I9h6Ktb1ed8k0Rf4aP/SUIFuUsttJIv1Beu?=
 =?us-ascii?Q?iZQl+ctqTxtTAYi4eDfOLyPavkEDGJXRIxa29pwqAlIOGAqBpDjSk1ww88Nq?=
 =?us-ascii?Q?/6ezDhtEw8hQ3XgaKFYNeQI8WZ+TZjkB9nNGKYg5wx/ZbxFX+YKW8HVM6edB?=
 =?us-ascii?Q?m4+ZL/CZJZWnhdpcL18JIKkn2tLbhm0FMn9x1z1B9P55j+rg7oETwUUaQiIl?=
 =?us-ascii?Q?ElI1ZTnh6XDN+8b6vEKNhVMbRoFAs+M4FcupCUiWTJUyLQPIg4zbsCbLMMu3?=
 =?us-ascii?Q?Tv87dQmSW1S+E+OVNozlbDiQbwpzzyZZ9sxceC+3th9Wwc4fss1OK9Wyij7m?=
 =?us-ascii?Q?nCCPmt7eu1F+tXZRJBrcr2cwDYvWrGQlzk85e211AsrfqDt1HGu7ycryg+AP?=
 =?us-ascii?Q?Ixv2fXK8N9D8yQ5Cg9rCR37zMBAlptvc5stX+FSqhipsmjbtu0vPxQSMLwav?=
 =?us-ascii?Q?he2WlDqzsiMbOL37Qa2yJX1PnE8g7pEGe+3L28Fdk+VZ8BnVyBjgDmDzCbhf?=
 =?us-ascii?Q?rWg85liFDKR9c1iPRn6KNe1QUs1moK47/wvE4Zc8tjarRASOCY+ghp396O9X?=
 =?us-ascii?Q?BJX2xnwVAdj9VK2yi7o+7RL1Z0IgmTaXyMiUTzM8EwzEgfHVVhR1my649Dc7?=
 =?us-ascii?Q?dY8Zu0xS61a3VdZhSabFuKGzADQesPvj+PGoyCkCASc2dM9ev6caNdrS1XJP?=
 =?us-ascii?Q?pUtEHLk=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 17:38:03.2537
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 46401c90-2c24-41ab-bbd6-08dcee09496f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000467F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5648

From: Carolina Jubran <cjubran@nvidia.com>

Refactor QoS normalization and rate calculation functions to operate
on mlx5_esw_sched_node, allowing for generalized handling of both
vports and nodes.

Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/esw/qos.c | 115 +++++++-----------
 1 file changed, 43 insertions(+), 72 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index 7b243ba5558c..7e7f99b38a37 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
@@ -168,45 +168,18 @@ static int esw_qos_sched_elem_config(struct mlx5_esw_sched_node *node, u32 max_r
 	return 0;
 }
 
-static u32 esw_qos_calculate_node_min_rate_divider(struct mlx5_esw_sched_node *node)
-{
-	u32 fw_max_bw_share = MLX5_CAP_QOS(node->esw->dev, max_tsar_bw_share);
-	struct mlx5_esw_sched_node *vport_node;
-	u32 max_guarantee = 0;
-
-	/* Find max min_rate across all vports in this node.
-	 * This will correspond to fw_max_bw_share in the final bw_share calculation.
-	 */
-	list_for_each_entry(vport_node, &node->children, entry) {
-		if (vport_node->min_rate > max_guarantee)
-			max_guarantee = vport_node->min_rate;
-	}
-
-	if (max_guarantee)
-		return max_t(u32, max_guarantee / fw_max_bw_share, 1);
-
-	/* If vports max min_rate divider is 0 but their node has bw_share
-	 * configured, then set bw_share for vports to minimal value.
-	 */
-	if (node->bw_share)
-		return 1;
-
-	/* A divider of 0 sets bw_share for all node vports to 0,
-	 * effectively disabling min guarantees.
-	 */
-	return 0;
-}
-
-static u32 esw_qos_calculate_min_rate_divider(struct mlx5_eswitch *esw)
+static u32 esw_qos_calculate_min_rate_divider(struct mlx5_eswitch *esw,
+					      struct mlx5_esw_sched_node *parent)
 {
+	struct list_head *nodes = parent ? &parent->children : &esw->qos.domain->nodes;
 	u32 fw_max_bw_share = MLX5_CAP_QOS(esw->dev, max_tsar_bw_share);
 	struct mlx5_esw_sched_node *node;
 	u32 max_guarantee = 0;
 
-	/* Find max min_rate across all esw nodes.
+	/* Find max min_rate across all nodes.
 	 * This will correspond to fw_max_bw_share in the final bw_share calculation.
 	 */
-	list_for_each_entry(node, &esw->qos.domain->nodes, entry) {
+	list_for_each_entry(node, nodes, entry) {
 		if (node->esw == esw && node->ix != esw->qos.root_tsar_ix &&
 		    node->min_rate > max_guarantee)
 			max_guarantee = node->min_rate;
@@ -215,7 +188,14 @@ static u32 esw_qos_calculate_min_rate_divider(struct mlx5_eswitch *esw)
 	if (max_guarantee)
 		return max_t(u32, max_guarantee / fw_max_bw_share, 1);
 
-	/* If no node has min_rate configured, a divider of 0 sets all
+	/* If nodes max min_rate divider is 0 but their parent has bw_share
+	 * configured, then set bw_share for nodes to minimal value.
+	 */
+
+	if (parent && parent->bw_share)
+		return 1;
+
+	/* If the node nodes has min_rate configured, a divider of 0 sets all
 	 * nodes' bw_share to 0, effectively disabling min guarantees.
 	 */
 	return 0;
@@ -228,59 +208,50 @@ static u32 esw_qos_calc_bw_share(u32 min_rate, u32 divider, u32 fw_max)
 	return min_t(u32, max_t(u32, DIV_ROUND_UP(min_rate, divider), MLX5_MIN_BW_SHARE), fw_max);
 }
 
-static int esw_qos_normalize_node_min_rate(struct mlx5_esw_sched_node *node,
-					   struct netlink_ext_ack *extack)
+static int esw_qos_update_sched_node_bw_share(struct mlx5_esw_sched_node *node,
+					      u32 divider,
+					      struct netlink_ext_ack *extack)
 {
 	u32 fw_max_bw_share = MLX5_CAP_QOS(node->esw->dev, max_tsar_bw_share);
-	u32 divider = esw_qos_calculate_node_min_rate_divider(node);
-	struct mlx5_esw_sched_node *vport_node;
 	u32 bw_share;
 	int err;
 
-	list_for_each_entry(vport_node, &node->children, entry) {
-		bw_share = esw_qos_calc_bw_share(vport_node->min_rate, divider, fw_max_bw_share);
+	bw_share = esw_qos_calc_bw_share(node->min_rate, divider, fw_max_bw_share);
 
-		if (bw_share == vport_node->bw_share)
-			continue;
+	if (bw_share == node->bw_share)
+		return 0;
 
-		err = esw_qos_sched_elem_config(vport_node, vport_node->max_rate, bw_share, extack);
-		if (err)
-			return err;
+	err = esw_qos_sched_elem_config(node, node->max_rate, bw_share, extack);
+	if (err)
+		return err;
 
-		vport_node->bw_share = bw_share;
-	}
+	node->bw_share = bw_share;
 
-	return 0;
+	return err;
 }
 
-static int esw_qos_normalize_min_rate(struct mlx5_eswitch *esw, struct netlink_ext_ack *extack)
+static int esw_qos_normalize_min_rate(struct mlx5_eswitch *esw,
+				      struct mlx5_esw_sched_node *parent,
+				      struct netlink_ext_ack *extack)
 {
-	u32 fw_max_bw_share = MLX5_CAP_QOS(esw->dev, max_tsar_bw_share);
-	u32 divider = esw_qos_calculate_min_rate_divider(esw);
+	struct list_head *nodes = parent ? &parent->children : &esw->qos.domain->nodes;
+	u32 divider = esw_qos_calculate_min_rate_divider(esw, parent);
 	struct mlx5_esw_sched_node *node;
-	u32 bw_share;
-	int err;
 
-	list_for_each_entry(node, &esw->qos.domain->nodes, entry) {
-		if (node->esw != esw || node->ix == esw->qos.root_tsar_ix)
-			continue;
-		bw_share = esw_qos_calc_bw_share(node->min_rate, divider,
-						 fw_max_bw_share);
+	list_for_each_entry(node, nodes, entry) {
+		int err;
 
-		if (bw_share == node->bw_share)
+		if (node->esw != esw || node->ix == esw->qos.root_tsar_ix)
 			continue;
 
-		err = esw_qos_sched_elem_config(node, node->max_rate, bw_share, extack);
+		err = esw_qos_update_sched_node_bw_share(node, divider, extack);
 		if (err)
 			return err;
 
-		node->bw_share = bw_share;
-
-		/* All the node's vports need to be set with default bw_share
-		 * to enable them with QOS
-		 */
-		err = esw_qos_normalize_node_min_rate(node, extack);
+		if (list_empty(&node->children))
+			continue;
 
+		err = esw_qos_normalize_min_rate(node->esw, node, extack);
 		if (err)
 			return err;
 	}
@@ -307,7 +278,7 @@ static int esw_qos_set_vport_min_rate(struct mlx5_vport *vport,
 
 	previous_min_rate = vport_node->min_rate;
 	vport_node->min_rate = min_rate;
-	err = esw_qos_normalize_node_min_rate(vport_node->parent, extack);
+	err = esw_qos_normalize_min_rate(vport_node->parent->esw, vport_node->parent, extack);
 	if (err)
 		vport_node->min_rate = previous_min_rate;
 
@@ -357,13 +328,13 @@ static int esw_qos_set_node_min_rate(struct mlx5_esw_sched_node *node,
 
 	previous_min_rate = node->min_rate;
 	node->min_rate = min_rate;
-	err = esw_qos_normalize_min_rate(esw, extack);
+	err = esw_qos_normalize_min_rate(esw, NULL, extack);
 	if (err) {
 		NL_SET_ERR_MSG_MOD(extack, "E-Switch node min rate setting failed");
 
 		/* Attempt restoring previous configuration */
 		node->min_rate = previous_min_rate;
-		if (esw_qos_normalize_min_rate(esw, extack))
+		if (esw_qos_normalize_min_rate(esw, NULL, extack))
 			NL_SET_ERR_MSG_MOD(extack, "E-Switch BW share restore failed");
 	}
 
@@ -525,8 +496,8 @@ static int esw_qos_vport_update_node(struct mlx5_vport *vport,
 
 	/* Recalculate bw share weights of old and new nodes */
 	if (vport_node->bw_share || new_node->bw_share) {
-		esw_qos_normalize_node_min_rate(curr_node, extack);
-		esw_qos_normalize_node_min_rate(new_node, extack);
+		esw_qos_normalize_min_rate(curr_node->esw, curr_node, extack);
+		esw_qos_normalize_min_rate(new_node->esw, new_node, extack);
 	}
 
 	return 0;
@@ -581,7 +552,7 @@ __esw_qos_create_vports_sched_node(struct mlx5_eswitch *esw, struct mlx5_esw_sch
 		goto err_alloc_node;
 	}
 
-	err = esw_qos_normalize_min_rate(esw, extack);
+	err = esw_qos_normalize_min_rate(esw, NULL, extack);
 	if (err) {
 		NL_SET_ERR_MSG_MOD(extack, "E-Switch nodes normalization failed");
 		goto err_min_rate;
@@ -638,7 +609,7 @@ static int __esw_qos_destroy_node(struct mlx5_esw_sched_node *node, struct netli
 		NL_SET_ERR_MSG_MOD(extack, "E-Switch destroy TSAR_ID failed");
 	__esw_qos_free_node(node);
 
-	err = esw_qos_normalize_min_rate(esw, extack);
+	err = esw_qos_normalize_min_rate(esw, NULL, extack);
 	if (err)
 		NL_SET_ERR_MSG_MOD(extack, "E-Switch nodes normalization failed");
 
-- 
2.44.0


