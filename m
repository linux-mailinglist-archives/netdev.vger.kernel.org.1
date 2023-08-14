Return-Path: <netdev+bounces-27233-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A833577B113
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 08:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42330280F7E
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 06:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E79538C;
	Mon, 14 Aug 2023 06:07:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75EE6185D
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 06:07:06 +0000 (UTC)
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 142F9129
	for <netdev@vger.kernel.org>; Sun, 13 Aug 2023 23:07:03 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0VpgMsba_1691993218;
Received: from 30.221.149.111(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0VpgMsba_1691993218)
          by smtp.aliyun-inc.com;
          Mon, 14 Aug 2023 14:06:59 +0800
Message-ID: <252849a7-bf24-007b-a7f4-23ce61ebccb8@linux.alibaba.com>
Date: Mon, 14 Aug 2023 14:06:55 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH net-next 0/8] virtio-net: support dynamic notification
 coalescing moderation
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20230811065512.22190-1-hengqi@linux.alibaba.com>
 <CACGkMEugNDGufpcK0apumz6+MdptoshMPuVWB4Czo1Z5jw1UyA@mail.gmail.com>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <CACGkMEugNDGufpcK0apumz6+MdptoshMPuVWB4Czo1Z5jw1UyA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-14.3 required=5.0 tests=BAYES_00,
	ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



在 2023/8/14 下午12:38, Jason Wang 写道:
> On Fri, Aug 11, 2023 at 2:55 PM Heng Qi <hengqi@linux.alibaba.com> wrote:
>> Now, virtio-net already supports per-queue notification coalescing parameter
>> setting. Based on this, we use the netdim library[1] of linux to support
>> dynamic notification coalescing moderation for virtio-net.
>>
>> [1] https://docs.kernel.org/networking/net_dim.html
> Do you have perf numbers?

We have only tested the control path now. The acquisition of perf 
numbers depends on the
modification of our backend, and it will take a few days. I will bring 
it in the next version!

Thanks!

>
> Thanks
>
>> This series also introduces some extractions and fixes. Please review.
>>
>> Heng Qi (8):
>>    virtio-net: initially change the value of tx-frames
>>    virtio-net: fix mismatch of getting txq tx-frames param
>>    virtio-net: returns whether napi is complete
>>    virtio-net: separate rx/tx coalescing moderation cmds
>>    virtio-net: extract virtqueue coalescig cmd for reuse
>>    virtio-net: support rx netdim
>>    virtio-net: support tx netdim
>>    virtio-net: a tiny comment update
>>
>>   drivers/net/virtio_net.c | 370 +++++++++++++++++++++++++++++++++------
>>   1 file changed, 316 insertions(+), 54 deletions(-)
>>
>> --
>> 2.19.1.6.gb485710b
>>


