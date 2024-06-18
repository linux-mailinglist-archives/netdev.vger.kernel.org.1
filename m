Return-Path: <netdev+bounces-104480-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBFE990CA7D
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 13:54:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79A1F287393
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 11:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8613415A860;
	Tue, 18 Jun 2024 11:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pyb9lgMA"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2073.outbound.protection.outlook.com [40.107.92.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B0B15A853
	for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 11:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718710554; cv=fail; b=YI1t1Tt481DxVsuCYvh/PaetdgdjW3d5RJc0Y4JC2keYColsPvTo4q7/LOqQ6hSvLN+rCzbHxWB5/to+Rw8LzbBWv60odOOBYS7DMtse/calWcxbprpxrAamVhvOvxj+W/ZcG1q3k8aqZtynf7QsOB+DZUbhWZz1hJwkdoQfDp0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718710554; c=relaxed/simple;
	bh=ilabmjmKCIxcZgvtmQil/+mXGC2DIcerswUdnobfG9c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qfGOU3IKdBRSQt1PuaEX4CYkpi+b/JwA2ubPjOPUXh1qe1D+YhpjzLd7xODxAeIGQVKi5vbCSAKcOHZHr7IRbhE/PzmVr8/v/fU6sS9qiZF6SbATCmu64to0k1Bd6wBqQZXyhpofBopV5KKveqV26lKxTmYXB53D/+/VNSpAhgM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pyb9lgMA; arc=fail smtp.client-ip=40.107.92.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cVcDCk+XDezosaW2IvZHwnwqEAnuFwPO61yhYC/g9ayX+8lBj1qBi3vsf8LWklF7eN4MknKcLl37G1m40vICdXhYIw5IQMp0cMCbq7eBp07NiG4mGyRAR3ZFXNdIj0zdWDBFue/hZkamVqS35Yiniv/QH0/S8oA641owfFNYklmlX/yqbvQXb/jr/7AyRsmUEV/vLsBNgYz//t+bLltZNnEp5qU7ZBi3MzgI58zPJYFTwUrLPI1fMw4fUJi+5DOEQK5Xx6PTx62QZM6wIGYiO/3tqDC2xVmvAOItdUl0Nc6BJcn40g/9qMZes7m1PdIGLo1trMpuJbUHPsvA6EK+Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YugrpxB9T9fg4wqQjWwx1U5BFRb9zT9MMcGQrjJfoQk=;
 b=bEKDbHUZxm9PQc9NmEYM0Nw4omYnoM8+OHdtmrilxiQTCwWHfl2H0V8IH4kLqkBZzykd3P3AT5hgWfBkr9FGn4LjcIRt4e/WbzDBPXI9XfS/82d55cCEsMr5UQvkt4zbgCTaf6hVPqyInQC0hRin1LX6I932A+vg3m3907XCPbxpWRidbm7SUlYd31uaQ/Sds3TPQhs5/MXheVEZBa+cHttGDreF9NCc4iUu78u2gHJdHQeKbuDGte9htnIKC3oPMh/nRWSOHh6ntpKr+qYm+xza88BEwcRvP+FihAQ3Wjl7FeEN30ljVzbkR+zVzW8+VoVGTFCu44mOmwP7WWomjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YugrpxB9T9fg4wqQjWwx1U5BFRb9zT9MMcGQrjJfoQk=;
 b=pyb9lgMA7G6+q10cWnx+I2trBmEAOZgO3/+HOlxLjHzLFPgcw6rmEDxeBHnk02eg1CnZKx90VFHLHcwm8qOH8pdp9z8TLuIbbdoTGu5BBAQKTuaaXlwwQvvBI2fckUXlxvKUSHQSGIHaS1lR4oi/AT+dX8xuxyNK67o5UCO/7giXnbf0ikBSZsCaydAVIn++zGFVD7e1k09II17aXdWwL6BJ5kwi0V6vPhJ5+EhMt1V2bYltaZbsPyeHe1EKXWiY/vvPHfXRqKdwTPDrKgY/z/3iUkM/+73NmsyISYgh3Nw38WxG2Sciksp7ZMPH1uOdsw+gKHAOX1oZNdFd/kZgcA==
