Return-Path: <netdev+bounces-155792-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F6CA03CCC
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 11:47:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DDAD1884F57
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 10:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35EA1E9B34;
	Tue,  7 Jan 2025 10:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="YQe+wygx"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BAA213B58D;
	Tue,  7 Jan 2025 10:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736246815; cv=none; b=H6WNIcXQSag2uXGxfnlPWO63kmb5O4eSCA1pAlPauODttiRESFgxQO0V2xvoCaA6IV7biMmR9J5Uzk/1rD8okquxy0Y2Hx9iEn8L7Z6MrfnFrgj2ekCWVoK4gZcTZpoVEzx05I723i71IDOnzGbjinD1eI8RpEynZnSOrvVrhMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736246815; c=relaxed/simple;
	bh=SGvl3YbKlzayeicQJhdyNUbOPGVZYCWyRiGubKkcJzA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WEt0OTENI9IEKUiU83O5VqqUw2CSeCtfx6yTmXityagSYslMEdFRANbzsoKfbvbc/SmQblGQ7Gi8+HPF7Ei0c9sihQkgNuQASKSOrAHrQCO/bSRJzg0aZXDWsIfMJdJy/L1znjm4iBoqhd8prFvSlsiAmIVoXFIC/MtR4cylg3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=YQe+wygx; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 507AL81p016691;
	Tue, 7 Jan 2025 02:46:44 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pfpt0220; bh=F
	oLLQxfARymGGrklp2JtSvBHoT8xA7QBSTLddWTFkG8=; b=YQe+wygxfOC0gI9c6
	ByrE/ssz0v0n6xHMZnwESaQezNuR33BG8l5lh0A9r96TwH6QtkY/0XdpDQK+Hevo
	Rb9ROj+TxLMrpBaJIBPX2uOmJCzNyGMNO8u+XQu1Jt+BGmZ4frIzUPhGtoupxx01
	MK06EGlXJjl5IARidbhoNYIcGAejJZWvYqtVoxXXhjilRrmZr5Yeg+nWs1r3bKUf
	ehXVemlfEw+ZcCfuCkUYcqNbqTXWnPHm3zwEr5jTyKg4WP5tjFkyZiTSuQMASxI2
	evFXZC4STgCiMJ6XWXNsg9+J2YBGZYbOAyEPjlBWh23buNL6dPOrOkrpB3KTYy/v
	bt08g==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4412ecg16v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jan 2025 02:46:43 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 7 Jan 2025 02:46:42 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 7 Jan 2025 02:46:42 -0800
Received: from localhost.localdomain (unknown [10.28.36.166])
	by maili.marvell.com (Postfix) with ESMTP id 9A93B3F70A2;
	Tue,  7 Jan 2025 02:46:38 -0800 (PST)
From: Suman Ghosh <sumang@marvell.com>
To: <sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
        <hkelam@marvell.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lcherian@marvell.com>,
        <jerinj@marvell.com>
CC: Suman Ghosh <sumang@marvell.com>
Subject: [net-next PATCH 1/6] octeontx2-pf: Add AF_XDP non-zero copy support
Date: Tue, 7 Jan 2025 16:16:23 +0530
Message-ID: <20250107104628.2035267-2-sumang@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250107104628.2035267-1-sumang@marvell.com>
References: <20250107104628.2035267-1-sumang@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: EI_dUs6WUrx6FoFyuxxmvh_rrCA9Jj1i
X-Proofpoint-GUID: EI_dUs6WUrx6FoFyuxxmvh_rrCA9Jj1i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.687,Hydra:6.0.235,FMLib:17.0.607.475
 definitions=2020-10-13_15,2020-10-13_02,2020-04-07_01

For XDP, page_pool APIs are getting used now. But the memory type was
not getting set due to which XDP_REDIRECT and hence AF_XDP was not
working. This patch ads the memory type MEM_TYPE_PAGE_POOL as the memory
model of the XDP program.

Signed-off-by: Suman Ghosh <sumang@marvell.com>
---
 .../ethernet/marvell/octeontx2/nic/otx2_common.c    |  8 +++++++-
 .../ethernet/marvell/octeontx2/nic/otx2_common.h    |  1 +
 .../net/ethernet/marvell/octeontx2/nic/otx2_txrx.c  | 13 ++++++++++---
 3 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
