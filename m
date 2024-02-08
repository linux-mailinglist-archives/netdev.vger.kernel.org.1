Return-Path: <netdev+bounces-70059-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A6884D75F
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 01:58:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B1EA1F22B3B
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 00:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A26E1EB2B;
	Thu,  8 Feb 2024 00:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pHxaaXL5"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2036A1E87C
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 00:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707353879; cv=fail; b=fNKUxOE9arhdGRsXRgF6yQHHUQc2XZhmONv1S2qL/+9W1lsXwRPWLjJ8GY9rY3dD2nA1YCqRdwM8oq1o6UDS+TXK+/Ax/fqiFYGKEce+tq7aGlAsj6hj1rzHRsIS6lCvvmSQFymdQJgK7Uvg0JOpouHb+3SsWQGNmMqLrZ05s9k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707353879; c=relaxed/simple;
	bh=uupbtQC58SvZ1ezB/jHF0RL1NjBfsHuYA2glzzv0XXs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FNi588Z3hNvjGhLN8w0BIif8l7feCqyBGXSTTKeeeDTkePuw10AI1e9HaR0AO2VVv+gtss9j9MYvxKaxvteVyWJxgoE9ZgJ5kkGBRCmsYpIivGydHZXdG+IQ6TfP4QewFWBw8G9n/pWsCrEfFqzEH64g+hAvrjW9fBkvu9CosPE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pHxaaXL5; arc=fail smtp.client-ip=40.107.237.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZfWPCDefVvfems4uVENNb+UCfoNKpK9V58dY/6st8RycVezCjbm+UogVtbO5JWmbd6YuI9EtJbnz8m4VzMKLjPcAUj3GK6oSG4hWCU9568ibr3PIAJFRhhizkK5kndhCAxDX9uOFDnVvPtOMq6p01wxE9WY80BnLWE9b62exbhl0M03PeHznj6qdtxkg8dY2b/S/i8XjnUerpkRNET2cgm8dX6bHANKTMVCHGEyXKveb+OPBrMNPEuJsusPckm0CTZ2MZeumpWRYC3hTHbja19Fo2bm2JkJRateWkAuz/XSzhwMapnpKmeLy5qK3cqVpVl5+Mrfr3NMYlBRx/Xrffg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YOhy6FBYptmGZNWQCIYYL/voQhXGZ397NsKaYeXieBM=;
 b=NUU8UPVIX/nTTujugle6kQFdJzo6bC2FM2A0qyJCnyj181wb9SXjF73AZH3JJLziSsY23YVzbvzi+AFtqmshfcPijDKPvMXlo96N0EzEzbLUGIkU6u/8aIg1dSwbvw/BOn4jYiXbkTpgOJk8NtoJS66rGmURudG0QZuOPQvB/tq8XVCF0ulxj198JmvkuAbBw+9KLLL7dqlpj5lzkq4CqYjcTpk2SHfVV0jXx0Ew87IM7KdhTMkzKBbpIozP9SVFf5wFhjaiUtRPw0sf+paFePEa2WJeUUAbP39hypd/nph9qPmQag6tTHKJzoZQJ7JOF4Zd/eLsYalUa/3QMSav3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YOhy6FBYptmGZNWQCIYYL/voQhXGZ397NsKaYeXieBM=;
 b=pHxaaXL5kMg+ObtJcZjwrek5JO8ybDDNUgf/DYcGHCwEl/NdYVvu/PJZos8JplucK+e9rUeuBUTPYR/HTdWpUFJfNw0huLgvKs3k9YMQR+y/2ONRTUDcsWFkVvJ0mte9RtFnpNDCiLHkL0T6CT4/e7/qKrrBa/5JYEskSWn/OL8=
Received: from DM5PR08CA0037.namprd08.prod.outlook.com (2603:10b6:4:60::26) by
 BY5PR12MB4148.namprd12.prod.outlook.com (2603:10b6:a03:208::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.16; Thu, 8 Feb
 2024 00:57:52 +0000
Received: from DS2PEPF00003440.namprd02.prod.outlook.com
 (2603:10b6:4:60:cafe::cc) by DM5PR08CA0037.outlook.office365.com
 (2603:10b6:4:60::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.37 via Frontend
 Transport; Thu, 8 Feb 2024 00:57:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003440.mail.protection.outlook.com (10.167.18.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Thu, 8 Feb 2024 00:57:52 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 7 Feb
 2024 18:57:51 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH v2 net-next 06/10] ionic: Add XDP packet headroom
Date: Wed, 7 Feb 2024 16:57:21 -0800
Message-ID: <20240208005725.65134-7-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240208005725.65134-1-shannon.nelson@amd.com>
References: <20240208005725.65134-1-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003440:EE_|BY5PR12MB4148:EE_
X-MS-Office365-Filtering-Correlation-Id: c71320a4-0e3b-48f0-f066-08dc2840fa97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	oGZKS2sKjH3dQKHFD/YWvvfxnktlkzLP+HIJWccHZQ12HAV/EIwCgKg6KWyB3iOLrH4bcS22Qw5PafoLKPyjQfUrVqDU7UvJBTkqs9HFP3l36qscH0XN/4fWEDgimuAQKXrNgp9zFfARwPXeMJl9L0kY6CFM1kRsKH2keUeLhEWP7tmF12Tg9+Ksk/EjvrEB4b35Z1Ujg9iozOZqEMJIko5vSLLDnT+p2z8yuAIn6mKomGWIu3ABTT+Dpk8X4ZKYFipXQVIiCUpNt4UOsLsaZh/FQzqSQ1rW/ibN1IBprfCbuUT06ONh+6hut5umvSFJoDZvUz2rGV7NFNkFqBsldTBUZts7RF496SJKP8J1xCIX96kT897l787cv4/ktPabJAk0ScYz3Cm1qTgQgTMroWTAFtf5ALP2vRvI25VJPIdvdLOyrSjKc8JMtGVmmRE4k5swdAgDkQ69vmEuC6pDxal2rJ0b01/9ILJhiOOUrpbcztgR4Z0k/5eyUxuAvEsai4+y4wPo8p5JYwifyTjLtNTdQgatxnjGKRNKoyHFK8r9fKTZrV6D1XCcsSYyun997a238/pZKLQ+jGcNjK2gUCfzoDZViyUlOeuu1T4L3To=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(39860400002)(396003)(136003)(230922051799003)(82310400011)(64100799003)(1800799012)(186009)(451199024)(36840700001)(46966006)(40470700004)(41300700001)(2906002)(5660300002)(70586007)(86362001)(8676002)(8936002)(4326008)(44832011)(6666004)(81166007)(54906003)(36756003)(70206006)(83380400001)(356005)(82740400003)(478600001)(316002)(110136005)(426003)(16526019)(336012)(2616005)(26005)(1076003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 00:57:52.6265
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c71320a4-0e3b-48f0-f066-08dc2840fa97
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003440.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4148

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
index 95dd632be9fe..3416e8442084 100644
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


