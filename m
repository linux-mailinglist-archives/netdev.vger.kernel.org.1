Return-Path: <netdev+bounces-177344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD3D4A6FAB7
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 13:07:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41A483BA0BF
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 12:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83DED2571A4;
	Tue, 25 Mar 2025 12:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NHsNzIF+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A4E1E5B91;
	Tue, 25 Mar 2025 12:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742904275; cv=none; b=k5vygpEy+h+b05dbVVoVYN0GVGUQAgmBYekcmVSjK079o4H822kwgSIzgJlz+iwrBRjEK5EqPq5znus4LikSMbfaUA8HRjb5gbB0c4ZvOumpi0gfld1czwkPcBhZiGsVbolanrkCkFmxpSLEVnF+bFJdlGBoBos8YviK7S9CEyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742904275; c=relaxed/simple;
	bh=aqqPVmMsOGhcdeqvF5p7t7SRzU4zDtVzAe7nlwDHd5A=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UEEK+YGE2DKRhRRS01O0t6lnd94sDuBJvsY4vhP1PKDdCns/R5MBFEX4MYsCIZ8m11xHTKD2/fX2wg6oVBQvOVEXSgMESpGgrtXC02THzpFXKyGkral0brfdYI/9HBlwmt04n6Bx1o7O83MP5QpzNuxGHfnC46Q7krTonD36C7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NHsNzIF+; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43cfecdd8b2so44000675e9.2;
        Tue, 25 Mar 2025 05:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742904272; x=1743509072; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=C+QdiynqsqYmewqvy8Ft0umJ+VItvB7uLquQbVoS8Oo=;
        b=NHsNzIF+hDTjCD/ma2l/zauy+C+vbA8q9QCAt0ZI0rvLhlOFAafmdPHa2inFsLDFku
         xNbO/6ZECj6+vpqQqFphWceedOwCoWxg4pojqhgtoQgV3v0ntEYKAWAj9T1IHVLawrVm
         yb1L62YUyTxrVrVz9KN/dVIdv1HKr/Q73HHmtFkVsoTmbdi6xnC5bhwtAnw/4i9iiUzJ
         gL1uDB06dBMWSmsqNGVFLmfOea+/0OwWZ7HRbD+TyEsFXLg8X800xpL9ng2C/QP1cO14
         F4a0c/gdS/70uW+7l6RsgH/ugH2zXfNZIyGMM0L6roYj0EG7KkEdCZK9cV2eyeg+ccMi
         AcZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742904272; x=1743509072;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C+QdiynqsqYmewqvy8Ft0umJ+VItvB7uLquQbVoS8Oo=;
        b=g8q45y8gQhiZccxpfk4kVoUNz6FA9KpElpmlk9xOaEfClwNK8996tDQ15Bw+2YFdpM
         5QbwhnX0YWtCIG/wkkDlxWZDK8RbpMdlaDQVBqVG2EMndJnDbyQ0uBSR3g0JSmrHmpWO
         1nYec68xCth13/vQ2AcvKDpluPTzdALHnkH6Urir4u2eHKMuASj4I34kWQNJ3ZnDS2wW
         PwKYHvXfz542kxbe9pQVYGqK16tYv5x8mp/t8VKZJE1e043XFoMmCRLjnXeBp516NwBo
         bE2hxLyDW4Hkf6WDmotw3GvxbU0v0AVh1+1SqFgiRbO606lVujshVuojxXTgs2gRJuae
         pGYA==
X-Forwarded-Encrypted: i=1; AJvYcCUkp2wOjeQnvNnYS8mYGL5O1BaldbQCxovRgVMAodJLp6IGs3v4pNRPGYFR/HzVq11IX1v5Pvsh@vger.kernel.org, AJvYcCVqrp0M+V1vwureuR2DqCq+VQoLOyZJCgFVTM9XhBvPMdmUyW0rF/oEWse7fbSJP5+zFNDQnkfS0Rvp@vger.kernel.org, AJvYcCWF4CyHNifrYE4+eo0xL3S+vPHmOjT+iXI3MkaUipXaUi3/uTApTY1BHl2igi018T4Xnc22po0wmUCoZc11@vger.kernel.org
X-Gm-Message-State: AOJu0YwykuuugNFtAhM/b6gA6Eao6+jBMlXYoLvpMYuRXXgvei5LIGF4
	DkszISC6w/wE9lArzbpPT2NeupWDYwJykdqFUaUWvXO7R424NnuW
