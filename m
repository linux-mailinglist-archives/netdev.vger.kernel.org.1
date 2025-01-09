Return-Path: <netdev+bounces-156764-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 359DFA07CE3
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 17:07:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE5B83A7984
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 16:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E20E222068A;
	Thu,  9 Jan 2025 16:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="r+FBh6SD"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FEC3220696
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 16:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736438860; cv=fail; b=LDxlqhr6QxHD8Z7ipplmYGcKNBrHbqOEWIvXS3ffHJKhMF5C5TiFP+zg3hw5n3evrXLt49BDKepIRU0T2ZDSivsZcEQ8BDFZr9Tiq4a9SAxx4Yxw7/LIkzSbuav9ASyBSTQ0yDnpCVB+rwV8LxCwrp/bEgGjJuvsaNlvHfNTeOg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736438860; c=relaxed/simple;
	bh=nqtLsmRyPxwZiC7k53W9Pf6OwAcmuJQuvox8iSXWoSY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o10f0lNolO3RCT7u0TtocQBeucKAQDAq5Vtpur/5vn2+yJsEZOE1fmsxjFmkHGHbIcYD3Z7GZcI3v6AQZ/VbkQA3U0XzAJcr5y8eJV3Rtqu5ck0VvpLXVxLMKb2tP1pAFeqbGQqE616GFyAHh++fzpTUrszag4NsjDS0VJqXN5s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=r+FBh6SD; arc=fail smtp.client-ip=40.107.223.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m7A1pjNp6PeticPYkEmgxGfD+k6SbHmFwxcqWePlIZ/ozDGDPUOCIEzJly96KqqKg4cn8rzXb2g8V2RE4508A4MsMFNKvkyzfgd+b+RjP3K/MT5SqWpdYeGZ0nYNruRkU6L5FENaeYE6aOXZBTWPKdLYtW8VHpI75Velaih6kAvcvEJ7tJ3G7k7wLiMK4sYkZ30XGvwaRZyY+GzMHnEj30XX2hdwFBo/7L9RMfU4XFK8FZ91rhln+qskXu8247Uw3HmUuAX8wKzg4H9m4EvORoWQS5XMW0pad5AqbfkDzGYdaCMfVmHqDuvOizpmka/o8r5zUHvZJ5VxJsrE/WwdMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NkEF6qo9pPmRH0kE2mvXAKe6bmVFc/eUtiqDO1+8th4=;
 b=yfNkabZY9Z1IUhvwweU/ey0FREUFlGOacpPpthu+qzjTizU7bkGSO3TOBb1sKmvDwTa33JASyja5sDvL/A7e70MaVkvTaWuGojcMoQseom0KrvUpovw44MUYx6h9JLAATQgoRqy54XQpsja37I1DAy7Px+LpLLkugofNMH6wDMQKLlOwZ7b03sCfZhzM4D3yNkmaBQZh+veZgle69dE9Gn31haqldbGvVU0GbvVRVIRrRO7S9QguHhoQYXGZYtMHSYN5YAIq07YvTm9d+Zi8nFW4tjFu+tEAU04F3IhhZ6k7yvN1O20E67q3Gy13u+O1SycThABNuSoVx222ylWEwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NkEF6qo9pPmRH0kE2mvXAKe6bmVFc/eUtiqDO1+8th4=;
 b=r+FBh6SDN56zGLL/0d1U1jW6VwYD4HD+Tcr3/5OejoriXp1eauOdQo71JYQkkbkv05PkYBrA4SYf1Y+ilIAdeqxDZnX5gbB5DAP9mzRTZXzL2S0DP/CnbjYzFWNHAoBapKjdeUy6BQAEOwTYhfilvnzncNZik0Mfgliv51LlK2QdIZaGqjyame4FSabqFFqKNJC/Vfkzmkr8SuNqdevgZtjnnbsYYf4IlgFLMXx7rVlrcdoitew+tUdQftTOa11ZeCrUjRV63l7AwI5b78woXlWYfqjp6aYBfP0m+7g5mNhJvhFYAgZmkKqOAdAOP8I2Gk5r3Gt1apLHZRAUNP6l8g==
