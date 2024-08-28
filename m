Return-Path: <netdev+bounces-122809-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F97962A03
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 16:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 666241C21BDB
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 14:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377A71459FD;
	Wed, 28 Aug 2024 14:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="2B6goa/c"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1191E1BC20;
	Wed, 28 Aug 2024 14:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724854652; cv=none; b=OKkvDvcOvW8YRIM3o5UJpRZdQhF14VvrTCOX7+F7NLY1tapgxib+U2mwSZMMrXLJsVtneZ9puclGucPMoVoLZFTruF3UfYVPn5pz2l2IxnJL8DYWBxft9wZrO6joqmE3KXvqKPvGxh2p1oUFVIGbHosCvnM+sPjfSLiQAdPcSFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724854652; c=relaxed/simple;
	bh=5SD3vS3hfinL4O4GRh1j4kmE2yjUTv86L39GGCDrJo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bv8y9WdhQobdxYiDA2tFRg2xrH/5CljpszM7mLM3bnzgSMAA7Ptppjt/cXJ09uRf0NlS5RtQTsDOFx+NCNPiaBVMwlJuuh9iaXBLY4vwqkWfkItkVvMBBAtuUsydknKiEQsz7W/kv2LDwEkXphPztBtg1EUHvlWcqeqsjaGlRtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=2B6goa/c; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Vfekbi0HchxBjQQ/RvzxtQJeD9GLl2y8IkOsbfDf82s=; b=2B6goa/cDio3lnpvelC5GvCUuA
	nWt5Lxn9qeayYM7qd7LBItOIe/RcB4Ge/jGfvdwztUetwRv73BK9KNuCLVXUieCPkHTsS34SA7eNu
	WFJzmlNvBnd9nmhShD+entZRaCx+G6bY0yPSwIyGGMTy/3Z8H/oqA3jeur4iksY9fIxI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sjJTr-005wST-EH; Wed, 28 Aug 2024 16:17:03 +0200
Date: Wed, 28 Aug 2024 16:17:03 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: woojung.huh@microchip.com, f.fainelli@gmail.com, olteanv@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linus.walleij@linaro.org, alsi@bang-olufsen.dk,
	justin.chen@broadcom.com, sebastian.hesselbarth@gmail.com,
	alexandre.torgue@foss.st.com, joabreu@synopsys.com,
	mcoquelin.stm32@gmail.com, wens@csie.org, jernej.skrabec@gmail.com,
	samuel@sholland.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
	ansuelsmth@gmail.com, UNGLinuxDriver@microchip.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	bcm-kernel-feedback-list@broadcom.com,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-stm32@st-md-mailman.stormreply.com, krzk@kernel.org,
	jic23@kernel.org
Subject: Re: [PATCH net-next v2 01/13] net: stmmac: dwmac-sun8i: Use
 for_each_child_of_node_scoped()
Message-ID: <52435305-d134-4cee-8660-f7bf60206ddf@lunn.ch>
References: <20240828032343.1218749-1-ruanjinjie@huawei.com>
 <20240828032343.1218749-2-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828032343.1218749-2-ruanjinjie@huawei.com>

On Wed, Aug 28, 2024 at 11:23:31AM +0800, Jinjie Ruan wrote:
> Avoid need to manually handle of_node_put() by using
> for_each_child_of_node_scoped(), which can simplfy code.
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> index cc93f73a380e..8c5b4e0c0976 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
> @@ -774,7 +774,7 @@ static int sun8i_dwmac_reset(struct stmmac_priv *priv)
>  static int get_ephy_nodes(struct stmmac_priv *priv)
>  {
>  	struct sunxi_priv_data *gmac = priv->plat->bsp_priv;
> -	struct device_node *mdio_mux, *iphynode;
> +	struct device_node *mdio_mux;
>  	struct device_node *mdio_internal;
>  	int ret;

Networking uses reverse Christmas tree. Variables are sorted, longest
first, shortest last. So you need to move mdio_mux after
mdio_internal.

The rest looks O.K.


    Andrew

---
pw-bot: cr

