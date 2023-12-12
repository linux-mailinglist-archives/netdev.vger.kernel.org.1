Return-Path: <netdev+bounces-56192-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BDE880E1FD
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 03:40:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA99A281776
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 02:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E836664A;
	Tue, 12 Dec 2023 02:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BFmpCxSL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F776AD
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 18:40:46 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-db632fef2dcso5085809276.1
        for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 18:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702348845; x=1702953645; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WwjPQY6SOBIX9LMvTSm5wdlDNKcBkOrGqYwgms31GYQ=;
        b=BFmpCxSL7R2ZEh9gCQt83vQlXcCe1608jzrpd6EmIwmn9mvaM8EojvOWD2HmBkL2Nj
         pOlxfNN4uJGR/sjXU2/ld878YyvccgL5oubbqukLzpdDFI+BU53BYgUGnYBuZj206Jav
         dFpIct4CHagkFs3kdJ8Vimf9gm+xMKjoZqau8Qr+vNaZAoG1Kf86uxMCs4ybVfN2iB2E
         lqZfsWHzRpY1KFuzPy//GPLKMiy2b4ZZy4Y2IozYxslR099uoHi35QxLl1F7IZlEUkAc
         I/nHCYTl7EtnICzJAfTV/q8d8RQ9Ss7N/VfVF7eaVJpaKdUfXGrfmsDwO5qfx6EoD3tf
         RYLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702348845; x=1702953645;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WwjPQY6SOBIX9LMvTSm5wdlDNKcBkOrGqYwgms31GYQ=;
        b=BObVPniwO8OHf5QAp+setRa3lbRN+f9tIg54ModZs5j2vZtqgrseY4PZTFpuD6eTYe
         F7Kh3woqXYExvVkj4/M8mSZErRI5HBmwWmJ2kh09UyAJJfrJRTl4UVxKL+i6r7mZsHIH
         RSVyXRIIekVQN/NNZk9HartEscW0q1VCLdJL2I3dxmNsaYWctihwDVJLDFnHp2ZKuAJk
         fl+slB35IY0MnBuVjsOY1vECHoF4ZOJeW3wY91/kABpy74A56j3FX3Qd6vjZoSgx3Ylh
         00KHIw9taFM6y8Dhr/NbH4gNF36I0lli4FQlUQuT+pu+eaOMH6L0BPAKRoLuzJHN6Zvg
         c08A==
X-Gm-Message-State: AOJu0YzGpkpva12qzq71oNwkH0kyljqCF7DKvTvCbm62/qgAq0vwH92h
	exPWhSKDVBobgEGgQOB8dIU=
X-Google-Smtp-Source: AGHT+IGCsfnsr8E1GeCgMmC5w87SQJTMC5JBHeYULNTNTQS01hH3eNbZTn9iTlbNwoPcpsjN3HAP3Q==
X-Received: by 2002:a25:595:0:b0:db7:dacf:59e4 with SMTP id 143-20020a250595000000b00db7dacf59e4mr3293637ybf.88.1702348845372;
        Mon, 11 Dec 2023 18:40:45 -0800 (PST)
Received: from ?IPV6:2600:1700:6cf8:1240:417a:37c5:36f9:ad70? ([2600:1700:6cf8:1240:417a:37c5:36f9:ad70])
        by smtp.gmail.com with ESMTPSA id g93-20020a25a4e6000000b00da10d9e96cesm2975622ybi.35.2023.12.11.18.40.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Dec 2023 18:40:45 -0800 (PST)
Message-ID: <83a83ca3-3481-4e2d-a952-37437fca1800@gmail.com>
Date: Mon, 11 Dec 2023 18:40:43 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/2] selftests: fib_tests: Add tests for
 toggling between w/ and w/o expires.
Content-Language: en-US
To: Hangbin Liu <liuhangbin@gmail.com>, thinker.li@gmail.com
Cc: netdev@vger.kernel.org, martin.lau@linux.dev, kernel-team@meta.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org,
 edumazet@google.com, kuifeng@meta.com
References: <20231208194523.312416-1-thinker.li@gmail.com>
 <20231208194523.312416-3-thinker.li@gmail.com> <ZXfDd_tzAwDbi66Q@Laptop-X1>
