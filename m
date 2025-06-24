Return-Path: <netdev+bounces-200867-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62C30AE7251
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 00:33:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 445725A2793
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 22:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 417CD2586FE;
	Tue, 24 Jun 2025 22:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EtFlio7e"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C65C258CD4;
	Tue, 24 Jun 2025 22:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750804423; cv=none; b=J7n8nn2hnHlPfrO2AC9Iyt6MAKgczVYMJsHTl53XLhqrhDTQxftQ7aFtN4zIgiQymbw963XSL8yqrj2wQqufMhh0bCWlmMBg1mAX2G6e4aUmTnsGmCke5J4uZgOSzQ2FYLccrVfY/fe7a07TMsWdc7nN5LSEE6nUmUr5UxbkBEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750804423; c=relaxed/simple;
	bh=/DmYF2BciHt7EB8YLnW6/AL61cBPxEUMGFv4bYqsL/E=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=K75/0o6PunPk5FJlQBr/ak3HromBDBDUunRF98OOOa6ZxyfPQAVW5jQjtpcjxnbKQD0Edi6Gs8PmfmHyrbudm1q1fA/2lloyG+9MEVd9pp4I552vBoha0KVMfKE7brr1VIw+tpz16YlvtuRDQt8FHYD3ML5QZTKE7j2WJdk5KyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EtFlio7e; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-73a5c41a71aso597180a34.0;
        Tue, 24 Jun 2025 15:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750804420; x=1751409220; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yIJQWPyhbpn21c48R2P6HcFwdTMTp7D7RyUvH0r10/I=;
        b=EtFlio7eo22GIQQSwiKUcNwce70ggvKlOfpcw1P1e/NLK0isq9p2YMGW1imV4xvlrm
         2MRI0CO3DvMDMEL/OP7WNX6vWZRoz2OpUsE+HRs6HTrAqLdsLRLiCOHX8YcamSWy9s/T
         3kxUPHXkN3+xMEtCJ2Mj0zzZmUwkLCC58TIPj1XxGkqSgInM3FVaNyO1hHD5xoYnnoE0
         90W31OEMDxhtPlVeCzsdbBwS4pA3y9zLF5D3KueDwib+y0oWJxWP1D7iaPm01ISvmFJ4
         2D9jFwF6wXOXxgRWwOb1Pvl+lvfv98VkftCCbdiJK0eNMkFvP9r4sFVE7ogMtXU/Lp93
         h74Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750804420; x=1751409220;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yIJQWPyhbpn21c48R2P6HcFwdTMTp7D7RyUvH0r10/I=;
        b=lvxZ41gs1WCpoXmhRZb0eJ79U0mAbA1MRhQI1bUotFHeF2/Yb3SzkQ7zIGosmb6xxz
         IRhE2uzEwDSv6HVy8+tr4rGU5/qfqLmg3SwShZ3rpWIuvPzABGrPPfAtKEnVaX8DyQYU
         mAO/aWUm/rlpRqdQTWLvIB+ve+4TmRl6Nhv3xG74AihtSF86htF0TI0qNo2zj5+26k6E
         aJjHxoJoTlfNlcmFkyFRUQUFmXoric6H0SUxkuzIRk+EEd2Zm5VwvSbdx7B5b1087hEZ
         /wBJ7tZPLcuAY8O99jBqq5MBTeh2TM6wywgy9bTjE5M6YbgO8rEsKVJj/It/vkoT/+Xa
         WvGA==
X-Forwarded-Encrypted: i=1; AJvYcCVomPmoHwJQwfb9sypomMyiXPBa4dkKpOrZkEp0M4TIJF6tDieWIB2TSgqYAYhVOCllNdBqEOnH@vger.kernel.org, AJvYcCWFarCSGNRSLj12rFPgOYXMHEi8ietWQzCv3uYEttv1WVHj8iFKxnG+2EPVRPUupQnMeHGiY81rF0EarG4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbUa6YkUp+3kLCeqML+pXBnuKeRwREb0+mrBIIWVEsjz2nLIW7
	9ky3oFLiiG2nusaNG9/x1nbVfjkek+a0K7jYoHP4qo7aHUJaCZ9GgKnZ
X-Gm-Gg: ASbGncsBqxLvkPspMJ0wVnQhLau8LO1EjyzRIheTtXUMCO7N6jl3dBQrhPgXJauVFVM
	uHtqfz2kdWAM8bn+S4WmXMTBzhqAWNX2+BSR5JRtQk1mIEZNvqO+o+JNBszBLRemNUSSCO3gmTe
	cKIGKgVbrJxOOdUesiR4x4CU0Ex0FO5yxJ2dEJK3ObyKeBjmCXD+OrAdwUKPtBRSTotZnOjBRHB
	ZNT/hz3PAMwyLRoQ+I46npyGZ4osPXda3vnJs4Ay57Zz+9Dq2z89qY7D6qsFqdcUXq7/CDh3D7S
	QRMh7/DPVJ3/VmvTEFcRwMa3bFGclPk2+026HogawIVbsw97h7VFD0aEeXITtSSHO6A5ua+JPZx
	7435WWMycQfpclwbEAtq1ENblO2P/5E0fM1APEK8GYIHYtBByvQ==