X-Gm-Gg: ASbGncvHYfYSGrKSzNUpw3Fe8bnplO4DPO8lv1mmh5N0ZmwXqbGtRXDfMqCnn1aMEU5
	Ur4aa63ifa30TCxPsWlSkzPNzLEICo5nS8nOaP5NhK/hNkMTk/icOirgl54yHgqQNAANOONTzja
	/2Uj4H936N8hsmMNzs+yez+KZhN82p7bDjka5hbwtgTAYW4YHhW83Dl+AHVLuGl1J518HjG11b2
	BBdzYjc/hLe7khR6tmDOxbNuFapepcwUhsH8hLt9edhU2egBCo/DblG+fM6e/7m6LDww1jGgx/+
	slaa5KsKbmaMo5d/N+BYMT7OCihIaVSl8qcbM7ernAKWMINIjAaSq1VzeUelWvuvqbZTVOXXe9O
	p
X-Google-Smtp-Source: AGHT+IFRwP4poLJtkBZF6thnwTl8o4U4l1CX0wU1hlvqltm9xd+6hoICxMwSdrrbFqwi7w51U9dMNQ==
X-Received: by 2002:a05:600c:8711:b0:43c:f513:9585 with SMTP id 5b1f17b1804b1-43d6515b9c1mr71086875e9.13.1742904271249;
        Tue, 25 Mar 2025 05:04:31 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-90-129.ip49.fastwebnet.it. [93.34.90.129])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43d43f3328bsm199119735e9.1.2025.03.25.05.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 05:04:30 -0700 (PDT)
Message-ID: <67e29bce.050a0220.15db86.84a4@mx.google.com>
X-Google-Original-Message-ID: <Z-KbzvWjYRxZIy7w@Ansuel-XPS.>
Date: Tue, 25 Mar 2025 13:04:30 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH 1/2] net: phy: Add support for new Aeonsemi PHYs
References: <20250323225439.32400-1-ansuelsmth@gmail.com>
 <f0c685b0-b543-4038-a9bd-9db7fc00c808@lunn.ch>
 <67e1692c.050a0220.2b4ad0.c073@mx.google.com>
 <a9abc0c6-91c2-4366-88dd-83e993791508@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9abc0c6-91c2-4366-88dd-83e993791508@lunn.ch>

On Mon, Mar 24, 2025 at 04:16:09PM +0100, Andrew Lunn wrote:
> On Mon, Mar 24, 2025 at 03:16:08PM +0100, Christian Marangi wrote:
> > On Mon, Mar 24, 2025 at 03:03:51PM +0100, Andrew Lunn wrote:
> > > > Supported PHYs AS21011JB1, AS21011PB1, AS21010JB1, AS21010PB1,
> > > > AS21511JB1, AS21511PB1, AS21510JB1, AS21510PB1, AS21210JB1,
> > > > AS21210PB1 that all register with the PHY ID 0x7500 0x7500
> > > > before the firmware is loaded.
> > > 
> > > Does the value change after the firmware is loaded? Is the same
> > > firmware used for all variants?
> > >
> > 
> > Yes It does... Can PHY subsystem react on this? Like probe for the
> > generic one and then use the OPs for the real PHY ID?
> 
> Multiple thoughts here....
> 
> If the firmware is in SPI, i assume by the time the MDIO bus is
> probed, the PHY has its 'real' IDs. So you need entries for those as
> well as the dummy ID.
> 
> I think this is the first PHY which changes its IDs at runtime. So we
> don't have a generic solution to this. USB and PCI probably have
> support for this, so maybe there is something we can copy. It could be
> they support hotplug, so the device disappears and returns. That is
> not really something we have in MDIO. So i don't know if we can reuse
> ideas from there.
> 
> When the firmware is running, do the different variants all share the
> same ID? Is there a way to tell them apart. We always have
> phy_driver->match_phy_device(). It could look for 0x75007500, download
> the firmware, and then match on the real IDs.
>

Ok update on this... The PHY report 7500 7500 but on enabling PTP clock,
a more specific ""family"" ID is filled in MMD that is 0x7500 0x9410.

They all use the same firmware so matching for the family ID might not
be a bad idea... The alternative is either load the firmware in
match_phy_device or introduce some additional OPs to handle this
correctly...

