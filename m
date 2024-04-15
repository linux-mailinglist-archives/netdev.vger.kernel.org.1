Return-Path: <netdev+bounces-87990-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D14528A51FD
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 15:43:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D4A92860C4
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 13:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A7871758;
	Mon, 15 Apr 2024 13:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="fd1oVXr3"
X-Original-To: netdev@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE91D405CC
	for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 13:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713188511; cv=none; b=cQubJGlT9cdJGiq9Lzfrp1nerI2My9y7ltMIe89CxulnKnzHcPP/LdLHz35kU9cDW1BlyMIpHAwXZoEn4veqATsIAw2UWGGLOdSqvvY0idYtXy/b2tBw32bFh6mtcubCAwYW78E5K/3hjl5NYNiMaBrNBjy94/pmtwXFkDrLicQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713188511; c=relaxed/simple;
	bh=8TTq7/7mxb6gkKwFLP2AmGeM/QjMw44POOLNWcWB1Vc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MUxJtFPwgfXXsad7D3nVnweZwMPUEkqBFeI8fHiDI3p32DH9m2SiVdM/CtlxTACWKT3MbuS7qMKmBJ6BK3JhROILQWjlbt6MoSBIJ4dY7iHFvRY1QuVum+jMH5zUzoEnoJVHK9xog6yFHJXW3bpVNulN6HO7TjqZsS+Zck3T45I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=fd1oVXr3; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713188506; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=AJqKE5avGzGgJ1MYXjUupo8SIJnHoMpU521d9pfBahw=;
	b=fd1oVXr3K0PtS1T8qex3l9SkxRy/ZEGUCah0TzORr04CNZ2J/gpAjIEBoCVaQKvFjCaAX9/XHVhs85TgSJvvhcvgCh5ALXQBXzryy5dj+2vdeDQTcwTzRs/FWqbC3uem81GnY28QhZo5UUU7ayiKAVJNB/6c9lVIsCuZse1IoAs=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0W4ea8bU_1713188504;
Received: from 30.221.148.177(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W4ea8bU_1713188504)
          by smtp.aliyun-inc.com;
          Mon, 15 Apr 2024 21:41:46 +0800
Message-ID: <80934787-ea3c-4b6d-a236-5185430ac92b@linux.alibaba.com>
Date: Mon, 15 Apr 2024 21:41:44 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 5/6] virtio_net: Add a lock for per queue RX
 coalesce
To: Daniel Jurgens <danielj@nvidia.com>, netdev@vger.kernel.org
Cc: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
 virtualization@lists.linux.dev, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, jiri@nvidia.com
References: <20240412195309.737781-1-danielj@nvidia.com>
 <20240412195309.737781-6-danielj@nvidia.com>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <20240412195309.737781-6-danielj@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/4/13 上午3:53, Daniel Jurgens 写道:
> Once the RTNL locking around the control buffer is removed there can be
> contention on the per queue RX interrupt coalescing data. Use a spin
> lock per queue.
>
> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
> ---
>   drivers/net/virtio_net.c | 23 ++++++++++++++++-------
>   1 file changed, 16 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index b3aa4d2a15e9..8724caa7c2ed 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -190,6 +190,7 @@ struct receive_queue {
>   	u32 packets_in_napi;
>   
>   	struct virtnet_interrupt_coalesce intr_coal;
> +	spinlock_t intr_coal_lock;
>   
>   	/* Chain pages by the private ptr. */
>   	struct page *pages;
> @@ -3087,11 +3088,13 @@ static int virtnet_set_ringparam(struct net_device *dev,
>   				return err;
>   
>   			/* The reason is same as the transmit virtqueue reset */
> -			err = virtnet_send_rx_ctrl_coal_vq_cmd(vi, i,
> -							       vi->intr_coal_rx.max_usecs,
> -							       vi->intr_coal_rx.max_packets);
> -			if (err)
> -				return err;
> +			scoped_guard(spinlock, &vi->rq[i].intr_coal_lock) {
> +				err = virtnet_send_rx_ctrl_coal_vq_cmd(vi, i,
> +								       vi->intr_coal_rx.max_usecs,
> +								       vi->intr_coal_rx.max_packets);
> +				if (err)
> +					return err;
> +			}
>   		}
>   	}
>   
> @@ -3510,8 +3513,10 @@ static int virtnet_send_rx_notf_coal_cmds(struct virtnet_info *vi,
>   	vi->intr_coal_rx.max_usecs = ec->rx_coalesce_usecs;
>   	vi->intr_coal_rx.max_packets = ec->rx_max_coalesced_frames;
>   	for (i = 0; i < vi->max_queue_pairs; i++) {
> -		vi->rq[i].intr_coal.max_usecs = ec->rx_coalesce_usecs;
> -		vi->rq[i].intr_coal.max_packets = ec->rx_max_coalesced_frames;
> +		scoped_guard(spinlock, &vi->rq[i].intr_coal_lock) {
> +			vi->rq[i].intr_coal.max_usecs = ec->rx_coalesce_usecs;
> +			vi->rq[i].intr_coal.max_packets = ec->rx_max_coalesced_frames;
> +		}
>   	}
>   
>   	return 0;
> @@ -3542,6 +3547,7 @@ static int virtnet_send_rx_notf_coal_vq_cmds(struct virtnet_info *vi,
>   	u32 max_usecs, max_packets;
>   	int err;
>   
> +	guard(spinlock)(&vi->rq[queue].intr_coal_lock);
>   	max_usecs = vi->rq[queue].intr_coal.max_usecs;
>   	max_packets = vi->rq[queue].intr_coal.max_packets;
>   
> @@ -3606,6 +3612,7 @@ static void virtnet_rx_dim_work(struct work_struct *work)
>   	if (!rq->dim_enabled)
>   		goto out;

We should also protect rq->dim_enabled access, incorrect values may be 
read in
rx_dim_worker because it is modified in set_coalesce/set_per_queue_coalesce.

Thanks.

>   
> +	guard(spinlock)(&rq->intr_coal_lock);
>   	update_moder = net_dim_get_rx_moderation(dim->mode, dim->profile_ix);
>   	if (update_moder.usec != rq->intr_coal.max_usecs ||
>   	    update_moder.pkts != rq->intr_coal.max_packets) {
> @@ -3756,6 +3763,7 @@ static int virtnet_get_per_queue_coalesce(struct net_device *dev,
>   		return -EINVAL;
>   
>   	if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_VQ_NOTF_COAL)) {
> +		guard(spinlock)(&vi->rq[queue].intr_coal_lock);
>   		ec->rx_coalesce_usecs = vi->rq[queue].intr_coal.max_usecs;
>   		ec->tx_coalesce_usecs = vi->sq[queue].intr_coal.max_usecs;
>   		ec->tx_max_coalesced_frames = vi->sq[queue].intr_coal.max_packets;
> @@ -4501,6 +4509,7 @@ static int virtnet_alloc_queues(struct virtnet_info *vi)
>   
>   		u64_stats_init(&vi->rq[i].stats.syncp);
>   		u64_stats_init(&vi->sq[i].stats.syncp);
> +		spin_lock_init(&vi->rq[i].intr_coal_lock);
>   	}
>   
>   	return 0;


