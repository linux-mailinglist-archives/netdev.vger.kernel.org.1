Return-Path: <netdev+bounces-147655-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C58219DAF0E
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 22:43:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 681121644B7
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 21:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729F8202F8A;
	Wed, 27 Nov 2024 21:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z5HiKXtA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9384220010A;
	Wed, 27 Nov 2024 21:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732743800; cv=none; b=U0dF7Hghwdete1SXPkOvyFUhYHzyrEoVrOB/JcMIOR7M7+W7H6FrhLObULW7i+Co4CHTcSmFCm5SHJfF9yTaEIj7fv4cqbDrbMBcbOztxGmPJccIWU2KNmrZOswYbflBNHRuoQ2PIjmWunQOtwUWic2aXL0CHqye/5I39nNxSXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732743800; c=relaxed/simple;
	bh=wXs3PUI1KJZPr4gbMINQMc7jW96/qVN8Qn6yuSuatMU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QmtBK5Q93JbVOvyHYjr95fiwytzFbfzpGpISdWIIs20rWh1Z9jEh7ObToICa454W7Tuu4LdmclRSzHCZrY+PYQxHDnjoGytpp8Yh8KkF6VrLBUoXbEHsR+5hLNpHxUVjh1O78WwETdC8Bk1Wn5/fwh26GjPxV1Qjx3Ey8HwgT3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z5HiKXtA; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-723f37dd76cso206623b3a.0;
        Wed, 27 Nov 2024 13:43:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732743798; x=1733348598; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=arhcFIZy7VahGuWTmFv2wEnktXnYief+y/QrrE2UMY4=;
        b=Z5HiKXtApg8gbKmHWEniru8lO23C+Js4B7ScVqu4FMqZbU3I55kwE+EDHtJ+e+XTO7
         EocP4FqrkIlU8eaqNZHsPMKxkyAtKibm8zj4F/pe9Y5sHKH90v7+6rPgZSGEBrrAYYKM
         G2lgsWZkftFGmO1d9Y6UBXWe8KGC4uixll0vxMay0szTYdd0hvzSUdtUroRAAhRmfqmy
         B6VSnY8drXjAU5rUebF52nsXSIA5MhuS56oRg/QWBtP5u0SCl1/Ni4f/SEoZXc6hK/Wb
         SJGnPwImktWdAL8kbrdzxCeMTGsUfLGBcEFfXMYAhfn/dNY8hPm8WWCKywD3FqjL7MQE
         tlUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732743798; x=1733348598;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=arhcFIZy7VahGuWTmFv2wEnktXnYief+y/QrrE2UMY4=;
        b=ZheczDAhmOkMeBR1s2FdYk8pnis6uqa1ciDfBdMPaVYUb/xnP2eSUy+PsZTMaeL/pk
         v+rHmyFX+imhw2kVGMwBR8PncnfbGAesoYzn2hPyZJ5wLWDAdKPFIFj0nf2WvszHNShV
         0sNcJ0cq0TXe4XX6epR8EFkmla/LSVgSi5OqkhiorAtPgSLJXte7H9XIPGvJtMyeMeZA
         rd/8mXhga3Cedb1MOWEPkZ1mpdmJwfcI8/zT810syWf0xY5taREt4fH/XJWBntWaHQSS
         ZrInK9Av8/FF2ylPlCmFQV8BAvSzKxsrFdPLDwbNhaDggF6FY1Wc8UG6nDsN5uHTCvg3
         lQhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQtjuEyoM1LhvuT1ecVwHzZ4hXfuXw6Uy1FaZ2SGd2b/UOtC4zZ1T0UgAaD+BPHWDLeSjBzE5pg/1xSGGD@vger.kernel.org, AJvYcCUxT0jG1Dvq/6k6a4wqY+nT1kr+EQnxDCCwcidc6bdgyiU0G7KqkcbekWb9lIReu3AGJScx0btNLtM=@vger.kernel.org, AJvYcCWFgcuobWLQw2cOj5jsQuvUWuJfB0XMi8BDMjy2khh+Am8215+jXzHQvyv8mXgrVE8KNNipwBae@vger.kernel.org
X-Gm-Message-State: AOJu0YwiLd/V2ZTfUQ+ALsRXUw+ycmtRI7hyQBBaXaUk9/2n1uaBeVpH
	l5SWSDHUulagD2PhC+YEk/ZhOKl9tYBIuJqN3lR/nbWyXGA9Hr60
X-Gm-Gg: ASbGncupgAvO+qreZ3sBm//rvdB+IYnxCBAZfJhOObRwUJk7xWa13ucvXIvPvhjHl0P
	CtgYBc+LIrJHYA+rEN2jkW96O4io/39p/hiAIc/2gQKHCCKIp1ur1h9JA+t1bkdERIoJZkS25kR
	RzUsugs2cq6NI2HmkOFpUjVTgF42S9x6od8rcSjWmclqPTYrPOtLu1E7e9dQkw/NKVr+2+DU+Sf
	ITOVrcC2iZwxWnjYRpzq4k8HqE3MnjsJ2S8C3ggYfPg1kbTiEew/Av2lYI6G7JX7uavZX8UGVH0
	gUFEnwSmmQzxnNmmsNGq9Eo=
