Return-Path: <netdev+bounces-146484-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 892369D398B
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 12:34:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D7E3B22757
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 11:33:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB9D91A08A0;
	Wed, 20 Nov 2024 11:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="F/fFZfaT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE41197A87
	for <netdev@vger.kernel.org>; Wed, 20 Nov 2024 11:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732102424; cv=none; b=AMdEoSP051on2mEohVsX/KBPXXkplL7gP+ORKD7DSx2Zpdmn8t7kftaGJ0TvTFOcb/UkHixwP6QjYsRpBjIiJ/dI4gIzWbECgPgUvBurSpgM16couMx8ola+JDbgmNMH9zfKARC9v/FPDIdKpz07fFy/FifGgUUVjeJNw1LboIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732102424; c=relaxed/simple;
	bh=6XPjJ5dqer4wFdCa51NDnB6OroOUa2ADFmdH8g8BRcQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hHRGtsLJtUe23G5dTPT7otR1EqeV04k0i6bmAP/9Rmd7mI4pz9fw53c6lf6kuxLJQVQkSB1pDvp6zYkF21MeofslVxX4CBSrty4AHLDf6fNgcKO9xDZO+N7vrMa0pUWxOQAl+BQgwvEgF9wszSzlo16e5ne8rTlvO1zCsz2ukfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=F/fFZfaT; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aa4833e9c44so245000366b.2
        for <netdev@vger.kernel.org>; Wed, 20 Nov 2024 03:33:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1732102420; x=1732707220; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0g0gR8z1copD7fs221INgCm/rUBI//0z/DFHYRooyO4=;
        b=F/fFZfaTprNQ1JneU4WQ8szxQ2KRQ4+3m+uMsM3XrEnCdKRzGnAH2/lgBVJT52ZVKt
         EXaunNVaAxqwIi7Rg0CIOQULaRvSJ4Sdrw/wj/UBVLEOkraXNZBvu6iWT3RPy6on/wwH
         nbmORb85ZSBRkME1UUVtYDqPIIOOY/r9gKvNQpLCh/0EorZk4AeiEJtL9yOy40tJozny
         UQxK258kHIZg+5VbhJhykGeKNnMFume94SV2m95OjJ8kXRnTt+8pY9btlm7uYDlhjle/
         gQlnFiPqXlfCE1RRvMiFVKWLLhQAsHXtnMPv7sXmc7muPncru/skzSA7phu/gXFZDW+g
         uOow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732102420; x=1732707220;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0g0gR8z1copD7fs221INgCm/rUBI//0z/DFHYRooyO4=;
        b=NmO487N6wn2aiAoHLiLvR4mpm7oSae9ZloJ+egMmGWqo6Q//Uau0K4HQWG9wr4xBwa
         zYtzkr51iF78s2z30yg2/AO2X713fgJbQKs0ziZBb8wzpfoXji4X72DF6eiTnf+1wWCF
         iniqxDGWWUpKafe5AaCJ972l1/tNHetsqKgO3FX6Q+AawtVFiddqWWf+RBsRm+SVvBgQ
         YMeRxzhkzYeU0XwkVpsF06k5v7SUuyA+2+wZ861gHe7s6r9AcF2bgz9Pp9KsX3ESOOZm
         xkRVVhGcv+zPI83Mz4nID2FPn1xdR7/aQVyxmm7ydwg1+StJcfzqPy1UfxgYfGvwIpl6
         QJtg==
X-Forwarded-Encrypted: i=1; AJvYcCU2OkUQN0PsHAM1KySkbPSX0uIxwZztby2jvWkwOdOGvwD75i3CL8lG5GhaUB9I1s7N+fRXH6E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyl7FbdrmgeU3n6BkiZorJAWpJw1ZbuyDy3mI0U9WkZYdqqETzw
	s53cS5kq/9gY3XUxNa0hMJ71DGXJZMtsUNuYCGrk6mTKqSPo0LAdKUhWC34s4tE=
