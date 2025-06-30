Return-Path: <netdev+bounces-202540-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB4EAEE32A
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 17:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D04723A32E9
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 15:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E2B128CF5C;
	Mon, 30 Jun 2025 15:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="g5MR3qia"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5805F1BD9CE;
	Mon, 30 Jun 2025 15:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751299060; cv=fail; b=Lj+Q4LulxuwszeYQ+xjcMxmWnkeltXvNHYUBB8nQOOo3piZhlaqJ+DHXYR7cLI+s1J/So5XNjGpLUr1g5EXfD+n+OfDuerNCf403EPqea4JiXtC6Z39yBPDPmDr4U4/HZmDOW1VVKmZfVL9B9tVcU7TxwpXDL4NnHCtuYnOehNc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751299060; c=relaxed/simple;
	bh=MgbbLZK4aiW5SQ7nGlr1wQbnksABR92/3giibu3ey+g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GfvPw704Mln9Ok07id6c+L8lR1pejPVt4hR6HrMxk02tiINJEBxZCQjti+mmnook54ZIKP+FPkjHBaGzu7kzC4zOEoJghoorenzYQGojUEw5VdgRfPbl1d2vjdmEbjw8snRx0nP4Hm1Gbv1D6BizrzC9+TfCRbWvyRGFecPUZrU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=g5MR3qia; arc=fail smtp.client-ip=40.107.92.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DXi8smfByKaVNt3c4t4QO6JzOQJn2tKtydQ0RYOWXWubJyTHa4irsmu2tiIl6wuvj3mSFkjEgMoErKI65Ro3MnfMMZyQR+83cS38oJJt53pr3XRiiR2bC15CzxCCGOZViTkHATwxNxdhJfMGiYRZtR/kf6zfMt0motoa+2k4bB41iSLCv5nAWVf8LrQkmayanvtUD4UR2xnEXTRa1H6FWCW3JJrehz63EXX0EP9u2PLosG2JSMNna+hvbC0A11TqMKkwDLWO6TGoDX7142AjbDwqQF41dwPvEMb3sKt8/Zewsc1goY/99EQ+4nnhouBgCbWbOXLhYDQYaRjY6KsA/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YkkHnOkQzcN+gPUTqFanYU8LI43RfpOZXIDvddOgtRw=;
 b=tIjD21oryzZqUKSKmY4+J5P88TK2fb05ucMfzS0o8pbiOCIoYuyZPYyfESubqnf2aCl+4MAIYQfmE7MQAY2sRwgdCC9BYHkC7/C2wsNUruJrPYmcCyQYXVej7686eLwsnwFCBnT0jL/2U55JF2vOzFn9X8qY5RBlk/Xg2wkgf6Ea92S1/3o0ruOTTdyHDofeWW3aIzRuyFNnqDi/pTohgy0xXxFYHtdkyFmwtx7ELEsiKoKx1aarpWHfYWwZA40ifutVZN2MTTMCOJJ+je12unpxM3ObzJ6NfXcqso+QPKvfpxDqlA3hCMIIYNfxi5LpCapb5zOQlF4Ma5IS0BJrBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YkkHnOkQzcN+gPUTqFanYU8LI43RfpOZXIDvddOgtRw=;
 b=g5MR3qiaUPogzUguRNx26w5PVRuBDi5nUyah+Q9vkFH7YDwrFOwTbB9mCUgKK9MGey+aH14f2f/LnCJfTH8WopKErxytLBv3b9CWvZvip+kqsGNRYQTo001JPplSRJQrwzktQKeT3IAzWEHsFkwgFCX46gzzvSP5kwJfk0dVXTE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4199.namprd12.prod.outlook.com (2603:10b6:610:a7::13)
 by IA0PR12MB7697.namprd12.prod.outlook.com (2603:10b6:208:433::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Mon, 30 Jun
 2025 15:57:33 +0000
Received: from CH2PR12MB4199.namprd12.prod.outlook.com
 ([fe80::3cf3:1328:d6cc:4476]) by CH2PR12MB4199.namprd12.prod.outlook.com
 ([fe80::3cf3:1328:d6cc:4476%3]) with mapi id 15.20.8880.015; Mon, 30 Jun 2025
 15:57:33 +0000
Message-ID: <593e126b-7942-484b-bdf3-2f8d25273f31@amd.com>
Date: Mon, 30 Jun 2025 16:57:29 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 05/22] sfc: setup cxl component regs and set media
 ready
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
References: <20250624141355.269056-1-alejandro.lucero-palau@amd.com>
 <20250624141355.269056-6-alejandro.lucero-palau@amd.com>
 <20250627093923.00004930@huawei.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20250627093923.00004930@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZP191CA0045.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f8::12) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB4199:EE_|IA0PR12MB7697:EE_
