Return-Path: <netdev+bounces-118727-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1594B95294E
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 08:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFCEC2871F8
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 06:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E12C176FA2;
	Thu, 15 Aug 2024 06:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aJAYIYpD"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2051.outbound.protection.outlook.com [40.107.93.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC947E583
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 06:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723703078; cv=fail; b=WzQn+UzmBROZ8VRZmVTKiLXmJ5q1vp5DyRb+qurLgmE3+QqIizfFqPKzfJ/guRcHCy5R9OJCRnyVK/sTLcG6Nv4kVhlkQdnRumW2JFI2n4OEQAP7fB2QMmo6JtZaa5aS2cuCbUDtlxhxI0kzZDz4sNMmeRP5MjkzjS/f5hqlm9Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723703078; c=relaxed/simple;
	bh=sWM+Lk5br32gYWKhDI4vRuDqzfgpId/QEeR3rzyJILg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FMcUQyUwqphd0IGH5Sn9InziqZDS0bdgnyE8/hdgvubeK2kN3kUI0Fmmaade+CYIQ7oS8MiMtyhOPOjB2FGYVa14bejl4SHTiRKMf/M29W8PHp84UOVZ4gYji+9GOeR+SJlPJbtjRVelU7b9pozT60LsoEqWs15Z6CcUCRTLMXc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aJAYIYpD; arc=fail smtp.client-ip=40.107.93.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qfomjaBWRmewvGVMO7wazOZIxLeA4afhdT2fOMlgJPKIPzCAFO6aoS/TCKm9PAPCT5Zn+Qc7BizWZHKvJJaRYRYlLCPGBGC6S5WFmYynW5edQqy/iSUeZtY0cK2xg8vrMHSTK1yNQ47jwPBNLGqgWPmEtRQTBCYPeRbJcGLU8YBn8d+nMT9VsbIVSE/Ejs27OIa4pHiiUeGUsbU4XcdUM6H6teoutAMgGmqIB2Y06iFrRefWEoNGm6iy8uO3p409EzZLEdzeNj0sTgx3T9pY8MNNEvNF9UaH6x4tyK80d08B8DfNJFnIRGQtmaS7K5U+MFLLen4rRKTD8/Dvvp69Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PqT7oeZR3cWGRv+y0zpRGACXh++WwM6/EtkgHpHpCcA=;
 b=fIDMbO9+78D3qEoh6wWGSw0a3Gpa71LBEZcBSyLSrhrRWfOiTT8UavJfgc1zJa+amdc+LiQ6ApdPjYQq4oH8zwKysUFTg7GoLzTEK9+jtrBR+b3j7Rmi/xtINiw+nftqiGrW53aBQfLEVPL+uVyyX5DlyA5fdSEXKIunXmDQBjztjjqka2RA1GpQxzeoEU0irjySnKP/T+gZRl9QFZNVQ2ZE++rP2eCToQOh1EHmveWEMLApV8OO9NATXcveDpfukOIHFejxbUiNQQrDRVDB7I+x7HGRZNrqU0cUzlEZZhNWj0tm2Xof/qiBERw6VTZRk87TIYI6uTyXzpLkilDlvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PqT7oeZR3cWGRv+y0zpRGACXh++WwM6/EtkgHpHpCcA=;
 b=aJAYIYpDKPtS/ULlCzxTL0Wu2S/Toc0IKYr6hojv2amFSNgncJ3QnzNMnr4NndyO9If5g45PDW+1D1f6iBP2YBlMrpyvqzUFnEKS4J4dua5PhhFp3Z19EwGO4Auk3vnqVeiRMOZmW9vZ/TeY7vXGlcH6uig83cYGxukJBHM4bnwlU8UvvMIohNdtV8elgPtCec/8ImxdtK3X5nohixgRHRmDVZPxPodiaXS5gVRa7N23177UaDJXcqpTPc1ml/U/DlIExGA7HZwCL+Dr1PNSrmPqy3Ts6616/1ugQQ+3kO4qRMkfX75LCdfjF0z4WYBGHIk3vhon+vLjpUPEj6gGZA==
