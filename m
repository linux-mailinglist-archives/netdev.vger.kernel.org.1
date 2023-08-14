Return-Path: <netdev+bounces-27208-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7913F77AF41
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 03:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 716381C204F8
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 01:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B84515B2;
	Mon, 14 Aug 2023 01:57:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2080415A6
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 01:57:14 +0000 (UTC)
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46633E54
	for <netdev@vger.kernel.org>; Sun, 13 Aug 2023 18:57:09 -0700 (PDT)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VpeIFCM_1691978224;
Received: from 30.221.149.111(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0VpeIFCM_1691978224)
          by smtp.aliyun-inc.com;
          Mon, 14 Aug 2023 09:57:05 +0800
Message-ID: <f421c31e-02d0-5a51-91ee-49d57d3f1be6@linux.alibaba.com>
Date: Mon, 14 Aug 2023 09:57:03 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH net-next 6/8] virtio-net: support rx netdim
To: Simon Horman <horms@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20230811065512.22190-1-hengqi@linux.alibaba.com>
 <20230811065512.22190-7-hengqi@linux.alibaba.com>
 <ZNfCwDi/NvLR/WTm@vergenet.net>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <ZNfCwDi/NvLR/WTm@vergenet.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-14.3 required=5.0 tests=BAYES_00,
	ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



在 2023/8/13 上午1:34, Simon Horman 写道:
> On Fri, Aug 11, 2023 at 02:55:10PM +0800, Heng Qi wrote:
>> By comparing the traffic information in the complete napi processes,
>> let the virtio-net driver automatically adjust the coalescing
>> moderation parameters of each receive queue.
>>
>> Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
>> ---
>>   drivers/net/virtio_net.c | 124 +++++++++++++++++++++++++++++++++------
>>   1 file changed, 106 insertions(+), 18 deletions(-)
>>
>> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
>> index 0318113bd8c2..3fb801a7a785 100644
>> --- a/drivers/net/virtio_net.c
>> +++ b/drivers/net/virtio_net.c
>> @@ -19,6 +19,7 @@
>>   #include <linux/average.h>
>>   #include <linux/filter.h>
>>   #include <linux/kernel.h>
>> +#include <linux/dim.h>
>>   #include <net/route.h>
>>   #include <net/xdp.h>
>>   #include <net/net_failover.h>
>> @@ -168,8 +169,17 @@ struct receive_queue {
>>   
>>   	struct virtnet_rq_stats stats;
>>   
>> +	/* The number of rx notifications */
>> +	u16 calls;
>> +
>> +	/* Is dynamic interrupt moderation enabled? */
>> +	bool dim_enabled;
>> +
>>   	struct virtnet_interrupt_coalesce intr_coal;
>>   
>> +	/* Dynamic Iterrupt Moderation */
> Hi Heng Qi,
>
> nit: Iterrupt -> interrupt

Hi,

Will fix in the next version ^^

>
>       Also, elsewhere in this patchset.
>
>       ./checkpatch.pl --codespell is your friend here

Ok. I will try this.

Thanks!

>
>> +	struct dim dim;
>> +
>>   	/* Chain pages by the private ptr. */
>>   	struct page *pages;
>>   
> ...


