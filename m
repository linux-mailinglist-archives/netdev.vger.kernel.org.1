Return-Path: <netdev+bounces-241236-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B37C81D42
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 18:12:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB5823B011D
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 17:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83937317712;
	Mon, 24 Nov 2025 17:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CXHKCyTB"
X-Original-To: netdev@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BE893168F2
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 17:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764004181; cv=none; b=KolzEpkVacnHEJKFAZu6yYm2heSK2Mw21ieoGlL72ZtU4faPpdqx6P4xnuV8ewHvqEofa011j2Kw+bnMcpmTxd8J9+IImQ+I0Z2fFdPpKsPsLtsCL1SPMBET90bbuORUeHB3rG1ukLXx3QnPgm/lvMesKceMpkvGmV0Ls+Fz8BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764004181; c=relaxed/simple;
	bh=SwwbBCr9k2pF9Nzrm3HZnJFPIP2wKXHaPFONhMY020U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iph6EGTjPot6T/mpLEX8dYo42Wg+AyeeB5Kx/VpvPTMST2BhybpYvV8U5Q2CRNeh9/Aauryu8FcQHnjGwY82Y6z++UwpX4hVs4mmIwgk5w1v/zABNlUz28wmXpERNhOu1ho99wbIMvWB7PuLKFy5zGKvCd/W7sSuYXQHXfoiZYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CXHKCyTB; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e89ecfe7-b910-48b8-8e04-a9ca251867d5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764004175;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dZQ0NsxX8h8+Z+bTfJqkPoEl60s8jOm6fSCd6b1PV84=;
	b=CXHKCyTBgecjSpbdkcCwSN38fCClDFecYB66s9Ngm/5mXbiO1h4nv9VJW4UTf7w1moVRR0
	noH+7wSqrwSENNMstnKXrZx00Skuid/20tVGp64fRQmtzAPTH3v82utz5+2qierJbfx+AI
	+yAyNiGwoROuFqDbu3nzpm3ASg3l3wY=
Date: Mon, 24 Nov 2025 17:09:31 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v4 2/7] phy: add hwtstamp_get callback to phy
 drivers
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Russell King <linux@armlinux.org.uk>, Heiner Kallweit
 <hkallweit1@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Andrei Botila <andrei.botila@oss.nxp.com>,
 Richard Cochran <richardcochran@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Simon Horman <horms@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 Jacob Keller <jacob.e.keller@intel.com>,
 bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org,
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
References: <20251120174540.273859-1-vadim.fedorenko@linux.dev>
 <20251120174540.273859-3-vadim.fedorenko@linux.dev>
 <20251120185126.6e536058@kmaincent-XPS-13-7390>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20251120185126.6e536058@kmaincent-XPS-13-7390>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 20/11/2025 17:51, Kory Maincent wrote:
> On Thu, 20 Nov 2025 17:45:35 +0000
> Vadim Fedorenko <vadim.fedorenko@linux.dev> wrote:
> 
>> PHY devices had lack of hwtstamp_get callback even though most of them
>> are tracking configuration info. Introduce new call back to
>> mii_timestamper.
> 
> It's a pity you didn't take my comment into account. :/
> 
> " It would be nice to update this kdoc note:
> https://elixir.bootlin.com/linux/v6.18-rc6/source/net/core/dev_ioctl.c#L252 "

Oh, sorry Kory, totally forgot about this change. Will make it into v5
ASAP

> 
>> Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
>> Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>
>> Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
>> ---
>>   drivers/net/phy/phy.c           | 3 +++
>>   include/linux/mii_timestamper.h | 5 +++++
>>   2 files changed, 8 insertions(+)
>>
>> diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
>> index 350bc23c1fdb..13dd1691886d 100644
>> --- a/drivers/net/phy/phy.c
>> +++ b/drivers/net/phy/phy.c
>> @@ -478,6 +478,9 @@ int __phy_hwtstamp_get(struct phy_device *phydev,
>>   	if (!phydev)
>>   		return -ENODEV;
>>   
>> +	if (phydev->mii_ts && phydev->mii_ts->hwtstamp_get)
>> +		return phydev->mii_ts->hwtstamp_get(phydev->mii_ts, config);
>> +
>>   	return -EOPNOTSUPP;
>>   }
>>   
>> diff --git a/include/linux/mii_timestamper.h b/include/linux/mii_timestamper.h
>> index 08863c0e9ea3..3102c425c8e0 100644
>> --- a/include/linux/mii_timestamper.h
>> +++ b/include/linux/mii_timestamper.h
>> @@ -29,6 +29,8 @@ struct phy_device;
>>    *
>>    * @hwtstamp_set: Handles SIOCSHWTSTAMP ioctl for hardware time stamping.
>>    *
>> + * @hwtstamp_get: Handles SIOCGHWTSTAMP ioctl for hardware time stamping.
>> + *
>>    * @link_state: Allows the device to respond to changes in the link
>>    *		state.  The caller invokes this function while holding
>>    *		the phy_device mutex.
>> @@ -55,6 +57,9 @@ struct mii_timestamper {
>>   			     struct kernel_hwtstamp_config *kernel_config,
>>   			     struct netlink_ext_ack *extack);
>>   
>> +	int  (*hwtstamp_get)(struct mii_timestamper *mii_ts,
>> +			     struct kernel_hwtstamp_config *kernel_config);
>> +
>>   	void (*link_state)(struct mii_timestamper *mii_ts,
>>   			   struct phy_device *phydev);
>>   
> 
> 
> 


