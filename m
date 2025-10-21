Return-Path: <netdev+bounces-231356-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 322A9BF7BCA
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 18:41:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C19A919C3C62
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 16:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23DCB1C8606;
	Tue, 21 Oct 2025 16:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GjUZqukO"
X-Original-To: netdev@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012011.outbound.protection.outlook.com [52.101.53.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE2634A76E
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 16:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761064860; cv=fail; b=MYWkWsEPLI848G5TJaLWZhuMU6aXA3LcUBttLql+jzwFN1SUslAqKWB0soOTmU/rOprCcs2I4h2OcG84UD9Z9b9Vji6/xVb6jb3NdD0cvckZvHgTkOJ6d3tYDRzRKtmJIFtKNDEXli34FScumOMa6J0+KmbLLciorWQZFU9Zeuo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761064860; c=relaxed/simple;
	bh=lXsDdl/2dZu9iMB+kDFzsD+S4VocNeO8zqSEZhQ6Cpo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uGch8HJeWdBvrmkMy+o4/b/03E1n3casdvQ6zUXRbmZSFKFKyfewZ2z8hBNOt2pxnowp4wjqZwSQQrsnbks6qGNM1KllIPQgxwGBhU1XL+5YhnERCXoS74/wQc3jcsFj7NZvHkroetYp3PVBqgllBpzAc7Uh7UD9LDRxnq0Mecw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GjUZqukO; arc=fail smtp.client-ip=52.101.53.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aUq+7makWO7DXVLuedK6zMnv+SqRVgVcbdZhoooNMDLJPB0fJo3aVL/2XFmUxjbhlpv5hIk2kJ5F0U2k4f2GwQHre5Y93PwXl9qn4GCJY6MuCFaSnAqEqwjLRFfPXAkfbdbFtWAWxcY372Lbwm2sk2ulcQFJJ4P2XCpGe3GAu32Z7I8k1yv4jjfVR4oKlH94NB8TvdLjI/5zSfquEReO1OmIPWLGq2vv1dnxWnmqiqmNGmmo0tFmrGF3/wgGg9DA9H+HTPcDQh/RvgVvtZRb8Jo986dXgMu+MjQhbzzBAUMLCPHdgBN2aB5VWRD5BccPu6cYaWxT6iqeR1KIl14AxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aA91SiT6SidBPOBnDprG/c2r4YXlYy4VnltKqhFg1pg=;
 b=Vm5Vtmoz8URv1K22q/EJJgxVT/KMc6ptUMJhwH6xmf5/opgHGSM2uen8Tu1XBrBM0VTu+gXu6IfKH30Fhj0+816Y5vksDNmQcUv4K8P+Jf4hH8UPzyAYWg1GCiwU5gG3F5P8PrTi6BBL20zYxzU9gG5PvNjGbMBckMgqspoViOciD4knLuPqHmUX34GSMhC8kBq/uEYvYc7zRpzmOkAnzmGGku2ZgDpwBXPQOJxjG8c1zXz3d6vfbB8A6UsFMmnO9Xve0e0dLFZ5dezsHEALJMBTfig0xe8PzwXCrcSs64gtmkMuKhAM4vaPvdBn09fu8NU73bdEDXngFEqRn1IRNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aA91SiT6SidBPOBnDprG/c2r4YXlYy4VnltKqhFg1pg=;
 b=GjUZqukOb9SMTpoyL2d1pe8pAxpPwIoN9rRYCr+If54//rgopO3jn54XFqBkWxsb0ZTIqZDQG5M+sD6Gss8Nx7lc/a1eMkl+bpAhnsPnkNKDK3cbfwyvddOhWY143fI6ZR6eUcCueGP7OsbUNYhkAJCzsPFZRESSUAyTO+qbaxA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB6395.namprd12.prod.outlook.com (2603:10b6:510:1fd::14)
 by MN0PR12MB5761.namprd12.prod.outlook.com (2603:10b6:208:374::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.17; Tue, 21 Oct
 2025 16:40:54 +0000
Received: from PH7PR12MB6395.namprd12.prod.outlook.com
 ([fe80::5a9e:cee7:496:6421]) by PH7PR12MB6395.namprd12.prod.outlook.com
 ([fe80::5a9e:cee7:496:6421%5]) with mapi id 15.20.9228.015; Tue, 21 Oct 2025
 16:40:53 +0000
Message-ID: <53151eb0-5c1c-47a1-95bb-2a6654d5d230@amd.com>
Date: Tue, 21 Oct 2025 22:10:42 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 2/4] amd-xgbe: add ethtool phy selftest
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, kuba@kernel.org,
 edumazet@google.com, davem@davemloft.net, andrew+netdev@lunn.ch,
 Shyam-sundar.S-k@amd.com
References: <20251020152228.1670070-1-Raju.Rangoju@amd.com>
 <20251020152228.1670070-3-Raju.Rangoju@amd.com>
 <ba2c0a35-eaad-4ae7-a337-b32cdf6323c6@bootlin.com>
 <9ba51a79-5a0e-42ab-90aa-950673633cda@lunn.ch>
 <563f3f1b-985f-4a9e-a32c-cb8e9b6af43a@bootlin.com>
Content-Language: en-US
From: "Rangoju, Raju" <raju.rangoju@amd.com>
In-Reply-To: <563f3f1b-985f-4a9e-a32c-cb8e9b6af43a@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0088.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d8::9) To PH7PR12MB6395.namprd12.prod.outlook.com
 (2603:10b6:510:1fd::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB6395:EE_|MN0PR12MB5761:EE_
X-MS-Office365-Filtering-Correlation-Id: ddd062fe-481d-4b94-f487-08de10c0999d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SjBaKy9Ea3lkWVRqUHdEN3F2M0lTckYrb21YNDRmT0paK1JnTm96WHpPWlMw?=
 =?utf-8?B?SWVDSFhCbHFJVVpMbXhGQ251RXdIa2NmRUh4Sjc5TFRxd0tubGt6b0VsREY4?=
 =?utf-8?B?V1hoblFMcjBFQnUwS1V5RlBENFRGdDRiT1RhTURoazRGckoxNTdnTXV2UENi?=
 =?utf-8?B?dDhkd0dJV1Y3Mi8zN2NLZlJkV205Z01OaFQ3bDYvL0ZBQnVYZ2RLS0t0TW9F?=
 =?utf-8?B?K2ZEbXV6cVAyT0k5OUFaNWJuc0pib3VvcUpaTlZYWnBoM0VzQzdLOUdoZVhF?=
 =?utf-8?B?OFB1c1p1WTNrRkdLTmdmc3ZuN1VweDRKTVU0b3dmR0JnRnc0eWhpdGF2eE5Y?=
 =?utf-8?B?cUdwMlJrcVE5UnBCZ2llM1dFR0huRDVnSlU3cWEwV1pXODhid2tYNU16MEcv?=
 =?utf-8?B?NDBnM2hBald5UXlLWUtvSXdKYXJteFA4MXErRVhFYVJ4QzdsbU8wZWRuVmFk?=
 =?utf-8?B?NkcwTU1lSE10ODZqUmk5SlI1V0ptUlBXOGk0bFB0elFwWmNnSnErUjRSY1Vr?=
 =?utf-8?B?VnVQb1BjV3NHemdWRElHQUJDWjdpa3RtVkkzYjlyUkJhY01uejBSa3VhSmtE?=
 =?utf-8?B?REpNb1BRU21TM1NhbzBJTzlzcnZsQ1lVcjB6bGJ6eVgrZHROQnRUZVNYVEVV?=
 =?utf-8?B?Y2FxMzJ3MzJVU1A5eWYyNlZIMExidUp0RStuKzgvclF3TEpGMTJZclRkNW42?=
 =?utf-8?B?Ky9IT0tHZzhRTlBieWRFaXBPc0psTVdyYmppcTMxZlZ1azV2azd3QkZIQzdX?=
 =?utf-8?B?ZDluVC9wcVpiaWNvWWdkSll4ai9oOVZhOTN4ZlIydFovMkxhbTVKVWRvNDlF?=
 =?utf-8?B?OFRYWjNsSVBlWGFVU0lXMHBFL2F1bE81WVpONWFnK21HSSsrLzlWSHMxNG9j?=
 =?utf-8?B?cU9vUnRzYWx0S1Z5WjlqTzQ0bzJOZXl5cFlORVpVaS9NS1FQSmxqSXpORDJo?=
 =?utf-8?B?VCtyVTN0S3NPRUJrZm5tWlJJWk11WlpTQ1dOV01Xb0lNT1EvQU1MSmd1Skdn?=
 =?utf-8?B?eDNhNWtPSjRuTU1WUDJwVDJKdUp5WldCQmltZ1FIdnpJZEFwS0g5aEZkOHlr?=
 =?utf-8?B?QTBjUFNoc0pTay9OOUIwdzREUkpwL3JVRnM1QTJ1RWJhVDlURnI2Ky9ER3NL?=
 =?utf-8?B?Y21rS0hja1dpYVhWTzAvTlhQdmR3akMvN1hKLzBRL2YwZjJLR0c1Q1U1clNt?=
 =?utf-8?B?OHNHeGNjQ1ovNjJLVmxDeGFkdG1tRkNiUjd1TkZrb0RHeVZDVnFvTGtxSlpl?=
 =?utf-8?B?a0ZEdHI1U0ZnR1E0a3ZqdmpZL3dNTkk5azY0eUtucmEwYUJ6V1I5S2NTaDh5?=
 =?utf-8?B?UFE0bC9ZZ1pCMHlkTEE1UGdlV0xKd2dFeUc5a1l2bzlUTVBCTFE1VHRsdnNt?=
 =?utf-8?B?RVRMUk1kL0tNdSs5YlA1SFVXUFoyeFFHWGxjWXRWbFdaZVpBNFpLRTZEdkhB?=
 =?utf-8?B?YWU2YitEc2x1VmVzeGlWZ1NkMTN5MnhhbURxUHI2a3BVcHdQd1hUT1A1T2ht?=
 =?utf-8?B?Q3gzWEQ2YXgwNTAwS0ZXbUg2TnZZZmtVWC9sTTZ1NEV1aWdtdTNPOWM5clBP?=
 =?utf-8?B?QjJJem9jWGpQcW0rWTk5NjBtN3JMcjlVN3h3MklvdXpPN1IxZFFSaS9hVVUv?=
 =?utf-8?B?YVk4Ym9yUWhXdm8rZ2IvSERtdzBDeDZoTmZ6aG8zQkg4bCtkOU1oSjExaFl0?=
 =?utf-8?B?SGlFaWRyZ05YalljVmpHV2w0RkNjS1J6QURiZWRwUGwxRHVqUUt3a1cybFhk?=
 =?utf-8?B?ZTkxV041bC8xWmJ3QWNtZG00NTZ6R0NLck9EdkhvZ3k4QllEMzZzeGJ3Y0ZZ?=
 =?utf-8?B?V2dWQ3FqOXRUNk0zMWRjZUVnR1BoMmRCNDExczVQSGtIemJVRmVEMnAyVVY5?=
 =?utf-8?B?b2pFVXJJa01uK2cwOUJZK2wxem0vYko0ckx0RGZ0aTZVRVE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB6395.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L3RPMWQ4MFNJOFd4d0xJdE1mbUNpb1lwWTAwT0RONmpRQXh6NUd5blBZK2kw?=
 =?utf-8?B?YjRSelBPT3ZGZjQ2emhZOThaRkRTa0ZvMFN0Z2xaNE14dkUrZnNHMjNYSi95?=
 =?utf-8?B?aXFoMTlWVWgrOGNqc1UwZkpTajM3aElrNnQ4NnUvcStlRTBmeVBXdytjbzgv?=
 =?utf-8?B?Nkk0WkNnZ00razlJTzUyUVNTSWZDdXVxcU0wNGNZWW54aDliYi9EQW1HSnIw?=
 =?utf-8?B?d0NGL3hWRVhDTlRLamkyUkJhMGRKVk8rVW9EVU83a0NVWTJqMGF5VjhBVUtK?=
 =?utf-8?B?NzVwakRBR0pMcFBDSDdKSVdONjR5aCt1WUhleG5kOEJGdmpvYlJYMG5PeE9Z?=
 =?utf-8?B?eWFGenVEdkxjakk2dE9BVjFrZ2IyTXdYWm0vaDF0MWNWWGJ6NnBXaHpWLys1?=
 =?utf-8?B?RXlYZWdmSWY4eTQ1TmVmQTlaRFVieTA2Z2pOSWQ2SFZtU2x3ZlJkN1BaZG8v?=
 =?utf-8?B?MDR2Q3hSSkIxbXVzc3NOd3FEVzNvNE1UcVJRajhaMG5hTW44ekJkeVVpN2hT?=
 =?utf-8?B?TFlHRHJYVEhFRmY3SWVPNW12WXlONjRFTXIzQnVqNzFkdzE4MjBSL21LNS9u?=
 =?utf-8?B?cWZWNy9MRityUjRkVC9JUXlmeDZIbS95Q0VEbW5kOEp5aWtuNitVRWVORnIw?=
 =?utf-8?B?VENDYzhpbmEvcStjNjRjZHhqR0ZzT2JGYURVdEdXRXRoMXd5NG5Jc2ZPcE5N?=
 =?utf-8?B?REdONm5NU3BGMDB0QTE4UEVRN0dFQysyRXYyZkRsblJBZkpscDZGWUI5OHlj?=
 =?utf-8?B?MW83RlAvTmFDblFTeTc2L0g5V29WaWMwemNLS1lJL0x2YjNUbEw2OSsrc09t?=
 =?utf-8?B?Y0MyZmFSaUk5Syt1MTBNeEtiaGhPTCtSSDdKWkRyOFZ0M3pxK3hhMWZwUThh?=
 =?utf-8?B?T0pjWkwrZVZRdVczcVFJOUFRSDlOWnZDRnJ4S3NhcHptTWswMXJDYXpRMU5l?=
 =?utf-8?B?NERPZVhqaU51TlV6eDRVSTQ3MU5uRE51ZGdPM2xoaFF4amFKZ25uNE0rbEtW?=
 =?utf-8?B?ak00ZHViSEc2cGQ3N0NuUHR2VTZHL3lPblZkSytiVWpiNkFGcHM4TUdTcXl5?=
 =?utf-8?B?cCs5UWhQSklVSWJqazVXTWVpZkJBRVFDLytnR3JRTFU1MHlaazg3VCtiMjNY?=
 =?utf-8?B?eCs3dlh3bW5jTGdLdWRxeUtvZFpmdkNRMXMyTWhtblZnZk1ISTU5c2lKQk41?=
 =?utf-8?B?dlZHaTdNbForb29KdUwwMDF3b0phOUdicXVTUE11aVlsbldQamJCZ1F5Y3lF?=
 =?utf-8?B?ZGw4NkR4Y0NhOU9rbWNkRlJUeUlRVmRobWRBbkR1OVA0RlZQWHpwK1ZPZ2pO?=
 =?utf-8?B?QlBzVnpYTGdYNzJCK2NidGkrZmdUZ1pxSzlGZmRQSnNsYWRWNVZ2eUw3RVhu?=
 =?utf-8?B?S2N3bDJpOU56b0hQaTh6aEc4R1B1V2UzRlgrcld5ZXJtbDhzclk4d1dqSEYw?=
 =?utf-8?B?T21YdFVEZXB1OVNYdUluVWU1UmFhOThZUU1ENUFzMW1vbkl4RUYyU1R1NEti?=
 =?utf-8?B?K0YwYUI4RWRQK2NXVTA5UDBZUnE2Tk5rWldrcjV4djQ3NG8vYzN3VHVOSklq?=
 =?utf-8?B?c0dPYTFicTdaNk1qUEM4TFNaUnhVTW1UM0JOKzR1bkRQQkZ5TE9oK2ZPblVQ?=
 =?utf-8?B?R3VvMDVIZXVTWm5HQ3lCcmxMZE83UHFrWlQwNE1jOTlieVRBOFpqVENHQi8w?=
 =?utf-8?B?UjlMNjIrc0FnMDBPeWJCck14Z2ZYUjRKVkhrTDBGSEJ2eXh0NlVuM2U2d3E0?=
 =?utf-8?B?WEcwUUJyOVlzZmtLZHZCYzgzU2NjeU1QWmVWLzY5R3g4Z0JDK0wzdmN6dDdM?=
 =?utf-8?B?TDFQamJMUjlLL3h5RDNzREJ2eVNCMUo1NG4xazJPekxyRFlGQURlWEpZamFI?=
 =?utf-8?B?cW1tN3NFSzIzb2taZTQyeVgwNmhMWHZoRmhsT1oraE42ZGxoZ2RyL1Vla1VP?=
 =?utf-8?B?cmoyaU5RcDRxN285bVhXVlNYSWUzWit1M24rd2c2R2d2M0d4VU5ORHFSMGla?=
 =?utf-8?B?OUpYZDltUG5yOUVwZER0eGk4VnZ6b1V3LytmVllKNjlDa1ZvcXp1Q3pzY2FV?=
 =?utf-8?B?bWlsZWpzRHlyOFRVaUcyOWRwRVQ3N3ZHRHg3MmRyNzlpSWpFTGw1REhQSTVs?=
 =?utf-8?Q?MslV9WzpP3mKyZpPd7F875ZCT?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddd062fe-481d-4b94-f487-08de10c0999d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB6395.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 16:40:53.5362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ek69J8Voa8d7/Ay7bIAWTqw3flKQEnjsqcRfNvy0Or7YgunZROx+nPc2fIrM9MMID9SIa9oMWs/0Yt5ot1JR5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5761



On 10/21/2025 3:02 PM, Maxime Chevallier wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> On 20/10/2025 21:07, Andrew Lunn wrote:
>> On Mon, Oct 20, 2025 at 06:19:55PM +0200, Maxime Chevallier wrote:
>>> Hi Raju,
>>>
>>> On 20/10/2025 17:22, Raju Rangoju wrote:
>>>> Adds support for ethtool PHY loopback selftest. It uses
>>>> genphy_loopback function, which use BMCR loopback bit to
>>>> enable or disable loopback.
>>>>
>>>> Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
>>>
>>> This all looks a lot like the stmmac selftests, hopefully one day
>>> we can extract that logic into a more generic selftest framework
>>> for all drivers to use.
>>
>> https://elixir.bootlin.com/linux/v6.17.3/source/net/core/selftests.c#L441
>>
>> Sorry, not looked at the patch to see if this is relevant for this
>> driver. But we do have a generic selftest framework...
>>
>>        Andrew
> 
> Ah ! And this also looks like this driver code. It seems to me that the
> main diffence that the amd-xgbe selftest brings is the ability to
> fallback to MAC-side loopback should PHY loopback fails, so they don't
> 1:1 map to these, but we could consider extending the existing selftests.
> 
> Besides that it seems that the generic selftest are more efficient wrt
> how they deal with PHY loopback, as they don't re-configure it for each
> selftest.
> 
> I don't necessarly think this series should be reworked but this is
> starting to be a lot of code duplication.
> 
> Raju, maybe you can re-use at least the generic packet generation
> functions (i.e net_tst_get_skb() 

Sure Maxime. The net_test_get_skb() is currently not exported, let me 
see if these can be re-used.

Thanks,
Raju

> 
> Maxime


