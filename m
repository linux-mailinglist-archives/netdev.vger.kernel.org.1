Return-Path: <netdev+bounces-22500-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C87B767BC9
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 04:59:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 497D41C218CC
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 02:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2801EC1;
	Sat, 29 Jul 2023 02:59:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B5A7E0
	for <netdev@vger.kernel.org>; Sat, 29 Jul 2023 02:59:25 +0000 (UTC)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9CA75253;
	Fri, 28 Jul 2023 19:58:49 -0700 (PDT)
Received: from kwepemm600007.china.huawei.com (unknown [172.30.72.55])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RCTfR5y4Xz1GDFb;
	Sat, 29 Jul 2023 10:56:15 +0800 (CST)
Received: from [10.69.136.139] (10.69.136.139) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sat, 29 Jul 2023 10:57:11 +0800
Message-ID: <ee5706c6-c841-24c0-8f65-60dbbc3cbdf8@huawei.com>
Date: Sat, 29 Jul 2023 10:57:10 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/6] net: hns3: fix side effects passed to min_t()
To: David Laight <David.Laight@ACULAB.COM>, "yisen.zhuang@huawei.com"
	<yisen.zhuang@huawei.com>, "salil.mehta@huawei.com" <salil.mehta@huawei.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>
CC: "shenjian15@huawei.com" <shenjian15@huawei.com>, "wangjie125@huawei.com"
	<wangjie125@huawei.com>, "liuyonglong@huawei.com" <liuyonglong@huawei.com>,
	"wangpeiyang1@huawei.com" <wangpeiyang1@huawei.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230728075840.4022760-1-shaojijie@huawei.com>
 <20230728075840.4022760-2-shaojijie@huawei.com>
 <85e3c423aa5a400981ae5c53a29ee280@AcuMS.aculab.com>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <85e3c423aa5a400981ae5c53a29ee280@AcuMS.aculab.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.69.136.139]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600007.china.huawei.com (7.193.23.208)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi David：

Yes, you're right, min_t() evaluates the arguments only once.

In the actual scenario, the number of cpu is far less than 65535. 
Therefore, the minimum value will not convert to zero.

Thanks for your advice, this patch will be withdrawn.

   Jijie Shao

on 2023/7/28 16:29, David Laight wrote:
> From: Jijie Shao
>> Sent: 28 July 2023 08:59
>>
>> num_online_cpus() may call more than once when passing to min_t(),
>> between calls, it may return different values, so move num_online_cpus()
>> out of min_t().
> Nope, wrong bug:
> min() (and friends) are careful to only evaluate their arguments once.
> The bug is using min_t() - especially with a small type.
>
> If/when the number of cpu hits 65536 the (u16) cast will convert
> it to zero.
>
> Looking at the code a lot of the local variables should be
> 'unsigned int' not 'u16.
> Just because the domain of a value is small doesn't mean
> you should use a small type (unless you are saving space in
> a structure).
>
> 	David
>
>> Signed-off-by: Yonglong Liu <liuyonglong@huawei.com>
>> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
>> ---
>>   drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
>> b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
>> index 9f6890059666..823e6d2e85f5 100644
>> --- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
>> +++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
>> @@ -4757,6 +4757,7 @@ static int hns3_nic_alloc_vector_data(struct hns3_nic_priv *priv)
>>   {
>>   	struct hnae3_handle *h = priv->ae_handle;
>>   	struct hns3_enet_tqp_vector *tqp_vector;
>> +	u32 online_cpus = num_online_cpus();
>>   	struct hnae3_vector_info *vector;
>>   	struct pci_dev *pdev = h->pdev;
>>   	u16 tqp_num = h->kinfo.num_tqps;
>> @@ -4766,7 +4767,7 @@ static int hns3_nic_alloc_vector_data(struct hns3_nic_priv *priv)
>>
>>   	/* RSS size, cpu online and vector_num should be the same */
>>   	/* Should consider 2p/4p later */
>> -	vector_num = min_t(u16, num_online_cpus(), tqp_num);
>> +	vector_num = min_t(u16, online_cpus, tqp_num);
>>
>>   	vector = devm_kcalloc(&pdev->dev, vector_num, sizeof(*vector),
>>   			      GFP_KERNEL);
>> --
>> 2.30.0
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
>
>

