Return-Path: <netdev+bounces-145677-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 083249D05EE
	for <lists+netdev@lfdr.de>; Sun, 17 Nov 2024 21:52:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57336B219C0
	for <lists+netdev@lfdr.de>; Sun, 17 Nov 2024 20:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 792C71DD0D5;
	Sun, 17 Nov 2024 20:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="r+LRlr6r"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785C31DD88B
	for <netdev@vger.kernel.org>; Sun, 17 Nov 2024 20:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731876726; cv=fail; b=Y9/+shqUgbUuEW9+cEUpQ4fcHxXoPNGqzJmOfAY/Nz5YvXVW/CJFaGqATColErGmhRIzHr/lloKt3AeDzHbLqO1T1YzYpIUWKREtKkPNbfri7bXgE3iZnohP3pWxosNo360bMbUnbzOcz031OKGlRZ3A7z7aChlewjIKMIXDzaE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731876726; c=relaxed/simple;
	bh=NBlgLNK5CyuZm3WcFEg+rBEavjcufhWVTCwS4YZ4SLo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LYp/M0x8n4HZscdjFq9JNh13XG4S7B8sgu2U9ckzPY8ULKpt7v9Fo2kIO3HherDfotYRDtngo9FjSiG/gZ8C5bWI6ORAE28vQxgGzSiSBBMGSkvRBxNFs4GXVP/kKxzUaftOpxlj/wFu9jUGKg21sbWZcYmxj2MSiruuHg4FIV0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=r+LRlr6r; arc=fail smtp.client-ip=40.107.223.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TW7ikUBvV6eKEB8Ji7iH0RHScX2zQ2R+W9GmljOED9f6m3kNDTbDEXMCNiLS3XI5tNY/uC1ZE4S3UoJ+OiwkWScMAH3FVz1b/JZK5ImJqmUnxZw5Lny2zHO/22Nrv2SjMenDUxuzvp0/O1+7eRwF9FSA3lVnWCZ9YQKM0c4zwuazM+3zExf2ddS+uj2Dyd6iwKljmayKey87MufpNv9XaVbiAxhvoTGKSi4eqC6GYMby8B4bt5JxVMvqL09KX8qb/IRBCW2L2T7kXpwmzGhb07UB+N30z+XlS25vaVGx9l3a/igMVH+KcZg+W4KDPZR4dIn1BIyi1vIYobC7v/K9Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hVnB9Q3iUr49rfdOSgjzkaEjGg1N16VbCPcU5D/RmkQ=;
 b=QXuBk1lZBPFCROLHBgvuYR878dh5zdvB/3EorYII4mwM07sSbhCkWrbpvB157Mqc0+nrIDuy6WHloI9zBGVVnbQxuHXjWEn14iYrJCLKOszi01Oi7a+qZrGu+c3XKTkTfQ9pVDVuFJijdXHCX2CXEjot8CXOhKQqWBz8uVVhFvfA+yHsvGM4zj85OUZIPRqHU7T6GF5eptBcna7LPn1bgEbsqBytF+HiYkcyh01jiWOeD1bu+8HZ7i5g68n4IIs5Wlx4M7cV7g9+wZjUlxJ/5/jKa8jBwgXaMQEUSCo3j0Txx3p2hF6rBafDf/LuG1mkBY5kCTSAY3y0vZaXya8S8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hVnB9Q3iUr49rfdOSgjzkaEjGg1N16VbCPcU5D/RmkQ=;
 b=r+LRlr6rNevSdFP6V//LVkP20x7mGr9/lf/qwTsUXFxIRuefRpUJOvMheTFlkxLOkn3bZwbCyGoBXZnaaKu7L3G1gP3ox7Yms4yOCpUi6OP9czyyIYnEs8kb9P4l6Duwj/vVsgR19Vlco0mfVwlm8uKgcmP+Muvlpt63Lvjh3TynQXz/Ko2mI/PRfz6GhyZtMnnM4vcox3CbsoQtHv+3aD/WoK1baQlMEq0TETpAoCd8EeHjmMNupG+e0AQ27rg2PJH+AoQn10UTDeldjobKqAab8+Y+4G64scKE6jKX6UJ78eOASjZ4ONVLhq95bsaq2zsWlyRprUoQogTsBA2pEA==
