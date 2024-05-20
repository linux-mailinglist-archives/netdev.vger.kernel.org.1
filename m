Return-Path: <netdev+bounces-97192-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 421B18C9DAA
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 14:48:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E874C285B1D
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 12:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96AB3133993;
	Mon, 20 May 2024 12:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="yA27LAgU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4B5133425
	for <netdev@vger.kernel.org>; Mon, 20 May 2024 12:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716209304; cv=none; b=cvbNg/t49a3bGukfpN/ZZodaSd8SGajmqEy80nVi3+XGRlVDzgVNKpbAZws6QFMq0pkbotgldKT9vhUUuSGEOvendobAc0hsYJ1sZdiPKNsDoq9IeCSQqQr0FFjz5H/f2vTSIteSNtj7cPub33os4otmu1XNlmCeVXHl/Ppnkjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716209304; c=relaxed/simple;
	bh=n2RFJvwuPIY0pWAVGkNT51g+Wyg/oDiKLxR0DAzZ5LY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MWNgJa4uMqem+4F/iTMVSc7rVmZzK1cArPlRp2t0pbObj1xvNMcst9Mz3cCWflVn7eCQRqdzN4u0q74HvbuWzaPocyu7BRw/9+aIOUEuxq93TghHI6+gk0DUnk6mK53EWAi0AlohUXFysEtugu146789m4SDcDjplDNa7JVMhYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=yA27LAgU; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2e724bc466fso13049331fa.3
        for <netdev@vger.kernel.org>; Mon, 20 May 2024 05:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1716209300; x=1716814100; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=edD/qHXmTSqUAHK1Fn+uFuuPgu4ZiccB5v7Y6S0pADc=;
        b=yA27LAgUYzXxaBYp5Df6Nd0Prm45Dk67S5QSn/AkvuCebd7u58uLZL88h4SZhBWneG
         UOCDpRBOcIQnwXZF8peG92LorghnND4f9uFmEfo5rmn3WNzdfnp6nzapO/umitQ1fc86
         YSxa+H1xvCBxRQcbEzioNumEvSf4h5Hs5Co5ugUVUSXyhTnr+tDKATfFCgWl/U6I6d3b
         1EIf8MyWfLRHMFC9n5tg36r0BA1R2UOguiePlAEtQeI6BcYUR2vePp6Ln6WOsNXIFOBQ
         p+NoqkE4y1oBG59bsKK7PCoMoPcHW6pYHRyyu7wexq5JxtmX42JC7yR4n7zN+h0kXRyE
         dp1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716209300; x=1716814100;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=edD/qHXmTSqUAHK1Fn+uFuuPgu4ZiccB5v7Y6S0pADc=;
        b=MGr6c3ph6VpUdoiEacYN/lxqv5uVQDuNpv564Kt7xg11NGs5ggYgypCMuD0Kf9ETkT
         op36dbhjBfikxn3KwtKWt5mxLs/QKFT8biCCGwOxJwPdGGmk1XQnGB6Yy+HeX9CaDTag
         L7amXXnrHTSI3aZc4fmAT/txNkJBW5cWVfzttVUCV39sOFoqURKd8K1kCRKKzn219WrO
         n8AQgzxBSIP6wFgLXbKT2XEBLCU/wZQndQsJ7OTFWCfPErfiUOy2k6s7INP3n9Nr4cii
         XgqC35/ZCAeYvOAgOzgSukC2D3TT2r3u/utwE3AGbMXTbEhoidlDJ+92MLudYQX8e5Ty
         UMFg==
X-Forwarded-Encrypted: i=1; AJvYcCXdlexta3LVx/LABDPAZ+ZeZTgEOOiHQgsqz9Oi6HdN7kSzE7SkgaDtkzbmZntHzSzMUhJ9Gic2HP9kFXRPFBljB41lsGZ6
X-Gm-Message-State: AOJu0YwYn7Nc0KmOYPaYnXXjrQJ/v6CbfLDXloTOt2sfWlU6BZiXtlsw
	5NsS22SQR82XDEgscJ+kvsHyZnYxhk7Owpsa1RdkJFGMjEUJOGFrwI9mp85iYjY=
