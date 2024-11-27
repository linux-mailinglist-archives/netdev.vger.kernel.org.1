Return-Path: <netdev+bounces-147573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A3A19DA479
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 10:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A84C7B2348B
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 09:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF611891B2;
	Wed, 27 Nov 2024 09:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DbtmrOAu"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2074.outbound.protection.outlook.com [40.107.92.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7235F14AD02;
	Wed, 27 Nov 2024 09:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732698466; cv=fail; b=kOoVFs2Q8OGV/qQWO9U0ArWhrbgrxqvrvDVV14q1ggiQ5w4WYbvC/IyurzgiLbpW1P9hic38C7KUZuqGMPDNbn0ekxlLnQB5kc1M50hjiOPsdvJs0EvGiJEMsxOZzw/ZAibYOUVDv0Ms7H82XM7BBGx/caDTYvatznT+zjVsjRA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732698466; c=relaxed/simple;
	bh=/nKYFcDsYcBZ/HZCwMoPZw0EdZL+O070oIiBndFO0mo=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=W4Ho6/GRZXRtq77Z2OT1FzzJ+1APAbswsjLEzD1khtMA9ZL88aG7RElXDBMtFW0kA40o0OuPqLiG2yYPxg/sdo4Nf5avbRxY7KeED6VhpOl84lw0OJzMi1UmnFm9/IcBSimqvuUfiv+nRq642c9MKmSeo+pScLtq1ilP6vG85dQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DbtmrOAu; arc=fail smtp.client-ip=40.107.92.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WeKdMCSVRcf5f6LIsbO38b6MSgVibx5SHlqDu+RvFVyXOHR3SpBTcuEfdRyCLTOaD3NQYRDRRXVx3f216336jBLV/DnTNWZbhJ3DKdiu7go0rxqCSNwimKK0SZNpLIZ4UFwt3nDkSC6smQl3C9Khr2Vg3GtmKr7xOz3eweIMXXo7fhXj+w36yK4DH2BJmoy6M0VGVc3QHEIAsvW5cSkB0xZ7AKef8w2leSSN/Gn8/QJUk8DaYNwVR5VDklt1kjnWlXvwoW9YnBIgkWFnSKQZl8DFP7csArMAN31j8qmvkWTv3bzYsHoJB5VJK2KRBjrLmh/zji/CRqfVoHIpaqfXtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aDO3U9QEmElKkzUAgfgBEmCUP7lptmX6Cs9q2vRwSTA=;
 b=SEAWsf0I/JrzuH+Pffg9MHqBVP4xTcVFJpOvZwvbDTrFytNyEsO3fDRKyWJPepzAgKTszIOymzFUz7nJ9iHWxLEkV7KOYJL211Uppn0x3UXsR1r6oBLsLTpqEMUQuJlrTTfUZR65hMBLCEdh59lw9yEm+hhco9Jwi49ibyx3bdB4xptu0I101ldmp6BJKexRVcKnI++JMwF9NJLyo1H/4YBA1RfZ1hLigEewOgjAlgQ0ExBoMH9ANlNgkw+WonGswKNqIarYujW1RgvRpX6MY5gZ0EI6AMKQAxFEbF99Y852JNKGlIYgr5Ak9cZSwqkWzGrqix40zRT1c3NXCVpjew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aDO3U9QEmElKkzUAgfgBEmCUP7lptmX6Cs9q2vRwSTA=;
 b=DbtmrOAuc6iZmKu3HaOjf9Z3fXy9pm9Lh6RcVHpwb0NlTZNDzTRs2GpMJzFjU108gYI8JibdCgbZ6YuIX2NfFU4S848sPq5WH0nMLf2YShMeLTDB0TiZ79EAwju/hQXYndzIAGfW073ToIlIDqwMKc+c8Bd4K+H6K/h0T7RaZeU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by MN2PR12MB4302.namprd12.prod.outlook.com (2603:10b6:208:1de::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Wed, 27 Nov
 2024 09:07:41 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.8207.010; Wed, 27 Nov 2024
 09:07:41 +0000
Message-ID: <2851555f-9495-9f3c-3979-be3500894d9d@amd.com>
Date: Wed, 27 Nov 2024 09:07:35 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 01/27] cxl: add type2 device basic support
Content-Language: en-US
From: Alejandro Lucero Palau <alucerop@amd.com>
To: Ben Cheatham <benjamin.cheatham@amd.com>,
 "Lucero Palau, Alejandro" <alejandro.lucero-palau@amd.com>
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, martin.habets@xilinx.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, "Cheatham, Benjamin" <bcheatha@amd.com>
References: <20241118164434.7551-1-alejandro.lucero-palau@amd.com>
 <20241118164434.7551-2-alejandro.lucero-palau@amd.com>
 <35be71eb-7261-441c-8677-355658fbcb4f@amd.com>
 <2c320f3c-907f-639a-6e5d-ecab8204172a@amd.com>
