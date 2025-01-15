Return-Path: <netdev+bounces-158440-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F17BCA11D8A
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 10:25:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A924518848E6
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 09:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E2A8248194;
	Wed, 15 Jan 2025 09:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="fyNJgltr"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48098248174;
	Wed, 15 Jan 2025 09:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736933106; cv=none; b=Qx/zyI7V4Z/tgIrFZn/xUuX0Gg+R3fRwglWeStQ8cynNPDZpVwWI+MEei3X1VuMPoI4EtKTwcRVWiMYLQ7yN/Wtg//D+baqB2OhUx2TbFkEwkS9XzktnO2uM0oYcyZ7Zd/efiowrNi9tsa8lINJMp9gGAkhVhLdOC6+SS+etZK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736933106; c=relaxed/simple;
	bh=k3HHqQxM0AtCwTht+smYhL6GwKyJgGywP3bonvIkk40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n/LShN62VCBDaIdudyEfccLOXvu5MUGkqp5aeVgkXF5Yh7kEbvH8knq/1K9n15WJ0BY2HwWh4PnanGbhTUxfW1vvmpUfV6q7xhZ2U4FUh26YJaIpD8rT1an+CuCAGvZZVl7AzRbL1pLalCKIM4dJZNBQ8HFtgqAFrf2N8GYtWJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=fyNJgltr; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=FJnoybHFzBfttif85dhJPVys3mjK+8VxS0+8DG4fHe4=; b=fyNJgltrZ5u8KtvISzzoeJXjeB
	tOMkKOS2IVVEQwMCaEAMOKuKRAadrDfQ46b3hwoZUoV+j/JcLsQ8NBFOQmDN4cktyL39dHvl4w69n
	gR8Ap6dfJfqZfRncvXTajE5XRy5J+9bp7mKviW5rUuPTJmf3wINdtoW2O6dq42piglSn41NSj0WX6
	s1zIpslbj1eVXvVIundcpjmN1xZ1AH04apYYUHvWMCD3PGRJE2niEw7hK5TZk+E+MXKpKGt4c2NSD
	E3OryCgrJf7IRutWyXnq4GMoYeX9IJfPGyCQSs7CbyAqSfSMg22xfUDj0TUyCm27yGhMys65PUy3N
	4KZZTnlA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:47770)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tXzds-0000wx-2h;
	Wed, 15 Jan 2025 09:24:52 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tXzdp-000634-0R;
	Wed, 15 Jan 2025 09:24:49 +0000
Date: Wed, 15 Jan 2025 09:24:48 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: phy: realtek: clear status if link is down
Message-ID: <Z4d-4E2R9TYrl0ZK@shell.armlinux.org.uk>
References: <229e077bad31d1a9086426f60c3a4f4ac20d2c1a.1736901813.git.daniel@makrotopia.org>
 <7dd12859-dd20-4ce1-a877-4c93b335b911@lunn.ch>
 <Z4dCig1kd-BhSHqD@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4dCig1kd-BhSHqD@makrotopia.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Jan 15, 2025 at 05:07:22AM +0000, Daniel Golle wrote:
> Hi Andrew,
> 
> On Wed, Jan 15, 2025 at 03:50:33AM +0100, Andrew Lunn wrote:
> > On Wed, Jan 15, 2025 at 12:46:11AM +0000, Daniel Golle wrote:
> > > Clear speed, duplex and master/slave status in case the link is down
> > > to avoid reporting bogus link(-partner) properties.
> > > 
> > > Fixes: 5cb409b3960e ("net: phy: realtek: clear 1000Base-T link partner advertisement")
> > > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> > > ---
> > >  drivers/net/phy/realtek.c | 20 ++++++++++++++------
> > >  1 file changed, 14 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
> > > index f65d7f1f348e..3f0e03e2abce 100644
> > > --- a/drivers/net/phy/realtek.c
> > > +++ b/drivers/net/phy/realtek.c
> > > @@ -720,8 +720,12 @@ static int rtlgen_read_status(struct phy_device *phydev)
> > >  	if (ret < 0)
> > >  		return ret;
> > >  
> > > -	if (!phydev->link)
> > > +	if (!phydev->link) {
> > > +		phydev->duplex = DUPLEX_UNKNOWN;
> > > +		phydev->master_slave_state = MASTER_SLAVE_STATE_UNKNOWN;
> > > +		phydev->speed = SPEED_UNKNOWN;
> > >  		return 0;
> > > +	}
> > >  
> > 
> > I must be missing something here...
> > 
> > 
> > rtlgen_read_status() first calls genphy_read_status(phydev);
> > [...]
> > Why is that not sufficient ?
> 
> The problem are the stale NBase-T link-partner advertisement bits and the
> subsequent call to phy_resolve_aneg_linkmode(), which results in bogus
> speed and duplex, based on previously connected link partner advertising
> 2500Base-T, 5GBase-T or 10GBase-T modes.

This means you're also populating the link-partner advertisement bits
with bogus data. It would be better not to read the link status.

Does it leave the MDIO_AN_STAT1_COMPLETE bit set as well, thus causing
genphy_c45_baset1_read_lpa() to read the advertisement rather than
clearing it?

Or is it because this is buggy:

        /* Vendor register as C45 has no standardized support for 1000BaseT */
        if (phydev->autoneg == AUTONEG_ENABLE) {
                val = phy_read_mmd(phydev, MDIO_MMD_VEND2,
                                   RTL822X_VND2_GANLPAR);
                if (val < 0)
                        return val;

                mii_stat1000_mod_linkmode_lpa_t(phydev->lp_advertising, val);
        }

This should be clearing the bits that mii_stat1000_mod_linkmode_lpa_t()
sets if autoneg is not complete.

> rtl822x_c45_read_status() calls genphy_c45_read_status(), which calls
> genphy_c45_read_lpa(), and that doesn't clear either
> ETHTOOL_LINK_MODE_1000baseT_Half_BIT nor ETHTOOL_LINK_MODE_1000baseT_Full_BIT
> as there is no generic handling for 1000Base-T in Clause-45.
> 
> So also in the Clause-45 case, the subsequent call to
> phy_resolve_aneg_linkmode() may then wrongly populate speed and duplex, this
> time according to the stale 1000baseT bits.
> 
> Moving the call to rtl822x_c45_read_status() in rtl822x_c45_read_status() to
> after the 1000baseT lpa bits have been taken care of fixes that part of the
> issue.
> 
> Clearing master_slave_state in the C45 case is still necessary because it isn't
> done by genphy_c45_read_status().

So that's a yes then.

That's because the functions only set/clear the advertisement bits that
they control. If the PHY driver manages any other advertisement bits, it
has to _fully_ manage them. So with 1000baseT bits, as the generic
functions don't manage them, the PHY driver has to do _full_ management
of them. That includes clearing the bits when autoneg is not complete.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

