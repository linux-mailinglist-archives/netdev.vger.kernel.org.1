Return-Path: <netdev+bounces-214040-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61AC6B27EDD
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 13:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CD2AB62EE2
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 11:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B02063002AF;
	Fri, 15 Aug 2025 11:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DDZoowHY"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2072.outbound.protection.outlook.com [40.107.92.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2D820012B;
	Fri, 15 Aug 2025 11:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755256055; cv=fail; b=K1U/63eV5rkJrC0WYQV9tg5E5Z4cSV+bbxIvWvS7yATPravy856RGdeh978uXmaXik7qA6PUJXD/G28ta7llgE/yGGdCuOqd9PCnmZBwl1Dm5sOtVMWSBba8chuh51BHzXjVW8z6MYCZun4/OStx6cGM8lR6neM+DPVsASuszhY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755256055; c=relaxed/simple;
	bh=IkOG7Jn7h/u1swNCKcqOX0IXYF1NYzjsODyvqBvk4K0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YJhSma+N3qpdhND0pme/J7jY9lIFZwQ4v0vbqC/ubwz2PB3ZMzK3TPADfoLhvgWKNWGRT9ebuAld/rdPFxVODlg6t9a/aT1f4MlBWCa92HkWP439xs4ljwHeZlAlIcWBgIUEZ9OWPE29uERJH+I/FBKdVQauxXMvNyLZJldLSAE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DDZoowHY; arc=fail smtp.client-ip=40.107.92.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NGBwO9hxSz4izyTLKYTY8Pjw1lJ1vhLRzzkQgueNs656OucKZNhqEeFHl9M9Ro1dOOYDISnD9B7AiXXsjCe8qqYXITDNVpUiSf972gbR69Gi2VyC6WFrQqXM0nzVbgdk1tD/PJTfWDINMSZsWfAJPdxzA5GmOsEQFbuaLmkXk76dh0SzJ0QVXYCfX9YiFp6iQI1XKmOTwS/+bjJF6LfKwTZ8DL2iKhDk01t4sgWWtnUsy12lIlpMHMKUXaioxu5qsIR2R0A+NjZQQy3gZKOMrbDtk4pXgvES/JsHau8UW/vNNGwxTtMlLjDjFJCN5s/ou6fTNns0GEJs5uUgtbWlwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uKQvHLzi3G/SJ0AYieUzkEDLfNfB3HSu9gocVsmoePs=;
 b=KF3l468ogrLXv51i7+sjK0L38i7XXzR9qIY9qhp5dtETXhtSUDcMc1dQf8NgLSEjWqbJvbqe949MJNnZ5D3dEhoFsSKferlv7R+653VBIfP4+9oGgtnTIMlgp/6L7aGhxZXsGJE/uO1zlqu0IDffA9snWm2m/hd7f24lPqlUN7oUyAXKTWF9Nds+F38rJqzcdwN9XtpzME5WGnFmAh4XVMQzHN5hF4XL3d6pMS7Bg7ZoFuKvuPSVqD5eh4gI67AK5C4wbQ80yW0PUGOWEZcx1wHcJBX9Ul0L/CYzIk9ektXPD0reVOxHEvWJxgtJeGK+ICywup079YuK/8eI+R1fkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uKQvHLzi3G/SJ0AYieUzkEDLfNfB3HSu9gocVsmoePs=;
 b=DDZoowHYx95HozQhIV/mYd05QnOg4wQ4WV5vydZrajY1u+bYLIg6w6OvB7bE4p7T/2uKDUlbA6vqW9SkMlGHghSSguvSf5T7Q0H2Kp+PRj15/8E6im69bG2Ci7uq0DKkChIXLOLEQY7k3zU8IxesMGiqsdFmTd/JFVrLrVv5huvkMtZxHjHVK0M2CrdV/dGyAR5WNKzfZNpt5BWoh45HaSy02ixwfgdYhuAnuXvsmcOSvS7l5u/WtLdXzAS+p69auCGQx9yDytREHz02ZDodYhAVuyMHnnLptQh22w1H+PKYvPjk0/Pfe3bkyuIDq2oa2HccGr7/juLzW1THrS5OLQ==
