Return-Path: <netdev+bounces-128838-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F6F97BE47
	for <lists+netdev@lfdr.de>; Wed, 18 Sep 2024 16:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FDD81C2108C
	for <lists+netdev@lfdr.de>; Wed, 18 Sep 2024 14:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79A5D1C3F13;
	Wed, 18 Sep 2024 14:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G2ULJver"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07CF1C5791
	for <netdev@vger.kernel.org>; Wed, 18 Sep 2024 14:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726671514; cv=none; b=iAtMdzFWkOZkMvXeWURGP0xM5goAICDmhgiVTeHtvuqlVQ8clohYdRPHmIJm16unzUfgztUnWcpfiUfOSjvke3jnPhvNLs6EwDz8T9Si+F47wnYn0ygLygu6s6sJ8uOq7v1kDOwwiAUhbWYnJdaVAXtpPz+3gIR7VLApZZOlVAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726671514; c=relaxed/simple;
	bh=QM+WRIrqOf/VG+tDwYImunOT5LIH7QRSSR3sO1/hKqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mqS0MQd9eq9vrE/LgxTKDnaRqaGJC3cW3nT6DDwz6iHnRMD9eVvHZu9As7Gt/7qPX6KNBtYntfYgCwaqpfSgqpcRlPML3pHBzTslHURhoFqpzqdbcsB10Nocjx0Tdrzyb2fC4a0+LcwpJFo/Rb57+Mty/UJ6YWMXjRtKFznuXDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=G2ULJver; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726671511;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MAwqY9vnRPc9YnB7fd6OqxXe5O2u5mpoyMN36Na6yP8=;
	b=G2ULJver9frtc59JaKphGZAQq8y+BVsYSKbE38K3AeYiMPZRzkAGr6Vtx/RaMKxh1+NLJi
	Ti4juDOqBztkDeNoVC1d7JXiMtGUFWttOf6XvHSYlE/l85QeoUyD/ZhYR43T1XI8tKxRww
	isl6MVO9WxYzJhRp7GcjEtoZEDwqQM0=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-402-uNELa10eP8S3MsfjwIkqeg-1; Wed, 18 Sep 2024 10:58:30 -0400
X-MC-Unique: uNELa10eP8S3MsfjwIkqeg-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5c24c92db25so1192370a12.0
        for <netdev@vger.kernel.org>; Wed, 18 Sep 2024 07:58:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726671509; x=1727276309;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MAwqY9vnRPc9YnB7fd6OqxXe5O2u5mpoyMN36Na6yP8=;
        b=ZL5ueVcO2CWmZQzmdWfD5XKi4H/Q2JZ63QFznaRibLK0smw7YrQlO7TwXcGDePCmiS
         g1XnIH5F0YOJ8GfBNQZxYMRYT6VCxT6rynhRPqJmON9lpp5OFwHU31X/NrNJR0ZDEy0X
         yVB90SfXqotDLIU/S4mwssCUqod5wm3hrZ3gvBM6g4YMRQEj4f4MkgNWXUQWMuwDvJQg
         fkRs32HFO4VJ7mEhBqEZnmX0KEUwSq6SbpZ1dEzOW33pR+N45B/GYSLhWZlmEIexLwUG
         bGDWLFTcv5rFTd7de2a1S9B9pSuEReqoud4MOK9W3/1b843yNd9xOcyS/9b+KzRcHM0m
         Z9fw==
X-Forwarded-Encrypted: i=1; AJvYcCW7voU0/j+uT3anIdpBvURliPN0aEIWj8zxQeaZPwhWbopmi/+oZK6ohB6IDZAb9UlJZv+iqo0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJTO1Vew1stCdrAHX4gxVo4avXP4E3yGZocsKhBHIBiMllUPpg
	LrJjNRROHePTvmCYrD6prgkxHGjzhb+YvLEFA1rb+8i8gVExqWqzVCeK+jy+nRMTHa+zVnj0/Wi
	6MomRHC/Apr/kFftiBNnRZCUAAETVyHUYUS7SfZL/WoMreGC6vmt2KA==
