Return-Path: <netdev+bounces-155724-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CEDEA037B1
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 07:09:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D97BD188687F
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 06:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A6C1DF993;
	Tue,  7 Jan 2025 06:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SEYsmw4K"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971D769D2B
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 06:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736230144; cv=fail; b=UJoK9NxDd1iMCx/FWYJYX0lC+rfBQ747V8OGIb+7zdBlDsQDABs+//TyqQarwzUPLr7ic/2QjrGPMy5DypYq0YJei2MjQgUZpFnQp4tDOxv0geAUWctSbj6dsxKxeDa+uwjdyBjJAyZunaaatbbk6exDR0hx3GOHQ6eKuk8E7oU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736230144; c=relaxed/simple;
	bh=6u8nE7L/hS4hodbinCkZBpGsCXJjJHqFNgYEjPFAv+0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nQSRcDiIPKm3oP57JjVsiQLB7T3MSpDo4Y7V+3m5zEPK6ne26vznhJld4xB+8LlJ0L77T00Gnu7IUy8XlPDW+XEW6NpW466R1x5AFrmjdpQu0g5L2u0hT4alHlC8MFsIbP0V9ShfCAm3utBH6GRe5n5eNWfSoGtfd9/VaZuql3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SEYsmw4K; arc=fail smtp.client-ip=40.107.244.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kBa3E0nkg8p+KqNTqVW7ZA1/Zsfe7Ns5svoOehaTbFR2nenC5OYS3xEsz7L+xR72oS20PpRHkM0AEk9AnJuCpn0u5F6JSKt+oPcdvHH8BQjsQLwb13NXeWCgGGh16MraeLaW40AQ2oTEsO6LnjGlE+hV0j22IKTUwrRkIhH7giItrdnKHY2FCtkfc+ToGnrRkUjSI5v6kBYu5F5SsBZC+S+wFwny/RxI1xNnaizrRd87DOnfyfFwKQKrcImfiRZ7SuB8m9dJWCOWHcsr3ZlqJ2ryNkbQdhzXI1kWJUrO00RJxvVe5kk/DtGiOcu1eiRYEJFZDWoxBZwB88c8AIgq5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z2lgxWEXg/bCsL1sm1k3dV0ALNYEqH9UykBYybiVDqo=;
 b=BhtYaRGtsNQpqFTBhfbp01XUikm6LrZwDWPEn7bbDCG8p0kiWGvDJMTk2cEEG6AbDozLzxx7nZLsc2tz/TsVsauimvLrTm0e2BV/OAtIva/H5ZYciTJJq/6QUSaMx/CAcVutH0BUJe8SPrQuxdYR2e79J0gYDjy/w3SNJuHrSdsw8U/XdUsOnkynqVhH+WfWyZKKoYNMqmEOkoZbj7kvXAc8bEebdOB1jWNxnkdT+kV7MlW2zAWhrdrZ0iy6ye2eJFKVxqrTXcE1h4GmoFAHGaS4yFbPZehgn4g7TzdsIKMdPdNk89XNuA+qrvhwybWMjxj37UUHopTc4KqhyqCIxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z2lgxWEXg/bCsL1sm1k3dV0ALNYEqH9UykBYybiVDqo=;
 b=SEYsmw4K6vIhNz3l1hEjqhlML2WCtDqUu7yXG62h9finBFDRFjmWOlFeVzBsvwJgEZD7qSqEQEH7VDXNNTDjpmTgvK8HoDW9+e85edq42kbuO7eGjUbwSIlOw+JTDOkj4q/fKxq06IZUUNBSSVBXRU9ekNHyBEVbv3MuHcJZBuqFGJ8usODXw1qmcz4FkKZoQhhDu9gLipSvlkdJoyu233xrvnxjpbbF6OI9fuhJbmv4QPnTDkZ978XxVFDQW4nm/4ilL86NS8qf95rnS3RblUY2paliOzwML/xH8Mz0RDFlm4pxtRhb05Wk/ndcXchU1cRqSbyIbbQndbMGDgwYCQ==
