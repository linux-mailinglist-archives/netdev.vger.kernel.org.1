Return-Path: <netdev+bounces-168288-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4A53A3E682
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 22:25:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B4474237F6
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 21:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02E6262D3A;
	Thu, 20 Feb 2025 21:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SxNXIhwi"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545691E571F
	for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 21:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740086741; cv=none; b=QjoS2c864tlUTvr2e0E8/8DU5zZH7MrJo5iR/dVx5N4U/tU6PcyYi2Pg4efDJNCqaQjoo7jRU6uv/mwqDOOKmujLupVThGmvgFEV2u73r/woqsL759C5pzwCPJng8dHZ6OFcimk7SZLr7gU9nmHopRlGoA8T02KWt8hURDgA9ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740086741; c=relaxed/simple;
	bh=x7rBl2z18pUs53vExXjZWpBRXv/IZMZTi6N+JNBqaBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZBgrQR4ld4ITTz8r8mb7RG+BC7GF03QuwgoDhRT68yUSIA+ZjvoVCqH5hk4GASj66cAwQRAezmM68TwgZHA5zBRnC6G5gEjKfBlJtaB/whfO3AI6QphEeU0pg601W2lP7VD01YDcgrhYeaU76WvEbIewFxYIepn83M5AYD7MAEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SxNXIhwi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740086738;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=unrDTS7QCI25KAS4sCB3l7J3lV8KCBJAU/xxoJQKS8w=;
	b=SxNXIhwiTBY5lgrmQXwPHEib+KyiQgPYYF4ngnTzk8yUGkgSn+zvjn5C9/vtqT3LG5mZMC
	oIkz38IcVi+uKj5QKbx/PbmDwkuq05GwSGLbr91VmoF3Yhk5KvJK6SVKZf31b0hrQPZiT9
	d9gPD0qW37XRuETwyip2W4PL63+O9gI=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-r4Ia4ZslOv-f4ll85X0G7w-1; Thu, 20 Feb 2025 16:25:35 -0500
X-MC-Unique: r4Ia4ZslOv-f4ll85X0G7w-1
X-Mimecast-MFC-AGG-ID: r4Ia4ZslOv-f4ll85X0G7w_1740086734
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5da03762497so1381200a12.1
        for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 13:25:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740086734; x=1740691534;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=unrDTS7QCI25KAS4sCB3l7J3lV8KCBJAU/xxoJQKS8w=;
        b=t/sh/6Q/r+ogcdPWAY8UMTcX2OdjVqMUJk/5GnlbHxFzWOAOSorrFmRbtNxDf7ssDW
         ukMKosKHMABOUiGgydNF+6O+e0d5wG8nSgpoHa/DirnIAdPsavYKDnHK+3Ns2sDHxRd7
         ddmRkG2PSPUX1CHmBXXXlINSapjSm5XySK73EPemOXhc6LKTOq4LJQ6XTdgs+S3tUug+
         kCoTBjOjEu1TO1FLL/TzdGdrQdqp2XH+Q8LvNoPQAa+Men54XBBhqPNNx15nL49Yx7xZ
         C7hwmnghmzxhf5RzCwkcuhx4SXBLPEx0J7ROKCGW/+iXj8Q8+Znynob/6tHn9/nFg2SH
         yvLg==
X-Forwarded-Encrypted: i=1; AJvYcCVV3Ko2ZMPKsF6lMC4MXtcy2rwVSylc8XqOSEOBERPMh0yf5aFuFHVGpZ2ZPqKWaZ4XYZdTHIk=@vger.kernel.org
X-Gm-Message-State: AOJu0YweBLoK61g3bXQulVoo/LHJyfSIJ3CbrcO/rC9fG86ownyNnRv4
	sIWIGLCMdYnKzN6OpDJQy3wWXfsLb4YcDiOrCVxSGR2ub8X/6P4z6GjPcON+WyHmghztkDMtcxR
	dxyTWwtSjqa+pkuU7SE/uoDlnnvLiXnGO2/rkTQGUpVyWRiXbva2IaQ==
X-Gm-Gg: ASbGncuvYh1ztsTd9sEthB5V74cm7Nt/jDKOfHSi706ZSxvX9u0PFlS7NFIPKof7o+D
	FREhNZAaAwTjkXL4LRECud3/a/jEVOFyv+c3OU2A3ww+mzcqI3G2FTFZEVEVbyLxSOhaER2aUiZ
	E9iEJq/IQHu2LDqya2yO+jcVN35f7zPsu2S+7gNam2GPzDb8cOB6WV1St9xUsr3yC1wY4GKg0Bn
	XNqAGnR/85xvh9rKJMIAwfHdAMZMNJ6MzTev3Ab2DwE3x6WlDe1ivOl3P6QfHXeiR9ajQ==
X-Received: by 2002:a05:6402:2381:b0:5dc:8fc1:b3b5 with SMTP id 4fb4d7f45d1cf-5e0b63746femr543893a12.15.1740086734509;
        Thu, 20 Feb 2025 13:25:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH5v3Yl+txcCz5/XdiQPZHOqYI0qvokO2xkWoSI5C9U/U0H41NLIvQ3f0aIpX8wcg7Zxg0iug==
X-Received: by 2002:a05:6402:2381:b0:5dc:8fc1:b3b5 with SMTP id 4fb4d7f45d1cf-5e0b63746femr543882a12.15.1740086734132;
        Thu, 20 Feb 2025 13:25:34 -0800 (PST)
Received: from redhat.com ([2.55.163.174])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dece1d3624sm12881090a12.40.2025.02.20.13.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Feb 2025 13:25:32 -0800 (PST)
Date: Thu, 20 Feb 2025 16:25:28 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] virtio-net: tweak for better TX performance in
 NAPI mode
