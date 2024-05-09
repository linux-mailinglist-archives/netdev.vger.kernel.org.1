Return-Path: <netdev+bounces-95165-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9FD38C195C
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 00:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30CB81F22CC8
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 22:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E513129A93;
	Thu,  9 May 2024 22:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q1jC5m/v"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B28129A75
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 22:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715293488; cv=none; b=bpYrXsJGK/ynDiivvMTXS+gcfIDy59zHMG4DBDq9qJNGbkQpns/AvvANDYRLKG0DcDsCoKCqZa2VHXTDsinm3uum7ms9HAMyyO5k0eHvrcemjI9KFxk6JZjzFXO/e5LkHFPhq/RaW1LIov0Z6bs8JgvAsfFn/tA0q5k+MsU/1h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715293488; c=relaxed/simple;
	bh=A7HQoEVLg363Kw8M9tyRRYJxKy30dEI+M2kLcBx+3SA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dy4IqttNf5uwjzfsMZ8u5ZXZMGcPgBsqPGn5v2+ZiyNa5TS8qXiQmV4treEb3iSaeuIoCY+JK95jrQErzBilmEIeBgP9vf5033dM/+3TmPUnkA6sAvOZj4+/hSkuFiEa7sxbRzvURenTD4Ml7QNaEjTg+GTOFMDAW64bw1jTZC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q1jC5m/v; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-41fd5dc0508so7746865e9.0
        for <netdev@vger.kernel.org>; Thu, 09 May 2024 15:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715293484; x=1715898284; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wJ8Wl2tPHOVBucFMYliOMSBHglVp39UymRVl07UZrqo=;
        b=Q1jC5m/v3UdaV6SbMDbJo4sZGC1x8e/BQ6CIbF3KBoKO+jEG89CNBI1OAf5hcSZaJm
         NKZZj8PJG7bIfA6szpZ/bfKOTCyz4SGQIdy5xnhoS15YoEadbha0nL80OCQo/efdvRqU
         aEp/kkbhKN+47wIw9OQr8L72XTtpDeUuhQvCInKTapp7nENVITHqNLYE9hNkAr5t8lbo
         oBVvANt1F+9jp/g6BoCdrJFdSxrE34ptCB8nY7yb0CImnvxyAYWSKnEhS09tvwX+gxxF
         Zu2KcivO/enet9M7wAlwdkLGIRPOLvZ+3F7aUKxGa/DPhsIserL/NeW7H3qduplPek8C
         M4hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715293484; x=1715898284;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wJ8Wl2tPHOVBucFMYliOMSBHglVp39UymRVl07UZrqo=;
        b=mYbh7E0Nhjda3co0sVvbzyzaqNLABSOKsEjvDcduAExFhmxAiL43Eyfug1Sf+5mRwm
         GYBwh2m/oMiGurNP8rYJ2BJ3EG2X6/gxXQgqrNesOCLI6wNbjJZJmcJa/ialVo1iXgVR
         SJDpj41psXtFodW2b/7qO+a94FKu+2WTit2noeg/3G4BO0XccXBQYsL7uHBJ5jDk2P+O
         gu6FNCN9lds8RD5oMiKs9JErqAKcCfeRrDhp3qo9d98qeqtZ8IgqZ/IvDppS+jaJq7Dm
         alf7G8KiYCy0c3Otz0S1ltjhrYLynO4AS6vQcediGVRowzlqwuezpVSRFLwb55s0puuL
         yfEQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9U7J6pnqLHCIp6Rx1ez0CNNKo+M1wx0zy9rbyVErct+dDxbfrzyTD84uIlNg1bMdwvMcMo/l3LkFR4WpNQ7+xmqOFmM8E
X-Gm-Message-State: AOJu0Yw1h+NB0eqEFHoE85UeB+dIU8GoakhHFNiytrlrIiaIxONJAawd
	fwBbJg8aYF/g9gchFgZiF8eC8us6wnDl9cDpx82MUnlhJcWh1WbSQxI05ymp
X-Google-Smtp-Source: AGHT+IGo3wY5Zd87sPpPGVtTuH5iIPdPoEoTWIaPlJSM6i5y1UxmeLIBi7bNS74K57WksyD8w2OXDQ==
X-Received: by 2002:a05:600c:24d:b0:41a:7bbe:c3bf with SMTP id 5b1f17b1804b1-41feaa44107mr6710265e9.22.1715293484110;
        Thu, 09 May 2024 15:24:44 -0700 (PDT)
Received: from [192.168.1.58] (111.68.9.51.dyn.plus.net. [51.9.68.111])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccee92c7sm40970435e9.34.2024.05.09.15.24.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 May 2024 15:24:43 -0700 (PDT)
Message-ID: <5181a634-fe25-45e7-803e-eb8737990e01@gmail.com>
Date: Thu, 9 May 2024 23:24:42 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: r8169: transmit queue timeouts and IRQ masking
To: Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org
Cc: nic_swsd@realtek.com
References: <ad6a0c52-4dcb-444e-88cd-a6c490a817fe@gmail.com>
 <f4197a6d-d829-4adf-8666-1390f2355540@gmail.com>
