Return-Path: <netdev+bounces-195449-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 55605AD0369
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 15:44:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 664AC7A399D
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 13:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E9FE28934A;
	Fri,  6 Jun 2025 13:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="o2OLDr+R"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF3F8C11;
	Fri,  6 Jun 2025 13:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749217481; cv=fail; b=HgNtg3SzG1H2rWA3j40/oXZslr1T6QucGG8SFBUjWzuf7iFYmK6Jtael8L2aUIkrTASQmNIet2Uk+1wyL9hOa5r/3G4hkY43NzzhWThi+Lk6Rlf7RHnxz7SsashmbH6C9Y2ouRBhWTMG2o7VqetjbkUlWC49pZYXa9oJ7iP+Igs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749217481; c=relaxed/simple;
	bh=M1IXKk/h4dcQ8DvaZFxV7HCtikJZjlTuuO7aTGitK60=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MviOIrlwvL2ifpjArSybso6l1MAsQ3lM/6H/O7hUZnzX5OhP2LWwe4WzeS3h8VGP+8Dr9OBKeQyMyROdQpX9jZ8v7m+Xl60o68tG/RMIeUcITdsfcYYW2Oqly3MHosZtYNuLRqn6c0p5uSJ4OWmQME/0WJ0+hOGXNwFD79WGTm0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=o2OLDr+R; arc=fail smtp.client-ip=40.107.223.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W8A7hLtL8R9jOyRQ03bi7ITBWchHLM5WshfQnHiB39+b2uPC7/TVupzS+qVM3GJmBIpeivoN6FzsQX9JQmRZz0/DW07t6GZUmFeJQvhY3cOl2hAdcUmauFCn3AVbC30jMunIbzKiXQqRI/SWQ3tm7icl3zC7j/GvfOCEdvzHMkWumcdOGG6vW/eAKBKFN9bRbMUUsbsfP/i7uZIM5vx84VwuofX0JEi0TObwFafSOFLBjY68gkCvaz4TAHaIm+vvkwFatcnirjdRUa7kVDbIzpjwOeNhKulpm1/hxOMv3slYEWWtBgSYdt/XVeVF3I06g1OGYARK0+GKr85pR3FdnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=84WOjK70tIzdEKVKTCmHJsU9eMrnPfmzlXqNz0FdSbM=;
 b=LFqBGrtUbT4eRO4gnWGwiUwcKVBg3zwHHiDQYRWBu66WnaqHrmrpqUGbC6Sx4ftXFthbe4IrZSsh7KwIhtWK0QWmzk8++xSLQY6oo09OBjVoAJ3JPG9C90xBpwWPixV/3p7VKpvL96oDi6TM1z07jmJY0pq1wwz/BAPzr4R+4KUWoMx23mljIvuiWjMeTo2lbovoyISeab8AhUrWQ94al80qKSxJQrAdI5m25bxIdUk52afPrP9ydjOXI8RSqRCJWqLqZviNirMvvkJ6e+zii9ZLi+sMB+5TwIX4iIfiXiTfwtyo00RrpX74mrIFBc+FJEly9NJvbg8RJpCkFhaLAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=84WOjK70tIzdEKVKTCmHJsU9eMrnPfmzlXqNz0FdSbM=;
 b=o2OLDr+RJMRt2HybMEAI/ig1AL+S3jtngp7/MAXVtxPK0VtW45cd0Rja038gpCVo3hL98CPKmzVnY2THcI6ibBnLC5FV72Tl7ZX5vvdOGyFzkN/eNEwyixxyLbsjSD+lbzftdSdKnvvANCxpsxpma9aY8XfPQy4eW4Wtj1qtP9Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by CY8PR12MB7538.namprd12.prod.outlook.com (2603:10b6:930:95::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Fri, 6 Jun
 2025 13:44:33 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%4]) with mapi id 15.20.8792.036; Fri, 6 Jun 2025
 13:44:32 +0000
