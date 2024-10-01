Return-Path: <netdev+bounces-130799-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F89898B9CB
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 12:37:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8960E1C225D5
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 10:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA1911A08B8;
	Tue,  1 Oct 2024 10:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uCwi6eX9"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2076.outbound.protection.outlook.com [40.107.237.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1ECF19CC08
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 10:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727779067; cv=fail; b=ao3wklKeLTiPJO9HtSRCk2r44CxyAZC3xXBKm5r+vfjKT9lRHVUcbwx0WF0qYj1VcLhm2RYn8sz/4odNeHVgdb9sgaCO4lb2qXG8GcnnzpsUCRyevm9gj01RlW1ki6Fw5+uyh82SowjEGs6gNB/qrb7GbUU231XF/738LPIFyNM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727779067; c=relaxed/simple;
	bh=6ZEiGDNlPKvKxH5ltGrs3qN6p5kBne8z5cFSwX6sN5M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XR42lM8JRUSOypwuiMIdhccSRdAFbbETBp4inxgkYmBBQXjlSaY9b5ytq5rdvDpBGmWFQDh61NFfe50MrjM3JQBx5SpZcn3m5W/byqBSPJcDYUNs8O8Pd20T7BtrniyIEpLPBiUCv2ZXjZNdSjp6ujKTR1GfYt6C08sumg2nfTM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uCwi6eX9; arc=fail smtp.client-ip=40.107.237.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pz7wl4hKYrCBfvMQvc/KtKuGh5I15PsOs9SZVsjPPGFgEF9+HxyfJ19t0D0n9ZRhzS534JdrIPPDYBtPet0vyqMe/n2L7X7OlfNdG8SmNS+GSX2aZ34u4gaj1lAbFyzVauT4kMT67tNALhRVPBl8kL6u8Pz1qUBxD2r2DtDNlJoBSwonMZqOWzMBpheutsUEIfnnpxCbOnyV04naS4B8zWpkOvjxo9hYx6utvvKrI29sKdgfFwEyAMEa/a+LDThhuP2AVyWqorWcFX6c/SVNsBjqOmyWAmN7pcsaqbbYEIrF8Ir+jVHogb5u9XOEgr0hCeRBrKBLIm10CIbvXwOnSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kbnQoE7qCA+NyZr0UDfdueOECUFxCJWCt/ArNgBDZgU=;
 b=r2g8VJQfyYGQRxBIgKC6xh8806bmRNhb9ShiExyw1DD8Lvse0nMwIEzJk71U+0mevB4x6wLeS9COXOs1uwTcB+SIdUmVLofOrnOGRxPOr5q5t4LK1oItGha24HpCag6CHB8K9YWziFkQr+XTzzYIHnEJIPpHQk5MPJH5vDlFtWfsvtk6ulc2M4SxaFalgKo35AfriQbrGUdaTDux62lxJiUqgs1YrjyQtBxKDv+r6PDoMzjsvb1cgoSjkpMmOJg+CKC0OKZRqNXmprp1lXHaAMHtDl2vDkD65PtGXpsTfivfDqrhsnzJkyXiUiT7Gd/3EIaI12CjG6DO7f34Ssj5PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kbnQoE7qCA+NyZr0UDfdueOECUFxCJWCt/ArNgBDZgU=;
 b=uCwi6eX9oV6Lk9rkm2WmPPXCM8fT1ws2bdYVtuEuMFhqb49G0xErqKo22dw6spP2RnbebI/8ra+D56ZYlDi3FwtYVvPzZ4DP8hTWX6xY5DdoKe66+vIHaAlo9929s1ihwQoovAEjgEqmQs0WnTkCzlCfvbEOTvjQlG0q2NGrhAi9exumfWQhODha7ZaJTxcpdfTL8HifNPPoTudTUdfYSFqrJX3fr2FpFIptKYtjIlfzJrLeezFfvXHGfV5wS9XDgZ+Y3gly8qihy/PLdNYqQlnjeGojFKDXtMNrY5q0vg7sbOxlQqSaLMuYqbtn+ylMaiwZm5yOlU+p3XatMdOiBQ==
