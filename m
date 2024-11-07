Return-Path: <netdev+bounces-143034-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 216A79C0F37
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 20:45:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A40901F23EE1
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 19:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C052178E3;
	Thu,  7 Nov 2024 19:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tcytmU4j"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2084.outbound.protection.outlook.com [40.107.243.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBA72170D1
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 19:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731008728; cv=fail; b=egKGj5m1x2eXRFx+rLTkN4TBO/Z/T/YUfFznxiPhcwqPuM31rCRupLntH5jhTdzxr8o/aXPNGQG1lKAeWR/UG0RJfA2DDL2L0T+svLRRJMdVrUHuF3olmzMYRtbK0Pmyz0jP1oIYbQimFvQHnmnELd0uQLEBIZMMHj8mCOKhxl4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731008728; c=relaxed/simple;
	bh=wnVS/VdIZ7Z0W3v1YITKRxayyw9C/lrG/GfeS2ZsVFo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I26nmPTSF1lWW0gKL9KeZSrOgIxiJEj2qXEJDE0Ww1eIi9YFapR5Mf/B9R8Xta4K2dRsN97w71uirpa1GjcRFXKAAceFUceGqTubXyqI/1KP3j3avkYXdJIRZ4aI/kg5A1zAzEmVts4YlD7Qu9KgOYtXyh9kWSqbv1sI9lYDtIY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tcytmU4j; arc=fail smtp.client-ip=40.107.243.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yv5ypC896TjJXd9lM3HuplOvZTiW8GO2i0ED5p+jngL94TsCxMTu12QQZc+vLXMk9lcQjS1eyGAhhUwLfPExRJqmydAs6EFP3+ci/inCnWbuu7C2NqiA1Y/BLuHB6mkEcAbA1f8NUn8k13Y+r9t7ISn60SQabSTZd2csJV2fDhta8uuVWzmWH7tmXSLTMOFJrlgFv/7IxixJaCzpf4n2tXHNwLhA9RZLUla6wzOiY1d98ADOTMNNeGIltlpOHn3zsue5DrqhUTQhCliB3vf24BjjvJ/qsedSK98p5a5K8m73jVTA/ph7YF5PEAhdLYLU0MQosGS3Jr+9Q4VJjw/q1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1eq3bxGler0lM0gaVkH8bxdUCh7jYIxI+MxEpBzUk/Q=;
 b=HYy1GECqfWba9yFExjb0WQ+joMPInTea0BUEK+K4TBuVS3TZlkzR0fzdWIfy9KhlQ0VIhmzxBfciXqPgtRkk6/5AL2X3118fF2idlZSzMUChK10dNbSyvbB5+XrtzdAU5e3iEMyNrRIwoYHKiO+Snk4I3KFJTAa0rw0X6FWCUdmbtTfv47EQ9i+VRdJi+qXREzxXOlPwZIhr1fBcJtvbGZqLXle8gt/sfAKNZSrVfV9BtRy13sIMrPJh0A3I9hsaTaN0E+ndV9xSCnGlOvOVLgo/TTgBKmFhwAm10Xb6bWpgE47xqqR8sxmCORl8SWoG7qPXuhrx/pnVNZjKnGm1Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1eq3bxGler0lM0gaVkH8bxdUCh7jYIxI+MxEpBzUk/Q=;
 b=tcytmU4jl7bwj7iQgVM2mGXoF1bxUtWmA00Uoz6w1++Ld/3RMtWVTSfvgdVn1rwV/6owri8iV43FdCcqBXVizi+ItXjxQcFmy6PVkOgDAI9CDBhyvVBSsTNEuWh5CLsfFoHQqAMDzR551INwOFFjRxjFwvTfNERs0RFSqFCZs64Ir9fFZH8z21UU0Z2GQtG/Nk1fcW9owTub+RRLLNAKLGpn3ihKiDo025Asx/Ze4T7wD69O4f7QKXzTGIC+oFb3DiJUm7G+vbHQfwEuxawkjdKe3rJlAIcTB2+rGgDYVKvtH3Er0kYI8BFrKzHWvDzNxrQAExKVZIZHAZACMFSFFA==
