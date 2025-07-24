Return-Path: <netdev+bounces-209680-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36BF3B10593
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 11:18:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9AB41639D7
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 09:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE4C24DCEB;
	Thu, 24 Jul 2025 09:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gOBk0hnz"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2FE15855E
	for <netdev@vger.kernel.org>; Thu, 24 Jul 2025 09:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753348703; cv=none; b=AnnE7vv28NaOhSzJgFjeALMftFcYjMtQJdhypPeR3sgskgl7/RAd/9Q+Hd79IMH5T36LC0w9spFug1rjh3NNX5mq32HPSP+ZaPkMdhvyDimO0RqZtOQKkuBu6f5/d3iXbpv402FCooV4WOKXsMvYbXjzOnc3tUHo+ehKg/REntI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753348703; c=relaxed/simple;
	bh=k4ryQwZrWFdbVrpzPmNt8BN0cErr3tgdmvOIfPNDMj0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p+1BNFPze+1dkVS7YRhPWciymSRv7Tj5ylb0vpFERhYWoXCwYTzXtjFapbalCJcF8kl04V57S7vafUW3tYMl//bp8TtYbym6R0i0ybwNwMFjupTTbaWR993OxYeOS/4+lQmpkeRCc5tijX34arizmqdA5EfzBQP3gZPAdvOPTac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gOBk0hnz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753348699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0u8ERjhlWRPtyJChf6ApY+WNDd3j+X08+pYCOJ6kI6s=;
	b=gOBk0hnzdiXDvGpXuEPxH/13e2i1JjNGVkZBPK9pL1jl73xSxjQzJrengRcq1SgoIRG4U8
	Tef5KLmNHuuH2M46l+f2mOtrt8l+FYXzsxYvYbCGZCVbKitbDD3jId0zXxlkEj1TQ9M9bx
	udQCnybDJ8KnxAHLD7zqOTM5cyYCFo4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-drrjsg4ANWKcf-qziuojhw-1; Thu, 24 Jul 2025 05:18:17 -0400
X-MC-Unique: drrjsg4ANWKcf-qziuojhw-1
X-Mimecast-MFC-AGG-ID: drrjsg4ANWKcf-qziuojhw_1753348696
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-451d7de4ae3so4597395e9.2
        for <netdev@vger.kernel.org>; Thu, 24 Jul 2025 02:18:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753348696; x=1753953496;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0u8ERjhlWRPtyJChf6ApY+WNDd3j+X08+pYCOJ6kI6s=;
        b=r/Ct0GszJ8RELDaZQIKKvq6Qh0C9DYHmhXzMi9snudkHZZI1yEuvB7NqGec06hJ7z9
         nH/CL71vfHBY/3ef8+DMFSrAhuZiYLyVlk8GYPgMkn5lj+BkxMJn7rQJfjUlJ3cdSrEf
         VdBJEw2IZsNrMgHPy66LCF73lgLsWD+R35uSY+5uaqcC8HPmE2Ax6msBuiKNG5DWV0NU
         o8uAS8bUu4Pq6hW3yBP4vl8gPN+2c/0v+qEVkObcXSTpI/qWSjb0Z9FsxORKsji/wnaV
         edS6Fl2z0Xz4Tp5ZeuHpTk690wqRJE0tYoE/bKjZREuOyhsMHUSAu1IQpm72QJEGdrf4
         JpnA==
X-Forwarded-Encrypted: i=1; AJvYcCUZu+a6fiwXpgz0zjDUBCcH0lfCP4vQP1cgjdtjMrcgwjrHl0e3FTxCvDd3njA0ZmyQJTNwAm8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAXCAU5SSPhy68lkrGzHCSnMBxNIPEHGGCMlcMEHoGQYdcGB2H
	Yy4lYsXqQ+CFXw7kUcgnMWelUEu1eUJrvKqbzBnJipWoUm86ygl0eAnTKAcvImOcosOFf+8JKxD
	xp5ZzX8gPNBJUKBLaHKxiBNbf9qxca7DhL0ok3VNIslPilicBqCFvxT7Qvg==
