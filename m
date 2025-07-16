Return-Path: <netdev+bounces-207571-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31D7BB07E47
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 21:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CA77160F5E
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 19:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF5A1D63C7;
	Wed, 16 Jul 2025 19:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JE2kUPjz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C45218858;
	Wed, 16 Jul 2025 19:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752695049; cv=none; b=gUvQ7QYBn3X1TG6Y7HcFAuT+Dpzfn85KiOP4hFbb6sPAOms9oRFL+pLyzSeQkJxqq6+V8iKYPuba3XtJs/2v0qL95ziF8cCbFREYXZLJf4bFVQcOqXjaD3ibzhVG2QOZYIRBsYd7ilYMNug7jBmGS7HRh4ZAk8rKafBwmGLPywU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752695049; c=relaxed/simple;
	bh=/VnGrfVARweMdrKBvQRe10ytz1StrdjfupJlLPy/m8k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OV5YJc3KUo59Yb5cKp6S2cEkknf1WVkPwtdf6LuBPpwHuZKV/ku1cC31vJHE0ds7xviJYMwmroiQkcUcnra4A7grt5u7y0UidqZTGnPtSFNqvnBprQPT9o71z7ifA4yKKM/hwxpZ3+0KbgvpIocNlaRKyL71nySMrBuIFqQKElU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JE2kUPjz; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-40a4bf1eb0dso173499b6e.3;
        Wed, 16 Jul 2025 12:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752695046; x=1753299846; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+RJb3K1usff7Zb3trCkpJkm8uKCGrOCVfGuf5HpRnA8=;
        b=JE2kUPjzwBgcfbEC0Wla7a2LL+9wMWRopm6ZozZ71+g+fVj6r3LCEpBYd/rQqP3lE6
         FHP1CeEd0U939jDyLagnw2yuR+KgO1JR3m3cAopoWELNMlHcpiRtCSr9ZFuKKUjVyAql
         Sv9HYbCi1hfCfTShtwxHfeYk/nPLni4MfF5KIbki0tBA7SJmCXM2NvR4U2eZtb17hhC4
         YEsZDEX6pKuJLBhrXvV/q9LNVM42UYP8GB+ztZGjeRY5qU49QeOAoINv/3itNhmQAE7Z
         4BG7DQmCwtRX1jH9lA1QKLhWU72rJR9C+cQRO04ijE5loESmmfbBM38PuseaSLpYcSDl
         na3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752695046; x=1753299846;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+RJb3K1usff7Zb3trCkpJkm8uKCGrOCVfGuf5HpRnA8=;
        b=LlRujuh776Q/ZHyS+3dRApLqN8feMxo5DUdgQ4H9i281rO9fBkoDROw4lkbaqZDndK
         KB+wq/UQPCiTvv/fIZViF4KSMcFd18ZYImrivEu7tPfX18wvlFAI0hDD5Dg1JgCAHjAZ
         7U+ocgsKiMHeZhhDe8nEXCqb6w9C43Qy9j7oLDIE1gfgPuqvikHqYCGs/pp2klkO+dsN
         NusgzmXBE7SpXuL8VgbMkX5HFZUXdphjseMrCfWhFe24DLKvpitsG3p2vHfru7/zpKL1
         Yeh77gIpi9DTrHzLCLZCqzhjJZLCJ1HzG/8O96n3r5MKXc0rOxhhMFKSHAKE+AbvG+po
         JSug==
X-Forwarded-Encrypted: i=1; AJvYcCXUABcsIP5MXXqG8ms6aeQcI2Hk0OxrgT9Pq7Y4y2+KnVuLR3M2yjqqI7F7omPxaWAi0yHlPj7V@vger.kernel.org, AJvYcCXxkE8plnduBXwqjR5YTu3u7D2vNwR16AD4f1nlGdIA7QTQpIhnLJOdA2MMKdqpPHY0YCHuqF7Yt741WSI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv7Q8JtoJLZksYLCsLZwGdj+DUY9CxtxpWgF4IouLC5W/UUKbr
	d0esEcFLAJB+mzNdw08xxAYUudMb9yXbKdlJGnDTT880Lhl/c4TeNukB
