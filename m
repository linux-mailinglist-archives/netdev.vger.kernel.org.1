Return-Path: <netdev+bounces-57022-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB66A8119AB
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 17:37:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DF471F2169E
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 16:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17DBB35F10;
	Wed, 13 Dec 2023 16:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WfBPPeFb"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2DE9AC
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 08:37:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jtqGUboPBS4Dz09aCvmDWGAXNix6YCxYnv1V+IP2bLzhBmckN8/JOJk8ZjKvE2iCTwQXtLbCTDEar2azn9r6V7fsP66YV4X5LxBx0SknEA1kJ09Ike6hW3g22UQv2/cf5wd8Al+TsDYoGRfoV3xpvYdsWaAoQWvLh8VU1M7DJHWckctMok2v+PCbFV4mb7RdHw09UPxpa2aAWDoz7Ix1o+Ll8/Epsuyg47X9eVS3zPTzZLu54EDTDnY2En5sbUyCKwOrCXs9XZZxB6rQjC1bqjrO68VGDm1Eq4c4iU/cEC8H1yUb1NPy+1+uPYUcFTl8kLQQpRuGm+eppn8otnYM4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E2teMCC3Qg1un9W7EwCNLtU1a3dwpVFdX2OgyvSxgB8=;
 b=TfguBikvW88SNlKYqILAttOioF6/2rZABc0f46DbEdjbb/3s9UIpBE2EpneFqFK/WJOOYvHUynMDvR3XEtPUpjiMxVtBzQmIV/8ZfTOf7KQE7mQnvHOA/GjXzvwBiBwJOBQLkHuOmi9g7V1psAf+WdF+L0EnRuwrnuAdjSCX/ajywF/7eV8FwMwqEVWYben009NOW6MKN86CU+uuTlQN/24iiRYVEjlxce9AjoWmoFfc85Fv9LeJ8BO6AwVhlu41rtO41srENCg5gI4/A4cFmLFy+vFWEtxHxIp/J8A2vW84vjouc8tl5Yzt64ebTuj7+6BAYGqwKTiUPYwU0mMqGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E2teMCC3Qg1un9W7EwCNLtU1a3dwpVFdX2OgyvSxgB8=;
 b=WfBPPeFbgx7fibtIXlJXykDyMLQsSh2JP0B2BIv+KR1N2b/mE5z6Ja8sY2Y+tu9KYemk5+w0yqk7a6grj5bCJwTNPHaiA3y5Zj+Dy7WDPekQ0SHWwse7zZH9xNjmchdgB/MiLS0yiyTdU9fXfQAFQs5Qx2JXPWMcs5JDLalCfDE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by BL1PR12MB5334.namprd12.prod.outlook.com (2603:10b6:208:31d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Wed, 13 Dec
 2023 16:37:43 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::1d68:1eb8:d7dc:4b43]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::1d68:1eb8:d7dc:4b43%6]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 16:37:43 +0000
Message-ID: <2ba8b168-627c-48f6-ac63-e83ab8056864@amd.com>
Date: Wed, 13 Dec 2023 10:37:40 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net-next 1/3] amd-xgbe: reorganize the code of XPCS
 access
To: Raju Rangoju <Raju.Rangoju@amd.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, Shyam-sundar.S-k@amd.com
References: <20231212053723.443772-1-Raju.Rangoju@amd.com>
 <20231212053723.443772-2-Raju.Rangoju@amd.com>
 <0dca661a-26d6-425c-a3c3-1b4ae94b3b47@amd.com>
 <4d8ff5ad-b234-1c91-3119-f22b5bb32aa9@amd.com>
Content-Language: en-US
From: Tom Lendacky <thomas.lendacky@amd.com>
Autocrypt: addr=thomas.lendacky@amd.com; keydata=
 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
 1NhFSLKvfA==
