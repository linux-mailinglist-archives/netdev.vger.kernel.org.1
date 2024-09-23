Return-Path: <netdev+bounces-129296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A1297EBB6
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 14:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62BBF1C20F2D
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 12:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 835FE197A7F;
	Mon, 23 Sep 2024 12:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="XVyThmct"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4216019755E
	for <netdev@vger.kernel.org>; Mon, 23 Sep 2024 12:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727095900; cv=none; b=QHYZCR2bitQThZ+txiUy+Q5giy2C1ea5jL3nykXe9/tVg/93Awifzu6tZSh6eFFJBvlIVGHyKzqjB3Vsp3x8qoENNhIm8ktP5nPPnntIodg6bjvq3kJ+pal6Jb6arzmW/rG0dwqjiZvAzYDuJbWg9cTNp+YPQZzI5sALA2HudCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727095900; c=relaxed/simple;
	bh=tkzEugAXyfx/FJo3iGs/diZSVUkc1Pnx6ncCdeSF/qc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SgNyuJpqahnG6/y18oUFG7syu7ul755A2ewjLDV+Pjf9Sa7/w5jBuKI9aM+SWk2ATiv0UgxjxGkDPjmqNLrk+IxzGSUOwum3pNzMJQCgA7tRbixkSGMJ+lcK+2NnwJJTZ7mj/WeC3d9DVIbJJfLKu7ni49CMjrbStqByemHxlp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=XVyThmct; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-374c3eef39eso2755662f8f.0
        for <netdev@vger.kernel.org>; Mon, 23 Sep 2024 05:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1727095896; x=1727700696; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ybSgKG2dnasSS05vAvz232MWRc/EvjGFbNpMoctKcYY=;
        b=XVyThmct6oOWjBco2s7A52ebG9zQhCXepQBNBcnt2aACic9gpzTq1LzI4PRQGf+2A7
         bM+mDHp61gTm+NiCZ7ngCrOuUe+3rO/i/IzZSJmYcqIKRWW7UmU1yGIBwBC6PCr1xcYA
         LaTsdfMcaYcuzB1iDs6lTdO8bJqpNvjaf3bk+br1rTjjDvYwObMQuQnpdAAmOpAMXqBY
         EnN7mJcfkk6Uak8gTchaIyweVRb138SAVkvzlczkCqJci5HSRdr1ZwvqeGPpmMohtI0l
         LsZYqlB89s/yKds2JkzGgHfio1JPcqHS3gnA2GFx+NtIgnoYdA0gvIleCfHBNNJNrfvj
         fV1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727095896; x=1727700696;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ybSgKG2dnasSS05vAvz232MWRc/EvjGFbNpMoctKcYY=;
        b=TJSkwYWCmFLERukgRAo/+McTxuiU/M6ZKSDXS0uumn/ijWK2kQiENQjE0wZNcq8Wzk
         5mAmFb0MtoC9WR2XjsAcLa8LgeojsHJrqp9bFtZu9AzblvtI+veZm1HyEjwNaDMG8RBz
         nlchr017jChuqF+3J+YCM6VVhmsu8REksKPpy7Fvxe8jKyxhpcM8HQm0pBCksCSnvj5w
         8flmDMALA9lskbLYD/i6eCAn1b9gqOH71czo+Ws45alT/hqHLpgeGXrEvVf0mNNJenlW
         hUN4S7/twFnc6Weu+6XM2MlfjJAhSYddCFIyWMesEJOu08YgRSwX0nmlCgS04V75Zwoo
         emHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBqg73OuOSaybKCrydM6TxiOT7Akv0WSNGSNyz0ARnfwmPoXKGTeq+F0J41u9yxxfH0nxGouQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvK52TBL89GXHeEyR7JJjaQpG+JajtZyF+bdPiktJLLZ1Rh6wR
	7H0Yl2sFZguqqcOpFQ0sEYitUj8c5T9w6BK+Rjlm9W+bQ3URrbIQBpvubavO0rY=
