Return-Path: <netdev+bounces-95875-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF8B28C3BDA
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 09:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BA8AB20B01
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 07:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2828146A80;
	Mon, 13 May 2024 07:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="RgPclb4f"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C385146A76
	for <netdev@vger.kernel.org>; Mon, 13 May 2024 07:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715585053; cv=none; b=j8StAWE72FjD/JoCGwLiiGgqq+m/0w8M2OrjLZYCPBD2Dy/Mb+g7knch03a6AW7tfzuQlqTtf2/+EbLHUbOWNtnDSceDheJdNZnVasXwa8Z1FJeoIYG46P4Rhh/3aj3VkPWD85um3BHV7eH4oAzyixR0XkDJPzwPeq+3qeCSnlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715585053; c=relaxed/simple;
	bh=gXR2GhS9hpjayE7jVGc8PVHJHdSU67jRihNMj9tn72k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lnF6TnA1ydiKj57LqtgBerVTc4OPd71UCDO3gqkFBPRSTupP5UUF+v2NbMz+d2c2gOoWtRfWAf5BJ4gArEU/73Rhg1J27Fe6XZhNFpDTeLCrrstufCtnI3PYP8UCREhFeIs4df+3bNkKqiH9SBoh60yLEvMdhLvCfgamTt0CoUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=RgPclb4f; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-41fe54cb0e3so24446635e9.2
        for <netdev@vger.kernel.org>; Mon, 13 May 2024 00:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1715585050; x=1716189850; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yKa3xZbGkFuKRYQlfSjgaB697IFSAtR2pNhD+xLaT8Q=;
        b=RgPclb4fsB72W4JONRVDXowBy9fMguT36JITiORUiu7JMHmySK5qDHIXBKdQXkZ0Wk
         olXLyPUoobOyCtHHwgl6Ar08VkGqR4df1UcSpbSpKpnhFA7v3lwUm6dI+JnZvZ8dueKJ
         FqVqb8/Z+OQHuUeZeMDxOD53t8F6bCZi3R4QeyjMHF+Y66TIhpSzqVRjnyZiKcOCJfI5
         3nY0aqJwtsDPyr4wMZgjrrRDtgdYuBh7pOhnFQZ/rq/2KEUj3D1MqXLvRiMz0KHi4g9R
         TD/Asu9XX5IKPrU7LZdFUdf2lvhsalK3X703xHgdzP5AsXAwe/Pfv4NALP8QLBeYpOPi
         UICw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715585050; x=1716189850;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yKa3xZbGkFuKRYQlfSjgaB697IFSAtR2pNhD+xLaT8Q=;
        b=dNz/5Y0xvPch/ev5HexSO6BlDCOk/vxS0FfWqmkyPuoSZjpqYYCWfXRzRaJJzzF152
         jtn9MlwvvfhncCRD7S/nsxKJlk3xKK3mgOfIYGi84mM/0nqNvZdkWSeCJFDKmkaRoDzj
         czIvAPwwuwe4RuBm1ZI7btr5QkN79VWNSlER6V7C6CyaYPUTQmGeVmqfdIEFOIyi4pqn
         RM82OAGZZtM7+SL63N+BvviSZagRJhwkucbGIsH8N8PS5qP6ZTQvIc2SMOgon7GU8GAc
         yQ1YTG6H7c5RTPHuF23nA2S9LjAJGgtwDGk1GWKztlhd7WQhIs3WZZn1FxLpvylQz32Y
         JAEQ==
X-Gm-Message-State: AOJu0YxBydICsViCAbtWIAEE4JGK76ma9W13fpapt83mTQF0ci6VBNIn
	aMXLs6cu1B0bmDEcyLTJa/VVJj4NXutBqv7feihm9D0Zx33xiL0xtS+b+BDLeC8=
