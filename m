Return-Path: <netdev+bounces-135322-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2698199D890
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 22:54:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBB2D2825A1
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 20:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A05C61CFEDB;
	Mon, 14 Oct 2024 20:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BCxQ2PiZ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC36B1CB330
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 20:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728939263; cv=fail; b=N1u4xNK6ZGP9WL7L2K6G43zuHMtmJyE4CbBwuVYnxoWacBpd1tTkpa9d8+fIX9J2qotMuNDFaVVEPsJuuirSY/HPAAAH0q4VhWNRGAWgGEdKWOoyux8WVfrfpslV/Z5gnNa/Gi65LdITMDbie7faMxHpUGapdnVYWrBh1d1Uo94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728939263; c=relaxed/simple;
	bh=kZYr4fJVLqKrtKYPpwYkNDd3xCHnVUp/xycW5qf9Rpk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AOW4Msm2cFWNhDPzwGwv8Ddx3IK9TZOMzEmNn3HpB0cpjnR4GvM7QG5Wep68h3EOm4AoQH5u3D0bOQqzFiSCsqHTGGjOYgkNkhjH+Z1IsqR9Cepg0lWM0GmULUi9022blLTf3Q1PDB6EcP6esUXAt18iRgzzulsdur1oqhI58N0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BCxQ2PiZ; arc=fail smtp.client-ip=40.107.223.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hQaGc4A8yHDxRtcvpLZi8ELuOTRT116PExASV97WGJcTmv2PiUed0y9w+2h7MFEMoe3DhLW/Q4OH+Wes21xeab0R5zIjMPzrJ2zTdUG0rf8N/a61qo11vgFu9bIuWvNgKoJ6NZC+IySMKNvrW1S4x9v6lB6QcfawHfwjzI8vCg08IkBBvaRjWgmkjKOC9fizYTSReTIJRECpu0m7tv+zQI1LCcK/0hvJbTzyXz6t+t2eKATXLHUO3E8boDgRuLPkPrMb+Vkav/E8lOGzhL9xzykxpc6gzWJ20ak0nabvKvVQg2/gIgG1DcTl8Zu0QVtuYtXRxvznNHWKyff6o3pbwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y9bZdxbR4M3tw1Z8t+Zp9hI8dB82663xO1SRUQ8yE/0=;
 b=TUUOxLnXgJes0rkCpHUIjvzJ8d6Zbk0OXyvorlydV24gUeusyf61GpkX5TJee9k2pVLbTR7luGUxNkayaI/yNNokqboLDctjgFG9s/OrsPmUu3Ydt1OK9UXxZbILqv356CH7eTwxkjiAjaWywJ8Tw5jNhdrttz1BB26NV/Gc0ONOyQ+sjLISti7pmpYY+ePra8jTpJcozuFC/JOmW8nFbW2RF/8zhEVvAdjCVvOJLg3sNSjbdg5eldTdv5YIR25gV7RAySjdGVJIXE3Mq2TiNT6kTDP8d7AMuc5Zv8uZiMPCv1zqPTezngMzmXWqd6ZjLE3Y807ksppbuGeiWgLpfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y9bZdxbR4M3tw1Z8t+Zp9hI8dB82663xO1SRUQ8yE/0=;
 b=BCxQ2PiZdnIROWgEZdk21Ve3HaAqK5Hn8JOnbFs6RO88vUFPSqIuYODWPKpAgQNDynZI8nd9nyNKlMFPhrib3LGYJLjXNB5b3qhHON+frFxkvdTn66aVvTYOkTZZu4adr/kiDEW2LplCsH+vbM6E/6L5q9tC4C9wWlxQPowyz9OqWlTQQmcag/qiKxPnh2mG75nDs3GMksyqR+zdwPVvVCkCINgTo2tBa0VKx01lu0k2KouNHrz70H5taWaj+sHt632XFW08nkdWbbZJ+pnLCfMjegdVb4IaIFEaqDxQbc5wnL6ZxbK0lKetkeGx9T68crxasKz3uf7R21j7nKQhqw==
