Return-Path: <netdev+bounces-156761-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 371F4A07CDE
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 17:07:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BBEF5188C751
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 16:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC1421E091;
	Thu,  9 Jan 2025 16:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FgMT43Vp"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B8021E088
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 16:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736438850; cv=fail; b=kxHvjhcvfdnURTSjabpmymUn3Obh3/0yvR5uGH+aBBPkZ2xZgKWTb7VYNGeZRj1xq+C78bzFGFr1iAIKBSR6N8EokRI3Om/vS5U/6G6A3rq0QyVIf5MxUARfnEeOSkqu1+qgMzfkra2Nq9+LSlrSqzBt0jZ0j75J+toIGAVxyp4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736438850; c=relaxed/simple;
	bh=FvrwwIz5NI6vE1z9UcHM2vW7RUhOrBlStJm7Uy/2xxs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OfOd6GApMr5O/H7IMxoh8EORiQlJKnX6OaMsBekroXIBPbPnF4kmQHZeUOz0auq2BUZ2jjj4USyizq7+2bPQAQHfpoEBkgFRV3Z7fkHCh9e4AS7ClIyh20MOYruN0wK0/WmLSVLwfEF9XmjWVXxKpHSeRKURUYMDQ9JEy7aT/qY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FgMT43Vp; arc=fail smtp.client-ip=40.107.220.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pfmRz66/xw0ya00+J88JvJw31/WfhLnJ8zr2DlhupmCyIrAQvY296QzFBBcRgqQNWtKUdiEYDMo9hdoAxM71EZDZUG9svoKglZSx49BVDpdKB0H85YrdY6cRvGl0D3nz71pIqlaUU3ZefA0jXV00JwV5js+GKwbwXFXXuq4ta1tT9rcI3jZxuFQrvuy1pX/7aJ6PVd0SKdYKVasRM4msKXJgtE5qrRi6FdDM3tYG8Ice4Sp4EjR8h+gh3v5lHOKp9pvnHjSUwcDqSo62wqEG6WfytQMBTr2LdVehIeLwrqylBJA7+xSxYkyczw1G1PNUcdCfqolEFOLzLZimWlxDVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hOhWIps7jFz+Jl/EudXdDn8R+AHJlKvdzoV1TqhRCFQ=;
 b=v8AI2dmYEQuhBKGU0GwlnpgkT9yZrZMovgzNUU55zk46Il9ysuEkPL8jeIVesW0K6ovC8iQ1+c8vzOGLrqxzL+c3uYiAIR21z8AoHsh0VZGZpjc9MVOh2wmAKUYyAuOenHqcShdOiJOtwe8+KQQHSvYT/vL2Hn2sAZXBP17FfbXPG2oOaYQL+bSxkxnkciw6AJFk1L7PQZsxVKuG4GbWNVoS/CiezGi+ZojloONiDdFbnAOs3JU4dQbHMgWYOKBYaxHVaRHl4b2vwLHTER3PmtwtJW8rPkxl54zCfJBSwR9Ycw/tcWmmnlwPavqChvF//p6+y04FMje6sCUKfK03qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hOhWIps7jFz+Jl/EudXdDn8R+AHJlKvdzoV1TqhRCFQ=;
 b=FgMT43VpKX03aS3Uaf7q6bXy0VjPuLEpQN/m0fJlFXoXJZwHpVw3qfki+QP4hkvtCMc6TFdop4RtzuB5ppiMt0pNlF1U4KFqLjBObkKz0/f79l6t+NSoJBb6PRua3GWSt0inc+BxYSWsVQqmbLGUWd/gwgUTEMI+8V0n2TEYvUeGGSHRnI3De4useVpQEuQixRrgsR01QoULI+95UHi38cuIXA8irtPd4VMVqNxMfAt5CjdSvbbSE4gEndCNxOdVqSEaZnSp+xWFTjIN6rKnNjIk01qgC0FiyQ6Kkak40sqx4/2b+gsHK7e4qb+peANwFPjrN7hDrkwmaT35oHa/Uw==
