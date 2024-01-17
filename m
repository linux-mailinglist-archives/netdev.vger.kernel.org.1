Return-Path: <netdev+bounces-63894-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE0D282FF59
	for <lists+netdev@lfdr.de>; Wed, 17 Jan 2024 04:39:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C68D1F24DA5
	for <lists+netdev@lfdr.de>; Wed, 17 Jan 2024 03:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3764B8C02;
	Wed, 17 Jan 2024 03:38:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108AF67C7D
	for <netdev@vger.kernel.org>; Wed, 17 Jan 2024 03:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705462730; cv=none; b=NZOJyICnf5dTizarcPasYakmPDnhJO0IfdpK40muMqCxqeflD3/hBsLZPuR8OUYQrCwxknRGX8OiND2xVbi4fWR8tQMsN0MqQiXRqUA0dboVqbn067ltiwzC0OE1QQLnTqaTuLbQpE7w8U0KOz1Uvxoxk+CmV4N9blRvN8JVfIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705462730; c=relaxed/simple;
	bh=KC4+acKhrL/06D2tmhrp7SHPW1FrF+ACnsOa9gzD2CM=;
	h=X-Alimail-AntiSpam:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=g1aFr6c2jCjOfXC1zGQL0I0VE4DR0jhUEIeGDip1j98IuA7JREriJvFcjP7T3xNKhy+HBJoCSMDryubXOxtPiRmaU55YnZkPxktpxIL99t0UTm/QCChL2NvlxCABedq9+dBb9osSTzOVLNNJKKb6yeHlU6v3kqBZ5Llxzb1ovIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0W-o17h9_1705462724;
Received: from 30.221.149.120(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W-o17h9_1705462724)
          by smtp.aliyun-inc.com;
          Wed, 17 Jan 2024 11:38:45 +0800
Message-ID: <1f73d1b6-d240-422f-b071-358ed5902747@linux.alibaba.com>
Date: Wed, 17 Jan 2024 11:38:44 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/3] virtio-net: batch dim request
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev,
 Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <1705410693-118895-1-git-send-email-hengqi@linux.alibaba.com>
 <1705410693-118895-3-git-send-email-hengqi@linux.alibaba.com>
 <20240116194912.GE588419@kernel.org>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <20240116194912.GE588419@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/1/17 上午3:49, Simon Horman 写道:
> On Tue, Jan 16, 2024 at 09:11:32PM +0800, Heng Qi wrote:
>> Currently, when each time the driver attempts to update the coalescing
>> parameters for a vq, it needs to kick the device.
>> The following path is observed:
>>    1. Driver kicks the device;
>>    2. After the device receives the kick, CPU scheduling occurs and DMA
>>       multiple buffers multiple times;
>>    3. The device completes processing and replies with a response.
>>
>> When large-queue devices issue multiple requests and kick the device
>> frequently, this often interrupt the work of the device-side CPU.
>> In addition, each vq request is processed separately, causing more
>> delays for the CPU to wait for the DMA request to complete.
>>
>> These interruptions and overhead will strain the CPU responsible for
>> controlling the path of the DPU, especially in multi-device and
>> large-queue scenarios.
>>
>> To solve the above problems, we internally tried batch request,
>> which merges requests from multiple queues and sends them at once.
>> We conservatively tested 8 queue commands and sent them together.
>> The DPU processing efficiency can be improved by 8 times, which
>> greatly eases the DPU's support for multi-device and multi-queue DIM.
>>
>> Suggested-by: Xiaoming Zhao <zxm377917@alibaba-inc.com>
>> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> ...
>
>> @@ -3546,16 +3552,32 @@ static void virtnet_rx_dim_work(struct work_struct *work)
>>   		update_moder = net_dim_get_rx_moderation(dim->mode, dim->profile_ix);
>>   		if (update_moder.usec != rq->intr_coal.max_usecs ||
>>   		    update_moder.pkts != rq->intr_coal.max_packets) {
>> -			err = virtnet_send_rx_ctrl_coal_vq_cmd(vi, qnum,
>> -							       update_moder.usec,
>> -							       update_moder.pkts);
>> -			if (err)
>> -				pr_debug("%s: Failed to send dim parameters on rxq%d\n",
>> -					 dev->name, qnum);
>> -			dim->state = DIM_START_MEASURE;
>> +			coal->coal_vqs[j].vqn = cpu_to_le16(rxq2vq(i));
>> +			coal->coal_vqs[j].coal.max_usecs = cpu_to_le32(update_moder.usec);
>> +			coal->coal_vqs[j].coal.max_packets = cpu_to_le32(update_moder.pkts);
>> +			rq->intr_coal.max_usecs = update_moder.usec;
>> +			rq->intr_coal.max_packets = update_moder.pkts;
>> +			j++;
>>   		}
>>   	}
>>   
>> +	if (!j)
>> +		goto ret;
>> +
>> +	coal->num_entries = cpu_to_le32(j);
>> +	sg_init_one(&sgs, coal, sizeof(struct virtnet_batch_coal) +
>> +		    j * sizeof(struct virtio_net_ctrl_coal_vq));
>> +	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_NOTF_COAL,
>> +				  VIRTIO_NET_CTRL_NOTF_COAL_VQS_SET,
>> +				  &sgs))
>> +		dev_warn(&vi->vdev->dev, "Failed to add dim command\n.");
>> +
>> +	for (i = 0; i < j; i++) {
>> +		rq = &vi->rq[(coal->coal_vqs[i].vqn) / 2];
> Hi Heng Qi,
>
> The type of .vqn is __le16, but here it is used as an
> integer in host byte order. Perhaps this should be (completely untested!):
>
> 		rq = &vi->rq[le16_to_cpu(coal->coal_vqs[i].vqn) / 2];

Hi Simon,

Thanks for the catch, I will check this out.

>
>> +		rq->dim.state = DIM_START_MEASURE;
>> +	}
>> +
>> +ret:
>>   	rtnl_unlock();
>>   }
>>   