X-Google-Smtp-Source: AGHT+IFuaJRe3iVbxPQwoRzc8SofGj1CS1U/L7vI+C+P5TVRo85HxCRvtPuQnTVUKB7u+1P7acOImA==
X-Received: by 2002:a05:6830:8209:b0:73a:90ee:53ea with SMTP id 46e09a7af769-73adc549343mr426786a34.9.1750804420295;
        Tue, 24 Jun 2025 15:33:40 -0700 (PDT)
Received: from ?IPV6:2603:8080:7400:36da:f36b:6513:fc98:48c4? ([2603:8080:7400:36da:f36b:6513:fc98:48c4])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73a90aee8ecsm2034738a34.10.2025.06.24.15.33.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jun 2025 15:33:39 -0700 (PDT)
Message-ID: <f34cec6a-67f4-444c-8807-5fbf3c4335b7@gmail.com>
Date: Tue, 24 Jun 2025 17:33:38 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bonding: Improve the accuracy of LACPDU transmissions
From: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
To: Jay Vosburgh <jv@jvosburgh.net>, Tonghao Zhang <tonghao@bamaicloud.com>
Cc: carlos.bilbao@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, sforshee@kernel.org,
 bilbao@vt.edu
References: <20250618195309.368645-1-carlos.bilbao@kernel.org>
 <341249BC-4A2E-4C90-A960-BB07FAA9C092@bamaicloud.com>
 <2487616.1750799732@famine> <32313811-2215-41c3-852f-8e257487dfb6@gmail.com>
Content-Language: en-US
In-Reply-To: <32313811-2215-41c3-852f-8e257487dfb6@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/24/25 17:27, Carlos Bilbao wrote:

> Hello both,
>
> On 6/24/25 16:15, Jay Vosburgh wrote:
>> Tonghao Zhang <tonghao@bamaicloud.com> wrote:
>>
>>>
>>>
>>>> 2025年6月19日 03:53，carlos.bilbao@kernel.org 写道：
>>>>
>>>> From: Carlos Bilbao <carlos.bilbao@kernel.org>
>>>>
>>>> Improve the timing accuracy of LACPDU transmissions in the bonding 
>>>> 802.3ad
>>>> (LACP) driver. The current approach relies on a decrementing 
>>>> counter to
>>>> limit the transmission rate. In our experience, this method is 
>>>> susceptible
>>>> to delays (such as those caused by CPU contention or soft lockups) 
>>>> which
>>>> can lead to accumulated drift in the LACPDU send interval. Over 
>>>> time, this
>>>> drift can cause synchronization issues with the top-of-rack (ToR) 
>>>> switch
>>>> managing the LAG, manifesting as lag map flapping. This in turn can 
>>>> trigger
>>>> temporary interface removal and potential packet loss.
>>     So, you're saying that contention or soft lockups are causing
>> the queue_delayed_work() of bond_3ad_state_machine_handler() to be
>> scheduled late, and, then, because the LACPDU TX limiter is based on the
>> number of state machine executions (which should be every 100ms), it is
>> then late sending LACPDUs?
>>
>>     If the core problem is that the state machine as a whole isn't
>> running regularly, how is doing a clock-based time check reliable?  Or
>> should I take the word "improve" from the Subject literally, and assume
>> it's making things "better" but not "totally perfect"?
>>
>>     Is the sync issue with the TOR due to missing / delayed LACPDUs,
>> or is there more to it?  At the fast LACP rate, the periodic timeout is
>> 3 seconds for a nominal 1 second LACPDU interval, which is fairly
>> generous.


Also, I didn’t ignore your comments -- I agree there’s a deeper issue at
the state machine level. I’m looking into it and will get back to y'all.


