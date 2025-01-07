Return-Path: <netdev+bounces-155730-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FEC3A037B8
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 07:10:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 155051882357
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 06:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E4991E04B3;
	Tue,  7 Jan 2025 06:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JCpa6ykk"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB3218641
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 06:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736230165; cv=fail; b=ilv6okhr67zOYbwKjH4swTpfnEUn5dbgnWLRiJ5Pvy78qQ0IViOyi8WKzu6BWGdmBnFaCjMtvuEmOaEcKuyYo14nJu1sPsVz6Gqe8btCa27skGQQtNKf3opyvfaWVPDXVQLZnD4ZzWXX0i1cAFQHto2wQF2uwT7kf7rQ0nbBpb0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736230165; c=relaxed/simple;
	bh=p2FWQFKyBm34MyTDfOavmW64cFGOd3FaV7TCaBdwUqU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=obwZbIZjCYn/nmkkrgLsJ4zu3VpBQcoqZOPhd24IUJgnMzmDt8kjgHl3plRCDcz+SJ08blONoxMvRQD1lhlCkzNRVyrz5YpegOMuyh+Y2PMfuDM9sPGWApXnxMWcpxBdTyRvkL1YqwJGQiIwB/1P458BneMpc+neYo2ynLVojJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JCpa6ykk; arc=fail smtp.client-ip=40.107.220.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N/IVD5dWMQi22B6SHJM7plaRVKsWQb/3bOD1v4keizIhRe8fcJQ177kr3+qBMYVnGsnl9/2KWVqVeWNFhPGTcFEumtL+A/f+ZxwANUU6FodhVlMJ2egkRTanazXYDbc8C1WQT2LRE+X/WR4pmP5pj4Be7LPcHD0TG5Q+xuRCaFT4u9LXbkK6GFswHa5mNqLQ2DOoI2jY6IYpznXpnzN+OcCuMw0wqua0IavCXdNAaupiMSm3VpFRQ1pMDzSjopZYIi6VC/TgIw8mz2YKxFlynVWg8Bh7UswqnPA5PkV73+Q/ydQW7Cp6Lv0fIxt5ZTlpuF03RjyQZxfvpyyUy9EhqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BtsQIl1waYU5IS/QzsGyFM2p0PVN4GfggxYMBN50pP0=;
 b=QULMNoJ7fBiQFbMkgGxYTNAknX7n63FDDVm5Ue8VDR6nq58x2PryddsSOaB750u4uLR5k7R+AZ+Tr2NvhvMn0OPkOZMuqGBgR/wbc493v6yK2utPyODOieTYzh+yNdSxnUG9VxYsa4zJM1dwYlB0JDy2npBIk62bGBNzrIUuLWC/GJN8YUaKVo16VpgfCX0em4jyxfiQfTFzw29m5cevXz/PS20zOyYCmfOb65oXexOxsaCwtFoJXJuFX9zVkXTS7ptZXt5B3vCQORBweKili0ZRD8h4NcWkKHguUVVzrzzTC9Pu9/AisqLrSEa2qHbQed6xFT5WWBYk026Q62A2WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BtsQIl1waYU5IS/QzsGyFM2p0PVN4GfggxYMBN50pP0=;
 b=JCpa6ykkazpFV7Ormc80x6IYUpppbm8yYK5oPCVB8rG3ftoKfZsrGlgoya0cuBFZx07fPJCu6cp90atCROzxcFMDaqpBiC1rOknIVKxxwPZJ+ZcwftCgFhpqAAujVcZ/DRfYcqgXg5YFb/Pvmp5Fb/773F4MhdRO4D6YVzzwxAbZcucLVo5O0r/o7LLzamG+GOR8L6h8WGEPMnmRZVIjKypaeVlzVvzELihj46wqVyOmxd5FCvSw5oH+uxAGbAFxP8pxidV1Kq2FEnmF6QLcEuAyV7GZuam1FkiNpezMQmXMAz4pTJeZeRfd0Rg5QNe5ahp78PRNWYzZgBC9SXzXXA==
