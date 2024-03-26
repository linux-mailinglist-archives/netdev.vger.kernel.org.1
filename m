Return-Path: <netdev+bounces-81880-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9097E88B797
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 03:46:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 477D62E7D62
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 02:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 680A7128387;
	Tue, 26 Mar 2024 02:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="xu73QNL6"
X-Original-To: netdev@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F91127B5C
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 02:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711421213; cv=none; b=pq5JFwMnWjz3kL6E4RL1lszojRX6FQ/Za15ss+6P9v6VNRot9J1J9xWm+RFX9bBAXZMGF02+nqk7qg6ZpA5rIV6N6shE96e1ZXDMDVcApjdSGrOcPttYEqEgwAgjKV+PL1CF6D2VgKgDEX4kzvww093l/8T25SmUORoHN9/FpoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711421213; c=relaxed/simple;
	bh=5/4+FnYP7WrpibFUSjMKZGgmnDOJvtxN/hNT/iYWwQc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nRXJq1cPan2tFlzveUppVMOLQXmZ6DvfVVD9vplg+QIgTScjB6juWsFpVVzjBkwGcUgzikc6rCPTHz8lpcqBzSiwnPBEQSgALozo1HNxRmmSLtQrPcskGNebFz2aNFdfAkHE8fNgMxe5ggr5EsXB7rUVP7a1nHGvaqIhf+MBl6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=xu73QNL6; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711421203; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=+tg+cbDnyeGxeUBGCtIjLT8x555SiGV5b/HSGfpvPmc=;
	b=xu73QNL693bYNfosaMQnRhTPd4M4pSQM5AuDajfWpxNNHj5ba6d78YuW+Wvd6GW7iczMhh/51pj1TY1G9ENp5Pmk5zL8FYFNV4TebkVlf6x4BIJDaFNnDo8srbaytjCjtwc7Mk9hV9G4pap+pEkpCBxs3kaP2YLN6JD1Tmk3RJQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W3JTV0m_1711421201;
Received: from 30.221.81.94(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W3JTV0m_1711421201)
          by smtp.aliyun-inc.com;
          Tue, 26 Mar 2024 10:46:42 +0800
Message-ID: <62451c11-0957-4d1b-8a34-5e224ea552e0@linux.alibaba.com>
Date: Tue, 26 Mar 2024 10:46:41 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] virtio-net: reduce the CPU consumption of dim worker
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev,
 "Michael S. Tsirkin" <mst@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 "David S. Miller" <davem@davemloft.net>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <1711021557-58116-1-git-send-email-hengqi@linux.alibaba.com>
 <1711021557-58116-3-git-send-email-hengqi@linux.alibaba.com>
 <CACGkMEuZ457UU6MhPtKHd_Y0VryvZoNU+uuKOc_4OK7jc62WwA@mail.gmail.com>
 <5708312a-d8eb-40ee-88a9-e16930b94dda@linux.alibaba.com>
 <CACGkMEu8or7+fw3+vX_PY3Qsrm7zVSf6TS9SiE20NpOsz-or6g@mail.gmail.com>
 <b54ad370-67bd-4b8c-82fb-54625e68288b@linux.alibaba.com>
 <CACGkMEv88U1_2K2b0KdmH97gfrdOvK_1ajqh=UTK6=KgZ4OYvQ@mail.gmail.com>
 <36ce2bbf-3a31-4c01-99f3-1875f79e2831@linux.alibaba.com>
 <CACGkMEvShZKd7AvMFtmEWBVGQsQrGkQMTEx8yQYYU0uYqp=uMg@mail.gmail.com>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <CACGkMEvShZKd7AvMFtmEWBVGQsQrGkQMTEx8yQYYU0uYqp=uMg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/3/25 下午4:42, Jason Wang 写道:
