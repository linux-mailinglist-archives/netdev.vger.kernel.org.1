Return-Path: <netdev+bounces-95389-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B2CE8C223A
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 12:35:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBCE61F2202B
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 10:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A359B85959;
	Fri, 10 May 2024 10:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="H4JDKQFk"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68578364
	for <netdev@vger.kernel.org>; Fri, 10 May 2024 10:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715337310; cv=none; b=hUqb2jcLOuzvxlgQuckB+EmNXztfaE9qaTuk/35xDCqKCX4SLo9CZH8C8NbfR6QrWxxI3BaAiA388XEAQ2a9eX6bsWIYcj9dsh9NmLxhfmcGiR7isX89cY6wsHRUEx0i/0AaE5IgmlOAAQEP2hUgzonbrDDRcTbtYNv8GfEIaIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715337310; c=relaxed/simple;
	bh=o6JFuHgOdAawciqY4EZmbjA2eVPuOWiIZa3N6EQKGwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W4FopBvJmecZZFCbOk2sSEcyqHMAvXn+Oqcnzcjd/X/UKJ6BXvo8MLgo+YV+nP7egFhLrCJ4GlnS+ynruVaKfZ+9apw1IuDjF6+MgmD1r7DmF1Cj8PFWopZwpaPET/C1YjrDeziRFUhqJB1z2KJFUdIu06rLd+zPp00OSo9yIs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=H4JDKQFk; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-51f60817e34so2248252e87.2
        for <netdev@vger.kernel.org>; Fri, 10 May 2024 03:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1715337306; x=1715942106; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7WF6NXAmShEkLi88sqZOX0cWWafeX5tooo7v0pkI1FQ=;
        b=H4JDKQFkV5R/iflwk21sABiFBEvO6Vwp6woIfQkHjMMWz9VUNfB4xZyGCEeYSSYIRH
         skyYW+sBnZnc7U1CgOMT3SFw12piTnFDTcPYDoPTZd1fA/dnj56BP/MRCR3Vzo6T5QDo
         6po9L7OjpYdK+dkPqaJxe5sFM8VivLTtg+NzLHb9Jwc9Hsx9Me2rL8cLfgBzj5nRiVhs
         UOIE5HuG0dvQ8ukrDBS/w74eGQIRR+x1SDkd27m8rLzrvXj4hsmCWK3yvfBxdDbJLUe5
         LniiPbYkKAADNzFtjAMMppDL+iRxfMcb8jySQifUgAuOV1em9VkjRXSvi5APf+R3GOM2
         wS+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715337306; x=1715942106;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7WF6NXAmShEkLi88sqZOX0cWWafeX5tooo7v0pkI1FQ=;
        b=vRMneDCMyufyHydDLNfYMkbUg8TWjEscaVZsSQ3ccYKTbrWYbU2aiPENLWr0mPrB7j
         EhQHecK5f/JXKRlVgOeBUr+ivROK27V4ySFkPvx3xo6v1EBUQxGXI+5nFymZBfwbIaRn
         CAS9HAWYT63Hq5krVz91S6uTkVzHbtgIYqoLoTrqiB/3QnT26s6OSjhpaOVvHhb8f8qO
         zQ3Fu6/KMHXLVy6+kXAdr0WhlhA3crz+CryEn+iwZL4cRiU9KZnQcm4iyYOOcMYmA5Yl
         eSF8pK3bd+ijaKJsOn3I2MscZm3CSCHdw+AdX5CopLrDzzpKCmk6CompdMOrEGWvJYQf
         6Z3A==
X-Forwarded-Encrypted: i=1; AJvYcCXU6wyyuKhqy0o4GNIhGvEf94D2I3FqO9lCM2Pe7FaBC1ZYDP2GS3q+2qXNJs4lfkoJIlGzr0m8a35NPCFAqCm4qlDtZPrc
X-Gm-Message-State: AOJu0YyNsxvBHfqJ85po9rB6GuT6rqM/+52ywi3G9Lv6FuK5/PRR+2wm
	aGK4Anftp4pzTI6yfSYaRJUfHjn9nZc+ZewBCS6vZHjwctdqcBEKJDIlBFcpsG0=
X-Google-Smtp-Source: AGHT+IEZdzOLT/qB1CrK1qM4rWDfvvPv8AKWCB3xY0cjp0hEZAQTWGTr+MhRIYstBgqcwctvkewJFw==
X-Received: by 2002:a05:6512:33ce:b0:513:edf4:6f20 with SMTP id 2adb3069b0e04-5220fe79457mr1602566e87.54.1715337306127;
        Fri, 10 May 2024 03:35:06 -0700 (PDT)
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b79bc99sm4190142f8f.11.2024.05.10.03.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 03:35:05 -0700 (PDT)
Date: Fri, 10 May 2024 12:35:02 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, mst@redhat.com, jasowang@redhat.com,
	xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev,
	ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
	john.fastabend@gmail.com, netdev@vger.kernel.org
Subject: Re: [patch net-next] virtio_net: add support for Byte Queue Limits
Message-ID: <Zj34VgY5yT7259iT@nanopsycho.orion>
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

Thanks for the pointers, will check that out.


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

