Return-Path: <netdev+bounces-81909-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A807088BA2E
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 07:06:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB205B20DAB
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 06:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4AC712AADE;
	Tue, 26 Mar 2024 06:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="KzUPoP/m"
X-Original-To: netdev@vger.kernel.org
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3732912AAC7
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 06:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711433157; cv=none; b=R80e4NMY5mWb3Kbi4ziclYftFkP2kGl3hO1p4FSI5/EmyTDdBBM3V4QwkFWuN3dvcjpWOZWfrgUHHfnnRKYD8HnY1Dg6o9EkZgUQMz+9G3qS7TjrX2ftNyR5Aa+sytzfDlQSrkXhUaU03qJGjJsvJa0JmoPKDxrBCebH42UToGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711433157; c=relaxed/simple;
	bh=NO61bJVRsEvpdgUYiYT6U+RNOOLLFAKVZCJYcNwFmiw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iZZTMupE5ytz16jmR7owICsaxAs23c+F4u6Y+ZJV3P1moTZbP6CydNs4H8q3FVZqhtf3F6Lyrlg92FVGXwCgFeUHF3vfzImXXL7IpjR3ZYVGAGrEPbCOxaIPJUVt31O3ZzxGv3jKUfyywcBrgYWC2M9B45qoaLeavAPWtpkNcTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=KzUPoP/m; arc=none smtp.client-ip=115.124.30.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711433148; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=7luCg4vEwCfkXoYWOAUIDYythaXAUaoq9HfKIfQxAA8=;
	b=KzUPoP/mqbPMf4nT8rmJe4DjWxK76qp1tBi4xlIJfPQDIAJZ7l7PQ7hQLN+2SKnCszX4kBv1g8TtHad/nPjpUhwVj29uHaHyz+5hj4O7g5gw/OIXi2F7ufw2C6v36lVzrO+m+jz1wAy2mulOqWfNnXD7bzA6COSkcyknMCwMynE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0W3JsaPL_1711433143;
Received: from 30.221.149.28(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W3JsaPL_1711433143)
          by smtp.aliyun-inc.com;
          Tue, 26 Mar 2024 14:05:48 +0800
Message-ID: <95369596-191b-4cd3-9262-26aff7558561@linux.alibaba.com>
Date: Tue, 26 Mar 2024 14:05:41 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/4] Remove RTNL lock protection of CVQ
To: Dan Jurgens <danielj@nvidia.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
 "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com"
 <pabeni@redhat.com>, Jiri Pirko <jiri@nvidia.com>
References: <20240325214912.323749-1-danielj@nvidia.com>
 <23e442f0-a18b-4da0-9321-f543b028cd7e@linux.alibaba.com>
 <CH0PR12MB8580BA6DB62352F6378E8EBFC9352@CH0PR12MB8580.namprd12.prod.outlook.com>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <CH0PR12MB8580BA6DB62352F6378E8EBFC9352@CH0PR12MB8580.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/3/26 下午12:11, Dan Jurgens 写道:
>> From: Heng Qi <hengqi@linux.alibaba.com>
>> Sent: Monday, March 25, 2024 9:54 PM
>> To: Dan Jurgens <danielj@nvidia.com>; netdev@vger.kernel.org
>> Cc: mst@redhat.com; jasowang@redhat.com; xuanzhuo@linux.alibaba.com;
>> virtualization@lists.linux.dev; davem@davemloft.net;
>> edumazet@google.com; kuba@kernel.org; pabeni@redhat.com; Jiri Pirko
>> <jiri@nvidia.com>
>> Subject: Re: [PATCH net-next 0/4] Remove RTNL lock protection of CVQ
>>
>>
>>
>> 在 2024/3/26 上午5:49, Daniel Jurgens 写道:
>>> Currently the buffer used for control VQ commands is protected by the
>>> RTNL lock. Previously this wasn't a major concern because the control
>>> VQ was only used during device setup and user interaction. With the
>>> recent addition of dynamic interrupt moderation the control VQ may be
>>> used frequently during normal operation.
>>>
>>> This series removes the RNTL lock dependancy by introducing a spin
>>> lock to protect the control buffer and writing SGs to the control VQ.
>> Hi Daniel.
>>
>> It's a nice piece of work, but now that we're talking about ctrlq adding
>> interrupts, spin lock has some conflicts with its goals. For example, we expect
>> the ethtool command to be blocked.
>> Therefore, a mutex lock may be more suitable.
>>
>> Any how, the final conclusion may require some waiting.
> Thanks, Heng
>
> I took this a step further and made the ctrlq interrupt driven, but an internal reviewer pointed me to this:
> https://lore.kernel.org/lkml/20230413064027.13267-1-jasowang@redhat.com/ (sorry if it gets safelinked)
>
> It seemed there was little appetite to go that route last year, because of set RX mode behavior change, and consumption of an additional IRQ.

Hi DanielJ.

Jason now supports this and wants to make changes to ctrlq.

Yes, our requirements for ctrlq have become higher and we need to make 
updates as expected.

So your patches look good:

         Reviewed-by: Heng Qi <hengqi@linux.alibaba.com>

I will make further modifications on top of these.

Regards,
Heng

>
> Either way, I think the spin lock is still needed. In my interrupt driven implantation I was allocating a new control buffer instead of just the data fields. The spin lock was tighter around virtqueue_add_sgs, after the kick it would unlock and wait for a completion that would be triggered from the cvq callback.
>
>
>> Regards,
>> Heng
>>
>>> Daniel Jurgens (4):
>>>     virtio_net: Store RSS setting in virtnet_info
>>>     virtio_net: Remove command data from control_buf
>>>     virtio_net: Add a lock for the command VQ.
>>>     virtio_net: Remove rtnl lock protection of command buffers
>>>
>>>    drivers/net/virtio_net.c | 185 ++++++++++++++++++++++-----------------
>>>    1 file changed, 104 insertions(+), 81 deletions(-)
>>>