In-Reply-To: <2c320f3c-907f-639a-6e5d-ecab8204172a@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PR3P191CA0023.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:102:54::28) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|MN2PR12MB4302:EE_
X-MS-Office365-Filtering-Correlation-Id: 750621fe-1750-4354-b548-08dd0ec2f28b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZjJpdEJTT1VZeEVVYzBPRXVqY0p2Vy9sekRidGJZTXI1NFhrcXBiSTFwMG1m?=
 =?utf-8?B?RWU3WDArcHh5d25odkZOc1BnOFFJLzI2V28zaU1kaytmbVJOMjRhY0hGbEVT?=
 =?utf-8?B?Qi9uV0p4T2ZLbUM0UFovRTh5anZuOGx4ck9MaDBSODhCYmt6UXFEZFNyY3Z0?=
 =?utf-8?B?VjFOOWZLcmdJbnRLU3VQZWNQc2JsenJhTkREUGtMbDNsdEk4aXl6NDB4N0xW?=
 =?utf-8?B?QzFta0tsV2dUc3ZTYWlnYVdlRzdzWE1zRkVraEhYbmRVUVIxZlNFMnVOaG1V?=
 =?utf-8?B?SVpEZzhpZFpVNk5lNFcvYUNlUG1TTUF5OUYreG9CZUJTTDhTbzNYZ25aT2Jm?=
 =?utf-8?B?U2drOWRqTmM4SmtUemZSdmRzUzN3VTZzUHJCOWpFTWx5OFdxa085bjhwM0Ro?=
 =?utf-8?B?QldkSElXY1ZjUW5zNGhFczJlQy9ESURicGFUWVZTZzZNTVBNdW83dnJSdFZU?=
 =?utf-8?B?N1ZFNk1hVzdDenJBZk4wVWZpcmtZVk5YNHpkME9KZk9kc1M1UjJwREliR21a?=
 =?utf-8?B?MERQSWlnTTVLSDdFVGtMdjRvODRxZmtIWEJhZEJTWlNiYWNZYTNNSVU1Vitn?=
 =?utf-8?B?RlM0VnpUci8wUEFqK1BoUkRLZU9WY1dONnZENm44S3hVenBDUmo1am9MYWZo?=
 =?utf-8?B?WnQ5b1JiVEdDRmpIVzRWclJmSUkxeG1IdHFucWw0VUdabXM2RTBaN0JyR1Q2?=
 =?utf-8?B?Zlh0OHBSVTdOdXcveG5yZmhlZVE1aUhoMGUvYlU2VHhwNjBnWkJtY3FFRk1j?=
 =?utf-8?B?OWc3My81ZHdxYWh4aEhOTlgvWmg3VVBIQjVySXlxaCtvNVRLVXZFYTNnWjRu?=
 =?utf-8?B?dzFvajVGV1V6ajVWV2IzN0VOWnFmZHJhRGZZMGo4YythcmhTSkV1anA0QTgr?=
 =?utf-8?B?VkNiSmtSNEFMUnQwZ2hBNWl3MzdaMEE5RThpSTVBallsT3dGWXh1VmtUNTc2?=
 =?utf-8?B?dFBiNFptZ2N5dHJSY011TWJCUFBveVdZVDlPOWpGejNMMG9TQWdnWGVBZk5o?=
 =?utf-8?B?dlI3VE55UE53b0FqVUllYU9IbUFiN3Y1b0hxS3pja0pvSkNpb05QMExMNmJi?=
 =?utf-8?B?TzI5VnRGaXVXekZoaGhNM2FSVEhad09YL1pMT3VkTXFvclY3cEpoRFFlWUlD?=
 =?utf-8?B?cnluazFQTGQvNlJaQm5iWncwMFZhaFRPZmF4dEFzeEh0eEM4Y2pkdFpIWGR4?=
 =?utf-8?B?R05sQlFJeVNId1Jwa1hnMHEyY1ZBNVhVLy9oVW1pNlVzQlFQMmQ0M3pqaWNv?=
 =?utf-8?B?bkcwU2N0dXBPbWg0WERhV3pvRjZaQSticFlSbU9Ha2grNUFpSC9odlJPRXNU?=
 =?utf-8?B?dTRYakoydUZXN1FuVlRCQXo0TmFDcGtXZE5mNkhWdUtvazdTeWEvRzkzdmlD?=
 =?utf-8?B?T21TcFFaWGx1bHFoSzlZVnhabjkwTHdqdHFuTEYrMThtMFdsRklXUCtFMGZ0?=
 =?utf-8?B?THZ0c0syOTNSd3ZnZS96a1lnay9QRmY2eEdLUFpsTnRVVTFSS2EwNm11cW5R?=
 =?utf-8?B?T1Qydm1ndTdaNjEzUDV6dTBqSDRHOEZsVlBNTXJIT1ppK28xOU41RXpvZU1v?=
 =?utf-8?B?RklWOXNoYVJBeE1OekIxcVVDTTJ0WVlZMzhjR05UMzk5UWxnZzA3TzdCdzBK?=
 =?utf-8?B?ZUpnWWNRNEN0YVorNE50Z0NNQ1QvVmxsUUxTR3VwVFJRZ2ZqTDh3aVd3UTJH?=
 =?utf-8?B?ZUIrM1F4U3lES0NZS1hWMnZDQUJna045ZnQ4VWptK3ZiYlhzLzVUYTB4NW9C?=
 =?utf-8?B?UzhXSGFWanlKbUw3M1A2aUladEZQbldrWlFRdUlTSGM5b1JSRU5OVnNGUHh5?=
 =?utf-8?Q?jBHv087/i6q1TBX2zVz1C+bfzGoNsP0oZzW+Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YlprSEM5QjZyUThsaFJkc1pQWTI3STN4MEtyOWFVZ1VCQWtUNEJwdE1kMXdW?=
 =?utf-8?B?b2J0cC9pa1p3MFV2OVEzZGIxSzU5a3hJQ0FoSEw3dExmYlRCV0huOVEydnRI?=
 =?utf-8?B?cjN3MURNZk1YUGlNRjd3aWhIc0xaMWpvRDlDME9kRDBkL3pLZjg4NnB6ekRj?=
 =?utf-8?B?Z1I3V0ZTY2s2UVNLa0FpNnBsdU1vYU9yZnd6L1lTbTJ6bkN4VWI2MTA2djZ3?=
 =?utf-8?B?K2x6MUsyeG0yajQyZklObHhzZ1pjdExOTi91K0M1aXNjK0tISWhmNWdueDI2?=
 =?utf-8?B?N2F0WDcxR25VYjFrZ1BGY0NucW92bUlRYm42cjZmbVdxMjI2MFdsUVIvcHVh?=
 =?utf-8?B?MkhmK241UXFjMUFuRnV4bm9RYWExN1lvOHRXdmcvMEkvdUtxSENIcUlBano4?=
 =?utf-8?B?N3AwOTYxbG9rNytOTTd3d0I1UUhZY3RqeGloWG5sT1E1dzdnMGxrSEdDNWVF?=
 =?utf-8?B?aDdJT0hITUVIQk42MUR2b25CcFpzV1NrMnR0MlV1eHZ3NDlnanptdzZpcmZH?=
 =?utf-8?B?WXdRUW03SU9zTFFiQTgwazVWYTlDeTNtYk5RUEhRcENvL2doZi9yQnYybFVm?=
 =?utf-8?B?TUFybTZubGE3NlBSZXp2TWFyaW5Kb3p1cmNKZnB0ZktGSzNISUJHK2RzWi9a?=
 =?utf-8?B?RmZJR2lEVTEwdklZL3FjMGtuZTMyY0pQeDY1c3ZxY09EN1dBU0N3eG8rcXk1?=
 =?utf-8?B?MEVzTE5mYzRPZFhhZEFqTEN4NDNFc0RRalI2K3lObXVTUDdkbTh2L3hQNVpP?=
 =?utf-8?B?dGJYdnZiSldOZ3Aya2F6YjRLaHhRRXhESEphREQ3UHByN2RzVDMrcitHSTNL?=
 =?utf-8?B?RkVmQnAwMXdYclErMnFlYkJRUXRGTUs5YVpRd0ZGOEo4akliOTFiZEcrNFFY?=
 =?utf-8?B?b2hIOHBmM09JQ3h6dDJhelg2cGhrL1JyY2NPUlkyN2Y4NGMzaHkzaHlPVlFV?=
 =?utf-8?B?cFlXcmd5dmJ5b0tOcXVKZFVSUGozbU1rSGl1aUdSdEJpVXViN3hyNHB3Yndr?=
 =?utf-8?B?UXdVYWRoeXJTRmR6WlpQelVyMnhJQmZDeG5td0RmUWV5SVlRMys2cHRPSWVt?=
 =?utf-8?B?OFFJaTdRcnJZNEZnZ3dacnByRjdsT01jVnFoL1NJQ2c4NTFnTStPTS9pVWwx?=
 =?utf-8?B?b0lkMFdlalJja0svd045TDA3TzFwWEEzN1R0bFVpS01BU05kNWRYbjZHbDU4?=
 =?utf-8?B?WXIySEd3ZzByc0pMRFV2UTNld3BtWEhZUkVuUzd3N1dHOVlnSnM1MGpWRFBY?=
 =?utf-8?B?alk5aSsvb3J6ZDAyZmswQXRJUGsxSDAxaGYxOW5sR09TSTArYnFxVnFhS2hj?=
 =?utf-8?B?SVRrQ2ZPRVVBMUFLaWdRNTNwSnh1RjB2NDd3eVVaOEpaWUQ5MWlRNFB6YlQw?=
 =?utf-8?B?VUViRG5lV3Z1Mkx5dHh5TGVGRnZxVXEyZW5ZbzdhZzV5NTl5bXFGNmlmdFFC?=
 =?utf-8?B?MDd4cW9MNXBiNU1tYnZyV3U3MkY1a0JIUXNKTzF5SFFPYmdMSkh3d2hKRzUy?=
 =?utf-8?B?TmVjcG90NzVBcmhwMzdGeHlpN3ZCdWdkcU5KWTFQa2hnNXdQcEFnYW02MHdJ?=
 =?utf-8?B?cnd1TVdnK0FkN2Z0WXZxQVFoQXVnajBCek1RYVlWTE5hRW5BR1Jsem5kenov?=
 =?utf-8?B?Rm1YdjNJT1IrcFJGZkNMc1ZNeUpidVhCTWdGajVjdE9zbVhBT3JSN3pnWGR1?=
 =?utf-8?B?ME1PU29PS0hnUnFnNnJTNFoyQ0UvbEUwOWUvdlI5aTVmU1o5WmxlVFF5anJL?=
 =?utf-8?B?Qm00RkJTdm94dHIySko1MGZaYVI0SlpxckNmVDlHcEFaYi91ek81ZitCelRr?=
 =?utf-8?B?N0xISm9JanNkVmFQWFpLRUhLa2U4WE1pTTFEb3FzWjBYblFQY1dRNEZQUWt2?=
 =?utf-8?B?WWRQMnZ3RTRGUU1pbHduUDdnelgzclBaalM5ZnJsK3NOTDdiVDcwUU1uQU1C?=
 =?utf-8?B?am9KVlpkVVdrQnA2TS8wVitNMWl1VE9YNElTRXh6TTZXQVdkQnkxZzQwUWF6?=
 =?utf-8?B?b215SE9odnI5b1BueVdrMm15bmVOVkY0VnpyUENTQm0yRmYwWW1kY2JCVStS?=
 =?utf-8?B?V1g3a1ZleUYrLzRRMVlCaG9UanN5d2pyYjdibWFtNC9TcEEvSUZaRWovUEV5?=
 =?utf-8?Q?+My5JF7AIeVEvHMc/n4OkqsII?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 750621fe-1750-4354-b548-08dd0ec2f28b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2024 09:07:41.3325
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kbzJiOGzVx2FQNP8ILfzhibvA5r1GUOagkMR8HZzLLqRsi17IMyN+L5O1y2ios+8vGWCxY/g5IwSou2udxWHqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4302


