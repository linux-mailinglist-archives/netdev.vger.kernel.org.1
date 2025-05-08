Return-Path: <netdev+bounces-189050-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C24AB0130
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 19:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 977257B2937
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 17:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D707A207A27;
	Thu,  8 May 2025 17:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sR9iyO1+"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2071.outbound.protection.outlook.com [40.107.223.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124E835966;
	Thu,  8 May 2025 17:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746724643; cv=fail; b=nsQzPbJqNMz10yuL2+ZNMq+I7yQamNjrqCZLbveY7h3Mex2iV7WoF3rOXSCprD4DMDDtgB85hfaSTp75X4LRd0dTysqipYiry3CNqzBu0GW65sX2a6sd7KU++v+MODDV9YVKYM+oBG++sPI7yT2gQllRkstlSiGSb4ft4VSMBJ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746724643; c=relaxed/simple;
	bh=bFS9EuSphE2X7x13pMIDIuGbV0QJk3aU3RCYuiTF5Jc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DZ2lLLMeKfvOtvYYLWRMImFjlrwdN3fYxahHl1y0jv6xGGdKZDWNFUvi3obLE6bpTQoCueNG0vrixst/OAYcO7fIjKZ6lB9V2ve/mSRgFuE38lKyBN2Nk04XS6xG4kGs9rSSGFCZ3wN7jnBBdRV/RrMf9ROFvBiV6KDaQcDsInw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sR9iyO1+; arc=fail smtp.client-ip=40.107.223.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OIQOx3kxWZt3LgobYAbOu6RXAHxhy3y65wZCoXsD0ji8vPHVxy42h+yB0nCK+/eV+x+hEfJ4IM1zPGPNReCabsYQH/gRpjxmTSCOoQwOh5L5iNSCiVwZagjZCa801zy+uGH73eeZoe4/BUTwWJgQL4bk2DoqF5+ALgbS99MHkXBHeHc7X2HuGjDr+cLXvGclTn+/DHzLVjWOyJHI7CUABYnVwAzkKy+3ehQkBpFwyxCmcFiZzg2kuMf/fvL+9ONSewwP5gN7RS2jUcz0HKKdV9NL/2q9lgGNyMYqY5qvjJLN0X/WQdfl1yFN0EMgG+x1bLyVEogJ4An1JueV+dqNOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gjNiqdHIo3yDMflr+N8NtmE2e2YMDOOaJP6kxl8FFz0=;
 b=oz/nuMm/AzpB8uMmsdpFydUx8o42CYUTmbZVFb6rGo/+7x8fYEoLoeVO3Qxf4LxKKbaHebRL/cHBv7RKPTROQBFkUcUIUY6XOIbDuTdyqC8uctgtKSRF0Rfe00EAihPiluPscfX0QNO165E69fH0xxZa37XATyoOxOKuG3X8pL8MHdlhz4uB7aO3RRRFJZCzBu7qkaGKnkMX3M/GrJzX8ZshBuf30q/COow3dHOfrY2R/kU3JPynauRghQLrEV64S81VXggSk55rok4w+NRgVXNdQW3161zkp+xX2uzTKCUtjOzJgz5Pekq3diVjQVGIrGBQ+RgahUCcHqwzEe8S4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gjNiqdHIo3yDMflr+N8NtmE2e2YMDOOaJP6kxl8FFz0=;
 b=sR9iyO1+1A2VB2psc58gYIoVkuyFEOkvI28KtSdN1yimvDSZ+okdNNaBtG8my6pTfc8SMTj7z0Ksna4lGCWNKn4G9fydMdPI2Y6nJfBRU2QUlb2DsdF3vvyh8bxdJ30WT+0YzjdTE1YQyUXwIi11GqVtfqm063KSIZs3b/x4/xQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by DM4PR12MB7695.namprd12.prod.outlook.com (2603:10b6:8:101::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.24; Thu, 8 May
 2025 17:17:19 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%4]) with mapi id 15.20.8722.021; Thu, 8 May 2025
 17:17:19 +0000
