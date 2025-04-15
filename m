Return-Path: <netdev+bounces-182614-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB76EA8956F
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 09:44:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF9927A2728
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 07:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F8F27A133;
	Tue, 15 Apr 2025 07:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="X8FxE2SU"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC9F268FE6;
	Tue, 15 Apr 2025 07:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744703067; cv=fail; b=qtUi6o+P/lkSsnDHgAxkVlg3HC1Hs7VfoxMH4TdH+sYGg/G0B+1PkInFDPWJNuhVQXGsqAytgwDJ4uWLIZ3KRlDmGg5sSa7nFB4Boh7x5RFib+VWznOlhGCTppPiRV2ytNgqTp66osDlIhyrWs9yitlsvJ2tQ85TCiLMcIhGp3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744703067; c=relaxed/simple;
	bh=KNcZwUeDnJYS0CDkn9AzuO6QF8FNVMcEcqlrs8OAvnU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=USZgIR3B4mzP53e3C1VJTCwgC0xmcPLf5NgWBInl3xCF+6joJaoUYwMsJrs/LSlb0oIeeiGADvY32YEhUEZNUWmKHlNs1TWrRdO1c6hfJefvTXXGVZR7eAjnaqfQe2y0WXTWJiv0cNALZ9E7eWTGhUZ+Jie1tJfwagIgw4XKQhM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=X8FxE2SU; arc=fail smtp.client-ip=40.107.223.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a5Z9oa0cnxULAoCoZFQ1ZaW4UdMM5rzixxunXQq0o5blolppFAOh7G0fqT/1hOfrTBoCBRMmEb1JIKEobmRm3H+yjJEqLK8Ye7GV1tMBKNHum5bufMpTRFcAxx9RwFZZgeDgubnp8aYFHd8iN9SSkEU4NCN9drOMge5hxEcBBPWtFP58NHdnuywXEf+EzGUreA7q8HHBBwpoOKqFZbfXxDu+euu9oDpv0Za8l3socLUPgGtm5aEU0xLCOpkjhseJEaQYI2i38LwlW2irFu2ICuBM7ZHH7KY/o4w2FrkczeWX6lU988kSTuDzQOex2Ar7rQeiP6Lq3OAOBI5o5qs9yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NtnhSahIx7c8fC6HDpDNYcU0I25Pq0Pp3NBuXhD54qE=;
 b=RIJmxNGfnCWmNkwbRjAT/XtzUslUA1HI/FtFvcQPKQaCDrWfkjplsE5zki7gOX4GDquA0B1GF6DAdqq8+YwmWJ8hPiMmMu+NDsv2Akqkuu2IZH5e0qljjXKecebAQLvnXVvaGKl5k2VI2Vgneh3xIIC9fu9Lt7zyPhS19Y1nS24R6syhSleabxOnm6BQ3FaA+6b+M0n3lPmCTVMyLGXAT3wCbM6Ca6wxy/ZSe8IpC0PPo30C/lG230YsIK6432vnGVxK0kukaZp7ZRN4RnJyEQ1vZ461QkNEApouYjiKJfpz3HxnpUfkF4mkFiBFbDarhC9rmMsvd8eR+QSQfNcSQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NtnhSahIx7c8fC6HDpDNYcU0I25Pq0Pp3NBuXhD54qE=;
 b=X8FxE2SUm59ujIVrmBIMgyh/ufePAkInTWUOLCtOePxRQvRT4VcPYB6gNDX7pDysPV96tgPN+eqs3zlWv9OQncRhg7Sg/UkS+ozhZG6cOaZZ1Vz3Z79HCT/iAcfDEc9ZQj8gHYxwT9NlQArXFIyN2P9JdSwaAKkPU+gQ4VEYors=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4205.namprd12.prod.outlook.com (2603:10b6:208:198::10)
 by MN0PR12MB6246.namprd12.prod.outlook.com (2603:10b6:208:3c2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Tue, 15 Apr
 2025 07:44:23 +0000
Received: from MN2PR12MB4205.namprd12.prod.outlook.com
 ([fe80::cdcb:a990:3743:e0bf]) by MN2PR12MB4205.namprd12.prod.outlook.com
 ([fe80::cdcb:a990:3743:e0bf%3]) with mapi id 15.20.8632.036; Tue, 15 Apr 2025
 07:44:22 +0000
Message-ID: <fe89058c-cd98-4149-a37e-8b8052cffa17@amd.com>
Date: Tue, 15 Apr 2025 08:44:18 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 04/22] cxl: move register/capability check to driver
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
References: <20250414151336.3852990-1-alejandro.lucero-palau@amd.com>
 <20250414151336.3852990-5-alejandro.lucero-palau@amd.com>
 <20250414181833.00003eca@huawei.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20250414181833.00003eca@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DBBPR09CA0036.eurprd09.prod.outlook.com
 (2603:10a6:10:d4::24) To MN2PR12MB4205.namprd12.prod.outlook.com
 (2603:10b6:208:198::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4205:EE_|MN0PR12MB6246:EE_
X-MS-Office365-Filtering-Correlation-Id: 05ac95bc-14fc-4d21-5f01-08dd7bf15609
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V2tpZzlzQXNUeDc5djZRYlkyY3lrL3g5VS9yS2ZTYXVsbGJVV2VuMGhFcXlr?=
 =?utf-8?B?V1pLeDdSSmtJTHBoNDFJVkpEQWV3enVDeUtIdWpkSXhLQTB5Q25TYWpJOWpO?=
 =?utf-8?B?SkpaQ1BYb0o2ZmZSWVpJbDh4LzJqKzRPeXlPN1psOXRKR1dLWHMzSmluQ0Ev?=
 =?utf-8?B?alFKeXBWa3IybERRV21Ha1FlTGlwV0dDL2tBcjhwK1hKTERBeW1YcTNvL2py?=
 =?utf-8?B?c1h5ZDRQanhYalFoaU1FTkJES0loNGN5NStxLzRPZ1MweGZ0R00xeGYzREJO?=
 =?utf-8?B?VUpRVmFpS2IyNW85K2xZMkNLYTlNMjNBRjRNT1dTTW5xL09oYlRpNS83UDgz?=
 =?utf-8?B?c21OUXBRY3VHZUhaU3YvMkdIWnVndHdreGNLUTJ3ZmF2MFFwOEJxNUh5QkJY?=
 =?utf-8?B?SWlqMGx0ZWUvd3RYTVh2YlhDWXhkRkk2Z0wxeGdLajRhdEFEeWRiUG1NRnUz?=
 =?utf-8?B?cEVvTElKUkg3cDB6eXlOM1B4bDJYaWdMOEVHNkt6RTdmL0FNdERWWkx5anlS?=
 =?utf-8?B?bGtheXJwbTZTNWlRRW5uMXBsNzJSMEU5Ymg1bFdvNFV1MGxsR3d3aUozVW9w?=
 =?utf-8?B?cmRnVkx2VmVGMFJuMVBBaXJHM01Vb21CakhOL2RBKy85M1BseXBXNThHcm40?=
 =?utf-8?B?TVhBZFRrRDFjaFRWRHBSYXZraGFndWNmOTlWb2MrMThGR1ZNZ0lGL05lOFho?=
 =?utf-8?B?b244NkxTdGtmNVIwNy9zR1pNdlFzVXkzUU1KRUdiNmxtRGFYdGZBdVI5SlRq?=
 =?utf-8?B?SU40a1l1NWFOTlBHVlFyTktxUXhPTDNLdU5aWk1HeWR6QUJ5TENpclBSRFhV?=
 =?utf-8?B?a0FnR3JLWUVUNkFaVXZpM3NBdzh1cUF5K2FVNWc2M2I2UjNzd2hhb3BXRVR1?=
 =?utf-8?B?YWxxbldOUkI2andRRHBnUzBJQ3NOQ29IcDVsS2FBUnRXcGlOaTRiU2xHSkh4?=
 =?utf-8?B?a3J6WTQ0WHowUjFQck96eiszYy9tUFJqL3U4NHNDRnBxOHd1VEJySGlBbjdU?=
 =?utf-8?B?VWdRU09zM0lhd3hWY3YwVmtzSUV2R2JnQjNCT0xrcFRLYnVsUzFNdkdtcEJT?=
 =?utf-8?B?TjBhUTN2a3o2cFRBNUVYUVArSzkyUkpqMTNONmw3ak5rcXdxWlZ1Z0hodnhU?=
 =?utf-8?B?ekpGdFRTQmJTbHc4dHcrOUxjU0xITnIxYkd1eCtuQmkzbDMweTZLWFBaOFNX?=
 =?utf-8?B?WWFRTmlCdENtZ000UDJ5andueVNMNTIyT3V3alhVVHhsdnh2YlEvVDlRUWZM?=
 =?utf-8?B?SzZyR2E0V0ZxYlJvY0V6UVQ0MkZhV0xjSW0xM08xM0o0SHEwWXVxVFU4Y2Iz?=
 =?utf-8?B?TEZqR0dSVFNoTktHUEFzK1Ntck9qcGc4cTBGbDBKMkhvcEJEVTBxZFYydkJn?=
 =?utf-8?B?V1VJVGYwbk9vOWROQW8rWWYxS0lFc1pSUXhrQ2JnVGtVdUgrUWUyYzB4K1hl?=
 =?utf-8?B?RkZBK2pMZDlCMjdBRTlKbHJuVEl2UE5WeTNpZ3EvSWJwQ3ZEVW1RT3Aybk10?=
 =?utf-8?B?ZW4vU2lONnJ2QzFOMDhQcVlxNzVmWk4rQXJQbVFwajlHSTZHMEVnTGg5cnVM?=
 =?utf-8?B?eWZQTDk3d1YwTmh0TGZwenZtZ0pZR3lJSlV5WmdKdDNHMUg5c0ZVeGxOVzFN?=
 =?utf-8?B?NnIyWWJUMVEvSGMzblZxeVRFeFNHaVE2bUZQMXlNK2t0ZVVkWGdmaDM1ZlMv?=
 =?utf-8?B?R3QxR05mYVJETDRsNkVDV3NqaS9xQk0vcWpqckovMmJlYzFYejUvd2pEVlZI?=
 =?utf-8?B?eTdsMGs0NXh6ekJpb3g4VWNFOUJnTGpvYTY3K0lSOERLNThERXpKdjdaQkNV?=
 =?utf-8?B?WEV4cnh1bm41MmRYWjB6WHhaQzBtM1J5RElMUGlFUnJrbis5VWpTNkd6eEwv?=
 =?utf-8?B?NUt6Z0xyM2xlbXppWEROWUxBcFNkV1hjR2srT0xsZ3I4M0ZlWU5yNjV3RU9O?=
 =?utf-8?Q?QEar02p7WX8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4205.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NXZzcVFucldhSmRoNVRESXFLK1Z4ZlRTMUorRFg5OUxYWHRFUXNZWjh0T1cz?=
 =?utf-8?B?dk90UjRxZDgrUzBER2dUUXdhMysxOUdvLzVNVDFnMEZMQzBVeUpjVmF0NVov?=
 =?utf-8?B?WmVoZUY4M01IODNuNUVTVENJMDhZdXRiaDliS1hzU3FIQy9JckNKMWFIRGN1?=
 =?utf-8?B?d2gvVndNTFUxZkZrVGwrcDlxUk8yaWZjQ2lqL0Rxbmg1eXZXQkpTVkhhRUxz?=
 =?utf-8?B?ZjZZUVRtcEJ3akl4WTAwVnZyM3JOSVQrcjBVVjBERGlsOHRoczBOMUdwYnRl?=
 =?utf-8?B?ZXQvZWpCWFJQejZFUlI5NVJkVHMyRkQwQ25ZQWlyMmhEa1RTbW01OVhEUDF6?=
 =?utf-8?B?eitGL2MrSGxUcEVnbElVU3c1UDQxcU5UaWlsSStvWklSZkZIdkxHcjlVdUl0?=
 =?utf-8?B?WTZEMHVzVHY3TFJmWWZ1NThVR1Y0SnlkQXB2UzVqc1BJZUQxaTF4UXU5TmhS?=
 =?utf-8?B?UjNFenJ5VUdRQzhETkRuTWNHdDlhK1RYYkk3aGxhSzJmS1l3Zi9TRERKTkgr?=
 =?utf-8?B?RmF6MmF1VWYrb3dBcHNwSTJQVnlHRU1tMmxDamxjeUR5Q1VEbUFtNDcvSzU1?=
 =?utf-8?B?bHNOekFwRldLamQ3WGtKRkVJUnRrUU1EUzJNOHZMUjl5UHg3dllEVFdUYldN?=
 =?utf-8?B?R3BHYlBpa2dwMUVFS2JyOHprNTZMWlk0N3BZRDdMb3lXVFVXUTUydFNOVEFI?=
 =?utf-8?B?c0Q4UUU3MjdGTTBuWmo4ZHE2bGxlRjNTTkVISW14UTE4WGhYWkd5UnNrbCtl?=
 =?utf-8?B?cU5ST3hPRUwzS3M5NmRsb2pzaUJiNDV2MTU2N1VBdTZsVlVscVBURFkvZVZ5?=
 =?utf-8?B?Sng3Uk1PVzdySFNmL2czZjZYQzBiOXFOZDdYRFVlWUQ1a1oxcldXSXI4L3dn?=
 =?utf-8?B?eEdOU3l4Mjdjb04wME9ya1lCcWRtTjhlUm1FSytNMnFsV1JadWZ5ZEtjNzlP?=
 =?utf-8?B?NVlsSWxaWDI1cEp1ZFBKbDl6NnBZRnp4RW9IeUpvTjM1VC9OMDZCVkhEQ2s5?=
 =?utf-8?B?cWpzUUxUek1jelVpemxwREZPNWpwYTl5WXpQUFhwWnhQNmZKcHVRZ0RtV0Yr?=
 =?utf-8?B?NDJJY0paV01LbFJITHl4VU1yYm5uZDRZeklSYUp4Slp5Yk51c0hYZnZCeGo2?=
 =?utf-8?B?VkpWK0p2cTJtcC9WVmpLekNkQm91YUNiSWx2bWFuYW5PMWl5NVViL1JnSHV6?=
 =?utf-8?B?dEcxRWNkdUVCL1NYTnhsaFgvMCtYNk9YWG1FSEoveHhtM0Y5VUlJWnlRQnFj?=
 =?utf-8?B?V3JGNmhRdTBKUEhFSDNnK2pKZ3pWUkVjbTdPZzdEU3c3djF1YTU3NlR2OHR4?=
 =?utf-8?B?ZFlEdXlyUmZ3aElhTTBiKzlwV1I3cGdqTU5UQ2lrQmlSOVFBWlVnWk40TWlx?=
 =?utf-8?B?RUR0SEw1SUhGSUpKY1FIc0dMWCtaY3FnakVTeE90SllCTE1NeEczTXRNeFR3?=
 =?utf-8?B?MWFxUTNjTGxnaXM3RWFBMWpvY2xmcFN4VVJIY25zcnpKd09nczlaM2RvRXdI?=
 =?utf-8?B?ZVRWSHRGS1JCTkVqVC9CRjkzY1dQbmR1YkpJT3NsNzV5RWtSTW80dVRHMWZs?=
 =?utf-8?B?ZUJmQWducm5LYVBleklkckhoN2xmNzNnZ1BuNUNuUWFTK01SSlNydTBkcDRu?=
 =?utf-8?B?cElKYnFNSDZNVUxROWpaYmZ6aUlWcGxhWEM3S1RKYTBXV1BWVzdGdHNtTDJR?=
 =?utf-8?B?Z1hFRVRxK2JqdXpSYWNRM25yQVZybTM3WXVsNXRkL3A1Q01LN1ZFVVlKVjFh?=
 =?utf-8?B?WHRMSHd0TkorN1JZREpqSldNVytKNEFJZUxsRjBJQzh2MUdCOWlabHhkWVBh?=
 =?utf-8?B?a2R4azd5VklvNk9lV3ZaU2lncDdQSGxPU1BCemFNR2ttNVo3N1BHM0Vod0pt?=
 =?utf-8?B?SDFtTzlMZzkzbzNrQmM4UmtlelBmSTJ2R1NEeFF2Zzh3YjFMYlFLa21reWlu?=
 =?utf-8?B?RjR6ejl0TmRuWDhlb0owbXVtWkxZaFZtRXE0UlhKSGtuY0FpaytuRUxEL0ZD?=
 =?utf-8?B?dURIZ0hIOVlBbWVSaVBUMjdVaWI2TFhIWWRlNmdFdUpCSXN2bnpKL2EzUmk5?=
 =?utf-8?B?bFFnTjVsdjNpQy92VEJBSkhtVlp6ZWhYcTd5VXVkSkRIS0xWYU9FZjlvN0ZH?=
 =?utf-8?Q?ZwREePUGKZBxBueUI86VNTcr5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05ac95bc-14fc-4d21-5f01-08dd7bf15609
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4205.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 07:44:22.3628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XuCNqUfnJysmUCZUlhb+4gIrW1begq1nidnI07p+djkqmOOPFQUSRQdkdWdp/jLTAy3lBt14yr4pJIN5epRZ/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6246


On 4/14/25 18:18, Jonathan Cameron wrote:
> On Mon, 14 Apr 2025 16:13:18 +0100
> alejandro.lucero-palau@amd.com wrote:
>
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Type3 has some mandatory capabilities which are optional for Type2.
>>
>> In order to support same register/capability discovery code for both
>> types, avoid any assumption about what capabilities should be there, and
>> export the capabilities found for the caller doing the capabilities
>> check based on the expected ones.
>>
>> Add a function for facilitating the report of capabiities missing the
>> expected ones.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Hi Alejandro.
>
> A request if we end up with a v14 - please add notes on what changed
> in each patch. It's really handy for reviewers to tell which patches
> they need to take another look at.   More info that we get from
> absence of our own tags!


Hi Jonathan,


Yes, I'll do so.


> One minor thing inline.
>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>

I'll do that change you suggest below as there will be an v14.


Thanks!


>> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
>> index 0996e228b26a..7d94e81b2e3b 100644
>> --- a/drivers/cxl/pci.c
>> +++ b/drivers/cxl/pci.c
>> @@ -836,6 +836,8 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>>   {
>>   	struct pci_host_bridge *host_bridge = pci_find_host_bridge(pdev->bus);
>>   	struct cxl_dpa_info range_info = { 0 };
>> +	DECLARE_BITMAP(expected, CXL_MAX_CAPS);
> Trivial but can do
> 	DECLARE_BITMAP(expected, CXL_MAX_CAPS) = {};
> to avoid need for the zeroing below.
>
>> +	DECLARE_BITMAP(found, CXL_MAX_CAPS);
>>   	struct cxl_memdev_state *mds;
>>   	struct cxl_dev_state *cxlds;
>>   	struct cxl_register_map map;
>> @@ -871,7 +873,19 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>>   
>>   	cxlds->rcd = is_cxl_restricted(pdev);
>>   
>> -	rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map);
>> +	bitmap_zero(expected, CXL_MAX_CAPS);
>> +	bitmap_zero(found, CXL_MAX_CAPS);
>> +
>> +	/*
>> +	 * These are the mandatory capabilities for a Type3 device.
>> +	 * Only checking capabilities used by current Linux drivers.
>> +	 */
>> +	set_bit(CXL_DEV_CAP_HDM, expected);
>> +	set_bit(CXL_DEV_CAP_DEV_STATUS, expected);
>> +	set_bit(CXL_DEV_CAP_MAILBOX_PRIMARY, expected);
>> +	set_bit(CXL_DEV_CAP_MEMDEV, expected);
>> +
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>
>

