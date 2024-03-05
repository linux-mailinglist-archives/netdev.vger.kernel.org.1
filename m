Return-Path: <netdev+bounces-77320-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC96187142F
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 04:20:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12AC41C21367
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 03:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80B729437;
	Tue,  5 Mar 2024 03:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iOhLC4fY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCC02942A
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 03:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709608807; cv=none; b=T9Tdjf64ywik9dSvSDpYOL/oqtiUNaiPFL78dFO17WdVlF/ModoldEeMPxCxEWVA1vW9hfdY04TMOcGsdMip6YsY5jur3+MtWIovbfkYQqB7KBz2zRyWHB6/5VpajSoAWBqgryKnJ42C7tygB1ttgVdxjk16KtzsEYm5skHkZcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709608807; c=relaxed/simple;
	bh=RH7vMr4oI5eXncQoIOt9MCnVVG5kmL5K66jtN4WsF2g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c/UCSDN9mIXuRaPgNIq0kCBDbpUbXNpco6mkp0EmRjWk3V9GMguovxWsm1wHvzpkLbAoaJYZgVtSddNT4tOf0de0QLEJJ86QX5uOITXEVCsJxHlZYyRHJx4HQeaiddGfs2u+kJ7GVj+SkW0KBQZJv5nBWfAQ4lTuR6OfWp/4FOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iOhLC4fY; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dd014003277so2134734276.2
        for <netdev@vger.kernel.org>; Mon, 04 Mar 2024 19:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709608805; x=1710213605; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LJc5yQVT8izAR/cwcjxLOkIsF+dnBzW3RYyf4+I6odw=;
        b=iOhLC4fYbvNLCzmk9vayPS1jX9MMq+G2BZmV1lH8h+Pg5vqSAgyeqdffkmgTkeaoq5
         l/P0X4S3tMKjfMdU8ZsjmqIKpoexg8GkwBpJ2zMqdt6rWs4d+ppR+44QjyHz8hxTCrAd
         wTvcpPCdMQ9FIONQ/cx49/6dUHngn8sRphenZJnWQri79g006ZL+QGA5D11yPgdC60Oy
         VCO8SG/cp2PZDz2Tmyk8XJqZ03mtenAX62dtsvXQZ6opMYM/ZPeRF8A3abWaTdy8Hh3c
         pguCypju7IoclYwEzpkH31LtD2jMpE+excLUdUWU1C7aFdDkiAzgnh5JOmigg6Wui06+
         wKgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709608805; x=1710213605;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LJc5yQVT8izAR/cwcjxLOkIsF+dnBzW3RYyf4+I6odw=;
        b=L2aPiqhL/gZ5j5EnK4X41Y4aB+Xl9+lEVs2J/pgKemOJK2XBjj4tXC7vkZO4yBGzpF
         CgGyiXEIFWRWZo6Zt5BEan/dPeNE29Lz/hl+Up3KrJg8RzZl8W59S27AMvQtqudlxvSA
         1yvI6r2AgjCXkN4tcrshOa2vyOc8z8R25R2U6lBRuy3vRtcqAWjWNeaGt2rG2B8bQWfX
         drolRouB0pPK636vBqLKLky6vVX9bAfi6j7TGPuaOq/L74+LgAK9ZHUrT3rpTLpgfi+H
         H+ZA3lLOYP/7kl7fpXIcxo/fEDIbqapwaxzNGWaSGsQKHOtvnR5ENsZutIJetLD0EeQb
         1XSg==
X-Forwarded-Encrypted: i=1; AJvYcCV2HTVaaL8y72eEKPfOfj0MV5AvffrlY66xmt3nO7eLrrS/Wc6bwsqXwY7Th+DXOsuD1c2/rczjEkZuFGxCJ84bJp32at4Q
X-Gm-Message-State: AOJu0YxuOjTyycn4kA2zL0q51v0wRN2R1C/e1y5KvN9AqsOFxi149zFo
	XYU2dFJAtN1LoYY9nfZyAR7b4eg5cURASA9TP3BBek2073W4lq5r
