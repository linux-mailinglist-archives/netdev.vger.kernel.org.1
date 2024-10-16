Return-Path: <netdev+bounces-136216-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D139A10CD
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 19:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DA9B1C2242F
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 17:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA725212F10;
	Wed, 16 Oct 2024 17:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sAzpoMxD"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49613212659
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 17:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729100281; cv=fail; b=USxiEfP0RdcapM8ZiM9SqOFRqzJmD2KzKyIjvVYSlFPxwgRBhfki6TcBwlwgy8b3L8HqmK4XSrt3jgEFj/WIOr01AEm4018BYm9gfhTTobQPjHeuYWnVa8LVUtX19mATbwrz19FWtSKiYYu7KVmipWDTv/HPhBIU5v8J6TCODpE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729100281; c=relaxed/simple;
	bh=VPeyPtHMKLSW93aSzn+4BiLumNQt2ggmUcEQXiILRCA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sz199yH5XWNM+hkMrI2i9n/AnoGb6AOlbXBSd2mQ+H31zyTl7XvjSUb8MSsseWLSxK8+O1a+XBRecFLsdJB1DtGWs4Ij4o0DXDc5plXr5hXLYAG6Z7T1s5ZdHbfDpoam62JPePkUfgnLhYCA4iNhWHMwamBgJzGk+1UzrUZNRaw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sAzpoMxD; arc=fail smtp.client-ip=40.107.243.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lzY5Sv4C4q/f3ITpsOT/TfiLrJ139qd3QQlHy34LazyckmQ6RTdonBjp/d8Mea3A3XCZfbQnVGZiDD7GsrAuMJSJj/+qyK2RVKpyw2abtngSCbShRdQ42Hxxcm0il4T7a7qvUc5I0bXxtHLEMEdK/kbyaUmsqTiUX0q0JlANOGTlfLXbIsNG1JFP9h/PzrlJdptlti1X/gEAhqZaEJdZLEsi/Kk9eUjpiInjgUmD4jWCohRZKvs4p5vmKx7Sz0WliS54HuTK+i2RAXMHq1WZTsAFxYixMH1/ejjajZwd7mv8whU2j0crZoudLJ288n3jt0L20zV8uB8ZnVeztwuPLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WA0XpVgpB6VaewpQ2A241hsMURUdKxbChm1SKoPBT04=;
 b=EjeO+d9w9yHtWwqZfev7DT9hjBU/AfhQlKfJyy9cUB6v3ONaO/k7uQlI00RJqpmI6zIjkJJ/QfohMlxt8QesgE7FsL99GQm/ZqnrD2Easbek1ALuCNkKm+CqKekteKdq/d3JsblT83gojWA0Aa87xuHpfhtc2VU190dDuw7X5e9u2Wmaw7+jhBNSXQxtuFOVq+HcTJs2/PvY08IrtDBznw/2vwHKuiesBke/NBRs5W7RYjcxC3s4Pnyn2A9HvOR9XYxtKRf4eW+rR8luFr0iANinGLbVWjiDesWt2eLMYrXbREd7OX9dt3wcpIuSqBLj3xMGrTwMdvhqJ8hCMw0Clw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WA0XpVgpB6VaewpQ2A241hsMURUdKxbChm1SKoPBT04=;
 b=sAzpoMxDl/kxiwbcVqNMGeurkiefJD4NXcX4pQ+V5CZdMkyAkFYoYOfOzJWtJcjADsuT1B4U5LCqmYtSUy6Qsi7uTx0/XLmQqjodtTVb213NHf3ll26OrIcSZvvYPtmqMKaTHaFIX5GK+ynHWOSmmP+ttYE7BP9xirnjV1hFJbI9MZMAFrWWpklid06gqgzOKHRK/J1lveS9xLdpo7WwbmXYWUvsrfyhbXleYjr0j5M25s0KDYbrYu+EdnHxXiTUIrXhlFictVFXfYJSLi4PbL8EzU+PUmB4+CdamXRfFF4kOhII/x7hUnmJiXAVaizhih6zblBJRo6cebFm5qZKag==
