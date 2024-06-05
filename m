Return-Path: <netdev+bounces-100966-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D2EA8FCB8E
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 14:03:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 623A81C20CFC
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 12:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863871993A0;
	Wed,  5 Jun 2024 11:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="nvTD8LGX"
X-Original-To: netdev@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF40199388
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 11:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717588315; cv=none; b=ZVhrV0TzkESIQLu1O76MRS4gSyToZXr33vCK9OdDYT2JOGgBeVyaXDU4R4FfkPyNWvnXA8hGzMLn7snRtNEWUx4z80W8rrCCkeCIuTHvX+KArmnPw97asNf1WWRWKesH6HGUgrJggfPkEqKqcp7l1rmeI3qOy3Oyu87H0fP5hMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717588315; c=relaxed/simple;
	bh=nX56YmrH6jSRhi41cg1jOIdrYXQfmvVg6w6IJ0y5FeI=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=Uun/SEA6vkVeVFvbq8KbdQLRecoRUi8pJdgpYi+HWkSrdrluTMZt8DnUkRiOCQM8sR9QtjSe1psledZWmrulRGMRFk6CAwkdw1KQXYKsn7+Oy1Hd5HfQz2EcbxguYCOgaxK4g353JRgtfQ1/aAPRzxt/7rrmU0eOvqQ0N4rFQ4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=nvTD8LGX; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717588305; h=Message-ID:Subject:Date:From:To;
	bh=9c5VJz2MI2/0urY/Ud9QJgSdUZNjOpj7ksVhnnGqaRE=;
	b=nvTD8LGX7gpY9SvqV7C+Xsis6y/szaN4IEtOm9i6WUKYTBwKjmFpGTFqeTcsHkffBsdiGeAXSi46hACmweo2Q85s+2kyhyR1SQKvReagrIjBfepVDBMj0Oy76skEj0qFcbf6oOHFDIOCBzeYY2mQDGayntbcCPSib9EHN/C3NQI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067113;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0W7vCRx5_1717588303;
Received: from localhost(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W7vCRx5_1717588303)
          by smtp.aliyun-inc.com;
          Wed, 05 Jun 2024 19:51:44 +0800
Message-ID: <1717587768.1588957-5-hengqi@linux.alibaba.com>
Subject: Re: [patch net-next] virtio_net: add support for Byte Queue Limits
Date: Wed, 5 Jun 2024 19:42:48 +0800
From: Heng Qi <hengqi@linux.alibaba.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: davem@davemloft.net,
 edumazet@google.com,
 kuba@kernel.org,
 pabeni@redhat.com,
 mst@redhat.com,
 jasowang@redhat.com,
 xuanzhuo@linux.alibaba.com,
 virtualization@lists.linux.dev,
 ast@kernel.org,
 daniel@iogearbox.net,
 hawk@kernel.org,
 john.fastabend@gmail.com,
 netdev@vger.kernel.org
References: <20240509114615.317450-1-jiri@resnulli.us>
 <1715325076.4219763-2-hengqi@linux.alibaba.com>
 <ZktGj4nDU4X0Lxtx@nanopsycho.orion>
 <ZmBMa7Am3LIYQw1x@nanopsycho.orion>
In-Reply-To: <ZmBMa7Am3LIYQw1x@nanopsycho.orion>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Wed, 5 Jun 2024 13:30:51 +0200, Jiri Pirko <jiri@resnulli.us> wrote:
> Mon, May 20, 2024 at 02:48:15PM CEST, jiri@resnulli.us wrote:
> >Fri, May 10, 2024 at 09:11:16AM CEST, hengqi@linux.alibaba.com wrote:
> >>On Thu,  9 May 2024 13:46:15 +0200, Jiri Pirko <jiri@resnulli.us> wrote:
> >>> From: Jiri Pirko <jiri@nvidia.com>
> >>> 
> >>> Add support for Byte Queue Limits (BQL).
> >>
> >>Historically both Jason and Michael have attempted to support BQL
> >>for virtio-net, for example:
> >>
> >>https://lore.kernel.org/netdev/21384cb5-99a6-7431-1039-b356521e1bc3@redhat.com/
> >>
> >>These discussions focus primarily on:
> >>
> >>1. BQL is based on napi tx. Therefore, the transfer of statistical information
> >>needs to rely on the judgment of use_napi. When the napi mode is switched to
> >>orphan, some statistical information will be lost, resulting in temporary
> >>inaccuracy in BQL.
> >>
> >>2. If tx dim is supported, orphan mode may be removed and tx irq will be more
> >>reasonable. This provides good support for BQL.
> >
> >But when the device does not support dim, the orphan mode is still
> >needed, isn't it?
> 
> Heng, is my assuption correct here? Thanks!
> 

