Return-Path: <netdev+bounces-150641-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB64F9EB0E0
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 13:33:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5A8A164490
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 12:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33BDB1A08A8;
	Tue, 10 Dec 2024 12:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Tx2hydeY"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2074.outbound.protection.outlook.com [40.107.96.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E33A19CD13;
	Tue, 10 Dec 2024 12:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733834009; cv=fail; b=IUdm/0DACwzRzxNrm5Y3fUfl+tcueXImbs34rnSlh4Nz5z8B6Ro79oQQNQLkwbbylINpNm3TYxrn2+FQHYDrJAJGZUxMKPtrJJkrUFtzrNQQGbdJaRmpWXVzBGP92Ea/iHhvApM041brzlrI70j5mGP7PFJH4mbWk8CRjYftENE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733834009; c=relaxed/simple;
	bh=2O8hUZpm6OgeUL144wj/sJCosPYPJDMlwUjvLIXAERM=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bkyWivJkb04V8jHShN8HUjrWCHvkW0+9JourJFUcmJFO9JHJ9TuJk/uK3SFwplCiWNEKzk6R8LnaCGmJXBjCXcf/tT+sGdG4ubKaKX5o38jJWQnfC6UxiEydtkPyyPDzQKF3VB2bieQCX4F4e1STXUXKef6wANcqTWFtNdjr1y8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Tx2hydeY; arc=fail smtp.client-ip=40.107.96.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=igUyVd3t2cteFdN5g5MiRAn6p0euIDYSKzhz0S3YZetS0ET2fGqlC0ckUwkAZhZTG4FqAdEhx2GgtAYc/4vVDPv2F+QRo6NjXkXYiiq4t0CoddH9X5ddw2Ds7ksy+cF90LeuIAhOwff56BAr4lNLabBxIfo5zg1S4eLK2Uihd+H4FyHk6qiqBsZz9NidXWkuBPWe3LhIXBuObwtFf45lTlfQDL39BRBEbPPS8VUtr49orygeNcLpYBUXwG90i7MJV548Pg/dDYyHFDI0JQUgsta4H82HulQInSykSqhghtG3xr7+vhmspkRCqDq+AhOOznNiLjZ8m3d3w8Rm6fPxNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2O8hUZpm6OgeUL144wj/sJCosPYPJDMlwUjvLIXAERM=;
 b=tHSZ5xES/clzZYbjHfiJf67pX67Ysm0wmCwrJXnApHSWfiuo2Sq+PCmFkX2XGBsn0FcQ4iLoMQbDqAex1tCtuYf6tRKjQH0CSLhzZP7KOryr9oNM9bAY+BfnmJ7YYIcUa1KYeF2/lqpkSyEqj6G8se6b78AuyrYOTJ3dfofcjyFs2W+wEbkI4pYX/a1BasKXn6ChyrljqSEAIQtR477gCDdQkVDEq3u4dF+fLvkCtH9SaKcN1DP8Tctkd4RxwvfNiaNzv79Ut7yB8qEbwkW6PIgv0UInZg9ZwEMCezOLp01JZVbvsVq4XIFtLL3Dmch0YXlHEnqPmkxeskt0NCbLGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2O8hUZpm6OgeUL144wj/sJCosPYPJDMlwUjvLIXAERM=;
 b=Tx2hydeYYHhyRfYZhgNWHUPA/kJEEcljcw9trc7lgUOznu2R2231ldo8HoZgcAGJvXXdw+nnsTXR4BX2RXtyTIx8CrGfVYmtYrd74oQQ9aPbkXsRPNyYQP4wB5l6URbz00LxexexsNtjfpsChDEFxC6yPhhK9qUZvvKnJoPuCcY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by MN0PR12MB5713.namprd12.prod.outlook.com (2603:10b6:208:370::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.14; Tue, 10 Dec
 2024 12:33:24 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.8230.016; Tue, 10 Dec 2024
 12:33:23 +0000
Message-ID: <9278bfd0-7b33-7b19-28cc-d860fc925530@amd.com>
Date: Tue, 10 Dec 2024 12:33:18 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v7 13/28] cxl: prepare memdev creation for type2
Content-Language: en-US
To: Edward Cree <ecree.xilinx@gmail.com>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, dan.j.williams@intel.com,
 martin.habets@xilinx.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
