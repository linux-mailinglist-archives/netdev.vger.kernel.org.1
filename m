Return-Path: <netdev+bounces-97285-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E878CA800
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 08:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E2B21F22121
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 06:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0192444C89;
	Tue, 21 May 2024 06:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="jdCvgC+6"
X-Original-To: netdev@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E4740879
	for <netdev@vger.kernel.org>; Tue, 21 May 2024 06:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716272639; cv=none; b=NZjONQj1rRQwpg+Jp95gBxLA64YfGF17nmKkdTvTqhZQZc6ygfPKUv9CS4sXlHWnk4OqjV4qo0piC32B67FQtSsacKqo58kvw/2PETVR6nGEV7g9lGt9jNaZMYJ0U8zbRmRUfuAdJgsKUxuGgRnHvSMpO+orscyRBx7F4vfTies=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716272639; c=relaxed/simple;
	bh=XdPY4gjUwA1NE+duK1+PdXwvwNKmDcz5+eP3xPTua60=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=Rkd9CG9CGqli2+suSOlqj6Pq/jGtQcOtHs0ezk1rcCNv1qsCeT3IrLknoo8eEMDFUVx3W5guvR7bmf+eYPX59/z7ngzR/7xPk+7JqPC7kxkT5+b7Gs8C7R+qBj+9p/Wq1ImS509tKRSPd+iQm4hTuvDmkWQzDY/U+NkiptqjyzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=jdCvgC+6; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1716272629; h=Message-ID:Subject:Date:From:To;
	bh=jiBqV3uNX+LvaujZ+2ncVHB5kL3I+N85pKIYKn0YHNo=;
	b=jdCvgC+6LZmIchDhmcBx2mc00dPKwA9j7bXxa5J54ff22cCxMrlqOlGqgyu0SOd42jwUa6vkXbzEf+6DR/TFde054w1EHp6L8oRjaO/ziDFxVjvaHfYOwWKy1nD6tXMlM7a1RRgSYDTyNdKqhH7js3STS7NrcupU/TIGRn7lA+w=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R641e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045046011;MF=xuanzhuo@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0W6wiHx-_1716272628;
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0W6wiHx-_1716272628)
          by smtp.aliyun-inc.com;
          Tue, 21 May 2024 14:23:49 +0800
Message-ID: <1716272619.4598048-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next] virtio-net: synchronize operstate with admin state on up/down
Date: Tue, 21 May 2024 14:23:39 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
Cc: davem@davemloft.net,
 edumazet@google.com,
 kuba@kernel.org,
 pabeni@redhat.com,
 virtualization@lists.linux.dev,
 netdev@vger.kernel.org,
 Venkat Venkatsubra <venkat.x.venkatsubra@oracle.com>,
 "Gia-Khanh Nguyen" <gia-khanh.nguyen@oracle.com>,
 mst@redhat.com,
 jasowang@redhat.com
References: <20240520010302.68611-1-jasowang@redhat.com>
In-Reply-To: <20240520010302.68611-1-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Mon, 20 May 2024 09:03:02 +0800, Jason Wang <jasowang@redhat.com> wrote:
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

Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

Thanks.

> ---
>  drivers/net/virtio_net.c | 94 +++++++++++++++++++++++++++-------------
>  1 file changed, 63 insertions(+), 31 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 4e1a0fc0d555..24d880a5023d 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -433,6 +433,12 @@ struct virtnet_info {
>  	/* The lock to synchronize the access to refill_enabled */
>  	spinlock_t refill_lock;
>
> +	/* Is config change enabled? */
> +	bool config_change_enabled;
> +
> +	/* The lock to synchronize the access to config_change_enabled */
> +	spinlock_t config_change_lock;
> +
>  	/* Work struct for config space updates */
>  	struct work_struct config_work;
>
> @@ -623,6 +629,20 @@ static void disable_delayed_refill(struct virtnet_info *vi)
>  	spin_unlock_bh(&vi->refill_lock);
>  }
>
> +static void enable_config_change(struct virtnet_info *vi)
> +{
> +	spin_lock_irq(&vi->config_change_lock);
> +	vi->config_change_enabled = true;
> +	spin_unlock_irq(&vi->config_change_lock);
> +}
> +
> +static void disable_config_change(struct virtnet_info *vi)
> +{
> +	spin_lock_irq(&vi->config_change_lock);
> +	vi->config_change_enabled = false;
> +	spin_unlock_irq(&vi->config_change_lock);
> +}
> +
>  static void enable_rx_mode_work(struct virtnet_info *vi)
>  {
>  	rtnl_lock();
> @@ -2421,6 +2441,25 @@ static int virtnet_enable_queue_pair(struct virtnet_info *vi, int qp_index)
>  	return err;
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
> @@ -2439,6 +2478,18 @@ static int virtnet_open(struct net_device *dev)
>  			goto err_enable_qp;
>  	}
>
> +	/* Assume link up if device can't report link status,
> +	   otherwise get link status from config. */
> +	netif_carrier_off(dev);
> +	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
> +		enable_config_change(vi);
> +		schedule_work(&vi->config_work);
> +	} else {
> +		vi->status = VIRTIO_NET_S_LINK_UP;
> +		virtnet_update_settings(vi);
> +		netif_carrier_on(dev);
> +	}
> +
>  	return 0;
>
>  err_enable_qp:
> @@ -2875,12 +2926,19 @@ static int virtnet_close(struct net_device *dev)
>  	disable_delayed_refill(vi);
>  	/* Make sure refill_work doesn't re-enable napi! */
>  	cancel_delayed_work_sync(&vi->refill);
> +	/* Make sure config notification doesn't schedule config work */
> +	disable_config_change(vi);
> +	/* Make sure status updating is cancelled */
> +	cancel_work_sync(&vi->config_work);
>
>  	for (i = 0; i < vi->max_queue_pairs; i++) {
>  		virtnet_disable_queue_pair(vi, i);
>  		cancel_work_sync(&vi->rq[i].dim.work);
>  	}
>
> +	vi->status &= ~VIRTIO_NET_S_LINK_UP;
> +	netif_carrier_off(dev);
> +
>  	return 0;
>  }
>
> @@ -4583,25 +4641,6 @@ static void virtnet_init_settings(struct net_device *dev)
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
> @@ -5163,7 +5202,10 @@ static void virtnet_config_changed(struct virtio_device *vdev)
>  {
>  	struct virtnet_info *vi = vdev->priv;
>
> -	schedule_work(&vi->config_work);
> +	spin_lock_irq(&vi->config_change_lock);
> +	if (vi->config_change_enabled)
> +		schedule_work(&vi->config_work);
> +	spin_unlock_irq(&vi->config_change_lock);
>  }
>
>  static void virtnet_free_queues(struct virtnet_info *vi)
> @@ -5706,6 +5748,7 @@ static int virtnet_probe(struct virtio_device *vdev)
>  	INIT_WORK(&vi->config_work, virtnet_config_changed_work);
>  	INIT_WORK(&vi->rx_mode_work, virtnet_rx_mode_work);
>  	spin_lock_init(&vi->refill_lock);
> +	spin_lock_init(&vi->config_change_lock);
>
>  	if (virtio_has_feature(vdev, VIRTIO_NET_F_MRG_RXBUF)) {
>  		vi->mergeable_rx_bufs = true;
> @@ -5901,17 +5944,6 @@ static int virtnet_probe(struct virtio_device *vdev)
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
>

