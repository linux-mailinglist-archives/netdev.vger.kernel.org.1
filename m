Return-Path: <netdev+bounces-94822-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20F448C0C80
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 10:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 449ED1C20A44
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 08:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD23113B5A9;
	Thu,  9 May 2024 08:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="ZywfUE0j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB1FD528
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 08:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715243074; cv=none; b=g+G7TQjVqrgjSjsFolPytMP7xrftG0jEgUQYsQB1k8SatUO8jPPDk5K1jExmoNxWHJ5qbjwQMZV9r4alMBGn8ctwD/GpyLDJ42s/Uj9wGiNVhPpEenymbFdcfOEoiQUscEQ/EtZIWzDLmMJ3XVT0k1p0oobo1fVt7K/NFi1lwg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715243074; c=relaxed/simple;
	bh=zmVx3rNKuLnJ2Wlwq8EcKeHd5L/7YRHK+ReT9/TwfuE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W1kItg5BMwGkRNaVOxVWxaJBcfkQ9OR3YZdTDKwCujOVH3TdvNipUlULsair7Bz/HGjhTB4joQfMCCD5H1k5oXyGf3gfwDDc5cPUSmi5wDfhqO4wDqM3go+Pt703Y86QontVhB7rpVGFRSR8dP6W+1LKKDGy2Myes5ZiHKrHHKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=ZywfUE0j; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-349545c3eb8so324800f8f.2
        for <netdev@vger.kernel.org>; Thu, 09 May 2024 01:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1715243070; x=1715847870; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=R5ypNlPhNqmmdIPprtNarw6csoNiCVV8u16iqX+HW5Y=;
        b=ZywfUE0jamj/dTOCUiX7OWA8HomhvlBBXbbufj9DYlSKoYGCNxYZ4OQgcldj4/1V/S
         Of+Bhd7Nq/5EpfTgsCeWn7mIE9wMD6WajiPCAzkshbTkC+e2jfu8Ie5DHArPUtO2aPCv
         m0ijE2EhnUxNp5RQASfQgk0rEv2ihBYBuHm+cYe+CYRx431CYCB2lhGdqukvH4fCHLPz
         JNTVfHxtzKmdl9kuuJ/VSF0ZUCCO8Dnf6nW/5Lrj4em9c7RXKZsB37kdGfmaHKlcDDla
         Z+BaEkLsHK/MTcttUtyVTwXGld/3+XeppuUwSAdYKf8tqc+k+bxcTKH0rDoeGgXMK+lN
         Eu+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715243070; x=1715847870;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R5ypNlPhNqmmdIPprtNarw6csoNiCVV8u16iqX+HW5Y=;
        b=s2Ay/KeS6/3UhKui3Dbp3759uEpzh4iaw8Zcv8mY5nH3b602lfeJGkco0NJAOKQ7X4
         kq2RxM7GhLFEkrUKdeltTcfJK5hfd0a0hQkzxg+qvzcpF1WSSBq6Jy8elkgGvU2cflUp
         wOXdWM1HY2kIod6UE1DzGYh0h10m1WrLBKtQIFbPkqt5UeCsQvE7pe58jl7uQizr2e8j
         X112uDFrnGNnKRKtxbbqq+r3q7WsshtyrNg1OHcehft4/KwsH/jUIzcCiQVSZGrn1x0T
         yInxLUFMVNGpN+hhprxbb7QQIYjNy6UEJ9b/QgA7hpOyfqXe7wwjR95FaRgCwcnXBoyb
         1DTw==
X-Gm-Message-State: AOJu0Yyaf2DQlzxFXqv4vj/y6zDHXS8ie3uh/AhJ8c2r6HqrpwpFI+94
	qiezQciMJiln6RbZommsJF866ceCcfATHRqIPY4TD3QRs2Fw5DZ2hBLrNCadp+lq1l2Dk7xJ7Qc
	u
