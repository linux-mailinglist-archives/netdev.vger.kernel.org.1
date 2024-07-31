Return-Path: <netdev+bounces-114690-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 371529437F5
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 23:27:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8712BB2115D
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 21:27:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E64B416CD01;
	Wed, 31 Jul 2024 21:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S2bDBLHd"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F264716C86B
	for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 21:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722461165; cv=none; b=E/ddZoDYfZTifxNDPIPGhkkDh9Jeyd4fyrGELw1xsm8ngjxyQVZNTTi2DoftQfcjQ1NMrhGqUibk0+nbOkcY5JDOTPw0fEJMt4SY6DEp2cWNG04Y4KW0NcRp2TIe0EDeX+eNd7kgH1rK1Fyi2j0V7J7WCdS6trDUVYIjSBxKoOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722461165; c=relaxed/simple;
	bh=wJqZinwQDfOcdmnW4ZL4CO1V5KkxCLaHjUfw+VxoVJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MC2XpDmegrZiK0tJ1jiD99nIRy5Zxrwr4bo5pPZ5JrZdNtEJZ7f/X6qWglLHkVTCXzLqva8BpNqfVt6BY+80xeLCouOS+zjOyXBZhd22vMXej1e1a18aMVugVTMFSth4/LpKSnTq/OeO8lq4uPytKbZLYwzUHNXWHJ+Pwh9DU+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S2bDBLHd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722461162;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7TRUxYTLzYZ5rhCTZsxQPqbtc51PlpFIcUNUImpU7Vc=;
	b=S2bDBLHd5ZNYga44ME8sORaegPCZXTPKMlnk879xeMU42mqtfhILLYK8Qosi/zYWOrr9hx
	rbODD8pAxuJbzahO0c6ibvmGoA+zO+3fekKaUWxR78d+8sQsCD+cMOfEMvkzKiGqey8809
	Uu1IutN1mHhhNE2j/bayy3eH9+GreAk=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-361-7J2LbeWUPACvPxSuz5fThA-1; Wed, 31 Jul 2024 17:26:01 -0400
X-MC-Unique: 7J2LbeWUPACvPxSuz5fThA-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2ef31dbc770so60042341fa.1
        for <netdev@vger.kernel.org>; Wed, 31 Jul 2024 14:26:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722461159; x=1723065959;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7TRUxYTLzYZ5rhCTZsxQPqbtc51PlpFIcUNUImpU7Vc=;
        b=v4EWg4vqToMdphGhwTd5qP6DqrZikgQ/UXRme7gKOokcsmBDSL5c0Huro3ZfUNZJGw
         xiPBkL9H29/FqDtVjw7fWo+SAASJUFeX68LiY/HbRaBs6hzXpnPBJWYTT7j4G9qqqEJ1
         qGOf+8ITxZcYQvBM2sE9UCdkxJ4+QOrUvebB35dJlO5eJvXkgMNxhfPsWHxJjjItnnUn
         Y2XxPUmWF2JmIPM3j/GXwqRot3endyKCDhyi4HFaluJRjURjE9RHnheV3GoaLw+eEyHf
         zelvxScHbNmxtB+myYPDziSJG2pHghbde+6eJEWHjdIdsRkD0EIesNyiKvP2CCXq3+RD
         vkAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzmo2e8ozC+39K0+NeLpM0E1cSOfB+8jdohLWE8+Sum+sq2gCBtCEaD0pdKSqoamsrEGutVqFClkpktBROErUPun53AB0T
X-Gm-Message-State: AOJu0Yw811XNneJSCLYTS3qXAjzcXd83niyfd04N3724ccOYcMIOILgc
	yczCitxM96/vg0mNcYsgWdtyN/yYL8HpcB9qQlwLzdWVKhq+z94TlMbNBmcHYaOgrH2kPL5IRRS
	90NIGfzRHgQh8dimGdryA09euSg9Ha5SEQeAnx99kVeoOC/2AaZe5+w==
X-Received: by 2002:a2e:380b:0:b0:2ef:2443:ac8c with SMTP id 38308e7fff4ca-2f1533ab1ddmr3483051fa.31.1722461159394;
        Wed, 31 Jul 2024 14:25:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHIXn3AhsXUgtbnPlhnFXcqTpzKMkzJeCcf1n2YR70oWJ6bCl6GOib1rUPlhXEQ2MUOewM2VQ==
X-Received: by 2002:a2e:380b:0:b0:2ef:2443:ac8c with SMTP id 38308e7fff4ca-2f1533ab1ddmr3482861fa.31.1722461158392;
        Wed, 31 Jul 2024 14:25:58 -0700 (PDT)
Received: from redhat.com ([2.55.44.248])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac6377d005sm9105489a12.38.2024.07.31.14.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 14:25:57 -0700 (PDT)
Date: Wed, 31 Jul 2024 17:25:52 -0400
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
Message-ID: <20240731172020-mutt-send-email-mst@kernel.org>
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

Changelog?

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

hmm

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

I already commented on this approach.  This is now invoked on each open,
lots of extra VM exits. No bueno, people are working hard to keep setup
overhead under control. Handle this in the config change interrupt -
your new infrastructure is perfect for this.


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

it's clear what this does even without a comment.
what you should comment on, and do not, is *why*.

> +	virtio_config_driver_disable(vi->vdev);
> +	/* Make sure status updating is cancelled */

same

also what "status updating"? confuses more than this clarifies.

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

notifications

Disable, not forbid.

> +	virtio_config_driver_disable(vi->vdev);
> +	/* Make sure status updating work is done */



> +	cancel_work_sync(&vi->config_work);
> +
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

config change notification

> +		   disabled. */
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