X-Gm-Gg: ASbGncsoafGRPPXjZfeO2SP2SmyFN35muOP2QvBdQfhC0XzjSmZm1GpgGLKXOYKNUbZ
	v7oBT64guhk3QaHDUNsQ7YRIVqnhnpf3zbJX84NEUI05zKqO9Z2VHMyOz3Thtkj5l1DNQmvmxwr
	sushX1/wCZLM60Atz3VdWg0Cjx9F7TFDEkLBNJH3sxspXdyGsfHe5tcIGiJrjjMS/AVTKM50R0H
	+DFKj+f4+Wfl/+qnwdDo0kSMau10alCMF3lBkWGhzMQAYib6wr44XjUcoN0QqDFdS7hm7sr485N
	46lm4RgPYWGYY5RqSiWXTnhWPXUtNEi6ongP3Tojc06CHufLrK2yz3GMFVHh+NMf7sENrVkl9+a
	KHm5Xd341qEG17tPNVDdy4jY6On/qz+D1FnQZ5dvFrwfgiEH2fVOW6jzhArd3a2NPU0iEwD5AUu
	Ty2Y/ezlP8Zg==
X-Google-Smtp-Source: AGHT+IH7rPU8CPdva5tScZ7spJLADHZI41f7z47LZOz8ijsXYyYSHLF00e7tnDZE6SDaj5d09jFo0Q==
X-Received: by 2002:a05:6808:189f:b0:408:fbed:c39f with SMTP id 5614622812f47-41d0526cad4mr2996628b6e.26.1752695046312;
        Wed, 16 Jul 2025 12:44:06 -0700 (PDT)
Received: from ?IPV6:2603:8080:7400:36da:ada3:14fa:a3ad:9ccf? ([2603:8080:7400:36da:ada3:14fa:a3ad:9ccf])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4141c78838asm2986824b6e.46.2025.07.16.12.44.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 12:44:05 -0700 (PDT)
Message-ID: <c1cf6883-a323-40e8-881d-ae7023bbc61a@gmail.com>
Date: Wed, 16 Jul 2025 14:44:04 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bonding: Switch periodic LACPDU state machine from
 counter to jiffies
To: Jay Vosburgh <jv@jvosburgh.net>, Carlos Bilbao <bilbao@vt.edu>
Cc: carlos.bilbao@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, sforshee@kernel.org
References: <20250715205733.50911-1-carlos.bilbao@kernel.org>
 <c9eac8f6-8e7f-4ed0-b34d-5dc50be8078f@vt.edu> <798952.1752679803@famine>
Content-Language: en-US
From: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
In-Reply-To: <798952.1752679803@famine>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello Jay,

On 7/16/25 10:30, Jay Vosburgh wrote:
> Carlos Bilbao <bilbao@vt.edu> wrote:
>
>> FYI, I was able to test this locally but couldn’t find any kselftests to
>> stress the bonding state machine. If anyone knows of additional ways to
>> test it, I’d be happy to run them.
> 	Your commit message says this change will "help reduce drift
> under contention," but above you say you're unable to stress the state
> machine.
>
> 	How do you induce "drift under contention" to test that your
> patch actually improves something?  What testing has been done to insure
> that the new code doesn't change the behavior in other ways (regressions)?


I tested the bonding driver with and without CPU contention*. With this
patch, the LACPDU state machine is much more consistent under load, with
standard deviation of 0.0065 secs between packets. In comparison, the
current version had a standard deviation of 0.15 secs (~x23 more
variability). I imagine this gets worsens with greater contention.

When I mentioned a possible kselftest (or similar) to "stress" the state
machine, I meant whether there's already any testing that checks the
state machine through different transitions -- e.g., scenarios where the
switch instruct the bond to change configs (for example, between fast and
slow LACP modes), resetting the bond under certain conditions, etc. I just
want to be exhaustive because as you mentioned the state machine has been
around for long time.

*System was stressed using:

stress-ng --cpu $(nproc) --timeout 60

Metrics were collected with:

sudo tcpdump -e -ni <my interface> ether proto 0x8809 and ether src <mac>


>
> 	Without a specific reproducable bug scenario that this change
> fixes, I'm leery of applying such a refactor to code that has seemingly
> been working fine for 20+ years.
>
> 	I gather that what this is intending to do is reduce the current
> dependency on the scheduling accuracy of the workqueue event that runs
> the state machines.  The current implementation works on a "number of
> invocations" basis, assuming that the event is invoked every 100 msec,
> and computes various timeouts based on the number of times the state