Content-Language: en-GB
From: Ken Milmore <ken.milmore@gmail.com>
In-Reply-To: <f4197a6d-d829-4adf-8666-1390f2355540@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/05/2024 22:14, Heiner Kallweit wrote:
> 
> Re-reading &tp->napi may be racy, and I think the code delivers
> a wrong result if NAPI_STATE_SCHEDand NAPI_STATE_DISABLE
> both are set.
> 
>>  out:
>>         rtl_ack_events(tp, status);
> 
> The following uses a modified version of napi_schedule_prep()
> to avoid re-reading the napi state.
> We would have to see whether this extension to the net core is
> acceptable, as r8169 would be the only user for now.
> For testing it's one patch, for submitting it would need to be
> splitted.
> 
> ---
>  drivers/net/ethernet/realtek/r8169_main.c |  6 ++++--
>  include/linux/netdevice.h                 |  7 ++++++-
>  net/core/dev.c                            | 12 ++++++------
>  3 files changed, 16 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index eb329f0ab..94b97a16d 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -4639,6 +4639,7 @@ static irqreturn_t rtl8169_interrupt(int irq, void *dev_instance)
>  {
>  	struct rtl8169_private *tp = dev_instance;
>  	u32 status = rtl_get_events(tp);
> +	int ret;
>  
>  	if ((status & 0xffff) == 0xffff || !(status & tp->irq_mask))
>  		return IRQ_NONE;
> @@ -4657,10 +4658,11 @@ static irqreturn_t rtl8169_interrupt(int irq, void *dev_instance)
>  		rtl_schedule_task(tp, RTL_FLAG_TASK_RESET_PENDING);
>  	}
>  
> -	if (napi_schedule_prep(&tp->napi)) {
> +	ret = __napi_schedule_prep(&tp->napi);
> +	if (ret >= 0)
>  		rtl_irq_disable(tp);
> +	if (ret > 0)
>  		__napi_schedule(&tp->napi);
> -	}
>  out:
>  	rtl_ack_events(tp, status);
>  
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 42b9e6dc6..3df560264 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -498,7 +498,12 @@ static inline bool napi_is_scheduled(struct napi_struct *n)
>  	return test_bit(NAPI_STATE_SCHED, &n->state);
>  }
>  
> -bool napi_schedule_prep(struct napi_struct *n);
> +int __napi_schedule_prep(struct napi_struct *n);
> +
> +static inline bool napi_schedule_prep(struct napi_struct *n)
> +{
> +	return __napi_schedule_prep(n) > 0;
> +}
>  
>  /**
>   *	napi_schedule - schedule NAPI poll
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 4bf081c5a..126eab121 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -6102,21 +6102,21 @@ void __napi_schedule(struct napi_struct *n)
>  EXPORT_SYMBOL(__napi_schedule);
>  
>  /**
> - *	napi_schedule_prep - check if napi can be scheduled
> + *	__napi_schedule_prep - check if napi can be scheduled
>   *	@n: napi context
>   *
>   * Test if NAPI routine is already running, and if not mark
>   * it as running.  This is used as a condition variable to
> - * insure only one NAPI poll instance runs.  We also make
> - * sure there is no pending NAPI disable.
> + * insure only one NAPI poll instance runs. Return -1 if
> + * there is a pending NAPI disable.
>   */
> -bool napi_schedule_prep(struct napi_struct *n)
> +int __napi_schedule_prep(struct napi_struct *n)
>  {
>  	unsigned long new, val = READ_ONCE(n->state);
>  
>  	do {
>  		if (unlikely(val & NAPIF_STATE_DISABLE))
> -			return false;
> +			return -1;
>  		new = val | NAPIF_STATE_SCHED;
>  
>  		/* Sets STATE_MISSED bit if STATE_SCHED was already set
> @@ -6131,7 +6131,7 @@ bool napi_schedule_prep(struct napi_struct *n)
>  
>  	return !(val & NAPIF_STATE_SCHED);
>  }
> -EXPORT_SYMBOL(napi_schedule_prep);
> +EXPORT_SYMBOL(__napi_schedule_prep);
>  
>  /**
>   * __napi_schedule_irqoff - schedule for receive

Here is a possible alternative (albeit expensive), using a flag in the driver:

diff --git linux-source-6.1~/drivers/net/ethernet/realtek/r8169_main.c linux-source-6.1/drivers/net/ethernet/realtek/r8169_main.c
index 6e34177..d703af1 100644
--- linux-source-6.1~/drivers/net/ethernet/realtek/r8169_main.c
+++ linux-source-6.1/drivers/net/ethernet/realtek/r8169_main.c
@@ -579,6 +579,7 @@ enum rtl_flag {
        RTL_FLAG_TASK_RESET_PENDING,
        RTL_FLAG_TASK_RESET_NO_QUEUE_WAKE,
        RTL_FLAG_TASK_TX_TIMEOUT,
+       RTL_FLAG_IRQ_DISABLED,
        RTL_FLAG_MAX
 };
 
@@ -4609,6 +4610,7 @@ static irqreturn_t rtl8169_interrupt(int irq, void *dev_instance)
 
        if (napi_schedule_prep(&tp->napi)) {
                rtl_irq_disable(tp);
+               set_bit(RTL_FLAG_IRQ_DISABLED, tp->wk.flags);
                __napi_schedule(&tp->napi);
        }
 out:
@@ -4655,12 +4657,17 @@ static int rtl8169_poll(struct napi_struct *napi, int budget)
        struct net_device *dev = tp->dev;
        int work_done;
 
+       if (!test_and_set_bit(RTL_FLAG_IRQ_DISABLED, tp->wk.flags))
+               rtl_irq_disable(tp);
+
        rtl_tx(dev, tp, budget);
 
        work_done = rtl_rx(dev, tp, budget);
 
-       if (work_done < budget && napi_complete_done(napi, work_done))
+       if (work_done < budget && napi_complete_done(napi, work_done)) {
+               clear_bit(RTL_FLAG_IRQ_DISABLED, tp->wk.flags);
                rtl_irq_enable(tp);
+       }
 
        return work_done;
 }





