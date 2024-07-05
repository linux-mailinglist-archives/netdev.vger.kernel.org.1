Return-Path: <netdev+bounces-109470-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 227CD92895F
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 15:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A31C22841AF
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 13:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4358614AD2B;
	Fri,  5 Jul 2024 13:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kfC8S3wt"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C28B14AD24
	for <netdev@vger.kernel.org>; Fri,  5 Jul 2024 13:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720185305; cv=fail; b=kHEFj1IYJYkV/vV/qqPY6XHWtzGFntb5kq7EBa4fc0cM0x6hrUaxW64e3+8oSUij2D7LdhyhlSEONS+HjWANuZJtZknOz1gWqq9FEM0syriEUnz7hXcu0YBWIem3/Ig9IMnriWkF/PGTrQHlcZ5O76JdWseuLdMAEt0xgTzjVhA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720185305; c=relaxed/simple;
	bh=JU7tD7JzVJg7mDjotqdqvxPjNsfF4qKWRF/3T5kz/R0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=j1mxLggZvegeWFEIXnQ2bUHROFOf4+Lo5dSD4FixPYuz7T67JqYTq8fkDl98xSVsVu5akiTmRma9s389QROwv3C7Mr1SjnLqZlOAtMXSCnbIhAlzLXBAuoDxqcocau36d25WX7Wq3OSq6yEJhUXu+6p7Uq8ZMPd7ot+vQIMdAgo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kfC8S3wt; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720185304; x=1751721304;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JU7tD7JzVJg7mDjotqdqvxPjNsfF4qKWRF/3T5kz/R0=;
  b=kfC8S3wtuk/PXC0JuuLFGzmKTDywfqCmGco6COyFjt4mphUYEguhfQZj
   CmjG/MN6IvN5CJ5OUD4qMeHBXM02Ycno4yONL7eJESvsMdnZzxo0zC19g
   nOm14TXdPCz8TSmGdiaY9qXd8JRFsRff2uekrDqVdKN0t+qoqIO4T6FSf
   UHPd5Om5wpYUN4fmwC1mv3/DRkukR/Lg8D4fCikcdyCx9tfgs0S5U0KwL
   BO7ptqwlhDJmJx7eU6tPcEGPcIlrWaR0YGDbAjf3WVEAs4XG5rHJtbLpq
   bAKIxKpaMtw8Cc4dvjhLmYRuaHbL0Xhlz1vD3T2U5UoOG/I2kt2MlkHJh
   w==;
X-CSE-ConnectionGUID: V6IYYh9yQnu+JpwCWakuaA==
X-CSE-MsgGUID: Hlg6Ex35TbmGThqFsel7RA==
X-IronPort-AV: E=McAfee;i="6700,10204,11123"; a="39990813"
X-IronPort-AV: E=Sophos;i="6.09,184,1716274800"; 
   d="scan'208";a="39990813"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2024 06:15:03 -0700
