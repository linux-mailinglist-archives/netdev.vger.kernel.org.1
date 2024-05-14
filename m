Return-Path: <netdev+bounces-96398-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90CFA8C59CE
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 18:35:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 117AB1F2167C
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 16:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61BE328366;
	Tue, 14 May 2024 16:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O1S4VJ+b"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7F9DF60
	for <netdev@vger.kernel.org>; Tue, 14 May 2024 16:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715704550; cv=none; b=MOVCVcBt2GYaMtxOnU3mDAJMfeEs/g+fS6LV32mrK/kstP7peaEGyv0j5SUmLUxMsnH8hbgd4gX/vB3VbV2mWzcWzIx0EnOM9Y35BPTU2mNumM+W8c5I7sKfJwxn8jKsbXEpT6yxNxYzI6UmzK9+gBH9wP8h0Q6/S5FOdDacrcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715704550; c=relaxed/simple;
	bh=kTL6lQPHLAzaGtd6Jlg0/T/ftJulbhmjd14ZoC+qTt4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cuYolyRkr7n7/nq179JpqRGdcGiMFbDcmNMaD6jrdpWuk8ofxCWCMXhRYBGqEs5ZXDBMUXM7E8/2Z1p1aAO47TMtlaj54KVB87HmHiVyE9GvQN+bmMxXOAZse8fGBZSZYGEZKcHxnH/WMs3uvMvdy8ppgRIQ6BHSM1ZKswDuuBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O1S4VJ+b; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a59a5f81af4so44327266b.3
        for <netdev@vger.kernel.org>; Tue, 14 May 2024 09:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715704547; x=1716309347; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AJ+SQOi03YySm7ec7dgO4LLgKLETbngQr04lJGXFIcQ=;
        b=O1S4VJ+bWLkbRH0tFtDR9k6tv/dhne1ydDh0v4PtQ/hCT6dlLO/Imo+boUmJsYyb7U
         7j2uyFLDuo9WnQMSuPzgQ7hRbPYBl2f1VGDTSkp6P0gsJvr0bJ2EJ6B4OvLWi+GSrKZ5
         8MYgeDE1NuOUsfNsycHF2cefsO16T6RQJ9OwLON7b1bU55aT3x5b2fHhk8OCdLnRrQ4+
         0ZvkNloqG+vVgrACaz6wtbs/426efV/CgjYVztB4vJE9o7b0JgBOwj8H9D5RquU5SLo2
         Vwc3IDp1N8EkPjXt9XVh+v7zVhY2vPfsOnWK9X8tC/TsRdXxB/P03yN8sbRpamS4+zJj
         Kt1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715704547; x=1716309347;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AJ+SQOi03YySm7ec7dgO4LLgKLETbngQr04lJGXFIcQ=;
        b=mwibN/GJneaLdz/eBEwrOmG32FIPyiS0+UxhpOhyPi8iwnBnNw+GWsRODLEKYxZBMq
         LBtDTI5iWCDA50nXS91vejj6FxFTSAlWWrmReaVzYcBawGWqnlDyTnwju/Lpyyx0bu7s
         QxUpu1CivmLstoo8bzHgsZ3npwYwQcrfGfP/udVwgYX8Yj/fQE3HsCtGOF6D4iN95FLO
         JaXPl0bPhKoR8OZKJP833V0U1HYh8YMbnM7PN85/UuzjlI6JZJtVPhlwZRjpY0iGEasU
         WvVGTnCBoSvdk69CykG7hx0QO/mFiiDpBrLstLAyW/d4tiYuJGRe7HtxzsBVIie00glg
         v2NQ==
X-Forwarded-Encrypted: i=1; AJvYcCXsx7WwWQsBi6j+j0nrvSwazXQIlrCYaBH4kgovPGFTzez3Cg+aJVw+Paa1pkvzSecVvnHD1Q8z34CPyqi15y8Vdj2feIEq
X-Gm-Message-State: AOJu0YwfeptXUmbl3MCHq62mYrRJSQUh+Wbk7hCndFERm3zGKnh6WOPQ
	/592mO46EKuvB22czEE+8qMPaAT12vfQH3se3PKTVaIXS55anKsX
X-Google-Smtp-Source: AGHT+IHbkMBctNSsNnIZjq3VP/OjkfC/oFWLzo2DJ0FgkAo9/5ccQBYcPO6TjtwQLG6lpiAxU6px/w==
X-Received: by 2002:a17:906:cd02:b0:a59:b359:3e18 with SMTP id a640c23a62f3a-a5a2d672ed8mr989670366b.47.1715704546812;
        Tue, 14 May 2024 09:35:46 -0700 (PDT)
Received: from ?IPV6:2a02:3100:9109:bf00:34ea:a297:c4b8:946f? (dynamic-2a02-3100-9109-bf00-34ea-a297-c4b8-946f.310.pool.telefonica.de. [2a02:3100:9109:bf00:34ea:a297:c4b8:946f])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a5a179c81b4sm738039666b.113.2024.05.14.09.35.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 May 2024 09:35:46 -0700 (PDT)
Message-ID: <78fb284b-f78a-4dde-8398-d4f175e49723@gmail.com>
Date: Tue, 14 May 2024 18:35:46 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/2] r8169: disable interrupts also for GRO-scheduled
 NAPI
To: Jakub Kicinski <kuba@kernel.org>,
 Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
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
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <20240514071100.70fcca3e@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14.05.2024 16:11, Jakub Kicinski wrote:
> On Tue, 14 May 2024 13:05:55 +0200 Eric Dumazet wrote:
>>> napi_schedule()         // we disabled interrupts
>>> napi_poll()             // we polled < budget frames
>>> napi_complete_done()    // reenable the interrupts, no repoll
>>>   hrtimer_start()       // GRO flush is queued
>>>     napi_schedule()
>>>       napi_poll()       // GRO flush, BUT interrupts are enabled
> 
> I thought the bug is because of a race with disable.

No, the second napi_poll() in this scenario is executed with device
interrupts enabled, what triggers a (supposedly) hw bug under heavy
load. So the fix is to disable device interrupts also in the case
that NAPI is already scheduled when entering the interrupt handler.

> But there's already a synchronize_net() after disable, so NAPI poll
> must fully exit before we mask in rtl8169_cleanup().
> 
> If the bug is double-enable you describe the fix is just making 
> the race window smaller. But I don't think that's the bug.
> 
> BTW why are events only acked in rtl8169_interrupt() and not
> rtl8169_poll()? 

You mean clearing the rx/tx-related interrupt status bits only
after napi_complete_done(), as an alternative to disabling
device interrupts?


