Return-Path: <netdev+bounces-154914-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29028A004E5
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 08:22:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DED13A3B34
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 07:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094071C9B97;
	Fri,  3 Jan 2025 07:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HdeWh9Ip"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2058.outbound.protection.outlook.com [40.107.93.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5481C7B62;
	Fri,  3 Jan 2025 07:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735888920; cv=fail; b=qpoD4bTOtDiFDFPZ5W04IsWaMsyr6Jyb//FGKYx7AGIQ85gddMpVxGPtAboALHiuW8oq/n0K0QfMGdmYULJdgYanh6hAxPTk2TwVNF23Sk0ZJW1m5i4y4JEp8dYcrKEyXQH/COOhQz+sZYtES0Niwet+mSfnATLjXpy/62W2WJ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735888920; c=relaxed/simple;
	bh=sKzETaJD2pPEjD3r5hBAEaeV7tOeFf3ENa96z4NuAd0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=c+sArpfURRVmLViVRsTZyVitRc5+swXJfH3UK69ZqoG+WBaPuqF2ClWZXR9bZTmZVrMlOd2lvDd1iYpzpwL/ZX4lE6ITmVbIX8YOXOjXaFLjxMI5X1aQupSz3JyjzxEXqNKD2LN9XA0O6bQcZzrvodLmTC/hlRFQcsxnhQXYX2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HdeWh9Ip; arc=fail smtp.client-ip=40.107.93.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kqRVXRGUFuVFrBB4guZ6eD12U/mYV7O1sPxOXcavTE9kUhgc8yUWs/pdyHAOLF94MkRaqbvuMeiME/YDJ0hgiAHkgNdr9jdZgXT/AFpHiE40UZLMVK7Dr2HTgc14lxz4eftDhWK4nRPIuDbwRg464HyNUtf1Vqi+MyF+byVH2t5gUw8uRB1JR6jo/zrE9ZLezTPgHV7zUPMS3bDGt8jLDbqNbF4nWIiwVlWHJtSfmRdO/AzsIQqDdaIOfjN5YXk8aAfXDJ5BPA9UU7WXY6TtJJ1EQicJdLsIy/aUzNinAHgwnjNmfMNd6STWk6xiGJRVpUEk5pOZxd6+Dylkmipbbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sKzETaJD2pPEjD3r5hBAEaeV7tOeFf3ENa96z4NuAd0=;
 b=yQYVmIClUFNFF16b5OEaEeudOldUzZRYorPUdahbIMZYiCy++vKunjTQEDtwkRXeF0X6axFlosFrw+2RSL1i8368opm2Bu5xlXqXkPeU8cVt/IiqK+pWP29fOaqGihIv+iNZ8qoxAjzdXtaie7kWhk/2zTuI6T1ZhS95hKVeXFOT5TNZS/l86ViS/QO5ZvWNWaLRg80zgzOXkm4H+yD+ZWV3gzMUz1eErOd4oI7gRb9kjX2h0cSsQEwRQVB9be9F/UtW9s1/X3QK2YrgCGQpwKbAKhKGxmwoNYo4pvG94BOgo/UCk9iutK6KLzRrkAATSyMukZdUzIp8DUfvAVHXug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sKzETaJD2pPEjD3r5hBAEaeV7tOeFf3ENa96z4NuAd0=;
 b=HdeWh9Ip1btOxI/34z8P0GBIzBTBcwYZ5AEjXhEs5aspGlrVmQyKim7ZrE6QFv8aD4dkHCwNtd+jWVD0nK2C6bPcOz6p4+cd1pclmeWZU6VWS/u4vQ5AK/+gv+f5VaWt8fOpHdsdAHwFvBYhyluxXK4lQjL4RvnOAZyrqL90rzI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by MN2PR12MB4333.namprd12.prod.outlook.com (2603:10b6:208:1d3::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.14; Fri, 3 Jan
 2025 07:21:53 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%6]) with mapi id 15.20.8314.013; Fri, 3 Jan 2025
 07:21:53 +0000