Received: from BYAPR08CA0072.namprd08.prod.outlook.com (2603:10b6:a03:117::49)
 by MW6PR12MB8661.namprd12.prod.outlook.com (2603:10b6:303:23f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Mon, 14 Oct
 2024 20:54:16 +0000
Received: from SJ1PEPF00001CDF.namprd05.prod.outlook.com
 (2603:10b6:a03:117:cafe::fb) by BYAPR08CA0072.outlook.office365.com
 (2603:10b6:a03:117::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27 via Frontend
 Transport; Mon, 14 Oct 2024 20:54:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00001CDF.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.17 via Frontend Transport; Mon, 14 Oct 2024 20:54:15 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 14 Oct
 2024 13:54:04 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 14 Oct
 2024 13:54:03 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Mon, 14 Oct
 2024 13:54:00 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, <cjubran@nvidia.com>,
	<cratiu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next V2 02/15] net/mlx5: Introduce node type to rate group structure
Date: Mon, 14 Oct 2024 23:52:47 +0300
Message-ID: <20241014205300.193519-3-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDF:EE_|MW6PR12MB8661:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f0d0ca6-32b8-4829-39d3-08dcec925d64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dDtWWXAcqoaLUyjuQjNm3FBLACVbeFFLnp6Yy/wbDddlZWE4aVdVCDraAO9J?=
 =?us-ascii?Q?Npkj6eZ+gWGlljymFuPQsmHnXSEf2w44pTcfewkLXaxvTjjnsiPlDy1+UrSk?=
 =?us-ascii?Q?KI3lvdfMEuJjJrOB4K9ETFPUq3k2em24HkD7PdvmbOlbOyJ1r4fPUhWhCudi?=
 =?us-ascii?Q?KWJFmeFQZMkxJMGnB+TC0mEN9HhwU0H5x0hBKVxZ4dGCpiewDO9GGX+uH5zJ?=
 =?us-ascii?Q?8LzdLWU6wVdlvSAgK7KEzY22MruR2eIIPqiw/mzr4u65R38Uguox5bvhLPSt?=
 =?us-ascii?Q?bti2ec5lST6JUefxmE/1FaDSRBG+VQYztW0PH6hXtuiNs3v5NL7/h4kU0gxV?=
 =?us-ascii?Q?HHqrlZcihW5s5DLV2coWCfgdeXd5nv2K/KtHJWgxP00lFBGiZtMkPQ61SzW5?=
 =?us-ascii?Q?Xw64uQUYilxaEa915WHB5kTruN+gmulmH4gGvzrjG5HASAocrjeH21VIZX0Z?=
 =?us-ascii?Q?ymVsSDwd72bJ2qN9X70XcG+042PoKlbsZKVtCbrVlLYjihjrlBGktIKjA00P?=
 =?us-ascii?Q?GXWa4p2fQy6Ii2bGTRGIpMotEOz/1SRbMgX5dSCWbpg8W3Z6Hsk112UPXGVi?=
 =?us-ascii?Q?VVm8QyAHHjkoDcqlEfxsa2RZNfwN1BroiU5IA+WEvfxevQO9BwXdWZJZ5MmU?=
 =?us-ascii?Q?DwNXgjMfDRJX6fdSDOTwAj6/ROHXlnUKGB1Pe5rI5ttNg/CDl78XOs72WH0t?=
 =?us-ascii?Q?ivXxxnXWiQhDRb1FIKibwXJYjdY4cx+WDTs7i1mtUKWEK+kDnIfBueqXEbKl?=
 =?us-ascii?Q?Rt2AvZj68+jCpUXArSxRV0VoHK/Cesbwh+MTxYgDpG8Q4IKLtMHQNdHO1mFZ?=
 =?us-ascii?Q?ls9vgZeJiW8tMpnYGiVK1Yf+Nfl/CUfLEE1IASS7eEe8py/TEl0Ck88WxC17?=
 =?us-ascii?Q?3NMpT5ityn8kmnZgrD1VsOrTIoUUwKt8aQp6xO0Gb8wJmG1vMEDYAL0TU0vs?=
 =?us-ascii?Q?jk9IIYiGFHn5+K7P7bJ66hffORQtjM9GrKuZN/bHYBFB6Aq2wBSTOXctBqWA?=
 =?us-ascii?Q?c3izqT04VH8pve264/RL0td00zwYOTpN6NK7dPjCS8C6h3W4zV46OH33moKV?=
 =?us-ascii?Q?a1TXb8FiBaPEVzCg//eAgU/YJYJtmMcxxF20qs07vycIj3ejcaPrifL0yv5u?=
 =?us-ascii?Q?lP0KQ1RCw8yFnevyrmFR8dkKlS9Hkk1c2Z04aiBqA1zb2r+5hpyNIHbPzZcR?=
 =?us-ascii?Q?S0/erBlpnUqBvKIEpIrQZyq6lFjb2wqT5TDT/ct0oOrLzV0vQ6JTjPplb/SA?=
 =?us-ascii?Q?ThaRYoznPPaIg8/dzRRhxjECk4v1ahtVaJpLtqF7EERZUPjW0oSiG9AbQddR?=
 =?us-ascii?Q?eK6AErx5L/Wyju+SF4/n1HEfTfC1tYmBWD4uBbv2Pf7ZnOtj2kA8wTqjaooc?=
 =?us-ascii?Q?Pcq4JJSgRespOsrenfh8Rllpc830?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 20:54:15.4747
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f0d0ca6-32b8-4829-39d3-08dcec925d64
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8661

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


