Return-Path: <netdev+bounces-243175-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id C073CC9ABFE
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 09:48:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 44E3C3463C4
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 08:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F02A6191F91;
	Tue,  2 Dec 2025 08:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zFwjF0vJ"
X-Original-To: netdev@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011056.outbound.protection.outlook.com [52.101.52.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FFF736D510;
	Tue,  2 Dec 2025 08:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764665283; cv=fail; b=Wmb+uJi09Kjz1p5KPXFExjyMZ6Bog5UOnitUctzYGbi6kgk+AiuAYUBWfoEWLFPapIg626qOe2Edb3PumDXoSXpjR2YSJKfFAs/6zsXpNRIivwcisDHg8wI2n5Mqkzf9pFlz11FUiuBWFKge4QWOGBlJX7aD6nvQT2AGl/KGY3s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764665283; c=relaxed/simple;
	bh=whwl+8bLpUu1AyLNnEo86+I/EAoBL4HjfTfY3e/FSF8=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VJFwdAUiJUDVfbb9oLSADEKQElZQYS/Q9eGoexFpuzHx7qEuGYBZfj4SKHeLPZqpDhkay+sUqX3WQWdJSL3F/vFH49gxV5IaqlkE819TOKPNoJTYRMbf5frRDlleuSeG/no4QtzJuSG7RGL/+NSmzr4a7lhrvBtNiHZfszcQUIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zFwjF0vJ; arc=fail smtp.client-ip=52.101.52.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d41q1YeA7aJAH3cykvfonT168y3/pvMVqIZ/vcstpLUVHgFq2Jb1lqDu/xRhkYVCWFkRORc1swkTgHgfXghMue/NAZ1vsAWr6quFI4f4t18deC1P0XiV4hirz4X5unSqAiJI0B4D/8XNi7Bs3e3QYku+2cN60uivlfRi2yrRl+V7eygIp8oHbaWWU4r7ts7gwq9dWsr+s1quZF0GrkHKBCSx92y6TUhJixH+F47qL0DMqfGktqK7+H5guQKER6WBtlBgHnLkTDZA+1GA5U1FcVfR/aUQ4xmEl1a8gkdXZgQVGiKQ1Qs+3Avwe/ZRjYVLQLcqAUZXoqFXSooR4lW4kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YtpSW4gUkXX3e96KazXlhFMgyw1xPWU5yPpxCsSIaTI=;
 b=PpVPQepx65hwvrGnax5HADGWGS/xsrDOnvyJqlIlp+512DrsO9Gsj6FqKH7sDDm4XDILabmEdrCvjs2LlqlBKBnMZ9YvUDAFdnK76EuWJ2yS0XXnUZt1eb4yJoLUI7IBpcWpNrBlvGalncfQcXgtwDRxNUhyl3ll6nt4fmwwu8oFzWtTFgAtoaJv4YkGIt4+qAmBqLl12Vjnu++qKCn5EA5RInPS8PaWEOc3LclgSfmKZDfuc1bv1zfZ+uWU0xUwp3fhxTt2yunf3qbE+fdQStekAJrT+iGOKQNAcvAHGakjA0mdSEJau8TI587tqe5vUQxAxVgjoggpd6BYP28oHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YtpSW4gUkXX3e96KazXlhFMgyw1xPWU5yPpxCsSIaTI=;
 b=zFwjF0vJzaI5gYwULjzBpKfGjsLLV+hiXDy6yJ2zeFRiMO8wSlbThDOrbp1b2UjV8RfuIgcuJQv9Pculxo33p9H0+W4LLh8z1cY0Vd4PEXd4+rCQ434JOiHDb3ISCvrl8Vj6VbkVHUwq8Nj/GOTg59a0cOyn349d8znWekzilYU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by IA1PR12MB7639.namprd12.prod.outlook.com (2603:10b6:208:425::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Tue, 2 Dec
 2025 08:47:59 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.9388.003; Tue, 2 Dec 2025
 08:47:59 +0000
Message-ID: <74fbeca5-2c64-40a5-b399-621b8c9a1271@amd.com>
Date: Tue, 2 Dec 2025 08:47:54 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v21 01/23] cxl/mem: refactor memdev allocation
To: dan.j.williams@intel.com, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com
References: <20251119192236.2527305-1-alejandro.lucero-palau@amd.com>
 <20251119192236.2527305-2-alejandro.lucero-palau@amd.com>
 <692e54808af8d_261c11001@dwillia2-mobl4.notmuch>
Content-Language: en-US
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <692e54808af8d_261c11001@dwillia2-mobl4.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0143.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c4::19) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|IA1PR12MB7639:EE_
X-MS-Office365-Filtering-Correlation-Id: 14e5867b-a783-4d2d-8624-08de317f7e90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WCtsOUlpQ2RMNEg3eGphRExvRlhaOTU5bGo3K2ZKdHJpaTlxejV3YTk5Vytw?=
 =?utf-8?B?UlBJTzQrdjVqZmlsVFU3V1VtTkJIZ20wS1ZPV0NBUkY0YVk2bzJYU216a0tH?=
 =?utf-8?B?RmE4VGEraGdNZkNkbW5LM0pMNm9hdVd0bFRaN0RPRWl1UnBRYnp3Q2NSdnNu?=
 =?utf-8?B?dXVBdFF3Z0VXT0kyNytKN3YxemRmSStMbGIyZERoUVRobTB5c2U5NzcwN2NT?=
 =?utf-8?B?N2xBMGZ3SzJ0ZHJRNXEvV1VBVUorb0thS3MxNjcwaEJaRWgzb0JyU0VlSXdw?=
 =?utf-8?B?b0c2VFVMTnZpckZaaExHODFjZWszWndFa2U2Tmlzb3M1ekRMUHA4cFVjbE5j?=
 =?utf-8?B?djBqVGVSZHVkQlRldnkyWEFZdHZrdzZiTy95WW4vMXJHUDBZZVRybDR1dDd5?=
 =?utf-8?B?ZHdneG41cEg0U2w1QllOR3dNbjh0RVdtVlQ4bU9HM2xDRjA2QXVxb1ByWXh4?=
 =?utf-8?B?ME92MGhKR0hGZHVpdnh2RmpianZiUUxoK2l2cHZGMVJTRVNUb1I5L3lVeXg5?=
 =?utf-8?B?SDMrdlM1Q2VnYzcrTE9oVnpJWENZVkV0bkU1NkR0WFBmN01XZHNGTW5WWVpa?=
 =?utf-8?B?cjc3N044K2Fka0hMZjlKeHJNdlJtNXdlNFNzeHFONlExVFZhODNyckJqTVNi?=
 =?utf-8?B?SkJzU01VT0dRVXNlZ3ZCU093WThueGZJaVpPN1djYWFSbmZxUHlrKzJ6cG51?=
 =?utf-8?B?VXRWZWpzTDdDZ21qL2VUeXdTUWQ2MUN4bEVJSTlNUysybndlSjllTHlKdDVt?=
 =?utf-8?B?NloyNllWd0o1bnVZcm1WZzJVKzFmNEdPMUwzZkhTNEZuWWM4NnRzZXRJdjcw?=
 =?utf-8?B?T2s2Y0xMSUpLcGU0d2Y1N1ZyUHgzYThvbDVjUUFERFBoNXM1UjIra21EaDJU?=
 =?utf-8?B?M1R2MktlT05EeVJkM253RnRlL3lZcFdWaERIZ1oxeUxPZ3IvUDBRZEhZZDNK?=
 =?utf-8?B?YXRzUEEyS0VDZkdxaU4rUTNWdmVaSG5FMFlVdVYzL1NEMjR5NVFYUmIrdDFX?=
 =?utf-8?B?R2ZmSGd4ZVpDREMxZ2QzL1pxbHAycnE1clphRnVhUkI0TDk0ZG10VEh5cCtW?=
 =?utf-8?B?WmlsaUxKZURFcGxNSXpiNGc1SWdQOVk5UTJ4SEZaemZqVjJ2RnFBNUprcEU4?=
 =?utf-8?B?RlVmcW9nS01ReStMd1pWY1h4S21FOW8xRmt1U0N0YU54VW1pSTZFUWIxeGQw?=
 =?utf-8?B?UUZEbkk5eE9WakFWMDh3ZG1odmJaWXlsRjZMSCtVQVJMYVFjVHd3TGw3Wk1k?=
 =?utf-8?B?K2JPeFJHcktGR1ZNWEZrRDBLMnNXUTc1MkhLRFhvWkw5VFVLL1dSSmk5N3Nx?=
 =?utf-8?B?ZVRnNFhxRUVHbElKSzdRVG4vOTZCSTdPdkV1WmhlUmUwcVhZMzhMR21ERzZS?=
 =?utf-8?B?TERsRmozK2NUcEpVUWJycDlzZ1VWL3BGNTR0WHQrZElDVHlNL0pqZmFEUXJL?=
 =?utf-8?B?d2VEUWdSWDdUcElXZGV2S1p2WDlJOUhyRmRIaXRHRzIzK3pJcWlJOWxZYXRK?=
 =?utf-8?B?eEFmOEYzSXZHWjU4WGJZWXdFY1VVbi9JMFlEdVJwR0hRemdaRElUZDZWdVJx?=
 =?utf-8?B?NXpqNmZCMEtTL2M1dFFON3haa2N6eWtEbnFaVlZNVi90dEtMNFRaL3kzRzIv?=
 =?utf-8?B?c2dYZXpzY25MbG45alJOa0JGSVJYY3NSUVNqZFpQZTZ1cEsvRjJFTjJITWFl?=
 =?utf-8?B?QTVucEo0SzJybXFFeExYaWhYNXk0TzE4MHFBRTY2Y2VNVmRBMGlML0o4WDVX?=
 =?utf-8?B?WENiVnpDMjluNzFGVnY3dE91Z2xCbElaUWlROTNQSnk5M3NRVHBWZ1BoUEVa?=
 =?utf-8?B?cDVNa0hFWDlrYUxGV29VdjZtSThvMmoreDQ5aUJlVkZtb1RIUEM2N1d2dTc5?=
 =?utf-8?B?Ujh0OHhzZ3M5cDhXL3RMR2JzUmh4MThDSjZQMVQwV3FFQUtCTXFKTHA1c3VC?=
 =?utf-8?B?QW5Kb1VuRnRadFRlb1grVG41S24vaFhYSkVEWU5mVmZjUmxaWFQ4dTZJd1hM?=
 =?utf-8?B?M3pXTHE0bmFaZmNIQmJkS3JCbFQ1T3pNbkVnbmxxL2xXQldJUkV5MkxXQmpi?=
 =?utf-8?Q?poK2Ht?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?amo3VUVSVkZRVGdENmd5TEUrTUlhOWV2Q0h5Umx1WDV6dlBVK3JPakFGdCtU?=
 =?utf-8?B?YVpZSEF1L0poWlNhUVFsdjdCSHlkSm5nZ3ZHZU9zNU1xelhxUFdydkFEZ2ZZ?=
 =?utf-8?B?MmNLMG9mam9WYTAzam5mdlNCM0YrbWVQdTdXQ0p2WlZrYmx5amM4UUs5T2or?=
 =?utf-8?B?L2J2OWt1TWNENGRzcngwWUJ4aVVRd2daZHk4T2dtNlVWR09jcUdyd2NlQ2U5?=
 =?utf-8?B?cVV3WU80dnI0ZW1iaFYxNUNGSmx3NERUelovUjh0NG5KN1dNRUJWbjNIV1JU?=
 =?utf-8?B?MHkxallyNFdSNVhZbXRKTkc2cm5HRlE2ZndHa1A0N0poZ1dUd0xGY2Z2M3ox?=
 =?utf-8?B?RkVnTjJMNEx0WWdoZEVCRkJMM2N3Tjk4cmR1RFl4ZVZuRHlxb2tiR0Q3RHA2?=
 =?utf-8?B?Tk5QZ2l4YW9SOFpQRlJFY3NEWW8zRDBYb0FvbXlTTGlRZms4UTE4emFZdE5S?=
 =?utf-8?B?QmduVTJoNTQyV3B6S0g2b0VlZ2dUY2k3eUxyRmt5TFYxM2RPREpLbWEvd1R5?=
 =?utf-8?B?V0RzOTFTL1FzMmljaTlzMDh1MW1mMmEvNGpHd2xTRHhMYzhtTFJOdHcvV0wv?=
 =?utf-8?B?bkI3L3NWZEJ5UFo4bTJtZU03dDhtbGNpaXJHZVMrcGRZYUQ1U0c4MHNNWGFY?=
 =?utf-8?B?ai9MOTliNFU3c0RZRDltckYzQS9yeHN6M3c3OGNmelNSeGVwWW16YlJ1cko1?=
 =?utf-8?B?SzNMWnJGQjhleC9QNXU0UjYvTWVDelRUREdZM3lRRlRjWXo3TEVUVUFIK21r?=
 =?utf-8?B?UGhFbFFFdmFaQWRmeUx6UHFOQUZzRW1uWldKL21JT25PNjRrUGJGc3dYWG56?=
 =?utf-8?B?OG1zTG5lT0pUTVp2NmRCOW1rSzZKWllnRm5USS9jenhvY0hyRjhEd0V5cnNI?=
 =?utf-8?B?L1J2dDdKNjVCNUsxMmpGQ3dXdUI3dEhGUFZ3TUlYK0h0c3NiRm8yV2FoV0VK?=
 =?utf-8?B?VEIzL2o2YlpMUDhSd0czY29MUTVrbloyK2pDTndsSjhTQ285d0NhUXRWcDVQ?=
 =?utf-8?B?N2ZZTVRtUUdZbDJ4eWt4WlZCV2daSTBCRTY3NkwrQVJBZ1E2RUtxSXBtSVVz?=
 =?utf-8?B?cnB1Q0xXZGlvY0ZlU3JBRnpnTmJNbFArMDQ1L2lBYmkvd09VTUhKWFg1WU1E?=
 =?utf-8?B?Y0Nwb3ZSLzB0ZytaVTM5TVJCRGZPUjVIcHQ4RGw1Y0V5Wks3cjFpYzR5Wngz?=
 =?utf-8?B?enRSN28reVFFTWtHbHpHbExqMVdKdWRlYkxsbnFOVjE2R0ZBVklINDZ2Znky?=
 =?utf-8?B?dmpYK0ZINmJNUU5IZC9mUldFTG5PZ2RuVmx6V3NiYndsaDBvQk5PL21uYmFs?=
 =?utf-8?B?dzhRd3N0c2xYbldqUm1LdUlxZFgwUktlL2ZNR0JnUnVUTEYxZjRqVFZ1dVpM?=
 =?utf-8?B?MGdiWWVwckV6QlZNQngxZG1iQ0IwRG1VdnNITzh5czR4cEpqMEs2T3VtdDdo?=
 =?utf-8?B?S0VOY1dqOXhvWndZL09CVUJpRGZCOHZkL0NtYXhtdzVwQ0U4Ym1uMHF3bmo0?=
 =?utf-8?B?OWpHNnNPcmp5K3VLKythZFBXa3VCa0VFSEtxUDN2cVdETnIwaVcrSTJDdW9y?=
 =?utf-8?B?SmJXbER4QTFXc2JkRGJJTGxjTDI2VDNsRlZ0Nmt5aDltMW1pc2pOaXJPdFBn?=
 =?utf-8?B?eFVQVEVGUUU1R2VhL2tPbk5xM1dnWDdFZTVraE9tTjJsTm5mL1Y5K0N2OTlk?=
 =?utf-8?B?S1hLVkNmZ28xTEIxZEVQTkVpaTJxTGZYMjJxZm9DRUNKVDdDcjdpdVI3bTQw?=
 =?utf-8?B?OUg3bVlHSFBSVnVmZmM0aXkrcFN1TS9ZREpOY1l3eVNHQ3ZaenM4VHRSRjZS?=
 =?utf-8?B?Wlg1a3YvUTBDUnA4dkVGY3ZHdVR0cmwyYlZZaUNNSzVucytmbVNBcm9Iajh6?=
 =?utf-8?B?dkM0NGUvN29uNzNUVXFCcTd6SjY3UWVVTWEvZG1PQVFHWHhXZ2t4S0FwZllj?=
 =?utf-8?B?YTNoUitkNHBvSHBEUEhtbTIveHh4VHlwRjlXMWwzMXBJdXNUWlUrNkFiNHJk?=
 =?utf-8?B?bk5za0d0WnRVMC9Gb2RkUi8vR0ZxRkU1cmcwOFBEczF2b2RmMWUzeGZ2N3pr?=
 =?utf-8?B?bERkd0JHdUNSUlFIQnVmMHh2Z1pGWnpIL2VYSHdHRWg5S1pIMVcyUjY4MmQv?=
 =?utf-8?Q?d4Q9hOlebSF5qQI6g1FsVjluB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14e5867b-a783-4d2d-8624-08de317f7e90
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 08:47:59.0352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: flLv2POuGLXlBMku4oF3gHS34CAGjP+i8wlItutUUxB11gJrD1LkFhXT9aobohw2iXbGsuuO9rBrC9OAnbHflg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7639


