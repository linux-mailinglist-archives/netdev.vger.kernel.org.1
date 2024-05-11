Return-Path: <netdev+bounces-95708-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB5A8C3277
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 18:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A3541C20A20
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 16:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842099461;
	Sat, 11 May 2024 16:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XNtU0Ieq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48D94A39
	for <netdev@vger.kernel.org>; Sat, 11 May 2024 16:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715445091; cv=none; b=mn+1m4KYBcDe5NHTN+njh9wKN9AggJyXmIEr+ILo/NkO/+t6GfaZBEsuxfHYsHpAFzP6UHmnNOZ5ZYacAT8I7X7uKqmyrtc62qBQoLFpUfKAdnnOnXkASVyxETre4zbB6GXQbi3DYLXErGKFX7Uu0IhCYNd2CFxdOnC5+pCm+1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715445091; c=relaxed/simple;
	bh=H7jane2e+8mew1GONQg/312wOn8Qdxh3yJRhtQ2Jy18=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P28NQmaJsQ7E+zDh28XqQLcX6S96JmPdPb8PXBGciP5h39oRhWoRc/6sp128sgObtQcP0ZI9iKtqRJCI0evVLFNukWrrK+rX9gGEyHGXwaPH3+pR6QzxjIPr0t/MXg1LwOUs0CIJtziz2IP7m0fgdhYqGL7wluVcOXkOhjUB6gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XNtU0Ieq; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-41fd5dc04e2so16435635e9.3
        for <netdev@vger.kernel.org>; Sat, 11 May 2024 09:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715445088; x=1716049888; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=eo7f+Q+cQ3gK3GrPUwrpMBXK1aZviLc1Z7L1kA0h66Y=;
        b=XNtU0IeqPM0Efa67UhKztmzuy2r+GawD4A8gvec37S+StZIIBK1HnQJVFZbGyD6E+7
         FjRKOl2s0f2sdh+mHLEdxV5/HO7vM4gEe/n40/L+8ig/b/FN1SRR2szIbP66rL8BvOR7
         Mfq+03MLSmgkxIHbBmc7emsxb0VDyLlPkHHRYKqLCahF0Rl9+/dCPdJf4N3vb5f9z3vI
         hEjUpUz9qRg8Q9yTM+vWbALsnMAjAEfn2+3FfcVyRNl5+gla6g32t9YndORsct4qI0Wy
         n9L3n7wBNAZsWUlaewWyEaY3ju3MPGmNRGC0JhcNjqz58Z45cw5WUbYacQTVV06wWmO2
         DJkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715445088; x=1716049888;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eo7f+Q+cQ3gK3GrPUwrpMBXK1aZviLc1Z7L1kA0h66Y=;
        b=NEogHGSkvxH+V6KOgpuWo+5EJrmYIqW9+/pumxsrzTlKulOMMpKC6+t8X7IfLDEvBw
         KKqFyLbfxhDEPWs4QZvEwZwvvR8OI7oyFvZKEx3Cwg//Pw6PCzWpD293bHml1fr6joJB
         c5ZMu7lC7N4Y3EQMCUQ6A0lx9b5F1zUjSwCZK76LKsHTL2N8z3nRHZ+mo1zxlHNFgqfB
         78aM3OG3Ru9o7lfB/mPxuZYoWICzD2o3gn1LWORGTMookGtPcjIQ8f1OCmu4Aiq4RwIO
         ec5qDapR4bAyPKSpYVCzVvYyN13Aj/MaxnvV31ROBeLZn8vMQlaNRAmyiHRx7a2Cohix
         H3bg==
X-Forwarded-Encrypted: i=1; AJvYcCXziOB/jb4htgofkNnZzVhO43f3nxK+DXoJwuZrOe0dkIHtlFw7R59uKhVEga4VM09UZvJWWOqx7ehecmmNLROPZeBMsQ2S
X-Gm-Message-State: AOJu0YyEi0I4Ue5O9+NImlco8G7VwRymOr5XX4u8aJAuYVOdVuhcJGNz
	HNpjP9zjZyPPHNhRFiwqhMIgJ4zc9irA0/DOVO4V2+VsbeG42IFp1wAF1g==
X-Google-Smtp-Source: AGHT+IH/LOwBSBTyW69qD+D11m6dmu7phlvEQuTGU/JWUEHuOrmPzTqHk5PNk2QHC7B8n9NrHjGtZg==
X-Received: by 2002:a05:600c:1c18:b0:41a:3868:d222 with SMTP id 5b1f17b1804b1-41fea539b00mr42372005e9.0.1715445087742;
        Sat, 11 May 2024 09:31:27 -0700 (PDT)