>>
>>>> This patch improves stability with a jiffies-based mechanism to 
>>>> track and
>>>> enforce the minimum transmission interval; keeping track of when 
>>>> the next
>>>> LACPDU should be sent.
>>>>
>>>> Suggested-by: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
>>>> Signed-off-by: Carlos Bilbao (DigitalOcean) <carlos.bilbao@kernel.org>
>>>> ---
>>>> drivers/net/bonding/bond_3ad.c | 18 ++++++++----------
>>>> include/net/bond_3ad.h         |  5 +----
>>>> 2 files changed, 9 insertions(+), 14 deletions(-)
>>>>
>>>> diff --git a/drivers/net/bonding/bond_3ad.c 
>>>> b/drivers/net/bonding/bond_3ad.c
>>>> index c6807e473ab7..47610697e4e5 100644
>>>> --- a/drivers/net/bonding/bond_3ad.c
>>>> +++ b/drivers/net/bonding/bond_3ad.c
>>>> @@ -1375,10 +1375,12 @@ static void ad_churn_machine(struct port 
>>>> *port)
>>>>   */
>>>> static void ad_tx_machine(struct port *port)
>>>> {
>>>> - /* check if tx timer expired, to verify that we do not send more 
>>>> than
>>>> - * 3 packets per second
>>>> - */
>>>> - if (port->sm_tx_timer_counter && !(--port->sm_tx_timer_counter)) {
>>>> + unsigned long now = jiffies;
>>>> +
>>>> + /* Check if enough time has passed since the last LACPDU sent */
>>>> + if (time_after_eq(now, port->sm_tx_next_jiffies)) {
>>>> + port->sm_tx_next_jiffies += ad_ticks_per_sec / AD_MAX_TX_IN_SECOND;
>>>> +
>>>> /* check if there is something to send */
>>>> if (port->ntt && (port->sm_vars & AD_PORT_LACP_ENABLED)) {
>>>> __update_lacpdu_from_port(port);
>>>> @@ -1395,10 +1397,6 @@ static void ad_tx_machine(struct port *port)
>>>> port->ntt = false;
>>>> }
>>>> }
>>>> - /* restart tx timer(to verify that we will not exceed
>>>> - * AD_MAX_TX_IN_SECOND
>>>> - */
>>>> - port->sm_tx_timer_counter = ad_ticks_per_sec/AD_MAX_TX_IN_SECOND;
>>>> }
>>>> }
>>>>
>>>> @@ -2199,9 +2197,9 @@ void bond_3ad_bind_slave(struct slave *slave)
>>>> /* actor system is the bond's system */
>>>> __ad_actor_update_port(port);
>>>> /* tx timer(to verify that no more than MAX_TX_IN_SECOND
>>>> - * lacpdu's are sent in one second)
>>>> + * lacpdu's are sent in the configured interval (1 or 30 secs))
>>>> */
>>>> - port->sm_tx_timer_counter = ad_ticks_per_sec/AD_MAX_TX_IN_SECOND;
>>>> + port->sm_tx_next_jiffies = jiffies + ad_ticks_per_sec / 
>>>> AD_MAX_TX_IN_SECOND;
>>> If CONFIG_HZ is 1000, there is 1000 tick per second, but 
>>> "ad_ticks_per_sec / AD_MAX_TX_IN_SECOND” == 10/3 == 3, so that means 
>>> send lacp packets every 3 ticks ?
>>     Agreed, I think the math is off here.
>>
>>     ad_ticks_per_sec is 10, it's the number of times the entire LACP
>> state machine runs per second.  It is unrelated to jiffies, and can't be
>> used directly with jiffy units (the duration of which varies depending
>> on what CONFIG_HZ is).  I agree that it's confusingly similar to
>> ad_delta_in_ticks, which is measured in jiffy units.
>>
>>     You'll probably want to use msecs_to_jiffies() somewhere.
>
>
> Thank you for taking the time to review my patch!
>
> I agree, the math is off here and I plan to fix that in v2. It shouldn't
> be:
>
> port->sm_tx_next_jiffies = jiffies + ad_ticks_per_sec / 
> AD_MAX_TX_IN_SECOND;
> port->sm_tx_next_jiffies = jiffies + 3;
>
> ... instead, it should be:
>
> port->sm_tx_next_jiffies = jiffies + HZ / AD_MAX_TX_IN_SECOND;
>
> ... which, assuming CONFIG_HZ is 1000, it would be:
>
> port->sm_tx_next_jiffies = jiffies + 333;
>
> This math also works in terms of the units too:
>
> HZ = ticks / sec
> AD_MAX_X_IN_SECOND = packets / sec
>
> so:
>
> (ticks / sec) / (packets /sec) = ticks / packet
>
>
>>
>>     How did you test this to insure the TX machine doesn't overrun
>> (i.e., exceed AD_MAX_TX_IN_SECOND LACPDU transmissions in one second)?
>>
>>     -J
>>
>>>> __disable_port(port);
>>>>
>>>> diff --git a/include/net/bond_3ad.h b/include/net/bond_3ad.h
>>>> index 2053cd8e788a..956d4cb45db1 100644
>>>> --- a/include/net/bond_3ad.h
>>>> +++ b/include/net/bond_3ad.h
>>>> @@ -231,10 +231,7 @@ typedef struct port {
>>>> mux_states_t sm_mux_state; /* state machine mux state */
>>>> u16 sm_mux_timer_counter; /* state machine mux timer counter */
>>>> tx_states_t sm_tx_state; /* state machine tx state */
>>>> - u16 sm_tx_timer_counter; /* state machine tx timer counter
>>>> - * (always on - enter to transmit
>>>> - *  state 3 time per second)
>>>> - */
>>>> + unsigned long sm_tx_next_jiffies;/* expected jiffies for next 
>>>> LACPDU sent */
>>>> u16 sm_churn_actor_timer_counter;
>>>> u16 sm_churn_partner_timer_counter;
>>>> u32 churn_actor_count;
>>>> -- 
>>>> 2.43.0
>>>>
>>>>
>>>>
>> ---
>>     -Jay Vosburgh, jv@jvosburgh.net
>>
>
> Thanks,
>
> Carlos
>

Thanks,

Carlos


