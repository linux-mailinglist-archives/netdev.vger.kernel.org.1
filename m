Return-Path: <netdev+bounces-146877-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1A09D6644
	for <lists+netdev@lfdr.de>; Sat, 23 Nov 2024 00:17:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6ED34B21ECB
	for <lists+netdev@lfdr.de>; Fri, 22 Nov 2024 23:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B79218870D;
	Fri, 22 Nov 2024 23:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="McinA9/2"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306AE175A5;
	Fri, 22 Nov 2024 23:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732317429; cv=none; b=Dv9MbXAy19kHsOWQF7NAVse//na9fJCulyjmaMsZAU0jOLu8o70qubWx6P27t3O/Uvn8w8DER3kxIpRp3Hxj1W3WlNDOaazPhl/tHYb83FZnrUzASEQgsWKXTtY82VoTfOMODiyQtqpi1KL8dA88SS4mUjvn1t/bNvFeKgPB3E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732317429; c=relaxed/simple;
	bh=BSDXvpM0OViZ45YebW7utZOtdqX/Jzc7J1aMkgoCg/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X+ObIst+5yVQ2mbgvqYQUzvQiU47ypoUDWpUEiSvXWV6cf78iEejwyWAOgfKQIbyFdRzyLBZ237IxgVCXfEQ/ETwcRz37qsndyzyz19/GAQajpUvhoOwkXMyeBYggRF5oYkjFLuph5VWGT5e80LYnBU2sHj6c1uyM1GGefg85JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=McinA9/2; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=nVftyJRl9ThyaLfNbVhV+F9OcRw1IwA/3BuCbESWyuw=; b=McinA9/2SWzu9g32K35EX2PS80
	sSgG5iJZP1SIJf3e38V1KIdlxxvZlMWjSn7bNX5A5qZnIdc7M8FZN/+HFwhPvyxYu1E04uDhtnziG
	J8IRCKXyRCL2W9buAj9jkeGXcxM+2cyS/dGw9vCel37kKSvUziy5UZTTPbneEeaefgRw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tEctW-00EAwA-CT; Sat, 23 Nov 2024 00:16:58 +0100
Date: Sat, 23 Nov 2024 00:16:58 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Frank Sae <Frank.Sae@motor-comm.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, xiaogang.fan@motor-comm.com,
	fei.zhang@motor-comm.com, hua.sun@motor-comm.com
Subject: Re: [PATCH net-next v2 05/21] motorcomm:yt6801: Implement the
 fxgmac_start function
Message-ID: <95675880-1b93-4916-beee-e5feb6531009@lunn.ch>
References: <20241120105625.22508-1-Frank.Sae@motor-comm.com>
 <20241120105625.22508-6-Frank.Sae@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241120105625.22508-6-Frank.Sae@motor-comm.com>

