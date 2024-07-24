Return-Path: <netdev+bounces-112731-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B2C393ADEB
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 10:25:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A05281F2128F
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 08:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E3E37A141;
	Wed, 24 Jul 2024 08:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Tn/Ldqv2"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C63AD23;
	Wed, 24 Jul 2024 08:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721809520; cv=fail; b=imLhgyGhrUpfrjn/asPevUXAXMV4rrQtv5bceEYgLxN3nLQ5FeGlXe7NAUw/LuY1vHKKH8Ih7ZDgqM6GY3z5rPZtruofWDq/odNEH83i6nS5WZIiTIJORijxB3ub+JAGU9COa3KjMIl0NvOBnaOwplVk9h7lfQq2zBRxnp6onr0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721809520; c=relaxed/simple;
	bh=3/UV+RWmCe8UJdZaT8sPrEHgV0yhPgKs3SFsysnasS4=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sIuuyz9Jt3//p3Y1QGaVClUxldaZ7yVWH+SpFxHEofdesMS8Ll+dqs7zt++TYUHWFoi4JVlsoLimg+F4dhTZqjIxKCsZ4B5ECVkWUjyWy8yRSEDIxXm3mChAOHHHCXIuJFHyOwHEdVnNCdsAEa2dLveJkpnIbid2CFunw1O1avg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Tn/Ldqv2; arc=fail smtp.client-ip=40.107.244.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I8Hn2NWOv4XV4OFUp/4RP+JZDsdWEj/vgQmHwVXr7cnt98f+7Oy9uUq6Y14GID4ANQ7SbYrRJtGjEYEQldFYkl+YZvaQOJtKWIZBccCncGciA9ock6pLPtxclvmzRgWUHs2CrqNQHxqM/+YP9NyejEiiOw37P3OfQqVZI+Dt/tPBAnBRJlecKkT3e28hjfDgL9w0fMxxn37E2b0l1q1v/SbdoNt1S3eOAD6ct366X1a41F0xisOEp0XUs6OrZ9fs3+2D0XY1Kub9IxokFC5Q2F29TfIoKX3ANcNJ0zTHvTs3oOAyhgKTPz0q3oWdoVfzHYuj4dt3sZMjQz52RFAJlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w71eBTfLtYSGYpS+Qw1AggejR1MoUEQe6+4NQvKhbf0=;
 b=klDoPE/JD6d23CQkj0xa2trFsffgmaiTtOsWPMnG8siGJdtx6fdNSLVmmweCEp8JCNe+9ucBki++3oRZ75Rips+6NGirtQjvU11M20orKFXQ88zm+LKsKueCqJmPhmfIkD8+8U7tnbJx1SXyqIgVZDJU+fAmY3jAdlZ6ZQGENEt3pl1d4u+UtVJjlEWl7L6nS0Xb71BBVPz1wZAzpPAFHyVsZRdLfKEhlZ5Higs5I2o0d/90WGi0nC1PeSTmWqgbGv/ewNmzBdddXUmoGRgoq2Sq/WQ4EP3jWTdOle369m/r5rbkFZ5oaXNEtgMIDv/NQvHogSuLOn/lBnHEsDK7RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w71eBTfLtYSGYpS+Qw1AggejR1MoUEQe6+4NQvKhbf0=;
 b=Tn/Ldqv2WIbklQKJ+bCi+5xLtmLd2L7e9mtU5TkdiuIhDfwExKyY4LN/80M0sCfb0NXXmybnHGrVww6xfg7LRzUl21TV0+iewhVnJjGsJizeZVtZHHGE7UGIz4/2GZLRVkDjUuj/SiHYeFDbpfmFjRQyKOY9Ws55yyIl7M6LTLA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by IA0PR12MB8086.namprd12.prod.outlook.com (2603:10b6:208:403::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Wed, 24 Jul
 2024 08:25:14 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%6]) with mapi id 15.20.7784.013; Wed, 24 Jul 2024
 08:25:12 +0000
Message-ID: <f40312b1-8ac7-973b-5519-ee185eec8560@amd.com>
Date: Wed, 24 Jul 2024 09:24:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 09/15] cxl: define a driver interface for HPA free
 space enumaration
Content-Language: en-US
To: "Li, Ming4" <ming4.li@intel.com>, alejandro.lucero-palau@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org, dan.j.williams@intel.com,
 martin.habets@xilinx.com, edward.cree@amd.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
 richard.hughes@amd.com