X-Google-Smtp-Source: AGHT+IGNzANonl8gZ91n6TQyXI6AAggdMb1yzMIJxOSpyZLMVhvBDryS7G1jOgs7Zk2USmb8GpQvlw==
X-Received: by 2002:a1c:4c07:0:b0:418:f826:58c3 with SMTP id 5b1f17b1804b1-41feaa3947dmr65941255e9.15.1715585049755;
        Mon, 13 May 2024 00:24:09 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:0:b0a4:8921:8456:9b28? ([2001:67c:2fbc:0:b0a4:8921:8456:9b28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-351b79e8e6bsm2777275f8f.65.2024.05.13.00.24.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 May 2024 00:24:09 -0700 (PDT)
Message-ID: <f4d2dfc1-5585-4e87-b53d-28890eec4c13@openvpn.net>
Date: Mon, 13 May 2024 09:25:29 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 12/24] ovpn: store tunnel and transport
 statistics
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Sergey Ryazanov <ryazanov.s.a@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew@lunn.ch>,
 Esben Haabendal <esben@geanix.com>
References: <20240506011637.27272-1-antonio@openvpn.net>
 <20240506011637.27272-13-antonio@openvpn.net> <ZkCCPvzuRED57RKL@hog>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <ZkCCPvzuRED57RKL@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/05/2024 10:47, Sabrina Dubroca wrote:
> 2024-05-06, 03:16:25 +0200, Antonio Quartulli wrote:
>> Byte/packet counters for in-tunnel and transport streams
>> are now initialized and updated as needed.
>>
>> To be exported via netlink.
>>
>> Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
>> ---
>>   drivers/net/ovpn/Makefile |  1 +
>>   drivers/net/ovpn/io.c     | 10 ++++++++
>>   drivers/net/ovpn/peer.c   |  3 +++
>>   drivers/net/ovpn/peer.h   | 13 +++++++---
>>   drivers/net/ovpn/stats.c  | 21 ++++++++++++++++
>>   drivers/net/ovpn/stats.h  | 52 +++++++++++++++++++++++++++++++++++++++
> 
> What I'm seeing in this patch are "success" counters. I don't see any
> stats for dropped packets that would help the user figure out why
> their VPN isn't working, or why their CPU is burning up decrypting
> packets that don't show up on the host, etc. You can guess there are
> issues by subtracting the link and vpn stats, but that's very limited.

This stats are just the bare minimum to make our current userspace happy :-)

But we can always extend the stats reporting later on, no?

> 
> For example:
>   - counter for packets dropped during the udp encap/decap
>   - counter for failed encrypt/decrypt (especially failed decrypt)
>   - counter for replay protection failures
>   - counter for malformed packets
> 
> Maybe not a separate counter for each of the prints you added in the
> rx/tx code, but at least enough of them to start figuring out what's
> going on without enabling all the prints and parsing dmesg.

Definitely a good suggestion! I'd just postpone it for later, unless you 
think it's a blocker.

> 
> 
>> diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
>> index da41d711745c..b5ff59a4b40f 100644
>> --- a/drivers/net/ovpn/peer.h
>> +++ b/drivers/net/ovpn/peer.h
>> @@ -10,14 +10,15 @@
>>   #ifndef _NET_OVPN_OVPNPEER_H_
>>   #define _NET_OVPN_OVPNPEER_H_
>>   
>> +#include <linux/ptr_ring.h>
>> +#include <net/dst_cache.h>
>> +#include <uapi/linux/ovpn.h>
>> +
>>   #include "bind.h"
>>   #include "pktid.h"
>>   #include "crypto.h"
>>   #include "socket.h"
>> -
>> -#include <linux/ptr_ring.h>
>> -#include <net/dst_cache.h>
>> -#include <uapi/linux/ovpn.h>
>> +#include "stats.h"
> 
> Header reshuffling got squashed into the wrong patch?

indeed, darn. Juggling this many patches has been quite tedious

> 
> 
>> diff --git a/drivers/net/ovpn/stats.h b/drivers/net/ovpn/stats.h
>> new file mode 100644
>> index 000000000000..5134e49c0458
>> --- /dev/null
>> +++ b/drivers/net/ovpn/stats.h
>> @@ -0,0 +1,52 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/*  OpenVPN data channel offload
>> + *
>> + *  Copyright (C) 2020-2024 OpenVPN, Inc.
>> + *
>> + *  Author:	James Yonan <james@openvpn.net>
>> + *		Antonio Quartulli <antonio@openvpn.net>
>> + *		Lev Stipakov <lev@openvpn.net>
>> + */
>> +
>> +#ifndef _NET_OVPN_OVPNSTATS_H_
>> +#define _NET_OVPN_OVPNSTATS_H_
>> +
>> +//#include <linux/atomic.h>
>> +//#include <linux/jiffies.h>
> 
> Forgot a clean up before posting? :)

Yeah..I guess I'll write a small script to catch all these things..it's 
easy to lose them across the whole patchset.

Thanks for spotting them! I will make sure they all go away

> 

-- 
Antonio Quartulli
OpenVPN Inc.