Considering how the thing are evolving with PHY I really feel it's time
we start introducing specific OP for firmware loading and we might call
this OP before PHY ID matching is done (or maybe do it again).

Lets see how bad the thing goes API wise tho.

> > > > +++ b/drivers/net/phy/Kconfig
> > > > @@ -121,6 +121,18 @@ config AMCC_QT2025_PHY
> > > >  
> > > >  source "drivers/net/phy/aquantia/Kconfig"
> > > >  
> > > > +config AS21XXX_PHY
> > > > +	tristate "Aeonsemi AS21xxx PHYs"
> > > 
> > > The sorting is based on the tristate value, so that when you look at
> > > 'make menuconfig' the menu is in alphabetical order. So this goes
> > > before aquantia.
> > > 
> > 
> > Tought it was only alphabetical, will move.
> 
> Yes, it is not obvious, it should have a comment added at the top.
> But the top is so far away, i guess many developers would miss it
> anyway.
> 
> > > > +static int as21xxx_get_features(struct phy_device *phydev)
> > > > +{
> > > > +	int ret;
> > > > +
> > > > +	ret = genphy_read_abilities(phydev);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	/* AS21xxx supports 100M/1G/2.5G/5G/10G speed. */
> > > > +	linkmode_clear_bit(ETHTOOL_LINK_MODE_10baseT_Half_BIT,
> > > > +			   phydev->supported);
> > > > +	linkmode_clear_bit(ETHTOOL_LINK_MODE_10baseT_Full_BIT,
> > > > +			   phydev->supported);
> > > > +	linkmode_clear_bit(ETHTOOL_LINK_MODE_100baseT_Half_BIT,
> > > > +			   phydev->supported);
> > > 
> > > Does this mean the registers genphy_read_abilities() reads are broken
> > > and report link modes it does not actually support?
> > > 
> > > > +	linkmode_set_bit(ETHTOOL_LINK_MODE_100baseT_Full_BIT,
> > > > +			 phydev->supported);
> > > > +	linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT,
> > > > +			 phydev->supported);
> > > 
> > > and it is also not reporting modes it does actually support? Is
> > > genphy_read_abilities() actually doing anything useful? Some more
> > > comments would be good here.
> > > 
> > > > +	linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
> > > > +			 phydev->supported);
> > > > +	linkmode_set_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT,
> > > > +			 phydev->supported);
> > > > +	linkmode_set_bit(ETHTOOL_LINK_MODE_10000baseT_Full_BIT,
> > > > +			 phydev->supported);
> > > 
> > > Does this mean genphy_c45_pma_read_abilities() also returns the wrong
> > > values?
> > > 
> > 
> > Honestly I followed what the SDK driver did for the get_feature. I will
> > check the register making sure correct bits are reported.
> > 
> > Looking at the get_status It might be conflicting as they map C22 in C45
> > vendor regs.
> 
> If all the registers used for automatic feature detection are broken,
> just comment on it and don't use genphy_read_abilities() etc.
> 
> > > > +static int as21xxx_read_link(struct phy_device *phydev, int *bmcr)
> > > > +{
> > > > +	int status;
> > > > +
> > > > +	*bmcr = phy_read_mmd(phydev, MDIO_MMD_AN,
> > > > +			     MDIO_AN_C22 + MII_BMCR);
> > > > +	if (*bmcr < 0)
> > > > +		return *bmcr;
> > > > +
> > > > +	/* Autoneg is being started, therefore disregard current
> > > > +	 * link status and report link as down.
> > > > +	 */
> > > > +	if (*bmcr & BMCR_ANRESTART) {
> > > > +		phydev->link = 0;
> > > > +		return 0;
> > > > +	}
> > > > +
> > > > +	status = phy_read_mmd(phydev, MDIO_MMD_AN, MDIO_STAT1);
> > > 
> > > No MDIO_AN_C22 + here? Maybe add a comment about which C22 registers
> > > are mapped into C45 space.
> > >
> > 
> > Nope, not a typo... They took the vendor route for some register but for
> > BMSR they used the expected one.
> > 
> > Just to make it clear, using the AN_C22 wasn't a choice... the C45 BMCR
> > reports inconsistent data compared to the vendor C22 one.
> 
> Comments would be good.
> 
> Is there an open datasheet for this device?
>

Sadly no and I don't even have datasheet, just some contacts to confirm
1-2 thing for the PHY.

-- 
	Ansuel

