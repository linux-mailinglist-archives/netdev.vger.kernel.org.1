Return-Path: <netdev+bounces-186364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E4B6A9EA32
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 10:01:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBB9A17447C
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 08:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7383A241670;
	Mon, 28 Apr 2025 08:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="n2/tiYds"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2088.outbound.protection.outlook.com [40.107.96.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942B623C8B3;
	Mon, 28 Apr 2025 08:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745827265; cv=fail; b=qehvgapuuypzSDBIvVN3Bs6zren9UnRqCG9ZpY+c+xknBQsrCLU2TgMadpr+8ejuN2R1xBu13IoqHv/m/4dj7+iniWJivxJuklEwxYJLBW74bH0v6+iTsIZYIn8K6ro3pzYGZdCm2ocepu3DlpbcL1fsXFZszRdKEK7wtjRuVbI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745827265; c=relaxed/simple;
	bh=uu5wRU8y4fcgrAlOSo1EGsRyOBoNTidcRIlSDL9xfkM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OmYh1IyBaXRDBE9Qyi10Tt0GPVzq3CJAN6vfqRMUkWk1s1iW8UNaMOcdKKss7O7lTCHJjxxfhrb9uVtEMN5Xm3NMqgOvY8FpsrowVEJlMqoFbfjhoNNjrkiBKTRiw7IXMIv5Bxqfmb7cfPe9fbIFtqUMzPBVqZgE4yS+AHgiokM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=n2/tiYds; arc=fail smtp.client-ip=40.107.96.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cWmNLuXR/BhotG4MErTgAlqOm7O9+dw4rcLYzZYPz7Xl72LEemOfMRnutfsebUUD32cG192/H272RHjzhVItXOGcLb+d1lm8tVgGwShUJBaqV68T8AhUsBa6QZDwESQYLZhP1TqKXOTU+/Yykvkb7bm4FItfU3gDDyFIB2lwS391qnf5MjSIHth49xwataQGmRdhKL5VEvmbfYKBp8E4beEjA/ccnkJ7x3N0aTP0Jn1ccTV0owmH5Q0joocAl59f4sjLbOE3RM+0wXqwGfyt3e6BlxoWAMU120WIW0UsqwX/zIDIRFFEN/lrhFJsxgBI4Lk8qkYuVaypDso4Q1sqPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xskkG/aZ2xA5RyU9HCMjbQ8ox5RQipZRZuHkhnxavjk=;
 b=gATQ2LUw9VeVNksGl43dcDqulGjKLaIePvLvekzf4jYYkJ7nEC2FooLI8W/M8dvbcBEYIf0NM2Y2pnfVL5FIpHXluxr6uVOr6fCOg3WQViPEvoCc+44DNcz1QFZxajHSHFQ6C/2jcOfzK2U9rHn4OprNchOTmiFm2QAZi4rPgo/rqLlVuUpIpnLn47sKhBIIWxnFgPqEN1Nl4yM3zv+UX6pw568dh4fePK9AwHtsENNK3PCVr8IeoupyLlIcRirK3T8ioPOe7LPuBxqjj5ctrH6QPWKpVcfXr1QFiq/iszMgEALpDB5QaldriAFS53NzC0NMldmFdoz8+GqUW0SBKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xskkG/aZ2xA5RyU9HCMjbQ8ox5RQipZRZuHkhnxavjk=;
 b=n2/tiYdsr9KtiFigX0wdq5Q9zwd4J+QQ9NRkS4Rsmh+/qwmSBgyb5EdJ8NsavpzWewDgbwNuuELwIlKXJyByae4MM26ZFw/YOj28A3ai8tFgO1WP/ol2s8vvm8+CN2JmDaAn9JmomKvKV8xzAL8dWm85DrqfCJ2ro/VEkBblXqg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by IA1PR12MB6434.namprd12.prod.outlook.com (2603:10b6:208:3ae::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.29; Mon, 28 Apr
 2025 08:00:57 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%6]) with mapi id 15.20.8678.028; Mon, 28 Apr 2025
 08:00:57 +0000
Message-ID: <683ab376-62f8-449b-8db3-5179854d7cd7@amd.com>
Date: Mon, 28 Apr 2025 09:00:51 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 11/22] cxl: define a driver interface for HPA free
 space enumeration
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
References: <20250417212926.1343268-1-alejandro.lucero-palau@amd.com>
 <20250417212926.1343268-12-alejandro.lucero-palau@amd.com>
 <20250422172211.00004d10@huawei.com>
