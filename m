Return-Path: <netdev+bounces-202260-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B47CDAECF85
	for <lists+netdev@lfdr.de>; Sun, 29 Jun 2025 20:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F20433B518B
	for <lists+netdev@lfdr.de>; Sun, 29 Jun 2025 18:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F0B230BE4;
	Sun, 29 Jun 2025 18:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="2BExNKnz"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37CB19ADBF;
	Sun, 29 Jun 2025 18:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751221422; cv=none; b=DEYdi2Tgsyp7VV+MDHjG6Ou+uKfy5y6w/8i9arl2KmsCIexu0JCMp/+ZlhEoAxeHCkzo6xuVApOUXKtAMMX2zhnl3KidyeHaXPfCQVaj9c05w/0UxlVP4Cx6Drw09IzNa3nszVr2fANBPbooxd/vQfmpaxKBiuBbcc3CWKpRKa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751221422; c=relaxed/simple;
	bh=/rz2FI8H+POPGjv2Q6JSUisZ54jqo+pekP+5RDuodFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eUKzGfg+8mRBWKfvBUrZ1+ROi6VRh99Pi3dx9LlKw8E6sD4TrpGMpLCdJn1twop26KPobxdXdBBUTRxpEVaFNtS8AUuKzc0A1nShM8hqybHrZkFCiHtJPcQIwTZlSW7YrNhstvF5ShdxdvvPvHX77e7xPgagsLORQIgsvXIbkAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=2BExNKnz; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Myxtx+Y7/VaI8ABGRupGWXUe5PVGaahjgE4X+AhP3TM=; b=2BExNKnzg/xdwxUfR70MEs+omD
	rWHPQp6QwjrGMrAaY5LVF0Yq8UVGDbvUgH7dP/sK9feaCAJs8J+aY4XPYsaMRVQBMHNxAcqKrrvSA
	p4Tq1D+srrUj+fQc/tZ1J6T7lq8RjAAXTAHbHI11eNajevRsOL3fbUkQP8gNsiHoIdzo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uVwgi-00HIEC-Uz; Sun, 29 Jun 2025 20:23:36 +0200
Date: Sun, 29 Jun 2025 20:23:36 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Golle <daniel@makrotopia.org>
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
Message-ID: <ea30ed46-b0b5-4ade-8267-f6f4a45fdd5d@lunn.ch>
References: <cover.1751072868.git.daniel@makrotopia.org>
 <566ca90fc59ad0d3aff8bc8dc22ebaf0544bce47.1751072868.git.daniel@makrotopia.org>
 <f9bec387-1858-4c79-bb4b-60e744457c9f@lunn.ch>
 <aGFM1UQ1P3IQjoex@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGFM1UQ1P3IQjoex@makrotopia.org>

On Sun, Jun 29, 2025 at 03:25:25PM +0100, Daniel Golle wrote:
> On Sat, Jun 28, 2025 at 10:13:51AM +0200, Andrew Lunn wrote:
> > > +static void *mtk_dma_ring_alloc(struct mtk_eth *eth, size_t size,
> > > +				dma_addr_t *dma_handle)
> > > +{
> > > +	void *dma_ring;
> > > +
> > > +	if (WARN_ON(mtk_use_legacy_sram(eth)))
> > > +		return -ENOMEM;
> > > +
> > > +	if (eth->sram_pool) {
> > > +		dma_ring = (void *)gen_pool_alloc(eth->sram_pool, size);
> > > +		if (!dma_ring)
> > > +			return dma_ring;
> > > +		*dma_handle = gen_pool_virt_to_phys(eth->sram_pool, (unsigned long)dma_ring);
> > 
> > I don't particularly like all the casting backwards and forwards
> > between unsigned long and void *. These two APIs are not really
> > compatible with each other. So any sort of wrapping is going to be
> > messy.
> > 
> > Maybe define a cookie union:
> > 
> > struct mtk_dma_cookie {
> > 	union {
> > 		unsigned long gen_pool;
> > 		void *coherent;
> > 	}
> > }
> 
> I've implemented that idea and the diffstat grew quite a lot. Also,
> it didn't really make the code more readable (see below why).

O.K, thanks for trying. Please keep with the casts back and forth.

	Andrew

