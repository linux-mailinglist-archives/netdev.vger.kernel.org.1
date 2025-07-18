Return-Path: <netdev+bounces-208163-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0455AB0A5BB
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 15:59:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C731E5A59E5
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 13:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B02C2DCC03;
	Fri, 18 Jul 2025 13:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="IUiiHLhp"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89A552DCBF4;
	Fri, 18 Jul 2025 13:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752847147; cv=none; b=Pg7o0b7aPV8OqvRERhle6An4+Br3YtrvzatC3nNpPtqKn+CP4rCCROQrYhzfB87uvKZOQTynV0J5ZAqADKchdcS7D/e9ERoZTesnCGeiiajoHjh+VlxS+8OxQjnm7079iYgk/3jCLGtuJGWnRev7VDSDWWv2HuJjfZTGOZjynfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752847147; c=relaxed/simple;
	bh=SO1Cr+JxrwDRiS2YlUtLUAroPiRof0FTOjcUxa99jXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oj3Yq4EXjwECUwgRv7BfXSJ7IpVaVxyjibQaiyG06OYx2TNnySJ8gPTAUO97iD9pcnNCb+9NbRdTR4Nop1tWEIgRPKA1/KUS/WOMici2bw1I2SA8TM4MtreCj424r+u18PniiRXO4WeAv5n+Uehpd/VGHRPPumSit5YOLUhL/GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=IUiiHLhp; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=FQcWQcpCN3Y38GiMafZhnaGAa0aOJeciEQGMTqzhgqA=; b=IUiiHLhpgrjin89G6aItM/YNWq
	XGLY+ySPIaUr1cTGwXlZc3vZv2Jy9bCtH7sIy+BaxVL2lhaMnfJEC4W8wJzLfwWDleO0tQKGDd3bK
	TOD7mVUqHdxNIKz4q1V/GVhsmTJgQ+hEgHvkWODkFHVW3+6C8l+klvmfwCkH8v6Z0hko=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uclc0-001zmJ-FE; Fri, 18 Jul 2025 15:58:56 +0200
Date: Fri, 18 Jul 2025 15:58:56 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	Andre Edich <andre.edich@microchip.com>,
	Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH net v4 0/3] net: phy: smsc: use IRQ + relaxed polling to
 fix missed link-up
Message-ID: <657997b5-1c20-4008-8b70-dc7a7f56c352@lunn.ch>
References: <20250714095240.2807202-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714095240.2807202-1-o.rempel@pengutronix.de>

On Mon, Jul 14, 2025 at 11:52:37AM +0200, Oleksij Rempel wrote:
> This series makes the SMSC LAN8700 (as used in LAN9512 and similar USB
> adapters) reliable again in configurations where it is forced to 10 Mb/s
> and the link partner still advertises autonegotiation.

I've seen a comment from another Maintainer that thinks this is rather
hackish. I tend to agree, you are adding complexity to the core to
handle one broken PHY, and a corner case in that PHY. It would be
better to hide as much of this in the PHY driver.

I'm wondering if there is a much simpler solution, which does not need
the core changing. Have the driver dynamically flip between interrupts
and polling, depending on the link mode.

Start up in the usual way. If the platform supports interrupts, let
the core get the interrupt, install the handler and use
interrupts. Otherwise do polling.

If .config_aneg() puts the PHY into the broken state, forced to 10
Mb/s, and interrupts are used, set phydev->irq = PHY_POLL, and call
phy_trigger_machine() to kick off polling.

If .config_aneg() is called to take it out of the broken state,
restore phydev->irq. An additional poll up to one second later should
not cause any issues.

I don't think this needs any core code changes.

Maybe there is an issue with phy_free_interrupt() being called while
irq has been set to polling? You might be able to use the
phy_driver.remove() to handle that?

	Andrew

