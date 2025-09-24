Return-Path: <netdev+bounces-226016-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE38B9AD45
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 18:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EDB719C20E2
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 16:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F0631282B;
	Wed, 24 Sep 2025 16:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="J1dT5teG"
X-Original-To: netdev@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013005.outbound.protection.outlook.com [40.93.196.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B7B30BB94;
	Wed, 24 Sep 2025 16:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758730585; cv=fail; b=V0JQjteHFxv8D4tnYyVZLFMdYaci0lhemPuIXeyfgP4Qc6blWVLZ1eVXAXDZ2soh7mry8WBx/l41d79ctLchIfY8KipJ+/QVxcKX+atXWj5xTJMba7JNPQgYDCTWppXK6G9zY8lGFQwejk8imRc+5qqUVTIspo5zcwaJmPTDtD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758730585; c=relaxed/simple;
	bh=wqAU4eAISQhxoki4fYBDB3maA96+Udzpdnm2YFFaqbw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=a2VmBYOeMYmAHsVJdvlYT4wpy4+jFGlxRFsdpMeUJqO+ms9zF/9sAX/rWDDgar2/FZGzXJXc4NABfGAG6os4wp5K8mni8Bq9fmHNW9mNq7tJ9losNFPuEQyHsFghO+fBuW4rltQ4yv51dKGYNyp0s/zsO4Cta1ozvHPcY3nLsZI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=J1dT5teG; arc=fail smtp.client-ip=40.93.196.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cHz15EuDHI/N1R+/d91nnT7ZSr90BVQyDaQITYgrSKDAN7Wz+gwcDSkIM5oTSu29+gmKds8Ksv22R8rPe60rx6mM2itS+Ee4xbwMssKHMxczq+QPg+3lyk4v0dQWc60BnRMQ62MAEAb3Ti4064yF2JMotsnRf6Fir2Lk/6wC4b2YktUm0BM7bxaiJhKlLkY9lGMvkzOp3rPeHbCWmwAl0YYe3p3VNVstnxKWLntdiFl8xThyTTSo/V8003voB4v+mWb4af5mMiXV7bjR3MLCVTu4pbggJyx5CkR+GG91UUum8Mhb4fu0kENNf/QEz2guBP6wCqwFlf7mprJjngmubQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ctns8lrMwtCP0QbFx5e/oIHVnJ7KSIUFKhzFa7iOaWQ=;
 b=BA8NpmQiaBWSeDD8vw9pykTbfh4ftWu0wpaytb15JGDNF401VjVjG4tmAzNCVzgq5KAES5aeq2EOPhR218f/2MOdayuK6AoaSitZH4+9dGq28qjrVNuZ96qKuIAgd9PqNPUEgjYc5AZG21HpTEf/9vqoLjTcDEPt7XckffiQMGtM/SLMyn5hAac560aMzHUcTAz8msyDAnuY4ilxVHhf2qJm4+JVlkjya93wT4mkVn1LdeEPi3StXL5yZ8bhJkmxgOMvxOsuHd0E/kkXJdzVeI7DThdFqM0ZRaY8TzkA0vyuzT5QE33qU+agxAQK7JZBdX3s0lmgQavWgV6HO4aw/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ctns8lrMwtCP0QbFx5e/oIHVnJ7KSIUFKhzFa7iOaWQ=;
 b=J1dT5teGyMPR9cNw9pWLq+iZIPd2HPjg35f8gn79H9AvzVhWPzXoBukyIcCkYz7ZpPAvks5tC/UxF9IIN6CgfdcMcGzJadfnDhQzMRSIIFHRtEVhsEPVGbEePCVysiOj1ytB8u05rjKpgUSvDcjFBR/B/FFZWx4ME9oTu22WGOw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by IA0PR12MB8086.namprd12.prod.outlook.com (2603:10b6:208:403::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Wed, 24 Sep
 2025 16:16:19 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.9137.018; Wed, 24 Sep 2025
 16:16:19 +0000
Message-ID: <989dd1bf-adcd-4bd4-82fc-0497d615667a@amd.com>
Date: Wed, 24 Sep 2025 17:16:14 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v18 09/20] cxl: Define a driver interface for HPA free
 space enumeration
Content-Language: en-US
To: Jonathan Cameron <jonathan.cameron@huawei.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
References: <20250918091746.2034285-1-alejandro.lucero-palau@amd.com>
 <20250918091746.2034285-10-alejandro.lucero-palau@amd.com>
 <20250918153503.00004800@huawei.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20250918153503.00004800@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0090.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:190::23) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|IA0PR12MB8086:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cea251a-9aed-4710-1a74-08ddfb85b1c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RFA5SE1XU2JFM2VYak54Sjh0b0FIL1oxZEMrNU0vMjVBaVdCcUpZcWZGRVl4?=
 =?utf-8?B?V0Mzd1Y0V3l1N3pqWTZPWDNVNEZUVExSbEpoSk9GN2E1TWhrZHlKQkpIRFZV?=
 =?utf-8?B?Q0xXR1N2WmJ3Mlc1RmpsV2NWNU9xcmhPMFN4ZW9ick9TT1dQa3ZRVE9NQUI1?=
 =?utf-8?B?NFpQN25QaThIa3VVY3prZkJPRFNYeXhoZXlVbjJoZHAxMkxDQ210Qmd1VE9i?=
 =?utf-8?B?TUtuYWVqSFhOYkxzL1VUdmsrQXlQbmtGRmVmdVk0d1hqYURiOVBxSzYydzFk?=
 =?utf-8?B?REwwTHNLWVNRaWQ4cWZyOTJnYmFvdkd5VVhheWtKNGlFUkZQTHB6YjNvbFNw?=
 =?utf-8?B?STUwbE9lWFBQNTJ0V05aMFBacjBsZFZaVzcvUTJuRXE0ZjF3NURzenNPc0di?=
 =?utf-8?B?bFFMcTNUQjNXREtwYVRGWVFUVmdBc0FrZmQ0OVlzQ3JGZUN5WnNzZFEzZTVU?=
 =?utf-8?B?dUZ6L01XeEQ4cW5lVVB1ZVpMN1J1dVVXZlEzZEZhckxIME43d1E4NnB3Z1Fl?=
 =?utf-8?B?dlpVc3ArSFJIOFA2eGVQUVdUNjRMSnRzSnVqTFFjV05DemRtTlJMdUF5NmJF?=
 =?utf-8?B?bEF5a1dWM1hMdVNJQlRGK1VTb3Q4UjF3dkg5QkwyTkFYaWdkM1BiWTFMTTkx?=
 =?utf-8?B?MlJ0dHBlQkF4WTRDa250Y0Z4TTIrYnBjd2t6M1VaS0VzK3FWNW5rcEE2Q2Yy?=
 =?utf-8?B?Y2ZXekFtak9mbG1oRkFIREpsL0lIWTJDcDBwQW13RjVqN1UrOEJxUENldmhj?=
 =?utf-8?B?WFRzRWlqQWdJV1JXb3FhWWVLL1dtSFBESzVyMHFsSFgrTjB5MFkycVJiM2hL?=
 =?utf-8?B?Z2NQQkxWU0tBbDZIelNFYzY4c3dMRldxTXEyVHpPaVNHU2UwSmJ3RTBURHdk?=
 =?utf-8?B?VXBGRklUQkk5dDN0d3FkRlJ1cU4xNE00d0paZHBoN0VKMVVzcktMTTBIcHls?=
 =?utf-8?B?NEtTNFJTS1pWZDBVWEdBWjFVcVMxbzB6NWpGc3RTYm00S0VBcTcrTURQRGJa?=
 =?utf-8?B?cjVDcU5NQ3BCNWpyQ1UzMjQxdDZsbUIxUklXd1BuTzVoREZVMDVmbWFtMXZQ?=
 =?utf-8?B?S2JIV01ScVcxMjdVSHdVbmxyaTFIeG1uSWZVRThuRmRIem81ampaUHFwSEFt?=
 =?utf-8?B?RWNBYzZyVmlnb083aEY1RXVIZVFUaTJGZ2xvb2Y1V0JSN1hpZjBPTHAvQzVh?=
 =?utf-8?B?QWNSSlVURGhtWlJkQ29GSGc0VWo0eFI1TS8xaWtTZ0xaT1RpOXBCZ0tjRWpZ?=
 =?utf-8?B?Vjk4eUZtZngzU3E2WS8vY283NzJSQXVtellvUUlpVXVKcGxxbk5ybGUxYzZ1?=
 =?utf-8?B?bGQwUXZhZ3hWY3NIUnd4VERWeXM0V0cvS1U5S1VVeUYvSHJTbWRtVXpBRTF0?=
 =?utf-8?B?SjB6REkyUlNzbXFyS3hQZG5PRXlOeU1rcnFpUEhpU2YvQ0gxaVg5WVpKc3pG?=
 =?utf-8?B?SlFkK2xPOVdFb1FoeXhvZzBtR0JnUXRzZ3AzbEx4YnN5K0NvaW11YmpMZzRt?=
 =?utf-8?B?aExXYUZwUE1BSGZkV0RoRGJPT3c1RUdhOWEzTThCNzQ3dW9UQ1VLb3g1cVZl?=
 =?utf-8?B?WVg2bmludkx4MjM1NTVlK0gwTkFCbHJEUXZkNzBCbTBkYUMzRXFpbnU1YnQ1?=
 =?utf-8?B?RnJhdWtoejc5Z2U1cVhCMStKMXBRT3RsZU5hZ1hEcnJJaFZ3RlRCbURyTnJF?=
 =?utf-8?B?ajVKVlBvSVRNVlo4TkxPSm1SV3c5QjBsc1JuTTdkaEQwWnFIV2haVDhyWnlZ?=
 =?utf-8?B?WFkzSm1NY0dmZjFJU2xCakpwYkdQT2hXSG9WNUY2UFZsMmJFYWdwS25VcFdh?=
 =?utf-8?B?MWo0eER4eVYraGlqZ0NjMDRwR1gxRSs3bnI5U1pUWkNOZmw1TmluTEtISk9s?=
 =?utf-8?B?TnFQOVBtekVMNVZtSTF0d24vdW5LUllqTGY4YmxoWDNoWkcrck9keTB6bUtt?=
 =?utf-8?Q?JaON9OIHukM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cFhCV0F5THpXVUZDSTl5WEtpcERRcE8xcGc1Q1ZjMXBrVXhwS1lWYjZhMXRP?=
 =?utf-8?B?Y2srbnNGVk5FbWIwYlJtS1NkRVFENGZ2MGE4ejNlblFlT04wMXNhaThSQVl2?=
 =?utf-8?B?d2YvbnN3bDFTMlJ6Q2ExR2dkV0YxMEcveXpmWkZTV0Q0ZGVXLzRRY3VJV3BR?=
 =?utf-8?B?OG1SaXhUOENrRGVuZEhNTHlYakRReXhkMFdSWE52RDkxSmNFV2h0M2tTZkNN?=
 =?utf-8?B?VTE2ek5qN2RsbTJ2b1lJYXRQb0I4U2hiUXoxV0JSL2RPenBvNWpNRFJmY3NM?=
 =?utf-8?B?UktaVmNYcHdFY1NVcC83TVBYWStiSlpjM2dwVEpKNDVVRC9Bc0UwTGg4NEpj?=
 =?utf-8?B?TkFNd1FBSHlxT042bnp3VENyamd2U1p1cHpWcXNxNHNtc3dQaGZlc2xjMU5F?=
 =?utf-8?B?elJoSGpCUU9hcWVxNkh2SW03NUxud3V2bmt4aFg1dytyM1NVRWxGMVp5dHFN?=
 =?utf-8?B?cTBtaS9EWk42UkR0a0VWTVRxVXNoTWNZWGEwc2o5b1hTWFBIT1VYVzhockVE?=
 =?utf-8?B?M0xuRWdIeGFqNk5tZXMwa3IwNy9Wa1pRTlJGOGFRUjB1aCtJZGdrcXlpSlc2?=
 =?utf-8?B?SDR3MEkvRnJLMVRIM29Ed2dTS2Q2Z0xsRnp6dWttL2I0TENVeW5IVVJHcExz?=
 =?utf-8?B?OFlkeVV6MWU0NEtYcGxlVGRvQlRSYld4WDNsbWM4Q1lXWUd1bjhhcHdrK1B3?=
 =?utf-8?B?d0F3REFvaWduQ0FTcmE5bVBpYVRjRmt4ZEx1TnhndVUwT0F2L2xZaFUzV0s4?=
 =?utf-8?B?anl2dGNyOG5QNXpKNkFRR2hyZGxrT01held4dmFGcmtTMjNTQmhRU0dmOEJk?=
 =?utf-8?B?ZWJuZDJhUVJBc0l4N3dFQmZSODhlUHVudUNaWXM2UEUxY0JYWUxKa2FmK2ZL?=
 =?utf-8?B?c2J4YW52YnVWVXR2OVVnaUxzU0lnQ2gzTVN5eXpGV25sL3pTU3FsL2VPbmtS?=
 =?utf-8?B?MVYvbjlHbzZGQkg4RTBIdnZFRTZHRDJFN3Flb1ZCVjJ2ME03T0dtTGpPUXJq?=
 =?utf-8?B?VVkwYzBpY3p2UktzeWlWYms1WXZOT0dxVCtyMFdNSzBPY0hWYnIxZ0NCcWdC?=
 =?utf-8?B?K1d6NS9rMXkyWWllV0MvMW5IOVlwY203V2wrdkREbjVWNXROZXpON0lPTHVF?=
 =?utf-8?B?MWNXSVpsU2ZTcVl0Y09OaVBlS04xVU0vOFkvTGUvaXNSRkxoQ2hyZDhVSWFk?=
 =?utf-8?B?VnU3YjJlaFVvRzVPM216emNsWFFxakdhbGpGNTZicTF0aUIxTWFCdGcxd05i?=
 =?utf-8?B?RnI3bjd5WCswTXZqVHE2RitFYlQ5bWRDUHFveDFYTFM2VFN3ZWJ4THVaeUM2?=
 =?utf-8?B?MWsyTWIvcEVidVdRbjZSSXB0YnBHMGFWTWMzcVVLRzBBLzNzaUJNUXdLSVIx?=
 =?utf-8?B?clhlTjFSZ0JOYWVkMFY3cmtneHFUU1E4Tkl5T0tHcHJoVlQ3bHB4TmluVGpB?=
 =?utf-8?B?ZDA3ZnllTWUyKyt0WWFCVW5zUjkwMVJJQjV0aGRtQUk4T3dqa1pFMkhlRWo3?=
 =?utf-8?B?WjJIa3pIYmlEYmRRZ1c4allnUjFRdU9TV3ptVkVVaXZJZFY2NmEwUEhrTjRV?=
 =?utf-8?B?ZlgvdFM1NXdqTVRJNWF0RGdJNHFoTStrcHRIWG9rNDZ2R1I4MVRTdFpHcmdm?=
 =?utf-8?B?aDVRTUxxZVdaamFyTlFXbjhJdG5PRU9kc2NuT3FNc3M4NEkxUzYydTkzZEhs?=
 =?utf-8?B?TElXT0pQRHBJSFQ2L2JleGRHWlJ5UEd1ZmhYUkE4M2FVS2p1QUw5TlozczVi?=
 =?utf-8?B?WTVmVG9QbzRLYlhtcHQrQnlsTU83c09FTi9xM0p4NkNnSzc1OVpPUzV1dDM1?=
 =?utf-8?B?K3dzdnJpSGZEZG5oM21vVHdiN2xBT3dqdFlVZmN1MnlSd2FsL2hBN3RSbjZj?=
 =?utf-8?B?eXVic3U5MWFONkZJSk1GZlpFNldmUjdxWDBRTFRpRm8xMGNVRFRzMlhMRXFQ?=
 =?utf-8?B?aU9LNGRNRnZtZ0FIeHEwZjdHWnlTV3NVbGY5dEEyU0pZRXhtMml0Z3k2cHgw?=
 =?utf-8?B?c3FsSEhJQkQvdTdSTkhkZm42emdpYWVMRlFSYzhkbGZOY0N5TUt2ZU42N0VD?=
 =?utf-8?B?dklZb3pBRmFEZFhQekw0Q25INUJVZk1ncjJwUEkvbVRvZ2M5cU1IcWhVQ2h2?=
 =?utf-8?Q?sqkFc+tiLwyhyER8wHT/ZlgCa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cea251a-9aed-4710-1a74-08ddfb85b1c2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 16:16:18.9500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yrcC4MN7IH762MUxkUMiYSVw9lxw+xWrCc9ku48Y14nOMvV86YtFzl2lnGdg2JDuU2JN43VI2Xfs56kVJYSLSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8086


