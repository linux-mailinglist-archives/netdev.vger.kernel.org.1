Return-Path: <netdev+bounces-42876-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D9B7D07AB
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 07:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27AA9B213A2
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 05:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B69163C2;
	Fri, 20 Oct 2023 05:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="V+84zKat"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9D81612E
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 05:40:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E85E91A4;
	Thu, 19 Oct 2023 22:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=yee1QAcotKE4LLlo4tSe49OoGTbkbZfuS57I8Vzt7i8=; b=V+84zKatvikvgQsDl7XDaGTQv9
	KompkKpM1gbHFLlzZgAK7G/4b9OXYxiZh7zre8MTJaPGg2n+YhbGcxJ/bqmhOktaohu4lOC2g/r09
	Aq9xWcOJ+3ssRGbz7untCblAGB4XZPUPVySFRGyhZe+nRvHgUabHBwv2icPwANwC2rKOXb3ULaMkK
	QDHgHg7PY3hqO+855nGbIpUVm0Lx98Jy+JFaOXTsfMSJnOR1EtuqiMg7yYsM+pvVGEU6EVYIhr699
	YGsVcFhE2IZynJC5ysoPM3kwwmX6Dujzs9ZluwgO0GgQE4yH0/9EXllv80aizbIz5m17SzJRSwjZI
	RsA9TSCQ==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qtiFK-001GiF-1B;
	Fri, 20 Oct 2023 05:40:30 +0000
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
	netdev@vger.kernel.org,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH 1/8] dma-direct: add depdenencies to CONFIG_DMA_GLOBAL_POOL
Date: Fri, 20 Oct 2023 07:40:17 +0200
Message-Id: <20231020054024.78295-2-hch@lst.de>
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

CONFIG_DMA_GLOBAL_POOL can't be combined with other DMA coherent
allocators.  Add dependencies to Kconfig to document this, and make
kconfig complain about unment dependencies if someone tries.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Greg Ungerer <gerg@linux-m68k.org>
Tested-by: Greg Ungerer <gerg@linux-m68k.org>
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