X-Google-Smtp-Source: AGHT+IGdYPl8eqYkpqi+OilcX/LBUQkNnoyVFYuvU6/03Tx9tXlTUEOLOipwDnf8cYej2iCSODVrvw==
X-Received: by 2002:a2e:859:0:b0:2e5:4171:1808 with SMTP id 38308e7fff4ca-2e541711898mr232419261fa.51.1716209300047;
        Mon, 20 May 2024 05:48:20 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41f87c235b4sm453601015e9.11.2024.05.20.05.48.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 05:48:19 -0700 (PDT)
Date: Mon, 20 May 2024 14:48:15 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, mst@redhat.com, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev,
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
	john.fastabend@gmail.com, netdev@vger.kernel.org
Subject: Re: [patch net-next] virtio_net: add support for Byte Queue Limits
Message-ID: <ZktGj4nDU4X0Lxtx@nanopsycho.orion>
References: <20240509114615.317450-1-jiri@resnulli.us>
 <1715325076.4219763-2-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1715325076.4219763-2-hengqi@linux.alibaba.com>

Fri, May 10, 2024 at 09:11:16AM CEST, hengqi@linux.alibaba.com wrote:
>On Thu,  9 May 2024 13:46:15 +0200, Jiri Pirko <jiri@resnulli.us> wrote:
>> From: Jiri Pirko <jiri@nvidia.com>
>> 
>> Add support for Byte Queue Limits (BQL).
>
>Historically both Jason and Michael have attempted to support BQL
>for virtio-net, for example:
>
>https://lore.kernel.org/netdev/21384cb5-99a6-7431-1039-b356521e1bc3@redhat.com/
>
>These discussions focus primarily on:
>
>1. BQL is based on napi tx. Therefore, the transfer of statistical information
>needs to rely on the judgment of use_napi. When the napi mode is switched to
>orphan, some statistical information will be lost, resulting in temporary
>inaccuracy in BQL.
>
>2. If tx dim is supported, orphan mode may be removed and tx irq will be more
>reasonable. This provides good support for BQL.

But when the device does not support dim, the orphan mode is still
needed, isn't it?

