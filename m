Return-Path: <netdev+bounces-196060-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90023AD35D8
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 14:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D07CF3B05CE
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 12:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA7B28F930;
	Tue, 10 Jun 2025 12:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="U6LiZTq7"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA60528F509;
	Tue, 10 Jun 2025 12:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749557827; cv=none; b=N7ZaVlounI8m5CxazM0uH0B9v6XYsxB5lvPD+nnTzcffFOwNoyzPhZFQiBEY5GnFKRHMiAYzo5bZ07t4rmzbLtB7/4EGAQeY3jpnoYFeLuxd9aWuJ8eILsCzRMMYnTEgndu01cdg2tZxdqPQqY446Y983sxWeO++2D1w1V0PwVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749557827; c=relaxed/simple;
	bh=omxUG8bbtsYAboaiJAE2LR4AXyYHGu7YqcfKF6Y8qZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YotjftGEVpZ1ExF84uKtNM7upnSyZLMSA93ZXmAqZSVTfCYbJqKfFTaUOYYumgORoUrOUbks9pldWCin7bZIIGFZDuoWe/ODNzza72qFdldV/ppXkjoSwlfYQTobw4vusqxSpharGw8s+Y9YBJFiIq5G5ww6fBuLTOgGRewsOm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=U6LiZTq7; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=EaIbOxWHGz4F6US80CpGSyzZKAY2qo/Md4Gb+B5yJdY=; b=U6LiZTq7nBCexaEQ/Ascd7UmU8
	9ojqDaA3EJ6lbO/MBPC3N5sP4FW2TK/uUJoCTq/xK0kLRDnM/+MEtTtGUg8PGzUNluc7lAZaPvIOK
	soKWiXpykte4UNMdzoH3i2Kaa0+sQm6NIpS6IsSWpLHw9WxH1eG5o8T4LkSzNDNaMPoc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uOxuB-00FFx1-7p; Tue, 10 Jun 2025 14:16:39 +0200
Date: Tue, 10 Jun 2025 14:16:39 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	David Jander <david@protonic.nl>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v1 1/3] net: phy: dp83tg720: implement soft
 reset with asymmetric delay
Message-ID: <534b3aed-bef5-410e-b970-495b62534d96@lunn.ch>
References: <20250610081059.3842459-1-o.rempel@pengutronix.de>
 <20250610081059.3842459-2-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250610081059.3842459-2-o.rempel@pengutronix.de>

On Tue, Jun 10, 2025 at 10:10:57AM +0200, Oleksij Rempel wrote:
> From: David Jander <david@protonic.nl>
> 
> Add a .soft_reset callback for the DP83TG720 PHY that issues a hardware
> reset followed by an asymmetric post-reset delay. The delay differs
> based on the PHY's master/slave role to avoid synchronized reset
> deadlocks, which are known to occur when both link partners use
> identical reset intervals.
> 
> The delay includes:
> - a fixed 1ms wait to satisfy MDC access timing per datasheet, and
> - an empirically chosen extra delay (97ms for master, 149ms for slave).
> 
> Co-developed-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Signed-off-by: David Jander <david@protonic.nl>

Hi Oleksij

Since you are submitting it, your Signed-off-by should come last. The
order signifies the developers who passed it along towards merging.

> ---
>  drivers/net/phy/dp83tg720.c | 75 ++++++++++++++++++++++++++++++++-----
>  1 file changed, 65 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/phy/dp83tg720.c b/drivers/net/phy/dp83tg720.c
> index 7e76323409c4..2c86d05bf857 100644
> --- a/drivers/net/phy/dp83tg720.c
> +++ b/drivers/net/phy/dp83tg720.c
> @@ -12,6 +12,42 @@
>  
>  #include "open_alliance_helpers.h"
>  
> +/*
> + * DP83TG720 PHY Limitations and Workarounds
> + *
> + * The DP83TG720 1000BASE-T1 PHY has several limitations that require
> + * software-side mitigations. These workarounds are implemented throughout
> + * this driver. This section documents the known issues and their corresponding
> + * mitigation strategies.

Is there a public errata you can reference?

> + *
> + * 1. Unreliable Link Detection and Synchronized Reset Deadlock
> + * ------------------------------------------------------------
> + * After a link loss or during link establishment, the DP83TG720 PHY may fail
> + * to detect or report link status correctly. To work around this, the PHY must
> + * be reset periodically when no link is detected.
> + *
> + * However, in point-to-point setups where both link partners use the same
> + * driver (e.g. Linux on both sides), a synchronized reset pattern may emerge.
> + * This leads to a deadlock, where both PHYs reset at the same time and
> + * continuously miss each other during auto-negotiation.
> + *
> + * To address this, the reset procedure includes two components:
> + *
> + * - A **fixed minimum delay of 1ms** after issuing a hardware reset, as
> + *   required by the "DP83TG720S-Q1 1000BASE-T1 Automotive Ethernet PHY with
> + *   SGMII and RGMII" datasheet. This ensures MDC access timing is respected
> + *   before any further MDIO operations.
> + *
> + * - An **additional asymmetric delay**, empirically chosen based on
> + *   master/slave role. This reduces the risk of synchronized resets on both
> + *   link partners. Values are selected to avoid periodic overlap and ensure
> + *   the link is re-established within a few cycles.

Maybe there is more about this in the following patches, i've not read
them yet. Does autoneg get as far as determining master/slave role? Or
are you assuming the link partners are somehow set as
prefer_master/prefer_slave?

	Andrew

