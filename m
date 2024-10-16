Return-Path: <netdev+bounces-136208-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 749749A10C4
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 19:37:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34E88283574
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 17:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F7DA2101A1;
	Wed, 16 Oct 2024 17:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DVnA8VJE"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704B018660A
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 17:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729100250; cv=fail; b=Lp0zXW0Hy27RJBuvoVsYj6feNCua7GWy1c5OoBSQuvm3/ShCwKIl+5ACm3PiNPLPzR2jsa7n9rgAULJcvhuPXCtTkJC0MTgxuXa5jcTiwfoyQbnRyIEMmk8qJKmcVkn7GdsRgnDHzZwdHeNtcCfZHbYWn0Dg7AZq7q3zk0IBCF8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729100250; c=relaxed/simple;
	bh=kZYr4fJVLqKrtKYPpwYkNDd3xCHnVUp/xycW5qf9Rpk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dfij0ygG5nxYjlcRpyEacsjkFQcvnjSCmlmJVYQpSlr5HZuwLGETBMrftPNHsj/yzjYvakSdkI3oyV6/nf6upqVFlzcOCGNWAeY9bsGfY//LdXDSH/M5rYZpqSYvcTRQRxgu/sFMlK7IWRYxBrF0zraSCfA5sVh/BfCXU7dx1zA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DVnA8VJE; arc=fail smtp.client-ip=40.107.223.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hU+D5ARj79ryjRtDLSklvb43eqhKPZjfYn0awiPd/jbF2ev0LLuboknw/+EL7cf1/gmBnyU1Xv6lRxYIjtJKKi2AwtKZDz+1KdGn8QjbWpIvQX12+kptCcpBFzWuHqSIwSKtOOQNzzPdMwD7W+dIrpWygrfTq5C2u65U8E+dsnNFx2T6Vd+q3MulGru9iVH2F3OoGQEeCch1ez15KF20ZT1l17u5O/IHjdbbKaLmtOTBcVIQ7QM8hNwelO5y5bOd5TDWKsgQEjciHgcs1q9oDhjmgSR9zgBnKhiC2q1YxhuUCe3xTIoO86FRcMF2pbm7YUTBnz5B8EyIgf2+X1z77w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y9bZdxbR4M3tw1Z8t+Zp9hI8dB82663xO1SRUQ8yE/0=;
 b=uM2o6+oFvQsHJTdMG5FSzIJx2Gwp9hJUMzwTos6r70wV3yHfUugrddTBhUgQukBpqMdWprmtoYMEw/tFFakVW+tSrnB+hGj1TwCVaaYaxJ3DmtW1AWEPF5p/CGMdX+2Eg+kg0vU1yxWQnLRDSP3K7uOE4NG7oqT2oCDhWk3PcoKC+SBitw+qdVZZ6u/ZnpYx6crIgUqJTRx+zKiVqNanVyReHRoKuz0TV2xLeSlzk8leAVrNizcq0E0rjCcHwmLqxQfiNO1cr0uJpnlV0yrbyzkzodcIR3BvkgZBt5zZeztxeIVZl682opd3QLO657jVPI4K6MpLgDV8KO2I0qvohA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y9bZdxbR4M3tw1Z8t+Zp9hI8dB82663xO1SRUQ8yE/0=;
 b=DVnA8VJE5fq09gxz0YlnWd83OoklfWrc/45tPwXurjAnQjzhrEVd1+e15xpOKI5VL8Z1N9q76zcbxMVYk5ayd+Jdaezv5het/QA1NKaZO4OZB0VVxK4DRzaDI8H98rXGa+cRlT8t3rQcjh5jW8RY5hSWxN7P7fYEJTsAzzn7O9ESpFhiw1j4ZaZURcpnYanoSnl+jNs4VSo2dcM9UW4gRbqkBu7Wcu3fbKgA+bvYKb1dR+KCXtMaCQWKKVk8RcIPuCWuG91uwAqZu24rbaqhvnB0DtO8jG/wJDENVag4xjJkopyTsvIZSPpAlcGfDF76e6Joi0eMEQ2G8TW2z0WmEw==
