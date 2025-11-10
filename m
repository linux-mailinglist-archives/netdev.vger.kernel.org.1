Return-Path: <netdev+bounces-237167-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5E1C4668E
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 12:57:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A5F2A344C75
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 11:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F44E309F12;
	Mon, 10 Nov 2025 11:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CzUwT2WR"
X-Original-To: netdev@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012023.outbound.protection.outlook.com [52.101.48.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43D830BF65;
	Mon, 10 Nov 2025 11:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762775840; cv=fail; b=Ge+by0+W9rcE0IsPDPeynen3zyopvfrnd+6WpaabkQWQwkuJMFMp9AG+WKAS00xyH0EUdUrfv4lseGpF++wr4UPQ03d+wXtSiqEPzQ4NLuqj5RnzUdUMnIoWYDh+2El8e1il5XlxyMVs8zu/rAi5o98l64H2qK2dBchzotzUwwo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762775840; c=relaxed/simple;
	bh=703PGp9kA+2baZH++cP+4ZrLi737O6nPst2ZWDQlyyE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WjbpfyJn17izJrghIl37PlbPZc1P3AxITCY4GAVJCGbSJ6nEonpK/1/dtZoEuAAfT8vBDNkV1iOP8gUGoIyJ6rNAMgd/OmFdKQmVjtWKXqpWqbQtfmkZGdHFO43C7Y5sCIXbj7u+nyNzHk+Me4f6MBzIE2m6xPhXIyhZuJuavpw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CzUwT2WR; arc=fail smtp.client-ip=52.101.48.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kK2mzYfod5apOZ4vvvFYKpqIwQ+blEQt1HIRzR6EDWHubTvVH1bMHo1qP6NY5hkus/SzA9rQU1ruJt3bmz3CbOb+Mj0hm+tx9rO6KKF5nR+43oY+0Tw8x9LpFCdlWGsloFliN1ugjfZMjH//Ml/zYx7BpqHfxHh7r2kFTUkeIihFmBVm6jCJ7E9JoxMnNoKE8mXsT5MmeXkKvocv6cBagqegX9ejceCzhuF+8MfQU7e1E07QSnocEH76TRGsf4NVjr63dfTRS2KuPcSC7Mh+6wN09IkL8lfx05lC9xUUbqUvR9mOmpLEOyySiToNvU0ZR+c1MCy7uezcRVlKnKBc/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9dpVUtq1jUl/p3KFM2uz9AgUzlS1kgtN0EYdlJB6VdY=;
 b=wFhDhjsTsSmbUQtGI/fGYfVfLKBjsGzvcOx5UspWnD8bzWoForpX/H5cfmNmeuBlYfoUW5cfvLlnHfCMxVTEIKt+i16OMA1uRDMITDlzZZd3sClWkXfQyunlROAwb4IHQ7MkQrD8p5wfvuHhDW9DMEOSJ8t2XIs2ootk8vmBrqZlqf8hWFMJ36Rz7BGW84I318BnpvYWwFORDxxKdfhhyAkRfMPln6NCQDTdmpoxiarUTnI67Zf0MJkgU0IhHLjSwM+fUDIaSfvWAcM4kzsiZbIg2pQ1eXuYbrLF+bKkeNE2mEpt3fbKr5H0JhGHzRC39FVW3vi5F/EWNA80jhe+kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9dpVUtq1jUl/p3KFM2uz9AgUzlS1kgtN0EYdlJB6VdY=;
 b=CzUwT2WRiCPA8U1igX7TnWtBHS1qnO8o/EOrCF7d9DWiOq1ahc+X1rkZqXvQS7WasZh1yKsnQiDO58yEWsnw1cqLJHjwaD8YiruEbVhOdkNEaCAuva4ydxvduzL4JgA5Mvug6+dlvPaQD0LXzPissiM8qXEhXdYuz6necrVh4Fc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by PH7PR12MB9150.namprd12.prod.outlook.com (2603:10b6:510:2eb::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Mon, 10 Nov
 2025 11:57:13 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.9298.015; Mon, 10 Nov 2025
 11:57:13 +0000
Message-ID: <c505396e-6b04-4dbf-b251-d623261e6bb3@amd.com>
Date: Mon, 10 Nov 2025 11:57:00 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v19 11/22] cxl: Define a driver interface for HPA free
 space enumeration
Content-Language: en-US
To: Dave Jiang <dave.jiang@intel.com>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, dan.j.williams@intel.com,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20251006100130.2623388-1-alejandro.lucero-palau@amd.com>
 <20251006100130.2623388-12-alejandro.lucero-palau@amd.com>
 <ea62e7a2-4754-4e5f-aed3-2125c90ba007@intel.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <ea62e7a2-4754-4e5f-aed3-2125c90ba007@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: JNXP275CA0022.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::34)
 To DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|PH7PR12MB9150:EE_
