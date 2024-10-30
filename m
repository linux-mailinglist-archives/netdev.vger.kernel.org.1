Return-Path: <netdev+bounces-140456-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A189B691E
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 17:27:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FFFC2828DC
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 16:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2112428F7;
	Wed, 30 Oct 2024 16:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OYJJ1scQ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2069.outbound.protection.outlook.com [40.107.92.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00FA621440F;
	Wed, 30 Oct 2024 16:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730305631; cv=fail; b=EuRphxP0OqmI8gZWY7ipPBKCRcWLlqU1Am2r17ys/mxEG8PyXk6KUwBcRGT4wLRQBsJlWMgMFWP+vLOPZdGTweBHhu/nSiFNUbgsOM1cSW/ZiR068SzG3XdM1NbqVsktCcTbH4mXds/+LPeB0+BxOnp8MN870nETukB+N/fT8WE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730305631; c=relaxed/simple;
	bh=w+WMHcbV7z5JlDWWca4sviV0jMFSve39/3j3rio7GUA=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Vmh+IDwi5rFIsO3ZBHY4gIIdDb+LqUpTuHVptO8LvSxwr2NLeT9rLH7xDvSsfhc8jIJiEGWIlx7rCQvbdh0/qjRqoi1/jjh3xpXmKM7+78iPjqzg0xxTohu+/9nO2i7maEPELGh5Qdht1gFEcdLOI3v3QQJRuQsw49qJvg/Dnbo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OYJJ1scQ; arc=fail smtp.client-ip=40.107.92.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WqZVndmNSPrvODnjsRd9Zu74ZlO2/EDvJLYKjlAujRy8F2ELJfCVwwNR7Kiv+019SuzjqbpNopxha9OnXemrB6CPCtA1IpqhaXJ/b+Osk1ivVoSaSu4n782jcrXWxK4xiPU1qcPKeIbR/oqYHW5ADQXJpuENDCj/huZXAy/CIOgFPTzWLcidpbpld63FxKDB+NO4nEgAHfWiMVY+IlEJb1sMu4XW3I2tSYOUJRSdsb0TPgC1DloTqUI8mCWvnJiUIgDm2pgETrT4/M9uMW0CflNthx7nM/kdKs48WbXIdwHVAo3YVGxVbhzJdKucu+em0+eBUwqYR5Cz0kxIN3CKLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EVt0RNYr4c7njABRLvmDSkwb1HjdiLJpPfsu/pQVMjs=;
 b=Yrw6OpbaNTrQWVW2KtfscX9v6VuIJplEdWlcZD4Zwg5awzvfCg8fq6qFrscdn3PS7+n7aW+MPqky/oW7Mq3L9GMUCsQcIucl9G2Orc7gNp5xpd5L2zYtyOkSbBrzf9gFuKnHtYSVGBZAhbNoilSZ81UyQ3e0Prd1uef3Ro/sQBmkykevUQHnqF3aiz399W5ActPjQxzG4fryGFQHWQS5lTYeo5p9gInUIYbIhqFMawLOj3y7FERoF0wNc8ZD+/ZfCDVllhTny/DPqjpxxiRKwUbJQ3heAIyYqCBrlmw2LirToOisqdFEIh87EvwoyPpnj1IQs771CvRKVO/MSahp5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EVt0RNYr4c7njABRLvmDSkwb1HjdiLJpPfsu/pQVMjs=;
 b=OYJJ1scQuI3eHzvrLP3rjuMheHloePKsCay62ECgEFWyXj+KwF3CFlrbsat9WaDRkGyBbiLROBxZ3i/7IKjTGG464+5Gh0rNH7aBLfX1KAeVPtRGO55C62thzdgOrfV1lOPPajjP77kotaWTEwtDnijQr+R7sa7LNceEuqk2t9Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by BL1PR12MB5898.namprd12.prod.outlook.com (2603:10b6:208:396::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Wed, 30 Oct
 2024 16:27:03 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%4]) with mapi id 15.20.8093.024; Wed, 30 Oct 2024
 16:27:03 +0000
Message-ID: <b3976ba0-8b2c-2940-b6c6-b8fbba9d0dc0@amd.com>
Date: Wed, 30 Oct 2024 16:26:57 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 01/26] cxl: add type2 device basic support
Content-Language: en-US
To: Dave Jiang <dave.jiang@intel.com>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, dan.j.williams@intel.com,
 martin.habets@xilinx.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
