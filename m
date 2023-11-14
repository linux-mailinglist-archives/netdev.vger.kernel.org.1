Return-Path: <netdev+bounces-47697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 497797EAFF7
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 13:39:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56C761C20A42
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 12:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA581199A4;
	Tue, 14 Nov 2023 12:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E5C3FB0B
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 12:39:01 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFFE418A
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 04:38:55 -0800 (PST)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.57])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4SV5SS36TKzWhDk;
	Tue, 14 Nov 2023 20:38:32 +0800 (CST)
Received: from [10.174.178.66] (10.174.178.66) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 14 Nov 2023 20:38:53 +0800
Message-ID: <98a4c633-0c63-d2ce-feea-e4182e9aaceb@huawei.com>
Date: Tue, 14 Nov 2023 20:38:53 +0800
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
To: Hangbin Liu <liuhangbin@gmail.com>
CC: <netdev@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <j.vosburgh@gmail.com>,
	<andy@greyhouse.net>, <weiyongjun1@huawei.com>, <yuehaibing@huawei.com>
References: <20231114091829.2509952-1-shaozhengchao@huawei.com>
 <ZVNJBEuJw+rT/Biq@Laptop-X1>
From: shaozhengchao <shaozhengchao@huawei.com>
In-Reply-To: <ZVNJBEuJw+rT/Biq@Laptop-X1>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.66]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500026.china.huawei.com (7.185.36.106)
X-CFilter-Loop: Reflected



On 2023/11/14 18:16, Hangbin Liu wrote:
> On Tue, Nov 14, 2023 at 05:18:29PM +0800, Zhengchao Shao wrote:
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
>>   drivers/net/bonding/bond_alb.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/bonding/bond_alb.c b/drivers/net/bonding/bond_alb.c
>> index dc2c7b979656..a7bad0fff8cb 100644
>> --- a/drivers/net/bonding/bond_alb.c
>> +++ b/drivers/net/bonding/bond_alb.c
>> @@ -984,8 +984,10 @@ static int alb_upper_dev_walk(struct net_device *upper,
>>   	 */
>>   	if (netif_is_macvlan(upper) && !strict_match) {
>>   		tags = bond_verify_device_path(bond->dev, upper, 0);
>> -		if (IS_ERR_OR_NULL(tags))
>> -			BUG();
>> +		if (IS_ERR_OR_NULL(tags)) {
>> +			WARN_ON_ONCE(1);
>> +			return 0;
> 
> Return 0 for an error looks weird. Should we keep walking the list if
> allocate "tags" failed?
> 
> Thanks
> Hangbin
> 
Hi Hangbin:
	I think minimizing the impact of a single allocation failure
is OK.

Zhengchao Shao




