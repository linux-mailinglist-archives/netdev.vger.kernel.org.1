Return-Path: <netdev+bounces-118385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD6095170E
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 10:54:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D42A01F236A1
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 08:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE3F142911;
	Wed, 14 Aug 2024 08:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KjNKbHu4"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2065.outbound.protection.outlook.com [40.107.101.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCBB145327
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 08:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723625639; cv=fail; b=RmyFn6mu2ioibTJfOujlDArXeYEAWOF/XP0DjUcMi5Jftxh/D/eUvuckmYMahCNJYj10sw9i3X4gD/WnzEu5xGI/5cDSlZ5Io1MuzFIHH//XqImUHSMgKhMTGtROFs0EeU8smfUpUDBM1JXaSi+yUrKbbFIVKHAxYexyyAEZJO0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723625639; c=relaxed/simple;
	bh=hzFTyB71DYE1G/U1oIjbiXQ8G48ALSfOzH2i3dU62xM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s7QLH8G2m+iIvC3w9ToXYnzQ2nCGTMWt79r+XMLN94KZ1tzfke8Q/h0RuXYe/GYmZFk4euCTpCkWbhCi3E7bU2H9Li6qiuaNWv6048lPgZUYhkjnJrmQgo9VlIi18agiQuFR118bHk2R81QRwyTj4Co2LqxXW42kH/TC63Wba1w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KjNKbHu4; arc=fail smtp.client-ip=40.107.101.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z6r8pVMnm8MPyBVZQBLdsGd/kjj2naNtwS1ve4Sl69kgh233WzAUIIgGlTpJzRgvakH2Ad1XGco78eLNM1RQA1pNQ7Zv/ZO2chkcP9gpViwF4ERe+3jH6wiO7ljUTatALbT0T+1jctfPFStcmR4KVdeVs8tWh+7wfxkER7gG/3PpcZtKvxNW+KsTI/DmciWBB9iWpYyU7isobka6PEXRbMwyEPJ/i6/Tm2sL0iWGCkA1xUMWB5Iv4bnFjs5pZoGsQZ8yV++TwZLOldtij1EZ9TZu5xeeeClzOF5x69SjGPQxhXim7g/OZ1kZ4W7k6HJBbT2+E4tiIwpPDlQtPoUCwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TbOJ5NsH8Gme9ua2/gj9AwaU7F9dN6gpZ5yLZRFualE=;
 b=HeYmiAnJ0IHgB2ewgarryLgboGahUkqHOcJa8eaiHh/ZxVTcnwcF4F5IwiFD9k8StHQU0mxWWvegeE/RQ1l2slT6uyifvX2kPj+sd6PAUgxni4tDFQNZAFmcU4zBErLXFmikx/6eaARoalirS9qA6vvNVdKa8p+zXV0pIyqNfivXrH024SEaUFZ/wkKHEenHAU/B840XNWkJN3a7X6H/KrKf+POi9gYeB/l7MJu3PXMBUFSjF49kO2suYLtxaEuha7IZp0BI06k9AK5rCmCxKrNidox5vDFvg98MGXqpmGFHl1X16B69MD/RD/4AUOEDzg+BbVhTE3mVWlQ7X1mA+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TbOJ5NsH8Gme9ua2/gj9AwaU7F9dN6gpZ5yLZRFualE=;
 b=KjNKbHu46tboy2OqsE447Rmy1OVoNl+59PkNJTNDcJo2KvVWQ9OTmKrpSC/kb2F4PGrt5Zrn4fSQF1mR2UjcOurPl992jEuW3ukDXHLGdHBzeobuECSVHLBfSotDPjQP17dHBFf1jUeuMAH/k+xs+pDuD7a0Uu++v8yfK46zDzM6kkJHicBNtkv1WZmuv3zzseP9kl8vCQLMCzIO4lwtMnpNZhuw2KDd1c55WQhulTtuG/Dw0ts5NV1G6vgktN65vLF2YQJMJigqLv/YbnKjGG2gbCgAYcfOWwupNF5lbTeqvFvvxg8urbPS9xgU2vYPAliiey03t2crGdLagcGGkw==
