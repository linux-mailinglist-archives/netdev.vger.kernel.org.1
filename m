Return-Path: <netdev+bounces-59654-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2391A81B9A4
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 15:34:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F23A1F21B01
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 14:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41108846B;
	Thu, 21 Dec 2023 14:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JdkrmPQQ"
X-Original-To: netdev@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740C0816
	for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 14:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7b3b6c67-05e0-4a90-8142-66f055e15d83@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1703169276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e6iOTHH/qin4z7nteRbrVZQnh9ljwpfWeOWXpZKN3Zc=;
	b=JdkrmPQQ6P9zXTmRJkJGRSA7QblRDYiBvB77/9C1sp5dKOestp+db8LAbS6S72Drc/3THZ
	l5FbH03BUo8v2GgKBKg2U02H24wACnFJQkvl4EiVOGiRbpFr7XgQV3aazYbbquxcU11YmI
	6XVnU7TY9fq49kYGJd3vdWenWe9WcHY=
Date: Thu, 21 Dec 2023 22:34:29 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next] virtio-net: switch napi_tx without downing nic
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 netdev@vger.kernel.org, virtualization@lists.linux-foundation.org
References: <f9f7d28624f8084ef07842ee569c22b324ee4055.1703059341.git.hengqi@linux.alibaba.com>
 <d26c6d0b-92a1-4baa-bceb-dc267b5b60e6@linux.dev>
 <46097ac2-c498-4b9f-898f-27ef097b9c85@linux.alibaba.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <46097ac2-c498-4b9f-898f-27ef097b9c85@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2023/12/21 13:20, Heng Qi 写道:
>
>
> 在 2023/12/21 上午11:02, Zhu Yanjun 写道:
>> 在 2023/12/20 16:07, Heng Qi 写道:
>>> virtio-net has two ways to switch napi_tx: one is through the
>>> module parameter, and the other is through coalescing parameter
>>> settings (provided that the nic status is down).
>>>
>>> Sometimes we face performance regression caused by napi_tx,
>>> then we need to switch napi_tx when debugging. However, the
>>> existing methods are a bit troublesome, such as needing to
>>> reload the driver or turn off the network card. So try to make
>>> this update.
>>
>> What scenario can trigger this? We want to make tests on our device.
>
> Hi Zhu Yanjun, you can use the following cmds:
>
> ethtool -C tx-frames 0, to disable napi_tx
> ethtool -C tx-frames 1, to enable napi_tx


Thanks a lot. Just now I made tests on our device. I confirmed that 
virtion_net driver can work well after running "ethtool -C NIC tx-frames 
0 && sleep 3 && ethtool -C NIC tx-frames 1".

You can add "Reviewed-and-tested-by: Zhu Yanjun <yanjun.zhu@linux.dev>"

Thanks,

Zhu Yanjun

