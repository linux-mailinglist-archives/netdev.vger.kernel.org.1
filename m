Return-Path: <netdev+bounces-212178-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD20EB1E95E
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 15:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0A0A188E42F
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 13:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F1527C162;
	Fri,  8 Aug 2025 13:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JbG6UqZ/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0951727BF6F;
	Fri,  8 Aug 2025 13:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754660346; cv=none; b=e+tHG63BhTrGrwU9M4KnUf/51Y5yJweySaUgs/ZS6rSYny5VewrymJw3dTbkURJtD4XLxgWzlqU5zi7d+cyK62KIb8kPKF5QGnCeOMK7ZDlDEo61I96jJQLvvXTfi4YzCztKRJMMSxI9bV27q5bFqDOizVpfd+7+mjZlR5Wz0vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754660346; c=relaxed/simple;
	bh=O8M84x0IipqdrdHYVv72YHHJENEIRaUQIZ2uMc5u99g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FHTfEqXocAEbbLq5A4AOMNmb/Xp/Mz2GInEjLwLycSwctv6pOlXDhHWhz/LvR5kUelaMuorCxzFf9F8gAxpvAxgr8QqUl+DZP6up0vcluE6QK5TtCzZKa9Ft24fgd7b+8EDY1Lv/KrvTBNmMm+ChJV3V2ByAdWqojL6EjRoKEvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JbG6UqZ/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF1FBC4CEED;
	Fri,  8 Aug 2025 13:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754660345;
	bh=O8M84x0IipqdrdHYVv72YHHJENEIRaUQIZ2uMc5u99g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JbG6UqZ/S0zddlUUGNsZ1LW2vuFaUZjaj1rL/Y+l6YznEaocmSIc2kJnU2E+c1yva
	 Lpeh2fn4V45OtjUoq9klWu0btN9KL9+mopyNOJDiFok1Nc/zuJZS9wnJZMC7icpo/e
	 Hp2B7PvXd3K5GARORPZT6Jq3n8AMGx0ZJVM2d/4cL1LoyR4D3OhsZEkjT4Ec6/233W
	 NHanv1pISitDUIR/YtwT8pVBlfOCuOmlK7vjamZA5OSlaPkOcxaiJwR/894+2F90CO
	 MYvlzlx9OAe2/YOKX7O8nDH9p7oYnZOiLnE/EsqkHgqtTuvOr3cCxSXePWqpGgw5fa
	 LXZjYbg6HJscQ==
Date: Fri, 8 Aug 2025 14:39:00 +0100
From: Simon Horman <horms@kernel.org>
To: Yao Zi <ziyao@disroot.org>
Cc: Drew Fustini <fustini@kernel.org>, Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Jisheng Zhang <jszhang@kernel.org>, nux-riscv@lists.infradead.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: stmmac: thead: Enable TX clock before MAC
 initialization
Message-ID: <20250808133900.GD1705@horms.kernel.org>
References: <20250808103447.63146-2-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250808103447.63146-2-ziyao@disroot.org>

On Fri, Aug 08, 2025 at 10:34:48AM +0000, Yao Zi wrote:

...

> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c
> index f2946bea0bc2..50c1920bde6a 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c
> @@ -152,7 +152,7 @@ static int thead_set_clk_tx_rate(void *bsp_priv, struct clk *clk_tx_i,
>  static int thead_dwmac_enable_clk(struct plat_stmmacenet_data *plat)
>  {
>  	struct thead_dwmac *dwmac = plat->bsp_priv;
> -	u32 reg;
> +	u32 reg, div;
>  
>  	switch (plat->mac_interface) {
>  	case PHY_INTERFACE_MODE_MII:
> @@ -164,6 +164,13 @@ static int thead_dwmac_enable_clk(struct plat_stmmacenet_data *plat)
>  	case PHY_INTERFACE_MODE_RGMII_RXID:
>  	case PHY_INTERFACE_MODE_RGMII_TXID:
>  		/* use pll */
> +		div = clk_get_rate(plat->stmmac_clk) / rgmii_clock(SPEED_1000);
> +		reg = FIELD_PREP(GMAC_PLLCLK_DIV_EN, 1) |
> +		      FIELD_PREP(GMAC_PLLCLK_DIV_NUM, div),

Sorry for not noticing this before sending my previous email.

Although the code above is correct. I think it would be clearer
to use ';' rather than ',' at the end of the line above. Perhaps ','
is a typo.(',' is next to ';' on my keyboard at least).

Flagged by Clang 20.1.8 with -Wcomma

> +
> +		writel(0, dwmac->apb_base + GMAC_PLLCLK_DIV);
> +		writel(reg, dwmac->apb_base + GMAC_PLLCLK_DIV);
> +
>  		writel(GMAC_GTXCLK_SEL_PLL, dwmac->apb_base + GMAC_GTXCLK_SEL);
>  		reg = GMAC_TX_CLK_EN | GMAC_TX_CLK_N_EN | GMAC_TX_CLK_OUT_EN |
>  		      GMAC_RX_CLK_EN | GMAC_RX_CLK_N_EN;

-- 
pw-bot: changes-requested.