Received: from CH5PR02CA0007.namprd02.prod.outlook.com (2603:10b6:610:1ed::29)
 by SJ1PR12MB6025.namprd12.prod.outlook.com (2603:10b6:a03:48c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Tue, 7 Jan
 2025 06:09:09 +0000
Received: from CH1PEPF0000AD76.namprd04.prod.outlook.com
 (2603:10b6:610:1ed:cafe::d1) by CH5PR02CA0007.outlook.office365.com
 (2603:10b6:610:1ed::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.17 via Frontend Transport; Tue,
 7 Jan 2025 06:09:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000AD76.mail.protection.outlook.com (10.167.244.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.7 via Frontend Transport; Tue, 7 Jan 2025 06:09:08 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 6 Jan 2025
 22:08:53 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 6 Jan 2025
 22:08:52 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Mon, 6 Jan
 2025 22:08:49 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Yevgeny Kliteynik
	<kliteyn@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 09/13] net/mlx5: fs, add HWS fte API functions
Date: Tue, 7 Jan 2025 08:07:04 +0200
Message-ID: <20250107060708.1610882-10-tariqt@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250107060708.1610882-1-tariqt@nvidia.com>
References: <20250107060708.1610882-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD76:EE_|SJ1PR12MB6025:EE_
X-MS-Office365-Filtering-Correlation-Id: 8778654c-0f10-48c1-4c8a-08dd2ee1cc2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2UVn1YJPUD5S4uwHUdxU/dKCe9+syUrCiXfXcEJrw67MQiv6IT3ZvZivI6fq?=
 =?us-ascii?Q?ejjUbk4VaJtZ2z8a50LpkxD/GaAL3ze5XXdhD8x6i6uLwAIvUccSLndmG7ut?=
 =?us-ascii?Q?AAdIqfYICQ+GmvdEEEULC40vAmaFko7rohUGzZCVFvvSpA9GKItNn+YmebHq?=
 =?us-ascii?Q?SruQp6lJ0ooAATsttw1Q5KTcCqzYPuNHqGkAxKTVKVX8ntCq6hGq8zyYOWX3?=
 =?us-ascii?Q?W/Vd6pmSSY+k4dptdbeDgTBlnybrkzdP+GkvkF2e3F6/04Naoy16vu+r+I++?=
 =?us-ascii?Q?MFTVInHtYbTPjF37iVLcpGU77KsRdMN+Qn66r+McY8NqIv0LFxHcU5C7uYL6?=
 =?us-ascii?Q?H7LZzQOqv+ls44qgkcLQd3EAuGrQRtNuvUOVpF+fyP5bxOXiIGE5ZG3eo/px?=
 =?us-ascii?Q?PlTLGcu50nE2WqnFyu8gvb6gsTSVY5GR4LJlZwLDjlJ+b5iSubAnBBf3HEku?=
 =?us-ascii?Q?jNjB2o+QQtrgQTj7KgkoYa59AHmvT2sUFcs/MeIkwvJZvoJdZlhabTPTTNu5?=
 =?us-ascii?Q?RNQvzvgxnpgdBFxv50H7EMeoYU+M1/ffQMFs6uo6qteiWAMvRrSh2hRbnu7K?=
 =?us-ascii?Q?08HxZmORGAlKSwl8ife8rDpxZndO/43mVdqCje717ZxJ4GBIoIm7HwfUOEyQ?=
 =?us-ascii?Q?UkP2WTZ33G6YCQqB8UX1yLyWXaJYlDHBZ8Qb+JSdklHlw0IGQUKIuADDX3LT?=
 =?us-ascii?Q?CdjkeOUqJWWbYph0LR9Rw3PdfhzGvY2bk2S7CO8Y93G7xXgaOAepn0p77voQ?=
 =?us-ascii?Q?YPpgPzpDH3sPY3dmOqyT/ePVgRTyANvRQMeO6K+CFNmv+BXa+YEsnPxDTInL?=
 =?us-ascii?Q?YZu7G9JMPEaYCxQXa7btwOyyHlS5drAmyfZpgKybMcdgr3/UTcDWRAgRZRi8?=
 =?us-ascii?Q?L25+ymv1tkqIfixrZVjCi1aenTKES/RU0OezHuBy3j4wNJGYKhQGATjDeDY4?=
 =?us-ascii?Q?e2oVndTpgBiWcOybj3tJ8vusdI6bczgoDb1jcacsIyd41JW6v+mp6kHGlxNS?=
 =?us-ascii?Q?hY/ZE/7RrNbpwYvAGcL3c/yIAFoDUsb/+Gaw9QB7pSHoQ7bEmoSaxvHaVbHe?=
 =?us-ascii?Q?7VzpWFkkDrbePlY8qyPxatTKPD2fDotoVmJ2coqy/b1EOsiA5dtQshFvoHVD?=
 =?us-ascii?Q?P2eQcUmVhY3vA0Eo2MUfbt4LPBMhXF/kGUFkDDL6OsCkgoZU1lijrUQw5f8t?=
 =?us-ascii?Q?BEggiDFB+SePgf8Lp1PkyNv7KhxYkfsgSm1pXjWajNSn9jL5Nbw6GrSZz1k/?=
 =?us-ascii?Q?yaasIx9Kesrggp525msOhmAEeIhQW4hOtlnwK2GfE9W8aG5FJSjTlM+1Kv/u?=
 =?us-ascii?Q?nkfQK6xpZwsoQ+AOy7LXiRJRvP9K/tD744Q57BsVIviKSGDcCI/rmg1+JPvO?=
 =?us-ascii?Q?gO9tjSw4svLUVVY7bafXMWWExGM9oa1LLEyWtYl0XOlogEGl0TR+gmLnWn1M?=
 =?us-ascii?Q?b8mDQtG0fgvrhVff+3rODllI9iUiDM+g4+eGCLsVTINrJeZr17JykzTyS/nl?=
 =?us-ascii?Q?wypKnLdI/1uzlfs=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 06:09:08.2865
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8778654c-0f10-48c1-4c8a-08dd2ee1cc2e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD76.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6025

From: Moshe Shemesh <moshe@nvidia.com>

Add create, destroy and update fte API functions for adding, removing
and updating flow steering rules in HW Steering mode. Get HWS actions
according to required rule, use actions from pool whenever possible.

Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/fs_core.h |   5 +-
 .../mellanox/mlx5/core/steering/hws/fs_hws.c  | 543 ++++++++++++++++++
 .../mellanox/mlx5/core/steering/hws/fs_hws.h  |  13 +
 3 files changed, 560 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h
index b6543a53d7c3..db0458b46390 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h
@@ -254,7 +254,10 @@ struct fs_fte_dup {
 /* Type of children is mlx5_flow_rule */
 struct fs_fte {
 	struct fs_node			node;
-	struct mlx5_fs_dr_rule		fs_dr_rule;
+	union {
+		struct mlx5_fs_dr_rule		fs_dr_rule;
+		struct mlx5_fs_hws_rule		fs_hws_rule;
+	};
 	u32				val[MLX5_ST_SZ_DW_MATCH_PARAM];
 	struct fs_fte_action		act_dests;
 	struct fs_fte_dup		*dup;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
index 6ee902999a01..e142e350160a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
@@ -357,6 +357,546 @@ static int mlx5_cmd_hws_destroy_flow_group(struct mlx5_flow_root_namespace *ns,
 	return mlx5hws_bwc_matcher_destroy(fg->fs_hws_matcher.matcher);
 }
 
+static struct mlx5hws_action *
+get_dest_action_ft(struct mlx5_fs_hws_context *fs_ctx,
+		   struct mlx5_flow_rule *dst)
+{
+	return xa_load(&fs_ctx->hws_pool.table_dests, dst->dest_attr.ft->id);
+}
+
+static struct mlx5hws_action *
+get_dest_action_table_num(struct mlx5_fs_hws_context *fs_ctx,
+			  struct mlx5_flow_rule *dst)
+{
+	u32 table_num = dst->dest_attr.ft_num;
+
+	return xa_load(&fs_ctx->hws_pool.table_dests, table_num);
+}
+
+static struct mlx5hws_action *
+create_dest_action_table_num(struct mlx5_fs_hws_context *fs_ctx,
+			     struct mlx5_flow_rule *dst)
+{
+	u32 flags = MLX5HWS_ACTION_FLAG_HWS_FDB | MLX5HWS_ACTION_FLAG_SHARED;
+	struct mlx5hws_context *ctx = fs_ctx->hws_ctx;
+	u32 table_num = dst->dest_attr.ft_num;
+
+	return mlx5hws_action_create_dest_table_num(ctx, table_num, flags);
+}
+
+static struct mlx5hws_action *
+create_dest_action_range(struct mlx5hws_context *ctx, struct mlx5_flow_rule *dst)
+{
+	u32 flags = MLX5HWS_ACTION_FLAG_HWS_FDB | MLX5HWS_ACTION_FLAG_SHARED;
+	struct mlx5_flow_destination *dest_attr = &dst->dest_attr;
+
+	return mlx5hws_action_create_dest_match_range(ctx,
+						      dest_attr->range.field,
+						      dest_attr->range.hit_ft,
+						      dest_attr->range.miss_ft,
+						      dest_attr->range.min,
+						      dest_attr->range.max,
+						      flags);
+}
+
+static struct mlx5hws_action *
+create_action_dest_array(struct mlx5hws_context *ctx,
+			 struct mlx5hws_action_dest_attr *dests,
+			 u32 num_of_dests, bool ignore_flow_level,
+			 u32 flow_source)
+{
+	u32 flags = MLX5HWS_ACTION_FLAG_HWS_FDB | MLX5HWS_ACTION_FLAG_SHARED;
+
+	return mlx5hws_action_create_dest_array(ctx, num_of_dests, dests,
+						ignore_flow_level,
+						flow_source, flags);
+}
+
+static struct mlx5hws_action *
+get_action_push_vlan(struct mlx5_fs_hws_context *fs_ctx)
+{
+	return fs_ctx->hws_pool.push_vlan_action;
+}
+
+static u32 calc_vlan_hdr(struct mlx5_fs_vlan *vlan)
+{
+	u16 n_ethtype = vlan->ethtype;
+	u8 prio = vlan->prio;
+	u16 vid = vlan->vid;
+
+	return (u32)n_ethtype << 16 | (u32)(prio) << 12 | (u32)vid;
+}
+
+static struct mlx5hws_action *
+get_action_pop_vlan(struct mlx5_fs_hws_context *fs_ctx)
+{
+	return fs_ctx->hws_pool.pop_vlan_action;
+}
+
+static struct mlx5hws_action *
+get_action_decap_tnl_l2_to_l2(struct mlx5_fs_hws_context *fs_ctx)
+{
+	return fs_ctx->hws_pool.decapl2_action;
+}
+
+static struct mlx5hws_action *
+get_dest_action_drop(struct mlx5_fs_hws_context *fs_ctx)
+{
+	return fs_ctx->hws_pool.drop_action;
+}
+
+static struct mlx5hws_action *
+get_action_tag(struct mlx5_fs_hws_context *fs_ctx)
+{
+	return fs_ctx->hws_pool.tag_action;
+}
+
+static struct mlx5hws_action *
+create_action_last(struct mlx5hws_context *ctx)
+{
+	u32 flags = MLX5HWS_ACTION_FLAG_HWS_FDB | MLX5HWS_ACTION_FLAG_SHARED;
+
+	return mlx5hws_action_create_last(ctx, flags);
+}
+
+static void destroy_fs_action(struct mlx5_fs_hws_rule_action *fs_action)
+{
+	switch (mlx5hws_action_get_type(fs_action->action)) {
+	case MLX5HWS_ACTION_TYP_CTR:
+		mlx5_fc_put_hws_action(fs_action->counter);
+		break;
+	default:
+		mlx5hws_action_destroy(fs_action->action);
+	}
+}
+
+static void destroy_fs_actions(struct mlx5_fs_hws_rule_action **fs_actions,
+			       int *num_fs_actions)
+{
+	int i;
+
+	/* Free in reverse order to handle action dependencies */
+	for (i = *num_fs_actions - 1; i >= 0; i--)
+		destroy_fs_action(*fs_actions + i);
+	*num_fs_actions = 0;
+	kfree(*fs_actions);
+	*fs_actions = NULL;
+}
+
+/* Splits FTE's actions into cached, rule and destination actions.
+ * The cached and destination actions are saved on the fte hws rule.
+ * The rule actions are returned as a parameter, together with their count.
+ * We want to support a rule with 32 destinations, which means we need to
+ * account for 32 destinations plus usually a counter plus one more action
+ * for a multi-destination flow table.
+ * 32 is SW limitation for array size, keep. HWS limitation is 16M STEs per matcher
+ */
+#define MLX5_FLOW_CONTEXT_ACTION_MAX 34
+static int fte_get_hws_actions(struct mlx5_flow_root_namespace *ns,
+			       struct mlx5_flow_table *ft,
+			       struct mlx5_flow_group *group,
+			       struct fs_fte *fte,
+			       struct mlx5hws_rule_action **ractions)
+{
+	struct mlx5_flow_act *fte_action = &fte->act_dests.action;
+	struct mlx5_fs_hws_context *fs_ctx = &ns->fs_hws_context;
+	struct mlx5hws_action_dest_attr *dest_actions;
+	struct mlx5hws_context *ctx = fs_ctx->hws_ctx;
+	struct mlx5_fs_hws_rule_action *fs_actions;
+	struct mlx5_core_dev *dev = ns->dev;
+	struct mlx5hws_action *dest_action;
+	struct mlx5hws_action *tmp_action;
+	struct mlx5_fs_hws_pr *pr_data;
+	struct mlx5_fs_hws_mh *mh_data;
+	bool delay_encap_set = false;
+	struct mlx5_flow_rule *dst;
+	int num_dest_actions = 0;
+	int num_fs_actions = 0;
+	int num_actions = 0;
+	int err;
+
+	*ractions = kcalloc(MLX5_FLOW_CONTEXT_ACTION_MAX, sizeof(**ractions),
+			    GFP_KERNEL);
+	if (!*ractions) {
+		err = -ENOMEM;
+		goto out_err;
+	}
+
+	fs_actions = kcalloc(MLX5_FLOW_CONTEXT_ACTION_MAX,
+			     sizeof(*fs_actions), GFP_KERNEL);
+	if (!fs_actions) {
+		err = -ENOMEM;
+		goto free_actions_alloc;
+	}
+
+	dest_actions = kcalloc(MLX5_FLOW_CONTEXT_ACTION_MAX,
+			       sizeof(*dest_actions), GFP_KERNEL);
+	if (!dest_actions) {
+		err = -ENOMEM;
+		goto free_fs_actions_alloc;
+	}
+
+	/* The order of the actions are must to be kept, only the following
+	 * order is supported by HW steering:
+	 * HWS: decap -> remove_hdr -> pop_vlan -> modify header -> push_vlan
+	 *      -> reformat (insert_hdr/encap) -> ctr -> tag -> aso
+	 *      -> drop -> FWD:tbl/vport/sampler/tbl_num/range -> dest_array -> last
+	 */
+	if (fte_action->action & MLX5_FLOW_CONTEXT_ACTION_DECAP) {
+		tmp_action = get_action_decap_tnl_l2_to_l2(fs_ctx);
+		if (!tmp_action) {
+			err = -ENOMEM;
+			goto free_dest_actions_alloc;
+		}
+		(*ractions)[num_actions++].action = tmp_action;
+	}
+
+	if (fte_action->action & MLX5_FLOW_CONTEXT_ACTION_PACKET_REFORMAT) {
+		int reformat_type = fte_action->pkt_reformat->reformat_type;
+
+		if (fte_action->pkt_reformat->owner == MLX5_FLOW_RESOURCE_OWNER_FW) {
+			mlx5_core_err(dev, "FW-owned reformat can't be used in HWS rule\n");
+			err = -EINVAL;
+			goto free_actions;
+		}
+
+		if (reformat_type == MLX5_REFORMAT_TYPE_L3_TUNNEL_TO_L2) {
+			pr_data = fte_action->pkt_reformat->fs_hws_action.pr_data;
+			(*ractions)[num_actions].reformat.offset = pr_data->offset;
+			(*ractions)[num_actions].reformat.hdr_idx = pr_data->hdr_idx;
+			(*ractions)[num_actions].reformat.data = pr_data->data;
+			(*ractions)[num_actions++].action =
+				fte_action->pkt_reformat->fs_hws_action.hws_action;
+		} else if (reformat_type == MLX5_REFORMAT_TYPE_REMOVE_HDR) {
+			(*ractions)[num_actions++].action =
+				fte_action->pkt_reformat->fs_hws_action.hws_action;
+		} else {
+			delay_encap_set = true;
+		}
+	}
+
+	if (fte_action->action & MLX5_FLOW_CONTEXT_ACTION_VLAN_POP) {
+		tmp_action = get_action_pop_vlan(fs_ctx);
+		if (!tmp_action) {
+			err = -ENOMEM;
+			goto free_actions;
+		}
+		(*ractions)[num_actions++].action = tmp_action;
+	}
+
+	if (fte_action->action & MLX5_FLOW_CONTEXT_ACTION_VLAN_POP_2) {
+		tmp_action = get_action_pop_vlan(fs_ctx);
+		if (!tmp_action) {
+			err = -ENOMEM;
+			goto free_actions;
+		}
+		(*ractions)[num_actions++].action = tmp_action;
+	}
+
+	if (fte_action->action & MLX5_FLOW_CONTEXT_ACTION_MOD_HDR) {
+		mh_data = fte_action->modify_hdr->fs_hws_action.mh_data;
+		(*ractions)[num_actions].modify_header.offset = mh_data->offset;
+		(*ractions)[num_actions].modify_header.data = mh_data->data;
+		(*ractions)[num_actions++].action =
+			fte_action->modify_hdr->fs_hws_action.hws_action;
+	}
+
+	if (fte_action->action & MLX5_FLOW_CONTEXT_ACTION_VLAN_PUSH) {
+		tmp_action = get_action_push_vlan(fs_ctx);
+		if (!tmp_action) {
+			err = -ENOMEM;
+			goto free_actions;
+		}
+		(*ractions)[num_actions].push_vlan.vlan_hdr =
+			htonl(calc_vlan_hdr(&fte_action->vlan[0]));
+		(*ractions)[num_actions++].action = tmp_action;
+	}
+
+	if (fte_action->action & MLX5_FLOW_CONTEXT_ACTION_VLAN_PUSH_2) {
+		tmp_action = get_action_push_vlan(fs_ctx);
+		if (!tmp_action) {
+			err = -ENOMEM;
+			goto free_actions;
+		}
+		(*ractions)[num_actions].push_vlan.vlan_hdr =
+			htonl(calc_vlan_hdr(&fte_action->vlan[1]));
+		(*ractions)[num_actions++].action = tmp_action;
+	}
+
+	if (delay_encap_set) {
+		pr_data = fte_action->pkt_reformat->fs_hws_action.pr_data;
+		(*ractions)[num_actions].reformat.offset = pr_data->offset;
+		(*ractions)[num_actions].reformat.data = pr_data->data;
+		(*ractions)[num_actions++].action =
+			fte_action->pkt_reformat->fs_hws_action.hws_action;
+	}
+
+	if (fte_action->action & MLX5_FLOW_CONTEXT_ACTION_COUNT) {
+		list_for_each_entry(dst, &fte->node.children, node.list) {
+			struct mlx5_fc *counter;
+
+			if (dst->dest_attr.type !=
+			    MLX5_FLOW_DESTINATION_TYPE_COUNTER)
+				continue;
+
+			if (num_actions == MLX5_FLOW_CONTEXT_ACTION_MAX) {
+				err = -EOPNOTSUPP;
+				goto free_actions;
+			}
+
+			counter = dst->dest_attr.counter;
+			tmp_action = mlx5_fc_get_hws_action(ctx, counter);
+			if (!tmp_action) {
+				err = -EINVAL;
+				goto free_actions;
+			}
+
+			(*ractions)[num_actions].counter.offset =
+				mlx5_fc_id(counter) - mlx5_fc_get_base_id(counter);
+			(*ractions)[num_actions++].action = tmp_action;
+			fs_actions[num_fs_actions].action = tmp_action;
+			fs_actions[num_fs_actions++].counter = counter;
+		}
+	}
+
+	if (fte->act_dests.flow_context.flow_tag) {
+		if (num_actions == MLX5_FLOW_CONTEXT_ACTION_MAX) {
+			err = -EOPNOTSUPP;
+			goto free_actions;
+		}
+		tmp_action = get_action_tag(fs_ctx);
+		if (!tmp_action) {
+			err = -ENOMEM;
+			goto free_actions;
+		}
+		(*ractions)[num_actions].tag.value = fte->act_dests.flow_context.flow_tag;
+		(*ractions)[num_actions++].action = tmp_action;
+	}
+
+	if (fte_action->action & MLX5_FLOW_CONTEXT_ACTION_EXECUTE_ASO) {
+		err = -EOPNOTSUPP;
+		goto free_actions;
+	}
+
+	if (fte_action->action & MLX5_FLOW_CONTEXT_ACTION_DROP) {
+		dest_action = get_dest_action_drop(fs_ctx);
+		if (!dest_action) {
+			err = -ENOMEM;
+			goto free_actions;
+		}
+		dest_actions[num_dest_actions++].dest = dest_action;
+	}
+
+	if (fte_action->action & MLX5_FLOW_CONTEXT_ACTION_FWD_DEST) {
+		list_for_each_entry(dst, &fte->node.children, node.list) {
+			struct mlx5_flow_destination *attr = &dst->dest_attr;
+
+			if (num_fs_actions == MLX5_FLOW_CONTEXT_ACTION_MAX ||
+			    num_dest_actions == MLX5_FLOW_CONTEXT_ACTION_MAX) {
+				err = -EOPNOTSUPP;
+				goto free_actions;
+			}
+			if (attr->type == MLX5_FLOW_DESTINATION_TYPE_COUNTER)
+				continue;
+
+			switch (attr->type) {
+			case MLX5_FLOW_DESTINATION_TYPE_FLOW_TABLE:
+				dest_action = get_dest_action_ft(fs_ctx, dst);
+				break;
+			case MLX5_FLOW_DESTINATION_TYPE_FLOW_TABLE_NUM:
+				dest_action = get_dest_action_table_num(fs_ctx, dst);
+				if (dest_action)
+					break;
+				dest_action = create_dest_action_table_num(fs_ctx, dst);
+				fs_actions[num_fs_actions++].action = dest_action;
+				break;
+			case MLX5_FLOW_DESTINATION_TYPE_RANGE:
+				dest_action = create_dest_action_range(ctx, dst);
+				fs_actions[num_fs_actions++].action = dest_action;
+				break;
+			default:
+				err = -EOPNOTSUPP;
+				goto free_actions;
+			}
+			if (!dest_action) {
+				err = -ENOMEM;
+				goto free_actions;
+			}
+			dest_actions[num_dest_actions++].dest = dest_action;
+		}
+	}
+
+	if (num_dest_actions == 1) {
+		if (num_actions == MLX5_FLOW_CONTEXT_ACTION_MAX) {
+			err = -EOPNOTSUPP;
+			goto free_actions;
+		}
+		(*ractions)[num_actions++].action = dest_actions->dest;
+	} else if (num_dest_actions > 1) {
+		bool ignore_flow_level =
+			!!(fte_action->flags & FLOW_ACT_IGNORE_FLOW_LEVEL);
+
+		if (num_actions == MLX5_FLOW_CONTEXT_ACTION_MAX ||
+		    num_fs_actions == MLX5_FLOW_CONTEXT_ACTION_MAX) {
+			err = -EOPNOTSUPP;
+			goto free_actions;
+		}
+		tmp_action = create_action_dest_array(ctx, dest_actions,
+						      num_dest_actions,
+						      ignore_flow_level,
+						      fte->act_dests.flow_context.flow_source);
+		if (!tmp_action) {
+			err = -EOPNOTSUPP;
+			goto free_actions;
+		}
+		fs_actions[num_fs_actions++].action = tmp_action;
+		(*ractions)[num_actions++].action = tmp_action;
+	}
+
+	if (num_actions == MLX5_FLOW_CONTEXT_ACTION_MAX ||
+	    num_fs_actions == MLX5_FLOW_CONTEXT_ACTION_MAX) {
+		err = -EOPNOTSUPP;
+		goto free_actions;
+	}
+
+	tmp_action = create_action_last(ctx);
+	if (!tmp_action) {
+		err = -ENOMEM;
+		goto free_actions;
+	}
+	fs_actions[num_fs_actions++].action = tmp_action;
+	(*ractions)[num_actions++].action = tmp_action;
+
+	kfree(dest_actions);
+
+	/* Actions created specifically for this rule will be destroyed
+	 * once rule is deleted.
+	 */
+	fte->fs_hws_rule.num_fs_actions = num_fs_actions;
+	fte->fs_hws_rule.hws_fs_actions = fs_actions;
+
+	return 0;
+
+free_actions:
+	destroy_fs_actions(&fs_actions, &num_fs_actions);
+free_dest_actions_alloc:
+	kfree(dest_actions);
+free_fs_actions_alloc:
+	kfree(fs_actions);
+free_actions_alloc:
+	kfree(*ractions);
+	*ractions = NULL;
+out_err:
+	return err;
+}
+
+static int mlx5_cmd_hws_create_fte(struct mlx5_flow_root_namespace *ns,
+				   struct mlx5_flow_table *ft,
+				   struct mlx5_flow_group *group,
+				   struct fs_fte *fte)
+{
+	struct mlx5hws_match_parameters params;
+	struct mlx5hws_rule_action *ractions;
+	struct mlx5hws_bwc_rule *rule;
+	int err = 0;
+
+	if (mlx5_fs_cmd_is_fw_term_table(ft)) {
+		/* Packet reformat on terminamtion table not supported yet */
+		if (fte->act_dests.action.action &
+		    MLX5_FLOW_CONTEXT_ACTION_PACKET_REFORMAT)
+			return -EOPNOTSUPP;
+		return mlx5_fs_cmd_get_fw_cmds()->create_fte(ns, ft, group, fte);
+	}
+
+	err = fte_get_hws_actions(ns, ft, group, fte, &ractions);
+	if (err)
+		goto out_err;
+
+	params.match_sz = sizeof(fte->val);
+	params.match_buf = fte->val;
+
+	rule = mlx5hws_bwc_rule_create(group->fs_hws_matcher.matcher, &params,
+				       fte->act_dests.flow_context.flow_source,
+				       ractions);
+	kfree(ractions);
+	if (!rule) {
+		err = -EINVAL;
+		goto free_actions;
+	}
+
+	fte->fs_hws_rule.bwc_rule = rule;
+	return 0;
+
+free_actions:
+	destroy_fs_actions(&fte->fs_hws_rule.hws_fs_actions,
+			   &fte->fs_hws_rule.num_fs_actions);
+out_err:
+	mlx5_core_err(ns->dev, "Failed to create hws rule err(%d)\n", err);
+	return err;
+}
+
+static int mlx5_cmd_hws_delete_fte(struct mlx5_flow_root_namespace *ns,
+				   struct mlx5_flow_table *ft,
+				   struct fs_fte *fte)
+{
+	struct mlx5_fs_hws_rule *rule = &fte->fs_hws_rule;
+	int err;
+
+	if (mlx5_fs_cmd_is_fw_term_table(ft))
+		return mlx5_fs_cmd_get_fw_cmds()->delete_fte(ns, ft, fte);
+
+	err = mlx5hws_bwc_rule_destroy(rule->bwc_rule);
+	rule->bwc_rule = NULL;
+
+	destroy_fs_actions(&rule->hws_fs_actions, &rule->num_fs_actions);
+
+	return err;
+}
+
+static int mlx5_cmd_hws_update_fte(struct mlx5_flow_root_namespace *ns,
+				   struct mlx5_flow_table *ft,
+				   struct mlx5_flow_group *group,
+				   int modify_mask,
+				   struct fs_fte *fte)
+{
+	int allowed_mask = BIT(MLX5_SET_FTE_MODIFY_ENABLE_MASK_ACTION) |
+		BIT(MLX5_SET_FTE_MODIFY_ENABLE_MASK_DESTINATION_LIST) |
+		BIT(MLX5_SET_FTE_MODIFY_ENABLE_MASK_FLOW_COUNTERS);
+	struct mlx5_fs_hws_rule_action *saved_hws_fs_actions;
+	struct mlx5hws_rule_action *ractions;
+	int saved_num_fs_actions;
+	int ret;
+
+	if (mlx5_fs_cmd_is_fw_term_table(ft))
+		return mlx5_fs_cmd_get_fw_cmds()->update_fte(ns, ft, group,
+							     modify_mask, fte);
+
+	if ((modify_mask & ~allowed_mask) != 0)
+		return -EINVAL;
+
+	saved_hws_fs_actions = fte->fs_hws_rule.hws_fs_actions;
+	saved_num_fs_actions = fte->fs_hws_rule.num_fs_actions;
+
+	ret = fte_get_hws_actions(ns, ft, group, fte, &ractions);
+	if (ret)
+		return ret;
+
+	ret = mlx5hws_bwc_rule_action_update(fte->fs_hws_rule.bwc_rule, ractions);
+	kfree(ractions);
+	if (ret)
+		goto restore_actions;
+
+	destroy_fs_actions(&saved_hws_fs_actions, &saved_num_fs_actions);
+	return ret;
+
+restore_actions:
+	destroy_fs_actions(&fte->fs_hws_rule.hws_fs_actions,
+			   &fte->fs_hws_rule.num_fs_actions);
+	fte->fs_hws_rule.hws_fs_actions = saved_hws_fs_actions;
+	fte->fs_hws_rule.num_fs_actions = saved_num_fs_actions;
+	return ret;
+}
+
 static struct mlx5hws_action *
 create_action_remove_header_vlan(struct mlx5hws_context *ctx)
 {
@@ -712,6 +1252,9 @@ static const struct mlx5_flow_cmds mlx5_flow_cmds_hws = {
 	.update_root_ft = mlx5_cmd_hws_update_root_ft,
 	.create_flow_group = mlx5_cmd_hws_create_flow_group,
 	.destroy_flow_group = mlx5_cmd_hws_destroy_flow_group,
+	.create_fte = mlx5_cmd_hws_create_fte,
+	.delete_fte = mlx5_cmd_hws_delete_fte,
+	.update_fte = mlx5_cmd_hws_update_fte,
 	.packet_reformat_alloc = mlx5_cmd_hws_packet_reformat_alloc,
 	.packet_reformat_dealloc = mlx5_cmd_hws_packet_reformat_dealloc,
 	.modify_header_alloc = mlx5_cmd_hws_modify_header_alloc,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.h
index c9807abd6c25..d260b14e3963 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.h
@@ -43,6 +43,19 @@ struct mlx5_fs_hws_matcher {
 	struct mlx5hws_bwc_matcher *matcher;
 };
 
+struct mlx5_fs_hws_rule_action {
+	struct mlx5hws_action *action;
+	union {
+		struct mlx5_fc *counter;
+	};
+};
+
+struct mlx5_fs_hws_rule {
+	struct mlx5hws_bwc_rule *bwc_rule;
+	struct mlx5_fs_hws_rule_action *hws_fs_actions;
+	int num_fs_actions;
+};
+
 #ifdef CONFIG_MLX5_HW_STEERING
 
 const struct mlx5_flow_cmds *mlx5_fs_cmd_get_hws_cmds(void);
-- 
2.45.0


