Return-Path: <netdev+bounces-82454-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 685FD88DD04
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 13:00:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDA65B22B4F
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 12:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4806C83A1C;
	Wed, 27 Mar 2024 12:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="mY3r8opu"
X-Original-To: netdev@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F1745954
	for <netdev@vger.kernel.org>; Wed, 27 Mar 2024 12:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711540808; cv=none; b=fuJSXA1KpCdlwBSyTVViCJoVKMj0MCSTKJ4pZDhw8BZ6D9LTg4tLZjnTcnogUPlNGoOD4DHO0t4LhfFfhqsNM4aaRqeTPasZX3u27VKqLcLM3Fiv2HxWpmBQqi+6sX8bbbXvjd0ld2DEbTtEo4+bLqjnlEduIaFcGFngYVyfmR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711540808; c=relaxed/simple;
	bh=eA5GxF7TR+a6e/WOnrkvmh8TvpOLH+c/LG3f3FOpQD4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=P366FyNE3fLo/GT6Y7Kt43XGDeBGv6fLLzpJW3B7PLyB+QPuyrsOJ9/qvIGxo+HFmYk+x4lzJsHLOYQA2wkMHKMQyZL+V/3tb/hl2uRIfsR87TUtbyIsefIeTVM4VMrno/yta0+4q1Lj6wvrXEROWmzyESlh7IGl7ooMErdbSHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=mY3r8opu; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711540803; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=CB0OzCMu7QlIaYlEd0xg2JNuqwd+jMTOtU7SHTAlnlg=;
	b=mY3r8opu9ptZEUJ8TtnIwr0PIQy8PMxGxl9vcZHDSCIid6xibuH5+dkR3lcF7vsnvSA/MVRpi6OP10TF0hC/T6IMutJz5atzEM4BHRLZtfWzhus4uDyZPpOGkH/jmYkQQF6NlQEAHdGJPGsUA3qWl9+dqV2tmaaRRewSp38gm8k=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0W3OcvHX_1711540801;
Received: from 30.221.148.214(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W3OcvHX_1711540801)
          by smtp.aliyun-inc.com;
          Wed, 27 Mar 2024 20:00:02 +0800
Message-ID: <e03bf61e-22ab-4950-996c-9ce6e72b608b@linux.alibaba.com>
Date: Wed, 27 Mar 2024 20:00:00 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 4/4] virtio_net: Remove rtnl lock protection of
 command buffers
From: Heng Qi <hengqi@linux.alibaba.com>
To: Dan Jurgens <danielj@nvidia.com>
Cc: "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
 "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com"
 <pabeni@redhat.com>, Jiri Pirko <jiri@nvidia.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <20240325214912.323749-1-danielj@nvidia.com>
 <20240325214912.323749-5-danielj@nvidia.com>
 <11b6dac0-a18a-47ae-904d-cb9d29e1ca31@linux.alibaba.com>
 <CH0PR12MB8580B9701C9BD0B62FF04B77C9352@CH0PR12MB8580.namprd12.prod.outlook.com>
 <9c3656c0-bb73-4e96-9bd1-26e732f72781@linux.alibaba.com>
