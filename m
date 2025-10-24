Return-Path: <netdev+bounces-232622-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E533C076C7
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 19:00:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91B601C42E2F
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 17:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 831DF20CCCA;
	Fri, 24 Oct 2025 17:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NuOyzL52"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C4B12B94;
	Fri, 24 Oct 2025 17:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761325236; cv=none; b=h0/tVv4EM6fN4zbmsBHKJ0SGL1rrCDlIySx2xNoWWJpzTYFEJLTdQHLHtClmMDtPYI9tsHqU0REWuoWx/AuFkL9fmZEbix2RhlnEwvzM82XasrQ6e6Qq5Yr8T+tNmst+bw/C6wSHArNGS89/2WLTIb4U+4fXHnR+8aMrQ4aK400=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761325236; c=relaxed/simple;
	bh=P30Amz6t4gClv82kJnXzJCEXNT49i1otAZuXWkHsM8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FHLb4bKvlyfU60DS26R6Cwb/opYIxwKrNtCAYYbag7hmKImRm7u+wJ9EXmzDeL3HH3tAQSqk1yN+xRRU4rSMSeBUs1GERacABP2mCyjFAbJRqZxn/RMugiP1uQF0IA+kRiDSP/qtYWGprv8QVu2w+0zSHEpSWjtciaoCbtMgUFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NuOyzL52; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F798C4CEF1;
	Fri, 24 Oct 2025 17:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761325235;
	bh=P30Amz6t4gClv82kJnXzJCEXNT49i1otAZuXWkHsM8w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NuOyzL52sbbNkLTISaUiZcxVPMMcvE6/aTHVBAKCncbKyPyCpaTJbaelkUrzmIvHW
	 /IQIIQH7hbBF2AjPQD68Pt4oJ7flSwE7WTcAmsTRXwZtluGJBM1hUtep1EscNVEtGw
	 DYRvG672/gLhggR5E6rPmBLHOgHJ0I7vmRWesKniWEjE7PYFofpc114Sqd9bHnYefw
	 YRVO6uihtxFDs4fa/4bV22aIP/BWlz6ieB2svEgOX2KesQ1bU3NzQaHK9ECvbm/oa4
	 SFvLUUzabBni7gjMcjnMStoX+T31dDTY4yTdYVozPoXLDTCriC69BpwkCCFOXhlatN
	 soVUdWoN86OOQ==
Date: Fri, 24 Oct 2025 18:00:30 +0100
From: Simon Horman <horms@kernel.org>
To: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Matthew Gerlach <matthew.gerlach@altera.com>, kernel@pengutronix.de,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	Teoh Ji Sheng <ji.sheng.teoh@intel.com>
Subject: Re: [PATCH v5 02/10] net: stmmac: Use interrupt mode INTM=1 for per
 channel irq
Message-ID: <aPuwrvGOgfBifrmC@horms.kernel.org>
References: <20251024-v6-12-topic-socfpga-agilex5-v5-0-4c4a51159eeb@pengutronix.de>
 <20251024-v6-12-topic-socfpga-agilex5-v5-2-4c4a51159eeb@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024-v6-12-topic-socfpga-agilex5-v5-2-4c4a51159eeb@pengutronix.de>

On Fri, Oct 24, 2025 at 01:49:54PM +0200, Steffen Trumtrar wrote:

...

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c

...

> @@ -746,6 +750,22 @@ int stmmac_get_platform_resources(struct platform_device *pdev,
>  	if (stmmac_res->irq < 0)
>  		return stmmac_res->irq;
>  
> +	/* For RX Channel */
> +	for (i = 0; i < MTL_MAX_RX_QUEUES; i++) {
> +		sprintf(irq_name, "%s%d", "macirq_rx", i);
> +		stmmac_res->rx_irq[i] = platform_get_irq_byname(pdev, irq_name);
> +		if (stmmac_res->rx_irq[i] < 0)
> +			break;
> +	}
> +
> +	/* For TX Channel */
> +	for (i = 0; i < MTL_MAX_TX_QUEUES; i++) {
> +		sprintf(irq_name, "%s%d", "macirq_tx", i);
> +		stmmac_res->tx_irq[i] = platform_get_irq_byname(pdev, irq_name);
> +			if (stmmac_res->tx_irq[i] < 0)
> +				break;

nit: The two lines above abbove to be indented a bit too much.

> +	}
> +
>  	/* On some platforms e.g. SPEAr the wake up irq differs from the mac irq
>  	 * The external wake up irq can be passed through the platform code
>  	 * named as "eth_wake_irq"

...

