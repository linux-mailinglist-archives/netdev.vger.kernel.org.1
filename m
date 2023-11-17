Return-Path: <netdev+bounces-48742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0378F7EF667
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 17:43:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF370281108
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 16:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C82612E78;
	Fri, 17 Nov 2023 16:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MCNLKBgt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD276ABF
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 16:43:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D91CC433C7;
	Fri, 17 Nov 2023 16:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700239388;
	bh=9GiSGpFIH0nr0tJT9r2HkfJJh4/TVWOuBUNY/F3PFPw=;
	h=From:To:Cc:Subject:Date:From;
	b=MCNLKBgtzmeGeUedNyDuNDmoAsA3jSX7XfegJgJ1taSqTCTsWhCd4tcZbX45UhJEM
	 cyLVs1U8+waXwGZJnfCR279ItKSh/9lrrQ7EJEne5UcT5USI950McZZlhBgEMJKOlf
	 e5rJAkhTWi7DVCmKw82TaMKw9h4r6CRUs5qzIUz5pZ/T7YV/PHlpE17YJk7vf4JmXq
	 GXfFArkFhfRJ/G0HFo6YtDlx1doASzSABLY+paRNvG6xO3s2pVKZMcwi4ScTh1FfIM
	 z5JCdrciap5DXkmr+adLeTN9KaZ/OahcL6R4SDgDykmHcznBbpdP8pgK+tW8mV3dAh
	 2ZYXrUlv/jjng==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: netdev@vger.kernel.org
Cc: nbd@nbd.name,
	john@phrozen.org,
	sean.wang@mediatek.com,
	Mark-MC.Lee@mediatek.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	lorenzo.bianconi@redhat.com,
	sujuan.chen@mediatek.com
Subject: [PATCH net-next] net: ethernet: mtk_wed: add support for devices with more than 4GB of dram
Date: Fri, 17 Nov 2023 17:42:59 +0100
Message-ID: <1c7efdf5d384ea7af3c0209723e40b2ee0f956bf.1700239272.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce WED offloading support for boards with more than 4GB of
memory.

Co-developed-by: Sujuan Chen <sujuan.chen@mediatek.com>
Signed-off-by: Sujuan Chen <sujuan.chen@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 5 ++++-
 drivers/net/ethernet/mediatek/mtk_wed.c     | 8 +++++---
 drivers/net/ethernet/mediatek/mtk_wed_wo.c  | 3 ++-
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index 3cf6589cfdac..a6e91573f8da 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -1159,15 +1159,18 @@ static int mtk_init_fq_dma(struct mtk_eth *eth)
 	phy_ring_tail = eth->phy_scratch_ring + soc->txrx.txd_size * (cnt - 1);
 
 	for (i = 0; i < cnt; i++) {
+		dma_addr_t addr = dma_addr + i * MTK_QDMA_PAGE_SIZE;
 		struct mtk_tx_dma_v2 *txd;
 
 		txd = eth->scratch_ring + i * soc->txrx.txd_size;
-		txd->txd1 = dma_addr + i * MTK_QDMA_PAGE_SIZE;
+		txd->txd1 = addr;
 		if (i < cnt - 1)
 			txd->txd2 = eth->phy_scratch_ring +
 				    (i + 1) * soc->txrx.txd_size;
 
 		txd->txd3 = TX_DMA_PLEN0(MTK_QDMA_PAGE_SIZE);
+		if (MTK_HAS_CAPS(soc->caps, MTK_36BIT_DMA))
+			txd->txd3 |= TX_DMA_PREP_ADDR64(addr);
 		txd->txd4 = 0;
 		if (mtk_is_netsys_v2_or_greater(eth)) {
 			txd->txd5 = 0;
diff --git a/drivers/net/ethernet/mediatek/mtk_wed.c b/drivers/net/ethernet/mediatek/mtk_wed.c
index 2ac35543fcfb..c895e265ae0e 100644
--- a/drivers/net/ethernet/mediatek/mtk_wed.c
+++ b/drivers/net/ethernet/mediatek/mtk_wed.c
@@ -691,10 +691,11 @@ mtk_wed_tx_buffer_alloc(struct mtk_wed_device *dev)
 
 		for (s = 0; s < MTK_WED_BUF_PER_PAGE; s++) {
 			struct mtk_wdma_desc *desc = desc_ptr;
+			u32 ctrl;
 
 			desc->buf0 = cpu_to_le32(buf_phys);
 			if (!mtk_wed_is_v3_or_greater(dev->hw)) {
-				u32 txd_size, ctrl;
+				u32 txd_size;
 
 				txd_size = dev->wlan.init_buf(buf, buf_phys,
 							      token++);
@@ -708,11 +709,11 @@ mtk_wed_tx_buffer_alloc(struct mtk_wed_device *dev)
 					ctrl |= MTK_WDMA_DESC_CTRL_LAST_SEG0 |
 						FIELD_PREP(MTK_WDMA_DESC_CTRL_LEN1_V2,
 							   MTK_WED_BUF_SIZE - txd_size);
-				desc->ctrl = cpu_to_le32(ctrl);
 				desc->info = 0;
 			} else {
-				desc->ctrl = cpu_to_le32(token << 16);
+				ctrl = token << 16 | TX_DMA_PREP_ADDR64(buf_phys);
 			}
+			desc->ctrl = cpu_to_le32(ctrl);
 
 			desc_ptr += desc_size;
 			buf += MTK_WED_BUF_SIZE;
@@ -811,6 +812,7 @@ mtk_wed_hwrro_buffer_alloc(struct mtk_wed_device *dev)
 		buf_phys = page_phys;
 		for (s = 0; s < MTK_WED_RX_BUF_PER_PAGE; s++) {
 			desc->buf0 = cpu_to_le32(buf_phys);
+			desc->token = cpu_to_le32(RX_DMA_PREP_ADDR64(buf_phys));
 			buf_phys += MTK_WED_PAGE_BUF_SIZE;
 			desc++;
 		}
diff --git a/drivers/net/ethernet/mediatek/mtk_wed_wo.c b/drivers/net/ethernet/mediatek/mtk_wed_wo.c
index 3bd51a3d6650..7ffbd4fca881 100644
--- a/drivers/net/ethernet/mediatek/mtk_wed_wo.c
+++ b/drivers/net/ethernet/mediatek/mtk_wed_wo.c
@@ -142,7 +142,8 @@ mtk_wed_wo_queue_refill(struct mtk_wed_wo *wo, struct mtk_wed_wo_queue *q,
 		dma_addr_t addr;
 		void *buf;
 
-		buf = page_frag_alloc(&q->cache, q->buf_size, GFP_ATOMIC);
+		buf = page_frag_alloc(&q->cache, q->buf_size,
+				      GFP_ATOMIC | GFP_DMA32);
 		if (!buf)
 			break;
 
-- 
2.42.0


