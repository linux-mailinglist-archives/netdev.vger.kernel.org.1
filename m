Return-Path: <netdev+bounces-96649-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02AB08C6DE0
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 23:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADBEE2839F8
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 21:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3325D15B159;
	Wed, 15 May 2024 21:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QetS5iUz"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE361591EC
	for <netdev@vger.kernel.org>; Wed, 15 May 2024 21:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715809387; cv=none; b=mp/iOa1znNAD8rXUp6ItNkZ2PG0u9KQ36u4W6386ED5/FfGX8iuosPT9L+U/jQW2uTkTj2xFh8vn9CVf1hW+10a9WQdxmNv9irXkTpo9zUC5tGTFHAmwlCx4/NUlSiMaSLQa8YcQ16cun4A424n4qOYYBqDqAcWQN8yAxC4oxBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715809387; c=relaxed/simple;
	bh=PtK14fY1rMzkVkKJc7euI+0gYz8tpqvd3VtkvA0K1vQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LBkFClaydEn/f9nR1VxOKpUdn7t7ZnpN+aLA4xnuL6TBfzjYjEBtvq7s5klSkzeuGA2JVOUh/CnYWPy34eF05PvWUkGOKs8T0YRbHui4c+jfS2zl3XBFab/d7TBfUPvnEO66iD/bfLH/2hfo3JEG9YsRRlbOWnITmioSExVvQ6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QetS5iUz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715809384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CfsV4L3uCM0qt/IKuOVeCHgH84Q1PpVaktQ22pA6gPE=;
	b=QetS5iUzhnL/nTyHOxKnUxtPN0cm2w6eXyAgL3bJYJPU2ZHuqlDx0JC/TsML2JolupzUI1
	b3QRjBbsIOLD+z4xktSVS0k8uPws0DZbdB2N5OHWxu28+1LLV+ABbMVXd9Zqa8rHxfCWl/
	Jw9qWxY7t2oNZ2GsWjjmvaw/mYEnXC0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-19-7Cou_d37Pia7UZJW9uwm4w-1; Wed, 15 May 2024 17:42:58 -0400
X-MC-Unique: 7Cou_d37Pia7UZJW9uwm4w-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-351bf7f7f73so2045969f8f.0
        for <netdev@vger.kernel.org>; Wed, 15 May 2024 14:42:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715809377; x=1716414177;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CfsV4L3uCM0qt/IKuOVeCHgH84Q1PpVaktQ22pA6gPE=;
        b=skk8w0z4cJ5Nkz0eYWikmKmGCQcJPqRaafz6Helx3qpMGTA27Hk7VIIegoMljNnPSV
         XCaFJy7M0Vv+5G3TyDqYcMITUZ3SQR9AAHwjONs9OFCjjSt+WqtXRoOARhA1JwRiaKyH
         KeCaoREwXVYbOGQqAlyz3lNBDctWQJGtmQIlgz4zlOEdLduNO7au7CAMkzEs2Ut83KxY
         IgMgqgyM0Vns3P0xen7Ai7obnmvw+n/eIYXTvzkgm2nM/TiJVRMmFOzOXFiFmDnQmCML
         iyJLazQI0vHKc5AVoAv/aaZV3gz88CHH8Y0QXK3mLM8XbCDiGDynzlyzctWjstERWLek
         J7DA==
X-Gm-Message-State: AOJu0Yzp7XDqUamIw+jE7ABvQRmqh4Bowmduqg/CZIoK68HzNoNAPc+V
	o6e3DHbDO6CjScz1GAZEj1HXdWJgwzznZarMGMrZTSwRpEcsWMPOhkLtZIdfC8Acd57BVSBgJaw
	vtBRye8uEISvLqnKyNTb4nL5Q1LBMqBb1Om93vyylQiH+8tL7Zf+pnw==
X-Received: by 2002:adf:e492:0:b0:34d:8d55:739a with SMTP id ffacd0b85a97d-3504a96ab52mr15997874f8f.57.1715809376768;
        Wed, 15 May 2024 14:42:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5vExwjG+ezOplBIzZSZDAIp3ZaPruBka2DhO/g/D3QX0xD25ZA2BfM/H4xr1SPHjrXyhbZQ==
X-Received: by 2002:adf:e492:0:b0:34d:8d55:739a with SMTP id ffacd0b85a97d-3504a96ab52mr15997855f8f.57.1715809376098;
        Wed, 15 May 2024 14:42:56 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:443:357d:1f98:7ef8:1117:f7bb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b896ab0sm17499202f8f.41.2024.05.15.14.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 May 2024 14:42:55 -0700 (PDT)
Date: Wed, 15 May 2024 17:42:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	virtualization@lists.linux.dev, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	jiri@nvidia.com, Eric Dumazet <edumaset@google.com>
Subject: Re: [PATCH v3] virtio_net: Fix missed rtnl_unlock
Message-ID: <20240515174242-mutt-send-email-mst@kernel.org>
References: <20240515163125.569743-1-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240515163125.569743-1-danielj@nvidia.com>

On Wed, May 15, 2024 at 11:31:25AM -0500, Daniel Jurgens wrote:
> The rtnl_lock would stay locked if allocating promisc_allmulti failed.
> Also changed the allocation to GFP_KERNEL.
> 
> Fixes: ff7c7d9f5261 ("virtio_net: Remove command data from control_buf")
> Reported-by: Eric Dumazet <edumaset@google.com>
> Link: https://lore.kernel.org/netdev/CANn89iLazVaUCvhPm6RPJJ0owra_oFnx7Fhc8d60gV-65ad3WQ@mail.gmail.com/
> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>


Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
> v3:
> 	- Changed to promisc_allmulti alloc to GPF_KERNEL
> v2:
> 	- Added fixes tag.
> ---
>  drivers/net/virtio_net.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 19a9b50646c7..4e1a0fc0d555 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2902,14 +2902,14 @@ static void virtnet_rx_mode_work(struct work_struct *work)
>  	if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_CTRL_RX))
>  		return;
>  
> -	rtnl_lock();
> -
> -	promisc_allmulti = kzalloc(sizeof(*promisc_allmulti), GFP_ATOMIC);
> +	promisc_allmulti = kzalloc(sizeof(*promisc_allmulti), GFP_KERNEL);
>  	if (!promisc_allmulti) {
>  		dev_warn(&dev->dev, "Failed to set RX mode, no memory.\n");
>  		return;
>  	}
>  
> +	rtnl_lock();
> +
>  	*promisc_allmulti = !!(dev->flags & IFF_PROMISC);
>  	sg_init_one(sg, promisc_allmulti, sizeof(*promisc_allmulti));
>  
> -- 
> 2.45.0


