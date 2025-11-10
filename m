Return-Path: <netdev+bounces-237169-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D9EC46744
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 13:07:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C27D421027
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 12:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A63BC306B20;
	Mon, 10 Nov 2025 12:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Gq0tjR+G"
X-Original-To: netdev@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010002.outbound.protection.outlook.com [52.101.85.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8003C2FE585;
	Mon, 10 Nov 2025 12:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762776278; cv=fail; b=tU6bf19LTfHdEKA8pKJA9Rqr0fMCzyr60OOtzdMBeN6qVv4plQBeMK+iEVYB+WKtWYrlbAvSV+PLh4Szj71fESsdD76ISmHvKTmx3AcgIXJyHDE9zPEGfRbeh/K/xBJZ+a03aGJJXn8LwVnLA8TXsMcswAvCzCy9991coZmahV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762776278; c=relaxed/simple;
	bh=uVBEKjjPDTHVCF05kAsGfhpN4dCfbGhSGSwwk1qz/h4=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cSZFOwktH66f3fccOi+nltLKgcXyNR9724L+zO0B7EsnnrLeNSpS4pdo7ojWKnGBdimtOGGy9Dg4GrxdqCUsjOQXTP7cEbP6juokG04JfptavCFOyVttKrswHL3032SVVbGDwajlDa6Zmo3bVc2bjBcfhFBSrPqewLXbnNjgyWk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Gq0tjR+G; arc=fail smtp.client-ip=52.101.85.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ixtsi1rjVK0EpRObPgeS7WudAOS+eBoffzNkYL8GB1nWMe0m8QKq9VJVvqClap1XEEZXDFrWB/wW0eEhRV3Pm3mhXHs5XAjclNgF6ynRb1vj87Y+d+Le/dtxBEOcaGTiTYqELbdT+7ZiOMPv0y17X9yzAkomNOmlrciTD2HzsRRAHekGGEHDRgDSLkZ+3Rw0BXR273dXf7aGk7ocK2cWPzF3bhJisCsg7iwDT5uzakkDiO8LV4iVMuuiqHfAXJXY3FJXBMeAaZILlDwT6ruppTi1WqdkHXurBAVsm/GerIR6XcXPA300I2KYG81ICVR+Q0nTlNA8Jrl2QU05tCOQzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1NOzjiaNmzZ8CnzbkuUKG/nafaSmudItqvDmHkSGBM0=;
 b=XZr2b/9507cQlgnOrg0iFJrMBv4UoHNIjREPTxon6MVVdYPYpJ3Wz1dY/XVksPtZJDsoTplC10/TUuGzaENejvUeDv6Vnrasxl7WEAtGjBY3oEeZLBU7fhovxrCHVsE5KHizDOj0AzyhE4ENdx0zwg0KRUPxcd6NxCrRTdTn3ZEDKgRtQ10kdksCZtlLfseWY0VxRtKeVs9ibV/q4CfD8OR9IRMZhz4sczmzIB2EDJ1ZxtDnMqPkmtJ5QS05lPyKayZl0do3+lnpXWxzMCuXN2m8yb0Ab8s345O2o5zacAhxFNXxk4ikGhszph7y5qwdwWmt4rRbW4prX80glDUBUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1NOzjiaNmzZ8CnzbkuUKG/nafaSmudItqvDmHkSGBM0=;
 b=Gq0tjR+GflRFL2ejP4y/i2xd/p7dKvZwihflohYnkix0K594+D6WnaWjq/KyIfKQ9EP+AzJT8L/z0NTAs/cTi2PsPqGqG005xYj4qc+0canPoGDvgdSh+LxK9YS0S5CVkPOJGq4z3RgaBMFrp+kWIvgR+MXe4qWtjUqqtBKrmeY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by SA1PR12MB9004.namprd12.prod.outlook.com (2603:10b6:806:388::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 12:04:34 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 12:04:34 +0000
Message-ID: <2ef6624f-f1d3-4541-81a7-b6b5060f2e49@amd.com>
Date: Mon, 10 Nov 2025 12:04:24 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 13/22] cxl: Define a driver interface for DPA
 allocation
Content-Language: en-US
To: Dave Jiang <dave.jiang@intel.com>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, dan.j.williams@intel.com,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com
References: <20251006100130.2623388-1-alejandro.lucero-palau@amd.com>
 <20251006100130.2623388-14-alejandro.lucero-palau@amd.com>
 <e7b2ff72-5367-4493-8bbe-40c05b3de607@intel.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <e7b2ff72-5367-4493-8bbe-40c05b3de607@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AUXP273CA0056.AREP273.PROD.OUTLOOK.COM
 (2603:1086:200:1b::11) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|SA1PR12MB9004:EE_
X-MS-Office365-Filtering-Correlation-Id: 22f21d6f-6d26-4a46-3d25-08de2051500e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cmcySnpoUzdBbE1JN2J5WVgxNUY1MGs4bGtjWURtalFVa0hPNnFIM0N0V1g2?=
 =?utf-8?B?bUp5T0I1REFZSUFnMEY5UzFRVmFHUzUvL0xPcGNpamt2ZDFDdzJ1Q3cyZmJk?=
 =?utf-8?B?OXJvUkVldnpTOWpSeWZzK0lpTGxaZkJzZUFINFdVSi9UdVY5N1JmME1jaEp1?=
 =?utf-8?B?WXNHa3BmaENBSTc4WmtLN3Bacm5GMUxaL2xhcktxQUVQdkZ6NkFuaUJpUS9R?=
 =?utf-8?B?MEJwaHNvSWR5ZWZ1K2xPLy9YVDhuSG1wMGVNZlF1L3hUU1lBYmszc01OU1pZ?=
 =?utf-8?B?bFVLMWY3UnN2R25UTVZIVmRtWDVsUks5MWhFMWRhbGk1TG96Sk0xSFJaS0ZN?=
 =?utf-8?B?Z2lRS3RBZmxjZ3hrd2liSzJ4Ym1ONXdIY3NLakdRMG5qNUwrWXZEK0NTTVlI?=
 =?utf-8?B?c3hNQkw4ZGYrNkRjL1NaSmxENEF6bThCMFd2RjdBa0NDM3Z1ZzNiekJiVWIz?=
 =?utf-8?B?Qm9qWVFtNkxEZjFtZ2ZCY2hPNWdrQkVDZ0tubU1SMXl0TFNvNFZPMGFuWUpj?=
 =?utf-8?B?NmdlTjlJZnBMRk5iQnlVOTBlZHN0dVRiTk5kUUs1VG12Q1E0bytoSDNQbWh3?=
 =?utf-8?B?clNHWlEyWDRYbGNJQXkxUERSb0JNRjZFM1JzZE0vVVZQS1EyaGZGcXYzSVA4?=
 =?utf-8?B?aGxsZXdUYnhPVnhhZDlsZUVOSVVPbG5HcEUwZk1xeWprWEozOUlWenJjeFNS?=
 =?utf-8?B?Q2JoTy92bjM2WFhxM2xPZU1mUlZQaUpoRGRpbUpLTU5SdmlYa1ExWUlyN0pq?=
 =?utf-8?B?MDRtY09DWlZEajd1WktxTWlsUjFCMmtTY2EwR0krZzB5VE9kMjhQRzRhR2Qy?=
 =?utf-8?B?ck1mY0FzWERIYmdld0tYd0hETm02NHJUcHdlNnQzU3dsRzdGY3lHZWx0NTJR?=
 =?utf-8?B?MEtNOXk2dXpyOG0xTFRqVFd1aUEzYnE3VlJYSWYxcVdZV3NZZE1ZVmpYVWIw?=
 =?utf-8?B?M29PRWlINGliSUhZTk9pYkRhNlJyU2NsSDlhZWNFWFRacko3dlFPTm45L2Ru?=
 =?utf-8?B?ZnpDZ0dOSWdvRGxqSmVqcFpqUDNtUHNzRGdWYlVIYWUwdlR4bHd3eG9SZy9p?=
 =?utf-8?B?eWNpUERhYlp6Y2kwT2l4bFFHbk1XWU1pNUc5UTdBY2wrcHlCTVhhTzRhVEpP?=
 =?utf-8?B?RUw4VjVHMk9KT1JBTUxYWFY4VXlqTDhIL21LbTdUOW9XSzFrZnpndFdDRXph?=
 =?utf-8?B?Rm5HT3Q0Y3pMUnQ1S2JyQitVaWR2bXBQYVNlaWh4YnhZek1LVEl5QmVDM2tU?=
 =?utf-8?B?OFFOVkJ4Uml5ZXg0ZUE3Y1Nsa3F0d0NGWEFDTnFrN1ZVN2doYTBOemtIMXRH?=
 =?utf-8?B?bms3b0t3ZzRXaTV4VUtjSS9SZEw1dHFyMEtvTWxuNm9HMENHWS9VVFdUcWd4?=
 =?utf-8?B?aXkvS3ZYSlA2U2VCaVF6eHJTV3MxR0dqMlBsRGZVOGpqZjBKNDNLdWcyTmIr?=
 =?utf-8?B?enpXSnE4anFrNVVORzIybkpwUVQrV0hmVXlYZ0xtOGNnR2lMRDB1Y0RmS0t0?=
 =?utf-8?B?UmtMNWJNdmxMak5OZ2lueGtsS2hoTmY1WWcrTWNyUEo4cHBvanNOUjFyM0xh?=
 =?utf-8?B?UE9PYytmVjMvcmdUMC9RazZVZDhlWDFrclV0cTRiekNyRVFaMmFoSU0yVUV0?=
 =?utf-8?B?d3FQTVBlSXQ1WkZTLzJPc1VEYk9LRkJwZXdHZVM0aGdra25EUk1UTGt0TWxH?=
 =?utf-8?B?NG1jdmtiV1RGWDVKZVQ4L0xHV2V5c3A5QTVCVHF2WWNtV0I0N1lKbFdlNy8x?=
 =?utf-8?B?OXBvY2xkQjRzV2N6WU1zR280VGc3ZGhiMFZpZ3JXMVNLYVVpeUhtT3lCazl0?=
 =?utf-8?B?RmZCUFU3MkhnVUdsTSt6NDVzU2xxa1o3QmNBSjA4WlN3Y2puZVR5OFFPN3VD?=
 =?utf-8?B?Tnp3dmdHaW1wakQrZXlJSnlkQnYxRndVRklPUWJHT00zNmFhRVdTeUYwOTgr?=
 =?utf-8?B?UmcrMVFPRGtzWlB1ZDF3OENCTlg1NUdBUkxQbk9LeDFTTWRwbVMrZHcvVHVz?=
 =?utf-8?B?SFYyZFpPU2NFU204aEZESTl3Sld5cE1CcDR5N2NYOXZOVndDL3FTRXNsOE93?=
 =?utf-8?Q?Tx+36V?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SnhLS1oxUi8zRkx1YnZ5cTBCa29sd3crbUxKeGFUNzFyNGtILzI5UHp6aklJ?=
 =?utf-8?B?UjhEeUFvTzBnajZOTS9WcEZrQTdONVB1alBaR3NOQTlvdFBqV0lqOHBGMkkw?=
 =?utf-8?B?RVJyb09WcmhURk5sKzJhYW1HREdWN0hxbDZPV1NQa2thR1IvQ3BBZWJNcHNn?=
 =?utf-8?B?REIvTWpFU3owOElIWm5QNkwyeTQ0WU1ydXVwVlRtdXo1QWtYd2ZDZEp6Z3dy?=
 =?utf-8?B?WVk2cEF1d2dPNjJVU01lY1pUZFZ5NUp3eGZTa2R0dDBLN2lwMFlGK1RXdXIy?=
 =?utf-8?B?MFhGQTJIVXVDMHdBdng1OXZiWWlNcVhYQVoySHFDdEhkV1UwMzF6RFhHTkh1?=
 =?utf-8?B?ZXpOU0M2Q0s1aExTRkRhc3NKb2hGdWJwaDlkaWRrNkowNnF3cEs2Smp4Zm1Z?=
 =?utf-8?B?MmJmZmlvTUtTTllDYUFuUVpFc1NKWTNEZ2s3emZrREdSRWlhOWRGdGR5ZWhC?=
 =?utf-8?B?SklIem9YelNjUWJUbHp0ZTM5RUluRjdQNzBkUzZZUlJoRFUvQ0pKb2x0VW1Z?=
 =?utf-8?B?blBLQWhMbzFpNWMrSEh3QXdTY1NxQUptUS95M1k1eVNzeDVqT3ZES2ZocXFO?=
 =?utf-8?B?MFJIN0ZpeDBYYkRUSmxWTDkyTXlFdFVMUFdHWjRBMHNEb3EvNlN3ZWRtc2FP?=
 =?utf-8?B?KzVXR1FhZysrdUZ5UHlwM0RaYkRrYnZGOFBYVUNlUGZmVDhjcElOY1Y5bitw?=
 =?utf-8?B?UHFDMHpSbUVsZXBKWEJZY0UybjcyNnNDSFBLMm9UL1RqUnB3SXhJejN2MGww?=
 =?utf-8?B?V1hDY0pCMGE3OTB6TUlJRnFhMVVpcGNIRk41cVJlTzZnWG1yMm45Z3gzQldx?=
 =?utf-8?B?YTZKTWNudEVNbzFhRjEwV2grd1V0M1lDak00c2ZYeFpWeW4xOU1raWxjRHV6?=
 =?utf-8?B?dEJ5VzFMMmNmKzNFQVBITWg0ZC82ODI3TzY1OTdnZnpGSHRWODRleXk3dWdO?=
 =?utf-8?B?Uk5YaXN2NEZuUHJ2cFZBcUFMTnhjcE5vbmlUTWdWRUk0V1lDektEalF0bm1G?=
 =?utf-8?B?b1NhM0lQLzBYYkdlSE5pZS9pUlZtRS93OE9rSHErNmNkY3F3bE5naG5GeFdk?=
 =?utf-8?B?Q2JGWUpPMGFhdDhwS1VkazlCd2FTeHZML2pkRGhUS3BlSzI2VlEzS0dLTW5G?=
 =?utf-8?B?NHZOMEE3NEVRUllHckRmdFdRamR2YU16aExwUGp6bzN3ZldxZmkxRkloOGg2?=
 =?utf-8?B?UlgxQXY0S3NPYXJ6ZlFwUHBKQW5JLzBId3o2dkFCcVVDM3JrMTd6VXpZWFA0?=
 =?utf-8?B?L3JUQ280R0FkSTg3NDF3TUxZSHI4dHJ5eEpRaDNwZDBMU09SMUlpdHFHdkJq?=
 =?utf-8?B?SW1qeWVtZStCZ0oyRWM5Rmd4R3FXUUNwZmJuRksrSU80aEN1RE0yRzAva2th?=
 =?utf-8?B?QzE2dGdyNm9HT285aFRhaEVBRGZXaE1IeTBQM21kcFNFRzM5bTRYd09aUGNZ?=
 =?utf-8?B?UGRWNnNnTWRHNTNXWTVjZE1ybVJmbU95SlZnemtqbHFBL2JOWVNKTFRaL1B1?=
 =?utf-8?B?cnp5NGFMQ0Nsb1U3bmMrWG1SMUZTODdVMXJQdlcxOEhyZ3N4M3ArblBycFdC?=
 =?utf-8?B?d1BndUZlZXplM2xsREUxK2tNako2NmtBV1dyZXdpclMrdU5JM3JWTXZNRHIx?=
 =?utf-8?B?NHc0S0VNUUtmWWlKdHZKaW9MUUlPZWppQzNBdUZnZHBja292aUE4QkZiUzZW?=
 =?utf-8?B?YkJwV0YzNWZqYzVFdFUxSjRDZitQQjNESWlUaFkvQWxxQVZIS2prKzVlaUtL?=
 =?utf-8?B?dWtXK0p5Snh5S0ltTUZwdkRoMk1QTzVBdm5NRWN2dnRaUjRRZ0c2MjgxUnlw?=
 =?utf-8?B?KzZEcnIwdGhHaVJOcGRFdlZRL0MrcXFpUm5XUEpDZGhSY0FoQ1JRRjFJdW5F?=
 =?utf-8?B?cGNJRkhXaFY4VktwOVNENm1ndHVNNi9DRWlsNTRwUTFlRGl5YWR0V3FUQ0lw?=
 =?utf-8?B?UXc4dUIrL1MvYTN2bjFYMllGYmNicHA5dXNreGc5YStUWnpJbDJBaFdxcW9y?=
 =?utf-8?B?dng1cE1Jb29HcFlRU3BVbnNnc2NVV1ZRNjlIN25XalBuY1RUWmpjbWRWTy9n?=
 =?utf-8?B?eVlCK3pPdjdtTkVkTWdYWGIrNjZPeDYwQzM2Tnc1cEFxbnd5cGRnRGY4bERu?=
 =?utf-8?Q?5tkA/Gaurrz3nM2qshk6t9I0M?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22f21d6f-6d26-4a46-3d25-08de2051500e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 12:04:34.2241
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WuAX23yHmEpgLBDjyekLQBbpn+hch8+f9zfdRP+E2gfg1QkFvwQRzO3s6RQHe2ul8i0u2Tl6Bfgtubx87qzUBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9004


On 10/15/25 21:08, Dave Jiang wrote:
>
> On 10/6/25 3:01 AM, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Region creation involves finding available DPA (device-physical-address)
>> capacity to map into HPA (host-physical-address) space.
>>
>> In order to support CXL Type2 devices, define an API, cxl_request_dpa(),
>> that tries to allocate the DPA memory the driver requires to operate.The
>> memory requested should not be bigger than the max available HPA obtained
>> previously with cxl_get_hpa_freespace().
>>
>> Based on https://lore.kernel.org/linux-cxl/168592158743.1948938.7622563891193802610.stgit@dwillia2-xfh.jf.intel.com/
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> just a nit below
>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>> ---
>>   drivers/cxl/core/hdm.c | 85 ++++++++++++++++++++++++++++++++++++++++++
>>   drivers/cxl/cxl.h      |  1 +
>>   include/cxl/cxl.h      |  5 +++
>>   3 files changed, 91 insertions(+)
>>
>> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
>> index e9e1d555cec6..70a15694c35d 100644
>> --- a/drivers/cxl/core/hdm.c
>> +++ b/drivers/cxl/core/hdm.c
>> @@ -3,6 +3,7 @@
>>   #include <linux/seq_file.h>
>>   #include <linux/device.h>
>>   #include <linux/delay.h>
>> +#include <cxl/cxl.h>
>>   
>>   #include "cxlmem.h"
>>   #include "core.h"
>> @@ -556,6 +557,13 @@ bool cxl_resource_contains_addr(const struct resource *res, const resource_size_
>>   	return resource_contains(res, &_addr);
>>   }
>>   
>> +/**
>> + * cxl_dpa_free - release DPA (Device Physical Address)
>> + *
> no blank line needed here
>
> DJ> + * @cxled: endpoint decoder linked to the DPA


I'll fix it.

Thanks!


>> + *
>> + * Returns 0 or error.
>> + */
>>   int cxl_dpa_free(struct cxl_endpoint_decoder *cxled)
>>   {
>>   	struct cxl_port *port = cxled_to_port(cxled);
>> @@ -582,6 +590,7 @@ int cxl_dpa_free(struct cxl_endpoint_decoder *cxled)
>>   	devm_cxl_dpa_release(cxled);
>>   	return 0;
>>   }
>> +EXPORT_SYMBOL_NS_GPL(cxl_dpa_free, "CXL");
>>   
>>   int cxl_dpa_set_part(struct cxl_endpoint_decoder *cxled,
>>   		     enum cxl_partition_mode mode)
>> @@ -613,6 +622,82 @@ int cxl_dpa_set_part(struct cxl_endpoint_decoder *cxled,
>>   	return 0;
>>   }
>>   
>> +static int find_free_decoder(struct device *dev, const void *data)
>> +{
>> +	struct cxl_endpoint_decoder *cxled;
>> +	struct cxl_port *port;
>> +
>> +	if (!is_endpoint_decoder(dev))
>> +		return 0;
>> +
>> +	cxled = to_cxl_endpoint_decoder(dev);
>> +	port = cxled_to_port(cxled);
>> +
>> +	return cxled->cxld.id == (port->hdm_end + 1);
>> +}
>> +
>> +static struct cxl_endpoint_decoder *
>> +cxl_find_free_decoder(struct cxl_memdev *cxlmd)
>> +{
>> +	struct cxl_port *endpoint = cxlmd->endpoint;
>> +	struct device *dev;
>> +
>> +	guard(rwsem_read)(&cxl_rwsem.dpa);
>> +	dev = device_find_child(&endpoint->dev, NULL,
>> +				find_free_decoder);
>> +	if (dev)
>> +		return to_cxl_endpoint_decoder(dev);
>> +
>> +	return NULL;
>> +}
>> +
>> +/**
>> + * cxl_request_dpa - search and reserve DPA given input constraints
>> + * @cxlmd: memdev with an endpoint port with available decoders
>> + * @mode: CXL partition mode (ram vs pmem)
>> + * @alloc: dpa size required
>> + *
>> + * Returns a pointer to a 'struct cxl_endpoint_decoder' on success or
>> + * an errno encoded pointer on failure.
>> + *
>> + * Given that a region needs to allocate from limited HPA capacity it
>> + * may be the case that a device has more mappable DPA capacity than
>> + * available HPA. The expectation is that @alloc is a driver known
>> + * value based on the device capacity but which could not be fully
>> + * available due to HPA constraints.
>> + *
>> + * Returns a pinned cxl_decoder with at least @alloc bytes of capacity
>> + * reserved, or an error pointer. The caller is also expected to own the
>> + * lifetime of the memdev registration associated with the endpoint to
>> + * pin the decoder registered as well.
>> + */
>> +struct cxl_endpoint_decoder *cxl_request_dpa(struct cxl_memdev *cxlmd,
>> +					     enum cxl_partition_mode mode,
>> +					     resource_size_t alloc)
>> +{
>> +	int rc;
>> +
>> +	if (!IS_ALIGNED(alloc, SZ_256M))
>> +		return ERR_PTR(-EINVAL);
>> +
>> +	struct cxl_endpoint_decoder *cxled __free(put_cxled) =
>> +		cxl_find_free_decoder(cxlmd);
>> +
>> +	if (!cxled)
>> +		return ERR_PTR(-ENODEV);
>> +
>> +	rc = cxl_dpa_set_part(cxled, mode);
>> +	if (rc)
>> +		return ERR_PTR(rc);
>> +
>> +	rc = cxl_dpa_alloc(cxled, alloc);
>> +	if (rc)
>> +		return ERR_PTR(rc);
>> +
>> +	return no_free_ptr(cxled);
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_request_dpa, "CXL");
>> +
>>   static int __cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, u64 size)
>>   {
>>   	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>> index ab490b5a9457..6ca0827cfaa5 100644
>> --- a/drivers/cxl/cxl.h
>> +++ b/drivers/cxl/cxl.h
>> @@ -625,6 +625,7 @@ struct cxl_root *find_cxl_root(struct cxl_port *port);
>>   
>>   DEFINE_FREE(put_cxl_root, struct cxl_root *, if (_T) put_device(&_T->port.dev))
>>   DEFINE_FREE(put_cxl_port, struct cxl_port *, if (!IS_ERR_OR_NULL(_T)) put_device(&_T->dev))
>> +DEFINE_FREE(put_cxled, struct cxl_endpoint_decoder *, if (!IS_ERR_OR_NULL(_T)) put_device(&_T->cxld.dev))
>>   DEFINE_FREE(put_cxl_root_decoder, struct cxl_root_decoder *, if (!IS_ERR_OR_NULL(_T)) put_device(&_T->cxlsd.cxld.dev))
>>   DEFINE_FREE(put_cxl_region, struct cxl_region *, if (!IS_ERR_OR_NULL(_T)) put_device(&_T->dev))
>>   
>> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
>> index 2966b95e80a6..1cbe53ad0416 100644
>> --- a/include/cxl/cxl.h
>> +++ b/include/cxl/cxl.h
>> @@ -7,6 +7,7 @@
>>   
>>   #include <linux/node.h>
>>   #include <linux/ioport.h>
>> +#include <linux/range.h>
>>   #include <cxl/mailbox.h>
>>   
>>   /**
>> @@ -270,4 +271,8 @@ struct cxl_root_decoder *cxl_get_hpa_freespace(struct cxl_memdev *cxlmd,
>>   					       unsigned long flags,
>>   					       resource_size_t *max);
>>   void cxl_put_root_decoder(struct cxl_root_decoder *cxlrd);
>> +struct cxl_endpoint_decoder *cxl_request_dpa(struct cxl_memdev *cxlmd,
>> +					     enum cxl_partition_mode mode,
>> +					     resource_size_t alloc);
>> +int cxl_dpa_free(struct cxl_endpoint_decoder *cxled);
>>   #endif /* __CXL_CXL_H__ */
>

