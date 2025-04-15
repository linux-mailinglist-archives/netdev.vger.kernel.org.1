Return-Path: <netdev+bounces-182807-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB7AA89F40
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 15:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 907521902287
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 13:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D42E3297A60;
	Tue, 15 Apr 2025 13:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TjiiS0uH"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915D629A3C2
	for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 13:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744723177; cv=none; b=utamM78vYuVdSV9KWqgYtaLMnJnwn5hbCqspHgmZdLO1OjvKkh9m1e86Efp7X5h8G0wFpjTwje533R5cWxf3yErg5Y63Ym35ZApaB93hQ8uMyqNJkNudSrgfv5c97hNLXbsRFQ7YalSYVl2g0cFM6bQib84PhTjsrVxYHIJFWH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744723177; c=relaxed/simple;
	bh=e9R32tQBSXYQd8goFfR+Lx7lJByV3tKzSiDQM/hj3JU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ntR7DZQBCtsXPX4Hyj53oTxpwC8DF/8Df5GRAVg1Sv/P7flTpkkVBYrIs1l2vwLznYblLJ0Z1yq4V60ooYvrPq0MBunnY1/LTTcn+BSd7lxt/Q66mzAE+sHH+3zjBXzcT+uYswto87emf396C8DV3/zjaXI8q4tlGKmBauuBjzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TjiiS0uH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744723173;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HDFRVUvYARrrdoMVKwNSz9nrR/1vGVN5NRO4r+H+6kk=;
	b=TjiiS0uH7PjepR7rcajPBTCLIYGdOXmkFJVyHQGAVk2cVnWtVL0AJFsRl3+pdyVflqITKX
	PtMf9ratbKcsB2CnfhHsmbeCKeA0FUYNglxqq5klJTvxGQ/mf0sVvEvgs4M1muEVYPNAuV
	/OsNUWAGser3Vl7T4VGb8G3/kvUQH1M=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-498-5PwxuRsWPpG60xMDyJoAow-1; Tue, 15 Apr 2025 09:19:32 -0400
X-MC-Unique: 5PwxuRsWPpG60xMDyJoAow-1
X-Mimecast-MFC-AGG-ID: 5PwxuRsWPpG60xMDyJoAow_1744723171
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-39143311936so2228669f8f.0
        for <netdev@vger.kernel.org>; Tue, 15 Apr 2025 06:19:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744723171; x=1745327971;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HDFRVUvYARrrdoMVKwNSz9nrR/1vGVN5NRO4r+H+6kk=;
        b=cZlG01KZ0i7hNLFfsLMX4MVcUOzEDuGHPw5RGZ9bRVcVPh37bsAGxmQnQ33U+UTHVL
         OplLq+rtc2iZny/6HBZzF4rmWILd1vQwDmFy/tsvHRdba4WU/GPWwmu79664gIbr8Wc1
         vMOxZbPkW5aEB/p6sYB2/dpL9XAgeHrgy+f2rUFP1adwCQAAobdmZXyP3gan9jYCZ/1a
         oySZlSjofKEK6mKtiH+nuLepoQsNQKbrwD5XlyTqdGFy3wpBi2ayHbHVzgY2CsKpGjum
         ZjQpanNGDOLvSQwEkIs7cWiWYdt8OBL7neNuDW8tRKXa+IhF9erdTOH6uWgB+pDgS3+g
         srwQ==
X-Forwarded-Encrypted: i=1; AJvYcCX8eWXwoTzxvQV7GRfFs4IzUknTecD6gooJ+2J5II10LmJkRKQ9vqAZO2ynclviWGHKNmq579o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlpdKHv3kk4+JRxAktxRLcW4wpyDmElUVLBCqZl31blnvPdIh2
	Ip5D/Jgo34tluqh2ROCQ62aO/F5CcOA9yp1JiBLpxAVOI6xWva34ahADKKW9BZETwJoU2VQZx4z
	V15H8bfDSIAivTj6f6LUtntTeQy8mATbsoZwS72FznmmSW2SJMVcXLQ==
