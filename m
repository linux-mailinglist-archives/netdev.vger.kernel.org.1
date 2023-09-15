Return-Path: <netdev+bounces-33996-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B75457A1372
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 04:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74B06281A0C
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 02:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F375F806;
	Fri, 15 Sep 2023 02:00:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D325836A
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 02:00:17 +0000 (UTC)
Received: from out-224.mta0.migadu.com (out-224.mta0.migadu.com [IPv6:2001:41d0:1004:224b::e0])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4096126A4
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 19:00:17 -0700 (PDT)
Message-ID: <a4b20b86-d6cc-d623-206b-fac3e7336276@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1694743215;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I07btjcoTGwy0N0AeqVOBXPTZEM3pn1yxPZvn66rdQc=;
	b=d8XC3gLs5ka9+pZVPwR1sfcMmhWTqJj+RYNc5FodS6rlwx/JV0XbMbrE4qAkQJzVDyjlzR
	uNWPb3UdIai3gjY785X3hZ/tkn42Cgulu70ASJpQS48A7LHf8hwqzeoo3bhytqdKnXbeRS
	ooOoV9+hWJxQXlBAPznlqVbK6M5TcN4=
Date: Fri, 15 Sep 2023 10:00:07 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v3] net/core: Export dev_core_stats_*_inc()
Content-Language: en-US
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20230914023718.3854545-1-yajun.deng@linux.dev>
 <ef9d4ca5-35e4-ff8c-c1aa-f77a4b04d0a2@intel.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yajun Deng <yajun.deng@linux.dev>
In-Reply-To: <ef9d4ca5-35e4-ff8c-c1aa-f77a4b04d0a2@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 2023/9/14 23:22, Alexander Lobakin wrote:
> From: Yajun Deng <yajun.deng@linux.dev>
> Date: Thu, 14 Sep 2023 10:37:18 +0800
>
>> Although there is a kfree_skb_reason() helper function that can be used to
>> find the reason why this skb is dropped, but most callers didn't increase
>> one of rx_dropped, tx_dropped, rx_nohandler and rx_otherhost_dropped.
>>
>> For the users, people are more concerned about why the dropped in ip
>> is increasing. So we can export dev_core_stats_rx_dropped_inc sets,
>> which users would trace them know why rx_dropped is increasing.
>>
>> Export dev_core_stats_{rx_dropped, tx_dropped, rx_nohandler,
>> rx_otherhost_dropped}_inc for trace. Also, move dev_core_stats()
>> and netdev_core_stats_alloc() to dev.c, as they are not called
>> externally.
> I'd like to hear some arguments against having them static inlines + one
> external that I proposed earlier.

I'd like to hear suggestions from the maintainers. If the maintainers 
have no objections, I'd like to

use your approach.

>> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
>> ---
>> v3: __cold should be added to the netdev_core_stats_alloc().
>> v2: use __cold instead of inline in dev_core_stats().
>> v1: https://lore.kernel.org/netdev/20230911082016.3694700-1-yajun.deng@linux.dev/
> ...as it's not at least mentioned here in the changelog.
>
> [...]
>
>> diff --git a/net/core/dev.c b/net/core/dev.c
>> index ccff2b6ef958..98592e4c1df0 100644
>> --- a/net/core/dev.c
>> +++ b/net/core/dev.c
>> @@ -10475,7 +10475,7 @@ void netdev_stats_to_stats64(struct rtnl_link_stats64 *stats64,
>>   }
>>   EXPORT_SYMBOL(netdev_stats_to_stats64);
>>   
>> -struct net_device_core_stats __percpu *netdev_core_stats_alloc(struct net_device *dev)
>> +static __cold struct net_device_core_stats __percpu *netdev_core_stats_alloc(struct net_device *dev)
> This is way over 79/80 chars, break the line before "netdev_".
Okay.
>
>>   {
>>   	struct net_device_core_stats __percpu *p;
>>   
>> @@ -10488,7 +10488,35 @@ struct net_device_core_stats __percpu *netdev_core_stats_alloc(struct net_device
>>   	/* This READ_ONCE() pairs with the cmpxchg() above */
>>   	return READ_ONCE(dev->core_stats);
>>   }
>> -EXPORT_SYMBOL(netdev_core_stats_alloc);
>> +
>> +static inline struct net_device_core_stats __percpu *dev_core_stats(struct net_device *dev)
> Same for the line length.
> Also notice that now some of the functions you touch have "dev_" prefix,
> others have "netdev_", I'd probably take a look into unifying this.
Okay, I'll unify with the "netdev_" prefix.
> (note for the maintainers that it would be probably better to leave
>   explicit "inline" here, but no bloat-o-meter was provided by the
>   author, so I can't say anything for sure)
>
>> +{
>> +	/* This READ_ONCE() pairs with the write in netdev_core_stats_alloc() */
>> +	struct net_device_core_stats __percpu *p = READ_ONCE(dev->core_stats);
>> +
>> +	if (likely(p))
>> +		return p;
>> +
>> +	return netdev_core_stats_alloc(dev);
>> +}
> [...]
>
> Thanks,
> Olek

