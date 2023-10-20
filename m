Return-Path: <netdev+bounces-42882-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B99457D07B3
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 07:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5968AB21391
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 05:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283B0C2F9;
	Fri, 20 Oct 2023 05:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KzFFarec"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FF1C15D
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 05:40:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2057F1A4;
	Thu, 19 Oct 2023 22:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=KxnTs7gymzuYQJ4ABXvh3JzqxQqiL8GoV+1jwXDsc7A=; b=KzFFarecVywzyeEpwpUH/45E+L
	jKc1bbjilM70qeziPcc8ZLZnR5Gs8xv/vd5Nb4NPEbEAURbvbJaKInpB0Z5sBrOQD/QWTBSkS5crI
	MyWtpoAhbO/bdEPAV4v8tnRr58OljuULFTXtXhe14sgL3pnZ5pIy/9kR44Up6QJ1FPAdNn9fhyxLn
	KkPiXnDXLx9Hrko+J/4cWTzDN2O5fY+qc5zJJ9+sqShUoP1DJf7+1DYuhJqIRHhVJeSRFWOthVeKy
	5Onc7Q6oWGn54r9qS2mhNTiXzOyHfELJN+FJDtSI+2QahG22L+6FfybpwjKGF6CzQ8gqTHgOHuJOV
	APa0iJjw==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qtiFW-001Gjq-1K;
	Fri, 20 Oct 2023 05:40:42 +0000
From: Christoph Hellwig <hch@lst.de>
To: Greg Ungerer <gerg@linux-m68k.org>,
	iommu@lists.linux.dev
Cc: Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Wei Fang <wei.fang@nxp.com>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	linux-m68k@lists.linux-m68k.org,
	netdev@vger.kernel.org
Subject: [PATCH 6/8] net: fec: use dma_alloc_noncoherent for data cache enabled coldfire
Date: Fri, 20 Oct 2023 07:40:22 +0200
Message-Id: <20231020054024.78295-7-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231020054024.78295-1-hch@lst.de>
References: <20231020054024.78295-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Coldfire platforms with data caches can't properly implement
dma_alloc_coherent and currently just return noncoherent memory from
dma_alloc_coherent.

The fec driver than works around this with a flush of all caches in the
receive path. Make this hack a little less bad by using the explicit
dma_alloc_noncoherent API and documenting the hacky cache flushes so
that the DMA API level hack can be removed.

Also replace the check for CONFIG_M532x for said hack with a check
for COLDFIRE && !COLDFIRE_COHERENT_DMA.  While m532x is the only such
platform with a fec module, this makes the code more consistent and
easier to follow.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Greg Ungerer <gerg@linux-m68k.org>
Tested-by: Greg Ungerer <gerg@linux-m68k.org>
---
 drivers/net/ethernet/freescale/fec_main.c | 86 ++++++++++++++++++++---
 1 file changed, 76 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 77c8e9cfb44562..c5e370570f6ec6 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -406,6 +406,70 @@ static void fec_dump(struct net_device *ndev)
 	} while (bdp != txq->bd.base);
 }
 
