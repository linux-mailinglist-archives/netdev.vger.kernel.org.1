Return-Path: <netdev+bounces-96459-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E56DB8C6051
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 07:53:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 381C8B20BF3
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 05:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7F833A1DC;
	Wed, 15 May 2024 05:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aXV6Z4H6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E33381BE
	for <netdev@vger.kernel.org>; Wed, 15 May 2024 05:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715752427; cv=none; b=krPEFKgKRvUqhHz/RXV4hY57OJfk2cj/jd5sZSz93bJqQBLPbLNjlim/GeAR5lna+Rn/hPfYj/YjQyzfnGUVsyUUg+3Ylt3KrcXXsGM4YCv0zq1wyvXQ6XC7Xzhd+t2AofzGy1bHddDt+eZxUep4ry+AHyUnbeXkuAidrv3gpUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715752427; c=relaxed/simple;
	bh=oMfyokGt9SJXE6r8oNLG02ENP+EXbvO34+8aTV98O8U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Arzt2iK23/oAPuqA0mYsEVPZG+ISaANhq8kSRbpAAlcXXoAr9cAbZ92LCOPYGLkMQyr88m7zd8kcNSEjG1fAerb7l64b2RlG8Fat9c96b8E2DAjeJ8tmX8lu2qWdsfrrdhxFT9n1FvCjlf/gpl+HL64nRn1EuMZEelgZVMQJJTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aXV6Z4H6; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5709cb80b03so1219919a12.2
        for <netdev@vger.kernel.org>; Tue, 14 May 2024 22:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715752424; x=1716357224; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ktb9HqYHBe59yp66mGo/2YeNRGREZVmYI/4zrI2cKOU=;
        b=aXV6Z4H6G7lXDVhWz/3AdPzfqJ9de0wcACx7S42jCJKkA+a21E0/b8Y6jcZztATm0Y
         G/rEI8rAbwwJoWAhAcWZHNIxe3o/f8XvieLmR2W38t8wE1mDi3IXFq3AjYjPON7cdtSi
         ec6WPorZFxjFngPhVIx9wset7Tx3gQvAubEGSjtbGAdITHQQ8KNU9ITXXgwsIoy1DKAu
         lzq/b0dcbwFkB+JdPNvc0BfXUQybxhHQxjDsIXBxdjWiS9IC2OoTuHGD2/Fm8TNo27Vq
         DsgO7e7z1cuvr3M3tG0daWGMX+OgkgVbKNGOK7gDibef9H+D06RydrtPslZ6YiR/DLHx
         LxyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715752424; x=1716357224;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ktb9HqYHBe59yp66mGo/2YeNRGREZVmYI/4zrI2cKOU=;
        b=tyQinmZw5GPDji/B4ZwGoWMZr7s2y/PjEVrnUuil4x2W1Acn2szDx4YenXhzb8v2KE
         ni/3gMcESiZ1S8pDBGGoZiafeKH1y6IJqx9eIAD12dTqSiNW38GO7tEF7/ALymNhyHj+
         KKlDsAcJecx2A/x23UwjlqxZp+iE6K1XHCS3t26y2Ws7p7SQ78U8KYxnYh88A3Bc6f2v
         ghtP4fGREe/KGtUg6PJs8NnPBc1M7mPlsSsbGE7o8ZdO42hq8fLd22uXC3k0Vmyvp/lv
         4vjEXnKZ9yWd0KoA2UVVExDyAa3BXpAI1eS00VJ52RvoaSxGBu71j3RwOYkrjqHBmnzN
         P9BQ==
X-Forwarded-Encrypted: i=1; AJvYcCXE+h8NMl1vDK1yHAn+jbPv9dHAhfqke/ahYLOmhNPrMa4s500yOP6+7gGusDmihyRAQWncF84ctYPvpbGKfRAo22XtchLA
X-Gm-Message-State: AOJu0YwbU3kycFZMpamY08xjIbwNRbb3bxK+U8EHGM4DrWkVGNuFPtmq
	b6d/NnGYkau7hd7YSd/OpfeUDelhMAAyZaSdB0LbyDOaPYRDFgQb
