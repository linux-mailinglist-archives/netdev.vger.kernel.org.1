Return-Path: <netdev+bounces-42883-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74DD87D07B4
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 07:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FE45B21471
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 05:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF728F7A;
	Fri, 20 Oct 2023 05:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jyc9rXLz"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBCCC8C4
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 05:40:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AC6D1A6;
	Thu, 19 Oct 2023 22:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=FAksQ8LRRyrn+3rUq4yXnrpMzoS6CnoEQo/S02ztLWc=; b=jyc9rXLznk0YfXclyLDS8X10nP
	Xk9Yo+/nE+zlyaGRitv8i/okmqV5ji0NuhKH1Q6Pk1xkmBLv5PGm2gfqS1x4pYF0YeIoPUP2OIRqp
	wRRwN8rh3xoXD9eSWZbeEvrfJ881SoCVL3An1oycmq7/vUUc2TAylcttg9LMuzPJi8MxSq1oWdkZX
	B0LZE3GWq11XP+yg+WtiSoPSunqCc9ab0Ikwk/nU5ML67YPana6OEbQR/LSR0ZZ1u0DcchCSfnRPw
	Z1Gl9MH8Eku25MVRV22C1EMf+BMOMLLEH5t/IiHD3YY4RZRoR5q7hPyPAXbZTGMHOWeKFHnTExWFG
	mff3lL0Q==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qtiFY-001Gki-2a;
	Fri, 20 Oct 2023 05:40:45 +0000
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
Subject: [PATCH 7/8] m68k: don't provide arch_dma_alloc for nommu/coldfire
Date: Fri, 20 Oct 2023 07:40:23 +0200
Message-Id: <20231020054024.78295-8-hch@lst.de>
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

Coldfire cores configured with a data cache can't provide coherent
DMA allocations at all.

Instead of returning non-coherent kernel memory in this case,
return NULL and fail the allocation.

The only driver that used to rely on the previous behavior (fec) has
been switched to use non-coherent allocations for this case recently.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Greg Ungerer <gerg@linux-m68k.org>
Tested-by: Greg Ungerer <gerg@linux-m68k.org>
---
 arch/m68k/kernel/dma.c | 23 -----------------------
 1 file changed, 23 deletions(-)

diff --git a/arch/m68k/kernel/dma.c b/arch/m68k/kernel/dma.c
index f83870cfa79b37..eef63d032abb53 100644
--- a/arch/m68k/kernel/dma.c
+++ b/arch/m68k/kernel/dma.c
@@ -33,29 +33,6 @@ pgprot_t pgprot_dmacoherent(pgprot_t prot)
 	}
 	return prot;
 }
-#else
-void *arch_dma_alloc(struct device *dev, size_t size, dma_addr_t *dma_handle,
-		gfp_t gfp, unsigned long attrs)
-{
-	void *ret;
-
-	if (dev == NULL || (*dev->dma_mask < 0xffffffff))
-		gfp |= GFP_DMA;
-	ret = (void *)__get_free_pages(gfp, get_order(size));
-
-	if (ret != NULL) {
-		memset(ret, 0, size);
-		*dma_handle = virt_to_phys(ret);
-	}
-	return ret;
-}
-
-void arch_dma_free(struct device *dev, size_t size, void *vaddr,
-		dma_addr_t dma_handle, unsigned long attrs)
-{
-	free_pages((unsigned long)vaddr, get_order(size));
-}
-
 #endif /* CONFIG_MMU && !CONFIG_COLDFIRE */
 
 void arch_sync_dma_for_device(phys_addr_t handle, size_t size,
-- 
2.39.2


