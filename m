Return-Path: <netdev+bounces-212029-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FCAFB1D627
	for <lists+netdev@lfdr.de>; Thu,  7 Aug 2025 12:56:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EBA0189381E
	for <lists+netdev@lfdr.de>; Thu,  7 Aug 2025 10:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA7922D78A;
	Thu,  7 Aug 2025 10:55:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCBA2A1CF;
	Thu,  7 Aug 2025 10:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754564158; cv=none; b=pAyX+RSiPx8b7EUGlo7bENLyqErFdWve7N8P++Gh2FzCEWKbUTOOoVC6HzHs83DJFGjRhQk6URi79UKHf9ccNi9hXldEOh6a1kKCrBwhLEmonYZgFtJ/BfywO7M6+hVeyWiliuN5j+ARvJ23NIY0yfsWzUqofZ0BhdEWZE5FfEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754564158; c=relaxed/simple;
	bh=2vHE/1SX60ijzzDdtv+ErW2FQvLsq4c1MNieh+o9OyE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=nDDVhXuA7XHcGjE7gLorvXcDNQeskCUl7dEj4zYcznoz/jvvghXQNaP0ua6m67xI9QqqoJc0Hn2qqr5EXsYEM62n5tdmocE+w6vJxqWObyR4KJZUkG4V/z1KJ9N0mztkBM5BESuQwoaCj9LXuOcjTWlqec8yGfvSmnF4o7mmMA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4byNsW5Y1nz2YPjN;
	Thu,  7 Aug 2025 18:37:51 +0800 (CST)
Received: from dggpemf500016.china.huawei.com (unknown [7.185.36.197])
	by mail.maildlp.com (Postfix) with ESMTPS id C7DE11A0188;
	Thu,  7 Aug 2025 18:36:48 +0800 (CST)
