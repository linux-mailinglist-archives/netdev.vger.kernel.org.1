Return-Path: <netdev+bounces-135323-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1158A99D895
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 22:54:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5308282610
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 20:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D7B1D1E9D;
	Mon, 14 Oct 2024 20:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Yu9HLb7N"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83171D172B
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 20:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728939268; cv=fail; b=mmF5+0jAt6vLaXqZlu3XoSaub0LoUNqyjibz/te+pKWrO8zfovG2ER2iabpkX54vTEObWsIjC7J49VdXAB/mdx7ChglUH7orCX/7mjSCsrQ+KvMoxxbyFp1+Cto1rqA5ZnbGHyMjfoEoPSrMEuPlwGFJJDZDdkF6yQy11NhBLxI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728939268; c=relaxed/simple;
	bh=4P1l46gBYeBUVreAIKyB3gUKf3FpThn7JObUxVsAfzw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JdTWjEk8eDHNxVepOswYkP1zuhfiIVsxqMJMN2aLMrxhQPapAxqeYaZiVJAxDWaAnlPkISIrBH0mmss3Om4WEdTF9ijdvT4Lkg402DS1z1c2vRz4gEK902LP0l5NGDXaTUxRp1yAfD0SE5h0tkUP2g1bY/hzfw8wTHWlKzLvTUo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Yu9HLb7N; arc=fail smtp.client-ip=40.107.92.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wxzWPid9is93zQ2Txyccf2xocMUE5lh7J3aHfBRYxOAFF4guc4abNvgHeRfK8208qs7M812iA9MTbVIhhoyZHsk4DgrUIQsaIUEBv6MqACmqJ1rZFWwCytizVUX9VaS3DEUUlJ4nwNcLkl5p4Ooqd1TgXpB0LIldWJ+WhEqjnaSniFwNIaGSyy1XlG3KBg6atUvuVqlURgBX4ofZejqQMEbSE1ll6leMvi/EfYcd7Sssd1pPsO5Q4Hxr4R1kzJKuWZjjch5beg+JgSo9zoi5LUrnY40CSPWfE6NplmQfQssv1d0afss0Vd66SJxXDyuTom0Ir+ngCIhunooViEOJ8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c5Rq6+voAr41stTFgInmp4ByXbWM0b0Au3R9Ag49qkg=;
 b=EAuJNMKwiCJjShrvFWo1dBH3LPOzrMg2SksEilq92TsF86i9NNM/MF2fIkmrlkC+x5zMgKWBUF/hHJFvz4m0i6uAdEHY5TVPn+RK+g6gsZ1elUJFqqyPn8pSMRJar5L0nWrhStxiiRloUPkRNt4kE9Z1UO4ZDeogMRx2/BPj4l+p618zux/DAbZWIOxqt9cHs6Q0sQcTve3IZvxOxFHzDZCnclzbQAPgI+QL+KGN7oLlapvmcxcoHpYV5ymtXyb8ztBG3fPDsEZtTUnHaYG02UiWUeSbKRKww3WbDZLDnRRjPk/LFU/O7398xdTfjBjOPbKGcLXzAdKOiEjmyCfcjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c5Rq6+voAr41stTFgInmp4ByXbWM0b0Au3R9Ag49qkg=;
 b=Yu9HLb7NwzxbHMpnoO6nNbdyggtmAMEDTzU3hZPaf4AEMpkwlphMVnKJJS+nguwXEI1hBsAmn2dfpCNMbTPi38pnovpxdO3fGk90lNX0auRuwYXs3Ob6YmX/yRyI0DzgsWjlR781EsBZbXpCKl57mvayoM/kpj/nihzOqvBpaqN6hAExlXMX3k3oshvNYFTa5OV1+BiXZXDm/pBKej96XzPGE7hlF6c0GQlfSqM0qFNvOcNiFZDB0D1gtAXyU0G3ak/M+hCkVWiO6S/q2eH5tj2wEZuYP0EwY7IBtIkNsQvfu5cqRmxsktnNPz6Eql4eLBdCcHyN8qSp8NOr0wZ9yA==
