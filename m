Return-Path: <netdev+bounces-207572-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 201F2B07E53
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 21:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5CAF3A997B
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 19:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B09228C2BB;
	Wed, 16 Jul 2025 19:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fVYCursZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B097828DF01;
	Wed, 16 Jul 2025 19:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752695128; cv=none; b=AORTa5L0JUBSFUbAdxDnFMFmr9bVPKzvOEIT7gn68nfGmgY+j5RzfvxE61AuN7mLhO2dCWmJuWo7stvvy/7vlqc2SHimKbkEX98BHHPVEcdLMp0sgVtERWJY6Rw/L0BpaPFVB2DxIycToBYhE7f6Mn3xuswbYf9umV6tqrUjUTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752695128; c=relaxed/simple;
	bh=Y5XZxdRTLqk/ncGXPl47/+ZUnPv74b4m0yZEJXZ8anI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PJMARgkEB28hGgWflJi7XlpChc9qYHTQWVJLc/VldKqiK2ficoHSciDaOPijqFPtNWYFXPNDo/0fbKC4nY3G6k0KBgENxmb09m0vrA4eAA5kO90f8PuQdOu404wsW6f+SxMy1wGE4nAPHcbl/iYmRktYaPdb5Ka3JBipSMVWN5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fVYCursZ; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-73e57751cd9so75262a34.1;
        Wed, 16 Jul 2025 12:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752695126; x=1753299926; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IbOzMgQRfsQq4DDryctg417+ooU3MeXFpRK9ccpxHbk=;
        b=fVYCursZqaYc9uSG4QRpjso0Qd4ZWXFcGh+3RKEwsjT4yNwdIdL/1T//yH17ipNnay
         VAtvfaOc27eP8EY7Spzak3BYMk4eZUKbIIJFJf2ivWRF3Mo8kVoBjs+xnl5uC+WEZXwn
         8PsAQEhtoewSnA4cC+27BSlGw0YDR63CYGu5pXSMuDyi6peePNOA1cEUesjdjxoQVh42
         /9+FgZgB2PftQJqdZ5i8DLQpgKuR2B8EVjh9m7YUgYxoXCfdek2URdYRDSXZDhbDmWaN
         B2+4Dp7H8tzb+WOOJEFQqpX+x9kVwD7y9iu/xntwNOxSCg8H11nWmyrUGoHoruykh1YM
         aRIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752695126; x=1753299926;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IbOzMgQRfsQq4DDryctg417+ooU3MeXFpRK9ccpxHbk=;
        b=vkp09eqi5JE3UCg+rriAuXAvId/ZwXtvH7D1JokSnUV6C6p8rEpgjO+3YFVIpHzcWg
         Uy7lt27qjGhSBnLb9TAO0DUNVj3mQKO+2F2lpJRjsL9ZRZbhmC4cSRHF5o5DRw8viMn4
         tE7ApdHyQyp1JfrywuQJHCEuDSFg3EYIt0qm8JxIt0LzYf1M1/r1402hElvAgdSsCxYg
         wLmwEkXn7itxG+uxGvJZ9qb/TA9LvQswjqFFuzN2BY7q+BffksG+xmps1R7x3jIjdH2q
         WVXTrTByqncG6iAbawjOagBCz7stN4SQYynkpPVnIUQA5V5hHNJv/z1dUptL4VY4djwQ
         MorA==
X-Forwarded-Encrypted: i=1; AJvYcCVCe1hg/s8Fbu15wPXexOkl8FCdkQzxTwuQhoxkBSXjGrkP14+mfpaTBZge8dAQzvUgGu7Hz9fb@vger.kernel.org, AJvYcCXMp7fxOjBr8hidaTAjrJ5Y3SbIuumXCEwrsU3vH0GQouL+oriL2s+p/P5EgZFFnNLeeZbBvxXQbbP5bQw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw52jxzm7zQD4gKYR0drjcI2E+WcTqczJTuJy6GrwCgjB6Ha2zl
	oPdzTE1vpT9AOJvKTiBg+PsQXUT54mdB7ZkILOaQBCnIRamwM2kEUpk8
X-Gm-Gg: ASbGnctIgAv2+u1sxpyC8kMjQwKcTP5elpV0y5z45etOg+h8xV/hnAcBMby0t19eKnw
	6nmvmSgiGSRmYHrrvqjWiIfa+9vdW1HDFByYqGtwOcoljTuw7owY/ShrFZBULPUBPrnA96IJJ6x
	jU4c9IlSVdSp9ywP+djO3hIbZTDaw8LheIeHt9rF0rEZszf3ACTf282gCuDIXMHc8WTx3jH051d
	evUp8MZcaxf9huouCtWuZBxqUQo0t7KJUk/Gx/+NHTIls7uzNfZuBYDR1vQHY0UYsTjHZsdxsR5
	j1ekRMeqyyquCcTU1KYCMjI2FPXi3SrTBgoBVA1FBul2E8/l0Rwzg8xcl0oeGUMbLVze+A8YMuz
	76QXipAox7btZPpEgA4yE90DGxml7Ztd2lr3i1Y4my/wtKR/O1AYPOWBQo9s8HzukDdobL+tJu6
	ZoPUNwZZ2ZR34z4ZkVmDGh