Message-ID: <6bb1fb0f-cc74-4853-a9fc-2bf96cd66ee4@amd.com>
Date: Fri, 6 Jun 2025 14:44:27 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 20/22] sfc: create cxl region
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com
Cc: Martin Habets <habetsm.xilinx@gmail.com>,
 Edward Cree <ecree.xilinx@gmail.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20250514132743.523469-1-alejandro.lucero-palau@amd.com>
 <20250514132743.523469-21-alejandro.lucero-palau@amd.com>
 <682e3f3343977_1626e100b0@dwillia2-xfh.jf.intel.com.notmuch>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <682e3f3343977_1626e100b0@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6PR0502CA0053.eurprd05.prod.outlook.com
 (2603:10a6:20b:56::30) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|CY8PR12MB7538:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f8e0668-0a1f-4563-f6fb-08dda5004492
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L01PMWRkRlJXNmZWbjlMbzE5YlM3eVZUdTRWajhnei9jT2owc3hpZEUycUxD?=
 =?utf-8?B?NE8zZDVWZWhxRzA3dTlFMkcxbWxzU1JIbjBsbTJGNU1VVjgwRkF2T0tCejFH?=
 =?utf-8?B?bWNzZ2RrK0RDRlUycXVDbUI4bjNtbldnVVhjUjJMUGluYmxJVDY5Q1VJSjZw?=
 =?utf-8?B?VCtZQmM4cS91dmR6amJZNytyTTI2YUEvSUZwUTkrbWtrSnJiZHhYOVl3K3Z0?=
 =?utf-8?B?eXJxeHlyV1p3dW5LaGlCV3UxenNUd2lNTVZUVVAxSk45bjJqWHhSeTkzRTVO?=
 =?utf-8?B?ZzVmRUxpbXNpalJLczdXVXZqQ2tSMkpNRVRFbmlpQWxnVXNNS1NrSTlxMWRn?=
 =?utf-8?B?b3FCQXZuSjFQVzZGVUN6VTVOTE9kTDFESy9JZVBZVXNMdnRReUN2UzBCZm9y?=
 =?utf-8?B?U0ZMeEE1bVY4Vm94MnBiREEwd1E2aFlESStCZkhjSDZCQ3I5U0RKQ0FWUjdQ?=
 =?utf-8?B?d04vS2U1VEhaK1NCYlNFN0xReUM1cjRjek1kb1VObVR2MUhIWVh6L0QxOEIr?=
 =?utf-8?B?RmY4MFR0SEY0SEZsK1dYZ21rVVJqaE1PUHBBWHYwYTVkZXhVUk9XMjZwdnZ4?=
 =?utf-8?B?TEs1VDgxSWRpRmIra3kveVlhNWFXQjlacW02SVJLSDRVTy9iWFFCbnMvbFg2?=
 =?utf-8?B?VnFZQUx2bzhWT2trTWJIUVBTWTZiSzNFeGQxYU04RWp6S2MzOC9OcFJTME5l?=
 =?utf-8?B?S3J4OXRqeUswRHhFTUpFdmRlaDdpUlM1T1JYUyt0aTBUWk1EU0dPSDRqSkJI?=
 =?utf-8?B?bitPQW0xZm1IWjMvQ240UmVHTmFJQmJ0U2VaZmhFYUwzNnE4UGhBZG44ZHh4?=
 =?utf-8?B?SCtHMTk2MWdaTkZxeUEwcnFmNmNacVljMU5CdWVDcUxkWWhYSytWMXhhdk50?=
 =?utf-8?B?WHYwZHFyUzR1WHdqUzUzd00xVytKR1dTN2VMTlZsQytISmJTOStYTzY2aUpk?=
 =?utf-8?B?a1BUQ3BNZVFONVhjYWNLRkNoanV1MGRqY3Y0K1hwS1lVS25QQ2t3Y25qLy9q?=
 =?utf-8?B?UUg0Y292R2lhQUZycFl4enQ2L2JucmlEZXRVYmNpNDk0eDBSSUN2MjZKY0d4?=
 =?utf-8?B?WnV2RjFwZHBIQ2kyVW9JR2FSRVlxRXFQbHpJNjFLZVpFN09rVU41NlcwN2RK?=
 =?utf-8?B?S01CVFhreWd3VW9ZSm15eXo3WWNOc1VJa0RReVhud0tMTnc0M1dHV0FUMU9L?=
 =?utf-8?B?aTJYZzZxNXN3dGI0ZWR3MjVCWW5IdDdQVEcwSVU4djQxR05uOEJOQU1Ddk8r?=
 =?utf-8?B?bnk2QjNKRGx4T1Q1Z25JYmZmYzdFc3p5ZkJCd2Z1WC9jSitqU3ByS09NUU1m?=
 =?utf-8?B?c2w3SzgvaE1xNXVlYXZ6d2J1MU8rZU9ocURvaHNCTzlwRS9iUWNMaTY5U1Bh?=
 =?utf-8?B?c09od2EzOEZ6VzMvQUxIdDhQa095WXhaRmtVaTZDT2ZYbDE0NzlKRjBKUUZW?=
 =?utf-8?B?dFF6NkhuTDNRVW1jM3VpRy92MXdaYTNvL2NmV29BM2RseXhpT3BNUHhMQU1h?=
 =?utf-8?B?TFRubHNlc0dwVG55cGJuQzhXYURlbUlmVHpOYmpNdDdrV0pzYkVCbjh0bzNZ?=
 =?utf-8?B?Z3dtQXFsZGdhN0lwdEljdzJuTStSUVlaSUQrbFBDL1pHZC9kTkt4OTVkakp3?=
 =?utf-8?B?VXYzMlZzRFBNQUZEVFBzRWw2UE1PZE9xQW9lOG0wVHIyYkZOODVZWWxjeTZq?=
 =?utf-8?B?VUxFSTJUekxaOHVtZzdjUXNYK3RVS09IVSttZXVsdElJZ1V4dzFmSERIUmdm?=
 =?utf-8?B?OVJNd2RmWldtNjZONnZqeHhLdE5ubUVJZzZWNkRSQ21VcjVGdWUzZmVqWTJN?=
 =?utf-8?B?Wnd5MXk3K1Z5czl5cHlpWW9sNFc5UTIwbnJ0blJ5ZlJoK0JIbGpRYjB2cGRw?=
 =?utf-8?B?MGo3ZlovVVlnNklMQzZBZTVaVFBaSFVwV2pRcEY4R0x3bk0zNzZrMVBOWkha?=
 =?utf-8?B?bG0xRzNuNERwTXcwYlM3YS9Jak5IbFFNRDc1S0J1SWU3VWp3QU4wN2JsNFJQ?=
 =?utf-8?B?K3BPL2lud2hnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UkplZnRvclpERkU5bGR0cHo4U09OeXlybUNRNkRxUkgxN0w1cytQUE9TLzQx?=
 =?utf-8?B?YUZrLzJSUWMrMnJmdDJDZFpiVW90YTlmQ092SEtDNUNFek1PcjhnTjBBUDJt?=
 =?utf-8?B?em5zcWFsQ2M0Y1N1cWh5eGFnQ1NzeEQyeEx1UzR2TzJwVlRGaVVmTXFTdmx0?=
 =?utf-8?B?RzJyS2pqN0I4M0dEZng3V0piaFBGd2tOVlBNc1JQTExIYnp6Q3gwNE5XMGRV?=
 =?utf-8?B?UjZtL0NzY2lRczdnRDdLWGdRWkRMKzNEZkI4YlNrejEwWkZ6TmlBRWZ1QkNV?=
 =?utf-8?B?U2RkOWx5MkFWY1FxVlIxOUZGTmRGd0d1N0xVS1NTK0lYMmZnZGRLR1ExcFk0?=
 =?utf-8?B?Z1NXb3FLbjlEc3M4UmhQZkVGNDFVVFpVNURpNzBmYXQxR2lSclBtY2c2ZjNs?=
 =?utf-8?B?ampzWFBpODIxdUduVEV5TW5hMDVNcGt0UHRJZlNjejlHU21xdGVNZDVkbGEx?=
 =?utf-8?B?UmYrTk5CTkVMdVZWczNJNHJmQlZITm1DZmlXcWl2bHVrZmRxanhzK1dadS94?=
 =?utf-8?B?Q3YwRVpaN0hYSWNSWGlKK0lUbjlmcy9HaHNrRFMwcyt1WEh4VDQrRlFZdU1l?=
 =?utf-8?B?OERtWUkzZW9uSXl2dklDcHhUbU1YdDhKOTJCSHBJc3EwTXZCam9mb1E2aUFK?=
 =?utf-8?B?d2ZYeHBlK1NUd2ZCYnZsVGs5dWZkN2NhYThlWTFtUWhESEJkRFJ3YzAzcnZC?=
 =?utf-8?B?Wi9WYVZacThSMk1ldCtLdDhXU3dqY1RoRlhiUWlQdm1yNnpSWDJkejJFOHZF?=
 =?utf-8?B?cSsvVzQrV3F5Z3pTYk1HK2Fza3g3K0ExWHE2TzIyQTNpL09QazBGRWJ1R3U2?=
 =?utf-8?B?bEFITzhxaHhXR3VpdnF3ZEtBT21SbHQrSllnbGd3dkhYL1pRcWlnalQ5Wnlj?=
 =?utf-8?B?UjdaRTlWZ0ZEbHp0WHVtZmJXQW9rM2dRL0xPZCtlekhCM3VpTGNseVE5M0tq?=
 =?utf-8?B?alhMRUN2MkUxNFNrdXBGcjhrNEh2YU8vRGpoRUVEUmdBRlVMOEptNjFyVE90?=
 =?utf-8?B?azIzQWdjd0p4SW1TQUZCSUpNTU56b0tMalprTllWK0sxTTM5K1lkU3c3NWZD?=
 =?utf-8?B?eTZodGp6Wmkxc1Q1Y01hNzZqV2tCNEJXbkZaMERMc0xNMjFIVmplNVhsQWNl?=
 =?utf-8?B?cnU2OEM4SDhxckNLd2pKNFo0NFRtWjVJKzUrbnppUmt4bFNOMUg5bmJ3VmVw?=
 =?utf-8?B?Ymk0SDRCWmlIdkNjZ3dWZWp1bzRidGlJV2dCTHJsbDdEdFpyNks3WUNZVGNI?=
 =?utf-8?B?cFRmUmNZdTkxOE9aV1VSMEo1em81THhFZUx0Y2dGbmRDOWdVeExKRmRta2Zn?=
 =?utf-8?B?c1A4Z2wvRUxMVjNyTjlJd2dOa0VQOG5NbWlTYnVkazdmUzRIWHJ2WVI3bGJt?=
 =?utf-8?B?Y09wVUlDb1d0Ti81YzR6L3g1TEc3aDY2TE9OdWdPU1htdXZnczZyaGx0Wk9x?=
 =?utf-8?B?UWROeThxcTJab29uV2c3VnZYdUl1MTJCeVJXVTRCYndOV3Fqb0sxTGFyRitv?=
 =?utf-8?B?M1FjVWtNakhLNjJNWVpkZklrcWNXam8wSjY5cGg2eGdvSUJ2RHBvM0dKendJ?=
 =?utf-8?B?Wkx2dlExYlB6ME02WDlIcS9BMFMwdWdYVjFSc3ltN29iY2t5c1NEM0tMWE9a?=
 =?utf-8?B?YkNBRW1xbk9rNTVQOWxDcGkxVjArcFN3d09ZRXB5RVo4QVo3N0dMVE1PbWs4?=
 =?utf-8?B?SUJCdXBibUlqeVFlMGxEVzVTa0p0WlFYWDdLdnRGUms1cU9WQUw5M1R2NGhr?=
 =?utf-8?B?bHNyd2xvYWMzNzZISGVXOUliZG5VdGJPdmVJdy90UnM1emNRUWF3UW5nbysy?=
 =?utf-8?B?Z2hHWEJXUVlSa1A3T0kzSVdwSU9KQTcvam0rYlIxSUFETlo0ZzVlcnh2QjBl?=
 =?utf-8?B?Tkc3RHJWTzJVQnkwMHlwWWlBWVd1WjlZRHAwbndUbnlhTTFyQTlPSTh3Wm5j?=
 =?utf-8?B?djY4NUFHVFdFeUNHSkVRZThJREVuZGZ5UFpNQXl1K2dWNXVmQW5ONGNCWVJL?=
 =?utf-8?B?ekFoNzVVaTNBOW5WWXBuKzIxdkVGbCtYSGxVQTVVNjZWdE5RcEFRVmlPVnVO?=
 =?utf-8?B?dEV0N1QwU3hleE8wRS9kVXBUT0tYSU1lUHZpUkJhMmNQQ3kzK01yMHdrSlc1?=
 =?utf-8?Q?VE+jwBp4w7LzlLdPs6Uf/UX4z?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f8e0668-0a1f-4563-f6fb-08dda5004492
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2025 13:44:32.8386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TqKqASiIlgM3Bi9d4kc8H2bGels3663TQmynt3NtN2slVpoWbGBAyvLS65MudptNCXfq19aF5gh9uttrE8F//g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7538


