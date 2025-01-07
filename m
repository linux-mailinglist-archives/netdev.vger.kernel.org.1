Return-Path: <netdev+bounces-155723-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34DF6A037AF
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 07:09:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECF31164C78
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 06:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D04A01AAA10;
	Tue,  7 Jan 2025 06:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="K/QU6ChI"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E36A1DED59
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 06:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736230142; cv=fail; b=lrgARFKNZtyghcJbJUA1VhiF31IzQVwxq5xiST8jjjJgnJaJjc075P2V4p686vx5E4hGniOLrUpQ2xX2av3Wrsrh25r5yMmuNSa7yfetmFEdG4VsmY/TCPE8jcA2nZN/as6xbIYmAgsBV27QYxCLtukeLZVlinCbjxrvwaV4mtM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736230142; c=relaxed/simple;
	bh=GBGzpFCaU/JGfEvnnqmCiDlYC70bgYT9Ns7pAMmLXrg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=doBsrj4CNPQ2AlBxRpktnhzV9/sEYYs4CNMX6fzdkdx16QtWT75PyP2tbRLFpUtmHGMxcnrGgy9yXcXxmCh6z1/0W6egrjk+fzLV9JeCW3VPoJsFFW35aThnA6z+GI2/otiu6n1iGOAZHzMsO+m2MMmsZWMZppe/HXIvs/Q0o0A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=K/QU6ChI; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m76JfP1g/ZCeFnYr2KOM4HtCOosDYjpfIYehDA6mUbOahbpoMyxlMlkkyGhbI/5YgWjAAjg1HSdMIq0HplSvTe78gYs0Vs63DsIy8QSO0J8xUZ2npJcjCTYq6nNBaxQ4/kalCmcfGBUvdYJcwDJuFs5XZ7UuZJkcDcuEBSci7tCtdazifBANxYIjM2dsK7OMfurMFBfX8j/VbyvbaBv0ovX+h7eFufeLk76im4oo2C7upLx7n+fj2Q6zEmIWZWQFqPBjkF9v9tpBpNVm4T9j5p8tmxrH/MBhmTP9AL6m4bVYkzfMNl8zi2e8Jb2g1Ni4NZ8S8OIlS5eMEFbZZoKZQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lceO3jRRjj49NZ8C542iqWishb4F962jWXemQFvdMP8=;
 b=q+TmskT/HzNDuQD/yjuXP8/TQd0WMzltqJzqHzNqYnABOElshRqYp/s5c6Sjezwmp0Urj4GZNfvdmeFuGKmlWWWjvbxNgr7F1hDUYqsO/kQwsdrBcjkpA05QsfdxUVujim4Z2YOjT4TFdHEVWTjmC0dbhfQJTBbXpNLyGxx9XNOhEiwQjJKIC6PJ+C1U9firMwk9MM5QxLXgf9vXaX/NBRnrGgDFSpy2lTlZr5QjDYOVHH/a1F649p6+asJhtHhQPOCB8o7VUMYizepLWKDW7nUixnMQ59qFfCU/74BQZwVxxhxXvAJ+rsBytuvRwBBFKji/8KW55tZrrZYdRuf3QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lceO3jRRjj49NZ8C542iqWishb4F962jWXemQFvdMP8=;
 b=K/QU6ChIQOojOwBGjqeUeG9xP9p/ksU3f1hEAboNTGUbTn8C7Wn9MhAyZXp9vjKPojV5N2Gt+5Icm3pHJ6cPhSvgrKoadF2Rie5iHm5RRsOVrdnurDRJlj9Wt61osrbkXXvn4MzZJCvnjuq68dhbVpxyQoRyusNEV7cdcghHdNEOaq5TdMQAO6cjBeQExMlricWL/QqHKpGaBqJT7ZBbYBv7D6SY59lycbsX5VlKYuzEDNoWottMwLxVzzLpc8Pl32eQfzwZjcFbUF3QfWgrt04TBfRZo/ySVbzSzgjMO7cOyOcT7J6pTa8fcrXT6xpGWwDUJhppI53IORuoqsKN6g==