X-Google-Smtp-Source: AGHT+IEsg32z9p7G24H0MqAreIDX1s6PvdptFXyEfVoP1OwxC1/63jlxI3iOH0/wuJMfMmH+m0BP7g==
X-Received: by 2002:a50:d793:0:b0:570:5e7f:62cb with SMTP id 4fb4d7f45d1cf-5734d67ae31mr9388193a12.29.1715752423848;
        Tue, 14 May 2024 22:53:43 -0700 (PDT)
Received: from ?IPV6:2a01:c22:7731:9200:5d4a:ed7b:b883:3704? (dynamic-2a01-0c22-7731-9200-5d4a-ed7b-b883-3704.c22.pool.telefonica.de. [2a01:c22:7731:9200:5d4a:ed7b:b883:3704])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-574ea5d755bsm1371201a12.51.2024.05.14.22.53.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 May 2024 22:53:43 -0700 (PDT)
Message-ID: <442303d8-ffaa-40dc-8f71-786bebde1366@gmail.com>
Date: Wed, 15 May 2024 07:53:44 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/2] r8169: disable interrupts also for GRO-scheduled
 NAPI
To: Eric Dumazet <edumazet@google.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 David Miller <davem@davemloft.net>,
 Realtek linux nic maintainers <nic_swsd@realtek.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Ken Milmore <ken.milmore@gmail.com>
References: <6d4a0450-9be1-4d91-ba18-5e9bd750fa40@gmail.com>
 <ef333a8c-1bb2-49a7-b721-68b28df19b0e@gmail.com>
 <CANn89iLgj0ph5gRWOA2M2J8N_4hQd3Ndm73gATR8WODXaOM_LA@mail.gmail.com>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <CANn89iLgj0ph5gRWOA2M2J8N_4hQd3Ndm73gATR8WODXaOM_LA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 14.05.2024 11:45, Eric Dumazet wrote:
> On Tue, May 14, 2024 at 8:52 AM Heiner Kallweit <hkallweit1@gmail.com> wrote:
>>
>> Ken reported that RTL8125b can lock up if gro_flush_timeout has the
>> default value of 20000 and napi_defer_hard_irqs is set to 0.
>> In this scenario device interrupts aren't disabled, what seems to
>> trigger some silicon bug under heavy load. I was able to reproduce this
>> behavior on RTL8168h.
>> Disabling device interrupts if NAPI is scheduled from a place other than
>> the driver's interrupt handler is a necessity in r8169, for other
>> drivers it may still be a performance optimization.
>>
>> Fixes: 7274c4147afb ("r8169: don't try to disable interrupts if NAPI is scheduled already")
>> Reported-by: Ken Milmore <ken.milmore@gmail.com>
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>> ---
>>  drivers/net/ethernet/realtek/r8169_main.c | 6 ++++--
>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
>> index e5ea827a2..01f0ca53d 100644
>> --- a/drivers/net/ethernet/realtek/r8169_main.c
>> +++ b/drivers/net/ethernet/realtek/r8169_main.c
>> @@ -4639,6 +4639,7 @@ static irqreturn_t rtl8169_interrupt(int irq, void *dev_instance)
>>  {
>>         struct rtl8169_private *tp = dev_instance;
>>         u32 status = rtl_get_events(tp);
>> +       int ret;
>>
>>         if ((status & 0xffff) == 0xffff || !(status & tp->irq_mask))
>>                 return IRQ_NONE;
>> @@ -4657,10 +4658,11 @@ static irqreturn_t rtl8169_interrupt(int irq, void *dev_instance)
>>                 rtl_schedule_task(tp, RTL_FLAG_TASK_RESET_PENDING);
>>         }
>>
>> -       if (napi_schedule_prep(&tp->napi)) {
>> +       ret = __napi_schedule_prep(&tp->napi);
>> +       if (ret >= 0)
>>                 rtl_irq_disable(tp);
>> +       if (ret > 0)
>>                 __napi_schedule(&tp->napi);
>> -       }
>>  out:
>>         rtl_ack_events(tp, status);
>>
> 
> I do not understand this patch.
> 
> __napi_schedule_prep() would only return -1 if NAPIF_STATE_DISABLE was set,
> but this should not happen under normal operations ?
> 
> A simple revert would avoid adding yet another NAPI helper.

Fine with me, I'll go with the revert for now.


