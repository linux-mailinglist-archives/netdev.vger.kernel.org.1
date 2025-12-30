Return-Path: <netdev+bounces-246374-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A454DCEA35A
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 17:44:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 37360302C4EA
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 16:44:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5AF31D39A;
	Tue, 30 Dec 2025 16:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yn3df44q";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="NXJpn3B7"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F79222A4CC
	for <netdev@vger.kernel.org>; Tue, 30 Dec 2025 16:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767113062; cv=none; b=m6A/pYmAaPhEyYWqVS+bKdO4yo24xP1stpeTDl7R4lFNtlGzMDwYBWHtylZRSTP7sRJP4onAtgmB7jjCMIMKn+HDnaPyyfJHIxcWFTC5pgqfrAI7aHXE4ufExcBGJjS/VR8iB3WqWKkqBN4iEeEG7zuUevSSEYR5rILFQfCQbc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767113062; c=relaxed/simple;
	bh=q7NyvwLa9sicZtWBXMJxS7E+6FRDA40em7tVFCO+yco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JgtJsyrBJSUWZ7DVQFPNKcyr40ruadySURPveLFWNVLfJAfeMOGyCyZzxs8Meqp/4GevVOOaA9qxgDO1VvMN8UufpeetJNk3XVzdpLyoeAUSAita1Iplq8lxTaJCNon6j9mKoIviZVh4/GoqS2KONl3C4Ue4xjKLpINHOPMzs8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yn3df44q; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=NXJpn3B7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1767113059;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xYI37eW2c8supzl6v0y3GWwFPuk4FGpGgqwaJcS9l/c=;
	b=Yn3df44qreTrLRCBgtaVN9rQESohrI0Zy04m/lgtp0U4CcxLY74OH5ekqopn0jtS4xnbax
	x7OcC8NrNmBwzd79yVqsJ6HPZAiXlu795SSdo1hycHJWyd1To7/lL0ki4jyj0HjBo/cG8O
	Zv1SOmhhkH3OtPr2oVIr53Lb5Ty8WlY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-zmorCLbJN5ie-wcGpITaHQ-1; Tue, 30 Dec 2025 11:44:15 -0500
X-MC-Unique: zmorCLbJN5ie-wcGpITaHQ-1
X-Mimecast-MFC-AGG-ID: zmorCLbJN5ie-wcGpITaHQ_1767113055
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4792bd2c290so97111375e9.1
        for <netdev@vger.kernel.org>; Tue, 30 Dec 2025 08:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1767113054; x=1767717854; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xYI37eW2c8supzl6v0y3GWwFPuk4FGpGgqwaJcS9l/c=;
        b=NXJpn3B7wKvEesvanrH4VI/6kf80ZY8pHPKwNp39RWkMJEbLy66GKLMD8IPKqCmuc7
         icxrepvaG0F4IOXljMOTpqil07Mrp5E4bEedE8pamvtcl5YLkLK3VuesMAHFF5yp03gD
         gbGUDQKUDT/K3V20J3nGeNmIv5u1wNSjKehNlknk29V8jb4bzKCIovhjZCp/b1t3h5KA
         jQeU9q+yJfIcJ2ZTW+b/kJvmfp7w7u/+MnTWuaiKwD1tRBlm0XAwDI93Tsh0AsUDgZid
         YdUsTXhFlfx/GfKjzblI4yQ4NSNlN/QqWJnMo41vXac69QtJKHGzg9VeuZkYehzANETt
         V2+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767113054; x=1767717854;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xYI37eW2c8supzl6v0y3GWwFPuk4FGpGgqwaJcS9l/c=;
        b=BYTcEDgD7nZgpkbWvCEo1e2+K2fx0sJD52fq8lq2qumI27rnB/5nukrnenq6Pf2rGd
         1OWMbQQ2t2LipgHpJtAcmEmt+5qZxnd3RhYcagI/R5bAmQLEzEhlfxbXy32KsG1L4yNy
         q6eOo2jEVephioVbEXo7/ceS/zSo3RP/XF3HDwXoSatNQKnj7XLMJkhoOZ6miZgGC2Zc
         r5hDLduQXMHa4NXBC3lqg3857ttJ8eE6+oMh+EleqHqjmDfNTbQWITDGcHw0bHeUetQD
         qQ/jgWsY66LrpCdJeSZHCPUp544QwzXk6AmO1+xDf/wgsSC6hiPdArWpw/bYFpcCwWQm
         hLEw==
