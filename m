Return-Path: <netdev+bounces-154920-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A008EA0056A
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 08:58:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5B4618839CC
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 07:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A0541C5F1C;
	Fri,  3 Jan 2025 07:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kg+GJ3MN"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2057.outbound.protection.outlook.com [40.107.220.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69071C5F09;
	Fri,  3 Jan 2025 07:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735891105; cv=fail; b=MqxBrxadqSMGCfiQ6viFzuRVm6J2Xo6dY1x/N/T+NeS5WABGcqP866MBthHmQstTFRijcGPOPmkgOEbL+MLnBWIksX3jLjFjVC/IdWsn55ZkPf5T3+VvQrWmsynhEDSTJ9LKGZnNNPro40Cmk1eAWZ6HJt3tP557J0M1BqYAZu0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735891105; c=relaxed/simple;
	bh=uMRWLSs6JdoLHD0Y4yYXtvfhff4hkgwEQ5TLYpGzbFs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tpdBJH7y2PUHsinZh9sMRMe87SysUAgyCkd5v9V58lk0rqR2ePqA/4EXfOVPO8hI9sqZrHhVcKY9DZT5OATjTYvARAOYfNJm+8xTWw8fYXZ/eQVuXJPT0jm7gUBcnW8PQquxtafOLDM1Str/qQsyGe0wk9SWwOP7Ps06b9TIjVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kg+GJ3MN; arc=fail smtp.client-ip=40.107.220.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oXOihI4IIZEtV72JxeV432QA1gKvunUufxq/m9iE+isDIp5bGx7JotBDRi2pJyFThoa2b5NnAJBvqqP/FTSEfKW7p7gNueflDZl4xjzOK9A0PzJwpq9+tMsu5p/96BXBsdHOp7p+O7JxLd0XD18KCERtX9o04nh/PHWGAuAEQhm1UcNhNxhZIIRUo9QYPsJ5YpRyViHc0XzGR7E+292H1aAgyj0c+NKaiYWO2TCUuBJtHoizci7QgdRkG4IDc3OAFGhk/600bTrzUe0SREmqDPxwcCKq6d8QQ5T1K/NLPJpjkBlM7dSTr/ShaJJylftnLa0To79JALeQbtYy46V9vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DgkxpuSX4GTbm2jHCDH6T6S6ZsJUOB0J1HyO9SSNJPQ=;
 b=fHeF29d5sLl/SCcGJWfgRFbkqYmOEM2TSZ6pB5c1C7QDxCxkMyzbnxlYy7DfTTox0c/Mq8c7E4vz/y50FF2m0du13HiTvDtLTq0ZN1riGC5ERBTe0qhQ3JwJQG8rbZSYmP6Ct4AYJLmwq1pz6K+KWHbju/fHgW9FUMnFKwU4TtjmCvYcj6LDCiZqpyqWnoJC4LMFczIuHbn8+cQKOh1Gc7SdLZQfdQZyoXpHBIJ5EMGkY/DUxUlX/CQA9ScZLRFX3j5Ao2GXFnPEjJ5WzJ6lVzqWxFHvsuAQQPfxfmH3ClymW+djB/QAA+NAElV6NXPkJRZfxHf9dr3ViGgXX+dWwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DgkxpuSX4GTbm2jHCDH6T6S6ZsJUOB0J1HyO9SSNJPQ=;
 b=kg+GJ3MNf4j9F3zUQ+IfqIvj5cLyfOusnx0MErstO0PO3Habmpf9NLMDaX7M/K93EKS60qT+2/5ahnVLiy9p1zpIpfN9i/evIZ5m/FgI3l1aVfFI9iSHbVHkEOFGpMLLvLjAVpM9rXTgeC+w5qHP3lzcp+grmIPDUEU0eJ9AczI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by DS0PR12MB6390.namprd12.prod.outlook.com (2603:10b6:8:ce::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8314.14; Fri, 3 Jan 2025 07:58:16 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%6]) with mapi id 15.20.8314.013; Fri, 3 Jan 2025
 07:58:16 +0000
