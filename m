Return-Path: <netdev+bounces-212174-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD434B1E8FB
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 15:14:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AD4CA02EEB
	for <lists+netdev@lfdr.de>; Fri,  8 Aug 2025 13:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BBC5279DA0;
	Fri,  8 Aug 2025 13:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lRoVFWEs"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851F7277030;
	Fri,  8 Aug 2025 13:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754658883; cv=fail; b=uWRbu6MQXz/B6/8l9XuIHs6hJ9NU5Ukxrot5W/jQzMMQYqbB5p9Mjo0hTa2plWqPNTA9ubyLiP/Bb+8Y70QI137utoG+eY2YpWQoHzGgzNkpynU9/n1aRmWWIcnGEpxLar3eu1mz4LpJACkjjP8y1QFaN6tH3uI5gcAPTjnCVbs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754658883; c=relaxed/simple;
	bh=K3uicTb7P1t7yXmaQ7uE2KH6znuwejegLD5lCJjg31A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZcB3k7CWY4jtWLFSEai8TiQg3iZOzwhnfxtGFo3nb6kIPSLKd51Ts/s7dRrQ7yXxmXhxLkhdGpfAHulZPL4yJuDoeRgbdw+CzItpCKsOeLUqPdVS6dKadXdvz7aclrS00xRKFFOC75vt+6ZKKeWtZFQ5E0eTBIgBb6lhiw2wb+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lRoVFWEs; arc=fail smtp.client-ip=40.107.243.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RlDUlXltMy6tirAC9AVkH+2c51+aEdfPG7wwfbYGZEev88p8rPEblJ1RzKc0n3rW7HeqCwJ2d2LSjzb3aI0Vg6zmXUVXiXDD9KvXuF81bE1seSPKOVVKf9liW14QaOlpaWEyQkrrbYeFVITtXuoLNLyjfymLqELvEz7aHsJ2i4EsnII1YPkKh40JFEiB9Q9Pa7eNlv3UCFc9XD2zN+1Iqj87mHO4/K7X9fFqTTq/tOAy/cSzP6CJ96nbM5pf+Er5rDIExfSpjmXVFuP4VN07ne6wozjDM5NhGgWUYEiTSQtS9xZk2fSu/V1oYdLaBj8wsA9PXr2U1q16jUHoILFv6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ed5Y4gRXMOydkgH0QmbhQQrR50ruf5Y+zg8yu/1kfsE=;
 b=tdSfLEwvIUFsY4+YWlO09tDOew6XCAGr5OWFORWUbuzLZOSuC6jXa6P1y063bSkYQf5mYMFEUc8hko6KOZzcEaOSd0e80T5sgBy4WGJPrhoTwsygwTMGfafXXjYGIuDAqJ3Ilhmdr+YPAftgQfMfynFUbizYNcfcMyQiASQKw/vKyV+DpzdtggVBE94kTvOusupoEHsDFazvb/MwQjN9U8Uds3+d1gD+4onghhu/g+vavHo99r0x4k4H4UBlAT5sdd5Z/R2JcuGXKa6icNERndiQyJ5pGHhJnzXBz+klELX3qEDkRnQ/FquebPtMDtfzeHLZa35Ti+7nUSmorYe9Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ed5Y4gRXMOydkgH0QmbhQQrR50ruf5Y+zg8yu/1kfsE=;
 b=lRoVFWEs9OS1NaTrxA/pVTIrvGbasbj+DobPutd1woClUElSfg6vOF/g3Mnle0U8isT3LG0VmW4Rv3s8RQsDGhCNIXWmhgBXULLcTNsN+mRhz7sIQOlzp+pGwlLOp1iewEClTlTjR+f/VTlrv/8iF1svOWG9TFWjNDKmEKmxGdM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by SA3PR12MB7976.namprd12.prod.outlook.com (2603:10b6:806:312::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.18; Fri, 8 Aug
 2025 13:14:38 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%6]) with mapi id 15.20.9009.017; Fri, 8 Aug 2025
 13:14:38 +0000
Message-ID: <9656c515-48d1-4740-bcae-9b5bf3899e47@amd.com>
Date: Fri, 8 Aug 2025 14:14:33 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 05/22] sfc: setup cxl component regs and set media
 ready
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
References: <20250624141355.269056-1-alejandro.lucero-palau@amd.com>
 <20250624141355.269056-6-alejandro.lucero-palau@amd.com>
 <20250627094551.0000360d@huawei.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20250627094551.0000360d@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0135.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:193::14) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|SA3PR12MB7976:EE_