X-Received: by 2002:a05:6402:5c8:b0:5c2:5254:cdc4 with SMTP id 4fb4d7f45d1cf-5c4143874bdmr25722273a12.17.1726671509310;
        Wed, 18 Sep 2024 07:58:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzH5nuqNle+ILuHyENqVhBvmZFotgEz0rqz8hkG1mCshcHdFnBkW5waH+k3AXJut3JW5zwew==
X-Received: by 2002:a05:6402:5c8:b0:5c2:5254:cdc4 with SMTP id 4fb4d7f45d1cf-5c4143874bdmr25722237a12.17.1726671508527;
        Wed, 18 Sep 2024 07:58:28 -0700 (PDT)
Received: from redhat.com ([83.68.141.146])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c42bb5e83asm5178794a12.40.2024.09.18.07.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Sep 2024 07:58:26 -0700 (PDT)
Date: Wed, 18 Sep 2024 10:58:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Wenbo Li <liwenbo.martin@bytedance.com>
Cc: jasowang@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jiahui Cen <cenjiahui@bytedance.com>,
	Ying Fang <fangying.tommy@bytedance.com>
Subject: Re: [PATCH v3] virtio_net: Fix mismatched buf address when unmapping
 for small packets
Message-ID: <20240918105803-mutt-send-email-mst@kernel.org>
References: <20240918132005.31174-1-liwenbo.martin@bytedance.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240918132005.31174-1-liwenbo.martin@bytedance.com>

On Wed, Sep 18, 2024 at 09:20:05PM +0800, Wenbo Li wrote:
> Currently, the virtio-net driver will perform a pre-dma-mapping for
> small or mergeable RX buffer. But for small packets, a mismatched address
> without VIRTNET_RX_PAD and xdp_headroom is used for unmapping.
> 
> That will result in unsynchronized buffers when SWIOTLB is enabled, for
> example, when running as a TDX guest.
> 
> This patch unifies the address passed to the virtio core into the address of
> the virtnet header and fixes the mismatched buffer address.
> 
> Changes from v2: unify the buf that passed to the virtio core in small
> and merge mode.
> Changes from v1: Use ctx to get xdp_headroom.
> 
> Fixes: 295525e29a5b ("virtio_net: merge dma operations when filling mergeable buffers")
> Signed-off-by: Wenbo Li <liwenbo.martin@bytedance.com>
> Signed-off-by: Jiahui Cen <cenjiahui@bytedance.com>
> Signed-off-by: Ying Fang <fangying.tommy@bytedance.com>

OK but can you please adhere to the kernel coding style?



> ---
>  drivers/net/virtio_net.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 6f4781ec2b36..9446666c84aa 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -1804,9 +1804,15 @@ static struct sk_buff *receive_small(struct net_device *dev,
>  				     struct virtnet_rq_stats *stats)
>  {
>  	unsigned int xdp_headroom = (unsigned long)ctx;
> -	struct page *page = virt_to_head_page(buf);
> +	struct page *page;
>  	struct sk_buff *skb;
>  
> +	// We passed the address of virtnet header to virtio-core,
> +	// so truncate the padding.
> +	buf -= VIRTNET_RX_PAD + xdp_headroom;
> +
> +	page = virt_to_head_page(buf);
> +
>  	len -= vi->hdr_len;
>  	u64_stats_add(&stats->bytes, len);
>  
> @@ -2422,8 +2428,9 @@ static int add_recvbuf_small(struct virtnet_info *vi, struct receive_queue *rq,
>  	if (unlikely(!buf))
>  		return -ENOMEM;
>  
> -	virtnet_rq_init_one_sg(rq, buf + VIRTNET_RX_PAD + xdp_headroom,
> -			       vi->hdr_len + GOOD_PACKET_LEN);
> +	buf += VIRTNET_RX_PAD + xdp_headroom;
> +
> +	virtnet_rq_init_one_sg(rq, buf, vi->hdr_len + GOOD_PACKET_LEN);
>  
>  	err = virtqueue_add_inbuf_ctx(rq->vq, rq->sg, 1, buf, ctx, gfp);
>  	if (err < 0) {
> -- 
> 2.20.1