Message-ID: <90e9e04d-0df8-4e91-aacd-51e05df36e97@amd.com>
Date: Thu, 8 May 2025 18:17:15 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 02/22] sfc: add cxl support
Content-Language: en-US
To: Alison Schofield <alison.schofield@intel.com>
Cc: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250417212926.1343268-1-alejandro.lucero-palau@amd.com>
 <20250417212926.1343268-3-alejandro.lucero-palau@amd.com>
 <aBv7woc3z3KSMK8Q@aschofie-mobl2.lan>
 <0de6789e-9d19-4e90-a0cb-cf77f12428c4@amd.com>
 <aBzmCjCStxiQRJkK@aschofie-mobl2.lan>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <aBzmCjCStxiQRJkK@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB8PR04CA0016.eurprd04.prod.outlook.com
 (2603:10a6:10:110::26) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|DM4PR12MB7695:EE_
X-MS-Office365-Filtering-Correlation-Id: 08a39882-4e86-4fce-b115-08dd8e54301f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a2t4bnQ2SzZKanJTcWlHc1lpbjQ0VitzWmszaUFRYXlHVTBkNXJjMUptZElK?=
 =?utf-8?B?RzBPbmFEK3BzN2tPdlJXeHRjcnVpRGZhTVYrOHFLQVBIbmFwU2FDQVN3Y2Nr?=
 =?utf-8?B?S1NuVUJ0V2tNRDJQdWJrNHJqcmQ3VW5Fd0JvM3lGZG9PY2J6N2NsVDhPNldk?=
 =?utf-8?B?UE9oNUlta2ZGTnZSZWlpcUpMUXhUSjdZcFlYK1VuN3Y4VDdaTUhTUFZzM1p2?=
 =?utf-8?B?cVVxUkFvWG11bWM2YUk5eExlZkRIVHFsU1FTUzdmNTAzVTVZZ0g2L3BrWS83?=
 =?utf-8?B?NjVRR3gyMmZqcmlOL0Q3a2dHSlBpSWNjZjY0S3dLaUkwRUx6MnJrMGs3em5R?=
 =?utf-8?B?a3dvdi9pTWZZWUFmYnpBbUM3ZDFWNlZ3MUo3K1d1eUFxRmoyOWJCTng5UVV0?=
 =?utf-8?B?YURFZWRwdTIvekwwWnZNUkxzckdMcUtjMkg0SnFsdldnTWZMZVY5Ty8zYm9D?=
 =?utf-8?B?cmRpQjRBeWFlQVhudHRBMlQ3WklUbzBjSWRUd1RuN2tjMmZnSURVdHlMc0ZM?=
 =?utf-8?B?cnZiR1ByWngyMVJBQkJmZkVsdFFXNHo5WTE5VENwMWJUNU1FZytoSkdEd3RC?=
 =?utf-8?B?Z09FOXBYWGthUzFCcGFlelhaTGczNDZJUExXQ3ZMZnIyUm9La0FHOEU2c1Fl?=
 =?utf-8?B?b1BNckU4YVlONGVFK2FkYytMV21WS3lFbElydVBaUm9oaWJwS2gzbG5pQVRx?=
 =?utf-8?B?Znc5V0lGQm0xR09Ed0YxT0V0cE5qWXJ2SW5lb0VJU04yaVFWMnEvb0Q2enRs?=
 =?utf-8?B?ZmRseWZYMGxZT2JIVHJuQm02ZS9qRklXMVJLL1NyVDd6ZE9MOXRlRGU3VkVI?=
 =?utf-8?B?T2c4VU9nZGl4K1Z4NUhKV1hHelFSMkhuSjVRWTEvWlVob1UvLzZZUVRjTkZ5?=
 =?utf-8?B?eFRPVW43U1RYN2J0QndrNHNwM21BbVZpbUhDY3pEUEZKTVgxMDFNMlNqc1lm?=
 =?utf-8?B?SzRQa3VOUE5DcHZUOVY3OXFHa1VvcGs4V3Q2VkxUaDlUVkZockRJWmxoSFZp?=
 =?utf-8?B?U0NKYzlMc1NFa1BteW4rbXBaUm9TS1crTE9nNmZhSm1pQ2tLOWtzRWcvdHJw?=
 =?utf-8?B?aXRFeS9mUnhmejFuaHJzVGVsVnNiSlpsclJ0ei9MemZXRkxoc1B2bzFidXJD?=
 =?utf-8?B?NDZLSkd4R2JzR3V1SldWRDFGY0dWWjJBZm5ZQzQ5MGNFc01PY2tJOUphZ0ds?=
 =?utf-8?B?a1VUeE5OaHZNQ3UydXNzUWEwTzVCRWdWYXU1c0NiZFNDWjNmMThxWXlCS0Fi?=
 =?utf-8?B?UGFyRTEwQVM4cXlKVWJQdGZjeUNHVm5ybWtEcm9tbmlpbkY0em44bUthWDBl?=
 =?utf-8?B?MExZRnBsTmVBSU9IVTdJUVJsY3RqWTIvTCtnbkdtbzhJeVR4TVBDWS9BUkhU?=
 =?utf-8?B?YVFzblcvSnloUEJLZmNWT0NFSGRDMHU0eXJQbWI1RTVaWnBNMURmbGlHWThz?=
 =?utf-8?B?MENrOUlnVUh2aloyMjY5UWRzbWpMdThxcEN6TzNFOTc1eWtmRThCSVFDeDE5?=
 =?utf-8?B?RkJISmxNYWprZTV5Y2RvZEczTkxhNmVnQXRSNUJMTkVadTNJUno4UmpZdTNQ?=
 =?utf-8?B?SW5pK0pDTmF0S093bXdPZ3R3TUF2UVlDb2syWDdPeGRMWlpuUkUrRVM1NDZQ?=
 =?utf-8?B?R0pRaitBWUhVTFZRaWJ3NDc0TkorMDNGbFlXWEN6dkF1WWFzKzJlOXg2dVlB?=
 =?utf-8?B?VldqVkx5L2NqK3VaTHBHenVWM0lHOHlGREdTVlRUYkFNMmlGODJIaEdnNlVC?=
 =?utf-8?B?MytncXVPZ09ITERvUFhPNE5IbnJXTWFGYUs1OHRPTFFWc2w1c3BoVkN4K011?=
 =?utf-8?B?ekFFOEx3Q0o0TkJvSStMWk9vQXJUb3REUUo1ZE12R2FGK1NqSEVrQjRaVmxm?=
 =?utf-8?B?VHdIZWNIQko0MFptM1RkdU5teStIdG5TUUpCN3R2QlhQOGQxSmo0SFh5ODZo?=
 =?utf-8?Q?5VzwmPsVHNc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WTNWUDZSK1hJd1A1OEl3VFdIeGRvc29FUkJZMXBEc2p1a0IwSXlMTUhIbDhp?=
 =?utf-8?B?aFJHdHNiN3UwMnJzMWNxdldIZlRKZ2U4RE9iNk9XdVpCSUtoaWhRK3NvN3kz?=
 =?utf-8?B?RGU2aVppZWM0WW9zNjU4akpXSHluNVQ4dE9tK1FyYUY1cUkxWlI4blZRcy85?=
 =?utf-8?B?Zm04NkdjQzY2UWVjcTZreHRtMk5TaEc3M2ErTjlIQ3VpWmxNeEgzL0F3UWRI?=
 =?utf-8?B?QUZuU29USGRTRlAyVVlHdE1wVDNSc0hTNzhZK2ZLYWg1K1ZMVWJRbnFlYm1s?=
 =?utf-8?B?eDArRmFZdTZxWGNCeHBndGhHY1owdndqOThZREhMTjJUTUVvYW1XRnVMZmFF?=
 =?utf-8?B?UEJnelNtVGFFT1c3Rk5WZUswTVB3R01CWWo5NldwRWUzV25Nc0RDMHNCN0pt?=
 =?utf-8?B?WThadGJEam95aUtPWHljWUhCaFN1eVAvNGxFTnZqK21vNk84TVNOTEpwVlEw?=
 =?utf-8?B?MXF3UWtzdVJYWUs5RnVDNlkvWE1ya3ZieFdTS1YzeVBDY3phZkxGQVBOTU5z?=
 =?utf-8?B?Rk5xSExodlZKMk1OU0ljTDY5RmZKNXVtNis2SzhqaXFiMWRDMzdvSHg3T3dT?=
 =?utf-8?B?RXJGMFlWRTRpRmxSWlhYSFBxOEp5aHRBWHhzRmR6MHJwQlF5cTdDM2U5ZGp4?=
 =?utf-8?B?akdldDRuWE96Q0owdG1PZktCakRrSEZpVkNqOWhvdWo1eUVPSDJ4ZE5rNnlQ?=
 =?utf-8?B?R3lKbGUxSi9QblRSQXo0bktMZ0FHSTJ6QUFUN1lpZ0JzQUhrRWxRN3BPc2Nt?=
 =?utf-8?B?d1pkZ1JKdm9CYlFneWkvTWFKMGg2Y3gwMDkzTHd1WHI3TW1YaTNpUC9xcmdO?=
 =?utf-8?B?cUIxcEZ4dVZ5WDFSMGtrNjZ0cmNvbDhvcEJ5YjZOVUQ3TjYrTUErQzh2MXRr?=
 =?utf-8?B?VWw5UVNYbXRGVGRQaEhNemgxRUUwRUd5YmVIdGdpaXV6MzltQTYzb1kxOHRt?=
 =?utf-8?B?ZGFNNmwzVlZIOHNWcFVOOTA5K2RmNldFNzhVQ0orN0t6TE9GT0ZFSnlySTVL?=
 =?utf-8?B?OXBTZ0s1M2Nvak05OWRrSy9qcFNrRzFqVTVJZDlKcnVUZk12cHpIN1lxYzVz?=
 =?utf-8?B?L3JYZTVHdWkxRktrUzh1U1RKVzByUGVjOTBwdytxTUI5azhGWldqR0NkMXh1?=
 =?utf-8?B?b2svZ1B2MmZvZEl6YUF0bnVoZElML3lNRHo3c0ltSVF4bTZEcitxVC8zNzVJ?=
 =?utf-8?B?R2tRWmFQZjRGTUkxQnZwei9HS0lHTkVjeFlQVnZReXlpS1dEbkFCekZsZGIy?=
 =?utf-8?B?OWJsTlhPTExLeWgzK2Q3ZEd4cSs1ZGRydjgyRGo2UnRCbWFYNk1CdUtERmVr?=
 =?utf-8?B?VFo1Mk83M2U3Zlo4bE9DN2RTaUJNeG4rWXROckFmeVc0YmR6QVdKNEVGc3dH?=
 =?utf-8?B?OWUxUzFUK1NXK0E3OGorckJueUJKS2wzdm9qYkVoZmlEc1BIcVlkY3ZUMTF5?=
 =?utf-8?B?QTc1cW9BYzk4UzZEVngzdmNlQUx0SXJKVThQNnY2bDV3RWJmWkdWaEtvVlhj?=
 =?utf-8?B?TVZkWlFvb3NhVnFpTTUzZWJsc2xITFBmWnQ1K2w0OUMzOXhqZ05ncm5HTDZP?=
 =?utf-8?B?SmxHaERZemJRMzFpTHlIL2Z6alloclBWcXZnOWZZbEMxY3U3ZSszeUlHNnpt?=
 =?utf-8?B?UnA3M3N3TjhHSGpzZkRwUVY1Z0F0cnJGMjV0U3JXL1Z4bXJWTEE3a2NoQ2JZ?=
 =?utf-8?B?MzlsMjFIY1NtVXByd01IM2NRM0RSSWtqVjlEaUxNQkp3V2FsYnRjK21zOXhS?=
 =?utf-8?B?MXB3azdjMDM3YnFOcGNxMVRRRHJrb1h6cGp6VmpPSnBTWmhtKy9GY2hFSUln?=
 =?utf-8?B?cUZIeTlpQms5bWhFRE5KS0l5YlNJSGZDZVRoV29HM2NLOHhhMUNLR2dsUjFY?=
 =?utf-8?B?SC9takpCMVBwb1FTSTVRRzcyS3oraE4wOEpuQ2F4ZW1SUEdEU2pHR2NsOW1w?=
 =?utf-8?B?a3NxeitkZDNnaVlpbmw5UjB3QTJHYWtNcCt3MmRHOVdTN2dvSDVqekRmdGpp?=
 =?utf-8?B?b2gxY044WThaSEt6WVdRZkVTRTNHMWhoM0hsMENTU2prVVBtL2NEZ1d2Qy9V?=
 =?utf-8?B?ak1jRHFudXlORzJpbkxPUURkalgvTjVMTUtpMmIvNDIzckNlay84MGlNNTBX?=
 =?utf-8?Q?i9JrQy/4Bhsnqd5M1cuWiEfie?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08a39882-4e86-4fce-b115-08dd8e54301f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 17:17:19.4637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ux1E+E83vMNLO/qVVZ9px/rUUhyl2g7ISIazin0M8EDz1oX0LJlnecBR/P0A/uXmjcjCEz7rlmFSXV7gYAQ96g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7695