In-Reply-To: <4d8ff5ad-b234-1c91-3119-f22b5bb32aa9@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA1P222CA0020.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:22c::21) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|BL1PR12MB5334:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f504fff-b6ff-426a-0526-08dbfbf9d413
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KB0qO//Ynx9G+VHx3MP6e+pQjhs2Lcl9XqiEEiwxFpb7JjHLyiIpq/5zMFx9AsWEW8dHxlh3o3viRR/fsf8L/YPq6XPqjzRvYq4tZ5a49bDeLdvWwHHJr8p2xgyLjN/MJ+9keWUvLRQf5XsoUSm4YOnqAS/YZDaDaOc6sJy1s242iQ+CMBSocwR0SZ0jLsXCnqPUwNV+b8e2JzhfKfW2zprzxTq592+cPJMX6PnM/Wn9x/GEmKdmNdIB/L0Q7Qr12MIQCNKOTELXKc+7eJgTlAxPz7mkSAlfojnoRrYOKH+CPshgRik7pdmOw0dX5Z2+/YzdKAJq+swLGsF6oASoCAgnjq/27HyJ60Mj/RGUDD2/HvruKt+wBRk7OlWQk+JMW+PQfmgmbq1KM2UPOrbGEcW/hmiPowwxWCxL4Xd00eVS9ygOKZOiV9WIvUUXrUHyOUk0aicQuKrMwlmvSDZ2zTb4dNwVaLrt8ccwMENf1YK1oN1BSiuObVHNbmSpbUeAvxsrNXTzAWd/4JDMAwhctenVsN80sbC/Q5chLn1Xe4Ky1qO2UzZC/3a9fF6CQAmsGyr514DQjoVblL6Sdal+5rch69IBuofA8aBbeLym+CTZ54AcQBDTCek4PGqH3vSU0btpAYkGF110pQJeS8WW1g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(136003)(346002)(376002)(396003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(2616005)(26005)(6506007)(6512007)(53546011)(83380400001)(5660300002)(4326008)(8676002)(8936002)(41300700001)(2906002)(6486002)(478600001)(316002)(66946007)(66556008)(66476007)(86362001)(31696002)(38100700002)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Uk9PdThDTFdvQS9OL3N4d1dmYTBzeXpLdVV6T2JYQ0V5UXJIVjE3OE1wdExa?=
 =?utf-8?B?OXdiQXhLU2w2ak0xS0dVTWZJUTNzbmVSWElsMUMvK05DS0VMZWhsUkl4OENG?=
 =?utf-8?B?eUU5c3RyNkNPeVJobzNpbHEraW8rWHhCcDJURTBDV3MyUDBkUTB2U05ld3Q1?=
 =?utf-8?B?NG9HUi9YeDJHUlhMblBxOXhjcVhSRXdlS1hDWW5paEtVL1VzTHplUWhNQUlS?=
 =?utf-8?B?cTYzUnF2bVlrYzByZWw2ZVJpczR3NHVORmpKWkxiV0FKTEJjSTFDeGZnb3Av?=
 =?utf-8?B?UWdhaHhTOEx0TFNHeTE5YnNnTEtUYTJlYnpUN1M2Y3hjc0k1cFdwcG93L0Vo?=
 =?utf-8?B?RTFRK1dFdWZSSU5sZTh0dmN1MCtvRnJoUUlXeTRHTjdFY2l6UkE3cDJJajJ3?=
 =?utf-8?B?MFh6UGJtajF3NnM0amVLQllQOGxYeTUzVC9qSll5cjdpK2d2ejFvMVZwVU10?=
 =?utf-8?B?NTBlY0ZlaDlyYUd0b1VuRFhtWm9JTkV0Nlo1TlBRa25sL2dualFEcVdIZWZu?=
 =?utf-8?B?WEJ3UHRlWWNKNEcxd25VNWFpNHRDTE1TMW5uWEp6Y1hJUUpSa3B4YStCY3hE?=
 =?utf-8?B?YzhLWnk5cXlybGZySXRwbkR0dG4yNXJxcEE2TWQxb1dISDFTakdYd2NpekdK?=
 =?utf-8?B?ZUlmWjJXOTAwd3RtOThuenFCNzRrMVZqeDRGblVvbEd5ZFlQeTZqU2ljMWg5?=
 =?utf-8?B?YkROUVRzczZUOWh1VzlMcHROeGVMYzRzWWt2WGFXVVg4V0llTERETTdtS0hG?=
 =?utf-8?B?cy9EU2s5a2RhQk0yUktrN2liYm5ZWkNiZU1vVHlmZjZRSVBCZVltU1NrcXAy?=
 =?utf-8?B?T1N2d2x4Z0E0eWZJb2lOczRRWHA5RC9UZWNXcktybi9pL1BDaG5hWGNVQXZI?=
 =?utf-8?B?Q3hEYzBOTW85Zkp4YlNSV3kzenByeTU4UlVyL1BxWXZIQ1VUb083YUVUMGpH?=
 =?utf-8?B?VnZxV3E0UFlOK1dTaXFBMVhZVHI0U00zRkRPaEw5T2NlTnBiMExBR3Z5ZXQr?=
 =?utf-8?B?ei9SK2JFZlk2NWFJdkl0YzRhbnBVM3J0M1RMd21UY25TY1BKdXhzSFloMytk?=
 =?utf-8?B?WnVtVEppNXNGNXFJWlZUS3lpcVI4WnNaQlE2eitSU3Nya1Jqd0FDKzFhOUJ5?=
 =?utf-8?B?U2IrNURtSjBwTkZHQnYydkp1QlZubTZSdEFOOS9xa240ZHMrS0htU2p4VnUr?=
 =?utf-8?B?TFdkZlBIc2xwc1ZFcVY4QnRHem4yNkRCUlBoNlg1TWdaV2xMZVM1N2VLc0Ns?=
 =?utf-8?B?eGg2YjBTdmJGZnVjVVhHc0l6UWJKZWVuWnJSbWhlakdWUCs2ZmlNUFRGcHFs?=
 =?utf-8?B?cUd1b1NSM1VvOHltQTdSQ1lOK25XajdPb0p1N0k1S0dCSVZSMmtiNWdldHdT?=
 =?utf-8?B?SWZxNGJUVVlaQnNVY2JGenNQVE9PYVFUYVpxdWpVbkdHMVVNTWllRGllRUU3?=
 =?utf-8?B?Mk1NWVoyY3M2eVc3d0JWNVNVek9Teit1bVZFRzcweFJDaDRyTmp0Uklqejla?=
 =?utf-8?B?ZmtRRldWcXZmMTdFYndKT0NZMUZBSWo2ak9tT0Nwb2Q5RnNGR2xXNExKbnNE?=
 =?utf-8?B?VC9BNzd0V1ZFdU0zUHdreXFXaCtXK0RmT2pTdzhMWTdNUXNJMHBSNGR4RzN1?=
 =?utf-8?B?QTZjYkF3U3llanBVcmdIWkJKUlJ4Q3R1U0oyTUZ2WmZENEJlSDhUaWtzT1B5?=
 =?utf-8?B?R05CM2NjQU1qTHA3TGhBazhuekF1amlPWmd2d21wWnlVQjdXNUxpSWtla01y?=
 =?utf-8?B?a2NQd1djWElSNEM3eW14OW9zdXNxTkFCYUQxc2p0dG1KOHgySWkzeFlueFU2?=
 =?utf-8?B?WnEzNHZDWTR5ck52cDJBVjBFRUE5eTZKVEpPQnRpSmo1bGpGV2phNDRiWW5k?=
 =?utf-8?B?SFBwMTZ2YkNKODA4bFBwSjI1L1Z4QW5qUFNnaWpHV3RZbGM3UHAxK3ZtMWl3?=
 =?utf-8?B?Yjc5L1V0SmVCbkZiYVNveXpVZ2lxNjBIcDA4bzJjb3BjMDBWYVlvNjZOTEpI?=
 =?utf-8?B?UlRrMXdLNSt4UkxCY0hrQTl2YVhxM3dQZFEwNW0xNTl6RmI2dVltSWFxS0Zp?=
 =?utf-8?B?MkFTdEYvNUlWOWtCV0xFblFoVnphdUhKYnErY3YwZVhwUTB5NjJGcFFIY2Vj?=
 =?utf-8?Q?LOI24Gd3aMw42QGWjjxjiTAEy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f504fff-b6ff-426a-0526-08dbfbf9d413
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 16:37:43.4825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G56F94HDEKX5h1967t/FFz8E+IZlOyl1LIo364yOSlP40ByVxlZP646YNYE9COrPZuyAlDlhPyFp2i3nLaxSww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5334

