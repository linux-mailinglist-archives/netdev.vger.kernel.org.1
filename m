Return-Path: <netdev+bounces-56971-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 548CD8117A1
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 16:42:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29F38B20C46
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 15:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D1235EF5;
	Wed, 13 Dec 2023 15:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2kkJXMDk"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2070.outbound.protection.outlook.com [40.107.96.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE4AE18F
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 07:35:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HaM58Cn5+rHqi8b4USxIvvXxjDQWt0XJQoJVS/lFHINSkaXN8WTBY06Q9/W7Dh7SF3VSKTZL8HV0XCuGkjXDk3pNXDlTXUZPWnaxtuy46/CWL5WeaS2WNkDhoCrYcpM09CnSu4B0XVl3HW4na+A6cNyLtAdp2XjkizuZ3K98RDuMMfNTlw+U9G6EZBon8G/Ppe4AqYm4pWMP55sGJADEJI+iYqmEBZ3b4YIhJhwMzKpfoWvmQ4a09p4wZDpX6AxdBsgVH26jGEJVRY91OJaM3+Sm//s6GunHA92+jZvR902j8P5mwPnYToThA+9fX5QC3ubyQkPKxdRGdhpSFKP/QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j0Y4vT/vqKYATyQ/DS4FV3ga0mZNqe08twgzEVaOLWc=;
 b=Mc2Va08k6d+zgnCCbkfUpWkVEIc4dL2vdd3hI/1WMS9clTCgntQqvdPKY8z2xreD4F7YLBsPX9WLJEnz4dxz9OOUkUaeiL4M2N1lv7ujpMWSVp/oqP9YY2T6GQSWF2Vr0L8WFCjgNvNtxCIT/pTIupMxZq9dm1k61LIDwtaSJ2hf47RPubtaOhrg5JsiveaUDX5lXDxNhgdFICJJygpCMiGG3+wKcrEBi8p3jg5Rhi4xJ6G3EN6A0XykifjvgYgWCb9H433Qa/0bs8ABBex0kGfVYnQ5WY+bYW4KCsSbpeEAKf/I4AQNgKNiVyRVQ1/QpQdMsyaw+sKv9VIosBSy3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j0Y4vT/vqKYATyQ/DS4FV3ga0mZNqe08twgzEVaOLWc=;
 b=2kkJXMDkeH78W8w4Mdo9DqIbGcAYOi8nhfNMkfg3oh1gEd4BPOfbWtVfam75oANR3KuouKvxqxgUnsPQHDvtwzv+NOhVqC8wq+6DzG8Irce/z84/550eJy961mgLwJhaAHD9RZlCCZdHBUmVfTnOrq1ST0eADDriocduLqJKqmI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6395.namprd12.prod.outlook.com (2603:10b6:510:1fd::14)
 by BN9PR12MB5049.namprd12.prod.outlook.com (2603:10b6:408:132::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 15:35:29 +0000
Received: from PH7PR12MB6395.namprd12.prod.outlook.com
 ([fe80::5c36:94b0:958d:5c80]) by PH7PR12MB6395.namprd12.prod.outlook.com
 ([fe80::5c36:94b0:958d:5c80%6]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 15:35:29 +0000
Message-ID: <4d8ff5ad-b234-1c91-3119-f22b5bb32aa9@amd.com>
Date: Wed, 13 Dec 2023 21:05:19 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 net-next 1/3] amd-xgbe: reorganize the code of XPCS
 access
Content-Language: en-US
To: Tom Lendacky <thomas.lendacky@amd.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, Shyam-sundar.S-k@amd.com
References: <20231212053723.443772-1-Raju.Rangoju@amd.com>
 <20231212053723.443772-2-Raju.Rangoju@amd.com>
 <0dca661a-26d6-425c-a3c3-1b4ae94b3b47@amd.com>
From: Raju Rangoju <Raju.Rangoju@amd.com>
In-Reply-To: <0dca661a-26d6-425c-a3c3-1b4ae94b3b47@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0186.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e8::13) To PH7PR12MB6395.namprd12.prod.outlook.com
 (2603:10b6:510:1fd::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6395:EE_|BN9PR12MB5049:EE_
X-MS-Office365-Filtering-Correlation-Id: 29c4fbd7-32ba-4273-1bf7-08dbfbf122d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pnZrxKb4ZMv+F0nodBagY4QwSVDZaFP9bDyQMcffkR6r4J+9l/My55fNfuJ6bxv7BitIRXi6O/YhXmt/+xRyBjpOhe4hNys2+3vKv5QI4yNWpmtsDd9MNl27LgQDxLMxGUglqAiamLam9CLyOQDXgsYUvcuWC/w+l9dtthrhZwYyFU7JVtk24N5NzWe6RiGSz9JKYuwA1QR3irhUY5vEEN3LQZvwIfjdWbZZrUGUxFjyBllohNFn3lpGVKWwqX+3sOTB52NWBtpU9j1D3tUUxBTdlIrtGEn9zsQMRqUXu6/iJAb8MvDspTXN2G64kKGFq5kLZOSJnxhP+WshhQKAU2CzlqLTQWTHmJnG4e3azLYCzNxjxvNSmbmdP7MG/gf2Jj/qrkP0LdFEzXZ1JmgT3nr/lYF63SBUTeDlOEM4wE1d6yqSlYy2saqjRR8yxUg7hFRLm80aByGNWm9Msk2v96AvDqsk2dImdiPHf9O7YXJlo/rKc2PCaSXx6QJMhbjShFEaSZmaf8gLzBeF99rP6hmMfDFU9XxNx4kyztJPbcGQTWRlj9tDaT76aboUPszc8LSC5xXvfnjf7bwSDq3dGV+3tr5fQyiEaFRGUNvBwbJiYte8vfGP1xixdNaEzhNy96sM7G9/CNTB1798w2PRdQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6395.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(366004)(136003)(396003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(53546011)(26005)(83380400001)(2616005)(6512007)(6506007)(38100700002)(8676002)(5660300002)(4326008)(8936002)(41300700001)(2906002)(6486002)(6666004)(478600001)(316002)(66476007)(66946007)(66556008)(31696002)(86362001)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UW5HSGsvejBoNTRiWkd5QjVXYmFvREozK2ZiaXh4Ulg1cWdWam84MllHbEJW?=
 =?utf-8?B?Q3NpK1N6Unc3WVRqbDhsdm5Pa2dIV2hBeG9UdWt0UmpVN0JmdzZwb0hzMjh6?=
 =?utf-8?B?YmR4OVJURnlpTHNidktOdnhyYmJLRmhFMEhKN2dYQkxjeFRBdWJ4a1hzMlVi?=
 =?utf-8?B?Zm8xeUFybnZTRGJSbTdHRXlHTGdXZTVmbWg0YU1vL1hERExOaENDZXJVU0cw?=
 =?utf-8?B?RFB5RDFFMCs2ZUs4WEYrTEFhaEltRC8yc21DUThrOGJ4a2Q5N2ZUeVh4N1ZQ?=
 =?utf-8?B?YlB5Smc2WW1pMmtLTzNXSjdFQ0M3dmovaFgvZ0Vmem9tQXZXWll4ZWo5Y3Ri?=
 =?utf-8?B?VXdid0dCaWQveEhBR1V2Tzd0UXFlVk1sdDVsWE9LeXE3OVFYMHZaZ25KZUx5?=
 =?utf-8?B?VyszR1RFbld0T00ydzE3ZTRZV2dzY2llVnhIRkdveGZPbHpPNm1oVHJ0VlFN?=
 =?utf-8?B?M2JpZ1BUZEhkSDM4WE1NZXRrVHkrMDhqaWFQcEc2YkI1VUNsWG5hcTdkRDRi?=
 =?utf-8?B?T3RJVVgrSWsrQTlLcDFsa1Z2ajkyTzZGYnFIZCs2akRxMVhrYWI5dW1xQUpQ?=
 =?utf-8?B?VTFWTVd0L29XU3JYMnhSOE5RN1A0V1FKODROUUJtR3RoRWk5MVBYbVE0UWJZ?=
 =?utf-8?B?aEJldTNKbkFUb2Vha3ByQW4zVytkc2RrdUgyL0xuM0MzZmZoeWJEc25LY0Z4?=
 =?utf-8?B?UXA0cC9iOWxVU3UvOGtEL0VubmdDaElHVnNpMEFGTTBIQ0V0SEYyMHhGTVQ1?=
 =?utf-8?B?VkplWEFLNlVFMSs0QkZVcG9xR0xyRngxSGhUNVlFNVpjMk1xVGF3bkYzVUZ6?=
 =?utf-8?B?ZFV1TTNxdVNYODd0Mno5OGJ4RzFIZWZLZWpFY3FhbmM5T2E3ZThwR3p1amZo?=
 =?utf-8?B?eFdxRm8weU1xWWlaVm40RzFZZXRxd3dQY2l1T1lZNjU3MitienVtd3U5Tk4v?=
 =?utf-8?B?WmowckRaeWxXVkN3RDI3NHk3S0NuQTFLdXBacFZDRTVjWHNCVG1vS0J0aTRj?=
 =?utf-8?B?di96OUZoQk1YWG52TWgzak1KQmp0QklEM1k3VjFFYVBtTmxodkcvN2w3Uncw?=
 =?utf-8?B?NE1UaG9iMElxQWRob1Y1aW9OKzhNeU9LckNBSStWZndSTGRZYitFVkcrcVFs?=
 =?utf-8?B?OVBnM2NKN1VxcWh1N1RKVGdZYWpMS1lzODFscy9tR3pVTnNBRXh2UVhSMGVJ?=
 =?utf-8?B?TzZhRzJyR1NBNWJuMTBtdHlsWFdyOVlnOFJjbDdocmx5VFhqMmFNZUsrczdZ?=
 =?utf-8?B?WVBkRGtPWkR5MDRKMUxnWStiY0pOTFVoWW8vK0I1aWFncUtwQkYvYkJQd3pn?=
 =?utf-8?B?QWxVNm5TSndWZ2VINzM3aGJVNzlqdm96bktQTXhJTEtKNStmS1k2VmNxUDNh?=
 =?utf-8?B?c05ySjBoMmRFNjJtS1lHeG9pbWJFVThtdzQ5ZHU0clNZeE5HT3pTS3IxUnox?=
 =?utf-8?B?dlBOS2s0OTNTNTBUZGVnQ3hmdnlWbFlDUlMrZnBwbGE4dkxYZ1JHdjE1VTUv?=
 =?utf-8?B?YSt0dHNkL3V3QnVXRUk4NXpiQnlLMk4yMCsrNjdiSWhnWHdaM0t5ZFlPZzlm?=
 =?utf-8?B?dEMrVms2QU03d1crdGdMdmhDbE5sdWV1UnN5TnhqNGEzTEhabzZZSXE1T0pr?=
 =?utf-8?B?NnVYQ0I2YTJRR21Nc0Mwc0R2ejY3OTFETEN4SDhaTVFMemYyZ25mMFFyeTBK?=
 =?utf-8?B?U2Rta2FkQVppU3kvbzVJaFhDSHVzbmNxOWdrdTZpbWRIR3JjWHl0K3NaUi9p?=
 =?utf-8?B?YkNDOXlWbUFUdGh3bXp3MmdkZHRUK2VtNC9JeGlBSXUwb2swYWJJOFZVVXBk?=
 =?utf-8?B?TVFEYmRVL0toK3NEMk42WVl3TkNnTVRlTW05b0hPOEl2bm1RN2NiVUlhMWd5?=
 =?utf-8?B?QWh1bHE4Y0o1RE5JZFpPNFZnUWlBTDJjMWRzemZ5U2NEVDFoem80OTZZOTNP?=
 =?utf-8?B?Zm1wUmhBL2FrYjdHVlpRelpDVEFnTCtKZWRCVm9MYXlld0hkZCtCN1ZsV01L?=
 =?utf-8?B?NDllM3hYQzRETjhzOS93QTQwaE1sTjUweGUyMm9sSGR5T0VHQ2pQbDJjTzYz?=
 =?utf-8?B?Mm8yWkQ2WWowR2dMYmVDMmlaWUFCUjMvUG5HVXRNNEt1bDNoRlJZb1BxRVB0?=
 =?utf-8?Q?y2oLjiEq0VGXnSLyssya5d1f9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29c4fbd7-32ba-4273-1bf7-08dbfbf122d1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6395.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 15:35:29.6355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: anU7D60nKthkrf9zlqSHMd0mSVseHCV1Ouacq+zlHPVPwGW6m2zuPk+eTYSdtpf4f2m+m38JXwp1eUx8RbvrIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5049



On 12/12/2023 8:03 PM, Tom Lendacky wrote:
> On 12/11/23 23:37, Raju Rangoju wrote:
>> The xgbe_{read/write}_mmd_regs_v* functions have common code which can
>> be moved to helper functions. Also, the xgbe_pci_probe() needs
>> reorganization.
>>
>> Add new helper functions to calculate the mmd_address for v1/v2 of xpcs
>> access. And, convert if/else statements in xgbe_pci_probe() to switch
>> case. This helps code look cleaner.
>>
>> Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
>> ---
>>   drivers/net/ethernet/amd/xgbe/xgbe-dev.c | 43 ++++++++++++------------
>>   drivers/net/ethernet/amd/xgbe/xgbe-pci.c | 18 +++++++---
>>   2 files changed, 34 insertions(+), 27 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c 
>> b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
>> index f393228d41c7..6cd003c24a64 100644
>> --- a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
>> +++ b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
>> @@ -1150,6 +1150,21 @@ static int xgbe_set_gpio(struct xgbe_prv_data 
>> *pdata, unsigned int gpio)
>>       return 0;
>>   }
>> +static unsigned int get_mmd_address(struct xgbe_prv_data *pdata, int 
>> mmd_reg)
>> +{
>> +    return (mmd_reg & XGBE_ADDR_C45) ?
>> +        mmd_reg & ~XGBE_ADDR_C45 :
>> +        (pdata->mdio_mmd << 16) | (mmd_reg & 0xffff);
>> +}
>> +
>> +static unsigned int get_index_offset(struct xgbe_prv_data *pdata, 
>> unsigned int mmd_address,
>> +                     unsigned int *index)
> 
> Just my opinion, but this looks confusing to me by updating index and 
> returning
> offset. And the name is confusing, too. I think it would read better as:
> 
> static void get_pcs_index_and_offset(struct xgbe_prv_data *pdata, 
> unsigned int mmd_address,
>                       unsigned int *index, unsigned int *offset)
> {
>      mmd_address <<= 1;
>      *index = mmd_address & ~pdata->xpcs_window_mask;
>      *offset = pdata->xpcs_window + (mmd_address & 
> pdata->xpcs_window_mask);
> }
> 

Sure

> Or break this into two functions:
> 
> static unsigned int get_pcs_index(struct xgbe_prv_data *pdata, unsigned 
> int mmd_address)
> {
>      return (mmd_address << 1) & ~pdata->xpcs_window_mask;
> }
> 
> static unsigned int get_pcs_offset(struct xgbe_prv_data *pdata, unsigned 
> int mmd_address)
> {
>      return pdata->xpcs_window + ((mmd_address << 1) & 
> pdata->xpcs_window_mask);
> }
> 
>> +{
>> +    mmd_address <<= 1;
>> +    *index = mmd_address & ~pdata->xpcs_window_mask;
>> +    return pdata->xpcs_window + (mmd_address & pdata->xpcs_window_mask);
>> +}
>> +
>>   static int xgbe_read_mmd_regs_v2(struct xgbe_prv_data *pdata, int 
>> prtad,
>>                    int mmd_reg)
>>   {
>> @@ -1157,10 +1172,7 @@ static int xgbe_read_mmd_regs_v2(struct 
>> xgbe_prv_data *pdata, int prtad,
>>       unsigned int mmd_address, index, offset;
>>       int mmd_data;
>> -    if (mmd_reg & XGBE_ADDR_C45)
>> -        mmd_address = mmd_reg & ~XGBE_ADDR_C45;
>> -    else
>> -        mmd_address = (pdata->mdio_mmd << 16) | (mmd_reg & 0xffff);
>> +    mmd_address = get_mmd_address(pdata, mmd_reg);
>>       /* The PCS registers are accessed using mmio. The underlying
>>        * management interface uses indirect addressing to access the MMD
>> @@ -1171,9 +1183,7 @@ static int xgbe_read_mmd_regs_v2(struct 
>> xgbe_prv_data *pdata, int prtad,
>>        * register offsets must therefore be adjusted by left shifting the
>>        * offset 1 bit and reading 16 bits of data.
>>        */
>> -    mmd_address <<= 1;
>> -    index = mmd_address & ~pdata->xpcs_window_mask;
>> -    offset = pdata->xpcs_window + (mmd_address & 
>> pdata->xpcs_window_mask);
>> +    offset = get_index_offset(pdata, mmd_address, &index);
> 
> The comment above this code should be moved into the new helper and then
> removed here and below.

Sure, I'll take care of this.

> 
>>       spin_lock_irqsave(&pdata->xpcs_lock, flags);
>>       XPCS32_IOWRITE(pdata, pdata->xpcs_window_sel_reg, index);
>> @@ -1189,10 +1199,7 @@ static void xgbe_write_mmd_regs_v2(struct 
>> xgbe_prv_data *pdata, int prtad,
>>       unsigned long flags;
>>       unsigned int mmd_address, index, offset;
>> -    if (mmd_reg & XGBE_ADDR_C45)
>> -        mmd_address = mmd_reg & ~XGBE_ADDR_C45;
>> -    else
>> -        mmd_address = (pdata->mdio_mmd << 16) | (mmd_reg & 0xffff);
>> +    mmd_address = get_mmd_address(pdata, mmd_reg);
>>       /* The PCS registers are accessed using mmio. The underlying
>>        * management interface uses indirect addressing to access the MMD
>> @@ -1203,9 +1210,7 @@ static void xgbe_write_mmd_regs_v2(struct 
>> xgbe_prv_data *pdata, int prtad,
>>        * register offsets must therefore be adjusted by left shifting the
>>        * offset 1 bit and writing 16 bits of data.
>>        */
>> -    mmd_address <<= 1;
>> -    index = mmd_address & ~pdata->xpcs_window_mask;
>> -    offset = pdata->xpcs_window + (mmd_address & 
>> pdata->xpcs_window_mask);
>> +    offset = get_index_offset(pdata, mmd_address, &index);
>>       spin_lock_irqsave(&pdata->xpcs_lock, flags);
>>       XPCS32_IOWRITE(pdata, pdata->xpcs_window_sel_reg, index);
>> @@ -1220,10 +1225,7 @@ static int xgbe_read_mmd_regs_v1(struct 
>> xgbe_prv_data *pdata, int prtad,
>>       unsigned int mmd_address;
>>       int mmd_data;
>> -    if (mmd_reg & XGBE_ADDR_C45)
>> -        mmd_address = mmd_reg & ~XGBE_ADDR_C45;
>> -    else
>> -        mmd_address = (pdata->mdio_mmd << 16) | (mmd_reg & 0xffff);
>> +    mmd_address = get_mmd_address(pdata, mmd_reg);
>>       /* The PCS registers are accessed using mmio. The underlying APB3
>>        * management interface uses indirect addressing to access the MMD
>> @@ -1248,10 +1250,7 @@ static void xgbe_write_mmd_regs_v1(struct 
>> xgbe_prv_data *pdata, int prtad,
>>       unsigned int mmd_address;
>>       unsigned long flags;
>> -    if (mmd_reg & XGBE_ADDR_C45)
>> -        mmd_address = mmd_reg & ~XGBE_ADDR_C45;
>> -    else
>> -        mmd_address = (pdata->mdio_mmd << 16) | (mmd_reg & 0xffff);
>> +    mmd_address = get_mmd_address(pdata, mmd_reg);
>>       /* The PCS registers are accessed using mmio. The underlying APB3
>>        * management interface uses indirect addressing to access the MMD
>> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-pci.c 
>> b/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
>> index f409d7bd1f1e..8b0c1e450b7e 100644
>> --- a/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
>> +++ b/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
>> @@ -274,12 +274,18 @@ static int xgbe_pci_probe(struct pci_dev *pdev, 
>> const struct pci_device_id *id)
>>       /* Set the PCS indirect addressing definition registers */
>>       rdev = pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(0, 0));
>> -    if (rdev &&
>> -        (rdev->vendor == PCI_VENDOR_ID_AMD) && (rdev->device == 
>> 0x15d0)) {
>> +
>> +    if (!(rdev && rdev->vendor == PCI_VENDOR_ID_AMD)) {
>> +        ret = -ENODEV;
>> +        goto err_pci_enable;
>> +    }
> 
> This is different behavior compared to today. Today, everything would
> default to the final "else" statement. With this patch you have a
> possibility of failing probe now.

This was done to skip the cases where rdev is NULL or vendor != AMD. Not 
sure if I'm missing something.

> 
> Thanks,
> Tom
> 
>> +
>> +    switch (rdev->device) {
>> +    case 0x15d0:
>>           pdata->xpcs_window_def_reg = PCS_V2_RV_WINDOW_DEF;
>>           pdata->xpcs_window_sel_reg = PCS_V2_RV_WINDOW_SELECT;
>> -    } else if (rdev && (rdev->vendor == PCI_VENDOR_ID_AMD) &&
>> -           (rdev->device == 0x14b5)) {
>> +        break;
>> +    case 0x14b5:
>>           pdata->xpcs_window_def_reg = PCS_V2_YC_WINDOW_DEF;
>>           pdata->xpcs_window_sel_reg = PCS_V2_YC_WINDOW_SELECT;
>> @@ -288,9 +294,11 @@ static int xgbe_pci_probe(struct pci_dev *pdev, 
>> const struct pci_device_id *id)
>>           /* Yellow Carp devices do not need rrc */
>>           pdata->vdata->enable_rrc = 0;
>> -    } else {
>> +        break;
>> +    default:
>>           pdata->xpcs_window_def_reg = PCS_V2_WINDOW_DEF;
>>           pdata->xpcs_window_sel_reg = PCS_V2_WINDOW_SELECT;
>> +        break;
>>       }
>>       pci_dev_put(rdev);

