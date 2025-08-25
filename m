Return-Path: <netdev+bounces-216393-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 480AEB33681
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 08:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0FDF189F390
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 06:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D20283FC9;
	Mon, 25 Aug 2025 06:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Xpg8D3YD"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1B527FD46;
	Mon, 25 Aug 2025 06:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756103866; cv=fail; b=FYzYHfD6mJFWMVjmswhvAqBDdtaXbo/6zmJ/wIyIfXCxkut1rUV5L2SeOQaxh0Motvcq2XvnpW1yrtqbzBrBrxuF0TZGNcyHYN9OIQ7tQk08u3lNM7eVVLHZoRWNC8EOPZPPtlq8SWKPRiV1y7pwnuh/t/lDF6Ye4vmuqCgUrdw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756103866; c=relaxed/simple;
	bh=AdKKn2odcy3ApXM3sMkzF+kfk6q+NaN0W4Azrk00X3o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r6ZGqj9gM3Kp7UldfmEhQSmRHUUk0VlVOT4QC35+dapAcpXRiRsu4XZreWPbkZ4JTAwvbWjC4E9gkZ3zGwPZaJgyGZCIiwzYvglgkTtbb/z/+a7/BMv3p2HHzS13uWUATGIzNgypqJ7OmQCrvmUesAPequ2CuApQYCwCA6ELCqY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Xpg8D3YD; arc=fail smtp.client-ip=40.107.244.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QlMgHkUhHHNckJKGN47D6MGU+svNJpFMSBfr2/wHBjdAegeJh/dy4e7ytLubm4oE+mFLVOeHrhzwRPNyvqpxkGWSbF7lHheFks3zEQ/az68x4RD5VniT3Zhx6lU2+VLcq2D8O6lA2gR7S1E/4iBwcSvtdPF6qVYqcAN3h1tAXGGJbE9GBNcLaKuVbD98IK+8yxnDU3uf83UpFfXVPfAOC+9jMrbYqB+7UAfZNnsxja/xO20qYMy1QXVeslHIKj/oA+RS01CQrQOuMUnPBPxC+FlQoTvOXeB+TdlkFPDwEVPtHc//ZhkA7eNhMVwXSMThZgJtBB7IoY4UbHkrmUcE2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NZ0bzHPW8qFefmHpfEKawVmyKeS0zkeBMs5NXNzME+Y=;
 b=lTfF1HkA5gdcTBB1LtVUH0QTz7882L/KYAN/uthlEdavqoTTC2d/6AxSzpYR+I+5ce5MWB5cLVGvJC25Y8tvya1LjuUkwTyIxDi6Y9hCLpwIn72PbC6eCwtln9L7o2FaDYVibwo4J0JgYHhDFFnlA4+5aKOkGvZlhNGoJuTgfr3EQ+zUlnlDSATQaJMIsQkPCACFBTbVsYB/sKwF22AaxgdV0I0QJpviuTlFOFb1Q++YGgmUI4eLGHzLK2xlvDBCargKqVyU3yX2yRiXWz/aYt4bP1yBygKthdy2g+0pyC4GBFfd+Sin2u+sLz4cIYXw66GhNkslDEG5SAFjAzsvTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NZ0bzHPW8qFefmHpfEKawVmyKeS0zkeBMs5NXNzME+Y=;
 b=Xpg8D3YD5tdWOMsb/Nq5abBq1KO/OMuI9seHgdf0hSwy1q4OGY4pwrBXfiouapCQVyFHGGONshPxoK6CF5JxiHziwSpopur0+IoS8pRFAM/oN64Zn4aFp5cZLTrt4Knn+ZnqLN/KtdOx1nirj2KiW5FMvvAw2EQqw+EyO29cKmFKaFAJnsi1pQCe38adBg8r+IEK11JqSk1CDVcRFNhcLbm+DZK6pqYlqlvmYkrMKQ7l/4C2DcYRPQQ7hFirM68QanFZkNvxYJ6LJ+Pu1XrWyuIreA1QYp5r6A93LDwyOhSHivHPpgwfgtry3ZFfUAA+WXaUYckxJL9lbjaWv6c7+A==
