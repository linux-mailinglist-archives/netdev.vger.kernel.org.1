Return-Path: <netdev+bounces-135708-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A09AC99EF94
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 16:29:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7831B21AFC
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 14:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B070A1B21A6;
	Tue, 15 Oct 2024 14:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jERtut1m"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61BA1B21B6;
	Tue, 15 Oct 2024 14:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729002549; cv=none; b=l1JKTi9gfFh87/lsEdJ+Z+WqHd6wM2Nk/E1PqzuaEqvc4P3+hI2m59umoN6FlD7zfZBU0it7ZUn6r61Rk3qP6gu5UKEBGnL0xgg/SnHBdw56VwdDm62BCJ+1loouJDgLJLiSwPdnadfAwuTmJgCxg/tUdy59So4ZwxVPJHprms0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729002549; c=relaxed/simple;
	bh=KYhwTzqpLb3lImYFAZDBipsuDoqTNhV85Vy2bPxqQRI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V398lcLH/8+WmPx/SZV3O6qlIQ0ad+A3f4FyhniB20B36pCmMVZreyGt0evxB3+ZWfnUOKaibH72XIo1aBwcm2xA8rkgSuaAl32Jx75D7ZdCRmLndiJeTX4obhPn76t5SOqOAXJhN0GKvHI6AL1oC5aAkrcbtBp8kNLyetf2qoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jERtut1m; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2fb498a92f6so26977741fa.1;
        Tue, 15 Oct 2024 07:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729002546; x=1729607346; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uJ3WPqH7t2kr/rB0FU+Ti9b525bP9DvSRI19vimoyX4=;
        b=jERtut1m4zw+Vs3Ywytj0e8/KMJfArgEKLTwU/mVHRpfpFVH2CoLimoVsajt0lSOzq
         hwlxaYwK/vLhlfkYstTntqAPuK2x/LB8OT9V/Q103u13P2Gp2Uz2ajbUWidEzDsZOVye
         qLe0sqQUb+9p2rDiAHeMIiNc88X1lL9hECldPqnBNyCwEwpkvexchtPCTfF0C8aEf488
         Am6bwIn9cmnrGGG4YF8A28OIsMvmxoXySAfcTm4lir1dJvK17KIrJc1eW+bosik96I+I
         s5e/bZ3uwP8HUJCIY1MW+Cl1DaW3W5As8aQyMkb4dF3RPjsHXO3zNZ9cc+gqZkv+14zU
         CZ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729002546; x=1729607346;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uJ3WPqH7t2kr/rB0FU+Ti9b525bP9DvSRI19vimoyX4=;
        b=e8a0Jt5ryUIFDicCY1LMsWu/FZvoVat+foL0T4caK2CRgV2dYNb04OQM+qdDb+0EBh
         pIhrTO00Ua992VV0V8bVhvN1tKAtjfbHljFAWwpNYZFiGi6OtAXCLbrsEUTswlmscl1A
         05t2zTPjR+e7vMuX86darpLRJAXvquYWKOxItl7GuOsvwaetdqvcV4fHzjEnrxb7P5Wm
         l/HLPCbxetCMwAnpzSlkYGBzJfPzTlgYeY7M0w1s8lLODAKMW/GuyfHr3PaIreF6pbYL
         iCdpeb/u2Vewg3d2BMF0iMdQnD30n7ERrOvn2Cg16V2izBq1fHjD2YUhWiqVHtlPeQcD
         I5Bg==
X-Forwarded-Encrypted: i=1; AJvYcCUHpmzfrqmAXa6gCdujeRZc3qFOJgWB9RfpdBLqIJq3jmha89K6QIzuJL8zKLxCdhVhd9rnDWgnfz4=@vger.kernel.org, AJvYcCWfAVtFabT1lJKPwjwwpB0TFdhHPpAFqk/2H/TzyJP0ZQkMpg2CYpKH5xL81wnW8zzoYXUPe+tR@vger.kernel.org
X-Gm-Message-State: AOJu0Yw02qjoLk/ftB3ce6GOcMLOX8r6l+zaEgGy7Kq+TqZTlTLoccZV
	LVaEuz6oeIFXfPR0NQurHajYYqQizjdiEwEqn+EJvgOOaDw7yxbk
