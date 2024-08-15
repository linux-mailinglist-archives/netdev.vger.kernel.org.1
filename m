Return-Path: <netdev+bounces-118730-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BFA6952952
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 08:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86DA2B24B73
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 06:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E2E178384;
	Thu, 15 Aug 2024 06:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rpb9Umpz"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DD317625E
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 06:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723703089; cv=fail; b=aXqyXsMVGMvM1nF4Ii60x9C2g4vd6DAt0RZHsauQqTiwBFj9UonOcAZeSiNNzLmzN8m7S6FfUF0VBQLkYLopCJ0kTD3IEzMLYAqzG8omOIKK6vI6TAUFz4+XwW1SRmuvMpBYrxwmIuXhCvcibj9szbRYgnT0L8dDznOFW5aATPM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723703089; c=relaxed/simple;
	bh=2jypo7DGpI8g0wA9U8X8BmO5SBEhWXsYOAXjBc5/h3Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j9GB7yGRlgyS9y6vG0dmIRCxtf8FsUUuOaqbUbjwNexR1m8C9pMuHIb575b0SdTwrQYH/fNETRAXN7CohLlFLDMGLWMIx976mbLBL0XGyuEmAwYiTSkZrajGc5IRszHge/9zCxJWg5orEv/0NmKzpnIBCvvStNVsPhGjWLbC484=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rpb9Umpz; arc=fail smtp.client-ip=40.107.93.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I8TB1fHIBRPP+1sQG3sZHATBsN1bKLW6ybtBIa4VaFlyvBqpqoWpaiv0N0XvuCOcdCkP2aqOR8bzFvBPdrlxX4uezjaUuEmNk5rZSj2xcSkudqUm4PwAayYd224fwCv5U5eb/alEFbBPLPVf0bKoTW79sJMMHHTlZJuTIzgF+togeI1k5w580SzyI9GIAsxnRXN1PmZKM/P8iFd4e0U82HB2ozcBTfx86tSoXpz9oCalUsWNcVnHkYfMeF1UeZZToZvT6IRZTcuT7CR+q+2gpH/N21RKmEUwLvX5JsFPqsse50Whh7/TOHZJqlIly3DGIGli0fR1ZgMHyKBK8sXNYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lRX3CrtQll6TLsWQLDqiZ188Kb1dwWlFcTPrC/ac9uI=;
 b=lSixnLn+St/2VNo5YQ9D96uwAMRhCkkLU2MXl3hZ0VCIPci7ThE2ltTWgdr/R2+/FFVtX9ZO5gwCwiV97viVzGJaOQrR9V56qgJDWLwV0xipLMUULGU3rxRWCr8e+V0IPb/k5qgkvCZhzatxPoZspz5tzHSadTlMyhORIulfL1vSMxycNsO1HKlsskN/uEuw60Oh87CA1RCsNslD6uYs6ii3QsCPce2C0hw66fB7+/UUGVn9zo21QSb1e5x2HcnUxy4UvfreR+ytqZcWp1DWXw5Dg2NPmRVhSzuj8k6yqZqZ+qAbCWRU4QTiqYwqOZdVxMg7kVctB/p7D67G7iqLuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lRX3CrtQll6TLsWQLDqiZ188Kb1dwWlFcTPrC/ac9uI=;
 b=rpb9UmpzcQeeq5KTT85YkGaxnHlcK0YpUvvWb18yvY+qFhJ+6u6ZMhPwaGAwFbCx3BpqsC5hzCK9nhFo3c4LL7iGHQF3Y5mI3wmtR6CloD0saaPjHGa8TZSW6TyF8B9Zgj4HcntdVquNV54iP5okegbBxzaPijaVX37hQH/BNdFrSOYGJmsd2ZLbn/wn9sbFPE2n3vfHiwgl1yD8eg//MySoob9bWl8MS/LiXrMwl4amKDgQRxf4ThmMiWSGx3SWLmATDMIvn3dX2ayy487+DxGWHUJkAtC9oqm+fN2vFKzQIM6NvLmphiWHLbV6sw0sMrbQa13ArZAh+L1RvTo74g==
