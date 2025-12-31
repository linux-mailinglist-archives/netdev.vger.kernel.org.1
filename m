Return-Path: <netdev+bounces-246438-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A8FE6CEC2A3
	for <lists+netdev@lfdr.de>; Wed, 31 Dec 2025 16:26:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4748F30380EF
	for <lists+netdev@lfdr.de>; Wed, 31 Dec 2025 15:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D864928469B;
	Wed, 31 Dec 2025 15:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aXvR5FNJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5052868AD
	for <netdev@vger.kernel.org>; Wed, 31 Dec 2025 15:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767194745; cv=none; b=hn0a+A/t5ollnqpJn0umNajpMNkNUdj5viFxUD+qis++bCSzCAWgOH5plVt5JSomrZLlDYDs11ezn9pWmC26MQmQyTz/5NsWydceOQEOmBVdyhtwrj9QsKNws/ei3Bt2LIYgSe8P8xNjegLJE3PfK0vncheAd7XxswJVpCxAYyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767194745; c=relaxed/simple;
	bh=979UspiXNW4eGHFMpGtmLPEpArKB8uG9aRPcJ46m//Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cJsIBuAtTkQ34Y9TaS4/ecrWmLEpp73PfwoPOVldTTv1rBL9SYECdyZb3SteWYlvBuPM+Ry5xDUHcUepsAkWOTb0E3vImQle7XD2YePhx5oRzB2Rts10FMPF7EsmKNTHWqmaNJt5erHNqhwIPXFdqm45WDH5C0z4RDoluWKNl1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aXvR5FNJ; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7aa9be9f03aso8994289b3a.2
        for <netdev@vger.kernel.org>; Wed, 31 Dec 2025 07:25:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767194743; x=1767799543; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lODuypmLoWbnrtex5xb240RMLf3LliH4cjDbDAmHrvU=;
        b=aXvR5FNJhCzPE2Uz3GhORxI0YFKw3xOXO9TVX3H0N7LxwEZpQxXbMQBtvEmv5xx0sG
         dsWXBjfEIMIgPvaLNwlnuIU+7qWn+1pGuJ06eqQ8Mnid3HfvXDHu10LP71JqEuVr8c0F
         omd8WJhWLp1fyR+5ZVhFbex0FzTnNqgi7U1IXV0xO3igylf7zkStBikYW+s9FG9Ib7+j
         qLWyfCSdRlYQgex8b8rSfOxNl4l/+xvqHglG4GjPaeHFpy9Pg66jjv8xJRBg0JoIBrq2
         PMttLwV8k0T6gbAkblvQICCl4PWUz61lEeSrdBszOy61zeMq7s69EEPdU/DB6h3nMBzb
         tN7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767194743; x=1767799543;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lODuypmLoWbnrtex5xb240RMLf3LliH4cjDbDAmHrvU=;
        b=YJPv7oB+PqX40EtoUnSxgliXjYwsRfY/9io9TFOuO88oFnllcyBukL4UtQTd6E1agc
         s2As3CzEoSe7K+eCWR1VYV6vddqAfyfhEoXxYlUq+7gCydasDhzMKi2f1Igh5vzVVw7K
         B2ujjGYGJvAxOHdsXO5GzOwIhIeKEhHy5bnVM3sIDtJk2i3JahNYZTEPk7JQ5UZCAsEW
         lwR9KJN8p/2oTHFQvLHjDaJhGUgQb9DaOgLMvtg/HENGCn01hcs2K5jSAHkR13pAcTxy
         GNum2nb0Dsv5SY+Wgz9kbGQgAa7PhIkD/4/osR8z0ZcDU6e7JLW5itLDou7/cPxEVl9V
         n3Dw==
X-Forwarded-Encrypted: i=1; AJvYcCU6Tku/xocqvci0i6dFXcJgwUUau2gicG7gcAWmRw+hbJWmvFN3cmjTd5F9GEwThP7LyVlp7V8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywq0b4g+tZhJZT261fpI214fUrvvGdv7iSVIjlSPrylCEk19OL2
	jdMpVJGlw+PMvWY+/KzpEFHortmBJDCq5IfTyvJ3xTfOkLNGv/nt9ZXp
