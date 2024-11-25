Return-Path: <netdev+bounces-147233-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3DE9D87C0
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 15:21:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7C38169DBB
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 14:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6581B21B3;
	Mon, 25 Nov 2024 14:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="H+cevGem"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E1C1AC43A;
	Mon, 25 Nov 2024 14:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732544304; cv=none; b=b2fh06PblXEdtAOoOQTwReL6TLldOd2Kl2JPT8jXbiiCBSd3tnI4GRFGYobi+lTksVvQ1FoAiw6OOZNaM3CxgZPc0z5CYleDrsypgIOD7hcghoH0TO6TtDvYKnv3w2CsemXHUopQQAHhHjTUXDIch1VHWCJn7UzRLYdKgaFoUXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732544304; c=relaxed/simple;
	bh=ctKaHozUO/AF5HxRZu2PDlbW3TqhY8CFwoyHMb0IeSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FIInlr2S4b5pzvDtbmXDJKxXmjcZ8uAWAdDMc2d0bagWIADEJ3TXChc+XID+WlX1yzg9zkMEjDNCjeQEvnhQLEZNeWE9AriDtFGGzmIK1fvhWW1XwtMuv1VKt9QU8k5lrYdDowBvp0RXMU9d35xTIgzE099SKXGRqjPEyvRcBjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=H+cevGem; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=0CpnDX6Kj6QjGvsPvwmG1odLi3Od9wlHP45GP/9BOjM=; b=H+cevGemSW77UIbdNcAojB8NTj
	bJmKFTIXMFvPs+AD71OPUoxZhfyGCPTLEBL/Vd7YajXQ4BzTsQCrhgBz9y/HgIiYBIqGRraKJ5Lg9
	jvB/E8rmxyuWpgoADigpPrtm4FqpgTEh+9+EEqKHB+haPmw4QS2pvFYYEAJGDeE7dYGc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tFZuf-00EOi2-0z; Mon, 25 Nov 2024 15:18:05 +0100
Date: Mon, 25 Nov 2024 15:18:05 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Frank Sae <Frank.Sae@motor-comm.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, xiaogang.fan@motor-comm.com,
	fei.zhang@motor-comm.com, hua.sun@motor-comm.com
Subject: Re: [PATCH net-next v2 05/21] motorcomm:yt6801: Implement the
 fxgmac_start function
Message-ID: <82e1860b-cbbf-4c82-9f1b-bf4a283e3585@lunn.ch>
References: <20241120105625.22508-1-Frank.Sae@motor-comm.com>
 <20241120105625.22508-6-Frank.Sae@motor-comm.com>
 <95675880-1b93-4916-beee-e5feb6531009@lunn.ch>
 <ba24293a-77b1-4106-84d2-81ff343fc90f@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba24293a-77b1-4106-84d2-81ff343fc90f@motor-comm.com>

> > RGMII is unusual, you normally want RGMII_ID. Where are the 2ns delays
> > added?
> > 
> 
> Yes, you are right. PHY_INTERFACE_MODE_RGMII should be PHY_INTERFACE_MODE_RGMII_ID.
> YT6801 NIC integrated with YT8531S phy, and the 2ns delays added in the phy driver.
> https://elixir.bootlin.com/linux/v6.12/source/drivers/net/phy/motorcomm.c#L895

But if you pass PHY_INTERFACE_MODE_RGMII to the PHY it is not adding
the 2ns delay. So how does this work now?