Received: from CH0PR07CA0005.namprd07.prod.outlook.com (2603:10b6:610:32::10)
 by CY8PR12MB7434.namprd12.prod.outlook.com (2603:10b6:930:52::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Tue, 1 Oct
 2024 10:37:40 +0000
Received: from CH2PEPF0000009D.namprd02.prod.outlook.com
 (2603:10b6:610:32:cafe::c0) by CH0PR07CA0005.outlook.office365.com
 (2603:10b6:610:32::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15 via Frontend
 Transport; Tue, 1 Oct 2024 10:37:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH2PEPF0000009D.mail.protection.outlook.com (10.167.244.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.11 via Frontend Transport; Tue, 1 Oct 2024 10:37:39 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 1 Oct 2024
 03:37:39 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 1 Oct 2024 03:37:38 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 1 Oct 2024 03:37:35 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Simon Horman
	<horms@kernel.org>, Cosmin Ratiu <cratiu@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net-next V2 1/6] net/mlx5: hw counters: Make fc_stats & fc_pool private
Date: Tue, 1 Oct 2024 13:37:04 +0300
Message-ID: <20241001103709.58127-2-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241001103709.58127-1-tariqt@nvidia.com>
References: <20241001103709.58127-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009D:EE_|CY8PR12MB7434:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a0a1f27-71a9-41cd-a8f4-08dce20512c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?J/W/6DmHL32asU8y5W+lWARMHW3bOs+RdF3Bul24RHPmvRtVYuEdKK0wO3SC?=
 =?us-ascii?Q?JCTAJ49QBuerXm7BZ7upMcBawJfm6Z0MADST1NEYut2JyQleLJRXqKOdKe41?=
 =?us-ascii?Q?4DLN1Io2oaSkr2A0sgXD1W/gbZJBoKm9SD4fgcLolq8qPisbb9bI+6qtF8LO?=
 =?us-ascii?Q?cEA7lytH6ea46z6TNv+gZQG9GoA0W7xF5IfSzaJZGIm5PmGUmT4lcM9EAx9F?=
 =?us-ascii?Q?vFrjSJjUqPTneteY0YkrnQu06HvX117TF3MU9RcFzA1b2WQVM9SIUOhQ3gfM?=
 =?us-ascii?Q?Cic0+e9QNpxxFEtjXqCKkCjssJFYtrsWeIllhkkwxQgGDdcZ8EaeG9fbAgek?=
 =?us-ascii?Q?LPrfEWFLDHlVS7xASofdm7qxnDK5ezGF8K1ZZ2rg3xKbpTJzIg//4aEKCzX8?=
 =?us-ascii?Q?rvQCouylfMjM9822topkRUPx+vMq2LOalsWIvnkEUnpVUCnYgx6IOQxWJNSo?=
 =?us-ascii?Q?ndLaMKtfDZZ4/eaRFsYUoOEoyK0ZoO0HjUoz6IZWX70ip6l7fbnHF223tYLU?=
 =?us-ascii?Q?U5uCG+n3SWpnHbzK6QmyWpGigD6UvZwiYz//b2br06Bs+6eGtTYT3cvVyKDk?=
 =?us-ascii?Q?X/1BPD1V2ltVmKfjG/ncvXJGtAyqGvNSO7AN/Q/n8WhMP3Hu/YQQv1YMVBPA?=
 =?us-ascii?Q?THCOJ8dOE6mTJC1BzqJPSOGkIeqJfZgBDBayaVq71wjZT11j4I8hBE3Yg+e3?=
 =?us-ascii?Q?DK/8KaPutnfN8LBO2bu5MuKg2pRrcV+lBasmqDyUIwXCBg6KZ/R9Xy3+l0KO?=
 =?us-ascii?Q?aTDHw+mZt7AG4IJqS0qcc2urIPHx3MvO3gzBfxoGbX910OvnSusRfQMISIeq?=
 =?us-ascii?Q?L0WBltRGeTYUBWdd5Cl/kHWLctDQgNuSvJwKiMu9gauu24sJbZvhQYAgl9cW?=
 =?us-ascii?Q?8YES3gj7GlK5ih8JZ02lTJ2PHnv4jvaaTrVOZjc++rX2ezFXYw/EkuMxF/fP?=
 =?us-ascii?Q?+4qn7tKPlF7ZTb0/VPa6t3D2/3MchqHNvF2RxZoQl6WNz5+2jtg8O6Ix5aSo?=
 =?us-ascii?Q?Wsxo5jIAh1X9wxTyzeAUZtWkQmM0e37msJvRu+xo/u73/oq0R5LWfXU8NR/U?=
 =?us-ascii?Q?kIuuUbyk6yeQ2f/zXC6m2BRAGD1feff5WQzgdYuyQLbf71JGOyKZ9fMj75Ib?=
 =?us-ascii?Q?ZrxbOfgv5sh/ihOSG03dAGwuYAQXwPKHVGyysSHn7xrUm3Zxg/W/AQlJUG8Q?=
 =?us-ascii?Q?zDlC0PLxJWK+MtbSaFhzg1rrN+Tj6drC4a6usoVEG1NhxA9pXjRojtYt2tg2?=
 =?us-ascii?Q?b1J6sEwljRoihrmdYWZtR3aENj3iwao38dMNV2jeZU4LQ9cgEvSOxAptH4U+?=
 =?us-ascii?Q?Nwdp8AeAcoOdzaKDHKhac+Qrem2KmaKAed4WIKKP75BkhBJMhrjeGI+cGyZ6?=
 =?us-ascii?Q?k9OuH+n0LRlVA3BvurhgiLrCABS1syCA6O2iSwHywc8gFLHyr7OXljK7RRIA?=
 =?us-ascii?Q?DuSTQWdKzmUa+ddkSmJcBRak18fTP+xJ?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 10:37:39.5757
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a0a1f27-71a9-41cd-a8f4-08dce20512c1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7434

From: Cosmin Ratiu <cratiu@nvidia.com>

The mlx5_fc_stats and mlx5_fc_pool structs are only used from
fs_counters.c. As such, make them private there.

mlx5_fc_pool is not used or referenced at all outside fs_counters.

mlx5_fc_stats is referenced from mlx5_core_dev, so instead of having it
as a direct member (which requires exporting it from fs_counters), store
a pointer to it, allocate it on init and clear it on destroy.
One caveat is that a simple container_of to get from a 'work' struct to
the outermost mlx5_core_dev struct directly no longer works, so an extra
pointer had to be added to mlx5_fc_stats back to the parent dev.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/fs_counters.c | 79 ++++++++++++++-----
 include/linux/mlx5/driver.h                   | 33 +-------
 2 files changed, 60 insertions(+), 52 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c
index 0c26d707eed2..7d6174d0f260 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c
@@ -69,6 +69,36 @@ struct mlx5_fc {
 	struct mlx5_fc_cache cache ____cacheline_aligned_in_smp;
 };
 
+struct mlx5_fc_pool {
+	struct mlx5_core_dev *dev;
+	struct mutex pool_lock; /* protects pool lists */
+	struct list_head fully_used;
+	struct list_head partially_used;
+	struct list_head unused;
+	int available_fcs;
+	int used_fcs;
+	int threshold;
+};
+
+struct mlx5_fc_stats {
+	spinlock_t counters_idr_lock; /* protects counters_idr */
+	struct idr counters_idr;
+	struct list_head counters;
+	struct llist_head addlist;
+	struct llist_head dellist;
+
+	struct workqueue_struct *wq;
+	struct delayed_work work;
+	unsigned long next_query;
+	unsigned long sampling_interval; /* jiffies */
+	u32 *bulk_query_out;
+	int bulk_query_len;
+	size_t num_counters;
+	bool bulk_query_alloc_failed;
+	unsigned long next_bulk_query_alloc;
+	struct mlx5_fc_pool fc_pool;
+};
+
 static void mlx5_fc_pool_init(struct mlx5_fc_pool *fc_pool, struct mlx5_core_dev *dev);
 static void mlx5_fc_pool_cleanup(struct mlx5_fc_pool *fc_pool);
 static struct mlx5_fc *mlx5_fc_pool_acquire_counter(struct mlx5_fc_pool *fc_pool);
@@ -109,7 +139,7 @@ static void mlx5_fc_pool_release_counter(struct mlx5_fc_pool *fc_pool, struct ml
 static struct list_head *mlx5_fc_counters_lookup_next(struct mlx5_core_dev *dev,
 						      u32 id)
 {
-	struct mlx5_fc_stats *fc_stats = &dev->priv.fc_stats;
+	struct mlx5_fc_stats *fc_stats = dev->priv.fc_stats;
 	unsigned long next_id = (unsigned long)id + 1;
 	struct mlx5_fc *counter;
 	unsigned long tmp;
@@ -137,7 +167,7 @@ static void mlx5_fc_stats_insert(struct mlx5_core_dev *dev,
 static void mlx5_fc_stats_remove(struct mlx5_core_dev *dev,
 				 struct mlx5_fc *counter)
 {
-	struct mlx5_fc_stats *fc_stats = &dev->priv.fc_stats;
+	struct mlx5_fc_stats *fc_stats = dev->priv.fc_stats;
 
 	list_del(&counter->list);
 
@@ -178,7 +208,7 @@ static void mlx5_fc_stats_query_counter_range(struct mlx5_core_dev *dev,
 					      struct mlx5_fc *first,
 					      u32 last_id)
 {
-	struct mlx5_fc_stats *fc_stats = &dev->priv.fc_stats;
+	struct mlx5_fc_stats *fc_stats = dev->priv.fc_stats;
 	bool query_more_counters = (first->id <= last_id);
 	int cur_bulk_len = fc_stats->bulk_query_len;
 	u32 *data = fc_stats->bulk_query_out;
@@ -225,7 +255,7 @@ static void mlx5_fc_free(struct mlx5_core_dev *dev, struct mlx5_fc *counter)
 
 static void mlx5_fc_release(struct mlx5_core_dev *dev, struct mlx5_fc *counter)
 {
-	struct mlx5_fc_stats *fc_stats = &dev->priv.fc_stats;
+	struct mlx5_fc_stats *fc_stats = dev->priv.fc_stats;
 
 	if (counter->bulk)
 		mlx5_fc_pool_release_counter(&fc_stats->fc_pool, counter);
@@ -235,7 +265,7 @@ static void mlx5_fc_release(struct mlx5_core_dev *dev, struct mlx5_fc *counter)
 
 static void mlx5_fc_stats_bulk_query_size_increase(struct mlx5_core_dev *dev)
 {
-	struct mlx5_fc_stats *fc_stats = &dev->priv.fc_stats;
+	struct mlx5_fc_stats *fc_stats = dev->priv.fc_stats;
 	int max_bulk_len = get_max_bulk_query_len(dev);
 	unsigned long now = jiffies;
 	u32 *bulk_query_out_tmp;
@@ -270,9 +300,9 @@ static void mlx5_fc_stats_bulk_query_size_increase(struct mlx5_core_dev *dev)
 
 static void mlx5_fc_stats_work(struct work_struct *work)
 {
-	struct mlx5_core_dev *dev = container_of(work, struct mlx5_core_dev,
-						 priv.fc_stats.work.work);
-	struct mlx5_fc_stats *fc_stats = &dev->priv.fc_stats;
+	struct mlx5_fc_stats *fc_stats = container_of(work, struct mlx5_fc_stats,
+						      work.work);
+	struct mlx5_core_dev *dev = fc_stats->fc_pool.dev;
 	/* Take dellist first to ensure that counters cannot be deleted before
 	 * they are inserted.
 	 */
@@ -334,7 +364,7 @@ static struct mlx5_fc *mlx5_fc_single_alloc(struct mlx5_core_dev *dev)
 
 static struct mlx5_fc *mlx5_fc_acquire(struct mlx5_core_dev *dev, bool aging)
 {
-	struct mlx5_fc_stats *fc_stats = &dev->priv.fc_stats;
+	struct mlx5_fc_stats *fc_stats = dev->priv.fc_stats;
 	struct mlx5_fc *counter;
 
 	if (aging && MLX5_CAP_GEN(dev, flow_counter_bulk_alloc) != 0) {
@@ -349,7 +379,7 @@ static struct mlx5_fc *mlx5_fc_acquire(struct mlx5_core_dev *dev, bool aging)
 struct mlx5_fc *mlx5_fc_create_ex(struct mlx5_core_dev *dev, bool aging)
 {
 	struct mlx5_fc *counter = mlx5_fc_acquire(dev, aging);
-	struct mlx5_fc_stats *fc_stats = &dev->priv.fc_stats;
+	struct mlx5_fc_stats *fc_stats = dev->priv.fc_stats;
 	int err;
 
 	if (IS_ERR(counter))
@@ -389,7 +419,7 @@ struct mlx5_fc *mlx5_fc_create_ex(struct mlx5_core_dev *dev, bool aging)
 struct mlx5_fc *mlx5_fc_create(struct mlx5_core_dev *dev, bool aging)
 {
 	struct mlx5_fc *counter = mlx5_fc_create_ex(dev, aging);
-	struct mlx5_fc_stats *fc_stats = &dev->priv.fc_stats;
+	struct mlx5_fc_stats *fc_stats = dev->priv.fc_stats;
 
 	if (aging)
 		mod_delayed_work(fc_stats->wq, &fc_stats->work, 0);
@@ -405,7 +435,7 @@ EXPORT_SYMBOL(mlx5_fc_id);
 
 void mlx5_fc_destroy(struct mlx5_core_dev *dev, struct mlx5_fc *counter)
 {
-	struct mlx5_fc_stats *fc_stats = &dev->priv.fc_stats;
+	struct mlx5_fc_stats *fc_stats = dev->priv.fc_stats;
 
 	if (!counter)
 		return;
@@ -422,10 +452,14 @@ EXPORT_SYMBOL(mlx5_fc_destroy);
 
 int mlx5_init_fc_stats(struct mlx5_core_dev *dev)
 {
-	struct mlx5_fc_stats *fc_stats = &dev->priv.fc_stats;
+	struct mlx5_fc_stats *fc_stats;
 	int init_bulk_len;
 	int init_out_len;
 
+	fc_stats = kzalloc(sizeof(*fc_stats), GFP_KERNEL);
+	if (!fc_stats)
+		return -ENOMEM;
+
 	spin_lock_init(&fc_stats->counters_idr_lock);
 	idr_init(&fc_stats->counters_idr);
 	INIT_LIST_HEAD(&fc_stats->counters);
@@ -436,7 +470,7 @@ int mlx5_init_fc_stats(struct mlx5_core_dev *dev)
 	init_out_len = mlx5_cmd_fc_get_bulk_query_out_len(init_bulk_len);
 	fc_stats->bulk_query_out = kzalloc(init_out_len, GFP_KERNEL);
 	if (!fc_stats->bulk_query_out)
-		return -ENOMEM;
+		goto err_bulk;
 	fc_stats->bulk_query_len = init_bulk_len;
 
 	fc_stats->wq = create_singlethread_workqueue("mlx5_fc");
@@ -447,23 +481,27 @@ int mlx5_init_fc_stats(struct mlx5_core_dev *dev)
 	INIT_DELAYED_WORK(&fc_stats->work, mlx5_fc_stats_work);
 
 	mlx5_fc_pool_init(&fc_stats->fc_pool, dev);
+	dev->priv.fc_stats = fc_stats;
+
 	return 0;
 
 err_wq_create:
 	kfree(fc_stats->bulk_query_out);
+err_bulk:
+	kfree(fc_stats);
 	return -ENOMEM;
 }
 
 void mlx5_cleanup_fc_stats(struct mlx5_core_dev *dev)
 {
-	struct mlx5_fc_stats *fc_stats = &dev->priv.fc_stats;
+	struct mlx5_fc_stats *fc_stats = dev->priv.fc_stats;
 	struct llist_node *tmplist;
 	struct mlx5_fc *counter;
 	struct mlx5_fc *tmp;
 
-	cancel_delayed_work_sync(&dev->priv.fc_stats.work);
-	destroy_workqueue(dev->priv.fc_stats.wq);
-	dev->priv.fc_stats.wq = NULL;
+	cancel_delayed_work_sync(&fc_stats->work);
+	destroy_workqueue(fc_stats->wq);
+	fc_stats->wq = NULL;
 
 	tmplist = llist_del_all(&fc_stats->addlist);
 	llist_for_each_entry_safe(counter, tmp, tmplist, addlist)
@@ -475,6 +513,7 @@ void mlx5_cleanup_fc_stats(struct mlx5_core_dev *dev)
 	mlx5_fc_pool_cleanup(&fc_stats->fc_pool);
 	idr_destroy(&fc_stats->counters_idr);
 	kfree(fc_stats->bulk_query_out);
+	kfree(fc_stats);
 }
 
 int mlx5_fc_query(struct mlx5_core_dev *dev, struct mlx5_fc *counter,
@@ -518,7 +557,7 @@ void mlx5_fc_queue_stats_work(struct mlx5_core_dev *dev,
 			      struct delayed_work *dwork,
 			      unsigned long delay)
 {
-	struct mlx5_fc_stats *fc_stats = &dev->priv.fc_stats;
+	struct mlx5_fc_stats *fc_stats = dev->priv.fc_stats;
 
 	queue_delayed_work(fc_stats->wq, dwork, delay);
 }
@@ -526,7 +565,7 @@ void mlx5_fc_queue_stats_work(struct mlx5_core_dev *dev,
 void mlx5_fc_update_sampling_interval(struct mlx5_core_dev *dev,
 				      unsigned long interval)
 {
-	struct mlx5_fc_stats *fc_stats = &dev->priv.fc_stats;
+	struct mlx5_fc_stats *fc_stats = dev->priv.fc_stats;
 
 	fc_stats->sampling_interval = min_t(unsigned long, interval,
 					    fc_stats->sampling_interval);
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index e23c692a34c7..fc7e6153b73d 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -45,7 +45,6 @@
 #include <linux/workqueue.h>
 #include <linux/mempool.h>
 #include <linux/interrupt.h>
-#include <linux/idr.h>
 #include <linux/notifier.h>
 #include <linux/refcount.h>
 #include <linux/auxiliary_bus.h>
@@ -474,36 +473,6 @@ struct mlx5_core_sriov {
 	u16			max_ec_vfs;
 };
 
-struct mlx5_fc_pool {
-	struct mlx5_core_dev *dev;
-	struct mutex pool_lock; /* protects pool lists */
-	struct list_head fully_used;
-	struct list_head partially_used;
-	struct list_head unused;
-	int available_fcs;
-	int used_fcs;
-	int threshold;
-};
-
-struct mlx5_fc_stats {
-	spinlock_t counters_idr_lock; /* protects counters_idr */
-	struct idr counters_idr;
-	struct list_head counters;
-	struct llist_head addlist;
-	struct llist_head dellist;
-
-	struct workqueue_struct *wq;
-	struct delayed_work work;
-	unsigned long next_query;
-	unsigned long sampling_interval; /* jiffies */
-	u32 *bulk_query_out;
-	int bulk_query_len;
-	size_t num_counters;
-	bool bulk_query_alloc_failed;
-	unsigned long next_bulk_query_alloc;
-	struct mlx5_fc_pool fc_pool;
-};
-
 struct mlx5_events;
 struct mlx5_mpfs;
 struct mlx5_eswitch;
@@ -630,7 +599,7 @@ struct mlx5_priv {
 	struct mlx5_devcom_comp_dev *hca_devcom_comp;
 	struct mlx5_fw_reset	*fw_reset;
 	struct mlx5_core_roce	roce;
-	struct mlx5_fc_stats		fc_stats;
+	struct mlx5_fc_stats		*fc_stats;
 	struct mlx5_rl_table            rl_table;
 	struct mlx5_ft_pool		*ft_pool;
 
-- 
2.44.0


