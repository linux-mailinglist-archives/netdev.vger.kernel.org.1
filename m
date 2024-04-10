Return-Path: <netdev+bounces-86768-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39A348A0375
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 00:35:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 741F91C219F3
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 22:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8DC8138E;
	Wed, 10 Apr 2024 22:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CTVgwtEu"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A83B1FA5
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 22:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712788519; cv=fail; b=CdMbQSPYQhssHNcl2zs4+YfJavjh0/tADAwgLJ/ZPGHjVlIAmyvJjri2vaIVTClPfFjYm+QJGmmXh80EMazgh0b06NZs3t7FfFugjq5WcfrV1fOE0dAzHFBFQjmtbIyjmHYWgD0XzfAJ9n1S8g+wBgsGD+qK1yFwgbPw7YHckj0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712788519; c=relaxed/simple;
	bh=z9dTwe3GpvuIydRTb+du6rD4TK3qCxPVUBxYETjJuk4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PSrh/rfrVuRmgxj3qRUvm9BGP+s94R39S2DHRBk6j2gbAHbOvbt9/z01znwyVt/+iYU8GoJVMPEZfcTVarQEYjGXQkLDnpRsFuIguplow0W1MVuqpfD/a0wb82NweCoQzm5WusPFPGKYeWkQkWf34ISOFr4wcuRpIrhTJbFBgpg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CTVgwtEu; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712788518; x=1744324518;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=z9dTwe3GpvuIydRTb+du6rD4TK3qCxPVUBxYETjJuk4=;
  b=CTVgwtEuVzd0Oxyng0Qp7jT2DEaYoor9fxDYMzuNc5zAxjCooA9VcGQA
   pkMK5JHMW5vCo+3/Wt810JJsb+CZA/IYTLLONUVXbELuXC1G5b6M8601R
   BM/dKXbBhrI8gfJj3Y7GkPoNSSqrfKaStLJrzUwB5IeLXYZC61iL3tBlV
   mCVzCm35FIZ9nmYERDgywt/unzAnpQEVjWKSJwhpRP+b0VtuFEJLNsLvs
   W3Rra1X0bGo4fmA0TDPZxsUexgAdpEakutFosOWWRkm3SJbozjJXU/w8f
   yDyussdqWQ6F1O3eHb7647Fv/0kRR4jNiYMsrssHQujU9o9louFYOmaiT
   w==;
X-CSE-ConnectionGUID: R9Dip+WuSmG2RUjIvzbD7A==
X-CSE-MsgGUID: TaU6ZhuCSWSTu6EZ1iZSkg==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="30664276"
X-IronPort-AV: E=Sophos;i="6.07,191,1708416000"; 
   d="scan'208";a="30664276"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 15:35:17 -0700
X-CSE-ConnectionGUID: N/HF4O5YQ5m+BCv/Lqp0iQ==
X-CSE-MsgGUID: zc7c6sNTQTmsXrs5pvAiiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,191,1708416000"; 
   d="scan'208";a="21133163"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Apr 2024 15:35:18 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 10 Apr 2024 15:35:16 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 10 Apr 2024 15:35:16 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 10 Apr 2024 15:35:16 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 10 Apr 2024 15:35:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eMDZvJCxnwHca6DhlEJOBhEwJG1Uvh7o5j3czeIFumBQGv65YsuQr0k7eNlOwCHDMBvYNdZ4sTCGJqm6UbkPFYUuf/LeG5gMmqzkWYzVMRUlIOyBvXCI/lHryDMXOqRkoL3TeB/6wHolb8EWLPsVTelpsugNiHkCgZL00f+JbtElJ2FIGpD97NCLVyC+XMoqiPMztMchB3KKRxN58senLUpuIBJvVLi5ixhdlrdNH435Bs89bu+PNwMkndQv6IbLvspxpeeWrlwOGlm46XOiHpEIE5ZFX8PSgCBVf4LhaItntfxvtZHFYJRWM8xRRZ05zj2B9BzrDU/LGwes80GN6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=67V9x44HoWva+Z3c85j+dlWAJGrwW7apHVAbb5TESTA=;
 b=jfzmOavh8J51Qu7XlJuUpfSo9QfK7VVV/Z+e92XxiJZjAEUgU0/boRUtuhBpYXxCl9OXzYoiWokLAbtRu+MorVlgCxuEhFEFymxWgEENFFu0umBy1SkwDbN+J4+EWUFN8XznxWXzW44uXOjd18U2ja1jFk08Zt0KiOBA+Ccvd5/ziDpf4PAHyluXlW8HIvj0RfbdPRgQICdDsER7M8SslGM6EKavzrsOPLYHlYYRRNQkH+z6Z3AgSIWYfK/mQ2LU3/cEyDG3+v2nLkxjdj0xBdIFH2ycUqeiNKpzpbTq7nSF0OrjrjtNOk69q37vjfescrLSuMHllrZd1Pr4EguFiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by BL1PR11MB5977.namprd11.prod.outlook.com (2603:10b6:208:384::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Wed, 10 Apr
 2024 22:35:13 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::b383:e86d:874:245a]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::b383:e86d:874:245a%5]) with mapi id 15.20.7452.019; Wed, 10 Apr 2024
 22:35:13 +0000
