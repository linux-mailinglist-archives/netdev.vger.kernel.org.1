Return-Path: <netdev+bounces-50328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9859E7F55F4
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 02:38:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49A492815B1
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 01:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE4810E9;
	Thu, 23 Nov 2023 01:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A18E11F
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 17:38:10 -0800 (PST)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.56])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SbLMn6QQ7zvR7w;
	Thu, 23 Nov 2023 09:37:41 +0800 (CST)
Received: from [10.174.178.66] (10.174.178.66) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 23 Nov 2023 09:38:06 +0800
Message-ID: <eb7f10cb-ae8d-9f76-46d4-a191cfc544a9@huawei.com>
Date: Thu, 23 Nov 2023 09:38:05 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Subject: Re: [PATCH net-next,v5] bonding: return -ENOMEM instead of BUG in
 alb_upper_dev_walk
To: Paolo Abeni <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>
CC: <j.vosburgh@gmail.com>, <andy@greyhouse.net>, <weiyongjun1@huawei.com>,
	<yuehaibing@huawei.com>
References: <20231121125805.949940-1-shaozhengchao@huawei.com>
 <8fc84e79-f5c9-8fbe-1fe8-b23b059f03d0@huawei.com>
 <f5b7507a4f3f4bff91a92d653762adc0fca33ff3.camel@redhat.com>
From: shaozhengchao <shaozhengchao@huawei.com>
In-Reply-To: <f5b7507a4f3f4bff91a92d653762adc0fca33ff3.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500026.china.huawei.com (7.185.36.106)
X-CFilter-Loop: Reflected



On 2023/11/23 0:16, Paolo Abeni wrote:
> On Wed, 2023-11-22 at 10:04 +0800, shaozhengchao wrote:
>>
>> On 2023/11/21 20:58, Zhengchao Shao wrote:
>>> If failed to allocate "tags" or could not find the final upper device from
>>> start_dev's upper list in bond_verify_device_path(), only the loopback
>>> detection of the current upper device should be affected, and the system is
>>> no need to be panic.
>>> So just return -ENOMEM in alb_upper_dev_walk to stop walking.
>>>
>>> I also think that the following function calls
>>> netdev_walk_all_upper_dev_rcu
>>> ---->>>alb_upper_dev_walk
>>> ---------->>>bond_verify_device_path
>>>>  From this way, "end device" can eventually be obtained from "start device"
>>> in bond_verify_device_path, IS_ERR(tags) could be instead of
>>> IS_ERR_OR_NULL(tags) in alb_upper_dev_walk.
>>>
>>> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
>>> Acked-by: Jay Vosburgh <jay.vosburgh@canonical.com>
>>> ---
>>> v5: drop print information, if the memory allocation fails, the mm layer
>>>       will emit a lot warning comprising the backtrace
>>> v4: print information instead of warn
>>> v3: return -ENOMEM instead of zero to stop walk
>>> v2: use WARN_ON_ONCE instead of WARN_ON
>>> ---
>>>    drivers/net/bonding/bond_alb.c | 3 ++-
>>>    1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/net/bonding/bond_alb.c b/drivers/net/bonding/bond_alb.c
>>> index dc2c7b979656..7edf0fd58c34 100644
>>> --- a/drivers/net/bonding/bond_alb.c
>>> +++ b/drivers/net/bonding/bond_alb.c
>>> @@ -985,7 +985,8 @@ static int alb_upper_dev_walk(struct net_device *upper,
>>>    	if (netif_is_macvlan(upper) && !strict_match) {
>>>    		tags = bond_verify_device_path(bond->dev, upper, 0);
>>>    		if (IS_ERR_OR_NULL(tags))
>>> -			BUG();
>>> +			return -ENOMEM;
>>> +
>>>    		alb_send_lp_vid(slave, upper->dev_addr,
>>>    				tags[0].vlan_proto, tags[0].vlan_id);
>>>    		kfree(tags);
>> Hi Paolo:
>> 	I find that v4 has been merged into net-next.
> 
> I'm sorry, that was due to PEBKAC here.
> 
>> So v5 is not
>> needed. But should I send another patch to drop that print info?
> 
> Yes please, send a follow-up just dropping the print.
> 
OK， I will do it today.
Thanks

Zhengchao Shao
> Thanks!
> 
> Paolo
> 
> 

