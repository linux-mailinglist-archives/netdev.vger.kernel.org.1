Return-Path: <netdev+bounces-155725-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC216A037B0
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 07:09:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A569C7A2452
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 06:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79ABF1A0BCA;
	Tue,  7 Jan 2025 06:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Aoi8fbT5"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2076.outbound.protection.outlook.com [40.107.236.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22EE41DE2C3
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 06:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736230146; cv=fail; b=SrWWLboiRlSxRY14XB+l0cbuFx1x82dON+SMbRitJhpt5m63GyXs3sZ5/flyZYwLbx2otqd0Lj9gJvEmhQkqUMXL/tym7fTb1tUPj3z0fdWVgtzco3OPOpTboYn1SEe4Y3MNmmgLWDWL+3+5/xsqQjUBihFCsRJefpNkM5A6cVA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736230146; c=relaxed/simple;
	bh=qUL3qLSVyAoLDnM9Fao5TWX9oeT8zaK/XdjKyBk8Oiw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=glKe9tXPpx4wtKPdjmJF2e0mSYq4T70LYlr7PlgYv53n0e8u/aEFnhqLppLXa5YoCbgDLC93A7arnOHNBCmtY6AzzA6lzmEP1Go6sR5YXXRthS6S92c6GY7GjRrkVMkm1tP0Z1q52tvKeqCWvpNcEd+3AhK5Pr12wulTtDYpLs8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Aoi8fbT5; arc=fail smtp.client-ip=40.107.236.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GJZiOFlyOdRnZQz0Wrz5THx4shaOoeBaBRKFg/M+fbwGjMK5fJ6bj9UqisPGW5RTVxvMMlcUqyeylu0EgJbxaLtQs+TFG1UmdQbJ6hujR6kLMG+biofpVoutioVPtXFbr3nahbWX2pvT46X6BWagrecttE1izCj3fTDdWBbx0ng5VELg6Jg1EtrDKp8X14iuZp+dS+FjoQJfDKjMKckWo7bgUsut3c8uE10745RhbRgP/vs5HGcoN2v7nqzepzT5omhEpzt8qDO/L3WKWUCMAbynnYdInmaFgPkIzlL3YR+3gne5MaN0x/vrgz7BhDqMjVWFujBFfre51qDtjafFsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5LIgU4xF0ql5Mus89WuEm9u85iUyX9tZrUgzfYXq5ww=;
 b=iElwaKA8KnRFqB1+g1b13WsiVEhjUvU2T157YqdT3XKRGKIRnXrV17Qc9iY7C7SGHJa+rF1NrAmmrM+OWa+gL3ere27W4HyDQa7ksJoMz9NNJ9mkFKjsv7fNFyO1QLpqPfBTL9zjq+SvJwvfeXJ6Fapl7KhcoqCw9ClZYDcIsSO6YaM3W9XeoQEs0mrXm1b9ISjL3pMsQxEK02RmIbaLBWJmtxhuWlmQXjHjCvetE+ULO4/jd4nn7R3SZe4PKI0xpzRWbdZWchbG/L8S/agyph5OXUCO3VgfmfHymec/dS6g1GZmmXr+x5T7Jl/z7eaTMfHc0UKNQpHkBgFIpDxRdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5LIgU4xF0ql5Mus89WuEm9u85iUyX9tZrUgzfYXq5ww=;
 b=Aoi8fbT5KJIiAApm55lVHmthJoBe8fStsQTD10vX8wnvQs9YTN0iqGQdYQoY0y2mgLhxvfvXK/Mb0boBeC8h3b4mOt9kQps2p1Tj5d+maPxOXeogO8HpMBYvjzOA1YF3oI1j2NRXca1ZTuUs51ezzN6hcCJKoMtuGrSrzMh56rhqkHfreD69S7cCtCK7Hpgu7t2Kf6Gn/TQaSZkurlXqXmfAWDVOiCavr5rEHLgtxR9b8/pQtc5ns03V23hhOk0D6lvpf5rdXcViJRzIqNBQV9JnPxUPO02Juw9VPda7cbrlWNCE4Qgre/104czuaGjqx3KL5nYveqv+7ZWDLiUTIw==
