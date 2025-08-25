Return-Path: <netdev+bounces-216396-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08401B33687
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 08:38:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6F0C481BCE
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 06:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3AC5283FEF;
	Mon, 25 Aug 2025 06:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nc19T6xx"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD011283FEE;
	Mon, 25 Aug 2025 06:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756103884; cv=fail; b=AFKA+kn6YmCBZiMNV06CzNB9QhpHIs+Nn8BG0KV9O5UKNhdqDVZPNWxRj0e5J1MHvXoV+/KntNRgv83N3RK65lNLOUS6qaeiHNHfJb46GzmchiAItKWIl4UUTI9+R6uDIYv2zKz8vjpQ2q6yExb19AyDBjm9Zloz63oHPEfYFf0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756103884; c=relaxed/simple;
	bh=h13I/zFV/ot2FGZMKCV7eg5GPg2gVbqcZYpUkmWWKf0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IMD5lraabSW7PdiNmczfbPKIufgx4vlHTMPY+azFSzRoiyV7g+WPRgvTzZBqOHKYqA30hOQci83oCpHKT57S8d6U08eojLrvp0CDw6VBLCx6+i8NLelG9/UvVetorq5WOq996imwNeg4khCaIC3id4UjPY9pFstKHdMBW1/gqzw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nc19T6xx; arc=fail smtp.client-ip=40.107.237.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G1gA+UpHNhRdjzgxd5kR3Jp7C33KfZ0n7h+cGpY0SeMK4LacuDMs4hi/SM37nSMeunjRyi9BC3r4gYTzbgCDFy3phbkN5VaLoYjfxW7BBQHJ4oh5mwU1S//k46Eu7tcgN5kYKJiDr7nh9xI77yZq0aG4q7zpCUWEyOYM2u5SZdzZLoarWdl716NrcqtSGe2PTUIp/v057Jt1KIEwsZn06Nkt/O0Qz6RcLk/jVLjNOboY0O0YWf8DB71vD60BY2x3DNWmkVsaFxC7vpJDGn8Ud2IUoSLsou8vUTPcOdZ7cd9h8tpMW7XnfjfR63+uU/CgbOAKNjOEY7TEGDDi2sFPlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XI37HeyH5tw7Kd5GqTzN98po6dxBPCNeIBtxtLYfvGk=;
 b=B1s8VCZodYH9its4L8uLMW6wIQtOaPayeDefm35nUfJazqlwzWUjpF3tNQRlSDrk9ZYTU90dX1pgq53PJ8eAbumEF1EGP6ggc7d2pC/0KHflCiAdfMI92omFoWrJjoar660NhxELvdPgxp1euEi231hftn7IL5vGaMpMV79NGYp7qgPApEp7mnR6HuN4cPac62X0Sw95V7NpTsF2mriWfugA9e9hZ1eDwMND9GbhJIUC64aNyguIFP2kbFqDV2cJ188ceKvzQqcANP7aeTr8tkWFKj4pASgnwm5HrDic8/+Q7m0WX4v1jUiz+pzSqknUpWxZIVjMtcUV9VjgdKrvbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XI37HeyH5tw7Kd5GqTzN98po6dxBPCNeIBtxtLYfvGk=;
 b=nc19T6xx2vlkJkCMECQy15hwu6mCYo/ye1y8Rz9b6XtYOoMWQVUn6N9fpAdA1X5Y15h8pFRM1Dz4W3HU8hTGIgledqeqloMBtcSb1kqMkXg5ca+kn2EDBeD2YZ4tdWHlkoCEIR2gZNUswLykz82Zufv2ydmzvEPnKb+NThB26jW30m03/LbXvehHliorpTjRm6rkpyEt9c/bs/utHkj9KbbFZjWS0uZhzoYJXuQuc82lbN3fGcnrOHbh7lqRc218LzqKzoV3f3Fz5Q/niY/lgFqCIgDgs33tuBk4DllxYJ+4tJ17rviW4JlXR4kw1iZTD+ZWeJbqmqm532lDOm++dg==
