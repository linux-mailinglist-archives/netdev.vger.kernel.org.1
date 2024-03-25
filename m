Return-Path: <netdev+bounces-81454-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC3F889A9F
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 11:32:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C1641C2690C
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 10:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B47AB142908;
	Mon, 25 Mar 2024 05:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="jCU/53zX"
X-Original-To: netdev@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207361514FE
	for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 02:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711332701; cv=none; b=GAcUJQ3KcldQVEWUHHe0Yo3uvDk+KjiFiM+Wf8HwNd/6iC6VKCg+Fmej2pw4NbuL71ShWOovxOyOSaGlZZmwKDjrajasfCFhT8Rk9OZzMDoC3s9vbiW0t3WOkc5YX1ASX0xOxU4Z19O7A2Vk3/k2swHXGcMHjLPzOFo8HUT3Dxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711332701; c=relaxed/simple;
	bh=ERBwTcCRR7JfAh9Bqn1NavkHYZ2+HQ+GxQVq4GtLf5k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FfaL6GaJE10vAFHQl28wthXfM36e6kp0wup9MmLjRuPcRy1HdTjDze3P75GwrmgFn/3pw4GOgUcVvV/Qc+5DqloP8s06Qbg94+MQadhlgbYfEa2X7FG5gcC7eq9MoNgya116hD5EWpukMuH/iXOR5dQXd1zFvwVeUVN3w6wma1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=jCU/53zX; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711332689; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=tYm0g5gQm89rFEk/IhJUT8xYkoINUjzAQrSyxy54c/0=;
	b=jCU/53zX2lbv4kbBjrQAclML+7aokYmqnCbDxrFOd/8C9AHyeib0d3Yv8/ZHapP8f+L73bs8ef2M4NjNtJotQ6H2SKaq71eK1dVTwnmyuxYDfz+3/23fin3KdJNJ8pQ/YSvUbjtwgvwo7o/N3+f5l8PMMWvp9f+cKw0kwJo3YSg=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0W3868H4_1711332676;
Received: from 30.221.148.153(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0W3868H4_1711332676)
          by smtp.aliyun-inc.com;
          Mon, 25 Mar 2024 10:11:28 +0800
Message-ID: <8d829442-0eef-485c-b448-cd2376c20270@linux.alibaba.com>
Date: Mon, 25 Mar 2024 10:11:16 +0800
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
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <CACGkMEtyujkJ6Gvxr1xV94a_tMzTo48opA+42oBvN-eQ=92StA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/3/22 下午1:17, Jason Wang 写道:
> On Thu, Mar 21, 2024 at 7:46 PM Heng Qi <hengqi@linux.alibaba.com> wrote:
>> When the dim worker is scheduled, if it fails to acquire the lock,
>> dim may not be able to return to the working state later.
>>
>> For example, the following single queue scenario:
>>    1. The dim worker of rxq0 is scheduled, and the dim status is
>>       changed to DIM_APPLY_NEW_PROFILE;
>>    2. The ethtool command is holding rtnl lock;
>>    3. Since the rtnl lock is already held, virtnet_rx_dim_work fails
>>       to acquire the lock and exits;
>>
>> Then, even if net_dim is invoked again, it cannot work because the
>> state is not restored to DIM_START_MEASURE.
>>
>> Fixes: 6208799553a8 ("virtio-net: support rx netdim")
>> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
>> ---
>>   drivers/net/virtio_net.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> index c22d111..0ebe322 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -3563,8 +3563,10 @@ static void virtnet_rx_dim_work(struct work_struct *work)
>>          struct dim_cq_moder update_moder;
>>          int i, qnum, err;
>>
>> -       if (!rtnl_trylock())
>> +       if (!rtnl_trylock()) {
>> +               schedule_work(&dim->work);
>>                  return;
>> +       }
> Patch looks fine but I wonder if a delayed schedule is better.

The work in net_dim() core layer uses non-delayed-work, and the two 
cannot be mixed.

Thanks,
Heng

>
> Thanks
>
>>          /* Each rxq's work is queued by "net_dim()->schedule_work()"
>>           * in response to NAPI traffic changes. Note that dim->profile_ix
>> --
>> 1.8.3.1
>>


