Return-Path: <netdev+bounces-70711-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B012A850153
	for <lists+netdev@lfdr.de>; Sat, 10 Feb 2024 01:49:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D507E1C21F23
	for <lists+netdev@lfdr.de>; Sat, 10 Feb 2024 00:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C98963B3;
	Sat, 10 Feb 2024 00:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oepmoo9l"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC2D442D
	for <netdev@vger.kernel.org>; Sat, 10 Feb 2024 00:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707526134; cv=fail; b=EQgvtaXeKPPv2h1tKQ5cT78UjWO4EAKDYH9nZXV2lMwEkfp4W0Ywx98YVyGlH6QOz1aOZ6cnSWbUL11OGAj1si543mR/a404hxh2adldrckCyJ9Qf9TXsBEQfpPaDHRB5jzq61j+35VfRFiE4w5SPgCBigmd9CcAxlL2OiaixkQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707526134; c=relaxed/simple;
	bh=ESQhI3ygm4I3BFDFXqJanptBVmuWMgTT6Z8kpVt0Mos=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hSkwajP3M2GMTIFinGg2Anft7WxLhsOmA4YgYb6uMnFILXmB6zkGdX4Rp4lbtckyQZei3okpHVv1/Y8gme74S1TrIjjjUkonfNALgmtKugNSdLlkV5Nwioog8pdIxa1YDOm8amiV2cZnErVmAriwVgVi+rk+LJXkhP1xrPx4+gE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oepmoo9l; arc=fail smtp.client-ip=40.107.244.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f4j73HuRl+smSQruDfnLLODvzgkkhxHFU8Svvm0uPtsO5x/otvAw3oIGnbmPFqaDHbkWgBvGRQCJ2r3Hxy/b25FJ9/bBQjdxyflwtzmI817H6nstcAuR9UlqSONtmH23h/+CJ3CLyYKRadnEaSKrr9gTVs77hFfhKK0EpRILd5GVzD1oJrPx+gbRpXKQmo3JIsNpf3W9w/0NSqgnLl9LOxSbXt17uOdfaXJpcQAkDWpqdtgr7DxN5p6c5M+tvtN/ty6DXBS3RF023N3m/DIhZe9+rQK429FuJncZ/S057RJps1xXzDzCa9Phf47nrG+ccOEwknwY5/7GxRd+mGwbjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9q4VrndR1W9DYJ2qN8pcKR+8dQEKMndkqUhU2RTLBIo=;
 b=oYSR4+TRDhVA1pLKuvMa/cH6ds+Sb6CX93Faot+bqvHC/vCLcZuo/WamE5QcNilDXWqfczR2x7MwgAJvXbVs6Qm2ndgodR7Y3cOzV+PsPOj3Zq+BGlgrqqoKg3aAunA0Wu+bKoHONJ6q34Yp+nVVzHYi5YWeinkVBek40Dp4JZMOMz3Gr5a1tSBvXEboiSzMY1a6fgL8BW6G4NN1CF6p89t6tTxNoniNVmTypGMfRrxbshQwSz0qXupshPB/ZelHkexpr9GfVTe52w3FlfXkZWtdY6N62pv92wUdW7j8Uu1/3UaeuQHexOvP8xSYrEdrbU6o4CAkvYI/nzImAhxmuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9q4VrndR1W9DYJ2qN8pcKR+8dQEKMndkqUhU2RTLBIo=;
 b=oepmoo9l9DRHDyhrb8rPI6ctJlUr0Qk+GQnyTSqWNki5y6HLomzWbfq5l5HoitdeUyhKC3N3DDk9cxYUwvUjZyVVK7HgK2yLgj+qzOwsNxxRJT0GySCPbPxYiAs8w53QQ3Jmv0iXUpLQx1djOl4+WuwRz1wqAFu33+dCdZLrd5c=