Message-ID: <8b7a94cb-f38b-ddd9-82e7-9579119e78b6@amd.com>
Date: Fri, 3 Jan 2025 07:58:10 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v9 17/27] cxl: define a driver interface for DPA
 allocation
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
References: <20241230214445.27602-1-alejandro.lucero-palau@amd.com>
 <20241230214445.27602-18-alejandro.lucero-palau@amd.com>
 <20250102151555.000072fd@huawei.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20250102151555.000072fd@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS9P194CA0022.EURP194.PROD.OUTLOOK.COM
 (2603:10a6:20b:46d::28) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|DS0PR12MB6390:EE_
X-MS-Office365-Filtering-Correlation-Id: e43ea881-a7c7-4774-7325-08dd2bcc611b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TkdLRnpROTdpbU9KNjZtVUNaTVFEeUJzRjVjbmltZlVLanE3Rjd6NC9uTThr?=
 =?utf-8?B?SWl6WjN5UHJFdE05MVFqYzI3MGlIQTFKcC9nQVhvZzdmbXpnSmtpWWNoOG92?=
 =?utf-8?B?M2hlRStyOUNFWERSakpodXp6SHhRZ1BjWU5HTml3bkZmS2puazBnc1BER1V6?=
 =?utf-8?B?OFNySWh5VnZVS0h0aGtXV1dXbGczNnZTWGVRZ0k2bVQ4T1QxcFBTVDZHVkpX?=
 =?utf-8?B?bWRKakxkTlhVTU91bWZJUHVSak5QNmhnYktqUEs5LzlTWGpKRUxGS1FtT2Nr?=
 =?utf-8?B?UFhvZWJjMXQ1Szl5U3NyamEycncxU1RaMjZYVHliSkF2RGQvN01pN21GRnp2?=
 =?utf-8?B?V0J0NDRHd002OE1qbEc5UGx5V294L0hsT1RvMWNjYnNyYitjYTlTQVJDdStx?=
 =?utf-8?B?L0xqOUhsNE5kZEtYKythTy9VN1BNMnpMYmpYbzYwTURjdWJSckcxelllYTNR?=
 =?utf-8?B?TkFya0JpSEx0K3hWTHhLb3JFdWg3MWRaYjZoYXBLWFNobFNESU5RNGx5eUZ1?=
 =?utf-8?B?cGx2TDRrM1YvM09TNmRWWE5zaEZONXl2WWdWajErelhkM2cvV2FLYlJNcDZ6?=
 =?utf-8?B?N043MS9sbmxtZEo0RERhOXZKVVVkblVpVXFpVFFBVWxNQklpQzY1VnppMHlU?=
 =?utf-8?B?L2lmVGpTSUxaZ2YyVmVVOFV3WHprd2FKU2xJeHAydUc4Wi84K1h4cStOVSti?=
 =?utf-8?B?UUxhd0VyTUE5OHllWjBJMGdUS1RQMFlaVjJrQUk1Rm9LSTF6dElhTTBuNzlt?=
 =?utf-8?B?Q09UdHJ6YmpoTU04VzYxc1VJRlBSbHFzV3FTZ05lcExSMWF5UXBnSGVsQ3lH?=
 =?utf-8?B?NERKZ1MzMnRzczBmMzlqTnowTDRGK2oxZ3FSZVRQVi9JSVVITlBKMUZ3ZWdF?=
 =?utf-8?B?WWtiQU9kTER5S1VnWmo3YWxpcGc5MWtueFMrTWRnaXIzLzQrNktSR3dOWEVp?=
 =?utf-8?B?S3NxaU1PZ1B2bVU2eFdQMU8zeHkyQXhJdjFtQjFmakpBdCs5bEVndUJQK003?=
 =?utf-8?B?bXZrNzhNaDVHMmoyQlNlYlYvTjBQbmV5Z0RaNkIyKzlyKzVaalYwT0JWZDg0?=
 =?utf-8?B?Sm1pMlR3cm1ZZ2d3eXpBY0NXM2NsaENoSEJuTm5jRG95UTdjRXVXODZVZ2Fh?=
 =?utf-8?B?NWgvR25VSVQ5eEFVVlBoNEpLQ09HTTF0UDg1RHVza0Z5c214QlJtWnhMTVJP?=
 =?utf-8?B?eTdUdThnc2tZeGdLS3V1OXU5Um1idU5rTnpXMk9PYXZoUmsyNTRHQU83bGF4?=
 =?utf-8?B?VHhVRmlrOXAyZlg1cXBJOEs2RmdkRU9iZjVhY3RESGY1MTh3MEhIVnptcCtY?=
 =?utf-8?B?ZXJwZGVpNFpFeE9pY2E4aTE1MTVCQ05XU3owaVhVRGZaSklLYjM4bUV6QUlz?=
 =?utf-8?B?QWVHUmJjeGx0TTFxOW94SXEzZTBsYnUxWnFtemZocS9IOEJoRENZRkV4L0JR?=
 =?utf-8?B?OW1Rc3krY2dmYktyaHR3cjVxSTZ2OFhJWmtPTm9KRVhzanBWNWMzNU5IRlVq?=
 =?utf-8?B?bmRkdWtYZUh6ZlF5ZmxpN0tEQkZZaVBjbS9yRUJwN2lSMWNCTUR1TFBOWnBG?=
 =?utf-8?B?VndQcHQzNCs2NGpXOHhISlliTGxENE43SnB4ZklWNzNsd3pjNXdoOEFvT1Az?=
 =?utf-8?B?S1NWM3kzdDJVQUlvM1JrbmttT1ZUcTRTNEE0dWUyTlR4R2F5NkEwdkNyeGxG?=
 =?utf-8?B?dDBkNkdZYjNIL2VLRll6dTZPSGg3SDc5MWZHNkVsaVBOQ1RBdlkwRnk4dGpY?=
 =?utf-8?B?VjBlczRIaUY2aHJ6WHJHMDhvdC9Sb2VSYjN4MG8wbVU1aXlqZTZrNkpNVndP?=
 =?utf-8?B?Y1Btbm50UHlIZWlYaU9yZmYwSk1QMXhodGZabmIyV3ZXWC9IZ1NYeUM1eDha?=
 =?utf-8?Q?QjMFal5n1aVFo?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZFVVMElsS2c2aWlFbUdYZHZrcU5CZDFWSHBORkpjeEZ2OUxDOXZBcmVXNE5s?=
 =?utf-8?B?WnFYQWdOMmZBUUJuWFpqTS9FSFQyQ2lZd2EyUlUyckJXZHJoQjRrT1RSUDR4?=
 =?utf-8?B?aWkvNzQvZ2hXYk5yUGlrdWdudUg1M3pKWDYrUGV0UVYwbEUzL3ZBRTRYVlZ0?=
 =?utf-8?B?M0VvU0M5alFpM3R0NXhqK0xQczYzWXdKczRLQWdzM1Q4WWhWL25DQWo1OEhi?=
 =?utf-8?B?c0dRODJFbjNmd29JZHhUSGNHdFBKUC9pWXE5bW5iZ251MisrdWJJUUg5N2gx?=
 =?utf-8?B?a1NmS0NHdlB3VC9mMmJ4d3dnVTVKNUFabTViYVhQbVcyYm01RG1UOVpSQjFL?=
 =?utf-8?B?bkhZUkR4dFBUTTBHcnBoMTJJWGRlUDRHOU9IeXR0NXJrOWRDSklrNmdOdkFD?=
 =?utf-8?B?QU1RK2lnaEl4SXVuRjNxS2c4UlU1RDhPd083Zko0eFQxMGtsc2tKbmVncGQw?=
 =?utf-8?B?SFpFSUlzaFA5NmF0ZndlNXNIS2toVUtNTnh1WjBDSUpCamhldU9heG54Zmpo?=
 =?utf-8?B?NjFJRlRZa0JUY0lrUDlJK2srRVNjQVlOOTJ0VTh2S3cvOXNxYUp2OUthc0NB?=
 =?utf-8?B?cmVuOTRhMWVrMzh1dTZPMDhRR01Sak1lY0QyWEF4aWZEK2dEb0wxSndaS3g5?=
 =?utf-8?B?RXRMczcvRHBNbDh6SWpTdkJUM0hZeThacndNNGNkZmVMY1YzVTd2eVlSMkla?=
 =?utf-8?B?WVRadUI5Q01paThaRVlkc0pDeHl2dDFOU2pielI5RVVHaHkrbDFGUnVYZ2d3?=
 =?utf-8?B?bXhUQVlpMUFoRHJSYXhPTlYyWUNQRHZJTk84allPUmFGSVZIRnFRZ1AvaTZj?=
 =?utf-8?B?TUw1RHhUOUk5by8yWGxFMVZTOWtEVURaa3BQTm5LaFVnWFREdVlkM0p3ZGtD?=
 =?utf-8?B?bDV1Z1I5bjV2NlZoZkJoYis2MjNUckJXL09BQjI1UkFYdGcyZHZuQjI4YktK?=
 =?utf-8?B?a3cwb0M5ZU0xamZFSkdkTmtEYnl0U2Q2ZEJ6eGt4NjRxemowSUk4U3dTNnZx?=
 =?utf-8?B?SjBxY3kvSk1RUUFxWEdsVklzbzhvVUg2WXNQMGx3SUlSYjlycG1BdkxFeWx5?=
 =?utf-8?B?bVRiUmdQTUVHSTd6SkpCZXZhSlhyRldWRHFtSFRxQVgvdTY1ekJmeW5nK2hK?=
 =?utf-8?B?eko2TWJndTNYdkk3YUd3OUpDUHdZWWMvdS9wN3VTeEV3TllsdUFiY2NaQnFI?=
 =?utf-8?B?bTJKT2g3L0ZZVkpnVXlGUXd2QlMxMmR1MnhDbDAvemV6clNpSDBRUGdXSXhl?=
 =?utf-8?B?cWR5TzhJNFNCdXl0VnBJU3hxRVVnNFUxYUNIcWdRSUpzV1pGeldnd2JDcC8w?=
 =?utf-8?B?d296bEVsMHJ0TEV3TWRIYlYvZ0Y2dlpja2xqZDhLelZudFAwa0xYMmVacGNu?=
 =?utf-8?B?VDQ0MFlQNTJhTHNzNTJGbGFUY0NJQnZQeU9KTldqWTVXNzhKczN3S0NZdzRq?=
 =?utf-8?B?MDZMVkpIVlpOUHZmTzRpMFNDRitCUW1XRGZUYVpNNEo0SC9ya25nRHNhN2RQ?=
 =?utf-8?B?NE5yTXQxbnNEbUFGRU5FMFEvVUE1TU9ETkh1cWhkTWFWdWp2bFJYdTJoTUFK?=
 =?utf-8?B?WTY0ZTJWWS9TcmVWUkNNOXNYNEtPVTNybWp3STNsRXE2djZuK1RLVWNqNUpL?=
 =?utf-8?B?VDFjK3BIUHpncHIyYlVVNmdEMmNYMXlYZ0loalRNblNvMnZ4Wk1wQi9jRW5G?=
 =?utf-8?B?TlhYeklZN0szQmt0TWt4OUVXeDRrNS9WS3ZWZjNPd0lMaVNVc2xORDZUT3FX?=
 =?utf-8?B?djE5ZFZIUlN3cC9OVEY1bXpsUTZQSkFkNDduL2dXbWFMM2drbURFQ0k0ZExa?=
 =?utf-8?B?Z09FbXo2NnJIa2tpdVBQbklOS0RjVm1SRHE0VWZSSG11VkFhM05NYlBZZzhG?=
 =?utf-8?B?LzYzRWZLYkpNNnJPbFJRSXMwOUJrQXI3OTJxZGxGd3BkeU55L2lFeEhJcUxO?=
 =?utf-8?B?MnU0VXBuWnAzcEtpNVphNlJpSmNBSWE1QlRXT3dwdUZEL3JibzNLWUNMcVdW?=
 =?utf-8?B?ZGdWV1d0amxDNjBWNy92N1R5R0FOb1VJZmN0RWIxbGxjYTVSY0QrY3BRbDVI?=
 =?utf-8?B?dDdZZGNIVTQ5Y2lpOWdQOVY1SStpVkgwWkc5cEp3S002cHROaG9CZ3p0blZH?=
 =?utf-8?Q?en2Jk9X61ynLpXufBDlEXDQed?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e43ea881-a7c7-4774-7325-08dd2bcc611b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2025 07:58:16.1238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5mMdgAiaSTnynCQ/DAt7j95Ufom+Lr4N2qHqXa8OwgSPID0hXksMcDLEuW/bdFtR7uNEIYyjpBZnh4Yip6bMfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6390


