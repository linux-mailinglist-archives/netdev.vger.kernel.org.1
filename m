Return-Path: <netdev+bounces-133792-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA4A29970C8
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 18:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B21B281865
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 16:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B09C204930;
	Wed,  9 Oct 2024 15:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="wmPbVs3/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9E72040AF
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 15:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728489017; cv=none; b=n/d32tn9OC/WEpbVy/xchBHO+HSu+watSxdJZMS37ll5u5LdZUa64C2XY97R7sG1XpJ4xkEGaKREOWL7TbUF2K4JtkhWSPY0AU4gIdkDJLww3UF+RZmPU+p0eaw4S/bI1C5LJilw2n/IDEnfMJ1+FI4nSMhMI56VPYnlqrNJaXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728489017; c=relaxed/simple;
	bh=87IU3fO+OOiFiPRhzP3EvAF6Nn44dN9XhTevNVHbxKc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rY2ojpfx7PNV2EWNPw6d3ag+Zyp4wWzLPvFAfIfXZ9aKlMbtt0xpXMm2tr9Fx8Jub+MqJGwrgfvOdqcemnGOWtjYCwKUlJmh6Xntnn+PRjq4DBNG5qiT9eFR/vXdmJDqzE6IbA7SeGMijdtLzhfFmBOPx4pToxt20hXWAaaKl74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=wmPbVs3/; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-8354599fd8aso21446439f.1
        for <netdev@vger.kernel.org>; Wed, 09 Oct 2024 08:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1728489015; x=1729093815; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dUQid9fopSTVX9z/0RNlNDofdRwoniQQdjCWe3pwaCE=;
        b=wmPbVs3/9Fa1NTGbCMcsMn7T7oAxuS7eLJw3S8ZVIZJ/+PjWuJKitn9IAJeGmQtVgS
         4zd2VxtVbPR3QTGriZZDJCzv+Ke1BwY43zK1a5Wl5E9AvHkHruOxzeD8Og1usPycWz9Q
         WMOjj9hZ+rzWA+zd6yG7Ki3f/YOSda10h5wu8jvSPzSgAMHsuLyNWNZ6aNo+vM3ejST3
         uHzs0tZW78uQnkYJ/NbDi/yKH8m4J4fY9JkAIYKyZvU65kb5IRAznLp0P3zm2sjbIAm1
         7ntI+fo5lrEg9Y/8RfWcDLstdHFh4p2f7usjQW0YleiNZcUrkfm6zMFDRnY+N9wI9Ln5
         lRbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728489015; x=1729093815;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dUQid9fopSTVX9z/0RNlNDofdRwoniQQdjCWe3pwaCE=;
        b=L5obnuH8pJ/rZKcWud3XgzGWvY0cR9bnwuc/OEAN2Fvr9MAGHXXW2OgSah3l/Rn5VS
         J7fBW2WlHHeEW9zHHT2EJ2CBWeg/XR9xu7WStrRYQsgOPd+/Q/VjwXmc2ck7VmX3J+bC
         u5NC1/ocKkBn546gYOTgmZ7AEnyGHmhz1tVzZRaK6lp4irHv4y8Sj/FXXH4EhqqwIHs/
         Lr+8yuP5ajnrazkkQPzi5ipw3ullRs5TPFjLrvXthsTYGE2UUnV9QS7s3iNakmxq6kou
         v+xWeZkI/eMSr6j9wsV/w2kzcBJN4VjRL+8JLDwyXbKexxk+ifYYnXok0JzYfPj5CMEA
         oBqA==
X-Forwarded-Encrypted: i=1; AJvYcCWqV2YSFUne/UEwkzwTfQhvPxZlNUE2qdkrbOOI/xsI5wdwnStpMSQWMARE++jWgsmE3sYvwcA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpSp8xbMwyhfOkRNRMvaM0+q4Esrk5IER++VkXONGqgQf3Hzm3
	JJ7/4zS0gpXv/vxYVkJqqffzqN/rqUfEwwVLNHoVuuLGXVLAfRffBMzfTX2ZujI=
X-Google-Smtp-Source: AGHT+IGm3N2QGoEjawkQwChQyRQKeX2kzJ+1pi6LjAgd+9jwQW/P+R4cFuLTjtuXN83wobRL5ig9dw==
X-Received: by 2002:a05:6602:1555:b0:82d:129f:acb6 with SMTP id ca18e2360f4ac-8353d5125a7mr276236939f.14.1728489014923;
        Wed, 09 Oct 2024 08:50:14 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-83503a91bc9sm223495939f.16.2024.10.09.08.50.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2024 08:50:14 -0700 (PDT)
