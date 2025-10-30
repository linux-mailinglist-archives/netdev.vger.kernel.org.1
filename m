Return-Path: <netdev+bounces-234388-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C038C1FFA6
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 13:20:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA45219C529B
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 12:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84F802D5922;
	Thu, 30 Oct 2025 12:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QNCWw7eC"
X-Original-To: netdev@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E17772618
	for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 12:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761826739; cv=none; b=hUI7dHajNrQeFkDOZcCiCMobSd/SsLJrldMaJGoz4SaFbshbZy6bbLKfplhsDCfy+xpJF8LlnY03dX/nX/9c69MB79peYQLDrCLnPRKOibGkZLIl3YqB7dfItK6HU+RGLK5lwLNgUQiVkh3S7UYej5sX+J8U0G435qXPC5Zx2ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761826739; c=relaxed/simple;
	bh=X0HZcUwvbkAUdRMem0CWsKp5l7ixK5IM9cIZZavhi68=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OJpNTHZGgS+KZHbp/pxcwhgszgZ0NU+fBSQ9yE+N5hQ2IeuCIBGJ6CO2zzB+nIwdhzg/xWcgku/TsgxAAL9BeMyr3GbagEN0oDHN+UENHeLfAelnFQRwphTHKzDUIMOAi8NLdo5o6YbStGp3T0JCZQFsGxNiJMFl+SS1NqHzM20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QNCWw7eC; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0a37246f-9dad-4977-b7e0-5fa73c69ee94@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761826733;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6TBG4jISVivVB3urNHknRFdi60DeOVVv79k58aZ/9r8=;
	b=QNCWw7eCVZJKEEi2pXT7uULE+GdO+cDXpyMqgIEmQHrg+4o/4j73IB7YXEf2ApZ6wYJaas
	9bAOsuX1gCRibv6ljUvAvY8cbZpS+1LvjRAdo1mgY+kPE0bibifmJ7sZohooQ/I0Z1isBI
	PsZVymVsTyYlJXGCzwcZs9NKKunUr0s=
Date: Thu, 30 Oct 2025 12:18:50 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next] ti: netcp: convert to ndo_hwtstamp callbacks
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, Vladimir Oltean <vladimir.oltean@nxp.com>
References: <20251029200922.590363-1-vadim.fedorenko@linux.dev>
 <20251030113007.1acc78b6@kmaincent-XPS-13-7390>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20251030113007.1acc78b6@kmaincent-XPS-13-7390>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 30/10/2025 10:30, Kory Maincent wrote:
> On Wed, 29 Oct 2025 20:09:22 +0000
> Vadim Fedorenko <vadim.fedorenko@linux.dev> wrote:
> 
>> Convert TI NetCP driver to use ndo_hwtstamp_get()/ndo_hwtstamp_set()
>> callbacks. The logic is slightly changed, because I believe the original
>> logic was not really correct. Config reading part is using the very
>> first module to get the configuration instead of iterating over all of
>> them and keep the last one as the configuration is supposed to be identical
>> for all modules. HW timestamp config set path is now trying to configure
>> all modules, but in case of error from one module it adds extack
>> message. This way the configuration will be as synchronized as possible.
> 
> On the case the hwtstamp_set return the extack error the hwtstamp_get will
> return something that might not be true as not all module will have the same
> config. Is it acceptable?

Well, technically you are right. But this logic was broken from the very
beginning. And as I also mentioned, both modules use the same set
function with the same error path, which means in current situation if
the first call is successful, the second one will also succeed. And
that's why it's acceptable

