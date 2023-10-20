Return-Path: <netdev+bounces-42881-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE567D07B1
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 07:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 662B0282040
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 05:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637F079E5;
	Fri, 20 Oct 2023 05:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZRlCImiC"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734257494
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 05:40:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05EEBD4C;
	Thu, 19 Oct 2023 22:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=G5eIP7CB6ER+Z8OijUse87xkJ6D3VkMkuWdOBa74oIQ=; b=ZRlCImiCePyyh+cxibViG/V1Xx
	b8uhkBd5bAB5YSOoHdb1bPIYaXKRJOLPhpKbgVeEc6jDpOHyOHWbAt+8La1y5dlML682X7/p9/s+o
	bDLt6I5Ud2LVqtRo4LPTJh5YwqXB9//YiGiwCCKv8TiNSHHTzjGUjf4O/RKBNa2qQ/JswPhVHvbyV
	S1SlBcYm8qZCcvapUlVpM0f4hJkMlcSTrtpdsbpcfClV2XWm+ScNgR3drz7tKzXDv/jSBLCpzZTy1
	OK4cu98zXoe8JzH9uTx7CPyZHpHE/W6s7MK7BnvsDSWH0/DFcg0AXvyiglGZHf39JmfGWkmRYWXMS
	oxtewfJQ==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qtiFT-001Gj2-2y;
	Fri, 20 Oct 2023 05:40:40 +0000
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
Subject: [PATCH 5/8] m68k: use the coherent DMA code for coldfire without data cache
Date: Fri, 20 Oct 2023 07:40:21 +0200
Message-Id: <20231020054024.78295-6-hch@lst.de>
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

Coldfire cores configured without a data cache are DMA coherent and
should thus simply use the simple coherent version of dma-direct.

Introduce a new COLDFIRE_COHERENT_DMA Kconfig symbol as a convenient
short hand for such configurations, and a M68K_NONCOHERENT_DMA symbol
for all cases where we need to build non-coherent DMA infrastructure
to simplify the Kconfig and code conditionals.

Not building the non-coherent DMA code slightly reduces the code
size for such configurations.

Numers for m5249evb_defconfig below:

  text	   data	    bss	    dec	    hex	filename
2896158	 401052	  65392	3362602	 334f2a	vmlinux.before
2895166	 400988	  65392	3361546	 334b0a	vmlinux.after

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Greg Ungerer <gerg@linux-m68k.org>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
Tested-by: Greg Ungerer <gerg@linux-m68k.org>
---
 arch/m68k/Kconfig         |  8 ++++----
 arch/m68k/Kconfig.cpu     | 12 ++++++++++++
 arch/m68k/kernel/Makefile |  2 +-
 arch/m68k/kernel/dma.c    |  2 +-
 4 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
index 4f3e7dec2171c8..50ada24dfbbadf 100644
--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -6,16 +6,16 @@ config M68K
 	select ARCH_HAS_BINFMT_FLAT
 	select ARCH_HAS_CPU_FINALIZE_INIT if MMU
 	select ARCH_HAS_CURRENT_STACK_POINTER
-	select ARCH_HAS_DMA_ALLOC if !MMU || COLDFIRE
-	select ARCH_HAS_DMA_PREP_COHERENT if HAS_DMA && MMU && !COLDFIRE
-	select ARCH_HAS_SYNC_DMA_FOR_DEVICE if HAS_DMA
+	select ARCH_HAS_DMA_ALLOC if M68K_NONCOHERENT_DMA && COLDFIRE
+	select ARCH_HAS_DMA_PREP_COHERENT if M68K_NONCOHERENT_DMA && !COLDFIRE
+	select ARCH_HAS_SYNC_DMA_FOR_DEVICE if M68K_NONCOHERENT_DMA
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG if RMW_INSNS
 	select ARCH_MIGHT_HAVE_PC_PARPORT if ISA
 	select ARCH_NO_PREEMPT if !COLDFIRE
 	select ARCH_USE_MEMTEST if MMU_MOTOROLA
 	select ARCH_WANT_IPC_PARSE_VERSION
 	select BINFMT_FLAT_ARGVP_ENVP_ON_STACK
-	select DMA_DIRECT_REMAP if HAS_DMA && MMU && !COLDFIRE
+	select DMA_DIRECT_REMAP if M68K_NONCOHERENT_DMA && !COLDFIRE
 	select GENERIC_ATOMIC64
 	select GENERIC_CPU_DEVICES
 	select GENERIC_IOMAP
diff --git a/arch/m68k/Kconfig.cpu b/arch/m68k/Kconfig.cpu
index b826e9c677b2ae..ad69b466a08bd1 100644
--- a/arch/m68k/Kconfig.cpu
+++ b/arch/m68k/Kconfig.cpu
@@ -535,3 +535,15 @@ config CACHE_COPYBACK
 	  The ColdFire CPU cache is set into Copy-back mode.
 endchoice
 endif # HAVE_CACHE_CB
+
+# Coldfire cores that do not have a data cache configured can do coherent DMA.
+config COLDFIRE_COHERENT_DMA
+	bool
+	default y
+	depends on COLDFIRE
+	depends on !HAVE_CACHE_CB && !CACHE_D && !CACHE_BOTH
+
+config M68K_NONCOHERENT_DMA
+	bool
+	default y
+	depends on HAS_DMA && !COLDFIRE_COHERENT_DMA
diff --git a/arch/m68k/kernel/Makefile b/arch/m68k/kernel/Makefile
index af015447dfb4c1..01fb69a5095f43 100644
--- a/arch/m68k/kernel/Makefile
+++ b/arch/m68k/kernel/Makefile
@@ -23,7 +23,7 @@ obj-$(CONFIG_MMU_MOTOROLA) += ints.o vectors.o
 obj-$(CONFIG_MMU_SUN3) += ints.o vectors.o
 obj-$(CONFIG_PCI) += pcibios.o
 
-obj-$(CONFIG_HAS_DMA)	+= dma.o
+obj-$(CONFIG_M68K_NONCOHERENT_DMA) += dma.o
 
 obj-$(CONFIG_KEXEC)		+= machine_kexec.o relocate_kernel.o
 obj-$(CONFIG_BOOTINFO_PROC)	+= bootinfo_proc.o
diff --git a/arch/m68k/kernel/dma.c b/arch/m68k/kernel/dma.c
index 2e192a5df949bb..f83870cfa79b37 100644
--- a/arch/m68k/kernel/dma.c
+++ b/arch/m68k/kernel/dma.c
@@ -17,7 +17,7 @@
 
 #include <asm/cacheflush.h>
 
-#if defined(CONFIG_MMU) && !defined(CONFIG_COLDFIRE)
+#ifndef CONFIG_COLDFIRE
 void arch_dma_prep_coherent(struct page *page, size_t size)
 {
 	cache_push(page_to_phys(page), size);
-- 
2.39.2