Received: from CH5P223CA0020.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:1f3::9)
 by CH0PR12MB8487.namprd12.prod.outlook.com (2603:10b6:610:18c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.18; Tue, 7 Jan
 2025 06:08:50 +0000
Received: from CH1PEPF0000AD79.namprd04.prod.outlook.com
 (2603:10b6:610:1f3:cafe::a8) by CH5P223CA0020.outlook.office365.com
 (2603:10b6:610:1f3::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.18 via Frontend Transport; Tue,
 7 Jan 2025 06:08:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000AD79.mail.protection.outlook.com (10.167.244.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.7 via Frontend Transport; Tue, 7 Jan 2025 06:08:50 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 6 Jan 2025
 22:08:34 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 6 Jan 2025
 22:08:33 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Mon, 6 Jan
 2025 22:08:30 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Yevgeny Kliteynik
	<kliteyn@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 04/13] net/mlx5: fs, add HWS actions pool
Date: Tue, 7 Jan 2025 08:06:59 +0200
Message-ID: <20250107060708.1610882-5-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD79:EE_|CH0PR12MB8487:EE_
X-MS-Office365-Filtering-Correlation-Id: bbbe1807-e4f8-4c54-b0be-08dd2ee1c16f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?alztym7x3UFXs8DTgmxp3gIINwuoQXiUB9gLrMEn/O7W/WxxXN+IxJ7B44JZ?=
 =?us-ascii?Q?ILFk7cQJlbK1ZkKZy2NsYsFIeVKoWz7UfOJGeG5E/nyHKpPoPeOOTv6l3Iyx?=
 =?us-ascii?Q?dHMmy2bX06/51ITrjJYzJw7cJTkTwK26JVX+6sLQyulAVHEIGJqVXamHbbXJ?=
 =?us-ascii?Q?501oiTT49grYXugKQgNANhDWDgP1dowLf2PkLnH+fuDxfXc8vFdvrRNvjzPa?=
 =?us-ascii?Q?9b/YWnDwK+xeKRtE9rqfYoQDOGdOHaVgA9JouBUX7PasUB6py5ONbT6C9ZYj?=
 =?us-ascii?Q?JlMeOtHXbAvc+Ovm/JTfOF67sLEIwA8xbsgkuDqytslOFZeJCYhhmEPOlGGK?=
 =?us-ascii?Q?z/8xKoEInjGrv1NQ+Qk0WzlA5jK8zz2WA3LdXCboafuAcmY/fLwlmSi7tmFz?=
 =?us-ascii?Q?B7PdKk16Z2xu8fWAKOHiJ/0IE7wXV6fPuK2gxbTb7IIM2VLA4gwLWrDncKov?=
 =?us-ascii?Q?wdKW/sHjvWD3alSRPEJIC69FEziAQOcOjpp658fo1pG/6ZJmAJnL+dXDEoMO?=
 =?us-ascii?Q?dosrH4QVNx2zlek4G1D3zJwR3OP63oExw8A/qTo4xERiN5TaUE2uIgllS0ZB?=
 =?us-ascii?Q?xJ7HHsyMlgKz5mz7hYuMhUJ3K8MhENIV5Jo93/NgchUQN9A8tH09mNgf3Z7c?=
 =?us-ascii?Q?fYW6zpM4b4ifkZOirSnXOvLyMXqygZ10lowZJhdqvZZrOusVzAJuYYTshrch?=
 =?us-ascii?Q?QztTt3OEju8XNlmk4fattvyVDr/q8ERuLXNYG6rkIiBo+KtDQE7U8zHh/DTp?=
 =?us-ascii?Q?12FCf6mINbhP80aEBGsTSBfH/N2SqF0zJlfcKtEfgnqj/MpkaDrtdu33YVv1?=
 =?us-ascii?Q?esRv0eZgDSl4MO02BYN1/tJbbpd1kDjZVoJRdWTbAezoQMN3Mgyw4cFMqf/Q?=
 =?us-ascii?Q?4Iv4ubxXNYgwrsMcZdAiKKOBE3wDNlayyvMrnmugNKJqPHG+jwjOr0vwiUUV?=
 =?us-ascii?Q?wKJJRDsR6taOSyPxZabrA+tZ3mX6t1tBn/it3RjUibqCTkTdhutSUX1rIcy4?=
 =?us-ascii?Q?v//iOk1lQ7/oCbNaq9YtPSrr4wZnBsy6uaia/OonmB6WcekXCUgEaXeSbfnU?=
 =?us-ascii?Q?Aa4HwlcERcgT4WSyOs+2mq3ReXKzb3sgylzaQNAC8HcX6QPhjTClvNlktDsC?=
 =?us-ascii?Q?XhfR74eKEGBenulo/FscvQzoCKUEVzyZQVRFnATQkOp7eMac4m7Dop6l4nRC?=
 =?us-ascii?Q?NrI7WNeJ6lU+DITncxTrlgbIwPY68r+rSdfpSlh8Hgh9/gxXzDnGivVwtxyf?=
 =?us-ascii?Q?7bYkOJEoBObbUvBzo6euKMjBt5PuQnNabnrAkvOZwGSfb2AdIBlngsM4iP1y?=
 =?us-ascii?Q?DVR/lyI35H002kpIXbp7oWMHin1Rz5z7eO14nn9BR+zKyYMBcwEFflOwIz2B?=
 =?us-ascii?Q?f8q5EC22AOEsKNsGH8ZIApeZgNy1Sle7XlnvhYge3X9ibgohffrDHpOcxw27?=
 =?us-ascii?Q?mYgTqX536YGQHq/N5VrMgzBTboHeHp7dWZ52966+qxzmRV0MyCxTU6lQBUbQ?=
 =?us-ascii?Q?MUQ3owFOLeVvDyQ=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 06:08:50.2757
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bbbe1807-e4f8-4c54-b0be-08dd2ee1c16f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD79.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8487

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
index c8064bc8a86c..eeaf4a84aafc 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
@@ -9,9 +9,60 @@
 #define MLX5HWS_CTX_MAX_NUM_OF_QUEUES 16
 #define MLX5HWS_CTX_QUEUE_SIZE 256
 
+static int init_hws_actions_pool(struct mlx5_fs_hws_context *fs_ctx)
+{
+	u32 flags = MLX5HWS_ACTION_FLAG_HWS_FDB | MLX5HWS_ACTION_FLAG_SHARED;
+	struct mlx5_fs_hws_actions_pool *hws_pool = &fs_ctx->hws_pool;
+	struct mlx5hws_action_reformat_header reformat_hdr = {};
+	struct mlx5hws_context *ctx = fs_ctx->hws_ctx;
+	enum mlx5hws_action_type action_type;
+
+	hws_pool->tag_action = mlx5hws_action_create_tag(ctx, flags);
+	if (!hws_pool->tag_action)
+		return -ENOMEM;
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
+	return -ENOMEM;
+}
+
+static void cleanup_hws_actions_pool(struct mlx5_fs_hws_context *fs_ctx)
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
 		return -EOPNOTSUPP;
 	}
+	err = init_hws_actions_pool(&ns->fs_hws_context);
+	if (err) {
+		mlx5_core_err(ns->dev, "Failed to init hws actions pool\n");
+		mlx5hws_context_close(ns->fs_hws_context.hws_ctx);
+		return err;
+	}
 	return 0;
 }
 
 static int mlx5_cmd_hws_destroy_ns(struct mlx5_flow_root_namespace *ns)
 {
+	cleanup_hws_actions_pool(&ns->fs_hws_context);
 	return mlx5hws_context_close(ns->fs_hws_context.hws_ctx);
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.h
index da8094c66cd5..256be4234d92 100644
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


