Return-Path: <netdev+bounces-163291-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C312A29D7F
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 00:20:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFECD160381
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 23:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FE8B21C17E;
	Wed,  5 Feb 2025 23:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KPrOrKb8"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CA0151982
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 23:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738797633; cv=fail; b=SR5YdIqNC1vqchMhZlDkchM0r4Cv8ZnhRchvW8C7U8hXznedLNgMyi8f3p0uBJmE9mG/hMOah1+dHwKLKs8Gx1VkdfLFtwX4jorU0hgr3gMbajrLGQLoo38axvNShdUHus/FX9MN2DkzSduakDca25xkvN6Fvou5VQjpZvEYnx4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738797633; c=relaxed/simple;
	bh=7lmNS6G78UfB+YyrXc1NDPZ+Ypgd8HNy/QFf57Ys1W8=;
	h=Message-ID:Date:To:From:Subject:Content-Type:MIME-Version; b=pBMhzZb3ds4VBSHozNW0KHNndAvw3Y6hLIRWOVWPxLttTvWyc6xbFFOxm8jex+L7p6mQRiCa7xnkmmNgZerC4gV9qZnvPx6GcZj6dEJgvDBvihsezk6q6dwkg6D/r0t+nQekRDPPHtGoqqf5qed5oWUvvvbZZQn1wovCRfvGYrg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KPrOrKb8; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738797632; x=1770333632;
  h=message-id:date:to:from:subject:
   content-transfer-encoding:mime-version;
  bh=7lmNS6G78UfB+YyrXc1NDPZ+Ypgd8HNy/QFf57Ys1W8=;
  b=KPrOrKb8nHSEtUVhkDkQCF1+DXNmdoSuY32WJ4w2Q/hj8qrZszP1/B++
   yWWUtSvZG9yCtvTHo82uMEsWjCRBmLOkBxUHx2uZHw+oLHBx24f3zGwfN
   DM3w+opQVjLEGNvyq6O1k6q07OFFrw+s31GtUUeqZI5syJqBA1GkoII3w
   H1F6oo7MWgm35ojAONwLthNACo7nUjujgy+w3oGXlbVIecq/L9DtecNWv
   oGHr2zjBZDAC3iHzn4Si+wwTNKGc+m45yVs5armC5hFwCFDa72STH0z2y
   mA71jGRD0PJ1C6TFajXJ7HJ2/wpm1oNXLigMKRx7CFXxiw3GIOfvK1TXZ
   A==;
X-CSE-ConnectionGUID: GxfwhAQlQ9S2G9D4uwWdOg==
X-CSE-MsgGUID: jfIH2sQ3TQugCQGTjtZ4fg==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="50005482"
X-IronPort-AV: E=Sophos;i="6.13,262,1732608000"; 
   d="scan'208";a="50005482"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 15:20:31 -0800
