Return-Path: <netdev+bounces-137409-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21AEC9A60BA
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 11:54:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD1E62847D3
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 09:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4381E3DFC;
	Mon, 21 Oct 2024 09:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oFuAhglU"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD071E3DF4;
	Mon, 21 Oct 2024 09:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729504457; cv=fail; b=SG9s4QWzH5pT1byf/EE+8MUWuoHoFOP6Bfyge6w1I/D6KHadmM9LreVJ5iCDnyy3cMM1E9lbg7yhZ5tcuSsMp709RULmM0gDirBDjQse9XHHsV4j4O4pfcfwgVxdE94WYwULROk2nhxgIWfgBjvjeZEPo2t1WgeBA3ByBoCBnv4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729504457; c=relaxed/simple;
	bh=IrWZSMw4gW9Jv81CqzJRF0SHaUBSjyaGzn1AwG8nRI0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=s8sEAR0hHIsLPdQdUJwHGP1/AjM97ytZKp8IXOurFiq0xdmSbe/KS2fUBUisDXhbgkTDGo0xay+sPWkgtvPbK4M5r7cLMv7gw7ygz2FzX4ZJNBR0kG3mRD2wCQB/CHiFusCfgAwQVAFLDm7gyFl+k+Y4n0xnSClLGAXJySTytBM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oFuAhglU; arc=fail smtp.client-ip=40.107.220.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yx3pBk+7NnGFQ4Zb8QUAfbyk/CNfFvLGA18HqiAsFa/K4llWzKgv21dALdori6NpYHIwi0bm/F67kK38FYd2ClrXhrG5KnVg/WRfQbp2Q/K3Oa7jK7eerKebpk3nJBmr/asa3kDKMD68oain3tBYSHwEkmb1IVgpWtgsQnoufRjVOCVMbi/0VsJT14hY5D4ZK9Mvh94znJ2/2rUvrADeT7sgLGhbvMwLr3QfnV3/wdp43R1OuwPDi0f/avTi0Oe7+n8a6BijA2T9rJB2QDsi+9GFa2IqwMRzmsbG+42dQWRP8jjVWgz5jJrmHHr1/vzoNvTMvbwYJ3UhfJnyreTQnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/tCHC66x3XqdomSjo2SyljtXZRI3gg/5EyNpMRwmxlc=;
 b=tx0p1hUdmSl4WJs7FoyzkgjujgSEaiXbYdRn7WkO6N1oHa+ypnrfX7G/yG3F/OaSlj5KFfpxQRw7pfUWg06lhHkqieH89XZC+NW1Yd5LYLYxc5C73F3zn7s5CB07dqGCsvu9m2DdzRy6a5Q3h+vBTUCap3qICiSOkaPICDJTaioU2BeJbxObfMKEwre86b3SvyDVlhbbsg+JOscPP/xysQkPZRN3laSHEzA52W5aj35NFrmK8F14JKJnhTSI9s7VBdzRK2RMEOmKGk+uFPLUVRoN4CyfD/afG8rlNeZIIGdmmtOQgFvXwY+9ufG5oJgd2tV0xnkSqVIckeMQowHT1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/tCHC66x3XqdomSjo2SyljtXZRI3gg/5EyNpMRwmxlc=;
 b=oFuAhglUgiJM7v+LjZpARCsL9x6axvCz3LadFizbHn3arRNcj8pY8XOJgyp/tMOckJhOqW1xaEu1WZCr1lXcDEkpSZLMA9FzifKtVefJqA2hgTIQwAqmjWyy6W5YqgnVnpN99PdCEjSeAFrGmGLBGIAXJn53Sz/N3Rh2m4jg0mA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by IA1PR12MB8468.namprd12.prod.outlook.com (2603:10b6:208:445::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 09:54:12 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.8069.027; Mon, 21 Oct 2024
 09:54:12 +0000
Message-ID: <78c928ff-4624-ea21-1c13-58ef61737a53@amd.com>
Date: Mon, 21 Oct 2024 10:54:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 22/26] cxl: allow region creation by type2 drivers
Content-Language: en-US
To: Ben Cheatham <benjamin.cheatham@amd.com>, alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org,
 dan.j.williams@intel.com, martin.habets@xilinx.com, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, edumazet@google.com
