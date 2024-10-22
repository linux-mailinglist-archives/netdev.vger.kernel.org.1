Return-Path: <netdev+bounces-137911-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B749AB16D
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 16:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC6511C229B8
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 14:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA021A01AB;
	Tue, 22 Oct 2024 14:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="js6AWYLK"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2080.outbound.protection.outlook.com [40.107.236.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978807DA7C
	for <netdev@vger.kernel.org>; Tue, 22 Oct 2024 14:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729608690; cv=fail; b=SnRorplLkxczJqI1CDukzKmiqRZ6mf01ETh2ex4kipAYyF3A2/iHlXF76plOXyTbX8CAFDF1rBnQ1lSHHL3n5BHRniTWnHiFKOsK29aYck5lcE+PUCLwArJ6TIchJbdv1wV29lNU332jitnlsggtAGY03Kc74tmxA/WurOIrWdM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729608690; c=relaxed/simple;
	bh=Dlrg+iYoc3moCw8DxpDWvhJqMUBd4eWPwzeZpX5XyCk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nltTlmmpQ1Ojh8h4SmIir/alvSTIuKhqHCucjevBLiecsvHcgCjuKKkUu8RXMniq1nT27w0Bh+Y/KsiAlz16oqieyVYBwWMeCgLlUeShu7/aG/y5qJSgDXBhiiWvzGE+Rx8OMrnqVZ3BX8493lVZcSuNIPQC6+HOl19NFUKW49c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=js6AWYLK; arc=fail smtp.client-ip=40.107.236.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rHUvKmkFCcY25OSbshkRwEtt9yrY5hqDYTrb+kBd+gD7MfUFXAQl0emBa22W6pSsYTCNQgU3ui4UHuDSVzX5S6FSxB29UmG6jADexjr2Vj45HL7Whvqu7fqhd+vLPn6Me8LACFXAHwh7hqJFAofyJipCloyo8o1TF8rmE/f1dUJWuAua5Tfpsrni/XZev8owV7nQAxwuQYzpdN/GpoDcyOCxosJs0JCGcOh3T69ZdeMRgcH3vs3XmZPFg6CdBYQsNs8LHvxNZpMDSgIFYRnyK666FtwTLbmjYw6MwuiQ+fS8V9SYWkBvGJb7llH+a07QEiMTkkfh+Sh2+iTaOfjB8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hIO3xvGTf22aCNfqHakyJgIhITzblk8urTZlYt9npWM=;
 b=bMhofnhNSbMbJW1WMxqApTeLSzSykXvzTTpBhXW/8eE+6ouHgBKDHTMQZKGbL9QjJqdPm0Il8DwplRqOlueTx5DzW5vtr8XDTlxCRPfDt34XWxWqVBaXxiqFcySQVlPrj9fm+Omz7slAxn5ie7moghDdeIZZTp5OlONKpAtRBT/f9yqX813e0y3XHfxGRCeD5mL5xK9vlZHPkVc25iAXqFnZazxB7HuBQeLw96V5LLVNOjZyz2kpq/zV16jt3giWdDu7EkGfS95A9U3TID6r1TupVtqe57FfxwSZhTtAZYSqDuepH0HWjgQNFk+M9v9jX8RWQpGHh9cWMm+rI/smCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hIO3xvGTf22aCNfqHakyJgIhITzblk8urTZlYt9npWM=;
 b=js6AWYLKWynmLBMQzFuvH5/tLPmKtRpYj1FtArZ/ikET9k4CIbCq5xzuElogIT2DHfshyKK/CiD/IJ2KtrT17ZRmxrCQlglz29GzTnJAf6LVY3dt1XlnEOupnjC8aeTqTXRpOwp8+EkdU3D5Hu0/mcbd6RWcDBSQlKWptWVZfHketGmheu0K4TWNwrEWaQv3PbLhZ4/64rO2oaLKijQ3QSfwDpjd4OiMolw0lBI8ZFAT4S8SKgeWwjoiTbxVuyDxuSehMqmGfjkCb9ph64YhW28YB7GDEQFH/ddMJkDUy+GLgM4rGDH2DFADdXbQrzFVCOgtBXU3kHr0J/+M0Rf0Ew==
Received: from MW2PR16CA0030.namprd16.prod.outlook.com (2603:10b6:907::43) by
 MW4PR12MB6949.namprd12.prod.outlook.com (2603:10b6:303:208::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Tue, 22 Oct
 2024 14:51:21 +0000
Received: from SJ1PEPF000023D7.namprd21.prod.outlook.com
 (2603:10b6:907:0:cafe::11) by MW2PR16CA0030.outlook.office365.com
 (2603:10b6:907::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16 via Frontend
 Transport; Tue, 22 Oct 2024 14:51:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000023D7.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.2 via Frontend Transport; Tue, 22 Oct 2024 14:51:21 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 22 Oct
 2024 07:51:05 -0700
Received: from fedora.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 22 Oct
 2024 07:50:57 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Amit
 Cohen" <amcohen@nvidia.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
	<mlxsw@nvidia.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	<intel-wired-lan@lists.osuosl.org>, <UNGLinuxDriver@microchip.com>, "Manish
 Chopra" <manishc@marvell.com>, <GR-Linux-NIC-Dev@marvell.com>, "Kuniyuki
 Iwashima" <kuniyu@amazon.com>, Andrew Lunn <andrew+netdev@lunn.ch>
Subject: [PATCH net-next 1/8] net: rtnetlink: Publish rtnl_fdb_notify()
Date: Tue, 22 Oct 2024 16:50:12 +0200
Message-ID: <ada2163d8edc973535987bcf87cd607761143adb.1729607879.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1729607879.git.petrm@nvidia.com>
References: <cover.1729607879.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D7:EE_|MW4PR12MB6949:EE_
X-MS-Office365-Filtering-Correlation-Id: 3421eb05-c072-461c-c1bc-08dcf2a8fe28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jmktBR8+dxzAbccA17xsQCKOAo0gblcnHw2/N9REPym3gBd7oetg+25Me7t2?=
 =?us-ascii?Q?s6liY1M2wAN7nepYH2ur/pUy7NGWnoNXCVqm+dguvM1+0JlP0+ERIMM3jnU2?=
 =?us-ascii?Q?A6r0bCah3H+uAPqk34eGtQjdAVI6oNuHS6CVsBMZKz16oqSDorR+E/3wkHr1?=
 =?us-ascii?Q?HCk1EJU1LQIGDlq/uNfh4E0BhOy/jbuAd3QAs5J79Zls8Ukebq0jXQkEBmI9?=
 =?us-ascii?Q?a01KIwUgZTSTpO54eg6GIfJXq+jz++UhGCvNcCdCgCS9dFiQS1hjt+IpZuz6?=
 =?us-ascii?Q?WRX9LbB4oRIacIukjpgn7O1y0bg7riWZPBbX3UNjRrlOtjZivHugtFXFJx/w?=
 =?us-ascii?Q?MnmLGj6XZH866H6O/uUSyf7LrjbSdRzqgZm/xiaQVEGgCxVyzhE0WAIK372j?=
 =?us-ascii?Q?brvd1b8+mqHsIPwm3zflZbb+wf8tQsETxSExfzg3+0ImbhMS4inWhkzGDqLH?=
 =?us-ascii?Q?WcOdzWVIVHKFmWBmP5mfgwoDhcXeXSc8uAEpo67GeKQ+goyRE2+hv6lZwxW1?=
 =?us-ascii?Q?v81pxTnklKLmtWnJJT2FQBT2Yf4v2FaJ+54xl3/J2g/kkM8Tw75eFFRkfw0v?=
 =?us-ascii?Q?UtOzMtUTTQW67rPckvCQQkaF4c/mAHaCpVCA5SpggJ7TbTrIGxPLx3GGP5sQ?=
 =?us-ascii?Q?NcpILMpB5R7Gj2h6w/1oIS2C01oyt7Wxb2LkwfKOr4QwZ0PcB1k7WIEx9kj8?=
 =?us-ascii?Q?MQFmiJvbPSvQ3AWYxLcWc6KOiRgymKdfM/wpUgEadGrxmaES6bVbT0VCQ0rG?=
 =?us-ascii?Q?wrefXAQMXAbZiSUTHl/l/xATiAE3UweKcAHbx3zocd79ZLI//Zs0AA91+P01?=
 =?us-ascii?Q?Bv/2F1pqJ4DQmMssvvU+xA+siUMGdkki7UZKrQ3PPaD3LwLI9CCuZNsHeZNx?=
 =?us-ascii?Q?Vzh5XkfiDHCzaxXj2LjCjh9eA3esUNE3x4BrbHqHxeBStpgsS4fW3dcB9wxB?=
 =?us-ascii?Q?ippesbeWC3/jEzfORDpXApGdQHELj+tqXt6Fm9SNk0CJfTH5nRXgXAKcuKNC?=
 =?us-ascii?Q?Y3UboasNL098sjfzG8U53Y06X1kKrLEqPFjCdp+HxhqWB2EtPfq18NFMeu4y?=
 =?us-ascii?Q?P3JyOCqsEMnR3Z0FmYNl+4lrr0fHjWyQTclRREJ8RIKpSStYI/pniTAlIeQX?=
 =?us-ascii?Q?BCJTOcaKglBki2tD4uZXsA4JygM+AmMubRoFyiKJDmXyojcbSs48ZA4AdKOB?=
 =?us-ascii?Q?rcD9RxXRQmtV8gGSdntZ2XlyYd8PyG7oNgCF+TGSDAySb+kA5DQ9MazXoluD?=
 =?us-ascii?Q?5rcAtifdKrnM3P2AM/nMegiDSg6RUhJnAQ1t//47TD15BIHM3ZM3/Zkz+ZFk?=
 =?us-ascii?Q?LO2BRlkY3OmmyVYWEJyoP97MnXzE66QaOExI9+ZVK80utCOBdCuh99vYkwz3?=
 =?us-ascii?Q?puANEA0baV4yV45jYDUSRy2kaUlv8eRRFPhlj+LTMSUoWmq4sg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 14:51:21.1029
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3421eb05-c072-461c-c1bc-08dcf2a8fe28
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6949

In the next patch, responsibility for sending notification is moved from
the core to the driver that implement fdb_add (and fdb_del in the patch
after that). In this patch, export a helper that the core currently uses
for sending FDB notifications for the drivers to use as a fallback if there
is nothing specific to report.

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Amit Cohen <amcohen@nvidia.com>
---
CC: Przemek Kitszel <przemyslaw.kitszel@intel.com>
CC: intel-wired-lan@lists.osuosl.org
CC: UNGLinuxDriver@microchip.com
CC: Manish Chopra <manishc@marvell.com>
CC: GR-Linux-NIC-Dev@marvell.com
CC: Kuniyuki Iwashima <kuniyu@amazon.com>
CC: Andrew Lunn <andrew+netdev@lunn.ch>
---
 include/linux/rtnetlink.h | 2 ++
 net/core/rtnetlink.c      | 7 ++++---
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/linux/rtnetlink.h b/include/linux/rtnetlink.h
index 8468a4ce8510..2e48b4ca7187 100644
--- a/include/linux/rtnetlink.h
+++ b/include/linux/rtnetlink.h
@@ -192,6 +192,8 @@ extern int ndo_dflt_fdb_add(struct ndmsg *ndm,
 			    const unsigned char *addr,
 			    u16 vid,
 			    u16 flags);
+extern void rtnl_fdb_notify(struct net_device *dev, const u8 *addr, u16 vid,
+			    int type, u16 ndm_state);
 extern int ndo_dflt_fdb_del(struct ndmsg *ndm,
 			    struct nlattr *tb[],
 			    struct net_device *dev,
diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 194a81e5f608..e5c6dd4c5cf5 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -4271,7 +4271,7 @@ void rtmsg_ifinfo_newnet(int type, struct net_device *dev, unsigned int change,
 
 static int nlmsg_populate_fdb_fill(struct sk_buff *skb,
 				   struct net_device *dev,
-				   u8 *addr, u16 vid, u32 pid, u32 seq,
+				   const u8 *addr, u16 vid, u32 pid, u32 seq,
 				   int type, unsigned int flags,
 				   int nlflags, u16 ndm_state)
 {
@@ -4313,8 +4313,8 @@ static inline size_t rtnl_fdb_nlmsg_size(const struct net_device *dev)
 	       0;
 }
 
-static void rtnl_fdb_notify(struct net_device *dev, u8 *addr, u16 vid, int type,
-			    u16 ndm_state)
+void rtnl_fdb_notify(struct net_device *dev, const u8 *addr, u16 vid, int type,
+		     u16 ndm_state)
 {
 	struct net *net = dev_net(dev);
 	struct sk_buff *skb;
@@ -4336,6 +4336,7 @@ static void rtnl_fdb_notify(struct net_device *dev, u8 *addr, u16 vid, int type,
 errout:
 	rtnl_set_sk_err(net, RTNLGRP_NEIGH, err);
 }
+EXPORT_SYMBOL_GPL(rtnl_fdb_notify);
 
 /*
  * ndo_dflt_fdb_add - default netdevice operation to add an FDB entry
-- 
2.45.0


