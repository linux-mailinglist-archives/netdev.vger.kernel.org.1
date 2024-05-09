Return-Path: <netdev+bounces-94925-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3A598C1040
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 15:24:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2C121C228D6
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 13:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ADB412F378;
	Thu,  9 May 2024 13:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="che7/BLi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE7A131196
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 13:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715261051; cv=none; b=MtNx2MtoHV7rANE69TRPFEU/38YA1zTXbO1KZ2IPd8mVhM9l9BaAzzKOu6s6vIkzwBoAs21QPXDnVCgPi+L6oL3jXrTb01LhJjtUIzH4iSpDD7bcba4j9QhWEq0EJHVJuTWTdYd+q43RQqfe7wRg1VJTBVnHBvVbcsmy4S+k4Os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715261051; c=relaxed/simple;
	bh=WOkkutEcKlk2fvJPV5VSSYxlVD0oZfZ89peqaMVx8VM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j/msaTXzeMoSlWQ5jTdgGBwvgnJG4xdbNRizHrsOGZcw8bgZoOGfo6OIAGxNafAY6FTMX2y31vStEQdqjqYIBSetYBk2Sd/7OmH37teu95Jb8cgu2LgvAHmwBBr3MutV9fsyhzcGjrCj/u9lFEdW86I4474KUmr/aJnosQ3EmBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=che7/BLi; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-41ba1ba55ffso4924095e9.1
        for <netdev@vger.kernel.org>; Thu, 09 May 2024 06:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1715261047; x=1715865847; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ph8zq37gjt3IFcUukROnYraKdqPOWmMD5LGcTSR/1ow=;
        b=che7/BLixOatClUUVjgRRj0uKftP0n42MCo0hRgWbfeeR/FYVCuJic6A/Jbu72iK0A
         tEyYy2VwEMnhXE6jLm2WlulvP4AuMOTvPrtnaDgYGODi+2pneL5O6xir7PmFYzmvWBnq
         0eNDUkJoxEA7vTAkFYpHNgCHtarjWhGBAIiCGH9wQvhxG6P79AhgnvzdnaSxd/2V26+9
         PzikJN+PwcfbVwrN2avUhLr6T6XnLWlMgCnIOFtGKcN29V4WNl5rLdbXnO/SYG6ErIEF
         v0/K2Xl58nA6TP2ZLoNTK+OngsVOB5Uw4wZyYAL996EXz9eWFaPERM+iiEocDwo2HHIi
         IQFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715261047; x=1715865847;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ph8zq37gjt3IFcUukROnYraKdqPOWmMD5LGcTSR/1ow=;
        b=KbnN+ia7ZktiFuPi2or2qi/oeuKY03T+OMh8f1aCD4SZD25wijaCt2CX2zsg4swwog
         O6CZtKEeDCtfH+2w32sFiN/lQet/TUj3hzVLL5s/eq3EyVS+w7r0r+o36YmKHkP+DZ+Q
         94KL1l5oG0OWm2D4g3pH6GUZxk0kuxfC5Qmzwo404zSKpa4qC0/suNF3ovv/YWYpa1Rz
         WetiaGUYWUEjriYq1CLsJvbt4yl3kp89TOo3VhPDWXO8ijU/JbeupfFz8iPVW+y5GuCv
         jT63gsPYD07hCAhwCeLom3O6fyT2BAq739ontuwe4lBYCwsFwGSBAj72m5p9iO/4UeFx
         B5eQ==
X-Gm-Message-State: AOJu0Yw8mZ239IXG42u6/A1OnlPqK/KXrkq+j7IvDHSVDNugkbzu+WS+
	cm8ILHqIAecuVS9kru5GDN2XpVHaC/O/vxjadYOu2yQTT5gi9JSFJuOwusnqQtE=
