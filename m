Return-Path: <netdev+bounces-95596-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E6598C2C6F
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 00:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30C2D1C21960
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 22:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A621A13CFA4;
	Fri, 10 May 2024 22:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HSegGdgB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E5913CFA3
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 22:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715378769; cv=none; b=OTabvL7GPCpUpyCehK9GDSLuR6nRgyaYZmloJum7glwsCxKuc6JcRcTcz6tUGs68fNtdIJhlcoWKNi3c760Pb5YRIctSD8srg9jG1LtE9BVkA9kjGry2wuVjIZHgpXB5bVoSqjyiPm7P+cPHuj01plBbt/rVvUHa99OPAeK9SLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715378769; c=relaxed/simple;
	bh=Vh4PKyqzUm8eI1OFfRz+4GaGUH/HSipUQb22rOAuUog=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VoaG5gTStuAoWBsd00AZsZs8/VOwJ1si62zXuWqffM64Jmew0ebTr02UtYIp7xg6hEXGQ/3FrCPRmNIyoTjA9B70md6Q/ECJDVqKRiEGf8YXTonQqFYcPoAP0g9GE+L8sH9oBSfqO6/j0TFrIoBVTXZGth6RotwFswRbHMjkzUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HSegGdgB; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-41ebcf01013so14311505e9.0
        for <netdev@vger.kernel.org>; Fri, 10 May 2024 15:06:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715378766; x=1715983566; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=IuOdFTTJrGv04nctXPlh2vl7GGCFUQIA6nTAExRsppo=;
        b=HSegGdgBmFYFGq8W7r7DQb0+fumo8LZNJ9/86Vy80DLOuogIP0Mlu3ev9iCuxG/P4G
         jiWwIwR5z1fscHBtBLqR1onmA/zd62PKRlzftqgHX82Lw5mLFAnRC+d6E3bbp2h5JP90
         FP+pdQDsLWcZU6fpXrzjp38opYt3SkInHnAYGvk6z6FtLLu6rgqXXeT+QXxjDd4NVnMZ
         7XEdaPzU2Rl8g992Qo1dsB/fQoOgdIwGjzq3OUJuezx25KENI9B9Sp97xgJHw6ng5ARI
         /hT2ExvXD8Nvx8376MXHoSL/Iqb8FWIjtOapj3M6nVDb0FQp41bRSPVI3mjiUmvbVo+u
         VMZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715378766; x=1715983566;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IuOdFTTJrGv04nctXPlh2vl7GGCFUQIA6nTAExRsppo=;
        b=gsZTT4+8MolCbQx3qwFtLgTKW9c5gr3XIQED6/L7EkIkW031Avy3cgTGtxsVpS8b91
         P/F+BdFfClI06CGveX8LcSjOqHIJbl4l3d2fF1ZWojwdfjiu4zAmeId3pCmn9iens9lc
         dhQCXx8uAAiGhGWXJFkdWdsyjGJIlWmIQ2GAG93RhB9mlCREkc8pNjdz1hFMqRaRn0lt
         lSDRMdKbYXebsrboAWKl9fyhsO/MsJ8t1BIpat5vrNLmGpGPXbTDvrj23BsK2K8+wPIU
         xqPY322CyV9xknq2EJSJXNI+zOLdvrgtaibyvCeB2/U/rFDC1KHlc11XkerBNMUFskww
         Ho0w==
X-Forwarded-Encrypted: i=1; AJvYcCVQtVw/F8NUfhKEyHO+YCqs20asSd2HROrHI6lD+lfPU83rLA1+gq076TwMR5dJSGKFShUQzBsSob0nispTlVh6/txowCtj
X-Gm-Message-State: AOJu0YzLHeN9v5+3iSlTIMP4HkKA8/87VfKmROalcw1JnLnsk68PljIm
	oMCjc2ELqrJKnYKVKZdGPswnZjDIo0OrMnpbag42vXO8vQ+hBadT
X-Google-Smtp-Source: AGHT+IEuu4mqzTaOKEkzofIPv6hV9BtpSHQ6F30ErqUETKlEjr2yxgND/Nnq5YYrDRqKV6bYscBTUQ==
X-Received: by 2002:a05:600c:4f06:b0:418:2981:c70f with SMTP id 5b1f17b1804b1-41fbcfb8473mr61113725e9.19.1715378765649;
        Fri, 10 May 2024 15:06:05 -0700 (PDT)
