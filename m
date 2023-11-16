Return-Path: <netdev+bounces-48346-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2488F7EE208
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 14:58:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACC0AB20A96
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 13:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E74F630D1F;
	Thu, 16 Nov 2023 13:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D2E1126
	for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 05:58:08 -0800 (PST)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.57])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4SWM2S4Wp7zNmTg;
	Thu, 16 Nov 2023 21:53:52 +0800 (CST)
Received: from [10.174.178.66] (10.174.178.66) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Thu, 16 Nov 2023 21:58:05 +0800
Message-ID: <d0803dc1-8013-5898-5788-464d7b000f46@huawei.com>
Date: Thu, 16 Nov 2023 21:58:04 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Subject: Re: [PATCH net-next,v3] bonding: use WARN_ON instead of BUG in
 alb_upper_dev_walk
To: Jay Vosburgh <jay.vosburgh@canonical.com>, Simon Horman <horms@kernel.org>
CC: Jiri Pirko <jiri@resnulli.us>, <netdev@vger.kernel.org>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andy@greyhouse.net>, <weiyongjun1@huawei.com>,
	<yuehaibing@huawei.com>
References: <20231115115537.420374-1-shaozhengchao@huawei.com>
 <ZVTUL4QByIyGyfDP@nanopsycho> <20231115174955.GV74656@kernel.org>
 <18323.1700080449@famine>
From: shaozhengchao <shaozhengchao@huawei.com>
In-Reply-To: <18323.1700080449@famine>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.66]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500026.china.huawei.com (7.185.36.106)
X-CFilter-Loop: Reflected



On 2023/11/16 4:34, Jay Vosburgh wrote:
> Simon Horman <horms@kernel.org> wrote:
> 
>> On Wed, Nov 15, 2023 at 03:22:39PM +0100, Jiri Pirko wrote:
>>> Wed, Nov 15, 2023 at 12:55:37PM CET, shaozhengchao@huawei.com wrote:
>>>> If failed to allocate "tags" or could not find the final upper device from
>>>> start_dev's upper list in bond_verify_device_path(), only the loopback
>>>> detection of the current upper device should be affected, and the system is
>>>> no need to be panic.
>>>>
>>>> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
>>>> ---
>>>> v3: return -ENOMEM instead of zero to stop walk
>>>> v2: use WARN_ON_ONCE instead of WARN_ON
>>>
>>> Yet the WARN_ON is back :O
>>
>> Hi Jiri,
>>
>> I think the suggestion was to either:
>>
>> 1. WARN_ON_ONCE(); return 0;      <= this was v2
>> 2. WARN_ON(); return -ESOMETHING; <= this is v3
>> (But not, WARN_ON(); return 0;    <= this was v1)
>>
>> And after v2 it was determined that the approach taken here in v3 is
>> preferred.
>>
>> So I think this patch is consistent with the feedback given by Jay
>> in his reviews so far.
> 
> 	Sigh, the more I look the more complicated this gets.
> 	
> 	Anyway, I was previously thinking we're ok with WARN_ON if the
> return is non-zero to terminate the device walk.  The bond itself will
> automatically call alb_upper_dev_walk at most once per second.
> 
> 	However, user space could do something like continuously change
> the MAC address of the bond or initiate a failover in order to trigger a
> call to alb_upper_dev_walk.  This won't be rate limited, and if the
> allocations there repeatedly fail, it would always trigger the WARN_ON.
> 
Yes, it will be bad.
> 	So, I'm thinking now that instead of WARN_anything, we should
> instead use something like
> 
> net_err_ratelimited("%s: %s: allocation failure\n", start_dev->name, __func__);
> 
> 	in bond_verify_device_path, and alb_upper_dev_walk doesn't do
> any WARN at all, and returns failure (non-zero).
> 	
> 	This is consistent with other similar allocation failures.
> 
Maybe you are right here. Thanks

Zhengchao Shao
> 	-J
> 
>>>> ---
>>>> drivers/net/bonding/bond_alb.c | 6 ++++--
>>>> 1 file changed, 4 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/net/bonding/bond_alb.c b/drivers/net/bonding/bond_alb.c
>>>> index dc2c7b979656..21f1cb8e453b 100644
>>>> --- a/drivers/net/bonding/bond_alb.c
>>>> +++ b/drivers/net/bonding/bond_alb.c
>>>> @@ -984,8 +984,10 @@ static int alb_upper_dev_walk(struct net_device *upper,
>>>> 	 */
>>>> 	if (netif_is_macvlan(upper) && !strict_match) {
>>>> 		tags = bond_verify_device_path(bond->dev, upper, 0);
>>>> -		if (IS_ERR_OR_NULL(tags))
>>>> -			BUG();
>>>> +		if (IS_ERR_OR_NULL(tags)) {
>>>> +			WARN_ON(1);
>>>> +			return -ENOMEM;
>>>> +		}
>>>> 		alb_send_lp_vid(slave, upper->dev_addr,
>>>> 				tags[0].vlan_proto, tags[0].vlan_id);
>>>> 		kfree(tags);
>>>> -- 
>>>> 2.34.1
>>>>
>>>>
>>>
>>
> 
> ---
> 	-Jay Vosburgh, jay.vosburgh@canonical.com

