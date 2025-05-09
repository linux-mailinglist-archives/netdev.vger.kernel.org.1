Return-Path: <netdev+bounces-189156-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCFDFAB0BE2
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 09:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 875383B2339
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 07:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE38D26B968;
	Fri,  9 May 2025 07:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Q8C1IZDf"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1AD626FA6C;
	Fri,  9 May 2025 07:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746776428; cv=fail; b=ZY+NNoYMfuh6YzjdVzcEWO1atIA5EDE9oSUJjWIczmyICICQ4FqPobvSa6MfEN1ZHlHlPslJSIej0dZin2u41xqcKo84tJtUocO86H56YF00d8TZbAK8CuMHd7uhqJ+S2gNCpFBUyT3pQkrXlbJMr8qwwJdw9An0eHSV/4sKX3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746776428; c=relaxed/simple;
	bh=NabZpekFdwJr0Nw6prQywpeEWBgBpvOqttP6Db+21So=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tZugXmIQUW4yXLnzwrPQBctO4MK4WPEOq2tLZTz4NhuBwo2yOfcS4Fn4Y4OdF81yrQm+ltckibEDqh9XEtvzzEobGgnJSREnpCUuOIr7d4scjVPT/gNl5jD4kZxHKK3u+uMag8YJqnxgHvtivdQaTV3ONfdbE9fiQ/nwLTYKT2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Q8C1IZDf; arc=fail smtp.client-ip=40.107.93.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ktLPj6YJr2mzlwDcIWfTmbafk+6i9ycwt2zNwf7FHp2Hp6oYUhqT4bXKOhqb4LdS8CTh4VuGGnNr0Nm4NjoTHCiyQXDr0nL28xNuEGUrkRmNKU8Yz1qBdO0jkXujaTJjnCBMy/RlREElaedeA9L10kXA0YJyGJJOZPuwhlGHCzzIgBYEbV0wh3FSRvx69m9GzABtTJU4zDRRn3q6BZ/t5Ze1arv7JpDSbaAQJiUxOSQrCR+sr0puV2A5LUa9+IWHpKEtAx3LP3qckh9m8b7fhunUtfno4lAe7tUOKs6r7okp/7sJ9aGY5AZIsbOweHjSOPK/3iumPU3smktlRbiizw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O2VwW7n7c3R+qqOWb03YF+Vun/JodDd/CwSEyp69IbI=;
 b=lP/gMHtvIcqZoJ8tlrRSX7O03PHbfBEzYGgS2StldhSobsArvkNxX4KLQlpZCuDtrXbKPHADvffH/pL0NKaLcwp8dUpW2asHaBam93CoapcSwDGsu27vFr2N/bQNmd7U2QP5g7/VpCm9TClagDJ6TJTH6MUBkIA9SkhQy428B5YCZRPnR101VJZnkOf01em7HIqXJgNKlUa11A0c3Iy1nkxBuNq2b4h5KJDlZTV0UbfXAzfKUmUG5XdKDV0IiKv58VJKf2F58o8bZeQoD3nVFs46aD0e3zZqU2R9sfv/C+ARG8uJ9cSdR7DHa0G4Z43uRTFC2nBByA7HOAWV1HjfUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O2VwW7n7c3R+qqOWb03YF+Vun/JodDd/CwSEyp69IbI=;
 b=Q8C1IZDf7Iv6eOf8U4cPehfA2UpSOVPADQwpI2nQ2tYDmPDdJjNFUV/nSRJm3fzXbZUjHLIgfwvh0MJsQ8UEdbuwfj1buBcPkOEWuOwXsB/jFRzE5NQTR1ZSyHuTq2nAbywtPEwKAxUhONlALNW3mu91axsbaUE4biyUUJ1ozWo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by LV8PR12MB9136.namprd12.prod.outlook.com (2603:10b6:408:18e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.38; Fri, 9 May
 2025 07:40:24 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%4]) with mapi id 15.20.8722.021; Fri, 9 May 2025
 07:40:23 +0000
Message-ID: <727ecbec-1f5b-4397-bfda-9a3a4b891ddb@amd.com>
Date: Fri, 9 May 2025 08:40:19 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 13/22] cxl: define a driver interface for DPA
 allocation
Content-Language: en-US
To: Alison Schofield <alison.schofield@intel.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 dave.jiang@intel.com, Ben Cheatham <benjamin.cheatham@amd.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250417212926.1343268-1-alejandro.lucero-palau@amd.com>
 <20250417212926.1343268-14-alejandro.lucero-palau@amd.com>
 <aBzxnPdKuFLTKaM5@aschofie-mobl2.lan>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <aBzxnPdKuFLTKaM5@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0120.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bc::18) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|LV8PR12MB9136:EE_
