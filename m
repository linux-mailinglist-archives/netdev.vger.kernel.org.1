Return-Path: <netdev+bounces-139135-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E0C9B05C7
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 16:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5FD81C225D1
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 14:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D095020BB21;
	Fri, 25 Oct 2024 14:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CWX3h9zi"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB9BB1632C0
	for <netdev@vger.kernel.org>; Fri, 25 Oct 2024 14:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729866440; cv=fail; b=fXMTNyfwI4vmS/TUgygv5PNtz5QEJPvJNP1NMf8wZTxrJvZi0uPZECbEUX/q2cTvhJP1XgOLd5P5tS1NlfNDAMuaapHuRtu4H2EBqZRp91FTkaXhydzDtwMYhgsE7XcNNMkB/OcTvb7C7Dh/1JD63CLQodLKe5JvvNecrSnelvk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729866440; c=relaxed/simple;
	bh=6FWInSkyAZM1EaiCbIjK9xCC9i//zsc1EzmPApLjxsk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jLDXfOyLl6xZY/dFRr6ll+c5SVlA62eNmSZR9Uyo8PBMYtZk6mb/JUqjYCWwUJK4SnXeaL0VN5uwxHv/J9HyNEGRKN8Bn1B5zwMFj4H3lnk22VfCgtgw+yOIHD3y8LZjNkby0XGQx5/60aZjd3UdeuwGmEwYiq0sSBHMgl0VPpc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CWX3h9zi; arc=fail smtp.client-ip=40.107.94.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NHISJt1Q9e1gA05L4dKnw2smbe6JP/ONQ8tFO/lfHKGLMG8b6xRjXDH3h3UXWjQP2w2Lt530ulyCUDuZVutDcZtwlHQRK+9TforJ8FZWbD2tNiQCT8qlLIOyi5XCsOUO2bEUi6iSjwzCLopUl2RhxmxandKMrXLLsFRs2MxVY5nybt8DTqh61xx8Zt6JN61T35axYJm2e/UviIt6Nc8oILFZapOagZXM+e1CitbeoF50fjntistJsc6IF/hYSGC56ABlVtvKCyYd/z6selKxdFJ3HEC/HdSrEpnmNsip+Wch1eGiwtuYNCDnx3GSHXV+v1GAPDlPcGBtnPOb43qa6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2PAdiw2GZ1bcQCyrPqMubPlWkkty7jB/5Mxdmhh2D64=;
 b=N6YZ4dix/+Br6ILCKY1xFLGhC8GwaY9j4n9IQpYx7tGMasIoyOWKAkr/YMh1iNOhW6EPARBupodUM2mHHcuh44unWfrcqKhhTdm0Q5pkdqQkf7WLgYALMMso6i5XvinLfHfirNQReUV063ue22jVWPQe36EHQDLvX4dPHPRm52DRx1IdrOAn7TCkrQv0Q05Jml/2NaLKKPC9om0OmNTNQmg5I/lNfSYKu8jR0eGD83IC9t7ehgM6OeMNZ3hf/u91Z8x91YDiIDdh38KPfJdlFuI5R0ikl9DnPRY0PNVDq6Gyq3pRYThRC0omnNX6hreoZyen+/01he8CVRWjF0pzOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2PAdiw2GZ1bcQCyrPqMubPlWkkty7jB/5Mxdmhh2D64=;
 b=CWX3h9zinYhft6Cd3o7uXE64s0Oz5Oejr30Y0FpfvyG+782UXYDN1/M2r3Atb0EU36RVyYZ2N9HkuHV+BiU+fOZDpISH313g9LGSuhF15WGaaJ+ELF6ovOV97WKwnTc4I/ld4Sf1S2M4cDC1kMFDGSt4sBPD8Ib5KZ3Ho+9GwcjUL+OOaQqDT73rBuBYLsSJkaISsRis8PwRNAZPNYSoHWb5TB5TbEKQ7rA2HqsHW1W4Tk645VgvyMJiwdDQwEaoNbIcwpmONDKLerY5vlt9g+kTB292I1HP3AuYagWVS53od63hV6pwHHkfziMkL/4K3djY1QRqxreKhWaRUkaJEQ==