Maybe, according to our cloud data, napi_tx=on works better than orphan mode in
most scenarios. Although orphan mode performs better in specific benckmark,
perf of napi_tx can be enhanced through tx dim. Then, there is no reason not to
support dim for devices that want the best performance.

Back to this patch set, I think BQL as a point that affects performance should
deserve more comprehensive test data.

Thanks.

> >
> >>
> >>Thanks.
> >>
> >>> 
> >>> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> >>> ---
> >>>  drivers/net/virtio_net.c | 33 ++++++++++++++++++++-------------
> >>>  1 file changed, 20 insertions(+), 13 deletions(-)
> >>> 
> >>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> >>> index 218a446c4c27..c53d6dc6d332 100644
> >>> --- a/drivers/net/virtio_net.c
> >>> +++ b/drivers/net/virtio_net.c
> >>> @@ -84,7 +84,9 @@ struct virtnet_stat_desc {
> >>>  
> >>>  struct virtnet_sq_free_stats {
> >>>  	u64 packets;
> >>> +	u64 xdp_packets;
> >>>  	u64 bytes;
> >>> +	u64 xdp_bytes;
> >>>  };
> >>>  
> >>>  struct virtnet_sq_stats {
> >>> @@ -512,19 +514,19 @@ static void __free_old_xmit(struct send_queue *sq, bool in_napi,
> >>>  	void *ptr;
> >>>  
> >>>  	while ((ptr = virtqueue_get_buf(sq->vq, &len)) != NULL) {
> >>> -		++stats->packets;
> >>> -
> >>>  		if (!is_xdp_frame(ptr)) {
> >>>  			struct sk_buff *skb = ptr;
> >>>  
> >>>  			pr_debug("Sent skb %p\n", skb);
> >>>  
> >>> +			stats->packets++;
> >>>  			stats->bytes += skb->len;
> >>>  			napi_consume_skb(skb, in_napi);
> >>>  		} else {
> >>>  			struct xdp_frame *frame = ptr_to_xdp(ptr);
> >>>  
> >>> -			stats->bytes += xdp_get_frame_len(frame);
> >>> +			stats->xdp_packets++;
> >>> +			stats->xdp_bytes += xdp_get_frame_len(frame);
> >>>  			xdp_return_frame(frame);
> >>>  		}
> >>>  	}
> >>> @@ -965,7 +967,8 @@ static void virtnet_rq_unmap_free_buf(struct virtqueue *vq, void *buf)
> >>>  	virtnet_rq_free_buf(vi, rq, buf);
> >>>  }
> >>>  
> >>> -static void free_old_xmit(struct send_queue *sq, bool in_napi)
> >>> +static void free_old_xmit(struct send_queue *sq, struct netdev_queue *txq,
> >>> +			  bool in_napi)
> >>>  {
> >>>  	struct virtnet_sq_free_stats stats = {0};
> >>>  
> >>> @@ -974,9 +977,11 @@ static void free_old_xmit(struct send_queue *sq, bool in_napi)
> >>>  	/* Avoid overhead when no packets have been processed
> >>>  	 * happens when called speculatively from start_xmit.
> >>>  	 */
> >>> -	if (!stats.packets)
> >>> +	if (!stats.packets && !stats.xdp_packets)
> >>>  		return;
> >>>  
> >>> +	netdev_tx_completed_queue(txq, stats.packets, stats.bytes);
> >>> +
> >>>  	u64_stats_update_begin(&sq->stats.syncp);
> >>>  	u64_stats_add(&sq->stats.bytes, stats.bytes);
> >>>  	u64_stats_add(&sq->stats.packets, stats.packets);
> >>> @@ -1013,13 +1018,15 @@ static void check_sq_full_and_disable(struct virtnet_info *vi,
> >>>  	 * early means 16 slots are typically wasted.
> >>>  	 */
> >>>  	if (sq->vq->num_free < 2+MAX_SKB_FRAGS) {
> >>> -		netif_stop_subqueue(dev, qnum);
> >>> +		struct netdev_queue *txq = netdev_get_tx_queue(dev, qnum);
> >>> +
> >>> +		netif_tx_stop_queue(txq);
> >>>  		if (use_napi) {
> >>>  			if (unlikely(!virtqueue_enable_cb_delayed(sq->vq)))
> >>>  				virtqueue_napi_schedule(&sq->napi, sq->vq);
> >>>  		} else if (unlikely(!virtqueue_enable_cb_delayed(sq->vq))) {
> >>>  			/* More just got used, free them then recheck. */
> >>> -			free_old_xmit(sq, false);
> >>> +			free_old_xmit(sq, txq, false);
> >>>  			if (sq->vq->num_free >= 2+MAX_SKB_FRAGS) {
> >>>  				netif_start_subqueue(dev, qnum);
> >>>  				virtqueue_disable_cb(sq->vq);
> >>> @@ -2319,7 +2326,7 @@ static void virtnet_poll_cleantx(struct receive_queue *rq)
> >>>  
> >>>  		do {
> >>>  			virtqueue_disable_cb(sq->vq);
> >>> -			free_old_xmit(sq, true);
> >>> +			free_old_xmit(sq, txq, true);
> >>>  		} while (unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
> >>>  
> >>>  		if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS)
> >>> @@ -2471,7 +2478,7 @@ static int virtnet_poll_tx(struct napi_struct *napi, int budget)
> >>>  	txq = netdev_get_tx_queue(vi->dev, index);
> >>>  	__netif_tx_lock(txq, raw_smp_processor_id());
> >>>  	virtqueue_disable_cb(sq->vq);
> >>> -	free_old_xmit(sq, true);
> >>> +	free_old_xmit(sq, txq, true);
> >>>  
> >>>  	if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS)
> >>>  		netif_tx_wake_queue(txq);
> >>> @@ -2553,7 +2560,7 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
> >>>  	struct send_queue *sq = &vi->sq[qnum];
> >>>  	int err;
> >>>  	struct netdev_queue *txq = netdev_get_tx_queue(dev, qnum);
> >>> -	bool kick = !netdev_xmit_more();
> >>> +	bool xmit_more = netdev_xmit_more();
> >>>  	bool use_napi = sq->napi.weight;
> >>>  
> >>>  	/* Free up any pending old buffers before queueing new ones. */
> >>> @@ -2561,9 +2568,9 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
> >>>  		if (use_napi)
> >>>  			virtqueue_disable_cb(sq->vq);
> >>>  
> >>> -		free_old_xmit(sq, false);
> >>> +		free_old_xmit(sq, txq, false);
> >>>  
> >>> -	} while (use_napi && kick &&
> >>> +	} while (use_napi && !xmit_more &&
> >>>  	       unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
> >>>  
> >>>  	/* timestamp packet in software */
> >>> @@ -2592,7 +2599,7 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
> >>>  
> >>>  	check_sq_full_and_disable(vi, dev, sq);
> >>>  
> >>> -	if (kick || netif_xmit_stopped(txq)) {
> >>> +	if (__netdev_tx_sent_queue(txq, skb->len, xmit_more)) {
> >>>  		if (virtqueue_kick_prepare(sq->vq) && virtqueue_notify(sq->vq)) {
> >>>  			u64_stats_update_begin(&sq->stats.syncp);
> >>>  			u64_stats_inc(&sq->stats.kicks);
> >>> -- 
> >>> 2.44.0
> >>> 
> >>> 

