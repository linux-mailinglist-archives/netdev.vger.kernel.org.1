Return-Path: <netdev+bounces-210627-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6D84B1412E
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 19:28:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B5A617D060
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 17:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDFB62741CB;
	Mon, 28 Jul 2025 17:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="1FsNGcke"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6876D21ABDC
	for <netdev@vger.kernel.org>; Mon, 28 Jul 2025 17:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753723693; cv=none; b=o1p5xeK1YeidBXQrfbc32wdQ77UbLW73pke7226x7kDGsxM94phZqtnpgCXU1hZVyhRxhIm2FsTsyuGU1b0Ak1C+Sv7a7tc5SgbJAlo7HsVpW6Q8Oj0Ps7wMMaxOQJiQ/RXBvoXT6YJ/wyxyqLOooEdRQe+jwyhZ4b0GNh80iFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753723693; c=relaxed/simple;
	bh=/Q2d20o29XmeKo582fnE1LnMgLf7T5cMCnSy+hrWQLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HHN7v5XWvsh0DKSMGwa/k2TLZPlmMplMbzXpmj7nky2KnNNbIKSNuMugUO/uB5GQtqPBlbbwVFRjMXt9rSTX6/mRBtn3Eqr/pO8hTwctYOHi06Gm/U19iPlQrchRl5FFjfPJb23/9KKbaIaKROSdngZBKhtnfWxmbqBM1sYAmk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=1FsNGcke; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=wyxR7Bm/Ol+TxP5+zw7WuA3v6FPnTthLLIDlKJiwW3k=; b=1FsNGckeU+WK5cG+tmTzYMRJaQ
	b85pYQyyffBg/suM8jGSCmz/xJG3vVRTHC5qtqyJ3vcJuHsZANzL+2G2xep2cvsSveqrXobVkygWt
	3Bdfcds26/26kypiDfb4fyyoIV1JrZ9hHeX+Zd3cHT/PU0N4weO0L62xVGaXcIiMz1Ak=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ugRdp-0037R9-Dh; Mon, 28 Jul 2025 19:28:01 +0200
Date: Mon, 28 Jul 2025 19:28:01 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH RFC net-next 6/7] net: stmmac: add helpers to indicate
 WoL enable status
Message-ID: <eaef1b1b-5366-430c-97dd-cf3b40399ac7@lunn.ch>
References: <aIebMKnQgzQxIY3j@shell.armlinux.org.uk>
 <E1ugQ33-006KDR-Nj@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1ugQ33-006KDR-Nj@rmk-PC.armlinux.org.uk>

> +static inline bool stmmac_wol_enabled_mac(struct stmmac_priv *priv)
> +{
> +	return priv->plat->pmt && device_may_wakeup(priv->device);
> +}
> +
> +static inline bool stmmac_wol_enabled_phy(struct stmmac_priv *priv)
> +{
> +	return !priv->plat->pmt && device_may_wakeup(priv->device);
> +}

I agree this is a direct translation into a helper.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

I'm guessing at some point you want to change these two
helpers. e.g. at some point, you want to try getting the PHY to do the
WoL, independent of !priv->plat->pmt? 

> -	if (device_may_wakeup(priv->device) && !priv->plat->pmt)
> +	if (stmmac_wol_enabled_phy(priv))
>  		phylink_speed_down(priv->phylink, false);

This might be related to the next patch. But why only do speed down
when PHY is doing WoL? If the MAC is doing WoL, you could also do a
speed_down.

	Andrew