Received: from CYXPR02CA0079.namprd02.prod.outlook.com (2603:10b6:930:ce::27)
 by DM6PR12MB4548.namprd12.prod.outlook.com (2603:10b6:5:2a1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.12; Sat, 10 Feb
 2024 00:48:50 +0000
Received: from CY4PEPF0000EE3F.namprd03.prod.outlook.com
 (2603:10b6:930:ce:cafe::9b) by CYXPR02CA0079.outlook.office365.com
 (2603:10b6:930:ce::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.26 via Frontend
 Transport; Sat, 10 Feb 2024 00:48:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3F.mail.protection.outlook.com (10.167.242.19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Sat, 10 Feb 2024 00:48:50 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 9 Feb
 2024 18:48:48 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH v3 net-next 8/9] ionic: add ndo_xdp_xmit
Date: Fri, 9 Feb 2024 16:48:26 -0800
Message-ID: <20240210004827.53814-9-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3F:EE_|DM6PR12MB4548:EE_
X-MS-Office365-Filtering-Correlation-Id: d69115a8-e4bd-40bb-84de-08dc29d20c29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	LoA1r7Y1SUyy4IDmu5ZiiHwm4q9edPGjO3cZ0VELQx/9KlJr2RFaaTXoiiRfUrGnupkOHV33H6VYAOX0tLzoh4GX020FhZwqzIMssaCfEkBe8tvaK69DRXnQdCFz2d6wz2z9IyvOWJJds1sIyZvE/RgTBM+IEvnb5vtRAPeMZmuSS7K3shyfxSOddA+fe83JqLG0u/SHr9CfbsGjR6e+NnMg8sGAqq3rnOgSLKj1dJcSJ8h3CfE0f3G2n61NLjCuOrpBP5caWUXNj59JATNI+IFEbNO6Wmov+8cs3IIaHlRDRC7tTf4hWCStLW8VrmjX9F+bwy+jNlCfPFILlSrnTgpoCPYVvXJqxaFlRpjNEK/T1hMj9zTjr65uVeG0xIjkIw7OVt2j8C1KfZQnywrWARZIzTVdL3BV7mIDBJvecRlbiDhsMYTq76kvcp/OAdXxCh3fp3VD3inyvzZsC7s13aB8hHzvlb07Tvmgu1CP3Z/lryJaLocMp3VMMR5p2AtNpJbf6oaubLM93SLc0pRRuDskK2f2Km1mR4CbKM8WOsM8ZxeUYSxmLcteGRJrFEIsw5dY8ZkashOAQLt3Brbs2jkn7V/CJ40xePeqmxCXdFw=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(396003)(39860400002)(376002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(82310400011)(40470700004)(46966006)(36840700001)(86362001)(81166007)(356005)(82740400003)(41300700001)(2906002)(336012)(26005)(2616005)(16526019)(1076003)(316002)(426003)(83380400001)(478600001)(6666004)(36756003)(5660300002)(8676002)(8936002)(4326008)(110136005)(70206006)(70586007)(54906003)(44832011);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2024 00:48:50.2592
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d69115a8-e4bd-40bb-84de-08dc29d20c29
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4548

When our ndo_xdp_xmit is called we mark the buffer with
XDP_REDIRECT so we know to return it to the XDP stack for
cleaning.

Co-developed-by: Brett Creeley <brett.creeley@amd.com>
Signed-off-by: Brett Creeley <brett.creeley@amd.com>
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 .../net/ethernet/pensando/ionic/ionic_lif.c   |  4 +-
 .../net/ethernet/pensando/ionic/ionic_txrx.c  | 63 ++++++++++++++++++-
 .../net/ethernet/pensando/ionic/ionic_txrx.h  |  1 +
 3 files changed, 66 insertions(+), 2 deletions(-)

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
index 6a2067599bd8..45644f6428b6 100644
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
@@ -372,6 +376,63 @@ static int ionic_xdp_post_frame(struct net_device *netdev,
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
+	txq_trans_cond_update(nq);
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