Message-ID: <0c828590-098b-4816-8b0b-22b1de91a2d7@intel.com>
Date: Wed, 10 Apr 2024 15:35:11 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V3] net/mlx5e: Expose the VF/SF RX drop counter
 on the representor
To: Tariq Toukan <tariqt@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Eric
 Dumazet" <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Carolina Jubran
	<cjubran@nvidia.com>, Aya Levin <ayal@nvidia.com>, Rahul Rameshbabu
	<rrameshbabu@nvidia.com>
References: <20240410214154.250583-1-tariqt@nvidia.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240410214154.250583-1-tariqt@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0278.namprd04.prod.outlook.com
 (2603:10b6:303:89::13) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|BL1PR11MB5977:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mygw0i4ay49wZsu2/R4MH9Nqw3nhyS7Nc4pAzCkmPhE1vOhg27XXqv2XwaRPLo653A0RpAeX9J++AvhmXVK+scLr5ShxShuP6uHcqkpqyFetdGCzJagFQr4YFP7qWbvQ6vk00iAB/klwGhmvcQf04iAMUypJAZb/QM3T2c8vUreUGEG67asJOZAcQrSxIhZbA0YwRSnYkIk5HyA9bIWFBMgV+sLzoopBJ10xCrby48JKTlL/xGKxK3ulvaMs049gq38Ey4wrYeKbQCD+HVNo9ar+XAYi9JryN2b5x/DMlPogxeIuosRA2clVBiyvnTbmug+th/gU3V84z7QqLqXHrqTADL8vpep1Q0OWXHxV4Ujll2uHUKoL+65TyI0FNNHAUygM/1/vVi3UjWEYKI7HEbKwhzPZOAzIZ28cWRq1XpCzOaoVYAeh6Yw8lQLXpMXBxpt4mc19KRToyUfqSAzLMQnZkYJjvz8xx/HT1cGckbFmOHpJjNsbIGQDnPEv79Qe7lB6S2P3//koEOMsaSVNs6zogOopFUSUQxbBofTfnQOTwXpp5UZ6FqeCJ75BuCxCwh+puouM8sSjjD+gfAK9+KodgNwvte5ASw9RsbE6wBT4cOjDimUmhy7Ob9oAPekna6PvRQWJNR9uEl218B0c7Ql47rxT5Lhe+r1LjhNkj8c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cFBJeE1BeXpwRmU3Y21IWDlYL1NMVjRVT0RSRlNSTU1IZWJNMmVzS0ZNLzdq?=
 =?utf-8?B?U1Jxa0svQjFOTTRJMnIxZk4yVjZaamw0cXVQMENjWVlaOVVlblFnam5EdUtx?=
 =?utf-8?B?anZ3OWhYSTJDQUZhTGJxK1ZnVGVpZTJwNU5VeUloZFhMbUpzRis3VmFlb3Fr?=
 =?utf-8?B?K0oxa2MwUUhoR25tNS9ZbHFTWTI1WlJCcE5veUs3SVRzbkVJdVN3SUwwY2k5?=
 =?utf-8?B?dTgrQ0ZtbzVDR3RNcUtIQncwVDQ5QmltRXNoZG1nNy80c0lkZE9TU2ZlMHlH?=
 =?utf-8?B?L0laa3lRTEk1UG5kS1ZtaC9MazBVVHJ2VWpCRzVYUzR5elF4NUhNRVZZT1dQ?=
 =?utf-8?B?WkhpQmZRS1hYSDd1d3dmZFVpV285bHlwOUF4RVlkYlJEdFFISm13d3hjc3hj?=
 =?utf-8?B?UjQ1a2VwRTJGWWlQK09BaHN5ank1dFRERmFUSWNkRjhPclZzWlR4UTFzaEkw?=
 =?utf-8?B?K3ZzMDBNc2loMWkxTytaSDY0bFc4SzRGUmc4TVZiOWxqdVY5KzhIUGtxS3px?=
 =?utf-8?B?ZXQraEtHR2MyajI0Q0owUWNXak02czdmK09Kbytma1N4Q0RBWVlZdHlNKzk4?=
 =?utf-8?B?ZXM5WTJqSDg1eVJLczBsT2VUVUVIYTVaNDJGVkNId3lvMGhseFM0ZlFjWDdx?=
 =?utf-8?B?THlORmJnNU4weVpJQWw4N3h4YXkrSm1vbFF0cS9lZkpHanZSalZtcDhKQWE3?=
 =?utf-8?B?cDdQcEt6Qmx4YlJiRjY0d0hhS2hJV01LakhKN0JSRVY1VnRVMkZLQkVxVGl0?=
 =?utf-8?B?Sk01ZXJPZkZvS1MyZzZjRDcwTWM0ZHNMYW1WOUREOHU4OHlYMlJOMmdNN1B5?=
 =?utf-8?B?NXZyWnZ5ZDQ4dWIydlE4SlJibEJYZzF5dzd2RWJETFIxb3lUWHRQL3Y1V25S?=
 =?utf-8?B?SFVrSmhXaVJrRThHeitFRmUwd2RMY0oxdGdKT3I4T0RiQzBMd1drczlzQnFK?=
 =?utf-8?B?Z2xHYnJxZUUxaTlEdk9XeE45WnZ6YUZ3S1JVSUliajlUMUpMOEcram4xK1Bv?=
 =?utf-8?B?WDRtY3lpalZSZGxIUlY2RHI3b1JzNktmR0gvZ3Vtc0E5ZWNtaEwzajVqZjFi?=
 =?utf-8?B?VFh0SmYwb3o2QXFDeGhXUmJKODJNQW13YUN1aW5FeWFqR29iem1peUpsNmNa?=
 =?utf-8?B?MDQwTGlGV2sxZU55R21ZU2dXQ0dLcEM4dTNSamdmNzdlMjZCTGJvLzNveGRj?=
 =?utf-8?B?R0RqRUdqZ2FNajQ1bnA1R1N3QTFjVDFRL1VXbHRSRk1qMklPb3M0TEpiRnhs?=
 =?utf-8?B?dmhYRVVMRW80aGFwSTNZOHlwMlVHMWU2R2JnVVRHVEJCSGpiTnAzYWRtbTIw?=
 =?utf-8?B?eHBTSjhYWXFnTEFtSFI1Z1VuQTNzL3dSYVM5SHp6NlFpQnJ5SmoyaEdRdk9y?=
 =?utf-8?B?dnUvdk5YZ2V6bTJXZjE4bE5rL1l6N2ZHSDVzcXN0blZ3c0Z6SGE2QUUrNERn?=
 =?utf-8?B?SzdXN3VuQ092WXVGbTFnQXJNa05RSE5CQnpBdUdFMkU4TUt5c0RMOHpRcm5z?=
 =?utf-8?B?NVgxbFRnajdiS0h4dHlFQlFlUC9NU2Ryd1dERVlhUkx6dFNmcC9yeFl2NXJ4?=
 =?utf-8?B?Mjc1dE5WZW9CRzlMWEMweS9WU0NVcVlUcmxmZ3h1THlkcnAwRDJDU1FLS3VP?=
 =?utf-8?B?UzgzSmZZTmZKL2V2QkE5RzNqdC80MGJCZnErMXlnUzRXNWgxVGlDWmRUVHY4?=
 =?utf-8?B?ZnZ2bkZoRnpnZGlpQ1I4Tnljc2VyNHNxRTJLbjd4YXZ0RzJSV1RjT1Z4Uyt0?=
 =?utf-8?B?WFJ5OFdSaGY5d1NNZ3EzUDBvdWhwM242MFVJeXZ2bngySHZsN21JemFuUlMv?=
 =?utf-8?B?N2h0bXpXYnc2VG56T2tNV1M5OWhmQm5KSkQ2L2RaUUlDNXpFZk1CeU1HTC92?=
 =?utf-8?B?VHZDY0lxOGNib2Rpb3RGM1NCdTBUbVBxNHJ5UzR2YnVqMTdaUWduL2xSWkVY?=
 =?utf-8?B?RXJFV1Q2QXJQUnR2V1JxUDU2TkU2WlBDd2JmUFB6U01janZXdzdsM3ZRRlAx?=
 =?utf-8?B?bC9rYWlYbHdQRFQ2eFNkRFBackRuTXRUb0RYdENzcVBDU2xORExYR3BzWkVY?=
 =?utf-8?B?VDFZbERnTFVVa01PQjVNd2k1c3VZSFl5aWpqSnF1dGRHU0p4S0hKSlVwd2o0?=
 =?utf-8?B?WWt2bVJhdXdBZkxCZG9HT2xZbmR2UVhMaGcvZUY4ZllZa09HZ3grd3ozU1ha?=
 =?utf-8?B?aWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dd6340e2-c33c-4cd9-8723-08dc59ae7cd8
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 22:35:13.4256
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OO0ZfHOE1bBF74yAorSYHl2cFWO3WxCWdVxm0Iypl7KJBz7KsBUa8xNfwPduHCA5yOtyHxLX/VyIlUuDfqmFoe1e/TRKHAoytQfk9Ohs1sc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5977
X-OriginatorOrg: intel.com



On 4/10/2024 2:41 PM, Tariq Toukan wrote:
> From: Carolina Jubran <cjubran@nvidia.com>
> 
> Q counters are device-level counters that track specific
> events, among which are out_of_buffer events. These events
> occur when packets are dropped due to a lack of receive
> buffer in the RX queue.
> 
> Expose the total number of out_of_buffer events on the
> VFs/SFs to their respective representor, using the
> "ip stats group link" under the name of "rx_missed".
> 
> The "rx_missed" equals the sum of all
> Q counters out_of_buffer values allocated on the VFs/SFs.
> 
> Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
> Reviewed-by: Gal Pressman <gal@nvidia.com>
> Reviewed-by: Aya Levin <ayal@nvidia.com>
> Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>


Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

