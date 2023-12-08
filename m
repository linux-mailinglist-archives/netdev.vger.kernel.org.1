Return-Path: <netdev+bounces-55237-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B522809F50
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 10:28:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8239B1C20950
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 09:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C17AA125B0;
	Fri,  8 Dec 2023 09:28:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D79F1735;
	Fri,  8 Dec 2023 01:28:24 -0800 (PST)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.53])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Smm1X2YcFz1Q6QK;
	Fri,  8 Dec 2023 17:24:32 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 8 Dec
 2023 17:28:21 +0800
Subject: Re: [PATCH net-next v6 08/12] libie: add Rx buffer management (via
 Page Pool)
To: Alexander Lobakin <aleksander.lobakin@intel.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Michal Kubiak
	<michal.kubiak@intel.com>, Larysa Zaremba <larysa.zaremba@intel.com>,
	Alexander Duyck <alexanderduyck@fb.com>, David Christensen
	<drc@linux.vnet.ibm.com>, Jesper Dangaard Brouer <hawk@kernel.org>, Ilias
 Apalodimas <ilias.apalodimas@linaro.org>, Paul Menzel
	<pmenzel@molgen.mpg.de>, <netdev@vger.kernel.org>,
	<intel-wired-lan@lists.osuosl.org>, <linux-kernel@vger.kernel.org>
References: <20231207172010.1441468-1-aleksander.lobakin@intel.com>
 <20231207172010.1441468-9-aleksander.lobakin@intel.com>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <1103fe8f-04c8-8cc4-8f1b-ff45cea22b54@huawei.com>
Date: Fri, 8 Dec 2023 17:28:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231207172010.1441468-9-aleksander.lobakin@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected

On 2023/12/8 1:20, Alexander Lobakin wrote:
...

> +
> +/**
> + * libie_rx_page_pool_create - create a PP with the default libie settings
> + * @bq: buffer queue struct to fill
> + * @napi: &napi_struct covering this PP (no usage outside its poll loops)
> + *
> + * Return: 0 on success, -errno on failure.
> + */
> +int libie_rx_page_pool_create(struct libie_buf_queue *bq,
> +			      struct napi_struct *napi)
> +{
> +	struct page_pool_params pp = {
> +		.flags		= PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV,
> +		.order		= LIBIE_RX_PAGE_ORDER,
> +		.pool_size	= bq->count,
> +		.nid		= NUMA_NO_NODE,

Is there a reason the NUMA_NO_NODE is used here instead of
dev_to_node(napi->dev->dev.parent)?

> +		.dev		= napi->dev->dev.parent,
> +		.netdev		= napi->dev,
> +		.napi		= napi,
> +		.dma_dir	= DMA_FROM_DEVICE,
> +		.offset		= LIBIE_SKB_HEADROOM,
> +	};
> +
> +	/* HW-writeable / syncable length per one page */
> +	pp.max_len = LIBIE_RX_BUF_LEN(pp.offset);
> +
> +	/* HW-writeable length per buffer */
> +	bq->rx_buf_len = libie_rx_hw_len(&pp);
> +	/* Buffer size to allocate */
> +	bq->truesize = roundup_pow_of_two(SKB_HEAD_ALIGN(pp.offset +
> +							 bq->rx_buf_len));
> +
> +	bq->pp = page_pool_create(&pp);
> +
> +	return PTR_ERR_OR_ZERO(bq->pp);
> +}
> +EXPORT_SYMBOL_NS_GPL(libie_rx_page_pool_create, LIBIE);
> +

...

> +/**
> + * libie_rx_sync_for_cpu - synchronize or recycle buffer post DMA
> + * @buf: buffer to process
> + * @len: frame length from the descriptor
> + *
> + * Process the buffer after it's written by HW. The regular path is to
> + * synchronize DMA for CPU, but in case of no data it will be immediately
> + * recycled back to its PP.
> + *
> + * Return: true when there's data to process, false otherwise.
> + */
> +static inline bool libie_rx_sync_for_cpu(const struct libie_rx_buffer *buf,
> +					 u32 len)
> +{
> +	struct page *page = buf->page;
> +
> +	/* Very rare, but possible case. The most common reason:
> +	 * the last fragment contained FCS only, which was then
> +	 * stripped by the HW.
> +	 */
> +	if (unlikely(!len)) {
> +		page_pool_recycle_direct(page->pp, page);
> +		return false;
> +	}
> +
> +	page_pool_dma_sync_for_cpu(page->pp, page, buf->offset, len);

Is there a reason why page_pool_dma_sync_for_cpu() is still used when
page_pool_create() is called with PP_FLAG_DMA_SYNC_DEV flag? Isn't syncing
already handled in page_pool core when when PP_FLAG_DMA_SYNC_DEV flag is
set?

> +
> +	return true;
> +}
>  
>  /* O(1) converting i40e/ice/iavf's 8/10-bit hardware packet type to a parsed
>   * bitfield struct.
> 

