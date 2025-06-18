Return-Path: <netdev+bounces-199065-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CECEFADECD5
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 14:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B0BA1883D34
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 12:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D659285CA2;
	Wed, 18 Jun 2025 12:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IKn06Ka/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4572D052;
	Wed, 18 Jun 2025 12:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750250338; cv=none; b=IlEHVzKbJIEBztC1icDsYjq60a7Yp3AqMVtbwEOBrnbDO064b+OwCQHRJZuZfaCyddOl6dAqYAnnN/Y+GIEYMMD/IeHhcivqXFYw8NChZcFZvSDGodFrWo9UXoCJGIQ4Nu+V76QDEIKayemFOwhgA4PH9ZwpG9nhEw8fQ90O8+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750250338; c=relaxed/simple;
	bh=kfP7CXAylEvUUUVxZ1zBTw/StB04PQhWmvq9ai1p+tg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mx3KF9PZoFPnO9Knic9pBE4n7e6OqACt82l/d1Cwzj0DVig+I1vIPtubYSfeb4qCFeU8SgpRXLA8dkBPwYHEge4/v6eGRjp7UYew1BMBCavvfQ/j7ZZShYtE3OnNyk8g7h3GIOi3cHRx0ypzRGqCIId0/fQaZOyp90BYbNG0JBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IKn06Ka/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07100C4CEE7;
	Wed, 18 Jun 2025 12:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750250338;
	bh=kfP7CXAylEvUUUVxZ1zBTw/StB04PQhWmvq9ai1p+tg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IKn06Ka/W8jBpvkt7jkRk+Jr2p63w6jL935h2WwftxJNrU0NXMtDF/ON1m0u3kTDm
	 NhEmSEtl6uAjse7HPW17x+ihOxk4+bqFjmLGNDZm+xSHciTBRZnEYjv/YnJIKrQRQH
	 3wv2E7cxlRjVZ0brU1J2sl96zpDJ7ygcSYrVv41Gs8MUF8CsT2tzMJ/V+COvxXGnOy
	 32U1JzoWrbWFxC2hwtexOtcgFpeouI62XGgI2+geYfpMVl3yp63wQvSM8LzA+x+CFz
	 QWRlhTe1Fvarf7jk+JBT3fK92XCMa/gYlNVz7TAzTOuv/IArHEJ97egPGDp+0u4Mfj
	 1T63PTmBm3s0g==
Date: Wed, 18 Jun 2025 13:38:53 +0100
From: Simon Horman <horms@kernel.org>
To: Frank Wunderlich <frank-w@public-files.de>
Cc: linux@fw-web.de, nbd@nbd.name, sean.wang@mediatek.com,
	lorenzo@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, daniel@makrotopia.org,
	arinc.unal@arinc9.com
Subject: Re: Re: [net-next v4 3/3] net: ethernet: mtk_eth_soc: change code to
 skip first IRQ completely
Message-ID: <20250618123853.GO1699@horms.kernel.org>
References: <20250616080738.117993-1-linux@fw-web.de>
 <20250616080738.117993-4-linux@fw-web.de>
 <20250618083556.GE2545@horms.kernel.org>
 <trinity-98989ec6-5b15-49ab-b7e0-60e5e23dd82b-1750238087001@trinity-msg-rest-gmx-gmx-live-847b5f5c86-t48nw>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <trinity-98989ec6-5b15-49ab-b7e0-60e5e23dd82b-1750238087001@trinity-msg-rest-gmx-gmx-live-847b5f5c86-t48nw>

