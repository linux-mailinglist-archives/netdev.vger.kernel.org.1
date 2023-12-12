Return-Path: <netdev+bounces-56282-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 569D780E61E
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 09:27:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93BDC281EB6
	for <lists+netdev@lfdr.de>; Tue, 12 Dec 2023 08:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD261946A;
	Tue, 12 Dec 2023 08:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ThU/tDAO"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10A0C1FFB
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 00:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702369608;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6tm5mmK3S0vE6Paxy7kwolqH56nl0BG1LhiyuWhMjTo=;
	b=ThU/tDAONFVM58BTzEmxdlyApZ842EspS78JGbcuhiVZn8JojskSO41G0ajCi6JWIFP4d4
	7SQ03TX4DJucbKmdHiOzXchjuY29vu08RXTmNvt8hRdYERj2Erjrllta0lqvSAuiC7nRJW
	Vw2WPwljgslXoCkNpttIh9uJk8ZYfp8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-496-d-M-CaL9MPioBnSqogDU5w-1; Tue, 12 Dec 2023 03:26:46 -0500
X-MC-Unique: d-M-CaL9MPioBnSqogDU5w-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3333c3b6519so4162040f8f.2
        for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 00:26:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702369605; x=1702974405;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6tm5mmK3S0vE6Paxy7kwolqH56nl0BG1LhiyuWhMjTo=;
        b=H6INVMhakBbCQtZjpGMBhe6c5+z8u3lEPl+b2Egdy1wCKpQm4+DzS19iOhCpYIqO7k
         VLF7JJjFFpEAToLFuF7w7iuEyBu0NFiEVM1bRfS9rMfI0o6ardztddvBKVNm2BTkSRpj
         OIBH65eBhouh7FslsBFPZ8/G/A1KV0cDU1wX/jNv6j23W9UdOFPYWJno1jH6uCmCy1/O
         6klYyM5UiHzefLk1dkf4G9FYs0uU0pSCQ24+S0utNQFRzd7yxO3YZCGDwsNktbGGO6Om
         96zF8tIopiNgf48rqxHNLCyN1y6n9c+ITf2ZWKvX7XRotCIe/InS92URAyrRgo87cIxB
         TasQ==
X-Gm-Message-State: AOJu0YwIM2gWnPxZgNycKpPvWSjU38BJSEDdToV9RyODBIH2nXp8k96F
	4mAez07RvyrwO2NA18Z+sasaAO3ArkdG4gKFalWz2foB6a1rXc+pyn8i9hz1CFEGxpHQ3ENd3qE
	HT0OxVNGJNmUiVPLq
X-Received: by 2002:a1c:4b0b:0:b0:40c:2a42:d7e2 with SMTP id y11-20020a1c4b0b000000b0040c2a42d7e2mr2607336wma.173.1702369605689;
        Tue, 12 Dec 2023 00:26:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGcANJsScFrxAeVP4i+9Zpa+xmw/zm+qfDt7Dwyn+hkDwo2wDP7z//KuFktxfIYRRwakEFZPg==
X-Received: by 2002:a1c:4b0b:0:b0:40c:2a42:d7e2 with SMTP id y11-20020a1c4b0b000000b0040c2a42d7e2mr2607329wma.173.1702369605283;
        Tue, 12 Dec 2023 00:26:45 -0800 (PST)
Received: from redhat.com ([2.52.23.105])
        by smtp.gmail.com with ESMTPSA id s13-20020a05600c384d00b004030e8ff964sm17994439wmr.34.2023.12.12.00.26.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 00:26:44 -0800 (PST)
Date: Tue, 12 Dec 2023 03:26:41 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v1] virtio_net: fix missing dma unmap for resize
Message-ID: <20231212032514-mutt-send-email-mst@kernel.org>
References: <20231212081141.39757-1-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212081141.39757-1-xuanzhuo@linux.alibaba.com>

