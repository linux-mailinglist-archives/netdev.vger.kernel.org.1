Return-Path: <netdev+bounces-119677-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CBC2956910
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 13:11:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C11FD1C21574
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 11:11:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41AFE2209F;
	Mon, 19 Aug 2024 11:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SyjGDz05"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2063.outbound.protection.outlook.com [40.107.92.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E77C1662F6;
	Mon, 19 Aug 2024 11:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724065882; cv=fail; b=Rsk0CgDfO/tb/bRekkc/Jtn4OYbUI/13Jwqe+vcnLbspkhp2iW6L0OYDEmGK4f++lI9HRV7QI2pm4cI0ccEb2fDBZ90LcB3bJ8v+oewIwZtFEKdA+PV6/dMOfMFuuGLd4z6p2T4bYjtQlj+83N3SHrnUCYIEBgqxzLO26vqljU8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724065882; c=relaxed/simple;
	bh=3htM3uR8EMpzWOaEEAvoLSJ+TGOPsR124PlDCbje0zs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fOr/k3K+rFZ6ClwhpFY3rCqqbT1/GcYapTb2OVK0CcztkP8VF1Ut24mC4IG5ZEyb13GHuMo6LFVa75NfLs+z7ymR5/kOT1+Ce+Vy7bGv7waQ9Wwu0vacMhNbEFqytWjdxizFkI9mcAVn8T2k7QsfiEG4dW+NGdH43OU8eeMgLpc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SyjGDz05; arc=fail smtp.client-ip=40.107.92.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hTn9Hg7NIINRgfs3w18uGUdev0hDv/fYolxeffoPruqXsbsgZmbeXlFTEB/vseZfiUHuAKErMXIx7szdgY1Nn/172WBqubW8iu2Qj4RTC8cJU/HOw1MZXRu3ZtpsEN34d3EU/cXGYyd6OJkuyfYVjuvnN8DyDSDJI2UnEkUKWcyf1kE3z1nXSX6mFJZFAPsl/Mn58gNF69UU5JoViyCEow1yroVirMLMQrD1RXIp3Vy2XkUWrp/0MRfhXcxbmp2feHVRlpN7wnNDIrAlT35xDcLXJ9a7viwrRxqMdcOedzaKZsCItAtU7/7HFjPfzbBp3RiGrTlAew5NUGF9QC7FeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zgY2D1N16G2SskdIz6hdrNOfl5tM+5TUMlAc6LQ9snk=;
 b=BvSkVmC7pxj+tRBJGrDhg4uYMkAng9+w012Lx96plYIVKiJgFlnvKqx5tiyZhVfnxAN/JwAhv0rUxRwCEqb3ftg8Uiup8muXxfuANNTYeBQDMaofVhOn/vVbP1/Qn+qdedtPRyz8Z/xT0+LPD4HpK2gHrsXxwfVzHms3Z3UcwP0Z37/5at48P3UKL+Nd5MyD1jqSA/eJv/x2DbACnS3uoIoFLJjSqS+KdeQmmAYXskyMZwRXch/QHiPf6codsF5s4zhNjpl85TVD+OnqvV0NsXQzwrRlG76s13wOS5WLrOzVYByTNBLpH+eYqgZfl9uJUmFenQkRWLmmsHH+m5s8pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zgY2D1N16G2SskdIz6hdrNOfl5tM+5TUMlAc6LQ9snk=;
 b=SyjGDz05nsb8v1e11qwpJgBkT2aC47aAxYx53SyS4+Ujq6vvkBt08zqGoBK1cPogljc1Olm3BE+jgO1YyHNzmzs5rGkBcIcXH6PsoEJsZE+oRArZtraqUFuJNEHwzF9cRhiRV1CwlE9u++MSVqa7+MA++bmCgmcZT99h2vLeDcc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by IA0PR12MB8696.namprd12.prod.outlook.com (2603:10b6:208:48f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 11:11:17 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%4]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 11:11:17 +0000
Message-ID: <3b23989a-9ac4-6a90-bc5b-bb12377c0385@amd.com>
Date: Mon, 19 Aug 2024 12:10:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 01/15] cxl: add type2 device basic support
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, martin.habets@xilinx.com,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, richard.hughes@amd.com
References: <20240715172835.24757-1-alejandro.lucero-palau@amd.com>
 <20240715172835.24757-2-alejandro.lucero-palau@amd.com>
 <20240804181045.000009dc@Huawei.com>
 <508e796c-64f1-f90a-3860-827eaab2c672@amd.com>
 <20240815173555.0000691a@Huawei.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20240815173555.0000691a@Huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0066.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c2::14) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|IA0PR12MB8696:EE_
