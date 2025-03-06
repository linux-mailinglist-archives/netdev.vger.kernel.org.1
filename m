Return-Path: <netdev+bounces-172619-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9BEA558BC
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 22:26:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00F0F1898EAD
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 21:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313E9207DF4;
	Thu,  6 Mar 2025 21:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="WQFx1oxY"
X-Original-To: netdev@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864CB20469E;
	Thu,  6 Mar 2025 21:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741296411; cv=none; b=G8xc4F2dA3IxqpObn9OAii4JI9tc64Giptyx9LlE7AYwiLdG6lnlk6tmTVoJQ8XqHCC5cdYrp6d5mfQzT2AdBGVYv9kOyhI0R8GobfXHZe3Ux2xNfVRDTe/qqJ6Qzva/XWlCozco10SM4m8Z6T8Mh0PMuiytePwlVlchVCYZJUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741296411; c=relaxed/simple;
	bh=CdwdRiO9iz24Y8hWaQ9+XhtVJb25oR/xbe14/trXsRg=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=fVDemX/18fKUlzyO0xntc7G9VpM/gQrVLBzVEKXcK4wxri1DQjmTgSQpJVUWRehSNo6hf9fDy98CmEXtLBYfzR8qKNTf6PCGliJGS2vsgtGzYZl7rXrC5DFku++IiK4Oqde7AKOq56akdJj6joYaUKsgC0UjnUxt/ktXJ/HHPtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=WQFx1oxY; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1741296406;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0cniJTIAMdIpdeQmR2BhsRWVUgh641WfBYMvCtapTXs=;
	b=WQFx1oxYMJEnrSFTAQ0UbkBpVyh0nQAgIwQEIXxuZrxgDTGBlVo43SGsVKMZ2CuuVaFS4I
	sKegnKlrteJk2c0RFwHqlW1CXBvObg64lnLfmmeOOavHBwgqmuknkFtzGQTLiFYomE2ul+
	Kcj+8Rrs9qPnuIHs5Zpx0ktxl2fRwxZ4ND/TLNIkFbiYdhsX/esaaBDyBNBRiimZ0RzF3a
	ukmnvwn1RF3g/pSw+jf8W+JrTM6BAYLrk+wjBRSdR/TmkctJHlNPwMM/TI/s4aAjRYAN6e
	CaqyoPGmG895fskrCqOIb4CwY1YC6gbpJg1UhXAefv9dcHPQH84Ou7Tegiln8g==
Date: Thu, 06 Mar 2025 22:26:45 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Jonas Karlman <jonas@kwiboo.se>
Cc: Heiko Stuebner <heiko@sntech.de>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre
 Torgue <alexandre.torgue@foss.st.com>, Ezequiel Garcia
 <ezequiel@vanguardiasur.com.ar>, David Wu <david.wu@rock-chips.com>,
 netdev@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 2/3] net: stmmac: dwmac-rk: Use DELAY_ENABLE macro for
 RK3566/RK3568
In-Reply-To: <20250306203858.1677595-3-jonas@kwiboo.se>
References: <20250306203858.1677595-1-jonas@kwiboo.se>
 <20250306203858.1677595-3-jonas@kwiboo.se>
Message-ID: <73ac54350ee3e42dee2b886403f003de@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Jonas,

On 2025-03-06 21:38, Jonas Karlman wrote:
> Support for Rockchip RK3566/RK3568 GMAC was added without use of the
> DELAY_ENABLE macro to assist with enable/disable use of MAC rx/tx 
> delay.
> 
> Change to use the DELAY_ENABLE macro to help disable MAC delay when
> RGMII_ID/RXID/TXID is used. This also re-order to enable/disable before

s/re-order/re-orders/

> the delay is written to match all other GMAC and vendor kernel.

s/GMAC/GMACs/

> Fixes: 3bb3d6b1c195 ("net: stmmac: Add RK3566/RK3568 SoC support")
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> index 297fa93e4a39..37eb86e4e325 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> @@ -1049,14 +1049,13 @@ static void rk3568_set_to_rgmii(struct
> rk_priv_data *bsp_priv,
>  	con1 = (bsp_priv->id == 1) ? RK3568_GRF_GMAC1_CON1 :
>  				     RK3568_GRF_GMAC0_CON1;
> 
> +	regmap_write(bsp_priv->grf, con1,
> +		     RK3568_GMAC_PHY_INTF_SEL_RGMII |
> +		     DELAY_ENABLE(RK3568, tx_delay, rx_delay));
> +
>  	regmap_write(bsp_priv->grf, con0,
>  		     RK3568_GMAC_CLK_RX_DL_CFG(rx_delay) |
>  		     RK3568_GMAC_CLK_TX_DL_CFG(tx_delay));
> -
> -	regmap_write(bsp_priv->grf, con1,
> -		     RK3568_GMAC_PHY_INTF_SEL_RGMII |
> -		     RK3568_GMAC_RXCLK_DLY_ENABLE |
> -		     RK3568_GMAC_TXCLK_DLY_ENABLE);
>  }
> 
>  static void rk3568_set_to_rmii(struct rk_priv_data *bsp_priv)

Thanks for this patch...  It's looking good to me, and good job
spotting this issue!  Please, free to include:

Reviewed-by: Dragan Simic <dsimic@manjaro.org>

