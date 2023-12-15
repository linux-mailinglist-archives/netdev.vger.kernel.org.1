Return-Path: <netdev+bounces-57774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C49628140FE
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 05:36:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2832E2817F1
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 04:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A790804;
	Fri, 15 Dec 2023 04:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QElkpkuT"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2076.outbound.protection.outlook.com [40.107.100.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D99D267
	for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 04:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ASwKbCjTZktMVMPMMEP2rC9ez0e73mF9oSYVfqcBprtuW6V/P9tf5uaVz5KWAbTDJYbuBGTvH8BZEBYwK7KEeZNM+ahM/lI85NHN/kbZKdzdZ5Xwes3VZoDnvEVNLFjLPduTmrznCncNbnmZOnEmT49rS/NR3XgZzvyat7giInehSJdVfttm4d3nlUvGbAHOboZ753O5kpsGRcaT3N/0xPahlWTcbS37b9GE5Cwe4mcFtNTMXyud0bJSwIQxGoxk+BS9aGTMpb9ccynxVQj/gCXOz8+u57mDArzfk09aVFlsMA84IlxZsl4iU2+omf+e48YGc7zFgY5EF+mX2NlKPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DmK/JEqnMF6iKtHy8gfl+eA3UXbE3Dk+fUlFkijJU2U=;
 b=SlD14a0TJUYqnxg8ic/sCoUyYmOr9LoeUlRXCFNTQty2AThhnVF868VJ1ef6jorcmycui941gVLHnlM9ant5nAe32pdF3DdLg34h+ltnnsIElCb7l5En9n/ObUSa84CsGCgQX2jhUVSWXT4Vf3+P+m7kCJUAo9IN+ZHkhOE+tg6r+IHMvOhUYyecu4yvrVuI7reoAUUB0Vwt6gG7ZLHefuojodeSHdlLOl6lbcbvvNbSBAXMthRwJmcn8tzCr9BZGiEU3JX8g41/ige8IOMuJlr9UqzppFuWcV0I2YkmNVfyHPyjktoiXMp6sGVxHe9SoesTFP6HCzSeivwQxNjXpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DmK/JEqnMF6iKtHy8gfl+eA3UXbE3Dk+fUlFkijJU2U=;
 b=QElkpkuTGgxWDFGHm1plFgvqU/MZ3zhkYxgqxviUaF07mGKnQwB4RRWn0KfU/r262nGcjmBiaIZ6ZqTwWqgc3muF6YbqeGBHP7zj/Dv7pgh2oEYOY7PpGYvPENpMl7w1vRrhkfGo5mninnnmiv90P6Z15JFMSBnGt90vsgzhkS8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6395.namprd12.prod.outlook.com (2603:10b6:510:1fd::14)
 by SA1PR12MB6680.namprd12.prod.outlook.com (2603:10b6:806:253::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Fri, 15 Dec
 2023 04:35:51 +0000
Received: from PH7PR12MB6395.namprd12.prod.outlook.com
 ([fe80::5c36:94b0:958d:5c80]) by PH7PR12MB6395.namprd12.prod.outlook.com
 ([fe80::5c36:94b0:958d:5c80%6]) with mapi id 15.20.7091.028; Fri, 15 Dec 2023
 04:35:51 +0000
Message-ID: <82f60707-a24d-b745-ab25-7909b24c629e@amd.com>
Date: Fri, 15 Dec 2023 10:05:40 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 net-next 3/3] amd-xgbe: use smn functions to avoid race
Content-Language: en-US
To: Tom Lendacky <thomas.lendacky@amd.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, Shyam-sundar.S-k@amd.com
References: <20231212053723.443772-1-Raju.Rangoju@amd.com>
 <20231212053723.443772-4-Raju.Rangoju@amd.com>
 <68c52e74-dd8d-4211-bdb9-9541b41c6900@amd.com>