X-Google-Smtp-Source: AGHT+IFGH2Y8tAiZJbC43mENzWURzUCLqpzLHaKKLlVHtZ8MqpaFhQi5WFvjEe92STyx3YQV/bMwfw==
X-Received: by 2002:adf:ed0a:0:b0:374:c8e5:d568 with SMTP id ffacd0b85a97d-37a422bf206mr6039818f8f.29.1727095896383;
        Mon, 23 Sep 2024 05:51:36 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:8a3e:77dd:5f67:bbfc? ([2001:67c:2fbc:1:8a3e:77dd:5f67:bbfc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e7800152sm24509706f8f.74.2024.09.23.05.51.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2024 05:51:35 -0700 (PDT)
Message-ID: <0c5daaf7-24b3-42ed-935e-05dd7d69edd9@openvpn.net>
Date: Mon, 23 Sep 2024 14:51:38 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 03/25] net: introduce OpenVPN Data Channel
 Offload (ovpn)
To: Sergey Ryazanov <ryazanov.s.a@gmail.com>,
 Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: andrew@lunn.ch, antony.antony@secunet.com, edumazet@google.com,
 kuba@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 sd@queasysnail.net, steffen.klassert@secunet.com
References: <a10dcebf-b8f1-4d9b-b417-cca7d0330e52@openvpn.net>
 <20240920093234.15620-1-kuniyu@amazon.com>
 <02420241-98a9-47dc-97a7-d3c1fad76573@openvpn.net>
 <cbd97c96-4972-4b4d-a5a5-d43968c1a2d0@gmail.com>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <cbd97c96-4972-4b4d-a5a5-d43968c1a2d0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 22/09/2024 22:51, Sergey Ryazanov wrote:
> Hello Antonio, Kuniyuki,
> 
> On 20.09.2024 12:46, Antonio Quartulli wrote:
>> Hi,
>>
>> On 20/09/2024 11:32, Kuniyuki Iwashima wrote:
>>> From: Antonio Quartulli <antonio@openvpn.net>
>>> Date: Thu, 19 Sep 2024 13:57:51 +0200
>>>> Hi Kuniyuki and thank you for chiming in.
>>>>
>>>> On 19/09/2024 07:52, Kuniyuki Iwashima wrote:
>>>>> From: Antonio Quartulli <antonio@openvpn.net>
>>>>> Date: Tue, 17 Sep 2024 03:07:12 +0200
>>>>>> +/* we register with rtnl to let core know that ovpn is a virtual 
>>>>>> driver and
>>>>>> + * therefore ifaces should be destroyed when exiting a netns
>>>>>> + */
>>>>>> +static struct rtnl_link_ops ovpn_link_ops = {
>>>>>> +};
>>>>>
>>>>> This looks like abusing rtnl_link_ops.
>>>>
>>>> In some way, the inspiration came from
>>>> 5b9e7e160795 ("openvswitch: introduce rtnl ops stub")
>>>>
>>>> [which just reminded me that I wanted to fill the .kind field, but I
>>>> forgot to do so]
>>>>
>>>> The reason for taking this approach was to avoid handling the iface
>>>> destruction upon netns exit inside the driver, when the core already 
>>>> has
>>>> all the code for taking care of this for us.
>>>>
>>>> Originally I implemented pernet_operations.pre_exit, but Sabrina
>>>> suggested that letting the core handle the destruction was cleaner (and
>>>> I agreed).
>>>>
>>>> However, after I removed the pre_exit implementation, we realized that
>>>> default_device_exit_batch/default_device_exit_net thought that an ovpn
>>>> device is a real NIC and was moving it to the global netns rather than
>>>> killing it.
>>>>
>>>> One way to fix the above was to register rtnl_link_ops with 
>>>> netns_fund =
>>>> false (so the ops object you see in this patch is not truly "empty").
>>>>
>>>> However, I then hit the bug which required patch 2 to get fixed.
>>>>
>>>> Does it make sense to you?
>>>> Or you still think this is an rtnl_link_ops abuse?
>>>
>>> The use of .kind makes sense, and the change should be in this patch.
>>
>> Ok, will add it here and I will also add an explicit .netns_fund = 
>> false to highlight the fact that we need this attribute to avoid 
>> moving the iface to the global netns.
>>
>>>
>>> For the patch 2 and dellink(), is the device not expected to be removed
>>> by ip link del ?  Setting unregister_netdevice_queue() to dellink() will
>>> support RTM_DELLINK, but otherwise -EOPNOTSUPP is returned.
>>
>> For the time being I decided that it would make sense to add and 
>> delete ovpn interfaces via netlink API only.
>>
>> But there are already discussions about implementing the RTNL 
>> add/dellink() too.
>> Therefore I think it makes sense to set dellink to 
>> unregister_netdevice_queue() in this patch and thus avoid patch 2 at all.
> 
> I should make a confession :) It was me who proposed and pushed the idea 
> of the RTNL ops removing. I was too concerned about uselessness of 
> addlink operation so I did not clearly mention that dellink is useful 
> operation. Especially when it comes to namespace destruction. My bad.

It helped getting where we are now :)

> 
> So yeah, providing the dellink operation make sense for namespace 
> destruction handling and for user to manually cleanup reminding network 
> interfaces after a forceful user application killing or crash.

For this specific case (i.e. crash) I am planning to add a netlink 
notifier that detects when the process having created the interface goes 
away and then kill the interface from within the kernel.

This way we have some sort of self cleanup and avoid leaving the system 
in a bogus state. (For those specific use cases where you want to create 
a "persistent" interface, I think we will provide a flag. But this is 
for a later patch..)


Cheers,

> 
>>>> The alternative was to change
>>>> default_device_exit_batch/default_device_exit_net to read some new
>>>> netdevice flag which would tell if the interface should be killed or
>>>> moved to global upon netns exit.
> 
> -- 
> Sergey

-- 
Antonio Quartulli
OpenVPN Inc.

