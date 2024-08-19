Return-Path: <netdev+bounces-119787-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A15956F47
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 17:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8121928188E
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 15:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12EB21384BF;
	Mon, 19 Aug 2024 15:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VupC0wQA"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2080.outbound.protection.outlook.com [40.107.237.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54FF83BBF2;
	Mon, 19 Aug 2024 15:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724082802; cv=fail; b=Get+iiUb1AxI3+qi2/OF38zgpSTkOoJ4TtZa8oZHL9PTOhBE2UtK4MJOWtFDWHXYysvhilKFBEAg+HO9LywxuJiBXSQAqA49hlrksYx4spzzbzcvQjT5FxGc8r1hAfujdJmmFlyFsTW3nDA1wOtNyqkFHGXneugbEOmTXIfWi94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724082802; c=relaxed/simple;
	bh=TKY0Mfi9Wguk/W0Xj/opnT6OQz2mbIRd0hd3kha0n/o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uZIHd0QVBDWswSXfRPpi6Mp2mk3q6Y9bz6TmJWuYDp+oBbmDIbyPJyAg6uE7+vcDEJlSA+RBHGDvBhzA/kFkRznXXz1wEa//ID24F+qxM+RtmjN6hRQNBsz6WJoXXNjmQXala1/HmrRynUtlqm9Qx3WgaiaFfO14n+3Ez9KUKuQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VupC0wQA; arc=fail smtp.client-ip=40.107.237.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fcl2t668QV/yppaZA9Yrqr8dsBsxl3BhD/9eEbORqoIHtn06CoI5eLsvQj90wV0dQg+re6Vcl1D2o0W3pRNWH1UCY5Sbp/izAEs6ibuRcT1sJpRexbV2XRvRn1j0fsGN71S5RUAViqn6OhN8dyPOe+2N+71AYAOWLBebseHQIPF85QIDKYHGQavWEIxBlN1ou+hSNE/qx15NOMIN6oT4dcr6y1BZBDlRWr8y/Uts9eCDvZ7FC4lCXdtvWuR3x3GZo3MuQvxq4LW7iFNZbqNZuNF8u6bXeWl5YSA/UOgYYcrSXfi4UyvHiruU/RR4lo2OPITp2WOdRmDDqyRanT005g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y0LcTEWRWOa3lLdCYs7F7ews9QfoCP83Bs0vQy2xwCM=;
 b=WJywhgOtPD8/UPDmZOXpNKQJgU5BGQQ3IWw1L2HQYYTNvaycbyotUJwCW0HT8jhbVibFJz4AFyhsAOczVSYVeReAG6fbpkXrlVQvQWhO7qG1KseXBhez063DlleGUHUwgU0AqKFVL5q/XkL7FNtAxS4/X9Q837pI7l666YM5dzwLcpbboBUtfJiCWv6eCiNH40WqdoVDzf8fPa2FBKe+Xtl6NBiIzwluT0iLNMXo8uXpmLinezjtBEOMVgerRoXHI00xBiORGDzG/95qSSTWgnm8aDaM3HbMbNVclcFRkPJe0GFYZvJqCagkHcjvSCt9fRztrnPaXMkbMZNf86iOJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y0LcTEWRWOa3lLdCYs7F7ews9QfoCP83Bs0vQy2xwCM=;
 b=VupC0wQAhSd9iAqOMftKpQyZBZSH/Qt3aTayhvX4EDv3k6KZuVEAVihKWhSt+wUp14sbPeppRov/+jwh6P1h6rG7eO/7L+H3HfixQ8WX/01vu8PNqBtWvof7djej1NF7kALceBXaTKuSSTMUpDCaHDJ8yEimOehRL//zBxAwgt4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by BL3PR12MB6401.namprd12.prod.outlook.com (2603:10b6:208:3b1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 15:53:17 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%4]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 15:53:17 +0000
Message-ID: <bc823ebe-b887-bc54-0651-b28362a49a7c@amd.com>
Date: Mon, 19 Aug 2024 16:52:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 10/15] cxl: define a driver interface for DPA
 allocation
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, martin.habets@xilinx.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, richard.hughes@amd.com
References: <20240715172835.24757-1-alejandro.lucero-palau@amd.com>
 <20240715172835.24757-11-alejandro.lucero-palau@amd.com>
 <20240804190718.0000361c@Huawei.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20240804190718.0000361c@Huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0141.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bd::28) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|BL3PR12MB6401:EE_