References: <20241017165225.21206-1-alejandro.lucero-palau@amd.com>
 <20241017165225.21206-2-alejandro.lucero-palau@amd.com>
 <00eaa9ca-5f07-46ce-b1b8-3c1f301ddc47@intel.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <00eaa9ca-5f07-46ce-b1b8-3c1f301ddc47@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR3P189CA0075.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:102:b4::20) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|BL1PR12MB5898:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ed90f9f-b736-464e-7e2d-08dcf8ffafe4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y21xK1VjMmVqcnoyZkJ2ZDYxUkFVZlBvVXloWFU0MVhReDlaNUVOdFVudERq?=
 =?utf-8?B?cERxaTJsYmxzWXczUHRKdUxJVGZMMmxOeHorc0lacTFIUXRPQmlXcDNXSmg4?=
 =?utf-8?B?N0JFZUVrTGhLSzQ2b2ZNWHZ2ZnVWTmpJOU4rTUpVUFpsR05rZ2Jub3NvTDBu?=
 =?utf-8?B?NkNGdCt3MzVpNUljVnltY0lHQmZDaUZGOWVLd2ZZNk9Yb3h2Sm9BdWk3b1hi?=
 =?utf-8?B?c0Ewalh6NWFaZWJubkFyMFoxWWpNNDMxNDIvdU5Da0RINk1FMjVlUGVLUmg3?=
 =?utf-8?B?KzFLK09wSlJzVFVEcmlnT3ZKRVU5WmZ3ZjhIR1RsNFd5bktWWlBtY1NRMmd4?=
 =?utf-8?B?WTJ2em9EOVRaNkwxVkhWelR6VzFFVWFkcTlwZmJrVEhBU3lOWkFycmpQUmNP?=
 =?utf-8?B?dTk4MlNpMGVucUpnZDdCbFNBaDZ1dWw5Q0lRMGs0c3VXQ25YTEowTGxFZzB5?=
 =?utf-8?B?SHFCOEl1TXpzSTVEQ05rS2d2WUJOS3NweWJYNGp5aWU4RURMTUdIUVZKVzls?=
 =?utf-8?B?OEtqUlV0TjNlU3FiKzRUc3IycU9WdG1zMmI3ZE5WUmxwOVp1UmREQ1hKakE3?=
 =?utf-8?B?TmtLYVYzTFREUURpVk1hOTR4dG0rWWhHS2NTOXFlMVJYRDhEd2dxcU5BNity?=
 =?utf-8?B?OXd1QlBKaWdtQ2hwTE13UnFBUy95NU9jUHlHb2cyS1NEZENPNllxeFpsNlBx?=
 =?utf-8?B?bDB2dS9xL2FUOEc3ZGxIRjUyVDlKandsc3VnaVRndGdqTDY5UVB4MTZ4VjBY?=
 =?utf-8?B?V3BJclZ6NDFTS1NsUmhZSFRHajN3aGRjU3QwQk5UdVFXLy9RYXpyamxTa01u?=
 =?utf-8?B?WU9yWDloY0RaUzhBQjg4TFFOOUlMdi84S2tnRHpSVzQ2dHI0WFVkSDJuVE84?=
 =?utf-8?B?V3lhcGxyUEM1aW90bjYzV2loTEhsMXN0RnprTEhWN0hQWS9Cd0laNTg3enlH?=
 =?utf-8?B?VTRYN1p4dlFCYi9VSSs1UFZHbFFzU3lIOTJJV1ZaeVdJV1h6MjVNS0ttS1gr?=
 =?utf-8?B?WWY4SnFybmZnYWVvUkJIZUJQcVlKYjJYWFgrZVNyTGpiaHZtTGFVRHpPaThq?=
 =?utf-8?B?NE9iVExhaGhyVWZ2anVId1lLcTg0alRwR21RTmlxQWZMOHFKUWs0cHdrRUlX?=
 =?utf-8?B?dEs0SEw1RW9ZS1FmSkdUNmlkTDlwVzI2V252dlhDeERnOVYwMTVTMVowRVJL?=
 =?utf-8?B?Q0swZi9XMS9CVit5Q3h0Ym9SQWpNRnpLRUlod1RJZTVEMkEwcnVYbzZTUFli?=
 =?utf-8?B?d2M1ZUpYalV1UzY2VzkvRkh3VmNsSzBYYTkzeTRkdUNwNU9ISHkzd3RqSGRZ?=
 =?utf-8?B?VnZqQ3BtVDZvZ3RGNWkrajdGM3daQ1JuZURrOHJla0tQNWZuR0FXM0l5U2RX?=
 =?utf-8?B?Y1RKL0RNamM3L0FrUlJQazUrYlJpc2pqQUppcHhkVXM0YnRCUk1wMXhPU3lG?=
 =?utf-8?B?U0wwTnY3YTRrU2c1ZWhvMXFYVUprcGNyd0RrOTd6NzFnU09qVWJKc2R4N0E1?=
 =?utf-8?B?enFsalk0Qmlob2lIcWl3UWh1N3MxbnR3RnJVSnFkVkJ0dXlCdUpVTVNyUVRP?=
 =?utf-8?B?UzNnTGdKcFNkTm9iMFoyTDRSQUdpL2tWbFFhdmJ5dzZhTzdKNzZiSytsQ3B6?=
 =?utf-8?B?WmRaVlpWczNXcWlBSkt4TGtWcGNIL3c5dXdhbzhsd3VBT2pubjlxMnRxTW96?=
 =?utf-8?B?Slhaa293Si96UXhweWVXYTRDVjAxMjFuVlFqd1djV0lhWXljUkVEdHU0Z0dV?=
 =?utf-8?B?ditHQnlJbFkvN0p0QTZZVnBRTTMwdDgxTFhCN2NXeGVGTWFGcE1ycXpSWTlC?=
 =?utf-8?B?NkdFWm1JamRyQnpRakp0Zz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Tjh2U25PeFdhdEJ5TjlXQVpkd2d0aU5oQzUrNklpaWU1WWxmZjZ5NnJRbUZ4?=
 =?utf-8?B?Y2ZuQ0Vsdnl1TE5wb0RXVytZVWhnMkJYUEJ2OG05WWdXUkZ0bGRDL1dNY3N1?=
 =?utf-8?B?MmNKZWZyUW00R2pqdTVvbzA4VW5TSDlxNjZXMVJOSm5oYjhUT05wamI3eEJl?=
 =?utf-8?B?c3YrOVVYcVkzSTBycEdKdTdROEdQaktveFVVZGp0VUNackkxUks2bUhTeXNJ?=
 =?utf-8?B?bGMrcXNUck85TVR2NTNiSGZCMUdFS3YxZEJRQk0xSjAvd2t2U2E4SllNMWlr?=
 =?utf-8?B?NnoyelRlV2hnTHpCSU9hVmtGYmdRMGd3cVRpb0VjT0tHbGEzcWtWVTFEaHJq?=
 =?utf-8?B?eEFvYXZkdUtEZHk0MWFveWtLaFZwa2NrYWVxWWM2TkhNN3g3TnIyR3FvUVFO?=
 =?utf-8?B?Q3RxeEY4b24rV2UxV0J0cnptYnRSTE5tRk1PbHZqY1kvT3BKT3lqMjVPejcr?=
 =?utf-8?B?UkF1TlZaRjhYRHk4OW5tZWdod3grUW55dEFmRkdmWDB6Z3F5Q3p4ejhDdzYy?=
 =?utf-8?B?OXJtUjhUQ1ZtYlk4OW9WL1djZHV2MmRMTWVlYi9JVHdSNjkwU1R6T1BQWEtm?=
 =?utf-8?B?NmhJQWJxNGpVYVB1MXFiOHZZRm11d1NpVC92cmw4R3ZkMG1NTStLcFNDa0VF?=
 =?utf-8?B?aUloTGkvbHN5K0s5Rjl1eHJ0dWYrWUsyNy9sdzh3OXlpK2VJSklGd1dYcUN5?=
 =?utf-8?B?amxZaDJHNmRkV2doSi9LajByOUJnZGxFZkpJMTBURnhZTzljeUg1cUdyMFlI?=
 =?utf-8?B?V3Zkak9ISGtiMUR6Tm41UDJWb1hJQTI1ZVdiOUp5VG54VEU5YnB5SE56NE5X?=
 =?utf-8?B?a0RBeW93ZGIrc254N0VmbFhXN0dlUW1PajNpQ09ndVBvaFlLeGlwYWoyU29x?=
 =?utf-8?B?bHA1MEVmSGdNRzMzTG9yRmZzYXZVTVIrUlBHdHZmdlVKcXhvdnZybE11dk5p?=
 =?utf-8?B?aFo5WnFRNWExdElTUytYMUpoQkRKQkQxYjNCVm9iTnc0Wm9qRXJnSTZZeVJZ?=
 =?utf-8?B?cksxV1BtUnNXcms5bkIzdXRUR1ZaTjFQb0hLUHl4RE1sd3IrY1gzc01LWDRT?=
 =?utf-8?B?QTVKQmFES0IweW5wRUN5YklSdGtxOE03YXFhMHNZTGNINVhZaDFacTgzeE53?=
 =?utf-8?B?aVZCUkNXaW0zNW1TNlhaSDZ0aXdrSWNGOFJtVEkxM3paK2wzOXB5Y1VtWEV6?=
 =?utf-8?B?OE9yQWJPYm5EdlFaaXBYamNFYUdEaFJESWwwVUNKdVdQK3FqRmRNemQvdytD?=
 =?utf-8?B?b2M0MnNCczB3MmY4VnFoeHpFR21mWExxSlN1YUZnSXZrQ1R4WmpCNTJhVFdF?=
 =?utf-8?B?eUZXRUIya0J4anRkbHBZS0RXRUMrZkhjQkxNQk9LWXVGRjRncE4xWGs2NXZ2?=
 =?utf-8?B?Z3hUUHhOdjBrRzhHS3dLU3lQMHIveEdGZzhnQ21Kb1JSbmljanVzWDY3Sm8v?=
 =?utf-8?B?M29WUGQ0dzV3eURCbU00SHA3djgvMlQxNVphNVRSMngyMGxnV2dhdFJzN0ZR?=
 =?utf-8?B?K0RnQWtlSjdGMFRVZFJyZzROSFVLY3BlUWttSkgvejR6NkllNndBWTRYUzJS?=
 =?utf-8?B?V21vRVRuK3M5ODRpQ2lVNlZvTGQ5clJiRXZtOE5wSlYxL1hQNWpPQmlMUjFh?=
 =?utf-8?B?cCsxYzlqN1lLYU9sbjRZWFdIR2hTY1dpM0FTdk1OaDJpb1lpeXRVd2xPM0Js?=
 =?utf-8?B?b2JUR1hiVWlXV2tLc2NSZXRJSEl5VkR6RzBiTEIwQmovRS9YcE8xYndETkNF?=
 =?utf-8?B?OHJ4amZNaG8rSmxnQnM0bm0vZUlXeit0M3pQNkxISWdkWURCb2M2eEVWbllE?=
 =?utf-8?B?aUJ3MFROckNBTDhyeGh6NnBuaHViNzhhTGUrbHB5ZmM1NmFwWnFiemhrZDFR?=
 =?utf-8?B?elBqUWoyMmpiN2Q5c2dTZlc3K2pabjE5K282Ym5Yd1NwZm0rV3dVeEI2dUJB?=
 =?utf-8?B?VXdoNmhISStwMWFlU0R1QWk5SkJ0dXpMU3NNa1J3ZzhiazcwMjAxTTJNekZ1?=
 =?utf-8?B?Q2JaR0FEYkZLeitYQVh1N1l0aGkvTmNPa1Jzd2xTYXFkR0psWk1NeTVWZzQ0?=
 =?utf-8?B?SG5ybUhBOWpGYVF6ZFN3VCt1WUJQTDQ4RnlTS09iejAzdFlhSisrWnhlSnBN?=
 =?utf-8?Q?wVfQeOWDOlvX9JYXqA18xLY1q?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ed90f9f-b736-464e-7e2d-08dcf8ffafe4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2024 16:27:03.4732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lYVgX+QkH3GTFbTbxZCMENDcp7gyKhLFHwc+X7XWPo/mEd1Uid6Jpm+s7qbMgITR1lIgirLkyV0fmXEY+msKgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5898