References: <20241017165225.21206-1-alejandro.lucero-palau@amd.com>
 <20241017165225.21206-23-alejandro.lucero-palau@amd.com>
 <4b699955-8131-48d8-a698-999d90523261@amd.com>
 <22262215-54de-1a36-056b-5854ff05ccc1@amd.com>
 <54dd9faf-0078-4f3f-b31e-a500bcff64ba@amd.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <54dd9faf-0078-4f3f-b31e-a500bcff64ba@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0082.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:190::15) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|IA1PR12MB8468:EE_
X-MS-Office365-Filtering-Correlation-Id: 43373558-71d7-4a78-a785-08dcf1b65081
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cG1JSWN5RUxhTStzTUlLQkpuT0FSVXRud0RDUXFrdFRHWkFhSkUzc2ZKcit5?=
 =?utf-8?B?UXEwWFdFZUtxRE1iOUw4RiswZHJLQmxGU0RpUlg5Z3V5SkEzUi9nZHVYbTUz?=
 =?utf-8?B?cTY5QnQ1bDdVVlo4NHFVbGJUMEUxNG1jR2x1T3dLQkxtL3NSaXhjcm1lbHhz?=
 =?utf-8?B?TFZMV0pDNk8xdi9EQUFVRWNHUmdFclNYQnp3SGdKQ0pEcWNvWHBaNHQ3Y216?=
 =?utf-8?B?VWc0ZWxhQlY5UWVScDR4ZndRQjhnQ1hmQitPQ3ZaaWZMVFlUWWxOZCs1VUNC?=
 =?utf-8?B?Z2t5akpNcUowbkoxWEF2TWZDWmsvajBrVE9vdWF4M2NCK3JpdXdRM2psSktn?=
 =?utf-8?B?RUdUeW1IUEpUZmdpYjc5L1h0Q01OSXJQYWdZYzlBUTQxNnlwSzhXWDlyYWVL?=
 =?utf-8?B?cXRJaGpQZ1hyeDU4c2dvTGhpcm5LcTBQMWJQTSsrVDBsQTBaQURMZ0ZpVUdj?=
 =?utf-8?B?aSszS1pBc2Z5UHBxeE5ZdjVRL3RWMWpjb2RuaFFKcVhHU3hUTW9HaTQ3ZVF6?=
 =?utf-8?B?bFNwOFBmNFRnQlF0WVdJeFNLajNJdUwwNkNpakp6ZkJ3bE9aUG5zRkJ4T256?=
 =?utf-8?B?Nmk0VG1EQmxnWGorOExxQXAvTmx6UlhYUE9jbnZIakI0OFhHWTVyaGVCQjVu?=
 =?utf-8?B?bGlnVWt2bDlnejVoUXhoaE9iL1JmY1REeXZNME4zYWZJOStuTzgxSjdMWkc1?=
 =?utf-8?B?MHYyNDlHbjdaOWQwclRWQk1zUmZtWW5EOGRrSzNWeVExY095VnJWeFZyb1B4?=
 =?utf-8?B?eWN3U3RxZ2JKWXNTUVJlb1hRZHUrKzE3bktlc3Q4enZMejJBSW1ZWGhQVFJC?=
 =?utf-8?B?NEg5NU52b0JVRVhyS1hnMWpxWnVXeW5tQk1reWtnVkJKcnJsOEZOelBVbnVk?=
 =?utf-8?B?bU5OK3o1SUhIS3ZLUTY5Ujh2bUFmaDBqbGxMN2dUWWhXRHdob3ROWDg0RDQr?=
 =?utf-8?B?MFBxdTFrQ0hqVUVFNVIvS3UwOVpGL0tKd3BkTCs5enNOcldpMjRwYkRlMk5Z?=
 =?utf-8?B?WEtkRWtZdC80amFkMzFmZlRCcTgwN096bHprWk1GRnNoT2ZCUDVWMkpna21G?=
 =?utf-8?B?VkhQVnJYcEVOYURVSlJRYW5QZlVEZkdHS0NTQ09uNmRvT00zaXJxa3l0NmYr?=
 =?utf-8?B?Tm5DTm80NHN2emVnSGVBUkdtZjNHeXZKUmlNQnduWEpKWFh2bFhCQjVkbmhU?=
 =?utf-8?B?cVRVWmVNVG1xSjB0dlRpZVRxK0dCbFpxOEhhMFR0Nk1jSHhSNWtEakZURk1S?=
 =?utf-8?B?K0R2eFJubFJBUlR5SFVtNXB0aHRHZ2NqYmVlbkVxRGEzVmkzNnZUTTQ2UlZu?=
 =?utf-8?B?My9VUThqTHpDd0d2S0RhaEJHWGhhMzArN0VzaHlBVHcyaTc5YVBtZ1F3OFRh?=
 =?utf-8?B?emZBamk3L3hDZ3NuSVZrNm1zclFsSlQ3QVFFLzkyeXFDdnJ0NGhxdUtGNFhF?=
 =?utf-8?B?YW5BSWhMOEJjN1E5U01GZ2xRWFBmNnFhNG0xQ0g5RVgvQVVDN2w0UWhWd1Js?=
 =?utf-8?B?ZElaVDUwUThaMU15QVNrVDhnVU9xUXpKWlhXQ0xOS0NRZ2hweXlwWklwMlRZ?=
 =?utf-8?B?NlM1L3F1N0pCc3ZQTG5LMUtla2trZHI3bGF4UnJZM0tUY2xHUmpqTlZZRGZm?=
 =?utf-8?B?aXA4dnRTRTg4Y2dtOGQvZ2NCUURyTnA3ald0ajEzTjByZjg0RUZtaDFSUkcr?=
 =?utf-8?B?OHEvdmZDelN0dGNPTUtlamRvbVdjM3FjRC84Lzl6MU1GZWxEK0sxb3A0R0xB?=
 =?utf-8?Q?OqWmdyrMKmJn+CMZd3sYqhonNjCZjoMce3NqJXq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cFBIUHQ1S2NaOVlKYkJUY3FWbEVMckdCTTRqeUNnUEt2U2p0OUp2Z20xZHNG?=
 =?utf-8?B?T0RDd1p3Uy8rRWUzUzZWL3ExK2hNcHUxSFpseDJBWnBOQWFQU2VUSkxSTmN3?=
 =?utf-8?B?TEJuNVp1UmpRdXRsSkRmVmZIQUY0YzVmaE9IMkdZQXpLV2pZNFZOc21XOUt4?=
 =?utf-8?B?U1A1OXh2TUptZXJEUmU5N2xPS1RuNkhMSHhkWWpSSnFNWlc4eUU3Y05ib1pq?=
 =?utf-8?B?bVFxcjRoY1kwc1dnR3lTZERTd1NFTlJHbmU0TEVTcE5nTGZJaURRcEdici9s?=
 =?utf-8?B?UzNJQ0RkNC8rMGZ3ZzFZOTVldkNFaHFFTFNhY282S0JPS2hpTHQwUFhvRXhv?=
 =?utf-8?B?M1lNdUtwcFpWTnZSMUdReUdYSldCZkNUQkQwUFJ5NElOY0d3aGw3eXUwQkVM?=
 =?utf-8?B?UUVNK3NSeEovK1Y4Y1NENVg3UklUMnB1eDFwY01qaWVja3NlWmtSd1YxMis4?=
 =?utf-8?B?NERjVHlJdGt0d2FlMTdQd3ptN3dFYzdKcC93VU05VTdvWWtLcW53VUd6RUxQ?=
 =?utf-8?B?eVZhbVpzbTB0RzBtK0FxMFZHVEZNeFBsSndOdGhLK1FVZlpQOVBmYXhJbk1s?=
 =?utf-8?B?TVhWcmlDRDQrdHdrS2hib1BEWTJNV0tDblZaTDgyVU1WWkowaUE4YnpVQkQw?=
 =?utf-8?B?ZzY1Tnk5andaT1d5a0M0SmZQTkxlNUt0amJ2bW5VSEhYVnAxME1VY21VSjk0?=
 =?utf-8?B?RENrRFV0RElNWVUrS2NhSXJGdTIvWlJHS1lqRHFPMG1aakJENGZpRkYxM3Y5?=
 =?utf-8?B?eGh0eHNma2t4Q1VaMmtQa1JUTVFpWlEwbGZqckRsMHd2dFVjTHVtR3liNUM4?=
 =?utf-8?B?dlR1c2lhRzZCU0hCS2pnZ0ZwLytDUDZuZ3ZBc1RSaHFGMG54WmFSaHhCTHVx?=
 =?utf-8?B?dnpQcE1PdjhYdHhrZWRqc1N2ZVgwbjRLQ2dmdUNxY2YzSndBd0loTUl2Z25a?=
 =?utf-8?B?NWRoa1RlUTJTNUVJWHlHQ3ZIWXRuT0pPVEUzUG5sQUtlTUE1Rk1McHM4SDJo?=
 =?utf-8?B?U3dpRDd2MWYrYlEyclFMYlFYUVk2TGJ2NTVuMTBWREQxL3hkQ1VlWFFYQTdq?=
 =?utf-8?B?eDgrUitMQkJmajdIay9WRmVLRldDOGgzWnFxU3huVTNuMURsQnhvZHZCdndM?=
 =?utf-8?B?Ni9NeHZiOEd2V1RKTlQwS0JadmsrdEd0QnZmZm95NjhGOVpUMlUyRVlVZW1a?=
 =?utf-8?B?R01wYkpQOU5ZNDN0WVFJRTlZWVpiZGR1Y0IzNXhNdklQcmxCR3FzTzBVNG8z?=
 =?utf-8?B?M3Y4RXNNaFNBYzBPSTRoekJsMDB2M0FzeHJjNkFHRmZ4OFVNZVNlWUVUSXJa?=
 =?utf-8?B?M0RJNFpqTnFsVzVtSnhJRzRsWnNBdnpLT2gzeGtJWlJvL1VLL2ZBaFB5K2Fk?=
 =?utf-8?B?eExodmhsaXFld2N0R0U4WUxxekYvMGJpYjFNd3BJVHBVUHVyc1IvRno3Rjd1?=
 =?utf-8?B?QXlyMk55UmJjNGFQZnpCdld5VCtpQW1rR1RmalZlV2RNMmx3eUZXOGQ1bDN0?=
 =?utf-8?B?MzdBb2I2QTAzN2tnSFZxSUxWR3lLalhma3hkQXcvUWlBUzQrM0xtK2FYUW1B?=
 =?utf-8?B?UTNHTjRyZ0hnc01oeWNGc2ZzTFpBbXJrSXhmQjFJTWF0ZVhmSWs4dFAvRzNn?=
 =?utf-8?B?UVJ3WkI1OW5KZWhQdVQ4Nk9YNE9CVGtZUWQ5VEhLVjQ4eGVvbEpkZnVadVpQ?=
 =?utf-8?B?SGdHSkdSRUtXQzNxOEJocDhCSVNSVHdiWjhqTWJLRHladGNnUnozV3J0bnI5?=
 =?utf-8?B?ZzhGWWdLWUs1LzlNYzc5bDBkb2V6M1RzbWdOQkV3QVdRb3Bia2lzZisyekgr?=
 =?utf-8?B?WW5ERmhzanVDZ1ZjV09kN1ExSmx5cVJUcENoNHlMUGhFUVROMDVKSVZoVlA5?=
 =?utf-8?B?OG5Kc3UvY0E2N1BNTE1nNGhHcmVNZzVsUnpHR21QOWdLQ2VQL0ZkSzU2ZTNh?=
 =?utf-8?B?TE1QaW1BaWxZNjJ5STJZeW5jZ2tzc1F4RGdReHg1eFByMEw0S1hiNGwzWFd5?=
 =?utf-8?B?bnhLdTV4cXk0NnpBSnF6Y2Iya05QVENOSEk4aGIyVURiYmtzZkUzbjI2RFRQ?=
 =?utf-8?B?UW9uRTRIKzJYU2RUVjNLNGZqMFFOSU1GQ3IwQmlqRnNaREdyMVZTNW9CVHBl?=
 =?utf-8?Q?fvL/ue9Z0hri05JiIM2LW/XNO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43373558-71d7-4a78-a785-08dcf1b65081
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 09:54:11.9429
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vw8+KSj7ZWxs90jQZNleH5TjlymKKrsIHf8hGtzC+qB6F16AR1bAvxeO9DRZyrSRCgWjUYNn6Y0hznnyZ3rBDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8468


