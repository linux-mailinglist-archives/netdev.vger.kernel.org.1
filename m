Return-Path: <netdev+bounces-130800-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54DC398B9CC
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 12:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04239282FCA
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 10:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062CC1A08BD;
	Tue,  1 Oct 2024 10:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DGx7URKj"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8C91A08B5
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 10:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727779067; cv=fail; b=ihpayATHp45zdJWeJVtx+udlB8pgNBmtyGEzwLbNlsApS8bfWJAnign9xtJusl93DRMeEnoU1r1LjBKHavw6jxmICBgZnSUX80rYlSA4qTfjRM8ZjZC2eNECJWYjKLIeURUNhVLZmh9LS1C31nUXm6G6VB/JXPFux+WavkRGcEE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727779067; c=relaxed/simple;
	bh=zNJAjF6vbYmSSRk1USAGGTROR2b9HnW6tIpddi8BBTg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rDgSBBo5yRuVe4R+pnrCy7SB8n/TJK2H1MP9IU+TK24ZAWM0tcPjdc8iQzTrvlSZAW+NaQdD2EhPzhNBkvdz1l1fvaB0jZLgbUwyvRmO7dFJMVcZ4ZK3KnV32qPFKX8CehAx627ZpV3vZ4Idfcajab9sJSgpo4ub9dmTulcxoEs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DGx7URKj; arc=fail smtp.client-ip=40.107.220.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F1kEtOsa49nMBruoBgmMR80K2G6x8YVLIH7Hr8AGgnYD26p1wte8amS1obj55PO8IFSDBEHPP/cexlPYB50cipgBb96LrSKrtwH4oELdiJVHh7VGMvfMWPNkj35rDDk74jpNGDLyoFH3cNW6RpHcN8ExXa59y2dVqwzTla337Kab6rLEsLCpUFDi1eKbhXm8DHbBhSCQrMmZRdxoSrHsMm3V6k/WBbOLeg2vu3dgr41QTcUfuNbjVeYN4fZwXCXXEnloIfsdH7WdwdjSZfjZWe0/fXBzcY8APDgvaFqHslDI5br53GBpHBjlC4+JlgUtBNp3TH4WZ8J8JEQzzDRFpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DJs77ZVRAaH5RwUsIzjYHBc5goBqhixG7mpxSQv771A=;
 b=WMZYQRIbihogt1/9SmRbvbzS0/vHcAk5Ve0s8eRZkSL2L/mExdIqiLhf1B9M8XsyCTfkHmYDRFLRXIGTCsFRuzOcVTrQki/NDdnOFzsE6I2Q/d6oFBM4XMWA5fSeYt8ZWZA4DO4CZaIAZNMEj2NTANUkUuf+0ZHpu+yaMJnw311YRwqXeUEdvCBFq9so1kTKHV222BmrM/UQp49tXetXO5ufvby86aXIl7DcvsI/nNrRukUwEWvC67tYwNLYP7TrjNNse4cvzJjrA4jrE525eEzZuohVrl19axAwMqjGxUJsmSj8G6PY+LguhBgvYVTXmxcTDqXkrvonq13Q6mlQWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DJs77ZVRAaH5RwUsIzjYHBc5goBqhixG7mpxSQv771A=;
 b=DGx7URKjuJgFNuA7rLkQiw/dgEhlBouhi6E3OQveDo2z9/MRdAmgfxViMNKd1lqt7TorGjzcDhKnAMw+pDi5nwGr74UQkAUfGBR5wBUvOgZ8QnOzgOhVHQvsaeAVw/anYyPSQV+ZvPLzNfoo2CWSkEzQIf+PIg6bDwTg54xMWTv3hemmv/wixTNMGkpdADYQOQRNeCD6vJZDbjVhziDFlotgC253u7GOx/hZiOKZw85Y5xODiU3aQih6VLNlQI31sVTcILUAUVUljshfY0UttfMJpJDSGHGjQiih6jy5lNfMSkqq8erJm2KCntDWyUw924cusA5QiINs3Bn3RiuBsg==
