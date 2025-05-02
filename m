Return-Path: <netdev+bounces-187537-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01307AA7C0F
	for <lists+netdev@lfdr.de>; Sat,  3 May 2025 00:13:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D05D466ED5
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 22:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE252214229;
	Fri,  2 May 2025 22:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="jdk2iU7O"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD265158DA3
	for <netdev@vger.kernel.org>; Fri,  2 May 2025 22:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746224009; cv=none; b=P0OnfJipbv9yL8/PUFdjty9My2SiDKxL9XvEHG556ewlOphnw4OONgQDSQzrFFmBD0sPCFXMAIH/MgkAlnIourcy82NJm6CkLCWplHEUhpGAK29D0zoaBLzQTz5kgzs+L9BQE9Ci4ePVK6wXiwneMOlApBrivhTnag305ytIKnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746224009; c=relaxed/simple;
	bh=jaym/16v8FFucxKSSDLsQMllUbISdbiFaG7eDkG/sTI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RbZYnbvZmumX8AUR2ThX5C9wbT41HmS8C/9kCviOFegvMWvyJw4kmd2ClVq/+DOAvqz9ZDDEnB0FDhjrRr4GbXAl7jQ+Z2igvL1Q1CLXffuGBzV/ynVthG6xJEBwwUPXhlnioLf2I/vH/LR1sRqavZxuJQ1bRVqJMX/feOmcKYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=jdk2iU7O; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-224341bbc1dso34460955ad.3
        for <netdev@vger.kernel.org>; Fri, 02 May 2025 15:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1746224007; x=1746828807; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tFotOqo0DgEAbTYeUd+xbULGxUTbjXpH3LeNYn7z6lo=;
        b=jdk2iU7O0Ay0RXXCtcUDyLyQCqm7Nt9xUFOVckozuoI7zfHA3qLAZTK5kykRgzfQBS
         cKpdIvrooZFvtlrlsVRjPToPOV1PR3HEYDxvMQt5qBr//gTOhcZUCbOO3WwbA0667t5d
         XvYBn0oS76t6Ei3XVyKTM+cy/5lforE6WMEuf62jZck77qWby3t1l7701FlTZagQCBQO
         VoKL6UFpRt+U3iXGcgG1YdDztdyEaDjosunR0hqNogtZisRZin2qymxyHGQMHUqpMIeg
         Z+PJ+4NbEu8agOhAT5jG6NWdA2yhnbeAthb/x3hPjh8zudf86AQ5DetoOx/xiQRAI2bs
         +x2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746224007; x=1746828807;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tFotOqo0DgEAbTYeUd+xbULGxUTbjXpH3LeNYn7z6lo=;
        b=eJkZM+qE7WrqPvCGscdwF3Eclf4woKWnva3njaqxUK0d4oNInUy1bI3C6JZ7M3Nsav
         X9l+aUxoP4yo/iWzWInVfN6ydmb07y5OqjsrADQGY+bgixUakADnNAdf4DpetxcnMnYa
         hSrUic9/0st0LUOhJ+UoRxhlwHhaWsAcWDrXJMIwkaw//R0uKIgB6LjVnjRqvOAul0WM
         RCKr8VU7v+2Te9EjXR9h1Wigyofk+5UEL1Zrwt678KgExzPsmsL1qlLcG/Ob1Q/4sL8b
         kO9xSn2c0DKOosRmJJ83GxK5nF/mojO22pxUjELOKxyUOwr51NFtPjQlKLqjLTlPZMmp
         5jhw==
X-Forwarded-Encrypted: i=1; AJvYcCUUQenTzIgOvjqG9pTTmUARVwEGAqs4DosRBgjcJmSebAbR8PvAh/M13nztp9mFsY+RLj3xLKw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxK27v4SP4BVjrGpjO9WeEumGgkr+3EirRGOy+jghNKu3sUQ3oN
	YsjdZ9jNX4dfGi2e7Oizutdr26qUuiKSrXVuN2a7/7kJHoAAS4j9Tr16lYLhNQ==
