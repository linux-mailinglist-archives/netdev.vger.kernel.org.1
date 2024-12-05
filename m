Return-Path: <netdev+bounces-149403-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFDD69E57F0
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 14:55:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 642A6284204
	for <lists+netdev@lfdr.de>; Thu,  5 Dec 2024 13:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1F32219A65;
	Thu,  5 Dec 2024 13:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AUkLzDDk"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2053.outbound.protection.outlook.com [40.107.236.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4CF218EBA;
	Thu,  5 Dec 2024 13:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733406935; cv=fail; b=ncuYrkFGNKFLCw1p7mIXFce/1xdymJkEDI9lJDyRtI1MI2nkXPEg3TH2xjn5XBjGuxZHWTru5oe5kVMm42kOi6YEXvqgi9lhLixwmMase8yLFfwjTpuT+nmLRx11MRe4sr//paZzc/QUkSzavlCn9hmh9z51ZMfyiV+s83Sqoho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733406935; c=relaxed/simple;
	bh=uZdFisk/F5dD55MnCzG2hiYhOszFeqJw7zZdr6Rzi44=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Vo2QU+2+e2KIQnyyvaErXeVIREdQa7ydAe9sQzuagfD71nW7wPzmNsk/Fwzqpuc43Vu07OJF4/QamdRJSIVHadRnUYPXS6n2I9D9Xi9KZWhtMv0PR3AQgfcr0tAK4FofEIE8NkevhrO9ZkA4wrKXRomkrUNHwaLXSJ5+gNGp8n8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AUkLzDDk; arc=fail smtp.client-ip=40.107.236.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CYSa2Rwhz+bUrlMO78Z+6xF70yYveVuiDTD9fVezHvnuygLDOTDXZNX5Q/N/VaCwFS5yRkGBMgCSN5fFM2crk2MN15HkP4JlUoTbb7PRMc1Bt2yvKZ9Pm8pvS67gfhNNVENbMKFn/Y+JvSSEVPQVj774BkGc7RhQKG4xQjsU/GdoCC9ltKwIIcIVDs/SVqDNtpiV0MKQMvMb9CxEfjZR+jS3XAuTEQTWOHIKVs1D/rSSbrWYyNH14fQIDJtPuk0ikRk6UicrUm8NZAe61/kX1ijF/5qufEJsCuOyjEZyaOBT1/jUvl/i4c86u4ZhH642vTWc8dBLH9b/nYaw5uyHaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=232t4n5PDUpymulw/AfE7CDRWTglqEbr5Z933Hak+7Y=;
 b=WdYa+zyRVtUkpm5Q4U6MNxuaXcoAspOKxVAS2B2xxd7ke0K2pGK9/WelSjG+/kKix51Lab/v18y1tZEaOOCX/RDypmF8JpP7Kj9Jto9Y4p383PWmpEu1vRlkf3zzebszcZlD9lmkk9buJDYXtyc/4mSP9djukKKKqxd/1UhPKrqciIC1WDfAPPvSostXdFouEOWJyw+KN+h+QtLCP9cdFCp6Bj/9QnhV/R0nHnZruM0EJQvEtzbpD5QxxzmBjYnbQW13Pd9Kc/bYrPIUu0cyPCU6hLPEbZVHMPnCjHPyEpfKgpZoJMJwutMHnrNj6zdMq76lRMFYEA4UCMcyt7IScg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=232t4n5PDUpymulw/AfE7CDRWTglqEbr5Z933Hak+7Y=;
 b=AUkLzDDkT6pYsHQNBpyZPXJFmwDAzYVzLh42xmCt1YC9T+5JTFBfkt0j4fp5GzNAAUy3NwxfDgtPnM4VF3Re1ffKPVywLxmgu0yh+nTvhpkSeEwsl+PNTh43D09JDiDXu+v9TCLFQeQGMaecwYcCy0i2Zjfjc5RovRbYOlB8wLx4lMd2izbj0llPtIdGnA/m9X/Jvt6Te823+ykbKXMg0uac9ThozdKKbm4gRikYWZzOVK7rgMAzMhNYKmpNFFuYfaaU1eNpnwUTbTBtiItazIqByNugy8ZanTUdusBoasmenVCx649zMyACruJ7jG+w5BQhAEt14diodFUvUBa5/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by MN2PR12MB4358.namprd12.prod.outlook.com (2603:10b6:208:24f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Thu, 5 Dec
 2024 13:55:29 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%2]) with mapi id 15.20.8207.017; Thu, 5 Dec 2024
 13:55:29 +0000