On 12/13/23 09:35, Raju Rangoju wrote:
> On 12/12/2023 8:03 PM, Tom Lendacky wrote:
>> On 12/11/23 23:37, Raju Rangoju wrote:
>>> The xgbe_{read/write}_mmd_regs_v* functions have common code which can
>>> be moved to helper functions. Also, the xgbe_pci_probe() needs
>>> reorganization.
>>>
>>> Add new helper functions to calculate the mmd_address for v1/v2 of xpcs
>>> access. And, convert if/else statements in xgbe_pci_probe() to switch
>>> case. This helps code look cleaner.
>>>
>>> Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
>>> ---
>>>   drivers/net/ethernet/amd/xgbe/xgbe-dev.c | 43 ++++++++++++------------
>>>   drivers/net/ethernet/amd/xgbe/xgbe-pci.c | 18 +++++++---
>>>   2 files changed, 34 insertions(+), 27 deletions(-)
>>>

>>> @@ -274,12 +274,18 @@ static int xgbe_pci_probe(struct pci_dev *pdev, 
>>> const struct pci_device_id *id)
>>>       /* Set the PCS indirect addressing definition registers */
>>>       rdev = pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(0, 0));
>>> -    if (rdev &&
>>> -        (rdev->vendor == PCI_VENDOR_ID_AMD) && (rdev->device == 
>>> 0x15d0)) {
>>> +
>>> +    if (!(rdev && rdev->vendor == PCI_VENDOR_ID_AMD)) {
>>> +        ret = -ENODEV;
>>> +        goto err_pci_enable;
>>> +    }
>>
>> This is different behavior compared to today. Today, everything would
>> default to the final "else" statement. With this patch you have a
>> possibility of failing probe now.
> 
> This was done to skip the cases where rdev is NULL or vendor != AMD. Not 
> sure if I'm missing something.

Right, I'm just pointing out that if rdev == NULL or vendor != AMD then, 
today, the else path is taken. With this patch you'll fail the probe with 
-ENODEV.

Thanks,
Tom

> 

