Return-Path: <netdev+bounces-163620-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 813F9A2AF54
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 18:49:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0783B16053B
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 17:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF88216DC3C;
	Thu,  6 Feb 2025 17:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oATVwoet"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27CDF18FC8F;
	Thu,  6 Feb 2025 17:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738864150; cv=fail; b=TIw4qPC5w7F00GD8zqWDeYWhl1C9VEhlU06fiyMWSuFwdbKUpXoeHR1KIThAdUNUYoGaZjsNsp6O9mEv3MO9XbrKTNTZ0Gz6ObJqAnoHGq9paITLlwKHVz7SSRrspyie6QoQ9Kwq7nDgh0fnmk+j/ZpwyWUOJDY5Wexu3NZmrSs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738864150; c=relaxed/simple;
	bh=g1TpbxIpC5BOXXephW3UEh8+91bvVr+7XL1ERd7I9xQ=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RWE7m1MrPNEvZMATW3mXQIGsUXwp+UAKJnT2Y1R/5RTbp3cAO9QEFQXczpk3u4VYn6vfQ7zAADwkGCmUDk+9ydZWbWevBcead+9kHCjXaTD1LPe4ylGt5OnMhZ98XyNndvn77puAAq7ffHhfRk0iJdnYXWmbG7HY/StvmQ89z9Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oATVwoet; arc=fail smtp.client-ip=40.107.237.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JOFYJj04LGCHdaM37I5aRiSV/fYeu6k4dsqdidXUZpfz94w2C83KO+MBUdttBeH9b3IPPljdV1q1VMa4yi/A4ZsrZbvUSicZih9m8EStn4lnqTooWGxwIkFY790X03gLJoNH6/SjS3cboAzxQid3JNLqstmOaRh/eHIiWTw/Tfzpv7Qv+aVGSilOCib1SsMpio5PzRATsiP5nQVYA1y81lozVNe9a6KOWrzhuClTsmrUbXoDlZOMJnbeSvfgkSiY+TAl4RJitIG5r/J1meE0Yfd6Jf0Hs05Rlh8oB4cvQpltuPXEYGdLlgGR6kNF32SDxj4o86C7Kawo7D+7n/RODw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zMVt8rzSuY7ziLyw+duaa1AwJ6WlBVaW0rbQd8YMCww=;
 b=C3CzI1UzqcxkC53qIM4odATCktWbyAVfmzR+XS1ZYg1NbEBA2/TQsFbkP2C03vIr1UbDEkIKpMZP3fUlMOrCdwRraW4BExMhAJAwR6AqMB1/CIWF/DRdSgolPcS6fXzLkHhn2MmdhtZ+g+f53qDadqAFyjwXrVW8JA8Shq9Qod/00Vo+fCnv5evA8s8KnlNAuceje5iUpZ1RbODmEM73UPZKASWM18g+cuYn6bFvMOaOCWpuwqXh2FBHAl1wXtT+PLk6c4gTHLj/Es599529iocLQeTHNhs7Hy1B6zapzaJmUy20AKW8uLfuEtw0sF1J7sTq6qSCiMprjf+Y8vYdlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zMVt8rzSuY7ziLyw+duaa1AwJ6WlBVaW0rbQd8YMCww=;
 b=oATVwoet1Y1lLrKusKDiZqdbgoyv+gOmhrsMHFFBJl5sBMyU6Us8bzJH15sxSRYU5gtFB8p1F2r0YVb0v83KNz3ZEfIU+qwBdetut/EXiwNqng0ECEhoNowzHiOtt4UfOWwWeYJwhvZqQ/6a+/d5kVcNFPrcE3cj7B+7gMLUv7E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by DS0PR12MB6559.namprd12.prod.outlook.com (2603:10b6:8:d1::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8422.11; Thu, 6 Feb 2025 17:49:06 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%6]) with mapi id 15.20.8422.012; Thu, 6 Feb 2025
 17:49:06 +0000
Message-ID: <16f4a5de-2f54-4367-9e14-b7a617468353@amd.com>
Date: Thu, 6 Feb 2025 17:49:00 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 03/26] cxl: move pci generic code
Content-Language: en-US
To: Ira Weiny <ira.weiny@intel.com>, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com
References: <20250205151950.25268-1-alucerop@amd.com>
 <20250205151950.25268-4-alucerop@amd.com>
 <67a3d931816f_2ee27529462@iweiny-mobl.notmuch>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <67a3d931816f_2ee27529462@iweiny-mobl.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: JNXP275CA0024.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::36)
 To DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|DS0PR12MB6559:EE_
