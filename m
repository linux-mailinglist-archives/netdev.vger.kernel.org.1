Return-Path: <netdev+bounces-103855-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BDAD909E51
	for <lists+netdev@lfdr.de>; Sun, 16 Jun 2024 18:07:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E5051C209B6
	for <lists+netdev@lfdr.de>; Sun, 16 Jun 2024 16:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3BD9168DE;
	Sun, 16 Jun 2024 16:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="tNE7bAc1"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB68168B7;
	Sun, 16 Jun 2024 16:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718554054; cv=none; b=nzn4MHSTxA+EUWdvInAtLB0QOCz3mJnXNBhO6dld+ewiehVXqWrp5Z31yWXrQ4gZXrB71ZLlWgYTMW+cWleAEXlx3C9yRCyXYnY7EKau5t7zFpqBbmOBDPMBcacJ47W3cmwzeSZJxGchNv0O2gn0oZ8fZsI1/BpErxlkSuNDFBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718554054; c=relaxed/simple;
	bh=VGdrVpvwehZq8pQcgcX31wohiO4uVDxEBXMaZKuXWRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bQOIUJU8TWQthVMRvnyEd5a7J8jJdERJLvCgE850IiskPypIJJUtynfEEy14oAzrzK6SNU5ysSCShBy7fYxDVDDoZCu7eMaHhfT/uFXN3QDKheeRJ+ABEXMrku9Z3V8rjKKsp2ayCCDr3wNjIcLrLUIz5/GAmvmOjPUT/nKh2/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=tNE7bAc1; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=nEcYSTIbPEKIGdfvYT2zer1/87igAAr4ZhpzWWwsRi4=; b=tNE7bAc1VDfe9maB6HuA3f+3FH
	n7Dcp/vmcbsiLl0yHtnLxwSj9ZeEBVDWyoIS4DBE+4x/QHE/12Gl5qHSPGxhBpcVZSgk0jApnH6JR
	y74zhZI95Xom+diPUXHJce1SBZdSAioyZnaR8ZdxJiMP7biDWghILyowLRUvepsonZtRRsM55eQm/
	M/Ff9BDAAh23eSeyIfuf+5/06dy5xz1bRkUkqK7s2XPiSj7O1DHsfe2zH9b9n7AmtX7dadYpibiaF
	KT34sfYLsr8mGlwnY13eB5UzO4rThrf1qZWpRauife7neo+w6wwIn5g5Hx5WJCjwS9JDvlII2OkDL
	lpzcJvwQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:53962)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sIsPP-0004E8-0R;
	Sun, 16 Jun 2024 17:07:11 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sIsPM-00046m-OT; Sun, 16 Jun 2024 17:07:08 +0100
Date: Sun, 16 Jun 2024 17:07:08 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com, Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	=?iso-8859-1?Q?Nicol=F2?= Veronese <nicveronese@gmail.com>,
	Simon Horman <horms@kernel.org>, mwojtas@chromium.org,
	Nathan Chancellor <nathan@kernel.org>,
	Antoine Tenart <atenart@kernel.org>
Subject: Re: [PATCH net-next v13 05/13] net: ethtool: Allow passing a phy
 index for some commands
Message-ID: <Zm8NrEproHTPzo+O@shell.armlinux.org.uk>
References: <20240607071836.911403-1-maxime.chevallier@bootlin.com>
 <20240607071836.911403-6-maxime.chevallier@bootlin.com>
 <20240613182613.5a11fca5@kernel.org>
 <20240616180231.338c2e6c@fedora>
 <9dbd5b23-c59d-4200-ab9c-f8a9d736fea6@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9dbd5b23-c59d-4200-ab9c-f8a9d736fea6@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sun, Jun 16, 2024 at 05:21:25PM +0200, Andrew Lunn wrote:
> On Sun, Jun 16, 2024 at 06:02:31PM +0200, Maxime Chevallier wrote:
> > Hello Jakub,
> > 
> > On Thu, 13 Jun 2024 18:26:13 -0700
> > Jakub Kicinski <kuba@kernel.org> wrote:
> > 
> > > On Fri,  7 Jun 2024 09:18:18 +0200 Maxime Chevallier wrote:
> > > > +		if (tb[ETHTOOL_A_HEADER_PHY_INDEX]) {
> > > > +			struct nlattr *phy_id;
> > > > +
> > > > +			phy_id = tb[ETHTOOL_A_HEADER_PHY_INDEX];
> > > > +			phydev = phy_link_topo_get_phy(dev,
> > > > +						       nla_get_u32(phy_id));  
> > > 
> > > Sorry for potentially repeating question (please put the answer in the
> > > commit message) - are phys guaranteed not to disappear, even if the
> > > netdev gets closed? this has no rtnl protection
> > 
> > I'll answer here so that people can correct me if I'm wrong, but I'll
> > also add it in the commit logs as well (and possibly with some fixes
> > depending on how this discussion goes)
> > 
> > While a PHY can be attached to/detached from a netdevice at open/close,
> > the phy_device itself will keep on living, as its lifetime is tied to
> > the underlying mdio_device (however phy_attach/detach take a ref on the
> > phy_device, preventing it from vanishing while it's attached to a
> > netdev)
> 
> It gets interesting with copper SFP. They contain a PHY, and that PHY
> can physically disappear at any time. What i don't know is when the
> logical representation of the PHY will disappear after the hotunplug
> event.

On a SFP module unplug, the following upstream device methods will be
called in order:
1. link_down
2. module_stop
3. disconnect_phy

At this point, the PHY device will be removed (phy_device_remove()) and
freed (phy_device_free()), and shortly thereafter, the MDIO bus is
unregistered and thus destroyed.

In response to the above, phylink will, respectively for each method:

1. disable the netdev carrier and call mac_link_down()
2. call phy_stop() on the attached PHY
3. remove the PHY from phylink, and then call phy_disconnect(),
   disconnecting it from the netdev.

Thus, when a SFP PHY is being removed, phylib will see in order the
following calls:

	phy_disconnect()
	phy_device_remove()
	phy_device_free()

Provided the topology linkage is removed on phy_disconnect() which
disassociates the PHY from the netdev, SFP PHYs should be fine.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

