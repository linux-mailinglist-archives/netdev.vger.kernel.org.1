Return-Path: <netdev+bounces-214035-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7521BB27ED0
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 13:07:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFC3B1CE6735
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 11:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1EBD2FFDF5;
	Fri, 15 Aug 2025 11:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="U/jHzxpG"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2051.outbound.protection.outlook.com [40.107.93.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D14B2FF651;
	Fri, 15 Aug 2025 11:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755256027; cv=fail; b=FZa3zi6+BtkZxd2A2Vsg57vAfkuyTRqlaEravGnAfK2Pddmb7mBxWEqKM79SWi23JHhO+sXT23PKH1cYniiC6bEbjkCtA4+qhW68YFP1Om0/RXGEkbNyjOdPRdptsQpgPS3+upS6w02jLSfZjGn0eGqm2NlsJiTQZAXNG4TeUUU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755256027; c=relaxed/simple;
	bh=MmZESp/RcUBEK3u4ChY5kF3/JbGzmabvaCzeL4YDrGY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uv55fKrJZgs8tRyiJrk+N6tJdy/dxuM0AOE9SikAZtWCCVtMOi++4aTE3LltZppgowQmzJLUxknGQC/PxXXBz5hHj+wEkOBb034PxpFoi31n1uZFm35ly0kIsZDPB+HMhETs3hVMZ5xcY4dNjmzGbFC/sbr869c18e5x8+lKDCE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=U/jHzxpG; arc=fail smtp.client-ip=40.107.93.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mIRWC/sO4HnSxXM0IOBYSKLSY3J1+VRlpJXDW7YBs5vmbFmhloTQ8WSEsgxzKeuIHp9oTT7OZ4M8WytRcR9AUyuIqP4jnA7zwUVYWoZ9HREApM9SECicQ1K0D1YVJE0b/RVQN/gT4CFWr6yEWIeogPggvIfaRGkdn2c+KNK4fhkSwnZWp7LE025/PT+OCC6rjzVUr2fwEESBgKGpWmg9bwgbuRdIMMbXOMj7etBN5XZ3dNxrVwHMog+Xjjg21YyB4RK9Eq8CPPhbHoX46YaFmXS+igQCr3M+58w/cm+tIx+L6FrlHKpTe3zFYMlGgW7uux1dEpinB89ISLB82CqdNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h7gsU9cgiDLHrCIXbM+/1MmtirK45v+1+Y/LmunbBLk=;
 b=iBwIaTURJY0xgf6yGx49EZEWXHCEOe+lHRYGb5XeTLO5tItRKVMV6WB7Iw0NErdYAnJysnFMGdcaQv+zRWiDg1faAAG4MzE7EEIFCGeuJIWkyMXl809RDrdpj6UV3UzmMCavWEdN9wks7WePzySzM5Csz8kBTxZRwfX2XgJtwQyemAvWUHrXxAG2d70xtERFrz+Nvvbpm5jBB88qr59GqPBxWfukc7nsmj3iRkXgnbfDubvVndzwrw5w3YKyK9GzPWa0cCwxDUKS+fccdFIQBy35tFHFJ7L10LmQ88/bj9uupmv9w0gvlEsB8RXn6aRdgqqjns2+MrmWcy62k4t6hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h7gsU9cgiDLHrCIXbM+/1MmtirK45v+1+Y/LmunbBLk=;
 b=U/jHzxpGejDTjY4L5txABhAXy/YRSvbXUn0h/M8iraw0NudDgOS9d+/yJifqNX6/Q/ppcy75GSSJ98ovE61fxx7PYAtQCWJVl+CozmQS+ke9eBAavB7NVFEjQsHDWaQctIhcYq6e49Tf8BLiUXYSF6Eo+0KpY8HLQZjT54OFHyNmBw2kc9f4keCeey23MUdPZUrYxcXMWTRPfJJ3cWwuGwrq82BekCHpi1hEn6iX0DUFi8mX5Mq4FdCD+R1M441s5Lk3P4pGynRGCPm6w1OqSDQ/Xmc7yB7W0Mltb/zRDBAzmosKmDlyCK1Jhb5YiV0ou6wZT2BrPYT2bH8vhEVJkg==
Received: from MN2PR02CA0018.namprd02.prod.outlook.com (2603:10b6:208:fc::31)
 by DM6PR12MB4283.namprd12.prod.outlook.com (2603:10b6:5:211::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.17; Fri, 15 Aug
 2025 11:07:01 +0000
Received: from BN3PEPF0000B06F.namprd21.prod.outlook.com
 (2603:10b6:208:fc:cafe::ec) by MN2PR02CA0018.outlook.office365.com
 (2603:10b6:208:fc::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.19 via Frontend Transport; Fri,
 15 Aug 2025 11:07:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF0000B06F.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.0 via Frontend Transport; Fri, 15 Aug 2025 11:07:00 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 15 Aug
 2025 04:06:47 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 15 Aug
 2025 04:06:47 -0700
Received: from f42.dev-l-178 (10.127.8.9) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Fri, 15
 Aug 2025 04:06:44 -0700
From: Dragos Tatulea <dtatulea@nvidia.com>
To: <almasrymina@google.com>, <asml.silence@gmail.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>
CC: Dragos Tatulea <dtatulea@nvidia.com>, <cratiu@nvidia.com>,
	<tariqt@nvidia.com>, <parav@nvidia.com>, Christoph Hellwig
	<hch@infradead.org>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC net-next v3 1/7] queue_api: add support for fetching per queue DMA dev
Date: Fri, 15 Aug 2025 14:03:42 +0300
Message-ID: <20250815110401.2254214-3-dtatulea@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06F:EE_|DM6PR12MB4283:EE_
X-MS-Office365-Filtering-Correlation-Id: 526f68f2-114c-4a1f-d41c-08dddbebdc04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iC1fuNCAaAXrwOAP/jm3MTaD58MgL+sNZsrjV1fC8zZXqMMCCopSKm9YLheu?=
 =?us-ascii?Q?7y9q1lEY4kkftsixAsbWTMvepZ/WIWm7WF0oIt2IHc3NLJZPvdpGd7rovyjo?=
 =?us-ascii?Q?JTKeofUvIJvGRw8+4YdYzAsW7CMw4I4dTw/B5V0ILLgzyvYtI91q+vU91p2X?=
 =?us-ascii?Q?Ll+Y7k6/wHihitH2dq6tmf/ppFol3h/f7zBTTKbml+baGfoCDyYZ1oTkoz3O?=
 =?us-ascii?Q?aOlo+D9NhzrrSvM5e38+GyOB8llbmGERp2iUVwFSMLdi9VNlBJqxtYu12SYG?=
 =?us-ascii?Q?kUCfmZ7Sn7OTtUMyGnwICrynOLGfmqXvvxgry12CuEBUIlqH15+OeSNK4Gte?=
 =?us-ascii?Q?0GgiHMtxUgaGRmZNMDBiVq9Uwgy3mZOrisgOua4mc9zcK8vTyTYKgmrg87LY?=
 =?us-ascii?Q?vlraeXZwEMqsUmI9mUnQ4HbqkhlOOcyD7scHMT/Y3GHx7yDYoEPiY/47NDJV?=
 =?us-ascii?Q?66I+jNp1rtmnuRNR9lfze84h2Zt4pulRcqWwC6bR2RvH79z5TcYPqtWlwO8c?=
 =?us-ascii?Q?meYLeG0OrEB4yT/k+uAFv+c8/cTs1ptpPghfDzAFz6KdqvDAoda7LoSFMVwG?=
 =?us-ascii?Q?SrWgCXxoMJtsBGDWFvMjScl8gOzpRFyZFRqlsSIshshphBrENnRkuPBn6gKD?=
 =?us-ascii?Q?gDwj1ykZFGGMAeU/Ct/PLMspb8D5Du/RQWzE3qsqLhaFMtFZ0wqunn/aWFOC?=
 =?us-ascii?Q?FkaCMXOeXiL5pHHNOJViSrVavf0ScYmYY3LS5eXFSKSiPdQ05wKj/bR2tamn?=
 =?us-ascii?Q?pRpBpFoCfc/EcOTro6x1M+iYG5cyDWSGVZqeCgeiXoEfjW/rMiTAb0Eo2c8W?=
 =?us-ascii?Q?0Fel4oiIwrZ8+B/CiDQNpRVYpvQ6lX0yNzsCxZeRZANZZ2N8ZgCumYhcj/4M?=
 =?us-ascii?Q?EUjxdEyTHlDaCGb9tCRgFHJ4HjE/2KpnFPsa61TgmhSWsQ+BvIiuijfCaI2L?=
 =?us-ascii?Q?e4jn6CvhV9DK6CASyDgPixCsHfNQQeopeO/px5sq/5rWsah2feYtfR7Q7VNT?=
 =?us-ascii?Q?J0QDqX/L2PmR2LyogCslMI3nMULYSavEdvYpDjEAVi+r9dILOZpOAcz1PG/F?=
 =?us-ascii?Q?iqM1G/lFVjCCXxSlKE+2Brbff7GrWJwA1UpTBHKN/qikVBlX5BMw0+LLKUvh?=
 =?us-ascii?Q?UeQ+eakP62h3pOrl6xxq0dVk7ldgAodHGkqrRE+1WbCC57AaMHJukrnTPBuv?=
 =?us-ascii?Q?x8JOMeEmmzjoMSR1O2PgirALj1pDW9Xe3qD7uDrouxv6ubVJzENMh5u5XbU5?=
 =?us-ascii?Q?SpKM7QV9sEQAv2nXpR7O8og8FRM1wZxOpp73nRkjV9jDWgxG3X/tdNxt+Tqb?=
 =?us-ascii?Q?whLdixiNV8AvKmbKXqOikMjuUNG2EQxYKqbgMYnNZIfllAVlMjj4MJfm+qB2?=
 =?us-ascii?Q?Zc4/TKXxG7SpCPac81YCMFe14qxsebu+Q8nWGyZe+UBwy4uRgXaOURQwWZ/p?=
 =?us-ascii?Q?xh+kSE/ZfBoyZW2bLIdz0HFvuEO1PTGR5edjXvzFpP13oz8L3sED++Vk6THa?=
 =?us-ascii?Q?EDstYFOSXH+3cKml3QT20HcLxop40eQrlmtJ?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 11:07:00.9806
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 526f68f2-114c-4a1f-d41c-08dddbebdc04
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4283

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
---
 include/net/netdev_queues.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/net/netdev_queues.h b/include/net/netdev_queues.h
index 6e835972abd1..d4d8c42b809f 100644
--- a/include/net/netdev_queues.h
+++ b/include/net/netdev_queues.h
@@ -127,6 +127,10 @@ void netdev_stat_queue_sum(struct net_device *netdev,
  * @ndo_queue_stop:	Stop the RX queue at the specified index. The stopped
  *			queue's memory is written at the specified address.
  *
+ * @ndo_queue_get_dma_dev: Get dma device for zero-copy operations to be used
+ *			   for this queue. When such device is not available,
+ *			   the function will return NULL.
+ *
  * Note that @ndo_queue_mem_alloc and @ndo_queue_mem_free may be called while
  * the interface is closed. @ndo_queue_start and @ndo_queue_stop will only
  * be called for an interface which is open.
@@ -144,6 +148,8 @@ struct netdev_queue_mgmt_ops {
 	int			(*ndo_queue_stop)(struct net_device *dev,
 						  void *per_queue_mem,
 						  int idx);
+	struct device *		(*ndo_queue_get_dma_dev)(struct net_device *dev,
+							 int idx);
 };
 
 /**
@@ -321,4 +327,18 @@ static inline void netif_subqueue_sent(const struct net_device *dev,
 					 get_desc, start_thrs);		\
 	})
 
+static inline struct device *
+netdev_queue_get_dma_dev(struct net_device *dev, int idx)
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
 #endif
-- 
2.50.1


