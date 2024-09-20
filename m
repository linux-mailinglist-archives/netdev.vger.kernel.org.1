Return-Path: <netdev+bounces-129057-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67D5097D3DB
	for <lists+netdev@lfdr.de>; Fri, 20 Sep 2024 11:46:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 715BE1C20A3B
	for <lists+netdev@lfdr.de>; Fri, 20 Sep 2024 09:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74DBA13B29B;
	Fri, 20 Sep 2024 09:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="RCGZIVjg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED60D7E101
	for <netdev@vger.kernel.org>; Fri, 20 Sep 2024 09:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726825598; cv=none; b=vDf3oVx8/qpA6PDMKvTA4aujqHqrjrw2DdYdf4SwRA5cB17uHfvyQ1bwntI7LKz5CU59XjDDausNSmpxBVoTbPVj8mWyTwKgJd9pcJe/0e0EH1ZJ6VKfuIGFbVn0peVLN9PLB6sllHgGpwBV+4LLswJdpHllM6uFicYPyHBwmbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726825598; c=relaxed/simple;
	bh=1RKTp4nidAuSccWZ8wFNK8FhhXYnQqAaDvyTWU3iK9Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uUmGLZpSLq2pvHMdqG+QhEc9TKhuXw3gEN2vbB2+ci+qDvtRnTXg4tc9RjOZ4ljXNp4zLteHLqgVmaFUc0obusSgMLE2tvHrXGTMt4COEI7ZLfdLMUefZ8RZrb0KicJh6NgKCW4j9ZpwmtppuWz0XepvScAiUooSxq65bvcIo9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=RCGZIVjg; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a8d64b27c45so298195566b.3
        for <netdev@vger.kernel.org>; Fri, 20 Sep 2024 02:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1726825594; x=1727430394; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uX2P6zDPqIfr58zEpP7JQcOaTXnWvmrRAGloETUHyis=;
        b=RCGZIVjgi9647mLrk3UeW22T+25r9CksIHGInTqX/d3Ufo5GyciWsfsFSVwQs9tMSv
         kkPMBG2m7FtSF5K/vedWy61jIvSe7lnzf6S2LDuU5fbeTSkbyvkCgqylOL25YyMArYgN
         YPhTS+iI+1ohQ5WuBE3XD+XqLBB3ONZXQoQakjHm/P9P4BbYMqVfDbtUX+8tetLUfm2Z
         bKY+RYOIbG1fOwzrQ3cY4e3ZO7HgczeJJdJfFWvH/WzTa/2sl4eaxJvwppbXUQOre9mk
         cOlG8kwxk7y6EFqkn08QqlJlIKjFkHIjRMbupr5MMae24Yxm84MTUJYTh7CRPwMOv8ok
         vaww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726825594; x=1727430394;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uX2P6zDPqIfr58zEpP7JQcOaTXnWvmrRAGloETUHyis=;
        b=tr5CSgNQhTgDQuy3lHDAaxXG1OMEucUF4GnDIk/uxKvhJB/FvTdP8HLjQ2qGA1UBUn
         T5c2wu0ABa4AAbE5yA8aCs1fU3k3LHNuXv3ekJbNHs6r8AOmDS/0PUJ/DG1OFHePQyWe
         9ow0WPp74h1jeZNz53UYxN0QgkiyNISieATv2i0ZvDoLfTpHt1jxykIB9/ACPIS6kXhT
         N4qAcOlx/5Sm/VQGUGG9uZiSlXeTfUHWjcWyeVrPhlF9Wq6cCNUwFL/t8DY3AgcbSovT
         gBFvpFJWzpX3Wx7kQ2WrMrkmVbzt4n0+RSdF0wTYxB/75qG/Rx0yAWu0cKMgP4CH5feO
         2HMg==
X-Forwarded-Encrypted: i=1; AJvYcCWGcAnimU26OCoA4buZGtWuZXztU3kun/AtdcIDWUMhW7CuLNShb1PuZb3s0u9aarLg+LyXc40=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0USjVxJKmgp/L7W/aRJAm1ki+tnSNk+g2YahScq1LZugGSRjg
	+TD7SIvPgwme2n33Lz3Vf7Z8fIunCdJWo/7rzIAYKHI8N5Jy4+C8Dmv6zrtjfa0=
