Return-Path: <netdev+bounces-33722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA4B79F84C
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 04:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D3F8281D8A
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 02:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A6A57E3;
	Thu, 14 Sep 2023 02:44:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F33D7F
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 02:44:25 +0000 (UTC)
Received: from out-218.mta1.migadu.com (out-218.mta1.migadu.com [IPv6:2001:41d0:203:375::da])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86AB9E6C
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 19:44:24 -0700 (PDT)
Message-ID: <dfe6cf9b-7cf9-f938-8ab1-a2d4c7741c64@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1694659462;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BGWpTABKSaIW7hxP7IMITxALKfibGVZu4WYwg1dXZeI=;
	b=VxedqEWv4RYa3FnYvC2tK0gFvXFn5F1XNkpgw8TENyAlN9OvCmiRqCY9RseoMg17HIjNHD
	v7yuJel2dSFX42c0Pb5yeIOinuB1Yk00sOqiGC9WzsvqMTUKLrVXZ1VWUHI7icKsuHY4qk
	uKwaJUAMCjHhIgtf/Nz5KqE0FiBo0vc=
Date: Thu, 14 Sep 2023 10:44:14 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] net/core: Export dev_core_stats_rx_dropped_inc sets
Content-Language: en-US
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20230911082016.3694700-1-yajun.deng@linux.dev>
 <9a1de9b3-b3cf-d26b-388e-c98294580bca@intel.com>
 <599cdff8-4865-3ade-0439-36e337891ca0@linux.dev>
 <e6de7c0b-97cc-090e-a331-dc566019f54e@intel.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yajun Deng <yajun.deng@linux.dev>
In-Reply-To: <e6de7c0b-97cc-090e-a331-dc566019f54e@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 2023/9/13 17:58, Alexander Lobakin wrote:
> From: Yajun Deng <yajun.deng@linux.dev>
> Date: Wed, 13 Sep 2023 10:08:08 +0800
>
>> On 2023/9/13 00:22, Alexander Lobakin wrote:
>>> From: Yajun Deng <yajun.deng@linux.dev>
>>> Date: Mon, 11 Sep 2023 16:20:16 +0800
> [...]
>
>>> EXPORT_SYMBOL_GPL(dev_core_stats_inc); // Why not GPL BTW?
>> This may be a better option.
>>
>> Just because EXPORT_SYMBOL(netdev_core_stats_alloc) before,  but I think
>>
>> EXPORT_SYMBOL_GPL is better.
> Ah I see. BTW, if you will still define increment functions as
> externals, there will be no reason to export netdev_core_stats_alloc()
> or even make it non-static at all.
>
>>   
>>> And then build inlines:
>>>
>>> #define DEV_CORE_STATS_INC(FIELD)				\
>>> static inline void						\
>>> dev_core_stats_##FIELD##_inc(struct net_device *dev)		\
>>> {								\
>>> 	dev_core_stats_inc(dev,					\
>>> 		offsetof(struct net_device_core_stats, FIELD));	\
>>> }
>>>
>>> DEV_CORE_STATS_INC(rx_dropped);
>>> ...
>>>
>>> OR even just make them macros
>>>
>>> #define __DEV_CORE_STATS_INC(dev, field)			\
>>> 	dev_core_stats_inc(dev,					\
>>> 		offsetof(struct net_device_core_stats, field))
>>>
>>> #define dev_core_stats_rx_dropped_inc(dev)			\
>>> 	__DEV_CORE_STATS_INC(dev, rx_dropped)
>>> ...
>> I would like the former.  Keep it the same as before.
> By "the former" you mean to build static inlines or externals? Seems
> like the first one, but I got confused by your "the same as before" :D
>
>>
>>> Just don't copy that awful Thunderbird's line wrap and don't assume this
>>> code builds and works and that is something finished/polished.
>>>
>>> You'll be able to trace functions and you'll be able to understand which
>>> counter has been incremented by checking the second argument, i.e. the
>>> field offset (IIRC tracing shows you arguments).
>>> And that way you wouldn't geometrically increase the number of symbol
>>> exports and deal with its consequences.
>> I agree that.
> Ok, after this one I guess you meant "I'd like to use your approach with
> static inlines".

Finally, I give up this approach.

The new function dev_core_stats_inc() didn't called by external modules 
directly.

So EXPORT_SYMBOL_GPL(dev_core_stats_inc) can be removed by anyone.


>>>>   
>>>>   /**
>>>>    *	dev_get_stats	- get network device statistics
>>> Thanks,
>>> Olek
> Thanks,
> Olek

