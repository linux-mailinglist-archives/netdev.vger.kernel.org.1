Return-Path: <netdev+bounces-95823-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF868C38F3
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 00:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D9D61C20C0E
	for <lists+netdev@lfdr.de>; Sun, 12 May 2024 22:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD5855476B;
	Sun, 12 May 2024 22:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D5d3ReUM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF75542A8B
	for <netdev@vger.kernel.org>; Sun, 12 May 2024 22:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715551685; cv=none; b=lZkWNiYtBQRyymGLL/+q9Q/e8gR0x1FunFVaQsjMXBBmsfapq0GQ2tVbT/e8oU8W8136tE3DuoWgZyj/ip+SvvockR3zhGM8DeHPaG00JT4Upo7sNbTEpN54tQb9OHu0P/z7r3HxmJZep7oCKqhEReD3tqZkh9J5Qp/khshfdzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715551685; c=relaxed/simple;
	bh=3MvlUBbCERYKPZujJQleb/hg7pEbAyL6upQ08fDpIqw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J/YcPU/oL1ihW5+738e+q95HYkIA5JFXzSJtf2vTwFZnY1fbpBc5N7o5tpfA54l2BfvE7ZAWL80ogeW0Z3BobwkvQqkDiNhxZ/1nuijDUtRDxj/LIMZh0+l8Q7vai9o1wxzthpPLDYoipBOhUdVS496/EXkwM3tl5ud9WRWGsx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D5d3ReUM; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a59ad12efe3so415216466b.3
        for <netdev@vger.kernel.org>; Sun, 12 May 2024 15:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715551682; x=1716156482; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LqeDsLW2D7aXO8cAk0OR+9yRjz9z35g5Pyw5R4GtSOk=;
        b=D5d3ReUMMzzKryhScbjzT5IvI4IxUHbzHoheESDHd0V4AL/kqMPXKh0WuuOJTbzmwD
         OglN5iZlajSkVL6K8dos6umgNu4fMMCU2Dr1zMW2tAiOIFRB2yVz247VOUtkjTJZBNF2
         ZvyGuu5SvdK49x6tAp9uKzddU6V7EQKRgi3SdlOib4fSOUbc4HST6mKbDxGX6oh4ohUX
         SkapsFxX2z7uPuBRCYOLnXTCzoFjWVbbTqtpUOth1y5awSTQ724vzWfphRNuz5qORdZH
         j4GcuoN3uZajwWffeJWh6kKLTqh9wOO+NaJESjK3Se3RQ4ZGL4ZcI/QP/cpZPcaEsP32
         HlyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715551682; x=1716156482;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LqeDsLW2D7aXO8cAk0OR+9yRjz9z35g5Pyw5R4GtSOk=;
        b=L5HR3Uan7IM2kl/QBKNV7Qh77VhVz2Ingli+hFGgiFgsgvRPT7WawyzCegRylT8OzJ
         ATTmP93BFcUPXSN6gpUe40psiF9/yMT1WPkLPqXNAJXTShFSbBTUYislhOrYRu8NXay5
         ux23IsC4hipDrwgEo7hVtSleQn3sFydbG9j4UD7N097TsvyhIYkIiTS6vM3UelSr3+Ut
         gImHJEweoVjUGI1oRxhBjHq9Pkksp2WnAsXvEEJS/Xh8YQ40UVK6I3tvW9sA89hSsX4L
         ZfUHZmM37eXh6TMawOncUNvAFlV8thoy4EJ3qoV1+5GGvg0rK7t0/mIUWsuZYFPPgGZs
         iKzg==
X-Forwarded-Encrypted: i=1; AJvYcCWp4VLBTKP/wAbJi1Ep1Iw3GO28ym5GA54Na2nY7KkxyZIeLTd5acKWLonpXukYCnvoeMYS31mjbjDpRaq66X89h+wf+YY6
X-Gm-Message-State: AOJu0Yw5IaGUoH9cTtIK1A598hK4kHniipUUsNP51N8r2uaQn5o+DNAN
	lSQFMyq5KUYpHG9AZS6haUPiv0WMtMqL4r2UreSfDGRfZcZYeRo9
X-Google-Smtp-Source: AGHT+IH0fVyGVF6cYgP87wB5uhiKX3JXZ2HJF3LdrLA2bthvxSHf1vKg90cbeD1EoRCFjjiOAzDQpg==
X-Received: by 2002:a50:8757:0:b0:572:47be:831d with SMTP id 4fb4d7f45d1cf-5734d5ce595mr7725239a12.20.1715551681896;
        Sun, 12 May 2024 15:08:01 -0700 (PDT)
