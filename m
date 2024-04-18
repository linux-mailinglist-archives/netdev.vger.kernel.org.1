Return-Path: <netdev+bounces-89305-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B1D8A9FBE
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 18:12:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6544B1C211D5
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 16:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C5A16F8EC;
	Thu, 18 Apr 2024 16:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="nnf1K6FF"
X-Original-To: netdev@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B4C16F8F2
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 16:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713456773; cv=none; b=Ks6yLB0QXA6/WVfbOTZnhL+diN5MyXz0RPpC5XfzpGMWotkXahNT6R7OdZP5P9NmZSj5JUkiooX3ZzLDaOLBxW5uuZp7mI37ZDn7IhghQOzJDCMn5+QAnS3CHMKH8pjvrjYIGtpHe2J6IPKXu1sdDuKMW98oiULyOyb6grVX3BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713456773; c=relaxed/simple;
	bh=DzP2+Rou1vBke4fg3Es7yZqkGcEs7wwaqusD7F504LI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k1SwaSHbmO17rOKq6S1B2w4dWBnOLLb4gSqXUxA7s3VFlPwILZgspq/5ITS6FCabX7+loBemqDaSiPFeFTNlV9KvNEoDzMzXAfogbyOz+nGcFB8xilvZIcLsVVzuWZjnErJcTMkviEcMBKYY6XlEKjBQ17IG2zmMuNZZADHkP1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=nnf1K6FF; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713456762; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=sbRtelo6/hK6s0/wj/48pFdnZmrztc3yweXzaicZPiw=;
	b=nnf1K6FFLkm1TX4uMvVlUp4YNtyBjXC4tUhUrEnGnO2I20e7GdqLoLGL1edoXOtHF52hPP0C2XyI4AmC49GgGGk06zT0DFhoZHnRyKOu1ZMyjtYJoeYeGe/H4rg61P3D8XRF87dCAuPqs1zcW2v8dl45ZoG4BHfTWIm3+JbGHxY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0W4p4NLF_1713456759;
Received: from 30.13.151.155(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W4p4NLF_1713456759)
          by smtp.aliyun-inc.com;
          Fri, 19 Apr 2024 00:12:41 +0800
Message-ID: <a8ffbe97-22d1-4afe-bc6a-b4f9e7a8089a@linux.alibaba.com>
Date: Fri, 19 Apr 2024 00:12:39 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 3/6] virtio_net: Add a lock for the command
 VQ.
To: Paolo Abeni <pabeni@redhat.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "mst@redhat.com" <mst@redhat.com>,
 "xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
 "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, Jiri Pirko <jiri@nvidia.com>,
 Dan Jurgens <danielj@nvidia.com>, Jason Wang <jasowang@redhat.com>
References: <20240416193039.272997-1-danielj@nvidia.com>
 <20240416193039.272997-4-danielj@nvidia.com>
 <CACGkMEsCm3=7FtnsTRx5QJo3ZM0Ko1OEvssWew_tfxm5V=MXvQ@mail.gmail.com>
 <28e45768-5091-484d-b09e-4a63bc72a549@linux.alibaba.com>
 <ad9f7b83e48cfd7f1463d8c728061c30a4509076.camel@redhat.com>
 <CH0PR12MB85802CBD3808B483876F8C77C90E2@CH0PR12MB8580.namprd12.prod.outlook.com>
 <72f6c8a55adac52ad17dfe11a579b5b3d5dc3cec.camel@redhat.com>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <72f6c8a55adac52ad17dfe11a579b5b3d5dc3cec.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/4/18 下午11:48, Paolo Abeni 写道:
> On Thu, 2024-04-18 at 15:38 +0000, Dan Jurgens wrote:
>>> From: Paolo Abeni <pabeni@redhat.com>
>>> Sent: Thursday, April 18, 2024 5:57 AM
>>> On Thu, 2024-04-18 at 15:36 +0800, Heng Qi wrote:
>>>> 在 2024/4/18 下午2:42, Jason Wang 写道:
>>>>> On Wed, Apr 17, 2024 at 3:31 AM Daniel Jurgens <danielj@nvidia.com>
>>> wrote:
>>>>>> The command VQ will no longer be protected by the RTNL lock. Use a
>>>>>> spinlock to protect the control buffer header and the VQ.
>>>>>>
>>>>>> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
>>>>>> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
>>>>>> ---
>>>>>>    drivers/net/virtio_net.c | 6 +++++-
>>>>>>    1 file changed, 5 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>>>>>> index 0ee192b45e1e..d02f83a919a7 100644
>>>>>> --- a/drivers/net/virtio_net.c
>>>>>> +++ b/drivers/net/virtio_net.c
>>>>>> @@ -282,6 +282,7 @@ struct virtnet_info {
>>>>>>
>>>>>>           /* Has control virtqueue */
>>>>>>           bool has_cvq;
>>>>>> +       spinlock_t cvq_lock;
>>>>> Spinlock is instead of mutex which is problematic as there's no
>>>>> guarantee on when the driver will get a reply. And it became even
>>>>> more serious after 0d197a147164 ("virtio-net: add cond_resched() to
>>>>> the command waiting loop").
>>>>>
>>>>> Any reason we can't use mutex?
>>>> Hi Jason,
>>>>
>>>> I made a patch set to enable ctrlq's irq on top of this patch set,
>>>> which removes cond_resched().
>>>>
>>>> But I need a little time to test, this is close to fast. So could the
>>>> topic about cond_resched + spin lock or mutex lock be wait?
>>> The big problem is that until the cond_resched() is there, replacing the
>>> mutex with a spinlock can/will lead to scheduling while atomic splats. We
>>> can't intentionally introduce such scenario.
>> When I created the series set_rx_mode wasn't moved to a work queue,
>> and the cond_resched wasn't there.
> Unfortunately cond_resched() is there right now.

YES.

>
>> Mutex wasn't possible, then. If the CVQ is made to be event driven, then
>> the lock can be released right after posting the work to the VQ.
> That should work.

Yes, I will test my new patches (ctrlq with irq enabled) soon, then the 
combination
of the this set and mine MAY make deciding between mutex or spin lock 
easier.

Thanks.

>
>>> Side note: the compiler apparently does not like guard() construct, leading to
>>> new warning, here and in later patches. I'm unsure if the code simplification
>>> is worthy.
>> I didn't see any warnings with GCC or clang. This is used other places in the kernel as well.
>> gcc version 13.2.1 20230918 (Red Hat 13.2.1-3) (GCC)
>> clang version 17.0.6 (Fedora 17.0.6-2.fc39)
>>
> See:
>
> https://patchwork.kernel.org/project/netdevbpf/patch/20240416193039.272997-4-danielj@nvidia.com/
> https://netdev.bots.linux.dev/static/nipa/845178/13632442/build_32bit/stderr
> https://netdev.bots.linux.dev/static/nipa/845178/13632442/build_allmodconfig_warn/stderr
>
> Cheers,
>
> Paolo


