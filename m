Return-Path: <netdev+bounces-117105-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B3794CB51
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 09:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 973BCB224D8
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 07:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A42155301;
	Fri,  9 Aug 2024 07:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eeIedm2O"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2063.outbound.protection.outlook.com [40.107.243.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39F612E7E;
	Fri,  9 Aug 2024 07:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723188476; cv=fail; b=ejpBMetp745r4VVhtP1Z0fJnriv9iGkPdNwjiVa9kKYbhZo2kczEHhz9h9Yqa04tNQYzKqpJWgfOqXcoMlp3xs2ruks+93n3MldijKqB/lHECEcf561Qdrj/9LT0H0O6m+ExULEMrzyCPGHtYikuR69qbfVXMPgD16XRqT0kqAo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723188476; c=relaxed/simple;
	bh=6lABGtidBtTa5PAcPQLz21Jg6UxN32WM0AdOQVwAVic=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WTf/DLSo5ypLWok7M6WALxlo9FPTyzIOz73sQVbdeQEQvXPbqIyVTXvebC5S/FgPYgILJrYIsF1d0HBcTC0AwFKJz7QQ4CwLmWAL0Ot4N53C8etszxQ7akwbWgdavzH46TtjF6Qefike0J4Zy1EATUv0rBJS6SQizpKheX8001A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eeIedm2O; arc=fail smtp.client-ip=40.107.243.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mT1EO1e+CMaNSOAImlSCUky2xUGAoAYLXDVmji6fWO4yz+TfjmOJu1Yvh7WwG9ASk0hF2XkIuzqPtnGuVN272a51jOtsmMteg/wGTx4nTJCK4GrFT8b2FpPK2SqhHzrZxI2exLJYZg7oPLjv9EhmKaBGUIFzcsoTnzb7wbqo9mIEJjJtURLFwA8dm2hstuKSfC6UgQufzhKpgCzy1/jgJpKqh6wzmaogTZPkav90jyQTqwqoSa2G5et6BUI0YgvueFECQNJKKEYeeFHMFiCD7w8EU7JEF0ZFE6r9+yKSi3PaV3gS6bt3TWT3dcna+25zd3mdlTDxLaFMpHm2C/ZV2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+RisqBUbSpCju47qk5j8bUykY2nRJi0vaPTyAHDGvjQ=;
 b=zHqQOna/9wtp3GuWI2LHtBihhTqmEz4/5JEf+SvPKRPSijhHbtl2an2F47zj+2NKyNke1XOy2JDcoEraIcnYorOUq9pz0db0YIlCniPin5c6t7cfVqwxXBaiY80XUImuHtpvHuzX7HIKS74y+Ok6ihWjNOh3iaSrzpGPNPdcSOxfcuL90YMmDiDS2g7VlL/SPnNp2fJ+xJ3GB/lTEss3KpmiSUxSs72wDgDKAC/Bl1NMLRbQGnh0dNac6j48i36a5JO2th08sbsn2SSp+Au99x99IzpGDy39s8I7rpkuEM+2TS8r9y/sMEZ4NWNEQPlWxTG9vHMSNhDzpyCynvbjXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+RisqBUbSpCju47qk5j8bUykY2nRJi0vaPTyAHDGvjQ=;
 b=eeIedm2ONdYoyHQIuzvyN+eQc30BHPK7pp4MrBSN4fjP4fv/NsyW3JV/SqilBI6gKrRlZ3yZx/QVsE/1gc2mawiJgzlobpyJW2mfvLPnaU8gyClPT7cv8hpJn3An96zbGXEUnTzOwDHIbNJpTYaTM8SGD5wur8wkM8fXVCNMIFc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by PH7PR12MB8428.namprd12.prod.outlook.com (2603:10b6:510:243::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.23; Fri, 9 Aug
 2024 07:26:52 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%4]) with mapi id 15.20.7849.014; Fri, 9 Aug 2024
 07:26:50 +0000
Message-ID: <37bb4ee4-9d5f-17f4-7311-5be97ca83c34@amd.com>
Date: Fri, 9 Aug 2024 08:26:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 01/15] cxl: add type2 device basic support
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: Dave Jiang <dave.jiang@intel.com>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, dan.j.williams@intel.com,
 martin.habets@xilinx.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 richard.hughes@amd.com
References: <20240715172835.24757-1-alejandro.lucero-palau@amd.com>
 <20240715172835.24757-2-alejandro.lucero-palau@amd.com>
 <936eecad-2e98-4336-b775-d28fa1d87d76@intel.com>
 <e5a4836d-a405-5b12-62a7-e45b39fb12ad@amd.com>
 <20240804174424.00007011@Huawei.com>
