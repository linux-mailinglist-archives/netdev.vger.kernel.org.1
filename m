Return-Path: <netdev+bounces-42879-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 90FCA7D07AF
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 07:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFCBFB21553
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 05:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ACEDB652;
	Fri, 20 Oct 2023 05:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TYTcVET4"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13A36FD9
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 05:40:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F7FCD51;
	Thu, 19 Oct 2023 22:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=2NdcUI9DyUHr2lanL5FVnDyDlgBIUYjE1oxDB5o8nXU=; b=TYTcVET4VKT5r76wzwXvbAUVaC
	xk+HX35iQzysz4uDIP1BUzhTLzDBe+6FcYOWatR2FycjNm87ncTx2D/ZmwP0bpNGna3HYe5clppzo
	/4b3HaUjeSsmIxXaiXeTeCIO8AaYsoKHVDTvZx7jIndMdYWZd81jquLFuJEvLWAnK/ALBHuOWdPL0
	AlFvO0RNXgLAgttQEEq4TrNMVib75O9jbtxfT3kPMndACfjRf4KIDYCOEb4CY0TjTQ8d1B6QChEdd
	Feleho09GFdNhmU+at3/Rk/DHY4W5PeQ6Xi+1hmAqqYlcI2EcrajCs09QtbGyKbRpWx7WDWCdYfrC
	Zl1C+6Dg==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qtiFP-001Gib-0S;
	Fri, 20 Oct 2023 05:40:35 +0000
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
Subject: [PATCH 3/8] dma-direct: simplify the use atomic pool logic in dma_direct_alloc
Date: Fri, 20 Oct 2023 07:40:19 +0200
Message-Id: <20231020054024.78295-4-hch@lst.de>
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

The logic in dma_direct_alloc when to use the atomic pool vs remapping
grew a bit unreadable.  Consolidate it into a single check, and clean
up the set_uncached vs remap logic a bit as well.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Reviewed-by: Greg Ungerer <gerg@linux-m68k.org>
Tested-by: Greg Ungerer <gerg@linux-m68k.org>
---
 kernel/dma/direct.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index c078090cd38ecc..9657ef7c055eaa 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -234,27 +234,22 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 					dma_handle);
 
 		/*
-		 * Otherwise remap if the architecture is asking for it.  But
-		 * given that remapping memory is a blocking operation we'll
-		 * instead have to dip into the atomic pools.
+		 * Otherwise we require the architecture to either be able to
+		 * mark arbitrary parts of the kernel direct mapping uncached,
+		 * or remapped it uncached.
 		 */
+		set_uncached = IS_ENABLED(CONFIG_ARCH_HAS_DMA_SET_UNCACHED);
 		remap = IS_ENABLED(CONFIG_DMA_DIRECT_REMAP);
-		if (remap) {
-			if (dma_direct_use_pool(dev, gfp))
-				return dma_direct_alloc_from_pool(dev, size,
-						dma_handle, gfp);
-		} else {
-			if (!IS_ENABLED(CONFIG_ARCH_HAS_DMA_SET_UNCACHED))
-				return NULL;
-			set_uncached = true;
-		}
+		if (!set_uncached && !remap)
+			return NULL;
 	}
 
 	/*
-	 * Decrypting memory may block, so allocate the memory from the atomic
-	 * pools if we can't block.
+	 * Remapping or decrypting memory may block, allocate the memory from
+	 * the atomic pools instead if we aren't allowed block.
 	 */
-	if (force_dma_unencrypted(dev) && dma_direct_use_pool(dev, gfp))
+	if ((remap || force_dma_unencrypted(dev)) &&
+	    dma_direct_use_pool(dev, gfp))
 		return dma_direct_alloc_from_pool(dev, size, dma_handle, gfp);
 
 	/* we always manually zero the memory once we are done */
-- 
2.39.2


