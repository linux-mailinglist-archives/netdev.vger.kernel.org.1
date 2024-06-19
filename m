Return-Path: <netdev+bounces-104886-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A563A90EF88
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 15:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BAD52820E5
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 13:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6103A150996;
	Wed, 19 Jun 2024 13:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R/deu9Vx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359BE2139CD;
	Wed, 19 Jun 2024 13:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718805423; cv=none; b=py8kJOHxhL61N3UqByA0A7vRU+G39SHb6fEIETneu9CAWYd3aK3jevKeTIL1DLCsWBB4iweNHOU9FHN3cZ/LsUpzdS8aTQ4w/cTQYb0GB3gYbZDaAq04AK71mdBVkWWn2m38Y8MhFDvKDWF2RRPOoKzCBC4wpwj+I9z7wGgax2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718805423; c=relaxed/simple;
	bh=TyaQfQKJsGMA8keYr1hp7wYXz2EM065ExSkm3viI+o0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kJIl99bJyJ7pjXDsMkizA783G0gCwd/Kato3RsqjpkRZVdQYopjhba7wlEcYgRFcXrMK3a3ASwZveitzKg9d7hv/lXLdWRf4iFIEDEZS0J0jspENhTlxoWIju93e/JZGFmgV5Srfr1UOodqA5aQay3tMid7vs4AbLtpCcqGqqd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R/deu9Vx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31722C4AF09;
	Wed, 19 Jun 2024 13:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718805423;
	bh=TyaQfQKJsGMA8keYr1hp7wYXz2EM065ExSkm3viI+o0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R/deu9VxpmCRDGd5dFsoRTcU1BnrqE6yXALbINS2b8zmXpVUYfA3YwgZq9EoaSDWR
	 Sdix+N/JuEfjl+pj/iryCgzyKNHeExXb2Gcl72tfy4ykcOPO3rV9STDfdpwNW0LprM
	 mOv4pWKLZOZbEZMgKiSXmDX8Z0bjIL6qzBo7lED7N9fNEVaQEXdj+pqlUHYQj5QNX1
	 I/4sQFs9LPuL9ktiDy8px+KyQDdDjGZaj+yWEvsLUYJRr7gFY4LyujuXG1KnooPZZy
	 j6a7/vvEgYszliFfX3Yzfbj6/NGLRk3UhuGw6hyMh7ipeYdiMLqCtfj0Qps2RBDrzE
	 zhxLBVbgeanAw==
Date: Wed, 19 Jun 2024 14:56:56 +0100
From: Simon Horman <horms@kernel.org>
To: Christophe Roullier <christophe.roullier@foss.st.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, Marek Vasut <marex@denx.de>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next,PATCH v2 2/2] net: stmmac: dwmac-stm32: stm32: add
 management of stm32mp25 for stm32
Message-ID: <20240619135656.GG690967@kernel.org>
References: <20240617154516.277205-1-christophe.roullier@foss.st.com>
 <20240617154516.277205-3-christophe.roullier@foss.st.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617154516.277205-3-christophe.roullier@foss.st.com>

On Mon, Jun 17, 2024 at 05:45:16PM +0200, Christophe Roullier wrote:
> Add Ethernet support for STM32MP25.
> STM32MP25 is STM32 SOC with 2 GMACs instances.
> GMAC IP version is SNPS 5.3x.
> GMAC IP configure with 2 RX and 4 TX queue.
> DMA HW capability register supported
> RX Checksum Offload Engine supported
> TX Checksum insertion supported
> Wake-Up On Lan supported
> TSO supported
> 
> Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>

The nit below notwithstanding, this looks good to me,
and appears to address review of earlier versions.

Reviewed-by: Simon Horman <horms@kernel.org>

> ---
>  .../net/ethernet/stmicro/stmmac/dwmac-stm32.c | 77 ++++++++++++++++++-
>  1 file changed, 74 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c

...

> @@ -365,6 +423,9 @@ static int stm32_dwmac_parse_data(struct stm32_dwmac *dwmac,
>  		return err;
>  	}
>  
> +	if (dwmac->ops->is_mp2)
> +		return err;
> +

nit: As far as I understand things, the intention here is to return early,
     rather than to return an error. And err will always be 0.
     So it might be clearer to simply:

		return 0;

>  	dwmac->mode_mask = SYSCFG_MP1_ETH_MASK;
>  	err = of_property_read_u32_index(np, "st,syscon", 2, &dwmac->mode_mask);
>  	if (err) {

...