X-MS-Office365-Filtering-Correlation-Id: e8b7e175-92e5-4665-3802-08de205048ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RE1ub1N2QnFwdUJNS0VxMktLc0U4SjBUaS9ZSWtPL2dETkhzaHNvR1laNDZa?=
 =?utf-8?B?a0wxRUNsYkpjdklpRDhCbDNpUXdlSzdBRnlSMERNbmFvZzljb1V1ZUV2ZktP?=
 =?utf-8?B?ZUVZT05waWsrZVZjL1NyOUw2bjhqd0d2MCt1S0lKVGZhRUpKSUdSV0g3dnRK?=
 =?utf-8?B?UVFwUFJDMmFwZ0pPNHEvbWxOTy9TZjVFN2tQZnR0cUJ5amd3VmtZYXZXV1dF?=
 =?utf-8?B?R2lNaWVKZ3VUa3Z1VjhjdlN0Rys0aEdFMVZFZ3JKRDJQNUtKZ1JEa3VNem5S?=
 =?utf-8?B?S0VZcy96bE5lUXl1VGFYREM1QjJ3ZjdxNk4ycGJQb3Z1YjV5aWJka3ZmZTVP?=
 =?utf-8?B?QzVnYjFtbHNONFUydDZFSEFVZTFwUEFJdXdkUUJqckJRMGZRbmdtNW1RMHNH?=
 =?utf-8?B?L1VaV3VCcHo3UGlGQTYwRUpiQktjdDV4TTFsNmtZbC9hK0NzaFk2REFWbXV0?=
 =?utf-8?B?UkJ5Nnp3ZHJIQW9wdXBDQ25RdlVORWpFUU43VVhBQ2pCa21jRkJLNGtsRjcz?=
 =?utf-8?B?VlZNaXEza1IvMGZuaVFObkdxdXM5bjF6YjdqQ0R6YTZsbnVkYUNRZ2tsVUhJ?=
 =?utf-8?B?MFFkZmt3VmV6eWw2aklaeHRXdDRxNElHcm5wdmdqODdWMWtoM3RpN0NVV2Zx?=
 =?utf-8?B?cEdZTEFZMEJiQ0xocEhxdlMzdWU4WW5IVThGRmI3SVZEZTNsbnB2RGN6NGZQ?=
 =?utf-8?B?ZFpvc2w0cjFuenRqbjNZWDJGdmlXTzVGa1BnRjM0aFBETXcwN2lzUGIxTjBC?=
 =?utf-8?B?MnZBbWczOCtBVEJEdDdBbjdTYnJxU3VoaXNiRzlpTExWcXNmM1FwZUNkOThk?=
 =?utf-8?B?QVdXRlNCV0ZMUUNQRXI1TVVGMEpEY2JZU3dUU0ZmT0s4Z1NLMzFwUlMrMjkx?=
 =?utf-8?B?dWJYKzYwdnkxWnh1ODZyOWZENmRYUlhIQXVuajRldUFaQVVqSTI4WkVtVG1Z?=
 =?utf-8?B?WktkS0JqZzNncFdwclZtTHFZMVc2ODFWaGFMcDZkeGJrNjhhaTk3U2thL2Yr?=
 =?utf-8?B?aGNaTGFsdmRmeHh4T3poR0R4bVF3MzZCQ2pVYk1mTFlqTHRQNXkrWVlxUkhX?=
 =?utf-8?B?eVVYdlVJZG4rcEJQcFVlRFZUMG9PdXB3UFk2MkZxM3AwMkhtcWJCUFROazJI?=
 =?utf-8?B?L0gxeXQ5a1dxVjV0QzJNMmxlYy9jRVJmQVoxbnNDckttRXIxK2k3RGwycWRi?=
 =?utf-8?B?WVVzcGU3WDhzay9WcnRETU5PLzU5VzF4OVh1ejVKR1hpS0dhbjhQeVNDTkF6?=
 =?utf-8?B?Zk5NaytBUFYyMWlacFVzV29EN0VlZjF5VHlGdDlTWXBMb0k2SnhDbzJldTFT?=
 =?utf-8?B?OTNFekZTNjNvbFVBTFRRUEJCSkE2NGljWUFsbzFGMEhTK3BuWFF5RWhBdDdm?=
 =?utf-8?B?bmdZTGFqcktGb3ZSQStFZXdpZW95d3lKREVrazRnS0lLVHZTeEFpL0c4ZUNn?=
 =?utf-8?B?SzdhWGJCUm1Bb2VEY1R0REtSQ3BmZnRXN09SMit5ZWNTUWhOOGdjRmFMMk5q?=
 =?utf-8?B?aURNa2U3bEYycDQ3WlFaRS85VnlNVHFWNEFpUjdWTEFXZ21oUjEwYUNFL3BV?=
 =?utf-8?B?TUVTbGV3c0lUUDYvWENmK2dtZFNHY3BFaUJyOTEvdmxlK1pLckJoTzRBQjhR?=
 =?utf-8?B?RW5vQXgyUGZNcEd1VTVjeFh5ZW94bGNITE1QYUdvelJkVjZwKzM4YVhHRXVs?=
 =?utf-8?B?Y0ZCdFZnSkJhNEgva3RTRzBaNVhnejVxK3lUaTJlWmFnbkN2dzdyOHdDYnZ5?=
 =?utf-8?B?MDlKRTlqQ3ZmQUUwRVVzZ0lPbWNJMGp2dGw5WUFENXVGZXJFNEY5RnZwNnpx?=
 =?utf-8?B?c1J2MnV1aGdKczhsdjQ2L2MvWHJHZnZkU001dGhQRkwyMnRJTjdBKzhyUHpT?=
 =?utf-8?B?anlUNmdCMnZETThWWjUwMTdQekJxKzVDU3hVTHV2R2dMWUtWclppcW9QQ0xq?=
 =?utf-8?B?dWFBKzk3UFp5VGhFZDRtS0FxbmlHQ29vUUhXenpUQ1VuaXdhKytuVVprRzNV?=
 =?utf-8?B?a0xoUzY2aWFkWHJvcE1lWFRtdnJNZnR4Q0kxUEFlMWMwd0NpWE4xc1JZaW4w?=
 =?utf-8?Q?Gk6Paq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UmxwMXRsVWxFQzV4T08wMHVYYlJ0dWR6S3AvNkRUSGxONkhKSzZrVmZERzBr?=
 =?utf-8?B?TVhsUGsxWHJ5ZVdpZjE4eHp3MlQyY3A3R09GQTRQTGJ3Qk1zMDY3MjZOa28r?=
 =?utf-8?B?dm1zNXRObkhvbEZDUWQ0bCs1R0NwLzBPUndEV2NzMEtsems1R2hpOExLSGJY?=
 =?utf-8?B?blFDaVliR0NiSjExdlo1UUpxU1llSTFmK3lmM2VIdVV3TG5kUmtwcnFMNXkw?=
 =?utf-8?B?bWFnNlhCS1grK2JYYzhvaWltK0MxYW1BVmZxcTlUbzZKM0c5cHg0RVNXVnJJ?=
 =?utf-8?B?NjZpTjlSVzlyNE5LZXdlMCtLU0VWNWczYUl3U0VkODc4bURJQlhBZ0R5bnJB?=
 =?utf-8?B?eVJhejV5ZFMyclkvNzRKOWltd2RvV2ZwNENONFhwQ2lVVUNvQmY3eEkwQ2JQ?=
 =?utf-8?B?Z0ZNbGluanlEemdCaGtyT1laclFuZDcrUW04YmpOeUVwWm9pNFM1YmlZSENB?=
 =?utf-8?B?Tm5ncjg1QXBPTTlFLzJUeWJnbXNsMEVFNGp1eWxpVXI5YzJ3Ull6ZjU0K0Ey?=
 =?utf-8?B?QU5pWGxOSzhKSDNrL2pmcGR6VURRbEFkL01LNG1FZi9mQi9VWGZER0ZkeExB?=
 =?utf-8?B?NWJvZVJIU0E4M2JyZjNUTXRScjB0V0pIVWU5aVc0QnN5T2tScjRFQm03OW5i?=
 =?utf-8?B?WHcrRjZsOWwydldBTjJCT3VXU2hXSFp0QUVhNmpOalFxNU5OaGVKaTlUV3F2?=
 =?utf-8?B?OHVxWVFueVd1YmdVSGtCWW9mejhraWlLNjB0cndZZm1NekFxOFlLYWpwR0ZU?=
 =?utf-8?B?d1VmSWtuQUFBdlgvenpxUmRkR2F0d2xxUWxZN09OYXh5dlNlb1h4RzRVa09W?=
 =?utf-8?B?bEovK1RUREpwNkxVL0FRVFlxZlFOcW54cm1jOVNtUC9jdnJTVFF2TVVKL3My?=
 =?utf-8?B?RVpuUjhkTFd5NzhnSnd2UUlGNmpIR1FqQ1M1WHZudnZJaGNsT0x4N1Q1eWFu?=
 =?utf-8?B?eTlMdloyOFNzakYvM29LbTh0NkR6MTc2UlB6NVRrb0FCTkRPOFFNS05MTFdr?=
 =?utf-8?B?NEtJbGgycW9Uc3NuY250QnlWbXFvTzhSQzF6dkRJS2ZreXJQWWJYbWg0ekhX?=
 =?utf-8?B?OVhsOEpzTkxKU0RiWUMxcUlZbWpyajJYY1BYOUpianJQWVBCQUlmNldtMVVm?=
 =?utf-8?B?K1p1cCtXbG4wT2xiZXQ4ZkVVcll3SWtaSU13TThPaDNKR2xTQzNZYVU5ZUZB?=
 =?utf-8?B?QWQwTkh4eFlydG9rY01lZXJ5SHVJQ3FQOFFmQW1WTTJiRnJvZ21SM01WaWJE?=
 =?utf-8?B?NXZ3anZYSHNvL2JLcU5na1g1YlJULzNEVk1mL2lRSlA1Z3p1RkxuWmJKUUg1?=
 =?utf-8?B?UWhKWkY4NWFXVWw3K1VnYzlYaThpMDR4OTZCa0pKL3oyQ0licnpoN0x2Tm4w?=
 =?utf-8?B?TkZHb1JlZDluN0pVU1h1K2IrQU9qTmpLQlVHd0FudXlmeUxzVmJJZTR6bmxZ?=
 =?utf-8?B?L0pURk5NaHdoYnYvM01SRTJiblVpWFh1ZmJnT0NxVnlYWUlFZHJDeUtTS2Rh?=
 =?utf-8?B?MG1XeUhSaUhhQlhkMUd0WnY3OWtid3FwZWhzbmpQWkJwRk5LZm1aNk0vdUI0?=
 =?utf-8?B?TnpLQVdQbXFuTTBya2NHc3lwQ0dWMUhydTdGQTVOdEtmU0pEUlFNdkgzNkFQ?=
 =?utf-8?B?RlRhZS9KaDArZm05TzdyUFBMbXVzdDdGSmVVZElTU3p6SE9GWDBGMW1vSkJY?=
 =?utf-8?B?eFVLT3FWZGhSWjhEMnhXZkMxM25kdVF4bkVObnUxMU4rTktiVlh4d296VGM1?=
 =?utf-8?B?THNzMzBuR05Lb3o4OEdYSkpna3BKOHVXNDFVMGlvNlNZUHljQmJUR25pbUdQ?=
 =?utf-8?B?MFFJZkVpU2t4dGhJZ3VTOXpCbFJvdG1jdG1nKytlQS9kdW0xNTllYTBndE1i?=
 =?utf-8?B?anVJTDJ4RkEvcm44SUZhUEFsQkl4dytMa0FwTDNQWmZVWUUzVTUwUHRzRDJK?=
 =?utf-8?B?c0Z5TGhzcW9JTXlYRSs1eHk5UENkc3J6KzdHa0V0Qmc2RXgwclpzcTJHVXBC?=
 =?utf-8?B?V1BNZEFpdGV3Smc0aGZ5WDlDUFRhL2grYUkzdXR3RHJIOFFnbEVsYk1seFpt?=
 =?utf-8?B?cE1iU1J1d1NWM1g4TjhlQjN4U05ncEtSZnJtaEZsSzQycDRCU3doYnhncElZ?=
 =?utf-8?Q?q3tUY6fiPzDHN9kxP0V1JFr/4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8b7e175-92e5-4665-3802-08de205048ee
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2025 11:57:13.0097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hdI9S/mtfJbjKG8QvBDF1c5r8CWzE1IFxQgkRZlr3aXjC4meV9cc0UVwcZ6hlhQ7wwsKdtz6jNKJbutVumX15g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9150


