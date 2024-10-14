Return-Path: <netdev+bounces-135330-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3539E99D89E
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 22:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 585F01C21137
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 20:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483851D1E68;
	Mon, 14 Oct 2024 20:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hXGwhO8/"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E521D0BA4
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 20:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728939293; cv=fail; b=GqjZAJgFw9NAvqBEsXnOrUfCCqCOIggo/eUilQa6hLjl/6DrYAZXAMtiXfk1NjuBNKx6LLny7iwWpkCitfDCT1VbhFNUWObNmN8dk1JtgfEIEPf2xWh0+cry64OX07X9RIfWhdnveWRDHxwcZNJFlGqDk1ddPbidKOcxs8PSplw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728939293; c=relaxed/simple;
	bh=Ehp3IebosekfWfKvIadpg1FiftoxqJgY4xTDuGQon5g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GGw3Wt31O9NKDKQec8MXYNsShamSRkDVboSd2fhpwGT7EDZ3YkfeadMLbSPj5Bfd64yeelaCk8Ul2tT0IDulTsEroIE6nqCssCoHbLfpqWlVFTF2QcEiN6wgDgggFQ5XGn02GCSFvlzBVWWhM9+Lh3aZ+5GN1U7uCRwG5g+Sgwo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hXGwhO8/; arc=fail smtp.client-ip=40.107.223.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=asRiuT3xHLOaET+ABH6xwS9HLm2j7ptdwSa6Re2WK1rp3F+v/YKGIsyVuMB7UV1Y+lsG//tuhobAq/lmRPtxjyJ3na95TRV5zI2OhWnT5lQ2ZoNuY5TnzUPwC3qyrrfigEsTEFLtMqnpKLMqkM3MfgOEIjc2453ZRb+TasjziXf0qWC8e2KF8VzAZuN6/9CBO6IcxUMR3hfzkqUB9jzqYiKHslSxy7RrtaknV18QsdgvWP3Nrhn/PDYFnly0/znARYKpIjw+j2rTwC7mm/34DlhOSG4ChGXsOQ9KM696XbA4PTUJWrStfLpLtcRvPY//7kpwViP/7T20a38pTuHjvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bo1FS7dfw4ysr6Apr/rYgsVuLHIuEbYCIeRjfGNu4Ds=;
 b=YAzf5v2IVUVP+ImumXzfElaSQ7eBgEJ4rBFwyf2vggY97ubw64e8knqM7V+jbaFndCY43I6ejS1k5BZT3cqgzF+6D+1cF0VSh4oPwc7RyJnoN48VQNiHsgqx44vIX2viWnPTORK/8Nz2RJYGvtbpBoO4qaOo+NU8mC5IUmywpdf7qx/vYYG+pZI9gyn6b38v8yTInF6Tmuzce9b4O39r2BzIZvARxpbU+skzcBVreJIjsQJYz2SIeMarSM46T+T6BRiKEo312Xu1mXFAOgcpMKUEloKQwF8EP7mhfH3Obe3lXM57ZoKaf/+XDTpQt1iDSStOadi1/hs8iTovsjp0Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bo1FS7dfw4ysr6Apr/rYgsVuLHIuEbYCIeRjfGNu4Ds=;
 b=hXGwhO8/6ZvXm3p9fgpirD8PO/0q95Jm8AOPIVPz/dtnI/s/wtiOG/YYOZpxKPao1TOckMnVzN0WrtUB9zg/UJlQPigBLp3fLerZtYDCJj4UPrMg9Z2UgNBFiJGpffeFb9+6wVDfH4q300naql7d9JyWWAONEHWd/y2iiSxb7HOcABFKSjp7Vwn3nfYNL7FSz6Bed75HORiTG6zoj+t5Y5w23OitTfwiHQoqRusdDsbVTnQRc71dYbXf4yX9Vpu+zKpJH5NAwP8bPjPsTGN5fW9dbXwGyvp85BcRrI7eYukbl6NcgW+jG5Ig8m9gN/JHpsXPtelkUZ+gNqXgcigxvw==