Received: from CH0PR07CA0019.namprd07.prod.outlook.com (2603:10b6:610:32::24)
 by SN7PR12MB7372.namprd12.prod.outlook.com (2603:10b6:806:29b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Tue, 1 Oct
 2024 10:37:43 +0000
Received: from CH2PEPF0000009D.namprd02.prod.outlook.com
 (2603:10b6:610:32:cafe::ec) by CH0PR07CA0019.outlook.office365.com
 (2603:10b6:610:32::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27 via Frontend
 Transport; Tue, 1 Oct 2024 10:37:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH2PEPF0000009D.mail.protection.outlook.com (10.167.244.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.11 via Frontend Transport; Tue, 1 Oct 2024 10:37:42 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 1 Oct 2024
 03:37:42 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 1 Oct 2024 03:37:41 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 1 Oct 2024 03:37:39 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Simon Horman
	<horms@kernel.org>, Cosmin Ratiu <cratiu@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net-next V2 2/6] net/mlx5: hw counters: Use kvmalloc for bulk query buffer
Date: Tue, 1 Oct 2024 13:37:05 +0300
Message-ID: <20241001103709.58127-3-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009D:EE_|SN7PR12MB7372:EE_
X-MS-Office365-Filtering-Correlation-Id: 364a05ac-fe95-4d4d-2f51-08dce20514af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bua8mVJtsyeRwzxc1bLI6gbbB4d8I0S+Ptmqj0EillOczuhHHKmVMSyksQht?=
 =?us-ascii?Q?Oj6Vkp8MiFUV6CqGAjRMJVdExIAcPQUm7RGR7TwfsTNslNPbX5VB8Qoy2Sgf?=
 =?us-ascii?Q?IpJ++9rxlcTzYR+cZTsRGv6hAmd9CUyNsG0cypg7Ad/+JLxDpa+pAtXkhRXD?=
 =?us-ascii?Q?Awegm7NOMO6PuyuOqXZETm1Qbyi+vsLNuW2GjmaL5ooy41+Md60fRopuaFtc?=
 =?us-ascii?Q?bgT1zK5Pqs8SuBpmyckUm1mhtJ0wJGT+uJAc7XZIbvwgO02M7LgyAYW2RTGk?=
 =?us-ascii?Q?be8l86pwajwA6aCKxYWOxCejn0nBBuKtWqsxw3bv9SVE9+UeHabvz9bzCw58?=
 =?us-ascii?Q?ldpwGGoByjF2V/ZZNVG63zh0P8Kk+Go/8aNHyv46ADNzE5tk1bMRl6Koy3Gj?=
 =?us-ascii?Q?IOYI3524vVsYNm9mAA9jqIE+wlM5Auu0XJqrC+xAIjtLxCs2Jk6c0dUswJK0?=
 =?us-ascii?Q?4TYkunVeIlLVDJ48hNfEYH2RkUD9MstIxsKEzUxWtY7EsKJsNNeCEWIy8GMM?=
 =?us-ascii?Q?UF8mcK1zWsoFRZwMFl9060ZY3Hus6cP7Iq0YkE0u4kof0PxUX6CgWWYM6pgc?=
 =?us-ascii?Q?uznQBtUPdhdwXcPUt5q3tP4Ak9F5xDKrJ+ZDjbVTDcIgTtQYXYUFzmBBpZnS?=
 =?us-ascii?Q?8IDEz9aYoqOtmf/NE7jLDE1f0b2ibhzh7DIqMGj2KEaM/jdti3UbkL+Gvo/E?=
 =?us-ascii?Q?Rw5J44IGcKVhYmTKGQR4I4vP0SkCK+DFubhzf55FfAIbA5h84xTKkjMtjU0s?=
 =?us-ascii?Q?2Ao8vJqJZm8cSzUOQ0TIN1NnH2AmlHRTeeGA/6TbkY4R61VR96bPkDsGYP2B?=
 =?us-ascii?Q?x1YcIZq14+2I4PhIlzqfLIpL+Cw+J6zTSPFtaYABMXPrz7sLYvXPcl6DwXo1?=
 =?us-ascii?Q?rM7C8uRAUJpXGRfDau3z2ihohm0w1E/NHcp3dll+8I0OWBimVdbMzsdBx0db?=
 =?us-ascii?Q?bbEBf2uS3MXSy3OMLRTT5Ah6ACUDStWquLtlUN64jp04T/an/6ptS7eiILgr?=
 =?us-ascii?Q?vlpqto6kl6kc/FnQ6koH2H5tSkZeECbaZySUtg00jGSLsnY8XI+hj8rM0rwE?=
 =?us-ascii?Q?J9hlhIhNU5gAOkkKsJXeZ1amVJnaOMVITZp+KvdusMNIuA531PJgvh3fBMB4?=
 =?us-ascii?Q?lux3UpBX37+0rT8APPsPgOjIZKTq3q3i6uEWSPt5uREO5DxlP/HkiU7piSS3?=
 =?us-ascii?Q?vt9FIpEiUxjFxYNcWC2bvG/rdAWv/tkPi8IOXKJrSl7LrBWieRjw6SsVW6CZ?=
 =?us-ascii?Q?g3h5qRMrlh2PmHqtQuECJ+U+++8+zx0meUGpiu2H/TxbjHzEgAI2H4/5346i?=
 =?us-ascii?Q?ELD+UVe7SdyEjzo0/K1jqyZbcXTgpIRWXscSzATW89N94T8XIkEtgrCcJIlm?=
 =?us-ascii?Q?wMCVUYw0D8jg+vQ3KkQwQQEKLhd2jRtVf994Obr53Cjy5VlDPGfvnxAwKew4?=
 =?us-ascii?Q?O3NnDP/djz/hiIS69GhX9Era0T0vzJRr?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 10:37:42.8256
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 364a05ac-fe95-4d4d-2f51-08dce20514af
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7372

From: Cosmin Ratiu <cratiu@nvidia.com>

The bulk query buffer starts out small (see [1]) and as soon as the
number of counters goes past the initial threshold grows to max
size (32K entries, 512KB) with a retry scheme.

This commit switches to using kvmalloc for the buffer, which has a near
zero likelihood of failing, and thus the explicit retry scheme becomes
superfluous and is taken out. On the low chance the allocation fails, it
will still be retried every sampling_interval, when the wq task runs.

[1] commit b247f32aecad ("net/mlx5: Dynamically resize flow counters
query buffer")

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/fs_counters.c | 59 +++++++------------
 1 file changed, 22 insertions(+), 37 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c
index 7d6174d0f260..9892895da9ee 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c
@@ -38,7 +38,6 @@
 #include "fs_cmd.h"
 
 #define MLX5_FC_STATS_PERIOD msecs_to_jiffies(1000)
-#define MLX5_FC_BULK_QUERY_ALLOC_PERIOD msecs_to_jiffies(180 * 1000)
 /* Max number of counters to query in bulk read is 32K */
 #define MLX5_SW_MAX_COUNTERS_BULK BIT(15)
 #define MLX5_INIT_COUNTERS_BULK 8
@@ -263,39 +262,28 @@ static void mlx5_fc_release(struct mlx5_core_dev *dev, struct mlx5_fc *counter)
 		mlx5_fc_free(dev, counter);
 }
 
-static void mlx5_fc_stats_bulk_query_size_increase(struct mlx5_core_dev *dev)
+static void mlx5_fc_stats_bulk_query_buf_realloc(struct mlx5_core_dev *dev,
+						 int bulk_query_len)
 {
 	struct mlx5_fc_stats *fc_stats = dev->priv.fc_stats;
-	int max_bulk_len = get_max_bulk_query_len(dev);
-	unsigned long now = jiffies;
 	u32 *bulk_query_out_tmp;
-	int max_out_len;
-
-	if (fc_stats->bulk_query_alloc_failed &&
-	    time_before(now, fc_stats->next_bulk_query_alloc))
-		return;
+	int out_len;
 
-	max_out_len = mlx5_cmd_fc_get_bulk_query_out_len(max_bulk_len);
-	bulk_query_out_tmp = kzalloc(max_out_len, GFP_KERNEL);
+	out_len = mlx5_cmd_fc_get_bulk_query_out_len(bulk_query_len);
+	bulk_query_out_tmp = kvzalloc(out_len, GFP_KERNEL);
 	if (!bulk_query_out_tmp) {
 		mlx5_core_warn_once(dev,
-				    "Can't increase flow counters bulk query buffer size, insufficient memory, bulk_size(%d)\n",
-				    max_bulk_len);
-		fc_stats->bulk_query_alloc_failed = true;
-		fc_stats->next_bulk_query_alloc =
-			now + MLX5_FC_BULK_QUERY_ALLOC_PERIOD;
+				    "Can't increase flow counters bulk query buffer size, alloc failed, bulk_query_len(%d)\n",
+				    bulk_query_len);
 		return;
 	}
 
-	kfree(fc_stats->bulk_query_out);
+	kvfree(fc_stats->bulk_query_out);
 	fc_stats->bulk_query_out = bulk_query_out_tmp;
-	fc_stats->bulk_query_len = max_bulk_len;
-	if (fc_stats->bulk_query_alloc_failed) {
-		mlx5_core_info(dev,
-			       "Flow counters bulk query buffer size increased, bulk_size(%d)\n",
-			       max_bulk_len);
-		fc_stats->bulk_query_alloc_failed = false;
-	}
+	fc_stats->bulk_query_len = bulk_query_len;
+	mlx5_core_info(dev,
+		       "Flow counters bulk query buffer size increased, bulk_query_len(%d)\n",
+		       bulk_query_len);
 }
 
 static void mlx5_fc_stats_work(struct work_struct *work)
@@ -327,13 +315,14 @@ static void mlx5_fc_stats_work(struct work_struct *work)
 		fc_stats->num_counters--;
 	}
 
