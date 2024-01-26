Return-Path: <netdev+bounces-66089-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 932AD83D2E4
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 04:14:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A29328D1BD
	for <lists+netdev@lfdr.de>; Fri, 26 Jan 2024 03:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78148B677;
	Fri, 26 Jan 2024 03:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UY6cAI2n"
X-Original-To: netdev@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B314AD53
	for <netdev@vger.kernel.org>; Fri, 26 Jan 2024 03:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706238841; cv=none; b=DesFg/BAcsTX2UxZoGfeznMAY8JlNbjR/s42GGrNFJa9sKRzoelHPi706IGwE1+vE+/hz0NykNmzg2UUWRtGn3kf21FwJ711wXy+PEQ6ORg4GZp5knKXjO6zOU5KiZ9QiSOFBtp2pm4y4V2XEmaszn4rou4xvv0RF1CnjKuPJeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706238841; c=relaxed/simple;
	bh=XtiKU91260sTE9LXDpOYClr9EsKTlZQRf4Ge1zxEBHc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=GEksxQ4tgIHZLMKm5tQNp3XEvknqGqdQd5/C0l0v+X6wsmyUlnaDLEv58XN8klGQBrh2hb+qxGeQZCyaILMSzomvU3HA1EziQSozYyG1OwP6arGfnf56fpac7Izn3/fX5B07NuzK2HNPDyy9F8Fqr5J9g+gX+lTxt75MYkrCGp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UY6cAI2n; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <68ebd92e-cf7a-43af-af71-386495606d90@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706238837;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7Gy15I7xMvKA2vgK/nMLjkz4GT3dS1zeHc8GorjJvwo=;
	b=UY6cAI2nBiqHEBjBnC2JefTmHnvMgdN15vUQzrK3goo8IRfT+XLfDCOO0yNT4+9oGPFX/G
	CFLdpEMsGB0Ner2EoviVGo4i4RKKR8sime1AJF8hqbzHk6/ZUMpVVeftfKvagpUjKxZRMP
	xG+hS6yR5etzqwI3m1Nx4arcfY08Kuw=
Date: Fri, 26 Jan 2024 11:13:48 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] virtio_net: Add timeout handler to avoid kernel hang
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Jason Wang <jasowang@redhat.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heng Qi <hengqi@linux.alibaba.com>,
 Paolo Abeni <pabeni@redhat.com>, Zhu Yanjun <yanjun.zhu@intel.com>,
 mst@redhat.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 virtualization@lists.linux.dev, netdev@vger.kernel.org
References: <20240115012918.3081203-1-yanjun.zhu@intel.com>
 <ea230712e27af2c8d2d77d1087e45ecfa86abb31.camel@redhat.com>
 <667a9520-a53f-40a2-810a-6c1e45146589@linux.dev>
 <7dd89fc0-f31e-4f83-9c02-58ee67c2d436@linux.alibaba.com>
 <430b899c-aed4-419d-8ae8-544bb9bec5d9@lunn.ch>
 <64270652-8e0c-4db7-b245-b970d9588918@linux.dev>
 <CACGkMEs18hjxiZRDT5-+PMDHkLbEyiviafGiCWsAE6CGBrj+9g@mail.gmail.com>
 <1705895881.6990144-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEvvn76w+BZArOWK-c1gsqNNx6bH8HPoqPAqpJG_7EYntA@mail.gmail.com>
 <1705904164.7020166-3-xuanzhuo@linux.alibaba.com>
 <CACGkMEsTT7hrm2QWZq-NasfVAJHsUoZq5hijvLE_jY+2YyKytg@mail.gmail.com>
 <CACGkMEt4zyESemjPwZtD5d4d00jtorY0qR5vM9y96NZzKkdj8A@mail.gmail.com>
 <1705906930.2143333-5-xuanzhuo@linux.alibaba.com>
 <e46d04d7-4eb7-4fcd-821a-d558c07531b7@linux.dev>