Yep.


> machine runs.
>
> 	-J
>
>> Thanks!
>>
>> Carlos
>>
>> On 7/15/25 15:57, carlos.bilbao@kernel.org wrote:
>>> From: Carlos Bilbao <carlos.bilbao@kernel.org>
>>>
>>> Replace the bonding periodic state machine for LACPDU transmission of
>>> function ad_periodic_machine() with a jiffies-based mechanism, which is
>>> more accurate and can help reduce drift under contention.
>>>
>>> Signed-off-by: Carlos Bilbao (DigitalOcean) <carlos.bilbao@kernel.org>
>>> ---
>>>    drivers/net/bonding/bond_3ad.c | 79 +++++++++++++---------------------
>>>    include/net/bond_3ad.h         |  2 +-
>>>    2 files changed, 32 insertions(+), 49 deletions(-)
>>>
>>> diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad.c
>>> index c6807e473ab7..8654a51266a3 100644
>>> --- a/drivers/net/bonding/bond_3ad.c
>>> +++ b/drivers/net/bonding/bond_3ad.c
>>> @@ -1421,44 +1421,24 @@ static void ad_periodic_machine(struct port *port, struct bond_params *bond_para
>>>    	    (!(port->actor_oper_port_state & LACP_STATE_LACP_ACTIVITY) && !(port->partner_oper.port_state & LACP_STATE_LACP_ACTIVITY)) ||
>>>    	    !bond_params->lacp_active) {
>>>    		port->sm_periodic_state = AD_NO_PERIODIC;
>>> -	}
>>> -	/* check if state machine should change state */
>>> -	else if (port->sm_periodic_timer_counter) {
>>> -		/* check if periodic state machine expired */
>>> -		if (!(--port->sm_periodic_timer_counter)) {
>>> -			/* if expired then do tx */
>>> -			port->sm_periodic_state = AD_PERIODIC_TX;
>>> -		} else {
>>> -			/* If not expired, check if there is some new timeout
>>> -			 * parameter from the partner state
>>> -			 */
>>> -			switch (port->sm_periodic_state) {
>>> -			case AD_FAST_PERIODIC:
>>> -				if (!(port->partner_oper.port_state
>>> -				      & LACP_STATE_LACP_TIMEOUT))
>>> -					port->sm_periodic_state = AD_SLOW_PERIODIC;
>>> -				break;
>>> -			case AD_SLOW_PERIODIC:
>>> -				if ((port->partner_oper.port_state & LACP_STATE_LACP_TIMEOUT)) {
>>> -					port->sm_periodic_timer_counter = 0;
>>> -					port->sm_periodic_state = AD_PERIODIC_TX;
>>> -				}
>>> -				break;
>>> -			default:
>>> -				break;
>>> -			}
>>> -		}
>>> +	} else if (port->sm_periodic_state == AD_NO_PERIODIC)
>>> +		port->sm_periodic_state = AD_FAST_PERIODIC;
>>> +	/* check if periodic state machine expired */
>>> +	else if (time_after_eq(jiffies, port->sm_periodic_next_jiffies)) {
>>> +		/* if expired then do tx */
>>> +		port->sm_periodic_state = AD_PERIODIC_TX;
>>>    	} else {
>>> +		/* If not expired, check if there is some new timeout
>>> +		 * parameter from the partner state
>>> +		 */
>>>    		switch (port->sm_periodic_state) {
>>> -		case AD_NO_PERIODIC:
>>> -			port->sm_periodic_state = AD_FAST_PERIODIC;
>>> -			break;
>>> -		case AD_PERIODIC_TX:
>>> -			if (!(port->partner_oper.port_state &
>>> -			    LACP_STATE_LACP_TIMEOUT))
>>> +		case AD_FAST_PERIODIC:
>>> +			if (!(port->partner_oper.port_state & LACP_STATE_LACP_TIMEOUT))
>>>    				port->sm_periodic_state = AD_SLOW_PERIODIC;
>>> -			else
>>> -				port->sm_periodic_state = AD_FAST_PERIODIC;
>>> +			break;
>>> +		case AD_SLOW_PERIODIC:
>>> +			if ((port->partner_oper.port_state & LACP_STATE_LACP_TIMEOUT))
>>> +				port->sm_periodic_state = AD_PERIODIC_TX;
>>>    			break;
>>>    		default:
>>>    			break;
>>> @@ -1471,21 +1451,24 @@ static void ad_periodic_machine(struct port *port, struct bond_params *bond_para
>>>    			  "Periodic Machine: Port=%d, Last State=%d, Curr State=%d\n",
>>>    			  port->actor_port_number, last_state,
>>>    			  port->sm_periodic_state);
>>> +
>>>    		switch (port->sm_periodic_state) {
>>> -		case AD_NO_PERIODIC:
>>> -			port->sm_periodic_timer_counter = 0;
>>> -			break;
>>> -		case AD_FAST_PERIODIC:
>>> -			/* decrement 1 tick we lost in the PERIODIC_TX cycle */
>>> -			port->sm_periodic_timer_counter = __ad_timer_to_ticks(AD_PERIODIC_TIMER, (u16)(AD_FAST_PERIODIC_TIME))-1;
>>> -			break;
>>> -		case AD_SLOW_PERIODIC:
>>> -			/* decrement 1 tick we lost in the PERIODIC_TX cycle */
>>> -			port->sm_periodic_timer_counter = __ad_timer_to_ticks(AD_PERIODIC_TIMER, (u16)(AD_SLOW_PERIODIC_TIME))-1;
>>> -			break;
>>>    		case AD_PERIODIC_TX:
>>>    			port->ntt = true;
>>> -			break;
>>> +			if (!(port->partner_oper.port_state &
>>> +						LACP_STATE_LACP_TIMEOUT))
>>> +				port->sm_periodic_state = AD_SLOW_PERIODIC;
>>> +			else
>>> +				port->sm_periodic_state = AD_FAST_PERIODIC;
>>> +		fallthrough;
>>> +		case AD_SLOW_PERIODIC:
>>> +		case AD_FAST_PERIODIC:
>>> +			if (port->sm_periodic_state == AD_SLOW_PERIODIC)
>>> +				port->sm_periodic_next_jiffies = jiffies
>>> +					+ HZ * AD_SLOW_PERIODIC_TIME;
>>> +			else /* AD_FAST_PERIODIC */
>>> +				port->sm_periodic_next_jiffies = jiffies
>>> +					+ HZ * AD_FAST_PERIODIC_TIME;
>>>    		default:
>>>    			break;
>>>    		}
>>> @@ -1987,7 +1970,7 @@ static void ad_initialize_port(struct port *port, int lacp_fast)
>>>    		port->sm_rx_state = 0;
>>>    		port->sm_rx_timer_counter = 0;
>>>    		port->sm_periodic_state = 0;
>>> -		port->sm_periodic_timer_counter = 0;
>>> +		port->sm_periodic_next_jiffies = 0;
>>>    		port->sm_mux_state = 0;
>>>    		port->sm_mux_timer_counter = 0;
>>>    		port->sm_tx_state = 0;
>>> diff --git a/include/net/bond_3ad.h b/include/net/bond_3ad.h
>>> index 2053cd8e788a..aabb8c97caf4 100644
>>> --- a/include/net/bond_3ad.h
>>> +++ b/include/net/bond_3ad.h
>>> @@ -227,7 +227,7 @@ typedef struct port {
>>>    	rx_states_t sm_rx_state;	/* state machine rx state */
>>>    	u16 sm_rx_timer_counter;	/* state machine rx timer counter */
>>>    	periodic_states_t sm_periodic_state;	/* state machine periodic state */
>>> -	u16 sm_periodic_timer_counter;	/* state machine periodic timer counter */
>>> +	unsigned long sm_periodic_next_jiffies;	/* state machine periodic next expected sent */
>>>    	mux_states_t sm_mux_state;	/* state machine mux state */
>>>    	u16 sm_mux_timer_counter;	/* state machine mux timer counter */
>>>    	tx_states_t sm_tx_state;	/* state machine tx state */
> ---
> 	-Jay Vosburgh, jv@jvosburgh.net
>

Thanks,

Carlos


