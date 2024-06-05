Return-Path: <netdev+bounces-100959-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1085E8FCA7C
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 13:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 854232822A1
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 11:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D119314BF99;
	Wed,  5 Jun 2024 11:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="ZAgYwCue"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C90C49622
	for <netdev@vger.kernel.org>; Wed,  5 Jun 2024 11:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717587059; cv=none; b=Vid+G0UPCOPzD67lOgd/rZshR1lP9vLU4/2BklKNilDgn4sshxJP7QIsRt1A4ilunjFwRc677KDNSvRhaQumgsP9ULoPli312drPuef8kInq6yR/AMVQQvrBbl+LFkRRYfXIo9uNNAMLM1e4RQiD7jhPwY/tYXKDTvz49jC8XWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717587059; c=relaxed/simple;
	bh=We5opLWy7VSuhbIfPgcRvEpu2bynphyAOWJP0WxhwnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q0js6YsAWzCFTOaqAcvjZDOp72hHCsMYOlZz9t10KhsZuRRYYn4jbz1AknXtn6KMIUUjiWqc9w67ERpVm0FJ/ZE7MRlA7+cREKwiAkxqXELRWxvLLIJvdY4LjBRNuJ4WyC2iSkqfhJGl38pxay0LN/mUSUhdkJm7pdKKG7j8xvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=ZAgYwCue; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-35dce610207so4979257f8f.2
        for <netdev@vger.kernel.org>; Wed, 05 Jun 2024 04:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1717587056; x=1718191856; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dI5cNg2pQS1K+SK1Dh8USe6ne1W8c1tbvQXgIdRfh6c=;
        b=ZAgYwCueiuJkMv0D82ObpboiB0jOYsocy4v3hImbWSLXj6X3dtfVscEVygSK3ZK9+K
         eJjcO7sSeXwacqE/oADRu0PTck7lRkEaAkU9KsAbk4p07d/5PEwVqUG67Ot6PzuENQPv
         lPJh1gx2nWJOM+Sb0qs/iWwEnRpxcKOBP5ZP7P4lqgGKOQuGpPbPxi7K5sItEz0vGuwQ
         0zIwBcxF/VoJRGMbz/kgbTYlfOK4LZRUvmdUuJipI0afCQ9rof31CyCaWcglygR3liXf
         0MVUJ/n+Y+J09tfHMYAsU+GDcRj6rIehbTTwzsG9q2SkWGTVwWwCS8/H7miga4CYQ0Px
         qkLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717587056; x=1718191856;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dI5cNg2pQS1K+SK1Dh8USe6ne1W8c1tbvQXgIdRfh6c=;
        b=T2aA+m/tfGE6uzZViYx3+jtMorDpArdk6OSQN5mlL3amUvNIKUGibe/Y05kDtjol9g
         OHwHwfVExGrZCWkyRKDg/ej3YLo6qg67yNRcHnlMlDHEXCY2fpnhAK61wCMx4FOMQpLL
         jh1dMx3a0YKr2wTQ5f6gYx/RZRlsS0cst1iFEcmQVgyZFEXVvRxkGkx+lbVllJ9J0VXs
         d78Qz8RFdqnDyYYHlkL35vVs9bq+7Tz9RbIgbZRQa2X6kZi530Oic+FvOfeCjzAmeviV
         XbrxVLyVoj5zdHjl0z9GvsKRggWSSQFRR2qE8aZOKNauug9vImjVTIzo4X5jPuaOWK0C
         yk7A==
X-Forwarded-Encrypted: i=1; AJvYcCWpgqoqamDjeXqB9Qcv75ct9kA/I4XwMEtvLswwV8hz8Dnv8F1ii9LfwSDAU874rlk9kAWkiiORdA4sqJFaG3rdTYVfAeit
X-Gm-Message-State: AOJu0YxqDA0GUvkwxfgmxHy/v3lCoGklrNIV9pLVMIas3AnFm5uorhWF
	LlAjCZoLb/794sHj0WlH9js1wj6McH+eiytz3b2zJAxcPoQ+oaSgIZXc5/CR6GE=
X-Google-Smtp-Source: AGHT+IHnLX9QfM04CGs0aTWeZ6fYFqn170weZqx+exS7IbQLTKyYFBDBcHm0DfVPHq7ray8i0QJPLA==
X-Received: by 2002:a05:6000:2a2:b0:35e:ebe7:de43 with SMTP id ffacd0b85a97d-35eebe7e01fmr1338482f8f.21.1717587055500;
        Wed, 05 Jun 2024 04:30:55 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35dd04c0d3csm14338107f8f.19.2024.06.05.04.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 04:30:54 -0700 (PDT)