X-MS-Office365-Filtering-Correlation-Id: d6fd55fc-452e-4f64-fae1-08ddb7eed305
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M3BGM1Vmck9VMUd2Z3E0eWhJZVVDUFMrYmU3SkZyaThuSWliM2Qzd084S0Y0?=
 =?utf-8?B?dXZOL01Zbm10VlJMSUttQUUxYTkxWUdneStFSzd5eXJHWGppdVRqR2lFVnJZ?=
 =?utf-8?B?dmorYzEvMXFOYlpxcmJ3andEb2kwa2dMb1pvdWt2cmE4bENFRXdXOUlGOTQ2?=
 =?utf-8?B?Rzh3K3JGRTdJSlRaQXpOeEZaZWNjak9iY1dja1R5L0cvaHl0VGlpMWRWQ2xn?=
 =?utf-8?B?cTN0eU94TzJqSzhkOHByQ01qdTVNUDIzTytTWmM0dDRGQko2MXoyblZNcFFr?=
 =?utf-8?B?NjVFRUF3NjJId3dLWkNEY1lXbWwxVytHT3ArTS9wWmR5WEhqQ1NiZi9EUzYv?=
 =?utf-8?B?bDM4RmhWb3VUOUJKRUZqK2xWUDY5anFwSWlTVHRGZnFqWWExSm1UOWxQQlNt?=
 =?utf-8?B?M1ArYXQrTmF4akxvUGFtbVV6U3p6Y0VFUnYyMUdxQmZWMlJzbGd0RGQyUk4y?=
 =?utf-8?B?b1JqMHN0L0NxcEdPZkhjTDhyekZhVDNEMTJrUDcweHpxUUJSbWVmTEVmVnZm?=
 =?utf-8?B?VlRIcngwOXIyYlRCMjJ0cGdPOFYxek5aY0hZaXMwWEJaSVpLNmRnRjl2T3py?=
 =?utf-8?B?TVdvdnFNbzdwbWdEcm9BYUdWYWZCb3l6NDlyeUR5alh3bEZHZ01ZUFJ1bEZ2?=
 =?utf-8?B?a3VYVWpHMzBYU3g1bTd1SmdmaHBKcHA4bit4WEV6VzBjazBySGZxUmluQTlH?=
 =?utf-8?B?MnRpcVhxUzF6dFgyVWVWNFBoaHEwbmFNRXkzQVNCeTYvWmQvd2hwczRiYjY3?=
 =?utf-8?B?NHQ4THBmTVlxWU5NQ3BucEpScjVFZ2VGTzEvL0ZQRk9VOFBQa0hMVVpJQzFu?=
 =?utf-8?B?ZHpYWFB0eVpVbjlEK09oU1V4akUyZWJYWUV6dWhNMEVsYXVEZEd2RTdleXNz?=
 =?utf-8?B?STQ4eTJucncyN25JOWtBQlJyb2cvV1o0QmZCYWxKOHJvVi9Wd3FndGpGVmFK?=
 =?utf-8?B?RWdzK1JGT200Z1FXSmJtckJlcWpOSkM1NVhsNk03M09FVmwyU2o3RDlxVjZ0?=
 =?utf-8?B?dm43NWJJY3FGN25NZlM3RzZlL1BFbHlqOFNMeHUvczRRWU9BUjNwLzQwYkd1?=
 =?utf-8?B?Q2t4dUN5REdTdnZFVWtaaHJhYzBzUlVvbDFCZHRxSmR2MmNNdkszc0xSSjJT?=
 =?utf-8?B?UHRLeVVVdVN3TUdqdXdvUFlLTzhoYjNlSVdKTnNReGs5RjZvUFV3UlpBdTVn?=
 =?utf-8?B?Vld4ZlV6cndEQ3hVUWtwMWFGUU9BNXExeVRwR0RLWW15RGFmbmwrK3JmcXgr?=
 =?utf-8?B?eXFYaXdhanI2c3ZYRXVvSisxcXgxU25RWko0ckM4QkRSNkxBa0FKVDdncHNO?=
 =?utf-8?B?RllHTGFSVUVwemlPbytmNVBQblcyMSsxMWJkSnVOK0xTVll1Rllqd1Jib21n?=
 =?utf-8?B?K003K2RRUHhyby9Qek5XNjdVRStTZDV4dW5vMzh4Y2xJRk4zZHRmWDJlS2lE?=
 =?utf-8?B?YUtCd2hxVVNmaUFEU0tJZno0VzZqUTM5ZVhRalRrbzM0YS95UVhXT3A1SzMx?=
 =?utf-8?B?Rm1tNjBZRVVScnBEYmt1VE9CdDk1bUtNRmZWdHJ5NVV1c2VsRmVuaGxEclNn?=
 =?utf-8?B?SHNlcjlHSFlYK0lYL0E4Ny9FNXdpamsyWmVCODBTU29URXZNVWgrZmIyTmsz?=
 =?utf-8?B?MzkyTG5Xb05nWnlidGQrK3dqUndLdmtOcGoveFhiSW8yazExRENpSUhId0Qw?=
 =?utf-8?B?dXRRWW1xRng0REFONXRaUlZ1QUFtYzVMNVpLWTFCVzFGNDFncEhtSzVLOVVR?=
 =?utf-8?B?cU5mZUFnNVVqZzltemJxRzhiV2xObi9aWTRlUzVLcmd0aVhMUGxHTDRVUmJ0?=
 =?utf-8?B?UkpvRkZYeS9Za1BXaHZUZXlFVmptTlZWb0p4MWNkbFdabkcxaFl0T3czaXRt?=
 =?utf-8?B?MnhZcWVGVWdqUTlrMkZQZ3BUZ1laaVVmODM1eGxxN2FnNVE1ZlJuamxvSm9D?=
 =?utf-8?Q?/IDjX/kBPW4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4199.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TEh4SS83aGlWTnhlT1VORXNjdktBNVpSb2xzWjgvK01FUnh3b2Z2VkpDY2l4?=
 =?utf-8?B?MUpkLzNNTUVkQUUzcWN4VWtYd2NLREx5bVJxN2RRdnBxS095VFlJZG1FUjQ5?=
 =?utf-8?B?blBmRGdhSU0zck1KVVVkZWpCbnhEVkRNbm5ZSWlZbG9ZMHpOR2RRbUllbDBj?=
 =?utf-8?B?RjJZWCthRU1KL0NIbXlLN3I1WWlzbnJwK2MwV29KL2pGcER5eFVydVUra3Iv?=
 =?utf-8?B?Nk14VGpIVCtCaUwvdm5DOG5NbmZDamtpbHVIVU9zV05TZm5wdWFXT2l5OVd6?=
 =?utf-8?B?bEVSYlErNjNtZDhQZGxpQnpGRHpQdHJJb240dmhvZ1AzdGMyRmF0MkRUc2xi?=
 =?utf-8?B?SHZqbFZHcHVQWEFNV3Y4VmMzTFoxalJ6Z0tzanA3cUdhUXM5dkw3eVpHUXor?=
 =?utf-8?B?UzBNVHVDdnR6ZHhEcW83QmR2R1owaE1GUDFyek9vbVNnYzE5UTJjb2ZFNW1R?=
 =?utf-8?B?RzhSNWxJMUZ6c1BHSDB5QUJTOXFkTlRKRE44ZlprMHNNOU95SUFXZ1RZL3ZS?=
 =?utf-8?B?R1lEZlorQXdad0NreWgwVjZMa0Z5Vlh6WWYwSmt6cHJXUkg3by85NFJLZWpQ?=
 =?utf-8?B?RzdqTE5UR29yc2sxUlErOUgwWjlXQUJhckg3N2hDZFJKVXJaY2hQcUg2ZXVj?=
 =?utf-8?B?Q3p4V2w0K1FqS1JGMFFxMnFldFR6amhZdlJJREM3Y0lWTUl4L0xmbWhzdDJU?=
 =?utf-8?B?VUVsaW1FWUZIY000MnpmR1Nzb1krQzRLZ1lVK052Q01DRkxTSkJ3clNYWnQw?=
 =?utf-8?B?WFBvK1pqaEZteDhwVjFBdlMrcjZxVFJHVWRweldLVzZzVFNWRHdWWGxpK2tp?=
 =?utf-8?B?OVBIY0FzeUg4TDBYVzhuVzJ3cUpBejlxTVhFOHpDSUJvS3VIYkxLQ0JPaklQ?=
 =?utf-8?B?eGJabllOTDI2aHBlWnZ4QzJ0MmwwUlRyOWhOc2REcWtqZ1gyc29pV1VWK2Nu?=
 =?utf-8?B?M3F4V0xpT1JIaSsrdi8rYU9VRVFWbm01ODFIUnpiNnRVMEdIOUpjTjZsRHV3?=
 =?utf-8?B?UTlCbGRNM21sVFZqYzVEbVhhdTkvNkF6Y3dQd1R4anNUS0s5SU1lbW1nY1VT?=
 =?utf-8?B?N0lwL3QyanAwS3NnanFhaENQcUwxdmluK0Iza0pZS1I1RnNROXRwa0UzS3VH?=
 =?utf-8?B?QVgvK2ZUK0hUT2s0dnBocWRJbzBxOHpndjJ1dTUvQUc0UHY4WkVEVldxRXRP?=
 =?utf-8?B?K0FFYk9EMGdDQ2dUbkJ4OHJldDFINWlwVGNBMHR4b3FVV3lzZjYwMm5sWm9y?=
 =?utf-8?B?ak53TngycHpxanJPWXlNVy9JMi8rdnphUno1bmdpS0ZTRU5oSFpxU3QwZ2VL?=
 =?utf-8?B?VjAyeTIyVElCM3UwdWFNOERlbHd6OElnc2N2RFF6cHNVclNBem9rdVl4ajZ2?=
 =?utf-8?B?MHVLRFpTY3RaZm1yMjdUTlEvckYxYkE4SUQ4ck9jR3Qwbm9uaHNhS082OFRi?=
 =?utf-8?B?NUtvekQzOXpqTjYySzBjVDRUdThCbm5tOGRtY0ZnWDF0YmZXd0tnUVY2T3o1?=
 =?utf-8?B?WWRyOEFWQnBINjdIYzhiSm8zNzhOdnNEd1pRMTRQVkhNaXhNeDNTYVlaNzYv?=
 =?utf-8?B?UmgwcUNNZ3VoeFp2MHdHcTl5bFhKNFNZWEdSRVROY245ZmdwN1hrMXkrRWtN?=
 =?utf-8?B?azNBVnk3dWZ3dEZ3d1ByakhrdSt5YlhTUWFZR0wrLzRab1F1TWxGY0NkL0FW?=
 =?utf-8?B?WTNJN3pmVFRVdnV4Rnl6ejJOMm10aTJyQ1AyWFljemdjc2xRcFJLNTJvcUpH?=
 =?utf-8?B?c2VBNEYrSmtlMXUrR3ZrajEra28vUXVDaG5aNWd2QkVDNU02aG5SbHo0czdL?=
 =?utf-8?B?OFRqVGVPbE82SkpCbHVFVklKblJPU0ptd3RqbEZmQ1RrV1VTa1QwTURQSjJ0?=
 =?utf-8?B?VnlJR0ZOOGRrcnZlVFpBSWs4QVZoNm5rVk1NaTE5cDRCaWo2RFZZd01oV2dR?=
 =?utf-8?B?QTdiZk8wSjRGZlBxczJYNWM5dWIzcGFud1h2NE55NmdhU3VyRHkvWHp1VTAz?=
 =?utf-8?B?Yy9KL1JoRlVFc2FsMzh4NnlMMHpjM3ZVMDJXc0FkMDlZTEc5NTI2aVk5cmda?=
 =?utf-8?B?VnhVcFRXcDAxU2Nxakh0VnVzMHN5eHRhdVZIbkJUenh5cUw5OFNQYTcxN3la?=
 =?utf-8?Q?+ngOYY/ondtU97xOu649ZbzyG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6fd55fc-452e-4f64-fae1-08ddb7eed305
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 15:57:33.2350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1YTF9qSHYMEkg5UuJq5agSl6QDY8bDJSUs0WOhzUHbJvBV+oxcY/PflAifph9Kr2flc3XSy9XSXtmVdj8+3TNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7697