X-MS-Office365-Filtering-Correlation-Id: 75b85008-dcde-4ab4-5ff6-08dd8eccc1c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TGVvc3pPRHpqRDEvNUc3QkM2U0E0SFJ2MXdjbVFsL2ZsRXFtWG5GWEZwd0lP?=
 =?utf-8?B?UU9jV011cGd3d3o0cG9IcVF6UGRjaGpVUWJ0ZVpKd3FmN0NHSW5aK2xLOEIr?=
 =?utf-8?B?eGovWlZaeklUQnc5emM0ZjNLVFVXMjBNN0ZZOVV1a0Qwb1lJdVBVUmwxK1R4?=
 =?utf-8?B?cmc4NU1ScUpLeVVMWGR5UHlKUnZzNEkreXM1Z3R4Q2hXejhGWHdVKzByK1RP?=
 =?utf-8?B?KzY1MzBkUmdFbTBHNllVUlhSaDRPb2N5QkNiclN0UkZOaGZpWDZPMEluS1Ru?=
 =?utf-8?B?Tlk5RU9BOVJHR2pTQ3FScTFkTDVSMFhValA5ZXkydWxqc1EyS3JudEx6MGV5?=
 =?utf-8?B?K3pETU56c3hxZHZIdVg0MEZwdERxVnZDeUtVd0p5a08wLzUzdHpQNVh5d0xX?=
 =?utf-8?B?NjVxSENBbUNIUTFMN0h4dHBlRnQ0bE92ODdHVDVpSGZBT2Z5NVpYTmhwZERh?=
 =?utf-8?B?Q2VOV3l5cG9HbVVJcmRzQVpXYUpzT0NBbkZFT2llV1RpbzVIaVFEZFowRGdL?=
 =?utf-8?B?R2JrTCtMR1pILzNaeTFNNjhrblhaQnpCR2VqdGYwM0hHVlJaREZJWnNObkFY?=
 =?utf-8?B?UmVTV25xVkcwWmNmc05iNXJVaFRwV09KdUU1WEhreC9jb3pDT1FNWmxGMVp5?=
 =?utf-8?B?ZWFWYzQ4OWtST3pMTkp3blJQckFDNytNcWxOczFDaVVTNjBlbDAyVGhqMG5m?=
 =?utf-8?B?OGwvV0ZqWXIvY2p3d2QwQyt0Z0lrRW4zUmdsdE1TODdpNit6cUZBR1FPTXVq?=
 =?utf-8?B?TjZYWG5pdFdMVnpMczhzbWkreVBDd29WZzY4VkpsamFYR1JtanRCRUk5L01z?=
 =?utf-8?B?UkMxSUk0ejlkRHBmN1p0RjIzVTdhc0UrM3FmNkN1YXRkZGJmaG0yMXdwQ2JQ?=
 =?utf-8?B?RWdCT2lJMDdwZmpROU9KQnc4c1hYajVQRE14Um9rVHRDWHZPdG9nZnlsRnMy?=
 =?utf-8?B?TE1qVjcxdjYwQjZrMVVkS2NYTVlsUmVQSlR6QmV4dkw3RVY1bjBuUTk3NHhx?=
 =?utf-8?B?ZEdPbnhOVkF4YWtnYUpWNS8yVTlQNDRkZFdrbFRETkdGTUpaNkJCbVlDeFNo?=
 =?utf-8?B?bm5xTGhuV2R2Qm1XcnYyWDhEZ0J0T2RGK3FrZ3VOQTNzdmdmQUdXZm02bHAv?=
 =?utf-8?B?ZkMzVFNKV3VQRXlodDZNdDk5UzlnendVYkdkeHFCNWtKNkg2YlFoVEtqcDJF?=
 =?utf-8?B?aFlNdy8zazVIMHJ3Y3NQWE1IYUdaSnphQnRTRlljU2xHTE94TXBubnVRclov?=
 =?utf-8?B?TmJFTDlFOERZc1ZQcXlvMTNjWGFyY2phQTgxd3RqcFNVV1MwMUdoakFqQVor?=
 =?utf-8?B?ZVQxZ1F1MDdTKzltWURrdUEyczhhRit5bXJ1aVczNmJyR24zMnhDcWxDdlNv?=
 =?utf-8?B?eHJRVEFUN3N1U0hRZXdLY3lhRjRxbE9GTVhUdXBNWUVPdlNKNmNxRlpXWkxo?=
 =?utf-8?B?cG5GUm1Ualk3NUM5eURtcHJxUXpka2hraXRLczZPRFk0MkFLN3gxV1hsSUs3?=
 =?utf-8?B?OExTU1VtVWNtdGh2Z1J2MXBEZTkzRmFBU29jd09NSkpMM003Z2V5WldkMmtY?=
 =?utf-8?B?MGI3RmJrT2J6TjZ1a1J6L2JmRFl2cURUVzVaSm9BY09ld1BkTWo4aEJmd2RT?=
 =?utf-8?B?ekk2bHh6TG5ZSEs0UjdDbDBNakhrTVRvbFUrK0dzODJ4WmpmWEwxNlV3cU5r?=
 =?utf-8?B?ZWowZWRWMjlFWUJpRTlkN2xxMmFqT09UUmtBS2FacHNURHJ4Y3gyVTM1RFJF?=
 =?utf-8?B?RFp0aHUyRDh2dFdUMDNvejdja0dEekV0dXZ4VVFqaWROWmZsVkt5TXlrTGVW?=
 =?utf-8?B?Z04rV2xNNUFWQmJiK0l5Y01GMHJUNnhBYVI5ZmwyVGh5bUdHejFVYWxBak9D?=
 =?utf-8?Q?KRcC3tPrOGrJ4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V1BjQkJCTnhPNlhHRGh4R2F2WmdIeWwzcWtlRUlLNHZxcFRMY1dvVlhUdmFa?=
 =?utf-8?B?dS9rMmdMci8vSTJLdGF4UmVCME5VWmd0TnRxUTQ2U1I2NDd4Y2NhWm1GYytL?=
 =?utf-8?B?alRaSXBtQ3p5NEUvajhXeFhrL3JjdHYrZVBQMEJDWGJTZkxQanFFbTZKV1hv?=
 =?utf-8?B?cTJER1RMR1V0Y0FWTVFESnNBcGtGa3l6dmxzNzREdHBLdnBQbFcyOVVkRDJu?=
 =?utf-8?B?KzY0elZ2L0Z1WUVPeXp0U24vR05BNFhpazZCMXl4dTFDRU83cEdNNldxbXFt?=
 =?utf-8?B?NzZGUHU1Z2o3ak5sd2ROemtNVk5CbUducXdoaDNoaHFoWHBNdk5DcjhzSkQx?=
 =?utf-8?B?cVdIbjNBSkJZZDRIOUF1TVJJVDZRekhpZFBZNTl6SkpxaFFhM2ZOU3F4T1Ur?=
 =?utf-8?B?L1dmLzBsLzlVY2MySXplUXlrcTlWUjV3SWh2UDJzWTNLaG03NDUvdXRnTHJ2?=
 =?utf-8?B?MzRqM3lEYW1Gb2Uzc3BBSXpsWDdXTWdvUmVia2JnVmdYbXhYQWxXREQ4aFhw?=
 =?utf-8?B?MVdCaTA3cGlnMFB6OTMxdDJiVUFSTkhqQkt2V2hjWW9pd1Vkb05qMUl3Vitj?=
 =?utf-8?B?S0FZQXhVamRPWFZlaCt0dTRmcmdFRzBMMmJPb205M0pFcmZ1OERQVUdSMEFK?=
 =?utf-8?B?akhUQ2ZMT0IrbmZ2U0pyYURpbVNUM1dNTVhYYXhuWVMvcHh1NTVnMVA0Z3p2?=
 =?utf-8?B?RkZGS0ZON1VGR1NnN3FuYmxORE5CMGNtSDMvMERIY0EwS0NXU0JhTTcxN2sv?=
 =?utf-8?B?bFJSV1pwcjdhTnpFV21EVzVDK3BGanpobjZNbG9kWlZTa25oK09RVUFTVUZG?=
 =?utf-8?B?aVFiZFhDM2pOMVQ4emRNZzRDZEU4QVJZSkdoNEJyZjFrTzY2anpxMUY0Y3RN?=
 =?utf-8?B?Mi9sWWs4d3p3WFdHemZjWEdZVG1CeU1BL0ljRThjODNSK0o5dGtBZzZiaE05?=
 =?utf-8?B?T2YwYzVOaFo5bHNRT2tvNkQ5dFZQZlRjSTVSODgxcjFETFE2WlJOOSsxQ0VV?=
 =?utf-8?B?NE00Y1hOTE5hTTZkMTk3T00rM1YxS2l3cURST09qVDhLTVhpSWJJci9zNGRn?=
 =?utf-8?B?dzJOTkIwMzBROFdBMjhsUml6RUdMVEgvZmc0VUZUa0c4N3FhaGRRbmhjbzgx?=
 =?utf-8?B?L0IydThYZFpvTC9LeVAvYk0vV2tIWGNzeGhzNjZQamZzbGFlV2pNYStid0dn?=
 =?utf-8?B?bGFqdFJGLzkxMmQ5NTl6dzU0OE1qb0VxN0E5S3dOVEZ0VWJydEYzWXlEYTIr?=
 =?utf-8?B?RVZVempuRGluWGY1RjNia2U3SWZTdGNvZjF3RFdCdnpwRDc4bDJsMGxYMWxy?=
 =?utf-8?B?bFZ5Zm1Ob2s1MFlWNEd0eFE1a1oycHVScHVIRGwzZFoxa25HOEtpMnpCWllX?=
 =?utf-8?B?R3VOYTB0dThHa3JqMnlGb1BsVXk0U3pmVXRsSEtHSDlaMU1WU0Z4YnRCMXly?=
 =?utf-8?B?NzlIWCtMWGVzWkJNRU0xdkpacjBYeTRUN3hqTmc5a2dqa29lV25xUHY1MjdJ?=
 =?utf-8?B?TmU3U0w4aDFnKzhkSFAycHhPYlRPTGJVZERZaEFIQSs4WXFDZzBRRmZqUExC?=
 =?utf-8?B?TnNFS2F5QjBNc0JHVHJ5dEhjZFBlY3hFcFFGckpiUysxUXdOTFo3UzFyNEk3?=
 =?utf-8?B?ZXprM1VOZDhCczVSY1F4TEF2U2lKTEw2ZVh2Q3FYTWo0VFVhdG90cy9vaXd2?=
 =?utf-8?B?dEVHcjA5MXFQWnVZNVM0ZCs5aVhPdjBGWlVNbW5NWlNEN3hSUmcvSzlidGZP?=
 =?utf-8?B?RjVkbWRSaVpZNDUxV0M4RFk2UWF5T0VkNGNjTUVoaStrbTIyVjR6NjRzc3pl?=
 =?utf-8?B?dEVRK0FuNGFHbmc4TGZUTnorUHBXMUVwTElFQVhYdEZTeDNtbjNxV2RObFph?=
 =?utf-8?B?QVh6bFZYS3BtMEREam5NejhlT0tmZEowWHFSaXhlMVdmamlzd3JsS3hhVHpq?=
 =?utf-8?B?MlRYRkgrdGtmQXoyQmdPeW5nVnpRUVBDWGEzajBEUmRJQ3grRVgvbkhUUjlk?=
 =?utf-8?B?ejA0R3FrYk1ZWmE1Tkg4OWk4eitzeTUvYlNiRnE0eVBrVkUxQ2l3VVYvallM?=
 =?utf-8?B?dE9Nb05tbFF5Y1F2Y1MxdHpaTnU1TE13dXdjQ2w0RVNNUDk2ZDhGdjNCZWVh?=
 =?utf-8?Q?+pGqVKX+jENXw3tm0fHuF4YtN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75b85008-dcde-4ab4-5ff6-08dd8eccc1c2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 07:40:23.8121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /oMKAnP2qXdsb6v+l6afn9z5bIFDPWDaEuKEVWYLmy7ggQDkYhXZhth/N5/CfoBHbzNaGNU0mmqIFR46TOckwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9136