Content-Language: en-US
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20240804174424.00007011@Huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0338.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18c::19) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|PH7PR12MB8428:EE_
X-MS-Office365-Filtering-Correlation-Id: eef947e2-644a-432d-fbe2-08dcb844a276
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bEdxM0hQaG9nNEt5c2FRSE5TcXRmc2JhOTRPVE1TWlExbG1sekRjMlBGajNL?=
 =?utf-8?B?ZWR0WWJQK1VRdWN2aGVzZkpjVk9xLy9pakw3eml3RW1LaGI5UUR3WUthV1VF?=
 =?utf-8?B?bDhaeER6RGtWU283ejR4ZEJIREJINXE4Y2U1elpZR29TQkNKWmtRUUsrRDVL?=
 =?utf-8?B?S1BuL0Q1cTU2RmJDbVRLVzhJM01TRzZLblRNVUMrbmdzVlZhRENyNEtaY3cw?=
 =?utf-8?B?bEVkSDJmeTJtc25yN0U0Zk8xakhOTzNlQ0haTDBRK09NemsxUHVCZVI5SGo3?=
 =?utf-8?B?T2FwVy82bjZONFIwZlNTQmZCWnRQeCtMOHBjVUJiR20xS1dKWk1FUEgrUXNN?=
 =?utf-8?B?ZWhDOUROSjdCd3RiUmJWNVRkSTNlSThQTURkcUd3Y01kemVidDJxTFlLdjZK?=
 =?utf-8?B?d2hMaU5zTGpxR25ZZDdZOUI4VUhnWmh5dTNNb3ZNT2cwWUdtaDVLQmxLd3JE?=
 =?utf-8?B?bVJDUnlCdVU5ZjlwemI5elJIMmNNSXpmVHNJNXMzS01MUnY2ZEpYd29ZMThu?=
 =?utf-8?B?UFU2MHRPaGlSNVBUQnNZWWZGRk1xa082eWNFWmpLbmlDQjgzOXJzTUlXOEts?=
 =?utf-8?B?am55ZlRjNm83M003dUJNZi9QYjBzMnpoMnl6NXpTL0NFckpuSTczTENlNTRm?=
 =?utf-8?B?bmgwc2ZHYzV5bE5CSUZ4OElOdFkwQlpwOVFkREwwMmt0RyttK2NtaXFtMUlt?=
 =?utf-8?B?c2FyZ2ZhdkZYeXIveFRTWmhhM09kUXB1VTlGODF2NExlcUkwT253bE9heWxJ?=
 =?utf-8?B?V09YVFdTWXBBTVZaNnI2SWNhaGxuT3pHMTk3MC8ydFpxcWVvWFRwb0RoRzlv?=
 =?utf-8?B?Ry9VcXJnZ1RjbFNPN1NoWlkwazR6Nzc0REc1WkgvT1BDQVR6bVp5VVFKOFpM?=
 =?utf-8?B?TzFGMGFIeTc1bVVJVUl6ZlNxbXJLa095SlVDRWtoaFdCNDQ5eGNENnBkOVM1?=
 =?utf-8?B?akg3WC8rVzJTVjM5OEZFbDBKVjUvTUlGYno5NXBWYnhWYjZvWFpIb2o5TU8z?=
 =?utf-8?B?azF5aFVZV3JZMEFDZlhoQytyTEdNcU5ScXlDV3o2d2FPNG1JWkg3N2ZBdys2?=
 =?utf-8?B?TnhTZ0phdG5FZGZqT0hXN2xQUjRJblliRW1IY2t6VHBXNUl6dU9mTmtYMXpD?=
 =?utf-8?B?blcrNXNKNk9CcU8yRTU4a0N1K2hJbXVHNitSYUQ0MVQwMWU1NVFJbU53ZTdN?=
 =?utf-8?B?dFk4VW10Nm9sbzJIbU1IWWpoWjlNUmh6QUNrSVRPUTlGTlJ5d3JVaEFYUkVl?=
 =?utf-8?B?dm9uL3NkMTBaNElJZS8rOUNITGwxdmg3b00yZXpEU0kwMlVyVGs1cFhOVFdu?=
 =?utf-8?B?OUIvazgvaTBvVEhtb3AxYzk1ekRGUU9sZWc5elBJZWx3NWlDNnQrM2NrbWVa?=
 =?utf-8?B?dzNVZHFTbHF1eHZKS2tTdk1xbFgvTmRrU01RWHUzY2ZSeXdmTWF4dDBTa2pm?=
 =?utf-8?B?d0tXcjM1NUhxOE1Ebi8vMHZVSGhhcEYzMTUyNUJBeVJSWjE3UTFmRlZnTFFK?=
 =?utf-8?B?QWFZeHZ3WHhGQTFWL3A4NjJBRUJYdGZQNVpxSDYwNWJtNWFiNnNTSnhZYlNC?=
 =?utf-8?B?OVlmVGdSTjhUUlJqYUJLRHIwMVpFN3lleVo1ZW5wT3ZqZWE2OGc4SytrU0wz?=
 =?utf-8?B?L2hpZVFBWWpJTkFOQ3JlZVlZN05ZSzNqVFp3QzNUWU5hYnZtS3EvUSttREpW?=
 =?utf-8?B?WjNWYzUzTVdXWmJadW1wNjAzUHFRWEw1djQ2QnpVcnYvTHFpbVBGVHBxZFp5?=
 =?utf-8?B?RjBPSXV1Mm15MUFKRy9HYkpKZFBJVnB5TjJMVE9rWTE0TTF3c2FQaWl6bFJT?=
 =?utf-8?B?UGw5aHdPQkx0UjQ2aHVYUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S2l6dmdnR1FwdGlUUDRWUlRiN2htUy9Ic1VZOXBtUnZrUmN4bHNZZWJXNjVa?=
 =?utf-8?B?dTdsZkVCOUIxR0FoQTk0UGo4cVNSOUdjRi9IQjRkbk9uNmZCVVlpdkFxamQ1?=
 =?utf-8?B?bDZWMjJjUGdidFBoNGRyUXJxMk8weVpFQko2NGxycUFjelJNUk5MTG9LK3Ew?=
 =?utf-8?B?cExpVjVRZUp2VS90NXduWElNMEVzU3lkS09xMndVZ2twanpwMjFMbVBBSkJp?=
 =?utf-8?B?T1lJN2xhLzRKZjgzb2dUMjgraW5tRCszZTFsdVBBd3pOZldBVG4rQ1F2RTho?=
 =?utf-8?B?am5mSnVmVWV3ZjZUdkRtUEFiN3ZTZlgzRDJIWHFWWGxpZU15N1JUVnc5NzBi?=
 =?utf-8?B?S096SHRyS3RYQzVsNDZsUkpwUS9Pb2owUTNod3VjVVZHZHVMVWhyeWZjWU50?=
 =?utf-8?B?aEw2UXRYWW5ES1JNYUlLM3cwN3QvaVc3SXhGblZNN0RVdnFzcmd1Rm5TWnpl?=
 =?utf-8?B?L05YOHNiRk5kc3NvZEFEaThNdnhhQjA1Rld2dWFXb2hYem02WnJicUJTTk56?=
 =?utf-8?B?S3czZ1h1MWhjeFNvTUc5TVk4cWRwSmRVYUlMRktMenJrc1VOVFhxV2JoMFho?=
 =?utf-8?B?aDRxTktjNmNhZW1oTGN4SjJGOGdwNXpBY2lxR2hEaFdLZUwxZTNlV1d2Q3hp?=
 =?utf-8?B?dkNDL3BXbndXYng2T1N4cDg5NWkrOHIxQTFNQXozdnluTUtod1QrSWhyMkVM?=
 =?utf-8?B?ZDdSZVFPd2tEQVdkMm9kYjhUUGZOd0loWUc2YWFXb200R3NMR1QvVExKY294?=
 =?utf-8?B?ektnRzFIcDdUWGtxc1J4UUpBSitERGVjZkFqaHR2bzVyL3gzTnBjSmNMWVkx?=
 =?utf-8?B?cG1GRzVyQnV6R3psZlFqcTVKVnFzSTl5SjhWNVNwWldqTklyaFYwUVFCdUYr?=
 =?utf-8?B?MWppTXY1a2ZOZE04Qko1MG5mWTh0Rld0cS9LMUM3UGFCemk4NS9BSS8zUWVS?=
 =?utf-8?B?NUcyQ0RPVW1zLzI5dkpyNExnSXVCOExuOTlSa1ZDbWs3OGc4c0UzT1Iyd1RQ?=
 =?utf-8?B?cWY3dkt0YXVLVmFpTUYyNm4vOFNJQ2J6MEpjVEYwZkZBcVM1UTRxak5uYldn?=
 =?utf-8?B?czVUKzZBQTc3L3pqa1RZdk1vdytlc2txcWNMMkJwQTBweGRmNXJUUFJTSFBI?=
 =?utf-8?B?YkZOZXc1eUFCaUNVWGVWZ01JOGljMjhvVDZVMUhPRTQxTFc2WTJaUkd6ZHoz?=
 =?utf-8?B?R2V2V3prUnFWYmRTTFRWcXJwQkpXSXBIV1BKTm5VOHZ5UGNYUXgrVmFGVWFO?=
 =?utf-8?B?QVVEWjdad3JiMGJXODdIRHIwRHY2SG9xbGFHcVJKUFNZT0IvUzNuTHI3MnRB?=
 =?utf-8?B?NlNSZmlnOVQ1aFo1SElLUklibmtpdEJMS2xweU5TMEUxYlBBOVVsNjFGUE1R?=
 =?utf-8?B?ZWdFei9KL01CeWR5VlpnNVZGaVZ1VEZoc0wvaWtDb3ZhekRuQisxUkd5Umpj?=
 =?utf-8?B?SG9mK09Qa0FXK3ZZaXhWMjUyMFRjWm5YOWFzTVdwUTU3QkxLL1MwS21jMVJt?=
 =?utf-8?B?SGV0L0dZRVR4MnFBdnQveVNyaVBMLzVPSWhtVmd1ZUJWWmxEMDNxV1B6WkZx?=
 =?utf-8?B?ZmNtQVNUYnlxaUE0ZU5WRzNPS1VISFpoZUdzTC80RDRET2NVZmdVRlErb0Js?=
 =?utf-8?B?WDA1QzR5Zk5BS0tZUlpaUFdta09PdERCRVBSN2dwVEJoM0FGaUs5WFdaSHpw?=
 =?utf-8?B?ZHpXWDE5UzFMcFNOa2poTHdKVG9JZkR4cXBvbTVsS3psVzdsQmlLaHdzOVRS?=
 =?utf-8?B?RmNjK1BpVVl1M0Zibjk5Wkw3eFhJOGp2L05uTFpvbytYdXlxWjg0MmpuY28w?=
 =?utf-8?B?SWc3Q0dnRWJCWkE4UVo4aFZKQis2QzJ6cmJ5cUMrWHFtZWVUNU91ZW5halp0?=
 =?utf-8?B?MlA2SVZJMi9mNXA1MVVvUHZKYTdyZWxUZ3kvSkwxaUw5Q2xVOC9yM3hzd21W?=
 =?utf-8?B?L0NQNXkzbG4weVM1MU51NkJFYStrUDU2TlQ2QmNJczRQeFhYaS93Z00zNThR?=
 =?utf-8?B?U1VHbjJNRENEOURmRHpWKzduTFp0Vkw0Q2JVM2Z6QlZGaUlGOERlY1BHR00v?=
 =?utf-8?B?VW16Tkx6dS81STc5bEpMRFBWaWo1cHZ4ODM2ZzQ3MXZHQ2dCNnN1Ni9WVnBO?=
 =?utf-8?Q?aeTkO1m30lg9S/hpzLw5NmYx8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eef947e2-644a-432d-fbe2-08dcb844a276
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 07:26:50.5124
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xxNskDe7lkS93T3AMWWnchKpIhXUxePE50omqs9o540KikMIj6sahJgPmfN7RCJUCZmwwOmaUwiQ/MmOhmdafA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8428


