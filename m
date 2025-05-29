Return-Path: <netdev+bounces-194183-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F12C3AC7B92
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 12:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4556B9E776F
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 10:07:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 371ED26C39F;
	Thu, 29 May 2025 10:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="VkvV1raF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C0FA55
	for <netdev@vger.kernel.org>; Thu, 29 May 2025 10:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748513276; cv=none; b=WP0/sS4RokwIYsfEAyWuxwDcRlBgrceHbuAYbDCv7BFn4svkEpia/LWS6js0NurxrLBbQZZZDAZn9z5BSVt/gVLMBv9Z6SH8QD1xSlmhIcJkcCBa7aC0aOTQCGPh++qTuak8iyxXMCpguJdNRQtvodd+FKGrPY1zslywocYyQY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748513276; c=relaxed/simple;
	bh=vX0MYWr9lXGTyMmatholoQSj4K1CgBawIO/sPx0uxtQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cEuLwJ0ML/uwUbr9olgW5ju+wwFrz6qiuCsM0bkw15f+FBSJnb7CX/7lU8RbTVbCrM1KETvoK5Zj6GlRwl1814JN0XPinAI8tGSLEISrgAdZLWC9NeT9J25KySfCCEwMjID88DrlNYh1iTCi8Rksm72W/RMKxpgKXm8IAuv5u5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=VkvV1raF; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ac34257295dso127394466b.2
        for <netdev@vger.kernel.org>; Thu, 29 May 2025 03:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1748513271; x=1749118071; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MJXdIsXIXQV46lIrJRlHtK1bHIDmLx8yks1lM3bDqro=;
        b=VkvV1raF0SBbBdPrwYWiSHG2ChiHWJ60jVRoQyS5p/s8wkSSUKjVWCceHF4qo+3Gb5
         Q1YMukTtoH/yFVHqCI0CEkALDcHt19qz7Eq7nHbc4vF4ub+trN8OPVlv2M0w3g/Ctn/y
         3UWn3V5FPO3I9Yfnfna7t7t0d21cvxP8uSlC9cnJH7FmIQ/bZ4O+ethKL4jwqLUjyirq
         tY+GXTkciklp8EtkJi5yvHaNZkkCtnpoRyl+LVymXchXlAfIS6cKIQpRuo3iz/JXEyjs
         F4vhT104dDSoVj69HoQTTyyU5wPGRe6abITvt8PRqOBQDhUiruhZVQsanT9PU6tE4koy
         XrXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748513271; x=1749118071;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MJXdIsXIXQV46lIrJRlHtK1bHIDmLx8yks1lM3bDqro=;
        b=hu6y1DKvyg8gjrvNlm6vEsS+PuD4rwA8u8dRJiTB84Zidrot3zsmlBxlLZkAFojXbP
         whoM/3WdlDtm4BBnk8yWYl/9XAhgp5xzCWIb8k/FUMgYpCVfv58qZGf16UUG7TJGLY4j
         KC2v2S6tSs4DPTT9Sb47iaXb4kmz0PLa/+aocNpWm+9wDL+hyJGjkE9SLTFmWCe2V0iB
         GyofVc/yJXShn0c1389gA66Tt0jFt69H2tHpXdKnM1G/+W4JPSxOAY56u4fzmmYale6O
         9O4md24OYszr2UV3AVVr0Avv/0pyUn1JupTCyf4DRRbO7pYKQdemWLo6T2wHPmOEFBKZ
         hcHQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+bw2iNdq64dyHvPtnt0xaeCE5948AEnurBoHXce62T1X1TVLzuoZUpoRfhaQ4Hen7g5Fw6oU=@vger.kernel.org
X-Gm-Message-State: AOJu0YziOn/IGISmQP2/mfvhhdn3JdC5QaJxE6t0EvVbdZ6LLPMY+1mN
	LdipOW9HK60Tg4kc2u8P3NwzqNQ0IDDhfa7EtxOX3ckDri2gn5EJSZ5rgWjpys4ByBkEjJ+X386
	A9P50rjGUEHxfKo4NaCVbkKRhJLDK8q/+PuHNcnGIsgXAct5+PY4=
