Return-Path: <netdev+bounces-214276-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E87CBB28B7A
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 09:35:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8768178FA4
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 07:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C4E2222C3;
	Sat, 16 Aug 2025 07:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="kukj1ZAi"
X-Original-To: netdev@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11012043.outbound.protection.outlook.com [52.101.126.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC95110E3;
	Sat, 16 Aug 2025 07:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755329744; cv=fail; b=ELILD7Sof+1FXYOpYLM01YdwJATGu1SAO5IA70pVQG/5+CaGDlG6cl0ypcBOFTqKOInnzamQaZzwXqMmuAGMfvjf/H/yykonbEYwuZAKVKNOWzUgJylcHGbY6D7h0YnaNewWW0xFE5hXV8GuC997Kp8BigChLcPK5We03jedbUY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755329744; c=relaxed/simple;
	bh=FskbEy5QQe7RmjHB94zChOf7zr6IsJ9ht3Fdgb0X5mI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=r0EsVF6gr01VOyZVcsAwQs9rpVNb6/7Nc0YeBpb38JKC9NWvK1g/o6YGjShKAB89y0OCDkhzHg3kNo/3paYReDG3vve2BUbKKwkGodlQpRo/6SPTbe8mepq0OXPobf8yatX0zIVA9XAOODI2BMXBJVRfhQ5clMjTELXUxUIl6PA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=kukj1ZAi; arc=fail smtp.client-ip=52.101.126.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WhU2dbkGqV7W12R02FtyoqVIhzFe6QKvNyZITA1xmZnEWNZKgTJQdh4ZH+7yz42ZkSdMevs0nt4AzftiwC21W66868y56OzEyXI2rFJW8+WZ9CcLjEJWrpeEqEqHoK9NPvbNMQ4bHerloW3wW1oSKaLTrQzRC5mjsi42mEERWS65qHTFH6Ctn161k7jOJESfeMAjoRE4MnZsJce8SvmDOrRdReWAO3d/eMkkYVZ6bZYABudVLLhQzfZoX+CIlLIS+7+ktxyPP/X23sUpGcdsy0z9tY9nfB/jeOy+utuJbm+TNd0Lf0IEK7VpGNe/La6u3zJo/WUtgEIYf8x328jrZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mIiB+osNLIdVWOYCnNJV1o8acyyq+wtWNmKpKJ5D3a0=;
 b=XyicTYxMaePW0lX/S9pre1Y2Y9JRQ7AFEuusKCJieSHPcZZmmha/J3HPzbgTo61TtJK+D9P7K9KRXVV2PdAiWeQvs1fw9Wt9Xb3aN6zMwP1xG337uiddB/7Q4CxnK915FY65VxvaigClFTPXlZHxeaom/2kfujcj19l2XVZaDETGwCbN0hJSrCmysS/J9wslNuP9Rzj57T5oAgk669FhNGrqAu9kYZtkP9pLesXv24mzwwIQIVmPI9X4kLSz6Av6l2Zr3+CP3XZ/bdmrxYCBORVKEskZ1cn0olXZHOmBGPPJgVVVY3oGW6BeMDjUoGd+ikSovl9O/f41m/wAtKgwVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mIiB+osNLIdVWOYCnNJV1o8acyyq+wtWNmKpKJ5D3a0=;
 b=kukj1ZAi6KNztQn7AErW15UD/96OudTqhftFMZdpKvoN5hcDW5QfbuAmtdbSEjWv2uPICkN/99t9/QvjbOEBq7O5ZGKO6oRfD1UWdyr9Tun/BCChQOnd5td79Lzcdhx68sTFESlx6AaSYn3ugCMeYXbbYMxwfZDH6XF81jfXXcfCyuMftiBsGEaqeE+Tf0asPdLN5mRKJRJ82cp9vdmaPwZDMW2X/4l/MdrPBNtZR224SvLIDjN5hsTOIFLoTdCL1Cic6Qh7mjpnTcl6/OjYPx7wE5SoX4X9iQh6HTupDMKHwahe1xb6byUonXB8rIK2iMVkhdGaxABBH3Pv3RwWEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 TYUPR06MB6220.apcprd06.prod.outlook.com (2603:1096:400:35c::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.19; Sat, 16 Aug 2025 07:35:40 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%5]) with mapi id 15.20.9031.018; Sat, 16 Aug 2025
 07:35:40 +0000
