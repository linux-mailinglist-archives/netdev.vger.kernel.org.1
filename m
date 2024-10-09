Return-Path: <netdev+bounces-133877-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C349997521
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 20:53:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A381C1F23614
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 18:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C2A1A255A;
	Wed,  9 Oct 2024 18:53:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17004EDE;
	Wed,  9 Oct 2024 18:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728499979; cv=none; b=aEMrX226TQyfDGC9ZuzaO5alDWQcHxC4qIycu2vn6W0XTQ0qVQ05zwIpB/sYaXg5o/PU76aIfCa9kQmypA1M6bwIWCSawtRmWHeX6kLg0nJoe7P+bZOlpZzcOBJvNil43Caozbj1SCjJm9EQC9VVNkn2tv4g4rUjCm/SWGQ/gMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728499979; c=relaxed/simple;
	bh=+dJ4yV6zXEoJxXC8MHm7Wsx/ONJG1NqSRGG8YWDq9OU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hybI/FAMJJaz7AaM8ZBT7INBNSYQqmB98ThBfYe4xpVjbhVRfZIEv+OOlYCtQcdH96jF+ELIIWn5ff6A85bGJ511iAHBurwNFeyJU+XmVco6AJkOXNyfzL0F3GvDfDFsn0AjJce1TGz5UBZE2ELyInVi9W4Y9ZPV05OUBVYrplM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98)
	(envelope-from <daniel@makrotopia.org>)
	id 1sybnk-000000008Bb-0BYF;
	Wed, 09 Oct 2024 18:52:48 +0000
Date: Wed, 9 Oct 2024 19:52:42 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: populate host_interfaces when
 attaching PHY
Message-ID: <ZwbQ-thwDxPfqGnW@makrotopia.org>
References: <ae53177a7b68964b2a988934a09f74a4931b862d.1728438951.git.daniel@makrotopia.org>
 <ZwZGVRL_j62tH9Mp@shell.armlinux.org.uk>
 <ZwZubYpZ4JAhyavl@makrotopia.org>
 <Zwa-j1LKB3V2o2r9@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zwa-j1LKB3V2o2r9@shell.armlinux.org.uk>

On Wed, Oct 09, 2024 at 06:34:07PM +0100, Russell King (Oracle) wrote:
> On Wed, Oct 09, 2024 at 12:52:13PM +0100, Daniel Golle wrote:
> > Hi Russell,
> > 
> > On Wed, Oct 09, 2024 at 10:01:09AM +0100, Russell King (Oracle) wrote:
> > > On Wed, Oct 09, 2024 at 02:57:03AM +0100, Daniel Golle wrote:
> > > > Use bitmask of interfaces supported by the MAC for the PHY to choose
> > > > from if the declared interface mode is among those using a single pair
> > > > of SerDes lanes.
> > > > This will allow 2500Base-T PHYs to switch to SGMII on most hosts, which
> > > > results in half-duplex being supported in case the MAC supports that.
> > > > Without this change, 2500Base-T PHYs will always operate in 2500Base-X
> > > > mode with rate-matching, which is not only wasteful in terms of energy
> > > > consumption, but also limits the supported interface modes to
> > > > full-duplex only.
> > > 
> > > We've had a similar patch before, and it's been NAK'd. The problem is
> > > that supplying the host_interfaces for built-in PHYs means that the
> > > hardware strapping for the PHY interface mode becomes useless, as does
> > > the DT property specifying it - and thus we may end up selecting a
> > > mode that both the MAC and PHY support, but the hardware design
> > > doesn't (e.g. signals aren't connected, signal speed to fast.)
> > > 
> > > For example, take a board designed to use RXAUI and the host supports
> > > 10GBASE-R. The first problem is, RXAUI is not listed in the SFP
> > > interface list because it's not usable over a SFP cage.
> > 
> > I thought about that, also boards configured for RGMII but both MAC
> > and PHY supporting SGMII or even 2500Base-X would be such a case.
> > In order to make sure we don't switch to link modes not supported
> > by the design I check if the interface mode configured in DT is
> > among those suitable for use with an SFP (ie. using a single pair
> > of SerDes lanes):
> > if (test_bit(pl->link_interface, phylink_sfp_interfaces))
> > 	phy_interface_and(phy_dev->host_interfaces, phylink_sfp_interfaces,
> > 			  pl->config->supported_interfaces);
> > 
> > Neither RXAUI nor RGMII modes are among phylink_sfp_interfaces, so
> > cases in which those modes are configured in DT are already excluded.
> 
> This still won't work. There are drivers (boo, hiss, stmmac crap which
> is resistant to cleanup and fixing but there's others too) that don't
> do the phylink interface switching.

Ok, what a mess. So multiple interfaces modes will have to be declared
in DT for those boards which actually support that. What you be open
to something like that:

phy-mode = "2500base-x", "sgmii";

> 
> For example, stmmac sets the mode specified in DT and also if there
> is a Synopsys XPCS, then the supported interfaces also gets USXGMII,
> 10GKR, XLGMII, 10GBASER, SGMII, 1000BASEX and 2500BASEX. If DT says
> 10GBASER, then the PHY must not switch to USXGMII, but if an
> 88x3310 were to be thrown in, the PHY driver _would_ decide to use
> USXGMII against the DT configuration.
> 
> phydev->host_interfaces is there to allow PHYs on SFPs be properly
> configured according to the host interface, where there is no DT
> description for the module. It is not meant for built-in PHYs.

Imho allowing several available interface modes can still be
advantageous also for built-in PHYs. Measurable power savings (~100mW on
MT7986!) and not needing rate matching are both desireable things.

The question is just how would we get there...

> > As we are also using using rate matching right now in cases when it
> > should not (and thereby inhibiting support for half-duplex modes), I
> > suppose the only good solution would be to allow a set of interface
> > modes in DT instead of only a single one.
> 
> Two issues... why was the PHY configured via firmware to use rate
> matching if that brings with it this restriction, and it's possible
> not to?

Looking at drivers/net/phy/realtek.c you see in rtl822xb_config_init()
...
        has_2500 = test_bit(PHY_INTERFACE_MODE_2500BASEX,
                            phydev->host_interfaces) ||
                   phydev->interface == PHY_INTERFACE_MODE_2500BASEX;

        has_sgmii = test_bit(PHY_INTERFACE_MODE_SGMII,
                             phydev->host_interfaces) ||
                    phydev->interface == PHY_INTERFACE_MODE_SGMII;

        /* fill in possible interfaces */
        __assign_bit(PHY_INTERFACE_MODE_2500BASEX, phydev->possible_interfaces,
                     has_2500);
        __assign_bit(PHY_INTERFACE_MODE_SGMII, phydev->possible_interfaces,
                     has_sgmii);

        if (!has_2500 && !has_sgmii)
                return 0;

        /* determine SerDes option mode */
        if (has_2500 && !has_sgmii) {
                mode = RTL822X_VND1_SERDES_OPTION_MODE_2500BASEX;
                phydev->rate_matching = RATE_MATCH_PAUSE;
        } else {
                mode = RTL822X_VND1_SERDES_OPTION_MODE_2500BASEX_SGMII;
                phydev->rate_matching = RATE_MATCH_NONE;
        }
...

So rate-matching is NOT configured in firmware, but rather it is
selected in cases where we (seemingly) don't have any other option. It
may not be a good choice (imho it never is), but rather just a last
resort in case we otherwise can't support lower speeds at all.

> 
> Second, aqr107_get_rate_matching() is rather basic based on what people
> want. It doesn't actually ask the PHY what its going to do. I know
> there's a bunch of VEND1_GLOBAL_CFG registers that give the serdes
> mode and rate adaption for each speed, and these can be set not only
> by firmware configuration, but changed by the host.
> 
> So, aqr107_get_rate_matching() should work out whether rate matching
> will be used for the interface mode by scanning these registers.
> [...]

Afaik Aquantia 2.5G PHYs always work only with a fixed interface mode
and perform rate-matching for lower speeds.

> 
> 
> Now, while phylink restricts RATE_MATCH_PAUSE to being full-duplex only,
> I'm not sure that is correct. I didn't contribute this support, and I
> don't have any platforms that support this, and I don't have any
> experience of it.

Afaik enforcing half-duplex via rate-maching with pause-frames is
supported by all the 2.5G PHYs I've seen up to now.

> 
> What I do have is the data sheet for 88x3310, and that doesn't mention
> any restriction such as "only full duplex is supported in rate matching
> mode".

Yep, and I suppose it should work just fine. The same applies for
RealTek and MaxLinear PHYs. I've tested it.

> 
> It is true that to use pause frames, the MAC/PCS must be in full-duplex
> mode, but if the PHY supports half-duplex on the media to full-duplex
> on the MAC side link, then why should phylink restrict this to be
> full-duplex only?

There is no reason for that imho. phylink.c states
/* Although a duplex-matching phy might exist, we
 * conservatively remove these modes because the MAC
 * will not be aware of the half-duplex nature of the
 * link.
 */

Afaik, practially all rate-matching PHYs which do support half-duplex
modes on the TP interface can perform duplex-matching as well.

> 
> I suspect phylink_get_capabilities() handling for RATE_MATCH_PAUSE is
> not correct - or maybe not versatile enough.

I agree. Never the less, why use rate matching at all if we don't have
to? It's obviously inefficient and wasteful, having the MAC follow the
PHY speed is preferrable in every case imho.