Received: from CH2PR14CA0052.namprd14.prod.outlook.com (2603:10b6:610:56::32)
 by SN7PR12MB6714.namprd12.prod.outlook.com (2603:10b6:806:272::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.17; Tue, 7 Jan
 2025 06:08:55 +0000
Received: from CH2PEPF0000009E.namprd02.prod.outlook.com
 (2603:10b6:610:56:cafe::7f) by CH2PR14CA0052.outlook.office365.com
 (2603:10b6:610:56::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.18 via Frontend Transport; Tue,
 7 Jan 2025 06:08:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF0000009E.mail.protection.outlook.com (10.167.244.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.7 via Frontend Transport; Tue, 7 Jan 2025 06:08:54 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 6 Jan 2025
 22:08:41 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 6 Jan 2025
 22:08:41 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Mon, 6 Jan
 2025 22:08:38 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Yevgeny Kliteynik
	<kliteyn@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 06/13] net/mlx5: fs, add HWS modify header API function
Date: Tue, 7 Jan 2025 08:07:01 +0200
Message-ID: <20250107060708.1610882-7-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009E:EE_|SN7PR12MB6714:EE_
X-MS-Office365-Filtering-Correlation-Id: 4196af44-a667-487b-da46-08dd2ee1c407
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?719SSzXQkpyJlCic/MzmaACFLlDJm+DoThlXDeji+aMzQwu3ewF51Z5/T/9l?=
 =?us-ascii?Q?2rLPuV5mtcEhgUdT+1WFFh4pW0GkmdS+KcMd94bHYMVlXFti7YtOK7eK1STa?=
 =?us-ascii?Q?cQZRIYnMK+NCYR/+6ClZCGcHFqwu59XGzF3uq8sVLScEZVnDCPzlPBDm+/Nu?=
 =?us-ascii?Q?0u1JxoEyxOy4e6QbPNdOCgcsZ7b9fjeXIhSSSlGfrwp74y9GJhwGx1mMvOZi?=
 =?us-ascii?Q?RxH1A4Acl4rxFByTZbawY0dQoIRMYkMv52yDvo1uFr61G3XiNpWcK61qUJDN?=
 =?us-ascii?Q?1oS6+GmC0g+IRIjeizRVKRXskzBXNet/XjRzLqVpkECMqVYkwWAU7hZlT8ra?=
 =?us-ascii?Q?aso7LhZ79dZxnOrNaw+hPbCDkwwXQ0DX6AAiJX2Lqwy2RlfRc0uOxpw0LjnW?=
 =?us-ascii?Q?9TpBbwGALbYnIklEiWFP4i4oXkrCnjGZqRpGAl/FWmbx5SBvVDd2ZSbwI8Sb?=
 =?us-ascii?Q?LXRN6p+1PGrHWkCebOvXbdJ27vmVRdRH5doBUgqbMahySUMb0PYfMqdnLve4?=
 =?us-ascii?Q?y1h/uFVQG7a9bU5xmlS7Uo7aVWCp80FUXz1bpwIdy2h/fZCjQ/d1mX7rU/R1?=
 =?us-ascii?Q?ApkkgXkIbYCaagPpQibw3LeK8a4ffXaXpSniXGY2IeuuRgWTOAQ7u9SJLghn?=
 =?us-ascii?Q?sDJiat5z72EGu94yllyjy0IMJiNGnFY7Qlex907raVoh96GHkdVwnqLwcR1b?=
 =?us-ascii?Q?tCIZ4WiXSG5xOVH25N/qRfVtL0DhHtXfzLsG4W+o1qlhX2nZ7o2Y4FNC37av?=
 =?us-ascii?Q?8ryLDeO8YYT2WvKthFYxUxpD9RJAD/pzDjGQCpE7P+pPjNQ3S0OmUeGa9q7+?=
 =?us-ascii?Q?m+mN0tfFavb3fmw7iwYqyl99/FO5bKeV9xOyegTQq1b3BNdXmsk7gxVO+jiN?=
 =?us-ascii?Q?xxl8q+9jVtqF7t+9AqPpnYE3NICkzRWp6di2Qhqy0RNfLNat7Knd2cI5AbRi?=
 =?us-ascii?Q?A1wCNaFRp+lknL8bJUTYTOqpVvccVejzSt6hRMZwZN9sM9yh0HomFtSYmQ33?=
 =?us-ascii?Q?7k04n2iNnF1znjmx1SUGSo2U4maiqkUAc+L2D+8O3MtH8OwcP/TVsFH++Oiz?=
 =?us-ascii?Q?pNEh1asNyN9yDksF3vLl7FghZkse4pmXNH9LeiKRyo0gTtaAbv8wi3d1L0+f?=
 =?us-ascii?Q?RbygtRJ1JQbB3PW9Esm+UbLOu4ksQX+OsyyOz/9QxdhkPhlooquOvy/8cPX2?=
 =?us-ascii?Q?3n5ePylalwAJLRGDm54d2tYxiTImrfHhJ3vQEbQWpGwfqZ0eld4Y6rAFA7Tb?=
 =?us-ascii?Q?rclRA9uk1wYIlElsP8FgRjLH20ZqKGhkfNRTT61tnQXYWkxLgjmf9ZO6D2dB?=
 =?us-ascii?Q?MfjrnLnktMYgt6x2yuWsXPuMvWDST5drsTVxT7y3n0rNLToDtEwD6OsqFqH5?=
 =?us-ascii?Q?Iu1disY1qetJkHvNeKbzG6F+90dArxSDVCRr2oYN3nJ/Nx5i3Wiq3KVTVa4S?=
 =?us-ascii?Q?2VQNI/yL29w3g58hXwljt20m7a1/hlahY8omGBfnbrRhvQ4cxLbMb3eD9cEl?=
 =?us-ascii?Q?0lL1iqXdtNuQ2IU=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 06:08:54.6284
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4196af44-a667-487b-da46-08dd2ee1c407
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6714

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
 .../mellanox/mlx5/core/steering/hws/fs_hws.c  | 117 +++++++++++++
 .../mellanox/mlx5/core/steering/hws/fs_hws.h  |   2 +
 .../mlx5/core/steering/hws/fs_hws_pools.c     | 164 ++++++++++++++++++
 .../mlx5/core/steering/hws/fs_hws_pools.h     |  22 +++
 5 files changed, 306 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h
index 9b0575a61362..06ec48f51b6d 100644
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
index 723865140b2e..a75e5ce168c7 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
@@ -14,6 +14,8 @@ static struct mlx5hws_action *
 create_action_remove_header_vlan(struct mlx5hws_context *ctx);
 static void destroy_pr_pool(struct mlx5_fs_pool *pool, struct xarray *pr_pools,
 			    unsigned long index);
+static void destroy_mh_pool(struct mlx5_fs_pool *pool, struct xarray *mh_pools,
+			    unsigned long index);
 
 static int init_hws_actions_pool(struct mlx5_core_dev *dev,
 				 struct mlx5_fs_hws_context *fs_ctx)
@@ -56,6 +58,7 @@ static int init_hws_actions_pool(struct mlx5_core_dev *dev,
 		goto cleanup_insert_hdr;
 	xa_init(&hws_pool->el2tol3tnl_pools);
 	xa_init(&hws_pool->el2tol2tnl_pools);
+	xa_init(&hws_pool->mh_pools);
 	return 0;
 
 cleanup_insert_hdr:
@@ -81,6 +84,9 @@ static void cleanup_hws_actions_pool(struct mlx5_fs_hws_context *fs_ctx)
 	struct mlx5_fs_pool *pool;
 	unsigned long i;
 
+	xa_for_each(&hws_pool->mh_pools, i, pool)
+		destroy_mh_pool(pool, &hws_pool->mh_pools, i);
+	xa_destroy(&hws_pool->mh_pools);
 	xa_for_each(&hws_pool->el2tol2tnl_pools, i, pool)
 		destroy_pr_pool(pool, &hws_pool->el2tol2tnl_pools, i);
 	xa_destroy(&hws_pool->el2tol2tnl_pools);
@@ -528,6 +534,115 @@ static void mlx5_cmd_hws_packet_reformat_dealloc(struct mlx5_flow_root_namespace
 	pkt_reformat->fs_hws_action.pr_data = NULL;
 }
 
+static struct mlx5_fs_pool *
+create_mh_pool(struct mlx5_core_dev *dev,
+	       struct mlx5hws_action_mh_pattern *pattern,
+	       struct xarray *mh_pools, unsigned long index)
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
+static void destroy_mh_pool(struct mlx5_fs_pool *pool, struct xarray *mh_pools,
+			    unsigned long index)
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
+		pool = create_mh_pool(ns->dev, &pattern, &hws_pool->mh_pools, cnt);
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
+		destroy_mh_pool(pool, &hws_pool->mh_pools, cnt);
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
@@ -537,6 +652,8 @@ static const struct mlx5_flow_cmds mlx5_flow_cmds_hws = {
 	.destroy_flow_group = mlx5_cmd_hws_destroy_flow_group,
 	.packet_reformat_alloc = mlx5_cmd_hws_packet_reformat_alloc,
 	.packet_reformat_dealloc = mlx5_cmd_hws_packet_reformat_dealloc,
+	.modify_header_alloc = mlx5_cmd_hws_modify_header_alloc,
+	.modify_header_dealloc = mlx5_cmd_hws_modify_header_dealloc,
 	.create_ns = mlx5_cmd_hws_create_ns,
 	.destroy_ns = mlx5_cmd_hws_destroy_ns,
 	.set_peer = mlx5_cmd_hws_set_peer,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.h
index 2292eb08ef24..db2d53fbf9d0 100644
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
index 14f732f3f09c..60dc0aaccbba 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws_pools.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws_pools.c
@@ -236,3 +236,167 @@ struct mlx5hws_action *mlx5_fs_hws_pr_get_action(struct mlx5_fs_hws_pr *pr_data)
 {
 	return pr_data->bulk->hws_action;
 }
+
+static struct mlx5hws_action *
+mh_bulk_action_create(struct mlx5hws_context *ctx,
+		      struct mlx5hws_action_mh_pattern *pattern)
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
+	int i;
+
+	root_ns = mlx5_get_root_namespace(dev, MLX5_FLOW_NAMESPACE_FDB);
+	if (!root_ns || root_ns->mode != MLX5_FLOW_STEERING_MODE_HMFS)
+		return NULL;
+
+	ctx = root_ns->fs_hws_context.hws_ctx;
+	if (!ctx)
+		return NULL;
+
+	if (!pool_ctx)
+		return NULL;
+	pattern = pool_ctx;
+	bulk_len = MLX5_FS_HWS_DEFAULT_BULK_LEN;
+	mh_bulk = kvzalloc(struct_size(mh_bulk, mhs_data, bulk_len), GFP_KERNEL);
+	if (!mh_bulk)
+		return NULL;
+
+	if (mlx5_fs_bulk_init(dev, &mh_bulk->fs_bulk, bulk_len))
+		goto free_mh_bulk;
+
+	for (i = 0; i < bulk_len; i++) {
+		mh_bulk->mhs_data[i].bulk = mh_bulk;
+		mh_bulk->mhs_data[i].offset = i;
+	}
+
+	mh_bulk->hws_action = mh_bulk_action_create(ctx, pattern);
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
+	for (i = 0; i < num_actions; i++)
+		if ((__force __be32)pattern->data[i] !=
+		    (__force __be32)pool_pattern->data[i])
+			return false;
+	return true;
+}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws_pools.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws_pools.h
index 93ec5b3b76fe..eda17031aef0 100644
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


