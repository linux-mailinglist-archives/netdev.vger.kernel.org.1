Return-Path: <netdev+bounces-149009-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50AC69E3C59
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 15:13:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C715C1661B0
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 14:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473F61F8913;
	Wed,  4 Dec 2024 14:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="U1WW9Sti"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151F81F707A
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 14:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733321559; cv=none; b=NcknUcv/Ewl73VoCXiYFDktlxjqEVFjBT6vL5KljoPEF4bR1xhbNmeJzJgjKyu+k51Ox+2u9HAUQFm6Wu0Xi8tIGBUtjZFuuRyzMxhxg8AAcWJpGJF/VtmozMYwih6NP7FdPB0bbJBz/vGIifikeHrrWkzGgRG2bHr+Jx430GnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733321559; c=relaxed/simple;
	bh=LAFRiXoR1eyxZsUiSRybV2rO5rZ40IaIIYJpcZeGuP0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=QkYE+8sz+wXKK8Ffd/N30aB2VJZzAguIRG1SGH7sK68YEDjPmDsZDnJK+YvOc6QDuW+gf+oSTI78iocW7hQR+QrGO96HJRSUdIa3qDTSdbGK+S4t9hm8N0RNIwT6ONb5PJu6fdqT6QCd6PxXBKqWRqRLqkONXaPpoXSWtrzGkb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=U1WW9Sti; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aa55171d73cso178104066b.0
        for <netdev@vger.kernel.org>; Wed, 04 Dec 2024 06:12:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1733321555; x=1733926355; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T36hNeDh4s4ctdjTEG4EQB7Xp8fYpuEsKp+LcwDEnrs=;
        b=U1WW9Stiae7zmDripK8w2eMLSs1/rH0KLL7EApRDMTh2h+KTPZBzgHY0nRytWdp0xW
         PBrVqPsAR59cydJYHencOiLEaASxPhnmSt1mrDngrbNZmV6l67g97/H6qveO9si+v+vr
         jdMrH8wUcS2SsiWrqvgiwQqMF0I+O/MmwgcqrVgVSsmZpsH49WrFjviQKE8nRlZYiViO
         9r4se3RvqN56s8xRBOaBDoGz3XbHaaH0VUK3VCFVz/moEQ54i3KkbPd+jNIEl/84hNu7
         dhc5Kh99k+0kNn4WkVyNOJDGgO3ZgaG30YKx6n+SWvtpYxCU6+XOCP6eAAw0xR51zJUd
         aT5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733321555; x=1733926355;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:from:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=T36hNeDh4s4ctdjTEG4EQB7Xp8fYpuEsKp+LcwDEnrs=;
        b=ZDWm/0kpBU4gj3rAkAyfro8tQoHUUteQBsAZt6byf8ta1LV95Vc9y2jti4Ko4VFQO5
         RB+4846ahb/Z6b6Y1u/mB97pOpkGvmPXBdWXDt5nhnJyfQMAURN+u3pySO7cXxCY57GW
         KPv0bP7mVHGMLczW3Cq/NlcezT9rfkDdrq+laNN94YGkcDW5/y2LH5ylvb628JXK1ZSB
         H+VgaM0yRzWUYMPNsPQMhvbYXCXImkEgZZrcOLCDfLeEwk7liO+rqTt7chqL7+g8Jf2C
         I2uG4bcNhpd0WozAgbopfB0nS0tMbaEGzO7phGO1P0rkMlQSGAkRgxkTKW+Xz5Y+Bxfi
         FHAQ==
X-Forwarded-Encrypted: i=1; AJvYcCViAT4shOQ8CwN3Drv2ag7YZaB5XxiyWN19U0xvxmZTqn/KfTaoQ0V1GyDb91Ay4xffDLYBeFE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ5kJbog8DjbJHQmEfdeXvS5tiOyHSDoUxU2R3Lh7E8vLyQJ9+
	oEi5LSx/Cmqlohti7ERbOkd54/l6+SNu+ucjG0BWYmEkHWO+BnMxEFc2iqn0CgMpEeasrYmEnKE
	d
