Return-Path: <netdev+bounces-114802-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F70944303
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 08:06:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B8D6B21107
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 06:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5236A155756;
	Thu,  1 Aug 2024 06:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U8MgtDUG"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B3D282E1
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 06:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722492375; cv=none; b=JJFFRYnVUNBVuzSlAqojq5zy/A3P3yAqF7//GvGeJIPuNS8IvkC6IM4FwR4gGqk7m99TBUJOsN4QKJuMErbO4MzN5WO2w+/El7w6wgZ45heM2MQ7abOaCUmGn55RgPYhfzk1TWQebwLkyqb/VVViB/372KWwyLHI+OQD4+5GIL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722492375; c=relaxed/simple;
	bh=MoJr4mGPo2emWOdduc6Ewmz4RQQEWee+Ztqd4CfE9Nc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oipccLkMCZcp5t+s1xcscKFMxCYIDj+YoehKQ7+YLXS/33/nEtVpOSwFEbgHVIqB6PopwvkJhwddVYQNgK8NOm5DEhabQGeXGKBv2GS2l/+VVdCjisEvWCntSxwIObg5HwcSlj8f0POepCDJBUVKnMhguOnI/JtMIQFuKuIdVfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U8MgtDUG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722492372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oXvVrXEs7imKq8lxNZGkuvPb2Qi8cRn244ngd84DYZs=;
	b=U8MgtDUGTxSBbLV9Y9br4o/Z9IQcR5hfM1NMNze5y2B3FZL2vUQDMY/aNhZVbP8J8OK5/F
	i2xvgk5l7YOpJ/qagDCol7oXCUPQ0v4JXv/lw8XaNltUjRmWapMAWKg1c3FxNCyZ3/5T8g
	s0jsNe8inpYZdyWr6kSpMgHwM9NtFao=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-282-87DrywF5MFOnrGdu537EAQ-1; Thu, 01 Aug 2024 02:06:08 -0400
X-MC-Unique: 87DrywF5MFOnrGdu537EAQ-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2ef3157ae4cso68672691fa.2
        for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 23:06:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722492367; x=1723097167;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oXvVrXEs7imKq8lxNZGkuvPb2Qi8cRn244ngd84DYZs=;
        b=OQ4ImAAouSytrE2GOjs7C8aSipw5HdE/LtLHDP9pMXViJoVWGuBmNvl01JduZuGpj1
         n70B433GY0LzV6bCRW5mzWVJ4CeOc3iVY9ToByWUoxmtm4BUPtdt8In9EUdMAMl+LU3v
         bqE3/SMG1A3tC49ecQAfUkHihaCn40xdHsUeZDhnT4p4CXPh/572GlUQQF73pqnFB1s+
         WcqTXSuu+HIzB7lBfzENLqaUG15yMMDHjzRpJiUZgdwz0N5JjCQ8dzHEpghK1yPUmQIj
         mw3RgpNKcVEbIw47AjxmOhOKMfe8ag75SJindkWZ57zzGOM7YyrQamM4wpywmx3CTeL+
         iMig==
X-Forwarded-Encrypted: i=1; AJvYcCU5DfvXg5lUMDV4JYWflW3HpN570F5Dhtv1yHVQy6+2iP+REujZ52o1l34rxunPvtq3E2fXl3eAApyAmI9wIH0rMzXe8AXV
X-Gm-Message-State: AOJu0YxJwzXnJ8xu/KgmVRpOHiqgasI+ND8dNB8/Zlf9EUOaD3/o6uUa
	+kazhyCHdBF+aUE2RLftsHLSJi5sHCQfvBFFVUhiWj5ugLNN+InZjQlW4rPNrKtR3Bq+NY44uca
	pCmODdbjOjtYrBHrQxX4L8lJf8bVXLz6y5iLgl0eK8YdEGPD1aaNrvg==
X-Received: by 2002:a2e:9e44:0:b0:2ef:32bb:5368 with SMTP id 38308e7fff4ca-2f1530ea1e2mr11451431fa.11.1722492367217;
        Wed, 31 Jul 2024 23:06:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHM9ZyKL75V6GO6PtO5RhoimbEdBrF+GHnf8Kpa6aPVDLn3MkQr2Rf9oSzR7icep3N5IacJHQ==
X-Received: by 2002:a2e:9e44:0:b0:2ef:32bb:5368 with SMTP id 38308e7fff4ca-2f1530ea1e2mr11450881fa.11.1722492366305;
        Wed, 31 Jul 2024 23:06:06 -0700 (PDT)
