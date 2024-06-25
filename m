Return-Path: <netdev+bounces-106485-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67499916952
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 15:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E88701F23A01
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 13:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3822815F3E8;
	Tue, 25 Jun 2024 13:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LavLwcPO"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2088.outbound.protection.outlook.com [40.107.93.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ABE017C98
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 13:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719323310; cv=fail; b=Sp7++3cZ7OpL/YNFId9jXZppwBsUYYREgZOmihzHd0MEXKO5tvRaNLA6VaGUrziIG+J6NNsR6JCsAiKUE2Ndk4Ui8n85FeeGGO9CupuYKiNzUkPRUTbRJO8FtGpx1jmQsOZyHTVnBztHua1BXt07R5b8Yd0JkxDOXhMYBl3AySs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719323310; c=relaxed/simple;
	bh=oi25eF//+6qhsQbRmzOknfow9hMORTmppDrtHCRjbQw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lGOeUnILzfvJrVb7vUDbY9Sgw+osQFoshDWw3bjtRYLgRREfET/lHLjTQPf1J2ns1xYeLAxujw9hJhoQ7SU0JrY2YxGNb1ln9U3OPFMOF4iCvi1Z9T6/8TYunyFXL81n4Mf7Sp/fwiK1aMzwWFW01SSg4d1KkcILPrNVV+Tb/8w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LavLwcPO; arc=fail smtp.client-ip=40.107.93.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q2t5Sag1ta7tjv//YXaHwYl9WixHaoLTirWH3DtxkFycWryLPCkb734alGZ+xPf93IAK0f4g62Z+8546tNxJPowBxUxxdXqf76XMdCRHXtNX/NykDPrjTlquQGC9XCuSpDMDrSC36bKe8qhs6B8Nemf9vGRr+kl7OZe7lkbLSW9Xp9/gtFzXELYn/uNUZBqHT96jnOw3iv3KkFBHI/fUMJSKd2kwwqwqG3/Z7bI4ph6R+0YfRkvxW161rEPVDz8o+z0+tplW/6P01yXzE9qQE3h3BMGrbka8Z0FX5JFWArsfapCXY+6u2orJ6AM9Cyuy5gZJdsyx2WRdo0Bx/2OGSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tEgp4E4gXbDSc94ZVzvje4Z/9TPn3gM9RSV/QQxnfps=;
 b=XmqrSdXCP+5fxKJKC/hHy0/z82BtdxIy/dZiyAul4W1zfy4SHjNt3HYerK3vfGsvDYAkNhiG3mEKfyaSrwens1d2gz+ZwYO91gyfIvn73yGACxwFWXwWbhncrOjSAp19V+2f/JtbQayw8HztIeyHKS3Fx3+jRwIs5otmddk/Peuann/OHr4IORfhOd+hvpVRUWfsCZj1DeJzy6Eexufz7QsAqGchnhZx1ve3RP7sQ946xEevtN/CPfROm/GsdjE5XUxPyknrDYtJdTuwuIeyIeHYfKrNrVwzpnId/mdScK6W8Xt0z72VM+JVWBcPoJLMT40y5/0/SuURVVWZIxJmKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tEgp4E4gXbDSc94ZVzvje4Z/9TPn3gM9RSV/QQxnfps=;
 b=LavLwcPO0Ak/OmJTnPzKIxTEZEojymN1m+Jiu20/63Bs9oYSRY63pcJfyfe7IdeR/vIqpaTMGa1HNmNeTae7hghk4U+uJVBLyxsi79nPhxtkIbfFt83ilauBRoKgQi2fsljhOx6SdL0yDYk7p7CrFl0F1rd+sCc5KnKnH6zHc55R0vwuI/5mrk5LRc7OkAL6cjl3D9+tItY2NwDcqQqyAsk3OihZ8DBHr+Xlrf9AKRpmEDH1jB+F6NNcQ5TYxmoM1vGcpQK9Cw8odvGFIWZgHK4i8JNFv/otMLE/2PAdigsUnGDvJwkPhbkmytFhAbvw/zDAj7eZjfpM3V2rZOPlrA==
