Return-Path: <netdev-owner@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F35407412ED
	for <lists+netdev@lfdr.de>; Wed, 28 Jun 2023 15:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231761AbjF1Nq7 (ORCPT <rfc822;lists+netdev@lfdr.de>);
        Wed, 28 Jun 2023 09:46:59 -0400
Received: from vps0.lunn.ch ([156.67.10.101]:40044 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230311AbjF1Nq4 (ORCPT <rfc822;netdev@vger.kernel.org>);
        Wed, 28 Jun 2023 09:46:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=JMUHvdoDQLqrrnqwbiuInr98425vgxaGjPqF0nUZz+s=; b=hRaXw8f+rFVlI2HNTnrOrC93UG
        0tNA42+RcyFae7gG0C0utELCBB0nrSeDtuWPPU3HE3CjEEc/H5hCCG8auuwfgA+bIZGoSDJKFPakM
        RItbCCiOxCNuo4k1GwBQ5lS3h9ogokz4Ubm5dQXqt8A5zwLSx58CZe0wWRWkxg7c5sE4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qEVVV-0007Z4-UX; Wed, 28 Jun 2023 15:46:53 +0200
Date:   Wed, 28 Jun 2023 15:46:53 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Revanth Kumar Uppala <ruppala@nvidia.com>, hkallweit1@gmail.com,
        netdev@vger.kernel.org, linux-tegra@vger.kernel.org,
        Narayan Reddy <narayanr@nvidia.com>
Subject: Re: [PATCH 1/4] net: phy: aquantia: Enable Tx/Rx pause frame support
 in aquantia PHY
Message-ID: <ce4c10b5-c2cf-489d-b096-19b5bcd8c49e@lunn.ch>
References: <20230628124326.55732-1-ruppala@nvidia.com>
 <ZJw2CKtgqbRU/3Z6@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJw2CKtgqbRU/3Z6@shell.armlinux.org.uk>
Precedence: bulk
List-ID: <netdev.vger.kernel.org>
X-Mailing-List: netdev@vger.kernel.org

On Wed, Jun 28, 2023 at 02:30:48PM +0100, Russell King (Oracle) wrote:
> On Wed, Jun 28, 2023 at 06:13:23PM +0530, Revanth Kumar Uppala wrote:
> > From: Narayan Reddy <narayanr@nvidia.com>
> > 
> > Enable flow control support using pause frames in aquantia phy driver.
> > 
> > Signed-off-by: Narayan Reddy <narayanr@nvidia.com>
> > Signed-off-by: Revanth Kumar Uppala <ruppala@nvidia.com>
> 
> I think this is over-complex.
> 
> >  #define MDIO_PHYXS_VEND_IF_STATUS		0xe812
> >  #define MDIO_PHYXS_VEND_IF_STATUS_TYPE_MASK	GENMASK(7, 3)
> >  #define MDIO_PHYXS_VEND_IF_STATUS_TYPE_KR	0
> > @@ -583,6 +585,17 @@ static int aqr107_config_init(struct phy_device *phydev)
> >  	if (!ret)
> >  		aqr107_chip_info(phydev);
> >  
> > +	/* Advertize flow control */
> > +	linkmode_set_bit(ETHTOOL_LINK_MODE_Pause_BIT, phydev->supported);
> > +	linkmode_set_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT, phydev->supported);
> > +	linkmode_copy(phydev->advertising, phydev->supported);
> 
> This is the wrong place to be doing this, since pause support depends
> not only on the PHY but also on the MAC. There are phylib interfaces
> that MACs should call so that phylib knows that the MAC supports pause
> frames.
> 
> Secondly, the PHY driver needs to tell phylib that the PHY supports
> pause frames, and that's done through either setting the .features
> member in the PHY driver, or by providing a .get_features
> implementation.
> 
> Configuration of the pause advertisement should already be happening
> through the core phylib code.

I really should do a LPC netdev talk "Everybody gets pause wrong..."

genphy_c45_an_config_aneg() will configure pause advertisement. The
PHY driver does not need to configure it, if the PHY follows the
standard and has the configuration in the correct place. As Russell
said, please check the PHYs ability to advertise pause is being
reported correctly, by .get_features, of the default implementation of
.get_features if that is being used. And then check your MAC driver is
also indicating it supports pause.

	Andrew