X-Google-Smtp-Source: AGHT+IEK5Sbm+WjJDR6g2t17R+og0Bt/of1ihGcPnWxde7ZGgJvdB84cOxRI2r3c4nE0cbTdBy8Hzg==
X-Received: by 2002:a05:6a00:b81:b0:724:fac6:35f2 with SMTP id d2e1a72fcca58-725300107f4mr5154814b3a.9.1732743797849;
        Wed, 27 Nov 2024 13:43:17 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72541762411sm37158b3a.20.2024.11.27.13.43.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Nov 2024 13:43:17 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <f04406c5-f805-4de3-8a7c-abfdfd91a501@roeck-us.net>
Date: Wed, 27 Nov 2024 13:43:14 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next v6 5/9] net: napi: Add napi_config
To: Joe Damato <jdamato@fastly.com>, netdev@vger.kernel.org,
 mkarsten@uwaterloo.ca, skhawaja@google.com, sdf@fomichev.me,
 bjorn@rivosinc.com, amritha.nambiar@intel.com, sridhar.samudrala@intel.com,
 willemdebruijn.kernel@gmail.com, edumazet@google.com,
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 Jiri Pirko <jiri@resnulli.us>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Johannes Berg <johannes.berg@intel.com>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>, pcnet32@frontier.com
References: <20241011184527.16393-1-jdamato@fastly.com>
 <20241011184527.16393-6-jdamato@fastly.com>
 <85dd4590-ea6b-427d-876a-1d8559c7ad82@roeck-us.net>
 <Z0dqJNnlcIrvLuV6@LQ3V64L9R2>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <Z0dqJNnlcIrvLuV6@LQ3V64L9R2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/27/24 10:51, Joe Damato wrote:
> On Wed, Nov 27, 2024 at 09:43:54AM -0800, Guenter Roeck wrote:
>> Hi,
>>
>> On Fri, Oct 11, 2024 at 06:45:00PM +0000, Joe Damato wrote:
>>> Add a persistent NAPI config area for NAPI configuration to the core.
>>> Drivers opt-in to setting the persistent config for a NAPI by passing an
>>> index when calling netif_napi_add_config.
>>>
>>> napi_config is allocated in alloc_netdev_mqs, freed in free_netdev
>>> (after the NAPIs are deleted).
>>>
>>> Drivers which call netif_napi_add_config will have persistent per-NAPI
>>> settings: NAPI IDs, gro_flush_timeout, and defer_hard_irq settings.
>>>
>>> Per-NAPI settings are saved in napi_disable and restored in napi_enable.
>>>
>>> Co-developed-by: Martin Karsten <mkarsten@uwaterloo.ca>
>>> Signed-off-by: Martin Karsten <mkarsten@uwaterloo.ca>
>>> Signed-off-by: Joe Damato <jdamato@fastly.com>
>>> Reviewed-by: Jakub Kicinski <kuba@kernel.org>
>>
>> This patch triggers a lock inversion message on pcnet Ethernet adapters.
> 
> Thanks for the report. I am not familiar with the pcnet driver, but
> took some time now to read the report below and the driver code.
> 
> I could definitely be reading the output incorrectly (if so please
> let me know), but it seems like the issue can be triggered in this
> case:
> 
> CPU 0:
> pcnet32_open
>     lock(lp->lock)
>       napi_enable
>         napi_hash_add
>           lock(napi_hash_lock)
>           unlock(napi_hash_lock)
>     unlock(lp->lock)
> 
> 
> Meanwhile on CPU 1:
>    pcnet32_close
>      napi_disable
>        napi_hash_del
>          lock(napi_hash_lock)
>          unlock(napi_hash_lock)
>      lock(lp->lock)
>      [... other code ...]
>      unlock(lp->lock)
>      [... other code ...]
>      lock(lp->lock)
>      [... other code ...]
>      unlock(lp->lock)
> 
> In other words: while the close path is holding napi_hash_lock (and
> before it acquires lp->lock), the enable path takes lp->lock and
> then napi_hash_lock.
> 
> It seems this was triggered because before the identified commit,
> napi_enable did not call napi_hash_add (and thus did not take the
> napi_hash_lock).
> 
> So, I agree there is an inversion; I can't say for sure if this
> would cause a deadlock in certain situations. It seems like
> napi_hash_del in the close path will return, so the inversion
> doesn't seem like it'd lead to a deadlock, but I am not an expert in
> this and could certainly be wrong.
> 
> I wonder if a potential fix for this would be in the driver's close
> function?
> 
> In pcnet32_open the order is:
>    lock(lp->lock)
>      napi_enable
>      netif_start_queue
>      mod_timer(watchdog)
>    unlock(lp->lock)
> 
> Perhaps pcnet32_close should be the same?
> 
> I've included an example patch below for pcnet32_close and I've CC'd
> the maintainer of pcnet32 that is not currently CC'd.
> 
> Guenter: Is there any change you might be able to test the proposed
> patch below?
> 

