Return-Path: <netdev+bounces-50404-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D53D7F5A1D
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 09:34:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A867B20F9A
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 08:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8898BE3;
	Thu, 23 Nov 2023 08:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CEE9D43
	for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 00:34:45 -0800 (PST)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R841e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VwypgXW_1700728482;
Received: from 30.221.145.52(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0VwypgXW_1700728482)
          by smtp.aliyun-inc.com;
          Thu, 23 Nov 2023 16:34:43 +0800
Message-ID: <e1e824ba-78dc-4a65-912d-4ef7f4175a51@linux.alibaba.com>
Date: Thu, 23 Nov 2023 16:34:40 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 4/4] virtio-net: support rx netdim
To: Yinjun Zhang <yinjun.zhang@corigine.com>
Cc: ast@kernel.org, davem@davemloft.net, edumazet@google.com,
 hawk@kernel.org, horms@kernel.org, jasowang@redhat.com,
 john.fastabend@gmail.com, kuba@kernel.org, mst@redhat.com,
 netdev@vger.kernel.org, pabeni@redhat.com,
 virtualization@lists.linux-foundation.org, xuanzhuo@linux.alibaba.com
References: <c00b526f32d9f9a5cd2e98a212ee5306d6b6d71c.1700478183.git.hengqi@linux.alibaba.com>
 <20231122092939.1005591-1-yinjun.zhang@corigine.com>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <20231122092939.1005591-1-yinjun.zhang@corigine.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2023/11/22 下午5:29, Yinjun Zhang 写道:
> On Mon, 20 Nov 2023 20:37:34 +0800, Heng Qi wrote:
> <...>
>> @@ -2179,6 +2220,7 @@ static void virtnet_disable_queue_pair(struct virtnet_info *vi, int qp_index)
>>   	virtnet_napi_tx_disable(&vi->sq[qp_index].napi);
>>   	napi_disable(&vi->rq[qp_index].napi);
>>   	xdp_rxq_info_unreg(&vi->rq[qp_index].xdp_rxq);
>> +	cancel_work_sync(&vi->rq[qp_index].dim.work);
> I'm not sure, but please check if here may cause deadlock:
>   rtnl_lock held ->
>   .ndo_stop ->
>   virtnet_disable_queue_pair() ->
>   cancel_work_sync() ->
>   virtnet_rx_dim_work() ->
>   rtnl_lock()

Good catch!

I tried using cancel_work() which solves the problem. Additionally I 
tested the
scenario of ctrl cmd/.remove/.ndo_stop()/dim_work when there is a lot of 
concurrency,
and this can work very well.

Thanks!

>
>>   }
>>   
>>   static int virtnet_enable_queue_pair(struct virtnet_info *vi, int qp_index)
> <...>