On 10/18/24 17:40, Ben Cheatham wrote:
>
> On 10/18/24 3:51 AM, Alejandro Lucero Palau wrote:
>> On 10/17/24 22:49, Ben Cheatham wrote:
>>> On 10/17/24 11:52 AM, alejandro.lucero-palau@amd.com wrote:
>>>> From: Alejandro Lucero <alucerop@amd.com>
>>>>
>>>> Creating a CXL region requires userspace intervention through the cxl
>>>> sysfs files. Type2 support should allow accelerator drivers to create
>>>> such cxl region from kernel code.
>>>>
>>>> Adding that functionality and integrating it with current support for
>>>> memory expanders.
>>>>
>>>> Based on https://lore.kernel.org/linux-cxl/168592159835.1948938.1647215579839222774.stgit@dwillia2-xfh.jf.intel.com/
>>>>
>>> So I ran into an issue at this point when using v3 as a base for my own testing. The problem is that
>>> you are doing manual region management while not explicitly preventing auto region discovery when
>>> devm_cxl_add_memdev() is called (patch 14/26 in this series). This caused some resource allocation
>>> conflicts which then caused both the auto region and the manual region set up to fail. To make it more
>>> concrete, here's the flow I encountered (I tried something new here, let me know if the ascii
>>> is all mangled):
>>>
>>> devm_cxl_add_memdev() is called
>>> │
>>> ├───► cxl_mem probes new memdev
>>> │     │
>>> │     ├─► cxl_mem probe adds new endpoint port
>>> │     │
>>> │     └─► cxl_mem probe finishes
>>> ├───────────────────────────────────────────────► Manual region set up starts (finding free space, etc.)
>>> ├───► cxl_port probes the new endpoint port            │
>>> │     │                                                │
>>> │     ├─► cxl_port probe sets up new endpoint          ├─► create_new_region() is called
>>> │     │                                                │
>>> │     ├─► cxl_port calls discover_region()             │
>>> │     │                                                │
>>> │     ├─► discover_region() creates new auto           ├─► create_new_region() creates
>>> │     │   discoveredregion                             │   new manual region
>>> │◄────◄────────────────────────────────────────────────┘
>>> │
>>> └─► Region creation fails due to resource contention/race (DPA resource, RAM resource, etc.)
>>>
>>> The timeline is a little off here I think, but it should be close enough to illustrate the point.
>>
>> Interesting.
>>
>>
>> I'm aware of that code path when endpoint port is probed, but it is not a problem with my testing because the decoder is not enabled at the time of discover_region.
>>
>>
>> I've tested this with two different emulated devices, one a dumb qemu type2 device with a driver doing nothing but cxl initialization, and another being our network device with CXL support and using RTL emulation, and in both cases the decoder is not enabled at that point, which makes sense since, AFAIK, it is at region creation/attachment when the decoder is committed/enabled. So my obvious question is how are you testing this functionality? It seems as if you could have been creating more than one region somehow, or maybe something I'm just missing about this.
>>
> I think the reason you aren't seeing this is that QEMU doesn't have regions programmed by firmware. In my setup
> the decoders are coming up pre-programmed and enabled by firmware, so it is hitting the path during endpoint probe.


