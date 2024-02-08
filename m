Return-Path: <netdev+bounces-70058-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DEFE784D760
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 01:58:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DD6BB2099A
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 00:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04361EA95;
	Thu,  8 Feb 2024 00:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gAX3c2fl"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0421E539
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 00:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707353879; cv=fail; b=ONtEuhI3mponPxw5ZjapBaiQ9W2bklcfjS3myF3LDISXaMTyp07omJ7FubNx1yjK4lHXd7GYq2zg7fYfuem+1mP35J05fN+TBSaaQWW83+WYg+preslBI+6UVPWHtFmz/bglQ7gw0BKWpUDhgq/VC1p2qiS1uAyBPVJKj0VikL4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707353879; c=relaxed/simple;
	bh=xhJRXhQPOFH4WkSGIUYiL5FXX7EbXTORo63dFxlUaMM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aTrgi9h55LBthiuPBui0TUnZSxDErP6AI2B9DhFi/y8zdYxtCCq0EiC1cWzu/u+PhUiqXYtE5j3L/gGk1YmVG55wW1bcHU8oyqz3C8vDs7tXC84rUcWZcGgNvAuhiZLEYShN9vt4wus35bBBZkgugs0uIsKX1+G8THwIIVK1L0M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gAX3c2fl; arc=fail smtp.client-ip=40.107.243.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IR9DsL872YVTC0pm11Lt9VyO8885vkBcaI9n0v7sPH4ae76WNxYIzxTcXH0/Th0kYezh5AmNIdbNsz7qJPOv1BLmqplk+1uITpI08Ee1dHWWlgoCzl1Sr1hqe/QyGpeHyKUxGgVtAfCLKCvJn4xhY6+y8my3MjJ7tAW1Grx15Lp9v/fQamxGkFrUu+G0zV/OrEF7L4YjuOXW2htj17YcmVtoMEFHbHJIAibB/MEccjnY+8qeodwTs4K6OigJNyd4x9QnEQ280rmvBMBxdEaJpwTl++AQkJubf6pb7A2dAkOANFhvQMCIepNIiNJWeo3YRBjkoAIVXzYgTi7sqYzqKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lTlknsPS//JdxY36arBWktG/qK6qs+noYdSTtTiMU3Q=;
 b=aRlUq5p7HbBXnb7+wm+fYhHDUQcFKYXUv3G9EMR9o9dZMJW5bguNHbrRi/JU+fOF12iEI+IXfsQe//HMH07BemR74m/eGmguVF7Iowdd0DH0jab1DEtT1cB0aJsWOOXw1LTgn/nsxJvCOXfhsWY2qyBrFKElCnQ0qt5zvW8QPsd1k0C4mndGtoMjkItAkW9/sf58nLaOXDQWwVr7If09EN2DKIH5MlpkBJcwAjrE5IhikSXyLINHmXfsiRtCTe1BRcv03+KmRgwE0ctp/finL800tJfCQSaB/Qn8Z8Shg61XCPAOXmKa8G7Xa6s/loHHYJlxWv5w6m2LgPbaRA180A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lTlknsPS//JdxY36arBWktG/qK6qs+noYdSTtTiMU3Q=;
 b=gAX3c2flBQtapjdxkJSaG/JJs+wKp2m6TDVzyC/dxF1jJSjpmJmXIvXWJSBt8smW095p0hfJKVJmnriVof3pvIDmKJj6zBvieq/cIILRNRAnH7fpltYlvs8pKsubDsiDu+UlcXqV3MbfgBA3GA5wGDeYuA+SHyQ/BuLsjAwzFzY=
Received: from DM5PR08CA0059.namprd08.prod.outlook.com (2603:10b6:4:60::48) by
 PH7PR12MB5595.namprd12.prod.outlook.com (2603:10b6:510:135::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.14; Thu, 8 Feb
 2024 00:57:56 +0000
Received: from DS2PEPF00003440.namprd02.prod.outlook.com
 (2603:10b6:4:60:cafe::9a) by DM5PR08CA0059.outlook.office365.com
 (2603:10b6:4:60::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.38 via Frontend
 Transport; Thu, 8 Feb 2024 00:57:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003440.mail.protection.outlook.com (10.167.18.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Thu, 8 Feb 2024 00:57:55 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 7 Feb
 2024 18:57:54 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH v2 net-next 09/10] ionic: add ndo_xdp_xmit
Date: Wed, 7 Feb 2024 16:57:24 -0800
Message-ID: <20240208005725.65134-10-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003440:EE_|PH7PR12MB5595:EE_
X-MS-Office365-Filtering-Correlation-Id: 54e1b43e-1981-4937-b1e1-08dc2840fc80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PSN7CS2BX/7J1dAhAlmEudi4DAU9/9wXjvUYd5qNpiZr3BvFut5fE7HDEAoL1cVQ/3nCHsmWyPXUUHY1SiXq+4HPzlSn63B5YQ+K5uqyibMda7r3R3fGPDIHbfTXxoNtJGfzOJViEJ2MnP6gEyuBRGfzZ6lZ0Cet/Aryv6n/f59ON5iu3CjF3IckqqWfqAVSDYYl1spqfKpGHExNtz5qG8/bk5fZ8A3GksnsZhrmehbFhS93F/BzTXvcE4nbeqXxFK8oe1NjoZSD3QvommviNfAniRE9Qmh1j/k8eqss2hHW9W2joZyipPF4thM/oPku9iayLtbjwwtg3q0besHI1vXk2weE6g6hJLcTOvbwxNE9LY+YmgmZoGPI5Y12wC5UVGjulmUrDYSAJQZbpUFsnWoMY2kTDn6xNF3dugsowbTRReaOJViZBQtEs2yFZRrLLgORetGS50uYN0m0ErQrhDo++IcqRMhcjrNw0Tc++vGcEkoYNeAlOe/Joxl+PBNQfh6rVikJCTamrpZvOiJSGSHwuJljiTXylLOZwtZg5RZ+fOvoA+4eJYvZXQHC2T17wTJHb6/8pvp7VjxndeV0mNLoWrSNO5a/2BYe0KS/uF0=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(376002)(136003)(396003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(82310400011)(46966006)(40470700004)(36840700001)(426003)(2616005)(16526019)(1076003)(336012)(41300700001)(26005)(54906003)(81166007)(36756003)(478600001)(83380400001)(356005)(6666004)(86362001)(82740400003)(316002)(44832011)(70586007)(5660300002)(70206006)(110136005)(8936002)(2906002)(4326008)(8676002);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 00:57:55.8297
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54e1b43e-1981-4937-b1e1-08dc2840fc80
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003440.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5595

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
index 57349d16908c..db3951d72093 100644
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