Received: from SJ0PR05CA0022.namprd05.prod.outlook.com (2603:10b6:a03:33b::27)
 by CH3PR12MB9077.namprd12.prod.outlook.com (2603:10b6:610:1a2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Wed, 16 Oct
 2024 17:37:21 +0000
Received: from SJ5PEPF00000203.namprd05.prod.outlook.com
 (2603:10b6:a03:33b:cafe::a5) by SJ0PR05CA0022.outlook.office365.com
 (2603:10b6:a03:33b::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.16 via Frontend
 Transport; Wed, 16 Oct 2024 17:37:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ5PEPF00000203.mail.protection.outlook.com (10.167.244.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Wed, 16 Oct 2024 17:37:21 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 16 Oct
 2024 10:37:12 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 16 Oct 2024 10:37:12 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 16 Oct 2024 10:37:09 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, <cjubran@nvidia.com>,
	<cratiu@nvidia.com>, Simon Horman <horms@kernel.org>, Daniel Machon
	<daniel.machon@microchip.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next V3 02/15] net/mlx5: Introduce node type to rate group structure
Date: Wed, 16 Oct 2024 20:36:04 +0300
Message-ID: <20241016173617.217736-3-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000203:EE_|CH3PR12MB9077:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bc871f7-6715-42e6-b8f6-08dcee093036
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NVMLj0tg5O2ZcqgSjaTDOqBPRdCG5JvOHumBCPUjN5xFPTZQPpWmsiyonjRA?=
 =?us-ascii?Q?3gshFt+k/GYZpTc0ajx4dV81ns5ryvXY5cBc1xjC036ZQZ4l+ovjA/p7uR3d?=
 =?us-ascii?Q?DETPCNEU3Ss+LTHwIZ0YbibOs73/Ani576A1VWQMxMgmtZHt0wN7mQH6xUxj?=
 =?us-ascii?Q?aoj2kFAo/XnC9MLlPBnJV5jwkAslSv2PI4ZtxbKSOTBmdWrOC7Grvko0GRhK?=
 =?us-ascii?Q?vC9TPTeGildI3b/7IUK4K/kbUBLbesej6Pw7Y3jEbUhYuJqHOnA/6jfFPHnn?=
 =?us-ascii?Q?FxGahUm3S47NBqMNBZTTLjwLRY1ptf2TjN4UWeSvOzBh7eDV2TLWsT9hrUxw?=
 =?us-ascii?Q?ZC1DjRm531AT1aYkf+GNVXuBDQebQTILaiRtxO5rBSEcP2zvg18oTGV4btRX?=
 =?us-ascii?Q?+dDdUrWAH3tLap2OKjSiLhLeI3sGwgJ21rroCgScs8ec7LGEtqmQSU+scKoM?=
 =?us-ascii?Q?AtTQkkHXebbYb7Plr7nXqcCbuE62dk5AZIN1MF4/5H4jTYei5nbm3IcNUP5z?=
 =?us-ascii?Q?sl2/palZbK8x3YNqvffb8OgjXfjyULgEYuYkbN8xK67kVcKF0W9hVegn62p2?=
 =?us-ascii?Q?fxZ80PCQeKPqOF99pH7xc4Sx33VQLdOaRtW2F/SrkFChYtYNu3RJ4yPxa0Yd?=
 =?us-ascii?Q?zvZ2TI7VgH7uytgM1VIJjwIKkZhbkjGKFMRWjlZDuKiHaf56Jzy2nXA2jg5p?=
 =?us-ascii?Q?QzHq88l+5YCiljcE1NlHWzamDCo0cX6YIP+Z8ShsA1RhH4jLoQJKmtEMy1fE?=
 =?us-ascii?Q?g1UIbOMJ5Wy1AdRev2H0QigQ2fWneNQvqdc7L54OxbObJmv2w1Vpofby02JS?=
 =?us-ascii?Q?c5kyuvGDzcGPuwl61P96It7EOiphCzUFIJtVZDVmfrq1oFNNg8yr29G2Qetb?=
 =?us-ascii?Q?SwnT0auoVSEjwcMyC6dvQkbJweSucPnRGNM5mH8mNmzvjvldC27K0azVGOIX?=
 =?us-ascii?Q?OeMNF3MpcIzS/p3172ARN5KUT2NFn+O8LXkSDITGWteSuOWh//dEiZ8ulOuW?=
 =?us-ascii?Q?JJd6S94gr6dZ1xVXsIrfZjUnDDcw7h5zatgj0zsSwUyRixmNr3BjX9DCNVwE?=
 =?us-ascii?Q?KrKZyo21NCOLi5OvIJGUtoKGzvT8S0KFMIvOgv51kvuHCiRUJp/BAZzIzzv8?=
 =?us-ascii?Q?qJDWkTa0Gwpa+jy2vOcFzGYGz9MjyRs7AZHdDK5xAzN3RVddcFZBK2w3gJIy?=
 =?us-ascii?Q?ytvheFUthmmYK4o/qRVckkKf8EZGW7sKuh0DzyBFmdN7887y4r0AUh/gKp+t?=
 =?us-ascii?Q?oOusqfsHjSVFxA5tCyddGbjZEISPn/OAbp6jxpgPSNa+6RsHGJTSOsmu8gMU?=
 =?us-ascii?Q?nNtRe6i90+1APjeJvYtnZZnoFDHeLMGdKkgPAm622OoSoOZuZR1EkRoG5IQ0?=
 =?us-ascii?Q?Yc4Drdje2shf6ZMUjZHuW6L/bt/s?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 17:37:21.0620
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bc871f7-6715-42e6-b8f6-08dcee093036
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000203.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9077

From: Carolina Jubran <cjubran@nvidia.com>

Introduce the `sched_node_type` enum to represent both the group and
its members as scheduling nodes in the rate hierarchy.

Add the `type` field to the rate group structure to specify the type of
the node membership in the rate hierarchy.

Generalize comments to reflect this flexibility within the rate group
structure.

Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/esw/qos.c | 28 ++++++++++++-------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index 7732f948e9c6..b324a6b1b9ff 100644
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
 	u32 tsar_ix;
@@ -533,7 +540,7 @@ __esw_qos_create_rate_group(struct mlx5_eswitch *esw, struct netlink_ext_ack *ex
 		return ERR_PTR(err);
 	}
 
-	group = __esw_qos_alloc_rate_group(esw, tsar_ix);
+	group = __esw_qos_alloc_rate_group(esw, tsar_ix, SCHED_NODE_TYPE_VPORTS_TSAR);
 	if (!group) {
 		NL_SET_ERR_MSG_MOD(extack, "E-Switch alloc group failed");
 		err = -ENOMEM;
@@ -563,7 +570,7 @@ static int esw_qos_get(struct mlx5_eswitch *esw, struct netlink_ext_ack *extack)
 static void esw_qos_put(struct mlx5_eswitch *esw);
 
 static struct mlx5_esw_rate_group *
-esw_qos_create_rate_group(struct mlx5_eswitch *esw, struct netlink_ext_ack *extack)
+esw_qos_create_vports_rate_group(struct mlx5_eswitch *esw, struct netlink_ext_ack *extack)
 {
 	struct mlx5_esw_rate_group *group;
 	int err;
@@ -576,7 +583,7 @@ esw_qos_create_rate_group(struct mlx5_eswitch *esw, struct netlink_ext_ack *exta
 	if (err)
 		return ERR_PTR(err);
 
-	group = __esw_qos_create_rate_group(esw, extack);
+	group = __esw_qos_create_vports_rate_group(esw, extack);
 	if (IS_ERR(group))
 		esw_qos_put(esw);
 
@@ -621,12 +628,13 @@ static int esw_qos_create(struct mlx5_eswitch *esw, struct netlink_ext_ack *exta
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
@@ -1038,7 +1046,7 @@ int mlx5_esw_devlink_rate_node_new(struct devlink_rate *rate_node, void **priv,
 		goto unlock;
 	}
 
-	group = esw_qos_create_rate_group(esw, extack);
+	group = esw_qos_create_vports_rate_group(esw, extack);
 	if (IS_ERR(group)) {
 		err = PTR_ERR(group);
 		goto unlock;
-- 
2.44.0


