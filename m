Return-Path: <netdev+bounces-74259-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B8B860A0D
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 05:53:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D0B31F23459
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 04:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D753111B7;
	Fri, 23 Feb 2024 04:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TrzQPfeN"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70231101C1
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 04:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708663988; cv=none; b=TopTHvBC8X7azz2M9RrfVxgeuNIMZgb4hHMFhIYRZhD3hBbb8oRniTPUdUk7zy3uFeoyhtmSFaLmPQyfv6YO/v2QxlbpldM2ys9tb/6JVvWSXg7kvXReLoyoZNiitkMtf3H+zzD4GNhfQ4oJycOtG7DcpC8CVsv5kMRD4ADtgo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708663988; c=relaxed/simple;
	bh=+ots6f2A3Py4cQCnGgs7e1LAsqO6uMoWNaBv8TCRwKg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pBBSr0co41S3falt7MuYBuk/fLutxt81KFkNejg0/DZSF4wufgU9prcf1rGTEDSIH3SvwPsqYszFux7TdA/KWoaIsrhAMjUQk/pzP0ItWnz8nk1ipaI50hafjZEGjeEJSTBUtwiNoQ8raUyjgRyoD2WuDqUiXqUw07/KOZ0zoD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TrzQPfeN; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-607f94d0b7cso5543547b3.3
        for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 20:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708663986; x=1709268786; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VNnjsdG7OaXeWjNkSn7w74PfYJbI4SKg53f38LSs1uw=;
        b=TrzQPfeNyypXKcwxRBsUZkcXOz7VHczWAl3p1ExnMP9gQCMDq99iFCbFPinlbvmAsI
         xScHZNB0vNy1aAFs7H1SipnOgwrORZs8hckJ4gxX5Jv98XgVMSvCDAS+oG3JPiGtZBdG
         a894V/dh9NVP3PIvKoqDQdjtXLCERcOLevy4HbGEyVFACd9v5593l2SHU2VutgoNBDGQ
         OU9OUJwYw15xgSpG8FmsURBlHvVAiShXNyAD7mW1hRsQJkCwMtlsiVB/KY1G03kxtfcF
         mAAETS9iSXgUHQ5t26wdgPV/UJo3WB1Npz7aJ4XHSJbJatViPp4Ls4TQN3AauLU9QcmA
         yDpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708663986; x=1709268786;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VNnjsdG7OaXeWjNkSn7w74PfYJbI4SKg53f38LSs1uw=;
        b=CwIdd/8km6SXwTNN0+tvTwvDnmpEfYyvd1cZWyUdliIyRsuoPYBZQhbGynYlNR8v37
         7JvCRgCUwbL99BxIgSVPa9e/dvLZ0pt8RdwWIhDS3D+Pfv+7YZ2vhUB6WboioPpjZUj0
         IpgpPMzU4NC6Li5HOmTNHJHvJsBLKRdc+XVTy/mP5Ul5G5old98Uchzp8MCcE2ztB1d7
         oGF5QwPT09g+uoThnfmU8S53rgEAFzYa4tR44z1cZRgFZNQ0Ohp8Wx53sAbi27hD2+2i
         2Oad6OlJnNukl9+6HNFggtJhGdb82JycC6LWcseoPz58GFpHuxQDkEEwc9m2DwopVUXh
         C2tw==
X-Gm-Message-State: AOJu0YzOgrSyHQP3UgzXApE5QaSjWLEqWgK86fFyRcfImwMe3RcLa44F
	Fjx8xvuQTMpH9G8BNCaZR92ivyXgtXyByzp9GeJzk7vyBECTxoL4
X-Google-Smtp-Source: AGHT+IEoRwN510iVa9zUtLHw7UrBbONBjC6P7Ll6uKiiYg5rueNizeLarsLzVUrVllXWn/r5L/iZYw==
X-Received: by 2002:a0d:d415:0:b0:608:77f9:e80a with SMTP id w21-20020a0dd415000000b0060877f9e80amr1053827ywd.28.1708663986357;
        Thu, 22 Feb 2024 20:53:06 -0800 (PST)
