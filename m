Return-Path: <netdev+bounces-86596-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D22189F422
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 15:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC86D1F2CE02
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 13:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5224615ECD2;
	Wed, 10 Apr 2024 13:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LswlFPl8"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6416215E5B1
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 13:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712755395; cv=fail; b=TvIpOc2IRFC6Ebx2YeAjLE6B5rGqz8Xy1BOSs8ff8yrF4sJ3UpUROYfsdSVhhna2Y4kUuf4IrPtVFhp2Edbf1EYCkdiJFuVJagNq3il/VodFuxbwi8/mfccma3yLXd3xmywc672ra1LLl5gwVL0Hw3u0J2gNiMwNtxFWCx6hfcM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712755395; c=relaxed/simple;
	bh=oOfgsRykZfszCPqcIFmkhwv4JWwLt/PA+rgWKFZJa64=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fRNB7pjcsCzlkFi/HQuJBl2cTQoniFoNpymxhJ2+JQKXg9o+a417Bik4dyj/yzbxWmhPHvGlpBZT5AcNKPcvVbP+5DgDY4x44NzWldzM7NUPuzJ9oBW25wRuGrB7yVzu7/lMsjYDZT9eJziNusAOsq5+IHG21GCPLJsHVY2QvKk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LswlFPl8; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712755393; x=1744291393;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=oOfgsRykZfszCPqcIFmkhwv4JWwLt/PA+rgWKFZJa64=;
  b=LswlFPl8+p8OvSb71G31GNc6fOwTl1Jl3HkeIMktRUWCHAH7Fg4kMSOO
   wrEeK+yargSi2/Qhg0fTZvF8Ny8sPnK1vLnvy5aFRP93xmA4gI7I8mNqB
   XLJ/QwyFNlfeeIuk46kMrK33U4VOoCtROZdPZApqxTUCuxz1loNV9Z0CP
   6l0vTftlDJLAz1sfV97QCf0EGx2GoR1jURj+N5l5zhyveCF86+mtTrylz
   ex46dvCF1kXYv2o/3ymP650cYl2oPzdWePajEOFwMDgHVVqJKwv0g3X49
   h7VVDLd+9faaPasYCbTirNKeVDWZ4m+A7+u2dIlpuedWJmyodRluErIg6
   Q==;
X-CSE-ConnectionGUID: Qt+rvtSCQhmWfxWqnCkd7Q==
X-CSE-MsgGUID: 4SC8eRkbToaSUe4+JgZr/w==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="19265019"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="19265019"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 06:23:13 -0700
X-CSE-ConnectionGUID: 6YvQ6tYMQseHAY45ghUyGg==
X-CSE-MsgGUID: gsfvf6x2RliLJlUv/0Uzuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="21136904"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Apr 2024 06:23:12 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 10 Apr 2024 06:23:12 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 10 Apr 2024 06:23:11 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 10 Apr 2024 06:23:11 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 10 Apr 2024 06:23:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HTt4kafMRLtGQTKQvETOlr3/D0fvEMCYmCzDhCwFUMdZIMsk6YzcONGeDO1/ZoHmQr4bfdIDSsDrQQzp6DcTC2w3Wd6MGaMY+vMbv2IEh87Xw5gGJ26DLvBL41Ib2y3kEisCrxTU2UEAaWynNPG2suZ7yKe0L2ahRgQMI9TX7BJrpvuof/eaB8ToNJvko5oM92LFRzZYpglBj0MoUjG7lmMvl+4NTdlSAmpsjbnoRQ0u+jcDBFr5LErF3gmhg6eubg0z5qscGAdn61O9ET7YrHhGrrlgChhEI1LdNIX08FIQaPWM/D2e3I1o9z2Clst9v3DeOnLxNfUZ7zNsl3sAJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5SVuEp4X39K0kC01xzROCh+Go/wefrPTNfVDl4XxESk=;
 b=FEmGu0VkF7LTwrASRN/W4bqvU/M/9cE3D7olEd1zPU1ivNDC7zjgZNCNR9kFuWjuhFkE+STHBXFM4plY/mTI5xkAou/IrBPvYCeWTfI3NElTum+EeZK8TEXV4gml4hj+ZDUbpE+mZBeOZny4lEdrKFEq2/4LLHGE1BJCJYd/VH/clJTsEWlxaNwBirFl9779xWQ+h4jfjorrhH8WMkteNOVG65OSH2yGNE1ICLwcEsjWuU35R5SomZyoBhoj+9S1JuemtoeOwTR3mq9g7bs/ZIILTk0cmgBmf7bud5FNIwZuYN5dhQF/C42B2pG/K/oV6WUx3Nfhu1Ihu8Ifm2DsLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by SN7PR11MB7116.namprd11.prod.outlook.com (2603:10b6:806:29b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.22; Wed, 10 Apr
 2024 13:22:58 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::5c8:d560:c544:d9cf]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::5c8:d560:c544:d9cf%5]) with mapi id 15.20.7430.045; Wed, 10 Apr 2024
 13:22:57 +0000