X-Gm-Gg: ASbGncuNRQKcqx8VP76WmODm5COdcMvJAryJ5hWqU3XAKG/+06ZIQ+rVxJtUuK2+RdH
	Y2Mets2WAgwtmIU7EPjT6beDxNvTGUTgjLbw8WLj5Iy337xnBAXA5IyKTCF8P2DYfRQls2OkdIs
	SbdOGuArDahMHAtyxGF/TL29eavGtP9j7oT3Gx+Ie9gYT5AF1AeSW87QzbLS/rJ+SIN+zt7Fus0
	qHz8WfqyhbrLhEc9X/KNer0OGQbCmqwQXuAaUnqk7kM8zrab9YDku6jYeey4xqqVrxl9Sj2IHT1
	YCZG5rhJi9C/
X-Google-Smtp-Source: AGHT+IFDpFDh2hT5bc54V4RHf7eiVb15vsRRml8Z5zP57LBHiQjS1dQpicFqMeRkHePjXUbJdALHIw==
X-Received: by 2002:a17:906:31ce:b0:aa5:4d1c:78aa with SMTP id a640c23a62f3a-aa5f70da47bmr651138966b.5.1733321555424;
        Wed, 04 Dec 2024 06:12:35 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:85f4:5278:b2f6:64fb? ([2001:67c:2fbc:1:85f4:5278:b2f6:64fb])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa5998e6345sm738249566b.109.2024.12.04.06.12.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Dec 2024 06:12:34 -0800 (PST)
Message-ID: <5ad48b64-1f83-4a62-addd-3008d5faa2f5@openvpn.net>
Date: Wed, 4 Dec 2024 15:13:14 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 13/22] ovpn: implement peer lookup logic
From: Antonio Quartulli <antonio@openvpn.net>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 ryazanov.s.a@gmail.com, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Donald Hunter <donald.hunter@gmail.com>, Shuah Khan <shuah@kernel.org>,
 Andrew Lunn <andrew@lunn.ch>
References: <20241202-b4-ovpn-v12-0-239ff733bf97@openvpn.net>
 <20241202-b4-ovpn-v12-13-239ff733bf97@openvpn.net>
 <5052453b-edd8-44e2-8df7-00ea439805ad@openvpn.net> <Z08tV5vQe2S4iawi@hog>
 <b4627d32-8d17-4253-8687-a451d7a1052e@openvpn.net>
