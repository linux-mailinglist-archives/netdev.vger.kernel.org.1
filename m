Return-Path: <netdev+bounces-134414-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71304999450
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 23:19:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A07B21C22769
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 21:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A920E1E4121;
	Thu, 10 Oct 2024 21:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bNYWRJjc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC171E1C13
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 21:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728595143; cv=none; b=rCEIhhz0LcF0oBzwIDoNf+hfzst29SqkXHYRVvUGU18hWbpLFhoEgzTtKDW2mq4MCI5ri1uuW18+k4UbgnfhA/9X6uk2u+wfRfud/2WoViiuT3dFYwCeTLrYWGIrdHiQ9l/oLOwqsR09vybJRDZ0WWS05Ny1zsm2WNnsljILfME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728595143; c=relaxed/simple;
	bh=XgFyRsRqIXnwJJtXgPqzhU6CtjwMWa+ou90c0icQbx0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IMl2iz4bNmRxAinbXeq7Mfp1utRJlh/Gq7ViCojlgMIyjFSlYrAG/6HUMGCGjBsUicBp83Iw4y2S65HaWlmnGZDnAOngoG57ew8dgNy/ONsPLc/Qkqzdv+SJe3OMKIjUe69xkebr+7xu+bY6RaeHqM1RWBAkS7b3hevz7osJtR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bNYWRJjc; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-835464abfa7so49082939f.0
        for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 14:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1728595140; x=1729199940; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nBZbBlwQa7HT+/mui9xTJE7fZJhA2rmF/mcQQtgNOAo=;
        b=bNYWRJjc1UpZiY4Iip35UUkTTGmuanbWWaFqetgyZP3a4urjmfcRoli4PiZEWbbTPB
         IJLAlqfX8Uc/oAB0VM7+45RC7bIq7l7jjJJjHqbmSftZS2Fm9yoSJAyPxJzgHp23F0eG
         ZTpivwUPD1fUasmUYMKpr4bn78qOESMYRFy6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728595140; x=1729199940;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nBZbBlwQa7HT+/mui9xTJE7fZJhA2rmF/mcQQtgNOAo=;
        b=I8PQTHYTLEpXuz4rXu/siYSkos/r5H5LqC0SiG+6BsvzLvTsf0svI71DcOvuUNGjE9
         u+rp6aXuVlyxrAbvw4qhxZRbUsEOlUk0LU/QZL9yyIdK41BUm94wJNvhcURv8HF0vGR7
         0DB2kktmV5TR5LB9nFqXEuQKp12BhGxp2kCCbIgB0NJtgDUgsztKNS/t+j1Qbzl6SNKF
         GncV9gjZQemtf7Mu0BJ58tJxlCZb1omik6tcBkV882AaaUKEnNcIGUo8ZTvHPhUkx+0+
         MCjRf22iodH++SeebtYwv0r935NF3jkIanlIwBZ9fATDTTHyD6BTQOeuZ/Njlt+xWmCA
         El4w==
X-Gm-Message-State: AOJu0YxsQ1QLCjGkyPVqH8/jthYQ6aGTV+/yh859izQeB88TuAhb4dxw
	C5dHDiQxcSkgO9X+oZfLfmKNKWDR+aD/qEO7euVSR8ZMagQSGaKhF8OW/UnS2RU=
X-Google-Smtp-Source: AGHT+IEYkeeNxtQt681in3Sz57PrDzHIA9l/kBVtyF0yM/0puYCqVuivQ2EI5A8y1bdIaBfyBVotKw==
X-Received: by 2002:a05:6602:1341:b0:835:3ec0:9 with SMTP id ca18e2360f4ac-83794d44d5cmr28566839f.15.1728595139979;
        Thu, 10 Oct 2024 14:18:59 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dbada841ebsm384083173.112.2024.10.10.14.18.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Oct 2024 14:18:59 -0700 (PDT)
Message-ID: <d4602ac9-8aa2-490e-be2d-edef517bc4f3@linuxfoundation.org>
Date: Thu, 10 Oct 2024 15:18:58 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v20 01/14] mm: page_frag: add a test module for
 page_frag
To: Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Alexander Duyck <alexander.duyck@gmail.com>,
 Alexander Duyck <alexanderduyck@fb.com>,
 Andrew Morton <akpm@linux-foundation.org>, Shuah Khan <shuah@kernel.org>,
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20241008112049.2279307-1-linyunsheng@huawei.com>
 <20241008112049.2279307-2-linyunsheng@huawei.com>
 <cb1acab0-a4c9-4e31-b6f6-70b8049f1663@linuxfoundation.org>
 <f3f882bf-4120-4daa-b35f-8b1b4e0deb2d@huawei.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <f3f882bf-4120-4daa-b35f-8b1b4e0deb2d@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/8/24 21:59, Yunsheng Lin wrote:
> On 2024/10/9 3:56, Shuah Khan wrote:
>> On 10/8/24 05:20, Yunsheng Lin wrote:
>>> The testing is done by ensuring that the fragment allocated
>>> from a frag_frag_cache instance is pushed into a ptr_ring
>>> instance in a kthread binded to a specified cpu, and a kthread
>>> binded to a specified cpu will pop the fragment from the
>>> ptr_ring and free the fragment.
>>>
>>> CC: Alexander Duyck <alexander.duyck@gmail.com>
>>> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
>>> Reviewed-by: Alexander Duyck <alexanderduyck@fb.com>
>>
>> Signed-off-by should be last. Same comment on all the other
> 
> Hi, Shuah
> 
> I used 'git am' to collect those tag, it seems that is the order
> the tool applied, and I checking other applied commit, it seems
> only Signed-off-by from the committer is the last, like the below
> recent mm commit:
> 6901cf55de22
> ff7f5ad7bce4
> 

okay.

>> patches in this series. When you have 4 patches, it is a good
>> practice to add cover-letter.
> 
> I guess the cover-letter meant below?
> https://lore.kernel.org/all/20241008112049.2279307-1-linyunsheng@huawei.com/

Somehow this isn't in my Inbox.

> 
>>

[snip]

> ...
> 
>>> +function run_manual_check()
>>> +{
>>> +    #
>>> +    # Validate passed parameters. If there is wrong one,
>>> +    # the script exists and does not execute further.
>>> +    #
>>> +    validate_passed_args $@
>>> +
>>> +    echo "Run the test with following parameters: $@"
>>
>> Is this marker good enough to isolate the test results in the
>> dmesg? Include the test name in the message.
>>
>>
>>> +    insmod $DRIVER $@ > /dev/null 2>&1
>>> +    echo "Done."
>>
>> Is this marker good enough to isolate the test results in the
>> dmesg? Include the test name in the message.
>>
>>> +    echo "Check the kernel ring buffer to see the summary."
>>
>> Usually the test would run dmesg and filter out the test results
>> from the dmesg and include them in the test script output.
>>
>> You can refer to other tests that do that: powerpc/scripts/hmi.sh
>> is one example.
> 
> Thanks, will check that.

thanks,
-- Shuah