On Tue, Dec 12, 2023 at 04:11:41PM +0800, Xuan Zhuo wrote:
> For rq, we have three cases getting buffers from virtio core:
> 
> 1. virtqueue_get_buf{,_ctx}
> 2. virtqueue_detach_unused_buf
> 3. callback for virtqueue_resize
> 
> But in commit 295525e29a5b("virtio_net: merge dma operations when
> filling mergeable buffers"), I missed the dma unmap for the #3 case.
> 
> That will leak some memory, because I did not release the pages referred
> by the unused buffers.
> 
> If we do such script, we will make the system OOM.
> 
>     while true
>     do
>             ethtool -G ens4 rx 128
>             ethtool -G ens4 rx 256
>             free -m
>     done
> 
> Fixes: 295525e29a5b ("virtio_net: merge dma operations when filling mergeable buffers")
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
> 
> v1: rename to virtnet_rq_free_buf_check_dma()

The fact that we check does not matter what matters is
that we unmap. I'd change the name to reflect that.


> 
>  drivers/net/virtio_net.c | 60 ++++++++++++++++++++--------------------
>  1 file changed, 30 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index d16f592c2061..58ebbffeb952 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -334,7 +334,6 @@ struct virtio_net_common_hdr {
>  	};
>  };
> 
> -static void virtnet_rq_free_unused_buf(struct virtqueue *vq, void *buf);
>  static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf);
> 
>  static bool is_xdp_frame(void *ptr)
> @@ -408,6 +407,17 @@ static struct page *get_a_page(struct receive_queue *rq, gfp_t gfp_mask)
>  	return p;
>  }
> 
> +static void virtnet_rq_free_buf(struct virtnet_info *vi,
> +				struct receive_queue *rq, void *buf)
> +{
> +	if (vi->mergeable_rx_bufs)
> +		put_page(virt_to_head_page(buf));
> +	else if (vi->big_packets)
> +		give_pages(rq, buf);
> +	else
> +		put_page(virt_to_head_page(buf));
> +}
> +
>  static void enable_delayed_refill(struct virtnet_info *vi)
>  {
>  	spin_lock_bh(&vi->refill_lock);
> @@ -634,17 +644,6 @@ static void *virtnet_rq_get_buf(struct receive_queue *rq, u32 *len, void **ctx)
>  	return buf;
>  }
> 
> -static void *virtnet_rq_detach_unused_buf(struct receive_queue *rq)
> -{
> -	void *buf;
> -
> -	buf = virtqueue_detach_unused_buf(rq->vq);
> -	if (buf && rq->do_dma)
> -		virtnet_rq_unmap(rq, buf, 0);
> -
> -	return buf;
> -}
> -
>  static void virtnet_rq_init_one_sg(struct receive_queue *rq, void *buf, u32 len)
>  {
>  	struct virtnet_rq_dma *dma;
> @@ -744,6 +743,20 @@ static void virtnet_rq_set_premapped(struct virtnet_info *vi)
>  	}
>  }
> 
> +static void virtnet_rq_free_buf_check_dma(struct virtqueue *vq, void *buf)
> +{
> +	struct virtnet_info *vi = vq->vdev->priv;
> +	struct receive_queue *rq;
> +	int i = vq2rxq(vq);
> +
> +	rq = &vi->rq[i];
> +
> +	if (rq->do_dma)
> +		virtnet_rq_unmap(rq, buf, 0);
> +
> +	virtnet_rq_free_buf(vi, rq, buf);
> +}
> +
>  static void free_old_xmit_skbs(struct send_queue *sq, bool in_napi)
>  {
>  	unsigned int len;
> @@ -1764,7 +1777,7 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
>  	if (unlikely(len < vi->hdr_len + ETH_HLEN)) {
>  		pr_debug("%s: short packet %i\n", dev->name, len);
>  		DEV_STATS_INC(dev, rx_length_errors);
> -		virtnet_rq_free_unused_buf(rq->vq, buf);
> +		virtnet_rq_free_buf(vi, rq, buf);
>  		return;
>  	}
> 
> @@ -2392,7 +2405,7 @@ static int virtnet_rx_resize(struct virtnet_info *vi,
>  	if (running)
>  		napi_disable(&rq->napi);
> 
> -	err = virtqueue_resize(rq->vq, ring_num, virtnet_rq_free_unused_buf);
> +	err = virtqueue_resize(rq->vq, ring_num, virtnet_rq_free_buf_check_dma);
>  	if (err)
>  		netdev_err(vi->dev, "resize rx fail: rx queue index: %d err: %d\n", qindex, err);
> 
> @@ -4031,19 +4044,6 @@ static void virtnet_sq_free_unused_buf(struct virtqueue *vq, void *buf)
>  		xdp_return_frame(ptr_to_xdp(buf));
>  }
> 
> -static void virtnet_rq_free_unused_buf(struct virtqueue *vq, void *buf)
> -{
> -	struct virtnet_info *vi = vq->vdev->priv;
> -	int i = vq2rxq(vq);
> -
> -	if (vi->mergeable_rx_bufs)
> -		put_page(virt_to_head_page(buf));
> -	else if (vi->big_packets)
> -		give_pages(&vi->rq[i], buf);
> -	else
> -		put_page(virt_to_head_page(buf));
> -}
> -
>  static void free_unused_bufs(struct virtnet_info *vi)
>  {
>  	void *buf;
> @@ -4057,10 +4057,10 @@ static void free_unused_bufs(struct virtnet_info *vi)
>  	}
> 
>  	for (i = 0; i < vi->max_queue_pairs; i++) {
> -		struct receive_queue *rq = &vi->rq[i];
> +		struct virtqueue *vq = vi->rq[i].vq;
> 
> -		while ((buf = virtnet_rq_detach_unused_buf(rq)) != NULL)
> -			virtnet_rq_free_unused_buf(rq->vq, buf);
> +		while ((buf = virtqueue_detach_unused_buf(vq)) != NULL)
> +			virtnet_rq_free_buf_check_dma(vq, buf);
>  		cond_resched();
>  	}
>  }
> --
> 2.32.0.3.g01195cf9f