On 11/27/24 09:00, Alejandro Lucero Palau wrote:
>
> On 11/22/24 20:43, Ben Cheatham wrote:
>> On 11/18/24 10:44 AM, alejandro.lucero-palau@amd.com wrote:
>>> From: Alejandro Lucero <alucerop@amd.com>
>>>
>>> Differentiate Type3, aka memory expanders, from Type2, aka device
>>> accelerators, with a new function for initializing cxl_dev_state.
>>>
>>> Create accessors to cxl_dev_state to be used by accel drivers.
>>>
>>> Based on previous work by Dan Williams [1]
>>>
>>> Link: [1] 
>>> https://lore.kernel.org/linux-cxl/168592160379.1948938.12863272903570476312.stgit@dwillia2-xfh.jf.intel.com/
>>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>>> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
>>> ---
>>>   drivers/cxl/core/memdev.c | 51 
>>> +++++++++++++++++++++++++++++++++++++++
>>>   drivers/cxl/core/pci.c    |  1 +
>>>   drivers/cxl/cxlpci.h      | 16 ------------
>>>   drivers/cxl/pci.c         | 13 +++++++---
>>>   include/cxl/cxl.h         | 21 ++++++++++++++++
>>>   include/cxl/pci.h         | 23 ++++++++++++++++++
>>>   6 files changed, 105 insertions(+), 20 deletions(-)
>>>   create mode 100644 include/cxl/cxl.h
>>>   create mode 100644 include/cxl/pci.h
>>>
>>> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
>>> index 84fefb76dafa..d083fd13a6dd 100644
>>> --- a/drivers/cxl/core/memdev.c
>>> +++ b/drivers/cxl/core/memdev.c
>>> @@ -1,6 +1,7 @@
>>>   // SPDX-License-Identifier: GPL-2.0-only
>>>   /* Copyright(c) 2020 Intel Corporation. */
>>>   +#include <cxl/cxl.h>
>> Pedantic one, you'll want this at the end CXL does reverse christmas 
>> tree
>> for #includes.
>
>
> That seems to be true for this file, but the reverse christmas tree is 
> not applied through all the files in the cxl directory.
>
> I was told to put it in alphabetical order (not remember which 
> specific file), what implies there is no agreement about how to put 
> the header references.
>
> Anyway, I think for this one your suggestion makes sense.
>
>
>>>   #include <linux/io-64-nonatomic-lo-hi.h>
>>>   #include <linux/firmware.h>
>>>   #include <linux/device.h>
>>> @@ -616,6 +617,25 @@ static void detach_memdev(struct work_struct 
>>> *work)
>>>     static struct lock_class_key cxl_memdev_key;
>>>   +struct cxl_dev_state *cxl_accel_state_create(struct device *dev)
>>> +{
>>> +    struct cxl_dev_state *cxlds;
>>> +
>>> +    cxlds = kzalloc(sizeof(*cxlds), GFP_KERNEL);
>> Would it be better to use a devm_kzalloc() here? I'd imagine this 
>> function
>> will be called as part of probe a majority of the time so I think the 
>> automatic
>> cleanup would be nice here. If you did that, then I'd also rename the 
>> function to
>> include devm_ as well.
>
>
> This is complicated. As I have said in other previous reviews 
> regarding use of devm_* by the sfc changes in this patchset, it is  
> not advice to use them inside the netdev subsystem. This is not the 
> case here since it is cxl code, but in this case used by a netdev 
> client (although other clients from other subsystems will likely come 
> soon).
>
>
> So, I'm not sure about this one. I could add the specific function to 
> use when released like when cxl_memdev_alloc is used by 
> devm_cxl_add_memdev, but frankly, mixing devm with no devm allocations 
> is a mess, at least in my view.
>

I forgot to mention another reason for not using devm and it is the fact 
that the memory is not released until the driver is detached. If the cxl 
initialization can fail and not being fatal, that means the memory not 
released while the driver is being used. A specific CXL accelerator 
driver, meaning the design relying on CXL, is not a problem, but a 
driver using CXL as an option for better performance could keep the 
memory unreleased as it is the case for sfc.


>
>>> +    if (!cxlds)
>>> +        return ERR_PTR(-ENOMEM);
>>> +
>>> +    cxlds->dev = dev;
>>> +    cxlds->type = CXL_DEVTYPE_DEVMEM;
>>> +
>>> +    cxlds->dpa_res = DEFINE_RES_MEM_NAMED(0, 0, "dpa");
>>> +    cxlds->ram_res = DEFINE_RES_MEM_NAMED(0, 0, "ram");
>>> +    cxlds->pmem_res = DEFINE_RES_MEM_NAMED(0, 0, "pmem");
>>> +
>>> +    return cxlds;
>>> +}
>>> +EXPORT_SYMBOL_NS_GPL(cxl_accel_state_create, CXL);
>>> +
>>>   static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state 
>>> *cxlds,
>>>                          const struct file_operations *fops)
>>>   {
>>> @@ -693,6 +713,37 @@ static int cxl_memdev_open(struct inode *inode, 
>>> struct file *file)
>>>       return 0;
>>>   }
>>>   +void cxl_set_dvsec(struct cxl_dev_state *cxlds, u16 dvsec)
>>> +{
>>> +    cxlds->cxl_dvsec = dvsec;
>>> +}
>>> +EXPORT_SYMBOL_NS_GPL(cxl_set_dvsec, CXL);
>>> +
>>> +void cxl_set_serial(struct cxl_dev_state *cxlds, u64 serial)
>>> +{
>>> +    cxlds->serial = serial;
>>> +}
>>> +EXPORT_SYMBOL_NS_GPL(cxl_set_serial, CXL);
>>> +
>>> +int cxl_set_resource(struct cxl_dev_state *cxlds, struct resource res,
>>> +             enum cxl_resource type)
>>> +{
>>> +    switch (type) {
>>> +    case CXL_RES_DPA:
>>> +        cxlds->dpa_res = res;
>>> +        return 0;
>>> +    case CXL_RES_RAM:
>>> +        cxlds->ram_res = res;
>>> +        return 0;
>>> +    case CXL_RES_PMEM:
>>> +        cxlds->pmem_res = res;
>>> +        return 0;
>>> +    }
>>> +
>>> +    return -EINVAL;
>>> +}
>>> +EXPORT_SYMBOL_NS_GPL(cxl_set_resource, CXL);
>>> +
>>>   static int cxl_memdev_release_file(struct inode *inode, struct 
>>> file *file)
>>>   {
>>>       struct cxl_memdev *cxlmd =
>>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>>> index 420e4be85a1f..ff266e91ea71 100644
>>> --- a/drivers/cxl/core/pci.c
>>> +++ b/drivers/cxl/core/pci.c
>>> @@ -1,5 +1,6 @@
>>>   // SPDX-License-Identifier: GPL-2.0-only
>>>   /* Copyright(c) 2021 Intel Corporation. All rights reserved. */
>>> +#include <cxl/pci.h>
>>>   #include <linux/units.h>
>>>   #include <linux/io-64-nonatomic-lo-hi.h>
>>>   #include <linux/device.h>
>>> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
>>> index 4da07727ab9c..eb59019fe5f3 100644
>>> --- a/drivers/cxl/cxlpci.h
>>> +++ b/drivers/cxl/cxlpci.h
>>> @@ -14,22 +14,6 @@
>>>    */
>>>   #define PCI_DVSEC_HEADER1_LENGTH_MASK    GENMASK(31, 20)
>>>   -/* CXL 2.0 8.1.3: PCIe DVSEC for CXL Device */
>>> -#define CXL_DVSEC_PCIE_DEVICE                    0
>>> -#define   CXL_DVSEC_CAP_OFFSET        0xA
>>> -#define     CXL_DVSEC_MEM_CAPABLE    BIT(2)
>>> -#define     CXL_DVSEC_HDM_COUNT_MASK    GENMASK(5, 4)
>>> -#define   CXL_DVSEC_CTRL_OFFSET        0xC
>>> -#define     CXL_DVSEC_MEM_ENABLE    BIT(2)
>>> -#define   CXL_DVSEC_RANGE_SIZE_HIGH(i)    (0x18 + (i * 0x10))
>>> -#define   CXL_DVSEC_RANGE_SIZE_LOW(i)    (0x1C + (i * 0x10))
>>> -#define     CXL_DVSEC_MEM_INFO_VALID    BIT(0)
>>> -#define     CXL_DVSEC_MEM_ACTIVE    BIT(1)
>>> -#define     CXL_DVSEC_MEM_SIZE_LOW_MASK    GENMASK(31, 28)
>>> -#define   CXL_DVSEC_RANGE_BASE_HIGH(i)    (0x20 + (i * 0x10))
>>> -#define   CXL_DVSEC_RANGE_BASE_LOW(i)    (0x24 + (i * 0x10))
>>> -#define     CXL_DVSEC_MEM_BASE_LOW_MASK    GENMASK(31, 28)
>>> -
>>>   #define CXL_DVSEC_RANGE_MAX        2
>>>     /* CXL 2.0 8.1.4: Non-CXL Function Map DVSEC */
>>> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
>>> index 188412d45e0d..0b910ef52db7 100644
>>> --- a/drivers/cxl/pci.c
>>> +++ b/drivers/cxl/pci.c
>>> @@ -1,5 +1,7 @@
>>>   // SPDX-License-Identifier: GPL-2.0-only
>>>   /* Copyright(c) 2020 Intel Corporation. All rights reserved. */
>>> +#include <cxl/cxl.h>
>>> +#include <cxl/pci.h>
>>>   #include <linux/unaligned.h>
>>>   #include <linux/io-64-nonatomic-lo-hi.h>
>>>   #include <linux/moduleparam.h>
>>> @@ -816,6 +818,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, 
>>> const struct pci_device_id *id)
>>>       struct cxl_memdev *cxlmd;
>>>       int i, rc, pmu_count;
>>>       bool irq_avail;
>>> +    u16 dvsec;
>>>         /*
>>>        * Double check the anonymous union trickery in struct cxl_regs
>>> @@ -836,13 +839,15 @@ static int cxl_pci_probe(struct pci_dev *pdev, 
>>> const struct pci_device_id *id)
>>>       pci_set_drvdata(pdev, cxlds);
>>>         cxlds->rcd = is_cxl_restricted(pdev);
>>> -    cxlds->serial = pci_get_dsn(pdev);
>>> -    cxlds->cxl_dvsec = pci_find_dvsec_capability(
>>> -        pdev, PCI_VENDOR_ID_CXL, CXL_DVSEC_PCIE_DEVICE);
>>> -    if (!cxlds->cxl_dvsec)
>>> +    cxl_set_serial(cxlds, pci_get_dsn(pdev));
>>> +    dvsec = pci_find_dvsec_capability(pdev, PCI_VENDOR_ID_CXL,
>>> +                      CXL_DVSEC_PCIE_DEVICE);
>>> +    if (!dvsec)
>>>           dev_warn(&pdev->dev,
>>>                "Device DVSEC not present, skip CXL.mem init\n");
>>>   +    cxl_set_dvsec(cxlds, dvsec);
>>> +
>>>       rc = cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map);
>>>       if (rc)
>>>           return rc;
>>> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
>>> new file mode 100644
>>> index 000000000000..19e5d883557a
>>> --- /dev/null
>>> +++ b/include/cxl/cxl.h
>> Is cxl.h the right name for this file? I initially thought this was 
>> the cxl.h
>> under drivers/cxl. It looks like it's just type 2 related functions, 
>> so maybe
>> "type2.h", or "accel.h" would be better? If the plan is to expose 
>> more CXL
>> functionality not necessarily related to type 2 devices later I'm 
>> fine with it,
>> and if no one else cares then I'm fine with it.
>
>
> I agree, but I did use cxl_accel_* in version 2 and it was suggested 
> then to remove the accel part, so leaving it as it is now if none else 
> cares about it.
>
> Thanks!
>
>
>>> @@ -0,0 +1,21 @@
>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>> +/* Copyright(c) 2024 Advanced Micro Devices, Inc. */
>>> +
>>> +#ifndef __CXL_H
>>> +#define __CXL_H
>>> +
>>> +#include <linux/ioport.h>
>>> +
>>> +enum cxl_resource {
>>> +    CXL_RES_DPA,
>>> +    CXL_RES_RAM,
>>> +    CXL_RES_PMEM,
>>> +};
>>> +
>>> +struct cxl_dev_state *cxl_accel_state_create(struct device *dev);
>>> +
>>> +void cxl_set_dvsec(struct cxl_dev_state *cxlds, u16 dvsec);
>>> +void cxl_set_serial(struct cxl_dev_state *cxlds, u64 serial);
>>> +int cxl_set_resource(struct cxl_dev_state *cxlds, struct resource res,
>>> +             enum cxl_resource);
>>> +#endif
>>> diff --git a/include/cxl/pci.h b/include/cxl/pci.h
>>> new file mode 100644
>>> index 000000000000..ad63560caa2c
>>> --- /dev/null
>>> +++ b/include/cxl/pci.h
>>> @@ -0,0 +1,23 @@
>>> +/* SPDX-License-Identifier: GPL-2.0-only */
>>> +/* Copyright(c) 2020 Intel Corporation. All rights reserved. */
>>> +
>>> +#ifndef __CXL_ACCEL_PCI_H
>>> +#define __CXL_ACCEL_PCI_H
>>> +
>>> +/* CXL 2.0 8.1.3: PCIe DVSEC for CXL Device */
>>> +#define CXL_DVSEC_PCIE_DEVICE                    0
>>> +#define   CXL_DVSEC_CAP_OFFSET        0xA
>>> +#define     CXL_DVSEC_MEM_CAPABLE    BIT(2)
>>> +#define     CXL_DVSEC_HDM_COUNT_MASK    GENMASK(5, 4)
>>> +#define   CXL_DVSEC_CTRL_OFFSET        0xC
>>> +#define     CXL_DVSEC_MEM_ENABLE    BIT(2)
>>> +#define   CXL_DVSEC_RANGE_SIZE_HIGH(i)    (0x18 + ((i) * 0x10))
>>> +#define   CXL_DVSEC_RANGE_SIZE_LOW(i)    (0x1C + ((i) * 0x10))
>>> +#define     CXL_DVSEC_MEM_INFO_VALID    BIT(0)
>>> +#define     CXL_DVSEC_MEM_ACTIVE    BIT(1)
>>> +#define     CXL_DVSEC_MEM_SIZE_LOW_MASK    GENMASK(31, 28)
>>> +#define   CXL_DVSEC_RANGE_BASE_HIGH(i)    (0x20 + ((i) * 0x10))
>>> +#define   CXL_DVSEC_RANGE_BASE_LOW(i)    (0x24 + ((i) * 0x10))
>>> +#define     CXL_DVSEC_MEM_BASE_LOW_MASK    GENMASK(31, 28)
>>> +
>>> +#endif