Date: Wed, 5 Jun 2024 13:30:51 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, mst@redhat.com, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev,
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
	john.fastabend@gmail.com, netdev@vger.kernel.org
Subject: Re: [patch net-next] virtio_net: add support for Byte Queue Limits
Message-ID: <ZmBMa7Am3LIYQw1x@nanopsycho.orion>
References: <20240509114615.317450-1-jiri@resnulli.us>
 <1715325076.4219763-2-hengqi@linux.alibaba.com>
 <ZktGj4nDU4X0Lxtx@nanopsycho.orion>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZktGj4nDU4X0Lxtx@nanopsycho.orion>

Mon, May 20, 2024 at 02:48:15PM CEST, jiri@resnulli.us wrote:
>Fri, May 10, 2024 at 09:11:16AM CEST, hengqi@linux.alibaba.com wrote:
>>On Thu,  9 May 2024 13:46:15 +0200, Jiri Pirko <jiri@resnulli.us> wrote:
>>> From: Jiri Pirko <jiri@nvidia.com>
>>> 
>>> Add support for Byte Queue Limits (BQL).
>>
>>Historically both Jason and Michael have attempted to support BQL
>>for virtio-net, for example:
>>
>>https://lore.kernel.org/netdev/21384cb5-99a6-7431-1039-b356521e1bc3@redhat.com/
>>
>>These discussions focus primarily on:
>>
>>1. BQL is based on napi tx. Therefore, the transfer of statistical information
>>needs to rely on the judgment of use_napi. When the napi mode is switched to
>>orphan, some statistical information will be lost, resulting in temporary
>>inaccuracy in BQL.
>>
>>2. If tx dim is supported, orphan mode may be removed and tx irq will be more
>>reasonable. This provides good support for BQL.
>
>But when the device does not support dim, the orphan mode is still
>needed, isn't it?

Heng, is my assuption correct here? Thanks!

