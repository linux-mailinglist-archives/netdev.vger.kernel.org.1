Return-Path: <netdev+bounces-240724-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 259BFC78A07
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 12:02:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 855F6354901
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 11:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682E934A764;
	Fri, 21 Nov 2025 11:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IHqlmeT7"
X-Original-To: netdev@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010057.outbound.protection.outlook.com [52.101.85.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2AA349AF6;
	Fri, 21 Nov 2025 11:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763722906; cv=fail; b=UT7OIutz2u0eXwQj9lshXAZQuMLiBKDdKDs+W/j3iHBwVeBNSXsxExKo05Rs6YURh1bJ4LdBzcoMV4DqduqJkay4pTZHGDqB6ODbuGMurBkSczC9W2R2eS83zxPuT5okuyqCK12cOOgx56WfTUpZl2j//bg4khBt84Bfnbjr0Tg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763722906; c=relaxed/simple;
	bh=tWiLtzaqDN0nJ36uj3cpaw+/BRqxFM4i/xUOJJdg1jI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PgVZvpQzqhJiYG/3mapNTlYLFiXxNps6bJNrhYbFSC00CiXCVsgx5o0uvnumTkwvZvwTwInsrbzxeQug40m0nrt2aMqEi55IhNTduV6Jdcfer49+y7sff2FOfHTTsyXeLyY85D3ezoxr54BrYBrsY5o2rsoKjOYM2JugSprqzM0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IHqlmeT7; arc=fail smtp.client-ip=52.101.85.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wt7KXOWurWE7h3B9AGS9jT5eSTv364Rm2bQcgjYiOSY+0x8rVlFXSsgQ86MTlWrb5maOTC8H6YuV1DF3m9IEQCVqQNqDNp2oZHA9jWOvE1UNJws4cHuM1RVn2b8fsfAhJ9lwJy6QIJWkLT0U4wJh9qzUU3Vtvpks8k+OkxcjRP9ByOVbbSv+Puq5p0nkPPgW/6eGu3wdlnOf9N94Bo+8fU3vqEhYn+wm1B4oWuHfHuatO19QaXnmD7NIgqdZavKoxyleudr/6nrb9/AcoFtl9qI9rOCgQFwNBI9JoUdP6yuWMO/uA9BEV9SzxtuzirD3GK93+1Xh1ZH1OkNI4yU5iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Io340KCcAXzAjsdEIMjL5P659XyjXZEHc8m0jj0tH6A=;
 b=zUJRtj0P3GVXH5gaXOD7CYtVZdl+Ar9VGODQCHdsqn2a9Swqbgn7rXpXXq0DzYte7VnmMEysm7wHJOQqKk6ZiLwqvYIXB4mNKbhtm2gsiZupboz0fZvOLkfMK4P4Qv40+cdvwukHULOnpVwTPi/oFr3zdppKybLivXNtmfXd9CPi4eV6sUmLaUQ8Os/4BH9g1QxS+yJn4cPNFSaGoL3pmLwWN9QvpflqvX0hIpe3txo0+wNgojjXVlPTggHn63E0FZjdfHS9y+N9fAavXqOF9M8F9Qt9UuFSb+5eDG+awUxe5haufl7hFQkKE2X0jrFYCz1BMKGTtUtN72b6pI5O9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Io340KCcAXzAjsdEIMjL5P659XyjXZEHc8m0jj0tH6A=;
 b=IHqlmeT7CxwSCH2v7R7S5BAE4+13ifUQY8Jw6/SGQh8kNGJo3p4q+m2Uy8vaDhdLn3SEqebKRXC4tOTgT0DgYNyS6uDPxTF7el+wK3xxYxnoKES1RDqh2wc2Tw1rgpDP1FMQNfy6UEpoqMsC2kdX70gUFf1mJLtylOzr4Pdhyr8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB4205.namprd12.prod.outlook.com (2603:10b6:208:198::10)
 by PH8PR12MB7027.namprd12.prod.outlook.com (2603:10b6:510:1be::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Fri, 21 Nov
 2025 11:01:41 +0000
Received: from MN2PR12MB4205.namprd12.prod.outlook.com
 ([fe80::cdcb:a990:3743:e0bf]) by MN2PR12MB4205.namprd12.prod.outlook.com
 ([fe80::cdcb:a990:3743:e0bf%6]) with mapi id 15.20.9343.011; Fri, 21 Nov 2025
 11:01:40 +0000
Message-ID: <69e5c565-3a19-4290-b0b5-9a0a749b5045@amd.com>
Date: Fri, 21 Nov 2025 11:01:37 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v21 08/23] cxl/sfc: Map cxl component regs
Content-Language: en-US
To: PJ Waskiewicz <ppwaskie@kernel.org>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, dan.j.williams@intel.com,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
Cc: Edward Cree <ecree.xilinx@gmail.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Ben Cheatham <benjamin.cheatham@amd.com>
References: <20251119192236.2527305-1-alejandro.lucero-palau@amd.com>
 <20251119192236.2527305-9-alejandro.lucero-palau@amd.com>
 <93fdd5d5ded2260c612875943adab8fcfffc3064.camel@kernel.org>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <93fdd5d5ded2260c612875943adab8fcfffc3064.camel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0339.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18c::20) To MN2PR12MB4205.namprd12.prod.outlook.com
 (2603:10b6:208:198::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4205:EE_|PH8PR12MB7027:EE_
X-MS-Office365-Filtering-Correlation-Id: d0b732fb-06fa-40c5-ba53-08de28ed5983
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UjZoT3Z6K0I0TitjK0JHQXp6QmFWckNyYUdFNGJaMStMVVU1Mkkyd0NYeVhS?=
 =?utf-8?B?Umo4SllYNlVXY01sTXU5bGp6R2w3b1FIS29uUm96M0lPc3pEdy9jM2lzUWMx?=
 =?utf-8?B?RngyaWpDM1k5UHcxVTVpcHdiYUJPVW4yd00wOU16dXJOT2pVSk1OSG5WWWJi?=
 =?utf-8?B?dWRmaTVKeUlUaHNpdmZ4eUwrM2d3YWZDUDdPUC9yTjNTVXhoM0pXM2YvNzc3?=
 =?utf-8?B?eGJTTFhRRVErNnBWY0JyVzByT3d5M3YzbnF1dVU1UmhWKzFPTVlBZXpsTzZs?=
 =?utf-8?B?VVFXUmRFY0VGankvMzA3NnU3Nmg5dWJpWHp3WERpMkF6eks3U3VQRWFnS3Jm?=
 =?utf-8?B?MGdiSmVCNzFVdWZ6ckVrTFlVTWpGVnNRN3VyZkFjWmxaaVJPNFZBK1ZGMUNS?=
 =?utf-8?B?dG5YQk1hOHJ5NjNBWmFSbDlkZWY4TkphZ1E1WTFjWVBnYUJlRTBsdG9iT3Nm?=
 =?utf-8?B?Y2l1ZVRGT3lxU1E3eGFjNEJQcldBY0pBR0FpL2llR2dRNlViWU9nVVdxZFdk?=
 =?utf-8?B?WmxrOEx3Z0RZMVVjTjd6bThjaU5Nb0hYOFoxZlZDanJBRDZxcXBNT1B0clZY?=
 =?utf-8?B?Q1FhNWx5bjBoTVlrMlpJaXEzMy9pcVh2RzFGbXR0M21mMm0xY2Rlc2IyTHo3?=
 =?utf-8?B?OEZFOC8vaG5CeE9IczNVNXBHc2VTUHNZZmgvWTVWVEpSUG9tYmZiRGpmNWd3?=
 =?utf-8?B?UE00UkYxd3JMcWpIQUhjblhUMVV3WllCczlNYWZRY0JTTHNUSlNRZDM3RlpB?=
 =?utf-8?B?WTZHdzlQR0dUU2RDbkN3ekZuTldiU21LekJNZjNUZkRvaFlpNVNvbWsrQ0ZC?=
 =?utf-8?B?ZkJJRFkvWWNLRVp2KytiVTJRREYreC81NXFobU5FSEJPOG9RME93U0VHZ1NN?=
 =?utf-8?B?b01iR2tZU2J6aTZnMG9qYXMwdGw5MjBhWTg1MnFPTlZCMWEwbVZhZXBmZU1N?=
 =?utf-8?B?RUVUV2FJVTEzZmxYMzVJaHlPYTNpTmhGU1FRV29sSDdmQ1M3WnlQV21PZnRG?=
 =?utf-8?B?L1NJL1ZsY3ZhMmtiN2ZtTWhqZys1L2dVWitBQ3E4Zng0VWE4bVRnNmI2ZE55?=
 =?utf-8?B?UGI0NUhUY2tNOHRHOVRZTEFmK0YyQlpGRzRnZjdJRGUzeWIvZllPWUYzYkl3?=
 =?utf-8?B?NlJQbDlKS1p2UnZhNWRzSmdlYWZWbTBuZEhyVTFVVlFJSGxpMDl0Nit2VWxy?=
 =?utf-8?B?NEVkMlJlazZyR3Zha25hYnc2UHA1K3dqa09lYTNYVEoxdUppWGNwSUtGQUJR?=
 =?utf-8?B?TmNpaVExbVp4cmJQSUc5eE0yUFp5S2tqK3drYkI1cFNxV014bFJKSHVJbEwy?=
 =?utf-8?B?NnhwclBmbGdORUFXeTA4aWZTUlJ2QzlKVU1zeFRuVXoyaFcvOXhzd1FTUVlx?=
 =?utf-8?B?bjNENnlWYS9vaUh1RGRnUXFXQWJqL1BHcXU2ZzE3MGtGV2VGb2tOeDZEMHVn?=
 =?utf-8?B?K1gxMkpNNFpNczQweWs5ajNhSzk0TlZySlRKZ3BKc3ZnRjk3a1pHMHA5bU5a?=
 =?utf-8?B?b0pPU2M2dVBKMk5ZNFV0eDFqQ1pBVGVaM3g2WndwampzR0lhNXNiY2pibURM?=
 =?utf-8?B?b0VLKzRmeWNzU1c3SlV0d3VwOE5QelE2WC9OWUJVRmhVdkNvQmFRLzNyRVpO?=
 =?utf-8?B?NXVSUTdvTUFsOEh1TXp4eEV6ZEpvcXd4SktzSFVwOFR0REpyT1E4WFYyVDl0?=
 =?utf-8?B?eVo0TFptNkJrSUl2MGNtUEt0OTVzMnQ0RWowS01BS0FvMEVFVDY3N3Z5VXV3?=
 =?utf-8?B?L09BMTJKNy9qa1I5VEJ6S3JRdExXQitQS1p4VXFiKy9wNVVKS1ROTnFlSlVJ?=
 =?utf-8?B?Q1hvQ0NSQ0p0TkpuVzVXWC8zWGM0RXU0M2s3cERaSElzNlNxdUREWDdKU1ly?=
 =?utf-8?B?bDFGMjFXVlhsZ0pPN0tJYVpGTU5xb0pDdForV05zdXNqeDhrT2pTM1o4bjc2?=
 =?utf-8?B?ZFhQbzNWK1VwOUUyVmJDVS94d1dIcklSVXdqWmhBR1JEUC9lRjIyYk5hVmYz?=
 =?utf-8?Q?MLoL1Zo/esMKpmy3qMaqRoRQvfJgyI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4205.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MjBmc0dGbDFXaVZuWXJhaDJHaGErbjRPd21hZUgyL3FBQkpNMWxvdTZQd2ww?=
 =?utf-8?B?UjNhSnE4Znh6T2pUbWR4dmxQem9zVlAwYzBuOGJwMDV2K0g4MDRpWG9teVQ0?=
 =?utf-8?B?bGVBS01IZEpzbXpuY3UzWHBsMkpKREFJWm9rdmJieEt0eEN6cWFDWkZjeXBB?=
 =?utf-8?B?Mmx4d2E4WGlLZ0dncUVFOElId1ZCazBQZk5TTHlQUVJsazd5WWlqNVZ2YkFY?=
 =?utf-8?B?djNaVHBQMVdQakdmRm5HbDB2SjNodUIrM1pQZDNaT0pXaXA1TlcyQlFWbUNO?=
 =?utf-8?B?MHBaajd6bmQxazZmNzhRTHJFOFZFSjdtTmU1amFJcG80dWpLQ1g0eFhGZDVJ?=
 =?utf-8?B?NGk1M1RLNlVBWGNOSWlTNWZoZndDa1JJQVpSMTlOOXRTS1l2cnBjUFpVYXZo?=
 =?utf-8?B?a0wvM1RrMnpUVVZVZHdtTktNYThMOXA2M0wyL1BERStmSkVGZXRXeWhlL0wz?=
 =?utf-8?B?b2tWTHJlRS8rakcvV2FYdFNpWklKaGVoRHA1cEo5V2VkQk1QQ1RNdTBYZGJ0?=
 =?utf-8?B?TWhaL3g1RENlV2l3NHNIa2pibDhTUWdENmZLbXI1RTFFNEVERm1CRTM4VUc2?=
 =?utf-8?B?eTRMWkxlLzlMK0hpWW9QeFhqLzNLbktNeWNoZkxIM1BFZHE2cHFRczF2ZUMw?=
 =?utf-8?B?WEJvMmZNWnRiWGIzdDFTc2JRL3dIY05Ea0pLb0FJYVhOWExNSG13cGVPUGR6?=
 =?utf-8?B?RHF1enUwSzVCb0FtTStSMkloT0NyRHFpU0xNTCtnV3FpRXhSZFFBN1c0azJS?=
 =?utf-8?B?dTFKRE9ZbVlsWmovQ1dOZXJYMDdwRFU1eUY4MUwxR1NJZXY0U3lZckJPUmxH?=
 =?utf-8?B?dnJZanJHcUZMbWJnY2xucVhzYitiSnNzZUdKVS9Zc244MVdCMlVMQStuNUZO?=
 =?utf-8?B?ZFQ1ZVVRWXYyZDAvMkVxS2tidG02cUZrUS9HSUFaWVpKQlYvc25HcEREejE2?=
 =?utf-8?B?LzRuZDJhNHh6TkUyREJCVjVTajFTMlBkbG94QjF3NWNzaE1FOXQ2Uk51d0N5?=
 =?utf-8?B?cmYxSWs0WGI0Nmk0TnlKOGdvdE9QQklKdWkvaGwyV3VHaFZkKzcvcEM2MVdI?=
 =?utf-8?B?alZub2FwQVpxSWdTazFqM2JqaDIzblJKeW5HTVQ3UGtsSXF6ZWxQRCs5K3BQ?=
 =?utf-8?B?NzdsU3JreTlLMWhlVDViSEUvRlNjR3ZjcEI4WGFDZ3I4Rlc5Z01MclMvUFRF?=
 =?utf-8?B?MElLSFdZeHhSeHhBTUJaZ21XS1hwWk9nMUc4QnE0Y0NOOFl0bXlBM0hHS1FN?=
 =?utf-8?B?TDMrRnc2ZTJHTzRveVVDTm4xeVZQM1FHZWNVMTBGek9UUTZ3NzJUWkFIdGhM?=
 =?utf-8?B?OHFST3U5alU4K040M3ZvWU1pTFkvNlBWckpBMHRPbXRUS2xuNmkvblhXRk5m?=
 =?utf-8?B?enJLanBIak1BOTc0eDJDcnV3Z21RUjV1QVpHejM5MThwejVSYVpBLzFQV2Vi?=
 =?utf-8?B?L01obGIycFVUMWpTMloxRFZFNEN3SkNoUEhwdm5xVUxrRVNQSEljK2UydENw?=
 =?utf-8?B?bWNJU3NiQ29FTzJZYU9ZUTFkc3JCMXUrRTZndlpIVnpKd2lpMXhCZVRlbkha?=
 =?utf-8?B?Y3NuV3c1QzdUM3BjVFJic2lqd1N0dlQ2TDYvK3FCOE43TmFmSXRteWtHcU1u?=
 =?utf-8?B?OXpuVFRaTStiZmlsNGtXNTVMM0NwL1loOXR5NTU0NTZvTW14c25JUDdJYTA1?=
 =?utf-8?B?TG1ndkF4cmdkUDA2c1JNZU53SzBNbGYwd2pSQmVIUDNnQ1VmZjhTclNqSkpt?=
 =?utf-8?B?MXFhWDA3a2Z1cS9kdS9QeGEzVHlxZERtQWwxNnRzK3pSbTRLRGxBU09lS0d1?=
 =?utf-8?B?OVhsZGp0TS93T1dRaEFzMG1HaU52azhHZXN2dUM2ZVo2UFVsU3BURTNVekE0?=
 =?utf-8?B?WEpwYWEzeFpIOHJlb2JLRDFOM21qdHJHOWtEeVBOcG1ydE1wdVdtSG03TW0w?=
 =?utf-8?B?L3UwajBiaGNrcUxHNXRPVW1vWnFFVS9vVVB0eno3aHJpdVRMRVhwL1JWYW9u?=
 =?utf-8?B?Wm9GOEZ5b2RlY0Q4eWJnN3QrTmg5NzN3bTdQT3I5N1pBS0xFVGRWTWZKVHpt?=
 =?utf-8?B?LzRkQ0ZJVnlpWThMbkhPWTEzOGZyYkFoSUo2YVFrZUxFTTZXLzd0OGlEckk5?=
 =?utf-8?Q?pYwmobFQ3It9zMIdiBbuEiBMx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0b732fb-06fa-40c5-ba53-08de28ed5983
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4205.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2025 11:01:40.8326
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z5pPTvo8jYUeTbcLRZBxP7OrZl5XdAv28xt9TOnjmn0YQC1Vbk3cIcoVrLjRrTvtJqUy9sFPcOoiU5nHxLdzZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7027


On 11/21/25 06:54, PJ Waskiewicz wrote:
> On Wed, 2025-11-19 at 19:22 +0000, alejandro.lucero-palau@amd.com
> wrote:
>
> Hi Alejandro,


Hi PJ,


<snip>


>> +	}
>> +
>> +	rc = cxl_map_component_regs(&cxl->cxlds.reg_map,
>> +				    &cxl->cxlds.regs.component,
>> +				    BIT(CXL_CM_CAP_CAP_ID_RAS));
> I'm going to reiterate a previous concern here with this.  When all of
> this was in the CXL core, the CXL core owned whatever BAR these
> registers were in in its entirety.  Now with a Type2 device, splitting
> this out has implications.