Message-ID: <566fb566-4806-41bc-ae6f-7f4ef5762a7b@nvidia.com>
Date: Thu, 5 Dec 2024 13:55:24 +0000
User-Agent: Mozilla Thunderbird
From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH net v1] net: stmmac: TSO: Fix unaligned DMA unmap for
 non-paged SKB data
To: Furong Xu <0x1207@gmail.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: andrew+netdev@lunn.ch, Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, xfr@outlook.com,
 Thierry Reding <thierry.reding@gmail.com>,
 Russell King <linux@armlinux.org.uk>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
References: <20241205091830.3719609-1-0x1207@gmail.com>
Content-Language: en-US
In-Reply-To: <20241205091830.3719609-1-0x1207@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0524.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2c5::9) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|MN2PR12MB4358:EE_
X-MS-Office365-Filtering-Correlation-Id: 33ddd82b-f888-4ffc-ff8c-08dd15347a7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aDlTcStiZDVqeDdlbWJnRm00VmZNWUh2NEh6RjJHbGRBSU1XRUZHQldvZkV4?=
 =?utf-8?B?RlNtTHJVa3pYVWhJQVF5TkdhQTVPdDNiTi8vTU9SdjhORmdVUXN0UnZsZWpK?=
 =?utf-8?B?ZTZhSjFhMFRRQy9HeGVPTklrSlJ0bEdGZUNMOXVyU0dtTXFmekhCa0JBQlhN?=
 =?utf-8?B?WWdlb05NN2tUd3hyRy9JbCs3c0Z1V05QWXZvZ2FwU3VhQjdOVSt1T3FVMDU3?=
 =?utf-8?B?bHJuUDNBbkxuYmtoMjI2QURWSGRiUkxMaFRXcmgyMHB6SXJmRjVCR0toSTFI?=
 =?utf-8?B?NkhGQ1NWbnRUZmlUc29qN3VwUDMrTGlhaXF4bDB5TjlUcGh0Q1lqU2paTk1j?=
 =?utf-8?B?SGYxYlgrRFpudjBhbCtxV3dKM1pvOUIrbGE1Zk1VYmRGK3c4RVpiSjBGZUR3?=
 =?utf-8?B?WXc1SUg5UWZ3VFhWTVhpZjF5KzBzVmxmN0REdG82K1pDZytST0lZOTVpOCt0?=
 =?utf-8?B?REQwZWx6Qit6N0piLzlOYUZRRkxtQWRUc3I2NnhvVjNmcWxSdng0SkJlSSs5?=
 =?utf-8?B?WHVhWm41UEIxOWNYSk9uRlZnOWdjclV1a0hzQjhMYmJ2YVRTazZ3UGkvNGVR?=
 =?utf-8?B?MG1Ib2VKa2hzZ25jdVJld3puUUFHTWg4bEQyd3ZidThva0lkUHBySGJEQ2lG?=
 =?utf-8?B?QmU3Y1Evbk11NGRZc0I5emRpNktWRm1DcDcvVm1vdGJzTXlHbldXd2FBVXZE?=
 =?utf-8?B?cnZFaXBHYUJwMW85SHpPOG5WVmxoRTZQVnYvWmZzSUF3VkRLSnZIWTFJODkz?=
 =?utf-8?B?UW43S2svaUpUazlRSGZCdzRBWEREMUEwekY2SWdXYTBmTlZmYTFhUmJsbHJo?=
 =?utf-8?B?UHpLR0NtckJ1SEpmOFF0S09IekF2Y2V2dVBrRitOeFJ6ZjVtSXlQRzdmNEtK?=
 =?utf-8?B?TVFVdlc5bVRaTExLZXhyMG9aTTREbjVDUVBGQWpqakFSTzQwMyt4eHFvZGpD?=
 =?utf-8?B?aDR6d2FQRGNDSVN6b3RxLzRTQ1RQYlh6RVdUblpZQ2FRR0xBcHp6ZzdGVlJD?=
 =?utf-8?B?dkwzTEszdjNYZURudHVVRHM4QWhGaHQ4QTcvdGxvZHlHaisrcHVXcmxIdit1?=
 =?utf-8?B?VExITzZ0Yk1sK3huMDBGWFF5eGdzYTdpdDFKT2Evcm1GZ2xJNVF3ZXpSNEJv?=
 =?utf-8?B?cS9NRVFFQitWd1BnUzVCMk5PRDFBMlJtKzNISjhRU0JBV25EdDVsdDVGaHBQ?=
 =?utf-8?B?bU9MVFhKa1dZdGp5Z2xURzhVWlVwL0Rpdm1UclpzaTM5SnhGSmRKOVBHbUpV?=
 =?utf-8?B?NVFlQXZvRHFYWGw1QktPd3pEVTFTTm1nVktPWXdSbGxjRDEyVU5qM2hNM0kv?=
 =?utf-8?B?c0dKSVpGRkdjTmY3RjlKd1lTUlJTYnArL05IQ29xRC9FSm14dFNNQjJwOG85?=
 =?utf-8?B?VXd4TXVVNUpCL056NDdyRU9nODdqVVE3NzFYQjhyOGUwc1VvQnVmVlY2ZWZ3?=
 =?utf-8?B?YzREaFdidlYwd2l5OXB5eHJmVEphREVwYW5nMWZsUWVXa0ZnVlhLb09YNUFi?=
 =?utf-8?B?QTB1dS8wK2F1YVBxSWZNSkFueGp3NUt3TmxLTmNXcTVOMEtIUHdlSjc4QkRX?=
 =?utf-8?B?TThlY0ZpSlNWRmltdEFFc0I4VzRLNXZweHJkR25jajhLS0dBeVdVV1NqbCtX?=
 =?utf-8?B?MllTOGFKNllxT1RvTjZkUmNtRXFobjEyTHdXeU9iRWRkUGM5ODQ0MEFzc05F?=
 =?utf-8?B?QU1ldVUzSk8rZTlXMUF0SnVSVS85NUpBcjFDeHUyTUxuQXlPNmRFVUZSSWpi?=
 =?utf-8?B?VzBkSkRsL1ErMHpwMzFkY01qVDA4SE1KUVF0NzNYUzE4ZC9lbUpacTNKNFg0?=
 =?utf-8?Q?Mr+ipQ0GJZfQJjXXDXWu17LWqBBqq8C+guSo0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WS9OWnJuUkVvMGJFcXkzdEZXSUY4aFhIeGVVdWIreldUUU9CRXZlcmsxU3RP?=
 =?utf-8?B?a0NkWHRsQlcxbjcwKzU4Qk1xeEhXeDBCWjNVZXJ0VzlreUlZSkhEVmNSUVdh?=
 =?utf-8?B?RE1RNTZxMFg1ZUVxTDRwdlppMGY1cjlEQWthMmFTRXVBMFhRU1UzOFJIYXo3?=
 =?utf-8?B?cmg2aVhaaVVyNG4wMlN2OGhuQVcvT1YwNk15b3lteWMzUElKYVVMaE9ldkhh?=
 =?utf-8?B?Z09qS2lTczlxTVh1VFovNjJyUjNYQWs4NENRK2tzQndIYlowV2E3VEwxNmdx?=
 =?utf-8?B?WGpjLytORndSNTFOS3U5RjdvdFgxVUNtaDRVK092U0VaK2FvOURFWGxCZHB5?=
 =?utf-8?B?TTRmTWtoWWw2Tkg5TmprQkR6NVRPb0FVbExhQlRGNDlUd0dBdFdYUk8yN1kr?=
 =?utf-8?B?bE5xdWt1UCtpS0lCVXBXVW8wQzlwYVh1bXkyQWF4am9NWkl1UStnSnlFRTJx?=
 =?utf-8?B?OHN4a0V6K0hXMlhrczAyVjJxY2NQT29iZW9Hc2RUVnN2cUFKODlkS3hJL3Zq?=
 =?utf-8?B?Y0JoZmgxYVpLeDFVZTBJbDVOUE5lVXFhMHRaZCtVZHo0YllMcTI2TXpaamtq?=
 =?utf-8?B?SHFGd2FPKzM5bXkrSGpkQUxhbTVaSnAzcFJDQ3pnMU5FQTE3NTRnOEgyUmhD?=
 =?utf-8?B?MGNLTkJPYzN1d1lwNVdqYjZIWnRiNDFucGMvZEo0TEQ5ZVIwcHNwQmV3b085?=
 =?utf-8?B?bHBBN3pROHpuTFZUTWNWeHlJdE1wV2NvTnNwSzhPbXpQQ3piREhIajFXVFdS?=
 =?utf-8?B?S051Uzl0TXpZY2NpL3M2VVRGVFA4VUdHZkViVmNLYVU5cE40aWhkM2llU3ls?=
 =?utf-8?B?blE3UWZaTWJ2MGMxc0hjZGd0UE83WnJJM3FWYzVLMXFBOERKR241V1VrMFQ3?=
 =?utf-8?B?dFN4MUVHekFjaU5YM2RDeEtFZ2VRVHRCVmZGS0VQcjdibHJqTTV5U2xkZUpY?=
 =?utf-8?B?dzRZVGdtOCtacllYSjR4T2ltS1RWNm1mb1J0RzZQR1FpdTkwQkVnN3dsODAx?=
 =?utf-8?B?U2lCMEhEaTJERDBWWjVhN3M2WDNBL0h4aHM5MjVDZmt2N2FKVXR4eHlJVDdC?=
 =?utf-8?B?RUNqaVFoQlNrNjNvNWxjcncvZHE5dStRQnl5QzNPWXVoQjQ3eEMxOGRQOTRy?=
 =?utf-8?B?bldYZzUybzFxN0dIK0RqS1g0M1VIYzNKTldDYXljaDhWYkJLQ2k2bUpwUjRj?=
 =?utf-8?B?NWxFZUdkVit1M3FJM1EvVmc2aUtsdXF6YU5xVTM5TDMraUNoRmpybGtJL1BX?=
 =?utf-8?B?MjBhY2UrcjMxSTIvYXJKQTEwM3U4Sm00bXlZT0hLaDRPb2tiOTZ6Rzg3QjFn?=
 =?utf-8?B?UzhCd1ZWTkFvcm14V1JTL3d4eHdRRGN2b2xIdmhPbHFiTEZsRTQxWVRWOFZv?=
 =?utf-8?B?cGVBNTZ2TElwZ2hLUnVtaVBranFsSzhGVG5WWVFMNmxvTGw0L1pLYkM1TkFI?=
 =?utf-8?B?ZUZ3RWE2dWRHNzJsMzVKcnZhRUw1YzNFYVFNUWNOeTg1SkpMWG1sNG12MTRY?=
 =?utf-8?B?V1pkQmhsK2kzNnd2OWpWRHFMTUJDRWgzOXNwTjRBRjZNQ29XZTM5bTcxeHhv?=
 =?utf-8?B?ZGlrOFF3bnVTcG5CdnZkYUtVczE2ZGNoWEdhRlZxd2NFODgwbXlRektFbDRZ?=
 =?utf-8?B?ejc0ZndnOGIrNkJRbytIbEx4UHVtZXlaWms0V1BDNTNOWjNoQlRncXZrV1NP?=
 =?utf-8?B?WHA3cVJxZmluWUlKdHRudzJQNnNNSUsvMThHVWQvSFZYcE13TmYwVEdZc1BM?=
 =?utf-8?B?cm9kWW9tYzdvTEIyb2xTMDBtNk5kSmE5cURPMUNRMlVaalV0azIxSDBndzRZ?=
 =?utf-8?B?aWNGbGhlcm9PUk93QmwydjJDL3F4TFRNUHVhY1BJNUF1aHdORXovNUxFQmls?=
 =?utf-8?B?eTZZVStHZTRKZVdwR25HNC9MQ3JqZjRHcnpxWHUveThIWk4weEJIOHdWTGxq?=
 =?utf-8?B?cTN0M04xdEgrZmc3SVBnMjFlOWZsaU9nNHhqUkV3VFN6MWxjNDhMWFdsWk5O?=
 =?utf-8?B?NlNBendTR0xQMFVOMzR0QmdYbFdsQXF6RUFDL09lUnVsbTBQMVRXaTdVM1hQ?=
 =?utf-8?B?ZFozWWRBOWYzSXNVaDBKWERzbU9uZzg4SFVJU1VydkhRMDk1L21KdU9NcXQ2?=
 =?utf-8?Q?Bxjhu3q2ic/y+pqP3b4wzxV4/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33ddd82b-f888-4ffc-ff8c-08dd15347a7a
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2024 13:55:29.5759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lt9eD4HRtLtqKgM3MlBX+yCeIXMBvqg4hZPfE+OskmsGz8IwmFvqfXzPVejXbEF++pHDrqK2tUkzLu/MgWk83w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4358


