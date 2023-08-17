Return-Path: <netdev+bounces-28291-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E061677EE8F
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 03:11:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93E2E281CE2
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 01:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 548A7382;
	Thu, 17 Aug 2023 01:11:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49488379
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 01:11:06 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDAC51987
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 18:11:04 -0700 (PDT)
Received: from dggpeml500003.china.huawei.com (unknown [172.30.72.57])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RR6Mr6BkpzVk8Q;
	Thu, 17 Aug 2023 09:08:56 +0800 (CST)
Received: from [10.174.177.173] (10.174.177.173) by
 dggpeml500003.china.huawei.com (7.185.36.200) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Thu, 17 Aug 2023 09:11:02 +0800
Message-ID: <141862b6-e788-f16d-660b-e552b9fc4c6c@huawei.com>
Date: Thu, 17 Aug 2023 09:11:02 +0800
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
To: "Nelson, Shannon" <shannon.nelson@amd.com>, <netdev@vger.kernel.org>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <liwei391@huawei.com>
References: <20230816013802.2985145-1-liaoyu15@huawei.com>
 <0d644ce7-88e2-4e51-8e04-5a39b80df5b8@amd.com>
From: Yu Liao <liaoyu15@huawei.com>
In-Reply-To: <0d644ce7-88e2-4e51-8e04-5a39b80df5b8@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
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

On 2023/8/16 22:02, Nelson, Shannon wrote:
> On 8/15/2023 6:38 PM, Yu Liao wrote:
>>
>> pci_disable_device() involves disabling PCI bus-mastering. So remove
>> redundant pci_clear_master().
>>
>> Signed-off-by: Yu Liao <liaoyu15@huawei.com>
>> ---
>>   drivers/net/ethernet/amd/pds_core/main.c | 2 --
>>   1 file changed, 2 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/amd/pds_core/main.c
>> b/drivers/net/ethernet/amd/pds_core/main.c
>> index 672757932246..ffe619cff413 100644
>> --- a/drivers/net/ethernet/amd/pds_core/main.c
>> +++ b/drivers/net/ethernet/amd/pds_core/main.c
>> @@ -374,7 +374,6 @@ static int pdsc_probe(struct pci_dev *pdev, const struct
>> pci_device_id *ent)
>>          return 0;
>>
>>   err_out_clear_master:
>> -       pci_clear_master(pdev);
> 
> Sure, this seems to make sense.  However, if we're removing this call, then we
> should change the name of the goto label to something like
> err_out_disable_device.
> 
> sln

Right, I'll make changes in v2.

Best regards,
Yu
> 
>>          pci_disable_device(pdev);
>>   err_out_free_ida:
>>          ida_free(&pdsc_ida, pdsc->uid);
>> @@ -439,7 +438,6 @@ static void pdsc_remove(struct pci_dev *pdev)
>>                  pci_release_regions(pdev);
>>          }
>>
>> -       pci_clear_master(pdev);
>>          pci_disable_device(pdev);
>>
>>          ida_free(&pdsc_ida, pdsc->uid);
>> -- 
>> 2.25.1
>>
>>


