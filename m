Return-Path: <netdev+bounces-76271-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C0586D0EC
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 18:40:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 058C41C229F5
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 17:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2043870AF1;
	Thu, 29 Feb 2024 17:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="J4iUTP2L"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B2270AEA
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 17:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709228409; cv=none; b=X4VFu2Yij4IA2MkTgK0H33SZZ6b2S5Y4C0zQ6zeJ7O0hrZUyHfLWfMN5U6Qvj5yXCYl4bclfBbwC6I9/EqYzr1rvSZnwWK6FbEnS5b1bPy47kaynyAnugaQfOkoaDSKVSKR78OSr+C7V95nxqfavA/7uRdQLfm+EtFT6YsRyS3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709228409; c=relaxed/simple;
	bh=3oywfVChFq+oQSxLGol560RpjgB+MysgyLROG3f01OI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QV+5btSPtlQtYjHwzwawPjh//fqxJTUp+qEzI7QcxH1QgIqWT0JMg5w+0WZjT3U9Mq7yHJ29smWlRomzTNN/8jNK6DQi3pi0mMPr8J83smKqVE759x/b0NbT0KFJ+HouiiCbz2LYJhCi8U2+YTrIHrhbR4h4v848SrwsiYT6rAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=J4iUTP2L; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-412b68d1a42so8948475e9.0
        for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 09:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1709228405; x=1709833205; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xgat6miZmocnOGtD6kLO92fEZ2YNS9HNuEFgov+kRps=;
        b=J4iUTP2L26qFlUoMNwp5jsLg4J+ovaMZSzjwdTEjULy1puUDSZvTC5xSzqBdTAUpai
         r1CRsVnJFRY/Dgo6QJC0pSCPdv45Cm2gqigbT3ZQL+uiJVsjBkOhB9F+YJncqQJChaYl
         nL9A7AIQq0J7jUilt/AzuB0NuEqc3Td21XoK1nCHtRfI0x4/6uMCB9puhxQM7Ktumcc2
         MMPXSq4XFcYsESTgCEinHg66QKdEEwTeWuAZr0f35YyoEqhH4WRCFmNyazDxjARV0zh4
         2LzqCz5sLo2Jf2GzKTzBtAUUmIp98ImRMNdJB+JirwUQTYVdOPxWz7D7l5UlhSCcejfP
         gVmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709228405; x=1709833205;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xgat6miZmocnOGtD6kLO92fEZ2YNS9HNuEFgov+kRps=;
        b=iGFVCvu2mOEhwAttqLCMOK+7C2pdtq5ncXISCin3CqPNK1T4qiIuZCPUtes9mfI0uv
         Z8i4RsT0NgcKHOha2iKcAPFRKP3u8BJ8WiopOICjR9TCjN9iuTgm/UNioTYLFaXIdFqm
         u16Gd0z9FilxYZO3Y5HcGOOMkhpGV/0YbYd5cvZ4eih1wlLGlL8tO4Y1riGYjMsJHT6A
         7CnLHMuvkO466tijjLwTIceCmIK13dopXjDfN2GdP7yVHbBkJgrTXmUMYurATPH3FOOQ
         sUadmM9WV8u2Qmt2csBvQ7NA9yZYxgKvn7ZCm/8h03Am3hE1z+Hn/TIMe99rIyREewj8
         fMUw==
X-Forwarded-Encrypted: i=1; AJvYcCWj3o/k1aPMz0aet/eTAAK9e/DWjZ0EgmiJG/9eE98JDMRdTx59DlctZTz0rLG/2KH90oM84tKc7Jph/BFnARYWzUoCQGaC
X-Gm-Message-State: AOJu0Yx71Sz3YjZ6Joe5K99FwVvoE41Ce9QNrV7abmxmz1Rc2EUe6C6c
	AjdO2jtnJQB+Dxe2loMG08dZNM0234aaF3HvMj3skOP+0SH7Xl2uFTl6eRCgf+A=
X-Google-Smtp-Source: AGHT+IGvrVMu/R++dtGYLzu3zYNqbleeCsRStSp9WdutBjPczwvniuk0tl8GCMOuKF81lZkf0yamzQ==
X-Received: by 2002:a05:600c:5105:b0:412:b82d:e2f7 with SMTP id o5-20020a05600c510500b00412b82de2f7mr2352157wms.28.1709228405011;
        Thu, 29 Feb 2024 09:40:05 -0800 (PST)
Received: from [192.168.1.70] ([84.102.31.43])
        by smtp.gmail.com with ESMTPSA id bd27-20020a05600c1f1b00b00411e3cc0e0asm2708296wmb.44.2024.02.29.09.40.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Feb 2024 09:40:04 -0800 (PST)
Message-ID: <16b4674c-33c0-4061-8775-0cf234051770@baylibre.com>
Date: Thu, 29 Feb 2024 18:40:02 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: ethernet: ti: am65-cpsw: Add minimal XDP support
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org
References: <20240223-am65-cpsw-xdp-basic-v1-1-9f0b6cbda310@baylibre.com>
 <e382df16-c78a-448d-b6d5-39a627b30652@lunn.ch>
 <65250d0c-96c1-4eb0-adbf-1d3296a7cf36@baylibre.com>
 <0ad02716-520e-41e6-ba11-38390427447f@lunn.ch>