> On Mon, Mar 25, 2024 at 4:22 PM Heng Qi <hengqi@linux.alibaba.com> wrote:
>>
>>
>> 在 2024/3/25 下午3:56, Jason Wang 写道:
>>> On Mon, Mar 25, 2024 at 3:18 PM Heng Qi <hengqi@linux.alibaba.com> wrote:
>>>>
>>>> 在 2024/3/25 下午1:57, Jason Wang 写道:
>>>>> On Mon, Mar 25, 2024 at 10:21 AM Heng Qi <hengqi@linux.alibaba.com> wrote:
>>>>>> 在 2024/3/22 下午1:19, Jason Wang 写道:
>>>>>>> On Thu, Mar 21, 2024 at 7:46 PM Heng Qi <hengqi@linux.alibaba.com> wrote:
>>>>>>>> Currently, ctrlq processes commands in a synchronous manner,
>>>>>>>> which increases the delay of dim commands when configuring
>>>>>>>> multi-queue VMs, which in turn causes the CPU utilization to
>>>>>>>> increase and interferes with the performance of dim.
>>>>>>>>
>>>>>>>> Therefore we asynchronously process ctlq's dim commands.
>>>>>>>>
>>>>>>>> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
>>>>>>> I may miss some previous discussions.
>>>>>>>
>>>>>>> But at least the changelog needs to explain why you don't use interrupt.
>>>>>> Will add, but reply here first.
>>>>>>
>>>>>> When upgrading the driver's ctrlq to use interrupt, problems may occur
>>>>>> with some existing devices.
>>>>>> For example, when existing devices are replaced with new drivers, they
>>>>>> may not work.
>>>>>> Or, if the guest OS supported by the new device is replaced by an old
>>>>>> downstream OS product, it will not be usable.
>>>>>>
>>>>>> Although, ctrlq has the same capabilities as IOq in the virtio spec,
>>>>>> this does have historical baggage.
>>>>> I don't think the upstream Linux drivers need to workaround buggy
>>>>> devices. Or it is a good excuse to block configure interrupts.
>>>> Of course I agree. Our DPU devices support ctrlq irq natively, as long
>>>> as the guest os opens irq to ctrlq.
>>>>
>>>> If other products have no problem with this, I would prefer to use irq
>>>> to solve this problem, which is the most essential solution.
>>> Let's do that.
>> Ok, will do.
>>
>> Do you have the link to the patch where you previously modified the
>> control queue for interrupt notifications.
>> I think a new patch could be made on top of it, but I can't seem to find it.
> Something like this?

YES. Thanks Jason.

>
> https://lore.kernel.org/lkml/6026e801-6fda-fee9-a69b-d06a80368621@redhat.com/t/
>
> Note that
>
> 1) some patch has been merged
> 2) we probably need to drop the timeout logic as it's another topic
> 3) need to address other comments

I did a quick read of your patch sets from the previous 5 version:
[1] 
https://lore.kernel.org/lkml/6026e801-6fda-fee9-a69b-d06a80368621@redhat.com/t/
[2] https://lore.kernel.org/all/20221226074908.8154-1-jasowang@redhat.com/
[3] https://lore.kernel.org/all/20230413064027.13267-1-jasowang@redhat.com/
[4] https://lore.kernel.org/all/20230524081842.3060-1-jasowang@redhat.com/
[5] https://lore.kernel.org/all/20230720083839.481487-1-jasowang@redhat.com/

Regarding adding the interrupt to ctrlq, there are a few points where 
there is no agreement,
which I summarize below.

1. Require additional interrupt vector resource
https://lore.kernel.org/all/20230516165043-mutt-send-email-mst@kernel.org/
2. Adding the interrupt for ctrlq may break some devices
https://lore.kernel.org/all/f9e75ce5-e6df-d1be-201b-7d0f18c1b6e7@redhat.com/
3. RTNL breaks surprise removal
https://lore.kernel.org/all/20230720170001-mutt-send-email-mst@kernel.org/

Regarding the above, there seems to be no conclusion yet.
If these problems still exist, I think this patch is good enough and we 
can merge it first.

For the third point, it seems to be being solved by Daniel now [6], but 
spink lock is used,
which I think conflicts with the way of adding interrupts to ctrlq.

[6] https://lore.kernel.org/all/20240325214912.323749-1-danielj@nvidia.com/


Thanks,
Heng

>
> THanks
>
>
>> Thanks,
>> Heng
>>
>>> Thanks
>>>
>>>>> And I remember you told us your device doesn't have such an issue.
>>>> YES.
>>>>
>>>> Thanks,
>>>> Heng
>>>>
>>>>> Thanks
>>>>>
>>>>>> Thanks,
>>>>>> Heng
>>>>>>
>>>>>>> Thanks


