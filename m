Return-Path: <netdev+bounces-38963-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D75997BD481
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 09:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 146B51C20A5C
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 07:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD37B11C81;
	Mon,  9 Oct 2023 07:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Z2Xg8ghT"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DCD514F7A
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 07:41:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA103A2;
	Mon,  9 Oct 2023 00:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=RfzJ0rmOfGgYG4ZhoNJ82M0rcD99jku72cgM5LPVp6w=; b=Z2Xg8ghTSFAMg3I86jHLAAJKXC
	E0d7HDALoYG8ZJWGjbvYuwdGx+RCXgdttGLPjSzLqzAmrEtudQIQNiQ40+iZ3bz6ICbwxBVveGmJ+
	wJFupjJmKd5ThYjfkAEvAC05bI3gOU6DR11ZCjNVqydjKc3o1VzgKq7rJXLzIzLD0vl01AVoESCpA
	VFkXP9b2wCtNE1vaOR5RE/5ZlHFKShRXTCOlxf2FQos4O6J0DcXW57ZtSLzXRx7nKXgG5IA22yvfL
	IuWNG/peBdQ8ALcaGfw0AW3TYu+Bo24xl9KbXcMpHHP1RzC+Ez7KkC+BtYpaC0jQ8r8RM0E6kVdHA
	rVhFQWsA==;
Received: from [2001:4bb8:182:6657:e5a9:584c:4324:b228] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qpktV-009ui9-2b;
	Mon, 09 Oct 2023 07:41:38 +0000
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
Subject: [PATCH 4/6] dma-direct: warn when coherent allocations aren't supported
Date: Mon,  9 Oct 2023 09:41:19 +0200
Message-Id: <20231009074121.219686-5-hch@lst.de>
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

Log a warning once when dma_alloc_coherent fails because the platform
does not support coherent allocations at all.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/dma/direct.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 1327d04fa32a25..fddfea3b2fe173 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -240,8 +240,10 @@ void *dma_direct_alloc(struct device *dev, size_t size,
 		 */
 		set_uncached = IS_ENABLED(CONFIG_ARCH_HAS_DMA_SET_UNCACHED);
 		remap = IS_ENABLED(CONFIG_DMA_DIRECT_REMAP);
-		if (!set_uncached && !remap)
+		if (!set_uncached && !remap) {
+			pr_warn_once("coherent DMA allocations not supported on this platform.\n");
 			return NULL;
+		}
 	}
 
 	/*
-- 
2.39.2


