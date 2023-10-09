Return-Path: <netdev+bounces-39078-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C3557BDCF0
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 14:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9418328150F
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 12:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84D191803A;
	Mon,  9 Oct 2023 12:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E52FE555
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 12:58:51 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F458F
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 05:58:50 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
	id C183A68CFE; Mon,  9 Oct 2023 14:58:44 +0200 (CEST)
Date: Mon, 9 Oct 2023 14:58:44 +0200
From: Christoph Hellwig <hch@lst.de>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Christoph Hellwig <hch@lst.de>, iommu@lists.linux.dev,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	NXP Linux Team <linux-imx@nxp.com>, linux-m68k@lists.linux-m68k.org,
	netdev@vger.kernel.org, Jim Quinlan <james.quinlan@broadcom.com>,
	Greg Ungerer <gerg@linux-m68k.org>
Subject: Re: [PATCH 5/6] net: fec: use dma_alloc_noncoherent for m532x
Message-ID: <20231009125843.GA7272@lst.de>
References: <20231009074121.219686-1-hch@lst.de> <20231009074121.219686-6-hch@lst.de> <ea608718-8a50-4f87-aecf-fc100d283fe8@arm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea608718-8a50-4f87-aecf-fc100d283fe8@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 09, 2023 at 11:29:12AM +0100, Robin Murphy wrote:
> It looks a bit odd that this ends up applying to all of Coldfire, while the 
> associated cache flush only applies to the M532x platform, which implies 
> that we'd now be relying on the non-coherent allocation actually being 
> coherent on other Coldfire platforms.
>
> Would it work to do something like this to make sure dma-direct does the 
> right thing on such platforms (which presumably don't have caches?), and 
> then reduce the scope of this FEC hack accordingly, to clean things up even 
> better?

Probably.  Actually Greg comment something along the lines last
time, and mentioned something about just instruction vs instruction
and data cache.

>
> diff --git a/arch/m68k/Kconfig.cpu b/arch/m68k/Kconfig.cpu
> index b826e9c677b2..1851fa3fe077 100644
> --- a/arch/m68k/Kconfig.cpu
> +++ b/arch/m68k/Kconfig.cpu
> @@ -27,6 +27,7 @@ config COLDFIRE
>  	select CPU_HAS_NO_BITFIELDS
>  	select CPU_HAS_NO_CAS
>  	select CPU_HAS_NO_MULDIV64
> +	select DMA_DEFAULT_COHERENT if !MMU && !M523x

Although it would probably make more sense to simply not select
CONFIG_ARCH_HAS_SYNC_DMA_FOR_DEVICE and
CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU for these platforms and not
build the non-coherent code at all.  This should also include
all coldfire platforms with mmu (M54xx/M548x/M5441x).  Then
again for many of the coldfire platforms the Kconfig allows
to select CACHE_WRITETHRU/CACHE_COPYBACK which looks related.

Greg, any chance you could help out with the caching modes on
coldfire and legacy m68knommu?


