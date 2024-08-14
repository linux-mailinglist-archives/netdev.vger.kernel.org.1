Return-Path: <netdev+bounces-118577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF7ED9521B9
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 20:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B1172829DB
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 18:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC9191B373D;
	Wed, 14 Aug 2024 18:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1PwgaSN/"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317E8524B4
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 18:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723658468; cv=fail; b=IeAV0xxQQaM191keW+kGe0l08LETIkH3Vp4RwB2LZ45UQHON/Ama5fGfuvZ2+88uQ35HRSy4QmaY3v0voRWV7jO6FiGt1OJEufatPGM0V8ayNp10gO9hUiokQ6bfBUFG7gbgMg1Afr2UUP8RVV9TeA4UjmQZk1mCqyB9ZACK2MU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723658468; c=relaxed/simple;
	bh=TDZGGYF69bP1dXoTs5LlbAIZ2xbGCNLiw6emADF/N7A=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oDscmXkJ1G5MhmjBqTfyPFodNjXAG2WBvuxq+ygEEDJj2+87TYJBcvCVh3QwYDm0Wz35Z36q1VisGBmoxH1UgFmAksTzSx3jY2d7xkfJq2MSr1ryxBo1B4bqYHTelhvbjqCpXwVNpXrUQdlRtaFjPUhHihyo758NyVNO96DN9Ak=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1PwgaSN/; arc=fail smtp.client-ip=40.107.223.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s4vjjMhE9fOmhwBkAFifDe0Bfi7x6w1P9c6RyTEJF2Z1qbi70+chA77aPe7lhBWbhf1SYdNAsSszidaMhdXIc0fG2m8HmVmhj8jvkYadbvSAJP4++vt4rgRE5CiXpKlLzn6E+VvUQ+jgl1UmurrB4X6GKKxfrzva/Ns3vseR7fObC7ID5YYFtI4IbS6aq0ZalNPxDX72KObkT2rVVy4e8qdUPLCIB+3zc3M8OyV6HakW2O7rVA3NPhZWYBlZpAZfqRiEKamiBqTDHp62zI4fevQ+tuaQiRvnDXOld3o7m9CVC9sFaXwSu0kOKXKeC4187s1y9R9lmCTdJbOeJZhkjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6WmruL8OAj5YmwcLL8hR1W8gP5O+zMB3QTN3tozc6ag=;
 b=fO/m8QxpIheHU0XdnNmTIEdeGStZx5oM2zwxGTZ8DXjg7Jw0qsvHeQc8vBbgpi1jjwDO3pMv4Jexu29sVQvcHsMEQ0YRJQ5gVvOfNfOtGabh24XvVlXydeEw4S85XZHKxrsfwMal2LUG2+TXHBW/BjdUnFuqa7ESlQ5XZRgP4uDRHMhZbDkkByQl8b5ZmZ3tfJnc80bZiaV+wG9pOkE2FP3sqkwpfLcbPmjO+Iz7PdiIlS2tiMA0fFOIPySwW4y6H2x8i/RreavlKt3zVl85orGVc6IgYuM9QbsC2OEPPwTZbhyzoVYW0wMDwjj0iOcgugLznEzHc9scqkO0Vkqu4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6WmruL8OAj5YmwcLL8hR1W8gP5O+zMB3QTN3tozc6ag=;
 b=1PwgaSN/7fDDQRHsQXJB75Gw3SlfJ1XKsrvH9DYVR4niLTnJGwHVpP3g64cNhEDh2N721n7tSRv0BXYw/4aecVZS3GKhiNcCsMi10tx2ZbK4256RPc3NbMpNfR1GUd3QzalNy7EkAgVh4a+2qamB0XmZrvk7zK74jw01GpglNrg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH0PR12MB7982.namprd12.prod.outlook.com (2603:10b6:510:28d::5)
 by PH7PR12MB8593.namprd12.prod.outlook.com (2603:10b6:510:1b1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.23; Wed, 14 Aug
 2024 18:01:04 +0000
Received: from PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bfd5:ffcf:f153:636a]) by PH0PR12MB7982.namprd12.prod.outlook.com
 ([fe80::bfd5:ffcf:f153:636a%6]) with mapi id 15.20.7849.021; Wed, 14 Aug 2024
 18:01:04 +0000
Message-ID: <86d049ce-226f-4b3d-a8f6-82374f0a0b71@amd.com>
Date: Wed, 14 Aug 2024 11:01:02 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] ionic: Fix napi case where budget == 0
To: Joe Damato <jdamato@fastly.com>, Brett Creeley <brett.creeley@amd.com>,
 netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, shannon.nelson@amd.com
