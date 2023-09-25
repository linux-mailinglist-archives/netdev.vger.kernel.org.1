Return-Path: <netdev+bounces-36071-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF6F7ACE6F
	for <lists+netdev@lfdr.de>; Mon, 25 Sep 2023 04:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 005212813F6
	for <lists+netdev@lfdr.de>; Mon, 25 Sep 2023 02:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0C6A54;
	Mon, 25 Sep 2023 02:48:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74337F
	for <netdev@vger.kernel.org>; Mon, 25 Sep 2023 02:47:58 +0000 (UTC)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B7892
	for <netdev@vger.kernel.org>; Sun, 24 Sep 2023 19:47:56 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R821e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VsjzwhS_1695610072;
Received: from 30.221.149.55(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0VsjzwhS_1695610072)
          by smtp.aliyun-inc.com;
          Mon, 25 Sep 2023 10:47:53 +0800
Message-ID: <2fd44af7-3111-4734-bed4-944cd075e820@linux.alibaba.com>
Date: Mon, 25 Sep 2023 10:47:47 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 5/6] virtio-net: fix the vq coalescing setting for vq
 resize
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
 "Michael S . Tsirkin" <mst@redhat.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Gavin Li <gavinl@nvidia.com>
References: <20230919074915.103110-1-hengqi@linux.alibaba.com>
 <20230919074915.103110-6-hengqi@linux.alibaba.com>
 <CACGkMEuJjxAmr6WC9ETYAw2K9dp0AUoD6LSZCduQyUQ9y7oM3Q@mail.gmail.com>
 <c95274cd-d119-402b-baf1-0c500472c9fb@linux.alibaba.com>
 <CACGkMEv4me_mjRJ8wEd-w_b9tjo370d6idioCTmFwJo-3TH3-A@mail.gmail.com>
 <2ffd0e15-107e-4c46-8d98-caf47ff6a0c6@linux.alibaba.com>
 <CACGkMEtbCSxOQDmrEySgdEWG49SOi3UFYkLMjmjF6=5m8F93xg@mail.gmail.com>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <CACGkMEtbCSxOQDmrEySgdEWG49SOi3UFYkLMjmjF6=5m8F93xg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



在 2023/9/25 上午10:29, Jason Wang 写道:
> On Fri, Sep 22, 2023 at 3:58 PM Heng Qi <hengqi@linux.alibaba.com> wrote:
>>
>>
>> 在 2023/9/22 下午3:32, Jason Wang 写道:
>>> On Fri, Sep 22, 2023 at 1:02 PM Heng Qi <hengqi@linux.alibaba.com> wrote:
>>>>
>>>> 在 2023/9/22 下午12:29, Jason Wang 写道:
>>>>> On Tue, Sep 19, 2023 at 3:49 PM Heng Qi <hengqi@linux.alibaba.com> wrote:
>>>>>> According to the definition of virtqueue coalescing spec[1]:
>>>>>>
>>>>>>      Upon disabling and re-enabling a transmit virtqueue, the device MUST set
>>>>>>      the coalescing parameters of the virtqueue to those configured through the
>>>>>>      VIRTIO_NET_CTRL_NOTF_COAL_TX_SET command, or, if the driver did not set
>>>>>>      any TX coalescing parameters, to 0.
>>>>>>
>>>>>>      Upon disabling and re-enabling a receive virtqueue, the device MUST set
>>>>>>      the coalescing parameters of the virtqueue to those configured through the
>>>>>>      VIRTIO_NET_CTRL_NOTF_COAL_RX_SET command, or, if the driver did not set
>>>>>>      any RX coalescing parameters, to 0.
>>>>>>
>>>>>> We need to add this setting for vq resize (ethtool -G) where vq_reset happens.
>>>>>>
>>>>>> [1] https://lists.oasis-open.org/archives/virtio-dev/202303/msg00415.html
>>>>>>
>>>>>> Fixes: 394bd87764b6 ("virtio_net: support per queue interrupt coalesce command")
>>>>> I'm not sure this is a real fix as spec allows it to go zero?
>>>> The spec says that if the user has configured interrupt coalescing
>>>> parameters,
>>>> parameters need to be restored after vq_reset, otherwise set to 0.
>>>> vi->intr_coal_tx and vi->intr_coal_rx always save the newest global
>>>> parameters,
>>>> regardless of whether the command is sent or not. So I think we need
>>>> this patch
>>>> it complies with the specification requirements.
>>> How can we make sure the old coalescing parameters still make sense
>>> for the new ring size?
>> I'm not sure, ringsize has a wider range of changes. Maybe we should
>> only keep coalescing
>> parameters in cases where only vq_reset occurs (no ring size change
>> involved)?
> Probably but do we actually have a user other than resize now?

Not yet. What I mean is if there is one in the future, for example in 
xdp's processing etc.,
we can reserve parameters for it.

Thanks

>
> Thanks
>
>> Thanks!
>>
>>> Thanks
>>>
>>>> Thanks!
>>>>
>>>>> Thanks


