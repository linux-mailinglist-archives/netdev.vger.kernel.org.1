Return-Path: <netdev+bounces-26198-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 344CD777271
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 10:12:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6573F1C20E53
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 08:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 695DF1ADF0;
	Thu, 10 Aug 2023 08:11:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE955667
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 08:11:05 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 644C1212E
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 01:10:56 -0700 (PDT)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.55])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RM01c5TQwzTm47;
	Thu, 10 Aug 2023 16:08:52 +0800 (CST)
Received: from [10.174.178.66] (10.174.178.66) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 10 Aug 2023 16:10:48 +0800
Message-ID: <90d2aee8-45f9-6b3c-e34e-8c34cd980226@huawei.com>
Date: Thu, 10 Aug 2023 16:10:48 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Subject: Re: [PATCH net-next 4/5] bonding: use bond_set_slave_arr to simplify
 code
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>, <netdev@vger.kernel.org>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <j.vosburgh@gmail.com>, <andy@greyhouse.net>, <weiyongjun1@huawei.com>,
	<yuehaibing@huawei.com>
References: <20230809124107.360574-1-shaozhengchao@huawei.com>
 <20230809124107.360574-5-shaozhengchao@huawei.com>
 <b5ccef63-4c16-0371-6dda-b3d1f9dfa5d6@linux.dev>
From: shaozhengchao <shaozhengchao@huawei.com>
In-Reply-To: <b5ccef63-4c16-0371-6dda-b3d1f9dfa5d6@linux.dev>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.178.66]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500026.china.huawei.com (7.185.36.106)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 2023/8/10 8:17, Vadim Fedorenko wrote:
> On 09/08/2023 13:41, Zhengchao Shao wrote:
>> In bond_reset_slave_arr(), values are assigned and memory is released 
>> only
>> when the variables "usable" and "all" are not NULL. But even if the
>> "usable" and "all" variables are NULL, they can still work, because value
>> will be checked in kfree_rcu. Therefore, use bond_set_slave_arr() and set
>> the input parameters "usable_slaves" and "all_slaves" to NULL to simplify
>> the code in bond_reset_slave_arr(). And the same to bond_uninit().
>>
>> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
>> ---
>>   drivers/net/bonding/bond_main.c | 29 +++--------------------------
>>   1 file changed, 3 insertions(+), 26 deletions(-)
>>
>> diff --git a/drivers/net/bonding/bond_main.c 
>> b/drivers/net/bonding/bond_main.c
>> index 6636638f5d97..dcc67bd4d5cf 100644
>> --- a/drivers/net/bonding/bond_main.c
>> +++ b/drivers/net/bonding/bond_main.c
>> @@ -5044,21 +5044,9 @@ static void bond_set_slave_arr(struct bonding 
>> *bond,
>>       kfree_rcu(all, rcu);
>>   }
>> -static void bond_reset_slave_arr(struct bonding *bond)
>> +static inline void bond_reset_slave_arr(struct bonding *bond)
> 
> No explicit inline in c files. Remove it and let the compiler decide.
> 
Hi Vadim:
	Thank you for your review. I will remove it in v2.

Zhengchao Shao
>>   {
>> -    struct bond_up_slave *usable, *all;
>> -
>> -    usable = rtnl_dereference(bond->usable_slaves);
>> -    if (usable) {
>> -        RCU_INIT_POINTER(bond->usable_slaves, NULL);
>> -        kfree_rcu(usable, rcu);
>> -    }
>> -
>> -    all = rtnl_dereference(bond->all_slaves);
>> -    if (all) {
>> -        RCU_INIT_POINTER(bond->all_slaves, NULL);
>> -        kfree_rcu(all, rcu);
>> -    }
>> +    bond_set_slave_arr(bond, NULL, NULL);
>>   }
>>   /* Build the usable slaves array in control path for modes that use 
>> xmit-hash
>> @@ -5951,7 +5939,6 @@ void bond_setup(struct net_device *bond_dev)
>>   static void bond_uninit(struct net_device *bond_dev)
>>   {
>>       struct bonding *bond = netdev_priv(bond_dev);
>> -    struct bond_up_slave *usable, *all;
>>       struct list_head *iter;
>>       struct slave *slave;
>> @@ -5962,17 +5949,7 @@ static void bond_uninit(struct net_device 
>> *bond_dev)
>>           __bond_release_one(bond_dev, slave->dev, true, true);
>>       netdev_info(bond_dev, "Released all slaves\n");
>> -    usable = rtnl_dereference(bond->usable_slaves);
>> -    if (usable) {
>> -        RCU_INIT_POINTER(bond->usable_slaves, NULL);
>> -        kfree_rcu(usable, rcu);
>> -    }
>> -
>> -    all = rtnl_dereference(bond->all_slaves);
>> -    if (all) {
>> -        RCU_INIT_POINTER(bond->all_slaves, NULL);
>> -        kfree_rcu(all, rcu);
>> -    }
>> +    bond_set_slave_arr(bond, NULL, NULL);
>>       list_del(&bond->bond_list);