Message-ID: <c37bf2ba-c657-462e-81e6-2d065eacc8eb@intel.com>
Date: Wed, 10 Apr 2024 15:22:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] ipv4: Remove RTO_ONLINK.
Content-Language: en-US
To: Guillaume Nault <gnault@redhat.com>, David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Eric
 Dumazet" <edumazet@google.com>
CC: <netdev@vger.kernel.org>, David Ahern <dsahern@kernel.org>
References: <57de760565cab55df7b129f523530ac6475865b2.1712754146.git.gnault@redhat.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <57de760565cab55df7b129f523530ac6475865b2.1712754146.git.gnault@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0241.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b5::24) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|SN7PR11MB7116:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 21kegTeLew5fJ1cioNF2nPeW5Xaps0B/Cd2YwNjo0HoAV6IIhYDR53S48+aKOM90UTiyJ/ZiVy9hE8/mXhCJS6gkWGdkV0xTpHaLWAoVFAX9FnGiVFy+wjMpmaJ6KsOMkF6kcAYAZdAvaNDRdpfvoGFAxz8GkYsxYzvuouCCmCBa5ZudRxO1xwiLHEqotYDuSGsyJopIPXuyGNN7If36xEuHvzUNjtvqOy380iB8JHL5iF85WY4hbLdU69fPrclK+cO4Bkt8xTjH1XAAtmvjl/BF3fuqvRaget/G5TrfKDqGhVlDTOWPKHaNLH8BBt1SLNMQD7qSEcZKHhKD3Vv7vxNjJoUgl1ONCIyPIonEz//tlOH9k+lIZ7qXou+mogFzloTpoE12k6hqH15uzJJo+QimJnzWpOV1mx/8d4UjZDUw4Pt5AaufOuUsP44kJIYWb4GBEAX7rneZiAPi9GeMW5tZlcVt3DED4BNle/pVWGot2F6Dtwx7VzTvRBlE3/+Xfmzmg00q6Lf8SRELsiFp5Z8kKDm2WTXa6Dtd5S7Dd4WPDIwFIen2dBef0kib6B70iOG+1rOaiG5fe2ALlOwDf2B+AyySg87GZVkYmezUzZ6XD8A3pFWqFR6gZ+0pCem32DsCgiJZ1yrU/crqx563UXYnrwtwjt9dmnqYcZMd47g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dnVvdUZldEVCaHNwNjQ5bGw5aXQxOVRqemxMVXN1VEw1bzQ5ck4rV2ZoTjdh?=
 =?utf-8?B?aHl4Q0xvT3BKZEd1ZFloaUluRklEL2QxR1R1OVZqalorMjNmbGYyaE9naE9N?=
 =?utf-8?B?eEZteFAxS0x3OEg3ZmxxR2xMT3JzUkphZy9ZLzU1ekhCM3lVZEZsbFhYN0R4?=
 =?utf-8?B?UmptS0xUZm1WanpNSmxpKzlyUEo0SFkxS283Y2dORnpxVzYydERDbEZQUllE?=
 =?utf-8?B?VERjWEtqa0ZyallGdmd5OVVwQzhwM3F3ekJkQVV3allPQ3lrTVZGaU1ka09Q?=
 =?utf-8?B?eE9VUitsTjQ1eEhvSE1ETXF1OUg4OTBlR1k2dndJVXRncDNRYzVHcnc4dkRK?=
 =?utf-8?B?YnNLcTdaaDFldi93U2tJdm1SY2hxL0F2QXR6VGdCdGsxVk1yN2loM2tVVWZ1?=
 =?utf-8?B?L0lCK1FQZkJrVytQczJ2QVpMeFJ4dEpzTE15cVM5NjJ3VWR6MjhVeU90c3Qv?=
 =?utf-8?B?UFA0REp6c3I0OGZ5YWhxZUc0enMrTkdpOStMYktCbUVocGhWVEl5WGRnYTM4?=
 =?utf-8?B?WHRGeWhRT1JxY2ExTWJDbUl3QXgzelBSYTFOcGhSUkhhcU9FaWFVWjN2MEVJ?=
 =?utf-8?B?Zm1QMktPaGtyeGFCUmZGb2pxMEd6KzZMVDJnZXZYNFlCMWNWYzFaZkZTejg0?=
 =?utf-8?B?K2d0VjFyR00yZ2g4dnhKZE5RWjlRTUFwamFpajk0Rzd1eVh3eUU3WFNyUTRt?=
 =?utf-8?B?VE91K1FyMlVxdVJYbFZMdEptdytkMWEvdVhnd1kzbFozMy82UmJMbWhoNVhG?=
 =?utf-8?B?ZDhRekJrc0Y1Q083VzR3WmJMN0t0eUE5ZmhEVGJ6NHpEaXY1RUZwemljTXRj?=
 =?utf-8?B?U0x6YTNjQk1hR3VWWU9mUlBna0ZkRm4rdkgvK3h3V0YvV2h1TVR1WGR2cjNC?=
 =?utf-8?B?OG9RRkRDLytpK3BGRHFCaFN1dFFwQUlLcWoxNlAvSmJSNWp0Z0ZDckJWRStq?=
 =?utf-8?B?MkRKZVdIaTdWNmt3L1FnQXMyME5UUzR4M2k4bjdaN1NqNDY3eUFXbElnT0h1?=
 =?utf-8?B?UDVBT2NrUVR4dEkwVGUvT0hRNFNpZU92MzBVZXFla2UwendqVmVJR2NvWThE?=
 =?utf-8?B?TlhyamJiUjhlUmFqbVdVdmNQbXJPa3BvZ0k4ZTUwa0dXVVNMb293Wk1CNHpR?=
 =?utf-8?B?Q29ORmI0OVVOOENhWkxXZ0tXN1Z5a1Qva1A2TnRnMkFmZDdzV2xZaC9tV1Ax?=
 =?utf-8?B?aVZmVjYvWTZBQzBKdDJSdmRZaEt0NTJISUYwZ3diWVE3cU5GZDAvSmQ1eCt1?=
 =?utf-8?B?aXJpSW02M3AzeXlad2srU21vN1JKTC9UTzA0Nkd5VzRzTHA3TUhzWWUzRU9h?=
 =?utf-8?B?TjVjZWx4ZmJyWUZyU1JiVm5XblM5NGNrdmtrSmJnVlZMaGI5djhZZ3RNOWdF?=
 =?utf-8?B?eFc3WnJvOXBKb3VMZDFzRzZSek1DZFBCeW1rdWZRRGR0Y0d2Z0UveVBQY2Jn?=
 =?utf-8?B?Wmt1djJXRndBSGtGYUtjaW44a2E1U1FNNUMvYVJJNWl6NEtidWF0NVdIM1BQ?=
 =?utf-8?B?Y1R2R1p5aDUyZEk4VC9QUXBrbm5nbUcrbGxsWTl6RStSelU0TkVhYU9xWG8z?=
 =?utf-8?B?TDFrQVplc3E2QjJ2d2lYanBHOUhKL042dTRYSXlad054QUZibXZWSnAveUJW?=
 =?utf-8?B?L2QzaGY1aWpEK1JhMnBJTC9ZOEtMWm1FZUtRM2xia256MEZGdFV4emFQVGMw?=
 =?utf-8?B?eVBKR09WK2x3RGJsSVNreDJNeUtkSzZTcDArbVVwYUEzTVNRMHB3Y3ROcmVD?=
 =?utf-8?B?TW02cVl3TDdDMnV3TjFYamsvUStmOTI0a2pDa0hWQjY2QndNSDJIdi8xbjZ5?=
 =?utf-8?B?eUZJQ0VhWlh5cUx2UGtRY0kvK1V6enVrd1RZYmNyOC9YNFVvTWZnMGhYR21y?=
 =?utf-8?B?Rkt6R2xCOWhMOTZOUGVVOUhJZzEvdEQ4clZFZkVtcEJ6T3k1cndvR1Uyancx?=
 =?utf-8?B?RjlMV2xuUXMvN1lqbEZaRnFuVEFyOWJPNzJVaGtESFRFa0JTK091eVNIRmZW?=
 =?utf-8?B?SzN6aU9ERGIzMml4Njc0QlJlYUhoOSt0WmQ1UGRqcW1YWTRvUGliZlpHS01o?=
 =?utf-8?B?Z0JLRGgzelJjSzlobWdXYkFMK3dPR05TZlpDVVlQbnJ6QVRyTWtLcWUvaUFy?=
 =?utf-8?B?RC9RVlR5eUZrUDd4dHpjZWxVRmREQ2thVTA2dDJzalBqRmhzYlczT1hEK1oy?=
 =?utf-8?B?eHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 66f99b3b-6086-475a-8de4-08dc5961567f
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 13:22:57.9113
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0zn95jCdFLZ3yu5KJVJHUfpJMIJpzgwI5h3Cs1BI+G8gyWkRt675cI16fD4oyJ5hoBPENzGbYssLplkox5OUSsby/MmhFCTuLi5uz/ERi90=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7116
X-OriginatorOrg: intel.com

