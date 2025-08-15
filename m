Return-Path: <netdev+bounces-214038-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F29B27EDC
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 13:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1CA9AA3C51
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 11:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F0092FD7D1;
	Fri, 15 Aug 2025 11:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LgZzdWyM"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2054.outbound.protection.outlook.com [40.107.223.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9232A2F7461;
	Fri, 15 Aug 2025 11:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755256048; cv=fail; b=Eu9s/EZY8uIKJHWKb/c7BXNtjr06rWT406ByblaubT3dssa7riMmOO6jEfoPhv6Mbi9VDYNYXE5gXkbwKrUa+iv5q5lrzc/rAvsQXHikQ7ANB5I/sCEqHm5y1o9eKEQp3QoKWA0YzDUUS1K6udOvRSOb2D3126DpXcLoupasp/I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755256048; c=relaxed/simple;
	bh=P1gTmVJtjA7yANqS+cFN59OaanOX84cr+5fG1eI0ErQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hfIioz0/0yAcL7FjhIddIAxH6sDCJRmt5Y+xVRUqJnfggsyyJWCOctSxPYtfwZoTJaxPzPs1FBhowM8k3eT6fHigIdW9fXUqNLR4urNbp6xXSsFS8V8HrtLSPx5VYWpq4L3UHBnFgFlh0EyFdeJ06mnDk+Vi3J3OuTmVboLAgO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LgZzdWyM; arc=fail smtp.client-ip=40.107.223.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w25U8DJWaLksKwWjky9xgQFam7Dd5ezdCUW9fX52R4JgRvAdaCzW9Ny7hql8bc1cm72ZS+ozZa4kdEDWnyRIf14JgZ7e/h0WY1Gmh2fPc65ZJkcobgm3sroHIwzT4SXM9rrYDQbInslV02uaZUwae4wgcJ5Iy46c2/BD6PkVv8+kxPxmyOrjf1dJtLxk8sKv59Bmm+nLu/RrXIyC1OfVjvtJH5/t/ttK39iSxUuDEhrJzosw2jNMorC24b8owOYmbQELLqBbij5RoETn7gA1VIHYr/CV3Pk7VKVpD9HvNb0EMJ0jTmJvy5XCCqVIsD2MPIWcVGvxAgqcLkdhZQscMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=55M6reHujLw13YzWHgCtkwgAC4v2MtLiwqgXE8G0+oc=;
 b=ROF5ihKsfRfXFJxJ7UCtya7Rn36Qn9JzMkd6TYhP1MDdsdJuVm6S0roFrnZJkpcUx1AlhJTdEZL37TuLRarciem8ior5E3UxOrwUtY7lvcBcYyW0B9FMrhRgzshdbIO11Evr6gJfRA6qUgrpsxW4/bnuZWxA7AV2QGZut+sb+cOXSaxt4VMLBTa7YeLe2vaabEiGc8jiP9JqYDA99D2zzEyTDJ9JsAPWGxQTAAo0SmrE9Tn1TZzFn3uk0aY68vH21x/3Em+01QJLgoodT2DSbJGX+SUbIyoLJl1HPmW2FHg/MmUUeuOEli/Cdce2mXX4+ZGlbM7PUeX/lrmQEVSW1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=55M6reHujLw13YzWHgCtkwgAC4v2MtLiwqgXE8G0+oc=;
 b=LgZzdWyM0/Kel8t2f8+G9RwRBr8WWgj6b2WO9TbSm8jRgrX5F/PoN3YZmikHg8TCIqsFGWQ83RyyFGoT8NBaEB8OimVWxkvpjZj+y3YxxjniXsQOS74qeJgeyamboNUK+/FtryhJR88tJIkWxDCuYCXShjEBRf6f85f0LzVPkt8Wwy6e+nlBD5znLEXgtVTrQocUjyvWMqyvI0MmJQR6n388suX1vHHa1jVUQfAgW7YT+4Wn2vQrd0J75Y1ITB7JlOhPSBnSSZN2m1Y7SgmyhBAXmmnMYsB31xPo7ieoXaI0sYr0dHUwTef2aQC4dboGtIvZ9h+8IcK5bQ/oMm1g5Q==
