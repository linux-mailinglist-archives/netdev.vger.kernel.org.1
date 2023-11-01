Return-Path: <netdev+bounces-45530-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4834A7DDE97
	for <lists+netdev@lfdr.de>; Wed,  1 Nov 2023 10:40:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 788A41C20BCD
	for <lists+netdev@lfdr.de>; Wed,  1 Nov 2023 09:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C827480;
	Wed,  1 Nov 2023 09:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0174B5680
	for <netdev@vger.kernel.org>; Wed,  1 Nov 2023 09:40:42 +0000 (UTC)
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A93EADA
	for <netdev@vger.kernel.org>; Wed,  1 Nov 2023 02:40:39 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VvRl.bA_1698831633;
Received: from 30.221.147.182(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0VvRl.bA_1698831633)
          by smtp.aliyun-inc.com;
          Wed, 01 Nov 2023 17:40:34 +0800
Message-ID: <707be7fa-3bb7-46c5-bb34-ef2900fe473f@linux.alibaba.com>
Date: Wed, 1 Nov 2023 17:40:30 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/5] virtio-net: support dynamic coalescing
 moderation
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, netdev@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eric Dumazet <edumazet@google.com>,
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, "Liu, Yujie" <yujie.liu@intel.com>
References: <cover.1697093455.git.hengqi@linux.alibaba.com>
 <20231025014821-mutt-send-email-mst@kernel.org>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <20231025014821-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2023/10/25 下午1:49, Michael S. Tsirkin 写道:
> On Thu, Oct 12, 2023 at 03:44:04PM +0800, Heng Qi wrote:
>> Now, virtio-net already supports per-queue moderation parameter
>> setting. Based on this, we use the netdim library of linux to support
>> dynamic coalescing moderation for virtio-net.
>>
>> Due to hardware scheduling issues, we only tested rx dim.
> So patches 1 to 4 look ok but patch 5 is untested - we should
> probably wait until it's tested properly.

Hi, Michael.

For a few reasons (reply to Jason's thread), I won't be trying to push 
tx dim any more in the short term.

Please review the remaining patches.

Thanks a lot!

>
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
>> 	--------------------------------------
>> 	| msg_size |  rx_dim=on / rx_dim=off |
>> 	--------------------------------------
>> 	|   14B    |         + 3%            |
>> 	--------------------------------------
>> 	|   100B   |         + 16%           |
>> 	--------------------------------------
>> 	|   500B   |         + 25%           |
>> 	--------------------------------------
>> 	|   1400B  |         + 28%           |
>> 	--------------------------------------
>> 	|   2048B  |         + 22%           |
>> 	--------------------------------------
>> 	|   4096B  |         + 5%            |
>> 	--------------------------------------
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


