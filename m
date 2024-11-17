Return-Path: <netdev+bounces-145682-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CAC49D05F3
	for <lists+netdev@lfdr.de>; Sun, 17 Nov 2024 21:52:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5CEDB219EA
	for <lists+netdev@lfdr.de>; Sun, 17 Nov 2024 20:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395A31DDA09;
	Sun, 17 Nov 2024 20:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RW4Kg2NT"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 373AF1DC184
	for <netdev@vger.kernel.org>; Sun, 17 Nov 2024 20:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731876744; cv=fail; b=XwHQC4NwMOB2qgD3ivjzASU8j3HgEjqvEIaWvs6jWTrcHGz8rys9LmTzvMH/tkqDi1ExZ2vdgdHMZzF9LM6o72sFfF1UXxYJ0skQahHWqrhYYwlcrpFgK5ZgirWX51Apdc1HDS2ItkACup1F08Ds8tZxufjreeQm1AslRuQvoUg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731876744; c=relaxed/simple;
	bh=4cNIZDzLQfKsJJ0kQrHNCv75ROx+XfXm7fbjY1Jm25k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R9nJmddDi5iNiez0qm8eWvCtvssUGWhBDHHKM0/gYMX5H7lQL9EXl8Le5BghMcqIy+Sjn4zzXxS90pVDHUxOLfXtjUqi8FJ1nQzq7dcGIhOIDitsn/lfGhBWl6qgYS32jC2DiNWkqoN5++s2sR0d15UoyrxI0mjr1wkHApo0PlU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RW4Kg2NT; arc=fail smtp.client-ip=40.107.237.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LBEw0/zEHpByO7peoaPwh+eFTKQiNyemIOEjXhVei2I7hb5QP6c/OI6Fq9YUUMZYWnvqrUG8/U9wd1areKS/X6R0E2uggFPU2wjuOtRdJTCIBPQom2OyYcqxim3N7guv/PeoMCGz+/XXFoCJFyi+w6wL+E+xMJv4nJl42lkeZo7YlIewq4R5Ti+w1FhMZikA1ksyYIUzOjeR2uQWivMeuXkuT/86I0hIaUJu7Pm3Wzf3zEgW3wVdnUTS8DcbPB1RJACO2LQepGdya6l3mUai4aw51kQsTb2oXrYUdoLIh7RQ2eW396rv/elXFvoL/u1+P6UB08KBVg2AMeBedjES9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BPvv3IafnPs+viKn9AmZlYH2Xt66noDxqyj57pvtwVk=;
 b=u6fEBSDsTv24wXXTaUoqckPQR3lTZIsgrwgAdLdbNTpcucD4SVXmCiTD3qMkgfqngzKNk8S5tHuRfJpCDnI4gn5fzSSD/matJxa4o8ejpktPhjV8fWMy/bdYPj2Vw34KnX0LfVsuLkETOapHegIy2W+k4WV8aaeW8uzHJJzUX/5Kz5UEeyxMDl1Px8wbNDpPecaWp/oC3JgjfLUkIzdBDCYLuxtcEXMlMWw0PSpEm1xPXuJw61bmTwX85kEskuCUBAju0eSqqGNlvv1rPvZCg8M444/BUICIexuuZLAvW0gH0rSqbzIjfS4+DNnNRCFU5eq0Rg9m/WwaL8eKaQchTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BPvv3IafnPs+viKn9AmZlYH2Xt66noDxqyj57pvtwVk=;
 b=RW4Kg2NTyteU3ketaUFS9cSwjvq4RZvT9ionTHbFRiI1Xn/AmK81pMDbOTtFzeUXSN30pEkK5bMLRJXYkEj1r2RZUz/GBCDNsGu8E1JQpUHxX4LwZxNRAs71nnssWUfis7k2041rJN5mdVNP3uiV9hv43lsf/Ozj7aBOlEgLE6UiFKbcAVGyKoRoqL0kPk0eawVcWXeYpyd0d/HzOjM1cqc2k5bQZJjJGIKynqM+ZNaQdKtRVAw1bCHmYpjDW/5lmqWmLlOYNaXcSZevPkUJYzfT6pgu01mgFGzoZYxXjaLRAW2QhXQaomAhZwnqOJ/iaJ7zOxFddHpsWG4iDRDdTw==
