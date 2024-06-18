Return-Path: <netdev+bounces-104647-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2DB490DB83
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 20:21:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BA5F28357D
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 18:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48DC915E5AA;
	Tue, 18 Jun 2024 18:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q2e3ALcd"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6499716B3AE
	for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 18:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718734709; cv=none; b=l9u5t/AtBlxXFZL3FT518xohqvSfiXPlld071LbuC94yVQKmOH8QmD+FEttMhfE31I7Qqov9DXD94IEzDV4Sgds7+hTz0P4SHVq7hVApLyiq3bH9muO0Lm/coP3+3/GEeS2/VRK6/696HF9hQPnt77hnmTqbfGFkANFKqGutV4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718734709; c=relaxed/simple;
	bh=53/UZlpcde7bPj4zvQFWC80YNaemyVPKC8nKJUgvPdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u1KjOZQZ7svZG7F549VvIR/QWVTpWWLS7afFuBGo9C+eBjOgWOTKqGOQKeSZhuoJMaV69yr+uNcNELbAaj/i3+VqZI2d0pV056hX+RWeVOC6mgl2nThqs+uoCF/xxgeLX02t7pk1DuOrq5BY407ZXZ8RFQqFYjpCD3U/ZjMi3LU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q2e3ALcd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718734705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N1tOtryDE2wA39qo5ZepffFCMBfFRHRUF+N5n+je4Q0=;
	b=Q2e3ALcddDZw8SC/rkgQQXQkvQPc4YqVbPrl4ABii+/uMIJmfFcHTCnwImElbLHIntQX1Q
	v5xhAOePjxCkTWwV+SXuJBz79LR7q2pZF+xyfFBMqPd2UbBxNhLuvulJBeojjk5t73Jsg6
	EqTE3G6LxAMx+xYG7733PMTb2s9ByzY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-323-czHb8kyaOw2LxTIvp_t5Fw-1; Tue, 18 Jun 2024 14:18:18 -0400
X-MC-Unique: czHb8kyaOw2LxTIvp_t5Fw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42108822a8eso409355e9.0
        for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 11:18:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718734697; x=1719339497;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N1tOtryDE2wA39qo5ZepffFCMBfFRHRUF+N5n+je4Q0=;
        b=PeqViMOg1zlpK8VL69uWMVL1ob2Jz1SS26tBKZlexQaHnBhfwtthTlZ1d9XDWH4Gyc
         1Qlddv3qdhLqSKlmE+bbQgIapWALv79bcE5U0vtie+dKztBUZztjPM1eNz+ILq8tfDf/
         UJfz4pU//o+rBlJQnbkyxyj9v/mnd7Ohz11AdZeWHjiHUblB/HAuAcfeGD/tBHNt61Ea
         aKUWHAnmJPVSIL+/BH+5qiatprT1ctv3ZU1KlNvBAvtDxr530T9gjrJv34vrYXWGFrUB
         uAF5NBZciFkSSqzd8mNb6H4+e4EuNMCS9IZPIVv8Za0cjHGpnmjTtQ9eXQzTJhct900q
         raKA==
X-Gm-Message-State: AOJu0YyKojio5RmAVZu5mbJtYZ2h8Fut4HmVt175QZAafNzDmAT5ZTu6
	bB2H+ga6/3VPv5uwP4lImO3gnkZ/yh0kaQruWhoWOYH5OMFttGiEhwHsoJTTFzD8iQUN0bQpbpM
	pmoajphjxYGJdELof+tzaW8c2P4t3meM53iSuMh3jA/I/pjaSxwn61Q==
X-Received: by 2002:a05:600c:511d:b0:421:b65d:2235 with SMTP id 5b1f17b1804b1-42474cb7e2fmr7229015e9.0.1718734697290;
        Tue, 18 Jun 2024 11:18:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJS8TBXNx5DGbLEW/NLJQv+1vHiAaAYr5kEpYAsFyI+86UU/ozr7+DLGglneoVzWRkAdDp6A==
X-Received: by 2002:a05:600c:511d:b0:421:b65d:2235 with SMTP id 5b1f17b1804b1-42474cb7e2fmr7228635e9.0.1718734696419;
        Tue, 18 Jun 2024 11:18:16 -0700 (PDT)
