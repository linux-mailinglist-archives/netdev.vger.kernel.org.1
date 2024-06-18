Return-Path: <netdev+bounces-104479-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90FAA90CA7C
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 13:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25334282429
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 11:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91FCC158DC8;
	Tue, 18 Jun 2024 11:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="imfTJ0iG"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2061.outbound.protection.outlook.com [40.107.101.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEABF152DEB
	for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 11:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718710547; cv=fail; b=fZocQWrNaW+gHV+oQCicmb56/YuRnk7hKck6iZkW6cOFu1ga8wHYJaN/bQWF0LmIDijnAKV8/TD5Wwgs4XmlSs9puJ4gy4GBfzUXZXX1fmd0ZbtZJUAeAbWvpy+fN4Df9Txollpo8OOcXyKQG5wVeuS3hshrRoDmALifko6kmuA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718710547; c=relaxed/simple;
	bh=PYQuU0fEt2qbRwrzokDcs614lDrOBf/saI5lYvyPFHg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jAHyxkapb2na9oGk/G2AxYkvn+2hYBuButkOn8ypGoB3UBQEyRpD0mLaY0LfwYfUnx5JzbklCvWrcY39alervfF4iXQrJFcS7a3r0XYPEZf4hTgp+S3bqj5RcIGj1chHvDQ1V2h4GtLsVUs+S4sEeu0It7xj2BJCJu5Xjd26rLk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=imfTJ0iG; arc=fail smtp.client-ip=40.107.101.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IL1IETp1DI1a4j6z2ODX3/crhHntoozei4JThBbDBYsi0gxytm3u4UY7s/VvgQ/DCD/sGZrDFjM7FjmZEQoLq+1YYRN8WyMosbKCOk8TpXaVQeEYYzHT0L8jWdOLmYUrx89c/u4V65LNOlb52nmvIwRM9BcDoWwAV1/271BlySNNp00AS8GTfpZn5zU5bKlOK7gfH6bm+kYIIMnWCa6TKfAUN6z3DG3ehdreXd1Vay0FCFdm6op5RYesnXQITa+BR9sZLRJhaUgRXrL2EK0doAf4jizaJ+UE35pcfTfe9hgB7IN9fah7Um6lZRpVvJioLJQ/RMgvLsxAUkZZLF7iQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oPBmbr0qAyea0gDzEXJi3zXKBUcsB2B8/N4kGj9k9nI=;
 b=bzs+9j2LJLyx1zUJn7qC22/534nhTY5xH1IP2Px0Rr7gQOJ77ZInzDZ6MG4JET1eu1e00s7VKyU5mQHDgkxlyqehq5/Amz/y/J2t5tb/CAoWMuaYz1IG0fboGqAj6nWIKVoJ+dfCMYxswIbcpBrd0/ihQMV/2RBD4wNqcHsZWbLoeCho3HwiQqWBDcZm2OfIsbDwBZnJ1d7UJitiMsfhQagAAinvRKK5GLKoxe6pwwWcdZroZi0VsJd6gCg22S5EIoj4+qnz/h6jw8wWZhUYLWvLRzAq+acic+/rH3i5hdMwru2Bsio93NN6V0zWlPVP/aA/AzhaumMuiN0x/PdD3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oPBmbr0qAyea0gDzEXJi3zXKBUcsB2B8/N4kGj9k9nI=;
 b=imfTJ0iGHt6F8mNZtQFyM0rlJcPju9nraegJtG5Q8Gsc93Nd6K+6LGgj+0rV9qD0MV7O0aax+pUlOOoG6x2b/Av7U13lgBZKw2TC9xLxClgWR2d+OnaK41HPxtDXV6Ym9kcM0UFZ1h3p25y3r7s5c5KoHAvRt+3mshyIiW2u6LD6JmkdDOCig6z9Coyf3HeNTL36vuVRxZrysK7rLT8S2BVvMF85p+T1cQgZrHAI+Z3BhkIaM1N4ioYuIIcXxsuEOlfubqSZpVqPH2rzdM959Pa3de8eiW6lLzE9rnTS2sXOJHfe8OLjg+YYFrLM+Ay7CeZV9NU6TL52YN5s6pJWkA==
Received: from DM6PR06CA0039.namprd06.prod.outlook.com (2603:10b6:5:54::16) by
 CH3PR12MB8511.namprd12.prod.outlook.com (2603:10b6:610:15c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Tue, 18 Jun
 2024 11:35:43 +0000
Received: from DS3PEPF0000C37F.namprd04.prod.outlook.com
 (2603:10b6:5:54:cafe::10) by DM6PR06CA0039.outlook.office365.com
 (2603:10b6:5:54::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31 via Frontend
 Transport; Tue, 18 Jun 2024 11:35:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF0000C37F.mail.protection.outlook.com (10.167.23.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Tue, 18 Jun 2024 11:35:42 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 18 Jun
 2024 04:35:26 -0700
Received: from yaviefel.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 18 Jun
 2024 04:35:21 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "Amit
 Cohen" <amcohen@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 3/7] mlxsw: pci: Initialize page pool per CQ
Date: Tue, 18 Jun 2024 13:34:42 +0200
Message-ID: <02e5856ae7c572d4293ce6bb92c286ee6cfec800.1718709196.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37F:EE_|CH3PR12MB8511:EE_
X-MS-Office365-Filtering-Correlation-Id: b2f2b905-9a1b-4abf-ff2a-08dc8f8ac960
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|82310400023|376011|36860700010;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bgINtzUy2AE7wfrGjYrHE9ssDiVEXBsWjRihJkrPbkW6bagwqHaHxoVEqd0n?=
 =?us-ascii?Q?kOqvgIyE/QWwcV/Hmej/g+bs0C7x86rvDse7QtUmhmpwjig7v2IZo27/yiQm?=
 =?us-ascii?Q?Oyta+CDxmEOFofZxjTNxkuz4aogI2rho7dWls0T0BZ49EOdPMOmrGRgHqY8P?=
 =?us-ascii?Q?DTrbwZdNc0yCb8XW+eUK6C6CqhRawHJwnjuw/QA55x4I0/Cz1j888RatxwKs?=
 =?us-ascii?Q?XD++ItpcHO1MRqW9n2o30mXvYr/v8x3WtpoH3osSSLUIKsH/whLS6iFRTm21?=
 =?us-ascii?Q?46OlAa8HvTypEofWU0Yd3KHA9epSqrq5FqggwgZ/oiO+qDFHUwkkkzocB95F?=
 =?us-ascii?Q?4g7gHlDs5JTDufJt2b42H3PXsgA7+OLqNDkO7rq+v40bKxBoS16rTIl6YT3N?=
 =?us-ascii?Q?dwVybLj9q9AbgMoCUVjOg8uZVBVqWvxerWH3IMz+84evbCWllKXiJn8bKTmW?=
 =?us-ascii?Q?t0gpGKgKrcDgLtjQWl+O/+ixiA35JUOsfZJ+gb8feVbU20L1HzT24rhac0VZ?=
 =?us-ascii?Q?CSHwqe/MMMu1HEYb75CRIQ94DOoRaqz4iQQH3ZJIUWOB2BlbI9ET0DvQYY/i?=
 =?us-ascii?Q?9qAAAlwjVjJHd0dPzcR5SWsjvMqDW9gf8Vni/cOKzC7rshb9IN2Iej6IytDm?=
 =?us-ascii?Q?cpOF6hvdGvXBgpTqbBZAaXfQqIHTe1JeCYseHweYcOgbfe82yHOy9f39Meu7?=
 =?us-ascii?Q?sU/CUY5muFAvF2A93M6L9W5hvXntWlNuIbibhnauqw537okDtgrcWHj2lhhU?=
 =?us-ascii?Q?yDPn1YBYqCPVQdseVpDAc0v47P6WefvhZSVeQyckquIOI0qD98wNucCrDXfX?=
 =?us-ascii?Q?xHyhPyf0ntV8OeCdz7vFTs0sKm/A0uKtuo05aCu1h8723Z984ES0MUAoZRvG?=
 =?us-ascii?Q?oNw3z4rZ5IdMQpv8Necce9qvKXgC1D5prnEMBm6B4igK2MtJ3QBnJWVmGiLk?=
 =?us-ascii?Q?pefPn3Ho3d4pxJr/cBoZHcDKBYeegB8RKXxZHGR5EL9eGq/qov+T7h3DAIwr?=
 =?us-ascii?Q?xVnth1L37wk7NQZm/aqNZQLTD534GRW3ZBKCYE1yfrEekmf40PtqUq3toVW4?=
 =?us-ascii?Q?fMcm9/a9bUVj5EWznXyaO5qI0FWavNJ/2eezYC6HQelJFcD1r44CtxN1aJ0l?=
 =?us-ascii?Q?F864DhPgqvxkVaekTb8TTZOBxOHEzTW4dwnCoAYKXbhXSvY7MP/xbK+uJqYv?=
 =?us-ascii?Q?TrKRdNtJ04Whki48J8iXW+sy+nAywCynK9CaGQjnY4DJQhx06lb+PE3LkCE+?=
 =?us-ascii?Q?qpBM/839WXikX3/AUq5SpwaGhpo/fWwgRp4P1JD44NiWdZqJSlkrr4biGbkM?=
 =?us-ascii?Q?Vyi8q6vcSsCNA00AXCRo6lA7AF6PgNMeLsOSItLUaTVQgI+tAk/ysj+S6OBS?=
 =?us-ascii?Q?IDPNcegIoceF8vqT9RqUYf6zclNMVLG4k7vR8+iFZbzbBoZl0w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230037)(1800799021)(82310400023)(376011)(36860700010);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 11:35:42.5197
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2f2b905-9a1b-4abf-ff2a-08dc8f8ac960
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8511

From: Amit Cohen <amcohen@nvidia.com>

Next patch will use page pool to allocate buffers for RDQ. Initialize
page pool for each CQ, which is mapped 1:1 to RDQ. Page pool for each Rx
queue enhances Rx side performance by reclaiming buffers back to each queue
specific pool.

When only one NAPI instance is the consumer of pages from page pool, it is
recommended to pass it as part of 'page_pool_params', then page pool APIs
will be done without special locks. mlxsw driver holds NAPI instance per
CQ, so add page pool per CQ and use the existing NAPI instance.

For now, pages are not allocated from the pool, next patch will use it.

Some notes regarding 'page_pool_params':
* Use PP_FLAG_DMA_MAP to allow page pool handles DMA mapping, for now
  do not use sync flag, as only the device writes to this memory and we
  read it only when it finishes writing there. This will probably be
  changed when we will support XDP.
* Define 'order' according to maximum MTU and take into account software
  overhead. Some round up are done, which means that we allocate more pages
  than we really need. This can be improved later by using fragmented
  buffers.
* Use pool_size = MLXSW_PCI_WQE_COUNT. This will be the size of 'ptr_ring',
  and should be the maximum amount of packets that page pool will allocate
  memory for. In our case, this is the queue size, defined as
  MLXSW_PCI_WQE_COUNT.

Signed-off-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/Kconfig |  1 +
 drivers/net/ethernet/mellanox/mlxsw/pci.c   | 60 ++++++++++++++++++++-
 2 files changed, 60 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/Kconfig b/drivers/net/ethernet/mellanox/mlxsw/Kconfig
index a510bf2cff2f..74f7e27b490f 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/Kconfig
+++ b/drivers/net/ethernet/mellanox/mlxsw/Kconfig
@@ -33,6 +33,7 @@ config MLXSW_CORE_THERMAL
 config MLXSW_PCI
 	tristate "PCI bus implementation for Mellanox Technologies Switch ASICs"
 	depends on PCI && HAS_IOMEM && MLXSW_CORE
+	select PAGE_POOL
 	default m
 	help
 	  This is PCI bus implementation for Mellanox Technologies Switch ASICs.
diff --git a/drivers/net/ethernet/mellanox/mlxsw/pci.c b/drivers/net/ethernet/mellanox/mlxsw/pci.c
index 400c7af80404..045f8b77698c 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/pci.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/pci.c
@@ -13,6 +13,7 @@
 #include <linux/if_vlan.h>
 #include <linux/log2.h>
 #include <linux/string.h>
+#include <net/page_pool/helpers.h>
 
 #include "pci_hw.h"
 #include "pci.h"
@@ -88,6 +89,7 @@ struct mlxsw_pci_queue {
 			enum mlxsw_pci_cqe_v v;
 			struct mlxsw_pci_queue *dq;
 			struct napi_struct napi;
+			struct page_pool *page_pool;
 		} cq;
 		struct {
 			struct tasklet_struct tasklet;
@@ -338,6 +340,12 @@ static void mlxsw_pci_sdq_fini(struct mlxsw_pci *mlxsw_pci,
 	mlxsw_cmd_hw2sw_sdq(mlxsw_pci->core, q->num);
 }
 
+#define MLXSW_PCI_SKB_HEADROOM (NET_SKB_PAD + NET_IP_ALIGN)
+
+#define MLXSW_PCI_RX_BUF_SW_OVERHEAD		\
+		(MLXSW_PCI_SKB_HEADROOM +	\
+		SKB_DATA_ALIGN(sizeof(struct skb_shared_info)))
+
 static int mlxsw_pci_wqe_frag_map(struct mlxsw_pci *mlxsw_pci, char *wqe,
 				  int index, char *frag_data, size_t frag_len,
 				  int direction)
@@ -844,9 +852,47 @@ static void mlxsw_pci_cq_napi_teardown(struct mlxsw_pci_queue *q)
 	netif_napi_del(&q->u.cq.napi);
 }
 
+static int mlxsw_pci_cq_page_pool_init(struct mlxsw_pci_queue *q,
+				       enum mlxsw_pci_cq_type cq_type)
+{
+	struct page_pool_params pp_params = {};
+	struct mlxsw_pci *mlxsw_pci = q->pci;
+	struct page_pool *page_pool;
+	u32 max_pkt_size;
+
+	if (cq_type != MLXSW_PCI_CQ_RDQ)
+		return 0;
+
+	max_pkt_size = MLXSW_PORT_MAX_MTU + MLXSW_PCI_RX_BUF_SW_OVERHEAD;
+	pp_params.order = get_order(max_pkt_size);
+	pp_params.flags = PP_FLAG_DMA_MAP;
+	pp_params.pool_size = MLXSW_PCI_WQE_COUNT;
+	pp_params.nid = dev_to_node(&mlxsw_pci->pdev->dev);
+	pp_params.dev = &mlxsw_pci->pdev->dev;
+	pp_params.napi = &q->u.cq.napi;
+	pp_params.dma_dir = DMA_FROM_DEVICE;
+
+	page_pool = page_pool_create(&pp_params);
+	if (IS_ERR(page_pool))
+		return PTR_ERR(page_pool);
+
+	q->u.cq.page_pool = page_pool;
+	return 0;
+}
+
+static void mlxsw_pci_cq_page_pool_fini(struct mlxsw_pci_queue *q,
+					enum mlxsw_pci_cq_type cq_type)
+{
+	if (cq_type != MLXSW_PCI_CQ_RDQ)
+		return;
+
+	page_pool_destroy(q->u.cq.page_pool);
+}
+
 static int mlxsw_pci_cq_init(struct mlxsw_pci *mlxsw_pci, char *mbox,
 			     struct mlxsw_pci_queue *q)
 {
+	enum mlxsw_pci_cq_type cq_type = mlxsw_pci_cq_type(mlxsw_pci, q);
 	int i;
 	int err;
 
@@ -876,17 +922,29 @@ static int mlxsw_pci_cq_init(struct mlxsw_pci *mlxsw_pci, char *mbox,
 	err = mlxsw_cmd_sw2hw_cq(mlxsw_pci->core, mbox, q->num);
 	if (err)
 		return err;
-	mlxsw_pci_cq_napi_setup(q, mlxsw_pci_cq_type(mlxsw_pci, q));
+	mlxsw_pci_cq_napi_setup(q, cq_type);
+
+	err = mlxsw_pci_cq_page_pool_init(q, cq_type);
+	if (err)
+		goto err_page_pool_init;
+
 	napi_enable(&q->u.cq.napi);
 	mlxsw_pci_queue_doorbell_consumer_ring(mlxsw_pci, q);
 	mlxsw_pci_queue_doorbell_arm_consumer_ring(mlxsw_pci, q);
 	return 0;
+
+err_page_pool_init:
+	mlxsw_pci_cq_napi_teardown(q);
+	return err;
 }
 
 static void mlxsw_pci_cq_fini(struct mlxsw_pci *mlxsw_pci,
 			      struct mlxsw_pci_queue *q)
 {
+	enum mlxsw_pci_cq_type cq_type = mlxsw_pci_cq_type(mlxsw_pci, q);
+
 	napi_disable(&q->u.cq.napi);
+	mlxsw_pci_cq_page_pool_fini(q, cq_type);
 	mlxsw_pci_cq_napi_teardown(q);
 	mlxsw_cmd_hw2sw_cq(mlxsw_pci->core, q->num);
 }
-- 
2.45.0