Received: from BN9P220CA0016.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::21)
 by DM4PR12MB8557.namprd12.prod.outlook.com (2603:10b6:8:18b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.20; Sun, 17 Nov
 2024 20:52:15 +0000
Received: from BL6PEPF00022573.namprd02.prod.outlook.com
 (2603:10b6:408:13e:cafe::71) by BN9P220CA0016.outlook.office365.com
 (2603:10b6:408:13e::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22 via Frontend
 Transport; Sun, 17 Nov 2024 20:52:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL6PEPF00022573.mail.protection.outlook.com (10.167.249.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.14 via Frontend Transport; Sun, 17 Nov 2024 20:52:14 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 17 Nov
 2024 12:52:13 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 17 Nov 2024 12:52:13 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sun, 17 Nov 2024 12:52:10 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Jiri Pirko
	<jiri@resnulli.us>, Carolina Jubran <cjubran@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next V3 8/8] net/mlx5: Manage TC arbiter nodes and implement full support for tc-bw
Date: Sun, 17 Nov 2024 22:50:45 +0200
Message-ID: <20241117205046.736499-9-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241117205046.736499-1-tariqt@nvidia.com>
References: <20241117205046.736499-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022573:EE_|DM4PR12MB8557:EE_
X-MS-Office365-Filtering-Correlation-Id: 26fa5882-57b5-4111-9f99-08dd0749b79f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KOh6kq2WwShVoI+Hnub5/LenUvWQSbC1VvmSwdIF68zdO/AUSkEn/uztK9BK?=
 =?us-ascii?Q?+VDd1bfmzJMsSXOSZUkaKyBtKeHyPA0DM1Wcy5ohHFNkP+G4n+kogRoKTo9c?=
 =?us-ascii?Q?2pyTaRHCDuKJUEgrWat/tChwHSy/YmZf0daiD8nxnhDC3DWc/UAUCnt6zRcI?=
 =?us-ascii?Q?UK/tCt1VyBP1RcNPLVlSGkG6dISsLfcsQ2fjGyEG3KvdZF47KgxT+UoqL0oc?=
 =?us-ascii?Q?2hDcmuljrN6n00la0RPrOdklZ+se03/HTGl7DPFe0i8xo8Rk0aKdEqi26+sO?=
 =?us-ascii?Q?3JgZ2izSJO7ENhe4/MSM+lNb7kid3/5EMmIt9bj4C3TKz/T+ySgNC/MSK2I8?=
 =?us-ascii?Q?M6dWO7qSEuYNX1k+aaxzmVpapNlelVSL5akCZWDrbngPKCnsEq9kiJVPMm7P?=
 =?us-ascii?Q?5Oo0khNh55okPAFJUhhnFpzBZ+qQxQFjrU6EsMokVglUir38Pqv+NZbXeai6?=
 =?us-ascii?Q?1PC38yfTRhaYVjo2S9pZYJy72YPiRQacoi1L82swxNweJxBzekEavejXW4l5?=
 =?us-ascii?Q?Kx3Q5sSr833bqz2BA4MTAUgnZaQXzGCLFeol2L+1fH4i6cnXgXPnhLa0T511?=
 =?us-ascii?Q?gdU1igkBb1ukuESTdHNsS8cOKqE7KfjC29mEr3+cMtUyy0QBg4HFF4Ho8CtR?=
 =?us-ascii?Q?kHuGDLx01vlI6ccXEVjsWE9CyntrthQI97ROrt0OH1KPyB2wQh/apEHWTn6N?=
 =?us-ascii?Q?j+2i41UWmkSAziZyw/GSN8eAwPWgrx0aY7AL+Gyh4tHyyonpCHojsI/Fd6fp?=
 =?us-ascii?Q?l75cjnX5ekAmzP5jut81iQV6G/ExVj35fl3mhovNg44HonqPZQn6Bx8OovIC?=
 =?us-ascii?Q?/dypuy7oEMcVMJTLfJSRswdq8UGojGaG+Me9KAQzpgdaEF/hIYyHZMTBIsOJ?=
 =?us-ascii?Q?DfR/AURsUeldH62eL5Du8qDuSwpB1dbv8cMPklRFToQuGbC76lPVQSxrZrhF?=
 =?us-ascii?Q?xd/7XAU554YlELLC8DNJcgMjFbEARqVYDxT3Fjp+eBjnMrwiLX+bxFmoRwjd?=
 =?us-ascii?Q?MQzfb3jCFXSaXXXC1gqXgsgEkpMx9riYl8Y8LF2oxhhnOQ/jDY+9zEh4/EOr?=
 =?us-ascii?Q?iuSHcgKxiBgSYsSFdovLT81NRfiCklcnRDPWESElpF1J0htcF3hsEyKPXPZs?=
 =?us-ascii?Q?0UL+TQLhSoS7MHmTmtne0ATAtFN0qRmCPTRRhR7Lalsf/FM+g+KefRGU0Dww?=
 =?us-ascii?Q?kgwTG3fmY10cEl1p5704XaQXPzDfh7To/ba6p2PsONM4RgJpHKJkmiNXQa/v?=
 =?us-ascii?Q?hK9ZV3QEPhQraMWdYcP7tHeiqQrkelIbKzEzf4VvQxg7cYOSGBS/LmAaDHZ5?=
 =?us-ascii?Q?JckncmC9G1ZWYsAWT1F2H+Iir1wQjepByE8EuzBqCPHrLVhx/kSLQX2Dabga?=
 =?us-ascii?Q?qbItbPl4p9IaUjIYEngHy4klk+4rJ6xtT2eZXxze6gekhv4xSQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2024 20:52:14.8989
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26fa5882-57b5-4111-9f99-08dd0749b79f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022573.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8557

From: Carolina Jubran <cjubran@nvidia.com>

Introduce support for managing Traffic Class (TC) arbiter nodes and
associated vports TC nodes within the E-Switch QoS hierarchy. This
patch adds support for the new scheduling node type,
`SCHED_NODE_TYPE_VPORTS_TC_TSAR`, and implements full support for
setting tc-bw on both vports and nodes.

Key changes include:

- Introduced the new scheduling node type,
  `SCHED_NODE_TYPE_VPORTS_TC_TSAR`, for managing vports within the TC
  arbiter node.

- New helper functions for creating and destroying vports TC nodes
  under the TC arbiter.

- Updated the minimum rate normalization function to skip nodes of type
  `SCHED_NODE_TYPE_VPORTS_TC_TSAR`. Vports TC TSARs have bandwidth
  shares configured on them but not minimum rates, so their `min_rate`
  cannot be normalized.

- Implementation of `esw_qos_tc_arbiter_scheduling_setup()` and
  `esw_qos_tc_arbiter_scheduling_teardown()` for initializing and
  cleaning up TC arbiter scheduling elements. These functions now fully
  support tc-bw configuration on TC arbiter nodes.

- Added `esw_qos_tc_arbiter_get_bw_shares()` and
  `esw_qos_set_tc_arbiter_bw_shares()` to handle the settings of
  bandwidth shares for vports traffic class TSARs.

- Refactored `mlx5_esw_devlink_rate_node_tc_bw_set()` and
  `mlx5_esw_devlink_rate_leaf_tc_bw_set()` to fully support configuring
  tc-bw on devlink rate nodes and vports, respectively.

Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/esw/qos.c | 185 +++++++++++++++++-
 1 file changed, 180 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index afb00deaae16..87c9789c2836 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
@@ -67,6 +67,7 @@ enum sched_node_type {
 	SCHED_NODE_TYPE_TC_ARBITER_TSAR,
 	SCHED_NODE_TYPE_RATE_LIMITER,
 	SCHED_NODE_TYPE_VPORT_TC,
+	SCHED_NODE_TYPE_VPORTS_TC_TSAR,
 };
 
 static const char * const sched_node_type_str[] = {
@@ -75,6 +76,7 @@ static const char * const sched_node_type_str[] = {
 	[SCHED_NODE_TYPE_TC_ARBITER_TSAR] = "TC Arbiter TSAR",
 	[SCHED_NODE_TYPE_RATE_LIMITER] = "Rate Limiter",
 	[SCHED_NODE_TYPE_VPORT_TC] = "vport TC",
+	[SCHED_NODE_TYPE_VPORTS_TC_TSAR] = "vports TC TSAR",
 };
 
 struct mlx5_esw_sched_node {
@@ -159,6 +161,11 @@ mlx5_esw_qos_vport_get_parent(const struct mlx5_vport *vport)
 static void esw_qos_sched_elem_warn(struct mlx5_esw_sched_node *node, int err, const char *op)
 {
 	switch (node->type) {
+	case SCHED_NODE_TYPE_VPORTS_TC_TSAR:
+		esw_warn(node->esw->dev,
+			 "E-Switch %s %s scheduling element failed (tc=%d,err=%d)\n",
+			 op, sched_node_type_str[node->type], node->tc, err);
+		break;
 	case SCHED_NODE_TYPE_VPORT_TC:
 		esw_warn(node->esw->dev,
 			 "E-Switch %s %s scheduling element failed (vport=%d,tc=%d,err=%d)\n",
@@ -344,7 +351,11 @@ static void esw_qos_normalize_min_rate(struct mlx5_eswitch *esw,
 		if (node->esw != esw || node->ix == esw->qos.root_tsar_ix)
 			continue;
 
-		esw_qos_update_sched_node_bw_share(node, divider, extack);
+		/* Vports TC TSARs don't have a minimum rate configured,
+		 * so there's no need to update the bw_share on them.
+		 */
+		if (node->type != SCHED_NODE_TYPE_VPORTS_TC_TSAR)
+			esw_qos_update_sched_node_bw_share(node, divider, extack);
 
 		if (list_empty(&node->children))
 			continue;
@@ -476,6 +487,129 @@ static void esw_qos_destroy_node(struct mlx5_esw_sched_node *node, struct netlin
 	__esw_qos_free_node(node);
 }
 
+static int esw_qos_create_vports_tc_node(struct mlx5_esw_sched_node *parent, u8 tc,
+					 struct netlink_ext_ack *extack)
+{
+	u32 tsar_ctx[MLX5_ST_SZ_DW(scheduling_context)] = {};
+	struct mlx5_core_dev *dev = parent->esw->dev;
+	struct mlx5_esw_sched_node *vports_tc_node;
+	void *attr;
+	int err;
+
+	if (!mlx5_qos_element_type_supported(dev,
+					     SCHEDULING_CONTEXT_ELEMENT_TYPE_TSAR,
+					     SCHEDULING_HIERARCHY_E_SWITCH) ||
+	    !mlx5_qos_tsar_type_supported(dev,
+					  TSAR_ELEMENT_TSAR_TYPE_DWRR,
+					  SCHEDULING_HIERARCHY_E_SWITCH))
+		return -EOPNOTSUPP;
+
+	vports_tc_node = __esw_qos_alloc_node(parent->esw, 0, SCHED_NODE_TYPE_VPORTS_TC_TSAR,
+					      parent);
+	if (!vports_tc_node) {
+		NL_SET_ERR_MSG_MOD(extack, "E-Switch alloc node failed");
+		esw_warn(dev, "Failed to alloc vports TC node (tc=%d)\n", tc);
+		return -ENOMEM;
+	}
+
+	attr = MLX5_ADDR_OF(scheduling_context, tsar_ctx, element_attributes);
+	MLX5_SET(tsar_element, attr, tsar_type, TSAR_ELEMENT_TSAR_TYPE_DWRR);
+	MLX5_SET(tsar_element, attr, traffic_class, tc);
+	MLX5_SET(scheduling_context, tsar_ctx, parent_element_id, parent->ix);
+	MLX5_SET(scheduling_context, tsar_ctx, element_type, SCHEDULING_CONTEXT_ELEMENT_TYPE_TSAR);
+
+	err = esw_qos_node_create_sched_element(vports_tc_node, tsar_ctx, extack);
+	if (err)
+		goto err_create_sched_element;
+
+	vports_tc_node->tc = tc;
+
+	return 0;
+
+err_create_sched_element:
+	__esw_qos_free_node(vports_tc_node);
+	return err;
+}
+
+static void
+esw_qos_tc_arbiter_get_bw_shares(struct mlx5_esw_sched_node *tc_arbiter_node, u32 *tc_bw)
+{
+	struct mlx5_esw_sched_node *vports_tc_node;
+
+	list_for_each_entry(vports_tc_node, &tc_arbiter_node->children, entry)
+		tc_bw[vports_tc_node->tc] = vports_tc_node->bw_share;
+}
+
+static void esw_qos_set_tc_arbiter_bw_shares(struct mlx5_esw_sched_node *tc_arbiter_node,
+					     u32 *tc_bw, struct netlink_ext_ack *extack)
+{
+	struct mlx5_esw_sched_node *vports_tc_node;
+
+	list_for_each_entry(vports_tc_node, &tc_arbiter_node->children, entry) {
+		u32 bw_share;
+		u8 tc;
+
+		tc = vports_tc_node->tc;
+		bw_share = tc_bw[tc] ?: MLX5_MIN_BW_SHARE;
+		esw_qos_sched_elem_config(vports_tc_node, 0, bw_share, extack);
+	}
+}
+
+static void esw_qos_destroy_vports_tc_nodes(struct mlx5_esw_sched_node *tc_arbiter_node,
+					    struct netlink_ext_ack *extack)
+{
+	struct mlx5_esw_sched_node *vports_tc_node, *tmp;
+
+	list_for_each_entry_safe(vports_tc_node, tmp, &tc_arbiter_node->children, entry)
+		esw_qos_destroy_node(vports_tc_node, extack);
+}
+
+static int esw_qos_create_vports_tc_nodes(struct mlx5_esw_sched_node *tc_arbiter_node,
+					  struct netlink_ext_ack *extack)
+{
+	struct mlx5_eswitch *esw = tc_arbiter_node->esw;
+	int err, i, num_tcs = esw_qos_num_tcs(esw->dev);
+
+	for (i = 0; i < num_tcs; i++) {
+		err = esw_qos_create_vports_tc_node(tc_arbiter_node, i, extack);
+		if (err)
+			goto err_tc_node_create;
+	}
+
+	return 0;
+
+err_tc_node_create:
+	esw_qos_destroy_vports_tc_nodes(tc_arbiter_node, NULL);
+	return err;
+}
+
+static int esw_qos_create_tc_arbiter_sched_elem(struct mlx5_esw_sched_node *tc_arbiter_node,
+						struct netlink_ext_ack *extack)
+{
+	u32 tsar_ctx[MLX5_ST_SZ_DW(scheduling_context)] = {};
+	u32 tsar_parent_ix;
+	void *attr;
+
+	if (!mlx5_qos_tsar_type_supported(tc_arbiter_node->esw->dev,
+					  TSAR_ELEMENT_TSAR_TYPE_TC_ARB,
+					  SCHEDULING_HIERARCHY_E_SWITCH)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "E-Switch TC Arbiter scheduling element is not supported");
+		return -EOPNOTSUPP;
+	}
+
+	attr = MLX5_ADDR_OF(scheduling_context, tsar_ctx, element_attributes);
+	MLX5_SET(tsar_element, attr, tsar_type, TSAR_ELEMENT_TSAR_TYPE_TC_ARB);
+	tsar_parent_ix = tc_arbiter_node->parent ? tc_arbiter_node->parent->ix :
+			 tc_arbiter_node->esw->qos.root_tsar_ix;
+	MLX5_SET(scheduling_context, tsar_ctx, parent_element_id, tsar_parent_ix);
+	MLX5_SET(scheduling_context, tsar_ctx, element_type, SCHEDULING_CONTEXT_ELEMENT_TYPE_TSAR);
+	MLX5_SET(scheduling_context, tsar_ctx, max_average_bw, tc_arbiter_node->max_rate);
+	MLX5_SET(scheduling_context, tsar_ctx, bw_share, tc_arbiter_node->bw_share);
+
+	return esw_qos_node_create_sched_element(tc_arbiter_node, tsar_ctx, extack);
+}
+
 static struct mlx5_esw_sched_node *
 __esw_qos_create_vports_sched_node(struct mlx5_eswitch *esw, struct mlx5_esw_sched_node *parent,
 				   struct netlink_ext_ack *extack)
@@ -539,6 +673,9 @@ static void __esw_qos_destroy_node(struct mlx5_esw_sched_node *node, struct netl
 {
 	struct mlx5_eswitch *esw = node->esw;
 
+	if (node->type == SCHED_NODE_TYPE_TC_ARBITER_TSAR)
+		esw_qos_destroy_vports_tc_nodes(node, extack);
+
 	trace_mlx5_esw_node_qos_destroy(esw->dev, node, node->ix);
 	esw_qos_destroy_node(node, extack);
 	esw_qos_normalize_min_rate(esw, NULL, extack);
@@ -628,13 +765,38 @@ static void esw_qos_put(struct mlx5_eswitch *esw)
 
 static void esw_qos_tc_arbiter_scheduling_teardown(struct mlx5_esw_sched_node *node,
 						   struct netlink_ext_ack *extack)
-{}
+{
+	/* Clean up all Vports TC nodes within the TC arbiter node. */
+	esw_qos_destroy_vports_tc_nodes(node, extack);
+	/* Destroy the scheduling element for the TC arbiter node itself. */
+	esw_qos_node_destroy_sched_element(node, extack);
+}
 
 static int esw_qos_tc_arbiter_scheduling_setup(struct mlx5_esw_sched_node *node,
 					       struct netlink_ext_ack *extack)
 {
-	NL_SET_ERR_MSG_MOD(extack, "TC arbiter elements are not supported.");
-	return -EOPNOTSUPP;
+	u32 curr_ix = node->ix;
+	int err;
+
+	err = esw_qos_create_tc_arbiter_sched_elem(node, extack);
+	if (err)
+		return err;
+	/* Initialize the vports TC nodes within created TC arbiter TSAR. */
+	err = esw_qos_create_vports_tc_nodes(node, extack);
+	if (err)
+		goto err_vports_tc_nodes;
+
+	node->type = SCHED_NODE_TYPE_TC_ARBITER_TSAR;
+
+	return 0;
+
+err_vports_tc_nodes:
+	/* If initialization fails, clean up the scheduling element
+	 * for the TC arbiter node.
+	 */
+	esw_qos_node_destroy_sched_element(node, NULL);
+	node->ix = curr_ix;
+	return err;
 }
 
 static int esw_qos_create_vport_tc_sched_node(struct mlx5_vport *vport,
@@ -965,6 +1127,7 @@ static int esw_qos_vport_update(struct mlx5_vport *vport, enum sched_node_type t
 {
 	struct mlx5_esw_sched_node *curr_parent = vport->qos.sched_node->parent;
 	enum sched_node_type curr_type = vport->qos.sched_node->type;
+	u32 curr_tc_bw[IEEE_8021QAZ_MAX_TCS] = {0};
 	int err;
 
 	esw_assert_qos_lock_held(vport->dev->priv.eswitch);
@@ -976,11 +1139,19 @@ static int esw_qos_vport_update(struct mlx5_vport *vport, enum sched_node_type t
 	if (err)
 		return err;
 
+	if (curr_type == SCHED_NODE_TYPE_TC_ARBITER_TSAR && curr_type == type)
+		esw_qos_tc_arbiter_get_bw_shares(vport->qos.sched_node, curr_tc_bw);
+
 	esw_qos_vport_disable(vport, extack);
 
 	err = esw_qos_vport_enable(vport, type, parent, extack);
-	if (err)
+	if (err) {
 		esw_qos_vport_enable(vport, curr_type, curr_parent, NULL);
+		extack = NULL;
+	}
+
+	if (curr_type == SCHED_NODE_TYPE_TC_ARBITER_TSAR && curr_type == type)
+		esw_qos_set_tc_arbiter_bw_shares(vport->qos.sched_node, curr_tc_bw, extack);
 
 	return err;
 }
@@ -1415,6 +1586,8 @@ int mlx5_esw_devlink_rate_leaf_tc_bw_set(struct devlink_rate *rate_leaf, void *p
 	} else {
 		err = esw_qos_vport_update(vport, SCHED_NODE_TYPE_TC_ARBITER_TSAR, NULL, extack);
 	}
+	if (!err)
+		esw_qos_set_tc_arbiter_bw_shares(vport_node, tc_bw, extack);
 unlock:
 	esw_qos_unlock(esw);
 	return err;
@@ -1441,6 +1614,8 @@ int mlx5_esw_devlink_rate_node_tc_bw_set(struct devlink_rate *rate_node, void *p
 	}
 
 	err = esw_qos_node_enable_tc_arbitration(node, extack);
+	if (!err)
+		esw_qos_set_tc_arbiter_bw_shares(node, tc_bw, extack);
 unlock:
 	esw_qos_unlock(esw);
 	return err;
-- 
2.44.0


