Return-Path: <netdev+bounces-82724-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3098388F6D6
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 05:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9F311F28650
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 04:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC9E36120;
	Thu, 28 Mar 2024 04:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="lUzc5/sk"
X-Original-To: netdev@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31894620
	for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 04:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711601848; cv=none; b=YujK66akv00o5B7V4kRCOhnfT+E3EDglKTCubP82ik7TiBVvah3g/E+jJ3QkyvOQ4EgzzbAaosenUGk9nLGQb6wUJmqkSZ1sVfzm3vQT8cbHAUnCfD7qs3Xz7UcWX4sLWLxm0GxYn6JSlMhz4/W0aBitoTX6bcCdIY1qFdnEGm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711601848; c=relaxed/simple;
	bh=VcMYQWHoBF1F4k5t3WGuhWgJSTjHqw/oyvR6aL/X6hw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HO0IoC0i4jATYU5Fkv3zoJlWrfxjpemDvrygu8fGtWOFZBY/SR+mrO6K3baG0mUvWJcEWY2BGRZxUMi6dhPwlhNeslk9bB+83gNsGuFXJqXVilqf/BAR8ipqv78y24erPUoXc9Sa9R2MVMOOOOjH4R2CZDRrsL9ulu6OmfTSojw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=lUzc5/sk; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711601842; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=ITjd5rwq3pXXuBXZcWEtftCUHivaqfaASfCSIfb6WQU=;
	b=lUzc5/skJ4pobFiVC0P0/fzsAxpPOX5/SY+riCQQaizPfO3BnCqCb7fW8SZ1ifOVMsX89MaAcddLuUaIZEQlFHN3V2Zg+WSe8R7+3OK8whUs9AOBPWt8Mouz3pl954Pcwi4VeZjaDJNZzPEf5jUEC/mO6nsU1Z6K9bjKSK//lCo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0W3QoJqF_1711601840;
Received: from 30.221.148.146(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W3QoJqF_1711601840)
          by smtp.aliyun-inc.com;
          Thu, 28 Mar 2024 12:57:22 +0800
Message-ID: <c8afda58-95ce-4d85-aa4a-5f4ed7c6ce9f@linux.alibaba.com>
Date: Thu, 28 Mar 2024 12:57:19 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 4/6] virtio_net: Do DIM update for specified
 queue only
To: Daniel Jurgens <danielj@nvidia.com>, netdev@vger.kernel.org
Cc: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
 virtualization@lists.linux.dev, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, jiri@nvidia.com
References: <20240328044715.266641-1-danielj@nvidia.com>
 <20240328044715.266641-5-danielj@nvidia.com>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <20240328044715.266641-5-danielj@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/3/28 下午12:47, Daniel Jurgens 写道:
> Since we no longer have to hold the RTNL lock here just do updates for
> the specified queue.
>
> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
> ---
>   drivers/net/virtio_net.c | 38 ++++++++++++++------------------------
>   1 file changed, 14 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index b9298544b1b5..9c4bfb1eb15c 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -3596,36 +3596,26 @@ static void virtnet_rx_dim_work(struct work_struct *work)
>   	struct virtnet_info *vi = rq->vq->vdev->priv;
>   	struct net_device *dev = vi->dev;
>   	struct dim_cq_moder update_moder;
> -	int i, qnum, err;
> +	int qnum, err;
>   
>   	if (!rtnl_trylock())
>   		return;
>   
> -	/* Each rxq's work is queued by "net_dim()->schedule_work()"
> -	 * in response to NAPI traffic changes. Note that dim->profile_ix
> -	 * for each rxq is updated prior to the queuing action.
> -	 * So we only need to traverse and update profiles for all rxqs
> -	 * in the work which is holding rtnl_lock.
> -	 */
> -	for (i = 0; i < vi->curr_queue_pairs; i++) {
> -		rq = &vi->rq[i];
> -		dim = &rq->dim;
> -		qnum = rq - vi->rq;
> +	qnum = rq - vi->rq;
>   
> -		if (!rq->dim_enabled)
> -			continue;
> +	if (!rq->dim_enabled)
> +		continue;

?

continue what?

For the lock code, please pass the test. It's important.

Regards,
Heng

>   
> -		update_moder = net_dim_get_rx_moderation(dim->mode, dim->profile_ix);
> -		if (update_moder.usec != rq->intr_coal.max_usecs ||
> -		    update_moder.pkts != rq->intr_coal.max_packets) {
> -			err = virtnet_send_rx_ctrl_coal_vq_cmd(vi, qnum,
> -							       update_moder.usec,
> -							       update_moder.pkts);
> -			if (err)
> -				pr_debug("%s: Failed to send dim parameters on rxq%d\n",
> -					 dev->name, qnum);
> -			dim->state = DIM_START_MEASURE;
> -		}
> +	update_moder = net_dim_get_rx_moderation(dim->mode, dim->profile_ix);
> +	if (update_moder.usec != rq->intr_coal.max_usecs ||
> +	    update_moder.pkts != rq->intr_coal.max_packets) {
> +		err = virtnet_send_rx_ctrl_coal_vq_cmd(vi, qnum,
> +						       update_moder.usec,
> +						       update_moder.pkts);
> +		if (err)
> +			pr_debug("%s: Failed to send dim parameters on rxq%d\n",
> +				 dev->name, qnum);
> +		dim->state = DIM_START_MEASURE;
>   	}
>   
>   	rtnl_unlock();


