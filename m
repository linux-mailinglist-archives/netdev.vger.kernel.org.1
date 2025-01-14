Return-Path: <netdev+bounces-157921-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 609FDA0D4A4
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 01:05:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F5111885C92
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 00:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7EFD1361;
	Tue, 14 Jan 2025 00:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JrC8B69i"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD82EF4F1;
	Tue, 14 Jan 2025 00:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736813103; cv=fail; b=j3lpA3MDsiNelUv5foHXXPQPA6Y/IyJs7H6WJKV+8U0F+yTv4ggGptZ9huyRft6mXoUYF+Yq448NKNa4IAGW3uBf004ISPXXokZ4cM8iPDdT22jCfqyNmZy1S37/aXpJ8k5BkMfz3FkvPs+dj5ixSMXwxqJU6K5/eA1Jn/mb3Ls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736813103; c=relaxed/simple;
	bh=FPdpsvtIg/JbBolBlsIkUm0j8TwfJrd0k4nNhRl/B4k=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=STADZZLe5aL1CJbvvSv6MyqLBaDE2V9CPLzKgxNBKiHkU1Q+7bxgtFhRHar5uWZhTfl+1kX4c1c97NJbV/33Z3sksR2fW9OuUsjH/XQpI1ax48P6wFx2F7Y/aIA+HogAsCl6N4ciimcMWfHc5I8d0L6ECgdEFae+0H7tTmlrt1c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JrC8B69i; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736813102; x=1768349102;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FPdpsvtIg/JbBolBlsIkUm0j8TwfJrd0k4nNhRl/B4k=;
  b=JrC8B69iXOmbGGvSkAbNEVY33hGrdjGhnCJdPCgNxoOa7f3BMWlAXThS
   4tUD6vnI+6IlvNp99PXO21lQpOpkOopQr2KvAs0fWNbXQ4kSO9BLDyKsB
   EZKZs1C0aQ3nSBpJMyR6d5OHHqJc8420CD4TaVvMckicgvyKSLUT+HkI5
   6iSlh0u9Sr/80dZyc4dJcUVdjXR0x/nNoxD7xnYu7lxntm8jwmRiTJU0d
   FqoRVVxDQt0pRALodeuYE8t8nOW4oUvBhDZLCzytSZDZZWvJ7DVdXzOtK
   gDenbH5ZCfk+tJZzF70t0vFS27zSoNQ/3EXksKpgKUz7Br17Qs1JHhiFb
   g==;
X-CSE-ConnectionGUID: a1rXiTqbSEmKlc9rh0ompw==
X-CSE-MsgGUID: 4p30/cyqSSa/4HRCg/Jd6A==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="24696680"
X-IronPort-AV: E=Sophos;i="6.12,312,1728975600"; 
   d="scan'208";a="24696680"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 16:05:01 -0800