Received: from DM6PR06CA0095.namprd06.prod.outlook.com (2603:10b6:5:336::28)
 by MN0PR12MB5836.namprd12.prod.outlook.com (2603:10b6:208:37b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Mon, 14 Oct
 2024 20:54:46 +0000
Received: from CH3PEPF00000011.namprd21.prod.outlook.com
 (2603:10b6:5:336:cafe::6e) by DM6PR06CA0095.outlook.office365.com
 (2603:10b6:5:336::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27 via Frontend
 Transport; Mon, 14 Oct 2024 20:54:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF00000011.mail.protection.outlook.com (10.167.244.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.1 via Frontend Transport; Mon, 14 Oct 2024 20:54:45 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 14 Oct
 2024 13:54:31 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 14 Oct
 2024 13:54:31 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Mon, 14 Oct
 2024 13:54:28 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, <cjubran@nvidia.com>,
	<cratiu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next V2 10/15] net/mlx5: Simplify QoS scheduling element configuration
Date: Mon, 14 Oct 2024 23:52:55 +0300
Message-ID: <20241014205300.193519-11-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241014205300.193519-1-tariqt@nvidia.com>
References: <20241014205300.193519-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000011:EE_|MN0PR12MB5836:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ea12ae4-b30d-4927-6b52-08dcec926f43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?33YhQTQ4gMYagFMAzvX+wYdIZw7BW2a2x74AJaK0WP4sdUIGQhenoyANaYhl?=
 =?us-ascii?Q?cdXi0KNOLA9pq5Ig81kA8W/XzGLtrIJvt1Dj5cI2PtZBzut1K+SLDZhtJnmb?=
 =?us-ascii?Q?1lYQp05q9V6XHM33pfCKsjuozVsmKt0CnHS61Vguzo2BHm9cC57i3uXMQKSM?=
 =?us-ascii?Q?8MquZKPdpe17s8XzimWQVsCiw0JanfFeXvQOAfjITf3rRmG7cF+yrwTNAXK1?=
 =?us-ascii?Q?DMLwSLMf+LTnh2dXHoN+QIK0TnGg9E0xCmGxt+ce0Xo5giehE5NKMeseefmy?=
 =?us-ascii?Q?rmfbuhczOLsHsmb8sjZgi5vt3FE52bwkFf2PNHkDk2fz24St9/ZRSmSdrQPe?=
 =?us-ascii?Q?xBw/0cxLk/E6QbgfQbMcrFz5qMqpsQ2UJKA07VSrzaQqBbBYt1HM1qNJEW94?=
 =?us-ascii?Q?qrQte7jls++m/EKRCOlfliydUwsHTmuVaEyN+/uzxddCfViiGjTNFdeWEGI0?=
 =?us-ascii?Q?obioI4JsU7jgqLO0diYBi5JzlgNWkzXfJVjmr6KC+mr08IK0sNb/8dvfcpoP?=
 =?us-ascii?Q?DMa3neahKd9MLEjGrAKqj87b2xqM7WDELkbIfFiiJA6OMQ1F2FsZES/itseh?=
 =?us-ascii?Q?36mDlhAl6ZbIPGgEvnOp1qXUh7d4gJXyOmZnJL2RpYOvPGjyXisO62ju2iWV?=
 =?us-ascii?Q?r3CB/Qe2eXcmGbMRrogYHA6tNuTWovBdFuiL3YzAM6ZSAQ7lCHhRFFFTooqz?=
 =?us-ascii?Q?0tWTgcSBpiY2oztl1MlGxlmOr9HDYqkh3ofrgiQhGLdxPDcK5CzHO8sYhgSG?=
 =?us-ascii?Q?76f+rZZ++qu8rt4lQfBT3csDIjKqBa7PjRBv6HNzuvxSNsMs4+R+FIutr7a9?=
 =?us-ascii?Q?rJ91eFb/D7MFsRU3UxGGaFWDPbNSAJDh/GqGNo8G6/WuXRb243nfW1MpXdLk?=
 =?us-ascii?Q?4h/mzvOQaeiCGIh7mB1582jEt1xJcpCisfgaCtc7hLyCPsrpGN8lJy2bOPQV?=
 =?us-ascii?Q?ZTGbjUG+Csk4LnznLpjqXS9Llpy6iPxg5rHGqcdKTm2GCm13twqdX0bRmiZm?=
 =?us-ascii?Q?nO3SEpFN7ECSwJ327488GFv9+v1DO8VDcvpn7KMc0o9Ri2dLtCpZTxGgRE/q?=
 =?us-ascii?Q?OrQ+oKstSUk2EkC+eI2jphK36yUzXQ673kjzzWOEOmU5/INLzbAkV/kXIYiN?=
 =?us-ascii?Q?conPr1YpqDRpBGaBrjPdSyT+0/kbf/jwJ6duhwn88yVWVTsXbZFR2Xt2pxjM?=
 =?us-ascii?Q?2bJNlkQ7cA6QSVlY+A+giSzMfFKXg4tK0BEBCRdhvg72jTXaZhlhG6mlqwWS?=
 =?us-ascii?Q?ojAlOjcyBBbkHs3CZK7WDw56tT1XBQON1YtrkgjULQcLa2KecXuojiWuSy0o?=
 =?us-ascii?Q?pR482P7NMujdxs0ZN77D81n4FbvIf6R8tXFxGWeiIKkCZX04bhZOUKMiPqac?=
 =?us-ascii?Q?5eA/BZTaajW9C4ccIrlmWJdFUMV8?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 20:54:45.4275
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ea12ae4-b30d-4927-6b52-08dcec926f43
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000011.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5836

From: Carolina Jubran <cjubran@nvidia.com>

Simplify the configuration of QoS scheduling elements by removing the
separate functions `esw_qos_node_config` and `esw_qos_vport_config`.

Instead, directly use the existing `esw_qos_sched_elem_config` function
for both nodes and vports.

This unification helps in generalizing operations on scheduling
elements nodes.

Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/esw/qos.c | 86 +++++++++----------
 1 file changed, 40 insertions(+), 46 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index b36fbaf8ead0..519af66e2325 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
@@ -66,6 +66,11 @@ enum sched_node_type {
 	SCHED_NODE_TYPE_VPORT,
 };
 
+static const char * const sched_node_type_str[] = {
+	[SCHED_NODE_TYPE_VPORTS_TSAR] = "vports TSAR",
+	[SCHED_NODE_TYPE_VPORT] = "vport",
+};
+
 struct mlx5_esw_sched_node {
 	u32 ix;
 	/* Bandwidth parameters. */
@@ -113,11 +118,27 @@ mlx5_esw_qos_vport_get_parent(const struct mlx5_vport *vport)
 	return vport->qos.sched_node->parent;
 }
 
-static int esw_qos_sched_elem_config(struct mlx5_core_dev *dev, u32 sched_elem_ix,
-				     u32 max_rate, u32 bw_share)
+static void esw_qos_sched_elem_config_warn(struct mlx5_esw_sched_node *node, int err)
+{
+	if (node->vport) {
+		esw_warn(node->esw->dev,
+			 "E-Switch modify %s scheduling element failed (vport=%d,err=%d)\n",
+			 sched_node_type_str[node->type], node->vport->vport, err);
+		return;
+	}
+
+	esw_warn(node->esw->dev,
+		 "E-Switch modify %s scheduling element failed (err=%d)\n",
+		 sched_node_type_str[node->type], err);
+}
+
+static int esw_qos_sched_elem_config(struct mlx5_esw_sched_node *node, u32 max_rate, u32 bw_share,
+				     struct netlink_ext_ack *extack)
 {
 	u32 sched_ctx[MLX5_ST_SZ_DW(scheduling_context)] = {};
+	struct mlx5_core_dev *dev = node->esw->dev;
 	u32 bitmask = 0;
+	int err;
 
 	if (!MLX5_CAP_GEN(dev, qos) || !MLX5_CAP_QOS(dev, esw_scheduling))
 		return -EOPNOTSUPP;
@@ -127,46 +148,22 @@ static int esw_qos_sched_elem_config(struct mlx5_core_dev *dev, u32 sched_elem_i
 	bitmask |= MODIFY_SCHEDULING_ELEMENT_IN_MODIFY_BITMASK_MAX_AVERAGE_BW;
 	bitmask |= MODIFY_SCHEDULING_ELEMENT_IN_MODIFY_BITMASK_BW_SHARE;
 
-	return mlx5_modify_scheduling_element_cmd(dev,
-						  SCHEDULING_HIERARCHY_E_SWITCH,
-						  sched_ctx,
-						  sched_elem_ix,
-						  bitmask);
-}
-
-static int esw_qos_node_config(struct mlx5_esw_sched_node *node,
-			       u32 max_rate, u32 bw_share, struct netlink_ext_ack *extack)
-{
-	struct mlx5_core_dev *dev = node->esw->dev;
-	int err;
-
-	err = esw_qos_sched_elem_config(dev, node->ix, max_rate, bw_share);
-	if (err)
-		NL_SET_ERR_MSG_MOD(extack, "E-Switch modify node TSAR element failed");
-
-	trace_mlx5_esw_node_qos_config(dev, node, node->ix, bw_share, max_rate);
-
-	return err;
-}
-
-static int esw_qos_vport_config(struct mlx5_vport *vport,
-				u32 max_rate, u32 bw_share,
-				struct netlink_ext_ack *extack)
-{
-	struct mlx5_esw_sched_node *vport_node = vport->qos.sched_node;
-	struct mlx5_core_dev *dev = vport_node->parent->esw->dev;
-	int err;
-
-	err = esw_qos_sched_elem_config(dev, vport_node->ix, max_rate, bw_share);
+	err = mlx5_modify_scheduling_element_cmd(dev,
+						 SCHEDULING_HIERARCHY_E_SWITCH,
+						 sched_ctx,
+						 node->ix,
+						 bitmask);
 	if (err) {
-		esw_warn(dev,
-			 "E-Switch modify vport scheduling element failed (vport=%d,err=%d)\n",
-			 vport->vport, err);
-		NL_SET_ERR_MSG_MOD(extack, "E-Switch modify vport scheduling element failed");
+		esw_qos_sched_elem_config_warn(node, err);
+		NL_SET_ERR_MSG_MOD(extack, "E-Switch modify scheduling element failed");
+
 		return err;
 	}
 
-	trace_mlx5_esw_vport_qos_config(dev, vport, bw_share, max_rate);
+	if (node->type == SCHED_NODE_TYPE_VPORTS_TSAR)
+		trace_mlx5_esw_node_qos_config(dev, node, node->ix, bw_share, max_rate);
+	else if (node->type == SCHED_NODE_TYPE_VPORT)
+		trace_mlx5_esw_vport_qos_config(dev, node->vport, bw_share, max_rate);
 
 	return 0;
 }
@@ -246,8 +243,7 @@ static int esw_qos_normalize_node_min_rate(struct mlx5_esw_sched_node *node,
 		if (bw_share == vport_node->bw_share)
 			continue;
 
-		err = esw_qos_vport_config(vport_node->vport, vport_node->max_rate, bw_share,
-					   extack);
+		err = esw_qos_sched_elem_config(vport_node, vport_node->max_rate, bw_share, extack);
 		if (err)
 			return err;
 
@@ -274,7 +270,7 @@ static int esw_qos_normalize_min_rate(struct mlx5_eswitch *esw, struct netlink_e
 		if (bw_share == node->bw_share)
 			continue;
 
-		err = esw_qos_node_config(node, node->max_rate, bw_share, extack);
+		err = esw_qos_sched_elem_config(node, node->max_rate, bw_share, extack);
 		if (err)
 			return err;
 
@@ -338,8 +334,7 @@ static int esw_qos_set_vport_max_rate(struct mlx5_vport *vport,
 	if (!max_rate)
 		act_max_rate = vport_node->parent->max_rate;
 
-	err = esw_qos_vport_config(vport, act_max_rate, vport_node->bw_share, extack);
-
+	err = esw_qos_sched_elem_config(vport_node, act_max_rate, vport_node->bw_share, extack);
 	if (!err)
 		vport_node->max_rate = max_rate;
 
@@ -384,7 +379,7 @@ static int esw_qos_set_node_max_rate(struct mlx5_esw_sched_node *node,
 	if (node->max_rate == max_rate)
 		return 0;
 
-	err = esw_qos_node_config(node, max_rate, node->bw_share, extack);
+	err = esw_qos_sched_elem_config(node, max_rate, node->bw_share, extack);
 	if (err)
 		return err;
 
@@ -395,8 +390,7 @@ static int esw_qos_set_node_max_rate(struct mlx5_esw_sched_node *node,
 		if (vport_node->max_rate)
 			continue;
 
-		err = esw_qos_vport_config(vport_node->vport, max_rate, vport_node->bw_share,
-					   extack);
+		err = esw_qos_sched_elem_config(vport_node, max_rate, vport_node->bw_share, extack);
 		if (err)
 			NL_SET_ERR_MSG_MOD(extack,
 					   "E-Switch vport implicit rate limit setting failed");
-- 
2.44.0


