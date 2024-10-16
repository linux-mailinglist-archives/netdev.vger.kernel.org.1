Return-Path: <netdev+bounces-136211-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 655829A10C7
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 19:37:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F91C1C223AD
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 17:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BB84212659;
	Wed, 16 Oct 2024 17:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WZRjEV7Y"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891C5212EEF
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 17:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729100260; cv=fail; b=lANbCkydLVWPdI/wsLQTH1+iovEEKY6YLUK4aGgwZ+XoHF9IkMy39eOzOakT81q1iAh2wJGD7/Xtx4hirdLKRUFxmY+daTb8Q5OcKpuEQWI5LzFuAI3NJSJMWz88ED5p4TTaS2Z22DiUAygBd8JXY7f9W6bb/TVr8RnG8mSo+/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729100260; c=relaxed/simple;
	bh=4P1l46gBYeBUVreAIKyB3gUKf3FpThn7JObUxVsAfzw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JaoeE2Cvi9K3z6xf63zrw9ZiunrxujYjstn9Ydes7m3cHpQ/lXWaUPTnbHvP+qe7z0g43iXmKDgMwQ28LCSnYuXiT4SpGLv2lQK70PnR8mM4rkOSg7Uswf0kkQQnWq4vv0uiAPuxFOCgB8r6ADuUs9jUzHLuIGBXx+UpP2IWmsI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WZRjEV7Y; arc=fail smtp.client-ip=40.107.223.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kAjiBHcIyDS7FMmMF9CW+3ZkE1OQIXoDBIHcvNnaL7EEwcoJI57swaxnDYAdSEPA3Z0or18WDA6mdghNYJIX0+96S6eXUTHLS9ojYTEiCLKux6BSeFv+dIUoEEzTRINDxQiAFREL0eq6dfaGWRRr2+o0OvE6uTBNXNEWAhsn1gT2Lh8Kw1/V7nToS0H3w6gMTScpNZqtZVdD6uxx+jhA6dAHu/LNl6/fhdUJRaAxkwOXQEvFOhAGdzzmtripprOQcNMxYn43V4dVZYE7gHQBiHSSuUQP4tg9FCkl8Q5Bv/uTQmg36xZvuD+jEWMceuVokPX+9Lri+Co2LhGVgN5DTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c5Rq6+voAr41stTFgInmp4ByXbWM0b0Au3R9Ag49qkg=;
 b=yqGqS23neZpSt11JfcLQ8kZWYRhNyQbUjQLA+jdy+ANdi+G2XZt40QoPk4K7KWNn1SfqPmP3KV48AbZ6+jpe3tEsWS4Y8M/JRS2P34ovduhC6pPvowKSQFnFClx1yefaeXQJFaQ4x8Lafy2/HImUg7O/wkz64EJKj5WcsObNEvQrj4W9yo6w5ejHBxvJbw2MZ6voPRtuYMUqv5W7v+Fx8snRmLPQdrNDMog0zBJNgpgV7TMGPAG2doBFm0pg0m5crofuyQGJsF6ECIX5onGFY30DyO7GLuGqaURykZVOl63lhIOXZOuizopbkC+XIyyoYzz0iVMP2tbsCNXMG3jjIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c5Rq6+voAr41stTFgInmp4ByXbWM0b0Au3R9Ag49qkg=;
 b=WZRjEV7YCqnrP60I65Tz2KwTA5y53v2ne7lUr1XG6xZNE3b5rRIqxXtdj2xQJKsuubihzgZUNnx3S+VcdIow9WLVAi3tWmd8RtKMbZ5eNRF/Qs1y1lEMBXD4HUTPQA4apujZp55BC5r9p32MtxRcm4R9m5h4UQMHabc3AWsziwjdJipdt9yLtc6PXS3CZjGdysHcaaEbA8cIFtdvZa6Ry+3YcBJgeHO5A0flkuJXpLZ96jaY+sjrlDjbwDNCR02PbyEFKz02ovYhjOwVHWaZl61okjrqXKbmRZ5so72jw35MIfsn2dkD6Rd7pks3arwFDnNQFpVxHU0rk4xErW39fw==
