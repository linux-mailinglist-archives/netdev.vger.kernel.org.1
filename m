Return-Path: <netdev+bounces-134907-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 948CD99B8A5
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 08:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D245282694
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 06:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA2F5136657;
	Sun, 13 Oct 2024 06:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZeC+hB7a"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2061.outbound.protection.outlook.com [40.107.236.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6F9131BAF
	for <netdev@vger.kernel.org>; Sun, 13 Oct 2024 06:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728802023; cv=fail; b=gta5/evdIr/XjdoKEQ2b+Zl8s7WxtTfHC2AH81MlzTlOkGZAiIZbYZatcpuxfFw/nRd1h/bLJ+TDmqjdM9WviCCu5ayRa8izWTOj9jtGlEwWlwSXvdcb4eu5yRAcK5TGkTc6NniEPoQO/nQ/75WIyF/pDaIkOhSGARRDhCoxI1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728802023; c=relaxed/simple;
	bh=7S3DGItSTLwaX9OaHaY0F+NPXk2M0vISpEzBDk87P/s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aR5OpuLrmR2Qm9JgqxBN7HSerFuQkG5FTLf78QK6/qiMNpxCgNcA0UrJt2JtNn1WJlblYbxKdJjMe4+/Au/hxxzV1DPFsoFhfQUdEvafME0PvSkeVuYmZLheUbeBqzVJxzoEFQ1OQqALx2MxWblzg9d4SgvBdXgSV8fGr+b9L8A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZeC+hB7a; arc=fail smtp.client-ip=40.107.236.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DgGXyhQA2EL9AgNDAvKqdhZh2UNZ/iYqqtipM0dOBc/y91AGNhkqtPjPOTXlBbvqmyNnMWtSM07TRHZCc2n7IcNnkBaLmfvha1i7STq7RCWOnxg4kEQ20jB8AOo/o1S/GabGR3NaNUyfHXyP1eT1OqKgV9c7FcbgORA08x98dDBMU5c6FNJyfWIdxN7+fLqtdgzwqpPMH51gi0QRYv+wr/pzyrKucHkzvrL3Mwxf+jmP8FBC/Wf3zr4CWVPkreAG7v4h/30iL0vMX9hu430cgt4w43tmRbJV1uxZxZcTDyBEdoeDNj6V6NliC0+UTPsozZ7HLih+UldeiU/HrLKxrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=19DexOcbRwDu0tJr87Og7dJuCOk8pJ0jqP1J/bdX3ac=;
 b=yoDe2dfaEOOP5XJLmxwrBByIYBVxeyBu9eQo1V/wbuYoMOXgtKjCzPgGO/2Bwd5actFQJ9if/HFvceQrvlpVEAavsycTT3Th7PYbdYH3uJONMxpaLM4Ux3Epjyql5oyShcUY5Y+IcMaw+ZiibgPi3gcIqeGtKB37G/kh7qX8ufbj8n9ZynxcaMrnXwFAH4yOOk9KhHY5TbKiCLqDksULxngfxo1KICMv+xGgLJUwtC6JXcegF2f4oB5qalnHTwF2gPsphgLUHQGUgAZefr+Lr66FAmU8AnzAebuzKu0uJ6g0XVCDd+B4GCKR4Z//0obLXxg+nnfexkd8hnNz/HSAGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=19DexOcbRwDu0tJr87Og7dJuCOk8pJ0jqP1J/bdX3ac=;
 b=ZeC+hB7ak7vVEfXiffA0xYXPtuMHH1/gVUuGQ8ixQJpFl1GP5fsSboD5Ija69SA01kWYUS8zO2ect5PXjqfe4Lot1pLxckNI+oFMgj/TwPYaQFU0LXrduXKSiDHMUhPwyRhliXjWFp/j7dg1pDv8TcA58emjThMy5RodVQ9MxY7gA/0GfezllUVhyPQ5hdu0wX8LDllEDBpl9wAGqFzSgoY576RO5f72E6dqSPEYKBAYsfXBFhSD3IodyOKglJtlzo0iSnJz2L0jEFM/4kHuF+hhLwr0QjeA3eXJKT+PiwaEw83LmewhRiBjE1gXxkTHdq3rspLZqbiYb3WeY7zmmA==
