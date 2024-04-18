Return-Path: <netdev+bounces-89036-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 848888A942C
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 09:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39BF61F22405
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 07:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB793C473;
	Thu, 18 Apr 2024 07:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="bosLVNIi"
X-Original-To: netdev@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335ED25757
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 07:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713425822; cv=none; b=M28r7gKcZ82Iik0VI299Ybp3+5vRxNawh4WEdGbKKb8uPxQ6FqmRNxjLT8gOP/Uwd5WtbrRgNansy8K5D7GQZEt1s/78LM2xbhx/jEfS/jki5hMVShSgS916FRb2/PNo0CKaMy73kZGSoE3SsR3LZ9A8n6BVQhurTeYu7OMWSYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713425822; c=relaxed/simple;
	bh=fTrQ/YWceSaRRdWxthcHz+8Uq53su8EhvbUEUZjLCig=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CU1PDHwccyrdkCynS1pwAVKuIJGcK4B0l9q46QHikU9zlcxwLw6ddvN0Yj4sM+Wr1FHTs4pW0l3CeUpia4lVP9hNtUiLw7SO9CqhNvqh/Auaf6xGQj3952sEDEGZu+XHS9XnsN/wpDNu7Jrkt8jScErlFig/RK12lwARs2M5SCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=bosLVNIi; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1713425811; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=nPWRaRUZCoDTEtaSZuHhqzBNBIv2Skg8nhh77yFiiu0=;
	b=bosLVNIiAt0TvoKBE8mpUSJqFfAIqaISMqcSmC9iVT3ynswS7rHItf8CEs6N6loa9NRQju7fsDeAZYFhvg0EmWWExApV/6wIJq3Fqc4Zk85dLWL9f+pBLayu/FRXqDEnb6cGZeN3zR8yFzkaW/Hq4puy1NUAPA71q2jlPxZkwqo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R891e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0W4njeN3_1713425809;
Received: from 30.221.148.242(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W4njeN3_1713425809)
          by smtp.aliyun-inc.com;
          Thu, 18 Apr 2024 15:36:50 +0800
Message-ID: <28e45768-5091-484d-b09e-4a63bc72a549@linux.alibaba.com>
Date: Thu, 18 Apr 2024 15:36:48 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 3/6] virtio_net: Add a lock for the command
 VQ.
To: Jason Wang <jasowang@redhat.com>, Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, mst@redhat.com, xuanzhuo@linux.alibaba.com,
 virtualization@lists.linux.dev, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, jiri@nvidia.com
References: <20240416193039.272997-1-danielj@nvidia.com>
 <20240416193039.272997-4-danielj@nvidia.com>
 <CACGkMEsCm3=7FtnsTRx5QJo3ZM0Ko1OEvssWew_tfxm5V=MXvQ@mail.gmail.com>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <CACGkMEsCm3=7FtnsTRx5QJo3ZM0Ko1OEvssWew_tfxm5V=MXvQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/4/18 下午2:42, Jason Wang 写道:
> On Wed, Apr 17, 2024 at 3:31 AM Daniel Jurgens <danielj@nvidia.com> wrote:
>> The command VQ will no longer be protected by the RTNL lock. Use a
>> spinlock to protect the control buffer header and the VQ.
>>
>> Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
>> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
>> ---
>>   drivers/net/virtio_net.c | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> index 0ee192b45e1e..d02f83a919a7 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -282,6 +282,7 @@ struct virtnet_info {
>>
>>          /* Has control virtqueue */
>>          bool has_cvq;
>> +       spinlock_t cvq_lock;
> Spinlock is instead of mutex which is problematic as there's no
> guarantee on when the driver will get a reply. And it became even more
> serious after 0d197a147164 ("virtio-net: add cond_resched() to the
> command waiting loop").
>
> Any reason we can't use mutex?

Hi Jason,

I made a patch set to enable ctrlq's irq on top of this patch set, which 
removes cond_resched().

But I need a little time to test, this is close to fast. So could the 
topic about cond_resched +
spin lock or mutex lock be wait?

Thank you very much!

>
> Thanks
>
>>          /* Host can handle any s/g split between our header and packet data */
>>          bool any_header_sg;
>> @@ -2529,6 +2530,7 @@ static bool virtnet_send_command(struct virtnet_info *vi, u8 class, u8 cmd,
>>          /* Caller should know better */
>>          BUG_ON(!virtio_has_feature(vi->vdev, VIRTIO_NET_F_CTRL_VQ));
>>
>> +       guard(spinlock)(&vi->cvq_lock);
>>          vi->ctrl->status = ~0;
>>          vi->ctrl->hdr.class = class;
>>          vi->ctrl->hdr.cmd = cmd;
>> @@ -4818,8 +4820,10 @@ static int virtnet_probe(struct virtio_device *vdev)
>>              virtio_has_feature(vdev, VIRTIO_F_VERSION_1))
>>                  vi->any_header_sg = true;
>>
>> -       if (virtio_has_feature(vdev, VIRTIO_NET_F_CTRL_VQ))
>> +       if (virtio_has_feature(vdev, VIRTIO_NET_F_CTRL_VQ)) {
>>                  vi->has_cvq = true;
>> +               spin_lock_init(&vi->cvq_lock);
>> +       }
>>
>>          if (virtio_has_feature(vdev, VIRTIO_NET_F_MTU)) {
>>                  mtu = virtio_cread16(vdev,
>> --
>> 2.34.1
>>


