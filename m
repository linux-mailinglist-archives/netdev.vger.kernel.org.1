Return-Path: <netdev+bounces-173275-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC53A5843C
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 14:27:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7C43188BCF9
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 13:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618D81D88DB;
	Sun,  9 Mar 2025 13:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cZ8TR84p"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD7A4690
	for <netdev@vger.kernel.org>; Sun,  9 Mar 2025 13:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741526851; cv=none; b=Ny1KaRgTaM/lgOtWKSnO+9WBm3YjwWJXk7TKi8g1Osbsmcm7lt+P3mANXpwmqcqynsQlk2eoLvD6/aN1o+ieHpb3oQ5YBnNJRjS5nRi/4Kjw7FRkdgUi7P8bPBPlsF9ocsxwLaaxTdaGfjf4KQIHNcmxhvTUDG0tN168kpw4Ez0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741526851; c=relaxed/simple;
	bh=voqAZGjLjgBNoXXlkt4DG42P89rivB0LkvylaLqPMdw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XlBsC94UAFrQEtHyRHNnoi+A8cYvZ7QWyE2nBZ3mBHeSN2xQvMUoc0jmEcUvAYPu8Q3X39suSqHhsLawD480DP9+McwhS4UUHtqAVgDzuLbIYhoTJ6VAgJmbHattrhf8MaskV8WoycqvTzIwFhmO4IxNdS2P2lk1jwP/4R0U5lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cZ8TR84p; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-22409077c06so38906665ad.1
        for <netdev@vger.kernel.org>; Sun, 09 Mar 2025 06:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741526848; x=1742131648; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RcEFCWQYYHxFZExcvX+pJuL+eOu8jZ+IcoamTjSx8g4=;
        b=cZ8TR84pfnD+kf1kG6f9Y1k8koTaaDG3oGKs3zDwk8rR37P0nYiI3iGThTBoODXKg2
         Fi1bK1Gm9FYHfUhHyYoRxCdxiRvd/mo48dn0Ca6U5k4VuuPXYJIxfqhQq88rjFbaA/Qx
         P6rnMmrAbNjkvwzRURDCOBaBczwU/3y3gBv0wZac3zercyACXoiVFMzONWsU/BB/hdFX
         CXNZNChrjYUBu1lXADxDe2GkjKxumKPcVDOXWU807ImN+EZBg6KZQaDgXVSG2EuAgDIN
         0tna8lPz3BU6IdGKokxfOOjfT8gNBVmNE2o89rdqBFWE1WOPmMuJ7L9mN4aIdK6WEF3O
         tETg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741526848; x=1742131648;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RcEFCWQYYHxFZExcvX+pJuL+eOu8jZ+IcoamTjSx8g4=;
        b=J20LNkywHVnMpDX39PlfuVSe9ZkM+OZHJW8GwepHW6bqW1WYm2fbgPci5ybqvfGAS9
         rzXfhbDqGJR0h5xQuXfEBwMOGurhorTVa/7NPsHH4xPi6L9LQxU7rbX3zY6m+h+K7Jjy
         eE/HQtNM/IJx/Eof0YqVpsC2RHnQMw1WqdDL8cJs5slHK3/FzHDzHwp+I7rDCTiCN7AG
         NzJNV0kvv5Aa24RvICjpsWW2x7UhBccF01lDFvfYddjUs2Fs/4XtGwWy8q6dvQ5oIrME
         YOCQyZZo2rHvz4H8nJNsgDpbvr2kDb6lH9sXi755VvO4ro1AAyPG1HPAvXCvzr6e5X8H
         DHgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwrxegpGTXoHFmCvADx56E92+USSeP5IPvDPEIY+k9wYWzYBYn3CQnutGuG4HnBGW0MLKV1CQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YySmzcGHvkmfE76RK75x+De8BL0NTeR2xNZWYQtSewnb2fGNzxC
	2Z2gCnMZ7el2sROfIgksiH7O4Q6/Ad1+pFdhoHLg2LWoeFAzh/Jf