Received: from DM6PR07CA0118.namprd07.prod.outlook.com (2603:10b6:5:330::31)
 by BL1PR12MB5706.namprd12.prod.outlook.com (2603:10b6:208:385::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.13; Thu, 9 Jan
 2025 16:07:31 +0000
Received: from DS1PEPF00017090.namprd03.prod.outlook.com
 (2603:10b6:5:330:cafe::70) by DM6PR07CA0118.outlook.office365.com
 (2603:10b6:5:330::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.11 via Frontend Transport; Thu,
 9 Jan 2025 16:07:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF00017090.mail.protection.outlook.com (10.167.17.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.7 via Frontend Transport; Thu, 9 Jan 2025 16:07:31 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 9 Jan 2025
 08:07:18 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 9 Jan 2025
 08:07:17 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Thu, 9 Jan
 2025 08:07:14 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Yevgeny Kliteynik
	<kliteyn@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next V2 07/15] net/mlx5: fs, manage flow counters HWS action sharing by refcount
Date: Thu, 9 Jan 2025 18:05:38 +0200
Message-ID: <20250109160546.1733647-8-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017090:EE_|BL1PR12MB5706:EE_
X-MS-Office365-Filtering-Correlation-Id: aa35eb4e-7bd9-4c41-49cf-08dd30c7b91d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+qNqW7d7WQkNKeR87NqTpx59g2+Qix1sx00vY2ZcqfxyOHR2nrQ5XV3iKqL1?=
 =?us-ascii?Q?kGI4gzpi5v4UzGXgI5gKy99tJGSav2ZeKK12a07Z+2rVIVCuIq+gdY9r8BZz?=
 =?us-ascii?Q?ACK/hHMVFwDM91H8DNLufEMT0QQOJaC6Xh/V4sQcS3drhUtaDDb3CKEDBY/t?=
 =?us-ascii?Q?ta8qIq9w7ruy3y94zG+rqzKir88HooUBfMq+NvL9Ord5rk+aY9maBLKj7rJ1?=
 =?us-ascii?Q?lfTnCpsag4kWpKSf7YB6LkOwThYsx8LwgqXBRvCjArswxlGYWTXDqFJJEvGC?=
 =?us-ascii?Q?rU+ekTG5SegYVtbMBVKehifayw9W3NHFWYSGeB5azMo9wgx+EOjbVn71PX5e?=
 =?us-ascii?Q?tRktP2qIwABxS2OsbXajAU1mLA7sIve0kGBXteLArxsxvHe1krcPYc9OnCHJ?=
 =?us-ascii?Q?4AlYke33sWMUXna52rezxcv6Z9Vk6ZJUj5VeTE6deyElLRn1bIltuIdHjunB?=
 =?us-ascii?Q?yboNqYfT44LOXgG+j2eUk16Y/XB+qHQh5+pngPP+TViYH4/85B43LGCovMMJ?=
 =?us-ascii?Q?1gBCMKtlqkldKHzDpSdFscDhHqZp59wCzHaFnd87cXSiCzJZYTpuLC4pziKZ?=
 =?us-ascii?Q?g/pRGx6UmcrnuyEbC/SM9AAyQRmESzBbZvxFN0/X6F/gnDCRAZA7Fw24TQk8?=
 =?us-ascii?Q?l6O9sRDeh78OBpGVcYxEKqDphttJBhAK7kjp0mf/6bm4/Qrv/Q+WcW+PaKRo?=
 =?us-ascii?Q?z/o83Cy/zwBAwYcSk1Htm8IzO2WTVghury+q/Q4qQICrOpX9QA4eT6CHy871?=
 =?us-ascii?Q?FULDPAl7PG32LgNpgJVqy6h2SFUGk88ZSeX5+ril7OTHARU5LGYkk6J/q3Ee?=
 =?us-ascii?Q?zpkMabMDKuygIJ5yS1P3HJvFEW58tsmO+klc/wst6q9G/bZ4JRfHyRXm/8Hw?=
 =?us-ascii?Q?0bdjr4OEuGmPCGfPoPWe1IMeO2hRwTfsv4WOyrj0T4ap39BjyenzjqJu37J7?=
 =?us-ascii?Q?Le9ElUNed5edRuIFfiHpZa343VlXzfaYCX+LCm1Cb668/KTpBIM0mVvebc8X?=
 =?us-ascii?Q?IITcW7vbXBVN9skn0lpzUJ68L76fUhnPtV09kT+aK8H2N4U/dFMP1yK+Wa2/?=
 =?us-ascii?Q?1/yaBhGQVliSuWLD12YaQDmdmlB7P0udEgxCJZ7xyNUaewewrfRUEPTFhrZW?=
 =?us-ascii?Q?1BESAeNKJcWJPkNOBYUgV+j94/cuitegJspMegtq5vejjzZKC6NGE3L/4ITb?=
 =?us-ascii?Q?/PU/C3doAuokQMK9bYC85Cke0FUHQW76ermXAyamFMnZThOstiQZ6nXC5VMV?=
 =?us-ascii?Q?iazR3WO5GLnHcxo47qw5510aD3+iXe4ejuR6Eq+9YepOt5fiCtCdNHkskuUu?=
 =?us-ascii?Q?GWKojp5rMnqW693rYstDgRjMycQuITsDPoQruYQSebb7Mx4ms7Lm/3EFwVT+?=
 =?us-ascii?Q?axqA9B6BAKMx5Lsv17njEJ2GyKpTqsP3cqMyPA4zPx2u/86iqSD3QsraBbfQ?=
 =?us-ascii?Q?EGMxvbkWRRoLQMESYetOB7tZ/OyFeHT1UKrF1ljLMHeo1szZIFoGMNiMhkew?=
 =?us-ascii?Q?KxjqiYbYnVrSPLk=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 16:07:31.7401
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa35eb4e-7bd9-4c41-49cf-08dd30c7b91d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017090.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5706

From: Moshe Shemesh <moshe@nvidia.com>

Multiple flow counters can utilize a single Hardware Steering (HWS)
action for Hardware Steering rules. Given that these counter bulks are
not exclusively created for Hardware Steering, but also serve purposes
such as statistics gathering and other steering modes, it's more
efficient to create the HWS action only when it's first needed by a
Hardware Steering rule. This approach allows for better resource
management through the use of a reference count, rather than
automatically creating an HWS action for every bulk of flow counters.

Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/fs_core.h | 36 ++++++++++++++
 .../ethernet/mellanox/mlx5/core/fs_counters.c | 37 ++++-----------
 .../mlx5/core/steering/hws/fs_hws_pools.c     | 47 +++++++++++++++++++
 .../mlx5/core/steering/hws/fs_hws_pools.h     |  3 ++
 4 files changed, 94 insertions(+), 29 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h
index 5875364cef4b..1c5d687f45f0 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h
@@ -316,6 +316,42 @@ struct mlx5_flow_root_namespace {
 	const struct mlx5_flow_cmds	*cmds;
 };
 
+enum mlx5_fc_type {
+	MLX5_FC_TYPE_ACQUIRED = 0,
+	MLX5_FC_TYPE_LOCAL,
+};
+
+struct mlx5_fc_cache {
+	u64 packets;
+	u64 bytes;
+	u64 lastuse;
+};
+
+struct mlx5_fc {
+	u32 id;
+	bool aging;
+	enum mlx5_fc_type type;
+	struct mlx5_fc_bulk *bulk;
+	struct mlx5_fc_cache cache;
+	/* last{packets,bytes} are used for calculating deltas since last reading. */
+	u64 lastpackets;
+	u64 lastbytes;
+};
+
+struct mlx5_fc_bulk_hws_data {
+	struct mlx5hws_action *hws_action;
+	struct mutex lock; /* protects hws_action */
+	refcount_t hws_action_refcount;
+};
+
+struct mlx5_fc_bulk {
+	struct mlx5_fs_bulk fs_bulk;
+	u32 base_id;
+	struct mlx5_fc_bulk_hws_data hws_data;
+	struct mlx5_fc fcs[];
+};
+
+u32 mlx5_fc_get_base_id(struct mlx5_fc *counter);
 int mlx5_init_fc_stats(struct mlx5_core_dev *dev);
 void mlx5_cleanup_fc_stats(struct mlx5_core_dev *dev);
 void mlx5_fc_queue_stats_work(struct mlx5_core_dev *dev,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c
index 94d9caacd50f..492775d3d193 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c
@@ -44,28 +44,6 @@
 #define MLX5_FC_POOL_MAX_THRESHOLD BIT(18)
 #define MLX5_FC_POOL_USED_BUFF_RATIO 10
 
-enum mlx5_fc_type {
-	MLX5_FC_TYPE_ACQUIRED = 0,
-	MLX5_FC_TYPE_LOCAL,
-};
-
-struct mlx5_fc_cache {
-	u64 packets;
-	u64 bytes;
-	u64 lastuse;
-};
-
-struct mlx5_fc {
-	u32 id;
-	bool aging;
-	enum mlx5_fc_type type;
-	struct mlx5_fc_bulk *bulk;
-	struct mlx5_fc_cache cache;
-	/* last{packets,bytes} are used for calculating deltas since last reading. */
-	u64 lastpackets;
-	u64 lastbytes;
-};
-
 struct mlx5_fc_stats {
 	struct xarray counters;
 
@@ -434,13 +412,7 @@ void mlx5_fc_update_sampling_interval(struct mlx5_core_dev *dev,
 					    fc_stats->sampling_interval);
 }
 
-/* Flow counter bluks */
-
-struct mlx5_fc_bulk {
-	struct mlx5_fs_bulk fs_bulk;
-	u32 base_id;
-	struct mlx5_fc fcs[];
-};
+/* Flow counter bulks */
 
 static void mlx5_fc_init(struct mlx5_fc *counter, struct mlx5_fc_bulk *bulk,
 			 u32 id)
@@ -449,6 +421,11 @@ static void mlx5_fc_init(struct mlx5_fc *counter, struct mlx5_fc_bulk *bulk,
 	counter->id = id;
 }
 
+u32 mlx5_fc_get_base_id(struct mlx5_fc *counter)
+{
+	return counter->bulk->base_id;
+}
+
 static struct mlx5_fs_bulk *mlx5_fc_bulk_create(struct mlx5_core_dev *dev,
 						void *pool_ctx)
 {
@@ -474,6 +451,8 @@ static struct mlx5_fs_bulk *mlx5_fc_bulk_create(struct mlx5_core_dev *dev,
 	for (i = 0; i < bulk_len; i++)
 		mlx5_fc_init(&fc_bulk->fcs[i], fc_bulk, base_id + i);
 
+	refcount_set(&fc_bulk->hws_data.hws_action_refcount, 0);
+	mutex_init(&fc_bulk->hws_data.lock);
 	return &fc_bulk->fs_bulk;
 
 fs_bulk_cleanup:
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws_pools.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws_pools.c
index 2a2175b6cfc0..2ae4ac62b0e2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws_pools.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws_pools.c
@@ -401,3 +401,50 @@ bool mlx5_fs_hws_mh_pool_match(struct mlx5_fs_pool *mh_pool,
 	}
 	return true;
 }
+
+struct mlx5hws_action *mlx5_fc_get_hws_action(struct mlx5hws_context *ctx,
+					      struct mlx5_fc *counter)
+{
+	u32 flags = MLX5HWS_ACTION_FLAG_HWS_FDB | MLX5HWS_ACTION_FLAG_SHARED;
+	struct mlx5_fc_bulk *fc_bulk = counter->bulk;
+	struct mlx5_fc_bulk_hws_data *fc_bulk_hws;
+
+	fc_bulk_hws = &fc_bulk->hws_data;
+	/* try avoid locking if not necessary */
+	if (refcount_inc_not_zero(&fc_bulk_hws->hws_action_refcount))
+		return fc_bulk_hws->hws_action;
+
+	mutex_lock(&fc_bulk_hws->lock);
+	if (refcount_inc_not_zero(&fc_bulk_hws->hws_action_refcount)) {
+		mutex_unlock(&fc_bulk_hws->lock);
+		return fc_bulk_hws->hws_action;
+	}
+	fc_bulk_hws->hws_action =
+		mlx5hws_action_create_counter(ctx, fc_bulk->base_id, flags);
+	if (!fc_bulk_hws->hws_action) {
+		mutex_unlock(&fc_bulk_hws->lock);
+		return NULL;
+	}
+	refcount_set(&fc_bulk_hws->hws_action_refcount, 1);
+	mutex_unlock(&fc_bulk_hws->lock);
+
+	return fc_bulk_hws->hws_action;
+}
+
+void mlx5_fc_put_hws_action(struct mlx5_fc *counter)
+{
+	struct mlx5_fc_bulk_hws_data *fc_bulk_hws = &counter->bulk->hws_data;
+
+	/* try avoid locking if not necessary */
+	if (refcount_dec_not_one(&fc_bulk_hws->hws_action_refcount))
+		return;
+
+	mutex_lock(&fc_bulk_hws->lock);
+	if (!refcount_dec_and_test(&fc_bulk_hws->hws_action_refcount)) {
+		mutex_unlock(&fc_bulk_hws->lock);
+		return;
+	}
+	mlx5hws_action_destroy(fc_bulk_hws->hws_action);
+	fc_bulk_hws->hws_action = NULL;
+	mutex_unlock(&fc_bulk_hws->lock);
+}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws_pools.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws_pools.h
index 30157db4d40e..34072551dd21 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws_pools.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws_pools.h
@@ -67,4 +67,7 @@ void mlx5_fs_hws_mh_pool_release_mh(struct mlx5_fs_pool *mh_pool,
 				    struct mlx5_fs_hws_mh *mh_data);
 bool mlx5_fs_hws_mh_pool_match(struct mlx5_fs_pool *mh_pool,
 			       struct mlx5hws_action_mh_pattern *pattern);
+struct mlx5hws_action *mlx5_fc_get_hws_action(struct mlx5hws_context *ctx,
+					      struct mlx5_fc *counter);
+void mlx5_fc_put_hws_action(struct mlx5_fc *counter);
 #endif /* __MLX5_FS_HWS_POOLS_H__ */
-- 
2.45.0