On 5/8/25 18:12, Alison Schofield wrote:
> On Thu, May 08, 2025 at 01:41:15PM +0100, Alejandro Lucero Palau wrote:
>> On 5/8/25 01:33, Alison Schofield wrote:
>>> On Thu, Apr 17, 2025 at 10:29:05PM +0100, alejandro.lucero-palau@amd.com wrote:
>>>> From: Alejandro Lucero <alucerop@amd.com>
>>>>
>>>> Add CXL initialization based on new CXL API for accel drivers and make
>>>> it dependent on kernel CXL configuration.
>>>>
>>>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>>>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>>> ---
>>>>    drivers/net/ethernet/sfc/Kconfig      |  9 +++++
>>>>    drivers/net/ethernet/sfc/Makefile     |  1 +
>>>>    drivers/net/ethernet/sfc/efx.c        | 15 +++++++-
>>>>    drivers/net/ethernet/sfc/efx_cxl.c    | 55 +++++++++++++++++++++++++++
>>>>    drivers/net/ethernet/sfc/efx_cxl.h    | 40 +++++++++++++++++++
>>>>    drivers/net/ethernet/sfc/net_driver.h | 10 +++++
>>>>    6 files changed, 129 insertions(+), 1 deletion(-)
>>>>    create mode 100644 drivers/net/ethernet/sfc/efx_cxl.c
>>>>    create mode 100644 drivers/net/ethernet/sfc/efx_cxl.h
>>>>
>>>> diff --git a/drivers/net/ethernet/sfc/Kconfig b/drivers/net/ethernet/sfc/Kconfig
>>>> index c4c43434f314..979f2801e2a8 100644
>>>> --- a/drivers/net/ethernet/sfc/Kconfig
>>>> +++ b/drivers/net/ethernet/sfc/Kconfig
>>>> @@ -66,6 +66,15 @@ config SFC_MCDI_LOGGING
>>>>    	  Driver-Interface) commands and responses, allowing debugging of
>>>>    	  driver/firmware interaction.  The tracing is actually enabled by
>>>>    	  a sysfs file 'mcdi_logging' under the PCI device.
>>>> +config SFC_CXL
>>>> +	bool "Solarflare SFC9100-family CXL support"
>>>> +	depends on SFC && CXL_BUS >= SFC
>>>> +	default SFC
>>>> +	help
>>>> +	  This enables SFC CXL support if the kernel is configuring CXL for
>>>> +	  using CTPIO with CXL.mem. The SFC device with CXL support and
>>>> +	  with a CXL-aware firmware can be used for minimizing latencies
>>>> +	  when sending through CTPIO.
>>> SFC is a tristate, and this new bool SFC_CXL defaults to it.
>>> default y seems more obvious and follows convention in this Kconfig
>>> file.
>>>
>>> CXL_BUS >= SFC tripped me up in my testing where I had CXL_BUS M
>>> and SFC Y. Why is that not allowable?
>>>
>>>
>> Not sure what you mean here. This means that if SFC can only be a module if
>> CXL_BUS is a module and you want CXL with SFC.
>>
>> You can have SFC as built-in in that case but without CXL support.
> OK - get the desired constraint.
>
> Why use >= with the tristates and why default to the tristate instead of
> 'y' - like this:
>
> 	depends on CXL_BUS
> 	depends on (SFC = m) || (SFC = y && CXL_BUS = y)
> 	default y


It was suggested by Dan and the driver maintainers happy enough.



