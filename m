Return-Path: <netdev+bounces-42878-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7300D7D07AE
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 07:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13583B214CD
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 05:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF2679F2;
	Fri, 20 Oct 2023 05:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="d+y5VOu+"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989F563CF
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 05:40:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E7C9D4C;
	Thu, 19 Oct 2023 22:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Pyz8+fmVXEIys12Pb3NL+63o6RprjuprlzvCIRnkBVU=; b=d+y5VOu+M/5iYh5+2vSPd9i5AB
	Rilo+F27nDhvIQ/lVqQAYJYz6xdiRlDwVbTfaTAL5a9WQnLq2QZ3D+GGCabDZ530g6VnOpxZAzKn6
	k7Z8JwRh5bXboJ8UDSZyuGqHpQ6cPt7ALRcxT5dEyoGtvNY1VRgBvS+hsxWRpsPK8f5VX/v3S43nG
	N1EyB2LjpAZ+RXsxtNzSK0J0YpBtrHBrD7Wm59HPygGey+HD11EhwM40BQFO+xwOHyJAK04Lq6QON
	eUVYxBK9WsueQWLtVRG3z+jr5AC5H9H8OncDLAOmTWPFeWD2F0WSxBwRRIieea4EDyg0RiqVEyoNp
	BZw7e4+w==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qtiFM-001GiR-2e;
	Fri, 20 Oct 2023 05:40:33 +0000
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
Subject: [PATCH 2/8] dma-direct: add a CONFIG_ARCH_HAS_DMA_ALLOC symbol
Date: Fri, 20 Oct 2023 07:40:18 +0200
Message-Id: <20231020054024.78295-3-hch@lst.de>
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

Instead of using arch_dma_alloc if none of the generic coherent
allocators are used, require the architectures to explicitly opt into
providing it.  This will used to deal with the case of m68knommu and
coldfire where we can't do any coherent allocations whatsoever, and
also makes it clear that arch_dma_alloc is a last resort.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Reviewed-by: Greg Ungerer <gerg@linux-m68k.org>
Tested-by: Greg Ungerer <gerg@linux-m68k.org>
---
 arch/arm/Kconfig    |  1 +
 arch/m68k/Kconfig   |  1 +
 arch/parisc/Kconfig |  1 +
 kernel/dma/Kconfig  |  9 +++++++++
 kernel/dma/direct.c | 12 ++----------
 5 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 9557808e8937b1..f8567e95f98bef 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -8,6 +8,7 @@ config ARM
 	select ARCH_HAS_CPU_FINALIZE_INIT if MMU
 	select ARCH_HAS_CURRENT_STACK_POINTER
 	select ARCH_HAS_DEBUG_VIRTUAL if MMU
+	select ARCH_HAS_DMA_ALLOC if MMU
 	select ARCH_HAS_DMA_WRITE_COMBINE if !ARM_DMA_MEM_BUFFERABLE
 	select ARCH_HAS_ELF_RANDOMIZE
 	select ARCH_HAS_FORTIFY_SOURCE
diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
index 3e318bf9504c5b..4f3e7dec2171c8 100644
--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -6,6 +6,7 @@ config M68K
 	select ARCH_HAS_BINFMT_FLAT
 	select ARCH_HAS_CPU_FINALIZE_INIT if MMU
 	select ARCH_HAS_CURRENT_STACK_POINTER
+	select ARCH_HAS_DMA_ALLOC if !MMU || COLDFIRE
 	select ARCH_HAS_DMA_PREP_COHERENT if HAS_DMA && MMU && !COLDFIRE
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE if HAS_DMA
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG if RMW_INSNS
diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
index a15ab147af2e07..46e8e4ea7a57de 100644
--- a/arch/parisc/Kconfig
+++ b/arch/parisc/Kconfig
@@ -8,6 +8,7 @@ config PARISC
 	select HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_SYSCALL_TRACEPOINTS
 	select ARCH_WANT_FRAME_POINTERS
+	select ARCH_HAS_DMA_ALLOC if PA11
 	select ARCH_HAS_ELF_RANDOMIZE
 	select ARCH_HAS_STRICT_KERNEL_RWX
 	select ARCH_HAS_STRICT_MODULE_RWX
diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
index 4524db877eba36..d62f5957f36be7 100644
--- a/kernel/dma/Kconfig
+++ b/kernel/dma/Kconfig
@@ -144,6 +144,15 @@ config DMA_DIRECT_REMAP
 	select DMA_COHERENT_POOL
 	select DMA_NONCOHERENT_MMAP
 
+#
+# Fallback to arch code for DMA allocations.  This should eventually go away.
+#
+config ARCH_HAS_DMA_ALLOC
+	depends on !ARCH_HAS_DMA_SET_UNCACHED
+	depends on !DMA_DIRECT_REMAP
+	depends on !DMA_GLOBAL_POOL
+	bool
+
 config DMA_CMA
 	bool "DMA Contiguous Memory Allocator"
 	depends on HAVE_DMA_CONTIGUOUS && CMA
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 9596ae1aa0dacf..c078090cd38ecc 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -220,13 +220,7 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 		return dma_direct_alloc_no_mapping(dev, size, dma_handle, gfp);
 
 	if (!dev_is_dma_coherent(dev)) {
-		/*
-		 * Fallback to the arch handler if it exists.  This should
-		 * eventually go away.
-		 */
-		if (!IS_ENABLED(CONFIG_ARCH_HAS_DMA_SET_UNCACHED) &&
-		    !IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
-		    !IS_ENABLED(CONFIG_DMA_GLOBAL_POOL) &&
+		if (IS_ENABLED(CONFIG_ARCH_HAS_DMA_ALLOC) &&
 		    !is_swiotlb_for_alloc(dev))
 			return arch_dma_alloc(dev, size, dma_handle, gfp,
 					      attrs);
@@ -330,9 +324,7 @@ void dma_direct_free(struct device *dev, size_t size,
 		return;
 	}
 
-	if (!IS_ENABLED(CONFIG_ARCH_HAS_DMA_SET_UNCACHED) &&
-	    !IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
-	    !IS_ENABLED(CONFIG_DMA_GLOBAL_POOL) &&
+	if (IS_ENABLED(CONFIG_ARCH_HAS_DMA_ALLOC) &&
 	    !dev_is_dma_coherent(dev) &&
 	    !is_swiotlb_for_alloc(dev)) {
 		arch_dma_free(dev, size, cpu_addr, dma_addr, attrs);
-- 
2.39.2


