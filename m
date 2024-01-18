Return-Path: <netdev+bounces-64276-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D71D831FB7
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 20:26:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D19EBB20CE3
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 19:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19DD62E836;
	Thu, 18 Jan 2024 19:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qbUVR0BS"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2063.outbound.protection.outlook.com [40.107.95.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB852E640
	for <netdev@vger.kernel.org>; Thu, 18 Jan 2024 19:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705605932; cv=fail; b=oDZi9BhtHp9MXi5algzEvHYxUkNfAqWbZvYDseGeEmivY8SJoGxWmUqcsnn+d1QbtrjKzu/Yd4UMQFeQpXtTKXevvPXPoBezf4JpCNM7cEutEhHrzrcLVvGvgUkf9FPbp9svpqTWoJhH4aIy3sl1BTNbMskOLdSIu7Z5QV0rL+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705605932; c=relaxed/simple;
	bh=2g8GMJdRZHv9xdYAgNM/7eeUlVcCVapJh7bNUFKmyDU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R2oToE6KNowI0Q6pBr5ys3KnFY8WahnUHxdaxixTJRZpRlNA2UdieVppa01S7E937VddsT6Ouj3eW+/Hoqk6ZaA4Wueg41hUMNt7dHkAwghUcaoAjii2AktVi6C+eCAF6JXfWUm+GSuORaRfZD2xf6R2/kM6PEKLGZdQ9s2U+eo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qbUVR0BS; arc=fail smtp.client-ip=40.107.95.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=exgy4+fUrO/CNWbrslrzBcqWqPcO7wLn8TMwNZ48Vu3N2FgGrw4YokYh3Jl5EBSz6CjcEVQhesC8RJ8zNvL+nqoLUDR4i7C/JKSV4MQsbzTJM4LZnWz0CEq8GSeL1lffLqp9o5ierJsrRNhekw+TgUcprYQfv/s5tshmk3Z7aoYGHMX71aEBOkcfg7XbJG3L+kkL3dWXSLOpV0/o6roik1yS/ZJOx7+Y3CW57dvC7NLvLzOHklJmgjFpl7toKNrlykc50bCqiXCVbaEhop84YmqZkMHXbSPzH/sxJVNs3dwjAKhQCpZWTaeHJkwpndHugsCL1MVFXZmK53TpktkDgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5RVok7rC3gV/gSSSVgsw8fEa9vrFF1HHJgTk+BLvU24=;
 b=KFrOaCS2HN3bDl9vSnT/4gjBe/9PT5rgigWkClHkGPQFwHsCfYuJHmosHrKKBtgD3niHYTLOsq/409a+bLmznJUOsksy1fZQ+wa+5Wi2UPNcITtSYXWEPle7C4atsckZtHZ71HliSz6h4zSEIvnFw6ovD3U863vTbLYknnacgQnYHhLD8+PjiCZZd7YUXwmlfd/gZgTmYR9jBadjkB2ohbAIkHX7KWCGJm9AepONANFnLOtkeEAAs3lY68flPAV75XU4+CshfHzSAvX/QWkwCSf7JPAD7q8KdsZ+OuXc4eYVtzuhgnfcI46USN1pMrLBRqEQRF9DsfBe1jmnKBLtJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5RVok7rC3gV/gSSSVgsw8fEa9vrFF1HHJgTk+BLvU24=;
 b=qbUVR0BStOMbMwN/XUfo5yWFYU1MRG8iqGkenKy1Kt6nxGHOQVFjBS1Y1aEvDYl5zY4PBQj4q0isRFV4epzb7JR/hdeYEiPz2J1dUMqIjqYWf5lPVFKz3BkdnHGm/+sfZ65AICJvLWQZB6Pb7xJvC3GE/Bt1pApd4zZLpzXih28=