X-CSE-ConnectionGUID: Kc4JsQkSRtKLHkh/YUBdIQ==
X-CSE-MsgGUID: r1vyhUe6SeWPjbL/+MgISg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,312,1728975600"; 
   d="scan'208";a="104720059"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Jan 2025 16:05:01 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Mon, 13 Jan 2025 16:05:00 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 13 Jan 2025 16:05:00 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 13 Jan 2025 16:04:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o+TVvqhRCyFftd88CIfRWNfz4DOZUAiWVi+zxBZeH9CiasmgmexX1WMkxIRlIYqnV5lcLmuGjrkEBuJ1WU6e/r8pOzp+driAHz3IjY/CFaFQ1fMIelKDkAFIiTn/y/htZf/eH1Cj6Lf55cY48znSycaReK6eg5HVdD6tglIY00mOG9SnpUgbiAiFVQmhRAq9wY3M5IPLc/DprYc33ClHsslNaCWivu3eKse1bpq2/DNJXKKv83lUEsMR7t79nseo4h8l4XYc4PFM2AxeiZzl7GFWXAkEHGfW5d2CVpmbNpWLQMtFAVR6z57SGOKl1dCL3clc/AJtlYtLicrK3Nffdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PyWK+TzvvMG50XO6ZZOXPgeiqBw5lmMrdbn1ykHZM4Y=;
 b=QHOzf80j1K8N7N4r9Ak1JxyJbpDqClH3N6oeV4UsRNnFEVhGp7aKTXgkaMIcGFQf+jT4dRRQIVMC3Anat1EDpPrclkVjC+f/T/R5fDl/ICf/BpSwxWc7zsv6IM2Ee8dIzkoYZ/LqHUqx1GXr8jhjUSAgHwnY/WntEZD/gO8k6iwQQ/F8Ov4hfWA8o80raMsLJPtPfTzRmuSJINLwXwuPD1OL2fhIZkFFv4O/TYqkQTzNba2eYhVl1gfheQWTVU1FuCzXVUL3LJXDGC45rrvi7fXFR4dzVcAKM3cc21w5FS3VTAVRNQfiJ3yNp8HUqT+y+vAtWFeHkh+JOWqwsAt/Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CH3PR11MB8563.namprd11.prod.outlook.com (2603:10b6:610:1af::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Tue, 14 Jan
 2025 00:04:44 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.8335.017; Tue, 14 Jan 2025
 00:04:44 +0000
Message-ID: <b5d5208e-a75f-4fae-ab6c-3b847596f06e@intel.com>
Date: Mon, 13 Jan 2025 16:04:42 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] ibmvnic: Print data buffers with kernel API's
To: Nick Child <nnac123@linux.ibm.com>, <linux-kernel@vger.kernel.org>
CC: <nick.child@ibm.com>, <netdev@vger.kernel.org>
References: <20250113221721.362093-1-nnac123@linux.ibm.com>
 <20250113221721.362093-4-nnac123@linux.ibm.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250113221721.362093-4-nnac123@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0041.namprd11.prod.outlook.com
 (2603:10b6:a03:80::18) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CH3PR11MB8563:EE_
