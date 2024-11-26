Return-Path: <netdev+bounces-147376-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3412D9D9474
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 10:29:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2157D168300
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 09:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC5911BA86C;
	Tue, 26 Nov 2024 09:28:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out28-171.mail.aliyun.com (out28-171.mail.aliyun.com [115.124.28.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61811B4122;
	Tue, 26 Nov 2024 09:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732613299; cv=none; b=nGHiUV0QGNFkQXNff5WTj2CA7AnChqU0xaJpCBFzNoF9/TW/TLNOQtYxMnS/0QD0pKGjgTTvflvGdfw+jjXtPddIDdzW76OkSF7GlyH5Ep32Orpm05SEJbna+9wY7mT0nw3LSIctC8u/Z2V7kIgUHeQwUnCr7UqQfCgPfHMNtJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732613299; c=relaxed/simple;
	bh=SZuyiSGsWlPw7HX0P6RnRL4kdpkTcv0tnCESV6ZJV4A=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=lLNrkQskFZQ7Ft1HB8UL5JRI1mo1oMRmQf9bA+ZzXnccX2KrCEhXp4p4jzRJ4PBS1iGA6r8UNqn6pQQKNZh7IJR3UG3VFGssklIn+HoSMMlkX2+XZJn+1oYkVKNxB021rNZEfbxSZvfepy+zzAWg3zant0rbzJPfTfHuvnDTP/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
Received: from 10.0.2.15(mailfrom:Frank.Sae@motor-comm.com fp:SMTPD_---.aNBBMub_1732613289 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 26 Nov 2024 17:28:10 +0800
Message-ID: <a48d76ac-db08-46d5-9528-f046a7b541dc@motor-comm.com>
Date: Tue, 26 Nov 2024 17:28:08 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 05/21] motorcomm:yt6801: Implement the
 fxgmac_start function
From: Frank Sae <Frank.Sae@motor-comm.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 xiaogang.fan@motor-comm.com, fei.zhang@motor-comm.com, hua.sun@motor-comm.com
References: <20241120105625.22508-1-Frank.Sae@motor-comm.com>
 <20241120105625.22508-6-Frank.Sae@motor-comm.com>
 <95675880-1b93-4916-beee-e5feb6531009@lunn.ch>
 <ba24293a-77b1-4106-84d2-81ff343fc90f@motor-comm.com>
 <82e1860b-cbbf-4c82-9f1b-bf4a283e3585@lunn.ch>
 <43341290-15e3-4784-9b69-7f3f13f34e01@motor-comm.com>
Content-Language: en-US
In-Reply-To: <43341290-15e3-4784-9b69-7f3f13f34e01@motor-comm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2024/11/26 11:15, Frank Sae wrote:
> Hi Andrew,
> 
> On 2024/11/25 22:18, Andrew Lunn wrote:
>>>> RGMII is unusual, you normally want RGMII_ID. Where are the 2ns delays
>>>> added?
>>>>
>>>
>>> Yes, you are right. PHY_INTERFACE_MODE_RGMII should be PHY_INTERFACE_MODE_RGMII_ID.
>>> YT6801 NIC integrated with YT8531S phy, and the 2ns delays added in the phy driver.
>>> https://elixir.bootlin.com/linux/v6.12/source/drivers/net/phy/motorcomm.c#L895
>>
>> But if you pass PHY_INTERFACE_MODE_RGMII to the PHY it is not adding
>> the 2ns delay. So how does this work now?
> 
> I'm sorry. Maybe PHY_INTERFACE_MODE_RGMII is enough.
> YT6801 is a pcie NIC chip that integrates one yt8531s phy.
> Therefore, a delay of 2ns is unnecessary, as the hardware has
>  already ensured this.

YT6801 looks like that:

                      ||                      
  ********************++**********************
  *            | PCIE Endpoint |             *
  *            +---------------+             *
  *                | GMAC |                  *
  *                +--++--+      YT6801      *
  *                  |**|                    *
  *         GMII --> |**| <-- MDIO           *
  *                 +-++--+                  *
  *                 | PHY |                  *
  *                 +--++-+                  *
  *********************||*********************

yt8531s phy driver not support GMII.


> 
>>
>>>>> +int fxgmac_start(struct fxgmac_pdata *pdata)
>>>>> +{
>>>>> +	struct fxgmac_hw_ops *hw_ops = &pdata->hw_ops;
>>>>> +	u32 val;
>>>>> +	int ret;
>>>>> +
>>>>> +	if (pdata->dev_state != FXGMAC_DEV_OPEN &&
>>>>> +	    pdata->dev_state != FXGMAC_DEV_STOP &&
>>>>> +	    pdata->dev_state != FXGMAC_DEV_RESUME) {
>>>>> +		yt_dbg(pdata, " dev_state err:%x\n", pdata->dev_state);
>>>>> +		return 0;
>>>>> +	}
>>>>> +
>>>>> +	if (pdata->dev_state != FXGMAC_DEV_STOP) {
>>>>> +		hw_ops->reset_phy(pdata);
>>>>> +		hw_ops->release_phy(pdata);
>>>>> +		yt_dbg(pdata, "reset phy.\n");
>>>>> +	}
>>>>> +
>>>>> +	if (pdata->dev_state == FXGMAC_DEV_OPEN) {
>>>>> +		ret = fxgmac_phy_connect(pdata);
>>>>> +		if (ret < 0)
>>>>> +			return ret;
>>>>> +
>>>>> +		yt_dbg(pdata, "fxgmac_phy_connect.\n");
>>>>> +	}
>>>>> +
>>>>> +	phy_init_hw(pdata->phydev);
>>>>> +	phy_resume(pdata->phydev);
>>>>
>>>> The MAC should not be doing this.
>>>
>>> Does this mean deleting 'phy_resume(pdata->phydev)'?
>>
>> There are only a few phylib API calls you should be using
>>
>> phy_connect() or one of its variants.
>> phy_start()
>> phy_stop()
>> phy_disconnect()
>>
>> Those four are the core. Those should be all you need to minimum
>> support.
>>
>> phy_support_asym_pause()
>> phy_support_eee()
>> phy_speed_up()
>> phy_speed_down()
>>
>> and these are just nice to have to let phylib know about things the
>> MAC supports, so phylib can manage the PHY to make them available to
>> the MAC. This is the API between the MAC driver and phylib. phylib
>> will then manage the PHY. Any time you want to use a phy_* function,
>> look to see if other MAC drivers do. If they don't you should not
>> either.
> 
> Tanks for your clear explanation.
> 
>>
>>>>> +	hw_ops->pcie_init(pdata);
>>>>> +	if (test_bit(FXGMAC_POWER_STATE_DOWN, &pdata->powerstate)) {
>>>>> +		yt_err(pdata,
>>>>> +		       "fxgmac powerstate is %lu when config power up.\n",
>>>>> +		       pdata->powerstate);
>>>>> +	}
>>>>> +
>>>>> +	hw_ops->config_power_up(pdata);
>>>>> +	hw_ops->dismiss_all_int(pdata);
>>>>> +	ret = hw_ops->init(pdata);
>>>>> +	if (ret < 0) {
>>>>> +		yt_err(pdata, "fxgmac hw init error.\n");
>>>>> +		return ret;
>>>>> +	}
>>>>> +
>>>>> +	fxgmac_napi_enable(pdata);
>>>>> +	ret = fxgmac_request_irqs(pdata);
>>>>> +	if (ret < 0)
>>>>> +		return ret;
>>>>> +
>>>>> +	/* Config interrupt to level signal */
>>>>> +	val = rd32_mac(pdata, DMA_MR);
>>>>> +	fxgmac_set_bits(&val, DMA_MR_INTM_POS, DMA_MR_INTM_LEN, 2);
>>>>> +	fxgmac_set_bits(&val, DMA_MR_QUREAD_POS, DMA_MR_QUREAD_LEN, 1);
>>>>> +	wr32_mac(pdata, val, DMA_MR);
>>>>> +
>>>>> +	hw_ops->enable_mgm_irq(pdata);
>>>>> +	hw_ops->set_interrupt_moderation(pdata);
>>>>> +
>>>>> +	if (pdata->per_channel_irq) {
>>>>> +		fxgmac_enable_msix_irqs(pdata);
>>>>> +		ret = fxgmac_phy_irq_enable(pdata, true);
>>>>> +		if (ret < 0)
>>>>> +			goto dis_napi;
>>>>> +	}
>>>>> +
>>>>> +	fxgmac_enable_rx_tx_ints(pdata);
>>>>> +	phy_speed_up(pdata->phydev);
>>>>> +	genphy_soft_reset(pdata->phydev);
>>>>
>>>> More things the MAC driver should not be doing.
>>>
>>> Does this mean deleting 'phy_speed_up(pdata->phydev);' and 'genphy_soft_reset(pdata->phydev);' ?
>>
>> Two things here:
>>
>> phy_speed_up()/phy_speed_down() is part of suspend/resume when using
>> WoL. This code has nothing to do with that. So why is it here?
>>
>> There should not be any need to call genphy_soft_reset(). You should
>> figure out why you need it, because it could be a PHY driver bug, or a
>> MAC driver bug.
>>
>> 	Andrew

