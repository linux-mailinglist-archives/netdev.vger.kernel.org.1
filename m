Return-Path: <netdev+bounces-118731-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FF5A952951
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 08:25:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3803D286EB9
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 06:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B29B176FB4;
	Thu, 15 Aug 2024 06:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EoLZRLRj"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2065.outbound.protection.outlook.com [40.107.92.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C9C1448C1
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 06:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723703089; cv=fail; b=YvkQWBMwZgcoZpcBbikXJxgssdHina71tEJ3OrXvMMyRg9Tg2H7WoH+17wx++cXAtojO7IQfpm5iSqZErl9yY48pDcbay53Cl9ZBiHo2aEaOzf2zzcJgkacim6iUxbP/4fjTQ3na20hMAp7sHXtzTSjokA7+tbELYcZJnqtx5eU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723703089; c=relaxed/simple;
	bh=MdJliMSBFa1EqMvO1S60iXF+vQW0fvBEJ8W6Q2VWv8c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QxnDzYyHHLrLYspJcELAwRx78dG1B6l5EGfQboYkosDjppLvBGKO1IEAnwYoYBo97i2GYiwrTbOnxo3rAzrFEszNXi5W9Lig0w9+NnZiM6xU4KQh58o2NT7dW9yjW/lr0+IPcqTIlmCOfa/KIbku05SnA7NwdACOMh0BLQgnYDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EoLZRLRj; arc=fail smtp.client-ip=40.107.92.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gsPllM3fSvWUnZeonmLES13LVOsTHYK55nqhUuguqg8ypGVhHBJoLLZPUQ3PCXwRBCH0A86bu0Sjy7TlQozXY5SxTEfDWxZf/CanBazFYQF+ANu9OV37Wms8aJzL448D28GfvLPBSUsPWbLGNowWJBTQHKF/OIU2oyefl1JcUdGZsMpuPIB/YtbnzW5X6PsYaR0IUKEIXiBw5MXx98hrx9hzZBfzsWuR7HklqU1XVg0Mk9Q68ykD6gq5BYsCFUBi3qrcK6z4XCdtrUNQk4HtQahXc/5x0KJBm/ObOS5mnmnCphpyww2tAhEqNI2ckEF+xaorT088L+KPh75sIz5GPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4xd+sSglU+WvtxNUA/9fYIcr4xCYH4R97W7jHquO9ss=;
 b=JqzVV3dGLAENCDuFOFsRboXPqzvNwTHqE9QjX46w/gKplLzSkDh5M6yt7vOeD4I2Fdq7IdzP4hX6oEXP+d9MDjZli+HeQSqwxDzm9ATRFG6QT0FOVwZIfDtBBR1m5C7YMwMgPddAYg+HBHo9LV+Cl0bRfcsLg3mPAJk6TAhZmlSFX+xG1k/myWOe32aMMTSUvOlYyR6P3sDif8EQEnY3Xu+kI/u2xP8eP1YVlPvxqipYR8jeKRuhsIlyXZ/mcFfYb7ok/6+ZrTzXAYAI0m2uWP/gzV3ywLM1XNtMz68c0CRQETvZRzjWAGU6twHL629oH2LF1T3FAPK6a/YqMG2qIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4xd+sSglU+WvtxNUA/9fYIcr4xCYH4R97W7jHquO9ss=;
 b=EoLZRLRjNj61sVl5cMlM6V7CXzSlWG4I2vOCmlWC9LHfpYoqW1dCaNxrRjZ8j+CqeRt5DCb+bkjFcIuQBJZHDdLRjtM4sOtGqEvPeFNfZWe8R/2RkLSXC8M47SwEgs5fy71RSPWtOutlViQNb3cxo3BIaeDbe7c5GnQbDJu5fKhm3eMNSr2Tnlo6gUryejH9VJa9EgJQphLynZNgpvgw5+4SAzU/qzdzK4DZGz3Ysnqd7sdsdYlmHvWm0g3KE/sWrY+Z8wVOcfEjEwGTMCfwRQZQDF0L3EKOoqPxp0uV8oIKz8DlOZAXx0WVYtZOa0DbO3XZijG0lCN2huhnYHtd6A==
