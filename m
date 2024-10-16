Return-Path: <netdev+bounces-136104-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 597859A0541
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 11:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 120081F25258
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 09:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 243FF205125;
	Wed, 16 Oct 2024 09:20:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864431DE3C8
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 09:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729070457; cv=none; b=WP0JTjrJbo1ED+4pMRJHL6UIDza4IMVBwuDf54VPoKIVxepMNAnLNQd/99yq47vGrH7WR3D9yGoa6u7LurQ6FKDP38XsLxG0LSdZSY8j2LE4lV33hVtcQAhEVJ8AtCu26urmOyjqMit7+9XNCCakX6pBUywGhujuRjHlp+ULBEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729070457; c=relaxed/simple;
	bh=P/Ydz5Di/X5ftPuix74WEe2g1Deqm8n03SA7g25JTDc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RzvBDPjYjH4m+So6cnTtZXeObsKI8oinyPkNnY4Uys8xOHPia8hDVPy8aGBDVOpmfstp90LTnhaa00oE59IYj+sVgdzMqNBJsjN+v4jwuNCwv2NuAJJaOE9hU9ucwdmZghTO/7NfJVzT4jgywaGX8Du3l63/CQLpOTRFuZgHp9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XT55P6YLxz1jB2Y;
	Wed, 16 Oct 2024 17:19:37 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id DAA05140361;
	Wed, 16 Oct 2024 17:20:51 +0800 (CST)
Received: from [10.67.120.129] (10.67.120.129) by
 dggpemf200006.china.huawei.com (7.185.36.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 16 Oct 2024 17:20:51 +0800
Message-ID: <89d7ce83-cc1d-4791-87b5-6f7af29a031d@huawei.com>
Date: Wed, 16 Oct 2024 17:20:51 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 2/3] gve: adopt page pool for DQ RDA mode
To: Praveen Kaligineedi <pkaligineedi@google.com>, <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <willemb@google.com>, <jeroendb@google.com>,
	<shailend@google.com>, <hramamurthy@google.com>, <ziweixiao@google.com>,
	<shannon.nelson@amd.com>, <jacob.e.keller@intel.com>
References: <20241014202108.1051963-1-pkaligineedi@google.com>
 <20241014202108.1051963-3-pkaligineedi@google.com>
Content-Language: en-US
From: Yunsheng Lin <linyunsheng@huawei.com>
In-Reply-To: <20241014202108.1051963-3-pkaligineedi@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2024/10/15 4:21, Praveen Kaligineedi wrote:

...

> +void gve_free_to_page_pool(struct gve_rx_ring *rx,
> +			   struct gve_rx_buf_state_dqo *buf_state,
> +			   bool allow_direct)
> +{
> +	struct page *page = buf_state->page_info.page;
> +
> +	if (!page)
> +		return;
> +
> +	page_pool_put_page(page->pp, page, buf_state->page_info.buf_size,
> +			   allow_direct);

page_pool_put_full_page() might be a better option here for now when
page_pool is created with PP_FLAG_DMA_SYNC_DEV flag and frag API like
page_pool_alloc() is used in gve_alloc_from_page_pool(), as explained
in below:

https://lore.kernel.org/netdev/20241014143542.000028dc@gmail.com/T/#mdaba23284a37affc2c46ef846674ae6aa49f8f04


> +	buf_state->page_info.page = NULL;
> +}
> +
> +static int gve_alloc_from_page_pool(struct gve_rx_ring *rx,
> +				    struct gve_rx_buf_state_dqo *buf_state)
> +{
> +	struct gve_priv *priv = rx->gve;
> +	struct page *page;
> +
> +	buf_state->page_info.buf_size = priv->data_buffer_size_dqo;
> +	page = page_pool_alloc(rx->dqo.page_pool,
> +			       &buf_state->page_info.page_offset,
> +			       &buf_state->page_info.buf_size, GFP_ATOMIC);
> +
> +	if (!page)
> +		return -ENOMEM;
> +
> +	buf_state->page_info.page = page;
> +	buf_state->page_info.page_address = page_address(page);
> +	buf_state->addr = page_pool_get_dma_addr(page);
> +
> +	return 0;
> +}
> +
> +struct page_pool *gve_rx_create_page_pool(struct gve_priv *priv,
> +					  struct gve_rx_ring *rx)
> +{
> +	u32 ntfy_id = gve_rx_idx_to_ntfy(priv, rx->q_num);
> +	struct page_pool_params pp = {
> +		.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV,
> +		.order = 0,
> +		.pool_size = GVE_PAGE_POOL_SIZE_MULTIPLIER * priv->rx_desc_cnt,
> +		.dev = &priv->pdev->dev,
> +		.netdev = priv->dev,
> +		.napi = &priv->ntfy_blocks[ntfy_id].napi,
> +		.max_len = PAGE_SIZE,
> +		.dma_dir = DMA_FROM_DEVICE,
> +	};
> +
> +	return page_pool_create(&pp);
> +}
> +

