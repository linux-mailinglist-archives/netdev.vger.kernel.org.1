Return-Path: <netdev+bounces-170789-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EFAEA49E62
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 17:10:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14F3D1894120
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 16:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD7D26B2C8;
	Fri, 28 Feb 2025 16:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="rBUHJGiu"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEEE721348;
	Fri, 28 Feb 2025 16:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740759046; cv=none; b=aygnFBViICqug1DbzikxrwSpYfpaLYcRTINQngn+dz6l05tqtepwH+vUyD40C7Wwc38WEygI+KP9dfpSR7HuTCch44nOvHaWSfJHQrpfIEzPvxMW//tJFhOHg9BF3FUQlyduXphjsKOKGh5+AQ3SYf937yma+NE90IBtqwi2uWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740759046; c=relaxed/simple;
	bh=8PLafN6etX4EKDUrAGl0nexldt+z6MyMne2bUMjDBFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q+mcy8MzTjcB2Nqam9yx8JCF0hygzUePGH90EFUqqDesCJBNY+sIb1OaPuRnrSiEluddmgSRIBbjnnLMWIv0zONIEUxgdkyIF1a0FCOKmmhhPRbtxmFd0cx+D31oJKsHuuvpP/xxQ9gTRCUrbYrko+AnHwPWYWvyL9zLd7xoecs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=rBUHJGiu; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=RL723Y7hLYwPD198BwDwCvbD/mzXQSgdofBbpBJZHqk=; b=rBUHJGiukrb/hfmv5YCA9S0af/
	KoxQPnagMLWPY21lJxvN3zgqTeJbkE8JOly0G96VjLvXwE1RauLeqUq5KVsa4ZN+vQONOPH3WNGpM
	y3zh28l1YQq7xbJJsRLx9cqiOSGBIThDDwZ0XMb0jBuWmqDp+OgBxXBtgYl2Ghd3HtUba+Z7o20rQ
	TJQW6fvwzOWS//X1fnGccnkadSta9XX++URMrosBa77CdR9GNrAN1/riNyMuqPnjkbwTLQ4p/HWd+
	ORAeGipgXsidMHUGbxHlJcsZNd76utqXf9dz64zfLRJLHPQT/oJoxb0/OqF1AfQQTQI0e7CkdyD35
	PrZiyZ0w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:54966)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1to2wf-0002Ly-14;
	Fri, 28 Feb 2025 16:10:37 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1to2wd-0000si-0U;
	Fri, 28 Feb 2025 16:10:35 +0000
Date: Fri, 28 Feb 2025 16:10:35 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
	linux-arm-kernel@lists.infradead.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	=?iso-8859-1?Q?K=F6ry?= Maincent <kory.maincent@bootlin.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Simon Horman <horms@kernel.org>,
	Romain Gantois <romain.gantois@bootlin.com>
Subject: Re: [PATCH net-next v3 03/13] net: phy: phy_caps: Move phy_speeds to
 phy_caps
Message-ID: <Z8Hf-9yR3qD9cqsX@shell.armlinux.org.uk>
References: <20250228145540.2209551-1-maxime.chevallier@bootlin.com>
 <20250228145540.2209551-4-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228145540.2209551-4-maxime.chevallier@bootlin.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Feb 28, 2025 at 03:55:28PM +0100, Maxime Chevallier wrote:
> Use the newly introduced link_capabilities array to derive the list of
> possible speeds when given a combination of linkmodes. As
> link_capabilities is indexed by speed, we don't have to iterate the
> whole phy_settings array.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> ---
>  drivers/net/phy/phy-caps.h |  3 +++
>  drivers/net/phy/phy-core.c | 15 ---------------
>  drivers/net/phy/phy.c      |  3 ++-
>  drivers/net/phy/phy_caps.c | 27 +++++++++++++++++++++++++++
>  include/linux/phy.h        |  2 --
>  5 files changed, 32 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/net/phy/phy-caps.h b/drivers/net/phy/phy-caps.h
> index 846d483269f6..f8cdfdb09242 100644
> --- a/drivers/net/phy/phy-caps.h
> +++ b/drivers/net/phy/phy-caps.h
> @@ -41,4 +41,7 @@ struct link_capabilities {
>  
>  void phy_caps_init(void);
>  
> +size_t phy_caps_speeds(unsigned int *speeds, size_t size,
> +		       unsigned long *linkmodes);
> +
>  #endif /* __PHY_CAPS_H */
> diff --git a/drivers/net/phy/phy-core.c b/drivers/net/phy/phy-core.c
> index b1c1670de23b..8533e57c3500 100644
> --- a/drivers/net/phy/phy-core.c
> +++ b/drivers/net/phy/phy-core.c
> @@ -339,21 +339,6 @@ phy_lookup_setting(int speed, int duplex, const unsigned long *mask, bool exact)
>  }
>  EXPORT_SYMBOL_GPL(phy_lookup_setting);
>  
> -size_t phy_speeds(unsigned int *speeds, size_t size,
> -		  unsigned long *mask)
> -{
> -	size_t count;
> -	int i;
> -
> -	for (i = 0, count = 0; i < ARRAY_SIZE(settings) && count < size; i++)
> -		if (settings[i].bit < __ETHTOOL_LINK_MODE_MASK_NBITS &&
> -		    test_bit(settings[i].bit, mask) &&
> -		    (count == 0 || speeds[count - 1] != settings[i].speed))
> -			speeds[count++] = settings[i].speed;
> -
> -	return count;
> -}
> -
>  static void __set_linkmode_max_speed(u32 max_speed, unsigned long *addr)
>  {
>  	const struct phy_setting *p;
> diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
> index 16ffc00b419c..3128df03feda 100644
> --- a/drivers/net/phy/phy.c
> +++ b/drivers/net/phy/phy.c
> @@ -37,6 +37,7 @@
>  #include <net/sock.h>
>  
>  #include "phylib-internal.h"
> +#include "phy-caps.h"
>  
>  #define PHY_STATE_TIME	HZ
>  
> @@ -245,7 +246,7 @@ unsigned int phy_supported_speeds(struct phy_device *phy,
>  				  unsigned int *speeds,
>  				  unsigned int size)
>  {
> -	return phy_speeds(speeds, size, phy->supported);
> +	return phy_caps_speeds(speeds, size, phy->supported);
>  }
>  
>  /**
> diff --git a/drivers/net/phy/phy_caps.c b/drivers/net/phy/phy_caps.c
> index 367ca7110ddc..e5c716365b36 100644
> --- a/drivers/net/phy/phy_caps.c
> +++ b/drivers/net/phy/phy_caps.c
> @@ -76,3 +76,30 @@ void phy_caps_init(void)
>  		__set_bit(i, link_caps[capa].linkmodes);
>  	}
>  }
> +
> +/**
> + * phy_caps_speeds() - Fill an array of supported SPEED_* values for given modes
> + * @speeds: Output array to store the speeds list into
> + * @size: Size of the output array
> + * @linkmodes: Linkmodes to get the speeds from
> + *
> + * Fills the speeds array with all possible speeds that can be achieved with
> + * the specified linkmodes.
> + *
> + * Returns: The number of speeds filled into the array. If the input array isn't
> + *	    big enough to store all speeds, fill it as much as possible.
> + */
> +size_t phy_caps_speeds(unsigned int *speeds, size_t size,
> +		       unsigned long *linkmodes)
> +{
> +	size_t count;
> +	int capa;
> +
> +	for (capa = 0, count = 0; capa < __LINK_CAPA_MAX && count < size; capa++) {
> +		if (linkmode_intersects(link_caps[capa].linkmodes, linkmodes) &&
> +		    (count == 0 || speeds[count - 1] != link_caps[capa].speed))
> +			speeds[count++] = link_caps[capa].speed;
> +	}

Having looked at several of these patches, there's a common pattern
emerging, which is we're walking over link_caps in either ascending
speed order or descending speed order. So I wonder whether it would
make sense to have:

#define for_each_link_caps_asc_speed(cap) \
	for (cap = link_caps; cap < &link_caps[__LINK_CAPA_MAX]; cap++)
#define for_each_link_caps_desc_speed(cap) \
	for (cap = &link_caps[__LINK_CAPA_MAX - 1]; cap >= link_caps; cap--)

for where iterating over in speed order is important. E.g. this would
make the above:

	struct link_capabilities *lcap;

	for_each_link_caps_asc_speed(lcap)
		if (linkmode_intersects(lcap->linkmodes, linkmodes) &&
		    (count == 0 || speeds[count - 1] != lcap->speed)) {
			speeds[count++] = lcap->speed;
			if (count >= size)
				break;
		}

which helps to make it explicit that speeds[] is in ascending value
order.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

