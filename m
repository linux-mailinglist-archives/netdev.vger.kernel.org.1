Return-Path: <netdev+bounces-156767-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F92A07CEA
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 17:08:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06A591652F6
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 16:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E64220699;
	Thu,  9 Jan 2025 16:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dR1PqK9b"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2076.outbound.protection.outlook.com [40.107.101.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E93220688
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 16:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736438871; cv=fail; b=QzDolJJwdbqapWZcFKJG9FzdCy0IdKeYJhhvgl8ijREZfdj6k+6H6wWR1djhvlGDlREfpN5tBsjLx/Q2FVjemH5hBrp4LWuXJqsmRN+qdevxnqHNFbj0GpKtuVR1Vtxwy3chKMBQwgRbNmFgkxah9nNzoMRwLj/2cd0WVCvPURw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736438871; c=relaxed/simple;
	bh=eON5bpbm7Q9olETMVVdMHJoC7tpOz4XKyK+WYZ8TqXI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e2ovnkfSYekGQk1p48LgpU0SbunexPHmfRISajKtxfKdryIppsbUtr4uYIU9NPemOwsNCQ96uIvEaM1sKCR5NYImVSFUlviJaYVHnWaGjl3gHt0UJswJF8944AvBAoTYTxEQngPHtyeGYn287I+knEYCykJtOFCXl5VE7/XaB1k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dR1PqK9b; arc=fail smtp.client-ip=40.107.101.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w9BWVtkY3Y2KjnfAiNJvfHQ6GjiqYOlwSAGJcp8UN81/rNzdT4I7J4Wx+V26vi9URPRTEUB4RiAxeON1LUfapLYB2Pupjr6l+CojNhPUG1OCWWX9OFMAn+AD+Uz70voKyjFq4/y4UhIKpIGU5oxw5tBNpwuDZNh8qKl8mflCgg91qUH157h/a9GUJQ9SW5eyF6iemPPpHrpVl5GuHqAszjvPgOLWkek41Pp+5y9MMp3kebLCYiKvMeqkr6m8vSGdIwu9f8UO2Cw5DHogbKt1tPZwDh/eaAMCb8dd4jGM7xSG8TnyWgsqFXhHZS8PnXT2N24y4ASVyUG04Fr4SBXJLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w93bXKOo3XN/mUg5m7QkVCo5Awvmcz9CKhqMNzEF4Qo=;
 b=GX1Ul4YCMuHKif/z/46zcR2kGPEfvnxy+EJ3PerIrltt1UJJRthv3XMMObfz7sxL3UDiMBstMuyWolplW7uH7gbGA05NhacZ01f9dEV1ewzAYv3o9AZBB5j9Y/xFrPqR5hJ4wEv6Xmx4E3q0WtKhq+ITNIzD9AzksSroXt1p11dY3Otm+p4Ng6ZZgTVzb6CNRiK6LImLenb5cAGJZhWMujJAsZ3y3VdbmJDo+JNqHPFroBeBU14viokqfJSZBO7QLPA+T2MluIWpUTR1GOOELVRN+9d5KVpRfXKoKGCOE0VLbBL9SgWBQY4VEL1rzuQhcj7Kb0IcStgxa3/plki2rA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w93bXKOo3XN/mUg5m7QkVCo5Awvmcz9CKhqMNzEF4Qo=;
 b=dR1PqK9bPkhQge4Fp6uuBKIrs7eQIfwBIyFoJTv6Ua5Wayvi/i5X5vYT6RWKMohJgi1XyTJLiKQXpCEq/ppy+NIlNQWXFaG9KON9QSzcqGyMMzlM9EP5UnyZQbBgImlaKbESqO/7YjPRBWq50gnW0dCPXtC6jaIke+2+4QXdE9jnSvgbaQCCqy6hQBwjAJ1R4apprQiGyjnRINzIvsVGqp+Y6RhlrwfdrCD9zlCHjQUUBP0jJPX7OQRLV7iba7emgnrElSSLeUZw4HlN3m9N2b6pDF4pCUDk01cCbfJqCKO8tw7UNZVm1yrQ6YIimFI3H0p+sCsQV5RDu6iOUFHQ2A==
