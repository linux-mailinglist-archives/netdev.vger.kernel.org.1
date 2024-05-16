Return-Path: <netdev+bounces-96795-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A5058C7DE5
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 23:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9AE12829FD
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 21:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205E9157E82;
	Thu, 16 May 2024 21:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nKipVV9H"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E74726AEA
	for <netdev@vger.kernel.org>; Thu, 16 May 2024 21:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715893829; cv=none; b=jN38yexHPjt6crU/GCZ/3Ngkt3/XKCLAuSnS8/tT45gsN1HUpK83IzL2o5l2/LibsRXLoUSm4UbtvLTCpSl0qGpng7PE/4+D5edc+ZVhmZ5nHayl1sTN12f3AFzbjtQoO5csYQJw66Scwn7WKf3yWLSPco+8wY1l4Xt1WEMYxo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715893829; c=relaxed/simple;
	bh=61To3U1BJ8KIm1flnm6QXQ7nH7fJUD1gP+QELq943Rs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hPUkwxnpRD6DvM7PUQ5JW+dmXFu9D5ShXlFpcpm1k3irIbe+dn7jB6kYwkXxoIflHD0sEj64cAobmaoPcMdsbZw1A3ogyCvxQnsxcFeuSzt0mxBmuwEF3Q/1n1hUv2S56XYxaSpJ76kdOnOuL4MzVTSmmcn40j3F3t7oR9Jexrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nKipVV9H; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42016c8daa7so34428105e9.2
        for <netdev@vger.kernel.org>; Thu, 16 May 2024 14:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715893825; x=1716498625; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WOiA4Wp2oUV3fRuzQBIO2gbiVYSCBWCran4MYc20h+A=;
        b=nKipVV9HPK+jsiuOrot/ePhbeaKtbIoKpcgLx3gbiOdeHX5Uzt/D9ACnz8b9DUeoi/
         UmYaVqIY5Mmu7MDNtxYqMP25C2wBYK5wl7MtOK8rGocFh6MQrOnARwgjs+Q3oNcMveOy
         GTTMelPnXCqmNiPCMA15fvqyHYQ6v9Cpw/IqQ0lgtah05nqkJejg1tz8Wj0guJnKz3NS
         qubnk8v/HvDAOfAfkMg0aSnOKXHu7IocBHS6C3jaoz3pF3QyC282k+UMwDqpVEneqsbB
         CTx9NQAp5PWP3yCQ/u9lDGGt9yr4MnzN4Q342DmBt4IATeRzQnTFKco3gm7WasDEz6GM
         23+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715893825; x=1716498625;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WOiA4Wp2oUV3fRuzQBIO2gbiVYSCBWCran4MYc20h+A=;
        b=lR+VVSYsT3k1kmuTWSiYv4slxEyHDMqf4I5+vLAthQCrupRBQ8Q6enTL4igxE4kYSQ
         b2zCkrOvFQGi0NVlQL84LbkMlm7rz/70emnpCgAdLSfyFCp5D4OTeMSN+/06x/zhqGDe
         2oqJsVaVk9CMZSkVqJ0tcRLwdVxiU2znNE3uIgRGsB5cda4Pgft7XRfW3eQhwzcpB27Q
         6nGIT1xM2Yve3T5d5zhKoeYyMjFahVgo1evX5nNpm2S1T0kDMEG7GAxFkMNfZ+tIwIjd
         1UM72z0UhP+u3ZSv5kU8KO87ih1/fZpEOywQelfsLAQ0OHzwCXSXZOBaCLSTMsQUg2yg
         c+dQ==
X-Gm-Message-State: AOJu0Yxcp9veY5NqOMn/0rRg0Krv2GRTtbivLuXoYF1DQsVcxWtRcadX
	DstjRL9QKKTOb5mKOr2dLd8FNBelOhX6UvOOrBCtYlTojzGo0N/jrPfAqUky
X-Google-Smtp-Source: AGHT+IEWA/yX9LlZl0B3A/A9aO6KHmaVWhUaXQZy9h6Fojswg7TxXyg2js2haO+LdQRXObx/YMNguw==
X-Received: by 2002:a05:600c:4f83:b0:418:2ccf:cbc7 with SMTP id 5b1f17b1804b1-41feaa2f473mr144691995e9.2.1715893824689;
        Thu, 16 May 2024 14:10:24 -0700 (PDT)