X-Gm-Gg: ASbGncuqM8JTADBQTVdJTCX84xDio0PAcsqxLniXDBQ2quj/hAD7btXw+DWanft3/ZG
	RV7+6M691bf99l7P82k5lpVec58a2FWZftcGKUNx/qkwOgRnXEYDjuHjkn7VBWYUsAzf/ik4DsL
	AhOHwfhXNO8IGf1vNiS9t+QJ//MlgQaVlePXiXhCKsK6Dp3rNzfA+TlAtDwAmMZOPNwOVkX4EVl
	KyYeSjOAvkD0oKvhLxKYgC98M6oFK3cOT2unsCP941/wX54wbtGIJm7zDBiWUWkJViItulmBa67
	gfW7OIvj56fv7ZYZ/+qiyu1uxegArWhcFVdcX0AZXQR6V7YcmvIHvbfGDE6QiW4OMRWjBqariuO
	GGqN0GFclXwis1A==
X-Google-Smtp-Source: AGHT+IGsgK6Poz5ttfZaCo7JuuXDz65rHWteHyROA0tk2+PFgZ5fVhwrSw3cK5PTyyZumTevGjYptA==
X-Received: by 2002:a17:907:f1d1:b0:ad8:9e80:6b9f with SMTP id a640c23a62f3a-ad89e8079fbmr645790966b.15.1748513270764;
        Thu, 29 May 2025 03:07:50 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:d079:e260:1678:9b60? ([2001:67c:2fbc:1:d079:e260:1678:9b60])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ada5d7febffsm114278266b.2.2025.05.29.03.07.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 May 2025 03:07:50 -0700 (PDT)
Message-ID: <736d1f6d-1b07-4671-857d-a0841828fce1@openvpn.net>
Date: Thu, 29 May 2025 12:07:48 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/4] ovpn: ensure sk is still valid during
 cleanup
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Oleksandr Natalenko <oleksandr@natalenko.name>,
 Qingfang Deng <dqfext@gmail.com>, Gert Doering <gert@greenie.muc.de>
References: <20250527134625.15216-1-antonio@openvpn.net>
 <20250527134625.15216-3-antonio@openvpn.net>
 <d9cbe73c-1895-42d7-8c21-70487773c94f@redhat.com>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <d9cbe73c-1895-42d7-8c21-70487773c94f@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29/05/2025 11:44, Paolo Abeni wrote:
> On 5/27/25 3:46 PM, Antonio Quartulli wrote:
>> diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
>> index bea03913bfb1..1dd7e763c168 100644
>> --- a/drivers/net/ovpn/netlink.c
>> +++ b/drivers/net/ovpn/netlink.c
>> @@ -423,9 +423,14 @@ int ovpn_nl_peer_new_doit(struct sk_buff *skb, struct genl_info *info)
>>   	ovpn_sock = ovpn_socket_new(sock, peer);
>>   	/* at this point we unconditionally drop the reference to the socket:
>>   	 * - in case of error, the socket has to be dropped
>> -	 * - if case of success, the socket is configured and let
>> +	 * - if case of success, the socket is configured and we let
>>   	 *   userspace own the reference, so that the latter can
>> -	 *   trigger the final close()
>> +	 *   trigger the final close().
>> +	 *
>> +	 * NOTE: at this point ovpn_socket_new() has acquired a reference
>> +	 * to sock->sk. That's needed especially to avoid race conditions
>> +	 * during cleanup, where sock may still be alive, but sock->sk may be
>> +	 * getting released concurrently.
> 
> This comment duplicate some wording from commit message contents and
> don't add much value IMHO. It could be dropped.

ACK

> 
>> @@ -192,19 +189,30 @@ struct ovpn_socket *ovpn_socket_new(struct socket *sock, struct ovpn_peer *peer)
>>   		rcu_read_unlock();
>>   	}
>>   
>> +	/* increase sk refcounter as we'll store a reference in
>> +	 * ovpn_socket.
>> +	 * ovpn_socket_release() will decrement the refcounter.
>> +	 */
>> +	if (!refcount_inc_not_zero(&sk->sk_refcnt)) {
> 
> How could sk_refcnt be zero here? likely just sock_hold() is sufficient.
> Also I think the reference could be acquired a little later, avoiding at
> least the following chunk.

I just wanted to be safe.
But as you point out I don't see any reason why sk_refcnt would be 0 at 
this point in time.

If we don't have to check the return value, I can definitely postpone 
the sock_hold() a bit more.

> 
> Also IMHO the comment is not very clear. I think it should state
> explicitly which entity is retaining the reference (AFAICS the peer hash
> table).

Ok, I will elaborate a bit more.
Essentially: sk -> ovpn_socket -> ovpn_peer -> peer hash


Thanks a lot!
Regards,

> 
> /P
> 

-- 
Antonio Quartulli
OpenVPN Inc.


