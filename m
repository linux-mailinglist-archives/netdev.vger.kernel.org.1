Return-Path: <netdev+bounces-19295-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4FA975A317
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 02:05:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F23C281BA0
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 00:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E388E38E;
	Thu, 20 Jul 2023 00:04:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF7A7F
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 00:04:34 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C3AF2109
	for <netdev@vger.kernel.org>; Wed, 19 Jul 2023 17:04:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TkgIheZoUDDJp2mFrVSEVB5Rm9VgOjgzf36csD62r/wAoDuCE0XuOZ8HSg7qXKnDIFrgSzDSV+cXJH1cJWvA1mKpYTfKW9A5T442d5uecvgvUKmzFqCnQKJaQ3P8MSDfHTj9PxVlMUYovXlX0rIimdoBiLAtSUB4jk1Sn13rS6WD/9lAhuqKpP3aIW2c127e/xoTWvtoJlOZabvfVSfZnBwRx7LgLxTa3ColfAizP+cyJVTeHNMUjrFLC55KGZfd/wDp2eARSkQlJgrUHOVvsoXQ2e9ukAMlxbTnKUj1dmCLykhgMZDWysKBB9sfgnqqolnvXKCz44kCxNmxHqtuWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hpZy+z857N9Z/Bzq+Cfo2Bv7faKL4poELv79lYLoPho=;
 b=lV0hHGnp9mLuNOfgbEk13OXQDNSk4H7CQVeSE62h2SHt3KsMbMvBi3CIll7rr1VhBpcwsOWoZUPvkLeiORSEz552U5oxhVIxDn3f9otS74L3dNwDAgkYLcTq159DYroPz1+Xk/b6rjffFWTw44EyhPEipJT2AUWBBRaqbPPcPCzXhwG4miF9Ld5PqjeclwqexVCbDM5559g+zOPgYUJHoicnSJKAzID2sb6IPbGyzG3LDazz07Ba9QTNdbfF4QeeA6WIcuW56R7k1TGYIgZHB6Uc3GFCvOUDpqdRrrnmJhmmv4MH6zE6rcuC5BMgMRoGs3OBQM634piHeHF10DFhPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hpZy+z857N9Z/Bzq+Cfo2Bv7faKL4poELv79lYLoPho=;
 b=fH/7XSxeOQVTXMD/m13S63vkTB9nj+b7Nhu71ea+YLnoJeSFJNdvGcvy7FG2Ihu3zPOIFfzkAnMpZh2AHfa349uEyFsC0g6cOMLxl4vqwTeBQ0Rs5U6QZUpYMIjoqw0gzaiQrYOKddNZBkGFVwcmYTVe5LUidwtym0snLX/LZBo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 SJ0PR12MB5673.namprd12.prod.outlook.com (2603:10b6:a03:42b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Thu, 20 Jul
 2023 00:04:19 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::bf76:da18:e4b4:746b]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::bf76:da18:e4b4:746b%7]) with mapi id 15.20.6609.024; Thu, 20 Jul 2023
 00:04:19 +0000
Message-ID: <8baedaad-4b4d-922f-fd12-14d68375bb13@amd.com>
Date: Wed, 19 Jul 2023 17:04:16 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v3 net-next 2/4] ionic: extract common bits from
 ionic_probe
Content-Language: en-US
To: Simon Horman <simon.horman@corigine.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 idosch@idosch.org, brett.creeley@amd.com, drivers@pensando.io
References: <20230717170001.30539-1-shannon.nelson@amd.com>
 <20230717170001.30539-3-shannon.nelson@amd.com>
 <ZLgh54I53tdedi/y@corigine.com>
