Return-Path: <netdev+bounces-118728-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C2395294F
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 08:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28509286E5C
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 06:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46AD177999;
	Thu, 15 Aug 2024 06:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cjpzrULs"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E730A176FD3
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 06:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723703080; cv=fail; b=Xjga2wbAQh8X6WeaDYpye7SwstRbXk627XUEvrIPPw+2+wpuV1WKu7BUYGSZhm1X12TXpyqfsognyACWh0wASXpPb8EZTFgu7o55eHwSpWJKDFSV+U0KeYuRD7B/M+7Rn11TmYFUvmxmGbcnwXLBWZ8AktWAxjcJppUYgj6aG0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723703080; c=relaxed/simple;
	bh=zNJAjF6vbYmSSRk1USAGGTROR2b9HnW6tIpddi8BBTg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BAbgz5y3qUDWUs+Qe/303md4M/PVMkGWHkCmmtJYHr0QGIIcciEUx9phKuiPbtm62CRluXbBnVbF0YER4+9Oc/YygFMGdmrZpVXmYKIoSGwT+iTehWgspXq0OyA67+MozhfxnkKrEN97reh51UA7soiPvRHs1XfQIiz3e/LOS8Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cjpzrULs; arc=fail smtp.client-ip=40.107.237.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sfRH7ZeIdEKxrQO+aWZIPudjn+FLwG95TENoxZURTwDiDt4vMPkwRlDHrIPpAWG8lUWVDaP4lN1iRrT97GFlCQrIsZLK6iA9ZsceVoeaicQReagAMQgKn/JLA/uvw2OIsqBWFFqrW520lOLsWz387rFq9+uG7HfgTu0XX7KLTp0lSItmtHQmUJpb+fZZj+U0SLBZriBI3eSeu9iZOL+uPAWVyxWaVMgaOqKwi68KCpWuLATmNd/8Isy3R6A9zgc8tgtoUZk9hcfkkNjUFzI+4iE7EdMfZWgGQYNIVhPr3flmfA3fEl8RgtNHdVN+XYDiLrUS/1JaZ3atDOJxIWYnXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DJs77ZVRAaH5RwUsIzjYHBc5goBqhixG7mpxSQv771A=;
 b=X9jzEpfZRsYUaF3R+uVFRvwoKWDhXOCwgpiyCAduUmhUjlQWpncT6DadO1mr7xreNCIabHYVNnIKhDOrD32s/nZ7ZOD3iiPzA55MIY1SWGYzIKh5ufbhH55SXAV9qAObLYZwlFsXBoUK4VrpMUAMb9bXL6lj9GiAnqikzVO9Z6hmN/4bVYcN2XYrvY3IlLfJnonhWAdFZdZg4wTBi3M3vPYk/7zzYx1Q9H93vAq53golyVCrrRunFphVpAY2VCvY22FDbVa8aiXay7L7cLoJ0bXao/p34QDViS73GaHejBZ1Q6q0F+SxKA2t6q1Pq5DnZWJYTQAMHtorNrqlVjtXYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DJs77ZVRAaH5RwUsIzjYHBc5goBqhixG7mpxSQv771A=;
 b=cjpzrULsVATQ9m1cBWACgMIcOznJ/U6oJCda90q/1SVcfGQSTurtbl8Ym2fGAC4EauLtoaPJv+J4zoDjqXgw1ctDVHzQ42GGJn1PMqeICiMiKddc1YpvreMOArWZGdeik7l7rlez1PUz6M1bPAMC2CA0l7AhU79QZ5m/UMwHWRVCax/6b6kmVaueYxrGuiZXIrs1/aZ8kF4CgThhsimwnT4C0nLWo4GS7aoZ7ROkYrB1kb2WlH+D/sFWJxLYSzumlcSetIf9tjqW350FGXlGD0X8UqRpHYGrfz3Sll8sQsCR+FqTfByQ1q+EMSZ/QYWTfe0VYl+af3c4wEth4+ve3A==
