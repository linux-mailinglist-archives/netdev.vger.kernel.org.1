Return-Path: <netdev-owner@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 923AB740DFE
	for <lists+netdev@lfdr.de>; Wed, 28 Jun 2023 12:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjF1KDq (ORCPT <rfc822;lists+netdev@lfdr.de>);
        Wed, 28 Jun 2023 06:03:46 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:41484 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232059AbjF1Jsp (ORCPT
        <rfc822;netdev@vger.kernel.org>); Wed, 28 Jun 2023 05:48:45 -0400
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QrcGM19MYzqV3L;
        Wed, 28 Jun 2023 17:48:27 +0800 (CST)
Received: from [10.174.178.66] (10.174.178.66) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 28 Jun 2023 17:48:43 +0800
Message-ID: <fc381683-00b8-ffae-b225-35317e538ac1@huawei.com>
Date:   Wed, 28 Jun 2023 17:48:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Subject: Re: [PATCH net] mlxsw: minimal: fix potential memory leak in
 mlxsw_m_linecards_init
To:     Ido Schimmel <idosch@nvidia.com>
CC:     <netdev@vger.kernel.org>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <petrm@nvidia.com>, <jiri@resnulli.us>, <vadimp@nvidia.com>,
        <yuehaibing@huawei.com>
References: <20230628005410.1524682-1-shaozhengchao@huawei.com>
 <ZJv3Uis/ePiRKIfc@shredder>
From:   shaozhengchao <shaozhengchao@huawei.com>
In-Reply-To: <ZJv3Uis/ePiRKIfc@shredder>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.66]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500026.china.huawei.com (7.185.36.106)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <netdev.vger.kernel.org>
X-Mailing-List: netdev@vger.kernel.org



On 2023/6/28 17:03, Ido Schimmel wrote:
> On Wed, Jun 28, 2023 at 08:54:10AM +0800, Zhengchao Shao wrote:
>> when allocating mlxsw_m->line_cards[] failed in mlxsw_m_linecards_init,
> 
Hi Ido:
> s/when/When/
> s/allocating/the allocation of/
> s/failed/fails/
> 
>> the memory pointed by mlxsw_m->line_cards is not released, which will
>> cause memory leak. Memory release processing is added to the incorrect
>> path.
> 
> Last sentence should be reworded to imperative mood.
> 
> Personally, I would reword the commit message to something like:
> 
> "
> The line cards array is not freed in the error path of
> mlxsw_m_linecards_init(), which can lead to a memory leak. Fix by
> freeing the array in the error path, thereby making the error path
> identical to mlxsw_m_linecards_fini().
> "
> 
	Thank you for your reply. I will send v2.

Zhengchao Shao
> Thanks
> 
>>
>> Fixes: 01328e23a476 ("mlxsw: minimal: Extend module to port mapping with slot index")
>> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
>> ---
>>   drivers/net/ethernet/mellanox/mlxsw/minimal.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/net/ethernet/mellanox/mlxsw/minimal.c b/drivers/net/ethernet/mellanox/mlxsw/minimal.c
>> index 6b56eadd736e..6b98c3287b49 100644
>> --- a/drivers/net/ethernet/mellanox/mlxsw/minimal.c
>> +++ b/drivers/net/ethernet/mellanox/mlxsw/minimal.c
>> @@ -417,6 +417,7 @@ static int mlxsw_m_linecards_init(struct mlxsw_m *mlxsw_m)
>>   err_kmalloc_array:
>>   	for (i--; i >= 0; i--)
>>   		kfree(mlxsw_m->line_cards[i]);
>> +	kfree(mlxsw_m->line_cards);
>>   err_kcalloc:
>>   	kfree(mlxsw_m->ports);
>>   	return err;
>> -- 
>> 2.34.1
>>