Received: from LV3P220CA0028.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:234::21)
 by DS7PR12MB5815.namprd12.prod.outlook.com (2603:10b6:8:77::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.14; Fri, 15 Aug
 2025 11:07:31 +0000
Received: from BN3PEPF0000B069.namprd21.prod.outlook.com
 (2603:10b6:408:234:cafe::6a) by LV3P220CA0028.outlook.office365.com
 (2603:10b6:408:234::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.19 via Frontend Transport; Fri,
 15 Aug 2025 11:07:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF0000B069.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.0 via Frontend Transport; Fri, 15 Aug 2025 11:07:31 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 15 Aug
 2025 04:07:16 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 15 Aug
 2025 04:07:15 -0700
Received: from f42.dev-l-178 (10.127.8.9) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Fri, 15
 Aug 2025 04:07:12 -0700
From: Dragos Tatulea <dtatulea@nvidia.com>
To: <almasrymina@google.com>, <asml.silence@gmail.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>
CC: Dragos Tatulea <dtatulea@nvidia.com>, <cratiu@nvidia.com>,
	<tariqt@nvidia.com>, <parav@nvidia.com>, Christoph Hellwig
	<hch@infradead.org>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC net-next v3 7/7] net: devmem: allow binding on rx queues with same MA devices
Date: Fri, 15 Aug 2025 14:03:48 +0300
Message-ID: <20250815110401.2254214-9-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250815110401.2254214-2-dtatulea@nvidia.com>
References: <20250815110401.2254214-2-dtatulea@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B069:EE_|DS7PR12MB5815:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d2a6c99-e6c6-4bdf-aadd-08dddbebedff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6ebbilBBQZmcstivQQRfTAlOIEKVgmSV/cDD4W7WOHkeCmpYG7Bs5EKt5f74?=
 =?us-ascii?Q?JYJDNU3dDPhjB+nPVHo+52huqexs0tTiKQVdjzQ9HX+pGcNpkZ7+VY0aQLJF?=
 =?us-ascii?Q?lSbSKLtxSSETo4Um0gQQBz8fMbuvkzNvlTxu1Z1WYuCGloHmxvhakccfbxAI?=
 =?us-ascii?Q?m2XP6mG9wrPaxZDGa83I6q8ZPPK2MHjuch7euGW1mboaoD5bNVtAnoNOYWke?=
 =?us-ascii?Q?rhIyR/OBith+ut/9ow3O4gEDgpbgd4/QH/c574ieF7zyJmzKP5HpO8XK+lsz?=
 =?us-ascii?Q?z4lgDQcN91bqKey/L/Jo6XX0na2QD+ikSj4gsPQKHYHaRhfb16rdLaa3ymDk?=
 =?us-ascii?Q?swWPDq8t9M+XRLQtj+Yppu/UAb4UhVF92SiJczYZNf5L0iOnlDCi7QhjKYOP?=
 =?us-ascii?Q?XNjfFpSakr01X9VcorD/Uex+o3bKOHJend7fmgckIyZTv6c8vonQDZlgk9xZ?=
 =?us-ascii?Q?QLTOnIxO739wLrxE5ePJnwq5IPvTwESd0GBHforqK3hGzSp1rAjlGu9emBJN?=
 =?us-ascii?Q?LeWysSdTADmzcYAuoBix/GYTW4kpYCFqD87PVA0DSqaF+yMUH16bPRiluDU9?=
 =?us-ascii?Q?pT5qNOyo8PQH7yk1hlYwuO0jKYlYoSsVoK7OpdelzFRA5lq8+9Q1zY6ClOoq?=
 =?us-ascii?Q?ZKC0q043G+qoXfqLRn6n8mEunVHCsAHRVnCuQiTDG0aulhDydOzA8BhnN3Ed?=
 =?us-ascii?Q?0whnoiVgLWOOYsI247mjTqxKQdotymiLvPVzbNL6NC8x2xQdhBlxRfysKWjo?=
 =?us-ascii?Q?mNNBgD7eIRhuL9Rn4xTUA7pW2I8n9d34JW5aXZ5SwJAHw0kQyaRKir8U+KiW?=
 =?us-ascii?Q?RKUX2hftAnkc15dlyUf1cKp7blJqzdN5Ne98zDTRrMzIISA0VvzqzOAf1ISu?=
 =?us-ascii?Q?hqwB9EavhvhLxh9CXlcfGzwkJnvWwjWdPviegVX9Oankmz0d9+au978d91mB?=
 =?us-ascii?Q?LaaMPWyFMQt6jFcWhcXlod1XlNLU+DZPFEh97RyGF8U59vXgFqFUyqC3Ujp0?=
 =?us-ascii?Q?KCC5mWyw9iDuAeo+LG+yPoDlD5462b8vFTilMov/Fyo2S/95CCvxiOXEu8M5?=
 =?us-ascii?Q?7e3LNYRZQlkv6JzOjxvJ/HqUOfQPbU6t7jlJYomtS7BQT7o8LgL5B3WIz1JX?=
 =?us-ascii?Q?xkr6hpLuKtlo0QcXK5lSwxm3tZVG606uOh3EpAVkJPSCzZ8AptI3lrApK8Vx?=
 =?us-ascii?Q?6m8JF5w6Sq7SMxk4OhfHOgxZN5OTzz4DwDwbnWZn2Kg78pju1m4U67sUJyBD?=
 =?us-ascii?Q?dwlVcgKkzdo2GyElfKhAKA3+vwZoinkmNvHkWmTJHwqlZNIKvDMGiNvfFFUe?=
 =?us-ascii?Q?4xC3Jhy2eaOaTOcxFjnCVL7VNDR9VRwK8Kbi04tXqfHiRgxGvvwqrOcP8nsQ?=
 =?us-ascii?Q?6lL/+ESMGGw/DIvNxjV+zpqIehQTmhnse4bzIGy3JeCPIOp101v2dU4+HlqA?=
 =?us-ascii?Q?Tdn0tljYrWNhfu0jZx065EHodmuXWm1Dp8tHpQuyJ/CSN4Bp6SSlTBYEvDmk?=
 =?us-ascii?Q?EPOJJk9Faaxg6BtgTvhaKKgjRmKJLqhoidd/?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 11:07:31.1458
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d2a6c99-e6c6-4bdf-aadd-08dddbebedff
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B069.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5815

Multi-PF netdevs have queues belonging to different PFs which also means
different DMA devices. This means that the binding on the DMA buffer can
be done to the incorrect device.

This change allows devmem binding to multiple queues only when the
queues have the same DMA device. Otherwise an error is returned.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
---
 net/core/netdev-genl.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 3e990f100bf0..649b62803529 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -903,6 +903,31 @@ static int netdev_nl_read_rxq_bitmap(struct genl_info *info,
 	return 0;
 }
 
+static struct device *netdev_nl_get_dma_dev(struct net_device *netdev,
+					    unsigned long *rxq_bitmap,
+					    struct netlink_ext_ack *extack)
+{
+	struct device *dma_dev = NULL;
+	u32 rxq_idx;
+
+	for_each_set_bit(rxq_idx, rxq_bitmap, netdev->num_rx_queues) {
+		struct device *rxq_dma_dev;
+
+		rxq_dma_dev = netdev_queue_get_dma_dev(netdev, rxq_idx);
+		/* Multi-PF netdev queues can belong to different DMA devoces.
+		 * Block this case.
+		 */
+		if (rxq_dma_dev && dma_dev && rxq_dma_dev != dma_dev) {
+			NL_SET_ERR_MSG(extack, "Can't bind to queues from different dma devices");
+			return NULL;
+		}
+
+		dma_dev = rxq_dma_dev;
+	}
+
+	return dma_dev;
+}
+
 int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct net_devmem_dmabuf_binding *binding;
@@ -962,7 +987,7 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
 	}
 	netdev_nl_read_rxq_bitmap(info, rxq_bitmap);
 
-	dma_dev = netdev_queue_get_dma_dev(netdev, 0);
+	dma_dev = netdev_nl_get_dma_dev(netdev, rxq_bitmap, info->extack);
 	binding = net_devmem_bind_dmabuf(netdev, dma_dev, DMA_FROM_DEVICE,
 					 dmabuf_fd, priv, info->extack);
 	if (IS_ERR(binding)) {
-- 
2.50.1