Content-Language: en-US
Autocrypt: addr=antonio@openvpn.net; keydata=
 xsFNBFN3k+ABEADEvXdJZVUfqxGOKByfkExNpKzFzAwHYjhOb3MTlzSLlVKLRIHxe/Etj13I
 X6tcViNYiIiJxmeHAH7FUj/yAISW56lynAEt7OdkGpZf3HGXRQz1Xi0PWuUINa4QW+ipaKmv
 voR4b1wZQ9cZ787KLmu10VF1duHW/IewDx9GUQIzChqQVI3lSHRCo90Z/NQ75ZL/rbR3UHB+
 EWLIh8Lz1cdE47VaVyX6f0yr3Itx0ZuyIWPrctlHwV5bUdA4JnyY3QvJh4yJPYh9I69HZWsj
 qplU2WxEfM6+OlaM9iKOUhVxjpkFXheD57EGdVkuG0YhizVF4p9MKGB42D70pfS3EiYdTaKf
 WzbiFUunOHLJ4hyAi75d4ugxU02DsUjw/0t0kfHtj2V0x1169Hp/NTW1jkqgPWtIsjn+dkde
 dG9mXk5QrvbpihgpcmNbtloSdkRZ02lsxkUzpG8U64X8WK6LuRz7BZ7p5t/WzaR/hCdOiQCG
 RNup2UTNDrZpWxpwadXMnJsyJcVX4BAKaWGsm5IQyXXBUdguHVa7To/JIBlhjlKackKWoBnI
 Ojl8VQhVLcD551iJ61w4aQH6bHxdTjz65MT2OrW/mFZbtIwWSeif6axrYpVCyERIDEKrX5AV
 rOmGEaUGsCd16FueoaM2Hf96BH3SI3/q2w+g058RedLOZVZtyQARAQABzSdBbnRvbmlvIFF1
 YXJ0dWxsaSA8YW50b25pb0BvcGVudnBuLm5ldD7Cwa0EEwEIAFcCGwMFCwkIBwMFFQoJCAsF
 FgIDAQACHgECF4AFCRWQ2TIWIQTKvaEoIBfCZyGYhcdI8My2j1nRTAUCYRUquBgYaGtwczov
 L2tleXMub3BlbnBncC5vcmcACgkQSPDMto9Z0UzmcxAAjzLeD47We0R4A/14oDKlZxXO0mKL
 fCzaWFsdhQCDhZkgxoHkYRektK2cEOh4Vd+CnfDcPs/iZ1i2+Zl+va79s4fcUhRReuwi7VCg
 7nHiYSNC7qZo84Wzjz3RoGYyJ6MKLRn3zqAxUtFECoS074/JX1sLG0Z3hi19MBmJ/teM84GY
 IbSvRwZu+VkJgIvZonFZjbwF7XyoSIiEJWQC+AKvwtEBNoVOMuH0tZsgqcgMqGs6lLn66RK4
 tMV1aNeX6R+dGSiu11i+9pm7sw8tAmsfu3kQpyk4SB3AJ0jtXrQRESFa1+iemJtt+RaSE5LK
 5sGLAO+oN+DlE0mRNDQowS6q/GBhPCjjbTMcMfRoWPCpHZZfKpv5iefXnZ/xVj7ugYdV2T7z
 r6VL2BRPNvvkgbLZgIlkWyfxRnGh683h4vTqRqTb1wka5pmyBNAv7vCgqrwfvaV1m7J9O4B5
 PuRjYRelmCygQBTXFeJAVJvuh2efFknMh41R01PP2ulXAQuVYEztq3t3Ycw6+HeqjbeqTF8C
 DboqYeIM18HgkOqRrn3VuwnKFNdzyBmgYh/zZx/dJ3yWQi/kfhR6TawAwz6GdbQGiu5fsx5t
 u14WBxmzNf9tXK7hnXcI24Z1z6e5jG6U2Swtmi8sGSh6fqV4dBKmhobEoS7Xl496JN2NKuaX
 jeWsF2rOwE0EZmhJFwEIAOAWiIj1EYkbikxXSSP3AazkI+Y/ICzdFDmiXXrYnf/mYEzORB0K
 vqNRQOdLyjbLKPQwSjYEt1uqwKaD1LRLbA7FpktAShDK4yIljkxhvDI8semfQ5WE/1Jj/I/Q
 U+4VXhkd6UvvpyQt/LiWvyAfvExPEvhiMnsg2zkQbBQ/M4Ns7ck0zQ4BTAVzW/GqoT2z03mg
 p1FhxkfzHMKPQ6ImEpuY5cZTQwrBUgWif6HzCtQJL7Ipa2fFnDaIHQeiJG0RXl/g9x3YlwWG
 sxOFrpWWsh6GI0Mo2W2nkinEIts48+wNDBCMcMlOaMYpyAI7fT5ziDuG2CBA060ZT7qqdl6b
 aXUAEQEAAcLBfAQYAQgAJhYhBMq9oSggF8JnIZiFx0jwzLaPWdFMBQJmaEkXAhsMBQkB4TOA
 AAoJEEjwzLaPWdFMbRUP/0t5FrjF8KY6uCU4Tx029NYKDN9zJr0CVwSGsNfC8WWonKs66QE1
 pd6xBVoBzu5InFRWa2ed6d6vBw2BaJHC0aMg3iwwBbEgPn4Jx89QfczFMJvFm+MNc2DLDrqN
 zaQSqBzQ5SvUjxh8lQ+iqAhi0MPv4e2YbXD0ROyO+ITRgQVZBVXoPm4IJGYWgmVmxP34oUQh
 BM7ipfCVbcOFU5OPhd9/jn1BCHzir+/i0fY2Z/aexMYHwXUMha/itvsBHGcIEYKk7PL9FEfs
 wlbq+vWoCtUTUc0AjDgB76AcUVxxJtxxpyvES9aFxWD7Qc+dnGJnfxVJI0zbN2b37fX138Bf
 27NuKpokv0sBnNEtsD7TY4gBz4QhvRNSBli0E5bGUbkM31rh4Iz21Qk0cCwR9D/vwQVsgPvG
 ioRqhvFWtLsEt/xKolOmUWA/jP0p8wnQ+3jY6a/DJ+o5LnVFzFqbK3fSojKbfr3bY33iZTSj
 DX9A4BcohRyqhnpNYyHL36gaOnNnOc+uXFCdoQkI531hXjzIsVs2OlfRufuDrWwAv+em2uOT
 BnRX9nFx9kPSO42TkFK55Dr5EDeBO3v33recscuB8VVN5xvh0GV57Qre+9sJrEq7Es9W609a
 +M0yRJWJEjFnMa/jsGZ+QyLD5QTL6SGuZ9gKI3W1SfFZOzV7hHsxPTZ6