X-CSE-ConnectionGUID: twNUmYa6Q4OsHcM7cedvIw==
X-CSE-MsgGUID: 015ADoOESRKte9eHdOysqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,184,1716274800"; 
   d="scan'208";a="51827287"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Jul 2024 06:15:02 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 5 Jul 2024 06:15:02 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Fri, 5 Jul 2024 06:15:02 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 5 Jul 2024 06:15:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G1epTBypYTDp/OBaO2hzFcNgaMpjT0BEcMNgkwMydA+4UKod1LCKuAJDUdmnqXMVd+ZyoNoIyVjQu3HJcJl/PplQPmgkizsU6In5LgpaT0OVU+9qL9yfNxvzT1zYVRa3dgid6CISGiOB/bvsAewZxfwar5snWEeCgsuXuWtBta04WFEA3xdDJnwEL2ujMqdZ0F0vFcnNeoFaOVc8fPcDt6A/WAKUzs0u4QrFz/blRqs+zlBs3dwMw+csIgw1PUyGak0S4PTEe7ymVKqseoNDoEjWBcWYvZ+u6gLDxIP1LVvSPPzyg5wqbafEPRt+x6TFqZpRvGQ4yRJcHl1BkNM3MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w9K8sN0+gU/qEguIm3ncDVHj5ndYL+phgSI//ztUR3Q=;
 b=ZmLcAKc9EiUg6QewLixvcU8NqaJ0Kq8lkZVFo1oCBvsNKNzb+W7N5o7+B35j9IHlzYipuED24q0uU6VC0V3wlsMKgnmRCrFgMRPAm/nIGLXd9BSCwnvJYfJCurWqYKqKCHCS+VbdP2gRMK/qGChrvmROfvpkmScYkKua1GkW/WRgd4iDXm4oqJsA+u0Vqfe9iBHWpHcT+WI0QF2sghktinEkNXSqxXaDAjKcu6gU1UH8zre40ITclsWYzfIw3m2Dnl9tvvVXogElmEhBogDz142B0gla+iUrkVnEq8ffm7+byBzeCP43BRhhGqA6i7ynZLgUtIizfrnjLVx9sNGTQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by PH7PR11MB5863.namprd11.prod.outlook.com (2603:10b6:510:135::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.28; Fri, 5 Jul
 2024 13:14:59 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%7]) with mapi id 15.20.7741.017; Fri, 5 Jul 2024
 13:14:59 +0000
Message-ID: <ba861ef2-eb28-41c8-b866-f3accc7adf0c@intel.com>
Date: Fri, 5 Jul 2024 15:14:53 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: page_pool: fix warning code
To: Johannes Berg <johannes@sipsolutions.net>, Alexander Lobakin
	<aleksander.lobakin@intel.com>
CC: <netdev@vger.kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>, "Ilias
 Apalodimas" <ilias.apalodimas@linaro.org>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Yunsheng Lin
	<linyunsheng@huawei.com>
References: <20240705134221.2f4de205caa1.I28496dc0f2ced580282d1fb892048017c4491e21@changeid>
 <50291617-0872-4ba9-8ca5-329597a0eff5@intel.com>
 <ac90ee8aa46a8d6dd9710a981545c14bf881f918.camel@sipsolutions.net>
 <228b8f6a-55a8-4e8b-85de-baf7593cf2c9@intel.com>
 <b836eb8ca8abf2f64478da48d250405bb1d90ad5.camel@sipsolutions.net>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <b836eb8ca8abf2f64478da48d250405bb1d90ad5.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI1P293CA0003.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::19) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|PH7PR11MB5863:EE_
