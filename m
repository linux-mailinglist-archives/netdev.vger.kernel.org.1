Return-Path: <netdev+bounces-143035-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35B679C0F38
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 20:45:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6F6D1F23FBD
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 19:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B811721767A;
	Thu,  7 Nov 2024 19:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="G+TxzC4N"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2060.outbound.protection.outlook.com [40.107.96.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35F7192D83
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 19:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731008737; cv=fail; b=eZzjdw5xb9MA8P1KVcykf9QzypuJ4O4ji9VOeYg05weOz7xUj+oqBhd39SgioT1yh96C77Pg5AA077VKwVocIq3au8Y7qArqy7ZZ5ZdVO/lx2qMjj1UEcZfBCWAe+rXMOlzeQjHp9GvtPW+Z9iviYDp4/MKqrwT7jNg38wgXSo8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731008737; c=relaxed/simple;
	bh=k6IMeiKgSFBtfUDOVfi6OeR51gTkrC0wYG+8cALHnLs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ToRSWNJye/PjILsVq1rgkFab+5Avw10NviC7tvqKXHitwslsEVKQz/OAeK3qwASjQ/Lo1/716C107njSy3H3ZoQmrRFgW/Dm9PYjAV0zoVk6Ba1RTH6y0/mgw5LZMn22eOWfKiDMfJUJfzMGnPEFZ3qVd28T4JGlKsdUuOkNLrM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=G+TxzC4N; arc=fail smtp.client-ip=40.107.96.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H4gbIgS8mDxwQt6Oz0SEiozqWq6G+FdRwfBLGbrCz9i4BtKhEswFCUpotaCjQBbAiDlaEzeb1xDXDSbEtiTNX2yYME6IZjhivJrWvSfwf9mA6vBjcPULR74pXHtrDIoz2n8530SlWzuTpxqVTfC5C0DJ4GzyzwkxJU2KtVlfCnvAPlFDnWuvnExw8zujewjamnSrRhSdrsaF1BDDOyz4Ls3qQ0WRABGtfWmFfyJEB4egr/Wz3ksO8uErfk7dhRyKxQnli3ebVyqBoqWcu/9+tVYs5OQNdTAq5pQTMdh/KfFo5SRul5rpC2YCt2mSJIj51gI3kq55k7zQ2tYbXyLFyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bLGW03MoF5HIMidkJMPGW8wHbJUyGzSFwlgmsFICE0g=;
 b=xD0E0HeixJ+NGuS16/DdmBT3UodZTjQvm+pTSsaphHNN9O3bzadZ+/GrlzAkQTZgN62W2xgZOsOMhIjcVyVGB2obtYRwIBrnAXtGvmr0qGghvNVDDGTusHPE8kg2Vuyu19LhyFUF2biOHI3dSmWcbMflz7ys5DzeK+/PbFvbzi488FrX2ODID38wc50NtLosJmGZj48UfnRKw3EWRwuVoc7PsLmvKsf0pQ0QIVKQ6qksCfXBs2k5vEYFXIOGQmAwmQO4jdvqrY0e7E64BSa40sNu4KQ0JEX5we8KBopn9poyciZC9WtC3mNhUO/8W1wKw/ncIlWehgmqgC9D4IIjng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bLGW03MoF5HIMidkJMPGW8wHbJUyGzSFwlgmsFICE0g=;
 b=G+TxzC4NEPoc85GcMocAhqKMJ9fuMAMVL+f1WZU3vPl0F5sCAB4kl+5q11EZdaqcg2zic4CZ63JmWMulbZ9VuF22lOcCNc1ojlXsJ14s5nKSzf0ilBmOYQx9ZLNDLNH9yzQcPlEcr5iHly2FCV0sNQoudCWYXJA/4yc0VFPbHUe8soWyQht7bjRbkbP6i/wsHI0hv5xi1+fkuvUfwoeMcbbGYwzSRHJ28bWUFUaUY18yrsaXg0n1shFUzo0z6s0bpOwtcCB3AptdYIL551SpjVbi3eIlhsqvuxDmtgyCvGc6VVxNugKg31jDl/65JYyfdiLegeSaX4zAFCoAzvx1Eg==
Received: from MW4P220CA0001.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::6)
 by CH3PR12MB8459.namprd12.prod.outlook.com (2603:10b6:610:139::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.21; Thu, 7 Nov
 2024 19:45:27 +0000
Received: from SJ5PEPF000001EA.namprd05.prod.outlook.com
 (2603:10b6:303:115:cafe::88) by MW4P220CA0001.outlook.office365.com
 (2603:10b6:303:115::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18 via Frontend
 Transport; Thu, 7 Nov 2024 19:45:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001EA.mail.protection.outlook.com (10.167.242.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.17 via Frontend Transport; Thu, 7 Nov 2024 19:45:27 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 7 Nov 2024
 11:45:07 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 7 Nov 2024
 11:45:07 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Thu, 7 Nov
 2024 11:45:04 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Carolina Jubran
	<cjubran@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net-next 04/12] net/mlx5: Refactor scheduling element configuration bitmasks
Date: Thu, 7 Nov 2024 21:43:49 +0200
Message-ID: <20241107194357.683732-5-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EA:EE_|CH3PR12MB8459:EE_
X-MS-Office365-Filtering-Correlation-Id: d072b179-dccd-42fc-ed8e-08dcff64ba93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?b6cW+LcTWpNBi1l3FEPUgLDlb2JJw+WO5tjeTjnLV1NUmAv+DwXAGjEWJojj?=
 =?us-ascii?Q?uKQSvDoutoGgKoBcJZcdGd8aRSrlaq3m+k1jkqzEgVTo0tfHi8R6fQqn85T8?=
 =?us-ascii?Q?S7hGyFYdqZxcDYgXaHlw/HNFUDMDcy/xpJtfyfYOAZ/GbUlvVGUrs7a6llqh?=
 =?us-ascii?Q?fG1duX5vJ4Kx2SasubFlbfeKDCE4VNbYE8Q96GxCdcluz1yWuyBxKTmrv+kX?=
 =?us-ascii?Q?vEKqqR3GwnENJPL7ZU9a/cHo3yIa7OyhnnRBqc5qM3Pzryp3u0Z221wUgfZn?=
 =?us-ascii?Q?KMyM/0/3SRsOh1DiBpd5ymEmKMLTg63Yy+F/MrgAltPfXNsQPVmVcAVEeSps?=
 =?us-ascii?Q?zfGZ5N4KRTeSWo1GIwtr/RJtJ6ZjMsrZYFGEjxavBB3kmca0EpBcZRLBE8qb?=
 =?us-ascii?Q?qTaeewLuIevy0dorJoSwkKpD+gUyWSiIKZqZoK70y95FStCvzR8psgBbIjyn?=
 =?us-ascii?Q?XA2u6WxvFSbZ5TD74ynNtKv5ab7xKw00YD2G3UJzfUJgbWq4AJDgVgl5B05T?=
 =?us-ascii?Q?h+3vlXefDINNomaLdGOGt4ZA1/YoqsNhJ8286rZkqW3/yRMGIv2ZrJ8VaP+7?=
 =?us-ascii?Q?BNBeCkU5MXSznHzod+hcvZHqOyZJOxCsMmwVA2y7zDa7k7alVyyVNMUf5imd?=
 =?us-ascii?Q?Gu2XjtRtNJBBt4yEF84wzYsqHkoI18ffc4/0vafadu6qe4dSOixgxJ2FvL60?=
 =?us-ascii?Q?XY8wRR/stAJFl4YKjFE6AbXpuitpbmvrxoUzwFgilA85fVog8OCxewRUFRA4?=
 =?us-ascii?Q?aQg9SwIZv1/Iess7he6p+5Uo/kr1GTAqkzhBkVwIP8FwyZZOW7B+Fe4auFOt?=
 =?us-ascii?Q?tt4CMK9rthFDzjEs62/OlSKwsZpjXYdfxD3HvhADdvcOxrozg+gjbSeeexvK?=
 =?us-ascii?Q?EPcag7KTaYUczPVbhJ8eCn5VHX5vLogeAgjh/KWSmLa7dJKNddR4GkXtKiGH?=
 =?us-ascii?Q?wbtbzp6YnRoFdDRUClC6DJ7+TT9xNMBwlw2ccCKzvmdjrY9UbgKTHLZxVdhe?=
 =?us-ascii?Q?BqYCKKWsKaIYTTkiu0HdAoOy4KNW65vxlnb/RTwqGgbUF54kAPJppbn2q5E9?=
 =?us-ascii?Q?kMiQrXprOKCO1JF3rHfvBH50nFFu2aA+6OZxVYwk5puncqs0C5JGSTpity/4?=
 =?us-ascii?Q?SHPqX3Ayzp0Yzw4Ml1LtKvNgLuJn2St6WuR12jEtcLNRFHUAqVc6mvYbn3/C?=
 =?us-ascii?Q?9Ka39N/mEX6bBfcDGth/zsFjLPk48kpiJBbgBf5fwV5QOHIVHPxcly/saYUz?=
 =?us-ascii?Q?ogyr2imTA46Ke7VhPFwLcPgHO4KX/BI/CTeTcmrdX6ECvtFbeOKaWYV9/dTm?=
 =?us-ascii?Q?hvBuyZWpRNoJT2Gsx/7V06tl2ikverac8zNHsr4YsjvMmKS7tAy2aWfrPFe4?=
 =?us-ascii?Q?sRlhDTm9UClpw22nwX+LGSD9mDVPkj1kzwKBkK1MhmVlxVlg6Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 19:45:27.0587
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d072b179-dccd-42fc-ed8e-08dcff64ba93
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8459

From: Carolina Jubran <cjubran@nvidia.com>

Refactor esw_qos_sched_elem_config to set bitmasks only when max_rate
or bw_share values change, allowing the function to configure nodes
with only one of these parameters.

This enables more flexible usage for nodes where only one parameter
requires configuration.

Remove scattered assignments and checks to centralize them within this
function, removing the now redundant esw_qos_set_node_max_rate
entirely.

With this refactor, also remove the assignment of the vport scheduling
node max rate to the parent max rate for unlimited vports
(where max rate is set to zero), as firmware already handles this
behavior.

Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/esw/qos.c | 80 ++++++-------------
 1 file changed, 24 insertions(+), 56 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index 82805bb20c76..c1e7b2425ebe 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
@@ -143,10 +143,21 @@ static int esw_qos_sched_elem_config(struct mlx5_esw_sched_node *node, u32 max_r
 	if (!MLX5_CAP_GEN(dev, qos) || !MLX5_CAP_QOS(dev, esw_scheduling))
 		return -EOPNOTSUPP;
 
-	MLX5_SET(scheduling_context, sched_ctx, max_average_bw, max_rate);
-	MLX5_SET(scheduling_context, sched_ctx, bw_share, bw_share);
-	bitmask |= MODIFY_SCHEDULING_ELEMENT_IN_MODIFY_BITMASK_MAX_AVERAGE_BW;
-	bitmask |= MODIFY_SCHEDULING_ELEMENT_IN_MODIFY_BITMASK_BW_SHARE;
+	if (bw_share && (!MLX5_CAP_QOS(dev, esw_bw_share) ||
+			 MLX5_CAP_QOS(dev, max_tsar_bw_share) < MLX5_MIN_BW_SHARE))
+		return -EOPNOTSUPP;
+
+	if (node->max_rate == max_rate && node->bw_share == bw_share)
+		return 0;
+
+	if (node->max_rate != max_rate) {
+		MLX5_SET(scheduling_context, sched_ctx, max_average_bw, max_rate);
+		bitmask |= MODIFY_SCHEDULING_ELEMENT_IN_MODIFY_BITMASK_MAX_AVERAGE_BW;
+	}
+	if (node->bw_share != bw_share) {
+		MLX5_SET(scheduling_context, sched_ctx, bw_share, bw_share);
+		bitmask |= MODIFY_SCHEDULING_ELEMENT_IN_MODIFY_BITMASK_BW_SHARE;
+	}
 
 	err = mlx5_modify_scheduling_element_cmd(dev,
 						 SCHEDULING_HIERARCHY_E_SWITCH,
@@ -160,6 +171,8 @@ static int esw_qos_sched_elem_config(struct mlx5_esw_sched_node *node, u32 max_r
 		return err;
 	}
 
+	node->max_rate = max_rate;
+	node->bw_share = bw_share;
 	if (node->type == SCHED_NODE_TYPE_VPORTS_TSAR)
 		trace_mlx5_esw_node_qos_config(dev, node, node->ix, bw_share, max_rate);
 	else if (node->type == SCHED_NODE_TYPE_VPORT)
@@ -217,11 +230,7 @@ static void esw_qos_update_sched_node_bw_share(struct mlx5_esw_sched_node *node,
 
 	bw_share = esw_qos_calc_bw_share(node->min_rate, divider, fw_max_bw_share);
 
-	if (bw_share == node->bw_share)
-		return;
-
 	esw_qos_sched_elem_config(node, node->max_rate, bw_share, extack);
-	node->bw_share = bw_share;
 }
 
 static void esw_qos_normalize_min_rate(struct mlx5_eswitch *esw,
@@ -250,10 +259,6 @@ static int esw_qos_set_node_min_rate(struct mlx5_esw_sched_node *node,
 {
 	struct mlx5_eswitch *esw = node->esw;
 
-	if (min_rate && (!MLX5_CAP_QOS(esw->dev, esw_bw_share) ||
-			 MLX5_CAP_QOS(esw->dev, max_tsar_bw_share) < MLX5_MIN_BW_SHARE))
-		return -EOPNOTSUPP;
-
 	if (min_rate == node->min_rate)
 		return 0;
 
@@ -263,41 +268,6 @@ static int esw_qos_set_node_min_rate(struct mlx5_esw_sched_node *node,
 	return 0;
 }
 
-static int esw_qos_set_node_max_rate(struct mlx5_esw_sched_node *node,
-				     u32 max_rate, struct netlink_ext_ack *extack)
-{
-	struct mlx5_esw_sched_node *vport_node;
-	int err;
-
-	if (node->max_rate == max_rate)
-		return 0;
-
-	/* Use parent node limit if new max rate is 0. */
-	if (!max_rate && node->parent)
-		max_rate = node->parent->max_rate;
-
-	err = esw_qos_sched_elem_config(node, max_rate, node->bw_share, extack);
-	if (err)
-		return err;
-
-	node->max_rate = max_rate;
-	if (node->type != SCHED_NODE_TYPE_VPORTS_TSAR)
-		return 0;
-
-	/* Any unlimited vports in the node should be set with the value of the node. */
-	list_for_each_entry(vport_node, &node->children, entry) {
-		if (vport_node->max_rate)
-			continue;
-
-		err = esw_qos_sched_elem_config(vport_node, max_rate, vport_node->bw_share, extack);
-		if (err)
-			NL_SET_ERR_MSG_MOD(extack,
-					   "E-Switch vport implicit rate limit setting failed");
-	}
-
-	return err;
-}
-
 static int esw_qos_create_node_sched_elem(struct mlx5_core_dev *dev, u32 parent_element_id,
 					  u32 *tsar_ix)
 {
@@ -367,7 +337,6 @@ static int esw_qos_update_node_scheduling_element(struct mlx5_vport *vport,
 						  struct netlink_ext_ack *extack)
 {
 	struct mlx5_esw_sched_node *vport_node = vport->qos.sched_node;
-	u32 max_rate;
 	int err;
 
 	err = mlx5_destroy_scheduling_element_cmd(curr_node->esw->dev,
@@ -378,9 +347,7 @@ static int esw_qos_update_node_scheduling_element(struct mlx5_vport *vport,
 		return err;
 	}
 
-	/* Use new node max rate if vport max rate is unlimited. */
-	max_rate = vport_node->max_rate ? vport_node->max_rate : new_node->max_rate;
-	err = esw_qos_vport_create_sched_element(vport, new_node, max_rate,
+	err = esw_qos_vport_create_sched_element(vport, new_node, vport_node->max_rate,
 						 vport_node->bw_share,
 						 &vport_node->ix);
 	if (err) {
@@ -393,8 +360,7 @@ static int esw_qos_update_node_scheduling_element(struct mlx5_vport *vport,
 	return 0;
 
 err_sched:
-	max_rate = vport_node->max_rate ? vport_node->max_rate : curr_node->max_rate;
-	if (esw_qos_vport_create_sched_element(vport, curr_node, max_rate,
+	if (esw_qos_vport_create_sched_element(vport, curr_node, vport_node->max_rate,
 					       vport_node->bw_share,
 					       &vport_node->ix))
 		esw_warn(curr_node->esw->dev, "E-Switch vport node restore failed (vport=%d)\n",
@@ -707,7 +673,8 @@ int mlx5_esw_qos_set_vport_rate(struct mlx5_vport *vport, u32 max_rate, u32 min_
 
 	err = esw_qos_set_node_min_rate(vport->qos.sched_node, min_rate, NULL);
 	if (!err)
-		err = esw_qos_set_node_max_rate(vport->qos.sched_node, max_rate, NULL);
+		err = esw_qos_sched_elem_config(vport->qos.sched_node, max_rate,
+						vport->qos.sched_node->bw_share, NULL);
 unlock:
 	esw_qos_unlock(esw);
 	return err;
@@ -930,7 +897,8 @@ int mlx5_esw_devlink_rate_leaf_tx_max_set(struct devlink_rate *rate_leaf, void *
 	if (err)
 		goto unlock;
 
-	err = esw_qos_set_node_max_rate(vport->qos.sched_node, tx_max, extack);
+	err = esw_qos_sched_elem_config(vport->qos.sched_node, tx_max,
+					vport->qos.sched_node->bw_share, extack);
 unlock:
 	esw_qos_unlock(esw);
 	return err;
@@ -965,7 +933,7 @@ int mlx5_esw_devlink_rate_node_tx_max_set(struct devlink_rate *rate_node, void *
 		return err;
 
 	esw_qos_lock(esw);
-	err = esw_qos_set_node_max_rate(node, tx_max, extack);
+	err = esw_qos_sched_elem_config(node, tx_max, node->bw_share, extack);
 	esw_qos_unlock(esw);
 	return err;
 }
-- 
2.44.0


