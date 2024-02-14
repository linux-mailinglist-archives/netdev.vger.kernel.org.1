Return-Path: <netdev+bounces-71791-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CAB5855181
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 19:07:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE825B2D0FE
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 18:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F218A12AAC2;
	Wed, 14 Feb 2024 17:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fD24xL1x"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2058.outbound.protection.outlook.com [40.107.92.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD46129A9F
	for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 17:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707933576; cv=fail; b=o93GInE2U+Mm0ngE8kwjRPwkE3+1DCwSL9z5oVN7mMuF7do76MfqKTT8ayPvwwz56c9P1iutA8q6GRgraJ3MUYPgTylfq98f1Kwlta6TRCTtMCUeeV29zx+0sJNamiWc5TEHrU1j+J8/vSNclcQK8gfsRYMr40XGbNKcWzfM2og=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707933576; c=relaxed/simple;
	bh=WZ8WewXVvK6s+LDiNYUv50k4FkyqyltBwsV6TCVUeVQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P3SqdRTA7pyJBQPbLszsbccj3niRT9WgQ5lNzbAQd06LjZFHH4bB4stbCKm6Vs+Buhsdeosr1qkVvhI5WtKYju926nTBZfuNCeuTTWdeaCzg1VvbLUdGZvZ0Db0vencjQEneD1oe49qWKaHl7/uJ5MqBR/3w0KqbyLuAPGw6lQs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fD24xL1x; arc=fail smtp.client-ip=40.107.92.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z5YDhwyTSlmWzHjyW9cA8s7ZYO6pA1E+tQk6Y66S2bXfnDycnpsfYDYBEqE90N0HnqzDw0cLmOW+Imz6tIThpiH518aebg+Gg21pLkHI7D8V3zyKeI6WjTXtrwu0oMycKVSZRh6pDW/H0IHmGGCn0vidN1uaNI1LWbOpKqQUuL5nEtI5+zw4RiPjNwX7GgnrIwOfO+s3FAiOEhaTXvH/MfTtUAcrGKlf73eq7svaYBH46wm6U5zSeAfBQVpZCaTsPuUPZc13VCrd74z1vLs7b/xm8bJd9oZrPr+ldkbwenNlkVYPJh066QthUWtzE19ngs5GasEqyKVDGid9IB+2nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GqL7s+fJxchqk4+g2GyyNcCaOThEMhgA3cJmbs6LGds=;
 b=bBvDg2N6GGbQfuuqG4nbAfX4M7CzCxTDA6PE2oLWU0Kf2TQELX4EYjyZ/sSAKCB38u19y8XtMyL+CYOwLOCt6nPcgOh98ZVbAdpw6132/nnYj6IlAQ8xMuuyLfskEq7nWSBDbttb8654tnzyaYELIOWce7oPuFC/Je/2524//QrwLxM0YfHiZbOZmZJiLA/zhqHTwhDFqa/13aKUizZE1WIBgU4335vSshYgo9JJiKKsvCk4dcTul24oq6Nd09vBYC9gM14ddEp31FEq5ZYR/gKvAPH9TqXVpub0OKxZOLNGFTuBw5wdyWWbgLXmqZCHRUbhJwruNaBzxk9iNLnVjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GqL7s+fJxchqk4+g2GyyNcCaOThEMhgA3cJmbs6LGds=;
 b=fD24xL1xjojtksDvqVb+uiruzHFBX5/kG4zyaeC7zD4AMtGWi78JMhU0CB9s/LOoQAbCOxdiPITdSLASTNyebAi64Llok1CwxeZYnFCl97W60jVfjvkK3Eu7CyDfQj2KsDsh/aM4/bSEogUUWf/Ozo0IlDZXX+yh0AIv7zdyAF8=
