Return-Path: <netdev+bounces-174193-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50186A5DD1B
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 13:53:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D16216AC1F
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 12:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA75244EA0;
	Wed, 12 Mar 2025 12:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TS76Jfei"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA0723E229
	for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 12:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741783985; cv=none; b=mLmJz1ZaFQ+as9427hLQWlahAy3faeZBtflFy5z8o6VYWIxL9Ns+exdFLyI/efegvulO4jqzEQrJ45LxoCq9s4OVn2DaCID9T54hpT2E2PxrgrfgeOKEFXZowFCsRqiNYGRl7sRtLJilev0gWomzoHXlTzAU5qzsEhG0SIGRfhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741783985; c=relaxed/simple;
	bh=n7rbJMhxVVA2kRRBtSpfYcYzvB4CF6LIap0myCyDGvw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=om9Fx9laC/AoiF1Edj657qfl031asesmT9qApdCeS7CUCt60QtPZfu9+1bV2ToRDflQGFHGbfkCqplN840YkFIpmHWJ4EFZmnTeIoDHftcRexFK5egqHFOX2bnGK8IxzYA5WVyl1wsGg/jj2PIixTTuD6yYYst72LJV0PWxjLi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TS76Jfei; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3914a5def6bso2017769f8f.1
        for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 05:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741783982; x=1742388782; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AxOFRJ5dV1MqeOPQPfMz3AS99k+2/1/mIifOGYFraVU=;
        b=TS76JfeiKup7pLjvRfR6EVvoETe0lOaxlXQ7BQMP9IIMr3rkaGjo1JxQba09ocr3HY
         d0ltPJ5K5ANmngRfVlbsA/K3Z4pcuR05bOFoMKxpGDYJdn8yqAr5myajZ9IUCYDW3brT
         Tw/Ea6lVdyt9BGCefPuR6JPB3lWm10sZWuExCqfrRHuv3zOSiWSNHfIICqvJeZukTEpm
         8LESCA7fko81OJRxviaebPl2a0vqEYG/dXMHDi1JqfMSu0BKw63+gR76etfZF1666vvi
         hCYS8iu/D1iG+epwwmWiF6UwBpgY7DTxFKj7fhtyEU/xPIZ3V7N739mc8u29N3GbZkHH
         T8Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741783982; x=1742388782;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AxOFRJ5dV1MqeOPQPfMz3AS99k+2/1/mIifOGYFraVU=;
        b=XX+BlldkM5pGV7kGqdetBs7MOkgNaPeaoIOh+Wdjuh7XZoWA/usFAi7ZgEn7lUpobc
         46lqTGeRrhUVM/A+WbJ+sDVKwLKRpVsbgkyZrdqpr/2tCgJdR3vOw9rtndJNspK/lV3j
         MeY4KXeZ6stp9MgqnHZb0d/UcjG8arTeIy75jSRVU9aC7o+dQT45VCaAtWU9md0YQ/hb
         U+HYuOGu9wmk+C1yXRDokPaP+t6F3zJ6qEYJXUTkEQI05ssdzoag1smEdv6QcyagbzEm
         4PsHGnxYVgGGnkEpPncvC+soNcrHIfCRMbvVxYkSsgylSm+NXvkeLpmMNPTkhJZdBlyJ
         tudg==
X-Forwarded-Encrypted: i=1; AJvYcCXKAEzwBFe5+kYu5uUbcg/Nr8LRa+Ku/rS0FN5SG+pxRq7ZMaHLkkAJC+SKOM4QkmXCQt/8qp8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg2Ol8TNG62j4ZtuGltfEqBabvk5hYcABGSMdSkh2lJZpzWsCr
	h2mJ2mvVhFxUVCCBqW4zJUl0Mm5hefgM+8yupYu+VYnNRasaBRCA
X-Gm-Gg: ASbGnct4JaT3Ki9Qbm2S41otsWYVPQVhTwYuYoU3ZJGKJz20qjuAuu6+6FYj9FN/rg2
	Sm0UDMn8bpGjG9GBuqjBZiWaZGjqXu0EXrIHI6EHXgAckacCoMnjNJL7NkPHtbSYnWS9ph4UYWV
	7/XUohKu4346adX7u+NLIGoGGzVJhtrknokTG4kNm0VJ8OOCNn5oRNPOF6xrpQlouIwHs+MYlmA
	R53WJFs1PqbQfKEuV8tNOxnt/bvsD4uTxbkyKAkWXXxVhzFK5Uv+mdPeNalG8jpdCdBf+RpSf1a
	G+uvh1pJfb1kVSTTtt3zWVlNvLzJzscmH2XD5nIRKri4g2n1D0ESLyifQdrwzoGaqp4x
X-Google-Smtp-Source: AGHT+IEEgWCjPXRghYAZa+gPXNihB2ZL++gW0z8f0e4WP9GqNq4b4nwhxd2LSxpTg+MzM8uZRnIksw==
X-Received: by 2002:a05:6000:2c5:b0:391:10c5:d1a9 with SMTP id ffacd0b85a97d-39132d82751mr15752267f8f.31.1741783981903;
        Wed, 12 Mar 2025 05:53:01 -0700 (PDT)
Received: from [192.168.116.141] ([148.252.129.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bfdfdc5sm20609379f8f.25.2025.03.12.05.52.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Mar 2025 05:53:01 -0700 (PDT)
Message-ID: <65dd1ce6-1ee3-4678-a156-244e6c0ca127@gmail.com>
Date: Wed, 12 Mar 2025 12:53:53 +0000
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
 Yunsheng Lin <linyunsheng@huawei.com>,
 Yunsheng Lin <yunshenglin0825@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 "David S. Miller" <davem@davemloft.net>
Cc: Yonglong Liu <liuyonglong@huawei.com>,
 Mina Almasry <almasrymina@google.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, linux-mm@kvack.org, netdev@vger.kernel.org
References: <20250308145500.14046-1-toke@redhat.com>
 <d84e19c9-be0c-4d23-908b-f5e5ab6f3f3f@gmail.com> <87cyepxn7n.fsf@toke.dk>
 <2c363f6a-f9e4-4dd2-941d-db446c501885@huawei.com> <875xkgykmi.fsf@toke.dk>
 <136f1d94-2cdd-43f6-a195-b87c55df2110@huawei.com> <87wmcvitq8.fsf@toke.dk>
 <ae07144c-9295-4c9d-a400-153bb689fe9e@huawei.com> <871pv2igd9.fsf@toke.dk>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <871pv2igd9.fsf@toke.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/12/25 12:27, Toke Høiland-Jørgensen wrote:
> Yunsheng Lin <linyunsheng@huawei.com> writes:
...
>>>>> cases where it's absolutely needed.
>>>>
>>>> The above can also be done for using page_pool_item too as the
>>>> lower 2 bits can be used to indicate the pointer in 'struct page'
>>>> is 'page_pool_item' or 'page_pool', I just don't think it is
>>>> necessary yet as it might add more checking in the fast path.
>>>
>>> Yup, did think about using the lower bits to distinguish if it does turn
>>> out that we can't avoid an indirection. See above; it's not actually the
>>
>> The 'memdesc' seems like an indirection to me when using that to shrink
>> 'struct page' to a smaller size.
> 
> Yes, it does seem like we'll end up with an indirection of some kind
> eventually. But let's cross that bridge when we get to it...

At which point it might be easier to avoid all the "bump"s business,
fully embrace net_iov / netmem format, wrap all pp pages into a
structure on the page pool side, and pass that around. That would
remove the indirection for most of the accesses, and the allocation
can be easily cached.

-- 
Pavel Begunkov


