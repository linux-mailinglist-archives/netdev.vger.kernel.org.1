Return-Path: <netdev+bounces-208402-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF56B0B4DB
	for <lists+netdev@lfdr.de>; Sun, 20 Jul 2025 12:22:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FF75189AA14
	for <lists+netdev@lfdr.de>; Sun, 20 Jul 2025 10:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AAE41EBA1E;
	Sun, 20 Jul 2025 10:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C12HnY2i"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6C63BB48;
	Sun, 20 Jul 2025 10:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753006950; cv=none; b=odDIznccWPIPoV4yTVkwIHEdWVkWgxYgAReFho0x7VqHjS0ZSM7pUf0YveL+aX8uVmVYWYGmpU2qaf768r3ciQ7bKPaFGDRgV78KPOx7CVWJxyyo9DjJBy1p/o0KPvz/R2opYNWN9wyBlCWSdHubTDCyvAFLjlG/m7U8S5fCyvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753006950; c=relaxed/simple;
	bh=0saEE2WiHsrf+WK5Q2dZ+kT/QmQXZYOT9kTATCjBH48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bATh6PX1Nb0iTs8v6v3zPfZ2mK3Dcut5AZe8KKo4pJkmwM28haeBZRL93sr0k34kb///DtliDX+kCwB0hMpDXKOGSkIa1mLL43gXjtfrlBOtsz8QquW7wbdu0P9tXxqQiGZMdEVXCDZ8nQhzNsw5fUFHUIlmuyX3sqQFTypKfX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C12HnY2i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 179E9C4CEE7;
	Sun, 20 Jul 2025 10:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753006950;
	bh=0saEE2WiHsrf+WK5Q2dZ+kT/QmQXZYOT9kTATCjBH48=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C12HnY2iVc8Pzy2vfJ9ySb2VSvAQUTbvEf8t8i9NEVAEBM8dwDHN65/24bu1UKpwp
	 w86aNq7B7rO3Z3EFcnJIQ9rKf4thStQz7/sqPNlxUevarPotJ46kLL5JrM2U8ikA0X
	 wp1DJzN8TN27DmijZQ2yiovJkDySM+vC3X+xvBa7W/60yfnqfKABPeF1NM+7xjcb6d
	 WrTEvcrzysMT8qubX9zAFGhr7zz4hpp3iF8cQOzEkX5f4PPnskc8Aae8qYDAHT/5rp
	 D8CItgHEk4YlleUwyzm/GjG4YxXEQ7PoN/ulsnQgfl4niFgY4BHCHKRBACauGMKoKm
	 ZsLSn3g5K6ViQ==
Date: Sun, 20 Jul 2025 11:22:24 +0100
From: Simon Horman <horms@kernel.org>
To: Tristram.Ha@microchip.com
Cc: Woojung Huh <woojung.huh@microchip.com>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Marek Vasut <marex@denx.de>, UNGLinuxDriver@microchip.com,
	devicetree@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 4/7] net: dsa: microchip: Use different
 registers for KSZ8463
Message-ID: <20250720102224.GR2459@horms.kernel.org>
References: <20250719012106.257968-1-Tristram.Ha@microchip.com>
 <20250719012106.257968-5-Tristram.Ha@microchip.com>
 <20250720101703.GQ2459@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250720101703.GQ2459@horms.kernel.org>

On Sun, Jul 20, 2025 at 11:17:03AM +0100, Simon Horman wrote:
> On Fri, Jul 18, 2025 at 06:21:03PM -0700, Tristram.Ha@microchip.com wrote:
> > From: Tristram Ha <tristram.ha@microchip.com>
> > 
> > KSZ8463 does not use same set of registers as KSZ8863 so it is necessary
> > to change some registers when using KSZ8463.
> > 
> > Signed-off-by: Tristram Ha <tristram.ha@microchip.com>
> > ---
> > v3
> > - Replace cpu_to_be16() with swab16() to avoid compiler warning
> 
> ...
> 
> > diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
> 
> ...
> 
> > @@ -2980,10 +2981,15 @@ static int ksz_setup(struct dsa_switch *ds)
> >  	}
> >  
> >  	/* set broadcast storm protection 10% rate */
> > -	regmap_update_bits(ksz_regmap_16(dev), regs[S_BROADCAST_CTRL],
> > -			   BROADCAST_STORM_RATE,
> > -			   (BROADCAST_STORM_VALUE *
> > -			   BROADCAST_STORM_PROT_RATE) / 100);
> > +	storm_mask = BROADCAST_STORM_RATE;
> > +	storm_rate = (BROADCAST_STORM_VALUE * BROADCAST_STORM_PROT_RATE) / 100;
> > +	if (ksz_is_ksz8463(dev)) {
> > +		storm_mask = swab16(storm_mask);
> > +		storm_rate = swab16(storm_rate);
> > +	}
> > +	regmap_update_bits(ksz_regmap_16(dev),
> > +			   reg16(dev, regs[S_BROADCAST_CTRL]),
> > +			   storm_mask, storm_rate);
> 
> Hi Tristram,
> 
> I am confused by the use of swab16() here.
> 
> Let us say that we are running on a little endian host (likely).
> Then the effect of this is to pass big endian values to regmap_update_bits().
> 
> But if we are running on a big endian host, the opposite will be true:
> little endian values will be passed to regmap_update_bits().
> 
> 
> Looking at KSZ_REGMAP_ENTRY() I see:
> 
> #define KSZ_REGMAP_ENTRY(width, swp, regbits, regpad, regalign)         \
>         {                                                               \
> 		...
>                 .reg_format_endian = REGMAP_ENDIAN_BIG,                 \
>                 .val_format_endian = REGMAP_ENDIAN_BIG                  \
>         }

Update; I now see this in another patch of the series:

+#define KSZ8463_REGMAP_ENTRY(width, swp, regbits, regpad, regalign)    \
+       {                                                               \
		...
+               .reg_format_endian = REGMAP_ENDIAN_BIG,                 \
+               .val_format_endian = REGMAP_ENDIAN_LITTLE               \
+       }

Which I understand to mean that the hardware is expecting little endian
values. But still, my concerns raised in my previous email of this
thread remain.

And I have a question: does this chip use little endian register values
whereas other chips used big endian register values?

> 
> Which based on a skimming the regmap code implies to me that
> regmap_update_bits() should be passed host byte order values
> which regmap will convert to big endian when writing out
> these values.
> 
> It is unclear to me why changing the byte order of storm_mask
> and storm_rate is needed here. But it does seem clear that
> it will lead to inconsistent results on big endian and little
> endian hosts.
> 
> ...
> 

