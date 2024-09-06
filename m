Return-Path: <netdev+bounces-125873-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC47096F101
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 12:07:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8FDD1C24D8E
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 10:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3520E1C9DD1;
	Fri,  6 Sep 2024 10:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="dqIdlrn7"
X-Original-To: netdev@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2D117ADEE;
	Fri,  6 Sep 2024 10:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725617222; cv=none; b=j6k4LGnJLvmlV0bZ3x7o6WO8ZsXgSUA1Pjq6ib5CTZ0gKhW7GHRkbIxSOMtdzHD7L1zYRPM9McBfZ+0dbh5x9NwTMWVSZotOc9GufYMNwdUCv1bmolWjIAxIa+Y1l23F/y0rQn2izzERjdx8UX454n0cgYSQHlcsLk9F2h1nsw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725617222; c=relaxed/simple;
	bh=Vvfx+DN5LVJ7Yt+aMpFXoAP8ef73GTzrgDyn8WgBGaM=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=Kfmhw1PTiBKBPD9wQNZzxFOR+4YaAnBCkWcRRQyWvSvk8by3/2BhC2pJnfVacqTbqkW0V4t8Vp7Ku1d7VIAenSQ1Sz98NZSPrgL50+IbAQY68qafPiqK3wE5Rj7hdQObSmea21GDbSiOW6W0yQA9nM6csj+OG8Bix2Q1+UCWwlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=dqIdlrn7; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1725617216; h=Message-ID:Subject:Date:From:To;
	bh=CUwG9aKobr3Qs9tubSmlRPOgMBUlhS4JCNVLHhUPh/8=;
	b=dqIdlrn7OOh14YZvIUL35G7itUjKchy524zy2Y4Zx3bmMMoFih5XzR3p+yjEIppyJE7CB5RzQD7JVhRtJVlbpx12S8hdId3ZvpO7L0qZqoxzv8aEexDEggTnAaWP9rDYz+e8faZhrEUrxJiXotegutoZP0MRriIPr4pI9cBM2L8=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WEP7DNV_1725617214)
          by smtp.aliyun-inc.com;
          Fri, 06 Sep 2024 18:06:55 +0800
Message-ID: <1725616970.1687496-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [RFC PATCH v2 5/7] Revert "virtio_net: rx remove premapped failover code"
Date: Fri, 6 Sep 2024 18:02:50 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 virtualization@lists.linux.dev,
 "Si-Wei Liu" <si-wei.liu@oracle.com>,
 Darren Kenny <darren.kenny@oracle.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
References: <cover.1725616135.git.mst@redhat.com>
 <69d3032b6560323844d6d9fb0ac4f832ed87f13d.1725616135.git.mst@redhat.com>
