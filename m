Return-Path: <netdev+bounces-164695-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62AD8A2EBD7
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 12:50:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1999416754D
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 11:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492E51E1C36;
	Mon, 10 Feb 2025 11:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="YXQ0SaM/"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21001F3B8B
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 11:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739188176; cv=none; b=KHeNdRlctT3/1E1u9QjXZ/LMCCYx0xqfEbWNMtJnXO+rBqd5EpckEraW+7Uk0uTMkl0Shdrc9sN5qxg+/gKRJzv1a2lAy1uFLI7MTNAdnCOu7OHCXS3dkAILB4DkqGDRhw80/drnEQF2w30ixl/pQCLfoMhrO9+k38Lf/r6XaKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739188176; c=relaxed/simple;
	bh=NyUW+7L4qdKSMRm0LDZB55r1JGU5bbVGB48WORx0Ybg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KXqcReQm/pAXpQAMshig8ItWl029QC0vUDGlxkCcP6FGi3lWMNyi2mCUBbR7/3zAZgl1AU6fbdl9on2lBYDJoy7hvUXPVo4gZvWgqoPqCoXz/XBQM8/LC9ihlDBoa96jDPupCG22u/i3249sT7O3OohH5RwWm9xH0eGAMAXFmsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=YXQ0SaM/; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=IhledqYr6SUwWzZvqTEaJI10jrEMaqjmTRFdfHkmzaM=; b=YXQ0SaM/U3uF+CQtvmMp+h+5wr
	m7vCyRZshyIOpvjMSb/wd4Sqe9Tapexp7PSK2cgvMm6tohypb7zpc0t8JNJEqi6fDD+IK1/ByFT6s
	BLJw495yLSYwaCMjiPTlL/RaJ38Hnfw6VokvshcHmFNEsXyyreE2od9SJ+r6s5hZa0hvrVN2PWKMq
	nWhyFbEts19IF8geImmd7eYHNYUJNtdmfO0jIDY6xR+SRT8TbRiT0tnfOpfb9VrfYYQVjhKtFuq3T
	/zW1897tLkVUWrvewnlA9quNQgyddEqlcoesMxLQb4hr+n/deBY1ieGzvgRcawHgSpPmaYx8cEE07
	BbXh9Izw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:46520)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1thSI0-0006hy-0N;
	Mon, 10 Feb 2025 11:49:24 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1thSHx-0007TG-2e;
	Mon, 10 Feb 2025 11:49:21 +0000
Date: Mon, 10 Feb 2025 11:49:21 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Tristram.Ha@microchip.com, UNGLinuxDriver@microchip.com,
	Woojung Huh <woojung.huh@microchip.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH RFC net-next 4/4] net: xpcs: allow 1000BASE-X to work
 with older XPCS IP
Message-ID: <Z6nnwfPtm9LqK3rd@shell.armlinux.org.uk>
References: <Z6NnPm13D1n5-Qlw@shell.armlinux.org.uk>
 <Z6NnPm13D1n5-Qlw@shell.armlinux.org.uk>
 <E1tffRT-003Z5u-CY@rmk-PC.armlinux.org.uk>
 <E1tffRT-003Z5u-CY@rmk-PC.armlinux.org.uk>
 <20250210110555.stuowh5l6hmz2yxh@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250210110555.stuowh5l6hmz2yxh@skbuf>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Feb 10, 2025 at 01:05:55PM +0200, Vladimir Oltean wrote:
> On Wed, Feb 05, 2025 at 01:27:47PM +0000, Russell King (Oracle) wrote:
> > Older XPCS IP requires SGMII_LINK and PHY_SIDE_SGMII to be set when
> > operating in 1000BASE-X mode even though the XPCS is not configured for
> > SGMII. An example of a device with older XPCS IP is KSZ9477.
> > 
> > We already don't clear these bits if we switch from SGMII to 1000BASE-X
> > on TXGBE - which would result in 1000BASE-X with the PHY_SIDE_SGMII bit
> > left set.
> 
> Is there a confirmation written down somewhere that a transition from
> SGMII to 1000Base-X was explicitly tested? I have to remain a bit
> skeptical and say that although the code is indeed like this, it
> doesn't mean by itself there are no unintended side effects.
> 
> > It is currently believed to be safe to set both bits on newer IP
> > without side-effects.
> > 
> > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > ---
> >  drivers/net/pcs/pcs-xpcs.c | 13 +++++++++++--
> >  drivers/net/pcs/pcs-xpcs.h |  1 +
> >  2 files changed, 12 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
> > index 1eba0c583f16..d522e4a5a138 100644
> > --- a/drivers/net/pcs/pcs-xpcs.c
> > +++ b/drivers/net/pcs/pcs-xpcs.c
> > @@ -774,9 +774,18 @@ static int xpcs_config_aneg_c37_1000basex(struct dw_xpcs *xpcs,
> >  			return ret;
> >  	}
> >  
> > -	mask = DW_VR_MII_PCS_MODE_MASK;
> > +	/* Older XPCS IP requires PHY_MODE (bit 3) and SGMII_LINK (but 4) to
>                                                                    ~~~
>                                                                    bit
> 
> > +	 * be set when operating in 1000BASE-X mode. See page 233
> > +	 * https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/ProductDocuments/DataSheets/KSZ9477S-Data-Sheet-DS00002392C.pdf
> > +	 * "5.5.9 SGMII AUTO-NEGOTIATION CONTROL REGISTER"
> > +	 */
> > +	mask = DW_VR_MII_PCS_MODE_MASK | DW_VR_MII_AN_CTRL_SGMII_LINK |
> > +	       DW_VR_MII_TX_CONFIG_MASK;
> >  	val = FIELD_PREP(DW_VR_MII_PCS_MODE_MASK,
> > -			 DW_VR_MII_PCS_MODE_C37_1000BASEX);
> > +			 DW_VR_MII_PCS_MODE_C37_1000BASEX) |
> > +	      FIELD_PREP(DW_VR_MII_TX_CONFIG_MASK,
> > +			 DW_VR_MII_TX_CONFIG_PHY_SIDE_SGMII) |
> > +	      DW_VR_MII_AN_CTRL_SGMII_LINK;
> >  
> >  	if (!xpcs->pcs.poll) {
> >  		mask |= DW_VR_MII_AN_INTR_EN;
> 
> I do believe that this is the kind of patch one would write when the
> hardware is completely a black box. But when we have Microchip engineers
> here with a channel open towards their hardware design who can help
> clarify where the requirement comes from, that just isn't the case.
> So I wouldn't rush with this.
> 
> Plus, it isn't even the most conservative way in which a (supposedly)
> integration-specific requirement is fulfilled in the common Synopsys
> driver. If one integration makes vendor-specific choices about these
> bits, I wouldn't assume that no other vendors made contradictory choices.
> 
> I don't want to say too much before Tristram comes with a statement from
> Microchip hardware design, but _if_ it turns out to be a KSZ9477
> specific requirement, it still seems safer to only enable this based
> (at least) on Tristram's MICROCHIP_KSZ9477_PMA_ID conditional from his
> other patch set, if not based on something stronger (a conditional
> describing some functional behavior, rather than a specific hardware IP).

So Jose's public reassurance means nothing?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

