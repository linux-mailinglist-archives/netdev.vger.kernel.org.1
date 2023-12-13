Return-Path: <netdev+bounces-57024-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD69B8119BA
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 17:42:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11DEEB21076
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 16:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3681D364C2;
	Wed, 13 Dec 2023 16:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RyZ9ELfP"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 698E5D0
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 08:42:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HiAk7dRymXMNXQHR13ml8jvecqhe7TfqXcfhJmRR9gSo5XmhPebJB+SLL6qtdscRVrFlmQyv7zSxktmtVHs8MVs55ZErWzgItLaAipJneMdS98OOBqBiuvQk9wBhowNCNEJuqJfS/KYy6QP2WhfFNrisHw2T2vu9dzd0q/aQ96Yi6jrL9ul9aA1PMhdmE4WuqTIjqKCw6fq05aox7PvU1ofwOlwjary+7Wi3F0jiHzbCPuzRBis58DEQISJfoboPoOytTrF3tKs9Oc69mjpfI4F/RhzktHlPate4RKeflowoNBjPJwOv07nsu+mwu71PkqIOdpv4kaxHv/SV6aWVsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DRyNTstDosNoswrvoJpwF0obR/3AQg590R9oX2HQKh0=;
 b=Lfzft0MAI6XbJQt6XP8pqycPw3BpztXkXC/5V7dAAn4FTtpTQQ1Zi1aLWGxYIazebDxZdj/yKT4EZwgqEpZyOUP7LGSzXhswsSSmc/7+E0YbPbMJJNL+Iugyis8oOFqHe3UhRF2amhBFpoLEnSYyQG31NoMDkOANl8JCLLSdsh5zudMvhK2n043kPj964wKP3OT0qImATlAWv1LASnCPojAIbrJQgR2mu/X8SxerGUTEuFMMz3Njds5CjpimcD6ygpxq7+LHGbiV+75hkaPMOaecGUEwn/rN/TcDXAHhsCZilK+O1Sbn9TKoKWTisfURY2wN3pWfPgCpvXd7kISA/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DRyNTstDosNoswrvoJpwF0obR/3AQg590R9oX2HQKh0=;
 b=RyZ9ELfPdyRD3CrobOdu/3sfbnWb+CkD6FrOg99XKKd2EJMWMNIkkzYfqWzgWmptDzr5aibHQzZtNNm/9MQ87W60hjryaD1g7T8niwS59PPCA25N7sdD2rSwkQchJR4niZMu15XiG6MaZeRXzclk7MReFgPYpC9gE3oCfF2cVsA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by BL1PR12MB5851.namprd12.prod.outlook.com (2603:10b6:208:396::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Wed, 13 Dec
 2023 16:42:10 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::1d68:1eb8:d7dc:4b43]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::1d68:1eb8:d7dc:4b43%6]) with mapi id 15.20.7091.022; Wed, 13 Dec 2023
 16:42:10 +0000
Message-ID: <f23d6b09-0682-4f10-a5a7-1e2c41801429@amd.com>
Date: Wed, 13 Dec 2023 10:42:07 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net-next 2/3] amd-xgbe: add support for Crater ethernet
 device
Content-Language: en-US
To: Raju Rangoju <Raju.Rangoju@amd.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, Shyam-sundar.S-k@amd.com,
 Sudheesh Mavila <sudheesh.mavila@amd.com>
References: <20231212053723.443772-1-Raju.Rangoju@amd.com>
 <20231212053723.443772-3-Raju.Rangoju@amd.com>
 <3067eb09-7277-4fb2-8c79-dcb2d500e15b@amd.com>
 <b60e6487-095f-d4bb-cd6b-ea38bec6c5d6@amd.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
Autocrypt: addr=thomas.lendacky@amd.com; keydata=
 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
 1NhFSLKvfA==
