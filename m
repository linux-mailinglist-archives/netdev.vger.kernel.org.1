Return-Path: <netdev+bounces-71793-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ECAA885520C
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 19:27:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2675DB29885
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 18:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8610213248E;
	Wed, 14 Feb 2024 17:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kmGLqC6i"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2075.outbound.protection.outlook.com [40.107.244.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7617F132473
	for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 17:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707933579; cv=fail; b=LyDX1O4GtByOwwJWbG35lrzeXAgk6cuZxVdsLIViT2OcP/9fu/Fk7m4+t7G6U7riiXlP8RX2+iSNabx30uPbNxVpdPFCkGolvQwmP/lrcAly09lD0wK3nr/4FJ7fqUWzZ8f9vkdOaDOAEs/dk2fpJCicynCWAfvzsUK20Pb39Yc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707933579; c=relaxed/simple;
	bh=jk4HHPTiEX0yzpe06XcyFcJ1klS9UED153A+03RbjmU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EsHQpIi1eR+DN5C/FdXpWqnX6d4ZHC6y6xFKAF8ho4P5CgSML3f7pPMM5Vd09jc9JcNBVyvMM0rDHs/MnJiFH/th03oM9nA5HdfdoZlF0H3Jb22OFwzy1dWsyO7F6cIJrk2z2r4zs9UbtLxUf30fQx9MRgBkd6Kas3tdt5P2++I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kmGLqC6i; arc=fail smtp.client-ip=40.107.244.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oA3AZNdhyvDaw2y7d1L2jHYVb5euON/04BVvvgU/kbI93OilR1BAU7rEa1Bh/sut+QgcCpbvhtqDPv0Ew4vg9CABH8nlXG9lKGhykLCntHSrQjbkGi+rkTEjks9D2Ssa9vhq38VpmCsGDLfwxHyHd9axgqbNxq85qDAuobpsbJbxf3ESORgvuF2S+yP538OPEFbxtQETtna9oN9UaybFtjLLqxMO7SGOTsuHdtqLe44R5IhveTN3Kcah3nyUu6l9QxieBhFPVT5X7fAn/sddeQu9g1rGHFXxAk3osISXLONYVixWsnIdFkQ7fIuSVwawftkZYTu2kN1YcuDl2p+ZDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T3ZB8iDOah7e6WRPK3imLQgeUSeNHy7HZSoez22PQUs=;
 b=f+z72jlm2l6Ds25VOLN6D7SgDEP6Ak/e5zngQyyk+bWIhl5UAmsPaHPW4rKe/yty5RZPwp6Z5qz2QrSP158dnQWQ/IJ8/atclGbTuuYYSBOOKktc0isPV0h2Z9JJHe8+84I6sfViOIbeHna4TIhk1B41z37XNC8Hr+AI5M0xN1FZkLPGM++Uakbm2GPc8QHDyuiILfXYBQaV03rpv28g+SoIkani6FnS8PjPUmla8Pu3dLdlvDRO+6tRPWgxn5gLXXm1bMrkUbA7wwfAcunqompePNGkyiYNi0iXCtunf2plWC9aoGdINnlNmgShnBBeFus8nxmOljAboa7ZXXHR1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T3ZB8iDOah7e6WRPK3imLQgeUSeNHy7HZSoez22PQUs=;
 b=kmGLqC6inmgwo+C9D0XyuquX9NkrZPj48c0ax7a4x5zpYJJppjl6LEJF+TLGwkz7u+cZhsfc0k7yomVos/o4JLJkzYjMI8xPYdN7UjcnOWLNYlm9ggBuQ4FX/wyUaAMHxiz+zGjVWD4txiJP2NVoA815QXBbx8wnTUrD82L94j4=
