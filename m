Return-Path: <netdev+bounces-134899-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D6C99B89D
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 08:46:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D24BF1F21CAE
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 06:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E711311B5;
	Sun, 13 Oct 2024 06:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tvtbkMu2"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2076.outbound.protection.outlook.com [40.107.236.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964A77A724
	for <netdev@vger.kernel.org>; Sun, 13 Oct 2024 06:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728802000; cv=fail; b=Ej1dJTWK/KEhmH9yVn5D9H5mfZIptjQ3tCFtSfYN5Nc4s0RIKsWgXZQUKsa/GKvPH7zt3iNVkKknI2mLsK2N5yI7QYQjjhbLdYUBk14KlDIkEYf8PHdJtTy6fG4nNnwNRvXhBX3LAVnZyPi8uukOLm5N3G+eLng61Sa3OKTs1UU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728802000; c=relaxed/simple;
	bh=k/7X5CAFjMDxloR3bk8AiU6ZZjNkk0f+E/GF7FH2pNU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mB64sgvZe7rWlQur/LnmcEJfFuvS8u6HyWcBW1vjsT2e/O3hexd0S0d6tGQjj1+bi+gNLcAXddj6alZy+52YSOavkWI2U7PbjfA87MBgWa/MWxkFXq1zu6g9WWhSAxyX6HGItfrCzEpBP8CB5FGHyC5zkwZCM144rPvQumEEMpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tvtbkMu2; arc=fail smtp.client-ip=40.107.236.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xZKp6E2aT1d6V+dE94mdi8Dd4gTnj+VjQgj4Cnw1eYlq2xq/6tgzeAP8uGCdHZBiv+BlDP783J+JmIYNuKaN4yImSR0Dff4a6W089v5FMeMddSx1fKng/WzEL+4nenkZxcjHS6drNgb5xLADAmSv9PSRzxd/hj7D7WcFHtM9IljUOIGShhwACT9T95adbuxgGxa7N+kYWD7iP30wsOvEkRx3Krs8UOa7mLKKM5hDfZ1jIITmz+b7edMl/gBxfBn2JMP8f/LpcAJzbse3wEqupKsNBMOeE22QXugQWbrLhyFTePamR7658cvVFZtF8pYqIYuMB9Jr8IMBn+DyDHaybw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tVNLzUBdlzn1mfYU+fvHCDW3NjUOydo6xybChaZQK/E=;
 b=PhaEANY0cyg+FV6agKeT4XyeghoZC+hkdOeziB9ZRqg2APT0impw5mJZx4BEpzaLu9SLXcONON3uhBQhAbNttxJhHM4Zld2TDyLoKMhH7O7+/PANnkOJd5xwt80jeHn0BWKaaH7vFqbVNsQGj5W7nVtJgyw84cRc5D0+CIVgHzCeSxuuQWVjfvryZv6NUzT2xE0scKp67HNnt7jaB2PgoomLSZY7IqBFnjHNeTFswGmB2vEKIouXnX8eLG4qrYmXwLViLVYoIkgqY5Jz0ZwV7DchTB6EtuAyq2KAu1RAYetOhTd4EmbztjdhAjrtGB7mBkVji05CEHZVOkV75qgAFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tVNLzUBdlzn1mfYU+fvHCDW3NjUOydo6xybChaZQK/E=;
 b=tvtbkMu2ZN3bFJFbIJyOnVJEXiTd0uLgtmWR6JGnaU91aKBp0C0vd65Dagu+T9xZyJxiVY7BvV7dbtxqn8/MeWx9hPVwnsfjPLiPvqtZB4bQoQ/J8KGU5uUToJ8DkCX6Q/GvJbBeC1C3oWPvD1mFH0FoFzmxszaxdIduMMxSkD2OjQPbfORkzJGGZfefwR7tv5rCGtjV18Rgs8WLRobLpfNOejthPKwruEdPjaUYKjhjdAJQ2ZOr1GaCYqGiHennTRAnCMTq1W3G32pY/5YsER69DG0GlVlN8C/aIXJxvxUHSXjvncczQmz09NOxbTdZilLy5fynzyA6k2MwiAJKjQ==
