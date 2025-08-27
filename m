Return-Path: <netdev+bounces-217324-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4895BB38543
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 16:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29455464819
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 14:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D29F227EA7;
	Wed, 27 Aug 2025 14:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="k1J0sxl6"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2071.outbound.protection.outlook.com [40.107.93.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 717EA201033;
	Wed, 27 Aug 2025 14:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756305715; cv=fail; b=LgxVG+M2aULVyso+qdsI53uK1WhF/pGfHDo5RSwNE84FVF/MCt3wMA+0t42Bb41P/rfiHGzZdh/auidUP9k90lA+45uJzlDb8sa4TNmuyXJH+85Q05G7dpeBrU/UVxq3vPnZD98e5KhlxHx5MniOdMiov6KIPjlLMK4dTPdBskQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756305715; c=relaxed/simple;
	bh=h13I/zFV/ot2FGZMKCV7eg5GPg2gVbqcZYpUkmWWKf0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rRFDzkU6MA39hk27/CCtaSvHF8h+dGvFXzoy6wWRl09ARisEl2DuXSXLW2MMP4P48JRlANT3+alSoS6sphIYdZvwTKQruYa9lVRLt1ZuHo0O9+YLl2UpsA1aR+FrrlyImJy1RbvZ7b4Jr4tJLxTUXqx0HZ54waaXxtpSaNTYc+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=k1J0sxl6; arc=fail smtp.client-ip=40.107.93.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fyljpf7x+S1FC+rZVINuOL/tMlZDrLEY6YJTh/XRxG46HFYa0kw1q5aFkcyw2yI3T/T3okiRIiK4GguhoQ6pjrzRWRYgu2iuNGPCcTO6mGi1m1wsxE+pGoPXVtfY9UJTHSR9MFOetBSflJv1Wc0Zb4TrTjT14ppryqIYfRhMvIyuBvvFbJV8zFmRYK8nPeSU1lFuC6XlT+eHI4tc/XMMD+BD3Y5efb9esONSOtXxpB9K8dvR/+hJXzDXqQZSbPpKiLfyvBH26jxG6ixjuxtLoxYk+RlEQALOe6oraZHclBATz5Q22RRHL1h/yEGk5P7M4FhKpLW1qTehjCFPQfhKZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XI37HeyH5tw7Kd5GqTzN98po6dxBPCNeIBtxtLYfvGk=;
 b=j5INHr/jNHH3gExAb/B0pfg9ReSeIL7/g5YBcauYvkAF3hIvdIMlSElHQH5fuAq1JrpixBHnx/oeuiOBtAYBFqqmZoVq3ZPTHSmHAEyMNNgnkT6c7yo5kTYwDGwdaRQyzziti/S81YVdvOlIAlW/705ptGm7reD6csUt5cGpSLILjM4KGouZWQ0Q+tN+imIE/zP1UuE5CHLYisAp9H1Xe7sfQuGaSJpbyLFdyp1e6z6C83y5gj9HgZP+O3RITGGWMqhYmMOnt9ntPvzfl1xDpYeO7jUsvhnxHkTu2tjIrwEkj9xoPsayBtyce/AAaulN3Cg7s7cSe0H0cGk20jlyuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XI37HeyH5tw7Kd5GqTzN98po6dxBPCNeIBtxtLYfvGk=;
 b=k1J0sxl6vhRhb7H1mB0ccyt3KIH6uGnpqWr2yRsTrhyayxJ3WmtiTBDhe+vlvdNIRCPumk+hJRwHdigInD24aFmJGnv1DXeVK7vp+cer9+zMwvS263qohQT8xgRJ7aAgJeSbb0Uih4x/B+jmM+bjdxyYqtszaFCo+jO31q+eR6TO1SFed0CgfeMF60KHIyKqWOYDIPM6JBMzNIs0MFPO2SXHTefoZO7Bw/lH/Kw2S1MVk53rTu/mos2UKAI3RSGtu8aqi5rtMOSlmq6axiFKORxyvXXtoujxwU19wzWqw/F7KjDK717tnETkcEAUnvbne2iDdUaHRwSh1TqqXlM/0Q==
Received: from DS7PR05CA0029.namprd05.prod.outlook.com (2603:10b6:5:3b9::34)
 by SA1PR12MB8859.namprd12.prod.outlook.com (2603:10b6:806:37c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Wed, 27 Aug
 2025 14:41:50 +0000
Received: from CY4PEPF0000FCC5.namprd03.prod.outlook.com
 (2603:10b6:5:3b9:cafe::7a) by DS7PR05CA0029.outlook.office365.com
 (2603:10b6:5:3b9::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.13 via Frontend Transport; Wed,
 27 Aug 2025 14:41:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000FCC5.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.11 via Frontend Transport; Wed, 27 Aug 2025 14:41:50 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 27 Aug
 2025 07:41:19 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 27 Aug
 2025 07:41:18 -0700
Received: from f42.dev-l-178 (10.127.8.9) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Wed, 27
 Aug 2025 07:41:15 -0700
From: Dragos Tatulea <dtatulea@nvidia.com>
To: <almasrymina@google.com>, <asml.silence@gmail.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>
CC: Dragos Tatulea <dtatulea@nvidia.com>, <cratiu@nvidia.com>,
	<parav@nvidia.com>, <netdev@vger.kernel.org>, <sdf@meta.com>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v6 5/7] net: devmem: pull out dma_dev out of net_devmem_bind_dmabuf
Date: Wed, 27 Aug 2025 17:39:59 +0300
Message-ID: <20250827144017.1529208-7-dtatulea@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC5:EE_|SA1PR12MB8859:EE_
X-MS-Office365-Filtering-Correlation-Id: b6cc0b9e-0d6b-4af6-e983-08dde577dba4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QRocqnCw/oViUeLvSBnpAc0FLxlAv+sgQrzPYft8HBqXXFxz0eZxlaXFgvdq?=
 =?us-ascii?Q?ZxqT/0Od8fJ9K8iNlqRaTrkRGBS1LMQ2PnZASu1E3RH4s2bAdkycDk1RRQY+?=
 =?us-ascii?Q?7KhF028Ebej1Tv+Lh/VWCA7hJPDjoylhq1b546xrGUzFggQffDH/0sKKwBZj?=
 =?us-ascii?Q?AZoIKt0mBnjIMr1zwNLrBiJLroSbiCKYddzgEfNm8j7rKzfWV3/Gw4mgppmV?=
 =?us-ascii?Q?0AMv32678tV/SaQN8iwY0txa6v3xNGdStOTrvDdvx/uJtrWqzQ8Aiq/f9e9U?=
 =?us-ascii?Q?+XrMN/Ne2E+z3vkDEE7UdvkoPF+E4E2MfHnihlnFbmW2Kkk9IM5PsdXsZg/b?=
 =?us-ascii?Q?DpabdGAx8KTI/zRVv5pIiioGrvpGXb5jn0P69el88dPxtDf4/A5bF8UAtbQt?=
 =?us-ascii?Q?QQQDAr94n62gjpPIbfZ4+sXpmGcFFBF5YZ7h5K2SQQcM4QOjVH1V2geuNffu?=
 =?us-ascii?Q?GXrahnSs2mIvhQiWOQSFlvbiUD51j4UOocdg8zGKez8WgXTe1WhTPCulm+JN?=
 =?us-ascii?Q?JqMN1rvI9cdUR5UwtXNnJ0R3xrJlErAdhpWRWav5yLd9JFbM6HfyebhEOMPE?=
 =?us-ascii?Q?FqmD6g3vW3wH88fmHTIAWlrJjq4uhR2HvqKtQMOeOQMPGwEkg+/88QwhFjKj?=
 =?us-ascii?Q?LgKYHs1EgwvwYJpitfTx2NT+zX3j/dSbDrbUUjj++unMuwyyF0bJP/TelQvO?=
 =?us-ascii?Q?8/82at6DoCIT+TZ4HMUWQ2lnsQuXWX2toksOlIJr8R1ztN2UjDDmdJKjve2W?=
 =?us-ascii?Q?zvINhny/Ka3WnKUVsglxS/OE9raL4wZpPYr+f0NY5xm2W88nFV3+zwIfHQ3v?=
 =?us-ascii?Q?KyAWRTDF8AKPYcCtQVvPIothffqFoJJJqArhJhwzsM4dUCxq+2Yk6WF50SJG?=
 =?us-ascii?Q?4H9IbkhChikYMlxkTmQreULfcCVNewkutpu02VVcfQRnJfjnpDUMK4GqGcfh?=
 =?us-ascii?Q?NyHYlJbKWIHwf+vHugdWvCf77PWuLZACms+DY87Gx/5G/vNU5wGUmHWtfJy+?=
 =?us-ascii?Q?WPTEEEE7LbF56quCIsyTBHwSsbY3FF4XQyQ0QAJHPbmEV6vDCXZ55Lrb0aEn?=
 =?us-ascii?Q?UM65iDK4y36FbLxMqHUpbvlaCAUJ9+if2dIyUXGx/Cf1CzmXq0gtNKJ+HxDb?=
 =?us-ascii?Q?FQNUlOZ8VCzwFDf/afkVOSI9gQt8PeK9zE8miWkAeZqqVOwgwQMkiKf9Yumi?=
 =?us-ascii?Q?6ZUR/W8xe4W+UlkAgHrX5RLJ4sUdSiBrkTNqWYgB9PiSI96MFkm21leo20no?=
 =?us-ascii?Q?aVVVVinIO3ghZ8F7D6kyTvZVMKzj43jzhljB1eCR5foZss57kH7aynnDIv8W?=
 =?us-ascii?Q?K8BwZ5kUmGewMvEzUXfZYWaTO/uW5H1DVPjwTncUmDPLHb4kWeklIsHaQgVk?=
 =?us-ascii?Q?2G36UtZQGlja3tGuzsQcmv1f4mSCHsEPcRO2K44TqYHUaX5+Tg1sClhfeBc4?=
 =?us-ascii?Q?onx7oY49cIYLnPOav+4Naw03Ktp+6XW0rEnUSc02r+kNP+EC3/dyQ4YZ+zvN?=
 =?us-ascii?Q?ZREzNPZSh75qu8WlAxSMtqX8oOdAN7uGhsGk?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 14:41:50.4316
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6cc0b9e-0d6b-4af6-e983-08dde577dba4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8859

Fetch the DMA device before calling net_devmem_bind_dmabuf()
and pass it on as a parameter.

This is needed for an upcoming change which will read the
DMA device per queue.

This patch has no functional changes.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Mina Almasry <almasrymina@google.com>
---
 net/core/devmem.c      | 14 ++++++--------
 net/core/devmem.h      |  2 ++
 net/core/netdev-genl.c | 12 ++++++++----
 3 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/net/core/devmem.c b/net/core/devmem.c
index c58b24128727..d9de31a6cc7f 100644
--- a/net/core/devmem.c
+++ b/net/core/devmem.c
@@ -176,30 +176,28 @@ int net_devmem_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
 
 struct net_devmem_dmabuf_binding *
 net_devmem_bind_dmabuf(struct net_device *dev,
+		       struct device *dma_dev,
 		       enum dma_data_direction direction,
 		       unsigned int dmabuf_fd, struct netdev_nl_sock *priv,
 		       struct netlink_ext_ack *extack)
 {
 	struct net_devmem_dmabuf_binding *binding;
 	static u32 id_alloc_next;
-	struct device *dma_dev;
 	struct scatterlist *sg;
 	struct dma_buf *dmabuf;
 	unsigned int sg_idx, i;
 	unsigned long virtual;
 	int err;
 
-	dmabuf = dma_buf_get(dmabuf_fd);
-	if (IS_ERR(dmabuf))
-		return ERR_CAST(dmabuf);
-
-	dma_dev = netdev_queue_get_dma_dev(dev, 0);
 	if (!dma_dev) {
-		err = -EOPNOTSUPP;
 		NL_SET_ERR_MSG(extack, "Device doesn't support DMA");
-		goto err_put_dmabuf;
+		return ERR_PTR(-EOPNOTSUPP);
 	}
 
+	dmabuf = dma_buf_get(dmabuf_fd);
+	if (IS_ERR(dmabuf))
+		return ERR_CAST(dmabuf);
+
 	binding = kzalloc_node(sizeof(*binding), GFP_KERNEL,
 			       dev_to_node(&dev->dev));
 	if (!binding) {
diff --git a/net/core/devmem.h b/net/core/devmem.h
index 41cd6e1c9141..101150d761af 100644
--- a/net/core/devmem.h
+++ b/net/core/devmem.h
@@ -85,6 +85,7 @@ struct dmabuf_genpool_chunk_owner {
 void __net_devmem_dmabuf_binding_free(struct work_struct *wq);
 struct net_devmem_dmabuf_binding *
 net_devmem_bind_dmabuf(struct net_device *dev,
+		       struct device *dma_dev,
 		       enum dma_data_direction direction,
 		       unsigned int dmabuf_fd, struct netdev_nl_sock *priv,
 		       struct netlink_ext_ack *extack);
@@ -170,6 +171,7 @@ static inline void net_devmem_put_net_iov(struct net_iov *niov)
 
 static inline struct net_devmem_dmabuf_binding *
 net_devmem_bind_dmabuf(struct net_device *dev,
+		       struct device *dma_dev,
 		       enum dma_data_direction direction,
 		       unsigned int dmabuf_fd,
 		       struct netdev_nl_sock *priv,
diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 6314eb7bdf69..3e2d6aa6e060 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -876,6 +876,7 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
 	u32 ifindex, dmabuf_fd, rxq_idx;
 	struct netdev_nl_sock *priv;
 	struct net_device *netdev;
+	struct device *dma_dev;
 	struct sk_buff *rsp;
 	struct nlattr *attr;
 	int rem, err = 0;
@@ -921,8 +922,9 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
 		goto err_unlock;
 	}
 
-	binding = net_devmem_bind_dmabuf(netdev, DMA_FROM_DEVICE, dmabuf_fd,
-					 priv, info->extack);
+	dma_dev = netdev_queue_get_dma_dev(netdev, 0);
+	binding = net_devmem_bind_dmabuf(netdev, dma_dev, DMA_FROM_DEVICE,
+					 dmabuf_fd, priv, info->extack);
 	if (IS_ERR(binding)) {
 		err = PTR_ERR(binding);
 		goto err_unlock;
@@ -986,6 +988,7 @@ int netdev_nl_bind_tx_doit(struct sk_buff *skb, struct genl_info *info)
 	struct net_devmem_dmabuf_binding *binding;
 	struct netdev_nl_sock *priv;
 	struct net_device *netdev;
+	struct device *dma_dev;
 	u32 ifindex, dmabuf_fd;
 	struct sk_buff *rsp;
 	int err = 0;
@@ -1032,8 +1035,9 @@ int netdev_nl_bind_tx_doit(struct sk_buff *skb, struct genl_info *info)
 		goto err_unlock_netdev;
 	}
 
-	binding = net_devmem_bind_dmabuf(netdev, DMA_TO_DEVICE, dmabuf_fd, priv,
-					 info->extack);
+	dma_dev = netdev_queue_get_dma_dev(netdev, 0);
+	binding = net_devmem_bind_dmabuf(netdev, dma_dev, DMA_TO_DEVICE,
+					 dmabuf_fd, priv, info->extack);
 	if (IS_ERR(binding)) {
 		err = PTR_ERR(binding);
 		goto err_unlock_netdev;
-- 
2.50.1


