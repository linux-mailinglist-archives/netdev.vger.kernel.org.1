Return-Path: <netdev+bounces-95030-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D91F78C144B
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 19:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B8E3B22D0B
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 17:47:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B5676F1D;
	Thu,  9 May 2024 17:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="rO5DX1yh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07458FBFD
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 17:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715276819; cv=none; b=MNSlykDwr2fFlmqEp+0zn8CKSCbChSK0VeqL8ErdCo2BF7tB5bNhw0cc9FhuqW5lDgbcKrO23g2ejonTDQTYF4TrJ0o9kRA9eDX23Ws5eDCCM2J0nju+oU35IGYYgvmJnN2vjmQ3L6+C1shAaj1QYdp9ZLmsNpAgdkxcjfy3C40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715276819; c=relaxed/simple;
	bh=gJ68XP9RLJtQXdROFvBjcsoAUV8wtAuSKfD1zG78Lvg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=htd0xLgQNesIxR8Nb0X1PRREYHlWe6RusaDTI7kxQxsEdIqLXFh+mICFk7nk1qkGEhuXnFsEaiHdm0fZQhtDLp3IWAq0RG4KWJfQTFWNYQN7Kbu2JfrA8p7ioqXfHkdkLGIwafioqaW3UD5e+CdqjMj3IM87KX5+TLPUfKZQoWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=rO5DX1yh; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-53fa455cd94so892406a12.2
        for <netdev@vger.kernel.org>; Thu, 09 May 2024 10:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1715276817; x=1715881617; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0gjM2LdJtSH/C4elUqmT8FA1WeyKpXQeqAMznEHvXNI=;
        b=rO5DX1yhm4Msl6Ogp8zDeNPOODJ4eM074i+ecFj6dZ+tf3U8Gjyn4uY1r0YAmOyt1j
         xrdKxqCUGhWN6A87lGzfDCxAR+T7cOHW62KaMxqcCceGwE8os5HCzkyT6ZRK2Ri1ou+i
         QeyGeIJvki0LUF7te081BG3LBnV2FXSb/Ek561dvBUkn8MMO697/o4duman95YZRKxIH
         AvWUEWTDLZfbgyMzdtO/TdF/cWKBHEHhletfMTEbtmvLcw63sc5Ca7evmW4V1p6p8CKL
         rUlpjK3fRC6RgCH7fYvKbALGEYlnrbnFMkRoV827cId1URSsr3Duns5xYmkeID7d0QYD
         CSUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715276817; x=1715881617;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0gjM2LdJtSH/C4elUqmT8FA1WeyKpXQeqAMznEHvXNI=;
        b=GdyJ6gctiSSh/a5aY6W29mluQunWVEZsVTs/aCtY6g8cXzZi9PHquePWesp3SR/vTt
         3T/HzEJbt6skM6MJMgMOACr8LQZAZPGcYN3/YwK/ESY72r0K32nRfbX8uKBTv3q5LzYa
         NXbCnQ3Xo52aZqBxYZEzq+YGIWlEVV0FpYfFUdxq/ZRYENB7ytf+HYVa3wnrvgTiKDGE
         /xZq2ZZm5hEy01JYbVefCsTutbEXhhMLdXvWv6M/XhsqC1p6Yp4bRKOKPU+dKqOGE8k3
         aTxxfrcn10Ula+vx+OIpt+2PJEsvzEzJnGf72srN1NJ5umNT4aXgfC0RoRURTXHHep+F
         xHUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXm2Vaze2ttERkUsHxN9LcQl4PrZhjVg8W3rc0Lfznos5CPYxzgpuNBjxugU0zLAKN2GQBSXGBHHjM+MJy9mTjYXAJ9PiQn
X-Gm-Message-State: AOJu0YyCAo2UvxArnd7aZUBf7oXdhJKlWt++f0P0xnsMQ4vUZT8gR67Z
	XuziDFy8jgNP+tq9WtQIx74HWyuZDyZ/qnzweGhxoWTolP6vEZrW66vtVIsIxNo=
X-Google-Smtp-Source: AGHT+IHYrINHCKLkmYBXOVWfHmC+FOaP22v9Do63Vd0ALuhzlZv64zUR1Quo7gu06s98dQpTEj6zcg==
X-Received: by 2002:a17:90a:b101:b0:2a2:7edd:19b7 with SMTP id 98e67ed59e1d1-2b6cc7805e1mr165346a91.27.1715276817092;
        Thu, 09 May 2024 10:46:57 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1256:2:c51:2090:e106:83fa? ([2620:10d:c090:500::5:c55])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b628849965sm3621991a91.15.2024.05.09.10.46.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 May 2024 10:46:56 -0700 (PDT)