X-CSE-ConnectionGUID: Ahs2bERNTJq3VQDzhtQPEg==
X-CSE-MsgGUID: K35AFpJfTBOZhUxq17vNVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,262,1732608000"; 
   d="scan'208";a="116039980"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Feb 2025 15:20:31 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 5 Feb 2025 15:20:30 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 5 Feb 2025 15:20:30 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 5 Feb 2025 15:20:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xPyiHavHxy2ily0hJefiBWK/5o2blJdfKRtd8NVLPI0aAdTLELrDN7hAhckEdCf1ZzJmkZKwsSA9+l2PGcMbCW5Tnn7SJM5Aa1SiGOxEE9hW+5Tn7bbTA/f/Nr9hmN3B/DBrbALgt9kkvkijWH56IuI5EClMe6yVgWu6q0gyPNEyYD3/1MbhreBu2fxF3fsHIxI8UAGANzAU2NSG8eMP/8uxuokxBiLlAN8A4d+oRCEXAEs5kjQ3Zf6uMssBpXycpeA2Ts+UZqoyXSYaghLcEqHzR86NSFprGQNNMsqVJIN2Cx4I0apzjdRUb7yKO072v/26jQl7GiaB3vlDi2evEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o2FmeSmWkN7a9c2fKeMJulq/dBOc6wbsWsIlYu7JLOk=;
 b=byMk1AH4MqUQYIzchlcEVbzj3hJGAG2nzZeATbYUgK5NiyHIt6Do3xfk7eBOtrltsWjK6aFxK3bou9EsVESo3b9huV526Mb4UmydLWQISXF4XhjTM6WlT6OhPr4YA99H1sgQj+k6Ki+7odJkIprP+dDEIDmaXGY4k6EXLokl9ah3irZLO3Tka8ydnRCtnvVga29r0nYo/ZDVowWTFLG1Px7ivpKD+9kyMrzW2242fai4KP2tRYToAA1XqlaLsDtIB/2+c8jh+YVlzjZPTiK6pK0Z5NKDPmup72sZJ1W85L7SmJ/vLtXY5NnK1rDX9kqlAgx+3AWt4fakEK37tdR5zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CY8PR11MB7244.namprd11.prod.outlook.com (2603:10b6:930:97::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Wed, 5 Feb
 2025 23:20:09 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.8398.021; Wed, 5 Feb 2025
 23:20:09 +0000
Message-ID: <81562543-5ea1-4994-9503-90b5ff19b094@intel.com>
Date: Wed, 5 Feb 2025 15:20:07 -0800
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
From: Jacob Keller <jacob.e.keller@intel.com>
Subject: iAVF circular lock dependency due to netdev_lock
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0016.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::29) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CY8PR11MB7244:EE_
X-MS-Office365-Filtering-Correlation-Id: 191a0118-b874-4329-5b87-08dd463ba1e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QUxIbXpuVVNqaUNIcE5ZQ2ZBb0g0ZzMvZEhLSG5zQkFaMzJoTitkaFM3TjVY?=
 =?utf-8?B?ZmxZRUR5NTI5a2h3WlFjQndVbUwzazk5emtDUEl0N1BIb3pqaDlveUY0aVlv?=
 =?utf-8?B?OWh2WWhEU3VuMGg5TkxoTzRuM3A4Q3kzOWEyM2RwdUFKbjhISW9FdUNGK1c0?=
 =?utf-8?B?M0g2czRzM1V3L0hlUFQwb2t6Z2FEMldzYVQwYjZvdVRDTFlwWjNPR2NwRi9Q?=
 =?utf-8?B?UjJFUUN2b3BFelllNjBFallvQ3h6cmN1T3dpVyttUWREQ0NPZUwrc3NBcFBz?=
 =?utf-8?B?V2VOaStSVEVKMWhPSkN4RFFmWjQrUnRQSU9Rei9TbU1xUDlscUNnVkRWOWY3?=
 =?utf-8?B?K2o0VHRrN1d6cEh0WExHSkcrR3ZCUmRMbWgrTWE0TXRNZG1vMFhqOWFBUWdU?=
 =?utf-8?B?aS80K2R3U1hjaFJmaGRFQjFsa3RWYWxJbHhvUURtUkRXUm50WGxVYjRHRlZB?=
 =?utf-8?B?N3JoVkxNS25aQkVEaEhKSUNiOHJUSndOYk05SDRFdldrQnRoUHcvb1M2L0Ra?=
 =?utf-8?B?MXQ5Z1pMT1daeURZeGJ1cXZwNU95VlJIc0xlOFc4WkZUZHdiaWZkSk9pb2hs?=
 =?utf-8?B?dmNBeXcrTmlvMzhzZkJ3eU9jWXJHb2xxekFXTG41NzNtVVBkVWorYzlMaVNz?=
 =?utf-8?B?U2c3TWVMS3FrS0RVMHF1dnA3UG92ZDZzczhZSEI1RUd1cE9iWVF6M3Z3MTVq?=
 =?utf-8?B?OTlYcGdDTy8wZEswME14NDRyVG5NRElGanQ3OWFPRE5NbnFDWkZmelJ5QVJs?=
 =?utf-8?B?MyswQk5TdGpoSXJvMEx4K0VHUVVsU0FUTFJNdkxMWkNMVjU3bExWVmExRUdm?=
 =?utf-8?B?ZzlQelVOUWIzazE4S3k4aUNUK1JWTWQ2V0IxSWlZenMraXZ1SkFDRGJqS2VY?=
 =?utf-8?B?YUxIc3JDbFJlS2NSUmZsQnlPd1RvamZvQWQzSHZsYTl5OU5YS2E1RzBjSVNp?=
 =?utf-8?B?YUcrbjRoMm1jUjVOUEVQS3hRUGNDeFR5MmFxdlFBL1JLQm9kMzNvOE1tQ0NX?=
 =?utf-8?B?SC9paDRRMVZ4Y2FZTkYzUXRIKzJGbjIzNlhySFd0eEJXYXNweFBuSHpWMnJz?=
 =?utf-8?B?T3pFMzJYUVNYUHcvdHdGeVdpUmRHUU1ZZ09VeWdUUEhsQ3I5K2xJSEtxSkRU?=
 =?utf-8?B?M29LVkE4Q2FnVzBNL2xLamV4M3VoSjlnbVI1OFlQZTBhOFJyZkhMbzd5YXNU?=
 =?utf-8?B?ZFFaQm9rMzdjYU05Uk9IcGdCdnppVEFKWjI5WXVOMlRBR0psNCs1RDI1M0RL?=
 =?utf-8?B?Sm84K0hSVTBvS1EyTzFxUVJ4Tldqb0tqQXdqaC8xYjNlcFptbjIyOXlCL1Nk?=
 =?utf-8?B?THl1SWdBek54SnhTQWxnVkpYMTM3UFJDbzVvZktvZ2UvZDN5a2VRQ3NQMDNR?=
 =?utf-8?B?U3FTa2tFUVE4aEZKK0x6cUJjU21BUEJFRjB3OUtoL0xBMUN6Vmc4ZTVCbXRY?=
 =?utf-8?B?N1FPQ3VKOE82d3FZTS9aTFUyUnFCQVhlTDltSk03U1Q3VjR2RU5GU3NPb3ZC?=
 =?utf-8?B?VitudjBYUkx3WG9zQ1FtSU1ROXFnbjhORUNhVkRnN2tzVFBDay82QkV5UFlz?=
 =?utf-8?B?RzdQa2prb1dVWGRuck5FenYwVUJHZnF1L1FRWkxOek8xNWRrRnNVMUxhU29k?=
 =?utf-8?B?T1NZOFFpNzh4UkE3dU9VQXJQYTZsblljSlljY3dZZURvTlJ6eHlLbDVnUVVL?=
 =?utf-8?B?SG5LRXBNdjhFUXltc3QyRi9FV1ZNR3VkSGtkY2pmTTkyQU5UbHB2LzRQb1RO?=
 =?utf-8?B?dkljQUZBVlpsbHhyZmhSR1UvdklPYzdOSHBrZ2Z4R1NGaVlESXc1eEVWL2lD?=
 =?utf-8?B?WmcrL0lESTZUVUt2cGNsdXJqbTQ5OFBJZk83bW83aFVSRFN0UkhoVEN2WUk5?=
 =?utf-8?Q?tfNkNuMZFHpFn?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y1podzA0NXlxQzV3b0xwZ051YjU0RndyY1FXeThzZDZLa3c2NEg5emRpMUVz?=
 =?utf-8?B?Mzg5TUpqbkd0eXNlNzVsakxBcU9HbU5hY2EwWFJOd1kzaVZ4clEzbzNCMHVr?=
 =?utf-8?B?OVBZb2VvWHdCb09jL3NvTG4rRjRBenNGVXhSdFRyZTljbG9WU3hwL0J1cENQ?=
 =?utf-8?B?K3p2WGJaWU55QnBKdzJScEcrTmFNOGxCcHdXenVPOWZKQlBUVStUa05qZDkx?=
 =?utf-8?B?c1hXK2VYVTFEbUNndEU2c3ZyNm8vNHd2eUZwd3ZpTlZReS9EN3RmMDZPdktD?=
 =?utf-8?B?WFI2K1prMktEaXRBZk5PTmVyYXR6a3M5NXhuN0JxRnlEcDBUU3lObmtwWkIz?=
 =?utf-8?B?SktvVWdWNlJ5TjJjT3REVzVObFlYNm45YjFuTG1JQXZ1eUFVQWc5bENCTElX?=
 =?utf-8?B?bzM2cGJya2xZdGFxbGlnOWkwTmc4N2hzcXh1N0NmY0phTTFBd0d4WTh6TnF2?=
 =?utf-8?B?dVF4SU9xRUxSL3lVTmRsZFI5bmY1VlJUcEtCci9DNTNrL3ZzMUgrR25vNnRi?=
 =?utf-8?B?bS9tMnYrMHRRR2htNEhHOG9GZWUySXYvQ2lIZkp2cXEzZVAwNXVTdmdLTWo4?=
 =?utf-8?B?OHAwNkhHd3BHL2ZKWWZYbjJvM2NLdjhOLytzR1dxMHZEQVpYdEVJeTBZMVBz?=
 =?utf-8?B?a0JEWVhWRHJKMzE0L3FMa2h1T0FWVjlXMDlFS0pWRlpiQ1ZoYjBWZU5FQW9R?=
 =?utf-8?B?R2Nja0ZhYWRYUFVZdHJVZFR2STN0ejF2a2VBS2ZEL0l3ZTNmenk1RVFKNEdI?=
 =?utf-8?B?T3JLTmxtL2E0VHRid1RxQ0Jqc2YrYldJZ0dxM0NGM3V1QXMrZm9JcHpBRmtJ?=
 =?utf-8?B?NGlxd0JUdDZFbU9aUldISFZlQ2FPbEkrczVOc2ErSHZtYzBqQ2xqYVFNM1NZ?=
 =?utf-8?B?TGJ3YWZwU0JGbmcxaUIrRDN5LzNHMmU4L1hVZ1lJMHZseWRrQzZ3OHI2UGd4?=
 =?utf-8?B?NzREWjY1M0l1S2VYWlVIQmxSWnNVbWJFdWdTdWpKamRwUkdiclpzbGJwM3Jv?=
 =?utf-8?B?TW56bDFBT3N6UG1UWm5TTUNveTdWTTEra3BTdUZHSGRaazJoZDQvRFVFcXl4?=
 =?utf-8?B?R3k3VzUyVWZxNGV0RGJYYkZMYURGT3UwbzZGN0pydG51NkVkaURTV2ZENmYw?=
 =?utf-8?B?Zy9vd3pHSCtoVjhRUHNWcDZjMytRNHRDV3EwaW51c0lwZGhleXh0dDIwVm95?=
 =?utf-8?B?UGxsS0xSYk1rdlpDSlZ2MEM2WEJHbXJHemxFTWRLbDZrMzdhSVdDczI5Zjk3?=
 =?utf-8?B?QnZJSWFMaFpldXpweVBDUHlwOWVib1NnSkswVmVZNng2QkZhYzlJcm5Jamhv?=
 =?utf-8?B?R1MreHVSVWpXdTFCUW43VG5DVVRVMkFsdWNBYm9xRldlYy9wcHNEWTEyMEVi?=
 =?utf-8?B?QTNjTERGcmZDck03eFF6RHgvNVFPb3lUdWNURXNwUndmV2xKT0h3MEUrQkVy?=
 =?utf-8?B?U0FqOHo0QkdTdWg5OGtGN1JCcXVqV1N3WE5ySUZ4bVNXdHgvbCtMcEVJaUFx?=
 =?utf-8?B?b2REdVJXTmhyQy9ERENUTnBGZmEyY1hLUHo3V3FIOWJDUFE1N0xTNDZUS1g4?=
 =?utf-8?B?WFh3UVk5TGkyTzVQR2gzYVVjQkVLVk1RWW1abkR5Q21lZkorODRTZFp0MVhK?=
 =?utf-8?B?RWdnNkpRSGhBZzlkR3VLRFU1MGF0cXZzcWVtTkU4YnlFSVM2aklGVVJRRUFi?=
 =?utf-8?B?VVdzenIrY2haS2tlVEdIZDZ4QzFoNkt6Q0pZdFNER3VRL2orRUd3bjFMQWxY?=
 =?utf-8?B?Y1BSVk5pQXY5TUV6VDI5b1VwNjFrZlpaVjY3MS8zWDBSdFYwd1NwM25SMVZX?=
 =?utf-8?B?L1pGeTFVQm1obEpWNmNna0ovWWZUNlg0QTdmM0pYQVNNYkRWREYzc0tmSE51?=
 =?utf-8?B?bEozMW1jMVBHRDkxU1hxZ3ptL3d2bm8wQTArUmJ4enF2UEcrRHpxRDMwckl4?=
 =?utf-8?B?OWNLOUVSeEd0T1N4MGlLQjVXRlI5K01IZE5CRlVKS0VXcUt2Y21SQnI1R2hy?=
 =?utf-8?B?a0FndWxMWWdoZ2ZLTmQyeTREV3N5OUlXVTJ4V2tOWmh4N3RjSnN4UWUzTEpN?=
 =?utf-8?B?bGhQT3d0KzBxNUdtVDA0emJ3S2xsVHdzNGxYWmtMb3lIWjBoMUFCNnJ2OXgv?=
 =?utf-8?B?WFZVNjJqU2ZTSi8reENRcWdXVzhRcWVnMkJmYkFwVktZdkhCcENrRjFYMzNP?=
 =?utf-8?B?MHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 191a0118-b874-4329-5b87-08dd463ba1e2
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 23:20:09.1096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qCPYaLI/+QcQCI08FbyOrzmNV2jjys2PFnB1sq3e2SRDoxsLziVSKjZtQ1jka/Q/mVKlUsXwXuTqUNgMyXM24tlBk3fGcVJBa6z57OI0TXw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7244
X-OriginatorOrg: intel.com