X-Google-Smtp-Source: AGHT+IH3NvdMWFtuhZoObNa3NWtrGm2ROtYcfYnve1mf8544umPgLtxcdAOauXnh+ppW7DFelcBmbg==
X-Received: by 2002:a17:906:7308:b0:a8d:29b7:ecea with SMTP id a640c23a62f3a-a90d5182575mr157499266b.61.1726825594079;
        Fri, 20 Sep 2024 02:46:34 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:f78c:a0f2:3670:1114? ([2001:67c:2fbc:1:f78c:a0f2:3670:1114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a90612df579sm823377166b.164.2024.09.20.02.46.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Sep 2024 02:46:33 -0700 (PDT)
Message-ID: <02420241-98a9-47dc-97a7-d3c1fad76573@openvpn.net>
Date: Fri, 20 Sep 2024 11:46:34 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 03/25] net: introduce OpenVPN Data Channel
 Offload (ovpn)
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: andrew@lunn.ch, antony.antony@secunet.com, edumazet@google.com,
 kuba@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 ryazanov.s.a@gmail.com, sd@queasysnail.net, steffen.klassert@secunet.com
References: <a10dcebf-b8f1-4d9b-b417-cca7d0330e52@openvpn.net>
 <20240920093234.15620-1-kuniyu@amazon.com>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <20240920093234.15620-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 20/09/2024 11:32, Kuniyuki Iwashima wrote:
> From: Antonio Quartulli <antonio@openvpn.net>
> Date: Thu, 19 Sep 2024 13:57:51 +0200
>> Hi Kuniyuki and thank you for chiming in.
>>
>> On 19/09/2024 07:52, Kuniyuki Iwashima wrote:
>>> From: Antonio Quartulli <antonio@openvpn.net>
>>> Date: Tue, 17 Sep 2024 03:07:12 +0200
>>>> +/* we register with rtnl to let core know that ovpn is a virtual driver and
>>>> + * therefore ifaces should be destroyed when exiting a netns
>>>> + */
>>>> +static struct rtnl_link_ops ovpn_link_ops = {
>>>> +};
>>>
>>> This looks like abusing rtnl_link_ops.
>>
>> In some way, the inspiration came from
>> 5b9e7e160795 ("openvswitch: introduce rtnl ops stub")
>>
>> [which just reminded me that I wanted to fill the .kind field, but I
>> forgot to do so]
>>
>> The reason for taking this approach was to avoid handling the iface
>> destruction upon netns exit inside the driver, when the core already has
>> all the code for taking care of this for us.
>>
>> Originally I implemented pernet_operations.pre_exit, but Sabrina
>> suggested that letting the core handle the destruction was cleaner (and
>> I agreed).
>>
>> However, after I removed the pre_exit implementation, we realized that
>> default_device_exit_batch/default_device_exit_net thought that an ovpn
>> device is a real NIC and was moving it to the global netns rather than
>> killing it.
>>
>> One way to fix the above was to register rtnl_link_ops with netns_fund =
>> false (so the ops object you see in this patch is not truly "empty").
>>
>> However, I then hit the bug which required patch 2 to get fixed.
>>
>> Does it make sense to you?
>> Or you still think this is an rtnl_link_ops abuse?
> 
> The use of .kind makes sense, and the change should be in this patch.

Ok, will add it here and I will also add an explicit .netns_fund = false 
to highlight the fact that we need this attribute to avoid moving the 
iface to the global netns.

> 
> For the patch 2 and dellink(), is the device not expected to be removed
> by ip link del ?  Setting unregister_netdevice_queue() to dellink() will
> support RTM_DELLINK, but otherwise -EOPNOTSUPP is returned.

For the time being I decided that it would make sense to add and delete 
ovpn interfaces via netlink API only.

But there are already discussions about implementing the RTNL 
add/dellink() too.
Therefore I think it makes sense to set dellink to 
unregister_netdevice_queue() in this patch and thus avoid patch 2 at all.


Thanks.

Regards,

> 
> 
>>
>> The alternative was to change
>> default_device_exit_batch/default_device_exit_net to read some new
>> netdevice flag which would tell if the interface should be killed or
>> moved to global upon netns exit.
>>
>> Regards,
>>

-- 
Antonio Quartulli
OpenVPN Inc.

