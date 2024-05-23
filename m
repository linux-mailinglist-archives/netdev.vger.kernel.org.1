Return-Path: <netdev+bounces-97877-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 169098CDA2F
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 20:49:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0F9E2834E5
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 18:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0A6442067;
	Thu, 23 May 2024 18:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Altg41ox"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117FF82D7A
	for <netdev@vger.kernel.org>; Thu, 23 May 2024 18:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716490171; cv=fail; b=VErpoUi6wtCmRPgBpLWCikrpedEpdDbY+UZbyUqyQ/beB9CZE3OpECriANKD+1rk+49pHJJ/IZ/P6WClGsDwZLkfToJEwQ9TInssTQ+tzblMW3l2DD0/6wq/fxw5AFvtbKr8em3lev4nluVM5bPjrvmTKFP40zfB9sgPSg5R+nQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716490171; c=relaxed/simple;
	bh=3JoZ4ZfBoxLRhs5blkHKvkxoIVM0UG4/bzxHtLG3t+Q=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=vDDC4m9m2GTyNYTibdjwrWpTVDmWDejFXuwpi2+cj8VXUN6Hx5qufX67ToLkjmpwTN9XBEZmAfQTeyFEerINVBfJB4aCcUeIWE8Py4wJrpq/C2gIyHAygOy9vf9ni7WwKfwTf840gY+u0Jcoz5Kx9Zrmm7ulBW1LmVAxHUO6WK8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Altg41ox; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716490170; x=1748026170;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3JoZ4ZfBoxLRhs5blkHKvkxoIVM0UG4/bzxHtLG3t+Q=;
  b=Altg41oxaQBsBRHsUG4tfoCG67GYtiWYv9gELU7SalYZ9AdWT3NXzcyf
   znqzPoSDRxrhybquC/z4LcITJMB8CaTbcqtjnfWFylNnv1A7IyhL4LPtT
   6/mGXoimbYZOGZpw4YJygKzG7uZ4JGqJV5ESvu684V94avN0kDyhl3frD
   uKlZUUYlqGY8vAuGN0lC7qvE65LvJQMKgOi+ZgPRTyZ7qqaqofUB9M6Ou
   Zfq9hNvzTmTDpzc8/gcCqtv80j4Jn8iB5FjFcGFIZWCSoIut26BDWHiLq
   //AwMBO7lJ8BvHStUUh2DPw9ygCgCz97pAO63RS0FHmc917gb3Z6KfKVC
   w==;
X-CSE-ConnectionGUID: oAzPkNc3RsmTcaM+BCBPlw==
X-CSE-MsgGUID: mmuMw/SyQTiUhFKprNWymQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11081"; a="12680393"
X-IronPort-AV: E=Sophos;i="6.08,183,1712646000"; 
   d="scan'208";a="12680393"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2024 11:49:30 -0700
X-CSE-ConnectionGUID: 8Q1iio13SlezCSRryI4aHQ==
X-CSE-MsgGUID: cLGOojAvSzWmdjbDOYZ4iA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,183,1712646000"; 
   d="scan'208";a="33668271"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 May 2024 11:49:29 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 23 May 2024 11:49:29 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 23 May 2024 11:49:28 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 23 May 2024 11:49:28 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 23 May 2024 11:49:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rtbh3wDd2Nm5BP40Cy7FzllJ3ocBH3nLJSEyupEYlAUmscx4YnkU3QC6Dprol0H1z2Wwd7kVaGoh12U70QXRfaFKk4U38sz+xLVtfqey7WZYtuzUuifW4x5ytM4QDmWoxejsoBRQ7xBT7EgUoySvDR9iv6AXWQ67IKJzzrjO2VNWR7rpWmBVbbdpl2aehl5XMfhBMkY/l+BPZgvkZPSZ67OC4/0m1KYdSnGi7H4oBgUk4o79WQhgrehq5PF1fhpJHpBcDobJOWOjQPYwq6EPP0wuz9EgxjCLhRCrjgyVAegKSHMr//fiegOOYHIxBv0tVGbQjHaszUXU1MeRuttYGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F/VlAbfaRgz7KZfS4OFc7cPd54T+h0XoYx3RoyaYpBc=;
 b=HuipdAgyXNl6cZNI5RfSZkCXNQwW3C/7jDDG1shVI4j9TFzTlYf+7rZNy1s7DHNDI0sOy5ILd8JTGLyzBoe87bm29SVJY3X01n/V33driODq+vBUTl//ilwyE5CmAnwDnxssCr1iRCq1Co3eOusqpe/1ze20NU76HLp15eXPREknL4AuEG0FVenlsXbqUmGh1XUAJxxeHPdpXsyq9SNU4Wpsp1LALHJVE+IOzQ7IFgpEjVOofyekeRg4AJQk9CRZQTuFLlC3GEDkzAl5Lk1eHqrgxwWi3sH3EdJiQwwFS+3fSxVnO0u9clGC5TvLs81t/zJU/+7f658CC7MAZUJv3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by MN0PR11MB6036.namprd11.prod.outlook.com (2603:10b6:208:377::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.20; Thu, 23 May
 2024 18:49:19 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.7611.016; Thu, 23 May 2024
 18:49:19 +0000
