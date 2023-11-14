Return-Path: <netdev+bounces-47621-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 818DD7EAB8A
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 09:22:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39DF82810AA
	for <lists+netdev@lfdr.de>; Tue, 14 Nov 2023 08:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E3CD13FE4;
	Tue, 14 Nov 2023 08:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAE913AF3
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 08:22:49 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28BCE1AC
	for <netdev@vger.kernel.org>; Tue, 14 Nov 2023 00:22:47 -0800 (PST)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.54])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4STzjW16vKzrVC4;
	Tue, 14 Nov 2023 16:19:27 +0800 (CST)
Received: from [10.174.178.66] (10.174.178.66) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 14 Nov 2023 16:22:45 +0800
Message-ID: <fbd774ed-12d2-2f47-129e-cd7b1947c65b@huawei.com>
Date: Tue, 14 Nov 2023 16:22:45 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Subject: Re: [PATCH net-next] bonding: use WARN_ON instead of BUG in
 alb_upper_dev_walk
To: Jay Vosburgh <jay.vosburgh@canonical.com>
CC: <netdev@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <andy@greyhouse.net>,
	<weiyongjun1@huawei.com>, <yuehaibing@huawei.com>
References: <20231113092754.3285306-1-shaozhengchao@huawei.com>
 <9928.1699921899@famine>
From: shaozhengchao <shaozhengchao@huawei.com>
In-Reply-To: <9928.1699921899@famine>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.66]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500026.china.huawei.com (7.185.36.106)
X-CFilter-Loop: Reflected



On 2023/11/14 8:31, Jay Vosburgh wrote:
> Zhengchao Shao <shaozhengchao@huawei.com> wrote:
> 
>> If failed to allocate "tags" or could not find the final upper device from
>> start_dev's upper list in bond_verify_device_path(), only the loopback
>> detection of the current upper device should be affected, and the system is
>> no need to be panic.
>>
>> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
>> ---
>> drivers/net/bonding/bond_alb.c | 6 ++++--
>> 1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/bonding/bond_alb.c b/drivers/net/bonding/bond_alb.c
>> index dc2c7b979656..5519cc95b966 100644
>> --- a/drivers/net/bonding/bond_alb.c
>> +++ b/drivers/net/bonding/bond_alb.c
>> @@ -984,8 +984,10 @@ static int alb_upper_dev_walk(struct net_device *upper,
>> 	 */
>> 	if (netif_is_macvlan(upper) && !strict_match) {
>> 		tags = bond_verify_device_path(bond->dev, upper, 0);
>> -		if (IS_ERR_OR_NULL(tags))
>> -			BUG();
>> +		if (IS_ERR_OR_NULL(tags)) {
>> +			WARN_ON(1);
>> +			return 0;
> 
> 	This seems reasonable enough, although I'd suggest the using
> WARN_ON_ONCE instead of WARN_ON.  Alternatively, this could stay as
> WARN_ON if the above also returns non-zero in order to terminate the
> netdev_walk_all_upper_dev_rcu walk.  The intent here is to avoid
> spamming the log if there's a lot of macvlans above the bond.  If the
> allocation in bond_verify_device_path failed, trying again immediately
> seems likely to fail as well.
Hi Jay:
	Thank you for your reply. I do agree with you. I will send v2.

Zhengchao Shao
> 
> 	We could also arrange for whatever called alb_upper_dev_walk to
> reschedule at a slightly later time, but I don't think that's worth the
> trouble.  The bond will by default resend learning packets once per
> second, so issues related to a lost learning packet should resolve
> relatively quickly.
> 
> 	-J
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

