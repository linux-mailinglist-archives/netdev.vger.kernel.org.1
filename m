Return-Path: <netdev+bounces-66932-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE9C84184F
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 02:31:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6580F1F23842
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 01:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF45736AEC;
	Tue, 30 Jan 2024 01:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fEpAdgdg"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63FB364C8
	for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 01:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706578273; cv=fail; b=Air5miIx0VO36frMsw0F37/Pn51IErdIbZgsKrob+oLjf16xgUE+Jb+zxPs+e3u+O2urvHuG7wkvM3xQGQjXRtGryCEwh6oM7cW/O0/x/VNLqFR4TfCBtj+m5OqvP1NaXOERFCPGsXBtI4K8PJGDru4xSjN9P/mrhRDQMJ8nUro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706578273; c=relaxed/simple;
	bh=EpdcKkIgYPpdVeehNi4pzLnExscutvW5b09S9vOvlNQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nOWzDZNd+VhQVJszTJdWXZiSjEXEQM7wtMfFZaazdrY9uV4yr7Du89cI6PoUOwqARo3J4VzPIKDtTkY7ap8itlFvxcs7BgDMgzMzLPK0waQU9TFbFO8E1fx4OUkIv2F+m3B+3P9yH4oRRcSVeOq1112gyrihccXbKSBCCE4hR4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fEpAdgdg; arc=fail smtp.client-ip=40.107.223.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YMQiyJGJC573AlSDpl47GMRZBq5vGHoQMxOq2zgdeJ4vKuchjR9dBhl4SHyqhxDxPviQQxTbaAXNRCkVReczLEdTzkVxiH73L06vmtXtQSGy6GzPbBS2RjjMSUKnfD667zWpG/tiJYZ0tokZVA3M0RvAmYlfei7u0tNQH8Ay+luzuTQD4vu5CnHmjNyOjaHCRGRmYSgb4/h1oMRum2P76nctaRWZm0IjSt96MGMBeBYcdj3Nkfn2G6EySajPJAqbSiF+PXQBPJV7enihhh8GqlVRcx8SafmTTyi5ptm0uSQEFVOunw0di7MNV4rTPrXjQDEVK4nL6kESiEGzCPdfdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ezuKt1xTbJvXbixYp+Qutaxtz5PU0IPIJB3Ny0uipY=;
 b=N+C6p0pFV5B1woMwGuO9cYfZBdiJnR843SQLQKh6I9BtmP1X4hVmwfMRzDNEPXS24KFxkGz5AGc7yOvR/2vKKEryinhynyOUwDK7L9eNIyLvD+l5DckWYtpwcluVz3XtMzTbjnyhFdhwOlC36QSDjg9hPKm7fmW3Y5mAy8mOblw5BFfHKse0l0o4m7KJZ9eHMAI3jO7FFbIICWqzmSDLFUmz6EqQOXH+9byJ81/Onpsv9SuLRCqNXRxqbzR3j7TRLcKwKaiaPSWAHW2EdQYdfKgwwIGgf02GLn9WavHtdE++Ymc5v1aUA5fMhXK6Qf7VxXWnzq0+gTM3hphdW3iVyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ezuKt1xTbJvXbixYp+Qutaxtz5PU0IPIJB3Ny0uipY=;
 b=fEpAdgdgXsUOu76z45lGL7uK2Vxc9Yt79TM2JLrW3skUtAVWtLgC6FWMf5jipDFSr/YAPV6d+xLOehORkzsSqkBFYehdTaZa7E5ZM5i0D03pslTITRFs5KMVFK7PoN2F4Zn1jf+Z88I5pOcxxPepekQiztjATTXmspoKDPYsVKw=