X-MS-Office365-Filtering-Correlation-Id: 04cfcf3d-e046-442a-802c-08dc9cf478dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MUpPVUZZSUlSRWdPVXNCZEcrNFprOUtMMzllUURRZ3UvKytCYmNBUDB5MzhC?=
 =?utf-8?B?RzFsYk41blhFRjVRNlg0dVZqTlFNTi8wUUpaWFdONkdYWWVJd2x2MmM4YmFY?=
 =?utf-8?B?VlVXbjdFMG1DQXRyaGNRQWQ5eUtNM25LeFFWVUN0N2JWbSsxQUZLOTUwYnRn?=
 =?utf-8?B?M2NKVDJrdFgwTEZvdGJKT05SMEQ5UGFHaGtjN1lSMDBia3JrM2p3eThvWjhH?=
 =?utf-8?B?Mkt2Rmdnbmc0Q3lsdmp1ZkFhbnV5SzFRbllJMzlRUHNhQlgxNXlGV1FZVFhZ?=
 =?utf-8?B?OS83U0JpOFNhbk42bnlqZmQxRHhWdkZjME45dXV1RlFZZmpkYkE4RVFKWTUy?=
 =?utf-8?B?b1YvQ0cxM1NQSlZOUStMckNpM0F1T25hVUZlS0JKNkRMTkRVNGRGMVVuUytM?=
 =?utf-8?B?TDJ0a01GelovUUZYS0tobFRtQzFMSkNwYlFOWUw4elZpZlY0TDRNUG85Vlpx?=
 =?utf-8?B?TlVzamQ2ZXdsR1crOHlMaTRKNFJ0amkrMk5jOWt5RC9RZEYvNThaREtUSGhr?=
 =?utf-8?B?bklMdVZMRjRuVmFjUnhtREVnS1lvUmlJRkJ4MTl2SStHTnEvTUhmTDhCL3c3?=
 =?utf-8?B?NERmVS83Q2RsdWd1Vjl3TkkvVXczQmhWaUU3OXFzdXZLbW92ZHJUT3haclUx?=
 =?utf-8?B?M083SmVmQ3pjdXllaEdPQVYzY3Z0d3ZrNDdnaDBWbFVmRTZxbG5iZDJqQlNY?=
 =?utf-8?B?L1ZVQkMvMnU5MEQ1bDFuUVhZZy9hQ1FKS0xqYlp5WmE1eXlGYVZrNGxFRnY3?=
 =?utf-8?B?Q3lqV3RGbjZFTytwcExUVkdra0VDa04xR2lTclozU3paVkJ1SzA5QTdUZCtY?=
 =?utf-8?B?cGowWDBFbGM5QTllRXZLRzAxNWRyeTVYcmIyTURIT2tENTM1ejVyR2R5YUw0?=
 =?utf-8?B?Q1YrVXN5NFFIYWQvRHRlUmZaMStDVVpaQ1hRdkE3RHpGcURtekU2OWZ3RmZv?=
 =?utf-8?B?QmF2S2cvTXVZK0UvU3BCL1VaWXlWaXJRM1JadXVoaVFjWE42Z25rcWJ3RWtm?=
 =?utf-8?B?MnQxUnpEYmhiSG94RStyaTB4c0hRZ3V5ZDBJRlZNaHk3eVN3bGpXVEpOYmU3?=
 =?utf-8?B?WlVzQ3JLTU4vRlViNy93WUovdkpid3h4YUFsUEYwV0hoTTV6WWNaZlBHbnhL?=
 =?utf-8?B?blRUUFlBM0ZqOGRkeWJlc0JOS0V3eVNuMUN4ZUFTV2xuV3FZak8yRmRyRVlY?=
 =?utf-8?B?MFBRaUZQaklESFFUZ2V6N29NUFFyaHFNbmc2cE5Hb2EwVm9NTGtQSE5SL09C?=
 =?utf-8?B?aWFJd0Q5T2VmS1lLcTVRbkQ1WCtlSGlZQnJzbWNmelBiSjlkRkwrS1pSUlBt?=
 =?utf-8?B?VmQ4SCtMcFRWU0RaYW44L0FuSWdrK3VodFQ1dFJQY3V3Wk1OWVdPVXc5WkRz?=
 =?utf-8?B?bHduVzlFZHJKcW9ZVGxHaEpDbk5lSktmUUFKUW5NYXZHZGljbStpY2NYQ3Ji?=
 =?utf-8?B?bVNPRHFCelpGRjMwSXhOQlQvdGpUNmxDRXU1UysyQWNFRm5EdXpTWWMyL2Rp?=
 =?utf-8?B?ZVFGS0xxa1hsVkNVK1ZBako4bkxjWXFiV1R4N04wNGdKWWt4THRQRGhDTFpx?=
 =?utf-8?B?UGptVjIzSUFWZlZFeDVwMTNObjBNTkhlMDRLQ2VYckJEb1BGT045TnVaLy9K?=
 =?utf-8?B?bERoNmFCTk1hSExkQ1hrbnZUbHk4a0RsTzZmZzhNN24rL2kwT050WHQ2aXNm?=
 =?utf-8?B?L0NIUWRZeHNQUHJPeXhMaE53K0NrNS9JTEtSUXlGNERSMHM3ZWZXZ011eWVu?=
 =?utf-8?Q?Tv9BI8BppEv7p1Lbbs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z1loamxYaHd3bjRDQjNWWUl6SGlScmVYd25CY1g0UlFpSjh3Ykl1dWJTaFlk?=
 =?utf-8?B?cndZUkxjTmx0UUg5WXpNT05XSU5KRjc1YkVjSmsrWkRmdXRUaDJIQTZiYmVn?=
 =?utf-8?B?dThBU1gxNXFHOHBFZU9QWURsbVpWODRaR2oxaTNxaGpiWFlEd3p1NFIwQ2FF?=
 =?utf-8?B?SzhESXlFR0FkWEw1Yk8yZE5VV1htWU1PYk5KU1czb3N5VWhJVFN0ZTl6TWk5?=
 =?utf-8?B?QW14eFdKOUV1Q285eG9hZVJJblpzNi9EVXpMbEhDOG1lNkFpRXBFa0xWS0d0?=
 =?utf-8?B?MWE5MWZSWmFYSW5DQk0vWEhUTWQxdW90OXkwWW1qNEJHN0RzbVZPcDJyWlE3?=
 =?utf-8?B?U1gwOHdDWWcwTDZZL1R3SmIzN1BES0VZTWZhL0RuQnRWSW90Y3llNjdlYUty?=
 =?utf-8?B?ZFVTejB3enJmZ29oWmdOSVJWbWEzajJRVkhkdFZjWjlZVWpQY0FqV1FvZlh0?=
 =?utf-8?B?ZHV2bDdvaURtVzRxMXdVVmIvakJuMjA2clBRbWpyR1VETkYrQjJPVTNkSVVt?=
 =?utf-8?B?NDFLVjNQVXFOK0dGS09iSktRdWlrMkJPL1NadmhDSDJ6ek9rYzE1bmt6VHAz?=
 =?utf-8?B?QUE2dDdWQkRYTmp4SWU5Ym5IaSs1N3BBMVY2bUJEbjFRTlhKbUtIUytTVXNs?=
 =?utf-8?B?UUd0dnlkZno1dkF5eWZ3TmZaVmtpQVhSeGYxTUFGTHFHTUtveHA1bHhoV3Vp?=
 =?utf-8?B?d0JOU1gwY2lNb0ljVDBJYmFrN3BGK3RYTGVoS3hLTXFDdU1LVzJORmIzOFNa?=
 =?utf-8?B?azllaEFQaXNlL2tVUnZwL1U0TjZ2cUEydE5MKzdyWGZuMDl4RXVnT3Q2Rmdq?=
 =?utf-8?B?TzlsUFpidzFqMnQ4UERFVHpEdVJyMEhSYjFtVEczc1hQazlQWTZ1WGpzbEJG?=
 =?utf-8?B?RXRSdm5LS3hVMks3WGp4SmtENFpNM1JuUjFiK09kSVM0SEdFaGdPTzhqM2Jl?=
 =?utf-8?B?QkxXL1VwSmJCZjF6YkRlSE9aUkZCZ0Y2TWlsdWRtdDl2M1kyck82bFB2bDN4?=
 =?utf-8?B?SjdtSGx2KzR6NkV5dlF6Uy85SU95OXhxbmdmSi9Wa2JYcFhWRkhSdlhoK0tH?=
 =?utf-8?B?K0NRVnNZSjBzdUNYUWx6Rkh1eEJMaENoOGlqWVp5MHZSMXZQeU1NaldqUXIr?=
 =?utf-8?B?V2RDdENPV0h2cHJ3dElZQVJMNWNpU2xYVnNPdTlUY3hZaVNvbzU1L0NXMWQy?=
 =?utf-8?B?L1NsbkdpcmVCbktJV3cvSHZabThERkxDdC9Wb3VUYkpzVTc2ODhMMXNOZ2pS?=
 =?utf-8?B?T0Q5UGdsUDRlRFEyWXNFSFZqKzdIbFpmYU55MytiWW5xTzFxWFpiMjlPbWNs?=
 =?utf-8?B?bWZJVzB1V3ZWSDduWG9IdFVySXFwRHhFbXFrVllRYjNTU2l6d3FDTzhVVFlX?=
 =?utf-8?B?WXdjWFBlVDRYUWFuVU9xc2RDR0ZsR002bUdDc2krREZXWktKSWlvdHRJbTE2?=
 =?utf-8?B?cnBUb2FMV1RTdUNWUVZBWFIzY3FMNXFEM0FWZFUvWTcySHBaV1RQcWRCZVpP?=
 =?utf-8?B?UXZNZGhsZVZvR3hhTStzVWh0UUc5QjVLbTJSVXBIVlRLWFJaa215cm92RzJF?=
 =?utf-8?B?RmZMenRyZHlmN2VBM085cDVtTjZYc2hEWmV6RHdlZ1p4MzA2WTVwcFRDQXJO?=
 =?utf-8?B?K3huTUVGZmJzZ3VXeUFyQVZ2SkRueXFISkREN2hUMEJEQ3VuVEVxZEx0K0x6?=
 =?utf-8?B?UVRSQnFRYjlwZjFBb2tkT0FManBTa01HMk92R3pyZTcyMnhwSGJFZTdhUW0r?=
 =?utf-8?B?RkJmYWZ3T0dxbkJHT1grM05SdWMzQ1BSODRQc3JQeVBoUlJVSFM1dmFJUTNt?=
 =?utf-8?B?emtIMi9KNGFOYW1qV2NCZVZrVU9rNEt0VEc2THE1ZzlpZjJINGNoQzhGcFQ3?=
 =?utf-8?B?eVNaclBORUV3S0NtRGx4elQwNzZ6dkQ2MTNtdEFzQS9WVGQza2ZKRW9LYzRK?=
 =?utf-8?B?WHFyQ1lRQW9xQmFTRTMzaTg3VnRQUGh2K2FVQTNPa3ZBaFVsR2JBTytSTnY5?=
 =?utf-8?B?T2x3dHpjNmNocnNCNXYzZDNtVXU1emU3U2pydjlpSjgwNldDUXFLZnQ2R1ZY?=
 =?utf-8?B?MDlkNDkxN2tLVEJFNDlCRHlUMzYrUUZDTXJwNkxzd2wxNEpzeDg5K245VGFa?=
 =?utf-8?B?TzhzeHBSQXZGSWdOcDhOdHhnMUhld3VvRTQ4b21vaWVBS0ZaY1NtMkpzeFBQ?=
 =?utf-8?B?MHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 04cfcf3d-e046-442a-802c-08dc9cf478dc
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 13:14:59.4168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xNqKnmKMK6PuRIZE9mkwyRN1JMJC+wMEOmcGil9kKAk/yq3SNbCr3WV0ccv+//4xrFgPqRa8qZE/bXxOI2Ux0AZqgzqWT/dxQ1AvR33VNwA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5863
X-OriginatorOrg: intel.com

