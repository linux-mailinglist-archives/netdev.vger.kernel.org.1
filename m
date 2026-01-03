Return-Path: <netdev+bounces-246675-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B36A2CF0379
	for <lists+netdev@lfdr.de>; Sat, 03 Jan 2026 18:35:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0AEB7301692C
	for <lists+netdev@lfdr.de>; Sat,  3 Jan 2026 17:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98EDC2C2AA2;
	Sat,  3 Jan 2026 17:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZPGs9L6G";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="H+MwUs7C"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5238421B9F6
	for <netdev@vger.kernel.org>; Sat,  3 Jan 2026 17:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767461706; cv=none; b=Ob5rTj37RbS7cSlfU+k/pNe1pSnS+XZu0EIh3na/EK/iqnKw0E5uSD93ykCh8C72OGA9vdNNlwS3Rpghi51RVxQ+BAbZSfL9RO18H4o8wbqXGu8qIFy09AumCA0HyLPnxCM5/BQFfKEatJjbHodRuIIZgMX2X/uB6cD45LxWkNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767461706; c=relaxed/simple;
	bh=Y13wLH4ceaDvl1ihvg/aw+w3hrnNabyh10rQhk12QDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cCFGRZxSjYtq3R5BGvDiAjRRoX/weBVy77d3ZrsWDk+uThimcWrGt3/U+YyYgruSe762/zmuuYINfAVFa8NSpNE+mo+gDgzSkb6SmwfPruUrGEGYdFKBfGbaSnbgEMot+3vUk0GEc8UNtQu/miXdjlZMxokYVv1OEaBtxJPAgQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZPGs9L6G; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=H+MwUs7C; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767461702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EEdIP9jALOvvc8ZF0tY5F3t+W442S2Znt+VKHwRg1LI=;
	b=ZPGs9L6GLa9jJ1MMUti3AoBPzEoM94zVCqvuZkAO9FyPUYV3/Fdfg/0B82sxkSYMhNib5t
	63Ux49vfm0tmfZAFPXvzt/O8g3ovP2W6aBuOOqXSUeNlotvPfVXQVcpnaBaZUCQs24ylz+
	5ulTTrA1Sm8WNH8AoSKhblF6n2f2Wbo=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-OcrpbcsrMBKDscbtPuAK-A-1; Sat, 03 Jan 2026 12:35:01 -0500
X-MC-Unique: OcrpbcsrMBKDscbtPuAK-A-1
X-Mimecast-MFC-AGG-ID: OcrpbcsrMBKDscbtPuAK-A_1767461700
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-47d5bd981c8so29249815e9.0
        for <netdev@vger.kernel.org>; Sat, 03 Jan 2026 09:35:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767461700; x=1768066500; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EEdIP9jALOvvc8ZF0tY5F3t+W442S2Znt+VKHwRg1LI=;
        b=H+MwUs7C/KZVQL/QwHAOOXdE/JbjGUeXL2s47lESWGBrX9/g6/3nqejdF+q2gTQLZB
         ooD+YdYH2Pd/3k45rsJpwk715B2n2fli1W7BQXvS6gJLvIsNyFK1VpMWpgbKKM54Q1L5
         xEiB1Jzb07bRJFHZwh4Ka4jG6BhXFTeDvTWdytt71gmr1UEZohqyoOg4wgn9A1DC9r3K
         K+BBYpsdi6V8ChrcuacLKJTnrSDzx/oItNbWDlvAgYELugIhCLBPVMV5iNnCsBpihyHT
         LfTJBqDbaIW3PwynD6uQZZ7moN89MYeIi4ZIBFd2WWWOTLl2c8U+WYjETm/wTP4hK98z
         WGFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767461700; x=1768066500;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EEdIP9jALOvvc8ZF0tY5F3t+W442S2Znt+VKHwRg1LI=;
        b=XHADlCKHFGKeHDKyLA9S7z/X2YR9JWCemMZK2CRCtBuvhEWPb0KoLt/fbST4v6/Whk
         Y0vYT5XvW/tg59thnMDGrtiYdSIerXXeREFlQ976TDs5gsWHb9pNapWKgWAfZLvAnj9U
         nrHyIM01PzoH4vkj00xmGiHRxkW/VjPEefAKG3lBecwlTMNR6EsptEKMyxdIfU0g/Zr5
         vhMEQD79nV+7MzHG+do/Fu6dwHdQNchSnbI/RHp0cNrOxHDpY0JkydF8FtANdr8BlgIZ
         EjMbkrjIzFUjvbrQNkIMax7a5GeE2A6Cvm5gOdPJcbcuNKRTV0huw3N2qPFu9ePaVq4m
         mKKA==
X-Gm-Message-State: AOJu0YzNydYu7cZv8kCOU3sW9Cni/fe3+pLB4pE3loYWN7pSepX5fPJa
	Lc5GjY5cKzbgaRtltYkP6NbuD6CkLBIhMNgB0H/vymPZzKcoGpsvI9zOF0Tz5aclO9sDtzIQFdY
	tw+o8QHIxBQ5Eo/Hob9/GeZZoiBqo2oay8//88G68iSALtc8kYDpAkCNcnw==
