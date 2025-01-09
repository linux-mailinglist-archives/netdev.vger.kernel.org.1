Return-Path: <netdev+bounces-156768-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0626FA07CE8
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 17:08:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE98E188CB36
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 16:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B176921E0BB;
	Thu,  9 Jan 2025 16:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="a1N0Wt/Y"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5D221E0A8
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 16:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736438876; cv=fail; b=GOSqRp6QKymjq70UTqCBg94zilME4yaZcJw8I/RRroyv2Gwr/WXFkGhd4XJeigc3jZEGFCr9fZmFhuV3A8IlqY/ZfqrSOpndF+onbs3zx7I1ZdbHAuYaK+LrSUof12/oEew3A+amMNSS2qKs5+vi1woephBfl9J+6eKvjxdaCUM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736438876; c=relaxed/simple;
	bh=XJODezJIQ94PIFcpCH6Ri6f8tMpAocT/42/8zT3Km+0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PNrTQZgZ0gXdOkDsLCWWY+0hFliYGfOhctOV1mKsdXxMHqIAi4IYclOzCXZMNLIZd2BpvBzImp8LqkejbzFKHbo3eAeHjUB2WbDe2qRKoxytI/UBvpu7azChvjKn6rkkxuKmRlKrjL/wllhddYmkDV/3HQvIu/scbOUpC7QNOrc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=a1N0Wt/Y; arc=fail smtp.client-ip=40.107.92.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CuIeV8DtF7FgRQ6OmIZUxYgl6u20wMoa8K7+qqumEWSAverLyN1r6t1mpss/Gpt3aeR6JbXIp2g6h9ZN9W8nDD0MF2tW7MahJfRue0d746bo8/VOm2YN9p8qjQv+hGA8GSit9K5Bg3JPDQWIkCRCJMpr6tt+cINar2CxOduasnc3eaPeBffHaaCZn7j2sX1oe06au6pPDQfH6VoUQn/2zuAL/JAyFZksbI/6v2cGDqPQ3nX/jKoSeJduGb+D8Ay2VXH5Yt7CDX1G3Cp0bkzmiiX1IdihRQC1YcEb5Xo/BtrIqjhW0r/NJppK5cxYqotQYrg5y8OmQK/AkxtFkP7yaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2O7qDrk0RA3GOwE1UJ9cUzVyYL42JXzDWruWuGd06uU=;
 b=G2UzP5jfroJ3J4dRC4Q61mKpbAWVLR8mLTf2CQVcwIpYSeyNaVpPCv4+pXIxJiHB5OLUl8dinhOPnqE4Gy1kSIxPkUHZqij0RdQnlQM4qG8gOpoq/cz33ifRRT789/FiNVU8NPef7YLlqchl3Wzn+24h5fdah3wUrXzVqs4/s0Uq3Kww3oiC5O3v2qWSftYPq4ik7o648KiM2Ey2V8nBEsh5Un0KwkWFgp2MzoSwJFEvgNIelsggBMUUqi0KsB/SusNQ6ix5ifJj6ABEeR985SdKvU6uTDaDGsfmXkfhI4r02gQTyW7hpxKvKFjEISqi9cVDK5M2vu5nAAyJGVWwZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2O7qDrk0RA3GOwE1UJ9cUzVyYL42JXzDWruWuGd06uU=;
 b=a1N0Wt/Yx4l47q4HruiVzH4iXiTzafq1ff2rGolwRUgzCGwOa9kHsm4CPtGVferbU918U3ezpMMMA9F+QMHJ6HHPYPsbqOt6e1v7MYUsx7+IBWTKta1zdg89J1FLU6G76OxtznnJZWA5ffON7KT5APoPYRCEIYWJiOPn5d2H/qvCs4YFdraMUzQN9lqy8WWY+SKK2zf6MhKbHIpyaqv+i816y71o+p3LWnmCnlbcjbIcaeiQE0pSPHEkvSebr+SDBxZiCtrx4tOGEnKbkhUeb+YkQQtx0fI/ghypOjng4hi8ThusnmZNxnAeqvrSGs6a1G33QBwC9NXLG2mASdHB1w==
