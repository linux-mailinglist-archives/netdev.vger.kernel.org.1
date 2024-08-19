Return-Path: <netdev+bounces-119797-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A32AE956FE3
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 18:12:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C81861C21CE7
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 16:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D397F8287D;
	Mon, 19 Aug 2024 16:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Mm2dJyh2"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2071.outbound.protection.outlook.com [40.107.236.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6DF139578;
	Mon, 19 Aug 2024 16:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724083954; cv=fail; b=p+KjGTOClV6CckMaMvdTwk9h0SK5e3+46PEp0fjK/8i0VKBOg1aD8oHsIwuk2xgjZhNMWUWXRc7HsbuqvDH0YIEwPw7Ia8B488RvjMtmTC9cSmvPscG26BoEoILlHLRTydsI3EJC7fhNIUHAoQxtj06ba24JqkEdItS2X4oA2AY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724083954; c=relaxed/simple;
	bh=Y/w4fbG50X/a+8/H/Oe9/OD0izBW97DGnmEnkGhXfQE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SDNCrSdC026XxGxWYWOkPAd4zuqCIEqCun5pksR3L+Y3HZuuTBBVMGyqAzDJKkUtG1gIvXN4R8DusyE0xVgEuhwWuomYucARTlflpjJ4m0AWAH8a/pqUzPrDxYv9CCFlxtpNRXT9kAvEiFnQnhX6ENZ7/fE17sKL7N1fxf+eynw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Mm2dJyh2; arc=fail smtp.client-ip=40.107.236.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y/HXIGt9Sjq1p1Icj5GC7wXI+11/mBE4H26LYw5SZWgN+nQzFYpiJspqEFF951K3uvIE/Cz0viGnJ1vzKXPo3R0XznT8Ce0KOVItoH5/g82gnNHQF5mIXf94NdOstQetlA6B7stJIlTVdaPVuVjPxdqr0g+5t1/Fp1vNwfn8FVf9n3dXWNvHKaBV+5B2ZvokPj7soGiFcsZvJWbrGeBLjb3ZPVgxDR6nEAFye3wO7anabyJzSeH/vMVqef/Ie+W5oI6f87rF6myiyKBvxfea73c+60f+CLOnzpWe4JPx8zQTUmxs7nRE8gRo3tnO6SVZpXd6BYhvZiZ6kHk/XjAYug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eXrcBB2AgZckce+SV8p2YG4DRrTNH7AGd2tCZ+kFFNM=;
 b=LEEk1H5+LvFEiXWH4565G6vl2H2gjWvVGtk9YsNntJENurbf00m0rs5puq8JhwdpOB7QkvQpm4AvulPrry/Yz/7sSY8/qbDzfzTiwvqiVZQahGSJpQb6enFaIHm369sZFDuNuc6Ot/awpkZ5l380JoP06YByFU5nD7lojuIff4mcoqai762LnUcL8JYshE5pjR+pltpLkYbdmLpE2rMRQG79T4nv1xpQt9aa+6d9mw1rloxw/XQKu9AFINhYRDnRljKk96bwpXdG2OU7nO8J8UAuyskKVXfssV75Zkwsj8ponS18k27lixD+GVnQbsQ4gA0uXd8JPUsa62GiyRGPDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eXrcBB2AgZckce+SV8p2YG4DRrTNH7AGd2tCZ+kFFNM=;
 b=Mm2dJyh2e5rZHiRD8dyGennLQqO/0D3JwBjre6zeYmalA/mp37Zum6AFedOjtlME/jhgU1Ps2+JYuj4Ygj0b2qsYn00MJjlLT0+feo7wq7SXFDxqwxcAXdgOd6xnhQz0GFzw/npHCHixkZ3dqB3wfUGLKi4PjcNzHhwhNGpTj1w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by CH3PR12MB8236.namprd12.prod.outlook.com (2603:10b6:610:121::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 16:12:29 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%4]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 16:12:29 +0000