X-MS-Office365-Filtering-Correlation-Id: e305b34b-7ab3-4098-2bc4-08dd46d68cc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MHY5TnRWSzRsZWxLNkNCSkp2Ylp3ZGNrcUxSU2ltSmNadDNyaHJtbjFvMGd3?=
 =?utf-8?B?cTFUcytCNVZtYVlaVWpkcjNYTTJwdGtTQTloU01xV0ZiVTNuU0taajR1TEl1?=
 =?utf-8?B?ZUZGamJ5cnpFRnRUOWpRQkNjL3YwcE9CTE50bjhBQkU5T09WaUp2TkRvSVNM?=
 =?utf-8?B?cTZUcDd2aEFLeTF2OVpwTlFsN3o4b1ZMQkdMVzhrZWcxVFBCWGNXWDRsTmlU?=
 =?utf-8?B?UklYWExMV2VSVEJFK2VwQjNJclJZWG0wOHRvTkZTbHJ6eUgzZEVMWXdqL2VF?=
 =?utf-8?B?eTFxUW1kYTNIMWF0c0ZlRmNlaWt2b0t6WnVZUWFQZmtCbmtXYWdsbDBWLzRr?=
 =?utf-8?B?by9CUGdJYy9LT3I3a0RER083bWZ0aHdZcVpiV29oZzJET1h6bmN0Q2pHbXM2?=
 =?utf-8?B?M2pnQ09aMUF3QTA4WThDNFJuZE5MalN4Ymk5Y3hxdVpJb1ltMDl3TEJKNHRm?=
 =?utf-8?B?ZmJqME1LOVZ2eXVHU004Z1BiRXRFMmVPQSthSXlaaWoxQ1hNSmdEMUczcENM?=
 =?utf-8?B?RHM2TFpkQ1BrSWhTdGRIdGdHY2RZLzVOSjVyQm1VeFd4YTNObnN3SDBRK0pk?=
 =?utf-8?B?ellrN01JZTk5a2tnUkp4blpFekpqb3h6TjM2V1VmRDFOZ2dMYWZIRkQ1M3Rj?=
 =?utf-8?B?dENtNzhPZUd4UTc1UmxqZGdWQytJYUpreVRiV2JLRkJkcEFMNE4zVFN4b09w?=
 =?utf-8?B?WGZUQ3VJQ01IWHBWY0RQdldnOWRpcUEvcmJxMHgzK1BJc0xDckdHOVNUL0tF?=
 =?utf-8?B?ZWxqRWVyZk50ZXJxMitsaWFqUTlnVU4zcndMR1FzRnZ5QXl5ekF6Z0VSck5F?=
 =?utf-8?B?bmo1dE91eHlySU82UVg0dk95RDN6anByM2JtbnE1NE94aktHSm03SlB1T1hx?=
 =?utf-8?B?TTJPd2gxeFgzZytaOThnWnBoaFIxTlRMeW9XcktFbGMyN1lHWkMzNVpScGVF?=
 =?utf-8?B?UWtodHVBRjZXUnlVaURFVzBFRWlMMHBCNDBBYm1KNXJMdUhqeUZwQk4wanNI?=
 =?utf-8?B?aDMzK0JHbUh2ek9HOWowYThqc3VYRERtVTIzTnNKSUY1emxKY1Y0cGNGMU0r?=
 =?utf-8?B?Y1RUUHZON1lRTGFQUW1tMG1sNHJRYTJNaUJXbHRBN3BkZStYVGNFWW9EamVl?=
 =?utf-8?B?Z2I0NS9WcU1hd1E2K0Z3cTA4VFFvWE1Sc1piNzhCNnpaVGo2QS90eHlISVM0?=
 =?utf-8?B?Y1dxMUtDdGUvalQyTFlXdFhDR2dRcUJzT3hFSk02QTNjMXYxSkN6ak1jVGZz?=
 =?utf-8?B?VFArNVE0Nk5pL3phc3V2RGY1QWZRbCtYc1pqME50S1A5akViTkZ0Y1ExeXk1?=
 =?utf-8?B?OWZOMU9GKzQ3aXBOek1mbmpZRkwwcTdGeWZ1cVpVaWJYS09NL2RGSFZ3VTdz?=
 =?utf-8?B?N1huc2xBcCtZUHJOeUQ4dit5cGVlbm5kemQ1RUJxTVVPZlV2dEdsNXRTSzFS?=
 =?utf-8?B?eGV2NXpYa3lJanpiV3E4dG9lZSsvTWpmemhQbTd0ekN0a0htaStJV3RoRER2?=
 =?utf-8?B?M3J3NE1pRnVIU1pHZzRBenNZVkZ2UytrY3FFYkRndnBnNnprNUxQMXZ0Ymp0?=
 =?utf-8?B?TGhYQ0dML283SG1kb1d6eHJZUVluV1ZIUzh0QmFWRzlTVTd1REhUUWNaQXdT?=
 =?utf-8?B?WWVkS0dnVUdUQjVZWWI4dmtxb0N0bzladGRyVGxhVzZITFdReU5sSm9uWWFB?=
 =?utf-8?B?QW1iRG1xRURuQm56ZmZqZTBiVFp1MXRHV0s5cXlMMkFTOUYwUFFJZlBlZVdj?=
 =?utf-8?B?U1BxSjVnNTh0bENaYStQVlprd3VnVFd5NUFQR2pwamhoN0JLWEd0WTRDRVF2?=
 =?utf-8?B?S3ExbXZ3eFYxUUNFNWhRNTRJYnhrTW1NVVRhcWM5ZUpKcnQ1bDZVYmljeGd1?=
 =?utf-8?B?MjgzSGhzMkI2QWZkYWhmOHJXOEFtU3ZMRURzZXV0ejM2Vi9tYlhTZ3pmQVpU?=
 =?utf-8?Q?FT/PYCKce1U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ekYwQ1hNWm1QbnJUWXdDdDRNTE1QMlg0MmQrMVByU1lLRElMZ29Za1k5NG9O?=
 =?utf-8?B?d3dXTlRTanlEQ25YT09ucnhEcGJacjRtRVJjQnowbHo2T0dUaVdkNzVBZCsz?=
 =?utf-8?B?WllLdG5GRzF1cFhxWjNNV042MnhWc0NQalZKaUFoREIrRzV6dTFEVEF1MlI4?=
 =?utf-8?B?RURLcVpSS3FtamxWcHJQdXVlM21YWFAwTVQvbTd1L0pCQnBGdGpuWSsxdWN0?=
 =?utf-8?B?QXlJNHRoMGN2UGFFeWZGU0J3VU05NE5BT1pVM2l6NGdSWlNtdEhaNjhFUFNU?=
 =?utf-8?B?Q2ZTRi8wTnY3ZmdJb3o3Tm1IZ0NHQkxwdXBtWXhvUHFiNFJWSll6YnliNGtK?=
 =?utf-8?B?UmMzUUs4djJHS09oc1RjRFVsWjAyNmFSb0xZMGYxV2FLU2ExS2MyZk9qTlVq?=
 =?utf-8?B?MEpCV0lMUEw5c3dZUGQvK1MwbWM4UHF0ME51cVJsek1SYnBZN1RrVXJ6MzZy?=
 =?utf-8?B?WE80eDlwTUd5MFpVUmh2T2J1LzlJV1RnbENRczlmaktHNzh2Y09ScDdJVThn?=
 =?utf-8?B?NXYvaE9tQzNpY0tiNWZMeC9RUHRRd3pMcDR5YVJaVkdyRCtSKzR5dEZNVlhu?=
 =?utf-8?B?a0p1SDZZN2lDMlowaU5HTGRiZDdoaE9ldFE5MlA2MXFVTUVMc3JZUnBJc2g0?=
 =?utf-8?B?SmJTRng3S3MwSkZ1VkZ1K3JXQ0tJTFJUdFZCV043ekxLQkNlVElDaVNYUU40?=
 =?utf-8?B?cmg4bm9VZGNaNi9wTjdKT1JDR2lid1JPZTE3eWMwSG9iVHZQeFJuSUljNWVr?=
 =?utf-8?B?MlRrYmt6cXY2dTJmRWtHNmRCd0RxallMMEZ3cCtiK2tpZHR6dVhYNm1OK3Nl?=
 =?utf-8?B?TVNKZnBCd3VXeGtubkNWMzFrdWR0bDVhVkhPL2lPOGw2YWNTNzJvWFlNUnM4?=
 =?utf-8?B?MTUvaDI2N0dPc0FyRGhKK1Arb29JWDdVM2x6Ump1K0FuajJDSmUyZ1hpdmlP?=
 =?utf-8?B?L0UzRW5iRzhUUXc0QmdJNm5Dem5Ga3RCYUFZNWxGc1JsenVMT3M0ZFc2V3Qx?=
 =?utf-8?B?dlJGNFo0cnRIK1p3VXc4SkRlUUlacmFJV1V5dWNERks0SllYUmRYdU03dmxw?=
 =?utf-8?B?TUZCbkx1aFNkTEl4WGxFV0MwMUFob3FHaXZMRjduNFJBS2huM0FZZGk3OTRk?=
 =?utf-8?B?RWFlRHdqVTRObmVtVnFsVThTbVo3M21ORzN5S1FYTHRLeU5FWVB4b2wxKzVn?=
 =?utf-8?B?YUZRSFVUVm9SWkxBTmFJUkJpTHpHQlFmVjZrYWJwaktYai9NVzJtVlZPVm1N?=
 =?utf-8?B?a0lZYVYxbDBhMFRSU1NiV1UvbG5LUVZ6VzUrRjRuN0VreGtJU0d0QUl1eDRi?=
 =?utf-8?B?UTBVZTNmdTJjMEo4MjI0b1ZCNkJCM2M3elVTZ3htaG1oYUxtN05RV2d4bHZW?=
 =?utf-8?B?SlpPR2J1di9xM3ZLcXpRWUg1Z29sTW1hemVyOXZKc1RMSlJvblRJZHg0ZStU?=
 =?utf-8?B?WE1SeDU3bHpJU1REUG1GaXNPRHVRZjBxdFVvclRUQlV2d0dOVXpsbUQzTnlx?=
 =?utf-8?B?TEJVZlVoWURYcUhLRG1URDYxRVI0cEFXWEhqbGNkYlhkYlNyYUpCVEEycFpU?=
 =?utf-8?B?Nk52bks0Y2NuMVpkNmFNS01iQ29zOUtLSDg3VmtyTmNHWmNZZVZkVzI0Z0N1?=
 =?utf-8?B?dVdYZUpPK1lackczdXhCaGVrVCtKVGFiaEJoRjhMZ0xNNE1MbUwvaTgyQzR0?=
 =?utf-8?B?MCsyQ2lHUDlLaFZWbzRwamQwWmNnQWg5Ry8yU2lnMms1UHFjYzUwaGsvMkdO?=
 =?utf-8?B?ZXY4VE9mb1hHdmsxL3ZkUUFMUGUwUzlDcktzTktSUkxmN25uaVRSbjFTdDVR?=
 =?utf-8?B?Znc5K3orWCt5REx1UlZHNldwbXluTUF6Y3UvMm5hWUd2cWd2NktldjBpWVF0?=
 =?utf-8?B?KytNV1VlcnN3YXNEZEFOSTFhenp2Z0J1NXZuVnhFYUsyTjc3amRjYVF4eGxq?=
 =?utf-8?B?NEJaZFVzYVBXQ0JDVk1uV0txdEtQdkxyOGNzRzBsRWJBRDlWaWw3ZXFuSFdC?=
 =?utf-8?B?RHRhTlJvM2VFRHlaMnIvSWVyTFhjQlNGSEpkSWgza2xJZThsR1FhYlpkTEtO?=
 =?utf-8?B?MHE2N3pMakE5UDNhckdVYWJ4Qkk0emx4dW5KRUhjNC9rRnZmZGYwZ1o2MkFq?=
 =?utf-8?Q?NV6yxxBmzvBxynFYARZ8MEa/C?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e305b34b-7ab3-4098-2bc4-08dd46d68cc5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 17:49:06.0069
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ENhT6KLIR2ZOsff3632SNqpBLTC5FBnWYp6c6bHGXGKZgC7GddynAedzVbU4MLcT3vU6TVKf9iCOveoqafaI6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6559


On 2/5/25 21:33, Ira Weiny wrote:
> alucerop@ wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
> [snip]
>
>> diff --git a/include/cxl/pci.h b/include/cxl/pci.h
>> index ad63560caa2c..e6178aa341b2 100644
>> --- a/include/cxl/pci.h
>> +++ b/include/cxl/pci.h
>> @@ -1,8 +1,21 @@
>>   /* SPDX-License-Identifier: GPL-2.0-only */
>>   /* Copyright(c) 2020 Intel Corporation. All rights reserved. */
>>   
>> -#ifndef __CXL_ACCEL_PCI_H
>> -#define __CXL_ACCEL_PCI_H
>> +#ifndef __LINUX_CXL_PCI_H
>> +#define __LINUX_CXL_PCI_H
> Nit: I'd just use __LINUX_CXL_PCI_H in the previous patch.


Dan suggested this change.


> Ira
>
> [snip]