References: <20240715172835.24757-1-alejandro.lucero-palau@amd.com>
 <20240715172835.24757-10-alejandro.lucero-palau@amd.com>
 <73311003-6b8e-4140-935a-55bd63a723e6@intel.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <73311003-6b8e-4140-935a-55bd63a723e6@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0663.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:316::10) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|IA0PR12MB8086:EE_
X-MS-Office365-Filtering-Correlation-Id: b35dffa3-c33b-44a8-5eda-08dcabba235b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?REwvRENiZzcwVWhvK3gyR0V4N2tkd2JWZWwyVmlIbTEzVnp4cUJFN3hDajRG?=
 =?utf-8?B?dDR1L1RTeWNPQVF3dlo0MnBEQVR4Wnp1WTJSd0Q3TjUrdHlYMGJQWkZMeHhS?=
 =?utf-8?B?eisrZzh4Y3BNNFVhaUk1MnNZUkkwYXBhY0l6VTl5c0NEdkJXWFJWclVFR2dG?=
 =?utf-8?B?L3crNGV0cjFvUXVNRk1xcjllYnJvUzBtT3YycGMrU1BhWjBSdlVmTzZEYkM2?=
 =?utf-8?B?ZGFzcmRFa0IrakxjTFE0YTZHUVdjR05BTktXazc1WEo5NjV0RDJHRjd0RlFu?=
 =?utf-8?B?ajZBeW1HRzQ2SmROK0VUaWFhNk9iY0hFZVkxMG9QZlB3WTY1My9PVm1QaU9L?=
 =?utf-8?B?NVdxOGlrZlpKb1RmM1dJMUh5TVEvTHpCRjNHbng0dXl0WEgvaDF3ZmxNVFpv?=
 =?utf-8?B?d2NlZkFuY1N4SzJwQzhKUDlKeHdMTTg5amVXWldwc3VLaGxnMXBDK3p0K1J3?=
 =?utf-8?B?akNrbEw0ckgrdFk0a3NDQjJWMHFuT2taWFh3aXlxdEtXZ2o5OWtBcEVsUE9F?=
 =?utf-8?B?NXQ5TGhFMWg4VVp1aTd4RStuUW84T1NWN0p0UTJHc21LQ1pvR1g0UHdYRFlm?=
 =?utf-8?B?c2drVnBqY2NEcjhUbGtweUxtMEpjSFNRL0FYNzZpblBLekl5RFo4VG1ueXV5?=
 =?utf-8?B?aG5Jd0xVdEttMksxR1BLLzgwbU8yZ0ZwTWp2bzBQL2NiTG52cW1GVGdwNkpa?=
 =?utf-8?B?TElEb1VPWjh6TWJYL29JTHJSVXptNEMwRGlkZ253L3FldlZpK2ZaSmdzbXdE?=
 =?utf-8?B?cjRHdGJzTnUzRU9WT3RMUlU2RjdOSm9KS2ZvbkQzQ1dJUDgrTnlWa3QxOERv?=
 =?utf-8?B?YnI1Mjh3blFPSzdJTFhNbHkrdnUvT0hlU3Q5YjhTakJ5ME1mV0NTb1dNaVc4?=
 =?utf-8?B?ai9vSHR3N0VwbS8yMHFoOEI1RnJxV3FIWVlLbFZDNjF2Zlk1UnMxZVlmVytK?=
 =?utf-8?B?eGRvVmRCeXFPTFFDNUxqbmcyUU9NNGRUTEhZSDd0M1pUY25LTXA5YjQ0Nkdo?=
 =?utf-8?B?dEwwaVg2ZFNRcHRMdkdjaDcvUkJETGxXSkZPeWlkWEQxZ2ZVNGZBSEFuVFNa?=
 =?utf-8?B?dnhYUm5EaXZPc0tiNHd5ZWJEOHNYcW02NVJGNzVPeEtJTkxpdFg1TllSR2dL?=
 =?utf-8?B?R2NBWnVmL3hLMVFNREI4emo1ZStoTTVxemNrUU9iU3JWbDlzRENHYUorc3pR?=
 =?utf-8?B?eHk5emhxYnFIMTNSUStrcjhIbWQ1c0R1REpPNHJ5ZE1BR0l5TTlGNjVWWGln?=
 =?utf-8?B?UUJ6WG5zdjVPZVlGWnR2K0I5RnBsYWV5MTRWL2gxUFpXcytVLzNpRXozV0h4?=
 =?utf-8?B?cXpPbmlPRTZlSEx1NCtVNDFmaExBb2dybnVPR1MwNWN5RW1RT0ZtWjQzaElW?=
 =?utf-8?B?WHlCQThyS3NYSk02bEN1L2lyNGczN1JwUm1BVGx5U2FpckhtMm4zMWtBeUlR?=
 =?utf-8?B?TUJ1c05TWDJmNXZQam1iVDEvb1I3bEZGRjdmRUY0VFl5ZjdrOVlEQ2hhZHdK?=
 =?utf-8?B?bkdkWTY3dFNBOURleTVwcjFkYkQ4eFV0cUpQci9zeVV5aFdYcm1IWkgrYzda?=
 =?utf-8?B?K2JlL2M4cGt4UU1BUzBObjlYcHBOSDhHTUZyTFIzUCtMRHMrS3dZY3dMY3NY?=
 =?utf-8?B?V3pRZ1pjbllQVmJuSkJCenYxUmZRWGg5My9QQnhuZ0lhODU1bmRNZXpaYVph?=
 =?utf-8?B?MFJHSU93ek1SWmJqU0NyK0kwWVlyQ1hPUDJqU21aeFZhNkE4cEZPZjNOdlBC?=
 =?utf-8?B?WmluR2hrUFBIZXNhNzlYVFNXWmVQd01sV1gyOHpqMmR6VTlyQTE1aFU5WVl0?=
 =?utf-8?B?N3dOemZITnRiRXdaTkR6UT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VHhHQ0JCM2VIV3ZzNmNwcmdNVlBzUCtIV1JCbGFVSi9IOWhlMFZTRStuemNO?=
 =?utf-8?B?YXpmaC9JNkEwZitPaVRVWVRLUmZwV0VhT01PL3ZuczRad1ZRVXBucjNiSXp4?=
 =?utf-8?B?ckhmbjd6YTBBNjhDd2tzc3IwYWNsZC9vNkNZckluc3g5eUdPajBMQ1d0NmRS?=
 =?utf-8?B?T29MU0ZnQ3A3czFHczJrblgrZ3VGUjBvcWNjcGxSSk9MbTRCZUFnZElwRWhH?=
 =?utf-8?B?d1ZlMDlpbGhCTkx5WWJnUXRHSmRjaTNFeHRYVVBtK2RHUnpSKzY3TDRwdE1F?=
 =?utf-8?B?cEhJREVoZEFPQmR6ZlJhclA3Umo4amN1dUQyQUZ1QjNsbS96VU5rcFZNZ0Vp?=
 =?utf-8?B?ZXZjbHVxZWVZRWNlVmM5RG51SVhIejV3OXBFbTRaY0NCWGZ5c0VJZ0k1elVF?=
 =?utf-8?B?NWNIM2RNNjF4QThlNUNZVllYQVdTZWhaU1dhaTA5ZVhZeEtiVXJjeHQ0Mmx1?=
 =?utf-8?B?NzN2WEQvbGlDWllVRUNRK1d5UVVaazBIWWtJMmFEYy9lRW0xSC9MN2UrK2tC?=
 =?utf-8?B?YWllVmk4OUV6aFRrMk9YRG5VZjVXV2w5NURsVWtZbmZsMXc1UjBzRTluUmc0?=
 =?utf-8?B?SGRVYVRNa1JhdjdGQk01eHFpaDdCOUd2K25PTjdESjJFdkcrUUI3WjBiYlJF?=
 =?utf-8?B?YlVodG1mdmdsbWtBZEpIaTluSVd5eG0rVDFYYXcrMlFsNUptUE9PeXkvSUJu?=
 =?utf-8?B?b3NZSDRUQkQyQlhtNk1HS2RFOXBuOGRSakZYdGtJR3I2bk04c3NnMWRVSHN6?=
 =?utf-8?B?ZWZIUG5LZVFqMEg0RDZJTUVZdzNqL1lxWVdFN2VFZWhZalpWdE1Ea2Y3SXNE?=
 =?utf-8?B?RVhyblJZMjN6a2FWQmhDVVNVR1dwMUZXekZGV0VmRVZNRTFXZXorS1FFSmdn?=
 =?utf-8?B?bndVSEI4NHRZVnhWMUdKUUErbHIxcEo4Yy9rMWtxTkJGOHZ5SVpmQStZTWdP?=
 =?utf-8?B?V3Y3RldYdWJza3c3VTFLeHdmSUxiOWFKeWhXZWIvajdkenAwUW1ZaHpLck9n?=
 =?utf-8?B?NXRsSDNxY3JxaWhwMHNGSmF2Qm01aGsyMnRiZllRd010Ti9hNmJxdmsyeXll?=
 =?utf-8?B?Lzk2MmtGcVJIWWNkZUJsUHMvamRnTVJrazAxZTl0a0t1OU5nUTRLUVVyM0tS?=
 =?utf-8?B?Tmx4Y00wck1VM2ZpZXBBZmxlc2VHMDZhMjVCOGhWNmNvT3pmNEZzei9jNU9x?=
 =?utf-8?B?dXlSMC9QTHlnYnB4NkFFRHNFY0xWVC9xQnRUWWFNL080dm5xRHdHek4yUHRY?=
 =?utf-8?B?L083UnI0clUxVkFwd0RvOC9nQWpvdmdMcEdyVC9hMWlCR1FSdmpkb1VBK0dl?=
 =?utf-8?B?R0tzcXhsTUd4TnRONnp2Y2FCMXZMOWc5Q0tpMlFuazVRRmJsTnFmRHZ2YWNV?=
 =?utf-8?B?RldpYXhMVlFqdGJ2ZXdRa055cVl6M2V5YXFReWFrYTYyY1BWZDlvejZ1Y054?=
 =?utf-8?B?NFFRR3B1cVdzdXRrUklDOVJFV1BKNkRmcnN6Sm1VWHorR1YzQjIyaW10ZFhh?=
 =?utf-8?B?RHNsWUpDZ3hVL0lQdWpLd1U4NnZwSHhOTjBtS1ZHMEJoeXowbFJheFM0bUZm?=
 =?utf-8?B?ZjRnejRQSjhNSVVSWXlUZyttclJXWmYxUkpTNWZaUzJBYnU3a05scDBHMEVU?=
 =?utf-8?B?K3c2cHBOOGo5MzVpMFlkNC9IZkYvTS9lZzM0QmpmbXkzSG56Z2wwbkFWNzVR?=
 =?utf-8?B?cHk5K01NTVBKdVROYm0yZmRudVQ1a1dCcnZUbXNTYU5hSGkwUHlSZ2tOMWZt?=
 =?utf-8?B?MXFjcVVPclFIc2Z1MllrR24zUHU1ZVRQK2ZsN09rRVVNdTcxbVJ1R1NJTm5N?=
 =?utf-8?B?aUVpL1ZhT2RhZzAydUlBY0owNHJWZHkvc2k2SXBLZVZRS2U1eXNMc3JBUXg4?=
 =?utf-8?B?R2RHN3plRmlrLzBiT1ZQdWQ1R0xJN3dady95cWMyUVNFcEJPQVdoNzZ6RlJK?=
 =?utf-8?B?S0hDWUlzZ2FEcVcrR04zcDBFVjljTzNtUVpOQ0V0Q1V1bDN1SlNwZmZwTytj?=
 =?utf-8?B?V0wrV1kwMmVFeXpqeCtSeEQzUVZDdi8vM3JMS3JtdjRNNWpRZzIyQTl0cEZK?=
 =?utf-8?B?Uk56T2FRWjVnSmZRdzc2K25WbkRPQUw2eFh4dS9CbGprWjRVM0lvK3lpTHBu?=
 =?utf-8?Q?3PLyCFu7b9b2NQYyv3RffEwLo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b35dffa3-c33b-44a8-5eda-08dcabba235b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2024 08:25:12.8092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aKLszZkHb5bVH8wtLR3YKyp5Xavp0PkEGMwmcn9KUXsijOnHPY9FcGc7nGhM7kRe1rFhcARMVqHyI7fR8L+MUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8086