Received: from BN9PR03CA0933.namprd03.prod.outlook.com (2603:10b6:408:108::8)
 by DM6PR12MB4220.namprd12.prod.outlook.com (2603:10b6:5:21d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.17; Thu, 15 Aug
 2024 06:24:35 +0000
Received: from BN2PEPF000044A7.namprd04.prod.outlook.com
 (2603:10b6:408:108:cafe::e) by BN9PR03CA0933.outlook.office365.com
 (2603:10b6:408:108::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.33 via Frontend
 Transport; Thu, 15 Aug 2024 06:24:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000044A7.mail.protection.outlook.com (10.167.243.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Thu, 15 Aug 2024 06:24:34 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 14 Aug
 2024 23:24:21 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 14 Aug
 2024 23:24:20 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Wed, 14 Aug
 2024 23:24:18 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 02/10] net/mlx5: hw counters: Use kvmalloc for bulk query buffer
Date: Thu, 15 Aug 2024 08:46:48 +0300
Message-ID: <20240815054656.2210494-3-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A7:EE_|DM6PR12MB4220:EE_
X-MS-Office365-Filtering-Correlation-Id: 307a2cc6-1ced-4b54-2501-08dcbcf2ee6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RbXT667mVLwUnMcN/SsWXsXReS7pBBdcfXH+tQe7T8eybGRwMa4kjwFv+QSo?=
 =?us-ascii?Q?O2cFWcDMY63j78c5IYMDBWH9OT4nuSZX0cilli4Sz4boGtvH9UQQR7IKX7i7?=
 =?us-ascii?Q?gWfphG288f4gs+vCaeATN1JZskSCGkA9wSvzElSd8qIlZFgtZcU6ACaexLNp?=
 =?us-ascii?Q?xPNkipAhNyzfEgSIqxsIYYMi4j+nIbJyV62CZ5jw621isG78EGP0GW5CVmA4?=
 =?us-ascii?Q?ZYVY3GJQ8ldPJQX6+vnrCFI5auf51J03CqpEobGx7xp5L0OfkF9whlVAYPAM?=
 =?us-ascii?Q?goSkjSRWQIrnn3+yRLhS1itokZVJT1r7VpT65uAieVuGJlRJOrvOfs8fkRnw?=
 =?us-ascii?Q?xAw3gjJm/Q1Miz2RDxikxxFO9i43ZTHm/rXhJ8Sbea/a6w141Kew/NNrIowX?=
 =?us-ascii?Q?DGpbsfHtbdrqziTG0jsDwzAPVsNxOjEi6Ij7v6l6j9SvDc6NJVhF66NDrRNB?=
 =?us-ascii?Q?MPjcDVEiMGYM/JQsC2UX96RPtliSprgbBJ/VxpoUJECRX92Gdx6jqdpu0mNC?=
 =?us-ascii?Q?HI0XcLP7wHsos3GT40K204DLBhPFJG25aXklZhfXoHfToCMQm/o1bZF3zYmj?=
 =?us-ascii?Q?YvHKGzZWtWGLMA55gZ13tmLjHvCrMyKVDzx2N7LgagGpMlf98TcfMS5sgYto?=
 =?us-ascii?Q?PZvAlpbbQZkq6a4vuncoK95GhigmuFYpP75KZrfaj2U8FJcbRuFsgYLafINk?=
 =?us-ascii?Q?YnZZ/rempkLtGg3ATqAJBNR+osaEMPzw/1MWoZN+mO6KIUoEwS0E62nL4bMh?=
 =?us-ascii?Q?9Ai39/CmOVtTDB/UYLNi2qVgDq8HiFN+uDgyVxH7IEDFUBckLjrISPZSsi74?=
 =?us-ascii?Q?NrxM0FaCR2F64/C4SxVnBQ8ivE9/RAGPKJBDgXfYAXZXJAeUh9q6hf8WcDuV?=
 =?us-ascii?Q?cSZ4B/l9ki/BcXkveYgEfe8XYYVHMF00dDmIRdsTmt/xl82hJZUaRij47vbj?=
 =?us-ascii?Q?36ck7Yb6qcdhVZdd44rYNJj5GdAGZGvdp8UEchkLMfTv1S3QriaEc4sI9vPV?=
 =?us-ascii?Q?i9COEqFwyanb0sL3giqFX0j0uf1gRWzM/JR2IgZFglWwGh9S7cJRzMECqYYX?=
 =?us-ascii?Q?ndDS72j+Y99PIWRvf4eS8PNG6MNIVaI6VAaS1Y+e+BPXM5rn+jwsgP7IqxdR?=
 =?us-ascii?Q?kFuWUmEnST0mX5QdZEHG3l7ZEzZTVqCMpYKXAVEIHRxkmmQlZp1SoOfeV9rU?=
 =?us-ascii?Q?CyJL5jjmXalGIaMpP/1xzgobj8wx43x4y4GL6MBgGjJ/zeXUWN2Kk6zSF3ZW?=
 =?us-ascii?Q?01tpI9L9piNc7nLawprzkGLAct7MSOT9qymN81rm1hXi8SnlRkimunHAH2oC?=
 =?us-ascii?Q?5MR+WLvQ2oODjsLlbqnPNNH3Eng5v2siUtFA7aZF7TgZwBNxaOKib7cLVacN?=
 =?us-ascii?Q?Yv7HAQs2JthCSAsFfawI1N8ib/hQzoOSEP1Tni3daZDoLgIjpnjc0cp26fPq?=
 =?us-ascii?Q?Gb1r0nguJSyDZuARGf6yuVZW1HYTV2aL?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 06:24:34.5792
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 307a2cc6-1ced-4b54-2501-08dcbcf2ee6f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4220

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


