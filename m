Return-Path: <netdev+bounces-132202-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12998990F72
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 21:59:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40F471C230B4
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 19:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A1F1DD893;
	Fri,  4 Oct 2024 19:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="YGrzVP+8"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12600136657;
	Fri,  4 Oct 2024 19:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728068539; cv=none; b=k6ULdTLgZgKW27GZ9SduL98hz/pRq52QW0QI4Fe/WQqKuhIThTEIoEcMDry5NrVrhwcsGgt90uzimiw+MzFqskO7UNruTSjsbNcfhAffdFcvaWPtyjVk50SA9UeFYzUMQ+JBfHXNekcgjqqx7VB/3bl+f7Kbfcy0IQ07oE115ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728068539; c=relaxed/simple;
	bh=7a31GCJJ4EI6f8qcjaAEHHqOYmESiFgilCyUnQHJGnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m5i6ke4E4u5zGuP3xPJNm8YNXp5PVXA4vN84pHdAhW/vxRxKvV/5QCoVUBUNL+3JwRCa8LwcAdHX5CcKh31+IJOf2tr9hfkQtNCz/iOBOuX15q6Fwm+WOj8qdSPnA8ErP5WAVqDw3I92lrX6XkizRCa6kw8mD1L0DWOPVQzsjDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=YGrzVP+8; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=LUJZilgqaYxyl2cKJ0toBOmC6GOF/ktiyVJOdIywIxo=; b=YGrzVP+85uGEvI8mFy8QFV94Ji
	0eGsA8DcZXpk3IERbh52eXU7BuqbgoFkPBUVh0mYXcjlti/SMDaBMNl+L3i3HchBkcdxm85SZDHJy
	qU185f9QfB+0+yP4denXtr0kQg17ElOgaP8X25DEc3VJcXRmjOEMDSPaMLAC6LSQhUVmwMmz8sgk9
	MprXS/39x2796zTQruklCKo1/UFocwZIXGYeiGaJSAYE/yAU3DwajKSm+daz4ldg3+N5LkNZApCeq
	87X6F08ARWjwNc2+Hzy9KEnDEWr9IDBK9UnYzenGPk78rkrAmvZTPRXuIwf0ynWJRzdUBXk66rCTJ
	9Pl8Gb4w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:38292)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1swnZ4-0002ar-2v;
	Fri, 04 Oct 2024 20:02:10 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1swnYz-0001Ox-13;
	Fri, 04 Oct 2024 20:02:05 +0100
Date: Fri, 4 Oct 2024 20:02:05 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, davem@davemloft.net,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	=?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>
Subject: Re: [PATCH net-next v2 7/9] net: phy: introduce ethtool_phy_ops to
 get and set phy configuration
Message-ID: <ZwA7rRCdJjU9BUUq@shell.armlinux.org.uk>
References: <20241004161601.2932901-1-maxime.chevallier@bootlin.com>
 <20241004161601.2932901-8-maxime.chevallier@bootlin.com>
 <4d4c0c85-ec27-4707-9613-2146aa68bf8c@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d4c0c85-ec27-4707-9613-2146aa68bf8c@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Oct 04, 2024 at 08:42:42PM +0200, Andrew Lunn wrote:
> > +int phy_set_config(struct phy_device *phydev,
> > +		   const struct phy_device_config *phy_cfg,
> > +		   struct netlink_ext_ack *extack)
> > +{
> > +	bool isolate_change;
> > +	int ret;
> > +
> > +	mutex_lock(&phydev->lock);
> > +	isolate_change = (phy_cfg->isolate != phydev->isolated);
> > +	mutex_unlock(&phydev->lock);
> > +
> > +	if (!isolate_change)
> > +		return 0;
> > +
> > +	ret = phy_isolate(phydev, phy_cfg->isolate);
> > +	if (ret)
> > +		NL_SET_ERR_MSG(extack, "Error while configuring PHY isolation");
> 
> This seems overly simplistic to me. Don't you need to iterate over all
> the other PHYs attached to this MAC and ensure they are isolated? Only
> one can be unisolated at once.
> 
> It is also not clear to me how this is going to work from a MAC
> perspective. Does the MAC call phy_connect() multiple times? How does
> ndev->phydev work? Who is responsible for the initial configuration,
> such that all but one PHY is isolated?
> 
> I assume you have a real board that needs this. So i think we need to
> see a bit more of the complete solution, including the MAC changes and
> the device tree for the board, so we can see the big picture.

Also what the ethernet driver looks like too!

One way around the ndev->phydev problem, assuming that we decide that
isolate is a good idea, would be to isolate the current PHY, disconnect
it from the net_device, connect the new PHY, and then clear the isolate
on the new PHY. Essentially, ndev->phydev becomes the currently-active
PHY.

However, I still want to hear whether multiple PHYs can be on the same
MII bus from a functional electrical perspective.

I know that on the Macchiatobin, where the 10G serdes signals go to the
88X3310 on doubleshot boards and to the SFP cage on singleshot boards,
this is controlled by the placement of zero ohm resistors to route the
serdes signals to the appropriate device, thus minimising the unused
stub lengths.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

