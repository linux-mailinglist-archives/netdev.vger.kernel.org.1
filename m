Return-Path: <netdev+bounces-81517-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C1CA888A793
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 16:50:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB029BC6988
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 13:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D4073513;
	Mon, 25 Mar 2024 09:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="FDieedJ6"
X-Original-To: netdev@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2B6174EC6
	for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 06:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711349881; cv=none; b=q7wan34RKylVfR0jJAxVdb21kFjB74XksC/us6XUUWPtZo7QBNdghR3qw3VZI5l/jwY+/aeYFst2bx6cGQItoVXceXuJYm+gEtlCq2Y1kJ/NmBiSCbQr7sH1VERzrLvgm0qHxb6PXyvIc0UyzvY3m+qkcjAXxE8PAZMHKwC7pkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711349881; c=relaxed/simple;
	bh=UpX0WFjDYniQjlx6ONDWYdNIMz6IxT2b2mPATGLCyOo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AAJ0ghYH23elySLFn3Kj2BTmKLGIBYV8jFmNOgCBuPp9UPK0d4DPrGqIGMWUuCM86f7+WPMXzaLKUougeN6zy/hNfa3IYDD6TiZ5YVKWmNsr12/ZrEXCy3FOoa+PNgLbVnCC1zH97Wu7yGt/Ac+JSPKL1LCUnLxAvyWSVm0FtGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=FDieedJ6; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711349875; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=em8lCJ5k62FqhJ9zPUJ67NFTOLKbF22N/XCX/IQBQkQ=;
	b=FDieedJ6Ve5n9TDiSpKjaCoXFcmHviVBUxg6X9Q3lIj1OFZMmUtven9SsgyuhC0a69HlCLWWI7jcS5+JjPGeBaPBr0/JaZ6UzLy7b4MlF3ZPjxFrQVCp588se6OrgoTaDMup30pgdQ6RbYz0aXxJ6F6CwS4bdvlRgb7oDgm9ceA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R721e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W3B0HIF_1711349873;
Received: from 30.221.148.153(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W3B0HIF_1711349873)
          by smtp.aliyun-inc.com;
          Mon, 25 Mar 2024 14:57:55 +0800
Message-ID: <8f1a722e-a16d-4c17-a5bd-face60b4cf4d@linux.alibaba.com>
Date: Mon, 25 Mar 2024 14:57:51 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] virtio-net: fix possible dim status unrecoverable
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux.dev,
 "Michael S. Tsirkin" <mst@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 "David S. Miller" <davem@davemloft.net>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <1711021557-58116-1-git-send-email-hengqi@linux.alibaba.com>
 <1711021557-58116-2-git-send-email-hengqi@linux.alibaba.com>
 <CACGkMEtyujkJ6Gvxr1xV94a_tMzTo48opA+42oBvN-eQ=92StA@mail.gmail.com>
 <8d829442-0eef-485c-b448-cd2376c20270@linux.alibaba.com>
 <CACGkMEv9H2q0ALywstj4srmzRehCFvzXGB5wUf__X3B9VK4DUA@mail.gmail.com>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <CACGkMEv9H2q0ALywstj4srmzRehCFvzXGB5wUf__X3B9VK4DUA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/3/25 下午2:29, Jason Wang 写道:
> On Mon, Mar 25, 2024 at 10:11 AM Heng Qi <hengqi@linux.alibaba.com> wrote:
>>
>>
>> 在 2024/3/22 下午1:17, Jason Wang 写道:
>>> On Thu, Mar 21, 2024 at 7:46 PM Heng Qi <hengqi@linux.alibaba.com> wrote:
>>>> When the dim worker is scheduled, if it fails to acquire the lock,
>>>> dim may not be able to return to the working state later.
>>>>
>>>> For example, the following single queue scenario:
>>>>     1. The dim worker of rxq0 is scheduled, and the dim status is
>>>>        changed to DIM_APPLY_NEW_PROFILE;
>>>>     2. The ethtool command is holding rtnl lock;
>>>>     3. Since the rtnl lock is already held, virtnet_rx_dim_work fails
>>>>        to acquire the lock and exits;
>>>>
>>>> Then, even if net_dim is invoked again, it cannot work because the
>>>> state is not restored to DIM_START_MEASURE.
>>>>
>>>> Fixes: 6208799553a8 ("virtio-net: support rx netdim")
>>>> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
>>>> ---
>>>>    drivers/net/virtio_net.c | 4 +++-
>>>>    1 file changed, 3 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>>>> index c22d111..0ebe322 100644
>>>> --- a/drivers/net/virtio_net.c
>>>> +++ b/drivers/net/virtio_net.c
>>>> @@ -3563,8 +3563,10 @@ static void virtnet_rx_dim_work(struct work_struct *work)
>>>>           struct dim_cq_moder update_moder;
>>>>           int i, qnum, err;
>>>>
>>>> -       if (!rtnl_trylock())
>>>> +       if (!rtnl_trylock()) {
>>>> +               schedule_work(&dim->work);
>>>>                   return;
>>>> +       }
>>> Patch looks fine but I wonder if a delayed schedule is better.
>> The work in net_dim() core layer uses non-delayed-work, and the two
>> cannot be mixed.
> Well, I think we need first to figure out if delayed work is better here.

I tested a VM with 16 NICs, 128 queues per NIC (2kq total). With dim 
enabled on all queues,
there are many opportunities for contention for rtnl lock, and this 
patch introduces no visible hotspots.
The dim performance is also stable. So I think there doesn't seem to be 
a strong motivation right now.

Thanks,
Heng

>
> Switching to use delayed work for dim seems not hard anyhow.
>
> Thanks
>
>> Thanks,
>> Heng
>>
>>> Thanks
>>>
>>>>           /* Each rxq's work is queued by "net_dim()->schedule_work()"
>>>>            * in response to NAPI traffic changes. Note that dim->profile_ix
>>>> --
>>>> 1.8.3.1
>>>>