X-MS-Office365-Filtering-Correlation-Id: e1e2c580-689f-4cfc-210e-08ddd67d871f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YWRLSTlEL1BHTmx2ek5BMXNzOVRDbURnRjZtbzg2L2lHSVpobHhzbGprQ0lW?=
 =?utf-8?B?MmdmbkJ2eFEyUUVPem1ySlBvU1JZc0NJMHgrNGRnRVpmN2VvNTdxazYxeHNT?=
 =?utf-8?B?Wmx3RGF1RzB0SnRxekRaT3ZBbW1VZFhlcDdZaVJJZW5FdTNIVm5MbWZMSU8v?=
 =?utf-8?B?TDlpTFN5d0g0bzZzMmpjTFdpLy9ZdlJOWmFTdEM1czJRSGo5VnR2dzI4bzdE?=
 =?utf-8?B?STc3cmtGaHNTWU1FL1lxV2k5VytpZGZDdkx3RXUycGtCNmZlcVZJOTYzRkg4?=
 =?utf-8?B?RHBYVC90SE5OWkhwVXBRUWlyTUx6RHIzK1AzNGJTYW5jdTdNai9tR0VSMXlz?=
 =?utf-8?B?cGNpZ2JOUEQ2Z29nVXorRmtOL1JiSTJKUTQ1UkZkUnJvN3o2Z3l6UDhNdGNx?=
 =?utf-8?B?b2YreDRnL3k3LzNWWlBxNFdFWFlodkVzZkFRRENHRVlucExMOTZoRVdqekhj?=
 =?utf-8?B?SWlsOE56N211Q3lkdlhQMjVrSDQxTlN0VTRFdzRhSElnVEMxd3pVVkk0NXpl?=
 =?utf-8?B?amJrR3FSejlrRjE0RHFqdlVjZ2g3dTR5dHR3V3Zva2wreFBONHlwTUNueGh3?=
 =?utf-8?B?RWRPL3g0WUhNMlgwQVdLSlo5NUIwUDhQOWt3dDdhd0JqRDlWY3Fwd3QyMzlL?=
 =?utf-8?B?bzlLdngvMmF4TE5Qa0FUbC84U3pPUU84QXBzdkpoZ1ljbVdzTVVLREdvZ2Ex?=
 =?utf-8?B?K3dGT2lXZndyNlMxQ09mWWYrUjJ5KytPem0zZStYTzlWbnpmMGtxa29CS2V4?=
 =?utf-8?B?UHFiTW5aWlJEOWkvSk5YcGlOMGNsTWdpaEhuV0ZoS01iVHdiSGtKK3VheDB1?=
 =?utf-8?B?VjRxWEFjMnpHYlRGV3dodTkyWXRMaEI0UFdqb3pwSitBQmxNenBWM3NhRFRB?=
 =?utf-8?B?Wis5dWYzUVlOM0kwNHE0TnFQUTB3aWlCelM2R2JkMHZnek9RSXl0bmd2SUZC?=
 =?utf-8?B?ZFRBMGp5L0U0VVVRMFlGNStZTEpETXByTEdTZEdQRnJwRHR2THc5SnZzdTIw?=
 =?utf-8?B?OWM4NlBLVkdKY1lZa2ltc2Q4UGFQazFOVjNJa3doVVllSk13SVkwb2k3bG0r?=
 =?utf-8?B?OEFYbTNrOEFiOUVhczY0TzhNRVZWYlQrRFoxUkhDWXpra3ZTNU50YlVMZ0xs?=
 =?utf-8?B?UXVpT2YyTkJlZ2didWt2VmNSMHdPeHo0eDVaMTVueEk0YUU2SWJrbGpmcHIx?=
 =?utf-8?B?em1DZDhGNXNUbkpVL2dDT0tSZklLRkVvUm4ybytwTXdhalZsc2toa2d0Tk5L?=
 =?utf-8?B?WDJsb0NKL0FubmhKdUJFY0k1VjI0dS9yZ0hTWkZmZURFa1J0b1JnS3Z4dUFX?=
 =?utf-8?B?aVh6bEJJNnpPbUZjY2pOcmJzeTkrM2ljbTVsNERBNzB6d0RGd2xSbDFSWGpK?=
 =?utf-8?B?NWdudmFVWk5jbnZZYUNZVGhOQmlNQzRwWTViUGlFV3lxeXE0dXJpZzBFb1dw?=
 =?utf-8?B?WEhYU3JhbTJmL2NURExsWS9kL2h0bkJvMVVyMDRycGxIejNpU0VkLzBrQkhl?=
 =?utf-8?B?VFFpVmFoeUZEUXBiREJNaHJBc3hzeURnUEQ1SnlzN3R6YVFEbEpyVnVOK3N1?=
 =?utf-8?B?S2loWG03VVdQZHJtNzEzZjZNNjl3Q1hWN3duSmFNZ3lRMXpvNmIxSFR3RzY1?=
 =?utf-8?B?cE84eFZPU01xdVpmczhCUTBrb3J6NkdnbnBoTDRYWmdqOGEwM29RTDZ4NUU4?=
 =?utf-8?B?eEtTMk9PMUZYN1JQazMxbDYzNUVLaFRmZCs3UmtSNjR4RW9oaVliOXc0M2Js?=
 =?utf-8?B?Q0ljTUdrYVJhTXl4SnZZdnV3VWRqVVFqQ3lLNCsraml5bE14RmI1ZDhwdTdQ?=
 =?utf-8?B?djdtbHdNOFdqK2F0TEdMeXdVamVqNGdTbHppOEVMd2lFanNSRGhOdTdVd1RS?=
 =?utf-8?B?eU0rVEQyYlFvUGlrOUE4QXFNNktyTzhLekdvNHBrdW1vUUlGYTRpNTZ4cVBG?=
 =?utf-8?Q?Z0dwfU4uDTs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N3UvcHByRVFkS3VnUTZmbUJUM0o1RFc1d0dDeVYrWThwdFR6NjdReVd1Vjhx?=
 =?utf-8?B?djBHYm9FR3ZNa2N4NjYrb0pudktMRnJTc2swbURXQ0xGTTVBWGYzdFhhMWgy?=
 =?utf-8?B?bmoyd1Fwd1czamN4VGFtcmxVM1NVMFNzM2p1K0VsVTMzNStISlVLN0Vlem4z?=
 =?utf-8?B?MlZ4aWsyODdFaU9wcjNVTFN0cnZ2VWFxUEp4SUJtaE5FZ1lwM1J3NzlrbzlJ?=
 =?utf-8?B?YW80K1JCWlJEbkNweUxualhyZ3o0OGVVMWRTSFBzU2wyaVdKd1FmU0w0Uzc3?=
 =?utf-8?B?ZXUyK3c5NWw1YmI1aGJVY2tsNkFKSnE0cFpqWVQ4WGVRU2xqQWhiTk84bVRs?=
 =?utf-8?B?dHo4R0RSTDc3eXNmNmoxaEM1elQyeTJQK1FOV1BValZ6ZnAwNUNRbGJyMWJG?=
 =?utf-8?B?bUQ0L05PUWRuUG9lLytWNUFUbWJhRDc0SWp5UFlBakNmckxpUTZuQVpabXVG?=
 =?utf-8?B?WUNGUTAwTWhXYWE4UnQrTWVTSlhHVXFLNC9oVHdiVXAwRUoydnA1dWczbU1x?=
 =?utf-8?B?aG8wU2NocitrMVEzcXg2T0V6QjYxYU84cXMvRFgvZzFpTm5lcDVDVUFmbXpL?=
 =?utf-8?B?QUVBTGhxRFBzaithTU1rWThPTE5xMzNaMVhsaUw3d1J0c1JMUTF5dkhlMnRh?=
 =?utf-8?B?MXNDdzBNb1dheFk3N2JhSTJZZUp1alJ3eVMxTFp5Rnh0TXN4SmorLzdsMEZ5?=
 =?utf-8?B?MURQZG1SNmpMUnM4dThxVjc0Nm5rUmZjMnRJUys3YUlqbS9JVGVBWjR3cXFr?=
 =?utf-8?B?YjlEWkowbmt6ZUkxMXlSK3dpb1VBbEVOTVpSUTF3eEF2a2wvTXlKSUJMTUds?=
 =?utf-8?B?MmF3a0Z2RzlWZ2dqVjJkZ1FMSG5VMEN4RE9CVW00amhEeG1zWVJnb0VDWU95?=
 =?utf-8?B?MG5aNzFwc0RqclhFYTBqZm00Wk9ESTZtV0t2b3RERmJtY0F0NHV2SWhOUW1s?=
 =?utf-8?B?S3RNQ1hrZnVrVXpoTXBGSVFvU2pVYnhjZ2s5OEFacHFyQlNMV2wrL0NDWU9H?=
 =?utf-8?B?cDB2cC9WZUptbHl1TWl6Ym9LT3dkN3ZpdzhYZFFrWnU4M0ZDcGRZZ0NnYkJo?=
 =?utf-8?B?L2tRNm90dnp3b3FGKzNDeWVYMC9OcjhZWjc4VWtlbEZjb1NVcWI5SnpkaXkw?=
 =?utf-8?B?NEE5SFZsRThZWHRJVHlWRXgvS25SYkV5SHd2MUdFWmcxVHc1dEovUjNUclJE?=
 =?utf-8?B?ZVowbEhraXdmUVhneDlBVFRGVW1sN1FEeWhEL0FRZXFMaFJEV3JSaXBHMDYr?=
 =?utf-8?B?TnlMS3pEUWF3d05oeDJyNlI0bXlyMXhkNnpRckhpL0RkN29lZDh6TXVJYXh3?=
 =?utf-8?B?a3NhcGg1WHRGZ25WeHkrcmloL2pITlI0cmdjaG5YeVF5RlkrMzFGZlRUVUlZ?=
 =?utf-8?B?Rnh5U0Q3MnpGM0NqYnFEUThZaSttOFpsTDkzKzhUQ3duSUtYcTIzQ2dSclBv?=
 =?utf-8?B?SFFQMWU0ZTRZSjRkSWVmaG5lS3V5aVJCTEVYNHZxZklod1lCWVlETk9Pam15?=
 =?utf-8?B?bmM1Qjh1dUUyaGVMOGtwcE5ORjJYaUQ0cGF0VG16d3BRRlpLSjA1d0JBeFJD?=
 =?utf-8?B?dUhKZTZkSkFVZzdOOG9JZGFLc0V0YkRmNGp6K1VrMHdnM1N6VjliNmlQSnRJ?=
 =?utf-8?B?b1V2SWx5bHBCb2tSRm5zQmdsR1NSWnZxd3N0U2JZMTQ4aHVsTExJS2VjMmxB?=
 =?utf-8?B?QXNpTUpabHdtNW96aVRVUEZvSFhEc2IvRnlBMVA0QThtT0NXRENnMFFKUGxa?=
 =?utf-8?B?TUZnM2xtTS9XdEhSN3NuTElEWGxmN2pRNnJUL3BGVCtlUTUyV1R2K0FqbGhj?=
 =?utf-8?B?ZFZyUWMvMzEvb0RaSjFtblFVNVk5Q3NycmczWGVLUU9FQTcyY1l0NTE0VzY5?=
 =?utf-8?B?VGp4UVlIcFZSVlZwV2FtZ3hqdlBCTTF5V0h0dU9SZVE1bkZJN1JheXhQUExt?=
 =?utf-8?B?M2xSZnhuL05nVldxZ3hoYWU0eXNIU2tvUVJUOU9SZUxWdHlaRkp5cmExSHZT?=
 =?utf-8?B?NG1CeEl5ZUY3cDlrRmVCOGxIZ21wanhtZCt6SE02NmwxZ3dKenRYc05vbnY3?=
 =?utf-8?B?M1BqMjN0dHlYU2NxOXBCK0pvT0tZZ0lhUXZIOTN6VUhQYitsb3lpamlzWjVS?=
 =?utf-8?Q?TWLaMtzCwsM1EtrvTDseOcAy8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1e2c580-689f-4cfc-210e-08ddd67d871f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2025 13:14:38.8187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: phwDnIIh1jdTZC3B0L6blNr0a3k1IeiQuWpLFfB3dRp1PW9rcxp6wPy5K7+TktFH2vKkLDQpSW9W9osat3VGQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7976


On 6/27/25 09:45, Jonathan Cameron wrote:
> On Tue, 24 Jun 2025 15:13:38 +0100
> alejandro.lucero-palau@amd.com wrote:
>
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Use cxl code for registers discovery and mapping regarding cxl component
>> regs and validate registers found are as expected.
>>
>> Set media ready explicitly as there is no means for doing so without
>> a mailbox, and without the related cxl register, not mandatory for type2.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Few things came to mind reading later patches...
>
> Some of the calls in here register extra devm stuff.  So, given we just
> eat any errors in this cxl setup in my mind we should clean them up.
>
> The devres group approach suggested earlier deals with that for you as
> all the CXL devm stuff will end up in that group and you can tear it
> down on error in efx_cxl_init()


This adds to your previous concern for using devres group, but after 
looking at it, I think from a netdev point of view is preferable to keep 
this out. Moreover, once I got Dan's review tag, I prefer to act quickly ;-)


But I will add the comments you advised to instead for making it clearer 
for reviewers.


Thank you!


