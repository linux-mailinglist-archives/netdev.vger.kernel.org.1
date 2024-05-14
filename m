Return-Path: <netdev+bounces-96334-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 614F68C52D4
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 13:41:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84C3B1C21964
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 11:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A7122374E;
	Tue, 14 May 2024 11:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YCwN50Nr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5898312F58D
	for <netdev@vger.kernel.org>; Tue, 14 May 2024 11:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715686148; cv=none; b=OG9dfNYNguOpLobfwylqtWlWS5FF5gOcrQLNVeiNZ1LG2dzBkdZpwXkXJNMSTSr3gaJpdXpUbSocr2X+TsgPdBP72D6R/2C7QoryRHWlUkbdDeQeZo282imipRluSdDCk9cJDzVdwJc5douzQj9wXqV+ftQ5jvfpbOzuQk0kdmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715686148; c=relaxed/simple;
	bh=IbEEkB4bhDZQP3Nup8DDcTSSq5jRr1QRksPWrG5bDXM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E/ZZUNhleJDq4MP5s5ohz9zAPC5y9L2+zYVa9lFUbHIFnkwpr33RGasrN9ZEykV4cyssp0lhbV2eeRensPpYLcomqSdtThkIBC6Wz7X16/csecyyqTP1Xg7sDuW4TjmHoqgClqFuaxWoqJyDmcl4Ealir1w+Bij46a4MYwDZu3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YCwN50Nr; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a59ce1e8609so7740466b.0
        for <netdev@vger.kernel.org>; Tue, 14 May 2024 04:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715686144; x=1716290944; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=aZlWNFGFu0gCHNev9F1rad1l5wBrgpGEFrnvHCjfSJA=;
        b=YCwN50NrG97wPNJYW+EbduovaKO3+LH1SviX0jr2z75BZtXSuDPeY6uLJfmMnXlbPe
         a9lugDcGC6MbEiVQ6GkP8Aezqy3XqJe3gP/G4RxRvEJ/Y+2YbeJmfVumprspWYM5N0iC
         xJBnkZvFsF7CgyDOSBfKo1Qus0lyATHgz2F7lExTsrrECB3dFWG4LKcIrgNbQQOmbzyI
         MuJ0nnpMYQHz/boRS30+/95876FHbJOQXW3/I5fRVSMr+8D1wq0vfuXB7XVW1EVNJk4v
         MrIFlC3QAar7N4zGB69Ey1NJXhM88DjNilltwhHupGjI2Wt+gJ3jAnfYJtbjRESbTHdq
         tNIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715686144; x=1716290944;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aZlWNFGFu0gCHNev9F1rad1l5wBrgpGEFrnvHCjfSJA=;
        b=J1g1b8qHPTnvyAuNiEDyzpQq4HsefaUCsUjRc28nI8n/MhvCEqVSp6bO/ZwBN0LJry
         xTt83S6XLfsTnt7yaf02BFxnyPHftxXKLsSyBPcviXWH+don+Gh1i1ALjwjTfTkamXZ0
         N7Ssc6W+WnH4zQFakMV8WrZly0LVZPKS41YFPQqsYW6wyb8bEooV5Ez/A1e+BfdcodiA
         Cxm7CLw5+xgvuL32qfbDD7cRpZx7VoyF+xK5Eg5JzssVW63el6Oj9eDHPgMnXfVKWx+F
         5c97zdcR7Rn2r2wCrcyFuhaFKTy0DmDD8UFEy9Fe3CE+Io4A+zSguTsHUwdsIU23Sh7P
         LK7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVoueojyIAzltM/CxBu+lzbOrdyDq+f1pvAak6Cech3r+kbdL9Cb8iCbcCtev8WEXOBlSQJPTB0Mdjb1gKXbR+/XvEEn33K
X-Gm-Message-State: AOJu0YxwcnBNmQn8ScFWzQgqJacL2LrtLryoRZ9StgszZ+/FXs/miKLC
	anUyyiOnAxHvTYYAtePS73n9XHBJcG63BeNrermJa8uNAyUaGgD2
X-Google-Smtp-Source: AGHT+IGMklC2leCZAxsNDEf2P7qs1PmJ4ozSNECbCtaSVb7alRqrMZPaZQkNiDrzquxWXzylJDHsEA==
X-Received: by 2002:a17:906:416:b0:a59:79fc:f922 with SMTP id a640c23a62f3a-a5a11557a1fmr1204677166b.6.1715686144313;
        Tue, 14 May 2024 04:29:04 -0700 (PDT)
Received: from ?IPV6:2a02:3100:9109:bf00:539:dc8b:b45e:f9bb? (dynamic-2a02-3100-9109-bf00-0539-dc8b-b45e-f9bb.310.pool.telefonica.de. [2a02:3100:9109:bf00:539:dc8b:b45e:f9bb])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a5a17894d57sm714341166b.73.2024.05.14.04.29.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 May 2024 04:29:03 -0700 (PDT)
Message-ID: <31b629ae-df12-4d6d-9716-60271f41cadc@gmail.com>
Date: Tue, 14 May 2024 13:29:03 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/2] r8169: disable interrupts also for GRO-scheduled
 NAPI
To: Eric Dumazet <edumazet@google.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 David Miller <davem@davemloft.net>,
 Realtek linux nic maintainers <nic_swsd@realtek.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Ken Milmore <ken.milmore@gmail.com>