Content-Language: en-US
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20250422172211.00004d10@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU7P195CA0028.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:10:54d::28) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|IA1PR12MB6434:EE_
X-MS-Office365-Filtering-Correlation-Id: cca72c53-5a64-499c-95f9-08dd862acee3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QmowYS8yY2hoVVNZU2xLSnl2a2U4NGMyQUVLUXVpSFI3aW5kZmdCb0phc25B?=
 =?utf-8?B?cVJFQ2dYRkFPNDFGdUhFMGFzS2FYNGNVQlhHZTBicHJEcnRaSGdKV3RjVnZO?=
 =?utf-8?B?R2FDUzlmTUJVMHJjSXRraTZaSUdTRndrY2pNWHNQOUFCSlQxb2FyZWRWSjJj?=
 =?utf-8?B?ZDNmS3NHbW15MGNmMmxOTmJ3cnlpb00yYllsWFRTTm1KRXAvc2NlVjR3WDdD?=
 =?utf-8?B?MnZLZHJnazFCSkFFeFlYemdQL2ZqV3FUVDdXU2VVcFdxWnJVd0RiQXFlZG04?=
 =?utf-8?B?Y0ZjcE10bEV6bC91RUpOY3ZwTG9BckJtbko3a0R6a1pGd09tNWg5bythdTNt?=
 =?utf-8?B?TmZHY09nUHBjWXBTT0RCTzRZQVlHWTNmdGpacmM4aXYrTTcxVktBdDJtSzdt?=
 =?utf-8?B?ZzRidlpDb3haVWpVcVBsUjhnOGk0NVNYelhQQzByaEg1L0xMTXJwTGFvMU94?=
 =?utf-8?B?S2tLVlRhSFE0K3RENGpmdGZIQ3dhQWpWZXhWazZlUGJaZWRoRzR2MnBpMlc5?=
 =?utf-8?B?eGFJTGpQN3A1MkdGc2NLWG1kS200anJ3Y0tDdXYzejFDcjY5TXJWY0NOUGgr?=
 =?utf-8?B?d25rN3RheHo1V0k2MGhOSDByWXVld1JmMG9KNWdzTVJ0T0pYd2JKbUdzZ1BC?=
 =?utf-8?B?MGJwTDV6SlVUbStIRWpzeXlrR0FHSDlMTkgyaWh4dGhzWGNybkZ4RHhTYzJu?=
 =?utf-8?B?OUlvTHZ2djFsV3VIb01tRzI3ZTZ5ME1LSDlVUEQ4UzVmcnJHWnNCbHUwMzNJ?=
 =?utf-8?B?SCtHa0hBVTdQUEthVkZoM3orRFRIT1hPUWFFMjNLM2hCVS9acVYvSzBKV1Zr?=
 =?utf-8?B?bHlod09XaDRkU3puTFhNc2pqeU15cTVuNkoycGU2VWtyWGI4UW5nNkFkbUxx?=
 =?utf-8?B?bGVMTUFJTkQvbkJVZTdnV0FYMzFFTVoyZFd6alB3ejJZYng1b3JiV3ZkUUFM?=
 =?utf-8?B?aWZtL2czM1M1NlFKTmw0S1RRdWFpVEEyajRzMjhqSHdEWDlJZ2c3WFBtZWt6?=
 =?utf-8?B?ZDdTRTR6NWRoSVR3SVFNeXlxK3FKbTgyL05sb1ptaFNQbHU2WTY0QS90S1hr?=
 =?utf-8?B?ek81aC94Si9Cc1gxdmI1cmdRVzNPenBDZzNDZTlaOHJtYkN6Ykw4aE5CTy9n?=
 =?utf-8?B?elVzKzQ3bnVLMGE1UUxBWXdvSTQwb1B3cVNFbDBlNHdwbktsVG1VZTduL2dN?=
 =?utf-8?B?d09TN2d4SFhJWWQyMkIrci9PbWFwSnNaL2JVVGR0ek1rTFBmZUIvclNhaUFM?=
 =?utf-8?B?N1NDbE00L0drK0hRUDJIWHpTdW0vVnFsVEVVRTAwZmVmRnNHL2pUQWxEVGs0?=
 =?utf-8?B?Y1JwUmN4OWk1cTlPbjVyOUtSWldUaWsyRFdlUklpbGd1VCt5VlJoUHZSa1NU?=
 =?utf-8?B?a1VRdkhFeWI1aXN3cmppdTUxTytkWDh5SkRyTldLTVNSVmdhYVJvVnpmWERY?=
 =?utf-8?B?d0RwRVFHc1A1YndLT0YrVWt6Z0xYeUUxVlozTFA5NGswZUw0RXg3MFRYQXQ5?=
 =?utf-8?B?U0RkMitEWDUyZ3RmMFUvMzBnNGhjN2dLdzlpSlZtSkR2QTFYMVc5RWNGMitE?=
 =?utf-8?B?MzQ3dHBhbkdSamtEQ0NHVjBLam1PTWxGc2VDelY2RFdxU1VrRWpTS0Zka2pZ?=
 =?utf-8?B?dW05eHhrZHdTOUlyM0c5dHlFU3hrajB4aG5CRDNsVUlWWWVQZ1lvWUZSZjlq?=
 =?utf-8?B?c3lqcmJnaC9GNCs1dVZFc1ErWm5HQlc1eklRR09sS2tKNkhxN2ZlbW1wTTRv?=
 =?utf-8?B?YVlud2h2T0VGL0lVRk9HdnFEQ0NoUC8xNWE5THNhMzNHZ1dZMmxFUHZWZ3Ro?=
 =?utf-8?B?OXJVcE9tMERyeUdMTlM0TGRRM0txUE5zMEZkUGVCdjNnZ0RveFU3RU5QZnVB?=
 =?utf-8?B?UTBpeEsxc0Z6VVZRSDdVQkEyWTEyYUpWdlM5M01yMzIrYjFPYy9VQ3dMV2Iw?=
 =?utf-8?Q?bWx4n7r9CVc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a3drZTRDUERaUkpRNDlMeVY4czNjVk9LcUh1ZFdXUG1jdE9KcVRnNWg2cE8y?=
 =?utf-8?B?MHByYko4c0s4YzBPM2hMdVNlWmZVZmZncjhFTVJOaHdhTjlHVktwSlhGUy9o?=
 =?utf-8?B?ZE44Vis1aW5Xbnd4QjNkMnFyQ3NqVm5yeE44WWFNeVVhVmdmTDJ0QngvNzVw?=
 =?utf-8?B?UEFtRll4NDVTNVVLSmxzeTV0TlIxNnBGa0lrSnV5bTIvbmtDWExFdVlwZGM2?=
 =?utf-8?B?eno1UEN4Zm9Hb1lPbUVnaWpTUGJQZ3BTaFh5eUJib25tQWROUXhlamhTVXpM?=
 =?utf-8?B?WHVpRUV4OGNWRzVQT2hiWFE4SW85OElyQ3psa1ArQ256NDNSb1JTYnVLMGdN?=
 =?utf-8?B?YklaSFFqcFVtQnBVeTRxMEY1NkZlQmkvK1cvaE1UYTVJYXdFUVJteTU0QUp1?=
 =?utf-8?B?bXBQRjg1ZnRsSHI5emVkN1VyQlNpeUQ3TUtybjU1ZVRaS3JaeDRidzNac2Jm?=
 =?utf-8?B?NFcyQXIvZk42S005eXVsR2NsSER2RTZ1Y01rVjloR3J6Tkc1REhTMngrTW5m?=
 =?utf-8?B?aFVoRithKzZjUWV3cjkvMnVJblA1TjlNcXVZam96alNkRU1WeFNwQmo3dE5r?=
 =?utf-8?B?emR4TElJQjFTbTVxbUJTMmFyT3B0TTlvZ0NtZ1hJM3FPYjYrR3RTa1dVejVW?=
 =?utf-8?B?TCtXVU1yZFBPc1pxM09wTjJuUW8vNFdWd0xQaFlyQkZHbm5Sb3U4MXNKSW4z?=
 =?utf-8?B?ZkRmZ3NVajZMaUNkb2JrR1ozWnk5anZUTE41bjVlRFNGYWhPRlFRd1VYd2Fh?=
 =?utf-8?B?ZHZ6V0VHbGxJYTExTlk2c0t5UkdQQXduR0pJb0paSzZLQXVPOWZqRzl1M2V5?=
 =?utf-8?B?M0N0Nk9BaFBTeGpXMjMxSHM0SUkyQVFGbEdjbFV5STA4SExkUXpzSXBTSWk3?=
 =?utf-8?B?TjcwVWlvb0dPSFFnUHJHZGZMdFJtR2llT2owNUNjT1lsRFMwdE5pSlBLNitn?=
 =?utf-8?B?UVhYdUZWMjIzbjlmcXcraDQ1MDNvRmxPSVFCWUpET0xBWVN4dWg1Ui8zcDgr?=
 =?utf-8?B?enZFUTNKOGprdEhWS0xjTDdDeXZ5R0JTUzJCUU1lLzFRdUEyRm5CU09qMTRF?=
 =?utf-8?B?OGlJR1ZBeEU4dUxocXpTOSs1VVV6OUxPeGpUUWdKdUE4WERHMnNDMzVGbjlv?=
 =?utf-8?B?cVhPZFpBL2dHeU52c1o2NTU1c2VTLzJUTUNxZGt6WjEzZXEwTUxCc294aXNn?=
 =?utf-8?B?dmU5TjF1ZzBwT0xKeXZHUlJpcUZ1cDFtNXV6K1hBanc1NEMvQWhvZGFDSFFa?=
 =?utf-8?B?bEIvN2NsWVZoaFZxUm54YmQwLytKSFJlWnljUnp3SjdRNHNNeTlWU3FCWkxR?=
 =?utf-8?B?aEM3K21VZ1ZjcEJocVVzYjdDSGNVbnpCckZkUDNkOWZGMmw2eUM2RGRkSVJm?=
 =?utf-8?B?T0xnL2xUQkF4bTRGODErY3NHOHdVSXU1dmk5UVRTb1FpOHdkeWZMbHp4S0s4?=
 =?utf-8?B?dVY1WUZCWGxHaWphRXVHbGtzaEQzQU90VEF6cnpINGs0Y2pEdVI5UEdCNnhR?=
 =?utf-8?B?ampiME1SS2luQUJRR2N0eGd4N0dldXVnTm9HSi9VOG1Ua3BUVXhOUXFobDBz?=
 =?utf-8?B?ZnVIZXdISktUWExJbFVaNjh2cUVSdnJyRVoyUHJBSitEWTQ5MUI3Z3lKdndO?=
 =?utf-8?B?RlIvSC9ITUNBeVViSVV3cmtLTHNJNHBJRUo4Qmo1VGlvcGlRSzY5QWNBMTZv?=
 =?utf-8?B?eERIWjVvWHlZcmNhRmhGUytGdE11YkJNOWdBVldNd0tzRUYvZ2VUbmtCck0v?=
 =?utf-8?B?ZGRmWHAxZVg4VnY1QXNTQjZDbGdtQXNFRFdRSWxXa0YrOU5pYXh0cTZxUTVE?=
 =?utf-8?B?eXRHa0NqdE1uN1FVanUrWGpGWmZHall1azdGQktFTTBCV3daK1JmcXBITnNN?=
 =?utf-8?B?RnBuNWhQbkdRLy9uVUJxR3h5dWQyZXVvV004ejNrWmhoVEc0cXIyK0Mzak5a?=
 =?utf-8?B?ZUhGdzlDQ0Z1TUFFSGpRRjlWYVBrR2R4OWhIV3p5RDNFUDkzZGQ2d0NVWG4w?=
 =?utf-8?B?NGRHWVdyOU5kM01Hd2FRN09QK1FVcjNmc3ZsZWdxZTV4NlVRWTNCSWhWbmQx?=
 =?utf-8?B?SDh3cVFNcUkvNHJNTDByRklMWnpHK3E1b1VtaHd1cXNBdFYrUy83WlY5dkZF?=
 =?utf-8?Q?vSR8Plis/QL4L0DM6qLLFk6ZD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cca72c53-5a64-499c-95f9-08dd862acee3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 08:00:57.6719
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oV3C7aURpsuHgTyTmFKWWqsRhxVIGivjKzO1bp2eNGTLZe4LN4NiYKvx5XLfwT8ORBl9fUOEkpXGs8DPIJoYAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6434


On 4/22/25 17:22, Jonathan Cameron wrote:
> On Thu, 17 Apr 2025 22:29:14 +0100
> <alejandro.lucero-palau@amd.com> wrote:
>
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
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> +	/*
>> +	 * None flags are declared as bitmaps but for the sake of better code
>> +	 * used here as such, restricting the bitmap size to those bits used by
>> +	 * any Type2 device driver requester.
> I'd just drop the comment as it's more confusing than helpful.
>
> If you really want something then perhaps.
>
> 	* Flags are single unsigned longs. As CXL_DECODER_F_MAX is less than
> 	* 32 bits the bitmap functions may be used.


As I said in v13, I just want to make sure none reading this code, and 
realizing those flags are not defined as bitmaps, being confused.


I can use your suggestion. I'll wait for more reviews for a potential 
v15 ... I guess/hope I have not been the only one off this last week ...


Thanks


>> +	 */
>> +	if (!bitmap_subset(&ctx->flags, &cxld->flags, CXL_DECODER_F_MAX)) {
>> +		dev_dbg(dev, "flags not matching: %08lx vs %08lx\n",
>> +			cxld->flags, ctx->flags);
>> +		return 0;
>> +	}
>

