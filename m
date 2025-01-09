Return-Path: <netdev+bounces-156763-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6215AA07CE1
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 17:07:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C9AC188CB35
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 16:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1190321E0B7;
	Thu,  9 Jan 2025 16:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="H0AtjI/O"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2069.outbound.protection.outlook.com [40.107.236.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC6722068A
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 16:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736438858; cv=fail; b=QOp+Djr0zyq/mYGmGuzu3OEgo7jqc9WxLPJksANEzWMOazljeAVEG5XnwozeUFHWDEOYTXR4mtr0M4j2J4uoVtWYtBS+4bRm5z82B66lwg8BdIm7HARVzkIC2zXMXOlWbNrEy8ZWrA7dg385OuoambXysVmPHAWeoVQU9kM6ZT8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736438858; c=relaxed/simple;
	bh=kobJeBQSU3joO2hSwNOawZA6vmqCSQw9NCTmeupEGtc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I5/bwgPaTjCJ842/35OzdAlmcTMw7wFpRFEZ/+wTlBtV4ErDCfrwusp2JrJI6lWI0tQkmR2bs1zkBDPxkrXK/4L/vk1H0q5iTOtD13WlfVFn75EcHSyHMvpH9JraAyOLkjCO1BVVAzJthF4J1iRtDwOC53sKIBTgDAHQvFLGZ8s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=H0AtjI/O; arc=fail smtp.client-ip=40.107.236.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h5JbLcw+traNfzvgT0AYUniifJjzYrGrJIwR1bersTYimjYvjWsoP+ivsfKZr3O2W5omKpa/9sUt/0nUCoEyRAYQKwOe/2bRhb27T0AuPv7Z+rMpIA9ukYfqkgWj7786qHZKsTOHy+JkYJMlMfnqhrYyxsLGsNHWneq4sMS34//HWGuL4HTCDbkECs2WAWEI7+5tgyyHQyY4L5BRNl9NGYMjhphzFof6rLBLi/YGLREVNgXbkxWJ1ykGKGWCvKt0RlMuR9laeAnqC1PiKDvteyahTyOM0/UtJwh9wrSpmCTFLGHA4CcGsORxa7JrfBo/KOiWnRZiud6kVEnqZF16sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fGv0b+r+N2AD4x+0l2ZLSy9bLq2wA9d1apA3Lx3XPZ0=;
 b=CMui79mkwXYsTCM8ZyCoXz/N+l8fdRfiAY5Hzb4ZU0yMvAhd3XLjnr0Z0VBaAipNueCZlN4eTq+klVYH7Ad2xToP2+eqn+DUjc2c8MXg0SHwJDwYcA+1EWGhfQfo8bJTgIn2La883vtZofiMI0Cj/q7xyvfQyHTFVyb7Y1JsYiiV/2+U3v7ONPf+qFQ+Ei1LK3nAwJ3KrUIOr6qr/yWnEI9smMumS5Ht89REp4GzB0rKma16XzcxjDu3vPur0YSH1CWeIVztsEHN1e8436wWR9F8PYUiTgmCQRPAyGwkY3ZkbCWVpyMeRJ2cijuFO7sz+TtkSKK59AIJ6uNzAxTv6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fGv0b+r+N2AD4x+0l2ZLSy9bLq2wA9d1apA3Lx3XPZ0=;
 b=H0AtjI/OvhKTGlm9Vt7TD4QOc42GtZ0ItmF/a74k1as1T+nhk15jRCaXSs40iTv0RtHk0zbFsIJOS/7FxRWun2xtd6SYYhtg3sn+OyJER3i9KrmY9kJ/4n1XX4N6X6A8L8d3FQ7nSl2XUbFgHNvAT9hlGjEjADGO8R2MstILsLOZKHuLwPBNk7f1B+M58ZWp3YVX8ny8+7OtOjmtZD6cvV83Vl+YMesK+nls2l/8/FfWV2khCJ2Cvu0kEgM9aMhpcAc25qrl+Imzjw3zMwuj6aNixDNJDMNxkVsTnD1/v9SQSBSinJGXgrnnmicM6oGYFaI33G38RVZCybEV7DBjvA==
Received: from DM5PR07CA0092.namprd07.prod.outlook.com (2603:10b6:4:ae::21) by
 PH8PR12MB7277.namprd12.prod.outlook.com (2603:10b6:510:223::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.12; Thu, 9 Jan
 2025 16:07:27 +0000
Received: from DS1PEPF0001708F.namprd03.prod.outlook.com
 (2603:10b6:4:ae:cafe::fd) by DM5PR07CA0092.outlook.office365.com
 (2603:10b6:4:ae::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.11 via Frontend Transport; Thu,
 9 Jan 2025 16:07:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF0001708F.mail.protection.outlook.com (10.167.17.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.7 via Frontend Transport; Thu, 9 Jan 2025 16:07:26 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 9 Jan 2025
 08:07:14 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 9 Jan 2025
 08:07:14 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Thu, 9 Jan
 2025 08:07:10 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Yevgeny Kliteynik
	<kliteyn@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next V2 06/15] net/mlx5: fs, add HWS modify header API function
Date: Thu, 9 Jan 2025 18:05:37 +0200
Message-ID: <20250109160546.1733647-7-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708F:EE_|PH8PR12MB7277:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c2c5873-60e8-466b-4abd-08dd30c7b62b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/Q2TV6gMAtZKKUX87713O+uqnaGxXxeGG0MGnoanZhH5Cnml0kV12+8vvKGL?=
 =?us-ascii?Q?4/gV/IHfenDuD0SAjMOrinGBFGQWKmxFvC8eVP46KcH8kgvf0otClHUWqipl?=
 =?us-ascii?Q?Gh/gcHILsR4+p8AAep5owYscSKhkfOrbSgFqTSc/bfJKxgVYAJz+ANVJ7UVW?=
 =?us-ascii?Q?8MUljHZ/1WuG6oMUz+jnHhql9ZDFd3kFbKAqHQCrNBhrf4Fo6rMvSe+LD5XR?=
 =?us-ascii?Q?XCNoiCo1E1xEWXgLzDPYHmMQOmrwINRgpzxaI0FEWaDwRlrHk8l2/uqAMqqm?=
 =?us-ascii?Q?ffx0gjpXVuirfHGxnANdAGWU8I+wFuybOOas9yTYkh06x4jO9fGKAg9D7eyY?=
 =?us-ascii?Q?VmHjtSS6h5s7T7Jpjz1fewuO+1k7vcyYOdbedb+dNeArEhIAcOjFML0vDBfj?=
 =?us-ascii?Q?rf2cDHFlAOD+loKX6mqRUz3P3MUobFA/CIpwXcudVCXFUHEqkSYhCbfA9NqU?=
 =?us-ascii?Q?cvUbx0f6/0Wt6YWqfdSvCyWeJljPO6xjveYfpRNMSYrWLc2xD72KFHkWHHQI?=
 =?us-ascii?Q?kyOFHfdNg2vz3baPRn3Algdq5w73MLqxAGllckDRYznckeSPIgvsvsUrNM0z?=
 =?us-ascii?Q?e64quvQ6yk6OtTE1snf9A0J/ItDz55IuROo6oXtU7kriuiUOq5OdNTET4NrN?=
 =?us-ascii?Q?xIjCNr1ednwFX5ojLRXIENk9antPSLqqRwDdwsrxfxZiitbIklKJRrNoR5Iz?=
 =?us-ascii?Q?NLMAiL5VKSg16DbosyuUNxXih4Hp/e2YE1OiSGrOw7TxVBkViy+TacpwFQa/?=
 =?us-ascii?Q?1ND/zY8Nr2EIHGDCD0cXrz5fvFy7JcYjVXha+34V12ItGatMP2f/6nPaIU8Z?=
 =?us-ascii?Q?yGcr2Xtvswokg6YbIGOaKmZKx8AcswAueRCeRUz5+/7248/YAqdrbJa+flUQ?=
 =?us-ascii?Q?w4oNvldZFV7h6jG3PgLH+6hqeqT6ZyjzDba4oTczcg8pxnLrShpMRncp960c?=
 =?us-ascii?Q?TBVZqZ+osHGcANDAWWeWZpBUuLVLelYqKYFbYATib4SgXePWfgtX6k0u52pG?=
 =?us-ascii?Q?KLAeDzngrunhnGNLQHXurIeSvYS2e6aNK6YzvXgPeh0okJxRko4Dvwn1otuu?=
 =?us-ascii?Q?Es8a8jcRHpOs+EyK7hp4em8mRWWUFOCS2HT5TwjoS/gVtnVJW+96vOuzlgND?=
 =?us-ascii?Q?CcAuTEL+8Cip50qRGWDcEOpBNksR5pM0j3jSM5MoJSACati0IP8zg7fPZGKl?=
 =?us-ascii?Q?itdi0nJGQnHyslfvaA1tdSUGm4Jp4SDyYvRFlPLan2isPPLaVwoU9UeUnRYe?=
 =?us-ascii?Q?gA5/vF1NWBvUljAG9+XInB0wlI0dhAkb/H2/XQ6nLU7m69qgBgte/n70Di8L?=
 =?us-ascii?Q?JRgubTtdg/5pvuL/ORYamjnP7WPWY1YCrenNlGdAiWYQpAvAypWgx+91KGdB?=
 =?us-ascii?Q?FtcDOCw2+S93h1UZNdm5+QQkGhrZ9od08t3/kmfeipDQ24IoqZBJCPaVEx51?=
 =?us-ascii?Q?nUmq+ZHhW1KBJGWZQns/JiZg/mkaUKCvrGSiv21ffU4p8a6277r1aV97z+l5?=
 =?us-ascii?Q?eJtGrpfT7ZF4Hzk=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 16:07:26.7362
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c2c5873-60e8-466b-4abd-08dd30c7b62b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001708F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7277

From: Moshe Shemesh <moshe@nvidia.com>

Add modify header alloc and dealloc API functions to provide modify
header actions for steering rules. Use fs hws pools to get actions from
shared bulks of modify header actions.

Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/fs_core.h |   1 +
 .../mellanox/mlx5/core/steering/hws/fs_hws.c  | 120 +++++++++++++
 .../mellanox/mlx5/core/steering/hws/fs_hws.h  |   2 +
 .../mlx5/core/steering/hws/fs_hws_pools.c     | 165 ++++++++++++++++++
 .../mlx5/core/steering/hws/fs_hws_pools.h     |  22 +++
 5 files changed, 310 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h
index b40e5310bef7..5875364cef4b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h
@@ -65,6 +65,7 @@ struct mlx5_modify_hdr {
 	enum mlx5_flow_resource_owner owner;
 	union {
 		struct mlx5_fs_dr_action fs_dr_action;
+		struct mlx5_fs_hws_action fs_hws_action;
 		u32 id;
 	};
 };
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
index a584aa16d2d1..543a7b2f0dff 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
@@ -15,6 +15,9 @@ mlx5_fs_create_action_remove_header_vlan(struct mlx5hws_context *ctx);
 static void
 mlx5_fs_destroy_pr_pool(struct mlx5_fs_pool *pool, struct xarray *pr_pools,
 			unsigned long index);
+static void
+mlx5_fs_destroy_mh_pool(struct mlx5_fs_pool *pool, struct xarray *mh_pools,
+			unsigned long index);
 
 static int mlx5_fs_init_hws_actions_pool(struct mlx5_core_dev *dev,
 					 struct mlx5_fs_hws_context *fs_ctx)
@@ -58,6 +61,7 @@ static int mlx5_fs_init_hws_actions_pool(struct mlx5_core_dev *dev,
 		goto cleanup_insert_hdr;
 	xa_init(&hws_pool->el2tol3tnl_pools);
 	xa_init(&hws_pool->el2tol2tnl_pools);
+	xa_init(&hws_pool->mh_pools);
 	return 0;
 
 cleanup_insert_hdr:
@@ -83,6 +87,9 @@ static void mlx5_fs_cleanup_hws_actions_pool(struct mlx5_fs_hws_context *fs_ctx)
 	struct mlx5_fs_pool *pool;
 	unsigned long i;
 
+	xa_for_each(&hws_pool->mh_pools, i, pool)
+		mlx5_fs_destroy_mh_pool(pool, &hws_pool->mh_pools, i);
+	xa_destroy(&hws_pool->mh_pools);
 	xa_for_each(&hws_pool->el2tol2tnl_pools, i, pool)
 		mlx5_fs_destroy_pr_pool(pool, &hws_pool->el2tol2tnl_pools, i);
 	xa_destroy(&hws_pool->el2tol2tnl_pools);
@@ -532,6 +539,117 @@ static void mlx5_cmd_hws_packet_reformat_dealloc(struct mlx5_flow_root_namespace
 	pkt_reformat->fs_hws_action.pr_data = NULL;
 }
 
+static struct mlx5_fs_pool *
+mlx5_fs_create_mh_pool(struct mlx5_core_dev *dev,
+		       struct mlx5hws_action_mh_pattern *pattern,
+		       struct xarray *mh_pools, unsigned long index)
+{
+	struct mlx5_fs_pool *pool;
+	int err;
+
+	pool = kzalloc(sizeof(*pool), GFP_KERNEL);
+	if (!pool)
+		return ERR_PTR(-ENOMEM);
+	err = mlx5_fs_hws_mh_pool_init(pool, dev, pattern);
+	if (err)
+		goto free_pool;
+	err = xa_insert(mh_pools, index, pool, GFP_KERNEL);
+	if (err)
+		goto cleanup_pool;
+	return pool;
+
+cleanup_pool:
+	mlx5_fs_hws_mh_pool_cleanup(pool);
+free_pool:
+	kfree(pool);
+	return ERR_PTR(err);
+}
+
+static void
+mlx5_fs_destroy_mh_pool(struct mlx5_fs_pool *pool, struct xarray *mh_pools,
+			unsigned long index)
+{
+	xa_erase(mh_pools, index);
+	mlx5_fs_hws_mh_pool_cleanup(pool);
+	kfree(pool);
+}
+
+static int mlx5_cmd_hws_modify_header_alloc(struct mlx5_flow_root_namespace *ns,
+					    u8 namespace, u8 num_actions,
+					    void *modify_actions,
+					    struct mlx5_modify_hdr *modify_hdr)
+{
+	struct mlx5_fs_hws_actions_pool *hws_pool = &ns->fs_hws_context.hws_pool;
+	struct mlx5hws_action_mh_pattern pattern = {};
+	struct mlx5_fs_hws_mh *mh_data = NULL;
+	struct mlx5hws_action *hws_action;
+	struct mlx5_fs_pool *pool;
+	unsigned long i, cnt = 0;
+	bool known_pattern;
+	int err;
+
+	pattern.sz = MLX5_UN_SZ_BYTES(set_add_copy_action_in_auto) * num_actions;
+	pattern.data = modify_actions;
+
+	known_pattern = false;
+	xa_for_each(&hws_pool->mh_pools, i, pool) {
+		if (mlx5_fs_hws_mh_pool_match(pool, &pattern)) {
+			known_pattern = true;
+			break;
+		}
+		cnt++;
+	}
+
+	if (!known_pattern) {
+		pool = mlx5_fs_create_mh_pool(ns->dev, &pattern,
+					      &hws_pool->mh_pools, cnt);
+		if (IS_ERR(pool))
+			return PTR_ERR(pool);
+	}
+	mh_data = mlx5_fs_hws_mh_pool_acquire_mh(pool);
+	if (IS_ERR(mh_data)) {
+		err = PTR_ERR(mh_data);
+		goto destroy_pool;
+	}
+	hws_action = mh_data->bulk->hws_action;
+	mh_data->data = kmemdup(pattern.data, pattern.sz, GFP_KERNEL);
+	if (!mh_data->data) {
+		err = -ENOMEM;
+		goto release_mh;
+	}
+	modify_hdr->fs_hws_action.mh_data = mh_data;
+	modify_hdr->fs_hws_action.fs_pool = pool;
+	modify_hdr->owner = MLX5_FLOW_RESOURCE_OWNER_SW;
+	modify_hdr->fs_hws_action.hws_action = hws_action;
+
+	return 0;
+
+release_mh:
+	mlx5_fs_hws_mh_pool_release_mh(pool, mh_data);
+destroy_pool:
+	if (!known_pattern)
+		mlx5_fs_destroy_mh_pool(pool, &hws_pool->mh_pools, cnt);
+	return err;
+}
+
+static void mlx5_cmd_hws_modify_header_dealloc(struct mlx5_flow_root_namespace *ns,
+					       struct mlx5_modify_hdr *modify_hdr)
+{
+	struct mlx5_fs_hws_mh *mh_data;
+	struct mlx5_fs_pool *pool;
+
+	if (!modify_hdr->fs_hws_action.fs_pool || !modify_hdr->fs_hws_action.mh_data) {
+		mlx5_core_err(ns->dev, "Failed release modify-header\n");
+		return;
+	}
+
+	mh_data = modify_hdr->fs_hws_action.mh_data;
+	kfree(mh_data->data);
+	pool = modify_hdr->fs_hws_action.fs_pool;
+	mlx5_fs_hws_mh_pool_release_mh(pool, mh_data);
+	modify_hdr->fs_hws_action.mh_data = NULL;
+}
+
 static const struct mlx5_flow_cmds mlx5_flow_cmds_hws = {
 	.create_flow_table = mlx5_cmd_hws_create_flow_table,
 	.destroy_flow_table = mlx5_cmd_hws_destroy_flow_table,
@@ -541,6 +659,8 @@ static const struct mlx5_flow_cmds mlx5_flow_cmds_hws = {
 	.destroy_flow_group = mlx5_cmd_hws_destroy_flow_group,
 	.packet_reformat_alloc = mlx5_cmd_hws_packet_reformat_alloc,
 	.packet_reformat_dealloc = mlx5_cmd_hws_packet_reformat_dealloc,
+	.modify_header_alloc = mlx5_cmd_hws_modify_header_alloc,
+	.modify_header_dealloc = mlx5_cmd_hws_modify_header_dealloc,
 	.create_ns = mlx5_cmd_hws_create_ns,
 	.destroy_ns = mlx5_cmd_hws_destroy_ns,
 	.set_peer = mlx5_cmd_hws_set_peer,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.h
index 19786838f6d6..1e53c0156338 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.h
@@ -18,6 +18,7 @@ struct mlx5_fs_hws_actions_pool {
 	struct mlx5_fs_pool dl3tnltol2_pool;
 	struct xarray el2tol3tnl_pools;
 	struct xarray el2tol2tnl_pools;
+	struct xarray mh_pools;
 };
 
 struct mlx5_fs_hws_context {
@@ -34,6 +35,7 @@ struct mlx5_fs_hws_action {
 	struct mlx5hws_action *hws_action;
 	struct mlx5_fs_pool *fs_pool;
 	struct mlx5_fs_hws_pr *pr_data;
+	struct mlx5_fs_hws_mh *mh_data;
 };
 
 struct mlx5_fs_hws_matcher {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws_pools.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws_pools.c
index b12b96c94dae..2a2175b6cfc0 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws_pools.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws_pools.c
@@ -236,3 +236,168 @@ struct mlx5hws_action *mlx5_fs_hws_pr_get_action(struct mlx5_fs_hws_pr *pr_data)
 {
 	return pr_data->bulk->hws_action;
 }
+
+static struct mlx5hws_action *
+mlx5_fs_mh_bulk_action_create(struct mlx5hws_context *ctx,
+			      struct mlx5hws_action_mh_pattern *pattern)
+{
+	u32 flags = MLX5HWS_ACTION_FLAG_HWS_FDB;
+	u32 log_bulk_size;
+
+	log_bulk_size = ilog2(MLX5_FS_HWS_DEFAULT_BULK_LEN);
+	return mlx5hws_action_create_modify_header(ctx, 1, pattern,
+						   log_bulk_size, flags);
+}
+
+static struct mlx5_fs_bulk *
+mlx5_fs_hws_mh_bulk_create(struct mlx5_core_dev *dev, void *pool_ctx)
+{
+	struct mlx5hws_action_mh_pattern *pattern;
+	struct mlx5_flow_root_namespace *root_ns;
+	struct mlx5_fs_hws_mh_bulk *mh_bulk;
+	struct mlx5hws_context *ctx;
+	int bulk_len;
+
+	if (!pool_ctx)
+		return NULL;
+
+	root_ns = mlx5_get_root_namespace(dev, MLX5_FLOW_NAMESPACE_FDB);
+	if (!root_ns || root_ns->mode != MLX5_FLOW_STEERING_MODE_HMFS)
+		return NULL;
+
+	ctx = root_ns->fs_hws_context.hws_ctx;
+	if (!ctx)
+		return NULL;
+
+	pattern = pool_ctx;
+	bulk_len = MLX5_FS_HWS_DEFAULT_BULK_LEN;
+	mh_bulk = kvzalloc(struct_size(mh_bulk, mhs_data, bulk_len), GFP_KERNEL);
+	if (!mh_bulk)
+		return NULL;
+
+	if (mlx5_fs_bulk_init(dev, &mh_bulk->fs_bulk, bulk_len))
+		goto free_mh_bulk;
+
+	for (int i = 0; i < bulk_len; i++) {
+		mh_bulk->mhs_data[i].bulk = mh_bulk;
+		mh_bulk->mhs_data[i].offset = i;
+	}
+
+	mh_bulk->hws_action = mlx5_fs_mh_bulk_action_create(ctx, pattern);
+	if (!mh_bulk->hws_action)
+		goto cleanup_fs_bulk;
+
+	return &mh_bulk->fs_bulk;
+
+cleanup_fs_bulk:
+	mlx5_fs_bulk_cleanup(&mh_bulk->fs_bulk);
+free_mh_bulk:
+	kvfree(mh_bulk);
+	return NULL;
+}
+
+static int
+mlx5_fs_hws_mh_bulk_destroy(struct mlx5_core_dev *dev,
+			    struct mlx5_fs_bulk *fs_bulk)
+{
+	struct mlx5_fs_hws_mh_bulk *mh_bulk;
+
+	mh_bulk = container_of(fs_bulk, struct mlx5_fs_hws_mh_bulk, fs_bulk);
+	if (mlx5_fs_bulk_get_free_amount(fs_bulk) < fs_bulk->bulk_len) {
+		mlx5_core_err(dev, "Freeing bulk before all modify header were released\n");
+		return -EBUSY;
+	}
+
+	mlx5hws_action_destroy(mh_bulk->hws_action);
+	mlx5_fs_bulk_cleanup(fs_bulk);
+	kvfree(mh_bulk);
+
+	return 0;
+}
+
+static const struct mlx5_fs_pool_ops mlx5_fs_hws_mh_pool_ops = {
+	.bulk_create = mlx5_fs_hws_mh_bulk_create,
+	.bulk_destroy = mlx5_fs_hws_mh_bulk_destroy,
+	.update_threshold = mlx5_hws_pool_update_threshold,
+};
+
+int mlx5_fs_hws_mh_pool_init(struct mlx5_fs_pool *fs_hws_mh_pool,
+			     struct mlx5_core_dev *dev,
+			     struct mlx5hws_action_mh_pattern *pattern)
+{
+	struct mlx5hws_action_mh_pattern *pool_pattern;
+
+	pool_pattern = kzalloc(sizeof(*pool_pattern), GFP_KERNEL);
+	if (!pool_pattern)
+		return -ENOMEM;
+	pool_pattern->data = kmemdup(pattern->data, pattern->sz, GFP_KERNEL);
+	if (!pool_pattern->data) {
+		kfree(pool_pattern);
+		return -ENOMEM;
+	}
+	pool_pattern->sz = pattern->sz;
+	mlx5_fs_pool_init(fs_hws_mh_pool, dev, &mlx5_fs_hws_mh_pool_ops,
+			  pool_pattern);
+	return 0;
+}
+
+void mlx5_fs_hws_mh_pool_cleanup(struct mlx5_fs_pool *fs_hws_mh_pool)
+{
+	struct mlx5hws_action_mh_pattern *pool_pattern;
+
+	mlx5_fs_pool_cleanup(fs_hws_mh_pool);
+	pool_pattern = fs_hws_mh_pool->pool_ctx;
+	if (!pool_pattern)
+		return;
+	kfree(pool_pattern->data);
+	kfree(pool_pattern);
+}
+
+struct mlx5_fs_hws_mh *
+mlx5_fs_hws_mh_pool_acquire_mh(struct mlx5_fs_pool *mh_pool)
+{
+	struct mlx5_fs_pool_index pool_index = {};
+	struct mlx5_fs_hws_mh_bulk *mh_bulk;
+	int err;
+
+	err = mlx5_fs_pool_acquire_index(mh_pool, &pool_index);
+	if (err)
+		return ERR_PTR(err);
+	mh_bulk = container_of(pool_index.fs_bulk, struct mlx5_fs_hws_mh_bulk,
+			       fs_bulk);
+	return &mh_bulk->mhs_data[pool_index.index];
+}
+
+void mlx5_fs_hws_mh_pool_release_mh(struct mlx5_fs_pool *mh_pool,
+				    struct mlx5_fs_hws_mh *mh_data)
+{
+	struct mlx5_fs_bulk *fs_bulk = &mh_data->bulk->fs_bulk;
+	struct mlx5_fs_pool_index pool_index = {};
+	struct mlx5_core_dev *dev = mh_pool->dev;
+
+	pool_index.fs_bulk = fs_bulk;
+	pool_index.index = mh_data->offset;
+	if (mlx5_fs_pool_release_index(mh_pool, &pool_index))
+		mlx5_core_warn(dev, "Attempted to release modify header which is not acquired\n");
+}
+
+bool mlx5_fs_hws_mh_pool_match(struct mlx5_fs_pool *mh_pool,
+			       struct mlx5hws_action_mh_pattern *pattern)
+{
+	struct mlx5hws_action_mh_pattern *pool_pattern;
+	int num_actions, i;
+
+	pool_pattern = mh_pool->pool_ctx;
+	if (WARN_ON_ONCE(!pool_pattern))
+		return false;
+
+	if (pattern->sz != pool_pattern->sz)
+		return false;
+	num_actions = pattern->sz / MLX5_UN_SZ_BYTES(set_add_copy_action_in_auto);
+	for (i = 0; i < num_actions; i++) {
+		if ((__force __be32)pattern->data[i] !=
+		    (__force __be32)pool_pattern->data[i])
+			return false;
+	}
+	return true;
+}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws_pools.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws_pools.h
index 544b277be3c5..30157db4d40e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws_pools.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws_pools.h
@@ -36,6 +36,19 @@ struct mlx5_fs_hws_pr_pool_ctx {
 	size_t encap_data_size;
 };
 
+struct mlx5_fs_hws_mh {
+	struct mlx5_fs_hws_mh_bulk *bulk;
+	u32 offset;
+	u8 *data;
+};
+
+struct mlx5_fs_hws_mh_bulk {
+	struct mlx5_fs_bulk fs_bulk;
+	struct mlx5_fs_pool *mh_pool;
+	struct mlx5hws_action *hws_action;
+	struct mlx5_fs_hws_mh mhs_data[];
+};
+
 int mlx5_fs_hws_pr_pool_init(struct mlx5_fs_pool *pr_pool,
 			     struct mlx5_core_dev *dev, size_t encap_data_size,
 			     enum mlx5hws_action_type reformat_type);
@@ -45,4 +58,13 @@ struct mlx5_fs_hws_pr *mlx5_fs_hws_pr_pool_acquire_pr(struct mlx5_fs_pool *pr_po
 void mlx5_fs_hws_pr_pool_release_pr(struct mlx5_fs_pool *pr_pool,
 				    struct mlx5_fs_hws_pr *pr_data);
 struct mlx5hws_action *mlx5_fs_hws_pr_get_action(struct mlx5_fs_hws_pr *pr_data);
+int mlx5_fs_hws_mh_pool_init(struct mlx5_fs_pool *fs_hws_mh_pool,
+			     struct mlx5_core_dev *dev,
+			     struct mlx5hws_action_mh_pattern *pattern);
+void mlx5_fs_hws_mh_pool_cleanup(struct mlx5_fs_pool *fs_hws_mh_pool);
+struct mlx5_fs_hws_mh *mlx5_fs_hws_mh_pool_acquire_mh(struct mlx5_fs_pool *mh_pool);
+void mlx5_fs_hws_mh_pool_release_mh(struct mlx5_fs_pool *mh_pool,
+				    struct mlx5_fs_hws_mh *mh_data);
+bool mlx5_fs_hws_mh_pool_match(struct mlx5_fs_pool *mh_pool,
+			       struct mlx5hws_action_mh_pattern *pattern);
 #endif /* __MLX5_FS_HWS_POOLS_H__ */
-- 
2.45.0


