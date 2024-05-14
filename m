Return-Path: <netdev+bounces-96404-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2601F8C5A15
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 19:09:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 501211C21542
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 17:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4399117F37C;
	Tue, 14 May 2024 17:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C/E4i7iJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92701365
	for <netdev@vger.kernel.org>; Tue, 14 May 2024 17:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715706565; cv=none; b=bJxmswNcCwXzRSYO4aN2xo4bk5VLhhS6rppZRpNnsEWodUzMU8pPABa4s5LW9kWVKw/Fjkvl3FuDeumzMQomMg5Dw/3Sc5D3/52ARRaTUkIRaCvkka1LDgE/sKSj/QYw4Z8C+0DUGgqCY+ALfO91JDTabBm9MwPEKrF4wmWT5VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715706565; c=relaxed/simple;
	bh=pv7gV9pCsM6FaeNsK4YqBT8BPamzPDGZ2Bx541WcLbg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bcFundWlhpplBtSGN9vZrTy3iOBYGe1Zfv/0NHH6jj7oAxla2OWP5T9e0xvPvPu5Sz+heMOFnxTbm4UXRmeyjQro5KGe08TV5JWS+WqVo2VtLs+mNQDWkvo6qB/Go7akSaXGeGbT14FxCqzoW2QNTTwQgjMGQyB5sQXNbnYb7CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C/E4i7iJ; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a5a0013d551so26485666b.2
        for <netdev@vger.kernel.org>; Tue, 14 May 2024 10:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715706562; x=1716311362; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=/aK+IelGMAr5sSS9Q/hcrut5l8UqhSffEmGWcP0rVks=;
        b=C/E4i7iJkuwUN2nmIOCoADhYlqQNixMNm0s8oy+TZJ/Keyhdn1xZeBWE5OaYMYFLuS
         V2oOpJ+GdoGRFsUDi6RwRAU0LTRmUJdLz+nd1NdAILR/RRnjKCOHggDNnwNUTlb+2LKl
         p7ybBkzJlxjVx5XX/K2prkvBsuFHF250zQwYRxnI0Z3SPe2ZLYuLPGqlBtRcG7uNJViE
         ozwk+8Om2+lgenvRluhG+Xi7dw4/EZmDET6jlDCe3haeUBl6c9C9F7fu/DsBnmYG4lZu
         /uMg45iubyvUvyJebmIiTIZbRXTqu6EfVrVH1PURYIlysbooKfLTlgidktkNqjUzhnY3
         T0Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715706562; x=1716311362;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/aK+IelGMAr5sSS9Q/hcrut5l8UqhSffEmGWcP0rVks=;
        b=lyn8wuqO2DP54i55XpNkcZ3DOhBf4FZIx8hE46IbK8xdzAQFtaEVDd0QjpAqXEL+Z+
         muZfZLxzL3cMxqkZoTQbHR720nN4vctdXTBojK9s/piu1NxdKot+TpwE/sHCI7YLVfIW
         RuVZfl80eTRgWeDt1EDUab5y4sET6Hvt6zutgNiClYVGohfBXiYsdfXT3cBldzf55rxE
         S1Td/h8K/ZbXW9rlgIDdWyXvp4SgNFtnsDPAWxPepTlSYkv3zOQH41r/EyKAW/SFdE8E
         5QBopIn8JzjCv4CncT3K6qjsW8YangKBXYFbXSQgUsasBkkuIZ7m+DNIsFvTZQKDGrpB
         eStA==
X-Forwarded-Encrypted: i=1; AJvYcCV7JdKc7GOJdPviOKT47madgLj1qwDGI8eOf68WXLHRYKlLvVJWPUWXG5Go+AHoIEPOOKohf4+HcN/RQobiDYUQ8fY2hEd5
X-Gm-Message-State: AOJu0YxWhuIW9eHd/c0z9o1+PHcrM0cTw+dERRTd3YNIsj7Tk1Qy9AW+
	ArZkmHiY8Sf3lYP/RoDBXe2woSuJpJ/jZFOia+B9vm/H7h/e/ShJ
X-Google-Smtp-Source: AGHT+IHK0BGPxNF/9iifuePbJJMvG6XoSHZR6FIzQZ4r/6Pz0zt1IPxDWoFsacc6PTj6/LNMElg69Q==
X-Received: by 2002:aa7:d787:0:b0:573:55cc:2f50 with SMTP id 4fb4d7f45d1cf-57355cc3092mr10991545a12.37.1715706561680;
        Tue, 14 May 2024 10:09:21 -0700 (PDT)