Received: from [10.174.176.70] (10.174.176.70) by
 dggpemf500016.china.huawei.com (7.185.36.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 7 Aug 2025 18:36:47 +0800
Message-ID: <1b374635-2444-453f-a7bd-7e732184998e@huawei.com>
Date: Thu, 7 Aug 2025 18:36:44 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: bridge: fix soft lockup in
 br_multicast_query_expired()
To: Nikolay Aleksandrov <razor@blackwall.org>, <idosch@nvidia.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>
CC: <bridge@lists.linux.dev>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <yuehaibing@huawei.com>,
	<zhangchangzhong@huawei.com>
References: <20250806094941.1285944-1-wangliang74@huawei.com>
 <9071898b-ad70-45f1-a671-89448ea168df@blackwall.org>
From: Wang Liang <wangliang74@huawei.com>
In-Reply-To: <9071898b-ad70-45f1-a671-89448ea168df@blackwall.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 dggpemf500016.china.huawei.com (7.185.36.197)


在 2025/8/6 18:08, Nikolay Aleksandrov 写道:
> On 8/6/25 12:49, Wang Liang wrote:
>> When set multicast_query_interval to a large value, the local variable
>> 'time' in br_multicast_send_query() may overflow. If the time is smaller
>> than jiffies, the timer will expire immediately, and then call mod_timer()
>> again, which creates a loop and may trigger the following soft lockup
>> issue:
>>
>>    watchdog: BUG: soft lockup - CPU#1 stuck for 221s! [rb_consumer:66]
>>    CPU: 1 UID: 0 PID: 66 Comm: rb_consumer Not tainted 6.16.0+ #259 PREEMPT(none)
>>    Call Trace:
>>     <IRQ>
>>     __netdev_alloc_skb+0x2e/0x3a0
>>     br_ip6_multicast_alloc_query+0x212/0x1b70
>>     __br_multicast_send_query+0x376/0xac0
>>     br_multicast_send_query+0x299/0x510
>>     br_multicast_query_expired.constprop.0+0x16d/0x1b0
>>     call_timer_fn+0x3b/0x2a0
>>     __run_timers+0x619/0x950
>>     run_timer_softirq+0x11c/0x220
>>     handle_softirqs+0x18e/0x560
>>     __irq_exit_rcu+0x158/0x1a0
>>     sysvec_apic_timer_interrupt+0x76/0x90
>>     </IRQ>
>>
>> This issue can be reproduced with:
>>    ip link add br0 type bridge
>>    echo 1 > /sys/class/net/br0/bridge/multicast_querier
>>    echo 0xffffffffffffffff >
>>    	/sys/class/net/br0/bridge/multicast_query_interval
>>    ip link set dev br0 up
>>
>> Fix this by comparing expire time with jiffies, to avoid the timer loop.
>>
>> Fixes: 7e4df51eb35d ("bridge: netlink: add support for igmp's intervals")
>> Signed-off-by: Wang Liang <wangliang74@huawei.com>
>> ---
>>   net/bridge/br_multicast.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
>> index 1377f31b719c..631ae3b4c45d 100644
>> --- a/net/bridge/br_multicast.c
>> +++ b/net/bridge/br_multicast.c
>> @@ -1892,7 +1892,8 @@ static void br_multicast_send_query(struct net_bridge_mcast *brmctx,
>>   	time += own_query->startup_sent < brmctx->multicast_startup_query_count ?
>>   		brmctx->multicast_startup_query_interval :
>>   		brmctx->multicast_query_interval;
>> -	mod_timer(&own_query->timer, time);
>> +	if (time_is_after_jiffies(time))
>> +		mod_timer(&own_query->timer, time);
>>   }
>>   
>>   static void
> This is the wrong way to fix it, it is a configuration issue, so we could either
> cap the value at something that noone uses, e.g. 24 hours, or we could make sure time
> is at least 1s (that is BR_MULTICAST_QUERY_INTVL_MIN).
>
> The simple fix would be to do a min(time, BR_MULTICAST_QUERY_INTVL_MIN), but I'd go
> for something similar to:
>   commit 99b40610956a
>   Author: Nikolay Aleksandrov <razor@blackwall.org>
>   Date:   Mon Dec 27 19:21:15 2021 +0200
>
>       net: bridge: mcast: add and enforce query interval minimum
>
> for the maximum to avoid the overflow altogether. By the way multicast_startup_query_interval
> would also cause the same issue, so you'd have to cap it.
>
> Cheers,
>   Nik


Thanks very much for your suggestions!

Similar to the commit 99b40610956a("net: bridge: mcast: add and enforce
query interval minimum"), it is indeed a better choice to add query
interval maximum:

diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index 1377f31b719c..8ce145938b02 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -4818,6 +4818,14 @@ void br_multicast_set_query_intvl(struct 
net_bridge_mcast *brmctx,
                 intvl_jiffies = BR_MULTICAST_QUERY_INTVL_MIN;
         }

+       if (intvl_jiffies > BR_MULTICAST_QUERY_INTVL_MAX) {
+               br_info(brmctx->br,
+                       "trying to set multicast query interval above 
maximum, setting to %lu (%ums)\n",
+ jiffies_to_clock_t(BR_MULTICAST_QUERY_INTVL_MAX),
+ jiffies_to_msecs(BR_MULTICAST_QUERY_INTVL_MAX));
+               intvl_jiffies = BR_MULTICAST_QUERY_INTVL_MAX;
+       }
+
         brmctx->multicast_query_interval = intvl_jiffies;
  }

@@ -4834,6 +4842,14 @@ void br_multicast_set_startup_query_intvl(struct 
net_bridge_mcast *brmctx,
                 intvl_jiffies = BR_MULTICAST_STARTUP_QUERY_INTVL_MIN;
         }

+       if (intvl_jiffies > BR_MULTICAST_STARTUP_QUERY_INTVL_MAX) {
+               br_info(brmctx->br,
+                       "trying to set multicast startup query interval 
above maximum, setting to %lu (%ums)\n",
+ jiffies_to_clock_t(BR_MULTICAST_STARTUP_QUERY_INTVL_MAX),
+ jiffies_to_msecs(BR_MULTICAST_STARTUP_QUERY_INTVL_MAX));
+               intvl_jiffies = BR_MULTICAST_STARTUP_QUERY_INTVL_MAX;
+       }
+
         brmctx->multicast_startup_query_interval = intvl_jiffies;
  }

diff --git a/net/bridge/br_private.h b/net/bridge/br_private.h
index b159aae594c0..8de0904b9627 100644
--- a/net/bridge/br_private.h
+++ b/net/bridge/br_private.h
@@ -31,6 +31,8 @@
  #define BR_MULTICAST_DEFAULT_HASH_MAX 4096
  #define BR_MULTICAST_QUERY_INTVL_MIN msecs_to_jiffies(1000)
  #define BR_MULTICAST_STARTUP_QUERY_INTVL_MIN BR_MULTICAST_QUERY_INTVL_MIN
+#define BR_MULTICAST_QUERY_INTVL_MAX msecs_to_jiffies(86400000) /* 24 
hours */
+#define BR_MULTICAST_STARTUP_QUERY_INTVL_MAX BR_MULTICAST_QUERY_INTVL_MAX

  #define BR_HWDOM_MAX BITS_PER_LONG

Set the interval maximum to 24 hours, it is big enough.
Please check it. If the above code is ok, I will send a v2 patch then.

------
Best regards
Wang Liang

>
>

