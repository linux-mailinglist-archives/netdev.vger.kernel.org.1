Return-Path: <netdev+bounces-112022-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BAEE9349B6
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 10:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36894284DA8
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 08:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF69855886;
	Thu, 18 Jul 2024 08:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="ED23/0Gh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20581EA8F
	for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 08:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721290814; cv=none; b=IswwjkwLkQnJ9YPWAn4AIOp2ypbRaDjUIuLq0PSAS/NuiW2adTWTjTaj9RsF3s3MLb9VxzPNbLVwBxFCPN9f+U8BSt7mkTSgPvSJyq2iryhX7k6u1oVGRoaIOf8ls93dp3nSDo+u2Ox4hDONYzraWtF5EMkW3F09HFfIDrh9GRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721290814; c=relaxed/simple;
	bh=cPcl/gr8imPmwFy66iW5C1s+37VDrGCKywXFlFUCcbU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Oek9aVsEG48RGbRhjEf+iuNBkFBPcecFKRvFOw9ZeYaqYtHO1NRQKUXDyQ4GMK09IZohnsFY2UZWyNgfQH9/Xik4Scq4x4TtBdIy7zM/ALcZIWzsDPJciX3A2s1kDloWWKgrmn+kWqJ2TuAeTxVSP/p51JjmWCHb4Ajjk51bb/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=ED23/0Gh; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4266ea6a488so364745e9.1
        for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 01:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1721290811; x=1721895611; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=q+PlyT7pC7mg0Ii9BCRl59hN4ArVVPVTuTQKpbg1vbA=;
        b=ED23/0GhzVEom2blJNre58DeCVbzqkDQ5/EyLlfeTza2wy3SoNrUc2MJAJDAcqzfry
         Lc3jFOuqP4NkSzUyo9QFlzXRr1ShDWYk4ZoEeExWQZznlhfgIZQXdeubgrEW/UKLXQyD
         AF/hcOVuCnyVw4JOXFc/mEExuqqdZ5/eCKtPnPFMkz7s3siBiDs3IZtdxKo7az/ETMnM
         2SFOa/rKj+Sg0mPLi78gvUOPkhH83Jirr0qq1eJrFvWCtgrtxzt42O2SmazLYf76/yrI
         oKH5780jHbR6oLw6li+NBRveth5s1fvdusy5imZ5pvtSeqxmzDNVbOLOWAqeF/PRVbkK
         VapA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721290811; x=1721895611;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q+PlyT7pC7mg0Ii9BCRl59hN4ArVVPVTuTQKpbg1vbA=;
        b=s935SeMisZYJ2TVOlUj202mlfI4xO2dDcV5/hbvh/2bphPiBb0YqQNvb9SuiCBG8iH
         RUowHqHGAeaQwtkDRIP12e6FBOXVi5a6TxD7qFJ2A9rk5ANc2aw7+iFmEKryXGrp9DRb
         PBfVjzWx7TGkO/WVKdxuU9Rd1XZvJFuFgE0aeyQ3fsJV++KPVjtogGuQ7nhkWOmAFi56
         bO8nsq9unJqRUu2+CpsXebhqr9CxE9oUbK0XlFu3HZOV08SmBrWvjKomWDO9hJfyW22R
         +RfdFpX5b+LuW3AC8u+vVfNYK2xpqgtdpsDE0lFnMZJmpMgdfezg2/ESb8gDHVEYKKlJ
         VwRg==
X-Gm-Message-State: AOJu0YyJnDWSnyF+A/xPouzWiovyuEHboA+cDN5gIx2YWSANvp7oXWwV
	AZ9kVWGDpnWg2pI1WlLfUtpB/LSyCef3ZfqRHc/Ru30NIqA4dpZKYaMP7bU9dpE=
X-Google-Smtp-Source: AGHT+IEeiZRYDCmhxo3U6y5NSR7YUMNH1Vz2kWULEhvZSrsPI/tw8mGOtvAswV/Ml76ITZl6rjNQ8g==
X-Received: by 2002:a05:600c:3b15:b0:426:59d3:8cae with SMTP id 5b1f17b1804b1-427c2cb87d6mr39121875e9.13.1721290810988;
        Thu, 18 Jul 2024 01:20:10 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:14d5:6a6d:7aec:1e83? ([2001:67c:2fbc:1:14d5:6a6d:7aec:1e83])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d2a8d988sm1613605e9.34.2024.07.18.01.20.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jul 2024 01:20:10 -0700 (PDT)
Message-ID: <1554a7e8-026c-42cf-8938-1de38171b048@openvpn.net>
Date: Thu, 18 Jul 2024 10:22:11 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 17/25] ovpn: implement keepalive mechanism
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, kuba@kernel.org, ryazanov.s.a@gmail.com,
 pabeni@redhat.com, edumazet@google.com, andrew@lunn.ch
References: <20240627130843.21042-1-antonio@openvpn.net>
 <20240627130843.21042-18-antonio@openvpn.net> <ZpU15_ZNAV5ysnCC@hog>
 <73a305c5-57c1-40d9-825e-9e8390e093db@openvpn.net> <ZpgsVYT3wR8HgPZ7@hog>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <ZpgsVYT3wR8HgPZ7@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17/07/2024 22:40, Sabrina Dubroca wrote:
>>>> +/**
>>>> + * ovpn_peer_keepalive_recv_reset - reset keepalive timeout
>>>> + * @peer: peer for which the timeout should be reset
>>>> + *
>>>> + * To be invoked upon reception of an authenticated packet from peer in order
>>>> + * to report valid activity and thus reset the keepalive timeout
>>>> + */
>>>> +static inline void ovpn_peer_keepalive_recv_reset(struct ovpn_peer *peer)
>>>> +{
>>>> +	u32 delta = msecs_to_jiffies(peer->keepalive_timeout * MSEC_PER_SEC);
>>>> +
>>>> +	if (unlikely(!delta))
>>>> +		return;
>>>> +
>>>> +	mod_timer(&peer->keepalive_recv, jiffies + delta);
>>>
>>> This (and ovpn_peer_keepalive_xmit_reset) is going to be called for
>>> each packet. I wonder how well the timer subsystem deals with one
>>> timer getting updated possibly thousands of time per second.
>>>
>>
>> May it even introduce some performance penalty?
> 
> That's what I was worried about, yes.
> 
> I asked Paolo, he suggested checking that we're actually doing any
> change to the timer:
> 
>     if (new_timeout_time != old_timeout_time)
>         mod_timer(...)
> 
> This would reduce the update frequency to one per jiffy, which should
> be acceptable.
> 
>> Maybe we should get rid of the timer object and introduce a periodic (1s)
>> worker which checks some last_recv timestamp on every known peer?
>> What do you think?
> 
> That should work, or the workqueue like Eyal is saying.

I will go with Eyal's approach.
This way we also eliminate any timer related operation from the fast path.


Cheers!



-- 
Antonio Quartulli
OpenVPN Inc.