Received: from BN9PR03CA0935.namprd03.prod.outlook.com (2603:10b6:408:108::10)
 by PH7PR12MB7843.namprd12.prod.outlook.com (2603:10b6:510:27e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.23; Thu, 15 Aug
 2024 06:24:38 +0000
Received: from BN2PEPF000044A7.namprd04.prod.outlook.com
 (2603:10b6:408:108:cafe::92) by BN9PR03CA0935.outlook.office365.com
 (2603:10b6:408:108::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.33 via Frontend
 Transport; Thu, 15 Aug 2024 06:24:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000044A7.mail.protection.outlook.com (10.167.243.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Thu, 15 Aug 2024 06:24:38 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 14 Aug
 2024 23:24:24 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 14 Aug
 2024 23:24:24 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Wed, 14 Aug
 2024 23:24:21 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 03/10] net/mlx5: hw counters: Replace IDR+lists with xarray
Date: Thu, 15 Aug 2024 08:46:49 +0300
Message-ID: <20240815054656.2210494-4-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A7:EE_|PH7PR12MB7843:EE_
X-MS-Office365-Filtering-Correlation-Id: a53f17bd-bd34-43fd-bdf4-08dcbcf2f08e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UjyONIrRlBMBtrEmcksQlBiwrS1hM6jQ4V/V9e533DHkYzIU+Pvwr0wyN39T?=
 =?us-ascii?Q?ja3DVRaT+Ldx9/bVLLJ7w+0tIpB0rePg8MgScYdlL3/jw5RBQiRJFd5g4fpJ?=
 =?us-ascii?Q?vX46RExIG3poTgWchaLebZ1pAm4Fpdsiv77KAJWCRY6PP2LwubE5WAlOmx8H?=
 =?us-ascii?Q?0AwbIclL3QrbD/cEKTHDx55G45YUdJ48dqyK4YKkPKZdMwotDnkk5QZK2BbS?=
 =?us-ascii?Q?4LfZWtSlcl+E0YCKwGbfEgQtcAbZbYMj4s3mzKdm240kd4pHWTFFGlKVSJfz?=
 =?us-ascii?Q?AF3DinUDoWRAVrdJbzJ7KtREf1VFXPreFqgw3W4W/M/11cCOy69JSRTwTbaQ?=
 =?us-ascii?Q?xv59el6J73C7lWAytw0OSxsdiv0WKw6a2ZPW6wiPge5bJJLK8rkTobYJseYP?=
 =?us-ascii?Q?b+F7bWQfHeBVoLejTqiEF+gVvymRiMaQpXzjXOHl4xfso/gEXqw9CVCmCgcA?=
 =?us-ascii?Q?rcE+S14Xo6Sl8kCBCfzkgXIsLgeFmEaljc7zRWXXIZaMKJ9uDE1IFv4mC0NP?=
 =?us-ascii?Q?Lomrdblp8T+UJJPZkbC7K6WhY7mqpafX/4FLe7hwDmykjsTkduR+gMxzCsAD?=
 =?us-ascii?Q?8W3hPGs0l4FbctfyV+q/oTB33CarhG5BlySe6W/aRsU14RrhM402RrTwwxOH?=
 =?us-ascii?Q?FFsFDzRIEWqNdTaJQId5YtNAtCYgQKjoWiG6O0rTdwvPjH4eDaM2MoChugE9?=
 =?us-ascii?Q?pyfYwKmRk2Dq80Ac1GEU/HBNJ8+Gksr5p+aGUWMoyixn/PNuCfqqzmlovKYU?=
 =?us-ascii?Q?XYr2lu25UuAQQlxZKqKFUlcKByf9t33m/1zPH0gfzCTriLDmfhJgWyEPMQqM?=
 =?us-ascii?Q?jVHOZVcePuMpNykxbIT3wYyOLlELc30LVA0U4KXvg/X6ToFdnemXkux9MSxB?=
 =?us-ascii?Q?QoxkbA1jx1pW7/IPL3TLtcW5C2z8jYofljML6mA7JFOtR+wdENWbDMIsd/UV?=
 =?us-ascii?Q?XNxOvJbRNW87NSAeoFiqYnNYTrneSf414mt3dYSCDrv3AN+Jwrv5MqCSdsH+?=
 =?us-ascii?Q?yjasF5IZMccOvwrBNNTU+BQaVrS9kcrBEIDHjLK6QFfIFmjrkpB0FRW/0fSU?=
 =?us-ascii?Q?F9gkNXf+u4wMXQz05si0F2+uTUk62/zxynqky6wgAjD0PA0Y3ovNBLE6GOuC?=
 =?us-ascii?Q?sDzkEfCYiji8MLYfZ0JZpbQP0w8X04TNKQ4lE43NtPm+Eicmotod6qk+CQGe?=
 =?us-ascii?Q?UyY/ACP51mYr5Ft9HJaD1X6CFznQJLuNz6q6U7yrXV5XII6oBjUI/dOJQ/4h?=
 =?us-ascii?Q?2DVh0GwpeoYdNOcoBYjRUGID3N0vWtEzZ659piKnmqVob3eVq0uWhH9tCGC9?=
 =?us-ascii?Q?RdFMHptnLk9VdJG3jurJ0wmp5iex52EvFGdOVqN4Chp1BzRXJZ7IhdMfrd7i?=
 =?us-ascii?Q?ZueNqb9dQTtKb8BX45fe+aj+UQDu4xuzUGXY2LZNG7nC0RiPwDbFvD0g9Cmp?=
 =?us-ascii?Q?flEFE08q+V+NcK2n7H0q6+/mnD5yltCS?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 06:24:38.1261
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a53f17bd-bd34-43fd-bdf4-08dcbcf2f08e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7843

From: Cosmin Ratiu <cratiu@nvidia.com>

Previously, managing counters was a complicated affair involving an IDR,
a sorted double linked list, two single linked lists and a complex dance
between a non-periodic wq task and users adding/deleting counters.

Adding was done by inserting new counters into the IDR and into a single
linked list, leaving the wq to process the list and actually add the
counters into the double linked list, maintained sorted with the IDR.

Deleting involved adding the counter into another single linked list,
leaving the wq to actually unlink the counter from the other structures
and release it.

Dumping the counters is done with the bulk query API, which relies on
the counter list being sorted and unmutable during querying to
efficiently retrieve cached counter values.

Finally, the IDR data struct is deprecated.

This commit replaces all of that with an xarray.

Adding is now done directly, by using xa_lock.
Deleting is also done directly, under the xa_lock.

Querying is done from a periodic task running every sampling_interval
(default 1s) and uses the bulk query API for efficiency.
It works by iterating over the xarray:
- when a new bulk needs to be started, the bulk information is computed
  under the xa_lock.
- the xa iteration state is saved and the xa_lock dropped.
- the HW is queried for bulk counter values.
- the xa_lock is reacquired.
- counter caches with ids covered by the bulk response are updated.

Querying always requests the max bulk length, for simplicity.

Counters could be added/deleted while the HW is queried. This is safe,
as the HW API simply returns unknown values for counters not in HW, but
those values won't be accessed. Only counters present in xarray before
bulk query will actually read queried cache values.

This cuts down the size of mlx5_fc by 4 pointers (88->56 bytes), which
amounts to ~3MB / 100K counters.
But more importantly, this solves the wq spinlock congestion issue seen
happening on high-rate counter insertion+deletion.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/fs_counters.c | 276 ++++++------------
 1 file changed, 82 insertions(+), 194 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c
index 9892895da9ee..05d9351ff577 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c
@@ -32,7 +32,6 @@
 
 #include <linux/mlx5/driver.h>
 #include <linux/mlx5/fs.h>
-#include <linux/rbtree.h>
 #include "mlx5_core.h"
 #include "fs_core.h"
 #include "fs_cmd.h"
@@ -51,21 +50,13 @@ struct mlx5_fc_cache {
 };
 
 struct mlx5_fc {
-	struct list_head list;
-	struct llist_node addlist;
-	struct llist_node dellist;
-
-	/* last{packets,bytes} members are used when calculating the delta since
-	 * last reading
-	 */
-	u64 lastpackets;
-	u64 lastbytes;
-
-	struct mlx5_fc_bulk *bulk;
 	u32 id;
 	bool aging;
-
+	struct mlx5_fc_bulk *bulk;
 	struct mlx5_fc_cache cache ____cacheline_aligned_in_smp;
+	/* last{packets,bytes} are used for calculating deltas since last reading. */
+	u64 lastpackets;
+	u64 lastbytes;
 };
 
 struct mlx5_fc_pool {
@@ -80,19 +71,14 @@ struct mlx5_fc_pool {
 };
 
 struct mlx5_fc_stats {
-	spinlock_t counters_idr_lock; /* protects counters_idr */
-	struct idr counters_idr;
-	struct list_head counters;
-	struct llist_head addlist;
-	struct llist_head dellist;
+	struct xarray counters;
 
 	struct workqueue_struct *wq;
 	struct delayed_work work;
-	unsigned long next_query;
 	unsigned long sampling_interval; /* jiffies */
 	u32 *bulk_query_out;
 	int bulk_query_len;
-	size_t num_counters;
+	size_t num_counters;  /* Also protected by xarray->xa_lock. */
 	bool bulk_query_alloc_failed;
 	unsigned long next_bulk_query_alloc;
 	struct mlx5_fc_pool fc_pool;
@@ -103,78 +89,6 @@ static void mlx5_fc_pool_cleanup(struct mlx5_fc_pool *fc_pool);
 static struct mlx5_fc *mlx5_fc_pool_acquire_counter(struct mlx5_fc_pool *fc_pool);
 static void mlx5_fc_pool_release_counter(struct mlx5_fc_pool *fc_pool, struct mlx5_fc *fc);
 
-/* locking scheme:
- *
- * It is the responsibility of the user to prevent concurrent calls or bad
- * ordering to mlx5_fc_create(), mlx5_fc_destroy() and accessing a reference
- * to struct mlx5_fc.
- * e.g en_tc.c is protected by RTNL lock of its caller, and will never call a
- * dump (access to struct mlx5_fc) after a counter is destroyed.
- *
- * access to counter list:
- * - create (user context)
- *   - mlx5_fc_create() only adds to an addlist to be used by
- *     mlx5_fc_stats_work(). addlist is a lockless single linked list
- *     that doesn't require any additional synchronization when adding single
- *     node.
- *   - spawn thread to do the actual destroy
- *
- * - destroy (user context)
- *   - add a counter to lockless dellist
- *   - spawn thread to do the actual del
- *
- * - dump (user context)
- *   user should not call dump after destroy
- *
- * - query (single thread workqueue context)
- *   destroy/dump - no conflict (see destroy)
- *   query/dump - packets and bytes might be inconsistent (since update is not
- *                atomic)
- *   query/create - no conflict (see create)
- *   since every create/destroy spawn the work, only after necessary time has
- *   elapsed, the thread will actually query the hardware.
- */
-
-static struct list_head *mlx5_fc_counters_lookup_next(struct mlx5_core_dev *dev,
-						      u32 id)
-{
-	struct mlx5_fc_stats *fc_stats = dev->priv.fc_stats;
-	unsigned long next_id = (unsigned long)id + 1;
-	struct mlx5_fc *counter;
-	unsigned long tmp;
-
-	rcu_read_lock();
-	/* skip counters that are in idr, but not yet in counters list */
-	idr_for_each_entry_continue_ul(&fc_stats->counters_idr,
-				       counter, tmp, next_id) {
-		if (!list_empty(&counter->list))
-			break;
-	}
-	rcu_read_unlock();
-
-	return counter ? &counter->list : &fc_stats->counters;
-}
-
-static void mlx5_fc_stats_insert(struct mlx5_core_dev *dev,
-				 struct mlx5_fc *counter)
-{
-	struct list_head *next = mlx5_fc_counters_lookup_next(dev, counter->id);
-
-	list_add_tail(&counter->list, next);
-}
-
-static void mlx5_fc_stats_remove(struct mlx5_core_dev *dev,
-				 struct mlx5_fc *counter)
-{
-	struct mlx5_fc_stats *fc_stats = dev->priv.fc_stats;
-
-	list_del(&counter->list);
-
-	spin_lock(&fc_stats->counters_idr_lock);
-	WARN_ON(!idr_remove(&fc_stats->counters_idr, counter->id));
-	spin_unlock(&fc_stats->counters_idr_lock);
-}
-
 static int get_init_bulk_query_len(struct mlx5_core_dev *dev)
 {
 	return min_t(int, MLX5_INIT_COUNTERS_BULK,
@@ -203,47 +117,64 @@ static void update_counter_cache(int index, u32 *bulk_raw_data,
 	cache->lastuse = jiffies;
 }
 
-static void mlx5_fc_stats_query_counter_range(struct mlx5_core_dev *dev,
-					      struct mlx5_fc *first,
-					      u32 last_id)
+/* Synchronization notes
+ *
+ * Access to counter array:
+ * - create - mlx5_fc_create() (user context)
+ *   - inserts the counter into the xarray.
+ *
+ * - destroy - mlx5_fc_destroy() (user context)
+ *   - erases the counter from the xarray and releases it.
+ *
+ * - query mlx5_fc_query(), mlx5_fc_query_cached{,_raw}() (user context)
+ *   - user should not access a counter after destroy.
+ *
+ * - bulk query (single thread workqueue context)
+ *   - create: query relies on 'lastuse' to avoid updating counters added
+ *             around the same time as the current bulk cmd.
+ *   - destroy: destroyed counters will not be accessed, even if they are
+ *              destroyed during a bulk query command.
+ */
+static void mlx5_fc_stats_query_all_counters(struct mlx5_core_dev *dev)
 {
 	struct mlx5_fc_stats *fc_stats = dev->priv.fc_stats;
-	bool query_more_counters = (first->id <= last_id);
-	int cur_bulk_len = fc_stats->bulk_query_len;
+	u32 bulk_len = fc_stats->bulk_query_len;
+	XA_STATE(xas, &fc_stats->counters, 0);
 	u32 *data = fc_stats->bulk_query_out;
-	struct mlx5_fc *counter = first;
+	struct mlx5_fc *counter;
+	u32 last_bulk_id = 0;
+	u64 bulk_query_time;
 	u32 bulk_base_id;
-	int bulk_len;
 	int err;
 
-	while (query_more_counters) {
-		/* first id must be aligned to 4 when using bulk query */
-		bulk_base_id = counter->id & ~0x3;
-
-		/* number of counters to query inc. the last counter */
-		bulk_len = min_t(int, cur_bulk_len,
-				 ALIGN(last_id - bulk_base_id + 1, 4));
-
-		err = mlx5_cmd_fc_bulk_query(dev, bulk_base_id, bulk_len,
-					     data);
-		if (err) {
-			mlx5_core_err(dev, "Error doing bulk query: %d\n", err);
-			return;
-		}
-		query_more_counters = false;
-
-		list_for_each_entry_from(counter, &fc_stats->counters, list) {
-			int counter_index = counter->id - bulk_base_id;
-			struct mlx5_fc_cache *cache = &counter->cache;
-
-			if (counter->id >= bulk_base_id + bulk_len) {
-				query_more_counters = true;
-				break;
+	xas_lock(&xas);
+	xas_for_each(&xas, counter, U32_MAX) {
+		if (xas_retry(&xas, counter))
+			continue;
+		if (unlikely(counter->id >= last_bulk_id)) {
+			/* Start new bulk query. */
+			/* First id must be aligned to 4 when using bulk query. */
+			bulk_base_id = counter->id & ~0x3;
+			last_bulk_id = bulk_base_id + bulk_len;
+			/* The lock is released while querying the hw and reacquired after. */
+			xas_unlock(&xas);
+			/* The same id needs to be processed again in the next loop iteration. */
+			xas_reset(&xas);
+			bulk_query_time = jiffies;
+			err = mlx5_cmd_fc_bulk_query(dev, bulk_base_id, bulk_len, data);
+			if (err) {
+				mlx5_core_err(dev, "Error doing bulk query: %d\n", err);
+				return;
 			}
-
-			update_counter_cache(counter_index, data, cache);
+			xas_lock(&xas);
+			continue;
 		}
+		/* Do not update counters added after bulk query was started. */
+		if (time_after64(bulk_query_time, counter->cache.lastuse))
+			update_counter_cache(counter->id - bulk_base_id, data,
+					     &counter->cache);
 	}
+	xas_unlock(&xas);
 }
 
 static void mlx5_fc_free(struct mlx5_core_dev *dev, struct mlx5_fc *counter)
@@ -291,46 +222,19 @@ static void mlx5_fc_stats_work(struct work_struct *work)
 	struct mlx5_fc_stats *fc_stats = container_of(work, struct mlx5_fc_stats,
 						      work.work);
 	struct mlx5_core_dev *dev = fc_stats->fc_pool.dev;
-	/* Take dellist first to ensure that counters cannot be deleted before
-	 * they are inserted.
-	 */
-	struct llist_node *dellist = llist_del_all(&fc_stats->dellist);
-	struct llist_node *addlist = llist_del_all(&fc_stats->addlist);
-	struct mlx5_fc *counter = NULL, *last = NULL, *tmp;
-	unsigned long now = jiffies;
-
-	if (addlist || !list_empty(&fc_stats->counters))
-		queue_delayed_work(fc_stats->wq, &fc_stats->work,
-				   fc_stats->sampling_interval);
-
-	llist_for_each_entry(counter, addlist, addlist) {
-		mlx5_fc_stats_insert(dev, counter);
-		fc_stats->num_counters++;
-	}
+	int num_counters;
 
-	llist_for_each_entry_safe(counter, tmp, dellist, dellist) {
-		mlx5_fc_stats_remove(dev, counter);
-
-		mlx5_fc_release(dev, counter);
-		fc_stats->num_counters--;
-	}
-
-	if (time_before(now, fc_stats->next_query) ||
-	    list_empty(&fc_stats->counters))
-		return;
+	queue_delayed_work(fc_stats->wq, &fc_stats->work, fc_stats->sampling_interval);
 
+	/* num_counters is only needed for determining whether to increase the buffer. */
+	xa_lock(&fc_stats->counters);
+	num_counters = fc_stats->num_counters;
+	xa_unlock(&fc_stats->counters);
 	if (fc_stats->bulk_query_len < get_max_bulk_query_len(dev) &&
-	    fc_stats->num_counters > get_init_bulk_query_len(dev))
+	    num_counters > get_init_bulk_query_len(dev))
 		mlx5_fc_stats_bulk_query_buf_realloc(dev, get_max_bulk_query_len(dev));
 
-	last = list_last_entry(&fc_stats->counters, struct mlx5_fc, list);
-
-	counter = list_first_entry(&fc_stats->counters, struct mlx5_fc,
-				   list);
-	if (counter)
-		mlx5_fc_stats_query_counter_range(dev, counter, last->id);
-
-	fc_stats->next_query = now + fc_stats->sampling_interval;
+	mlx5_fc_stats_query_all_counters(dev);
 }
 
 static struct mlx5_fc *mlx5_fc_single_alloc(struct mlx5_core_dev *dev)
@@ -374,7 +278,6 @@ struct mlx5_fc *mlx5_fc_create_ex(struct mlx5_core_dev *dev, bool aging)
 	if (IS_ERR(counter))
 		return counter;
 
-	INIT_LIST_HEAD(&counter->list);
 	counter->aging = aging;
 
 	if (aging) {
@@ -384,18 +287,15 @@ struct mlx5_fc *mlx5_fc_create_ex(struct mlx5_core_dev *dev, bool aging)
 		counter->lastbytes = counter->cache.bytes;
 		counter->lastpackets = counter->cache.packets;
 
-		idr_preload(GFP_KERNEL);
-		spin_lock(&fc_stats->counters_idr_lock);
+		xa_lock(&fc_stats->counters);
 
-		err = idr_alloc_u32(&fc_stats->counters_idr, counter, &id, id,
-				    GFP_NOWAIT);
-
-		spin_unlock(&fc_stats->counters_idr_lock);
-		idr_preload_end();
-		if (err)
+		err = xa_err(__xa_store(&fc_stats->counters, id, counter, GFP_KERNEL));
+		if (err != 0) {
+			xa_unlock(&fc_stats->counters);
 			goto err_out_alloc;
-
-		llist_add(&counter->addlist, &fc_stats->addlist);
+		}
+		fc_stats->num_counters++;
+		xa_unlock(&fc_stats->counters);
 	}
 
 	return counter;
@@ -407,12 +307,7 @@ struct mlx5_fc *mlx5_fc_create_ex(struct mlx5_core_dev *dev, bool aging)
 
 struct mlx5_fc *mlx5_fc_create(struct mlx5_core_dev *dev, bool aging)
 {
-	struct mlx5_fc *counter = mlx5_fc_create_ex(dev, aging);
-	struct mlx5_fc_stats *fc_stats = dev->priv.fc_stats;
-
-	if (aging)
-		mod_delayed_work(fc_stats->wq, &fc_stats->work, 0);
-	return counter;
+	return mlx5_fc_create_ex(dev, aging);
 }
 EXPORT_SYMBOL(mlx5_fc_create);
 
@@ -430,11 +325,11 @@ void mlx5_fc_destroy(struct mlx5_core_dev *dev, struct mlx5_fc *counter)
 		return;
 
 	if (counter->aging) {
-		llist_add(&counter->dellist, &fc_stats->dellist);
-		mod_delayed_work(fc_stats->wq, &fc_stats->work, 0);
-		return;
+		xa_lock(&fc_stats->counters);
+		fc_stats->num_counters--;
+		__xa_erase(&fc_stats->counters, counter->id);
+		xa_unlock(&fc_stats->counters);
 	}
-
 	mlx5_fc_release(dev, counter);
 }
 EXPORT_SYMBOL(mlx5_fc_destroy);
@@ -448,11 +343,7 @@ int mlx5_init_fc_stats(struct mlx5_core_dev *dev)
 		return -ENOMEM;
 	dev->priv.fc_stats = fc_stats;
 
-	spin_lock_init(&fc_stats->counters_idr_lock);
-	idr_init(&fc_stats->counters_idr);
-	INIT_LIST_HEAD(&fc_stats->counters);
-	init_llist_head(&fc_stats->addlist);
-	init_llist_head(&fc_stats->dellist);
+	xa_init(&fc_stats->counters);
 
 	/* Allocate initial (small) bulk query buffer. */
 	mlx5_fc_stats_bulk_query_buf_realloc(dev, get_init_bulk_query_len(dev));
@@ -467,7 +358,7 @@ int mlx5_init_fc_stats(struct mlx5_core_dev *dev)
 	INIT_DELAYED_WORK(&fc_stats->work, mlx5_fc_stats_work);
 
 	mlx5_fc_pool_init(&fc_stats->fc_pool, dev);
-
+	queue_delayed_work(fc_stats->wq, &fc_stats->work, MLX5_FC_STATS_PERIOD);
 	return 0;
 
 err_wq_create:
@@ -480,23 +371,20 @@ int mlx5_init_fc_stats(struct mlx5_core_dev *dev)
 void mlx5_cleanup_fc_stats(struct mlx5_core_dev *dev)
 {
 	struct mlx5_fc_stats *fc_stats = dev->priv.fc_stats;
-	struct llist_node *tmplist;
 	struct mlx5_fc *counter;
-	struct mlx5_fc *tmp;
+	unsigned long id;
 
 	cancel_delayed_work_sync(&fc_stats->work);
 	destroy_workqueue(fc_stats->wq);
 	fc_stats->wq = NULL;
 
-	tmplist = llist_del_all(&fc_stats->addlist);
-	llist_for_each_entry_safe(counter, tmp, tmplist, addlist)
-		mlx5_fc_release(dev, counter);
-
-	list_for_each_entry_safe(counter, tmp, &fc_stats->counters, list)
+	xa_for_each(&fc_stats->counters, id, counter) {
+		xa_erase(&fc_stats->counters, id);
 		mlx5_fc_release(dev, counter);
+	}
+	xa_destroy(&fc_stats->counters);
 
 	mlx5_fc_pool_cleanup(&fc_stats->fc_pool);
-	idr_destroy(&fc_stats->counters_idr);
 	kvfree(fc_stats->bulk_query_out);
 	kfree(fc_stats);
 }
-- 
2.44.0


