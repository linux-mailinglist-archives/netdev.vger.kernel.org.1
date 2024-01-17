Return-Path: <netdev+bounces-63893-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8277E82FF4B
	for <lists+netdev@lfdr.de>; Wed, 17 Jan 2024 04:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6B3FB22059
	for <lists+netdev@lfdr.de>; Wed, 17 Jan 2024 03:34:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF15367C7E;
	Wed, 17 Jan 2024 03:34:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038A31C0F
	for <netdev@vger.kernel.org>; Wed, 17 Jan 2024 03:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705462482; cv=none; b=HLbqsUK8Lcj6dZpnzFuUuHiFwrbQMgq9OQElt9nB4HmaWXj4lesTe7OBChPwcX+KtRdKRjJmvPBjWmF+gxwdamAYmh3t//sml0kuWmymYaEj+w15eZdMbvE/3krmfp7M/YkwQ2OqB5LU1tF8gYrV392TmMYdWQDOauS2OLNfiq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705462482; c=relaxed/simple;
	bh=VXbXBLgQ2O/qIZVsmjuPj5yhMpXMbVfc7MP1xeLPetA=;
	h=X-Alimail-AntiSpam:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=Iov5DJyaHxtfb+FYbWBBsrUaPXO03nLOaWXatDDbTPq0gqlMzPgXIhcUmLpwIvxspIeMx9hYwE2EMpptHYtMp/2jx+x2ndrUU6T6K6ndt56r+fCWe0bPWql3uPd3apYQDJ8VoS4O/AmSc01UKvBKVFNNs7L2wL7iobMxrWDBFks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W-nmzeT_1705462476;
Received: from 30.221.149.120(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W-nmzeT_1705462476)
          by smtp.aliyun-inc.com;
          Wed, 17 Jan 2024 11:34:37 +0800
Message-ID: <c3d23a1d-eb26-4da8-91c6-99097e4cfc31@linux.alibaba.com>
Date: Wed, 17 Jan 2024 11:34:35 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/3] virtio-net: fix possible dim status
 unrecoverable
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev,
 Jason Wang <jasowang@redhat.com>, Paolo Abeni <pabeni@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
 "David S. Miller" <davem@davemloft.net>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <1705410693-118895-1-git-send-email-hengqi@linux.alibaba.com>
 <1705410693-118895-2-git-send-email-hengqi@linux.alibaba.com>
 <20240116081442-mutt-send-email-mst@kernel.org>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <20240116081442-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/1/16 下午9:15, Michael S. Tsirkin 写道:
> On Tue, Jan 16, 2024 at 09:11:31PM +0800, Heng Qi wrote:
>> When the dim worker is scheduled, if it fails to acquire the lock,
>> dim may not be able to return to the working state later.
>>
>> For example, the following single queue scenario:
>>    1. The dim worker of rxq0 is scheduled, and the dim status is
>>       changed to DIM_APPLY_NEW_PROFILE;
>>    2. The ethtool command is holding rtnl lock;
>>    3. Since the rtnl lock is already held, virtnet_rx_dim_work fails
>>       to acquire the lock and exits;
>>
>> Then, even if net_dim is invoked again, it cannot work because the
>> state is not restored to DIM_START_MEASURE.
>>
>> Fixes: 6208799553a8 ("virtio-net: support rx netdim")
>> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
>> ---
>> Belongs to the net branch.
>>
>>   drivers/net/virtio_net.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> index d7ce4a1..f6ac3e7 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -3524,8 +3524,10 @@ static void virtnet_rx_dim_work(struct work_struct *work)
>>   	struct dim_cq_moder update_moder;
>>   	int i, qnum, err;
>>   
>> -	if (!rtnl_trylock())
>> +	if (!rtnl_trylock()) {
>> +		schedule_work(&dim->work);
>>   		return;
>> +	}
>>   
>>   	/* Each rxq's work is queued by "net_dim()->schedule_work()"
>>   	 * in response to NAPI traffic changes. Note that dim->profile_ix
> OK but this means that in cleanup it is not sufficient to flush
> dim work - it can requeue itself.

We did not use the flush work operation, cancel_work_sync will handle 
the re-queue situation:

    "Cancel @work and wait for its execution to finish. This function
    can be used even if the work re-queues itself or migrates to
    another workqueue. On return from this function, @work is
    guaranteed to be not pending or executing on any CPU."

Thanks.

>
>
>> -- 
>> 1.8.3.1