Received: from CH5PR02CA0003.namprd02.prod.outlook.com (2603:10b6:610:1ed::23)
 by IA1PR12MB8496.namprd12.prod.outlook.com (2603:10b6:208:446::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.24; Sun, 13 Oct
 2024 06:46:34 +0000
Received: from CH1PEPF0000AD7C.namprd04.prod.outlook.com
 (2603:10b6:610:1ed:cafe::52) by CH5PR02CA0003.outlook.office365.com
 (2603:10b6:610:1ed::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.22 via Frontend
 Transport; Sun, 13 Oct 2024 06:46:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH1PEPF0000AD7C.mail.protection.outlook.com (10.167.244.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.13 via Frontend Transport; Sun, 13 Oct 2024 06:46:33 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 12 Oct
 2024 23:46:22 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sat, 12 Oct 2024 23:46:21 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sat, 12 Oct 2024 23:46:19 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, <cjubran@nvidia.com>,
	<cratiu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 02/15] net/mlx5: Introduce node type to rate group structure
Date: Sun, 13 Oct 2024 09:45:27 +0300
Message-ID: <20241013064540.170722-3-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7C:EE_|IA1PR12MB8496:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bba32c5-77c9-4ebe-3024-08dceb52c6c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XIoMeLiBNXNJzdT8S+CfUIYU+9ALGlNb8w7tBCwW/mpG0orOGmYhsKw2mUec?=
 =?us-ascii?Q?rzRvRH1qVx5AqX1d8ZQTS0WgypOiszgy14DSgsDZMXDIUQvak9lLiI8iIPNU?=
 =?us-ascii?Q?CkI1Uujf7anwZXpaOxQe9pxLM9+dnZ6Aux0ElxidZ/xGLf0FPBfJ8LyT4neb?=
 =?us-ascii?Q?9dMgMPx6Mc3czya0SgkMILu2chK/LSLtnUd/ySbBnlxFD0RaoglWvPPnlRy6?=
 =?us-ascii?Q?pKf5unSVK2jYRPVTCtmBb5ob0nsnElurtNgOKciQuLOk7YkDOBJY2z81TS5A?=
 =?us-ascii?Q?/OA7CpVLWNiCajTxt69XgRQm+tGvNlDzLGxkvnY/5PI19m0x9Jn0lWvxGZr/?=
 =?us-ascii?Q?sdi0wKK18b+zIe12yfG1tSGWqMxxe1jVG+jhh3isO+y7HbrjlchU/2PRGN2e?=
 =?us-ascii?Q?WkPBoxeXkfExShoqU8Uh0PCnq71gFMXbagPH45LqZRmSpqA0qUgOEM24lbkT?=
 =?us-ascii?Q?FLn6V6EYpQy+rJo2RcW0rGfjKrNRZX7P9p+oEVPnY44scsVTi/v2SVuqB6ma?=
 =?us-ascii?Q?4eVC/pVVq5gLBlbRFFvgRfUH1rP0NCs8QQhot7dUdZU16uRDvn1fD5ZojYxU?=
 =?us-ascii?Q?S4dKkxR7EtsLftbiS4sdAKeKl2pQgHpyJSceK4RuUAPSx/+sXx6rcJscQQ6Y?=
 =?us-ascii?Q?HW5WMIRu8zPkgcKlVkxjMXESFWMwY5q/NkIXT3djruqygrAyJFPj+Icv8SkD?=
 =?us-ascii?Q?eEWnkrlfH2nKmO8uVHsy/VsLyPqth4JDJ0c5Zg2pcbqEdtDSljKDUOY5N375?=
 =?us-ascii?Q?k4Zm7I7+4lhBe1PaMMwT/lLDgzt35vGXWw58BmC+3+ot6NqlUjo8zYW3MR2h?=
 =?us-ascii?Q?qt7q51GGabFUEviFsUSR8S2/Xrz+nncAP0dQQBx/r+YvM0IQFgoxpMAO+2ad?=
 =?us-ascii?Q?FKuxQZzHsiwzxQezWToq9wDABpJ4F9TqPrMJCseJ5RXCd0pe2c7A/aRV3H2Z?=
 =?us-ascii?Q?yNplGpPJ0MGfFgsvruaLgKrMj2EwvEGDXUDC71HOpdBMt/WIdu6DDVTtLC8u?=
 =?us-ascii?Q?Ox+bYIfFPXe+NI0q9uEHlivoYXQZbApj+C/HXsQOpzKyPVhNMEaDrTEzqnNb?=
 =?us-ascii?Q?Ck0gFPcQIr5RTgOPyPvb60CF+Ci2hkPCsW13aeByhmwkORxzeC9P4nVoxp7r?=
 =?us-ascii?Q?SEp37owOKqFi38/CJJ+9ooOi4qdjX4xXyGEPAdMu1RhObgqnrv3CzdjM3hZ3?=
 =?us-ascii?Q?K4e6Cqb4/4hIT8h6EuJ+k/N7inZD1FqSYnCJkFkih35a2jpOb0BW/GCKzAWp?=
 =?us-ascii?Q?8H0AAAqeUbU1QJy6c/j2tz1oECMd662mLzvoIv8yVDwkTQDa31ISAsxRz9UD?=
 =?us-ascii?Q?HIjd7slwqgbbV1OlIrRnmxX548sKIriJrqVgeCqCtch/Dhx+bM294CM9tZ/z?=
 =?us-ascii?Q?8xNikA2APQyg++ZjRfrtnnlQ/qO+?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2024 06:46:33.2666
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bba32c5-77c9-4ebe-3024-08dceb52c6c2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8496

From: Carolina Jubran <cjubran@nvidia.com>

Introduce the `sched_node_type` enum to represent both the group and
its members as scheduling nodes in the rate hierarchy.

Add the `type` field to the rate group structure to specify the type of
the node membership in the rate hierarchy.

Generalize comments to reflect this flexibility within the rate group
structure.

Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/esw/qos.c | 28 ++++++++++++-------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index e357ccd7bfd3..b2b60b0b6506 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
@@ -61,6 +61,10 @@ static void esw_qos_domain_release(struct mlx5_eswitch *esw)
 	esw->qos.domain = NULL;
 }
 
+enum sched_node_type {
+	SCHED_NODE_TYPE_VPORTS_TSAR,
+};
+
 struct mlx5_esw_rate_group {
 	u32 tsar_ix;
 	/* Bandwidth parameters. */
@@ -68,11 +72,13 @@ struct mlx5_esw_rate_group {
 	u32 min_rate;
 	/* A computed value indicating relative min_rate between group members. */
 	u32 bw_share;
-	/* Membership in the qos domain 'groups' list. */
+	/* Membership in the parent list. */
 	struct list_head parent_entry;
+	/* The type of this group node in the rate hierarchy. */
+	enum sched_node_type type;
 	/* The eswitch this group belongs to. */
 	struct mlx5_eswitch *esw;
-	/* Vport members of this group.*/
+	/* Members of this group.*/
 	struct list_head members;
 };
 
@@ -499,7 +505,7 @@ static int esw_qos_vport_update_group(struct mlx5_vport *vport,
 }
 
 static struct mlx5_esw_rate_group *
-__esw_qos_alloc_rate_group(struct mlx5_eswitch *esw, u32 tsar_ix)
+__esw_qos_alloc_rate_group(struct mlx5_eswitch *esw, u32 tsar_ix, enum sched_node_type type)
 {
 	struct mlx5_esw_rate_group *group;
 
@@ -509,6 +515,7 @@ __esw_qos_alloc_rate_group(struct mlx5_eswitch *esw, u32 tsar_ix)
 
 	group->esw = esw;
 	group->tsar_ix = tsar_ix;
+	group->type = type;
 	INIT_LIST_HEAD(&group->members);
 	list_add_tail(&group->parent_entry, &esw->qos.domain->groups);
 	return group;
@@ -521,7 +528,7 @@ static void __esw_qos_free_rate_group(struct mlx5_esw_rate_group *group)
 }
 
 static struct mlx5_esw_rate_group *
-__esw_qos_create_rate_group(struct mlx5_eswitch *esw, struct netlink_ext_ack *extack)
+__esw_qos_create_vports_rate_group(struct mlx5_eswitch *esw, struct netlink_ext_ack *extack)
 {
 	struct mlx5_esw_rate_group *group;
 	u32 tsar_ix, err;
@@ -532,7 +539,7 @@ __esw_qos_create_rate_group(struct mlx5_eswitch *esw, struct netlink_ext_ack *ex
 		return ERR_PTR(err);
 	}
 
-	group = __esw_qos_alloc_rate_group(esw, tsar_ix);
+	group = __esw_qos_alloc_rate_group(esw, tsar_ix, SCHED_NODE_TYPE_VPORTS_TSAR);
 	if (!group) {
 		NL_SET_ERR_MSG_MOD(extack, "E-Switch alloc group failed");
 		err = -ENOMEM;
@@ -562,7 +569,7 @@ static int esw_qos_get(struct mlx5_eswitch *esw, struct netlink_ext_ack *extack)
 static void esw_qos_put(struct mlx5_eswitch *esw);
 
 static struct mlx5_esw_rate_group *
-esw_qos_create_rate_group(struct mlx5_eswitch *esw, struct netlink_ext_ack *extack)
+esw_qos_create_vports_rate_group(struct mlx5_eswitch *esw, struct netlink_ext_ack *extack)
 {
 	struct mlx5_esw_rate_group *group;
 	int err;
@@ -575,7 +582,7 @@ esw_qos_create_rate_group(struct mlx5_eswitch *esw, struct netlink_ext_ack *exta
 	if (err)
 		return ERR_PTR(err);
 
-	group = __esw_qos_create_rate_group(esw, extack);
+	group = __esw_qos_create_vports_rate_group(esw, extack);
 	if (IS_ERR(group))
 		esw_qos_put(esw);
 
@@ -620,12 +627,13 @@ static int esw_qos_create(struct mlx5_eswitch *esw, struct netlink_ext_ack *exta
 	}
 
 	if (MLX5_CAP_QOS(dev, log_esw_max_sched_depth)) {
-		esw->qos.group0 = __esw_qos_create_rate_group(esw, extack);
+		esw->qos.group0 = __esw_qos_create_vports_rate_group(esw, extack);
 	} else {
 		/* The eswitch doesn't support scheduling groups.
 		 * Create a software-only group0 using the root TSAR to attach vport QoS to.
 		 */
-		if (!__esw_qos_alloc_rate_group(esw, esw->qos.root_tsar_ix))
+		if (!__esw_qos_alloc_rate_group(esw, esw->qos.root_tsar_ix,
+						SCHED_NODE_TYPE_VPORTS_TSAR))
 			esw->qos.group0 = ERR_PTR(-ENOMEM);
 	}
 	if (IS_ERR(esw->qos.group0)) {
@@ -1037,7 +1045,7 @@ int mlx5_esw_devlink_rate_node_new(struct devlink_rate *rate_node, void **priv,
 		goto unlock;
 	}
 
-	group = esw_qos_create_rate_group(esw, extack);
+	group = esw_qos_create_vports_rate_group(esw, extack);
 	if (IS_ERR(group)) {
 		err = PTR_ERR(group);
 		goto unlock;
-- 
2.44.0


