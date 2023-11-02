Return-Path: <netdev+bounces-45640-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E327DEC0B
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 05:54:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE7E41F2242D
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 04:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CBDC1C07;
	Thu,  2 Nov 2023 04:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1316915B8
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 04:54:04 +0000 (UTC)
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E156AC1
	for <netdev@vger.kernel.org>; Wed,  1 Nov 2023 21:54:01 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R271e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VvUkqbl_1698900835;
Received: from 30.221.148.113(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0VvUkqbl_1698900835)
          by smtp.aliyun-inc.com;
          Thu, 02 Nov 2023 12:53:57 +0800
Message-ID: <8a0ab590-fc90-4018-a2ef-dbfdf7df424d@linux.alibaba.com>
Date: Thu, 2 Nov 2023 12:53:53 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/5] virtio-net: support dynamic coalescing
 moderation
From: Heng Qi <hengqi@linux.alibaba.com>
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
 <753ac6da-f7f1-4acb-9184-e59271809c6d@linux.alibaba.com>
 <CACGkMEsRVV9mgVe2+Qe89QZD807KV8jyBmAz5--Z3NiZBPrPVg@mail.gmail.com>
 <6f324788-216e-4998-9fad-f8e7d27b4261@linux.alibaba.com>
In-Reply-To: <6f324788-216e-4998-9fad-f8e7d27b4261@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2023/11/2 下午12:51, Heng Qi 写道:
>
>
> 在 2023/11/2 下午12:34, Jason Wang 写道:
>> On Wed, Nov 1, 2023 at 5:38 PM Heng Qi <hengqi@linux.alibaba.com> wrote:
>>>
>>>
>>> 在 2023/10/25 上午9:18, Jason Wang 写道:
>>>> On Tue, Oct 24, 2023 at 8:03 PM Heng Qi <hengqi@linux.alibaba.com> 
>>>> wrote:
>>>>>
>>>>> 在 2023/10/12 下午4:29, Jason Wang 写道:
>>>>>> On Thu, Oct 12, 2023 at 3:44 PM Heng Qi 
>>>>>> <hengqi@linux.alibaba.com> wrote:
>>>>>>> Now, virtio-net already supports per-queue moderation parameter
>>>>>>> setting. Based on this, we use the netdim library of linux to 
>>>>>>> support
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
>>> Hi, Jason.
>>>
>>> Sorry for the late reply to this! Our team has been blocked by other
>>> priorities the past few days.
>>>
>>> For tx dim, we have a fixed empirical value internally.
>>> This value performs better overall than manually adjusting the tx timer
>>> register -->
>>> I'll do not have tx numbers. :( So in the short term I no longer try to
>>> push [5/5]
>>> patch for tx dim and try to return -EOPNOTSUPP for it, sorry for this.
>>>
>>>> about 10 years ago.
>>>>
>>>> I will start to review the series but let's try to have some TX 
>>>> numbers as well.
>>>>
>>>> Btw, it would be more convenient to have a raw PPS benchmark. E.g you
>>> I got some raw pps data using pktgen from linux/sample/pktgen:
>>>
>>> 1. tx cmd
>>> ./pktgen_sample02_multiqueue.sh -i eth1 -s 44 -d ${dst_ip} -m 
>>> ${dst_mac}
>>> -t 8 -f 0 -n 0
>>>
>>> This uses 8 kpktgend threads to inject data into eth1.
>>>
>>> 2. Rx side loads a simple xdp prog which drops all received udp 
>>> packets.
>>>
>>> 3. Data
>>> pps: ~1000w
>> For "w" did you mean 10 million? Looks too huge to me?
>
> Yes, all cpus in tx are 100% sys, rx uses xdp to drop all received udp 
> packets.
> Then this means rx receiving ability is strong.
>
> If there was no xdp in rx, I remember tx sent 10million pps, but rx 
> could only receive 7.3+ million pps.

In addition, in the test environment of pktgen, rx has 8 cpu and 8 queue.

Thanks!

>
> Thanks!
>
>>
>>> rx dim off: cpu idle= ~35%
>>> rx dim on: cpu idle= ~76%
>> This looks promising.
>>
>> Thanks
>>
>>> Thanks!
>>>
>>>> can try to use a software or hardware packet generator.
>>>>
>>>> Thanks
>>>>
>>>>> I. Sockperf UDP
>>>>> =================================================
>>>>> 1. Env
>>>>> rxq_0 is affinity to cpu_0
>>>>>
>>>>> 2. Cmd
>>>>> client:  taskset -c 0 sockperf tp -p 8989 -i $IP -t 10 -m 16B
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
>>>>> dim off:   978437.23
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
>>>>> dim off:   877931.67
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
>>>>>>> client: taskset -c 0 sockperf tp -i ${IP} -t 30 --tcp -m 
>>>>>>> ${msg_size}
>>>>>>> server: taskset -c 0 sockperf sr --tcp
>>>>>>>
>>>>>>> @Test res
>>>>>>> The second column is the ratio of the result returned by client
>>>>>>> when rx dim is enabled to the result returned by client when
>>>>>>> rx dim is disabled.
>>>>>>>            --------------------------------------
>>>>>>>            | msg_size |  rx_dim=on / rx_dim=off |
>>>>>>>            --------------------------------------
>>>>>>>            |   14B    |         + 3%            |
>>>>>>>            --------------------------------------
>>>>>>>            |   100B   |         + 16%           |
>>>>>>>            --------------------------------------
>>>>>>>            |   500B   |         + 25%           |
>>>>>>>            --------------------------------------
>>>>>>>            |   1400B  |         + 28%           |
>>>>>>>            --------------------------------------
>>>>>>>            |   2048B  |         + 22%           |
>>>>>>>            --------------------------------------
>>>>>>>            |   4096B  |         + 5%            |
>>>>>>>            --------------------------------------
>>>>>>>
>>>>>>> ---
>>>>>>> This patch set was part of the previous netdim patch set[1].
>>>>>>> [1] was split into a merged bugfix set[2] and the current set.
>>>>>>> The previous relevant commentators have been Cced.
>>>>>>>
>>>>>>> [1] 
>>>>>>> https://lore.kernel.org/all/20230811065512.22190-1-hengqi@linux.alibaba.com/
>>>>>>> [2] 
>>>>>>> https://lore.kernel.org/all/cover.1696745452.git.hengqi@linux.alibaba.com/
>>>>>>>
>>>>>>> Heng Qi (5):
>>>>>>>      virtio-net: returns whether napi is complete
>>>>>>>      virtio-net: separate rx/tx coalescing moderation cmds
>>>>>>>      virtio-net: extract virtqueue coalescig cmd for reuse
>>>>>>>      virtio-net: support rx netdim
>>>>>>>      virtio-net: support tx netdim
>>>>>>>
>>>>>>>     drivers/net/virtio_net.c | 394 
>>>>>>> ++++++++++++++++++++++++++++++++-------
>>>>>>>     1 file changed, 322 insertions(+), 72 deletions(-)
>>>>>>>
>>>>>>> -- 
>>>>>>> 2.19.1.6.gb485710b
>>>>>>>
>>>>>>>
>


