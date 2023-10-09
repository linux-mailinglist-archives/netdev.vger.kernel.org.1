Return-Path: <netdev+bounces-38964-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA257BD482
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 09:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A9F0281857
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 07:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4E66134B7;
	Mon,  9 Oct 2023 07:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0OOkYrVz"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95BE8828
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 07:41:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42037A6;
	Mon,  9 Oct 2023 00:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=VF0gxGFSBA+cMueOmLdHXrnjVJ09h1I3YlloleiMbFI=; b=0OOkYrVz0/HNB0kgh5KBUuvSze
	2BQc+JNZ4Ny2yFzQOSkvEtUZASdUyknYL6PteaIeKQSoe+eAdhNqcK2f9GPMKTqjLXNM+Hko6QL/A
	jrW+rfPvsjLaDYV8HKdTRsyq2T221cRR/jeQj+8ywMAObYuZiSAyT/Vbxy/bVb4m9ao5HODS7HG5u
	x/gnyRUKZlImsnu959sLFWj7VCxSawisTuUzCzkTKvwJk9RnQsE2NmFVForKiwJ4BJtSmLLS55LTZ
	GdAYu7Gm061Y+/cgSh+8hwFbIcFl0O+IFAx877BKIZYH1rwkXdFuiq9bss44iWhjsBuNGb3oCRANY
	y2fp0asA==;
Received: from [2001:4bb8:182:6657:e5a9:584c:4324:b228] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qpktY-009uj7-2R;
	Mon, 09 Oct 2023 07:41:41 +0000
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux.dev
Cc: Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Wei Fang <wei.fang@nxp.com>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	linux-m68k@lists.linux-m68k.org,
	netdev@vger.kernel.org,
	Jim Quinlan <james.quinlan@broadcom.com>
Subject: [PATCH 5/6] net: fec: use dma_alloc_noncoherent for m532x
Date: Mon,  9 Oct 2023 09:41:20 +0200
Message-Id: <20231009074121.219686-6-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231009074121.219686-1-hch@lst.de>
References: <20231009074121.219686-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The coldfire platforms can't properly implement dma_alloc_coherent and
currently just return noncoherent memory from dma_alloc_coherent.

The fec driver than works around this with a flush of all caches in the
receive path. Make this hack a little less bad by using the explicit
dma_alloc_noncoherent API and documenting the hacky cache flushes so
that the DMA API level hack can be removed.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/net/ethernet/freescale/fec_main.c | 84 ++++++++++++++++++++---
 1 file changed, 75 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 77c8e9cfb44562..aa032ea0ebf0c2 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -406,6 +406,70 @@ static void fec_dump(struct net_device *ndev)
 	} while (bdp != txq->bd.base);
 }
 
+/*
+ * Coldfire does not support DMA coherent allocations, and has historically used
+ * a band-aid with a manual flush in fec_enet_rx_queue.
+ */
+#ifdef CONFIG_COLDFIRE
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
+#else /* CONFIG_COLDFIRE */
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
+#endif /* !CONFIG_COLDFIRE */
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
@@ -1661,6 +1725,10 @@ fec_enet_rx_queue(struct net_device *ndev, int budget, u16 queue_id)
 #endif
 
 #ifdef CONFIG_M532x
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


