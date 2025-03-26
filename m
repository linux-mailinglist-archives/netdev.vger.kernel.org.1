Return-Path: <netdev+bounces-177693-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD619A714B9
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 11:24:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AC6F1793E4
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 10:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC101B653C;
	Wed, 26 Mar 2025 10:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="ghV426rt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4741B0F3C
	for <netdev@vger.kernel.org>; Wed, 26 Mar 2025 10:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742984564; cv=none; b=KqGCI1XhG87QfBJcoxOQQDNgXrL+MkCmbeNkhG3G5S67/ivSFiE8gwiXhKm25TdTZu/kZcH5to1QW/q/aaJ96YRfieFhbEDjaTiZlslbBfc4msLPPI/Vqp7uD0RLYfxj0Hxhqf1qkqCHdO//V0JuxHPcLqjbP2x7VkY9LmptPzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742984564; c=relaxed/simple;
	bh=BqWwb0xLvwtow4UVNuwfZIbhHuDESy5C7BmEnmnVeLk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uycC+2ECn/hQ8Oar6EULw6m+V9M+Xgg9OeKnbfbCNnQ7NnGtgYTddDIhXgYo7iiEDIL0oMMJagD4aAvu10tFDLKPbxgoeE2DFyAhhtpl1x0bVncxmm0z+wWgil3RMSQfH5rrTrsoGuinJm+zk2XMxb5Xi96qrLIlgfzJ0w6PZDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=ghV426rt; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ac2a089fbbdso143924066b.1
        for <netdev@vger.kernel.org>; Wed, 26 Mar 2025 03:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1742984559; x=1743589359; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=XzGTmtio/DS5cJAgg4c6s0hQtINp6fDQ58QRoa7g8YE=;
        b=ghV426rtpKgRwwYUiegxuH3SDEDoLlIBX0LBn5OlpgKbdOVSAiQUx4e/tCIt9hb+Ve
         d7h7RHTWaZf3RLsRO8UDScTCbR6GIeTPZ3yB+orDVcvdiF1VtLuT46zDmjrQCP2eixxd
         16AEi9/U0od/eBKwdCPh9M2bNcQrLJjnwZI5OBouLYPY+4oePGTf2tiD765ekdqTdgyf
         c3gfgDse6eyW8eJqylpGgCHX6Kjdj79yylD9uakFzKBW825FTdCzZ6mKa+iCH4593E+M
         x9taa9p8ZRpOzHbMZW5dX1uTkvx52dBCMCjHUpBxWwWFuDP25uZAYL/lOkaQdP4h0Xcv
         EE5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742984559; x=1743589359;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XzGTmtio/DS5cJAgg4c6s0hQtINp6fDQ58QRoa7g8YE=;
        b=oehfNSfJGCXoHivc2p3uh8ARYFot4CnmkdUGldclTqhIyY1E7+YMOIo2Z8owjdNz+C
         DWApiaESS/sMFMXKXntvdVf9/gCzaBxTn2T+2+CHztXpQ0Yc7ItSkEU+cUzbXjWlo1Fs
         RZJRFCdBU68MPGybsI7PN/eSpae2fPnVD8SOWp1j9CH8/M3fejR8eqce8c9xyk0BRudn
         fQE9t0asaHuhJkO6LcWbOyTDVSFBngjT7NUh2hl6H9HKu2TXQYZDwBzVDiCL7+s+kNox
         RDrYn2rQf4MP7bGBaqhAKdgxI2bmgB9XAM8W2c7e+JQa3wHkKvgHtqecw6/vOtfUXPyK
         3Q4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVwA9JphQwKkppB8JeRLKK0GSGSi28JDSVsnU86irRTKQCZXAOKPbZAOmVWRLIVJq2Adh7FFP4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWSpb7BeXIoph/ClFGgA6A8NijEGUhH1StF+s9177IGyU7dEzm
	Pi85Unr91mfXm6XJIap5SHIZ/7WmJJCMCpHqg/FfIeepy2dT2qvC9XvxtUds8Cac7c0Gvl4AyOY
	Qe0B2dKDnGtNaOfzOk7uX4D2LUQRcm5lpw1G0w8TX5BZHaZeIRYe7uUrMX3q+