Received: from BL1P221CA0030.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::21)
 by DM6PR12MB5007.namprd12.prod.outlook.com (2603:10b6:5:20d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.25; Wed, 14 Feb
 2024 17:59:35 +0000
Received: from BL6PEPF0001AB71.namprd02.prod.outlook.com
 (2603:10b6:208:2c5:cafe::36) by BL1P221CA0030.outlook.office365.com
 (2603:10b6:208:2c5::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26 via Frontend
 Transport; Wed, 14 Feb 2024 17:59:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB71.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Wed, 14 Feb 2024 17:59:35 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 14 Feb
 2024 11:59:33 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH v4 net-next 8/9] ionic: add ndo_xdp_xmit
Date: Wed, 14 Feb 2024 09:59:08 -0800
Message-ID: <20240214175909.68802-9-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB71:EE_|DM6PR12MB5007:EE_
X-MS-Office365-Filtering-Correlation-Id: 1748a137-97c5-4f88-6fe9-08dc2d86b42b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3ryl3wgq3dMUoVXEK3wutgwdzmAenJaWwbKCbX+I0m2DpTPdPVBYSdyke15fG5yMB57JRhaY7Cv9Ur5+s8/1Flp6YGWmlamkhntNbIdsDMJ9Og5zxx0BFYX2WVt9CujyQzVwtsPwQdfxiGUn8iZLaHC7mvQXVXhqMydLd+/vKDJ9iSPY5N/N/m5QR3nWef690V7qpEvx3J/b//EVGc0111kQlzKUSw8fg9Ob3k8vUa8AvrtGxaEihXWP6KqrMWjJ7B2ucOCHRnP4PnrzDoHbQjFgT9IhS6/eA4Pl1axH4WOz/0V9PQYjZqk5pqcQvyCa3S39laCDGeWOcGavYY5xJ8pWZv0DqhSVnaPXEzjbjah1+EocpjpQYyoQ2r5CtSP0EEuoX/cYYZwFrrh3XlSGtoHs0IAMaJGSbl7bn/D5a5XMzMWLY/3SVAo7snKZxd/EegV23j6NFn2uMAA/YYk0z5FbR0Rkd90qhknSv9z6dMBXBKNcq4q1V5puJmAsBBoQ5zh/sWMLV+6EXZarFOCWg+Bl6guMND3wBmdQB7+jTpZLGcihuyUWkfPl0Y/55PMBvQ6LDl8KK/n39tyURGOTd6cB69tCXepeXj560mfivYQ=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(39860400002)(376002)(396003)(230922051799003)(82310400011)(186009)(451199024)(1800799012)(64100799003)(46966006)(36840700001)(40470700004)(316002)(110136005)(54906003)(6666004)(5660300002)(2906002)(44832011)(70206006)(86362001)(70586007)(4326008)(8676002)(8936002)(336012)(26005)(478600001)(41300700001)(1076003)(36756003)(2616005)(356005)(81166007)(16526019)(426003)(82740400003)(83380400001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 17:59:35.1068
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1748a137-97c5-4f88-6fe9-08dc2d86b42b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB71.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5007

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
index 79bb07083f35..d26ea697804d 100644
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
@@ -2847,6 +2848,7 @@ static const struct net_device_ops ionic_netdev_ops = {
 	.ndo_eth_ioctl		= ionic_eth_ioctl,
 	.ndo_start_xmit		= ionic_start_xmit,
 	.ndo_bpf		= ionic_xdp,
+	.ndo_xdp_xmit		= ionic_xdp_xmit,
 	.ndo_get_stats64	= ionic_get_stats64,
 	.ndo_set_rx_mode	= ionic_ndo_set_rx_mode,
 	.ndo_set_features	= ionic_set_features,
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
index 5471c182bacc..e1839d5b7922 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
@@ -320,9 +320,13 @@ static void ionic_xdp_tx_desc_clean(struct ionic_queue *q,
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
@@ -376,6 +380,63 @@ static int ionic_xdp_post_frame(struct net_device *netdev,
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
 			  struct bpf_prog *xdp_prog,
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