Received: from SJ0PR05CA0007.namprd05.prod.outlook.com (2603:10b6:a03:33b::12)
 by DM4PR12MB7551.namprd12.prod.outlook.com (2603:10b6:8:10d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Wed, 16 Oct
 2024 17:37:55 +0000
Received: from SJ5PEPF00000203.namprd05.prod.outlook.com
 (2603:10b6:a03:33b:cafe::74) by SJ0PR05CA0007.outlook.office365.com
 (2603:10b6:a03:33b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.15 via Frontend
 Transport; Wed, 16 Oct 2024 17:37:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ5PEPF00000203.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Wed, 16 Oct 2024 17:37:54 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 16 Oct
 2024 10:37:40 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 16 Oct 2024 10:37:40 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 16 Oct 2024 10:37:37 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, <cjubran@nvidia.com>,
	<cratiu@nvidia.com>, Simon Horman <horms@kernel.org>, Daniel Machon
	<daniel.machon@microchip.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next V3 10/15] net/mlx5: Simplify QoS scheduling element configuration
Date: Wed, 16 Oct 2024 20:36:12 +0300
Message-ID: <20241016173617.217736-11-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000203:EE_|DM4PR12MB7551:EE_
X-MS-Office365-Filtering-Correlation-Id: c69e3c4a-f674-432d-a97d-08dcee094467
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uehUQ/AxCVifTLXH1OwQUzSCZd0ERYf5b29Z0KgjZ7pb7cb7G9h5R3Ry3QxS?=
 =?us-ascii?Q?J5dWyYJRV1uwc/BEjtI0b4N4fWBXCe3biTGrWB1qN5Zy+KtIyeDv+BO8OWzp?=
 =?us-ascii?Q?nGiV6MxBOKakMM7XE2+wmjlIh0FH1Z9Ziu0u3AqQRTzs2X7fHTFfg/LJcE4J?=
 =?us-ascii?Q?ONKBe8am7zO53RLmRrppTKWwLqZHRjTNYIDwaGsrRskXkxh+Qk5ej1sfh+wT?=
 =?us-ascii?Q?TxxHacNkeSFHEEYZq2OKbHr2cy475M187hDRR1bTw8JqFCk92X1Y5uEQuMeU?=
 =?us-ascii?Q?INEO/06o/QhZfAtHxBLEviqngjNs3ny+DMkcvXnvfDt5sWgrCN9FcgskBQmw?=
 =?us-ascii?Q?RV9zdi8qnp6PW+vrZJgNkbsxiJcjZKV4bevZ3LEx4ICHCG95p++ZOuQEc3Cc?=
 =?us-ascii?Q?cydQcLlKRPAocI8mYtVtoMUph9swTsT2kOin8wx3JOTCbrHbNXVJCj8XAfy2?=
 =?us-ascii?Q?f0d5tNHT5/31YA0fGJk6WMVFlRyLH+NFRnIWyr4LGsUYzTgUP2mW89jh5Mbe?=
 =?us-ascii?Q?WXMUxMoeCwomMA2z4PnCmwNfuLRDBTT7ekRJePK8/2S9Qao/yVBWIkc8UrmC?=
 =?us-ascii?Q?q7Vt59lc5NKUO/WsXJmj+wbK7rK3hRG14BAnxNhvfA8k6LLjRYf5MXfjlfBt?=
 =?us-ascii?Q?z2+pnS7BS6mxTA2QKI5yTj6IxUwLVjDJFjmU3+EBOVEk90NVxfFD1XFOKCMZ?=
 =?us-ascii?Q?JYfavvAaGtvkjRHqfXlNVX1dLdPwLpOtfXNnStpxsH7uOWUiyIpM7qufWY3R?=
 =?us-ascii?Q?e4CVZq61zfs7lt/hEn1KHVUovMn1YCHiXuDARImLbE+m/dU0OWqfBsBrtZpp?=
 =?us-ascii?Q?fn7wGEsO3ip+RhncxGMxV65Oj1qkJrnG5woPVWaEcuiv75J+Qx+9IIuRKv7r?=
 =?us-ascii?Q?TubxwgqJSeJw33XCnSEsjqgfdjz15RHYWtsULNVRSwywlPNx88wP4QBn1G/S?=
 =?us-ascii?Q?XafDr1cVAgQpi6XdJE/5V8kERHAPQOX9L2tkgYCjcD47ClJWxIFXtsLgdQ4d?=
 =?us-ascii?Q?7umyGHnsMwr0tpDmPBlIcbot1lzivQpCUjMg7b6u3znuoQLMY2atK5dr/Mgm?=
 =?us-ascii?Q?UoO1sU3SYK8QlGl7Pb1HiWY4RVO+KNrDwfFRY11Fuo2idopX/SkIuTjqU5Vj?=
 =?us-ascii?Q?zw66VHNNhApvNieTe92kcbt5ob1ZCpXnJK5Rv0g3rzoV25PrJugy7Arpe82H?=
 =?us-ascii?Q?EWxFouO1D56yUSfSmb6ME1ZXQ/c3r2F66TqSoZFJ8VgPg7RVhBpjIvAld3v2?=
 =?us-ascii?Q?WgyJpmadzYNHulbeu0NIWZU4I/PSkDP+MsbobigmVDB9FeOlJgNQXxO+dA9e?=
 =?us-ascii?Q?do23ZCIj654cIkR/hpuRWqzlapkno/yKuRQD9PAdrCGws3/F8gZQMr/i0xdx?=
 =?us-ascii?Q?HZrxS8UnLNZDaR9TTmg9WSJ3+qIK?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 17:37:54.9372
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c69e3c4a-f674-432d-a97d-08dcee094467
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000203.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7551

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
index 77e835fd099d..7b243ba5558c 100644
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


