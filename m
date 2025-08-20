Return-Path: <netdev+bounces-215343-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F061CB2E32E
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 19:16:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 861BB1BC005E
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 17:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69424335BD0;
	Wed, 20 Aug 2025 17:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IczsnGyV"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2078.outbound.protection.outlook.com [40.107.93.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1CF335BCC;
	Wed, 20 Aug 2025 17:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755710039; cv=fail; b=etvFIMcOAwdnrf+Jq0HTzuH5iseBxHCkVeO6vlQrSRVYIfTMncTNm8gSddxOBO4MQd+89AUNFfjG0Q/8d2hOyx89M/5WXQRE9LCi5shJ58XjbYC+m8H2nq/ZThZDsnmoxmw1eBLUBtqei2XbgBI3Ej3hZYBwty4roqGD3Wq/LNg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755710039; c=relaxed/simple;
	bh=Fxr7Zw/DWx/bRcc3KoQDcPCTNbuY8uWkzq+VctCTe2o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eYt7OmSjibzSTkIprpO1JwzZRVkcOPkQ6dz8yEmrddz+7oQbNYohI2m4+9TJdFjkh81GuLW9DVl1I5Pfab97TFQpmYUkIkKrYqqWEOhcMxC7+AjBLOGXsSGbdRtsCaipZiie2WZ5ECanlUuugBYimmVEop5vVIo8LG7LX7TBPNE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IczsnGyV; arc=fail smtp.client-ip=40.107.93.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YxVIPdbO/LSDaphIm64dKLefbxYGOQnoJi9HG/0dq1O/V6pP8UHfsj88feGT/OigpTvGuFTglQ0MQn8mEnqasUfmeZA8yv2ALZY3omEpX/ZgMJP2FbQTHFuWdC/p34w04U8T6nnEDxRzo+QcblejrkMPVtQ1XM4TceVE71uIqRxxXz5YYrNxnUMWu194vYikpE+bzB132kQniQcWrqzrr+el0SuF0OtiSxqo6CoIQnShQrrc8pXdGdTEj5dQqWqaCStlUxR4P+pbdmMoL3qakg/vCMvhEu0Nbdlbe+fKyHeoHM8NNNilfxzlSz8q9rucUDXmo54Udg19BxetX9gZBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LC5GjTER5n57gx2ci0OtZxTS6uLrshHKNTW+WWhldbQ=;
 b=KFkny1GDmWRtyBDSqjAHO++MmtfoXykY7LLkPTsA3L0LWnnLd1gK5iuglsbAFvqrmqpRBLmxE75878m8k31Gqhseow0wTCKbqc9q3YnXQa2BYzeZu9e7qC2/MvqRyZ1myq0QQnlwqDZJ5t2Qh2S89MLOy+My1ZBIklh36DoukFzTzGzHXO7Ff9Y+t9XDBQSzV41Fv1Z1RFRl5gP+aZIps5gDj0Bf+oxsvDKVyikqVSR4EZcU99ogYwEMWJMC1aTQfUkyn3y1ILKvij2I/hsUkcFKwsG/z2iQZC/RyJRZ7EUbQ+Q379I2pJI5l6pnPufpQHEvOyWb5aUZBjxmpnYPtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LC5GjTER5n57gx2ci0OtZxTS6uLrshHKNTW+WWhldbQ=;
 b=IczsnGyV9lFghpMn3Z0+ppszO74M6oD2pNDCJj/RkDnDS4dVfgwcJkb90Je9jJcrpSRgL7Mui+aTgfq2EffgX7YdC5lqLChkA10y7ZAyILktQ2FKjILegaTp61AwJcva6KWvpK/XmNkn+c2KVy4lDDA9xVuyWs2sUOXZilvYz9UPnCpEwbrmsJNNY4zY79RQJ24OuA2jp/Nuf7lOWNuTrwzD5tpwqQSZdpGXhtgv5JGJrWailW1ow5td+JBMME5o1uMZI18Nb1xSyDN14+gBZLh1m77+Fdfo39m639NdYDR7SwX0ir4nFrftZJB5+h6MjQ90NuJb+LvMOLeGKsFRNw==
