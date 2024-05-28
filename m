Return-Path: <netdev+bounces-98511-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C788D1A21
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 13:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7470D1C211DD
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 11:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC8616C6B1;
	Tue, 28 May 2024 11:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="K+QnNgUO"
X-Original-To: netdev@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F3116C856
	for <netdev@vger.kernel.org>; Tue, 28 May 2024 11:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716896801; cv=none; b=cHyCo/Ik1jPmpxLhoMCRKg9dDYJhTPbsTRwtMkAkhz9jxa6p89FKT1vv7J5tJN3p2dcVXqI6jhzqJnhdRWWZj4kb8H67xCmMztLl+wncK3cynOLDcqzwCs5V8HshUr2KPyXqE0qDxHkr9gQg2hByEzr6qKirEYTO2IObcvAA1bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716896801; c=relaxed/simple;
	bh=5X2a2fVYGAa/BCC1AgPsR8+eFARh/NPdsTWDOOM1arg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qnPkgHIjmyUMMtTd4UFwrprArGcZL52gcDM1/VHi/0O9VRoCntHnITv4NCsnbpB3BZtUY3BiDmNyOym49NSpUnmdJVlbnUCA17Mx8hbcM+ImJCMOmdMFv2UYFHYxcDB5e4mWrbUdD+lcpmTDgkNQHsJxlih/AGOabrcA9CSnkVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=K+QnNgUO; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1716896796; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=s/JIHDkoxLXL+3UZcc69yu2RhlbrrvGxGOjDh5DZJ1M=;
	b=K+QnNgUOXv0FatZ0E4OSOtpbplVHdt5vwwhu/cD9sVc6Llljb4mgDaSoT8B+FxyuLQ76io0Fduot+6zWrS9uvUeoFsTseMQfFXlssAU/U6m/m/lkqx6o2A0J9IS8dSiPCSvT5aLY9YpBvRX9jE7bGwP9zDFRdMSasaGBWLH7b0A=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045046011;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0W7PWm.1_1716896794;
Received: from 30.221.148.249(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W7PWm.1_1716896794)
          by smtp.aliyun-inc.com;
          Tue, 28 May 2024 19:46:35 +0800
Message-ID: <60f1f487-427e-4ad7-8da6-d61d364e55ad@linux.alibaba.com>
Date: Tue, 28 May 2024 19:46:33 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 2/2] Revert "virtio_net: Add a lock for per queue
 RX coalesce"
To: Paolo Abeni <pabeni@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
 netdev@vger.kernel.org, virtualization@lists.linux.dev
References: <20240523074651.3717-1-hengqi@linux.alibaba.com>
 <20240523074651.3717-3-hengqi@linux.alibaba.com>
 <a8b15f50960e15ba37c213169473f1b1d893f9e0.camel@redhat.com>
 <1716865564.880848-2-hengqi@linux.alibaba.com>
 <c443d5d84fc32beb6e11c6dd5fa506abcd6b4fc4.camel@redhat.com>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <c443d5d84fc32beb6e11c6dd5fa506abcd6b4fc4.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2024/5/28 下午6:04, Paolo Abeni 写道:
> On Tue, 2024-05-28 at 11:06 +0800, Heng Qi wrote:
>> On Mon, 27 May 2024 12:42:43 +0200, Paolo Abeni <pabeni@redhat.com> wrote:
>>> On Thu, 2024-05-23 at 15:46 +0800, Heng Qi wrote:
>>>> This reverts commit 4d4ac2ececd3c42a08dd32a6e3a4aaf25f7efe44.
>>>>
>>>> When the following snippet is run, lockdep will report a deadlock[1].
>>>>
>>>>    /* Acquire all queues dim_locks */
>>>>    for (i = 0; i < vi->max_queue_pairs; i++)
>>>>            mutex_lock(&vi->rq[i].dim_lock);
>>>>
>>>> There's no deadlock here because the vq locks are always taken
>>>> in the same order, but lockdep can not figure it out, and we
>>>> can not make each lock a separate class because there can be more
>>>> than MAX_LOCKDEP_SUBCLASSES of vqs.
>>>>
>>>> However, dropping the lock is harmless:
>>>>    1. If dim is enabled, modifications made by dim worker to coalescing
>>>>       params may cause the user's query results to be dirty data.
>>> It looks like the above can confuse the user-space/admin?
>> Maybe, but we don't seem to guarantee this --
>> the global query interface (.get_coalesce) cannot
>> guarantee correct results when the DIM and .get_per_queue_coalesce are present:
>>
>> 1. DIM has been around for a long time (it will modify the per-queue parameters),
>>     but many nics only have interfaces for querying global parameters.
>> 2. Some nics provide the .get_per_queue_coalesce interface, it is not
>>     synchronized with DIM.
>>
>> So I think this is acceptable.
> Yes, the above sounds acceptable to me.
>
>>> Have you considered instead re-factoring
>>> virtnet_send_rx_notf_coal_cmds() to avoid acquiring all the mutex in
>>> sequence?
>> Perhaps it is a way to not traverse and update the parameters of each queue
>> in the global settings interface.
> I'm wondering if something as dumb as the following would suffice? Not
> even compile-tested.