Received: from DS7PR05CA0097.namprd05.prod.outlook.com (2603:10b6:8:56::26) by
 DS0PR12MB7945.namprd12.prod.outlook.com (2603:10b6:8:153::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7202.24; Thu, 18 Jan 2024 19:25:26 +0000
Received: from DS3PEPF000099DC.namprd04.prod.outlook.com
 (2603:10b6:8:56:cafe::22) by DS7PR05CA0097.outlook.office365.com
 (2603:10b6:8:56::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.8 via Frontend
 Transport; Thu, 18 Jan 2024 19:25:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DC.mail.protection.outlook.com (10.167.17.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Thu, 18 Jan 2024 19:25:26 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 18 Jan
 2024 13:25:25 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH RFC net-next 8/9] ionic: add ndo_xdp_xmit
Date: Thu, 18 Jan 2024 11:24:59 -0800
Message-ID: <20240118192500.58665-9-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DC:EE_|DS0PR12MB7945:EE_
X-MS-Office365-Filtering-Correlation-Id: c8e81cc5-f6c6-4346-00fa-08dc185b39b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	D3IgzjJyLtQdwYny4+vTrNCEMCUxkL1jDdqk3nWet1AATtqYkJkEYmCjcnSogiacNAUsboP67+4Zv4k83Jgkbds6Y1luYbGLIbAJaLf2jSsutKHy6eodBqpYb0nXiRP+H1Lb3o0wTDaYFF6PyDBgR2LVRH0bwrqAGYmX7QtQZOxGeE/qLFUmu4QWYaaf5eMCxx9fNY97fxnZnloxMb60LRcdahsN6cVBxM1ft133vzxsjf44sM+/EXt0xTyeLgF6MU/NgalFW25F9MP6KEFIo0SvRsuU6sxzWQ+HYy6EdlM7qAI9GObPUIIuvYLhXmIp90OcMZxQCa9p4PGuY1aKM7ONjCIGBejRyuJdOO0L7wInmS00HOeIo31//lMLPfOa14oAjttLg/n0picMiNHoPMsMozG6Yhdsf/K+T46ZIRWMpAnzuy0OCUx6RaLim/p5MXUqjAp/J4nquK5NsPfjCvb9mFMZfM1rc/yp05VmLu90ajAm3GULJt/CRN7JY4e5CIDnDjR5z18gTt4KvSCVBAhQsYjaeDPP7tSEr6YRXwN4zscO9R2J9komUs5zAnt9zAADCFZ0R8DFKNsUlv5wdBargQN4Scdpj3UDm8Lrrc7jqoDCx6q0XfGOR2qWDxlloQkZnMHux21VFrs9BOgyUKp5xxahkrNEXRmOoc2eBpzxAbbwn3UJy/XdKziGRYEmWhnmbwVShR+2hjlPnCzo4aoh/31zx1Ff3HHnA+r+xTa3DOCfOHf5+ZiyLnEHCRsRoMCUi4IuJtRbjtoOAE7ZyA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(396003)(39860400002)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(82310400011)(46966006)(36840700001)(40470700004)(26005)(336012)(6666004)(1076003)(16526019)(2616005)(36860700001)(426003)(47076005)(5660300002)(8676002)(4326008)(44832011)(8936002)(41300700001)(2906002)(54906003)(70586007)(478600001)(110136005)(70206006)(316002)(36756003)(81166007)(86362001)(356005)(82740400003)(83380400001)(40460700003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 19:25:26.8437
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8e81cc5-f6c6-4346-00fa-08dc185b39b8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7945

When our ndo_xdp_xmit is called we mark the buffer with
XDP_REDIRECT so we know to return it to the XDP stack for
cleaning.

Co-developed-by: Brett Creeley <brett.creeley@amd.com>
Signed-off-by: Brett Creeley <brett.creeley@amd.com>
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 .../net/ethernet/pensando/ionic/ionic_lif.c   |  4 +-
 .../net/ethernet/pensando/ionic/ionic_txrx.c  | 62 ++++++++++++++++++-
 .../net/ethernet/pensando/ionic/ionic_txrx.h  |  1 +
 3 files changed, 65 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
index bd65b4b2c7f8..ed5d792c4780 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
@@ -1650,7 +1650,8 @@ static int ionic_init_nic_features(struct ionic_lif *lif)
 			      IFF_LIVE_ADDR_CHANGE;
 
 	netdev->xdp_features = NETDEV_XDP_ACT_BASIC    |
-			       NETDEV_XDP_ACT_REDIRECT;
+			       NETDEV_XDP_ACT_REDIRECT |
+			       NETDEV_XDP_ACT_NDO_XMIT;
 
 	return 0;
 }
@@ -2844,6 +2845,7 @@ static const struct net_device_ops ionic_netdev_ops = {
 	.ndo_eth_ioctl		= ionic_eth_ioctl,
 	.ndo_start_xmit		= ionic_start_xmit,
 	.ndo_bpf		= ionic_xdp,
+	.ndo_xdp_xmit		= ionic_xdp_xmit,
 	.ndo_get_stats64	= ionic_get_stats64,
 	.ndo_set_rx_mode	= ionic_ndo_set_rx_mode,
 	.ndo_set_features	= ionic_set_features,
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
index c2be2215406a..618d15fb8d95 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
@@ -316,9 +316,13 @@ static void ionic_xdp_tx_desc_clean(struct ionic_queue *q,
 	buf_info = desc_info->bufs;
 	dma_unmap_single(dev, buf_info->dma_addr,
 			 buf_info->len, DMA_TO_DEVICE);
-	__free_pages(buf_info->page, 0);
+	if (desc_info->act == XDP_TX)
+		__free_pages(buf_info->page, 0);
 	buf_info->page = NULL;
 
+	if (desc_info->act == XDP_REDIRECT)
+		xdp_return_frame(desc_info->xdpf);
+
 	desc_info->nbufs = 0;
 	desc_info->xdpf = NULL;
 	desc_info->act = 0;
@@ -372,6 +376,62 @@ static int ionic_xdp_post_frame(struct net_device *netdev,
 	return 0;
 }
 
+int ionic_xdp_xmit(struct net_device *netdev, int n,
+		   struct xdp_frame **xdp_frames, u32 flags)
+{
+	struct ionic_lif *lif = netdev_priv(netdev);
+	struct ionic_queue *txq;
+	struct netdev_queue *nq;
+	int nxmit;
+	int space;
+	int cpu;
+	int qi;
+
+	if (unlikely(!test_bit(IONIC_LIF_F_UP, lif->state)))
+		return -ENETDOWN;
+
+	if (unlikely(flags & ~XDP_XMIT_FLAGS_MASK))
+		return -EINVAL;
+
+	/* AdminQ is assumed on cpu 0, while we attempt to affinitize the
+	 * TxRx queue pairs 0..n-1 on cpus 1..n.  We try to keep with that
+	 * affinitization here, but of course irqbalance and friends might
+	 * have juggled things anyway, so we have to check for the 0 case.
+	 */
+	cpu = smp_processor_id();
+	qi = cpu ? (cpu - 1) % lif->nxqs : cpu;
+
+	txq = &lif->txqcqs[qi]->q;
+	nq = netdev_get_tx_queue(netdev, txq->index);
+	__netif_tx_lock(nq, cpu);
+
+	if (netif_tx_queue_stopped(nq) ||
+	    unlikely(ionic_maybe_stop_tx(txq, 1))) {
+		__netif_tx_unlock(nq);
+		return -EIO;
+	}
+
+	space = min_t(int, n, ionic_q_space_avail(txq));
+	for (nxmit = 0; nxmit < space ; nxmit++) {
+		if (ionic_xdp_post_frame(netdev, txq, xdp_frames[nxmit],
+					 XDP_REDIRECT,
+					 virt_to_page(xdp_frames[nxmit]->data),
+					 0, false)) {
+			nxmit--;
+			break;
+		}
+	}
+
+	if (flags & XDP_XMIT_FLUSH)
+		ionic_dbell_ring(lif->kern_dbpage, txq->hw_type,
+				 txq->dbval | txq->head_idx);
+
+	ionic_maybe_stop_tx(txq, 4);
+	__netif_tx_unlock(nq);
+
+	return nxmit;
+}
+
 static bool ionic_run_xdp(struct ionic_rx_stats *stats,
 			  struct net_device *netdev,
 			  struct ionic_queue *rxq,
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_txrx.h b/drivers/net/ethernet/pensando/ionic/ionic_txrx.h
index d7cbaad8a6fb..82fc38e0f573 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_txrx.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic_txrx.h
@@ -17,4 +17,5 @@ netdev_tx_t ionic_start_xmit(struct sk_buff *skb, struct net_device *netdev);
 bool ionic_rx_service(struct ionic_cq *cq, struct ionic_cq_info *cq_info);
 bool ionic_tx_service(struct ionic_cq *cq, struct ionic_cq_info *cq_info);
 
+int ionic_xdp_xmit(struct net_device *netdev, int n, struct xdp_frame **xdp, u32 flags);
 #endif /* _IONIC_TXRX_H_ */
-- 
2.17.1


