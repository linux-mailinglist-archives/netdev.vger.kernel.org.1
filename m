Return-Path: <netdev+bounces-202897-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 470FFAEF971
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 14:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 568631884294
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 12:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55341274657;
	Tue,  1 Jul 2025 12:58:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AAC32741DA;
	Tue,  1 Jul 2025 12:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751374704; cv=none; b=CzMs35NdrNJ3Bl4a1IKSijL1juBxcI1UyIj4m++80wRzjqyNC8mQumlk/uqM218qtsYQA1dH/nD+zNa+CGi6bk6TYlPjVUwTzcIpyhGgxMZ1RzaatTc2J45CvfBSd5HMnQjuGs3M19Ssk38dcktvTv+ZZhNL2yDHN00Mz0iJXUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751374704; c=relaxed/simple;
	bh=uU7hVrkEHJIapRUtdI+BFAxixg3nluKlyKz9/mybDgg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JjkMgHRRlrd+1vgyLB0QgQZD/SVAv+IbQb2IRTDc0InhdGBvAys5ndE3oey9AI1tFoXl3NPpL2Z84CvTkyJmljn2REZbUPu3nwKw+OH46a2Edj/9D1wp2ps4FC/cZFVhN52x9k7A6ACqwO4wlls4S/bH5/K3kG6efVRSpf0ywEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id A80192009187;
	Tue,  1 Jul 2025 14:58:19 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 9EE25316325; Tue,  1 Jul 2025 14:58:19 +0200 (CEST)
Date: Tue, 1 Jul 2025 14:58:19 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	Andre Edich <andre.edich@microchip.com>
Subject: Re: [PATCH net v1 4/4] net: phy: smsc: Disable IRQ support to
 prevent link state corruption
Message-ID: <aGPba6fX1bqgVfYC@wunner.de>
References: <20250701122146.35579-1-o.rempel@pengutronix.de>
 <20250701122146.35579-5-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701122146.35579-5-o.rempel@pengutronix.de>

On Tue, Jul 01, 2025 at 02:21:46PM +0200, Oleksij Rempel wrote:
> Disable interrupt handling for the LAN87xx PHY to prevent the network
> interface from entering a corrupted state after rapid configuration
> changes.
> 
> When the link configuration is changed quickly, the PHY can get stuck in
> a non-functional state. In this state, 'ethtool' reports that a link is
> present, but 'ip link' shows NO-CARRIER, and the interface is unable to
> transfer data.
[...]
> --- a/drivers/net/phy/smsc.c
> +++ b/drivers/net/phy/smsc.c
> @@ -746,10 +746,6 @@ static struct phy_driver smsc_phy_driver[] = {
>  	.soft_reset	= smsc_phy_reset,
>  	.config_aneg	= lan87xx_config_aneg,
>  
> -	/* IRQ related */
> -	.config_intr	= smsc_phy_config_intr,
> -	.handle_interrupt = smsc_phy_handle_interrupt,
> -

Well, that's not good.  I guess this means that the interrupt is
polled again, so we basically go back to the suboptimal behavior
prior to 1ce8b37241ed?

Without support for interrupt handling, we can't take advantage
of the GPIOs on the chip for interrupt generation.  Nor can we
properly support runtime PM if no cable is attached.

What's the actual root cause?  Is it the issue described in this
paragraph of 1ce8b37241ed's commit message?

    Normally the PHY interrupt should be masked until the PHY driver has
    cleared it.  However masking requires a (sleeping) USB transaction and
    interrupts are received in (non-sleepable) softirq context.  I decided
    not to mask the interrupt at all (by using the dummy_irq_chip's noop
    ->irq_mask() callback):  The USB interrupt endpoint is polled in 1 msec
    intervals and normally that's sufficient to wake the PHY driver's IRQ
    thread and have it clear the interrupt.  If it does take longer, worst
    thing that can happen is the IRQ thread is woken again.  No big deal.

There must be better options than going back to polling.
E.g. inserting delays to avoid the PHY getting wedged.

TBH I did test this thoroughly back in the day and never
witnessed the issue.

Thanks,

Lukas

