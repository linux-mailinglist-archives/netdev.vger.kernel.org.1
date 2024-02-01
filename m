Return-Path: <netdev+bounces-68138-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B52BE845E46
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 18:14:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7A5D1C228EF
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 17:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33FC4160888;
	Thu,  1 Feb 2024 17:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yi6vpXtg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E25116087F
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 17:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706807662; cv=none; b=QuvStXPs1q3M2+ht9S63dxwz0MCudoGc8hJ6KikHHviMO62fPKDzo9hd+4LlecLPNgo+QT6dyM71BF68yS7coevy60iLeW4LrVBx1sEPpQNp4BezgKQjxTa/A0bzgmlkKV8nyXIAMqPflb3gsI9Z8meg6aUIo4JoLtpFaH6F+x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706807662; c=relaxed/simple;
	bh=gU8thq7J5TCYF34U/LU+7wEBu8KKfhhL845/dKJ4GxI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VdlNAeIxRv06FPqp31ejueTlIR6qnCesCaZj2KNPzHEgndL8nXKuL8YuEIAdinfQPYEAibof19Kk+WZ8tcYUSN6f/+xAdZvFqq+QLlrQn+Vp/HHrRhc3k43nAERs6C3c/Hk1Ve4mgujHdCZiJpfil5dWXQZdA7iIbTUPOy3ww6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yi6vpXtg; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-604123a7499so12334457b3.3
        for <netdev@vger.kernel.org>; Thu, 01 Feb 2024 09:14:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706807659; x=1707412459; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BODdxd4JD+654DTMxsqMEdGHW0fURTYjfBFForLZ/KI=;
        b=Yi6vpXtgnOKQASMBaJP0lQUl2jPQQP0su/iYzn78zk8Bmtp+q6rCJKrC/tJ63WpfFP
         gXRreOVUPH4Q8UM56yrbkna/ZnjXD0jaIwxqe3+psu9mZBfPRJEWvTOxcJPsyZbl5koA
         KToBN6IEi3EpyHl1KsCsea2WfR7nYEEYVqVKHjjnEoOcLDcBuR5TTTWaPvJ/hEfjFil5
         wtQ6FxJMx5xRBXjVI52NSuFocCBcKOs79ZKAZXNpCQw1YMmyfmK2bkYnFOyVvca3dO7j
         lIROhC5F99gMIpYFoL4sgWnAwrPb3oYmhcHn3+b094Dv46S772YvXorllEJb2Ee/+guG
         fqcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706807659; x=1707412459;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BODdxd4JD+654DTMxsqMEdGHW0fURTYjfBFForLZ/KI=;
        b=OJXE19CDEq8ybyws/YBEidfH0YPgtOy15rdtwM1T6cRvT93SOjJ1MvktRwQ16/bHYw
         5OZLbLpHZx9KHWlq2AxTEXOagH9xgG4aR5KT6mNLgfAPx1VZ9l3VgmLpwrZ9x/xIPJxU
         w1Y5sKs7+W2TTaW5zkxnBGjiUvV87uKv87PXdbngNanuJ7Rb0mazCN+IWBlXYuulog9S
         vdEdmY6SMPCZOMZQyed2Is/zSIONZMRiglGQ1St6qFtw6NUZh/1L7CdjkXbD1EK6JlVA
         lwC/JCXfWBw/SJCMMIWOfiZtMbIS9O7utlrcBk4k3L3XD+elzJlNU++qolprcTo6k3Wx
         rwpw==
X-Gm-Message-State: AOJu0YxcG4W/Lir5DRdZ1GotkXRW3wJgWRjyte/BbadUvKRPnaNAXfly
	KKLS/WbkSTsPAkf3ZkE473Yqup92SWQS429rB1x/LE8c2jdxizUu8mg673Hp
X-Google-Smtp-Source: AGHT+IGfuT4IiPO0+Fww2hxl8xPzUw5v8ANjG/0TuIeqlF71izScDxK1mvftSKZTevxec8QTx21/7A==
X-Received: by 2002:a0d:d901:0:b0:5ff:58f1:9944 with SMTP id b1-20020a0dd901000000b005ff58f19944mr5305828ywe.30.1706807659453;
        Thu, 01 Feb 2024 09:14:19 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUKVetHWLgS8L6a9vrcAsBCcio3w8xBYqT8Q74pQoOTRIQ6o0iFEd/4lH1Jlhxp2mF6SN/Hof6OEkO/tHQEjbYeREXLgdq4+MhNFQZT76S360o9BVAHHE17t1bKwwRp4ElS0U1x5Yy+pZ2kWM3ScCnWcSd/eNShWlNLA0ZTBv/DjbexFy+xYIAJXKs1zLVbJsA/qWdqhVcW66NxsRaj+R/PHiJp+yQAVSDj28GzLkLW+ZHGPywBnNYnWbWs3wqJB5iFBOJu0DkO/F44DwQK8OHJ8RP//KbvB8lT9YqmbluSiE+apv/pPxU1G03qnLL4ALBGsK1H