Received: from BL1P222CA0030.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::35)
 by MW3PR12MB4425.namprd12.prod.outlook.com (2603:10b6:303:5e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Thu, 15 Aug
 2024 06:24:43 +0000
Received: from BN2PEPF000044AC.namprd04.prod.outlook.com
 (2603:10b6:208:2c7:cafe::76) by BL1P222CA0030.outlook.office365.com
 (2603:10b6:208:2c7::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.24 via Frontend
 Transport; Thu, 15 Aug 2024 06:24:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000044AC.mail.protection.outlook.com (10.167.243.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Thu, 15 Aug 2024 06:24:43 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 14 Aug
 2024 23:24:31 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 14 Aug
 2024 23:24:31 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Wed, 14 Aug
 2024 23:24:28 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 05/10] net/mlx5: hw counters: Don't maintain a counter count
Date: Thu, 15 Aug 2024 08:46:51 +0300
Message-ID: <20240815054656.2210494-6-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AC:EE_|MW3PR12MB4425:EE_
X-MS-Office365-Filtering-Correlation-Id: 64b1f6ca-f558-4d49-72fa-08dcbcf2f37a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ooFrEaW+ibsA0oiDYtFJkLSJauapE0FRPoFBOLvemJKdnpH4r0F54+Vv+JH6?=
 =?us-ascii?Q?FU/MBZgj52n5JDADE+p3oHLy1G2m1qsmxqUJlobLhi0AwY4ozDpNz69mIY4Y?=
 =?us-ascii?Q?mcBKou1FP32NTTZl3/4ZvhTkqZoYJ2tApJMM2scG8MaLzCeoFf6deq5Sgll9?=
 =?us-ascii?Q?vwGQ3/LkeLyRIRWNvyC6ofJbGegvcHWgTO/ZX+YP3UR+7W8afNoWYPnUXwNV?=
 =?us-ascii?Q?cOMOq8bZF+ksmpYrSZEXOvnfUbtCZSmZqBAOnrwpxdgfLu/XNB/URo9bsD7y?=
 =?us-ascii?Q?ji6LF/aQYM3io0t/VIrDFnBhxZl8Tzi9X4mabIEDOkFltO6/dQUXzFzKhUJX?=
 =?us-ascii?Q?BdoV3su3V2J8EMthpEiRMxwF0qr9yKuoD8lsW3AFcvdamh6hM/ATn5uStcil?=
 =?us-ascii?Q?Y2n1g5zCl9VB3wmaxmNauRJ3stzjLCEJpmp87LusMJsKBwvaardErUd2XR3k?=
 =?us-ascii?Q?xymwJE9ej7vWwpQu851224MzyKni4trj/q5Vo8gWBXCv6uodADwU4ide+28w?=
 =?us-ascii?Q?nJrOdC3REPPm7GwlBbiunxN8gnso919fyswbmJY83/5vTWlpg1txNyZ5Ct7d?=
 =?us-ascii?Q?xnhyJTZWGhBDsvvrHLoocIMnhpADrphFaC9Ywvp06HRz74ghrnNIYi845+eO?=
 =?us-ascii?Q?N9xtNOM+IXnhFv6CbG9b5aqWdmTluhncmkmLDlnACAT8xJyLiSmWV9OxJCcK?=
 =?us-ascii?Q?Hqg923nhCvFEUduUVGA9M2PAwbNO/hx6UFMgIxH+k2cVOkm5W+H9a+C9IGgI?=
 =?us-ascii?Q?roiTRvRDbL+LVjHI3mvCgiUfLnDTa57zjI4vdzgSSDGL6RWuN6gW882TbVFk?=
 =?us-ascii?Q?Y/cQvfsc9pp4w3wnmtkV73CBS2iLG3/eAweDcBTV68fWpxOdL+wVNiy0TS5K?=
 =?us-ascii?Q?uuJZrttBwRpfsV58JfpnVRFcZISavd2xp8NxLKy2wRLXV5tM412/fvGO7gno?=
 =?us-ascii?Q?pw3jJ/YAEVM5q8VPIwVMimcZ+4nhg86HjK1GkD2hFprfPe5RWr/KFQ9VyUHj?=
 =?us-ascii?Q?VbXcfNJ39nb6lDwOMa9UmPzassH3nJE2wrP9yu+VKvQtY7OiR51XfO1p2K1q?=
 =?us-ascii?Q?1IsxxVdsdjhzNriLlsUx3X2amWiqpibVDZAew/ItLQCfK3W7N1Sa1AqMmQQv?=
 =?us-ascii?Q?x1MRCCRQzlMK7Z6XSEh3I/MbwzSEhASA6Y1EO7JLAouZg4YtGyvVNeQNOsLZ?=
 =?us-ascii?Q?eWJfmZ4mCwQy4U8BdgQaTqv+UPcnFDHexkUjCGv/SN/TardnU40AV23x2fSz?=
 =?us-ascii?Q?DAoGicsLKh0AYwv+uo7n92gJjbvmo3fLnbjy7DBW3/yfuyKJWcDwmYLCjjWH?=
 =?us-ascii?Q?tgdwWzgNEyZHJDnQMMeFUMWxosCy9ZcrPUQg39d2luw/tKBM1dngKjJOKDep?=
 =?us-ascii?Q?eItqcfs6/Y9Hm/fb69ImiUEmM5mGfxH7avq44YL+5+6DIeKjAATRRWKHaFec?=
 =?us-ascii?Q?AE4GlMQ6dJH/pUA9WFXcUdSZgS8UeNnj?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 06:24:43.0419
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64b1f6ca-f558-4d49-72fa-08dcbcf2f37a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044AC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4425

From: Cosmin Ratiu <cratiu@nvidia.com>

num_counters is only used for deciding whether to grow the bulk query
buffer, which is done once more counters than a small initial threshold
are present. After that, maintaining num_counters serves no purpose.

This commit replaces that with an actual xarray traversal to count the
counters. This appears expensive at first sight, but is only done when
the number of counters is less than the initial threshold (8) and only
once every sampling interval. Once the number of counters goes above the
threshold, the bulk query buffer is grown to max size and the xarray
traversal is never done again.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/fs_counters.c | 40 +++++++++----------
 1 file changed, 18 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c
index ef13941e55c2..0b80c33cba5f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c
@@ -78,7 +78,6 @@ struct mlx5_fc_stats {
 	unsigned long sampling_interval; /* jiffies */
 	u32 *bulk_query_out;
 	int bulk_query_len;
-	size_t num_counters;  /* Also protected by xarray->xa_lock. */
 	bool bulk_query_alloc_failed;
 	unsigned long next_bulk_query_alloc;
 	struct mlx5_fc_pool fc_pool;
@@ -217,21 +216,28 @@ static void mlx5_fc_stats_bulk_query_buf_realloc(struct mlx5_core_dev *dev,
 		       bulk_query_len);
 }
 
+static int mlx5_fc_num_counters(struct mlx5_fc_stats *fc_stats)
+{
+	struct mlx5_fc *counter;
+	int num_counters = 0;
+	unsigned long id;
+
+	xa_for_each(&fc_stats->counters, id, counter)
+		num_counters++;
+	return num_counters;
+}
+
 static void mlx5_fc_stats_work(struct work_struct *work)
 {
 	struct mlx5_fc_stats *fc_stats = container_of(work, struct mlx5_fc_stats,
 						      work.work);
 	struct mlx5_core_dev *dev = fc_stats->fc_pool.dev;
-	int num_counters;
 
 	queue_delayed_work(fc_stats->wq, &fc_stats->work, fc_stats->sampling_interval);
 
-	/* num_counters is only needed for determining whether to increase the buffer. */
-	xa_lock(&fc_stats->counters);
-	num_counters = fc_stats->num_counters;
-	xa_unlock(&fc_stats->counters);
-	if (fc_stats->bulk_query_len < get_max_bulk_query_len(dev) &&
-	    num_counters > get_init_bulk_query_len(dev))
+	/* Grow the bulk query buffer to max if not maxed and enough counters are present. */
+	if (unlikely(fc_stats->bulk_query_len < get_max_bulk_query_len(dev) &&
+		     mlx5_fc_num_counters(fc_stats) > get_init_bulk_query_len(dev)))
 		mlx5_fc_stats_bulk_query_buf_realloc(dev, get_max_bulk_query_len(dev));
 
 	mlx5_fc_stats_query_all_counters(dev);
@@ -287,15 +293,9 @@ struct mlx5_fc *mlx5_fc_create_ex(struct mlx5_core_dev *dev, bool aging)
 		counter->lastbytes = counter->cache.bytes;
 		counter->lastpackets = counter->cache.packets;
 
-		xa_lock(&fc_stats->counters);
-
-		err = xa_err(__xa_store(&fc_stats->counters, id, counter, GFP_KERNEL));
-		if (err != 0) {
-			xa_unlock(&fc_stats->counters);
+		err = xa_err(xa_store(&fc_stats->counters, id, counter, GFP_KERNEL));
+		if (err != 0)
 			goto err_out_alloc;
-		}
-		fc_stats->num_counters++;
-		xa_unlock(&fc_stats->counters);
 	}
 
 	return counter;
@@ -324,12 +324,8 @@ void mlx5_fc_destroy(struct mlx5_core_dev *dev, struct mlx5_fc *counter)
 	if (!counter)
 		return;
 
-	if (counter->aging) {
-		xa_lock(&fc_stats->counters);
-		fc_stats->num_counters--;
-		__xa_erase(&fc_stats->counters, counter->id);
-		xa_unlock(&fc_stats->counters);
-	}
+	if (counter->aging)
+		xa_erase(&fc_stats->counters, counter->id);
 	mlx5_fc_release(dev, counter);
 }
 EXPORT_SYMBOL(mlx5_fc_destroy);
-- 
2.44.0