On 10/28/24 18:05, Dave Jiang wrote:


<snip>


>
> diff --git a/include/linux/cxl/pci.h b/include/linux/cxl/pci.h
> new file mode 100644
> index 000000000000..ad63560caa2c
> --- /dev/null
> +++ b/include/linux/cxl/pci.h
> Just a reminder that this should go in as include/cxl/pci.h now.
>
> DJ


Yes, I'm aware of it. Just the kernel I'm using not having that change 
yet, but I'll do for v5.

Thanks!


>> @@ -0,0 +1,23 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/* Copyright(c) 2020 Intel Corporation. All rights reserved. */
>> +
>> +#ifndef __CXL_ACCEL_PCI_H
>> +#define __CXL_ACCEL_PCI_H
>> +
>> +/* CXL 2.0 8.1.3: PCIe DVSEC for CXL Device */
>> +#define CXL_DVSEC_PCIE_DEVICE					0
>> +#define   CXL_DVSEC_CAP_OFFSET		0xA
>> +#define     CXL_DVSEC_MEM_CAPABLE	BIT(2)
>> +#define     CXL_DVSEC_HDM_COUNT_MASK	GENMASK(5, 4)
>> +#define   CXL_DVSEC_CTRL_OFFSET		0xC
>> +#define     CXL_DVSEC_MEM_ENABLE	BIT(2)
>> +#define   CXL_DVSEC_RANGE_SIZE_HIGH(i)	(0x18 + ((i) * 0x10))
>> +#define   CXL_DVSEC_RANGE_SIZE_LOW(i)	(0x1C + ((i) * 0x10))
>> +#define     CXL_DVSEC_MEM_INFO_VALID	BIT(0)
>> +#define     CXL_DVSEC_MEM_ACTIVE	BIT(1)
>> +#define     CXL_DVSEC_MEM_SIZE_LOW_MASK	GENMASK(31, 28)
>> +#define   CXL_DVSEC_RANGE_BASE_HIGH(i)	(0x20 + ((i) * 0x10))
>> +#define   CXL_DVSEC_RANGE_BASE_LOW(i)	(0x24 + ((i) * 0x10))
>> +#define     CXL_DVSEC_MEM_BASE_LOW_MASK	GENMASK(31, 28)
>> +
>> +#endif