X-Forwarded-Encrypted: i=1; AJvYcCUwjj0b4v1lf5VagwzxTs1kfBWNZtxd91T9ZgqK01x3qr+hE2LOLJms8/peFqOOzBOLYUhOHOk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNO2TGWRdlRk6oDt4jo9ogExHt1qIqlYnjMT4j9KwwhFhFTRmC
	f86ZDT/OqfgJq2qO2boowIZtbscyHFhpo4SlxaU1N7reHAQYlxrT/AAEc9h+xGYIYySfhl9K5Sl
	iqccShuk4RVj9z25Hfx3uym/aNzkDHHIPWBnqxCrr+Pgh2tpVhZMJPYJxoA==
X-Gm-Gg: AY/fxX50UE58L67bQOQxYIFBtucj02N0qj2go0VoeSzPovShNBrAYyxsOzdVnV1He9H
	ZrOjxYnyq9yaJuzmN/gtXUFHWA3uHe1PEYP9foNFZmrw0rEA0Go/N3azsR3OwwAy5YPBcYJHIcb
	oC1SWlpBdBMO4sYOg8+e6NC9g9inLtdTzKJ8vYHI1/4U2MC1bA9xfahFMNnNzgDZxfgQ5KUFl9s
	jDaPTzX3lEBlSuWMF9fv3u08XIKSuQMQrVBm4R9/wm+iYW6K+boiHKbT5iP9rm/sNXOi2JAxexL
	Mo+wcObU6Gl7SMOHpOjK3DZyj7VpbmZxjY6kcjiLCJYuLJcC/LRcMuI+rpSxbgTut/UltWVcfFN
	wgyHU9sMGHeSvQ0IBO7hrya99SUCbPIeHrg==
X-Received: by 2002:a05:600d:102:b0:477:9ce2:a0d8 with SMTP id 5b1f17b1804b1-47d197fa272mr258316455e9.0.1767113054547;
        Tue, 30 Dec 2025 08:44:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IExM9stLawDuC2XzpEaGqqSH1Qt3OQeeOH56cPRU+M9oRh04T9pEzHr6R7usT5ampfEyN0iTQ==
X-Received: by 2002:a05:600d:102:b0:477:9ce2:a0d8 with SMTP id 5b1f17b1804b1-47d197fa272mr258316135e9.0.1767113054022;
        Tue, 30 Dec 2025 08:44:14 -0800 (PST)
Received: from redhat.com (IGLD-80-230-31-118.inter.net.il. [80.230.31.118])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d192e88f5sm596270045e9.0.2025.12.30.08.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 08:44:13 -0800 (PST)
Date: Tue, 30 Dec 2025 11:44:10 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org,
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
	bpf@vger.kernel.org
Subject: Re: [PATCH net 1/3] virtio-net: make refill work a per receive queue
 work
Message-ID: <20251230114250-mutt-send-email-mst@kernel.org>
References: <20251223152533.24364-1-minhquangbui99@gmail.com>
 <20251223152533.24364-2-minhquangbui99@gmail.com>
 <CACGkMEvXkPiTGxZ6nuC72-VGdLHVXzrGa9bAF=TcP8nqPjeZ_w@mail.gmail.com>
 <1766540234.3618076-1-xuanzhuo@linux.alibaba.com>
 <20251223204555-mutt-send-email-mst@kernel.org>
 <CACGkMEs7_-=-8w=7gW8R_EhzfWOwuDoj4p-iCPQ7areOa9uaUw@mail.gmail.com>
 <20251225112729-mutt-send-email-mst@kernel.org>
 <CACGkMEt33BAWGmeFfHWYrjQLOT4+JB7HsWWVMKUn6yFxQ9y2gg@mail.gmail.com>
 <20251226022727-mutt-send-email-mst@kernel.org>
 <7143657a-a52f-4cff-acbc-e89f4c713cc4@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7143657a-a52f-4cff-acbc-e89f4c713cc4@gmail.com>

