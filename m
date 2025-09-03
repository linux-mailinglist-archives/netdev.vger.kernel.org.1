Return-Path: <netdev+bounces-219416-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F8AB412BF
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 05:06:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 006C4176000
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 03:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A3DF2C15B4;
	Wed,  3 Sep 2025 03:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b="v6/IoUJ8"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2139.outbound.protection.outlook.com [40.107.237.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 427FE19E81F;
	Wed,  3 Sep 2025 03:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756868774; cv=fail; b=JyXQLJztymB1yrlsiSaH7Yaji0Nw4z7OdEmxe98AbrvRrFEKAqR145JngazV3ncaAtRUq6fGICWYhdjekxK3hqRrkFojSWAyWHv8NKiELC+BhLnd2KEzD6HQjuwjP6M7S7cI9es6z4mlRA9cXRTAlG2xtc/ZGaazPN1jf+3YQzs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756868774; c=relaxed/simple;
	bh=PXS1AKY9vtjCloGL95NsTjv+lVkg3kx2aezyKfLCoMY=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GoJt4Z0zvVBLMcQEBShcpSym3mqJd7BcqzFrorb3WYVxvO6swNG4zI8I40De4iYeu9ZKWU8R9VtXgciZp+GlMND+uhebnObSvf4KFTtHLNZ3+GI6CbuoV+nWdmuA500NqMC7hZUD1/nzR5niYMwbmhNK6Ibp5ppxP9axbkMusAA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=fail (0-bit key) header.d=amperemail.onmicrosoft.com header.i=@amperemail.onmicrosoft.com header.b=v6/IoUJ8 reason="key not found in DNS"; arc=fail smtp.client-ip=40.107.237.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amperemail.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D4hOso1XOpN3YQFxWijCR/FrSsfoTxhadZEkPPg5DM9ga30b7QElh8l/b2/9UZqrJfbCekhyB8ioMTnR1r3f+i2tKT6xUM0EvXd0Pd4OxgQZOObZKjNTN7nTjXqT1CHHvvgYylOghxeOUhKPgf8QBzXsfvDLK7VErHkq3KWdhxaQ3LuvLv5rNEqfHR/zVdhkGAzrSziVniM4dHnUVYaDaD9cZ8VozkWv1n8eb+vh+SWwlvoyZqHR5qu1CdgwEBsHBipXx6GLHM40PJJkGv+zu4X/afRIvuqPyAn+5bzXPDDQETcgoXtS64x8MPzaQja5PIy7umH9OqMjXCInKydjow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MR7y141mnzj1rw86wsOa9JrN/bHkEziwTw4a0WH8p2o=;
 b=ocfoPf03k83FrQDnlzhEDo+kgVtfWCEUD9dcpa0/sEn1F3oWSaNwaw8VWrr5xUiak3EhC1amFw2oaPHR9wDpxKfhGZKl84a2GBqGz0kBdJQgANSE+CCg0pJM/b+0gPaB5oQJrlQSzjZM8nSY9t5F1PhtFp1FZkAiHZyJLvGGvKmeBu1nEphIfEucId3njJpT5kPNUTOYpMu+OR3rlP+YnljAubbNEy4pGmudhztzw0TTcifXZcwi7ma1kBcaTZUVf3l2wSGU97JqDvFsVyvPX8RE+e1K3QpiU2lnk+O7i5rw7u17+6p9XOpxYTt+LDnDaFQz9DcQTU1UEWJu9d9rCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=amperemail.onmicrosoft.com; dkim=pass
 header.d=amperemail.onmicrosoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amperemail.onmicrosoft.com; s=selector1-amperemail-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MR7y141mnzj1rw86wsOa9JrN/bHkEziwTw4a0WH8p2o=;
 b=v6/IoUJ8ICb3NspkNGJ7sW6vf9RNrE3vsTujGVV7fxzmUt8TjkkZ/WKn7UEi9pDKVFJeP8rVwc+TFdH0x8XDgt1K2isDJ3G/Sy7A7IacmCggSE8U2MXO+03QszUc3pdaq/P6NVct5TsIyFFVKYox/OxTKuIGpFbU+QOPB745zJo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amperemail.onmicrosoft.com;
Received: from BN3PR01MB9212.prod.exchangelabs.com (2603:10b6:408:2cb::8) by
 SA1PR01MB7360.prod.exchangelabs.com (2603:10b6:806:1fb::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.27; Wed, 3 Sep 2025 03:06:08 +0000
Received: from BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd]) by BN3PR01MB9212.prod.exchangelabs.com
 ([fe80::3513:ad6e:208c:5dbd%4]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 03:06:08 +0000
Message-ID: <958f555a-1187-44ef-95df-c93474888208@amperemail.onmicrosoft.com>
Date: Tue, 2 Sep 2025 23:06:02 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v27 1/1] mctp pcc: Implement MCTP over PCC
 Transport
