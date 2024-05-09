Return-Path: <netdev+bounces-94864-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 29FB98C0E3C
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 12:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 907DEB206B0
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 10:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1785339A;
	Thu,  9 May 2024 10:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="Hky6GU0U"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3088E1361
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 10:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715250861; cv=none; b=Qu0hnN3JDvNLJ+GN79j6o2elwMjPkC+OShkuknPGPP5qJXGAhAcyyM8bUmBdUL8zKqU0Ri3ZBdmdA+KOMH4k6j6Ib0eCLFa49/lFibw+L33UJLLqIIxrDm32I82Yh3qhKrMs3Af5RUY4bZ2ixuzXb49sylU7Nb/5T3+vkQl7Z0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715250861; c=relaxed/simple;
	bh=Ycz4hbL0W7i4gLuTJhJbHszP0Jez67146UQpLWNs5F8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BdPOaoFsf4Cx9iVnWB3ZrHewiMqmZDwjqnsVZj7P0s8PWmgvdJ4zadLsvWR8g4uCfkFiNfJb7s97S2pmaR/kXfbNkAKvArGBPx2FdotEPT9lOZt1XyvdYTmMxy9tb1eDGSX7UmkuewttJeO9iD1qLYg2g6PnOMmjrL9FwTZkA9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=Hky6GU0U; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-34db6a29998so442667f8f.0
        for <netdev@vger.kernel.org>; Thu, 09 May 2024 03:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1715250857; x=1715855657; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mg41IsWhkVbLWM4ti3OkDr2GTfJRNZnEB7yLlcVaHm4=;
        b=Hky6GU0UZ5AqONrzf6rLp3ScK152+wM1YCdPz//Ycj4k6tKtPi1eJgXCL3x3k32mf2
         GOa9L55JXgrzer8NVuVYuxyludgtpj4EhV9mINEeFQiNh9p3TEZHKTDLj3uFjtMl2K2A
         hP9kuF/WBY3ZQ6IKTj6NQVHH1oz0+9RxpvbiB7fVn+DFG94kzsXrkZWxtYBLDNlWjbKO
         bptXNUcc88elA4MJGAaJakerl70cKFLtAMntS3lHyXx1q4gREXNces6Stvueb1MakKwd
         AHrzmBateK2l48PvYm1IlK3adfCOIrKiweU9q5lA1tQEVc5EJChFH9OYKP0LK6Sn1Smt
         cGog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715250857; x=1715855657;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mg41IsWhkVbLWM4ti3OkDr2GTfJRNZnEB7yLlcVaHm4=;
        b=f95dQ207YqLgiyvhmHiki4R6ndhFY52wec1IF4g/mcRHl38KThjSff+4YtTVBj0H8p
         9h0Rs7RFhm2L4Pp2ufm5Vr1wJIsd+8LjZ+NUVGhctXJBskXTg20FM80Y0vLpdazDq3i2
         YMKJPiK8MWIQNfBJDZlkPuJ8Ee0bYp6KaXNhTuJSeaMZFoN7toXSCzgq3R7fal5ORQQr
         ACtnGsvHaqBIq8rKFpvwTeHtBIlmebT7Sj1UhONvLXuHcvXl5vChGyszk16Pwctw0fBR
         3hKEEjsMYSa3Jq2VctFQkhbfBhCnFLFOJJYoDfWQyTZU2l7ZVY7p+mv/Yf/29K6xHAmb
         BWLg==
X-Gm-Message-State: AOJu0YwOJjPCuFD/oUBRxk+CyAsDjrF3mKCe/Zz4cWfNgCR9FALymI4r
	q27NwAdHLR3aLBh5KsxJA81XP8zvGGlpw2GjluO5DNwni7Wo3rnONyXR1pfWul0=