>> There are only 2 modules using netcp core infrastructure, and both use
>> the very same function to configure HW timestamping, so no actual
>> difference in behavior is expected.
>>
>> Compile test only.
>>
>> Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
>> b/drivers/net/ethernet/ti/netcp_ethss.c index 55a1a96cd834..0ae44112812c
>> 100644 --- a/drivers/net/ethernet/ti/netcp_ethss.c
>> +++ b/drivers/net/ethernet/ti/netcp_ethss.c
>> @@ -2591,20 +2591,26 @@ static int gbe_rxtstamp(struct gbe_intf *gbe_intf,
>> struct netcp_packet *p_info) return 0;
>>   }
>>   
>> -static int gbe_hwtstamp_get(struct gbe_intf *gbe_intf, struct ifreq *ifr)
>> +static int gbe_hwtstamp_get(void *intf_priv, struct kernel_hwtstamp_config
>> *cfg) {
>> -	struct gbe_priv *gbe_dev = gbe_intf->gbe_dev;
>> -	struct cpts *cpts = gbe_dev->cpts;
>> -	struct hwtstamp_config cfg;
>> +	struct gbe_intf *gbe_intf = intf_priv;
>> +	struct gbe_priv *gbe_dev;
>> +	struct phy_device *phy;
>> +
>> +	gbe_dev = gbe_intf->gbe_dev;
>>   
>> -	if (!cpts)
>> +	if (!gbe_dev->cpts)
>> +		return -EOPNOTSUPP;
>> +
>> +	phy = gbe_intf->slave->phy;
>> +	if (phy_has_hwtstamp(phy))
>>   		return -EOPNOTSUPP;
> 
> This condition should be removed.
> The selection between PHY or MAC timestamping is now done in the net core:
> https://elixir.bootlin.com/linux/v6.17.1/source/net/core/dev_ioctl.c#L244

Yeah, but the problem here is that phy device is not really attached to 
netdev, but rather to some private structure, which is not accessible by
the core, only driver can work with it, according to the original code.

But I might be missing something obvious here, if someone is at least a
bit aware of this code and can shed some light and confirm that phydev
is correctly set and attached to actual netdev, I'm happy to remove this
ugly part.

> 
>>   
>> -	cfg.flags = 0;
>> -	cfg.tx_type = gbe_dev->tx_ts_enabled ? HWTSTAMP_TX_ON :
>> HWTSTAMP_TX_OFF;
>> -	cfg.rx_filter = gbe_dev->rx_ts_enabled;
>> +	cfg->flags = 0;
>> +	cfg->tx_type = gbe_dev->tx_ts_enabled ? HWTSTAMP_TX_ON :
>> HWTSTAMP_TX_OFF;
>> +	cfg->rx_filter = gbe_dev->rx_ts_enabled;
>>   
>> -	return copy_to_user(ifr->ifr_data, &cfg, sizeof(cfg)) ? -EFAULT : 0;
>> +	return 0;
>>   }
>>   
>>   static void gbe_hwtstamp(struct gbe_intf *gbe_intf)
>> @@ -2637,19 +2643,23 @@ static void gbe_hwtstamp(struct gbe_intf *gbe_intf)
>>   	writel(ctl,    GBE_REG_ADDR(slave, port_regs, ts_ctl_ltype2));
>>   }
>>   
>> -static int gbe_hwtstamp_set(struct gbe_intf *gbe_intf, struct ifreq *ifr)
>> +static int gbe_hwtstamp_set(void *intf_priv, struct kernel_hwtstamp_config
>> *cfg,
>> +			    struct netlink_ext_ack *extack)
>>   {
>> -	struct gbe_priv *gbe_dev = gbe_intf->gbe_dev;
>> -	struct cpts *cpts = gbe_dev->cpts;
>> -	struct hwtstamp_config cfg;
>> +	struct gbe_intf *gbe_intf = intf_priv;
>> +	struct gbe_priv *gbe_dev;
>> +	struct phy_device *phy;
>>   
>> -	if (!cpts)
>> +	gbe_dev = gbe_intf->gbe_dev;
>> +
>> +	if (!gbe_dev->cpts)
>>   		return -EOPNOTSUPP;
>>   
>> -	if (copy_from_user(&cfg, ifr->ifr_data, sizeof(cfg)))
>> -		return -EFAULT;
>> +	phy = gbe_intf->slave->phy;
>> +	if (phy_has_hwtstamp(phy))
>> +		return phy->mii_ts->hwtstamp(phy->mii_ts, cfg, extack);
> 
> Same.
> 
>>   
>> -	switch (cfg.tx_type) {
>> +	switch (cfg->tx_type) {
>>   	case HWTSTAMP_TX_OFF:
>>   		gbe_dev->tx_ts_enabled = 0;
>>   		break;
>> @@ -2660,7 +2670,7 @@ static int gbe_hwtstamp_set(struct gbe_intf *gbe_intf,
>> struct ifreq *ifr) return -ERANGE;
>>   	}
>>   
>> -	switch (cfg.rx_filter) {
>> +	switch (cfg->rx_filter) {
>>   	case HWTSTAMP_FILTER_NONE:
>>   		gbe_dev->rx_ts_enabled = HWTSTAMP_FILTER_NONE;
>>   		break;
>> @@ -2668,7 +2678,7 @@ static int gbe_hwtstamp_set(struct gbe_intf *gbe_intf,
>> struct ifreq *ifr) case HWTSTAMP_FILTER_PTP_V1_L4_SYNC:
>>   	case HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ:
>>   		gbe_dev->rx_ts_enabled = HWTSTAMP_FILTER_PTP_V1_L4_EVENT;
>> -		cfg.rx_filter = HWTSTAMP_FILTER_PTP_V1_L4_EVENT;
>> +		cfg->rx_filter = HWTSTAMP_FILTER_PTP_V1_L4_EVENT;
>>   		break;
>>   	case HWTSTAMP_FILTER_PTP_V2_L4_EVENT:
>>   	case HWTSTAMP_FILTER_PTP_V2_L4_SYNC:
>> @@ -2680,7 +2690,7 @@ static int gbe_hwtstamp_set(struct gbe_intf *gbe_intf,
>> struct ifreq *ifr) case HWTSTAMP_FILTER_PTP_V2_SYNC:
>>   	case HWTSTAMP_FILTER_PTP_V2_DELAY_REQ:
>>   		gbe_dev->rx_ts_enabled = HWTSTAMP_FILTER_PTP_V2_EVENT;
>> -		cfg.rx_filter = HWTSTAMP_FILTER_PTP_V2_EVENT;
>> +		cfg->rx_filter = HWTSTAMP_FILTER_PTP_V2_EVENT;
>>   		break;
>>   	default:
>>   		return -ERANGE;
>> @@ -2688,7 +2698,7 @@ static int gbe_hwtstamp_set(struct gbe_intf *gbe_intf,
>> struct ifreq *ifr)
>>   	gbe_hwtstamp(gbe_intf);
>>   
>> -	return copy_to_user(ifr->ifr_data, &cfg, sizeof(cfg)) ? -EFAULT : 0;
>> +	return 0;
>>   }
>>   
>>   static void gbe_register_cpts(struct gbe_priv *gbe_dev)
>> @@ -2745,12 +2755,15 @@ static inline void gbe_unregister_cpts(struct
>> gbe_priv *gbe_dev) {
>>   }
>>   
>> -static inline int gbe_hwtstamp_get(struct gbe_intf *gbe_intf, struct ifreq
>> *req) +static inline int gbe_hwtstamp_get(struct gbe_intf *gbe_intf,
>> +				   struct kernel_hwtstamp_config *cfg)
>>   {
>>   	return -EOPNOTSUPP;
>>   }
>>   
>> -static inline int gbe_hwtstamp_set(struct gbe_intf *gbe_intf, struct ifreq
>> *req) +static inline int gbe_hwtstamp_set(struct gbe_intf *gbe_intf,
>> +				   struct kernel_hwtstamp_config *cfg,
>> +				   struct netlink_ext_ack *extack)
>>   {
>>   	return -EOPNOTSUPP;
>>   }
>> @@ -2816,15 +2829,6 @@ static int gbe_ioctl(void *intf_priv, struct ifreq
>> *req, int cmd) struct gbe_intf *gbe_intf = intf_priv;
>>   	struct phy_device *phy = gbe_intf->slave->phy;
>>   
>> -	if (!phy_has_hwtstamp(phy)) {
>> -		switch (cmd) {
>> -		case SIOCGHWTSTAMP:
>> -			return gbe_hwtstamp_get(gbe_intf, req);
>> -		case SIOCSHWTSTAMP:
>> -			return gbe_hwtstamp_set(gbe_intf, req);
>> -		}
>> -	}
>> -
>>   	if (phy)
>>   		return phy_mii_ioctl(phy, req, cmd);
>>   
>> @@ -3824,6 +3828,8 @@ static struct netcp_module gbe_module = {
>>   	.add_vid	= gbe_add_vid,
>>   	.del_vid	= gbe_del_vid,
>>   	.ioctl		= gbe_ioctl,
>> +	.hwtstamp_get	= gbe_hwtstamp_get,
>> +	.hwtstamp_set	= gbe_hwtstamp_set,
>>   };
>>   
>>   static struct netcp_module xgbe_module = {
>> @@ -3841,6 +3847,8 @@ static struct netcp_module xgbe_module = {
>>   	.add_vid	= gbe_add_vid,
>>   	.del_vid	= gbe_del_vid,
>>   	.ioctl		= gbe_ioctl,
>> +	.hwtstamp_get	= gbe_hwtstamp_get,
>> +	.hwtstamp_set	= gbe_hwtstamp_set,
>>   };
>>   
>>   static int __init keystone_gbe_init(void)
> 
> 
> 