I have not forgotten your concern and as I said then, I will work on a 
follow-up for this once basic Type2 support patchset goes through.

The client linked to this patchset is the sfc driver and we do not have 
this problem for the card supporting CXL. But I fully understand this is 
a problem for other more than potential Type2 API clients.


> The cxl_map_component_regs() is going to try and map the register map
> you request as a reserved resource, which will fail if this Type2
> driver has the BAR mapped (which basically all of these drivers do).
>
> I think it's worth either a big comment or something explicit in the
> patch description that calls this limitation or restriction out.
> Hardware designers will be caught off-guard if they design their
> hardware where the CXL component regs are in a BAR shared by other
> register maps in their devices.  If they land the CXL regs in the
> middle of that BAR, they will have to do some serious gymnastics in the
> drivers to map pieces of their BAR to allow the kernel to map the
> component regs.  OR...they can have some breadcrumbs to try and design
> the HW where the CXL component regs are at the very beginning or very
> end of their BAR.  That way drivers have an easier way to reserve a
> subset of a contiguous BAR, and allow the kernel to grab the remainder
> for CXL access and management.


I have thought about the proper solution for this and IMO implies to add 
a new argument where the client can specify the already mapped memory 
for getting the CXL regs available to the CXL core. It should not be too 
much complicated, but I prefer to leave it for a follow up. Not sure if 
you want something more complicated where the code can solve this 
without the driver's write awareness, but the call failing could be more 
chatty about this possibility so the user can know.