Received: from [192.168.1.58] (186.28.45.217.dyn.plus.net. [217.45.28.186])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccbe8e3csm283039525e9.1.2024.05.16.14.10.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 May 2024 14:10:24 -0700 (PDT)
Message-ID: <84d8b645-d756-4a07-9062-cece62fcfd50@gmail.com>
Date: Thu, 16 May 2024 22:10:23 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] Revert "r8169: don't try to disable interrupts if
 NAPI is, scheduled already"
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Heiner Kallweit <hkallweit1@gmail.com>
Cc: Realtek linux nic maintainers <nic_swsd@realtek.com>
References: <9b5b6f4c-4f54-4b90-b0b3-8d8023c2e780@gmail.com>
Content-Language: en-GB
From: Ken Milmore <ken.milmore@gmail.com>
In-Reply-To: <9b5b6f4c-4f54-4b90-b0b3-8d8023c2e780@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/05/2024 07:18, Heiner Kallweit wrote:
> This reverts commit 7274c4147afbf46f45b8501edbdad6da8cd013b9.
> 
> Ken reported that RTL8125b can lock up if gro_flush_timeout has the
> default value of 20000 and napi_defer_hard_irqs is set to 0.
> In this scenario device interrupts aren't disabled, what seems to
> trigger some silicon bug under heavy load. I was able to reproduce this
> behavior on RTL8168h. Fix this by reverting 7274c4147afb.
> 
> Fixes: 7274c4147afb ("r8169: don't try to disable interrupts if NAPI is scheduled already")
> Cc: stable@vger.kernel.org
> Reported-by: Ken Milmore <ken.milmore@gmail.com>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/net/ethernet/realtek/r8169_main.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index 0fc5fe564ae5..69606c8081a3 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -4655,10 +4655,8 @@ static irqreturn_t rtl8169_interrupt(int irq, void *dev_instance)
>  		rtl_schedule_task(tp, RTL_FLAG_TASK_RESET_PENDING);
>  	}
>  
> -	if (napi_schedule_prep(&tp->napi)) {
> -		rtl_irq_disable(tp);
> -		__napi_schedule(&tp->napi);
> -	}
> +	rtl_irq_disable(tp);
> +	napi_schedule(&tp->napi);
>  out:
>  	rtl_ack_events(tp, status);
>  

FYI, by now I am reasonably well convinced that the behaviour we've been seeing
is not in fact a silicon bug, but rather a very specific behaviour regarding how
these devices raise MSI interrupts.

This is largely due to the investigations by David Dillow described exhaustively
in the 2009 netdev thread linked below. I wish I had spotted this much sooner!
This information has been corroborated by my own testing on the RTL8125b:
https://lore.kernel.org/netdev/1242001754.4093.12.camel@obelisk.thedillows.org/T/

To summarise precisely what I think the behaviour is:

********
An interrupt is generated *only* when the device registers undergo a transition
from (status & mask) == 0 to (status & mask) != 0.
********

If the above holds, then calling rtl_irq_disable() will immediately force the
condition (status & mask) == 0, so we are ready to raise another interrupt when
interrupts are subsequently enabled again. 

To try and verify this, I tried the code below, which locks up the network
traffic immediately, regardless of the setting of napi_defer_hard_irqs:

diff --git linux-source-6.1~/drivers/net/ethernet/realtek/r8169_main.c linux-source-6.1/drivers/net/ethernet/realtek/r8169_main.c
index 2ce4bff..add5bdd 100644
--- linux-source-6.1~/drivers/net/ethernet/realtek/r8169_main.c
+++ linux-source-6.1/drivers/net/ethernet/realtek/r8169_main.c
@@ -4607,10 +4607,13 @@ static irqreturn_t rtl8169_interrupt(int irq, void *dev_instance)
 		rtl_schedule_task(tp, RTL_FLAG_TASK_RESET_PENDING);
 	}
 
-	rtl_irq_disable(tp);
 	napi_schedule(&tp->napi);
 out:
+	u32 status2 = rtl_get_events(tp);
 	rtl_ack_events(tp, status);
+	if(status2 & ~status)
+		printk_ratelimited("rtl8169_interrupt: status=%x status2=%x\n",
+				   status, status2);
 
 	return IRQ_HANDLED;
 }

Here's some typical dmesg output:

[11315.581136] rtl8169_interrupt: status=1 status2=85
[11324.142176] r8169 0000:07:00.0 eth0: ASPM disabled on Tx timeout
[11324.151765] rtl8169_interrupt: status=4 status2=84

We can see that when a new interrupt is flagged in the interval between reading
the status register and writing to it, we may never achieve the condition
(status & mask) == 0.

So, if we read 0x01 (RxOK) from the status register, we will then write
0x01 back to acknowledge the interrupt. But in the meantime, 0x04 (TxOK) has
been flagged, as well as 0x80 (TxDescUnavail), so the register now contains
0x85. We acknowledge by writing back 0x01, so the status register should now
contain 0x84. If interrupts are unmasked throughout, then (status & mask) != 0
throughout, so no interrupt will be raised for the missed TxOK event, unless
something else should occur to set one of the other status bits.

To test this hypothesis, I tried the code below, which never disables
interrupts but instead clears out the status register on every interrupt:

index 2ce4bff..dbda9ef 100644
--- linux-source-6.1~/drivers/net/ethernet/realtek/r8169_main.c
+++ linux-source-6.1/drivers/net/ethernet/realtek/r8169_main.c
@@ -4610,7 +4610,7 @@ static irqreturn_t rtl8169_interrupt(int irq, void *dev_instance)
 	rtl_irq_disable(tp);
 	napi_schedule(&tp->napi);
 out:
-	rtl_ack_events(tp, status);
+	rtl_ack_events(tp, tp->irq_mask);
 
 	return IRQ_HANDLED;
 }

This passed my iperf3 test perfectly! It is likely to cause other problems
though: Specifically it opens the possibility that we will miss a SYSErr,
LinkChg or RxFIFOOver interrupt. Hence the rationale for achieving the required
(status & mask) == 0 condition by clearing the mask register instead.

I hope this information may prove useful in the future.

