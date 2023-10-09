Return-Path: <netdev+bounces-38965-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B3D7BD483
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 09:41:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 936462816CE
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 07:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55FD14269;
	Mon,  9 Oct 2023 07:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bi4nkMlX"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04D0134BE
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 07:41:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15CE08F;
	Mon,  9 Oct 2023 00:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=J0N33buiHeappg+m+Dq08xJB46xuxlX8SMtn/y29oQQ=; b=bi4nkMlX1sEIWe8AWc45AGSIF7
	AEkSsS6pt1TsxqOXMseRQdPnQTmbR6v5Jeuaiguhx0knPIU/tn9nMdZz94UP5eWWpTRtnhKp9tQN7
	HfsoaPEGnMzG53bko4vPHw4LZhJx9w2yYO4wCZf80KQbi856wX6nNLpBwhbFbSbkf8Qzw4imJVor3
	oer5ztdx1IAocg6Fxtbqo7paappgzw/bn6Fob9gWln2LHLBRsXXP++7vChe1s+hBnbbHOKENzv6k+
	19wEs3F6gK3o546x5/W9FiuIwagCn3d6bcSBs85elqPGduZ9KFXhBGked64J8b/ZErWzoGLBZ0dYt
	ndWgQZww==;
Received: from [2001:4bb8:182:6657:e5a9:584c:4324:b228] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qpktb-009ukC-17;
	Mon, 09 Oct 2023 07:41:43 +0000
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
Subject: [PATCH 6/6] m68k: don't provide arch_dma_alloc for nommu/coldfire
Date: Mon,  9 Oct 2023 09:41:21 +0200
Message-Id: <20231009074121.219686-7-hch@lst.de>
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

m68knommu and coldfire can't provide coherent DMA allocations at all.
Currently they simply return normal kernel memory from
dma_alloc_coherent, which is broken and breaks the API contract.  Now
that the only DMA capable driver on these systems has been switched
to use explicitly non-coherent allocations we can drop this hack and
return NULL from dma_alloc_coherent.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/m68k/Kconfig      |  1 -
 arch/m68k/kernel/dma.c | 23 -----------------------
 2 files changed, 24 deletions(-)

diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
index 0430b8ba6b5cc6..3e318bf9504c5b 100644
--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -3,7 +3,6 @@ config M68K
 	bool
 	default y
 	select ARCH_32BIT_OFF_T
-	select ARCH_DMA_ALLOC if !MMU || COLDFIRE
 	select ARCH_HAS_BINFMT_FLAT
 	select ARCH_HAS_CPU_FINALIZE_INIT if MMU
 	select ARCH_HAS_CURRENT_STACK_POINTER
diff --git a/arch/m68k/kernel/dma.c b/arch/m68k/kernel/dma.c
index 2e192a5df949bb..eb164ef1a45ebd 100644
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


