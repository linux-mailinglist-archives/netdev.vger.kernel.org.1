Return-Path: <netdev+bounces-148561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2053D9E2B26
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 19:42:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA85DBA5EA0
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 15:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D28F41F76A4;
	Tue,  3 Dec 2024 15:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="a05jWbHq"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982811F754A;
	Tue,  3 Dec 2024 15:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733239299; cv=none; b=VuGpgWLrCX6+HQxL+d9V41hiDZVPkcPQjJyzwKx0LwfGcIRSpcpijPoxGp7FBYGMMQrAyvIMu+xFBQ/XWTT4vFWPvqcuCp3brP0m4Kb10OfAdFV/updMMN+779WSpe0ssRSE2N0G2ZMzAbkrGZ3x3//oIeiqewsxo7tytpbvcNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733239299; c=relaxed/simple;
	bh=mWtkQ5CquY60LlMloavI5/3jpyFHtneZJvIg3RSc6zc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YCWo0Bn6w44BvIGWYQq/58O4ZNgvUynsH/Uz/R454Vxvw7EX1HNkNcTd9l8SwqY6H/vXLvwd8hkrvVdZ/Z0xp0OjQfRBOh1/R/Gi+jpC6n84hxH7wRX/KEokP9MWmxmORMuJ2eNV2djYI5cdRjsEnE1Dj2IlERRrNna0fANHwyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=a05jWbHq; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=560ujTZylYqzONy9nlDx4apR92OOHEPovMZg6J9+Abc=; b=a05jWbHq+J2KbE6jnoVNJm2kFi
	q3YiNHjqoSfiM6nRm3VgfW8O9nR4C+O8mRZ70+UoSwFwiDxdtONu0hPFSuiV5Wk8rAIOssco+QITh
	+1md7qUSwgBeKhzo2SyH2QbBIQKNlWg3+4Z2oM+SnehBeP967OpxTWHKe0sY9nSowqnXx4ou8ECEo
	/2BtMW5zePBiaDIyMd6RePE0nPOsk8Dt24N8vJlAxmFZQLaWN6EJxlJBFy2ns9a+8knTvXasV+qCN
	nI9OrC6ZdeMS4rvsVLIFuzLByI2yQJ0Et6+CZtgNtp/6B6JCnJRus/qO/L0Or5GVf8bHyzjxxs+EB
	K+BOvaTg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:48744)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tIUiP-00026H-1k;
	Tue, 03 Dec 2024 15:21:30 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tIUiN-0004eX-38;
	Tue, 03 Dec 2024 15:21:27 +0000
Date: Tue, 3 Dec 2024 15:21:27 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Dennis Ostermann <dennis.ostermann@renesas.com>,
	"nikita.yoush" <nikita.yoush@cogentembedded.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Michael Dege <michael.dege@renesas.com>,
	Christian Mardmoeller <christian.mardmoeller@renesas.com>
Subject: Re: [PATCH] net: phy: phy_ethtool_ksettings_set: Allow any supported
 speed
Message-ID: <Z08h95dUlS7zacTY@shell.armlinux.org.uk>
References: <73ca1492-d97b-4120-b662-cc80fc787ffd@cogentembedded.com>
 <Z02He-kU6jlH-TJb@shell.armlinux.org.uk>
 <eddde51a-2e0b-48c2-9681-48a95f329f5c@cogentembedded.com>
 <Z02KoULvRqMQbxR3@shell.armlinux.org.uk>
 <c1296735-81be-4f7d-a601-bc1a3718a6a2@cogentembedded.com>
 <Z02oTJgl1Ldw8J6X@shell.armlinux.org.uk>
 <5cef26d0-b24f-48c6-a5e0-f7c9bd0cefec@cogentembedded.com>
 <Z03aPw_QgVYn8WyR@shell.armlinux.org.uk>
 <TYCPR01MB1047854DA050E52CADB04393A8E362@TYCPR01MB10478.jpnprd01.prod.outlook.com>
 <1ff52755-ef24-4e4b-a671-803db37b58fc@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ff52755-ef24-4e4b-a671-803db37b58fc@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Dec 03, 2024 at 03:45:09PM +0100, Andrew Lunn wrote:
> On Tue, Dec 03, 2024 at 02:05:07PM +0000, Dennis Ostermann wrote:
> > Hi,
> > 
> > according to IEE 802.3-2022, ch. 125.2.4.3, Auto-Negotiation is optional for 2.5GBASE-T1
> > 
> > > 125.2.4.3 Auto-Negotiation, type single differential-pair media
> > > Auto-Negotiation (Clause 98) may be used by 2.5GBASE-T1 and 5GBASE-T1 devices to detect the
> > > abilities (modes of operation) supported by the device at the other end of a link segment, determine common
> > > abilities, and configure for joint operation. Auto-Negotiation is performed upon link startup through the use
> > > of half-duplex differential Manchester encoding.
> > > The use of Clause 98 Auto-Negotiation is optional for 2.5GBASE-T1 and 5GBASE-T1 PHYs
> > 
> > So, purposed change could make sense for T1 PHYs.
> 
> The proposed change it too liberal. We need the PHY to say it supports
> 2.5GBASE-T1, not 2.5GBASE-T. We can then allow 2.5GBASE-T1 to not use
> autoneg, but 2.5GBASE-T has to use autoneg.

I'm wondering whether we should add:

	__ETHTOOL_DECLARE_LINK_MODE_MASK(requires_an);

to struct phy_device, and have phylib populate that by default with all
base-T link modes > 1G (which would be the default case as it is now.)
Then, PHY drivers can change this bitmap as they need for their device.
After the PHY features have been discovered, this should then get
AND-ed with the supported bitmap.

We can then check this in ksettings_set() to determine whether the fixed
speed requires AN.

This would be more flexible, and allow future cases to be handled.

Good idea, or over-engineering at this point?

Another idea would be to have a boolean in struct phy_device that
identifies the PHY as base-T1, and makes an exception that way.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

