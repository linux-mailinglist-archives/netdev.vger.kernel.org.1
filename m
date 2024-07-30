Return-Path: <netdev+bounces-114123-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7116B941040
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 13:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 951631C229C9
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 11:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0856198858;
	Tue, 30 Jul 2024 11:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="vm/XWdkY"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482D918EFE0;
	Tue, 30 Jul 2024 11:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722337942; cv=none; b=e7WGSnGQmwOX+IItQaBD/3w99ty6OmrfQdQxEUCPUiT6se2MoItv70SaaCl1pCBRwZtQ8GHFjtrfTl0rw1brnbSeiJa+g89qbK0t8wys0lfUw2lOE1edyVbkzBgE5AaulsluRZ7EfiuRotZ0W+hlF2PWhRKfl8gSh8X2Cs/YdBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722337942; c=relaxed/simple;
	bh=vHn/YMFQYvEvdkK2phFGHAoHqay92V6pC/Sk/gri1yk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u+5pvjqUTH7r2cWbSBu3zFCmCq3u4kkKSBcaIJkiX25MfwrlO3BRqSz8vD2q4oYMYTEKMervWvE/bUETWX/GCcISpAGllEf33Tq6ENCv4UeqYEbR0r4CI0NTUBMAH2qs7WPowwNqs5nu1f1PXLMf2lUNZHlOsXr85ZCiGaAJe3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=vm/XWdkY; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=00cHFaeuJkRiA6ZZBAXaPk6UlUalmESLB0PKwQ7QRXE=; b=vm/XWdkYsNl1F5HkcFA0fuZr1z
	nZQSSYkGFEsK7dCx7jIm1FVwigToSDtvdDI0fJ8Q/ESovhqUOEp+6WTUU8+cROKcCJk/TMGy740zS
	w5t5/0f46QhaHcYldyxQ0ShxBxtOe+fTTE9DqeHAQmhVmp45bxPAX0NjHzVgWvDe/b8Uw4SmJAtYu
	+rURyKz8zj7xTGLNUa+SI/WUzwLvZIYANpb5c6VXHE/TAt+6kqBy95U0cgs63EBqWlXrrIZc51ENT
	sG8peN9SwSMq9zc8t5fhp/6gzHaF3I+0ypB0RQxjZX9vVPHrNFdsWMjSZIae7y5UrHg4yCJGi//eF
	pgzCh86w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44490)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sYklz-0006W2-3A;
	Tue, 30 Jul 2024 12:12:08 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sYkm3-0005Dp-Or; Tue, 30 Jul 2024 12:12:11 +0100
Date: Tue, 30 Jul 2024 12:12:11 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Revanth Kumar Uppala <ruppala@nvidia.com>,
	"andrew@lunn.ch" <andrew@lunn.ch>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH 3/4] net: phy: aquantia: Poll for TX ready at PHY system
 side
Message-ID: <ZqjKi0iC83BlZ5PT@shell.armlinux.org.uk>
References: <20230628124326.55732-1-ruppala@nvidia.com>
 <20230628124326.55732-3-ruppala@nvidia.com>
 <ZJw2u6BIShe2ZGsw@shell.armlinux.org.uk>
 <BL3PR12MB64504E3A40CD6D8EAB7FF0C8C302A@BL3PR12MB6450.namprd12.prod.outlook.com>
 <ZL5nQxCyj8x+5lWk@shell.armlinux.org.uk>
 <bb949d68-3229-45b8-964c-54ccf812f6f8@nvidia.com>
 <ZqdzOxYJiRyft1Nh@shell.armlinux.org.uk>
 <2aefce6d-5009-491b-b797-ca318e8bad4e@nvidia.com>
 <Zqi1O88vXK3Uonr1@shell.armlinux.org.uk>
 <22cd777b-ffda-439b-b2e5-866235aba05e@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22cd777b-ffda-439b-b2e5-866235aba05e@nvidia.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Jul 30, 2024 at 11:02:07AM +0100, Jon Hunter wrote:
> 
> On 30/07/2024 10:41, Russell King (Oracle) wrote:
> > On Tue, Jul 30, 2024 at 10:36:12AM +0100, Jon Hunter wrote:
> > > 
> > > On 29/07/2024 11:47, Russell King (Oracle) wrote:
> > > 
> > > ...
> > > 
> > > > > Apologies for not following up before on this and now that is has been a
> > > > > year I am not sure if it is even appropriate to dig this up as opposed to
> > > > > starting a new thread completely.
> > > > > 
> > > > > However, I want to resume this conversation because we have found that this
> > > > > change does resolve a long-standing issue where we occasionally see our
> > > > > ethernet controller fail to get an IP address.
> > > > > 
> > > > > I understand that your objection to the above change is that (per Revanth's
> > > > > feedback) this change assumes interface has the link. However, looking at
> > > > > the aqr107_read_status() function where this change is made the function has
> > > > > the following ...
> > > > > 
> > > > > static int aqr107_read_status(struct phy_device *phydev)
> > > > > {
> > > > >           int val, ret;
> > > > > 
> > > > >           ret = aqr_read_status(phydev);
> > > > >           if (ret)
> > > > >                   return ret;
> > > > > 
> > > > >           if (!phydev->link || phydev->autoneg == AUTONEG_DISABLE)
> > > > >                   return 0;
> > > > > 
> > > > > 
> > > > > So my understanding is that if we don't have the link, then the above test
> > > > > will return before we attempt to poll the TX ready status. If that is the
> > > > > case, then would the change being proposed be OK?
> > > > 
> > > > Here, phydev->link will be the _media_ side link. This is fine - if the
> > > > media link is down, there's no point doing anything further. However,
> > > > if the link is up, then we need the PHY to update phydev->interface
> > > > _and_ report that the link was up (phydev->link is true).
> > > > 
> > > > When that happens, the layers above (e.g. phylib, phylink, MAC driver)
> > > > then know that the _media_ side interface has come up, and they also
> > > > know the parameters that were negotiated. They also know what interface
> > > > mode the PHY is wanting to use.
> > > > 
> > > > At that point, the MAC driver can then reconfigure its PHY facing
> > > > interface according to what the PHY is using. Until that point, there
> > > > is a very real chance that the PHY <--> MAC connection will remain
> > > > _down_.
> > > > 
> > > > The patch adds up to a _two_ _second_ wait for the PHY <--> MAC
> > > > connection to come up before aqr107_read_status() will return. This
> > > > is total nonsense - because waiting here means that the MAC won't
> > > > get the notification of which interface mode the PHY is expecting
> > > > to use, therefore the MAC won't configure its PHY facing hardware
> > > > for that interface mode, and therefore the PHY <--> MAC connection
> > > > will _not_ _come_ _up_.
> > > > 
> > > > You can not wait for the PHY <--> MAC connection to come up in the
> > > > phylib read_status method. Ever.
> > > > 
> > > > This is non-negotiable because it is just totally wrong to do this
> > > > and leads to pointless two second delays.
> > > 
> > > 
> > > Thanks for the feedback! We will go away, review this and see if we can
> > > figure out a good/correct way to resolve our ethernet issue.
> > 
> > Which ethernet driver is having a problem?
> > 
> 
> It is the drivers/net/ethernet/stmicro/stmmac/dwmac-tegra.c driver. It works
> most of the time, but on occasion it fails to get a valid IP address.

Hmm. dwmac-tegra.c sets STMMAC_FLAG_SERDES_UP_AFTER_PHY_LINKUP, which
means that the serdes won't be powered up until after the PHY has
indicated that link is up. If the serdes is not powered up, then the
MAC facing interface on the PHY won't come up.

Hence, the code you're adding will, in all probability, merely add a
two second delay to each and every time the PHY is polled for its
status when the PHY indicates that the media link is up until such
time that the stmmac side has processed that the link has come up.

I also note that mgbe_uphy_lane_bringup_serdes_up() polls the link
status on the MAC PCS side, waiting for the link to become ready
on that side.

So, what you have is:

- you bring the interface up. The serdes interface remains powered down.
- phylib starts polling the PHY.
- the PHY indicates the media link is up.
- your new code polls the PHY's MAC facing interface for link up, but
  because the serdes interface is powered down, it ends up timing out
  after two seconds and then proceeds.
- phylib notifies phylink that the PHY has link.
- phylink brings the PCS and MAC side(s) up, calling
  stmmac_mac_link_up().
- stmmac_mac_link_up() calls mgbe_uphy_lane_bringup_serdes_up() which
  then does receive lane calibration (which is likely the reason why
  this is delayed to link-up, so the PHY is giving a valid serdes
  stream for the calibration to use.)
- mgbe_uphy_lane_bringup_serdes_up() enables the data path, and
  clears resets, and then waits for the serdes link with the PHY to
  come up.

While stmmac_mac_link_up() is running, phylib will continue to try to
poll the PHY for its status once every second, and each time it does
if the PHY's MAC facing link reports that it's down, the phylib locks
will be held for _two_ seconds each time. That will mean you won't be
able to bring the interface down until those two seconds time out.

So, I think one needs to go back and properly understand what is going
on to figure out what is going wrong.

You will likely find that inserting a two second delay at the start of
mgbe_uphy_lane_bringup_serdes_up() is just as effective at solving
the issue - although I am not suggesting that would be an acceptable
solution. It would help to confirm that the reasoning is correct.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