Received: from ?IPV6:2600:1700:6cf8:1240:16d4:21fd:67de:3e7? ([2600:1700:6cf8:1240:16d4:21fd:67de:3e7])
        by smtp.gmail.com with ESMTPSA id cp33-20020a05690c0e2100b005effa4feef0sm4406784ywb.58.2024.02.01.09.14.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 09:14:19 -0800 (PST)
Message-ID: <22cc962a-c300-49ee-95ee-76d9f794e23a@gmail.com>
Date: Thu, 1 Feb 2024 09:14:17 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 5/5] selftests/net: Adding test cases of
 replacing routes and route advertisements.
Content-Language: en-US
To: Hangbin Liu <liuhangbin@gmail.com>, thinker.li@gmail.com
Cc: netdev@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
 kernel-team@meta.com, davem@davemloft.net, dsahern@kernel.org,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, kuifeng@meta.com
References: <20240131064041.3445212-1-thinker.li@gmail.com>
 <20240131064041.3445212-6-thinker.li@gmail.com> <ZbtabpEr7I6Gy5vE@Laptop-X1>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <ZbtabpEr7I6Gy5vE@Laptop-X1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/1/24 00:46, Hangbin Liu wrote:
> Hi,
> 
> On Tue, Jan 30, 2024 at 10:40:41PM -0800, thinker.li@gmail.com wrote:
>> +# Create a new dummy_10 to remove all associated routes.
>> +reset_dummy_10()
>> +{
>> +	$IP link del dev dummy_10
>> +
>> +	$IP link add dummy_10 type dummy
>> +	$IP link set dev dummy_10 up
>> +	$IP -6 address add 2001:10::1/64 dev dummy_10
>> +}
>> +
>>   fib6_gc_test()
>>   {
>>   	setup
>> @@ -768,15 +778,19 @@ fib6_gc_test()
>>   	    $IP -6 route add 2001:20::$i \
>>   		via 2001:10::2 dev dummy_10 expires $EXPIRE
>>   	done
>> -	sleep $(($EXPIRE * 2))
>> -	N_EXP_SLEEP=$($IP -6 route list |grep expires|wc -l)
>> -	if [ $N_EXP_SLEEP -ne 0 ]; then
>> -	    echo "FAIL: expected 0 routes with expires, got $N_EXP_SLEEP"
>> +	sleep $(($EXPIRE * 2 + 1))
>> +	N_EXP=$($IP -6 route list |grep expires|wc -l)
>> +	if [ $N_EXP -ne 0 ]; then
>> +	    echo "FAIL: expected 0 routes with expires, got $N_EXP"
>>   	    ret=1
>>   	else
>>   	    ret=0
>>   	fi
>>   
>> +	log_test $ret 0 "ipv6 route garbage collection"
>> +
>> +	reset_dummy_10
> 
> Since you reset the dummy device and will not affect the later tests. Maybe
> you can log the test directly, e.g.
> 
> 	if [ "$($IP -6 route list |grep expires|wc -l)" -ne 0 ]; then
> 		log_test $ret 0 "ipv6 route garbage collection"
> 	fi
> 
> Or, if you want to keep ret and also report passed log, you can wrapper the
> number checking like
> 
> check_exp_number()
> {
> 	local exp=$1
> 	local n_exp=$($IP -6 route list |grep expires|wc -l)
> 	if [ "$n_exp" -ne "$exp" ]; then
> 		echo "FAIL: expected $exp routes with expires, got $n_exp"
> 		ret=1
> 	else
> 		ret=0
> 	fi
> }
> 
> Then we can call it without repeating the if/else lines
> 
> 	check_exp_number 0
> 	log_test $ret 0 "ipv6 route garbage collection"

If I read it correctly, the point here is too many boilerplate checks,
and you prefer to reduce them. Right?
No problem! I will do it.


> 
> Thanks
> Hangbin