On 5/8/25 19:02, Alison Schofield wrote:
> On Thu, Apr 17, 2025 at 10:29:16PM +0100, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Region creation involves finding available DPA (device-physical-address)
>> capacity to map into HPA (host-physical-address) space. Define an API,
>> cxl_request_dpa(), that tries to allocate the DPA memory the driver
>> requires to operate. The memory requested should not be bigger than the
>> max available HPA obtained previously with cxl_get_hpa_freespace.
>>
>> Based on https://lore.kernel.org/linux-cxl/168592158743.1948938.7622563891193802610.stgit@dwillia2-xfh.jf.intel.com/
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> ---
>>   drivers/cxl/core/hdm.c | 77 ++++++++++++++++++++++++++++++++++++++++++
>>   include/cxl/cxl.h      |  5 +++
>>   2 files changed, 82 insertions(+)
> snip
>
>> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
>> index e9ae7eff2393..c75456dd7404 100644
>> --- a/include/cxl/cxl.h
>> +++ b/include/cxl/cxl.h
>> @@ -8,6 +8,7 @@
>>   #include <linux/cdev.h>
>>   #include <linux/node.h>
>>   #include <linux/ioport.h>
>> +#include <linux/range.h>
>>   #include <cxl/mailbox.h>
> range.h is not needed here in this patch, nor for the set as whole.
> It builds without.


It mostly build without it. It was added for fixing robot complains for 
different arch builds as in here:


https://lore.kernel.org/linux-cxl/20250414151336.3852990-1-alejandro.lucero-palau@amd.com/T/#m8f5ad2153bc40fcc1213a2b062f57a4e336f5a7f




