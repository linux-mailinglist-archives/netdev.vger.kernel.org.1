Return-Path: <netdev+bounces-173725-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E0AA5B5F6
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 02:43:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B160B160B74
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 01:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0BA51DF985;
	Tue, 11 Mar 2025 01:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IqjMwtuf"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EAB11DEFE4
	for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 01:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741657389; cv=fail; b=lBpwWaEKAsrvkKY0WFrNtahDjc+IVdPATmSTXTCVoYZOgXfTdlH0C9uf83A8LpExlqUqvVuvtndAJkj1Jv0m/UEai8FXyAcotK2e1FXOb51AvIUw6Y4j7rAtiKpZK/naMv2W7AtO0xhwFpaQY++14LCR85pxQeb5QtBP/QDXUsg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741657389; c=relaxed/simple;
	bh=qgLxtWG2QjBofuI0dbm0Tr95Qc2Xk/w5A+heegg1PH8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Xaew6tYaPN15LqacPG/aYXSaKfDncg4lUP2PUzkhSTuzVMhfMkpAO3VZsAqFRiQjeC3Yg8x2qgOoirqm2OxjWbU3AVVb/76jsohMnqVmdvw1QLKNaAn55+w2URz5YYBb+rJyaAyDye/QJ7ng0/u//7DUGNlg2PLA06y1iAqlzqw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IqjMwtuf; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741657387; x=1773193387;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qgLxtWG2QjBofuI0dbm0Tr95Qc2Xk/w5A+heegg1PH8=;
  b=IqjMwtufVDNqtL/D5Y/DRfafA93oLKvag+39heXRiy1B2EVfW6w9wKaO
   9GxCO9ZNTLs2rT0WHGnyFld8NwejMT+/VAu95qzlAhq54/997Ox9wNqU3
   d4YSi67sJ/n8XOej8FhREws5tVkGUWtrC8KkkFdMhQwIZwBMYZQ2LjMQZ
   0j9mg3Jm1nsRTOha+BoxHD7yXzNVxCrz6P6oBcny/hfAiK52Js8NSN2/w
   VP5aokJNJbMZuD0EXciZG8/6OkNbxXJoG8rQgtGElgdDUnJscpno/R3D6
   bIKX2CP4ERVSCAuqmwyYzBoOeMp7rXpJUT7sEt+KdbRL4pVkzJgx+5LAF
   Q==;
X-CSE-ConnectionGUID: 7ZC72DeJTSuXUXsUXpZARA==
X-CSE-MsgGUID: XH9/Ue9iQSinmLrdFnOz/g==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="54055068"
X-IronPort-AV: E=Sophos;i="6.14,237,1736841600"; 
   d="scan'208";a="54055068"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 18:43:07 -0700
