Return-Path: <netdev+bounces-145083-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A969C9512
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 23:11:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CE4FB26B7D
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 22:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B251B0F29;
	Thu, 14 Nov 2024 22:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="o+hyiKXi"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234EC1B0F28
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 22:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731622268; cv=fail; b=d2h9zd8uh0VAvfAAnvfPIKGfkayMzxTqBtIhWwanDshIWymt7kMoiey6v0vKxRec8gfR9j/KJX3Zc5xNbamQ07UfCaKhtzgP4FLA3oWzBCFPxPWY0uq/ftJrf2AkvTBRXeJHtWonCVYUNdQu29k7iSfBIhJScEWiiQG5C6jke1w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731622268; c=relaxed/simple;
	bh=HHQBwq5ADf0bXfPgumfWvXEFjc1ZGxHBo3kXBWpRUHE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y1AaRcDsAdmgfNGTzhhWcBFk0jKJWDCaabgauhYyBw0YpJwcWKm+9Hj1mm4T8wUgkElvgCQpteiEwBTldvjhUmdI/F+E0k88laYKhoDX3xRi0UUpWhRZEtQ2mEcI56WVReUSL+mBAESbdhhaiJ1sZ45ZZub+TF7EsWPB74CMIGs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=o+hyiKXi; arc=fail smtp.client-ip=40.107.237.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fllUFKAGRsAb5cvWGh3R0n7b7DKUn0HGEibZPj88DQRoRldu2kns13kWq7jkujW7fB6SNrwTo8kfmbICU5jKbDNM7hD/Sycm2Uz1BMd/H+y3I21iGHM0N7Nj4SgAVUAa/DZfl2uqs+QumIIg/d4XNcI9BTvuAlpqpMUpIa1mHGDxWxGI5cfDWKalNHRHmEdw/vq7p8ApWv31Q9Z0xHdVz9JUWHLMTc35NTkmFilQBSHjy6jD0J+h5CPdfi3R5T/pfiSorWUngqBLEk1Ig/7xjK5dQ/vgConR+SN2UOtorIrJXgdIgUm+z2UDl55LYtmttFpBlumMze9TOsKatvUddA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4+upgNhb0qBf2vf5sDE2ZbMR602z7NkjUpdlQgg6YOs=;
 b=r7D1bqxcp4ODy6aNA6k/co/nULmnbsNJzzA3megsKPvXvcpXUsiLoz9L2wAc16tf2ULLZyIp1fhtzCdw6WeYnxOuuDDdIJd6NEnWyOOc0xagMDOsJnTC3aZnuNhWfFy7tnVFFJcEgPdQhEslIxyr+KiWP8eSq7coFXLluCN8GcFrg+hqU4bkLEIVaGGppynGrRLfeFNaZEtxP/buCjnC5T+/0ApyiG3Xqtk3LambFzB1iOBdeDbLcCAr8gnYYcWKJ1EYDVsvewt0X/1sO54x9NG51k3cmcrS538G5Q0p2LFy2OwJXNYWt4FiYQu4rWYMVBhCZZvDqofB4WwZpyeRkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4+upgNhb0qBf2vf5sDE2ZbMR602z7NkjUpdlQgg6YOs=;
 b=o+hyiKXiJ8mA7Cnm+RkFogw72ejjP/kkLsNqUMgneFAScSpAdVQvTbFvZPc+9EJOlzLcLCWl8/r2UNw0iSRPfzBpc14ywFGL+DZh+/FTEVLo4cydetGJ79olW0YJmSwmJgeeoLxLbrUpQm2VbgXKkbJbTZlcEOmVUEwjl/WhoKJIoTDfuTi5pZ0ws0c7foEgdxELKSUPJR3UfweGauw867MuHy4RLTpKPdBqmGKKyxmnp7u9X9xscpr2hwhtJxhQhqN3ysz5DFNbDYMYgBhKzTUzKmWy77YT5BNBztdpUMGkumybZi8EoHGtIMoJH+vbQ0dQoV8W0GH2EwdDqiwLUQ==