Received: from CH5P223CA0015.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:1f3::15)
 by CH3PR12MB8306.namprd12.prod.outlook.com (2603:10b6:610:12c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.18; Tue, 7 Jan
 2025 06:08:53 +0000
Received: from CH1PEPF0000AD79.namprd04.prod.outlook.com
 (2603:10b6:610:1f3:cafe::86) by CH5P223CA0015.outlook.office365.com
 (2603:10b6:610:1f3::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.10 via Frontend Transport; Tue,
 7 Jan 2025 06:08:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000AD79.mail.protection.outlook.com (10.167.244.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.7 via Frontend Transport; Tue, 7 Jan 2025 06:08:53 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 6 Jan 2025
 22:08:38 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 6 Jan 2025
 22:08:37 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Mon, 6 Jan
 2025 22:08:34 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Yevgeny Kliteynik
	<kliteyn@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 05/13] net/mlx5: fs, add HWS packet reformat API function
Date: Tue, 7 Jan 2025 08:07:00 +0200
Message-ID: <20250107060708.1610882-6-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD79:EE_|CH3PR12MB8306:EE_
X-MS-Office365-Filtering-Correlation-Id: e2edd533-c538-4d8f-9a9c-08dd2ee1c340
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?O8reRZLIUva+rqd4w4oJzezR5SmDGUviDjXnwAGAQ9fl/KqMQTZOeAS46ls+?=
 =?us-ascii?Q?ZKXER/zlKIOJxIoQe0AvzIyNCZ7r//OIw1I+cwNy5lLxhWn4iIQIp7hg8iZh?=
 =?us-ascii?Q?5JqmNBBl59DmXYA78VOp+4aDFDWINTTOmS05YRDKW8xhPt5A0G/xdtM5lUaV?=
 =?us-ascii?Q?igC2isV1QGZzsXPieNb1dEQCDkl2PV/8X9KANvh4X7bR0kMZQIgJ6abZ9TBT?=
 =?us-ascii?Q?J6LzspBHXUEIz4f8ZKzAsNTZWKAZm/NYk4SnzJX6e9zktmzedzkNs9yDP2ZN?=
 =?us-ascii?Q?M08kTufie1W9Mps6/ldjSDXDUwnRNdNO6GdtI54IANh3+pYdzGIppm84Ld2d?=
 =?us-ascii?Q?9/ENxAPJ0vlCTWE/L51O9SkvwnXXqdBYUDfWMoGEA17USL/PwL0EO8yP89Li?=
 =?us-ascii?Q?R2Mh2hrK9bC8k5SG1Pj3KjQDKlJ/cQ+Hp5irL8yBrO1XXtWmoe4K1iKtvZjO?=
 =?us-ascii?Q?8sso3A1l9uf52EdQdBBCVstGB+WuPOGJXZMVosNdFP57f+vS0EX3VqGqCLMl?=
 =?us-ascii?Q?bmTWpjjPoaLOwPY6GvtEosXN0l2s2Xp0D3n5WysSWP1vNaoO4Dsy/3frQ1t2?=
 =?us-ascii?Q?pNCxSmcBt15oMUy1CKpgOJRVYPRLBimCRKgenRneFDYepHEIYGD/36GqM4Tl?=
 =?us-ascii?Q?QT/HcLCJlrLSJSkIcMk12IfwAdBPwsx+Ypn/3B4AFbsSRnx4tdWcQNqe8TBo?=
 =?us-ascii?Q?VrYTQWyEfcdEGQ2sGfNn/pg1FhbD9TxV69SqPWrMOX8ts4N7alu8e4ksamjb?=
 =?us-ascii?Q?Q30M3AvIdhPp0uR2SsFiZgo+pPbCJmrndZ0kYwS+nSqm6O540uPduytL3IO1?=
 =?us-ascii?Q?5lESbeLURu10ieSEMMv5/ptJFcwtPa3Qk92cT+1chtU76VD2Lt+4RURMrzHL?=
 =?us-ascii?Q?JE0zE7lPU8PUKJxTJJMXYsdpxFEwlV9stnToe8GX4IyOLs6pZccQCswAqMD2?=
 =?us-ascii?Q?wgShWsOAe1KUm3J+y0KrlLoXZC0lMQ6s9dUR+i8S47iLQwJwojBtX+c+E6t8?=
 =?us-ascii?Q?eoHkZWTIuU7iWSk27QS1b1ry03d8eOWk6mbOAF4GTXk5bt5p2VIKNaHMl/m0?=
 =?us-ascii?Q?mwq/tcSuH3Lhelj+VxaSvhlXMDjVel+tWsyj6cIv6P0V6tvyUuudg5tXnv6T?=
 =?us-ascii?Q?aIsMHt+wMW8tr7q01RMT6uVrcc6uVynP0hkDDt2txSFElSn1DG9JBy+iK7OD?=
 =?us-ascii?Q?+NVODyDDaowY3+CBWUWC2CXRGRKr9vkafIfIikPjwZpJJPhxCfH7iAwOGgmK?=
 =?us-ascii?Q?QKFgZlZahTHeq57JCFm2V7/TZzU/5GPpPTsBayE7O1STMMAiFJtau35LJXCv?=
 =?us-ascii?Q?YAaK4luMs5IdPoPyk5zg1wCCLMkQHug6G2biSMwR6WWU94SbeDnxkHThJk00?=
 =?us-ascii?Q?88w+23qPoyKVGsNRyA/i6XaZVGsEQPiiax4L65RxUMgQhKq5DAHn2myxsPPf?=
 =?us-ascii?Q?keMxJ/xIAzoJShlG4+y++zRClVEo7SjSINQD6owHz2v954oTQPAjKeuP5b7F?=
 =?us-ascii?Q?1uRJI11QVng1ID8=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 06:08:53.3226
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2edd533-c538-4d8f-9a9c-08dd2ee1c340
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD79.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8306

From: Moshe Shemesh <moshe@nvidia.com>

Add packet reformat alloc and dealloc API functions to provide packet
reformat actions for steering rules.

Add HWS action pools for each of the following packet reformat types:
- decapl3: decapsulate l3 tunnel to l2
- encapl2: encapsulate l2 to tunnel l2
- encapl3: encapsulate l2 to tunnel l3
- insert_hdr: insert header

In addition cache remove header action for remove vlan header as this is
currently the only use case of remove header action in the driver.

Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/Makefile  |   1 +
 .../net/ethernet/mellanox/mlx5/core/fs_core.h |   1 +
 .../ethernet/mellanox/mlx5/core/fs_counters.c |   5 +-
 .../net/ethernet/mellanox/mlx5/core/fs_pool.c |   5 +-
 .../net/ethernet/mellanox/mlx5/core/fs_pool.h |   5 +-
 .../mellanox/mlx5/core/steering/hws/fs_hws.c  | 289 +++++++++++++++++-
 .../mellanox/mlx5/core/steering/hws/fs_hws.h  |  12 +
 .../mlx5/core/steering/hws/fs_hws_pools.c     | 238 +++++++++++++++
 .../mlx5/core/steering/hws/fs_hws_pools.h     |  48 +++
 include/linux/mlx5/mlx5_ifc.h                 |   1 +
 10 files changed, 594 insertions(+), 11 deletions(-)
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws_pools.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws_pools.h

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/Makefile b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
index 0008b22417c8..d9a8817bb33c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/Makefile
+++ b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
@@ -152,6 +152,7 @@ mlx5_core-$(CONFIG_MLX5_HW_STEERING) += steering/hws/cmd.o \
 					steering/hws/debug.o \
 					steering/hws/vport.o \
 					steering/hws/bwc_complex.o \
+					steering/hws/fs_hws_pools.o \
 					steering/hws/fs_hws.o
 
 #
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h
index bbe3741b7868..9b0575a61362 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h
@@ -75,6 +75,7 @@ struct mlx5_pkt_reformat {
 	enum mlx5_flow_resource_owner owner;
 	union {
 		struct mlx5_fs_dr_action fs_dr_action;
+		struct mlx5_fs_hws_action fs_hws_action;
 		u32 id;
 	};
 };
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c
index d8e1c4ebd364..94d9caacd50f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c
@@ -449,7 +449,8 @@ static void mlx5_fc_init(struct mlx5_fc *counter, struct mlx5_fc_bulk *bulk,
 	counter->id = id;
 }
 
-static struct mlx5_fs_bulk *mlx5_fc_bulk_create(struct mlx5_core_dev *dev)
+static struct mlx5_fs_bulk *mlx5_fc_bulk_create(struct mlx5_core_dev *dev,
+						void *pool_ctx)
 {
 	enum mlx5_fc_bulk_alloc_bitmask alloc_bitmask;
 	struct mlx5_fc_bulk *fc_bulk;
@@ -518,7 +519,7 @@ static const struct mlx5_fs_pool_ops mlx5_fc_pool_ops = {
 static void
 mlx5_fc_pool_init(struct mlx5_fs_pool *fc_pool, struct mlx5_core_dev *dev)
 {
-	mlx5_fs_pool_init(fc_pool, dev, &mlx5_fc_pool_ops);
+	mlx5_fs_pool_init(fc_pool, dev, &mlx5_fc_pool_ops, NULL);
 }
 
 static void mlx5_fc_pool_cleanup(struct mlx5_fs_pool *fc_pool)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_pool.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_pool.c
index b891d7b9e3e0..f6c226664602 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_pool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_pool.c
@@ -56,11 +56,12 @@ static int mlx5_fs_bulk_release_index(struct mlx5_fs_bulk *fs_bulk, int index)
 }
 
 void mlx5_fs_pool_init(struct mlx5_fs_pool *pool, struct mlx5_core_dev *dev,
-		       const struct mlx5_fs_pool_ops *ops)
+		       const struct mlx5_fs_pool_ops *ops, void *pool_ctx)
 {
 	WARN_ON_ONCE(!ops || !ops->bulk_destroy || !ops->bulk_create ||
 		     !ops->update_threshold);
 	pool->dev = dev;
+	pool->pool_ctx = pool_ctx;
 	mutex_init(&pool->pool_lock);
 	INIT_LIST_HEAD(&pool->fully_used);
 	INIT_LIST_HEAD(&pool->partially_used);
@@ -91,7 +92,7 @@ mlx5_fs_pool_alloc_new_bulk(struct mlx5_fs_pool *fs_pool)
 	struct mlx5_core_dev *dev = fs_pool->dev;
 	struct mlx5_fs_bulk *new_bulk;
 
-	new_bulk = fs_pool->ops->bulk_create(dev);
+	new_bulk = fs_pool->ops->bulk_create(dev, fs_pool->pool_ctx);
 	if (new_bulk)
 		fs_pool->available_units += new_bulk->bulk_len;
 	fs_pool->ops->update_threshold(fs_pool);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_pool.h b/drivers/net/ethernet/mellanox/mlx5/core/fs_pool.h
index 3b149863260c..f04ec3107498 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_pool.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_pool.h
@@ -21,7 +21,8 @@ struct mlx5_fs_pool;
 
 struct mlx5_fs_pool_ops {
 	int (*bulk_destroy)(struct mlx5_core_dev *dev, struct mlx5_fs_bulk *bulk);
-	struct mlx5_fs_bulk * (*bulk_create)(struct mlx5_core_dev *dev);
+	struct mlx5_fs_bulk * (*bulk_create)(struct mlx5_core_dev *dev,
+					     void *pool_ctx);
 	void (*update_threshold)(struct mlx5_fs_pool *pool);
 };
 
@@ -44,7 +45,7 @@ void mlx5_fs_bulk_cleanup(struct mlx5_fs_bulk *fs_bulk);
 int mlx5_fs_bulk_get_free_amount(struct mlx5_fs_bulk *bulk);
 
 void mlx5_fs_pool_init(struct mlx5_fs_pool *pool, struct mlx5_core_dev *dev,
-		       const struct mlx5_fs_pool_ops *ops);
+		       const struct mlx5_fs_pool_ops *ops, void *pool_ctx);
 void mlx5_fs_pool_cleanup(struct mlx5_fs_pool *pool);
 int mlx5_fs_pool_acquire_index(struct mlx5_fs_pool *fs_pool,
 			       struct mlx5_fs_pool_index *pool_index);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
index eeaf4a84aafc..723865140b2e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
@@ -4,22 +4,30 @@
 #include <mlx5_core.h>
 #include <fs_core.h>
 #include <fs_cmd.h>
+#include "fs_hws_pools.h"
 #include "mlx5hws.h"
 
 #define MLX5HWS_CTX_MAX_NUM_OF_QUEUES 16
 #define MLX5HWS_CTX_QUEUE_SIZE 256
 
-static int init_hws_actions_pool(struct mlx5_fs_hws_context *fs_ctx)
+static struct mlx5hws_action *
+create_action_remove_header_vlan(struct mlx5hws_context *ctx);
+static void destroy_pr_pool(struct mlx5_fs_pool *pool, struct xarray *pr_pools,
+			    unsigned long index);
+
+static int init_hws_actions_pool(struct mlx5_core_dev *dev,
+				 struct mlx5_fs_hws_context *fs_ctx)
 {
 	u32 flags = MLX5HWS_ACTION_FLAG_HWS_FDB | MLX5HWS_ACTION_FLAG_SHARED;
 	struct mlx5_fs_hws_actions_pool *hws_pool = &fs_ctx->hws_pool;
 	struct mlx5hws_action_reformat_header reformat_hdr = {};
 	struct mlx5hws_context *ctx = fs_ctx->hws_ctx;
 	enum mlx5hws_action_type action_type;
+	int err = -ENOMEM;
 
 	hws_pool->tag_action = mlx5hws_action_create_tag(ctx, flags);
 	if (!hws_pool->tag_action)
-		return -ENOMEM;
+		return err;
 	hws_pool->pop_vlan_action = mlx5hws_action_create_pop_vlan(ctx, flags);
 	if (!hws_pool->pop_vlan_action)
 		goto destroy_tag;
@@ -35,8 +43,27 @@ static int init_hws_actions_pool(struct mlx5_fs_hws_context *fs_ctx)
 					       &reformat_hdr, 0, flags);
 	if (!hws_pool->decapl2_action)
 		goto destroy_drop;
+	hws_pool->remove_hdr_vlan_action = create_action_remove_header_vlan(ctx);
+	if (!hws_pool->remove_hdr_vlan_action)
+		goto destroy_decapl2;
+	err = mlx5_fs_hws_pr_pool_init(&hws_pool->insert_hdr_pool, dev, 0,
+				       MLX5HWS_ACTION_TYP_INSERT_HEADER);
+	if (err)
+		goto destroy_remove_hdr;
+	err = mlx5_fs_hws_pr_pool_init(&hws_pool->dl3tnltol2_pool, dev, 0,
+				       MLX5HWS_ACTION_TYP_REFORMAT_TNL_L3_TO_L2);
+	if (err)
+		goto cleanup_insert_hdr;
+	xa_init(&hws_pool->el2tol3tnl_pools);
+	xa_init(&hws_pool->el2tol2tnl_pools);
 	return 0;
 
+cleanup_insert_hdr:
+	mlx5_fs_hws_pr_pool_cleanup(&hws_pool->insert_hdr_pool);
+destroy_remove_hdr:
+	mlx5hws_action_destroy(hws_pool->remove_hdr_vlan_action);
+destroy_decapl2:
+	mlx5hws_action_destroy(hws_pool->decapl2_action);
 destroy_drop:
 	mlx5hws_action_destroy(hws_pool->drop_action);
 destroy_push_vlan:
@@ -45,13 +72,24 @@ static int init_hws_actions_pool(struct mlx5_fs_hws_context *fs_ctx)
 	mlx5hws_action_destroy(hws_pool->pop_vlan_action);
 destroy_tag:
 	mlx5hws_action_destroy(hws_pool->tag_action);
-	return -ENOMEM;
+	return err;
 }
 
 static void cleanup_hws_actions_pool(struct mlx5_fs_hws_context *fs_ctx)
 {
 	struct mlx5_fs_hws_actions_pool *hws_pool = &fs_ctx->hws_pool;
-
+	struct mlx5_fs_pool *pool;
+	unsigned long i;
+
+	xa_for_each(&hws_pool->el2tol2tnl_pools, i, pool)
+		destroy_pr_pool(pool, &hws_pool->el2tol2tnl_pools, i);
+	xa_destroy(&hws_pool->el2tol2tnl_pools);
+	xa_for_each(&hws_pool->el2tol3tnl_pools, i, pool)
+		destroy_pr_pool(pool, &hws_pool->el2tol3tnl_pools, i);
+	xa_destroy(&hws_pool->el2tol3tnl_pools);
+	mlx5_fs_hws_pr_pool_cleanup(&hws_pool->dl3tnltol2_pool);
+	mlx5_fs_hws_pr_pool_cleanup(&hws_pool->insert_hdr_pool);
+	mlx5hws_action_destroy(hws_pool->remove_hdr_vlan_action);
 	mlx5hws_action_destroy(hws_pool->decapl2_action);
 	mlx5hws_action_destroy(hws_pool->drop_action);
 	mlx5hws_action_destroy(hws_pool->push_vlan_action);
@@ -74,7 +112,7 @@ static int mlx5_cmd_hws_create_ns(struct mlx5_flow_root_namespace *ns)
 		mlx5_core_err(ns->dev, "Failed to create hws flow namespace\n");
 		return -EOPNOTSUPP;
 	}
-	err = init_hws_actions_pool(&ns->fs_hws_context);
+	err = init_hws_actions_pool(ns->dev, &ns->fs_hws_context);
 	if (err) {
 		mlx5_core_err(ns->dev, "Failed to init hws actions pool\n");
 		mlx5hws_context_close(ns->fs_hws_context.hws_ctx);
@@ -251,6 +289,245 @@ static int mlx5_cmd_hws_destroy_flow_group(struct mlx5_flow_root_namespace *ns,
 	return mlx5hws_bwc_matcher_destroy(fg->fs_hws_matcher.matcher);
 }
 
+static struct mlx5hws_action *
+create_action_remove_header_vlan(struct mlx5hws_context *ctx)
+{
+	u32 flags = MLX5HWS_ACTION_FLAG_HWS_FDB | MLX5HWS_ACTION_FLAG_SHARED;
+	struct mlx5hws_action_remove_header_attr remove_hdr_vlan = {};
+
+	/* MAC anchor not supported in HWS reformat, use VLAN anchor */
+	remove_hdr_vlan.anchor = MLX5_REFORMAT_CONTEXT_ANCHOR_VLAN_START;
+	remove_hdr_vlan.offset = 0;
+	remove_hdr_vlan.size = sizeof(struct vlan_hdr);
+	return mlx5hws_action_create_remove_header(ctx, &remove_hdr_vlan, flags);
+}
+
+static struct mlx5hws_action *
+get_action_remove_header_vlan(struct mlx5_fs_hws_context *fs_ctx,
+			      struct mlx5_pkt_reformat_params *params)
+{
+	if (!params ||
+	    params->param_0 != MLX5_REFORMAT_CONTEXT_ANCHOR_MAC_START ||
+	    params->param_1 != offsetof(struct vlan_ethhdr, h_vlan_proto) ||
+	    params->size != sizeof(struct vlan_hdr))
+		return NULL;
+
+	return fs_ctx->hws_pool.remove_hdr_vlan_action;
+}
+
+static int
+verify_insert_header_params(struct mlx5_core_dev *mdev,
+			    struct mlx5_pkt_reformat_params *params)
+{
+	if ((!params->data && params->size) || (params->data && !params->size) ||
+	    MLX5_CAP_GEN_2(mdev, max_reformat_insert_size) < params->size ||
+	    MLX5_CAP_GEN_2(mdev, max_reformat_insert_offset) < params->param_1) {
+		mlx5_core_err(mdev, "Invalid reformat params for INSERT_HDR\n");
+		return -EINVAL;
+	}
+	if (params->param_0 != MLX5_FS_INSERT_HDR_VLAN_ANCHOR ||
+	    params->param_1 != MLX5_FS_INSERT_HDR_VLAN_OFFSET ||
+	    params->size != MLX5_FS_INSERT_HDR_VLAN_SIZE) {
+		mlx5_core_err(mdev, "Only vlan insert header supported\n");
+		return -EOPNOTSUPP;
+	}
+	return 0;
+}
+
+static int verify_encap_decap_params(struct mlx5_core_dev *dev,
+				     struct mlx5_pkt_reformat_params *params)
+{
+	if (params->param_0 || params->param_1) {
+		mlx5_core_err(dev, "Invalid reformat params\n");
+		return -EINVAL;
+	}
+	return 0;
+}
+
+static struct mlx5_fs_pool *
+get_pr_encap_pool(struct mlx5_core_dev *dev, struct xarray *pr_pools,
+		  enum mlx5hws_action_type reformat_type, size_t size)
+{
+	struct mlx5_fs_pool *pr_pool;
+	unsigned long index = size;
+	int err;
+
+	pr_pool = xa_load(pr_pools, index);
+	if (pr_pool)
+		return pr_pool;
+
+	pr_pool = kzalloc(sizeof(*pr_pool), GFP_KERNEL);
+	if (!pr_pool)
+		return ERR_PTR(-ENOMEM);
+	err = mlx5_fs_hws_pr_pool_init(pr_pool, dev, size, reformat_type);
+	if (err)
+		goto free_pr_pool;
+	err = xa_insert(pr_pools, index, pr_pool, GFP_KERNEL);
+	if (err)
+		goto cleanup_pr_pool;
+	return pr_pool;
+
+cleanup_pr_pool:
+	mlx5_fs_hws_pr_pool_cleanup(pr_pool);
+free_pr_pool:
+	kfree(pr_pool);
+	return ERR_PTR(err);
+}
+
+static void destroy_pr_pool(struct mlx5_fs_pool *pool, struct xarray *pr_pools,
+			    unsigned long index)
+{
+	xa_erase(pr_pools, index);
+	mlx5_fs_hws_pr_pool_cleanup(pool);
+	kfree(pool);
+}
+
+static int
+mlx5_cmd_hws_packet_reformat_alloc(struct mlx5_flow_root_namespace *ns,
+				   struct mlx5_pkt_reformat_params *params,
+				   enum mlx5_flow_namespace_type namespace,
+				   struct mlx5_pkt_reformat *pkt_reformat)
+{
+	struct mlx5_fs_hws_context *fs_ctx = &ns->fs_hws_context;
+	struct mlx5_fs_hws_actions_pool *hws_pool;
+	struct mlx5hws_action *hws_action = NULL;
+	struct mlx5_fs_hws_pr *pr_data = NULL;
+	struct mlx5_fs_pool *pr_pool = NULL;
+	struct mlx5_core_dev *dev = ns->dev;
+	u8 hdr_idx = 0;
+	int err;
+
+	if (!params)
+		return -EINVAL;
+
+	hws_pool = &fs_ctx->hws_pool;
+
+	switch (params->type) {
+	case MLX5_REFORMAT_TYPE_L2_TO_VXLAN:
+	case MLX5_REFORMAT_TYPE_L2_TO_NVGRE:
+	case MLX5_REFORMAT_TYPE_L2_TO_L2_TUNNEL:
+		if (verify_encap_decap_params(dev, params))
+			return -EINVAL;
+		pr_pool = get_pr_encap_pool(dev, &hws_pool->el2tol2tnl_pools,
+					    MLX5HWS_ACTION_TYP_REFORMAT_L2_TO_TNL_L2,
+					    params->size);
+		if (IS_ERR(pr_pool))
+			return PTR_ERR(pr_pool);
+		break;
+	case MLX5_REFORMAT_TYPE_L2_TO_L3_TUNNEL:
+		if (verify_encap_decap_params(dev, params))
+			return -EINVAL;
+		pr_pool = get_pr_encap_pool(dev, &hws_pool->el2tol3tnl_pools,
+					    MLX5HWS_ACTION_TYP_REFORMAT_L2_TO_TNL_L3,
+					    params->size);
+		if (IS_ERR(pr_pool))
+			return PTR_ERR(pr_pool);
+		break;
+	case MLX5_REFORMAT_TYPE_L3_TUNNEL_TO_L2:
+		if (verify_encap_decap_params(dev, params))
+			return -EINVAL;
+		pr_pool = &hws_pool->dl3tnltol2_pool;
+		hdr_idx = params->size == ETH_HLEN ?
+			  MLX5_FS_DL3TNLTOL2_MAC_HDR_IDX :
+			  MLX5_FS_DL3TNLTOL2_MAC_VLAN_HDR_IDX;
+		break;
+	case MLX5_REFORMAT_TYPE_INSERT_HDR:
+		err = verify_insert_header_params(dev, params);
+		if (err)
+			return err;
+		pr_pool = &hws_pool->insert_hdr_pool;
+		break;
+	case MLX5_REFORMAT_TYPE_REMOVE_HDR:
+		hws_action = get_action_remove_header_vlan(fs_ctx, params);
+		if (!hws_action)
+			mlx5_core_err(dev, "Only vlan remove header supported\n");
+		break;
+	default:
+		mlx5_core_err(ns->dev, "Packet-reformat not supported(%d)\n",
+			      params->type);
+		return -EOPNOTSUPP;
+	}
+
+	if (pr_pool) {
+		pr_data = mlx5_fs_hws_pr_pool_acquire_pr(pr_pool);
+		if (IS_ERR_OR_NULL(pr_data))
+			return !pr_data ? -EINVAL : PTR_ERR(pr_data);
+		hws_action = pr_data->bulk->hws_action;
+		if (!hws_action) {
+			mlx5_core_err(dev,
+				      "Failed allocating packet-reformat action\n");
+			err = -EINVAL;
+			goto release_pr;
+		}
+		pr_data->data = kmemdup(params->data, params->size, GFP_KERNEL);
+		if (!pr_data->data) {
+			err = -ENOMEM;
+			goto release_pr;
+		}
+		pr_data->hdr_idx = hdr_idx;
+		pr_data->data_size = params->size;
+		pkt_reformat->fs_hws_action.pr_data = pr_data;
+	}
+
+	pkt_reformat->owner = MLX5_FLOW_RESOURCE_OWNER_SW;
+	pkt_reformat->fs_hws_action.hws_action = hws_action;
+	return 0;
+
+release_pr:
+	if (pr_pool && pr_data)
+		mlx5_fs_hws_pr_pool_release_pr(pr_pool, pr_data);
+	return err;
+}
+
+static void mlx5_cmd_hws_packet_reformat_dealloc(struct mlx5_flow_root_namespace *ns,
+						 struct mlx5_pkt_reformat *pkt_reformat)
+{
+	struct mlx5_fs_hws_actions_pool *hws_pool = &ns->fs_hws_context.hws_pool;
+	struct mlx5_core_dev *dev = ns->dev;
+	struct mlx5_fs_hws_pr *pr_data;
+	struct mlx5_fs_pool *pr_pool;
+
+	if (pkt_reformat->reformat_type == MLX5_REFORMAT_TYPE_REMOVE_HDR)
+		return;
+
+	if (!pkt_reformat->fs_hws_action.pr_data) {
+		mlx5_core_err(ns->dev, "Failed release packet-reformat\n");
+		return;
+	}
+	pr_data = pkt_reformat->fs_hws_action.pr_data;
+
+	switch (pkt_reformat->reformat_type) {
+	case MLX5_REFORMAT_TYPE_L2_TO_VXLAN:
+	case MLX5_REFORMAT_TYPE_L2_TO_NVGRE:
+	case MLX5_REFORMAT_TYPE_L2_TO_L2_TUNNEL:
+		pr_pool = get_pr_encap_pool(dev, &hws_pool->el2tol2tnl_pools,
+					    MLX5HWS_ACTION_TYP_REFORMAT_L2_TO_TNL_L2,
+					    pr_data->data_size);
+		break;
+	case MLX5_REFORMAT_TYPE_L2_TO_L3_TUNNEL:
+		pr_pool = get_pr_encap_pool(dev, &hws_pool->el2tol2tnl_pools,
+					    MLX5HWS_ACTION_TYP_REFORMAT_L2_TO_TNL_L2,
+					    pr_data->data_size);
+		break;
+	case MLX5_REFORMAT_TYPE_L3_TUNNEL_TO_L2:
+		pr_pool = &hws_pool->dl3tnltol2_pool;
+		break;
+	case MLX5_REFORMAT_TYPE_INSERT_HDR:
+		pr_pool = &hws_pool->insert_hdr_pool;
+		break;
+	default:
+		mlx5_core_err(ns->dev, "Unknown packet-reformat type\n");
+		return;
+	}
+	if (!pkt_reformat->fs_hws_action.pr_data || IS_ERR(pr_pool)) {
+		mlx5_core_err(ns->dev, "Failed release packet-reformat\n");
+		return;
+	}
+	kfree(pr_data->data);
+	mlx5_fs_hws_pr_pool_release_pr(pr_pool, pr_data);
+	pkt_reformat->fs_hws_action.pr_data = NULL;
+}
+
 static const struct mlx5_flow_cmds mlx5_flow_cmds_hws = {
 	.create_flow_table = mlx5_cmd_hws_create_flow_table,
 	.destroy_flow_table = mlx5_cmd_hws_destroy_flow_table,
@@ -258,6 +535,8 @@ static const struct mlx5_flow_cmds mlx5_flow_cmds_hws = {
 	.update_root_ft = mlx5_cmd_hws_update_root_ft,
 	.create_flow_group = mlx5_cmd_hws_create_flow_group,
 	.destroy_flow_group = mlx5_cmd_hws_destroy_flow_group,
+	.packet_reformat_alloc = mlx5_cmd_hws_packet_reformat_alloc,
+	.packet_reformat_dealloc = mlx5_cmd_hws_packet_reformat_dealloc,
 	.create_ns = mlx5_cmd_hws_create_ns,
 	.destroy_ns = mlx5_cmd_hws_destroy_ns,
 	.set_peer = mlx5_cmd_hws_set_peer,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.h
index 256be4234d92..2292eb08ef24 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.h
@@ -5,6 +5,7 @@
 #define _MLX5_FS_HWS_
 
 #include "mlx5hws.h"
+#include "fs_hws_pools.h"
 
 struct mlx5_fs_hws_actions_pool {
 	struct mlx5hws_action *tag_action;
@@ -12,6 +13,11 @@ struct mlx5_fs_hws_actions_pool {
 	struct mlx5hws_action *push_vlan_action;
 	struct mlx5hws_action *drop_action;
 	struct mlx5hws_action *decapl2_action;
+	struct mlx5hws_action *remove_hdr_vlan_action;
+	struct mlx5_fs_pool insert_hdr_pool;
+	struct mlx5_fs_pool dl3tnltol2_pool;
+	struct xarray el2tol3tnl_pools;
+	struct xarray el2tol2tnl_pools;
 };
 
 struct mlx5_fs_hws_context {
@@ -24,6 +30,12 @@ struct mlx5_fs_hws_table {
 	bool miss_ft_set;
 };
 
+struct mlx5_fs_hws_action {
+	struct mlx5hws_action *hws_action;
+	struct mlx5_fs_pool *fs_pool;
+	struct mlx5_fs_hws_pr *pr_data;
+};
+
 struct mlx5_fs_hws_matcher {
 	struct mlx5hws_bwc_matcher *matcher;
 };
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws_pools.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws_pools.c
new file mode 100644
index 000000000000..14f732f3f09c
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws_pools.c
@@ -0,0 +1,238 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+/* Copyright (c) 2024 NVIDIA Corporation & Affiliates */
+
+#include <mlx5_core.h>
+#include "fs_hws_pools.h"
+
+#define MLX5_FS_HWS_DEFAULT_BULK_LEN 65536
+#define MLX5_FS_HWS_POOL_MAX_THRESHOLD BIT(18)
+#define MLX5_FS_HWS_POOL_USED_BUFF_RATIO 10
+
+static struct mlx5hws_action *
+dl3tnltol2_bulk_action_create(struct mlx5hws_context *ctx)
+{
+	struct mlx5hws_action_reformat_header reformat_hdr[2] = {};
+	u32 flags = MLX5HWS_ACTION_FLAG_HWS_FDB;
+	enum mlx5hws_action_type reformat_type;
+	u32 log_bulk_size;
+
+	reformat_type = MLX5HWS_ACTION_TYP_REFORMAT_TNL_L3_TO_L2;
+	reformat_hdr[MLX5_FS_DL3TNLTOL2_MAC_HDR_IDX].sz = ETH_HLEN;
+	reformat_hdr[MLX5_FS_DL3TNLTOL2_MAC_VLAN_HDR_IDX].sz = ETH_HLEN + VLAN_HLEN;
+
+	log_bulk_size = ilog2(MLX5_FS_HWS_DEFAULT_BULK_LEN);
+	return mlx5hws_action_create_reformat(ctx, reformat_type, 2,
+					      reformat_hdr, log_bulk_size, flags);
+}
+
+static struct mlx5hws_action *
+el2tol3tnl_bulk_action_create(struct mlx5hws_context *ctx, size_t data_size)
+{
+	struct mlx5hws_action_reformat_header reformat_hdr = {};
+	u32 flags = MLX5HWS_ACTION_FLAG_HWS_FDB;
+	enum mlx5hws_action_type reformat_type;
+	u32 log_bulk_size;
+
+	reformat_type = MLX5HWS_ACTION_TYP_REFORMAT_L2_TO_TNL_L3;
+	reformat_hdr.sz = data_size;
+
+	log_bulk_size = ilog2(MLX5_FS_HWS_DEFAULT_BULK_LEN);
+	return mlx5hws_action_create_reformat(ctx, reformat_type, 1,
+					      &reformat_hdr, log_bulk_size, flags);
+}
+
+static struct mlx5hws_action *
+el2tol2tnl_bulk_action_create(struct mlx5hws_context *ctx, size_t data_size)
+{
+	struct mlx5hws_action_reformat_header reformat_hdr = {};
+	u32 flags = MLX5HWS_ACTION_FLAG_HWS_FDB;
+	enum mlx5hws_action_type reformat_type;
+	u32 log_bulk_size;
+
+	reformat_type = MLX5HWS_ACTION_TYP_REFORMAT_L2_TO_TNL_L2;
+	reformat_hdr.sz = data_size;
+
+	log_bulk_size = ilog2(MLX5_FS_HWS_DEFAULT_BULK_LEN);
+	return mlx5hws_action_create_reformat(ctx, reformat_type, 1,
+					      &reformat_hdr, log_bulk_size, flags);
+}
+
+static struct mlx5hws_action *
+insert_hdr_bulk_action_create(struct mlx5hws_context *ctx)
+{
+	struct mlx5hws_action_insert_header insert_hdr = {};
+	u32 flags = MLX5HWS_ACTION_FLAG_HWS_FDB;
+	u32 log_bulk_size;
+
+	log_bulk_size = ilog2(MLX5_FS_HWS_DEFAULT_BULK_LEN);
+	insert_hdr.hdr.sz = MLX5_FS_INSERT_HDR_VLAN_SIZE;
+	insert_hdr.anchor = MLX5_FS_INSERT_HDR_VLAN_ANCHOR;
+	insert_hdr.offset = MLX5_FS_INSERT_HDR_VLAN_OFFSET;
+
+	return mlx5hws_action_create_insert_header(ctx, 1, &insert_hdr,
+						   log_bulk_size, flags);
+}
+
+static struct mlx5hws_action *
+pr_bulk_action_create(struct mlx5_core_dev *dev,
+		      struct mlx5_fs_hws_pr_pool_ctx *pr_pool_ctx)
+{
+	struct mlx5_flow_root_namespace *root_ns;
+	struct mlx5hws_context *ctx;
+	size_t encap_data_size;
+
+	root_ns = mlx5_get_root_namespace(dev, MLX5_FLOW_NAMESPACE_FDB);
+	if (!root_ns || root_ns->mode != MLX5_FLOW_STEERING_MODE_HMFS)
+		return NULL;
+
+	ctx = root_ns->fs_hws_context.hws_ctx;
+	if (!ctx)
+		return NULL;
+
+	encap_data_size = pr_pool_ctx->encap_data_size;
+	switch (pr_pool_ctx->reformat_type) {
+	case MLX5HWS_ACTION_TYP_REFORMAT_TNL_L3_TO_L2:
+		return dl3tnltol2_bulk_action_create(ctx);
+	case MLX5HWS_ACTION_TYP_REFORMAT_L2_TO_TNL_L3:
+		return el2tol3tnl_bulk_action_create(ctx, encap_data_size);
+	case MLX5HWS_ACTION_TYP_REFORMAT_L2_TO_TNL_L2:
+		return el2tol2tnl_bulk_action_create(ctx, encap_data_size);
+	case MLX5HWS_ACTION_TYP_INSERT_HEADER:
+		return insert_hdr_bulk_action_create(ctx);
+	default:
+		return NULL;
+	}
+	return NULL;
+}
+
+static struct mlx5_fs_bulk *
+mlx5_fs_hws_pr_bulk_create(struct mlx5_core_dev *dev, void *pool_ctx)
+{
+	struct mlx5_fs_hws_pr_pool_ctx *pr_pool_ctx;
+	struct mlx5_fs_hws_pr_bulk *pr_bulk;
+	int bulk_len;
+	int i;
+
+	if (!pool_ctx)
+		return NULL;
+	pr_pool_ctx = pool_ctx;
+	bulk_len = MLX5_FS_HWS_DEFAULT_BULK_LEN;
+	pr_bulk = kvzalloc(struct_size(pr_bulk, prs_data, bulk_len), GFP_KERNEL);
+	if (!pr_bulk)
+		return NULL;
+
+	if (mlx5_fs_bulk_init(dev, &pr_bulk->fs_bulk, bulk_len))
+		goto free_pr_bulk;
+
+	for (i = 0; i < bulk_len; i++) {
+		pr_bulk->prs_data[i].bulk = pr_bulk;
+		pr_bulk->prs_data[i].offset = i;
+	}
+
+	pr_bulk->hws_action = pr_bulk_action_create(dev, pr_pool_ctx);
+	if (!pr_bulk->hws_action)
+		goto cleanup_fs_bulk;
+
+	return &pr_bulk->fs_bulk;
+
+cleanup_fs_bulk:
+	mlx5_fs_bulk_cleanup(&pr_bulk->fs_bulk);
+free_pr_bulk:
+	kvfree(pr_bulk);
+	return NULL;
+}
+
+static int
+mlx5_fs_hws_pr_bulk_destroy(struct mlx5_core_dev *dev, struct mlx5_fs_bulk *fs_bulk)
+{
+	struct mlx5_fs_hws_pr_bulk *pr_bulk;
+
+	pr_bulk = container_of(fs_bulk, struct mlx5_fs_hws_pr_bulk, fs_bulk);
+	if (mlx5_fs_bulk_get_free_amount(fs_bulk) < fs_bulk->bulk_len) {
+		mlx5_core_err(dev, "Freeing bulk before all reformats were released\n");
+		return -EBUSY;
+	}
+
+	mlx5hws_action_destroy(pr_bulk->hws_action);
+	mlx5_fs_bulk_cleanup(fs_bulk);
+	kvfree(pr_bulk);
+
+	return 0;
+}
+
+static void mlx5_hws_pool_update_threshold(struct mlx5_fs_pool *hws_pool)
+{
+	hws_pool->threshold = min_t(int, MLX5_FS_HWS_POOL_MAX_THRESHOLD,
+				    hws_pool->used_units / MLX5_FS_HWS_POOL_USED_BUFF_RATIO);
+}
+
+static const struct mlx5_fs_pool_ops mlx5_fs_hws_pr_pool_ops = {
+	.bulk_create = mlx5_fs_hws_pr_bulk_create,
+	.bulk_destroy = mlx5_fs_hws_pr_bulk_destroy,
+	.update_threshold = mlx5_hws_pool_update_threshold,
+};
+
+int mlx5_fs_hws_pr_pool_init(struct mlx5_fs_pool *pr_pool,
+			     struct mlx5_core_dev *dev, size_t encap_data_size,
+			     enum mlx5hws_action_type reformat_type)
+{
+	struct mlx5_fs_hws_pr_pool_ctx *pr_pool_ctx;
+
+	if (reformat_type != MLX5HWS_ACTION_TYP_INSERT_HEADER &&
+	    reformat_type != MLX5HWS_ACTION_TYP_REFORMAT_TNL_L3_TO_L2 &&
+	    reformat_type != MLX5HWS_ACTION_TYP_REFORMAT_L2_TO_TNL_L3 &&
+	    reformat_type != MLX5HWS_ACTION_TYP_REFORMAT_L2_TO_TNL_L2)
+		return -EOPNOTSUPP;
+
+	pr_pool_ctx = kzalloc(sizeof(*pr_pool_ctx), GFP_KERNEL);
+	if (!pr_pool_ctx)
+		return -ENOMEM;
+	pr_pool_ctx->reformat_type = reformat_type;
+	pr_pool_ctx->encap_data_size = encap_data_size;
+	mlx5_fs_pool_init(pr_pool, dev, &mlx5_fs_hws_pr_pool_ops, pr_pool_ctx);
+	return 0;
+}
+
+void mlx5_fs_hws_pr_pool_cleanup(struct mlx5_fs_pool *pr_pool)
+{
+	struct mlx5_fs_hws_pr_pool_ctx *pr_pool_ctx;
+
+	mlx5_fs_pool_cleanup(pr_pool);
+	pr_pool_ctx = pr_pool->pool_ctx;
+	if (!pr_pool_ctx)
+		return;
+	kfree(pr_pool_ctx);
+}
+
+struct mlx5_fs_hws_pr *
+mlx5_fs_hws_pr_pool_acquire_pr(struct mlx5_fs_pool *pr_pool)
+{
+	struct mlx5_fs_pool_index pool_index = {};
+	struct mlx5_fs_hws_pr_bulk *pr_bulk;
+	int err;
+
+	err = mlx5_fs_pool_acquire_index(pr_pool, &pool_index);
+	if (err)
+		return ERR_PTR(err);
+	pr_bulk = container_of(pool_index.fs_bulk, struct mlx5_fs_hws_pr_bulk,
+			       fs_bulk);
+	return &pr_bulk->prs_data[pool_index.index];
+}
+
+void mlx5_fs_hws_pr_pool_release_pr(struct mlx5_fs_pool *pr_pool,
+				    struct mlx5_fs_hws_pr *pr_data)
+{
+	struct mlx5_fs_bulk *fs_bulk = &pr_data->bulk->fs_bulk;
+	struct mlx5_fs_pool_index pool_index = {};
+	struct mlx5_core_dev *dev = pr_pool->dev;
+
+	pool_index.fs_bulk = fs_bulk;
+	pool_index.index = pr_data->offset;
+	if (mlx5_fs_pool_release_index(pr_pool, &pool_index))
+		mlx5_core_warn(dev, "Attempted to release packet reformat which is not acquired\n");
+}
+
+struct mlx5hws_action *mlx5_fs_hws_pr_get_action(struct mlx5_fs_hws_pr *pr_data)
+{
+	return pr_data->bulk->hws_action;
+}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws_pools.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws_pools.h
new file mode 100644
index 000000000000..93ec5b3b76fe
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws_pools.h
@@ -0,0 +1,48 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
+/* Copyright (c) 2024 NVIDIA Corporation & Affiliates */
+
+#ifndef __MLX5_FS_HWS_POOLS_H__
+#define __MLX5_FS_HWS_POOLS_H__
+
+#include <linux/if_vlan.h>
+#include "fs_pool.h"
+#include "fs_core.h"
+
+#define MLX5_FS_INSERT_HDR_VLAN_ANCHOR MLX5_REFORMAT_CONTEXT_ANCHOR_MAC_START
+#define MLX5_FS_INSERT_HDR_VLAN_OFFSET offsetof(struct vlan_ethhdr, h_vlan_proto)
+#define MLX5_FS_INSERT_HDR_VLAN_SIZE sizeof(struct vlan_hdr)
+
+enum {
+	MLX5_FS_DL3TNLTOL2_MAC_HDR_IDX = 0,
+	MLX5_FS_DL3TNLTOL2_MAC_VLAN_HDR_IDX,
+};
+
+struct mlx5_fs_hws_pr {
+	struct mlx5_fs_hws_pr_bulk *bulk;
+	u32 offset;
+	u8 hdr_idx;
+	u8 *data;
+	size_t data_size;
+};
+
+struct mlx5_fs_hws_pr_bulk {
+	struct mlx5_fs_bulk fs_bulk;
+	struct mlx5hws_action *hws_action;
+	struct mlx5_fs_hws_pr prs_data[];
+};
+
+struct mlx5_fs_hws_pr_pool_ctx {
+	enum mlx5hws_action_type reformat_type;
+	size_t encap_data_size;
+};
+
+int mlx5_fs_hws_pr_pool_init(struct mlx5_fs_pool *pr_pool,
+			     struct mlx5_core_dev *dev, size_t encap_data_size,
+			     enum mlx5hws_action_type reformat_type);
+void mlx5_fs_hws_pr_pool_cleanup(struct mlx5_fs_pool *pr_pool);
+
+struct mlx5_fs_hws_pr *mlx5_fs_hws_pr_pool_acquire_pr(struct mlx5_fs_pool *pr_pool);
+void mlx5_fs_hws_pr_pool_release_pr(struct mlx5_fs_pool *pr_pool,
+				    struct mlx5_fs_hws_pr *pr_data);
+struct mlx5hws_action *mlx5_fs_hws_pr_get_action(struct mlx5_fs_hws_pr *pr_data);
+#endif /* __MLX5_FS_HWS_POOLS_H__ */
diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index 370f533da107..bb99a35fc6a2 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -7025,6 +7025,7 @@ struct mlx5_ifc_alloc_packet_reformat_context_out_bits {
 
 enum {
 	MLX5_REFORMAT_CONTEXT_ANCHOR_MAC_START = 0x1,
+	MLX5_REFORMAT_CONTEXT_ANCHOR_VLAN_START = 0x2,
 	MLX5_REFORMAT_CONTEXT_ANCHOR_IP_START = 0x7,
 	MLX5_REFORMAT_CONTEXT_ANCHOR_TCP_UDP_START = 0x9,
 };
-- 
2.45.0