> +static  void fxgmac_phylink_handler(struct net_device *ndev)
> +{
> +	struct fxgmac_pdata *pdata = netdev_priv(ndev);
> +	struct fxgmac_hw_ops *hw_ops = &pdata->hw_ops;
> +
> +	pdata->phy_link = pdata->phydev->link;
> +	pdata->phy_speed = pdata->phydev->speed;
> +	pdata->phy_duplex = pdata->phydev->duplex;
> +
> +	yt_dbg(pdata, "EPHY_CTRL:%x, link:%d, speed:%d,  duplex:%x.\n",
> +	       rd32_mem(pdata, EPHY_CTRL), pdata->phy_link, pdata->phy_speed,
> +	       pdata->phy_duplex);
> +
> +	if (pdata->phy_link) {
> +		hw_ops->config_mac_speed(pdata);
> +		hw_ops->enable_rx(pdata);
> +		hw_ops->enable_tx(pdata);
> +		netif_carrier_on(pdata->netdev);

phylib controls the carrier, not the MAC driver.

> +static int fxgmac_phy_connect(struct fxgmac_pdata *pdata)
> +{
> +	struct phy_device *phydev = pdata->phydev;
> +	int ret;
> +
> +	ret = phy_connect_direct(pdata->netdev, phydev, fxgmac_phylink_handler,
> +				 PHY_INTERFACE_MODE_RGMII);

RGMII is unusual, you normally want RGMII_ID. Where are the 2ns delays
added?

> +int fxgmac_phy_irq_enable(struct fxgmac_pdata *pdata, bool clear_phy_interrupt)
> +{
> +	struct phy_device *phydev = pdata->phydev;
> +
> +	if (clear_phy_interrupt &&
> +	    phy_read(phydev, PHY_INT_STATUS) < 0)
> +		return -ETIMEDOUT;
> +
> +	return phy_modify(phydev, PHY_INT_MASK,
> +				     PHY_INT_MASK_LINK_UP |
> +					     PHY_INT_MASK_LINK_DOWN,
> +				     PHY_INT_MASK_LINK_UP |
> +					     PHY_INT_MASK_LINK_DOWN);

The PHY driver is in charge of PHY interrupts.

> +int fxgmac_start(struct fxgmac_pdata *pdata)
> +{
> +	struct fxgmac_hw_ops *hw_ops = &pdata->hw_ops;
> +	u32 val;
> +	int ret;
> +
> +	if (pdata->dev_state != FXGMAC_DEV_OPEN &&
> +	    pdata->dev_state != FXGMAC_DEV_STOP &&
> +	    pdata->dev_state != FXGMAC_DEV_RESUME) {
> +		yt_dbg(pdata, " dev_state err:%x\n", pdata->dev_state);
> +		return 0;
> +	}
> +
> +	if (pdata->dev_state != FXGMAC_DEV_STOP) {
> +		hw_ops->reset_phy(pdata);
> +		hw_ops->release_phy(pdata);
> +		yt_dbg(pdata, "reset phy.\n");
> +	}
> +
> +	if (pdata->dev_state == FXGMAC_DEV_OPEN) {
> +		ret = fxgmac_phy_connect(pdata);
> +		if (ret < 0)
> +			return ret;
> +
> +		yt_dbg(pdata, "fxgmac_phy_connect.\n");
> +	}
> +
> +	phy_init_hw(pdata->phydev);
> +	phy_resume(pdata->phydev);

The MAC should not be doing this.

> +
> +	hw_ops->pcie_init(pdata);
> +	if (test_bit(FXGMAC_POWER_STATE_DOWN, &pdata->powerstate)) {
> +		yt_err(pdata,
> +		       "fxgmac powerstate is %lu when config power up.\n",
> +		       pdata->powerstate);
> +	}
> +
> +	hw_ops->config_power_up(pdata);
> +	hw_ops->dismiss_all_int(pdata);
> +	ret = hw_ops->init(pdata);
> +	if (ret < 0) {
> +		yt_err(pdata, "fxgmac hw init error.\n");
> +		return ret;
> +	}
> +
> +	fxgmac_napi_enable(pdata);
> +	ret = fxgmac_request_irqs(pdata);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Config interrupt to level signal */
> +	val = rd32_mac(pdata, DMA_MR);
> +	fxgmac_set_bits(&val, DMA_MR_INTM_POS, DMA_MR_INTM_LEN, 2);
> +	fxgmac_set_bits(&val, DMA_MR_QUREAD_POS, DMA_MR_QUREAD_LEN, 1);
> +	wr32_mac(pdata, val, DMA_MR);
> +
> +	hw_ops->enable_mgm_irq(pdata);
> +	hw_ops->set_interrupt_moderation(pdata);
> +
> +	if (pdata->per_channel_irq) {
> +		fxgmac_enable_msix_irqs(pdata);
> +		ret = fxgmac_phy_irq_enable(pdata, true);
> +		if (ret < 0)
> +			goto dis_napi;
> +	}
> +
> +	fxgmac_enable_rx_tx_ints(pdata);
> +	phy_speed_up(pdata->phydev);
> +	genphy_soft_reset(pdata->phydev);

More things the MAC driver should not be doing.

	Andrew