Received: from MW4PR04CA0079.namprd04.prod.outlook.com (2603:10b6:303:6b::24)
 by IA1PR12MB8555.namprd12.prod.outlook.com (2603:10b6:208:44f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Thu, 9 Jan
 2025 16:07:46 +0000
Received: from CO1PEPF000044FD.namprd21.prod.outlook.com
 (2603:10b6:303:6b:cafe::5) by MW4PR04CA0079.outlook.office365.com
 (2603:10b6:303:6b::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.11 via Frontend Transport; Thu,
 9 Jan 2025 16:07:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000044FD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.0 via Frontend Transport; Thu, 9 Jan 2025 16:07:45 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 9 Jan 2025
 08:07:25 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 9 Jan 2025
 08:07:25 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Thu, 9 Jan
 2025 08:07:21 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Yevgeny Kliteynik
	<kliteyn@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next V2 09/15] net/mlx5: fs, add HWS fte API functions
Date: Thu, 9 Jan 2025 18:05:40 +0200
Message-ID: <20250109160546.1733647-10-tariqt@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250109160546.1733647-1-tariqt@nvidia.com>
References: <20250109160546.1733647-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FD:EE_|IA1PR12MB8555:EE_
X-MS-Office365-Filtering-Correlation-Id: f4f50b24-9784-41b5-bd1c-08dd30c7c16e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tCaYhgI44BCg0Rcc098fk+Jm4gfBNiPSz/JThUusngPzDu8PXVVDR4UvzM61?=
 =?us-ascii?Q?CGFda/QzyjKI2XC4KkOUxChNtekl8ecvIYK7ah6VD6jvE9ZAJu4iq7BA3Umy?=
 =?us-ascii?Q?sIQknjx4ir2OrEjysCIXQRP5NkMC4k+AysRpQoL7WWe1nWlfd/QG+Ql2btVi?=
 =?us-ascii?Q?yjFG89syAMmv7/gsJoe3ouLE8Xa3WgIvY+Anl/sQt9+dXwBeCuikLBKDro6h?=
 =?us-ascii?Q?bKvhhPHtD5FCqP1+iHpho19hEBtLVdRKWds8OxMp6HCmCxRMBrGrzOPvgj1l?=
 =?us-ascii?Q?zzsX8FTq4vPS7pHHNEka7GcxBuuKtF9W4v7KIrot+ssnpeHUnOK9/DcNotxt?=
 =?us-ascii?Q?uQ9pbJGD8U9PLJBaneDN5MHqq0LyXqyoI8KCxYKZOIyIiNirn+ggIKwhYovf?=
 =?us-ascii?Q?6gMju+PZDA40No3TeXAf6liPuTkupn14SJzba8BfxMtCUuoIfyAwPMeJJxN3?=
 =?us-ascii?Q?mG4dPNJvPpkHvlUZxG5jchkMZl/4rTUP2Xc2N3Dgy5eWJGokM/2LdH7mQblv?=
 =?us-ascii?Q?6NmtH4jEwGOb7Y1/zjSATksdvIm2bUIyQ3ueIKgf4DLw+a1ZfPvCSNCj7Cnh?=
 =?us-ascii?Q?nOQOBEDslsFQ2sLU7yiqi2axG3rkhu0P7TX/IjP9LOtMhJo2rrZNJiG7fGHI?=
 =?us-ascii?Q?ruLru0aMpet+6/eJvgv0DGagnnxeohCgLIyX7ij1Lbr62Nf9AwEWpZgXbGu+?=
 =?us-ascii?Q?c0o/rnLdvj2Vl4k53fkaDZB3h6VxKeCVyW12Jk4YlGRp0R5B56PSusEWazc8?=
 =?us-ascii?Q?nNOZlsYY24ADDqe4sO4JuhIWKMzbHiHTrcMO27mcmTp5BshkGGhq/i8ZAm/V?=
 =?us-ascii?Q?T25oUh9i5r68txjdb6Cljyk1Q3QLEsEw1Vd/z3yUfuF7lFqzLvC+z08tO8uw?=
 =?us-ascii?Q?aUuIxpwzvcY0eXRgGwfoOGyTqBZ4vfkjqUOz8eD7EPHdxYNt3A4mky0Gasmk?=
 =?us-ascii?Q?vx3hn3PogebsgDRKuloRP4q8EIc7/hRWa2lNrXbTGb97z3SJ2nNVYNEek/2n?=
 =?us-ascii?Q?O0c3aQ7xymlWNe06AjqL5JKTFlYuFYGvEytN8BBJlATJn80VjGuDkbwJlbHr?=
 =?us-ascii?Q?7sdwSZlI3kj7K+Fl8XFOTrgY5L9GNR90H6RjFyIWilfAd9/lZ/EXaVjsagRK?=
 =?us-ascii?Q?MP7Ox4HqePiOaGY/HX0UDbTSJaG2IHWcH8y+75J0sjty72ayO0ypRXPkhPgj?=
 =?us-ascii?Q?20NUwZC2zmv9j1nv09CQtKMaQWAOy0KXMKhUn+YI5MOyGz/WhVxu4jRJc4Kp?=
 =?us-ascii?Q?cuGU7axNJCNi+Al/St+3cHOFTkaT4XE58+tldjRwzlBn6T/8wfqHqtA64Tk+?=
 =?us-ascii?Q?8kDNV7tXsT5EXz0RIImPQ7+U5mkdR4PfRJl25HjtvPbyTpGh9muemivW0fSM?=
 =?us-ascii?Q?dg6BeUQtqoh2AUwSi89sK6wAKpnbTROySEoyKkEsTej2dxGcmbBc4K1SMx74?=
 =?us-ascii?Q?xyLh4m3RkKDLSSa7Hi6d/v1O6k+IJEXxPfPLjabvVCp6BmRVpv6CfRj+S+h3?=
 =?us-ascii?Q?kWdhJzB/dZUOgWM=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 16:07:45.6801
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f4f50b24-9784-41b5-bd1c-08dd30c7c16e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8555

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
 .../mellanox/mlx5/core/steering/hws/fs_hws.c  | 549 ++++++++++++++++++
 .../mellanox/mlx5/core/steering/hws/fs_hws.h  |  13 +
 3 files changed, 566 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h
index 1c5d687f45f0..20837e526679 100644
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
index 7146cdd791fc..6a552b3b6e16 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
@@ -360,6 +360,552 @@ static int mlx5_cmd_hws_destroy_flow_group(struct mlx5_flow_root_namespace *ns,
 	return mlx5hws_bwc_matcher_destroy(fg->fs_hws_matcher.matcher);
 }
 
+static struct mlx5hws_action *
+mlx5_fs_get_dest_action_ft(struct mlx5_fs_hws_context *fs_ctx,
+			   struct mlx5_flow_rule *dst)
+{
+	return xa_load(&fs_ctx->hws_pool.table_dests, dst->dest_attr.ft->id);
+}
+
+static struct mlx5hws_action *
+mlx5_fs_get_dest_action_table_num(struct mlx5_fs_hws_context *fs_ctx,
+				  struct mlx5_flow_rule *dst)
+{
+	u32 table_num = dst->dest_attr.ft_num;
+
+	return xa_load(&fs_ctx->hws_pool.table_dests, table_num);
+}
+
+static struct mlx5hws_action *
+mlx5_fs_create_dest_action_table_num(struct mlx5_fs_hws_context *fs_ctx,
+				     struct mlx5_flow_rule *dst)
+{
+	u32 flags = MLX5HWS_ACTION_FLAG_HWS_FDB | MLX5HWS_ACTION_FLAG_SHARED;
+	struct mlx5hws_context *ctx = fs_ctx->hws_ctx;
+	u32 table_num = dst->dest_attr.ft_num;
+
+	return mlx5hws_action_create_dest_table_num(ctx, table_num, flags);
+}
+
+static struct mlx5hws_action *
+mlx5_fs_create_dest_action_range(struct mlx5hws_context *ctx,
+				 struct mlx5_flow_rule *dst)
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
+mlx5_fs_create_action_dest_array(struct mlx5hws_context *ctx,
+				 struct mlx5hws_action_dest_attr *dests,
+				 u32 num_of_dests, bool ignore_flow_level,
+				 u32 flow_source)
+{
+	u32 flags = MLX5HWS_ACTION_FLAG_HWS_FDB | MLX5HWS_ACTION_FLAG_SHARED;
+
+	return mlx5hws_action_create_dest_array(ctx, num_of_dests, dests,
+						ignore_flow_level,
+						flow_source, flags);
+}
+
+static struct mlx5hws_action *
+mlx5_fs_get_action_push_vlan(struct mlx5_fs_hws_context *fs_ctx)
+{
+	return fs_ctx->hws_pool.push_vlan_action;
+}
+
+static u32 mlx5_fs_calc_vlan_hdr(struct mlx5_fs_vlan *vlan)
+{
+	u16 n_ethtype = vlan->ethtype;
+	u8 prio = vlan->prio;
+	u16 vid = vlan->vid;
+
+	return (u32)n_ethtype << 16 | (u32)(prio) << 12 | (u32)vid;
+}
+
+static struct mlx5hws_action *
+mlx5_fs_get_action_pop_vlan(struct mlx5_fs_hws_context *fs_ctx)
+{
+	return fs_ctx->hws_pool.pop_vlan_action;
+}
+
+static struct mlx5hws_action *
+mlx5_fs_get_action_decap_tnl_l2_to_l2(struct mlx5_fs_hws_context *fs_ctx)
+{
+	return fs_ctx->hws_pool.decapl2_action;
+}
+
+static struct mlx5hws_action *
+mlx5_fs_get_dest_action_drop(struct mlx5_fs_hws_context *fs_ctx)
+{
+	return fs_ctx->hws_pool.drop_action;
+}
+
+static struct mlx5hws_action *
+mlx5_fs_get_action_tag(struct mlx5_fs_hws_context *fs_ctx)
+{
+	return fs_ctx->hws_pool.tag_action;
+}
+
+static struct mlx5hws_action *
+mlx5_fs_create_action_last(struct mlx5hws_context *ctx)
+{
+	u32 flags = MLX5HWS_ACTION_FLAG_HWS_FDB | MLX5HWS_ACTION_FLAG_SHARED;
+
+	return mlx5hws_action_create_last(ctx, flags);
+}
+
+static void mlx5_fs_destroy_fs_action(struct mlx5_fs_hws_rule_action *fs_action)
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
+static void
+mlx5_fs_destroy_fs_actions(struct mlx5_fs_hws_rule_action **fs_actions,
+			   int *num_fs_actions)
+{
+	int i;
+
+	/* Free in reverse order to handle action dependencies */
+	for (i = *num_fs_actions - 1; i >= 0; i--)
+		mlx5_fs_destroy_fs_action(*fs_actions + i);
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
+static int mlx5_fs_fte_get_hws_actions(struct mlx5_flow_root_namespace *ns,
+				       struct mlx5_flow_table *ft,
+				       struct mlx5_flow_group *group,
+				       struct fs_fte *fte,
+				       struct mlx5hws_rule_action **ractions)
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
+		tmp_action = mlx5_fs_get_action_decap_tnl_l2_to_l2(fs_ctx);
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
+		tmp_action = mlx5_fs_get_action_pop_vlan(fs_ctx);
+		if (!tmp_action) {
+			err = -ENOMEM;
+			goto free_actions;
+		}
+		(*ractions)[num_actions++].action = tmp_action;
+	}
+
+	if (fte_action->action & MLX5_FLOW_CONTEXT_ACTION_VLAN_POP_2) {
+		tmp_action = mlx5_fs_get_action_pop_vlan(fs_ctx);
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
+		tmp_action = mlx5_fs_get_action_push_vlan(fs_ctx);
+		if (!tmp_action) {
+			err = -ENOMEM;
+			goto free_actions;
+		}
+		(*ractions)[num_actions].push_vlan.vlan_hdr =
+			htonl(mlx5_fs_calc_vlan_hdr(&fte_action->vlan[0]));
+		(*ractions)[num_actions++].action = tmp_action;
+	}
+
+	if (fte_action->action & MLX5_FLOW_CONTEXT_ACTION_VLAN_PUSH_2) {
+		tmp_action = mlx5_fs_get_action_push_vlan(fs_ctx);
+		if (!tmp_action) {
+			err = -ENOMEM;
+			goto free_actions;
+		}
+		(*ractions)[num_actions].push_vlan.vlan_hdr =
+			htonl(mlx5_fs_calc_vlan_hdr(&fte_action->vlan[1]));
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
+		tmp_action = mlx5_fs_get_action_tag(fs_ctx);
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
+		dest_action = mlx5_fs_get_dest_action_drop(fs_ctx);
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
+				dest_action = mlx5_fs_get_dest_action_ft(fs_ctx, dst);
+				break;
+			case MLX5_FLOW_DESTINATION_TYPE_FLOW_TABLE_NUM:
+				dest_action = mlx5_fs_get_dest_action_table_num(fs_ctx,
+										dst);
+				if (dest_action)
+					break;
+				dest_action = mlx5_fs_create_dest_action_table_num(fs_ctx,
+										   dst);
+				fs_actions[num_fs_actions++].action = dest_action;
+				break;
+			case MLX5_FLOW_DESTINATION_TYPE_RANGE:
+				dest_action = mlx5_fs_create_dest_action_range(ctx, dst);
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
+		u32 flow_source = fte->act_dests.flow_context.flow_source;
+		bool ignore_flow_level;
+
+		if (num_actions == MLX5_FLOW_CONTEXT_ACTION_MAX ||
+		    num_fs_actions == MLX5_FLOW_CONTEXT_ACTION_MAX) {
+			err = -EOPNOTSUPP;
+			goto free_actions;
+		}
+		ignore_flow_level =
+			!!(fte_action->flags & FLOW_ACT_IGNORE_FLOW_LEVEL);
+		tmp_action = mlx5_fs_create_action_dest_array(ctx, dest_actions,
+							      num_dest_actions,
+							      ignore_flow_level,
+							      flow_source);
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
+	tmp_action = mlx5_fs_create_action_last(ctx);
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
+	mlx5_fs_destroy_fs_actions(&fs_actions, &num_fs_actions);
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
+	err = mlx5_fs_fte_get_hws_actions(ns, ft, group, fte, &ractions);
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
+	mlx5_fs_destroy_fs_actions(&fte->fs_hws_rule.hws_fs_actions,
+				   &fte->fs_hws_rule.num_fs_actions);
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
+	mlx5_fs_destroy_fs_actions(&rule->hws_fs_actions, &rule->num_fs_actions);
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
+	ret = mlx5_fs_fte_get_hws_actions(ns, ft, group, fte, &ractions);
+	if (ret)
+		return ret;
+
+	ret = mlx5hws_bwc_rule_action_update(fte->fs_hws_rule.bwc_rule, ractions);
+	kfree(ractions);
+	if (ret)
+		goto restore_actions;
+
+	mlx5_fs_destroy_fs_actions(&saved_hws_fs_actions, &saved_num_fs_actions);
+	return ret;
+
+restore_actions:
+	mlx5_fs_destroy_fs_actions(&fte->fs_hws_rule.hws_fs_actions,
+				   &fte->fs_hws_rule.num_fs_actions);
+	fte->fs_hws_rule.hws_fs_actions = saved_hws_fs_actions;
+	fte->fs_hws_rule.num_fs_actions = saved_num_fs_actions;
+	return ret;
+}
+
 static struct mlx5hws_action *
 mlx5_fs_create_action_remove_header_vlan(struct mlx5hws_context *ctx)
 {
@@ -719,6 +1265,9 @@ static const struct mlx5_flow_cmds mlx5_flow_cmds_hws = {
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
index 205d8d71e7d9..d3f0c2f5026a 100644
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