Received: from SJ0PR03CA0292.namprd03.prod.outlook.com (2603:10b6:a03:39e::27)
 by DS7PR12MB6143.namprd12.prod.outlook.com (2603:10b6:8:99::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Thu, 9 Jan
 2025 16:07:42 +0000
Received: from CO1PEPF000044FA.namprd21.prod.outlook.com
 (2603:10b6:a03:39e:cafe::ff) by SJ0PR03CA0292.outlook.office365.com
 (2603:10b6:a03:39e::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.12 via Frontend Transport; Thu,
 9 Jan 2025 16:07:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000044FA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.0 via Frontend Transport; Thu, 9 Jan 2025 16:07:41 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 9 Jan 2025
 08:07:21 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 9 Jan 2025
 08:07:21 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Thu, 9 Jan
 2025 08:07:18 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Yevgeny Kliteynik
	<kliteyn@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next V2 08/15] net/mlx5: fs, add dest table cache
Date: Thu, 9 Jan 2025 18:05:39 +0200
Message-ID: <20250109160546.1733647-9-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FA:EE_|DS7PR12MB6143:EE_
X-MS-Office365-Filtering-Correlation-Id: 12e61fa5-c192-4183-a185-08dd30c7bf36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cwj4kcvqA47dK/k1ZigFawy0WgDg08kfC6PlekrFpTIEfMp6RIib4p2d98Ki?=
 =?us-ascii?Q?rp1kxRB3RBR/4er02i7D9wtbktEwWeWcYn9XK0OuxQYYxLdmvWp3QzDNH1gh?=
 =?us-ascii?Q?AfjkfRhezBu3seB4enGrLcy9udRuOdI51godLOYPsd2SpDMCXHev7a6w0kkJ?=
 =?us-ascii?Q?k+O5FQ0l/VTEPUpvmDyuZksrGlLuz/+HONyiiFMu9HxasKsgXJ4ohRvHusxF?=
 =?us-ascii?Q?tSYeehBPF7B95ahpt0RyAUAM86IcYdCjjfygaizjv1zzmDSGIobTGwCkgy24?=
 =?us-ascii?Q?+Hjp4kGh3OsMY564197C5xSF9unx3QNfUGwPSkrnQyz2VgvpwVRaPDBa7Bph?=
 =?us-ascii?Q?puHsVrpqsfF60HqWuup3JsSTluUx9wizpmOO5FuCkyKv/QGrR1JbKJwmFeLG?=
 =?us-ascii?Q?tCNsoJwZu1Jgl0a9sQxiElvGhw1bpvarczBn9jNVnbLeZ8SSx9lwqFCTFBsU?=
 =?us-ascii?Q?v316BWWRJHB1UOo/gfBThuLcicpniakUmzjWt5auIvA/AwQgdNilWaGQ5QFi?=
 =?us-ascii?Q?Pbrf6Fo9G/KOsXE/TmeBbjndIT8tnWp5wxiAocK/0cgzZwdKY39Y3J1wh0iC?=
 =?us-ascii?Q?dLw71fSm+l07ZeCp9A1H7q7RKtu2RAftON9wVfLGfqVxluLjyN3k1iDfOcCX?=
 =?us-ascii?Q?6xog5yPOr1r3PZzpaomyyK5PeIFsDGYURTtB8//N5dvr0zDb4pVHf4e0eqFl?=
 =?us-ascii?Q?jMAFyRELegNFwhw7p9nWiPGw4LNqBwYJIxI6FHAeM7Ag2Vr/V9thvwVTQXFZ?=
 =?us-ascii?Q?qR5uFsKpbYetqAMDovCsuiAvVbhZvhy5TtuCL5N7qFRmvBLvf7mO6dUyxDcq?=
 =?us-ascii?Q?nTSyWtyEqwl2TIF7LFiFpzbZUK2+0DCuMsJbBzMEISrQLMi/KN0goHC9O+2w?=
 =?us-ascii?Q?L3lFNPMDQGwg02Ejg5lTUeQKSIA+TXnxjqB+crW04Li+AfbaOopVNBoAeU6+?=
 =?us-ascii?Q?ARrJj6h2DaNMz572ZUi6Nw0A4lbJGFwNw+MN/FiVhp0hA1OXGcqj/LLFnyaf?=
 =?us-ascii?Q?Xj/OhCTemO4KMHnFSiZDAqJGtVbJ1vlC9eyCC2Ed9pkuy14yCLmVU3FJ9RD+?=
 =?us-ascii?Q?Xdki6PvytHMiytUsbJhLJMDOvOTaOhQ8aCusGhNVteAD2rbnynKxWzJdYSzY?=
 =?us-ascii?Q?y5pjdaeO29VnY6Yuo4xus+OixunqjYSz1gHn/O7hl4FhhA/Rb6KUb0OO4lUK?=
 =?us-ascii?Q?3L7kdS0n+xMh+NBfq3vx6HcApNsQ/y4fu2p1ws7YAfJa4MIl06w+8Th3Rx7i?=
 =?us-ascii?Q?OzbEkniDWi84bufLKqmWCNuVDXwu08gXbEItJOdZwiWF9EW1BvFHte9q23E3?=
 =?us-ascii?Q?/HIdlhOdNyXfnZCiJBE/WJi8fDza4vr4fWx2pbsKAkA9yja8w9159278Ziaw?=
 =?us-ascii?Q?sTUr80f4xDT0+ObBTfNOlERICDSlBSflaGtYO0xhu52meyvF2NXlE7mSSXoa?=
 =?us-ascii?Q?d1NCNuIe6lVyo6vneZiqpjW/ImSds4uHQ4cFWfiMSBdCjOORZp7UCg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 16:07:41.9725
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12e61fa5-c192-4183-a185-08dd30c7bf36
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6143

From: Moshe Shemesh <moshe@nvidia.com>

Add cache of destination flow table HWS action per HWS table. For each
flow table created cache a destination action towards this table. The
cached action will be used on the downstream patch whenever a rule
requires such action.

Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/steering/hws/fs_hws.c  | 68 ++++++++++++++++++-
 .../mellanox/mlx5/core/steering/hws/fs_hws.h  |  1 +
 2 files changed, 66 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
index 543a7b2f0dff..7146cdd791fc 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
@@ -62,6 +62,7 @@ static int mlx5_fs_init_hws_actions_pool(struct mlx5_core_dev *dev,
 	xa_init(&hws_pool->el2tol3tnl_pools);
 	xa_init(&hws_pool->el2tol2tnl_pools);
 	xa_init(&hws_pool->mh_pools);
+	xa_init(&hws_pool->table_dests);
 	return 0;
 
 cleanup_insert_hdr:
@@ -87,6 +88,7 @@ static void mlx5_fs_cleanup_hws_actions_pool(struct mlx5_fs_hws_context *fs_ctx)
 	struct mlx5_fs_pool *pool;
 	unsigned long i;
 
+	xa_destroy(&hws_pool->table_dests);
 	xa_for_each(&hws_pool->mh_pools, i, pool)
 		mlx5_fs_destroy_mh_pool(pool, &hws_pool->mh_pools, i);
 	xa_destroy(&hws_pool->mh_pools);
@@ -173,6 +175,50 @@ static int mlx5_fs_set_ft_default_miss(struct mlx5_flow_root_namespace *ns,
 	return 0;
 }
 
+static int mlx5_fs_add_flow_table_dest_action(struct mlx5_flow_root_namespace *ns,
+					      struct mlx5_flow_table *ft)
+{
+	u32 flags = MLX5HWS_ACTION_FLAG_HWS_FDB | MLX5HWS_ACTION_FLAG_SHARED;
+	struct mlx5_fs_hws_context *fs_ctx = &ns->fs_hws_context;
+	struct mlx5hws_action *dest_ft_action;
+	struct xarray *dests_xa;
+	int err;
+
+	dest_ft_action = mlx5hws_action_create_dest_table_num(fs_ctx->hws_ctx,
+							      ft->id, flags);
+	if (!dest_ft_action) {
+		mlx5_core_err(ns->dev, "Failed creating dest table action\n");
+		return -ENOMEM;
+	}
+
+	dests_xa = &fs_ctx->hws_pool.table_dests;
+	err = xa_insert(dests_xa, ft->id, dest_ft_action, GFP_KERNEL);
+	if (err)
+		mlx5hws_action_destroy(dest_ft_action);
+	return err;
+}
+
+static int mlx5_fs_del_flow_table_dest_action(struct mlx5_flow_root_namespace *ns,
+					      struct mlx5_flow_table *ft)
+{
+	struct mlx5_fs_hws_context *fs_ctx = &ns->fs_hws_context;
+	struct mlx5hws_action *dest_ft_action;
+	struct xarray *dests_xa;
+	int err;
+
+	dests_xa = &fs_ctx->hws_pool.table_dests;
+	dest_ft_action = xa_erase(dests_xa, ft->id);
+	if (!dest_ft_action) {
+		mlx5_core_err(ns->dev, "Failed to erase dest ft action\n");
+		return -ENOENT;
+	}
+
+	err = mlx5hws_action_destroy(dest_ft_action);
+	if (err)
+		mlx5_core_err(ns->dev, "Failed to destroy dest ft action\n");
+	return err;
+}
+
 static int mlx5_cmd_hws_create_flow_table(struct mlx5_flow_root_namespace *ns,
 					  struct mlx5_flow_table *ft,
 					  struct mlx5_flow_table_attr *ft_attr,
@@ -183,9 +229,16 @@ static int mlx5_cmd_hws_create_flow_table(struct mlx5_flow_root_namespace *ns,
 	struct mlx5hws_table *tbl;
 	int err;
 
-	if (mlx5_fs_cmd_is_fw_term_table(ft))
-		return mlx5_fs_cmd_get_fw_cmds()->create_flow_table(ns, ft, ft_attr,
-								    next_ft);
+	if (mlx5_fs_cmd_is_fw_term_table(ft)) {
+		err = mlx5_fs_cmd_get_fw_cmds()->create_flow_table(ns, ft, ft_attr,
+								   next_ft);
+		if (err)
+			return err;
+		err = mlx5_fs_add_flow_table_dest_action(ns, ft);
+		if (err)
+			mlx5_fs_cmd_get_fw_cmds()->destroy_flow_table(ns, ft);
+		return err;
+	}
 
 	if (ns->table_type != FS_FT_FDB) {
 		mlx5_core_err(ns->dev, "Table type %d not supported for HWS\n",
@@ -212,8 +265,13 @@ static int mlx5_cmd_hws_create_flow_table(struct mlx5_flow_root_namespace *ns,
 
 	ft->max_fte = INT_MAX;
 
+	err = mlx5_fs_add_flow_table_dest_action(ns, ft);
+	if (err)
+		goto clear_ft_miss;
 	return 0;
 
+clear_ft_miss:
+	mlx5_fs_set_ft_default_miss(ns, ft, NULL);
 destroy_table:
 	mlx5hws_table_destroy(tbl);
 	ft->fs_hws_table.hws_table = NULL;
@@ -225,6 +283,10 @@ static int mlx5_cmd_hws_destroy_flow_table(struct mlx5_flow_root_namespace *ns,
 {
 	int err;
 
+	err = mlx5_fs_del_flow_table_dest_action(ns, ft);
+	if (err)
+		mlx5_core_err(ns->dev, "Failed to remove dest action (%d)\n", err);
+
 	if (mlx5_fs_cmd_is_fw_term_table(ft))
 		return mlx5_fs_cmd_get_fw_cmds()->destroy_flow_table(ns, ft);
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.h
index 1e53c0156338..205d8d71e7d9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.h
@@ -19,6 +19,7 @@ struct mlx5_fs_hws_actions_pool {
 	struct xarray el2tol3tnl_pools;
 	struct xarray el2tol2tnl_pools;
 	struct xarray mh_pools;
+	struct xarray table_dests;
 };
 
 struct mlx5_fs_hws_context {
-- 
2.45.0