X-CSE-ConnectionGUID: VKkj9wfGSiy8j4BMV3ru4A==
X-CSE-MsgGUID: krv2t4lTTjO3eeruDvTq6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,237,1736841600"; 
   d="scan'208";a="119892040"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa009.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Mar 2025 18:43:06 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 10 Mar 2025 18:43:05 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 10 Mar 2025 18:43:05 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 10 Mar 2025 18:43:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WKT0rQOOq5avx8L2JRd8ko5dP71X+0W7odcTfli29gBP03HgzDp4X7oyaabTPwa0QNQIcr7Lw5ROWeHAEUFDw06DwvyDlBB5HYt+4txLOkoAhW2SsMlAF5jnap/t7aPphHPQhc7QtQp9xxIDHockJfoD/KOhy4R/KELvfVnPCzt/46yzQYcFfgOybqIdTpNczVLGz4Vz923KmeqLWqdpzIqT0XwY2iOI17wYPPgf3851eztUm431BJvgQvoRDlAjVnT1VmRB0CePW2iuWD2DAxIVIeZ0BqbHZZ4siyVuw0DGZcfBvackTbUUan8tdJFeYwDqthwmNZsk9lQ25qMLWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wi71mfjE/88V3uwGmOS8QTKCMM8lcV+6o2/8MOzrrow=;
 b=V8BFtk5QX9WuHF2nTEUqOcId7leSs3WXNf66AkEuOsc1ydD1B2A5BPHa6Us+68UP8H8IbEYDQ2ztMvIQH2G1hGn+s9oPrUscsaV2I+Mq7H3FD6S8DzZvpvE1hxvtccJ/oPj6A7yrSVIFoka7LljhxD3rXPdXbVJwMxaKR1gh/VWyM1uK9ThdTs0sC3PoHlO6ZtfSWRdHgetDiVaZ1RIOwIO9SItxQRzgf2KWpGS53EaDeUlO3IorBJIHXG8VOqvNwv9rTmACJEvjtqv7qK7N/ncV1rD5ByvTki9RSzgr7bYEayKHaSkkeMnuZWS3hMroCS2USJwyjCRAUVO0lZ46xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB4893.namprd11.prod.outlook.com (2603:10b6:a03:2ac::17)
 by MN0PR11MB6133.namprd11.prod.outlook.com (2603:10b6:208:3cb::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 01:42:16 +0000
Received: from SJ0PR11MB4893.namprd11.prod.outlook.com
 ([fe80::189b:3752:51d5:d53]) by SJ0PR11MB4893.namprd11.prod.outlook.com
 ([fe80::189b:3752:51d5:d53%3]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 01:42:15 +0000
Message-ID: <020727ec-6c9b-455c-bddc-78deb55ba5e5@intel.com>
Date: Mon, 10 Mar 2025 18:42:11 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: net-shapers plan
To: Cosmin Ratiu <cratiu@nvidia.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "horms@kernel.org" <horms@kernel.org>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>, "Tariq
 Toukan" <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	"jiri@resnulli.us" <jiri@resnulli.us>, Leon Romanovsky <leonro@nvidia.com>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Carolina Jubran
	<cjubran@nvidia.com>, "pabeni@redhat.com" <pabeni@redhat.com>, Madhu Chittim
	<madhu.chittim@intel.com>, "Zaki, Ahmed" <ahmed.zaki@intel.com>
References: <d9831d0c940a7b77419abe7c7330e822bbfd1cfb.camel@nvidia.com>
Content-Language: en-US
From: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
In-Reply-To: <d9831d0c940a7b77419abe7c7330e822bbfd1cfb.camel@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0215.namprd03.prod.outlook.com
 (2603:10b6:303:b9::10) To SJ0PR11MB4893.namprd11.prod.outlook.com
 (2603:10b6:a03:2ac::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB4893:EE_|MN0PR11MB6133:EE_
X-MS-Office365-Filtering-Correlation-Id: 872e1b60-c280-47aa-42eb-08dd603df3a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bzB2QjdOVlZOcUdFODNYZk5zSHJtMDJaeFQwZFJ0TVY4eGlUT3Y0Y2lhM0t4?=
 =?utf-8?B?TE9zOHEzQm5yWFFWVnpzREVYV1YvQVVVbEMzalYxMmlPWk9EYkQzajk3NWt1?=
 =?utf-8?B?WFlCaXlOaXg1NlBZTVEvV0ZLb3FnU1pwckV3bzNtM2lxQy9HdnFRdWlHVWxM?=
 =?utf-8?B?dDFDdFMzR2prTVA1ajNhQ29tMnVMVnUvVXF1cEhRanozTjNRVzZnTXlLVE5D?=
 =?utf-8?B?NkFuOHpXVW85c2dFV0tpZVJjVGNBMnEwYUhXWUloM3A2OE5KVWllYytxZ3Jp?=
 =?utf-8?B?YmwwVkFkL3BqMGNSSWtBOXk2ckJvMVBjdjh3dXF1UGVoaG0rUThSQVhXSXIr?=
 =?utf-8?B?RWFNLytGL2ZrbU1iZjM1Mi93YWZXMjhuc3pQQ1BDVkg1SUxJZk9qckxOTjZC?=
 =?utf-8?B?azFQRkhpNXI3eEEralRCNUZkNmt5bWxxSjdwaWhKL2tFM2hXWDJhbEUraTEw?=
 =?utf-8?B?V3M1UUx3WWRNM2I5Sm9jQ1E3c0xEdGpJeWpsdGpVOGJ3ZitXdWx2dVFWUWtK?=
 =?utf-8?B?UTdVVSs0V3IrV0VQMUR0dWRySG5UQzdtOEFPc3EvbW56Z1Z6R3lHbjNENHNF?=
 =?utf-8?B?RFdXbTg3U2p1QVdpZmV6dSsrbkdBQ2N0QWlBaTdaM1pBclpVZk1GSVN0Wmxh?=
 =?utf-8?B?c3Z6Ni9aZWYzVXBiQ1NOUUV0V3hoUFAzVU1VeDRMSmIrTXVRclh6MUFVM29n?=
 =?utf-8?B?VnByZUFaU1V3SUplRWpsbEF0VG83UkR5NDZ4MHN0SnBWOFFDckp0VWJCclFJ?=
 =?utf-8?B?R1VZU3lTaTZxWG5FZ3l6emFLYk9wWDlWaGlvK3JQOEw2a0cyQXEwS25XbHdQ?=
 =?utf-8?B?Ymk2dzE1RXRhajhkRVV0K3R1dGJaaktQQkV5ZXZ5VUU4M1lWS1VzNnJETjlq?=
 =?utf-8?B?UkI3N1hYaFBGQkFNNTZUTCtlcDh3cDRXS2gxK3ZobVhRV3BJWmVGbjN1aWdX?=
 =?utf-8?B?MHFkY0lpQnpiWDNrWE9jZUNGSDlMcm5DMjdSakgxUnRndHd3dVoxT2RJUU0w?=
 =?utf-8?B?cDhCcHdWdlNrK0Fob0g3R0o3MGFmWHBwbk8xNm5qajlPck1ab29Ca3ZjOWJs?=
 =?utf-8?B?SlhLMjJWVmJFUVZqa01aT0VNdjFRMWkrSDZiMjJ6UzNoeEdJRUMzcVo0MFdH?=
 =?utf-8?B?emJlem5vZmFyTHRObFZmSmxrMENGMzd1RDY3enNVUGtuR2xJeVNHakk1Vzdy?=
 =?utf-8?B?OHdHUFRwdkd6Y1NxZkpXNEI0SCthanVNdmFaNUVyM1BuVFhQZ1gySUJlMzYz?=
 =?utf-8?B?K3V3SmVRcmJwckZ3QnlXem1nTE5XY2JKR3NnRDFWbzY1Yi9PbFhZeEFRY25v?=
 =?utf-8?B?WGY4R3BMVGVEa3Yyc2Qycld0K3pGbXJ2bVpZbDFEUWVSSFdtdlVYQzdtQnFE?=
 =?utf-8?B?UGR2bVhuckdJdmFsNWhBeGljWFJVOGg2Y0hlbU1wNGFjVzR0aDlwV1p4RHdY?=
 =?utf-8?B?aWNsNys4eDNjeXg2OGw0UVFWaXpTVTZGMmpNSVByR21IRHg4MUFuSGFXZDJG?=
 =?utf-8?B?bk0zQm8zbUEyTm5lNkZ2ZFhQS2tMMitETEdySjIwbGRmNFFWdzQxWHYwbkFp?=
 =?utf-8?B?WGF2a1RNY0gyVmpQcHRWK1kzRDhWUG5IdFBQM1hYY1h0OTk4bVdQSDdqWk40?=
 =?utf-8?B?Z3NuRkpBbGp5dFR1UDArYkhYMmpUMmFsUHhsY1AxL0NzNWx6NmFiWDhJNFAr?=
 =?utf-8?B?Wk5NSmw2SFhmcldrbWdQRHluaE02SWpTZmJPSEU3VkNydDluajFUQWt6WWx2?=
 =?utf-8?B?ZVYwbGpMNlZHRy8wU1R2ZGF1Rk5HL0tEaTl6QmR2VWdqS1NMZDIxaVdwL3lI?=
 =?utf-8?B?bWw2ZmxyZ2VzTWs5UHMyamtMVmM2OTNKOEVXVHhmaTlCYW0wZXVxc0JZcUhi?=
 =?utf-8?B?S3JpQjlTeWtia2tFbjJwdkRrdTlZYldrY1FnNytNTGphSUE9PQ==?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB4893.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWt3eFRaRGJXQklRclhBQU1NVG9KdEdyMWNXcmt6dm9rYjJVUTFMWHZqMUFI?=
 =?utf-8?B?S2ozRXFDeEhNakVhYW95ZmlBSjV5U0pXVkEzVkx5bTVYUkR6S04wU3FhN0wx?=
 =?utf-8?B?c203bDgvTDdVT1ErazJ1aWRkZ0l5Znd3Ri9Bc2pVTmw1TitBb09IanJUZjRj?=
 =?utf-8?B?TWJYaVFKRjQ0bThVWXYzOHB4VStOTlpXNzg4MndZOFNtSUtRUnlPVWo0cHFD?=
 =?utf-8?B?Z3RicnBoZ2VsWEVaYWVaVG56ckV0UFgvS2N6TDRoNmhiekUxS2xjQzhJRGdH?=
 =?utf-8?B?V2tjQjNzb0xsYWhWdTEyMzdteXFZV0JWb2dNWmlxZldRVndoVVcyZnc2WUY0?=
 =?utf-8?B?RUdvQld3SnRTaG96SCtQZXRXQVVhQmhnV0F5a2Q2eHkyMmNvOFN6MDJTTzdi?=
 =?utf-8?B?a2ViV05IQmxCaHdnRXhlK1U0djJrNnQxZEFzck5rNXB3c20xTUsySVVhNHU4?=
 =?utf-8?B?enZMZW9hbExSZ2MxcDFheDBsTHJPRU9ZWitvb2xVUzZRd00wU0l0M1V0KzZF?=
 =?utf-8?B?ZUtOcGJiNTFVQ1Y0cUVCeSs0UktVM1ZvMFcya0wyVHNaa2w1YklZRFNUNkNL?=
 =?utf-8?B?MHorazJQckxYNkxYeGpkcWxwUWEvUzNpSTZUa2o1WnZNbEpWR0J3dlRXYWhI?=
 =?utf-8?B?OU9ldktibkszaTVVL3VZMk9KWkJlZGM2OGlCbnB1cndXbExsVnBtT1phNFhB?=
 =?utf-8?B?YjhhYVhMb1YvaGh3WVV6R0IxZm5zVVY1MHJLcjVEZjFUdHIyRWJxUTlUZStU?=
 =?utf-8?B?bDltbDREa25pamlIUXVqTlVMTGdsMzdCdzFEL2MzOFJPTS96Mkk3MGx4Yk5C?=
 =?utf-8?B?MXpqaHNtWk5IbTJ0ZjdjMlQzeDdZcnVaWFdwekJWeFZsWnQxRVR5NEgrV2k0?=
 =?utf-8?B?aWdkYVpzcFdtUmk5THBnV0NNTXBzeWJ1NklncU5LMzBpWjZFUFltTW13Y2Nh?=
 =?utf-8?B?RDRvVUt1Vys2NXUvUnp1bGd2aVF4KzlCRWdYZmVza0tENTlpbTFjdzhYYVA4?=
 =?utf-8?B?cVFsS29qV29ZRFhWUVZTNEhEbmtkSGZKb2hDVmJielRMaGloRHA3WWJMSUZ1?=
 =?utf-8?B?M0c2SGRaWUhiR0xLb3NvUlp5Uk41NFFjUGxKcUZTR3p3VENtUGsrUStSRTFr?=
 =?utf-8?B?eGtVbEVTbWc4MFR4UjNSME1pM1Jmd3hneGdFQVU3WXN3MmZnODFCdmt1MTNr?=
 =?utf-8?B?RTdUczNNaElXMnhiT1hjUGdKZDFoMmVIUmh3UDBnOW9FaHV2UTlLT05SMHdS?=
 =?utf-8?B?WVFxYkdtZzVuVk81WU5SVHExVTI1Z05xOHN2TWU1K1NKTWZlVFhwTWJSYW5L?=
 =?utf-8?B?SDllTktmZmNQRk5KdTNKUXllMkFxQ2NWTFgzeExuRUY2Y0VCTkc4RXM0Q1A2?=
 =?utf-8?B?Z0kydFNGczlSZW5SYUFOTWVvakVpMFExSXNLZCtKUFBJUG9GQndNNDFrRmts?=
 =?utf-8?B?ZlZDS0VDbzFCYUs0V3JwNW1UbG0vaXFKcnlDbFVXeXR4aWRuY1BwQ09sd0Jl?=
 =?utf-8?B?S2V2NDhvSUZrd1VNVmE1MHR1Q0ZFUTQwRHRTRTE1ZnAvbTZPSHViRWJHZ3BX?=
 =?utf-8?B?WTBmeUtjZUpXYTU1VElFemRRdUY4Vy9sbTQ3MjVtbWEwR0syS3VGTytHTnlr?=
 =?utf-8?B?emlFdmtYYUNMZ3FPK3M1eEMvQmsxazdlWG5JQVNwWEtRQzNpdFVJS0JSQStM?=
 =?utf-8?B?OW5IZkxGK2dXSHAwRk8yN3lYUWZacVlSeU9mN0xCWEhQSHFwUFNXeW5pcjNy?=
 =?utf-8?B?WnhsTDRkdEN2cTFkenVBVVEwanF0VU54d0thTnMxblJIQmRadGFxSjFBZnY4?=
 =?utf-8?B?b3E0OXNGWk92dHlLNE9qSmZKNUlqdzBBSjVId0NBblN3MGdUQmZKcnZ2ZUhl?=
 =?utf-8?B?bUJaNFoyQkEwdkVhN1B1SkVQMXdWTnRaUDZUKzFjWFBuZzlhSUtKcnlvNGVO?=
 =?utf-8?B?Q0JkTXZDME5JamcxWEZhRlFZcmF2SlVjdWxSR1A3Q2NQOGJuN3RKNFNDTjkx?=
 =?utf-8?B?K3hMaFdMZTVYUTUwelpMOFJ5NzdRRGF0SlhQNVVTQnZjNTh6N2VyMUtpTHBX?=
 =?utf-8?B?VUtjQUR0bFAxclo3Vm84Yi9Ld1p6VUpPVjU0UXZTRkVnQVZnSVdNZnNzWENj?=
 =?utf-8?B?UE1nOGlSR0h5Qk1QV3JMbk1yMHQ1NDVIRUZjaEw1Wmo2UWdLNTljMzRMeEJq?=
 =?utf-8?B?SlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 872e1b60-c280-47aa-42eb-08dd603df3a5
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4893.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 01:42:15.6540
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L+yhTN3wmGCKuHPcS2DM4/T0pJ8hytGzRuNRGG8BmxwbckfabV/1gzY6zVp9YaLK0vO52pMK3MOgYRnPzmuygsqG0x6AAX9hj9aBwIpqme0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6133
X-OriginatorOrg: intel.com



On 3/6/2025 6:03 AM, Cosmin Ratiu wrote:
> Hello,
> 
> This (long) email presents a plan agreed with Simon and Paolo for
> extending net-shapers with use cases currently serviced by devlink-
> rate. The goal is to get net-shapers to feature parity with devlink-
> rate so that the amount of code dedicated to traffic shaping in the
> kernel could eventually be reduced significantly.
> 
> This is in response to Jakub's concerns raised in [3] and [4].
> 
> Context
> -------
> devlink-rate ([1]) can control traffic shaping for a VF / VF group and
> is currently implemented by the Intel ice and NVIDIA mlx5 drivers. It
> operates either on devlink ports (for VF rates) or on devlink objects
> (for group rates). Rate objects are owned by the devlink object.
> 
> net-shapers ([2]) is a recently added API for shaping traffic for a
> netdev tx queue / queue group / entire netdev. It is more granular than
> devlink-rate but cannot currently control shaping for groups of
> netdevs. It operates with netdev handles. Stores the shaping hierarchy
> in the netdevice.
> 
> [3] & [4] add support to devlink-rate for traffic-class shaping, which
> is controlling the shaping hierarchy in hardware to control the
> bandwidth allocation different traffic classes get. The question is how
> to represent traffic classes in net-shapers.
>      
> In [5], Jiri expressed a desire to eventually convert devlink-rate to
> net-shapers.
>          
> Finally, in [6] I sent an update outlining a snapshot of discussions
> that took place trying to figure things out.
>          
> Putting these pieces together, the following plan takes shape.
>        
> Plan, in short
> --------------
> 1. Extend net-shapers hierarchy with the ability to define 8 traffic
> class roots for a net device instead of a single root like today. There
> is no need for a new scope, the NETDEV scope with a different id to
> differentiate TCs should be enough.
> This is needed to allow backpressure from the hierarchy to the txq
> level and proper TC selection.
> 
> The goal is to either have a hierarchy like today, with one netdev-
> level root containing nodes and leaves being txqs or to have a TC-
> enabled hierarchy with 8 roots (one for each traffic class), with nodes
> and txqs as leaves.
> 
> 2. Extend the semantics of NET_SHAPER_SCOPE_NODE to be able to group
> multiple netdevs, similar to devlink-rate nodes.
> 
> 3. Add a new DEVLINK binding type for the hierarchy, to be able to
> represent netdev groups. That part of the hierarchy would be stored in
> the devlink object instead of the netdev. This allows separation
> between the VM and the hypervisor parts of the hierarchy.
> 
> These together should make net-shapers a strict superset of devlink-
> rate and would allow the devlink-rate implementation to be converted to
> net-shapers. It allows independently operating traffic shaping from a
> VM (limited to its own VF/netdev) and from the hypervisor (being able
> to rate limit traffic classes and groups of VFs, like devlink-rate).
> 
> Plan, in detail
> ---------------
> 1. Packet classification
> It is outside the scope of net-shapers, but it's worth talking about
> it.
> Packet classification is done based on either:
> a. TOS field in the IP header (known as DSCP) or
> b. VLAN priority in the VLAN header (known as PCP).
> c. Arbitrary rules based on DPI (not standard, but possible).
> 
> Classification means labeling a packet with a traffic class based on
> the above rules, then treating packets with different traffic classes
> differently during tx processing.
> 
> The first moment when classification matters is when choosing a txq.
> Since the goal is to be able to treat different traffic classes
> differently, it it necessary to have a txq only output a single traffic
> class. If that condition doesn't hold, a txq sending a mixture of
> traffic classes might suffer from head-of-line blocking. Imagine a
> scenario with a txq on which low volume high priority TC 7 for example
> is sent alongside high volume low priority TC 0.
> Backpressure on TC 0 from further up the shaping hierarchy would only
> be able to manifest itself by blocking the entire txq, affecting both
> traffic classes.
> 
> It is not important which entity (kernel or hw) classifies packets as
> long as the condition that a given txq only sends traffic for a single
> traffic class holds.
> 
> 2. New net-shapers netdev TC roots
> A new netdev TC root would therefore logically identify a disjoint
> subset of txqs that service that TC. The union of all 8 roots would
> encompass all device txqs.

Are these TC roots configured on the VF/SF netdev? OR are these on the 
corresponding Port representor netdevs?

> 
> The primary reason to define separate roots for each TC is that
> backpressure from the hierarchy on one of the traffic classes needs to
> not affect other traffic classes, meaning only txqs servicing the
> blocked traffic class should be affected.
> 
> Furthermore, this cannot be done by simply grouping txqs for a given TC
> with NET_SHAPER_SCOPE_NODE, because the TC for a txq is not always
> known to the kernel and might only be known to the driver or the NIC.
> With the new roots, net-shapers can relay the intent to shape traffic
> for a particular TC to the driver without having knowledge of which
> txqs service a TC. The association between txqs and TCs they service
> doesn't need to be known to the kernel.
> 
> 3. Extend NODE scope to group multiple netdevs and new DEVLINK binding
> Today, all net-shapers objects are owned by a netdevice. Who should own
> a net shaper that represents a group of netdevices? It needs to be a
> stable object that isn't affected by group membership changes and
> therefore cannot be any netdev from the group. The only sensible option
> would be to pick an object corresponding to the eswitch to own such
> groups, which neatly corresponds to the devlink object today.

When you are referring to grouping multiple netdevs, I am assuming these 
are port representor netdevs. Is this correct?

> 
> 4. VM/hypervisor considerations
> A great deal of discussion happened about the split of shaping
> responsibilities between the VM and the hypervisor. With devlink today,
> the shaping hierarchy and traffic class bw split is decided entirely by
> the hypervisor, the VMs have no influence on shaping.
> 
> But net-shapers has more precise granularity for shaping at queue
> level, so perhaps there are valid use cases for allowing VMs to control
> their part of the hierarchy. In the end, what we think makes sense is
> this model:
> 
> VMs can control the shaping of txqs, queue groups and the VFs they own.
> On top of that, the hypervisor can take the netdev root of the VM
> hierarchy and plug it into its own hierarchy, imposing additional
> constraints. The VM has no influence on that. So for example the VM can
> decide that "my VF should be limited to 10Gbps", but the hypervisor can
> then add another shaping node saying "that VF is limited to 1Gbps" and
> the later should be the limit.

Isn't it sufficient to enable rate limit at a VF/SF's queue or 
queue-group granularity from the VF/SF netdev? The hypervisor should be 
able to rate limit at VF granularity.
> 
> With traffic classes, the VM can send out tc-labeled traffic on
> different txqs, but the hypervisor decides to take the VM TC roots and
> group them in an arbiter node (== a shaping node arbitrating between
> different traffic classes), or to group TC roots from multiple VMs
> before applying arbitration settings. This is similar to devlink-rate
> today. The VM itself should have no control into TC bandwidth settings.


It is not clear if TC roots are configured by the VF driver or the PF 
drivers supporting switchdev. Can you share an example configuration 
with steps on how to configure hierachical traffic shaping of VFs queues/TCs

> 
> Cosmin.
> 
> [1] https://man7.org/linux/man-pages/man8/devlink-rate.8.html
> [2]
> https://lore.kernel.org/netdev/cover.1728460186.git.pabeni@redhat.com/
> [3] https://lore.kernel.org/netdev/20241206181345.3eccfca4@kernel.org/
> [4]
> https://lore.kernel.org/netdev/20250209101716.112774-1-tariqt@nvidia.com/
> [5] https://lore.kernel.org/netdev/ZwP8OWtMfCH0_ikc@nanopsycho.orion/
> [6]
> https://lore.kernel.org/netdev/67df1a562614b553dcab043f347a0d7c5393ff83.camel@nvidia.com/
> 


