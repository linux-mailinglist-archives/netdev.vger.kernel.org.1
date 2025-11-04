Return-Path: <netdev+bounces-235460-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E7EC30F33
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 13:18:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E7A9C4EAE50
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 12:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E692D2459E5;
	Tue,  4 Nov 2025 12:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tjGegJDL"
X-Original-To: netdev@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1469329BD96
	for <netdev@vger.kernel.org>; Tue,  4 Nov 2025 12:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762258546; cv=none; b=QKiMME26pHWFI0+wWsCp3tMrP1O195G5lungu6Pido6OolzI7u+JlQgYZHl0LoOvGck1WlFuH1SSQtvT+f1mWh2aRIrMx9dVIuB0Re2abyt4LEepcKjUQgSysIc+b55sENI51NiXTgoyyvgu2f/uKgQej50NVebHrqUBVuHfbV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762258546; c=relaxed/simple;
	bh=Duvxq30qPDdYltTs0mSXj+JzKqC0iiP4GqSiSJLAZXY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PAlgORPv6htQEByKHzxCndU6zrTIbmzX/ga4lt7lcQyfprlHFmqTQNUJZ/iQdRNv2qdSqlZJ4T14V1xk1OChlUyM2cVeUJlqdedJhSdcka9m9ObIs7dOS+1WT9DIDFVRr1qK7K8q9BjsKejsrb4+6t/MzQKLP68JwnyEl6PhXb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tjGegJDL; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <afbddc5a-c051-4e45-9d4f-79d4543f6529@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762258541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BTjEtZhc8fgNW9a1vq70MN65ZMhTpw/MYK7PO3kTFIA=;
	b=tjGegJDLXtKTgq9Zj3QWjhK91p5V+jONjK9wmVt5CO9Zk8Z3qxcHPUKS5w5mbpZPiNLj4d
	jCtF2HJeIxBEXN0IE2Dtl8WH3Rb4kuPP64AQNguzz1QvSG7Kl/LmZiwWz/Y4Cchtr/5Jv6
	yXITQYONaiMKryfjE8O8IVz+VSecJhE=
Date: Tue, 4 Nov 2025 12:15:32 +0000
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
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20251103215240.7057f8cb@kmaincent-XPS-13-7390>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 03/11/2025 20:52, Kory Maincent wrote:
> On Mon,  3 Nov 2025 17:29:02 +0000
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
>>
>> There are only 2 modules using netcp core infrastructure, and both use
>> the very same function to configure HW timestamping, so no actual
>> difference in behavior is expected.
>>
>> Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
>> ---
>> v1 -> v2:
>> - avoid changing logic and hiding errors. keep the call failing after
>>    the first error
>> ---
> 
> ...
> 
>> +
>> +	for_each_module(netcp, intf_modpriv) {
>> +		module = intf_modpriv->netcp_module;
>> +		if (!module->hwtstamp_set)
>> +			continue;
>> +
>> +		err = module->hwtstamp_set(intf_modpriv->module_priv, config,
>> +					   extack);
>> +		if ((err < 0) && (err != -EOPNOTSUPP)) {
>> +			NL_SET_ERR_MSG_WEAK_MOD(extack,
>> +						"At least one module failed
>> to setup HW timestamps");
>> +			ret = err;
>> +			goto out;
> 
> Why don't you use break.

That's the original code, I tried to make as less changes as possible

> 
>> +		}
>> +		if (err == 0)
>> +			ret = err;
>> +	}
>> +
>> +out:
>> +	return (ret == 0) ? 0 : err;
>> +}
>> +
> 
> ...
> 
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
> Sorry to come back to this but the choice of using PHY or MAC timestamping is
> done in the core. Putting this here may conflict with the core.
> I know this driver has kind of a weird PHYs management through slave
> description but we shouldn't let the MAC driver call the PHY hwtstamp ops.
> If there is indeed an issue due to the weird development of this driver, people
> will write a patch specifically tackling this issue and maybe (by luck)
> refactoring this driver.
> 
> Anyway, this was not in the driver before, so I think we should not make this
> change in this patch.

Well, that was actually in the original code:

static int gbe_ioctl(void *intf_priv, struct ifreq *req, int cmd)
{
         struct gbe_intf *gbe_intf = intf_priv;
         struct phy_device *phy = gbe_intf->slave->phy;

         if (!phy_has_hwtstamp(phy)) {
                 switch (cmd) {
                 case SIOCGHWTSTAMP:
                         return gbe_hwtstamp_get(gbe_intf, req);
                 case SIOCSHWTSTAMP:
                         return gbe_hwtstamp_set(gbe_intf, req);
                 }
         }

         if (phy)
                 return phy_mii_ioctl(phy, req, cmd);

         return -EOPNOTSUPP;
}

SIOCGHWTSTAMP/SIOCSHWTSTAMP were sent to gbe functions only when there
was no support for hwtstamps on phy layer. The original flow of the call
is:

netcp_ndo_ioctl -> gbe_ioctl -> gbe_hwtstamp_*/phy_mii_ioctl

where netcp_ndo_ioctl operating over netdev while other function
operating with other objects, with phy taken from gbe_intf.

Checking on init part of phy devices, I found that the only phydev
allocated structure is stored in gbe_slave object, which is definitely
not accessible from the core. I haven't found any assignments to
net_device->phydev in neither netcp_core.c nor netcp_ethss.c.
Even though there are checks for some phy functions from netdev->phydev
in RX and TX paths, I'm not quite sure it works properly.

I decided to keep the original logic here with checking phy from
gbe_intf->slave.