On 4/10/24 15:14, Guillaume Nault wrote:
> RTO_ONLINK was a flag used in ->flowi4_tos that allowed to alter the
> scope of an IPv4 route lookup. Setting this flag was equivalent to
> specifying RT_SCOPE_LINK in ->flowi4_scope.
> 
> With commit ec20b2830093 ("ipv4: Set scope explicitly in
> ip_route_output()."), the last users of RTO_ONLINK have been removed.
> Therefore, we can now drop the code that checked this bit and stop
> modifying ->flowi4_scope in ip_route_output_key_hash().
> 
> Signed-off-by: Guillaume Nault <gnault@redhat.com>
> ---
>   include/net/route.h |  2 --
>   net/ipv4/route.c    | 14 +-------------
>   2 files changed, 1 insertion(+), 15 deletions(-)
> 
> diff --git a/include/net/route.h b/include/net/route.h
> index 315a8acee6c6..630d1ef6868a 100644
> --- a/include/net/route.h
> +++ b/include/net/route.h
> @@ -35,8 +35,6 @@
>   #include <linux/cache.h>
>   #include <linux/security.h>
>   
> -#define RTO_ONLINK	0x01
> -
>   static inline __u8 ip_sock_rt_scope(const struct sock *sk)
>   {
>   	if (sock_flag(sk, SOCK_LOCALROUTE))
> diff --git a/net/ipv4/route.c b/net/ipv4/route.c
> index c8f76f56dc16..bc6759e07a6f 100644
> --- a/net/ipv4/route.c
> +++ b/net/ipv4/route.c
> @@ -106,9 +106,6 @@
>   
>   #include "fib_lookup.h"
>   
> -#define RT_FL_TOS(oldflp4) \
> -	((oldflp4)->flowi4_tos & (IPTOS_RT_MASK | RTO_ONLINK))
> -
>   #define RT_GC_TIMEOUT (300*HZ)
>   
>   #define DEFAULT_MIN_PMTU (512 + 20 + 20)
> @@ -498,15 +495,6 @@ void __ip_select_ident(struct net *net, struct iphdr *iph, int segs)
>   }
>   EXPORT_SYMBOL(__ip_select_ident);
>   
> -static void ip_rt_fix_tos(struct flowi4 *fl4)
> -{
> -	__u8 tos = RT_FL_TOS(fl4);
> -
> -	fl4->flowi4_tos = tos & IPTOS_RT_MASK;
> -	if (tos & RTO_ONLINK)
> -		fl4->flowi4_scope = RT_SCOPE_LINK;
> -}
> -
>   static void __build_flow_key(const struct net *net, struct flowi4 *fl4,
>   			     const struct sock *sk, const struct iphdr *iph,
>   			     int oif, __u8 tos, u8 prot, u32 mark,
> @@ -2638,7 +2626,7 @@ struct rtable *ip_route_output_key_hash(struct net *net, struct flowi4 *fl4,
>   	struct rtable *rth;
>   
>   	fl4->flowi4_iif = LOOPBACK_IFINDEX;
> -	ip_rt_fix_tos(fl4);
> +	fl4->flowi4_tos &= IPTOS_RT_MASK;
>   
>   	rcu_read_lock();
>   	rth = ip_route_output_key_hash_rcu(net, fl4, &res, skb);

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