X-Google-Smtp-Source: AGHT+IGcbBiMI4F6YjYfM1LEwylKFySObFXpHZ9WlRvmAO3s1TFz18qgRgz+4T0NZDJ9DycqoC8MEg==
X-Received: by 2002:a2e:4c1a:0:b0:2fb:5014:c963 with SMTP id 38308e7fff4ca-2fb61b6e100mr3754801fa.20.1729002545380;
        Tue, 15 Oct 2024 07:29:05 -0700 (PDT)
Received: from [192.168.42.212] ([85.255.233.136])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c98d4d6269sm770716a12.2.2024.10.15.07.29.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Oct 2024 07:29:04 -0700 (PDT)
Message-ID: <75b16ab0-07c0-41d8-9285-0511a10629f7@gmail.com>
Date: Tue, 15 Oct 2024 15:29:26 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 7/7] bnxt_en: add support for device memory
 tcp
To: Mina Almasry <almasrymina@google.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: Leon Romanovsky <leonro@nvidia.com>, Jakub Kicinski <kuba@kernel.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Samiullah Khawaja <skhawaja@google.com>, Taehee Yoo <ap420073@gmail.com>,
 davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org, donald.hunter@gmail.com,
 corbet@lwn.net, michael.chan@broadcom.com, kory.maincent@bootlin.com,
 andrew@lunn.ch, maxime.chevallier@bootlin.com, danieller@nvidia.com,
 hengqi@linux.alibaba.com, ecree.xilinx@gmail.com,
 przemyslaw.kitszel@intel.com, hkallweit1@gmail.com, ahmed.zaki@intel.com,
 paul.greenwalt@intel.com, rrameshbabu@nvidia.com, idosch@nvidia.com,
 kaiyuanz@google.com, willemb@google.com, aleksander.lobakin@intel.com,
 dw@davidwei.uk, sridhar.samudrala@intel.com, bcreeley@amd.com
References: <20241003160620.1521626-1-ap420073@gmail.com>
 <20241003160620.1521626-8-ap420073@gmail.com>
 <CAHS8izO-7pPk7xyY4JdyaY4hZpd7zerbjhGanRvaTk+OOsvY0A@mail.gmail.com>
 <CAMArcTU61G=fexf-RJDSW_sGp9dZCkJsJKC=yjg79RS9Ugjuxw@mail.gmail.com>
 <20241008125023.7fbc1f64@kernel.org>
 <CAMArcTWVrQ7KWPt+c0u7X=jvBd2VZGVLwjWYCjMYhWZTymMRTg@mail.gmail.com>
 <20241009170102.1980ed1d@kernel.org>
 <CAHS8izMwd__+RkW-Nj3r3uG4gmocJa6QEqeHChzNXux1cbSS=w@mail.gmail.com>
 <20241010183440.29751370@kernel.org>
 <CAHS8izPuWkSmp4VCTYm93JB9fEJyUTztcT5u3UMX4b8ADWZGrA@mail.gmail.com>
 <20241011234227.GB1825128@ziepe.ca>
 <CAHS8izNzK4=6AMdACfn9LWqH9GifCL1vVxH1y2DmF9mFZbB72g@mail.gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <CAHS8izNzK4=6AMdACfn9LWqH9GifCL1vVxH1y2DmF9mFZbB72g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/14/24 23:38, Mina Almasry wrote:
> On Sat, Oct 12, 2024 at 2:42 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>>
>> On Fri, Oct 11, 2024 at 10:33:43AM -0700, Mina Almasry wrote:
>>> On Thu, Oct 10, 2024 at 6:34 PM Jakub Kicinski <kuba@kernel.org> wrote:
>>>>
>>>> On Thu, 10 Oct 2024 10:44:38 -0700 Mina Almasry wrote:
>>>>>>> I haven't thought the failure of PP_FLAG_DMA_SYNC_DEV
>>>>>>> for dmabuf may be wrong.
>>>>>>> I think device memory TCP is not related to this flag.
>>>>>>> So device memory TCP core API should not return failure when
>>>>>>> PP_FLAG_DMA_SYNC_DEV flag is set.
>>>>>>> How about removing this condition check code in device memory TCP core?
>>>>>>
>>>>>> I think we need to invert the check..
>>>>>> Mina, WDYT?
>>>>>
>>>>> On a closer look, my feeling is similar to Taehee,
>>>>> PP_FLAG_DMA_SYNC_DEV should be orthogonal to memory providers. The
>>>>> memory providers allocate the memory and provide the dma-addr, but
>>>>> need not dma-sync the dma-addr, right? The driver can sync the
>>>>> dma-addr if it wants and the driver can delegate the syncing to the pp
>>>>> via PP_FLAG_DMA_SYNC_DEV if it wants. AFAICT I think the check should
>>>>> be removed, not inverted, but I could be missing something.
>>>>
>>>> I don't know much about dmabuf but it hinges on the question whether
>>>> doing DMA sync for device on a dmabuf address is :
>>>>   - a good thing
>>>>   - a noop
>>>>   - a bad thing
>>>>
>>>> If it's a good thing or a noop - agreed.
>>>>
>>>> Similar question for the sync for CPU.
>>>>
>>>> I agree that intuitively it should be all fine. But the fact that dmabuf
>>>> has a bespoke API for accessing the memory by the CPU makes me worried
>>>> that there may be assumptions about these addresses not getting
>>>> randomly fed into the normal DMA API..
>>>
>>> Sorry I'm also a bit unsure what is the right thing to do here. The
>>> code that we've been running in GVE does a dma-sync for cpu
>>> unconditionally on RX for dma-buf and non-dmabuf dma-addrs and we
>>> haven't been seeing issues. It never does dma-sync for device.
>>>
>>> My first question is why is dma-sync for device needed on RX path at
>>> all for some drivers in the first place? For incoming (non-dmabuf)
>>> data, the data is written by the device and read by the cpu, so sync
>>> for cpu is really what's needed. Is the sync for device for XDP? Or is
>>> it that buffers should be dma-syncd for device before they are
>>> re-posted to the NIC?
>>>
>>> Christian/Jason, sorry quick question: are
>>> dma_sync_single_for_{device|cpu} needed or wanted when the dma-addrs
>>> come from a dma-buf? Or these dma-addrs to be treated like any other
>>> with the normal dma_sync_for_{device|cpu} rules?
>>
>> Um, I think because dma-buf hacks things up and generates illegal
>> scatterlist entries with weird dma_map_resource() addresses for the
>> typical P2P case the dma sync API should not be used on those things.
>>
>> However, there is no way to know if the dma-buf has does this, and
>> there are valid case where the scatterlist is not ill formed and the
>> sync is necessary.
>>
>> We are getting soo close to being able to start fixing these API
>> issues in dmabuf, I hope next cylce we can begin.. Fingers crossed.
>>
>>  From a CPU architecture perspective you do not need to cache flush PCI
>> MMIO BAR memory, and perhaps doing so be might be problematic on some
>> arches (???). But you do need to flush normal cachable CPU memory if
>> that is in the DMA buf.
>>
> 
> Thanks Jason. In that case I agree with Jakub we should take in his change here:
> 
> https://lore.kernel.org/netdev/20241009170102.1980ed1d@kernel.org/
> 
> With this change the driver would delegate dma_sync_for_device to the
> page_pool, and the page_pool will skip it altogether for the dma-buf
> memory provider.

Requiring ->dma_map should be common to all providers as page pool
shouldn't be dipping to net_iovs figuring out how to map them. However,
looking at this discussion seems that the ->dma_sync concern is devmem
specific and should be discarded by pp providers using dmabufs, i.e. in
devmem.c:mp_dmabuf_devmem_init().

-- 
Pavel Begunkov