X-Gm-Gg: ASbGncsWIuLlYdVJwOSSKOCYq2ox5xo2M/CQqjaWdhVrWQXBf29/nLMcl7rMUcg9u+J
	/UwfH/s4wyz3jAQlWMkWyUgX65WnHBxfQmMAyMbhCRk9LHsYULSkrYg26zmgnKkJmi+cPY0op3i
	uAG2b3F9QLo8Vz++Lja7wAYmOyEEESQpfDv7352UOASIbgMuX3MhBNfxovb0H/VQw5pqgERwDo+
	OR4L3Qdu11TKTPqsJNuc8ZWFOIday8vUJrYXTfOA/qTRxN2NhSK6gSBx719U4y5VrIALh9IoyTG
	IjxwB1vG0WUvN7nd6QuAaq0CquIv2BKZKco+oGYAWhYWmEjfT4e0qALGs1QhQWcLhLE3ZnbvWNc
	v35UqOF9zO7gDTSR6OHRDM+eBmkFK5Q==
X-Google-Smtp-Source: AGHT+IFZ7+BrV2GG3nZGskDU3JjfiErgPSS8b3veSeS0LDFZB/UF/uXXRB6778elDZmORNtRG19MEw==
X-Received: by 2002:a05:6a21:1519:b0:1f5:7280:1cf7 with SMTP id adf61e73a8af0-1f572802cf6mr2379258637.16.1741526848313;
        Sun, 09 Mar 2025 06:27:28 -0700 (PDT)
Received: from ?IPV6:2409:8a55:301b:e120:c508:514a:4065:877? ([2409:8a55:301b:e120:c508:514a:4065:877])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736b3f2412csm4146568b3a.175.2025.03.09.06.27.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Mar 2025 06:27:27 -0700 (PDT)
Message-ID: <d84e19c9-be0c-4d23-908b-f5e5ab6f3f3f@gmail.com>
Date: Sun, 9 Mar 2025 21:27:17 +0800
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
 Andrew Morton <akpm@linux-foundation.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 "David S. Miller" <davem@davemloft.net>
Cc: Yunsheng Lin <linyunsheng@huawei.com>,
 Yonglong Liu <liuyonglong@huawei.com>, Mina Almasry
 <almasrymina@google.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, linux-mm@kvack.org, netdev@vger.kernel.org
References: <20250308145500.14046-1-toke@redhat.com>
Content-Language: en-US
From: Yunsheng Lin <yunshenglin0825@gmail.com>
In-Reply-To: <20250308145500.14046-1-toke@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/8/2025 10:54 PM, Toke Høiland-Jørgensen wrote:
> When enabling DMA mapping in page_pool, pages are kept DMA mapped until
> they are released from the pool, to avoid the overhead of re-mapping the
> pages every time they are used. This causes problems when a device is
> torn down, because the page pool can't unmap the pages until they are
> returned to the pool. This causes resource leaks and/or crashes when
> there are pages still outstanding while the device is torn down, because
> page_pool will attempt an unmap of a non-existent DMA device on the
> subsequent page return.
> 
> To fix this, implement a simple tracking of outstanding dma-mapped pages
> in page pool using an xarray. This was first suggested by Mina[0], and
> turns out to be fairly straight forward: We simply store pointers to
> pages directly in the xarray with xa_alloc() when they are first DMA
> mapped, and remove them from the array on unmap. Then, when a page pool
> is torn down, it can simply walk the xarray and unmap all pages still
> present there before returning, which also allows us to get rid of the
> get/put_device() calls in page_pool. Using xa_cmpxchg(), no additional
> synchronisation is needed, as a page will only ever be unmapped once.

