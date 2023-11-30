Return-Path: <netdev+bounces-52510-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B3B7FEF52
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 13:42:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3B6B1C20C64
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 12:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9EED3B1AC;
	Thu, 30 Nov 2023 12:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 596A71B3
	for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 04:42:34 -0800 (PST)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R621e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=hengqi@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0VxRYdGL_1701348150;
Received: from 30.222.48.140(mailfrom:hengqi@linux.alibaba.com fp:SMTPD_---0VxRYdGL_1701348150)
          by smtp.aliyun-inc.com;
          Thu, 30 Nov 2023 20:42:31 +0800
Message-ID: <dd8d0c1f-f1ef-42e3-b6a9-24fb5c82f881@linux.alibaba.com>
Date: Thu, 30 Nov 2023 20:42:27 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 4/4] virtio-net: support rx netdim
To: Paolo Abeni <pabeni@redhat.com>,
 virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
Cc: jasowang@redhat.com, mst@redhat.com, kuba@kernel.org,
 edumazet@google.com, davem@davemloft.net, hawk@kernel.org,
 john.fastabend@gmail.com, ast@kernel.org, horms@kernel.org,
 xuanzhuo@linux.alibaba.com, yinjun.zhang@corigine.com
References: <cover.1701050450.git.hengqi@linux.alibaba.com>
 <12c0a070d31f29e394b78a8abb4c009274b8a88c.1701050450.git.hengqi@linux.alibaba.com>
 <8d2ee27f10a7a6c9414f10e8c0155c090b5f11e3.camel@redhat.com>
 <6f78d5e0-a8a8-463e-938c-9a9b49cf106f@linux.alibaba.com>
 <4608e204307b1fb16e1f98e0a9c52e6ce2d0a3db.camel@redhat.com>
From: Heng Qi <hengqi@linux.alibaba.com>
In-Reply-To: <4608e204307b1fb16e1f98e0a9c52e6ce2d0a3db.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2023/11/30 下午8:23, Paolo Abeni 写道:
> On Thu, 2023-11-30 at 20:09 +0800, Heng Qi wrote:
>> 在 2023/11/30 下午5:33, Paolo Abeni 写道:
>>> On Mon, 2023-11-27 at 10:55 +0800, Heng Qi wrote:
>>>> @@ -4738,11 +4881,14 @@ static void remove_vq_common(struct virtnet_info *vi)
>>>>    static void virtnet_remove(struct virtio_device *vdev)
>>>>    {
>>>>    	struct virtnet_info *vi = vdev->priv;
>>>> +	int i;
>>>>    
>>>>    	virtnet_cpu_notif_remove(vi);
>>>>    
>>>>    	/* Make sure no work handler is accessing the device. */
>>>>    	flush_work(&vi->config_work);
>>>> +	for (i = 0; i < vi->max_queue_pairs; i++)
>>>> +		cancel_work(&vi->rq[i].dim.work);
>>> If the dim work is still running here, what prevents it from completing
>>> after the following unregister/free netdev?
>> Yes, no one here is trying to stop it,
> So it will cause UaF, right?
>
>> the situation is like
>> unregister/free netdev
>> when rss are being set, so I think this is ok.
>   
> Could you please elaborate more the point?

If I'm not wrong, I think the following 2 scenarios are similar:

Scen2 1:
1. User uses ethtool to configure rss settings
2. ethtool core holds rtnl_lock
2. virtnet_remove() is called
3. virtnet_send_command() is called.

Scene 2:
1. virtnet_poll() queues a virtnet_rx_dim_work()
1. virtnet_rx_dim_work() is called and holds rtnl_lock
2. virtnet_remove() is called
3. virtnet_send_command() is called.

So I think it's ok to use cancel_work() here.
What do you think? :)

>
>>> It looks like you want need to call cancel_work_sync here?
>> In v4, Yinjun Zhang mentioned that _sync() can cause deadlock[1].
>> Therefore, cancel_work() is used here instead of cancel_work_sync() to
>> avoid possible deadlock.
>>
>> [1]
>> https://lore.kernel.org/all/20231122092939.1005591-1-yinjun.zhang@corigine.com/
> Here the call to cancel_work() happens while the caller does not held
> the rtnl lock, the deadlock reported above will not be triggered.

There's cancel_work_sync() in v4 and I did reproduce the deadlock.

rtnl_lock held -> .ndo_stop() -> cancel_work_sync() -> 
virtnet_rx_dim_work(),
the work acquires the rtnl_lock again, then a deadlock occurs.

I tested the scenario of ctrl cmd/.remove/.ndo_stop()/dim_work when there is
a big concurrency, and cancel_work() works well.

Thanks!

>
>>> Additionally the later remove_vq_common() will needless call
>>> cancel_work() again;
>> Yes. remove_vq_common() now does not call cancel_work().
> I'm sorry, I missread the context in a previous chunk.
>
> The other point should still apply.
>
> Cheers,
>
> Paolo


