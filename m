Return-Path: <netdev+bounces-217320-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C9EB38537
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 16:42:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B8457C343C
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 14:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBDB721CC4D;
	Wed, 27 Aug 2025 14:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BzoKEIuZ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6A221C166;
	Wed, 27 Aug 2025 14:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756305704; cv=fail; b=ZSv8h/xj+CLGnQlYFV5faxq0vQOS/9ChM280hC8yqh8hoe8jDzpzGdVEkECLCxymS4tMkv8q0eKl97tKqNKXlnY4XzEn3ZQVoq+I52UEvsx171j6gPl3M7e1It1cUrAM0+s9oXzgH6ynREij4x3UWIjyPLgiLkp5WOhEk+NIbCo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756305704; c=relaxed/simple;
	bh=AdKKn2odcy3ApXM3sMkzF+kfk6q+NaN0W4Azrk00X3o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bgughcOoQQ+vQ5Bx0qVxAXr1MBaTYdim32sfEeo1VV9TqKcpHYuzvG8plZb2pyO3EzQivySo1SR44O4UsHQX+9PChjQjRaBrlVvdvQUZSZG87UgwQVexfUWxQySVO9FCnjfEVk8WqX/stLaRSPUMVEn6rvXJvmlShKHRWT4xh1U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BzoKEIuZ; arc=fail smtp.client-ip=40.107.220.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IQ4RsqmLdyFlDr/razWRbgkQNwV9CgdY8vNhCaYfOIEpSZpTQ3nbRJ+BWxMGKlD9/ykmq+9fC5qQIZk1bm3pm6np2nbBNi4TkE+YG4A+4Hq/9DznMy/11LeOseRrweDm1MgL+xyO4CL9UO0s2UZbnZajyVc5jl7xJhhdhzse0ACGPnWSihJn7sO/61BtfuYd/3hfhSjNJSD4MKbFqobuG1BAJi8Yxxh6xGiM5NleA2CL2HwpV+3XgYx3xYK/MmRoWN1iPCIqMsruPETFr2wBJRq7JYKdLdwUMTZg55fqQmv89vW6OKnoFAiG3NJ45pvi3z6mn2geXXhHHQ+kefQgvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NZ0bzHPW8qFefmHpfEKawVmyKeS0zkeBMs5NXNzME+Y=;
 b=wWaL444AtLA/L5f7y0GSlNRHycjkfBl0VtUnfXy+0N+y8azSjCrKDPzJOLh4bkigXkFTY49L0Tl5jdh31Mqh2U0SScgTzXGEYWHyLKo05J7xQ4Hi3KlJTpFwOoCT8kI4pWmMdYh8KbMnOZV8AVV4rZxvep8XTBS8piUnGwJ9p13oNiMDjz7W2rcZsPWUm9FmpQoSFc6cXdT2xC/YmSHAM/ShjPdVRPEQ1Cs//8yCanLO5GtYVf+O01Pnxri/9oD18FSk5qOot/5/H1vPRmY7g2teHzCUftI1ERZw/1uVijZx7LJBI1L2TL/p78lcgjVSFreZTpmr6JeKm96f1XxuxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NZ0bzHPW8qFefmHpfEKawVmyKeS0zkeBMs5NXNzME+Y=;
 b=BzoKEIuZJkAwdgokdpaOknmf9RBalK9Pj6fwqLa/CV+hqZ6rQSDjrUd1xTOcxZMWb+qTmsKJinNGEGOYacxN0x3GEbU7bd0CqbwcWhJhU5gGejAjG4neoz9QtPofcTkxTm+6sBFfJxlvMBEA2mp3A7VQMMSdmWOVp0nbSkjRABwxonfMWXKPXrLyg6gF6P6nPZgZjaEpq5SrLSOglfZH9KH9gjAtWCJoqzXFg3ZnjGY9Uh3Mmase3X+99uy3oYFOu05DAImojK2Svpkk4xqTwCOI4cNLMZajfVDESi1gsbu/j2ch4amZjFsuZhMvRRZykrg5/N/7BzV2w8zj5Agc5A==