X-MS-Office365-Filtering-Correlation-Id: 12c3a64f-f405-479a-6d6f-08dcc0670a68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R0YvdGNMSGtLZjFRQ3g0K2xGcjhpS0pGaHRvOERkU2EvclNTZE0wUmgvUDlH?=
 =?utf-8?B?RURpK2xWMVNVTkJCWkkrR1p1UlVKL2ltTS9DRUtZRXFKdFV6dVNtV1l2TXQr?=
 =?utf-8?B?Y0dYeDNjc0hQM3BZUzJpZHJVaW1ZdFJPbnpTT3NCRDBMMmJuM0JnRXRDRWJ4?=
 =?utf-8?B?MFQ2azFDWXFVNVgreGY2czRON0srdjd6T2duNHJ0Q0NPbXZBU1Y4cm5Seis2?=
 =?utf-8?B?VERCbG1JbVAwSUNoR3E0YnBHaW5zNEtzUkhlMytaS1B5aFQwazk3OS9OSU9E?=
 =?utf-8?B?ak9MU0NnM0NwNHZFRlJlT1BISktEOVJ3UDZmRFkwRDhiRzFFdWh3QytoOVJp?=
 =?utf-8?B?NHNGWnliSUxqRzNDWmUrcytEbFZML3B0dVpic1htREg3eFlMVzBQa0YwMktw?=
 =?utf-8?B?K3NuVUVOb0RGYUMxNjhHYXhxZGt1WW40eFFyQWtGT2k0R3dBWXlodzNQVXhh?=
 =?utf-8?B?L21wc0RxSXJURWMxbEtLVk0vM3RRSUFtRWhjT09IN0I1QUpJbnoxeFV3aUNY?=
 =?utf-8?B?NTlxaUJPTEh3a0dMK2lsR3FRSVAzM2lsaUtCNXlIbVFnQXBKUFAyZjZ4Y2lW?=
 =?utf-8?B?QlVTTk8zZytXM0lTL0wyN0lVdFZyV252TnRoM2xnUkE0ZThWWW9KRk1lKzlk?=
 =?utf-8?B?Sy9meVN1ZEtULzFzaVV3a20wNmtvU1ZHTkxOQ2N2dGNtcktSWEQ3eDJjOUds?=
 =?utf-8?B?Y0hsdGVuamJNMXdLUXQzT3ZrUDRQQmZxWXp1QWMzajJsakU3YUN0cGtMTHVr?=
 =?utf-8?B?V1pCSEVubFlyRmFUTmswVTRqdnl6QVBxTjl0L3l0djFaMFE4N2lMOFhZTVpv?=
 =?utf-8?B?UGJRUWZZbWdDVS9TbFpnV0U4VkJMTGxaYWo5bDFmNTRURjRsNTlWNDIzUVhY?=
 =?utf-8?B?QzJTODNWUSsvQmFWeVZHVEdkazZBa0FEOTU4aGE1clFSZnN1Q2daVTdWWHVV?=
 =?utf-8?B?c1JZWmFnYWtOTDBvKzRRM3AwRUhLL1hTQ2xiQmlTQUJBVWswemdiU2dtc21i?=
 =?utf-8?B?R1lOL2NTTlhYbWlydjFLNnNBYmJxeFFxTjcwK0NaMmg5dFFtNmdtZFFBYWdI?=
 =?utf-8?B?aHNaN2pOZFFZZXd4YXovdSs1RmRaMERneVZuQS83YjBlWWQ2YmNUaGt3dVor?=
 =?utf-8?B?allWZHU0MG9NU0kxNmY0Z2lRWGt3SDFsaWFqMFBUVUY2bzFxSDFWZFZBMC9y?=
 =?utf-8?B?eG0zNlBEaHRGeFZsK1I2UUhTay9aR09mYlZIbzVSVVp3S1VSb0MvZWlBRVds?=
 =?utf-8?B?MzhNVU1BcHpzclh0MkxyN1dFbEI0Tmd0WlFKUTNjUTFSMXFTcjZhaUJzcndD?=
 =?utf-8?B?UGZuUTJGU1ZpVmR4Y3A1YUxnaDk4dzJBK3BXc1d2WTZZVzJ3VWk0dW0vb1dF?=
 =?utf-8?B?a2ptcE85RUVmTDdqVnZQektOUkpYWjBOMUJSd1RZb2NpMkNnalVvWVVnalg2?=
 =?utf-8?B?UGtkR3Bjc2NMSXZCYVZmalBjMFR2YU00cUQ0cjlHUndMbEJtd1pDMkJIV0NI?=
 =?utf-8?B?Q21RaTdxY2k2VGVLNCs1M3dpODFaNWZnSVJma3dVUjBZMUFHYzgycGh5YmRv?=
 =?utf-8?B?WnJOdzdNQmZsRmJ6MFBCYTdHTjAxbDVmYkVlZmJkeDRTbTVtRm9QK1hQYXlj?=
 =?utf-8?B?N3J5ajh6SFZnOHZDZFFjSDkyYUZCLzkrSVJKOXRuRzhQKzlPSnlSV0xZNTZ5?=
 =?utf-8?B?akJacHFlM0t4VVFmT3JjTGdvWm95Y3FhL0M5aUhYRzJ5UVFpeDcreHpVNTNM?=
 =?utf-8?Q?VjRGuEynkQbhfuBq2UPZ4ndfIsam0VvpfFNg58F?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SlduUllvNTdrc1BJK1l0cUlzVHJzYjhGQzJFL0FNMGNycXgwN2NiUm1SU3A0?=
 =?utf-8?B?R1VjZjIvRk5NNHM2Y0dzZnBaUWVvN1lCMzJxOGNMdU5Wam00a0ViczJ2dGJq?=
 =?utf-8?B?dy9iQjFrUVM3SXY2QnNXaE0rSmh3aWNZOS9JU3lxWC9PN1hqVkV1TFNhOFFX?=
 =?utf-8?B?eVg5dlM1dXdxdThzTStIY3VEQ29oVThzVjN4a29MWlAzb3pwNzJLOGtOdWpE?=
 =?utf-8?B?Zjk5LzJaUFRhVzF6YU52bFEyeFpqMVdwemxldDF3T1VvNGxyWjZDc05FMjhy?=
 =?utf-8?B?bWphQ0FjTDhVMDVPMDlNNmdjeGYwSURpMVJ4MDdTQzZFdVBsRHRLWUdveXln?=
 =?utf-8?B?Y3kvcE9uWGRhR3d1dDBNMEo3a2tvcWFyWVQ4NUhrWXV4L1NJOVNxYW1YaUJx?=
 =?utf-8?B?VkV0QXBIcnVFNmIzUk9YQWgra0xKTFdFRDdBV3F6Zjh5RUd0cEVSVUJIVlBv?=
 =?utf-8?B?K2VVK0FrM3pEVjJnWnp6TFZsYytDMG5iZHZTQWNPb0VJaXQ1c0lNM2YrZXIr?=
 =?utf-8?B?QXVNWFE3bVVURk5kZWJieURabGNlZUZCT0E0Tm0rUi9KR1RqY2lxTlBUMjE4?=
 =?utf-8?B?c2h4dTR1QUQwRCtJUG5TWGhFV1g0WDZMeitMcnMwMmZWQkpOZnVBR00yS1F6?=
 =?utf-8?B?OG1KME5SZDBDQmRXbk5hYWVXSnQwdmVhQi9INGgwcTE0U3YwZ2ttWHN3bUgy?=
 =?utf-8?B?clh3QUpFQlhQVWRSeWZHdEZtTmNCdm94SEtwa2JYakliNUNTYlhJS3NaUkdo?=
 =?utf-8?B?eHdtaGZiNTVaMlJCK0NtRG5UMEk2RzN1V0d1alF3b0FpNHZaMEtnQU5lVnRs?=
 =?utf-8?B?WkpJZ2d6VHZVMk9wVGdIQVNaQVlrUGhnVGFudDdsMHFpZ3FTT0hoU2FqY1JG?=
 =?utf-8?B?eWk3NDk0SlljYmcvbUllNVZkeHZ3YVhmS1hvK1NXSlNBNHlBMTNaR0lyVVd0?=
 =?utf-8?B?L1Q1cVdUdDlLWUNKaThIZlQxNXVJR0ZnWUsxUGlGdGgraC9qeTNGdysrQjVZ?=
 =?utf-8?B?RGtPdi80TzFBTC8wVlI0emlGT3Z6UWx2cWFidVpaSTJnRTVXcFFDd3NnOUQv?=
 =?utf-8?B?cDVXb1dyY2NXNFdmNFFESW53Z3g1NTZuUGlMQzhVb0RySThsMUpPVjQ3RTQ3?=
 =?utf-8?B?K3BjSktabmh6ejhqWExUNHpzNVNhRmsvMUduYXRMSEg1VkxWRWdBY3U2OUVZ?=
 =?utf-8?B?Y0t3elRPd1h6b05SaC9iWnczdGQzTjdCdTlNazhOWmZVS01vd1pxOTkyNmh0?=
 =?utf-8?B?bUJnMDNJN1dLbkxxd3dQQmdsaG93Z01lSVkzVGlZUGRPOWh4dTJ1NEpQMnZj?=
 =?utf-8?B?V2pmQytiWEJKVVArU1AvNlh5TThyeWN4MUd2Y1ZUQnViVThyY3pyYndpSVRU?=
 =?utf-8?B?dHR4UUFZWnBFRTRseUgzSks2d1ExMW9RYXZDeXd2NTVRRHN3NTVPZ1ZYVHNo?=
 =?utf-8?B?aUlJb0hsRTdkZXhOV2JpRFB1RXdHMlZLTmdaU2ZDMVduQ2VSeWZxRU9RUVRN?=
 =?utf-8?B?Z01NY0M1QjYraWhRdTZqeWEzOExsdi9VZTY1WTZEdUthb0IzY1B0NTFRc3Q4?=
 =?utf-8?B?VVc0Q0dkY25ickd1M28zWDZ6NmdzTHdlRkM1c1JpeFkwUE9yUFFLS0VPZSto?=
 =?utf-8?B?cnZCdXlNeWIxVDNGUERtRGtFTjlCYmpSUWZIT2ZmOHkzZVI3ZEYweHg5MHN3?=
 =?utf-8?B?U09qbFNyenhTb2FVSW5JSWkvOHBxaSt5UGo0TEhVZFJ2a1NoTDlydXlTeFpZ?=
 =?utf-8?B?bXlpa0FjdDk1R2VGNnFmdk1OZ2kvQ0ZLVFF0MHhGb2pJcENBYUNBZm5pOUY5?=
 =?utf-8?B?UTdPSTV1WnFVUEZmSi8vb24xeVUvY2oxNEZ5QW41T3pmN2ludTVOTFRVblR0?=
 =?utf-8?B?dXZTWjFuUnJBcWNTdUtjbGRRK3Vray90VzBFTVNncnZ0VFlXU2VoOGRCSlFZ?=
 =?utf-8?B?eHg2UnVXd2NhZUpNSGxQSEp4VFVDakpOd1ZBTHhyUDBza0R5aUNmYjFveFoz?=
 =?utf-8?B?Y3BvYzRucmdUcHF5N2kyNlNpcVczampuaW4wL29TNnErNC9XaGV1M2l0NWRy?=
 =?utf-8?B?ZmkyaEdoNWRzblJNN000T1dMQk9CYXd3UStrU2ZUYXFkRXoydFRZZEpqaHBG?=
 =?utf-8?Q?oZS7OzuQyPZtCbl0DCHL/6ZuK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12c3a64f-f405-479a-6d6f-08dcc0670a68
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 15:53:17.1519
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I/dNbvAH12hQt6Rt3CGuHFgfF1TEmWHxtzWoRq+6jh3nkM+zQdDzArhgYM1QrvaWqIrSjT0P+Jyw8THqepYV6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6401