X-Google-Smtp-Source: AGHT+IE/DlaSIUPKp85cyGvZT0OFokF2QGP0tuZEXUHsoKDTEzNm8hJ3pdT4uoreLk6Kub8JYi8r1Q==
X-Received: by 2002:adf:e484:0:b0:33e:800d:e87a with SMTP id ffacd0b85a97d-34fcafcdb91mr4371658f8f.34.1715243069529;
        Thu, 09 May 2024 01:24:29 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:0:6fcd:499b:c37e:9a0? ([2001:67c:2fbc:0:6fcd:499b:c37e:9a0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502baacff4sm1040852f8f.79.2024.05.09.01.24.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 May 2024 01:24:28 -0700 (PDT)
Message-ID: <b6a6c29b-ad78-4d6f-be1a-93615f27c956@openvpn.net>
Date: Thu, 9 May 2024 10:25:44 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 04/24] ovpn: add basic interface
 creation/destruction/management routines
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Sergey Ryazanov <ryazanov.s.a@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew@lunn.ch>,
 Esben Haabendal <esben@geanix.com>
References: <20240506011637.27272-1-antonio@openvpn.net>
 <20240506011637.27272-5-antonio@openvpn.net> <ZjuRqyZB0kMINqme@hog>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <ZjuRqyZB0kMINqme@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08/05/2024 16:52, Sabrina Dubroca wrote:
> 2024-05-06, 03:16:17 +0200, Antonio Quartulli wrote:
>> diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
>> index ad3813419c33..338e99dfe886 100644
>> --- a/drivers/net/ovpn/io.c
>> +++ b/drivers/net/ovpn/io.c
>> @@ -11,6 +11,26 @@
>>   #include <linux/skbuff.h>
>>   
>>   #include "io.h"
>> +#include "ovpnstruct.h"
>> +#include "netlink.h"
>> +
>> +int ovpn_struct_init(struct net_device *dev)
> 
> nit: Should this be in main.c? It's only used there, and I think it
> would make more sense to drop it next to ovpn_struct_free.

yeah, it makes sense. will move it.

> 
>> +{
>> +	struct ovpn_struct *ovpn = netdev_priv(dev);
>> +	int err;
>> +
> 
> [...]
>> diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
>> index 33c0b004ce16..584cd7286aff 100644
>> --- a/drivers/net/ovpn/main.c
>> +++ b/drivers/net/ovpn/main.c
> [...]
>> +static void ovpn_struct_free(struct net_device *net)
>> +{
>> +	struct ovpn_struct *ovpn = netdev_priv(net);
>> +
>> +	rtnl_lock();
> 
>   ->priv_destructor can run from register_netdevice (already under
> RTNL), this doesn't look right.
> 
>> +	list_del(&ovpn->dev_list);
> 
> And if this gets called from register_netdevice, the list_add from
> ovpn_iface_create hasn't run yet, so this will probably do strange
> things?

Argh, again I haven't considered a failure in register_netdevice and you 
are indeed right.

Maybe it is better to call list_del() in the netdev notifier, upon 
NETDEV_UNREGISTER event?


> 
>> +	rtnl_unlock();
>> +
>> +	free_percpu(net->tstats);
>> +}
>> +
>> +static int ovpn_net_open(struct net_device *dev)
>> +{
>> +	struct in_device *dev_v4 = __in_dev_get_rtnl(dev);
>> +
>> +	if (dev_v4) {
>> +		/* disable redirects as Linux gets confused by ovpn handling
>> +		 * same-LAN routing
>> +		 */
>> +		IN_DEV_CONF_SET(dev_v4, SEND_REDIRECTS, false);
>> +		IPV4_DEVCONF_ALL(dev_net(dev), SEND_REDIRECTS) = false;
> 
> Jakub, are you ok with that? This feels a bit weird to have in the
> middle of a driver.

Let me share what the problem is (copied from the email I sent to Andrew 
Lunn as he was also curious about this):

The reason for requiring this setting lies in the OpenVPN server acting 
as relay point (star topology) for hosts in the same subnet.

Example: given the a.b.c.0/24 IP network, you have .2 that in order to 
talk to .3 must have its traffic relayed by .1 (the server).

When the kernel (at .1) sees this traffic it will send the ICMP 
redirects, because it believes that .2 should directly talk to .3 
without passing through .1.

Of course it makes sense in a normal network with a classic broadcast 
domain, but this is not the case in a VPN implemented as a star topology.

Does it make sense?

The only way I see to fix this globally is to have an extra flag in the 
netdevice signaling this peculiarity and thus disabling ICMP redirects 
automatically.

Note: wireguard has those lines too, as it probably needs to address the 
same scenario.


> 
>> +	}
>> +
>> +	netif_tx_start_all_queues(dev);
>> +	return 0;
>> +}
> 
> [...]
>> +void ovpn_iface_destruct(struct ovpn_struct *ovpn)
>> +{
>> +	ASSERT_RTNL();
>> +
>> +	netif_carrier_off(ovpn->dev);
>> +
>> +	ovpn->registered = false;
>> +
>> +	unregister_netdevice(ovpn->dev);
>> +	synchronize_net();
> 
> If this gets called from the loop in ovpn_netns_pre_exit, one
> synchronize_net per ovpn device would seem quite expensive.

As per your other comment, maybe I should just remove the 
synchronize_net() entirely since it'll be the core to take care of 
inflight packets?

> 
>> +}
>> +
>>   static int ovpn_netdev_notifier_call(struct notifier_block *nb,
>>   				     unsigned long state, void *ptr)
>>   {
>>   	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
>> +	struct ovpn_struct *ovpn;
>>   
>>   	if (!ovpn_dev_is_valid(dev))
>>   		return NOTIFY_DONE;
>>   
>> +	ovpn = netdev_priv(dev);
>> +
>>   	switch (state) {
>>   	case NETDEV_REGISTER:
>> -		/* add device to internal list for later destruction upon
>> -		 * unregistration
>> -		 */
>> +		ovpn->registered = true;
>>   		break;
>>   	case NETDEV_UNREGISTER:
>> +		/* twiddle thumbs on netns device moves */
>> +		if (dev->reg_state != NETREG_UNREGISTERING)
>> +			break;
>> +
>>   		/* can be delivered multiple times, so check registered flag,
>>   		 * then destroy the interface
>>   		 */
>> +		if (!ovpn->registered)
>> +			return NOTIFY_DONE;
>> +
>> +		ovpn_iface_destruct(ovpn);
> 
> Maybe I'm misunderstanding this code. Why do you want to manually
> destroy a device that is already going away?

We need to perform some internal cleanup (i.e. release all peers).
I don't see how this can happen automatically, no?

> 
>>   		break;
>>   	case NETDEV_POST_INIT:
>>   	case NETDEV_GOING_DOWN:
>>   	case NETDEV_DOWN:
>>   	case NETDEV_UP:
>>   	case NETDEV_PRE_UP:
>> +		break;
>>   	default:
>>   		return NOTIFY_DONE;
>>   	}
>> @@ -62,6 +210,24 @@ static struct notifier_block ovpn_netdev_notifier = {
>>   	.notifier_call = ovpn_netdev_notifier_call,
>>   };
>>   
>> +static void ovpn_netns_pre_exit(struct net *net)
>> +{
>> +	struct ovpn_struct *ovpn;
>> +
>> +	rtnl_lock();
>> +	list_for_each_entry(ovpn, &dev_list, dev_list) {
>> +		if (dev_net(ovpn->dev) != net)
>> +			continue;
>> +
>> +		ovpn_iface_destruct(ovpn);
> 
> Is this needed? On netns destruction all devices within the ns will be
> destroyed by the networking core.

Before implementing ovpn_netns_pre_exit() this way, upon namespace 
deletion the ovpn interface was being moved to the global namespace.

Hence I decided to manually take care of its destruction.

Isn't this expected?

-- 
Antonio Quartulli
OpenVPN Inc.

