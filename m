Return-Path: <netdev+bounces-134909-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE9F299B8A7
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 08:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4483C1F21D0C
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 06:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7D913B7B3;
	Sun, 13 Oct 2024 06:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mE+ngyUG"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2085.outbound.protection.outlook.com [40.107.244.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739BA13957C
	for <netdev@vger.kernel.org>; Sun, 13 Oct 2024 06:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728802027; cv=fail; b=ioT4Z5cd61A8PjMX+JpxnYRvPpI/C2f0ZdzamQ7sbc4WGxECAUF56P0y557Ag0ptHhYRvr+Kmb+B19odVGzn6u0niQYwnoh3/2ldrs6+LKVdeLolXS2KqZaeX9bItr9LBfhOut+LF3/J2EZGYKLID4QfiahZ1A1WM23Hc8WxwRE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728802027; c=relaxed/simple;
	bh=RYa/96svgrAnnb4SdzxOLi5ZgF5fcGwxleXttt+MYxs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V6jbSUd9xrEJd1TMadA9T+zrisjyPJ2vjPxEoLshIqGwhNqQc3U1P9uk2Wk8+9c5XgwngdXjU7kfzqaCjHhwNEeBaUGeG1pnAzPs4pnv/WdyXbTcpqfEqJACei2SjiKHSaKNB+bTf5R1fKdEYHvuposTVPbKg2iEZJAvmoGizkE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mE+ngyUG; arc=fail smtp.client-ip=40.107.244.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TvIqDGZJarXSGzZLZeBgsmGdfOBidS+QZbY0IvT3savXBqL/vEr10x7i58C/QUuZsHhB3HWiHATdOT+OxqbDDFfRZDzT+vyReJPqmCHh5DwfaEN6hRTFHv95k+RGRrV+xCcELrCRLVNqd8vo8cBPQ/KQrDc+bOvpWhSByVChQmggskW+wbSXSLVxV9DNAbHUdx09ErYrAxFigaBhTlfeN5adQv2CP9Yj6mcVEVXxoUi7+hDYpAqG5UMTEn2kTnT7vrIOpFdeg09tVFaPHCy3MJwXlGXJf8fcxyX+M0R0NOdlS0fdK4mG/vO/UhBjeenKJYiLr/GWu2G1Vip/+4BVVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TWXNFLS9fDHbl0/EPCCpzVFMjKtf2a2chR1ZLjNcfNo=;
 b=eavjAQEulVCkEwVnrA3YbNPddIEZWvKUVwXZd0B0gc/8RYQYnxrkjM4VA4YrmQ/X8tgyb/8eMVYwYe55zj1v1NPiBjvvSi/j71eKTl2xP0cMhxaMK0wBmkMf3QOYcRJ91edfNtKvuIUiDYx+vEF7lRZmkobNtdOmZqhHls3YHBsFWxoqub8xuvPfo4yC+AWlI+Tzj/UZ6Mrvzz4hOLXjwj70UMLHV/cuLl4BWYa4F8ZMof7TPPmL4wc92tkZLpDCJudtqtoy/6MyAuCCdnLZEpF5h7KYvf18dk8GvonodeCcaYOFQT6GYi8Ca+eHU9C16p06NyR3XDYO/brbsNAC8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TWXNFLS9fDHbl0/EPCCpzVFMjKtf2a2chR1ZLjNcfNo=;
 b=mE+ngyUG5tj/QQFVCQEVURm0sp8wIwNJQroh3t5Q057+BRNFsGfIUbeQyqL3KrN+F/jH5RF6dvxFiOHIM/IQeKXfNo2NhBySh7fwhcULm9JW7KxST7Zuf4mCuhOhlNfZMP1rcODR9Uro8n7sFLvhP9cugAPqvGaPPRpxQcRZ3mXVeOfW4l39QOUGqjLnixzV9kL0dcix1pxIJ/7KrcMKEU7Wimj4jGEp19ZLJyVR6S8+2pCR40xE+yKkpJZi0kHgA2icooh+iW9E3juVgk3Pt/skgVzbfRb5P4TB7Wzeu3ilsU6k/SX2EZUBQCqggZNFB1aAbiLBg0U+d6g9FZwmkA==
