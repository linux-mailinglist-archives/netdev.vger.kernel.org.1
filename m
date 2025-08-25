Return-Path: <netdev+bounces-216398-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 396E4B3368E
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 08:39:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3967B202A97
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 06:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567D6285053;
	Mon, 25 Aug 2025 06:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lK7RMLzR"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2081.outbound.protection.outlook.com [40.107.243.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D3DD257836;
	Mon, 25 Aug 2025 06:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756103894; cv=fail; b=FFQGHo87tyqRW0z0Pllcg8AfjTBHeNzRM7JDo8dIr0W5eEvno72rYy4N/5N6KyuBVlBWMtek4bsI3VqIxQZhIYi1kyE1xEAq6fBgQBP+HgFU2ZjFlXy6oJXIXVaXkULpA6bMbpy2e1fvusSzG4DyoL/DVQWpyK8sAvAQvDCffag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756103894; c=relaxed/simple;
	bh=hmjKZbfSY2uxMHwicacr80rm6FvWiBouLKo5IAocaHc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cEk3KoHBPXCN/w7xXAAhHOFWR0j243TKruYUODsEL5Q8WRtb9k2kRSVptXMEVRKzdubi+iy8SOdEU+d/4WWjUSGIlrlKQcktmjxrjLVex9uo534dqvjzViIBroZ0vvolKNH2XD5Wuf1QF66ZYTxWCyDw7F+oip9z8r5ufXVlsK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lK7RMLzR; arc=fail smtp.client-ip=40.107.243.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TVPHGu967k5rygA27zw9hn3jlPicNIRczr7AZXlGzXAX7AS5NwqHYoCxqJLRD0u7D0BI71zMLtf/igDW29eQUuyx2Ml6CQ1jpcgVY55uMSnTxDR1NN/KGKv5cmaw9QPrkUHEo0dA0yVKqA5yLpG0eok72nC5Ke4jFWYWh9Y464rIhuODJPnNLDNdTAdC0viDtQV2cPMNOyUozcI+GlhXC/gZkl74ghgMW5BXAw9SuBJwJR2m2eQeX2UlzViKMojgIdWX2B7vq9Qb8Kwf/jSBUvGSujS7kt5EEFR4QyspxfcXftG/2EN5qRzPdaWe35cwcC8wWP9+jqAHr7I0uK+7xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t9iM86A+KYrzcbcFISg3CgTp+dkVb08kCgbSsIzxxK8=;
 b=Cwb0p25wGieqKyosZXe06iKuhbkdtUs9Ch+mxHWPkSxz4KfUsdFZLppFdjm5iHYagSe0AGGeLK/jkyopwpIA27NxpC0tJfrr2rRNndpbW8DY2FgmumZcIOOAIUDX4diyoCUzl3s29y4fDSeyzbDKqVM6dtk7Ad+Agi0V8Y9IJHqs4GJfcy/fzOuTLGWjw60SyN40bz5Ls/2B2+vNI0TDhxCB/GzqZzi95wFVyTnzRHf+MmXTuBvRLbnFxHikqitqD80qou4DFLWpVhRm9AUHn3SckvnaH+UfE+eyZ+v64Ry1fTF4IWj2eu9vtWO1RHO9rW0TP33Fl7uWCPJehEG4Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t9iM86A+KYrzcbcFISg3CgTp+dkVb08kCgbSsIzxxK8=;
 b=lK7RMLzR1nfLred7H7AzX1KcFxLjVaz8Y1p5IzQuKRxYFpkIL9o50sd8ZbphcAUM58Bh4Ome99CrSCSqwFBlpBL81WRuB/6tIAj8Z3YFEZ//U8yC1Shos1B6yg7b7NG6WRI9M1SOXn+euc3qSr9SChNqGYMmYswURNf23DNWJwBN4S/UmwJuG5CE6DeTrrt9ci9w/w1v+HEU6uYslVkkvD1hwOwWeC0f8YX32EXMlJAtUanmgvUALPd4NXkrRCKWR684uC6WH0N3YEp+BT+Q3ohWcRIAaYoI83KyabC9p18csPbgMUkKX1eyNdDlrS26SJRcIIYQSHWQamwtc2QOOA==