In-Reply-To: <e46d04d7-4eb7-4fcd-821a-d558c07531b7@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2024/1/26 11:11, Zhu Yanjun 写道:
>
>
> 在 2024/1/22 15:02, Xuan Zhuo 写道:
>> On Mon, 22 Jan 2024 14:58:09 +0800, Jason Wang<jasowang@redhat.com>  wrote:
>>> On Mon, Jan 22, 2024 at 2:55 PM Jason Wang<jasowang@redhat.com>  wrote:
>>>> On Mon, Jan 22, 2024 at 2:20 PM Xuan Zhuo<xuanzhuo@linux.alibaba.com>  wrote:
>>>>> On Mon, 22 Jan 2024 12:16:27 +0800, Jason Wang<jasowang@redhat.com>  wrote:
>>>>>> On Mon, Jan 22, 2024 at 12:00 PM Xuan Zhuo<xuanzhuo@linux.alibaba.com>  wrote:
>>>>>>> On Mon, 22 Jan 2024 11:14:30 +0800, Jason Wang<jasowang@redhat.com>  wrote:
>>>>>>>> On Mon, Jan 22, 2024 at 10:12 AM Zhu Yanjun<yanjun.zhu@linux.dev>  wrote:
>>>>>>>>> 在 2024/1/20 1:29, Andrew Lunn 写道:
>>>>>>>>>>>>>>         while (!virtqueue_get_buf(vi->cvq, &tmp) &&
>>>>>>>>>>>>>> -           !virtqueue_is_broken(vi->cvq))
>>>>>>>>>>>>>> +           !virtqueue_is_broken(vi->cvq)) {
>>>>>>>>>>>>>> +        if (timeout)
>>>>>>>>>>>>>> +            timeout--;
>>>>>>>>>>>>> This is not really a timeout, just a loop counter. 200 iterations could
>>>>>>>>>>>>> be a very short time on reasonable H/W. I guess this avoid the soft
>>>>>>>>>>>>> lockup, but possibly (likely?) breaks the functionality when we need to
>>>>>>>>>>>>> loop for some non negligible time.
>>>>>>>>>>>>>
>>>>>>>>>>>>> I fear we need a more complex solution, as mentioned by Micheal in the
>>>>>>>>>>>>> thread you quoted.
>>>>>>>>>>>> Got it. I also look forward to the more complex solution to this problem.
>>>>>>>>>>> Can we add a device capability (new feature bit) such as ctrq_wait_timeout
>>>>>>>>>>> to get a reasonable timeout？
>>>>>>>>>> The usual solution to this is include/linux/iopoll.h. If you can sleep
>>>>>>>>>> read_poll_timeout() otherwise read_poll_timeout_atomic().
>>>>>>>>> I read carefully the functions read_poll_timeout() and
>>>>>>>>> read_poll_timeout_atomic(). The timeout is set by the caller of the 2
>>>>>>>>> functions.
>>>>>>>> FYI, in order to avoid a swtich of atomic or not, we need convert rx
>>>>>>>> mode setting to workqueue first:
>>>>>>>>
>>>>>>>> https://www.mail-archive.com/virtualization@lists.linux-foundation.org/msg60298.html
>>>>>>>>
>>>>>>>>> As such, can we add a module parameter to customize this timeout value
>>>>>>>>> by the user?
>>>>>>>> Who is the "user" here, or how can the "user" know the value?
>>>>>>>>
>>>>>>>>> Or this timeout value is stored in device register, virtio_net driver
>>>>>>>>> will read this timeout value at initialization?
>>>>>>>> See another thread. The design needs to be general, or you can post a RFC.
>>>>>>>>
>>>>>>>> In another thought, we've already had a tx watchdog, maybe we can have
>>>>>>>> something similar to cvq and use timeout + reset in that case.
>>>>>>> But we may block by the reset ^_^ if the device is broken?
>>>>>> I mean vq reset here.
>>>>> I see.
>>>>>
>>>>> I mean when the deivce is broken, the vq reset also many be blocked.
>>>>>
>>>>>          void vp_modern_set_queue_reset(struct virtio_pci_modern_device *mdev, u16 index)
>>>>>          {
>>>>>                  struct virtio_pci_modern_common_cfg __iomem *cfg;
>>>>>
>>>>>                  cfg = (struct virtio_pci_modern_common_cfg __iomem *)mdev->common;
>>>>>
>>>>>                  vp_iowrite16(index, &cfg->cfg.queue_select);
>>>>>                  vp_iowrite16(1, &cfg->queue_reset);
>>>>>
>>>>>                  while (vp_ioread16(&cfg->queue_reset))
>>>>>                          msleep(1);
>>>>>
>>>>>                  while (vp_ioread16(&cfg->cfg.queue_enable))
>>>>>                          msleep(1);
>>>>>          }
>>>>>          EXPORT_SYMBOL_GPL(vp_modern_set_queue_reset);
>>>>>
>>>>> In this function, for the broken device, we can not expect something.
>>>> Yes, it's best effort, there's no guarantee then. But it doesn't harm to try.
>>>>
>>>> Thanks
>>>>
>>>>>> It looks like we have multiple goals here
>>>>>>
>>>>>> 1) avoid lockups, using workqueue + cond_resched() seems to be
>>>>>> sufficient, it has issue but nothing new
>>>>>> 2) recover from the unresponsive device, the issue for timeout is that
>>>>>> it needs to deal with false positives
>>>>> I agree.
>>>>>
>>>>> But I want to add a new goal, cvq async. In the netdim, we will
>>>>> send many requests via the cvq, so the cvq async will be nice.
>>> Then you need an interrupt for cvq.
>>>
>>> FYI, I've posted a series that use interrupt for cvq in the past:
>>>
>>> https://lore.kernel.org/lkml/6026e801-6fda-fee9-a69b-d06a80368621@redhat.com/t/
>> I know this. But the interrupt maybe not a good solution without new space.
>>
>>> Haven't found time in working on this anymore, maybe we can start from
>>> this or not.
>> I said async, but my aim is to put many requests to the cvq before getting the
>> response.
>>
>> Heng Qi posted thishttps://lore.kernel.org/all/1705410693-118895-4-git-send-email-hengqi@linux.alibaba.com/

Sorry. This mail is rejected by netdev maillist. So I have to resend it.


Thanks a lot. I read Heng Qi's commits carefully. This patch series are 
similiar with the NIC feature xmit_more.

But if cvq command is urgent, can we let this urgent cvq command be 
passed ASAP?

I mean, can we set a flag similar to xmit_more? if cvq command is not 
urgent, it can be queued. If it is urgent,

this cvq command is passed ASAP.

Zhu Yanjun

> Zhu Yanjun
>
>> Thanks.
>>
>>
>>> Thanks
>>>
>>>>> Thanks.
>>>>>
>>>>>
>>>>>> Thanks
>>>>>>
>>>>>>> Thanks.
>>>>>>>
>>>>>>>
>>>>>>>> Thans
>>>>>>>>
>>>>>>>>> Zhu Yanjun
>>>>>>>>>
>>>>>>>>>>        Andrew