In-Reply-To: <b60e6487-095f-d4bb-cd6b-ea38bec6c5d6@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0167.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::22) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|BL1PR12MB5851:EE_
X-MS-Office365-Filtering-Correlation-Id: d69d38a1-133e-4d7c-6b4a-08dbfbfa7390
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NnbAJLjkJDxMZY+QdyKwxR98RRBOMxEAk2ICg3X6weXpVqCtXDahIAMvGvS/tOeuZHWW53RBoYR9sKvqxWKUh3JpXHK9xcmL58s4nudSI/JRFW4JQ3Yvd9R8rqzW4P9EeCshzDrqSTUBbgLvNPeH4/SzZtvgMcwtay58pSycJZGESrMAMAMuH7Qo/7rbAofMyfUIQQigqQ86/Atc/ZQNAuEAOaHq1mHcCcvL30o0kKHOVK67kdTsK0raV6N3mLO8nPgwA9nW1Nu/rCOhMNsLRVK33M+cSPtTXpO3oYwLYII1bc4jrC3aXkjJLoTujTbBvUaZO9TB6xplb6fpCagz6TfxMnu6C6nDBHBgiECiDy5tJOpeMV5XvKoedhJDJusL58Yas72XXBUywrxjnbl5UhVPSQ1/ffz6TZL/Q8j9wa7CTFDiFhwvvgElyYA9qJObnHtrKv+CqUHspSdLbNG4mcDpdY1BgA4GciqvHFwM1kSjyE61EjVblpjfToTlaNSf1D8oEomnW8RpPD24cQlOkqsRpYEh5vrS1NeHbPP1sdIJI9ABMssvpANhSsLNLwqfoCUY9sBhEGUDHs4xc0eF6egkBJ8U7YwwVbmbnVEEutVWjEvVhyR1JnifogoPX6nbaafZeMU0gGies84ltYbAaw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(396003)(376002)(39860400002)(346002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(66946007)(83380400001)(53546011)(6512007)(2616005)(6506007)(5660300002)(4326008)(41300700001)(8936002)(6486002)(316002)(26005)(478600001)(2906002)(8676002)(6666004)(66476007)(38100700002)(36756003)(86362001)(31696002)(66556008)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZjMrT3A1a2h0a1EwdGt0SHY5RnoxZG9LUHJWcDlZWHJRL3RtVkxhcG9UdGJ1?=
 =?utf-8?B?OHhVeUZUbFNHbTYxR0RNM0tzOWEzQklaT0hjc1E1SjR1MDJQbmtMR1g4QkYy?=
 =?utf-8?B?S04xZGtvU1kyRGJ1UThaV28zeVVsQmhDWTF1bzA1N2dNbWwyWFJKYTZ2MXZF?=
 =?utf-8?B?OERjUXFOTTBUOW1ySXRHSnZ6WmRhZU5FaTR4Vnd6azArS2xmYTlBV0hMeTQ1?=
 =?utf-8?B?RjZYdExHVG53ak10bzVGR2xkVmhqL3I4TEtqSjd5Z3k3T2ZoUmR6MGpaMU8z?=
 =?utf-8?B?alZlZ1UzOG1lMEN4cnpFdEJUOGNqeTQ4RGZTUnZZRUNRRGRidzFTcDVYZml2?=
 =?utf-8?B?VVFwazhCQk5DVC9GR2pIcGI4SUV6NXhhRTFudm5OWU85SUtrSHRiMGRzNUM3?=
 =?utf-8?B?aHc2YmhkMWlwSTNBOW40RzI1TlBvbVptcnlEYUoxd1YrcWRISEpXSk9YOGRH?=
 =?utf-8?B?b3MrTFIvRmVmVGF1c3R6dSthWitDcXhsdTM1MXNWQUQ1bjNYaXVLT1ltalF5?=
 =?utf-8?B?YWd3emVFWUhRT3NaajMxREUwRmdtcDlIVzV6TE84T2srR2dVTXRLTnVYMDJN?=
 =?utf-8?B?VWZuZlF5MFhkeXNYSGFBYTJPaUNJRktiV3dhQ1ptMzc2NzAwM0ZEN1BTTjJ0?=
 =?utf-8?B?YU94Tm1xT3VGODluU3preEpXdkFncHluTnN1UkQ5TzFkWjh1c1RwZEtzWlFX?=
 =?utf-8?B?M1dQRHJ1QlBBd1RKMkRUSjlsM0RMVWpwSGEzT1hmbkxBR1pjVTB1N3N5Skhn?=
 =?utf-8?B?cVpKdnp5V2JPaStsZ2Z4OXNuakFBSGhqTkpkV3FLa2NPZFlmU0dBUHpGeS9R?=
 =?utf-8?B?aFNsMEtnZTh3R0h4RS9YSHN6ZzRlWnpxYllIa20xUklnQ0JUNlZOU05hNHFP?=
 =?utf-8?B?Mm5nbFpnZ2Mrakh6UlYwNXQ0UGxaOUt0WFN1VXJxQ0Z2cjdXUXl4WWcxQTNh?=
 =?utf-8?B?T0wyM0ZvdzFtbWxFUmFBOGFuSXl2WHV6b2UwcytDZlRxM0JodGowaXlTaS9X?=
 =?utf-8?B?MU9vL1lTQlVpZFptanYwaEpVamFCcld5S21IMm1PR1ZVQUYzNGlzUVZseGlh?=
 =?utf-8?B?RCtlNVl4VTZ5UDh3aEVLalU0MEY4TWtld0VxUVZ5RERqcjhFcXhvSWhnZHdP?=
 =?utf-8?B?ZFdVdjJiOWVldUZsSDJvZEJxMWt6NHpUZU1JRlQxckNHME0rbHJhd1J1UnY1?=
 =?utf-8?B?aVd6c3JzYU1GNzUzaU1lVVRpbUJsaTVEcnNxUzVMTFJRVFFJdit5K3V2QmQ1?=
 =?utf-8?B?WGpxdEVRQUF6WUxjQzRKcWFKTGwveGlVanNVeGRkeCtZWDZ0TUp2RnZ4d2Zv?=
 =?utf-8?B?M05sbHNpa09SVXhwQzZZaGhjeHVxWUQ1SHZ1RG5GajJZNzlzcm1KUHdnOExP?=
 =?utf-8?B?OWxCWG4xQTVYUytjWjlLczFaMlhGRkRydlJsOStGMDY4cEM3K3B6VE43ZTlp?=
 =?utf-8?B?Z29NK2dtYStYMGtYU3d0RzQ2NzNvYUIraWNzS0RZNTg3Yy8zamlUSDlEeHF4?=
 =?utf-8?B?VzhRd0MwY2wvUlo2Uk0rdXdDM2JsTGxad1ErK2dLajl2VCtscmxkSFVGaVFZ?=
 =?utf-8?B?amYzaEUwajUvRVdmOEJzNVdaV3FiY1k4THVRZktCSUVTYTFEWEd0UWE2YmtP?=
 =?utf-8?B?K2ZONkVDejZKbVB1ZzVuMmdxdEhmdXJjYmxkRjI0Y1QyeWJmMThQd1drUmJP?=
 =?utf-8?B?S1BWRWZWR3pFWTBoOU5pd1B1YkpsalgxWWc3S3krUDhreHZsd3V2c1k0WVA3?=
 =?utf-8?B?ZEF1OWFsdHBrRzhZL1hOV2tyaXRBakMwbWY2eHhMUW1TOS83RWtNTEJOSkZC?=
 =?utf-8?B?eG8yRG1jZVdBMmw2NU03U21MU3FUbWVua0VFQkwwNGVCSmgrZVZEelRRcmJi?=
 =?utf-8?B?ZStWQk0vY3BDbmdQeEVNMFdjM2pqOXI3Z2hPeFlEWkc1dW5jVHk3SUdCMGxn?=
 =?utf-8?B?QlpXQmpkOXl2cUhRejhkVEw5aERYUlV0ZGl2emdpSU1ueEtyTnRXdmU3NVdj?=
 =?utf-8?B?cTV2VFRua3ZzUXFPNGtqV1BwSXBBY2pTbjNOS3JXYU9tRW02SVdNUHZkdldG?=
 =?utf-8?B?bWwzSG9uZFE5SEo0bnAyRTgxWWdiU2pLdTlWaXlTWmVTaURxWWtDRWsxQkFX?=
 =?utf-8?Q?JGgjr6EiT6JQjLkKtmu7sjlOq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d69d38a1-133e-4d7c-6b4a-08dbfbfa7390
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2023 16:42:10.3583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3IHkyVA8P3uMOSf1N/bp/f9rdjvqgPla2b9hDTmzfpwYjLMYooU8EGN6ZR2jwwmv8HzRIdmSicGSiRZpCBgJdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5851

On 12/13/23 10:25, Raju Rangoju wrote:
> On 12/12/2023 9:02 PM, Tom Lendacky wrote:
>> On 12/11/23 23:37, Raju Rangoju wrote:
>>> Add the necessary support to enable Crater ethernet device. Since the
>>> BAR1 address cannot be used to access the XPCS registers on Crater, use
>>> the pci_{read/write}_config_dword calls. Also, include the new pci device
>>> id 0x1641 to register Crater device with PCIe.
>>>
>>> Co-developed-by: Sudheesh Mavila <sudheesh.mavila@amd.com>
>>> Signed-off-by: Sudheesh Mavila <sudheesh.mavila@amd.com>
>>> Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
>>> ---
>>>   drivers/net/ethernet/amd/xgbe/xgbe-common.h |  5 ++
>>>   drivers/net/ethernet/amd/xgbe/xgbe-dev.c    | 93 +++++++++++++++++++++
>>>   drivers/net/ethernet/amd/xgbe/xgbe-pci.c    | 35 +++++++-
>>>   drivers/net/ethernet/amd/xgbe/xgbe.h        |  6 ++
>>>   4 files changed, 137 insertions(+), 2 deletions(-)
>>>

>>> +
>>> +    spin_lock_irqsave(&pdata->xpcs_lock, flags);
>>> +    pci_write_config_dword(rdev, 0x60, (pdata->xphy_base + 
>>> pdata->xpcs_window_sel_reg));
>>> +    pci_write_config_dword(rdev, 0x64, index);
>>> +    pci_write_config_dword(rdev, 0x60, pdata->xphy_base + offset);
>>> +    pci_read_config_dword(rdev, 0x64, &ctr_mmd_data);
>>> +    if (offset % 4) {
>>> +        ctr_mmd_data = FIELD_PREP(XGBE_GEN_HI_MASK, mmd_data) |
>>> +                   FIELD_GET(XGBE_GEN_LO_MASK, ctr_mmd_data);
>>> +    } else {
>>> +        ctr_mmd_data = FIELD_PREP(XGBE_GEN_HI_MASK,
>>> +                      FIELD_GET(XGBE_GEN_HI_MASK, ctr_mmd_data)) |
>>> +                   FIELD_GET(XGBE_GEN_LO_MASK, mmd_data);
>>> +    }
>>
>> Braces aren't necessary.
>>
>> Also, just curious, what is the "ctr" prefix meant to imply here?
> 
> ctr = crater. Will use the full name instead to avoid confusion.

You should probably make it generic and use pci_ or tmp_ (or smn_ if you 
end up squashing patches 2 and 3), since this may not be "crater" specific 
if this is used by another device ID in the future.

> 
>>
>>

>>> @@ -295,15 +295,28 @@ static int xgbe_pci_probe(struct pci_dev *pdev, 
>>> const struct pci_device_id *id)
>>>           /* Yellow Carp devices do not need rrc */
>>>           pdata->vdata->enable_rrc = 0;
>>>           break;
>>> +    case 0x1630:
>>
>> What PCI ID is this, it doesn't match the 0x1641 added below?
> 
> 0x1630 is root hub

Ah, right, sorry for the noise.

Thanks,
Tom

> 

