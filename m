Return-Path: <netdev+bounces-167019-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0923DA38500
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 14:45:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BC021888D10
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 13:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B8E18C907;
	Mon, 17 Feb 2025 13:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZFle7TW7"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C2F215F5E;
	Mon, 17 Feb 2025 13:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739799886; cv=fail; b=C2Kax++pTDo490sFEeIh3cqTlp1lZRnFbPd0F3KXZCZpDcWEDLFWt1OWQWGqZn5/qiCihk6fUR7xD0hQw9XFsksiFyivqZZq2A67Vu3c2NtkW3a5JwFCIe5JtNWPtj8FJPz8R0B4iqbJpg0/fHnZgzGZF9bboQ1vgLNAEdx3Pts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739799886; c=relaxed/simple;
	bh=vu9jBDdIS7SBrv1m9SKsUhyP1gsT0mNKBMCxISUNyW0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rEzqV3MJMty9k63Nd097guJG7dtcKkxav3mc5kY85HqKXLKesMnw58vkFnAWAv1bXw4D7tFMm9R+/EUXQRMUt5a3KaFMGaBBrXw2Ns+ygE5H5IF1Tj69ddDa9XivQoVEsdcF4qKgPLDohQyH6KUr/ZjdUnSE2WqJXV7dEPBKomY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZFle7TW7; arc=fail smtp.client-ip=40.107.93.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WuSMwKP3mhCZaY2mZbnAqINY94ofEqmk90NmAJ7lwYvUPfdFfjXlCcTPjS58xLVvL+HaAeIBR57ri5NOznfZXIxWFWK+K+/v9/lu0HGsw6oyhZ/zHjoN/OXTo3RUJOaeKddKW3yjO9JSDVS1KxzqefxH4YWN5jFE/tz8dmpjzHCozN6EkPsvNd9BzJC54eQ+MZzO15N2W9vQMNvfpEzCuXzuLramofCL/7YHn0cOCWwWwrukWJV27o0NqVBL1fNHwRBcAfA308ADEZmlAXHSFyQtXN2WSiSl+kUCKQveKv9iMAkZ0oj0bho/Sch5YKS6Dp96yPYYiQODmqUvZRKcSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FfndiYfJco0enLynjc36VQrDCBj4709nyav83XO3+58=;
 b=LgSLhi4S7+MmlJxukKVhrH5+stbF+ufm4AiIu9QHz5zBgfPZNiPQY5WmtvMSMP7Pd3UHxfhAENUTY1kgF3ZOcvnZjgRM3+2+ofmlnvN7d7yFl3PSHxFJGsLEAb/FsRZ7ZdHmWc8f6zOPSvRCMbm7oGADy67gLtCjoFj495v45cBfU5cjr1ureok5RM7q8ax4rGFQvs41f+1KVvoqvqDo0XdAzEg3CU6wCdbsbDy+ICJsJNMt0xpVDTDN+sS7PggNEIArAaoJr6XX0U3dKB46F5muidkivQ0tt+W25DQwyAjXfZxNtCnh4Dh56+iR3tu5NBBCHwVSAF0zeQxx/FGpJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FfndiYfJco0enLynjc36VQrDCBj4709nyav83XO3+58=;
 b=ZFle7TW78K0YcefdgJcUpkZQj5y3jbuC2dc9p6kWz7GB/H0yB1h/iNJYRgCkoBqQWJ992E2EyXjofKaUUR4hLzLhogFLOQvK+GicDlb5I48XhXF94uKbv0cih2j941EBJqGAtEf0iRkpVYhRa9fRDriUPvfzibbM5Ci1//yIbv4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by IA0PR12MB8421.namprd12.prod.outlook.com (2603:10b6:208:40f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Mon, 17 Feb
 2025 13:44:40 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%7]) with mapi id 15.20.8445.017; Mon, 17 Feb 2025
 13:44:40 +0000
