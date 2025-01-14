Return-Path: <netdev+bounces-158119-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 65EE7A107DA
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 14:32:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA5DD7A4680
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 13:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA15236A6B;
	Tue, 14 Jan 2025 13:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ACRsFW9W"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECFF23245E
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 13:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736861520; cv=none; b=RmUYMFQRDJ0BXTHYv4hdtyw8cwSdF8l3bV3zJDS7b4EJEAnVGnkgwWn3urum+qXAiHnTMQ0q0D7AxFDa/G42UGlEAYXg6TpJc9vyB3FYJ1DEd7pSsVvQ+Eu6ZGtbqPF35lrQxVQajLp+/gW+nbaF5gAkn/30KW/pAYeJQIAW9Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736861520; c=relaxed/simple;
	bh=i7tnEnhM8uMBZ1kBOKawo/Rmt6H4Lrr/18MqYk1um5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SvobD/NV/iA/YKbwlPQAzhvmW4Edd+TAi6PnnR2ok9z3mgt5RbXwaGk4gQ96XNLBkSNUmPcIjyi7Mdb5X/HfS1Lr7SUAcPynZtwd5gmr45vdly41oufSy4tj6o1GvqLIrNoKhxUM9YuZsZwufmS3J/1YbC0ME7ojzuMqunlEKF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=ACRsFW9W; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=PXhz4v2yekrKs85FQBVnLqNAuOivEjZLOTeqH0/iKdE=; b=ACRsFW9WU2+DJBTNWVQgV68sLY
	8wp+9obPu/cISydMFEC83f8go9szWM5DNzJCdWaKur+4DIru28qW8x9cIwS62uRWlLWBX9ny0Ue/W
	7KDN63dX0MgCLHDs1FdaZB+MQqFa2oeUiHRZjwE05N7hURUleOdMR5Z3d3BMVzFMJ6MLMWRbJj4Bo
	bafLaSMof+vc7ySuTZNh23qoZcwSL3Ci2q6eWhScPvgh9fP0jWk9laKuJqHIhcc0hklkD4EMRJGFw
	1BQ558wpb3AyW76xEPS/WlvDa7NqxG37pfnlTGjZwp6n718edU9RET1/5V4FUtR9I5yhHhSz5p4S0
	Yocf6qhg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:46624)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tXh0z-00086M-0K;
	Tue, 14 Jan 2025 13:31:29 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tXh0s-00057B-0b;
	Tue, 14 Jan 2025 13:31:22 +0000
Date: Tue, 14 Jan 2025 13:31:22 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Alexander Couzens <lynxis@fe80.eu>,
	Alexander Duyck <alexanderduyck@fb.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Daniel Golle <daniel@makrotopia.org>,
	Daniel Machon <daniel.machon@microchip.com>,
	"David S. Miller" <davem@davemloft.net>,
	DENG Qingfang <dqfext@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Jakub Kicinski <kuba@kernel.org>, kernel-team@meta.com,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Madalin Bucur <madalin.bucur@nxp.com>,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Michal Simek <michal.simek@amd.com>, netdev@vger.kernel.org,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Sean Anderson <sean.anderson@seco.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Taras Chornyi <taras.chornyi@plvision.eu>,
	UNGLinuxDriver@microchip.com, Eric Woudstra <ericwouds@gmail.com>
Subject: Re: [PATCH net-next v2 5/5] net: phylink: provide fixed state for
 1000base-X and 2500base-X
Message-ID: <Z4ZnKpQgxZCbV5Yk@shell.armlinux.org.uk>
References: <Z4TbR93B-X8A8iHe@shell.armlinux.org.uk>
 <E1tXGei-000EtL-Fn@rmk-PC.armlinux.org.uk>
 <20250114125739.sgegfxibbzpc2uor@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250114125739.sgegfxibbzpc2uor@skbuf>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Jan 14, 2025 at 02:57:39PM +0200, Vladimir Oltean wrote:
> On Mon, Jan 13, 2025 at 09:22:44AM +0000, Russell King (Oracle) wrote:
> > When decoding clause 22 state, if in-band is disabled and using either
> > 1000base-X or 2500base-X, rather than reporting link-down, we know the
> > speed, and we only support full duplex. Pause modes taken from XPCS.
> > 
> > This fixes a problem reported by Eric Woudstra.
> > 
> > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > ---
> >  drivers/net/phy/phylink.c | 29 +++++++++++++++++++----------
> >  1 file changed, 19 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
> > index b79f975bc164..ff0efb52189f 100644
> > --- a/drivers/net/phy/phylink.c
> > +++ b/drivers/net/phy/phylink.c
> > @@ -3882,27 +3882,36 @@ void phylink_mii_c22_pcs_decode_state(struct phylink_link_state *state,
> >  	if (!state->link)
> >  		return;
> >  
> > -	/* If in-band is disabled, then the advertisement data is not
> > -	 * meaningful.
> > -	 */
> > -	if (neg_mode != PHYLINK_PCS_NEG_INBAND_ENABLED)
> > -		return;
> > -
> >  	switch (state->interface) {
> >  	case PHY_INTERFACE_MODE_1000BASEX:
> > -		phylink_decode_c37_word(state, lpa, SPEED_1000);
> > +		if (neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED) {
> > +			phylink_decode_c37_word(state, lpa, SPEED_1000);
> > +		} else {
> > +			state->speed = SPEED_1000;
> > +			state->duplex = DUPLEX_FULL;
> > +			state->pause |= MLO_PAUSE_TX | MLO_PAUSE_RX;
> > +		}
> >  		break;
> >  
> >  	case PHY_INTERFACE_MODE_2500BASEX:
> > -		phylink_decode_c37_word(state, lpa, SPEED_2500);
> > +		if (neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED) {
> > +			phylink_decode_c37_word(state, lpa, SPEED_2500);
> > +		} else {
> > +			state->speed = SPEED_2500;
> > +			state->duplex = DUPLEX_FULL;
> > +			state->pause |= MLO_PAUSE_TX | MLO_PAUSE_RX;
> > +		}
> >  		break;
> 
> Are the "else" branches necessary, given the "else" branch from
> phylink_mac_pcs_get_state?
> 
> static void phylink_mac_pcs_get_state(struct phylink *pl,
> 				      struct phylink_link_state *state)
> {
> 	struct phylink_pcs *pcs;
> 	bool autoneg;
> 
> 	linkmode_copy(state->advertising, pl->link_config.advertising);
> 	linkmode_zero(state->lp_advertising);
> 	state->interface = pl->link_config.interface;
> 	state->rate_matching = pl->link_config.rate_matching;
> 	state->an_complete = 0;
> 	state->link = 1;
> 
> 	pcs = pl->pcs;
> 	if (!pcs || pcs->neg_mode)
> 		autoneg = pl->pcs_neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED;
> 	else
> 		autoneg = linkmode_test_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
> 					    state->advertising);
> 
> 	if (autoneg) {
> 		state->speed = SPEED_UNKNOWN;
> 		state->duplex = DUPLEX_UNKNOWN;
> 		state->pause = MLO_PAUSE_NONE;
> 	} else {						|
> 		state->speed =  pl->link_config.speed;		|
> 		state->duplex = pl->link_config.duplex;		| this
> 		state->pause = pl->link_config.pause;		|
> 	}							|

This is fine for cases where ethtool is used to turn autoneg off, but
not if we're in in-band mode and the PCS/PHY have decided to have
autoneg off - in that case, nothing sets pl->link_config.* to anything
sensible.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