-	if (fc_stats->bulk_query_len < get_max_bulk_query_len(dev) &&
-	    fc_stats->num_counters > get_init_bulk_query_len(dev))
-		mlx5_fc_stats_bulk_query_size_increase(dev);
-
 	if (time_before(now, fc_stats->next_query) ||
 	    list_empty(&fc_stats->counters))
 		return;
+
+	if (fc_stats->bulk_query_len < get_max_bulk_query_len(dev) &&
+	    fc_stats->num_counters > get_init_bulk_query_len(dev))
+		mlx5_fc_stats_bulk_query_buf_realloc(dev, get_max_bulk_query_len(dev));
+
 	last = list_last_entry(&fc_stats->counters, struct mlx5_fc, list);
 
 	counter = list_first_entry(&fc_stats->counters, struct mlx5_fc,
@@ -453,12 +442,11 @@ EXPORT_SYMBOL(mlx5_fc_destroy);
 int mlx5_init_fc_stats(struct mlx5_core_dev *dev)
 {
 	struct mlx5_fc_stats *fc_stats;
-	int init_bulk_len;
-	int init_out_len;
 
 	fc_stats = kzalloc(sizeof(*fc_stats), GFP_KERNEL);
 	if (!fc_stats)
 		return -ENOMEM;
+	dev->priv.fc_stats = fc_stats;
 
 	spin_lock_init(&fc_stats->counters_idr_lock);
 	idr_init(&fc_stats->counters_idr);
@@ -466,12 +454,10 @@ int mlx5_init_fc_stats(struct mlx5_core_dev *dev)
 	init_llist_head(&fc_stats->addlist);
 	init_llist_head(&fc_stats->dellist);
 
-	init_bulk_len = get_init_bulk_query_len(dev);
-	init_out_len = mlx5_cmd_fc_get_bulk_query_out_len(init_bulk_len);
-	fc_stats->bulk_query_out = kzalloc(init_out_len, GFP_KERNEL);
+	/* Allocate initial (small) bulk query buffer. */
+	mlx5_fc_stats_bulk_query_buf_realloc(dev, get_init_bulk_query_len(dev));
 	if (!fc_stats->bulk_query_out)
 		goto err_bulk;
-	fc_stats->bulk_query_len = init_bulk_len;
 
 	fc_stats->wq = create_singlethread_workqueue("mlx5_fc");
 	if (!fc_stats->wq)
@@ -481,12 +467,11 @@ int mlx5_init_fc_stats(struct mlx5_core_dev *dev)
 	INIT_DELAYED_WORK(&fc_stats->work, mlx5_fc_stats_work);
 
 	mlx5_fc_pool_init(&fc_stats->fc_pool, dev);
-	dev->priv.fc_stats = fc_stats;
 
 	return 0;
 
 err_wq_create:
-	kfree(fc_stats->bulk_query_out);
+	kvfree(fc_stats->bulk_query_out);
 err_bulk:
 	kfree(fc_stats);
 	return -ENOMEM;
@@ -512,7 +497,7 @@ void mlx5_cleanup_fc_stats(struct mlx5_core_dev *dev)
 
 	mlx5_fc_pool_cleanup(&fc_stats->fc_pool);
 	idr_destroy(&fc_stats->counters_idr);
-	kfree(fc_stats->bulk_query_out);
+	kvfree(fc_stats->bulk_query_out);
 	kfree(fc_stats);
 }
 
-- 
2.44.0