On 5/21/25 22:01, Dan Williams wrote:
> alejandro.lucero-palau@ wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Use cxl api for creating a region using the endpoint decoder related to
>> a DPA range specifying no DAX device should be created.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
>> Acked-by: Edward Cree <ecree.xilinx@gmail.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> ---
>>   drivers/net/ethernet/sfc/efx_cxl.c | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
>> index 20db9aa382ec..960293a04ed3 100644
>> --- a/drivers/net/ethernet/sfc/efx_cxl.c
>> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
>> @@ -110,10 +110,19 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>>   		goto sfc_put_decoder;
>>   	}
>>   
>> +	cxl->efx_region = cxl_create_region(cxl->cxlrd, cxl->cxled, 1, true);
>> +	if (IS_ERR(cxl->efx_region)) {
>> +		pci_err(pci_dev, "CXL accel create region failed");
>> +		rc = PTR_ERR(cxl->efx_region);
>> +		goto err_region;
>> +	}
>> +
>>   	probe_data->cxl = cxl;
>>   
>>   	return 0;
>>   
>> +err_region:
>> +	cxl_dpa_free(cxl->cxled);
>>   sfc_put_decoder:
>>   	cxl_put_root_decoder(cxl->cxlrd);
>>   	return rc;
>> @@ -122,6 +131,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>>   void efx_cxl_exit(struct efx_probe_data *probe_data)
>>   {
>>   	if (probe_data->cxl) {
>> +		cxl_accel_region_detach(probe_data->cxl->cxled);
> Here is more late magic hoping that cxl_accel_region_detach() can
> actually find something useful to do at this point. I notice that this
> series has dropped the cxl_acquire_endpoint() proposal which at least
> guaranteed a consistent state of the world throughout this whole
> process.
>
> Did I miss the discussion where that approach was abandoned?


As I have commented in patch 12, I was not contemplating those modules 
to be removed while the SFC driver depends on them.


>
> The idea would be that at setup time you do:
>
> add_memdev()
> acquire_endpoint()
> register_hdm_error_handlers()
> get_hpa()
> get_dpa()
> create_region()
> release_endpoint()
>
> ...where that new register_hdm_error_handlers() is what coordinates
> cleaning up everything the type-2 driver cares about upon the memdev
> being detached from the CXL topology.


For clarification, we assume this detachment being due to cxl_mem or 
cxl_acpi being removed therefore contemplating a clean unwind which has 
to be implemented. Correct?


>
> Then your efx_cxl_exit() is automatically handled by:
>
> del_memdev()
>
> ...which includes detaching the memdev from the cxl topology.
>
>>   		cxl_dpa_free(probe_data->cxl->cxled);
>>   		cxl_put_root_decoder(probe_data->cxl->cxlrd);
> Otherwise, these long held references are not buying you anything but
> the ability to determine "whoops, should have let go of these
> resources a long time ago, everything I needed for cleanup is now in a
> defunct state".

