Return-Path: <netdev+bounces-133086-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B3C9947D6
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 13:59:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 440CB283C99
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 11:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC84C1D26F2;
	Tue,  8 Oct 2024 11:59:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83DE185B58;
	Tue,  8 Oct 2024 11:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728388778; cv=none; b=qIoe0XIDh9L6RdCKkdtA2pDKjUJnsaI4Aibo4yP46sbjXDRFKVDYKq4723xV4HPNIOP249t9CXROGslCs7K52YoSu0MbZtcAY5r1Y0JQi85seHjevuelbpdfK0s7ka1/JdlmXD0fY5hXT2He0s0mRscqx+QTeSppHJEBFprQ9RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728388778; c=relaxed/simple;
	bh=ZaLYx4nmqBM6DcQkzfjm8PmU+xSyF8YriqxYb412Eoo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=td1/L3bdm5OKt8EXTBy/Vf2sxnISRnLpm5Vx0uUHgPpVlGRwVd54pFmAyPkNzdgX2uwgDzBW+2EvjNHmIknlVkeJeBXcamSyZNri7wknS5QZTS1G5u3kiZAQ3ceAmHJfxGhsPqqWoSEdc6bRm+AxDzVlUZB/NVkPDpS8Yto2WjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98)
	(envelope-from <daniel@makrotopia.org>)
	id 1sy8s4-000000008KO-2PiW;
	Tue, 08 Oct 2024 11:59:20 +0000
Date: Tue, 8 Oct 2024 12:59:17 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: realtek: check validity of 10GbE
 link-partner advertisement
Message-ID: <ZwUelSBiPSP_JDSy@makrotopia.org>
References: <fb736ae9a0af7616c20c36264aaec8702abc84ae.1728056939.git.daniel@makrotopia.org>
 <8fb5c25d-8ef5-4126-b709-0cfe2d722330@lunn.ch>
 <ZwBmycWDB6ui4Y7j@makrotopia.org>
 <ZwUTDw0oqJ1dvzPq@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZwUTDw0oqJ1dvzPq@shell.armlinux.org.uk>

On Tue, Oct 08, 2024 at 12:10:07PM +0100, Russell King (Oracle) wrote:
> On Fri, Oct 04, 2024 at 11:06:01PM +0100, Daniel Golle wrote:
> > On Fri, Oct 04, 2024 at 11:17:28PM +0200, Andrew Lunn wrote:
> > > On Fri, Oct 04, 2024 at 04:50:36PM +0100, Daniel Golle wrote:
> > > > Only use link-partner advertisement bits for 10GbE modes if they are
> > > > actually valid. Check LOCALOK and REMOTEOK bits and clear 10GbE modes
> > > > unless both of them are set.
> > > > This prevents misinterpreting the stale 2500M link-partner advertisement
> > > > bit in case a subsequent linkpartner doesn't do any NBase-T
> > > > advertisement at all.
> > > > 
> > > > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> > > > ---
> > > >  drivers/net/phy/realtek.c | 4 ++++
> > > >  1 file changed, 4 insertions(+)
> > > > 
> > > > diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
> > > > index c4d0d93523ad..d276477cf511 100644
> > > > --- a/drivers/net/phy/realtek.c
> > > > +++ b/drivers/net/phy/realtek.c
> > > > @@ -927,6 +927,10 @@ static int rtl822x_read_status(struct phy_device *phydev)
> > > >  		if (lpadv < 0)
> > > >  			return lpadv;
> > > >  
> > > > +		if (!(lpadv & MDIO_AN_10GBT_STAT_REMOK) ||
> > > > +		    !(lpadv & MDIO_AN_10GBT_STAT_LOCOK))
> > > > +			lpadv = 0;
> > > > +
> > > >  		mii_10gbt_stat_mod_linkmode_lpa_t(phydev->lp_advertising,
> > > >  						  lpadv);
> > > 
> > > I know lpadv is coming from a vendor register, but does
> > > MDIO_AN_10GBT_STAT_LOCOK and MDIO_AN_10GBT_STAT_REMOK apply if it was
> > > also from the register defined in 802.3? I'm just wondering if this
> > > test should be inside mii_10gbt_stat_mod_linkmode_lpa_t()?
> > 
> > Yes, it does apply and I thought the same, but as
> > mii_10gbt_stat_mod_linkmode_lpa_t is used in various places without
> > checking those two bits we may break other PHYs which may not use
> > them (and apparently this is mostly a problem on RealTek PHYs where
> > all the other bits in the register persist in case of a non-NBase-T-
> > capable subsequent link-partner after initially being connected to
> > an NBase-T-capable one).
> > 
> > Maybe we could introduce a new function
> > mii_10gbt_stat_mod_linkmode_lpa_validate_t()
> > which calls mii_10gbt_stat_mod_linkmode_lpa_t() but checks LOCOK and
> > REMOK as a precondition?
> 
> Isn't the link status supposed to indicate link down of LOCOK
> is clear?
> 
> Maybe checking these bits should be included in the link status
> check, and if not set, then phydev->link should be cleared?

At least in case of those RealTek PHYs the situation is a bit different:
The AN_10GBT bits do get set according to the link partner advertisement
in case the link partner does any 10GBT advertisement at all.
Now, if after being connected to a link partner which does 10GBT
advertisement you subsequently connect to a link partner which doesn't
do any 10GBT advertisement at all, the previously advertised bits
remain in the register, just REMOK and LOCOK aren't set.
That obviously doesn't imply that the link is down.
I noticed it because I would see a downshift warning in kernel logs
even though the new link partner was not capable of connecting with
speeds higher than 1000MBit/s.
Note that some that this doesn't happen with all 1GBE NICs, because
some seem to carry out 10GBT advertisement but just all empty while
others just don't do any 10GBT advertisement at all.

