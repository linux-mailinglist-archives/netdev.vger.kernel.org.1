Return-Path: <netdev+bounces-134900-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F4C99B89E
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 08:46:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 015362826AF
	for <lists+netdev@lfdr.de>; Sun, 13 Oct 2024 06:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D318D13698B;
	Sun, 13 Oct 2024 06:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="W6ae2yQR"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2057.outbound.protection.outlook.com [40.107.236.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C811304AB
	for <netdev@vger.kernel.org>; Sun, 13 Oct 2024 06:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728802001; cv=fail; b=s2ME0tf+4ItyzcN0t81EG+v9G1P+96Tk+N8hJ0lgN9vFSrGFSJOOJlq949iUiQXlBBOIOEQUS9MS0sKXWCXbQDb9tqIT25YkAgx0jH46KFkUWocaUBOPaTpbF5MrNOgNfjbANgBG4X/mL19xWqT26L49dRl7zwd+Yc0ubvSYkAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728802001; c=relaxed/simple;
	bh=DeMDKS6cmECbetHr/ZN7q4+T520WH/PEOoha1SQvcMs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QUnhTqxQ4jGRL0VUWXKjLR8p412mNUO52zR0UVrT2Byu4ED7O6fkhcvPGcwObEELCVdjgfGeSNVZB96rU9pwaZuWfDIU6Ww8LsOVE+mxClOg3SuBB/PbGTe7PR8hFzlV5vxsauXWIt38iaavS91xfOapC3dekJIDxWE/jEvDgg8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=W6ae2yQR; arc=fail smtp.client-ip=40.107.236.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vvsfrbiuPwym49TJWLyO4z4LHg1rlBzUiX/MRxw8xf2KFzIu8zlnPQa1rShRJdtlR0iNxidhwrfzBZEHWba8+ZdXzpoeEjh1g3cVDPvzV26NJ3aU6QkIWyrAPI8Zvl9TyZPcvEPFALlG9RoTmDcocpMUs0CmpwT4YGzvYnmlbNdUb7dm/h+FBFH1P0dli90mURVa+JlyM1DTPn9JiliE3KcfcS/60ae5oCtZ37qyJ+4y4lBMu9f87cDfhnYqGlc9ccMG5WmRqPCKomgLEUjzjCGsZtng8SbpH2UQKanIbsfgnQVUAdj0QQiMmfIB1BTerITWcUuzlyst7m1BBiHFDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RarYE3jsQByPF8RQbeEGUZocew3Ygmu1nmD6tYuB5XM=;
 b=Xe5tq6SIEonNeNg81Uvg+VxFmFs+yOG52KeH27qxpzcRHscLA6yuTFcFBSqmS4uCAVIXLh9bMa82X0Cv+BTjKWdk9wMRnPRiVcja8IXug03tHlOcSFvvAIkvqBb1+bQd3XijVfeGingt8vyTYZ0F8VCEByogpEoGo/hU2Hd7pPL4aSe5melcN/R0+/atEDRgfxAWopRaqS+8sKZzVF0PFgXuRGY9UiB8hQK/7Kkubz+fUwPLxddofCT4EcMbuJz8rrQAc1OZopFdLA6RiuvhjyXC6erX8hslvH1UA3VwImldrDwQ9/jVIqW2i/76Nz5l0ILMAceEQsIZYld4h6Idmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RarYE3jsQByPF8RQbeEGUZocew3Ygmu1nmD6tYuB5XM=;
 b=W6ae2yQRrx6y+tT/BLOTkcMhFmKCuMazey0WvtbNPpo62b5H23vXkyeLmWDKcgSu66HxOacGKSW4V57LNYE3LhylIIwKS9TdOSOdAXEUSopQ8B9nwr85mbegvHOYtFAD4Z7wG6n4l1aKLBlFDvjouK6JAu0n69n04QnvC/Mxnu5lgzBXu7erzrEZQwBUxnYiKti8NIAcruAZPGvTYU74c9vdPJLNqJToP5ERFxf+D63tv6SmO0t9hxkfbwgWv3c6kRAQe2ol2Y/63NXeP3MTyI0gyVbC4L0McVMl23bJREIDur6Mlo3XGA7Mwh9M6ftQZpSvWnHlVAAH3TjW+mYanQ==
Received: from CH5P222CA0006.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::27)
 by SA1PR12MB7341.namprd12.prod.outlook.com (2603:10b6:806:2ba::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.21; Sun, 13 Oct
 2024 06:46:34 +0000
Received: from CH2PEPF0000013F.namprd02.prod.outlook.com
 (2603:10b6:610:1ee:cafe::a0) by CH5P222CA0006.outlook.office365.com
 (2603:10b6:610:1ee::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26 via Frontend
 Transport; Sun, 13 Oct 2024 06:46:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH2PEPF0000013F.mail.protection.outlook.com (10.167.244.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8048.13 via Frontend Transport; Sun, 13 Oct 2024 06:46:32 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sat, 12 Oct
 2024 23:46:25 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sat, 12 Oct 2024 23:46:24 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sat, 12 Oct 2024 23:46:22 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, <cjubran@nvidia.com>,
	<cratiu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 03/15] net/mlx5: Add parent group support in rate group structure
Date: Sun, 13 Oct 2024 09:45:28 +0300
Message-ID: <20241013064540.170722-4-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013F:EE_|SA1PR12MB7341:EE_
X-MS-Office365-Filtering-Correlation-Id: e77633c5-5c54-490e-8588-08dceb52c66c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iAzJIrz7xSkh7Rtyg9EoCCWdgXT9ZVuGG/A1IlvhfIJm1aqZLEImB88BMzYW?=
 =?us-ascii?Q?C46KBfPs0PJNYXROF26p5vdXznX8b5M0p3eUuSFJt+njy1hWZgCWXnmnDmyO?=
 =?us-ascii?Q?RMBh8ZLLD+bqWaGMYcVbg57WW+qHR+oZh6A4hCKBUu49gYXltCfrVO2rg1Df?=
 =?us-ascii?Q?BhYgVCN+TzatZ1EjOKrivCCOFmq0N/DhKDjanklgTOeQXMNfRlHR7bWaLiTn?=
 =?us-ascii?Q?1RYKyARrBaMOl2N5ttTDEdsG3iGoFfPtT79YI1hGO3HWOWb8ldRP7OCsL0up?=
 =?us-ascii?Q?frYKT+xQGzGbfu2uasGF+RbghAmiCUskpiet/+4ITdagO0AGJNsn4bFr4jul?=
 =?us-ascii?Q?75DTCU+D1ms9mjaCqBk+7FYUnw2gibZBF/Tv+XZhJXbupHPONjiPjuYqne+r?=
 =?us-ascii?Q?o2VNLuWa8zoVb3LRz7gLKG2eHIVoE9k9uMZvvfWVF2gUBW3kN6elpYJcFGG6?=
 =?us-ascii?Q?9jjUEW9yyX5V8RJtBTa3PFuA7xRvlhJmYdIbYV4a18T45t5nW6z8r4STn0BM?=
 =?us-ascii?Q?E+PllLSQ/1p3oUs2JwCKNvT++dZo6NmXCA3UtTDYMxPwY6wvPvwSrUoZbPdU?=
 =?us-ascii?Q?udiufJKEdCD8DdhvzkY+Hk8+/h7UX+UpPoqpUNAwMGUUUfIga1JhtJmJ8G+a?=
 =?us-ascii?Q?B2THEMRq3d8TRhfwRsK90JvGWZnoH5F6+/WQLrLsSPsZWvXnzRqM6NmjRtT6?=
 =?us-ascii?Q?tib+hWrh6SU2Nc+Bi8PZJitgn511DM1o4UF+pu1uy7hvxnLy4vETEpeDWxHr?=
 =?us-ascii?Q?SaZoS9FZspCXPR5q/WzB1NlDbFYXyTT3ydEbbwJcFd0a0+vRm2GZA4I/KZIi?=
 =?us-ascii?Q?Spd5c/DFXVtxt2SaV3rcBYRvaaJ51zdFfcy44WtlTboYcCeY6uxwXEtAELp9?=
 =?us-ascii?Q?37FzXNHchSxu/0uOyMhpkJiTC7ZUc5V1s5J1uujd38Jqc7L+jatFQ9QLflib?=
 =?us-ascii?Q?GQdYPPLMK1Z606v4g8kGt5oXTV2ESWxmWeGwlhD85P0zdDxCmE2v9pjsMGMN?=
 =?us-ascii?Q?wzabaSC+4X1EFIpbomO9z3alBHll6env7bJKpdbKfFC1nq1huZDLnRY7Slxd?=
 =?us-ascii?Q?WPScsFQcYGEM4aGVLhETp2T0KOmHxlc1SS9WuNGyY2pnMIsXJfstiCPspns2?=
 =?us-ascii?Q?f8qrqp/U8BgtLOBvwnrsivM/LiKvK6qqtu8du6ujejMANXmqzM5mwwiE5Dfa?=
 =?us-ascii?Q?FmU0Vk5v8uxq+wa/itsjUxDcGhTn7LHuwPshZQFlwO1SGjIC1svpg4cluZFR?=
 =?us-ascii?Q?Y4yUZsE3jRciTsOYRzXTYppDw0r7x6W8YtyTXM1AgkwHUd6HUtJMrj0gSmof?=
 =?us-ascii?Q?EhK7Rh9Cmj55C/XSrkggaLtIGC1w1A1BQD2E0r3KW4QbT6DxAW/GNzrVehss?=
 =?us-ascii?Q?wRfNX0mlpyE5e/6q7fLN6+vwUXS5?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2024 06:46:32.5489
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e77633c5-5c54-490e-8588-08dceb52c66c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7341

From: Carolina Jubran <cjubran@nvidia.com>

Introduce a `parent` field in the `mlx5_esw_rate_group` structure to
support hierarchical group relationships.

The `parent` can reference another group or be set to `NULL`,
indicating the group is connected to the root TSAR.

This change enables the ability to manage groups in a hierarchical
structure for future enhancements.

Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/esw/qos.c   | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index b2b60b0b6506..e9ddd7f4ac80 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
@@ -72,6 +72,8 @@ struct mlx5_esw_rate_group {
 	u32 min_rate;
 	/* A computed value indicating relative min_rate between group members. */
 	u32 bw_share;
+	/* The parent group of this group. */
+	struct mlx5_esw_rate_group *parent;
 	/* Membership in the parent list. */
 	struct list_head parent_entry;
 	/* The type of this group node in the rate hierarchy. */
@@ -505,7 +507,8 @@ static int esw_qos_vport_update_group(struct mlx5_vport *vport,
 }
 
 static struct mlx5_esw_rate_group *
-__esw_qos_alloc_rate_group(struct mlx5_eswitch *esw, u32 tsar_ix, enum sched_node_type type)
+__esw_qos_alloc_rate_group(struct mlx5_eswitch *esw, u32 tsar_ix, enum sched_node_type type,
+			   struct mlx5_esw_rate_group *parent)
 {
 	struct mlx5_esw_rate_group *group;
 
@@ -516,6 +519,7 @@ __esw_qos_alloc_rate_group(struct mlx5_eswitch *esw, u32 tsar_ix, enum sched_nod
 	group->esw = esw;
 	group->tsar_ix = tsar_ix;
 	group->type = type;
+	group->parent = parent;
 	INIT_LIST_HEAD(&group->members);
 	list_add_tail(&group->parent_entry, &esw->qos.domain->groups);
 	return group;
@@ -528,7 +532,8 @@ static void __esw_qos_free_rate_group(struct mlx5_esw_rate_group *group)
 }
 
 static struct mlx5_esw_rate_group *
-__esw_qos_create_vports_rate_group(struct mlx5_eswitch *esw, struct netlink_ext_ack *extack)
+__esw_qos_create_vports_rate_group(struct mlx5_eswitch *esw, struct mlx5_esw_rate_group *parent,
+				   struct netlink_ext_ack *extack)
 {
 	struct mlx5_esw_rate_group *group;
 	u32 tsar_ix, err;
@@ -539,7 +544,7 @@ __esw_qos_create_vports_rate_group(struct mlx5_eswitch *esw, struct netlink_ext_
 		return ERR_PTR(err);
 	}
 
-	group = __esw_qos_alloc_rate_group(esw, tsar_ix, SCHED_NODE_TYPE_VPORTS_TSAR);
+	group = __esw_qos_alloc_rate_group(esw, tsar_ix, SCHED_NODE_TYPE_VPORTS_TSAR, parent);
 	if (!group) {
 		NL_SET_ERR_MSG_MOD(extack, "E-Switch alloc group failed");
 		err = -ENOMEM;
@@ -582,7 +587,7 @@ esw_qos_create_vports_rate_group(struct mlx5_eswitch *esw, struct netlink_ext_ac
 	if (err)
 		return ERR_PTR(err);
 
-	group = __esw_qos_create_vports_rate_group(esw, extack);
+	group = __esw_qos_create_vports_rate_group(esw, NULL, extack);
 	if (IS_ERR(group))
 		esw_qos_put(esw);
 
@@ -627,13 +632,13 @@ static int esw_qos_create(struct mlx5_eswitch *esw, struct netlink_ext_ack *exta
 	}
 
 	if (MLX5_CAP_QOS(dev, log_esw_max_sched_depth)) {
-		esw->qos.group0 = __esw_qos_create_vports_rate_group(esw, extack);
+		esw->qos.group0 = __esw_qos_create_vports_rate_group(esw, NULL, extack);
 	} else {
 		/* The eswitch doesn't support scheduling groups.
 		 * Create a software-only group0 using the root TSAR to attach vport QoS to.
 		 */
 		if (!__esw_qos_alloc_rate_group(esw, esw->qos.root_tsar_ix,
-						SCHED_NODE_TYPE_VPORTS_TSAR))
+						SCHED_NODE_TYPE_VPORTS_TSAR, NULL))
 			esw->qos.group0 = ERR_PTR(-ENOMEM);
 	}
 	if (IS_ERR(esw->qos.group0)) {
-- 
2.44.0


