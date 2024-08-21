Return-Path: <netdev+bounces-120707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B0495A525
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 21:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36D4F284265
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 19:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A59BC16DECB;
	Wed, 21 Aug 2024 19:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a90sogqP"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43E516DEC3
	for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 19:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724267529; cv=fail; b=peFyNBZmf2RLCs28kXpc4FcwAF+BxEYbAkonIpYvUm60UqHD6HxsluJhZgiPHK1n04eEdCAv2ptrmyomrSPOlOfKwqQUr0MxgL7yGu1IQi/GhQRhE9V8Bwb+FvWpiHrWG8MqfOGxaTsxIVucLqSGqAKSklRLDSs7+Xelg5M2bH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724267529; c=relaxed/simple;
	bh=FPyj86grDVKRx41+Hw7Ns6r7SQgataikALsESjHvu5A=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MzqrLERQWgUVfqvRSOOlKsz/zlVGG00ofvT0LPmPCmrznBNGHt782XveIxJyVV98HJlskRtpI5ZBJcUz8zVC5ekCDbBAes9Uu7PkgB5bLUvb3GcluO/xLKEQ4NgGahCiPJEKJ8EuAqDDICEEEbk/l5AhF0Tp90kdhQsfv4rWtNA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a90sogqP; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724267528; x=1755803528;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FPyj86grDVKRx41+Hw7Ns6r7SQgataikALsESjHvu5A=;
  b=a90sogqP6gH46TfnLa/64s2hQiZVJsgqAtwPRHEZ6l6EW5uVm0oVMa0p
   zzpXdk9BY0H6pE5znO6E9u9VgX/3VARq9bjkN6ASCFQ5DifKxU1Z83zaB
   MXetUhyclFbxZ+c0/duad6T0mlIprjjjCHuOJI6Fqj2rX7cGOh8P+sVgM
   RfWKnD6PWzj+prjiUEh7AQddW4l3sMsyEwLPMANBjrwKJRsYDhmxzAId0
   ReScOSwQS4P/6MK/8h9KKpqwvHsdEsmLKmBRauQ1C4AtY3GxNz5EnKXvm
   3PhyeXXKgDHnDlrGMQfzmC81wOI4HK0x2Kts54QZL0gHjz0r44jiDbS9B
   A==;
X-CSE-ConnectionGUID: N9FOxF2jTmyTtISVHqxZJw==
X-CSE-MsgGUID: OU/QFd3CRHGbmOT/uxfE1w==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="33802086"
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="33802086"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 12:12:07 -0700
X-CSE-ConnectionGUID: 1HMgVx8cTlKVO4+3Gt5BYw==
X-CSE-MsgGUID: tpPQW/rXSjiRA9lXpfaAkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="98685480"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Aug 2024 12:12:08 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 21 Aug 2024 12:12:06 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 21 Aug 2024 12:12:06 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 21 Aug 2024 12:12:06 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 21 Aug 2024 12:12:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GaLrbPFH6WrXpv1hG2frh1G/i5n4tMnSkpDzx9lU4QVIfpVUYmmIVWvel35jVtXjZ0/5ivRQbp2KO1/vCI94wZb7Oab+KLPkLlVWqOzCER3WomtjY2NVZpgomrZxJji6DN1bYK/w3RLAi8i5Pl/PSWiaHx56TkFSzPOxQ1rybfSKSnhSDVgsx7AKCgZTIzY+ijRNa45AeBe2bipg71Nj97E88iqRYYOchWUbnKE499A1IhiHIeM/1669CZjwZy2T86NvT2JR68wXsX1Hu21gZJcwHANQAW1yON3aaernZm79qjIIBfOFLXuxtOg24/q0HCH9KNgZg6DGRDqaH8Tkbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9aIHcLoTtI9s+Kf/HGB89lE/CvlKpjy4+icZboFwluI=;
 b=o8z0cXA9yTbCJDmlUtpWyREPE+q4rNzNwxJogUZfCOw9IqrH7hNrqLw3VIuOZ+XBAivStLgmtXWPrjWbr+0pNKWfyDAWIHafgRskLuNn4oqBgV22CPROughMx2bzSCEaKhkZwoK970MfkaECGTolQpOkuAT9JjzYroirmkMVWwBG537P2YgRmV/4T9zT3AFO+D96cDFQ/VGV05gqiLnz2lDQsEeKWJAHRjqu4lbNIft2cx5oHLMipFe7x6CZ3s5T04WcPF04OpG7Y3oUIZ0XLdoh3+Lmg4lV32r0OzCJDBImSUW7AgaV9WksMS3pUxg0zVqB7UtaoTCq4rVln/RenQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SA1PR11MB8280.namprd11.prod.outlook.com (2603:10b6:806:25d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Wed, 21 Aug
 2024 19:12:02 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%2]) with mapi id 15.20.7875.023; Wed, 21 Aug 2024
 19:12:02 +0000