On Wed, Jun 18, 2025 at 09:14:47AM +0000, Frank Wunderlich wrote:
> Hi Simon,
> 
> thanks for your review
> 
> > Gesendet: Mittwoch, 18. Juni 2025 um 10:35
> > Von: "Simon Horman" <horms@kernel.org>
> > Betreff: Re: [net-next v4 3/3] net: ethernet: mtk_eth_soc: change code to skip first IRQ completely
> >
> > On Mon, Jun 16, 2025 at 10:07:36AM +0200, Frank Wunderlich wrote:
> > > From: Frank Wunderlich <frank-w@public-files.de>
> > > 
> > > On SoCs without MTK_SHARED_INT capability (mt7621 + mt7628) the first
> > > IRQ (eth->irq[0]) was read but never used. Do not read it and reduce
> > > the IRQ-count to 2 because of skipped index 0.
> > 
> > Describing the first IRQ as read seems a bit confusing to me - do we read
> > it? And saying get or got seems hard to parse. So perhaps something like
> > this would be clearer?
> > 
> > ... platform_get_irq() is called for the first IRQ (eth->irq[0]) but
> > it is never used.
> 
> ok, i change it in next version
> 
> > > 
> > > Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> > > ---
> > > v4:
> > > - drop >2 condition as max is already 2 and drop the else continue
> > > - update comment to explain which IRQs are taken in legacy way
> > > ---
> > >  drivers/net/ethernet/mediatek/mtk_eth_soc.c | 20 ++++++++++++++++----
> > >  drivers/net/ethernet/mediatek/mtk_eth_soc.h |  4 ++--
> > >  2 files changed, 18 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> > > index 3ecb399dcf81..f3fcbb00822c 100644
> > > --- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> > > +++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
> > > @@ -3341,16 +3341,28 @@ static int mtk_get_irqs(struct platform_device *pdev, struct mtk_eth *eth)
> > >  {
> > >  	int i;
> > >  
> > > +	/* future SoCs beginning with MT7988 should use named IRQs in dts */
> > 
> > Perhaps this comment belongs in the patch that adds support for named IRQs.
> 
> also thought that after sending it :)
> 
> > >  	eth->irq[MTK_ETH_IRQ_TX] = platform_get_irq_byname(pdev, "tx");
> > >  	eth->irq[MTK_ETH_IRQ_RX] = platform_get_irq_byname(pdev, "rx");
> > >  	if (eth->irq[MTK_ETH_IRQ_TX] >= 0 && eth->irq[MTK_ETH_IRQ_RX] >= 0)
> > >  		return 0;
> > >  
> > > +	/* legacy way:
> > > +	 * On MTK_SHARED_INT SoCs (MT7621 + MT7628) the first IRQ is taken from
> > > +	 * devicetree and used for rx+tx.
> > > +	 * On SoCs with non-shared IRQ the first was not used, second entry is
> > > +	 * TX and third is RX.
> > 
> > Maybe I am slow. But I had a bit of trouble parsing this.
> > Perhaps this is clearer?
> > 
> >         * devicetree and used for both RX and TX - it is shared.
> > 	* On SoCs with non-shared IRQs the first entry is not used,
> >         * the second is for TX, and the third is for RX.
> 
> I would also move this comment in first patch with your changes requested.

Yes, good point.

> 
> /* legacy way:
>  * On MTK_SHARED_INT SoCs (MT7621 + MT7628) the first IRQ is taken from
>  * devicetree and used for both RX and TX - it is shared.
>  * On SoCs with non-shared IRQs the first entry is not used,
>  * the second is for TX, and the third is for RX.
>  */
> 
> i can keep your RB there?

Yes, thanks for asking.

> 
> > > +	 */
> > > +
> > >  	for (i = 0; i < MTK_ETH_IRQ_MAX; i++) {
> > > -		if (MTK_HAS_CAPS(eth->soc->caps, MTK_SHARED_INT) && i > 0)
> > > -			eth->irq[i] = eth->irq[MTK_ETH_IRQ_SHARED];
> > > -		else
> > > -			eth->irq[i] = platform_get_irq(pdev, i);
> > > +		if (MTK_HAS_CAPS(eth->soc->caps, MTK_SHARED_INT)) {
> > > +			if (i == 0)
> > > +				eth->irq[MTK_ETH_IRQ_SHARED] = platform_get_irq(pdev, i);
> > > +			else
> > > +				eth->irq[i] = eth->irq[MTK_ETH_IRQ_SHARED];
> > > +		} else {
> > > +			eth->irq[i] = platform_get_irq(pdev, i + 1);
> > > +		}
> > >  
> > >  		if (eth->irq[i] < 0) {
> > >  			dev_err(&pdev->dev, "no IRQ%d resource found\n", i);
> 
> code changes are OK?

Yes. I did try to think of a more succinct way to express the logic.
But I think what you have is good.

In any case, let me review the next revision of this patch.
That will be easier for me than imagining what it looks like
with the non-code changes discussed above in place.


