Return-Path: <netdev+bounces-43838-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E85B7D4F5C
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 14:03:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EB9E1C20B1A
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 12:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CBDF266D4;
	Tue, 24 Oct 2023 12:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF0D266D0
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 12:02:58 +0000 (UTC)
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0811D7F
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 05:02:55 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R331e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VurHmp2_1698148970;
Received: from 30.221.149.38(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0VurHmp2_1698148970)
          by smtp.aliyun-inc.com;
          Tue, 24 Oct 2023 20:02:51 +0800
Message-ID: <d215566f-8185-463b-aa0b-5925f2a0853c@linux.alibaba.com>
Date: Tue, 24 Oct 2023 20:02:48 +0800
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



在 2023/10/12 下午4:29, Jason Wang 写道:
> On Thu, Oct 12, 2023 at 3:44 PM Heng Qi <hengqi@linux.alibaba.com> wrote:
>> Now, virtio-net already supports per-queue moderation parameter
>> setting. Based on this, we use the netdim library of linux to support
>> dynamic coalescing moderation for virtio-net.
>>
>> Due to hardware scheduling issues, we only tested rx dim.
> Do you have PPS numbers? And TX numbers are also important as the
> throughput could be misleading due to various reasons.

Hi Jason!

The comparison of rx netdim performance is as follows:
(the backend supporting tx dim is not yet ready)


I. Sockperf UDP
=================================================
1. Env
rxq_0 is affinity to cpu_0

2. Cmd
client:  taskset -c 0 sockperf tp -p 8989 -i $IP -t 10 -m 16B
server: taskset -c 0 sockperf sr -p 8989

3. Result
dim off: 1143277.00 rxpps, throughput 17.844 MBps, cpu is 100%.
dim on: 1124161.00 rxpps, throughput 17.610 MBps, cpu is 83.5%.
=================================================


II. Redis
=================================================
1. Env
There are 8 rxqs and rxq_i is affinity to cpu_i.

2. Result
When all cpus are 100%, ops/sec of memtier_benchmark client is
dim off:   978437.23
dim on: 1143638.28
=================================================


III. Nginx
=================================================
1. Env
There are 8 rxqs and rxq_i is affinity to cpu_i.

2. Result
When all cpus are 100%, requests/sec of wrk client is
dim off:   877931.67
dim on: 1019160.31
=================================================

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


