Return-Path: <netdev+bounces-144516-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF8A99C7A9C
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 19:04:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 805181F245A4
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 18:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D001F206E93;
	Wed, 13 Nov 2024 18:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jB33WH7c"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2086.outbound.protection.outlook.com [40.107.102.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF88C206952
	for <netdev@vger.kernel.org>; Wed, 13 Nov 2024 18:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731520918; cv=fail; b=JwtlvaqYsCpz21QM2TC1IRiIe87FHVWKmqyEf4UuYAy/E+/PCiNvYWeOUU8Pvv0iXVCTzSWMuWF4A/DwhZ0olfNd/cwOTo+A+KKxtEYzgxegtwl2Y4uPwEpsBpFUam0lC0YIm5ribQ/c6VA07DqIyFNNQPerTmiGmJHCJ0WlOyY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731520918; c=relaxed/simple;
	bh=Qi7yRqybdw+X5v9W0Q5ZBqG7QlPIO8r2mNxa0e38cBQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GbQAb3/RJrxe2du8BQXj7SDW0UxWMDJIUPWYrroRBWUmmMzSB4uUAZ0UPMtW5smaiofauFpA8xwClMv/b7DAC7YC/eZLfG2uBHR9J3MuI945NrzvhvKkaMCYYUcBlP/tyYWS7lN6WY8JLhvri/YWs0Kqb/Jc25iwiiGEh0Zz9AA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jB33WH7c; arc=fail smtp.client-ip=40.107.102.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dz/Rq7mM/6rQ9njatawPLlIEFPyHmpO6Pl8H6wX2EecCBzgckTNHtIeBomUgBr+vzoPp8dmvzAGfeT7VfTRkS1rBpvG8a9ehLv4YgS5szy9vSKUjPyXcPE5Kpe0aqBmGpQ/26HlFhV0BYiAoIzZGuxabNkMLmrKl666jaSlr46xpqKdpVf3HAzbUB1Gy4Zs3UgsoirIOFuaaN/UMiwGtHzRoXL7IyzXDigUl0xlLHegsezuh51fuyS872E/3pHkaoGFSLzzjYSiYlTFM7oZ7ewQwsw04bu5/b/oT86F5VAlqysDtwM8sRjCzDs+2yy8caZIwnbX/BdMe9jlsfgm9Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dpKmI8muhNfmEqYlJpe7FZjCAGhZSEIrljQ3tnPEge0=;
 b=hmjpSGBIKD9vy1NxAg/8l51qm2snrIozillZMCFVctBLwyF7XetrzscuVKrI8A0Z/Heoj+K0UXO+/pzXy2EBBW7AOAWCNYwJLeBs9rO5zAWLybIDp+jbRBzsdB22BSEeFvxgal5drOSp1bh9UCVVb3wjXq16lm4tZUhEgEMv6L7znZz80xsErRqy3wNPbJ0jXOqoEpaCfDRzBQa6//Wg1Lc3JtkdVKdUz11bwdyMu908hstIbANDRczXHr4SgdUcH4EKwE5o9i9tEKmJsb1o2yVQ9h/E/aVcUST51fx3tYDLMKLigY8RMFvkWKOg8TWW22rxj6M4HRPoIcun2Gl+pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dpKmI8muhNfmEqYlJpe7FZjCAGhZSEIrljQ3tnPEge0=;
 b=jB33WH7crHO/29owwEz9+4nDBRV1upy3FYmL3AW0mPI3iIQlbKM0hJXWR2rMFSMVvT8lR47jx7UMQ94MmBjSkXNp8hUCZcYlHxPdRG5lSSvQ2aZS3HPcezG6pmxN0GOtI7wBhgsuFz8SmrD1z4B3aW8ti/RdzLV/iB0bTFrd0EirguCv6qOHj/8IYtTp/KBwJT3trVV+MWOBWQorWo3Y3ReTbvXK8dA61T8ZrXm2V3olBshjSoOeaU4+dS8ndr7MuW/Pk5/8PR0SKd4Jqhct6CA2Hdlpfh6KUfhcsa7xFaNbQjUfhqOhbHqddHb94v9R8ys4KyYK6aDRnK5Iaz/+Qw==
