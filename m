Return-Path: <netdev+bounces-156760-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5325CA07CDF
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 17:07:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9DF90162EF6
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 16:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF0121E088;
	Thu,  9 Jan 2025 16:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Cd/6v3LK"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E33F21D5BF
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 16:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736438844; cv=fail; b=c+lKsUT9JdOuh+PMCg7fGtq3KWZYVqM9CKuZN7dfWpHIDKwIFz3HHkqC+wKd4/fNNn1J70D6SQkXWg6JPUGRburexisfohbtaQt3aYYEASYqaUq/CFIn0JUvRzy91SFZ/ogaKs29PbS9ZwJyULKmg4A3DEGBXaHl/tR0zxJQU48=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736438844; c=relaxed/simple;
	bh=O3K584dXHepjG+q3jsNvtZt1evuomqASdzD9WgwtgoY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dP41EnvmKfHG7Qqcp9sI2stP0xGYSh3EdUIrIhYlkp6y4Nv552ohF4Y+W5rz88BKfiVsIxIT0jl41LXkUf7Hv3AffyeOS9xyWLjMV5/b02hrKt5Ai0TgVJTDRlYIDq8LcM0j6O7T69VS8adynXLjG6xHiveVzNMSdl8zK2K3dO0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Cd/6v3LK; arc=fail smtp.client-ip=40.107.92.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VfYQTmyVw4aZG9NxTb8VApy2Heg2zHkXWPzGXpdi/1I+ytt4bI9bwhRcex1Bfp1SvT1EswFa2FgqE76DGF7y/aFNrM5khqSGoqgkejSPc7h8W73Jl9v7Z7F4lW1IwiK39TBeevCnYRceu7PW3DPRuhwIgeH3casRUPYYR3i3yKJjfC5dVgmBf9Cs/Bvz+szJWHHHiYZ7ruQlkcS+8lRH5UEYhY9LeZVvhOaE/PmcSKefj8zmEhdsGvL0P6kyEWHNKS2cWq7nDwue+VS8M/MiWteGCu3DO9SKZmPbF4++pevmtFePdNQ+0HDPXCNTL7aKM6/86QV30MD0GZyrmrJXeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2vJyC8MDYuklGJnS9da83DTyYxUzvtohEmvaFv/Pm1Y=;
 b=uc9uRB45By/fynaL7fV+aWwP2bayX83o4nschi/3oVyzAO0C337O/cA1500hG81HpTMxORG7MexQKUZ7lHHu/gWJXmmgzEvqa28+4xO6xnEIaoyPOlCc0aBhkKut23P0piXii7sKGDWABLRoI7IpMwn/OgbvEEau7FKgXduW8ZWKRUkArSGfiJQE1+7N8phcr/DWaxECyQIjWdbN8uohv/eVj23V8B+EAMT7Mz/MaFAWCw8RH3OpYPITWWCQTpUZ+NQfLjojRGs5YdEykcbJtttdEGlZz7VyTkXKi5WrIsF02hEdCrbe6YYbAjZSfZ6Ks+/EngFJrMJZHyxRlMCqqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2vJyC8MDYuklGJnS9da83DTyYxUzvtohEmvaFv/Pm1Y=;
 b=Cd/6v3LKJ/Vya9MwnPgPRPvdfD9jecrqv6y3eZ2tRUwTWfqFZv23m22C2aamEfC9yVAhajRR/gM44Efk+MfVeybVy3oqNvsBx7oLmPbMXUm/WCXRgi5tta9ohprIJB0eObhR9v2UMIYpYi/Ti+d2GpN/NSSBBOYdIf5cKQHJ69cYzuEoXM3hwGPjsysAfKK7Qn3zUCq6IuzgC+/57xam0TQuT3cTU50yPie0sL22kYW56EAW+qtNAOAa5jvnHjA2d8bg8l52wKbENrVa36P8UwP/GSg/fzno70M7rF1jtm1uOJfTMWmQ5wT/TXRdHOGFzG4ArEfKMfrG03cTWG9dyQ==
