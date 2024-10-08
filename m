Return-Path: <netdev+bounces-133175-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 839FC995364
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 17:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31924283A20
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 15:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA011E0082;
	Tue,  8 Oct 2024 15:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="WLDmjm41"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02F91DFE00;
	Tue,  8 Oct 2024 15:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728401277; cv=none; b=fM0pj4ZfH9T18ETpvXxgWEA4mDHyetFIRlO8gJbV8dgZwK7QL9Kgk7Ub7IJu2bJ9yhHy/RE0m3VXjx4oPaF6kAzPGuphA0ij5VbbxDYpeNB2g1aj3+8XAjsfCQ5ZnlW17BYEV5Zb6u5+h7iwf5EoENhntMORjo3dV0HYvSEfU6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728401277; c=relaxed/simple;
	bh=/nNNkCPa14tl4T8/iPpdXojCkRsEih3ZlyZ5E/c0n6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QDYhiQO02RpQR5HEOc1MHovPDTx7dKQqqNjtnYEdQxfkwqrg0mal/wBrvxFKzi1W3UjbdZm5WEOZzVFUwB/g7H9gmpke/7ZMeegyuAzotqcBiJyHR7xvhb2EFcbDHR5xxRoRYWXDfoaZOjZT98JSZUBaaJT/uuW2S2C1N476U6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=WLDmjm41; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=FST8qW+eM/NUtJ2BpKAboGn3/932eVgmWk4GHR1qc08=; b=WLDmjm41bOzYWnzltA5tU7XUeN
	tpinM0bbWHJ2wVuCPjmIHQT20SU7dZNhOyORzUafZZ8fGc5aa1v0cySxTGj8pwZIk3AU/2m4eAsIt
	5isCs9k3YjjQ3g41LdMGMuL2OSDZnfo+j06R01PkzrJB5pjUV0DRNxv0z7TygUeXfKHeRilQi/QHK
	xkvrh7yY+pd5Sbazd8nPLgL3WzpsiniEYo3bhazy0zvlolr21t88jfpuPivFnmfqUZ7zZa8EZOEe5
	oFGNI1e6TlxD52RzCRgJvqqrF/KvOkp6Dbm/DJtHAbghv1aV0xQ1vwCMaxQ8hL4/72bTt/XhOh6dy
	CI//Ludg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:49600)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1syC7o-0007h9-1d;
	Tue, 08 Oct 2024 16:27:48 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1syC7j-0005Im-36;
	Tue, 08 Oct 2024 16:27:43 +0100
Date: Tue, 8 Oct 2024 16:27:43 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, davem@davemloft.net,
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
Message-ID: <ZwVPb1Prm_zQScH0@shell.armlinux.org.uk>
References: <20241004161601.2932901-8-maxime.chevallier@bootlin.com>
 <4d4c0c85-ec27-4707-9613-2146aa68bf8c@lunn.ch>
 <ZwA7rRCdJjU9BUUq@shell.armlinux.org.uk>
 <20241007123751.3df87430@device-21.home>
 <6bdaf8de-8f7e-42db-8c29-1e8a48c4ddda@lunn.ch>
 <20241007154839.4b9c6a02@device-21.home>
 <b71aa855-9a48-44e9-9287-c9b076887f67@lunn.ch>
 <20241008092557.50db7539@device-21.home>
 <f1af0323-23f5-44fd-a980-686815957b5a@lunn.ch>
 <20241008165742.71858efa@device-21.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008165742.71858efa@device-21.home>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Oct 08, 2024 at 04:57:42PM +0200, Maxime Chevallier wrote:
> Oh but I plan to add support for the marvell switch, mcbin, and turris
> first,

What do you think needs adding for the mcbin?

For the single-shot version, the serdes lines are hard-wired to the
SFP cages, so it's a MAC with a SFP cage directly connected.

For the double-shot, the switching happens dynamically within the
88x3310 PHY, so there's no need to fiddle with any isolate modes.

The only thing that is missing is switching the 88x3310's fibre
interface from the default 10gbase-r to 1000base-X and/or SGMII, and
allowing PHYs to be stacked on top. The former I have untested
patches for but the latter is something that's waiting for
networking/phylib to gain support for stacked PHY.

Switching the interface mode is very disruptive as it needs the PHY
to be software-reset, and if the RJ45 has link but one is simply
plugging in a SFP, hitting the PHY with a software reset will
disrupt that link.

Given that the mcbin has one SFP cage that is capable of 2500base-X,
1000base-X and SGMII, and two SFP cages that can do 10gbase-r, with
a PHY that can do 10/100/1G/2.5G/5G/10G over the RJ45, I'm not sure
adding more complexity really gains us very much other than...
additional complexity.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

