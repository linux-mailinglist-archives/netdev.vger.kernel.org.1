Return-Path: <netdev+bounces-182132-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31F12A87F83
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 13:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E57633A861E
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 11:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77B4283689;
	Mon, 14 Apr 2025 11:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C8fIV8Qq"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E08B176AC5
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 11:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744631186; cv=none; b=ctI3koEF21Ix4ggVsf4atsilv0uQnOl6WeZrk0kf42dyg58Q2wN8Kxp/7HyFZS9UTS7MJ00dOnviO9NcnPHuOh/BzG/irMnoYc9ldWrNb3IMSO2ANU0JNqQ+F5z+VXgMwIQekHtXm6hg+E6qwJO2jKr9RdJni4KWUvlVzml8+A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744631186; c=relaxed/simple;
	bh=TGa5A74hhJRFatKtiDaBCJm3bNAxG+RmuZi9KC/N3rk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o/04crdAbCDKHwxH109YGCK6GH1q06XCPfxf6n0TjbjFNQV/IiZm5On6FYEqDq5q8+sElVUHkfOCx69hIDFWUDCkh6DvN+m2ddSI3Co3ziezw7QuhT1Rd5Cvf+XR2C0Vx2zjyckhQyeIeHBc0SxF2F7NuMURkH/j8W//ok6Odr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C8fIV8Qq; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744631183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zjO+mv63DF8OWXZ5ZxlPzpl6bC2oyYwvBcdRfK7EHgs=;
	b=C8fIV8QqD9O2AbZs9VOIrjM1+M10u3pyBLGOS5I+7N7mSgZYJqzS/+YQ6dqHiChFxnkvlj
	k0OYzt8ka9OtjyTpELkggipLAMkQ5D8b/+1VSlusq8ht7j8Sxcs2hoo4H5WJ6T/mJrQzEm
	4lgMUa1+FCNsobeHa+jVoiLHLF1/u1E=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-UgG0kahPMDW5ZFyYTR-_2g-1; Mon, 14 Apr 2025 07:46:22 -0400
X-MC-Unique: UgG0kahPMDW5ZFyYTR-_2g-1
X-Mimecast-MFC-AGG-ID: UgG0kahPMDW5ZFyYTR-_2g_1744631182
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43cec217977so25669205e9.0
        for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 04:46:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744631181; x=1745235981;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zjO+mv63DF8OWXZ5ZxlPzpl6bC2oyYwvBcdRfK7EHgs=;
        b=G/kBl5ifmgTvHPfBWGwW6WZOLfJuUKk79NhZbxubNkMgC4ff83KB22AHvUss1r7kxg
         TaH1G9JgbZam5hLXq5HZ0ZgIHjA8H/QdqxD/InK7v0x42Wz8sPwwrhXEjMHH69rFB5ff
         aI8OvI3HAG11dELg4cwUaW7mAHM2Ujy0mYbmYXVOVNyT/viqxpz0pfMRNJsbujnQ3SYB
         GEEkIC8Mf+4uP8H9kpT+JCR/QFb08H0Z/8DoUtrDegNqPI2ypUY4GZRM3TE6vnBxvNDO
         /p2SU6yPmfKB0lAFjyvTMv8uB1V/BNudD9s54hEEyR/mE/+wpiCNX4MqIJv/3FvzVrXC
         hXJw==
X-Forwarded-Encrypted: i=1; AJvYcCUwNryB8AikT/WYkNGZCSQ+frs1koJr4ZxjpQa1tB7AWkGpIxuLFaH/gg80mglxp7e5hiE0lL4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGhUXcXtmPmrNk1vHWRsmg4NmEmX7R9YdwRBfLxPTKsE0cDY4P
	A4PnYi5RAf6b5LWm6TAwlLY5UZRGtdc0LlwAkCAfvNHEURLt53lQ4ZAZeio8GNgJDExPAB/qBlX
	K+PduefGPdB+rDSdsJ2yMLBFfBzQyOBJBvBijkb3pzpZHXh3mWr5WJw==
X-Gm-Gg: ASbGncv4J0/T3LBj8A6U/KKKeyDiXauxL1fwVh7mNU8PF4toTB0NrMyUk97risDaOS5
	j5udrbh48IykoXy3D4dbsYXBDEFCwYwDjg1ZLGnKeAFPIyS1sMN882K7IznrS06tf3/nbsaiS5P
	GJ+ObGc1Utofk52XNhLdbuK3NNFh+0lvpkJIUiVZFPhUb/cO0vKxD6MqevKIMVjdXuM5u/4Na5J
	D6xYcnD3kLVy6DvJn4yRm6IV/WjdN3+RBOPnol3TrG53lW+BCtB2fL7nm3B+I1Q71/EB2yw59eE
	hpG6uQ==