Received: from BN9P221CA0029.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::27)
 by DS7PR12MB6142.namprd12.prod.outlook.com (2603:10b6:8:9a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.23; Thu, 15 Aug
 2024 06:24:31 +0000
Received: from BL6PEPF00020E65.namprd04.prod.outlook.com
 (2603:10b6:408:10a:cafe::d2) by BN9P221CA0029.outlook.office365.com
 (2603:10b6:408:10a::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.23 via Frontend
 Transport; Thu, 15 Aug 2024 06:24:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00020E65.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Thu, 15 Aug 2024 06:24:30 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 14 Aug
 2024 23:24:18 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 14 Aug
 2024 23:24:17 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Wed, 14 Aug
 2024 23:24:14 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 01/10] net/mlx5: hw counters: Make fc_stats & fc_pool private
Date: Thu, 15 Aug 2024 08:46:47 +0300
Message-ID: <20240815054656.2210494-2-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240815054656.2210494-1-tariqt@nvidia.com>
References: <20240815054656.2210494-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E65:EE_|DS7PR12MB6142:EE_
X-MS-Office365-Filtering-Correlation-Id: da9d2cbd-4c50-4c25-698b-08dcbcf2ec0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?52VSgV6hSCpZYQPl/n/URr71ur1ByARJ+Ccc8ZB2PfzzCxWg1NxpA17K6JDv?=
 =?us-ascii?Q?HLwKLz5xWT2jx5HfsC//4NDxcW2rFT6O9KuE2V9LM1y4d4gfTYvLRoIFD9oU?=
 =?us-ascii?Q?YFPH3bN3mQetIhDGx26z32HKKa+WVGK8YWXHeDlMpjB3xnmPCsRiY7XeEy+r?=
 =?us-ascii?Q?DvZtbqaXIMtWT+7lIPl+7ryoA6iqCMyPWX/SnDGt5ePdGUWDX3xLT2f9bYSe?=
 =?us-ascii?Q?t61cmzDcxKbpcO4Se/a6nHewaApn971jmH7b5qdtLkO1pPnd8/6Fa+bsBYMh?=
 =?us-ascii?Q?ex9o9Q4KZlVg0UPS7cQ6jvDAukJ2ZkejEhTpLqHRj3SxuL0ytSjHrTt8dvFn?=
 =?us-ascii?Q?opUnrcCZMmfpjEFDrFuPqCDPFd1FHjeGy+8cL1TZa37MqaXRg0zgFWQX39AJ?=
 =?us-ascii?Q?t2PjgxgIQrH+5+CiGY0x6uukPOnbfhpmhOMlNTRwaWKGFbUEgN7k9pytXTDT?=
 =?us-ascii?Q?zuezFdEZh/1MJ55F0XX0Zjg/DBFgN0Jk3c/qp+uALipDNJp3niM8h+r7GtIQ?=
 =?us-ascii?Q?rdz52EnHhCqDU1CQP8A589tZzkufTTa0bnZLe4nmpxR+jC24jz5HfhmBwo6/?=
 =?us-ascii?Q?tZRYLhKx6ht58c78f3igHE56kvDPMZsh4FjTb1nZNVtUUXTM7yIg/gcLKaCD?=
 =?us-ascii?Q?rk+RNsMEbPgYSidI4WsfbwRXL4S9zK1JagcCLI28H+p4irdqzfMhlif3T8rA?=
 =?us-ascii?Q?tFmeGC7JCkveMjL2HBR4t5U6SYh8UaguPkbweic3Xkv1e91TvcP3MKASzYw/?=
 =?us-ascii?Q?2R4b/hQKNdFQLsi8Uzh2Met1as3YTTpiFs1uBlO0YFONyDDS/HS8RldXPL7b?=
 =?us-ascii?Q?+HjvdsXVvkEtLBYb1X+tUqDHPwVhAyMWcHRtCc/hslSHhkpaDFzB2knTdX8n?=
 =?us-ascii?Q?6h5am41v1CWpKKQhjmekDYvt+Ti6uemoEjOOAbFb29Nkx3wYpi4ikevAkY65?=
 =?us-ascii?Q?xYLpyJnunqw/pDgFpBJF4SLAmJ0I7Vrrv6Ow0WLYZaI5dsGxI5E4xvEmZihh?=
 =?us-ascii?Q?xoQeukUnOHNx5CGhGZxRLg6ppTVRQMrdB6FODMhR4NbIYWI0j+0PQlHyrQEj?=
 =?us-ascii?Q?D7PI21Y1z9urZCjIpYJTzRhpM4kkkT/lQ9n7d5RYJQX3OyqLHyi4uLEdGAh1?=
 =?us-ascii?Q?ucVXA2YKM7AJNTsSmNKUyutLjX/IE3YlRqpSMPO7bdiXyxIOa/vS8eIf/N0f?=
 =?us-ascii?Q?+NznYkXf6RSh7P8ClbgbdR/Y9B5yFUle4o0KReadfbNN5SU4YINIRRZfugtM?=
 =?us-ascii?Q?q3Ll9o+hOIXo2uhIIRk4XqQCzkzdV2kqP+5Ige7efrGdLjOAaAUrkiTtJAzs?=
 =?us-ascii?Q?975HaapIs/Y/Yqo90za9hC/03VZfuUJ5zZEgHhU+Ayrg4y7KdnWqHwDlMZUG?=
 =?us-ascii?Q?I87N4ZbS1cRLsOTt9QUoZr//jzMywmt+F3WAFbSv29mOQsPhN6zrOAfsIqw8?=
 =?us-ascii?Q?0nwfbAH8kdEYJOltvwUBebBXeX9ZLmII?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 06:24:30.6433
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da9d2cbd-4c50-4c25-698b-08dcbcf2ec0f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6142

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
index 9f42834f57c5..7047df3ad204 100644
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


