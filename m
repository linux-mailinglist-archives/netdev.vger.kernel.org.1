Return-Path: <netdev+bounces-208401-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F39FB0B4D9
	for <lists+netdev@lfdr.de>; Sun, 20 Jul 2025 12:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAE141899CD9
	for <lists+netdev@lfdr.de>; Sun, 20 Jul 2025 10:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E07451DE3C0;
	Sun, 20 Jul 2025 10:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C49xHYPw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CFE3BB48;
	Sun, 20 Jul 2025 10:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753006629; cv=none; b=jdha/0Z2jeGschrjQE5RXzBBidYM+JF/1Kg06T6ceZ5Qf6qM4bUOR3pUB9yCFvR/PBj9ze6RvcUTCE3z94H4brKYBh2AEZIkjngqVv2uzqe/rTVMZtwlerdK7PzI9seVSfzON3JdR3Uo3HxcjJyfjxSsU/SEAEOzPDQyPVUSRDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753006629; c=relaxed/simple;
	bh=qSu/fVLvTpTjNXmoaaXZmuvU+HNTptap35jxCNKV8JM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JB7ufY2r+oqFh3LdtBQ5P+DUEHP/8vDnZ++J4768vWEPCTwWcD6RtMRA5s9QNQQF2pU7WbMlmr13EfXyBtRh1IBEsq++M7rBcesBy/V/Y/aiLwl27jiLtKy3OhC/9piPLiaS9RjIZsqL/qgMCVrxJqnLl4TON07t/8n0GczyOOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C49xHYPw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A2E6C4CEF6;
	Sun, 20 Jul 2025 10:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753006629;
	bh=qSu/fVLvTpTjNXmoaaXZmuvU+HNTptap35jxCNKV8JM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C49xHYPw8EcrXNvn5NbHoP17B/RrVTBcOYSgsNvuP54YYe7xEnruCpHX2biLUK/1l
	 euNoozdlYwKNM6WgrseLWzO/OKxjBfJ44uAGn9YiM3XhoC8Ks4cMX9VVFZDD7M36rI
	 gBFm0IX0PVnTn2X45+ZxZuz0q8JdLRCTn6zIcj7qYib1c+Pu8iAH0mBiZVYB6wtnXq
	 Cr79spYmxltgHdnw5Bt6VO/xIvifUq85vbnbEkt94iDiOvXkBeT3NAGA/vaN7CTAnO
	 tngSL9XJrg2cpznS0WhyNYVoLRBIhPSaCm1zhsNObyIp2PAsFg/ktclJRacn3qyS5Z
	 u6xrNzyr8Ubiw==
Date: Sun, 20 Jul 2025 11:17:03 +0100
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
Message-ID: <20250720101703.GQ2459@horms.kernel.org>
References: <20250719012106.257968-1-Tristram.Ha@microchip.com>
 <20250719012106.257968-5-Tristram.Ha@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250719012106.257968-5-Tristram.Ha@microchip.com>

On Fri, Jul 18, 2025 at 06:21:03PM -0700, Tristram.Ha@microchip.com wrote:
> From: Tristram Ha <tristram.ha@microchip.com>
> 
> KSZ8463 does not use same set of registers as KSZ8863 so it is necessary
> to change some registers when using KSZ8463.
> 
> Signed-off-by: Tristram Ha <tristram.ha@microchip.com>
> ---
> v3
> - Replace cpu_to_be16() with swab16() to avoid compiler warning

...

> diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c

...

> @@ -2980,10 +2981,15 @@ static int ksz_setup(struct dsa_switch *ds)
>  	}
>  
>  	/* set broadcast storm protection 10% rate */
> -	regmap_update_bits(ksz_regmap_16(dev), regs[S_BROADCAST_CTRL],
> -			   BROADCAST_STORM_RATE,
> -			   (BROADCAST_STORM_VALUE *
> -			   BROADCAST_STORM_PROT_RATE) / 100);
> +	storm_mask = BROADCAST_STORM_RATE;
> +	storm_rate = (BROADCAST_STORM_VALUE * BROADCAST_STORM_PROT_RATE) / 100;
> +	if (ksz_is_ksz8463(dev)) {
> +		storm_mask = swab16(storm_mask);
> +		storm_rate = swab16(storm_rate);
> +	}
> +	regmap_update_bits(ksz_regmap_16(dev),
> +			   reg16(dev, regs[S_BROADCAST_CTRL]),
> +			   storm_mask, storm_rate);

Hi Tristram,

I am confused by the use of swab16() here.

Let us say that we are running on a little endian host (likely).
Then the effect of this is to pass big endian values to regmap_update_bits().

But if we are running on a big endian host, the opposite will be true:
little endian values will be passed to regmap_update_bits().


Looking at KSZ_REGMAP_ENTRY() I see:

#define KSZ_REGMAP_ENTRY(width, swp, regbits, regpad, regalign)         \
        {                                                               \
		...
                .reg_format_endian = REGMAP_ENDIAN_BIG,                 \
                .val_format_endian = REGMAP_ENDIAN_BIG                  \
        }

Which based on a skimming the regmap code implies to me that
regmap_update_bits() should be passed host byte order values
which regmap will convert to big endian when writing out
these values.

It is unclear to me why changing the byte order of storm_mask
and storm_rate is needed here. But it does seem clear that
it will lead to inconsistent results on big endian and little
endian hosts.

...

