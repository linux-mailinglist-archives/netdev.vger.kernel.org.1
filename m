Return-Path: <netdev+bounces-244969-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D8BCCC449E
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 17:28:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D7673072AD9
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 16:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D8F2DC33F;
	Tue, 16 Dec 2025 16:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AJjVGTM7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D46328B7A
	for <netdev@vger.kernel.org>; Tue, 16 Dec 2025 16:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765902197; cv=none; b=UaiYJtWUk5FsQlXoZq5AtvNZ+Boae8spIOu9oHT1nP854c+yJRlxWO+C1mllOgjY5qOPU8maTs6jY8DiovkeiWwXixU81YMoFF0fjoU8Tgnye+sQ6tfQH5IyCQJ9P+ABqSLa4fv1lFnD9yz+RGFQLNOCzwVuW7q+XP8ltXUb7lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765902197; c=relaxed/simple;
	bh=SLX1m3nU08SsL41tzHOdEaPGIcnB60w6kwnMIe7g1D8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U+p/6mUxhcQDq+zkNGxumTgOoAYxbAeHDpVZjmJzLyhYJ6iNvXQHtRqDIGbQJpO5+wHyhLs5aK3CCssFroceyrdvrcgSrUdCdwvVbX6fVaai0VEbGtouq0vna4YQsxKCUX3Y0m2qOzKQnz0buitgnKnkclL5Xy2+dMdKazq2tRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AJjVGTM7; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7b9387df58cso7308393b3a.3
        for <netdev@vger.kernel.org>; Tue, 16 Dec 2025 08:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765902192; x=1766506992; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=j5vCKhasJ1Ig30OHsuQK/Y6r0bPzjGj3HFYq+PgtrOQ=;
        b=AJjVGTM7XpDfXWGy0gPq7xS3kaZ2fKALIguR6VN2mi058QrVFEYoi59Z7BnP/4TX54
         HCgDd59buA1cVTH542lXEnG3OrHAi0WwXFP/MLXGLnwNP8ti27qM02q9/URdoonjemds
         x61nixnZ0dtld20k1G7twYBB19fcvhB1mId070eKqOgQpd38N8DrAx0n7VxjJcImp9u0
         ty6ckOp0h92tBSRmKbd1o7yFwjcaIOjOQLyllJxbxyS98woZ/QQEaSzY5qjfsBfVF65c
         sZwEbTf2XNbsT11nkXSUebU2xkaA3bD7PMXZrqhECzClF9n6/pGmgjLdCPodEQ6nS4A6
         Dvsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765902192; x=1766506992;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j5vCKhasJ1Ig30OHsuQK/Y6r0bPzjGj3HFYq+PgtrOQ=;
        b=hf32ka/8/N/DvjyrCWrlBjL/0a4gupSJkG3R7XxqiARkQIlr0V5EYpIODqMUJcz5zt
         RHsjkPEIijgO2cbxWr3jahGKtW0imVUgHCADvppCQkjAYA5SjM5+cjXUeCTWHa1TY0Ov
         Y7YvWB8nzAB+GAk0B6BgdS3ZIrq/rLF6JeJFvHxatxHdUmai4n09zgSbAWYODqzsU62d
         +D0a1iUc+TRo6rY9PeKli4RVwJaF27E3OFf6Ceg9wKO99OXSSr9dHqad0yAyjcj+726T
         MCpegodIui0bqEs0fh4J9zCdWs9yrRu0iNpamZ6MUPOzZBAthzcENuJM43JRYsER8bwm
         Om3A==
X-Gm-Message-State: AOJu0YzqXqBdAZPqfpYW+eQYvS/YZqbGcsWqO6kNBPdkowr0U1rK38Ay
	l+yrfJx1kdVDxBZhfR8D3jIDaFaL72MVYthNxGBIaQIDpiEh0qPGPDgS
X-Gm-Gg: AY/fxX4mXHIW79ATmFPN5zs/HqhAluCe0KyAhGr4XnGP3lr+KuSLFX1zSGw43ocI7Zq
	71p2g5raeF9cxN2iX5UMRfKF1WHKHlsPekXZa/oZLKmORR9gHihm7+bsHByKvI2cPNhi60B2w7x
	qH1gXqVlnY+yBmW+BjzavxhzuvVukXSxp0u1JOwJtT3aF9LqRAk51tMFxoCAij4TRGy5Vv9OZNz
	AX4GIoSGFTFgaFPphtF8iJmCu1MjhtSK7s6mI3Ch3xMtFVPuqfVAL/EWqPQHTRjlvrU9KBa5l5h
	UiUjY5OeADBIoqFqt4U3Nz4Mwaqjd/zc2bMoxM8OeqBEv1S+bdgju7Gfn5sDL+q7G4tQ3+KVLXf
	UjMTuZJE6w1Kvi4Y6myTyUkoNfYUVc1ywIeEqx8rgwjahYGZ/spZQy2l/tQsxBPQnE0K7WQzU8/
	ZRcdjUkaDKHfiAOIlGc35sRN3jpzFSVQAJpBd2lRSBYUF2BKMBVed1x3CI+U8=
X-Google-Smtp-Source: AGHT+IECYfe/OWkP+h6xwdXpAJwtn05ZsuE/m7/iUcw3NPvb9j7sxFVFBX2c8mmvByjxd+djfC6elw==
X-Received: by 2002:a05:6a00:1d0a:b0:7b7:6f69:e9ba with SMTP id d2e1a72fcca58-7f667447030mr15140623b3a.1.1765902191527;
        Tue, 16 Dec 2025 08:23:11 -0800 (PST)
