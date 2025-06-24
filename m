Return-Path: <netdev+bounces-200864-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F949AE7244
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 00:27:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C24931778EF
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 22:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07AAD258CD4;
	Tue, 24 Jun 2025 22:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SBF5i25Q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A7D3074AE;
	Tue, 24 Jun 2025 22:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750804069; cv=none; b=kcxlYWXlSX86KGLCQflH/0tXzx8LtQbk62qNWxJEHKPtaaX3ZMqRIuVNZGcwd3dGKxnJYtjcpADZdP2Oh9QhuxjOXOpjjcJ84qd4bEU6tGrAt4b5P4ZjFm00X4bDDf2g8RdWkhL0ex7yBplVxqN6CqvyKP612nQJ6FaGl6CVWVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750804069; c=relaxed/simple;
	bh=rsRf0PL3ZLH8Xx67Ag9+WLpe57IaIhoPEstUpn0XNTU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JHT3UdFjdZRrVhiPEZmQeyPIdLIpG/7jl2TzgbYqN7Pt8wfX3rM70pOY0ssIjOcMcBsie6f2qDWJVaq030RTr0aPY3/SRsNxNE5xv+6hkJTXc/zmCpfQ7FOGhJCqTP4UiCn8ivO45GMmS2JBZhuHeFdJVLRW/y6MmgOVihaeOeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SBF5i25Q; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-73adf1a0c48so4459a34.2;
        Tue, 24 Jun 2025 15:27:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750804067; x=1751408867; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2VBUICZhzOBKJv0I6KyYxiOnFlvXxpDoLRw1ihnDV+E=;
        b=SBF5i25Qpa/WeWsMYk9+CV9H7e9eJdMNMWZOviqnikel7aaB6asjytc6m9IP9NMFbE
         Q+QwlW3x7t4E+j9cCGl1ptBX5HoaxvrQhtX5kwIxR7SRyslA+cK0VP2jLzqE5rdVrj1g
         RFZKlTGx7saHJ+YzsTpcJ0Vp7ofbF/kW7EwCd3I4jHdsdxNuC/60MBTQuWMB7EUQY5iD
         RX9/Rq51q/AtMlBAdChEprNr8awmqedneg8bqYgPsTjx+DQun5tutTs7jkMTZTNBmIPN
         I6XFHm9tofQSiNCgof9MVFC0VmVsbWVGCXn0JEcoCjxub1epErxyVwKCA0geNRrT35GE
         HGYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750804067; x=1751408867;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2VBUICZhzOBKJv0I6KyYxiOnFlvXxpDoLRw1ihnDV+E=;
        b=QR7w65o84+UU2L0fIVeFC5ajMSaPPR3ZaETZ23GAP8kJcmqC6ZeiRt/a1/9KW0trUT
         4C5gOQ1ZBLPf576vkwwVmcqXHCwfuADXrA9+cC33EhttX7sN9c6vYbf+C36kP20jGIkJ
         Ndb+Z82upvLhuVWZ+G2ZF6i1SAfFgbPA8UxXAac0DdvNvGj0v/f6rNma/MfHbOhfhaqE
         yOeQ59vQNe3d6PMJAsSoFGYb5gBvwvHqFn+I79a57gsz80MwzE/Qrhb1ae9T4/3cUxbB
         L/DLn/44p3aHnQpiuY6tXvU/pkKcnmDqunR1TpR8hkPuPar5QO6CWINWJ71yJxGur7cG
         sseA==
X-Forwarded-Encrypted: i=1; AJvYcCU5jsrybseHYYle1EGsmuRUS/nTi2tdvUushIJx4k3DPGBAQe2ENM5lI8WMEoRPC39UAOGrT82oWiY4Ucs=@vger.kernel.org, AJvYcCXU+DxEOLa/EjBY8GQEfOG0Lq+qMb53G3rGY317SXH21M0b6S+EdNA+O8FW/fReF1NoN+Fb3ioY@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9qscM2ArbSPyipq6jSY0wPwokOMLHUqotAFTEit341oBE63F6
	Y+xRRGJe5sthoG2PtxNye0Knwp652GWGi0l66VE914SjjDEcnb4v0heA