>
> Thanks.
>
>>
>> Zhu Yanjun
>>
>>>
>>> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
>>> Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>>> ---
>>>   drivers/net/virtio_net.c | 81 
>>> ++++++++++++++++++----------------------
>>>   1 file changed, 37 insertions(+), 44 deletions(-)
>>>
>>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>>> index 10614e9f7cad..12f8e1f9971c 100644
>>> --- a/drivers/net/virtio_net.c
>>> +++ b/drivers/net/virtio_net.c
>>> @@ -3559,16 +3559,37 @@ static int 
>>> virtnet_coal_params_supported(struct ethtool_coalesce *ec)
>>>       return 0;
>>>   }
>>>   -static int virtnet_should_update_vq_weight(int dev_flags, int 
>>> weight,
>>> -                       int vq_weight, bool *should_update)
>>> +static void virtnet_switch_napi_tx(struct virtnet_info *vi, u32 
>>> qstart,
>>> +                   u32 qend, u32 tx_frames)
>>>   {
>>> -    if (weight ^ vq_weight) {
>>> -        if (dev_flags & IFF_UP)
>>> -            return -EBUSY;
>>> -        *should_update = true;
>>> -    }
>>> +    struct net_device *dev = vi->dev;
>>> +    int new_weight, cur_weight;
>>> +    struct netdev_queue *txq;
>>> +    struct send_queue *sq;
>>>   -    return 0;
>>> +    new_weight = tx_frames ? NAPI_POLL_WEIGHT : 0;
>>> +    for (; qstart < qend; qstart++) {
>>> +        sq = &vi->sq[qstart];
>>> +        cur_weight = sq->napi.weight;
>>> +        if (!(new_weight ^ cur_weight))
>>> +            continue;
>>> +
>>> +        if (!(dev->flags & IFF_UP)) {
>>> +            sq->napi.weight = new_weight;
>>> +            continue;
>>> +        }
>>> +
>>> +        if (cur_weight)
>>> +            virtnet_napi_tx_disable(&sq->napi);
>>> +
>>> +        txq = netdev_get_tx_queue(dev, qstart);
>>> +        __netif_tx_lock_bh(txq);
>>> +        sq->napi.weight = new_weight;
>>> +        __netif_tx_unlock_bh(txq);
>>> +
>>> +        if (!cur_weight)
>>> +            virtnet_napi_tx_enable(vi, sq->vq, &sq->napi);
>>> +    }
>>>   }
>>>     static int virtnet_set_coalesce(struct net_device *dev,
>>> @@ -3577,25 +3598,11 @@ static int virtnet_set_coalesce(struct 
>>> net_device *dev,
>>>                   struct netlink_ext_ack *extack)
>>>   {
>>>       struct virtnet_info *vi = netdev_priv(dev);
>>> -    int ret, queue_number, napi_weight;
>>> -    bool update_napi = false;
>>> -
>>> -    /* Can't change NAPI weight if the link is up */
>>> -    napi_weight = ec->tx_max_coalesced_frames ? NAPI_POLL_WEIGHT : 0;
>>> -    for (queue_number = 0; queue_number < vi->max_queue_pairs; 
>>> queue_number++) {
>>> -        ret = virtnet_should_update_vq_weight(dev->flags, napi_weight,
>>> - vi->sq[queue_number].napi.weight,
>>> -                              &update_napi);
>>> -        if (ret)
>>> -            return ret;
>>> -
>>> -        if (update_napi) {
>>> -            /* All queues that belong to [queue_number, 
>>> vi->max_queue_pairs] will be
>>> -             * updated for the sake of simplicity, which might not 
>>> be necessary
>>> -             */
>>> -            break;
>>> -        }
>>> -    }
>>> +    int ret;
>>> +
>>> +    /* Param tx_frames can be used to switch napi_tx */
>>> +    virtnet_switch_napi_tx(vi, 0, vi->max_queue_pairs,
>>> +                   ec->tx_max_coalesced_frames);
>>>         if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_NOTF_COAL))
>>>           ret = virtnet_send_notf_coal_cmds(vi, ec);
>>> @@ -3605,11 +3612,6 @@ static int virtnet_set_coalesce(struct 
>>> net_device *dev,
>>>       if (ret)
>>>           return ret;
>>>   -    if (update_napi) {
>>> -        for (; queue_number < vi->max_queue_pairs; queue_number++)
>>> -            vi->sq[queue_number].napi.weight = napi_weight;
>>> -    }
>>> -
>>>       return ret;
>>>   }
>>>   @@ -3641,19 +3643,13 @@ static int 
>>> virtnet_set_per_queue_coalesce(struct net_device *dev,
>>>                         struct ethtool_coalesce *ec)
>>>   {
>>>       struct virtnet_info *vi = netdev_priv(dev);
>>> -    int ret, napi_weight;
>>> -    bool update_napi = false;
>>> +    int ret;
>>>         if (queue >= vi->max_queue_pairs)
>>>           return -EINVAL;
>>>   -    /* Can't change NAPI weight if the link is up */
>>> -    napi_weight = ec->tx_max_coalesced_frames ? NAPI_POLL_WEIGHT : 0;
>>> -    ret = virtnet_should_update_vq_weight(dev->flags, napi_weight,
>>> -                          vi->sq[queue].napi.weight,
>>> -                          &update_napi);
>>> -    if (ret)
>>> -        return ret;
>>> +    /* Param tx_frames can be used to switch napi_tx */
>>> +    virtnet_switch_napi_tx(vi, queue, queue, 
>>> ec->tx_max_coalesced_frames);
>>>         if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_VQ_NOTF_COAL))
>>>           ret = virtnet_send_notf_coal_vq_cmds(vi, ec, queue);
>>> @@ -3663,9 +3659,6 @@ static int 
>>> virtnet_set_per_queue_coalesce(struct net_device *dev,
>>>       if (ret)
>>>           return ret;
>>>   -    if (update_napi)
>>> -        vi->sq[queue].napi.weight = napi_weight;
>>> -
>>>       return 0;
>>>   }
>