Message-ID: <decbaab6-a9ab-4aa3-9285-0ffa98970c59@intel.com>
Date: Thu, 23 May 2024 11:49:17 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] Revert "ixgbe: Manual AN-37 for troublesome link
 partners for X550 SFI"
To: <kernel.org-fo5k2w@ycharbi.fr>, Jeff Daly <jeffd@silicom-usa.com>, "Simon
 Horman" <horms@kernel.org>
CC: <netdev@vger.kernel.org>
References: <655f9036-1adb-4578-ab75-68d8b6429825@intel.com>
 <AM0PR04MB5490DFFC58A60FA38A994C5AEAEA2@AM0PR04MB5490.eurprd04.prod.outlook.com>
 <20240520-net-2024-05-20-revert-silicom-switch-workaround-v1-1-50f80f261c94@intel.com>
 <20240521164143.GC839490@kernel.org>
 <1e350a3a8de1a24c5fdd4f8df508f55df7b6ac86@ycharbi.fr>
 <c6519af5-8252-4fdb-86c2-c77cf99c292c@intel.com>
 <69ac60c954ce47462b177c145622793aa3fbeaeb@ycharbi.fr>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <69ac60c954ce47462b177c145622793aa3fbeaeb@ycharbi.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0034.namprd04.prod.outlook.com
 (2603:10b6:303:6a::9) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|MN0PR11MB6036:EE_