X-Google-Smtp-Source: AGHT+IGj6rUztDNXPRxIvJBZLZum9S9nUZDx4Y2U4IJX4zprmH9/R8qTGcN0rCFN/LX+++IgNAjovA==
X-Received: by 2002:a05:600c:3144:b0:419:c9e1:70b8 with SMTP id 5b1f17b1804b1-41fbcd7095fmr22174535e9.13.1715261047105;
        Thu, 09 May 2024 06:24:07 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:0:6fcd:499b:c37e:9a0? ([2001:67c:2fbc:0:6fcd:499b:c37e:9a0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccce93aesm25405785e9.26.2024.05.09.06.24.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 May 2024 06:24:06 -0700 (PDT)
Message-ID: <b537eb9d-ddab-4b39-bcea-2b8781507a8c@openvpn.net>
Date: Thu, 9 May 2024 15:25:21 +0200
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
 <1d31ca80-055e-4601-91b6-b0dc38b721c7@openvpn.net> <Zjy-jPqyKo-6clve@hog>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <Zjy-jPqyKo-6clve@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

By the way, thank you very much for taking the time to have this 
constructive discussion. I really appreciate it!

On 09/05/2024 14:16, Sabrina Dubroca wrote:
> 2024-05-09, 12:35:32 +0200, Antonio Quartulli wrote:
>> On 09/05/2024 12:09, Sabrina Dubroca wrote:
>>> 2024-05-09, 10:25:44 +0200, Antonio Quartulli wrote:
>>>> On 08/05/2024 16:52, Sabrina Dubroca wrote:
>>>>> 2024-05-06, 03:16:17 +0200, Antonio Quartulli wrote:
>>>>>>     static int ovpn_netdev_notifier_call(struct notifier_block *nb,
>>>>>>     				     unsigned long state, void *ptr)
>>>>>>     {
>>>>>>     	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
>>>>>> +	struct ovpn_struct *ovpn;
>>>>>>     	if (!ovpn_dev_is_valid(dev))
>>>>>>     		return NOTIFY_DONE;
>>>>>> +	ovpn = netdev_priv(dev);
>>>>>> +
>>>>>>     	switch (state) {
>>>>>>     	case NETDEV_REGISTER:
>>>>>> -		/* add device to internal list for later destruction upon
>>>>>> -		 * unregistration
>>>>>> -		 */
>>>>>> +		ovpn->registered = true;
>>>>>>     		break;
>>>>>>     	case NETDEV_UNREGISTER:
>>>>>> +		/* twiddle thumbs on netns device moves */
>>>>>> +		if (dev->reg_state != NETREG_UNREGISTERING)
>>>>>> +			break;
>>>>>> +
>>>>>>     		/* can be delivered multiple times, so check registered flag,
>>>>>>     		 * then destroy the interface
>>>>>>     		 */
>>>>>> +		if (!ovpn->registered)
>>>>>> +			return NOTIFY_DONE;
>>>>>> +
>>>>>> +		ovpn_iface_destruct(ovpn);
>>>>>
>>>>> Maybe I'm misunderstanding this code. Why do you want to manually
>>>>> destroy a device that is already going away?
>>>>
>>>> We need to perform some internal cleanup (i.e. release all peers).
>>>> I don't see how this can happen automatically, no?
>>>
>>> That's what ->priv_destructor does,
>>
>> Not really.
>>
>> Every peer object increases the netdev refcounter to the netdev, therefore
>> we must first delete all peers in order to have netdevice->refcnt reach 0
>> (and then invoke priv_destructor).
> 
> Oh, I see. I'm still trying to wrap my head around all the objects and
> components of your driver.
> 
>> So the idea is: upon UNREGISTER event we drop all resources and eventually
>> (via RCU) all references to the netdev are also released, which in turn
>> triggers the destructor.
>>
>> makes sense?
> 
> That part, yes, thanks for explaining. Do you really need the peers to
> hold a reference on the netdevice? With my limited understanding, it
> seems the peers are sub-objects of the netdevice.
> 
>>> and it will be called ultimately
>>> by the unregister_netdevice call you have in ovpn_iface_destruct (in
>>> netdev_run_todo). Anyway, this UNREGISTER event is probably generated
>>> by unregister_netdevice_many_notify (basically a previous
>>> unregister_netdevice() call), so I don't know why you want to call
>>> unregister_netdevice again on the same device.
>>
>> I believe I have seen this notification being triggered upon netns exit, but
>> in that case the netdevice was not being removed from core.
> 
> Sure, but you have a comment about that and you're filtering that
> event, so I'm ignoring this case.

You're right..now I wonder if my observation was made before I 
introduced that check...

> 
>> Hence I decided to fully trigger the unregistration.
> 
> That's the bit that doesn't make sense to me: the device is going
> away, so you trigger a manual unregister. Cleaning up some additional
> resources (peers etc), that makes sense. But calling
> unregister_netdevice (when you're most likely getting called from
> unregister_netdevice already, because I don't see other spots setting
> dev->reg_state = NETREG_UNREGISTERING) is what I don't get. And I
> wonder why you're not hitting the BUG_ON in
> unregister_netdevice_many_notify:
> 
>      BUG_ON(dev->reg_state != NETREG_REGISTERED);

I think because we have our ovpn->registered check.
It ensures that we don't call ovpn_iface_destruct more than once.

But now, that I implemented the rtnl_link_ops I can confirm I am hitting 
the BUG_ON. And now it makes sense.

I presume that now I can I simply remove the call to 
unregister_netdevice() from ovpn_iface_destruct() and move it to 
ovpn_nl_del_iface_doit().

This way, upon netns exit, the real UNREGISTER handler (triggered thanks 
to rtnl_link_ops) will still perform the destruct, but won't try to 
schedule an UNREGISTER event again.

> 
> 
>>>>>> @@ -62,6 +210,24 @@ static struct notifier_block ovpn_netdev_notifier = {
>>>>>>     	.notifier_call = ovpn_netdev_notifier_call,
>>>>>>     };
>>>>>> +static void ovpn_netns_pre_exit(struct net *net)
> 
> BTW, in case you end up keeping this function, it should have
> __net_exit annotation (see for example ipv4_frags_exit_net).

ACK, but thanks to the rtnl_link_ops trick we are definitely ditching it.
> 
>>>>>> +{
>>>>>> +	struct ovpn_struct *ovpn;
>>>>>> +
>>>>>> +	rtnl_lock();
>>>>>> +	list_for_each_entry(ovpn, &dev_list, dev_list) {
>>>>>> +		if (dev_net(ovpn->dev) != net)
>>>>>> +			continue;
>>>>>> +
>>>>>> +		ovpn_iface_destruct(ovpn);
>>>>>
>>>>> Is this needed? On netns destruction all devices within the ns will be
>>>>> destroyed by the networking core.
>>>>
>>>> Before implementing ovpn_netns_pre_exit() this way, upon namespace deletion
>>>> the ovpn interface was being moved to the global namespace.
>>>
>>> Crap it's only the devices with ->rtnl_link_ops that get killed by the
>>> core.
>>
>> exactly! this goes hand to hand with my comment above: event delivered but
>> interface not destroyed.
> 
> There's no event sent to ovpn_netdev_notifier_call in that case (well,
> only the fake "unregister" out of the current netns that you're
> ignoring). Otherwise, you wouldn't need ovpn_netns_pre_exit.

Yeah you're right. I think I wanted to conclude the same thing but my 
brain was unable to produce a meaningful sentence.

> 
>>> Because you create your devices via genl (which I'm not a fan
>>> of, even if it's a bit nicer for userspace having a single netlink api
>>> to deal with),
>>
>> Originally I had implemented the rtnl_link_ops, but the (meaningful)
>> objection was that a user is never supposed to create an ovpn iface by
>> himself, but there should always be an openvpn process running in userspace.
>> Hence the restriction to genl only.
> 
> Sorry, but how does genl prevent a user from creating the ovpn
> interface manually? Whatever API you define, anyone who manages to
> come up with the right netlink message will be able to create an
> interface. You can't stop people from using your API without your
> official client.

I don't want to prevent people from creating ovpn ifaces the way they like.
I just don't see how the rtnl_link API can be useful, other than 
allowing users to execute 'ip link add/del..'.
And by design that is not a usecase we want to support, because once the 
iface is created, nothing will happen if there is no userspace software 
driving it (no matter if it is openvpn or anything else).

When explaining this decision, I like to make a comparison to virtual 
802.11/wifi ifaces.
They also lack rtnl_link (AFAIR) as they also require some userspace 
software to handle them in order to be useful.

All this said, having everything in one place looks cleaner too :)

> 
>>> default_device_exit_batch/default_device_exit_net think
>>> ovpn devices are real NICs and move them back to init_net instead of
>>> destroying them.
>>>
>>> Maybe we can extend the condition in default_device_exit_net with a
>>> new flag so that ovpn devices get destroyed by the core, even without
>>> rtnl_link_ops?
>>
>> Thanks for pointing out the function responsible for this decision.
>> How would you extend the check though?
>>
>> Alternatively, what if ovpn simply registers an empty rtnl_link_ops with
>> netns_fund set to false? That should make the condition happy, while keeping
>> ovpn genl-only
> 
> Yes. I was thinking about adding a flag to the device, because I
> wasn't sure an almost empty rtnl_link_ops could be handled safely, but
> it seems ok. ovs does it, see commit 5b9e7e160795 ("openvswitch:
> introduce rtnl ops stub"). And, as that commit message says, "ip -d
> link show" would also show that the device is of type openvpn (or
> ovpn, whatever you put in ops->kind), which would be nice.

I just coded something along those lines.

It seems pretty clean and we don't need to touch core (+ the bonus of 
having the name in "ip -d link")....and the iface does get destroyed 
upon netns exit! :-)

I am grasping much better how all these APIs work together now.

Thanks!

-- 
Antonio Quartulli
OpenVPN Inc.

