Return-Path: <netdev+bounces-173894-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5199A5C288
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 14:25:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 447243B22B3
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 13:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C1B5680;
	Tue, 11 Mar 2025 13:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f0F0rKui"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1B374BED
	for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 13:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741699461; cv=none; b=cIVjMHo4uVtQt7VGfeQoYhjIjE61Tl68Kh2C+8YY0wUBmyXPIKXOrvwoUMEKy+IRDAMCCXd9mj/Fj47Ya+s27t6O+aDGkZpOtHLmHcCdXAI0iynQxSfxULFs5KDP+X4mqb+LQ+5ZpWH7jNqKXKi/ptdQ8VVc7GQHn3jgZWDm0xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741699461; c=relaxed/simple;
	bh=a+qml/l+P0CYqMejAk7Vj7ahyJ9uQrNqhenaR9eEJ/c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MMX1CSb9HltJp4vIuh/1M0uUdYP0jGeW5ZTwZZaHi/qhjuRmN5OaNUOThyY9RU/CCwv8nMlwiZQJoQvUwHdiu+pEqMcFjlFlFKoRm1Ef6UGTFLwmK5oCYBXrBM4TRqVph1cs+d1nuUstTaUGNcsJVMnNpVCcnN5/XhyEYJkNCAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f0F0rKui; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43cebe06e9eso17756395e9.3
        for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 06:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741699458; x=1742304258; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SB2j+2DJD1bu8gPq0cnVv7W46llV7q01ONp8A9vhfUg=;
        b=f0F0rKuicpW5PGo7NCBN8Zf67L9XpQuQ3xyZ87NdQRg3VgEAf7tJmDirVadq0n57nH
         UkprNvEpEhlJyAXsO76oFNxRrlmyR0cYX+psgW5dKLOT4Y71LYW459NPV7zkjxzIbIf7
         4/+sStySCm+RGvHp2TYO9RSkl4cYz6qGn8qpH8ZfGRWNr0D1OXmEuVxcbrwIK4v+PKrd
         RbaucF9hT7UHOHg3gfw44mE5e6Yei3A253ME2zW31kZzpLDZ87xRFasXpJfX/UAQUqz/
         zpf7tCMn8MwqOzKD/ceSWwNB1n2XL7LSCDz5FfJRPDWRNAhGOq+4LpRgQnX04gdIX4e3
         ggRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741699458; x=1742304258;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SB2j+2DJD1bu8gPq0cnVv7W46llV7q01ONp8A9vhfUg=;
        b=wzXBIq5y1XQBfIFNusnPQPlyp/GClcS3+5FcDjDi2kSUsU6Z//7vdm24Ik8H1bVXSy
         BhdqkzJr4gkCrPvrUhe6Kj+TMVdf6FCQ8gCt51oDz91oTc40kMEtHDkpKw/TWNQExJOx
         migQ3B5myIHmevkFCG4NLVhP8bpphT1gzCmZiNsFPR4j179Y9TciweMHE21nKSbcWDYK
         m+laKmAKXG/PTfgd+utUDIBw7oQzqytnk/9UGT+IsYRkB1H+ohbvdlb7Fv9R5yViNaRV
         hBjjqvAjocWi8Eag8j9gNJlh76A4VApXhlw3tTy5B3ewuhjQPFa/7KpwgB+lEl0rlWfR
         qK3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWawLei/P2w8Jye1Z670tv9JVEcUrD0Nvt8fGIoNx2tIk1G6kurwjHYYqvJiBjYUJoPAJv2Krw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0dQKV9XTa6XyaxhRjbtz/U3ZMed4m1AQ/+wyWHsUTSoXexXFm
	jm+Ra2Kg0TpqLPzbSALyVufKCnBilKAMtJg+EfMLBtQhbM9LHHPmn8QTZypS
X-Gm-Gg: ASbGnctaR4aByAoYjtoykbrbMFJtY4PDGdbFB0jQgl/cz0CKXJLNQKn8Kvwxdq310XQ
	6cVhLmwruqUL94guEGPLmNVJamZ+doERz5jifSEAKIpUhgDE6O9WNjV4WEzzTOlu2AM03oLhLQM
	u6gGIdWd6UtbJXJcIolsS885s0TWAsPNJsNRq8zFajXP8K9EOrKGFstWpMSq8gOWR9Fm+yTizrG
	SeMjL1KR9B/rUXaf+fRTZwOSNQJ6Tej6ElbEUgDYMEtg5aBgDgc4G7fC0sqMUy85U0xIZAY4BmT
	7HRJcPZA9yCSWUdjzOqJdFSwYyHIuFUIRb/NhY296ndNa/C9CengfH5Sww==