From: Shannon Nelson <shannon.nelson@amd.com>
In-Reply-To: <ZLgh54I53tdedi/y@corigine.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR03CA0003.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::8) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|SJ0PR12MB5673:EE_
X-MS-Office365-Filtering-Correlation-Id: 25770a40-f349-44f3-d13a-08db88b4dd29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yEPLHz2bO9qz0BzuVSkAHs8DKhjM0N2htYjo5ePPEkAodhgXr8jfWwaVAaRt0yMDJLOeDTuTLeO56yiRHPsT9RmuTme5R74HgvA2Aof4AtmnAJ4PRbQ6tDDQzztWXE6I8b2NPTCD5M4nYA4FoDYOJSSjAxBS0igaQKvv5p92I+7wu6KHFohk8yTGWvewl9X9Bqd5y/1BIoQsH/nG5z1i9s+Q5sT+h23xSFkHzU4kZA2cOcEL/xLk6E5XYRBL1EFivWwQWBTKDU4N2JNYqZKHUPCDg4yFZ8Xsqt0aUfVIjS8YR5UFTc6Pg9gPiCedQDsIsODGAaEqm85Vc8wQEcvM3pTCnrHsfN/TheNwNuc7JojLdiE/K2+f+D3jpFNnfBifaplp4ek3FcePt3dwA8f8RYrNz16HuKbD4CwQK3Ybn0MPJIBhoSK2Qm5/iI7p49EuaAR3er+GeWtWet1UdJpFMggJL9xufCmRycMs8WFIC6cqpBnBTd61emMS5Ym9U6/hLBebTmcnUApEnmYYhZdKT8SXenBE5dtwIo5ZrJdg75aQw1SEbbGCAGZm6SgioMhfocKxv36v8XWy8lFSYuZDhapnfXwEMVlz4F+84OjLUoMgqzh6Bs7D51BzCmR2od4h/Jda1+u0QRQ11mCr9VqP4Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(136003)(366004)(396003)(39860400002)(451199021)(26005)(186003)(6506007)(31686004)(478600001)(66556008)(66946007)(316002)(4326008)(66476007)(53546011)(41300700001)(6916009)(86362001)(6666004)(8676002)(8936002)(44832011)(31696002)(6512007)(6486002)(5660300002)(36756003)(2616005)(2906002)(83380400001)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cjhobG5JQTBFWStReHp5V3BKckVUeTVDN2o4SXdDcmVlU0hjcTc2U1M0OUxG?=
 =?utf-8?B?OFhEdU1yTVZJd1dkSmFLcE9KUTJCZFRoMUtLeTY2Y2NLTXJMWTQwZmJ0ZTI5?=
 =?utf-8?B?NjFka1laeitxMnFTOGxWcFlmZ21ISXBNVEpTRVRSSkR5VmErSmtVSkVEMXlB?=
 =?utf-8?B?Vk4xY0k2RVd3Y1phcTArRVl3bFdJdmJlTzgxenVUL1F5b3lVNFJVSUVDR2tS?=
 =?utf-8?B?NkV4aU11b1ZhZU9iYWJBM2JwYWhoZXJOU3BTMDVCZGhGMVhzVFRGRk1WdWhs?=
 =?utf-8?B?bWhCZy8zdkNScFNjMDhkM1k4cHhpbFNmYytSNGRqMWo2cHViME5Nd2VNaUZu?=
 =?utf-8?B?MDdkT3Z0Z3dqSTNjdE1TdGJJN2YrUTFReU02UkdXdFJKT2FRQVU4TldKZ3J0?=
 =?utf-8?B?RGkrUUlEV1dER1VLYnBOZzF2YkZzVXpic3hHN3pwM1RMSEpzN3l5Q2EremJk?=
 =?utf-8?B?R0xSYjJvM1owUHBXRmVWUklkY3BDL3B1RzUvb0RWdVE0NTgvZWdYWHU2NkVG?=
 =?utf-8?B?b21HOWtCQUVZUTBWbUc4c1FqaTBveFJud21neFZBeGx3bGt3NGs5NysrblNx?=
 =?utf-8?B?NEFIU0t6NDVaSU9OcjJaeXFlMjU2MXVsWkxSUVBEaGM5ODlDMytEMWtRblUr?=
 =?utf-8?B?aG5CZW1tT3Z1MEtPOS96dUxTWnNNemRVQUZoWmxqNUpjcCtyR0dDa1dhOWYy?=
 =?utf-8?B?SjYvemhETjEyckRCSVc5eXFuN3VjTGx1UzQybU1mNitnamdPYzV6RWpZYUg2?=
 =?utf-8?B?Z0ZSdDlEVGxXWk9UeHdtVU9XT21wM1pLTitIUC9acHFXcHp5NS8vcHhNSk02?=
 =?utf-8?B?aXVsREZ4ZlJVUlBBYlpzN05jM0xLZ2NnYmg5cHVQL3d1NThJZXBXK0hGM3BN?=
 =?utf-8?B?UGx3UW1oTlFxVVB1bE5nK0ZHditvcmJhVW41V3Z6c3ZjVUUvdmgyNndpaXN0?=
 =?utf-8?B?RUVQMi9qWVlxTHJXNXlCczNnbXlwWXhWSktFYjFFejd1MTdSd1oydHVpdmhw?=
 =?utf-8?B?UnZ6Z1Jsd3NNS0tHbWFXamx2TnRrR2RUZllLbzFTVERobTlMaGJvN2Y2RGxE?=
 =?utf-8?B?eE90Mnc4L2pybTljZWxYYThXMi9jZ3hqOE1jaytCSmE3VEFwQmx3RWtwcERR?=
 =?utf-8?B?Z0JIRlpKaHlhU1dhRHJMN1VTc0NVWDFETmJMdGl0UmRMcnRKSTgrbldwK2Ew?=
 =?utf-8?B?K0hOUFB3QU9hOXVvYTAyQUUwdWVBcVpUT3ZpYjhwUHFZVmtSYkFBNzBkMmEw?=
 =?utf-8?B?Z0I1WUlrYUNFUVdjZnhRajRBd21wR25CUlFYTlVZemxtbTNjVG5oSkNONmFG?=
 =?utf-8?B?aVBvdjRpYVYxRDVPazdrOWkveTcxaVplT0lKcCtrU096c3c4MHdCQVh0S2N4?=
 =?utf-8?B?bmVlVHVUZFAyaTkvem5VS2pZSzM3ajd0aXBpZEZvQnVNdzBSRGhjTXVTQzhp?=
 =?utf-8?B?SGFQSXBLZFN4NVEyTTNVVTJnMUFLaEtkMDlBenlnZmRIcENoWlljSHhGZ1dK?=
 =?utf-8?B?RnJ4QWVRamhqS1NrOGpiNGoyejlNL0RPdVJJNnlGTDJrdHJ2cjZSOVRpbWhY?=
 =?utf-8?B?WDNGaTdYRUsreVFacVJxRDB1Y1lZZGUyTC9mY3kyWGJzOU9VcUhIK0RnRGkv?=
 =?utf-8?B?ZHoxa0lmN2pxN1JVcGxvK0tYalBFcHVFVEtja0tyd2hCekJwa3BzcnJ0VjdI?=
 =?utf-8?B?RDRhSnZPMnFTdkdyRHBUWm1ZUzNFSXZ2dW5ueitXeXdmQm5BQXVRd3R0N2R1?=
 =?utf-8?B?QStlRmZmQi9wZVlxZ2ZVcC8yZXhIT0dtb1hqYUQ0WGQxL1hFc1AzNTFJN25v?=
 =?utf-8?B?WDVwWFJJUGs1U3ptRFF2R0IzNUNFZGY2RjhIeHJPWC9wZ1VQOFRTTkYrSEUw?=
 =?utf-8?B?bmF1NE9OY0puUzNZampBL0tQZ1IwV2JnbFd0NitDek5qZ01tZittaERXeVFv?=
 =?utf-8?B?YXA4aTVLTzMveFUzQjhjQ0duNVJkaGZrRE5mREN1ckdtSm16VkIxUWUvWGdR?=
 =?utf-8?B?R2Z0SUV3R01vV3dMa2xaSG42cjltb1czb0R6dUo4TlZ1bnJzYXpEYjJ0RkY3?=
 =?utf-8?B?Mi9oTDU3dmlKcXNhVThjdDFkeUkrMS9ueXZvSzhDZkNVZ0I2eEJ0UUZzWnRM?=
 =?utf-8?Q?CBkpAiDoMK3v7W6ZwriEow8ct?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25770a40-f349-44f3-d13a-08db88b4dd29
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 00:04:19.0348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XeFtgL8pFPQPcrWp7ey6u/kKHf0Ieh0p43CkuGdfZQDY4GLFFSb9l1ZY23Iu6Uff+icRSOeMSgFcO2Mh7ilXEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5673
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 7/19/23 10:48 AM, Simon Horman wrote:
> 
> On Mon, Jul 17, 2023 at 09:59:59AM -0700, Shannon Nelson wrote:
>> Pull out some chunks of code from ionic_probe() that will
>> be common in rebuild paths.
>>
>> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
> 
> ...
> 
>> +static int ionic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>> +{
>> +     struct device *dev = &pdev->dev;
>> +     struct ionic *ionic;
>> +     int num_vfs;
>> +     int err;
>> +
>> +     ionic = ionic_devlink_alloc(dev);
>> +     if (!ionic)
>> +             return -ENOMEM;
>> +
>> +     ionic->pdev = pdev;
>> +     ionic->dev = dev;
>> +     pci_set_drvdata(pdev, ionic);
>> +     mutex_init(&ionic->dev_cmd_lock);
>> +
>> +     /* Query system for DMA addressing limitation for the device. */
>> +     err = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(IONIC_ADDR_LEN));
>> +     if (err) {
>> +             dev_err(dev, "Unable to obtain 64-bit DMA for consistent allocations, aborting.  err=%d\n",
>> +                     err);
>> +             goto err_out;
>> +     }
>> +
>> +     err = ionic_setup_one(ionic);
>> +     if (err)
>> +             goto err_out;
>> +
>>        /* Allocate and init the LIF */
>>        err = ionic_lif_size(ionic);
>>        if (err) {
>>                dev_err(dev, "Cannot size LIF: %d, aborting\n", err);
>> -             goto err_out_port_reset;
>> +             goto err_out_pci;
> 
> Hi Shannon,
> 
> Prior to this patch, if this error occurred then the following cleanup
> would occur.
> 
>          ionic_port_reset(ionic);
>          ionic_reset(ionic);
>          ionic_dev_teardown(ionic);
>          ionic_clear_pci(ionic);
>          ionic_debugfs_del_dev(ionic);
>          mutex_destroy(&ionic->dev_cmd_lock);
>          ionic_devlink_free(ionic);
> 
> With this patch I am assuming that the same setup has occurred at
> this point (maybe I am mistaken). But with the following cleanup on error.
> 
>          ionic_clear_pci(ionic);
>          mutex_destroy(&ionic->dev_cmd_lock);
>          ionic_devlink_free(ionic);
> 
> I feel that I'm reading this wrong.

You read that right.  The port_reset and reset are superflous so are 
dropped here.  However, that dev_teardown() does need to happen to be 
sure we don't leak a couple CMB related things.  I'll add that.

Thanks,
sln

> 
>>        }
>>
>>        err = ionic_lif_alloc(ionic);
>> @@ -354,17 +375,9 @@ static int ionic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>>        ionic->lif = NULL;
>>   err_out_free_irqs:
>>        ionic_bus_free_irq_vectors(ionic);
>> -err_out_port_reset:
>> -     ionic_port_reset(ionic);
>> -err_out_reset:
>> -     ionic_reset(ionic);
>> -err_out_teardown:
>> -     ionic_dev_teardown(ionic);
>> -err_out_clear_pci:
>> +err_out_pci:
>>        ionic_clear_pci(ionic);
>> -err_out_debugfs_del_dev:
>> -     ionic_debugfs_del_dev(ionic);
>> -err_out_clear_drvdata:
>> +err_out:
>>        mutex_destroy(&ionic->dev_cmd_lock);
>>        ionic_devlink_free(ionic);
>>
>> --
>> 2.17.1
>>
>>

