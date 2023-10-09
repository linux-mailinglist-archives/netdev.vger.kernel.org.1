Return-Path: <netdev+bounces-38961-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06EEA7BD47F
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 09:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A91351C20C07
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 07:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29AC134B7;
	Mon,  9 Oct 2023 07:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="G+koY4fm"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0FC211735
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 07:41:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86BB6A2;
	Mon,  9 Oct 2023 00:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=+FPz7Ddw0opVwX7ZO8En7vSHubL/dQg5n7dN1DBxBIs=; b=G+koY4fmQ0lJuBHe79kLgHPTv8
	Ed/nCRtqEcekFMNOzpDeSRgYdd59xMKBGz3bRQ07eg2KVlWRvx0/6h7j1EeNcquLwTZAPDUYpfdFU
	8v7yhjcEwjJgcMpJDmYREUHqvXYoPAlqRofkxiSIWJsFoQ6vaphsbVHEvtFO1NRMgx5rOqOhAryF0
	1LebMuoQRy5VD95EGJ6n0DUqlco8qcoTESXT8mVdqtod/NMgIu94s0xdDZZxw8g6cpOjyEWs0rkcs
	OqIRWozESB4Kfswidl07IgGCJVRMkfAX2ZCeFk9d7ik2wMojh5ReF4Pujaf9yYGCCM79/vwRF9gEK
	y8gH5oaQ==;
Received: from [2001:4bb8:182:6657:e5a9:584c:4324:b228] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qpktQ-009uhk-1H;
	Mon, 09 Oct 2023 07:41:32 +0000
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
Subject: [PATCH 2/6] dma-direct: add a CONFIG_ARCH_DMA_ALLOC symbol
Date: Mon,  9 Oct 2023 09:41:17 +0200
Message-Id: <20231009074121.219686-3-hch@lst.de>
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

Instead of using arch_dma_alloc if none of the generic coherent
allocators are used, require the architectures to explicitly opt into
providing it.  This will used to deal with the case of m68knommu and
coldfire where we can't do any coherent allocations whatsoever, and
also makes it clear that arch_dma_alloc is a last resort.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm/Kconfig    |  1 +
 arch/m68k/Kconfig   |  1 +
 arch/parisc/Kconfig |  1 +
 kernel/dma/Kconfig  |  9 +++++++++
 kernel/dma/direct.c | 12 ++----------
 5 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 9557808e8937b1..a3fdf584278f86 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -4,6 +4,7 @@ config ARM
 	default y
 	select ARCH_32BIT_OFF_T
 	select ARCH_CORRECT_STACKTRACE_ON_KRETPROBE if HAVE_KRETPROBES && FRAME_POINTER && !ARM_UNWIND
+	select ARCH_DMA_ALLOC if MMU
 	select ARCH_HAS_BINFMT_FLAT
 	select ARCH_HAS_CPU_FINALIZE_INIT if MMU
 	select ARCH_HAS_CURRENT_STACK_POINTER
diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
index 3e318bf9504c5b..0430b8ba6b5cc6 100644
--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -3,6 +3,7 @@ config M68K
 	bool
 	default y
 	select ARCH_32BIT_OFF_T
+	select ARCH_DMA_ALLOC if !MMU || COLDFIRE
 	select ARCH_HAS_BINFMT_FLAT
 	select ARCH_HAS_CPU_FINALIZE_INIT if MMU
 	select ARCH_HAS_CURRENT_STACK_POINTER
diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
index a15ab147af2e07..30a4916fa9b0cc 100644
--- a/arch/parisc/Kconfig
+++ b/arch/parisc/Kconfig
@@ -3,6 +3,7 @@ config PARISC
 	def_bool y
 	select ALTERNATE_USER_ADDRESS_SPACE
 	select ARCH_32BIT_OFF_T if !64BIT
+	select ARCH_DMA_ALLOC if PA11
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select HAVE_FUNCTION_TRACER
 	select HAVE_FUNCTION_GRAPH_TRACER
diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
index 4524db877eba36..515d2063b509ac 100644
--- a/kernel/dma/Kconfig
+++ b/kernel/dma/Kconfig
@@ -144,6 +144,15 @@ config DMA_DIRECT_REMAP
 	select DMA_COHERENT_POOL
 	select DMA_NONCOHERENT_MMAP
 
+#
+# Fallback to arch code for DMA allocations.  This should eventually go away.
+#
+config ARCH_DMA_ALLOC
+	depends on !ARCH_HAS_DMA_SET_UNCACHED
+	depends on !DMA_DIRECT_REMAP
+	depends on !DMA_GLOBAL_POOL
+	bool
+
 config DMA_CMA
 	bool "DMA Contiguous Memory Allocator"
 	depends on HAVE_DMA_CONTIGUOUS && CMA
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 9596ae1aa0dacf..ec410af1d8a14e 100644
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
+		if (IS_ENABLED(CONFIG_ARCH_DMA_ALLOC) &&
 		    !is_swiotlb_for_alloc(dev))
 			return arch_dma_alloc(dev, size, dma_handle, gfp,
 					      attrs);
@@ -330,9 +324,7 @@ void dma_direct_free(struct device *dev, size_t size,
 		return;
 	}
 
-	if (!IS_ENABLED(CONFIG_ARCH_HAS_DMA_SET_UNCACHED) &&
-	    !IS_ENABLED(CONFIG_DMA_DIRECT_REMAP) &&
-	    !IS_ENABLED(CONFIG_DMA_GLOBAL_POOL) &&
+	if (IS_ENABLED(CONFIG_ARCH_DMA_ALLOC) &&
 	    !dev_is_dma_coherent(dev) &&
 	    !is_swiotlb_for_alloc(dev)) {
 		arch_dma_free(dev, size, cpu_addr, dma_addr, attrs);
-- 
2.39.2


