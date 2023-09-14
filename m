Return-Path: <netdev+bounces-33860-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 999517A07D6
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 16:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4893A281BC7
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 14:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28C6721346;
	Thu, 14 Sep 2023 14:39:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C5121344;
	Thu, 14 Sep 2023 14:39:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAC6BC43397;
	Thu, 14 Sep 2023 14:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694702374;
	bh=bptKA4oxu938HC76Gt7Y+c/P6Zyx8f+qya9UM/jezdY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LQgRUn8d7kTWrl1/JS/ClNubszPNHA6pcsRN4+rsXGTkNvYl+sKsyw7CM1h0WAvY8
	 FZcRQGYtD0hFzUCjECOTcdEtnk98pPYKRWxJSxUcsZBT2PpBBk8VzuC4wgytU1rp25
	 gq6+1N1II972L4ai0sEE9otV8HXxBA1WDhWPdDul/PnxroyM6JivlxC8o6NSC+5JZw
	 ADYFszokqS3Fbjdug9TKwJig0Jh28ktgDg8/L80Pyka5Eymw/ba+LqtSixhQsTl1Jg
	 zKOBbdJa9KcJeLxiJrkc2CAbE2D2BbnQWDbNnjVj/Crc7trZxyhzIUji/9gNJPvraY
	 M8lgQLYR2F9jg==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: netdev@vger.kernel.org
Cc: lorenzo.bianconi@redhat.com,
	nbd@nbd.name,
	john@phrozen.org,
	sean.wang@mediatek.com,
	Mark-MC.Lee@mediatek.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	daniel@makrotopia.org,
	linux-mediatek@lists.infradead.org,
	sujuan.chen@mediatek.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	devicetree@vger.kernel.org
Subject: [PATCH net-next 07/15] net: ethernet: mtk_wed: introduce mtk_wed_buf structure
Date: Thu, 14 Sep 2023 16:38:12 +0200
Message-ID: <7eede969f46fee8c05913fe1893cb60db9144edf.1694701767.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1694701767.git.lorenzo@kernel.org>
References: <cover.1694701767.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce mtk_wed_buf structure to store both virtual and physical
addresses allocated in mtk_wed_tx_buffer_alloc() routine. This is a
preliminary patch to add WED support for MT7988 SoC since it relies on a
different dma descriptor layout not storing page dma addresses.

Co-developed-by: Sujuan Chen <sujuan.chen@mediatek.com>
Signed-off-by: Sujuan Chen <sujuan.chen@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/mediatek/mtk_wed.c | 12 ++++++------
 include/linux/soc/mediatek/mtk_wed.h    |  7 ++++++-
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_wed.c b/drivers/net/ethernet/mediatek/mtk_wed.c
index 8880b018ffca..58d97be98029 100644
--- a/drivers/net/ethernet/mediatek/mtk_wed.c
+++ b/drivers/net/ethernet/mediatek/mtk_wed.c
@@ -300,9 +300,9 @@ mtk_wed_assign(struct mtk_wed_device *dev)
 static int
 mtk_wed_tx_buffer_alloc(struct mtk_wed_device *dev)
 {
+	struct mtk_wed_buf *page_list;
 	struct mtk_wdma_desc *desc;
 	dma_addr_t desc_phys;
-	void **page_list;
 	int token = dev->wlan.token_start;
 	int ring_size;
 	int n_pages;
@@ -343,7 +343,8 @@ mtk_wed_tx_buffer_alloc(struct mtk_wed_device *dev)
 			return -ENOMEM;
 		}
 
-		page_list[page_idx++] = page;
+		page_list[page_idx].p = page;
+		page_list[page_idx++].phy_addr = page_phys;
 		dma_sync_single_for_cpu(dev->hw->dev, page_phys, PAGE_SIZE,
 					DMA_BIDIRECTIONAL);
 
@@ -387,8 +388,8 @@ mtk_wed_tx_buffer_alloc(struct mtk_wed_device *dev)
 static void
 mtk_wed_free_tx_buffer(struct mtk_wed_device *dev)
 {
+	struct mtk_wed_buf *page_list = dev->tx_buf_ring.pages;
 	struct mtk_wdma_desc *desc = dev->tx_buf_ring.desc;
-	void **page_list = dev->tx_buf_ring.pages;
 	int page_idx;
 	int i;
 
@@ -400,13 +401,12 @@ mtk_wed_free_tx_buffer(struct mtk_wed_device *dev)
 
 	for (i = 0, page_idx = 0; i < dev->tx_buf_ring.size;
 	     i += MTK_WED_BUF_PER_PAGE) {
-		void *page = page_list[page_idx++];
-		dma_addr_t buf_addr;
+		dma_addr_t buf_addr = page_list[page_idx].phy_addr;
+		void *page = page_list[page_idx++].p;
 
 		if (!page)
 			break;
 
-		buf_addr = le32_to_cpu(desc[i].buf0);
 		dma_unmap_page(dev->hw->dev, buf_addr, PAGE_SIZE,
 			       DMA_BIDIRECTIONAL);
 		__free_page(page);
diff --git a/include/linux/soc/mediatek/mtk_wed.h b/include/linux/soc/mediatek/mtk_wed.h
index c6512c216b27..5f00dc26582b 100644
--- a/include/linux/soc/mediatek/mtk_wed.h
+++ b/include/linux/soc/mediatek/mtk_wed.h
@@ -76,6 +76,11 @@ struct mtk_wed_wo_rx_stats {
 	__le32 rx_drop_cnt;
 };
 
+struct mtk_wed_buf {
+	void *p;
+	dma_addr_t phy_addr;
+};
+
 struct mtk_wed_device {
 #ifdef CONFIG_NET_MEDIATEK_SOC_WED
 	const struct mtk_wed_ops *ops;
@@ -97,7 +102,7 @@ struct mtk_wed_device {
 
 	struct {
 		int size;
-		void **pages;
+		struct mtk_wed_buf *pages;
 		struct mtk_wdma_desc *desc;
 		dma_addr_t desc_phys;
 	} tx_buf_ring;
-- 
2.41.0


