Return-Path: <netdev+bounces-45638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DB6CC7DEC03
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 05:47:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42382B210FC
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 04:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14D710EF;
	Thu,  2 Nov 2023 04:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6DA51FA1
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 04:47:40 +0000 (UTC)
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A57A6
	for <netdev@vger.kernel.org>; Wed,  1 Nov 2023 21:47:38 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R641e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VvUWJ74_1698900424;
Received: from 30.221.148.113(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0VvUWJ74_1698900424)
          by smtp.aliyun-inc.com;
          Thu, 02 Nov 2023 12:47:33 +0800
Message-ID: <7b8050c6-f393-4b6c-971e-1f9aa798d110@linux.alibaba.com>
Date: Thu, 2 Nov 2023 12:47:32 +0800
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
 <d215566f-8185-463b-aa0b-5925f2a0853c@linux.alibaba.com>
 <CACGkMEseRoUBHOJ2CgPqVe=HNkAJqdj+Sh3pWsRaPCvcjwD9Gw@mail.gmail.com>
 <20231025015243-mutt-send-email-mst@kernel.org>
 <d3b9e9e8-1ef4-48ac-8a2f-4fa647ae4372@linux.alibaba.com>
 <CACGkMEsQ4oDbXPQZ2boB-Bj36qzWs9Sx_Du9ZiJLe+-99DOtwQ@mail.gmail.com>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <CACGkMEsQ4oDbXPQZ2boB-Bj36qzWs9Sx_Du9ZiJLe+-99DOtwQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2023/11/2 下午12:33, Jason Wang 写道:
> On Wed, Nov 1, 2023 at 7:03 PM Heng Qi <hengqi@linux.alibaba.com> wrote:
>>
>>
>> 在 2023/10/25 下午1:53, Michael S. Tsirkin 写道:
>>> On Wed, Oct 25, 2023 at 09:18:27AM +0800, Jason Wang wrote:
>>>> On Tue, Oct 24, 2023 at 8:03 PM Heng Qi <hengqi@linux.alibaba.com> wrote:
>>>>>
>>>>> 在 2023/10/12 下午4:29, Jason Wang 写道:
>>>>>> On Thu, Oct 12, 2023 at 3:44 PM Heng Qi <hengqi@linux.alibaba.com> wrote:
>>>>>>> Now, virtio-net already supports per-queue moderation parameter
>>>>>>> setting. Based on this, we use the netdim library of linux to support
>>>>>>> dynamic coalescing moderation for virtio-net.
>>>>>>>
>>>>>>> Due to hardware scheduling issues, we only tested rx dim.
>>>>>> Do you have PPS numbers? And TX numbers are also important as the
>>>>>> throughput could be misleading due to various reasons.
>>>>> Hi Jason!
>>>>>
>>>>> The comparison of rx netdim performance is as follows:
>>>>> (the backend supporting tx dim is not yet ready)
>>>> Thanks a lot for the numbers.
>>>>
>>>> I'd still expect the TX result as I did play tx interrupt coalescing
>>>> about 10 years ago.
>>>>
>>>> I will start to review the series but let's try to have some TX numbers as well.
>>>>
>>>> Btw, it would be more convenient to have a raw PPS benchmark. E.g you
>>>> can try to use a software or hardware packet generator.
>>>>
>>>> Thanks
>>> Latency results are also kind of interesting.
>> I test the latency using sockperf pp:
>>
>> @Rx cmd
>> taskset -c 0 sockperf sr -p 8989
>>
>> @Tx cmd
>> taskset -c 0 sockperf pp -i ${ip} -p 8989 -t 10
>>
>> After running this cmd 5 times and averaging the results,
>> we get the following data:
>>
>> dim off: 17.7735 usec
>> dim on: 18.0110 usec
> Let's add those numbers to the changelog of the next version.

Ok. Thanks!

