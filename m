Return-Path: <netdev+bounces-86519-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33DA689F172
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 13:53:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A4761F254F3
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 11:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A95B615B12A;
	Wed, 10 Apr 2024 11:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LYOrA9lg"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201E415B10C
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 11:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712749867; cv=fail; b=MTF6tcwF4acXd1gbo99bWlm1ZwEFQHSU3sO1zJKWCKEYaaXynUHKRMV2q2MYRjVdvhQUNZR+ud+c7vZ29sXS/fKdom/a0WaODhaxdgcfvAvhPi26e+3iwCHvEooAdGpsy7ODz5mBob3yAM76iOgn+KinPvfvwYcnc4tANxvztOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712749867; c=relaxed/simple;
	bh=ie8lzwD1+rJGCzHSbcfw4TKGbZxN/obGf3NDYOCPpoQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=F0/XtGnjpgM3Ee3Js+72wLm0+EG5AX0S09PQbzr3yKQqCCXKvWkf37AJceJ+eUxRQ5v3m707VzusC2jti3LsH6QR/3QxrJxEeTOv+MBqap5wccvb1NzuJRrvY8+mAgL4krFzNYcZhGbRKEYS5A4ohzGsGLpRpZCx7udwdUWzK8g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LYOrA9lg; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712749866; x=1744285866;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ie8lzwD1+rJGCzHSbcfw4TKGbZxN/obGf3NDYOCPpoQ=;
  b=LYOrA9lgVRGeedv3wg1Kfdn/yOrbxFbU+SA6ciJfYwpU/xAR+uAgVS0j
   Qh2uE+PLmPCuARatVOOLeSGsnQzwVSlX1oFJF2Ux97QE8Js01+lSihN3B
   XopNSg0/GQgSgmEWcq/PEVXle+Cyz3RYPI3pN3BxRDajSkPx33M9R1mMT
   wERvQ+n0mLJ7LC5MXirFTsSpggUFH84tqSWYBKG+Gp08Z6AxvKzRMmCg8
   jObVi+RAHoOiqr0aBOTo8rPm0Dt4maIuTBPr9QrloHpiOiO8bFRn78Jdf
   NbTlpC+3hA0F2i7x/dSrVC1ItAKAEOYWH1S8n4ZSnhQFromr63cPqs77r
   w==;
X-CSE-ConnectionGUID: WTZ/pAADTampeHpxKpelZA==
X-CSE-MsgGUID: 26JxdT3zRc+mlwf1rS7LeA==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="18670911"
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="18670911"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 04:51:05 -0700
X-CSE-ConnectionGUID: xWvb2geBRxO7YFqDNK9JWA==
X-CSE-MsgGUID: oB98BAs+T5q9hCcDd9Cx0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,190,1708416000"; 
   d="scan'208";a="20598445"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Apr 2024 04:51:05 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 10 Apr 2024 04:51:04 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 10 Apr 2024 04:51:04 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 10 Apr 2024 04:51:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I884ZyTKHWuqAHCTIAClhGaV9RcIj2CI10PeWsV5HYIx801TdoikdRi7S1Jjrk65Hqj/zV4ZY+xyTf7zpOPWbIfp9wJ4q7map10QUCa8Y8I8zjqdCgStV4EtY+YkHVPXaH9+eHliyYZmTFBfoEksrmMhpduEoUtt6LO8J5I9taKIg1h7z+3/IWo0dii84cmu9TEebWrpZO4FQejK367BjcJM5kz8npufZCTJzQi/C2/kH4J2Px8YhOpes+Lhm4F2UTlL4VnoechKHDzU5h7CBVABPM1MvIJVKHjlXbDL38psBGsCzQHeWMKy05HPasgVOHLlcIi7CvR7txbHe2Zprg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iDVx6TvJNE/i7ajOBS4YLC2X1z/sEXD3CCTrAMdFgHo=;
 b=Gn2Get1lrhaKzp0KPd+DHUzeOrdhjYEDoX8ABoscV6Q7VqU14Pmlch9DukuWp+OmBOdfShPY2NUAtZ/L4VsYJHcPErQfUpgZvKWdklbizSA7RtDGMX5W+Hx92JDB6N/4g66gl4ErPDK6hw4n3oJy6gCJsdkXhwPLvMcA+R+5MP2ZMTeT0+Ht+AJ/61oilrozLx7hiqI/IbFqAA28JsDnX8xp7+nfn2v9kumvaN2rAvl+Mi7Zaorgwv52KQG0O2Fq/jD1ObhtLF/32PkQQCtW7biqGIijOBPXwBeKT6gN42sNWO6vmzryLh5WocWltdmHpzkHXTqzUArFMZbXU3QaFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by PH7PR11MB6053.namprd11.prod.outlook.com (2603:10b6:510:1d1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.25; Wed, 10 Apr
 2024 11:51:01 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::654c:d66a:ec8e:45e9]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::654c:d66a:ec8e:45e9%6]) with mapi id 15.20.7452.019; Wed, 10 Apr 2024
 11:51:01 +0000