X-Gm-Gg: ASbGncuVYRJ/f79jT6heg8rgrM9LRi/6FYV7xt9DH648C0mln6Quj0Y07i4YW5NMQLD
	Z0MXvZ5FBNHtmNl0lfMEjC5hEUzC6XTn8yryze8sk+TP9wJ9dmkH2FnkV/YQq0eJqjqjR0OG18u
	MMqCRlAW7T/9NQD7uOqRTUAZd9jGC07ub6a+9L/w9WtHz8uFdY2w8g/PoJ7f6GRJh0Yvc5mNbcC
	fPEbYIXXgVvi7Z6Q/1pWpfVRmZIHcZ3Qmm04UhQdruqnmgAQCc53qQQYLSsRMdjPIxBnf9/+cQW
	UpIs7gLpV8UdqXZp9P9ZAx+poeOzh9wNnKpjf3hGk+ibOHC6ZZ6xO7897yCjpV+d5kuonHPny0Z
	56cbVuJX7PY4=
X-Received: by 2002:a05:600c:45c3:b0:43d:b3:fb1 with SMTP id 5b1f17b1804b1-45868d69d8emr54329605e9.27.1753348695925;
        Thu, 24 Jul 2025 02:18:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGswj6iCsZirmRqy+pX9RHAraGdCm1TZF9NrwvdxJuR2oUFg5RXAFuiCvJUdh5Bl4ruR4N8JA==
X-Received: by 2002:a05:600c:45c3:b0:43d:b3:fb1 with SMTP id 5b1f17b1804b1-45868d69d8emr54329235e9.27.1753348695478;
        Thu, 24 Jul 2025 02:18:15 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b76fcad22asm1571531f8f.53.2025.07.24.02.18.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 02:18:15 -0700 (PDT)
Message-ID: <b772e896-5e73-4904-b6c7-8ed913198b02@redhat.com>
Date: Thu, 24 Jul 2025 11:18:13 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: virtio_close() stuck on napi_disable_locked()
To: Zigit Zo <zuozhijie@bytedance.com>, Jakub Kicinski <kuba@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <c5a93ed1-9abe-4880-a3bb-8d1678018b1d@redhat.com>
 <20250722145524.7ae61342@kernel.org>
 <4e3e39ea-b4ae-4785-a8ca-346b66e80a9e@bytedance.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <4e3e39ea-b4ae-4785-a8ca-346b66e80a9e@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/24/25 10:58 AM, Zigit Zo wrote:
> On 7/23/25 5:55 AM, Jakub Kicinski wrote:
>> On Tue, 22 Jul 2025 13:00:14 +0200 Paolo Abeni wrote:
>>> The NIPA CI is reporting some hung-up in the stats.py test caused by the
>>> virtio_net driver stuck at close time.
>>>
>>> A sample splat is available here:
>>>
>>> https://netdev-3.bots.linux.dev/vmksft-drv-hw-dbg/results/209441/4-stats-py/stderr
>>>
>>> AFAICS the issue happens only on debug builds.
>>>
>>> I'm wild guessing to something similar to the the issue addressed by
>>> commit 4bc12818b363bd30f0f7348dd9ab077290a637ae, possibly for tx_napi,
>>> but I could not spot anything obvious.
>>>
>>> Could you please have a look?
>>
>> It only hits in around 1 in 5 runs. Likely some pre-existing race, but
>> it started popping up for us when be5dcaed694e ("virtio-net: fix
>> recursived rtnl_lock() during probe()") was merged. It never hit before.
>> If we can't find a quick fix I think we should revert be5dcaed694e for
>> now, so that it doesn't end up regressing 6.16 final.
> 
> Just found that there's a new test script `netpoll_basic.py`. Before 209441,
> this test did not exist at all, I randomly picked some test results prior to
> its introduction and did not find any hung logs. Is it relevant?

If I read correctly the nipa configuration, it executes the tests in
sequence. `netpoll_basic.py` runs just before `stats.py`, so it could
cause failure if it leaves some inconsistent state - but not in a
deterministic way, as the issue is sporadic.

Technically possible, IMHO unlikely. Still it would explain why I can't
repro the issue here. With unlimited time available could be worthy
validating if the issue could be reproduced running the 2 tests in sequence.

/P