Received: from BN9P221CA0002.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::9)
 by PH8PR12MB7229.namprd12.prod.outlook.com (2603:10b6:510:227::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Wed, 16 Oct
 2024 17:37:32 +0000
Received: from BN1PEPF00004683.namprd03.prod.outlook.com
 (2603:10b6:408:10a:cafe::a0) by BN9P221CA0002.outlook.office365.com
 (2603:10b6:408:10a::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18 via Frontend
 Transport; Wed, 16 Oct 2024 17:37:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN1PEPF00004683.mail.protection.outlook.com (10.167.243.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Wed, 16 Oct 2024 17:37:31 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 16 Oct
 2024 10:37:15 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 16 Oct 2024 10:37:15 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 16 Oct 2024 10:37:12 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, <cjubran@nvidia.com>,
	<cratiu@nvidia.com>, Simon Horman <horms@kernel.org>, Daniel Machon
	<daniel.machon@microchip.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next V3 03/15] net/mlx5: Add parent group support in rate group structure
Date: Wed, 16 Oct 2024 20:36:05 +0300
Message-ID: <20241016173617.217736-4-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004683:EE_|PH8PR12MB7229:EE_
X-MS-Office365-Filtering-Correlation-Id: 73443296-1b1a-452a-54e3-08dcee093678
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UGSTOa1OMjNZiBUj4pyWzMsTXHr8S2MgXyquibNXobopWsXsGUPK4IxYjGrX?=
 =?us-ascii?Q?Y55utvRiH/nM/GfvAwNUVKh4UfdsJo7rDn7aexSShLEg/G37cE1F5DwKYj3M?=
 =?us-ascii?Q?A9qz5ejgabz37XWd+NetGq85WTh4i0VnG8mtK16Wfes0qM2dF7v170lbKwbY?=
 =?us-ascii?Q?6vYI0gGSbhBGYeuu4AF+L/3OkExDsY3CueN0eAid6xJQWT76D9VZyr/qErlt?=
 =?us-ascii?Q?NyXrCO8DgGm/QRKCU0Iu3j/94d0ksHuNyOm/qJTrWyCn/WQl+eWqMQt0XT83?=
 =?us-ascii?Q?kVzjJGP0ZAWyIs2Jrfr6dZZF+990wJrlG0giZXPWSVvWl6gbOAVajPfWKDmE?=
 =?us-ascii?Q?CwoF3c1whoP364ljxvtNi+SZMXueRTdIH+7QgSy7gj06MfiExyw7uMgjoPol?=
 =?us-ascii?Q?Is7prF35tgEEsBokm7vW1PjZgFVRCn7bdp+9xOY+k0tIhtdIJJETBAFZegtp?=
 =?us-ascii?Q?w9pyiPihzQWPmQk8dFMAoYuoj/7nUhJiQ9anDfjdvTBrxlm3iDZDge1coNz6?=
 =?us-ascii?Q?TtHHpzlllldZZrmYwsihicTr+muaaOnepl8Rd2CO518xvJDhhb7NG0z/NrFp?=
 =?us-ascii?Q?gzEgJVJULtAOJ0Nw6Y53YL9ig36VkK1hUVgykQMoms/VKxUbaNpcLu/l17Sp?=
 =?us-ascii?Q?eM3AGkEl177LHBBHlsxsPdR8LT/HqwUNn9YOLSzwCb8LulGMT6Q/5MsJVwrq?=
 =?us-ascii?Q?Ku8V0Ttq57EPKG8+Njxo4VI0XEDgB46r78MlJja9ebYwlR6acU5qC6SF14ch?=
 =?us-ascii?Q?1INlmr8i8Uo2T9KakLA9UjUrGdsYOw4GJzTpJ0FkO/r2MxcuEBtdFHK/N7/9?=
 =?us-ascii?Q?ixY8GpXjl16uKqYwbj3C2D/4+hV/xZihn/GEFphcgItq9jErI2Mw/oH3VvZM?=
 =?us-ascii?Q?7Ahct87cmGyU02bkYDJGEHTgWRgPqIWsy6XtANuwHMvBJ+ZRxCzD5Cvx3/sf?=
 =?us-ascii?Q?OSSqvM5BGRW5WpxQeOvaa2sD68750y37C97L23xuCKdBYSWyN1t8d8zGaTjI?=
 =?us-ascii?Q?7V41+Qu65w9ZfYb1QH2lkgpzKIbI5EF73xiTV0HuAfmypWOPwVzwFt/tt/fk?=
 =?us-ascii?Q?H+6XiCZtkcDBDCeV9nUNMB1zOGyqIZ+P3FgsKe07eOtc27r3Zwm5v4+Zygqb?=
 =?us-ascii?Q?qyR3NEmIFa5MQybZIShVaWzhQHHEsLlWPlqyLRaBlkMiGqHJ4O5azC7moHbJ?=
 =?us-ascii?Q?SkXHwfwNOCuMIC/pIhJsBpX4OKWose66n+f8SIrg4Hq+XRQpVz6h4jeUH73/?=
 =?us-ascii?Q?SQAokeD9S4LdR3ABW8uYC2FE/srC+Xlsp0xfO9InKT1hZg8+QS1RUv7p4+5E?=
 =?us-ascii?Q?mCJceOajI0jAwpeCaiq+WfeXF6AyTPG8eYN86ZNGwpvRVWtZaH9mlYyT/CPZ?=
 =?us-ascii?Q?UFi0JK5brQuXJiecs2ixoSfX2zW3?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 17:37:31.4333
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73443296-1b1a-452a-54e3-08dcee093678
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004683.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7229

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
index b324a6b1b9ff..f2a0d59fa5bb 100644
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
 	u32 tsar_ix;
@@ -540,7 +545,7 @@ __esw_qos_create_vports_rate_group(struct mlx5_eswitch *esw, struct netlink_ext_
 		return ERR_PTR(err);
 	}
 
-	group = __esw_qos_alloc_rate_group(esw, tsar_ix, SCHED_NODE_TYPE_VPORTS_TSAR);
+	group = __esw_qos_alloc_rate_group(esw, tsar_ix, SCHED_NODE_TYPE_VPORTS_TSAR, parent);
 	if (!group) {
 		NL_SET_ERR_MSG_MOD(extack, "E-Switch alloc group failed");
 		err = -ENOMEM;
@@ -583,7 +588,7 @@ esw_qos_create_vports_rate_group(struct mlx5_eswitch *esw, struct netlink_ext_ac
 	if (err)
 		return ERR_PTR(err);
 
-	group = __esw_qos_create_vports_rate_group(esw, extack);
+	group = __esw_qos_create_vports_rate_group(esw, NULL, extack);
 	if (IS_ERR(group))
 		esw_qos_put(esw);
 
@@ -628,13 +633,13 @@ static int esw_qos_create(struct mlx5_eswitch *esw, struct netlink_ext_ack *exta
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