Received: from BL1P222CA0002.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::7)
 by DS0PR12MB7899.namprd12.prod.outlook.com (2603:10b6:8:149::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.20; Fri, 25 Oct
 2024 14:27:15 +0000
Received: from BL6PEPF0001AB58.namprd02.prod.outlook.com
 (2603:10b6:208:2c7:cafe::fd) by BL1P222CA0002.outlook.office365.com
 (2603:10b6:208:2c7::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18 via Frontend
 Transport; Fri, 25 Oct 2024 14:27:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB58.mail.protection.outlook.com (10.167.241.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.14 via Frontend Transport; Fri, 25 Oct 2024 14:27:14 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 25 Oct
 2024 07:27:03 -0700
Received: from fedora.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 25 Oct
 2024 07:26:58 -0700
From: Petr Machata <petrm@nvidia.com>
To: <netdev@vger.kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Danielle Ratson <danieller@nvidia.com>, Petr Machata
	<petrm@nvidia.com>, Ido Schimmel <idosch@nvidia.com>, Amit Cohen
	<amcohen@nvidia.com>, <mlxsw@nvidia.com>, Jiri Pirko <jiri@resnulli.us>
Subject: [PATCH net 2/5] mlxsw: pci: Sync Rx buffers for CPU
Date: Fri, 25 Oct 2024 16:26:26 +0200
Message-ID: <461486fac91755ca4e04c2068c102250026dcd0b.1729866134.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1729866134.git.petrm@nvidia.com>
References: <cover.1729866134.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB58:EE_|DS0PR12MB7899:EE_
X-MS-Office365-Filtering-Correlation-Id: 40a416bf-93fa-42ea-e355-08dcf5011f67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9EHSnWwe9eGPMpY440CiGPs4dbwrJ0KepQfoX5Yz5M9LVBDS3GpHqtMyyyqw?=
 =?us-ascii?Q?hrBukPit0c6Ze2/HFJBmR0UEVkA2I4swJ5UElQTpbQ6j7eVV4oFn5Y3wqilq?=
 =?us-ascii?Q?JrF9K36skBVXBwP+khTaauTmRVo5eWMART+SF8n58v4M07PKTFkCzU9oXecF?=
 =?us-ascii?Q?coRT4556rS9y0zU1TjIxxI2rz8PeATbwJRw9JX3z/fxbVUKSrqEPY0PoPN43?=
 =?us-ascii?Q?Fv6GEI662CmansqkGDDdsBDyiTlu5Kgbf8681ThGIj4LKr3td3Vg/YxsLGuF?=
 =?us-ascii?Q?wmPsIQLgHRTEDylHGy4oB9G59sKXOuIemUJiqHbXWRSSnYiiD+CDLER1egIr?=
 =?us-ascii?Q?IR5LmW0SbbRV9NXqCq/GQo6uZrd1yf7adnzJtLTgl2Co3EPmCm7ZWyKXzdPt?=
 =?us-ascii?Q?wFj7eUfVghqk6kKjrWUoVyCM7yvVbXnGsxc3wkHjQNYTvvPdzq19gxcm8GTH?=
 =?us-ascii?Q?jxfTVcBI4ZQSZlKOGy8s0YcAZA1rSkU67fF90oPPSUQln20/dkiPfiBJlsCm?=
 =?us-ascii?Q?BCnlSds58IYPhmHNnXAi25izpSuGGJPHTFzswOPg5s+wYDw0+F3CYgMWDhwG?=
 =?us-ascii?Q?FziWZmNj9w/V7CkWSTzR91eelk72RPN+9ZgxfxTY3HHyxRXR/qjEB8CRtv1z?=
 =?us-ascii?Q?ITZKFd0dG6HUz666arGghLmWYLPOmWsh1weESOtb+4nuDTj2v61YzTZ2leEj?=
 =?us-ascii?Q?YXr7Mijz8nzMrqgBAra0SHjNuWACvQu1nW0bCCjWVhxv7640BTg/JDai2Uqr?=
 =?us-ascii?Q?DYpfnTyAyXihzYYaQfWI4J8h+NHvX5uQa8x7Pp5UAun3BFJz9WL16B/lb1J6?=
 =?us-ascii?Q?DHZRK3fu5Ot8jJxaJW05c6GFNe54DufBFe4s3xmUlFkREPBySF7QVhIR4b8g?=
 =?us-ascii?Q?VZq3fcEX0/rAhuPjxFxwufSLpD0pfLTllz1CJoF5hhB9DwscAJFYuU46uIQA?=
 =?us-ascii?Q?uTfRv5Y8fV47Hn/clYIPWBh6SuV3Kto46aZa7BjLjKnNvJFkDztU5aX1NZRu?=
 =?us-ascii?Q?FeqKnL4rl+EvZiMO6Y0U4iwGuDu2HeJtWNwg5d0sFD3E0jwomKDWBvrSe1eM?=
 =?us-ascii?Q?DC9I0/5jBBD0fxbJQVvz+Rh75jGABsiptB6zXxDHK5FLksSz1EuUJz+KIRX+?=
 =?us-ascii?Q?AE1OToDjkq9nE7CY1+Z9ByWzcHADV4U6fJUjEUA7tY0RA50c3HntN60JIgck?=
 =?us-ascii?Q?7zjEpnUO2BKiKC45PwhutgzrGcgc8t1MrBt/2uiG9HeI/xb8bYeXfHr15+PB?=
 =?us-ascii?Q?IsrmKfLVK2sXC0O4ZH0837MFoEbVBq9xSoAvtnOHyoqpe8GwfrfScyLJOHfK?=
 =?us-ascii?Q?9tRTQ88sG+P+6084uSlNtE+4puiGQD6LbRyuZ5EggV8DUGUPFB49UbWkR8hC?=
 =?us-ascii?Q?rnGmeH/WAs1iKWJA9TeLAPIaQ1BjptVBUQklQ8OzcbmRCF6cuQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 14:27:14.8567
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 40a416bf-93fa-42ea-e355-08dcf5011f67
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB58.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7899

From: Amit Cohen <amcohen@nvidia.com>

When Rx packet is received, drivers should sync the pages for CPU, to
ensure the CPU reads the data written by the device and not stale
data from its cache.

Add the missing sync call in Rx path, sync the actual length of data for
each fragment.

Cc: Jiri Pirko <jiri@resnulli.us>
Fixes: b5b60bb491b2 ("mlxsw: pci: Use page pool for Rx buffers allocation")
Signed-off-by: Amit Cohen <amcohen@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/pci.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/pci.c b/drivers/net/ethernet/mellanox/mlxsw/pci.c
index 060e5b939211..2320a5f323b4 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/pci.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/pci.c
@@ -389,15 +389,27 @@ static void mlxsw_pci_wqe_frag_unmap(struct mlxsw_pci *mlxsw_pci, char *wqe,
 	dma_unmap_single(&pdev->dev, mapaddr, frag_len, direction);
 }
 
-static struct sk_buff *mlxsw_pci_rdq_build_skb(struct page *pages[],
+static struct sk_buff *mlxsw_pci_rdq_build_skb(struct mlxsw_pci_queue *q,
+					       struct page *pages[],
 					       u16 byte_count)
 {
+	struct mlxsw_pci_queue *cq = q->u.rdq.cq;
 	unsigned int linear_data_size;
+	struct page_pool *page_pool;
 	struct sk_buff *skb;
 	int page_index = 0;
 	bool linear_only;
 	void *data;
 
+	linear_only = byte_count + MLXSW_PCI_RX_BUF_SW_OVERHEAD <= PAGE_SIZE;
+	linear_data_size = linear_only ? byte_count :
+					 PAGE_SIZE -
+					 MLXSW_PCI_RX_BUF_SW_OVERHEAD;
+
+	page_pool = cq->u.cq.page_pool;
+	page_pool_dma_sync_for_cpu(page_pool, pages[page_index],
+				   MLXSW_PCI_SKB_HEADROOM, linear_data_size);
+
 	data = page_address(pages[page_index]);
 	net_prefetch(data);
 
@@ -405,11 +417,6 @@ static struct sk_buff *mlxsw_pci_rdq_build_skb(struct page *pages[],
 	if (unlikely(!skb))
 		return ERR_PTR(-ENOMEM);
 
-	linear_only = byte_count + MLXSW_PCI_RX_BUF_SW_OVERHEAD <= PAGE_SIZE;
-	linear_data_size = linear_only ? byte_count :
-					 PAGE_SIZE -
-					 MLXSW_PCI_RX_BUF_SW_OVERHEAD;
-
 	skb_reserve(skb, MLXSW_PCI_SKB_HEADROOM);
 	skb_put(skb, linear_data_size);
 
@@ -425,6 +432,7 @@ static struct sk_buff *mlxsw_pci_rdq_build_skb(struct page *pages[],
 
 		page = pages[page_index];
 		frag_size = min(byte_count, PAGE_SIZE);
+		page_pool_dma_sync_for_cpu(page_pool, page, 0, frag_size);
 		skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
 				page, 0, frag_size, PAGE_SIZE);
 		byte_count -= frag_size;
@@ -760,7 +768,7 @@ static void mlxsw_pci_cqe_rdq_handle(struct mlxsw_pci *mlxsw_pci,
 	if (err)
 		goto out;
 
-	skb = mlxsw_pci_rdq_build_skb(pages, byte_count);
+	skb = mlxsw_pci_rdq_build_skb(q, pages, byte_count);
 	if (IS_ERR(skb)) {
 		dev_err_ratelimited(&pdev->dev, "Failed to build skb for RDQ\n");
 		mlxsw_pci_rdq_pages_recycle(q, pages, num_sg_entries);
-- 
2.45.0