Received: from ?IPV6:2600:1700:6cf8:1240:ed33:997d:2a31:1f4? ([2600:1700:6cf8:1240:ed33:997d:2a31:1f4])
        by smtp.gmail.com with ESMTPSA id w22-20020a814916000000b0060895f49c8asm723754ywa.120.2024.02.22.20.53.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 20:53:06 -0800 (PST)
Message-ID: <1cd8c2c9-d067-4eb4-8b56-d08525971c95@gmail.com>
Date: Thu, 22 Feb 2024 20:53:03 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 5/5] selftests/net: Adding test cases of
 replacing routes and route advertisements.
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, thinker.li@gmail.com
Cc: netdev@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
 kernel-team@meta.com, davem@davemloft.net, dsahern@kernel.org,
 edumazet@google.com, pabeni@redhat.com, liuhangbin@gmail.com,
 kuifeng@meta.com
References: <20240208220653.374773-1-thinker.li@gmail.com>
 <20240208220653.374773-6-thinker.li@gmail.com>
 <20240222195224.7ff5c5e0@kernel.org>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <20240222195224.7ff5c5e0@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/22/24 19:52, Jakub Kicinski wrote:
> On Thu,  8 Feb 2024 14:06:53 -0800 thinker.li@gmail.com wrote:
>>   	# Permanent routes
>> -	for i in $(seq 1 5000); do
>> +	for i in $(seq 1 5); do
>>   	    $IP -6 route add 2001:30::$i \
>>   		via 2001:10::2 dev dummy_10
>>   	done
>>   	# Temporary routes
>> -	for i in $(seq 1 1000); do
>> +	for i in $(seq 1 5); do
>>   	    # Expire route after $EXPIRE seconds
>>   	    $IP -6 route add 2001:20::$i \
>>   		via 2001:10::2 dev dummy_10 expires $EXPIRE
>>   	done
>> -	sleep $(($EXPIRE * 2))
>> -	N_EXP_SLEEP=$($IP -6 route list |grep expires|wc -l)
>> -	if [ $N_EXP_SLEEP -ne 0 ]; then
>> -	    echo "FAIL: expected 0 routes with expires," \
>> -		 "got $N_EXP_SLEEP (5000 permanent routes)"
>> -	    ret=1
>> -	else
>> -	    ret=0
>> +	sleep $(($EXPIRE * 2 + 1))
>> +	check_rt_num 0 $($IP -6 route list |grep expires|wc -l)
>> +	log_test $ret 0 "ipv6 route garbage collection (with permanent routes)"
> 
> Looks like fib_tests.sh have gotten flaky since this got merged :(

Sure! I am looking into it.

> 
> https://netdev.bots.linux.dev/contest.html?test=fib-tests-sh&executor=vmksft-net&pass=0
> 
> # Fib6 garbage collection test
> #     TEST: ipv6 route garbage collection                                 [ OK ]
> # FAIL: Expected 0 routes, got 1
> #     TEST: ipv6 route garbage collection (with permanent routes)         [FAIL]
> #     TEST: ipv6 route garbage collection (replace with expires)          [ OK ]
> #     TEST: ipv6 route garbage collection (replace with permanent)        [ OK ]
> https://netdev-3.bots.linux.dev/vmksft-net/results/477081/6-fib-tests-sh/stdout
> 
> # Fib6 garbage collection test
> #     TEST: ipv6 route garbage collection                                 [ OK ]
> # FAIL: Expected 0 routes, got 3
> #     TEST: ipv6 route garbage collection (with permanent routes)         [FAIL]
> #     TEST: ipv6 route garbage collection (replace with expires)          [ OK ]
> #     TEST: ipv6 route garbage collection (replace with permanent)        [ OK ]
> https://netdev-3.bots.linux.dev/vmksft-net/results/467181/6-fib-tests-sh/stdout
> 
> # Fib6 garbage collection test
> #     TEST: ipv6 route garbage collection                                 [ OK ]
> # FAIL: Expected 0 routes, got 3
> #     TEST: ipv6 route garbage collection (with permanent routes)         [FAIL]
> #     TEST: ipv6 route garbage collection (replace with expires)          [ OK ]
> #     TEST: ipv6 route garbage collection (replace with permanent)        [ OK ]
> https://netdev-3.bots.linux.dev/vmksft-net/results/466641/18-fib-tests-sh/stdout
> 
> Could you take a look?