Message-ID: <2b5054e6-e071-1776-f283-b79f96790df1@amd.com>
Date: Fri, 3 Jan 2025 07:21:48 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v9 02/27] sfc: add cxl support using new CXL API
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
References: <20241230214445.27602-1-alejandro.lucero-palau@amd.com>
 <20241230214445.27602-3-alejandro.lucero-palau@amd.com>
 <20250102143234.000045e6@huawei.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20250102143234.000045e6@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CWLP265CA0268.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:401:5c::16) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|MN2PR12MB4333:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e41acd3-505d-4ad8-7c7f-08dd2bc74c16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MVd0ZlZhTW1xRWNyOHBDaTFCZ1FLWU5qRWcwaGg2TmFzN1ZETlpCVVB3STcx?=
 =?utf-8?B?U011MThNYXorY1BBejcwN2ljS1FGWGpRdCtBYUUzamFvL1ZWMjhidnJSSTFo?=
 =?utf-8?B?Y2xyaUx2bDI1MldtOWZDN3ZKU1dneHVUbUVSaFRrRWppRFpOcitDU25EQjZl?=
 =?utf-8?B?cE1aSTc2bll3RUF2eUhOUzJTMEMraG9Gc0F1dGg2dFlKUlI3bWdKQmJBc3RG?=
 =?utf-8?B?SFh1QU9JQWxuSHo4cDhCS3J5bThnSW9meGNsbWNGZXpwTzNmUTA5UmQwV1Fl?=
 =?utf-8?B?OFZBMFlwdTJqT3R0aURaY0JYdjJ3eHo4R0ZBWE1qN0FWa3pxNmp1dG5DdldJ?=
 =?utf-8?B?T1IrdTkwcFRpS21ScnNIN2pKbUtleHZJRFhobi9YUEtZSXQ2TXFBL25JajA4?=
 =?utf-8?B?V2s1N3dmMHUyWHc1QzFsdVAvSVhWMEJGNys0cEc2cmlQOVNDcFJuRmdqM3hN?=
 =?utf-8?B?bWEwZ2NWamk0TFZhcmpML2RJdXdJcHlCYWYvOG14a1R5SDQwYzNScjVGNEtr?=
 =?utf-8?B?M1A0NDkzMnVzdHk1ZHB4aUdXcTdObExoQis0MEdENkxDRUhwYm1wQks0ZUx0?=
 =?utf-8?B?UHBLWHFJOXU2YnJJUFIvVEJ0M3dacUZBR2FhcUZGZHJKeUFuY3dTVi9CV1F6?=
 =?utf-8?B?Z3JLdjh2OHlJRVB0UVpFdmJQYzNRcE5xb2xmMnJjc3VqcXgvdjgxUXJTUDYy?=
 =?utf-8?B?eGtiTklTUlEySXN3bTVheXhlcENYOVRLTXVqMjh0UXhzUy81blh2RTU4Q2tl?=
 =?utf-8?B?bElwZGlHMjVvSUdsc3h1aGZndFhGb1pROXpseUpzSHJHbWswT0VSclRTQnVN?=
 =?utf-8?B?SWhIdURTQTROdlVBUjY4ZGgyNmFhelRUbDFKc0ZZdFRBQ2kxbkk1WnAyeFhQ?=
 =?utf-8?B?SmZSZlA4VnhKM3AwTW94bi9IbE5zVHJaaklGQ1ZYWU5LRlg2bTJ1eHlpMC9u?=
 =?utf-8?B?TW1PSmNjUjFCdUt4NDNTTXJyZmpTK2ZONWo1Ky90TDVwaUpnZEFXbnZna21T?=
 =?utf-8?B?azUrVVVwVmRVOGwzamwzaDA1SjJpV29Qak9Gb1lKZUpKY1BjQUhTeGEwL1Vz?=
 =?utf-8?B?ZmU2OS9PUGtveUNlNnpPa0N3QWh3YXB3YitSS1VxV1ZsMnlYd0tpRk0zd1dj?=
 =?utf-8?B?ZVZVbWd5TzhzV3U2TWtzeU5KM2VHa3l2dHUrakNRS2VuRjlBaHJ0NUFTTWhF?=
 =?utf-8?B?OGtsK1RsL3paRTAvSnExbm1ZWlZEUVNvbkNGV3h4MVN0eVFhaHUxSnpJTng1?=
 =?utf-8?B?bnJoU2dBMnM0QldjVkd4cXVQMExyOUhyNEFxM01KZG42djB3TnBOVGwxbjFP?=
 =?utf-8?B?V0ZzSUwyc01VT3NzQUtsYnIwclViY1lDSDV3ZHgzeUpwekgxbCt6UWk5Szc0?=
 =?utf-8?B?ZURrR2VUM1RUV0ZidG9Sa1ZoMEVDMEx6blFuMWczRTczY1lzdEM2M3VsRWZs?=
 =?utf-8?B?LzV3RzlsR3JoNkZjWFJoOE5kRVRJKzNjZ3hzTnFXZkY5MnF6NEdwM1lRVXFs?=
 =?utf-8?B?TE5UZUVLR3BGQ2FxeVVHRDZWbTR0Y2NyZ21QcGtHZVpRTHQrdFBHekZYZG1G?=
 =?utf-8?B?QkdHNFpITVVYdytnaWZ6NGJ3SnVvalZyRFF2cXZqTTdRbXYwWVNsQjN4R3Ba?=
 =?utf-8?B?dElweEY5aFhkaytMazVxZ3ozaElTMlphazRyNGgvWlhHYVhJVnR4OEhyTk1t?=
 =?utf-8?B?NzJXK042WExRVjRTTXdZMVcrMGk3Qkp2Q1dteXgxQXpCdVU5THNmVVdFd2Js?=
 =?utf-8?B?VFhZVEVsSURUdEtPWVBKQ2ZiNkFaSXFHakdacXhUTFEvMHBaV0x1YWlObkxX?=
 =?utf-8?B?NExjRW5sN2JNbU5WWlNWMWpqckIzV2M2RjJnMElBK2hYYVEvd2swSnRIUnd4?=
 =?utf-8?Q?2za+ummH+wzBB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TGMwQXlJU1V0WFdKcmlUbEpvMDgyTWFBajFIVXZvbUVUUUVpdVoyVm5zQVRK?=
 =?utf-8?B?NlRKNEt4MWYrMnJlNFd4T0NINzBPZ0Q0MXlzN0l6VnF1M3NUNUR3ZXBENk9z?=
 =?utf-8?B?Tjh1L05Ra1cyNmJsSlpJWWxzN0ZwNjQ5a0N6VzJGTFIrcUw3bmV6VjBnRzBJ?=
 =?utf-8?B?ZmN3eEkrcENHZk5wZ204YktMVkRQTzVsZFIrOVlvMUd4NC9QVmtmOW1ienRF?=
 =?utf-8?B?R2w0TnlndThJYXY3aUV2dnNuR1dOTklzRmFuS3lmUVltdUJkTnE0cDRBRHZF?=
 =?utf-8?B?TGhndFF3WDdpTTMvVUZ1L3YyZ1pGZElBM3hHbHZVclJ4dWdvQU9kcjNlMXZw?=
 =?utf-8?B?VDJOMllHdlZpT09qTGdYTGQ5Vk16Uk9HRzVhcEs5SG1CdE9idW44SG9Bekpr?=
 =?utf-8?B?a1p2ckM3eDN1NTRiM0NnTWcvbStpS3ppQnRxa2pLa084YnVqMFlkcGE3NEJp?=
 =?utf-8?B?Z1JCNFByS0NDbVRWZmsrRUdJb0pWTDFSN3MxblB6aDVzYmhnVFRldjRDamlW?=
 =?utf-8?B?WjNuTGZFZGxmdEhRdGMwNnRRbGh1ZERKcmp1TUl4emVxdDhJKy91cGhvalBy?=
 =?utf-8?B?dXEvUE9oTmtYbkJRcmZRMWRzNGpVYVBLQW8yNkdTcmptY2x3ci8vanJ6N0N1?=
 =?utf-8?B?dFJBOElkMkRzenlHaGFWWFN0cGJpMjdaOExXOWszM3huNjVWTGFiTUl1WGNF?=
 =?utf-8?B?bTFBVGhCU3N3TTZ6RkQyTkt5TFoyV1NqZzhYUFhtQUoxd0Q4aUlDNS91N1J5?=
 =?utf-8?B?U2F3WWEzQmtvK3NqeDRGQ1E5bjlNNXN5ZGo4eXc5bHEvTnBZYWxUMEx1KzZG?=
 =?utf-8?B?S2pmL3NjVTB4ajcvNXRwWEZVSHFmU09vcEZhamdadUY3QUtsdU55WldieVZ4?=
 =?utf-8?B?UXhSQWNZUUY2Z1RxZ2FiWFoyVmUrdGVOcFF2WGtGTW1aSjhjUkZWM0U4Z3Ra?=
 =?utf-8?B?aVlpc0UvUkhWTGxKaHkzbjltWktQbDk1MWJheTl2K2M5SnJON2EwN21mZXp4?=
 =?utf-8?B?SkdhNU1YMkp0UXhYbElvVzhWUTJ6bVhjMGlXNFdNVGU3TkxTUCtKNkE2ZTVz?=
 =?utf-8?B?WEdRa0hZdytkQzFEVU5GNExlUUYxMHdSTUFST2hxZ1FNTERaWEM1K1BKRjFh?=
 =?utf-8?B?aU05c1NQa25DMUtxZUQvSjhSZXJHTnBCRXY5bVFja0xxU1hDN0ZSWDJiSjly?=
 =?utf-8?B?YitXV2k2V2ZoVFJBc0oyNHFOSGlmSEhIMmdmV0p1MHhrYkNvR1BWanVqOFVR?=
 =?utf-8?B?NEVZUDV6aTRDZXVuUXhwSFhwQ1FIYWx3dHo2YU1DT0kyZER1YXVMQ2I2YWND?=
 =?utf-8?B?Q0NMRmRFdEhpQXlhaENRUWdJWFhEblEycXllQ2Npa0YyUWNlekVHcnZaRWtp?=
 =?utf-8?B?SEVpQU9Uam5NWDU1T2NEQmtsUkRlWHphKzRCdUMyN2JWeFV1V0l1aTNzSHVw?=
 =?utf-8?B?ZlNndmZlT25EM0NZbzBZb0NnZENpWDkvbnNCTG9hUkhTMHgxVzZvemNKUVh4?=
 =?utf-8?B?OUpFQm9neXg4Uk9SZGhQWFhCVVFCNEdWd3laWTBvTk9xVFp3OUJKczZOQzU4?=
 =?utf-8?B?QjQ0WjdBTlpIZFc4QjBJUWRneENhaWFjM250QW9IdFV2WDlISmZRTGJkcGVa?=
 =?utf-8?B?TFZWd1haTVlCeW9iTzBZQWkycVkzWjZ3WVVDTWhrTmRYc3YxK0ptNTUycDd3?=
 =?utf-8?B?by9HV0F4ODdXbXBFWkQrWk5Eb3FjUWFYdjcxYUZQbWxqelNLaUxrMW5GTEx4?=
 =?utf-8?B?SllqZ3d5Wm4xZjZES3BaeHR1clhocUxKZmJVdWtBVGJaUjdBeEthR0tFWGxS?=
 =?utf-8?B?enJQMDdyNHNTNEhZdi8wd3ZCU0xSU0VnMkpGU3VhaXEvQ3BxTEFvbzBHSS9J?=
 =?utf-8?B?akwvd2t5MEZBcUl1VTkxaS9MMEE0c0FuM0JZRGh0VHlVV1c0Z2g4Ly9sUHRt?=
 =?utf-8?B?TWlVbkx2dlpLcDJjaysrc2ZPWVdaT3NzWmc4OUl1MU1ZdjkzemhjeG1TZ1dL?=
 =?utf-8?B?TVBJV3oxTnFtWkZWa3VDWjJkOXFWYUpDbXVuOThxcldrSzhxUDhvb3BSVFND?=
 =?utf-8?B?U3N4SHZYU0NaK1BhdUN2blZPcDBaSmQ0ZlZySjFtRXhqa0pUTWtvS2NTREY5?=
 =?utf-8?Q?W0X42aX/OnepuN5hESzBugIoS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e41acd3-505d-4ad8-7c7f-08dd2bc74c16
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2025 07:21:53.3945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1qnamdoIJSLYy/AL3TuPy7sBXHwv3A/leCWvOaMevd7Aj+pVpvBgdxj0afAzNblPp7KXUzwbhGaSyNHlfr6tww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4333


On 1/2/25 14:32, Jonathan Cameron wrote:
> On Mon, 30 Dec 2024 21:44:20 +0000
> alejandro.lucero-palau@amd.com wrote:
>
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Add CXL initialization based on new CXL API for accel drivers and make
>> it dependent on kernel CXL configuration.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
>> Acked-by: Edward Cree <ecree.xilinx@gmail.com>
> Hi Alejandro,
>
> Happy New Year!
>
> I gave an RB for this on v8 (subject to the few small things you
> have tidied up), I guess you missed it.


Hi Jonathan,


Yes, sorry. I will add yours in v10.


Happy new year!


> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

