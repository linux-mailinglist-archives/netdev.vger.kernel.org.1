Return-Path: <netdev+bounces-133667-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C9D996A13
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 14:32:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0DFA287690
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 12:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A771194082;
	Wed,  9 Oct 2024 12:32:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F57192B95;
	Wed,  9 Oct 2024 12:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728477160; cv=none; b=q0s9R23GZoWBCUFwn3iwrBnXsWm1mncDRU7qRY2uQOO5W/p2C45HBeqfP73NUgxlR0GYcbsijEiZkoCr2hpbMLY+Tr9QDi0ksMwSs59BH7X2tGSM4LQsEmtzr5Io/vfPJ5x6/ggAXLSFb9+3QIkWz06uvx2Y47MrD896eOVpVRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728477160; c=relaxed/simple;
	bh=JxPeNyGf6R6l8PYvNsvYdX2dUSjUcmnQS7P8Nbd7M4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iqs5B0TRsXiwOwmvJ5pixn7NDqHkTpScmw5nqzEcxyLWAz+8thTW62vAXrRKZEi1zLlIgGXsTcSb765Hep98MRN+Xl6+aMACY9/qRtkxJ4HH5GJQpPRo2Z0vd1/2WuOUynPV5drYyCbu9PYomXcE1CNugcWozgv2u3Q3SWF8nAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98)
	(envelope-from <daniel@makrotopia.org>)
	id 1syVrd-000000006Mn-1FZa;
	Wed, 09 Oct 2024 12:32:25 +0000
Date: Wed, 9 Oct 2024 13:32:20 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: intel-xway: add support for PHY LEDs
Message-ID: <ZwZ31IkwY-bum7T0@makrotopia.org>
References: <c1358e27e3fea346600369bb5d9195e6ccfbcf50.1728440758.git.daniel@makrotopia.org>
 <bc9e4e95-8896-4087-8649-0d8ec6e2cb69@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc9e4e95-8896-4087-8649-0d8ec6e2cb69@lunn.ch>

On Wed, Oct 09, 2024 at 02:16:29PM +0200, Andrew Lunn wrote:
> > +static int xway_gphy_led_polarity_set(struct phy_device *phydev, int index,
> > +				      unsigned long modes)
> > +{
> > +	bool active_low = false;
> > +	u32 mode;
> > +
> > +	if (index >= XWAY_GPHY_MAX_LEDS)
> > +		return -EINVAL;
> > +
> > +	for_each_set_bit(mode, &modes, __PHY_LED_MODES_NUM) {
> > +		switch (mode) {
> > +		case PHY_LED_ACTIVE_LOW:
> > +			active_low = true;
> > +			break;
> > +		case PHY_LED_ACTIVE_HIGH:
> > +			break;
> > +		default:
> > +			return -EINVAL;
> > +		}
> > +	}
> > +
> > +	return phy_modify(phydev, XWAY_MDIO_LED, XWAY_GPHY_LED_INV(index),
> > +			  active_low ? XWAY_GPHY_LED_INV(index) : 0);
> 
> This does not appear to implement the 'leave it alone' option.

The framework already implements that. The function is never called with
modes == 0.
See commit 7ae215ee7bb8 net: phy: add support for PHY LEDs polarity modes:

       if (of_property_read_bool(led, "active-low"))
               set_bit(PHY_LED_ACTIVE_LOW, &modes);
       if (of_property_read_bool(led, "inactive-high-impedance"))
               set_bit(PHY_LED_INACTIVE_HIGH_IMPEDANCE, &modes);

       if (modes) {
               /* Return error if asked to set polarity modes but not supported */
               if (!phydev->drv->led_polarity_set)
                       return -EINVAL;

               err = phydev->drv->led_polarity_set(phydev, index, modes);
               if (err)
                       return err;
       }

So in case none of the LED polarity properties are set in DT, modes is 0
and hence led_polarity_set() isn't called.

I considered to change that with my suggested patch
https://patchwork.kernel.org/project/netdevbpf/patch/473d62f268f2a317fd81d0f38f15d2f2f98e2451.1728056697.git.daniel@makrotopia.org/

But it was rightously critizised for breaking existing DT which assume
LED polarity not being touched if none of the polarity properties are
present.