Message-ID: <ab8b5f77-7a53-a716-a1e6-bf1f7e06eb50@amd.com>
Date: Mon, 19 Aug 2024 17:11:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 12/15] cxl: allow region creation by type2 drivers
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, martin.habets@xilinx.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, richard.hughes@amd.com
References: <20240715172835.24757-1-alejandro.lucero-palau@amd.com>
 <20240715172835.24757-13-alejandro.lucero-palau@amd.com>
 <20240804192923.000035bd@Huawei.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20240804192923.000035bd@Huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0015.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ad::18) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|CH3PR12MB8236:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e925eb7-5d28-4870-3680-08dcc069b913
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cGlKWWd5WXV1djBkQ2ZQaUFyMFUyaHFyaE5wa1hvTFZnVTZPeXlzeTdGdXlS?=
 =?utf-8?B?eStUVEVOK1ZqZllrL0lZYVZDendCWWduUnJhb28zZ2JCOGtUbHlQQVRIYVpF?=
 =?utf-8?B?TnpVVU1jNXlLT1RwWks1QVord2lLd1lpSWh0UWpUQzhJb0ZlVGozMVYzR29T?=
 =?utf-8?B?SStVdU1zdzBrMi8yRjdUWno5TFFmRkRGQ1BNRGx5V1BsRC9aZTF2dm9GdE0y?=
 =?utf-8?B?YkxCdERncVB6VElYbDRGeVJXMUpoZTFBemkvMWxLWHdPU0VEbmc2bFdDOTBZ?=
 =?utf-8?B?eTJlWW4wZkNPcVhNSjZvN3BRZGp0S0NrRWJ5TUZMNG4zZ0hwN1FrRnR5OVVK?=
 =?utf-8?B?dmRES20vc0VTWk1Oak9VUFdaVVRaUjBsSE52TTc2eVhoazNpc1VvYlZtMEs1?=
 =?utf-8?B?dktrN0NjT3d6cG10bjduREZJMzlwN3J2a0tPd3ZUWGJHMDc5VCtMN2JvaS9X?=
 =?utf-8?B?T29UeExnd1RndmJTRVVpb085eXUrc1VRa0pIRU9CMDVkbUozZUVRSVBYUklO?=
 =?utf-8?B?czR0ZmhnS2s3UFFEamlVRDdZRmJKakxTNUNEZ1V1VG05VmNCSGtYV1c4RUpL?=
 =?utf-8?B?TmRpS3g3YjBMLzR1azBhcGltK0lSc3dRa1EzaDBCUTlOZDJ1NFZsbkZ3aGFl?=
 =?utf-8?B?bmVMYnVObWRVOGRwOGl6bU42M1ZoS3A5UFhDdEkxMldCOERMSHJ0VFF3bC9s?=
 =?utf-8?B?aW1ZSzQvQVNMMERGVStRWGJZejBsZkhsNzdNdk8wM256ZkFwK0JYKzlnQTJt?=
 =?utf-8?B?YU50cHFDZk9ZZUYrYnlBbnpIdGVWSEhWajVIaDdYZDZJc3dVUUZCYlZzc3Jh?=
 =?utf-8?B?YXpXK05Xa3RReFNPaE9TTnNIcXNSdS93VTFhbmt1akFaV3F4aWZMbk9KZklz?=
 =?utf-8?B?K05ZMjV6bC8zVDY2bnk1QmhDY1BKNnZFM3pLWEZtVWhaZ25iZ2o4Vmo2Q0hY?=
 =?utf-8?B?VDNUd0NuL1l2a2MrZ1J3VUZTNVBGcmpsMkNOZDFBb3VkcU5BTVBEbWkyTFZ2?=
 =?utf-8?B?LzNlU1dvd3Zmc0greWZMQ3ZrM3F5Nzl2N3JEdTZ3UVdGdGg0cXl2V2V0eVN5?=
 =?utf-8?B?K2tmbVYwZW53dzk5TnVJSUlWNnNZL0lKek5ZK05JSHBJcVU1T29FZTRaR0FR?=
 =?utf-8?B?T1lCd1hseHNidFlxZXhBblB6cFoxWG9JWUpqZGhOTWtLUzZrSEJOWm5BdHZw?=
 =?utf-8?B?NlZmNWZML0duejBtbGRVYU14bFdvYktHbUJLOHhidnZ1d0ZGZU83ZHRJWDRJ?=
 =?utf-8?B?Q3dMSkdyUXFuRm05ejlRZkNXYkRWRWMrTlhnNzBNTjZRa1lCY0R5ZkVOZG43?=
 =?utf-8?B?a2Uzc25wUzc0Zy9qK2dFdEVJUTgzTDlYR1VFU0lFQ1lDeEduSWlPbXBTVzBo?=
 =?utf-8?B?Ri95MjVobFl0dUQ2V1VYdlcyOVlIeWh5akRlY2gvL3QzN0VOTlNwSHkweG9k?=
 =?utf-8?B?aXpKUEJ5YlptektqQ0VZRkw4Sk44U0ZWNEh4VThMMFgwZkttd2hqSnI0UEQw?=
 =?utf-8?B?NFNTWnFPczZEZkJjaUNLTG9vaW90TjJ2S3BiQ3dqaGEyVnQ3N1lwZ3hpQXZN?=
 =?utf-8?B?b1phMHc5S3JEUlNaMHJjR2pXUWo2YldYSjcvai9aei9DUTVudXJsay9Qby9H?=
 =?utf-8?B?RWc5d1lIZUhmTXFRaHBuQ1V4Y24zOTB5a25VckxTY2c5WDJ2a3JZWFRmQmtW?=
 =?utf-8?B?WHdPMm55ZnZubW5WcU5CbWZ2OEExeXVQOWQrMUdmejJ3eU1lUXNta3lsV0Jr?=
 =?utf-8?Q?4Ouu5gIOIjdeiY8S44=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bFUzV0pHV2IrTWZoUDl6S3c2d3hsV0RqTjJJdndVQTRiaHllejhXRlN4R1R4?=
 =?utf-8?B?YmQwVFM0aHRRcDlJejVYM3F6WWp1UHpIQXVEbmxmak41dW1uVWlIem55WnNp?=
 =?utf-8?B?aWNINStXZjhKdnF4aElzL0tpS3Q4NGVFMng0eXgvQXJ0eGFHVDZHWjFWeE5G?=
 =?utf-8?B?T2dESm83NEdIS0dhL3g4QmVjNXBYY2hBazVJZ1BVWTc4U0dOSE9xUTBuUW5C?=
 =?utf-8?B?Y2dkcVByOUJlMXE0TGY1QkJSeWd5eU5lZzBXR2c4d1Z3d1VYVmgxeldZM0h3?=
 =?utf-8?B?d1MxTkNiVDhLNWE0dlVuZGFrK1Y4WmxYcmpFd2w2R2ZOWjZ3WGZDUHUwSmFZ?=
 =?utf-8?B?N08ycnVkcjJiU0I2SDJhWXF4dGdGeWVFQWRrQ2VmL284NHpmQWhIYkJmdEVU?=
 =?utf-8?B?M2dlRjdZV0JqcmxhV3BqdU1qVXp3UmJBRjgvbngyb2RDVTI4Q2Q1MmE4dDNn?=
 =?utf-8?B?eDVlSFpMcGNCUGdoUHpMdTVydnJISVJnMXlLaDlVSlVQdHI0VmRheE9kNXRX?=
 =?utf-8?B?eTdZL0pnbVBhQTJZWVJBZ2IrTXF3bFpBRHo0OXFWdnZxeVhkTzRWc3RiSVhB?=
 =?utf-8?B?TXJFSkFXdXJLd2l0aWhlRXpLUERjY3JuWHRDRVhFUkZtMk11S1RQbkxGMmpC?=
 =?utf-8?B?ZjR2OHowUTdiaEFXbUg1MFdKdnR0aU9JRXo4SUJaZm41aW5BYVBQeDBsTEEz?=
 =?utf-8?B?cnVveHlRYjhaRXc5bzZER21MdHFMbGFqYi9qY2N0VUJvY3FvU0Ria2tnTkVH?=
 =?utf-8?B?djZwZTdGTmIxSzJoTlNFS3FtenNSNTM0MVlKMXdqS1ZuSmhZR2ZRL1lVV0h4?=
 =?utf-8?B?SERVRS96RlhlTHNvSzZxa3BBMzN2SHk1c2oxMnliaHpLSlpMSlQyZForK1o1?=
 =?utf-8?B?TDAzNTlhVkd3R3B6dXVBZ25ZVmh0UFhXbUNPUXRaNkpqLzMzbWVia3R0Qitp?=
 =?utf-8?B?SE9UdjhqaU1CM3liY3dqRVA2NEtWbGFUdjROVUhhSzZCRGs5NnFxSGI5ek1M?=
 =?utf-8?B?bERaek5UdEZpaEN4ZzZLNmZCMGxINWNIVUJlOTdBSHQ0WTg3eDBQczFNaVBk?=
 =?utf-8?B?RkVpWkNSZlF3R2syU21xeEd2clZQNmoxMit1clpyS0QzVWxNR2ZnY3V4bEtj?=
 =?utf-8?B?SzRXUVhEUXgzS0g2QnlyMWNNWm4rVUNZdSs0dmFQMFZ1RTZFZ0hZNi9kSVE2?=
 =?utf-8?B?TTNndDRzSDFSSkgwVXdCUnp4WnlqeHFMNkdQNWlBYzBybFJMNGo5bU4xY3I1?=
 =?utf-8?B?OHlXWllSdDJPRFF0aWRZMGlLV3lHT0JrRU9vZ0FkcFJQdzlZSzZ2ZEZvc1Bo?=
 =?utf-8?B?THo0bE5oeVBHRGp4dXhON29PQW4vZTZpdSt4aE9QYUhXMG1qaEZ2K2pYNkJG?=
 =?utf-8?B?d3dnTFlpemZBRkFGdm5PbnF4cnlGQTdLR2pRdEUrS3VxZkhGYXJMU1BSRkhV?=
 =?utf-8?B?LzJNcGFVMjlWYjcrOFlHOTFRSExaWmtPaE1VaXJrR3RZemlKSHpoOTE2UWxV?=
 =?utf-8?B?N1g0NWN1dnB1UVV1KzhyOExhZU1SMUV2NzlnSUpMV2RoQzhrNUpYWm1JeHZZ?=
 =?utf-8?B?cHQwT0tkNWhuSHU2TThFbXVWSWpCWUVKR3hjVkd0anowODM5SE9Va1dBdlR1?=
 =?utf-8?B?RTB1WHV5TmxsWStsem1FVFVWQ2xqVHhEd0ZzSThyTHNVQ1RJMyt5L1NyQ0lX?=
 =?utf-8?B?bnI1aXdRV3Z1QWRUQVkzaVYyUkVpTzdEVG94MVNESWpLcmY0amNzVno2RkpF?=
 =?utf-8?B?VmpNUUh5VkdsL25JWFpiT2QzR3g2Zm1TWVh1TzdWN1pEaEFXVEg5QXB6U0xp?=
 =?utf-8?B?YUhLOU9ib1ZjSStiOXJEZ2FsZTgwSm1TQzNqSGpYd0NKUjhTRDAwdmpqdUll?=
 =?utf-8?B?OURzT2M5Zm9tVE1WTDVETklQc21md1NuSThPcFZQcllnQmQ2aDhNckE4UkIw?=
 =?utf-8?B?VmlFWTNhclltem9sMHBCNm1xNWV1M1U5aDM5NWRrc2p6TkFNWVN0aCtORDgx?=
 =?utf-8?B?cXZHWSt0RE9wcWF0VXkvdldDeFd3TFU5WFN2dC93emh2VjhQYUJtbGp2b3JY?=
 =?utf-8?B?UzgrNE9mUm0wZGp4NzUyL2swV290ekxlWmQxWDVEWWIxZlFpc2pTUjVpbnY1?=
 =?utf-8?Q?EcHNYmJmDvEz9OYCSQiUrvAb4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e925eb7-5d28-4870-3680-08dcc069b913
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 16:12:29.3277
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w82rKDP8cuHgIri61H0940OVPfF25IEVFtP8pQcIJe5QS//CVWBQWqCr3vkKaq5r6dXtpZuEHSWlj7jVOrRbsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8236