X-MS-Office365-Filtering-Correlation-Id: c241060a-7727-429f-f794-08dd342f0cf8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YkNRMGJ1QUN0M2drVG1TdEZqdTA3ZGpSenJPYzA2dE03WDY0VjEveVhpSDNQ?=
 =?utf-8?B?MUFtNzhrS1ZVNVRDK2Qwdzd6VkxCTnVSZGw4aHZIRmN0eVdxeWRuYTdDdDBO?=
 =?utf-8?B?SFZ5UlFXNFI4RUdwekxrUnFkZDJaNXF3Qi8wd0RpY1lMczIxM0NQZGw5RnNQ?=
 =?utf-8?B?ZWFGdVBkTVFEN09saGZ0ZFhFSStSOUdxVjJxNzdEcFhqNkJIZ21CVlc5RCtk?=
 =?utf-8?B?dDFMdWlNaWYrVGVzaERNTHdBR1pSR2FOaEFJdi9NSDcvL2tGMFdYRWgvVWVM?=
 =?utf-8?B?S2tHK2J4WW5UUHdvQzRsdWg5ZjBPazR5OEQ4Y25BVWhDZzNUR0NNOFdaNTlK?=
 =?utf-8?B?Ni9oNlBYaENQdFBpTHk3VGVWZVh4RjlnT1NHYXdmR3VGZmNjUFhTNkFGVE85?=
 =?utf-8?B?eUhPZmFUWHh4U0V5SDNQUmtqS21zMnJNdXFKdDN6djQrZEZEcHAraDZSbE1W?=
 =?utf-8?B?dm9paE52cHBLeFc5RVFLWlUzbThrM0NWVFlUQVMxUTRpNGhTMm1pOWFiOTNW?=
 =?utf-8?B?bE1JOS9OVXFxVVQ4aFhyTXdXbUlmSG5lTEpxdk5xNkxjVUlQdDFSMVJ5cmlE?=
 =?utf-8?B?ZGpZMUpVclZUYnBoRWQzTDMwWEhDdXVzazRkQlpMK1R3L2xsMnhmYVpjSkNU?=
 =?utf-8?B?Sm1xYmhtcW9BTS9jM0tFdktIS3NMbkpMMXRZVWZIdWpiQjBwM2NqazFXand4?=
 =?utf-8?B?Z1hPeCtQRGpFTUNxUFIxVTlETndpNDdEUWVtLzNLZzc1YVBET3NkU0Z6NG9H?=
 =?utf-8?B?S1YxMnRWVmlCWWhzUkxCZ05rU1pLQi9JeFV5YmIwR2ZYRzRtbFdpeVF5U0pU?=
 =?utf-8?B?WUJad2JRb1d0WVRPSTJYNHFqTlg4a01yZ0xFekMyWGlvNTg5UzdyamxtR2pm?=
 =?utf-8?B?UFNNcnkvKzcwRG0yQ0krd1M5bG9WTXQyVVEzWGIxeGhyVUFrRXlhUUZPcmdG?=
 =?utf-8?B?SitsQ2ZDV0dzSG00Z1VkWCt0bXpHWEErajBSS0hCRnJzcEg5NVZJeGJVN1dO?=
 =?utf-8?B?M0JpWGpWTXRMallTYzVKR0FVV2o2Skg1eGY5RzZ0VHhYZGpQTHF2bkNmVW5O?=
 =?utf-8?B?Ym90b2wrRkJyWmwwNjVaSUNiRDBBSU00SXExc3FGWmYxVnZOdTdJSGlpMXl6?=
 =?utf-8?B?Z2taM0Iwb3hlcmlRMUUzL1RNaFpJVzdyNlYyanZPYjlrNlpKN0JWWDV2UXEv?=
 =?utf-8?B?eU15YXdpOXdETlc0WUd0Q2FPOFJ6Y1NiUzdGRFRLQTJmSFRiSHlUdnorYUli?=
 =?utf-8?B?Q3IzL0JwdHowUkFhdHdnTHRwU3llVG1CU0R6OWRremdnd2VtYjhkN1QxSS83?=
 =?utf-8?B?WlV2TkRLdkRtVUVTa0EvKzVadlZUNks1VnNMVWY2ZlFjR3JxWHlRc012R2cx?=
 =?utf-8?B?bzlxUGhUNnEvaHZvbzd5akJ6cFY1TGtmTDI4UkdpaWt2QzJic1RLYXdhZlRP?=
 =?utf-8?B?MXd1N0lVSDNFa1h5K1ZoYnZGa1p5cHcwN0xncWw0THdvZFAyZWkwcTVuTGVz?=
 =?utf-8?B?b2phVjY4bzhwdi92N1NuMjJHK0NNY2xwM0krV1MrWGVMSE45RDJhcEFwNEVX?=
 =?utf-8?B?UE9UcERPOHgvZi9nY01Va0ZqRnJ6T3VUVW9helNsN1JYcjBkWEFlZTFuZzlx?=
 =?utf-8?B?VmJKaWNlWjlGWVVxVHpsVytWU0RoTEdLZkFCY1JNckwvKzBPWTltQmpTa1dV?=
 =?utf-8?B?Zmk2NEYwK3d3Z21ROWlKZEpzV2lmaGVEQi9jdTVDSFBseVdTZThRY1dpTGw2?=
 =?utf-8?B?cnhpeDMyekFSWXc4azBmRmlmSVZlblcwNmo2d1Y4VUFBeDRJOGNVNFpHWXF3?=
 =?utf-8?B?dFJ6RGltOWVKajZyMHFDWnNWL0w0V0hkSXpmOGd3OWRWbUlCdnBKMjZ5ZnFl?=
 =?utf-8?Q?mkyRUjNoZWFEF?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dk0rWkxuM1g4cW5HSHJxUlFGV3VwN2xiUHoyL253WnBuS3MzV1gvSjBXdDF1?=
 =?utf-8?B?K2t6NkNLM3ByeDd6T1g0RnBudWVFSjFIbnJwaXNmcHdST2QybE5CMHVNb1N1?=
 =?utf-8?B?R1E2S0ZGT3pTMTZkcTNVbXZ5WWI5VVZLSFdWamRQZjlMZThnSnA4STJ2VHRa?=
 =?utf-8?B?YW1FSk1TRFJUOXcrV0ZnSEFnZE1zNExqY2owaGJpRGY1SXJVR1VMaytibVFr?=
 =?utf-8?B?NVpRN2hTdkp0cGQ5NTNwNU51VlVXaWtZanUwbkNhRVpIUkZwSmFyeWltdmtN?=
 =?utf-8?B?amlCK3A3OVF6WkdDVTFjc0t5Q0p5L0xhMXdRenNNaTVGRGo1cUI0U0NKZHlC?=
 =?utf-8?B?Qjh5WnVtaERNQ2tYeW5aNGlKdXlwRk9jdWdxUUhnYkFNRXVwbjV1d3BxREpi?=
 =?utf-8?B?eCtjQnBoSk14aURuaHZJZm1sKzlZYWlsLzR3L0svcnhUUmpzcHdsaE5oaVVy?=
 =?utf-8?B?UXE4QnFwMnROU2VNZzVwZUhkWTZlOE4vSGJ3aC9KaWwya3RlWGE2QVN2cmgr?=
 =?utf-8?B?WTNJS0JTczlHUytnWXgyVGxMK3VWZkxHVEFmMHcrSmtuQW5tckRkajBKeVRH?=
 =?utf-8?B?bWlmYzJkN25lUHFCZFNoUVNtSE1mOU53WGhNZk5SWVRKUGFMNHp3b1k4bmov?=
 =?utf-8?B?cDFJVytxY2xNeGZ4S2h3cGVUQWpTbG1KMVBtQTZtSzNEUXBTYUtTNXRtZ09i?=
 =?utf-8?B?amcxZ3JWdEgzNHY4TDhnSkFEMzBJZ2JObjlaOWhZbG9wRkVnb3lGeEN3U1B0?=
 =?utf-8?B?NDlLNmpSa0h6KzJWVHk4SUZoS3JicDNnSExXNWIwNEdDREFyUVNTcUNxd2Q4?=
 =?utf-8?B?cG1Wa25UWTdXVUVFQnF2UWk1TjVjc2MzNGN6aUttblpBR1B4LzV0NW1lMjZy?=
 =?utf-8?B?eGJwbGpDMHNWMFh0Z2RxVWhxS1JYelNuczhSOFpDSjVScy84Yk9pd2htN055?=
 =?utf-8?B?L0tBRHdWdnFpNlFObEgxby91QzY5K1p1MTF0MVJJRHd0ZkYzWWlubXJ6YUdG?=
 =?utf-8?B?S2VodVphcWFFemZRckJEVHphUzZCaExjUmJsYTNIVkdyY3pweHVLVXhVdFh2?=
 =?utf-8?B?V3NkZWVray9ham9ITGtWNk4zNUgrbUhPUFpuLzBrYS95QkZLallZeVgvYjBB?=
 =?utf-8?B?VFdWQVlHUTg0b2xJR0ZxYnc5UUNIUnpvTjJ2c1RNc0xHVjM4TTJxUUY2ak85?=
 =?utf-8?B?blM4ZTBwOWFSVmRSam5rSnpYNEN4bkowalc0MG1PU3k0eDNxdUFjNUI0S2JJ?=
 =?utf-8?B?bG1RdWFoeUZ4UTNwVnBqNnRlZXdvWmk3aFlCL0l3UHpOSitCRkd1MjZKZXFv?=
 =?utf-8?B?eEp3WjF6a0djaHhHZzRoa3BpMnViYWMrOVlkZVBYSjhhZC92Q0RwK0tlLzZD?=
 =?utf-8?B?eDZpMnBXTXdOWkh2MTBYSHBmMjRKcTFnQ2JlWHNBcVBrTEsvOFZ1RzNoU0F2?=
 =?utf-8?B?VWtpeVUzRjU0U05MZmtiYTZsTnNPMVZhV0l1RmxJZWpQSTFlVXJhd2xzbnQ4?=
 =?utf-8?B?a0owbFpIZEZNQ2hEUmExRGlWV1J3bDkvNmdSQWluN29mQ1RsWG5xWGRLbW03?=
 =?utf-8?B?K2lTSXNRbU45V0ZLTXVkUDIvQ3BSbnJJOHlQR1d5cXpVaHREUldJTWc1SWkr?=
 =?utf-8?B?THp2TU4rdEo2eHYrZ2I4Wk9KUUtQdkduTHRuUXpvQkh3WGNXYW04MmZ2OEtV?=
 =?utf-8?B?VGtqMzZEZXVmT0ZsNlRSVCs1akV4NW1pWUc3c2I4WjgrbkZJZWJHZEhMWTM1?=
 =?utf-8?B?emY1Tk9MejR3a2w0Ly8yVmJSd3ZqU2F3cEEzNXlHcXhYSGp6UE5BdkNjY1or?=
 =?utf-8?B?R2tLd1hDVEFlalJPUGpUd0syT2hSWkovd0N2Y0h5OFFsdjZaOGRJQkpJQ1RD?=
 =?utf-8?B?SmJIaGdrQUh0ZnlVcTVuRUFDb1NUQmdxN2lmZ1RQb294c2VjQjR2eFR4MkNZ?=
 =?utf-8?B?UHRvME84YWFLd2gweTFETlVQekdFZU1jSE85UmNFU2tQYzkwelRwN0pQRnFV?=
 =?utf-8?B?R1JZbUZqays3bGJhOTVuQ3lNRTRiV2V5T2tqVHJWa2s2ZzZrSTNBVEpqWWZj?=
 =?utf-8?B?UVI4RWdrM0RVQ1I1U3M0NGp4Rll5N1pWS1pTOGUrY3BBK0lJdVgrR3UyYUti?=
 =?utf-8?B?ZDMwUkMxL0o4TjhzeERtVFRPYVk4THIrRmFVRkdnRGNEdVl2MXpWS2FORWxU?=
 =?utf-8?B?YXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c241060a-7727-429f-f794-08dd342f0cf8
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 00:04:44.3450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: du92aZduv4rvYtDxKMNxx9gyGWljQ209dsmiUwWZzaFpxI6/E227YJgGDLRQP/oeC6fodcik18zYbFWK4dY+FrOl2Yn5/ACFzz5YWCcDCaM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8563
X-OriginatorOrg: intel.com



