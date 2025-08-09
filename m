Return-Path: <netdev+bounces-212312-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD70FB1F1E1
	for <lists+netdev@lfdr.de>; Sat,  9 Aug 2025 03:54:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 461207A54A1
	for <lists+netdev@lfdr.de>; Sat,  9 Aug 2025 01:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C9E5274FFE;
	Sat,  9 Aug 2025 01:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="I9//k9ul"
X-Original-To: netdev@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9D324C669;
	Sat,  9 Aug 2025 01:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754704460; cv=none; b=KlI4zYBlyX4q0Y+JgKgR31FmKZ2PYdx1rL3sPIh6MVAW272+rjMJDPCqAcsSLZsDfWY9uaUyN/TfllX1MmCZvszKhyr7QBl0BHQ1p4TrZBfHOVlWGdouwWRBtOUfFy0P2hiKYRVU/yDYa/SX2QlHInO4SKK022gc8kmU2AjpSlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754704460; c=relaxed/simple;
	bh=5MyHNWSI46tiJHinASdxqRIJxh1kM6PIeynDVJ2wzu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lY24ZvycPmlwWxTFWlXrpPaxYx5c2YomyMJz5R7ZM4jbkX8kc6bhhyKLx7hsHuqKDzEBpdeJf+8iBH6z1RN+l7izKG51b8nxRIAY0zgvOZG8kUtjwALRucVdcHadB4s1AVe02BHE3H6SvAjRC3mqyGzyeQ5AfhHwVYaEfWILXGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=I9//k9ul; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 9BD8825A48;
	Sat,  9 Aug 2025 03:54:14 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Mo_9veumSBIp; Sat,  9 Aug 2025 03:54:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1754704454; bh=5MyHNWSI46tiJHinASdxqRIJxh1kM6PIeynDVJ2wzu0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=I9//k9ulVwTDy43huorejXZhmyPCRlRhGsnPZWFGSNYAv1FKcCp4Me90sThnYxNLq
	 yZUYwEQE7W7Dx2EwJVjzD0YfaU21DdgDhFE6olrOO8a57PSUqm/xoSKZbfWruSFU5Q
	 FQSjbDiZIUuvNhlgrP1Ag+f4Y+7bcUQoppq7cZmBxuOw7yviHOB76EQstHXTxbKDc8
	 AUw5teQoSswGquAjBMFWhZVjYq53lFAeLzDifrI5sI7w6vPEPvk9pL7fUvEVh7Oea+
	 pfspb/1dwhFyf8+SQvFw2/8S4ncJYiIL5Zftuvu9NUqj9Lzkbl4WmQgEYq71ZBOMhK
	 lMcXvPsHpZHkg==
Date: Sat, 9 Aug 2025 01:54:00 +0000
From: Yao Zi <ziyao@disroot.org>
To: Simon Horman <horms@kernel.org>
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
Message-ID: <aJaqOHYU_eklj2BR@pie>
References: <20250808103447.63146-2-ziyao@disroot.org>
 <20250808133900.GD1705@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250808133900.GD1705@horms.kernel.org>

On Fri, Aug 08, 2025 at 02:39:00PM +0100, Simon Horman wrote:
> On Fri, Aug 08, 2025 at 10:34:48AM +0000, Yao Zi wrote:
> 
> ...
> 
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c
> > index f2946bea0bc2..50c1920bde6a 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-thead.c
> > @@ -152,7 +152,7 @@ static int thead_set_clk_tx_rate(void *bsp_priv, struct clk *clk_tx_i,
> >  static int thead_dwmac_enable_clk(struct plat_stmmacenet_data *plat)
> >  {
> >  	struct thead_dwmac *dwmac = plat->bsp_priv;
> > -	u32 reg;
> > +	u32 reg, div;
> >  
> >  	switch (plat->mac_interface) {
> >  	case PHY_INTERFACE_MODE_MII:
> > @@ -164,6 +164,13 @@ static int thead_dwmac_enable_clk(struct plat_stmmacenet_data *plat)
> >  	case PHY_INTERFACE_MODE_RGMII_RXID:
> >  	case PHY_INTERFACE_MODE_RGMII_TXID:
> >  		/* use pll */
> > +		div = clk_get_rate(plat->stmmac_clk) / rgmii_clock(SPEED_1000);
> > +		reg = FIELD_PREP(GMAC_PLLCLK_DIV_EN, 1) |
> > +		      FIELD_PREP(GMAC_PLLCLK_DIV_NUM, div),
> 
> Sorry for not noticing this before sending my previous email.
> 
> Although the code above is correct. I think it would be clearer
> to use ';' rather than ',' at the end of the line above. Perhaps ','
> is a typo.(',' is next to ';' on my keyboard at least).

This is actually a typo that occasionally passes the compilation... yeah
thanks for catching it.

I'll add a comment about the requirement that PLLCLK_DIV_EN must be set
to zero before changing the rate, and fix this typo in v3 as well.

> Flagged by Clang 20.1.8 with -Wcomma

Best regards,
Yao Zi

> > +
> > +		writel(0, dwmac->apb_base + GMAC_PLLCLK_DIV);
> > +		writel(reg, dwmac->apb_base + GMAC_PLLCLK_DIV);
> > +
> >  		writel(GMAC_GTXCLK_SEL_PLL, dwmac->apb_base + GMAC_GTXCLK_SEL);
> >  		reg = GMAC_TX_CLK_EN | GMAC_TX_CLK_N_EN | GMAC_TX_CLK_OUT_EN |
> >  		      GMAC_RX_CLK_EN | GMAC_RX_CLK_N_EN;
> 
> -- 
> pw-bot: changes-requested.

