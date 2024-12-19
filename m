Return-Path: <netdev+bounces-153475-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8AF29F82C3
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 19:00:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D53C164531
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 18:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113E11A0728;
	Thu, 19 Dec 2024 17:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aP5BnbeI"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDAD819E965
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 17:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734631193; cv=fail; b=rKxo+VFGlHnsELoojAKyPovGfs8kI9dL3PUn6N0zR8/OEyw0hCRfbokbPNdXcld/cWBNN0zKppGQWiDbLrmnWFrVuCFNE0P+VZwzQkXMYHdcrJN5iTwDMTWy/bRwQWfRiOYDg9H3RFreC6f50O3+eI3Ec5QQcXlId3K9b2ehP0M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734631193; c=relaxed/simple;
	bh=d7gCAhKbmxHWo2MPCMzo8ubyyFeqkDeU7JDn4RFctZ0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KEndHoVN9nskw2sUmXFfrjy3rrKWCMeMWlg/04IJ2DIDJhqYaRqyOakmv3K+7/6pxdj87mHipTMjKwzKR4A8nPHz+yqSOYruO+v6yvl/oE3/TQUYPFsToD6flhq1JDvA+FOPEzq8td1EMQh+I7ieSI336EgVT4/p9bGx3pcPXRA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aP5BnbeI; arc=fail smtp.client-ip=40.107.244.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pJNcZ5De6YtVh9J7QcwPhTEp5yr9ZBwGPl/MUQRH5hIoBtdYhgHw55CYwGvogXOAlvBRflriGfU4tn83usUMvuw6QuNnZHsdyn0JsxbpjRPvTPZ33ku6mgyqYx44ozAVKT5OixNRYQfRLxHsl/ehNJzbJbP5qvijawH6Hd9kIED/JzNeHMuDKSg8jzLQWKzO2dXqmiKHyOzIWbooA1Egdm0uiE5OLRNAFwAdEbefqAwaXNn8ffiezfEru4TuhIFE7un6BgLhrZzood7GRWaluA94iYlb557LECNgmazPXmR0+czVGtrzd3XR+NB+2aDoQo2F2Ff40PNf30ze9IBM3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oIm/VUqXdoalGNNYFVTqcfSYJusnL8jM6VXt/8Rdx60=;
 b=zFINfWU0Z+j3sORflMSRwDgwSb/hlhSEDSSYXqo8NbU+s+hA4oymhJ1HMtE6d4SXC6dLqS99XNvZ+fNWi00eYvu81eO35TZBP2iGpm8isKWmC/SwE7caFLNnVl5oTLzw6mUuXthWg+z+rV1OFVOam34w37s4ZNUaS7UjO0hZJ3HmY+xJN6dHL+K9v4dOFMOXU1l04JStIhgGfvi2h0a8ssTqEInKQeyja8kIyXo3FxDen7Yr1MMmKbM18dgZpycCEYYYxKtpDlCM54QtlSX3+zEb80tzalCBEbaSjzcQY2GyMcBCagDHuFP/rhP1NX+tnOopSjdfnLpPDBT26lQ6dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oIm/VUqXdoalGNNYFVTqcfSYJusnL8jM6VXt/8Rdx60=;
 b=aP5BnbeIaWuatE9+AQATG49xEVjPZtf/6C3IWOjrW+WAWiUjMIgxWVWmO0cVrkW1abjIuBleShU3XBXp2ZVaY16MOLosyjmgYRjVVJOFbo7+JE3X4i9BiwD97sBI4N3Rv8oT9+Bb/8W9RV4xwvUg2JL9jQuTmijfKFl6cUgMVe2DZbub3FdgkuKlsMr7+OFOuRH/pDjIScgyFoKR5QdT8I5VnhO7dDiONGiO62W/PlC6cJuDou9qqvIYKSMZFZv/FucBqz3Q3En20VT50PLlQqOVBR+FRubagO0SOKRFUo5w8BAA5CoAws447HuTCztp32wjx+cKYDLhTy+2QCXMLg==
