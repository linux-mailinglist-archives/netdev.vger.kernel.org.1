Return-Path: <netdev+bounces-102134-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84CE19017F4
	for <lists+netdev@lfdr.de>; Sun,  9 Jun 2024 21:12:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDB3A1F210D4
	for <lists+netdev@lfdr.de>; Sun,  9 Jun 2024 19:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4614D8BD;
	Sun,  9 Jun 2024 19:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="ZWJOE041"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D12840879
	for <netdev@vger.kernel.org>; Sun,  9 Jun 2024 19:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717960373; cv=none; b=t66KUxlUToB9Ixwusy2lMpKk2MIcBf0VtJta1AdpLaYT39kWSZLHW0e8V1EqlXIji9dzmyjWf9bIxF7vQLwuRFQkMjz2lrTQASOrd85Pu4uaaCvnErTUKGYI3JL70btMSvBK2NHqe4P9z+zTXSTlKiMZizLh6H8uspGGDIyWeMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717960373; c=relaxed/simple;
	bh=PjVNSZER6iAuSxFoilVKVwpy22KmeNcHopke3nvhQqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ID0OZGcWV7/6AZx4l2b7aUyPbg7kXHjQKjm8snyPiNYyBkToKJeX8d2dBNNG21vwlECympAve87TBlh5RpAAnS1EYeoQ6ZVvdrvui4zN1hSgbbQuRB9GSwuA8rVbB7CEzIB/0Nw2Gb3Y2pRQ7Tm+i62Mt4JhXxtpHRswn2FxhzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=ZWJOE041; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Hb1/N+vKZF5IQftWwV188h7BXCdKHR1JeBuluupcWFM=; b=ZWJOE041kcYpMmm4Hegc/eGh8c
	NlLMby94Ka8N/YRQfK6CFtKKr6km84TW8EQHuliyvxM7UWaCgk5TXtQBaRHSes82pK327ELPhnFB7
	bHYXiceTp8v8op/86pH+IMj1hvi4/WW/xVwKoY6semOBWXUgRCX7L5gDsIu0hbHDNGwlYRFdZFETc
	LHHeBhyFtxeHH+0urteMnu3Ifec8jenHSaiFi3bcNhaT8/HUYw9beYYQ0URFB7gQ+0+XdTncRn5fe
	TVxPb9CKCIsIiAcMzr1Ga/MnKgXqBOONlW2uD4IyBAIlve2X6vwc04Z2WhyYzk04pWXwaA47IdRi/
	dKvlWT/Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:52684)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sGNy6-0000hf-05;
	Sun, 09 Jun 2024 20:12:42 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sGNy6-0006Ag-Fm; Sun, 09 Jun 2024 20:12:42 +0100
Date: Sun, 9 Jun 2024 20:12:42 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Hans-Frieder Vogt <hfdevel@gmx.net>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, netdev@vger.kernel.org,
	andrew@lunn.ch, horms@kernel.org, kuba@kernel.org, jiri@resnulli.us,
	pabeni@redhat.com, naveenm@marvell.com, jdamato@fastly.com
Subject: Re: [PATCH net-next v9 0/6] add ethernet driver for Tehuti Networks
 TN40xx chips
Message-ID: <ZmX+qo73ENfCyP6E@shell.armlinux.org.uk>
References: <20240605232608.65471-1-fujita.tomonori@gmail.com>
 <7fbf409d-a3bc-42e0-ba32-47a1db017b57@gmx.net>
 <ZmWG/ZQ4e/susuo6@shell.armlinux.org.uk>
 <e461ce5b-e8d0-413f-a872-2394f41a15d4@gmx.net>
 <ZmWyufzdM9vKjBDc@shell.armlinux.org.uk>
 <c3f29b80-0085-4dd2-8d78-f2ac2a004474@gmx.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c3f29b80-0085-4dd2-8d78-f2ac2a004474@gmx.net>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sun, Jun 09, 2024 at 08:36:42PM +0200, Hans-Frieder Vogt wrote:
> On 09.06.2024 15.48, Russell King (Oracle) wrote:
> 
> > On Sun, Jun 09, 2024 at 02:40:03PM +0200, Hans-Frieder Vogt wrote:
> > > --- a/drivers/net/ethernet/tehuti/tn40_phy.c    2024-06-06
> > > 06:43:40.865474664 +0200
> > > +++ b/drivers/net/ethernet/tehuti/tn40_phy.c    2024-06-06
> > > 18:57:01.978776712 +0200
> > > @@ -54,6 +54,8 @@ int tn40_phy_register(struct tn40_priv *
> > >                  return -1;
> > >          }
> > > 
> > > +       __set_bit(PHY_INTERFACE_MODE_XAUI, phydev->host_interfaces);
> > > +
> > >          config = &priv->phylink_config;
> > >          config->dev = &priv->ndev->dev;
> > >          config->type = PHYLINK_NETDEV;
> > This shouldn't be done - host_interfaces is really only for SFPs, and
> > it suggests that the 88x3310 isn't properly configured with pinstrapping
> > for the correct MAC type (which determines the interface mode to be used
> > to communicate with the MAC.)
> I already wondered why host_interfaces was used in the 88x3310, but not
> in the aqr105 phy driver. Makes sense because the 88x3310 supports both
> directly BASE-T and an SFP+ cage.
> > I'm not sure what to suggest here, other than further debug (e.g. what
> > interface mode is the 88x3310 trying to use without this?)
> 
> The message is:
> tn40xx 0000:10:00.0 enp16s0: PHY has no common interfaces

So... the 88x3310 supports SGMII, 2500BASE-X, 5GBASE-R, XAUI, RXAUI,
10GBASE-R and USXGMII on its host side interface.

When the phy is attached, the config_init method in the PHY driver
will be called, and it will fill in phydev->possible_interfaces to
reflect the interface modes that the PHY will _actually_ be using.

Phylink will notice phydev->possible_interfaces being non-empty and
check whether the union of the set of PHY possible_interfaces and
the set of MAC supported_interfaces is non-empty. If it's empty,
then the above message will be issued.

This suggests, as mentioned earlier, that the operating mode of the
88x3310 PHY doesn't match what this MAC can support, which makes me
wonder about the pinstrapping options for the 88x3310 on this
hardware. My guess is someone found a hardware design error and
decided "software can sort this out for us!"

> tn40xx 0000:10:00.0 enp16s0: validation of xaui with support
> 00,00000000,00018000,0000706f and advertisement
> 00,00000000,00018000,0000706f failed: -22

Basically, the PHY isn't operating in XAUI mode.

> You are probably right that the interfaceis not properly pinstrapped.
> bits 2:0 in 1f.f001 are initially 0, which means RXAUI, and the vendor
> driver just forces the bits to 1 (XAUI with rate matching). Maybe it is
> a quirk (or a design flaw of the Tehuti reference card). Just a thought:
> if it cannot be autodetected then maybe the simplest solution is adding
> a module parameter.

It may be that the best option is to set phydev->host_interfaces, but
I would like to see a comment giving details about why this is
necessary - essentially covering the information above please. It's
making use of that outside its original purpose, and I would like
such uses well documented so if stuff needs to change, we know what
and why these drivers are making use of it.

> I followed this discussion, but was hoping that the situation would change.
> I think I will give the card with AQR105 phy priority, assuming that the
> firmware topic is easier to solve for the Aquantia line of Marvell products.

Fingers crossed!

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