In-Reply-To: <69d3032b6560323844d6d9fb0ac4f832ed87f13d.1725616135.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Fri, 6 Sep 2024 05:52:36 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> This reverts commit defd28aa5acb0fd7c15adc6bc40a8ac277d04dea.
>
> leads to crashes with no ACCESS_PLATFORM when
> sysctl net.core.high_order_alloc_disable=1
>
> Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> Reported-by: Si-Wei Liu <si-wei.liu@oracle.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  drivers/net/virtio_net.c | 89 +++++++++++++++++++++++-----------------
>  1 file changed, 52 insertions(+), 37 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 0944430dfb1f..0a2ec9570521 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -348,6 +348,9 @@ struct receive_queue {
>
>  	/* Record the last dma info to free after new pages is allocated. */
>  	struct virtnet_rq_dma *last_dma;
> +
> +	/* Do dma by self */
> +	bool do_dma;
>  };
>
>  /* This structure can contain rss message with maximum settings for indirection table and keysize
> @@ -867,7 +870,7 @@ static void *virtnet_rq_get_buf(struct receive_queue *rq, u32 *len, void **ctx)
>  	void *buf;
>
>  	buf = virtqueue_get_buf_ctx(rq->vq, len, ctx);
> -	if (buf)
> +	if (buf && rq->do_dma)
>  		virtnet_rq_unmap(rq, buf, *len);
>
>  	return buf;
> @@ -880,6 +883,11 @@ static void virtnet_rq_init_one_sg(struct receive_queue *rq, void *buf, u32 len)
>  	u32 offset;
>  	void *head;
>
> +	if (!rq->do_dma) {
> +		sg_init_one(rq->sg, buf, len);
> +		return;
> +	}
> +
>  	head = page_address(rq->alloc_frag.page);
>
>  	offset = buf - head;
> @@ -905,42 +913,44 @@ static void *virtnet_rq_alloc(struct receive_queue *rq, u32 size, gfp_t gfp)
>
>  	head = page_address(alloc_frag->page);
>
> -	dma = head;
> +	if (rq->do_dma) {
> +		dma = head;
>
> -	/* new pages */
> -	if (!alloc_frag->offset) {
> -		if (rq->last_dma) {
> -			/* Now, the new page is allocated, the last dma
> -			 * will not be used. So the dma can be unmapped
> -			 * if the ref is 0.
> +		/* new pages */
> +		if (!alloc_frag->offset) {
> +			if (rq->last_dma) {
> +				/* Now, the new page is allocated, the last dma
> +				 * will not be used. So the dma can be unmapped
> +				 * if the ref is 0.
> +				 */
> +				virtnet_rq_unmap(rq, rq->last_dma, 0);
> +				rq->last_dma = NULL;
> +			}
> +
> +			dma->len = alloc_frag->size - sizeof(*dma);
> +
> +			addr = virtqueue_dma_map_single_attrs(rq->vq, dma + 1,
> +							      dma->len, DMA_FROM_DEVICE, 0);
> +			if (virtqueue_dma_mapping_error(rq->vq, addr))
> +				return NULL;
> +
> +			dma->addr = addr;
> +			dma->need_sync = virtqueue_dma_need_sync(rq->vq, addr);
> +
> +			/* Add a reference to dma to prevent the entire dma from
> +			 * being released during error handling. This reference
> +			 * will be freed after the pages are no longer used.
>  			 */
> -			virtnet_rq_unmap(rq, rq->last_dma, 0);
> -			rq->last_dma = NULL;
> +			get_page(alloc_frag->page);
> +			dma->ref = 1;
> +			alloc_frag->offset = sizeof(*dma);
> +
> +			rq->last_dma = dma;
>  		}
>
> -		dma->len = alloc_frag->size - sizeof(*dma);
> -
> -		addr = virtqueue_dma_map_single_attrs(rq->vq, dma + 1,
> -						      dma->len, DMA_FROM_DEVICE, 0);
> -		if (virtqueue_dma_mapping_error(rq->vq, addr))
> -			return NULL;
> -
> -		dma->addr = addr;
> -		dma->need_sync = virtqueue_dma_need_sync(rq->vq, addr);
> -
> -		/* Add a reference to dma to prevent the entire dma from
> -		 * being released during error handling. This reference
> -		 * will be freed after the pages are no longer used.
> -		 */
> -		get_page(alloc_frag->page);
> -		dma->ref = 1;
> -		alloc_frag->offset = sizeof(*dma);
> -
> -		rq->last_dma = dma;
> +		++dma->ref;
>  	}
>
> -	++dma->ref;
> -
>  	buf = head + alloc_frag->offset;
>
>  	get_page(alloc_frag->page);
> @@ -957,9 +967,12 @@ static void virtnet_rq_set_premapped(struct virtnet_info *vi)
>  	if (!vi->mergeable_rx_bufs && vi->big_packets)
>  		return;
>
> -	for (i = 0; i < vi->max_queue_pairs; i++)
> -		/* error should never happen */
> -		BUG_ON(virtqueue_set_dma_premapped(vi->rq[i].vq));
> +	for (i = 0; i < vi->max_queue_pairs; i++) {
> +		if (virtqueue_set_dma_premapped(vi->rq[i].vq))
> +			continue;
> +
> +		vi->rq[i].do_dma = true;
> +	}

This is too much code to revert. We can just revert this and next one.
And add a patch to turn off the default premapped setting (return from this
function directly). Otherwise, we will have to do all the work again in the
future.

There is no need to revert xsk related code, xsk function cannot be enabled, in
the case that premapped mode is not turned on. There is no direct impact itself.

Thanks.


>  }
>
>  static void virtnet_rq_unmap_free_buf(struct virtqueue *vq, void *buf)
> @@ -2107,7 +2120,8 @@ static int add_recvbuf_small(struct virtnet_info *vi, struct receive_queue *rq,
>
>  	err = virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1, buf, ctx, gfp);
>  	if (err < 0) {
> -		virtnet_rq_unmap(rq, buf, 0);
> +		if (rq->do_dma)
> +			virtnet_rq_unmap(rq, buf, 0);
>  		put_page(virt_to_head_page(buf));
>  	}
>
> @@ -2221,7 +2235,8 @@ static int add_recvbuf_mergeable(struct virtnet_info *vi,
>  	ctx = mergeable_len_to_ctx(len + room, headroom);
>  	err = virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1, buf, ctx, gfp);
>  	if (err < 0) {
> -		virtnet_rq_unmap(rq, buf, 0);
> +		if (rq->do_dma)
> +			virtnet_rq_unmap(rq, buf, 0);
>  		put_page(virt_to_head_page(buf));
>  	}
>
> @@ -5392,7 +5407,7 @@ static void free_receive_page_frags(struct virtnet_info *vi)
>  	int i;
>  	for (i = 0; i < vi->max_queue_pairs; i++)
>  		if (vi->rq[i].alloc_frag.page) {
> -			if (vi->rq[i].last_dma)
> +			if (vi->rq[i].do_dma && vi->rq[i].last_dma)
>  				virtnet_rq_unmap(&vi->rq[i], vi->rq[i].last_dma, 0);
>  			put_page(vi->rq[i].alloc_frag.page);
>  		}
> --
> MST
>

