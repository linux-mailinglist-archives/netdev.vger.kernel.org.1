Return-Path: <netdev+bounces-110265-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6154292BB02
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 15:27:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F8341C22243
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 13:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0CD815B57A;
	Tue,  9 Jul 2024 13:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cexhm8l0"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE71158A0D
	for <netdev@vger.kernel.org>; Tue,  9 Jul 2024 13:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720531651; cv=none; b=QlBRREEEdNBawkPsKTi0vV6Ttaoqnr3Q9uJIyxxR6sYWNeKTLzDpsST8f0mRaSN+dzPiQFpXxjGbT0PrutvVQNxRFBVpIM6itl9EkW9Ih+AL8+MqWCuKgX1edjLJjG+ih6b5B4WNpm+Mvm+FejGwN+PPoNqxkGpAQn9dxfz1HA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720531651; c=relaxed/simple;
	bh=PRTs7ENNNPkFFlE7BIaCY/EAUslJtTBxr+x41B6vuKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I/N2M+wAuNnWTuzcg8V4xA3vWw/1d0VujdDPC0O0KHAHzbrM48We2YNq0hgQ7lQq8j9ACqlI50mx+80/qjuV1Le3DNVJR52D5aaxutK2nVKtBNm11vavMClsSwfKIOedkdVUxL4+8UZ/qiTHZHMCF/y+7LahBR3KSAy2WSHv2Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cexhm8l0; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720531649;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gtVPK2ZkpErkolXPfykX1c4ToiqBJouweYxuDjYw52I=;
	b=Cexhm8l038+cOglaV8+ZJ2OjeaQhI8IOzgpDRdJAK7gtkTI0d6Z7xQj9euamnn2xYwnC3p
	AL4IkUGlSK0XcB9VKjHunLuoIfyHH7ZBnDWz1t90JX62YXKoZ6fTbWgZjhMYx51C0NLLse
	m8lCAcfUgFPZint/WMhnMnqupm+jVto=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-7g8b0NLFOh2Obf-UM4M2Bw-1; Tue, 09 Jul 2024 09:27:27 -0400
X-MC-Unique: 7g8b0NLFOh2Obf-UM4M2Bw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-42674318a4eso6442395e9.1
        for <netdev@vger.kernel.org>; Tue, 09 Jul 2024 06:27:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720531645; x=1721136445;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gtVPK2ZkpErkolXPfykX1c4ToiqBJouweYxuDjYw52I=;
        b=qSAmdWa9SWVX+Gc5YG4SVdYwy5iOTN1OZ1Npjs8yWUugJE7KdSizBbKE+tq9FlrR/m
         WdgfKrbKB9RR9eJjX3uU7GQxAHsdmgC4P+OIbFHNjTtxjpXz4xrufVSXUnoDcwPvfLtf
         sPSaKsisuGXfiGEN4yZ7hyFICXrs5aHQs+Y5vYLbbJfCpJmQdqpB3YLpHt1JcU5JzYhl
         Uu2hJYuVfQeK07/WUbARb3MV7tpR0dkMPCcKGXTnJ01mtXqm3pU57+3L+6JhKGGwm+PC
         TCp1LQWDzbEuQGpPvO2SGP8lAtrdYzYjab8cBSvCpvnRZ4lZFxPfS9WzhJQPtbmwWDDH
         BHKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVpEU+Tmaa5qreDsh9/vuHZCjnyjCHx3ybB0tytXgqoKtYoL4OryTKidRoo5SYGfSYO8ls+L6ZXi/SV1zQi4/cvF4G9LRI7
X-Gm-Message-State: AOJu0Yxu0sxFtGRdA/4jrkRpEvvfqcqnmNVP9jkl5tEYFHvWGNq76iNs
	cRj0yHcycwUQHG47cf0v0cz5yTkIZ8MnbvQnhSluvot/LCaBDqYiO0Z7fjEwfXPZLcN4+282vDE
	OOukUaz2A/g8JZP5UsfctzdYn3oTOD/KDfSjrLOFsZbdMTJITb3GGJA==
