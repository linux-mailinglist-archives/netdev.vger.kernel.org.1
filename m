Return-Path: <netdev+bounces-15791-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC78A749C66
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 14:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD6D41C20D96
	for <lists+netdev@lfdr.de>; Thu,  6 Jul 2023 12:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B4C8F70;
	Thu,  6 Jul 2023 12:48:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61A88F71
	for <netdev@vger.kernel.org>; Thu,  6 Jul 2023 12:48:08 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B1B21FFA;
	Thu,  6 Jul 2023 05:47:42 -0700 (PDT)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.56])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Qxbrb2f3DzqSMc;
	Thu,  6 Jul 2023 20:46:55 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 6 Jul
 2023 20:47:22 +0800
Subject: Re: [PATCH RFC net-next v4 6/9] iavf: switch to Page Pool
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
References: <20230705155551.1317583-1-aleksander.lobakin@intel.com>
 <20230705155551.1317583-7-aleksander.lobakin@intel.com>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <6b8bc66f-8a02-b6b4-92cc-f8aaf067abd8@huawei.com>
Date: Thu, 6 Jul 2023 20:47:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230705155551.1317583-7-aleksander.lobakin@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.30.204]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023/7/5 23:55, Alexander Lobakin wrote:
> Now that the IAVF driver simply uses dev_alloc_page() + free_page() with
> no custom recycling logics, it can easily be switched to using Page
> Pool / libie API instead.
> This allows to removing the whole dancing around headroom, HW buffer
> size, and page order. All DMA-for-device is now done in the PP core,
> for-CPU -- in the libie helper.
> Use skb_mark_for_recycle() to bring back the recycling and restore the
> performance. Speaking of performance: on par with the baseline and
> faster with the PP optimization series applied. But the memory usage for
> 1500b MTU is now almost 2x lower (x86_64) thanks to allocating a page
> every second descriptor.
> 
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> ---

...

> @@ -2562,11 +2541,7 @@ static void iavf_init_config_adapter(struct iavf_adapter *adapter)
>  
>  	netdev->netdev_ops = &iavf_netdev_ops;
>  	iavf_set_ethtool_ops(netdev);
> -	netdev->watchdog_timeo = 5 * HZ;

This seems like a unrelated change here?

> -
> -	/* MTU range: 68 - 9710 */
> -	netdev->min_mtu = ETH_MIN_MTU;
> -	netdev->max_mtu = IAVF_MAX_RXBUFFER - IAVF_PACKET_HDR_PAD;
> +	netdev->max_mtu = LIBIE_MAX_MTU;
>  

...

>  /**
> @@ -766,13 +742,19 @@ void iavf_free_rx_resources(struct iavf_ring *rx_ring)
>   **/
>  int iavf_setup_rx_descriptors(struct iavf_ring *rx_ring)
>  {
> -	struct device *dev = rx_ring->dev;
> -	int bi_size;
> +	struct page_pool *pool;
> +
> +	pool = libie_rx_page_pool_create(&rx_ring->q_vector->napi,
> +					 rx_ring->count);

If a page is able to be spilt between more than one desc, perhaps the
prt_ring size does not need to be as big as rx_ring->count.

> +	if (IS_ERR(pool))
> +		return PTR_ERR(pool);
> +
> +	rx_ring->pp = pool;
>  
>  	/* warn if we are about to overwrite the pointer */
>  	WARN_ON(rx_ring->rx_bi);
> -	bi_size = sizeof(struct iavf_rx_buffer) * rx_ring->count;
> -	rx_ring->rx_bi = kzalloc(bi_size, GFP_KERNEL);
> +	rx_ring->rx_bi = kcalloc(rx_ring->count, sizeof(*rx_ring->rx_bi),
> +				 GFP_KERNEL);
>  	if (!rx_ring->rx_bi)
>  		goto err;
>  

...

>  
>  /**
>   * iavf_build_skb - Build skb around an existing buffer
> - * @rx_ring: Rx descriptor ring to transact packets on
>   * @rx_buffer: Rx buffer to pull data from
>   * @size: size of buffer to add to skb
>   *
>   * This function builds an skb around an existing Rx buffer, taking care
>   * to set up the skb correctly and avoid any memcpy overhead.
>   */
> -static struct sk_buff *iavf_build_skb(struct iavf_ring *rx_ring,
> -				      struct iavf_rx_buffer *rx_buffer,
> +static struct sk_buff *iavf_build_skb(const struct libie_rx_buffer *rx_buffer,
>  				      unsigned int size)
>  {
> -	void *va;
> -#if (PAGE_SIZE < 8192)
> -	unsigned int truesize = iavf_rx_pg_size(rx_ring) / 2;
> -#else
> -	unsigned int truesize = SKB_DATA_ALIGN(sizeof(struct skb_shared_info)) +
> -				SKB_DATA_ALIGN(IAVF_SKB_PAD + size);
> -#endif
> +	struct page *page = rx_buffer->page;
> +	u32 hr = page->pp->p.offset;
>  	struct sk_buff *skb;
> +	void *va;
>  
> -	if (!rx_buffer || !size)
> -		return NULL;
>  	/* prefetch first cache line of first page */
> -	va = page_address(rx_buffer->page) + rx_buffer->page_offset;
> -	net_prefetch(va);
> +	va = page_address(page) + rx_buffer->offset;
> +	net_prefetch(va + hr);
>  
>  	/* build an skb around the page buffer */
> -	skb = napi_build_skb(va - IAVF_SKB_PAD, truesize);
> -	if (unlikely(!skb))
> +	skb = napi_build_skb(va, rx_buffer->truesize);
> +	if (unlikely(!skb)) {
> +		page_pool_put_page(page->pp, page, size, true);

Isn't it more correct to call page_pool_put_full_page() here?
as we do not know which frag is used for the rx_buffer, and depend
on the last released frag to do the syncing, maybe I should mention
that in Documentation/networking/page_pool.rst.

>  		return NULL;
> +	}

...

>  struct iavf_queue_stats {
>  	u64 packets;
>  	u64 bytes;
> @@ -311,16 +243,19 @@ enum iavf_ring_state_t {
>  struct iavf_ring {
>  	struct iavf_ring *next;		/* pointer to next ring in q_vector */
>  	void *desc;			/* Descriptor ring memory */
> -	struct device *dev;		/* Used for DMA mapping */
> +	union {
> +		struct page_pool *pp;	/* Used on Rx for buffer management */
> +		struct device *dev;	/* Used on Tx for DMA mapping */
> +	};
>  	struct net_device *netdev;	/* netdev ring maps to */
>  	union {
> +		struct libie_rx_buffer *rx_bi;
>  		struct iavf_tx_buffer *tx_bi;
> -		struct iavf_rx_buffer *rx_bi;
>  	};
>  	DECLARE_BITMAP(state, __IAVF_RING_STATE_NBITS);
> +	u8 __iomem *tail;

Is there a reason to move it here?

>  	u16 queue_index;		/* Queue number of ring */
>  	u8 dcb_tc;			/* Traffic class of ring */
> -	u8 __iomem *tail;
>  