In-Reply-To: <9c3656c0-bb73-4e96-9bd1-26e732f72781@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/3/27 上午10:10, Heng Qi 写道:
>
>
> 在 2024/3/26 下午11:18, Dan Jurgens 写道:
>>> From: Heng Qi <hengqi@linux.alibaba.com>
>>> Sent: Tuesday, March 26, 2024 3:55 AM
>>> To: Dan Jurgens <danielj@nvidia.com>; netdev@vger.kernel.org
>>> Cc: mst@redhat.com; jasowang@redhat.com; xuanzhuo@linux.alibaba.com;
>>> virtualization@lists.linux.dev; davem@davemloft.net;
>>> edumazet@google.com; kuba@kernel.org; pabeni@redhat.com; Jiri Pirko
>>> <jiri@nvidia.com>
>>> Subject: Re: [PATCH net-next 4/4] virtio_net: Remove rtnl lock 
>>> protection of
>>> command buffers
>>>
>>>
>>>
>>> 在 2024/3/26 上午5:49, Daniel Jurgens 写道:
>>>> The rtnl lock is no longer needed to protect the control buffer and
>>>> command VQ.
>>>>
>>>> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
>>>> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
>>>> ---
>>>>    drivers/net/virtio_net.c | 27 +++++----------------------
>>>>    1 file changed, 5 insertions(+), 22 deletions(-)
>>>>
>>>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c index
>>>> 41f8dc16ff38..d09ea20b16be 100644
>>>> --- a/drivers/net/virtio_net.c
>>>> +++ b/drivers/net/virtio_net.c
>>>> @@ -2639,14 +2639,12 @@ static void virtnet_stats(struct net_device
>>>> *dev,
>>>>
>>>>    static void virtnet_ack_link_announce(struct virtnet_info *vi)
>>>>    {
>>>> -    rtnl_lock();
>>>>        if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_ANNOUNCE,
>>>>                      VIRTIO_NET_CTRL_ANNOUNCE_ACK,
>>> NULL))
>>>> dev_warn(&vi->dev->dev, "Failed to ack link announce.\n");
>>>> -    rtnl_unlock();
>>>>    }
>>>>
>>>> -static int _virtnet_set_queues(struct virtnet_info *vi, u16
>>>> queue_pairs)
>>>> +static int virtnet_set_queues(struct virtnet_info *vi, u16
>>>> +queue_pairs)
>>>>    {
>>>>        struct virtio_net_ctrl_mq *mq __free(kfree) = NULL;
>>>>        struct scatterlist sg;
>>>> @@ -2677,16 +2675,6 @@ static int _virtnet_set_queues(struct
>>> virtnet_info *vi, u16 queue_pairs)
>>>>        return 0;
>>>>    }
>>>>
>>>> -static int virtnet_set_queues(struct virtnet_info *vi, u16
>>>> queue_pairs) -{
>>>> -    int err;
>>>> -
>>>> -    rtnl_lock();
>>>> -    err = _virtnet_set_queues(vi, queue_pairs);
>>>> -    rtnl_unlock();
>>>> -    return err;
>>>> -}
>>>> -
>>>>    static int virtnet_close(struct net_device *dev)
>>>>    {
>>>>        struct virtnet_info *vi = netdev_priv(dev); @@ -3268,7 
>>>> +3256,7 @@
>>>> static int virtnet_set_channels(struct net_device *dev,
>>>>            return -EINVAL;
>>>>
>>>>        cpus_read_lock();
>>>> -    err = _virtnet_set_queues(vi, queue_pairs);
>>>> +    err = virtnet_set_queues(vi, queue_pairs);
>>>>        if (err) {
>>>>            cpus_read_unlock();
>>>>            goto err;
>>>> @@ -3558,14 +3546,11 @@ static void virtnet_rx_dim_work(struct
>>> work_struct *work)
>>>>        struct dim_cq_moder update_moder;
>>>>        int i, qnum, err;
>>>>
>>>> -    if (!rtnl_trylock())
>>>> -        return;
>>>> -
>>> Does this guarantee that the synchronization is completely correct?
>>>
>>> The purpose of this patch set is to add a separate lock for ctrlq 
>>> rather than
>>> reusing the RTNL lock.
>>> But for dim workers, it not only involves the use of ctrlq, but also 
>>> involves
>>> reading shared variables in interfaces such as .set_coalesce, 
>>> .get_coalesce,
>>> etc.
>> It looks like there is a risk of a dirty read in the get (usecs 
>> updated, but not max_packets).
>
> Also dim_enabled.
>
> And later I need to asynchronousize the dim cmds, which means that
> different dim workers will operate a shared linked list.
>
> So we need a lock.

After removing the loop, maybe READ_ONCE/WRITE_ONCE will be enough?

>
>>   In the set it will return -EINVAL if trying to adjust the settings 
>> aside from DIM enabled.  I can add a lock for this if you think it's 
>> needed, but it doesn't seem like a major problem for debug info.
>
> Not just for debug info, but future extensions as well.
>
> These desynchronizations can introduce more trouble in the future.
>
> Regards,
> Heng
>
>>
>>
>>> In addition, assuming there are 10 queues, each queue is scheduled 
>>> with its
>>> own dim worker at the same time, then these 10 workers may issue
>>> parameters to rxq0 10 times in parallel, just because the RTNL lock is
>>> removed here.
>>>
>>> Therefore, when the RTNL lock is removed, a 'for loop' is no longer 
>>> needed in
>>> virtnet_rx_dim_work, and the dim worker of each queue only 
>>> configures its
>>> own parameters.
>>>
>> Good point. I'll add a new patch to remove the for loop.
>>
>>> Alternatively, please keep RTNL lock here.
>>>
>>> Regards,
>>> Heng
>>>
>>>>        /* Each rxq's work is queued by "net_dim()->schedule_work()"
>>>>         * in response to NAPI traffic changes. Note that 
>>>> dim->profile_ix
>>>>         * for each rxq is updated prior to the queuing action.
>>>>         * So we only need to traverse and update profiles for all rxqs
>>>> -     * in the work which is holding rtnl_lock.
>>>> +     * in the work.
>>>>         */
>>>>        for (i = 0; i < vi->curr_queue_pairs; i++) {
>>>>            rq = &vi->rq[i];
>>>> @@ -3587,8 +3572,6 @@ static void virtnet_rx_dim_work(struct
>>> work_struct *work)
>>>>                dim->state = DIM_START_MEASURE;
>>>>            }
>>>>        }
>>>> -
>>>> -    rtnl_unlock();
>>>>    }
>>>>
>>>>    static int virtnet_coal_params_supported(struct ethtool_coalesce
>>>> *ec) @@ -4036,7 +4019,7 @@ static int virtnet_xdp_set(struct 
>>>> net_device
>>> *dev, struct bpf_prog *prog,
>>>>            synchronize_net();
>>>>        }
>>>>
>>>> -    err = _virtnet_set_queues(vi, curr_qp + xdp_qp);
>>>> +    err = virtnet_set_queues(vi, curr_qp + xdp_qp);
>>>>        if (err)
>>>>            goto err;
>>>>        netif_set_real_num_rx_queues(dev, curr_qp + xdp_qp); @@ -
>>> 4852,7
>>>> +4835,7 @@ static int virtnet_probe(struct virtio_device *vdev)
>>>>
>>>>        virtio_device_ready(vdev);
>>>>
>>>> -    _virtnet_set_queues(vi, vi->curr_queue_pairs);
>>>> +    virtnet_set_queues(vi, vi->curr_queue_pairs);
>>>>
>>>>        /* a random MAC address has been assigned, notify the device.
>>>>         * We don't fail probe if VIRTIO_NET_F_CTRL_MAC_ADDR is not
>>> there
>