Received: from MW4PR03CA0257.namprd03.prod.outlook.com (2603:10b6:303:b4::22)
 by LV8PR12MB9408.namprd12.prod.outlook.com (2603:10b6:408:208::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Mon, 25 Aug
 2025 06:37:59 +0000
Received: from SJ5PEPF000001CC.namprd05.prod.outlook.com
 (2603:10b6:303:b4:cafe::af) by MW4PR03CA0257.outlook.office365.com
 (2603:10b6:303:b4::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.20 via Frontend Transport; Mon,
 25 Aug 2025 06:37:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001CC.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.11 via Frontend Transport; Mon, 25 Aug 2025 06:37:58 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 24 Aug
 2025 23:37:44 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 24 Aug
 2025 23:37:43 -0700
Received: from f42.dev-l-178 (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Sun, 24
 Aug 2025 23:37:40 -0700
From: Dragos Tatulea <dtatulea@nvidia.com>
To: <almasrymina@google.com>, <asml.silence@gmail.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>
CC: Dragos Tatulea <dtatulea@nvidia.com>, <cratiu@nvidia.com>,
	<parav@nvidia.com>, <netdev@vger.kernel.org>, <sdf@meta.com>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v5 5/7] net: devmem: pull out dma_dev out of net_devmem_bind_dmabuf
Date: Mon, 25 Aug 2025 09:36:37 +0300
Message-ID: <20250825063655.583454-6-dtatulea@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CC:EE_|LV8PR12MB9408:EE_
X-MS-Office365-Filtering-Correlation-Id: 81580f43-3f27-4da9-bfa1-08dde3a1ee4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rfy2NgIFUyHoTIRfSUTQbq0E1twQE5maMLc16A3N56smY13knT6bNTnv0IP7?=
 =?us-ascii?Q?YAWD7ypgI0pUvZm9HzJhd7/psL/e0aopIykYxyrNmb00bDqtEh8K6MjUg5qg?=
 =?us-ascii?Q?bOcCcNPFbgflTM9pjuZi+y1X61NOS0mHDtyHNWLW1vF6xh8CtEj+TYufP/OH?=
 =?us-ascii?Q?V5Ja8mrrahujZi9JWHqJKQjtp+dTxahq+OQHf3e8hX75tZ4gzqIOdwfajs3W?=
 =?us-ascii?Q?0OTKun/9W/K0VR2HPD/Uo529LH+j9r7pMEL3EJzLetVD8q6t+3TNQSGJN42u?=
 =?us-ascii?Q?A3H6Q6T9LoBAxCTnwEhg01qjvXzrYT7Jx2HkIQBusuck+5YmUetV51559SMA?=
 =?us-ascii?Q?IBSbvrFgFqdyENhIfX/pWdJiKL44UOd6ByuqfW7xX+qljCPS7fPTW+FEhdzs?=
 =?us-ascii?Q?Q7SQaAPwUnMGtGiQRpT16LDXdBbDVvvSGIHRLnJS42f9thY3ZdU5987+wPEm?=
 =?us-ascii?Q?7YZTMCFSDk72gepk1YaQGU6tV63XGj9AWmmZ2Ud+ixPEXbfGO8oHMHyz+0Oh?=
 =?us-ascii?Q?KA4rSpkBYGMDYMs70eGOrh4hcUVY2i8hMnBGqlI1P/DdIuIFKYtIMl0BO+qF?=
 =?us-ascii?Q?iltD6Al9WR8ZttUn4dqApFev+m23XKKHmMXgWSxZuCPOAHDTUUd1zftCBYD3?=
 =?us-ascii?Q?5W9OFYr2wpXwqXyoyMXOJTh9b5OHmaPgVeK+veRNa0QLfFuenmZ6xteG9gtq?=
 =?us-ascii?Q?GQC7v8xkvMf6c7dep0FTDBBUZLE3Qsu7Rr/uqI5QUrNULgg92rJNWKFNrUJD?=
 =?us-ascii?Q?x3Scih7zj8SQA82U40Fzx2Usery+ca2XwoDL/qKK964eQbbBCmnBHVRelFPy?=
 =?us-ascii?Q?4K33zXKkX077J7OsVrfTd479qAeWDnWOb+ZSKlMQ8PjijHQNSOtckCPrycRD?=
 =?us-ascii?Q?nBPNlEDWv4oqfOSMtFnglW4pcToTgYdBgfCCJ1GWLrBSowj1YqVzbsmeWvCU?=
 =?us-ascii?Q?4P55+JisxK3El8coD9hjt/1DLcGGmCJKz/mIeL/bLbkSnqtjbM78XOwndwlV?=
 =?us-ascii?Q?0zKe+UdsBNuQOVyEDXxHe2d0Rn0CGWbPT++ntFw6+QLhEUZ9xRdsW4Sap1zl?=
 =?us-ascii?Q?ziUuA1kfCRydRgGRPOt4bS8STHY3rDGc1Y5GIDo5DPZjwYe42q2g0o4Oa5Mn?=
 =?us-ascii?Q?wlXmppT9YupxdBNg71jdwPp70e4B+04R1ykskLMQSB29Xtro1yvVrnOai+e2?=
 =?us-ascii?Q?3HPte2FWj0eTFmD8YgEmQ12VXegfHQmltdpa3jx7S1fBt0ZWNMe144TQma5V?=
 =?us-ascii?Q?m9HE1fobcWPdH4jYcOyuhhSVyQQyeqG6+xt4rZAVYgdipMcKugVzrIF3RIDa?=
 =?us-ascii?Q?BNk+N9SXoE9OdwGg5udV24I37huY4yq9H7JrfHAvWZmZj6iFGVnZErTwf+Sd?=
 =?us-ascii?Q?I3LJKyihDSYTZQnP4MT7FfEFvsSQpzlLdtIBoVo7kCLbRz8pBR52BnXn27WU?=
 =?us-ascii?Q?xFFRXKk0o7tiBdAIqLe7ubzANrk1Z+fv75YF+OXwvDWRTXRwOsiKc4geqCg2?=
 =?us-ascii?Q?pazG+276hCWZhvG7K9uGwDMEH0+jwMF+eiYv?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 06:37:58.2413
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81580f43-3f27-4da9-bfa1-08dde3a1ee4d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9408

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