Received: from BN9PR03CA0065.namprd03.prod.outlook.com (2603:10b6:408:fc::10)
 by DS0PR12MB6629.namprd12.prod.outlook.com (2603:10b6:8:d3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Wed, 13 Nov
 2024 18:01:48 +0000
Received: from BL02EPF00029928.namprd02.prod.outlook.com
 (2603:10b6:408:fc:cafe::58) by BN9PR03CA0065.outlook.office365.com
 (2603:10b6:408:fc::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.16 via Frontend
 Transport; Wed, 13 Nov 2024 18:01:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL02EPF00029928.mail.protection.outlook.com (10.167.249.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.14 via Frontend Transport; Wed, 13 Nov 2024 18:01:46 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 13 Nov
 2024 10:01:29 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 13 Nov 2024 10:01:29 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 13 Nov 2024 10:01:26 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Jiri Pirko
	<jiri@resnulli.us>, Carolina Jubran <cjubran@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 3/8] devlink: Extend devlink rate API with traffic classes bandwidth management
Date: Wed, 13 Nov 2024 20:00:28 +0200
Message-ID: <20241113180034.714102-4-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241113180034.714102-1-tariqt@nvidia.com>
References: <20241113180034.714102-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00029928:EE_|DS0PR12MB6629:EE_
X-MS-Office365-Filtering-Correlation-Id: 477a7056-288b-4079-9ef8-08dd040d3d41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dRisbL6GWdcXwyz0B40dAVUsodsksICH+dZ2P/W08DRnInbwnTR54Di+p+D2?=
 =?us-ascii?Q?X5NeMbBqtRxGxrUL4/A3pslQdkDoP2mOPWtEoK3zQcxpNyh3tbTlIlwNb2Pf?=
 =?us-ascii?Q?QpS/I2/O4BKvOSYfakzQex8GMIPDbgX9lVCOW+fw3BHoj9H86MoHkhesdkmc?=
 =?us-ascii?Q?YTlCMCtz1mL6VbrwDWGtVyrLkyhaNTP5WoY9dDqOlLtsXtKR6tum1t6uCaMV?=
 =?us-ascii?Q?S6/H2oy4yx2HJJ2I1FVd2o8sD24GL7F41Wdi4+HIRDAVaUl+83cPwZbNmdxy?=
 =?us-ascii?Q?Rofz95e18/vWAun0pJSfvx7QmWIY5Tiz1dav7ZTDaOL8GaZ+LNGHQRbF4KpL?=
 =?us-ascii?Q?Aksl5UejnJDN8Ancy6sZdkOnPkcEGiL5ZL7tuVcIFWxWVv31ZcpAHttoES6i?=
 =?us-ascii?Q?6GCVkvo492xW+wE0GMQuiVHMUSXHFgkmMmHvwB7SteHm6vyIuzmdnQfCANzH?=
 =?us-ascii?Q?Yq9jKyGu7xC6GXZbsnfUeiVlPtIO5l6Azjts/wTW6ZSm34Lh4H16Vd67HE8+?=
 =?us-ascii?Q?/mhMv8ZeB9fQXzuHSCXmBgovUlyyWUi+bshpBsjpcwItSsbZ+HYGTJmxd2sG?=
 =?us-ascii?Q?AR3r73zzdLBQ/cGFTuhb5DNv3QFDnIzRXx6BBUMSbXNDHNV9SvX7opnrqSlL?=
 =?us-ascii?Q?EO59bcZhLD6Yo/ElXSnYRhMV6lzWJhOBJQX9rIDywMpD4PxomoXYxDod4TvK?=
 =?us-ascii?Q?oMaWQGFa5FBjsDZbaeFhQcoJW5aivndKLeOTCx4W4UpJyNtpaQmiOWcMw+jK?=
 =?us-ascii?Q?Ynd5BgaZgSVRsvtW9RoO1DI+5ELLtUg4cAraXCq/m1KlVEhsMDy+F07cO5+8?=
 =?us-ascii?Q?3V4/scgylwfh8VvWFCTrLx/2/Ptqup72bpBr4Lye81dgv+AbZnxjc45Sthmd?=
 =?us-ascii?Q?+UKb7orIVSU97ilp7uJsijPu4skDAIIxSoV3+cFQWkJ8qnRyqTzb2Sa3stQ/?=
 =?us-ascii?Q?69IGgLk/cX0xF4ODiRjOJDDwCkdQZyWXdCwzLWE4DaUpiRW/yksdZBAT+y1q?=
 =?us-ascii?Q?vwXGzBLRTGDmZL3IQkwgbGpjm3aKJvzzS3RrBjfDquXhRsNb9271/lx+K6ll?=
 =?us-ascii?Q?cWDWSSCKPRPrjmBLB5KrEmjlNYXiP0oEsuOdc3Nm+2K6RUuXSpnK2LJ7jn9q?=
 =?us-ascii?Q?9pQjta++3p7GfWU6zABGYVaamilKnPhZ/UGPo1lEykzvKOv1LfqeMjNF+Dl6?=
 =?us-ascii?Q?X8puVU0FKQjMi+BUHEOKBBz5jIfN8gvtcIDysxFc2ikJFv5baJrW35ACrarE?=
 =?us-ascii?Q?qBtUMvkruQzypUUUqZ2DFkpXd8noTUm28ZM6AQ+PZ9vtnMHpumGZKJyIW4cI?=
 =?us-ascii?Q?LqlfbBKy7vrd8uHMPrguXNTS7cd4wIKETNyU8l8/pSuU+EKZgH0OvjNf65/D?=
 =?us-ascii?Q?ZbxHPvQQ5dzHRdTky67c+pikkoqxhwqJTehFeENHNsPimXXgKg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 18:01:46.3087
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 477a7056-288b-4079-9ef8-08dd040d3d41
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00029928.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6629

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
 Documentation/netlink/specs/devlink.yaml | 50 ++++++++++++++++++++
 include/net/devlink.h                    |  6 +++
 include/uapi/linux/devlink.h             | 10 ++++
 net/devlink/netlink_gen.c                | 21 +++++++--
 net/devlink/netlink_gen.h                |  1 +
 net/devlink/rate.c                       | 60 ++++++++++++++++++++++--
 6 files changed, 141 insertions(+), 7 deletions(-)

diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
index 09fbb4c03fc8..41fdc2514f69 100644
--- a/Documentation/netlink/specs/devlink.yaml
+++ b/Documentation/netlink/specs/devlink.yaml
@@ -817,6 +817,34 @@ attribute-sets:
       -
         name: rate-tx-weight
         type: u32
+      -
+        name: rate-tc-0-bw
+        type: u32
+      -
+        name: rate-tc-1-bw
+        type: u32
+      -
+        name: rate-tc-2-bw
+        type: u32
+      -
+        name: rate-tc-3-bw
+        type: u32
+      -
+        name: rate-tc-4-bw
+        type: u32
+      -
+        name: rate-tc-5-bw
+        type: u32
+      -
+        name: rate-tc-6-bw
+        type: u32
+      -
+        name: rate-tc-7-bw
+        type: u32
+      -
+        name: rate-tc-bw
+        type: nest
+        nested-attributes: dl-rate-tc-bw-values
       -
         name: region-direct
         type: flag
@@ -1225,6 +1253,26 @@ attribute-sets:
       -
         name: flash
         type: flag
+  -
+    name: dl-rate-tc-bw-values
+    subset-of: devlink
+    attributes:
+      -
+        name: rate-tc-0-bw
+      -
+        name: rate-tc-1-bw
+      -
+        name: rate-tc-2-bw
+      -
+        name: rate-tc-3-bw
+      -
+        name: rate-tc-4-bw
+      -
+        name: rate-tc-5-bw
+      -
+        name: rate-tc-6-bw
+      -
+        name: rate-tc-7-bw
 
 operations:
   enum-model: directional
@@ -2148,6 +2196,7 @@ operations:
             - rate-tx-max
             - rate-tx-priority
             - rate-tx-weight
+            - rate-tc-bw
             - rate-parent-node-name
 
     -
@@ -2168,6 +2217,7 @@ operations:
             - rate-tx-max
             - rate-tx-priority
             - rate-tx-weight
+            - rate-tc-bw
             - rate-parent-node-name
 
     -
diff --git a/include/net/devlink.h b/include/net/devlink.h
index fbb9a2668e24..917bc006a5a4 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -117,6 +117,8 @@ struct devlink_rate {
 
 	u32 tx_priority;
 	u32 tx_weight;
+
+	u32 tc_bw[IEEE_8021QAZ_MAX_TCS];
 };
 
 struct devlink_port {
@@ -1469,6 +1471,8 @@ struct devlink_ops {
 					 u32 tx_priority, struct netlink_ext_ack *extack);
 	int (*rate_leaf_tx_weight_set)(struct devlink_rate *devlink_rate, void *priv,
 				       u32 tx_weight, struct netlink_ext_ack *extack);
+	int (*rate_leaf_tc_bw_set)(struct devlink_rate *devlink_rate, void *priv,
+				   u32 *tc_bw, struct netlink_ext_ack *extack);
 	int (*rate_node_tx_share_set)(struct devlink_rate *devlink_rate, void *priv,
 				      u64 tx_share, struct netlink_ext_ack *extack);
 	int (*rate_node_tx_max_set)(struct devlink_rate *devlink_rate, void *priv,
@@ -1477,6 +1481,8 @@ struct devlink_ops {
 					 u32 tx_priority, struct netlink_ext_ack *extack);
 	int (*rate_node_tx_weight_set)(struct devlink_rate *devlink_rate, void *priv,
 				       u32 tx_weight, struct netlink_ext_ack *extack);
+	int (*rate_node_tc_bw_set)(struct devlink_rate *devlink_rate, void *priv,
+				   u32 *tc_bw, struct netlink_ext_ack *extack);
 	int (*rate_node_new)(struct devlink_rate *rate_node, void **priv,
 			     struct netlink_ext_ack *extack);
 	int (*rate_node_del)(struct devlink_rate *rate_node, void *priv,
diff --git a/include/uapi/linux/devlink.h b/include/uapi/linux/devlink.h
index 9401aa343673..c369726a262a 100644
--- a/include/uapi/linux/devlink.h
+++ b/include/uapi/linux/devlink.h
@@ -614,6 +614,16 @@ enum devlink_attr {
 
 	DEVLINK_ATTR_REGION_DIRECT,		/* flag */
 
+	DEVLINK_ATTR_RATE_TC_0_BW,		/* u32 */
+	DEVLINK_ATTR_RATE_TC_1_BW,		/* u32 */
+	DEVLINK_ATTR_RATE_TC_2_BW,		/* u32 */
+	DEVLINK_ATTR_RATE_TC_3_BW,		/* u32 */
+	DEVLINK_ATTR_RATE_TC_4_BW,		/* u32 */
+	DEVLINK_ATTR_RATE_TC_5_BW,		/* u32 */
+	DEVLINK_ATTR_RATE_TC_6_BW,		/* u32 */
+	DEVLINK_ATTR_RATE_TC_7_BW,		/* u32 */
+	DEVLINK_ATTR_RATE_TC_BW,		/* nested */
+
 	/* Add new attributes above here, update the spec in
 	 * Documentation/netlink/specs/devlink.yaml and re-generate
 	 * net/devlink/netlink_gen.c.
diff --git a/net/devlink/netlink_gen.c b/net/devlink/netlink_gen.c
index f9786d51f68f..546766bdd836 100644
--- a/net/devlink/netlink_gen.c
+++ b/net/devlink/netlink_gen.c
@@ -18,6 +18,17 @@ const struct nla_policy devlink_dl_port_function_nl_policy[DEVLINK_PORT_FN_ATTR_
 	[DEVLINK_PORT_FN_ATTR_CAPS] = NLA_POLICY_BITFIELD32(15),
 };
 
+const struct nla_policy devlink_dl_rate_tc_bw_nl_policy[DEVLINK_ATTR_RATE_TC_7_BW + 1] = {
+	[DEVLINK_ATTR_RATE_TC_0_BW] = { .type = NLA_U32, },
+	[DEVLINK_ATTR_RATE_TC_1_BW] = { .type = NLA_U32, },
+	[DEVLINK_ATTR_RATE_TC_2_BW] = { .type = NLA_U32, },
+	[DEVLINK_ATTR_RATE_TC_3_BW] = { .type = NLA_U32, },
+	[DEVLINK_ATTR_RATE_TC_4_BW] = { .type = NLA_U32, },
+	[DEVLINK_ATTR_RATE_TC_5_BW] = { .type = NLA_U32, },
+	[DEVLINK_ATTR_RATE_TC_6_BW] = { .type = NLA_U32, },
+	[DEVLINK_ATTR_RATE_TC_7_BW] = { .type = NLA_U32, },
+};
+
 const struct nla_policy devlink_dl_selftest_id_nl_policy[DEVLINK_ATTR_SELFTEST_ID_FLASH + 1] = {
 	[DEVLINK_ATTR_SELFTEST_ID_FLASH] = { .type = NLA_FLAG, },
 };
@@ -496,7 +507,7 @@ static const struct nla_policy devlink_rate_get_dump_nl_policy[DEVLINK_ATTR_DEV_
 };
 
 /* DEVLINK_CMD_RATE_SET - do */
-static const struct nla_policy devlink_rate_set_nl_policy[DEVLINK_ATTR_RATE_TX_WEIGHT + 1] = {
+static const struct nla_policy devlink_rate_set_nl_policy[DEVLINK_ATTR_RATE_TC_BW + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_RATE_NODE_NAME] = { .type = NLA_NUL_STRING, },
@@ -505,10 +516,11 @@ static const struct nla_policy devlink_rate_set_nl_policy[DEVLINK_ATTR_RATE_TX_W
 	[DEVLINK_ATTR_RATE_TX_PRIORITY] = { .type = NLA_U32, },
 	[DEVLINK_ATTR_RATE_TX_WEIGHT] = { .type = NLA_U32, },
 	[DEVLINK_ATTR_RATE_PARENT_NODE_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_RATE_TC_BW] = NLA_POLICY_NESTED(devlink_dl_rate_tc_bw_nl_policy),
 };
 
 /* DEVLINK_CMD_RATE_NEW - do */
-static const struct nla_policy devlink_rate_new_nl_policy[DEVLINK_ATTR_RATE_TX_WEIGHT + 1] = {
+static const struct nla_policy devlink_rate_new_nl_policy[DEVLINK_ATTR_RATE_TC_BW + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_RATE_NODE_NAME] = { .type = NLA_NUL_STRING, },
@@ -517,6 +529,7 @@ static const struct nla_policy devlink_rate_new_nl_policy[DEVLINK_ATTR_RATE_TX_W
 	[DEVLINK_ATTR_RATE_TX_PRIORITY] = { .type = NLA_U32, },
 	[DEVLINK_ATTR_RATE_TX_WEIGHT] = { .type = NLA_U32, },
 	[DEVLINK_ATTR_RATE_PARENT_NODE_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_RATE_TC_BW] = NLA_POLICY_NESTED(devlink_dl_rate_tc_bw_nl_policy),
 };
 
 /* DEVLINK_CMD_RATE_DEL - do */
@@ -1164,7 +1177,7 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.doit		= devlink_nl_rate_set_doit,
 		.post_doit	= devlink_nl_post_doit,
 		.policy		= devlink_rate_set_nl_policy,
-		.maxattr	= DEVLINK_ATTR_RATE_TX_WEIGHT,
+		.maxattr	= DEVLINK_ATTR_RATE_TC_BW,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
@@ -1174,7 +1187,7 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 		.doit		= devlink_nl_rate_new_doit,
 		.post_doit	= devlink_nl_post_doit,
 		.policy		= devlink_rate_new_nl_policy,
-		.maxattr	= DEVLINK_ATTR_RATE_TX_WEIGHT,
+		.maxattr	= DEVLINK_ATTR_RATE_TC_BW,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
diff --git a/net/devlink/netlink_gen.h b/net/devlink/netlink_gen.h
index 8f2bd50ddf5e..084ad5026d4f 100644
--- a/net/devlink/netlink_gen.h
+++ b/net/devlink/netlink_gen.h
@@ -14,6 +14,7 @@
 /* Common nested types */
 extern const struct nla_policy devlink_dl_port_function_nl_policy[DEVLINK_PORT_FN_ATTR_CAPS + 1];
 extern const struct nla_policy devlink_dl_selftest_id_nl_policy[DEVLINK_ATTR_SELFTEST_ID_FLASH + 1];
+extern const struct nla_policy devlink_dl_rate_tc_bw_nl_policy[DEVLINK_ATTR_RATE_TC_7_BW + 1];
 
 /* Ops table for devlink */
 extern const struct genl_split_ops devlink_nl_ops[74];
diff --git a/net/devlink/rate.c b/net/devlink/rate.c
index 8828ffaf6cbc..9bffda6783f9 100644
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
@@ -124,10 +126,19 @@ static int devlink_nl_rate_fill(struct sk_buff *msg,
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
+		if (nla_put_u32(msg, DEVLINK_ATTR_RATE_TC_0_BW + i,
+				devlink_rate->tc_bw[i])) {
+			nla_nest_cancel(msg, nla_tc_bw);
 			goto nla_put_failure;
+		}
+	}
+
+	nla_nest_end(msg, nla_tc_bw);
 
 	genlmsg_end(msg, hdr);
 	return 0;
@@ -321,6 +332,7 @@ static int devlink_nl_rate_set(struct devlink_rate *devlink_rate,
 			       struct genl_info *info)
 {
 	struct nlattr *nla_parent, **attrs = info->attrs;
+	u32 tc_bw[IEEE_8021QAZ_MAX_TCS];
 	int err = -EOPNOTSUPP;
 	u32 priority;
 	u32 weight;
@@ -380,6 +392,36 @@ static int devlink_nl_rate_set(struct devlink_rate *devlink_rate,
 		devlink_rate->tx_weight = weight;
 	}
 
+	if (attrs[DEVLINK_ATTR_RATE_TC_BW]) {
+		struct nlattr *nla_tc_bw = attrs[DEVLINK_ATTR_RATE_TC_BW];
+		struct nlattr *tb[DEVLINK_ATTR_RATE_TC_7_BW + 1];
+		int i;
+
+		err = nla_parse_nested(tb, DEVLINK_ATTR_RATE_TC_7_BW, nla_tc_bw,
+				       devlink_dl_rate_tc_bw_nl_policy, info->extack);
+		if (err)
+			return err;
+
+		for (i = 0; i < IEEE_8021QAZ_MAX_TCS; i++) {
+			if (tb[DEVLINK_ATTR_RATE_TC_0_BW + i])
+				tc_bw[i] = nla_get_u32(tb[DEVLINK_ATTR_RATE_TC_0_BW + i]);
+			else
+				tc_bw[i] = 0;
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
@@ -423,6 +465,12 @@ static bool devlink_rate_set_ops_supported(const struct devlink_ops *ops,
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
@@ -449,6 +497,12 @@ static bool devlink_rate_set_ops_supported(const struct devlink_ops *ops,
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