On 7/5/24 14:39, Johannes Berg wrote:
> On Fri, 2024-07-05 at 14:37 +0200, Alexander Lobakin wrote:
>> From: Johannes Berg <johannes@sipsolutions.net>
>> Date: Fri, 05 Jul 2024 14:33:31 +0200
>>
>>> On Fri, 2024-07-05 at 14:32 +0200, Alexander Lobakin wrote:
>>>> From: Johannes Berg <johannes@sipsolutions.net>
>>>> Date: Fri,  5 Jul 2024 13:42:06 +0200
>>>>
>>>>> From: Johannes Berg <johannes.berg@intel.com>
>>>>>
>>>>> WARN_ON_ONCE("string") doesn't really do what appears to
>>>>> be intended, so fix that.
>>>>>
>>>>> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
>>>>
>>>> "Fixes:" tag?
>>>
>>> There keep being discussions around this so I have no idea what's the
>>> guideline-du-jour ... It changes the code but it's not really an issue?
>>
>> Hmm, it's an incorrect usage of WARN_ON() (a string is passed instead of
>> a warning condition),
> 
> Well, yes, but the intent was clearly to unconditionally trigger a
> warning with a message, and the only thing getting lost is the message;
> if you look up the warning in the code you still see it. But anyway, I
> don't care.
> 

for the record, [1] tells: to the -next

[1] 
https://lore.kernel.org/netdev/20240704072155.2ea340a9@kernel.org/T/#m919e75afc977fd250ec8c4fa37a2fb1e5baadd3f

> The tag would be
> 
> Fixes: 90de47f020db ("page_pool: fragment API support for 32-bit arch with 64-bit DMA")
> 
> if anyone wants it :)
> 
> johannes
> 



