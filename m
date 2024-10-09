Return-Path: <netdev+bounces-133828-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 284719972C3
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 19:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E47B2281679
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 17:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71931E0E15;
	Wed,  9 Oct 2024 17:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="pYf7ZjRk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0164B1E04AB
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 17:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728493981; cv=none; b=dqKuLS1NofhLniv+Ori6Z911VsXqIJb8Wy10ykdHi/83rn/kxxHBP+erzvGEVSkYumTHO91VmFrR0CYIuLgklhepcdZagH0yISUjJ4d1G3Nm48sZ5Plt4ZdnmFzJcVYixSiSFayyqZ0hYQ4OLpyO8xcXkhaW+G2OOegYIL4iq4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728493981; c=relaxed/simple;
	bh=4u062a7juDDNtgmOtcx1kqq5FQfnoz7Py7zSBS4eE3c=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=avfzc8HZOHRyhGG/2HmwjRV3oUfYrVNb4J2wMCwcvIfR7rPEcudHAnTBwHmn5BbzVkMKo/siIcjw5bKqWyPIuqrFWZEmlx/9CrybyiuHeM09rBTUVSX2EIbU0gwGHSDUiNr6CKcQjbcgsTJzprDNpssRVaXAnJ3uA46x+ZMw8tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=pYf7ZjRk; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-8353f5862a7so287139f.2
        for <netdev@vger.kernel.org>; Wed, 09 Oct 2024 10:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1728493979; x=1729098779; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uQ0ziA+/Q9rPIOTqtgTrSfiD/AQJeJPFey2nSipe5OM=;
        b=pYf7ZjRk+cFKGHTDdxkwr55mVCZpJ1MoRVDRkap8UdTdW8T1WQrJyspOcKDI8pnfMl
         8VPQUZkT858j2ACoKpSGsFzrM6DlcFCiJUhjB4dfS+TCW+gglod9PmlPGTrXw4ukCr+l
         yuCE9tc41vBjVWAH4HNLRpTZW7P7vzKjzI5dPKF/3GriytYz1/DZDUb093uGzLmipi9t
         CWslVUdnrjBLmUyGgQMtucqsUQI2TH40FwigcjClfS/xJhnWTIJOhTfyi5UrD5oowZ4m
         ylTsX4BmKHhAHdJ0gUuZ5wCxKk1wk4LqUnz7UELPODxO1PXLIFevyrqCgyAbebxh8ACh
         lUEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728493979; x=1729098779;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uQ0ziA+/Q9rPIOTqtgTrSfiD/AQJeJPFey2nSipe5OM=;
        b=NMxCWfLUvn4qk2MyJfrIWXTCc8WbS8ECgSR3VH3OA6SjI9xZSq86485BNKu/TwzrQo
         cCo9m+1yWWYUfJ27qPR95NqzB87Tqe6AVqmvyhcM56GWJ2cVSpGQQ4PA0XpOSxc/IODM
         7lrnYaRTpnrz6SzYwb5pvKLHUQzH7s5IDNXzfjbYa9hFx/fiLAGQhjT2KIRr75HtmVDB
         EmIXa4E8v+phWCoYQlHwMACmFEX3fDBbGlLPE8D70SinH6xuYODFrPI7ulcegmagrfX2
         BHhMAPOXVnMWIY+cITfu3tZYN5Ryt2rhVaR1HoX5CeoIlkzcFZy8U3Lt3WDm2BR5behz
         9pnw==
X-Forwarded-Encrypted: i=1; AJvYcCVLIuCRbn5m9Cee1MdELMbuXU8RSllCkYc8Mqm4TUsQFwdS0NZFZX4U2W322rAxuqejRnI/twc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5iLe7pkoO7Hn6upiFfGZ3CdlVfevxpGR+LfqW5AxBhmRNKEqR
	5wOLJ/pxAZbbGV72RyI/+9yNKynDCaNqU2Wkx5SfweVNYi61aXvVrMhPxDxN4jE=
X-Google-Smtp-Source: AGHT+IFhpKNGgR0dkZcJUtav53xbAPFZv/mgXH3EhV8u+mqRPQq96Rx3Zgqs2lYDyKIF5Bhg9e9mOQ==
X-Received: by 2002:a05:6602:2c0a:b0:82d:9b0:ecb7 with SMTP id ca18e2360f4ac-8353d47c5e9mr386871439f.3.1728493978705;
        Wed, 09 Oct 2024 10:12:58 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4db6ec73d77sm2134872173.176.2024.10.09.10.12.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Oct 2024 10:12:57 -0700 (PDT)
Message-ID: <b8fd4a5b-a7eb-45a7-a2f4-fce3b149bd5b@kernel.dk>
Date: Wed, 9 Oct 2024 11:12:56 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 00/15] io_uring zero copy rx
From: Jens Axboe <axboe@kernel.dk>
To: David Ahern <dsahern@kernel.org>, David Wei <dw@davidwei.uk>,
 io-uring@vger.kernel.org, netdev@vger.kernel.org
Cc: Pavel Begunkov <asml.silence@gmail.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Mina Almasry <almasrymina@google.com>
References: <20241007221603.1703699-1-dw@davidwei.uk>
 <2e475d9f-8d39-43f4-adc5-501897c951a8@kernel.dk>
 <93036b67-018a-44fb-8d12-7328c58be3c4@kernel.org>
 <2144827e-ad7e-4cea-8e38-05fb310a85f5@kernel.dk>
 <3b2646d6-6d52-4479-b082-eb6264e8d6f7@kernel.org>
 <57391bd9-e56e-427c-9ff0-04cb49d2c6d8@kernel.dk>
 <d0ba9ba9-8969-4bf6-a8c7-55628771c406@kernel.dk>
Content-Language: en-US
In-Reply-To: <d0ba9ba9-8969-4bf6-a8c7-55628771c406@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/9/24 10:53 AM, Jens Axboe wrote:
> On 10/9/24 10:50 AM, Jens Axboe wrote:
>> On 10/9/24 10:35 AM, David Ahern wrote:
>>> On 10/9/24 9:43 AM, Jens Axboe wrote:
>>>> Yep basically line rate, I get 97-98Gbps. I originally used a slower box
>>>> as the sender, but then you're capped on the non-zc sender being too
>>>> slow. The intel box does better, but it's still basically maxing out the
>>>> sender at this point. So yeah, with a faster (or more efficient sender),
>>>
>>> I am surprised by this comment. You should not see a Tx limited test
>>> (including CPU bound sender). Tx with ZC has been the easy option for a
>>> while now.
>>
>> I just set this up to test yesterday and just used default! I'm sure
>> there is a zc option, just not the default and hence it wasn't used.
>> I'll give it a spin, will be useful for 200G testing.
> 
> I think we're talking past each other. Yes send with zerocopy is
> available for a while now, both with io_uring and just sendmsg(), but
> I'm using kperf for testing and it does not look like it supports it.
> Might have to add it... We'll see how far I can get without it.

Stanislav pointed me at:

https://github.com/facebookexperimental/kperf/pull/2

which adds zc send. I ran a quick test, and it does reduce cpu
utilization on the sender from 100% to 95%. I'll keep poking...

-- 
Jens Axboe

