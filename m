Return-Path: <netdev+bounces-47951-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E00557EC139
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 12:25:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 163CF1C203A8
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 11:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B465156F7;
	Wed, 15 Nov 2023 11:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356BC156E4
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 11:25:01 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7091FE6
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 03:24:59 -0800 (PST)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.54])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4SVgjF2tNKz1P7Z4;
	Wed, 15 Nov 2023 19:21:37 +0800 (CST)
Received: from [10.174.178.66] (10.174.178.66) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 15 Nov 2023 19:24:56 +0800
Message-ID: <41ecaf46-ab68-3f65-4e74-11f9b6117668@huawei.com>
Date: Wed, 15 Nov 2023 19:24:56 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Subject: Re: [PATCH net-next,v2] bonding: use WARN_ON_ONCE instead of BUG in
 alb_upper_dev_walk
To: Jay Vosburgh <jay.vosburgh@canonical.com>
CC: <netdev@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <andy@greyhouse.net>,
	<weiyongjun1@huawei.com>, <yuehaibing@huawei.com>
References: <20231114091829.2509952-1-shaozhengchao@huawei.com>
 <20960.1699990842@famine>
From: shaozhengchao <shaozhengchao@huawei.com>
In-Reply-To: <20960.1699990842@famine>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.66]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500026.china.huawei.com (7.185.36.106)
X-CFilter-Loop: Reflected



On 2023/11/15 3:40, Jay Vosburgh wrote:
> Zhengchao Shao <shaozhengchao@huawei.com> wrote:
> 
>> If failed to allocate "tags" or could not find the final upper device from
>> start_dev's upper list in bond_verify_device_path(), only the loopback
>> detection of the current upper device should be affected, and the system is
>> no need to be panic.
>> Using WARN_ON_ONCE here is to avoid spamming the log if there's a lot of
>> macvlans above the bond.
>>
>> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
>> ---
>> v2: use WARN_ON_ONCE instead of WARN_ON
>> ---
>> drivers/net/bonding/bond_alb.c | 6 ++++--
>> 1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/bonding/bond_alb.c b/drivers/net/bonding/bond_alb.c
>> index dc2c7b979656..a7bad0fff8cb 100644
>> --- a/drivers/net/bonding/bond_alb.c
>> +++ b/drivers/net/bonding/bond_alb.c
>> @@ -984,8 +984,10 @@ static int alb_upper_dev_walk(struct net_device *upper,
>> 	 */
>> 	if (netif_is_macvlan(upper) && !strict_match) {
>> 		tags = bond_verify_device_path(bond->dev, upper, 0);
>> -		if (IS_ERR_OR_NULL(tags))
>> -			BUG();
>> +		if (IS_ERR_OR_NULL(tags)) {
>> +			WARN_ON_ONCE(1);
>> +			return 0;
> 
> 	Ok, I know this is what I said, but on reflection, I think this
> should really return non-zero to terminate the device walk.
> 
> 	-J
> 
	After this failure, there is a high probability that walk
process will still fail. Therefore, it is OK to exit directly. Thanks.
I will send V3.

Zhengchao Shao
> 
>> +		}
>> 		alb_send_lp_vid(slave, upper->dev_addr,
>> 				tags[0].vlan_proto, tags[0].vlan_id);
>> 		kfree(tags);
>> -- 
>> 2.34.1
> 
> ---
> 	-Jay Vosburgh, jay.vosburgh@canonical.com