References: <6d4a0450-9be1-4d91-ba18-5e9bd750fa40@gmail.com>
 <ef333a8c-1bb2-49a7-b721-68b28df19b0e@gmail.com>
 <CANn89iLgj0ph5gRWOA2M2J8N_4hQd3Ndm73gATR8WODXaOM_LA@mail.gmail.com>
 <e8f548f8-6d16-4a30-9408-80e4212afe9c@intel.com>
 <CANn89i+yKgXGHUyJxVLYTAMKj7wpoV+8X7UR8cWh75yxVLSA6Q@mail.gmail.com>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <CANn89i+yKgXGHUyJxVLYTAMKj7wpoV+8X7UR8cWh75yxVLSA6Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 14.05.2024 13:05, Eric Dumazet wrote:
> On Tue, May 14, 2024 at 12:53 PM Alexander Lobakin
> <aleksander.lobakin@intel.com> wrote:
>>
>> From: Eric Dumazet <edumazet@google.com>
>> Date: Tue, 14 May 2024 11:45:05 +0200
>>
>>> On Tue, May 14, 2024 at 8:52 AM Heiner Kallweit <hkallweit1@gmail.com> wrote:
>>>>
>>>> Ken reported that RTL8125b can lock up if gro_flush_timeout has the
>>>> default value of 20000 and napi_defer_hard_irqs is set to 0.
>>>> In this scenario device interrupts aren't disabled, what seems to
>>>> trigger some silicon bug under heavy load. I was able to reproduce this
>>>> behavior on RTL8168h.
>>>> Disabling device interrupts if NAPI is scheduled from a place other than
>>>> the driver's interrupt handler is a necessity in r8169, for other
>>>> drivers it may still be a performance optimization.
>>>>
>>>> Fixes: 7274c4147afb ("r8169: don't try to disable interrupts if NAPI is scheduled already")
>>>> Reported-by: Ken Milmore <ken.milmore@gmail.com>
>>>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>>>> ---
>>>>  drivers/net/ethernet/realtek/r8169_main.c | 6 ++++--
>>>>  1 file changed, 4 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
>>>> index e5ea827a2..01f0ca53d 100644
>>>> --- a/drivers/net/ethernet/realtek/r8169_main.c
>>>> +++ b/drivers/net/ethernet/realtek/r8169_main.c
>>>> @@ -4639,6 +4639,7 @@ static irqreturn_t rtl8169_interrupt(int irq, void *dev_instance)
>>>>  {
>>>>         struct rtl8169_private *tp = dev_instance;
>>>>         u32 status = rtl_get_events(tp);
>>>> +       int ret;
>>>>
>>>>         if ((status & 0xffff) == 0xffff || !(status & tp->irq_mask))
>>>>                 return IRQ_NONE;
>>>> @@ -4657,10 +4658,11 @@ static irqreturn_t rtl8169_interrupt(int irq, void *dev_instance)
>>>>                 rtl_schedule_task(tp, RTL_FLAG_TASK_RESET_PENDING);
>>>>         }
>>>>
>>>> -       if (napi_schedule_prep(&tp->napi)) {
>>>> +       ret = __napi_schedule_prep(&tp->napi);
>>>> +       if (ret >= 0)
>>>>                 rtl_irq_disable(tp);
>>>> +       if (ret > 0)
>>>>                 __napi_schedule(&tp->napi);
>>>> -       }
>>>>  out:
>>>>         rtl_ack_events(tp, status);
>>>>
>>>
>>> I do not understand this patch.
>>>
>>> __napi_schedule_prep() would only return -1 if NAPIF_STATE_DISABLE was set,
>>> but this should not happen under normal operations ?
>>
>> Without this patch, napi_schedule_prep() returns false if it's either
>> scheduled already OR it's disabled. Drivers disable interrupts only if
>> it returns true, which means they don't do that if it's already scheduled.
>> With this patch, __napi_schedule_prep() returns -1 if it's disabled and
>> 0 if it was already scheduled. Which means we can disable interrupts
>> when the result is >= 0, i.e. regardless if it was scheduled before the
>> call or within the call.
>>
>> IIUC, this addresses such situations:
>>
>> napi_schedule()         // we disabled interrupts
>> napi_poll()             // we polled < budget frames
>> napi_complete_done()    // reenable the interrupts, no repoll
>>   hrtimer_start()       // GRO flush is queued
>>     napi_schedule()
>>       napi_poll()       // GRO flush, BUT interrupts are enabled
>>
>> On r8169, this seems to cause issues. On other drivers, it seems to be
>> okay, but with this new helper, you can save some cycles.
>>
>> Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> 
> Rephrasing the changelog is not really helping.
> 
> Consider myself as a network maintainer, not as a casual patch reviewer.
> 
> "This seems to cause issues" is rather weak.
> 
> I would simply revert the faulty commit, because the interrupts are
> going to be disabled no matter what.
> 
> Old logic was very simple and rock solid. A revert is a clear stable candidate.
> 
> rtl_irq_disable(tp);
> napi_schedule(&tp->napi);
> 
Proposed new solution differs from the revert wrt how NAPIF_STATE_DISABLE
is handled. I'm not sure the old code would handle this corner case correctly.
It would disable device interrupts, and following napi_schedule() is a no-op.
Therefore device interrupts would remain disabled, and I think that's not
what we want.
When trying to solve this by adding an extra call to e.g. napi_disable_pending(),
then I have concerns this might be racy.

> If this is still broken, we might have similar issues in old/legacy drivers.