Received: from redhat.com ([2a02:14f:17c:d4a1:48dc:2f16:ab1d:e55a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422870e9676sm230816975e9.24.2024.06.18.11.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 11:18:15 -0700 (PDT)
Date: Tue, 18 Jun 2024 14:18:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev,
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
	john.fastabend@gmail.com, dave.taht@gmail.com,
	kerneljasonxing@gmail.com, hengqi@linux.alibaba.com
Subject: Re: [PATCH net-next v3] virtio_net: add support for Byte Queue Limits
Message-ID: <20240618140326-mutt-send-email-mst@kernel.org>
References: <20240618144456.1688998-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618144456.1688998-1-jiri@resnulli.us>

This looks like a sensible way to do this.
Yet something to improve:


On Tue, Jun 18, 2024 at 04:44:56PM +0200, Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> Add support for Byte Queue Limits (BQL).
> 
> Tested on qemu emulated virtio_net device with 1, 2 and 4 queues.
> Tested with fq_codel and pfifo_fast. Super netperf with 50 threads is
> running in background. Netperf TCP_RR results:
> 
> NOBQL FQC 1q:  159.56  159.33  158.50  154.31    agv: 157.925
> NOBQL FQC 2q:  184.64  184.96  174.73  174.15    agv: 179.62
> NOBQL FQC 4q:  994.46  441.96  416.50  499.56    agv: 588.12
> NOBQL PFF 1q:  148.68  148.92  145.95  149.48    agv: 148.2575
> NOBQL PFF 2q:  171.86  171.20  170.42  169.42    agv: 170.725
> NOBQL PFF 4q: 1505.23 1137.23 2488.70 3507.99    agv: 2159.7875
>   BQL FQC 1q: 1332.80 1297.97 1351.41 1147.57    agv: 1282.4375
>   BQL FQC 2q:  768.30  817.72  864.43  974.40    agv: 856.2125
>   BQL FQC 4q:  945.66  942.68  878.51  822.82    agv: 897.4175
>   BQL PFF 1q:  149.69  151.49  149.40  147.47    agv: 149.5125
>   BQL PFF 2q: 2059.32  798.74 1844.12  381.80    agv: 1270.995
>   BQL PFF 4q: 1871.98 4420.02 4916.59 13268.16   agv: 6119.1875
> 
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> ---
> v2->v3:
> - fixed the switch from/to orphan mode while skbs are yet to be
>   completed by using the second least significant bit in virtqueue
>   token pointer to indicate skb is orphan. Don't account orphan
>   skbs in completion.
> - reorganized parallel skb/xdp free stats accounting to napi/others.
> - fixed kick condition check in orphan mode
> v1->v2:
> - moved netdev_tx_completed_queue() call into __free_old_xmit(),
>   propagate use_napi flag to __free_old_xmit() and only call
>   netdev_tx_completed_queue() in case it is true
> - added forgotten call to netdev_tx_reset_queue()
> - fixed stats for xdp packets
> - fixed bql accounting when __free_old_xmit() is called from xdp path
> - handle the !use_napi case in start_xmit() kick section
> ---
>  drivers/net/virtio_net.c | 81 ++++++++++++++++++++++++++++------------
>  1 file changed, 57 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 61a57d134544..9f9b86874173 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -47,7 +47,8 @@ module_param(napi_tx, bool, 0644);
>  #define VIRTIO_XDP_TX		BIT(0)
>  #define VIRTIO_XDP_REDIR	BIT(1)
>  
> -#define VIRTIO_XDP_FLAG	BIT(0)
> +#define VIRTIO_XDP_FLAG		BIT(0)
> +#define VIRTIO_ORPHAN_FLAG	BIT(1)
>  
>  /* RX packet size EWMA. The average packet size is used to determine the packet
>   * buffer size when refilling RX rings. As the entire RX ring may be refilled
> @@ -85,6 +86,8 @@ struct virtnet_stat_desc {
>  struct virtnet_sq_free_stats {
>  	u64 packets;
>  	u64 bytes;
> +	u64 napi_packets;
> +	u64 napi_bytes;
>  };
>  
>  struct virtnet_sq_stats {
> @@ -506,29 +509,50 @@ static struct xdp_frame *ptr_to_xdp(void *ptr)
>  	return (struct xdp_frame *)((unsigned long)ptr & ~VIRTIO_XDP_FLAG);
>  }
>  
> -static void __free_old_xmit(struct send_queue *sq, bool in_napi,
> -			    struct virtnet_sq_free_stats *stats)
> +static bool is_orphan_skb(void *ptr)
> +{
> +	return (unsigned long)ptr & VIRTIO_ORPHAN_FLAG;
> +}
> +
> +static void *skb_to_ptr(struct sk_buff *skb, bool orphan)
> +{
> +	return (void *)((unsigned long)skb | (orphan ? VIRTIO_ORPHAN_FLAG : 0));
> +}
> +
> +static struct sk_buff *ptr_to_skb(void *ptr)
> +{
> +	return (struct sk_buff *)((unsigned long)ptr & ~VIRTIO_ORPHAN_FLAG);
> +}
> +
> +static void __free_old_xmit(struct send_queue *sq, struct netdev_queue *txq,
> +			    bool in_napi, struct virtnet_sq_free_stats *stats)
>  {
>  	unsigned int len;
>  	void *ptr;
>  
>  	while ((ptr = virtqueue_get_buf(sq->vq, &len)) != NULL) {
> -		++stats->packets;
> -
>  		if (!is_xdp_frame(ptr)) {
> -			struct sk_buff *skb = ptr;
> +			struct sk_buff *skb = ptr_to_skb(ptr);
>  
>  			pr_debug("Sent skb %p\n", skb);
>  
> -			stats->bytes += skb->len;
> +			if (is_orphan_skb(ptr)) {
> +				stats->packets++;
> +				stats->bytes += skb->len;
> +			} else {
> +				stats->napi_packets++;
> +				stats->napi_bytes += skb->len;
> +			}
>  			napi_consume_skb(skb, in_napi);
>  		} else {
>  			struct xdp_frame *frame = ptr_to_xdp(ptr);
>  
> +			stats->packets++;
>  			stats->bytes += xdp_get_frame_len(frame);
>  			xdp_return_frame(frame);
>  		}
>  	}
> +	netdev_tx_completed_queue(txq, stats->napi_packets, stats->napi_bytes);

Are you sure it's right? You are completing larger and larger
number of bytes and packets each time.

For example as won't this eventually trigger this inside dql_completed:

        BUG_ON(count > num_queued - dql->num_completed);

?


If I am right the perf testing has to be redone with this fixed ...


>  }
>  
>  /* Converting between virtqueue no. and kernel tx/rx queue no.
> @@ -955,21 +979,22 @@ static void virtnet_rq_unmap_free_buf(struct virtqueue *vq, void *buf)
>  	virtnet_rq_free_buf(vi, rq, buf);
>  }
>  
> -static void free_old_xmit(struct send_queue *sq, bool in_napi)
> +static void free_old_xmit(struct send_queue *sq, struct netdev_queue *txq,
> +			  bool in_napi)
>  {
>  	struct virtnet_sq_free_stats stats = {0};
>  
> -	__free_old_xmit(sq, in_napi, &stats);
> +	__free_old_xmit(sq, txq, in_napi, &stats);
>  
>  	/* Avoid overhead when no packets have been processed
>  	 * happens when called speculatively from start_xmit.
>  	 */
> -	if (!stats.packets)
> +	if (!stats.packets && !stats.napi_packets)
>  		return;
>  
>  	u64_stats_update_begin(&sq->stats.syncp);
> -	u64_stats_add(&sq->stats.bytes, stats.bytes);
> -	u64_stats_add(&sq->stats.packets, stats.packets);
> +	u64_stats_add(&sq->stats.bytes, stats.bytes + stats.napi_bytes);
> +	u64_stats_add(&sq->stats.packets, stats.packets + stats.napi_packets);
>  	u64_stats_update_end(&sq->stats.syncp);
>  }
>  
> @@ -1003,7 +1028,9 @@ static void check_sq_full_and_disable(struct virtnet_info *vi,
>  	 * early means 16 slots are typically wasted.
>  	 */
>  	if (sq->vq->num_free < 2+MAX_SKB_FRAGS) {
> -		netif_stop_subqueue(dev, qnum);
> +		struct netdev_queue *txq = netdev_get_tx_queue(dev, qnum);
> +
> +		netif_tx_stop_queue(txq);
>  		u64_stats_update_begin(&sq->stats.syncp);
>  		u64_stats_inc(&sq->stats.stop);
>  		u64_stats_update_end(&sq->stats.syncp);
> @@ -1012,7 +1039,7 @@ static void check_sq_full_and_disable(struct virtnet_info *vi,
>  				virtqueue_napi_schedule(&sq->napi, sq->vq);
>  		} else if (unlikely(!virtqueue_enable_cb_delayed(sq->vq))) {
>  			/* More just got used, free them then recheck. */
> -			free_old_xmit(sq, false);
> +			free_old_xmit(sq, txq, false);
>  			if (sq->vq->num_free >= 2+MAX_SKB_FRAGS) {
>  				netif_start_subqueue(dev, qnum);
>  				u64_stats_update_begin(&sq->stats.syncp);
> @@ -1138,7 +1165,8 @@ static int virtnet_xdp_xmit(struct net_device *dev,
>  	}
>  
>  	/* Free up any pending old buffers before queueing new ones. */
> -	__free_old_xmit(sq, false, &stats);
> +	__free_old_xmit(sq, netdev_get_tx_queue(dev, sq - vi->sq),
> +			false, &stats);
>  
>  	for (i = 0; i < n; i++) {
>  		struct xdp_frame *xdpf = frames[i];
> @@ -2313,7 +2341,7 @@ static void virtnet_poll_cleantx(struct receive_queue *rq)
>  
>  		do {
>  			virtqueue_disable_cb(sq->vq);
> -			free_old_xmit(sq, true);
> +			free_old_xmit(sq, txq, true);
>  		} while (unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
>  
>  		if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS) {
> @@ -2412,6 +2440,7 @@ static int virtnet_enable_queue_pair(struct virtnet_info *vi, int qp_index)
>  		goto err_xdp_reg_mem_model;
>  
>  	virtnet_napi_enable(vi->rq[qp_index].vq, &vi->rq[qp_index].napi);
> +	netdev_tx_reset_queue(netdev_get_tx_queue(vi->dev, qp_index));
>  	virtnet_napi_tx_enable(vi, vi->sq[qp_index].vq, &vi->sq[qp_index].napi);
>  
>  	return 0;
> @@ -2471,7 +2500,7 @@ static int virtnet_poll_tx(struct napi_struct *napi, int budget)
>  	txq = netdev_get_tx_queue(vi->dev, index);
>  	__netif_tx_lock(txq, raw_smp_processor_id());
>  	virtqueue_disable_cb(sq->vq);
> -	free_old_xmit(sq, true);
> +	free_old_xmit(sq, txq, true);
>  
>  	if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS) {
>  		if (netif_tx_queue_stopped(txq)) {
> @@ -2505,7 +2534,7 @@ static int virtnet_poll_tx(struct napi_struct *napi, int budget)
>  	return 0;
>  }
>  
> -static int xmit_skb(struct send_queue *sq, struct sk_buff *skb)
> +static int xmit_skb(struct send_queue *sq, struct sk_buff *skb, bool orphan)
>  {
>  	struct virtio_net_hdr_mrg_rxbuf *hdr;
>  	const unsigned char *dest = ((struct ethhdr *)skb->data)->h_dest;
> @@ -2549,7 +2578,8 @@ static int xmit_skb(struct send_queue *sq, struct sk_buff *skb)
>  			return num_sg;
>  		num_sg++;
>  	}
> -	return virtqueue_add_outbuf(sq->vq, sq->sg, num_sg, skb, GFP_ATOMIC);
> +	return virtqueue_add_outbuf(sq->vq, sq->sg, num_sg,
> +				    skb_to_ptr(skb, orphan), GFP_ATOMIC);
>  }
>  
>  static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
> @@ -2559,24 +2589,25 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
>  	struct send_queue *sq = &vi->sq[qnum];
>  	int err;
>  	struct netdev_queue *txq = netdev_get_tx_queue(dev, qnum);
> -	bool kick = !netdev_xmit_more();
> +	bool xmit_more = netdev_xmit_more();
>  	bool use_napi = sq->napi.weight;
> +	bool kick;
>  
>  	/* Free up any pending old buffers before queueing new ones. */
>  	do {
>  		if (use_napi)
>  			virtqueue_disable_cb(sq->vq);
>  
> -		free_old_xmit(sq, false);
> +		free_old_xmit(sq, txq, false);
>  
> -	} while (use_napi && kick &&
> +	} while (use_napi && !xmit_more &&
>  	       unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
>  
>  	/* timestamp packet in software */
>  	skb_tx_timestamp(skb);
>  
>  	/* Try to transmit */
> -	err = xmit_skb(sq, skb);
> +	err = xmit_skb(sq, skb, !use_napi);
>  
>  	/* This should not happen! */
>  	if (unlikely(err)) {
> @@ -2598,7 +2629,9 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
>  
>  	check_sq_full_and_disable(vi, dev, sq);
>  
> -	if (kick || netif_xmit_stopped(txq)) {
> +	kick = use_napi ? __netdev_tx_sent_queue(txq, skb->len, xmit_more) :
> +			  !xmit_more || netif_xmit_stopped(txq);
> +	if (kick) {
>  		if (virtqueue_kick_prepare(sq->vq) && virtqueue_notify(sq->vq)) {
>  			u64_stats_update_begin(&sq->stats.syncp);
>  			u64_stats_inc(&sq->stats.kicks);
> -- 
> 2.45.1


