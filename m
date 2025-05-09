Return-Path: <netdev+bounces-189159-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE7DAB0CF3
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 10:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9F801897BAB
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 08:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B2E22D9FC;
	Fri,  9 May 2025 08:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XUOwtGhl"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2076.outbound.protection.outlook.com [40.107.236.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4A123F295;
	Fri,  9 May 2025 08:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746778601; cv=fail; b=u7jXm+Gd/83Y+NjCcqc92bOcsSLjhsbvSWf50GJLO0D2qPG6gGG5ZX7CoiL5gJV3iaiCedhsYWHviFpZNqdGSfzgD1eIsKre70yvLeMvqi0xyxIYJGKykWf8nW2cVb1JvoCQ5R4vann9gUskc+jpTMyMJMMroLwuA4LzxvykQeM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746778601; c=relaxed/simple;
	bh=N/YcA1cpooXQnlNGA1Ff3ACpa/JEkjIafkBiRRYxTLU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=n1eGAyrIv6cfGAKpWf6Fm9ICdu6rs2QVKp+I/KpZSVekLy8vTndn4Ji4a+G75WCIMR+di55f/zxTTCgHVhy5dPZ3qP7hvogUo0oHXPf+UY2bzd0ZVrkK2EiFNL/aMQg/kkj2BNxwzgUsxFAaSkJI6xewKkvVPuAQyGnHsPwD+1o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XUOwtGhl; arc=fail smtp.client-ip=40.107.236.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kxUwgNRLqRGJNOqKjNOVhIq3gOPEBBhZLm9XpqtI/wN8VyBzJVfOlR5rmGU9SzsdxTYBLkPwipfaIEY9t+MCmIPMb6o4+YvjLMLDgh/hOPQ/9BbVSgqT3TGIqgWvZOvrdl89yyae7zZwR3nKbdNO9XR55TEB/opyMaJHKhf89RnMtagBSvJSyLf0uBZxhqY7efQpiWyA4A+QhqLpN5o8rSyV6SmWqwzJnNTCZemlU8+wr9JGKFrxVTr33E8l+gCum0J2iAhC5YU9pc0jWIotJmo4T6Gt+lIv486Dqxab6eCvqExwP20j8oYtUtkSap8KGaAvUR0mutwkh3vIaQ0DfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ONv/2FayHmn5FIDdpd/7Sf+ah/z5gBDECLws4yLSvqE=;
 b=YzGQBSUIYiLok62Sherx/tYn2YoVMuDI1Py/x3SCdA28HSlHR3jsfXkACkVDxAUbako/dmE2E0J2dBeUkXjXjlXFm9W2Cleo6uaNVpQTqxTRhiH6U6iEjnRrBY7T3x9c7SrkJGbHTIcYlQKbZImEjbILcEO+Mtpcwz6v1Prz2s+aamP8h5tbxJ0siYHOq68efUUaTFPzs/2zkCxzX5nnZF9qPgkLD9RoUaRDf4gYU/hnRlcbqutFFUTemat0Pc73Yhoxnha5E+bcztAfYg74DBG3KpEgS7hlNM+maTz+5ePAh3q7ZAoMQb7AbsA5SAZHMmTw+Wi/vAG5LOd08TFGEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ONv/2FayHmn5FIDdpd/7Sf+ah/z5gBDECLws4yLSvqE=;
 b=XUOwtGhlTJtsxpO6aU+l/kDw5yMyM6JUg8cO0DBJFt/MqubjRtlFl8yPG/zVZsIDvaFY7zEGQSKbqJT7pQlFc9XzcGnIO+wm0dJ79XBJVuoNsHlWSVILAuYbdcQrCRlTkghvBOa8XhlUnoIhVF3e6znlh+FkriKlb3zZxWRYiAs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by DS4PR12MB9609.namprd12.prod.outlook.com (2603:10b6:8:278::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Fri, 9 May
 2025 08:16:33 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%4]) with mapi id 15.20.8722.021; Fri, 9 May 2025
 08:16:33 +0000
Message-ID: <6a341a58-5d07-4f1c-9680-b04030ecb172@amd.com>
Date: Fri, 9 May 2025 09:16:28 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 19/22] cxl: add region flag for precluding a device
 memory to be used for dax