>
> Thanks
>
>> Thanks!
>>
>>>
>>>>> I. Sockperf UDP
>>>>> =================================================
>>>>> 1. Env
>>>>> rxq_0 is affinity to cpu_0
>>>>>
>>>>> 2. Cmd
>>>>> client:  taskset -c 0 sockperf tp -p 8989 -i $IP -t 10 -m 16B
>>>>> server: taskset -c 0 sockperf sr -p 8989
>>>>>
>>>>> 3. Result
>>>>> dim off: 1143277.00 rxpps, throughput 17.844 MBps, cpu is 100%.
>>>>> dim on: 1124161.00 rxpps, throughput 17.610 MBps, cpu is 83.5%.
>>>>> =================================================
>>>>>
>>>>>
>>>>> II. Redis
>>>>> =================================================
>>>>> 1. Env
>>>>> There are 8 rxqs and rxq_i is affinity to cpu_i.
>>>>>
>>>>> 2. Result
>>>>> When all cpus are 100%, ops/sec of memtier_benchmark client is
>>>>> dim off:   978437.23
>>>>> dim on: 1143638.28
>>>>> =================================================
>>>>>
>>>>>
>>>>> III. Nginx
>>>>> =================================================
>>>>> 1. Env
>>>>> There are 8 rxqs and rxq_i is affinity to cpu_i.
>>>>>
>>>>> 2. Result
>>>>> When all cpus are 100%, requests/sec of wrk client is
>>>>> dim off:   877931.67
>>>>> dim on: 1019160.31
>>>>> =================================================
>>>>>
>>>>> Thanks!
>>>>>
>>>>>> Thanks
>>>>>>
>>>>>>> @Test env
>>>>>>> rxq0 has affinity to cpu0.
>>>>>>>
>>>>>>> @Test cmd
>>>>>>> client: taskset -c 0 sockperf tp -i ${IP} -t 30 --tcp -m ${msg_size}
>>>>>>> server: taskset -c 0 sockperf sr --tcp
>>>>>>>
>>>>>>> @Test res
>>>>>>> The second column is the ratio of the result returned by client
>>>>>>> when rx dim is enabled to the result returned by client when
>>>>>>> rx dim is disabled.
>>>>>>>            --------------------------------------
>>>>>>>            | msg_size |  rx_dim=on / rx_dim=off |
>>>>>>>            --------------------------------------
>>>>>>>            |   14B    |         + 3%            |
>>>>>>>            --------------------------------------
>>>>>>>            |   100B   |         + 16%           |
>>>>>>>            --------------------------------------
>>>>>>>            |   500B   |         + 25%           |
>>>>>>>            --------------------------------------
>>>>>>>            |   1400B  |         + 28%           |
>>>>>>>            --------------------------------------
>>>>>>>            |   2048B  |         + 22%           |
>>>>>>>            --------------------------------------
>>>>>>>            |   4096B  |         + 5%            |
>>>>>>>            --------------------------------------
>>>>>>>
>>>>>>> ---
>>>>>>> This patch set was part of the previous netdim patch set[1].
>>>>>>> [1] was split into a merged bugfix set[2] and the current set.
>>>>>>> The previous relevant commentators have been Cced.
>>>>>>>
>>>>>>> [1] https://lore.kernel.org/all/20230811065512.22190-1-hengqi@linux.alibaba.com/
>>>>>>> [2] https://lore.kernel.org/all/cover.1696745452.git.hengqi@linux.alibaba.com/
>>>>>>>
>>>>>>> Heng Qi (5):
>>>>>>>      virtio-net: returns whether napi is complete
>>>>>>>      virtio-net: separate rx/tx coalescing moderation cmds
>>>>>>>      virtio-net: extract virtqueue coalescig cmd for reuse
>>>>>>>      virtio-net: support rx netdim
>>>>>>>      virtio-net: support tx netdim
>>>>>>>
>>>>>>>     drivers/net/virtio_net.c | 394 ++++++++++++++++++++++++++++++++-------
>>>>>>>     1 file changed, 322 insertions(+), 72 deletions(-)
>>>>>>>
>>>>>>> --
>>>>>>> 2.19.1.6.gb485710b
>>>>>>>
>>>>>>>


