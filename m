Return-Path: <netdev+bounces-27999-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62BB377DD70
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 11:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3604A1C20F0C
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 09:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AAA7DF6F;
	Wed, 16 Aug 2023 09:39:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B91D52B
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 09:39:38 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15BCC13E
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 02:39:37 -0700 (PDT)
Received: from dggpeml500003.china.huawei.com (unknown [172.30.72.54])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RQjj52X8zzVk6v;
	Wed, 16 Aug 2023 17:37:29 +0800 (CST)
Received: from [10.174.177.173] (10.174.177.173) by
 dggpeml500003.china.huawei.com (7.185.36.200) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 16 Aug 2023 17:39:34 +0800
Message-ID: <c232243d-0c5a-c253-5e3b-81be2479b776@huawei.com>
Date: Wed, 16 Aug 2023 17:39:33 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH net-next] pds_core: remove redundant pci_clear_master()
Content-Language: en-US
To: Leon Romanovsky <leon@kernel.org>
CC: <netdev@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <liwei391@huawei.com>, Xiongfeng Wang
	<wangxiongfeng2@huawei.com>
References: <20230816013802.2985145-1-liaoyu15@huawei.com>
 <20230816063820.GV22185@unreal>
From: Yu Liao <liaoyu15@huawei.com>
In-Reply-To: <20230816063820.GV22185@unreal>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.173]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500003.china.huawei.com (7.185.36.200)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,HK_RANDOM_ENVFROM,
	HK_RANDOM_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023/8/16 14:38, Leon Romanovsky wrote:
> On Wed, Aug 16, 2023 at 09:38:02AM +0800, Yu Liao wrote:
>> pci_disable_device() involves disabling PCI bus-mastering. So remove
>> redundant pci_clear_master().
> 
> I would say that this commit message needs to be more descriptive and
> explain why pci_disable_device() will actually disable PCI in these
> flows.
> 
> According to the doc and code:
>   2263  * Note we don't actually disable the device until all callers of 
>   2264  * pci_enable_device() have called pci_disable_device().
> 
> Thanks
> 
Thank you for the review. My bad, I didn't describe it clearly in commit
message. I will send the v2 version and add the following explanation:

do_pci_disable_device() disable PCI bus-mastering as following:
static void do_pci_disable_device(struct pci_dev *dev)
{
		u16 pci_command;

		pci_read_config_word(dev, PCI_COMMAND, &pci_command);
		if (pci_command & PCI_COMMAND_MASTER) {
				pci_command &= ~PCI_COMMAND_MASTER;
				pci_write_config_word(dev, PCI_COMMAND, pci_command);
		}

		pcibios_disable_device(dev);
}
And pci_disable_device() sets dev->is_busmaster to 0.

So for pci_dev that has called pci_enable_device(), pci_disable_device()
involves disabling PCI bus-mastering. Remove redundant pci_clear_master() in
the following places:
- In error path 'err_out_clear_master' of pdsc_probe(), pci_enable_device()
has already been called.
- In pdsc_remove(), pci_enable_device() has already been called in pdsc_probe().

Best regards,
Yu
>>
>> Signed-off-by: Yu Liao <liaoyu15@huawei.com>
>> ---
>>  drivers/net/ethernet/amd/pds_core/main.c | 2 --
>>  1 file changed, 2 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/amd/pds_core/main.c b/drivers/net/ethernet/amd/pds_core/main.c
>> index 672757932246..ffe619cff413 100644
>> --- a/drivers/net/ethernet/amd/pds_core/main.c
>> +++ b/drivers/net/ethernet/amd/pds_core/main.c
>> @@ -374,7 +374,6 @@ static int pdsc_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>>  	return 0;
>>  
>>  err_out_clear_master:
>> -	pci_clear_master(pdev);
>>  	pci_disable_device(pdev);
>>  err_out_free_ida:
>>  	ida_free(&pdsc_ida, pdsc->uid);
>> @@ -439,7 +438,6 @@ static void pdsc_remove(struct pci_dev *pdev)
>>  		pci_release_regions(pdev);
>>  	}
>>  
>> -	pci_clear_master(pdev);
>>  	pci_disable_device(pdev);
>>  
>>  	ida_free(&pdsc_ida, pdsc->uid);
>> -- 
>> 2.25.1
>>
>>


