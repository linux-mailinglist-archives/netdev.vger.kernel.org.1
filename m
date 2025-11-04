Return-Path: <netdev+bounces-235487-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A634FC315DD
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 15:02:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 719C818C4FCD
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 14:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6924432D443;
	Tue,  4 Nov 2025 13:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cq6/75Vd"
X-Original-To: netdev@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C83032937D
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 13:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762264782; cv=none; b=kfvRrkvB9LfNCcs/COdLFQGFw21TqNx1mfZ2ltbTReE2lVXPAhMuVbcnaRdw1HFkzuZjXZK7G2yk/SYNWjoyfYML89ZvYlCrhyW+zonprqIMA89CxVx4W854KCXWMNVUUdPbvnfWf2jakq5fo5ZM1jACHIKEHZ9g8kEs5NSMGsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762264782; c=relaxed/simple;
	bh=R1wooKHbXzOtLiN5EIgFNDW8QIT6oz3v7w9tg42wYj4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bmPzIwtVFaMp4JtPjvECYda5teEVjiYDwE41lCC0sKCKVRKeD20SyGWfiYXR6f7KYDV3eDMa0/oAxd9ezfoohOYoXNFgDUSXvJVxFn8CcQRY/oFjkKyncmmcm2rbfgx48BCgqv1Pz+jdTh5zbadF8K+n3s9KO+ru1qSn92TKRjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cq6/75Vd; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0a030e1e-bb2b-4c32-96ad-3f9f0890f1a1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762264773;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jq1jL46bRnb7eNkLikPyy2/L/xf+mAza+HTcG2zHlzs=;
	b=cq6/75Vdg9AOUyUzgqJFwUaB3/RbVN4FDPKY4WjTzAGNz+sggKi2YeliAw2twTyefPyScE
	4Tx2r3QSqqPZXjvQfQAzfanuNNkjcCFjk8n29pqRmpgErPqJufItMA3gbcjBa6VtTYDtbj
	VyO76PsJ4o/iC/TdoZLOscOlL30Kugg=
Date: Tue, 4 Nov 2025 13:59:28 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v2] ti: netcp: convert to ndo_hwtstamp callbacks
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, Vladimir Oltean <vladimir.oltean@nxp.com>
References: <20251103172902.3538392-1-vadim.fedorenko@linux.dev>
 <20251103215240.7057f8cb@kmaincent-XPS-13-7390>
 <afbddc5a-c051-4e45-9d4f-79d4543f6529@linux.dev>
 <20251104143901.5f030fa9@kmaincent-XPS-13-7390>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20251104143901.5f030fa9@kmaincent-XPS-13-7390>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 04/11/2025 13:39, Kory Maincent wrote:
> On Tue, 4 Nov 2025 12:15:32 +0000
> Vadim Fedorenko <vadim.fedorenko@linux.dev> wrote:
> 
>> On 03/11/2025 20:52, Kory Maincent wrote:
>>> On Mon,  3 Nov 2025 17:29:02 +0000
>>> Vadim Fedorenko <vadim.fedorenko@linux.dev> wrote:
>>>    
>>>> Convert TI NetCP driver to use ndo_hwtstamp_get()/ndo_hwtstamp_set()
>>>> callbacks. The logic is slightly changed, because I believe the original
>>>> logic was not really correct. Config reading part is using the very
>>>> first module to get the configuration instead of iterating over all of
>>>> them and keep the last one as the configuration is supposed to be identical
>>>> for all modules. HW timestamp config set path is now trying to configure
>>>> all modules, but in case of error from one module it adds extack
>>>> message. This way the configuration will be as synchronized as possible.
>>>>
>>>> There are only 2 modules using netcp core infrastructure, and both use
>>>> the very same function to configure HW timestamping, so no actual
>>>> difference in behavior is expected.
>>>>
>>>> Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
>>>> ---
>>>> v1 -> v2:
>>>> - avoid changing logic and hiding errors. keep the call failing after
>>>>     the first error
>>>> ---
>>>
>>> ...
>>>    
>>>> +
>>>> +	for_each_module(netcp, intf_modpriv) {
>>>> +		module = intf_modpriv->netcp_module;
>>>> +		if (!module->hwtstamp_set)
>>>> +			continue;
>>>> +
>>>> +		err = module->hwtstamp_set(intf_modpriv->module_priv,
>>>> config,
>>>> +					   extack);
>>>> +		if ((err < 0) && (err != -EOPNOTSUPP)) {
>>>> +			NL_SET_ERR_MSG_WEAK_MOD(extack,
>>>> +						"At least one module
>>>> failed to setup HW timestamps");
>>>> +			ret = err;
>>>> +			goto out;
>>>
>>> Why don't you use break.
>>
>> That's the original code, I tried to make as less changes as possible
>>
>>>    
>>>> +		}
>>>> +		if (err == 0)
>>>> +			ret = err;
>>>> +	}
>>>> +
>>>> +out:
>>>> +	return (ret == 0) ? 0 : err;
>>>> +}
>>>> +
>>>
>>> ...
>>>    
>>>> -static int gbe_hwtstamp_set(struct gbe_intf *gbe_intf, struct ifreq *ifr)
>>>> +static int gbe_hwtstamp_set(void *intf_priv, struct kernel_hwtstamp_config
>>>> *cfg,
>>>> +			    struct netlink_ext_ack *extack)
>>>>    {
>>>> -	struct gbe_priv *gbe_dev = gbe_intf->gbe_dev;
>>>> -	struct cpts *cpts = gbe_dev->cpts;
>>>> -	struct hwtstamp_config cfg;
>>>> +	struct gbe_intf *gbe_intf = intf_priv;
>>>> +	struct gbe_priv *gbe_dev;
>>>> +	struct phy_device *phy;
>>>>    
>>>> -	if (!cpts)
>>>> +	gbe_dev = gbe_intf->gbe_dev;
>>>> +
>>>> +	if (!gbe_dev->cpts)
>>>>    		return -EOPNOTSUPP;
>>>>    
>>>> -	if (copy_from_user(&cfg, ifr->ifr_data, sizeof(cfg)))
>>>> -		return -EFAULT;
>>>> +	phy = gbe_intf->slave->phy;
>>>> +	if (phy_has_hwtstamp(phy))
>>>> +		return phy->mii_ts->hwtstamp(phy->mii_ts, cfg, extack);
>>>
>>> Sorry to come back to this but the choice of using PHY or MAC timestamping
>>> is done in the core. Putting this here may conflict with the core.
>>> I know this driver has kind of a weird PHYs management through slave
>>> description but we shouldn't let the MAC driver call the PHY hwtstamp ops.
>>> If there is indeed an issue due to the weird development of this driver,
>>> people will write a patch specifically tackling this issue and maybe (by
>>> luck) refactoring this driver.
>>>
>>> Anyway, this was not in the driver before, so I think we should not make
>>> this change in this patch.
>>
>> Well, that was actually in the original code:
> 
> Oh indeed, sorry, I missed that.
>   
>> static int gbe_ioctl(void *intf_priv, struct ifreq *req, int cmd)
>> {
>>           struct gbe_intf *gbe_intf = intf_priv;
>>           struct phy_device *phy = gbe_intf->slave->phy;
>>
>>           if (!phy_has_hwtstamp(phy)) {
>>                   switch (cmd) {
>>                   case SIOCGHWTSTAMP:
>>                           return gbe_hwtstamp_get(gbe_intf, req);
>>                   case SIOCSHWTSTAMP:
>>                           return gbe_hwtstamp_set(gbe_intf, req);
>>                   }
>>           }
>>
>>           if (phy)
>>                   return phy_mii_ioctl(phy, req, cmd);
>>
>>           return -EOPNOTSUPP;
>> }
>>
>> SIOCGHWTSTAMP/SIOCSHWTSTAMP were sent to gbe functions only when there
>> was no support for hwtstamps on phy layer. The original flow of the call
>> is:
>>
>> netcp_ndo_ioctl -> gbe_ioctl -> gbe_hwtstamp_*/phy_mii_ioctl
>>
>> where netcp_ndo_ioctl operating over netdev while other function
>> operating with other objects, with phy taken from gbe_intf.
>>
>> Checking on init part of phy devices, I found that the only phydev
>> allocated structure is stored in gbe_slave object, which is definitely
>> not accessible from the core. I haven't found any assignments to
>> net_device->phydev in neither netcp_core.c nor netcp_ethss.c.
>> Even though there are checks for some phy functions from netdev->phydev
>> in RX and TX paths, I'm not quite sure it works properly.
>>
>> I decided to keep the original logic here with checking phy from
>> gbe_intf->slave.
> 
> Ok. I still think this may conflict when associated to a PHY that support
> hwtstamp, but if you keep the old logic then it is ok to me. Someone will fix
> it when the case appear. FYI you could use the phy_hwtstamp() helper
> instead of phy->mii_ts->hwtstamp(). Relevant in case of v3.

Sure, good catch. I'll change it if v3 is needed

> 
> Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>
> 
> Thank you!
> 
> Regards,