X-Google-Smtp-Source: AGHT+IE04giasXZ9anjB7dZH+sZhPOEYxhTrj/992+uhxidTAsnZSrwpSM9oOcLVdYloFk91lWBk3Q==
X-Received: by 2002:a05:6000:230:b0:34c:d5e8:faad with SMTP id ffacd0b85a97d-34fca80ea6amr3230749f8f.58.1715250857284;
        Thu, 09 May 2024 03:34:17 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:0:6fcd:499b:c37e:9a0? ([2001:67c:2fbc:0:6fcd:499b:c37e:9a0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502bbbc35asm1333386f8f.109.2024.05.09.03.34.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 May 2024 03:34:16 -0700 (PDT)
Message-ID: <1d31ca80-055e-4601-91b6-b0dc38b721c7@openvpn.net>
Date: Thu, 9 May 2024 12:35:32 +0200
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
 <b6a6c29b-ad78-4d6f-be1a-93615f27c956@openvpn.net> <ZjygvCgXFfrA4GRN@hog>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <ZjygvCgXFfrA4GRN@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09/05/2024 12:09, Sabrina Dubroca wrote:
> 2024-05-09, 10:25:44 +0200, Antonio Quartulli wrote:
>> On 08/05/2024 16:52, Sabrina Dubroca wrote:
>>> 2024-05-06, 03:16:17 +0200, Antonio Quartulli wrote:
>>>> diff --git a/drivers/net/ovpn/main.c b/drivers/net/ovpn/main.c
>>>> index 33c0b004ce16..584cd7286aff 100644
>>>> --- a/drivers/net/ovpn/main.c
>>>> +++ b/drivers/net/ovpn/main.c
>>> [...]
>>>> +static void ovpn_struct_free(struct net_device *net)
>>>> +{
>>>> +	struct ovpn_struct *ovpn = netdev_priv(net);
>>>> +
>>>> +	rtnl_lock();
>>>
>>>    ->priv_destructor can run from register_netdevice (already under
>>> RTNL), this doesn't look right.
>>>
>>>> +	list_del(&ovpn->dev_list);
>>>
>>> And if this gets called from register_netdevice, the list_add from
>>> ovpn_iface_create hasn't run yet, so this will probably do strange
>>> things?
>>
>> Argh, again I haven't considered a failure in register_netdevice and you are
>> indeed right.
>>
>> Maybe it is better to call list_del() in the netdev notifier, upon
>> NETDEV_UNREGISTER event?
> 
> I'd like to avoid splitting the clean up code over so maybe different
> functions and called through different means. Keep it simple.
> 
> AFAICT the only reason you need this list is to delete your devices on
> netns exit, so if we can get rid of that the list can go away.

right.

> 
> 
>>>> +static int ovpn_net_open(struct net_device *dev)
>>>> +{
>>>> +	struct in_device *dev_v4 = __in_dev_get_rtnl(dev);
>>>> +
>>>> +	if (dev_v4) {
>>>> +		/* disable redirects as Linux gets confused by ovpn handling
>>>> +		 * same-LAN routing
>>>> +		 */
>>>> +		IN_DEV_CONF_SET(dev_v4, SEND_REDIRECTS, false);
>>>> +		IPV4_DEVCONF_ALL(dev_net(dev), SEND_REDIRECTS) = false;
>>>
>>> Jakub, are you ok with that? This feels a bit weird to have in the
>>> middle of a driver.
>>
>> Let me share what the problem is (copied from the email I sent to Andrew
>> Lunn as he was also curious about this):
>>
>> The reason for requiring this setting lies in the OpenVPN server acting as
>> relay point (star topology) for hosts in the same subnet.
>>
>> Example: given the a.b.c.0/24 IP network, you have .2 that in order to talk
>> to .3 must have its traffic relayed by .1 (the server).
>>
>> When the kernel (at .1) sees this traffic it will send the ICMP redirects,
>> because it believes that .2 should directly talk to .3 without passing
>> through .1.
> 
> So only the server would need to stop sending them, not the client?

correct

> (or the client would need to ignore them)
> But the kernel has no way of knowing if an ovpn device is on a client
> or a server?

the server knows if the interface is configured in P2P or MP (MultiPeer) 
mode. The latter is what requires redirects to be off, so we could at 
least add a check and switch them off only for MP ifaces.

> 
>> Of course it makes sense in a normal network with a classic broadcast
>> domain, but this is not the case in a VPN implemented as a star topology.
>>
>> Does it make sense?
> 
> It looks like the problem is that ovpn links are point-to-point
> (instead of a broadcast LAN kind of link where redirects would make
> sense), and the kernel doesn't handle it that way.

exactly

> 
>> The only way I see to fix this globally is to have an extra flag in the
>> netdevice signaling this peculiarity and thus disabling ICMP redirects
>> automatically.
>>
>> Note: wireguard has those lines too, as it probably needs to address the
>> same scenario.
> 
> I've noticed a lot of similarities in some bits I've looked at, and I
> hate that this is turning into another pile of duplicate code like
> vxlan/geneve, bond/team, etc :(

For starters, we could at least moves these few lines in some helper 
function and call it from both modules.

On the other hand, we could, like I suggested above, convert this into a 
netdev flag and let core handle the behaviour when the flag is set.

> 
> 
>>> [...]
>>>> +void ovpn_iface_destruct(struct ovpn_struct *ovpn)
>>>> +{
>>>> +	ASSERT_RTNL();
>>>> +
>>>> +	netif_carrier_off(ovpn->dev);
>>>> +
>>>> +	ovpn->registered = false;
>>>> +
>>>> +	unregister_netdevice(ovpn->dev);
>>>> +	synchronize_net();
>>>
>>> If this gets called from the loop in ovpn_netns_pre_exit, one
>>> synchronize_net per ovpn device would seem quite expensive.
>>
>> As per your other comment, maybe I should just remove the synchronize_net()
>> entirely since it'll be the core to take care of inflight packets?
> 
> There's a synchronize_net in unregister_netdevice_many_notify, so I'd
> say you can get rid of it here.

ok! Jakub was indeed suggesting that core should already take care of this.

Will remove it for good.

> 
> 
>>>>    static int ovpn_netdev_notifier_call(struct notifier_block *nb,
>>>>    				     unsigned long state, void *ptr)
>>>>    {
>>>>    	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
>>>> +	struct ovpn_struct *ovpn;
>>>>    	if (!ovpn_dev_is_valid(dev))
>>>>    		return NOTIFY_DONE;
>>>> +	ovpn = netdev_priv(dev);
>>>> +
>>>>    	switch (state) {
>>>>    	case NETDEV_REGISTER:
>>>> -		/* add device to internal list for later destruction upon
>>>> -		 * unregistration
>>>> -		 */
>>>> +		ovpn->registered = true;
>>>>    		break;
>>>>    	case NETDEV_UNREGISTER:
>>>> +		/* twiddle thumbs on netns device moves */
>>>> +		if (dev->reg_state != NETREG_UNREGISTERING)
>>>> +			break;
>>>> +
>>>>    		/* can be delivered multiple times, so check registered flag,
>>>>    		 * then destroy the interface
>>>>    		 */
>>>> +		if (!ovpn->registered)
>>>> +			return NOTIFY_DONE;
>>>> +
>>>> +		ovpn_iface_destruct(ovpn);
>>>
>>> Maybe I'm misunderstanding this code. Why do you want to manually
>>> destroy a device that is already going away?
>>
>> We need to perform some internal cleanup (i.e. release all peers).
>> I don't see how this can happen automatically, no?
> 
> That's what ->priv_destructor does, 

Not really.

Every peer object increases the netdev refcounter to the netdev, 
therefore we must first delete all peers in order to have 
netdevice->refcnt reach 0 (and then invoke priv_destructor).

So the idea is: upon UNREGISTER event we drop all resources and 
eventually (via RCU) all references to the netdev are also released, 
which in turn triggers the destructor.

makes sense?


> and it will be called ultimately
> by the unregister_netdevice call you have in ovpn_iface_destruct (in
> netdev_run_todo). Anyway, this UNREGISTER event is probably generated
> by unregister_netdevice_many_notify (basically a previous
> unregister_netdevice() call), so I don't know why you want to call
> unregister_netdevice again on the same device.

I believe I have seen this notification being triggered upon netns exit, 
but in that case the netdevice was not being removed from core.

Hence I decided to fully trigger the unregistration.

Expected?

I can repeat the test to be sure.

> 
> 
>>>> @@ -62,6 +210,24 @@ static struct notifier_block ovpn_netdev_notifier = {
>>>>    	.notifier_call = ovpn_netdev_notifier_call,
>>>>    };
>>>> +static void ovpn_netns_pre_exit(struct net *net)
>>>> +{
>>>> +	struct ovpn_struct *ovpn;
>>>> +
>>>> +	rtnl_lock();
>>>> +	list_for_each_entry(ovpn, &dev_list, dev_list) {
>>>> +		if (dev_net(ovpn->dev) != net)
>>>> +			continue;
>>>> +
>>>> +		ovpn_iface_destruct(ovpn);
>>>
>>> Is this needed? On netns destruction all devices within the ns will be
>>> destroyed by the networking core.
>>
>> Before implementing ovpn_netns_pre_exit() this way, upon namespace deletion
>> the ovpn interface was being moved to the global namespace.
> 
> Crap it's only the devices with ->rtnl_link_ops that get killed by the
> core. 

exactly! this goes hand to hand with my comment above: event delivered 
but interface not destroyed.

> Because you create your devices via genl (which I'm not a fan
> of, even if it's a bit nicer for userspace having a single netlink api
> to deal with),

Originally I had implemented the rtnl_link_ops, but the (meaningful) 
objection was that a user is never supposed to create an ovpn iface by 
himself, but there should always be an openvpn process running in 
userspace. Hence the restriction to genl only.

> default_device_exit_batch/default_device_exit_net think
> ovpn devices are real NICs and move them back to init_net instead of
> destroying them.
> 
> Maybe we can extend the condition in default_device_exit_net with a
> new flag so that ovpn devices get destroyed by the core, even without
> rtnl_link_ops?

Thanks for pointing out the function responsible for this decision.
How would you extend the check though?

Alternatively, what if ovpn simply registers an empty rtnl_link_ops with 
netns_fund set to false? That should make the condition happy, while 
keeping ovpn genl-only


Thanks a lot


-- 
Antonio Quartulli
OpenVPN Inc.

