Return-Path: <netdev+bounces-70710-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD656850152
	for <lists+netdev@lfdr.de>; Sat, 10 Feb 2024 01:49:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 479DA1F2A4B7
	for <lists+netdev@lfdr.de>; Sat, 10 Feb 2024 00:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E4D04C7B;
	Sat, 10 Feb 2024 00:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="b/oyS71T"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968064417
	for <netdev@vger.kernel.org>; Sat, 10 Feb 2024 00:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707526133; cv=fail; b=XGD72yfjAaR0TKQ8C6u6H+eeMx17xBuqtfYmwsq8gnnplSH8LQiN3uXeK981taSnSSdXvB+zoq4/t+sEvxi4A64G500PnBPhJtWhAbfwsT+HeiVnwBxT2tbv1qJqdBtF0sXTgzB3VP63ekpWW1jBt61Reh7dDJWqVLC8Ec6oqr0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707526133; c=relaxed/simple;
	bh=EpdcKkIgYPpdVeehNi4pzLnExscutvW5b09S9vOvlNQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V9j9Caizovp8wystmqoztvYRTAlArYAkHBgqaR6BXVLRFHzjWdbUsjH5GWfPyaApSMzPkSOMeRp2rIPqk4i7k5fVJDv4zmkx3xZn1nAA76n35K0ejk58/gNud2r89gmiz/AUg+zgBDBHVK+BWXLBZ+7k4mb5pnC1owdcCqFuf/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=b/oyS71T; arc=fail smtp.client-ip=40.107.244.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M3uVQt5jI7qVj0AXP8i19BFq4Q+7xWmabRFuDUW5Nxur4avkt9ZO9VPsDFk7pyBMopqAq381bUL5AE81ag3Dd+IDc53TBo1gdd3kyuY+vmJpYej+7/zH/6pcP4H14Tx7G/Kg5FWYZsDAcBHF7P1Tn2lvlqAg41lzer95dnTGJs2ZhAX92JpkIAnLL1dNbwrzJWuv8ZsbUP3iD6OIPPQhO3qhtnWZkDkqm5XkKl95kwebaOAavoFBY/NFCNwvAGTqFT3d+umCqT1jgtTx3JR6wheQ0tTACdGn5aIIjIFgX4pmMhKj4FbwIO2riIi0+J1Lq3OMm9WsJVQkGHlbtGt8FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ezuKt1xTbJvXbixYp+Qutaxtz5PU0IPIJB3Ny0uipY=;
 b=gLcpq9C//Z/zDkl3J+vBQCl/OHoSGyVST4dZDCi3cbuJplbegFuzdsTeA2bZ39e5G8fmuxbSKbWxGw8D1EV/77EERUmsDayVV/aIdHhEdSi7BKOnYglE9EMfhzkpv81f5el9GbnkCMTMRSuOd6QEIzeTdDiQj4y2jA39gyZW75if++25TZafAoo2BcOq2csEMKsqSyjkHgPWEm24cUakCsnelNGvSG1ccyKSAK+mMA7qmKk2bTupJtymTioHvPDhZNrynfQkMxlp1FzP+HBuw4lhoagczV60bC1lvzVmOjcNv20j+wwHrAy8T2BsaebwGK83ttnUkchpE+17B/6wMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ezuKt1xTbJvXbixYp+Qutaxtz5PU0IPIJB3Ny0uipY=;
 b=b/oyS71TdTv660/H4UGCPCtdsEt95io20ROEQBxcD93gsNOMp2tUIgxeRrn3j1IpSsDCNUOzHhXuZ5MzI5DwdHwutcWSwMI4/NQZN89Wh68gP+qM6YjkReXP+YJYQxksNN6FjjYIksnYrlow86lOggHsywKcGhwPyEZsB4Q6YFk=
Received: from DM6PR03CA0094.namprd03.prod.outlook.com (2603:10b6:5:333::27)
 by SJ0PR12MB7033.namprd12.prod.outlook.com (2603:10b6:a03:448::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.17; Sat, 10 Feb
 2024 00:48:47 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:5:333:cafe::b8) by DM6PR03CA0094.outlook.office365.com
 (2603:10b6:5:333::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.39 via Frontend
 Transport; Sat, 10 Feb 2024 00:48:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.13 via Frontend Transport; Sat, 10 Feb 2024 00:48:47 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 9 Feb
 2024 18:48:45 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH v3 net-next 5/9] ionic: Add XDP packet headroom
Date: Fri, 9 Feb 2024 16:48:23 -0800
Message-ID: <20240210004827.53814-6-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240210004827.53814-1-shannon.nelson@amd.com>
References: <20240210004827.53814-1-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|SJ0PR12MB7033:EE_
X-MS-Office365-Filtering-Correlation-Id: 601e6925-e06a-4113-0fab-08dc29d20a5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9W3jNjvxd9qikhv1YrGxFj9LCSkRvb4SdH2cNLfT6y/82HaUhTu5k7V/mehqrOTbvV8YdO5/VK5tbD7z7WkmbDg6xY+Tm1TbGlomzJUThaSw/9m23DQbCRK4A+K4ZeW4Ddwvg8U4+EudjJrDmxXvqHzeFrbdx0+bpdDIehezJrWM342Ti66wAb7PfH5eJydVgB2w4Kefo9dqcp+gIbTELLD0Tx6iIF0Ia5Qvla3yTYv9SfK7fQxYssyIT8OyRkq6CV0IoTu+vDJt936wwPz2RyMFxeGOU7GVlpucTKzaUUZ028WoGFJoKGGyyHZo9bnd1dv2/lXMFdwAdAW2nWg4ib/QZdT1RzWetnuCKxInw8+xLlVJ0jt9zbc//D/JdNnB6juapYGGFH8g1TswtYlsYVIhdkM1+POJSJc1X/miqayyu6VuI6ZEPIqi4i3sf+VgOMmPYdlfxRwynJn2RwCOq7lHpgUdrsH+AusHr1AE8C0Wi8JXfmphFvPgyHdv9Z09fW9Xh/zhNd92ohwuFLlcXZ6mj2SJ8mzkc471gaNLhXHfjDiseBEivbJ9EyKrIlrxeW6xtfDSH73Rjujd0njMw56s/ldGodn88puxVemBO8I=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(346002)(376002)(396003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(82310400011)(40470700004)(46966006)(36840700001)(5660300002)(44832011)(8936002)(8676002)(70206006)(70586007)(4326008)(2906002)(16526019)(36756003)(81166007)(356005)(82740400003)(86362001)(83380400001)(478600001)(110136005)(6666004)(54906003)(316002)(2616005)(1076003)(426003)(26005)(336012)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2024 00:48:47.2703
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 601e6925-e06a-4113-0fab-08dc29d20a5f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7033

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