Received: from ?IPV6:2a01:c23:b9a1:7300:ace1:b314:fd08:7c6a? (dynamic-2a01-0c23-b9a1-7300-ace1-b314-fd08-7c6a.c23.pool.telefonica.de. [2a01:c23:b9a1:7300:ace1:b314:fd08:7c6a])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-41f87d200c6sm111618285e9.23.2024.05.10.15.06.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 May 2024 15:06:05 -0700 (PDT)
Message-ID: <adfb0005-3283-4138-97d5-b4af3a314d98@gmail.com>
Date: Sat, 11 May 2024 00:06:04 +0200
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
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <5181a634-fe25-45e7-803e-eb8737990e01@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10.05.2024 00:24, Ken Milmore wrote:
> On 08/05/2024 22:14, Heiner Kallweit wrote:
>>
>> Re-reading &tp->napi may be racy, and I think the code delivers
>> a wrong result if NAPI_STATE_SCHEDand NAPI_STATE_DISABLE
>> both are set.
>>
>>>  out:
>>>         rtl_ack_events(tp, status);
>>
>> The following uses a modified version of napi_schedule_prep()
>> to avoid re-reading the napi state.
>> We would have to see whether this extension to the net core is
>> acceptable, as r8169 would be the only user for now.
>> For testing it's one patch, for submitting it would need to be
>> splitted.
>>
>> ---
>>  drivers/net/ethernet/realtek/r8169_main.c |  6 ++++--
>>  include/linux/netdevice.h                 |  7 ++++++-
>>  net/core/dev.c                            | 12 ++++++------
>>  3 files changed, 16 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
>> index eb329f0ab..94b97a16d 100644
>> --- a/drivers/net/ethernet/realtek/r8169_main.c
>> +++ b/drivers/net/ethernet/realtek/r8169_main.c
>> @@ -4639,6 +4639,7 @@ static irqreturn_t rtl8169_interrupt(int irq, void *dev_instance)
>>  {
>>  	struct rtl8169_private *tp = dev_instance;
>>  	u32 status = rtl_get_events(tp);
>> +	int ret;
>>  
>>  	if ((status & 0xffff) == 0xffff || !(status & tp->irq_mask))
>>  		return IRQ_NONE;
>> @@ -4657,10 +4658,11 @@ static irqreturn_t rtl8169_interrupt(int irq, void *dev_instance)
>>  		rtl_schedule_task(tp, RTL_FLAG_TASK_RESET_PENDING);
>>  	}
>>  
>> -	if (napi_schedule_prep(&tp->napi)) {
>> +	ret = __napi_schedule_prep(&tp->napi);
>> +	if (ret >= 0)
>>  		rtl_irq_disable(tp);
>> +	if (ret > 0)
>>  		__napi_schedule(&tp->napi);
>> -	}
>>  out:
>>  	rtl_ack_events(tp, status);
>>  
>> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
>> index 42b9e6dc6..3df560264 100644
>> --- a/include/linux/netdevice.h
>> +++ b/include/linux/netdevice.h
>> @@ -498,7 +498,12 @@ static inline bool napi_is_scheduled(struct napi_struct *n)
>>  	return test_bit(NAPI_STATE_SCHED, &n->state);
>>  }
>>  
>> -bool napi_schedule_prep(struct napi_struct *n);
>> +int __napi_schedule_prep(struct napi_struct *n);
>> +
>> +static inline bool napi_schedule_prep(struct napi_struct *n)
>> +{
>> +	return __napi_schedule_prep(n) > 0;
>> +}
>>  
>>  /**
>>   *	napi_schedule - schedule NAPI poll
>> diff --git a/net/core/dev.c b/net/core/dev.c
>> index 4bf081c5a..126eab121 100644
>> --- a/net/core/dev.c
>> +++ b/net/core/dev.c
>> @@ -6102,21 +6102,21 @@ void __napi_schedule(struct napi_struct *n)
>>  EXPORT_SYMBOL(__napi_schedule);
>>  
>>  /**
>> - *	napi_schedule_prep - check if napi can be scheduled
>> + *	__napi_schedule_prep - check if napi can be scheduled
>>   *	@n: napi context
>>   *
>>   * Test if NAPI routine is already running, and if not mark
>>   * it as running.  This is used as a condition variable to
>> - * insure only one NAPI poll instance runs.  We also make
>> - * sure there is no pending NAPI disable.
>> + * insure only one NAPI poll instance runs. Return -1 if
>> + * there is a pending NAPI disable.
>>   */
>> -bool napi_schedule_prep(struct napi_struct *n)
>> +int __napi_schedule_prep(struct napi_struct *n)
>>  {
>>  	unsigned long new, val = READ_ONCE(n->state);
>>  
>>  	do {
>>  		if (unlikely(val & NAPIF_STATE_DISABLE))
>> -			return false;
>> +			return -1;
>>  		new = val | NAPIF_STATE_SCHED;
>>  
>>  		/* Sets STATE_MISSED bit if STATE_SCHED was already set
>> @@ -6131,7 +6131,7 @@ bool napi_schedule_prep(struct napi_struct *n)
>>  
>>  	return !(val & NAPIF_STATE_SCHED);
>>  }
>> -EXPORT_SYMBOL(napi_schedule_prep);
>> +EXPORT_SYMBOL(__napi_schedule_prep);
>>  
>>  /**
>>   * __napi_schedule_irqoff - schedule for receive
> 
> Here is a possible alternative (albeit expensive), using a flag in the driver:
> 
> diff --git linux-source-6.1~/drivers/net/ethernet/realtek/r8169_main.c linux-source-6.1/drivers/net/ethernet/realtek/r8169_main.c
> index 6e34177..d703af1 100644
> --- linux-source-6.1~/drivers/net/ethernet/realtek/r8169_main.c
> +++ linux-source-6.1/drivers/net/ethernet/realtek/r8169_main.c
> @@ -579,6 +579,7 @@ enum rtl_flag {
>         RTL_FLAG_TASK_RESET_PENDING,
>         RTL_FLAG_TASK_RESET_NO_QUEUE_WAKE,
>         RTL_FLAG_TASK_TX_TIMEOUT,
> +       RTL_FLAG_IRQ_DISABLED,
>         RTL_FLAG_MAX
>  };
>  
> @@ -4609,6 +4610,7 @@ static irqreturn_t rtl8169_interrupt(int irq, void *dev_instance)
>  
>         if (napi_schedule_prep(&tp->napi)) {
>                 rtl_irq_disable(tp);
> +               set_bit(RTL_FLAG_IRQ_DISABLED, tp->wk.flags);
>                 __napi_schedule(&tp->napi);
>         }
>  out:
> @@ -4655,12 +4657,17 @@ static int rtl8169_poll(struct napi_struct *napi, int budget)
>         struct net_device *dev = tp->dev;
>         int work_done;
>  
> +       if (!test_and_set_bit(RTL_FLAG_IRQ_DISABLED, tp->wk.flags))
> +               rtl_irq_disable(tp);
> +
>         rtl_tx(dev, tp, budget);
>  
>         work_done = rtl_rx(dev, tp, budget);
>  
> -       if (work_done < budget && napi_complete_done(napi, work_done))
> +       if (work_done < budget && napi_complete_done(napi, work_done)) {
> +               clear_bit(RTL_FLAG_IRQ_DISABLED, tp->wk.flags);
>                 rtl_irq_enable(tp);
> +       }
>  
>         return work_done;
>  }
> 
> 
> 
> 

Nice idea. The following is a simplified version.
It's based on the thought that between scheduling NAPI and start of NAPI
polling interrupts don't hurt.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/ethernet/realtek/r8169_main.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index e5ea827a2..7b04dfecc 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -592,6 +592,7 @@ enum rtl_flag {
 	RTL_FLAG_TASK_RESET_PENDING,
 	RTL_FLAG_TASK_RESET_NO_QUEUE_WAKE,
 	RTL_FLAG_TASK_TX_TIMEOUT,
+	RTL_FLAG_IRQ_DISABLED,
 	RTL_FLAG_MAX
 };
 
@@ -4657,10 +4658,7 @@ static irqreturn_t rtl8169_interrupt(int irq, void *dev_instance)
 		rtl_schedule_task(tp, RTL_FLAG_TASK_RESET_PENDING);
 	}
 
-	if (napi_schedule_prep(&tp->napi)) {
-		rtl_irq_disable(tp);
-		__napi_schedule(&tp->napi);
-	}
+	napi_schedule(&tp->napi);
 out:
 	rtl_ack_events(tp, status);
 
@@ -4714,12 +4712,17 @@ static int rtl8169_poll(struct napi_struct *napi, int budget)
 	struct net_device *dev = tp->dev;
 	int work_done;
 
+	if (!test_and_set_bit(RTL_FLAG_IRQ_DISABLED, tp->wk.flags))
+		rtl_irq_disable(tp);
+
 	rtl_tx(dev, tp, budget);
 
 	work_done = rtl_rx(dev, tp, budget);
 
-	if (work_done < budget && napi_complete_done(napi, work_done))
+	if (work_done < budget && napi_complete_done(napi, work_done)) {
+		clear_bit(RTL_FLAG_IRQ_DISABLED, tp->wk.flags);
 		rtl_irq_enable(tp);
+	}
 
 	return work_done;
 }
-- 
2.45.0



