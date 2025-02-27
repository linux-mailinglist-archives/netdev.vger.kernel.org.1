Return-Path: <netdev+bounces-170254-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 509AAA4800C
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 14:55:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B879A188E85C
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 13:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9819B22E3F4;
	Thu, 27 Feb 2025 13:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ZEwSO2rC"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B76C1E5210;
	Thu, 27 Feb 2025 13:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740664451; cv=none; b=XtJ4AAkwlSPJGZqcMpVTzxvEBuWKLOGmRp5Y2RXtxeKNOeEHveufTxeWyAskUXH3Nm0b8gUgyq0EPDTRWkVwZ3i8x/WU97WPxHMaEmDb0eup8j1m1eDY/6O17umgJ4GJIKhSQiqSl2RVJYV2U1yaGUlhN56DBxuNtMWoy3lRFnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740664451; c=relaxed/simple;
	bh=ccPiffmu6Z/RdPlNU4FutbTtkoXgChiCC+ODbm0Rf00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r17S3p24cM7d1x+DvmYa4QH3S5VX4IxUmHRNF726sHiXC7wUAhXfOSGaiGDYyHjCiPWGDHX1kSRwLt1IDtxQN6XoisPuh4PsOa2L9Evbed78yq50wXfARCJKzW3PTmptUQN2OMeSM7sFVg0PpZh7jpEh5dJIlDQcqi6G/sWVGqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ZEwSO2rC; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=+7p+whL+y2ixszcQ8G1Y9xt2LHqMnZq6hXYHzWoyza0=; b=ZEwSO2rCiGPMOuBHO8x1SYughN
	fgqx5F8nB+leOGzlDnAeTvXiV5RenBG4RfJroRdp+uK1TO3ZTSPLA79yHFN4qIn3wk+X8V37Tz7Au
	Nz68ETmYRp+jludadMpYqCvj0FvHQ+eNtTGDIwaBQqpQYUWRSFPKFIA6F8t08MlPB/WU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tneKs-000bj1-01; Thu, 27 Feb 2025 14:53:58 +0100
Date: Thu, 27 Feb 2025 14:53:57 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Kever Yang <kever.yang@rock-chips.com>
Cc: heiko@sntech.de, linux-rockchip@lists.infradead.org,
	David Wu <david.wu@rock-chips.com>,
	linux-arm-kernel@lists.infradead.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	netdev@vger.kernel.org,
	Detlev Casanova <detlev.casanova@collabora.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	"Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH v2 3/3] ethernet: stmmac: dwmac-rk: Make the phy clock
 could be used for external phy
Message-ID: <c523a7a8-34db-4902-bfc2-b8207ce4f4a0@lunn.ch>
References: <20250227110652.2342729-1-kever.yang@rock-chips.com>
 <20250227110652.2342729-3-kever.yang@rock-chips.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227110652.2342729-3-kever.yang@rock-chips.com>

On Thu, Feb 27, 2025 at 07:06:52PM +0800, Kever Yang wrote:
> From: David Wu <david.wu@rock-chips.com>
> 
> Use the phy_clk to prepare_enable and unprepare_disable related phy clock.
> 
> Signed-off-by: David Wu <david.wu@rock-chips.com>
> Signed-off-by: Kever Yang <kever.yang@rock-chips.com>
> ---
> 
> Changes in v2: None
> 
>  drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> index ccf4ecdffad3..cc90c74ec70c 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
> @@ -1867,12 +1867,14 @@ static int rk_gmac_clk_init(struct plat_stmmacenet_data *plat)
>  		clk_set_rate(bsp_priv->clk_mac, 50000000);
>  	}
>  
> -	if (plat->phy_node && bsp_priv->integrated_phy) {
> +	if (plat->phy_node) {
>  		bsp_priv->clk_phy = of_clk_get(plat->phy_node, 0);
>  		ret = PTR_ERR_OR_ZERO(bsp_priv->clk_phy);
>  		if (ret)
>  			return dev_err_probe(dev, ret, "Cannot get PHY clock\n");
> -		clk_set_rate(bsp_priv->clk_phy, 50000000);
> +		/* If it is not integrated_phy, clk_phy is optional */
> +		if (bsp_priv->integrated_phy)
> +			clk_set_rate(bsp_priv->clk_phy, 50000000);

That does not look backwards compatible. Older DT blobs which don't
have an integrated PHY won't have a clock in the node, so of_clk_get()
will return an error, and this function then exits with an error code.


    Andrew

---
pw-bot: cr

