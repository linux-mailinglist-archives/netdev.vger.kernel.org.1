Return-Path: <netdev+bounces-160751-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CEE00A1B318
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 10:52:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29E56162034
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 09:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85C2D219A8F;
	Fri, 24 Jan 2025 09:52:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698B923A0;
	Fri, 24 Jan 2025 09:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737712367; cv=none; b=czZZzAjdcFkMwXVpBXn1VuvpBLwhuJ+OA/JTceTpaclI54crKq29VVZ7V4uVx3jkrBo4l8+CI6e/CZ4R2fDbeEDTRrXC9t6BDFC4cxwCP3koR4by1qJ9ZJpj79TwgCbI9tCB7pvwq0WS210/D/MuxOvT9DY7fMOrIyGfaTTzspg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737712367; c=relaxed/simple;
	bh=OxnKsPySuSh7Ons4C5nnqMMTtF+f9pa+WVc7g72LwNc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=B41CmwaYqckzilhZxbsNIeYr/t0kxs2CsTocrWoeibI19/hp/NA/G3UdDucEvPHb7NYcdJVwwzcqeR2CpaXrE/LfHMGIm64ETD+cvReHsN7eCFgcOZ107GGfKMPTVumM++4cfzGLHyEeJrdfD/MWacx+jHIitBo0PEedpTivqog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4YfY3V0x6qzrSkW;
	Fri, 24 Jan 2025 17:51:02 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 9A472140159;
	Fri, 24 Jan 2025 17:52:40 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 24 Jan 2025 17:52:40 +0800
Message-ID: <ead00fb7-8538-45b3-8322-8a41386e7381@huawei.com>
Date: Fri, 24 Jan 2025 17:52:33 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v23 3/7] mm: page_frag: use initial zero offset
 for page_frag_alloc_align()
To: Florian Fainelli <florian.fainelli@broadcom.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Alexander Duyck
	<alexander.duyck@gmail.com>, Andrew Morton <akpm@linux-foundation.org>,
	Linux-MM <linux-mm@kvack.org>, Alexander Duyck <alexanderduyck@fb.com>
References: <20241028115343.3405838-1-linyunsheng@huawei.com>
 <20241028115343.3405838-4-linyunsheng@huawei.com>
 <2ef8b7d4-7fae-4a08-9db1-4a33cd56ec9c@broadcom.com>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <2ef8b7d4-7fae-4a08-9db1-4a33cd56ec9c@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2025/1/24 3:15, Florian Fainelli wrote:
> 
> Sorry for the late feedback, this patch causes the bgmac driver in is .ndo_open() function to return -ENOMEM, the call trace looks like this:

Hi, Florian
Thanks for the report.

> 
>  bgmac_open
>   -> bgmac_dma_init
>     -> bgmac_dma_rx_skb_for_slot
>       -> netdev_alloc_frag
> 
> BGMAC_RX_ALLOC_SIZE = 10048 and PAGE_FRAG_CACHE_MAX_SIZE = 32768.

I guess BGMAC_RX_ALLOC_SIZE being bigger than PAGE_SIZE is the
problem here, as the frag API is not really supporting allocating
fragment that is bigger than PAGE_SIZE, as it will fall back to
allocate the base page when order-3 compound page allocation fails,
see __page_frag_cache_refill().

Also, it seems strange that bgmac driver seems to always use jumbo
frame size to allocate fragment, isn't more  appropriate to allocate
the fragment according to MTU?

> 
> Eventually we land into __page_frag_alloc_align() with the following parameters across multiple successive calls:
> 
> __page_frag_alloc_align: fragsz=10048, align_mask=-1, size=32768, offset=0
> __page_frag_alloc_align: fragsz=10048, align_mask=-1, size=32768, offset=10048
> __page_frag_alloc_align: fragsz=10048, align_mask=-1, size=32768, offset=20096
> __page_frag_alloc_align: fragsz=10048, align_mask=-1, size=32768, offset=30144
> 
> So in that case we do indeed have offset + fragsz (40192) > size (32768) and so we would eventually return NULL.

It seems the changing of '(unlikely(offset < 0))' checking to
"fragsz > PAGE_SIZE" causes bgmac driver to break more easily
here. But bgmac driver might likely break too if the system
memory is severely fragmented when falling back to alllocate
base page before this patch.

> 
> Any idea on how to best fix that within the bgmac driver?

Maybe use the page allocator API directly when allocating fragment
with BGMAC_RX_ALLOC_SIZE > PAGE_SIZE for a quick fix.

In the long term, maybe it makes sense to use the page_pool API
as more drivers are converting to use page_pool API already.

