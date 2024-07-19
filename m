Return-Path: <netdev+bounces-112189-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3252B937568
	for <lists+netdev@lfdr.de>; Fri, 19 Jul 2024 10:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2383F1C20C75
	for <lists+netdev@lfdr.de>; Fri, 19 Jul 2024 08:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 349E569959;
	Fri, 19 Jul 2024 08:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="KS1n2iKK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA59F3236
	for <netdev@vger.kernel.org>; Fri, 19 Jul 2024 08:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721379448; cv=none; b=UPumazdQBjtKR3ulRs5njuTPk24X1aiKIZ956FNtWTieAuz60E16ZDeOmTBny2Nu7U00shQRv00rkO+Q8Iseh03Xdtozek/7tnzOoa5bBpP/Ysrm88RTh+MEVKobpc0EtXCj68KQdJKQbqhTKVvbUK9FzezJtVO8dHz7S969bB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721379448; c=relaxed/simple;
	bh=Ogq5tK5optkI/YJuFWc2cPNg8VNTe7LUcyZXqa4LNdo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r+IF0FOchavuZxIYx3ib89uXO12F6mytSgmNwZafm7ZNFGsjlWHko+kEVc0hEB/+WIMw9nAlDKYvU130JIWuz5XC0vjgrmTc0mBZYNZxvnBYwgdlq793uVCRpDGqTkrBDzj4TePWWagTrmS3rTEZcai+zRidrkQSXw17INuQKyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=KS1n2iKK; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4267300145eso11255485e9.3
        for <netdev@vger.kernel.org>; Fri, 19 Jul 2024 01:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1721379444; x=1721984244; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=O+GwNeposPn0azjqs5L0s0p7UJDRFvmFbvIU73Nfjfs=;
        b=KS1n2iKKOz5CsSsii0tLX8YKM0Fy1qTku3s8gduQ2ArS/Okj0bAQCUybP+dWNCndB2
         0m8+eaNgiNotJuZGkvpxMVmzR8VQSpc6S9y376a4lj8yXeGxcvX6Nf3LZ119qhUqMuot
         4GVUS4TKssxBm70T+7g/bHe75CL65/XLCBT5JrTS9Tgcl8AuJ9egUJV2LgRhBQmb0j2K
         thJaxZUzomEKKUwN/QU4ALY+Rq4EZvfF16c2W7aZF3fJeF4bWDxlCONFLUzezVnhSR4R
         TjSOHKQLcRN7mnSvKJb4gPf5+lt9bg+vRfywJDbZ9TjXPZhPCU9W49tKhphXzb2jl2ov
         KiyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721379444; x=1721984244;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O+GwNeposPn0azjqs5L0s0p7UJDRFvmFbvIU73Nfjfs=;
        b=BzcoyvV86WpkLD9g+GgkFJaM3i+92sURJ0l/P+80x3VSgDhbIkaM34t2Zcu74ziYgk
         fkxpMoOw4m2rqbOwbj4Vk2FRbRy6RHTgYukWX3plDDqcjBotyfoDMXZjBAO+cQshFcTj
         3ohlizEd59a0e0H6Mk4NtcUvlkb3Hd+sfrxpMRrqml66VvGwvj1xhFxmQFN8kLWrPns6
         GZf+RK02IwfwE7vHqkGKskb71GTN4sC5GH1KB/cRQPHe/6MR0/C8QbeOn0v5Ug9Q5SVO
         0B6OV2TRCsjok/WD2BFqMhB79uGJmw65jhiIN/oBX1BEKvpgc2z5Fvqn8ZwwVWVexjUy
         Y/lg==
X-Forwarded-Encrypted: i=1; AJvYcCV6yv8o044nlkVOVfhtqzkepl7bsGXSlEUOLr5CnMMJW7P3+yjbevTvwLSHjrGUvNw7qrV8B6SL2KxLpAMmSMRiceVIE7OR
X-Gm-Message-State: AOJu0YxF5++sbr6mmmBi30/vGlkVx/ku490+QYFCzA3ys4GOcnUsmCWm
	a3x+7unkPp4D/A8juF4qJCnHbwXO6ACUSI5NH5XRS4J3YKjJT2+U/5dpEZHRqAk=
