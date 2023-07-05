Return-Path: <netdev+bounces-15523-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E37574837E
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 13:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9675D1C20AFF
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 11:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCCE46FB3;
	Wed,  5 Jul 2023 11:51:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3DF6FAE
	for <netdev@vger.kernel.org>; Wed,  5 Jul 2023 11:51:49 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE1FBE6E;
	Wed,  5 Jul 2023 04:51:46 -0700 (PDT)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.57])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Qwybd1cPszMntK;
	Wed,  5 Jul 2023 19:48:29 +0800 (CST)
Received: from [10.174.178.66] (10.174.178.66) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 5 Jul 2023 19:51:42 +0800
Message-ID: <74dacb36-2ab1-68dc-d4aa-ad89d6e86fbc@huawei.com>
Date: Wed, 5 Jul 2023 19:51:42 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Subject: Re: [PATCH net] net/mlx5: DR, fix memory leak in
 mlx5dr_cmd_create_reformat_ctx
To: Leon Romanovsky <leon@kernel.org>, Simon Horman
	<simon.horman@corigine.com>
CC: <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <valex@nvidia.com>, <kliteyn@nvidia.com>,
	<mbloch@nvidia.com>, <danielj@nvidia.com>, <erezsh@mellanox.com>,
	<saeedm@nvidia.com>, <weiyongjun1@huawei.com>, <yuehaibing@huawei.com>
References: <20230704033308.3773764-1-shaozhengchao@huawei.com>
 <ZKQvbCkdeVWWCzEw@corigine.com> <20230705082353.GJ6455@unreal>
From: shaozhengchao <shaozhengchao@huawei.com>
In-Reply-To: <20230705082353.GJ6455@unreal>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.66]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500026.china.huawei.com (7.185.36.106)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


Hi:
On 2023/7/5 16:23, Leon Romanovsky wrote:
> On Tue, Jul 04, 2023 at 03:40:44PM +0100, Simon Horman wrote:
>> On Tue, Jul 04, 2023 at 11:33:08AM +0800, Zhengchao Shao wrote:
>>> when mlx5_cmd_exec failed in mlx5dr_cmd_create_reformat_ctx, the memory
>>> pointed by 'in' is not released, which will cause memory leak. Move memory
>>> release after mlx5_cmd_exec.
>>>
>>> Fixes: 1d9186476e12 ("net/mlx5: DR, Add direct rule command utilities")
>>> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
>>> ---
>>>   drivers/net/ethernet/mellanox/mlx5/core/steering/dr_cmd.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_cmd.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_cmd.c
>>> index 7491911ebcb5..cf5820744e99 100644
>>> --- a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_cmd.c
>>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_cmd.c
>>> @@ -563,11 +563,11 @@ int mlx5dr_cmd_create_reformat_ctx(struct mlx5_core_dev *mdev,
>>>   		memcpy(pdata, reformat_data, reformat_size);
>>>   
>>>   	err = mlx5_cmd_exec(mdev, in, inlen, out, sizeof(out));
>>> +	kvfree(in);
>>>   	if (err)
>>>   		return err;
>>>   
>>>   	*reformat_id = MLX5_GET(alloc_packet_reformat_context_out, out, packet_reformat_id);
>>> -	kvfree(in);
>>>   
>>>   	return err;
>>>   }
>>
>> Hi Zhengchao Shao,
>>
>> I agree this is a correct fix.
>> However, I think a more idiomatic approach to this problem
>> would be to use a goto label. Something like this (completely untested!).
> 
> Thanks, your change looks more natural to me.
> 
>>
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_cmd.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_cmd.c
>> index 7491911ebcb5..8c2a34a0d6be 100644
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_cmd.c
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_cmd.c
>> @@ -564,11 +564,12 @@ int mlx5dr_cmd_create_reformat_ctx(struct mlx5_core_dev *mdev,
>>   
>>   	err = mlx5_cmd_exec(mdev, in, inlen, out, sizeof(out));
>>   	if (err)
>> -		return err;
>> +		goto err_free_in;
>>   
>>   	*reformat_id = MLX5_GET(alloc_packet_reformat_context_out, out, packet_reformat_id);
>> -	kvfree(in);
>>   
>> +err_free_in:
>> +	kvfree(in);
>>   	return err;
>>   }
>>   

	Thank you for your advice. I will send V2.

Zhengchao Shao

