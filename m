Return-Path: <netdev+bounces-209403-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7889B0F813
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 18:26:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE5A43A39AA
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 16:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D42C1EB5DD;
	Wed, 23 Jul 2025 16:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N9kJJIZb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFFC45009;
	Wed, 23 Jul 2025 16:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753288013; cv=none; b=ffi/2GPuCKSFoKnp3nF0OolxReZWEAfJlUsv+fFepfGsvUYsrEF4DP8Nqu7HxYSr/nddHdrArWay/qhqco3I3ibPkteH3aPFzkf4ezQdWqXT6IvtBhF2KT2nut14Fbsjk7SODGTafDGRsCYdMzmY4xAXppLlzcZrRZIRD8FNAXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753288013; c=relaxed/simple;
	bh=n3qXmtc19QU3ZmV4nZYz1SVUQ1cC1I+DIwzc4nirjyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mrPrDe+I21VOYQHjJLjRqiPHmU32wMxFtcVS3M3ivaVF4fee2Cma5TxyHYUjA0sGri9Xj4X6p9cZWc2rJ16ywbw7HJCAPVfGfqVkXqvxrFSDoeKCFaYydHLgJsODUGzUx1Nv8Y0QLv+DL5pDyj8d7WY8PmV2EF8RrWKKVc8C06U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N9kJJIZb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01150C4CEF1;
	Wed, 23 Jul 2025 16:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753288013;
	bh=n3qXmtc19QU3ZmV4nZYz1SVUQ1cC1I+DIwzc4nirjyg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=N9kJJIZbQJf6P9svGPJUD275iN2bEHWtom3WIIIQ7r4NHUvucLRzaFmcwM6DYXy/w
	 eP8JMAD3toXG9dTz2WF6xlKU3KMM+rLmwOOw0NBmvEpBRJd6FZA5gXCq7mqYy+yd+V
	 Z4x2uIW8DtG81v6WT9T8Uq85ff17hwtnI8CEtXn08YNtbV+NKarkzKOKjmTSYwCJQG
	 Y183CBkHkZJmYJs72lK2Z/+DPX5LYt80yXPnETvNvaUNcjGjU2hAxbnvUbZcAphNI2
	 k54Flizmov93mPe9r05TdbaIT9tVHzoplWF46nbNuOY89i4QqAzqq12nbkkUUZhPsA
	 jJ4LgoDcEcSCg==
Date: Wed, 23 Jul 2025 17:26:47 +0100
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
Subject: Re: [PATCH net-next v5 3/6] net: dsa: microchip: Use different
 registers for KSZ8463
Message-ID: <20250723162647.GK1036606@horms.kernel.org>
References: <20250723022612.38535-1-Tristram.Ha@microchip.com>
 <20250723022612.38535-4-Tristram.Ha@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250723022612.38535-4-Tristram.Ha@microchip.com>

On Tue, Jul 22, 2025 at 07:26:09PM -0700, Tristram.Ha@microchip.com wrote:
> From: Tristram Ha <tristram.ha@microchip.com>
> 
> KSZ8463 does not use same set of registers as KSZ8863 so it is necessary
> to change some registers when using KSZ8463.
> 
> Signed-off-by: Tristram Ha <tristram.ha@microchip.com>

...

> diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c

...

> @@ -2980,10 +2981,14 @@ static int ksz_setup(struct dsa_switch *ds)
>  	}
>  
>  	/* set broadcast storm protection 10% rate */
> +	storm_mask = BROADCAST_STORM_RATE;
> +	storm_rate = (BROADCAST_STORM_VALUE * BROADCAST_STORM_PROT_RATE) / 100;
> +	if (ksz_is_ksz8463(dev)) {
> +		storm_mask = swab16(storm_mask);
> +		storm_rate = swab16(storm_rate);
> +	}

I'm sorry to be difficult, but I think the topic of using
swab16(), which I raised in reviewing the previous version of this
patchset, is still open.

https://lore.kernel.org/netdev/20250723162158.GJ1036606@horms.kernel.org/

...

