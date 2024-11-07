Return-Path: <netdev+bounces-142747-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C05D9C0389
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 12:11:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B81FE28647F
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 11:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1481F4FA5;
	Thu,  7 Nov 2024 11:11:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D93D1F4708;
	Thu,  7 Nov 2024 11:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730977860; cv=none; b=tHepZX5HFJUkTIVYUY3WudWaZCH2JHKJmJ0F8/eVSdxjEIqaiOUl085mTBF1gE2Bx2v3rfeF1c831V+hXtJdwdVaAEatAO1bdBB2anTlhG6/he9tVvm6rIREtTpxel2MWCPcYaT33AawzNWViShu+sXaVuLjvMmUwJlTAo1hG8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730977860; c=relaxed/simple;
	bh=9I9JBtOY3ZqePZ+S4OHEhGiCfFKTPsxFopvm26hwpz4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HddNoUfFGwUqsnFap6rH/6uWsQcq8B068LNcZNxbYinyb6pXvOU09QBXOG1jFXGYrujoFetK9YQoNs4+O0z9dW88tsa5oIMNps4R7BgT9VLN8mrHokURwAh9oqKQfhJoCgUePB99OmHH4ELg0Ojj/85UWDBS9XG7cbBBvvAIt3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4XkfSy6VQXz1P9Y4;
	Thu,  7 Nov 2024 19:08:34 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 38EB518005F;
	Thu,  7 Nov 2024 19:10:56 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 7 Nov 2024 19:10:55 +0800
Message-ID: <addfdff2-d62c-49b3-b528-77071d34b872@huawei.com>
Date: Thu, 7 Nov 2024 19:10:55 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 3/3] page_pool: fix IOMMU crash when driver
 has already unbound
To: Alexander Duyck <alexander.duyck@gmail.com>, Jesper Dangaard Brouer
	<hawk@kernel.org>
CC: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<zhangkun09@huawei.com>, <fanghaiqing@huawei.com>, <liuyonglong@huawei.com>,
	Robin Murphy <robin.murphy@arm.com>, IOMMU <iommu@lists.linux.dev>, Andrew
 Morton <akpm@linux-foundation.org>, Eric Dumazet <edumazet@google.com>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, kernel-team
	<kernel-team@cloudflare.com>, Viktor Malik <vmalik@redhat.com>
References: <20241022032214.3915232-1-linyunsheng@huawei.com>
 <20241022032214.3915232-4-linyunsheng@huawei.com>
 <dbd7dca7-d144-4a0f-9261-e8373be6f8a1@kernel.org>
 <113c9835-f170-46cf-92ba-df4ca5dfab3d@huawei.com> <878qudftsn.fsf@toke.dk>
 <d8e0895b-dd37-44bf-ba19-75c93605fc5e@huawei.com> <87r084e8lc.fsf@toke.dk>
 <0c146fb8-4c95-4832-941f-dfc3a465cf91@kernel.org>
 <204272e7-82c3-4437-bb0d-2c3237275d1f@huawei.com>
 <18ba4489-ad30-423e-9c54-d4025f74c193@kernel.org>
 <b8b7818a-e44b-45f5-91c2-d5eceaa5dd5b@kernel.org>
 <CAKgT0UfkyLsfZGm0+T0Jyv=jO=tvS11vtD8MSR7s-EdZ4nGM+g@mail.gmail.com>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <CAKgT0UfkyLsfZGm0+T0Jyv=jO=tvS11vtD8MSR7s-EdZ4nGM+g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2024/11/7 3:55, Alexander Duyck wrote:
                         |
...

> 
> Is there any specific reason for why we need to store the pages
> instead of just scanning the page tables to look for them? We should
> already know how many we need to look for and free. If we were to just
> scan the page structs and identify the page pool pages that are
> pointing to our pool we should be able to go through and clean them
> up. It won't be the fastest approach, but this should be an
> exceptional case to handle things like a hot plug removal of a device
> where we can essentially run this in the background before we free the
> device.

Does 'scanning the page tables' mean scaning the array of 'struct page *',
like vmemmap/memmap?

I am not sure if there is any existing pattern or API to scan that array?
Does it fall under the catalog of poking into the internals of mm subsystem?
For exmaple, there seems to be different implemenation for that array depending
on CONFIG_SPARSEMEM* config.

Also, I am not sure how much time it may take if we have to scan the array
of 'struct page *' for all the memory in the system.

> 
> Then it would just be a matter of modifying the pool so that it will
> drop support for doing DMA unmapping and essentially just become a
> place for the freed pages to go to die.
> 
If I understand it correctly, the above seems to be what this patch is
trying to do by clearing pool->dma_map after doing the dma unmapping for
the inflight pages.