Received: from DM6PR07CA0124.namprd07.prod.outlook.com (2603:10b6:5:330::34)
 by PH8PR12MB7157.namprd12.prod.outlook.com (2603:10b6:510:22b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.18; Thu, 9 Jan
 2025 16:07:14 +0000
Received: from DS1PEPF00017090.namprd03.prod.outlook.com
 (2603:10b6:5:330:cafe::99) by DM6PR07CA0124.outlook.office365.com
 (2603:10b6:5:330::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.13 via Frontend Transport; Thu,
 9 Jan 2025 16:07:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF00017090.mail.protection.outlook.com (10.167.17.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.7 via Frontend Transport; Thu, 9 Jan 2025 16:07:13 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 9 Jan 2025
 08:06:59 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 9 Jan 2025
 08:06:59 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Thu, 9 Jan
 2025 08:06:56 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Yevgeny Kliteynik
	<kliteyn@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next V2 02/15] net/mlx5: fs, add HWS flow table API functions
Date: Thu, 9 Jan 2025 18:05:33 +0200
Message-ID: <20250109160546.1733647-3-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017090:EE_|PH8PR12MB7157:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a01b405-0299-4a34-02da-08dd30c7ae71
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lPa+XAFaDU3P+owwaESv2Ikzu8nYLBsgOZQ5rTkfuIJEOsrqY6MmJ1uLNkmm?=
 =?us-ascii?Q?9n50oBAFc7NvOh6KBn0pLqay7XK3gkrx9W6EaMJj99ACB5do9BcivUu89HF/?=
 =?us-ascii?Q?+ZSnUmEUhC6XTnhQPiBdr/dxtefvDTx53OFJtg1BVNxrlckBW4/IVygLpZP5?=
 =?us-ascii?Q?ZBLRQhHL8LyZyogbUJu+gqz9pZm8KWVlt/RgtA4xQJN4Ifd5cCUFFz8i5mLA?=
 =?us-ascii?Q?V2jjQ4KV+8ZP9xj/3Kjv3V+DKGI7YON1OSHSauDo4g6Vx6exK/747UcEMwwj?=
 =?us-ascii?Q?DzAWfWYDwU2+ZtkMG6IugA2CYktwFDZTdud6gX94GtxHoTHXZPZ7Dayb72kL?=
 =?us-ascii?Q?K8ZobXFBDAlO89sP4qT+GRuV06o2ptKEvSOJ64DQ6Ceb/uSA8K6XJZUDeP9U?=
 =?us-ascii?Q?AQ9XdWieOEsJXnzjApHyKXyDzfn3oZ1fJkAOULr0NnZQhIBgzVupDIiBXvrA?=
 =?us-ascii?Q?aqa//lxFmXRZSkvaIG1j8Mexrvx90+xJkpM/e7TpXV0i1gFoIQWoVkfjHQFe?=
 =?us-ascii?Q?+oV0RuNPbvJrzfD24rAVy/EwAfpyH75zO43fflazMC+zCkO8IGI2KR4xucpL?=
 =?us-ascii?Q?65bOPWpJC6ZDJ983x+PTvCMFeI/lbWHOMfvX7aZQ6fGNfZrw14EM5xhYaRQV?=
 =?us-ascii?Q?PZhzqRXCe6SKNZm+uVwEXMx+YR/ER+S2F7tm8lCJeZVKj2RhwwNv9l73e8TY?=
 =?us-ascii?Q?meyBP8lZ7fSRJSWiyCUHpf+1/EpFVqEYcMkO1YIYIgN1WcMVY5A4eWjpWLRB?=
 =?us-ascii?Q?W06hnOFDLWF3Ek2lbMR6CMbMigLURHdWVFFvolmCkFZ6oN0q82cJJMse+s2K?=
 =?us-ascii?Q?z7/T6XTGFvy1UV3sZymoGvclamUZhB9RG8nA3SmNNRUio56Xf8Fvwv3nAxEL?=
 =?us-ascii?Q?0p5bSpsAEk2diUyTlo0GEu32jvfPsklUspzS4klXPLm4tZcVCrv3nz0MHyav?=
 =?us-ascii?Q?n4YyBxMpEX3W7Jdtk1Y8rwza8UwCUWdRZ1R/v+wXmZXDJcNnCoBHZzcgajAS?=
 =?us-ascii?Q?HFCrrViF57G24aFHlGw13ox+fBvUJP7fh/hGRyzTmOOS7YlnSPpEb9zT9HRG?=
 =?us-ascii?Q?QvayBuVO0uBgfhkCOSyq1hSP5McN7XwasWSt0J68Fx7CnhE++2/9R9Qey40R?=
 =?us-ascii?Q?TqLyYtsUVmKNhn6/AIW2Y0ONWytkaW9o3Hv+XqP874x0PJtdvhG03q7RYAFU?=
 =?us-ascii?Q?pPGrweQXFh9mfX/dbgfb47D2fO0j1Mwau0qkbuCl55RpGQn0EWfjBsHhXiHX?=
 =?us-ascii?Q?EZmfDutV4a25mgy2yuslT5c1cYiERlLLTyLAfRQWqoCPglwEslZ1h/vJDzKE?=
 =?us-ascii?Q?KGwkkx8dnUJ9YjvKvM0woYt6atGB79gACp8lt3h6zhKH8ls9GKGcqQNsSyU4?=
 =?us-ascii?Q?qx0e7fXRxEdR9iZCvNZHjj/T0hZd6GUmEZb0Vr2Ta1P6Hy6FpQzm8KtR4oJK?=
 =?us-ascii?Q?7TIWZsfnKROyyUZQb15SaXxTNKVBnVcL7sA8vpRlxrW/oV9F2+9hzWfK2JGS?=
 =?us-ascii?Q?JUmJwYVh6pTHqtg=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 16:07:13.8183
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a01b405-0299-4a34-02da-08dd30c7ae71
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017090.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7157

From: Moshe Shemesh <moshe@nvidia.com>

Add API functions to create, modify and destroy HW Steering flow tables.
Modify table enables change, connect or disconnect default miss table.
Add update root flow table API function.

Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/fs_core.h |   5 +-
 .../mellanox/mlx5/core/steering/hws/fs_hws.c  | 113 ++++++++++++++++++
 .../mellanox/mlx5/core/steering/hws/fs_hws.h  |   5 +
 3 files changed, 122 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h
index d309906d1106..7fd480a2570d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h
@@ -192,7 +192,10 @@ struct mlx5_flow_handle {
 /* Type of children is mlx5_flow_group */
 struct mlx5_flow_table {
 	struct fs_node			node;
-	struct mlx5_fs_dr_table		fs_dr_table;
+	union {
+		struct mlx5_fs_dr_table		fs_dr_table;
+		struct mlx5_fs_hws_table	fs_hws_table;
+	};
 	u32				id;
 	u16				vport;
 	unsigned int			max_fte;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
index ac61f96af1c3..57d88088e18b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
@@ -44,7 +44,120 @@ static int mlx5_cmd_hws_set_peer(struct mlx5_flow_root_namespace *ns,
 	return 0;
 }
 
+static int mlx5_fs_set_ft_default_miss(struct mlx5_flow_root_namespace *ns,
+				       struct mlx5_flow_table *ft,
+				       struct mlx5_flow_table *next_ft)
+{
+	struct mlx5hws_table *next_tbl;
+	int err;
+
+	if (!ns->fs_hws_context.hws_ctx)
+		return -EINVAL;
+
+	/* if no change required, return */
+	if (!next_ft && !ft->fs_hws_table.miss_ft_set)
+		return 0;
+
+	next_tbl = next_ft ? next_ft->fs_hws_table.hws_table : NULL;
+	err = mlx5hws_table_set_default_miss(ft->fs_hws_table.hws_table, next_tbl);
+	if (err) {
+		mlx5_core_err(ns->dev, "Failed setting FT default miss (%d)\n", err);
+		return err;
+	}
+	ft->fs_hws_table.miss_ft_set = !!next_tbl;
+	return 0;
+}
+
+static int mlx5_cmd_hws_create_flow_table(struct mlx5_flow_root_namespace *ns,
+					  struct mlx5_flow_table *ft,
+					  struct mlx5_flow_table_attr *ft_attr,
+					  struct mlx5_flow_table *next_ft)
+{
+	struct mlx5hws_context *ctx = ns->fs_hws_context.hws_ctx;
+	struct mlx5hws_table_attr tbl_attr = {};
+	struct mlx5hws_table *tbl;
+	int err;
+
+	if (mlx5_fs_cmd_is_fw_term_table(ft))
+		return mlx5_fs_cmd_get_fw_cmds()->create_flow_table(ns, ft, ft_attr,
+								    next_ft);
+
+	if (ns->table_type != FS_FT_FDB) {
+		mlx5_core_err(ns->dev, "Table type %d not supported for HWS\n",
+			      ns->table_type);
+		return -EOPNOTSUPP;
+	}
+
+	tbl_attr.type = MLX5HWS_TABLE_TYPE_FDB;
+	tbl_attr.level = ft_attr->level;
+	tbl = mlx5hws_table_create(ctx, &tbl_attr);
+	if (!tbl) {
+		mlx5_core_err(ns->dev, "Failed creating hws flow_table\n");
+		return -EINVAL;
+	}
+
+	ft->fs_hws_table.hws_table = tbl;
+	ft->id = mlx5hws_table_get_id(tbl);
+
+	if (next_ft) {
+		err = mlx5_fs_set_ft_default_miss(ns, ft, next_ft);
+		if (err)
+			goto destroy_table;
+	}
+
+	ft->max_fte = INT_MAX;
+
+	return 0;
+
+destroy_table:
+	mlx5hws_table_destroy(tbl);
+	ft->fs_hws_table.hws_table = NULL;
+	return err;
+}
+
+static int mlx5_cmd_hws_destroy_flow_table(struct mlx5_flow_root_namespace *ns,
+					   struct mlx5_flow_table *ft)
+{
+	int err;
+
+	if (mlx5_fs_cmd_is_fw_term_table(ft))
+		return mlx5_fs_cmd_get_fw_cmds()->destroy_flow_table(ns, ft);
+
+	err = mlx5_fs_set_ft_default_miss(ns, ft, NULL);
+	if (err)
+		mlx5_core_err(ns->dev, "Failed to disconnect next table (%d)\n", err);
+
+	err = mlx5hws_table_destroy(ft->fs_hws_table.hws_table);
+	if (err)
+		mlx5_core_err(ns->dev, "Failed to destroy flow_table (%d)\n", err);
+
+	return err;
+}
+
+static int mlx5_cmd_hws_modify_flow_table(struct mlx5_flow_root_namespace *ns,
+					  struct mlx5_flow_table *ft,
+					  struct mlx5_flow_table *next_ft)
+{
+	if (mlx5_fs_cmd_is_fw_term_table(ft))
+		return mlx5_fs_cmd_get_fw_cmds()->modify_flow_table(ns, ft, next_ft);
+
+	return mlx5_fs_set_ft_default_miss(ns, ft, next_ft);
+}
+
+static int mlx5_cmd_hws_update_root_ft(struct mlx5_flow_root_namespace *ns,
+				       struct mlx5_flow_table *ft,
+				       u32 underlay_qpn,
+				       bool disconnect)
+{
+	return mlx5_fs_cmd_get_fw_cmds()->update_root_ft(ns, ft, underlay_qpn,
+							 disconnect);
+}
+
 static const struct mlx5_flow_cmds mlx5_flow_cmds_hws = {
+	.create_flow_table = mlx5_cmd_hws_create_flow_table,
+	.destroy_flow_table = mlx5_cmd_hws_destroy_flow_table,
+	.modify_flow_table = mlx5_cmd_hws_modify_flow_table,
+	.update_root_ft = mlx5_cmd_hws_update_root_ft,
 	.create_ns = mlx5_cmd_hws_create_ns,
 	.destroy_ns = mlx5_cmd_hws_destroy_ns,
 	.set_peer = mlx5_cmd_hws_set_peer,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.h
index 17ac0d150253..c4af8d617b4d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.h
@@ -10,6 +10,11 @@ struct mlx5_fs_hws_context {
 	struct mlx5hws_context	*hws_ctx;
 };
 
+struct mlx5_fs_hws_table {
+	struct mlx5hws_table *hws_table;
+	bool miss_ft_set;
+};
+
 #ifdef CONFIG_MLX5_HW_STEERING
 
 const struct mlx5_flow_cmds *mlx5_fs_cmd_get_hws_cmds(void);
-- 
2.45.0