Received: from CYZPR14CA0015.namprd14.prod.outlook.com (2603:10b6:930:8f::9)
 by SN7PR12MB8001.namprd12.prod.outlook.com (2603:10b6:806:340::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.14; Thu, 19 Dec
 2024 17:59:46 +0000
Received: from CY4PEPF0000EE30.namprd05.prod.outlook.com
 (2603:10b6:930:8f:cafe::30) by CYZPR14CA0015.outlook.office365.com
 (2603:10b6:930:8f::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.25 via Frontend Transport; Thu,
 19 Dec 2024 17:59:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE30.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15 via Frontend Transport; Thu, 19 Dec 2024 17:59:45 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 19 Dec
 2024 09:59:33 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 19 Dec
 2024 09:59:32 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Thu, 19 Dec
 2024 09:59:29 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, "Moshe
 Shemesh" <moshe@nvidia.com>, Yevgeny Kliteynik <kliteyn@nvidia.com>, "Tariq
 Toukan" <tariqt@nvidia.com>
Subject: [PATCH net-next V4 04/11] net/mlx5: fs, add mlx5_fs_pool API
Date: Thu, 19 Dec 2024 19:58:34 +0200
Message-ID: <20241219175841.1094544-5-tariqt@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20241219175841.1094544-1-tariqt@nvidia.com>
References: <20241219175841.1094544-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE30:EE_|SN7PR12MB8001:EE_
X-MS-Office365-Filtering-Correlation-Id: be97882a-51d8-4505-bb93-08dd2056ec41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LceRNuadKzlt1DWJi+aH0h4qD24FwZRfDYxtyaa4aDSywrJqXbh6SB0dKAct?=
 =?us-ascii?Q?C6rYlIylZ8ELYD2/wu3IYEASRQ+0zYUAiXxeoLUiaaxTrvf3XLatteXAGlmb?=
 =?us-ascii?Q?DJNgx07TSOBaROJ/SdW4jo3+WrmynL27yZ9hm1/ERMc7CB2Rlyqflr6rbw42?=
 =?us-ascii?Q?lKIF2LQFMtyDKwycoV54Uib8Lgc4+SJ0ZPAh0tAfm0je+tNP6itD0HW/nWQW?=
 =?us-ascii?Q?oJWJ/SNrsLbKhtIx3mtzuz5lf4mfbCVsYqRM8Q+EeLSD/mir2T4dJK7yGk6N?=
 =?us-ascii?Q?k9+/Uc06+WY/F2Nzn8Ao97zToikmblk5OHwa/3ctt/fu57RPLRjenAqg3DyU?=
 =?us-ascii?Q?b1t4q1cXTKyqiUqY/fi2gn1Ir2nNzTy/7icDSrrVmSj+zaFOWg3xTzvItBAP?=
 =?us-ascii?Q?jUazcBtwbW6gMcW34Wol4mhihxZb4xfZTtj8rCMbtPJnwzHJ8HlZG+dpjERY?=
 =?us-ascii?Q?jXrKBJTkZPS7cahtdhVOflBNMYMU+gX8yXdtF+Za3jsNJE7zlJ/PS7j+5KjB?=
 =?us-ascii?Q?Dfm0e7HAuTjRcHLnmhtdheTNxgbEX+67RKeyfarE/+OLxOOPDvTHw3xb/hVw?=
 =?us-ascii?Q?GC0Rtrs0jaXibtqtb/XOWYa6g7KdoOcGYh81Mhjq1JVBab/MgMqjgsX8SvHH?=
 =?us-ascii?Q?ZWyBYd/pYi8qYXdH3o/3JtDO+kvrYO2+wI9JFVN4dudxxSCzz1+A23x00zsb?=
 =?us-ascii?Q?G+lvi6/WCv85UiL+Eo//AKu7JtMXOB02OjE35eq2O/Lxo60OK2BXbpTSHMXE?=
 =?us-ascii?Q?6Nj64NSIGtFnXJyoDMwHWIehEe2dev7LdIEMIkWVMnxzLgZ//EmIJxdchUNh?=
 =?us-ascii?Q?BpK+gHI+2GycT31Yvh0SEUhx07udJ8HmgNxj0L3y1CRhpiMKMlQuk4LpxGQu?=
 =?us-ascii?Q?MQWT58RNpYnErIohtLyfPmzvtgAQEY9nzELdakIKogt9nnow9v+O6BmvQ5Wz?=
 =?us-ascii?Q?V4Cpq6CPE/7fpdLLCw1tFcGPfz6AEDQwrmNDqr1P4rOSvMVhhgGxrXdrLZly?=
 =?us-ascii?Q?2/JvJroV7KX/H5swmjiOhVW45ZcWj7xoX2KVCvjm811MJay5wS/TqY4jxQbb?=
 =?us-ascii?Q?LZgmsj3mzaaPj1JVQBFo8OpW8Cwx46JhhJuKJ022oZIq7eLTR30lfYfPqCjE?=
 =?us-ascii?Q?qRkbR6WK+wKyWYlvDdKu+sVgYFV7rouk6it0U8b4acsfFmUPAVJeDw39+XS7?=
 =?us-ascii?Q?0cg88AxxMBKriVSH60gyAh+AGWAsGccA9TRuehzjiqoxJ6HpSinrkLxVyaAb?=
 =?us-ascii?Q?PuPWHEpbtODFKoKTDAMK/OlYpLZAyqUk8CeGExiuUTsJYNJd95Y/a589J+o/?=
 =?us-ascii?Q?Vov96CNx7xMD0ygVNJfJKZWv5zEkxLqMis4WITXKJyRX7TLXaRZkqekvaGGM?=
 =?us-ascii?Q?Ow8K58uLIpXaRFCS9ISI1AMBbRHPuadHsSGsXAJL1pNAybU7B3TVMdW0mcqL?=
 =?us-ascii?Q?5fZyggMbh3pSxwd0rXCPKBameGU6QbKinMYHVSodlbEQ7LIraf/3jHrjdlnd?=
 =?us-ascii?Q?WBnXBQb/DAZVXRM=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2024 17:59:45.8391
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be97882a-51d8-4505-bb93-08dd2056ec41
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE30.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8001

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
 .../ethernet/mellanox/mlx5/core/fs_counters.c | 286 +++++-------------
 .../net/ethernet/mellanox/mlx5/core/fs_pool.c | 194 ++++++++++++
 .../net/ethernet/mellanox/mlx5/core/fs_pool.h |  54 ++++
 4 files changed, 327 insertions(+), 209 deletions(-)
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
index 7d56deaa4609..d8e1c4ebd364 100644
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
+		goto fc_bulk_free;
 
-	err = mlx5_cmd_fc_bulk_alloc(dev, alloc_bitmask, &base_id);
-	if (err)
-		goto err_mlx5_cmd_bulk_alloc;
-
-	bulk->base_id = base_id;
-	bulk->bulk_len = bulk_len;
-	for (i = 0; i < bulk_len; i++) {
-		mlx5_fc_init(&bulk->fcs[i], bulk, base_id + i);
-		set_bit(i, bulk->bitmask);
-	}
+	if (mlx5_cmd_fc_bulk_alloc(dev, alloc_bitmask, &base_id))
+		goto fs_bulk_cleanup;
+	fc_bulk->base_id = base_id;
+	for (i = 0; i < bulk_len; i++)
+		mlx5_fc_init(&fc_bulk->fcs[i], fc_bulk, base_id + i);
 
-	return bulk;
+	return &fc_bulk->fs_bulk;
 
-err_mlx5_cmd_bulk_alloc:
-	kvfree(bulk->bitmask);
-err_alloc_bitmask:
-	kvfree(bulk);
-err_alloc_bulk:
-	return ERR_PTR(err);
+fs_bulk_cleanup:
+	mlx5_fs_bulk_cleanup(&fc_bulk->fs_bulk);
+fc_bulk_free:
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
 
-	clear_bit(free_fc_index, bulk->bitmask);
-	return &bulk->fcs[free_fc_index];
+static const struct mlx5_fs_pool_ops mlx5_fc_pool_ops = {
+	.bulk_destroy = mlx5_fc_bulk_destroy,
+	.bulk_create = mlx5_fc_bulk_create,
+	.update_threshold = mlx5_fc_pool_update_threshold,
+};
+
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
@@ -573,7 +581,7 @@ mlx5_fc_local_create(u32 counter_id, u32 offset, u32 bulk_size)
 	counter->type = MLX5_FC_TYPE_LOCAL;
 	counter->id = counter_id;
 	fc_bulk->base_id = counter_id - offset;
-	fc_bulk->bulk_len = bulk_size;
+	fc_bulk->fs_bulk.bulk_len = bulk_size;
 	counter->bulk = fc_bulk;
 	return counter;
 }
@@ -588,141 +596,3 @@ void mlx5_fc_local_destroy(struct mlx5_fc *counter)
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