Hi,

I just discovered that iAVF now has a circular lock dependency on its
critical lock and the netdev lock:

> [ 1504.790308] ====================================================== 
> [ 1504.790309] WARNING: possible circular locking dependency detected 
> [ 1504.790310] 6.13.0 #net_next_rt.c2933b2befe2.el9 Not tainted 
> [ 1504.790311] ------------------------------------------------------ 
> [ 1504.790312] kworker/u128:0/13566 is trying to acquire lock: 
> [ 1504.790313] ffff97d0e4738f18 (&dev->lock){+.+.}-{4:4}, at: register_netdevice+0x52c/0x710 
> [ 1504.790320]  
> [ 1504.790320] but task is already holding lock: 
> [ 1504.790321] ffff97d0e47392e8 (&adapter->crit_lock){+.+.}-{4:4}, at: iavf_finish_config+0x37/0x240 [iavf] 
> [ 1504.790330]  
> [ 1504.790330] which lock already depends on the new lock. 
> [ 1504.790330]  
> [ 1504.790330]  
> [ 1504.790330] the existing dependency chain (in reverse order) is: 
> [ 1504.790331]  
> [ 1504.790331] -> #1 (&adapter->crit_lock){+.+.}-{4:4}: 
> [ 1504.790333]        __lock_acquire+0x52d/0xbb0 
> [ 1504.790337]        lock_acquire+0xd9/0x330 
> [ 1504.790338]        mutex_lock_nested+0x4b/0xb0 
> [ 1504.790341]        iavf_finish_config+0x37/0x240 [iavf] 
> [ 1504.790347]        process_one_work+0x248/0x6d0 
> [ 1504.790350]        worker_thread+0x18d/0x330 
> [ 1504.790352]        kthread+0x10e/0x250 
> [ 1504.790354]        ret_from_fork+0x30/0x50 
> [ 1504.790357]        ret_from_fork_asm+0x1a/0x30 
> [ 1504.790361]  
> [ 1504.790361] -> #0 (&dev->lock){+.+.}-{4:4}: 
> [ 1504.790364]        check_prev_add+0xf1/0xce0 
> [ 1504.790366]        validate_chain+0x46a/0x570 
> [ 1504.790368]        __lock_acquire+0x52d/0xbb0 
> [ 1504.790370]        lock_acquire+0xd9/0x330 
> [ 1504.790371]        mutex_lock_nested+0x4b/0xb0 
> [ 1504.790372]        register_netdevice+0x52c/0x710 
> [ 1504.790374]        iavf_finish_config+0xfa/0x240 [iavf] 
> [ 1504.790379]        process_one_work+0x248/0x6d0 
> [ 1504.790381]        worker_thread+0x18d/0x330 
> [ 1504.790383]        kthread+0x10e/0x250 
> [ 1504.790385]        ret_from_fork+0x30/0x50 
> [ 1504.790387]        ret_from_fork_asm+0x1a/0x30 
> [ 1504.790389]  
> [ 1504.790389] other info that might help us debug this: 
> [ 1504.790389]  
> [ 1504.790389]  Possible unsafe locking scenario: 
> [ 1504.790389]  
> [ 1504.790390]        CPU0                    CPU1 
> [ 1504.790391]        ----                    ---- 
> [ 1504.790391]   lock(&adapter->crit_lock); 
> [ 1504.790393]                                lock(&dev->lock); 
> [ 1504.790394]                                lock(&adapter->crit_lock); 
> [ 1504.790395]   lock(&dev->lock); 
> [ 1504.790397]  
> [ 1504.790397]  *** DEADLOCK *** 
> [ 1504.790397]  
> [ 1504.790397] 4 locks held by kworker/u128:0/13566: 
> [ 1504.790399]  #0: ffff97d1924d4d48 ((wq_completion)iavf){+.+.}-{0:0}, at: process_one_work+0x49b/0x6d0 
> [ 1504.790404]  #1: ffffa848c3d9be40 ((work_completion)(&adapter->finish_config)){+.+.}-{0:0}, at: process_one_work+0x1f3/0x6d0 
> [ 1504.790408]  #2: ffffffffb3e1bf40 (rtnl_mutex){+.+.}-{4:4}, at: iavf_finish_config+0x18/0x240 [iavf] 
> [ 1504.790416]  #3: ffff97d0e47392e8 (&adapter->crit_lock){+.+.}-{4:4}, at: iavf_finish_config+0x37/0x240 [iavf] 


This happens because the driver takes netdev_lock prior to acquiring its
own adapter->crit_lock, but then it calls register_netdevice under the
crit_lock. Since commit 5fda3f35349b ("net: make netdev_lock() protect
netdev->reg_state"), the register_netdevice() function now acquires
netdev_lock as part of its flow.

I can fix this by refactoring iavf to only take netdev_lock after
acquiring its own crit_lock.. but that smells funny. It seems like a
future change could require to take netdev_lock before calling into the
driver routines somehow, making that ordering problematic.

I'm not sure how else to fix this... I briefly considered just removing
crit_lock and relying solely on netdev_lock for synchronization, but
that doesn't work because of the register_netdevice() taking the lock.

I guess I could do some funky stuff with unlocking but that seems ugly
as well...

I'm not sure what we should do to fix this.

