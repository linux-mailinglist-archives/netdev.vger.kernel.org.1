Return-Path: <netdev+bounces-226216-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31417B9E234
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 10:53:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 365961BC3A9F
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 08:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4490F279351;
	Thu, 25 Sep 2025 08:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bvkXrcGa"
X-Original-To: netdev@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012063.outbound.protection.outlook.com [40.107.209.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1317227877D;
	Thu, 25 Sep 2025 08:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758790392; cv=fail; b=COdk3kSQyMdh+SJa0nqNTpL4eRH75i3zCh4EIugXpl3JQVI/aEq8v5qmgR9dfMBstjzr16kEFmImYo0NZP3lM7Q0zSw/kR7WoG3wIsp0CiUIsbOFtYQxO1Hf0wTpDplH4Y/aGrjKVzz9BAQLu8TmGOqX1eKoleoB0yO+rxkqyAo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758790392; c=relaxed/simple;
	bh=Xwd4bAmzkSevvQDIJbZrw1vpPMpSnJs780UAUfEVCFU=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Z55ZEIW8WeQnrSwRVU+pEsdgbVo6+NY/J9RBYoBjE3Ppb4CNVJprPQPrQAElz76KBGHBqfiW4uN7xsAbhDcoDjgFY97KQoED8OanQ/SJdVM2zE+ZQ+Ov3SJRbV+LMMqeuNfNE0NpDE3UcrrargCbMvsnj4+9XiCLsZLRKaR5Bvw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bvkXrcGa; arc=fail smtp.client-ip=40.107.209.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cQKU1vl6cseSaXIkdVw++Ur/Mrl1oRt5+rrvzybVFAOk7LJhdEYqML0cWtD7YCc0hMhQmQiE3dVmNJnArIJn/SeuyxE2BSqz+T+kPv9vRVnH1YxkZGrrGYdtFOKpdTvZggn1AWpLdbiz0jfh1QDWe9YByMfhYweRtB1tYDDDz7mRXL5yiMv706F74KD/Jkinjk3nenkENgZWZnbtC2VHtce20FG1gKj4L4qlLlrIRV+WTo5j4skbdAjXCzxm4jchggdsu5eeUEXgTB/NSayymBGhd/JxOMWtX5fHHyNP+UdphI1EA04+fWQfi/fmB6PQDKGD+5Yu89OOcn3MObbw4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nW2HEYTkW+dU/kMZDghBfZ4Z8JU4hohzxGxtFYDVqwQ=;
 b=SpdNUF5F+292kU4y0fMO+OaJ7ZNNwvxG0zyuReRDCRM6BCkFnqh1uZvwqyEXaqXPgvOQWsFGXcEdf+pxCustxHJMB5KjqcEI6KyrMw8FSVir1MBWkPjzaVhZiaCPw2a48L/s6Zl2grmsQoHELLMcn3p/mr7CHoHgj/PCam3SA50+x4ICIdB8T7xBbAlCrQZ/NR9S+k2XMeaBSXUs/DgbOWOKLMvYX8Co532/mEDfY5/qeww3q4BCnRhDra0qMzyMESUNzzZoQSA7Hm0xsvxalPi45k0fCJn8Ns2bRFtBJN4/1z8ZhHlefTsOnPeYtpeFxV5YtsD3TBpGb33VENF9tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nW2HEYTkW+dU/kMZDghBfZ4Z8JU4hohzxGxtFYDVqwQ=;
 b=bvkXrcGaMlhpdg6uYDTmJO/cw5/0+K56Pwb/iKFOhafdMxBvi9Qk0a9m7NLJ8UQGiEDvkJjtlr2zOcPXh47FaNmqEPFMPk1O2Ef/dc14mmI8Oa6o2FRsk97/5KwlPjl2t5LBnbYiFoCLr4g93nxGT93093Yna+Q4Sp9az2LwnLw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by PH7PR12MB8107.namprd12.prod.outlook.com (2603:10b6:510:2bb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Thu, 25 Sep
 2025 08:53:05 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.9137.018; Thu, 25 Sep 2025
 08:53:05 +0000
Message-ID: <e2f05d8c-74a9-4b43-878b-20743a6cbd34@amd.com>
Date: Thu, 25 Sep 2025 09:53:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 04/20] cxl: allow Type2 drivers to map cxl component
 regs
Content-Language: en-US
From: Alejandro Lucero Palau <alucerop@amd.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
References: <20250918091746.2034285-1-alejandro.lucero-palau@amd.com>
 <20250918091746.2034285-5-alejandro.lucero-palau@amd.com>
 <20250918120348.000028a5@huawei.com>
 <765f9f24-cb26-4eb6-9a44-b215c5ca2a6c@amd.com>
In-Reply-To: <765f9f24-cb26-4eb6-9a44-b215c5ca2a6c@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0020.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ae::16) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|PH7PR12MB8107:EE_
X-MS-Office365-Filtering-Correlation-Id: 77fe50fe-f589-46c3-68be-08ddfc10f0ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cG1FWkZrOFgxM1p3WndPY3Z3eVdaZlZ4bU5TaktsTXRmZmRDTHNXMVVqYkJk?=
 =?utf-8?B?R21IYms1M1ZQM0FrTnpyK3QvYUp2V2xwc2o4elQ0WE96c3BsLy9pUXFzTDV5?=
 =?utf-8?B?aHRJRlRTMHBqYUdxbmVIR1lFWlZ2SDRsNFJUNVI2VGdGbXFVS3dnNzJDWklN?=
 =?utf-8?B?Y0QxSHdMNDl1WVJNTVphR3kwZzlYbVozRVVWNmcraERRQS9xRGpBYW15UnFv?=
 =?utf-8?B?WlJ1Z0JXa0FqSGJibUhYdW5iM1lCUFU0QlVyd0V1K3Vkc28zYWxzN2VUM2pE?=
 =?utf-8?B?WkZaT1FHMHEvdExkSmp4S281eW5TQUVjNDJxUUU3c0ZieXRDaTVoeXNxbExZ?=
 =?utf-8?B?UnRmZkhUUzk2ZU0vV3FDQVBXU3JTbUhiakFveUVlUy9CenpMUXhSZ0duL0Zj?=
 =?utf-8?B?U1oxeEdRc3lBcmwwNWhPWFFuSDZHSjU4MUoycktEdlhBa0dQSmJpa1JULy83?=
 =?utf-8?B?ZzhsNi9sRXdJMHRTR3dmT2RtdDBYTHlnek9uQ3QwTGZ2LzNESXIzYXZZNjEr?=
 =?utf-8?B?cnJCM0s5b1E1bDFKV3lhTUJUcFJSTWQybm11bDhXVE9iVll4UEpUVXlodDFu?=
 =?utf-8?B?TVMyZ0NkWGNQM083d2VINC8vKzFRb1RyaEpaZWpPOEdhRUNPTkkzTWpSL1ZM?=
 =?utf-8?B?Wk9Vd0tWbFJsNVBSYi9IUSsrcWQyQk5TcUdpWE8zRGJMSjJBMk5ZcjlWSVFn?=
 =?utf-8?B?a05iRmJlNVdodXY2WWdIM2ZJUzVTQVIrZHBMQVN4U0h3Uks3V01mT2VKUjlo?=
 =?utf-8?B?NjFQL1NVRHIrMENpaGdaWjhGVUpRcVpqN1VRNUYrTHo3QkRKVGJqcWdZQzgy?=
 =?utf-8?B?Ri9pY2dYbnowWTVKTnc2Y0N1aTZrZEZxakJuNjRuREJsK2dmbnhCeENBYWFL?=
 =?utf-8?B?NkhaVjZEdFF2Z3JNa2h2bEdkanJFQndrRWo3TUhWankvT1YrY2VVYW1ibGg0?=
 =?utf-8?B?eTNTNnJIeEFRTkZIVStKeTk4NmxvR0htNGFabDBGRzRIdU1VQTZ6VUZ1UVF1?=
 =?utf-8?B?TXNLek9kRWk5L09tUTZ0SHJ2bjcxTCs1R2Y2NFFjNEJFNVZuODZsVTd1V3Bh?=
 =?utf-8?B?VjVnQWNWUTlUazlHWi8vUm8vVVlldHhDbGlyK1pNTzlIR2YzMTdCZjJlUUUv?=
 =?utf-8?B?TXlRNTRiaFIzN3VlUjd4VzBVck1FY0dtV2dyTURTbCtFSk5iUjYydnpsc1hI?=
 =?utf-8?B?SHo5eDZKb3Nmcnk2WUxucXZrZGt6Q0QyTk42ckl4TTNTNlhZZjhSaXU2UWhr?=
 =?utf-8?B?bUhRTDNnaGE4ajRyZnR4L3l6OHAxVTNXaHNzWnNuZTNEN29Db2hRNFY2L3Bk?=
 =?utf-8?B?UWEzMW9yL1hBVTF5RlhmcEZZaHMyMmpBSUdBOWNVenhLZ3E3cTZZanNDVGg2?=
 =?utf-8?B?WVdMWC9ZdUdSczMwdVlVRDNLTzZTMXQvMk94RzRsbUcwclhVU3FTSHNwRklx?=
 =?utf-8?B?K3NFYnBDYTB6QUdvQTBVZSttM0Iyb0g5NTcrQjNKTGhRYzFGSlJOVmZDUFNi?=
 =?utf-8?B?ZGxEOWt0VkFORWdlVnVURVJKQXNTVlRLeU80UHhBcXR1SXlCMDNLRC9hSFdE?=
 =?utf-8?B?UW9vbVBFbU9xbFcxT3cwMmZ6ckh6RzFocDhaNTVwcVJBK0NNL0U3WHpUWHVW?=
 =?utf-8?B?UzA0WnhNM2cyTkZSQXB4eWpUNExVZ2Z5OUhiQW5KTWltc2RuM2JNcTE4akUr?=
 =?utf-8?B?dG5uNkw4enJQNnVzSDJGSFZUM0kwQkVnMWJHWjJNdGNLcng5cVBpQlAvamhJ?=
 =?utf-8?B?SzA3bHJDemFrRVU3NDVXQ2pXbFhQY1gzZlVxSlg0Q09yWkJSdXNOZHdLdElh?=
 =?utf-8?B?RzdXd0VkL25lcEg2NlZKb2pid2pGdWM5Y3ZJMExXU0dMK0FVTEVZenZTSDZi?=
 =?utf-8?B?Tm9NdHBHTVAxN2FyOEQxb056ZWRlZG1jb1p2N0xxRkpkamhxb0VSRWpKNlpt?=
 =?utf-8?Q?8Q4h4cEe7Fr1uMYqx+6d+M7oIeofmlVm?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TTJaTmNKY1B2REtiR2RFRUNPd3QzaHlpZFNJNFU3b0RGbWM1VmZDZ2owbUFL?=
 =?utf-8?B?Wm1La1gxSDZUTU8xV2l0aXh0cDk1RHRlUnpGMEtSMjlUbnRpTVF6cVpKMk1z?=
 =?utf-8?B?WkJMWHBFc2FJU1dYZ0RIZFZ1ckNVRlpQNVpZRUFFM1A1UG1md2o4aFhTVWlp?=
 =?utf-8?B?S1dZQXZhVHo4SExlS1NhSEtiVEdyRzdpc1NoSHdyWkNNdXpmTzRBS3hWOGVY?=
 =?utf-8?B?Rjl1RkZrK29nMjE0ZXNXdituTVFCNXNjckVRQURLWFdqYVFtZUxxYkpYclZv?=
 =?utf-8?B?U1hjRHN0bVVXdUVjWW0vc1BpalRxbmlUeWRtM2ZVaVFYZGpFRHNaRnpQd29Q?=
 =?utf-8?B?ZkxBZUptaDlSOFpHVDlTdmRKbS8wSUptT2psRDNySmVlK1RwUFcwRi93TGhX?=
 =?utf-8?B?WFBUUExpaWcxWnJYaUNKK2crOGkvYWQ1cTFwbjNHL3Y3V2FibWZDb2VLU3hK?=
 =?utf-8?B?NUdOd1hUdWF3NG9XSnVncDZBMlJTNU4yVUFZejYxdVZzWFU1Ym5aUXlUaUhN?=
 =?utf-8?B?UnovczNESm1scm1zYUVucjJOdDNYSkFCSDlDZGNaRnVOUHpWeG9CUDB6cGlw?=
 =?utf-8?B?K1FDamdiZkRVdkFqQW5mOXpFTVBHb3N3RUtFUzhmTmIwRlhOdFlMVW80WWts?=
 =?utf-8?B?dUJNQ2dTcFZsSWorSllIUWUwa1lpQkhWVXBqUVhwN1lXcDJtVWZxSFpHSVJv?=
 =?utf-8?B?SmRaV05ObTNpL2VFNzFQaHBKR2ZVeEszRGJ5cHJJM2phaThTNzYrbk1RL25l?=
 =?utf-8?B?emt0bUppWFVKc2VPNkRXK1ZaK0NlUEV2eVd2Q3NtL3dFQzh1ZmZIMDhVMFdj?=
 =?utf-8?B?Z0ZiZXNYYi9rUmNRYWwyNFZUQlJWM21DUXdaMjRJajhzNkI4L2hNYjM4VEth?=
 =?utf-8?B?a012VUZGSmREVCtSeFR5SHczbGlxZ1F6RDJHQ0F0ZzdKV0R5UWFUSU5FMlRS?=
 =?utf-8?B?QVZxZmluM0F6ZWxNeEdYWHVLVkMxOUtoVWxoeGoyRUUxZVRFbjRwdzluQkZ4?=
 =?utf-8?B?eVRGQ01uQzlzRGF4SlU4eXBES3hWMDZrbkR2RWhNb0kyN1RBWUw2Vmp5RmNv?=
 =?utf-8?B?WWg0NkFuYVBKL3ZnVTV3RFAzQ2gzNy81WFVFMys0bWo1MDJEQjVqcDlqcWV0?=
 =?utf-8?B?ZEVZTkV6NWUrQlk3REU0MnhlWngvRzhYSlJNdlQ5OC85Y0VaRE1aaURlb1RD?=
 =?utf-8?B?bFNTbUJGR0hSR24ra3IrRDZtMW41ekc5TDVVU0lNUVZrckJHdW5YNWxObDBl?=
 =?utf-8?B?OGZrNDIycW91LzdqOHdVdG1NRHBLMUFqMEZUQXNhSDRheTgxMTM2T2Jidm5h?=
 =?utf-8?B?VjhrZUNkYmJxdERvNHcrSmtLOHFoaEllZ2NISlNrRzhES1lmcEg3YXJiZlVM?=
 =?utf-8?B?dGpJYTFoSlVlVzV4N0ZORkh0TUxsZU5kUFFqUjBRTzVkdzF4cWRsOFBOV2hM?=
 =?utf-8?B?VUNtNTFueE5PLytSZFFLUXBTV3lmR2REd0M3ZUVBU2o2ZVBqOUE0eFc3d1Uz?=
 =?utf-8?B?RWJkaHpCR3JTTE5GRDdwalFHMW5MdXBTenZEcUhzR1QwMGdySVdCZGZodFlL?=
 =?utf-8?B?Y2ZBRWxsNDZrdDZ2NXRCVkczVEYrRlA1S1VIQ1YveUxyRWpIWEFwYTFIb0Vt?=
 =?utf-8?B?aStOR0pJOGpoUGdwMWxZSllxbVlENFNlZk9zNWEydE5kNXcwZmtXNGNzK2tw?=
 =?utf-8?B?VVM5amhOSU9VanZRdkI0SERFZEZ2QU4rVHNOWEp4QVR4bnJQL0pmU05ZMENN?=
 =?utf-8?B?bHB3Zm4rZUFYVnN4L1ZlVkJFN0JnVXBZcHNncW5Jdmt6dnBWNkdhb0ZiWGpR?=
 =?utf-8?B?SzhDNGV3eG9vS2FpUk91QmJsNmJTWDVZZ29OUndtMXFSbnpGdkRtdUl0dVZH?=
 =?utf-8?B?bEVPbm4xOVY1QTdmZzZQVjcyRlV2U0ZIVzhYNDFCZXNwMk1sMTVYaWpSd3pC?=
 =?utf-8?B?ckx6RUV5ZnlPbGUyUFhCNDVrRVBEdjdJWUlVaWl6MnVwOXhodjcrY1ExUVZx?=
 =?utf-8?B?SmliUGZnL0ptNnNXSGhmQWgzdC9PM3h0SEo5WlVXVG9mS2lZWUJNc29pcG1G?=
 =?utf-8?B?ZDVXRGswSEJwaGRJSmVLK0JCUk9DYmh2TTdDbllrQml3cEI5TVFqdE1TT1pW?=
 =?utf-8?Q?5XQhTwIcy+RRq7JdYy02uL3bI?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77fe50fe-f589-46c3-68be-08ddfc10f0ea
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2025 08:53:05.3434
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SzSXyXj854FVNVh4dwKmXP7gM349vRe1yE5PEoI3YHeWH8Eq8yYRnI1QPHEETzAFrsLcvFM2+3YFc/UqZnQQUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8107


