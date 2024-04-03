Return-Path: <netdev+bounces-84362-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 078CF896AF2
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 11:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 394421C21380
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 09:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8082134CF7;
	Wed,  3 Apr 2024 09:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="XzvMn8Fw"
X-Original-To: netdev@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060D4135411
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 09:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712137445; cv=none; b=SBJ4CcwM+B4GSheRp8pkXgjM/ihHXXBdtjWXL6bHybKXDsiKz4E19URFHl8CCAK77v32fDr6iQjuabQKzMEWIa2hiTRZA/eaz5QibWbx8azluiyXH8a7LlNZZb3OFl3lWUO8JNNw/0tYun6ufDI8nDAL4oSz19UAQYTfRPEj+JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712137445; c=relaxed/simple;
	bh=Fa2DMH6y0UbMft3xZMOCr4ybCYrylzPuBr0o9wc6ckM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JDIRoBvQ1bJ+R/9xv6V8o30xfvcM9VJdVHB4/3Rx+ayImU1Ug4BeW+UJ71Aq1c3SXcNgElYZthNUnw43VPJlyLkwtL4SioxO7g7YrRToR6oqYHR5/DljdA0I0I/VbwaYcU+B9IRW/isOyp1u7wt80IQdd3apquXlR/e7I/h/jik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=XzvMn8Fw; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712137440; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=fbU/cciztk5M6yzem4LuRwgLHdzo4qZWb8zEVpSSv3k=;
	b=XzvMn8FwqQYKyxwkTI79/0F6ewuP6mhT8/IyHFA1zV+EGHwqGwt3qiNYT5BGEzfgx7UQYW+i9WctIfkwTHL1cbPS3kprfRtecbt6RglhQYGn0VnRjdan85dqQu6K4spaC+iecGB9iHwl+vuSxADAU5T6vawDWHNI5/ULIE/PZrA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0W3rJiWU_1712137438;
Received: from 30.221.147.161(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W3rJiWU_1712137438)
          by smtp.aliyun-inc.com;
          Wed, 03 Apr 2024 17:44:00 +0800
Message-ID: <2695ca82-9358-4dbe-a253-e847e51f4a47@linux.alibaba.com>
Date: Wed, 3 Apr 2024 17:43:58 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 2/3] virtio-net: refactor dim
 initialization/destruction
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <1712059988-7705-1-git-send-email-hengqi@linux.alibaba.com>
 <1712059988-7705-3-git-send-email-hengqi@linux.alibaba.com>
 <20240402123656.GA1648445@maili.marvell.com>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <20240402123656.GA1648445@maili.marvell.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/4/2 下午8:36, Ratheesh Kannoth 写道:
> On 2024-04-02 at 17:43:07, Heng Qi (hengqi@linux.alibaba.com) wrote:
>> Extract the initialization and destruction actions
>> of dim for use in the next patch.
>>
>> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
>> ---
>>   drivers/net/virtio_net.c | 37 ++++++++++++++++++++++++++-----------
>>   1 file changed, 26 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> index e709d44..5c56fdc 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -2278,6 +2278,13 @@ static int virtnet_enable_queue_pair(struct virtnet_info *vi, int qp_index)
>>   	return err;
>>   }
>>
>> +static void virtnet_dim_clean(struct virtnet_info *vi,
>> +			      int start_qnum, int end_qnum)
>> +{
>> +	for (; start_qnum <= end_qnum; start_qnum++)
>> +		cancel_work_sync(&vi->rq[start_qnum].dim.work);
>> +}
>> +
>>   static int virtnet_open(struct net_device *dev)
>>   {
>>   	struct virtnet_info *vi = netdev_priv(dev);
>> @@ -2301,11 +2308,9 @@ static int virtnet_open(struct net_device *dev)
>>   err_enable_qp:
>>   	disable_delayed_refill(vi);
>>   	cancel_delayed_work_sync(&vi->refill);
>> -
>> -	for (i--; i >= 0; i--) {
>> +	virtnet_dim_clean(vi, 0, i);
>> +	for (i--; i >= 0; i--)
>>   		virtnet_disable_queue_pair(vi, i);
> Now function argument is  "i", not "i - 1".
> Is it intentional ? commit message did not indicate any fixes.

Will fix in next version.

Thanks.

>
>> -		cancel_work_sync(&vi->rq[i].dim.work);
>> -	}
>>
>>   	return err;
>>   }
>> @@ -2470,7 +2475,7 @@ static int virtnet_rx_resize(struct virtnet_info *vi,
>>
>>   	if (running) {
>>   		napi_disable(&rq->napi);
>> -		cancel_work_sync(&rq->dim.work);
>> +		virtnet_dim_clean(vi, qindex, qindex);
>>   	}
>>
>>   	err = virtqueue_resize(rq->vq, ring_num, virtnet_rq_unmap_free_buf);
>> @@ -2720,10 +2725,9 @@ static int virtnet_close(struct net_device *dev)
>>   	/* Make sure refill_work doesn't re-enable napi! */
>>   	cancel_delayed_work_sync(&vi->refill);
>>
>> -	for (i = 0; i < vi->max_queue_pairs; i++) {
>> +	virtnet_dim_clean(vi, 0, vi->max_queue_pairs - 1);
>> +	for (i = 0; i < vi->max_queue_pairs; i++)
>>   		virtnet_disable_queue_pair(vi, i);
>> -		cancel_work_sync(&vi->rq[i].dim.work);
>> -	}
>>
>>   	return 0;
>>   }
>> @@ -4422,6 +4426,19 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
>>   	return ret;
>>   }
>>
>> +static void virtnet_dim_init(struct virtnet_info *vi)
>> +{
>> +	int i;
>> +
>> +	if (!virtio_has_feature(vi->vdev, VIRTIO_NET_F_VQ_NOTF_COAL))
>> +		return;
>> +
>> +	for (i = 0; i < vi->max_queue_pairs; i++) {
>> +		INIT_WORK(&vi->rq[i].dim.work, virtnet_rx_dim_work);
>> +		vi->rq[i].dim.mode = DIM_CQ_PERIOD_MODE_START_FROM_EQE;
>> +	}
>> +}
>> +
>>   static int virtnet_alloc_queues(struct virtnet_info *vi)
>>   {
>>   	int i;
>> @@ -4441,6 +4458,7 @@ static int virtnet_alloc_queues(struct virtnet_info *vi)
>>   		goto err_rq;
>>
>>   	INIT_DELAYED_WORK(&vi->refill, refill_work);
>> +	virtnet_dim_init(vi);
>>   	for (i = 0; i < vi->max_queue_pairs; i++) {
>>   		vi->rq[i].pages = NULL;
>>   		netif_napi_add_weight(vi->dev, &vi->rq[i].napi, virtnet_poll,
>> @@ -4449,9 +4467,6 @@ static int virtnet_alloc_queues(struct virtnet_info *vi)
>>   					 virtnet_poll_tx,
>>   					 napi_tx ? napi_weight : 0);
>>
>> -		INIT_WORK(&vi->rq[i].dim.work, virtnet_rx_dim_work);
>> -		vi->rq[i].dim.mode = DIM_CQ_PERIOD_MODE_START_FROM_EQE;
>> -
>>   		sg_init_table(vi->rq[i].sg, ARRAY_SIZE(vi->rq[i].sg));
>>   		ewma_pkt_len_init(&vi->rq[i].mrg_avg_pkt_len);
>>   		sg_init_table(vi->sq[i].sg, ARRAY_SIZE(vi->sq[i].sg));
>> --
>> 1.8.3.1
>>