Organization: OpenVPN Inc.
In-Reply-To: <b4627d32-8d17-4253-8687-a451d7a1052e@openvpn.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 04/12/2024 09:28, Antonio Quartulli wrote:
> On 03/12/2024 17:09, Sabrina Dubroca wrote:
>> 2024-12-03, 15:58:17 +0100, Antonio Quartulli wrote:
>>> On 02/12/2024 16:07, Antonio Quartulli wrote:
>>> [...]
>>>> +#define ovpn_get_hash_slot(_key, _key_len, _tbl) ({    \
>>>> +    typeof(_tbl) *__tbl = &(_tbl);            \
>>>> +    jhash(_key, _key_len, 0) % HASH_SIZE(*__tbl);    \
>>>> +})
>>>> +
>>>> +#define ovpn_get_hash_head(_tbl, _key, _key_len) ({        \
>>>> +    typeof(_tbl) *__tbl = &(_tbl);                \
>>>> +    &(*__tbl)[ovpn_get_hash_slot(_key, _key_len, *__tbl)];    \
>>>> +})
>>>
>>> clang a reporting various warnings like this:
>>>
>>> ../drivers/net/ovpn/peer.c:406:9: warning: variable '__tbl' is 
>>> uninitialized
>>> when used within its own initialization [-Wuninitialized]
>>>    406 |         head = ovpn_get_hash_head(ovpn->peers->by_id, &peer_id,
>>>        |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>    407 |                                   sizeof(peer_id));
>>>        |                                   ~~~~~~~~~~~~~~~~
>>> ../drivers/net/ovpn/peer.c:179:48: note: expanded from macro
>>> 'ovpn_get_hash_head'
>>>    179 |         &(*__tbl)[ovpn_get_hash_slot(_key, _key_len, 
>>> *__tbl)];  \
>>>        |                   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~
>>> ../drivers/net/ovpn/peer.c:173:26: note: expanded from macro
>>> 'ovpn_get_hash_slot'
>>>    173 |         typeof(_tbl) *__tbl = &(_tbl);                  \
>>>        |                       ~~~~~     ^~~~
>>>
>>> Anybody willing to help me understand this issue?
>>>
>>> I have troubles figuring out how __tbl is being used uninitialized.
>>> I wonder if the parameters naming is fooling clang (or me) somehow.
>>
>> Not really a solution to this specific issue, but do you actually need
>> ovpn_get_hash_slot as a separate macro? AFAICT all users could also be
>> converted to ovpn_get_hash_head, then you can merge ovpn_get_hash_slot
>> into ovpn_get_hash_head and maybe clang won't get confused?
>>
>> No guarantee that this fixes anything (except saving one or two lines
>> in a few functions).
> 
> This is what it used to be before (and no error was reported), but I had 
> to split the macro because I need to isolate the slot computation for 
> nulls comparison. So there are some users for ovpn_get_hash_slot()
> 
> I will quickly try changing the naming and see if clang gets happier.

Indeed it's the declaration of __tbl in ovpn_get_hash_slot() that 
confuses clang.
I'll rename both __tbl and add a comment to remember why we did that.

Regards,

> 
> Regards,
> 
> 

-- 
Antonio Quartulli
OpenVPN Inc.