X-Received: by 2002:a05:600c:810b:b0:43c:f61e:6ea8 with SMTP id 5b1f17b1804b1-43f3a926c29mr101650495e9.2.1744631181502;
        Mon, 14 Apr 2025 04:46:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFq+5ke4eamrk9xDN2am47+k03CAk53gsv1lkSszP4cGrTySTbHEceig7E6SA/uputECe8AcA==
X-Received: by 2002:a05:600c:810b:b0:43c:f61e:6ea8 with SMTP id 5b1f17b1804b1-43f3a926c29mr101650165e9.2.1744631181039;
        Mon, 14 Apr 2025 04:46:21 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39eae96c074sm10536365f8f.28.2025.04.14.04.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 04:46:20 -0700 (PDT)
Date: Mon, 14 Apr 2025 07:46:17 -0400
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
Subject: Re: [PATCH v2 1/3] virtio-net: disable delayed refill when pausing rx
Message-ID: <20250414074407-mutt-send-email-mst@kernel.org>
References: <20250414050837.31213-1-minhquangbui99@gmail.com>
 <20250414050837.31213-2-minhquangbui99@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250414050837.31213-2-minhquangbui99@gmail.com>

On Mon, Apr 14, 2025 at 12:08:35PM +0700, Bui Quang Minh wrote:
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
> ---
>  drivers/net/virtio_net.c | 60 ++++++++++++++++++++++++++++++++++------
>  1 file changed, 51 insertions(+), 9 deletions(-)


Thans for the patch! Yes something to improve:

> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 7e4617216a4b..4361b91ccc64 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3342,10 +3342,53 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
>  	return NETDEV_TX_OK;
>  }
>  
> +static void virtnet_rx_pause_all(struct virtnet_info *vi)
> +{
> +	bool running = netif_running(vi->dev);
> +
> +	/*
> +	 * Make sure refill_work does not run concurrently to
> +	 * avoid napi_disable race which leads to deadlock.
> +	 */
> +	disable_delayed_refill(vi);
> +	cancel_delayed_work_sync(&vi->refill);
> +	if (running) {
> +		int i;
> +
> +		for (i = 0; i < vi->max_queue_pairs; i++) {
> +			virtnet_napi_disable(&vi->rq[i]);
> +			virtnet_cancel_dim(vi, &vi->rq[i].dim);

duplicates a bit of code from virtnet_rx_pause_all.


> +		}
> +	}
> +}
> +
> +static void virtnet_rx_resume_all(struct virtnet_info *vi)
> +{
> +	bool running = netif_running(vi->dev);
> +	int i;
> +
> +	enable_delayed_refill(vi);
> +	for (i = 0; i < vi->max_queue_pairs; i++) {
> +		if (i < vi->curr_queue_pairs) {
> +			if (!try_fill_recv(vi, &vi->rq[i], GFP_KERNEL))
> +				schedule_delayed_work(&vi->refill, 0);
> +		}
> +
> +		if (running)
> +			virtnet_napi_enable(&vi->rq[i]);
> +	}
> +}
> +
>  static void virtnet_rx_pause(struct virtnet_info *vi, struct receive_queue *rq)
>  {
>  	bool running = netif_running(vi->dev);
>  
> +	/*
> +	 * Make sure refill_work does not run concurrently to
> +	 * avoid napi_disable race which leads to deadlock.
> +	 */
> +	disable_delayed_refill(vi);
> +	cancel_delayed_work_sync(&vi->refill);


Maybe rename this e.g. __virtnet_rx_pause ?


>  	if (running) {
>  		virtnet_napi_disable(rq);
>  		virtnet_cancel_dim(vi, &rq->dim);
> @@ -3356,6 +3399,7 @@ static void virtnet_rx_resume(struct virtnet_info *vi, struct receive_queue *rq)
>  {
>  	bool running = netif_running(vi->dev);
>  
> +	enable_delayed_refill(vi);
>  	if (!try_fill_recv(vi, rq, GFP_KERNEL))
>  		schedule_delayed_work(&vi->refill, 0);
>  
> @@ -5959,12 +6003,12 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
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
> @@ -5996,13 +6040,12 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
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
> @@ -6014,11 +6057,10 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
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