I moved the spinlock after del_timer_sync() because it is not a good idea
to hold a spinlock when calling that function. That results in:

[   10.646956] BUG: sleeping function called from invalid context at net/core/dev.c:6775
[   10.647142] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 1817, name: ip
[   10.647237] preempt_count: 1, expected: 0
[   10.647319] 2 locks held by ip/1817:
[   10.647383]  #0: ffffffff81ded990 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_newlink+0x22a/0x74c
[   10.647880]  #1: ff6000000498ccb0 (&lp->lock){-.-.}-{3:3}, at: pcnet32_close+0x40/0x126
[   10.648050] irq event stamp: 3720
[   10.648102] hardirqs last  enabled at (3719): [<ffffffff80decaf4>] _raw_spin_unlock_irqrestore+0x54/0x62
[   10.648204] hardirqs last disabled at (3720): [<ffffffff80dec8a2>] _raw_spin_lock_irqsave+0x5e/0x64
[   10.648301] softirqs last  enabled at (3712): [<ffffffff8001efca>] handle_softirqs+0x3e6/0x4a2
[   10.648396] softirqs last disabled at (3631): [<ffffffff80ded6cc>] __do_softirq+0x12/0x1a
[   10.648666] CPU: 0 UID: 0 PID: 1817 Comm: ip Tainted: G                 N 6.12.0-10313-g7d4050728c83-dirty #1
[   10.648828] Tainted: [N]=TEST
[   10.648879] Hardware name: riscv-virtio,qemu (DT)
[   10.648978] Call Trace:
[   10.649048] [<ffffffff80006d42>] dump_backtrace+0x1c/0x24
[   10.649117] [<ffffffff80dc8d94>] show_stack+0x2c/0x38
[   10.649180] [<ffffffff80de00b0>] dump_stack_lvl+0x74/0xac
[   10.649246] [<ffffffff80de00fc>] dump_stack+0x14/0x1c
[   10.649308] [<ffffffff8004da18>] __might_resched+0x23e/0x248
[   10.649377] [<ffffffff8004da60>] __might_sleep+0x3e/0x62
[   10.649441] [<ffffffff80b8d370>] napi_disable+0x24/0x10c
[   10.649506] [<ffffffff809a06fe>] pcnet32_close+0x6c/0x126
...

This is due to might_sleep() at the beginning of napi_disable(). So it doesn't
work as intended, it just replaces one problem with another.

> Don: Would you mind taking a look to see if this change is sensible?
> 
> Netdev maintainers: at a higher level, I'm not sure how many other
> drivers might have locking patterns like this that commit
> 86e25f40aa1e ("net: napi: Add napi_config") will break in a similar
> manner.
> 
> Do I:
>    - comb through drivers trying to identify these, and/or

Coccinelle, checking for napi_enable calls under spinlock, points to:

napi_enable called under spin_lock_irqsave from drivers/net/ethernet/via/via-velocity.c:2325
napi_enable called under spin_lock_irqsave from drivers/net/can/grcan.c:1076
napi_enable called under spin_lock from drivers/net/ethernet/marvell/mvneta.c:4388
napi_enable called under spin_lock_irqsave from drivers/net/ethernet/amd/pcnet32.c:2104

Guenter

>    - do we find a way to implement the identified commit with the
>      original lock ordering to avoid breaking any other driver?
> 
> I'd appreciate guidance/insight from the maintainers on how to best
> proceed.
> 
> diff --git a/drivers/net/ethernet/amd/pcnet32.c b/drivers/net/ethernet/amd/pcnet32.c
> index 72db9f9e7bee..ff56a308fec9 100644
> --- a/drivers/net/ethernet/amd/pcnet32.c
> +++ b/drivers/net/ethernet/amd/pcnet32.c
> @@ -2623,13 +2623,13 @@ static int pcnet32_close(struct net_device *dev)
>          struct pcnet32_private *lp = netdev_priv(dev);
>          unsigned long flags;
> 
> +       spin_lock_irqsave(&lp->lock, flags);
> +
>          del_timer_sync(&lp->watchdog_timer);
> 
>          netif_stop_queue(dev);
>          napi_disable(&lp->napi);
> 
> -       spin_lock_irqsave(&lp->lock, flags);
> -
>          dev->stats.rx_missed_errors = lp->a->read_csr(ioaddr, 112);
> 
>          netif_printk(lp, ifdown, KERN_DEBUG, dev,