On 10/15/25 19:17, Dave Jiang wrote:
>
> On 10/6/25 3:01 AM, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> CXL region creation involves allocating capacity from Device Physical Address
>> (DPA) and assigning it to decode a given Host Physical Address (HPA). Before
>> determining how much DPA to allocate the amount of available HPA must be
>> determined. Also, not all HPA is created equal, some HPA targets RAM, some
>> targets PMEM, some is prepared for device-memory flows like HDM-D and HDM-DB,
>> and some is HDM-H (host-only).
>>
>> In order to support Type2 CXL devices, wrap all of those concerns into
>> an API that retrieves a root decoder (platform CXL window) that fits the
>> specified constraints and the capacity available for a new region.
>>
>> Add a complementary function for releasing the reference to such root
>> decoder.
>>
>> Based on https://lore.kernel.org/linux-cxl/168592159290.1948938.13522227102445462976.stgit@dwillia2-xfh.jf.intel.com/
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> ---
>>   drivers/cxl/core/region.c | 162 ++++++++++++++++++++++++++++++++++++++
>>   drivers/cxl/cxl.h         |   3 +
>>   include/cxl/cxl.h         |   6 ++
>>   3 files changed, 171 insertions(+)
>>
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index e9bf42d91689..c5b66204ecde 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -703,6 +703,168 @@ static int free_hpa(struct cxl_region *cxlr)
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
>> +	int found = 0;
>> +
>> +	if (!is_root_decoder(dev))
>> +		return 0;
>> +
>> +	cxlrd = to_cxl_root_decoder(dev);
>> +	cxlsd = &cxlrd->cxlsd;
>> +	cxld = &cxlsd->cxld;
>> +
>> +	if ((cxld->flags & ctx->flags) != ctx->flags) {
>> +		dev_dbg(dev, "flags not matching: %08lx vs %08lx\n",
>> +			cxld->flags, ctx->flags);
>> +		return 0;
>> +	}
>> +
>> +	for (int i = 0; i < ctx->interleave_ways; i++) {
>> +		for (int j = 0; j < ctx->interleave_ways; j++) {
>> +			if (ctx->host_bridges[i] == cxlsd->target[j]->dport_dev) {
>> +				found++;
>> +				break;
>> +			}
>> +		}
>> +	}
>> +
>> +	if (found != ctx->interleave_ways) {
>> +		dev_dbg(dev,
>> +			"Not enough host bridges. Found %d for %d interleave ways requested\n",
>> +			found, ctx->interleave_ways);
>> +		return 0;
>> +	}
>> +
>> +	/*
>> +	 * Walk the root decoder resource range relying on cxl_rwsem.region to
>> +	 * preclude sibling arrival/departure and find the largest free space
>> +	 * gap.
>> +	 */
>> +	lockdep_assert_held_read(&cxl_rwsem.region);
>> +	res = cxlrd->res->child;
>> +
>> +	/* With no resource child the whole parent resource is available */
>> +	if (!res)
>> +		max = resource_size(cxlrd->res);
>> +	else
>> +		max = 0;
>> +
>> +	for (prev = NULL; res; prev = res, res = res->sibling) {
>> +		struct resource *next = res->sibling;
>> +		resource_size_t free = 0;
>> +
>> +		/*
>> +		 * Sanity check for preventing arithmetic problems below as a
>> +		 * resource with size 0 could imply using the end field below
>> +		 * when set to unsigned zero - 1 or all f in hex.
>> +		 */
>> +		if (prev && !resource_size(prev))
>> +			continue;
>> +
>> +		if (!prev && res->start > cxlrd->res->start) {
>> +			free = res->start - cxlrd->res->start;
>> +			max = max(free, max);
>> +		}
>> +		if (prev && res->start > prev->end + 1) {
>> +			free = res->start - prev->end + 1;
>> +			max = max(free, max);
>> +		}
>> +		if (next && res->end + 1 < next->start) {
>> +			free = next->start - res->end + 1;
>> +			max = max(free, max);
>> +		}
>> +		if (!next && res->end + 1 < cxlrd->res->end + 1) {
>> +			free = cxlrd->res->end + 1 - res->end + 1;
>> +			max = max(free, max);
>> +		}
>> +	}
>> +
>> +	dev_dbg(cxlrd_dev(cxlrd), "found %pa bytes of free space\n", &max);
>> +	if (max > ctx->max_hpa) {
>> +		if (ctx->cxlrd)
>> +			put_device(cxlrd_dev(ctx->cxlrd));
>> +		get_device(cxlrd_dev(cxlrd));
>> +		ctx->cxlrd = cxlrd;
>> +		ctx->max_hpa = max;
>> +	}
>> +	return 0;
>> +}
>> +
>> +/**
>> + * cxl_get_hpa_freespace - find a root decoder with free capacity per constraints
>> + * @cxlmd: the mem device requiring the HPA
>> + * @interleave_ways: number of entries in @host_bridges
>> + * @flags: CXL_DECODER_F flags for selecting RAM vs PMEM, and Type2 device
>> + * @max_avail_contig: output parameter of max contiguous bytes available in the
>> + *		      returned decoder
>> + *
>> + * Returns a pointer to a struct cxl_root_decoder
>> + *
>> + * The return tuple of a 'struct cxl_root_decoder' and 'bytes available given
>> + * in (@max_avail_contig))' is a point in time snapshot. If by the time the
>> + * caller goes to use this decoder and its capacity is reduced then caller needs
>> + * to loop and retry.
>> + *
>> + * The returned root decoder has an elevated reference count that needs to be
>> + * put with cxl_put_root_decoder(cxlrd).
>> + */
>> +struct cxl_root_decoder *cxl_get_hpa_freespace(struct cxl_memdev *cxlmd,
>> +					       int interleave_ways,
>> +					       unsigned long flags,
>> +					       resource_size_t *max_avail_contig)
>> +{
>> +	struct cxl_port *endpoint = cxlmd->endpoint;
> Do the assignment right before the check. Would help prevent future issues of use before check.
>

I'll do, but the pointer declaration will be placed the last one with 
the new line length, just before the assignment. I bet some reviewers in 
v20 will tell to do the assignment along with the declaration ...


>> +	struct cxlrd_max_context ctx = {
>> +		.flags = flags,
>> +	};
>> +	struct cxl_port *root_port;
>> +
>> +	if (!endpoint) {
>> +		dev_dbg(&cxlmd->dev, "endpoint not linked to memdev\n");
>> +		return ERR_PTR(-ENXIO);
>> +	}
>> +
>> +	ctx.host_bridges = &endpoint->host_bridge;
> Would there ever be a scenario where there would be multiple host bridges that requires this to be an array? I'm not seeing that usage in this patch series.


It has been suggested by Dan the cxl core modified for Type2 needs to 
cover other impending requirements, and this one comes from Dan's 
original patchset.

I could avoid the array as it is not being used for sfc, but let's ask 
Dan specifically.



>
> DJ
>
>> +
>> +	struct cxl_root *root __free(put_cxl_root) = find_cxl_root(endpoint);
>> +	if (!root) {
>> +		dev_dbg(&endpoint->dev, "endpoint is not related to a root port\n");
>> +		return ERR_PTR(-ENXIO);
>> +	}
>> +
>> +	root_port = &root->port;
>> +	scoped_guard(rwsem_read, &cxl_rwsem.region)
>> +		device_for_each_child(&root_port->dev, &ctx, find_max_hpa);
>> +
>> +	if (!ctx.cxlrd)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	*max_avail_contig = ctx.max_hpa;
>> +	return ctx.cxlrd;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_get_hpa_freespace, "CXL");
>> +
>> +void cxl_put_root_decoder(struct cxl_root_decoder *cxlrd)
>> +{
>> +	put_device(cxlrd_dev(cxlrd));
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_put_root_decoder, "CXL");
>> +
>>   static ssize_t size_store(struct device *dev, struct device_attribute *attr,
>>   			  const char *buf, size_t len)
>>   {
>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>> index 793d4dfe51a2..076640e91ee0 100644
>> --- a/drivers/cxl/cxl.h
>> +++ b/drivers/cxl/cxl.h
>> @@ -664,6 +664,9 @@ struct cxl_root_decoder *to_cxl_root_decoder(struct device *dev);
>>   struct cxl_switch_decoder *to_cxl_switch_decoder(struct device *dev);
>>   struct cxl_endpoint_decoder *to_cxl_endpoint_decoder(struct device *dev);
>>   bool is_root_decoder(struct device *dev);
>> +
>> +#define cxlrd_dev(cxlrd) (&(cxlrd)->cxlsd.cxld.dev)
>> +
>>   bool is_switch_decoder(struct device *dev);
>>   bool is_endpoint_decoder(struct device *dev);
>>   struct cxl_root_decoder *cxl_root_decoder_alloc(struct cxl_port *port,
>> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
>> index 043fc31c764e..2ec514c77021 100644
>> --- a/include/cxl/cxl.h
>> +++ b/include/cxl/cxl.h
>> @@ -250,4 +250,10 @@ int cxl_set_capacity(struct cxl_dev_state *cxlds, u64 capacity);
>>   struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
>>   				       struct cxl_dev_state *cxlds,
>>   				       const struct cxl_memdev_ops *ops);
>> +struct cxl_port;
>> +struct cxl_root_decoder *cxl_get_hpa_freespace(struct cxl_memdev *cxlmd,
>> +					       int interleave_ways,
>> +					       unsigned long flags,
>> +					       resource_size_t *max);
>> +void cxl_put_root_decoder(struct cxl_root_decoder *cxlrd);
>>   #endif /* __CXL_CXL_H__ */
>

