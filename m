Return-Path: <netdev+bounces-83586-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A31893222
	for <lists+netdev@lfdr.de>; Sun, 31 Mar 2024 17:56:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 032021C209F6
	for <lists+netdev@lfdr.de>; Sun, 31 Mar 2024 15:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F166145331;
	Sun, 31 Mar 2024 15:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="jTg/C5uJ"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF011E531
	for <netdev@vger.kernel.org>; Sun, 31 Mar 2024 15:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711900560; cv=none; b=l7urbWipOrdyeo4Le0U+DFYyrGj9WPhCpFMxlxXFBZix2LMK5ZMawceTdbttVsHlhyKRSWnDZRO9Z4RKaWpNyQgyOGac/1iNszGmnZZlb7TyVP6AsfrCRUhb6KL7sFPGrK9fbH+wtrMGy4h4Xjmr6Nqn0c583ZSwE8jh5wgBkDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711900560; c=relaxed/simple;
	bh=y3K1VNumngJzm4HsVRvRVGUzmIKcJOr7mrcOo5NnA+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rTzq4L8g6aDlhigpJ9BBDvYUr8j459uznwNxZye0vsWAJZEYkRF0AvNWKXJ0jGWGnEaR5jLFKPoGNIkbPq1jNs+kPtQ9fN02F1as1O5p38vnqeU4Nyt9eVhoZQjBnkrivvmzFIyvpTTcY10QGTOXlWwv6HfEUM37xdYeQu3zEbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=jTg/C5uJ; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=MSgtFhYRciB3jJWn0Bl3Iuy5M7QG29zgNzby5ECkpss=; b=jTg/C5uJL7ANjVgr1NwyNAVoZG
	bVnxr+7qO6h+TtDfNysiOqudL+XcTN2hBgPiLrT1K9t2BFiT0yhX89HkXxTwh/qJF4C+DbyCJYn+C
	6VJU//Y4g4ccBHNaaZEPuy8n25K6mTH74ZMWQgaWsvqBiu3RgmWX23flGSpgffLUTD+uGuhk4N4/C
	gYfQjGBk5/SRSgikRBRftXPuBtpx+CgeHBFHp7i4ME5XfL2Fun0ozxWnbStwuueAI41LrGjQT8Dz3
	fP67s0k00S8OyoWEnmvfLJuI5dBI6FjOIo+sTVD2f/pwsNUTCQH9kO+WNnV/RhOcvmisnizAs94nS
	GVR7jQqA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:50118)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rqxX8-0003s7-0x;
	Sun, 31 Mar 2024 16:55:47 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rqxX6-0004n5-Kl; Sun, 31 Mar 2024 16:55:44 +0100
Date: Sun, 31 Mar 2024 16:55:44 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Gregory Clement <gregory.clement@bootlin.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2 6/7] dsa: mv88e6xxx: Create port/netdev LEDs
Message-ID: <ZgmHgAhXQpaaKMNb@shell.armlinux.org.uk>
References: <20240330-v6-8-0-net-next-mv88e6xxx-leds-v4-v2-0-fc5beb9febc5@lunn.ch>
 <20240330-v6-8-0-net-next-mv88e6xxx-leds-v4-v2-6-fc5beb9febc5@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240330-v6-8-0-net-next-mv88e6xxx-leds-v4-v2-6-fc5beb9febc5@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sat, Mar 30, 2024 at 01:32:03PM -0500, Andrew Lunn wrote:

> +static int mv88e6xxx_led_brightness_set(struct net_device *ndev,
> +					u8 led, enum led_brightness value)
> +{
> +	struct dsa_switch *ds = dsa_user_to_ds(ndev);
> +	struct mv88e6xxx_chip *chip = ds->priv;
> +	int port = dsa_user_to_index(ndev);

This breaks the model that the DSA layer contains shims to translate
stuff to a dsa_switch pointer and port index. That's not a complaint.
I think it's the right way forward, because the shim later feels like
it makes maintenance needlessly more complex.

I have been thinking whether to do the same for the various phylink
functions - having DSA drivers provide the phylink_mac_ops themselves
where they implement the phylink ops, and convert from the "config"
to dsa_switch+port or whatever is suitable for them where necessary.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

