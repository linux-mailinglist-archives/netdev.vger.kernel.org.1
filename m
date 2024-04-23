Return-Path: <netdev+bounces-90699-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 643598AFC19
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 00:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87AAD1C22832
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 22:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C631641746;
	Tue, 23 Apr 2024 22:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="vtBsl/ch"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A912E644
	for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 22:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713912141; cv=none; b=EMMvQrqKaMoh9CtTDS4cC5SPznRb1GvqTsUcdhanDrr27+SrQS4R3c1r6IV33CJ39Sj2IMZrqZAY5elKNZc3zeSzPMjvY5XiEjQqZXd6Fn+dIPiGWt4voIvr7hEe98fXgPdceN4/YAg90G7eBz9kOnx34Ea99mCYsE86s1dC4tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713912141; c=relaxed/simple;
	bh=UvdwXWXG1PNScJhZS7lD4Ns3TVdO+4izlNOhEZdfd+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QADpgRVSUtkyGO3vdeg27YzJ6k34b+BTmGYoRjcQu5JHcPN44/HtOrvOQGBPx5+6RL5HH0i91+eiywF6RuGgsBUxHFCSWb6aKc+u38DlERHq4urLJ1H/2rKIb+Td6UCCeX6vznXD0/EAJlBJsmpgdDIV+BGbf+gEeq9k+s073AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=vtBsl/ch; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1e5715a9ebdso51385505ad.2
        for <netdev@vger.kernel.org>; Tue, 23 Apr 2024 15:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1713912138; x=1714516938; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f0NF/urch0L9yqqTw9KHmdE06xhVpDAjqz9wOu+b8KM=;
        b=vtBsl/chbCNPMhQVjONdN2YmCc1uZUWknGQMpazoyXADdT+WydHffIMw+DTkt78IZw
         ijqMQPUyIKu2FsFf9I1KoYDPBkJnPwZqzfiyzxxX20BOLcWd+N67OElTgzaQby2o+ltm
         KOVhWmupPy/ytKol7rsGCLdPADW2jECV7JOnQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713912138; x=1714516938;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f0NF/urch0L9yqqTw9KHmdE06xhVpDAjqz9wOu+b8KM=;
        b=UeN/SPu6p0xUrviFOpSX64+F5dp+lFK9Mq0WVfR7Qi5Op9MIz3v7WKxOtE9nkTkOWw
         5gzQDz3hMTM1fDq1YJwFPLnGkPLOjje5VhiM/J9zaUcO1ebS4aJpjzrGday9/ZijL4ab
         Rk4Yn3IQysDM4VbDey4dyayGgV4wzccsPGoLWbF1f3XO1vfz0ymIQMfCGVzm4xZf6fT/
         Px9w6kiNuU8ASQXU3/5E6ov26CZNnUCcjzeBb6sebjsF0IVVMc1xlowQfwSbLvpIlIkK
         ETEE2BKyqbaLTTiO8R0H/BN0JcqhEfPIJ9q3nUDH1zSC0FmLBt0ON1km9KMLCn1/n64J
         ZrDA==
X-Forwarded-Encrypted: i=1; AJvYcCU8Tq3yjdd8D/9qzSqY6Rpt2hKuX0VagGYVodTRdWi9ITNuINIzYAj/xNv/pFRFH0/NGjEB8d+Kbbnr/p26WlxvHEn2S/5k
X-Gm-Message-State: AOJu0YybL7HYPqAPBqgK4SbsPKcL6qD2aCGBMowyGr+huZc6wmOX3khi
	l0rzoEsIa9iqsVtYziN0dBPy9PAedOluJBWdEMbclYDPjE67HI8PtCjHV/fSfZk=
X-Google-Smtp-Source: AGHT+IEDbX6ouzL5Njlg4Ul6dWDxEJq6hgxpeeyfBQ3CJep+Y0+BVxqC0fInHm5nJWzeekHj+AC+og==
X-Received: by 2002:a17:902:ce91:b0:1e4:4955:98d9 with SMTP id f17-20020a170902ce9100b001e4495598d9mr1048993plg.45.1713912138228;
        Tue, 23 Apr 2024 15:42:18 -0700 (PDT)
Received: from LQ3V64L9R2 ([74.87.211.242])
        by smtp.gmail.com with ESMTPSA id p2-20020a1709027ec200b001e2ba8605dfsm10716451plb.150.2024.04.23.15.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 15:42:17 -0700 (PDT)
Date: Tue, 23 Apr 2024 12:42:13 -1000
From: Joe Damato <jdamato@fastly.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, tariqt@nvidia.com,
	saeedm@nvidia.com
Cc: mkarsten@uwaterloo.ca, gal@nvidia.com, nalramli@fastly.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"open list:MELLANOX MLX4 core VPI driver" <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH net-next 3/3] net/mlx4: support per-queue statistics via
 netlink
Message-ID: <Zig5RZOkzhGITL7V@LQ3V64L9R2>
References: <20240423194931.97013-1-jdamato@fastly.com>
 <20240423194931.97013-4-jdamato@fastly.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240423194931.97013-4-jdamato@fastly.com>