The implementation of xa_cmpxchg() seems to take the xa_lock, which
seems to be a per-Xarray spin_lock.
Yes, if if we were to take a per-Xarray lock unconditionaly, additional
synchronisation like rcu doesn't seems to be needed. But it seems an
excessive overhead for normal packet processing when page_pool_destroy()
is not called yet?

Also, we might need a similar locking or synchronisation for the dma
sync API in order to skip the dma sync API when page_pool_destroy() is
called too.

> 
> To avoid having to walk the entire xarray on unmap to find the page
> reference, we stash the ID assigned by xa_alloc() into the page
> structure itself, in the field previously called '_pp_mapping_pad' in
> the page_pool struct inside struct page. This field overlaps with the
> page->mapping pointer, which may turn out to be problematic, so an
> alternative is probably needed. Sticking the ID into some of the upper
> bits of page->pp_magic may work as an alternative, but that requires
> further investigation. Using the 'mapping' field works well enough as
> a demonstration for this RFC, though.
page->pp_magic seems to only have 16 bits space available at most when
trying to reuse some unused bits in page->pp_magic, as BPF_PTR_POISON
and STACK_DEPOT_POISON seems to already use 16 bits, so:
1. For 32 bits system, it seems there is only 16 bits left even if the
    ILLEGAL_POINTER_VALUE is defined as 0x0.
2. For 64 bits system, it seems there is only 12 bits left for powerpc
    as ILLEGAL_POINTER_VALUE is defined as 0x5deadbeef0000000, see
    arch/powerpc/Kconfig.

So it seems we might need to limit the dma mapping count to 4096 or
65536?

And to be honest, I am not sure if those 'unused' 12/16 bits can really 
be reused or not, I guess we might need suggestion from mm and arch
experts here.

> 
> Since all the tracking is performed on DMA map/unmap, no additional code
> is needed in the fast path, meaning the performance overhead of this
> tracking is negligible. The extra memory needed to track the pages is
> neatly encapsulated inside xarray, which uses the 'struct xa_node'
> structure to track items. This structure is 576 bytes long, with slots
> for 64 items, meaning that a full node occurs only 9 bytes of overhead
> per slot it tracks (in practice, it probably won't be this efficient,
> but in any case it should be an acceptable overhead).

Even if items is stored sequentially in xa_node at first, is it possible
that there may be fragmentation in those xa_node when pages are released
and allocated many times during packet processing? If yes, is there any
fragmentation info about those xa_node?

> 
> [0] https://lore.kernel.org/all/CAHS8izPg7B5DwKfSuzz-iOop_YRbk3Sd6Y4rX7KBG9DcVJcyWg@mail.gmail.com/
> 
> Fixes: ff7d6b27f894 ("page_pool: refurbish version of page_pool code")
> Reported-by: Yonglong Liu <liuyonglong@huawei.com>
> Suggested-by: Mina Almasry <almasrymina@google.com>
> Reviewed-by: Jesper Dangaard Brouer <hawk@kernel.org>
> Tested-by: Jesper Dangaard Brouer <hawk@kernel.org>
> Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
> ---
> This is an alternative to Yunsheng's series. Yunsheng requested I send
> this as an RFC to better be able to discuss the different approaches; see
> some initial discussion in[1], also regarding where to store the ID as
> alluded to above.

As mentioned before, I am not really convinced there is still any
space left in 'struct page' yet, otherwise we might already use that
space to fix the DMA address > 32 bits problem in 32 bits system, see
page_pool_set_dma_addr_netmem().

Also, Using the more space in 'struct page' for the page_pool seems to
make page_pool more coupled to the mm subsystem, which seems to not
align with the folios work that is trying to decouple non-mm subsystem
from the mm subsystem by avoid other subsystem using more of the 'struct
page' as metadata from the long term point of view.

> 
> -Toke
> 
> [1] https://lore.kernel.org/r/40b33879-509a-4c4a-873b-b5d3573b6e14@gmail.com
> 




