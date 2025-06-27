Return-Path: <netdev+bounces-201923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E48D6AEB712
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 14:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0276717BB17
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 12:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CB9823B61D;
	Fri, 27 Jun 2025 12:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="IOjPJtY0"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011015.outbound.protection.outlook.com [40.107.130.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A92E19F461
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 12:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751025956; cv=fail; b=B6vGrLvSCP7nmqgUlZnFz07DzE0hHiiV2bZcfQb1tgmQkeYUBIIxmmS7xheo+hhYzIGKq9/ArOtT+EntrooBgvwj3daOZZqizQPaJrH4DtLwniLKW+E8GvlR7vcHLQB5MhSQWkC6k+TfN4cmMckuaTEtUqhmCIWVhNFVTvHMOYA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751025956; c=relaxed/simple;
	bh=0JbCcoDG3EJyUeh6LGGwJWS+q5wWNzGdJedDedPY4CQ=;
	h=Message-ID:Date:Subject:To:References:From:Cc:In-Reply-To:
	 Content-Type:MIME-Version; b=Mp46PaF3tIBtKdevGqDZHelIH7K+vzPw37abl5EgHaoxeJHVBmA0I67ilohqMvKSqfgS1nqIfbT0fdg/3ETQ1/6GHUNTVMGVlOkj2M5Oi8wtc/RaZxxMEuKMMdEqLzc0uBK9ao2SDkepGoEPElwe1e2Y92I0TUxzd1OG4ClehTk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=2n.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=IOjPJtY0; arc=fail smtp.client-ip=40.107.130.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=2n.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VhUg2QlOCnsUhMPe5BbFmWgucEWM6nGlwyNEZY48elqmFHqWUGyxeMvR3KhUPl6VMtRWdqr4L1xfINZ2f9V4l8ZLL0e01wacrKIxbNLFO8phuisul2JgVQnoWyx4Tih6mB6OEr0Czu8AqamsM8yoMz1iC5wsod2hdKbIgqUgUKtV6eGj6EEVSlcU7BnQTMTI/S/FwIyOaibyY/N06wlG+rRE/Z+OU4mf0z62ltrjk6SCMh0MwZjAnAq+9N76+qrTxjJMemjgdnTJQ5XZ9DSuFNfNdRaSxfoOG95nped+WCENn9h4jkg0Yx+J11vmltFqINp09VMz+9PyVJYdkKro6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ugw1iTcTRyznykf49WnwxY1jP30iLqRwst/k403z0Zc=;
 b=QGCGuCTg+lGoCIoyL6Ary8WIKaW/SxN0mQKm321M0/FQlw4cvk5xqe0/Q82VINi5kHSZxxrc4RcE8+aAyFSRh/aWBDX20kzc4WDvZcxqxTkhoAD2/yOW9LhSQXL8rxkMmEi8h2U3jeralvZ5B+56E5WjIn/xnwpGrid3wCTfB9K0VdEFKDUX/NSu1/ASSwOZMY7fxJXqBbafCsFPZ3JsRrZvSSo+VCwzcs+AcGQMkv+iOmvrdpliGjUrwC4uGoebgJG8K6iuNy72ziqRBMwLWKmtP3bfoBn0u4m+tWnOHil0tV7RkMkUwxVyvGyRQOAu3C0IGuadz3hzmY33zxm/5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=2n.com; dmarc=pass action=none header.from=axis.com; dkim=pass
 header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ugw1iTcTRyznykf49WnwxY1jP30iLqRwst/k403z0Zc=;
 b=IOjPJtY0vaUg11+3gxidq6gi5HqMgTtKb7I2UTYE+1U5QQJmuKaREazGOfgvUAIzG6FFSMSX1OgQiTyZQSi/7lrswKOEiJnelMw+Ugkr0xXW5vF21ajiXSAYj9YgV3dtkIylW5rST4PiRCs/4duqr64Ptot4FxZ7sTSQ+2j7mHE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Received: from DB5PR02MB10093.eurprd02.prod.outlook.com (2603:10a6:10:488::13)
 by AS2PR02MB9631.eurprd02.prod.outlook.com (2603:10a6:20b:595::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.33; Fri, 27 Jun
 2025 12:05:49 +0000
Received: from DB5PR02MB10093.eurprd02.prod.outlook.com
 ([fe80::2a25:783c:e73a:a81d]) by DB5PR02MB10093.eurprd02.prod.outlook.com
 ([fe80::2a25:783c:e73a:a81d%4]) with mapi id 15.20.8880.015; Fri, 27 Jun 2025
 12:05:49 +0000
Message-ID: <5909c12e-c957-4477-9012-b3bdb61b2e70@axis.com>
Date: Fri, 27 Jun 2025 14:05:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] dt-bindings: ethernet-phy: add MII-Lite phy interface
 type
To: Krzysztof Kozlowski <krzk@kernel.org>
References: <20250626115619.3659443-1-kamilh@axis.com>
 <20250626115619.3659443-3-kamilh@axis.com>
 <cbf487b5-a3e5-4741-b672-8ba062f86a54@kernel.org>
Content-Language: en-US
From: =?UTF-8?B?S2FtaWwgSG9yw6FrICgyTik=?= <kamilh@axis.com>
Cc: netdev <netdev@vger.kernel.org>
In-Reply-To: <cbf487b5-a3e5-4741-b672-8ba062f86a54@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0214.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e4::10) To DB5PR02MB10093.eurprd02.prod.outlook.com
 (2603:10a6:10:488::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PR02MB10093:EE_|AS2PR02MB9631:EE_
X-MS-Office365-Filtering-Correlation-Id: 43547dc9-b67c-4c57-06da-08ddb572f4c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bXBqQWpPZ0p0SVE3bzVqUWkyZ005QU5JNVVVSWVtcy9iU00wUitKaUlMUXJw?=
 =?utf-8?B?dkFDMFB5Z3lCb0xWQysrVWNsdlZlZ0RHN1h1WTN0alB1alduM2hYRk5vbjBX?=
 =?utf-8?B?d212YjdCNWFVbERJODZsT3NXZ1N0Mng3N3NrUDhCMzFFbytzN29rM0ZCbjha?=
 =?utf-8?B?L2M3TEJqd0NEZ08wS3RXWWNLMkE1OG5BNFNBKzdVMXNvSXE5STY3THRTQXNH?=
 =?utf-8?B?dWFKK3VUbktIa0JSV0dTeWwwcXN1WDkzRDF0Z2VjV3dGTjVuWjBBTlpudTBO?=
 =?utf-8?B?d1AyMnFGUzNaMnUwV1hHZUxiRlZEK1hHTis5SHQ0b0xTRGlPTkM3QXVmblJw?=
 =?utf-8?B?akJaYjUxbmxTQ09wejJ6RFRaaGNUQXY5WmJ4U3pndFowZUozV3lzd3N0dncr?=
 =?utf-8?B?dFlBclhjbElaUXZURUNlNEJNKzM2MFRXcnJFS3p5VVF1V0wrNlJibFBuVGJq?=
 =?utf-8?B?Q2N6d3p0SjJoTERpQUtFcHNsQmdscStjY3lXeXlaVUZyeWhTMHIzdjdZNDNs?=
 =?utf-8?B?RlZKUVpQSXRoWjhPeWpZZmpTZE83dE4xaUdhZHQrMU45bm5SWnNWT0lydmtl?=
 =?utf-8?B?Y2NVZnl4T0VwbGhiRlRDeVd0VlJVYkNsb3duMm1LMkFNLzhEU2ZaUmttUVM0?=
 =?utf-8?B?SXZSZXNqRnpiTWRhOU9HWjlBRTM5aHZRQ3AxYVI2UWFFYnpDeHFKYXBJdFQv?=
 =?utf-8?B?ODBENEVEUWxsa2FKakFhSlhFcDgvTlFaMzhxNVdGbzJpQTcyUkpuMVZ0RWtG?=
 =?utf-8?B?ZlFkWmlXUWgycXUrdFlCa05zU1ZvcjVJR0VteVl3aWI1Y2xnQkp6dFBoa2NF?=
 =?utf-8?B?Y0h3YkJ1SXE3VmUvaGJaalJBQmhSLzYyUnRGV0Q3Vi9OVnd1VVMvRHliS3h1?=
 =?utf-8?B?NFlrQ3BadUJHV3hSWnlLN0s4eXgxeDBRVzcrMG15enU4ZG83NFFpMm9teTN2?=
 =?utf-8?B?SWFCNXNVaGM3UkVsaFNGUTZzU0RHR1MxOWJGZWY3Z0dUUlFuZGtnNU5Cc0dU?=
 =?utf-8?B?NCtGdjV0enJUbFd0SlJLQVRhL1l4QlRKY2pERkdLSkxZMGsvelU0cTg4N1Fx?=
 =?utf-8?B?Qmo0LzB3Rm8ycXlJZTNuM25nRG1vRkhQUU5RbXJiU1poYTBVa3ZaUDV2dGtQ?=
 =?utf-8?B?LytZNWREYU1OUEI1NGtGWUZtL0o1dXAvT3V3Q3ZPK0FkdDI4ZkVhZStsbmMw?=
 =?utf-8?B?K21abXI4b2VuTm00SnZKV054aHNEU2Y4UTVmdkZpSk9SREpjMFJXMUZiRVVI?=
 =?utf-8?B?czhrY0JOaW1lclA0OG1zRjhDMVdwMjdPdDhsU2phZUFSL0JwWmxrcWJkRUEr?=
 =?utf-8?B?OTAzUnBYVXZCL1ZPcHNCTWI4dmVWVlAvK2NUMjhqYUY2cW1WZ0ZEYXZyOUw0?=
 =?utf-8?B?aE9mL1NaR3hKbDRkQ2Z5cjFSRmJqOXBZOHBpcHp0c1pkc1A2bkxrdnFCMnpP?=
 =?utf-8?B?ODNzekRKMWtSRUpRYitQT1pwZkYyMWhGY2xMbk1WakEzRkpNdjNjVDNtS2Nw?=
 =?utf-8?B?QzRzMlFMeXRKNlNMbTJlTzR2MDEzTTRudjVCQlJIbEhUMm9rVUVCa3NjbWZR?=
 =?utf-8?B?ZnpQKy9ndDQwZ05HVkRFdk8vdnFmSHI1QlRzb0lha0ZYUHB1UVFqMFJidFRN?=
 =?utf-8?B?dGM4QWVvZHZGNjBmWGg4YzJiakdLMmRsN3hFeElKeUJrZnNwTGI1Y1FlNVp3?=
 =?utf-8?B?Z2JCdFJMWjA1NVFhLzczNHNHQUg1WDFSaHg3Szl3ZU5KWTNoSCtTVlYwcUVj?=
 =?utf-8?B?SCtzTnE1TlBKWWhNdEpBNHVETlp1UXFyQkVEYklGSndhUEJMQnBNbVJhVVZH?=
 =?utf-8?B?WEtlUlFORTZxakVYK0JIZXlZeUVCMGM5anZkVUFaQ1p1akxSeXhucHpTTVMz?=
 =?utf-8?B?ZVdXaE1BVnUvdGIyZ1FiSmY0MG45VXMvQVJ5Y3FydENtRWZoM2lhb1dsVGlC?=
 =?utf-8?Q?pjxyLe+5Afw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB5PR02MB10093.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VWgyd3k3L2JQODFrOTg5VWtyOTFjeEVkZnJnZ3IzbDFpVFlTbkxJS0VnemNy?=
 =?utf-8?B?S1dYWVpVd2ZqYk12Z3NiZEdXUVJ6L1h5RzV6TG1VcitTa1J5T0dxNmJoZDFo?=
 =?utf-8?B?d1JkUU9FU2kvZnVHYTlzMENTaFgvV0pSY3o4TlZKVTlBcUJocERsTHkxNU93?=
 =?utf-8?B?TDlFaEdySTg5QTJ1Zm9vWTVvL2o0WitVSHhvQXNTQWVTQWlWcmpzcHJnSVhH?=
 =?utf-8?B?bVZLcGw4TExjRkk2WWxIbjNTSGN3Ykl1dEVrYktDenRaSXRoTmxyOWlaZzhT?=
 =?utf-8?B?MENOaE1CeFN0bjlLSkZQMDNvSWx3WklpeUpraXVhTk45dnBVS1VQZ3phcDM4?=
 =?utf-8?B?SXU0Y0NRQzFiOGcxcWtsSDh3blZYRUdTaE5FWTJST3JTRWxGb0RSbnBxNTdr?=
 =?utf-8?B?RTUxRFA4SEFFL0RKMFBER3UwTlVEQTRzVDJTT3hic3RnOFcyZ05hdjJWRkZq?=
 =?utf-8?B?ZEdZNzJ1MWZnWXg4dm0rRTVnSEtJSEhFaTFXSkNqMDVoUnZQZjZTK2d1ZU8x?=
 =?utf-8?B?cjJscVU2MlExRnlkR3YwZkR3WGRxYzJPVmdaeFFyZzNLQnBkQTFZZzJBbEIx?=
 =?utf-8?B?VFowMzlDVEpsYmRnZmFDb25qTndpdHhaMXVCR0lreEV3RG45MDBvOTdEV1gz?=
 =?utf-8?B?K2FWcFNDNnE5WEIvWEtTcGJTNytMa0tQS1R4dmdQRlFndFFML1NBVTlnMFNW?=
 =?utf-8?B?QmtOejk0NHMxL0VzQkNDMUduL001Y04wS3lUNzUvV1JOWWVpbjJVT2E3RDdJ?=
 =?utf-8?B?a0hCaUdmRGREdmJGNVNqNzk2cmEzbFRZaFNDa0F0aWlSYllLdk96ajdadFIy?=
 =?utf-8?B?QXhmM2VPS09sOE5pM2d6RE1NM2pqOXgvRmhxZU1CcCttQm5sYkRtbURrQXdh?=
 =?utf-8?B?L0VtVTdnTWxVaUpTTnh4S0NDbllHNG5sa2pDNFNBT3hLTnlzSFQwc3hDelpv?=
 =?utf-8?B?OEt2eTlqaE04ZWw1OU9lTm1mb1p4UW5IUEplaVc5NTRWRjVybDdnbGlMQUFG?=
 =?utf-8?B?MEpadkRaMWp0SEZOVTZJU2VMcXhjZUhxT01NV085eFNGTUZLRHEzY01BWXEv?=
 =?utf-8?B?N0FjRDdZSzhpSUh4MVVnYThhWk5MRU5BM1A4SFFLU3JMdEtSZ3hPUWx6TUNK?=
 =?utf-8?B?UVpJbTdHQVpLMnUzWXEzOXkyVDNLRmdWd3BkQW9QSnIzRFM4T1RDaE9CVjBk?=
 =?utf-8?B?K1J6dHJjZnBvTGVRbUhMaC9OMHQrU3ZySzFYTnNqWWJMZzIyL1JPdVpKc1Zv?=
 =?utf-8?B?VHltcENwUlJEMDNOZjlPdlJaeGRkdGNwVjhYTEpJK2thdnhCMGg1SmY3M1V3?=
 =?utf-8?B?RjU2aEVCbThnK1VYNU9uTGN4YmRkaWVGdDdPcFluZjRSZm5QZU83b3plaE9j?=
 =?utf-8?B?dVhDcjJkTVRTM09ibDZlckVmajZ2ekN0ZnFRRDA2WU0xN2RIeUJ6U3UyMUcr?=
 =?utf-8?B?YjhvR3NnSEd1U1p5QkpSeDloZXpkVHY3V29ZbUZJT2doQ2FZaVQ2NEd5bXdI?=
 =?utf-8?B?eGxNZTFSbGt4bUhyeUtUV3JOZlBBalV0RzIrc3JJMVphVnlyYWt4d3VNUUU1?=
 =?utf-8?B?VkFhTHdzSnJ3ZUwyWmRnZ21rclhDNU5RSWNrT1gzcjJBSzdXOGhnY0xlU3hh?=
 =?utf-8?B?Q0FxYUU1RnR4SkFkQWtNN2JlRFQyc2Rab3BDSTNHTUExSnNITzRZak9TSFIw?=
 =?utf-8?B?SjNDMFhtN2xNU3g2RG90eDZ6bnJ6T3p4dlhFeG13TzUzOFYrTDRhNGkvdDVq?=
 =?utf-8?B?eEdMbWFHMHFYamEvWHEzWWI2Ri9IQkxXRnkweXRJSXRJYWFQM2hJUDEweTJI?=
 =?utf-8?B?a3hlamlzbWtJY3BiNW1hQkU4TG9OdTVDUi9BOFY1TEFmMzFGeVF4eGdjRFQv?=
 =?utf-8?B?Nm1ybHdmTTBmMlE2ZFhHWjFTOU1iMnJDNnM0RVN0disrMFZCbjZnUXpEdWZG?=
 =?utf-8?B?TThNUjFTT3BVaWhiZzkrZExDNW56V0tmaEZQS0NnSXNsZlY4bWNIaWdvVnJ1?=
 =?utf-8?B?VGg4WU1OQUdWMDAxVGRoQU82ZGJzNnMwWHJCclJOZ2NKcUtUU21CTDRXU1E2?=
 =?utf-8?B?WnZLdUF0TkpiVFRaVE5zQ2tkSlZPU3dod094MVNFT2p3bktWNTd3ZlVmM1lE?=
 =?utf-8?Q?dXL3txgNuAlKb4pNTTYfCYXMc?=
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43547dc9-b67c-4c57-06da-08ddb572f4c5
X-MS-Exchange-CrossTenant-AuthSource: DB5PR02MB10093.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 12:05:49.5072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D0bE+YAmrDu5TdabtmBWO/ie+yVpL9ib1sVwKlB5O/WKRra9+ld6oCdHXyHEL3rW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR02MB9631



On 6/26/25 13:58, Krzysztof Kozlowski wrote:
> On 26/06/2025 13:56, Kamil Horák - 2N wrote:
>> Some Broadcom PHYs are capable to operate in simplified MII mode,
>> without TXER, RXER, CRS and COL signals as defined for the MII.
>> The MII-Lite mode can be used on most Ethernet controllers with full
>> MII interface by just leaving the input signals (RXER, CRS, COL)
>> inactive. The absence of COL signal makes half-duplex link modes
>> impossible but does not interfere with BroadR-Reach link modes on
>> Broadcom PHYs, because they are all full-duplex only.
>>
>> Add new interface type "mii-lite" to phy-connection-type enum.
>>
>> Fixes: 03ab6c244bb0 ("net: phy: bcm-phy-lib: Implement BroadR-Reach link modes")
>> Signed-off-by: Kamil Horák - 2N <kamilh@axis.com>
>> ---
>>   Documentation/devicetree/bindings/net/ethernet-controller.yaml | 1 +
> 
> You just sent v3 (double v3!) of this, no changelog, no explanations.
> 
> Please slow down and don't send the same triple time. Provide changelog,
> as explained in submitting patches.
I am sorry, that was not done intentionally. I would have rather 
cancelled or withdrawn the posts but there is apparently no way to do so :-(

> 
> Best regards,
> Krzysztof

Kamil