Received: from ?IPV6:2a01:c22:7bdd:8a00:ad81:1135:9a6d:a23f? (dynamic-2a01-0c22-7bdd-8a00-ad81-1135-9a6d-a23f.c22.pool.telefonica.de. [2a01:c22:7bdd:8a00:ad81:1135:9a6d:a23f])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5733bebb6d5sm5222334a12.34.2024.05.12.15.08.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 May 2024 15:08:01 -0700 (PDT)
Message-ID: <35fa38fc-9d1e-4a22-86dd-a4c9147d7f70@gmail.com>
Date: Mon, 13 May 2024 00:08:01 +0200
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
 <940faa90-81db-40dc-8773-1720520b10ed@gmail.com>
 <c71a960f-16d3-41f0-9899-0040116b30ee@gmail.com>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <c71a960f-16d3-41f0-9899-0040116b30ee@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12.05.2024 21:49, Ken Milmore wrote:
> 
> 
> On 11/05/2024 17:31, Heiner Kallweit wrote:
>> On 11.05.2024 00:29, Ken Milmore wrote:
>>>
>>> Reading this worries me though:
>>>
>>> https://docs.kernel.org/networking/napi.html
>>> "napi_disable() and subsequent calls to the poll method only wait for the ownership of the instance to be released, not for the poll method to exit.
>>> This means that drivers should avoid accessing any data structures after calling napi_complete_done()."
>>>
>> According to kernel doc napi_disable() waits.
>>
>> /**
>>  *	napi_disable - prevent NAPI from scheduling
>>  *	@n: NAPI context
>>  *
>>  * Stop NAPI from being scheduled on this context.
>>  * Waits till any outstanding processing completes.
>>  */
>>
>>> Which seems to imply that the IRQ enable following napi_complete_done() is unguarded, and might race with the disable on an incoming poll.
>>> Is that a possibility?
>>
>> Same documents states in section "Scheduling and IRQ masking":
>> IRQ should only be unmasked after a successful call to napi_complete_done()
>> So I think we should be fine.
>>
> 
> Nevertheless, it would be good if we could get away without the flag.
> 
> I had started out with the assumption that an interrupt acknowledgement coinciding with some part of the work being done in rtl8169_poll() might be the cause of the problem.
> So it seemed natural to try guarding the whole block by disabling interrupts at the beginning.
> But this seems to work just as well:
> 
> diff --git linux-source-6.1~/drivers/net/ethernet/realtek/r8169_main.c linux-source-6.1/drivers/net/ethernet/realtek/r8169_main.c
> index 6e34177..353ce99 100644
> --- linux-source-6.1~/drivers/net/ethernet/realtek/r8169_main.c
> +++ linux-source-6.1/drivers/net/ethernet/realtek/r8169_main.c
> @@ -4659,8 +4659,10 @@ static int rtl8169_poll(struct napi_struct *napi, int budget)
>  
>  	work_done = rtl_rx(dev, tp, budget);
>  
> -	if (work_done < budget && napi_complete_done(napi, work_done))
> +	if (work_done < budget && napi_complete_done(napi, work_done)) {
> +		rtl_irq_disable(tp);
>  		rtl_irq_enable(tp);
> +	}
>  
>  	return work_done;
>  }
> 
> On this basis, I assume the problem may actually involve some subtlety with the behaviour of the interrupt mask and status registers.
> 
In the register dump in your original report the interrupt mask is set.
So it seems rtl_irq_enable() was executed. I don't have an explanation
why a previous rtl_irq_disable() makes a difference.
Interesting would be whether it has to be a write to the interrupt mask
register, or whether a write to any register is sufficient.

> In addition, I'm not sure it is such a good idea to do away with disabling interrupts from within rtl8169_interrupt().
> This causes a modest, but noticeable increase in IRQ rate which I measured at around 3 to 7%, depending on whether the load is Tx or Rx heavy and also on the setting of gro_flush_timeout and napi_defer_hard_irqs.
> 
> e.g.
> Tx only test with iperf3, gro_flush_timeout=20000, napi_defer_hard_irqs=1:
> Averaged 32343 vs 30165 interrupts per second, an increase of about 7%.
> 
> Bidirectional test with with gro_flush_timeout=0, napi_defer_hard_irqs=0:
> Averaged 82118 vs 79689 interrupts per second, an increase of about 3%.
> 
> Given that these NICs are already fairly heavy on interrupt rate, it seems a shame to make them even worse!
> 
> All in all I preferred the solution where we do all the interrupt disabling in rtl8169_interrupt(), notwithstanding that it may require a change to the interface of napi_schedule_prep().

I agree.


