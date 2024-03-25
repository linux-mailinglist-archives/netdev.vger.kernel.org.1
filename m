Return-Path: <netdev+bounces-81534-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B1788A192
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 14:21:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 302932C657E
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 13:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6646813FD87;
	Mon, 25 Mar 2024 10:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Cqu3ww2+"
X-Original-To: netdev@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37F3A14F103
	for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 08:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711354946; cv=none; b=T9nTV9ps/leu6aESkNMqVdh6Udoh+VdLh0ZHum5VJ5yVdEZ2Y4q8IdAXQts99scL8KwzHc4kgubWNQwLEjzJB0wVh2hKKnlz8Twcubrjb5CrelqGb4/DAKbkOWKH2rttKnuwJaLTr2Rwv8lMROxs9/tw1H2kuby2WwzAMHAzXiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711354946; c=relaxed/simple;
	bh=b9FmiI9Sq+TCqOP+A6HV/teAqMiEHMNA8KXPT7w4IrE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D7LgTa9+1TQ1w9jbu3yNJlDE6rcrzlqet616F4N9hWkd2b+L9jemqiT1S/a4bmmd0okNUKSNgSQukoG3ufC/LiFQQ/i2TSOkpkL1ynbLNWgWFkBFsXhce5NjD3cv8xS2baeST5xSjmpqKeWKjjgeBdXHzBjZaQ9/EYUEFT4WQO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Cqu3ww2+; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711354941; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=bEzipBhG/k4adub5cfWHCJ/NQav+qWnAiGWpYm5ooOA=;
	b=Cqu3ww2+6svRSgPr6tBIi+07xrbC1vhd+zMbMnfZ/qPvh/SrPv5/75e0u9lUE5+2ibKihkbf5Cazvyojeq0xTZWOTgDFZb5tob1KsNJUrHskKHrHIs8C4+Kxqip+P3mdw+k7Q+DVaBl+hd+8kFBzbfkL0MLs2KdYxZNppXH4bsY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W3CFn.C_1711354940;
Received: from 30.221.148.153(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W3CFn.C_1711354940)
          by smtp.aliyun-inc.com;
          Mon, 25 Mar 2024 16:22:21 +0800
Message-ID: <36ce2bbf-3a31-4c01-99f3-1875f79e2831@linux.alibaba.com>
Date: Mon, 25 Mar 2024 16:22:17 +0800
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
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <CACGkMEv88U1_2K2b0KdmH97gfrdOvK_1ajqh=UTK6=KgZ4OYvQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/3/25 下午3:56, Jason Wang 写道:
> On Mon, Mar 25, 2024 at 3:18 PM Heng Qi <hengqi@linux.alibaba.com> wrote:
>>
>>
>> 在 2024/3/25 下午1:57, Jason Wang 写道:
>>> On Mon, Mar 25, 2024 at 10:21 AM Heng Qi <hengqi@linux.alibaba.com> wrote:
>>>>
>>>> 在 2024/3/22 下午1:19, Jason Wang 写道:
>>>>> On Thu, Mar 21, 2024 at 7:46 PM Heng Qi <hengqi@linux.alibaba.com> wrote:
>>>>>> Currently, ctrlq processes commands in a synchronous manner,
>>>>>> which increases the delay of dim commands when configuring
>>>>>> multi-queue VMs, which in turn causes the CPU utilization to
>>>>>> increase and interferes with the performance of dim.
>>>>>>
>>>>>> Therefore we asynchronously process ctlq's dim commands.
>>>>>>
>>>>>> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
>>>>> I may miss some previous discussions.
>>>>>
>>>>> But at least the changelog needs to explain why you don't use interrupt.
>>>> Will add, but reply here first.
>>>>
>>>> When upgrading the driver's ctrlq to use interrupt, problems may occur
>>>> with some existing devices.
>>>> For example, when existing devices are replaced with new drivers, they
>>>> may not work.
>>>> Or, if the guest OS supported by the new device is replaced by an old
>>>> downstream OS product, it will not be usable.
>>>>
>>>> Although, ctrlq has the same capabilities as IOq in the virtio spec,
>>>> this does have historical baggage.
>>> I don't think the upstream Linux drivers need to workaround buggy
>>> devices. Or it is a good excuse to block configure interrupts.
>> Of course I agree. Our DPU devices support ctrlq irq natively, as long
>> as the guest os opens irq to ctrlq.
>>
>> If other products have no problem with this, I would prefer to use irq
>> to solve this problem, which is the most essential solution.
> Let's do that.

Ok, will do.

Do you have the link to the patch where you previously modified the 
control queue for interrupt notifications.
I think a new patch could be made on top of it, but I can't seem to find it.

Thanks,
Heng

>
> Thanks
>
>>> And I remember you told us your device doesn't have such an issue.
>> YES.
>>
>> Thanks,
>> Heng
>>
>>> Thanks
>>>
>>>> Thanks,
>>>> Heng
>>>>
>>>>> Thanks