Received: from BY3PR05CA0059.namprd05.prod.outlook.com (2603:10b6:a03:39b::34)
 by DS0PR12MB6389.namprd12.prod.outlook.com (2603:10b6:8:cf::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.21; Mon, 25 Aug 2025 06:37:41 +0000
Received: from SJ5PEPF00000206.namprd05.prod.outlook.com
 (2603:10b6:a03:39b:cafe::df) by BY3PR05CA0059.outlook.office365.com
 (2603:10b6:a03:39b::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.13 via Frontend Transport; Mon,
 25 Aug 2025 06:37:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF00000206.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.11 via Frontend Transport; Mon, 25 Aug 2025 06:37:40 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 24 Aug
 2025 23:37:22 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 24 Aug
 2025 23:37:22 -0700
Received: from f42.dev-l-178 (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Sun, 24
 Aug 2025 23:37:18 -0700
From: Dragos Tatulea <dtatulea@nvidia.com>
To: <almasrymina@google.com>, <asml.silence@gmail.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>
CC: Dragos Tatulea <dtatulea@nvidia.com>, <cratiu@nvidia.com>,
	<parav@nvidia.com>, <netdev@vger.kernel.org>, <sdf@meta.com>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v5 1/7] queue_api: add support for fetching per queue DMA dev
Date: Mon, 25 Aug 2025 09:36:33 +0300
Message-ID: <20250825063655.583454-2-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250825063655.583454-1-dtatulea@nvidia.com>
References: <20250825063655.583454-1-dtatulea@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000206:EE_|DS0PR12MB6389:EE_
X-MS-Office365-Filtering-Correlation-Id: d6b34f3a-cb0b-46a5-5130-08dde3a1e3bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qScKwfF/QPsBkUNkhc48qR6cjAV4pF0nCLSAqfoUu9bq2FphR5q8OkmbtyX9?=
 =?us-ascii?Q?0m5vJB60jsWtFGISoykT54Wh+wAQhHKq8CwMMfrQaVXQbWs70AJqUbxvPIZ2?=
 =?us-ascii?Q?Tru20kk1xCtQUkkcYbaMvk25maOjL+/h4jJbK+2ji1WHLoIXQlrreXHvNyyK?=
 =?us-ascii?Q?y630wD+AuwDqUokyIINcA4wAoUPbE8AJ/lsNoaVe0KUj7qHfKViQTtgukmHD?=
 =?us-ascii?Q?cIG4a2GKC54i8Dlq9dBv1PyaKlnsYtwzHX9m1S0PMBfFMYJEFmIMkJbRCTQS?=
 =?us-ascii?Q?kAUKPzmNAtrUKkfg5tXBIzCG7t0XjLWleojAt+J9YeMaLg2ZHVr0c7Xk/ceW?=
 =?us-ascii?Q?DL7EVI+P7z03+wSX76zOKJGDqfL+cC5QTzyi2qcU3yvPVP2Nam/aObF1oEAT?=
 =?us-ascii?Q?jo3RKQuAh0P/bm2KcpBkrCaPulZSkPiBfv9I2hKJUBSZUGe9nhcxHcRUZT6a?=
 =?us-ascii?Q?a0Cl1UtinlHfddPLnJns0Av4aMcmQOhrwvr/bWssa3JYey+7W8h4DqbPtCpW?=
 =?us-ascii?Q?hZ1bV6GB6Zeu1ZK44qoIQv6kOu7RvdOLiaZhqwuaDQmJK8vXxIg8BSYZ0mwG?=
 =?us-ascii?Q?JYohNt2Cfn655HEdDs2ZRoT2oOSIzKBUWhcSdtFO/WLksOrFiAXavIjfc0gQ?=
 =?us-ascii?Q?DQl88j+ZsryppAhZHq8RwwpNenMWXs7IQIlxA2AMzTRM2gR/aiErA6jRpYk9?=
 =?us-ascii?Q?zTnNJdXaxUZbugyyj86IlhADQefdOra5nAWTMzFlYo3lTg9iAr0wmjkuwcZO?=
 =?us-ascii?Q?SqDdyuaT5Oe93f1gQkZI41cpytKIIgjv/8zMAjPdXkEKgD8Xa553p+7ctQLd?=
 =?us-ascii?Q?+RChS+qNYBueWQZFgSnw3rLUUPLAi74BzejqCdprWW5OPoyDGg+LeRBwuiq3?=
 =?us-ascii?Q?aGk/rU55W258jJ3cDiIqcWiz1Gy7zohrkEXADyCsTZaQKZSdMDu+I6mlRhQn?=
 =?us-ascii?Q?KufUmLT9vraNz93zgJ5uvLeoL3eK7vlqmaj2oxu3dCpfxpqfpSL4QV/7iQXs?=
 =?us-ascii?Q?5e3oGfSuzdJYWn8nN0xd2776IhhfCWoIuDkNpIy2exoLg1csUpaFW0kDRnuP?=
 =?us-ascii?Q?jGwtWeJ8mzTLQGYpnh1K81OY5/p4ISdF0vm0/3MoJNC1S406jSQIbtWJX1DX?=
 =?us-ascii?Q?9JwjxLxfuKRT/lequmtf5DXORS6MCFOmVBV5+VkzpQ27QiN01lrAX7rIzY+P?=
 =?us-ascii?Q?e/L+LYrNjhjH3bav6DZqTC4vcwy7V0AK7wToq6pH1FnaYKJx8txfZW9i9NOt?=
 =?us-ascii?Q?qPy0lzQedZreBZERvGsgBpAU8VtpD4D/0jRFpMUtsApc/ax40pLsPkNjwH7w?=
 =?us-ascii?Q?QYI1WPWimBYE2bWWkZaNSqlpetk2h7GNJP/PMDCmA1VyvGqSlY1ICIU+xHLc?=
 =?us-ascii?Q?ghA1RS9erq279Sulxmr9k2kdeDnbar62QHUSsE7h00lxNXUv0W7CIahM4KM8?=
 =?us-ascii?Q?m9K2Nxe6q/CgLXiXHRiHxvETZC/5k2I5EHk3pE6DiqGRp3x41IE/SsLrTUr9?=
 =?us-ascii?Q?4ROcCB8X0pTpEY+vspveyVCVjMIMN4NatJY/?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 06:37:40.5712
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6b34f3a-cb0b-46a5-5130-08dde3a1e3bd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF00000206.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6389

For zerocopy (io_uring, devmem), there is an assumption that the
parent device can do DMA. However that is not always the case:
- Scalable Function netdevs [1] have the DMA device in the grandparent.
- For Multi-PF netdevs [2] queues can be associated to different DMA
devices.

This patch introduces the a queue based interface for allowing drivers
to expose a different DMA device for zerocopy.

[1] Documentation/networking/device_drivers/ethernet/mellanox/mlx5/switchdev.rst
[2] Documentation/networking/multi-pf-netdev.rst

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>
Reviewed-by: Mina Almasry <almasrymina@google.com>
---
 include/net/netdev_queues.h |  7 +++++++
 net/core/Makefile           |  1 +
 net/core/netdev_queues.c    | 27 +++++++++++++++++++++++++++
 3 files changed, 35 insertions(+)
 create mode 100644 net/core/netdev_queues.c

diff --git a/include/net/netdev_queues.h b/include/net/netdev_queues.h
index 6e835972abd1..b9d02bc65c97 100644
--- a/include/net/netdev_queues.h
+++ b/include/net/netdev_queues.h
@@ -127,6 +127,9 @@ void netdev_stat_queue_sum(struct net_device *netdev,
  * @ndo_queue_stop:	Stop the RX queue at the specified index. The stopped
  *			queue's memory is written at the specified address.
  *
+ * @ndo_queue_get_dma_dev: Get dma device for zero-copy operations to be used
+ *			   for this queue. Return NULL on error.
+ *
  * Note that @ndo_queue_mem_alloc and @ndo_queue_mem_free may be called while
  * the interface is closed. @ndo_queue_start and @ndo_queue_stop will only
  * be called for an interface which is open.
@@ -144,6 +147,8 @@ struct netdev_queue_mgmt_ops {
 	int			(*ndo_queue_stop)(struct net_device *dev,
 						  void *per_queue_mem,
 						  int idx);
+	struct device *		(*ndo_queue_get_dma_dev)(struct net_device *dev,
+							 int idx);
 };
 
 /**
@@ -321,4 +326,6 @@ static inline void netif_subqueue_sent(const struct net_device *dev,
 					 get_desc, start_thrs);		\
 	})
 
+struct device *netdev_queue_get_dma_dev(struct net_device *dev, int idx);
+
 #endif
diff --git a/net/core/Makefile b/net/core/Makefile
index b2a76ce33932..9ef2099c5426 100644
--- a/net/core/Makefile
+++ b/net/core/Makefile
@@ -20,6 +20,7 @@ obj-$(CONFIG_NETDEV_ADDR_LIST_TEST) += dev_addr_lists_test.o
 obj-y += net-sysfs.o
 obj-y += hotdata.o
 obj-y += netdev_rx_queue.o
+obj-y += netdev_queues.o
 obj-$(CONFIG_PAGE_POOL) += page_pool.o page_pool_user.o
 obj-$(CONFIG_PROC_FS) += net-procfs.o
 obj-$(CONFIG_NET_PKTGEN) += pktgen.o
diff --git a/net/core/netdev_queues.c b/net/core/netdev_queues.c
new file mode 100644
index 000000000000..251f27a8307f
--- /dev/null
+++ b/net/core/netdev_queues.c
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <net/netdev_queues.h>
+
+/**
+ * netdev_queue_get_dma_dev() - get dma device for zero-copy operations
+ * @dev:	net_device
+ * @idx:	queue index
+ *
+ * Get dma device for zero-copy operations to be used for this queue.
+ * When such device is not available or valid, the function will return NULL.
+ *
+ * Return: Device or NULL on error
+ */
+struct device *netdev_queue_get_dma_dev(struct net_device *dev, int idx)
+{
+	const struct netdev_queue_mgmt_ops *queue_ops = dev->queue_mgmt_ops;
+	struct device *dma_dev;
+
+	if (queue_ops && queue_ops->ndo_queue_get_dma_dev)
+		dma_dev = queue_ops->ndo_queue_get_dma_dev(dev, idx);
+	else
+		dma_dev = dev->dev.parent;
+
+	return dma_dev && dma_dev->dma_mask ? dma_dev : NULL;
+}
+
-- 
2.50.1