X-MS-Office365-Filtering-Correlation-Id: dfd42ab8-0243-4930-3a93-08dc7b590dd1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?REVWQ0Y1OGxoODlieTh3azdUQ1BPZkF3aE9WeWt1OW1PM1JrQzZqN0YyU1pt?=
 =?utf-8?B?Wmp1Z0RibDlTZlN1Z1JaMDlnZ2VIVnZVekhoTTBZWjZoMFBGMDFYTWRSaDhB?=
 =?utf-8?B?YllkdHBFd0dhbDhlK2Q0ODdDd1Zla2JXVlRHWlc4QnF2OUt1MjNqempGdGla?=
 =?utf-8?B?TE1uM1NhUnFreDZaSGZST2g5Skcrc3Z4V2g2dEdpUmFPMEhEam1HQjMydURl?=
 =?utf-8?B?c3BkNWd5a3kvUGtVRU9TYTZBS25waTdHR2d6SXNacVRIUUtXVWVtUkEvdEZm?=
 =?utf-8?B?b2h0VUcvdlRTd25PSmswaHNFQmFUU3V3M2UzYUVyZUNDYjNhSS9TV2dGWUE5?=
 =?utf-8?B?REcrZXpPRUpFWTUveEkybW90MDY1YUJtcXgyakZ5VGNGdkNJa1NTK0NpdVN3?=
 =?utf-8?B?a3J2cmE3cEYzY25PSDlhclZvVUdoZnFzZ2VpNDJkWXlwWmV6R295YThkUGdI?=
 =?utf-8?B?ZUtZU1RTa0xpWG9kUGRibmhZemhxYlp3TnhZcFREN3pyK2MxekRHbXRiRVY0?=
 =?utf-8?B?L1NHa0ptYjF4dmh3cVg0N2lwNmYzaytIbDJrTmsycEV4OUpmSVc0RUkzQlBG?=
 =?utf-8?B?MzNFV2JMVDFWS2lmZDd4bXMrYStYK3pFL0FLeHVhaHY1clF4NWhUeXpzVGxX?=
 =?utf-8?B?eWRUdXJLUVM4Y09xeURrMEYzcWYwenRacTQyN1FCQVJ6Um53YzF3TW52NkZQ?=
 =?utf-8?B?bndEdDZkVWIvOFN3VFZ3WURkWTJNYi9ITEtYQm5yL29NYlg3OERBT1RQK1Nx?=
 =?utf-8?B?cDFGQW9JS1U5YzZtS3k3N0l1UWd3UUFmbi9jdjRmenN5R1U2b3VpN0grNHdh?=
 =?utf-8?B?RVpTNmVsdmpqVzkzUGdSVmdDM2J4cFg5ZnYvLzJRN2ZuSndvQ2RXTkFESGRj?=
 =?utf-8?B?Q0QxYjdpZnJ1eHZURTZwcHduT2hNandtdzVReDhsaVVnS3k0cW5mUGFQRE5Y?=
 =?utf-8?B?em1sZjg1ZTdOak9jZE9RMTUyUDZVWHFVWkU1UUpFWitWQS8xZ3hnWG5Tc28z?=
 =?utf-8?B?aVFWQjBXdGtmQjMrak5LNmJJVHg3UHNBNXM4THJ2eEtpMUtNclRKUVF3Vk9D?=
 =?utf-8?B?eVhYR1FqNkVtSXBpc3Q4YmI5NVNSNnBodGRFZHRkVzNSV1lTN0tvYXMraTQx?=
 =?utf-8?B?MVNMMGNCaVNDVFFuNjlrUE1rSEpBL2t4MnZsZUd6UHU0eDlsL0FNRnc1blVm?=
 =?utf-8?B?dGEvemVTTk1jWlRHQVRtY1IrQjA1UlJ0a2RmQmwxdjFsME54Q1g3Ty9HUi9r?=
 =?utf-8?B?eUFOQ3R2QkR6YnMrUVBlM2JPd2hFM1JPWTVyMVJFVml5Tk1KcHpPVUk3SXMy?=
 =?utf-8?B?ZXhmaGtnTUlxODNVclpoZ29EbGJUTzNRRFZqa280V01POTBLSnZoVFdER01R?=
 =?utf-8?B?UlBqd2o5RlVHekhkWm9tWEVieWNQNGJpTlh4bTFxdjhmd09jM3V6Z1VRbGJ4?=
 =?utf-8?B?NGJrZnd4SXl0aHNSTnk5UVZ2TnNQNUkrZVpQbTU0M3M3UTN6dzJRVE9ISWtC?=
 =?utf-8?B?QjFZWnh2YlYxcGFGVzBqL25CVmkwQWNIS0lqUDh2NXQ5dGxiOVlVRE9LK0cy?=
 =?utf-8?B?Wi9FSmhIQm5wa2ZPR1R4b1g0NnUvSlZoc0tkN3pMQXNBTGNGT1hablN6L1VT?=
 =?utf-8?B?S0Q4TVVrR3o3V3JvSXdMSzRROHpuRElQYnZKY3JpV2pPY05LVHVwZUFPdndj?=
 =?utf-8?B?djJhRWplZTV4c2E4bndmMkIrUElqZ2hoU0JSRGdyUXNKbHE5alRmQ1ZBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bkVUS0FKM2ZKV3ZwVzVWdXJIUGRVNHFKdUJxSk1GYU5IVzNLWkRkYkc0KzRF?=
 =?utf-8?B?M0J3SThGMnorZWtmQXl5a3JYZitDU0JUeFdkVDBYeG5uaHBZSkN4MnI5ZmdN?=
 =?utf-8?B?UGZKejM4bExzVHhjL2JraEJRenBpTU0vdUdCS2Q4VTZQc08zZ3QyK1lkVm1E?=
 =?utf-8?B?cmhQTUFuRUQyYm5YT0QwbmpwWXgwamZpM2FWME96NkJpUGVlanRISEdFNVhH?=
 =?utf-8?B?Z2NCemM5OEUrOVEvVmRja1h0VXVIMDJTSUN3OFhCdWorMy9WQVB1VTJXNTIx?=
 =?utf-8?B?aktyWDVNTmFzcXlQZHljRjMzOHJxTmIvL3pJSnpqcElKRjVHWi9FY2M4OExW?=
 =?utf-8?B?a0haVi9ibEZqN3F0Zng4QVY3VmFpVHhtVHJhaGh2MmxMZm1FcDhWeUVNZnBO?=
 =?utf-8?B?dHRpUEtWQ09IZVhHRWNucnVKRDJETFkwVzFuRkcyYisxWVZxNVdTQitvbGRJ?=
 =?utf-8?B?aFB3ZDFLdUJRT3BEK3dQemx3MHZIRXdnWXNHTGxGNk50R0pTOHk2NVJkSkZP?=
 =?utf-8?B?OHkrTW1SMnBlNUVNWkI2YTR6Y0pVczR4dGRjL3NhTjAyYXpycmVOeXZwc0dj?=
 =?utf-8?B?NWJYZFY5R3QyZ2M2MUlSSUtJK2RxZnlPRkl6T3FJblY3MmlPalQyMGswSm1h?=
 =?utf-8?B?Um5NQ25BQ3czQmhQVFRaZ1VTTmlOaUZwYmlZaVBZVG45dVMrZG8vaTFRV21P?=
 =?utf-8?B?Q1ZhVVB0RWxUQWFSVzJiams2aXRqSlZ6NHp2M3hVRHlqb05TUkRIUUNjUnYy?=
 =?utf-8?B?WE5TSkx6OU1HZy91SGltVlo5Q25IczMxc2hNbkIzbGZkSnpQNkkwc3BKcXF0?=
 =?utf-8?B?bE9ydWxhb00yYlJZYjM3d2k5cVlkc0FqWjNacUdPcVBCdGVUY2hrMjNGWkxI?=
 =?utf-8?B?a3hXQ3RMcG5HZWR3WHgzT0E0bkNQRndudzM1VWhUbE96dWw3S2xhUmF1STJh?=
 =?utf-8?B?V2JiMXErNUZGWGs2emxxb3pkWjZtMmQzMEhacVRHSXU0MUJvUG1id002Rmto?=
 =?utf-8?B?UVJFOGlKVVhzYTkzVzZOckFnRk1vaFl6RW5OL3ZydDFCVTcvcEdqV0JEU0R6?=
 =?utf-8?B?engvNWVMM0wyc3pFSWZHb20xMnZxdG9Ha2ZwSkt3eGp0am1PNEl2UTdQYmhj?=
 =?utf-8?B?azExTEJrWW5jVGRqeDN5ZnNzY004VjJGdjhVSmZlSFNveENYN0kwWkZOUzlk?=
 =?utf-8?B?Q09RVndsN1d6Q01qOVhCMUszTWlnTktsdksrTWg0aGlnUGxrcE5Lc2JQUVNa?=
 =?utf-8?B?ZWVkOUx6eHdHMituZTFyZXJuY3FrbWxWbkFRV1pWd2Mxb0phdWNvZm1zai9l?=
 =?utf-8?B?bHMrQmZEaWpkL3RwS1RVWkR4Nysxa0J2VjVCMGJXM29Yd0Z6WTRDWmhCMmNF?=
 =?utf-8?B?VTVZR0UrbjBYYTgvUk8rSy9hTHc0ME9UWHBSc2RnbkZidW5SSmd6UjJmODQr?=
 =?utf-8?B?NVRGSnNCTXU0K3BLeG1TNGh2eVlJOVF1L1lBVkd5R1dGMGszZHlQa0JqVFdI?=
 =?utf-8?B?SzA4UjljZzZTRi80YU9JRlRwWkxOMS8venkyY0NSOHhNYUJmbHQwNVRIbklM?=
 =?utf-8?B?TTRQVHJjd1BTU2hwczJkQVI4RGFaS2dEdlpYYXV5Nk5zS05NWW5LUERxd0Zy?=
 =?utf-8?B?NWpneVg1K1k2QTRJSFpjd0tzMFJ6OXFBQnNUdDl3MTVlNFFUYXFnSCs0ZmVs?=
 =?utf-8?B?TmpCTzFXellKZzFpL3FLSmNDb1ljdHRuT2dFakJIU2ZvK3RQZlMwSlBZMzRz?=
 =?utf-8?B?RVA4MkY0M2thWGYwUEVWeTkrWGx3bFY4NXpFWU5UT0pjQlN1RFVaU2Y0Wk9a?=
 =?utf-8?B?aGs3NkhtUkhwekpjWlVQcWJ3VWVrZW5kRWNFd0dBeUV2cS93S0g2Z214Snp3?=
 =?utf-8?B?LzBOMHk3cHZCZFBDRTFxenAwZUlyckhrWkFaVElOK2NKRndRVkpld2ZvYUly?=
 =?utf-8?B?c3hQL3F1ZFN6UzArSzBuWURZLytLRGJUaEd2NjJMcWFaZWVVUmp3cUFsTnVv?=
 =?utf-8?B?N21BcUd2bzRvcWtOaE14NTZJb1hFWFRYRnl0U004Q3FFTGYzamw2TERKQ0NY?=
 =?utf-8?B?T202Y3Q5UXRydU9KbVE2bGw5ejh1UlRCSUNsd1FXZDBPR0V3MFcwQzMrMm1I?=
 =?utf-8?B?T3p1Tm9BTWVSa2pRS0xPRjh3OE1VZTNiY2gwalpkQnlqZ0NqdFNoQVJIN0du?=
 =?utf-8?B?YXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dfd42ab8-0243-4930-3a93-08dc7b590dd1
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 18:49:19.4549
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lo+iXXUpAe4drywDB9f0yxJDOFoKeaiRU1Bbo8Tgo41Hin4lHhJGOg3RC20u8o/TIAkm4Mzvd3tFI1rQjaop7MWMsOXYnwsv+vqibegakg8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6036
X-OriginatorOrg: intel.com



On 5/23/2024 9:49 AM, kernel.org-fo5k2w@ycharbi.fr wrote:
>>
> 
>> The link is an SFP-10GBase-CX1?
> 
> As I understand it, CX1 is the name given to Twinax copper cables such as the one I used in the experiments in this thread. It's therefore a priori the right value to display for this kind of connection (instead of “10000baseT/Full”).
> 
One more thing: Could you confirm if this behavior appears in the 5.19.9
driver from the Intel website or source forge? I'm curious if this is a
case of a fix that never got published to the netdev community.

Thanks,
Jake

