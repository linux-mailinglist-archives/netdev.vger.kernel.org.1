Return-Path: <netdev+bounces-50176-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED3D37F4C5F
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 17:31:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82CD42810F4
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 16:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1BBBEA8;
	Wed, 22 Nov 2023 16:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Ua2AZSG9"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C46FC19E
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 08:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=gwGbCMTsH64qaCI3+11KUJqW/R9W2u8CDVGrf2J3TUs=; b=Ua2AZSG9D4BL0oWlAQyHw6rMqt
	TmdV7FXzhJCitGBEd6hR+PJ5V0pV3NQ3C0IRUmuljm6/TwDxBKebDn6f3lHxBM11IwprKxqA1BE5P
	7OsXEOW055seWe/6YcN1irQikRg0j6xaq/hDIkGGU7e624Yl1jLkY8NLPDSpOMSORsyGB6bOcC4Dc
	0wWNl2CZ2Lc/tmz4apSeVwz4YgQvxRq7nXEJCxejjC0BKMOr1U510UIoRnxfx4VCWxmwxy6CyXEwr
	sbGdB8L80Aw0CQ9F3lY/4Ua20guLg5xiVA9qbgMOO9mNLEKXSY/rl7fRObK+BAfyjNmz6/oEUj7kx
	ZNNKd6wQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:59652)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1r5q7f-0000S6-0w;
	Wed, 22 Nov 2023 16:30:43 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1r5q7d-0005Kf-3y; Wed, 22 Nov 2023 16:30:41 +0000
Date: Wed, 22 Nov 2023 16:30:41 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Jiawen Wu <jiawenwu@trustnetic.com>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, mengyuanlou@net-swift.com
Subject: Re: [PATCH net-next 1/5] net: wangxun: add flow control support
Message-ID: <ZV4ssdbQyxtYgURN@shell.armlinux.org.uk>
References: <20231122102226.986265-1-jiawenwu@trustnetic.com>
 <20231122102226.986265-2-jiawenwu@trustnetic.com>
 <6218df6e-db11-4640-a296-946088d32916@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6218df6e-db11-4640-a296-946088d32916@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Nov 22, 2023 at 05:15:05PM +0100, Andrew Lunn wrote:
> > +static void ngbe_get_pauseparam(struct net_device *netdev,
> > +				struct ethtool_pauseparam *pause)
> > +{
> > +	struct wx *wx = netdev_priv(netdev);
> > +
> > +	pause->autoneg = !wx->fc.disable_fc_autoneg;
> 
> Maybe call it enable_fs_autoneg, since that is what the kAPI uses?

fs?

> > +	wx->fc.disable_fc_autoneg = !pause->autoneg;
> > +	wx->fc.tx_pause = pause->tx_pause;
> > +	wx->fc.rx_pause = pause->rx_pause;
> > +
> > +	phy_set_asym_pause(wx->phydev, pause->rx_pause, pause->tx_pause);
> 
> You should only be doing this if pause->autoneg is true. If it is
> false, you ignore the results from autoneg, and just configure the
> hardware as indicated by pause->{tr}x_pause.

However, if autoneg is supported, but pause autoneg is disabled, there
is still the need to update the PHY's advertisement so the remote end
knows what's going on, as documented in the user API:

" * If the link is autonegotiated, drivers should use
  * mii_advertise_flowctrl() or similar code to set the advertised
  * pause frame capabilities based on the @rx_pause and @tx_pause flags,
  * even if @autoneg is zero. ... "

You are correct that when !pause->autoneg, tx_pause/rx_pause are to be
used in place of the negotiated versions.

Also... when getting the pause parameters, tx_pause/rx_pause _should_
reflect what was set for these parameters via the set function, *not*
the current state affected by negotiation.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