On Tue, Dec 30, 2025 at 11:28:50PM +0700, Bui Quang Minh wrote:
> On 12/26/25 14:37, Michael S. Tsirkin wrote:
> > On Fri, Dec 26, 2025 at 09:31:26AM +0800, Jason Wang wrote:
> > > On Fri, Dec 26, 2025 at 12:27 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > On Thu, Dec 25, 2025 at 03:33:29PM +0800, Jason Wang wrote:
> > > > > On Wed, Dec 24, 2025 at 9:48 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > > On Wed, Dec 24, 2025 at 09:37:14AM +0800, Xuan Zhuo wrote:
> > > > > > > Hi Jason,
> > > > > > > 
> > > > > > > I'm wondering why we even need this refill work. Why not simply let NAPI retry
> > > > > > > the refill on its next run if the refill fails? That would seem much simpler.
> > > > > > > This refill work complicates maintenance and often introduces a lot of
> > > > > > > concurrency issues and races.
> > > > > > > 
> > > > > > > Thanks.
> > > > > > refill work can refill from GFP_KERNEL, napi only from ATOMIC.
> > > > > > 
> > > > > > And if GFP_ATOMIC failed, aggressively retrying might not be a great idea.
> > > > > Btw, I see some drivers are doing things as Xuan said. E.g
> > > > > mlx5e_napi_poll() did:
> > > > > 
> > > > > busy |= INDIRECT_CALL_2(rq->post_wqes,
> > > > >                                  mlx5e_post_rx_mpwqes,
> > > > >                                  mlx5e_post_rx_wqes,
> > > > > 
> > > > > ...
> > > > > 
> > > > > if (busy) {
> > > > >           if (likely(mlx5e_channel_no_affinity_change(c))) {
> > > > >                  work_done = budget;
> > > > >                  goto out;
> > > > > ...
> > > > 
> > > > is busy a GFP_ATOMIC allocation failure?
> > > Yes, and I think the logic here is to fallback to ksoftirqd if the
> > > allocation fails too much.
> > > 
> > > Thanks
> > 
> > True. I just don't know if this works better or worse than the
> > current design, but it is certainly simpler and we never actually
> > worried about the performance of the current one.
> > 
> > 
> > So you know, let's roll with this approach.
> > 
> > I do however ask that some testing is done on the patch forcing these OOM
> > situations just to see if we are missing something obvious.
> > 
> > 
> > the beauty is the patch can be very small:
> > 1. patch 1 do not schedule refill ever, just retrigger napi
> > 2. remove all the now dead code
> > 
> > this way patch 1 will be small and backportable to stable.
> 
> I've tried 1. with this patch
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 1bb3aeca66c6..9e890aff2d95 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3035,7 +3035,7 @@ static int virtnet_receive_packets(struct virtnet_info *vi,
>  }
> 
>  static int virtnet_receive(struct receive_queue *rq, int budget,
> -               unsigned int *xdp_xmit)
> +               unsigned int *xdp_xmit, bool *retry_refill)
>  {
>      struct virtnet_info *vi = rq->vq->vdev->priv;
>      struct virtnet_rq_stats stats = {};
> @@ -3047,12 +3047,8 @@ static int virtnet_receive(struct receive_queue *rq, int budget,
>          packets = virtnet_receive_packets(vi, rq, budget, xdp_xmit, &stats);
> 
>      if (rq->vq->num_free > min((unsigned int)budget, virtqueue_get_vring_size(rq->vq)) / 2) {
> -        if (!try_fill_recv(vi, rq, GFP_ATOMIC)) {
> -            spin_lock(&vi->refill_lock);
> -            if (vi->refill_enabled)
> -                schedule_delayed_work(&vi->refill, 0);
> -            spin_unlock(&vi->refill_lock);
> -        }
> +        if (!try_fill_recv(vi, rq, GFP_ATOMIC))
> +            *retry_refill = true;
>      }
> 
>      u64_stats_set(&stats.packets, packets);
> @@ -3129,18 +3125,18 @@ static int virtnet_poll(struct napi_struct *napi, int budget)
>      struct send_queue *sq;
>      unsigned int received;
>      unsigned int xdp_xmit = 0;
> -    bool napi_complete;
> +    bool napi_complete, retry_refill = false;
> 
>      virtnet_poll_cleantx(rq, budget);
> 
> -    received = virtnet_receive(rq, budget, &xdp_xmit);
> +    received = virtnet_receive(rq, budget, &xdp_xmit, &retry_refill);
>      rq->packets_in_napi += received;
> 
>      if (xdp_xmit & VIRTIO_XDP_REDIR)
>          xdp_do_flush();
> 
>      /* Out of packets? */
> -    if (received < budget) {
> +    if (received < budget && !retry_refill) {
>          napi_complete = virtqueue_napi_complete(napi, rq->vq, received);
>          /* Intentionally not taking dim_lock here. This may result in a
>           * spurious net_dim call. But if that happens virtnet_rx_dim_work
> @@ -3230,9 +3226,11 @@ static int virtnet_open(struct net_device *dev)
> 
>      for (i = 0; i < vi->max_queue_pairs; i++) {
>          if (i < vi->curr_queue_pairs)
> -            /* Make sure we have some buffers: if oom use wq. */
> -            if (!try_fill_recv(vi, &vi->rq[i], GFP_KERNEL))
> -                schedule_delayed_work(&vi->refill, 0);
> +            /* If this fails, we will retry later in
> +             * NAPI poll, which is scheduled in the below
> +             * virtnet_enable_queue_pair
> +             */
> +            try_fill_recv(vi, &vi->rq[i], GFP_KERNEL);
> 
>          err = virtnet_enable_queue_pair(vi, i);
>          if (err < 0)
> @@ -3473,15 +3471,15 @@ static void __virtnet_rx_resume(struct virtnet_info *vi,
>                  bool refill)
>  {
>      bool running = netif_running(vi->dev);
> -    bool schedule_refill = false;
> 
> -    if (refill && !try_fill_recv(vi, rq, GFP_KERNEL))
> -        schedule_refill = true;
> +    if (refill)
> +        /* If this fails, we will retry later in NAPI poll, which is
> +         * scheduled in the below virtnet_napi_enable
> +         */
> +        try_fill_recv(vi, rq, GFP_KERNEL);
> +
>      if (running)
>          virtnet_napi_enable(rq);
> -
> -    if (schedule_refill)
> -        schedule_delayed_work(&vi->refill, 0);
>  }
> 
>  static void virtnet_rx_resume_all(struct virtnet_info *vi)
> @@ -3777,6 +3775,7 @@ static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
>      struct virtio_net_rss_config_trailer old_rss_trailer;
>      struct net_device *dev = vi->dev;
>      struct scatterlist sg;
> +    int i;
> 
>      if (!vi->has_cvq || !virtio_has_feature(vi->vdev, VIRTIO_NET_F_MQ))
>          return 0;
> @@ -3829,11 +3828,8 @@ static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
>      }
>  succ:
>      vi->curr_queue_pairs = queue_pairs;
> -    /* virtnet_open() will refill when device is going to up. */
> -    spin_lock_bh(&vi->refill_lock);
> -    if (dev->flags & IFF_UP && vi->refill_enabled)
> -        schedule_delayed_work(&vi->refill, 0);
> -    spin_unlock_bh(&vi->refill_lock);
> +    for (i = 0; i < vi->curr_queue_pairs; i++)
> +        try_fill_recv(vi, &vi->rq[i], GFP_KERNEL);
> 
>      return 0;
>  }
> 
> 
> But I got an issue with selftests/drivers/net/hw/xsk_reconfig.py. This
> test sets up XDP zerocopy (Xsk) but does not provide any descriptors to
> the fill ring. So xsk_pool does not have any descriptors and
> try_fill_recv will always fail. The RX NAPI keeps polling. Later, when
> we want to disable the xsk_pool, in virtnet_xsk_pool_disable path,
> 
> virtnet_xsk_pool_disable
> -> virtnet_rq_bind_xsk_pool
>   -> virtnet_rx_pause
>     -> __virtnet_rx_pause
>       -> virtnet_napi_disable
>         -> napi_disable
> 
> We get stuck in napi_disable because the RX NAPI is still polling.
> 
> In drivers/net/ethernet/mellanox/mlx5, AFAICS, it uses state bit for
> synchronization between xsk setup (mlx5e_xsk_setup_pool) with RX NAPI
> (mlx5e_napi_poll) without using napi_disable/enable. However, in
> drivers/net/ethernet/intel/ice,
> 
> ice_xsk_pool_setup
> -> ice_qp_dis
>   -> ice_qvec_toggle_napi
>     -> napi_disable
> 
> it still uses napi_disable. Did I miss something in the above patch?
> I'll try to look into using another synchronization instead of
> napi_disable/enable in xsk_pool setup path too.
> 
> Thanks,
> Quang Minh.


... and the simplicity is out of the window. Up to you but maybe
it is easier to keep plugging the holes in the current approach.
It has been in the field for a very long time now, at least.

-- 
MST