>
>>
>>Thanks.
>>
>>> 
>>> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>>> ---
>>>  drivers/net/virtio_net.c | 33 ++++++++++++++++++++-------------
>>>  1 file changed, 20 insertions(+), 13 deletions(-)
>>> 
>>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>>> index 218a446c4c27..c53d6dc6d332 100644
>>> --- a/drivers/net/virtio_net.c
>>> +++ b/drivers/net/virtio_net.c
>>> @@ -84,7 +84,9 @@ struct virtnet_stat_desc {
>>>  
>>>  struct virtnet_sq_free_stats {
>>>  	u64 packets;
>>> +	u64 xdp_packets;
>>>  	u64 bytes;
>>> +	u64 xdp_bytes;
>>>  };
>>>  
>>>  struct virtnet_sq_stats {
>>> @@ -512,19 +514,19 @@ static void __free_old_xmit(struct send_queue *sq, bool in_napi,
>>>  	void *ptr;
>>>  
>>>  	while ((ptr = virtqueue_get_buf(sq->vq, &len)) != NULL) {
>>> -		++stats->packets;
>>> -
>>>  		if (!is_xdp_frame(ptr)) {
>>>  			struct sk_buff *skb = ptr;
>>>  
>>>  			pr_debug("Sent skb %p\n", skb);
>>>  
>>> +			stats->packets++;
>>>  			stats->bytes += skb->len;
>>>  			napi_consume_skb(skb, in_napi);
>>>  		} else {
>>>  			struct xdp_frame *frame = ptr_to_xdp(ptr);
>>>  
>>> -			stats->bytes += xdp_get_frame_len(frame);
>>> +			stats->xdp_packets++;
>>> +			stats->xdp_bytes += xdp_get_frame_len(frame);
>>>  			xdp_return_frame(frame);
>>>  		}
>>>  	}
>>> @@ -965,7 +967,8 @@ static void virtnet_rq_unmap_free_buf(struct virtqueue *vq, void *buf)
>>>  	virtnet_rq_free_buf(vi, rq, buf);
>>>  }
>>>  
>>> -static void free_old_xmit(struct send_queue *sq, bool in_napi)
>>> +static void free_old_xmit(struct send_queue *sq, struct netdev_queue *txq,
>>> +			  bool in_napi)
>>>  {
>>>  	struct virtnet_sq_free_stats stats = {0};
>>>  
>>> @@ -974,9 +977,11 @@ static void free_old_xmit(struct send_queue *sq, bool in_napi)
>>>  	/* Avoid overhead when no packets have been processed
>>>  	 * happens when called speculatively from start_xmit.
>>>  	 */
>>> -	if (!stats.packets)
>>> +	if (!stats.packets && !stats.xdp_packets)
>>>  		return;
>>>  
>>> +	netdev_tx_completed_queue(txq, stats.packets, stats.bytes);
>>> +
>>>  	u64_stats_update_begin(&sq->stats.syncp);
>>>  	u64_stats_add(&sq->stats.bytes, stats.bytes);
>>>  	u64_stats_add(&sq->stats.packets, stats.packets);
>>> @@ -1013,13 +1018,15 @@ static void check_sq_full_and_disable(struct virtnet_info *vi,
>>>  	 * early means 16 slots are typically wasted.
>>>  	 */
>>>  	if (sq->vq->num_free < 2+MAX_SKB_FRAGS) {
>>> -		netif_stop_subqueue(dev, qnum);
>>> +		struct netdev_queue *txq = netdev_get_tx_queue(dev, qnum);
>>> +
>>> +		netif_tx_stop_queue(txq);
>>>  		if (use_napi) {
>>>  			if (unlikely(!virtqueue_enable_cb_delayed(sq->vq)))
>>>  				virtqueue_napi_schedule(&sq->napi, sq->vq);
>>>  		} else if (unlikely(!virtqueue_enable_cb_delayed(sq->vq))) {
>>>  			/* More just got used, free them then recheck. */
>>> -			free_old_xmit(sq, false);
>>> +			free_old_xmit(sq, txq, false);
>>>  			if (sq->vq->num_free >= 2+MAX_SKB_FRAGS) {
>>>  				netif_start_subqueue(dev, qnum);
>>>  				virtqueue_disable_cb(sq->vq);
>>> @@ -2319,7 +2326,7 @@ static void virtnet_poll_cleantx(struct receive_queue *rq)
>>>  
>>>  		do {
>>>  			virtqueue_disable_cb(sq->vq);
>>> -			free_old_xmit(sq, true);
>>> +			free_old_xmit(sq, txq, true);
>>>  		} while (unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
>>>  
>>>  		if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS)
>>> @@ -2471,7 +2478,7 @@ static int virtnet_poll_tx(struct napi_struct *napi, int budget)
>>>  	txq = netdev_get_tx_queue(vi->dev, index);
>>>  	__netif_tx_lock(txq, raw_smp_processor_id());
>>>  	virtqueue_disable_cb(sq->vq);
>>> -	free_old_xmit(sq, true);
>>> +	free_old_xmit(sq, txq, true);
>>>  
>>>  	if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS)
>>>  		netif_tx_wake_queue(txq);
>>> @@ -2553,7 +2560,7 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
>>>  	struct send_queue *sq = &vi->sq[qnum];
>>>  	int err;
>>>  	struct netdev_queue *txq = netdev_get_tx_queue(dev, qnum);
>>> -	bool kick = !netdev_xmit_more();
>>> +	bool xmit_more = netdev_xmit_more();
>>>  	bool use_napi = sq->napi.weight;
>>>  
>>>  	/* Free up any pending old buffers before queueing new ones. */
>>> @@ -2561,9 +2568,9 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
>>>  		if (use_napi)
>>>  			virtqueue_disable_cb(sq->vq);
>>>  
>>> -		free_old_xmit(sq, false);
>>> +		free_old_xmit(sq, txq, false);
>>>  
>>> -	} while (use_napi && kick &&
>>> +	} while (use_napi && !xmit_more &&
>>>  	       unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
>>>  
>>>  	/* timestamp packet in software */
>>> @@ -2592,7 +2599,7 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
>>>  
>>>  	check_sq_full_and_disable(vi, dev, sq);
>>>  
>>> -	if (kick || netif_xmit_stopped(txq)) {
>>> +	if (__netdev_tx_sent_queue(txq, skb->len, xmit_more)) {
>>>  		if (virtqueue_kick_prepare(sq->vq) && virtqueue_notify(sq->vq)) {
>>>  			u64_stats_update_begin(&sq->stats.syncp);
>>>  			u64_stats_inc(&sq->stats.kicks);
>>> -- 
>>> 2.44.0
>>> 
>>> 

