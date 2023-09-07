Return-Path: <netdev+bounces-32358-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E1FB796F1B
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 04:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE8A62815B5
	for <lists+netdev@lfdr.de>; Thu,  7 Sep 2023 02:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C72EA21;
	Thu,  7 Sep 2023 02:54:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F9B371
	for <netdev@vger.kernel.org>; Thu,  7 Sep 2023 02:54:07 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 488DE10C8
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 19:54:06 -0700 (PDT)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.55])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Rh3db2njmzMlB4;
	Thu,  7 Sep 2023 10:50:43 +0800 (CST)
Received: from [10.174.176.93] (10.174.176.93) by
 canpemm500010.china.huawei.com (7.192.105.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Thu, 7 Sep 2023 10:54:03 +0800
Message-ID: <b9abe13e-2c29-ab5e-2da9-1bcc9183974a@huawei.com>
Date: Thu, 7 Sep 2023 10:54:03 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH net] net: ipv4: fix one memleak in __inet_del_ifa()
To: Julian Anastasov <ja@ssi.bg>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <hadi@cyberus.ca>,
	<netdev@vger.kernel.org>
References: <20230905135554.1958156-1-liujian56@huawei.com>
 <bcb0e791-37ab-3fff-9da6-a86883924205@ssi.bg>
 <cbe579bd-4aff-8239-0e32-6acb79b11bca@huawei.com>
 <734181f9-b340-daa2-0772-7ed220eee150@ssi.bg>
From: "liujian (CE)" <liujian56@huawei.com>
In-Reply-To: <734181f9-b340-daa2-0772-7ed220eee150@ssi.bg>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.93]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 2023/9/6 18:30, Julian Anastasov wrote:
> 
> 	Hello,
> 
> On Wed, 6 Sep 2023, liujian (CE) wrote:
> 
>> On 2023/9/6 1:20, Julian Anastasov wrote:
>>>
>>> On Tue, 5 Sep 2023, Liu Jian wrote:
>>>
>>>> I got the below warning when do fuzzing test:
>>>> unregister_netdevice: waiting for bond0 to become free. Usage count = 2
>>>>
>>>> It can be repoduced via:
>>>>
>>>> ip link add bond0 type bond
>>>> sysctl -w net.ipv4.conf.bond0.promote_secondaries=1
>>>> ip addr add 4.117.174.103/0 scope 0x40 dev bond0
>>>> ip addr add 192.168.100.111/255.255.255.254 scope 0 dev bond0
>>>> ip addr add 0.0.0.4/0 scope 0x40 secondary dev bond0
>>>> ip addr del 4.117.174.103/0 scope 0x40 dev bond0
>>>> ip link delete bond0 type bond
>>>>
>>>> In this reproduction test case, an incorrect 'last_prim' is found in
>>>> __inet_del_ifa(), as a result, the secondary address(0.0.0.4/0 scope 0x40)
>>>> is lost. The memory of the secondary address is leaked and the reference of
>>>> in_device and net_device is leaked.
> 
> 	We can also explain that the problem occurs when we delete
> the first primary address and the promoted address is leaked because
> it is attached to the to-be-freed primary address instead of to ifa_list.
> 
>>>> Fix this problem by modifying the PROMOTE_SECONDANCE behavior as follows:
>>>> 1. Traverse in_dev->ifa_list to search for the actual 'last_prim'.
>>>> 2. When last_prim is empty, move 'promote' to the in_dev->ifa_list header.
>>>
>>> 	So, the problem is that last_prim initially points to the
>>> first primary address that we are actually removing. Looks like with
>>> last_prim we try to promote the secondary IP after all primaries with
>>> scope >= our scope, i.e. simulating a new IP insert. As the secondary IPs
>>> have same scope as their primary, why just not remove the last_prim
>>> var/code and to insert the promoted secondary at the same place as the
>>> deleted primary? May be your patch does the same: insert at same pos?
>>>
>>> Before deletion:
>>> 1. primary1 scope global (to be deleted)
>>> 2. primary2 scope global
>>> 3. promoted_secondary
>>>
>>> After deletion (old way, promote as a new insertion):
>>> 1. primary2 scope global
>>> 2. promoted_secondary scope global (inserted as new primary)
>>>
>> It is :
>> After deletion (old way, promoted_secondary lost):
>> 1. primary2 scope global
> 
> 	Yes, that is what happens :)
> 
>>> After deletion (new way, promote at same place):
>>> 1. promoted_secondary scope global (now primary, inserted at same place)
>>> 2. primary2 scope global
>>>
>>>   What I mean is to use ifap as last_prim, not tested:
>>>
>> Yes, This is better and it can work also. Thanks.
>> Tested-by: Liu Jian <liujian56@huawei.com>
> 
> 	But let me propose another version. It is a minimal
> bugfix that does not change the place where the promoted address
> is added and just converts last_prim to be rcu ptr to insert
> position. last_prim will start from ifap because the promoted
> address can not be added before this position. It is better
> not to reorder the IPs because scripts may depend on the
> old behavior to add the promoted IP after all others for
> the scope. If you find this version better you can post it
> as v2 and I'll sign it too.
Have sent v2, thank you for this case.
> 
> diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
> index 5deac0517ef7..37be82496322 100644
> --- a/net/ipv4/devinet.c
> +++ b/net/ipv4/devinet.c
> @@ -355,14 +355,14 @@ static void __inet_del_ifa(struct in_device *in_dev,
>   {
>   	struct in_ifaddr *promote = NULL;
>   	struct in_ifaddr *ifa, *ifa1;
> -	struct in_ifaddr *last_prim;
> +	struct in_ifaddr __rcu **last_prim;
>   	struct in_ifaddr *prev_prom = NULL;
>   	int do_promote = IN_DEV_PROMOTE_SECONDARIES(in_dev);
>   
>   	ASSERT_RTNL();
>   
>   	ifa1 = rtnl_dereference(*ifap);
> -	last_prim = rtnl_dereference(in_dev->ifa_list);
> +	last_prim = ifap;
>   	if (in_dev->dead)
>   		goto no_promotions;
>   
> @@ -376,7 +376,7 @@ static void __inet_del_ifa(struct in_device *in_dev,
>   		while ((ifa = rtnl_dereference(*ifap1)) != NULL) {
>   			if (!(ifa->ifa_flags & IFA_F_SECONDARY) &&
>   			    ifa1->ifa_scope <= ifa->ifa_scope)
> -				last_prim = ifa;
> +				last_prim = &ifa->ifa_next;
>   
>   			if (!(ifa->ifa_flags & IFA_F_SECONDARY) ||
>   			    ifa1->ifa_mask != ifa->ifa_mask ||
> @@ -440,9 +440,9 @@ static void __inet_del_ifa(struct in_device *in_dev,
>   
>   			rcu_assign_pointer(prev_prom->ifa_next, next_sec);
>   
> -			last_sec = rtnl_dereference(last_prim->ifa_next);
> +			last_sec = rtnl_dereference(*last_prim);
>   			rcu_assign_pointer(promote->ifa_next, last_sec);
> -			rcu_assign_pointer(last_prim->ifa_next, promote);
> +			rcu_assign_pointer(*last_prim, promote);
>   		}
>   
>   		promote->ifa_flags &= ~IFA_F_SECONDARY;
> 
> Regards
> 
> --
> Julian Anastasov <ja@ssi.bg>
> 