Message-ID: <e6166f35-87d4-4873-a412-fcf62d22e482@intel.com>
Date: Wed, 10 Apr 2024 13:48:54 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: ethernet: Move eth_*_addr_base to global
 symbols
To: Jakub Kicinski <kuba@kernel.org>, Diogo Ivo <diogo.ivo@siemens.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <jan.kiszka@siemens.com>
References: <20240409160720.154470-2-diogo.ivo@siemens.com>
 <20240409145835.71c0ef8e@kernel.org>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20240409145835.71c0ef8e@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0024.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::15) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|PH7PR11MB6053:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o+ZluZyGQhBNTmGLp/bQf7i/VuCjmmu5FpUtQa7ELjvzufGgXvf7j1+3fETUr3T2cQCUC8VVzyqwVRObk8cQwjCPgWsy8AgP3iTw777zCy3CHcE7x+Nr40ojUQgx3Imz4zdVDXUK8jOFQU1+USaTvE8pvpD3G5Ia8A2ZOyKUGOT3yL20k+4BLtYy09YZP6FIgP6X7OT2fxURFGgtMBlECrtRtGole1pcPSdGEYBrVAaOOPvC4ePsljI+hEc0WaI4UjdErsKUyUUV0/18SVs1dxsFHR9aA2qHO/ddYPlsCgJidshyEcCGtar6I05JzgN5M0eKyXuoi8Q0JztcXMKMT9W/VzutAuiGPOvjffoKHP4kW/ZMxOhlU8PGNrsZgIDwjmhVLeV33b4H51hL5jPYIbMr8GSfoEO7ORI0SaTC9xPhcOI+t7wcfUJWmltVwAhf/gBwQKUrm/bsesLmS8ECSIIUFTBseq9Fd5/HJtoOQAOpXJjD/jy3WPwgxW4Rp6A59YUDO8lDSSnPiC3rhztCHo9U9YRibNSWT1+4MPlrUXMjPX+01uaiU0lmR/3bFqzkDiWH48nekULseCLZTitdCRVd8/qSUkAtOoLf0W7xn+U22Jkl9xHNMYAgGMZwumQ3qU5ylif4f2e46GQcWFyMJv0/JiDJEb5DL3H/jOp0HnQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFVHSEs4aTVKWkI5SUk2SDR4Y2cxMUx5bi8ycDdodlA3Nkh6aUVqcUd1YSsv?=
 =?utf-8?B?OEZNNVNlM1ZsRzZmZDB5V1JzbW5hYnQxM2RZMVFaT3p1VFdXQnhXeFNxUmJG?=
 =?utf-8?B?YU5nTS8zeEg0SnFoNDM4UDRSZnhPa2I2U2xkVXFtODF4cFFrVVRCMnlaQkFC?=
 =?utf-8?B?ejFVT0ZqQTFWd204QldFTXhGdDI3eWxCNGlCbTQ3NDFaYkpnbHM5WU0xQUNy?=
 =?utf-8?B?dURMUDg1bUZjQ09YUnY2cnFvMmpaQTlaYzdRZWU5NktYZjBubStBNFhqNkoy?=
 =?utf-8?B?S3dIWGNHV0hHL1VuTnpmOGQwMlRLcTRDYTlrTytrQUZmNkcyN2lyblRaUG5W?=
 =?utf-8?B?TFhtNi9PZFRVOCtrUnVaM0FiNEpkOTlnUTN1QTdGRDJpM0h6VEJrZk0zb1Vi?=
 =?utf-8?B?TnVtWVlyS2RRdnhpQWxQcjA3d0t3cit1ZVB1VUx2ei9SekF4TTNTdU15MjB3?=
 =?utf-8?B?M0FYZ2NyallJMVZ5MXFDOGJxd2E1QXJaNTBRc0ZYbWRLZ0MrRkpKbVVFLytW?=
 =?utf-8?B?cjNsZ1RYdmFzOUZ5UDJOYXRsbHJHRWJrRzJldmhPWE9zT2hrbi93SmJ5LzBv?=
 =?utf-8?B?cGZGQk9NekhtVUtwZk5GYzR0bXowbll5VlUxcExCdzhzWWdwWlhwZllRS0Vl?=
 =?utf-8?B?eHRaNkp2TWpMSDVmTUJRckxsN1N2QytaSGRpMHBCbnIzWEVpVUpBOWk3WmZu?=
 =?utf-8?B?UTVpWlF0SCt1d1N1dmZ1bFVibUxpdlErZE9vSjFRWmxwUlNUc29yZS9OV1da?=
 =?utf-8?B?Vy9GSEN6UWZOOExKbkROV1AxRnpaVEY1TzBzQ1QweXhFQit0ZDIvWGdaUDN6?=
 =?utf-8?B?ekw0ZnpTNEJPak5kTjlON1pETWFsbUxDWFZBRXR3SFRFb0VDUmFmalVDYUpD?=
 =?utf-8?B?Q3hXSGxxWFpBYXhPV2V6QWpxeExlUzFKRTJwczFDYTd5QSs1cUNiQ0pWSTV6?=
 =?utf-8?B?SFVIc0pVZUVXRmpHSVVYcnB2bkJkOUhma1pzSGFuZHhyOUZtRExvMWQ4SU01?=
 =?utf-8?B?Q1Ridm1wQkRKaFRNR1hQT3A2WjNHT21yNU92Zi9tMklSeEZiQ1RMV3cwbWs1?=
 =?utf-8?B?bTZ3R1JRUGd5Y1lqVmo2VlFYNzBWQit0eHl2ZFAwcjBIQnZJNkY1dkVPRWdm?=
 =?utf-8?B?dnpVZlBrUUxSNTNERU95WEdFWExzU25YWFhZZVZqL2JRWlBVNHVsSmo1eE1U?=
 =?utf-8?B?MHhlYjJWb0dTV3Z3d0ttamg4OHJwbm9tY1pWeTlKNTFoL3FVdEE0SnNsbXpI?=
 =?utf-8?B?SmlOODBxV1ljSEh2MlVqUXpaclhmdjhBcDNjSEdUUUtsdXFlaUs0UjUxSDJi?=
 =?utf-8?B?SmVkNG4reUFmdGRDR0VpV3lldkRDbkFGYWpOOVJib2dTN2ZNRW9KYzM3VS9j?=
 =?utf-8?B?aThadWFuV2pFeEpIUW5SeFVPRS9MNi9XbDA3andraDdGZEdTb3VhVlJnMVdN?=
 =?utf-8?B?TUJ0bzkxVGpCNnBPbUNyaFNJWVdUdWJIc0JoSTlqQitET0pqWlF1cU14clVp?=
 =?utf-8?B?S1hyK2JqMXNGNkQ1clZlZjQwUTA4MmUxaW5TWXk2dFJSTnBVOVlUZ1dMczZH?=
 =?utf-8?B?K3Q5VkR6QndQbEMwU0lrelZKd3ZsQ0l4SjFvQ2VkVGNoY05uU3llN0hBSWZH?=
 =?utf-8?B?VEhXa0dDMFRnT2VzY3g4MUFwSHZCQVFHcTUyR0h4bW5LM0IvUTc2eUYxcUxk?=
 =?utf-8?B?WXV2Ykt2M2lWYVdzakNjcS8wSnJ1ZzVyNGFwekN5Um5laUEveU9iVGg2aXdk?=
 =?utf-8?B?RmszQmJUbWYxbUhNdUtnT1ZBTTQ0S0owTWVMZ0I5MUxidHZGem5kOW5ra0NX?=
 =?utf-8?B?d2kweXQ2SzIwWnNPdkpQT1lqekhFdVh0akF1V2Q3d0VncWM1ZTBMaXprVlVi?=
 =?utf-8?B?aDFsSnl4dVFrYkRlTHpYZGpTR1gvVE4zQlhpUFdMYVVWMDl2VjhJelBYbXJv?=
 =?utf-8?B?YzdUWnV4V0Q4WmxzWlpPMUJkTmN2TUtSaFVvcG1IeHF4MVFJUG9Sd2Y5bVJU?=
 =?utf-8?B?L0pheW5EVVI4RUh6RDNNQUNyU1B6K2p1ZlY3Tkh5VWRuQXI1NWFudldLQWlD?=
 =?utf-8?B?NUR1Zmw0UDBma0VkOWlJVnpoenEwUTFGNWNpWndrNnE1bk5uZHZTVSttTWk0?=
 =?utf-8?B?ZGdFdmV1cFV0OFgxd01IcHRWclhBaXNtQldRM0hBdHd0azFWNHkxU3lrZDcr?=
 =?utf-8?B?elE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dd07c624-9785-4083-a11f-08dc59547e6d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 11:51:01.5476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OsYhpOheG9uvbWHN2xRFKdAgn48azrvGiKnywFD6eI7fSnxcU+2Sq43+DbZFSn2VGBfjV0/IT0m+6WY0OCHBTYiiGrbMX1KvIgW25WuNeW8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6053
X-OriginatorOrg: intel.com

From: Jakub Kicinski <kuba@kernel.org>
Date: Tue, 9 Apr 2024 14:58:35 -0700

> On Tue,  9 Apr 2024 17:07:18 +0100 Diogo Ivo wrote:
>> Promote IPv4/6 and Ethernet reserved base addresses to global symbols
>> to avoid local copies being created when these addresses are referenced.
> 
> Did someone bloat-o-meter this?

bloat-o-meter would be good, right.

> I agree it's odd but the values are tiny and I'd expect compiler 
> to eliminate the dead instances.

The compiler won't copy the arrays to each file which includes
ethernet.h obviously.

> I mean, the instances are literally smaller than a pointer we'll
> need to refer to them, if they can be inlined..

The compilers are sometimes even able to inline extern consts. So,
without bloat-o-meter, I wouldn't assume anything at all :)

Thanks,
Olek