Received: from BN9PR03CA0624.namprd03.prod.outlook.com (2603:10b6:408:106::29)
 by BY5PR12MB4194.namprd12.prod.outlook.com (2603:10b6:a03:210::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.18; Fri, 15 Aug
 2025 11:07:20 +0000
Received: from BN3PEPF0000B06C.namprd21.prod.outlook.com
 (2603:10b6:408:106:cafe::6b) by BN9PR03CA0624.outlook.office365.com
 (2603:10b6:408:106::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.19 via Frontend Transport; Fri,
 15 Aug 2025 11:07:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF0000B06C.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.0 via Frontend Transport; Fri, 15 Aug 2025 11:07:18 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 15 Aug
 2025 04:07:06 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 15 Aug
 2025 04:07:06 -0700
Received: from f42.dev-l-178 (10.127.8.9) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Fri, 15
 Aug 2025 04:07:02 -0700
From: Dragos Tatulea <dtatulea@nvidia.com>
To: <almasrymina@google.com>, <asml.silence@gmail.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>
CC: Dragos Tatulea <dtatulea@nvidia.com>, <cratiu@nvidia.com>,
	<tariqt@nvidia.com>, <parav@nvidia.com>, Christoph Hellwig
	<hch@infradead.org>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC net-next v3 5/7] net: devmem: pull out dma_dev out of net_devmem_bind_dmabuf
Date: Fri, 15 Aug 2025 14:03:46 +0300
Message-ID: <20250815110401.2254214-7-dtatulea@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06C:EE_|BY5PR12MB4194:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e88e65f-8e93-403a-4eaf-08dddbebe6b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4Dwf3EJ5yxRmAZ44XZQurB9uFCweUvejjnEZGcKTYN8EN9OCaNX13Z5KSFAA?=
 =?us-ascii?Q?54oZA73svpqLho5qy/ipCF3syZfVZyKEteIeZ3wUB1BYx74jdOp0K/HSy4L3?=
 =?us-ascii?Q?OSfRxGYPsVin6VUPC6KV3I9T0JMR+GOk83oGbvP6hRN80Pc2bcUfBc+oiFb/?=
 =?us-ascii?Q?LBbwnirtSAnB0hJqNApa115pdHcwO+1RUuMT3kCAsWfOXq52kORT5xNEgmO/?=
 =?us-ascii?Q?uaLqX2MNXLlJLLiBbIYX4Uy/9t5aWy3v5oO+XtDzHbLiggoF9bpsaFwAHgG0?=
 =?us-ascii?Q?W3CzpPvPf9qIdaLEwM5NLohNBapqLkvHw/oqSgMnNTNLKJVS1mjFu+knYjyO?=
 =?us-ascii?Q?BL9SKf7C6eu16wSVicao7yIoMch859fH58U9grT/P8UdNmt8+Ja3inTY9Dkf?=
 =?us-ascii?Q?LaBfet3e9t5YJgwLlV29AUsQ5VjkTOmfkcWMvSXi8wAQStrvsQN3R17LKjfK?=
 =?us-ascii?Q?r8g8yIbl2wFRVlj+Vo4c4SQbqHNEz9SFSMPRmSMB2WO4DhFnXODBoY4c+tU6?=
 =?us-ascii?Q?zBqcMWnzwJtexv9dD+Ak3FiS/4/P9xxroJvi/zpAVQqtGJ45hFIw+7BlGpiD?=
 =?us-ascii?Q?KIyRe9PHF7jKWE+2Wu4xj+GcuISlTzyq8Svjs/WuAjzKxchAt5KO1e/V/wmA?=
 =?us-ascii?Q?06IdWeDqzoCpCccz4viRXptyCz7ihkWwSbXQhB7YVXrw00PeiO/nFCgoYV82?=
 =?us-ascii?Q?EJEKEOuftuAfLWpUksAUaa7htwmSEuMtBXXytd3w7TmeBCMqGm2FdBRlCxMi?=
 =?us-ascii?Q?9UFb1ZHAE9jwxnAjZd4tFyfnDSI7XJcM1GS+bwefq5Eu6TlDJ1x6Ym6nNFjx?=
 =?us-ascii?Q?c49ccR+aT24YlYtEwbVET4t+7v/4FQF3JTXxUtZdcjEeQMYgd5+oVCNTS68H?=
 =?us-ascii?Q?dmMiajl4blRMCxkjGItW3K3wvV7epYzJ3z05hOFjU0LgdTx2RZpHuMLxv6SR?=
 =?us-ascii?Q?M7odxYFaymeySBi6rha1GKn0H22tl4yzK5nuqKrXa/ADnQCiDBx1rPNaIdNf?=
 =?us-ascii?Q?K/u0ah4oEZbjCImBlfRwK7OHVh0Cwn6hdds/rtbCi5eT5uXk7T2CjTFFXnVe?=
 =?us-ascii?Q?zxnxVsXfbVW+p67qNLjiUFfxDCw3Q1IKwYVNOWOfQS4wYtmkpp197IJzL63l?=
 =?us-ascii?Q?QPL/WDj3Q7StugLyFePSVsL9YDa22oorxxAUMd5lRN79D1vEguDuA4+29uhn?=
 =?us-ascii?Q?5zHLilXuEHcXdbl6SJWbwBdhP3uNBOxGsMHiUWz7Aqh130yOKjJoJICbI99f?=
 =?us-ascii?Q?MRnMnFQ+LKEv/eQZPQaJOwPEv8F8kcDjylTpJJ32D5NXTwNNco9q6WKdjxiE?=
 =?us-ascii?Q?WHZQRGBQduYz73KYywRUKvdjviei1EONKAqgvF+NlYn2T1w9AcgX+eGoOHA2?=
 =?us-ascii?Q?y7Bxpkxz44JG8qWwVgka5znzVUJgevrEf860Qt8JSTYrdIUQg8i4YG/it1h8?=
 =?us-ascii?Q?lX12XtFM8TELbjXnaV3c2fMiwL03LKJQyLcA+ssS35lQeR4eGtuQaRpYCMyh?=
 =?us-ascii?Q?5ROtzV+3bsWU4Ad+IqBozBcAJUdMA1k3PPMb?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 11:07:18.8727
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e88e65f-8e93-403a-4eaf-08dddbebe6b0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06C.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4194

Fetch the DMA device before calling net_devmem_bind_dmabuf()
and pass it on as a parameter.

This is needed for an upcoming change which will read the
DMA device per queue.

This patch has no functional changes.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
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