On 1/2/25 15:15, Jonathan Cameron wrote:
> On Mon, 30 Dec 2024 21:44:35 +0000
> <alejandro.lucero-palau@amd.com> wrote:
>
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Region creation involves finding available DPA (device-physical-address)
>> capacity to map into HPA (host-physical-address) space. Given the HPA
>> capacity constraint, define an API, cxl_request_dpa(), that has the
>> flexibility to map the minimum amount of memory the driver needs to
>> operate vs the total possible that can be mapped given HPA availability.
>>
>> Factor out the core of cxl_dpa_alloc, that does free space scanning,
>> into a cxl_dpa_freespace() helper, and use that to balance the capacity
>> available to map vs the @min and @max arguments to cxl_request_dpa.
>>
>> Based on https://lore.kernel.org/linux-cxl/168592158743.1948938.7622563891193802610.stgit@dwillia2-xfh.jf.intel.com/
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
> A couple of really minor things inline. Either way
>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
>> +/**
>> + * cxl_request_dpa - search and reserve DPA given input constraints
>> + * @cxlmd: memdev with an endpoint port with available decoders
>> + * @is_ram: DPA operation mode (ram vs pmem)
>> + * @min: the minimum amount of capacity the call needs
>> + * @max: HPA capacity available
>> + *
>> + * Given that a region needs to allocate from limited HPA capacity it
>> + * may be the case that a device has more mappable DPA capacity than
>> + * available HPA. So, the expectation is that @min is a driver known
>> + * value for how much capacity is needed, and @max is based the limit of
> is the limit? Not sure what the "is based" means


Typo from original Dan's patches.

I'll fix it.


>
>> + * how much HPA space is available for a new region.
>> + *
>> + * Returns a pinned cxl_decoder with at least @min bytes of capacity
>> + * reserved, or an error pointer. The caller is also expected to own the
>> + * lifetime of the memdev registration associated with the endpoint to
>> + * pin the decoder registered as well.
>> + */
>> +struct cxl_endpoint_decoder *cxl_request_dpa(struct cxl_memdev *cxlmd,
>> +					     bool is_ram,
>> +					     resource_size_t min,
>> +					     resource_size_t max)
>> +{
>> +	struct cxl_port *endpoint = cxlmd->endpoint;
>> +	struct cxl_endpoint_decoder *cxled;
>> +	enum cxl_decoder_mode mode;
>> +	struct device *cxled_dev;
>> +	resource_size_t alloc;
>> +	int rc;
>> +
>> +	if (!IS_ALIGNED(min | max, SZ_256M))
>> +		return ERR_PTR(-EINVAL);
>> +
>> +	down_read(&cxl_dpa_rwsem);
>> +	cxled_dev = device_find_child(&endpoint->dev, NULL, find_free_decoder);
>> +	up_read(&cxl_dpa_rwsem);
>> +
>> +	if (!cxled_dev)
>> +		return ERR_PTR(-ENXIO);
>> +
>> +	cxled = to_cxl_endpoint_decoder(cxled_dev);
>> +
>> +	if (!cxled) {
>> +		put_device(cxled_dev);
>> +		return ERR_PTR(-ENODEV);
> Ah. My suggestion on v8 missed that there is an error block
> below. More consistent with rest of the code as
>
> 		rc = -ENODEV;
> 		goto err;
>

I'll do.

Thanks!


>> +	}
>> +
>> +	if (is_ram)
>> +		mode = CXL_DECODER_RAM;
>> +	else
>> +		mode = CXL_DECODER_PMEM;
>> +
>> +	rc = cxl_dpa_set_mode(cxled, mode);
>> +	if (rc)
>> +		goto err;
>> +
>> +	down_read(&cxl_dpa_rwsem);
>> +	alloc = cxl_dpa_freespace(cxled, NULL, NULL);
>> +	up_read(&cxl_dpa_rwsem);
>> +
>> +	if (max)
>> +		alloc = min(max, alloc);
>> +	if (alloc < min) {
>> +		rc = -ENOMEM;
>> +		goto err;
>> +	}
>> +
>> +	rc = cxl_dpa_alloc(cxled, alloc);
>> +	if (rc)
>> +		goto err;
>> +
>> +	return cxled;
>> +err:
>> +	put_device(cxled_dev);
>> +	return ERR_PTR(rc);
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_request_dpa, "CXL");
>