X-Gm-Gg: ASbGncvQR6JJx+Ui8wEh29WVSHwglrgG2nFHH+FbBUK8Q8bV9C11+MqPaURn6M7E0pA
	YqAhmytvxY+kFJlRJ3iMFU5pcgUcFm20jANWXiccYQKRfoLDiP3yEbopkSuQFA0SaNIerkQ10cg
	f48OqCD11db5UvL0wQibQCB9NPDacle8YrypyL0PuKc2zgBr9dt0UXLp0pU0ixobvgniR0O53hX
	EDfs3+9lL9rSQO+zWSoRarlREx/wRXZowkxzsI4pbe1CqQcb29rVGpEqq5LM1X3QV+t5817eoKm
	+sD7qnYrZQR6j/VMh1qMIvflY6T5/KMu11Bd3eZLZX6UfJXT8LhN2hYYj1stFqvvAnrrfqLwTkM
	wWRwLtTX5+T9scN7jLYntPgsoPWfOkRFKl+ypz9wDoOXoIpwX6A==
X-Google-Smtp-Source: AGHT+IHlXq99qMT+XBGv3ZycysESdOTzN9nSBBMp59mp0iD95SesODS3VFN8a/ClQ/r/3LXWqtZbig==
X-Received: by 2002:a05:6870:3920:b0:2d6:6688:a625 with SMTP id 586e51a60fabf-2efb246f165mr606263fac.37.1750804066984;
        Tue, 24 Jun 2025 15:27:46 -0700 (PDT)
Received: from ?IPV6:2603:8080:7400:36da:f36b:6513:fc98:48c4? ([2603:8080:7400:36da:f36b:6513:fc98:48c4])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73ac9d62473sm599304a34.54.2025.06.24.15.27.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jun 2025 15:27:46 -0700 (PDT)
Message-ID: <32313811-2215-41c3-852f-8e257487dfb6@gmail.com>
Date: Tue, 24 Jun 2025 17:27:45 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bonding: Improve the accuracy of LACPDU transmissions
To: Jay Vosburgh <jv@jvosburgh.net>, Tonghao Zhang <tonghao@bamaicloud.com>
Cc: carlos.bilbao@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, sforshee@kernel.org,
 bilbao@vt.edu
References: <20250618195309.368645-1-carlos.bilbao@kernel.org>
 <341249BC-4A2E-4C90-A960-BB07FAA9C092@bamaicloud.com>
 <2487616.1750799732@famine>
Content-Language: en-US
From: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
In-Reply-To: <2487616.1750799732@famine>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello both,

On 6/24/25 16:15, Jay Vosburgh wrote:
> Tonghao Zhang <tonghao@bamaicloud.com> wrote:
>
>>
>>
>>> 2025年6月19日 03:53，carlos.bilbao@kernel.org 写道：
>>>
>>> From: Carlos Bilbao <carlos.bilbao@kernel.org>
>>>
>>> Improve the timing accuracy of LACPDU transmissions in the bonding 802.3ad
>>> (LACP) driver. The current approach relies on a decrementing counter to
>>> limit the transmission rate. In our experience, this method is susceptible
>>> to delays (such as those caused by CPU contention or soft lockups) which
>>> can lead to accumulated drift in the LACPDU send interval. Over time, this
>>> drift can cause synchronization issues with the top-of-rack (ToR) switch
>>> managing the LAG, manifesting as lag map flapping. This in turn can trigger
>>> temporary interface removal and potential packet loss.
> 	So, you're saying that contention or soft lockups are causing
> the queue_delayed_work() of bond_3ad_state_machine_handler() to be
> scheduled late, and, then, because the LACPDU TX limiter is based on the
> number of state machine executions (which should be every 100ms), it is
> then late sending LACPDUs?
>
> 	If the core problem is that the state machine as a whole isn't
> running regularly, how is doing a clock-based time check reliable?  Or
> should I take the word "improve" from the Subject literally, and assume
> it's making things "better" but not "totally perfect"?
>
> 	Is the sync issue with the TOR due to missing / delayed LACPDUs,
> or is there more to it?  At the fast LACP rate, the periodic timeout is
> 3 seconds for a nominal 1 second LACPDU interval, which is fairly
> generous.
>
>>> This patch improves stability with a jiffies-based mechanism to track and
>>> enforce the minimum transmission interval; keeping track of when the next
>>> LACPDU should be sent.
>>>
>>> Suggested-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
>>> Signed-off-by: Carlos Bilbao (DigitalOcean) <carlos.bilbao@kernel.org>
>>> ---
>>> drivers/net/bonding/bond_3ad.c | 18 ++++++++----------
>>> include/net/bond_3ad.h         |  5 +----
>>> 2 files changed, 9 insertions(+), 14 deletions(-)
>>>
>>> diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad.c
>>> index c6807e473ab7..47610697e4e5 100644
>>> --- a/drivers/net/bonding/bond_3ad.c
>>> +++ b/drivers/net/bonding/bond_3ad.c
>>> @@ -1375,10 +1375,12 @@ static void ad_churn_machine(struct port *port)
>>>   */
>>> static void ad_tx_machine(struct port *port)
>>> {
>>> - /* check if tx timer expired, to verify that we do not send more than
>>> - * 3 packets per second
>>> - */
>>> - if (port->sm_tx_timer_counter && !(--port->sm_tx_timer_counter)) {
>>> + unsigned long now = jiffies;
>>> +
>>> + /* Check if enough time has passed since the last LACPDU sent */
>>> + if (time_after_eq(now, port->sm_tx_next_jiffies)) {
>>> + port->sm_tx_next_jiffies += ad_ticks_per_sec / AD_MAX_TX_IN_SECOND;
>>> +
>>> /* check if there is something to send */
>>> if (port->ntt && (port->sm_vars & AD_PORT_LACP_ENABLED)) {
>>> __update_lacpdu_from_port(port);
>>> @@ -1395,10 +1397,6 @@ static void ad_tx_machine(struct port *port)
>>> port->ntt = false;
>>> }
>>> }
>>> - /* restart tx timer(to verify that we will not exceed
>>> - * AD_MAX_TX_IN_SECOND
>>> - */
>>> - port->sm_tx_timer_counter = ad_ticks_per_sec/AD_MAX_TX_IN_SECOND;
>>> }
>>> }
>>>
>>> @@ -2199,9 +2197,9 @@ void bond_3ad_bind_slave(struct slave *slave)
>>> /* actor system is the bond's system */
>>> __ad_actor_update_port(port);
>>> /* tx timer(to verify that no more than MAX_TX_IN_SECOND
>>> - * lacpdu's are sent in one second)
>>> + * lacpdu's are sent in the configured interval (1 or 30 secs))
>>> */
>>> - port->sm_tx_timer_counter = ad_ticks_per_sec/AD_MAX_TX_IN_SECOND;
>>> + port->sm_tx_next_jiffies = jiffies + ad_ticks_per_sec / AD_MAX_TX_IN_SECOND;
>> If CONFIG_HZ is 1000, there is 1000 tick per second, but "ad_ticks_per_sec / AD_MAX_TX_IN_SECOND” == 10/3 == 3, so that means send lacp packets every 3 ticks ?
> 	Agreed, I think the math is off here.
>
> 	ad_ticks_per_sec is 10, it's the number of times the entire LACP
> state machine runs per second.  It is unrelated to jiffies, and can't be
> used directly with jiffy units (the duration of which varies depending
> on what CONFIG_HZ is).  I agree that it's confusingly similar to
> ad_delta_in_ticks, which is measured in jiffy units.
>
> 	You'll probably want to use msecs_to_jiffies() somewhere.