Received: from PH0P220CA0009.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::13)
 by SJ0PR12MB6966.namprd12.prod.outlook.com (2603:10b6:a03:449::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.16; Thu, 14 Nov
 2024 22:11:01 +0000
Received: from CY4PEPF0000FCC0.namprd03.prod.outlook.com
 (2603:10b6:510:d3:cafe::65) by PH0P220CA0009.outlook.office365.com
 (2603:10b6:510:d3::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18 via Frontend
 Transport; Thu, 14 Nov 2024 22:11:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000FCC0.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.14 via Frontend Transport; Thu, 14 Nov 2024 22:11:00 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 14 Nov
 2024 14:10:44 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 14 Nov
 2024 14:10:44 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Thu, 14 Nov
 2024 14:10:40 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Jiri Pirko
	<jiri@resnulli.us>, Carolina Jubran <cjubran@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next V2 3/8] devlink: Extend devlink rate API with traffic classes bandwidth management
Date: Fri, 15 Nov 2024 00:09:32 +0200
Message-ID: <20241114220937.719507-4-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241114220937.719507-1-tariqt@nvidia.com>
References: <20241114220937.719507-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC0:EE_|SJ0PR12MB6966:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f8230f5-d5fc-446b-f74c-08dd04f93945
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QAFizIAdsmXGDMQa80M+PqUx3FLAIdjRWNq9c50qpEw5dHOuC0Nsq/WwN8dp?=
 =?us-ascii?Q?YEhJW6frjuefKpNO2HMwfpFMu7+0WsanXdWlf8MBi6jluy2s6wC/eRubCprM?=
 =?us-ascii?Q?NSLOTHq//JWMzHNGceDD/pm8qK6jbkpybechZVcZKmaKmdqhKAUVrBuBpkuS?=
 =?us-ascii?Q?IfK7IjhZ0e7lzcKutoUzbWYUSh90R/hmmOzlfjjer67d+OqWH4bzRo41ZzsW?=
 =?us-ascii?Q?+6tcy+k4N4SI+K2hNuzmSsN9NbXH8mD7+h2cOwQA6gS8MmDROOomxaX1ZlfY?=
 =?us-ascii?Q?ZCIYhMJTlkYKLlO+Fe3b1C8YzpjltM7f8pCRQmTGLcQhHwWJbc8tb+lLqqDa?=
 =?us-ascii?Q?xjop+pdoPN/+NlH1ME7jogixWpLYZROq2KidI9BIYuky8fa2x5v3+5KtAJrQ?=
 =?us-ascii?Q?tZTn3yUvzY4oxul5XEPSQijt6rkLcB6xrj+NGtIfkBrQ/fPA+WqSZVpbSI0n?=
 =?us-ascii?Q?vu33uLbmyjcFXd2avKLFbo3G0GCLLmYOGp8WPgx+e4ko4PMU8cl7hRbSKBH/?=
 =?us-ascii?Q?9wukS3183tvgmmqoROIghiHT//XBXHJkAF5/nJG+3W6837VMweRzCX45AXl5?=
 =?us-ascii?Q?FBVXke24LoxOVGIhhx/eJ9yNku35/1gEToQaHzy5ZyAwSldTy0nviTr1ioCW?=
 =?us-ascii?Q?yDjHsyk5p/PtiIlCifOdMNfxGW/NOImp/WLqQaFkS/2hZ3Y5rBkZXPJjERuH?=
 =?us-ascii?Q?E5ajnQZWcPCwdd645AjNnxvvLg9eOBKTlaMig6f2Yv+En1cD2jHIu3aq3GBM?=
 =?us-ascii?Q?frP05JqNtdzlxckaLIjDrj3v9QtgxcUVREQZ5RjLKZn5e6tOFz3XxeqFD0dR?=
 =?us-ascii?Q?EB6JGETg9FD/JLXyOz0PEOI4cjb9yyr6ql90fMVu0WvAOA0ibbcBvS1g6Azk?=
 =?us-ascii?Q?e3Ym987eIg7pKJ6TeiYpij8ebAnqLFCPhOe5+fmBllDXCJNk2XX3dB8mBdK/?=
 =?us-ascii?Q?X2kerNxXwpspAKeTZM/0dhtMK2tDLO08BEmhog5gSn7Q0cexZngl56gwrgCd?=
 =?us-ascii?Q?Ib0hrmRG3SsueNdPqpoICwJafmH/w+a8ApD3W330dz6Wy5kEGrLRJoirS1JJ?=
 =?us-ascii?Q?pRycOSXmCgG7NB5UWYVfpU7Pj7a7PVz43OgvBHuvTl1pwjbt8GhrR9sMAJ7O?=
 =?us-ascii?Q?Som2dX8FSvsCpWkxeWHzU0lwQ4nd2EcJwQYvmwFBmNOQrQgIneYE14yQUdo/?=
 =?us-ascii?Q?bAqgm6CWJi4Ssn3iy4tr3TZ2mC+OjnUb+8DUWtkrY0zYNsbXOXx+XlCW2GcM?=
 =?us-ascii?Q?fTUqDt0h7Fcuqfr2KAOjDh5fdj5kaz3n8XOlwhr59qafhQupb7ADwjhBTpQz?=
 =?us-ascii?Q?qhDe5kIxtkTy3UWttTaPocfLe+tdLOfe1akBWTxXVW7/nF/MzUQHP10CEV+M?=
 =?us-ascii?Q?U9Mb2yV9Z6xRM9OY91F7tiwf5xJpVMyyLxD+tgdRkwuXciUVLA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 22:11:00.9170
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f8230f5-d5fc-446b-f74c-08dd04f93945
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6966

From: Carolina Jubran <cjubran@nvidia.com>

Introduce support for specifying bandwidth proportions between traffic
classes (TC) in the devlink-rate API. This new option allows users to
allocate bandwidth across multiple traffic classes in a single command.

This feature provides a more granular control over traffic management,
especially for scenarios requiring Enhanced Transmission Selection.

Users can now define a specific bandwidth share for each traffic class,
such as allocating 20% for TC0 (TCP/UDP) and 80% for TC5 (RoCE).

Example:
DEV=pci/0000:08:00.0

$ devlink port function rate add $DEV/vfs_group tx_share 10Gbit \
  tx_max 50Gbit tc-bw 0:20 1:0 2:0 3:0 4:0 5:80 6:0 7:0

$ devlink port function rate set $DEV/vfs_group \
  tc-bw 0:20 1:0 2:0 3:0 4:0 5:10 6:60 7:0

Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 Documentation/netlink/specs/devlink.yaml | 22 ++++++++
 include/net/devlink.h                    |  7 +++
 include/uapi/linux/devlink.h             |  4 ++
 net/devlink/netlink_gen.c                | 15 +++--
 net/devlink/netlink_gen.h                |  1 +
 net/devlink/rate.c                       | 71 +++++++++++++++++++++++-
 6 files changed, 113 insertions(+), 7 deletions(-)

diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
index 09fbb4c03fc8..68211b8218fd 100644
--- a/Documentation/netlink/specs/devlink.yaml
+++ b/Documentation/netlink/specs/devlink.yaml
@@ -817,6 +817,16 @@ attribute-sets:
       -
         name: rate-tx-weight
         type: u32
+      -
+        name: rate-tc-index
+        type: u8
+
+      - name: rate-bw
+        type: u32
+      -
+        name: rate-tc-bw
+        type: nest
+        nested-attributes: dl-rate-tc-bw
       -
         name: region-direct
         type: flag
@@ -1225,6 +1235,16 @@ attribute-sets:
       -
         name: flash
         type: flag
+  -
+    name: dl-rate-tc-bw
+    subset-of: devlink
+    attributes:
+      -
+        name: rate-tc-index
+        type: u8
+      -
+        name: rate-bw
+        type: u32
 
 operations:
   enum-model: directional
@@ -2148,6 +2168,7 @@ operations:
             - rate-tx-max
             - rate-tx-priority
             - rate-tx-weight
+            - rate-tc-bw
             - rate-parent-node-name
 
     -
@@ -2168,6 +2189,7 @@ operations:
             - rate-tx-max
             - rate-tx-priority
             - rate-tx-weight
+            - rate-tc-bw
             - rate-parent-node-name
 
     -
diff --git a/include/net/devlink.h b/include/net/devlink.h
index fbb9a2668e24..277b826cdd60 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -20,6 +20,7 @@
 #include <uapi/linux/devlink.h>
 #include <linux/xarray.h>
 #include <linux/firmware.h>
+#include <linux/dcbnl.h>
 
 struct devlink;
 struct devlink_linecard;
@@ -117,6 +118,8 @@ struct devlink_rate {
 
 	u32 tx_priority;
 	u32 tx_weight;
+
+	u32 tc_bw[IEEE_8021QAZ_MAX_TCS];
 };
 
 struct devlink_port {
@@ -1469,6 +1472,8 @@ struct devlink_ops {
 					 u32 tx_priority, struct netlink_ext_ack *extack);
 	int (*rate_leaf_tx_weight_set)(struct devlink_rate *devlink_rate, void *priv,
 				       u32 tx_weight, struct netlink_ext_ack *extack);
+	int (*rate_leaf_tc_bw_set)(struct devlink_rate *devlink_rate, void *priv,
+				   u32 *tc_bw, struct netlink_ext_ack *extack);
 	int (*rate_node_tx_share_set)(struct devlink_rate *devlink_rate, void *priv,
 				      u64 tx_share, struct netlink_ext_ack *extack);
 	int (*rate_node_tx_max_set)(struct devlink_rate *devlink_rate, void *priv,
@@ -1477,6 +1482,8 @@ struct devlink_ops {
 					 u32 tx_priority, struct netlink_ext_ack *extack);
 	int (*rate_node_tx_weight_set)(struct devlink_rate *devlink_rate, void *priv,
 				       u32 tx_weight, struct netlink_ext_ack *extack);
+	int (*rate_node_tc_bw_set)(struct devlink_rate *devlink_rate, void *priv,
+				   u32 *tc_bw, struct netlink_ext_ack *extack);
 	int (*rate_node_new)(struct devlink_rate *rate_node, void **priv,
 			     struct netlink_ext_ack *extack);
 	int (*rate_node_del)(struct devlink_rate *rate_node, void *priv,
diff --git a/include/uapi/linux/devlink.h b/include/uapi/linux/devlink.h
index 9401aa343673..a66217808dd9 100644
--- a/include/uapi/linux/devlink.h
+++ b/include/uapi/linux/devlink.h
@@ -614,6 +614,10 @@ enum devlink_attr {
 
 	DEVLINK_ATTR_REGION_DIRECT,		/* flag */
 
+	DEVLINK_ATTR_RATE_TC_INDEX,		/* u8 */
+	DEVLINK_ATTR_RATE_BW,			/* u32 */
+	DEVLINK_ATTR_RATE_TC_BW,		/* nested */
+
 	/* Add new attributes above here, update the spec in
 	 * Documentation/netlink/specs/devlink.yaml and re-generate
 	 * net/devlink/netlink_gen.c.
diff --git a/net/devlink/netlink_gen.c b/net/devlink/netlink_gen.c
index f9786d51f68f..fac062ede7a4 100644
--- a/net/devlink/netlink_gen.c
+++ b/net/devlink/netlink_gen.c
@@ -18,6 +18,11 @@ const struct nla_policy devlink_dl_port_function_nl_policy[DEVLINK_PORT_FN_ATTR_
 	[DEVLINK_PORT_FN_ATTR_CAPS] = NLA_POLICY_BITFIELD32(15),
 };
 
+const struct nla_policy devlink_dl_rate_tc_bw_nl_policy[DEVLINK_ATTR_RATE_BW + 1] = {
+	[DEVLINK_ATTR_RATE_TC_INDEX] = { .type = NLA_U8, },
+	[DEVLINK_ATTR_RATE_BW] = { .type = NLA_U32, },
+};
+
 const struct nla_policy devlink_dl_selftest_id_nl_policy[DEVLINK_ATTR_SELFTEST_ID_FLASH + 1] = {
 	[DEVLINK_ATTR_SELFTEST_ID_FLASH] = { .type = NLA_FLAG, },
 };
@@ -496,7 +501,7 @@ static const struct nla_policy devlink_rate_get_dump_nl_policy[DEVLINK_ATTR_DEV_
 };
 
 /* DEVLINK_CMD_RATE_SET - do */
-static const struct nla_policy devlink_rate_set_nl_policy[DEVLINK_ATTR_RATE_TX_WEIGHT + 1] = {
+static const struct nla_policy devlink_rate_set_nl_policy[DEVLINK_ATTR_RATE_TC_BW + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_RATE_NODE_NAME] = { .type = NLA_NUL_STRING, },
@@ -504,11 +509,12 @@ static const struct nla_policy devlink_rate_set_nl_policy[DEVLINK_ATTR_RATE_TX_W
 	[DEVLINK_ATTR_RATE_TX_MAX] = { .type = NLA_U64, },
 	[DEVLINK_ATTR_RATE_TX_PRIORITY] = { .type = NLA_U32, },
 	[DEVLINK_ATTR_RATE_TX_WEIGHT] = { .type = NLA_U32, },
+	[DEVLINK_ATTR_RATE_TC_BW] = NLA_POLICY_NESTED(devlink_dl_rate_tc_bw_nl_policy),
 	[DEVLINK_ATTR_RATE_PARENT_NODE_NAME] = { .type = NLA_NUL_STRING, },
 };
 
 /* DEVLINK_CMD_RATE_NEW - do */
-static const struct nla_policy devlink_rate_new_nl_policy[DEVLINK_ATTR_RATE_TX_WEIGHT + 1] = {
+static const struct nla_policy devlink_rate_new_nl_policy[DEVLINK_ATTR_RATE_TC_BW + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_RATE_NODE_NAME] = { .type = NLA_NUL_STRING, },
@@ -516,6 +522,7 @@ static const struct nla_policy devlink_rate_new_nl_policy[DEVLINK_ATTR_RATE_TX_W
 	[DEVLINK_ATTR_RATE_TX_MAX] = { .type = NLA_U64, },
 	[DEVLINK_ATTR_RATE_TX_PRIORITY] = { .type = NLA_U32, },
 	[DEVLINK_ATTR_RATE_TX_WEIGHT] = { .type = NLA_U32, },
+	[DEVLINK_ATTR_RATE_TC_BW] = NLA_POLICY_NESTED(devlink_dl_rate_tc_bw_nl_policy),
 	[DEVLINK_ATTR_RATE_PARENT_NODE_NAME] = { .type = NLA_NUL_STRING, },
 };
 
@@ -1164,7 +1171,7 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.doit		= devlink_nl_rate_set_doit,
 		.post_doit	= devlink_nl_post_doit,
 		.policy		= devlink_rate_set_nl_policy,
-		.maxattr	= DEVLINK_ATTR_RATE_TX_WEIGHT,
+		.maxattr	= DEVLINK_ATTR_RATE_TC_BW,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
@@ -1174,7 +1181,7 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.doit		= devlink_nl_rate_new_doit,
 		.post_doit	= devlink_nl_post_doit,
 		.policy		= devlink_rate_new_nl_policy,
-		.maxattr	= DEVLINK_ATTR_RATE_TX_WEIGHT,
+		.maxattr	= DEVLINK_ATTR_RATE_TC_BW,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
diff --git a/net/devlink/netlink_gen.h b/net/devlink/netlink_gen.h
index 8f2bd50ddf5e..df37c3ef3113 100644
--- a/net/devlink/netlink_gen.h
+++ b/net/devlink/netlink_gen.h
@@ -13,6 +13,7 @@
 
 /* Common nested types */
 extern const struct nla_policy devlink_dl_port_function_nl_policy[DEVLINK_PORT_FN_ATTR_CAPS + 1];
+extern const struct nla_policy devlink_dl_rate_tc_bw_nl_policy[DEVLINK_ATTR_RATE_BW + 1];
 extern const struct nla_policy devlink_dl_selftest_id_nl_policy[DEVLINK_ATTR_SELFTEST_ID_FLASH + 1];
 
 /* Ops table for devlink */
diff --git a/net/devlink/rate.c b/net/devlink/rate.c
index 8828ffaf6cbc..dbf1d552fae2 100644
--- a/net/devlink/rate.c
+++ b/net/devlink/rate.c
@@ -86,7 +86,9 @@ static int devlink_nl_rate_fill(struct sk_buff *msg,
 				int flags, struct netlink_ext_ack *extack)
 {
 	struct devlink *devlink = devlink_rate->devlink;
+	struct nlattr *nla_tc_bw;
 	void *hdr;
+	int i;
 
 	hdr = genlmsg_put(msg, portid, seq, &devlink_nl_family, flags, cmd);
 	if (!hdr)
@@ -124,10 +126,29 @@ static int devlink_nl_rate_fill(struct sk_buff *msg,
 			devlink_rate->tx_weight))
 		goto nla_put_failure;
 
-	if (devlink_rate->parent)
-		if (nla_put_string(msg, DEVLINK_ATTR_RATE_PARENT_NODE_NAME,
-				   devlink_rate->parent->name))
+	nla_tc_bw = nla_nest_start(msg, DEVLINK_ATTR_RATE_TC_BW);
+	if (!nla_tc_bw)
+		goto nla_put_failure;
+
+	for (i = 0; i < IEEE_8021QAZ_MAX_TCS; i++) {
+		struct nlattr *nla_tc_entry = nla_nest_start(msg, i);
+
+		if (!nla_tc_entry) {
+			nla_nest_cancel(msg, nla_tc_bw);
+			goto nla_put_failure;
+		}
+
+		if (nla_put_u8(msg, DEVLINK_ATTR_RATE_TC_INDEX, i) ||
+		    nla_put_u32(msg, DEVLINK_ATTR_RATE_BW, devlink_rate->tc_bw[i])) {
+			nla_nest_cancel(msg, nla_tc_entry);
+			nla_nest_cancel(msg, nla_tc_bw);
 			goto nla_put_failure;
+		}
+
+		nla_nest_end(msg, nla_tc_entry);
+	}
+
+	nla_nest_end(msg, nla_tc_bw);
 
 	genlmsg_end(msg, hdr);
 	return 0;
@@ -380,6 +401,38 @@ static int devlink_nl_rate_set(struct devlink_rate *devlink_rate,
 		devlink_rate->tx_weight = weight;
 	}
 
+	if (attrs[DEVLINK_ATTR_RATE_TC_BW]) {
+		struct nlattr *nla_tc_bw = attrs[DEVLINK_ATTR_RATE_TC_BW];
+		struct nlattr *tb[DEVLINK_ATTR_RATE_BW + 1];
+		u32 tc_bw[IEEE_8021QAZ_MAX_TCS] = {0};
+		struct nlattr *nla_tc_entry;
+		int rem, tc_index;
+
+		nla_for_each_nested(nla_tc_entry, nla_tc_bw, rem) {
+			err = nla_parse_nested(tb, DEVLINK_ATTR_RATE_BW, nla_tc_entry,
+					       devlink_dl_rate_tc_bw_nl_policy, info->extack);
+			if (err)
+				return err;
+
+			if (tb[DEVLINK_ATTR_RATE_TC_INDEX] && tb[DEVLINK_ATTR_RATE_BW]) {
+				tc_index = nla_get_u8(tb[DEVLINK_ATTR_RATE_TC_INDEX]);
+				tc_bw[tc_index] = nla_get_u32(tb[DEVLINK_ATTR_RATE_BW]);
+			}
+		}
+
+		if (devlink_rate_is_leaf(devlink_rate))
+			err = ops->rate_leaf_tc_bw_set(devlink_rate, devlink_rate->priv,
+						       tc_bw, info->extack);
+		else if (devlink_rate_is_node(devlink_rate))
+			err = ops->rate_node_tc_bw_set(devlink_rate, devlink_rate->priv,
+						       tc_bw, info->extack);
+
+		if (err)
+			return err;
+
+		memcpy(devlink_rate->tc_bw, tc_bw, sizeof(tc_bw));
+	}
+
 	nla_parent = attrs[DEVLINK_ATTR_RATE_PARENT_NODE_NAME];
 	if (nla_parent) {
 		err = devlink_nl_rate_parent_node_set(devlink_rate, info,
@@ -423,6 +476,12 @@ static bool devlink_rate_set_ops_supported(const struct devlink_ops *ops,
 					    "TX weight set isn't supported for the leafs");
 			return false;
 		}
+		if (attrs[DEVLINK_ATTR_RATE_TC_BW] && !ops->rate_leaf_tc_bw_set) {
+			NL_SET_ERR_MSG_ATTR(info->extack,
+					    attrs[DEVLINK_ATTR_RATE_TC_BW],
+					    "TC bandwidth set isn't supported for the leafs");
+			return false;
+		}
 	} else if (type == DEVLINK_RATE_TYPE_NODE) {
 		if (attrs[DEVLINK_ATTR_RATE_TX_SHARE] && !ops->rate_node_tx_share_set) {
 			NL_SET_ERR_MSG(info->extack, "TX share set isn't supported for the nodes");
@@ -449,6 +508,12 @@ static bool devlink_rate_set_ops_supported(const struct devlink_ops *ops,
 					    "TX weight set isn't supported for the nodes");
 			return false;
 		}
+		if (attrs[DEVLINK_ATTR_RATE_TC_BW] && !ops->rate_node_tc_bw_set) {
+			NL_SET_ERR_MSG_ATTR(info->extack,
+					    attrs[DEVLINK_ATTR_RATE_TC_BW],
+					    "TC bandwidth set isn't supported for the nodes");
+			return false;
+		}
 	} else {
 		WARN(1, "Unknown type of rate object");
 		return false;
-- 
2.44.0


