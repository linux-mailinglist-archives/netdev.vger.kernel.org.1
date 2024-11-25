Return-Path: <netdev+bounces-147193-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 631B89D8244
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 10:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E92B816342F
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 09:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85BF019007F;
	Mon, 25 Nov 2024 09:31:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out198-20.us.a.mail.aliyun.com (out198-20.us.a.mail.aliyun.com [47.90.198.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2109915098F;
	Mon, 25 Nov 2024 09:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732527081; cv=none; b=OO6QnAzcqiAa3gZ2fDpx7X/FbeYjBWEhqeOQrsB62e4DzZ7GFr9sDFaenZ4YZ9+WNI8hs7wHLU5O/pLF3YPcjKvbPKkHB633CcnTDlrvQQMoJc/ftAFePMZcSHCXyzqYUCbK8TI1GNPBr/qDKyOyWA46IO3GdGTVsm1QwpOJu5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732527081; c=relaxed/simple;
	bh=l3qVLm9ZddLvs9+B9vDgR3UiVviQdJaPmWBDf72fr3M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G8E2k/x+APvYfp8WMsk3vcnsXVQSc105VnffTzrGnFrpXeJYXvknnx9fmHq5fxsygoWfVmnoL/l02WuE0cuAY/DzQzSRLsvCxm6RCyeh8sky5mFheEuWtQe7Z3Z5v0c47pZk0T9Y3E4tTooP5oKI/9teU7Antc9lPBGphp5Z/6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=47.90.198.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
Received: from 10.0.2.15(mailfrom:Frank.Sae@motor-comm.com fp:SMTPD_---.aLnmoO6_1732527063 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 25 Nov 2024 17:31:04 +0800
Message-ID: <ba24293a-77b1-4106-84d2-81ff343fc90f@motor-comm.com>
Date: Mon, 25 Nov 2024 17:31:02 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 05/21] motorcomm:yt6801: Implement the
 fxgmac_start function
To: Andrew Lunn <andrew@lunn.ch>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 xiaogang.fan@motor-comm.com, fei.zhang@motor-comm.com, hua.sun@motor-comm.com
References: <20241120105625.22508-1-Frank.Sae@motor-comm.com>
 <20241120105625.22508-6-Frank.Sae@motor-comm.com>
 <95675880-1b93-4916-beee-e5feb6531009@lunn.ch>
Content-Language: en-US
From: Frank Sae <Frank.Sae@motor-comm.com>
In-Reply-To: <95675880-1b93-4916-beee-e5feb6531009@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Andrew,

On 2024/11/23 07:16, Andrew Lunn wrote:
>> +static  void fxgmac_phylink_handler(struct net_device *ndev)
>> +{
>> +	struct fxgmac_pdata *pdata = netdev_priv(ndev);
>> +	struct fxgmac_hw_ops *hw_ops = &pdata->hw_ops;
>> +
>> +	pdata->phy_link = pdata->phydev->link;
>> +	pdata->phy_speed = pdata->phydev->speed;
>> +	pdata->phy_duplex = pdata->phydev->duplex;
>> +
>> +	yt_dbg(pdata, "EPHY_CTRL:%x, link:%d, speed:%d,  duplex:%x.\n",
>> +	       rd32_mem(pdata, EPHY_CTRL), pdata->phy_link, pdata->phy_speed,
>> +	       pdata->phy_duplex);
>> +
>> +	if (pdata->phy_link) {
>> +		hw_ops->config_mac_speed(pdata);
>> +		hw_ops->enable_rx(pdata);
>> +		hw_ops->enable_tx(pdata);
>> +		netif_carrier_on(pdata->netdev);
> 
> phylib controls the carrier, not the MAC driver.
> 
>> +static int fxgmac_phy_connect(struct fxgmac_pdata *pdata)
>> +{
>> +	struct phy_device *phydev = pdata->phydev;
>> +	int ret;
>> +
>> +	ret = phy_connect_direct(pdata->netdev, phydev, fxgmac_phylink_handler,
>> +				 PHY_INTERFACE_MODE_RGMII);
> 
> RGMII is unusual, you normally want RGMII_ID. Where are the 2ns delays
> added?
> 

Yes, you are right. PHY_INTERFACE_MODE_RGMII should be PHY_INTERFACE_MODE_RGMII_ID.
YT6801 NIC integrated with YT8531S phy, and the 2ns delays added in the phy driver.
https://elixir.bootlin.com/linux/v6.12/source/drivers/net/phy/motorcomm.c#L895


>> +int fxgmac_phy_irq_enable(struct fxgmac_pdata *pdata, bool clear_phy_interrupt)
>> +{
>> +	struct phy_device *phydev = pdata->phydev;
>> +
>> +	if (clear_phy_interrupt &&
>> +	    phy_read(phydev, PHY_INT_STATUS) < 0)
>> +		return -ETIMEDOUT;
>> +
>> +	return phy_modify(phydev, PHY_INT_MASK,
>> +				     PHY_INT_MASK_LINK_UP |
>> +					     PHY_INT_MASK_LINK_DOWN,
>> +				     PHY_INT_MASK_LINK_UP |
>> +					     PHY_INT_MASK_LINK_DOWN);
> 
> The PHY driver is in charge of PHY interrupts.
> 
>> +int fxgmac_start(struct fxgmac_pdata *pdata)
>> +{
>> +	struct fxgmac_hw_ops *hw_ops = &pdata->hw_ops;
>> +	u32 val;
>> +	int ret;
>> +
>> +	if (pdata->dev_state != FXGMAC_DEV_OPEN &&
>> +	    pdata->dev_state != FXGMAC_DEV_STOP &&
>> +	    pdata->dev_state != FXGMAC_DEV_RESUME) {
>> +		yt_dbg(pdata, " dev_state err:%x\n", pdata->dev_state);
>> +		return 0;
>> +	}
>> +
>> +	if (pdata->dev_state != FXGMAC_DEV_STOP) {
>> +		hw_ops->reset_phy(pdata);
>> +		hw_ops->release_phy(pdata);
>> +		yt_dbg(pdata, "reset phy.\n");
>> +	}
>> +
>> +	if (pdata->dev_state == FXGMAC_DEV_OPEN) {
>> +		ret = fxgmac_phy_connect(pdata);
>> +		if (ret < 0)
>> +			return ret;
>> +
>> +		yt_dbg(pdata, "fxgmac_phy_connect.\n");
>> +	}
>> +
>> +	phy_init_hw(pdata->phydev);
>> +	phy_resume(pdata->phydev);
> 
> The MAC should not be doing this.

Does this mean deleting 'phy_resume(pdata->phydev)'?

> 
>> +
>> +	hw_ops->pcie_init(pdata);
>> +	if (test_bit(FXGMAC_POWER_STATE_DOWN, &pdata->powerstate)) {
>> +		yt_err(pdata,
>> +		       "fxgmac powerstate is %lu when config power up.\n",
>> +		       pdata->powerstate);
>> +	}
>> +
>> +	hw_ops->config_power_up(pdata);
>> +	hw_ops->dismiss_all_int(pdata);
>> +	ret = hw_ops->init(pdata);
>> +	if (ret < 0) {
>> +		yt_err(pdata, "fxgmac hw init error.\n");
>> +		return ret;
>> +	}
>> +
>> +	fxgmac_napi_enable(pdata);
>> +	ret = fxgmac_request_irqs(pdata);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	/* Config interrupt to level signal */
>> +	val = rd32_mac(pdata, DMA_MR);
>> +	fxgmac_set_bits(&val, DMA_MR_INTM_POS, DMA_MR_INTM_LEN, 2);
>> +	fxgmac_set_bits(&val, DMA_MR_QUREAD_POS, DMA_MR_QUREAD_LEN, 1);
>> +	wr32_mac(pdata, val, DMA_MR);
>> +
>> +	hw_ops->enable_mgm_irq(pdata);
>> +	hw_ops->set_interrupt_moderation(pdata);
>> +
>> +	if (pdata->per_channel_irq) {
>> +		fxgmac_enable_msix_irqs(pdata);
>> +		ret = fxgmac_phy_irq_enable(pdata, true);
>> +		if (ret < 0)
>> +			goto dis_napi;
>> +	}
>> +
>> +	fxgmac_enable_rx_tx_ints(pdata);
>> +	phy_speed_up(pdata->phydev);
>> +	genphy_soft_reset(pdata->phydev);
> 
> More things the MAC driver should not be doing.

Does this mean deleting 'phy_speed_up(pdata->phydev);' and 'genphy_soft_reset(pdata->phydev);' ?

> 
> 	Andrew

