Return-Path: <netdev+bounces-153028-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89AF19F69A7
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 16:12:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 649C3166721
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 15:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 564BD1E9B09;
	Wed, 18 Dec 2024 15:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ivVb6Yh3"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2052.outbound.protection.outlook.com [40.107.243.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0982C1F0E32
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 15:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734534683; cv=fail; b=kpSDfsJVwGbU+uq9ZE5jSAnGC4foIHaATF4pzY1FrC0twF30kjIb8VNRddGYBwtHIxHL3J7VFQLJtjlku1LZZDVCpk3h6x3prZ0tLYSVPcUH1cKUKOb04x4OlS6DIx5qgtzs5N/n2IpvSnu5EoACG2wQ+ADVNvn2qq6wUSXsDlM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734534683; c=relaxed/simple;
	bh=QKKww8rdSqm2LWjHIyifn8ibBZuNO3Krv0vi+xoCH4I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AYuvzu2rZNQ9YVVT8Ax7QgNyCb3wkIVYRjQtcCilmJ6z8oZOTPI3mRMlcd/ENWah+1FbFrFr9vdQ+UVCqVqtBQ6y+CJztyu/oaDazXySPYo3W6xa7ly5Q0MSLl+mv7wer7YyMW+jrQoGP6A+bcapTIEMH3QT3h7w07TiUlkNiNk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ivVb6Yh3; arc=fail smtp.client-ip=40.107.243.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F4ZnF4igktSvTGjqWazfwoKukq2Xa02U7oKZnSiK4WWnAPwm6HtA2CVbQ+POIgt7VwaCj4xsxLjn/UBYnDebihYSsAFzYz8xoDuWQelE/+IPTMHKHjLFQNJIW1YRtH7xwGHLLfH+l7In8mrd8jUwTxJhytBGb14toYHKtW5C4AOCTurny8yvS9CQmMMLeZ1iufs9FrJddm0cqUNOCyU+HREwfO+rC+8EXNcL17ckjnqMARQSzcNzNc+YvYATz2XRoEVm5TYtrUHaDC8iF7sWHIqH9hwIqWOAyjO23XJ4519KyM4ko6+TnoHGsWsQWHa+jV3hcuRzHV/OK4y81Cj7+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cICAP92EcChnFYoa0r9J3h/hy2kSNkyZBT9BTGAuZls=;
 b=jdCZrU1Yep+H3KNdpyiuCykCUoBa0X8dNJ7pVkgv62PGjAlbunyGucOiuzWE9+vE4Erw9YGR9OTsPcBDwxe/nebvCU/Rt4Ug0yfo6MxtUP+AienRvdQCGDCEEZ7mCP78Ml80tBn9rhbbAYZEmwPqlbtn8p9kfyI6YhRPkV0QhSEUt+Bjn0P/8JEkXajYQiGKHZkgeRH0NCo37Qy2ajpsTv9w5y+ZlOjxXFtVilePRqGoxfgtg1zTsMLLmGWEmqj0131LXTMtiM1uGR2rp3zY1Ow7zDecpWwv6KfvB3PtVY8C/E+vYxeQAdR6p9HCQEXJ+mHalnjenu9VrP6OFP0+DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cICAP92EcChnFYoa0r9J3h/hy2kSNkyZBT9BTGAuZls=;
 b=ivVb6Yh3ChBgh5QE9SqvfaqbqxXPAcn8LbCjlQDMj9eIvgK+h2PGTJ2d6MR/mWPkiiv9xIJG5I14kmsKiwvsLslKPyEBMV+Uh6mQXiqcjpUawzxFAgIb3ZTNXguCerSJ3WJV81GNv/TUoLXrZiVDjO+D8mFEWDU2LmEZExc+enJFQCy5Bh/4mvqXO0t3T6Y1mRg63fi2v5tKoQ/so5dfsVyEKUPEAX1E69Z4xyx9hOmSByMKXDHZS684Jx65xfoi0LbJUk+hc0bYhLkPN+LEXYSbypZQtP7UKoHdXMlzMPdyJVfYRMHFFJV/i10EIPZ1r46rrmfWxWqQoM10OZ/jdA==