Received: from redhat.com ([2.55.14.19])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acad41027sm845472466b.122.2024.07.31.23.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 23:06:04 -0700 (PDT)
Date: Thu, 1 Aug 2024 02:05:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Venkat Venkatsubra <venkat.x.venkatsubra@oracle.com>,
	Gia-Khanh Nguyen <gia-khanh.nguyen@oracle.com>
Subject: Re: [PATCH V4 net-next 3/3] virtio-net: synchronize operstate with
 admin state on up/down
Message-ID: <20240801015914-mutt-send-email-mst@kernel.org>
References: <20240731025947.23157-1-jasowang@redhat.com>
 <20240731025947.23157-4-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731025947.23157-4-jasowang@redhat.com>

On Wed, Jul 31, 2024 at 10:59:47AM +0800, Jason Wang wrote:
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
>  drivers/net/virtio_net.c | 84 ++++++++++++++++++++++++++--------------
>  1 file changed, 54 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 0383a3e136d6..0cb93261eba1 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2878,6 +2878,7 @@ static int virtnet_enable_queue_pair(struct virtnet_info *vi, int qp_index)
>  	return err;
>  }
>  
> +
>  static void virtnet_cancel_dim(struct virtnet_info *vi, struct dim *dim)
>  {
>  	if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_VQ_NOTF_COAL))
> @@ -2885,6 +2886,25 @@ static void virtnet_cancel_dim(struct virtnet_info *vi, struct dim *dim)
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
> @@ -2903,6 +2923,16 @@ static int virtnet_open(struct net_device *dev)
>  			goto err_enable_qp;
>  	}
>  
> +	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
> +		if (vi->status & VIRTIO_NET_S_LINK_UP)
> +			netif_carrier_on(vi->dev);
> +		virtio_config_driver_enable(vi->vdev);
> +	} else {
> +		vi->status = VIRTIO_NET_S_LINK_UP;
> +		netif_carrier_on(dev);
> +		virtnet_update_settings(vi);
> +	}
> +
>  	return 0;
>  
>  err_enable_qp:
> @@ -3381,12 +3411,18 @@ static int virtnet_close(struct net_device *dev)
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
> +	netif_carrier_off(dev);
> +
>  	return 0;
>  }
>  
> @@ -5085,25 +5121,6 @@ static void virtnet_init_settings(struct net_device *dev)
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
> @@ -6514,6 +6531,11 @@ static int virtnet_probe(struct virtio_device *vdev)
>  		goto free_failover;
>  	}
>  
> +	/* Forbid config change notification until ndo_open. */
> +	virtio_config_driver_disable(vi->vdev);
> +	/* Make sure status updating work is done */

Wait a second, how can anything run here, this is probe,
config change callbacks are never invoked at all.

> +	cancel_work_sync(&vi->config_work);
> +


this is pointless, too.

>  	virtio_device_ready(vdev);
>  
>  	virtnet_set_queues(vi, vi->curr_queue_pairs);
> @@ -6563,6 +6585,19 @@ static int virtnet_probe(struct virtio_device *vdev)
>  		vi->device_stats_cap = le64_to_cpu(v);
>  	}
>  
> +	/* Assume link up if device can't report link status,
> +           otherwise get link status from config. */
> +        netif_carrier_off(dev);
> +        if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
> +		/* This is safe as config notification change has been
> +		   disabled. */

What "this"? pls explain what this does: get config data from
device.

Actually not because it was disabled. probe can poke at
config with impunity no change callbacks trigger during probe.

> +                virtnet_config_changed_work(&vi->config_work);




> +        } else {
> +                vi->status = VIRTIO_NET_S_LINK_UP;
> +                virtnet_update_settings(vi);
> +                netif_carrier_on(dev);
> +        }
> +
>  	rtnl_unlock();
>  
>  	err = virtnet_cpu_notif_add(vi);
> @@ -6571,17 +6606,6 @@ static int virtnet_probe(struct virtio_device *vdev)
>  		goto free_unregister_netdev;
>  	}
>  
> -	/* Assume link up if device can't report link status,
> -	   otherwise get link status from config. */
> -	netif_carrier_off(dev);
> -	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
> -		schedule_work(&vi->config_work);
> -	} else {
> -		vi->status = VIRTIO_NET_S_LINK_UP;
> -		virtnet_update_settings(vi);
> -		netif_carrier_on(dev);
> -	}
> -
>  	for (i = 0; i < ARRAY_SIZE(guest_offloads); i++)
>  		if (virtio_has_feature(vi->vdev, guest_offloads[i]))
>  			set_bit(guest_offloads[i], &vi->guest_offloads);
> -- 
> 2.31.1