Received: from MW4PR04CA0176.namprd04.prod.outlook.com (2603:10b6:303:85::31)
 by LV3PR12MB9440.namprd12.prod.outlook.com (2603:10b6:408:215::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Mon, 25 Aug
 2025 06:38:07 +0000
Received: from SJ5PEPF000001CD.namprd05.prod.outlook.com
 (2603:10b6:303:85:cafe::66) by MW4PR04CA0176.outlook.office365.com
 (2603:10b6:303:85::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.21 via Frontend Transport; Mon,
 25 Aug 2025 06:38:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001CD.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.11 via Frontend Transport; Mon, 25 Aug 2025 06:38:05 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 24 Aug
 2025 23:37:48 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 24 Aug
 2025 23:37:48 -0700
Received: from f42.dev-l-178 (10.127.8.9) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Sun, 24
 Aug 2025 23:37:44 -0700
From: Dragos Tatulea <dtatulea@nvidia.com>
To: <almasrymina@google.com>, <asml.silence@gmail.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>
CC: Dragos Tatulea <dtatulea@nvidia.com>, <cratiu@nvidia.com>,
	<parav@nvidia.com>, <netdev@vger.kernel.org>, <sdf@meta.com>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next v5 6/7] net: devmem: pre-read requested rx queues during bind
Date: Mon, 25 Aug 2025 09:36:38 +0300
Message-ID: <20250825063655.583454-7-dtatulea@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CD:EE_|LV3PR12MB9440:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f052ad3-24a4-41fe-d3bb-08dde3a1f2a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tZsszutqnfEmfV5w+7BOOkkkpEBqLHAjwH+kYmoMdxwl8/ljGo9E9rCY9SYz?=
 =?us-ascii?Q?Lq6oDn35QcyPU8NEVJpScdx4X0+1fTOiUoTYrrGl9PoSoGS1w7kydOZ3QLaU?=
 =?us-ascii?Q?HQIDrQskdPmUTZuFZytQv0B+ZybzRvVj0EETYG0bsslyigcxl3ABu+z3bB/g?=
 =?us-ascii?Q?DES7yUnzV5kF/4c0pmzxX9Yhz3UQPmELBh74EJpTtW2xZfYLrVG4QEEu2QRc?=
 =?us-ascii?Q?gEtYsDAQiom/OMKa+ZxJlOZM9BgmWkU0aBYEUXIHwDkuZK/pnejeL4FXvseg?=
 =?us-ascii?Q?SINE0wYohfSAgxysj+VMCOFtWUYGzdGqs4Fr9iqiBMITmUj2b10Voqepn+cc?=
 =?us-ascii?Q?7SLm745RhwzAy9GQnnlXWQfFZSvv3za/NvbsqKVZI6cg8FHV5Kx2v3D5SaiT?=
 =?us-ascii?Q?OBH78oxMBJAUa43rS2VtiacHfbtlRhevz/GNHR3n9E4esG0FJ0uBxShvjDah?=
 =?us-ascii?Q?xbY+ahdYuQVU9/t/e3Js9yOVc8H+OFKpGSZ6B5ogPVs9h4thBptVry2beK2Y?=
 =?us-ascii?Q?iJqfdRzUXJyWUS2CPtnaw+RepcE5UEU9sGyc4uHUw2SmbEvVFtkmAFw2ReC3?=
 =?us-ascii?Q?FKmZVUU0Y5DrhWqNflza2kPYtCs+DLG1gVDLL8y/4l8FrZ/6ZQFTx8E8RzN3?=
 =?us-ascii?Q?wEcCKJXFhCm6VN0UnlSMC+tCR750KNNN/EaILnlLxETMEsM/SgyUP+i2B3GU?=
 =?us-ascii?Q?0nfa3L1TB23+IuDiaBsTgZ2OJisheVRkT4HpaO2lqy6mQ1zQZ96z60QBvuEx?=
 =?us-ascii?Q?qVdsI2M/SzxrNzZcauKPCWB6ymaEMONEfsEPIdM670NeVtDfKmeVooReB849?=
 =?us-ascii?Q?d1LPWRxOwEKo8pbWbXnZJ7DVLPFblxxg/U5HqgKUMGNdaIiPF+g6NPur02BI?=
 =?us-ascii?Q?BHwQZ12TCa1o0M9KXAQFMtHfPdI/7zHco5QyXpVUzxBr4pY7oa9xl90h3Olx?=
 =?us-ascii?Q?6Qm8cjdVb96OF2ZnI82b5+OYomjRj7GX1SJiCe+N3o9OsryV6BYhdzr+xZx/?=
 =?us-ascii?Q?v9bkyE9dswqJAmqo7LsvmjXzSUDNNsfu5MfwdT4mwAgIOau1k3XauiYlXokH?=
 =?us-ascii?Q?gdAoEhYvAwhNwGt+Y7uSRzbLur5uEKlAPdLIm+aLWOYFFTigy3ssugydTzCB?=
 =?us-ascii?Q?sA2y1CDCP6gd62J0sENtto9CgWvtS9fCxmRV+16KP3plXAuKGbkLyiZdVoE1?=
 =?us-ascii?Q?xfKGiiw7xm7ujXJnyikvaFrZV8VBnnGfZA3mWdPfXYnrHoX/TTYwZm/iKeGX?=
 =?us-ascii?Q?c0GyGFKPcywTl2aQNH1YoGnFkpdY5nAMS11b2Pr/YZqCuRIn/2f9O2fWAPqt?=
 =?us-ascii?Q?+BGWnC/uYdYJK2BJYO39tBJyeevWeUEN3/0dsd0oJt0bQmZN8wv5atXCnKZi?=
 =?us-ascii?Q?BDmuj65d4Wx5nvjGpcu8nbSongBsTGTPpL9AXbeIKt7Fj/T+11l/nPCJJUWf?=
 =?us-ascii?Q?M3zYEoD60QEz7SJ7kSP+Z14rKn4PXkkLgoziRXYvgCNn79H5n4G6qTrreSUY?=
 =?us-ascii?Q?+GvseMZEosDM912/Z35Dgir+dpI9UaTjWLVq?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 06:38:05.5162
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f052ad3-24a4-41fe-d3bb-08dde3a1f2a3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9440

Instead of reading the requested rx queues after binding the buffer,
read the rx queues in advance in a bitmap and iterate over them when
needed.

This is a preparation for fetching the DMA device for each queue.

This patch has no functional changes besides adding an extra
rq index bounds check.

Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Mina Almasry <almasrymina@google.com>
---
 net/core/netdev-genl.c | 83 ++++++++++++++++++++++++++++--------------
 1 file changed, 56 insertions(+), 27 deletions(-)

diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
index 3e2d6aa6e060..75d600c24caf 100644
--- a/net/core/netdev-genl.c
+++ b/net/core/netdev-genl.c
@@ -869,17 +869,53 @@ int netdev_nl_qstats_get_dumpit(struct sk_buff *skb,
 	return err;
 }
 
-int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
+static int netdev_nl_read_rxq_bitmap(struct genl_info *info,
+				     u32 rxq_bitmap_len,
+				     unsigned long *rxq_bitmap)
 {
+	const int maxtype = ARRAY_SIZE(netdev_queue_id_nl_policy) - 1;
 	struct nlattr *tb[ARRAY_SIZE(netdev_queue_id_nl_policy)];
+	struct nlattr *attr;
+	int rem, err = 0;
+	u32 rxq_idx;
+
+	nla_for_each_attr_type(attr, NETDEV_A_DMABUF_QUEUES,
+			       genlmsg_data(info->genlhdr),
+			       genlmsg_len(info->genlhdr), rem) {
+		err = nla_parse_nested(tb, maxtype, attr,
+				       netdev_queue_id_nl_policy, info->extack);
+		if (err < 0)
+			return err;
+
+		if (NL_REQ_ATTR_CHECK(info->extack, attr, tb, NETDEV_A_QUEUE_ID) ||
+		    NL_REQ_ATTR_CHECK(info->extack, attr, tb, NETDEV_A_QUEUE_TYPE))
+			return -EINVAL;
+
+		if (nla_get_u32(tb[NETDEV_A_QUEUE_TYPE]) != NETDEV_QUEUE_TYPE_RX) {
+			NL_SET_BAD_ATTR(info->extack, tb[NETDEV_A_QUEUE_TYPE]);
+			return -EINVAL;
+		}
+
+		rxq_idx = nla_get_u32(tb[NETDEV_A_QUEUE_ID]);
+		if (rxq_idx >= rxq_bitmap_len)
+			return -EINVAL;
+
+		bitmap_set(rxq_bitmap, rxq_idx, 1);
+	}
+
+	return 0;
+}
+
+int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
+{
 	struct net_devmem_dmabuf_binding *binding;
 	u32 ifindex, dmabuf_fd, rxq_idx;
 	struct netdev_nl_sock *priv;
 	struct net_device *netdev;
+	unsigned long *rxq_bitmap;
 	struct device *dma_dev;
 	struct sk_buff *rsp;
-	struct nlattr *attr;
-	int rem, err = 0;
+	int err = 0;
 	void *hdr;
 
 	if (GENL_REQ_ATTR_CHECK(info, NETDEV_A_DEV_IFINDEX) ||
@@ -922,37 +958,26 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
 		goto err_unlock;
 	}
 
+	rxq_bitmap = bitmap_zalloc(netdev->real_num_rx_queues, GFP_KERNEL);
+	if (!rxq_bitmap) {
+		err = -ENOMEM;
+		goto err_unlock;
+	}
+
+	err = netdev_nl_read_rxq_bitmap(info, netdev->real_num_rx_queues,
+					rxq_bitmap);
+	if (err)
+		goto err_rxq_bitmap;
+
 	dma_dev = netdev_queue_get_dma_dev(netdev, 0);
 	binding = net_devmem_bind_dmabuf(netdev, dma_dev, DMA_FROM_DEVICE,
 					 dmabuf_fd, priv, info->extack);
 	if (IS_ERR(binding)) {
 		err = PTR_ERR(binding);
-		goto err_unlock;
+		goto err_rxq_bitmap;
 	}
 
-	nla_for_each_attr_type(attr, NETDEV_A_DMABUF_QUEUES,
-			       genlmsg_data(info->genlhdr),
-			       genlmsg_len(info->genlhdr), rem) {
-		err = nla_parse_nested(
-			tb, ARRAY_SIZE(netdev_queue_id_nl_policy) - 1, attr,
-			netdev_queue_id_nl_policy, info->extack);
-		if (err < 0)
-			goto err_unbind;
-
-		if (NL_REQ_ATTR_CHECK(info->extack, attr, tb, NETDEV_A_QUEUE_ID) ||
-		    NL_REQ_ATTR_CHECK(info->extack, attr, tb, NETDEV_A_QUEUE_TYPE)) {
-			err = -EINVAL;
-			goto err_unbind;
-		}
-
-		if (nla_get_u32(tb[NETDEV_A_QUEUE_TYPE]) != NETDEV_QUEUE_TYPE_RX) {
-			NL_SET_BAD_ATTR(info->extack, tb[NETDEV_A_QUEUE_TYPE]);
-			err = -EINVAL;
-			goto err_unbind;
-		}
-
-		rxq_idx = nla_get_u32(tb[NETDEV_A_QUEUE_ID]);
-
+	for_each_set_bit(rxq_idx, rxq_bitmap, netdev->real_num_rx_queues) {
 		err = net_devmem_bind_dmabuf_to_queue(netdev, rxq_idx, binding,
 						      info->extack);
 		if (err)
@@ -966,6 +991,8 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
 	if (err)
 		goto err_unbind;
 
+	bitmap_free(rxq_bitmap);
+
 	netdev_unlock(netdev);
 
 	mutex_unlock(&priv->lock);
@@ -974,6 +1001,8 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struct genl_info *info)
 
 err_unbind:
 	net_devmem_unbind_dmabuf(binding);
+err_rxq_bitmap:
+	bitmap_free(rxq_bitmap);
 err_unlock:
 	netdev_unlock(netdev);
 err_unlock_sock:
-- 
2.50.1


