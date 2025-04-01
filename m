Return-Path: <netdev+bounces-178665-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 894B4A78193
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 19:36:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DC8916C7D6
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 17:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9456320DD65;
	Tue,  1 Apr 2025 17:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yxoqf8cY"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6B62045A6;
	Tue,  1 Apr 2025 17:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743528998; cv=fail; b=OBqiMUu3zh9xFVPKoY1gxOBZD+UhU+f2+cRWsgxFusOrn/OZfAFIfzL08ZOAzoeupMgkp5/o1kd7zXPrxW4QcdTK69SNaq5p4R2KxkD6vyzA8ghkOgXw3WuYqFTXYVKgC/Au13AWu8/ao8PjryRPvlEIPPIIwUomcCgW5tdmk7w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743528998; c=relaxed/simple;
	bh=DASGDBroU/sRDtG3DbZ6uBeeZ6TspORPopw1kd7gbNg=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VPhsN/TjedTZ+4grR/JRPRDaM7e6rL73GPugJZBm+6zoTw6+PvngQZZtof3hflSCGRnR41mzhGktZJreKKN8ov+Lt/w76gK1IfxLsrGL/w13ek3EM/7CgohIAeG/hmumM1NqR9kk0LbX4grc0W0zwxoXe1bFSgjvIc1g1ZXqH4E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yxoqf8cY; arc=fail smtp.client-ip=40.107.93.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MULTW5moJ25FiLcLBr7kO0cYkGrCgD+OzbvHpl/ycJYUKPgIVu+PLviGbjYHDgUP4JVcfbotSJanjJ7tG3XOXmIrYL4hPhHSGeNrQOb50uTwj/LFiSJLb68PmsW+ZDtQhfRXTdOxXuS0i27tXSrVkX5JTYd0wnRYQGf6UzdwRdwrgJUDboLXrLbjCfUC74UXVA6/Pr0UWS5MVp65CskqW5/VwO97gz7mqghwyxqmB++DJwJiamH1G/OzUtqU9T5O9nLWIqR1FhAtKTAUg1OvOzDAa9bALD4tqrT8iRgYaraYitAoMC5eqTeqEYG1cs4wbVpDLTAcfkhax5BCI92Mrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zqlbMpq6/c4jG2uYVNLEaG983CWEIupIIVtb0KPUO/w=;
 b=lV+gHtTjlRdQqju2/QhSrj5KPd3Kj6A6Vt24lK6X/EnUdEswd1Bv2ehIolwmbDZPWw91yai8dRNJfd6ASob/vDSUQjypp3eHLL6U1u2JeAC2bHILZZ0liSbgmj0+CQwu0FGlgCT/O8DkeqKeE42ZqsTajBNhUExEySS48VbfZn+GvcOqE62ZpTyJ2EQLe2Ia3C+RrSar42E5vMhvMct/iYfwFq5ijKbCat3Y0miu0F2mdaWe5jMrUe/XRPD6/U6j7W1rA76yrbg2tBv6O7H5QQXPx3IoixWOmCeOwapXJTKFWiEAgf8+BN4DXJzhfg1FOQ1TJwDTl5RfM4aOXZHqpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zqlbMpq6/c4jG2uYVNLEaG983CWEIupIIVtb0KPUO/w=;
 b=yxoqf8cYQjh8n/76xmbiE3MaxB/6E7F+e1HqJk2g1uxiBHM853KJV3ztxrLEJflCsvSVQRArN8uH+zVBRIhoCYmfOnFCEueTrvQexoALXowcEhikgc6S21F+J73b+/yRKn3SZ9/pyAo8o/Lz1KS9BI8Iztw25arZdRZl7Ds21Z0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by SA1PR12MB7126.namprd12.prod.outlook.com (2603:10b6:806:2b0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Tue, 1 Apr
 2025 17:36:34 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%7]) with mapi id 15.20.8534.048; Tue, 1 Apr 2025
 17:36:34 +0000
Message-ID: <09720c8c-a1bc-42d9-8725-14b208534755@amd.com>
Date: Tue, 1 Apr 2025 18:36:29 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 01/23] cxl: add type2 device basic support
Content-Language: en-US
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 netdev@vger.kernel.org, dan.j.williams@intel.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com
References: <20250331144555.1947819-1-alejandro.lucero-palau@amd.com>
 <20250331144555.1947819-2-alejandro.lucero-palau@amd.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20250331144555.1947819-2-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CWLP265CA0393.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:1d6::9) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|SA1PR12MB7126:EE_