Received: from CH2PR07CA0062.namprd07.prod.outlook.com (2603:10b6:610:5b::36)
 by SJ2PR12MB8009.namprd12.prod.outlook.com (2603:10b6:a03:4c7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.20; Sun, 17 Nov
 2024 20:51:57 +0000
Received: from CH3PEPF0000000B.namprd04.prod.outlook.com
 (2603:10b6:610:5b:cafe::dc) by CH2PR07CA0062.outlook.office365.com
 (2603:10b6:610:5b::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22 via Frontend
 Transport; Sun, 17 Nov 2024 20:51:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH3PEPF0000000B.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.14 via Frontend Transport; Sun, 17 Nov 2024 20:51:56 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 17 Nov
 2024 12:51:56 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 17 Nov 2024 12:51:56 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sun, 17 Nov 2024 12:51:53 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Jiri Pirko
	<jiri@resnulli.us>, Carolina Jubran <cjubran@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next V3 3/8] devlink: Extend devlink rate API with traffic classes bandwidth management
Date: Sun, 17 Nov 2024 22:50:40 +0200
Message-ID: <20241117205046.736499-4-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241117205046.736499-1-tariqt@nvidia.com>
References: <20241117205046.736499-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000B:EE_|SJ2PR12MB8009:EE_
X-MS-Office365-Filtering-Correlation-Id: f48d785d-b24f-4bc7-8d6d-08dd0749acc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nq3kquOgDEgBY9SCl79ssOyVK4tm2VWc/S2y+zsBwRY5U9la8qdiw1VLXevF?=
 =?us-ascii?Q?n++54TgEHDncomoKrde3/j4jkR373+a7zK8MdnRt2IjFpvOJU7uUg6SUZ19C?=
 =?us-ascii?Q?EC7lLdWj16Q+UhBXPYv6fv+HJoGLPPtJJzxWmfef2n1Au8G0YXsUFkcAws/q?=
 =?us-ascii?Q?YsY2UNrdEmw06axMrFmumnkoSnv+GM0uTUosxO/1q40N92SNWd7LnwHAlseq?=
 =?us-ascii?Q?qTzBRHQlB/ikRUs54qYVfbY/3tTsgE78kZ7cq/Sp2GZgVNgO2aFMocnfgbGp?=
 =?us-ascii?Q?hZ4AwNwAGgD7kNtsmeNEU6WOQX5qrBm47ujiomE0fjx8xi1e0m7fyNzqxFbV?=
 =?us-ascii?Q?p+DU/fiDF0uBE8F9V/ChUOidXvcVuixtpw1mQxljkNB5q1xmZc3gTey31YvE?=
 =?us-ascii?Q?kPajlYOCyUiahwyMNzyX4e5JptvS3kTPXcBqxLBRc5BWqOr0fnGsfdi0yLBq?=
 =?us-ascii?Q?/C1wIAX3ZITjIhMYIQ7w4V1z40Oq8X6zWuWc9gPT1o7P6YMPZq2rUG/7kv+E?=
 =?us-ascii?Q?loHXAYgyUE0In62StTWHRqwSNZ/rTOMTbRJcS0Cqgz//rAfS85DEJ6UfYqAe?=
 =?us-ascii?Q?qU9GqKO85Yk4MU14WoDDbKwuhtAyI9ea/XKicv7ZEO8dJo4F0CyxHdQaFh5e?=
 =?us-ascii?Q?dgSknXetWGV4xLUHgIDnTqoyo04Yed1vI0xHerXdycqnUXauitGoD/xZOavL?=
 =?us-ascii?Q?iHQekpONBBy6S1O7vfaJLDyrq/n2zK44oiSxh404Yo8NZBVx0KPwoWvw8xSe?=
 =?us-ascii?Q?VMm1ZXZRabj968vwp6m0INwr5iA+Y62LJdHlWhwOArAJX5/gZQdvSXkd5meG?=
 =?us-ascii?Q?UyCIP34/1lZcDVerPBmqIfxza4d4adaPbUopXO4i3K0jnCfzbgHZR3rVfcR5?=
 =?us-ascii?Q?h6YGN2ciJUeefzNW2TOYUDK5/rPec1oUKyl5kkgq1A8Y/WvwLZlsFFQxrE7h?=
 =?us-ascii?Q?pHOpgWtNY5mMoFAOe86U8JzSxjDdHcyGIvU4J4eI8yIL4pRcYWkY8nLikYB5?=
 =?us-ascii?Q?E3ChGxJcM48widQdMk4iZXAqtPBhTGPlSwUHzaMddLPxT22X5+NWMCehPwSA?=
 =?us-ascii?Q?4SIZDds1QW9J1702QSOh6bIC5s7/Ba1kvOdiTOsjIvTsshgzpHOBWkEVCbM+?=
 =?us-ascii?Q?P54GZhpJ2O7D5k569/+H9vj5iY8zpmGChpYY1fXZ+PST5YuPkuTEXcjytVAA?=
 =?us-ascii?Q?wW7tjvJjA6w99Qy3LY4EDP7mOziqK83rJEK6SZgFSDF0WqJRn5vline0gjzT?=
 =?us-ascii?Q?3U4CTtY1HDGAC04ApHtleTHt5vlQsnQKDqAXGZRDVSSRQv4tUmMBS8haT3m1?=
 =?us-ascii?Q?Lea5ueDkzRFNQeEd2BF2hCh+Z6gGbH5shIMwzP1enIqiYkTG47RVwp3llTLd?=
 =?us-ascii?Q?o8rVpfCoCIuq6RcOQv1mhhqoK2RqRcDmPXjivJpT4FUL7l+ecA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2024 20:51:56.7813
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f48d785d-b24f-4bc7-8d6d-08dd0749acc9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8009

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
  tc-bw 0:20 1:0 2:0 3:0 4:0 5:20 6:60 7:0

Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 Documentation/netlink/specs/devlink.yaml | 22 ++++++++
 include/net/devlink.h                    |  7 +++
 include/uapi/linux/devlink.h             |  3 +
 net/devlink/netlink_gen.c                | 14 +++--
 net/devlink/netlink_gen.h                |  1 +
 net/devlink/rate.c                       | 71 +++++++++++++++++++++++-
 6 files changed, 113 insertions(+), 5 deletions(-)

diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
index 09fbb4c03fc8..fece78ed60fe 100644
--- a/Documentation/netlink/specs/devlink.yaml
+++ b/Documentation/netlink/specs/devlink.yaml
@@ -820,6 +820,19 @@ attribute-sets:
       -
         name: region-direct
         type: flag
+      -
+        name: rate-tc-bw
+        type: u32
+        doc: |
+             Specifies the bandwidth allocation for the Traffic Class as a
+             percentage.
+        checks:
+          min: 0
+          max: 100
+      -
+        name: rate-tc-bw-values
+        type: nest
+        nested-attributes: dl-rate-tc-bw-values
 
   -
     name: dl-dev-stats
@@ -1225,6 +1238,13 @@ attribute-sets:
       -
         name: flash
         type: flag
+  -
+    name: dl-rate-tc-bw-values
+    subset-of: devlink
+    attributes:
+      -
+        name: rate-tc-bw
+        type: u32
 
 operations:
   enum-model: directional
@@ -2149,6 +2169,7 @@ operations:
             - rate-tx-priority
             - rate-tx-weight
             - rate-parent-node-name
+            - rate-tc-bw-values
 
     -
       name: rate-new
@@ -2169,6 +2190,7 @@ operations:
             - rate-tx-priority
             - rate-tx-weight
             - rate-parent-node-name
+            - rate-tc-bw-values
 
     -
       name: rate-del
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
index 9401aa343673..0940f8770319 100644
--- a/include/uapi/linux/devlink.h
+++ b/include/uapi/linux/devlink.h
@@ -614,6 +614,9 @@ enum devlink_attr {
 
 	DEVLINK_ATTR_REGION_DIRECT,		/* flag */
 
+	DEVLINK_ATTR_RATE_TC_BW,		/* u32 */
+	DEVLINK_ATTR_RATE_TC_BW_VALUES,		/* nested */
+
 	/* Add new attributes above here, update the spec in
 	 * Documentation/netlink/specs/devlink.yaml and re-generate
 	 * net/devlink/netlink_gen.c.
diff --git a/net/devlink/netlink_gen.c b/net/devlink/netlink_gen.c
index f9786d51f68f..231c2752538f 100644
--- a/net/devlink/netlink_gen.c
+++ b/net/devlink/netlink_gen.c
@@ -18,6 +18,10 @@ const struct nla_policy devlink_dl_port_function_nl_policy[DEVLINK_PORT_FN_ATTR_
 	[DEVLINK_PORT_FN_ATTR_CAPS] = NLA_POLICY_BITFIELD32(15),
 };
 
+const struct nla_policy devlink_dl_rate_tc_bw_values_nl_policy[DEVLINK_ATTR_RATE_TC_BW + 1] = {
+	[DEVLINK_ATTR_RATE_TC_BW] = NLA_POLICY_RANGE(NLA_U32, 0, 100),
+};
+
 const struct nla_policy devlink_dl_selftest_id_nl_policy[DEVLINK_ATTR_SELFTEST_ID_FLASH + 1] = {
 	[DEVLINK_ATTR_SELFTEST_ID_FLASH] = { .type = NLA_FLAG, },
 };
@@ -496,7 +500,7 @@ static const struct nla_policy devlink_rate_get_dump_nl_policy[DEVLINK_ATTR_DEV_
 };
 
 /* DEVLINK_CMD_RATE_SET - do */
-static const struct nla_policy devlink_rate_set_nl_policy[DEVLINK_ATTR_RATE_TX_WEIGHT + 1] = {
+static const struct nla_policy devlink_rate_set_nl_policy[DEVLINK_ATTR_RATE_TC_BW_VALUES + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_RATE_NODE_NAME] = { .type = NLA_NUL_STRING, },
@@ -505,10 +509,11 @@ static const struct nla_policy devlink_rate_set_nl_policy[DEVLINK_ATTR_RATE_TX_W
 	[DEVLINK_ATTR_RATE_TX_PRIORITY] = { .type = NLA_U32, },
 	[DEVLINK_ATTR_RATE_TX_WEIGHT] = { .type = NLA_U32, },
 	[DEVLINK_ATTR_RATE_PARENT_NODE_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_RATE_TC_BW_VALUES] = NLA_POLICY_NESTED(devlink_dl_rate_tc_bw_values_nl_policy),
 };
 
 /* DEVLINK_CMD_RATE_NEW - do */
-static const struct nla_policy devlink_rate_new_nl_policy[DEVLINK_ATTR_RATE_TX_WEIGHT + 1] = {
+static const struct nla_policy devlink_rate_new_nl_policy[DEVLINK_ATTR_RATE_TC_BW_VALUES + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_RATE_NODE_NAME] = { .type = NLA_NUL_STRING, },
@@ -517,6 +522,7 @@ static const struct nla_policy devlink_rate_new_nl_policy[DEVLINK_ATTR_RATE_TX_W
 	[DEVLINK_ATTR_RATE_TX_PRIORITY] = { .type = NLA_U32, },
 	[DEVLINK_ATTR_RATE_TX_WEIGHT] = { .type = NLA_U32, },
 	[DEVLINK_ATTR_RATE_PARENT_NODE_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_RATE_TC_BW_VALUES] = NLA_POLICY_NESTED(devlink_dl_rate_tc_bw_values_nl_policy),
 };
 
 /* DEVLINK_CMD_RATE_DEL - do */
@@ -1164,7 +1170,7 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.doit		= devlink_nl_rate_set_doit,
 		.post_doit	= devlink_nl_post_doit,
 		.policy		= devlink_rate_set_nl_policy,
-		.maxattr	= DEVLINK_ATTR_RATE_TX_WEIGHT,
+		.maxattr	= DEVLINK_ATTR_RATE_TC_BW_VALUES,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
@@ -1174,7 +1180,7 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.doit		= devlink_nl_rate_new_doit,
 		.post_doit	= devlink_nl_post_doit,
 		.policy		= devlink_rate_new_nl_policy,
-		.maxattr	= DEVLINK_ATTR_RATE_TX_WEIGHT,
+		.maxattr	= DEVLINK_ATTR_RATE_TC_BW_VALUES,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
diff --git a/net/devlink/netlink_gen.h b/net/devlink/netlink_gen.h
index 8f2bd50ddf5e..a8f0f20f6f0b 100644
--- a/net/devlink/netlink_gen.h
+++ b/net/devlink/netlink_gen.h
@@ -13,6 +13,7 @@
 
 /* Common nested types */
 extern const struct nla_policy devlink_dl_port_function_nl_policy[DEVLINK_PORT_FN_ATTR_CAPS + 1];
+extern const struct nla_policy devlink_dl_rate_tc_bw_values_nl_policy[DEVLINK_ATTR_RATE_TC_BW + 1];
 extern const struct nla_policy devlink_dl_selftest_id_nl_policy[DEVLINK_ATTR_SELFTEST_ID_FLASH + 1];
 
 /* Ops table for devlink */
diff --git a/net/devlink/rate.c b/net/devlink/rate.c
index 8828ffaf6cbc..4eb0598d40f9 100644
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
@@ -129,6 +131,19 @@ static int devlink_nl_rate_fill(struct sk_buff *msg,
 				   devlink_rate->parent->name))
 			goto nla_put_failure;
 
+	nla_tc_bw = nla_nest_start(msg, DEVLINK_ATTR_RATE_TC_BW_VALUES);
+	if (!nla_tc_bw)
+		goto nla_put_failure;
+
+	for (i = 0; i < IEEE_8021QAZ_MAX_TCS; i++) {
+		if (nla_put_u32(msg, DEVLINK_ATTR_RATE_TC_BW, devlink_rate->tc_bw[i])) {
+			nla_nest_cancel(msg, nla_tc_bw);
+			goto nla_put_failure;
+		}
+	}
+
+	nla_nest_end(msg, nla_tc_bw);
+
 	genlmsg_end(msg, hdr);
 	return 0;
 
@@ -316,11 +331,46 @@ devlink_nl_rate_parent_node_set(struct devlink_rate *devlink_rate,
 	return 0;
 }
 
+static int devlink_nl_rate_tc_bw_set(struct devlink_rate *devlink_rate,
+				     struct genl_info *info,
+				     struct nlattr *nla_tc_bw)
+{
+	struct devlink *devlink = devlink_rate->devlink;
+	const struct devlink_ops *ops = devlink->ops;
+	u32 tc_bw[IEEE_8021QAZ_MAX_TCS] = {0};
+	struct nlattr *nla_tc_entry;
+	int rem, err = 0, i = 0;
+
+	nla_for_each_nested(nla_tc_entry, nla_tc_bw, rem) {
+		if (i >= IEEE_8021QAZ_MAX_TCS || nla_type(nla_tc_entry) != DEVLINK_ATTR_RATE_TC_BW)
+			return -EINVAL;
+
+		tc_bw[i++] = nla_get_u32(nla_tc_entry);
+	}
+
+	if (i != IEEE_8021QAZ_MAX_TCS)
+		return -EINVAL;
+
+	if (devlink_rate_is_leaf(devlink_rate))
+		err = ops->rate_leaf_tc_bw_set(devlink_rate, devlink_rate->priv, tc_bw,
+					       info->extack);
+	else if (devlink_rate_is_node(devlink_rate))
+		err = ops->rate_node_tc_bw_set(devlink_rate, devlink_rate->priv, tc_bw,
+					       info->extack);
+
+	if (err)
+		return err;
+
+	memcpy(devlink_rate->tc_bw, tc_bw, sizeof(tc_bw));
+
+	return 0;
+}
+
 static int devlink_nl_rate_set(struct devlink_rate *devlink_rate,
 			       const struct devlink_ops *ops,
 			       struct genl_info *info)
 {
-	struct nlattr *nla_parent, **attrs = info->attrs;
+	struct nlattr *nla_parent, *nla_tc_bw, **attrs = info->attrs;
 	int err = -EOPNOTSUPP;
 	u32 priority;
 	u32 weight;
@@ -380,6 +430,13 @@ static int devlink_nl_rate_set(struct devlink_rate *devlink_rate,
 		devlink_rate->tx_weight = weight;
 	}
 
+	nla_tc_bw = attrs[DEVLINK_ATTR_RATE_TC_BW_VALUES];
+	if (nla_tc_bw) {
+		err = devlink_nl_rate_tc_bw_set(devlink_rate, info, nla_tc_bw);
+		if (err)
+			return err;
+	}
+
 	nla_parent = attrs[DEVLINK_ATTR_RATE_PARENT_NODE_NAME];
 	if (nla_parent) {
 		err = devlink_nl_rate_parent_node_set(devlink_rate, info,
@@ -423,6 +480,12 @@ static bool devlink_rate_set_ops_supported(const struct devlink_ops *ops,
 					    "TX weight set isn't supported for the leafs");
 			return false;
 		}
+		if (attrs[DEVLINK_ATTR_RATE_TC_BW_VALUES] && !ops->rate_leaf_tc_bw_set) {
+			NL_SET_ERR_MSG_ATTR(info->extack,
+					    attrs[DEVLINK_ATTR_RATE_TC_BW_VALUES],
+					    "TC bandwidth set isn't supported for the leafs");
+			return false;
+		}
 	} else if (type == DEVLINK_RATE_TYPE_NODE) {
 		if (attrs[DEVLINK_ATTR_RATE_TX_SHARE] && !ops->rate_node_tx_share_set) {
 			NL_SET_ERR_MSG(info->extack, "TX share set isn't supported for the nodes");
@@ -449,6 +512,12 @@ static bool devlink_rate_set_ops_supported(const struct devlink_ops *ops,
 					    "TX weight set isn't supported for the nodes");
 			return false;
 		}
+		if (attrs[DEVLINK_ATTR_RATE_TC_BW_VALUES] && !ops->rate_node_tc_bw_set) {
+			NL_SET_ERR_MSG_ATTR(info->extack,
+					    attrs[DEVLINK_ATTR_RATE_TC_BW_VALUES],
+					    "TC bandwidth set isn't supported for the nodes");
+			return false;
+		}
 	} else {
 		WARN(1, "Unknown type of rate object");
 		return false;
-- 
2.44.0


