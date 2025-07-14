Return-Path: <netdev+bounces-206678-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53CBFB0409B
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 15:53:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4ECC13BAD9B
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 13:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC46253954;
	Mon, 14 Jul 2025 13:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="UtBS/0ch"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEF2242D98
	for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 13:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752501204; cv=none; b=ezRkip5o28ksqMfmZo70A0QWdqH5hCIYBGTgxY8YoIJ3InCy3gOof/2UpV2o/QEp3DxrZ0BTFavTRcu8RmoYoCsIiHn20BkplNjSVzX4N2WmigPpFNJYVlovHYEJcqOp3xCWYgAR5rKT1t18CYcMdYT088BP0hqdYFuUWGY72zA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752501204; c=relaxed/simple;
	bh=66xLKEOt00CvLKb5oOn8Y904YAJJuUxY0b83/wj+HY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cFmTNnQ+nX9dNPXk6m8actBwnh9DHLOqMs5UJSJiDK1jdn+Jmy2pBven1Cga14eHxfQ5PK7JvDFOP5tpcMWfbdniFl7UdmP+9NZB1NTJM9jsqM4cufi/I06+O8wUmRPEnzYhtXhtJIcUnzI7JxgJSn5ZAsVlm7Xl/PRs59e4zRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=UtBS/0ch; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=TmleEhhVyOMAvmKR4twAxGwgQhrNxQ2pccvF+Yutx3I=; b=UtBS/0chb+ZDH8y8RqGl2m7yeO
	uals07ZFQCEyENbaG0hmUouu0k1MOEE9tuQ9w1lbvRnHxN74m9jAD9TNxN09YNLhBuTiKXM5sIOh9
	s1IxAtvFuAVBtBbbzIWwXNkjBPu4ny0UXVcqerQIexBZ074ZoGLlgNjKIIDz3x+03Sko=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1ubJcB-001SqZ-ID; Mon, 14 Jul 2025 15:53:07 +0200
Date: Mon, 14 Jul 2025 15:53:07 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Marvin Lin <milkfafa@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, openbmc@lists.ozlabs.org,
	KWLIU@nuvoton.com, tmaimon77@gmail.com, kflin@nuvoton.com
Subject: Re: [PATCH] net: stmmac: Add NCSI support
Message-ID: <5b01bd9c-252c-41ac-adaa-dddda8ffd06b@lunn.ch>
References: <20250714053527.767380-1-milkfafa@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714053527.767380-1-milkfafa@gmail.com>

> -	ret = stmmac_reset(priv, priv->ioaddr);
> -	if (ret) {
> -		netdev_err(priv->dev, "Failed to reset the dma\n");
> -		return ret;
> +	if (!priv->plat->use_ncsi) {
> +		ret = stmmac_reset(priv, priv->ioaddr);
> +		if (ret) {
> +			netdev_err(priv->dev, "Failed to reset the dma\n");
> +			return ret;
> +		}
>  	}

Please break this patch up into a series and include good commit
messages. You can then explain why this change is safe.

>  	/* DMA Configuration */
> @@ -3643,6 +3646,14 @@ static void stmmac_hw_teardown(struct net_device *dev)
>  	clk_disable_unprepare(priv->plat->clk_ptp_ref);
>  }
>  
> +static void stmmac_ncsi_handler(struct ncsi_dev *nd)
> +{
> +	if (unlikely(nd->state != ncsi_dev_state_functional))
> +		return;
> +
> +	netdev_info(nd->dev, "NCSI interface %s\n", nd->link_up ? "up" : "down");

Please don't spam the kernel log. Only do prints if something goes
wrong.

> +}
> +
>  static void stmmac_free_irq(struct net_device *dev,
>  			    enum request_irq_err irq_err, int irq_idx)
>  {
> @@ -4046,14 +4057,16 @@ static int __stmmac_open(struct net_device *dev,
>  	if (ret < 0)
>  		return ret;
>  
> -	if ((!priv->hw->xpcs ||
> -	     xpcs_get_an_mode(priv->hw->xpcs, mode) != DW_AN_C73)) {
> -		ret = stmmac_init_phy(dev);
> -		if (ret) {
> -			netdev_err(priv->dev,
> -				   "%s: Cannot attach to PHY (error: %d)\n",
> -				   __func__, ret);
> -			goto init_phy_error;
> +	if (!priv->plat->use_ncsi) {
> +		if ((!priv->hw->xpcs ||

My understanding of NCSI is that you have an additional RGMII like
port feeding into the MAC. The MAC still has all its media machinery,
a PCS, PHY etc. Something needs to drive that PCS and PHY. So it would
be good to explain in the commit message why you are removing all
this.

	Andrew