Thank you for taking the time to review my patch!

I agree, the math is off here and I plan to fix that in v2. It shouldn't
be:

port->sm_tx_next_jiffies = jiffies + ad_ticks_per_sec / AD_MAX_TX_IN_SECOND;
port->sm_tx_next_jiffies = jiffies + 3;

... instead, it should be:

port->sm_tx_next_jiffies = jiffies + HZ / AD_MAX_TX_IN_SECOND;

... which, assuming CONFIG_HZ is 1000, it would be:

port->sm_tx_next_jiffies = jiffies + 333;

This math also works in terms of the units too:

HZ = ticks / sec
AD_MAX_X_IN_SECOND = packets / sec

so:

(ticks / sec) / (packets /sec) = ticks / packet


>
> 	How did you test this to insure the TX machine doesn't overrun
> (i.e., exceed AD_MAX_TX_IN_SECOND LACPDU transmissions in one second)?
>
> 	-J
>
>>> __disable_port(port);
>>>
>>> diff --git a/include/net/bond_3ad.h b/include/net/bond_3ad.h
>>> index 2053cd8e788a..956d4cb45db1 100644
>>> --- a/include/net/bond_3ad.h
>>> +++ b/include/net/bond_3ad.h
>>> @@ -231,10 +231,7 @@ typedef struct port {
>>> mux_states_t sm_mux_state; /* state machine mux state */
>>> u16 sm_mux_timer_counter; /* state machine mux timer counter */
>>> tx_states_t sm_tx_state; /* state machine tx state */
>>> - u16 sm_tx_timer_counter; /* state machine tx timer counter
>>> - * (always on - enter to transmit
>>> - *  state 3 time per second)
>>> - */
>>> + unsigned long sm_tx_next_jiffies;/* expected jiffies for next LACPDU sent */
>>> u16 sm_churn_actor_timer_counter;
>>> u16 sm_churn_partner_timer_counter;
>>> u32 churn_actor_count;
>>> -- 
>>> 2.43.0
>>>
>>>
>>>
> ---
> 	-Jay Vosburgh, jv@jvosburgh.net
>

Thanks,

Carlos


