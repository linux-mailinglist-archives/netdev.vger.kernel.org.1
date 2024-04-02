Return-Path: <netdev+bounces-84187-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D9BA895EFF
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 23:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D5DFB24B4F
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 21:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A53BE15E7F3;
	Tue,  2 Apr 2024 21:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="rBDr+qUy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B237215E1FD
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 21:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712095148; cv=none; b=IUEbvhXkTcP4o3Y6GyFMnD4JK8JcXagZ+iT5yzpKlhKyXmuUPJ/KdgOG4M1uB9uLVDpkcWdrSsrwb/9Hf4i4ppLmyVFcVFgOF0Ttbx56uNoWJQ4K40TffFxIiU/8Yi/DWMIraYpNOfbaR9VemhIUsaQs5lUvSKIA2Ajs1cTahOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712095148; c=relaxed/simple;
	bh=3HMuC3bRtsHpwo2gdK92KXOEH/vPfxmFImAuMKKMCGQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OmA5UJOCy3njVZKwJ2hSpbEYySUsrJA4LUB8w47sx9+PqBEKQ6bgO7eLi4vxHOectFuxqI0cAM3Ucur4aKioIMd5PW3pYKVkjFYOnYy+Y8+4z20mh0McM7BPKF+B3vOdHN7MLdWvfc92LkWjocBW90mTqGlwA6EMCTGFcNv808E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=rBDr+qUy; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4161d73d855so8537545e9.1
        for <netdev@vger.kernel.org>; Tue, 02 Apr 2024 14:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1712095145; x=1712699945; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bz4CwkwJXdjQGGsT6Kr7wpt065JkKz8ijRcVPDcuGpo=;
        b=rBDr+qUy/qWYrJEpqaumslRbQCfpawgJ8HfXO8Dv9pU2SZp7vn5wgyoySvLp7PetvB
         MjgQiIF3fJbARk1HIJBhZ7NdBJMH1uIcdrlgVxvGAWcQfBepk4x1GWCyAprxnKRBBhxs
         Z9kCKfdUDhvCYwWYn4mNJhsmQnvyH36Mw8eBu+1Dd5ny1EzKJNhV3pv1QLE935Qojyq/
         ruV8k9ios/FWFFIEeTPYGudoTgxSGMTy1gVZCBt9/kKtjJLanWMGpUaiTyq3MQjk3zKp
         1eXlt4IGPixXwNejPEvNlyysAfMwFmSeuav+XeXo1YIHdsD+zpO5i3qTTTKoaYnQHYAm
         Q8lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712095145; x=1712699945;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bz4CwkwJXdjQGGsT6Kr7wpt065JkKz8ijRcVPDcuGpo=;
        b=Ya9e6yvtJVoN79GpIkxy2PZaesNoBH7gaHetnhwjNOJWZON4h66u0eKWV3xdT5ySRf
         jnBsrNUpBocrAyjLxNTsc2KnuRPc4MP9Zd47IvgRZQKyISVu8WYdIh103HhY6HteE/SG
         fe89dju2SbzN5fVY8kCRGtowH0UG5dD7J7wYNSycCCLZAcEfjrCWmyL9RdeErJWHYdOW
         wp41Omnh90wkmNOuzuxl33fo8ovpXlsFZ7CL9W1CSnCEyTlwpW7rri7T2uNIW3qyHbgu
         zity+RzuI+Hb3KmUOuMOyEzz7gUYvAND6D1BjdQQilioI99ezD2hzuhRHaqln1ocjPQ0
         Yt0w==
X-Forwarded-Encrypted: i=1; AJvYcCWPDNSx4FqK41uFS4flIaDeaVtabmxqWc1BNTAAZ0VPQNgVpgkQOj9zIzkYJSGeyhR5YWezIgvNpeEx1yizDFQ0g3qNcB5j
X-Gm-Message-State: AOJu0Yxb9rtkc3QmhFvBzencNpWKgl/NfumHdEKS3WM4w4YOqpvZ0rag
	e3mq8diulZlpp5NagkrVtxPjf2JikV97bV5eCidC1jqTrD6Vt1RK50etu+pxvSY=
X-Google-Smtp-Source: AGHT+IEzWPque6zbwFpJujfIUQvfyL/QyFGSNetVbKefpR0Ye1/gaucb/Se1Rf4tT1hKJ+Irl4vpZA==
X-Received: by 2002:a05:600c:3206:b0:413:feed:b309 with SMTP id r6-20020a05600c320600b00413feedb309mr2435174wmp.6.1712095144945;
        Tue, 02 Apr 2024 14:59:04 -0700 (PDT)
Received: from [192.168.0.106] (176.111.182.227.kyiv.volia.net. [176.111.182.227])
        by smtp.gmail.com with ESMTPSA id u22-20020a05600c139600b004148d7b889asm22518328wmf.8.2024.04.02.14.59.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Apr 2024 14:59:04 -0700 (PDT)
Message-ID: <065b803f-14a9-4013-8f11-712bb8d54848@blackwall.org>
Date: Wed, 3 Apr 2024 00:59:03 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next 00/10] MC Flood disable and snooping
Content-Language: en-US
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Joseph Huang <Joseph.Huang@garmin.com>, netdev@vger.kernel.org,
 Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Roopa Prabhu <roopa@nvidia.com>, =?UTF-8?Q?Linus_L=C3=BCssing?=
 <linus.luessing@c0d3.blue>, linux-kernel@vger.kernel.org,
 bridge@lists.linux.dev