References: <20241209185429.54054-1-alejandro.lucero-palau@amd.com>
 <20241209185429.54054-14-alejandro.lucero-palau@amd.com>
 <ff0d8ed4-8967-1482-c838-3b3498506914@gmail.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <ff0d8ed4-8967-1482-c838-3b3498506914@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0439.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a9::12) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|MN0PR12MB5713:EE_
X-MS-Office365-Filtering-Correlation-Id: db9e3901-969b-49ae-261f-08dd1916d676
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cTd3NW12cVNhemp5bVZtTDJDbnFJWWQvSDJtOGUxSlczS09NeG5Xc1JBdlg4?=
 =?utf-8?B?WTB2K1ZKa0hCTFhjTTRpSVpSQTBoQ0dQd09XWldXOFFsQ2Z3OTk1RExWRytK?=
 =?utf-8?B?dnBIN2hvVHUwcW4rSG00aGJDNjYydjVNQXRnZ2xONEV2ZmNVRm9xdzRqWUt6?=
 =?utf-8?B?Y0pBRkt5WlE0b2xUcTB4UzVMV1VhZ3lZRk83ajVWcDVCcWNCaGxrcWk4VUk5?=
 =?utf-8?B?QXRKbGVBaHVTMlp2NE1PZUh3UnZkeUptbEZmaTErdExFMkthS2IzT3J1dEgx?=
 =?utf-8?B?M2NCUStXRVRsNCtXVUdib1hTdGFGY2x1VE5ZQUZFRm95WmtlVEtiWlh0UXZ0?=
 =?utf-8?B?K25aT1hkRE9tNEN1eDdCQUk0L240ZGJxbk9jQ1dFYnI2cE00ZFFKbXQwL1FD?=
 =?utf-8?B?U0NxUXdlNVJUbnJQS296WkttcWhwSUloQms4dUtQVnVNcHFOczlOb1pBYXRG?=
 =?utf-8?B?Tll3SUtWZjRXZ2Z0RVZHZXBKdEk2RG9FZlh4SnQwNVpERUhlT3JXTnZna2hm?=
 =?utf-8?B?UU44TmpEZ1c4SVliRjJlNjZYdzFLOW9LcjBzRW51S0dhM1ZJdmxmWGpWLzRh?=
 =?utf-8?B?NFltdmN5NkUvNlNscmRvRTdwRE43azlMME1Za3VEanRqZXNLcXNWV2ZNbjRs?=
 =?utf-8?B?bFg4ZjFuVGxsN0toL2JZOU8xSE94NVkxTXRvMzRhZDdqQ0pzSTI5bGNCSldY?=
 =?utf-8?B?M1I3UFRtN1BRUEo5b3g4QllTcFBwRmZPZ1phZFRHVnphbDViaEZoNU5UWk5W?=
 =?utf-8?B?UUlXRm5RSDhnZGVHOVV6UjFuV29sbmNPQks0dGZjTE81bkl4ZkRsbE8wbENE?=
 =?utf-8?B?YmxBVEZPenZhL201dVRKVkVEMzR2aDN1dWdxd2dsK1htbjM3TS91bG1nZTdW?=
 =?utf-8?B?clozZ3MxZlU4UE9wMzdwUUE2OGpRdnkvMmoxWUp3amxuUEV5dEo5TGR0QTNt?=
 =?utf-8?B?Q1FVQUFoWXB0bTBUR1pZZVl0MXo2anZDRG1aaWQ1L3hSMzdjT3U1RDY5Z2lq?=
 =?utf-8?B?UDFDQlNNYXZiaGMwV0k1YitadkhpNVN2NDlSWjhNbnJDZ2JudHJvazllbkk2?=
 =?utf-8?B?NGVtUlFtc2t1UEwyb0xHRWZFNDkzSjlBMHBKZXNGZjdKdEdWc1M2Y05EZzRF?=
 =?utf-8?B?TWNEQkd4WHpKb1QzOU5rUW5OQVd2L3NKdzhqcWZCRUJnb2x1dlZtS2NoQlBn?=
 =?utf-8?B?SDF6RDRyNDRLelkxTGszQ1JkYlJ1endCSUoyR0pWUDhzOS9RMFRzMlBDTlRY?=
 =?utf-8?B?U0VLVndueFdjdWplVUMrMTZoUlVrS0dlN1VxYWV3ZU83MEZJUXE2WTlMV05j?=
 =?utf-8?B?K0VuWm9VaVkvZnpobTNsUi9vTjFXME9md2hIRmNORzZNc3FqTnQyMUd3MmRy?=
 =?utf-8?B?dXhYUVdiQURjY3BqUVk2cWFPc2JpY0JPOUh6V2NGc0hRanNoMDdsaUpXM3Zs?=
 =?utf-8?B?VlpVaXBjUXc1VWFRTTZXREQrRjdZNHU5Rzltams3V1hPd2JrUXFSS1N1dVY3?=
 =?utf-8?B?SmZuMEJ3ME4vNkd4Yi9oOGhpdDZhMVAxTzAxajh6cHAvUlBnaW9MMmhhREFK?=
 =?utf-8?B?Wkl0SXk4RDQ4UWt4SWYzV2VrU0M5QWJqQUtuU25XM3NEbUtlSkp3UVBtL2Rs?=
 =?utf-8?B?cnNJcUpubTRKaU9zYzczcHNtRzFGT2xkam5CT05jQkNXRzZqUjJHVkRiaFpN?=
 =?utf-8?B?dGROZjMxUUh2R0FxL3Z0QU9BbytSdGh4TlkrWVhZUThXc1NJMkVLbFJ4bFVj?=
 =?utf-8?B?amJvWjlTa1h0S08xVW9tTHpSamlZdmgxMGF3bUJTdFpIeDVTQnNld2ZaY0Nv?=
 =?utf-8?B?Tmd6cFVBQklSeW1SSzcwZ2JFL2c4UHV1N3RHWkpqaTVScThzQWZydTdudG83?=
 =?utf-8?B?MGtsZ0RjYm15NjlRTmVXQTQ0cjdpM1EyWkI4R3hjTkZJZnc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aXhORWkrVnU0UDF1SUpaaWJsZlZpdGd3d2RnSU5PZ3J6MXJhaUdJYXBtT3M0?=
 =?utf-8?B?Tkg1SDR4MFBoYmxhanlKZ2hoSmpoS2FZaVZIZXNWcWR6RFlmMlh3dDVZMnhQ?=
 =?utf-8?B?bHg4SHBkZWpTMDBGQ056QlordXdaR0RwcmR0SDUxcWZEZHpkcm5kR0IxNHNq?=
 =?utf-8?B?VlJzUG0yNU9WV0Z0cXFTWm1KQ29IaXZwV09MaGRtNGJWZGpZMldlTm54Sk1H?=
 =?utf-8?B?dVJSNWR6YXcxVzNrTnVmZDRGSXpqT0U1VmZKVFF2bDJVcGJ5SDFVbkU3SlJI?=
 =?utf-8?B?bDRoeEd3SUNBMVZlZWFreDRacVA4ZXk2UTlYZWFBQ0x6VHJINmhrbnJYRTN4?=
 =?utf-8?B?R3RQZHZYdFEyYmJsTFdRc2d6NzNlVEJVUVNaa2V4azlPS3UwQVNUUjNQeTdZ?=
 =?utf-8?B?cVBIenhVUUpaVVZLSUFBZjNFN2k2WExTb2dPMzBBdFpkSGM5Z3RsN2tiM0dp?=
 =?utf-8?B?UGJrV0ExOVhhY0hONE43NkxISklWeUlieWlpMXRXODVnVW5ZdzFEQVYwalVF?=
 =?utf-8?B?TWZCSy9sYmtKMDBYL0RpZjZjWllIVmRYeVgwcGNoYnF1UlF1OW1pWktUdCtX?=
 =?utf-8?B?amFBaC9kL25RS0wybjVYdXZITUFtQThKMkM1Zk5Xa0o2Y0g1M3R5cjVhMFVM?=
 =?utf-8?B?dWg0Tnd6WHZ2Q1FrNWlwN2dxcUNkYmNQdno0ZnVRaE5BQ2tqWDZZcVlBaytK?=
 =?utf-8?B?cDN0amxjaE5OVlpieXlxT2h2bEg3clRLZkhFUitkTzdmSGg0dVhYa1BCM01m?=
 =?utf-8?B?L21pN0RHdDNKVW5BeUZCZ213amRBdTdwNVl6cFBseStFUUNPWE95NE43Y0JI?=
 =?utf-8?B?Q1JSSzMvUm9ieUFtY2FqTW45bEpYVStEUTM5YlhuUDNPU29EYlpZclpkQXBG?=
 =?utf-8?B?Qlo2eDZiNExEMXJOS1B6d0pHM0VuejNEbWpnRlFLazM0QzhseXQvU0o2eGY1?=
 =?utf-8?B?bXkxK3NEV2VNT1ZkWWJCQVF0V0NueTdZNHdrMWdNUzM1ckt0WktSZUNGTnRh?=
 =?utf-8?B?VVU5Tm1QcUlLOCtFRFRkaEpvWUVYQ2pLdVBWbzRmcmRaMFBnUVlkdUx6NG11?=
 =?utf-8?B?MDZDaW1WYzlkNnc3Mit1THNsUHUwWkdUZlp0ZzRGbEZkSmpwQkJBS0p6SENt?=
 =?utf-8?B?REhPWmtwWXZuTks5OXdnWTlaTVRYYzBkQWhpdHVmMHh2OHBvY3NZRlhmNVZP?=
 =?utf-8?B?UE93NVp6TEs4d01xbFpDanJwQmdTMkJJY0QyaldjQ2R0blpUSEVuUk5XZlBQ?=
 =?utf-8?B?d25wdTIwUTk1Q0plK3VxY2k0eHZmeTBjZGp3dTY2Y2hINWhaa0lXLzl2UGtP?=
 =?utf-8?B?TTBQQ256QTYyb3JsSVhkUjIrMUJaOVZMM3ppVHArSDBQM2x1a3grWkdhL28v?=
 =?utf-8?B?RHVFcDdMNFc5NGorR2wxNC85NGJnQlE1Z2NwaWg1bXN1cysrd1l6c3FqSUFC?=
 =?utf-8?B?SGhMakFROXZvUnBucVlrUUpJS2JvYitLL0MwOEFYK0l1OW5ITzU4K1gvNjV1?=
 =?utf-8?B?YXhmREhMK0MrWk1hdGxDVjFXZ05GbVZFM2tFM2J2OWpNVTBpWllLVHdMYzBY?=
 =?utf-8?B?bjZzenYwT2FQa2hCY0RraTdJUCtZb1N6RWhkYjlDQTJQN29yT3UvTm15b21m?=
 =?utf-8?B?RVhUeU5qcm9VNlhyOXRZcTRHNXF3L0xkWXV1OHUvSU9hbG1NU3N2Q2RRYXZv?=
 =?utf-8?B?WWhTbUVxUkpiS3A4bHJtdmpBbkZLSnNXeEE1Sm1jaHFwamlZTDJlRkkzR1dT?=
 =?utf-8?B?emtDMHp1elBvSFhWTkVmM0RnSkkzT2VKREJRbFIyY0JEL1hLWWlMSWxOcFBT?=
 =?utf-8?B?MmpVWUVLbzlVUUxrZzBJbEFPVjdWRE8rSHpCV0NvU25MY2NXN3RNUlg1YmEz?=
 =?utf-8?B?SEhFMHdzMTZRVURnYjhvZW91UHcwYXpCMnEzL25aamFVMEd0YVI2dnVQVHVB?=
 =?utf-8?B?OEpNUkVhV0c4YTc0YldWN3F1QkFvWVFXRGNReFJtR2g0dFBOUDYxUjBMNC9C?=
 =?utf-8?B?dnlKblJOZkFaNHNNM2o4cDd4R2V5a3oxSmVlUmZhUFRQWmpDSE05UjZCMmZo?=
 =?utf-8?B?RzB2N3JrZ1BVT0xIdWVzenBBWlpwK3E5NUdPakQwKzIyNUZSR1VkM1Q2My9m?=
 =?utf-8?Q?YapC4NgGu3wfP8MCI9g6Mt/+B?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db9e3901-969b-49ae-261f-08dd1916d676
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 12:33:23.7398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rzAJOOhQoK/gZQqeQdiBUVxu2f05s7dfRo4frpqmqqddG/G/YcdI3garaxOnwzknL9ragGm+CuRxUnq2f/O+Rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5713


On 12/9/24 23:30, Edward Cree wrote:
> On 09/12/2024 18:54, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Current cxl core is relying on a CXL_DEVTYPE_CLASSMEM type device when
>> creating a memdev leading to problems when obtaining cxl_memdev_state
>> references from a CXL_DEVTYPE_DEVMEM type. This last device type is
>> managed by a specific vendor driver and does not need same sysfs files
>> since not userspace intervention is expected.
>>
>> Create a new cxl_mem device type with no attributes for Type2.
>>
>> Avoid debugfs files relying on existence of clx_memdev_state.
> Typo for cxl_memdev_state?


Yes. I'll fix it.

Thanks


