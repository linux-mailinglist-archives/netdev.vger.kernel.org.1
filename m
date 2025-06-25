Return-Path: <netdev+bounces-201015-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D4B2AE7DD0
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 11:47:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1EF816BB00
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 09:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0339C29B797;
	Wed, 25 Jun 2025 09:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mFqWk2Ed"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF38329ACFA;
	Wed, 25 Jun 2025 09:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750844416; cv=none; b=rsSl/L4Hmlwl9auqiiRUz3Ha1kjv+x7cSmq2fgXDGSffDsYg9BflwFqPe3JtNBKkkwMF4TZHhJiJlgvP7BImu70MxIx4+VNfTVbBJm+h0MdWynttKuBdw+rPZIAxGl69BfvZsl4EiwcYpdUqykfmLoe6TmICTt0xp4zSE2QE8ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750844416; c=relaxed/simple;
	bh=Dz/zi2vBTU9RAcB3YC2BaOA4M6ssvm3AVyFc4F415Bs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cVW1dha5u4rIi/zkc3MZc5BakfAAEi6KBGK+QxmBcWGaAlK8UuoqyLTQdoOAyChlX3qAyrhVY2odTcBbiz56nD3z00T56WF0NDowoDRkxFuim8JRND4qFYjhKeqDxPQVga30JelDeKtmTtyTtnWGdSnggz0NyH7QjLzqPGgDv8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mFqWk2Ed; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E0EAC4CEEA;
	Wed, 25 Jun 2025 09:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750844416;
	bh=Dz/zi2vBTU9RAcB3YC2BaOA4M6ssvm3AVyFc4F415Bs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mFqWk2EdHJG0FIVnRH1+BUssUZak2X4ezgO8WnQ1exyCJk6rVpBOiUxU1jgCbjLsU
	 wSKwDamV2ht7PkEYJxk3V77YQ68bk1jkeVPClCExZ/2evkqZ01rMLX2lO3hugV9yTZ
	 Of+inbxwb8/FOT3AMXqIMRqXgKyF4JAR31/bU5fxlzPGxjRyzqvJQzSw9rG+wbK9st
	 8RLJAUtDobLmUO8plCeVBCf86KEHicIt/zBdhDCcgeg24agCI4DjGNiriWdoyRtrgR
	 USpm+uGVmhGa+cPX4sxLoeSI0N3GEw3ZuGa3Pdfgp+4eT1oZxwe3sMQEKzp3kv0imK
	 naLSjrsW2PU8g==
Date: Wed, 25 Jun 2025 10:40:13 +0100
From: Simon Horman <horms@kernel.org>
To: Thomas Fourier <fourier.thomas@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Chas Williams <3chas3@gmail.com>,
	"moderated list:ATM" <linux-atm-general@lists.sourceforge.net>,
	"open list:ATM" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] atm: idt77252: Add missing `dma_map_error()`
Message-ID: <20250625094013.GL1562@horms.kernel.org>
References: <20250624064148.12815-3-fourier.thomas@gmail.com>
 <20250624165128.GA1562@horms.kernel.org>
 <4c6deafe-a6ec-40bf-873f-dc0df1a72dc4@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c6deafe-a6ec-40bf-873f-dc0df1a72dc4@gmail.com>

On Wed, Jun 25, 2025 at 11:14:56AM +0200, Thomas Fourier wrote:
> On 24/06/2025 18:51, Simon Horman wrote:
> > On Tue, Jun 24, 2025 at 08:41:47AM +0200, Thomas Fourier wrote:
> > > The DMA map functions can fail and should be tested for errors.
> > > 
> > > Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
> > > ---
> > >   drivers/atm/idt77252.c | 5 +++++
> > >   1 file changed, 5 insertions(+)
> > > 
> > > diff --git a/drivers/atm/idt77252.c b/drivers/atm/idt77252.c
> > > index 1206ab764ba9..f2e91b7d79f0 100644
> > > --- a/drivers/atm/idt77252.c
> > > +++ b/drivers/atm/idt77252.c
> > > @@ -852,6 +852,8 @@ queue_skb(struct idt77252_dev *card, struct vc_map *vc,
> > >   	IDT77252_PRV_PADDR(skb) = dma_map_single(&card->pcidev->dev, skb->data,
> > >   						 skb->len, DMA_TO_DEVICE);
> > > +	if (dma_mapping_error(&card->pcidev->dev, IDT77252_PRV_PADDR(skb)))
> > > +		return -ENOMEM;
> > >   	error = -EINVAL;
> > > @@ -1857,6 +1859,8 @@ add_rx_skb(struct idt77252_dev *card, int queue,
> > >   		paddr = dma_map_single(&card->pcidev->dev, skb->data,
> > >   				       skb_end_pointer(skb) - skb->data,
> > >   				       DMA_FROM_DEVICE);
> > > +		if (dma_mapping_error(&card->pcidev->dev, paddr))
> > > +			goto outpoolrm;
> > >   		IDT77252_PRV_PADDR(skb) = paddr;
> > >   		if (push_rx_skb(card, skb, queue)) {
> > > @@ -1871,6 +1875,7 @@ add_rx_skb(struct idt77252_dev *card, int queue,
> > >   	dma_unmap_single(&card->pcidev->dev, IDT77252_PRV_PADDR(skb),
> > >   			 skb_end_pointer(skb) - skb->data, DMA_FROM_DEVICE);
> > > +outpoolrm:
> > >   	handle = IDT77252_PRV_POOL(skb);
> > >   	card->sbpool[POOL_QUEUE(handle)].skb[POOL_INDEX(handle)] = NULL;
> > Hi Thomas,
> > 
> > Can sb_pool_remove() be used here?
> > It seems to be the converse of sb_pool_add().
> > And safer than the code above.
> > But perhaps I'm missing something.
> 
> 
> Hi Simon,
> 
> I don't see any reason why this would be a problem,
> 
> though, I don't think it is related and the change should be in the same
> patch.

Yes, good point. In that case this patch looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

> Should I create another patch for that?

I think that would be nice. But let's wait for this patch to land first.

