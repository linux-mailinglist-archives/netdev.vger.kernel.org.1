Return-Path: <netdev+bounces-229557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E9FEBDE0D2
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 12:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EE10424564
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 10:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C89315D59;
	Wed, 15 Oct 2025 10:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hIDXSBE+"
X-Original-To: netdev@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0710330CD97
	for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 10:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760524725; cv=none; b=fuIy3+EB4RoDk7SiH9yE+BqKupVj1Dy66An+fC1PqusvdA5jchYQAXUdvI+QbGdYlFoc0Agw85UJs5BmZ73MAJayX3sjI6YXEN7CUkFrVjKzFFxvH6iI/opqdqs7lXM56+2t6DXUjPiKZ812Tg55nMzaRKjnA87a7Ytj3fjvyH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760524725; c=relaxed/simple;
	bh=2qJmSFWgOw4h6lyZBlQuw0qo+KUbnt4yk4wDPEPqL5w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lz9/YCcRI7kJO2/WQgfK1rXrM+FeS81D2Emha5oslcHfV48FszO9Qq4W7GfNPzub+vhmo9L2HtJuV/himFdC88A8zmmEJfmdDOeuuxx859HrI7gSe5uQ/SxabBrvVDDNFo1vN92nr4Ah3kDwk+Mqzq3wIH0QW9VUuEsFJBVfueg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hIDXSBE+; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d160e924-dee1-46b9-8d24-71c3d9c00ea1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760524721;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jSy/yOO1QQAxVNmZJpZIeg62gLnzCPSUzpyphy2PrfA=;
	b=hIDXSBE+aK6/SPy48QH2BnznUkIpPPQL1XDMDLuIIN7FslzO9FZnABnlVXldTPm7F4kXCp
	XozGshCIbr/z90NMZSFPvZBrvlhXzeZA//SamRZbgVqpPqCJkBjA1IJDoUmoEhvnn7dqro
	F45EI1TILKHDs9bmWnR5WPCPE56CDf8=
Date: Wed, 15 Oct 2025 11:38:34 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v2 6/7] tsnep: convert to ndo_hwtstatmp API
To: Simon Horman <horms@kernel.org>
Cc: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Egor Pomozov <epomozov@marvell.com>, Potnuri Bharat Teja
 <bharat@chelsio.com>, Dimitris Michailidis <dmichail@fungible.com>,
 MD Danish Anwar <danishanwar@ti.com>, Roger Quadros <rogerq@kernel.org>,
 Richard Cochran <richardcochran@gmail.com>,
 Russell King <linux@armlinux.org.uk>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org
References: <20251014224216.8163-1-vadim.fedorenko@linux.dev>
 <20251014224216.8163-7-vadim.fedorenko@linux.dev>
 <aO9xf0gW9F0qsaCz@horms.kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <aO9xf0gW9F0qsaCz@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 15/10/2025 11:03, Simon Horman wrote:
> On Tue, Oct 14, 2025 at 10:42:15PM +0000, Vadim Fedorenko wrote:
>> Convert to .ndo_hwtstamp_get()/.ndo_hwtstamp_set() callbacks.
>> After conversions the rest of tsnep_netdev_ioctl() becomes pure
>> phy_do_ioctl_running(), so remove tsnep_netdev_ioctl() and replace
>> it with phy_do_ioctl_running() in .ndo_eth_ioctl.
>>
>> Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> 
> ...
> 
>> diff --git a/drivers/net/ethernet/engleder/tsnep_ptp.c b/drivers/net/ethernet/engleder/tsnep_ptp.c
>> index 54fbf0126815..ae1308eb813d 100644
>> --- a/drivers/net/ethernet/engleder/tsnep_ptp.c
>> +++ b/drivers/net/ethernet/engleder/tsnep_ptp.c
>> @@ -19,57 +19,53 @@ void tsnep_get_system_time(struct tsnep_adapter *adapter, u64 *time)
>>   	*time = (((u64)high) << 32) | ((u64)low);
>>   }
>>   
>> -int tsnep_ptp_ioctl(struct net_device *netdev, struct ifreq *ifr, int cmd)
>> +int tsnep_ptp_hwtstamp_get(struct net_device *netdev,
>> +			   struct kernel_hwtstamp_config *config)
>>   {
>>   	struct tsnep_adapter *adapter = netdev_priv(netdev);
>> -	struct hwtstamp_config config;
>> -
>> -	if (!ifr)
>> -		return -EINVAL;
>> -
>> -	if (cmd == SIOCSHWTSTAMP) {
>> -		if (copy_from_user(&config, ifr->ifr_data, sizeof(config)))
>> -			return -EFAULT;
>> -
>> -		switch (config.tx_type) {
>> -		case HWTSTAMP_TX_OFF:
>> -		case HWTSTAMP_TX_ON:
>> -			break;
>> -		default:
>> -			return -ERANGE;
>> -		}
>> -
>> -		switch (config.rx_filter) {
>> -		case HWTSTAMP_FILTER_NONE:
>> -			break;
>> -		case HWTSTAMP_FILTER_ALL:
>> -		case HWTSTAMP_FILTER_PTP_V1_L4_EVENT:
>> -		case HWTSTAMP_FILTER_PTP_V1_L4_SYNC:
>> -		case HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ:
>> -		case HWTSTAMP_FILTER_PTP_V2_L4_EVENT:
>> -		case HWTSTAMP_FILTER_PTP_V2_L4_SYNC:
>> -		case HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ:
>> -		case HWTSTAMP_FILTER_PTP_V2_L2_EVENT:
>> -		case HWTSTAMP_FILTER_PTP_V2_L2_SYNC:
>> -		case HWTSTAMP_FILTER_PTP_V2_L2_DELAY_REQ:
>> -		case HWTSTAMP_FILTER_PTP_V2_EVENT:
>> -		case HWTSTAMP_FILTER_PTP_V2_SYNC:
>> -		case HWTSTAMP_FILTER_PTP_V2_DELAY_REQ:
>> -		case HWTSTAMP_FILTER_NTP_ALL:
>> -			config.rx_filter = HWTSTAMP_FILTER_ALL;
>> -			break;
>> -		default:
>> -			return -ERANGE;
>> -		}
> 
> Hi Vadim,
> 
> I'm probably missing something obvious, but it's not clear to me why
> removing the inner switch statements above is ok. Or, perhaps more to the
> point, it seems inconsistent with other patches in this series.
> 
> OTOH, I do see why dropping the outer if conditions makes sense.

I believe it's just a question for git diff. It replaces original
tsnep_ptp_ioctl() function with get() callback. The only thing that new 
function does is copying actual config into reply.

The switch statement goes to set() callback where the logic is kept as
is. Original tsnep_ptp_ioctl() was serving both get and set operations,
but the logic was applied to set operation only.

> 
>> -
>> -		memcpy(&adapter->hwtstamp_config, &config,
>> -		       sizeof(adapter->hwtstamp_config));
>> +
>> +	*config = adapter->hwtstamp_config;
>> +	return 0;
>> +}
> 
> ...