Received: from BN9PR03CA0039.namprd03.prod.outlook.com (2603:10b6:408:fb::14)
 by CH3PR12MB9456.namprd12.prod.outlook.com (2603:10b6:610:1c2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Tue, 18 Jun
 2024 11:35:48 +0000
Received: from BN2PEPF0000449F.namprd02.prod.outlook.com
 (2603:10b6:408:fb:cafe::82) by BN9PR03CA0039.outlook.office365.com
 (2603:10b6:408:fb::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31 via Frontend
 Transport; Tue, 18 Jun 2024 11:35:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF0000449F.mail.protection.outlook.com (10.167.243.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Tue, 18 Jun 2024 11:35:47 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 18 Jun
 2024 04:35:32 -0700
Received: from yaviefel.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 18 Jun
 2024 04:35:27 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Amit
 Cohen" <amcohen@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 4/7] mlxsw: pci: Use page pool for Rx buffers allocation
Date: Tue, 18 Jun 2024 13:34:43 +0200
Message-ID: <1cf788a8f43c70aae6d526018ef77becb27ad6d3.1718709196.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1718709196.git.petrm@nvidia.com>
References: <cover.1718709196.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449F:EE_|CH3PR12MB9456:EE_
X-MS-Office365-Filtering-Correlation-Id: a8cd99a3-60ec-40c8-91f7-08dc8f8acc8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|82310400023|1800799021|376011|36860700010;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?68RVvxsvIuguEnJdO9NJXmTg7l8G2MjQAiECPFeWXg3xVEGRTqAOJeZnc2Rw?=
 =?us-ascii?Q?WrDh9E8p8jzmqLsCW+GwbXkeXfnZ7iVPS2kaXP/4GtnVyD5LLhIw5SEQr2Io?=
 =?us-ascii?Q?8WKAbXBMddp2NHKgP2XAY5DckxbYXIvCCN/dyDWTV6Hi1QqZzR0xUng8nbGh?=
 =?us-ascii?Q?c/8FGbYPe670GIWb+VZvpd4xqRzVUz0SrT9+muNkUws4Ad3OiOGyjBIuzxbC?=
 =?us-ascii?Q?3MGRWrTN68MtEkxxDGR5U28UwMvbd7ncMa2bqA8gQ+e7dgVUQmR4lTXu5td7?=
 =?us-ascii?Q?1aejr+N8BCCt8F28DklJMqlHd2U1rSH6tpBRSq0aThouBrOVUQDH9YV1QwTz?=
 =?us-ascii?Q?DbjPaVzoHkkJtto4WRX2Ge/YthooPox4z1ZOOF6ybfCHFVywM+Pgh+TqEiF+?=
 =?us-ascii?Q?kYZ1RBV49mHUN8yqHBs6HzkCKovMDPpl7RVMZVI8x+NQMKGStkSInEV3Am7p?=
 =?us-ascii?Q?jVB02o4RhyZoEeCStkhRm5mu48VlGbEQZJ0VAbOGbrUT2eNPkubHBM6ybh8Y?=
 =?us-ascii?Q?oJspkuUkJ4g0/jI3vI382XDvyEMRWEBK7MzzNEk7j5Pzoc3kv3MXSD6sePDl?=
 =?us-ascii?Q?78pIWhml0KgLuP/uMjWdX+S6qF8B/Uy57hzX4nzFN14Ozs0OqUofSyFa+PZX?=
 =?us-ascii?Q?svo0Roui9jUeF/MOIJIxIwXgxOetqLOb7S16hUihz4VOsLouglcGpDcXpjwP?=
 =?us-ascii?Q?LXqjZHYxRDNMVN8278KE3nY4KOf75aPAdABQZCS847G76lCGoPI5bOoxRc47?=
 =?us-ascii?Q?qmtkAP1Nls98pwwAcPvTIRMXxxpm6UzTW1u+Jkbhuv/oX7zbnFoQ6B7DR4Xw?=
 =?us-ascii?Q?fK8EO/mqsh4dMzG94QnwelgO9RYtemGLVGg9yVQFezpP6H0zNZ0UzUjhjmkf?=
 =?us-ascii?Q?yRogb6KmxXQjrzc8VM5f1e9/Ib/V5TVNFJOdZZHUW2sqvajBbprPK7re/pOs?=
 =?us-ascii?Q?jJTroTZ5nLz9/BSgUKaR261eheKOaNISqeodpK/biDsB/3wmltX6sbMGDVPm?=
 =?us-ascii?Q?5hdkuwiUUO1uuRcOSJA14ED7FUMj/pq2PdOhEa1ChNU9NoEAzQE2ir1v4AO8?=
 =?us-ascii?Q?ssOzN4ccTPldXID0kS1YOG28YpEv3E8o8Ii+ESBUeFKVIv8+injJWpkahoyx?=
 =?us-ascii?Q?sAzaBac4z3YrwsF0n0B4E9sA+mRcXZDhGgas4DpfPT8t/4EqiZ7/q4MhHP+Y?=
 =?us-ascii?Q?tZKgBXJA5/mnbnq+trUkrRh8UvbPR7ErK3nmJKgrifhcAi0GeX7tlh5th+Lu?=
 =?us-ascii?Q?x4JMDkeWpKGeFj2SDAuBw+fGTfbuYlhE9eEbONiJXld7+iCzl6mb0pqspEZN?=
 =?us-ascii?Q?JuxUmSvYIEo2T6mozi0AC6m4RNN2gFeaQ6eYqfV35nlq2++3InS9neSGMtk4?=
 =?us-ascii?Q?TnyJFSeLoD87b4JtH/41TR7pumcutFnrKJMo0yV/DNYzIxKy1g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230037)(82310400023)(1800799021)(376011)(36860700010);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 11:35:47.7825
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a8cd99a3-60ec-40c8-91f7-08dc8f8acc8d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000449F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9456

From: Amit Cohen <amcohen@nvidia.com>

As part of driver init, all Rx queues are filled with buffers for
hardware usage. Later, when a packet is received, a new buffer should be
allocated to be used by hardware instead of the received buffer.
Packet's processing time includes allocation time, which can be improved
using page pool.

Using page pool, DMA mapping is done only for first allocation of buffers.
As subsequent buffers allocation avoid DMA mapping, it results in
performance improvement. The purpose of page pool is to allocate pages fast
from cache without locking. This lockless guarantee naturally comes from
running under a NAPI.

Use page pool to allocate the data buffer only, so hardware will use it to
fill the packet. At completion time, attach the data buffer (now filled
with packet payload) to new SKB which is allocated around the received
buffer. SKB building at completion time prevents cache miss for each
packet, as now the SKB is allocated right before packets will be handled by
networking stack.

Page pool for each Rx queue enhances Rx side performance by reclaiming
buffers back to each queue specific pool. This change significantly
improves driver performance, CPU can handle about 345% of the packets per
second it previously handled.

Signed-off-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/pci.c | 103 ++++++++++++++--------
 1 file changed, 64 insertions(+), 39 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/pci.c b/drivers/net/ethernet/mellanox/mlxsw/pci.c
index 045f8b77698c..711b12aecfb7 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/pci.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/pci.c
@@ -62,6 +62,7 @@ struct mlxsw_pci_mem_item {
 };
 
 struct mlxsw_pci_queue_elem_info {
+	struct page *page;
 	char *elem; /* pointer to actual dma mapped element mem chunk */
 	union {
 		struct {
@@ -346,6 +347,19 @@ static void mlxsw_pci_sdq_fini(struct mlxsw_pci *mlxsw_pci,
 		(MLXSW_PCI_SKB_HEADROOM +	\
 		SKB_DATA_ALIGN(sizeof(struct skb_shared_info)))
 
+static void
+mlxsw_pci_wqe_rx_frag_set(struct mlxsw_pci *mlxsw_pci, struct page *page,
+			  char *wqe, int index, size_t frag_len)
+{
+	dma_addr_t mapaddr;
+
+	mapaddr = page_pool_get_dma_addr(page);
+	mapaddr += MLXSW_PCI_SKB_HEADROOM;
+
+	mlxsw_pci_wqe_address_set(wqe, index, mapaddr);
+	mlxsw_pci_wqe_byte_count_set(wqe, index, frag_len);
+}
+
 static int mlxsw_pci_wqe_frag_map(struct mlxsw_pci *mlxsw_pci, char *wqe,
 				  int index, char *frag_data, size_t frag_len,
 				  int direction)
@@ -375,43 +389,46 @@ static void mlxsw_pci_wqe_frag_unmap(struct mlxsw_pci *mlxsw_pci, char *wqe,
 	dma_unmap_single(&pdev->dev, mapaddr, frag_len, direction);
 }
 
-static int mlxsw_pci_rdq_skb_alloc(struct mlxsw_pci *mlxsw_pci,
-				   struct mlxsw_pci_queue_elem_info *elem_info,
-				   gfp_t gfp)
+static struct sk_buff *mlxsw_pci_rdq_build_skb(struct page *page,
+					       u16 byte_count)
 {
+	void *data = page_address(page);
+	unsigned int allocated_size;
+	struct sk_buff *skb;
+
+	allocated_size = page_size(page);
+	skb = napi_build_skb(data, allocated_size);
+	if (unlikely(!skb))
+		return ERR_PTR(-ENOMEM);
+
+	skb_reserve(skb, MLXSW_PCI_SKB_HEADROOM);
+	skb_put(skb, byte_count);
+	return skb;
+}
+
+static int mlxsw_pci_rdq_page_alloc(struct mlxsw_pci_queue *q,
+				    struct mlxsw_pci_queue_elem_info *elem_info)
+{
+	struct mlxsw_pci_queue *cq = q->u.rdq.cq;
 	size_t buf_len = MLXSW_PORT_MAX_MTU;
 	char *wqe = elem_info->elem;
-	struct sk_buff *skb;
-	int err;
+	struct page *page;
 
-	skb = __netdev_alloc_skb_ip_align(NULL, buf_len, gfp);
-	if (!skb)
+	page = page_pool_dev_alloc_pages(cq->u.cq.page_pool);
+	if (unlikely(!page))
 		return -ENOMEM;
 
-	err = mlxsw_pci_wqe_frag_map(mlxsw_pci, wqe, 0, skb->data,
-				     buf_len, DMA_FROM_DEVICE);
-	if (err)
-		goto err_frag_map;
-
-	elem_info->u.rdq.skb = skb;
+	mlxsw_pci_wqe_rx_frag_set(q->pci, page, wqe, 0, buf_len);
+	elem_info->page = page;
 	return 0;
-
-err_frag_map:
-	dev_kfree_skb_any(skb);
-	return err;
 }
 
-static void mlxsw_pci_rdq_skb_free(struct mlxsw_pci *mlxsw_pci,
-				   struct mlxsw_pci_queue_elem_info *elem_info)
+static void mlxsw_pci_rdq_page_free(struct mlxsw_pci_queue *q,
+				    struct mlxsw_pci_queue_elem_info *elem_info)
 {
-	struct sk_buff *skb;
-	char *wqe;
+	struct mlxsw_pci_queue *cq = q->u.rdq.cq;
 
-	skb = elem_info->u.rdq.skb;
-	wqe = elem_info->elem;
-
-	mlxsw_pci_wqe_frag_unmap(mlxsw_pci, wqe, 0, DMA_FROM_DEVICE);
-	dev_kfree_skb_any(skb);
+	page_pool_put_page(cq->u.cq.page_pool, elem_info->page, -1, false);
 }
 
 static int mlxsw_pci_rdq_init(struct mlxsw_pci *mlxsw_pci, char *mbox,
@@ -452,7 +469,7 @@ static int mlxsw_pci_rdq_init(struct mlxsw_pci *mlxsw_pci, char *mbox,
 	for (i = 0; i < q->count; i++) {
 		elem_info = mlxsw_pci_queue_elem_info_producer_get(q);
 		BUG_ON(!elem_info);
-		err = mlxsw_pci_rdq_skb_alloc(mlxsw_pci, elem_info, GFP_KERNEL);
+		err = mlxsw_pci_rdq_page_alloc(q, elem_info);
 		if (err)
 			goto rollback;
 		/* Everything is set up, ring doorbell to pass elem to HW */
@@ -465,7 +482,7 @@ static int mlxsw_pci_rdq_init(struct mlxsw_pci *mlxsw_pci, char *mbox,
 rollback:
 	for (i--; i >= 0; i--) {
 		elem_info = mlxsw_pci_queue_elem_info_get(q, i);
-		mlxsw_pci_rdq_skb_free(mlxsw_pci, elem_info);
+		mlxsw_pci_rdq_page_free(q, elem_info);
 	}
 	q->u.rdq.cq = NULL;
 	cq->u.cq.dq = NULL;
@@ -483,7 +500,7 @@ static void mlxsw_pci_rdq_fini(struct mlxsw_pci *mlxsw_pci,
 	mlxsw_cmd_hw2sw_rdq(mlxsw_pci->core, q->num);
 	for (i = 0; i < q->count; i++) {
 		elem_info = mlxsw_pci_queue_elem_info_get(q, i);
-		mlxsw_pci_rdq_skb_free(mlxsw_pci, elem_info);
+		mlxsw_pci_rdq_page_free(q, elem_info);
 	}
 }
 
@@ -618,26 +635,38 @@ static void mlxsw_pci_cqe_rdq_handle(struct mlxsw_pci *mlxsw_pci,
 {
 	struct pci_dev *pdev = mlxsw_pci->pdev;
 	struct mlxsw_pci_queue_elem_info *elem_info;
+	struct mlxsw_pci_queue *cq = q->u.rdq.cq;
 	struct mlxsw_rx_info rx_info = {};
-	char wqe[MLXSW_PCI_WQE_SIZE];
 	struct sk_buff *skb;
+	struct page *page;
 	u16 byte_count;
 	int err;
 
 	elem_info = mlxsw_pci_queue_elem_info_consumer_get(q);
-	skb = elem_info->u.rdq.skb;
-	memcpy(wqe, elem_info->elem, MLXSW_PCI_WQE_SIZE);
 
 	if (q->consumer_counter++ != consumer_counter_limit)
 		dev_dbg_ratelimited(&pdev->dev, "Consumer counter does not match limit in RDQ\n");
 
-	err = mlxsw_pci_rdq_skb_alloc(mlxsw_pci, elem_info, GFP_ATOMIC);
+	byte_count = mlxsw_pci_cqe_byte_count_get(cqe);
+	if (mlxsw_pci_cqe_crc_get(cqe_v, cqe))
+		byte_count -= ETH_FCS_LEN;
+
+	page = elem_info->page;
+
+	err = mlxsw_pci_rdq_page_alloc(q, elem_info);
 	if (err) {
-		dev_err_ratelimited(&pdev->dev, "Failed to alloc skb for RDQ\n");
+		dev_err_ratelimited(&pdev->dev, "Failed to alloc page\n");
 		goto out;
 	}
 
-	mlxsw_pci_wqe_frag_unmap(mlxsw_pci, wqe, 0, DMA_FROM_DEVICE);
+	skb = mlxsw_pci_rdq_build_skb(page, byte_count);
+	if (IS_ERR(skb)) {
+		dev_err_ratelimited(&pdev->dev, "Failed to build skb for RDQ\n");
+		page_pool_recycle_direct(cq->u.cq.page_pool, page);
+		goto out;
+	}
+
+	skb_mark_for_recycle(skb);
 
 	if (mlxsw_pci_cqe_lag_get(cqe_v, cqe)) {
 		rx_info.is_lag = true;
@@ -670,10 +699,6 @@ static void mlxsw_pci_cqe_rdq_handle(struct mlxsw_pci *mlxsw_pci,
 
 	mlxsw_pci_skb_cb_ts_set(mlxsw_pci, skb, cqe_v, cqe);
 
-	byte_count = mlxsw_pci_cqe_byte_count_get(cqe);
-	if (mlxsw_pci_cqe_crc_get(cqe_v, cqe))
-		byte_count -= ETH_FCS_LEN;
-	skb_put(skb, byte_count);
 	mlxsw_core_skb_receive(mlxsw_pci->core, skb, &rx_info);
 
 out:
-- 
2.45.0