Received: from BLAP220CA0004.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::9)
 by DS2PR12MB9662.namprd12.prod.outlook.com (2603:10b6:8:27d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Wed, 27 Aug
 2025 14:41:39 +0000
Received: from BN2PEPF000055DE.namprd21.prod.outlook.com
 (2603:10b6:208:32c:cafe::75) by BLAP220CA0004.outlook.office365.com
 (2603:10b6:208:32c::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.20 via Frontend Transport; Wed,
 27 Aug 2025 14:41:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000055DE.mail.protection.outlook.com (10.167.245.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.0 via Frontend Transport; Wed, 27 Aug 2025 14:41:37 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 27 Aug
 2025 07:41:00 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 27 Aug
 2025 07:41:00 -0700
Received: from f42.dev-l-178 (10.127.8.9) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Wed, 27
 Aug 2025 07:40:57 -0700
From: Dragos Tatulea <dtatulea@nvidia.com>
To: <almasrymina@google.com>, <asml.silence@gmail.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>
CC: Dragos Tatulea <dtatulea@nvidia.com>, <cratiu@nvidia.com>,
	<parav@nvidia.com>, <netdev@vger.kernel.org>, <sdf@meta.com>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v6 1/7] queue_api: add support for fetching per queue DMA dev
Date: Wed, 27 Aug 2025 17:39:55 +0300
Message-ID: <20250827144017.1529208-3-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250827144017.1529208-2-dtatulea@nvidia.com>
References: <20250827144017.1529208-2-dtatulea@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DE:EE_|DS2PR12MB9662:EE_
X-MS-Office365-Filtering-Correlation-Id: c65c023b-f91c-489d-1dfd-08dde577d45e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KeXftnqICOh5FzE0KifT6/9QF2UZtP14kzHlw0+v+KoOl5xFmX/5nHEmCEeF?=
 =?us-ascii?Q?7epwOCwu4FZAGuESG4+jgFPB0g6CiqEh6RYPAgjeUpcsSvXjatRkeqTg6MtT?=
 =?us-ascii?Q?Q9J5JLCAQk3ArSVm6vYyjB3Rsl/Pky6ggsEeSoMgmrtgNMscdU2NnswTCnky?=
 =?us-ascii?Q?OQlFD/aiAPd5QBknTHuPkLLZ73bVgPpR5sQUIb4SF2Cx46q2snR1gZP9SpbC?=
 =?us-ascii?Q?D6OvLzY6KKeQtMBAha1RqOdYJiToJuGUfW0NMXGBpxk9m2a7eu+3jwCwcMcP?=
 =?us-ascii?Q?Gyo499AagsSEc/6e6ra0O8uivmUvLypZ8qtcPJpqCTy1b429ehHm04jVqTRB?=
 =?us-ascii?Q?YBOXggcZIOoTLmmCzDLJe49BNTnliWiIkjMj8lfTnMKhrUc+QjEXGZWPntSZ?=
 =?us-ascii?Q?lwfpy8hP6yn76jE/1Hykag6DE5Ay1ss/+s3YmxhBJPgMpNUkhwtASRBkY166?=
 =?us-ascii?Q?iA+KAmYfktz015J2Zo/+z+Ofj+OYek0HpDyHEF0+PbCzBlquNYv8FwREin17?=
 =?us-ascii?Q?SrkJAH/Di9AGHTxEyFkptZXbVYK1bbpeY1wes0mpRb9YzyCCwsnPKHV1bjLl?=
 =?us-ascii?Q?fngJdeMb+Sq9gXeQc2CiZPIuctFzTv7UNowfdo28kk3t5joLpKxG9JU7EyEQ?=
 =?us-ascii?Q?RnQVq9cmaDR9FrfS86m5ztgdgU+F47seICLUSbqGf0VkXUTtk+uNgDGVbjGx?=
 =?us-ascii?Q?D6MdsmldLaxgyEpPQh8JBYTRfnpimy7nawgJ0m/eYlfVg3KtAxbkUQov/cUh?=
 =?us-ascii?Q?RPR0c6RMohvZ5hHE46zbkYo8DgoA7B//rrXpkxhK8GWJfKq5XmgXdF3D+Pm8?=
 =?us-ascii?Q?WaYZ+hC7hscf9vTkdDQfI2aOZLpmnPhABCWeSxj+9BYdKEIE5YN7sOL0dWKV?=
 =?us-ascii?Q?iJfCP2BwJ/scTViGaXSDpiocLn6QX3aI7hdxXc7jYV+56sQd2bnFTEchBDpL?=
 =?us-ascii?Q?e1V8psEobrV5HzvqTjTj1utbLPYf9ehhP79Jh9JX906X6OYMaPZB4GMkcwiC?=
 =?us-ascii?Q?LGoBOQWs/K4NZKgqxSiPbU+LUreUt6qr3rhQMFiKu7ssmIEuVYz5FRXHX7LY?=
 =?us-ascii?Q?XYJl5qcS5lu7lAKCEiFP+OI9yE3MK7+TGv+GRDR08jCZUX2pyB+EL5jgCweS?=
 =?us-ascii?Q?9n82sK6h8kMn0xFllYSz/8myeEtsvhxBcADv82MwPUskUCDbVxfYyA/MebH2?=
 =?us-ascii?Q?j+/Y9K+aYvDvNXL6uHnHOPXqyh19UWQoTt0X0DKwOuZzwrGyBIR26hLN0ty/?=
 =?us-ascii?Q?SE7pbUN6kSm0ezliL7i9cpF1mh5gxIXpwmHNOjqD5jpcm4LC5qg10IalgOpX?=
 =?us-ascii?Q?fDR8C6WPVDjdRsXdKw1DDStUGaSt0ueTE5XfuXJYZnXxpXQPCBoLDCPD6WJL?=
 =?us-ascii?Q?ShR91WunqndxgszsVT0jiXeqinewYT0K17XC45sOkBxcaaqrc9PlA7YGq+BT?=
 =?us-ascii?Q?vfLWzCL8upRPm3blmpBcmDerz2JH0lSyL/Wu1HVbvb31mQdHljCyOGLndlQ0?=
 =?us-ascii?Q?Xxzp8MVh6sNw4/HcBBC88FgwwR+HFIYAO/jl?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 14:41:37.9788
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c65c023b-f91c-489d-1dfd-08dde577d45e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DE.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9662

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