X-Gm-Gg: ASbGncu0jAqGGM+E0fgBcfKqI59WIDFwispTCYcH/4GKHRONnf+QBY/PJv7Jjbu9yie
	3c1x6Uyamrxoq/6564Fq7vwud8CrQzWS96bQ7TOChVXVS7fgNIb1AdGXhIrBx+Zczxb6D3hpTKN
	/9nHtiytoqLa0c7q/sBzXZE2G5SooOCQDY6DtIPlLgmYjATM1BAzJAE1FoUNrYCrj/qT6IOICM+
	Bk5fSBpF0/R4KW8Y9PUChSwupEEqxR1j9ovWorWEK/pcYKa1sqDW8AW9yFwxuXIvaKsoT/QPzHg
	qiMyTA==
X-Received: by 2002:a5d:6d82:0:b0:38f:2b77:a9f3 with SMTP id ffacd0b85a97d-39eaaecd9d3mr14812790f8f.43.1744723171088;
        Tue, 15 Apr 2025 06:19:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH3g59/gkleqCg6T/d47/qE3AgIRCAsXkZY+0Zs8YtzSwtO0Ld+xwTSwCyCTlke980a+IysoQ==
X-Received: by 2002:a5d:6d82:0:b0:38f:2b77:a9f3 with SMTP id ffacd0b85a97d-39eaaecd9d3mr14812768f8f.43.1744723170724;
        Tue, 15 Apr 2025 06:19:30 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f206269c8sm217509515e9.16.2025.04.15.06.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 06:19:30 -0700 (PDT)
Date: Tue, 15 Apr 2025 09:19:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bui Quang Minh <minhquangbui99@gmail.com>
Cc: virtualization@lists.linux.dev, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v3 1/3] virtio-net: disable delayed refill when pausing rx
Message-ID: <20250415091917-mutt-send-email-mst@kernel.org>
References: <20250415074341.12461-1-minhquangbui99@gmail.com>
 <20250415074341.12461-2-minhquangbui99@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250415074341.12461-2-minhquangbui99@gmail.com>