Received: from BYAPR01CA0036.prod.exchangelabs.com (2603:10b6:a02:80::49) by
 PH7PR12MB9073.namprd12.prod.outlook.com (2603:10b6:510:2eb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Thu, 7 Nov
 2024 19:45:23 +0000
Received: from SJ5PEPF000001EE.namprd05.prod.outlook.com
 (2603:10b6:a02:80:cafe::e8) by BYAPR01CA0036.outlook.office365.com
 (2603:10b6:a02:80::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20 via Frontend
 Transport; Thu, 7 Nov 2024 19:45:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001EE.mail.protection.outlook.com (10.167.242.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.17 via Frontend Transport; Thu, 7 Nov 2024 19:45:22 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 7 Nov 2024
 11:45:04 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 7 Nov 2024
 11:45:04 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Thu, 7 Nov
 2024 11:45:01 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Carolina Jubran
	<cjubran@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net-next 03/12] net/mlx5: Generalize max_rate and min_rate setting for nodes
Date: Thu, 7 Nov 2024 21:43:48 +0200
Message-ID: <20241107194357.683732-4-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EE:EE_|PH7PR12MB9073:EE_
X-MS-Office365-Filtering-Correlation-Id: 30e572a3-f6ca-4b92-a0a3-08dcff64b7dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Tw7/7Lf0xAJT07wzD3m9IS7tHd5fgxBOaQnyJEtiuIjplPur0ipAZFNW2Z2d?=
 =?us-ascii?Q?2v0kvPZp8UgE+j5RkZ97gnzTMg0Qeea6f1jpZk38J6tXaoSJaRsEmrZTAuL1?=
 =?us-ascii?Q?f0EhZiW4Nr9VfE+e6E06rS+/CmudWKSWZlT0bVE3wBJBIN6yVRd3VIte+RWT?=
 =?us-ascii?Q?mRxrfz2NgrICILKUpZe27rEGDi21AA6zFwqrDcNpx4pao1aEBmWXY8Wbhm7i?=
 =?us-ascii?Q?L8R6utstOCy87sJNdlFQ/GtB8X/XfZE8gh2EHLQtwP0bwcUFQEvvkGdGfDFQ?=
 =?us-ascii?Q?3aUxiUHr7faA3HvndFndPWGZhiM07ZVPkyKahSuKbxJpOFTnv37iJOJNLnDY?=
 =?us-ascii?Q?zr6t/yy53+z3uTrWI82/6tznDv3u9A1+UCRn4O4cQSAnaFg9I6mmdKbLUdte?=
 =?us-ascii?Q?E83Mu3my8nEk9cF0SczD2CPj5qsvmt8uVsJioQI9eOwg3w4g81AtLZQ/go/g?=
 =?us-ascii?Q?YRW4sig3m37BbV+1zWAyWJ6Cohoo93Z1frqaS9CDUkIYGBDtwC+357L7VApK?=
 =?us-ascii?Q?6TuPfP1mZFS+pS6rkGp3ZOM5tI0x/yzVD/L+fuy32qXCcDiIpiyLmjrElEpF?=
 =?us-ascii?Q?+DKYDNVEQV54fYFChw2eF0Mvp5vI7Jc8VykNNgu4GNB96hL/Y2iDu8lHE6V/?=
 =?us-ascii?Q?1Ki+cVRdnrkI/tgCVV5ijI0RUCjdW98AXgAUt51H2ldep0xNn4efxVIwkcPq?=
 =?us-ascii?Q?ZUcNHJW3MCLNyOQwr+lONY/8h4Ih4btHltVc82USql8OTn82NKqSQrEQ2g+D?=
 =?us-ascii?Q?e2OzD+IEODdJzTZf0rS3+V+vkchSyvTNZpCKf50/Rmrx0AZZ9biViqnj1BNo?=
 =?us-ascii?Q?93p1/OoNQKjdEmh6xWq5l+AqP3pNZqTJqpjeR7i08mDZ6DoH3dHuv/v3JjE8?=
 =?us-ascii?Q?GX6xdZ+rpNxTGVLJLGF6r3lT5pvKXWt3fWmVwrmfzfor4K7qSMzYNwFx3tsp?=
 =?us-ascii?Q?3KujnRLm//ksi2T8Dg3SzVWi1sf5Q5aa2EkyhvWx0FO+TmMIKmHjdgZ1thPe?=
 =?us-ascii?Q?c+XkXQYzCz2cUaahL3u3r1bonLrTBtagZTz2/O0tmiWbnWJyZCpdE2gsY/qA?=
 =?us-ascii?Q?ssLm2RkkKNuMcZMIr1BnTaOV4RzwiOp9RGHDUhOZOVnx/WmrYZ+js8dSk2jk?=
 =?us-ascii?Q?LeKwb885ebB3wTXiZ84A4XgaEDLXAbUD661oayJTMGK7FqUb7wHwvCPoSV5s?=
 =?us-ascii?Q?JPnhc42oNACOZAjYTQeDpkqOCkcHmjlzeLAdqGqBeV5JvXVFDarn3RwqjjPv?=
 =?us-ascii?Q?IHAyojiLcUOo8NYpTa4wJb0ckay7P8Bxm+8aeQhVYm0LnQ9PuIpOLdhE/zaz?=
 =?us-ascii?Q?3WNxNpA92gboYYrPZfNdzJlH/FCCeQ/m9OHFYIlwvwDzydtbfoxGW/AT7mTU?=
 =?us-ascii?Q?bJMJx4s8Tr3uJQjEa1nPGDKJziJZ2WUC0PH15OifYcoV+YQv/Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 19:45:22.4772
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30e572a3-f6ca-4b92-a0a3-08dcff64b7dd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9073

From: Carolina Jubran <cjubran@nvidia.com>

Refactor max_rate and min_rate setting functions to operate on
mlx5_esw_sched_node, allowing for generalized handling of both vports
and nodes.

Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/esw/qos.c | 69 ++++---------------
 1 file changed, 13 insertions(+), 56 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index 0c371f27c693..82805bb20c76 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
@@ -245,69 +245,20 @@ static void esw_qos_normalize_min_rate(struct mlx5_eswitch *esw,
 	}
 }
 
-static int esw_qos_set_vport_min_rate(struct mlx5_vport *vport,
-				      u32 min_rate, struct netlink_ext_ack *extack)
-{
-	struct mlx5_esw_sched_node *vport_node = vport->qos.sched_node;
-	bool min_rate_supported;
-	u32 fw_max_bw_share;
-
-	esw_assert_qos_lock_held(vport_node->esw);
-	fw_max_bw_share = MLX5_CAP_QOS(vport->dev, max_tsar_bw_share);
-	min_rate_supported = MLX5_CAP_QOS(vport->dev, esw_bw_share) &&
-				fw_max_bw_share >= MLX5_MIN_BW_SHARE;
-	if (min_rate && !min_rate_supported)
-		return -EOPNOTSUPP;
-	if (min_rate == vport_node->min_rate)
-		return 0;
-
-	vport_node->min_rate = min_rate;
-	esw_qos_normalize_min_rate(vport_node->parent->esw, vport_node->parent, extack);
-
-	return 0;
-}
-
-static int esw_qos_set_vport_max_rate(struct mlx5_vport *vport,
-				      u32 max_rate, struct netlink_ext_ack *extack)
-{
-	struct mlx5_esw_sched_node *vport_node = vport->qos.sched_node;
-	u32 act_max_rate = max_rate;
-	bool max_rate_supported;
-	int err;
-
-	esw_assert_qos_lock_held(vport_node->esw);
-	max_rate_supported = MLX5_CAP_QOS(vport->dev, esw_rate_limit);
-
-	if (max_rate && !max_rate_supported)
-		return -EOPNOTSUPP;
-	if (max_rate == vport_node->max_rate)
-		return 0;
-
-	/* Use parent node limit if new max rate is 0. */
-	if (!max_rate)
-		act_max_rate = vport_node->parent->max_rate;
-
-	err = esw_qos_sched_elem_config(vport_node, act_max_rate, vport_node->bw_share, extack);
-	if (!err)
-		vport_node->max_rate = max_rate;
-
-	return err;
-}
-
 static int esw_qos_set_node_min_rate(struct mlx5_esw_sched_node *node,
 				     u32 min_rate, struct netlink_ext_ack *extack)
 {
 	struct mlx5_eswitch *esw = node->esw;
 
-	if (!MLX5_CAP_QOS(esw->dev, esw_bw_share) ||
-	    MLX5_CAP_QOS(esw->dev, max_tsar_bw_share) < MLX5_MIN_BW_SHARE)
+	if (min_rate && (!MLX5_CAP_QOS(esw->dev, esw_bw_share) ||
+			 MLX5_CAP_QOS(esw->dev, max_tsar_bw_share) < MLX5_MIN_BW_SHARE))
 		return -EOPNOTSUPP;
 
 	if (min_rate == node->min_rate)
 		return 0;
 
 	node->min_rate = min_rate;
-	esw_qos_normalize_min_rate(esw, NULL, extack);
+	esw_qos_normalize_min_rate(esw, node->parent, extack);
 
 	return 0;
 }
@@ -321,11 +272,17 @@ static int esw_qos_set_node_max_rate(struct mlx5_esw_sched_node *node,
 	if (node->max_rate == max_rate)
 		return 0;
 
+	/* Use parent node limit if new max rate is 0. */
+	if (!max_rate && node->parent)
+		max_rate = node->parent->max_rate;
+
 	err = esw_qos_sched_elem_config(node, max_rate, node->bw_share, extack);
 	if (err)
 		return err;
 
 	node->max_rate = max_rate;
+	if (node->type != SCHED_NODE_TYPE_VPORTS_TSAR)
+		return 0;
 
 	/* Any unlimited vports in the node should be set with the value of the node. */
 	list_for_each_entry(vport_node, &node->children, entry) {
@@ -748,9 +705,9 @@ int mlx5_esw_qos_set_vport_rate(struct mlx5_vport *vport, u32 max_rate, u32 min_
 	if (err)
 		goto unlock;
 
-	err = esw_qos_set_vport_min_rate(vport, min_rate, NULL);
+	err = esw_qos_set_node_min_rate(vport->qos.sched_node, min_rate, NULL);
 	if (!err)
-		err = esw_qos_set_vport_max_rate(vport, max_rate, NULL);
+		err = esw_qos_set_node_max_rate(vport->qos.sched_node, max_rate, NULL);
 unlock:
 	esw_qos_unlock(esw);
 	return err;
@@ -947,7 +904,7 @@ int mlx5_esw_devlink_rate_leaf_tx_share_set(struct devlink_rate *rate_leaf, void
 	if (err)
 		goto unlock;
 
-	err = esw_qos_set_vport_min_rate(vport, tx_share, extack);
+	err = esw_qos_set_node_min_rate(vport->qos.sched_node, tx_share, extack);
 unlock:
 	esw_qos_unlock(esw);
 	return err;
@@ -973,7 +930,7 @@ int mlx5_esw_devlink_rate_leaf_tx_max_set(struct devlink_rate *rate_leaf, void *
 	if (err)
 		goto unlock;
 
-	err = esw_qos_set_vport_max_rate(vport, tx_max, extack);
+	err = esw_qos_set_node_max_rate(vport->qos.sched_node, tx_max, extack);
 unlock:
 	esw_qos_unlock(esw);
 	return err;
-- 
2.44.0


