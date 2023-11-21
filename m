Return-Path: <netdev+bounces-49745-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A49C47F354A
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 18:50:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44718B21728
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 17:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0003B20DF0;
	Tue, 21 Nov 2023 17:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="Fk1Xyu8F"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC8712A
	for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 09:50:18 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-4083f61322fso27673295e9.1
        for <netdev@vger.kernel.org>; Tue, 21 Nov 2023 09:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1700589016; x=1701193816; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V7eEoEaHBgdi9fm5W+Qi0cAzvT8Gw9lGqubNWJJvxtI=;
        b=Fk1Xyu8F2FvFgnGIOHt8t8detzN/SNukWQ9ymhZbpIrDN+Cd9NjAj8UBdcSjak0uV6
         n+VkkBvvCqAyEWapLuEkFIIcc3yY+07d4OwcSzrHG2IZvVYuWXQy/jrmDW2jyxF9Viba
         ZTfH1Ie9l1R2dnGQ1YvsikmnLP+Nmw6UCH6o6X+WKYNOaQdsyT5aF1cYl34yIuzyiUlp
         79huflY5r9pSRErlLWL0hqMINlke25ECmFaQ6eoVE8ILrRzX5QCQfmGnR+cAkbOHPFbD
         l7QzXPucLhdY91TXxNPfG8t1Jvek0Ir+7ud1HZhKGIbtZnfyywkPKmYZLV1UkB4FEIiT
         sZNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700589016; x=1701193816;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V7eEoEaHBgdi9fm5W+Qi0cAzvT8Gw9lGqubNWJJvxtI=;
        b=QXF1lKgZijNz34G1l/DtUAag/+b7+wcA2xJUJlO2IFg7WvXoC4HZJGvyTGBR+AqRHD
         A1XkLiD7rwHhlF+kibZ9fN3jeNEDcPzGc3WpeRfRtV0xfSy16o1BDmPXhBojF89VX7Zt
         AyA0zBCdVt/2CeDZ+cdc8pkwieEMWFt8uTwVMYQ/7eQmvkXl6X5rwwgg4fiWVr5WZSU3
         g4CNj3w7LuaF2iiTSTgOhAlLD5YUZcGtnB0FNkrmk4D1ge4tYxEm2AdQu/782GbnQwV3
         XD5Dx9Di/K/KkI0WZDyZ+scprNBkOfNzCkbD8QaDjHHyY+Y90IawiNXCKbYJesl0PXJr
         CFnA==
X-Gm-Message-State: AOJu0Yx+V44JmT1L3tacElQHYJBlceHExjdcdhQH3mWq7RrSsJ7WcWry
	7Kaxd8DEebFeIStjhHFP2/JUwt+/pDjzv4k+uu4=
X-Google-Smtp-Source: AGHT+IEpTAg+2Gdi3b5o9hbskbgTV/96r1yf487agp5DGQ9tqg02GcM0PNTAzeuJrdNRubxG04UqxQ==
X-Received: by 2002:a05:600c:ce:b0:401:38dc:8916 with SMTP id u14-20020a05600c00ce00b0040138dc8916mr68648wmm.10.1700589016483;
        Tue, 21 Nov 2023 09:50:16 -0800 (PST)
Received: from [10.83.37.178] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id z17-20020a1c4c11000000b0040a44179a88sm21635907wmf.42.2023.11.21.09.50.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Nov 2023 09:50:15 -0800 (PST)
Message-ID: <793d71be-5164-4943-b18d-7038492b45ea@arista.com>
Date: Tue, 21 Nov 2023 17:50:14 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/7] net/tcp: Limit TCP_AO_REPAIR to non-listen sockets
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>
Cc: David Ahern <dsahern@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 linux-kernel@vger.kernel.org, Dmitry Safonov <0x7f454c46@gmail.com>,
 Francesco Ruggeri <fruggeri05@gmail.com>,
 Salam Noureddine <noureddine@arista.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org
References: <20231121020111.1143180-1-dima@arista.com>
 <20231121020111.1143180-4-dima@arista.com>
 <CANn89i+2xLv=bR5u0iGcmZhZ8WZjPHyzaqAe3cZAhmc95KSVag@mail.gmail.com>
From: Dmitry Safonov <dima@arista.com>
In-Reply-To: <CANn89i+2xLv=bR5u0iGcmZhZ8WZjPHyzaqAe3cZAhmc95KSVag@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 11/21/23 08:21, Eric Dumazet wrote:
> On Tue, Nov 21, 2023 at 3:01 AM Dmitry Safonov <dima@arista.com> wrote:
>>
>> Listen socket is not an established TCP connection, so
>> setsockopt(TCP_AO_REPAIR) doesn't have any impact.
>>
>> Restrict this uAPI for listen sockets.
>>
>> Fixes: faadfaba5e01 ("net/tcp: Add TCP_AO_REPAIR")
>> Signed-off-by: Dmitry Safonov <dima@arista.com>
>> ---
>>  net/ipv4/tcp.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
>> index 53bcc17c91e4..2836515ab3d7 100644
>> --- a/net/ipv4/tcp.c
>> +++ b/net/ipv4/tcp.c
>> @@ -3594,6 +3594,10 @@ int do_tcp_setsockopt(struct sock *sk, int level, int optname,
>>                 break;
>>
>>         case TCP_AO_REPAIR:
>> +               if (sk->sk_state == TCP_LISTEN) {
>> +                       err = -ENOSTR;
> 
> ENOSTR is not used a single time in linux.
> 
> I suggest you use tcp_can_repair_sock() helper (and return -EPERM as
> other TCP_REPAIR options)

Sounds good to me. Unsure why I didn't use tcp_can_repair_sock() in the
first place. Will do in v2.

> 
>> +                       break;
>> +               }
>>                 err = tcp_ao_set_repair(sk, optval, optlen);
>>                 break;
>>  #ifdef CONFIG_TCP_AO
>> @@ -4293,6 +4297,8 @@ int do_tcp_getsockopt(struct sock *sk, int level,
>>         }
>>  #endif
>>         case TCP_AO_REPAIR:
>> +               if (sk->sk_state == TCP_LISTEN)
>> +                       return -ENOSTR;
>>                 return tcp_ao_get_repair(sk, optval, optlen);
>>         case TCP_AO_GET_KEYS:
>>         case TCP_AO_INFO: {
>> --
>> 2.42.0
>>

Thanks,
             Dmitry