From: Julien Panis <jpanis@baylibre.com>
In-Reply-To: <0ad02716-520e-41e6-ba11-38390427447f@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/29/24 17:46, Andrew Lunn wrote:
> On Thu, Feb 29, 2024 at 05:19:44PM +0100, Julien Panis wrote:
>> On 2/27/24 00:18, Andrew Lunn wrote:
>>>> +static struct sk_buff *am65_cpsw_alloc_skb(struct net_device *ndev, unsigned int len)
>>>> +{
>>>> +	struct page *page;
>>>> +	struct sk_buff *skb;
>>>> +
>>>> +	page = dev_alloc_pages(0);
>>> You are likely to get better performance if you use the page_pool.
>>>
>>> When FEC added XDP support, the first set of changes was to make use
>>> of page_pool. That improved the drivers performance. Then XDP was
>>> added on top. Maybe you can follow that pattern.
>>>
>>>         Andrew
>> Hello Andrew,
>>
>> Thanks for this suggestion. I've been working on it over the last days.
>> I encountered issues and I begin to wonder if that's a good option for
>> this driver. Let me explain...
> I'm not a page pool expert, so hopefully those that are will jump in
> and help.
>
>> This device has 3 ports:
>> - Port0 is the host port (internal to the subsystem and referred as CPPI
>> in the driver).
>> - Port1 and 2 are the external ethernet ports.
>> Each port's RX FIFO has 1 queue.
>>
>> As mentioned in page_pool documentation:
>> https://docs.kernel.org/networking/page_pool.html
>> "The number of pools created MUST match the number of hardware
>> queues unless hardware restrictions make that impossible. This would
>> otherwise beat the purpose of page pool, which is allocate pages fast
>> from cache without locking."
> My guess is, this last bit is the important part. Locking. Do ports 1
> and port 2 rx and tx run in parallel on different CPUs? Hence do you
> need locking?

No.

>
>> So, for this driver I should use 2 page pools (for port1 and 2) if possible.
> Maybe, maybe not. It is not really the number of front panel interface
> which matters here. It is the number of entities which need buffers.
>
>> But, if I I replace any alloc_skb() with page_pool_alloc() in the original
>> driver, I will have to create only 1 page_pool.
>> This is visible in am65_cpsw_nuss_common_open(), which starts with:
>> "if (common->usage_count) return 0;" to ensure that subsequent code
>> will be executed only once even if the 2 interfaces are ndo_open'd.
>> IOW, skbs will be allocated for only 1 RX channel. I checked that behavior,
>> and that's the way it works.
>> This is because the host port (CPPI) has only 1 RX queue. This single
>> queue is used to get all the packets, from both Ports and 2 (port ID is
>> stored in each descriptor).
> So you have one entity which needs buffers. CPPI. It seems like Port1
> and Port2 do not need buffers? So to me, you need one page pool.

Yes, only one entity (CPPI) needs buffers.

>
>> So, because of this constraint, I ended up working on the "single
>> page pool" option.
>>
>> Questions:
>> 1) Is the behavior described above usual for ethernet switch devices ?
> This might be the first time page pool has been used by a switch? I
> would check the melanox and sparx5 driver and see if they use page
> pool.

It seems that sparx5 does not use page pools, mellanox does.

>
>> 2) Given that I can't use a page pool for each HW queue, is it worth
>> using the page pool memory model ?
>> 3) Currently I use 2 xdp_rxq (one for port1 and another one for port2).
>> If an XDP program is attached to port1, my page pool dma parameter
>> will need to be DMA_BIDIRECTIONAL (because of XDP_TX). As a result,
>> even if there is no XDP program attached to port2, the setting for page
>> pool will need to be DMA_BIDIRECTIONAL instead of DMA_FROM_DEVICE.
>> In such situation, isn't it a problem for port2 ?
>> 4) Because of 1) and 2), will page pool performance really be better for
>> this driver ?
> You probably need to explain the TX architecture a bit. How are
> packets passed to the hardware? Is it again via a single CPPI entity?
> Or are there two entities?

Yes, packets are passed to the hardware via a single CPPI entity.

> DMA_BIDIRECTIONAL and DMA_FROM_DEVICE is about cache flushing and
> invalidation. Before you pass a buffer to the hardware for it to
> receive into, you need to invalidate the cache. That means when the
> hardware gives the buffer back with a packet in it, there is a cache
> miss and it fetches the new data from memory. If that packet gets
> turned into an XDP_TX, you need to flush the cache to force any
> changes out of the cache and into memory. The DMA from memory then
> gets the up to date packet contents.
>
> My guess would be, always using DMA_BIDIRECTIONAL is fine, so long as
> your cache operations are correct. Turn on DMA_API_DEBUG and make sure
> it is happy.
>
>       Andrew

Thank you for all these explanations.
I'll carry on working on this single page pool option, so.

Julien

