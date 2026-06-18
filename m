Return-Path: <netdev+bounces-300477-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AjvxHHQQNGpKNAYAu9opvQ
	(envelope-from <netdev+bounces-300477-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 17:36:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C8AD06A1470
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 17:36:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=MlPWB7KP;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300477-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300477-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C9251302416F
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 15:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 742A13321DE;
	Thu, 18 Jun 2026 15:34:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28CC32B128
	for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 15:34:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781796894; cv=none; b=htpOcxauH4MPhmLz6VbBhbnGcqGkfFM3rJ4l9hR48aC/TUjX7AaSJEARAZ+3IqLsfK2e9X87WQeHXKp5PmeUe0sBFmcn4SEU3JPt3vacxA6Vr/GvNEnbi2pgpDV6NMiGxjOTGdPi24EX3ICU+XUyshLDizbKoeva9UDBslH9mZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781796894; c=relaxed/simple;
	bh=66h1cozuW7WJSgfW3nPNiBwBY/hmH341lOk4v+9okMg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oavbFRcTJkRmCwGF5MrQP/EpqWn9kpNmTz2wQYo8oZ14lyeh8KEcTk2U8hvQZFH6RPe4l5HTOZMJP4GHU8OX2rAaN0UWJz1T6UAYWW52GR4QBA/568UFm0WmGjrvXcJwcCNEhOgINDajnx6MZNjjWKWebSNd0PpVpN10JtasXbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=MlPWB7KP; arc=none smtp.client-ip=185.246.85.4
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id E2F794E42FAD;
	Thu, 18 Jun 2026 15:34:49 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B65375FF03;
	Thu, 18 Jun 2026 15:34:49 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 34D59106C8189;
	Thu, 18 Jun 2026 17:34:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1781796889; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=sC0bVctGQ7Xf2COYa7bvdpaGebxcOTkkJazq/uVZyy4=;
	b=MlPWB7KPi/790B5LQTdeAp/AkFLOR4X2+LpjQXWzXavAyeVBBCnT0BAFFtDCi8zJdJ3U3R
	jUejE/EYVXB/RLA8Ml72Jd1MT/q+uwDXdMXypg3QvTRE3pxAb2CjY18AXPJcl3qiieZlsm
	YHX10Dr9VH55KoB7jDj1NWv++EZSKqrbzLrKkpBrrNXq+nbEYkcvXxCDVKWwirOYo2nuXA
	mRYrnOomSew3faYOLdvux9jxp0KHB2epS+exzGGJ+n2xejEl0jGDpncHr4QMXJlftMxrdD
	R/4/zWaKhRzH3eY7CvN0hBEAirwO3EvnD86PlZ7dLy4qM17Piysx9gU9MF1E+A==
Message-ID: <df2a8c16-7b84-43ba-88f4-3b99e792376b@bootlin.com>
Date: Thu, 18 Jun 2026 17:34:42 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] net: mvneta: re-enable percpu interrupt on resume
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 "Zhou, Yun" <yun.zhou@windriver.com>
Cc: marcin.s.wojtas@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260618104351.3456161-1-yun.zhou@windriver.com>
 <20260618125128.h5g-StPH@linutronix.de>
 <06d0158e-bf4c-4ad1-8ad3-c8176003ab11@windriver.com>
 <20260618150440.cLDwgyDM@linutronix.de>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260618150440.cLDwgyDM@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-300477-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bigeasy@linutronix.de,m:yun.zhou@windriver.com,m:marcin.s.wojtas@gmail.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:marcinswojtas@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,bootlin.com:dkim,bootlin.com:mid,bootlin.com:url,bootlin.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C8AD06A1470

Hi,

On 6/18/26 17:04, Sebastian Andrzej Siewior wrote:
> On 2026-06-18 21:56:12 [+0800], Zhou, Yun wrote:
>>
>>> But if the thread is idle then you have one enable too many, don't you?
>>> Well you have the NAPI callback which does disable on the local CPU and
>>> this resume which enables it on every CPU. So this does not look right.
>>>
>>
>> The enable in resume is intentionally unconditional and idempotent
>> (writing MPIC_INT_CLEAR_MASK on an already unmasked IRQ is a no-op).
>>
>>> The interesting question is what happens to the enable_percpu_irq() from
>>> the mvneta_poll(). Is it lost? And if so, how/ why?
>>>
>>
>> The enable_percpu_irq() from mvneta_poll is not "lost" — it never
>> gets a chance to execute. The sequence is:
>>
>> 1. mvneta_percpu_isr: disable_percpu_irq() + napi_schedule()
>> 2. PM freezes kthreads (on PREEMPT_RT, softirq runs in kthread)
> 
> But napi_schedule() runs in ksoftird, doesn't it? The per-CPU IRQs are
> not threaded. That does not look optimal.
> 
>> 3. NAPI poll cannot run → enable_percpu_irq() is never called
>> 4. mvneta_stop_dev → napi_disable(): cancels the scheduled poll
>>     but does NOT execute the completion path (no enable_percpu_irq)
> 
> napi_schedule() sets NAPIF_STATE_SCHED.
> napi_disable() sets NAPI_STATE_DISABLE and waits until NAPIF_STATE_SCHED
> is cleared. So if NAPIF_STATE_SCHED was set then enable_percpu_irq()
> will be invoked unless it leaves somewhere early.
> However, if DISABLED was already set then it disables the IRQ source but
> does not schedule NAPI. This is probably what happens.
> 
>> 5. Resume → napi_enable(): resets NAPI state but MPIC stays masked
>>
>> The unconditional enable in resume covers this case. When NAPI was
>> idle at suspend time, the extra enable is harmless.
> 
> There is no desc::depth counting here, that got me confused. But that
> per-CPU irq is not optimal. Is this a SoC limitation or a design choice?

I _think_ that on mvneta, the mapping is done by assigning queues to CPUs
directly, and then you have per-cpu register banks to handle the interrupts :

https://elixir.bootlin.com/linux/v7.1/source/drivers/net/ethernet/marvell/mvneta.c#L138

This seems to be confirmed by some comments here [1] :

static void mvneta_percpu_mask_interrupt(void *arg)
{
	struct mvneta_port *pp = arg;

	/* All the queue are masked, but actually only the ones
	 * mapped to this CPU will be masked
	 */
	mvreg_write(pp, MVNETA_INTR_NEW_MASK, 0);
	mvreg_write(pp, MVNETA_INTR_OLD_MASK, 0);
	mvreg_write(pp, MVNETA_INTR_MISC_MASK, 0);
}

These registers will control different queue's interrupt behaviour depending
on which CPU executes that code...

[1] : https://elixir.bootlin.com/linux/v7.1/source/drivers/net/ethernet/marvell/mvneta.c#L1441

This may be why the design ended-up that way. I'm not saying this is ideal
though :)

The percpu interrupt mechanism isn't used on armada 3700 (hence all the special
conditions) because IIRC the interrupt routing is flawed for the network part, and
all interrupts end-up on CPU0 anyways...

Maxime