Message-ID: <9fb486df-b78b-4155-a398-d57161ebc583@vivo.com>
Date: Sat, 16 Aug 2025 15:35:37 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] nfp: flower: use vmalloc_array() to simplify code
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>,
 "open list:NETRONOME ETHERNET DRIVERS" <oss-drivers@corigine.com>,
 "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20250814102100.151942-1-rongqianfeng@vivo.com>
 <20250814102100.151942-3-rongqianfeng@vivo.com>
 <20250815105026.04912f25@kernel.org>
From: Qianfeng Rong <rongqianfeng@vivo.com>
In-Reply-To: <20250815105026.04912f25@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0003.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::20) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|TYUPR06MB6220:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a6e3e01-70ad-463d-f5d9-08dddc977fdf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YWQ3SDZDcFRmVkxwKzl4eDlqRDc3TnlZS0hwejdoQU03Wm9HRGVzaEtPb0p3?=
 =?utf-8?B?ZElmTTVFTlV1WkhWUiswc1h0VjVta21pSndGalMrWDBxa25ieUFOU21NY2JO?=
 =?utf-8?B?dW0zQ3BBNHRGbGgrSTBUTTg0b0E1Z1VDN3AxU3RORWRXZHZMdEJma0Uvcngx?=
 =?utf-8?B?RzY3WXBCTDB1QURCU0pJa3g0K3paMy9tSEhkYjZMMHNHdXRTTWJ6UHpvM0sx?=
 =?utf-8?B?Q0R6Y0ZIK2ZMVEZzdUpBVUNrMTRBRlNOUVBlTnQ5VHYxSktTaHFJOTZrbHIr?=
 =?utf-8?B?THp0THZCZjlkU3IydW1YRnVZYnN0dUduMDZCL1Y2bmVUWnFjZlZhdy95dkpI?=
 =?utf-8?B?LzVIbDl4SW5wQzRYY3h0ejhUZUxPL0FNUUN0bTRDWUdkeTBoYzROS3JlYVpv?=
 =?utf-8?B?czM4S1NobUV2MXlTcHc4NDVZR3NhZkM4b1Znc2w3OVAzWnFENTVVTTQ0STVP?=
 =?utf-8?B?WkZGSlljNlFhK3lCYWEyZHhtOU82SjZwM0g5d3BIbWNKWFl4QnhNZlFsT2Jq?=
 =?utf-8?B?RG5TS2c1OVRLR25nbVkza0hTdURieEF0TlZYMmtHcDJtT1BKZmR2OWRTM29O?=
 =?utf-8?B?eWhWV0FOTVRhOERVVm9TZUh6N2UyNVdIQzJsWnpmdHNEK3VzZC92MGpjSmRP?=
 =?utf-8?B?dC9UL0FTYzRzc25mbDZwWjBTSGRWVGl0WU1FS1pXNnB2RUVkTmpiSmdvdEVZ?=
 =?utf-8?B?UnVYS3BwelJwNmFyREVlN3daT2tKbTkvbVZtbTlDc2s3TWtidVNIVG5jSXov?=
 =?utf-8?B?bFJvVm5WY1R2c2d5TkZvSE5QL09ibWVqYmVKVjRZcUFIVko3dEFWY25sQll2?=
 =?utf-8?B?NFVzeWFKOWtSM2hTSGNwa3JGVitsNkU3cytZVkQ2bFFaNm1oRTVmMmNkMnQv?=
 =?utf-8?B?UWlsbFhSdCtsSjFyaVpJL09sZitMOW9DdTVPRmlNN29kblpLRERyVE14NTRD?=
 =?utf-8?B?T05PSDZOdTZkcURkeEhzOTh6U1B3TlVreGJwVGFuQko3c3JDTGdiNUJhTHRx?=
 =?utf-8?B?cWxma2xiNkluZUhYeW1Qb25jTWl2eHA2QmxnN1k3MG5YWTFUSE5saEhJdkpW?=
 =?utf-8?B?OWRRUGF5OGV4VExjcXVhbWdFb3FncVRTZ1VpbGg3YldjdG1mamRxRHhESDJy?=
 =?utf-8?B?ZmdyM0FBQTUwbDFOTS82ank3Zk5QMUgzbkRqMW5obzdzbUVNNjVjeXNGK0Rw?=
 =?utf-8?B?OVA1aWN2VVY1NFlJU1dPczZpZ3MwMEZsZ0tqNlgzZEhEWlIyUTVPZUwwYzNJ?=
 =?utf-8?B?aFJvTmdSN3FKaFhyMnJyN1d6RDZYVHlQeFRYR0tWam5zUVdBaWdLZHlDSk1k?=
 =?utf-8?B?Slh3RmN6cVkrOWlZQ0ttNVFPYU1LM21DV2xScW1Od0VUVFJDOVp5NUFRNFhU?=
 =?utf-8?B?ZUl0OENQL3RzSHhYZ2M4WGJPRmMxaEhueThIcFZhRy9aQ2JZMlAvVDlGZGZC?=
 =?utf-8?B?T3ptSHp0S1h5MlNjNU14dUd2OGV2NnkxRFZBNUJnNHpvT05Xd2U4bWFRVVNy?=
 =?utf-8?B?Mm9wMkR2TS9GalhJempJNzlsbnVxZFRyYlM5bTRRRUhNQjBxaktKbW5zbEJy?=
 =?utf-8?B?VVJrVmI4b3V2MGZZK3RKaFZ5amxZbG9ad1NQWVVhMjVtNmhhQ1ZGbXhuUGw0?=
 =?utf-8?B?ajJQYXVGM05WVURnSWRHV0NjMFQwblFNak1uUXVRRFdJRFBxbi9hd3VhTXRE?=
 =?utf-8?B?MDJVcTNsZ3FGVk9LbHkvdXc2c1ozcDVjRis0NmE5dzVkd0dzMUhYSS9CTndp?=
 =?utf-8?B?RmV0V1U5eDdrOVJIL3JYSjJUS3J4c3lHSm1zWDZSc0hTQVhmM09OUVhkVURi?=
 =?utf-8?B?L2N0Y3hoU0NER0JFemZET1lFY0ltL3hKOTZBREhuM2ZvVmlNS0pFWWdXMmVi?=
 =?utf-8?B?eU5DazJVbkVCQkZXMm9ib1Y0WmlzNW94azIzaUFKaDRRalVrRFc0a25CT042?=
 =?utf-8?Q?/XicLXJvQiA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NjdaS0o4d3N1UFYybmFoYzRyMHk0VkMybjBVY05xK3VFbkdzVy83ZFdPM09Q?=
 =?utf-8?B?V2gvdjg4blIyT3ZLVzhLaXFsVmkwQWt2MWxjbUhYbFdaNHlRN3RTZU5LV1ln?=
 =?utf-8?B?c2lveERRaDhSQ2VET3NkMG1xczFwWjBDRlNhbFozNENzc0poVkdFSUFlTk9l?=
 =?utf-8?B?YTJJRjJkbmUxN2txV0RlYjhSNFNxRVBOMElhQjJyQkRtSFlOTmN2NGNxZ0Y5?=
 =?utf-8?B?T3FzSUx3WXY1RmQzL2RSMDExVmlrc2FlSXBvVzNIVTRnS0lMRlU4UHF6T3Mx?=
 =?utf-8?B?ejQ2VTFOck8vM3YwaDZEaFRKaEhWN1VvbzZHc1hLSW9UTkZXTlo0MGNOd2kx?=
 =?utf-8?B?SVVRK1F3ZEFKSUdqQWg4UzNXdUxkZjgrOVVVM25JQjVjWVRWbXJlN2N5NHhJ?=
 =?utf-8?B?TXhrK04vdlB0cDV6cjRta1JZM2RvZ2gyWUtkMmpiZG9rTTlDZy9EbHhPcDdz?=
 =?utf-8?B?bVlwWnRHU3lGRlY5bndNNDEzZDFaLyt4WFBQUEdReFRhcEdMWDZ2Wmc5L2dx?=
 =?utf-8?B?SXpQSFpPZ3h0QmRWelZVMDYzdDR2Wk1kaGxTTXd5WFY4eHBhRDVJZVB4VGxY?=
 =?utf-8?B?THo1eCtweEY0SkZ3NzVnRHQzQkMvMFpTc1ZzakFzeDFsaVMvY0ZvSytWWmh0?=
 =?utf-8?B?TGdyS2M5M3ZjWXlMSUR5aG8zUWFJMy82RGliNTAxM0FNNDJOclUrZnprT3N3?=
 =?utf-8?B?R0d4MnFXcWJqdFhtc1Bhb3BOL1Z5ZkxSSzhVNGlSYTAxU0k4NVBMY0NDajNa?=
 =?utf-8?B?aFh5MUJQU2FLcWVsWFdXd0xHSHZPRFU3Z3hZQjBjaVhXZzFodjRTdUM1VGFE?=
 =?utf-8?B?RHpuVDlSZjN5a0dvS2FoM29JVDFnRmNQd0hvVXNKMGdvdWVFcEk1THQrblFO?=
 =?utf-8?B?SjZDNWVMQTZsWnVyemxlNFNSbUtzME1DS1VodEtFMVh5UUlvMUkvakVpWW5j?=
 =?utf-8?B?R1Q5SkRzMWRLZFZFTXc0MWNzZFJzMFQvQyt2Nmg4WUJGZmxMS09sOXljZksz?=
 =?utf-8?B?OENiSmI4d1VFSWkvODRiUXVxZTZHcXQ0NWdRZEVUYldUNXZEM0tFOXAzc2xF?=
 =?utf-8?B?clNTamx5Z2VBcE5zRzNnNTM4TVhETTZQZU1xMVE5b2lhS0RZLzhGOXlCRk9h?=
 =?utf-8?B?bllSM2JYQWc2U3gyc0tmVTFBZXRnTzFyNmpnaFkxZ29WcU8rZkFubmRXOU1R?=
 =?utf-8?B?NUZPR0kwS3pNcDl4RjF4MmtGeS9LOE8zWUNHTHZ1NGRnK016bnRWalI2cFBX?=
 =?utf-8?B?VVJJSkQ0Zk5iZnFEeCt3ZkYzSDBFRXIwQXJaSHBoMW1xZko4d011MTZobVcz?=
 =?utf-8?B?WFVFV0JNaDJORVU3NFdxWlV4SzhVNGN3TEFMSXh0T2dvc0lvdmhNaVl3aHJy?=
 =?utf-8?B?Y1VxalpMQVh0dVFRNk1Db3kzT2RQUkgzZmJxQklMK3VvNnY3VVZwK2diZytk?=
 =?utf-8?B?MTh3R2JSV1lKK1hsWEtIdVpKaVhQVkV0UjlUdHppTlhuM3B2STZTUW5hTUhM?=
 =?utf-8?B?eUdXeUdSRlJ6YUVMdHZrVU9UbEp0SVBFSHl0YTZkZk9YSlQ2U0M2b0N6T293?=
 =?utf-8?B?clVabmR1SnpHRDNZMklkSWp2dTBOdFdUeEVmWDQ1VG42QitrelcwN0VxU05R?=
 =?utf-8?B?VUdkTVF3a20wSU1abVpueXlNdmxZajZFQ29ZVitpZFRUV2JCQjRNL3pQU3Zq?=
 =?utf-8?B?djJVazNxcVdtYS9YS3NMeHZ1STZsS3hLK0lweFlxY2JpR1FDbEd4bmJRYjdm?=
 =?utf-8?B?Y1JCaVI5YmVyUldiUDNjNGg5QmhZNnI4VWg0d3ZZQkYxQjhvSHBCUDF6aWRY?=
 =?utf-8?B?UDU0VHduTUdrV2UzQkgzWlFCZHQ1K0pGcTVIOUFwSS9ia0lRZllJZmM3VUZJ?=
 =?utf-8?B?dzhSNlhWdDE4TXMza0hJeUp2K2FtV0tIeGp0TnRjd2VXazNKMGc1S3c3V0VO?=
 =?utf-8?B?dzVUVFFnRmVpNCs0NncrUjNKSE9aUEZhbHhOMzBEY0lydnB0MVJ4VkJHbmxz?=
 =?utf-8?B?OXhnRG5DbGZVRk5HSGhhRFVtT1Q2Tmh1Y2pSU2cwV2NvVDZ4Vnc1eS9uT3Bt?=
 =?utf-8?B?KzBPekc4NkRQYnNpV0lQWWJVM2dPYzRTZkFFb2FOR2JIMEgxNGVQQjkzdDlB?=
 =?utf-8?Q?JMKqA6M7BWzUEaSTHj7T2ojyG?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a6e3e01-70ad-463d-f5d9-08dddc977fdf
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2025 07:35:40.1397
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YxL+FRxQV5n1Y4XY1fOc4ZTcYPyI9S9Gcrxuj0zMiCB7iSqg+PuWIxHz2RAynr39Prg1aoo87QYpkzBCNzsrlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB6220


在 2025/8/16 1:50, Jakub Kicinski 写道:
> On Thu, 14 Aug 2025 18:20:54 +0800 Qianfeng Rong wrote:
>> -		vmalloc(array_size(NFP_FL_STATS_ELEM_RS,
>> -				   priv->stats_ring_size));
>> +		vmalloc_array(NFP_FL_STATS_ELEM_RS,
>> +			      priv->stats_ring_size);
> This generates a bunch of warnings on gcc when building with W=1

Thank you for pointing this out. I will research the issue and fix the
warning immediately.

Best regards,
Qianfeng


