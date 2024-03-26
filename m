Return-Path: <netdev+bounces-81936-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08FA088BCE0
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 09:55:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B360E2E3AAB
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 08:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557E111CBA;
	Tue, 26 Mar 2024 08:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="CNhhBiBn"
X-Original-To: netdev@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4FC14290
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 08:55:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711443305; cv=none; b=MBWcL5z3rc+Ua7HAKYhoJbSFcD1xEVVccLegyzYO4ImooNd/EY7MZy961FWQGUliJpE5mOJ8L1KspUhv9acMcFpOB7R0euv2IUnETMqCtBV6dS8yVRdK/AE8+mtSAnvKRRgXHzMnwCDPFAcHoWYpk02aPn8g5GShhM7cnrlxmhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711443305; c=relaxed/simple;
	bh=CrajXvb3Y6yOtElYto91kI0srJFZeDUdWSC6aT2R9vc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pc1vMECaUW8Hqw80V3JUvquh6+BFsp2Az6sNuiAQSMtQMMp3zHWZb4x0R8RP5IysYGZXS1NxkXcrebGuB06ITzkiCPoUISFEqzN6rLTKvhw6xygoIcUMX2BMOkT9gffqOl29AZrUfDnlWUhNrlSQ+/OsgqTGsb8w8idoXdTloac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=CNhhBiBn; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711443295; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Gpm/s+EmzB9U/+tLm8dO6kOXPvtxh6u8iVlG8sBa3z0=;
	b=CNhhBiBnKDMXSyC3OJOJLDnqEuGIn6y8HYE1oP7PUsgqVeCeaVV6MdnZLmNa1XAcAfzbMW9wo9jMw7X8bwGVjS5GxiB97U2eUzxKcQFlqyXk/p1iUQJPfYI0zf0nGxwUu8iKqr+TY2PuAfCMcUq9HbiG0uR07KwrzFaJVFCUb0k=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0W3KW6I9_1711443293;
Received: from 30.221.149.28(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W3KW6I9_1711443293)
          by smtp.aliyun-inc.com;
          Tue, 26 Mar 2024 16:54:54 +0800
Message-ID: <11b6dac0-a18a-47ae-904d-cb9d29e1ca31@linux.alibaba.com>
Date: Tue, 26 Mar 2024 16:54:52 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 4/4] virtio_net: Remove rtnl lock protection of
 command buffers
To: Daniel Jurgens <danielj@nvidia.com>, netdev@vger.kernel.org
Cc: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
 virtualization@lists.linux.dev, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, jiri@nvidia.com
References: <20240325214912.323749-1-danielj@nvidia.com>
 <20240325214912.323749-5-danielj@nvidia.com>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <20240325214912.323749-5-danielj@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/3/26 上午5:49, Daniel Jurgens 写道:
> The rtnl lock is no longer needed to protect the control buffer and
> command VQ.
>
> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> ---
>   drivers/net/virtio_net.c | 27 +++++----------------------
>   1 file changed, 5 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 41f8dc16ff38..d09ea20b16be 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -2639,14 +2639,12 @@ static void virtnet_stats(struct net_device *dev,
>   
>   static void virtnet_ack_link_announce(struct virtnet_info *vi)
>   {
> -	rtnl_lock();
>   	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_ANNOUNCE,
>   				  VIRTIO_NET_CTRL_ANNOUNCE_ACK, NULL))
>   		dev_warn(&vi->dev->dev, "Failed to ack link announce.\n");
> -	rtnl_unlock();
>   }
>   
> -static int _virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
> +static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
>   {
>   	struct virtio_net_ctrl_mq *mq __free(kfree) = NULL;
>   	struct scatterlist sg;
> @@ -2677,16 +2675,6 @@ static int _virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
>   	return 0;
>   }
>   
> -static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
> -{
> -	int err;
> -
> -	rtnl_lock();
> -	err = _virtnet_set_queues(vi, queue_pairs);
> -	rtnl_unlock();
> -	return err;
> -}
> -
>   static int virtnet_close(struct net_device *dev)
>   {
>   	struct virtnet_info *vi = netdev_priv(dev);
> @@ -3268,7 +3256,7 @@ static int virtnet_set_channels(struct net_device *dev,
>   		return -EINVAL;
>   
>   	cpus_read_lock();
> -	err = _virtnet_set_queues(vi, queue_pairs);
> +	err = virtnet_set_queues(vi, queue_pairs);
>   	if (err) {
>   		cpus_read_unlock();
>   		goto err;
> @@ -3558,14 +3546,11 @@ static void virtnet_rx_dim_work(struct work_struct *work)
>   	struct dim_cq_moder update_moder;
>   	int i, qnum, err;
>   
> -	if (!rtnl_trylock())
> -		return;
> -

Does this guarantee that the synchronization is completely correct?

The purpose of this patch set is to add a separate lock for ctrlq rather 
than reusing the RTNL lock.
But for dim workers, it not only involves the use of ctrlq, but also 
involves reading shared variables
in interfaces such as .set_coalesce, .get_coalesce, etc.

In addition, assuming there are 10 queues, each queue is scheduled with 
its own dim worker at the
same time, then these 10 workers may issue parameters to rxq0 10 times 
in parallel, just because
the RTNL lock is removed here.

Therefore, when the RTNL lock is removed, a 'for loop' is no longer 
needed in virtnet_rx_dim_work,
and the dim worker of each queue only configures its own parameters.

Alternatively, please keep RTNL lock here.

Regards,
Heng

>   	/* Each rxq's work is queued by "net_dim()->schedule_work()"
>   	 * in response to NAPI traffic changes. Note that dim->profile_ix
>   	 * for each rxq is updated prior to the queuing action.
>   	 * So we only need to traverse and update profiles for all rxqs
> -	 * in the work which is holding rtnl_lock.
> +	 * in the work.
>   	 */
>   	for (i = 0; i < vi->curr_queue_pairs; i++) {
>   		rq = &vi->rq[i];
> @@ -3587,8 +3572,6 @@ static void virtnet_rx_dim_work(struct work_struct *work)
>   			dim->state = DIM_START_MEASURE;
>   		}
>   	}
> -
> -	rtnl_unlock();
>   }
>   
>   static int virtnet_coal_params_supported(struct ethtool_coalesce *ec)
> @@ -4036,7 +4019,7 @@ static int virtnet_xdp_set(struct net_device *dev, struct bpf_prog *prog,
>   		synchronize_net();
>   	}
>   
> -	err = _virtnet_set_queues(vi, curr_qp + xdp_qp);
> +	err = virtnet_set_queues(vi, curr_qp + xdp_qp);
>   	if (err)
>   		goto err;
>   	netif_set_real_num_rx_queues(dev, curr_qp + xdp_qp);
> @@ -4852,7 +4835,7 @@ static int virtnet_probe(struct virtio_device *vdev)
>   
>   	virtio_device_ready(vdev);
>   
> -	_virtnet_set_queues(vi, vi->curr_queue_pairs);
> +	virtnet_set_queues(vi, vi->curr_queue_pairs);
>   
>   	/* a random MAC address has been assigned, notify the device.
>   	 * We don't fail probe if VIRTIO_NET_F_CTRL_MAC_ADDR is not there


