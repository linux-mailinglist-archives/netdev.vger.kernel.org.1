Return-Path: <netdev+bounces-116068-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13DA0948F00
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 14:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 947EA28F322
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 12:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4EAA1C232A;
	Tue,  6 Aug 2024 12:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D1Jx+n+W"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1461BD015
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 12:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722947109; cv=none; b=jf3dbOUgsLRcsSSWAbvvlKlW5Blx30fNuMhJ/b2pOHxKxm1P3EC2Rvp0fWoPCmnBheK2UdYfY7sfbt5NtZIz2bA20lX0nc9TfMGBz2ukWbAsvGpnz8/XMSXwr9SRnxl3g3Ju+I3gdVni2gzV0gZPxc1aQxXfyNnfD6ee7CskwE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722947109; c=relaxed/simple;
	bh=Zu5nxB10vxcRfClXXeGH1h4cUWEuoT+5MdHAObYksrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rU9Wut/06gVOj35bvETvK3Hcxf+9iNIm2zmc2fLP95hH5NDDrYNMU6FzBAJbnuBcFVCgtxMq2f6TDC00DunzTOUfSWGrAf/HwRUEq7bv/pipEOrNxAbd9KLdR2yzPVpXhIsXYv/+rxqQbs9nd4IRlGqCVYxsiq1T00eCEnJN4gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D1Jx+n+W; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722947106;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PactkZyJX0Ag5OakZPEWVf1Vde5VXyxtGsMlaDiA2ks=;
	b=D1Jx+n+WLgy/rmeHRaN1b9yxx7t881oFAd5qiTFcCVd7ayTFQ/PEeycYgEr9p7ews+JNnj
	50dk3+df1/ZBXYvKg4jjz6vmO+1WV79S77ALG8JA0SSf+XhZVfGGUNXSyHORRog/6rMqKl
	xDdD28T6U0SaqKuGudSy+wcgPVxKEto=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-358-cJ_PPKrwOqefzjhlvnuI_w-1; Tue, 06 Aug 2024 08:25:05 -0400
X-MC-Unique: cJ_PPKrwOqefzjhlvnuI_w-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-427ffa0c9c7so6854425e9.1
        for <netdev@vger.kernel.org>; Tue, 06 Aug 2024 05:25:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722947104; x=1723551904;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PactkZyJX0Ag5OakZPEWVf1Vde5VXyxtGsMlaDiA2ks=;
        b=a9/sTVXnxwp+FkNAvVRHHIZusbk96aZQVZCJOg7Lc0NBdY5amhYjDYqmrB9pZP/PtF
         ukXj4oQ26G6kyla7v3u5Pu6HgUPYEscHTT/eP/OmJbFaEixzwX9Mu3DjS0JP/VA4Xx1a
         ZkSDSphIDTj40BhZ1XEgWCywRdZxUEb14xCqQiEdTHqf1mZSNlW+/mmOXY2s4g0gxu++
         F5Il9yJ+pQeC1jCKmaovQ8X1Fo39wWcEdKEBt3RBo9JIRO0hvuDKSSnPrYXAvY1TiT3R
         +Rsho1wXNzVpUhpyhslBCHbRWUm0qtl94mMVluHz1UMD9OTILVkhDNdizCOTPQOABOMq
         nEqA==
X-Forwarded-Encrypted: i=1; AJvYcCUzDYzasBZ7bGXmtZdfXkv9qaeJWKBxE59rG31PHKgF72EOWLqlrJ3E24e+6LZNnKibo/s1AL/IRIm37UmLdk/M62MxEHyf
X-Gm-Message-State: AOJu0YzUiGTtHqyrRUGsPex8tXp2MYVQbGhGXuvBuqQrt1dzgfzTsNDF
	lxHnXq/LWQrjk61xz421PqH4sq3vPr3aV1rQFx9augg96SYFPSDHdjPCTl5j70WHhGud8Ur3NdF
	q03mGrs/NLVKA6XmS5L4cw/XuE7e9KYbIQu/ryuh+TfXIsl0awIodhg==
X-Received: by 2002:a05:600c:3b16:b0:426:6822:5aa8 with SMTP id 5b1f17b1804b1-428e6b2a6ffmr145329775e9.18.1722947103947;
        Tue, 06 Aug 2024 05:25:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzVU9aAZD5lCQaBSPg04gI2QuPw/TNVwvVCA7OZglja6VMFhHphFFZfNM7ojHYJSFxf3gR6Q==
X-Received: by 2002:a05:600c:3b16:b0:426:6822:5aa8 with SMTP id 5b1f17b1804b1-428e6b2a6ffmr145329395e9.18.1722947103082;
        Tue, 06 Aug 2024 05:25:03 -0700 (PDT)
Received: from redhat.com ([2a02:14f:175:c9eb:d9d4:606a:87dc:59c7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282b89aa4bsm241485275e9.7.2024.08.06.05.25.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 05:25:02 -0700 (PDT)
Date: Tue, 6 Aug 2024 08:24:57 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	inux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next V6 4/4] virtio-net: synchronize probe with
 ndo_set_features
Message-ID: <20240806082436-mutt-send-email-mst@kernel.org>
References: <20240806022224.71779-1-jasowang@redhat.com>
 <20240806022224.71779-5-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806022224.71779-5-jasowang@redhat.com>

On Tue, Aug 06, 2024 at 10:22:24AM +0800, Jason Wang wrote:
> We calculate guest offloads during probe without the protection of
> rtnl_lock. This lead to race between probe and ndo_set_features. Fix
> this by moving the calculation under the rtnl_lock.
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Fixes tag pls?

> ---
>  drivers/net/virtio_net.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index fc5196ca8d51..1d86aa07c871 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -6596,6 +6596,11 @@ static int virtnet_probe(struct virtio_device *vdev)
>  		netif_carrier_on(dev);
>  	}
>  
> +	for (i = 0; i < ARRAY_SIZE(guest_offloads); i++)
> +		if (virtio_has_feature(vi->vdev, guest_offloads[i]))
> +			set_bit(guest_offloads[i], &vi->guest_offloads);
> +	vi->guest_offloads_capable = vi->guest_offloads;
> +
>  	rtnl_unlock();
>  
>  	err = virtnet_cpu_notif_add(vi);
> @@ -6604,11 +6609,6 @@ static int virtnet_probe(struct virtio_device *vdev)
>  		goto free_unregister_netdev;
>  	}
>  
> -	for (i = 0; i < ARRAY_SIZE(guest_offloads); i++)
> -		if (virtio_has_feature(vi->vdev, guest_offloads[i]))
> -			set_bit(guest_offloads[i], &vi->guest_offloads);
> -	vi->guest_offloads_capable = vi->guest_offloads;
> -
>  	pr_debug("virtnet: registered device %s with %d RX and TX vq's\n",
>  		 dev->name, max_queue_pairs);
>  
> -- 
> 2.31.1