>
>Thanks.
>
>> 
>> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
>> ---
>>  drivers/net/virtio_net.c | 33 ++++++++++++++++++++-------------
>>  1 file changed, 20 insertions(+), 13 deletions(-)
>> 
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> index 218a446c4c27..c53d6dc6d332 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -84,7 +84,9 @@ struct virtnet_stat_desc {
>>  
>>  struct virtnet_sq_free_stats {
>>  	u64 packets;
>> +	u64 xdp_packets;
>>  	u64 bytes;
>> +	u64 xdp_bytes;
>>  };
>>  
>>  struct virtnet_sq_stats {
>> @@ -512,19 +514,19 @@ static void __free_old_xmit(struct send_queue *sq, bool in_napi,
>>  	void *ptr;
>>  
>>  	while ((ptr = virtqueue_get_buf(sq->vq, &len)) != NULL) {
>> -		++stats->packets;
>> -
>>  		if (!is_xdp_frame(ptr)) {
>>  			struct sk_buff *skb = ptr;
>>  
>>  			pr_debug("Sent skb %p\n", skb);
>>  
>> +			stats->packets++;
>>  			stats->bytes += skb->len;
>>  			napi_consume_skb(skb, in_napi);
>>  		} else {
>>  			struct xdp_frame *frame = ptr_to_xdp(ptr);
>>  
>> -			stats->bytes += xdp_get_frame_len(frame);
>> +			stats->xdp_packets++;
>> +			stats->xdp_bytes += xdp_get_frame_len(frame);
>>  			xdp_return_frame(frame);
>>  		}
>>  	}
>> @@ -965,7 +967,8 @@ static void virtnet_rq_unmap_free_buf(struct virtqueue *vq, void *buf)
>>  	virtnet_rq_free_buf(vi, rq, buf);
>>  }
>>  
>> -static void free_old_xmit(struct send_queue *sq, bool in_napi)
>> +static void free_old_xmit(struct send_queue *sq, struct netdev_queue *txq,
>> +			  bool in_napi)
>>  {
>>  	struct virtnet_sq_free_stats stats = {0};
>>  
>> @@ -974,9 +977,11 @@ static void free_old_xmit(struct send_queue *sq, bool in_napi)
>>  	/* Avoid overhead when no packets have been processed
>>  	 * happens when called speculatively from start_xmit.
>>  	 */
>> -	if (!stats.packets)
>> +	if (!stats.packets && !stats.xdp_packets)
>>  		return;
>>  
>> +	netdev_tx_completed_queue(txq, stats.packets, stats.bytes);
>> +
>>  	u64_stats_update_begin(&sq->stats.syncp);
>>  	u64_stats_add(&sq->stats.bytes, stats.bytes);
>>  	u64_stats_add(&sq->stats.packets, stats.packets);
>> @@ -1013,13 +1018,15 @@ static void check_sq_full_and_disable(struct virtnet_info *vi,
>>  	 * early means 16 slots are typically wasted.
>>  	 */
>>  	if (sq->vq->num_free < 2+MAX_SKB_FRAGS) {
>> -		netif_stop_subqueue(dev, qnum);
>> +		struct netdev_queue *txq = netdev_get_tx_queue(dev, qnum);
>> +
>> +		netif_tx_stop_queue(txq);
>>  		if (use_napi) {
>>  			if (unlikely(!virtqueue_enable_cb_delayed(sq->vq)))
>>  				virtqueue_napi_schedule(&sq->napi, sq->vq);
>>  		} else if (unlikely(!virtqueue_enable_cb_delayed(sq->vq))) {
>>  			/* More just got used, free them then recheck. */
>> -			free_old_xmit(sq, false);
>> +			free_old_xmit(sq, txq, false);
>>  			if (sq->vq->num_free >= 2+MAX_SKB_FRAGS) {
>>  				netif_start_subqueue(dev, qnum);
>>  				virtqueue_disable_cb(sq->vq);
>> @@ -2319,7 +2326,7 @@ static void virtnet_poll_cleantx(struct receive_queue *rq)
>>  
>>  		do {
>>  			virtqueue_disable_cb(sq->vq);
>> -			free_old_xmit(sq, true);
>> +			free_old_xmit(sq, txq, true);
>>  		} while (unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
>>  
>>  		if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS)
>> @@ -2471,7 +2478,7 @@ static int virtnet_poll_tx(struct napi_struct *napi, int budget)
>>  	txq = netdev_get_tx_queue(vi->dev, index);
>>  	__netif_tx_lock(txq, raw_smp_processor_id());
>>  	virtqueue_disable_cb(sq->vq);
>> -	free_old_xmit(sq, true);
>> +	free_old_xmit(sq, txq, true);
>>  
>>  	if (sq->vq->num_free >= 2 + MAX_SKB_FRAGS)
>>  		netif_tx_wake_queue(txq);
>> @@ -2553,7 +2560,7 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
>>  	struct send_queue *sq = &vi->sq[qnum];
>>  	int err;
>>  	struct netdev_queue *txq = netdev_get_tx_queue(dev, qnum);
>> -	bool kick = !netdev_xmit_more();
>> +	bool xmit_more = netdev_xmit_more();
>>  	bool use_napi = sq->napi.weight;
>>  
>>  	/* Free up any pending old buffers before queueing new ones. */
>> @@ -2561,9 +2568,9 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
>>  		if (use_napi)
>>  			virtqueue_disable_cb(sq->vq);
>>  
>> -		free_old_xmit(sq, false);
>> +		free_old_xmit(sq, txq, false);
>>  
>> -	} while (use_napi && kick &&
>> +	} while (use_napi && !xmit_more &&
>>  	       unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
>>  
>>  	/* timestamp packet in software */
>> @@ -2592,7 +2599,7 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
>>  
>>  	check_sq_full_and_disable(vi, dev, sq);
>>  
>> -	if (kick || netif_xmit_stopped(txq)) {
>> +	if (__netdev_tx_sent_queue(txq, skb->len, xmit_more)) {
>>  		if (virtqueue_kick_prepare(sq->vq) && virtqueue_notify(sq->vq)) {
>>  			u64_stats_update_begin(&sq->stats.syncp);
>>  			u64_stats_inc(&sq->stats.kicks);
>> -- 
>> 2.44.0
>> 
>> 

