Return-Path: <netdev+bounces-64275-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA5C831FB6
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 20:26:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7838E1F22606
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 19:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08FEF2E833;
	Thu, 18 Jan 2024 19:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jUh1Ewub"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835D52E62C
	for <netdev@vger.kernel.org>; Thu, 18 Jan 2024 19:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705605931; cv=fail; b=nLKmZPRIIUOhTLxt0ztGnL8DChH8nnQ5aU1SuFcy4kGI8yf9zLEmG+2cAhc1nZRC4uCesRZz0FqQxW+shdyV5bCnBcgX+klGC3Zye+mftJPgdCRTIoz62DBvzZ8Ars3vTu3RJkj2/SJYdruo8WdUkpuy6nPLf9tE1sd4IHXNiaM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705605931; c=relaxed/simple;
	bh=EpdcKkIgYPpdVeehNi4pzLnExscutvW5b09S9vOvlNQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cj0v+DMOQBClEmaHcf9F5iLq5W/0Z7Rok2C3e/OeBFdL/QDQGRdWKDEKtZIcVBNubB4anmRK6FfqmWI3WucgTqRT69Cjd9CsVWRVnXVVEkUihf5c+CtB6nA4AOpiYr6gZ3/uFbgR5MiI6IKfDG+8X8IldQR3yecnf6xDKCGaspE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jUh1Ewub; arc=fail smtp.client-ip=40.107.243.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RxQRDCc5f+SdXtg/K5yiwdsngqwqe9G/GfbyLzpMnKd1shpLGnfu2I110Gexp7oby7EsqpGdpzJHpcz/1VC0jA4WRSgj6XRMzNuirXxz4n99497uuqC7WnIlJhzc76yaTleskFjvA4/gPIRe13sFqgU9vgWdFWrStvyoQ1+CHk27c7VhG1rX+X1zikTxSUhTYVVo8hdJ2Ee8Ckctp/z4IziXfMoCwsQiNkEAfqbfqNXHiNAMQL3aIItbSrQITxyiX2uO+nFaekTrx9BiH8+T/BiK2PMinNk8tTy+VtdN2UWOJ9XmYBFjbMZyurbd86daSxMWBFyhmj2x2FFP8onflg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ezuKt1xTbJvXbixYp+Qutaxtz5PU0IPIJB3Ny0uipY=;
 b=Avtf2vB0EwVtwDqHdOymxqFpCYohSIFdSKGwf/lSglgk6z8tphEpBN1t1xHk4WGDYKw+fM435fPJczKz+OZgaMf3H4YJ/2hBoQaW1lCv5QZKcEfdq9tgTnGi7OBg7675AvG4F4ywGh8nC+SvNCWbuxOvuapVLK0Ps71UWo4IcEx2acnak1pfI3GX/Xr6wtcnasu/wMoM/mKt2/3AI69fcmq+EnBHe/VyyOjn/XTO6Okr6iIIVSB0IQ5nLXe16BMREcm1E2O/ZCoVbrhQ/sp+Vggpyh7/jWPEggnmsYY/7GlqknnJl22qJCxUjYRUK2vC+a7GNuzQSPd5tEmPOtIydw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ezuKt1xTbJvXbixYp+Qutaxtz5PU0IPIJB3Ny0uipY=;
 b=jUh1EwubeJOrgWjPTpLM7Vsqz9+a5uquuRqzQCXA2X7/mE5FK3SxqBcw5tSMqJn0fouj+cNfqXBQ/n83HmJXJo+Rb9Dgbawv4jDU/pN2ag7wTIiy9vx60PDJu+XxrtBvEzXs5eBFd/oeG+tuZqqGJ2uezYVInUQyycsJRsl+rGY=
Received: from DS7PR05CA0094.namprd05.prod.outlook.com (2603:10b6:8:56::11) by
 BN9PR12MB5212.namprd12.prod.outlook.com (2603:10b6:408:11d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Thu, 18 Jan
 2024 19:25:25 +0000
Received: from DS3PEPF000099DC.namprd04.prod.outlook.com
 (2603:10b6:8:56:cafe::12) by DS7PR05CA0094.outlook.office365.com
 (2603:10b6:8:56::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.8 via Frontend
 Transport; Thu, 18 Jan 2024 19:25:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DC.mail.protection.outlook.com (10.167.17.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Thu, 18 Jan 2024 19:25:25 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 18 Jan
 2024 13:25:21 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH RFC net-next 5/9] ionic: Add XDP packet headroom
Date: Thu, 18 Jan 2024 11:24:56 -0800
Message-ID: <20240118192500.58665-6-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240118192500.58665-1-shannon.nelson@amd.com>
References: <20240118192500.58665-1-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DC:EE_|BN9PR12MB5212:EE_
X-MS-Office365-Filtering-Correlation-Id: 73e29de1-d87e-4566-0cdb-08dc185b38c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rEUNglvBL9ZCRI34H+RYpgRG2oeas4WDNGh0y2jpfatOxhV+IHX8YJ39QPUjdKPihfFUH3oCqNLxf3899ygK0hdVuSrlEnmmf3y0/dyssegjCa1TqunAd9A7dac4sUmqcjRNUNzAKmA42nVCmoTZGPyLdoEIiFf6wntrDb74SU7Iq23VRrxIJ8ZPpn2TA0O9TN90pNtxqbBvsUp1D2i6OIKuFcW5JA5kKgzJVBDg3ESD5YhpotvnzoEvet/GrHf7qubSsXIRKvF97olrrmOfs0wZ9xcA8yeTm5XIoZ3Zo0QISOpCaFhKx5SocLlTgU9nAAZ1h/Ulu98dzBykyVMq0PmQVsjZEp0qII6jF/t4Z3IOuWzclyTnOMmAUrm5S4SRAOHjHsdY32KEjvI27Nl+ePHHQJ8sEjaSqd01MM1w1bf7boWCn8C0/b5CHFBLhLkOOaaAb0+wETQ0vZ5arkiIi10Mtzpm+0h+wQrGI6nG0+Lae2d2fHUc3HPyvC6waj2cI0mDevZaaY/sR4H2daTkKFJTc7yVIXhOOgmlGpIz650HWMQS4/7ApExC/4SWWYfTz9f3/CzrXVyKhgGrJoG2+NcLiP0zrRLPGXJy1e/Es9yqoVVodA2JUNfnP1+4DEmJiKCybh4AOnoghYZkLQOYCFGZ85sYE630JBvTjKzmWVwSBVC08MSgJutByNrB0ZbPKYR+5avRR/V3FauFlgH/qNP9hYFp2bDs/Z77bzreD4Si2N9G51sNXhzVQHzIUOsoVQV5PUfc7NkBBt5i+lLxZQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(136003)(376002)(396003)(230922051799003)(186009)(64100799003)(451199024)(82310400011)(1800799012)(36840700001)(46966006)(40470700004)(26005)(40480700001)(40460700003)(6666004)(426003)(336012)(16526019)(2616005)(1076003)(36756003)(86362001)(82740400003)(81166007)(356005)(41300700001)(44832011)(83380400001)(36860700001)(5660300002)(2906002)(478600001)(47076005)(110136005)(8676002)(8936002)(4326008)(316002)(54906003)(70586007)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 19:25:25.2187
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73e29de1-d87e-4566-0cdb-08dc185b38c0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5212

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