X-MS-Office365-Filtering-Correlation-Id: f4274e40-7c50-4b9b-adc6-08dd7143bef0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bUM2Qjl0SnFBUlEwL2F6dmluVEpHYkY4NkZuSjhoUUN5QkRzbHNTK0FLWWd1?=
 =?utf-8?B?RkJtS28vKzRhQnQ5N3RVUFd4ZEZBRTlrUk54T3BMWHJVVStKMVd2N0JBbHN6?=
 =?utf-8?B?cDZhU3JDTVpoZnJyUGpYckRiRkZCQXVZdnZpZDJoUXNSVlBDZkI5WDBXa1hM?=
 =?utf-8?B?QW1NQmIyNHp6MFhSZElycnVVbE9EVnYxQlFxNkJreXBaTGRJa3Nkb1NmN1Rv?=
 =?utf-8?B?MXMzUTJGVHZ6blc5d2UwK2VUUGlaRlUrNXgxZldyNitDVklMbWRySExEVzJ5?=
 =?utf-8?B?dEJYMFd5bUM0SVFZNjErL0s1aWRMRkZYc1p1czRycDF1MG1ERlBYM1FjaE03?=
 =?utf-8?B?T2w0bTlFWVJyalZtamttTFhGUjhiM0FPZVlscm1QUlBQOGdNSEM5MFF6OGJW?=
 =?utf-8?B?Z0RGZTBNSTRHUi9qWXZDRnNvWnZZZU1yZUNsbVM0T0htK3N2TGtKYzQ2M3kv?=
 =?utf-8?B?ZjRGRkpOVGExUnBVS0VsR2RsMGVWTWJjU3czekZRT1ROcjNjRHVoeGNOYnpr?=
 =?utf-8?B?WlFuT0JWSThIbDFYUmoxTVpMZjUzYWZKc21hLy9zSEw1OEFrc3hwUzJGNlFr?=
 =?utf-8?B?UnBjT2hYWmo2OWtHTUhXRU4xUDR6RlBGNlcyaHFoRDdvc1Q0RWtldDU4M0Rq?=
 =?utf-8?B?cENsQVhRODJiK2FQSDVad2dXb0NVZkhMeHppTzdUZmF4eVY1dlVXK2VpMHo2?=
 =?utf-8?B?dm1SSm5Ed1ROV0RjU0xScTlRVk0zYlBFWDRXS29TVFF1dk4rNVh1MDVBTzFr?=
 =?utf-8?B?Yktxa0RjYmFhTExxRWh3TXhlTFp5OW1kVVNiK1QyZ1liaktJMGduTnJWcTMr?=
 =?utf-8?B?eVhNQWRscDZvUC81WjJoUFlCRXZBTEx5THdmUU81bW5QUmZ3S21YL1Nkc2VV?=
 =?utf-8?B?THFSNWhlMGhuVjhEem1memtLOGdhY2tNcXEvZjJZbUQ2czZETklML2UyNmNx?=
 =?utf-8?B?eU44RVY5allqTk45cUM4blorMmYwdm5VamhZYVc0KzdmMDhjQlFOVmEvU3NQ?=
 =?utf-8?B?N09pNWwrbzgya1dFTDlNWm9vWmMyYlpoM05kN1dmdmVhdnhjZW9lb01HMjll?=
 =?utf-8?B?Nmc0NVJGYkJqeGxMZVNEZVpVN09hTmd6U1d5VVpTbG1UTjJxY0xEVSt0dDAw?=
 =?utf-8?B?YnNoYU9YUUROSDNjWktnc21mNjV4ZkQzVVBIR0t1elBUWjVlUytCSTI3M3hU?=
 =?utf-8?B?RVpMck96T28zdXU2alkxbVRZcDVtbHM5cVF1aWdDMTZXRk9aY1FWbnNGdDhj?=
 =?utf-8?B?cmxWZUlUWGlmSzl4L1NNZzRyay8rTkhxNk1RY1djRnNnVjd3a2g1d3Vxckk2?=
 =?utf-8?B?OUFVdmFhZERaRUdGeVhqY08xZ3JRL0ZUSW5QRXBiR29MRDJCd0hGajcvVEo5?=
 =?utf-8?B?d2ZkazEwTDdRb09CZTMwQVBwR1BVSWY2UG1ydVh1YTdiZ0w2ZFNIWFAvN01r?=
 =?utf-8?B?VWZld3BveVJCWEJMTk04NkpWYXk3bHVRNGxqczZRS1hrWHhiK2FPSlFGeE1z?=
 =?utf-8?B?czZETXk4KzhsWk41U3ptV3FjOW96aExGTWRLK2wrNUNTQlVwenlKbGE2N1NV?=
 =?utf-8?B?Mlhscm1aM3ZETVBoSzljN1BqTkgxUCt1dTFmRExVcllxL2drV2Z5c3ZTRUhi?=
 =?utf-8?B?OEJmMDNYSlBlbkZwQUlWcjY1SngvZE9VMkFtSEpvUHFtY0l0TVl0NVJrMlZ0?=
 =?utf-8?B?eWFBYjMwaUlRMUY0anlSaVUrREplWWtxVm9QZ0RGREw4d004cFNmWlNVL1VD?=
 =?utf-8?B?cnBzQUtHV0dIRUhJb0J5NFNhMEdlMThnbUxLSGRJVzUwQUc1NlVjd2VnMGN2?=
 =?utf-8?B?NWUxMDdETFpUQUdadGhkVTN4NldMV3pmUFFaVE9KcDdQTDBIRGNZdnBBR0Js?=
 =?utf-8?B?VW5LcWdzWVZoSlBYMTNoYUlYdlRpU3AyRGFmMTllTlRkZkJHdTg2UHJkZjNP?=
 =?utf-8?Q?Js6W1VbAZNs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d2lkWGJCb3N5RjBPV3VZV29zdGRDU2ZpN0NWdVhsb21UZzRTTFduQjVWNGFS?=
 =?utf-8?B?WWF2am44M3JSUWo4OEtSelNmbHlDU2RBWnlZdmFweTZ5QVpXV3VpVzFzaDZG?=
 =?utf-8?B?ekxxK2FZTFhYQlZhSkwvRndzRi9aZ0l1TGhJbnAwU1ZBNGg2S2FNU1diR3F4?=
 =?utf-8?B?MTRpbkFmWjRQNjBVeHJhZzl4Qjg4dGF6TVNvQ3JRZGxoRFl5bnFueFd4OEJs?=
 =?utf-8?B?c2Vhd3NKb3hOeXlyMEtXV3RvcnlSY0ljRjRucnNBcVBmVEJHaXE4MUxzZzZw?=
 =?utf-8?B?dFZEYk5hRTF1WUIxMjUxR1EybFFIeVgzNjEyMHF3Z2gyaVpmVUg2MWRHQVE2?=
 =?utf-8?B?aVRWZXpiczJPR3owRGQ0bndlUXJ0cGRodWJyN3N6UkpjMWZtcjhTbE9JWjVM?=
 =?utf-8?B?Y1RNWGxYa0h5a25adU96MkVXV3Q3TlJWWVZnaEJzS1Vhd3IyNnpJV091NFlV?=
 =?utf-8?B?N0pGVXNXemZGUzhYaEdRN2NXUWFHdVgyV21aTmpVM2tRZzRIdFpaNjlyRStw?=
 =?utf-8?B?M292SnF3Qm1RRHZHbXJIZ1M2TFgxS0tYaEY1WW1vaUlvN0tUeEZiOFJNSDdX?=
 =?utf-8?B?MHB5UnZhRnArTzI0MnN6VTgwSE5nMzVQaERuZ3FZRmRROXhubm9WOEFqUTdI?=
 =?utf-8?B?Vm9RdXdxd0JVMGhpOVdhMTEvMUhkc0E4bWo0VC9rVkhDL2F3Y2ppWG9YWnFz?=
 =?utf-8?B?aHJKZXI3WlF1dUc2WnMyYU85RjlDRlVaVE1rWDloR1BDSEdGYVRvck92Mm8y?=
 =?utf-8?B?SjVHUVFFdEkwWWhTYVIrSUhDOHU4Y1NoK2NLb1EzNnA1WmpBa3BROCtPQms2?=
 =?utf-8?B?bGZuSG5UNDUwRmN3eUZGMktrV0xZQ21naGxpS0lIdVJwOEptSHV2cm1BRXlR?=
 =?utf-8?B?eXBaMkhoSHhqcUNFSE1Qd2J6NGdnWDFnNUZXSVM1NnQwT2VDSHZjUW5VNmlI?=
 =?utf-8?B?Y0dEWFgwMjUzeHNKdkhnTzdpblpCMHlGRjE5dERoSklDdWVxL05DRmpNNXdi?=
 =?utf-8?B?bm1EWkVmS0JZQjkva2J5cXNxZ1l2bnZITGJaMGYxVHJzT2VpUE9Zak16cDRp?=
 =?utf-8?B?cXVaWDJEZ3J6ZHlmL041WjhZWU9JWmpVWTFkN08zSVEzUG52Vm5DWUJvcGUv?=
 =?utf-8?B?UlhvaWtwUmx1cWlFT1lnOWVrcHBqUzVpRHhBeGVldXc0TUkwMC9sbHRtZUk1?=
 =?utf-8?B?b2YwMVltRFo5TmZYOXc5TkFHR2dCeExPSjJWaGhtRHZnQStrTjBMSHlzQ2hO?=
 =?utf-8?B?YjlKVHlTLzdzMXFCczZkenVwc0YxaXIrMUgySnpGb0JYQjd2UW51MER6ejNJ?=
 =?utf-8?B?bkNkQnBBbE9GQmMwNEIyWlJWTXFzQkpRT3pOcmRoTzVzdWtwSXdnbWJsMmE3?=
 =?utf-8?B?TTJDU0Z0amVrek1XdjhiWUV1eXRwOHdPcVVMVFE2M3lSSVEyV0daMk1xUktT?=
 =?utf-8?B?ZG8vUXZyZXpNYzlLZUtxUy9EWnI2bVhnYXhsVldWYlJPdUdDUzNTbU9sRmd3?=
 =?utf-8?B?Vkc2Q1VrdmdDK0RSS05sdUg3cXlucEpaUkZHQ1VlekxlSldJUGNMYjA5VUpY?=
 =?utf-8?B?TDdTMmdZaFVlNUtVL0lRMnVVbmlzTU5KMCt1aU9FUlkvakx0Zzh5TXlBTmUz?=
 =?utf-8?B?dEN0aVZPVEdBM1FHQkpDNUxuNFFtQkVDZ29JckVlTDUxanpJR2Znb0FGWXpz?=
 =?utf-8?B?QUErT1ZuUlk0QlVkMHV6ZGkyeDF1c0F5azljRm9RdXUyZGYwazJ3UlFKMXZD?=
 =?utf-8?B?U1hHcTVjTW53NjM0cEVwakVXa04yYys5T1RzTXY3RGNtY2JaN1htUTlCTG4v?=
 =?utf-8?B?STQ4WE56MkhnRWVRbkppa2RqckJKcWxhZzZOSjkxZk5SY0M3aGNLbFFockZO?=
 =?utf-8?B?M3hGc1Y2OWhPRWJZSDlJUXhRTnZHTVgzcTh0VStCZ3NqNXozV3ROY2hackt3?=
 =?utf-8?B?cmx2VUhoaTZaREhiVEpxRVYyK3Q2TjNIZ3RxVTFnWkQ3UCtXVklBdGtiTTI0?=
 =?utf-8?B?TVJuWWMwT1BFY2REQkpYOThZczBoUTdqZVBhc3NLT1Z2aVBUSGtQblprT2xh?=
 =?utf-8?B?Sk9zR052VkF6VktHNHlmTEZyZUdSUnl0THBNSVpOSUx3SDdkaDQvMUxGTW9p?=
 =?utf-8?Q?P37izXip4Jxfdq3B+mjq5TXF2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4274e40-7c50-4b9b-adc6-08dd7143bef0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2025 17:36:33.9394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b3apC0qkfw7PKRQNROFBeWeB4wdt0mBjZV3YXc1np4HNUNNBh4n1/lef+a4I8qAFD83y1YmsAceok6QOcNRkug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7126