This alleviates the problem, and l would like to repost this fix.

Thanks.
> ---
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 4a802c0ea2cb..d844f4c89152 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -4267,27 +4267,27 @@ static int virtnet_send_rx_notf_coal_cmds(struct virtnet_info *vi,
>   			       ec->rx_max_coalesced_frames != vi->intr_coal_rx.max_packets))
>   		return -EINVAL;
>   
> -	/* Acquire all queues dim_locks */
> -	for (i = 0; i < vi->max_queue_pairs; i++)
> -		mutex_lock(&vi->rq[i].dim_lock);
> -
>   	if (rx_ctrl_dim_on && !vi->rx_dim_enabled) {
>   		vi->rx_dim_enabled = true;
> -		for (i = 0; i < vi->max_queue_pairs; i++)
> +		for (i = 0; i < vi->max_queue_pairs; i++) {
> +			mutex_lock(&vi->rq[i].dim_lock);
>   			vi->rq[i].dim_enabled = true;
> -		goto unlock;
> +			mutex_unlock(&vi->rq[i].dim_lock);
> +		}
> +		return 0;
>   	}
>   
>   	coal_rx = kzalloc(sizeof(*coal_rx), GFP_KERNEL);
> -	if (!coal_rx) {
> -		ret = -ENOMEM;
> -		goto unlock;
> -	}
> +	if (!coal_rx)
> +		return -ENOMEM;
>   
>   	if (!rx_ctrl_dim_on && vi->rx_dim_enabled) {
>   		vi->rx_dim_enabled = false;
> -		for (i = 0; i < vi->max_queue_pairs; i++)
> +		for (i = 0; i < vi->max_queue_pairs; i++) {
> +			mutex_lock(&vi->rq[i].dim_lock);
>   			vi->rq[i].dim_enabled = false;
> +			mutex_unlock(&vi->rq[i].dim_lock);
> +		}
>   	}
>   
>   	/* Since the per-queue coalescing params can be set,
> @@ -4300,21 +4300,17 @@ static int virtnet_send_rx_notf_coal_cmds(struct virtnet_info *vi,
>   
>   	if (!virtnet_send_command(vi, VIRTIO_NET_CTRL_NOTF_COAL,
>   				  VIRTIO_NET_CTRL_NOTF_COAL_RX_SET,
> -				  &sgs_rx)) {
> -		ret = -EINVAL;
> -		goto unlock;
> -	}
> +				  &sgs_rx))
> +		return -EINVAL;
>   
>   	vi->intr_coal_rx.max_usecs = ec->rx_coalesce_usecs;
>   	vi->intr_coal_rx.max_packets = ec->rx_max_coalesced_frames;
>   	for (i = 0; i < vi->max_queue_pairs; i++) {
> +		mutex_lock(&vi->rq[i].dim_lock);
>   		vi->rq[i].intr_coal.max_usecs = ec->rx_coalesce_usecs;
>   		vi->rq[i].intr_coal.max_packets = ec->rx_max_coalesced_frames;
> -	}
> -unlock:
> -	for (i = vi->max_queue_pairs - 1; i >= 0; i--)
>   		mutex_unlock(&vi->rq[i].dim_lock);
> -
> +	}
>   	return ret;
>   }
> ---
>
> Otherwise I think you need to add {READ,WRITE}_ONCE annotations while
> touching the dim fields to avoid data races.
>
> Thanks,
>
> Paolo
>
>
>
>