That explains it, and it also means you do not have the EFI_RESERVED 
flag in use what we expect for our device.

And I think the solution you give below should fix it. I'll add it to v5.

Thanks!


> Thanks,
> Ben
>
>>> The easy solution here to not allow auto region discovery for CXL type 2 devices, like so:
>>>
>>> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
>>> index 22a9ba89cf5a..07b991e2c05b 100644
>>> --- a/drivers/cxl/port.c
>>> +++ b/drivers/cxl/port.c
>>> @@ -34,6 +34,7 @@ static void schedule_detach(void *cxlmd)
>>>    static int discover_region(struct device *dev, void *root)
>>>    {
>>>           struct cxl_endpoint_decoder *cxled;
>>> +       struct cxl_memdev *cxlmd;
>>>           int rc;
>>>
>>>           dev_err(dev, "%s:%d: Enter\n", __func__, __LINE__);
>>> @@ -45,7 +46,9 @@ static int discover_region(struct device *dev, void *root)
>>>           if ((cxled->cxld.flags & CXL_DECODER_F_ENABLE) == 0)
>>>                   return 0;
>>>
>>> -       if (cxled->state != CXL_DECODER_STATE_AUTO)
>>> +       cxlmd = cxled_to_memdev(cxled);
>>> +       if (cxled->state != CXL_DECODER_STATE_AUTO ||
>>> +           cxlmd->cxlds->type == CXL_DEVTYPE_DEVMEM)
>>>                   return 0;
>>>
>>> I think there's a better way to go about this, more to say about it in patch 24/26. I've
>>> dropped this here just in case you don't like my ideas there ;).
>>>                                                                      
>>>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>>>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>>>> ---
>>>>    drivers/cxl/core/region.c | 147 ++++++++++++++++++++++++++++++++++----
>>>>    drivers/cxl/cxlmem.h      |   2 +
>>>>    include/linux/cxl/cxl.h   |   4 ++
>>>>    3 files changed, 138 insertions(+), 15 deletions(-)
>>>>
>>>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>>>> index d08a2a848ac9..04c270a29e96 100644
>>>> --- a/drivers/cxl/core/region.c
>>>> +++ b/drivers/cxl/core/region.c
>>>> @@ -2253,6 +2253,18 @@ static int cxl_region_detach(struct cxl_endpoint_decoder *cxled)
>>>>        return rc;
>>>>    }
>>>>    +int cxl_accel_region_detach(struct cxl_endpoint_decoder *cxled)
>>>> +{
>>>> +    int rc;
>>>> +
>>>> +    down_write(&cxl_region_rwsem);
>>>> +    cxled->mode = CXL_DECODER_DEAD;
>>>> +    rc = cxl_region_detach(cxled);
>>>> +    up_write(&cxl_region_rwsem);
>>>> +    return rc;
>>>> +}
>>>> +EXPORT_SYMBOL_NS_GPL(cxl_accel_region_detach, CXL);
>>>> +
>>>>    void cxl_decoder_kill_region(struct cxl_endpoint_decoder *cxled)
>>>>    {
>>>>        down_write(&cxl_region_rwsem);
>>>> @@ -2781,6 +2793,14 @@ cxl_find_region_by_name(struct cxl_root_decoder *cxlrd, const char *name)
>>>>        return to_cxl_region(region_dev);
>>>>    }
>>>>    +static void drop_region(struct cxl_region *cxlr)
>>>> +{
>>>> +    struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
>>>> +    struct cxl_port *port = cxlrd_to_port(cxlrd);
>>>> +
>>>> +    devm_release_action(port->uport_dev, unregister_region, cxlr);
>>>> +}
>>>> +
>>>>    static ssize_t delete_region_store(struct device *dev,
>>>>                       struct device_attribute *attr,
>>>>                       const char *buf, size_t len)
>>>> @@ -3386,17 +3406,18 @@ static int match_region_by_range(struct device *dev, void *data)
>>>>        return rc;
>>>>    }
>>>>    -/* Establish an empty region covering the given HPA range */
>>>> -static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>>>> -                       struct cxl_endpoint_decoder *cxled)
>>>> +static void construct_region_end(void)
>>>> +{
>>>> +    up_write(&cxl_region_rwsem);
>>>> +}
>>>> +
>>>> +static struct cxl_region *construct_region_begin(struct cxl_root_decoder *cxlrd,
>>>> +                         struct cxl_endpoint_decoder *cxled)
>>>>    {
>>>>        struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
>>>> -    struct cxl_port *port = cxlrd_to_port(cxlrd);
>>>> -    struct range *hpa = &cxled->cxld.hpa_range;
>>>>        struct cxl_region_params *p;
>>>>        struct cxl_region *cxlr;
>>>> -    struct resource *res;
>>>> -    int rc;
>>>> +    int err;
>>>>          do {
>>>>            cxlr = __create_region(cxlrd, cxled->mode,
>>>> @@ -3405,8 +3426,7 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>>>>        } while (IS_ERR(cxlr) && PTR_ERR(cxlr) == -EBUSY);
>>>>          if (IS_ERR(cxlr)) {
>>>> -        dev_err(cxlmd->dev.parent,
>>>> -            "%s:%s: %s failed assign region: %ld\n",
>>>> +        dev_err(cxlmd->dev.parent, "%s:%s: %s failed assign region: %ld\n",
>>>>                dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
>>>>                __func__, PTR_ERR(cxlr));
>>>>            return cxlr;
>>>> @@ -3416,13 +3436,33 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>>>>        p = &cxlr->params;
>>>>        if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE) {
>>>>            dev_err(cxlmd->dev.parent,
>>>> -            "%s:%s: %s autodiscovery interrupted\n",
>>>> +            "%s:%s: %s region setup interrupted\n",
>>>>                dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
>>>>                __func__);
>>>> -        rc = -EBUSY;
>>>> -        goto err;
>>>> +        err = -EBUSY;
>>>> +        construct_region_end();
>>>> +        drop_region(cxlr);
>>>> +        return ERR_PTR(err);
>>>>        }
>>>>    +    return cxlr;
>>>> +}
>>>> +
>>>> +/* Establish an empty region covering the given HPA range */
>>>> +static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>>>> +                       struct cxl_endpoint_decoder *cxled)
>>>> +{
>>>> +    struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
>>>> +    struct range *hpa = &cxled->cxld.hpa_range;
>>>> +    struct cxl_region_params *p;
>>>> +    struct cxl_region *cxlr;
>>>> +    struct resource *res;
>>>> +    int rc;
>>>> +
>>>> +    cxlr = construct_region_begin(cxlrd, cxled);
>>>> +    if (IS_ERR(cxlr))
>>>> +        return cxlr;
>>>> +
>>>>        set_bit(CXL_REGION_F_AUTO, &cxlr->flags);
>>>>          res = kmalloc(sizeof(*res), GFP_KERNEL);
>>>> @@ -3445,6 +3485,7 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>>>>                 __func__, dev_name(&cxlr->dev));
>>>>        }
>>>>    +    p = &cxlr->params;
>>>>        p->res = res;
>>>>        p->interleave_ways = cxled->cxld.interleave_ways;
>>>>        p->interleave_granularity = cxled->cxld.interleave_granularity;
>>>> @@ -3462,15 +3503,91 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>>>>        /* ...to match put_device() in cxl_add_to_region() */
>>>>        get_device(&cxlr->dev);
>>>>        up_write(&cxl_region_rwsem);
>>>> -
>>>> +    construct_region_end();
>>>>        return cxlr;
>>>>      err:
>>>> -    up_write(&cxl_region_rwsem);
>>>> -    devm_release_action(port->uport_dev, unregister_region, cxlr);
>>>> +    construct_region_end();
>>>> +    drop_region(cxlr);
>>>> +    return ERR_PTR(rc);
>>>> +}
>>>> +
>>>> +static struct cxl_region *
>>>> +__construct_new_region(struct cxl_root_decoder *cxlrd,
>>>> +               struct cxl_endpoint_decoder *cxled)
>>>> +{
>>>> +    struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
>>>> +    struct cxl_region_params *p;
>>>> +    struct cxl_region *cxlr;
>>>> +    int rc;
>>>> +
>>>> +    cxlr = construct_region_begin(cxlrd, cxled);
>>>> +    if (IS_ERR(cxlr))
>>>> +        return cxlr;
>>>> +
>>>> +    rc = set_interleave_ways(cxlr, 1);
>>>> +    if (rc)
>>>> +        goto err;
>>>> +
>>>> +    rc = set_interleave_granularity(cxlr, cxld->interleave_granularity);
>>>> +    if (rc)
>>>> +        goto err;
>>>> +
>>>> +    rc = alloc_hpa(cxlr, resource_size(cxled->dpa_res));
>>>> +    if (rc)
>>>> +        goto err;
>>>> +
>>>> +    down_read(&cxl_dpa_rwsem);
>>>> +    rc = cxl_region_attach(cxlr, cxled, 0);
>>>> +    up_read(&cxl_dpa_rwsem);
>>>> +
>>>> +    if (rc)
>>>> +        goto err;
>>>> +
>>>> +    rc = cxl_region_decode_commit(cxlr);
>>>> +    if (rc)
>>>> +        goto err;
>>>> +
>>>> +    p = &cxlr->params;
>>>> +    p->state = CXL_CONFIG_COMMIT;
>>>> +
>>>> +    construct_region_end();
>>>> +    return cxlr;
>>>> +err:
>>>> +    construct_region_end();
>>>> +    drop_region(cxlr);
>>>>        return ERR_PTR(rc);
>>>>    }
>>>>    +/**
>>>> + * cxl_create_region - Establish a region given an endpoint decoder
>>>> + * @cxlrd: root decoder to allocate HPA
>>>> + * @cxled: endpoint decoder with reserved DPA capacity
>>>> + *
>>>> + * Returns a fully formed region in the commit state and attached to the
>>>> + * cxl_region driver.
>>>> + */
>>>> +struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
>>>> +                     struct cxl_endpoint_decoder *cxled)
>>>> +{
>>>> +    struct cxl_region *cxlr;
>>>> +
>>>> +    mutex_lock(&cxlrd->range_lock);
>>>> +    cxlr = __construct_new_region(cxlrd, cxled);
>>>> +    mutex_unlock(&cxlrd->range_lock);
>>>> +
>>>> +    if (IS_ERR(cxlr))
>>>> +        return cxlr;
>>>> +
>>>> +    if (device_attach(&cxlr->dev) <= 0) {
>>>> +        dev_err(&cxlr->dev, "failed to create region\n");
>>>> +        drop_region(cxlr);
>>>> +        return ERR_PTR(-ENODEV);
>>>> +    }
>>>> +    return cxlr;
>>>> +}
>>>> +EXPORT_SYMBOL_NS_GPL(cxl_create_region, CXL);
>>>> +
>>>>    int cxl_add_to_region(struct cxl_port *root, struct cxl_endpoint_decoder *cxled)
>>>>    {
>>>>        struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
>>>> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
>>>> index 68d28eab3696..0f5c71909fd1 100644
>>>> --- a/drivers/cxl/cxlmem.h
>>>> +++ b/drivers/cxl/cxlmem.h
>>>> @@ -875,4 +875,6 @@ struct cxl_hdm {
>>>>    struct seq_file;
>>>>    struct dentry *cxl_debugfs_create_dir(const char *dir);
>>>>    void cxl_dpa_debug(struct seq_file *file, struct cxl_dev_state *cxlds);
>>>> +struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
>>>> +                     struct cxl_endpoint_decoder *cxled);
>>>>    #endif /* __CXL_MEM_H__ */
>>>> diff --git a/include/linux/cxl/cxl.h b/include/linux/cxl/cxl.h
>>>> index 45b6badb8048..c544339c2baf 100644
>>>> --- a/include/linux/cxl/cxl.h
>>>> +++ b/include/linux/cxl/cxl.h
>>>> @@ -72,4 +72,8 @@ struct cxl_endpoint_decoder *cxl_request_dpa(struct cxl_memdev *cxlmd,
>>>>                             resource_size_t min,
>>>>                             resource_size_t max);
>>>>    int cxl_dpa_free(struct cxl_endpoint_decoder *cxled);
>>>> +struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
>>>> +                     struct cxl_endpoint_decoder *cxled);
>>>> +
>>>> +int cxl_accel_region_detach(struct cxl_endpoint_decoder *cxled);
>>>>    #endif