Message-ID: <3ffdaada-5d60-4af1-90e7-5f43ceb0d3cb@amd.com>
Date: Mon, 17 Feb 2025 13:44:35 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 14/26] cxl: define a driver interface for HPA free
 space enumeration
Content-Language: en-US
To: Simon Horman <horms@kernel.org>
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
References: <20250205151950.25268-1-alucerop@amd.com>
 <20250205151950.25268-15-alucerop@amd.com>
 <20250207125543.GR554665@kernel.org>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20250207125543.GR554665@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0315.eurprd04.prod.outlook.com
 (2603:10a6:10:2b5::20) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|IA0PR12MB8421:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b41b23c-ec67-498f-d23e-08dd4f593a46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VWRUeGVlbjlTM202YzZLUXE2WWFSYTBSYzl2M2J3MnBFMS9FM0owT0wySnRo?=
 =?utf-8?B?eU16Z2xHN0RYVFZhZGJzTExjRSsvOU44eWJ6NWVycml1anJnQTY3UlpISlRY?=
 =?utf-8?B?OHBERXRYQUhseVMwcll4WTFKNW5BQ0MxZm5tWWdUQkpycGx1dWhMOVNZZ3lF?=
 =?utf-8?B?eGRZRDN4MEw3N0NpVjZhNWpGUEhIdXZKUE5mbUMxUmk2OG44RGNwelhaMHN5?=
 =?utf-8?B?cG5HSGVBYUJXOGRiaVQyTStCWjROSWJXWExEU21Rd29uaFNOUEJmTk9lWXJC?=
 =?utf-8?B?U013UFc5U2h0MVJMMUhHL1VGR2Y3alBoN0ZVbHdhaXAybmZyV2lQWGpHNDEw?=
 =?utf-8?B?ejMxSG1Pd1UveEF1UTRWdm9OazZEVncyTEVnVENhcy93YTh3ZUZCMllhNjV5?=
 =?utf-8?B?aVFMWXJ0aFhoOEIrZjByRFhkN2NXbmVveDd6L2JBSTJNUmh4TWlDcnh0allF?=
 =?utf-8?B?cWt5WGNYZVdSQjRGaFRGZEdnQ3FEWlJKQXBGUittYk9mbTFVdkxsaVhYSVdP?=
 =?utf-8?B?RzRXL2hwQ3hPOENSUHlIR3hRYWF1V0FscmJlN1FERkgzQTJOTFpQNWVlcDU3?=
 =?utf-8?B?WnFieTY2OFhxOHYzOWV2QVduSC9ZaWpuQ09nLy9wcUJLNno5amppbldzTERr?=
 =?utf-8?B?QStnSFJmcEc4NjZBWnBIdzhoUytsZy9hZjA2RVJCSk9zd0FyY2U4ZDlGNkNT?=
 =?utf-8?B?MmF0bU1DOGtnRXNHa09leVNtY2hTc2tTMEhmamlETkIySit0OEN4L2ZEVjBm?=
 =?utf-8?B?RUJPSndUb05aVThpNmRkaVRTYVBDRXJ3UWFWZEFTbDZoZEZWamJvNFVYKzlj?=
 =?utf-8?B?UVFtRFRqVTJVRitRT0MrejdMMmJkdndNSkRySHU3VDc5dklVN0MyWkF4Ky90?=
 =?utf-8?B?a1VtUFE3SzBtbk40ZEFXSm5FS0VUMU1QY1dHbnFwVGs5VGtuZEtBWWZSNU40?=
 =?utf-8?B?ZDBiRHl0NmtsOE00UTZrdys4VnEwSEpERnFma2hUUUJ2QUVUSG1ralI0bEpQ?=
 =?utf-8?B?QUxOOXowVHllZ3g1UWVyOUV1UHBHN2phdW5lTDZzTDBFRFFnbGc1OE56a0tW?=
 =?utf-8?B?S01MUU9pWW9hcmlrcjV1WnNZTlFGV0VCTEpRQm02ZGZ4RjlqRGVjbzJPQ1Ry?=
 =?utf-8?B?SG45RnplU3V2MFFaVlFpK1hvQlFtM01qQk5JUTFQL0dCSDE5T3ZHbk5HdUo4?=
 =?utf-8?B?dElUQmJBejM4TGtMaWdiSFBCNVBBZy9qRGdxOUFaUEpNL1BxNE1LaW8vN3Fj?=
 =?utf-8?B?dndpQUVIUVNNaG03K09mOVRva3NPTmd2SGI2MWI5UGpMMm5KUDdBNmRYNExZ?=
 =?utf-8?B?eWREbHpPc3J0WlRBQVhCeVVia09ISXZ3c1IvaG9DZndCWXpvcFhZMmQvczg0?=
 =?utf-8?B?QlEyWjJraGgrTHJ1ZCtDUUtDUER5RGkrWDZkQUk1b3o0dTZNOXkxS28yZzl3?=
 =?utf-8?B?TTRNRjY2Ti9yTU1paGlDNlZzNUQ5cU11SGVpZEZOaG5ucUZkdU1GUTUrRHVR?=
 =?utf-8?B?V24vd1JmVEdPNHhOSmhGY3pESFV5N1luMHEzQzhCaFEvMFdxdzllVGVIc3Na?=
 =?utf-8?B?QlVtN3JwdDY0VHRPbEhteXZBWE54NmFwK1BCM1U1TDJ2bm9hOXQzSkVzbity?=
 =?utf-8?B?SnJiTDcxSXZZVXRkYnRhM0tSY1hxNCt0NVZlQU40dDlZejZTR0FsZXlFbVNK?=
 =?utf-8?B?NHEwL3YzL2VBakRtdUUyUkJlamp2RUdDSXlqV0ZRZzZEdkxMd1JVemZ0UzVH?=
 =?utf-8?B?VXFsU0FSZnlMTXp2SXBQRkI3UHBNdkcweUZVOWlKOVdKQjljRUFyb29QeFlH?=
 =?utf-8?B?QVhSRHVmbXZJOG5CZTVLa3BCSUEyR2c4MUZaS1JMWitrVEV4bEV1cjA2UXVk?=
 =?utf-8?Q?4DQZediiQsknD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MDVBc2J6K2pXcEdsQlFyYlBMYlJOZ0UrZ2RzQThNL1V0dVl4eFc3VlhRTjU2?=
 =?utf-8?B?OXdYcUJoeXgxbkVneWo1dDI5TDZCWEptZE9nUlExYUFFeWVGU3ZuN3lJQ0ox?=
 =?utf-8?B?MlF3NWFHWXZBeGVKY2ZTaTZwWGx5V0QxMk1qblZLbDZ3MEtsYWg0TGp3akc2?=
 =?utf-8?B?MmpXWnJJdVJ6ZmdYbjN3S2RCS3czWVF1SGIxNVlYdEs2YnFTZk00eURkTHE0?=
 =?utf-8?B?d2EyTHFMaFBWTks4MEZ1RjZPY1JzZGpxZWZzS1hyZTF4eDh0VUVlb1hNZFJk?=
 =?utf-8?B?RGlsek4zUlRvSG0zNTRzU01WL1ZUQ0hiZDE2bzhFZ3pCOFVYeUl4TktRK2l5?=
 =?utf-8?B?Qlo4RWtXcVNqM2k4S001ZVdqN1p3dWE5aWlOQnBudDVBcUduZmp0M0Z6aFBS?=
 =?utf-8?B?YkpnV2JnNktLOFpsZ1JyVThvMytwZkFpb011SGVvaUM3M0lKSmRSeGZXSVFI?=
 =?utf-8?B?WmZTV1BSNmdocGFqK3FCQmtUNWYvZnp2RDEveDJGNjBVT3F2ZDdZVThncHBk?=
 =?utf-8?B?djJBbzdsenAvRW1wMmJ3L3FYdEFZcWlkTE81czBGM2VCM0NwRGdyTUhUUGYr?=
 =?utf-8?B?Q0V4aFEweVVBR2w5WUp4Z21IQ0VxL2krbWR1WVh3Y0Voa0FDMkkxOG1ZYUZK?=
 =?utf-8?B?WlFuVlFPVVQwYURtNzdtZnlPbCtGa0YySS96TjkzQ0d5NnY1NlVpM3JsYWtr?=
 =?utf-8?B?YWxZWVZrRFIvUWlxZ2Z0N2xDa0R0d2NZS2ZlMnB5ZVdNRWsyVGpqUHJOc3Vp?=
 =?utf-8?B?ZXpZYkFrUUJHM094YWtoN1lnRGZ4Yzh6ci9WNE1rNkNuaDQ0dnY4a0VtazF2?=
 =?utf-8?B?dThxU3NHR3BYZzQzSUMyS2l2dHlqdno0NDZRazZ1TDRpeEdkWTVjM3AyNjZt?=
 =?utf-8?B?MTh0Y25wQXE5WE1hNU9scm84bXlKbm0zV2dEUFRaVC91TzIxV1grZlpaQ1hB?=
 =?utf-8?B?Q0FtendxWVZvQ0FHckpOa1d4ZVhtbVN1eFhwWENJTm80UnpNOVJ6eDFmTmNj?=
 =?utf-8?B?WjNlbWMvOVF3TFdYOTJUdGtoVTZHTDFsTGtiTEpaSUZ4aXF6Q0xlYW4rWnZV?=
 =?utf-8?B?cExnaS95djJJbzZqUXgxUWJ5dlpFREZWTjNlVGVzVC95QjJCcm9nZURub2hR?=
 =?utf-8?B?eVlOMDcwY3ZlVDg2bEJRTlZmTG1sV25KQ1QvdWdHY1BKeHRTUWFtaEttMzVZ?=
 =?utf-8?B?b3JOZ3FNenNpbXFuUloxNnBVcEIwR2VBRkdFNzFxRktKV3dKRUU4RnpqNG9y?=
 =?utf-8?B?TlAwQ05PQUY2WnJ5T2V2eDBqd3FNVXdIZnNTY0YzTE4xcCtTNTdOckFBWFZ0?=
 =?utf-8?B?bFRmblFQb0xnemtHUzVQY3BzZ2JNK0Q3VW1mdmNIci94aXU2ZHRVc1hTblR5?=
 =?utf-8?B?K2pETUU0a0RKWkQvQmVTc0FCQmsyQ0kxbEcrM2d6Ukg2SFNjM2hTVUZXK1RE?=
 =?utf-8?B?aXA3YW1OemMzbHNZSHBpLzBCTG1UTFJDUm5laHg5NldNWVBlK08zTU9GSnJX?=
 =?utf-8?B?bStVUlVPWjUyYVUyQ0Q2MTJkMmFPTjMrMUYzaCsxazRiUTJWa3hXTWFKS2hH?=
 =?utf-8?B?ZHBnK2dIazZ3cU1yam8ra2Y5TGZNVjdvL1BiSElkak9UZWd6K09DRDJ3c0h4?=
 =?utf-8?B?R2RIL3VCeUxoTnNEMXQ5ZlpIdWV4cDJZSHFHWWNHa0pHQThEUmpjbGxzczdO?=
 =?utf-8?B?OGhhL1lVZWdWVW1uYmxNWjlxRjhFU0R1aFQ0QW13NWNraUJSdzdwVHJLd1Zn?=
 =?utf-8?B?dUFXQTdWNGZPYkVUejBldVQ1ejkraXMxZjJaRThuZHFjN2JhdGZHZDdZOFV2?=
 =?utf-8?B?TTIxYTB4RnRSMXV5U21XY1Z5b3ZtNERWVlFTa1lXdzF0TkFQZEtkajVlNnda?=
 =?utf-8?B?cGkzL0trT2N4UHJyM1NvMlBvVDM2V1pmWUU3L25QVklFa2NlVnRFTTFhdi9F?=
 =?utf-8?B?akY3TzVpWTdnU2xXaGRESG5ib0w3azQrT0RKUUR5ZG94V1JSUkk5azB1QVNm?=
 =?utf-8?B?Q2c4dERUUTlneHlVMEpObVQ0RlU2WHAxWnUybXBIVDEwOWdxa3doSi9yQndk?=
 =?utf-8?B?ZUcwekRhMlM0ZjFDUGdtVlhiT3BRQzVhUXhYWVE3d1FoczRQR1JlcnFpYnJF?=
 =?utf-8?Q?SNnwTjsw1ImN8zGpvc4adWlml?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b41b23c-ec67-498f-d23e-08dd4f593a46
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 13:44:40.7208
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xdBUSLNKy1fJMgluuwRBrj76FL3Qyisy8BW3IEYiTPHGvhK6CLG4YjsfDt7pO8Rx5sOZMXtMQtSarym74CsAbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8421