On 7/16/24 07:06, Li, Ming4 wrote:
> On 7/16/2024 1:28 AM, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> CXL region creation involves allocating capacity from device DPA
>> (device-physical-address space) and assigning it to decode a given HPA
>> (host-physical-address space). Before determining how much DPA to
>> allocate the amount of available HPA must be determined. Also, not all
>> HPA is create equal, some specifically targets RAM, some target PMEM,
>> some is prepared for device-memory flows like HDM-D and HDM-DB, and some
>> is host-only (HDM-H).
>>
>> Wrap all of those concerns into an API that retrieves a root decoder
>> (platform CXL window) that fits the specified constraints and the
>> capacity available for a new region.
>>
>> Based on https://lore.kernel.org/linux-cxl/168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com/T/#m6fbe775541da3cd477d65fa95c8acdc347345b4f
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
>> ---
>>   drivers/cxl/core/region.c          | 161 +++++++++++++++++++++++++++++
>>   drivers/cxl/cxl.h                  |   3 +
>>   drivers/cxl/cxlmem.h               |   5 +
>>   drivers/net/ethernet/sfc/efx_cxl.c |  14 +++
>>   include/linux/cxl_accel_mem.h      |   9 ++
>>   5 files changed, 192 insertions(+)
>>
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index 538ebd5a64fd..ca464bfef77b 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -702,6 +702,167 @@ static int free_hpa(struct cxl_region *cxlr)
>>   	return 0;
>>   }
>>   
>> +
>> +struct cxlrd_max_context {
>> +	struct device * const *host_bridges;
>> +	int interleave_ways;
>> +	unsigned long flags;
>> +	resource_size_t max_hpa;
>> +	struct cxl_root_decoder *cxlrd;
>> +};
>> +
>> +static int find_max_hpa(struct device *dev, void *data)
>> +{
>> +	struct cxlrd_max_context *ctx = data;
>> +	struct cxl_switch_decoder *cxlsd;
>> +	struct cxl_root_decoder *cxlrd;
>> +	struct resource *res, *prev;
>> +	struct cxl_decoder *cxld;
>> +	resource_size_t max;
>> +	int found;
>> +
>> +	if (!is_root_decoder(dev))
>> +		return 0;
>> +
>> +	cxlrd = to_cxl_root_decoder(dev);
>> +	cxld = &cxlrd->cxlsd.cxld;
>> +	if ((cxld->flags & ctx->flags) != ctx->flags) {
>> +		dev_dbg(dev, "find_max_hpa, flags not matching: %08lx vs %08lx\n",
>> +			      cxld->flags, ctx->flags);
>> +		return 0;
>> +	}
>> +
>> +	/* A Host bridge could have more interleave ways than an
>> +	 * endpoint, couldn´t it?
>> +	 *
>> +	 * What does interleave ways mean here in terms of the requestor?
>> +	 * Why the FFMWS has 0 interleave ways but root port has 1?
>> +	 */
>> +	if (cxld->interleave_ways != ctx->interleave_ways) {
>> +		dev_dbg(dev, "find_max_hpa, interleave_ways  not matching\n");
>> +		return 0;
>> +	}
>> +
>> +	cxlsd = &cxlrd->cxlsd;
>> +
>> +	guard(rwsem_read)(&cxl_region_rwsem);
>> +	found = 0;
>> +	for (int i = 0; i < ctx->interleave_ways; i++)
>> +		for (int j = 0; j < ctx->interleave_ways; j++)
>> +			if (ctx->host_bridges[i] ==
>> +					cxlsd->target[j]->dport_dev) {
>> +				found++;
>> +				break;
>> +			}
>> +
>> +	if (found != ctx->interleave_ways) {
>> +		dev_dbg(dev, "find_max_hpa, no interleave_ways found\n");
>> +		return 0;
>> +	}
>> +
>> +	/*
>> +	 * Walk the root decoder resource range relying on cxl_region_rwsem to
>> +	 * preclude sibling arrival/departure and find the largest free space
>> +	 * gap.
>> +	 */
>> +	lockdep_assert_held_read(&cxl_region_rwsem);
>> +	max = 0;
>> +	res = cxlrd->res->child;
>> +	if (!res)
>> +		max = resource_size(cxlrd->res);
>> +	else
>> +		max = 0;
>> +
>> +	for (prev = NULL; res; prev = res, res = res->sibling) {
>> +		struct resource *next = res->sibling;
>> +		resource_size_t free = 0;
>> +
>> +		if (!prev && res->start > cxlrd->res->start) {
>> +			free = res->start - cxlrd->res->start;
>> +			max = max(free, max);
>> +		}
>> +		if (prev && res->start > prev->end + 1) {
>> +			free = res->start - prev->end + 1;
>> +			max = max(free, max);
>> +		}
>> +		if (next && res->end + 1 < next->start) {
>> +			free = next->start - res->end + 1;
>> +			max = max(free, max);
>> +		}
>> +		if (!next && res->end + 1 < cxlrd->res->end + 1) {
>> +			free = cxlrd->res->end + 1 - res->end + 1;
>> +			max = max(free, max);
>> +		}
>> +	}
>> +
>> +	if (max > ctx->max_hpa) {
>> +		if (ctx->cxlrd)
>> +			put_device(CXLRD_DEV(ctx->cxlrd));
>> +		get_device(CXLRD_DEV(cxlrd));
>> +		ctx->cxlrd = cxlrd;
>> +		ctx->max_hpa = max;
>> +		dev_info(CXLRD_DEV(cxlrd), "found %pa bytes of free space\n", &max);
>> +	}
>> +	return 0;
>> +}
>> +
>> +/**
>> + * cxl_get_hpa_freespace - find a root decoder with free capacity per constraints
>> + * @endpoint: an endpoint that is mapped by the returned decoder
>> + * @interleave_ways: number of entries in @host_bridges
>> + * @flags: CXL_DECODER_F flags for selecting RAM vs PMEM, and HDM-H vs HDM-D[B]
>> + * @max: output parameter of bytes available in the returned decoder
>> + *
>> + * The return tuple of a 'struct cxl_root_decoder' and 'bytes available (@max)'
>> + * is a point in time snapshot. If by the time the caller goes to use this root
>> + * decoder's capacity the capacity is reduced then caller needs to loop and
>> + * retry.
>> + *
>> + * The returned root decoder has an elevated reference count that needs to be
>> + * put with put_device(cxlrd_dev(cxlrd)). Locking context is with
>> + * cxl_{acquire,release}_endpoint(), that ensures removal of the root decoder
>> + * does not race.
>> + */
>> +struct cxl_root_decoder *cxl_get_hpa_freespace(struct cxl_port *endpoint,
>> +					       int interleave_ways,
>> +					       unsigned long flags,
>> +					       resource_size_t *max)
>> +{
>> +
>> +	struct cxlrd_max_context ctx = {
>> +		.host_bridges = &endpoint->host_bridge,
>> +		.interleave_ways = interleave_ways,
>> +		.flags = flags,
>> +	};
>> +	struct cxl_port *root_port;
>> +	struct cxl_root *root;
>> +
>> +	if (!is_cxl_endpoint(endpoint)) {
>> +		dev_dbg(&endpoint->dev, "hpa requestor is not an endpoint\n");
>> +		return ERR_PTR(-EINVAL);
>> +	}
>> +
>> +	root = find_cxl_root(endpoint);
> Could use scope-based resource management  __free() here to drop below put_device(&root_port->dev);
>
> e.g. struct cxl_root *cxl_root __free(put_cxl_root) = find_cxl_root(endpoint);
>

I need to admit not familiar yet with scope-based macros, but I think 
these are different things. The scope of the pointer is inside this 
function, but the data referenced is likely to persist.


  get_device, inside find_cxl_root, is needed to avoid the 
device-related data disappearing while referenced by the code inside 
this function, and at the time of put_device, the data will be freed if 
ref counter reaches 0. Am I missing something?


>> +	if (!root) {
>> +		dev_dbg(&endpoint->dev, "endpoint can not be related to a root port\n");
>> +		return ERR_PTR(-ENXIO);
>> +	}
>> +
>> +	root_port = &root->port;
>> +	down_read(&cxl_region_rwsem);
>> +	device_for_each_child(&root_port->dev, &ctx, find_max_hpa);
>> +	up_read(&cxl_region_rwsem);
>> +	put_device(&root_port->dev);
>> +
>> +	if (!ctx.cxlrd)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	*max = ctx.max_hpa;
>> +	return ctx.cxlrd;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_get_hpa_freespace, CXL);
>> +
>> +
>>   static ssize_t size_store(struct device *dev, struct device_attribute *attr,
>>   			  const char *buf, size_t len)
>>   {
>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>> index 9973430d975f..d3fdd2c1e066 100644
>> --- a/drivers/cxl/cxl.h
>> +++ b/drivers/cxl/cxl.h
>> @@ -770,6 +770,9 @@ struct cxl_decoder *to_cxl_decoder(struct device *dev);
>>   struct cxl_root_decoder *to_cxl_root_decoder(struct device *dev);
>>   struct cxl_switch_decoder *to_cxl_switch_decoder(struct device *dev);
>>   struct cxl_endpoint_decoder *to_cxl_endpoint_decoder(struct device *dev);
>> +
>> +#define CXLRD_DEV(cxlrd) &cxlrd->cxlsd.cxld.dev
>> +
>>   bool is_root_decoder(struct device *dev);
>>   bool is_switch_decoder(struct device *dev);
>>   bool is_endpoint_decoder(struct device *dev);
>> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
>> index 8f2a820bd92d..a0e0795ec064 100644
>> --- a/drivers/cxl/cxlmem.h
>> +++ b/drivers/cxl/cxlmem.h
>> @@ -877,4 +877,9 @@ struct cxl_hdm {
>>   struct seq_file;
>>   struct dentry *cxl_debugfs_create_dir(const char *dir);
>>   void cxl_dpa_debug(struct seq_file *file, struct cxl_dev_state *cxlds);
>> +struct cxl_root_decoder *cxl_get_hpa_freespace(struct cxl_port *endpoint,
>> +					       int interleave_ways,
>> +					       unsigned long flags,
>> +					       resource_size_t *max);
>> +
>>   #endif /* __CXL_MEM_H__ */
>> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
>> index 2cf4837ddfc1..6d49571ccff7 100644
>> --- a/drivers/net/ethernet/sfc/efx_cxl.c
>> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
>> @@ -22,6 +22,7 @@ void efx_cxl_init(struct efx_nic *efx)
>>   {
>>   	struct pci_dev *pci_dev = efx->pci_dev;
>>   	struct efx_cxl *cxl = efx->cxl;
>> +	resource_size_t max = 0;
>>   	struct resource res;
>>   	u16 dvsec;
>>   
>> @@ -74,6 +75,19 @@ void efx_cxl_init(struct efx_nic *efx)
>>   	if (IS_ERR(cxl->endpoint))
>>   		pci_info(pci_dev, "CXL accel acquire endpoint failed");
>>   
>> +	cxl->cxlrd = cxl_get_hpa_freespace(cxl->endpoint, 1,
>> +					    CXL_DECODER_F_RAM | CXL_DECODER_F_TYPE2,
>> +					    &max);
>> +
>> +	if (IS_ERR(cxl->cxlrd)) {
>> +		pci_info(pci_dev, "CXL accel get HPA failed");
>> +		goto out;
>> +	}
>> +
>> +	if (max < EFX_CTPIO_BUFFER_SIZE)
>> +		pci_info(pci_dev, "CXL accel not enough free HPA space %llu < %u\n",
>> +				  max, EFX_CTPIO_BUFFER_SIZE);
>> +out:
>>   	cxl_release_endpoint(cxl->cxlmd, cxl->endpoint);
>>   }
>>   
>> diff --git a/include/linux/cxl_accel_mem.h b/include/linux/cxl_accel_mem.h
>> index 701910021df8..f3e77688ffe0 100644
>> --- a/include/linux/cxl_accel_mem.h
>> +++ b/include/linux/cxl_accel_mem.h
>> @@ -6,6 +6,10 @@
>>   #ifndef __CXL_ACCEL_MEM_H
>>   #define __CXL_ACCEL_MEM_H
>>   
>> +#define CXL_DECODER_F_RAM   BIT(0)
>> +#define CXL_DECODER_F_PMEM  BIT(1)
>> +#define CXL_DECODER_F_TYPE2 BIT(2)
>> +
>>   enum accel_resource{
>>   	CXL_ACCEL_RES_DPA,
>>   	CXL_ACCEL_RES_RAM,
>> @@ -32,4 +36,9 @@ struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
>>   
>>   struct cxl_port *cxl_acquire_endpoint(struct cxl_memdev *cxlmd);
>>   void cxl_release_endpoint(struct cxl_memdev *cxlmd, struct cxl_port *endpoint);
>> +
>> +struct cxl_root_decoder *cxl_get_hpa_freespace(struct cxl_port *endpoint,
>> +					       int interleave_ways,
>> +					       unsigned long flags,
>> +					       resource_size_t *max);
>>   #endif
>