On 05/12/2024 09:18, Furong Xu wrote:
> Commit 66600fac7a98 ("net: stmmac: TSO: Fix unbalanced DMA map/unmap for
> non-paged SKB data") assigns a wrong DMA buffer address that is added an
> offset of proto_hdr_len to tx_q->tx_skbuff_dma[entry].buf on a certain
> platform that the DMA AXI address width is configured to 40-bit/48-bit,

In our case it is 40/40 ...

  dwc-eth-dwmac 2490000.ethernet: Using 40/40 bits DMA host/device width

> stmmac_tx_clean() will try to unmap this illegal DMA buffer address
> and many crashes are reported: [1] [2].
> 
> This patch guarantees that DMA address is passed to stmmac_tx_clean()
> unmodified and without offset.
> 
> [1] https://lore.kernel.org/all/d8112193-0386-4e14-b516-37c2d838171a@nvidia.com/
> [2] https://lore.kernel.org/all/klkzp5yn5kq5efgtrow6wbvnc46bcqfxs65nz3qy77ujr5turc@bwwhelz2l4dw/
> 
> Reported-by: Jon Hunter <jonathanh@nvidia.com>
> Reported-by: Thierry Reding <thierry.reding@gmail.com>
> Suggested-by: Russell King (Oracle) <linux@armlinux.org.uk>
> Fixes: 66600fac7a98 ("net: stmmac: TSO: Fix unbalanced DMA map/unmap for non-paged SKB data")
> Signed-off-by: Furong Xu <0x1207@gmail.com>
> ---
>   drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 9b262cdad60b..7227f8428b5e 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -4192,8 +4192,8 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
>   	struct stmmac_txq_stats *txq_stats;
>   	struct stmmac_tx_queue *tx_q;
>   	u32 pay_len, mss, queue;
> +	dma_addr_t tso_hdr, des;
>   	u8 proto_hdr_len, hdr;
> -	dma_addr_t des;
>   	bool set_ic;
>   	int i;
>   
> @@ -4279,6 +4279,7 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
>   			     DMA_TO_DEVICE);
>   	if (dma_mapping_error(priv->device, des))
>   		goto dma_map_err;
> +	tso_hdr = des;
>   
>   	if (priv->dma_cap.addr64 <= 32) {
>   		first->des0 = cpu_to_le32(des);
> @@ -4310,7 +4311,7 @@ static netdev_tx_t stmmac_tso_xmit(struct sk_buff *skb, struct net_device *dev)
>   	 * this DMA buffer right after the DMA engine completely finishes the
>   	 * full buffer transmission.
>   	 */
> -	tx_q->tx_skbuff_dma[tx_q->cur_tx].buf = des;
> +	tx_q->tx_skbuff_dma[tx_q->cur_tx].buf = tso_hdr;
>   	tx_q->tx_skbuff_dma[tx_q->cur_tx].len = skb_headlen(skb);
>   	tx_q->tx_skbuff_dma[tx_q->cur_tx].map_as_page = false;
>   	tx_q->tx_skbuff_dma[tx_q->cur_tx].buf_type = STMMAC_TXBUF_T_SKB;

Otherwise ...

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon

-- 
nvpublic


