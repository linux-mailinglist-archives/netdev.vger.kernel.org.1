Return-Path: <netdev+bounces-215340-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1203B2E31F
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 19:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15DB6A225EB
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 17:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 378DB335BAF;
	Wed, 20 Aug 2025 17:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="k5kR6ueh"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6723036CE0D;
	Wed, 20 Aug 2025 17:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755710023; cv=fail; b=q9j3QuAy0HqMM+6hsLCiaViPW95rPke5jmdD9vZM/43WFyHCndvP8V1B6ijPzTYSGb87LvFwT4+fGGhbo/00ClM5cL9apEWXaCCYdN0FXsWGkkXW6TrrEQZXYU3pyaG6kqsPTwQs4t6KBj/hdIoylDoGzXsXNEvop/pqtr5gC0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755710023; c=relaxed/simple;
	bh=X3rlwdY63OjhafJsFgv7KemiFF6XGmtRg9Gi4XuoGVM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HB599yNMKF9hCtC+pB1PXQ+cuVfbu+PMMmLaFthMtC8Tcx0AjovzekLDSUZ1h00FH3EyDstR05ZByHY5KtV2FPndVHtD/zakysnGOP+fBZdLU3wY5qrwPkHxGz6R+fQw9q6Tzh3c6trTZnWZ/vFJxZptphlMyC8nWbOHKghphWw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=k5kR6ueh; arc=fail smtp.client-ip=40.107.244.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zSqea8HYE6lUY74IvLD9DuqOiSzMjVBtegkpN8FruOCM2nHj2R2HFiWXYsAC+1Sqj7ZjLq002dwqL47BH5xT4ktcX+rSBo708q0GU7VktK709DhUNRcVTJArh54g1NMHssxV3p+wLuySU8cfknLyxhL9lLHh9XAKWJo5UOAoXBWMPprUE+ma6vG9IPVwz2rHQlhFuPg2+4TWEhUfXHsdAHdyiMGaFgyrsy+Awge/0OOgYZYx18HFkbkWP2FnEEZm44z741wHRopMWascSicXNgVYHsdQte/Kx9slHjrD21JBM70cZAwG+6oks/sR2arRlEDFZbtIpMnG36slOD7xSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mMAKwQQe7aeUM5vMKIlq5gVFPKUGoWFgW28L17vsy0s=;
 b=k15BPmjNMihv7/qCpihUyzQ5YmDfkcjJnm9Zuhbpy+fR1hLyTEswGp15B+3fa21m6ELqdDPIpiqz33+V7c9h0bSlS0v2nizS4NhHCYQTSqyyqoe9ogN2sJrZW7QuYfMCk0bVqUr+qaV8cORhaj163j0RlGY6oKvgS+8+678bNxtYYU5cS8J+O9bVM8er/gH/UsJYnBfeYgSaTfbJEKDH68mrTrOKC1NOGYNMlIaYNQy6MrqwAL93ixNg+QzzMBv0ugKGO4OwjGyaq/5r2ML6AW0ESUL06fTAq4CvLyNRduqpM5UyyACJPPykeHX+WgWc6wcsDFahvqewHUEwKrGynQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mMAKwQQe7aeUM5vMKIlq5gVFPKUGoWFgW28L17vsy0s=;
 b=k5kR6uehDl5EDC1+3BEnZX83uSMhtH7TK85/hhf++1A8QbvtkjWS9nM6JHw4WnnsHv0wVwlmV2nGDt9l2uGC8680SKZFOaJ1S+pQxZfDherl7fAzVxB633ReQMqPpSH8T7cdMFa1i5qHoVXtNQwqyaIrfSHl5SeMWHUhnLnwLtK0GwZpufoDJI6Aq0hZfJf75vNJzaJLSGMs1X2Z2ti8WV9c4/OIs2jmzE25DlBNvo52BFEE2jmhJlMRrQS7VRV10eSSxa5dKDtpWy/XinAUo/n2lYJALdOIDYOLL6Qn3vO3cFka29rUdgOnGTIfWsLZJIVjwaHVL/k76myW3HHi2g==
