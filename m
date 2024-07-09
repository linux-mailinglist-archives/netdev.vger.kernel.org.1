Return-Path: <netdev+bounces-110150-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D8E92B1E8
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 10:14:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 898EF2826B2
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 08:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32129152E15;
	Tue,  9 Jul 2024 08:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="r23IEEij"
X-Original-To: netdev@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67CA152E0E;
	Tue,  9 Jul 2024 08:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720512875; cv=none; b=Z3LzGdJ1ZvxX2wAnNYO4W82S1YkThLm4Ll4TI2AnEulKewgJaT+FN58S27fYRPLDR7WCBNp85tWxAJrX28iks7KgKs4xo1sCG6+u00DuCD1EAmIWEhRZoeeS2Ug3ZxmJK1uqbtGMyUd9qgvlAxokNirSDt6mMoF1adq38H6y67w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720512875; c=relaxed/simple;
	bh=jHYgOUYZNDN4TT6NaoH4B6KP3j10ThQ1R7SuDQV3Am4=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=q1N/KVnKT3bD05JJnMdg1YU7SAX4F4e60Th/tonFajwztdmz4bYCq76OVqp7n1syFgS8Z037L/IYWN8qd9P0AkeJAKB+955nQWQr6qwUJTs+RZVYS4IHd367rBu07vemZohfz9M28JfeMMs7x6WUEDqUb9QTfdzmOVwOIMdZbVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=r23IEEij; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1720512865; h=Message-ID:Subject:Date:From:To;
	bh=9ZPXBFessF7YYMvrmhVpEe9L/6/J8peId7eQk6COC6w=;
	b=r23IEEijW7j/l/r7ZqCXvPZEL+t3Y9EfzubYYYA789a4BOm+jhQwZ6//A6HlB4OFPb1FdhH5/4YdzqLtOXXIHCLING7gac3rCk6jwNFKC8Eot0AZJCj/XGw/S6FqjeCDW4XxnIDty6dWDKyG0PghHFda5BblC5CCG1pZxIdWxQw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045046011;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0WAB1v5Z_1720512864;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WAB1v5Z_1720512864)
          by smtp.aliyun-inc.com;
          Tue, 09 Jul 2024 16:14:24 +0800
Message-ID: <1720512858.396788-4-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v3 3/3] virtio-net: synchronize operstate with admin state on up/down
Date: Tue, 9 Jul 2024 16:14:18 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
Cc: virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 davem@davemloft.net,
 edumazet@google.com,
 kuba@kernel.org,
 pabeni@redhat.com,
 netdev@vger.kernel.org,
 Venkat Venkatsubra <venkat.x.venkatsubra@oracle.com>,
 "Gia-Khanh Nguyen" <gia-khanh.nguyen@oracle.com>,
 mst@redhat.com,
 jasowang@redhat.com,
 eperezma@redhat.com
References: <20240709080214.9790-1-jasowang@redhat.com>
 <20240709080214.9790-4-jasowang@redhat.com>
In-Reply-To: <20240709080214.9790-4-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Tue,  9 Jul 2024 16:02:14 +0800, Jason Wang <jasowang@redhat.com> wrote:
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
>
> Cc: Venkat Venkatsubra <venkat.x.venkatsubra@oracle.com>
> Cc: Gia-Khanh Nguyen <gia-khanh.nguyen@oracle.com>
> Signed-off-by: Jason Wang <jasowang@redhat.com>




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
> +		virtio_config_changed(vi->vdev);
> +	} else {
> +		vi->status = VIRTIO_NET_S_LINK_UP;
> +		virtnet_update_settings(vi);
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
>
>  	for (i = 0; i < ARRAY_SIZE(guest_offloads); i++)
>  		if (virtio_has_feature(vi->vdev, guest_offloads[i]))
> --
> 2.31.1
>

