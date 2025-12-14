Return-Path: <netdev+bounces-244651-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B291CBC133
	for <lists+netdev@lfdr.de>; Sun, 14 Dec 2025 23:31:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9A97230021ED
	for <lists+netdev@lfdr.de>; Sun, 14 Dec 2025 22:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0840D314A62;
	Sun, 14 Dec 2025 22:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="2rEh/LIV"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928C9221F39;
	Sun, 14 Dec 2025 22:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765751479; cv=none; b=jSDAQNilMdSnIKIQbPmkhbhdcAiOkraoY8yZBweAvZudnXWr8a/BCA/DKzb2OjH3hqarUpsMxbGxbsaJJIuyGx+WR6+obnhq67O4Bbjhm+ZRzix0xqqEPD1swKaSyRM3d1yQb/yShSDAKg4Lny7laU9IoYmO8lCYHz5jsJHGJ/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765751479; c=relaxed/simple;
	bh=n/dhjzhd/Pp2IXEKArQf3Uz07bOuxKVxtYSTm0xXQKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tmrPDWw8BZQ0P5gKEujmpJ5OqHqJ9Y3IzSbVBWlPQXdx2DNV9OB2e2q3DQRBEnFcnw+BtzI83kjRb0Qe9eCd4vB8tQeTwGuxYxErXQGdU2TCFHNZZrR8O6+RZNibVQ2fzRP0kWawDZz9RQ6g7gc5XHwxpmpnsCL9Mi0BXbfO2rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=2rEh/LIV; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=z6fXs+IIbDChxuFtTKIP2sLb6jR6q7HS1FdEpkJpi6g=; b=2rEh/LIVp8lLB0Cmg0619HT3ME
	YLLfXMm8HuA25MtApqKFp1X85UfJ7fAykF9Eyig4AJuNW1FgFBmoV9/q7aiok7X3EQ1bVhljtMylJ
	ujYx/7ZUEo/Hz6Dzeq42dceYvih8RtSxHWeGZrY4yWA4IhDxUHx3yvbRglCvtmXq0r24=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vUubz-00GwZz-Sv; Sun, 14 Dec 2025 23:30:43 +0100
Date: Sun, 14 Dec 2025 23:30:43 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: jan.petrous@oss.nxp.com
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Chester Lin <chester62515@gmail.com>,
	Matthias Brugger <mbrugger@suse.com>,
	Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>,
	NXP S32 Linux Team <s32@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, devicetree@vger.kernel.org
Subject: Re: [PATCH RFC 1/4] net: stmmac: platform: read channels irq
Message-ID: <b9c8580f-e615-4eaa-8878-2fb8d888c0aa@lunn.ch>
References: <20251214-dwmac_multi_irq-v1-0-36562ab0e9f7@oss.nxp.com>
 <20251214-dwmac_multi_irq-v1-1-36562ab0e9f7@oss.nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251214-dwmac_multi_irq-v1-1-36562ab0e9f7@oss.nxp.com>

On Sun, Dec 14, 2025 at 11:15:37PM +0100, Jan Petrous via B4 Relay wrote:
> From: "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>
> 
> Read IRQ resources for all channels, to allow multi IRQ mode
> for platform glue drivers.
> 
> Signed-off-by: Jan Petrous (OSS) <jan.petrous@oss.nxp.com>
> ---
>  .../net/ethernet/stmicro/stmmac/stmmac_platform.c  | 38 +++++++++++++++++++++-
>  1 file changed, 37 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> index 8979a50b5507..29e40253bdfe 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> @@ -700,6 +700,9 @@ EXPORT_SYMBOL_GPL(stmmac_pltfr_find_clk);
>  int stmmac_get_platform_resources(struct platform_device *pdev,
>  				  struct stmmac_resources *stmmac_res)
>  {
> +	int i;
> +	char name[8];

Reverse Christmas tree please.

>  	memset(stmmac_res, 0, sizeof(*stmmac_res));
>  
>  	/* Get IRQ information early to have an ability to ask for deferred
> @@ -743,7 +746,40 @@ int stmmac_get_platform_resources(struct platform_device *pdev,
>  
>  	stmmac_res->addr = devm_platform_ioremap_resource(pdev, 0);
>  
> -	return PTR_ERR_OR_ZERO(stmmac_res->addr);
> +	if (IS_ERR(stmmac_res->addr))
> +		return PTR_ERR(stmmac_res->addr);
> +
> +	/* RX channels irq */
> +	for (i = 0; i < MTL_MAX_RX_QUEUES; i++) {
> +		scnprintf(name, 8, "rx-queue-%d", i);

It would be better to use sizeof(name), not 8.

Also, 'rx-queue-' is 9 characters. So i don't see how this can
actually work?

	Andrew