Message-ID: <246d09a5-e3f2-425a-be68-8abbe3c98eb3@davidwei.uk>
Date: Thu, 9 May 2024 10:46:54 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 10/10] gve: Implement queue api
Content-Language: en-GB
To: Mina Almasry <almasrymina@google.com>
Cc: Shailend Chand <shailend@google.com>, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, hramamurthy@google.com,
 jeroendb@google.com, kuba@kernel.org, pabeni@redhat.com,
 pkaligineedi@google.com, rushilg@google.com, willemb@google.com,
 ziweixiao@google.com
References: <20240501232549.1327174-1-shailend@google.com>
 <20240501232549.1327174-11-shailend@google.com>
 <43d7196e-e2f5-4568-b88b-c66e51218b2b@davidwei.uk>
 <CAHS8izOYj-_KKgpPm7Tn3SkcqAjkU1b4h9nkRpPj+wMyQ23JqA@mail.gmail.com>
 <320a7d5f-f932-467b-a874-dbd2d8319b9f@davidwei.uk>
 <CAHS8izO4EjXB4U=oq0zFTdJRnqXPzRJLo9fVqtSHPAFnKoU9aQ@mail.gmail.com>
From: David Wei <dw@davidwei.uk>
In-Reply-To: <CAHS8izO4EjXB4U=oq0zFTdJRnqXPzRJLo9fVqtSHPAFnKoU9aQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2024-05-08 10:09, Mina Almasry wrote:
> On Tue, May 7, 2024 at 2:06 PM David Wei <dw@davidwei.uk> wrote:
>>
>> On 2024-05-06 11:47, Mina Almasry wrote:
>>> On Mon, May 6, 2024 at 11:09 AM David Wei <dw@davidwei.uk> wrote:
>>>>
>>>> On 2024-05-01 16:25, Shailend Chand wrote:
>>>>> The new netdev queue api is implemented for gve.
>>>>>
>>>>> Tested-by: Mina Almasry <almasrymina@google.com>
>>>>> Reviewed-by:  Mina Almasry <almasrymina@google.com>
>>>>> Reviewed-by: Praveen Kaligineedi <pkaligineedi@google.com>
>>>>> Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
>>>>> Signed-off-by: Shailend Chand <shailend@google.com>
>>>>> ---
>>>>>  drivers/net/ethernet/google/gve/gve.h        |   6 +
>>>>>  drivers/net/ethernet/google/gve/gve_dqo.h    |   6 +
>>>>>  drivers/net/ethernet/google/gve/gve_main.c   | 177 +++++++++++++++++--
>>>>>  drivers/net/ethernet/google/gve/gve_rx.c     |  12 +-
>>>>>  drivers/net/ethernet/google/gve/gve_rx_dqo.c |  12 +-
>>>>>  5 files changed, 189 insertions(+), 24 deletions(-)
>>>>>
>>>>
>>>> [...]
>>>>
>>>>> +static const struct netdev_queue_mgmt_ops gve_queue_mgmt_ops = {
>>>>> +     .ndo_queue_mem_size     =       sizeof(struct gve_rx_ring),
>>>>> +     .ndo_queue_mem_alloc    =       gve_rx_queue_mem_alloc,
>>>>> +     .ndo_queue_mem_free     =       gve_rx_queue_mem_free,
>>>>> +     .ndo_queue_start        =       gve_rx_queue_start,
>>>>> +     .ndo_queue_stop         =       gve_rx_queue_stop,
>>>>> +};
>>>>
>>>> Shailend, Mina, do you have code that calls the ndos somewhere?
>>>
>>> I plan to rebase the devmem TCP series on top of these ndos and submit
>>> that, likely sometime this week. The ndos should be used from an
>>> updated version of [RFC,net-next,v8,04/14] netdev: support binding
>>> dma-buf to netdevice
>>
>> Now that queue API ndos have merged, could you please send this as a
>> separate series and put it somewhere where it can be re-used e.g.
>> netdev_rx_queue.c?
>>
> 
> Definitely happy to put it in a generic place like netdev_rx_queue.c
> like you did, but slight pushback to putting it into its own series.
> With the ndos merged finally, I can take our devmem TCP series out of
> RFC and I am eager to do so. Making it dependent on a change that is
> in another series means it must remain RFC.
> 
> What I can do here is put this change into its own patch in the devmem
> TCP series. Once that is reviewed the maintainers may apply that patch
> out of the series. I can also put it in its own series and keep devmem
> TCP in RFC for now if you insist :D

No, that's fine. Please put it at the front of the series once you're
ready. I'll cherrypick it into our series.

> 
> 