Message-ID: <20250220162359-mutt-send-email-mst@kernel.org>
References: <20250218023908.1755-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218023908.1755-1-jasowang@redhat.com>

On Tue, Feb 18, 2025 at 10:39:08AM +0800, Jason Wang wrote:
> There are several issues existed in start_xmit():
> 
> - Transmitted packets need to be freed before sending a packet, this
>   introduces delay and increases the average packets transmit
>   time. This also increase the time that spent in holding the TX lock.
> - Notification is enabled after free_old_xmit_skbs() which will
>   introduce unnecessary interrupts if TX notification happens on the
>   same CPU that is doing the transmission now (actually, virtio-net
>   driver are optimized for this case).
> 
> So this patch tries to avoid those issues by not cleaning transmitted
> packets in start_xmit() when TX NAPI is enabled and disable
> notifications even more aggressively. Notification will be since the
> beginning of the start_xmit(). But we can't enable delayed
> notification after TX is stopped as we will lose the
> notifications. Instead, the delayed notification needs is enabled
> after the virtqueue is kicked for best performance.
> 
> Performance numbers:
> 
> 1) single queue 2 vcpus guest with pktgen_sample03_burst_single_flow.sh
>    (burst 256) + testpmd (rxonly) on the host:
> 
> - When pinning TX IRQ to pktgen VCPU: split virtqueue PPS were
>   increased 55% from 6.89 Mpps to 10.7 Mpps and 32% TX interrupts were
>   eliminated. Packed virtqueue PPS were increased 50% from 7.09 Mpps to
>   10.7 Mpps, 99% TX interrupts were eliminated.
> 
> - When pinning TX IRQ to VCPU other than pktgen: split virtqueue PPS
>   were increased 96% from 5.29 Mpps to 10.4 Mpps and 45% TX interrupts
>   were eliminated; Packed virtqueue PPS were increased 78% from 6.12
>   Mpps to 10.9 Mpps and 99% TX interrupts were eliminated.
> 
> 2) single queue 1 vcpu guest + vhost-net/TAP on the host: single
>    session netperf from guest to host shows 82% improvement from
>    31Gb/s to 58Gb/s, %stddev were reduced from 34.5% to 1.9% and 88%
>    of TX interrupts were eliminated.
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>


okay

Acked-by: Michael S. Tsirkin <mst@redhat.com>

but tell me something, would it be even better to schedule
napi once, and have that deal with enabling notifications?

> ---
>  drivers/net/virtio_net.c | 45 ++++++++++++++++++++++++++++------------
>  1 file changed, 32 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 7646ddd9bef7..ac26a6201c44 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -1088,11 +1088,10 @@ static bool is_xdp_raw_buffer_queue(struct virtnet_info *vi, int q)
>  		return false;
>  }
>  
> -static void check_sq_full_and_disable(struct virtnet_info *vi,
> -				      struct net_device *dev,
> -				      struct send_queue *sq)
> +static bool tx_may_stop(struct virtnet_info *vi,
> +			struct net_device *dev,
> +			struct send_queue *sq)
>  {
> -	bool use_napi = sq->napi.weight;
>  	int qnum;
>  
>  	qnum = sq - vi->sq;
> @@ -1114,6 +1113,25 @@ static void check_sq_full_and_disable(struct virtnet_info *vi,
>  		u64_stats_update_begin(&sq->stats.syncp);
>  		u64_stats_inc(&sq->stats.stop);
>  		u64_stats_update_end(&sq->stats.syncp);
> +
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
> +static void check_sq_full_and_disable(struct virtnet_info *vi,
> +				      struct net_device *dev,
> +				      struct send_queue *sq)
> +{
> +	bool use_napi = sq->napi.weight;
> +	int qnum;
> +
> +	qnum = sq - vi->sq;
> +
> +	if (tx_may_stop(vi, dev, sq)) {
> +		struct netdev_queue *txq = netdev_get_tx_queue(dev, qnum);
> +
>  		if (use_napi) {
>  			if (unlikely(!virtqueue_enable_cb_delayed(sq->vq)))
>  				virtqueue_napi_schedule(&sq->napi, sq->vq);
> @@ -3253,15 +3271,10 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
>  	bool use_napi = sq->napi.weight;
>  	bool kick;
>  
> -	/* Free up any pending old buffers before queueing new ones. */
> -	do {
> -		if (use_napi)
> -			virtqueue_disable_cb(sq->vq);
> -
> +	if (!use_napi)
>  		free_old_xmit(sq, txq, false);
> -
> -	} while (use_napi && !xmit_more &&
> -	       unlikely(!virtqueue_enable_cb_delayed(sq->vq)));
> +	else
> +		virtqueue_disable_cb(sq->vq);
>  
>  	/* timestamp packet in software */
>  	skb_tx_timestamp(skb);
> @@ -3287,7 +3300,10 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
>  		nf_reset_ct(skb);
>  	}
>  
> -	check_sq_full_and_disable(vi, dev, sq);
> +	if (use_napi)
> +		tx_may_stop(vi, dev, sq);
> +	else
> +		check_sq_full_and_disable(vi, dev,sq);
>  
>  	kick = use_napi ? __netdev_tx_sent_queue(txq, skb->len, xmit_more) :
>  			  !xmit_more || netif_xmit_stopped(txq);
> @@ -3299,6 +3315,9 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
>  		}
>  	}
>  
> +	if (use_napi && kick && unlikely(!virtqueue_enable_cb_delayed(sq->vq)))
> +		virtqueue_napi_schedule(&sq->napi, sq->vq);
> +
>  	return NETDEV_TX_OK;
>  }
>  
> -- 
> 2.34.1