X-Gm-Gg: ASbGncuZ/Iq+gUi7NaMFd74F7gpudvLY2XynJIelcz6EOYrYjiMWNAo7lMKraC4QWBT
	9PyH8gNqEOfN+zIlUFBDALsa/aT6QcrUO2q2vnERiV6Wqn2TCDzJRDgN7M1IVOxwwIwjvQYulcm
	VfR20XA7Jq5P9832AmXHiDi02FQ3R7P42e4EFYJKk/neYmlCud0uVj97D9M6mrLfvo8XnHTKVa6
	EOwZJNfHbN3DEL22swFOAfoutTY5GxlMCVBRQCYmpf/f7zSpKQe/ryAIA9H7+bcwApJEZIMnov/
	QvEmB3rZItcxUtoCEKqgoPIs5A3Zd8ESneJqXOgHhttq4lgdS/fAu93uaNL3UvIClmPbUvAdDV/
	IazVLv+Y5jzfq
X-Google-Smtp-Source: AGHT+IG4GaHZJSxp6hmrrP5ViD28WMg/hyB60xxx/rY+rgYW/EHG94yHvHwwfW6wMy2WLRTJwQlPEg==
X-Received: by 2002:a17:907:7204:b0:ac3:25ea:822 with SMTP id a640c23a62f3a-ac6e050a9b6mr305008166b.4.1742984559412;
        Wed, 26 Mar 2025 03:22:39 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:e3b:3856:9645:30d? ([2001:67c:2fbc:1:e3b:3856:9645:30d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3ef21a99asm1008374866b.0.2025.03.26.03.22.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Mar 2025 03:22:38 -0700 (PDT)
Message-ID: <bdcc035e-24c2-4469-a0fd-f63494d74169@openvpn.net>
Date: Wed, 26 Mar 2025 11:22:37 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v24 09/23] ovpn: implement packet processing
To: Qingfang Deng <dqfext@gmail.com>
Cc: Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Shuah Khan <shuah@kernel.org>, sd@queasysnail.net, ryazanov.s.a@gmail.com,
 Andrew Lunn <andrew+netdev@lunn.ch>, Xiao Liang <shaw.leon@gmail.com>
References: <20250318-b4-ovpn-v24-9-3ec4ab5c4a77@openvpn.net>
 <20250325020802.7632-1-dqfext@gmail.com>
 <58712444-1de7-4076-b850-4c6035792931@openvpn.net>
 <CALW65jZ=Jngf0THLTuWHuhpQb0NDM=4x4HN_Xj922nmq71EMUQ@mail.gmail.com>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <CALW65jZ=Jngf0THLTuWHuhpQb0NDM=4x4HN_Xj922nmq71EMUQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 26/03/2025 11:03, Qingfang Deng wrote:
> Hi Antonio,
> 
> On Wed, Mar 26, 2025 at 5:41 PM Antonio Quartulli <antonio@openvpn.net> wrote:
>>>> +/* Get the next packet ID for xmit */
>>>> +static inline int ovpn_pktid_xmit_next(struct ovpn_pktid_xmit *pid, u32 *pktid)
>>>> +{
>>>> +    const s64 seq_num = atomic64_fetch_add_unless(&pid->seq_num, 1,
>>>> +                                                  0x100000000LL);
>>>> +    /* when the 32bit space is over, we return an error because the packet
>>>> +     * ID is used to create the cipher IV and we do not want to reuse the
>>>> +     * same value more than once
>>>> +     */
>>>> +    if (unlikely(seq_num == 0x100000000LL))
>>>> +            return -ERANGE;
>>>
>>> You may use a 32-bit atomic_t, instead of checking if it equals
>>> 0x1_00000000, check if it wraparounds to zero.
>>> Additionally, you don't need full memory ordering as you just want an
>>> incrementing value:
>>>
>>> int seq_num = atomic_fetch_inc_relaxed(&pid->seq_num);
>>>
>>> if (unlikely(!seq_num))
>>>        ...
>>
>> But then if we have concurrent invocations of ovpn_pktid_xmit_next()
>> only the first one will error out on wrap-around, while the others will
>> return no error (seq_num becomes > 0) and will allow the packets to go
>> through.
>>
>> This is not what we want.
> 
> Got it. You could replace it with
> atomic_fetch_add_unless(&pid->seq_num, 1, 0) and check if it wraps
> around to zero.

What about the first time when seq_num is 0? It will already stop, no?

> 
> However, what about the opposite scenario? If multiple threads
> concurrently invoke ovpn_pktid_xmit_next() and all detect the
> wraparound condition, could this lead to simultaneous calls to
> ovpn_crypto_kill_key() and ovpn_nl_key_swap_notify()?

Calling ovpn_crypto_kill_key() multiple times is not an issue, as only 
the first time it'll do something. Subsequent calls are no-op.

But you're right about ovpn_nl_key_swap_notify(): each call will produce 
a notification which we don't want.
I'll make it conditional so that we'll send a notification only if 
ovpn_crypto_kill_key() did the killing.

Thanks for asking this!


Regards,

-- 
Antonio Quartulli
OpenVPN Inc.