References: <20240813234122.53083-1-brett.creeley@amd.com>
 <20240813234122.53083-2-brett.creeley@amd.com> <ZryWAFkWSmp3brjE@LQ3V64L9R2>
Content-Language: en-US
From: Brett Creeley <bcreeley@amd.com>
In-Reply-To: <ZryWAFkWSmp3brjE@LQ3V64L9R2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0024.namprd05.prod.outlook.com
 (2603:10b6:a03:254::29) To PH0PR12MB7982.namprd12.prod.outlook.com
 (2603:10b6:510:28d::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR12MB7982:EE_|PH7PR12MB8593:EE_
X-MS-Office365-Filtering-Correlation-Id: 470f5447-0bd4-41c5-3729-08dcbc8b1073
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RFBMZFFhVkJCOGdTYi9RbmlKVFMyR0dXdlpTVlVSTy95Tkd1VGZTRVl1aExW?=
 =?utf-8?B?Y0s2SUJ2Sm91NjhJVXB6TmRTV2Rwd01kM0drcjZvUEZ1SDVEVFJnQlRVbS9V?=
 =?utf-8?B?S0YrSzR0ckxsdWFKQzBicEJxd0FKZHZmLzgyNFpZWkpEdFUwZWVWTWo4eHl4?=
 =?utf-8?B?S3RuNFJyVEJZNzc4N2pQYktZTUF5bmdaaEROUlZMUVd5RVY3RzZvT0s0TEpI?=
 =?utf-8?B?SjdIU2ZsdWFqNkJaNDVDajV0dVBhc0hPVGwzN1hJU0dxTmNwUTNMSDJLZGJE?=
 =?utf-8?B?NUhiOVpDTitPZ2VpUGxPY01Kczd0NmZ5bEtPK1BMeGdVVmV0WEJLYTNRVTFI?=
 =?utf-8?B?OVdqNG5GR2M3cU9SVjJkeE4rc1V0NzA5RjA1bnYwT0lqNGtEWjZiY1UxQ3l3?=
 =?utf-8?B?K09VallZWVRnNUVTdDlRbXF0NUZwaGxaU0N4QkNYUlJremxqN0pMZVFqOXZa?=
 =?utf-8?B?YVlSTk5qd3RHMzJHTEttanQwM0dPVXlxcFlOOTlLZW1IVlVhL016eHA4Rld2?=
 =?utf-8?B?T05CWE1URlFHSVBHeUZsanJ0enQrZk5ZeWlPWXlkczFId0RPVGtZMmprRm5u?=
 =?utf-8?B?RG83TU84YjkvcmFEVFlKMEhDUU14U2cvUXBEYkRhcGVlQngvVlhTTDJTUUtC?=
 =?utf-8?B?aURLWGNKODM2ZnhYTW16VzE0UEJ5UXZJdHhEYmozbE5TMEdEeWJ0TXVUYzJF?=
 =?utf-8?B?S1R0MXM5RnUvY1FaemFKV0p6bElwalBKMks3ekFvRHZKUXl6K0dCUTlWWFRK?=
 =?utf-8?B?VndIK0JoRUVsNmtSS2ZleXBvaUNxNWJldHBrb0VlRVlPcWlMcHZrK1U0a0t5?=
 =?utf-8?B?RjRZSGRYaDhwYUNZK3IycEtUNjZhUkx6NGdDTnl2VGpxQ29reEdIWjBhQThH?=
 =?utf-8?B?UFRXbmhGZEI2MDF6Y2ZyZ25tSUExVWI0UFJreWY3WFY0cS9yUSt5cDR2TmNL?=
 =?utf-8?B?cllNMjlNQ3FZYnZVTlpZcmVvWnB2R00rZFUzQjRYdmQvS1hnNG1xbFRUT0l1?=
 =?utf-8?B?OWJQNFd0ai9aRWVCbUJnaHlkRzJrUkVUbEVPVEU3MHRzdEowbWw4WXJFQldX?=
 =?utf-8?B?c1JJT0s3UFlPOHA5Vjk1T2FEMWM5OE1FZVdwWGZMa0tGNVFCSUtjQlF5NmJZ?=
 =?utf-8?B?dE50S0sreDFJSGI0aXRkK3pQY1k1Lys4WWtielQxOEdmaXkrSVlpYXBTT0kw?=
 =?utf-8?B?aC9iTWpxQWJqMVlRR1RreGVYazFyMnl0U3NjQUljdU04N1JIeEt6V2hIbWpv?=
 =?utf-8?B?Z0prQS9qTGxLb0NZU3pYV3RKemk1YzJ2UVhuMkdkZHIxa1hKMzVVcmczdEdC?=
 =?utf-8?B?cmMvVnFIelRveC9LV05nMTJnV3lrTEdXRUluNmRQRUx3ZTE5clVMNEdNUU5P?=
 =?utf-8?B?REdoMlFBMnJyOHA0RDhZTVBoODVpOUhBWERhMmVzeW1QVW56MWJINGJuTTZ3?=
 =?utf-8?B?V0xmYnJZWUI4WG9YckhudVQ4dkViTElvblNPNm9mL0ZwbWNGS0xpeERCdjYx?=
 =?utf-8?B?OWZKL0pzUDJiUkc2cUhCNG9NY2tBMFlzV00zS0lMWEJ1Vk5lRHdaU0lHWkdK?=
 =?utf-8?B?YktnNk9kSFJPaStoeEtwenNDaEx1R1I5Y2UzK3gwaTR6MXg2dHVGVjFFUTU5?=
 =?utf-8?B?MTZxakNMM3FzWmpodVp1d3R6WkE4MFlNMVJUUTRRbXhCMXVQRmo0SkxMQkEv?=
 =?utf-8?B?V1Y3QXFyL2NwQUVFTTFLVmp0YzMwajhyTTBCQXp4ZTFIUWtWQ0g1cmppQmFB?=
 =?utf-8?B?bWNJQlIxY0MvaDVQcmZUalFBNnltbWJLRENBVWFNRTJ6SVZJSmQ3MmxHNTU1?=
 =?utf-8?B?YkF3VkNHV2I4OWcrVVR1dz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB7982.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cnErc3Q1TGxicjZBaVNVQkxWNXp3VWFuRVZpR1ovc0NXNDAyMVpOVS9aOE9p?=
 =?utf-8?B?ZytCejVVWnh5MjRLMjhyRGRxTmROQzFPWWNzS1lYeVY3VG1CMzNuQllRaFN6?=
 =?utf-8?B?TnoySzJucG1CTm1jbWh4dno0djFNNkZvL255ZXRuRmxGMEtndTlOMXNndzVo?=
 =?utf-8?B?dGVwcjlkOWRaYXk4Q1M4ZXc2bFFQVDFLNDhlLzNUaW5qcm1ENmRwS1ZTY2Ir?=
 =?utf-8?B?QXZQVWhmMVJTb084SmNTSkk5VnBRdTZrbmFvSDhQRHc0RXh5WFNFMGF4WmVk?=
 =?utf-8?B?OGZqd00yZ2ZvUSt4b1NCRUhjYnJtakZJZ3lMb1NSVklOWVVPb1JBcHBhajRN?=
 =?utf-8?B?Rk5QVHA2WWljQ3dsaTdGWitmYXR2TTRlMEo0SmxXUk82YUFJUFBaQlNjYnFS?=
 =?utf-8?B?UlpFcndvR2RmN1plY0xteUQzaEQ3WUhoRmMzYWdDTUxnWDhUeUszNng3bnRv?=
 =?utf-8?B?MHZlOThpUnVwVUZ0bWRmQ1gvVm85SU44WU5PTW5BYjUvckhJWFlnaXZ3SDh2?=
 =?utf-8?B?UGFETE03cWFFWWIvQVJCZXFrakhjRkI4dk1rditNZXJsUTczcmZudnJwMmpn?=
 =?utf-8?B?YWs2elhQczBkSFV5Si9LY1YzY3pYRnhxOVFKOThNQ0swOVNSb1UwdHM0VVdS?=
 =?utf-8?B?Z1NmRUpmTW53WnJ5WmJpOFROeW1OMXV0QlRWRjhXdldCUUFzSThDZzI2NmVD?=
 =?utf-8?B?TFByVmtoZGhMV1drK2FSanZOSXp3UFZTMmh2cG9DUEQ3MUdzK1k5Vzh0cXFq?=
 =?utf-8?B?Z0JXWXhNcDFHVXpZNG5CTW0yYU1tRGZIa2JuVmpiUXlHSjI0NlJIbStUUHZ0?=
 =?utf-8?B?RVordTd5WVV6bE84Wk04Z0ZzbFFJRUdDdGJGMHNaV0FpdDVBbCtsWHpIaDlu?=
 =?utf-8?B?VG12UWtSOVluY21WdE12M0Z0dS9qdWRlUllrVFNlTFJRUzN1Vm1rMWo2UXJQ?=
 =?utf-8?B?bFdDdHhmZkNkQUFBY0pScERBYzV2UEZzby9kTm9Xdm9sSXVKU1ZZUFhDTGlF?=
 =?utf-8?B?bmtRZ0phbjhPemgxZ2ZVUDFsQ1NxU2RVUFhVSzhkMkdtVWJ5TnJuZFV3bVBE?=
 =?utf-8?B?OEFjWkZYMzduZll4K0pNRjVGVDNpc1FZZmU0K1ZCdXM0YmFXOUdrVnZKSjNT?=
 =?utf-8?B?R3gxYlNFcXRVSUVRSUNyOWxIZkw3c0J0RU1sazczOW5hUWRaVFVCVGRzY2Ux?=
 =?utf-8?B?Z3crN2lzck9icStCVGF0c20vUDM3eGdNRDhBTzR3NUFmcGNBa2djaElFT2Ns?=
 =?utf-8?B?TFhSZy9UT1drMnhsaDV5d0k1MDZQd3RndlNuSzBsQjFNL3pFYzByT2xKOEZ6?=
 =?utf-8?B?ZlJmckZkbmFubHBjeWxOalYyaC95WmFtb1BPS1pQTXZray9jaTNFYkZJM1p5?=
 =?utf-8?B?ODhYZmJwcjBzekEveFhiL3NPRGVsOHFQZE5JNi9XTlFXdVErQlF0MFQzeWFK?=
 =?utf-8?B?Z3JIeFJJZXV2SnVTVmdOVXpKWTJiSDl5WXRxam9tUmp5R0pRajFQWnVaMXRv?=
 =?utf-8?B?M0NrajlxanJ0N0YxcXB0VzdqVTZLenFZRU9rN3hjRWxiWFc0Ulp6di85UEY2?=
 =?utf-8?B?cVUvbkxjYlVBanpZK1dQZVRPb1NrVVN5bmI2ZFhWNXdudEdELzVlSnhLeThP?=
 =?utf-8?B?S0JFVW1Nem5pb0dvTy8vdzBRM0VvN2NPcHlRM1BLc29XaHg2L01ESGh5MVh0?=
 =?utf-8?B?dTl2M3huV3AxVnc0WldCTU9lTG5YUTZZZytzSUltOVVFVmdkRTNnZlZIYjh2?=
 =?utf-8?B?VllXYS9CR0phM3Y5SDE3RzE2dmlmUEFMSVQ1ZmlZUWJJekdzYnRVY0JKQU1Z?=
 =?utf-8?B?UVhydjhRY2FXdnhiSTlpOHplekw4SjA5STQvMUgwU2EwRnVPVk5QTlZvOG11?=
 =?utf-8?B?WFBiOG51WmdqUHN4dkh4TXRjOUFOeVhzd0twa280akZNTXNhYkVuOWt5NWVo?=
 =?utf-8?B?OHM5U2grcDlJNlZJcWIwVWZTQnA1WUVPL2NDS2R0WVZTMmpDU1NHeW9jcHhk?=
 =?utf-8?B?aHJneUpjZ2JQTEdqdHhQNmNLelYwSW81bHNkYkRvTHdXeVVrZSthZzFiZjNT?=
 =?utf-8?B?WmV6bDQ1TGNSZWU0d29sQ0VhSmJlRGxYM2NLZ2QvdnVjcEVxZEk3Y1QrWWkz?=
 =?utf-8?Q?Q+vOEjs4DuXGlf1vg+3HFctCw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 470f5447-0bd4-41c5-3729-08dcbc8b1073
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB7982.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 18:01:04.3412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e2uBhTNh/DwNUIkqI4N2ASDfwbEw/JV9CX2ddhQhQpWqh71q6cHVJeWOOStkt4deHAEDX/+cGaGLrx80BAvjIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8593


On 8/14/2024 4:33 AM, Joe Damato wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> On Tue, Aug 13, 2024 at 04:41:21PM -0700, Brett Creeley wrote:
>> The change in the fixes allowed the ionic_tx_cq_service() function
>> to be called when budget == 0, but no packet completions will
>> actually be serviced since it returns immediately when budget is
>> passed in as 0. Fix this by not checking budget before entering
>> the completion servicing while loop. This will allow a single
>> cq entry to be processed since ++work_done will always be greater
>> than work_to_do.
>>
>> With this change a simple netconsole test as described in
>> Documentation/networking/netconsole.txt works as expected.
>>
>> Fixes: 2f74258d997c ("ionic: minimal work with 0 budget")
>> Signed-off-by: Brett Creeley <brett.creeley@amd.com>
>> ---
>>   drivers/net/ethernet/pensando/ionic/ionic_txrx.c | 3 ---
>>   1 file changed, 3 deletions(-)
> 
> I think fixes may need to CC stable, but in either case:
> 
> Reviewed-by: Joe Damato <jdamato@fastly.com>

Thanks for the reminder and review. I will CC stable if I end up needing 
to re-push a v2.

Brett