Received: from BL0PR01CA0008.prod.exchangelabs.com (2603:10b6:208:71::21) by
 IA0PR12MB7652.namprd12.prod.outlook.com (2603:10b6:208:434::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.28; Wed, 14 Feb 2024 17:59:31 +0000
Received: from BL6PEPF0001AB75.namprd02.prod.outlook.com
 (2603:10b6:208:71:cafe::d7) by BL0PR01CA0008.outlook.office365.com
 (2603:10b6:208:71::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.40 via Frontend
 Transport; Wed, 14 Feb 2024 17:59:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB75.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Wed, 14 Feb 2024 17:59:31 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 14 Feb
 2024 11:59:30 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH v4 net-next 5/9] ionic: Add XDP packet headroom
Date: Wed, 14 Feb 2024 09:59:05 -0800
Message-ID: <20240214175909.68802-6-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240214175909.68802-1-shannon.nelson@amd.com>
References: <20240214175909.68802-1-shannon.nelson@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB75:EE_|IA0PR12MB7652:EE_
X-MS-Office365-Filtering-Correlation-Id: 357332af-999a-445a-b7e7-08dc2d86b21f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	AY4HPab5He2CSpF6KSmxM8tWnGWGd9u8VXOeBE/YhLH5AD/j9vE5NvnlOAcNNbnZXhwTzY4cSsmi8A8l2jAjf2i4kez2GOEGiPd5Q9RynMqrjyzCRJfGSo3cVqzBHqYBOV1dpqXt3mixSqSn8dpY4BlZiIj7Bc0XRIDI4+xIHlxuwrWyUiqZS0imnWZBjcsKZHwtHTjTyhVlOu0OIWaimmGhELljc9z3PTlVrsMMKhD2QH6VPYWoBQQukj+JQzfR9yp5Ssx6UKPdY9f4l4ZGMa8FaGLq/P1RP9qJb/XEmVTbrh/M7+H4jy+eU/SZDHieV6UTZmmGxS3FYiaKgfx9rr45nt40VySOt0IsjR85SqgJkeKP7zB0X5k9AjLpoLR2y5/kwpHCsh5rKlk3WucJvbkl8bXPqbzHSfpRv6Zy28K+0r3g6ileItqKKHuzjqV1g/VQoo8a/c9GEY8SNGuY+IsV8a7iI82C2WyTyfRWFjoyjxfoqFUEo43/R45dDUCq8ULutf1nbErkXYk7zViKoztN5jbfeghtfDYPthRcoV0cMrcA53BTgw9Oyo/kKOV0iSZCUum99t9Ti2mvcb0TAFG9I0SUp3ci1AwjLeHU4fE=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(376002)(136003)(39860400002)(230922051799003)(64100799003)(186009)(1800799012)(82310400011)(451199024)(46966006)(40470700004)(36840700001)(478600001)(41300700001)(4326008)(44832011)(2906002)(5660300002)(8676002)(8936002)(70206006)(110136005)(6666004)(54906003)(316002)(83380400001)(2616005)(70586007)(82740400003)(336012)(426003)(356005)(86362001)(81166007)(26005)(16526019)(1076003)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 17:59:31.6746
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 357332af-999a-445a-b7e7-08dc2d86b21f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB75.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7652

If an xdp program is loaded, add headroom at the beginning
of the frame to allow for editing and insertions that an XDP
program might need room for, and tailroom used later for XDP
frame tracking.  These are only needed in the first Rx buffer
in a packet, not for any trailing frags.

Co-developed-by: Brett Creeley <brett.creeley@amd.com>
Signed-off-by: Brett Creeley <brett.creeley@amd.com>
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 .../net/ethernet/pensando/ionic/ionic_txrx.c  | 68 ++++++++++++-------
 1 file changed, 45 insertions(+), 23 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
index 8a85f846107d..88d4306f013b 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
@@ -189,7 +189,9 @@ static bool ionic_rx_buf_recycle(struct ionic_queue *q,
 
 static struct sk_buff *ionic_rx_frags(struct ionic_queue *q,
 				      struct ionic_desc_info *desc_info,
-				      struct ionic_rxq_comp *comp,
+				      unsigned int headroom,
+				      unsigned int len,
+				      unsigned int num_sg_elems,
 				      bool synced)
 {
 	struct net_device *netdev = q->lif->netdev;
@@ -199,12 +201,10 @@ static struct sk_buff *ionic_rx_frags(struct ionic_queue *q,
 	struct sk_buff *skb;
 	unsigned int i;
 	u16 frag_len;
-	u16 len;
 
 	stats = q_to_rx_stats(q);
 
 	buf_info = &desc_info->bufs[0];
-	len = le16_to_cpu(comp->len);
 
 	prefetchw(buf_info->page);
 
@@ -216,23 +216,26 @@ static struct sk_buff *ionic_rx_frags(struct ionic_queue *q,
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
 
 		if (!synced)
 			dma_sync_single_range_for_cpu(dev, ionic_rx_buf_pa(buf_info),
-						      0, frag_len, DMA_FROM_DEVICE);
+						      headroom, frag_len, DMA_FROM_DEVICE);
 
 		skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
-				buf_info->page, buf_info->page_offset, frag_len,
-				IONIC_PAGE_SIZE);
+				buf_info->page, buf_info->page_offset + headroom,
+				frag_len, IONIC_PAGE_SIZE);
 
 		if (!ionic_rx_buf_recycle(q, buf_info, frag_len)) {
 			dma_unmap_page(dev, buf_info->dma_addr,
@@ -240,6 +243,10 @@ static struct sk_buff *ionic_rx_frags(struct ionic_queue *q,
 			buf_info->page = NULL;
 		}
 
+		/* only needed on the first buffer */
+		if (headroom)
+			headroom = 0;
+
 		buf_info++;
 
 		i--;
@@ -250,7 +257,8 @@ static struct sk_buff *ionic_rx_frags(struct ionic_queue *q,
 
 static struct sk_buff *ionic_rx_copybreak(struct ionic_queue *q,
 					  struct ionic_desc_info *desc_info,
-					  struct ionic_rxq_comp *comp,
+					  unsigned int headroom,
+					  unsigned int len,
 					  bool synced)
 {
 	struct net_device *netdev = q->lif->netdev;
@@ -258,12 +266,10 @@ static struct sk_buff *ionic_rx_copybreak(struct ionic_queue *q,
 	struct ionic_rx_stats *stats;
 	struct device *dev = q->dev;
 	struct sk_buff *skb;
-	u16 len;
 
 	stats = q_to_rx_stats(q);
 
 	buf_info = &desc_info->bufs[0];
-	len = le16_to_cpu(comp->len);
 
 	skb = napi_alloc_skb(&q_to_qcq(q)->napi, len);
 	if (unlikely(!skb)) {
@@ -280,10 +286,10 @@ static struct sk_buff *ionic_rx_copybreak(struct ionic_queue *q,
 
 	if (!synced)
 		dma_sync_single_range_for_cpu(dev, ionic_rx_buf_pa(buf_info),
-					      0, len, DMA_FROM_DEVICE);
-	skb_copy_to_linear_data(skb, ionic_rx_buf_va(buf_info), len);
+					      headroom, len, DMA_FROM_DEVICE);
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
@@ -345,6 +351,7 @@ static void ionic_rx_clean(struct ionic_queue *q,
 	struct ionic_rx_stats *stats;
 	struct ionic_rxq_comp *comp;
 	struct bpf_prog *xdp_prog;
+	unsigned int headroom;
 	struct sk_buff *skb;
 	u16 len;
 
@@ -366,10 +373,12 @@ static void ionic_rx_clean(struct ionic_queue *q,
 	    ionic_run_xdp(stats, netdev, xdp_prog, q, desc_info->bufs, len))
 		return;
 
+	headroom = q->xdp_rxq_info ? XDP_PACKET_HEADROOM : 0;
 	if (len <= q->lif->rx_copybreak)
-		skb = ionic_rx_copybreak(q, desc_info, comp, !!xdp_prog);
+		skb = ionic_rx_copybreak(q, desc_info, headroom, len, !!xdp_prog);
 	else
-		skb = ionic_rx_frags(q, desc_info, comp, !!xdp_prog);
+		skb = ionic_rx_frags(q, desc_info, headroom, len,
+				     comp->num_sg_elems, !!xdp_prog);
 
 	if (unlikely(!skb)) {
 		stats->dropped++;
@@ -493,8 +502,9 @@ void ionic_rx_fill(struct ionic_queue *q)
 	unsigned int frag_len;
 	unsigned int nfrags;
 	unsigned int n_fill;
-	unsigned int i, j;
 	unsigned int len;
+	unsigned int i;
+	unsigned int j;
 
 	n_fill = ionic_q_space_avail(q);
 
@@ -503,9 +513,12 @@ void ionic_rx_fill(struct ionic_queue *q)
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
@@ -520,9 +533,18 @@ void ionic_rx_fill(struct ionic_queue *q)
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


