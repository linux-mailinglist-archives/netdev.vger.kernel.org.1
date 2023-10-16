Return-Path: <netdev+bounces-41169-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE90B7CA0AC
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 09:35:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76C732814FD
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 07:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094FC16423;
	Mon, 16 Oct 2023 07:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CBD154A3
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 07:35:31 +0000 (UTC)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AB54D9
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 00:35:29 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VuCobbW_1697441724;
Received: from 30.221.149.148(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0VuCobbW_1697441724)
          by smtp.aliyun-inc.com;
          Mon, 16 Oct 2023 15:35:26 +0800
Message-ID: <5244489d-333b-467f-ac16-ba060c5288c7@linux.alibaba.com>
Date: Mon, 16 Oct 2023 15:35:21 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/5] virtio-net: support dynamic coalescing
 moderation
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eric Dumazet <edumazet@google.com>,
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, "Liu, Yujie" <yujie.liu@intel.com>
References: <cover.1697093455.git.hengqi@linux.alibaba.com>
 <CACGkMEthktJjPdptHo3EDQxjRqdPELOSbMw4k-d0MyYmR4i9KA@mail.gmail.com>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <CACGkMEthktJjPdptHo3EDQxjRqdPELOSbMw4k-d0MyYmR4i9KA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



在 2023/10/12 下午4:29, Jason Wang 写道:
> On Thu, Oct 12, 2023 at 3:44 PM Heng Qi <hengqi@linux.alibaba.com> wrote:
>> Now, virtio-net already supports per-queue moderation parameter
>> setting. Based on this, we use the netdim library of linux to support
>> dynamic coalescing moderation for virtio-net.
>>
>> Due to hardware scheduling issues, we only tested rx dim.
> Do you have PPS numbers? And TX numbers are also important as the
> throughput could be misleading due to various reasons.

OK, will reply until the test environment is ready (the test machine is 
currently locked by someone else).

Thanks!

>
> Thanks
>
>> @Test env
>> rxq0 has affinity to cpu0.
>>
>> @Test cmd
>> client: taskset -c 0 sockperf tp -i ${IP} -t 30 --tcp -m ${msg_size}
>> server: taskset -c 0 sockperf sr --tcp
>>
>> @Test res
>> The second column is the ratio of the result returned by client
>> when rx dim is enabled to the result returned by client when
>> rx dim is disabled.
>>          --------------------------------------
>>          | msg_size |  rx_dim=on / rx_dim=off |
>>          --------------------------------------
>>          |   14B    |         + 3%            |
>>          --------------------------------------
>>          |   100B   |         + 16%           |
>>          --------------------------------------
>>          |   500B   |         + 25%           |
>>          --------------------------------------
>>          |   1400B  |         + 28%           |
>>          --------------------------------------
>>          |   2048B  |         + 22%           |
>>          --------------------------------------
>>          |   4096B  |         + 5%            |
>>          --------------------------------------
>>
>> ---
>> This patch set was part of the previous netdim patch set[1].
>> [1] was split into a merged bugfix set[2] and the current set.
>> The previous relevant commentators have been Cced.
>>
>> [1] https://lore.kernel.org/all/20230811065512.22190-1-hengqi@linux.alibaba.com/
>> [2] https://lore.kernel.org/all/cover.1696745452.git.hengqi@linux.alibaba.com/
>>
>> Heng Qi (5):
>>    virtio-net: returns whether napi is complete
>>    virtio-net: separate rx/tx coalescing moderation cmds
>>    virtio-net: extract virtqueue coalescig cmd for reuse
>>    virtio-net: support rx netdim
>>    virtio-net: support tx netdim
>>
>>   drivers/net/virtio_net.c | 394 ++++++++++++++++++++++++++++++++-------
>>   1 file changed, 322 insertions(+), 72 deletions(-)
>>
>> --
>> 2.19.1.6.gb485710b
>>
>>