X-Received: by 2002:a05:600c:4aa9:b0:426:5b44:2be7 with SMTP id 5b1f17b1804b1-426707cea49mr23970635e9.10.1720531645011;
        Tue, 09 Jul 2024 06:27:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtCh7cTPgB26yWMyLQJhXp4cXICRWd/EuMsW0N0P3ozyXfXO/Wb4u4clbYFjvvspzLgUGLnQ==
X-Received: by 2002:a05:600c:4aa9:b0:426:5b44:2be7 with SMTP id 5b1f17b1804b1-426707cea49mr23970305e9.10.1720531644464;
        Tue, 09 Jul 2024 06:27:24 -0700 (PDT)
Received: from redhat.com ([2a02:14f:174:f6ae:a6e3:8cbc:2cbd:b8ff])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4264a2fca8bsm208275575e9.47.2024.07.09.06.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 06:27:23 -0700 (PDT)
Date: Tue, 9 Jul 2024 09:27:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	Venkat Venkatsubra <venkat.x.venkatsubra@oracle.com>,
	Gia-Khanh Nguyen <gia-khanh.nguyen@oracle.com>
Subject: Re: [PATCH net-next v3 3/3] virtio-net: synchronize operstate with
 admin state on up/down
Message-ID: <20240709090743-mutt-send-email-mst@kernel.org>
References: <20240709080214.9790-1-jasowang@redhat.com>
 <20240709080214.9790-4-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240709080214.9790-4-jasowang@redhat.com>

On Tue, Jul 09, 2024 at 04:02:14PM +0800, Jason Wang wrote:
> This patch synchronize operstate with admin state per RFC2863.
> 
> This is done by trying to toggle the carrier upon open/close and
> synchronize with the config change work. This allows propagate status
> correctly to stacked devices like:
> 
> ip link add link enp0s3 macvlan0 type macvlan
> ip link set link enp0s3 down
> ip link show
> 
> Before this patch:
> 
> 3: enp0s3: <BROADCAST,MULTICAST> mtu 1500 qdisc pfifo_fast state DOWN mode DEFAULT group default qlen 1000
>     link/ether 00:00:05:00:00:09 brd ff:ff:ff:ff:ff:ff
> ......
> 5: macvlan0@enp0s3: <BROADCAST,MULTICAST,UP,LOWER_UP,M-DOWN> mtu 1500 qdisc noqueue state UP mode DEFAULT group default qlen 1000
>     link/ether b2:a9:c5:04:da:53 brd ff:ff:ff:ff:ff:ff
> 
> After this patch:
> 
> 3: enp0s3: <BROADCAST,MULTICAST> mtu 1500 qdisc pfifo_fast state DOWN mode DEFAULT group default qlen 1000
>     link/ether 00:00:05:00:00:09 brd ff:ff:ff:ff:ff:ff
> ...
> 5: macvlan0@enp0s3: <NO-CARRIER,BROADCAST,MULTICAST,UP,M-DOWN> mtu 1500 qdisc noqueue state LOWERLAYERDOWN mode DEFAULT group default qlen 1000
>     link/ether b2:a9:c5:04:da:53 brd ff:ff:ff:ff:ff:ff

I think that the commit log is confusing. It seems to say that
the issue fixed is synchronizing state with hardware
config change. But your example does not show any
hardware change. Isn't this example really just
a side effect of setting carrier off on close?


> Cc: Venkat Venkatsubra <venkat.x.venkatsubra@oracle.com>
> Cc: Gia-Khanh Nguyen <gia-khanh.nguyen@oracle.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Yes but this just forces lots of re-reads of config on each
open/close for no good reason.
Config interrupt is handled in core, you can read once
on probe and then handle config changes.





