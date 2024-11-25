Return-Path: <netdev+bounces-147197-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B0DB9D82DA
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 10:50:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C7A9286A27
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 09:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0504B19149E;
	Mon, 25 Nov 2024 09:49:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out198-20.us.a.mail.aliyun.com (out198-20.us.a.mail.aliyun.com [47.90.198.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D8912B17C;
	Mon, 25 Nov 2024 09:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=47.90.198.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732528176; cv=none; b=rkJ+cpchJ3ASPzC1C9hhdg/m8JNHB+mhP4mHhg21JYym76oaTKw/HpLNvDLvVAwIfxfRu0bI+dW/2/kTZRnqa1uZy5U3mImDFF1p+a+pzFF0CrOCNtRKmtvlxzapzsiMeWhEGwBAoTuYd7iRA73p+crYrokuxW0clvd7aqVROHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732528176; c=relaxed/simple;
	bh=oVpkyRX5ML3zfya5CuT278HfRoLX4XGPkPbPJqJcckE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B2swinK+eFQRgYvbe4wLOcTaNBIX2y4vsbQtrPnyV1gOHRm4Ik1Uc/xbVwqZOEz38jFumyVSzPi5b/15706EKnIcb1bxRU8NhMKiH1s4goaVNH1c6TRIeqZV12fafChD50XU4ecjTP1pgcZ+GUBAzu540CqjQCQI9Y4PmRUlcPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=47.90.198.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
Received: from 10.0.2.15(mailfrom:Frank.Sae@motor-comm.com fp:SMTPD_---.aLoTznl_1732528160 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 25 Nov 2024 17:49:20 +0800
Message-ID: <11e26658-670f-49fa-8001-0654670b541e@motor-comm.com>
Date: Mon, 25 Nov 2024 17:49:19 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 09/21] motorcomm:yt6801: Implement some hw_ops
 function
To: Andrew Lunn <andrew@lunn.ch>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 xiaogang.fan@motor-comm.com, fei.zhang@motor-comm.com, hua.sun@motor-comm.com
References: <20241120105625.22508-1-Frank.Sae@motor-comm.com>
 <20241120105625.22508-10-Frank.Sae@motor-comm.com>
 <46206a81-e230-411c-8a78-d461d238b171@lunn.ch>
Content-Language: en-US
From: Frank Sae <Frank.Sae@motor-comm.com>
In-Reply-To: <46206a81-e230-411c-8a78-d461d238b171@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Andrew,

On 2024/11/23 09:03, Andrew Lunn wrote:
> It took a lot of effort to find your MDIO code. And MDIO bus driver
> makes a good patch on its own.
> 

Sorry about that.
There is too many codes in yt6801_hw.c file. If I put the MDIO bus driver
in one patch, it's would be very difficult to limit to 15 patches. 

>> +static int mdio_loop_wait(struct fxgmac_pdata *pdata, u32 max_cnt)
>> +{
>> +	u32 val, i;
>> +
>> +	for (i = 0; i < max_cnt; i++) {
>> +		val = rd32_mac(pdata, MAC_MDIO_ADDRESS);
>> +		if ((val & MAC_MDIO_ADDR_BUSY) == 0)
>> +			break;
>> +
>> +		fsleep(10);
>> +	}
>> +
>> +	if (i >= max_cnt) {
>> +		WARN_ON(1);
>> +		yt_err(pdata, "%s timeout. used cnt:%d, reg_val=%x.\n",
>> +		       __func__, i + 1, val);
>> +
>> +		return -ETIMEDOUT;
>> +	}
> 
> Please replace this using one of the helpers in
> include/linux/iopoll.h.
> 
>> +#define PHY_WR_CONFIG(reg_offset)		(0x8000205 + ((reg_offset) * 0x10000))
>> +static int fxgmac_phy_write_reg(struct fxgmac_pdata *pdata, u32 reg_id, u32 data)
>> +{
>> +	int ret;
>> +
>> +	wr32_mac(pdata, data, MAC_MDIO_DATA);
>> +	wr32_mac(pdata, PHY_WR_CONFIG(reg_id), MAC_MDIO_ADDRESS);
>> +	ret = mdio_loop_wait(pdata, PHY_MDIO_MAX_TRY);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	yt_dbg(pdata, "%s, id:%x %s, ctrl:0x%08x, data:0x%08x\n", __func__,
>> +	       reg_id, (ret == 0) ? "ok" : "err", PHY_WR_CONFIG(reg_id), data);
>> +
>> +	return ret;
>> +}
>> +
>> +#define PHY_RD_CONFIG(reg_offset)		(0x800020d + ((reg_offset) * 0x10000))
>> +static int fxgmac_phy_read_reg(struct fxgmac_pdata *pdata, u32 reg_id)
>> +{
>> +	u32 val;
>> +	int ret;
>> +
>> +	wr32_mac(pdata, PHY_RD_CONFIG(reg_id), MAC_MDIO_ADDRESS);
>> +	ret =  mdio_loop_wait(pdata, PHY_MDIO_MAX_TRY);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	val = rd32_mac(pdata, MAC_MDIO_DATA);  /* Read data */
>> +	yt_dbg(pdata, "%s, id:%x ok, ctrl:0x%08x, val:0x%08x.\n", __func__,
>> +	       reg_id, PHY_RD_CONFIG(reg_id), val);
>> +
>> +	return val;
>> +}
> 
> And where is the rest of the MDIO bus driver?

There is no separate reset of MDIO bus driver.

> 
>> +static int fxgmac_config_flow_control(struct fxgmac_pdata *pdata)
>> +{
>> +	u32 val = 0;
>> +	int ret;
>> +
>> +	fxgmac_config_tx_flow_control(pdata);
>> +	fxgmac_config_rx_flow_control(pdata);
>> +
>> +	/* Set auto negotiation advertisement pause ability */
>> +	if (pdata->tx_pause || pdata->rx_pause)
>> +		val |= ADVERTISE_PAUSE_CAP | ADVERTISE_PAUSE_ASYM;
>> +
>> +	ret = phy_modify(pdata->phydev, MII_ADVERTISE,
>> +			 ADVERTISE_PAUSE_CAP | ADVERTISE_PAUSE_ASYM, val);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	return phy_modify(pdata->phydev, MII_BMCR, BMCR_RESET, BMCR_RESET);
>> +}
> 
> 
> Yet more code messing with the PHY. This all needs to go.
> 
>> +static int fxgmac_phy_clear_interrupt(struct fxgmac_pdata *pdata)
>> +{
>> +	u32 stats_pre, stats;
>> +
>> +	if (mutex_trylock(&pdata->phydev->mdio.bus->mdio_lock) == 0) {
>> +		yt_dbg(pdata, "lock not ready!\n");
>> +		return 0;
>> +	}
>> +
>> +	stats_pre = fxgmac_phy_read_reg(pdata, PHY_INT_STATUS);
>> +	if (stats_pre < 0)
>> +		goto unlock;
>> +
>> +	stats = fxgmac_phy_read_reg(pdata, PHY_INT_STATUS);
>> +	if (stats < 0)
>> +		goto unlock;
>> +
>> +	phy_unlock_mdio_bus(pdata->phydev);
>> +
>> +#define LINK_DOWN	0x800
>> +#define LINK_UP		0x400
>> +#define LINK_CHANGE	(LINK_DOWN | LINK_UP)
>> +	if ((stats_pre & LINK_CHANGE) != (stats & LINK_CHANGE)) {
>> +		yt_dbg(pdata, "phy link change\n");
>> +		return 1;
>> +	}
>> +
>> +	return 0;
>> +unlock:
>> +	phy_unlock_mdio_bus(pdata->phydev);
>> +	yt_err(pdata, "fxgmac_phy_read_reg err!\n");
>> +	return  -ETIMEDOUT;
>> +}
> 
> You need to rework your PHY interrupt handling. The PHY driver is
> responsible for handing the interrupt registers in the PHY. Ideally
> you just want to export an interrupt to phylib, so it can do all the
> work.

I'm sorry. Could you please give me more information about export
 an interrupt to phylib?

> 
> 	Andrew