References: <20240402001137.2980589-1-Joseph.Huang@garmin.com>
 <7fc8264a-a383-4682-a144-8d91fe3971d9@blackwall.org>
 <20240402174348.wosc37adyub5o7xu@skbuf>
 <a8968719-a63b-4969-a971-173c010d708f@blackwall.org>
 <20240402204600.5ep4xlzrhleqzw7k@skbuf>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20240402204600.5ep4xlzrhleqzw7k@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/2/24 23:46, Vladimir Oltean wrote:
> On Tue, Apr 02, 2024 at 09:50:51PM +0300, Nikolay Aleksandrov wrote:
>> On 4/2/24 20:43, Vladimir Oltean wrote:
>>> Hi Nikolai,
>>>
>>> On Tue, Apr 02, 2024 at 12:28:38PM +0300, Nikolay Aleksandrov wrote:
>>>> For the bridge patches:
>>>> Nacked-by: Nikolay Aleksandrov <razor@blackwall.org>
>>>>
>>>> You cannot break the multicast flood flag to add support for a custom
>>>> use-case. This is unacceptable. The current bridge behaviour is correct
>>>> your patch 02 doesn't fix anything, you should configure the bridge
>>>> properly to avoid all those problems, not break protocols.
>>>>
>>>> Your special use case can easily be solved by a user-space helper or
>>>> eBPF and nftables. You can set the mcast flood flag and bypass the
>>>> bridge for these packets. I basically said the same in 2021, if this is
>>>> going to be in the bridge it should be hidden behind an option that is
>>>> default off. But in my opinion adding an option to solve such special
>>>> cases is undesirable, they can be easily solved with what's currently
>>>> available.
>>>
>>> I appreciate your time is limited, but could you please translate your
>>> suggestion, and detail your proposed alternative a bit, for those of us
>>> who are not very familiar with IP multicast snooping?
>>>
>>
>> My suggestion is not related to snooping really, but to the goal of
>> patches 01-03. The bridge patches in this set are trying to forward
>> traffic that is not supposed to be forwarded with the proposed
>> configuration,
> 
> Correct up to a point. Reinterpreting the given user space configuration
> and trying to make it do something else seems like a mistake, but in
> principle one could also look at alternative bridge configurations like
> the one I described here:
> https://lore.kernel.org/netdev/20240402180805.yhhwj2f52sdc4dl2@skbuf/
> 
>> so that can be done by a user-space helper that installs
>> rules to bypass the bridge specifically for those packets while
>> monitoring the bridge state to implement a policy and manage these rules
>> in order to keep snooping working.
>>
>>> Bypass the bridge for which packets? General IGMP/MLD queries? Wouldn't
>>> that break snooping? And then do what with the packets, forward them in
>>> another software layer than the bridge?
>>>
>>
>> The ones that are not supposed to be forwarded in the proposed config
>> and are needed for this use case (control traffic and link-local). Obviously
>> to have proper snooping you'd need to manage these bypass
>> rules and use them only while needed.
> 
> I think Joseph will end up in a situation where he needs IGMP control
> messages both in the bridge data path and outside of it :)
> 

My solution does not exclude such scenario. With all unregistered mcast
disabled it will be handled the same as with this proposed solution.

> Also, your proposal eliminates the possibility of cooperating with a
> hardware accelerator which can forward the IGMP messages where they need
> to go.
> 
> As far as I understand, I don't think Joseph has a very "special" use case.
> Disabling flooding of unregistered multicast in the data plane sounds
> reasonable. There seems to be a gap in the bridge API, in that this

This we already have, but..

> operation also affects the control plane, which he is trying to fix with
> this "force flooding", because of insufficiently fine grained control.
> 

Right, this is the part that is more special, I'm not saying it's
unreasonable. The proposition to make it optional and break it down to
type of traffic sounds good to me.

>>> I also don't quite understand the suggestion of turning on mcast flooding:
>>> isn't Joseph saying that he wants it off for the unregistered multicast
>>> data traffic?
>>
>> Ah my bad, I meant to turn off flooding and bypass the bridge for those
>> packets and ports while necessary, under necessary can be any policy
>> that the user-space helper wants to implement.
>>
>> In any case, if this is going to be yet another kernel solution then it
>> must be a new option that is default off, and doesn't break current mcast
>> flood flag behaviour.
> 
> Yeah, maybe something like this, simple and with clear offload
> semantics, as seen in existing hardware (not Marvell though):
> 
> mcast_flood == off:
> - mcast_ipv4_ctrl_flood: don't care (maybe can force to "off")
> - mcast_ipv4_data_flood: don't care
> - mcast_ipv6_ctrl_flood: don't care
> - mcast_ipv6_data_flood: don't care
> - mcast_l2_flood: don't care
> mcast_flood == on:
> - Flood 224.0.0.x according to mcast_ipv4_ctrl_flood
> - Flood all other IPv4 multicast according to mcast_ipv4_data_flood
> - Flood ff02::/16 according to mcast_ipv6_ctrl_flood
> - Flood all other IPv6 multicast according to mcast_ipv6_data_flood
> - Flood L2 according to mcast_l2_flood

Yep, sounds good to me. I was thinking about something in these lines
as well if doing a kernel solution in order to make it simpler and more
generic. The ctrl flood bits need to be handled more carefully to make
sure they match only control traffic and not link-local data.
I think the old option can be converted to use this fine-grained
control, that is if anyone sets the old flood on/off then the flood
mask gets set properly so we can do just 1 & in the fast path and avoid
adding more tests. It will also make it symmetric - if it can override
the on case, then it will be able to override the off case. And to be
more explicit you can pass a mask variable to br_multicast_rcv() which
will get populated and then you can pass it down to br_flood(). That
will also avoid adding new bits to the skb's bridge CB.



