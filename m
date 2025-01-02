Return-Path: <netdev+bounces-154723-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA439FF971
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 13:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89A981621FA
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 12:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3044D1B140D;
	Thu,  2 Jan 2025 12:45:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5162F1B0F0A
	for <netdev@vger.kernel.org>; Thu,  2 Jan 2025 12:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735821913; cv=none; b=Fe3BwKUNg9Bmzzu+7wvczS0J3swHaqoOAZerZ9RcCneEf2w5EdQ1A9zubZPaoyxOosnsTIflAc8Ir9yFK2U8+F30RsP23OjTgXY4969fjm//FRLQE3jxhgHioPeOaSQR8m+Z4dxecouCYv53B0yfxJNGZlgP00Wu8KKc2jzk9pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735821913; c=relaxed/simple;
	bh=h6fEkAXO9Z2ToW0L4BvTCUD9rjpPirPTPYcZ5OLU2Bc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CVJ2eEDY4XFzy71G6SR+7SHFL4tAfV1M2bwj2f/N1yeiYGNC9+YMFS4jFJjTFulQQwUenMBs9hKRVylafM1LT5z2kN1zlcV+OnN2pDSGcCnvAyCJVWEXWsXioBVOCD+n9OpWKLY0NWdh51JrRGIIoDW5Ii0bvql5lhDL+F6SWwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98)
	(envelope-from <daniel@makrotopia.org>)
	id 1tTKI6-000000007DY-3PLl;
	Thu, 02 Jan 2025 12:27:06 +0000
Date: Thu, 2 Jan 2025 12:26:52 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Alexander Couzens <lynxis@fe80.eu>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net-next 2/3] net: pcs: pcs-mtk-lynxi: implement
 pcs_inband_caps() method
Message-ID: <Z3aGDHU2TLV_YtZW@pidgin.makrotopia.org>
References: <Z1F1b8eh8s8T627j@shell.armlinux.org.uk>
 <E1tJ8NR-006L5P-E3@rmk-PC.armlinux.org.uk>
 <Z1UMEnlZ_ivTsru5@pidgin.makrotopia.org>
 <Z1VjJ8ago-HetCxi@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1VjJ8ago-HetCxi@shell.armlinux.org.uk>

On Sun, Dec 08, 2024 at 09:13:11AM +0000, Russell King (Oracle) wrote:
> On Sun, Dec 08, 2024 at 03:01:38AM +0000, Daniel Golle wrote:
> > On Thu, Dec 05, 2024 at 09:42:29AM +0000, Russell King (Oracle) wrote:
> > > Report the PCS in-band capabilities to phylink for the LynxI PCS.
> > > 
> > > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > > ---
> > >  drivers/net/pcs/pcs-mtk-lynxi.c | 16 ++++++++++++++++
> > >  1 file changed, 16 insertions(+)
> > > 
> > > diff --git a/drivers/net/pcs/pcs-mtk-lynxi.c b/drivers/net/pcs/pcs-mtk-lynxi.c
> > > index 4f63abe638c4..7de804535229 100644
> > > --- a/drivers/net/pcs/pcs-mtk-lynxi.c
> > > +++ b/drivers/net/pcs/pcs-mtk-lynxi.c
> > > @@ -88,6 +88,21 @@ static struct mtk_pcs_lynxi *pcs_to_mtk_pcs_lynxi(struct phylink_pcs *pcs)
> > >  	return container_of(pcs, struct mtk_pcs_lynxi, pcs);
> > >  }
> > >  
> > > +static unsigned int mtk_pcs_lynxi_inband_caps(struct phylink_pcs *pcs,
> > > +					      phy_interface_t interface)
> > > +{
> > > +	switch (interface) {
> > > +	case PHY_INTERFACE_MODE_1000BASEX:
> > > +	case PHY_INTERFACE_MODE_2500BASEX:
> > > +	case PHY_INTERFACE_MODE_SGMII:
> > > +	case PHY_INTERFACE_MODE_QSGMII:
> > 
> > QSGMII is not supported by this PCS.
> 
> Well...
> - lynx_pcs_get_state(), lynx_pcs_config(), and lynx_pcs_link_up()
>   include QSGMII in their case statements.
> - lynx_pcs_config_giga() refers to QSGMII in a comment, grouping it
>   with SGMII configuration.

These functions are in pcs-lynx.c and not in pcs-mtk-lynxi.c.
There is no reference to QSGMII anywhere in pcs-mtk-lynxi.c, what made
you assume it would be supported?

> 
> I think if the hardware doesn't support QSGMII, these references to it
> should be removed?
> 
> I also think that adding a .pcs_validate() method would be a good idea
> to reject interface modes that the PCS does not support.

I can add the pcs_validate function and send the patch doing that to be
included in net-next.