On 9/18/25 15:35, Jonathan Cameron wrote:
> On Thu, 18 Sep 2025 10:17:35 +0100
> <alejandro.lucero-palau@amd.com> wrote:
>
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> CXL region creation involves allocating capacity from Device Physical Address
>> (DPA) and assigning it to decode a given Host Physical Address (HPA). Before
>> determining how much DPA to allocate the amount of available HPA must be
>> determined. Also, not all HPA is created equal, some HPA targets RAM, some
>> targets PMEM, some is prepared for device-memory flows like HDM-D and HDM-DB,
>> and some is HDM-H (host-only).
>>
>> In order to support Type2 CXL devices, wrap all of those concerns into
>> an API that retrieves a root decoder (platform CXL window) that fits the
>> specified constraints and the capacity available for a new region.
>>
>> Add a complementary function for releasing the reference to such root
>> decoder.
>>
>> Based on https://lore.kernel.org/linux-cxl/168592159290.1948938.13522227102445462976.stgit@dwillia2-xfh.jf.intel.com/
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Either I was half asleep or a few things have snuck in.
>
> See below.
>
>> +
>> +/**
>> + * cxl_get_hpa_freespace - find a root decoder with free capacity per constraints
>> + * @endpoint: the endpoint requiring the HPA
> The parameter seems to have changed.  Make sure to point scripts/kernel-doc at each
> file to check for stuff like this.


OK.


>
>> + * @interleave_ways: number of entries in @host_bridges
>> + * @flags: CXL_DECODER_F flags for selecting RAM vs PMEM, and Type2 device
>> + * @max_avail_contig: output parameter of max contiguous bytes available in the
>> + *		      returned decoder
>> + *
>> + * Returns a pointer to a struct cxl_root_decoder
>> + *
>> + * The return tuple of a 'struct cxl_root_decoder' and 'bytes available given
>> + * in (@max_avail_contig))' is a point in time snapshot. If by the time the
>> + * caller goes to use this root decoder's capacity the capacity is reduced then
>> + * caller needs to loop and retry.
>> + *
>> + * The returned root decoder has an elevated reference count that needs to be
>> + * put with cxl_put_root_decoder(cxlrd).
>> + */
>> +struct cxl_root_decoder *cxl_get_hpa_freespace(struct cxl_memdev *cxlmd,
>> +					       int interleave_ways,
>> +					       unsigned long flags,
>> +					       resource_size_t *max_avail_contig)
>> +{
>> +	struct cxl_root *root __free(put_cxl_root) = NULL;
> Nope to this.  See the stuff in cleanup.h on why not.


I guess you mean to declare the pointer later on when assigned to the 
object instead of a default NULL, as you point out later.

After reading the cleanup file, it is not clear to me if this is really 
needed since there is no lock involved in that example for a potential bug.


>> +	struct cxl_port *endpoint = cxlmd->endpoint;
>> +	struct cxlrd_max_context ctx = {
>> +		.host_bridges = &endpoint->host_bridge,
>> +		.flags = flags,
>> +	};
>> +	struct cxl_port *root_port;
>> +
>> +	if (!endpoint) {
>> +		dev_dbg(&cxlmd->dev, "endpoint not linked to memdev\n");
>> +		return ERR_PTR(-ENXIO);
>> +	}
>> +
>> +	root  = find_cxl_root(endpoint);
> extra space, but should be
> 	struct cxl_root *root __free(put_cxl_root) = find_cxl_root(endpoint);
> anyway.
>
>> +	if (!root) {
>> +		dev_dbg(&endpoint->dev, "endpoint can not be related to a root port\n");
>> +		return ERR_PTR(-ENXIO);
>> +	}
>> +
>> +	root_port = &root->port;
>> +	scoped_guard(rwsem_read, &cxl_rwsem.region)
>> +		device_for_each_child(&root_port->dev, &ctx, find_max_hpa);
>> +
>> +	if (!ctx.cxlrd)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	*max_avail_contig = ctx.max_hpa;
>> +	return ctx.cxlrd;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_get_hpa_freespace, "CXL");
>> +
>> +/*
>> + * TODO: those references released here should avoid the decoder to be
>> + * unregistered.
> That is an ominous sounding TODO for a v18.  Perhaps add more on why this
> is still here.


With Dan's patches this makes less sense or no sense at all. I'll remove 
it if I can not see a reason for keeping it.


Thanks!


>> + */
>> +void cxl_put_root_decoder(struct cxl_root_decoder *cxlrd)
>> +{
>> +	put_device(cxlrd_dev(cxlrd));
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_put_root_decoder, "CXL");
>

