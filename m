Return-Path: <netdev+bounces-218548-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 51F94B3D1FD
	for <lists+netdev@lfdr.de>; Sun, 31 Aug 2025 12:08:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC4AC7A149C
	for <lists+netdev@lfdr.de>; Sun, 31 Aug 2025 10:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE0F22A4DA;
	Sun, 31 Aug 2025 10:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="s+aUE1IA"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B491E3DC8
	for <netdev@vger.kernel.org>; Sun, 31 Aug 2025 10:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756634932; cv=none; b=FmlYI9pFty/iUJhm/8ejs0sslCXGZYueOr/Z/wtvbnh7wJk0jxBLNtWlzpVTVn9Ikz0nnwMW+vZFy5/om6qJFDQ5jBumSQQdjYuHKVgbqzUKsnMKhqe4E6UL1qONS4kcKzU5FSv2gaLjn50d8R7hXiyEPeEDkN4olia1ziD237o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756634932; c=relaxed/simple;
	bh=jd01UooJkWZMmXC+19yDRLdonl6SC/V4bqQpVZXgQGw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u4CV0FWnxc29Ihah+ix3Vj1od5g0uUHkuHGp7zuoH78NeekzRDkBLdF5QrNpWDqykFptNA3A3Whl6DdSd3sabgINM1ClG17efMWJmBGDCBS+Vj8EWifB+tM16yFaDs/bAzPDEx4e2PMJVyGfTslSdJ/wvYOvbj/qO+DL1iwsRsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=s+aUE1IA; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=1J2NCpThMNdOFpRgxZE0V/aCFXipAMunh3VihrLCjfQ=; b=s+aUE1IAL6ERvH+l85sIJJ7+L7
	1y8FLWzz1GoxR0118jQgQXr3CpnrWrMuQiAFmb7DrpFDrD9Orfs3nsT6pMu8vu+yuUYiLws9MDXP3
	KP72aaEKXoosIKmDAYhYMyCddBCBb5Knt5nst2d/UASe7BqXMzhEZ3g7VzlC0tOMdx0NO3kBu9qIZ
	Lo31M8BU8mZvSwTN+hhP6pzJ7C0QgxWC3ox1pOGmgmRLGayAwR9+rhlDZMFXJHgnqGbT34yvOh42F
	ame7+mJwxGxk7HvHQEazHYZwo++vH6NGKRuIt9NfQTyNuNIYtnGBG/JV4DvB4IbJcT5i/IOQ5gOMI
	0xWEzSyQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:41774)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1usez9-000000004on-0Du0;
	Sun, 31 Aug 2025 11:08:32 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1usez4-000000005xr-1IfH;
	Sun, 31 Aug 2025 11:08:26 +0100
Date: Sun, 31 Aug 2025 11:08:26 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: markus.stockhausen@gmx.de
Cc: andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, jan@3e8.eu,
	'Chris Packham' <chris.packham@alliedtelesis.co.nz>
Subject: Re: C22/C45 decision in phy_restart_aneg()
Message-ID: <aLQfGgYfTdcCFHtC@shell.armlinux.org.uk>
References: <009a01dc1a4b$45452120$cfcf6360$@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <009a01dc1a4b$45452120$cfcf6360$@gmx.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sun, Aug 31, 2025 at 09:45:46AM +0200, markus.stockhausen@gmx.de wrote:
> @Russell: Sorry for the inconvenience of my first mail. After a lengthy
> analysis session, I focused too much on the initial C45 enhancement 
> of the below function that you wrote. I sent it off too hastily.

It's important to send messages to the right people for a proper
discussion. Andrew may have some input on this - maybe as a result
of my ideas below.

> So, once again, here is some interesting finding regarding the 
> limitations of the Realtek MDIO driver. Remember that it can only run 
> in either C22 or C45. This time it is about autonegotiation restart.
> 
> int phy_restart_aneg(struct phy_device *phydev) {
>   int ret;
> 
>   if (phydev->is_c45 && !(phydev->c45_ids.devices_in_package & BIT(0))
>     ret = genphy_c45_restart_aneg(phydev);
>   else
>     ret = genphy_restart_aneg(phydev);
> 
>   return ret;
> }
> 
> I assume that BIT(0) means MDIO_DEVS_C22_PRESENT. As I understand it,
> this basically uses C22 commands for C45 PHYs if C22 support is detected.
> Currently, I have no reasonable explanation for this additional check.

There was discussion and delving into the spec when this was added.
See https://lore.kernel.org/all/20170601102327.GF27796@n2100.armlinux.org.uk/

(side note: google is now useless for finding that, searching for "hook
up clause 45 autonegotiation restart" returns very few results, none of
them with the full history. I've had to search my mailboxes for it, find
the message ID, and then look it up on lore. We now have various web
high-bandwidth crawlers that do not respect robots.txt to thank for this
as sites have ended up blocking all crawlers using stuff like Anubis
proof of work.)

It's been a long time, and so I've forgotten the details now, so all
there is to go on are the above emails.

You may notice that the initial version I submitted just used
phydev->is_c45.

> In our case, this function fails for C45 PHYs because the bus and PHY are 
> locked down to this single mode. It's stupid, of course, but that's how 
> it is. I see two options for fixing the issue:
> 
> 1) Mask the C22 presence in the bus for all PHYs when running in C45.
> 2) Drop the C22 condition check in the above function.

I guess we also need to make these kinds of tests conditional on
whether the bus supports C45 or not.

static bool mdiobus_supports_c22(struct mii_bus *bus)
{
	return bus->read && bus->write;
}

static bool mdiobus_supports_c45(struct mii_bus *bus)
{
	return bus->read_c45 && bus->write_c45;
}

This should be fine, because we already require MII bus drivers to only
populate these methods only when they're supported (see commit
fbfe97597c77 ("net: phy: Decide on C45 capabilities based on presence
of method").

	if (phydev->is_c45 && !(phydev->c45_ids.devices_in_package & BIT(0))

can then become:

	if (phydev->is_c45 &&
	    !(mdiobus_supports_c22(phydev->mdio.bus) &&
	      phydev->c45_ids.devices_in_package & MDIO_DEVS_C22PRESENT))

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