On 9/24/25 09:25, Alejandro Lucero Palau wrote:
>
> On 9/18/25 12:03, Jonathan Cameron wrote:
>> On Thu, 18 Sep 2025 10:17:30 +0100
>> alejandro.lucero-palau@amd.com wrote:
>>
>>> From: Alejandro Lucero <alucerop@amd.com>
>>>
>>> Export cxl core functions for a Type2 driver being able to discover and
>>> map the device component registers.
>>>
>>> Use it in sfc driver cxl initialization.
>>>
>>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>>> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
>>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c 
>>> b/drivers/net/ethernet/sfc/efx_cxl.c
>>> index 56d148318636..cdfbe546d8d8 100644
>>> --- a/drivers/net/ethernet/sfc/efx_cxl.c
>>> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
>>> @@ -5,6 +5,7 @@
>>>    * Copyright (C) 2025, Advanced Micro Devices, Inc.
>>>    */
>>>   +#include <cxl/cxl.h>
>>>   #include <cxl/pci.h>
>>>   #include <linux/pci.h>
>>>   @@ -19,6 +20,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>>>       struct pci_dev *pci_dev = efx->pci_dev;
>>>       struct efx_cxl *cxl;
>>>       u16 dvsec;
>>> +    int rc;
>>>         probe_data->cxl_pio_initialised = false;
>>>   @@ -45,6 +47,37 @@ int efx_cxl_init(struct efx_probe_data 
>>> *probe_data)
>>>       if (!cxl)
>>>           return -ENOMEM;
>>>   +    rc = cxl_pci_setup_regs(pci_dev, CXL_REGLOC_RBI_COMPONENT,
>>> +                &cxl->cxlds.reg_map);
>>> +    if (rc) {
>>> +        dev_err(&pci_dev->dev, "No component registers (err=%d)\n", 
>>> rc);
>>> +        return rc;
>>> +    }
>>> +
>>> +    if (!cxl->cxlds.reg_map.component_map.hdm_decoder.valid) {
>>> +        dev_err(&pci_dev->dev, "Expected HDM component register not 
>>> found\n");
>>> +        return -ENODEV;
>>> +    }
>>> +
>>> +    if (!cxl->cxlds.reg_map.component_map.ras.valid)
>>> +        return dev_err_probe(&pci_dev->dev, -ENODEV,
>>> +                     "Expected RAS component register not found\n");
>> Why the mix of dev_err() and dev_err_probe()?
>> I'd prefer dev_err_probe() for all these, but we definitely don't
>> want a mix.
>
>
> I'll use dev_err_probe here and in following patches extending sfc cxl 
> functionality.
>

FWIW, I have decided to drop patch 8 what was something problematic 
coming from v17, and after Dan's patches, neither its original purpose 
nor why I was still using it, remain. So no EPROBE_DEFER possible for 
sfc driver initialization, therefore no dev_err_probe will be used.


This along with sfc driver using pci_err makes me to update the code for 
using always pci_err. Nevetheless, I do not think mixing pci_err and 
dev_err should be seen as inconsistent error reporting since some errors 
could be clearly related to the pci device and other to those devices 
created during cxl driver initialization. For those errors reported in 
this patch makes sense pci_err though.


Thanks


>
>>> +
>>> +    rc = cxl_map_component_regs(&cxl->cxlds.reg_map,
>>> +                    &cxl->cxlds.regs.component,
>>> +                    BIT(CXL_CM_CAP_CAP_ID_RAS));
>>> +    if (rc) {
>>> +        dev_err(&pci_dev->dev, "Failed to map RAS capability.\n");
>>> +        return rc;
>>> +    }
>>> +
>>> +    /*
>>> +     * Set media ready explicitly as there are neither mailbox for 
>>> checking
>>> +     * this state nor the CXL register involved, both not mandatory 
>>> for
>>> +     * type2.
>>> +     */
>>> +    cxl->cxlds.media_ready = true;
>>> +
>>>       probe_data->cxl = cxl;
>>>         return 0;
>>> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
>>> index 13d448686189..3b9c8cb187a3 100644
>>> --- a/include/cxl/cxl.h
>>> +++ b/include/cxl/cxl.h
>>> +/**
>>> + * cxl_map_component_regs - map cxl component registers
>>> + *
>> Why 2 blank lines?
>
>
> I'll fix it.
>
>
> Thanks!
>
>
>>
>>> + *
>>> + * @map: cxl register map to update with the mappings
>>> + * @regs: cxl component registers to work with
>>> + * @map_mask: cxl component regs to map
>>> + *
>>> + * Returns integer: success (0) or error (-ENOMEM)
>>> + *
>>> + * Made public for Type2 driver support.
>>> + */
>>> +int cxl_map_component_regs(const struct cxl_register_map *map,
>>> +               struct cxl_component_regs *regs,
>>> +               unsigned long map_mask);
>>>   #endif /* __CXL_CXL_H__ */
>>                struct cxl_register_map *map);
>>