On 2/7/25 12:55, Simon Horman wrote:
> On Wed, Feb 05, 2025 at 03:19:38PM +0000, alucerop@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> CXL region creation involves allocating capacity from device DPA
>> (device-physical-address space) and assigning it to decode a given HPA
>> (host-physical-address space). Before determining how much DPA to
>> allocate the amount of available HPA must be determined. Also, not all
>> HPA is created equal, some specifically targets RAM, some target PMEM,
>> some is prepared for device-memory flows like HDM-D and HDM-DB, and some
>> is host-only (HDM-H).
>>
>> Wrap all of those concerns into an API that retrieves a root decoder
>> (platform CXL window) that fits the specified constraints and the
>> capacity available for a new region.
>>
>> Add a complementary function for releasing the reference to such root
>> decoder.
>>
>> Based on https://lore.kernel.org/linux-cxl/168592159290.1948938.13522227102445462976.stgit@dwillia2-xfh.jf.intel.com/
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> ---
>>   drivers/cxl/core/region.c | 160 ++++++++++++++++++++++++++++++++++++++
>>   drivers/cxl/cxl.h         |   3 +
>>   include/cxl/cxl.h         |  10 +++
>>   3 files changed, 173 insertions(+)
>>
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index 84ce625b8591..69ff00154298 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -695,6 +695,166 @@ static int free_hpa(struct cxl_region *cxlr)
>>   	return 0;
>>   }
>>   
>> +struct cxlrd_max_context {
>> +	struct device * const *host_bridges;
>> +	int interleave_ways;
>> +	unsigned long flags;
>> +	resource_size_t max_hpa;
>> +	struct cxl_root_decoder *cxlrd;
>> +};
>> +
>> +static int find_max_hpa(struct device *dev, void *data)
>> +{
>> +	struct cxlrd_max_context *ctx = data;
>> +	struct cxl_switch_decoder *cxlsd;
>> +	struct cxl_root_decoder *cxlrd;
>> +	struct resource *res, *prev;
>> +	struct cxl_decoder *cxld;
>> +	resource_size_t max;
>> +	int found;
>> +
>> +	if (!is_root_decoder(dev))
>> +		return 0;
>> +
>> +	cxlrd = to_cxl_root_decoder(dev);
>> +	cxlsd = &cxlrd->cxlsd;
>> +	cxld = &cxlsd->cxld;
>> +	if ((cxld->flags & ctx->flags) != ctx->flags) {
>> +		dev_dbg(dev, "flags not matching: %08lx vs %08lx\n",
>> +			cxld->flags, ctx->flags);
>> +		return 0;
>> +	}
>> +
>> +	for (int i = 0; i < ctx->interleave_ways; i++)
>> +		for (int j = 0; j < ctx->interleave_ways; j++)
>> +			if (ctx->host_bridges[i] == cxlsd->target[j]->dport_dev) {
>> +				found++;
> Hi Alejandro,
>
> found is incremented here, but does not appear to have been initialised.


Yes. I'll fix it.

Thanks


>
> Flagged by W=1 build with clang-19, and by Smatch.
>
>> +				break;
>> +			}
> ...