X-MS-Office365-Filtering-Correlation-Id: 9910cf48-7740-42ba-be38-08dcc03fa599
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NnM0Mk9JZnVuVnVXT3RYT0kvZDltakJTNjZaM2hiMDNpNjFrMnpvVWcrQmUy?=
 =?utf-8?B?Y1RMZ1VDV3RMbmgyaVB6QnA2L0JXQnoxdThlcmFYRkFsclQ2UTZmelhRVGJG?=
 =?utf-8?B?L3dGcVU2K1IwUldpZXdPd3Q2MmxGY0ZWTHQ1MnptcGljNWUyMFczNkliaFM3?=
 =?utf-8?B?ZDB3ZHdHdjJadVhnTzBxSnhRT28veEtPTW1uOG1ySVdIWnBMMHl2RmpoRDhP?=
 =?utf-8?B?M0FLNmhVK3pCUGRGeUpWMjN2dWhaNzBHa0s4bE14OFdnajNPaEhXMVJqWXNY?=
 =?utf-8?B?QWoyVVdsc2M0aTlscXdFWTc0Y3puR0R4MHF0RExBUDlwUVE4VURhbHBZaUpi?=
 =?utf-8?B?aXUwWEFoSWJYd29lSEs4V2gyWDd1Q0hsNzBzM1lUczd3RitPN1B4Qm1WTk83?=
 =?utf-8?B?cXdvTTJIeXBITk9HQitZNXJZZGMwbmtsZzUxd1BuZUNQSHdIQ3VTTmdMVnFj?=
 =?utf-8?B?ZVpQSzRJSWxUY0dPSFR5ZWlLaGJzUTZ3blRUK1o3dzV5aDhZdlI3VlVGWFlY?=
 =?utf-8?B?dVc5eEZvbHZGbktCL2c0UUtTWk5jY3ZCNzkxM2ZCYlBLakhmQm41dnJha3g5?=
 =?utf-8?B?TjBIWU55S1JKRXdUaHJVY1RVbnRHYU84NCtBeExkTXNUUjBpYkJtL2pONHRt?=
 =?utf-8?B?V00vaGNnM3g1SG9ta1psdGdaVHdubkVja2FTTTlFOGFBU1UrQlVyODVyVXFt?=
 =?utf-8?B?RVpLcG9iQU90QU8wZmZEM29pQjliSThOc0w3V2p6NzZJaVpuY2FCM1cybTQr?=
 =?utf-8?B?WUV3MlNpdTlvczFxeDJIVjh5UWJHcXlmQXBsZXNIVkdZR1NRZkJBRTUyWEVp?=
 =?utf-8?B?QysxZmk3bmppaWpiSXA1bkZKcnRkOEpCMFc3dWtkaVhzMXJkdTdldXltRkxY?=
 =?utf-8?B?VW5hbnMyZk1Veno2RGxoeHpmMDBEYTByajhmNVJsWjhhU040SEgrMjhVSFFj?=
 =?utf-8?B?VmNJaTcrTXhyLzJuL3hPUHJKb0VvaVBPelpESE1IVGNMaDNKWDAyYWRxcWpC?=
 =?utf-8?B?S1BaZllYWGtObjR5WmlKc0h5MGJPY2ZxcTVTUHEyWWZJdFJDMlZ5YjJZSzV0?=
 =?utf-8?B?OEdzWUppVVJuVXgwbWRVVkQ2ell5eHQ0TFpwbmNqcmsyeWNiYm5ETkY4aXZH?=
 =?utf-8?B?U0cxU1RxZGp1UHE3ZmZuZ1N3dkp0elhDVTVQLzM5TDFCZGdoWDkzN2hSakgv?=
 =?utf-8?B?SzBMWGtrUUdISHBVUG1qeXU5bjR0d1BQUnNXV255cTNOWTc2Tmc0T3BNelhw?=
 =?utf-8?B?RnBENXNiZlZEU3dELzQ5eGgwY3I5d0x3bjZsVDVyeTAvMXpoRDV0dm1rSjJp?=
 =?utf-8?B?OG45RERQRXhNZGRzT3BWd1dMY0M0VE5ielVPcEs4eWlVZytzalNhblR1R3JL?=
 =?utf-8?B?bDRmQWJCaE1mdWsyU0hlRStKcU5oM1dlVDZCY0NZci94UVl5RWVoMm9kUjZ2?=
 =?utf-8?B?RVlpbU9iQjMyN2UrSE1BUDBLWitSZ3hTaXF6RHhQZTVJeE4xdTh2NmdpUkt3?=
 =?utf-8?B?SUk2TVFMUk1QVTM5Q2lHVEtyK0JweEVqVTZyZkZ4UnhobHYvdkJnYlcvdzZu?=
 =?utf-8?B?Y2pQOG9TaStkdHVJNDd3d2p0a1dsMjNWK1RRZHdVczEwSmViQ3VyNjNwOXIz?=
 =?utf-8?B?QkIzYmdYdmg3TGk5LzlMRXVHRi9zWVN4R1hyRkN2L1VnRnZMdFQxS3JSbXla?=
 =?utf-8?B?V0RjSXZ2OWxnQ3dQcHY3aVZBVjBQTTZBNlMzejFMU1FmTDgwbTRYVzI3V1JN?=
 =?utf-8?Q?EOvZQD1nqhliH5CMtQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WG1xNk9ma1NIeFFYaVJEQ0xjN2lNQjNZUlUwaDR1QUg4WjhKdStHcmdMTUpV?=
 =?utf-8?B?MVVjcmFkd1Q3RjRnWlFtb3NEMThpT3hoKzhYcGgyWmp3VStWck15L0hOUzBH?=
 =?utf-8?B?NkpWK1M4RnpTS3VMN2g4L2lVMzl5QVVHZ3hidS9YaXFQSkdDdjRDcFNBMVR6?=
 =?utf-8?B?cUNNKzVLaHFadzBCMlJHQnk2cVVBNm8rUEZlZUVUdjJ4Rk1XZGMvdXdrNzBB?=
 =?utf-8?B?L1J2UGtMTm50Z05zdnExTjh6elJQZHhhNDRLYTJTVGRHenR3NnFjV1MrY3VZ?=
 =?utf-8?B?eTZndVlGNlk0N09KeU9QdlNHVWxxamFkb0Y1eDgvdWxnVmhFaU0wMWxBU3pD?=
 =?utf-8?B?Z2dGUzg3TUgwVlVBaUpRTFV6Zm5aYVJNbHFPMDdFdjhJbkRWSUJVWkROYXBj?=
 =?utf-8?B?bmYvY1hmS0JqMWpGeXZNZElseldFVjJNVEJVMlF6WFM2U01uOU5nZHVQVWJU?=
 =?utf-8?B?VGdHUmhwdGhCQzE4Y051NmFFeGJwRXlqa2wwU24zS2sydzZQblRtTXNSajJn?=
 =?utf-8?B?bUFmR2J2UC9YZklEdzdHT215cW5mRUpPbG5BSStkdzlVVnJqM2tLYjNSVE5y?=
 =?utf-8?B?MUluS09LR2ZKQnlWWFNGVXBCRjF3Vmk5bFNXeVNOOUE4TU92ZEJuYlRoa1Uv?=
 =?utf-8?B?cWxCVUpYT1BJVFpxUFFtc1dNNWQ5YnRBeEhDRHROMGFkME5vYlNKZjAxUHlP?=
 =?utf-8?B?djN1YjJBU2dGUXhyRU9EaUtyWDAwUnZXbWhjNHdHV09scFNsWmNYUDkyay9Y?=
 =?utf-8?B?YkFxWnRaRUJUZnE3TEdwQkE3WmM3cW0wZFl6TEZkaXVISlZhcGptQjdFWUls?=
 =?utf-8?B?RVhXbWJDYWlPK1N5b0o4ZDJEbkRQVFlTUWk0QWhkOE54K0JWb3E1NEE0aWdN?=
 =?utf-8?B?OU16MHNYYVptaG92ditVRFllaW5QTHExVHBpSFpRZ3RyVWFGNWI0MHlnMU8r?=
 =?utf-8?B?WFNHMDY0UjNVeEtmc0tKaWpWdE16YWMxUzFPWkU4VHJpQTVjTDVLSzNkWFhM?=
 =?utf-8?B?VWlrNE5vOFdTSkFYdVhTenlTWlVENWtzU04vYUIxdkVkcWpLR2lsR1RrSWVW?=
 =?utf-8?B?RkRPdzNSRnV2Uk9EL1dnSGo1dEJIRkIxZXJ1NEVZUHJ5eUgvRmxGRXVNNmg1?=
 =?utf-8?B?a3lPVUduWTJsbUNOdE8rQk9kOFowTmVyWWlXMmlkWmFyY3BuaXlsQUlDQUMw?=
 =?utf-8?B?SEZ1M01RaEFpaVhNa2d4N0k1S0FSak9HK2hjV1grV1pQcWlXS2JIODdsaFFn?=
 =?utf-8?B?c0JuS3dDN3p2dVN6NWQ5eFh4VTUvOWNjWTRoYis4dkdGc1lGK0hza0dDM1BR?=
 =?utf-8?B?bXRjanZYMjBIZ1A4Y3lpVXMrbjh6NURIbDgyVHF4S0dvYm5DVHduT0d3UmdZ?=
 =?utf-8?B?N21rR2oyMDVxRGd3R1EwNjQ1dkw5R09CcUNMd1JISmpUWFYrTkhCNWwxQVI1?=
 =?utf-8?B?b0R6SW04UHd3MVV1MXVuYkQvdytWak1jZVQzRHdvTjdiZDk1eTBIQ1duVjlW?=
 =?utf-8?B?TkVjYk51SW04VjZIL2NXUHY0eVE4N3VZVittc0lueWdVeUxSakQwa0RlQzc0?=
 =?utf-8?B?T2dGMkRxYmhPRHpyOGlRbE85YUxEOG12Y2RjWS8yV1YyaHVZdHZJMW9GY3Bt?=
 =?utf-8?B?R0lvOU9VVWQ1SVhSditXazhXK1ZDOHNwcWdnelIxN2ZmVXdHVENsVUpxdXVr?=
 =?utf-8?B?empkTkZVOTc4dkQ1VlNvOXhsWUtiWnY3eVBIS0pJcFlFZkc4ZllZdVFqYlpy?=
 =?utf-8?B?U3RCWkhZL3FaQ0hJR254YzNZcWdWZFRKUDFOcUgza3J0c3k1SVdmWUQ4ZUFt?=
 =?utf-8?B?OEpua2dwTk44SEw1aTZEWFFSalRkOCtUZGRUOXFrTHNMUmNLMm1kMEFLTkhx?=
 =?utf-8?B?eVF0SWlpM3NieHhKTnFya0s2cHR5akFBdmFkMS9UczVxaWJuTThrQk5MWTRi?=
 =?utf-8?B?eFNNNk5CQnhGTmtCTG41dHZWTmUzQm9VU1o1dXlhN3EvYnZGbVM2Q1hQMmcz?=
 =?utf-8?B?cklNUC9aK1d6MXBCTE5uNEJYc2JXdS9lVVIybTBiNjB2U0tQV3hoZFRJcG9v?=
 =?utf-8?B?c3pHbzdobTBscUJPaklGcUVwMXdzeEJUdUZOZXE0NGowamErN0RJekdQbGc3?=
 =?utf-8?Q?8ginfPafNzCdSeKC7XIdafToT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9910cf48-7740-42ba-be38-08dcc03fa599
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 11:11:17.6910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Ccf6/s15vQD6DuWcOHn9cXXxF4wc2SToCK5m2TWrHreoILrmQBMntKiU7BMndRu7DsGOixdz8Oc2jii53F1xQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8696