Received: from BN9PR03CA0268.namprd03.prod.outlook.com (2603:10b6:408:ff::33)
 by DM4PR12MB6400.namprd12.prod.outlook.com (2603:10b6:8:b9::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.20; Wed, 18 Dec 2024 15:11:16 +0000
Received: from BL6PEPF0001AB73.namprd02.prod.outlook.com
 (2603:10b6:408:ff:cafe::68) by BN9PR03CA0268.outlook.office365.com
 (2603:10b6:408:ff::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.22 via Frontend Transport; Wed,
 18 Dec 2024 15:11:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB73.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15 via Frontend Transport; Wed, 18 Dec 2024 15:11:14 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 18 Dec
 2024 07:10:53 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 18 Dec
 2024 07:10:53 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Wed, 18 Dec
 2024 07:10:50 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Yevgeny Kliteynik
	<kliteyn@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next V3 04/11] net/mlx5: fs, add mlx5_fs_pool API
Date: Wed, 18 Dec 2024 17:09:42 +0200
Message-ID: <20241218150949.1037752-5-tariqt@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241218150949.1037752-1-tariqt@nvidia.com>
References: <20241218150949.1037752-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB73:EE_|DM4PR12MB6400:EE_
X-MS-Office365-Filtering-Correlation-Id: f1d9ab67-9467-48e8-b0e9-08dd1f763733
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cvogbQ/1wS/GCG8TGORtJQ7YcdsPb2ywBsLWuS3LDGjGB9WyUE0mHzEZ+g32?=
 =?us-ascii?Q?59hOUPSEaEMzE0TfdxOJbgYyDPgAKcRjw2e8Jco+sBWOpf5Js31pr6x8qbgJ?=
 =?us-ascii?Q?5sd3scO6VwkGRmHelrUbNfAbxEPWuwLMZYZpINUY8B98xFRaZ5y9aCQNXA54?=
 =?us-ascii?Q?caJ+zSN/DOUA9BYWiOU6sJX8qdDxe+0rVCGjALiwT3+P2bQJdksZEoCRcrSy?=
 =?us-ascii?Q?my0bNx/yMd0GSfUgZ7m5pmzohqtstBzKrtd5fZy/bJEyaUYUT8EvaNMy83zq?=
 =?us-ascii?Q?+qs7QQBl6s0sfpb4EBZL0pmcupn5xicZJ57LDrkHKay/vG8JmiFjwGAz45iG?=
 =?us-ascii?Q?Uz8PuT49SbOa3voPSjZxbTADHDFRx3QEJVEmMeZYbey1UDcgHYB7d6leuUdp?=
 =?us-ascii?Q?xwWUcuTz45tOspGFPFbVpgb76FWKnXM+E2UnrhjgllWQx9ouQNL0uTsbmaoR?=
 =?us-ascii?Q?YOLkmw1OR6/kpWCdoXnZtbPWe9NYkaN1Gm6dSYuR8k4gI8zcqBt7bdHKi7o5?=
 =?us-ascii?Q?pgXYLRMbs5QvhRXyNYXM1MToi0Yc0LSDL6ClX4IyNwoYZzyGZb4pvgHAOpkM?=
 =?us-ascii?Q?/wjCiisf3Y6YIgdZWvNZnxWGddqqerybXJlvfYmN6F9vfiaobR+k3Hzqe0P8?=
 =?us-ascii?Q?4GvjrW2tSWRGMH7bZGCRWOnCrSqpOTXD59tvQLc3tEtChQ4YYsJ0nWACIMBw?=
 =?us-ascii?Q?daGJyBTm37t144/cHdompeuybHgkxvaVy+brltic68teAXsaRYq97Ea/oJYY?=
 =?us-ascii?Q?bggitEBA088KCvcGxCigneKCCOP8SkQFYb4rheViZFF49f3+5hgK88SZeOF8?=
 =?us-ascii?Q?kiQaTHW7AHhG1dEHVO7fH9V1FTr/beJEOPKu2aep0FcChfn8mG+qAP7dPT20?=
 =?us-ascii?Q?TVK0t7rVQIJbtTpQg2OpTIUapxgRPbofX+5uo+GL65hx/xNUuoNPm1hZnZzI?=
 =?us-ascii?Q?dyHWHi+eha5Ws4oFUyGaII0Nre8QptqOCNRrBw0YJsueYWZ1zUNQAbyou5SU?=
 =?us-ascii?Q?LJBQd4Qd/sGtt/kjQfpwJWRu8Ak5zpkIxToqMVGoRBI7k6sp4VCiJUrvVFpO?=
 =?us-ascii?Q?f3ODox4IZw3WuRJQ02OOgIh0lzwzde4VlMC90OqatCb/QZjDCPyEDIisWUKp?=
 =?us-ascii?Q?d76BRf5wjekSOy3cfAKWxskUj9bZCKwxlGsmHYBFxMJWcZO2sNqATH4MbANn?=
 =?us-ascii?Q?wQVD1RD0QBHYkeEYFjC8BDNixrS2gSJeKKr5ziItmVmjEKM4VfvcGwkNtpic?=
 =?us-ascii?Q?FwwS7hGDKbKDTZMFSi6M0O925RAaDb+g6UIe501Mgm4/yPI5cmzX7zYFgiIc?=
 =?us-ascii?Q?F5jKeS1rPtej0IvTFbZLPulBGVQ8jDgWQ8Fug3SWn0wXQFiQk7RpMNRO5fyM?=
 =?us-ascii?Q?UC2EShegKXFwHEIdaqO9ih3YclHhhvgMtyVOQ7mAps+BCnmjcifTTu6/NPoF?=
 =?us-ascii?Q?WY8xOfFVKhCOTDocRn/2b9siRW49khZFMgVM87vgvVGSJA4jyuxFaSORhyXp?=
 =?us-ascii?Q?yI+M15SBgy1OmQw=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2024 15:11:14.6402
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1d9ab67-9467-48e8-b0e9-08dd1f763733
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB73.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6400

From: Moshe Shemesh <moshe@nvidia.com>

Refactor fc_pool API to create generic fs_pool API, as HW steering has
more flow steering elements which can take advantage of the same pool of
bulks API. Change fs_counters code to use the fs_pool API.

Note, removed __counted_by from struct mlx5_fc_bulk as bulk_len is now
inner struct member. It will be added back once __counted_by can support
inner struct members.

Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/Makefile  |   2 +-
 .../ethernet/mellanox/mlx5/core/fs_counters.c | 294 +++++-------------
 .../net/ethernet/mellanox/mlx5/core/fs_pool.c | 194 ++++++++++++
 .../net/ethernet/mellanox/mlx5/core/fs_pool.h |  54 ++++
 4 files changed, 331 insertions(+), 213 deletions(-)
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/fs_pool.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/fs_pool.h

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/Makefile b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
index be3d0876c521..79fe09de0a9f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/Makefile
+++ b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
@@ -17,7 +17,7 @@ mlx5_core-y :=	main.o cmd.o debugfs.o fw.o eq.o uar.o pagealloc.o \
 		fs_counters.o fs_ft_pool.o rl.o lag/debugfs.o lag/lag.o dev.o events.o wq.o lib/gid.o \
 		lib/devcom.o lib/pci_vsc.o lib/dm.o lib/fs_ttc.o diag/fs_tracepoint.o \
 		diag/fw_tracer.o diag/crdump.o devlink.o diag/rsc_dump.o diag/reporter_vnic.o \
-		fw_reset.o qos.o lib/tout.o lib/aso.o wc.o
+		fw_reset.o qos.o lib/tout.o lib/aso.o wc.o fs_pool.o
 
 #
 # Netdev basic
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c
index e95488ed1547..a693c5c792b3 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c
@@ -34,6 +34,7 @@
 #include <linux/mlx5/fs.h>
 #include "mlx5_core.h"
 #include "fs_core.h"
+#include "fs_pool.h"
 #include "fs_cmd.h"
 
 #define MLX5_FC_STATS_PERIOD msecs_to_jiffies(1000)
@@ -65,17 +66,6 @@ struct mlx5_fc {
 	u64 lastbytes;
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
 struct mlx5_fc_stats {
 	struct xarray counters;
 
@@ -86,13 +76,13 @@ struct mlx5_fc_stats {
 	int bulk_query_len;
 	bool bulk_query_alloc_failed;
 	unsigned long next_bulk_query_alloc;
-	struct mlx5_fc_pool fc_pool;
+	struct mlx5_fs_pool fc_pool;
 };
 
-static void mlx5_fc_pool_init(struct mlx5_fc_pool *fc_pool, struct mlx5_core_dev *dev);
-static void mlx5_fc_pool_cleanup(struct mlx5_fc_pool *fc_pool);
-static struct mlx5_fc *mlx5_fc_pool_acquire_counter(struct mlx5_fc_pool *fc_pool);
-static void mlx5_fc_pool_release_counter(struct mlx5_fc_pool *fc_pool, struct mlx5_fc *fc);
+static void mlx5_fc_pool_init(struct mlx5_fs_pool *fc_pool, struct mlx5_core_dev *dev);
+static void mlx5_fc_pool_cleanup(struct mlx5_fs_pool *fc_pool);
+static struct mlx5_fc *mlx5_fc_pool_acquire_counter(struct mlx5_fs_pool *fc_pool);
+static void mlx5_fc_pool_release_counter(struct mlx5_fs_pool *fc_pool, struct mlx5_fc *fc);
 
 static int get_init_bulk_query_len(struct mlx5_core_dev *dev)
 {
@@ -447,11 +437,9 @@ void mlx5_fc_update_sampling_interval(struct mlx5_core_dev *dev,
 /* Flow counter bluks */
 
 struct mlx5_fc_bulk {
-	struct list_head pool_list;
+	struct mlx5_fs_bulk fs_bulk;
 	u32 base_id;
-	int bulk_len;
-	unsigned long *bitmask;
-	struct mlx5_fc fcs[] __counted_by(bulk_len);
+	struct mlx5_fc fcs[];
 };
 
 static void mlx5_fc_init(struct mlx5_fc *counter, struct mlx5_fc_bulk *bulk,
@@ -461,16 +449,10 @@ static void mlx5_fc_init(struct mlx5_fc *counter, struct mlx5_fc_bulk *bulk,
 	counter->id = id;
 }
 
-static int mlx5_fc_bulk_get_free_fcs_amount(struct mlx5_fc_bulk *bulk)
-{
-	return bitmap_weight(bulk->bitmask, bulk->bulk_len);
-}
-
-static struct mlx5_fc_bulk *mlx5_fc_bulk_create(struct mlx5_core_dev *dev)
+static struct mlx5_fs_bulk *mlx5_fc_bulk_create(struct mlx5_core_dev *dev)
 {
 	enum mlx5_fc_bulk_alloc_bitmask alloc_bitmask;
-	struct mlx5_fc_bulk *bulk;
-	int err = -ENOMEM;
+	struct mlx5_fc_bulk *fc_bulk;
 	int bulk_len;
 	u32 base_id;
 	int i;
@@ -478,71 +460,97 @@ static struct mlx5_fc_bulk *mlx5_fc_bulk_create(struct mlx5_core_dev *dev)
 	alloc_bitmask = MLX5_CAP_GEN(dev, flow_counter_bulk_alloc);
 	bulk_len = alloc_bitmask > 0 ? MLX5_FC_BULK_NUM_FCS(alloc_bitmask) : 1;
 
-	bulk = kvzalloc(struct_size(bulk, fcs, bulk_len), GFP_KERNEL);
-	if (!bulk)
-		goto err_alloc_bulk;
+	fc_bulk = kvzalloc(struct_size(fc_bulk, fcs, bulk_len), GFP_KERNEL);
+	if (!fc_bulk)
+		return NULL;
 
-	bulk->bitmask = kvcalloc(BITS_TO_LONGS(bulk_len), sizeof(unsigned long),
-				 GFP_KERNEL);
-	if (!bulk->bitmask)
-		goto err_alloc_bitmask;
+	if (mlx5_fs_bulk_init(dev, &fc_bulk->fs_bulk, bulk_len))
+		goto err_fs_bulk_init;
 
-	err = mlx5_cmd_fc_bulk_alloc(dev, alloc_bitmask, &base_id);
-	if (err)
-		goto err_mlx5_cmd_bulk_alloc;
+	if (mlx5_cmd_fc_bulk_alloc(dev, alloc_bitmask, &base_id))
+		goto err_cmd_bulk_alloc;
+	fc_bulk->base_id = base_id;
+	for (i = 0; i < bulk_len; i++)
+		mlx5_fc_init(&fc_bulk->fcs[i], fc_bulk, base_id + i);
 
-	bulk->base_id = base_id;
-	bulk->bulk_len = bulk_len;
-	for (i = 0; i < bulk_len; i++) {
-		mlx5_fc_init(&bulk->fcs[i], bulk, base_id + i);
-		set_bit(i, bulk->bitmask);
-	}
+	return &fc_bulk->fs_bulk;
 
-	return bulk;
-
-err_mlx5_cmd_bulk_alloc:
-	kvfree(bulk->bitmask);
-err_alloc_bitmask:
-	kvfree(bulk);
-err_alloc_bulk:
-	return ERR_PTR(err);
+err_cmd_bulk_alloc:
+	mlx5_fs_bulk_cleanup(&fc_bulk->fs_bulk);
+err_fs_bulk_init:
+	kvfree(fc_bulk);
+	return NULL;
 }
 
 static int
-mlx5_fc_bulk_destroy(struct mlx5_core_dev *dev, struct mlx5_fc_bulk *bulk)
+mlx5_fc_bulk_destroy(struct mlx5_core_dev *dev, struct mlx5_fs_bulk *fs_bulk)
 {
-	if (mlx5_fc_bulk_get_free_fcs_amount(bulk) < bulk->bulk_len) {
+	struct mlx5_fc_bulk *fc_bulk = container_of(fs_bulk,
+						    struct mlx5_fc_bulk,
+						    fs_bulk);
+
+	if (mlx5_fs_bulk_get_free_amount(fs_bulk) < fs_bulk->bulk_len) {
 		mlx5_core_err(dev, "Freeing bulk before all counters were released\n");
 		return -EBUSY;
 	}
 
-	mlx5_cmd_fc_free(dev, bulk->base_id);
-	kvfree(bulk->bitmask);
-	kvfree(bulk);
+	mlx5_cmd_fc_free(dev, fc_bulk->base_id);
+	mlx5_fs_bulk_cleanup(fs_bulk);
+	kvfree(fc_bulk);
 
 	return 0;
 }
 
-static struct mlx5_fc *mlx5_fc_bulk_acquire_fc(struct mlx5_fc_bulk *bulk)
+static void mlx5_fc_pool_update_threshold(struct mlx5_fs_pool *fc_pool)
 {
-	int free_fc_index = find_first_bit(bulk->bitmask, bulk->bulk_len);
+	fc_pool->threshold = min_t(int, MLX5_FC_POOL_MAX_THRESHOLD,
+				   fc_pool->used_units / MLX5_FC_POOL_USED_BUFF_RATIO);
+}
 
-	if (free_fc_index >= bulk->bulk_len)
-		return ERR_PTR(-ENOSPC);
+/* Flow counters pool API */
+
+static const struct mlx5_fs_pool_ops mlx5_fc_pool_ops = {
+	.bulk_destroy = mlx5_fc_bulk_destroy,
+	.bulk_create = mlx5_fc_bulk_create,
+	.update_threshold = mlx5_fc_pool_update_threshold,
+};
 
-	clear_bit(free_fc_index, bulk->bitmask);
-	return &bulk->fcs[free_fc_index];
+static void
+mlx5_fc_pool_init(struct mlx5_fs_pool *fc_pool, struct mlx5_core_dev *dev)
+{
+	mlx5_fs_pool_init(fc_pool, dev, &mlx5_fc_pool_ops);
 }
 
-static int mlx5_fc_bulk_release_fc(struct mlx5_fc_bulk *bulk, struct mlx5_fc *fc)
+static void mlx5_fc_pool_cleanup(struct mlx5_fs_pool *fc_pool)
 {
-	int fc_index = fc->id - bulk->base_id;
+	mlx5_fs_pool_cleanup(fc_pool);
+}
 
-	if (test_bit(fc_index, bulk->bitmask))
-		return -EINVAL;
+static struct mlx5_fc *
+mlx5_fc_pool_acquire_counter(struct mlx5_fs_pool *fc_pool)
+{
+	struct mlx5_fs_pool_index pool_index = {};
+	struct mlx5_fc_bulk *fc_bulk;
+	int err;
 
-	set_bit(fc_index, bulk->bitmask);
-	return 0;
+	err = mlx5_fs_pool_acquire_index(fc_pool, &pool_index);
+	if (err)
+		return ERR_PTR(err);
+	fc_bulk = container_of(pool_index.fs_bulk, struct mlx5_fc_bulk, fs_bulk);
+	return &fc_bulk->fcs[pool_index.index];
+}
+
+static void
+mlx5_fc_pool_release_counter(struct mlx5_fs_pool *fc_pool, struct mlx5_fc *fc)
+{
+	struct mlx5_fs_bulk *fs_bulk = &fc->bulk->fs_bulk;
+	struct mlx5_fs_pool_index pool_index = {};
+	struct mlx5_core_dev *dev = fc_pool->dev;
+
+	pool_index.fs_bulk = fs_bulk;
+	pool_index.index = fc->id - fc->bulk->base_id;
+	if (mlx5_fs_pool_release_index(fc_pool, &pool_index))
+		mlx5_core_warn(dev, "Attempted to release a counter which is not acquired\n");
 }
 
 /**
@@ -558,22 +566,22 @@ static int mlx5_fc_bulk_release_fc(struct mlx5_fc_bulk *bulk, struct mlx5_fc *fc
 struct mlx5_fc *
 mlx5_fc_local_create(u32 counter_id, u32 offset, u32 bulk_size)
 {
-	struct mlx5_fc_bulk *bulk;
+	struct mlx5_fc_bulk *fc_bulk;
 	struct mlx5_fc *counter;
 
 	counter = kzalloc(sizeof(*counter), GFP_KERNEL);
 	if (!counter)
 		return ERR_PTR(-ENOMEM);
-	bulk = kzalloc(sizeof(*bulk), GFP_KERNEL);
-	if (!bulk) {
+	fc_bulk = kzalloc(sizeof(*fc_bulk), GFP_KERNEL);
+	if (!fc_bulk) {
 		kfree(counter);
 		return ERR_PTR(-ENOMEM);
 	}
 
 	counter->type = MLX5_FC_TYPE_LOCAL;
 	counter->id = counter_id;
-	bulk->base_id = counter_id - offset;
-	bulk->bulk_len = bulk_size;
+	fc_bulk->base_id = counter_id - offset;
+	fc_bulk->fs_bulk.bulk_len = bulk_size;
 	return counter;
 }
 EXPORT_SYMBOL(mlx5_fc_local_create);
@@ -587,141 +595,3 @@ void mlx5_fc_local_destroy(struct mlx5_fc *counter)
 	kfree(counter);
 }
 EXPORT_SYMBOL(mlx5_fc_local_destroy);
-
-/* Flow counters pool API */
-
-static void mlx5_fc_pool_init(struct mlx5_fc_pool *fc_pool, struct mlx5_core_dev *dev)
-{
-	fc_pool->dev = dev;
-	mutex_init(&fc_pool->pool_lock);
-	INIT_LIST_HEAD(&fc_pool->fully_used);
-	INIT_LIST_HEAD(&fc_pool->partially_used);
-	INIT_LIST_HEAD(&fc_pool->unused);
-	fc_pool->available_fcs = 0;
-	fc_pool->used_fcs = 0;
-	fc_pool->threshold = 0;
-}
-
-static void mlx5_fc_pool_cleanup(struct mlx5_fc_pool *fc_pool)
-{
-	struct mlx5_core_dev *dev = fc_pool->dev;
-	struct mlx5_fc_bulk *bulk;
-	struct mlx5_fc_bulk *tmp;
-
-	list_for_each_entry_safe(bulk, tmp, &fc_pool->fully_used, pool_list)
-		mlx5_fc_bulk_destroy(dev, bulk);
-	list_for_each_entry_safe(bulk, tmp, &fc_pool->partially_used, pool_list)
-		mlx5_fc_bulk_destroy(dev, bulk);
-	list_for_each_entry_safe(bulk, tmp, &fc_pool->unused, pool_list)
-		mlx5_fc_bulk_destroy(dev, bulk);
-}
-
-static void mlx5_fc_pool_update_threshold(struct mlx5_fc_pool *fc_pool)
-{
-	fc_pool->threshold = min_t(int, MLX5_FC_POOL_MAX_THRESHOLD,
-				   fc_pool->used_fcs / MLX5_FC_POOL_USED_BUFF_RATIO);
-}
-
-static struct mlx5_fc_bulk *
-mlx5_fc_pool_alloc_new_bulk(struct mlx5_fc_pool *fc_pool)
-{
-	struct mlx5_core_dev *dev = fc_pool->dev;
-	struct mlx5_fc_bulk *new_bulk;
-
-	new_bulk = mlx5_fc_bulk_create(dev);
-	if (!IS_ERR(new_bulk))
-		fc_pool->available_fcs += new_bulk->bulk_len;
-	mlx5_fc_pool_update_threshold(fc_pool);
-	return new_bulk;
-}
-
-static void
-mlx5_fc_pool_free_bulk(struct mlx5_fc_pool *fc_pool, struct mlx5_fc_bulk *bulk)
-{
-	struct mlx5_core_dev *dev = fc_pool->dev;
-
-	fc_pool->available_fcs -= bulk->bulk_len;
-	mlx5_fc_bulk_destroy(dev, bulk);
-	mlx5_fc_pool_update_threshold(fc_pool);
-}
-
-static struct mlx5_fc *
-mlx5_fc_pool_acquire_from_list(struct list_head *src_list,
-			       struct list_head *next_list,
-			       bool move_non_full_bulk)
-{
-	struct mlx5_fc_bulk *bulk;
-	struct mlx5_fc *fc;
-
-	if (list_empty(src_list))
-		return ERR_PTR(-ENODATA);
-
-	bulk = list_first_entry(src_list, struct mlx5_fc_bulk, pool_list);
-	fc = mlx5_fc_bulk_acquire_fc(bulk);
-	if (move_non_full_bulk || mlx5_fc_bulk_get_free_fcs_amount(bulk) == 0)
-		list_move(&bulk->pool_list, next_list);
-	return fc;
-}
-
-static struct mlx5_fc *
-mlx5_fc_pool_acquire_counter(struct mlx5_fc_pool *fc_pool)
-{
-	struct mlx5_fc_bulk *new_bulk;
-	struct mlx5_fc *fc;
-
-	mutex_lock(&fc_pool->pool_lock);
-
-	fc = mlx5_fc_pool_acquire_from_list(&fc_pool->partially_used,
-					    &fc_pool->fully_used, false);
-	if (IS_ERR(fc))
-		fc = mlx5_fc_pool_acquire_from_list(&fc_pool->unused,
-						    &fc_pool->partially_used,
-						    true);
-	if (IS_ERR(fc)) {
-		new_bulk = mlx5_fc_pool_alloc_new_bulk(fc_pool);
-		if (IS_ERR(new_bulk)) {
-			fc = ERR_CAST(new_bulk);
-			goto out;
-		}
-		fc = mlx5_fc_bulk_acquire_fc(new_bulk);
-		list_add(&new_bulk->pool_list, &fc_pool->partially_used);
-	}
-	fc_pool->available_fcs--;
-	fc_pool->used_fcs++;
-
-out:
-	mutex_unlock(&fc_pool->pool_lock);
-	return fc;
-}
-
-static void
-mlx5_fc_pool_release_counter(struct mlx5_fc_pool *fc_pool, struct mlx5_fc *fc)
-{
-	struct mlx5_core_dev *dev = fc_pool->dev;
-	struct mlx5_fc_bulk *bulk = fc->bulk;
-	int bulk_free_fcs_amount;
-
-	mutex_lock(&fc_pool->pool_lock);
-
-	if (mlx5_fc_bulk_release_fc(bulk, fc)) {
-		mlx5_core_warn(dev, "Attempted to release a counter which is not acquired\n");
-		goto unlock;
-	}
-
-	fc_pool->available_fcs++;
-	fc_pool->used_fcs--;
-
-	bulk_free_fcs_amount = mlx5_fc_bulk_get_free_fcs_amount(bulk);
-	if (bulk_free_fcs_amount == 1)
-		list_move_tail(&bulk->pool_list, &fc_pool->partially_used);
-	if (bulk_free_fcs_amount == bulk->bulk_len) {
-		list_del(&bulk->pool_list);
-		if (fc_pool->available_fcs > fc_pool->threshold)
-			mlx5_fc_pool_free_bulk(fc_pool, bulk);
-		else
-			list_add(&bulk->pool_list, &fc_pool->unused);
-	}
-
-unlock:
-	mutex_unlock(&fc_pool->pool_lock);
-}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_pool.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_pool.c
new file mode 100644
index 000000000000..b891d7b9e3e0
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_pool.c
@@ -0,0 +1,194 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+/* Copyright (c) 2024 NVIDIA Corporation & Affiliates */
+
+#include <mlx5_core.h>
+#include "fs_pool.h"
+
+int mlx5_fs_bulk_init(struct mlx5_core_dev *dev, struct mlx5_fs_bulk *fs_bulk,
+		      int bulk_len)
+{
+	int i;
+
+	fs_bulk->bitmask = kvcalloc(BITS_TO_LONGS(bulk_len), sizeof(unsigned long),
+				    GFP_KERNEL);
+	if (!fs_bulk->bitmask)
+		return -ENOMEM;
+
+	fs_bulk->bulk_len = bulk_len;
+	for (i = 0; i < bulk_len; i++)
+		set_bit(i, fs_bulk->bitmask);
+
+	return 0;
+}
+
+void mlx5_fs_bulk_cleanup(struct mlx5_fs_bulk *fs_bulk)
+{
+	kvfree(fs_bulk->bitmask);
+}
+
+int mlx5_fs_bulk_get_free_amount(struct mlx5_fs_bulk *bulk)
+{
+	return bitmap_weight(bulk->bitmask, bulk->bulk_len);
+}
+
+static int mlx5_fs_bulk_acquire_index(struct mlx5_fs_bulk *fs_bulk,
+				      struct mlx5_fs_pool_index *pool_index)
+{
+	int free_index = find_first_bit(fs_bulk->bitmask, fs_bulk->bulk_len);
+
+	WARN_ON_ONCE(!pool_index || !fs_bulk);
+	if (free_index >= fs_bulk->bulk_len)
+		return -ENOSPC;
+
+	clear_bit(free_index, fs_bulk->bitmask);
+	pool_index->fs_bulk = fs_bulk;
+	pool_index->index = free_index;
+	return 0;
+}
+
+static int mlx5_fs_bulk_release_index(struct mlx5_fs_bulk *fs_bulk, int index)
+{
+	if (test_bit(index, fs_bulk->bitmask))
+		return -EINVAL;
+
+	set_bit(index, fs_bulk->bitmask);
+	return 0;
+}
+
+void mlx5_fs_pool_init(struct mlx5_fs_pool *pool, struct mlx5_core_dev *dev,
+		       const struct mlx5_fs_pool_ops *ops)
+{
+	WARN_ON_ONCE(!ops || !ops->bulk_destroy || !ops->bulk_create ||
+		     !ops->update_threshold);
+	pool->dev = dev;
+	mutex_init(&pool->pool_lock);
+	INIT_LIST_HEAD(&pool->fully_used);
+	INIT_LIST_HEAD(&pool->partially_used);
+	INIT_LIST_HEAD(&pool->unused);
+	pool->available_units = 0;
+	pool->used_units = 0;
+	pool->threshold = 0;
+	pool->ops = ops;
+}
+
+void mlx5_fs_pool_cleanup(struct mlx5_fs_pool *pool)
+{
+	struct mlx5_core_dev *dev = pool->dev;
+	struct mlx5_fs_bulk *bulk;
+	struct mlx5_fs_bulk *tmp;
+
+	list_for_each_entry_safe(bulk, tmp, &pool->fully_used, pool_list)
+		pool->ops->bulk_destroy(dev, bulk);
+	list_for_each_entry_safe(bulk, tmp, &pool->partially_used, pool_list)
+		pool->ops->bulk_destroy(dev, bulk);
+	list_for_each_entry_safe(bulk, tmp, &pool->unused, pool_list)
+		pool->ops->bulk_destroy(dev, bulk);
+}
+
+static struct mlx5_fs_bulk *
+mlx5_fs_pool_alloc_new_bulk(struct mlx5_fs_pool *fs_pool)
+{
+	struct mlx5_core_dev *dev = fs_pool->dev;
+	struct mlx5_fs_bulk *new_bulk;
+
+	new_bulk = fs_pool->ops->bulk_create(dev);
+	if (new_bulk)
+		fs_pool->available_units += new_bulk->bulk_len;
+	fs_pool->ops->update_threshold(fs_pool);
+	return new_bulk;
+}
+
+static void
+mlx5_fs_pool_free_bulk(struct mlx5_fs_pool *fs_pool, struct mlx5_fs_bulk *bulk)
+{
+	struct mlx5_core_dev *dev = fs_pool->dev;
+
+	fs_pool->available_units -= bulk->bulk_len;
+	fs_pool->ops->bulk_destroy(dev, bulk);
+	fs_pool->ops->update_threshold(fs_pool);
+}
+
+static int
+mlx5_fs_pool_acquire_from_list(struct list_head *src_list,
+			       struct list_head *next_list,
+			       bool move_non_full_bulk,
+			       struct mlx5_fs_pool_index *pool_index)
+{
+	struct mlx5_fs_bulk *fs_bulk;
+	int err;
+
+	if (list_empty(src_list))
+		return -ENODATA;
+
+	fs_bulk = list_first_entry(src_list, struct mlx5_fs_bulk, pool_list);
+	err = mlx5_fs_bulk_acquire_index(fs_bulk, pool_index);
+	if (move_non_full_bulk || mlx5_fs_bulk_get_free_amount(fs_bulk) == 0)
+		list_move(&fs_bulk->pool_list, next_list);
+	return err;
+}
+
+int mlx5_fs_pool_acquire_index(struct mlx5_fs_pool *fs_pool,
+			       struct mlx5_fs_pool_index *pool_index)
+{
+	struct mlx5_fs_bulk *new_bulk;
+	int err;
+
+	mutex_lock(&fs_pool->pool_lock);
+
+	err = mlx5_fs_pool_acquire_from_list(&fs_pool->partially_used,
+					     &fs_pool->fully_used, false,
+					     pool_index);
+	if (err)
+		err = mlx5_fs_pool_acquire_from_list(&fs_pool->unused,
+						     &fs_pool->partially_used,
+						     true, pool_index);
+	if (err) {
+		new_bulk = mlx5_fs_pool_alloc_new_bulk(fs_pool);
+		if (!new_bulk) {
+			err = -ENOENT;
+			goto out;
+		}
+		err = mlx5_fs_bulk_acquire_index(new_bulk, pool_index);
+		WARN_ON_ONCE(err);
+		list_add(&new_bulk->pool_list, &fs_pool->partially_used);
+	}
+	fs_pool->available_units--;
+	fs_pool->used_units++;
+
+out:
+	mutex_unlock(&fs_pool->pool_lock);
+	return err;
+}
+
+int mlx5_fs_pool_release_index(struct mlx5_fs_pool *fs_pool,
+			       struct mlx5_fs_pool_index *pool_index)
+{
+	struct mlx5_fs_bulk *bulk = pool_index->fs_bulk;
+	int bulk_free_amount;
+	int err;
+
+	mutex_lock(&fs_pool->pool_lock);
+
+	/* TBD would rather return void if there was no warn here in original code */
+	err = mlx5_fs_bulk_release_index(bulk, pool_index->index);
+	if (err)
+		goto unlock;
+
+	fs_pool->available_units++;
+	fs_pool->used_units--;
+
+	bulk_free_amount = mlx5_fs_bulk_get_free_amount(bulk);
+	if (bulk_free_amount == 1)
+		list_move_tail(&bulk->pool_list, &fs_pool->partially_used);
+	if (bulk_free_amount == bulk->bulk_len) {
+		list_del(&bulk->pool_list);
+		if (fs_pool->available_units > fs_pool->threshold)
+			mlx5_fs_pool_free_bulk(fs_pool, bulk);
+		else
+			list_add(&bulk->pool_list, &fs_pool->unused);
+	}
+
+unlock:
+	mutex_unlock(&fs_pool->pool_lock);
+	return err;
+}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_pool.h b/drivers/net/ethernet/mellanox/mlx5/core/fs_pool.h
new file mode 100644
index 000000000000..3b149863260c
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_pool.h
@@ -0,0 +1,54 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
+/* Copyright (c) 2024 NVIDIA Corporation & Affiliates */
+
+#ifndef __MLX5_FS_POOL_H__
+#define __MLX5_FS_POOL_H__
+
+#include <linux/mlx5/driver.h>
+
+struct mlx5_fs_bulk {
+	struct list_head pool_list;
+	int bulk_len;
+	unsigned long *bitmask;
+};
+
+struct mlx5_fs_pool_index {
+	struct mlx5_fs_bulk *fs_bulk;
+	int index;
+};
+
+struct mlx5_fs_pool;
+
+struct mlx5_fs_pool_ops {
+	int (*bulk_destroy)(struct mlx5_core_dev *dev, struct mlx5_fs_bulk *bulk);
+	struct mlx5_fs_bulk * (*bulk_create)(struct mlx5_core_dev *dev);
+	void (*update_threshold)(struct mlx5_fs_pool *pool);
+};
+
+struct mlx5_fs_pool {
+	struct mlx5_core_dev *dev;
+	void *pool_ctx;
+	const struct mlx5_fs_pool_ops *ops;
+	struct mutex pool_lock; /* protects pool lists */
+	struct list_head fully_used;
+	struct list_head partially_used;
+	struct list_head unused;
+	int available_units;
+	int used_units;
+	int threshold;
+};
+
+int mlx5_fs_bulk_init(struct mlx5_core_dev *dev, struct mlx5_fs_bulk *fs_bulk,
+		      int bulk_len);
+void mlx5_fs_bulk_cleanup(struct mlx5_fs_bulk *fs_bulk);
+int mlx5_fs_bulk_get_free_amount(struct mlx5_fs_bulk *bulk);
+
+void mlx5_fs_pool_init(struct mlx5_fs_pool *pool, struct mlx5_core_dev *dev,
+		       const struct mlx5_fs_pool_ops *ops);
+void mlx5_fs_pool_cleanup(struct mlx5_fs_pool *pool);
+int mlx5_fs_pool_acquire_index(struct mlx5_fs_pool *fs_pool,
+			       struct mlx5_fs_pool_index *pool_index);
+int mlx5_fs_pool_release_index(struct mlx5_fs_pool *fs_pool,
+			       struct mlx5_fs_pool_index *pool_index);
+
+#endif /* __MLX5_FS_POOL_H__ */
-- 
2.45.0