On 12/2/25 02:52, dan.j.williams@intel.com wrote:
> alejandro.lucero-palau@ wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> In preparation for always-synchronous memdev attach, refactor memdev
>> allocation and fix release bug in devm_cxl_add_memdev() when error after
>> a successful allocation.
> Never do "refactor and fix". Always do "fix" then "refactor" separately.


Ok.


> In this case though I wonder what release bug you are referring to?
>
> If cxl_memdev_alloc() fails, nothing to free.
>
> If dev_set_name() fails, it puts the device which calls
> cxl_memdev_release() which undoes cxl_memdev_alloc().  (Now, that weird
> and busted devm_cxl_memdev_edac_release() somehow snuck into
> cxl_memdev_release() when I was not looking. I will fix that separately,
> but no leak there that I can see.)
>
> If cdev_device_add() fails we need to shutdown the ioctl path, but
> otherwise put_device() cleans everything up.
>
> If the devm_add_action_or_reset() fails the device needs to be both
> unregistered and final put. It does not use device_unregister() because
> the cdev also needs to be deleted. So cdev_device_del() handles the
> device_del() and the caller is responsible for the final put_device().
>
> What bug are you referring to?


You are right. I was missing the release from cxl_memdev_type linked to 
put_device.


I guess I got confused with devm and __free approaches ...