Received: from MN2PR14CA0009.namprd14.prod.outlook.com (2603:10b6:208:23e::14)
 by SA1PR12MB6728.namprd12.prod.outlook.com (2603:10b6:806:257::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Tue, 30 Jan
 2024 01:31:07 +0000
Received: from MN1PEPF0000F0E5.namprd04.prod.outlook.com
 (2603:10b6:208:23e:cafe::cd) by MN2PR14CA0009.outlook.office365.com
 (2603:10b6:208:23e::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34 via Frontend
 Transport; Tue, 30 Jan 2024 01:31:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E5.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Tue, 30 Jan 2024 01:31:07 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 29 Jan
 2024 19:31:05 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH net-next 5/9] ionic: Add XDP packet headroom
Date: Mon, 29 Jan 2024 17:30:38 -0800
Message-ID: <20240130013042.11586-6-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240130013042.11586-1-shannon.nelson@amd.com>
References: <20240130013042.11586-1-shannon.nelson@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E5:EE_|SA1PR12MB6728:EE_
X-MS-Office365-Filtering-Correlation-Id: 825e5987-30ee-4990-aa0c-08dc213321d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NX5f4RXGXfLkrw6HhVSH38PGuYez9Odq4g17mBs1x9bKa/ylL8opiamPDRUWveW/yf043IL+7jsebCau73cWAXACPNwWNHHhrj/5HjDCUopcC0podPIT2ZUMSZjq4B66LKaAVS86ESVPtf4Vx/Vt6WlScDEaZG9vtpEkYrNje/6uakKfiVrekizFQrCCQoQWV1A0GF19El67n5ZdRxePM+IDOCk9Ul5TRCr2lJ9jA4qkgz62PVx5zJUnXqFCgo49xRZBgiL+fIqa1lFbf2seARcuHQk7XcDWrzNBghdfQQw4piOOOr1Lr49WsiGarpn3Of2duhveJDKUBLD05CgvDjgOIQtoNOOaEtJhxBQrkWAdt+DE8dv4CwUsgLM21QFmSn4c7VulCidSqdSgeLiwOUFYQv9Vcvsb/M0+JkZaKcaDgJTCohBmf0bDs0jtoybgdGleIzt0sNxftKzSol9dHAxeGfN/jHhz2Ev/aF7z78byhDe2YDYLbelYbzNU/9Jd2LWrl2fNEsEPR1Lu+hXMoS5ofmoX5ZRJ8HG6gW2zhIigrHY7OUbGaFXtjXbSE+JyiS16vONTPOqMy0EpLVhBw3ges6FZInwQ8OLhs4dpN/2hufGXHbNvQYHN5GxLEpxaBVOfIbWtnco++OAMB+BG49KzI/t6gg2NYpGhD6u0w6Ryqw5LsWtyWMZMnZbqjXYVkctOc5VxccxYByc2ExCbPTxMbgkMCH6hAbqBV97zMRhXzDqNtye5CwBa7YKUG7DFNB32B+9ZUG0qt5WdEzGhxQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(39860400002)(346002)(136003)(230922051799003)(451199024)(1800799012)(186009)(82310400011)(64100799003)(40470700004)(36840700001)(46966006)(83380400001)(426003)(1076003)(16526019)(6666004)(336012)(26005)(36860700001)(2616005)(47076005)(8936002)(5660300002)(81166007)(4326008)(8676002)(41300700001)(44832011)(2906002)(478600001)(110136005)(54906003)(316002)(70206006)(70586007)(36756003)(86362001)(82740400003)(356005)(40480700001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 01:31:07.4154
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 825e5987-30ee-4990-aa0c-08dc213321d5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6728

If an xdp program is loaded, add headroom at the beginning
of the frame to allow for editing and insertions that an XDP
program might need room for, and tailroom used later for XDP
frame tracking.  These are only needed in the first Rx buffer
in a packet, not for any trailing frags.

Co-developed-by: Brett Creeley <brett.creeley@amd.com>
Signed-off-by: Brett Creeley <brett.creeley@amd.com>
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 .../net/ethernet/pensando/ionic/ionic_txrx.c  | 67 ++++++++++++-------
 1 file changed, 44 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
index 07a17be94d4d..072a9e376b39 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
@@ -189,7 +189,9 @@ static bool ionic_rx_buf_recycle(struct ionic_queue *q,
 
 static struct sk_buff *ionic_rx_frags(struct ionic_queue *q,
 				      struct ionic_desc_info *desc_info,
-				      struct ionic_rxq_comp *comp)
+				      unsigned int headroom,
+				      unsigned int len,
+				      unsigned int num_sg_elems)
 {
 	struct net_device *netdev = q->lif->netdev;
 	struct ionic_buf_info *buf_info;
@@ -198,12 +200,10 @@ static struct sk_buff *ionic_rx_frags(struct ionic_queue *q,
 	struct sk_buff *skb;
 	unsigned int i;
 	u16 frag_len;
-	u16 len;
 
 	stats = q_to_rx_stats(q);
 
 	buf_info = &desc_info->bufs[0];
-	len = le16_to_cpu(comp->len);
 
 	prefetchw(buf_info->page);
 
@@ -215,22 +215,25 @@ static struct sk_buff *ionic_rx_frags(struct ionic_queue *q,
 		return NULL;
 	}
 
-	i = comp->num_sg_elems + 1;
+	i = num_sg_elems + 1;
 	do {
 		if (unlikely(!buf_info->page)) {
 			dev_kfree_skb(skb);
 			return NULL;
 		}
 
-		frag_len = min_t(u16, len, ionic_rx_buf_size(buf_info));
+		if (headroom)
+			frag_len = min_t(u16, len, IONIC_XDP_MAX_LINEAR_MTU + VLAN_ETH_HLEN);
+		else
+			frag_len = min_t(u16, len, ionic_rx_buf_size(buf_info));
 		len -= frag_len;
 
 		dma_sync_single_range_for_cpu(dev, ionic_rx_buf_pa(buf_info),
-					      0, frag_len, DMA_FROM_DEVICE);
+					      headroom, frag_len, DMA_FROM_DEVICE);
 
 		skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
-				buf_info->page, buf_info->page_offset, frag_len,
-				IONIC_PAGE_SIZE);
+				buf_info->page, buf_info->page_offset + headroom,
+				frag_len, IONIC_PAGE_SIZE);
 
 		if (!ionic_rx_buf_recycle(q, buf_info, frag_len)) {
 			dma_unmap_page(dev, buf_info->dma_addr,
@@ -238,6 +241,10 @@ static struct sk_buff *ionic_rx_frags(struct ionic_queue *q,
 			buf_info->page = NULL;
 		}
 
+		/* only needed on the first buffer */
+		if (headroom)
+			headroom = 0;
+
 		buf_info++;
 
 		i--;
@@ -248,19 +255,18 @@ static struct sk_buff *ionic_rx_frags(struct ionic_queue *q,
 
 static struct sk_buff *ionic_rx_copybreak(struct ionic_queue *q,
 					  struct ionic_desc_info *desc_info,
-					  struct ionic_rxq_comp *comp)
+					  unsigned int headroom,
+					  unsigned int len)
 {
 	struct net_device *netdev = q->lif->netdev;
 	struct ionic_buf_info *buf_info;
 	struct ionic_rx_stats *stats;
 	struct device *dev = q->dev;
 	struct sk_buff *skb;
-	u16 len;
 
 	stats = q_to_rx_stats(q);
 
 	buf_info = &desc_info->bufs[0];
-	len = le16_to_cpu(comp->len);
 
 	skb = napi_alloc_skb(&q_to_qcq(q)->napi, len);
 	if (unlikely(!skb)) {
@@ -276,10 +282,10 @@ static struct sk_buff *ionic_rx_copybreak(struct ionic_queue *q,
 	}
 
 	dma_sync_single_range_for_cpu(dev, ionic_rx_buf_pa(buf_info),
-				      0, len, DMA_FROM_DEVICE);
-	skb_copy_to_linear_data(skb, ionic_rx_buf_va(buf_info), len);
+				      headroom, len, DMA_FROM_DEVICE);
+	skb_copy_to_linear_data(skb, ionic_rx_buf_va(buf_info) + headroom, len);
 	dma_sync_single_range_for_device(dev, ionic_rx_buf_pa(buf_info),
-					 0, len, DMA_FROM_DEVICE);
+					 headroom, len, DMA_FROM_DEVICE);
 
 	skb_put(skb, len);
 	skb->protocol = eth_type_trans(skb, q->lif->netdev);
@@ -303,10 +309,10 @@ static bool ionic_run_xdp(struct ionic_rx_stats *stats,
 
 	xdp_init_buff(&xdp_buf, IONIC_PAGE_SIZE, rxq->xdp_rxq_info);
 	xdp_prepare_buff(&xdp_buf, ionic_rx_buf_va(buf_info),
-			 0, len, false);
+			 XDP_PACKET_HEADROOM, len, false);
 
 	dma_sync_single_range_for_cpu(rxq->dev, ionic_rx_buf_pa(buf_info),
-				      0, len,
+				      XDP_PACKET_HEADROOM, len,
 				      DMA_FROM_DEVICE);
 
 	prefetchw(&xdp_buf.data_hard_start);
@@ -344,6 +350,7 @@ static void ionic_rx_clean(struct ionic_queue *q,
 	struct ionic_qcq *qcq = q_to_qcq(q);
 	struct ionic_rx_stats *stats;
 	struct ionic_rxq_comp *comp;
+	unsigned int headroom;
 	struct sk_buff *skb;
 	u16 len;
 
@@ -363,10 +370,11 @@ static void ionic_rx_clean(struct ionic_queue *q,
 	if (ionic_run_xdp(stats, netdev, q, desc_info->bufs, len))
 		return;
 
+	headroom = q->xdp_rxq_info ? XDP_PACKET_HEADROOM : 0;
 	if (len <= q->lif->rx_copybreak)
-		skb = ionic_rx_copybreak(q, desc_info, comp);
+		skb = ionic_rx_copybreak(q, desc_info, headroom, len);
 	else
-		skb = ionic_rx_frags(q, desc_info, comp);
+		skb = ionic_rx_frags(q, desc_info, headroom, len, comp->num_sg_elems);
 
 	if (unlikely(!skb)) {
 		stats->dropped++;
@@ -490,8 +498,9 @@ void ionic_rx_fill(struct ionic_queue *q)
 	unsigned int frag_len;
 	unsigned int nfrags;
 	unsigned int n_fill;
-	unsigned int i, j;
 	unsigned int len;
+	unsigned int i;
+	unsigned int j;
 
 	n_fill = ionic_q_space_avail(q);
 
@@ -500,9 +509,12 @@ void ionic_rx_fill(struct ionic_queue *q)
 	if (n_fill < fill_threshold)
 		return;
 
-	len = netdev->mtu + ETH_HLEN + VLAN_HLEN;
+	len = netdev->mtu + VLAN_ETH_HLEN;
 
 	for (i = n_fill; i; i--) {
+		unsigned int headroom;
+		unsigned int buf_len;
+
 		nfrags = 0;
 		remain_len = len;
 		desc_info = &q->info[q->head_idx];
@@ -517,9 +529,18 @@ void ionic_rx_fill(struct ionic_queue *q)
 			}
 		}
 
-		/* fill main descriptor - buf[0] */
-		desc->addr = cpu_to_le64(ionic_rx_buf_pa(buf_info));
-		frag_len = min_t(u16, len, ionic_rx_buf_size(buf_info));
+		/* fill main descriptor - buf[0]
+		 * XDP uses space in the first buffer, so account for
+		 * head room, tail room, and ip header in the first frag size.
+		 */
+		headroom = q->xdp_rxq_info ? XDP_PACKET_HEADROOM : 0;
+		if (q->xdp_rxq_info)
+			buf_len = IONIC_XDP_MAX_LINEAR_MTU + VLAN_ETH_HLEN;
+		else
+			buf_len = ionic_rx_buf_size(buf_info);
+		frag_len = min_t(u16, len, buf_len);
+
+		desc->addr = cpu_to_le64(ionic_rx_buf_pa(buf_info) + headroom);
 		desc->len = cpu_to_le16(frag_len);
 		remain_len -= frag_len;
 		buf_info++;
-- 
2.17.1


