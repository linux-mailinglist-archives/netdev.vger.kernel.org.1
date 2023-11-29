Return-Path: <netdev+bounces-52272-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA7E7FE1B8
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 22:20:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16A98281DE0
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 21:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288A661686;
	Wed, 29 Nov 2023 21:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KmipKZQa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D3910C0;
	Wed, 29 Nov 2023 13:20:45 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-a132acb67b5so30308766b.3;
        Wed, 29 Nov 2023 13:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701292844; x=1701897644; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e7uJ6/cKIhORoXu8TzZSGHhq752ZWeeIg37a8KHIARo=;
        b=KmipKZQaD7eBdQGjrHhsDnIdiispL672PDDG3mL3WJMSUGRsgdIfnA4f0SDvU8/zUg
         DwfSf1QmxWoNZvv4Njtvk4KcMq4hMNBYIaFQBkcClDVdnl798K0pz91VnZ8CkdFZC/Pa
         VN4JM7Se4CIqpf5k1pZHbuNOjWGHg2Ae6q35Pc1eBYZEkD1SSFQivPMCazTFSiE5YEcv
         nabHWacSSM0Jk0/mRzM82TCToaRRoyyA2kSLV22GILbspPzfYM07LQ5KXWi059/Ru08l
         wEyBVILxXjZVZZMp2Sw27iyGsCx9gCDM2DYpD3iwaqXAaNJRtVNWqIDf2Pgljk3rh48w
         9zSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701292844; x=1701897644;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e7uJ6/cKIhORoXu8TzZSGHhq752ZWeeIg37a8KHIARo=;
        b=eJIdWYP5tWk0e8dnujJ6ASbDRZDngG9bO5gUMML/LpNthe6OlhEYg2mvhRRBjyCNfD
         0rU6jzV1XhvG3BI26o72BwnqjBtZyfFTqA3ZJ+uwowrzSfHV5HCwV86sQX+exvrM5t16
         Q4yJ+cyVjdAyTOrN+Kj7CsQU2fJTD0cDCYQmiVyFfyTIRhSWzh0b2Mx9WHB9KlP6ClvN
         gtH4igoUB+x9e1+mMR/rzhADdaCUOJzxzEmz5T1w2HocCfZ5rkG50REJkvuDZOa80z9l
         oVW6DmHwqf6lwvu40EKScm0+XvC33Di0vjJSe5iyUq27k/5pYuGwRLYOuWijF6h4hFam
         8gRQ==
X-Gm-Message-State: AOJu0Yzrfl8JrDEMn+YXwGM4e1F1Nrrm9bMbCHaT6NAERUPYz4uh/Sgj
	YwJzUXEnaPoHKWX0+5f6vl4=
X-Google-Smtp-Source: AGHT+IHW256ZYrusTlNvNtiLRMCdgMj6p64wZO364+KYmDxL9yXjM8VrqXHYyIuRwwYq8Ld2nVxSCA==
X-Received: by 2002:a17:906:27d9:b0:a01:c04a:ca9b with SMTP id k25-20020a17090627d900b00a01c04aca9bmr14609716ejc.72.1701292843807;
        Wed, 29 Nov 2023 13:20:43 -0800 (PST)
Received: from [192.168.26.149] (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.googlemail.com with ESMTPSA id p18-20020a1709061b5200b009b9a1714524sm8409276ejg.12.2023.11.29.13.20.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Nov 2023 13:20:41 -0800 (PST)
Message-ID: <ec17c6c8-e697-4a5a-a705-bff24daae7b2@gmail.com>
Date: Wed, 29 Nov 2023 22:20:38 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: ARM BCM53573 SoC hangs/lockups caused by locks/clock/random
 changes
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
 Boqun Feng <boqun.feng@gmail.com>, Russell King <linux@armlinux.org.uk>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>, Florian Fainelli
 <f.fainelli@gmail.com>, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, openwrt-devel@lists.openwrt.org,
 bcm-kernel-feedback-list@broadcom.com
References: <a03a6e1d-e99c-40a3-bdac-0075b5339beb@gmail.com>
 <CACRpkdahWm9aP+UasDx=s3th+vyjAfuWrKB5HS9BKEbz90ZmKw@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
In-Reply-To: <CACRpkdahWm9aP+UasDx=s3th+vyjAfuWrKB5HS9BKEbz90ZmKw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

it's a late reply but I didn't find enough determination earlier.

On 8.09.2023 10:10, Linus Walleij wrote:
> On Mon, Sep 4, 2023 at 10:34 AM Rafał Miłecki <zajec5@gmail.com> wrote:
> 
>> I'm clueless at this point.
>> Maybe someone can come up with an idea of actual issue & ideally a
>> solution.
> 
> Damn this is frustrating.
> 
>> 2. Clock (arm,armv7-timer)
>>
>> While comparing main clock in Broadcom's SDK with upstream one I noticed
>> a tiny difference: mask value. I don't know it it makes any sense but
>> switching from CLOCKSOURCE_MASK(56) to CLOCKSOURCE_MASK(64) in
>> arm_arch_timer.c (to match SDK) increases average uptime (time before a
>> hang/lockup happens) from 4 minutes to 36 minutes.
> 
> This could be related to how often the system goes to idle.
> 
>> +       if (cpu_idle_force_poll == 1234)
>> +               arch_cpu_idle();
>> +       if (cpu_idle_force_poll == 5678)
>> +               arch_cpu_idle();
>> +       if (cpu_idle_force_poll == 1234)
>> +               arch_cpu_idle();
>> +       if (cpu_idle_force_poll == 5678)
>> +               arch_cpu_idle();
>> +       if (cpu_idle_force_poll == 1234)
>> +               arch_cpu_idle();
>> +       if (cpu_idle_force_poll == 5678)
>> +               arch_cpu_idle();
>> +       if (cpu_idle_force_poll == 1234)
>> +               arch_cpu_idle();
> 
> Idle again.
> 
> I would have tried to see what arch_cpu_idle() is doing.
> 
> arm_pm_idle() or cpu_do_idle()?

In my case arm_pm_idle is NULL.


> What happens if you just put return in arch_cpu_idle()
> so it does nothing?

Doesn't help. I also tried putting:
udelay(10);
and
udelay(1000);
at the arch_cpu_idle() beginning. None helped.


Here comes more interesting experiment though. Putting there:

if (!(foo++ % 10000)) {
	pr_info("[%s] arm_pm_idle:%ps\n", __func__, arm_pm_idle);
}

doesn't seem to help.


Putting following however seems to make kernel/device stable:

if (!(foo++ % 100)) {
	pr_info("[%s] arm_pm_idle:%ps\n", __func__, arm_pm_idle);
}


I think I'm just going to assume those chipsets are simply hw broken.