On 6/27/25 09:39, Jonathan Cameron wrote:
> On Tue, 24 Jun 2025 15:13:38 +0100
> alejandro.lucero-palau@amd.com wrote:
>
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Use cxl code for registers discovery and mapping regarding cxl component
>> regs and validate registers found are as expected.
>>
>> Set media ready explicitly as there is no means for doing so without
>> a mailbox, and without the related cxl register, not mandatory for type2.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Perhaps add a brief note to the description on why you decided on the
> mix of warn vs err messages in the different conditions.


After your comment I think such divergence needs to be addressed. Using 
the warn comes from the cxl pci driver, but it is a different situation 
here, so dev_err should be used instead.


>
> Superficially there is a call in here that can defer.  If it can't
> add a comment on why as if it can you should be failing the main
> driver probe until it doesn't defer (or adding a bunch of descriptive
> comments on why that doesn't make sense!)


Commenting on this below.


>
>> ---
>>   drivers/net/ethernet/sfc/efx_cxl.c | 34 ++++++++++++++++++++++++++++++
>>   1 file changed, 34 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
>> index f1db7284dee8..ea02eb82b73c 100644
>> --- a/drivers/net/ethernet/sfc/efx_cxl.c
>> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
>> @@ -9,6 +9,7 @@
>>    * by the Free Software Foundation, incorporated herein by reference.
>>    */
>>   
>> +#include <cxl/cxl.h>
>>   #include <cxl/pci.h>
>>   #include <linux/pci.h>
>>   
>> @@ -23,6 +24,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>>   	struct pci_dev *pci_dev = efx->pci_dev;
>>   	struct efx_cxl *cxl;
>>   	u16 dvsec;
>> +	int rc;
>>   
>>   	probe_data->cxl_pio_initialised = false;
>>   
>> @@ -43,6 +45,38 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>>   	if (!cxl)
>>   		return -ENOMEM;
>>   
>> +	rc = cxl_pci_setup_regs(pci_dev, CXL_REGLOC_RBI_COMPONENT,
>> +				&cxl->cxlds.reg_map);
>> +	if (rc) {
>> +		dev_warn(&pci_dev->dev, "No component registers (err=%d)\n", rc);
>> +		return rc;
> I haven't checked the code paths to see if we might hit them but this might
> defer.  In which case
> 		return dev_err_probe() is appropriate as it stashes away the
> cause of deferral for debugging purposes and doesn't print if that's what
> happened as we'll be back later.
>
> If we can hit the deferral then you should catch that at the caller of efx_cxl_init()
> and fail the probe (we'll be back a bit later and should then succeed).
>

I'm scare of opening this can ... but I think adding probe deferral 
support to the sfc driver is not an option, or at least something we 
want to avoid because the complexity it would add.


If this call returns EPROBE_DEFER it would be because cxl_mem is not 
loaded or some delay with the cxl mem device initialization when probe 
inside that module, because the other potential CXL modules should be 
loaded at this point (subsys_initcall vs device_initcall). I am aware 
there could be some latencies when those modules are initializing, 
although I think it is not a big problem now and if it is, I think we 
should address it specifically. Then, if the problem is with cxl_mem, 
something I have been witnessing, IMO it is preferable to unload the sfc 
driver and load it again, once the cxl_mem is installed, than to support 
probe deferral. Moreover, if the problem is with something related to 
the cxl_mem probe, I doubt probe deferral will help at all since the sfc 
cxl unwinding will remove the mem device as well, so the probing will be 
needed to happen again ...


Did I say I did not want to open this can?


>> +	}
>> +
>> +	if (!cxl->cxlds.reg_map.component_map.hdm_decoder.valid) {
>> +		dev_err(&pci_dev->dev, "Expected HDM component register not found\n");
>> +		return -ENODEV;
> Trivial but given this is new code maybe differing from style of existing sfc
> and using
> 		return dev_err_probe(&pci->dev, "Expected HDM component register not found\n");
> would be a nice to have.  Given deferral isn't a thing for this call, it just saves on about
> 2 lines of code for each use.


It makes sense.


Thanks!


> or use pci_err() and pci_warn()?
>
>   
>> +	}
>> +
>> +	if (!cxl->cxlds.reg_map.component_map.ras.valid) {
>> +		dev_err(&pci_dev->dev, "Expected RAS component register not found\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	rc = cxl_map_component_regs(&cxl->cxlds.reg_map,
>> +				    &cxl->cxlds.regs.component,
>> +				    BIT(CXL_CM_CAP_CAP_ID_RAS));
>> +	if (rc) {
>> +		dev_err(&pci_dev->dev, "Failed to map RAS capability.\n");
>> +		return rc;
>> +	}
>> +
>> +	/*
>> +	 * Set media ready explicitly as there are neither mailbox for checking
>> +	 * this state nor the CXL register involved, both not mandatory for
>> +	 * type2.
>> +	 */
>> +	cxl->cxlds.media_ready = true;
>> +
>>   	probe_data->cxl = cxl;
>>   
>>   	return 0;