From: Kui-Feng Lee <sinquersw@gmail.com>
In-Reply-To: <ZXfDd_tzAwDbi66Q@Laptop-X1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 12/11/23 18:20, Hangbin Liu wrote:
> On Fri, Dec 08, 2023 at 11:45:23AM -0800, thinker.li@gmail.com wrote:
>> From: Kui-Feng Lee <thinker.li@gmail.com>
>>
>> Make sure that toggling routes between w/ expires and w/o expires works
>> properly with GC list.
>>
>> When a route with expires is replaced by a permanent route, the entry
>> should be removed from the gc list. When a permanent routes is replaced by
>> a temporary route, the new entry should be added to the gc list. The new
>> tests check if these basic operators work properly.
>>
>> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
>> ---
>>   tools/testing/selftests/net/fib_tests.sh | 69 +++++++++++++++++++++++-
>>   1 file changed, 67 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/testing/selftests/net/fib_tests.sh b/tools/testing/selftests/net/fib_tests.sh
>> index 66d0db7a2614..a8b4628fd7d2 100755
>> --- a/tools/testing/selftests/net/fib_tests.sh
>> +++ b/tools/testing/selftests/net/fib_tests.sh
>> @@ -806,10 +806,75 @@ fib6_gc_test()
>>   	    ret=0
>>   	fi
>>   
>> -	set +e
>> -
>>   	log_test $ret 0 "ipv6 route garbage collection"
>>   
>> +	# Delete permanent routes
>> +	for i in $(seq 1 5000); do
>> +	    $IP -6 route del 2001:30::$i \
>> +		via 2001:10::2 dev dummy_10
>> +	done
>> +
>> +	# Permanent routes
>> +	for i in $(seq 1 100); do
>> +	    # Expire route after $EXPIRE seconds
>> +	    $IP -6 route add 2001:20::$i \
>> +		via 2001:10::2 dev dummy_10
>> +	done
>> +	# Replace with temporary routes
>> +	for i in $(seq 1 100); do
>> +	    # Expire route after $EXPIRE seconds
>> +	    $IP -6 route replace 2001:20::$i \
>> +		via 2001:10::2 dev dummy_10 expires $EXPIRE
>> +	done
>> +	N_EXP_SLEEP=$($IP -6 route list |grep expires|wc -l)
>> +	if [ $N_EXP_SLEEP -ne 100 ]; then
>> +	    echo "FAIL: expected 100 routes with expires, got $N_EXP_SLEEP"
> 
> Hi,
> 
> Here the test failed, but ret is not updated.
> 
>> +	fi
>> +	sleep $(($EXPIRE * 2 + 1))
>> +	N_EXP_SLEEP=$($IP -6 route list |grep expires|wc -l)
>> +	if [ $N_EXP_SLEEP -ne 0 ]; then
>> +	    echo "FAIL: expected 0 routes with expires," \
>> +		 "got $N_EXP_SLEEP"
>> +	    ret=1
> 
> Here the ret is updated.
> 
>> +	else
>> +	    ret=0
>> +	fi
>> +
>> +	log_test $ret 0 "ipv6 route garbage collection (replace with expires)"
>> +
>> +	PERM_BASE=$($IP -6 route list |grep -v expires|wc -l)
>> +	# Temporary routes
>> +	for i in $(seq 1 100); do
>> +	    # Expire route after $EXPIRE seconds
>> +	    $IP -6 route add 2001:20::$i \
>> +		via 2001:10::2 dev dummy_10 expires $EXPIRE
>> +	done
>> +	# Replace with permanent routes
>> +	for i in $(seq 1 100); do
>> +	    # Expire route after $EXPIRE seconds
>> +	    $IP -6 route replace 2001:20::$i \
>> +		via 2001:10::2 dev dummy_10
>> +	done
>> +	N_EXP_SLEEP=$($IP -6 route list |grep expires|wc -l)
>> +	if [ $N_EXP_SLEEP -ne 0 ]; then
>> +	    echo "FAIL: expected 0 routes with expires," \
>> +		 "got $N_EXP_SLEEP"
> 
> Same here.
> 
> Thanks
> Hangbin
>> +	fi
>> +	sleep $(($EXPIRE * 2 + 1))
>> +	N_EXP_PERM=$($IP -6 route list |grep -v expires|wc -l)
>> +	N_EXP_PERM=$(($N_EXP_PERM - $PERM_BASE))
>> +	if [ $N_EXP_PERM -ne 100 ]; then
>> +	    echo "FAIL: expected 100 permanent routes," \
>> +		 "got $N_EXP_PERM"
>> +	    ret=1
>> +	else
>> +	    ret=0
>> +	fi
>> +
>> +	log_test $ret 0 "ipv6 route garbage collection (replace with permanent)"
>> +
>> +	set +e
>> +
>>   	cleanup &> /dev/null
>>   }
>>   
>> -- 
>> 2.34.1
>>
Got it! Thanks!