Content-Language: en-US
To: Alison Schofield <alison.schofield@intel.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 dave.jiang@intel.com, Zhi Wang <zhiw@nvidia.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Ben Cheatham <benjamin.cheatham@amd.com>
References: <20250417212926.1343268-1-alejandro.lucero-palau@amd.com>
 <20250417212926.1343268-20-alejandro.lucero-palau@amd.com>
 <aBz19JAPxKm_XYRc@aschofie-mobl2.lan>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <aBz19JAPxKm_XYRc@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0235.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:315::12) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|DS4PR12MB9609:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c0f18af-f3c2-4120-1d9e-08dd8ed1ceec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aWlCVWxSajFIMnVjR3hVaWhuYlpuOEFiZmZWcUMrTXoxNWwrY1dOQnVKRmdU?=
 =?utf-8?B?bHBZNmNERklTT1QzVFFITjlCSjJiRkxlM0ZSNEJHa2RlSExxZGhMYmFBRS81?=
 =?utf-8?B?WlhqdVYwVTdQR2dLbmRIak96aTBKQkhhOG1iTWNWVm1WSnZIY25Wekl3aU55?=
 =?utf-8?B?UEVLN2UzQzJOWnhOMGErYldTcXNBZXVrRkloVXlNZ01ablZIa0tKQmM1aVF1?=
 =?utf-8?B?WVYwQVFqYlJUanFGMjhYa2VkUHNUWkZ1ZVdwKzYyMGgrMGl3M29BQTJVcXEv?=
 =?utf-8?B?aGZLb2d2WVRFQXNGd1R6YUUycC9mRE1heEpmR2xLQktpOVk1Z0pDUzEySjVT?=
 =?utf-8?B?eXlTN0FUanQwSkhobzRHM1NQcWlEM2RNclhzN3RCekhydnBEUC9HRUdpMlE2?=
 =?utf-8?B?dnNTQWk4R1NCM2xIKzJhSWF1Um95OUQvd0tuRmVYakNhTkk0VHR1QlIxSTVz?=
 =?utf-8?B?RXNqb2Z0VU9Tb3BIcXNDaEZ5UHdPQjV3WVFKODVTL09Wb01WUXdtMmRoV1Jn?=
 =?utf-8?B?eENwOTRMK3RoenB3NjhaOURjM1Fiamt2cUIxTGIzNU5oUklBTUVSNGFQbnIx?=
 =?utf-8?B?QXlNSHBzbGlwTzdlYTJMM3gxMi9XRXdYdjVxb2Z4bUhLMHFEbk9EMjErOG1j?=
 =?utf-8?B?cDJ1S1BTbXgzZWJyZFhBKzBFaDNrWHNBQUR3VXJCQWM5M2phK3h1QXhqMkNn?=
 =?utf-8?B?MEZxN09YaE5UUitubDBSR3Q3bkgxMCtCZjI3L09DV3dMS2FCejFldGlLMCtP?=
 =?utf-8?B?dUROSE9uRldyWkxScHZzRmlCZEhkWmNUNXUxWlU0bytwZXRZaWNqc0VLSFhs?=
 =?utf-8?B?OC9HM2hEWU96YVpVSHM0dzVQejJyczZZQ2t3UFVGYUh6d0p5TlJlcUVsK09V?=
 =?utf-8?B?NUpSY2lOSVpaVFhxL3RZNTRzYTZ4dkFNdGZjZ3FIblhmYzNpOXQ4eXBHdjFF?=
 =?utf-8?B?ZHhhQjN3R0N0NEtxRHY0aTh4L1VpNThVMkFRVTBKVldCbWp2MnNNckltN1Fp?=
 =?utf-8?B?dkxQQVRXeXZNNWZ5TXRjeHpRR0o1eGVSQXVTdTRCOHpDUng0WUc2NHdjdk12?=
 =?utf-8?B?RFRZd2hxSEZzbGNhT01IbUwyWVFrRkVzMzRzTjJ6QmVXSm9rajNkRlNWRFBi?=
 =?utf-8?B?ODI0NjVqWnlickZxZmU5K3JyWFJSNFA1N0g5ZVBWVUNHQ1FodkxsNjZ2Lzk1?=
 =?utf-8?B?WXd4bXc5ZlNSVTJ0NTFHeWwzckFMN0JrWlhXMHIxWmVhRi84QmF3Q0NHVU1y?=
 =?utf-8?B?WDVPbEczemkydXdNUTFNY1RVQTdQUCs5UmNUVFY4ZU53S3dlL3J0RnJONjFl?=
 =?utf-8?B?QTZldldmaTJLTEpYNzJhU2tlbDduUVphdjhlN3Y5N2VBZWxyUjB4MmtMbndr?=
 =?utf-8?B?Nm1kTE1Gc1lnTVo4L0pFYk5hR3grOXFIbkZyaTJKYmtCdzBGYUpTa3hyaTRI?=
 =?utf-8?B?SlpDOS9yTGNoWmd1OTEzNEQxWVhraW1KdmVWamd1aDFpT2t4amN6MDZUYkxz?=
 =?utf-8?B?VEI1Sk9UZWNiYkh4S2VYbVhxT0c4czFTTko5dkJ5TGV6WUJOQzFPUkZSekFD?=
 =?utf-8?B?MEw3eHRKRVE1ZE1COVJoVkNhaGo5d3VPRlAyYTV2eStybDdXalFkeU5FMkVT?=
 =?utf-8?B?RXhNenAxaHUwczZTSUJrTmZ2ZXNIcWFKRno2YWJZeEo2SVJHbkwzRWY3N280?=
 =?utf-8?B?ektZaDBlWFFERmdGUDJMd1RTV2wyanhIbnZTZFM2d24rN0Y4em5uRWlPaG5l?=
 =?utf-8?B?UlAvSnMwaE03Qm9ZQmZIYXBoRjM4OTN1ZTQ4bncrUVB6WDdlVTFOd3k4Q09V?=
 =?utf-8?B?OVZ1RXVCeHluRERiVkdtdDltRi9nVm1sN2E5a3F6VW9LS3laQTlRRXpRdWhM?=
 =?utf-8?B?bE5PdEwxSUFVcmM1V3RSQ20zMnFLTFZ3TUp5KzlLZjlpRHp1L0ZsVkZtcnFs?=
 =?utf-8?Q?dpWUH28cl/o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a2VibW93eG1mdzc2b1p0UTRnYXVDM1RVb0o3TWJ1Z0d1ODNkczNsc1VUT0lC?=
 =?utf-8?B?cXd2RUxzMEZBWFBVM2FFSVQ2akw2cVEra2daOXFoaVpraFlhWWt2VzdYbm9h?=
 =?utf-8?B?S0FudTBiNjhLMWNzd0tjVVQ1bHZXbEZzUjFSSm9PdngzTkU1YS9PVUU3Vkls?=
 =?utf-8?B?U0tkbTc1WEhxZC9WU1Y1UGkwa3liRUp0YmxkbXAxMyt1dHNCcTBFSFd4TEdF?=
 =?utf-8?B?RnI0cEhUajFldS9ZbGlmUFlqbGthcCtsNklydm0vTjhkbDF2ME04YXBEWTlu?=
 =?utf-8?B?ZW1aU0w4MGtUTlZTY0pTMU10ZmlqUlhTOUd2b210bGFZSlpiaVdvMDErZCtO?=
 =?utf-8?B?RkRRNTJ4YzM2OTZ3TDFDUTFyOGRnd3lCbmtTNEc4czdBYmhteDJYSlI5UTkx?=
 =?utf-8?B?SC93MUtRRkx4U1NQYzdPTjJHM2hOcXhpY3o5WlhhNDVYY0gyRXJJd0c1Mi96?=
 =?utf-8?B?NHZkK084bWRMSTV3d0JlWHpVNSthbDNQTE9qK2hLNkh4V3pWOUdPdldsTlNq?=
 =?utf-8?B?ZVpGMGIrNHU3ZlpuUU11Nmd5aExyNEZHbk5Id2lERE44SVdsYVdvcnVoUWt0?=
 =?utf-8?B?SVJRNFl0VGJFSnVPd2RzVGxBdExzNHhudjR3eE8yb01vSnB4S2FCVDRCTisw?=
 =?utf-8?B?YjgyNHpCNlVGVjdkUnppQ1JYSHZkb21qYi9SQThKZXZVSk5DRnEzSThEUnRw?=
 =?utf-8?B?ZFA4VzFVWlJ4bFliSEtTak9YbU9TL3Vuc0pESHJNWEF5Y2VaUFJ1OHpXS3Bs?=
 =?utf-8?B?a21YblM3QzRGUkxIejd5aWR6ZC9LL28zV01BV3J4Zm5sVjdWaFFUTSttOFli?=
 =?utf-8?B?emxiaHQwYjY5TzJnZXZtUHQ0L29WandHazdZaWNlVmtQS1lHN2Y4NG5adlVV?=
 =?utf-8?B?MlN0bVhXUGlTREt6cG83T2NkYk9lZlEzZ1VjYm9HS2wxZ3owVmR6YXBRZ3Fj?=
 =?utf-8?B?MCtvbUVoSW11NGVZOVFJbUFxdTFZRmMrMnhUbTZHeEJKL21Kc1ZmMHZ0c1B5?=
 =?utf-8?B?LzlaRWRsNDJ6Q2tLT0JlbnJVdzM4eUlhUU5mTWpGUnBkU0xNbFJkWjFEdGpw?=
 =?utf-8?B?NHBlbm1aYzkyalZWYVZSZUtSaGhoTHdhSDF2N3BpSzkzcG83MXgwMUpWbnJS?=
 =?utf-8?B?cVNOTW1DVVFMSi9oVDY4Z3pZZlFiZ0RUT3BRM0lTNW1WbzgyMytySTBsS0Jo?=
 =?utf-8?B?NGlsWEViOTZROGRncjVSLzBiMzlWNDd6V1hVRE92aDFhbGxtM0hxY0RPSS9P?=
 =?utf-8?B?ckp2a0x4Q3pLMGV5VU1tRFY5ejd4b3RVaGtnT0ZZeFZnZFE5K0s5QWE4SUY3?=
 =?utf-8?B?RmNhSDBmcmY2RzV5VEUxZURFdzkzLzlEWkdMMFJKNk5ienQ5NERqb3JwV2lY?=
 =?utf-8?B?TnBpZlJZSlFMalQwK1p6ZjU2SWdkMFhUMFhsTjU4c0hnZU41TkZsTVM2Qzdm?=
 =?utf-8?B?SllraE0relpBQUdIRE5VeGNhYmJZOTJhMVl1UDBQWkRQbjQyemh6TExLMmZl?=
 =?utf-8?B?aW11ekcwWktPdVdFdVJBcXRGZlNmWXhjTGhYa0NTcVpGTE11bzZKdkUrMCts?=
 =?utf-8?B?aHZOZ29UY0xGVjJ6MHdwTW90eUtZbEJ5QUJhVjJ2dmp3YUF5czM5UXd4S3FO?=
 =?utf-8?B?N1ZFeWY4NENTZVd2SkljUlFxQzBTMFd3Wjcyd2t6NXJBVC9NL3BIWGoweXJ5?=
 =?utf-8?B?UDIyUmwyY0FKQUlEQTlmUWNJK002V3RDVDhPSDY3NFpqTm9BV0w4bDdtQWxN?=
 =?utf-8?B?VW5YWDJvb1RoeUdLeW5WbSs0K0E4bnEzcWNBaUhCMFlIVG1tZG9RZUhaaHFT?=
 =?utf-8?B?eDE0aXRVSVBYNWtMWGI3Yll3OHpReVZZdEVGOExrR0hiT2YyRmcrdklTV2M4?=
 =?utf-8?B?R0VnTm9MaXYxalZCcVZwdnhBNDBtcjBGRFBLZXpnaFFtanlhR0RZckxtRHpp?=
 =?utf-8?B?SDRMdmN5di9LUkFnRTNzYUMxQjRPc25WT2F3eW5LdEgvRzlNVnFQVHFkQU8z?=
 =?utf-8?B?UEdYTWFTdVM2U3ErTXRPd3BxZVFkQlBVNXJoOXJzanRKY1ZrbmlCdkhmeGJN?=
 =?utf-8?B?Y3p0SE5pa1V0ZjdtRWVZY2Q0VzlsRW94SEtLZlh6UzdFRjczd1dJUVd2Q1h0?=
 =?utf-8?Q?3/GwOXjYgSHh8mMDSaQsI7AlK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c0f18af-f3c2-4120-1d9e-08dd8ed1ceec
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 08:16:32.9732
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ABUmvU9wZ4kqztvYg+86qO+V9Z7rsDSmsE5TPzuN1hUSeeY4uoU+Obietqjl2F6CkEab6xxA0cHo0kLxEDNwKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9609