Received: from CH0PR03CA0023.namprd03.prod.outlook.com (2603:10b6:610:b0::28)
 by DM4PR12MB5940.namprd12.prod.outlook.com (2603:10b6:8:6b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.28; Tue, 25 Jun
 2024 13:48:24 +0000
Received: from CH2PEPF00000141.namprd02.prod.outlook.com
 (2603:10b6:610:b0:cafe::e7) by CH0PR03CA0023.outlook.office365.com
 (2603:10b6:610:b0::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.20 via Frontend
 Transport; Tue, 25 Jun 2024 13:48:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF00000141.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Tue, 25 Jun 2024 13:48:23 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 25 Jun
 2024 06:48:04 -0700
Received: from yaviefel.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 25 Jun
 2024 06:48:00 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Amit
 Cohen" <amcohen@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 2/2] mlxsw: pci: Use fragmented buffers
Date: Tue, 25 Jun 2024 15:47:35 +0200
Message-ID: <ee38898c692e7f644a7f3ea4d33aeddb4dd917d2.1719321422.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1719321422.git.petrm@nvidia.com>
References: <cover.1719321422.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000141:EE_|DM4PR12MB5940:EE_
X-MS-Office365-Filtering-Correlation-Id: 89f86d61-bc2b-48c6-6bae-08dc951d7b8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|82310400023|376011|1800799021|36860700010;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kJ4ERcBgVXl7Vl0G97kaokZz+mvP/vnM2UuORq52UiwD57nyYWzPwbMMupzU?=
 =?us-ascii?Q?dK1BqH2S5MdHXi8t9q5bS1s2MuUG9JPPHh/sviEC5MwNGcyenibbF2LxcFkQ?=
 =?us-ascii?Q?wh8Xr65P5m/0Rv3jvlFDfBum/Hq4YqScAtcSt4scK9G61NGHK4XFWUiUakqp?=
 =?us-ascii?Q?WidNHydqJfIwZZ6DWp5EfmWZepVajo44IF9994/02siAMklodePALb9nrhTT?=
 =?us-ascii?Q?KcgwsML+CLtI4yrNaiSvqHZMHdwzTOFJtIdleJ4oCrMIdi8Snsdxb9KAB5sT?=
 =?us-ascii?Q?ouKO9jTHo3qVTVTRX12mmAVp8Jxw0KeLVx0oLcq/+sLYL20gc1SbR4bzzjR0?=
 =?us-ascii?Q?ejhHeRcgCNaQtk2+rx/0rU+DFT2CFj1nwJiXGvuqxs3WlShAOjv8z5TuyYRj?=
 =?us-ascii?Q?8GOAosjiJo0N+iu65VSkMeXuV4ByQJpoh4qpOve9ahvD6HZ/3SkpEuJ9yzoR?=
 =?us-ascii?Q?MwhkLDLnzGRQNKRWuvaBbNC7y/plEZz3+L2ZTzz1G830KStEy90Taf8IMfO+?=
 =?us-ascii?Q?rmrYZBrN9ceimFGnViVWiQa3te0IZ89c7cOg3wxruvOqxbXvlBqxPE/hVowz?=
 =?us-ascii?Q?j8mWBDB8dj8yY/ZJMyi2az7PWksDFVS9WkTVkQzubZslMOWakvPK7YH+aqOR?=
 =?us-ascii?Q?gxsUE7RzvfO+AIoqjVyypOnmaxTMUba2l2ScpNtojkSIaQZ+hrxeMF6VJL1R?=
 =?us-ascii?Q?FQcB8+A2YstTZqT0Hjghh/gi2LPajYUDCzMci6SstYQReN7vgQYA8U/D40Wm?=
 =?us-ascii?Q?ZD0wvkI4VzYx/ceO99TJB2EqtfERWvRzl7T2F8obu6IVSQCDM1MW+0eXVEQn?=
 =?us-ascii?Q?wORlWHX7obM4FjIxoqhlcu5FQmONJCoHGkhPkIdncBKnn4jwQVedC2BwUnYA?=
 =?us-ascii?Q?t53oGmIGmTOAvJrNwbOM/4f1LT1FMleazRyTW7D0hIGSkCoU3QFZ3oq1HuKD?=
 =?us-ascii?Q?16XE2MWhDuFIwS+9fFH3aC4AKWE2jDyqE5y/C0iXrZr9oB6OJ64xRWMRcs+e?=
 =?us-ascii?Q?ySE7i8CVlAvnVggIle0z69vx8cU8I4mFmEke43i4kwXT5k/Xy+CLDSgN4SSM?=
 =?us-ascii?Q?sVWFv6Hs3LHUAqu1E7IV7sbZjIMBCa5+9+s0PcGi1G39Ib25UPHP8G8/iYkH?=
 =?us-ascii?Q?lyUnyABgm8hGbbqCE5RmypVexUJhhX0gF/kuKqaYTl5YopEfXyu2wDWt4ZJx?=
 =?us-ascii?Q?xKtwhuSNZ+s+ZFVDckJ6ZRyiJPJnxmEGa2U2JgZUB68A8bu2XWIBy6g0vkw/?=
 =?us-ascii?Q?YYiZgwgUP017wclQA1/wDUELogE80qteBTCjOdrtY0rrO81wn86fralARRJV?=
 =?us-ascii?Q?W99hfXDJL1ATKzYzXVhbD37v4lD5xliPqkJDra6LrtsJpHty/b7g31ep93Sj?=
 =?us-ascii?Q?qXXEKevbcrP/lsk8BjuEqgPI97sAI4nUQlJKzHtE+wwnGarILg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230037)(82310400023)(376011)(1800799021)(36860700010);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 13:48:23.7595
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89f86d61-bc2b-48c6-6bae-08dc951d7b8c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000141.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5940

From: Amit Cohen <amcohen@nvidia.com>

WQE (Work Queue Element) includes 3 scatter/gather entries for buffers.
The buffer can be split into 3 parts, software should set address and byte
count of each part.

A previous patch-set used page pool to allocate buffers, to simplify the
change, we first used one continuous buffer, which was allocated with
order > 0. This patch improves page pool usage to allocate the exact
number of pages which are required for packet.

As part of init, fill WQE.address[x] and WQE.byte_count* with pages which
are allocated from the pool. Fill x entries according to number of
scatter/gather entries which are required for maximum packet size. When a
packet is received, check the actual size and replace only the used pages.
Save bytes for software overhead only as part of the first entry.

This change also requires using fragmented SKB, till now all the buffer
was in the linear part. Note that 'skb->truesize' is decreased for small
packets.

For now the maximum buffer size is 3 * PAGE_SIZE which is enough, in
case that the driver will support larger MTU, we can use 'order' to
allocate more than one page per scatter/gather entry.

This change significantly reduces memory consumption of mlxsw driver. The
footprint is reduced by 26%.

Signed-off-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/pci.c | 163 +++++++++++++++++-----
 1 file changed, 129 insertions(+), 34 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/pci.c b/drivers/net/ethernet/mellanox/mlxsw/pci.c
index 0492013aca18..0320dabd1380 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/pci.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/pci.c
@@ -62,7 +62,7 @@ struct mlxsw_pci_mem_item {
 };
 
 struct mlxsw_pci_queue_elem_info {
-	struct page *page;
+	struct page *pages[MLXSW_PCI_WQE_SG_ENTRIES];
 	char *elem; /* pointer to actual dma mapped element mem chunk */
 	struct {
 		struct sk_buff *skb;
@@ -350,7 +350,11 @@ mlxsw_pci_wqe_rx_frag_set(struct mlxsw_pci *mlxsw_pci, struct page *page,
 	dma_addr_t mapaddr;
 
 	mapaddr = page_pool_get_dma_addr(page);
-	mapaddr += MLXSW_PCI_SKB_HEADROOM;
+
+	if (index == 0) {
+		mapaddr += MLXSW_PCI_SKB_HEADROOM;
+		frag_len = frag_len - MLXSW_PCI_RX_BUF_SW_OVERHEAD;
+	}
 
 	mlxsw_pci_wqe_address_set(wqe, index, mapaddr);
 	mlxsw_pci_wqe_byte_count_set(wqe, index, frag_len);
@@ -385,29 +389,56 @@ static void mlxsw_pci_wqe_frag_unmap(struct mlxsw_pci *mlxsw_pci, char *wqe,
 	dma_unmap_single(&pdev->dev, mapaddr, frag_len, direction);
 }
 
-static struct sk_buff *mlxsw_pci_rdq_build_skb(struct page *page,
+static struct sk_buff *mlxsw_pci_rdq_build_skb(struct page *pages[],
 					       u16 byte_count)
 {
-	void *data = page_address(page);
-	unsigned int allocated_size;
+	unsigned int linear_data_size;
 	struct sk_buff *skb;
+	int page_index = 0;
+	bool linear_only;
+	void *data;
 
+	data = page_address(pages[page_index]);
 	net_prefetch(data);
-	allocated_size = page_size(page);
-	skb = napi_build_skb(data, allocated_size);
+
+	skb = napi_build_skb(data, PAGE_SIZE);
 	if (unlikely(!skb))
 		return ERR_PTR(-ENOMEM);
 
+	linear_only = byte_count + MLXSW_PCI_RX_BUF_SW_OVERHEAD <= PAGE_SIZE;
+	linear_data_size = linear_only ? byte_count :
+					 PAGE_SIZE -
+					 MLXSW_PCI_RX_BUF_SW_OVERHEAD;
+
 	skb_reserve(skb, MLXSW_PCI_SKB_HEADROOM);
-	skb_put(skb, byte_count);
+	skb_put(skb, linear_data_size);
+
+	if (linear_only)
+		return skb;
+
+	byte_count -= linear_data_size;
+	page_index++;
+
+	while (byte_count > 0) {
+		unsigned int frag_size;
+		struct page *page;
+
+		page = pages[page_index];
+		frag_size = min(byte_count, PAGE_SIZE);
+		skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
+				page, 0, frag_size, PAGE_SIZE);
+		byte_count -= frag_size;
+		page_index++;
+	}
+
 	return skb;
 }
 
 static int mlxsw_pci_rdq_page_alloc(struct mlxsw_pci_queue *q,
-				    struct mlxsw_pci_queue_elem_info *elem_info)
+				    struct mlxsw_pci_queue_elem_info *elem_info,
+				    int index)
 {
 	struct mlxsw_pci_queue *cq = q->u.rdq.cq;
-	size_t buf_len = MLXSW_PORT_MAX_MTU;
 	char *wqe = elem_info->elem;
 	struct page *page;
 
@@ -415,17 +446,19 @@ static int mlxsw_pci_rdq_page_alloc(struct mlxsw_pci_queue *q,
 	if (unlikely(!page))
 		return -ENOMEM;
 
-	mlxsw_pci_wqe_rx_frag_set(q->pci, page, wqe, 0, buf_len);
-	elem_info->page = page;
+	mlxsw_pci_wqe_rx_frag_set(q->pci, page, wqe, index, PAGE_SIZE);
+	elem_info->pages[index] = page;
 	return 0;
 }
 
 static void mlxsw_pci_rdq_page_free(struct mlxsw_pci_queue *q,
-				    struct mlxsw_pci_queue_elem_info *elem_info)
+				    struct mlxsw_pci_queue_elem_info *elem_info,
+				    int index)
 {
 	struct mlxsw_pci_queue *cq = q->u.rdq.cq;
 
-	page_pool_put_page(cq->u.cq.page_pool, elem_info->page, -1, false);
+	page_pool_put_page(cq->u.cq.page_pool, elem_info->pages[index], -1,
+			   false);
 }
 
 static u8 mlxsw_pci_num_sg_entries_get(u16 byte_count)
@@ -434,6 +467,64 @@ static u8 mlxsw_pci_num_sg_entries_get(u16 byte_count)
 			    PAGE_SIZE);
 }
 
+static int
+mlxsw_pci_elem_info_pages_ref_store(const struct mlxsw_pci_queue *q,
+				    const struct mlxsw_pci_queue_elem_info *el,
+				    u16 byte_count, struct page *pages[],
+				    u8 *p_num_sg_entries)
+{
+	u8 num_sg_entries;
+	int i;
+
+	num_sg_entries = mlxsw_pci_num_sg_entries_get(byte_count);
+	if (WARN_ON_ONCE(num_sg_entries > q->pci->num_sg_entries))
+		return -EINVAL;
+
+	for (i = 0; i < num_sg_entries; i++)
+		pages[i] = el->pages[i];
+
+	*p_num_sg_entries = num_sg_entries;
+	return 0;
+}
+
+static int
+mlxsw_pci_rdq_pages_alloc(struct mlxsw_pci_queue *q,
+			  struct mlxsw_pci_queue_elem_info *elem_info,
+			  u8 num_sg_entries)
+{
+	struct page *old_pages[MLXSW_PCI_WQE_SG_ENTRIES];
+	struct mlxsw_pci_queue *cq = q->u.rdq.cq;
+	int i, err;
+
+	for (i = 0; i < num_sg_entries; i++) {
+		old_pages[i] = elem_info->pages[i];
+		err = mlxsw_pci_rdq_page_alloc(q, elem_info, i);
+		if (err) {
+			dev_err_ratelimited(&q->pci->pdev->dev, "Failed to alloc page\n");
+			goto err_page_alloc;
+		}
+	}
+
+	return 0;
+
+err_page_alloc:
+	for (i--; i >= 0; i--)
+		page_pool_recycle_direct(cq->u.cq.page_pool, old_pages[i]);
+
+	return err;
+}
+
+static void
+mlxsw_pci_rdq_pages_recycle(struct mlxsw_pci_queue *q, struct page *pages[],
+			    u8 num_sg_entries)
+{
+	struct mlxsw_pci_queue *cq = q->u.rdq.cq;
+	int i;
+
+	for (i = 0; i < num_sg_entries; i++)
+		page_pool_recycle_direct(cq->u.cq.page_pool, pages[i]);
+}
+
 static int mlxsw_pci_rdq_init(struct mlxsw_pci *mlxsw_pci, char *mbox,
 			      struct mlxsw_pci_queue *q)
 {
@@ -441,7 +532,7 @@ static int mlxsw_pci_rdq_init(struct mlxsw_pci *mlxsw_pci, char *mbox,
 	u8 sdq_count = mlxsw_pci->num_sdqs;
 	struct mlxsw_pci_queue *cq;
 	u8 cq_num;
-	int i;
+	int i, j;
 	int err;
 
 	q->producer_counter = 0;
@@ -472,9 +563,12 @@ static int mlxsw_pci_rdq_init(struct mlxsw_pci *mlxsw_pci, char *mbox,
 	for (i = 0; i < q->count; i++) {
 		elem_info = mlxsw_pci_queue_elem_info_producer_get(q);
 		BUG_ON(!elem_info);
-		err = mlxsw_pci_rdq_page_alloc(q, elem_info);
-		if (err)
-			goto rollback;
+
+		for (j = 0; j < mlxsw_pci->num_sg_entries; j++) {
+			err = mlxsw_pci_rdq_page_alloc(q, elem_info, j);
+			if (err)
+				goto rollback;
+		}
 		/* Everything is set up, ring doorbell to pass elem to HW */
 		q->producer_counter++;
 		mlxsw_pci_queue_doorbell_producer_ring(mlxsw_pci, q);
@@ -485,7 +579,9 @@ static int mlxsw_pci_rdq_init(struct mlxsw_pci *mlxsw_pci, char *mbox,
 rollback:
 	for (i--; i >= 0; i--) {
 		elem_info = mlxsw_pci_queue_elem_info_get(q, i);
-		mlxsw_pci_rdq_page_free(q, elem_info);
+		for (j--; j >= 0; j--)
+			mlxsw_pci_rdq_page_free(q, elem_info, j);
+		j = mlxsw_pci->num_sg_entries;
 	}
 	q->u.rdq.cq = NULL;
 	cq->u.cq.dq = NULL;
@@ -498,12 +594,13 @@ static void mlxsw_pci_rdq_fini(struct mlxsw_pci *mlxsw_pci,
 			       struct mlxsw_pci_queue *q)
 {
 	struct mlxsw_pci_queue_elem_info *elem_info;
-	int i;
+	int i, j;
 
 	mlxsw_cmd_hw2sw_rdq(mlxsw_pci->core, q->num);
 	for (i = 0; i < q->count; i++) {
 		elem_info = mlxsw_pci_queue_elem_info_get(q, i);
-		mlxsw_pci_rdq_page_free(q, elem_info);
+		for (j = 0; j < mlxsw_pci->num_sg_entries; j++)
+			mlxsw_pci_rdq_page_free(q, elem_info, j);
 	}
 }
 
@@ -637,11 +734,11 @@ static void mlxsw_pci_cqe_rdq_handle(struct mlxsw_pci *mlxsw_pci,
 				     enum mlxsw_pci_cqe_v cqe_v, char *cqe)
 {
 	struct pci_dev *pdev = mlxsw_pci->pdev;
+	struct page *pages[MLXSW_PCI_WQE_SG_ENTRIES];
 	struct mlxsw_pci_queue_elem_info *elem_info;
-	struct mlxsw_pci_queue *cq = q->u.rdq.cq;
 	struct mlxsw_rx_info rx_info = {};
 	struct sk_buff *skb;
-	struct page *page;
+	u8 num_sg_entries;
 	u16 byte_count;
 	int err;
 
@@ -654,18 +751,19 @@ static void mlxsw_pci_cqe_rdq_handle(struct mlxsw_pci *mlxsw_pci,
 	if (mlxsw_pci_cqe_crc_get(cqe_v, cqe))
 		byte_count -= ETH_FCS_LEN;
 
-	page = elem_info->page;
+	err = mlxsw_pci_elem_info_pages_ref_store(q, elem_info, byte_count,
+						  pages, &num_sg_entries);
+	if (err)
+		goto out;
 
-	err = mlxsw_pci_rdq_page_alloc(q, elem_info);
-	if (err) {
-		dev_err_ratelimited(&pdev->dev, "Failed to alloc page\n");
+	err = mlxsw_pci_rdq_pages_alloc(q, elem_info, num_sg_entries);
+	if (err)
 		goto out;
-	}
 
-	skb = mlxsw_pci_rdq_build_skb(page, byte_count);
+	skb = mlxsw_pci_rdq_build_skb(pages, byte_count);
 	if (IS_ERR(skb)) {
 		dev_err_ratelimited(&pdev->dev, "Failed to build skb for RDQ\n");
-		page_pool_recycle_direct(cq->u.cq.page_pool, page);
+		mlxsw_pci_rdq_pages_recycle(q, pages, num_sg_entries);
 		goto out;
 	}
 
@@ -886,15 +984,12 @@ static int mlxsw_pci_cq_page_pool_init(struct mlxsw_pci_queue *q,
 	struct page_pool_params pp_params = {};
 	struct mlxsw_pci *mlxsw_pci = q->pci;
 	struct page_pool *page_pool;
-	u32 max_pkt_size;
 
 	if (cq_type != MLXSW_PCI_CQ_RDQ)
 		return 0;
 
-	max_pkt_size = MLXSW_PORT_MAX_MTU + MLXSW_PCI_RX_BUF_SW_OVERHEAD;
-	pp_params.order = get_order(max_pkt_size);
 	pp_params.flags = PP_FLAG_DMA_MAP;
-	pp_params.pool_size = MLXSW_PCI_WQE_COUNT;
+	pp_params.pool_size = MLXSW_PCI_WQE_COUNT * mlxsw_pci->num_sg_entries;
 	pp_params.nid = dev_to_node(&mlxsw_pci->pdev->dev);
 	pp_params.dev = &mlxsw_pci->pdev->dev;
 	pp_params.napi = &q->u.cq.napi;
-- 
2.45.0