> ---
>  drivers/net/virtio_net.c | 64 ++++++++++++++++++++++++----------------
>  1 file changed, 38 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 0b4747e81464..e6626ba25b29 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2476,6 +2476,25 @@ static void virtnet_cancel_dim(struct virtnet_info *vi, struct dim *dim)
>  	net_dim_work_cancel(dim);
>  }
>  
> +static void virtnet_update_settings(struct virtnet_info *vi)
> +{
> +	u32 speed;
> +	u8 duplex;
> +
> +	if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_SPEED_DUPLEX))
> +		return;
> +
> +	virtio_cread_le(vi->vdev, struct virtio_net_config, speed, &speed);
> +
> +	if (ethtool_validate_speed(speed))
> +		vi->speed = speed;
> +
> +	virtio_cread_le(vi->vdev, struct virtio_net_config, duplex, &duplex);
> +
> +	if (ethtool_validate_duplex(duplex))
> +		vi->duplex = duplex;
> +}
> +
>  static int virtnet_open(struct net_device *dev)
>  {
>  	struct virtnet_info *vi = netdev_priv(dev);
> @@ -2494,6 +2513,18 @@ static int virtnet_open(struct net_device *dev)
>  			goto err_enable_qp;
>  	}
>  
> +	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
> +		virtio_config_driver_enable(vi->vdev);
> +		/* Do not schedule the config change work as the
> +		 * config change notification might have been disabled
> +		 * by the virtio core. */

I don't get why you need this.
If the notification was disabled it will just trigger later.
This is exactly why using core is a good idea.


> +		virtio_config_changed(vi->vdev);
> +	} else {
> +		vi->status = VIRTIO_NET_S_LINK_UP;
> +		virtnet_update_settings(vi);


And why do we need this here I don't get at all.

> +		netif_carrier_on(dev);
> +	}



> +
>  	return 0;
>  
>  err_enable_qp:
> @@ -2936,12 +2967,19 @@ static int virtnet_close(struct net_device *dev)
>  	disable_delayed_refill(vi);
>  	/* Make sure refill_work doesn't re-enable napi! */
>  	cancel_delayed_work_sync(&vi->refill);
> +	/* Make sure config notification doesn't schedule config work */
> +	virtio_config_driver_disable(vi->vdev);
> +	/* Make sure status updating is cancelled */
> +	cancel_work_sync(&vi->config_work);
>  
>  	for (i = 0; i < vi->max_queue_pairs; i++) {
>  		virtnet_disable_queue_pair(vi, i);
>  		virtnet_cancel_dim(vi, &vi->rq[i].dim);
>  	}
>  
> +	vi->status &= ~VIRTIO_NET_S_LINK_UP;
> +	netif_carrier_off(dev);
> +
>  	return 0;
>  }
>  
> @@ -4640,25 +4678,6 @@ static void virtnet_init_settings(struct net_device *dev)
>  	vi->duplex = DUPLEX_UNKNOWN;
>  }
>  
> -static void virtnet_update_settings(struct virtnet_info *vi)
> -{
> -	u32 speed;
> -	u8 duplex;
> -
> -	if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_SPEED_DUPLEX))
> -		return;
> -
> -	virtio_cread_le(vi->vdev, struct virtio_net_config, speed, &speed);
> -
> -	if (ethtool_validate_speed(speed))
> -		vi->speed = speed;
> -
> -	virtio_cread_le(vi->vdev, struct virtio_net_config, duplex, &duplex);
> -
> -	if (ethtool_validate_duplex(duplex))
> -		vi->duplex = duplex;
> -}
> -
>  static u32 virtnet_get_rxfh_key_size(struct net_device *dev)
>  {
>  	return ((struct virtnet_info *)netdev_priv(dev))->rss_key_size;
> @@ -6000,13 +6019,6 @@ static int virtnet_probe(struct virtio_device *vdev)
>  	/* Assume link up if device can't report link status,
>  	   otherwise get link status from config. */
>  	netif_carrier_off(dev);
> -	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
> -		schedule_work(&vi->config_work);
> -	} else {
> -		vi->status = VIRTIO_NET_S_LINK_UP;
> -		virtnet_update_settings(vi);
> -		netif_carrier_on(dev);
> -	}


Here it all made sense - we were reading config for the 1st time.


>  	for (i = 0; i < ARRAY_SIZE(guest_offloads); i++)
>  		if (virtio_has_feature(vi->vdev, guest_offloads[i]))
> -- 
> 2.31.1


