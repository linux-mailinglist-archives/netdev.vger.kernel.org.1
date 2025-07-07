Return-Path: <netdev+bounces-204662-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1633BAFBA66
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 20:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEBC71899B21
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 18:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEDC0261586;
	Mon,  7 Jul 2025 18:10:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB43194C96;
	Mon,  7 Jul 2025 18:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751911841; cv=none; b=bjvACUascsgPFycqJ0AyE5WnMjoSY1K5xr3XviI4/Ug7fkDv8lgN+9h/JQQXKXi+GFj3UO/alaB7Ga+n/S4Olqb3l5nIYyfOwMwbvOkNn/x5YltHJa02o2peCrFyk72MLk6PS2prgjSRZNWDXUlJ/iScS7FOu6wN9FpYvNIG8Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751911841; c=relaxed/simple;
	bh=wlHrCtGBl+DGqEhOWB+uOhhtbGi1szeAAR8W96IRhys=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TofEdPpDnBcBdMNZaPn0HLympt4McjJ4DabZxiOYFRCyBqmIuJlSN37jBiyregff13ezpbbCUYXRHWDnjBPt7XYjnFWCaIgTSErSFryD7s4wxeLq1pHsBeIWkdFGo+u7koiy8BSqXralQDM/V00XAWm9tajJLHSQ89gbvDf4KNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 7F0F92009184;
	Mon,  7 Jul 2025 20:10:36 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 67F0D19DDB6; Mon,  7 Jul 2025 20:10:36 +0200 (CEST)
Date: Mon, 7 Jul 2025 20:10:36 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	kernel@pengutronix.de, linux-kernel@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	Andre Edich <andre.edich@microchip.com>
Subject: Re: [PATCH net v1 2/2] net: phy: smsc: add adaptive polling to
 recover missed link-up on LAN8700
Message-ID: <aGwNnBJbM9LWnJ8f@wunner.de>
References: <20250707153232.1082819-1-o.rempel@pengutronix.de>
 <20250707153232.1082819-3-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250707153232.1082819-3-o.rempel@pengutronix.de>

On Mon, Jul 07, 2025 at 05:32:32PM +0200, Oleksij Rempel wrote:
> Fixe unreliable link detection on LAN8700 configured for 10 Mbit / half-

s/Fixe/Fix/

> or full-duplex against an autonegotiating partner and similar scenarios.
> 
> The LAN8700 PHY (build in to LAN9512 and similar adapters) can fail to

s/build/built/

> report a link-up event when it is forced to a fixed speed/duplex and the
> link partner still advertises autonegotiation. During link establishment
> the PHY raises several interrupts while the link is not yet up; once the
> link finally comes up no further interrupt is generated, so phylib never
> observes the transition and the kernel keeps the interface down even
> though ethtool shows the link as up.
> 
> Mitigate this by combining interrupts with adaptive polling:
> 
> - When the driver is running in pure polling mode it continues to poll
>   once per second (unchanged).
> - With an IRQ present we now
>   - poll every 30 s while the link is up (low overhead);
>   - switch to a 1 s poll for up to 30 s after the last IRQ and while the
>     link is down, ensuring we catch the final silent link-up.

I think this begs the question, if we *know* that the link may come up
belatedly without an interrupt, why poll?  Would it work to schedule a
one-off link check after a reasonable delay to catch the link change?

I'm also wondering if enabling EDPD changes the behavior?

> +static unsigned int smsc_phy_get_next_update(struct phy_device *phydev)
> +{
> +	struct smsc_phy_priv *priv = phydev->priv;
> +
> +	/* If interrupts are disabled, fall back to default polling */
> +	if (phydev->irq == PHY_POLL)
> +		return SMSC_NOIRQ_POLLING_INTERVAL;
> +
> +	/* The PHY sometimes drops the *final* link-up IRQ when we run
> +	 * with autoneg OFF (10 Mbps HD/FD) against an autonegotiating
> +	 * partner: we see several "link down" IRQs, none for "link up".

Hm, I'm not seeing a check for all those conditions (e.g. autoneg off) here?

Also, you seem to be using UTF-8 characters instead of US-ASCII single or
double quotes around "link down" and "link up".

> +	 *
> +	 * Work-around philosophy:
> +	 *   - If the link is already up, the hazard is past, so we
> +	 *     revert to a relaxed 30 s poll to save power.
> +	 *   - Otherwise we stay in a tighter polling loop for up to one
> +	 *     full interval after the last IRQ in case the crucial
> +	 *     link-up IRQ was lost.  Empirically 5 s is enough but we
> +	 *     keep 30 s to be extra conservative.
> +	 */
> +	if (!priv->last_irq || phydev->link ||
> +	    time_is_before_jiffies(priv->last_irq + SMSC_IRQ_POLLING_INTERVAL))
> +		return SMSC_IRQ_POLLING_INTERVAL;
> +
> +	return SMSC_NOIRQ_POLLING_INTERVAL;
> +}

Thanks,

Lukas