Received: from BN9PR03CA0163.namprd03.prod.outlook.com (2603:10b6:408:f4::18)
 by MN0PR12MB5713.namprd12.prod.outlook.com (2603:10b6:208:370::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Wed, 20 Aug
 2025 17:13:35 +0000
Received: from BN1PEPF00004682.namprd03.prod.outlook.com
 (2603:10b6:408:f4:cafe::fd) by BN9PR03CA0163.outlook.office365.com
 (2603:10b6:408:f4::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.14 via Frontend Transport; Wed,
 20 Aug 2025 17:13:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00004682.mail.protection.outlook.com (10.167.243.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.8 via Frontend Transport; Wed, 20 Aug 2025 17:13:34 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 20 Aug
 2025 10:13:04 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 20 Aug
 2025 10:13:04 -0700
Received: from f42.dev-l-178 (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Wed, 20
 Aug 2025 10:13:00 -0700
From: Dragos Tatulea <dtatulea@nvidia.com>
To: <almasrymina@google.com>, <asml.silence@gmail.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>
CC: Dragos Tatulea <dtatulea@nvidia.com>, <cratiu@nvidia.com>,
	<parav@nvidia.com>, <netdev@vger.kernel.org>, <sdf@meta.com>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v4 1/7] queue_api: add support for fetching per queue DMA dev
Date: Wed, 20 Aug 2025 20:11:52 +0300
Message-ID: <20250820171214.3597901-3-dtatulea@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250820171214.3597901-1-dtatulea@nvidia.com>
References: <20250820171214.3597901-1-dtatulea@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004682:EE_|MN0PR12MB5713:EE_
X-MS-Office365-Filtering-Correlation-Id: d3eae18e-1b5e-4f09-cbdf-08dde00ce57c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Thww8DabO2jiGZ2uQXJrcIriaNb3gFT5EMwkwk54UC+6D/CxkvtEcsKa/aG7?=
 =?us-ascii?Q?/ZiaP/lcOACyNPlLdrV8OO/ZucyWIuvUd67CygBu/HZK6gzKB/5TLD6nXgii?=
 =?us-ascii?Q?fp7FxRDrPABw4bpQKT0C/momrd1723JBR9JkU8h32nLKgfZSpAuG4tUu1z+N?=
 =?us-ascii?Q?IAGFiHnXDVzmAZSblWlXyR4YinMjI+I+2vXtQEEN2YDg7mj0CD8JXdIij5Qw?=
 =?us-ascii?Q?6y4ccgqpuonFq3lhL8H3wpzaL6sg0P+HEJW8B5zUkLeJCllgzCCDQWXvL693?=
 =?us-ascii?Q?Gkc9bFgCSGXFH6gaAE71js9brTbbkiK5uHsq3XxzwMlagF54qwQ8mR8QDpGa?=
 =?us-ascii?Q?I0OtOzkrt2Ao59rkEEHRueLx/HR22G6T/ASIPIOVIA9yUCCsxCE93WxbkWJ6?=
 =?us-ascii?Q?XsycO+llKMnz2wy8dKWcXMcqFEf3LEmrMpTuzU5I4yYubKaNsUpJUBsNH0rF?=
 =?us-ascii?Q?RGo4ZprjIvTj134iUJhYnXvwoYMvpRmzzF8Z3h/AatkJFb5zQDJa0mjM+fir?=
 =?us-ascii?Q?8jJ76jw3S6u18Pd2JwPG5ZUKU0Y3xDG2vJKnOpEvX2ZTMLgaRkq28Dq9GwWC?=
 =?us-ascii?Q?P5UryeGG4gXB0HgCseZc33YIURUTCUbwoe+C5vqkdziBvmGttoqWX9kTZmOJ?=
 =?us-ascii?Q?7xoRg7vnTa6shDdUOSEV89L39ZGiPSkjfUTOkEmVgKqoBJe3PdXRChPdclL4?=
 =?us-ascii?Q?PKdKY1KsBldVnBr2YhVTw6a/wYmxt5Pu3A1/EPQ7CCnmSpxNDlxAlsxTef3a?=
 =?us-ascii?Q?iqgvgQugax2XgpKJGfwrQvBF84Etl4QuogD1qcrwOMZ/z7QJEMhHP4X02Dzt?=
 =?us-ascii?Q?h+gyeqp87O9g9iW63pvSX874B8Upq0feFOKBRK2cbsF6iu59Om2yZW2aAbk6?=
 =?us-ascii?Q?GnUcTjJGYezNDUGRTwNqr5ZOIF7V/6cSpec/Jn+VlcozVfMM/4AB2By4UQmM?=
 =?us-ascii?Q?ZR/8Nt8nNf/p2jxNdkT0gMg//0O/m+dpst6VNCYw/E7AUdT9op5E1ghPXn2S?=
 =?us-ascii?Q?EFL6M3BPXFxlTTl5Y6cyBgdroHjE748fmY4CpsLZ/wZcWlH0YxO4426s8yPK?=
 =?us-ascii?Q?/H45hOIJyIVygIS8KMETfiuzR0eEp5KbNHXl3RxvTLeuUq2nQjwwO/npvB9G?=
 =?us-ascii?Q?xeL9SevWUKK8oN+EmWNAQw7c2O6Gie1fVwcipkjeSxLbQwTpLBfJh4BpU8er?=
 =?us-ascii?Q?p7i+KIDYrrM7anXyf5iJAWrLglkOKuuGr/cJYNI1hYsY7nSvUdl23bYP8WNr?=
 =?us-ascii?Q?GC2n7Wt2hdjSmNRrSZPkd9q8C5cNLoKG+7xgwgx2tYLO0K1j8L1U0HNzZiC4?=
 =?us-ascii?Q?wmkIG285Hv9baWxZM4o9Sx8e3LaRPG+xlBT0zi+0j54SuN5oMqKelRZAmARJ?=
 =?us-ascii?Q?44iBtRCC6Y9P1AgrIQMrG3WO8DeUVFswgda8L8lNu2pbazTMJ3XBAMHefr/b?=
 =?us-ascii?Q?5+1nKH1xaMeH4CMjc3wc9bq9FxjnWreH6m1Bws8C9/pA9jwM6b3mSW+zGnL6?=
 =?us-ascii?Q?SFHqX2S2vO/COR3jaL4ITYGMp+KygGZ5TQyA?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 17:13:34.3845
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3eae18e-1b5e-4f09-cbdf-08dde00ce57c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004682.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5713

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
---
 include/net/netdev_queues.h |  8 ++++++++
 net/core/Makefile           |  1 +
 net/core/netdev_queues.c    | 25 +++++++++++++++++++++++++
 3 files changed, 34 insertions(+)
 create mode 100644 net/core/netdev_queues.c

diff --git a/include/net/netdev_queues.h b/include/net/netdev_queues.h
index 6e835972abd1..f648de4ca03e 100644
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
@@ -321,4 +327,6 @@ static inline void netif_subqueue_sent(const struct net_device *dev,
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
index 000000000000..d00f071e0edf
--- /dev/null
+++ b/net/core/netdev_queues.c
@@ -0,0 +1,25 @@
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
+EXPORT_SYMBOL(netdev_queue_get_dma_dev);
\ No newline at end of file
-- 
2.50.1