On 8/15/24 17:35, Jonathan Cameron wrote:
> On Mon, 12 Aug 2024 12:16:02 +0100
> Alejandro Lucero Palau <alucerop@amd.com> wrote:
>
>> On 8/4/24 18:10, Jonathan Cameron wrote:
>>> On Mon, 15 Jul 2024 18:28:21 +0100
>>> <alejandro.lucero-palau@amd.com> wrote:
>>>   
>>>> From: Alejandro Lucero <alucerop@amd.com>
>>>>
>>>> Differientiate Type3, aka memory expanders, from Type2, aka device
>>>> accelerators, with a new function for initializing cxl_dev_state.
>>>>
>>>> Create opaque struct to be used by accelerators relying on new access
>>>> functions in following patches.
>>>>
>>>> Add SFC ethernet network driver as the client.
>>>>
>>>> Based on https://lore.kernel.org/linux-cxl/168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com/T/#m52543f85d0e41ff7b3063fdb9caa7e845b446d0e
>>>>
>>>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>>>> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
>>>   
>>>> +
>>>> +void cxl_accel_set_dvsec(struct cxl_dev_state *cxlds, u16 dvsec)
>>>> +{
>>>> +	cxlds->cxl_dvsec = dvsec;
>>> Nothing to do with accel. If these make sense promote to cxl
>>> core and a linux/cxl/ header.  Also we may want the type3 driver to
>>> switch to them long term. If nothing else, making that handle the
>>> cxl_dev_state as more opaque will show up what is still directly
>>> accessed and may need to be wrapped up for a future accelerator driver
>>> to use.
>>>   
>> I will change the function name then, but not sure I follow the comment
>> about more opaque ...
> If most code can't see the internals of cxl_dev_state because it
> doesn't include the header that defines it, then we will generally
> spot data that may not belong in that state structure in the first place
> or where it is appropriate to have an accessor function mediating that
> access.


I follow that but I do not know if you are suggesting here to make it 
opaque which conflicts with a previous comment stating it does not need 
to be.


> Jonathan
>
>

