Return-Path: <netdev+bounces-245471-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D29CCE7B7
	for <lists+netdev@lfdr.de>; Fri, 19 Dec 2025 06:03:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 280573014A97
	for <lists+netdev@lfdr.de>; Fri, 19 Dec 2025 05:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87D629E0F7;
	Fri, 19 Dec 2025 05:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iyer4/7Z"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDA422A4D6
	for <netdev@vger.kernel.org>; Fri, 19 Dec 2025 05:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766120619; cv=none; b=XqEm744NzqqEufrBI4rHoiLMOqfFbsl1ydLrvQQ1eGYfTbj28p7LWDT6aak8Nx0INy3PpkXqX1JC7hJxeFd7iuzZZC6X8WI44nrcCVWmoHiR4YqJ7AYbEYQo8U1pCvNan33Z5F4GdSZXhaG6xxS7biAZfV4WiZqtEai6mG/mBCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766120619; c=relaxed/simple;
	bh=kaURwmhdJjY8j91/nuYsMJxS/M+9Ly7tIAquBQJLkUw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XEFux1sMDmQziu8NDXY6VIMTvDJMw3zhLUG5cHr5tlNbWmZIesmWGD5PQhLe0yxNgjm+/635i04sCrb7qQkevqBEteJMJ30BiuTmA4kI3qCZ5sIFnpezYKfc4/WcfK8ZPcNKEhSXMhyeZlhPAyn2vgbdHGPMfRrJ4FoxQcrY9gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iyer4/7Z; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2a12ebe4b74so21053995ad.0
        for <netdev@vger.kernel.org>; Thu, 18 Dec 2025 21:03:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766120617; x=1766725417; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zZTCvbTwNrP8p42X+dpd7k1dFq41aRyw/GMHSDy5acE=;
        b=Iyer4/7ZW4Hy69dmR5GPqwHheqkmQR8/thVF17jlwpulr6jvINxSl1/A6a25uIhehg
         /cI68wYritWKGcpHIAg8KIz20aieDnO7mfIxrj1txYe/Yz+aMRCeV9dgK4FVUBDU9b4S
         xHvwhp7i/Z4M9r3gC0nrNUDjCEeTFGK6hWVNV+K1KkFqNpWV6g6IiPkJHd91AGlMqlXe
         F9M2CRwSp3gMDbwoYJ2YJomLhLXxNgcTYISg5IWqHrlkbVYZX/ZRVpKSp+xdUcMVQ+9Q
         ry7PR3yeVOt2GLMN5txlY4SlO90ZF2b6m2QCpaBn8Zl9N57ABQs/tZM+cT9WGDRWZFTq
         5iRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766120617; x=1766725417;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zZTCvbTwNrP8p42X+dpd7k1dFq41aRyw/GMHSDy5acE=;
        b=OHp0a8TCKbqJwLNUyGf8AXB6l0qkUxHI7k296J1I/ymJECIUdK8c0fZt9R399j7AJj
         OjyIRpOCpOSOZzpOOcW5U2/ntSelfNJDM4UAQ7Xu8xReMhKcRM3SaIVUDV3Nt/MD1Yz7
         Z5OvpLJSS2MLlcS8srEvRVQ6CV9r+eNGw1zwE2cv6Ot0iEmWNux07kgueR0+PcKRUl6w
         gU06TO2U/yiiHGRdVQH8I6gA9OiiWL3626KBZYzreR7ycg1d00xdXoAJHnlIBoIKHSyC
         1aAiqZ422pGUNKItSwMIX/n9xJEYyQsWarvLxxqad/YldRcbeNK/41BsZ+kE0Oz3Ho+N
         2iLw==
X-Gm-Message-State: AOJu0YweRETn1U5hsePEmGMk/ENbisevkooT+ElgEmqV0/Yjc2n1ShuZ
	Tek0aKKnZ1WGaxN0ndyDvtG93cQNdy1FXuzgk/6V9OWX4l0T0rQ+sCNw