Received: from CH5P221CA0003.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1f2::22)
 by SA1PR12MB7293.namprd12.prod.outlook.com (2603:10b6:806:2b9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.22; Sun, 13 Oct
 2024 06:46:57 +0000
Received: from CH1PEPF0000AD81.namprd04.prod.outlook.com
 (2603:10b6:610:1f2:cafe::d3) by CH5P221CA0003.outlook.office365.com
 (2603:10b6:610:1f2::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.24 via Frontend
 Transport; Sun, 13 Oct 2024 06:46:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH1PEPF0000AD81.mail.protection.outlook.com (10.167.244.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.13 via Frontend Transport; Sun, 13 Oct 2024 06:46:55 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 12 Oct
 2024 23:46:47 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sat, 12 Oct 2024 23:46:46 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sat, 12 Oct 2024 23:46:44 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, <cjubran@nvidia.com>,
	<cratiu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 10/15] net/mlx5: Simplify QoS scheduling element configuration
Date: Sun, 13 Oct 2024 09:45:35 +0300
Message-ID: <20241013064540.170722-11-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD81:EE_|SA1PR12MB7293:EE_
X-MS-Office365-Filtering-Correlation-Id: ee12194f-683f-41ee-daa4-08dceb52d40c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hNeLnc3VRC3x1m8846ugROKYXSEehwlj3AF8zmJo+UlWLEzwgs3CldD6Z1LB?=
 =?us-ascii?Q?aGrEj7wh61VsRvxoFziQEFkhgmKRIDTKrJv0A4ktm+oPFlJWgMoN+mUARol5?=
 =?us-ascii?Q?aJw9bSWczZdyTeV6EKHW9BOKwg7Zpks9gR6WTdycn6XDgS2x/VovJnqa/pX2?=
 =?us-ascii?Q?vBCoVYQDIJRYv7gQLdx0e2u3/ISSIyIAV1m8FQlNQnJqsOGBIHfOSd+M4Rm7?=
 =?us-ascii?Q?y+uHzn6BZ51vufOy0xViRAjDnPYXEP1sI9zO610CZeVgmJh2MTMVgxxWZJ6V?=
 =?us-ascii?Q?hetsac5ae+UG1JFvY3w3hnHKNWUgvk/iZcMVhr8yTyJd/Ctc8Ly1Cvsj2Kfv?=
 =?us-ascii?Q?01PoJ1L3oM4jo97Bz58judHfSSgyJWQKfFoL+uprZ24ZPMI0MSJTJkGBQ9+9?=
 =?us-ascii?Q?Z9QT/l7eyxtXMVahrOgnAxwx43uO5mFboKor6teIovJgpo70rysIlF5sfjA4?=
 =?us-ascii?Q?3BfUFoyH+7jfoJ5Hs2zgUEMJJrdT7APA8c7+C55XYXoRosnCG/6IsFR/x8n7?=
 =?us-ascii?Q?ruW3E2M8iO7bVhtfrKaZ+eCZM3ZLF7bMyICGvLH+PT2avPYeD2oa9cao1F7K?=
 =?us-ascii?Q?hUYqOmj0FEw4Dv5st9LjlXeJB+qqiVZga6NoKRCaaS5fp5NJ86aTgR/39nrE?=
 =?us-ascii?Q?txjqCzTgLSOrBnhvQYlKBBicarCzP41jPCQQ8f8TKTCrh/YcuKrQvyCtmV1v?=
 =?us-ascii?Q?AxPZC9cxR6JYjyfDsPOqfrGDkAvXFZC7kSLnPghWghtm7eYomqfqEuYYPQrd?=
 =?us-ascii?Q?bKqb/eyqmnKffhPPTUyj76Aa0UVd6lCME2eCmBV1Gtm6sA0+ga7N73YExRp8?=
 =?us-ascii?Q?OZ1DIjAOKUyZzc+gRTAcIElaxgoTiyMaaDs0zeIyXzq7HP46VWGxmnn4AHYy?=
 =?us-ascii?Q?yjp62m7Vq3EPpH17saBO4H/kjSwMj1DBmgiG/RHqFicoJljNJJnU//V0j0IU?=
 =?us-ascii?Q?k2BjIcn71h7MjyUmIRTiql75chkb3xNyu00p8jxNb9kHJsCAWhHzmmFz3emJ?=
 =?us-ascii?Q?EaBwsipbRf+BxeBzSSIab10+1y9iFGeTjw+c/Z7peRQZO6Hp+0TIeKS59VvY?=
 =?us-ascii?Q?RJsjrByIxmZEf/5Ai+EM7cmmhKBRegQDIvZPRP+lG3/1ERbvC7C+4dGMBSl0?=
 =?us-ascii?Q?A1QnejrayWU4Wt4drrkjRinJyTDlIVlOh+3YHMDxjRCHaanI3B5YKvCJxg+v?=
 =?us-ascii?Q?tKRYcM7EmcKYSRILlUbWn3jzpVRkdxO29dzuW/yGnbrJ50UhvhltQoCjei1q?=
 =?us-ascii?Q?AP7nCx5PA/fWd49LHu0ceL7Kbo/f3rMuNbQ0gVwqSMRZgIMgSl1alMcQIoVV?=
 =?us-ascii?Q?Sc6rrs3pJkaWF2+it6qSmGsJBYnYF5gqH0tEm2BZgHOEcmsi7r5XgP6Za8sD?=
 =?us-ascii?Q?mHsyAcH15xw0fVy2Njw3wyxmvuQK?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2024 06:46:55.5819
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee12194f-683f-41ee-daa4-08dceb52d40c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD81.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7293

From: Carolina Jubran <cjubran@nvidia.com>

Simplify the configuration of QoS scheduling elements by removing the
separate functions `esw_qos_node_config` and `esw_qos_vport_config`.

Instead, directly use the existing `esw_qos_sched_elem_config` function
for both nodes and vports.

This unification helps in generalizing operations on scheduling
elements nodes.

Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/esw/qos.c | 86 +++++++++----------
 1 file changed, 40 insertions(+), 46 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index 0f465de4a916..ffd5d4d38fe5 100644
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
 
@@ -340,8 +336,7 @@ static int esw_qos_set_vport_max_rate(struct mlx5_vport *vport,
 	if (!max_rate)
 		act_max_rate = vport_node->parent->max_rate;
 
-	err = esw_qos_vport_config(vport, act_max_rate, vport_node->bw_share, extack);
-
+	err = esw_qos_sched_elem_config(vport_node, act_max_rate, vport_node->bw_share, extack);
 	if (!err)
 		vport_node->max_rate = max_rate;
 
@@ -386,7 +381,7 @@ static int esw_qos_set_node_max_rate(struct mlx5_esw_sched_node *node,
 	if (node->max_rate == max_rate)
 		return 0;
 
-	err = esw_qos_node_config(node, max_rate, node->bw_share, extack);
+	err = esw_qos_sched_elem_config(node, max_rate, node->bw_share, extack);
 	if (err)
 		return err;
 
@@ -397,8 +392,7 @@ static int esw_qos_set_node_max_rate(struct mlx5_esw_sched_node *node,
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