On Tue, Apr 23, 2024 at 07:49:30PM +0000, Joe Damato wrote:
> Make mlx4 compatible with the newly added netlink queue stats API.
> 
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> Tested-by: Martin Karsten <mkarsten@uwaterloo.ca>
> ---
>  .../net/ethernet/mellanox/mlx4/en_netdev.c    | 91 +++++++++++++++++++
>  1 file changed, 91 insertions(+)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx4/en_netdev.c b/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
> index 5d3fde63b273..c7f04d4820c6 100644
> --- a/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
> +++ b/drivers/net/ethernet/mellanox/mlx4/en_netdev.c
> @@ -43,6 +43,7 @@
>  #include <net/vxlan.h>
>  #include <net/devlink.h>
>  #include <net/rps.h>
> +#include <net/netdev_queues.h>
>  
>  #include <linux/mlx4/driver.h>
>  #include <linux/mlx4/device.h>
> @@ -3099,6 +3100,95 @@ void mlx4_en_set_stats_bitmap(struct mlx4_dev *dev,
>  	last_i += NUM_PHY_STATS;
>  }
>  
> +static void mlx4_get_queue_stats_rx(struct net_device *dev, int i,
> +				    struct netdev_queue_stats_rx *stats)
> +{
> +	struct mlx4_en_priv *priv = netdev_priv(dev);
> +	const struct mlx4_en_rx_ring *ring;
> +
> +	stats->packets = 0xff;
> +	stats->bytes = 0xff;
> +	stats->alloc_fail = 0xff;
> +
> +	spin_lock_bh(&priv->stats_lock);
> +
> +	if (!priv->port_up || mlx4_is_master(priv->mdev->dev))
> +		goto out_unlock;
> +
> +	ring = priv->rx_ring[i];
> +	stats->packets = READ_ONCE(ring->packets);
> +	stats->bytes   = READ_ONCE(ring->bytes);
> +	stats->alloc_fail = READ_ONCE(ring->dropped);
> +
> +out_unlock:
> +	spin_unlock_bh(&priv->stats_lock);
> +}
> +
> +static void mlx4_get_queue_stats_tx(struct net_device *dev, int i,
> +				    struct netdev_queue_stats_tx *stats)
> +{
> +	struct mlx4_en_priv *priv = netdev_priv(dev);
> +	const struct mlx4_en_tx_ring *ring;
> +
> +	stats->packets = 0xff;
> +	stats->bytes = 0xff;
> +
> +	spin_lock_bh(&priv->stats_lock);
> +
> +	if (!priv->port_up || mlx4_is_master(priv->mdev->dev))
> +		goto out_unlock;
> +
> +	ring = priv->tx_ring[TX][i];
> +	stats->packets = READ_ONCE(ring->packets);
> +	stats->bytes   = READ_ONCE(ring->bytes);
> +
> +out_unlock:
> +	spin_unlock_bh(&priv->stats_lock);
> +}
> +
> +static void mlx4_get_base_stats(struct net_device *dev,
> +				struct netdev_queue_stats_rx *rx,
> +				struct netdev_queue_stats_tx *tx)
> +{
> +	struct mlx4_en_priv *priv = netdev_priv(dev);
> +	int i;
> +
> +	rx->packets = 0xff;
> +	rx->bytes = 0xff;
> +	rx->alloc_fail = 0xff;
> +	tx->packets = 0xff;
> +	tx->bytes = 0xff;
> +
> +	spin_lock_bh(&priv->stats_lock);
> +
> +	if (!priv->port_up || mlx4_is_master(priv->mdev->dev))
> +		goto out_unlock;

I realized in this case, I'll need to set the fields initialized to 0xff
above to 0 before doing the increments below.

Sorry about that; just realized that now and will fix that in the v2 (along
with any other feedback I get), probably something:

  if (priv->rx_ring_num) {
          rx->packets = 0;
          rx->bytes = 0;
          rx->alloc_fail = 0;
  }

Here for the RX side and see below for the TX side.

> +	for (i = 0; i < priv->rx_ring_num; i++) {
> +		const struct mlx4_en_rx_ring *ring = priv->rx_ring[i];
> +
> +		rx->packets += READ_ONCE(ring->packets);
> +		rx->bytes += READ_ONCE(ring->bytes);
> +		rx->alloc_fail += READ_ONCE(ring->dropped);
> +	}

Similar to above, probably will fix with something like this here:

  if (priv->tx_ring_num[TX]) {
          tx->packets = 0;
          tx->bytes = 0;
  }

Sorry for the noise, I should have noticed this before sending it out.

> +	for (i = 0; i < priv->tx_ring_num[TX]; i++) {
> +		const struct mlx4_en_tx_ring *ring = priv->tx_ring[TX][i];
> +
> +		tx->packets += READ_ONCE(ring->packets);
> +		tx->bytes   += READ_ONCE(ring->bytes);
> +	}
> +
> +out_unlock:
> +	spin_unlock_bh(&priv->stats_lock);
> +}
> +
> +static const struct netdev_stat_ops mlx4_stat_ops = {
> +	.get_queue_stats_rx     = mlx4_get_queue_stats_rx,
> +	.get_queue_stats_tx     = mlx4_get_queue_stats_tx,
> +	.get_base_stats         = mlx4_get_base_stats,
> +};
> +
>  int mlx4_en_init_netdev(struct mlx4_en_dev *mdev, int port,
>  			struct mlx4_en_port_profile *prof)
>  {
> @@ -3262,6 +3352,7 @@ int mlx4_en_init_netdev(struct mlx4_en_dev *mdev, int port,
>  	netif_set_real_num_tx_queues(dev, priv->tx_ring_num[TX]);
>  	netif_set_real_num_rx_queues(dev, priv->rx_ring_num);
>  
> +	dev->stat_ops = &mlx4_stat_ops;
>  	dev->ethtool_ops = &mlx4_en_ethtool_ops;
>  
>  	/*
> -- 
> 2.25.1
> 

