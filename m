Return-Path: <netdev+bounces-250578-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C94F7D339E8
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 18:01:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DB25B30A21B3
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 16:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 560273939A4;
	Fri, 16 Jan 2026 16:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BJPvEdR6"
X-Original-To: netdev@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC570340D8C
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 16:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768582794; cv=none; b=TtKcrltjeM7bPYau5R/IYoNDY+yehW1tu+R4zbJ0491ErnpUC8DdMS7YW5palhCJD+0+MWO/LIKiJAiMVQfhny7rkixIDTucBjPKaN6HoVGQ9C17yJ6BPp8OO2F11xHt/zrBghReZkqQQvR6MaGmBXXQQwSsJI6xnKt5k5A31zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768582794; c=relaxed/simple;
	bh=g5/sW2OukMHtYOjWFxtjJRGK4Oxj6NDZRd6XNP7Ph9Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SAnkRJy/eq+XdWZUe+riz5pgcBBaqtaOClIM8OJQJQ1Je0KRlyjis9dNNKBU7nOXivFlsrduIIP8juNnrCZJBg52pYxdB6hEKsP8YVAnDYJShwnGI6gqCgC9shGIjAfw6W33tQpeDhDMULOVl2kRH+9MGYSf1/bb/6Ob1caU8kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BJPvEdR6; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <42614b10-549b-4cb2-a226-b9db30ff26c0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768582789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zllNg8/FdqNycdpGniGNzL0Gsm8TQnL88LvbSU/qkBQ=;
	b=BJPvEdR6T9B8fYeelrEWXi7VwhrLzFCU4LmPYNruDPL+UPwmSNbdClQNYAvYzbQuz5sLp8
	e1T7RNtEyq/Jx376gMM1w5C/W6wBdU1GUHd16OSKx+q01AX3OgIA24PmgAYaxtvT3BF5D5
	aVMsobtBBtlqAzPmtiFxwHGPwLPxle4=
Date: Fri, 16 Jan 2026 16:59:46 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next] net: ethernet: xscale: Check for PTP support
 properly
To: Vladimir Oltean <vladimir.oltean@nxp.com>,
 Linus Walleij <linusw@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org
References: <20260116-ixp4xx-fix-ethernet-v1-1-9ab3b411c77e@kernel.org>
 <20260116-ixp4xx-fix-ethernet-v1-1-9ab3b411c77e@kernel.org>
 <20260116143754.6xfhqrlhgtsewifd@skbuf>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20260116143754.6xfhqrlhgtsewifd@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 16/01/2026 14:37, Vladimir Oltean wrote:
> On Fri, Jan 16, 2026 at 03:27:29PM +0100, Linus Walleij wrote:
>> In ixp4xx_get_ts_info() ixp46x_ptp_find() is called
>> unconditionally despite this feature only existing on
>> ixp46x, leading to the following splat from tcpdump:
>>
>> root@OpenWrt:~# tcpdump -vv -X -i eth0
>> (...)
>> Unable to handle kernel NULL pointer dereference at virtual address
>>    00000238 when read
>> (...)
>> Call trace:
>>   ptp_clock_index from ixp46x_ptp_find+0x1c/0x38
>>   ixp46x_ptp_find from ixp4xx_get_ts_info+0x4c/0x64
>>   ixp4xx_get_ts_info from __ethtool_get_ts_info+0x90/0x108
>>   __ethtool_get_ts_info from __dev_ethtool+0xa00/0x2648
>>   __dev_ethtool from dev_ethtool+0x160/0x234
>>   dev_ethtool from dev_ioctl+0x2cc/0x460
>>   dev_ioctl from sock_ioctl+0x1ec/0x524
>>   sock_ioctl from sys_ioctl+0x51c/0xa94
>>   sys_ioctl from ret_fast_syscall+0x0/0x44
>>   (...)
>> Segmentation fault
>>
>> Check for ixp46x support before calling PTP.
>>
>> Fixes: c14e1ecefd9e ("net: ixp4xx_eth: convert to ndo_hwtstamp_get() and ndo_hwtstamp_set()")
> 
> I fail to see how this commit affected the ethtool_get_ts_info() code
> path, and how the problem wasn't already there.
> 
> What do you think about commit 9055a2f59162 ("ixp4xx_eth: make ptp
> support a platform driver")? Before it, ixp4xx_get_ts_info() had a
> cpu_is_ixp46x() test. Now it lacks it, and it relies on ixp46x_ptp_find()
> to not crash when the platform device driver for the PTP clock didn't
> probe (something which obviously doesn't happen currently).

I agree, 9055a2f59162 ("ixp4xx_eth: make ptp support a platform driver")
did introduce the regression while NDO hwtstamp conversion didn't touch
capabilities code.

And the fix should be applied to ixp46x_ptp_find() as it's obviously
wrong.

> 
>> Signed-off-by: Linus Walleij <linusw@kernel.org>
>> ---
>>   drivers/net/ethernet/xscale/ixp4xx_eth.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/xscale/ixp4xx_eth.c b/drivers/net/ethernet/xscale/ixp4xx_eth.c
>> index e1e7f65553e7..fa3a7694087a 100644
>> --- a/drivers/net/ethernet/xscale/ixp4xx_eth.c
>> +++ b/drivers/net/ethernet/xscale/ixp4xx_eth.c
>> @@ -1014,7 +1014,7 @@ static int ixp4xx_get_ts_info(struct net_device *dev,
>>   {
>>   	struct port *port = netdev_priv(dev);
>>   
>> -	if (port->phc_index < 0)
>> +	if (cpu_is_ixp46x() && (port->phc_index < 0))
>>   		ixp46x_ptp_find(&port->timesync_regs, &port->phc_index);
>>   
>>   	info->phc_index = port->phc_index;
>>
>> ---
>> base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
>> change-id: 20260116-ixp4xx-fix-ethernet-4fa36d900ccc
>>
>> Best regards,
>> -- 
>> Linus Walleij <linusw@kernel.org>
>>


