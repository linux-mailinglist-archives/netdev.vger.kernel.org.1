Return-Path: <netdev+bounces-121410-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C36F195D01A
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 16:37:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2A68B221C1
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 14:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A696195B18;
	Fri, 23 Aug 2024 14:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="o7tgunip"
X-Original-To: netdev@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 416291957E2;
	Fri, 23 Aug 2024 14:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724422869; cv=none; b=Blui+oCgMtCh9sfSLPP4/Wq1qQJcukXquuzWi4qwWkHp7Wl9QRqlSoH7QB+DmjWcxSZvjwaNpRPMuh3R8+itZI4ear3ncy7pzbCBbn9aGGwoITy53qlDAfZShW+NuClX996jMBv7qgjKRedJM2cZ431rSq3bKki+WsiXXPuKhqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724422869; c=relaxed/simple;
	bh=Kk3ivEyA42z+9r2IfR4JbZJoYLGX82D0G3ygMejCNYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ScqbJMmpYulNFZUsDAR5ALgjL38v0brH+A2LVmJAmF0O9FWz10AmrsgWYKgKWgG4gidn/wZ+7pP2KtB5ZTiFUnJ7VRoL830UH0BOZtalY7BvA1WZNoKES3JFMLIjQazp3jnvaDFIL7TXI/gp/Yjmvb8yBDwcx9iPa60sejBpeGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=o7tgunip; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=bQZmzBWz/CL6j0TwrrcEFPo250vjCJnNPzSnDONQR+Q=; b=o7tgunipyF+hYaNzNp7UZ+DjdN
	lr/1wgmFiCtGvzou+9dQ+rFXLkrO0RLyYTg4mrGX9Pt2sMsXtNqFgtfaMBvhdKM0Y9mvjbgD0W5Yu
	Dsd12mO2zfVbIKgjuA1AsPFMaFkNcw3oOB/PHR5YqvIWrTii84c0LgBexCRuCFoPYqUJ27D9WNbIw
	gTr9MVvzkRUnKafxmTAXYK7R67XfS3I6ny2GmucRzWx31oLz2oy9OfsP4dNq9EOLh249XTbhFIcjK
	vnvgJqIk2SG3StOrhSptUZptaESD8rskRpd4Ori6j7VkvT0OYJ70P6E2M6929fyBNlp4aDdqjwjz7
	ROUngT9w==;
Received: from i53875ae2.versanet.de ([83.135.90.226] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1shV9d-0005sc-Qs; Fri, 23 Aug 2024 16:20:41 +0200
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: linux-kernel@vger.kernel.org,
 Detlev Casanova <detlev.casanova@collabora.com>
Cc: "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 David Wu <david.wu@rock-chips.com>,
 Giuseppe Cavallaro <peppe.cavallaro@st.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com,
 kernel@collabora.com, Detlev Casanova <detlev.casanova@collabora.com>
Subject:
 Re: [PATCH v3 1/3] ethernet: stmmac: dwmac-rk: Fix typo for RK3588 code
Date: Fri, 23 Aug 2024 16:21:25 +0200
Message-ID: <2564871.TLnPLrj5Ze@diego>
In-Reply-To: <20240823141318.51201-2-detlev.casanova@collabora.com>
References:
 <20240823141318.51201-1-detlev.casanova@collabora.com>
 <20240823141318.51201-2-detlev.casanova@collabora.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Freitag, 23. August 2024, 16:11:13 CEST schrieb Detlev Casanova:
> Fix SELET -> SELECT in RK3588_GMAC_CLK_SELET_CRU and
> RK3588_GMAC_CLK_SELET_IO
> 
> Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>

Reviewed-by: Heiko Stuebner <heiko@sntech.de>

> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> index 7ae04d8d291c8..9cf0aa58d13bf 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> @@ -1141,8 +1141,8 @@ static const struct rk_gmac_ops rk3568_ops = {
>  #define RK3588_GMAC_CLK_RMII_MODE(id)		GRF_BIT(5 * (id))
>  #define RK3588_GMAC_CLK_RGMII_MODE(id)		GRF_CLR_BIT(5 * (id))
>  
> -#define RK3588_GMAC_CLK_SELET_CRU(id)		GRF_BIT(5 * (id) + 4)
> -#define RK3588_GMAC_CLK_SELET_IO(id)		GRF_CLR_BIT(5 * (id) + 4)
> +#define RK3588_GMAC_CLK_SELECT_CRU(id)		GRF_BIT(5 * (id) + 4)
> +#define RK3588_GMAC_CLK_SELECT_IO(id)		GRF_CLR_BIT(5 * (id) + 4)
>  
>  #define RK3588_GMA_CLK_RMII_DIV2(id)		GRF_BIT(5 * (id) + 2)
>  #define RK3588_GMA_CLK_RMII_DIV20(id)		GRF_CLR_BIT(5 * (id) + 2)
> @@ -1240,8 +1240,8 @@ static void rk3588_set_gmac_speed(struct rk_priv_data *bsp_priv, int speed)
>  static void rk3588_set_clock_selection(struct rk_priv_data *bsp_priv, bool input,
>  				       bool enable)
>  {
> -	unsigned int val = input ? RK3588_GMAC_CLK_SELET_IO(bsp_priv->id) :
> -				   RK3588_GMAC_CLK_SELET_CRU(bsp_priv->id);
> +	unsigned int val = input ? RK3588_GMAC_CLK_SELECT_IO(bsp_priv->id) :
> +				   RK3588_GMAC_CLK_SELECT_CRU(bsp_priv->id);
>  
>  	val |= enable ? RK3588_GMAC_CLK_RMII_NOGATE(bsp_priv->id) :
>  			RK3588_GMAC_CLK_RMII_GATE(bsp_priv->id);
> 





