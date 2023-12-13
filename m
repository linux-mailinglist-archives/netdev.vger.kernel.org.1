Return-Path: <netdev+bounces-57013-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 56F57811943
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 17:26:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB5B6B20E9C
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 16:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3226633CF1;
	Wed, 13 Dec 2023 16:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FZb0tvyK"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D23591
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 08:25:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NZVv1yV2yJp3eVmWz6fsnizdktqPNVAbqjQoHjMlMPg5MDh9dctuZafn6RfoWsDW0mq82WQU3zB5c2HQt0cW5Z3Sa1SzjpbfWIWY+WAeHtB3I6OW4YGk3hdCC3ibaos1kd+rdYmbVuOIJH4IPara+I1ZxwfxUheJ4sfzd7TPY8NFoY1uJDCSK5ItDb0CydWGzWnSZpdQQMGjo2el3kSTKx1luRXA453uR8P5GdpARbmCfAmlzDLz6oNzDQPMVXlFUJ2cbQlBVX4uIn8wD4BKaktohC4OUIlt7blnHnlVqkZGv6sNT4Pzp1mmAvfpM6I+lXWfSpRrL/+uW4G9yGLldw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fcx31llHaE27PGmLSCwywgmabfL/ZOi6qkUVifmEtF4=;
 b=P6+G+CcI+R1kma/mT2w45OKau+a2RV/JBIvUeDXOXjRbjN5jZ/le4oAh0CUDxG2mBNwmybReC5fYhWoairXCA8OL1KnWW4/r8cDKDMxzTmPoJLf3fw3UBtej6sU0lLzGX9CFY32yg39A+AUA0XYN/Vxjea3IKljQt4jqzGAgqfhETNXaBsDUi2yfBB9BsTgcaeTW3KHT6de+3CjRFx2lY0Rqf4+fuyPIhavWQfyRJXsfU7J9mZRBAw/j528FLH8uKmZjdooc4StKHWApAOMNzYm5M9QNApHg3MP1BadfjU1l6uZ3BvnQUUDRqvX+3Qu1mdBTIvoOj0cVYvXc17YEsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fcx31llHaE27PGmLSCwywgmabfL/ZOi6qkUVifmEtF4=;
 b=FZb0tvyKeESVjsStRJKuooH+Bvozm74MAcpRes/CsHY8iqzb/KVNoAWJlLkMp41yq5m2FPJgtX5TnjsxX4fUOaj4t5t2OBnf7igO8zm0aBa0XF7b6cjvEu8z/3wZlP86Ok1lefhkVliNllM+7d50kNAcBLhRU0KdDEtQGZAX+5w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6395.namprd12.prod.outlook.com (2603:10b6:510:1fd::14)
 by CH0PR12MB5121.namprd12.prod.outlook.com (2603:10b6:610:bc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 16:25:51 +0000
Received: from PH7PR12MB6395.namprd12.prod.outlook.com
 ([fe80::5c36:94b0:958d:5c80]) by PH7PR12MB6395.namprd12.prod.outlook.com
 ([fe80::5c36:94b0:958d:5c80%6]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 16:25:51 +0000
Message-ID: <b60e6487-095f-d4bb-cd6b-ea38bec6c5d6@amd.com>
Date: Wed, 13 Dec 2023 21:55:42 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 net-next 2/3] amd-xgbe: add support for Crater ethernet
 device
Content-Language: en-US
To: Tom Lendacky <thomas.lendacky@amd.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, Shyam-sundar.S-k@amd.com,
 Sudheesh Mavila <sudheesh.mavila@amd.com>
References: <20231212053723.443772-1-Raju.Rangoju@amd.com>
 <20231212053723.443772-3-Raju.Rangoju@amd.com>
 <3067eb09-7277-4fb2-8c79-dcb2d500e15b@amd.com>
From: Raju Rangoju <Raju.Rangoju@amd.com>
In-Reply-To: <3067eb09-7277-4fb2-8c79-dcb2d500e15b@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN3PR01CA0013.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:95::9) To PH7PR12MB6395.namprd12.prod.outlook.com
 (2603:10b6:510:1fd::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6395:EE_|CH0PR12MB5121:EE_
X-MS-Office365-Filtering-Correlation-Id: e7ecfcce-7132-4d0d-fd45-08dbfbf82c2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QYFvMMtaU0tCyBZwAjLVeaG9Plv6+ueNfNU7O9Oq1IUzGq3klkaF+ogxe7SAK60oQ0C0L/WrEIACoxKIvK9lM2ROCSTn08RO4JSAOFHVr6idcGJkOIK0zCaaCvNK0+cPfLeh5VUjxj4REOl3jSGA3ApfNw0fZRCiQU6yUuY+SCt9xFfJDW5/vIFk37tfIUF4Qs5PJ6vNd5tepXkUb0XXgfQf/hEL07luyMYmoN5WSITthvaOg9IkBTAyeXN56pxNx49yn6Bkwen/5jlLr+mlCTN/tB54BCP1sMAxEappJCDkpLncbC8CUw4/Ef7Z3FVTZH4H1UIdpNStPR8uytCvPVg/qwqdXRENQk6j9dmn6CK34c4NGiNOXc1GDUHMvUIeupZ2CSfyBhtjECe8FmhiyHQpksXybEdKR1G5Mrr+jT9g0yZEobi/mfLBe4ubKuWMOt+pTKCfKATENS3n9pgdvEoYzaUylF3RefpWQTf73RvtbE2mDtO7VUSBfNfvwMH6XoHNZnJfiSmKWV0VAky/tKIcnehkNjrPsJk2Q/6dK7EWWhdJtjmI6C631PEe3At+MNbHsU3o989d181HgKsGEN5CIGp3MFOjOS8uaV7wBCKYYaTJOSDlp2qfcXaZ5UPz+Lj7bC1aMhmpbNl+d9tWUw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6395.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(396003)(376002)(39860400002)(346002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(31686004)(66946007)(66556008)(66476007)(31696002)(36756003)(86362001)(38100700002)(83380400001)(2616005)(53546011)(6512007)(26005)(6506007)(6486002)(4326008)(2906002)(316002)(478600001)(6666004)(30864003)(5660300002)(8676002)(8936002)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bkdnSEg3amU1VUUrOGRTTjdjeDlmQk1RODhpaXZDUmw5b1FHd0xjWGhjZXhp?=
 =?utf-8?B?dkppUHI0MkFWWWFuYk04VC81b2RuSWRXYVR6a2g5TEpPWUZEZEUycXpBMXNi?=
 =?utf-8?B?aEhlMDV1Yi9lcUJkeHBWYm12cVJFa09Ea1BJc24weUNaam1wNWVZZ24yazNt?=
 =?utf-8?B?Z0djMkNhUVFVZ2ozWHduYldpUCtGZUpOSld1d3ZUR0dVOGQ3K1hPSUFmQ1ZW?=
 =?utf-8?B?VDJna2UvdU5lMFpSQXZrUzZYMUpCbFZxVHdJeDliY2F6aFkrcXlTQllDdzl3?=
 =?utf-8?B?Q0RtWEYydWpnWVJabVB5Skd5ckNtU1BiWnowa3RYcDNwQ2pZWit2SVZVUFdv?=
 =?utf-8?B?VlMrY01rbXU2eTBVMzNOODFRVEFPeWNnZ3ZLTU9PNjE4aTRrVVRsb01COVNu?=
 =?utf-8?B?TTNDQWpMVXJHWk85ekdKOFdodnNCL0lDZ2NuSHRCak5sVFdySlV4UGFldGpO?=
 =?utf-8?B?YklEUWE0bEQ5TmhzZDVjUEQ1d0VtQlIxeS9IS2lCd0NGNWRnKy9rNlI2S0Rj?=
 =?utf-8?B?YVZnUWF5SFRCNXFaKzI2LzRLTWVFcVFlN2pJUkI2VUh0V0pycENFdXgyQ1py?=
 =?utf-8?B?U2FqQXFHckIydEo3TFdibVc5VER5ZU9jL3ovdFhKaGQ0M2VtSmNXU0tSL0tj?=
 =?utf-8?B?YVduaUQxbVV3S0tkckNObnlaeW5ULzZiNTByaDlUSEl2aXFJaUMxVDRoZ0pa?=
 =?utf-8?B?eU5FTkgwc0ZOR3VtcmgrWEExQW93L3pIdXRCRUdkaUU1TlVwNElIT1BFUzdj?=
 =?utf-8?B?S3g2Q2ZlQ0NtaWFkQTZBZm1MR3poZkVlTm9rUHVUS015cWRGYVZxY2cvSU5E?=
 =?utf-8?B?SjBSY1J6WTE4b3lMSXhHSWtvUGs3ZlJ5VCtsRG9iM3Y5YTZXaDM4NWI5V0V3?=
 =?utf-8?B?bEFDTSs2dTBITmdZSzZaRE4xTHdlb2tQelVyaFgwWGIzY3pKYUZKZXJtdWk1?=
 =?utf-8?B?ZUtpT3F1VU9QeXI0Y1VtNFdwbXFBTUdGVCtTdlBMVFNNQ1hJaWEveXdValhB?=
 =?utf-8?B?a21PWHNFTXhraU9CZDBtY1REZDJtc1JGL1VSem1PSXhKWUNHMlhVWWRVZWZq?=
 =?utf-8?B?NzNIL3ZqSlRJSUVTUU80aEQxWFRkdkh4d0RlU2dpMVJtQWxnSkFjSG56QzdL?=
 =?utf-8?B?aXR0ZGtsck04ZGszMnA1TUtxMXJLb0lMZ0xyTFNvOUk5NEE0bWFtRmRPbG9i?=
 =?utf-8?B?Wk1KY3E3YVUvRkxXSzZZMDhERXIrOUVteHA2WHpxQWkxQ3BUVVRXejVxNHVM?=
 =?utf-8?B?bnNtYjlyWW9lQ2V1MlhMVDFpQllwSU5OMmZ5czRiMnM0bUowandBSUNCTEVv?=
 =?utf-8?B?Tkg1UDVxWkVPc2FUd29YQkM0aXJvZU9IaVErdWV1UVdyZ3NLWTl1VXE5Z0Ft?=
 =?utf-8?B?cm9qV28vRFpOK0J4b25yUThXeEVTYkpzQjdTS0ExUGhySVBReW9MY21mZ2Za?=
 =?utf-8?B?MHFxT21JS3pDa2MvWTRocUdnT2ZuUlYwcE02N2luV1lkOHVncnB2RWJvU29G?=
 =?utf-8?B?dTRDZTRrMnMxOUQxTzBCK1JuZUNhd2NpV2hLOWhZRnFvZFN5WDYvalJsV21W?=
 =?utf-8?B?V3ZCcWJ5Y0pNRXBTS0VJSllnR1g3bW52dGMwOXJUVW95TWE2Nm80UDNpV2di?=
 =?utf-8?B?WmVpUDJpZEVzWVZOMlNmTWJkMkxQRWMxMU5TVzlHRGpyVVlvRk5mMEQwZ3ZT?=
 =?utf-8?B?aHcraEpsdkVpeU40SkM1czRST2ZzdEFDOU5sK0pNWE1VNStQK2M0dnZVQlRu?=
 =?utf-8?B?Vy9sNWFrV2M2QmZzalV3cFNSK0VOWDk1azJMQWdNSTJLNjI0ZzF3OC8yUHhG?=
 =?utf-8?B?Yzl0V29aYkRXbVBBQkMxTDNCc0dDd0FWdE1QUldPb0g0WkhZait4ekZ0NHlM?=
 =?utf-8?B?NGw5UnBZek81eGdpVXhNRUtHamNCVTJmQkFJWU1uTCs4cjBna01MOXB1NWcr?=
 =?utf-8?B?TlpOZzhCVDJGRWZJekEwdkozbHFjS1J1aHFtaC96L2luT2w3bmpMZjZZS3Na?=
 =?utf-8?B?S2szUzk2L0hub1N0cjRXKzJzS0ZOTEt4aUc0eW10WkRGUFE0Qm40TkJVMGVN?=
 =?utf-8?B?SjJTV3FFSUJpN3F3cGRmZ0ZPTXNBVkhZZysybHVnK2JRQTZrV0NtL09QeEpB?=
 =?utf-8?Q?Cx/X1tidiPnJt/8+EgUa6E0wO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7ecfcce-7132-4d0d-fd45-08dbfbf82c2e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6395.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 16:25:51.8394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0+gPdHohvTyEckEhQDgVieyOfBTQUlcFsE1jZeFeaEktbRT43x+o4RvkOmtChUYpi8/0Uw/yg0QyhSu0PxpEWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5121



On 12/12/2023 9:02 PM, Tom Lendacky wrote:
> On 12/11/23 23:37, Raju Rangoju wrote:
>> Add the necessary support to enable Crater ethernet device. Since the
>> BAR1 address cannot be used to access the XPCS registers on Crater, use
>> the pci_{read/write}_config_dword calls. Also, include the new pci device
>> id 0x1641 to register Crater device with PCIe.
>>
>> Co-developed-by: Sudheesh Mavila <sudheesh.mavila@amd.com>
>> Signed-off-by: Sudheesh Mavila <sudheesh.mavila@amd.com>
>> Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
>> ---
>>   drivers/net/ethernet/amd/xgbe/xgbe-common.h |  5 ++
>>   drivers/net/ethernet/amd/xgbe/xgbe-dev.c    | 93 +++++++++++++++++++++
>>   drivers/net/ethernet/amd/xgbe/xgbe-pci.c    | 35 +++++++-
>>   drivers/net/ethernet/amd/xgbe/xgbe.h        |  6 ++
>>   4 files changed, 137 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-common.h 
>> b/drivers/net/ethernet/amd/xgbe/xgbe-common.h
>> index 3b70f6737633..e1f70f0528ef 100644
>> --- a/drivers/net/ethernet/amd/xgbe/xgbe-common.h
>> +++ b/drivers/net/ethernet/amd/xgbe/xgbe-common.h
>> @@ -900,6 +900,11 @@
>>   #define PCS_V2_RV_WINDOW_SELECT        0x1064
>>   #define PCS_V2_YC_WINDOW_DEF        0x18060
>>   #define PCS_V2_YC_WINDOW_SELECT        0x18064
>> +#define PCS_V2_RN_WINDOW_DEF        0xF8078
>> +#define PCS_V2_RN_WINDOW_SELECT        0xF807c
> 
> Should this be PCS_V3_ (here and below) ??

Yes, it should be PCS_V3. I'll take care of it in next version.

> 
>> +
>> +#define PCS_RN_SMN_BASE_ADDR        0x11E00000
>> +#define PCS_RN_PORT_ADDR_SIZE        0x100000
> 
> All hex characters should be consistent and in lower case.

Sure

> 
>>   /* PCS register entry bit positions and sizes */
>>   #define PCS_V2_WINDOW_DEF_OFFSET_INDEX    6
>> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c 
>> b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
>> index 6cd003c24a64..a9eb2ffa9f73 100644
>> --- a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
>> +++ b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
>> @@ -120,6 +120,7 @@
>>   #include <linux/bitrev.h>
>>   #include <linux/crc32.h>
>>   #include <linux/crc32poly.h>
>> +#include <linux/pci.h>
>>   #include "xgbe.h"
>>   #include "xgbe-common.h"
>> @@ -1165,6 +1166,92 @@ static unsigned int get_index_offset(struct 
>> xgbe_prv_data *pdata, unsigned int m
>>       return pdata->xpcs_window + (mmd_address & 
>> pdata->xpcs_window_mask);
>>   }
>> +static int xgbe_read_mmd_regs_v3(struct xgbe_prv_data *pdata, int prtad,
>> +                 int mmd_reg)
>> +{
>> +    unsigned int mmd_address, index, offset;
>> +    struct pci_dev *rdev;
>> +    unsigned long flags;
>> +    int mmd_data;
>> +
>> +    rdev = pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(0, 0));
>> +    if (!rdev)
>> +        return 0;
>> +
>> +    mmd_address = get_mmd_address(pdata, mmd_reg);
>> +
>> +    /* The PCS registers are accessed using mmio. The underlying
>> +     * management interface uses indirect addressing to access the MMD
>> +     * register sets. This requires accessing of the PCS register in two
>> +     * phases, an address phase and a data phase.
>> +     *
>> +     * The mmio interface is based on 16-bit offsets and values. All
>> +     * register offsets must therefore be adjusted by left shifting the
>> +     * offset 1 bit and reading 16 bits of data.
>> +     */
>> +    offset = get_index_offset(pdata, mmd_address, &index);
>> +
>> +    spin_lock_irqsave(&pdata->xpcs_lock, flags);
>> +    pci_write_config_dword(rdev, 0x60, (pdata->xphy_base + 
>> pdata->xpcs_window_sel_reg));
>> +    pci_write_config_dword(rdev, 0x64, index);
>> +    pci_write_config_dword(rdev, 0x60, pdata->xphy_base + offset);
>> +    pci_read_config_dword(rdev, 0x64, &mmd_data);
>> +    mmd_data = (offset % 4) ? FIELD_GET(XGBE_GEN_HI_MASK, mmd_data) :
>> +                  FIELD_GET(XGBE_GEN_LO_MASK, mmd_data);
>> +    pci_dev_put(rdev);
>> +
>> +    spin_unlock_irqrestore(&pdata->xpcs_lock, flags);
>> +
>> +    return mmd_data;
>> +}
>> +
>> +static void xgbe_write_mmd_regs_v3(struct xgbe_prv_data *pdata, int 
>> prtad,
>> +                   int mmd_reg, int mmd_data)
>> +{
>> +    unsigned int mmd_address, index, offset, ctr_mmd_data;
>> +    struct pci_dev *rdev;
>> +    unsigned long flags;
>> +
>> +    rdev = pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(0, 0));
>> +    if (!rdev)
>> +        return;
>> +
>> +    mmd_address = get_mmd_address(pdata, mmd_reg);
>> +
>> +    /* The PCS registers are accessed using mmio. The underlying
>> +     * management interface uses indirect addressing to access the MMD
>> +     * register sets. This requires accessing of the PCS register in two
>> +     * phases, an address phase and a data phase.
>> +     *
>> +     * The mmio interface is based on 16-bit offsets and values. All
>> +     * register offsets must therefore be adjusted by left shifting the
>> +     * offset 1 bit and writing 16 bits of data.
>> +     */
>> +    offset = get_index_offset(pdata, mmd_address, &index);
>> +
>> +    spin_lock_irqsave(&pdata->xpcs_lock, flags);
>> +    pci_write_config_dword(rdev, 0x60, (pdata->xphy_base + 
>> pdata->xpcs_window_sel_reg));
>> +    pci_write_config_dword(rdev, 0x64, index);
>> +    pci_write_config_dword(rdev, 0x60, pdata->xphy_base + offset);
>> +    pci_read_config_dword(rdev, 0x64, &ctr_mmd_data);
>> +    if (offset % 4) {
>> +        ctr_mmd_data = FIELD_PREP(XGBE_GEN_HI_MASK, mmd_data) |
>> +                   FIELD_GET(XGBE_GEN_LO_MASK, ctr_mmd_data);
>> +    } else {
>> +        ctr_mmd_data = FIELD_PREP(XGBE_GEN_HI_MASK,
>> +                      FIELD_GET(XGBE_GEN_HI_MASK, ctr_mmd_data)) |
>> +                   FIELD_GET(XGBE_GEN_LO_MASK, mmd_data);
>> +    }
> 
> Braces aren't necessary.
> 
> Also, just curious, what is the "ctr" prefix meant to imply here?

ctr = crater. Will use the full name instead to avoid confusion.

> 
> 
>> +
>> +    pci_write_config_dword(rdev, 0x60, (pdata->xphy_base + 
>> pdata->xpcs_window_sel_reg));
>> +    pci_write_config_dword(rdev, 0x64, index);
>> +    pci_write_config_dword(rdev, 0x60, (pdata->xphy_base + offset));
>> +    pci_write_config_dword(rdev, 0x64, ctr_mmd_data);
>> +    pci_dev_put(rdev);
>> +
>> +    spin_unlock_irqrestore(&pdata->xpcs_lock, flags);
>> +}
>> +
>>   static int xgbe_read_mmd_regs_v2(struct xgbe_prv_data *pdata, int 
>> prtad,
>>                    int mmd_reg)
>>   {
>> @@ -1274,6 +1361,9 @@ static int xgbe_read_mmd_regs(struct 
>> xgbe_prv_data *pdata, int prtad,
>>       case XGBE_XPCS_ACCESS_V1:
>>           return xgbe_read_mmd_regs_v1(pdata, prtad, mmd_reg);
>> +    case XGBE_XPCS_ACCESS_V3:
>> +        return xgbe_read_mmd_regs_v3(pdata, prtad, mmd_reg);
>> +
>>       case XGBE_XPCS_ACCESS_V2:
>>       default:
>>           return xgbe_read_mmd_regs_v2(pdata, prtad, mmd_reg);
>> @@ -1287,6 +1377,9 @@ static void xgbe_write_mmd_regs(struct 
>> xgbe_prv_data *pdata, int prtad,
>>       case XGBE_XPCS_ACCESS_V1:
>>           return xgbe_write_mmd_regs_v1(pdata, prtad, mmd_reg, mmd_data);
>> +    case XGBE_XPCS_ACCESS_V3:
>> +        return xgbe_write_mmd_regs_v3(pdata, prtad, mmd_reg, mmd_data);
>> +
>>       case XGBE_XPCS_ACCESS_V2:
>>       default:
>>           return xgbe_write_mmd_regs_v2(pdata, prtad, mmd_reg, mmd_data);
>> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-pci.c 
>> b/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
>> index 8b0c1e450b7e..db3e8aac3339 100644
>> --- a/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
>> +++ b/drivers/net/ethernet/amd/xgbe/xgbe-pci.c
>> @@ -295,15 +295,28 @@ static int xgbe_pci_probe(struct pci_dev *pdev, 
>> const struct pci_device_id *id)
>>           /* Yellow Carp devices do not need rrc */
>>           pdata->vdata->enable_rrc = 0;
>>           break;
>> +    case 0x1630:
> 
> What PCI ID is this, it doesn't match the 0x1641 added below?

0x1630 is root hub

> 
> Thanks,
> Tom
> 
>> +        pdata->xpcs_window_def_reg = PCS_V2_RN_WINDOW_DEF;
>> +        pdata->xpcs_window_sel_reg = PCS_V2_RN_WINDOW_SELECT;
>> +        break;
>>       default:
>>           pdata->xpcs_window_def_reg = PCS_V2_WINDOW_DEF;
>>           pdata->xpcs_window_sel_reg = PCS_V2_WINDOW_SELECT;
>>           break;
>>       }
>> -    pci_dev_put(rdev);
>>       /* Configure the PCS indirect addressing support */
>> -    reg = XPCS32_IOREAD(pdata, pdata->xpcs_window_def_reg);
>> +    if (pdata->vdata->xpcs_access == XGBE_XPCS_ACCESS_V3) {
>> +        reg = XP_IOREAD(pdata, XP_PROP_0);
>> +        pdata->xphy_base = PCS_RN_SMN_BASE_ADDR +
>> +                   (PCS_RN_PORT_ADDR_SIZE * XP_GET_BITS(reg, 
>> XP_PROP_0, PORT_ID));
>> +        pci_write_config_dword(rdev, 0x60, pdata->xphy_base + 
>> (pdata->xpcs_window_def_reg));
>> +        pci_read_config_dword(rdev, 0x64, &reg);
>> +    } else {
>> +        reg = XPCS32_IOREAD(pdata, pdata->xpcs_window_def_reg);
>> +    }
>> +    pci_dev_put(rdev);
>> +
>>       pdata->xpcs_window = XPCS_GET_BITS(reg, PCS_V2_WINDOW_DEF, OFFSET);
>>       pdata->xpcs_window <<= 6;
>>       pdata->xpcs_window_size = XPCS_GET_BITS(reg, PCS_V2_WINDOW_DEF, 
>> SIZE);
>> @@ -481,6 +494,22 @@ static int __maybe_unused xgbe_pci_resume(struct 
>> device *dev)
>>       return ret;
>>   }
>> +static struct xgbe_version_data xgbe_v3 = {
>> +    .init_function_ptrs_phy_impl    = xgbe_init_function_ptrs_phy_v2,
>> +    .xpcs_access            = XGBE_XPCS_ACCESS_V3,
>> +    .mmc_64bit            = 1,
>> +    .tx_max_fifo_size        = 65536,
>> +    .rx_max_fifo_size        = 65536,
>> +    .tx_tstamp_workaround        = 1,
>> +    .ecc_support            = 1,
>> +    .i2c_support            = 1,
>> +    .irq_reissue_support        = 1,
>> +    .tx_desc_prefetch        = 5,
>> +    .rx_desc_prefetch        = 5,
>> +    .an_cdr_workaround        = 0,
>> +    .enable_rrc            = 0,
>> +};
>> +
>>   static struct xgbe_version_data xgbe_v2a = {
>>       .init_function_ptrs_phy_impl    = xgbe_init_function_ptrs_phy_v2,
>>       .xpcs_access            = XGBE_XPCS_ACCESS_V2,
>> @@ -518,6 +547,8 @@ static const struct pci_device_id xgbe_pci_table[] 
>> = {
>>         .driver_data = (kernel_ulong_t)&xgbe_v2a },
>>       { PCI_VDEVICE(AMD, 0x1459),
>>         .driver_data = (kernel_ulong_t)&xgbe_v2b },
>> +    { PCI_VDEVICE(AMD, 0x1641),
>> +      .driver_data = (kernel_ulong_t)&xgbe_v3 },
>>       /* Last entry must be zero */
>>       { 0, }
>>   };
>> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe.h 
>> b/drivers/net/ethernet/amd/xgbe/xgbe.h
>> index ad136ed493ed..dbb1faaf6185 100644
>> --- a/drivers/net/ethernet/amd/xgbe/xgbe.h
>> +++ b/drivers/net/ethernet/amd/xgbe/xgbe.h
>> @@ -347,6 +347,10 @@
>>               (_src)->link_modes._sname,        \
>>               __ETHTOOL_LINK_MODE_MASK_NBITS)
>> +/* Generic low and high masks */
>> +#define XGBE_GEN_HI_MASK    GENMASK(31, 16)
>> +#define XGBE_GEN_LO_MASK    GENMASK(15, 0)
>> +
>>   struct xgbe_prv_data;
>>   struct xgbe_packet_data {
>> @@ -565,6 +569,7 @@ enum xgbe_speed {
>>   enum xgbe_xpcs_access {
>>       XGBE_XPCS_ACCESS_V1 = 0,
>>       XGBE_XPCS_ACCESS_V2,
>> +    XGBE_XPCS_ACCESS_V3,
>>   };
>>   enum xgbe_an_mode {
>> @@ -1056,6 +1061,7 @@ struct xgbe_prv_data {
>>       struct device *dev;
>>       struct platform_device *phy_platdev;
>>       struct device *phy_dev;
>> +    unsigned int xphy_base;
>>       /* Version related data */
>>       struct xgbe_version_data *vdata;