X-Google-Smtp-Source: AGHT+IEG41Sh2atWO3RHBfoSb7Tx3IIwYhLEiEKsNbi+A9VfcSbMXi1f7yke56YANW9xiS3CuXBj5g==
X-Received: by 2002:a05:6000:381:b0:391:4ca:490 with SMTP id ffacd0b85a97d-39132d76e70mr12811495f8f.29.1741699457734;
        Tue, 11 Mar 2025 06:24:17 -0700 (PDT)
Received: from [192.168.116.141] ([148.252.129.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c0e2f10sm18253881f8f.65.2025.03.11.06.24.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Mar 2025 06:24:16 -0700 (PDT)
Message-ID: <edc407d1-bd76-4c6b-a2b1-0f1313ca3be7@gmail.com>
Date: Tue, 11 Mar 2025 13:25:11 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next] page_pool: Track DMA-mapped pages and unmap
 them when destroying the pool
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 Mina Almasry <almasrymina@google.com>, David Wei <dw@davidwei.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 "David S. Miller" <davem@davemloft.net>,
 Yunsheng Lin <linyunsheng@huawei.com>, Yonglong Liu
 <liuyonglong@huawei.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, linux-mm@kvack.org, netdev@vger.kernel.org
References: <20250308145500.14046-1-toke@redhat.com>
 <CAHS8izPLDaF8tdDrXgUp4zLCQ4M+3rz-ncpi8ACxtcAbCNSGrg@mail.gmail.com>
 <87cyeqml3d.fsf@toke.dk>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <87cyeqml3d.fsf@toke.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/9/25 12:42, Toke Høiland-Jørgensen wrote:
> Mina Almasry <almasrymina@google.com> writes:
> 
>> On Sat, Mar 8, 2025 at 6:55 AM Toke Høiland-Jørgensen <toke@redhat.com> wrote:
>>>
>>> When enabling DMA mapping in page_pool, pages are kept DMA mapped until
>>> they are released from the pool, to avoid the overhead of re-mapping the
>>> pages every time they are used. This causes problems when a device is
>>> torn down, because the page pool can't unmap the pages until they are
>>> returned to the pool. This causes resource leaks and/or crashes when
>>> there are pages still outstanding while the device is torn down, because
>>> page_pool will attempt an unmap of a non-existent DMA device on the
>>> subsequent page return.
>>>
>>> To fix this, implement a simple tracking of outstanding dma-mapped pages
>>> in page pool using an xarray. This was first suggested by Mina[0], and
>>> turns out to be fairly straight forward: We simply store pointers to
>>> pages directly in the xarray with xa_alloc() when they are first DMA
>>> mapped, and remove them from the array on unmap. Then, when a page pool
>>> is torn down, it can simply walk the xarray and unmap all pages still
>>> present there before returning, which also allows us to get rid of the
>>> get/put_device() calls in page_pool.
>>
>> THANK YOU!! I had been looking at the other proposals to fix this here
>> and there and I had similar feelings to you. They add lots of code
>> changes and the code changes themselves were hard for me to
>> understand. I hope we can make this simpler approach work.
> 
> You're welcome :)
> And yeah, me too!
> 
>>> Using xa_cmpxchg(), no additional
>>> synchronisation is needed, as a page will only ever be unmapped once.
>>>
>>
>> Very clever. I had been wondering how to handle the concurrency. I
>> also think this works.
> 
> Thanks!
> 
>>> To avoid having to walk the entire xarray on unmap to find the page
>>> reference, we stash the ID assigned by xa_alloc() into the page
>>> structure itself, in the field previously called '_pp_mapping_pad' in
>>> the page_pool struct inside struct page. This field overlaps with the
>>> page->mapping pointer, which may turn out to be problematic, so an
>>> alternative is probably needed. Sticking the ID into some of the upper
>>> bits of page->pp_magic may work as an alternative, but that requires
>>> further investigation. Using the 'mapping' field works well enough as
>>> a demonstration for this RFC, though.
>>>
>>
>> I'm unsure about this. I think page->mapping may be used when we map
>> the page to the userspace in TCP zerocopy, but I'm really not sure.
>> Yes, finding somewhere else to put the id would be ideal. Do we really
>> need a full unsigned long for the pp_magic?
> 
> No, pp_magic was also my backup plan (see the other thread). Tried
> actually doing that now, and while there's a bit of complication due to
> the varying definitions of POISON_POINTER_DELTA across architectures,
> but it seems that this can be defined at compile time. I'll send a v2
> RFC with this change.

FWIW, personally I like this one much more than an extra indirection
to pp.

If we're out of space in the page, why can't we use struct page *
as indices into the xarray? Ala

struct page *p = ...;
xa_store(xarray, index=(unsigned long)p, p);

Indices wouldn't be nicely packed, but it's still a map. Is there
a problem with that I didn't consider?

-- 
Pavel Begunkov