Received: from ?IPV6:2a01:c23:c4c4:8000:303f:d58c:7afb:5465? (dynamic-2a01-0c23-c4c4-8000-303f-d58c-7afb-5465.c23.pool.telefonica.de. [2a01:c23:c4c4:8000:303f:d58c:7afb:5465])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-41fccce25casm103217585e9.20.2024.05.11.09.31.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 May 2024 09:31:27 -0700 (PDT)
Message-ID: <940faa90-81db-40dc-8773-1720520b10ed@gmail.com>
Date: Sat, 11 May 2024 18:31:27 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: r8169: transmit queue timeouts and IRQ masking
To: Ken Milmore <ken.milmore@gmail.com>, netdev@vger.kernel.org
Cc: nic_swsd@realtek.com
References: <ad6a0c52-4dcb-444e-88cd-a6c490a817fe@gmail.com>
 <f4197a6d-d829-4adf-8666-1390f2355540@gmail.com>
 <5181a634-fe25-45e7-803e-eb8737990e01@gmail.com>
 <adfb0005-3283-4138-97d5-b4af3a314d98@gmail.com>
 <f0305064-64d9-4705-9846-cdc0fb103b82@gmail.com>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <f0305064-64d9-4705-9846-cdc0fb103b82@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11.05.2024 00:29, Ken Milmore wrote:
> On 10/05/2024 23:06, Heiner Kallweit wrote:
>>
>> Nice idea. The following is a simplified version.
>> It's based on the thought that between scheduling NAPI and start of NAPI
>> polling interrupts don't hurt.
>>
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>> ---
>>  drivers/net/ethernet/realtek/r8169_main.c | 13 ++++++++-----
>>  1 file changed, 8 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
>> index e5ea827a2..7b04dfecc 100644
>> --- a/drivers/net/ethernet/realtek/r8169_main.c
>> +++ b/drivers/net/ethernet/realtek/r8169_main.c
>> @@ -592,6 +592,7 @@ enum rtl_flag {
>>  	RTL_FLAG_TASK_RESET_PENDING,
>>  	RTL_FLAG_TASK_RESET_NO_QUEUE_WAKE,
>>  	RTL_FLAG_TASK_TX_TIMEOUT,
>> +	RTL_FLAG_IRQ_DISABLED,
>>  	RTL_FLAG_MAX
>>  };
>>  
>> @@ -4657,10 +4658,7 @@ static irqreturn_t rtl8169_interrupt(int irq, void *dev_instance)
>>  		rtl_schedule_task(tp, RTL_FLAG_TASK_RESET_PENDING);
>>  	}
>>  
>> -	if (napi_schedule_prep(&tp->napi)) {
>> -		rtl_irq_disable(tp);
>> -		__napi_schedule(&tp->napi);
>> -	}
>> +	napi_schedule(&tp->napi);
>>  out:
>>  	rtl_ack_events(tp, status);
>>  
>> @@ -4714,12 +4712,17 @@ static int rtl8169_poll(struct napi_struct *napi, int budget)
>>  	struct net_device *dev = tp->dev;
>>  	int work_done;
>>  
>> +	if (!test_and_set_bit(RTL_FLAG_IRQ_DISABLED, tp->wk.flags))
>> +		rtl_irq_disable(tp);
>> +
>>  	rtl_tx(dev, tp, budget);
>>  
>>  	work_done = rtl_rx(dev, tp, budget);
>>  
>> -	if (work_done < budget && napi_complete_done(napi, work_done))
>> +	if (work_done < budget && napi_complete_done(napi, work_done)) {
>> +		clear_bit(RTL_FLAG_IRQ_DISABLED, tp->wk.flags);
>>  		rtl_irq_enable(tp);
>> +	}
>>  
>>  	return work_done;
>>  }
> 
> Reading this worries me though:
> 
> https://docs.kernel.org/networking/napi.html
> "napi_disable() and subsequent calls to the poll method only wait for the ownership of the instance to be released, not for the poll method to exit.
> This means that drivers should avoid accessing any data structures after calling napi_complete_done()."
> 
According to kernel doc napi_disable() waits.

/**
 *	napi_disable - prevent NAPI from scheduling
 *	@n: NAPI context
 *
 * Stop NAPI from being scheduled on this context.
 * Waits till any outstanding processing completes.
 */

> Which seems to imply that the IRQ enable following napi_complete_done() is unguarded, and might race with the disable on an incoming poll.
> Is that a possibility?

Same documents states in section "Scheduling and IRQ masking":
IRQ should only be unmasked after a successful call to napi_complete_done()
So I think we should be fine.


