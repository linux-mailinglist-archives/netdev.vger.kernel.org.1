Return-Path: <netdev+bounces-229755-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E35BE0921
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 21:59:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD6123A8980
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 19:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529B5304BC1;
	Wed, 15 Oct 2025 19:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TEY9FEJ7"
X-Original-To: netdev@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E672272E4E
	for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 19:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760558294; cv=none; b=ul8G5l/pj42Jauk4gvpWfD88aH+o2H8ITh+S0FtZJ7V4UjK7O59OJWq2rmexEaEe9hZl+ptj/1tAuBX16oL6c91PNZLWjY0dlcMLo+vcFlg+IxCD5Qpc1zAooQd3EOlUCgc8rJLpu3TsgcRQBa51g+zpha5CLr5McW+ns+H/r/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760558294; c=relaxed/simple;
	bh=ijL7G3l17UUFGXfpJ6o3y43JTGFLjdaQ/OZTY+k0O84=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TxkvTnQav3x3ntvgn8cn8fcXOPC1tVJsptApNwSD8msG7PEHJaEN/CRzaFBnQGPIYi7xknosiQrqDt8548CbZDFP4u17x3zD0tQFGCIl5InYd8qDKzwtrp/Yp2Q0l/ufSbIa8kFHtE96JnaaizVRhWZ2qNBLbv9UKgUlWr4Ik2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TEY9FEJ7; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a8a523bb-a50a-419c-8ba8-78a3e7aa0daa@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760558288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YJKZ0PbJKApfosUZ/ry9Uk0FtDFj+uxPV98i+xqDHtY=;
	b=TEY9FEJ7MMmW7TBZu7xIIIbdSufKswnX24+5IMInKSDltyTom95gd6sdRjeFwfgOFGTJpJ
	KgDMCli8lbiwmc1e4WW9fWBh1V5FxI+K1KaXRejt3XflXyZ7ZVKegxUq+1Nqxt0Bj/YVSs
	rYmNdw/lMRnTgx5QCu0lpg8GfQ1yw7k=
Date: Wed, 15 Oct 2025 20:58:03 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v2 3/7] amd-xgbe: convert to ndo_hwtstamp
 callbacks
To: Jacob Keller <jacob.e.keller@intel.com>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Egor Pomozov <epomozov@marvell.com>, Potnuri Bharat Teja
 <bharat@chelsio.com>, Dimitris Michailidis <dmichail@fungible.com>,
 MD Danish Anwar <danishanwar@ti.com>, Roger Quadros <rogerq@kernel.org>
Cc: Richard Cochran <richardcochran@gmail.com>,
 Russell King <linux@armlinux.org.uk>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org
References: <20251014224216.8163-1-vadim.fedorenko@linux.dev>
 <20251014224216.8163-4-vadim.fedorenko@linux.dev>
 <0529aae6-19ef-4e10-9444-a99e54c90edc@intel.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <0529aae6-19ef-4e10-9444-a99e54c90edc@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 15.10.2025 20:47, Jacob Keller wrote:
> 
> 
> On 10/14/2025 3:42 PM, Vadim Fedorenko wrote:
>> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-hwtstamp.c b/drivers/net/ethernet/amd/xgbe/xgbe-hwtstamp.c
>> index bc52e5ec6420..0127988e10be 100644
>> --- a/drivers/net/ethernet/amd/xgbe/xgbe-hwtstamp.c
>> +++ b/drivers/net/ethernet/amd/xgbe/xgbe-hwtstamp.c
>> @@ -157,26 +157,24 @@ void xgbe_tx_tstamp(struct work_struct *work)
>>   	spin_unlock_irqrestore(&pdata->tstamp_lock, flags);
>>   }
>>   
>> -int xgbe_get_hwtstamp_settings(struct xgbe_prv_data *pdata, struct ifreq *ifreq)
>> +int xgbe_get_hwtstamp_settings(struct net_device *netdev,
>> +			       struct kernel_hwtstamp_config *config)
>>   {
>> -	if (copy_to_user(ifreq->ifr_data, &pdata->tstamp_config,
>> -			 sizeof(pdata->tstamp_config)))
>> -		return -EFAULT;
>> +	struct xgbe_prv_data *pdata = netdev_priv(netdev);
>> +
>> +	*config = pdata->tstamp_config;
>>   
>>   	return 0;
>>   }
>>   
>> -int xgbe_set_hwtstamp_settings(struct xgbe_prv_data *pdata, struct ifreq *ifreq)
>> +int xgbe_set_hwtstamp_settings(struct net_device *netdev,
>> +			       struct kernel_hwtstamp_config *config,
>> +			       struct netlink_ext_ack *extack)
>>   {
>> -	struct hwtstamp_config config;
>> -	unsigned int mac_tscr;
>> -
>> -	if (copy_from_user(&config, ifreq->ifr_data, sizeof(config)))
>> -		return -EFAULT;
>> -
>> -	mac_tscr = 0;
>> +	struct xgbe_prv_data *pdata = netdev_priv(netdev);
>> +	unsigned int mac_tscr = 0;
>>   
> 
> I noticed in this driver you didn't bother to add NL_SET_ERR_MSG calls.
> Any particular reason?

The only error here is the -ERANGE which is self-explanatory, so I decided to
keep the amount of changed lines as low as possible.

We might think of adding netlink error message for ERANGE error in
dev_set_hwtstamp() in case the driver skips setting specific message.