From: Raju Rangoju <Raju.Rangoju@amd.com>
In-Reply-To: <68c52e74-dd8d-4211-bdb9-9541b41c6900@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0135.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::6) To PH7PR12MB6395.namprd12.prod.outlook.com
 (2603:10b6:510:1fd::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6395:EE_|SA1PR12MB6680:EE_
X-MS-Office365-Filtering-Correlation-Id: f6947d83-3c63-45df-b53b-08dbfd27516a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bd8sO6tpw86wdvHjJBwNHVBDBCij1h33jBL3Cw1GZ+7SsuEiefwDYBxXD6178lePjOdaRyThU3Z08t10WqgkKVnw86W044GirwTUTfW0LsJMy4bQcKVrS3IvawtnZ9STkXQXdqzh+/Tiin0XIN6zSp4pmAVWZOlUlgBkhPXo4GgHYNQf8iHZ3Momvoakbxp4HhomHJGRLVCW0ZXLP4vu2zTZ5y1uhoQ2bHUmlTJvzcgOKllGrPeJFnWu6uinTSCLaXCwpPFi5NVXkAszwsA/PGtcEfoc+VTKvpUJLCcZZc2zK7KIYlAam6pn6N8L9WAdorZNW1OIeh7n6+1V0KYkWmTvYbgEOBkw9F8n9+5thRZvFHqg0c8sxBaZludreIIcE6IPLGVL8b54jJy0W8YG9AbOKV4yV3XGXuTozSDmoaZAJ0z9VvGD86VlXTOZ0ek03CFVRh71q8wqACItepfeijUrmdpTMmNQBO7kjLiEOeNR9WjFFDl80VUuP0h8USvO1D3e1bbW80RR8czUCZL3L2nEofkb1lj75ufwGtHv2zwIjk9Vbj64lsNfLXi6jwpd4n/CU0igKIcNS5VKUkx+ooLGU8yTazILLSAzgLZwbFbw2M5njJWOrwwHFIZRI9vhyp1OPyu/YDvVzCzAb3L2YA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6395.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(39860400002)(366004)(396003)(376002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(31686004)(26005)(6506007)(2616005)(6666004)(31696002)(36756003)(86362001)(38100700002)(83380400001)(4326008)(5660300002)(6512007)(53546011)(316002)(66946007)(8676002)(6486002)(8936002)(66556008)(66476007)(41300700001)(478600001)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?czFGeStKNnlXVjZyTFA2d0plemtaTHRXQlpLK0RkUUhpQkY0bm1lOGVmdGs0?=
 =?utf-8?B?TjJiclhwODZHTWJ3NDlBdFRCcmt2ckFHSVlUeENnTGxCWlpxZkFTQmtySFpI?=
 =?utf-8?B?elZHWG43K3JCKzNOa2dyd2RvaG5DNG1PQTFob3JxeFBDcU1adEVtRW53bkFP?=
 =?utf-8?B?UjVZL09pMUM2N0J2aXltakhka3dyLzVwSHdFUFgwS05OYXBUaDJSWGhRaThS?=
 =?utf-8?B?eTZtTSt2TllXRjJ3TTc4a1BzbEF3bUY0VzdMVnA2VVlJT25JMTZUcFVUa2hK?=
 =?utf-8?B?YnFsQStIV0pJY3dnRXpRRUI4MVF4dWhjRkFSb3hueGo4Y3pxTXo2WlIvbHJ1?=
 =?utf-8?B?VGIzU2lLS0d4YTl6ODdjak9mMDVGQjRibHM2cTh4MUlmS3Z2Vm5CNXRkMVVK?=
 =?utf-8?B?VThUbWIzelZ2ODRuejJZZ2xYd0p4SmJJdit2ajgzQU5sVVVScnBHb1NBdFJ2?=
 =?utf-8?B?VU0wVm5NODBsWjNtd3dtUVd5S0FqSmRFTU1OblFxUmxaeUpGdGtYN25Ka0M5?=
 =?utf-8?B?R2I0NDJ2MWZsUUdtRUFvL3FITEc4Y0puYkxDL0k4RGcvUTNaRUpyN3R0SVd1?=
 =?utf-8?B?azB1U25ISXVqWEdpem9Pd0tLVUo3MUQ3N0dmM3lja0thUVVZRzJTWWpKNXlZ?=
 =?utf-8?B?THE0b3Q0TklMQVlIZzVwR1JqQzF1TVV4dE9MRHhNOWF2R3NhRGU1QXl6ZWdj?=
 =?utf-8?B?WnA5RGtibHRVKzVZemxybXJpZFhuc1k2QUoxVVVTMk1WYjVmaHY5Vlg1TUoy?=
 =?utf-8?B?ZExSOFNQOTR4OFZWajdaQUlPcHUxZk83bG90QkZzSGdGZSsrcTFlTzF1YXBl?=
 =?utf-8?B?cG9JRE1qTjRndW9iU08wM3pJL1dVMDQ3NGxiRWVPa3FYNVR1TTc4M3dxcjBB?=
 =?utf-8?B?Nk9OU01TSnBWUFYrb0VhT2ZGS0cxRkxFNlVuelQwQzBHa2NlK1ZKMnNhZW1j?=
 =?utf-8?B?Yjh2REpoRENkYVBWc2RzU29JSEptTTJoNEx1Y1ZhTmVKRW5WdC9OQ0E3eUtv?=
 =?utf-8?B?SEMwVy9sRWtUcENiVEIyMmVrRitJd21qNUJGOFRDSC9UTkNUVGRJK1ZCb09E?=
 =?utf-8?B?TDZPM1B3Q2hMNHhTR0hJaml5dUh1Z2h0WXdrOVJFT2Q5cVplRHZ0cXI3SVdx?=
 =?utf-8?B?VllnNEdOZHQzbkxTUzkzK05RU2pOOVU2K3VMU3J3eWxRNUgyRDBKeVBwRDZx?=
 =?utf-8?B?b3lRaGI5dDZocVJodmVaYmhuSTZveTVQOEUyOHdoTDdsNE9OaCsxTjE2Nys5?=
 =?utf-8?B?OHZZRTZnTVdyR053ZXkwdytLcjRqVXl1RW5Rb1RueHNFTEQvRTAxSGhTbjZw?=
 =?utf-8?B?dmszTFU0dDIyYVYwcFlJM2FjWitaSHQxWGZIR0hvcnduK1NKVHQ1N3Q3R3VQ?=
 =?utf-8?B?TmpGd1NyNEpvS1lTdWo5MVBzRDU5R0NqYkpNdjh4bWhvUE9tN0hwMmxyTFAv?=
 =?utf-8?B?NEk2M0kxbmFOdGtSUXZ3Y0ExYkN1RGFDcHpVOGVEKzZ0NHJHdWJaVHVZUnJT?=
 =?utf-8?B?K3JYYzNGenlGYVpUMk9LTHhtMHQzaEhvaTd1Nkt3RE9tZE5OVnF2bjBkTC9P?=
 =?utf-8?B?ZEhXTVR5VkVRSmVPayttU2pUUzgvb3BUZEVnaWk1TDdNbWVOUjZmK1NGSS9X?=
 =?utf-8?B?elV0Rm1FM0VDQVl6UzRwZGE1bEFUYnNUNFJlMFpRdXdzWGEvK1M5OGNiVHdS?=
 =?utf-8?B?dHZ1RnRhbTJ1QndjQ1dUZ0JvSVBXcEVCVVB0ajNTQXFBSkYvVzZlUENYczVC?=
 =?utf-8?B?MXUvS1R5TGdVUDhYTGVaYmg0S2lXNENrQXdNNnRlTnZRemZpLzFhblQyZUZR?=
 =?utf-8?B?L1h2aTR4QU9Ud1Z6L3BGaXhDb1pIMVFGamJ3RVN3cDRBMGhVVlliaDZ1ZlV6?=
 =?utf-8?B?aXkwNkRNRWFULys1bHlXaEtReVE0L0ZsVE1BRVBpOG1EV1M1bHJVZk5FODdr?=
 =?utf-8?B?T3o0TFhqNEpjUFJwc2R0UFZBRXZSUHdvMk4vRE55OEdkNnhGcmxjT2tQeHRV?=
 =?utf-8?B?NHpTTXNpMnZSWHdaZ1FKVkNncXdSdWRQbnZ6WnM4L1ltaEpmUEtEeUQxQklM?=
 =?utf-8?B?cmVYWXFSUHpyOEpmMXlPZEN3QUx3Y25BR3ljL2x3ZjBSVVY5ZXI3YTlKU2lN?=
 =?utf-8?Q?rv282vZNSrTS8TsIm1C63YS8P?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f6947d83-3c63-45df-b53b-08dbfd27516a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6395.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 04:35:51.6034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LCweJminTjDYD5TOZYKYy0Sn4tlJmLXTLofgnEvq/iMefxs+QcKcwW3IS2swj0b0FysKRxAadavZ4FSq5xkhjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6680



On 12/12/2023 9:08 PM, Tom Lendacky wrote:
> On 12/11/23 23:37, Raju Rangoju wrote:
>> Some of the ethernet add-in-cards have dual PHY but share a single MDIO
>> line (between the ports). In such cases, link inconsistencies are
>> noticed during the heavy traffic and during reboot stress tests.
>>
>> So, use the SMN calls to avoid the race conditions.
> 
> So this patch replaces all the PCI accesses you added in patch #2, so 
> why not just do this from the start?

Yes, that is correct. It was done to maintain the history and that will 
be reference as to why SMN is used over regular PCI accesses in this case.

> 
>>
>> Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
>> ---
>>   drivers/net/ethernet/amd/xgbe/xgbe-dev.c | 33 ++++++------------------
>>   drivers/net/ethernet/amd/xgbe/xgbe-pci.c | 10 +++----
>>   drivers/net/ethernet/amd/xgbe/xgbe-smn.h | 27 +++++++++++++++++++
>>   drivers/net/ethernet/amd/xgbe/xgbe.h     |  2 +-
>>   4 files changed, 41 insertions(+), 31 deletions(-)
>>   create mode 100644 drivers/net/ethernet/amd/xgbe/xgbe-smn.h
>>
>> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c 
>> b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
>> index a9eb2ffa9f73..8d8876ab258c 100644
>> --- a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
>> +++ b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
>> @@ -124,6 +124,7 @@
>>   #include "xgbe.h"
>>   #include "xgbe-common.h"
>> +#include "xgbe-smn.h"
>>   static inline unsigned int xgbe_get_max_frame(struct xgbe_prv_data 
>> *pdata)
>>   {
>> @@ -1170,14 +1171,9 @@ static int xgbe_read_mmd_regs_v3(struct 
>> xgbe_prv_data *pdata, int prtad,
>>                    int mmd_reg)
>>   {
>>       unsigned int mmd_address, index, offset;
>> -    struct pci_dev *rdev;
>>       unsigned long flags;
>>       int mmd_data;
>> -    rdev = pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(0, 0));
>> -    if (!rdev)
>> -        return 0;
>> -
>>       mmd_address = get_mmd_address(pdata, mmd_reg);
>>       /* The PCS registers are accessed using mmio. The underlying
>> @@ -1192,13 +1188,10 @@ static int xgbe_read_mmd_regs_v3(struct 
>> xgbe_prv_data *pdata, int prtad,
>>       offset = get_index_offset(pdata, mmd_address, &index);
>>       spin_lock_irqsave(&pdata->xpcs_lock, flags);
>> -    pci_write_config_dword(rdev, 0x60, (pdata->xphy_base + 
>> pdata->xpcs_window_sel_reg));
>> -    pci_write_config_dword(rdev, 0x64, index);
>> -    pci_write_config_dword(rdev, 0x60, pdata->xphy_base + offset);
>> -    pci_read_config_dword(rdev, 0x64, &mmd_data);
>> +    amd_smn_write(0, (pdata->smn_base + pdata->xpcs_window_sel_reg), 
>> index);
>> +    amd_smn_read(0, pdata->smn_base + offset, &mmd_data);
>>       mmd_data = (offset % 4) ? FIELD_GET(XGBE_GEN_HI_MASK, mmd_data) :
>>                     FIELD_GET(XGBE_GEN_LO_MASK, mmd_data);
>> -    pci_dev_put(rdev);
>>       spin_unlock_irqrestore(&pdata->xpcs_lock, flags);
>> @@ -1209,13 +1202,8 @@ static void xgbe_write_mmd_regs_v3(struct 
>> xgbe_prv_data *pdata, int prtad,
>>                      int mmd_reg, int mmd_data)
>>   {
>>       unsigned int mmd_address, index, offset, ctr_mmd_data;
>> -    struct pci_dev *rdev;
>>       unsigned long flags;
>> -    rdev = pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(0, 0));
>> -    if (!rdev)
>> -        return;
>> -
>>       mmd_address = get_mmd_address(pdata, mmd_reg);
>>       /* The PCS registers are accessed using mmio. The underlying
>> @@ -1230,10 +1218,9 @@ static void xgbe_write_mmd_regs_v3(struct 
>> xgbe_prv_data *pdata, int prtad,
>>       offset = get_index_offset(pdata, mmd_address, &index);
>>       spin_lock_irqsave(&pdata->xpcs_lock, flags);
>> -    pci_write_config_dword(rdev, 0x60, (pdata->xphy_base + 
>> pdata->xpcs_window_sel_reg));
>> -    pci_write_config_dword(rdev, 0x64, index);
>> -    pci_write_config_dword(rdev, 0x60, pdata->xphy_base + offset);
>> -    pci_read_config_dword(rdev, 0x64, &ctr_mmd_data);
>> +    amd_smn_write(0, (pdata->smn_base + pdata->xpcs_window_sel_reg), 
>> index);
>> +    amd_smn_read(0, pdata->smn_base + offset, &ctr_mmd_data);
>> +
>>       if (offset % 4) {
>>           ctr_mmd_data = FIELD_PREP(XGBE_GEN_HI_MASK, mmd_data) |
>>                      FIELD_GET(XGBE_GEN_LO_MASK, ctr_mmd_data);
>> @@ -1243,12 +1230,8 @@ static void xgbe_write_mmd_regs_v3(struct 
>> xgbe_prv_data *pdata, int prtad,
>>                      FIELD_GET(XGBE_GEN_LO_MASK, mmd_data);
>>       }
>> -    pci_write_config_dword(rdev, 0x60, (pdata->xphy_base + 
>> pdata->xpcs_window_sel_reg));
>> -    pci_write_config_dword(rdev, 0x64, index);
>> -    pci_write_config_dword(rdev, 0x60, (pdata->xphy_base + offset));
>> -    pci_write_config_dword(rdev, 0x64, ctr_mmd_data);
>> -    pci_dev_put(rdev);
>> -
>> +    amd_smn_write(0, (pdata->smn_base + pdata->xpcs_window_sel_reg), 
>> index);
>> +    amd_smn_write(0, (pdata->smn_base + offset), ctr_mmd_data);
>>       spin_unlock_irqrestore(&pdata->xpcs_lock, flags);
>>   }
>> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-pci.c 
>> b/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
>> index db3e8aac3339..135128b5be90 100644
>> --- a/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
>> +++ b/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
>> @@ -121,6 +121,7 @@
>>   #include "xgbe.h"
>>   #include "xgbe-common.h"
>> +#include "xgbe-smn.h"
>>   static int xgbe_config_multi_msi(struct xgbe_prv_data *pdata)
>>   {
>> @@ -304,18 +305,17 @@ static int xgbe_pci_probe(struct pci_dev *pdev, 
>> const struct pci_device_id *id)
>>           pdata->xpcs_window_sel_reg = PCS_V2_WINDOW_SELECT;
>>           break;
>>       }
>> +    pci_dev_put(rdev);
>>       /* Configure the PCS indirect addressing support */
>>       if (pdata->vdata->xpcs_access == XGBE_XPCS_ACCESS_V3) {
>>           reg = XP_IOREAD(pdata, XP_PROP_0);
>> -        pdata->xphy_base = PCS_RN_SMN_BASE_ADDR +
>> -                   (PCS_RN_PORT_ADDR_SIZE * XP_GET_BITS(reg, 
>> XP_PROP_0, PORT_ID));
>> -        pci_write_config_dword(rdev, 0x60, pdata->xphy_base + 
>> (pdata->xpcs_window_def_reg));
>> -        pci_read_config_dword(rdev, 0x64, &reg);
>> +        pdata->smn_base = PCS_RN_SMN_BASE_ADDR +
>> +                  (PCS_RN_PORT_ADDR_SIZE * XP_GET_BITS(reg, 
>> XP_PROP_0, PORT_ID));
>> +        amd_smn_read(0, pdata->smn_base + 
>> (pdata->xpcs_window_def_reg), &reg);
>>       } else {
>>           reg = XPCS32_IOREAD(pdata, pdata->xpcs_window_def_reg);
>>       }
>> -    pci_dev_put(rdev);
>>       pdata->xpcs_window = XPCS_GET_BITS(reg, PCS_V2_WINDOW_DEF, OFFSET);
>>       pdata->xpcs_window <<= 6;
>> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-smn.h 
>> b/drivers/net/ethernet/amd/xgbe/xgbe-smn.h
>> new file mode 100644
>> index 000000000000..bd25ddc7c869
>> --- /dev/null
>> +++ b/drivers/net/ethernet/amd/xgbe/xgbe-smn.h
>> @@ -0,0 +1,27 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * AMD 10Gb Ethernet driver
>> + *
>> + * Copyright (c) 2023, Advanced Micro Devices, Inc.
>> + * All Rights Reserved.
>> + *
>> + * Author: Raju Rangoju <Raju.Rangoju@amd.com>
>> + */
> 
> Shouldn't this license match the license in all the other files?
> 
> Also, you need header protection here, e.g.:
> 
> #ifndef __XGBE_SMN_H__
> #define __XGBE_SMN_H__
> 
> and a #endif at the end.

Sure Tom, I'll take care of this.

> 
> Thanks,
> Tom
> 
>> +
>> +#ifdef CONFIG_AMD_NB
>> +
>> +#include <asm/amd_nb.h>
>> +
>> +#else
>> +
>> +static inline int amd_smn_write(u16 node, u32 address, u32 value)
>> +{
>> +    return -ENODEV;
>> +}
>> +
>> +static inline int amd_smn_read(u16 node, u32 address, u32 *value)
>> +{
>> +    return -ENODEV;
>> +}
>> +
>> +#endif
>> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe.h 
>> b/drivers/net/ethernet/amd/xgbe/xgbe.h
>> index dbb1faaf6185..ba45ab0adb8c 100644
>> --- a/drivers/net/ethernet/amd/xgbe/xgbe.h
>> +++ b/drivers/net/ethernet/amd/xgbe/xgbe.h
>> @@ -1061,7 +1061,7 @@ struct xgbe_prv_data {
>>       struct device *dev;
>>       struct platform_device *phy_platdev;
>>       struct device *phy_dev;
>> -    unsigned int xphy_base;
>> +    unsigned int smn_base;
>>       /* Version related data */
>>       struct xgbe_version_data *vdata;