Received: from ?IPV6:2a02:3100:9109:bf00:34ea:a297:c4b8:946f? (dynamic-2a02-3100-9109-bf00-34ea-a297-c4b8-946f.310.pool.telefonica.de. [2a02:3100:9109:bf00:34ea:a297:c4b8:946f])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5733bed0a99sm7758301a12.52.2024.05.14.10.09.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 May 2024 10:09:21 -0700 (PDT)
Message-ID: <cdaf9e9a-881c-4324-a886-0ed38e2de72e@gmail.com>
Date: Tue, 14 May 2024 19:09:21 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/2] r8169: disable interrupts also for GRO-scheduled
 NAPI
To: Jakub Kicinski <kuba@kernel.org>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 David Miller <davem@davemloft.net>,
 Realtek linux nic maintainers <nic_swsd@realtek.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Ken Milmore <ken.milmore@gmail.com>
References: <6d4a0450-9be1-4d91-ba18-5e9bd750fa40@gmail.com>
 <ef333a8c-1bb2-49a7-b721-68b28df19b0e@gmail.com>
 <CANn89iLgj0ph5gRWOA2M2J8N_4hQd3Ndm73gATR8WODXaOM_LA@mail.gmail.com>
 <e8f548f8-6d16-4a30-9408-80e4212afe9c@intel.com>
 <CANn89i+yKgXGHUyJxVLYTAMKj7wpoV+8X7UR8cWh75yxVLSA6Q@mail.gmail.com>
 <20240514071100.70fcca3e@kernel.org>
 <78fb284b-f78a-4dde-8398-d4f175e49723@gmail.com>
 <20240514094908.61593793@kernel.org>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <20240514094908.61593793@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14.05.2024 18:49, Jakub Kicinski wrote:
> On Tue, 14 May 2024 18:35:46 +0200 Heiner Kallweit wrote:
>>> I thought the bug is because of a race with disable.  
>>
>> No, the second napi_poll() in this scenario is executed with device
>> interrupts enabled, what triggers a (supposedly) hw bug under heavy
>> load. So the fix is to disable device interrupts also in the case
>> that NAPI is already scheduled when entering the interrupt handler.
>>
>>> But there's already a synchronize_net() after disable, so NAPI poll
>>> must fully exit before we mask in rtl8169_cleanup().
>>>
>>> If the bug is double-enable you describe the fix is just making 
>>> the race window smaller. But I don't think that's the bug.
>>>
>>> BTW why are events only acked in rtl8169_interrupt() and not
>>> rtl8169_poll()?   
>>
>> You mean clearing the rx/tx-related interrupt status bits only
>> after napi_complete_done(), as an alternative to disabling
>> device interrupts?
> 
> Before, basically ack them at the start of a poll function.
> If gro_timeout / IRQ suppression is not enabled it won't make 
> much of a difference. Probably also won't make much difference
> with iperf.
> 
> But normally traffic is bursty so with gro_timeout we can see 
> something like:
> 
>     packets: x x  x  x x   <  no more packets  >
> IRQ pending: xxx  xxxxxxxxxxxxxxxxxxxxxx
>         ISR:    []                      []
>     IRQ ack:    x                       x
>        NAPI:     [=====] < timeout > [=] [=] < timeout > [=]
> 
> Acking at the beginning of NAPI poll can't make us miss events 
> but we'd clear the pending IRQ on the "deferred" NAPI run, avoiding 
> an extra HW IRQ and 2 NAPI calls:
> 
>     packets: x x  x  x x   <  no more packets  >
> IRQ pending: xxxx xxxxxxxxxxxxxxxxxxx
>         ISR:    []                   
>     IRQ ack:     x                   x
>        NAPI:     [=====] < timeout > [=]

Thanks for the explanation. What is the benefit of acking interrupts
at the beginning of NAPI poll, compared to acking them after
napi_complete_done()?
If budget is exceeded and we know we're polled again, why ack
the interrupts in between?
I just tested with the defaults of gro_flush_timeout=20000 and
napi_defer_hardirqs=1, and iperf3 --bidir.
The difference is massive. When acking after napi_complete_done()
I see only a few hundred interrupts. Acking at the beginning of
NAPI poll it's few hundred thousand interrupts.


