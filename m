Return-Path: <netdev+bounces-136001-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0D6D99FEB5
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 04:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C6271F2618F
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 02:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63AA714D718;
	Wed, 16 Oct 2024 02:19:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6EC621E3BF
	for <netdev@vger.kernel.org>; Wed, 16 Oct 2024 02:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729045166; cv=none; b=W+6qtu3UGvFNFDeaBmYiuWrgg1L5nMdcZ2oGu64dDHjnCY7JSidIxPAsa4HsMVfyTeemNYTj7avmtmzvx7jP+cPF5vgRtiupEVLhcuggbbzvHBJulIiC+36S1a7feRj8TM+xQ+s09m9WDzOn976Y8j6VLRaL5m2DuQBE7JKfxQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729045166; c=relaxed/simple;
	bh=mhv+z3WCXp3ndg6cJpd2KVIfcPBjhos9utI95atwGV8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=p31waJYrHrJha4jEK0h6Gjf/31lKBWOpX9mxaQ+Z4eqzxnqwJ41d1QIBSAb+5p7HksHpmsU35+vusHIoeafjAZhPCYoByMnSiFrdJxokAYWPGXLi9f0tvEzS/yEXXlV86MLBbY0T5xGhzOEzfVuA6nvft3gSIqzrLw6vMKCjuBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4XSvl25Y0jz1spnN;
	Wed, 16 Oct 2024 10:18:06 +0800 (CST)
Received: from dggpeml500024.china.huawei.com (unknown [7.185.36.10])
	by mail.maildlp.com (Postfix) with ESMTPS id 248BB1A016C;
	Wed, 16 Oct 2024 10:19:21 +0800 (CST)
Received: from [10.174.178.41] (10.174.178.41) by
 dggpeml500024.china.huawei.com (7.185.36.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 16 Oct 2024 10:19:20 +0800
Message-ID: <107fb00f-1dac-4a13-b444-af2649901ae4@huawei.com>
Date: Wed, 16 Oct 2024 10:19:19 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] mlxsw: spectrum_router: fix xa_store() error
 checking
To: Petr Machata <petrm@nvidia.com>
CC: <idosch@nvidia.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <netdev@vger.kernel.org>
References: <20241015063651.8610-1-yuancan@huawei.com>
 <8734kxix77.fsf@nvidia.com>
Content-Language: en-US
From: Yuan Can <yuancan@huawei.com>
In-Reply-To: <8734kxix77.fsf@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500024.china.huawei.com (7.185.36.10)

On 2024/10/15 16:06, Petr Machata wrote:
> Yuan Can <yuancan@huawei.com> writes:
>
>> It is meant to use xa_err() to extract the error encoded in the return
>> value of xa_store().
>>
>> Fixes: 44c2fbebe18a ("mlxsw: spectrum_router: Share nexthop counters in resilient groups")
>> Signed-off-by: Yuan Can <yuancan@huawei.com>
> Reviewed-by: Petr Machata <petrm@nvidia.com>
>
> What's the consequence of using IS_ERR()/PTR_ERR() vs. xa_err()? From
> the documentation it looks like IS_ERR() might interpret some valid
> pointers as errors[0]. Which would then show as leaks, because we bail
> out early and never clean up?

At least the PRT_ERR() will return a wrong error number, though the 
error number

seems not used nor printed.

>
> I.e. should this aim at net rather than net-next? It looks like it's not
> just semantics, but has actual observable impact.
Ok, do I need to send a V2 patch to net branch?
>
> [0] "The XArray does not support storing IS_ERR() pointers as some
>      conflict with value entries or internal entries."
>
>> ---
>>   drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c | 9 +++------
>>   1 file changed, 3 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
>> index 800dfb64ec83..7d6d859cef3f 100644
>> --- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
>> +++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_router.c
>> @@ -3197,7 +3197,6 @@ mlxsw_sp_nexthop_sh_counter_get(struct mlxsw_sp *mlxsw_sp,
>>   {
>>   	struct mlxsw_sp_nexthop_group *nh_grp = nh->nhgi->nh_grp;
>>   	struct mlxsw_sp_nexthop_counter *nhct;
>> -	void *ptr;
>>   	int err;
>>   
>>   	nhct = xa_load(&nh_grp->nhgi->nexthop_counters, nh->id);
>> @@ -3210,12 +3209,10 @@ mlxsw_sp_nexthop_sh_counter_get(struct mlxsw_sp *mlxsw_sp,
>>   	if (IS_ERR(nhct))
>>   		return nhct;
>>   
>> -	ptr = xa_store(&nh_grp->nhgi->nexthop_counters, nh->id, nhct,
>> -		       GFP_KERNEL);
>> -	if (IS_ERR(ptr)) {
>> -		err = PTR_ERR(ptr);
>> +	err = xa_err(xa_store(&nh_grp->nhgi->nexthop_counters, nh->id, nhct,
>> +			      GFP_KERNEL));
>> +	if (err)
>>   		goto err_store;
>> -	}

-- 
Best regards,
Yuan Can