X-Google-Smtp-Source: AGHT+IFPdfejD/4ij2rRzrau70AG9kQOB/YPdMoE/o5PxR0iucaVhs0LvtAHKsp5xpch+BG7zQCbqw==
X-Received: by 2002:a5b:48d:0:b0:dc6:ebca:c2e8 with SMTP id n13-20020a5b048d000000b00dc6ebcac2e8mr8203842ybp.5.1709608805350;
        Mon, 04 Mar 2024 19:20:05 -0800 (PST)
Received: from ?IPV6:2600:1700:6cf8:1240:2491:3867:404c:f267? ([2600:1700:6cf8:1240:2491:3867:404c:f267])
        by smtp.gmail.com with ESMTPSA id w73-20020a25df4c000000b00dc74258241fsm827886ybg.45.2024.03.04.19.20.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Mar 2024 19:20:04 -0800 (PST)
Message-ID: <c637d176-d3c8-4b3c-8b64-7c1813bcd5fc@gmail.com>
Date: Mon, 4 Mar 2024 19:20:03 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] selftests/net: force synchronized GC for a test.
Content-Language: en-US
To: David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Cc: Kui-Feng Lee <thinker.li@gmail.com>, netdev@vger.kernel.org,
 ast@kernel.org, martin.lau@linux.dev, kernel-team@meta.com,
 davem@davemloft.net, kuifeng@meta.com
References: <20240223081346.2052267-1-thinker.li@gmail.com>
 <20240223182109.3cb573a2@kernel.org>
 <b1386790-905f-4bc4-8e60-c0c86030b60c@kernel.org>
 <6b73aa09-b842-4bd0-abab-7011495e7176@gmail.com>
 <d2a4bcab-4fab-4750-b856-a8a9b674a31a@gmail.com>
 <20240304074421.41726c4d@kernel.org>
 <d0719417-e67f-48a9-ac1a-970d0c405270@kernel.org>
 <ad0de3e3-e988-4975-b8b7-5ae7574087f6@kernel.org>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <ad0de3e3-e988-4975-b8b7-5ae7574087f6@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/4/24 18:49, David Ahern wrote:
> On 3/4/24 7:41 PM, David Ahern wrote:
>> On 3/4/24 8:44 AM, Jakub Kicinski wrote:
>>> On Fri, 1 Mar 2024 16:45:58 -0800 Kui-Feng Lee wrote:
>>>> However, some extra waiting may be added to it.
>>>> There are two possible extra waiting. The first one is calling
>>>> round_jiffies() in fib6_run_gc(), that may add 750ms at most. The second
>>>> one is the granularity of waiting for 5 seconds (in our case) is 512ms
>>>> for HZ 1000 according to the comment at the very begin of timer.c.
>>>> In fact, it can add 392ms for 5750ms (5000ms + 750ms). Overall, they may
>>>> contribute up to 1144ms.
>>>>
>>>> Does that make sense?
>>>>
>>>> Debug build is slower. So, the test scripts will be slower than normal
>>>> build. That means the script is actually waiting longer with a debug build.
>>>
>>> Meaning bumping the wait to $((($EXPIRE + 1) * 2))
>>> should be enough for the non-debug runner?
>>
>> I have not had time to do a deep a dive on the timing, but it seems odd
>> to me that a 1 second timer can turn into 11 sec. That means for 10
>> seconds (10x the time the user requested) the route survived.
> 
> Also, you added a direct call to ipv6_sysctl_rtcache_flush to force a
> flush which is going to try to kick off gc at that moment. Is the delay
> kicking in?
> 
> delay = net->ipv6.sysctl.flush_delay;

The delay doesn't cause any different here. The delay affects only 
exceptions.

It doesn't 10x. It does 2 times.
In fib_tests.sh

   sysctl -wq net.ipv6.route.gc_interval= $EXPIRE

The test sets the gc interval to 5 seconds.

The test install several routes in a round. So, some later routes may
miss the first GC that emitted after the first 5 seconds. These routes
have to wait for 5 more seconds for the next time GC. So, it is 10
seconds. However, due to calling round_jiffies() in fib6_run_gc(), the
waiting time of the second GC period can be longer. It could increase
750ms at most.  And, due to the granularity of the timer, it can adds
another 512ms at the range 4s~32s.



