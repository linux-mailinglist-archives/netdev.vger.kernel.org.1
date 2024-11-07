Return-Path: <netdev+bounces-143033-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3253B9C0F36
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 20:45:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56AA41C21EFF
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 19:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5A46217F4A;
	Thu,  7 Nov 2024 19:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="boslKEoB"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2058.outbound.protection.outlook.com [40.107.92.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11693217F2A
	for <netdev@vger.kernel.org>; Thu,  7 Nov 2024 19:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731008722; cv=fail; b=MuFj9qHpE/NsZDlY2oKeXGQmXio1AR8O8Hoj9JdZDjGq0bIABOEDU8/FGA+bCTAyhCU5f/PImAemg23iqFKJ/08KB8Df79IPby7Bi6VHeQR9X8Od/KHbLbyfcy3d3Qqgsd+KCMAW2Al10KPYzE5M5AAVWco99j5EtJxyIhL8FrU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731008722; c=relaxed/simple;
	bh=t8toPWyl+p0q6o9CZnlU8Jg2v6zmdAOCzn0hDedAt90=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I8b9q3h7DKpyOSWWVlMVAzczZiLKyZ1kJ4dp3q31SZL1y9twKcnDfeZECnv1st+yTYRKg7FQ29+0kitALC2/gFz8QduwrJAr803aWCHo+lgnA6wLBKzoij+msktHEHrY1UilwO7K9KbFVHHucEy8CpIf73XCrlUd604wDmSDsMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=boslKEoB; arc=fail smtp.client-ip=40.107.92.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z5g7iFLGUBJt96s5mquApl33Tkp4I8fHdXjcnALen7lut3cWUkvSiMeeLmlLxFwvzTWNQ5mf3jR7+LGcJZEXFINjcehC3PVNU9egi+EwcnH0V3wURDM3+2jZDa6BduF7arA7LXWE2rLDl+n//hg+CMAKic5gjnGZTTJJkn8/3WaZYLlcwpfEgaWC0yfIyTw60xembQy2ur6tzjEoylOk8GEh03TCVfahUOA4EE5urtDxEBVOPhYwNkFym7Ml6kRyh51PXEn5keATBfyUN7XYQICYZoieFuTns7p6VTcKRZZiYg2MyyhyGFEqkyStpZtb6PAOJUg3Zqw5GLnTzKUh9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fiabPjMvvSSCUGfGj96uoZETDpMBOMJAxXhU3yencKQ=;
 b=Nu4bfzacYbnnzfDQXKNxwu67yl6M/KwM2WWJ8OqJfdqms3MBVSHaMjN7spVtxGmlQn56fq5LWCdEWstoLwwows0nZbkA6mEjQB1MxyyOg2djUEoqjCCIudPG/77SJDfHuem4NpL58e1oY5J1v40Mn3kmMa9Kd4W8JnZ2fM9iiDgZna9LkPFSis/8pUKziIuZEQ9wqQBG4Enlj42InL1Yn+Df3NvY3wg8KoZeswx1Fi/REcVt/wVDzOTGSGcJWCSXxKlvM4D2ZRrFO8NQnwUN5hdUptv4I0DEWsgjTYMggiw06DFRNyqYfXrtSzmzol9A4D1eiCvo4YgGQSB06fRfuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fiabPjMvvSSCUGfGj96uoZETDpMBOMJAxXhU3yencKQ=;
 b=boslKEoBG8v+Qdkt2mH6I0CJ8yH189ks5PQoHmF9LhWr02SEt24g8felEd+LRxDgb1pTO6s2LfrtstOTMqKY4pkzkQCDGjlIJXW/WcY/NfExT0InFYGtTQ/PzYFaqju0omoQvtQLzNEvv5jKGWM65DK6lxP41AjnFeWms6fvD3iFRRRm+/CFXq3ZF/AV3v3r/K+6ywlJOKEU+qMLTj9XXy0EmZb20sQuz/dhvOvlg8l2SFEE1aARrSrJ+sUNsbxEu/v99Lq986ZeEeQkTRdSSd5/vFIvb7CwgDxG8+3+MJUOMN2KpORkVL8Y+VbrbQ91QMw/cmIqoI22ApdMqJwIFA==
Received: from BN9PR03CA0550.namprd03.prod.outlook.com (2603:10b6:408:138::15)
 by SA3PR12MB7781.namprd12.prod.outlook.com (2603:10b6:806:31a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Thu, 7 Nov
 2024 19:45:17 +0000
Received: from BN3PEPF0000B374.namprd21.prod.outlook.com
 (2603:10b6:408:138:cafe::2a) by BN9PR03CA0550.outlook.office365.com
 (2603:10b6:408:138::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20 via Frontend
 Transport; Thu, 7 Nov 2024 19:45:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF0000B374.mail.protection.outlook.com (10.167.243.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.0 via Frontend Transport; Thu, 7 Nov 2024 19:45:16 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 7 Nov 2024
 11:45:00 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 7 Nov 2024
 11:45:00 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Thu, 7 Nov
 2024 11:44:57 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Carolina Jubran
	<cjubran@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net-next 02/12] net/mlx5: Simplify QoS normalization by removing error handling
Date: Thu, 7 Nov 2024 21:43:47 +0200
Message-ID: <20241107194357.683732-3-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B374:EE_|SA3PR12MB7781:EE_
X-MS-Office365-Filtering-Correlation-Id: c06ef88c-4fc8-496b-54e5-08dcff64b45d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?O4F6RBfZMtZGYik5r/EXnAsGiNKd5i3Om7ISHLcc4NLCskRn1aSHUZpcLTj0?=
 =?us-ascii?Q?c63SaNOLxsNCQCV/yWT4WhGYi/a6Pt3vq4FdN+I98QZeT5Cp10dFJ3qvLTwG?=
 =?us-ascii?Q?C1UftbpXC9xQKbluPXgJpYc7ziw7sMaf01L44D8KEkWQbnxN4+b5Qj9uP84P?=
 =?us-ascii?Q?UeCh2iQ7QxnqRYaybq7IrfU9gcgPhiS6EmEK9LdNH/PRQ4HTf0biuU+kA8aA?=
 =?us-ascii?Q?oh7UqivcsqWRn4Jgp2Ze5IaaDefcyl4k/RvIyX9oDDctCnDK8R6fw0CxsrYK?=
 =?us-ascii?Q?DDSc7otb8qvVwoP0YlUXxT2AfeyNNdEM3YCD5WXwhrqaG29bbBlqqsW0YO8o?=
 =?us-ascii?Q?/beFU4hJDwLHZ4+CB/5bdm5p9Khn+q0pIvHfLMKhQW/gOr4UQiNXqr02AsoN?=
 =?us-ascii?Q?zyWTFPlZmzJCpPXdA2j51pd6iX9/ap1RL4pMGLxVjxBcgdRSj8m2Nnmow8QL?=
 =?us-ascii?Q?o9Q4KosYRPoaZuOCAzpYqe5By072gSvi9FOSFJPLTkMS58FN6sJsFf9aM1K8?=
 =?us-ascii?Q?b01Dqk2SfAYSkbBxJXNwr6QsliSAjq6Ujcjaq7PqJOXMa1QF4wWiDa4nyKit?=
 =?us-ascii?Q?byIeEJzHBN1w9ndh0pzZQ0olODtx6FacvsXD0Xasa8ilDRWSv0Ipe42yrtYL?=
 =?us-ascii?Q?v9B0YO6egNw71Zbxlx9lRbO2I654dbvDaoq9EjNP7Hc9C85IkJ96vSpDpTOk?=
 =?us-ascii?Q?ncvjYZKbiHg5gI92SHrC37pbOk2JiMMOG8e2D3MGSYAz6znMbUrmXHFV0vPB?=
 =?us-ascii?Q?yyrWC2LuYTYxYDViK19FJ/335RvD/mSFpx+TIFeGQblcn+uq8GIHgWUVRbzW?=
 =?us-ascii?Q?bmdhiROiU3l0RNuAxUrl62OUYB7F2bhBkqY6VFgSi+vxpL7md/q0juiFsPRc?=
 =?us-ascii?Q?WhRvxKWDemxApwNQwDjO7NFYjTPDiltYH2KNxTtBVyo8CGn4tamtT6c8ZOsb?=
 =?us-ascii?Q?P6XdFmZtIveEyTzDmkPUTTOSX+8DwOtvJYYaV4jSplwZXI/pX4uTm4XeTI46?=
 =?us-ascii?Q?+TIpu0cGk6rilswU5J8LkfviPg0OI4CvixrN25QNynStGp9XtORlg3E9lqou?=
 =?us-ascii?Q?Iqi1FwfQzrPCosSCN8DJIoD9TYHb2x9G515s7rqi+dipwdOw1UYjqH1kf84L?=
 =?us-ascii?Q?D4z0r5j4jj4Aat48oin6ZOGjVoic3Nq/cs0zF+WJaDFaHjCqw+v5O6QoYMo6?=
 =?us-ascii?Q?w1wa8hjWzkezCWv/gDqaWN+ngdZkFLTH2MQgNvt3Ijcw+hFlx0lyVwY8UghW?=
 =?us-ascii?Q?grXZwu4fLQGTbNWbwI8OT45/04rE9E7BCq2SlX3D/L87FzwwoErZjol0267k?=
 =?us-ascii?Q?KxQx838zcXPpQ/G1NfiqV8s3gNNv9UzPqAdOYGUvBMC1NddTv0t0wOQOPaqJ?=
 =?us-ascii?Q?OyYCx3TKqpePU4zck3Y41Kfe5l4Evn9F5dRagszYBh944m8gAA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 19:45:16.5251
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c06ef88c-4fc8-496b-54e5-08dcff64b45d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B374.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7781

From: Carolina Jubran <cjubran@nvidia.com>

This change updates esw_qos_normalize_min_rate to not return errors,
significantly simplifying the code.

Normalization failures are software bugs, and it's unnecessary to
handle them with rollback mechanisms. Instead,
`esw_qos_update_sched_node_bw_share` and `esw_qos_normalize_min_rate`
now return void, with any errors logged as warnings to indicate
potential software issues.

This approach avoids compensating for hidden bugs and removes error
handling from all places that perform normalization, streamlining
future patches.

Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/esw/qos.c | 72 +++++--------------
 1 file changed, 17 insertions(+), 55 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index 940e1c2d1e39..0c371f27c693 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
@@ -208,64 +208,49 @@ static u32 esw_qos_calc_bw_share(u32 min_rate, u32 divider, u32 fw_max)
 	return min_t(u32, max_t(u32, DIV_ROUND_UP(min_rate, divider), MLX5_MIN_BW_SHARE), fw_max);
 }
 
-static int esw_qos_update_sched_node_bw_share(struct mlx5_esw_sched_node *node,
-					      u32 divider,
-					      struct netlink_ext_ack *extack)
+static void esw_qos_update_sched_node_bw_share(struct mlx5_esw_sched_node *node,
+					       u32 divider,
+					       struct netlink_ext_ack *extack)
 {
 	u32 fw_max_bw_share = MLX5_CAP_QOS(node->esw->dev, max_tsar_bw_share);
 	u32 bw_share;
-	int err;
 
 	bw_share = esw_qos_calc_bw_share(node->min_rate, divider, fw_max_bw_share);
 
 	if (bw_share == node->bw_share)
-		return 0;
-
-	err = esw_qos_sched_elem_config(node, node->max_rate, bw_share, extack);
-	if (err)
-		return err;
+		return;
 
+	esw_qos_sched_elem_config(node, node->max_rate, bw_share, extack);
 	node->bw_share = bw_share;
-
-	return err;
 }
 
-static int esw_qos_normalize_min_rate(struct mlx5_eswitch *esw,
-				      struct mlx5_esw_sched_node *parent,
-				      struct netlink_ext_ack *extack)
+static void esw_qos_normalize_min_rate(struct mlx5_eswitch *esw,
+				       struct mlx5_esw_sched_node *parent,
+				       struct netlink_ext_ack *extack)
 {
 	struct list_head *nodes = parent ? &parent->children : &esw->qos.domain->nodes;
 	u32 divider = esw_qos_calculate_min_rate_divider(esw, parent);
 	struct mlx5_esw_sched_node *node;
 
 	list_for_each_entry(node, nodes, entry) {
-		int err;
-
 		if (node->esw != esw || node->ix == esw->qos.root_tsar_ix)
 			continue;
 
-		err = esw_qos_update_sched_node_bw_share(node, divider, extack);
-		if (err)
-			return err;
+		esw_qos_update_sched_node_bw_share(node, divider, extack);
 
 		if (list_empty(&node->children))
 			continue;
 
-		err = esw_qos_normalize_min_rate(node->esw, node, extack);
-		if (err)
-			return err;
+		esw_qos_normalize_min_rate(node->esw, node, extack);
 	}
-
-	return 0;
 }
 
 static int esw_qos_set_vport_min_rate(struct mlx5_vport *vport,
 				      u32 min_rate, struct netlink_ext_ack *extack)
 {
 	struct mlx5_esw_sched_node *vport_node = vport->qos.sched_node;
-	u32 fw_max_bw_share, previous_min_rate;
 	bool min_rate_supported;
-	int err;
+	u32 fw_max_bw_share;
 
 	esw_assert_qos_lock_held(vport_node->esw);
 	fw_max_bw_share = MLX5_CAP_QOS(vport->dev, max_tsar_bw_share);
@@ -276,13 +261,10 @@ static int esw_qos_set_vport_min_rate(struct mlx5_vport *vport,
 	if (min_rate == vport_node->min_rate)
 		return 0;
 
-	previous_min_rate = vport_node->min_rate;
 	vport_node->min_rate = min_rate;
-	err = esw_qos_normalize_min_rate(vport_node->parent->esw, vport_node->parent, extack);
-	if (err)
-		vport_node->min_rate = previous_min_rate;
+	esw_qos_normalize_min_rate(vport_node->parent->esw, vport_node->parent, extack);
 
-	return err;
+	return 0;
 }
 
 static int esw_qos_set_vport_max_rate(struct mlx5_vport *vport,
@@ -316,8 +298,6 @@ static int esw_qos_set_node_min_rate(struct mlx5_esw_sched_node *node,
 				     u32 min_rate, struct netlink_ext_ack *extack)
 {
 	struct mlx5_eswitch *esw = node->esw;
-	u32 previous_min_rate;
-	int err;
 
 	if (!MLX5_CAP_QOS(esw->dev, esw_bw_share) ||
 	    MLX5_CAP_QOS(esw->dev, max_tsar_bw_share) < MLX5_MIN_BW_SHARE)
@@ -326,19 +306,10 @@ static int esw_qos_set_node_min_rate(struct mlx5_esw_sched_node *node,
 	if (min_rate == node->min_rate)
 		return 0;
 
-	previous_min_rate = node->min_rate;
 	node->min_rate = min_rate;
-	err = esw_qos_normalize_min_rate(esw, NULL, extack);
-	if (err) {
-		NL_SET_ERR_MSG_MOD(extack, "E-Switch node min rate setting failed");
-
-		/* Attempt restoring previous configuration */
-		node->min_rate = previous_min_rate;
-		if (esw_qos_normalize_min_rate(esw, NULL, extack))
-			NL_SET_ERR_MSG_MOD(extack, "E-Switch BW share restore failed");
-	}
+	esw_qos_normalize_min_rate(esw, NULL, extack);
 
-	return err;
+	return 0;
 }
 
 static int esw_qos_set_node_max_rate(struct mlx5_esw_sched_node *node,
@@ -552,17 +523,11 @@ __esw_qos_create_vports_sched_node(struct mlx5_eswitch *esw, struct mlx5_esw_sch
 		goto err_alloc_node;
 	}
 
-	err = esw_qos_normalize_min_rate(esw, NULL, extack);
-	if (err) {
-		NL_SET_ERR_MSG_MOD(extack, "E-Switch nodes normalization failed");
-		goto err_min_rate;
-	}
+	esw_qos_normalize_min_rate(esw, NULL, extack);
 	trace_mlx5_esw_node_qos_create(esw->dev, node, node->ix);
 
 	return node;
 
-err_min_rate:
-	__esw_qos_free_node(node);
 err_alloc_node:
 	if (mlx5_destroy_scheduling_element_cmd(esw->dev,
 						SCHEDULING_HIERARCHY_E_SWITCH,
@@ -609,10 +574,7 @@ static int __esw_qos_destroy_node(struct mlx5_esw_sched_node *node, struct netli
 		NL_SET_ERR_MSG_MOD(extack, "E-Switch destroy TSAR_ID failed");
 	__esw_qos_free_node(node);
 
-	err = esw_qos_normalize_min_rate(esw, NULL, extack);
-	if (err)
-		NL_SET_ERR_MSG_MOD(extack, "E-Switch nodes normalization failed");
-
+	esw_qos_normalize_min_rate(esw, NULL, extack);
 
 	return err;
 }
-- 
2.44.0