X-Gm-Gg: AY/fxX5HPjs9T6S7zLsejVk8OgWid8yB92TEQsF0EAEJe8dhOCAlGBQwi8hA1uslJSk
	yhLkRXj0OTeAL0W2QIGiozf4hdl1/yFMu0AykR1fn4RTZJk2ylgB2nDiLYFHG2eeJG1OkES3WaV
	g9kLqEfP6xGxX6/QuWiadj1OZvv/4PHhnf8ABQlPmvoF78/kAr/q5/ITLLBUz6/heOMzCPlbmJV
	EDRK8aO7eOuzVQcPjFyEFdezmXHkUG6HHRm1oYoK4ESQy2vk9FFaQvUokyqqOoydmeZofWyUikB
	GMutDrGrfWtHJOfaqmTYcdLaLWKuLuOb9+72FwvSMltwrUAwMC5/H8nBv7Rp1aPtQWOGABCWVHB
	YWbE=
X-Received: by 2002:a05:600c:1d1d:b0:47a:94fc:d057 with SMTP id 5b1f17b1804b1-47d19538d98mr456348965e9.2.1767461699739;
        Sat, 03 Jan 2026 09:34:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGsvgbzF9KuB+7M5SVS6+TnF2qNTINOjinMqCh3ayX5afcmIoMa8eQxNaipc5DNoNmcMJrY9A==
X-Received: by 2002:a05:600c:1d1d:b0:47a:94fc:d057 with SMTP id 5b1f17b1804b1-47d19538d98mr456348655e9.2.1767461699245;
        Sat, 03 Jan 2026 09:34:59 -0800 (PST)
Received: from redhat.com ([147.235.217.121])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d6d33eefesm46522085e9.12.2026.01.03.09.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jan 2026 09:34:58 -0800 (PST)
Date: Sat, 3 Jan 2026 12:34:54 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v2 1/3] virtio-net: don't schedule delayed refill
 worker
Message-ID: <20260103123411-mutt-send-email-mst@kernel.org>
References: <20260102152023.10773-1-minhquangbui99@gmail.com>
 <20260102152023.10773-2-minhquangbui99@gmail.com>
 <20260103115424-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260103115424-mutt-send-email-mst@kernel.org>