index 2b49bfec7869..161cf33ef89e 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
@@ -1047,6 +1047,7 @@ static int otx2_cq_init(struct otx2_nic *pfvf, u16 qidx)
 	int err, pool_id, non_xdp_queues;
 	struct nix_aq_enq_req *aq;
 	struct otx2_cq_queue *cq;
+	struct otx2_pool *pool;
 
 	cq = &qset->cq[qidx];
 	cq->cq_idx = qidx;
@@ -1055,8 +1056,13 @@ static int otx2_cq_init(struct otx2_nic *pfvf, u16 qidx)
 		cq->cq_type = CQ_RX;
 		cq->cint_idx = qidx;
 		cq->cqe_cnt = qset->rqe_cnt;
-		if (pfvf->xdp_prog)
+		if (pfvf->xdp_prog) {
+			pool = &qset->pool[qidx];
 			xdp_rxq_info_reg(&cq->xdp_rxq, pfvf->netdev, qidx, 0);
+			xdp_rxq_info_reg_mem_model(&cq->xdp_rxq,
+						   MEM_TYPE_PAGE_POOL,
+						   pool->page_pool);
+		}
 	} else if (qidx < non_xdp_queues) {
 		cq->cq_type = CQ_TX;
 		cq->cint_idx = qidx - pfvf->hw.rx_queues;
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
index 65814e3dc93f..3748941bbaf1 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
@@ -21,6 +21,7 @@
 #include <linux/time64.h>
 #include <linux/dim.h>
 #include <uapi/linux/if_macsec.h>
+#include <net/page_pool/helpers.h>
 
 #include <mbox.h>
 #include <npc.h>
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
index 224cef938927..ed8b37eb2054 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
@@ -96,7 +96,7 @@ static unsigned int frag_num(unsigned int i)
 
 static void otx2_xdp_snd_pkt_handler(struct otx2_nic *pfvf,
 				     struct otx2_snd_queue *sq,
-				 struct nix_cqe_tx_s *cqe)
+				     struct nix_cqe_tx_s *cqe)
 {
 	struct nix_send_comp_s *snd_comp = &cqe->comp;
 	struct sg_list *sg;
@@ -109,6 +109,11 @@ static void otx2_xdp_snd_pkt_handler(struct otx2_nic *pfvf,
 	otx2_dma_unmap_page(pfvf, sg->dma_addr[0],
 			    sg->size[0], DMA_TO_DEVICE);
 	page = virt_to_page(phys_to_virt(pa));
+	if (page->pp) {
+		page_pool_recycle_direct(page->pp, page);
+		return;
+	}
+
 	put_page(page);
 }
 
@@ -1419,6 +1424,7 @@ static bool otx2_xdp_rcv_pkt_handler(struct otx2_nic *pfvf,
 				     bool *need_xdp_flush)
 {
 	unsigned char *hard_start;
+	struct otx2_pool *pool;
 	int qidx = cq->cq_idx;
 	struct xdp_buff xdp;
 	struct page *page;
@@ -1426,6 +1432,7 @@ static bool otx2_xdp_rcv_pkt_handler(struct otx2_nic *pfvf,
 	u32 act;
 	int err;
 
+	pool = &pfvf->qset.pool[qidx];
 	iova = cqe->sg.seg_addr - OTX2_HEAD_ROOM;
 	pa = otx2_iova_to_phys(pfvf->iommu_domain, iova);
 	page = virt_to_page(phys_to_virt(pa));
@@ -1456,7 +1463,7 @@ static bool otx2_xdp_rcv_pkt_handler(struct otx2_nic *pfvf,
 			*need_xdp_flush = true;
 			return true;
 		}
-		put_page(page);
+		page_pool_recycle_direct(pool->page_pool, page);
 		break;
 	default:
 		bpf_warn_invalid_xdp_action(pfvf->netdev, prog, act);
@@ -1467,7 +1474,7 @@ static bool otx2_xdp_rcv_pkt_handler(struct otx2_nic *pfvf,
 	case XDP_DROP:
 		otx2_dma_unmap_page(pfvf, iova, pfvf->rbsize,
 				    DMA_FROM_DEVICE);
-		put_page(page);
+		page_pool_recycle_direct(pool->page_pool, page);
 		cq->pool_ptrs++;
 		return true;
 	}
-- 
2.25.1