On Tue, Apr 15, 2025 at 02:43:39PM +0700, Bui Quang Minh wrote:
> When pausing rx (e.g. set up xdp, xsk pool, rx resize), we call
> napi_disable() on the receive queue's napi. In delayed refill_work, it
> also calls napi_disable() on the receive queue's napi.  When
> napi_disable() is called on an already disabled napi, it will sleep in
> napi_disable_locked while still holding the netdev_lock. As a result,
> later napi_enable gets stuck too as it cannot acquire the netdev_lock.
> This leads to refill_work and the pause-then-resume tx are stuck
> altogether.
> 
> This scenario can be reproducible by binding a XDP socket to virtio-net
> interface without setting up the fill ring. As a result, try_fill_recv
> will fail until the fill ring is set up and refill_work is scheduled.
> 
> This commit adds virtnet_rx_(pause/resume)_all helpers and fixes up the
> virtnet_rx_resume to disable future and cancel all inflights delayed
> refill_work before calling napi_disable() to pause the rx.
> 
> Fixes: 413f0271f396 ("net: protect NAPI enablement with netdev_lock()")
> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  drivers/net/virtio_net.c | 69 +++++++++++++++++++++++++++++++++-------
>  1 file changed, 57 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 7e4617216a4b..848fab51dfa1 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3342,7 +3342,8 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
>  	return NETDEV_TX_OK;
>  }
>  
> -static void virtnet_rx_pause(struct virtnet_info *vi, struct receive_queue *rq)
> +static void __virtnet_rx_pause(struct virtnet_info *vi,
> +			       struct receive_queue *rq)
>  {
>  	bool running = netif_running(vi->dev);
>  
> @@ -3352,17 +3353,63 @@ static void virtnet_rx_pause(struct virtnet_info *vi, struct receive_queue *rq)
>  	}
>  }
>  
> -static void virtnet_rx_resume(struct virtnet_info *vi, struct receive_queue *rq)
> +static void virtnet_rx_pause_all(struct virtnet_info *vi)
> +{
> +	int i;
> +
> +	/*
> +	 * Make sure refill_work does not run concurrently to
> +	 * avoid napi_disable race which leads to deadlock.
> +	 */
> +	disable_delayed_refill(vi);
> +	cancel_delayed_work_sync(&vi->refill);
> +	for (i = 0; i < vi->max_queue_pairs; i++)
> +		__virtnet_rx_pause(vi, &vi->rq[i]);
> +}
> +
> +static void virtnet_rx_pause(struct virtnet_info *vi, struct receive_queue *rq)
> +{
> +	/*
> +	 * Make sure refill_work does not run concurrently to
> +	 * avoid napi_disable race which leads to deadlock.
> +	 */
> +	disable_delayed_refill(vi);
> +	cancel_delayed_work_sync(&vi->refill);
> +	__virtnet_rx_pause(vi, rq);
> +}
> +
> +static void __virtnet_rx_resume(struct virtnet_info *vi,
> +				struct receive_queue *rq,
> +				bool refill)
>  {
>  	bool running = netif_running(vi->dev);
>  
> -	if (!try_fill_recv(vi, rq, GFP_KERNEL))
> +	if (refill && !try_fill_recv(vi, rq, GFP_KERNEL))
>  		schedule_delayed_work(&vi->refill, 0);
>  
>  	if (running)
>  		virtnet_napi_enable(rq);
>  }
>  
> +static void virtnet_rx_resume_all(struct virtnet_info *vi)
> +{
> +	int i;
> +
> +	enable_delayed_refill(vi);
> +	for (i = 0; i < vi->max_queue_pairs; i++) {
> +		if (i < vi->curr_queue_pairs)
> +			__virtnet_rx_resume(vi, &vi->rq[i], true);
> +		else
> +			__virtnet_rx_resume(vi, &vi->rq[i], false);
> +	}
> +}
> +
> +static void virtnet_rx_resume(struct virtnet_info *vi, struct receive_queue *rq)
> +{
> +	enable_delayed_refill(vi);
> +	__virtnet_rx_resume(vi, rq, true);
> +}
> +
>  static int virtnet_rx_resize(struct virtnet_info *vi,
>  			     struct receive_queue *rq, u32 ring_num)
>  {
> @@ -5959,12 +6006,12 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
>  	if (prog)
>  		bpf_prog_add(prog, vi->max_queue_pairs - 1);
>  
> +	virtnet_rx_pause_all(vi);
> +
>  	/* Make sure NAPI is not using any XDP TX queues for RX. */
>  	if (netif_running(dev)) {
> -		for (i = 0; i < vi->max_queue_pairs; i++) {
> -			virtnet_napi_disable(&vi->rq[i]);
> +		for (i = 0; i < vi->max_queue_pairs; i++)
>  			virtnet_napi_tx_disable(&vi->sq[i]);
> -		}
>  	}
>  
>  	if (!prog) {
> @@ -5996,13 +6043,12 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
>  		vi->xdp_enabled = false;
>  	}
>  
> +	virtnet_rx_resume_all(vi);
>  	for (i = 0; i < vi->max_queue_pairs; i++) {
>  		if (old_prog)
>  			bpf_prog_put(old_prog);
> -		if (netif_running(dev)) {
> -			virtnet_napi_enable(&vi->rq[i]);
> +		if (netif_running(dev))
>  			virtnet_napi_tx_enable(&vi->sq[i]);
> -		}
>  	}
>  
>  	return 0;
> @@ -6014,11 +6060,10 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
>  			rcu_assign_pointer(vi->rq[i].xdp_prog, old_prog);
>  	}
>  
> +	virtnet_rx_resume_all(vi);
>  	if (netif_running(dev)) {
> -		for (i = 0; i < vi->max_queue_pairs; i++) {
> -			virtnet_napi_enable(&vi->rq[i]);
> +		for (i = 0; i < vi->max_queue_pairs; i++)
>  			virtnet_napi_tx_enable(&vi->sq[i]);
> -		}
>  	}
>  	if (prog)
>  		bpf_prog_sub(prog, vi->max_queue_pairs - 1);
> -- 
> 2.43.0


