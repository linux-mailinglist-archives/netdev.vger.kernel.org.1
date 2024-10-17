Return-Path: <netdev+bounces-136478-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BABCA9A1E98
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 11:40:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56412B25E44
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 09:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 838601D90BD;
	Thu, 17 Oct 2024 09:40:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35224762E0
	for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 09:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729158012; cv=none; b=AWJ2IRpNh7j2xJxo/vdtAtrbdmaDsBuAcNYrSQNb5IL/1Gvp36KqLJnHXCkxPvPS8RxveXkmPhIWUGThZWSrM+cAjS0SnfMkJKaYU3Cn+E6coJf2REUMEsipe8deoPl4wG0SGfmus5gVdBRkE4uLEYoxth0VlNbpJFqc2zHvbgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729158012; c=relaxed/simple;
	bh=HfbRrUrWeLWP6xolSgeEuOauGNhfwmJjuvBcMtLuU4Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=IIAo6n8Jn55JS+egAqsuPxEzznGDdxxPZ6FxRgWcYDBkbZcl+x+uNvEWKg6rhtxill5VWiBIHNTlpM5nhVQ6YQ8TmE3KDteDsghAUv0Kujvo1iTeIc6RUYhp1K6dxTvuOF9VoshoNP2tLWeEWWlbpZKWBubjMmwNfDQaaXQ47nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4XTjT52232z1SCl6;
	Thu, 17 Oct 2024 17:38:49 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 4FC731A016C;
	Thu, 17 Oct 2024 17:40:05 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 17 Oct 2024 17:40:05 +0800
Message-ID: <e9c92aab-16bc-4814-8902-7796b9d29826@huawei.com>
Date: Thu, 17 Oct 2024 17:40:04 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 2/3] gve: adopt page pool for DQ RDA mode
To: Praveen Kaligineedi <pkaligineedi@google.com>
CC: <netdev@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <willemb@google.com>,
	<jeroendb@google.com>, <shailend@google.com>, <hramamurthy@google.com>,
	<ziweixiao@google.com>, <shannon.nelson@amd.com>, <jacob.e.keller@intel.com>
References: <20241014202108.1051963-1-pkaligineedi@google.com>
 <20241014202108.1051963-3-pkaligineedi@google.com>
 <89d7ce83-cc1d-4791-87b5-6f7af29a031d@huawei.com>
 <CA+f9V1MZWkWmVHruHgJC1hqepi-CTLDvGjtkd3CGaCiUR-kF5Q@mail.gmail.com>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <CA+f9V1MZWkWmVHruHgJC1hqepi-CTLDvGjtkd3CGaCiUR-kF5Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2024/10/17 3:43, Praveen Kaligineedi wrote:
> Thanks Yunsheng. One thing that's not clear to me - the GVE driver
> does not call page_pool_put_page with dma_sync_size of 0 anywhere. Is
> this still an issue in that case?

It depends on what's value of 'dma_sync_size', as the value of the
below 'page_info.buf_size' seems to be the size of one fragment, so
it might end up only doing the dma_sync operation for the first fragment,
and what we want might be to dma sync all the fragments in the same page.

The doc about that in Documentation/networking/page_pool.rst seems a
little outdated, but what it meant is still true as my understanding:

https://elixir.bootlin.com/linux/v6.11.3/source/Documentation/networking/page_pool.rst#L101

> 
> Thanks,
> Praveen
> 
> 
> On Wed, Oct 16, 2024 at 2:21 AM Yunsheng Lin <linyunsheng@huawei.com> wrote:
>>
>> On 2024/10/15 4:21, Praveen Kaligineedi wrote:
>>
>> ...
>>
>>> +void gve_free_to_page_pool(struct gve_rx_ring *rx,
>>> +                        struct gve_rx_buf_state_dqo *buf_state,
>>> +                        bool allow_direct)
>>> +{
>>> +     struct page *page = buf_state->page_info.page;
>>> +
>>> +     if (!page)
>>> +             return;
>>> +
>>> +     page_pool_put_page(page->pp, page, buf_state->page_info.buf_size,
>>> +                        allow_direct);
>>
>> page_pool_put_full_page() might be a better option here for now when
>> page_pool is created with PP_FLAG_DMA_SYNC_DEV flag and frag API like
>> page_pool_alloc() is used in gve_alloc_from_page_pool(), as explained
>> in below:
>>
>> https://lore.kernel.org/netdev/20241014143542.000028dc@gmail.com/T/#mdaba23284a37affc2c46ef846674ae6aa49f8f04
>>
>>
>>> +     buf_state->page_info.page = NULL;
>>> +}
>>> +
>>> +static int gve_alloc_from_page_pool(struct gve_rx_ring *rx,
>>> +                                 struct gve_rx_buf_state_dqo *buf_state)
>>> +{
>>> +     struct gve_priv *priv = rx->gve;
>>> +     struct page *page;
>>> +
>>> +     buf_state->page_info.buf_size = priv->data_buffer_size_dqo;
>>> +     page = page_pool_alloc(rx->dqo.page_pool,
>>> +                            &buf_state->page_info.page_offset,
>>> +                            &buf_state->page_info.buf_size, GFP_ATOMIC);
>>> +
>>> +     if (!page)
>>> +             return -ENOMEM;
>>> +
>>> +     buf_state->page_info.page = page;
>>> +     buf_state->page_info.page_address = page_address(page);
>>> +     buf_state->addr = page_pool_get_dma_addr(page);
>>> +
>>> +     return 0;
>>> +}
>>> +
>>> +struct page_pool *gve_rx_create_page_pool(struct gve_priv *priv,
>>> +                                       struct gve_rx_ring *rx)
>>> +{
>>> +     u32 ntfy_id = gve_rx_idx_to_ntfy(priv, rx->q_num);
>>> +     struct page_pool_params pp = {
>>> +             .flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV,
>>> +             .order = 0,
>>> +             .pool_size = GVE_PAGE_POOL_SIZE_MULTIPLIER * priv->rx_desc_cnt,
>>> +             .dev = &priv->pdev->dev,
>>> +             .netdev = priv->dev,
>>> +             .napi = &priv->ntfy_blocks[ntfy_id].napi,
>>> +             .max_len = PAGE_SIZE,
>>> +             .dma_dir = DMA_FROM_DEVICE,
>>> +     };
>>> +
>>> +     return page_pool_create(&pp);
>>> +}
>>> +