Received: from ?IPV6:2001:ee0:4f4c:210:aa6d:57b:2df9:35ae? ([2001:ee0:4f4c:210:aa6d:57b:2df9:35ae])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7f4c4e9d9e3sm15921893b3a.45.2025.12.16.08.23.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Dec 2025 08:23:11 -0800 (PST)
Message-ID: <3f5613e9-ccd0-4096-afc3-67ee94f6f660@gmail.com>
Date: Tue, 16 Dec 2025 23:23:04 +0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] virtio-net: enable all napis before scheduling
 refill work
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, stable@vger.kernel.org
References: <20251212152741.11656-1-minhquangbui99@gmail.com>
 <CACGkMEtzXmfDhiQiq=5qPGXG+rJcxGkWk0CZ4X_2cnr2UVH+eQ@mail.gmail.com>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <CACGkMEtzXmfDhiQiq=5qPGXG+rJcxGkWk0CZ4X_2cnr2UVH+eQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/16/25 11:16, Jason Wang wrote:
> On Fri, Dec 12, 2025 at 11:28 PM Bui Quang Minh
> <minhquangbui99@gmail.com> wrote:
>> Calling napi_disable() on an already disabled napi can cause the
>> deadlock. In commit 4bc12818b363 ("virtio-net: disable delayed refill
>> when pausing rx"), to avoid the deadlock, when pausing the RX in
>> virtnet_rx_pause[_all](), we disable and cancel the delayed refill work.
>> However, in the virtnet_rx_resume_all(), we enable the delayed refill
>> work too early before enabling all the receive queue napis.
>>
>> The deadlock can be reproduced by running
>> selftests/drivers/net/hw/xsk_reconfig.py with multiqueue virtio-net
>> device and inserting a cond_resched() inside the for loop in
>> virtnet_rx_resume_all() to increase the success rate. Because the worker
>> processing the delayed refilled work runs on the same CPU as
>> virtnet_rx_resume_all(), a reschedule is needed to cause the deadlock.
>> In real scenario, the contention on netdev_lock can cause the
>> reschedule.
>>
>> This fixes the deadlock by ensuring all receive queue's napis are
>> enabled before we enable the delayed refill work in
>> virtnet_rx_resume_all() and virtnet_open().
>>
>> Fixes: 4bc12818b363 ("virtio-net: disable delayed refill when pausing rx")
>> Reported-by: Paolo Abeni <pabeni@redhat.com>
>> Closes: https://netdev-ctrl.bots.linux.dev/logs/vmksft/drv-hw-dbg/results/400961/3-xdp-py/stderr
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
>> ---
>> Changes in v2:
>> - Move try_fill_recv() before rx napi_enable()
>> - Link to v1: https://lore.kernel.org/netdev/20251208153419.18196-1-minhquangbui99@gmail.com/
>> ---
>>   drivers/net/virtio_net.c | 71 +++++++++++++++++++++++++---------------
>>   1 file changed, 45 insertions(+), 26 deletions(-)
>>
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> index 8e04adb57f52..4e08880a9467 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -3214,21 +3214,31 @@ static void virtnet_update_settings(struct virtnet_info *vi)
>>   static int virtnet_open(struct net_device *dev)
>>   {
>>          struct virtnet_info *vi = netdev_priv(dev);
>> +       bool schedule_refill = false;
>>          int i, err;
>>
>> -       enable_delayed_refill(vi);
>> -
>> +       /* - We must call try_fill_recv before enabling napi of the same receive
>> +        * queue so that it doesn't race with the call in virtnet_receive.
>> +        * - We must enable and schedule delayed refill work only when we have
>> +        * enabled all the receive queue's napi. Otherwise, in refill_work, we
>> +        * have a deadlock when calling napi_disable on an already disabled
>> +        * napi.
>> +        */
>>          for (i = 0; i < vi->max_queue_pairs; i++) {
>>                  if (i < vi->curr_queue_pairs)
>>                          /* Make sure we have some buffers: if oom use wq. */
>>                          if (!try_fill_recv(vi, &vi->rq[i], GFP_KERNEL))
>> -                               schedule_delayed_work(&vi->refill, 0);
>> +                               schedule_refill = true;
>>
>>                  err = virtnet_enable_queue_pair(vi, i);
>>                  if (err < 0)
>>                          goto err_enable_qp;
>>          }
> So NAPI could be scheduled and it may want to refill but since refill
> is not enabled, there would be no refill work.
>
> Is this a problem?

You are right. It is indeed a problem.

I think we can unconditionally schedule the delayed refill after 
enabling all the RX NAPIs (don't check the boolean schedule_refill 
anymore) to ensure that we will have refill work. We can still keep the 
try_fill_recv here to fill the receive buffer earlier in normal case. 
What do you think?

>
>
>> +       enable_delayed_refill(vi);
>> +       if (schedule_refill)
>> +               schedule_delayed_work(&vi->refill, 0);
>> +
>>          if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
>>                  if (vi->status & VIRTIO_NET_S_LINK_UP)
>>                          netif_carrier_on(vi->dev);
>> @@ -3463,39 +3473,48 @@ static void virtnet_rx_pause(struct virtnet_info *vi, struct receive_queue *rq)
>>          __virtnet_rx_pause(vi, rq);
>>   }
>>
> Thanks
>

Thanks,
Quang Minh.


