Return-Path: <netdev+bounces-135331-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5674699D8A0
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 22:55:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 798C31C210E9
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 20:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B3941D0BA4;
	Mon, 14 Oct 2024 20:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LtRna55k"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F561D6DC8
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 20:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728939296; cv=fail; b=ACyr4M7zrkUYR3xg4DdA/Ro9POS7vSYyfKpvXQuHmAUkfxv9CD+63dJS7SqyQbNcHbOIhP1wEreHeraSy4ySMf7kJ2g3iNB906iNihtvEX1HjKH9EQvSNqSoPskSy71IOWICRxLVJKrh6aoUBY8snb2zihkcdSG42ybnIxtgnpI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728939296; c=relaxed/simple;
	bh=VLwhQs9dnZ5XHtoV5ZLmcPkY4DWYxy+OozDblERFFZo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DXS5UmHNgFphqAnPv3Ca1aE9NeaULKnCL/2Ave6q3LqLsieWDm/bNY23OfFnmI/VCQpHQNcEC+2dea4CKlxvYsQlHSAcHQqBSwrMg0Er1idP9wNMJhqHMLQy55NYzOqtj4o9Vx4M2RvMo/EelKdOankJQMeuK3AgJM7fq0MuQfc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LtRna55k; arc=fail smtp.client-ip=40.107.94.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ck51AZyiswaVjQ4YYbB3NevVXCAycHCDF8YtWweiGBgdABw+wmH5+g7b8za1rF38anOZKCZ6sL5bv90S/p7vBOfJ18nsBaWtuXkf+ixfwF0ZDbTweB26CXzKNSvUHrB0F4J1/ASYeG9byefPP+w61Mz82ephnTsZVZV1PeTQuF2Fbn/2mMW91/mGZdbNBs7b/H+3JfE2t5RQWP1oV7wijH8ph7n2wfimF0sJDW8KEiReQmkrKzeVzeYq77d8Bqdj3dwvAjG29DTUtEiDTxHxrSf28/EARnaGdaAqzf3jYp+ZHszEQpHkc/F9/+vpHVAGBjINtQBEMh2VXjrOuUn4Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=deoJFWw2vZ5jyr4u0p3XwoAyApnlhas/WCocvCV5QQ8=;
 b=I5vmNQgjekpVg5IMpQREEt5WjqrOviK8dca4lqBCkLmKcrELRm0ZYS6RGWsrX8gFP1gdDx00uYzDehiUtnqq7e9tUf/fW5BoGjlaisnKajx2QlrcgY+0iX8SsgW31zzzU0RwTlfrva2aDaAeG/f36C2r2+27STYh6Zk7jxWIjf/x3uF5MW2aSxYTuO9twhVDzt4rTJv2xcOgXI7tjSYA05ewCMVE/KJixlk2MasK6TYWsigeSVMuAPRGxL/EwXmapJCJj3aBGBBIG8MLx/42AQX/A0eCOTKMt/n93VcvjuYEqKrSCbdSKbs5E6UIPCH70b+jtISAc14haVaduAITMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=deoJFWw2vZ5jyr4u0p3XwoAyApnlhas/WCocvCV5QQ8=;
 b=LtRna55kS+U84q1rKNujz5HPTdEc8RdUQ5/7hGLnKspvVNWS9n8rmPSJYnzRQARtxm5QhIqLznHl36l45VuJEPNyHtYcvOSSvIaEwZePEzAIwLwzCybwSOgW6Su0VAWhvKlCogp7gq3SmKfEQ24tD50vDMT5/drPQXqpNJ4YYOInhlqcdi8RIxbmqBvQu89J/tCmBogf34qj5C5tZMNxzoe2QYjjnAZ6jIx64jaWFV1z8ZIg4160zya1U8yiwR+2JJTrfK1ed7ikdYE77zx+XcYkwKe8Dw6uocTYQGp8KIiKtsOK70qWPRdcv+l16xPxXp+hwYgnwo8GMCfBG9NaPw==