Received: from CH2PR07CA0018.namprd07.prod.outlook.com (2603:10b6:610:20::31)
 by SA1PR12MB9248.namprd12.prod.outlook.com (2603:10b6:806:3a3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Wed, 20 Aug
 2025 17:13:52 +0000
Received: from CH1PEPF0000AD7A.namprd04.prod.outlook.com
 (2603:10b6:610:20:cafe::fa) by CH2PR07CA0018.outlook.office365.com
 (2603:10b6:610:20::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.14 via Frontend Transport; Wed,
 20 Aug 2025 17:13:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000AD7A.mail.protection.outlook.com (10.167.244.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.8 via Frontend Transport; Wed, 20 Aug 2025 17:13:51 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 20 Aug
 2025 10:13:26 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 20 Aug
 2025 10:13:26 -0700
Received: from f42.dev-l-178 (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Wed, 20
 Aug 2025 10:13:23 -0700
From: Dragos Tatulea <dtatulea@nvidia.com>
To: <almasrymina@google.com>, <asml.silence@gmail.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>
CC: Dragos Tatulea <dtatulea@nvidia.com>, <cratiu@nvidia.com>,
	<parav@nvidia.com>, <netdev@vger.kernel.org>, <sdf@meta.com>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v4 5/7] net: devmem: pull out dma_dev out of net_devmem_bind_dmabuf
Date: Wed, 20 Aug 2025 20:11:56 +0300
Message-ID: <20250820171214.3597901-7-dtatulea@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7A:EE_|SA1PR12MB9248:EE_
X-MS-Office365-Filtering-Correlation-Id: f7b0adbe-5592-494e-1b9f-08dde00cef65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?l3sWEGQCFZw0JPRh9ulGKZyz5DtVhbgGj+4L6esX+OncyTfrcnTiKEinh06t?=
 =?us-ascii?Q?O/T/w1ItKkXStHx6CZ8Osc2M4m4E0/wrRQpfY56QXzur8CBaelEn5QHBr4w5?=
 =?us-ascii?Q?tJb4nUc1jPGmq7v3KpI1B5kEyLs219SKwr3cdFdj1ho2zM77Aoz0YxhZAsKs?=
 =?us-ascii?Q?Uahaz8d7D+oyKfigau0lblxfux+Yw6P1coaR4IZ600qoJJpUejo0JNlZ/pPj?=
 =?us-ascii?Q?D84VO4ktRmqHD4MTSKIcnVZ2tn2z5z4zbH6Lk+nSKHy6Ujoug8bu0s2SmIi6?=
 =?us-ascii?Q?OtmyXMFm9R1kil3hl0RXTBUufK0AhRW2274NCCoxbikgBXZGBzTjYcnNfxkH?=
 =?us-ascii?Q?BuwxsdjZrknt81HR/fIlLvdYT6ZqK3JbKJHYkLFCXX9wlaLco1OJ/qfLNYnh?=
 =?us-ascii?Q?OMoVCqcuGLpxoEJNZKY96kwJQq08hO8HmnZCC+vsTY2rEq/mUANQe275YT6d?=
 =?us-ascii?Q?DOcXn3BvvgeP9Kql+hOKh9AvUN3Xok3PQgNf1L349oIhIEXa0SVZHGBdtkxY?=
 =?us-ascii?Q?sDbuH2cl+2VWHmMBE2O9JkUnl0gOqpkMi0LjUAER7kqfuw5QtC/I1Avwk25o?=
 =?us-ascii?Q?YVGiphY87t93LH+C3bK+dTkQNhPpQkWOVhyLWgcgmuGJxu6yPjiNJOJMEh25?=
 =?us-ascii?Q?BwoLEasTHa7t9dv4Bg4w1Oy0tq7yaH1gq1bi4eu0U2GRIFkvPzj6SSfgkmlG?=
 =?us-ascii?Q?2j3IY6JY1G9aiLQXbLssPGFUXGJSDVYtKJNf3HbmNCxCX/nXKq1E84X1tMwV?=
 =?us-ascii?Q?oCBo2f9va0w5CXDMUqxSdXXrlwHYAq3NqsWAQ5U/ZsUOKH5nGygI0Jao1DDn?=
 =?us-ascii?Q?i/aYrftmN1kmk0j3s+Uzvq7KbLH2GDteinDLAIrsPksoJnSPD9U1oUzqS+NU?=
 =?us-ascii?Q?0v+tawjRZYEZqLU36vJ3S4S3VhTh4zecCKpgAby6bwFSP4Z0sIRziCvkjkp0?=
 =?us-ascii?Q?6CtcYtkzRi/O32L8jahd0i8+qHcAs6a8lI0IaZtdEz2KDjmSo0HdreCmriFx?=
 =?us-ascii?Q?76ItfIO5cQ4eAOFuqOeHljNfqVK14ccic9REzspuFcGKgB60NptjgA4McDV1?=
 =?us-ascii?Q?u/EN9G9koS9C0cxtThsRA/qYYPQ9IddSN44h3d1fInxfKd1WETnS+xlvv43m?=
 =?us-ascii?Q?Evyw3WfrAfZ7grW+QPr2XJ6l/Yq/+cpvTQEbmGlZ49yLBg+pcnE7L/3jFfgU?=
 =?us-ascii?Q?qxf2/IW51jVVVn6+pWd83Ha6x7pbIJ1UbqArER5eCX0bQoHlHGQRFEzFwicw?=
 =?us-ascii?Q?I8sPTCHnkzY6PKqk4+ZpIwIIpChWpRNn03I/6vJ7fi2eE8n6LrybVQNqrsIA?=
 =?us-ascii?Q?MkMFMhbFa7/zV1ucbcx22CdUUbIk5WrBOulZ8NWCTlNYj3qtO/iX/Wo+cQ2K?=
 =?us-ascii?Q?1b7w1Z4d0+nfyh/Tcd6ijY7SDmG0guoCD/xnY+iwCbKUGEfATUX96WMGjZCP?=
 =?us-ascii?Q?H5S+Og5W4LF4CZGCXb+JnfVeafA1f2rMov4jlyqLwTjqTRehVqwDLIl20RmN?=
 =?us-ascii?Q?zIGJ0YThtM5BAWWMk9vNo2b9z/Uytdowp7XD?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 17:13:51.5403
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7b0adbe-5592-494e-1b9f-08dde00cef65
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD7A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9248

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
index d66cb0a63bd6..c7ca16c9fc04 100644
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
 		NL_SET_ERR_MSG(extack, "Device doesn't support dma");
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