X-Google-Smtp-Source: AGHT+IHr5ntGscYA88vSgp3gbES+Ng8TJ0O4WcH5dKhBDBbGiloYYc+u0j6Go0vy63ngU94V7BYomA==
X-Received: by 2002:a05:6870:f68b:b0:29e:2ce2:94d with SMTP id 586e51a60fabf-2ffaf2a3c3cmr3593603fac.14.1752695125650;
        Wed, 16 Jul 2025 12:45:25 -0700 (PDT)
Received: from ?IPV6:2603:8080:7400:36da:ada3:14fa:a3ad:9ccf? ([2603:8080:7400:36da:ada3:14fa:a3ad:9ccf])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2ff111c4f8asm3734738fac.6.2025.07.16.12.45.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Jul 2025 12:45:25 -0700 (PDT)
Message-ID: <2d8c482c-cf4f-4527-8edb-a850d1d538ac@gmail.com>
Date: Wed, 16 Jul 2025 14:45:23 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] bonding: Switch periodic LACPDU state machine from
 counter to jiffies
To: Simon Horman <horms@kernel.org>, carlos.bilbao@kernel.org
Cc: jv@jvosburgh.net, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, sforshee@kernel.org,
 bilbao@vt.edu
References: <20250715205733.50911-1-carlos.bilbao@kernel.org>
 <20250716090945.GL721198@horms.kernel.org>
Content-Language: en-US
From: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
In-Reply-To: <20250716090945.GL721198@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hello Simon,

On 7/16/25 04:09, Simon Horman wrote:
> On Tue, Jul 15, 2025 at 03:57:33PM -0500, carlos.bilbao@kernel.org wrote:
>> From: Carlos Bilbao <carlos.bilbao@kernel.org>
>>
>> Replace the bonding periodic state machine for LACPDU transmission of
>> function ad_periodic_machine() with a jiffies-based mechanism, which is
>> more accurate and can help reduce drift under contention.
>>
>> Signed-off-by: Carlos Bilbao (DigitalOcean) <carlos.bilbao@kernel.org>
>> ---
>>   drivers/net/bonding/bond_3ad.c | 79 +++++++++++++---------------------
>>   include/net/bond_3ad.h         |  2 +-
>>   2 files changed, 32 insertions(+), 49 deletions(-)
>>
> Hi Carlos,
>
> Some minor feedback from my side.
>
>> diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad.c
> ...
>
>> @@ -1471,21 +1451,24 @@ static void ad_periodic_machine(struct port *port, struct bond_params *bond_para
>>   			  "Periodic Machine: Port=%d, Last State=%d, Curr State=%d\n",
>>   			  port->actor_port_number, last_state,
>>   			  port->sm_periodic_state);
>> +
>>   		switch (port->sm_periodic_state) {
>> -		case AD_NO_PERIODIC:
>> -			port->sm_periodic_timer_counter = 0;
>> -			break;
>> -		case AD_FAST_PERIODIC:
>> -			/* decrement 1 tick we lost in the PERIODIC_TX cycle */
>> -			port->sm_periodic_timer_counter = __ad_timer_to_ticks(AD_PERIODIC_TIMER, (u16)(AD_FAST_PERIODIC_TIME))-1;
>> -			break;
>> -		case AD_SLOW_PERIODIC:
>> -			/* decrement 1 tick we lost in the PERIODIC_TX cycle */
>> -			port->sm_periodic_timer_counter = __ad_timer_to_ticks(AD_PERIODIC_TIMER, (u16)(AD_SLOW_PERIODIC_TIME))-1;
>> -			break;
>>   		case AD_PERIODIC_TX:
>>   			port->ntt = true;
>> -			break;
>> +			if (!(port->partner_oper.port_state &
>> +						LACP_STATE_LACP_TIMEOUT))
>> +				port->sm_periodic_state = AD_SLOW_PERIODIC;
>> +			else
>> +				port->sm_periodic_state = AD_FAST_PERIODIC;
>> +		fallthrough;
> super-nit: maybe one more tab of indentation for the line above.
>
>> +		case AD_SLOW_PERIODIC:
>> +		case AD_FAST_PERIODIC:
>> +			if (port->sm_periodic_state == AD_SLOW_PERIODIC)
>> +				port->sm_periodic_next_jiffies = jiffies
>> +					+ HZ * AD_SLOW_PERIODIC_TIME;
>> +			else /* AD_FAST_PERIODIC */
>> +				port->sm_periodic_next_jiffies = jiffies
>> +					+ HZ * AD_FAST_PERIODIC_TIME;
> Clang 20.1.8 complains that either a break; or fallthrough; should go here.
> For consistency with the code above I'd suggest the latter.


Thank you for the feedback! I’ll be sure to address it in v2, if we decide
to move forward with this.


>
>
>>   		default:
>>   			break;
>>   		}
> ...


Thanks,

Carlos


