Return-Path: <netdev+bounces-14693-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4934A74323A
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 03:28:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05E13280E2A
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 01:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11CD715B1;
	Fri, 30 Jun 2023 01:27:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C3015AE
	for <netdev@vger.kernel.org>; Fri, 30 Jun 2023 01:27:57 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 239AB297B;
	Thu, 29 Jun 2023 18:27:56 -0700 (PDT)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.55])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Qsd0B0f1LzMq1F;
	Fri, 30 Jun 2023 09:24:42 +0800 (CST)
Received: from [10.174.178.66] (10.174.178.66) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 30 Jun 2023 09:27:52 +0800
Message-ID: <22050ad7-7c80-1c39-0860-f9bee6e0f3a1@huawei.com>
Date: Fri, 30 Jun 2023 09:27:52 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Subject: Re: [PATCH net 1/2] net/mlx5e: fix memory leak in
 mlx5e_fs_tt_redirect_any_create
To: Rahul Rameshbabu <rrameshbabu@nvidia.com>
CC: <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <richardcochran@gmail.com>, <saeedm@nvidia.com>,
	<leon@kernel.org>, <lkayal@nvidia.com>, <tariqt@nvidia.com>,
	<gal@nvidia.com>, <vadfed@meta.com>, <ayal@nvidia.com>, <eranbe@nvidia.com>,
	<weiyongjun1@huawei.com>, <yuehaibing@huawei.com>
References: <20230629024642.2228767-1-shaozhengchao@huawei.com>
 <20230629024642.2228767-2-shaozhengchao@huawei.com>
 <874jmqb09d.fsf@nvidia.com>
From: shaozhengchao <shaozhengchao@huawei.com>
In-Reply-To: <874jmqb09d.fsf@nvidia.com>
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



On 2023/6/30 2:18, Rahul Rameshbabu wrote:
> On Thu, 29 Jun, 2023 10:46:41 +0800 Zhengchao Shao <shaozhengchao@huawei.com> wrote:
>> The memory pointed to by the fs->any pointer is not freed in the error
>> path of mlx5e_fs_tt_redirect_any_create, which can lead to a memory leak.
>> Fix by freeing the memory in the error path, thereby making the error path
>> identical to mlx5e_fs_tt_redirect_any_destroy().
>>
>> Fixes: 0f575c20bf06 ("net/mlx5e: Introduce Flow Steering ANY API")
>> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
>> ---
>>   drivers/net/ethernet/mellanox/mlx5/core/en/fs_tt_redirect.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/fs_tt_redirect.c b/drivers/net/ethernet/mellanox/mlx5/core/en/fs_tt_redirect.c
>> index 03cb79adf912..9cf4ec931b8b 100644
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/fs_tt_redirect.c
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/fs_tt_redirect.c
>> @@ -594,7 +594,7 @@ int mlx5e_fs_tt_redirect_any_create(struct mlx5e_flow_steering *fs)
>>   
>>   	err = fs_any_create_table(fs);
>>   	if (err)
>> -		return err;
>> +		goto err_free_any;
>>   
>>   	err = fs_any_enable(fs);
>>   	if (err)
>> @@ -606,7 +606,7 @@ int mlx5e_fs_tt_redirect_any_create(struct mlx5e_flow_steering *fs)
>>   
>>   err_destroy_table:
>>   	fs_any_destroy_table(fs_any);
>> -
>> +err_free_any:
>>   	kfree(fs_any);
>>   	mlx5e_fs_set_any(fs, NULL);
> 
Hi Rahul:
> We probably should update the 'any' member reference in fs to NULL
> *before* free-ing fs_any. Otherwise, there is a period in time where fs
> is referring to a dirty pointer value in its any member field. It's not
> critical, but it makes logical sense in my opinion. Lets swap these two
> lines in this patch.
> 
	It looks good. I will send V2. Thank you.

Zhengchao Shao
>>   	return err;
> 
> Thanks for the patch,
> 
> -- Rahul Rameshbabu