>
>> The diff is busy as this moves cxl_memdev_alloc() down below the definition
>> of cxl_memdev_fops and introduces devm_cxl_memdev_add_or_reset() to
>> preclude needing to export more symbols from the cxl_core.
> Will need to read the code to figure out what this patch is trying to do
> because this changelog is not orienting me to the problem that is being
> solved.
>
>> Fixes: 1c3333a28d45 ("cxl/mem: Do not rely on device_add() side effects for dev_set_name() failures")
> Maybe this Fixes: tag is wrong and this is instead a bug introduced by
> my probe order RFC? At least Jonathan pinged me about a bug there that I
> will go look at next.


This fixes tag is wrong due what you pointed out above.


Not sure what you/Jonathan are referring to here. PJ found a problem 
with cyclic module dependencies with the changes introduced by these two 
first patches.

It can be solved changing CXL _BUS config from tristate to bool ... what 
PJ tried successfully. I was expecting some comments before adding it to 
next patchset version ...


>
>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> Why does this have my Sign-off?


It was your original patch.


>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> ---
>>   drivers/cxl/core/memdev.c | 134 +++++++++++++++++++++-----------------
>>   drivers/cxl/private.h     |  10 +++
>>   2 files changed, 86 insertions(+), 58 deletions(-)
>>   create mode 100644 drivers/cxl/private.h
>>
>> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
>> index e370d733e440..8de19807ac7b 100644
>> --- a/drivers/cxl/core/memdev.c
>> +++ b/drivers/cxl/core/memdev.c
>> @@ -8,6 +8,7 @@
>>   #include <linux/idr.h>
>>   #include <linux/pci.h>
>>   #include <cxlmem.h>
>> +#include "private.h"
>>   #include "trace.h"
>>   #include "core.h"
>>   
>> @@ -648,42 +649,25 @@ static void detach_memdev(struct work_struct *work)
>>   
>>   static struct lock_class_key cxl_memdev_key;
>>   
>> -static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
>> -					   const struct file_operations *fops)
>> +int devm_cxl_memdev_add_or_reset(struct device *host, struct cxl_memdev *cxlmd)
> Can you say more why Type-2 drivers need an "_or_reset()" export? If a
> Type-2 driver is calling devm_cxl_add_memdev() from its ->probe()
> routine, then just return on failure. Confused.


Well, maybe it is you who should answer that question. It comes from 
something you suggested I should use for solving problems with Type2 and 
potential module removal. I added those patches first time two months 
ago and now you are finally commenting on it.

This is the little story: my comments suggesting how I think we should 
deal with that problem were ignored, then you suddenly commented in and 
offer your way of solving it pointing to your branch. I used and tested 
it which indeed fixed those potential removals ... I work on them for 
solving some minor issues then Jonathan suggests to refactor the first 
patch. I think I found a problem with the allocation ... I tried to 
solve it ... I kept the original commit as you were the one proposing it 
and you are a native english speaker ... you realized in the next patch 
review those are indeed your work on solving the problem ... then you 
propose another patch ...


I really hope you review all this in the impending v22 where I will 
present a solution for the Type2 initialization when HDM committed by 
firmware.