Received: from CH2PR17CA0005.namprd17.prod.outlook.com (2603:10b6:610:53::15)
 by IA1PR12MB6481.namprd12.prod.outlook.com (2603:10b6:208:3aa::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Wed, 14 Aug
 2024 08:53:54 +0000
Received: from CH1PEPF0000AD81.namprd04.prod.outlook.com
 (2603:10b6:610:53:cafe::e0) by CH2PR17CA0005.outlook.office365.com
 (2603:10b6:610:53::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.23 via Frontend
 Transport; Wed, 14 Aug 2024 08:53:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000AD81.mail.protection.outlook.com (10.167.244.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Wed, 14 Aug 2024 08:53:53 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 14 Aug
 2024 01:53:42 -0700
Received: from nexus.mtl.labs.mlnx (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 14 Aug
 2024 01:53:38 -0700
From: Cosmin Ratiu <cratiu@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <cjubran@nvidia.com>, <cratiu@nvidia.com>, <tariqt@nvidia.com>,
	<saeedm@nvidia.com>, <yossiku@nvidia.com>, <gal@nvidia.com>,
	<jiri@nvidia.com>
Subject: [PATCH] devlink: Extend the devlink rate API to support rate management on traffic classes
Date: Wed, 14 Aug 2024 11:51:46 +0300
Message-ID: <20240814085320.134075-2-cratiu@nvidia.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240814085320.134075-1-cratiu@nvidia.com>
References: <20240814085320.134075-1-cratiu@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD81:EE_|IA1PR12MB6481:EE_
X-MS-Office365-Filtering-Correlation-Id: 32f17678-827b-403e-c06e-08dcbc3ea01e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?N5KkRSy8mH9b5vxoIjiqkktYkFu18oAwqd/BEuGuQdbdxYLUTRfF/b1ipRDS?=
 =?us-ascii?Q?/A4RFscMhgG2zpQ9tnbgJCzPFQN+Mwx5SWLMVHeymdoY2sjVt/DZ/0RCLxIl?=
 =?us-ascii?Q?h/kYe9Blhhos01AKn5ZJ+oFE6V1tpxxzBXlBjPo2voK+m7k469mNqRRQxKay?=
 =?us-ascii?Q?LxQIPMOpprameHWaOlRQMuXJHo4XRT4uLKGXAmYXkK0jut/kUUUn27k3t4q1?=
 =?us-ascii?Q?hKQBbt1bmau5eI4ncjX8ilTRyQZqYxr2KtvuGspnb3gbzAaPqXLpVlWD/I6Q?=
 =?us-ascii?Q?OEI+al17OODMmn9/aeAtDB0FLZijguDKi6/YaQS374M5AsICGo7RaHnx7o7w?=
 =?us-ascii?Q?GnNHhJdaWPOOnwlqith1wicnnlDeP5e3RPxFmw4sRNPN7UyJDxmaRedqas2r?=
 =?us-ascii?Q?Igt/pvWYEfS93vp9LSLnPvx4bsIKQYZVFZSSE78q1beuob/H0P4fv4tGAbSY?=
 =?us-ascii?Q?qP4yfpd06G6W0YfANrDt1Fu9wSZLGU1IDwUwr7EbOZZFq+Il/vWPDrQxKVZI?=
 =?us-ascii?Q?p5mtLSr/nqDQKaYAgNB3aWUEQPm8cujGkzw+cD5vChVc8JYBvZ6d8gIa+zzx?=
 =?us-ascii?Q?uHLvi6fpzwPJDyaLTCbD9NSaZrIWIHKGFWWNiZPOUdhwsqb6incjC8QWRSMs?=
 =?us-ascii?Q?NFvvMtm/23D+Ey0SYvzSGOF6Q7lN5atR+UIKqVcLmhk9jDbYcC2NfyoF8yHV?=
 =?us-ascii?Q?4TrJYjWJ2bwPsz1ImSohypip+KoT3M3ONMpZO6rUKe0QwvCnTeERyxbNOe0R?=
 =?us-ascii?Q?4mFrKRF7uuu48PfL+OXvha3cxy0x9LJMuzuCdZ40PmpRWrEpBVlnKy8gVUpI?=
 =?us-ascii?Q?fBoqbDqw3sXXGf626+dXlAv3ABGwhjqwFXsKtSiGDT3EcSV5DPUpSo0hCQvr?=
 =?us-ascii?Q?PeQHWBP/xUHaEnQS2zLYu3x9jhChSmtBc85yqXc/zTuJFF97kogv7YHVFqNp?=
 =?us-ascii?Q?Xva2mCVfAFTk9Jq9c9UTwIP6Bc0vUBYBd6qpfmoE1LvyF6YB/MONojoeHC+0?=
 =?us-ascii?Q?P/jAGwchUFQZqEhwIIsaLMN+mY+Wc2WhtsRYyBhMioKjcFRS+3mulVyx5dpU?=
 =?us-ascii?Q?FjUl2iDq7aUbJY83Vu30hA8Qz6+9n3hhMveJuux5swbFOGN1wXa485uXjFFU?=
 =?us-ascii?Q?iYAyXjEUD2H8MZYWdWOrcnIWwPHEj6Aqjz26kjwHV4aezrK8IRCfBH4oxJvV?=
 =?us-ascii?Q?fzo71nbvNvuqWnX0PE8lxpqaIlFMBa92elbl5lDtUq49CEHOx/rt6Sxj5qCc?=
 =?us-ascii?Q?TaLuKdgX455qLOsYLHI8GWKPknSJvJAm3f/daS3NalCsr+heL5Qd3PPmewqg?=
 =?us-ascii?Q?8qQ/0l501n4i4AMC8GPSjDQFHvonKGS5Fk1tbJKUD9NY5U1EsXlY4EYUqZXz?=
 =?us-ascii?Q?/nV55FB0Gr6/Ynl+3gfWt34QhllXfANCVjLbnrDcer2DZsTd/Ggbzk2VM2Ho?=
 =?us-ascii?Q?BJbCyVO6cwhtTXEyp3NapW77GR3SJKCV?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 08:53:53.8413
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32f17678-827b-403e-c06e-08dcbc3ea01e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD81.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6481

From: Carolina Jubran <cjubran@nvidia.com>

Introduce support for traffic classes (TC) in the devlink-rate API,
expanding beyond the current two object types: nodes and leafs. The
support of traffic classes provides more granular control, especially
in scenarios where customers need to implement Enhanced Transmission
Selection (ETS) for specific groups of Virtual Functions (VFs).

For instance, users can now allocate specific traffic classes, such as
TC0 and TC5, to handle TCP/UDP and RoCE traffic respectively, with
defined bandwidth shares (e.g., 20% for TC0 and 80% for TC5).

Example:
DEV=pci/0000:08:00.0

devlink port function rate add $DEV/vfs_group tx_share 10Gbit tx_max 50Gbit
devlink port function rate add $DEV/group_tc0 tx_weight 20 parent vfs_group
devlink port function rate add $DEV/group_tc5 tx_weight 80 parent vfs_group
devlink port function rate set $DEV/1/tc0 parent group_tc0
devlink port function rate set $DEV/2/tc0 parent group_tc0

devlink port function rate set $DEV/1/tc5 parent group_tc5
devlink port function rate set $DEV/2/tc5 parent group_tc5

Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Change-Id: If14e37966db416e1ff715c19439d071814800efe
---
 Documentation/netlink/specs/devlink.yaml      |   8 ++
 .../networking/devlink/devlink-port.rst       |  18 ++-
 include/net/devlink.h                         |  16 +++
 include/uapi/linux/devlink.h                  |   2 +
 net/devlink/netlink_gen.c                     |   3 +
 net/devlink/rate.c                            | 128 ++++++++++++++++++
 6 files changed, 170 insertions(+), 5 deletions(-)

diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
index 09fbb4c03fc8..14e702c17387 100644
--- a/Documentation/netlink/specs/devlink.yaml
+++ b/Documentation/netlink/specs/devlink.yaml
@@ -83,6 +83,8 @@ definitions:
         name: leaf
       -
         name: node
+      -
+        name: traffic-class
   -
     type: enum
     name: sb-threshold-type
@@ -781,6 +783,9 @@ attribute-sets:
       -
         name: rate-tx-max
         type: u64
+      -
+        name: rate-traffic-class-index
+        type: u16
       -
         name: rate-node-name
         type: string
@@ -2121,6 +2126,7 @@ operations:
             - bus-name
             - dev-name
             - port-index
+            - rate-traffic-class-index
             - rate-node-name
         reply: &rate-get-reply
           value: 76
@@ -2143,6 +2149,7 @@ operations:
           attributes:
             - bus-name
             - dev-name
+            - rate-traffic-class-index
             - rate-node-name
             - rate-tx-share
             - rate-tx-max
@@ -2163,6 +2170,7 @@ operations:
           attributes:
             - bus-name
             - dev-name
+            - rate-traffic-class-index
             - rate-node-name
             - rate-tx-share
             - rate-tx-max
diff --git a/Documentation/networking/devlink/devlink-port.rst b/Documentation/networking/devlink/devlink-port.rst
index 9d22d41a7cd1..6ea50b7cf769 100644
--- a/Documentation/networking/devlink/devlink-port.rst
+++ b/Documentation/networking/devlink/devlink-port.rst
@@ -374,14 +374,21 @@ At this point a matching subfunction driver binds to the subfunction's auxiliary
 Rate object management
 ======================
 
-Devlink provides API to manage tx rates of single devlink port or a group.
-This is done through rate objects, which can be one of the two types:
+Devlink provides API to manage tx rates of single devlink port, specific traffic classes or a group.
+This is done through rate objects, which can be one of the three types:
 
 ``leaf``
   Represents a single devlink port; created/destroyed by the driver. Since leaf
   have 1to1 mapping to its devlink port, in user space it is referred as
   ``pci/<bus_addr>/<port_index>``;
 
+``traffic class (tc)``
+  Represents a traffic class on a devlink port; created/destroyed by the
+  driver. The traffic class object is referred to in userspace as
+  ``pci/<bus_addr>/<port_index>/tc<traffic_class_index>``. This object allows
+  for the management of TX rates at the traffic class level on a specific
+  devlink port.
+
 ``node``
   Represents a group of rate objects (leafs and/or nodes); created/deleted by
   request from the userspace; initially empty (no rate objects added). In
@@ -437,9 +444,10 @@ Arbitration flow from the high level:
 #. If all the nodes from the highest priority sub-group are satisfied, or
    overused their assigned BW, move to the lower priority nodes.
 
-Driver implementations are allowed to support both or either rate object types
-and setting methods of their parameters. Additionally driver implementation
-may export nodes/leafs and their child-parent relationships.
+Driver implementations are allowed to support any combination of the rate
+object types and setting methods of their parameters. Additionally driver
+implementation may export nodes, leafs, traffic classes, and their
+child-parent relationships.
 
 Terms and Definitions
 =====================
diff --git a/include/net/devlink.h b/include/net/devlink.h
index db5eff6cb60f..a485c489acd6 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -117,6 +117,7 @@ struct devlink_rate {
 
 	u32 tx_priority;
 	u32 tx_weight;
+	u16 tc_id;
 };
 
 struct devlink_port {
@@ -1477,6 +1478,14 @@ struct devlink_ops {
 					 u32 tx_priority, struct netlink_ext_ack *extack);
 	int (*rate_node_tx_weight_set)(struct devlink_rate *devlink_rate, void *priv,
 				       u32 tx_weight, struct netlink_ext_ack *extack);
+	int (*rate_traffic_class_tx_share_set)(struct devlink_rate *devlink_rate, void *priv,
+					       u64 tx_share, struct netlink_ext_ack *extack);
+	int (*rate_traffic_class_tx_max_set)(struct devlink_rate *devlink_rate, void *priv,
+					     u64 tx_max, struct netlink_ext_ack *extack);
+	int (*rate_traffic_class_tx_priority_set)(struct devlink_rate *devlink_rate, void *priv,
+						  u32 tx_priority, struct netlink_ext_ack *extack);
+	int (*rate_traffic_class_tx_weight_set)(struct devlink_rate *devlink_rate, void *priv,
+						u32 tx_weight, struct netlink_ext_ack *extack);
 	int (*rate_node_new)(struct devlink_rate *rate_node, void **priv,
 			     struct netlink_ext_ack *extack);
 	int (*rate_node_del)(struct devlink_rate *rate_node, void *priv,
@@ -1489,6 +1498,10 @@ struct devlink_ops {
 				    struct devlink_rate *parent,
 				    void *priv_child, void *priv_parent,
 				    struct netlink_ext_ack *extack);
+	int (*rate_traffic_class_parent_set)(struct devlink_rate *child,
+					     struct devlink_rate *parent,
+					     void *priv_child, void *priv_parent,
+					     struct netlink_ext_ack *extack);
 	/**
 	 * selftests_check() - queries if selftest is supported
 	 * @devlink: devlink instance
@@ -1723,6 +1736,9 @@ devl_rate_node_create(struct devlink *devlink, void *priv, char *node_name,
 int
 devl_rate_leaf_create(struct devlink_port *devlink_port, void *priv,
 		      struct devlink_rate *parent);
+int
+devl_rate_traffic_class_create(struct devlink_port *devlink_port, void *priv, u16 tc_id,
+			       struct devlink_rate *parent);
 void devl_rate_leaf_destroy(struct devlink_port *devlink_port);
 void devl_rate_nodes_destroy(struct devlink *devlink);
 void devlink_port_linecard_set(struct devlink_port *devlink_port,
diff --git a/include/uapi/linux/devlink.h b/include/uapi/linux/devlink.h
index 9401aa343673..94f6e3ca5f8d 100644
--- a/include/uapi/linux/devlink.h
+++ b/include/uapi/linux/devlink.h
@@ -224,6 +224,7 @@ enum devlink_port_flavour {
 enum devlink_rate_type {
 	DEVLINK_RATE_TYPE_LEAF,
 	DEVLINK_RATE_TYPE_NODE,
+	DEVLINK_RATE_TYPE_TRAFFIC_CLASS,
 };
 
 enum devlink_param_cmode {
@@ -595,6 +596,7 @@ enum devlink_attr {
 	DEVLINK_ATTR_RATE_TYPE,			/* u16 */
 	DEVLINK_ATTR_RATE_TX_SHARE,		/* u64 */
 	DEVLINK_ATTR_RATE_TX_MAX,		/* u64 */
+	DEVLINK_ATTR_RATE_TRAFFIC_CLASS_INDEX,	/* u16 */
 	DEVLINK_ATTR_RATE_NODE_NAME,		/* string */
 	DEVLINK_ATTR_RATE_PARENT_NODE_NAME,	/* string */
 
diff --git a/net/devlink/netlink_gen.c b/net/devlink/netlink_gen.c
index f9786d51f68f..d62772a02930 100644
--- a/net/devlink/netlink_gen.c
+++ b/net/devlink/netlink_gen.c
@@ -486,6 +486,7 @@ static const struct nla_policy devlink_rate_get_do_nl_policy[DEVLINK_ATTR_RATE_N
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_PORT_INDEX] = { .type = NLA_U32, },
+	[DEVLINK_ATTR_RATE_TRAFFIC_CLASS_INDEX] = { .type = NLA_U16, },
 	[DEVLINK_ATTR_RATE_NODE_NAME] = { .type = NLA_NUL_STRING, },
 };
 
@@ -499,6 +500,7 @@ static const struct nla_policy devlink_rate_get_dump_nl_policy[DEVLINK_ATTR_DEV_
 static const struct nla_policy devlink_rate_set_nl_policy[DEVLINK_ATTR_RATE_TX_WEIGHT + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_RATE_TRAFFIC_CLASS_INDEX] = { .type = NLA_U16, },
 	[DEVLINK_ATTR_RATE_NODE_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_RATE_TX_SHARE] = { .type = NLA_U64, },
 	[DEVLINK_ATTR_RATE_TX_MAX] = { .type = NLA_U64, },
@@ -511,6 +513,7 @@ static const struct nla_policy devlink_rate_set_nl_policy[DEVLINK_ATTR_RATE_TX_W
 static const struct nla_policy devlink_rate_new_nl_policy[DEVLINK_ATTR_RATE_TX_WEIGHT + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_RATE_TRAFFIC_CLASS_INDEX] = { .type = NLA_U16, },
 	[DEVLINK_ATTR_RATE_NODE_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_RATE_TX_SHARE] = { .type = NLA_U64, },
 	[DEVLINK_ATTR_RATE_TX_MAX] = { .type = NLA_U64, },
diff --git a/net/devlink/rate.c b/net/devlink/rate.c
index 7139e67e93ae..6812690883df 100644
--- a/net/devlink/rate.c
+++ b/net/devlink/rate.c
@@ -18,6 +18,12 @@ devlink_rate_is_node(struct devlink_rate *devlink_rate)
 	return devlink_rate->type == DEVLINK_RATE_TYPE_NODE;
 }
 
+static inline bool
+devlink_rate_is_traffic_class(struct devlink_rate *devlink_rate)
+{
+	return devlink_rate->type == DEVLINK_RATE_TYPE_TRAFFIC_CLASS;
+}
+
 static struct devlink_rate *
 devlink_rate_leaf_get_from_info(struct devlink *devlink, struct genl_info *info)
 {
@@ -31,6 +37,43 @@ devlink_rate_leaf_get_from_info(struct devlink *devlink, struct genl_info *info)
 	return devlink_rate ?: ERR_PTR(-ENODEV);
 }
 
+static struct devlink_rate *
+devlink_rate_traffic_class_get_by_id(struct devlink *devlink, u16 tc_id)
+{
+	static struct devlink_rate *devlink_rate;
+
+	list_for_each_entry(devlink_rate, &devlink->rate_list, list) {
+		if (devlink_rate_is_traffic_class(devlink_rate) &&
+		    devlink_rate->tc_id == tc_id)
+			return devlink_rate;
+	}
+
+	return ERR_PTR(-ENODEV);
+}
+
+static struct devlink_rate *
+devlink_rate_traffic_class_get_from_attrs(struct devlink *devlink, struct nlattr **attrs)
+{
+	struct devlink_rate *devlink_rate;
+	u16 tc_id;
+
+	if (!attrs[DEVLINK_ATTR_RATE_TRAFFIC_CLASS_INDEX])
+		return ERR_PTR(-EINVAL);
+
+	tc_id = nla_get_u16(attrs[DEVLINK_ATTR_RATE_TRAFFIC_CLASS_INDEX]);
+	devlink_rate = devlink_rate_traffic_class_get_by_id(devlink, tc_id);
+	if (!devlink_rate)
+		return ERR_PTR(-ENODEV);
+
+	return devlink_rate;
+}
+
+static struct devlink_rate *
+devlink_rate_traffic_class_get_from_info(struct devlink *devlink, struct genl_info *info)
+{
+	return devlink_rate_traffic_class_get_from_attrs(devlink, info->attrs);
+}
+
 static struct devlink_rate *
 devlink_rate_node_get_by_name(struct devlink *devlink, const char *node_name)
 {
@@ -76,6 +119,8 @@ devlink_rate_get_from_info(struct devlink *devlink, struct genl_info *info)
 		return devlink_rate_leaf_get_from_info(devlink, info);
 	else if (attrs[DEVLINK_ATTR_RATE_NODE_NAME])
 		return devlink_rate_node_get_from_info(devlink, info);
+	else if (attrs[DEVLINK_ATTR_RATE_TRAFFIC_CLASS_INDEX])
+		return devlink_rate_traffic_class_get_from_info(devlink, info);
 	else
 		return ERR_PTR(-EINVAL);
 }
@@ -106,6 +151,10 @@ static int devlink_nl_rate_fill(struct sk_buff *msg,
 		if (nla_put_string(msg, DEVLINK_ATTR_RATE_NODE_NAME,
 				   devlink_rate->name))
 			goto nla_put_failure;
+	} else if (devlink_rate_is_traffic_class(devlink_rate)) {
+		if (nla_put_u16(msg, DEVLINK_ATTR_RATE_TRAFFIC_CLASS_INDEX, devlink_rate->tc_id) ||
+		    nla_put_u32(msg, DEVLINK_ATTR_PORT_INDEX, devlink_rate->devlink_port->index))
+			goto nla_put_failure;
 	}
 
 	if (nla_put_u64_64bit(msg, DEVLINK_ATTR_RATE_TX_SHARE,
@@ -273,6 +322,10 @@ devlink_nl_rate_parent_node_set(struct devlink_rate *devlink_rate,
 			err = ops->rate_node_parent_set(devlink_rate, NULL,
 							devlink_rate->priv, NULL,
 							info->extack);
+		else if (devlink_rate_is_traffic_class(devlink_rate))
+			err = ops->rate_traffic_class_parent_set(devlink_rate, NULL,
+								 devlink_rate->priv, NULL,
+								 info->extack);
 		if (err)
 			return err;
 
@@ -302,6 +355,10 @@ devlink_nl_rate_parent_node_set(struct devlink_rate *devlink_rate,
 			err = ops->rate_node_parent_set(devlink_rate, parent,
 							devlink_rate->priv, parent->priv,
 							info->extack);
+		else if (devlink_rate_is_traffic_class(devlink_rate))
+			err = ops->rate_traffic_class_parent_set(devlink_rate, parent,
+								 devlink_rate->priv, parent->priv,
+								 info->extack);
 		if (err)
 			return err;
 
@@ -449,6 +506,32 @@ static bool devlink_rate_set_ops_supported(const struct devlink_ops *ops,
 					    "TX weight set isn't supported for the nodes");
 			return false;
 		}
+	} else if (type == DEVLINK_RATE_TYPE_TRAFFIC_CLASS) {
+		if (attrs[DEVLINK_ATTR_RATE_TX_SHARE] && !ops->rate_traffic_class_tx_share_set) {
+			NL_SET_ERR_MSG(info->extack, "TX share set isn't supported for the traffic classes");
+			return false;
+		}
+		if (attrs[DEVLINK_ATTR_RATE_TX_MAX] && !ops->rate_traffic_class_tx_max_set) {
+			NL_SET_ERR_MSG(info->extack, "TX max set isn't supported for the traffic classes");
+			return false;
+		}
+		if (attrs[DEVLINK_ATTR_RATE_PARENT_NODE_NAME] &&
+		    !ops->rate_traffic_class_parent_set) {
+			NL_SET_ERR_MSG(info->extack, "Parent set isn't supported for the traffic classes");
+			return false;
+		}
+		if (attrs[DEVLINK_ATTR_RATE_TX_PRIORITY] && !ops->rate_traffic_class_tx_priority_set) {
+			NL_SET_ERR_MSG_ATTR(info->extack,
+					    attrs[DEVLINK_ATTR_RATE_TX_PRIORITY],
+					    "TX priority set isn't supported for the traffic classes");
+			return false;
+		}
+		if (attrs[DEVLINK_ATTR_RATE_TX_WEIGHT] && !ops->rate_traffic_class_tx_weight_set) {
+			NL_SET_ERR_MSG_ATTR(info->extack,
+					    attrs[DEVLINK_ATTR_RATE_TX_WEIGHT],
+					    "TX weight set isn't supported for the traffic classes");
+			return false;
+		}
 	} else {
 		WARN(1, "Unknown type of rate object");
 		return false;
@@ -659,6 +742,48 @@ int devl_rate_leaf_create(struct devlink_port *devlink_port, void *priv,
 }
 EXPORT_SYMBOL_GPL(devl_rate_leaf_create);
 
+/**
+ * devl_rate_traffic_class_create - create devlink rate queue
+ * @devlink: devlink instance
+ * @priv: driver private data
+ * @tc_id: identifier of the new traffic class
+ *
+ * Create devlink rate object of type node
+ */
+int devl_rate_traffic_class_create(struct devlink_port *devlink_port, void *priv, u16 tc_id,
+				   struct devlink_rate *parent)
+{
+	struct devlink *devlink = devlink_port->devlink;
+	struct devlink_rate *devlink_rate;
+
+	devl_assert_locked(devlink);
+
+	devlink_rate = devlink_rate_traffic_class_get_by_id(devlink, tc_id);
+	if (!IS_ERR(devlink_rate))
+		return -EEXIST;
+
+	devlink_rate = kzalloc(sizeof(*devlink_rate), GFP_KERNEL);
+	if (!devlink_rate)
+		return -ENOMEM;
+
+	if (parent) {
+		devlink_rate->parent = parent;
+		refcount_inc(&devlink_rate->parent->refcnt);
+	}
+
+	devlink_rate->type = DEVLINK_RATE_TYPE_TRAFFIC_CLASS;
+	devlink_rate->devlink = devlink;
+	devlink_rate->devlink_port = devlink_port;
+	devlink_rate->tc_id = tc_id;
+	devlink_rate->priv = priv;
+	list_add_tail(&devlink_rate->list, &devlink->rate_list);
+	devlink_port->devlink_rate = devlink_rate;
+	devlink_rate_notify(devlink_rate, DEVLINK_CMD_RATE_NEW);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(devl_rate_traffic_class_create);
+
 /**
  * devl_rate_leaf_destroy - destroy devlink rate leaf
  *
@@ -708,6 +833,9 @@ void devl_rate_nodes_destroy(struct devlink *devlink)
 		else if (devlink_rate_is_node(devlink_rate))
 			ops->rate_node_parent_set(devlink_rate, NULL, devlink_rate->priv,
 						  NULL, NULL);
+		else if (devlink_rate_is_traffic_class(devlink_rate))
+			ops->rate_traffic_class_parent_set(devlink_rate, NULL, devlink_rate->priv,
+							   NULL, NULL);
 	}
 	list_for_each_entry_safe(devlink_rate, tmp, &devlink->rate_list, list) {
 		if (devlink_rate_is_node(devlink_rate)) {
-- 
2.43.2