X-Gm-Gg: AY/fxX6sI1OUD+scWsGrTS/rilJSw8ES+NPAAf9fdIcYv34W/U+vRHjiLKq8whLQMTE
	JucXFRcPrrNJcOwEqakL4izfYgjPnnGeXN9fygeP3vzgN1PqSXXb0nT1l8p7h88s+7BddyfzPBj
	rYYrhq9ZeV4nUU0GUQ2pfSSjUvFc/jwHok5pghcz1kNMWC50Qj3aJkXufoqvUSp9tSvo86mCoez
	g56Rdk0gFrcaiJd9lPRivy3ej9BQkP5c+E1kSu3tRfHyps9vQHqda3MA8ZWUv7180e4yNESQecZ
	JEMpsHd/wqfKS//vN/ZwI6w/bRa9DZVB0pN5d0tbCJWy1+/sngdRgkXkRNNqL0t5WMOiLr2Z7tq
	h0z/v2xpBVsuOaWQXSQbmM/6vXmsjRy6peR9pon2Mb74Q0R4WKc050mqEp/fDG6/hBQk7KpWGDL
	6jNXRdkZyJcbf4I1jVxyd7yKHebXICoxWLLp21QGxiDKaUpTsWjRVrxtaZs/faK9xw48PgwFT3
X-Google-Smtp-Source: AGHT+IFlAvoj9OX5Jfdu6AtFcYb3Ny0uLLf0Tj74ADp6OdyjPjL2eECj+48RLjIcfjlXxc49Lq2Ssw==
X-Received: by 2002:a05:6a00:a882:b0:7f7:26fe:c92f with SMTP id d2e1a72fcca58-7ff64cd5fcbmr30658077b3a.29.1767194742942;
        Wed, 31 Dec 2025 07:25:42 -0800 (PST)
Received: from ?IPV6:2001:ee0:4f4c:210:331d:4167:c690:ec93? ([2001:ee0:4f4c:210:331d:4167:c690:ec93])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7a843ee4sm36172944b3a.10.2025.12.31.07.25.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Dec 2025 07:25:41 -0800 (PST)
Message-ID: <750b2296-9009-45d8-9e18-a47ebcfb912d@gmail.com>
Date: Wed, 31 Dec 2025 22:25:34 +0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/3] virtio-net: make refill work a per receive queue
 work
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20251223152533.24364-1-minhquangbui99@gmail.com>
 <20251223152533.24364-2-minhquangbui99@gmail.com>
 <CACGkMEvXkPiTGxZ6nuC72-VGdLHVXzrGa9bAF=TcP8nqPjeZ_w@mail.gmail.com>
 <1766540234.3618076-1-xuanzhuo@linux.alibaba.com>
 <20251223204555-mutt-send-email-mst@kernel.org>
 <CACGkMEs7_-=-8w=7gW8R_EhzfWOwuDoj4p-iCPQ7areOa9uaUw@mail.gmail.com>
 <20251225112729-mutt-send-email-mst@kernel.org>
 <CACGkMEt33BAWGmeFfHWYrjQLOT4+JB7HsWWVMKUn6yFxQ9y2gg@mail.gmail.com>
 <20251226022727-mutt-send-email-mst@kernel.org>
 <7143657a-a52f-4cff-acbc-e89f4c713cc4@gmail.com>
 <CACGkMEuasGDh=wT0n5b5QFDSNNBK7muipBKHb2v5eoKCU0NWDw@mail.gmail.com>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <CACGkMEuasGDh=wT0n5b5QFDSNNBK7muipBKHb2v5eoKCU0NWDw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/31/25 14:30, Jason Wang wrote:
> On Wed, Dec 31, 2025 at 12:29 AM Bui Quang Minh
> <minhquangbui99@gmail.com> wrote:
>> On 12/26/25 14:37, Michael S. Tsirkin wrote:
>>> On Fri, Dec 26, 2025 at 09:31:26AM +0800, Jason Wang wrote:
>>>> On Fri, Dec 26, 2025 at 12:27 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>>>>> On Thu, Dec 25, 2025 at 03:33:29PM +0800, Jason Wang wrote:
>>>>>> On Wed, Dec 24, 2025 at 9:48 AM Michael S. Tsirkin <mst@redhat.com> wrote:
>>>>>>> On Wed, Dec 24, 2025 at 09:37:14AM +0800, Xuan Zhuo wrote:
>>>>>>>> Hi Jason,
>>>>>>>>
>>>>>>>> I'm wondering why we even need this refill work. Why not simply let NAPI retry
>>>>>>>> the refill on its next run if the refill fails? That would seem much simpler.
>>>>>>>> This refill work complicates maintenance and often introduces a lot of
>>>>>>>> concurrency issues and races.
>>>>>>>>
>>>>>>>> Thanks.
>>>>>>> refill work can refill from GFP_KERNEL, napi only from ATOMIC.
>>>>>>>
>>>>>>> And if GFP_ATOMIC failed, aggressively retrying might not be a great idea.
>>>>>> Btw, I see some drivers are doing things as Xuan said. E.g
>>>>>> mlx5e_napi_poll() did:
>>>>>>
>>>>>> busy |= INDIRECT_CALL_2(rq->post_wqes,
>>>>>>                                   mlx5e_post_rx_mpwqes,
>>>>>>                                   mlx5e_post_rx_wqes,
>>>>>>
>>>>>> ...
>>>>>>
>>>>>> if (busy) {
>>>>>>            if (likely(mlx5e_channel_no_affinity_change(c))) {
>>>>>>                   work_done = budget;
>>>>>>                   goto out;
>>>>>> ...
>>>>> is busy a GFP_ATOMIC allocation failure?
>>>> Yes, and I think the logic here is to fallback to ksoftirqd if the
>>>> allocation fails too much.
>>>>
>>>> Thanks
>>> True. I just don't know if this works better or worse than the
>>> current design, but it is certainly simpler and we never actually
>>> worried about the performance of the current one.
>>>
>>>
>>> So you know, let's roll with this approach.
>>>
>>> I do however ask that some testing is done on the patch forcing these OOM
>>> situations just to see if we are missing something obvious.
>>>
>>>
>>> the beauty is the patch can be very small:
>>> 1. patch 1 do not schedule refill ever, just retrigger napi
>>> 2. remove all the now dead code
>>>
>>> this way patch 1 will be small and backportable to stable.
>> I've tried 1. with this patch
>>
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> index 1bb3aeca66c6..9e890aff2d95 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -3035,7 +3035,7 @@ static int virtnet_receive_packets(struct virtnet_info *vi,
>>    }
>>
>>    static int virtnet_receive(struct receive_queue *rq, int budget,
>> -               unsigned int *xdp_xmit)
>> +               unsigned int *xdp_xmit, bool *retry_refill)
>>    {
>>        struct virtnet_info *vi = rq->vq->vdev->priv;
>>        struct virtnet_rq_stats stats = {};
>> @@ -3047,12 +3047,8 @@ static int virtnet_receive(struct receive_queue *rq, int budget,
>>            packets = virtnet_receive_packets(vi, rq, budget, xdp_xmit, &stats);
>>
>>        if (rq->vq->num_free > min((unsigned int)budget, virtqueue_get_vring_size(rq->vq)) / 2) {
>> -        if (!try_fill_recv(vi, rq, GFP_ATOMIC)) {
>> -            spin_lock(&vi->refill_lock);
>> -            if (vi->refill_enabled)
>> -                schedule_delayed_work(&vi->refill, 0);
>> -            spin_unlock(&vi->refill_lock);
>> -        }
>> +        if (!try_fill_recv(vi, rq, GFP_ATOMIC))
>> +            *retry_refill = true;
>>        }
>>
>>        u64_stats_set(&stats.packets, packets);
>> @@ -3129,18 +3125,18 @@ static int virtnet_poll(struct napi_struct *napi, int budget)
>>        struct send_queue *sq;
>>        unsigned int received;
>>        unsigned int xdp_xmit = 0;
>> -    bool napi_complete;
>> +    bool napi_complete, retry_refill = false;
>>
>>        virtnet_poll_cleantx(rq, budget);
>>
>> -    received = virtnet_receive(rq, budget, &xdp_xmit);
>> +    received = virtnet_receive(rq, budget, &xdp_xmit, &retry_refill);
>>        rq->packets_in_napi += received;
>>
>>        if (xdp_xmit & VIRTIO_XDP_REDIR)
>>            xdp_do_flush();
>>
>>        /* Out of packets? */
>> -    if (received < budget) {
>> +    if (received < budget && !retry_refill) {
> But you didn't return the budget when we need to retry here?

You are right. Returning budget when we need to retry solves the issue. In __napi_poll, if we return budget, it will check whether we have pending disable by calling napi_disable_pending. If so, the NAPI is descheduled and we can napi_disable it.

Thanks,
Quang Minh.

>
>>            napi_complete = virtqueue_napi_complete(napi, rq->vq, received);
>>            /* Intentionally not taking dim_lock here. This may result in a
>>             * spurious net_dim call. But if that happens virtnet_rx_dim_work
>> @@ -3230,9 +3226,11 @@ static int virtnet_open(struct net_device *dev)
>>
>>        for (i = 0; i < vi->max_queue_pairs; i++) {
>>            if (i < vi->curr_queue_pairs)
>> -            /* Make sure we have some buffers: if oom use wq. */
>> -            if (!try_fill_recv(vi, &vi->rq[i], GFP_KERNEL))
>> -                schedule_delayed_work(&vi->refill, 0);
>> +            /* If this fails, we will retry later in
>> +             * NAPI poll, which is scheduled in the below
>> +             * virtnet_enable_queue_pair
>> +             */
>> +            try_fill_recv(vi, &vi->rq[i], GFP_KERNEL);
>>
>>            err = virtnet_enable_queue_pair(vi, i);
>>            if (err < 0)
>> @@ -3473,15 +3471,15 @@ static void __virtnet_rx_resume(struct virtnet_info *vi,
>>                    bool refill)
>>    {
>>        bool running = netif_running(vi->dev);
>> -    bool schedule_refill = false;
>>
>> -    if (refill && !try_fill_recv(vi, rq, GFP_KERNEL))
>> -        schedule_refill = true;
>> +    if (refill)
>> +        /* If this fails, we will retry later in NAPI poll, which is
>> +         * scheduled in the below virtnet_napi_enable
>> +         */
>> +        try_fill_recv(vi, rq, GFP_KERNEL);
>> +
>>        if (running)
>>            virtnet_napi_enable(rq);
>> -
>> -    if (schedule_refill)
>> -        schedule_delayed_work(&vi->refill, 0);
>>    }
>>
>>    static void virtnet_rx_resume_all(struct virtnet_info *vi)
>> @@ -3777,6 +3775,7 @@ static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
>>        struct virtio_net_rss_config_trailer old_rss_trailer;
>>        struct net_device *dev = vi->dev;
>>        struct scatterlist sg;
>> +    int i;
>>
>>        if (!vi->has_cvq || !virtio_has_feature(vi->vdev, VIRTIO_NET_F_MQ))
>>            return 0;
>> @@ -3829,11 +3828,8 @@ static int virtnet_set_queues(struct virtnet_info *vi, u16 queue_pairs)
>>        }
>>    succ:
>>        vi->curr_queue_pairs = queue_pairs;
>> -    /* virtnet_open() will refill when device is going to up. */
>> -    spin_lock_bh(&vi->refill_lock);
>> -    if (dev->flags & IFF_UP && vi->refill_enabled)
>> -        schedule_delayed_work(&vi->refill, 0);
>> -    spin_unlock_bh(&vi->refill_lock);
>> +    for (i = 0; i < vi->curr_queue_pairs; i++)
>> +        try_fill_recv(vi, &vi->rq[i], GFP_KERNEL);
>>
>>        return 0;
>>    }
>>
>>
>> But I got an issue with selftests/drivers/net/hw/xsk_reconfig.py. This
>> test sets up XDP zerocopy (Xsk) but does not provide any descriptors to
>> the fill ring. So xsk_pool does not have any descriptors and
>> try_fill_recv will always fail. The RX NAPI keeps polling. Later, when
>> we want to disable the xsk_pool, in virtnet_xsk_pool_disable path,
>>
>> virtnet_xsk_pool_disable
>> -> virtnet_rq_bind_xsk_pool
>>     -> virtnet_rx_pause
>>       -> __virtnet_rx_pause
>>         -> virtnet_napi_disable
>>           -> napi_disable
>>
>> We get stuck in napi_disable because the RX NAPI is still polling.
> napi_disable will set NAPI_DISABLE bit, no?
>
>> In drivers/net/ethernet/mellanox/mlx5, AFAICS, it uses state bit for
>> synchronization between xsk setup (mlx5e_xsk_setup_pool) with RX NAPI
>> (mlx5e_napi_poll) without using napi_disable/enable. However, in
>> drivers/net/ethernet/intel/ice,
>>
>> ice_xsk_pool_setup
>> -> ice_qp_dis
>>     -> ice_qvec_toggle_napi
>>       -> napi_disable
>>
>> it still uses napi_disable. Did I miss something in the above patch?
>> I'll try to look into using another synchronization instead of
>> napi_disable/enable in xsk_pool setup path too.
>>
>> Thanks,
>> Quang Minh.
>>
> Thanks
>