Message-ID: <3ec395f8-6271-4fa1-b981-7bfcda26eea0@kernel.dk>
Date: Wed, 9 Oct 2024 09:50:13 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 00/15] io_uring zero copy rx
To: Pavel Begunkov <asml.silence@gmail.com>, David Ahern
 <dsahern@kernel.org>, David Wei <dw@davidwei.uk>, io-uring@vger.kernel.org,
 netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Mina Almasry <almasrymina@google.com>
References: <20241007221603.1703699-1-dw@davidwei.uk>
 <2e475d9f-8d39-43f4-adc5-501897c951a8@kernel.dk>
 <93036b67-018a-44fb-8d12-7328c58be3c4@kernel.org>
 <2144827e-ad7e-4cea-8e38-05fb310a85f5@kernel.dk>
 <b57dd3b9-b607-46ab-a2d0-98aedb2772f7@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <b57dd3b9-b607-46ab-a2d0-98aedb2772f7@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/9/24 9:49 AM, Pavel Begunkov wrote:
> On 10/9/24 16:43, Jens Axboe wrote:
>> On 10/9/24 9:38 AM, David Ahern wrote:
>>> On 10/9/24 9:27 AM, Jens Axboe wrote:
>>>> On 10/7/24 4:15 PM, David Wei wrote:
>>>>> ===========
>>>>> Performance
>>>>> ===========
>>>>>
>>>>> Test setup:
>>>>> * AMD EPYC 9454
>>>>> * Broadcom BCM957508 200G
>>>>> * Kernel v6.11 base [2]
>>>>> * liburing fork [3]
>>>>> * kperf fork [4]
>>>>> * 4K MTU
>>>>> * Single TCP flow
>>>>>
>>>>> With application thread + net rx softirq pinned to _different_ cores:
>>>>>
>>>>> epoll
>>>>> 82.2 Gbps
>>>>>
>>>>> io_uring
>>>>> 116.2 Gbps (+41%)
>>>>>
>>>>> Pinned to _same_ core:
>>>>>
>>>>> epoll
>>>>> 62.6 Gbps
>>>>>
>>>>> io_uring
>>>>> 80.9 Gbps (+29%)
>>>>
>>>> I'll review the io_uring bits in detail, but I did take a quick look and
>>>> overall it looks really nice.
>>>>
>>>> I decided to give this a spin, as I noticed that Broadcom now has a
>>>> 230.x firmware release out that supports this. Hence no dependencies on
>>>> that anymore, outside of some pain getting the fw updated. Here are my
>>>> test setup details:
>>>>
>>>> Receiver:
>>>> AMD EPYC 9754 (recei
>>>> Broadcom P2100G
>>>> -git + this series + the bnxt series referenced
>>>>
>>>> Sender:
>>>> Intel(R) Xeon(R) Platinum 8458P
>>>> Broadcom P2100G
>>>> -git
>>>>
>>>> Test:
>>>> kperf with David's patches to support io_uring zc. Eg single flow TCP,
>>>> just testing bandwidth. A single cpu/thread being used on both the
>>>> receiver and sender side.
>>>>
>>>> non-zc
>>>> 60.9 Gbps
>>>>
>>>> io_uring + zc
>>>> 97.1 Gbps
>>>
>>> so line rate? Did you look at whether there is cpu to spare? meaning it
>>> will report higher speeds with a 200G setup?
>>
>> Yep basically line rate, I get 97-98Gbps. I originally used a slower box
>> as the sender, but then you're capped on the non-zc sender being too
>> slow. The intel box does better, but it's still basically maxing out the
>> sender at this point. So yeah, with a faster (or more efficient sender),
>> I have no doubts this will go much higher per thread, if the link bw was
>> there. When I looked at CPU usage for the receiver, the thread itself is
>> using ~30% CPU. And then there's some softirq/irq time outside of that,
>> but that should ammortize with higher bps rates too I'd expect.
>>
>> My nic does have 2 100G ports, so might warrant a bit more testing...
> If you haven't done it already, I'd also pin softirq processing to
> the same CPU as the app so we measure the full stack. kperf has an
> option IIRC.

I thought that was the default if you didn't give it a cpu-off option?
I'll check...

-- 
Jens Axboe