X-Gm-Gg: AY/fxX5SUHWdFYLWxqyGZNZZMVDOrNmuyH9Jgjk6epK2S3f9rOaHIkQpu7iiI+GvsOl
	mllkb1fYdoKJL9kk6OLvDUh6t9Ce3UjNx30xSN3RCEtERHNKrnRnwAGNIBQ5UAxjF+ACLsLIiZy
	zI4C1uYUrNMM4HC2soCOWLro7z5gKHMph+89fwQt82xG102bBymcFPIPbwlDbSlO7fqQxIwZvOu
	ulc/Z1DhtrLhKSpuk1sO1+/QyrVlLdlRYCy8CNoMCYaCr000jQGW3ZBC2kNPX7nPZaoM7Fe4zn2
	PhmDvrzCzrITT9krwgqAJNuTrt+sTEVY0WMD9I7Q+pcIFu6lbZaFwwCnQsX0lTbkbc5r8JrVgmC
	GXP6VYFgzuPv2NS3S3dFUXeSKCNyi5id/daO4YgPFrSVb5Qy0M/5Sm41lDbwSt6KVedHrH1D/mU
	AXX04lzEcB9dZ7h+q5lDUDbiz58ad3FiAclrhuEt59n4fkwVuRwPEIt2h4XS4=
X-Google-Smtp-Source: AGHT+IEMNwtnT5HSACs7KJDQv87Ul7tb9qZwcx6898sXznsIUuzVEP7oMOI9Ae1p0oHl8YKCnExepA==
X-Received: by 2002:a17:902:e74c:b0:24b:270e:56c7 with SMTP id d9443c01a7336-2a2f22069e3mr16825885ad.7.1766120617119;
        Thu, 18 Dec 2025 21:03:37 -0800 (PST)
Received: from ?IPV6:2001:ee0:4f4c:210:2598:f3ef:512:c5a9? ([2001:ee0:4f4c:210:2598:f3ef:512:c5a9])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3d77451sm8994465ad.96.2025.12.18.21.03.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Dec 2025 21:03:36 -0800 (PST)
Message-ID: <5434a67e-dd6e-4cd1-870b-fdd32ad34a28@gmail.com>
Date: Fri, 19 Dec 2025 12:03:29 +0700
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
 <3f5613e9-ccd0-4096-afc3-67ee94f6f660@gmail.com>
 <CACGkMEs+Mse7nhPPiqbd2doeGtPD2QD3BM_cztr6e=VfuiobHQ@mail.gmail.com>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <CACGkMEs+Mse7nhPPiqbd2doeGtPD2QD3BM_cztr6e=VfuiobHQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/17/25 09:58, Jason Wang wrote:
> On Wed, Dec 17, 2025 at 12:23 AM Bui Quang Minh
> <minhquangbui99@gmail.com> wrote:
>> On 12/16/25 11:16, Jason Wang wrote:
>>> On Fri, Dec 12, 2025 at 11:28 PM Bui Quang Minh
>>> <minhquangbui99@gmail.com> wrote:
>>>> Calling napi_disable() on an already disabled napi can cause the
>>>> deadlock. In commit 4bc12818b363 ("virtio-net: disable delayed refill
>>>> when pausing rx"), to avoid the deadlock, when pausing the RX in
>>>> virtnet_rx_pause[_all](), we disable and cancel the delayed refill work.
>>>> However, in the virtnet_rx_resume_all(), we enable the delayed refill
>>>> work too early before enabling all the receive queue napis.
>>>>
>>>> The deadlock can be reproduced by running
>>>> selftests/drivers/net/hw/xsk_reconfig.py with multiqueue virtio-net
>>>> device and inserting a cond_resched() inside the for loop in
>>>> virtnet_rx_resume_all() to increase the success rate. Because the worker
>>>> processing the delayed refilled work runs on the same CPU as
>>>> virtnet_rx_resume_all(), a reschedule is needed to cause the deadlock.
>>>> In real scenario, the contention on netdev_lock can cause the
>>>> reschedule.
>>>>
>>>> This fixes the deadlock by ensuring all receive queue's napis are
>>>> enabled before we enable the delayed refill work in
>>>> virtnet_rx_resume_all() and virtnet_open().
>>>>
>>>> Fixes: 4bc12818b363 ("virtio-net: disable delayed refill when pausing rx")
>>>> Reported-by: Paolo Abeni <pabeni@redhat.com>
>>>> Closes: https://netdev-ctrl.bots.linux.dev/logs/vmksft/drv-hw-dbg/results/400961/3-xdp-py/stderr
>>>> Cc: stable@vger.kernel.org
>>>> Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
>>>> ---
>>>> Changes in v2:
>>>> - Move try_fill_recv() before rx napi_enable()
>>>> - Link to v1: https://lore.kernel.org/netdev/20251208153419.18196-1-minhquangbui99@gmail.com/
>>>> ---
>>>>    drivers/net/virtio_net.c | 71 +++++++++++++++++++++++++---------------
>>>>    1 file changed, 45 insertions(+), 26 deletions(-)
>>>>
>>>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>>>> index 8e04adb57f52..4e08880a9467 100644
>>>> --- a/drivers/net/virtio_net.c
>>>> +++ b/drivers/net/virtio_net.c
>>>> @@ -3214,21 +3214,31 @@ static void virtnet_update_settings(struct virtnet_info *vi)
>>>>    static int virtnet_open(struct net_device *dev)
>>>>    {
>>>>           struct virtnet_info *vi = netdev_priv(dev);
>>>> +       bool schedule_refill = false;
>>>>           int i, err;
>>>>
>>>> -       enable_delayed_refill(vi);
>>>> -
>>>> +       /* - We must call try_fill_recv before enabling napi of the same receive
>>>> +        * queue so that it doesn't race with the call in virtnet_receive.
>>>> +        * - We must enable and schedule delayed refill work only when we have
>>>> +        * enabled all the receive queue's napi. Otherwise, in refill_work, we
>>>> +        * have a deadlock when calling napi_disable on an already disabled
>>>> +        * napi.
>>>> +        */
>>>>           for (i = 0; i < vi->max_queue_pairs; i++) {
>>>>                   if (i < vi->curr_queue_pairs)
>>>>                           /* Make sure we have some buffers: if oom use wq. */
>>>>                           if (!try_fill_recv(vi, &vi->rq[i], GFP_KERNEL))
>>>> -                               schedule_delayed_work(&vi->refill, 0);
>>>> +                               schedule_refill = true;
>>>>
>>>>                   err = virtnet_enable_queue_pair(vi, i);
>>>>                   if (err < 0)
>>>>                           goto err_enable_qp;
>>>>           }
>>> So NAPI could be scheduled and it may want to refill but since refill
>>> is not enabled, there would be no refill work.
>>>
>>> Is this a problem?
>> You are right. It is indeed a problem.
>>
>> I think we can unconditionally schedule the delayed refill after
>> enabling all the RX NAPIs (don't check the boolean schedule_refill
>> anymore) to ensure that we will have refill work. We can still keep the
>> try_fill_recv here to fill the receive buffer earlier in normal case.
>> What do you think?
> Or we can have a reill_pending

Okay, let me implement this in the next version.

> but basically I think we need something
> that is much more simple. That is, using a per rq work instead of a
> global one?

I think we can leave this in a net-next patch later.

Thanks,
Quang Minh

>
> Thanks
>
>>>
>>>> +       enable_delayed_refill(vi);
>>>> +       if (schedule_refill)
>>>> +               schedule_delayed_work(&vi->refill, 0);
>>>> +
>>>>           if (virtio_has_feature(vi->vdev, VIRTIO_NET_F_STATUS)) {
>>>>                   if (vi->status & VIRTIO_NET_S_LINK_UP)
>>>>                           netif_carrier_on(vi->dev);
>>>> @@ -3463,39 +3473,48 @@ static void virtnet_rx_pause(struct virtnet_info *vi, struct receive_queue *rq)
>>>>           __virtnet_rx_pause(vi, rq);
>>>>    }
>>>>
>>> Thanks
>>>
>> Thanks,
>> Quang Minh.
>>