Received: from DM6PR17CA0015.namprd17.prod.outlook.com (2603:10b6:5:1b3::28)
 by BL3PR12MB6476.namprd12.prod.outlook.com (2603:10b6:208:3bc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.12; Thu, 9 Jan
 2025 16:07:21 +0000
Received: from DS1PEPF0001708E.namprd03.prod.outlook.com
 (2603:10b6:5:1b3:cafe::27) by DM6PR17CA0015.outlook.office365.com
 (2603:10b6:5:1b3::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.12 via Frontend Transport; Thu,
 9 Jan 2025 16:07:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF0001708E.mail.protection.outlook.com (10.167.17.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.7 via Frontend Transport; Thu, 9 Jan 2025 16:07:21 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 9 Jan 2025
 08:07:07 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 9 Jan 2025
 08:07:06 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Thu, 9 Jan
 2025 08:07:03 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Yevgeny Kliteynik
	<kliteyn@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next V2 04/15] net/mlx5: fs, add HWS actions pool
Date: Thu, 9 Jan 2025 18:05:35 +0200
Message-ID: <20250109160546.1733647-5-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708E:EE_|BL3PR12MB6476:EE_
X-MS-Office365-Filtering-Correlation-Id: ee367a87-914c-4830-f171-08dd30c7b2df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bM57n5Y6WgAKm418NTP3NPs+Po+tzddvyXWLYX4l1PgcMWdhAz8udzGxAeCy?=
 =?us-ascii?Q?Ul5XTSfEVaY4EWViOS3cwG9bXBf7e6lPkcS3eXhR8kEN44PsVE0GtSUeEEW3?=
 =?us-ascii?Q?kHDf1rNXKEDUga3qFDSsqCH3PgwoPFloPkJUUHsVDJyOkL38lLse7evtPg9n?=
 =?us-ascii?Q?sYsTBWVT74Zka3DU8ha5eEwgdWq+ZAAFl2F8W0TMilAl9s2pmnOk+KUN1Hf7?=
 =?us-ascii?Q?nLB2T6sI6Cyk7SAqhE5k0RF5yJG3IcTSWR/wDdutKQXAklC90hYffDmWl1fq?=
 =?us-ascii?Q?mfEaN937GYfNugf1+v3ToCt5Xh1xNgk1QAe6WsDRnUOoivT2Z133oxPGqy+w?=
 =?us-ascii?Q?KWOOTkocnBcsFIkJIk9PBj8amkjsNB+OMxzr+EFCJlYe2SNO0E7tegGWktsP?=
 =?us-ascii?Q?FctB2h9DQ7otJMH4Wqmryyyo1hEITBKBfYkWwQnbDThlj18t9uUEieaJR052?=
 =?us-ascii?Q?6Ih6zDKS7HooPicIRV0/uhEk9E/6E3dRTmJU+iGrdseWSo/FuXpUlWrnRsJq?=
 =?us-ascii?Q?Ch3JY5Uu82MsTCxHWlDVbBkXyaF1ozc8DmLCS3pSrarBlGboPbVGaxFHieCo?=
 =?us-ascii?Q?nIjwEzH4141pJl4XSP4JsYShL9Je6y1CbzAi/bWiWz14kYZBfRsUCdjcXbiw?=
 =?us-ascii?Q?yfV5Z06uOiM5N0Ifx805hPgUUILIi3YmgAFzX5iLMf0Ig2byiBT13Zm6msAL?=
 =?us-ascii?Q?J0mMzt1T7FkpwasKBZ71BaM9AYO6R7IGMKvs0ubjNOCR2EldtCthHFNRKGlq?=
 =?us-ascii?Q?XLVAjRnZLKqf4XE7WBYjKFL8ezse2ByAivZjbmWUBvJDGP6FtRT1nMoOn8/Z?=
 =?us-ascii?Q?I7WPClz+bOo6+9B5Rq9msCYY+2CuPzhCtRS6g2Sh/hu0pj149fthSJYAxaro?=
 =?us-ascii?Q?ToE5lLHZ0e5toOxDHEF5Jdx2jX12xqNG7FjUAoV4qo3ks7EkdapEN1bdTvzU?=
 =?us-ascii?Q?xNwhhH75x5iThFtaUeG7zExae4Ayjo04k707lsF4l1cszCsepvKhKbkrGKcc?=
 =?us-ascii?Q?xUn/k+BDsID/yj+9g1zp2ZbIaeF3k0Sy0MKzsmKDniN/KbJKw2WxZfwSSSIj?=
 =?us-ascii?Q?Ss8o37oXuLQmXQDdBJTrCDiqJa2NYAOLj/vY9Ekf7I0kqFaArWY/VbSScXSJ?=
 =?us-ascii?Q?53daxt1qTU3Q0e42XJoSIviO1BYcB6RimPBLoLki3HeirtU3NfMQJ0FdGl20?=
 =?us-ascii?Q?039gmVWJ2tcQiLOH9Tpp8tUQSzyLsclSiQ2h2AGa1fSg26RyUECwMBGx/ZP5?=
 =?us-ascii?Q?eYjwC7TYTU8KMHoK3D+RB8xehROfufDU1MrGHvvi/CNGeGA0nzYurYA1eHCO?=
 =?us-ascii?Q?ayVVnvrgrCxDAu+Ue7xfR+27u2YQN6pfKYcobpJgTFlCkZNCL0MvQxJvi2ne?=
 =?us-ascii?Q?+Md050klN0NFHjw5yDGN30a+GLaxiefDUKwKnr/vIINNVt86DXzisCxH+iSf?=
 =?us-ascii?Q?DvF4amBmWTIy7Ld6qRq70CVC9bLmB4XWGbRUwUw2x+QIcJ+DRZLFiPOXocuC?=
 =?us-ascii?Q?Z1XjJwsECstOaMU=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 16:07:21.2718
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee367a87-914c-4830-f171-08dd30c7b2df
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001708E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6476

From: Moshe Shemesh <moshe@nvidia.com>

The HW Steering actions pool will help utilize the option in HW Steering
to share steering actions among different rules.

Create pool on root namespace creation and add few HW Steering actions
that don't depend on the steering rule itself and thus can be shared
between rules, created on same namespace: tag, pop_vlan, push_vlan,
drop, decap l2.

Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/steering/hws/fs_hws.c  | 58 +++++++++++++++++++
 .../mellanox/mlx5/core/steering/hws/fs_hws.h  |  9 +++
 2 files changed, 67 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
index f0cbc9996456..5987710f8706 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
@@ -9,9 +9,60 @@
 #define MLX5HWS_CTX_MAX_NUM_OF_QUEUES 16
 #define MLX5HWS_CTX_QUEUE_SIZE 256
 
+static int mlx5_fs_init_hws_actions_pool(struct mlx5_fs_hws_context *fs_ctx)
+{
+	u32 flags = MLX5HWS_ACTION_FLAG_HWS_FDB | MLX5HWS_ACTION_FLAG_SHARED;
+	struct mlx5_fs_hws_actions_pool *hws_pool = &fs_ctx->hws_pool;
+	struct mlx5hws_action_reformat_header reformat_hdr = {};
+	struct mlx5hws_context *ctx = fs_ctx->hws_ctx;
+	enum mlx5hws_action_type action_type;
+
+	hws_pool->tag_action = mlx5hws_action_create_tag(ctx, flags);
+	if (!hws_pool->tag_action)
+		return -ENOSPC;
+	hws_pool->pop_vlan_action = mlx5hws_action_create_pop_vlan(ctx, flags);
+	if (!hws_pool->pop_vlan_action)
+		goto destroy_tag;
+	hws_pool->push_vlan_action = mlx5hws_action_create_push_vlan(ctx, flags);
+	if (!hws_pool->push_vlan_action)
+		goto destroy_pop_vlan;
+	hws_pool->drop_action = mlx5hws_action_create_dest_drop(ctx, flags);
+	if (!hws_pool->drop_action)
+		goto destroy_push_vlan;
+	action_type = MLX5HWS_ACTION_TYP_REFORMAT_TNL_L2_TO_L2;
+	hws_pool->decapl2_action =
+		mlx5hws_action_create_reformat(ctx, action_type, 1,
+					       &reformat_hdr, 0, flags);
+	if (!hws_pool->decapl2_action)
+		goto destroy_drop;
+	return 0;
+
+destroy_drop:
+	mlx5hws_action_destroy(hws_pool->drop_action);
+destroy_push_vlan:
+	mlx5hws_action_destroy(hws_pool->push_vlan_action);
+destroy_pop_vlan:
+	mlx5hws_action_destroy(hws_pool->pop_vlan_action);
+destroy_tag:
+	mlx5hws_action_destroy(hws_pool->tag_action);
+	return -ENOSPC;
+}
+
+static void mlx5_fs_cleanup_hws_actions_pool(struct mlx5_fs_hws_context *fs_ctx)
+{
+	struct mlx5_fs_hws_actions_pool *hws_pool = &fs_ctx->hws_pool;
+
+	mlx5hws_action_destroy(hws_pool->decapl2_action);
+	mlx5hws_action_destroy(hws_pool->drop_action);
+	mlx5hws_action_destroy(hws_pool->push_vlan_action);
+	mlx5hws_action_destroy(hws_pool->pop_vlan_action);
+	mlx5hws_action_destroy(hws_pool->tag_action);
+}
+
 static int mlx5_cmd_hws_create_ns(struct mlx5_flow_root_namespace *ns)
 {
 	struct mlx5hws_context_attr hws_ctx_attr = {};
+	int err;
 
 	hws_ctx_attr.queues = min_t(int, num_online_cpus(),
 				    MLX5HWS_CTX_MAX_NUM_OF_QUEUES);
@@ -23,11 +74,18 @@ static int mlx5_cmd_hws_create_ns(struct mlx5_flow_root_namespace *ns)
 		mlx5_core_err(ns->dev, "Failed to create hws flow namespace\n");
 		return -EINVAL;
 	}
+	err = mlx5_fs_init_hws_actions_pool(&ns->fs_hws_context);
+	if (err) {
+		mlx5_core_err(ns->dev, "Failed to init hws actions pool\n");
+		mlx5hws_context_close(ns->fs_hws_context.hws_ctx);
+		return err;
+	}
 	return 0;
 }
 
 static int mlx5_cmd_hws_destroy_ns(struct mlx5_flow_root_namespace *ns)
 {
+	mlx5_fs_cleanup_hws_actions_pool(&ns->fs_hws_context);
 	return mlx5hws_context_close(ns->fs_hws_context.hws_ctx);
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.h
index a54b426d99b2..a2580b39d728 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.h
@@ -6,8 +6,17 @@
 
 #include "mlx5hws.h"
 
+struct mlx5_fs_hws_actions_pool {
+	struct mlx5hws_action *tag_action;
+	struct mlx5hws_action *pop_vlan_action;
+	struct mlx5hws_action *push_vlan_action;
+	struct mlx5hws_action *drop_action;
+	struct mlx5hws_action *decapl2_action;
+};
+
 struct mlx5_fs_hws_context {
 	struct mlx5hws_context	*hws_ctx;
+	struct mlx5_fs_hws_actions_pool hws_pool;
 };
 
 struct mlx5_fs_hws_table {
-- 
2.45.0


