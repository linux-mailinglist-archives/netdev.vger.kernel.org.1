Return-Path: <netdev+bounces-78556-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73EEB875B6A
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 01:11:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC0BC1F2179B
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 00:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB992367;
	Fri,  8 Mar 2024 00:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="DOVXhGEP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9046C364
	for <netdev@vger.kernel.org>; Fri,  8 Mar 2024 00:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709856714; cv=none; b=sD+3Og60Z50p2h4zIew9uIIrYrt/C6/T+/q1AthgsurMMZwOeYuaR6h88Yo942SrgwXkhNDZputeh4k8bVaHzCDW2yUuQxQ1vfRAuoh6a+Mwxftky8ERYVnKAiNG4KGnPytR361WM5KLcLxKoDPCZuiiKr4Lb4ugqsbbGm32HS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709856714; c=relaxed/simple;
	bh=xv3eBehMIzkbA1SHf9UNjklESOm4FT8v/lle/VW1X3Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GwZqTSuHyQIpETddioVHZoqwH3YM5fGaNCbZ9s0QErwoZ01RD7ExM6qr+3vCcyXhYI/4rkUL2dnYiq3g+E2kcRiTvs8QdzP5jvCKbPtdLNDQqo5ZM17J2gZ566EYRnGRQcMw3ph9w0J7Z8WPyMNKXE2TMtwmGjFQLA95jwRzTQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=DOVXhGEP; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a2f22bfb4e6so238206466b.0
        for <netdev@vger.kernel.org>; Thu, 07 Mar 2024 16:11:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1709856711; x=1710461511; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KlPI+gGBo0qo1v2NMWbRBP6vO+bDQdAHGz6dxZ9NEfA=;
        b=DOVXhGEPJTdfeo+2wu1SGvITdLDpyJdW9YOMcNtckMfRx5ZvwixUHqzQH2PkE6bOrL
         uytYoq0j4HhAFK5SB8D7Fn2WyXjdyhpcgQutg9lyUp4biLUkgtTVTD/eKbddqNx6lRu6
         Bty9oFezWXlGAaL/WKojQG9uNTM4YyCqqj4f5F48Ah7dc+abAyh8RnrotPi/qRCpBILp
         dl7z0FOdtq6GZ371yKcf6Cqof7I5Mm/Y/c/NL+rmioEjsS3TfqrY5Z1aNuXePLiTkO7V
         z+yLR5AYDnzCPzUa974DTV2k2aF8h8pzSJaghINWIziGYhvPpu+7J5m0iBTIB6hIHJFA
         nPKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709856711; x=1710461511;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KlPI+gGBo0qo1v2NMWbRBP6vO+bDQdAHGz6dxZ9NEfA=;
        b=Z+3udxy2F+0It7OamQb/kZXTh/dMseXNPfPiNN5zzSPXEF4u3wmVST3qW2D4nMSqwA
         Wf9IM9QwE/vB9iXw3M4YVTV+Y3RNqXU3ddhNeI1buRQxW8Xd2rx8GokvA0PV/D7fY62Y
         XPF4/iJh45ffBV73xCCT0FG58UzOcjshT75JAN/dqxiGe3Jgvzxkzz08L9zF8VPGpC3M
         C7swaR/hqwUBHAQCyVwv4Xkds8MXPlJL2Ik30Wv0/8kNnCz1XhtroSdOBt7AqkakO3PZ
         g542PnCm1/suZE9GZOAyjh5i8mthCwTKgQGFbK3JgT4Qvf0aIjFZMp5xrUVswXjtNBNO
         YU3Q==
X-Gm-Message-State: AOJu0YylirFIkihHK/dW/VXyFTiFvnQ5I04idtDjgpXDyLXHLuVOyMUf
	JuO7sNXJRX2VepN4oNpNq72SiVId6fYaNqZo1gbaBPeMtcAqZjTTP0Ki+9ydcFY=
X-Google-Smtp-Source: AGHT+IGwE08bVp81lMJ2g6DQU8R7ydmLxONWxWs3Cj6zn+ZVf/eQnu/1PuoYFPyMPmucAeHjfWnGYQ==
X-Received: by 2002:a17:906:b08:b0:a45:248e:b253 with SMTP id u8-20020a1709060b0800b00a45248eb253mr9999246ejg.76.1709856710781;
        Thu, 07 Mar 2024 16:11:50 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:0:460d:9497:9f21:53e7? ([2001:67c:2fbc:0:460d:9497:9f21:53e7])
        by smtp.gmail.com with ESMTPSA id j15-20020a1709062a0f00b00a45a96a9c37sm3346251eje.65.2024.03.07.16.11.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Mar 2024 16:11:50 -0800 (PST)
Message-ID: <f9290545-c5c2-4b2f-967e-33025e5af809@openvpn.net>
Date: Fri, 8 Mar 2024 01:12:15 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 06/22] ovpn: introduce the ovpn_peer object
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Sergey Ryazanov <ryazanov.s.a@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>
References: <20240304150914.11444-1-antonio@openvpn.net>
 <20240304150914.11444-7-antonio@openvpn.net>
 <053db969-1c21-41db-b0b5-f436593205dc@lunn.ch>
 <91005d44-8a51-4c6d-9f5c-d5951d92f7c5@openvpn.net>
 <f98d9f01-f9c9-4990-ad51-aa46b77ef63d@lunn.ch>
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <f98d9f01-f9c9-4990-ad51-aa46b77ef63d@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/03/2024 20:23, Andrew Lunn wrote:
>> This is a very good point where I might require some input/feedback.
>> I have not ignored the problem, but I was hoping to solve it in a future
>> iteration. (all the better if we can get it out the way right now)
>>
>> The reason for having these rings is to pass packets between contexts.
>>
>> When packets are received from the network in softirq context, they are
>> queued in the rx_ring and later processed by a dedicated worker. The latter
>> also takes care of decryption, which may sleep.
>>
>> The same, but symmetric, process happens for packets sent by the user to the
>> device: queued in tx_ring and then encrypted by the dedicated worker.
>>
>> netif_rx_ring is just a queue for NAPI.
>>
>>
>> I can definitely have a look at BQL, but feel free to drop me any
>> pointer/keyword as to what I should look at.
> 
> Do you have any measurements about the average and maximum fill size
> of these queues? If you could make the rings smaller, the whole
> question of latency and bufferbloat disappears. NAPI tends to deal
> with up to 64 packets. So could you make these rings 128 in size?

I don't have actual numbers at hand.
Fill size depends on encryption/decryption speed vs network speed.

I can tell you that, while performing stress tests on AWS, we could get 
to the point where all rings are full and packets started being dropped.

However, this may be a ill-formed case, where network is much faster 
than the crypto part.

I will try to measure how many packets are kept in the queue under 
standard utilization. That should tell us if 128 is a decent size or not.

Thanks for the hint!

Regards,

> 
> 	Andrew

-- 
Antonio Quartulli
OpenVPN Inc.