Received: from BYAPR08CA0038.namprd08.prod.outlook.com (2603:10b6:a03:117::15)
 by IA1PR12MB7543.namprd12.prod.outlook.com (2603:10b6:208:42d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Mon, 14 Oct
 2024 20:54:20 +0000
Received: from SJ1PEPF00001CE2.namprd05.prod.outlook.com
 (2603:10b6:a03:117:cafe::3a) by BYAPR08CA0038.outlook.office365.com
 (2603:10b6:a03:117::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26 via Frontend
 Transport; Mon, 14 Oct 2024 20:54:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00001CE2.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Mon, 14 Oct 2024 20:54:19 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 14 Oct
 2024 13:54:07 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 14 Oct
 2024 13:54:07 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Mon, 14 Oct
 2024 13:54:04 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, <cjubran@nvidia.com>,
	<cratiu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next V2 03/15] net/mlx5: Add parent group support in rate group structure
Date: Mon, 14 Oct 2024 23:52:48 +0300
Message-ID: <20241014205300.193519-4-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241014205300.193519-1-tariqt@nvidia.com>
References: <20241014205300.193519-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE2:EE_|IA1PR12MB7543:EE_
X-MS-Office365-Filtering-Correlation-Id: ce396853-8179-4850-02e2-08dcec925f8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XKJ5mdmyg5XrUdzST7nFqEY/zb3+9IzWx4SN2Y3OwmHt+dEOw452XPGrHrI0?=
 =?us-ascii?Q?Q7Sj+LBeY5TsnHzIjZdIVtxs+MohH7arikadGoeoCunkr0ZLluTl6lUAR0Ug?=
 =?us-ascii?Q?fLPZuL6LawUSbdTIefW1Lgr1+dOeLQ6BHWYNY6zs5W4e0IpmZ74Mhb+yCaLh?=
 =?us-ascii?Q?K0zVx9I0bMr+2iDBKfcAq85PcorGp09BFR90WewdW/5Tm8PdsTZTiDaPVhqr?=
 =?us-ascii?Q?8A6Y7H+BIL7MJCXBIEUG79EYQuMqWSkU62XRLXxCXOFAmAD2p+ppMgnuE1am?=
 =?us-ascii?Q?dCXiVEOfPLb8DWN4x4kUV8nPHKhBiChvPYNlOWs9KMeTKtGKJ/Le8cplIVdo?=
 =?us-ascii?Q?JQTlwi8sBYeRpnYGwN5u/2VA/NCCX5dA0n0pCRrSmw9Y2ennUn+UnXzuWa7E?=
 =?us-ascii?Q?Ycqc+rxhkr5MdRntW22+zZgwg2KwdNPCDfaQ7ePIOzaZg1UxZj7LH/Enqo29?=
 =?us-ascii?Q?GjXguXs4FBZLUt6nGx3aNDz728mZJv0KfH9HGXlRNSaDtEq3B6YzGUyykHrx?=
 =?us-ascii?Q?8WHkOrgvwDw1RK3KcZm39NCm2B08abTpJVzb0xGjd3mMg0xRUGOq6PL45pOz?=
 =?us-ascii?Q?8KGLPwtlwNjJrzRWpkqzRYLWFjlKd4c4MeBOr/Ca36FGgc6A3YOb+zdTKbOC?=
 =?us-ascii?Q?g99RUvGuiwO/mHvnBMAREJKszksM810LFQNUzMiRT3fBtEzdjk/sYt3IsADx?=
 =?us-ascii?Q?cdsx4QRZzvzfl/Ag9l8+4zjNsPjWq2U+j9t+2bYHHNYFxnAOv0lGGLrr+wcW?=
 =?us-ascii?Q?855uJTSl8tkZhemaiTN/GUF4fnc7sh9PRHLlS37Me85O+3LiQoHWyoJg3ute?=
 =?us-ascii?Q?WcBv07BJGyzaVd7lNFkJ0F7OZs9CDR03se552gefsj02fYTp0GcAThDt1aed?=
 =?us-ascii?Q?7IlF6mNhKqkHryGg4FjkeModtPGHmclkVEO/0Zv1lo8mq9WXfdS9+ymDcyqh?=
 =?us-ascii?Q?9iRJ7Wg2uVU7GuThFy4DorRTE8J02W0Vq5TbKzJrS/G7MB8ZnTEM+j0KlqTc?=
 =?us-ascii?Q?ZJ+kjs0sTyaOzbZc+Qn9onP0OaGpe4SO76TQjHjzL5icNnIdmmYS4p7Zq0J+?=
 =?us-ascii?Q?G6gldeErEEAWTvO26fv8Q9dq19kkCMXSttGlvyrydqLfx9DNaQVyqir9TqJy?=
 =?us-ascii?Q?SGXHMC3dQ4hyK+xnkM8CTPrZmi8x8Q4HcPj26U1xU+VhWQmInoPVEKeVdk1h?=
 =?us-ascii?Q?ZCagNhVMz3oEivBd5NCm3PqOgunlXg3+wv19GccDCSaVIb+zhW/yeBFTSqm9?=
 =?us-ascii?Q?P8ZO7mQEA7Uaxsqoykii8hG4RZuomDtMTZRCmTxeN5qt3Txxw3EqM5AeuVer?=
 =?us-ascii?Q?ukoIZrwVmdBsS4rqtoU2+deNyNPdQu+Pm520oazXtd+eCfJ9oYaGkIujPC0j?=
 =?us-ascii?Q?Esg5GMcohHntzJbS2MF6/NApn7TQ?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 20:54:19.1106
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce396853-8179-4850-02e2-08dcec925f8f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7543

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