On 8/4/24 19:29, Jonathan Cameron wrote:
> On Mon, 15 Jul 2024 18:28:32 +0100
> alejandro.lucero-palau@amd.com wrote:
>
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Creating a CXL region requires userspace intervention through the cxl
>> sysfs files. Type2 support should allow accelerator drivers to create
>> such cxl region from kernel code.
>>
>> Adding that functionality and integrating it with current support for
>> memory expanders.
>>
>> Based on https://lore.kernel.org/linux-cxl/168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com/T/#m84598b534cc5664f5bb31521ba6e41c7bc213758
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> Needs a co-developed or similar given Dan didn't email this patch
> (which this sign off list suggests he did).


Yes, I'll fix it.


>
> I'll take another look at the locking, but my main comment is
> that it is really confusing so I have no idea if it's right.
> Consider different ways of breaking up the code you need
> to try and keep the locking obvious.


I have to agree and this means I need to work on it. I know it works for 
my case, what was my main focus for the RFC, but not looked at it with 
the right mindset.

I take your next comments as valuable inputs for the required work.

Thanks!


> Jonathan
>
>> +
>> +static ssize_t interleave_ways_store(struct device *dev,
>> +				     struct device_attribute *attr,
>> +				     const char *buf, size_t len)
>> +{
>> +	struct cxl_region *cxlr = to_cxl_region(dev);
>> +	unsigned int val;
>> +	int rc;
>> +
>> +	rc = kstrtouint(buf, 0, &val);
>> +	if (rc)
>> +		return rc;
>> +
>> +	rc = down_write_killable(&cxl_region_rwsem);
>> +	if (rc)
>> +		return rc;
>> +
>> +	rc = set_interleave_ways(cxlr, val);
>>   	up_write(&cxl_region_rwsem);
>>   	if (rc)
>>   		return rc;
>>   	return len;
>>   }
>> +
> This was probably intentional. Common to group a macro like this
> with the function it is using by not having a blank line.
>>   static DEVICE_ATTR_RW(interleave_ways);
>>   
>>   static ssize_t interleave_granularity_show(struct device *dev,
>> @@ -547,21 +556,14 @@ static ssize_t interleave_granularity_show(struct device *dev,
>>   	return rc;
>>   }
>> +static ssize_t interleave_granularity_store(struct device *dev,
>> +					    struct device_attribute *attr,
>> +					    const char *buf, size_t len)
>> +{
>> +	struct cxl_region *cxlr = to_cxl_region(dev);
>> +	int rc, val;
>> +
>> +	rc = kstrtoint(buf, 0, &val);
>> +	if (rc)
>> +		return rc;
>> +
>>   	rc = down_write_killable(&cxl_region_rwsem);
>>   	if (rc)
>>   		return rc;
>> -	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE) {
>> -		rc = -EBUSY;
>> -		goto out;
>> -	}
>>   
>> -	p->interleave_granularity = val;
>> -out:
>> +	rc = set_interleave_granularity(cxlr, val);
>>   	up_write(&cxl_region_rwsem);
>>   	if (rc)
>>   		return rc;
>>   	return len;
>>   }
>> +
> grump.
>
>>   static DEVICE_ATTR_RW(interleave_granularity);
>> +/* Establish an empty region covering the given HPA range */
>> +static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>> +					   struct cxl_endpoint_decoder *cxled)
>> +{
>> +	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
>> +	struct range *hpa = &cxled->cxld.hpa_range;
>> +	struct cxl_region_params *p;
>> +	struct cxl_region *cxlr;
>> +	struct resource *res;
>> +	int rc;
>> +
>> +	cxlr = construct_region_begin(cxlrd, cxled);
>> +	if (IS_ERR(cxlr))
>> +		return cxlr;
>>   
>>   	set_bit(CXL_REGION_F_AUTO, &cxlr->flags);
>>   
>>   	res = kmalloc(sizeof(*res), GFP_KERNEL);
>>   	if (!res) {
>>   		rc = -ENOMEM;
>> -		goto err;
>> +		goto out;
>>   	}
>>   
>>   	*res = DEFINE_RES_MEM_NAMED(hpa->start, range_len(hpa),
>>   				    dev_name(&cxlr->dev));
>> +
>>   	rc = insert_resource(cxlrd->res, res);
>>   	if (rc) {
>>   		/*
>> @@ -3412,6 +3462,7 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>>   			 __func__, dev_name(&cxlr->dev));
>>   	}
>>   
>> +	p = &cxlr->params;
>>   	p->res = res;
>>   	p->interleave_ways = cxled->cxld.interleave_ways;
>>   	p->interleave_granularity = cxled->cxld.interleave_granularity;
>> @@ -3419,24 +3470,124 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>>   
>>   	rc = sysfs_update_group(&cxlr->dev.kobj, get_cxl_region_target_group());
>>   	if (rc)
>> -		goto err;
>> +		goto out;
>>   
>>   	dev_dbg(cxlmd->dev.parent, "%s:%s: %s %s res: %pr iw: %d ig: %d\n",
>> -		dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev), __func__,
>> -		dev_name(&cxlr->dev), p->res, p->interleave_ways,
>> -		p->interleave_granularity);
>> +				   dev_name(&cxlmd->dev),
>> +				   dev_name(&cxled->cxld.dev), __func__,
>> +				   dev_name(&cxlr->dev), p->res,
>> +				   p->interleave_ways,
>> +				   p->interleave_granularity);
>>   
>>   	/* ...to match put_device() in cxl_add_to_region() */
>>   	get_device(&cxlr->dev);
>>   	up_write(&cxl_region_rwsem);
>> +out:
>> +	construct_region_end();
> two calls to up_write(&cxl_region_rwsem) next to each other?
>
>> +	if (rc) {
>> +		drop_region(cxlr);
>> +		return ERR_PTR(rc);
>> +	}
>> +	return cxlr;
>> +}
>> +
>> +static struct cxl_region *
>> +__construct_new_region(struct cxl_root_decoder *cxlrd,
>> +		       struct cxl_endpoint_decoder **cxled, int ways)
>> +{
>> +	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
>> +	struct cxl_region_params *p;
>> +	resource_size_t size = 0;
>> +	struct cxl_region *cxlr;
>> +	int rc, i;
>> +
>> +	/* If interleaving is not supported, why does ways need to be at least 1? */
> I think 1 means no interleave. It's simpler to do this than have 0 and 1 both
> mean no interleave because 1 works for programmable decoders.
>
>> +	if (ways < 1)
>> +		return ERR_PTR(-EINVAL);
>> +
>> +	cxlr = construct_region_begin(cxlrd, cxled[0]);
> rethink how this broken up.  Taking the cxl_dpa_rwsem
> inside this function and is really hard to follow.  Ideally
> manage it with scoped_guard()
>
>
>> +	if (IS_ERR(cxlr))
>> +		return cxlr;
>> +
>> +	rc = set_interleave_ways(cxlr, ways);
>> +	if (rc)
>> +		goto out;
>> +
>> +	rc = set_interleave_granularity(cxlr, cxld->interleave_granularity);
>> +	if (rc)
> here I think cxl_dpa_rwsem is held.
>> +		goto out;
>> +
>> +	down_read(&cxl_dpa_rwsem);
>> +	for (i = 0; i < ways; i++) {
>> +		if (!cxled[i]->dpa_res)
>> +			break;
>> +		size += resource_size(cxled[i]->dpa_res);
>> +	}
>> +	up_read(&cxl_dpa_rwsem);
>> +
>> +	if (i < ways)
> but not here and they go to the same place.
>
>> +		goto out;
>> +
>> +	rc = alloc_hpa(cxlr, size);
>> +	if (rc)
>> +		goto out;
>> +
>> +	down_read(&cxl_dpa_rwsem);
>> +	for (i = 0; i < ways; i++) {
>> +		rc = cxl_region_attach(cxlr, cxled[i], i);
>> +		if (rc)
>> +			break;
>> +	}
>> +	up_read(&cxl_dpa_rwsem);
>> +
>> +	if (rc)
>> +		goto out;
>> +
>> +	rc = cxl_region_decode_commit(cxlr);
>> +	if (rc)
>> +		goto out;
>>   
>> +	p = &cxlr->params;
>> +	p->state = CXL_CONFIG_COMMIT;
>> +out:
>> +	construct_region_end();
>> +	if (rc) {
>> +		drop_region(cxlr);
>> +		return ERR_PTR(rc);
>> +	}
>>   	return cxlr;
>> +}
>> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
>> index a0e0795ec064..377bb3cd2d47 100644
>> --- a/drivers/cxl/cxlmem.h
>> +++ b/drivers/cxl/cxlmem.h
>> @@ -881,5 +881,7 @@ struct cxl_root_decoder *cxl_get_hpa_freespace(struct cxl_port *endpoint,
>>   					       int interleave_ways,
>>   					       unsigned long flags,
>>   					       resource_size_t *max);
>> -
> Avoid whitespace noise.
>
>> +struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
>> +				     struct cxl_endpoint_decoder **cxled,
>> +				     int ways);
>>   #endif /* __CXL_MEM_H__ */

