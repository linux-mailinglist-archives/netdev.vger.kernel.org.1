Return-Path: <netdev+bounces-148029-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EE1E9DFE0D
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 11:04:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB3B3B23ED2
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 10:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCECB1FA17F;
	Mon,  2 Dec 2024 10:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Qls5pUpR"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8C515A8;
	Mon,  2 Dec 2024 10:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733133853; cv=none; b=IOdHM4PjxKBTZybqDAp0xTkw4BgZdqfRmaxPN9C34byJt8tTwjUN2k4UEf0M5NDbVboF1DnPdAJhirxZJnMJstcIa/WfpwJkb3XktT7nEL50w8a3YaQSIHKrG07OKYAPl2aeLJdPTFAqDb0WfjwXazfLRTqGxREQdpbj8vTHsTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733133853; c=relaxed/simple;
	bh=2Lkd9Ijvwvpof8iO4bmOZDTqeOxNgFJ2P3yrVbN2vlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eX9sC5npJnioAbdEJ9xI17LhbUwDHusqctXaVYHjqUjWKsgPCcF5J5r7TJLe7OA2LsPzO19j8hdU+mVOShsNKO/aNaOG5a24lPam9D0VNvTKG4dTbLWnzuFmw/hDLpPcj+3YEe3eVWNsHsOhWuyzJXLoiXLcAEbPKNoBWGgUAcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Qls5pUpR; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=pV+sM3rbIDkKfXwr2BfPRA+jRWfynOGk3G+gE5xBhQU=; b=Qls5pUpRaDYVoZqEPgOnHOXOIL
	rheNDh/AdGn1kn4cKJ1GkAg2w/hDFjdFt+8EA/LX9YwGDqOlVcXnjJ5pxSKW4w+DcDqyD1p1qwrqf
	m+7buEykoXQL6BTuV2oOlm/JHBGAj+qqWu1IbIHoc0ye5Q0u4kjc+jKRPe0FYICHI+zh2+M6hayE7
	2KRwzNbkeQWI5EIDIQ/fqTBuaBbWO9IJ+RsOhdA48KiQoyObVC/tq+M3SgCTi37beMGo7J73SPBNx
	ot40pnJ3SCf9defKK9CJB1rq/MEca8cV6PHi2eeh8OinWqXQ790gnbwkcDi+fDA6qX6Bxhjg8ge8P
	ARvuBccg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45962)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tI3HX-000884-2Z;
	Mon, 02 Dec 2024 10:03:56 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tI3HU-0003TN-2H;
	Mon, 02 Dec 2024 10:03:52 +0000
Date: Mon, 2 Dec 2024 10:03:52 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Michael Dege <michael.dege@renesas.com>,
	Christian Mardmoeller <christian.mardmoeller@renesas.com>,
	Dennis Ostermann <dennis.ostermann@renesas.com>
Subject: Re: [PATCH] net: phy: phy_ethtool_ksettings_set: Allow any supported
 speed
Message-ID: <Z02GCGMOuiwZ4qvA@shell.armlinux.org.uk>
References: <20241202083352.3865373-1-nikita.yoush@cogentembedded.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202083352.3865373-1-nikita.yoush@cogentembedded.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Dec 02, 2024 at 01:33:52PM +0500, Nikita Yushchenko wrote:
> When auto-negotiation is not used, allow any speed/duplex pair
> supported by the PHY, not only 10/100/1000 half/full.
> 
> This enables drivers to use phy_ethtool_set_link_ksettings() in their
> ethtool_ops and still support configuring PHYs for speeds above 1 GBps.
> 
> Also this will cause an error return on attempt to manually set
> speed/duplex pair that is not supported by the PHY.

Does IEEE 802.3 allow auto-negotiation to be turned off for speeds
greater than 1Gbps?

My research for 1G speeds indicated that AN is required as part of the
establishment of link parameters other than the capabilities of each
end. We have PHYs that require AN to be turned on for 1G speeds, and
other PHYs that allow the AN enable bit to be cleared, but internally
keep it enabled for 1G. To eliminate patches in drivers that force
AN for 1G or error out the ksettings_set call, phylib now emulates the
advertisement for all PHYs and keeps AN enabled when the user requests
fixed-speed 1G, which is what Marvell PHYs do and is the most sensible
solution.

Presently, I don't think it makes sense to turn off AN for speeds
beyond 1G. You need to provide a very good reason for why this is
desired, a real use for it, and indicate why it would be safe to
do.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

