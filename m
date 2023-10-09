Return-Path: <netdev+bounces-38960-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E6787BD47E
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 09:41:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 191A21C20BB3
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 07:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DDD6125CB;
	Mon,  9 Oct 2023 07:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pr0vjBrl"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B537611734
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 07:41:39 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7204394;
	Mon,  9 Oct 2023 00:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=/l9PqXALl8eAHGVDXCtCLR3TdmMUZiHoVO4DUFj3woY=; b=pr0vjBrlwdqYfzLiQLVLo1UoPR
	+dHb37jfGrj+WoUBM5SXfiSNErJ3LrxCvSMM5fAWPv5UoOC/+B/4Yqpca23AHR4XEmXRksyJfR3Yr
	iKcB14cUDgNZLQo0UoarKm0YCX3EXTymHw4abrfcPNcsPhfxo3Gb3EAJfCnPbqhl3xZU1i65VEh/s
	uIbQISG9onx8Unz9nchdyrMPvLEtOoEsqB1v35R7fiuAJAvEkTk/L7JoTH/1xqFORLuucqRe8ELpN
	N0KG63v2NoRrBqggLx1+YZtVoQDz8scF4l46a1J7YooxDbKtFGvDZ913Vp7BDWWIljfZHrjSAm/zF
	9EXvK9/g==;
Received: from [2001:4bb8:182:6657:e5a9:584c:4324:b228] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qpktN-009uhZ-13;
	Mon, 09 Oct 2023 07:41:29 +0000
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
Subject: [PATCH 1/6] dma-direct: add depdenencies to CONFIG_DMA_GLOBAL_POOL
Date: Mon,  9 Oct 2023 09:41:16 +0200
Message-Id: <20231009074121.219686-2-hch@lst.de>
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

CONFIG_DMA_GLOBAL_POOL can't be combined with other dma-coherent
allocators.  Add dependencies to Kconfig to document this, and make
kconfig complain about unment dependencies if someone tries.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/dma/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
index f488997b071712..4524db877eba36 100644
--- a/kernel/dma/Kconfig
+++ b/kernel/dma/Kconfig
@@ -135,6 +135,8 @@ config DMA_COHERENT_POOL
 
 config DMA_GLOBAL_POOL
 	select DMA_DECLARE_COHERENT
+	depends on !ARCH_HAS_DMA_SET_UNCACHED
+	depends on !DMA_DIRECT_REMAP
 	bool
 
 config DMA_DIRECT_REMAP
-- 
2.39.2