On 1/13/2025 2:17 PM, Nick Child wrote:
> Previously, data buffers that were to be printed were cast to 8 byte
> integers and printed. This can lead to buffer overflow if the length
> of the buffer is not a multiple of 8.
> 
> Simplify and safeguard printing by using kernel provided functions
> to print these data blobs.
> 
> Signed-off-by: Nick Child <nnac123@linux.ibm.com>
> ---
>  drivers/net/ethernet/ibm/ibmvnic.c | 23 ++++++++++++++---------
>  1 file changed, 14 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
> index e95ae0d39948..a8f1feb9a2e7 100644
> --- a/drivers/net/ethernet/ibm/ibmvnic.c
> +++ b/drivers/net/ethernet/ibm/ibmvnic.c
> @@ -5556,9 +5560,10 @@ static int handle_login_rsp(union ibmvnic_crq *login_rsp_crq,
>  	netdev->mtu = adapter->req_mtu - ETH_HLEN;
>  
>  	netdev_dbg(adapter->netdev, "Login Response Buffer:\n");
> -	for (i = 0; i < (adapter->login_rsp_buf_sz - 1) / 8 + 1; i++) {
> -		netdev_dbg(adapter->netdev, "%016lx\n",
> -			   ((unsigned long *)(adapter->login_rsp_buf))[i]);
> +	for_each_line_in_hex_dump(i, 16, hex_str, sizeof(hex_str), 8,
> +				  adapter->login_rsp_buf,
> +				  adapter->login_rsp_buf_sz) {
> +		netdev_dbg(adapter->netdev, "%s\n", hex_str);
>  	}

This is nicer to read and a bit more flexible than print_hex_dump. Neat.
Strictly you don't need the {} here, but i think its more readable given
all the arguments you have to pass to the for_each_macro over multiple
lines.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

>  
>  	/* Sanity checks */


