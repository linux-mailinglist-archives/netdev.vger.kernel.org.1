Return-Path: <netdev+bounces-235811-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 72CC4C35DA8
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 14:33:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1E21B349F4B
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 13:33:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA4E1322DA8;
	Wed,  5 Nov 2025 13:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lZEwQFVw"
X-Original-To: netdev@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF3B321F51
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 13:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762349596; cv=none; b=PIEdtg/FN9pVx1LGOfTs3+UaBC2Q4u7eSTic6SXiw29YbwhncdExUMwimD/rU1M3Ec0yll1ekOZaNHLJcO28oqZZyoFgdyNP99j58whSCV89saA9uFHUMtQOEViMA38bdoXosXCR5SO6D4by40acoqH0FWWUP3Dr1AE5rUPPGCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762349596; c=relaxed/simple;
	bh=GNQH7xtNMfbLhh+/Rx1SO+VjrtVuKFJMQRUmoses+iM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vGr3ilJ0G0B4DU0YEv+OXnHH4BGtR8lRLsQ8An620+J5JMLWIquZZfj3vURuBfe1qsBDlyk4qjB8dKhVkl8bLiCQiwaNBkP1m9uGO0TF/HT5oyKO/amngDSCN+5m0ZPhxSbcFLuCbygI1pcCa6QfTzTwKNCPiv2JiVJ5E4fq/HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lZEwQFVw; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f28ee997-ed08-4123-83ab-3496e88ed815@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762349592;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CWTdo+5hh7NJLBSq727BtkQgikxX1L8tZgXBZ8gCACs=;
	b=lZEwQFVw9yNQ9sk2uxKkuOyaETin+DkFDuEXGq5+e4abmbd20pBco6LsT84eYK1xLwQhgv
	J6VVRJ69UlEhfF8dutp0qviMGTPx5DCc5P4OLZ9rDfraoxiNLb3dqNZaMXkZxzJyfGxGDX
	kkTbe5Cit9WwwD6xAiC01i99DgisL0A=
Date: Wed, 5 Nov 2025 13:33:08 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v2 1/7] bnx2x: convert to use ndo_hwtstamp
 callbacks
To: Jakub Kicinski <kuba@kernel.org>
Cc: Manish Chopra <manishc@marvell.com>,
 Marco Crivellari <marco.crivellari@suse.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Sunil Goutham <sgoutham@marvell.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Russell King <linux@armlinux.org.uk>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Simon Horman <horms@kernel.org>,
 Jacob Keller <jacob.e.keller@intel.com>,
 Kory Maincent <kory.maincent@bootlin.com>,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org
References: <20251103150952.3538205-1-vadim.fedorenko@linux.dev>
 <20251103150952.3538205-2-vadim.fedorenko@linux.dev>
 <20251104173737.3f655692@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20251104173737.3f655692@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 05/11/2025 01:37, Jakub Kicinski wrote:
> On Mon,  3 Nov 2025 15:09:46 +0000 Vadim Fedorenko wrote:
>> -static int bnx2x_hwtstamp_ioctl(struct bnx2x *bp, struct ifreq *ifr)
>> +static int bnx2x_hwtstamp_set(struct net_device *dev,
>> +			      struct kernel_hwtstamp_config *config,
>> +			      struct netlink_ext_ack *extack)
>>   {
>> -	struct hwtstamp_config config;
>> +	struct bnx2x *bp = netdev_priv(dev);
>>   	int rc;
>>   
>> -	DP(BNX2X_MSG_PTP, "HWTSTAMP IOCTL called\n");
>> -
>> -	if (copy_from_user(&config, ifr->ifr_data, sizeof(config)))
>> -		return -EFAULT;
>> +	DP(BNX2X_MSG_PTP, "HWTSTAMP SET called\n");
>>   
>>   	DP(BNX2X_MSG_PTP, "Requested tx_type: %d, requested rx_filters = %d\n",
>> -	   config.tx_type, config.rx_filter);
>> +	   config->tx_type, config->rx_filter);
>>   
>>   	bp->hwtstamp_ioctl_called = true;
>> -	bp->tx_type = config.tx_type;
>> -	bp->rx_filter = config.rx_filter;
>> +	bp->tx_type = config->tx_type;
>> +	bp->rx_filter = config->rx_filter;
>>   
>>   	rc = bnx2x_configure_ptp_filters(bp);
> 
> bnx2x_configure_ptp_filters() may return -ERANGE if settings were not applied.
> This may already be semi-broken but with the get in place we will make
> it even worse.

Ah, you mean in case of -ERANGE we will still have new filter
configuration set in bp object? It's easy to fix, but it will be
some kind of change of behavior. If it's acceptable, I'm happy to send 
v3 of the patchset.>
>>   	if (rc)
>>   		return rc;
>>   
>> -	config.rx_filter = bp->rx_filter;
>> +	config->rx_filter = bp->rx_filter;
>> +
>> +	return 0;
>> +}
>>   
>> -	return copy_to_user(ifr->ifr_data, &config, sizeof(config)) ?
>> -		-EFAULT : 0;
>> +static int bnx2x_hwtstamp_get(struct net_device *dev,
>> +			      struct kernel_hwtstamp_config *config)
>> +{
>> +	struct bnx2x *bp = netdev_priv(dev);
>> +
>> +	config->rx_filter = bp->rx_filter;
>> +	config->tx_type = bp->tx_type;
>> +
>> +	return 0;
>>   }