On 8/4/24 19:07, Jonathan Cameron wrote:
> On Mon, 15 Jul 2024 18:28:30 +0100
> alejandro.lucero-palau@amd.com wrote:
>
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Region creation involves finding available DPA (device-physical-address)
>> capacity to map into HPA (host-physical-address) space. Given the HPA
>> capacity constraint, define an API, cxl_request_dpa(), that has the
>> flexibility to  map the minimum amount of memory the driver needs to
>> operate vs the total possible that can be mapped given HPA availability.
>>
>> Factor out the core of cxl_dpa_alloc, that does free space scanning,
>> into a cxl_dpa_freespace() helper, and use that to balance the capacity
>> available to map vs the @min and @max arguments to cxl_request_dpa.
>>
>> Based on https://lore.kernel.org/linux-cxl/168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com/T/#m4271ee49a91615c8af54e3ab20679f8be3099393
>>
> Use the permalink link under these to get shorter links.
> https://lore.kernel.org/linux-cxl/168592158743.1948938.7622563891193802610.stgit@dwillia2-xfh.jf.intel.com/
> goes to the same patch.


I'll do.


>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
>
>> +
>> +int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
>> +{
>> +	struct cxl_port *port = cxled_to_port(cxled);
>> +	struct device *dev = &cxled->cxld.dev;
>> +	resource_size_t start, avail, skip;
>> +	int rc;
>> +
>> +	down_write(&cxl_dpa_rwsem);
> Some cleanup.h magic would help here by allowing early returns.
> Needs the scoped lock though to ensure it's released before the
> devm_add_action_or_reset() as I'd guess we will deadlock otherwise
> if that fails.


Yes, I'll try to use it making cleaner code.


>> +	if (cxled->cxld.region) {
>> +		dev_dbg(dev, "EBUSY, decoder attached to %s\n",
>> +			     dev_name(&cxled->cxld.region->dev));
>> +		rc = -EBUSY;
>>   		goto out;
>>   	}
>>   
>> +	if (cxled->cxld.flags & CXL_DECODER_F_ENABLE) {
>> +		dev_dbg(dev, "EBUSY, decoder enabled\n");
>> +		rc = -EBUSY;
>> +		goto out;
>> +	}
>> +
>> +	avail = cxl_dpa_freespace(cxled, &start, &skip);
>> +
>>   	if (size > avail) {
>>   		dev_dbg(dev, "%pa exceeds available %s capacity: %pa\n", &size,
>> -			cxl_decoder_mode_name(cxled->mode), &avail);
>> +			     cxled->mode == CXL_DECODER_RAM ? "ram" : "pmem",
>> +			     &avail);
>>   		rc = -ENOSPC;
>>   		goto out;
>>   	}
>> @@ -550,6 +570,99 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
>>   	return devm_add_action_or_reset(&port->dev, cxl_dpa_release, cxled);
>>   }
>>   
>> +static int find_free_decoder(struct device *dev, void *data)
>> +{
>> +	struct cxl_endpoint_decoder *cxled;
>> +	struct cxl_port *port;
>> +
>> +	if (!is_endpoint_decoder(dev))
>> +		return 0;
>> +
>> +	cxled = to_cxl_endpoint_decoder(dev);
>> +	port = cxled_to_port(cxled);
>> +
>> +	if (cxled->cxld.id != port->hdm_end + 1) {
>> +		return 0;
> No brackets


Sure.


>> +	}
>> +	return 1;
>> +}
>> +
>> +/**
>> + * cxl_request_dpa - search and reserve DPA given input constraints
>> + * @endpoint: an endpoint port with available decoders
>> + * @mode: DPA operation mode (ram vs pmem)
>> + * @min: the minimum amount of capacity the call needs
>> + * @max: extra capacity to allocate after min is satisfied
>> + *
>> + * Given that a region needs to allocate from limited HPA capacity it
>> + * may be the case that a device has more mappable DPA capacity than
>> + * available HPA. So, the expectation is that @min is a driver known
>> + * value for how much capacity is needed, and @max is based the limit of
>> + * how much HPA space is available for a new region.
> We are going to need a policy control on the max value.
> Otherwise, if you have two devices that support huge capacity and
> not enough space, who gets it will just be a race.
>
> Not a problem for now though!


I agree. If CXL ends up being what we hope, these races will need to be 
better handled.

Thanks!


>> + *
>> + * Returns a pinned cxl_decoder with at least @min bytes of capacity
>> + * reserved, or an error pointer. The caller is also expected to own the
>> + * lifetime of the memdev registration associated with the endpoint to
>> + * pin the decoder registered as well.
>> + */
>
>