On 3/31/25 15:45, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
>
> Differentiate CXL memory expanders (type 3) from CXL device accelerators
> (type 2) with a new function for initializing cxl_dev_state and a macro
> for helping accel drivers to embed cxl_dev_state inside a private
> struct.
>
> Move structs to include/cxl as the size of the accel driver private
> struct embedding cxl_dev_state needs to know the size of this struct.
>
> Use same new initialization with the type3 pci driver.
>
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> ---
>   drivers/cxl/core/mbox.c      |  11 +-
>   drivers/cxl/core/memdev.c    |  32 ++++++
>   drivers/cxl/core/pci.c       |   1 +
>   drivers/cxl/core/regs.c      |   1 +
>   drivers/cxl/cxl.h            |  97 +---------------
>   drivers/cxl/cxlmem.h         |  88 +--------------
>   drivers/cxl/cxlpci.h         |  25 +----
>   drivers/cxl/pci.c            |  17 +--
>   include/cxl/cxl.h            | 209 +++++++++++++++++++++++++++++++++++
>   include/cxl/pci.h            |  23 ++++
>   tools/testing/cxl/test/mem.c |   2 +-
>   11 files changed, 290 insertions(+), 216 deletions(-)
>   create mode 100644 include/cxl/cxl.h
>   create mode 100644 include/cxl/pci.h
>
<snip>


> diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> index 0ceba8aa6eec..6e9b3141035b 100644
> --- a/tools/testing/cxl/test/mem.c
> +++ b/tools/testing/cxl/test/mem.c
> @@ -1611,6 +1611,7 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
>   	if (rc)
>   		return rc;
>   
> +	mds = cxl_memdev_state_create(dev, pdev->id + 1, NULL);
>   	mds = cxl_memdev_state_create(dev);


Patch did not apply properly :-(

The call with the old interface needs to be removed.