Received: from CH2PR03CA0002.namprd03.prod.outlook.com (2603:10b6:610:59::12)
 by CH3PR12MB9099.namprd12.prod.outlook.com (2603:10b6:610:1a5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Mon, 14 Oct
 2024 20:54:49 +0000
Received: from CH3PEPF00000017.namprd21.prod.outlook.com
 (2603:10b6:610:59:cafe::fd) by CH2PR03CA0002.outlook.office365.com
 (2603:10b6:610:59::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.24 via Frontend
 Transport; Mon, 14 Oct 2024 20:54:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF00000017.mail.protection.outlook.com (10.167.244.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.1 via Frontend Transport; Mon, 14 Oct 2024 20:54:49 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 14 Oct
 2024 13:54:35 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 14 Oct
 2024 13:54:34 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Mon, 14 Oct
 2024 13:54:31 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, <cjubran@nvidia.com>,
	<cratiu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next V2 11/15] net/mlx5: Generalize QoS operations for nodes and vports
Date: Mon, 14 Oct 2024 23:52:56 +0300
Message-ID: <20241014205300.193519-12-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000017:EE_|CH3PR12MB9099:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b7f53a6-b4ca-4e91-a4b1-08dcec9271b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wiouQv8XZPNybAL2krOpfZLTQtsnQcOhx/bE8I3ijqFTn3ZA2SNYu6eY0ReO?=
 =?us-ascii?Q?oeu908NILVG4CpeOUzCivkahJJN6X82DszIoxCPy7MY/4LGlMF5fYA7ii8vX?=
 =?us-ascii?Q?eQOb/nBcFRPhnkAKhREojtbmXkyeI1m2riWxTgLV6yGOMqiBk3vgdoHr6s5x?=
 =?us-ascii?Q?tg9L0lY/Z0dvi9zlIyoVoE2M5neqKmvrXeHLS4GgWeoqyTf4+HfFQvB/2RiF?=
 =?us-ascii?Q?43VtvaUIN9Ava4Kqzem0iRI8snVlsLobHiYca5iGhcvZscL0G5A2leqICnre?=
 =?us-ascii?Q?h58V5LtbAoXYsHQDxneH5jG/KwG3kz+T1Eegb49Fx84it/hS/3KyEu/PZP47?=
 =?us-ascii?Q?CgOwyGBWDTJsMGGxsRiC4245MUlbjDT67ff5X59CHzzbyc98GpXkwkhZ1Th6?=
 =?us-ascii?Q?43lGFnGZyqIDTGFQcLg8PwTqpEbuSt+slT5g0rZamthViuFQk7prd+CIYMqL?=
 =?us-ascii?Q?AV2tmrvtnVnvPtppNWuk20gPNuF14SrL4bVc7W+MyPHRdjxoa1zbZgbWSegu?=
 =?us-ascii?Q?aukF/AzVKQaF9wlG06piivQ5XiKFFbNLy8f0tHPbK6BgaD2gv6/29BbvLfV0?=
 =?us-ascii?Q?YaNPt6Kn3PxAUQc6kNZ2MJuwClMROrYu0g+mbm6apwc8rV5TB4cOklvzAX+F?=
 =?us-ascii?Q?/GYFlZLZgYFj6wKIm0nEy77z7HwvKDQZT1C0Ko72soZrbmZro29Jqr8H5oS5?=
 =?us-ascii?Q?buMNdgFE6jjuKcs3iS8SQNCJZPKEzdTojjzcjpn9y6g/6SuZ8A4qIQJQoERG?=
 =?us-ascii?Q?9X11SALeOeMEL0km6xPPazddkK3xK0gS+AOCFEe7/z4J7u5Juf3v3lePUjQe?=
 =?us-ascii?Q?tQCiURjwd1fg87P1jlj1GvcF+/waGuvpRj0U62TE+jocSgxLW0ayPCyU7nT6?=
 =?us-ascii?Q?wUSglvIXzhlUdSjFDwYiSziifQlOUiV/dNeT1eke9A9WkpUbSLS9mOiPwOv9?=
 =?us-ascii?Q?yIp0eF4jR1zYeSpsXXJ0LCeMMtRVFDvwiz5gajI9xAFQELRTEepKsprhBmCT?=
 =?us-ascii?Q?wzrQjZ853ISmB9BF87cDuMsTaQXdbdqo3Gskx04PBjIvE+qks3KFT0zKmwz+?=
 =?us-ascii?Q?H/pCdJzvS+VXzx7aug/GDRmHMGYL4rM7M3a77dSBNCcyDogf5129H+Iw2JKe?=
 =?us-ascii?Q?nOt2Hy8mxXFWOHqzl4UmH/FvBoVXvfUgrP2/htRWqN3Ub60SmlMrkhTBJOAv?=
 =?us-ascii?Q?bpfAxf02GQ/TX5uHqaJbZXj4V4nuTYYoC+z8QcONB5Z8q2zjL3xYv9/+hE76?=
 =?us-ascii?Q?qlRYdb466x2b2aqsOpOCwapsoHzfo4JgnTq+zfUgmLNdMzrXPBFNfKtWXGPI?=
 =?us-ascii?Q?EAdVZcdpMHplnBgZXr8ohRE/3Li+9D3Q7NuMrgzSYFehkeCpbZv8Yvg82/RP?=
 =?us-ascii?Q?9IylSwI=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 20:54:49.5511
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b7f53a6-b4ca-4e91-a4b1-08dcec9271b8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000017.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9099

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
index 519af66e2325..7c3e84b7ce4c 100644
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
+		if (node->type != SCHED_NODE_TYPE_VPORTS_TSAR)
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