X-Gm-Gg: ASbGnctysNztY+YvrPldLGPJxI9MdKZXkqwJvBJL5zEQePM/4Wos6ro7Bm9XJyP7Ij8
	OooMz8U0CnP68KPtDDRoT4H8v5dWfuDS8iDZvsnlCmz2FV6q/pyswsCfFew3mb6x0eBU5UkgaVN
	jFMCIDfbS8LojDNdVkbAUy/DGJDeLC7OT3ribxkFPJRo/zziAUQVElVVUIfBvLkZLRKnVQZLw87
	a8pxVxRasx9+tAitpwTpippDb68gg+Po0v91IRERK6AX4OQW7TQ2FEiTZqzwA7pr/0jxslf1gNO
	tZZYW5/JvC9URt8qVuwp1i1Ux+LOoHW3rh9D4UQe95QfQwE0LKx8m1WGsbpv91/+h1QJw9KE1b4
	BaQ5+3nzxbuQ=
X-Google-Smtp-Source: AGHT+IHnh6Aopfv20YDtmSdz175QDlyZYCM9OEPqA8Zl7GC0o++Dw4E9MtEXkQYSNGjPMsOuTQc+7Q==
X-Received: by 2002:a17:903:2350:b0:220:c813:dfce with SMTP id d9443c01a7336-22e18c39127mr8813745ad.39.1746224006807;
        Fri, 02 May 2025 15:13:26 -0700 (PDT)
Received: from ?IPV6:2804:7f1:e2c0:32dc:1373:7adc:1124:6935? ([2804:7f1:e2c0:32dc:1373:7adc:1124:6935])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e173b584csm7338805ad.16.2025.05.02.15.13.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 May 2025 15:13:26 -0700 (PDT)
Message-ID: <d56902b7-1e1a-402e-b0b8-9080e9115add@mojatatu.com>
Date: Fri, 2 May 2025 19:13:23 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch net 1/2] sch_htb: make htb_deactivate() idempotent
To: Paolo Abeni <pabeni@redhat.com>, Cong Wang <xiyou.wangcong@gmail.com>,
 netdev@vger.kernel.org
Cc: jhs@mojatatu.com, jiri@resnulli.us, alan@wylie.me.uk
References: <20250428232955.1740419-1-xiyou.wangcong@gmail.com>
 <20250428232955.1740419-2-xiyou.wangcong@gmail.com>
 <eecd9a29-14f9-432d-a3cf-5215313df9f0@mojatatu.com>
 <74017437-48d2-4518-9888-e74c14e01a5d@redhat.com>
Content-Language: en-US
From: Victor Nogueira <victor@mojatatu.com>
In-Reply-To: <74017437-48d2-4518-9888-e74c14e01a5d@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/2/25 06:59, Paolo Abeni wrote:
> On 4/30/25 5:19 PM, Victor Nogueira wrote:
>> If that's so, couldn't we instead of doing:
>>
>>> @@ -348,7 +348,8 @@ static void htb_add_to_wait_tree(struct htb_sched *q,
>>>     */
>>>    static inline void htb_next_rb_node(struct rb_node **n)
>>>    {
>>> -	*n = rb_next(*n);
>>> +	if (*n)
>>> +		*n = rb_next(*n);
>>>    }
>>
>> do something like:
>>
>> @@ -921,7 +921,9 @@ static struct sk_buff *htb_dequeue_tree(struct
>> htb_sched *q, const int prio,
>>                   cl->leaf.deficit[level] -= qdisc_pkt_len(skb);
>>                   if (cl->leaf.deficit[level] < 0) {
>>                           cl->leaf.deficit[level] += cl->quantum;
>> -                       htb_next_rb_node(level ?
>> &cl->parent->inner.clprio[prio].ptr :
>> +                       /* Account for (fq_)codel child deactivating
>> after dequeue */
>> +                       if (likely(cl->prio_activity))
>> +                               htb_next_rb_node(level ?
>> &cl->parent->inner.clprio[prio].ptr :
>>    
>> &q->hlevel[0].hprio[prio].ptr);
>>                   }
>>                   /* this used to be after charge_class but this constelation
>>
>> That way it's clear that the issue is a corner case where the
>> child qdisc deactivates the parent. Otherwise it seems like
>> we need to check for (*n) being NULL for every call to
>> htb_next_rb_node.
> 
> @Victor, I think that the Cong's suggested patch is simpler to very/tie
> to code change to the actually addressed issue. I started at your
> suggest code for a bit, and out of sheer htb ignorance I'm less
> confident about it fixing the thing.
> 
> Do you have strong feeling vs Cong's suggested approach?

I have no strong feelings, I'm ok with merging the patch
as is.

cheers,
Victor