But I agree the current patchset should at least specifically comment on 
this in the code. I will do so in v22, but if there exists generic 
concern about this case not being supported in the current work, I'll be 
addressing this for such a next patchset version.


Thank you!



>
> I think this is a pretty serious implication that I don't see a way
> around.  But letting a HW designer fall into this hole and realize they
> can only fix it with a horrible set of driver hacks, or a silicon
> respin, really sucks.
>
> Cheers,
> -PJ
>
>> +	if (rc) {
>> +		pci_err(pci_dev, "Failed to map RAS capability.\n");
>> +		return rc;
>> +	}
>> +
>> +	/*
>> +	 * Set media ready explicitly as there are neither mailbox
>> for checking
>> +	 * this state nor the CXL register involved, both not
>> mandatory for
>> +	 * type2.
>> +	 */
>> +	cxl->cxlds.media_ready = true;
>> +
>>   	probe_data->cxl = cxl;
>>   
>>   	return 0;
>> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
>> index 13d448686189..7f2e23bce1f7 100644
>> --- a/include/cxl/cxl.h
>> +++ b/include/cxl/cxl.h
>> @@ -70,6 +70,10 @@ struct cxl_regs {
>>   	);
>>   };
>>   
>> +#define   CXL_CM_CAP_CAP_ID_RAS 0x2
>> +#define   CXL_CM_CAP_CAP_ID_HDM 0x5
>> +#define   CXL_CM_CAP_CAP_HDM_VERSION 1
>> +
>>   struct cxl_reg_map {
>>   	bool valid;
>>   	int id;
>> @@ -223,4 +227,19 @@ struct cxl_dev_state
>> *_devm_cxl_dev_state_create(struct device *dev,
>>   		(drv_struct *)_devm_cxl_dev_state_create(parent,
>> type, serial, dvsec,	\
>>   						
>> sizeof(drv_struct), mbox);	\
>>   	})
>> +
>> +/**
>> + * cxl_map_component_regs - map cxl component registers
>> + *
>> + * @map: cxl register map to update with the mappings
>> + * @regs: cxl component registers to work with
>> + * @map_mask: cxl component regs to map
>> + *
>> + * Returns integer: success (0) or error (-ENOMEM)
>> + *
>> + * Made public for Type2 driver support.
>> + */
>> +int cxl_map_component_regs(const struct cxl_register_map *map,
>> +			   struct cxl_component_regs *regs,
>> +			   unsigned long map_mask);
>>   #endif /* __CXL_CXL_H__ */
>> diff --git a/include/cxl/pci.h b/include/cxl/pci.h
>> new file mode 100644
>> index 000000000000..a172439f08c6
>> --- /dev/null
>> +++ b/include/cxl/pci.h
>> @@ -0,0 +1,21 @@
>> +/* SPDX-License-Identifier: GPL-2.0-only */
>> +/* Copyright(c) 2020 Intel Corporation. All rights reserved. */
>> +
>> +#ifndef __CXL_CXL_PCI_H__
>> +#define __CXL_CXL_PCI_H__
>> +
>> +/* Register Block Identifier (RBI) */
>> +enum cxl_regloc_type {
>> +	CXL_REGLOC_RBI_EMPTY = 0,
>> +	CXL_REGLOC_RBI_COMPONENT,
>> +	CXL_REGLOC_RBI_VIRT,
>> +	CXL_REGLOC_RBI_MEMDEV,
>> +	CXL_REGLOC_RBI_PMU,
>> +	CXL_REGLOC_RBI_TYPES
>> +};
>> +
>> +struct cxl_register_map;
>> +
>> +int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type
>> type,
>> +		       struct cxl_register_map *map);
>> +#endif