On Sat, Jan 03, 2026 at 11:57:43AM -0500, Michael S. Tsirkin wrote:
> On Fri, Jan 02, 2026 at 10:20:21PM +0700, Bui Quang Minh wrote:
> > When we fail to refill the receive buffers, we schedule a delayed worker
> > to retry later. However, this worker creates some concurrency issues
> > such as races and deadlocks. To simplify the logic and avoid further
> > problems, we will instead retry refilling in the next NAPI poll.
> > 
> > Fixes: 4bc12818b363 ("virtio-net: disable delayed refill when pausing rx")
> > Reported-by: Paolo Abeni <pabeni@redhat.com>
> > Closes: https://netdev-ctrl.bots.linux.dev/logs/vmksft/drv-hw-dbg/results/400961/3-xdp-py/stderr
> > Cc: stable@vger.kernel.org
> > Suggested-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
> > ---
> >  drivers/net/virtio_net.c | 55 ++++++++++++++++++++++------------------
> >  1 file changed, 30 insertions(+), 25 deletions(-)
> > 
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 1bb3aeca66c6..ac514c9383ae 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -3035,7 +3035,7 @@ static int virtnet_receive_packets(struct virtnet_info *vi,
> >  }
> >  
> >  static int virtnet_receive(struct receive_queue *rq, int budget,
> > -			   unsigned int *xdp_xmit)
> > +			   unsigned int *xdp_xmit, bool *retry_refill)
> >  {
> >  	struct virtnet_info *vi = rq->vq->vdev->priv;
> >  	struct virtnet_rq_stats stats = {};
> > @@ -3047,12 +3047,8 @@ static int virtnet_receive(struct receive_queue *rq, int budget,
> >  		packets = virtnet_receive_packets(vi, rq, budget, xdp_xmit, &stats);
> >  
> >  	if (rq->vq->num_free > min((unsigned int)budget, virtqueue_get_vring_size(rq->vq)) / 2) {
> > -		if (!try_fill_recv(vi, rq, GFP_ATOMIC)) {
> > -			spin_lock(&vi->refill_lock);
> > -			if (vi->refill_enabled)
> > -				schedule_delayed_work(&vi->refill, 0);
> > -			spin_unlock(&vi->refill_lock);
> > -		}
> > +		if (!try_fill_recv(vi, rq, GFP_ATOMIC))
> > +			*retry_refill = true;
> >  	}
> >  
> >  	u64_stats_set(&stats.packets, packets);
> > @@ -3129,18 +3125,18 @@ static int virtnet_poll(struct napi_struct *napi, int budget)
> >  	struct send_queue *sq;
> >  	unsigned int received;
> >  	unsigned int xdp_xmit = 0;
> > -	bool napi_complete;
> > +	bool napi_complete, retry_refill = false;
> >  
> >  	virtnet_poll_cleantx(rq, budget);
> >  
> > -	received = virtnet_receive(rq, budget, &xdp_xmit);
> > +	received = virtnet_receive(rq, budget, &xdp_xmit, &retry_refill);
> >  	rq->packets_in_napi += received;
> >  
> >  	if (xdp_xmit & VIRTIO_XDP_REDIR)
> >  		xdp_do_flush();
> >  
> >  	/* Out of packets? */
> > -	if (received < budget) {
> > +	if (received < budget && !retry_refill) {
> >  		napi_complete = virtqueue_napi_complete(napi, rq->vq, received);
> >  		/* Intentionally not taking dim_lock here. This may result in a
> >  		 * spurious net_dim call. But if that happens virtnet_rx_dim_work
> > @@ -3160,7 +3156,7 @@ static int virtnet_poll(struct napi_struct *napi, int budget)
> >  		virtnet_xdp_put_sq(vi, sq);
> >  	}
> >  
> > -	return received;
> > +	return retry_refill ? budget : received;
> >  }
> >  
> >  static void virtnet_disable_queue_pair(struct virtnet_info *vi, int qp_index)
> > @@ -3230,9 +3226,11 @@ static int virtnet_open(struct net_device *dev)
> >  
> >  	for (i = 0; i < vi->max_queue_pairs; i++) {
> >  		if (i < vi->curr_queue_pairs)
> > -			/* Make sure we have some buffers: if oom use wq. */
> > -			if (!try_fill_recv(vi, &vi->rq[i], GFP_KERNEL))
> > -				schedule_delayed_work(&vi->refill, 0);
> > +			/* If this fails, we will retry later in
> > +			 * NAPI poll, which is scheduled in the below
> > +			 * virtnet_enable_queue_pair
> 
> hmm do we even need this, then?


Oh this one is GFP_KERNEL. So it makes it more likely the ring will
be filled.

> > +			 */
> > +			try_fill_recv(vi, &vi->rq[i], GFP_KERNEL);
> >  
> >  		err = virtnet_enable_queue_pair(vi, i);
> >  		if (err < 0)
> > @@ -3473,15 +3471,15 @@ static void __virtnet_rx_resume(struct virtnet_info *vi,
> >  				bool refill)
> >  {
> >  	bool running = netif_running(vi->dev);
> > -	bool schedule_refill = false;
> >  
> > -	if (refill && !try_fill_recv(vi, rq, GFP_KERNEL))
> > -		schedule_refill = true;
> > +	if (refill)
> > +		/* If this fails, we will retry later in NAPI poll, which is
> > +		 * scheduled in the below virtnet_napi_enable
> > +		 */
> > +		try_fill_recv(vi, rq, GFP_KERNEL);
> 
> 
> hmm do we even need this, then?
> 
> > +
> >  	if (running)
> >  		virtnet_napi_enable(rq);
> > -
> > -	if (schedule_refill)
> > -		schedule_delayed_work(&vi->refill, 0);
> >  }
> >  
> >  static void virtnet_rx_resume_all(struct virtnet_info *vi)
> > @@ -3777,6 +3775,7 @@ static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
> >  	struct virtio_net_rss_config_trailer old_rss_trailer;
> >  	struct net_device *dev = vi->dev;
> >  	struct scatterlist sg;
> > +	int i;
> >  
> >  	if (!vi->has_cvq || !virtio_has_feature(vi->vdev, VIRTIO_NET_F_MQ))
> >  		return 0;
> > @@ -3829,11 +3828,17 @@ static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
> >  	}
> >  succ:
> >  	vi->curr_queue_pairs = queue_pairs;
> > -	/* virtnet_open() will refill when device is going to up. */
> > -	spin_lock_bh(&vi->refill_lock);
> > -	if (dev->flags & IFF_UP && vi->refill_enabled)
> > -		schedule_delayed_work(&vi->refill, 0);
> > -	spin_unlock_bh(&vi->refill_lock);
> > +	if (dev->flags & IFF_UP) {
> > +		/* Let the NAPI poll refill the receive buffer for us. We can't
> > +		 * safely call try_fill_recv() here because the NAPI might be
> > +		 * enabled already.
> > +		 */
> 
> I'd drop this comment, it does not clarify much.
> 
> > +		local_bh_disable();
> > +		for (i = 0; i < vi->curr_queue_pairs; i++)
> > +			virtqueue_napi_schedule(&vi->rq[i].napi, vi->rq[i].vq);
> > +
> > +		local_bh_enable();
> > +	}
> >  
> >  	return 0;
> >  }
> > -- 
> > 2.43.0