From: Adam Young <admiyo@amperemail.onmicrosoft.com>
To: Jeremy Kerr <jk@codeconstruct.com.au>,
 Adam Young <admiyo@os.amperecomputing.com>,
 Matt Johnston <matt@codeconstruct.com.au>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sudeep Holla <sudeep.holla@arm.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Huisong Li <lihuisong@huawei.com>
References: <20250828043331.247636-1-admiyo@os.amperecomputing.com>
 <20250828043331.247636-2-admiyo@os.amperecomputing.com>
 <eb156195ce9a0f9c0f2c6bc46c7dcdaf6e83c96d.camel@codeconstruct.com.au>
 <e28eeb4f-98a4-4db6-af96-c576019d3af1@amperemail.onmicrosoft.com>
 <c22e5f4dc6d496cec2c5645eac5f43aa448d0c48.camel@codeconstruct.com.au>
 <3d30c216-e49e-4d85-8f1b-581306033909@amperemail.onmicrosoft.com>
Content-Language: en-US
In-Reply-To: <3d30c216-e49e-4d85-8f1b-581306033909@amperemail.onmicrosoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CY5PR15CA0087.namprd15.prod.outlook.com
 (2603:10b6:930:18::13) To BN3PR01MB9212.prod.exchangelabs.com
 (2603:10b6:408:2cb::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PR01MB9212:EE_|SA1PR01MB7360:EE_
X-MS-Office365-Filtering-Correlation-Id: 8de4a08d-04a8-4886-57e2-08ddea96d3f6
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VlFNd2ZHaHhJS2czeXNNVmVuOGFKVDd2eGFpMm1DMEZUN211UEN6WkRUSHZ0?=
 =?utf-8?B?UWY5clNQM3BPZkJONkpTSldqZDk0V2xDemNGbFNrMmxDK2dVdkVKMlkxYndp?=
 =?utf-8?B?K2s4eElnU2VvV2JDVkQ4dXdDVFJNMDZ5TmdIODZpZ0pSTVVZWFB2R1RVa3VN?=
 =?utf-8?B?VFJNSzV4end0V0tjK3VrWUR2bHN4MitBeHBiS3ZRZGJlSCsxVnVrMm5hVUFH?=
 =?utf-8?B?YkJiR3FsckptY1M0SmxYQzBpREpDOExZZk9SaUNtTjkxektLQW5RNUwvR0tr?=
 =?utf-8?B?MExPajVlM2F4c2gvdnY3MnhkVG5Oa0g1VndXZ0dYaVliZkljUnFOdkpjbFhP?=
 =?utf-8?B?RjcrNlQ0RUQvRVZMRWgvRzVLY0JDeDNnLzArY2RPdjcyNFY2SWs2THVBcG9q?=
 =?utf-8?B?Qk1SYWUxOHhsT0ZiTGpBOVQrU3U1UzhFb2ovL0RZVG1aY2JiT0Q5a1U1K21r?=
 =?utf-8?B?bXFjS1FHdTZSWGp4VzdPd0djUEpveTFOeDAvd0w4aTRpOXhteHYzZXVJMnF4?=
 =?utf-8?B?dm5zTnpVNDZQVS95N2t1Z2dWbTk5VnJ1UnFUWHZSdnRMNEJsOEY4SStyUkxM?=
 =?utf-8?B?d2xzUUhlMVlwUjkzWE9YcHVzQ2lJSGdyOWVTWmNVVFM2QUw0azVTTEZwaGxw?=
 =?utf-8?B?WWNzaUVaU3dyM3ROWHpWbElvRW1EUm9JUnY0eVpndDJBOUdRN0tRRWQreGtt?=
 =?utf-8?B?eC9BaE8xeWdKbDNPNnFMUnZUdWNpR0kyVkJtSXpnRmhMMUZxZGYrb1ppcmE0?=
 =?utf-8?B?RGI0c1o2d0VFLzI5Z3ZRYk5palpsOUFwVWhKUFNLeTlUaHZST2NCbWZzeUdU?=
 =?utf-8?B?V2Ftb0hhWDJwZjNsUUNZV1hWZm5kcDhJTmpJRWZqdGREVS9wU0RuMzZuLzNJ?=
 =?utf-8?B?THlwbE1Sb1hlWFZPcmRMa1hUUVJQaEp0MHJqSTh1aU1uWHlMR1ErbmJoQXRS?=
 =?utf-8?B?SmFkSUlYL0xPWHdyUFlBSFZOR1lSeUk5K1JSVG9FM1Q4L2g1TU50S2pONmlr?=
 =?utf-8?B?bG1ITHVmbm5RVUs0YmVoLyt1cWNoc1c3VGhNUkJ0bDlMcGNqN0NjdmpldFZR?=
 =?utf-8?B?ZHdhdFB6OWo0WHV4RlR6YU92dG9JcVhUUHhWN3VGeWo0ZzdjSUxKd0k3eFFX?=
 =?utf-8?B?aG11NHJIQVo0S0JkSWZWQWdpNGFiaGV6OXRTc1d5cVN2UkM1ZXpCeCtXeExu?=
 =?utf-8?B?T1JadHRmRlY3WmFuT0ZVWm56U2kyYzhWK2s2TkxCUHpxZUptYTcxVXdhL2k0?=
 =?utf-8?B?QWhmM05iQmZKdGNOVkNmQ3pIYUVUL2FCUVVxQjJwR2RCazFsM1FPWkdoWEE3?=
 =?utf-8?B?QVZwQndRdFB4UDFhNHBmUlRmY0xwMmwrMUxWV2xBUVo3dTNWYWI3ZHlCSGs0?=
 =?utf-8?B?ZEhlV1F3MW84VDJXeU1aNU1XT2xhVzAvR1N6eVJoTW1VajdzemxpS1dObkpK?=
 =?utf-8?B?TkJhYUJDblZRVHpUcjE3K1EyNzdzUnA2aUNuWU5hb0MvVWcra21BN2FpUmdy?=
 =?utf-8?B?VWp2TEVwQWRwSDcrYzNhL29XalgzQkR3aStiNGg4UHVjaDFLcjN3MWVDMS92?=
 =?utf-8?B?SHNVV2l5a202U2IyeGQ2dXVZNkxJMVUrWWlyZTNxb0pzbFNreUVXMG9XSWVN?=
 =?utf-8?B?VUJkMldHSTJXWnpIenphNGdXcTFGNk5NR0dMUm8xRWhVOG9HREVzYjlLdmRy?=
 =?utf-8?B?K2lyUUhySjBvbDJRazJKYXI4MGFtaVFUWUJrWUNwZ3g0MWo0OUl4ejdKYzZK?=
 =?utf-8?B?OWdMS2U5bjhLRW83NTIwRTRnNWFqZmJEdzJnZzFidStJQVZMSGg1MDRUQWtv?=
 =?utf-8?B?U1R2ZkhlM2VQODVyWWUyNmZaVEIxak9PeHBiUVh6V1N6Z0xsZk5EWXpYamRH?=
 =?utf-8?B?a1MzbU9mL3pTRVNzUGVPdHFETnZRZDBoZXd0MkJ4Ky8rOGFYbm5YWHpYL3Zp?=
 =?utf-8?Q?7vJ3iiV99Ls=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN3PR01MB9212.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bmZTK2ZpMThhTnZHV0d1N1Q0WmNDdVpHNThxM1VaU3hNNXFGZ214YW5tM3hE?=
 =?utf-8?B?MUxGd2tFQ211MUU1R1FOZGQrZ2lyRkp0dVZhZnJ5dDJoUVFNNU1DMWQ1OGFP?=
 =?utf-8?B?YzhwUkgvNGtoK3JFTFF0TlVDdUFIWXc0VnkxQitjL0R6S040R2RsSS9aV05G?=
 =?utf-8?B?ck9BNmxsSlNlNUs0dkdkYWM3OC9Kam5mbG0rWWwwQ2hpNm42Rmt2NUdyalNz?=
 =?utf-8?B?OEVCbExtaUdxeVFZWXorR3RuN21oZHFBY1NWd1lQajVPS09kQVI3UEhyL3lL?=
 =?utf-8?B?N1lvMWhQRnp6OUZ1OXFRVXVxbG5SaS9zaWM4L0xnNFVYNG42KytkNDZOQTdF?=
 =?utf-8?B?RzZva0k4QlZVanU1YUxPSW1vcUZUdnRUOVpSa0w4WEN2WVEwU1VYS2NFVXk3?=
 =?utf-8?B?cDlaa3JIWnFjcmJrZkp3clZJTFVidDBTNGlxb3FFSHRqWTFhR2xidXJJaXh5?=
 =?utf-8?B?eSs2ZTgyUDZCNkVadWJ1U01mR09pWU10ZHJlak5nWkptekwwVXc1TDhlUW1M?=
 =?utf-8?B?NG9lTk8vc2t5d2lGMnBDZVc4YTNXMDFkR2E0MzNwblhHZFNUUVlhUHNYQ2h3?=
 =?utf-8?B?TGxZdFZNU0FBYkdYVHh4NEhyczFmakJPVW1CUEtsWHpPMHJhbDZQWlUvM3Nz?=
 =?utf-8?B?SmI2WDA5a09PVnFLeWZmOVBkdi8vZE9ONERsRzJxQTU3emJ3LzFWSGc2cFAx?=
 =?utf-8?B?SjZHRis3dTN1QnN2SGhPWjVWN3ZyS3BmUi9zdzlHL3FGSmFKWXdicHpYQXd5?=
 =?utf-8?B?S2xGdmM4MGhpcm9QdUxGeURhTTNqMmZwMW1UY1JybG5URFVENUFMZm4zOWNl?=
 =?utf-8?B?dGVSMmZRN0JoMVVhcERwRWRGaTRCVnNYWi8za0pJd2ZFVFhlZVZadDQrQ1Bi?=
 =?utf-8?B?Tmk5VnhxWmtJQXJGbUNCNUpUWnM4T1AyOGZoOWtPMEllOElZZDhLUjhXNXJY?=
 =?utf-8?B?TnZxV0kvR2d5VDJHZnA2MGJ2WjVndTl2eUY3aUNSNVRKNVlpRkJIMDZUOTBB?=
 =?utf-8?B?WGJvdmRLZ2JEcHMrOXd5WGp1ZXlJU1VaTFBKWERBdHBqaTFDOER4dkgxRVd2?=
 =?utf-8?B?elREemg0Rm5EeTl4Z3VOMGxlWGtuSVJVY1RaR1Fydlk1UjV0SFpSaEJGaG5o?=
 =?utf-8?B?WFV0ZGE3clg0Ny8vT2Q3WVdUNkxMSjJzNDd4V3JoUUJmQ3ducG5jNW42WU9r?=
 =?utf-8?B?dW5HVHJ6d0VDK0trL2R1bTU5Q1dCbDBIWG1GaE8xTjFVRGNCMlpTMDlnWHZR?=
 =?utf-8?B?NlFObm5Jcm1pR3ZlV1RRRnowTkhjREtQNkh2S1N2NHRibjZDNDcxY1pjdVQ0?=
 =?utf-8?B?TlpqRjU4M3ZqSUZ1MGZYamFnWHBQSWp4OEl3UXI2bmljMWI2Q01WeC9aUWsr?=
 =?utf-8?B?K0g0RnIyQTkwRzVmMVk2SE5hUVF1ZDF0V1JWSitPM3o1K0xjSWdFeGJ0VWZu?=
 =?utf-8?B?MmYvR2k0WXJoYVViS3NKWWMrdDVrM3hoYTJVbDBodnBTVGIvM01zWDE0ZHZG?=
 =?utf-8?B?TmFBRWcyNWlBVVVxdWVuemNZc2FlUGc3cjBtQ1d3M3B2dVZYdGJvclhremVU?=
 =?utf-8?B?dC9yQitMUHRBYzlqcTRNL1NGQlExb3VkenlyWkZIOTUrQTdqVXhYdjFGeWIr?=
 =?utf-8?B?TDVBb3g1YkpLaUNZVFdsWjd4SEdGK3Q3RjFOT1NWMzg5dTQ1RnE4c2IzOTQ5?=
 =?utf-8?B?SlVxNnVoVjhoRzM2SEQvcVBaMlNTZm9scWRxeW42Y3M0V1Vna0Zwb0hwcmpH?=
 =?utf-8?B?MmJtRkVtUWtsZkpHdFdFcU9Vb0dZWUs5UDVKdmR3M2J0OHhHMWlnL1lIUTAx?=
 =?utf-8?B?S3ZLRFhlRm5DZEVkOGlPSy9Vd0l6TzRJVUpGRDRzVnVXUFVJRmNFWG9wYitQ?=
 =?utf-8?B?YkxaZW0vZkFRaWUrVGhjbU1MVzByTnNWQlhpNHNuN3d3TjNxME8waGtpUS9m?=
 =?utf-8?B?R0R5VHQ1anNuSTFMNVMxSDVjSVBXU1J0Wk5ET2I0akUzaWg3VFlFYjRxbDdl?=
 =?utf-8?B?Tm5YTnYydnNpSEY2SFc1RUpDVVliYW1wUDJKMHAwN25ETTd3L3lJdTFNSTRZ?=
 =?utf-8?B?b2lXcXhiaFUxT3VOVFZmcnpjZ240WDBPcUxoaDJGL3BzOUM4S3lPZzhJYTNC?=
 =?utf-8?B?TlZyTlBOT2orTlkvcVVtNStTeW1lOFk2dVRWVk9xZWxZa2hZY0ZIZ3dCMjVa?=
 =?utf-8?B?ZG1BdTBadFFFckhxMEZvMmszcWx2NCt4TFJZTFVZb2JLREE2bm9VaEJzYUho?=
 =?utf-8?Q?81YU9ndFPwd2eLkWKII6BjJB6Rjgi7HyXcCukzc81Y=3D?=
X-OriginatorOrg: amperemail.onmicrosoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8de4a08d-04a8-4886-57e2-08ddea96d3f6
X-MS-Exchange-CrossTenant-AuthSource: BN3PR01MB9212.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 03:06:08.0421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EpUCR04BAfRq5etB9ZcfO1zSGwG0miQyMNV0u8j9HXIbj+gzU25Ght0cKuZmSKCcmwxkaKGLnURkJGRSksmfieg5KHO8clibpDd0w8s8/ew+y3HaibqQpXj43iUirhGB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR01MB7360


On 9/2/25 18:45, Adam Young wrote:
>>>> +static int mctp_pcc_ndo_stop(struct net_device *ndev)
>>>> +{
>>>> +       struct mctp_pcc_ndev *mctp_pcc_ndev =
>>>> +           netdev_priv(ndev);
>>> Minor: Unneeded wrapping here, and it seems to be suppressing the
>>> warning about a blank line after declarations.
>> The Reverse XMasstree format checker I am using seems overly strict.  I
>> will try to unwrap all of these.  Is it better to do a separate variable
>> initialization?  Seems a bad coding practice for just a format decision
>> that is purely aesthetic. But this one is simple to fix.
> That shouldn't be tripping any RCT checks here, as it's just one
> variable init?
>
>     mctp_pcc_ndev *mctp_pcc_ndev = netdev_priv(ndev);
>
> Keep it in one if possible (as you have done). 


The issue is being moved around.  After my current set of changes, it 
ends up like this:
static int initialize_MTU(struct net_device *ndev)
{
         struct mctp_pcc_ndev *mctp_pcc_ndev = netdev_priv(ndev);
         struct mctp_pcc_mailbox *outbox
                 = &mctp_pcc_ndev->outbox;
         int mctp_pcc_mtu;


Without the wrapping I get:
WARNING: Violation(s) in mctp-pcc.c
Line 275
     struct mctp_pcc_ndev *mctp_pcc_ndev = netdev_priv(ndev);
     struct mctp_pcc_mailbox *outbox = &mctp_pcc_ndev->outbox;

I could move the initialization of outbox, but that seems wrong. The 
wrapping is the least bad option here.