On 5/8/25 19:20, Alison Schofield wrote:
> On Thu, Apr 17, 2025 at 10:29:22PM +0100, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> By definition a type2 cxl device will use the host managed memory for
>> specific functionality, therefore it should not be available to other
>> uses. However, a dax interface could be just good enough in some cases.
>>
>> Add a flag to a cxl region for specifically state to not create a dax
>> device. Allow a Type2 driver to set that flag at region creation time.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Zhi Wang <zhiw@nvidia.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>>   drivers/cxl/core/region.c | 10 +++++++++-
>>   drivers/cxl/cxl.h         |  3 +++
>>   include/cxl/cxl.h         |  3 ++-
>>   3 files changed, 14 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index f55fb253ecde..cec168a26efb 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -3649,12 +3649,14 @@ __construct_new_region(struct cxl_root_decoder *cxlrd,
>>    * @cxlrd: root decoder to allocate HPA
>>    * @cxled: endpoint decoder with reserved DPA capacity
>>    * @ways: interleave ways required
>> + * @no_dax: if true no DAX device should be created
> I'll suggest avoiding the double negative on no_dax and name this
> variable based on what can happen, not what must be prevented.
>
> Something like: dax_allowed or allow_dax or dax_ok
>

Not sure about this one.


IMO, being negative implies not to do the default action, as an 
exception, and it reflects better the point.