> >> +int fxgmac_start(struct fxgmac_pdata *pdata)
> >> +{
> >> +	struct fxgmac_hw_ops *hw_ops = &pdata->hw_ops;
> >> +	u32 val;
> >> +	int ret;
> >> +
> >> +	if (pdata->dev_state != FXGMAC_DEV_OPEN &&
> >> +	    pdata->dev_state != FXGMAC_DEV_STOP &&
> >> +	    pdata->dev_state != FXGMAC_DEV_RESUME) {
> >> +		yt_dbg(pdata, " dev_state err:%x\n", pdata->dev_state);
> >> +		return 0;
> >> +	}
> >> +
> >> +	if (pdata->dev_state != FXGMAC_DEV_STOP) {
> >> +		hw_ops->reset_phy(pdata);
> >> +		hw_ops->release_phy(pdata);
> >> +		yt_dbg(pdata, "reset phy.\n");
> >> +	}
> >> +
> >> +	if (pdata->dev_state == FXGMAC_DEV_OPEN) {
> >> +		ret = fxgmac_phy_connect(pdata);
> >> +		if (ret < 0)
> >> +			return ret;
> >> +
> >> +		yt_dbg(pdata, "fxgmac_phy_connect.\n");
> >> +	}
> >> +
> >> +	phy_init_hw(pdata->phydev);
> >> +	phy_resume(pdata->phydev);
> > 
> > The MAC should not be doing this.
> 
> Does this mean deleting 'phy_resume(pdata->phydev)'?

There are only a few phylib API calls you should be using

phy_connect() or one of its variants.
phy_start()
phy_stop()
phy_disconnect()

Those four are the core. Those should be all you need to minimum
support.

phy_support_asym_pause()
phy_support_eee()
phy_speed_up()
phy_speed_down()

and these are just nice to have to let phylib know about things the
MAC supports, so phylib can manage the PHY to make them available to
the MAC. This is the API between the MAC driver and phylib. phylib
will then manage the PHY. Any time you want to use a phy_* function,
look to see if other MAC drivers do. If they don't you should not
either.

> >> +	hw_ops->pcie_init(pdata);
> >> +	if (test_bit(FXGMAC_POWER_STATE_DOWN, &pdata->powerstate)) {
> >> +		yt_err(pdata,
> >> +		       "fxgmac powerstate is %lu when config power up.\n",
> >> +		       pdata->powerstate);
> >> +	}
> >> +
> >> +	hw_ops->config_power_up(pdata);
> >> +	hw_ops->dismiss_all_int(pdata);
> >> +	ret = hw_ops->init(pdata);
> >> +	if (ret < 0) {
> >> +		yt_err(pdata, "fxgmac hw init error.\n");
> >> +		return ret;
> >> +	}
> >> +
> >> +	fxgmac_napi_enable(pdata);
> >> +	ret = fxgmac_request_irqs(pdata);
> >> +	if (ret < 0)
> >> +		return ret;
> >> +
> >> +	/* Config interrupt to level signal */
> >> +	val = rd32_mac(pdata, DMA_MR);
> >> +	fxgmac_set_bits(&val, DMA_MR_INTM_POS, DMA_MR_INTM_LEN, 2);
> >> +	fxgmac_set_bits(&val, DMA_MR_QUREAD_POS, DMA_MR_QUREAD_LEN, 1);
> >> +	wr32_mac(pdata, val, DMA_MR);
> >> +
> >> +	hw_ops->enable_mgm_irq(pdata);
> >> +	hw_ops->set_interrupt_moderation(pdata);
> >> +
> >> +	if (pdata->per_channel_irq) {
> >> +		fxgmac_enable_msix_irqs(pdata);
> >> +		ret = fxgmac_phy_irq_enable(pdata, true);
> >> +		if (ret < 0)
> >> +			goto dis_napi;
> >> +	}
> >> +
> >> +	fxgmac_enable_rx_tx_ints(pdata);
> >> +	phy_speed_up(pdata->phydev);
> >> +	genphy_soft_reset(pdata->phydev);
> > 
> > More things the MAC driver should not be doing.
> 
> Does this mean deleting 'phy_speed_up(pdata->phydev);' and 'genphy_soft_reset(pdata->phydev);' ?

Two things here:

phy_speed_up()/phy_speed_down() is part of suspend/resume when using
WoL. This code has nothing to do with that. So why is it here?

There should not be any need to call genphy_soft_reset(). You should
figure out why you need it, because it could be a PHY driver bug, or a
MAC driver bug.

	Andrew

