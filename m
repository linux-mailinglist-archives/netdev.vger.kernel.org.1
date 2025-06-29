Return-Path: <netdev+bounces-202240-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3985BAECDF1
	for <lists+netdev@lfdr.de>; Sun, 29 Jun 2025 16:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93EEC172C78
	for <lists+netdev@lfdr.de>; Sun, 29 Jun 2025 14:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 386E7227B9A;
	Sun, 29 Jun 2025 14:25:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3454227BA4;
	Sun, 29 Jun 2025 14:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751207150; cv=none; b=ub3eNmKkMjNwyOa2TVaCPJsumxD7JEqiZBYjFo/F3zPncO5beaaqGIX5e4konkSUdhKjp1kvIjlzTxOhDueWD55IaKpiKiO0KHewGsjxzlMjJXjpA5EILxlwJkquq6upCCFRYwHxtTe0Tiz9SPHGiMAT4+2R94uqvXV1ofi5xgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751207150; c=relaxed/simple;
	bh=E6AUdqXg1UQebluQC1Qcloluh833TMA6tD31kT9MSCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pX577WlsD30HHpsPN1MrhSx5F5vYRSNSNX1QqlJJrQ/VNhhHBs0F/kOyMc+lbh6xaGUzCVhHgWThPvJ3HHiTRTtyWW+XbHyPt3wBXBteFLqf9nMWMSLS4PPJYROEb4lpdDv22MLjOugLmFaE5y5nljHZgDZhrIR58+pJFHxYn2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1uVsyM-0000000015j-3WGk;
	Sun, 29 Jun 2025 14:25:34 +0000
Date: Sun, 29 Jun 2025 15:25:25 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Sky Huang <skylake.huang@mediatek.com>, netdev@vger.kernel.org,
	Sean Wang <sean.wang@mediatek.com>,
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	Bo-Cun Chen <bc-bocun.chen@mediatek.com>,
	Eric Woudstra <ericwouds@gmail.com>, Elad Yifee <eladwf@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Felix Fietkau <nbd@nbd.name>
Subject: Re: [PATCH net/next 3/3] net: ethernet: mtk_eth_soc: use genpool
 allocator for SRAM
Message-ID: <aGFM1UQ1P3IQjoex@makrotopia.org>
References: <cover.1751072868.git.daniel@makrotopia.org>
 <566ca90fc59ad0d3aff8bc8dc22ebaf0544bce47.1751072868.git.daniel@makrotopia.org>
 <f9bec387-1858-4c79-bb4b-60e744457c9f@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9bec387-1858-4c79-bb4b-60e744457c9f@lunn.ch>

On Sat, Jun 28, 2025 at 10:13:51AM +0200, Andrew Lunn wrote:
> > +static void *mtk_dma_ring_alloc(struct mtk_eth *eth, size_t size,
> > +				dma_addr_t *dma_handle)
> > +{
> > +	void *dma_ring;
> > +
> > +	if (WARN_ON(mtk_use_legacy_sram(eth)))
> > +		return -ENOMEM;
> > +
> > +	if (eth->sram_pool) {
> > +		dma_ring = (void *)gen_pool_alloc(eth->sram_pool, size);
> > +		if (!dma_ring)
> > +			return dma_ring;
> > +		*dma_handle = gen_pool_virt_to_phys(eth->sram_pool, (unsigned long)dma_ring);
> 
> I don't particularly like all the casting backwards and forwards
> between unsigned long and void *. These two APIs are not really
> compatible with each other. So any sort of wrapping is going to be
> messy.
> 
> Maybe define a cookie union:
> 
> struct mtk_dma_cookie {
> 	union {
> 		unsigned long gen_pool;
> 		void *coherent;
> 	}
> }

I've implemented that idea and the diffstat grew quite a lot. Also,
it didn't really make the code more readable (see below why).

> 
> Only dma_handle appears to be used by the rest of the code, so only
> the _alloc and _free need to know about the union.

That's not true. The void* ring->dma is used to access the RX and TX
descriptors, so keeping it void* is useful and using the struct you
are suggesting will make things even more messy than they already are.

See all the places in the code where we assume ring->dma being void*.
Converting all of those to use struct mtk_dma_cookie will not make things
better imho.

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/ethernet/mediatek/mtk_eth_soc.c#n1337

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/ethernet/mediatek/mtk_eth_soc.c#n1345

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/ethernet/mediatek/mtk_eth_soc.c#n1358

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/ethernet/mediatek/mtk_eth_soc.c#n1804

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/ethernet/mediatek/mtk_eth_soc.c#n2172

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/ethernet/mediatek/mtk_eth_soc.c#n2490

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/ethernet/mediatek/mtk_eth_soc.c#n2638

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/ethernet/mediatek/mtk_eth_soc.c#n2668

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/ethernet/mediatek/mtk_eth_soc.c#n2904

I think keeping the two casts in mtk_dma_ring_alloc() and
mtk_dma_ring_free() is the better option.