On 8/4/24 17:44, Jonathan Cameron wrote:
>>>> diff --git a/include/linux/cxl_accel_mem.h b/include/linux/cxl_accel_mem.h
>>>> new file mode 100644
>>>> index 000000000000..daf46d41f59c
>>>> --- /dev/null
>>>> +++ b/include/linux/cxl_accel_mem.h
>>>> @@ -0,0 +1,22 @@
>>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>>> +/* Copyright(c) 2024 Advanced Micro Devices, Inc. */
>>>> +
>>>> +#include <linux/cdev.h>
>>> Don't think this header is needed?
>>>   
>>>> +
>>>> +#ifndef __CXL_ACCEL_MEM_H
>>>> +#define __CXL_ACCEL_MEM_H
>>>> +
>>>> +enum accel_resource{
>>>> +	CXL_ACCEL_RES_DPA,
>>>> +	CXL_ACCEL_RES_RAM,
>>>> +	CXL_ACCEL_RES_PMEM,
>>>> +};
>>>> +
>>>> +typedef struct cxl_dev_state cxl_accel_state;
>>> Please use 'struct cxl_dev_state' directly. There's no good reason to hide the type.
>>
>> That is what I think I was told to do although not explicitly. There
>> were concerns in the RFC about accel drivers too loose for doing things
>> regarding CXL and somehow CXL core should keep control as much as
>> possible.  I was even thought I was being asked to implement auxbus with
>> the CXL part of an accel as an auxiliar device which should be bound to
>> a CXL core driver. Then Jonathan Cameron the only one explicitly giving
>> the possibility of the opaque approach and disadvising the auxbus idea.
> I wasn't thinking a typedef to hide it.
> More making all state accesses that are needed through accessor functions so
> that from the 'internals' become opaque to the accelerator code and
> we can radically change how things are structured internally with
> no impact to the (hopefully large number of) CXL accelerator drivers.
>
> So here, I'd just expect a
> struct cxl_device_state; forwards declaration.
>
> Or potentially one to a a different structure after refactors etc.


OK. It makes sense. I thought the concern was about external driver 
modules using the internal cxl structs.

This is the main point in this second patchset version, so if none else 
says the opposite during the next days, I will take it as the right move 
forward and send a new version 3 soon.

Thank you


>>
>> Maybe I need an explicit action here.
> J

