Return-Path: <netdev+bounces-180455-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA97A815EF
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 21:38:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9906A448B95
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 19:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D06A724501C;
	Tue,  8 Apr 2025 19:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aVHLsyvO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC19245012
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 19:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744141078; cv=none; b=ebLze3KE1Kt04pte8j5fEvBjNF0QGY+gfc7kHiLciTIAEK861QBwkDSsMfjQIbgCcsqA9g0KZZYXJZHtzhGmsqscRiqJyiwR7A4vsQSueR6Gv1qLAjgu+iSGaaZu9Zo+qw8xjuhODfcZWB0Sbf52vlnRvsbs1XIuIDf8Cg3SHwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744141078; c=relaxed/simple;
	bh=85wIl317j4jiqoJgOO4oESIHzu0abN/wXL9l0EY3Ies=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=edglH4qrbUs89bjLcg0qndo09esv14K6ihuIWdiath0Gwbt533AzoM9ECUcg2WObWtJOnOgOViNWcfzcgJkSTtJtq4zFNxl0Ys7o2QS5Cn9og2U8iHGZDkAkQqWhuSWhd4iIRqr9QOHHf23TCR+ys2/0a+qrkbNoQWMecH3SsgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aVHLsyvO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60554C4CEE5;
	Tue,  8 Apr 2025 19:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744141077;
	bh=85wIl317j4jiqoJgOO4oESIHzu0abN/wXL9l0EY3Ies=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aVHLsyvOWP+kNWbam7Tzo8XFBXpS13rzOknrm9cfpuvzhC+LIv/jiBJJCBvHhMHJV
	 qkeRQSgZYZIx5ci0Cpz93Qet9TDxTvkxuXp4axZajQeQIsf3skDOvNPpPpZOhOL48I
	 6BlL/FfpNgXaqM4tRvtCmJf4k7HqKBNM8jnZzNy6Ci4oJkZpH1h0+VFOw6Pp4w53Rm
	 R2yVW4TX03ZXeYfhUcQtuR8TQVpXZxrMC2CkPxiqRPMS+Iiz9wURzXqpB/WtbpLYom
	 ZeBd3NnBzmEsHDOtEYxnoiYUCEPr9bqSpZOgrufWVzE1vUbv4nbtPwW49rZXTmGD6q
	 TY535/rH79KRg==
Date: Tue, 8 Apr 2025 12:37:55 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jon Hunter <jonathanh@nvidia.com>,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org, Paolo Abeni
 <pabeni@redhat.com>, Prabhakar <prabhakar.csengg@gmail.com>, Thierry Reding
 <treding@nvidia.com>
Subject: Re: [PATCH net-next 2/2] net: stmmac: dwc-qos: use
 stmmac_pltfr_find_clk()
Message-ID: <20250408123755.1077e29b@kernel.org>
In-Reply-To: <E1u1rMv-0013ON-TJ@rmk-PC.armlinux.org.uk>
References: <Z_Qbw0tZ2ktgBf7c@shell.armlinux.org.uk>
	<E1u1rMv-0013ON-TJ@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 07 Apr 2025 19:38:49 +0100 Russell King (Oracle) wrote:
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  .../ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c    | 14 ++------------
>  1 file changed, 2 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
> index cd431f84f34f..f5c68e3b4354 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c
> @@ -34,16 +34,6 @@ struct tegra_eqos {
>  	struct gpio_desc *reset;
>  };
>  
> -static struct clk *dwc_eth_find_clk(struct plat_stmmacenet_data *plat_dat,
> -				    const char *name)
> -{
> -	for (int i = 0; i < plat_dat->num_clks; i++)
> -		if (strcmp(plat_dat->clks[i].id, name) == 0)
> -			return plat_dat->clks[i].clk;
> -
> -	return NULL;
> -}

Missed one user?

drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c:355:25: error: call to undeclared function 'dwc_eth_find_clk'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
  355 |         plat_dat->stmmac_clk = dwc_eth_find_clk(plat_dat,
      |                                ^
drivers/net/ethernet/stmicro/stmmac/dwmac-dwc-qos-eth.c:355:23: error: incompatible integer to pointer conversion assigning to 'struct clk *' from 'int' [-Wint-conversion]
  355 |         plat_dat->stmmac_clk = dwc_eth_find_clk(plat_dat,
      |                              ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~
  356 |                                                 data->stmmac_clk_name);
      |                                                 ~~~~~~~~~~~~~~~~~~~~~~
-- 
pw-bot: cr

