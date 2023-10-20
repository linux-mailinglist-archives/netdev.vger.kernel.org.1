Return-Path: <netdev+bounces-42877-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 574817D07AC
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 07:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5DF8B21571
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 05:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC53979DB;
	Fri, 20 Oct 2023 05:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Zkid2MHI"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF0563A6
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 05:40:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F2BD1A6;
	Thu, 19 Oct 2023 22:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=mDzIZQ/fWeGbPC1Nok0DTdolfJiMn3Mwfk8q0zRywXg=; b=Zkid2MHIF1cA1H/8btD9RK46S0
	DQw5wFVpnnItjVm66zLBOc9O6J+W72q275CLIN1NcjVR5QfqoLPPWyM6EjvuyAuMVwxLURVF4+P5d
	3+3uyiI+tq3PO1oy7b7rGbf4XBxyL6Y5vzkUPtxqeBfZZI2juxaFYTA2ZsQ2WBJ9+EoUGlt5y8vYZ
	0XLIE2jo6wCkwM/ZIOhmBWklWGmkicd2UHcYy8rulvNR8QW+SwaWTsJ/H20gPumXGfDpwEf22jw7Y
	m05fakPg7dP87bWP20LxqVrBM/GUWPQms6PtxxsQJd2m4nt+7I6VDZwK4YS9Cy8cLCYPvn4mF09qW
	3YmepUXA==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1qtiFI-001GiC-08;
	Fri, 20 Oct 2023 05:40:28 +0000
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
Subject: fix the non-coherent coldfire dma_alloc_coherent v4
Date: Fri, 20 Oct 2023 07:40:16 +0200
Message-Id: <20231020054024.78295-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi all,

this is the next attempt to not return memory that is not DMA coherent
on coldfire/m68knommu.  The last one needed more fixups in the fec
driver, which this versions includes.  On top of that I've also added
a few more cleanups to the core DMA allocation code.

Note: without the separately submitted

   fix a few RISC-V / renesas Kconfig dependencies

series this will cause Kconfig warnings on riscv.   These warnings are
due to real dependency issues, so I do not plan to hold the series for
those patches to be applied.


Changes since v2:
 - drop the separatly submitted riscv/soc patches and rebase on top of the
   soc tree
 - rename CONFIG_ARCH_DMA_ALLOC to ARCH_HAS_DMA_ALLOC
 - fix stray CONFIG_ prefixes in a Kconfig file

Changes since v1:
 - sort out the dependency mess in RISCV
 - don't even built non-coherent DMA support for coldfire cores without
   data caches
 - apply the fec workarounds to all coldfire platforms with data caches
 - add a trivial cleanup for m68k dma.c