Received: from CH0PR03CA0018.namprd03.prod.outlook.com (2603:10b6:610:b0::23)
 by BY5PR12MB4260.namprd12.prod.outlook.com (2603:10b6:a03:206::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.25; Sun, 13 Oct
 2024 06:47:00 +0000
Received: from CH1PEPF0000AD80.namprd04.prod.outlook.com
 (2603:10b6:610:b0:cafe::b9) by CH0PR03CA0018.outlook.office365.com
 (2603:10b6:610:b0::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.24 via Frontend
 Transport; Sun, 13 Oct 2024 06:47:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH1PEPF0000AD80.mail.protection.outlook.com (10.167.244.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.13 via Frontend Transport; Sun, 13 Oct 2024 06:46:59 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 12 Oct
 2024 23:46:50 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sat, 12 Oct 2024 23:46:50 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sat, 12 Oct 2024 23:46:47 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, <cjubran@nvidia.com>,
	<cratiu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 11/15] net/mlx5: Generalize QoS operations for nodes and vports
Date: Sun, 13 Oct 2024 09:45:36 +0300
Message-ID: <20241013064540.170722-12-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241013064540.170722-1-tariqt@nvidia.com>
References: <20241013064540.170722-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD80:EE_|BY5PR12MB4260:EE_
X-MS-Office365-Filtering-Correlation-Id: cce1bf26-f96a-4c4d-0580-08dceb52d650
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0bGe1Jy8JqZltIifuw6fzPwZ6MPtfWGHGUNsRo9qdkUhndqrEHzEZFyDXgbB?=
 =?us-ascii?Q?iJaNZNposE9olfwYsQ5n3WfawqSvMNPXBjcBlq52oTSpj8PjZf0T5sjN2VbU?=
 =?us-ascii?Q?bYewsYePad43D/oNIDVplfmQR5n2QnntiDrK7eei4QmJGrHkJjlA8affXZz5?=
 =?us-ascii?Q?4+rumYvXKiqNMHC/A2jp65MMEU25gbjXc3q3BKNJtL2g9bNY2kWIfC8TAf+d?=
 =?us-ascii?Q?byWoPVHQcrHtAVaRAQpTVla0uvuNdrGZHbfN7QwbLqnd75mCcEK/9W1407lk?=
 =?us-ascii?Q?7rIflUoGVXJI6Tabi7XPPfp9Kowg8os+dENEMXm3nCcemQd4bJY4c90ueiWZ?=
 =?us-ascii?Q?JDjPT7G9kkU8vC33sOS3ZFN5XCJA2LwoN8Z3tG95qtUTq+uNllo9vdeKwhJp?=
 =?us-ascii?Q?tyO+rWdCPw4PkIw7+OoWCsu7S+VTw7YayQnYak6qDIr0engzgZu3gI25ILXJ?=
 =?us-ascii?Q?gamMoKA+5cqrSgfsHoQAzbo44ma2vwIJVje/95Qom0XILKPEm2RpLxeUjRyu?=
 =?us-ascii?Q?ULnzAVRrQlm3Jp4UiJ2lCFf5BmIXV7Bst/2P8nqX3R9tPFBc3rH86qazHvC9?=
 =?us-ascii?Q?/ATGfHkc7KZtsgMvKrd0rjyo7QUOE6lWQzKa+gOzM2JQCQ6o0S2m/77Hztxh?=
 =?us-ascii?Q?GhQb7wUUdR9rxqSliHC/g6XMYiqzEmgSBwAX4lDGCb7ynfa/Knnn5E/bu9us?=
 =?us-ascii?Q?ZUZBZMoJUEqBTjZMj679JdJvTbJrdgRIX6Va/7drhV7QutQUgS9CLf7gH56X?=
 =?us-ascii?Q?dAmsc/WdWdyXHJ2SMm5IiPSX01cL9fCNGyL+Jttp9d8M+Xo+qV+TGTpl3lQm?=
 =?us-ascii?Q?da9DOTMBJWhR7agXNnkjMpf6B0MgMBnyR7Czir5w2jrKSj89qS1kTITviPtZ?=
 =?us-ascii?Q?2x76okftqxzsNyyZNqlIbLsvLhzNuS55cXptSwFQt+qtKyl/SqoAgIpauK3u?=
 =?us-ascii?Q?ik2OIxx6qEnyRhqlbc80ED0hLfo72GLn6pqg+kJpjNtCkoV7ZtWu914qd4Yt?=
 =?us-ascii?Q?qXmunqlowYO58o7WfNQnIfw1oRePUmPBcVElsquaCytrHM8dLs9OOjsI9DI9?=
 =?us-ascii?Q?OCW6hy89RXYnfw5VPbk0SbURm0DqPz463RNNBE8xXoa1Ov4c/jFzAj58KIE5?=
 =?us-ascii?Q?wc/Qfnh6c1EC1pIqia/7YepoH126NWMSkL/V0Gxqh0YIYSicMX92rBdqx7Pq?=
 =?us-ascii?Q?bJZkt9J2T3tM0XL7g1NkgOHgwiPkh1bjf43G/FD9xB4Poh4CbX2SLjwC60QA?=
 =?us-ascii?Q?GaW/pJpG/fhcsddIwTknS8+D9+sAy09sLtUC2mTcnSP21gyb898qgxon4v1e?=
 =?us-ascii?Q?mMjjqGHV1XQjFNmNPTzN62373FGZsyzDD0jCN79FF8UBnk5N/BIPZOZKds/e?=
 =?us-ascii?Q?tumsA7Q=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2024 06:46:59.3775
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cce1bf26-f96a-4c4d-0580-08dceb52d650
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD80.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4260

From: Carolina Jubran <cjubran@nvidia.com>

Refactor QoS normalization and rate calculation functions to operate
on mlx5_esw_sched_node, allowing for generalized handling of both
vports and nodes.

Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/esw/qos.c | 115 +++++++-----------
 1 file changed, 43 insertions(+), 72 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index ffd5d4d38fe5..f8253dc8ed3e 100644
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
@@ -308,7 +279,7 @@ static int esw_qos_set_vport_min_rate(struct mlx5_vport *vport,
 
 	previous_min_rate = vport_node->min_rate;
 	vport_node->min_rate = min_rate;
-	err = esw_qos_normalize_node_min_rate(vport_node->parent, extack);
+	err = esw_qos_normalize_min_rate(vport_node->parent->esw, vport_node->parent, extack);
 	if (err)
 		vport_node->min_rate = previous_min_rate;
 
@@ -359,13 +330,13 @@ static int esw_qos_set_node_min_rate(struct mlx5_esw_sched_node *node,
 
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
 
@@ -527,8 +498,8 @@ static int esw_qos_vport_update_node(struct mlx5_vport *vport,
 
 	/* Recalculate bw share weights of old and new nodes */
 	if (vport_node->bw_share || new_node->bw_share) {
-		esw_qos_normalize_node_min_rate(curr_node, extack);
-		esw_qos_normalize_node_min_rate(new_node, extack);
+		esw_qos_normalize_min_rate(curr_node->esw, curr_node, extack);
+		esw_qos_normalize_min_rate(new_node->esw, new_node, extack);
 	}
 
 	return 0;
@@ -582,7 +553,7 @@ __esw_qos_create_vports_rate_node(struct mlx5_eswitch *esw, struct mlx5_esw_sche
 		goto err_alloc_node;
 	}
 
-	err = esw_qos_normalize_min_rate(esw, extack);
+	err = esw_qos_normalize_min_rate(esw, NULL, extack);
 	if (err) {
 		NL_SET_ERR_MSG_MOD(extack, "E-Switch nodes normalization failed");
 		goto err_min_rate;
@@ -640,7 +611,7 @@ static int __esw_qos_destroy_rate_node(struct mlx5_esw_sched_node *node,
 		NL_SET_ERR_MSG_MOD(extack, "E-Switch destroy TSAR_ID failed");
 	__esw_qos_free_node(node);
 
-	err = esw_qos_normalize_min_rate(esw, extack);
+	err = esw_qos_normalize_min_rate(esw, NULL, extack);
 	if (err)
 		NL_SET_ERR_MSG_MOD(extack, "E-Switch nodes normalization failed");
 
-- 
2.44.0


