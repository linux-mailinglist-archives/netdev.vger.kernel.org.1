Return-Path: <netdev+bounces-35696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4EA57AAB00
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 09:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 98DB428243D
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 07:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA0E1A29F;
	Fri, 22 Sep 2023 07:58:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07EDE14F81
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 07:58:49 +0000 (UTC)
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17E0F195
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 00:58:45 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VschYeO_1695369521;
Received: from 30.221.145.61(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0VschYeO_1695369521)
          by smtp.aliyun-inc.com;
          Fri, 22 Sep 2023 15:58:43 +0800
Message-ID: <2ffd0e15-107e-4c46-8d98-caf47ff6a0c6@linux.alibaba.com>
Date: Fri, 22 Sep 2023 15:58:40 +0800
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
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <CACGkMEv4me_mjRJ8wEd-w_b9tjo370d6idioCTmFwJo-3TH3-A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



在 2023/9/22 下午3:32, Jason Wang 写道:
> On Fri, Sep 22, 2023 at 1:02 PM Heng Qi <hengqi@linux.alibaba.com> wrote:
>>
>>
>> 在 2023/9/22 下午12:29, Jason Wang 写道:
>>> On Tue, Sep 19, 2023 at 3:49 PM Heng Qi <hengqi@linux.alibaba.com> wrote:
>>>> According to the definition of virtqueue coalescing spec[1]:
>>>>
>>>>     Upon disabling and re-enabling a transmit virtqueue, the device MUST set
>>>>     the coalescing parameters of the virtqueue to those configured through the
>>>>     VIRTIO_NET_CTRL_NOTF_COAL_TX_SET command, or, if the driver did not set
>>>>     any TX coalescing parameters, to 0.
>>>>
>>>>     Upon disabling and re-enabling a receive virtqueue, the device MUST set
>>>>     the coalescing parameters of the virtqueue to those configured through the
>>>>     VIRTIO_NET_CTRL_NOTF_COAL_RX_SET command, or, if the driver did not set
>>>>     any RX coalescing parameters, to 0.
>>>>
>>>> We need to add this setting for vq resize (ethtool -G) where vq_reset happens.
>>>>
>>>> [1] https://lists.oasis-open.org/archives/virtio-dev/202303/msg00415.html
>>>>
>>>> Fixes: 394bd87764b6 ("virtio_net: support per queue interrupt coalesce command")
>>> I'm not sure this is a real fix as spec allows it to go zero?
>> The spec says that if the user has configured interrupt coalescing
>> parameters,
>> parameters need to be restored after vq_reset, otherwise set to 0.
>> vi->intr_coal_tx and vi->intr_coal_rx always save the newest global
>> parameters,
>> regardless of whether the command is sent or not. So I think we need
>> this patch
>> it complies with the specification requirements.
> How can we make sure the old coalescing parameters still make sense
> for the new ring size?

I'm not sure, ringsize has a wider range of changes. Maybe we should 
only keep coalescing
parameters in cases where only vq_reset occurs (no ring size change 
involved)?

Thanks!

>
> Thanks
>
>> Thanks!
>>
>>> Thanks