X-Google-Smtp-Source: AGHT+IG7URSYRZPWjCFuS2c1SVVI5yK8phhdFZUnPGRqq0zw31Zja3M/TDj/P+N/7F3WQPFei30lxQ==
X-Received: by 2002:a17:906:7953:b0:a99:f466:a87a with SMTP id a640c23a62f3a-aa4dd52c2a1mr190999866b.3.1732102420496;
        Wed, 20 Nov 2024 03:33:40 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:65a7:31ec:a512:a40e? ([2001:67c:2fbc:1:65a7:31ec:a512:a40e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20dffd695sm754198066b.114.2024.11.20.03.33.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Nov 2024 03:33:39 -0800 (PST)
Message-ID: <28447817-028e-4c5c-ae7e-3ffa86de9bf1@openvpn.net>
Date: Wed, 20 Nov 2024 12:34:08 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 18/23] ovpn: implement peer
 add/get/dump/delete via netlink
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Shuah Khan <shuah@kernel.org>, ryazanov.s.a@gmail.com,
 Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
 <20241029-b4-ovpn-v11-18-de4698c73a25@openvpn.net> <Zyjk781vOqV4kXhJ@hog>
 <76191b85-6844-4a85-bb9c-ad19aa5110c5@openvpn.net> <ZzTaRNeZjo48ArsR@hog>
 <e11c5f81-cbc8-43a3-b275-7004efdcb358@openvpn.net> <Zz3EEl0diYofGkIC@hog>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <Zz3EEl0diYofGkIC@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/11/2024 12:12, Sabrina Dubroca wrote:
> 2024-11-14, 10:21:18 +0100, Antonio Quartulli wrote:
>> On 13/11/2024 17:56, Sabrina Dubroca wrote:
>>> 2024-11-12, 15:19:50 +0100, Antonio Quartulli wrote:
>>>> On 04/11/2024 16:14, Sabrina Dubroca wrote:
>>>>> 2024-10-29, 11:47:31 +0100, Antonio Quartulli wrote:
>>>>>> +static int ovpn_nl_peer_precheck(struct ovpn_struct *ovpn,
>>>>>> +				 struct genl_info *info,
>>>>>> +				 struct nlattr **attrs)
>>>>>> +{
>>>>>> +	if (NL_REQ_ATTR_CHECK(info->extack, info->attrs[OVPN_A_PEER], attrs,
>>>>>> +			      OVPN_A_PEER_ID))
>>>>>> +		return -EINVAL;
>>>>>> +
>>>>>> +	if (attrs[OVPN_A_PEER_REMOTE_IPV4] && attrs[OVPN_A_PEER_REMOTE_IPV6]) {
>>>>>> +		NL_SET_ERR_MSG_MOD(info->extack,
>>>>>> +				   "cannot specify both remote IPv4 or IPv6 address");
>>>>>> +		return -EINVAL;
>>>>>> +	}
>>>>>> +
>>>>>> +	if (!attrs[OVPN_A_PEER_REMOTE_IPV4] &&
>>>>>> +	    !attrs[OVPN_A_PEER_REMOTE_IPV6] && attrs[OVPN_A_PEER_REMOTE_PORT]) {
>>>>>> +		NL_SET_ERR_MSG_MOD(info->extack,
>>>>>> +				   "cannot specify remote port without IP address");
>>>>>> +		return -EINVAL;
>>>>>> +	}
>>>>>> +
>>>>>> +	if (!attrs[OVPN_A_PEER_REMOTE_IPV4] &&
>>>>>> +	    attrs[OVPN_A_PEER_LOCAL_IPV4]) {
>>>>>> +		NL_SET_ERR_MSG_MOD(info->extack,
>>>>>> +				   "cannot specify local IPv4 address without remote");
>>>>>> +		return -EINVAL;
>>>>>> +	}
>>>>>> +
>>>>>> +	if (!attrs[OVPN_A_PEER_REMOTE_IPV6] &&
>>>>>> +	    attrs[OVPN_A_PEER_LOCAL_IPV6]) {
>>>>>
>>>>> I think these consistency checks should account for v4mapped
>>>>> addresses. With remote=v4mapped and local=v6 we'll end up with an
>>>>> incorrect ipv4 "local" address (taken out of the ipv6 address's first
>>>>> 4B by ovpn_peer_reset_sockaddr). With remote=ipv6 and local=v4mapped,
>>>>> we'll pass the last 4B of OVPN_A_PEER_LOCAL_IPV6 to
>>>>> ovpn_peer_reset_sockaddr and try to read 16B (the full ipv6 address)
>>>>> out of that.
>>>>
>>>> Right, a v4mapped address would fool this check.
>>>> How about checking if both or none addresses are v4mapped? This way we
>>>> should prevent such cases.
>>>
>>> I don't know when userspace would use v4mapped addresses,
>>
>> It happens when listening on [::] with a v6 socket that has no "IPV6_V6ONLY"
>> set to true (you can check ipv6(7) for more details).
>> This socket can receive IPv4 connections, which are implemented using
>> v4mapped addresses. In this case both remote and local are going to be
>> v4mapped.
> 
> I'm familiar with v4mapped addresses, but I wasn't sure the userspace
> part would actually passed them as peer. But I guess it would when the
> peer connects over ipv4 on an ipv6 socket.
> 
> So the combination of PEER_IPV4 with LOCAL_IPV6(v4mapped) should never
> happen? In that case I guess we just need to check that we got 2
> attributes of the same type (both _IPV4 or both _IPV6) and if we got
> _IPV6, that they're either both v4mapped or both not. Might be a tiny
> bit simpler than what I was suggesting below.

Exactly - this is what I was originally suggesting, but your solution is 
just a bit cleaner imho.

> 
>> However, the sanity check should make sure nobody can inject bogus
>> combinations.
>>
>>> but treating
>>> a v4mapped address as a "proper" ipv4 address should work with the
>>> rest of the code, since you already have the conversion in
>>> ovpn_nl_attr_local_ip and ovpn_nl_attr_sockaddr_remote. So maybe you
>>> could do something like (rough idea and completely untested):
>>>
>>>       static int get_family(attr_v4, attr_v6)
>>>       {
>>>          if (attr_v4)
>>>              return AF_INET;
>>>          if (attr_v6) {
>>>              if (ipv6_addr_v4mapped(attr_v6)
>>>                  return AF_INET;
>>>              return AF_INET6;
>>>          }
>>>          return AF_UNSPEC;
>>>       }
>>>
>>>
>>>       // in _precheck:
>>>       // keep the   attrs[OVPN_A_PEER_REMOTE_IPV4] && attrs[OVPN_A_PEER_REMOTE_IPV6]  check
>>>       // maybe add a similar one for   LOCAL_IPV4 && LOCAL_IPV6
>>
>> the latter is already covered by:
>>
>>   192         if (!attrs[OVPN_A_PEER_REMOTE_IPV4] &&
>>   193             attrs[OVPN_A_PEER_LOCAL_IPV4]) {
>>   194                 NL_SET_ERR_MSG_MOD(info->extack,
>>   195                                    "cannot specify local IPv4 address
>> without remote");
>>   196                 return -EINVAL;
>>   197         }
>>   198
>>   199         if (!attrs[OVPN_A_PEER_REMOTE_IPV6] &&
>>   200             attrs[OVPN_A_PEER_LOCAL_IPV6]) {
>>   201                 NL_SET_ERR_MSG_MOD(info->extack,
>>   202                                    "cannot specify local IPV6 address
>> without remote");
>>   203                 return -EINVAL;
>>   204         }
> 
> LOCAL_IPV4 combined with REMOTE_IPV6 should be fine if the remote is
> v4mapped. And conversely, LOCAL_IPV6 combined with REMOTE_IPV6 isn't
> ok if remote is v4mapped. So those checks should go away and be
> replaced with the "get_family" thing, but that requires at most one of
> the _IPV4/_IPV6 attributes to be present to behave consistently.

I don't expect to receive a mix of _IPV4 and _IPV6, because the 
assumption is that either both addresses are v4mapped or none.

Userspace fetches the addresses from the received packet, so I presume 
they will both be exposed as v4mapped if we are in this special case.

Hence, I don't truly want to allow combining them.

Does it make sense?

> 
> 
>>>
>>>       remote_family = get_family(attrs[OVPN_A_PEER_REMOTE_IPV4], attrs[OVPN_A_PEER_REMOTE_IPV6]);
>>>       local_family = get_family(attrs[OVPN_A_PEER_LOCAL_IPV4], attrs[OVPN_A_PEER_LOCAL_IPV6]);
>>>       if (remote_family != local_family) {
>>>           extack "incompatible address families";
>>>           return -EINVAL;
>>>       }
>>>
>>> That would mirror the conversion that
>>> ovpn_nl_attr_local_ip/ovpn_nl_attr_sockaddr_remote do.
>>
>> Yeah, pretty much what I was suggested, but in a more explicit manner.
>> I like it.
> 
> Cool.
> 
> BTW, I guess scope_id should only be used when it's not a v4mapped address?
> So the "cannot specify scope id without remote IPv6 address" check
> should probably use:
> 
>      if (remote_family != AF_INET6)

Right!

> 
> (or split it into !attrs[OVPN_A_PEER_REMOTE_IPV6] and remote_family !=
> AF_INET6 to have a fully specific extack message, but maybe that's
> overkill)

Yeah, maybe splitting works better.

Thanks a lot!

Regards,

> 

-- 
Antonio Quartulli
OpenVPN Inc.