X-Google-Smtp-Source: AGHT+IETf7Y2O2C2xAlZptcgHLPEEybvcLxQefx2VRaYDRKI7tkxAaDSbLR5X0qS3h6Ae0giET0NMA==
X-Received: by 2002:a5d:6488:0:b0:367:4dce:1ff4 with SMTP id ffacd0b85a97d-368315f1e56mr7333514f8f.14.1721379444034;
        Fri, 19 Jul 2024 01:57:24 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:4e9d:c9b7:21b6:5935? ([2001:67c:2fbc:1:4e9d:c9b7:21b6:5935])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36878694450sm1017390f8f.51.2024.07.19.01.57.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jul 2024 01:57:23 -0700 (PDT)
Message-ID: <4ec02430-e1e1-4180-857b-14c4591e7d87@openvpn.net>
Date: Fri, 19 Jul 2024 10:59:23 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 17/25] ovpn: implement keepalive mechanism
To: Andrew Lunn <andrew@lunn.ch>
Cc: Sabrina Dubroca <sd@queasysnail.net>, netdev@vger.kernel.org,
 kuba@kernel.org, ryazanov.s.a@gmail.com, pabeni@redhat.com,
 edumazet@google.com
References: <20240627130843.21042-1-antonio@openvpn.net>
 <20240627130843.21042-18-antonio@openvpn.net> <ZpU15_ZNAV5ysnCC@hog>
 <73a305c5-57c1-40d9-825e-9e8390e093db@openvpn.net>
 <69bab34d-2bf2-48b8-94f7-748ed71c07d3@lunn.ch>
 <4c26fc98-1748-4344-bb1c-11d8d47cc3eb@openvpn.net>
 <ea6e8939-5dc2-4322-a67f-207a6aa65da9@lunn.ch>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <ea6e8939-5dc2-4322-a67f-207a6aa65da9@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/07/2024 05:31, Andrew Lunn wrote:
> On Thu, Jul 18, 2024 at 09:46:00AM +0200, Antonio Quartulli wrote:
>> On 18/07/2024 04:01, Andrew Lunn wrote:
>>>>>> +		if (ovpn_is_keepalive(skb)) {
>>>>>> +			netdev_dbg(peer->ovpn->dev,
>>>>>> +				   "ping received from peer %u\n", peer->id);
>>>>>
>>>>> That should probably be _ratelimited, but it seems we don't have
>>>>> _ratelimited variants for the netdev_* helpers.
>>>>
>>>> Right.
>>>> I have used the net_*_ratelimited() variants when needed.
>>>> Too bad we don't have those.
>>>
>>> If you think netdev_dbg_ratelimited() would be useful, i don't see why
>>> you cannot add it.
>>>
>>> I just did an search and found something interesting in the history:
>>>
>>> https://lore.kernel.org/all/20190809002941.15341-1-liuhangbin@gmail.com/T/#u
>>>
>>> Maybe limit it to netdev_dbg_ratelimited() to avoid the potential
>>> abuse DaveM was worried about.
>>
>> I see what Dave says however...
>>
>> ...along the packet processing routine there are several messages (some are
>> err or warn or info) which require ratelimiting.
>> Otherwise you end up with a gazilion log entries in case of a long lasting
>> issue.
>>
>> Right now I am using net_dbg/warn/err/info_ratelimited(), therefore not
>> having a netdev counterpart is not really helping with Dave's argument.
> 
> Yes, i think Dave' argument is weak because these alternatives
> exist. Maybe they did not at the time?

They did and it's exactly what Hangbin was introducing:

https://lore.kernel.org/all/20190801090347.8258-1-liuhangbin@gmail.com/

before being suggested by Joe to implement the new macros:

https://lore.kernel.org/all/209f7fe62e2a79cd8c02b104b8e3babdd16bff30.camel@perches.com/

> 
> I suspect he was using it as a way to force fixing the real issue. A
> driver should not be issues lots of err or info messages. Protocol
> errors are part of normal behaviour, just increment a counter and keep
> going. Peer devices disappearing is normal behaviour, count it and
> keep going. _err is generally reserved for something fatal happened,
> and there is no recovery, other than unload the kernel module and
> reload it.

Yeah, it looks like it and David pushed them to rethink the error 
handling rather than making the error less painful.

But I can still netdev_dbg_ratelimited useful for debugging/development.
Anyway, I will add this to my todo and see if this specific variant can 
be accepted.

Regards,

-- 
Antonio Quartulli
OpenVPN Inc.