+/*
+ * Coldfire does not support DMA coherent allocations, and has historically used
+ * a band-aid with a manual flush in fec_enet_rx_queue.
+ */
+#if defined(CONFIG_COLDFIRE) && !defined(CONFIG_COLDFIRE_COHERENT_DMA)
+static void *fec_dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
+		gfp_t gfp)
+{
+	return dma_alloc_noncoherent(dev, size, handle, DMA_BIDIRECTIONAL, gfp);
+}
+
+static void fec_dma_free(struct device *dev, size_t size, void *cpu_addr,
+		dma_addr_t handle)
+{
+	dma_free_noncoherent(dev, size, cpu_addr, handle, DMA_BIDIRECTIONAL);
+}
+#else /* !CONFIG_COLDFIRE || CONFIG_COLDFIRE_COHERENT_DMA */
+static void *fec_dma_alloc(struct device *dev, size_t size, dma_addr_t *handle,
+		gfp_t gfp)
+{
+	return dma_alloc_coherent(dev, size, handle, gfp);
+}
+
+static void fec_dma_free(struct device *dev, size_t size, void *cpu_addr,
+		dma_addr_t handle)
+{
+	dma_free_coherent(dev, size, cpu_addr, handle);
+}
+#endif /* !CONFIG_COLDFIRE || CONFIG_COLDFIRE_COHERENT_DMA */
+
+struct fec_dma_devres {
+	size_t		size;
+	void		*vaddr;
+	dma_addr_t	dma_handle;
+};
+
+static void fec_dmam_release(struct device *dev, void *res)
+{
+	struct fec_dma_devres *this = res;
+
+	fec_dma_free(dev, this->size, this->vaddr, this->dma_handle);
+}
+
+static void *fec_dmam_alloc(struct device *dev, size_t size, dma_addr_t *handle,
+		gfp_t gfp)
+{
+	struct fec_dma_devres *dr;
+	void *vaddr;
+
+	dr = devres_alloc(fec_dmam_release, sizeof(*dr), gfp);
+	if (!dr)
+		return NULL;
+	vaddr = fec_dma_alloc(dev, size, handle, gfp);
+	if (!vaddr) {
+		devres_free(dr);
+		return NULL;
+	}
+	dr->vaddr = vaddr;
+	dr->dma_handle = *handle;
+	dr->size = size;
+	devres_add(dev, dr);
+	return vaddr;
+}
+
 static inline bool is_ipv4_pkt(struct sk_buff *skb)
 {
 	return skb->protocol == htons(ETH_P_IP) && ip_hdr(skb)->version == 4;
@@ -1660,7 +1724,11 @@ fec_enet_rx_queue(struct net_device *ndev, int budget, u16 queue_id)
 	}
 #endif
 
-#ifdef CONFIG_M532x
+#if defined(CONFIG_COLDFIRE) && !defined(CONFIG_COLDFIRE_COHERENT_DMA)
+	/*
+	 * Hacky flush of all caches instead of using the DMA API for the TSO
+	 * headers.
+	 */
 	flush_cache_all();
 #endif
 	rxq = fep->rx_queue[queue_id];
@@ -3288,10 +3356,9 @@ static void fec_enet_free_queue(struct net_device *ndev)
 	for (i = 0; i < fep->num_tx_queues; i++)
 		if (fep->tx_queue[i] && fep->tx_queue[i]->tso_hdrs) {
 			txq = fep->tx_queue[i];
-			dma_free_coherent(&fep->pdev->dev,
-					  txq->bd.ring_size * TSO_HEADER_SIZE,
-					  txq->tso_hdrs,
-					  txq->tso_hdrs_dma);
+			fec_dma_free(&fep->pdev->dev,
+				     txq->bd.ring_size * TSO_HEADER_SIZE,
+				     txq->tso_hdrs, txq->tso_hdrs_dma);
 		}
 
 	for (i = 0; i < fep->num_rx_queues; i++)
@@ -3321,10 +3388,9 @@ static int fec_enet_alloc_queue(struct net_device *ndev)
 		txq->tx_stop_threshold = FEC_MAX_SKB_DESCS;
 		txq->tx_wake_threshold = FEC_MAX_SKB_DESCS + 2 * MAX_SKB_FRAGS;
 
-		txq->tso_hdrs = dma_alloc_coherent(&fep->pdev->dev,
+		txq->tso_hdrs = fec_dma_alloc(&fep->pdev->dev,
 					txq->bd.ring_size * TSO_HEADER_SIZE,
-					&txq->tso_hdrs_dma,
-					GFP_KERNEL);
+					&txq->tso_hdrs_dma, GFP_KERNEL);
 		if (!txq->tso_hdrs) {
 			ret = -ENOMEM;
 			goto alloc_failed;
@@ -4043,8 +4109,8 @@ static int fec_enet_init(struct net_device *ndev)
 	bd_size = (fep->total_tx_ring_size + fep->total_rx_ring_size) * dsize;
 
 	/* Allocate memory for buffer descriptors. */
-	cbd_base = dmam_alloc_coherent(&fep->pdev->dev, bd_size, &bd_dma,
-				       GFP_KERNEL);
+	cbd_base = fec_dmam_alloc(&fep->pdev->dev, bd_size, &bd_dma,
+				  GFP_KERNEL);
 	if (!cbd_base) {
 		ret = -ENOMEM;
 		goto free_queue_mem;
-- 
2.39.2