Message-ID: <0aab2158-c8a0-493e-8a32-e1abd6ba6c1c@intel.com>
Date: Wed, 21 Aug 2024 12:12:00 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: lib/packing.c behaving weird if buffer length is not multiple of
 4 with QUIRK_LSW32_IS_FIRST
To: Vladimir Oltean <olteanv@gmail.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <a0338310-e66c-497c-bc1f-a597e50aa3ff@intel.com>
 <0e523795-a4b2-4276-b665-969c745b20f6@intel.com>
 <20240818132910.jmsvqg363vkzbaxw@skbuf>
 <fcd9eaf4-3eb7-42e1-9b46-4c03e666db69@intel.com>
 <7d0e11a8-04c3-445b-89d3-fb347563dcd3@intel.com>
 <20240821135859.6ge4ruqyxrzcub67@skbuf>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240821135859.6ge4ruqyxrzcub67@skbuf>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0334.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::9) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SA1PR11MB8280:EE_
X-MS-Office365-Filtering-Correlation-Id: df89ea0f-be59-4182-9442-08dcc2152331
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K2UzMEVyQTVSNTNxS254K0c4VTc0Z1I2K2locS9JMVNTblo4RHVFTllXM3F1?=
 =?utf-8?B?b3JCYTZMYWhobEZCSTRiSG1KcGtRa093ZW4xZTFDSWZyNDB6bEt0aHUvS0F3?=
 =?utf-8?B?bEEvc2hCTmdoM09BVThuU3pyZHZiU1FsazhVdStEcTIxSkVwZ1lzNFBuMUFC?=
 =?utf-8?B?UlBFRTZqeEpRbHJKZFp1alg0S1h0TDQvQ0JWaUxUa3dZdi9mS1NUS3g1K0Y1?=
 =?utf-8?B?R3pQV0xZRFlLQzRyR3VHbmVRVm8vYXlyRTR4NzJuNkFTZU5xaFFJYzgyd2o2?=
 =?utf-8?B?Tjg1ODcveFdEcUh6K2FUTGgrRTFiWEdxQzRpQ2ExNFAzWENaQkpNMitOT2Rs?=
 =?utf-8?B?OUNKMHljQzloUDg3QWdVQzBwYTdqdWxNQ1R3a2Z4TTZtTHpEdlhSL0FlUjc3?=
 =?utf-8?B?RzJGU2c1enI2aVFxVm1HMUNkY1pyZjdQMVVMeFV4VzVXcEN0QWsySmU3aUtI?=
 =?utf-8?B?Z21HN1BWWjZlQWFPKzg4VHJDYVJHMGRqSzRhVld5TnE4blBkNFVINkczSWFj?=
 =?utf-8?B?WVpFMEhqL2FTeVhsNmM2OWluSjJ1MTYvdHo3UjZ4TGhXckZqaDljSjhvM0xy?=
 =?utf-8?B?MmM5d0Foem94d055bHdrRDNTNjRqUTBBdWsreEgvenhOT0dFVFFPdHg3ajNz?=
 =?utf-8?B?c0pSVkV1MHRmWGFCdzVSVFVYZW93YW9NeUxSM0ZER0lxcEFET1hVaURGN3ls?=
 =?utf-8?B?K01LKzd1bUN1RkVhTE5zeVQ5WlY1dmlJSWpKZlNWZERndENDZVp2ZmRxZ21I?=
 =?utf-8?B?UTRvN2lNV2tHd0xQeE9RdzUrK1VJS1h2eFpxaFJIS0pnUVpJV01hbDQyU21K?=
 =?utf-8?B?Slo3REluV29KU1FQYmZsZlVUK2xPSlZzTTBNVGpHd0hnclVOalBEYkcySmIv?=
 =?utf-8?B?dUNKYzFRNnpLSjY2Qmc3RHVpazJ6VUlzOWtRaHp1RFVsalNyTngxQVUyY2dF?=
 =?utf-8?B?RmRCeTRrTE5RZXJnUGVHMXFad0ZEZExsalNrNzBleFdxR1J0R2dFTGJ0OUV5?=
 =?utf-8?B?emZ6cTBXcGpSVHRDd1c1L2lLMTBrdVExYURZd1pqbElRTGdNUzgvWlR3Y0Nw?=
 =?utf-8?B?aGtiVkZWMEUzNEdhMHFNZDlnQ0V5cVRXRC9kdkI4OVRNZE41YVZ5Mi83ZHpx?=
 =?utf-8?B?UkhjMURuZUg1ZEpxUmFwWjFNaW5kSnlzWnJpcDEzeCt4Wm1jQ1VXeGR0SXpj?=
 =?utf-8?B?dzh0ZFVLZTQ2OTU4eGI3YUpkK3JQL0JielRERG5DQlA4Z2d0MXRtRjFiU2g0?=
 =?utf-8?B?SXdTYU5VdWxidVEvT0dmd0R0QWp0QWZBM3poR28rWGtMekJCTGtrdmpOV3Zm?=
 =?utf-8?B?QkpuRTJmZ2R4ajV6T29CWkgyYlJEVlZ3a05PeGtaYVdiNVZrYmFCZlNzbE5N?=
 =?utf-8?B?WktSTHkyMndGQ2NQaE9nYzNqeGdTUEdseUgwT1gyK3NoQ0FjbEdCWnVLSFRJ?=
 =?utf-8?B?S2pWOVk5SUV3S0FOaFVJd21NdnVoKyt2N2FGNlVXY09vVndyOGF3bEZROEdF?=
 =?utf-8?B?OFM5YS9NWEJML3A3dDdreFlwSmJJS3ZkeWZtT3pRN3pVS012dVRZeGRBUHdw?=
 =?utf-8?B?NnR6TDI1OGR5MDZ6ODRPa0dCd0hTU3RWb2g3UlUxTytsSHRBYVNuMkNKQS9l?=
 =?utf-8?B?LzZIRFZjMVhNTjNaaWdzYUFIV1FJemlTSEliMVQzS0FGNDdmNTRadjhpc3hW?=
 =?utf-8?B?NnpQUjhyYk0yTkREdkIzS3pxMWVOZjcwZG5lcUpnOXJJRVpySVJ5azA3TTBR?=
 =?utf-8?Q?A+4IGY/F/wx4Zyo/bk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZHFaYUI5NzhVOVhJT2xheFBDaElubFp0RC9POFNPQWhvVXpIZTN5cS9sY0Rq?=
 =?utf-8?B?Y0RSY1gyYnFLL3h0ZExTTDVsMHZqVysxczBOTUc0clM0cWhpZERXSTcvWThu?=
 =?utf-8?B?cTJRaFhLcGNZNXNSR2lBUHYwMWhHZ2lsRHlDVHVFWGZuTzY3VFphTE4wVmYy?=
 =?utf-8?B?cW5SQWoyMnJmQ291ZUgvVERxa2dwN21SSGNvbFpFT0VqZmY4by96UTJ5ekJW?=
 =?utf-8?B?bnVENHE2RnBsK1IzYm0rZlQ3anlPazZWWGZxNkdNQXBJK3dJb1hvZElvbXcr?=
 =?utf-8?B?ZUFoNFZ1QnQxSXdQNElDbEZoSks0YUwyUkkwYlVVY05PcC90OUpURE9RQ1lh?=
 =?utf-8?B?Vi9seU1iK1dyZmZtYllBYy84QnE5TkFCOTR3cEkyMnVaMnpEUElvOGRHL2Rj?=
 =?utf-8?B?LzhRYll3VU9wMWNpdExpMEdNblQ2MGhzYjRUMnhrdkc4L1FmUm1CR1dCbEFG?=
 =?utf-8?B?RldTRU1yVGdqMXpER1B2TFM4cmVIaStKYlBhQktGU2pwdjM1RE9OSTRTYXVr?=
 =?utf-8?B?MFlDMURsMW5kMjJsUmVnK0dDWmE2U25lZXdLZEZVVjJzWHg5Y3Zqa3ArQWlk?=
 =?utf-8?B?M0JXZDdFazNLcmtZcWlxRmYvMS9NZU9PaC81WTVmTWMvck55R3p2ZjBkWXgv?=
 =?utf-8?B?S2V3SmNvbGFadERZTVB1RVZEdUZOV09oL0dlWTZrMTFzaXQrdnd3ZU5RTXll?=
 =?utf-8?B?SW93OXEwRW5QWWpaejhQbitFMjFGNkVBd1lKM0xRZ21ubDZzMkVTbjN3YUF6?=
 =?utf-8?B?dTY5dk1KYUdPWVQvQVVtZk5mRWNLUkRKVFVCbmdaTzZGM0wrb0dkaXYrNWVm?=
 =?utf-8?B?VVlJMWh5VE9yZjYzT0trWmgrYWUyVGZpL201dGhrSmZqd3hNV2JwaTVZUEQ2?=
 =?utf-8?B?dUNLdTVlNDlqTnNsQms4MkdJWG5QWlpST1JuMEU1UDhLQ3dCUzRDZmhnUGls?=
 =?utf-8?B?bVFqVW53V2oxYTBJdDlUcUJ1VGxQNzVOby94blRVaENuNXRlZGN1WHZJbkJq?=
 =?utf-8?B?cUoyTVZ5RmVZTzZNaTd3VlUxR2dPSXhhWWpmY3kvNXpXS3ZFaHlrdDRZU3BJ?=
 =?utf-8?B?UG1BcmFyZXAyS1VlRW5YYzJ4dXh1bVhyK2pESFJuV0g1ODdJUnZNOUZkc21I?=
 =?utf-8?B?TzF3bE0vWXhRQk5JQm1SaFcvT0VBL1gvMG5VL1pzdDJwM1ZwWFltdDc2UEZB?=
 =?utf-8?B?aFpjQXRjaUtaN0lCTy9SMVNhNkdsUWRSUVZPT25mV3ZkdVRlTW9PTGVMU01D?=
 =?utf-8?B?aDdlWklUb2syL1BtUGo2Wno5T3Y5Z0J5MEszTzFObW9McVRUdm1OeWl6L2NW?=
 =?utf-8?B?VUMrYkVRTU5UMzRXNUZQN2VBRUErbFF0SlVCZU9Vd3RIUHR6N1k2ZjFBVmwr?=
 =?utf-8?B?Umx4YzhrWXd6YW5zaGlOZFM3clgwNDRoYUk5QkhLdmVvdklZRWtBV2dSTmJV?=
 =?utf-8?B?UDZNVWF2Q1IybjVkNkZicFBWTVBEdDR3MTVTamJhM3pCNnJ1djV2bkJOQk1E?=
 =?utf-8?B?bDdPdXRWSnBFNmEwM2pLdXI2VHdVazBGWGh0UU1KenU3bnZyaHVEc0ZNYW1R?=
 =?utf-8?B?NDZLcFZrTTJkQVRVZEdwN3lJU1pKZytCN0kyR1VkSUxuWTZiYkdqVXBFYXVz?=
 =?utf-8?B?N3hYK1VIRXZRV2Jxd0IzVnJoeHo0MDBtcEVocEE5UWhOaFAzNlRRVVhZdEZV?=
 =?utf-8?B?Z3JRZ2Jjckc2dFNzTXgyL0x4RldVUm9VY24zNFUwampWdUR6Mmszc1lacTJj?=
 =?utf-8?B?VThkbVFSaDlUWkhaandvUjBiMjNTM1g5T1UzVnhKQjJPVTJKVWE2UU5nd0ZF?=
 =?utf-8?B?TVlZSzVVUmRzZlZobzFRNWxmNlcwOTFkM1YrdTE3RnM1czM3TUpwVURVampz?=
 =?utf-8?B?S2lDeHJvWUl4ZHdzUTNzM2pjWWg0WXZFMDdCWlNobUtDRCszdEdIT0ZFNlc5?=
 =?utf-8?B?SUdZVHdvMzdocnF1Nm1zc1IvWDVHcXBrMEpYTGw2RE15MldrUXlBSVkyaEcv?=
 =?utf-8?B?VG5lQ050VkVMOTZlbXM5SHpJdFBiNFlQaE4wcmk0eVdUNHd2ZHNlYUR2Vysx?=
 =?utf-8?B?aUJhL3BFWkVnSWZraUxhM1l2MUJ5TWk4a054c2NrWmU4Q2Q1TjhTcXdPMERx?=
 =?utf-8?B?UjFhSmllclNNRDA0eXE3UDhNZDZWdEd4Z2pNWkVoVUc0UkhGcFVJdlFJOUFn?=
 =?utf-8?B?Wmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: df89ea0f-be59-4182-9442-08dcc2152331
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 19:12:02.1596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KMaE0kH/PV7DN1MotGPmJe8eLhNFmp9VxjhUi0mm2LLrnTUi9TZRgqnoMFAmqqafmutwmrYdRC1CAYUHYHTC1Fb1i4sRaqlsq3inQUQhcLQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8280
X-OriginatorOrg: intel.com



On 8/21/2024 6:58 AM, Vladimir Oltean wrote:
> On Mon, Aug 19, 2024 at 02:53:34PM -0700, Jacob Keller wrote:
>> The patches work for my use-case! I also think it might be helpful to
>> add some Kunit tests to cover the packing and unpacking, which I
>> wouldn't mind trying to do.
>>
>> If/when you send the patches, feel free to add:
>>
>> Tested-by: Jacob Keller <jacob.e.keller@intel.com>
>>
>> Alternatively, I could send them as part of the series where I implement
>> the changes to use lib/packing in the ice driver.
> 
> This is good to hear!
> 
> I did have some boot-time selftests written, albeit in a very bare-bones
> format. I'm afraid I do not have as much energy as I'd wish to push this
> patch set forward. Especially not to learn to use KUnit and to adapt the
> tests to that format.

No problem. I'm quite happy to work on that part.

> 
> If you wish, here is a Github branch with what I have. You can pick from
> it for your submissions and adapt as you see fit.
> https://github.com/vladimiroltean/linux/tree/packing-selftests

Ok. I'll investigate this, and I will send the two fixes for lib/packing
in my series to implement the support in ice. That would help on our end
with managing the changes since it avoids an interdependence between
multiple series in flight.

Regards,
Jake

