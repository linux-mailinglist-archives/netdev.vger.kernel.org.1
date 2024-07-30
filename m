Return-Path: <netdev+bounces-114081-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDA4A940E2D
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 11:45:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 901ED287537
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 09:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AADBC15FA68;
	Tue, 30 Jul 2024 09:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JvB/WL54"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E4118F2E7
	for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 09:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722332713; cv=fail; b=EWNKuFLDFvPOkrxeHM1rWVFYIv/reoERs+5g9hDr7x4I9OER/Y0XP0KL28/oXd7RXWtJI9LsVoGcxmuraLa8OFg3HqMU/Hb8Iew9ZREfnQVMP+Hh5a7XKPhsfBe3CtmgCt6XVT3bHFmPO4GrqhcCnkH+FqwK6cA1Z+N0WvjwKKo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722332713; c=relaxed/simple;
	bh=qzmXDjME9dnf/lqDPOJrq8uyGM3fWOU4bMUJODxlWz0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DJUq7VvFlJGdNGw31SdXnciuoqnjTaElX0t21I4w3lBU1Lv55nXwulQBYWIylYNO7gEc59husnp4ArN0TYQ3sVTEAhsDDKIljx3Kl07RF+orr3UTNWXWXmnpFYQf+KpX7L3ORvU9Z3Aai4dOYeuFO/RhlNcxH2rYbloYdQDZpGs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JvB/WL54; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722332712; x=1753868712;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qzmXDjME9dnf/lqDPOJrq8uyGM3fWOU4bMUJODxlWz0=;
  b=JvB/WL54BhTEKxFiHVSpzb/f6fWM2D7adEtblqy40j04xcemHFbZT87C
   OT6PDqgvNlPGzEpkdgOHagjXYPdX1W+effkwplB+Ys7HYh1OqbrYCmEGT
   uIiWIayRX+mHybq8GfaWB2VCzqaMjp4wVWmfSdOBzzmJzUYnf/71xGxsB
   fqfcYQM3JhLcAfjIxUD7DzMk6wP82NqmC3NfYDvuMZnFOhjARiNn/F7Jl
   hLCEvBvxcyj7VBdK+8SqFLiF+h/V6M45ZMPFvsOuysTWXcxWaC5bDLuKD
   XeXQvQNVfGNO7ETud61gEjwScU7ntkuLX5Vg59RzojF02s8iQeKNYAUA1
   w==;
X-CSE-ConnectionGUID: C1wGCN6wToaQ//pMI/dmpQ==
X-CSE-MsgGUID: SIlQtYWBStSNHKC+rwsecw==
X-IronPort-AV: E=McAfee;i="6700,10204,11148"; a="24002331"
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="24002331"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2024 02:45:11 -0700
X-CSE-ConnectionGUID: UGxt5YjfT3eQfBaIEtRaGg==
X-CSE-MsgGUID: Y4g4TA7WTqyBFekvWd5+vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,248,1716274800"; 
   d="scan'208";a="91784546"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Jul 2024 02:45:11 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 30 Jul 2024 02:45:10 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 30 Jul 2024 02:45:10 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 30 Jul 2024 02:45:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tmYUWalg0DUTl5rF+vxuiSUOewkjWeMqY4iwjnhkcjiRhdkpSeYG5/puOxJRuHiwKLs4AK62ySXN8kp5QGcrIOwDvVbfV01mpOG5DafCuMsKoskpSOih2oYpH9z5c7qync+9dBygz5VUUC4EZv4yb//8NyqwZo+HrQg5fbprokaYqeGsxC4uvfIWTEckdwfMsvN56SHs2L01+wXSKzpZaCrMAexGEX7/jTssKf5X4KZjA1DBsJ9+vRHtfBhX4QD/Nv4gM5IXRphDXbAKu8dhPO+AJQzdZLzuBeFOyNOs/oDny92Bh3kQjdk6U3G6akKT4rNM3EooMex5q6inPz/7BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DFZY6pZpoLHZFbypp3RyHBh+C7bz/8a2JAa/Ih6+wXw=;
 b=boMnH34suHa3uu2BlfMbUlkKACTVPLwdkb2hNuJTZoBAiJU+BjDThvajY/gFYmmvInzttWMFNv0o3MpSkY/86kqLayPqwdWimX8/JTKTF88NLYYFf7OOFYZ2r23pDWgWgiqAuWz41MlQylPHxfcGQqsYqSHlt1lPa1XI7sLhWGOymWWMxkw8xUQ4PaZgWxbk4zbt8ckOHSn7NwjkgxJqvS6P6zoswO8jAIc9FlSjcRnHxYOx9XSGurRkoFb1nraZENxLDGBXWamXQ2bo/h6VWcYDDWmog1Hfw2xgNJouficxj37Cd7lfdStex6Vk+y4KrwH0fb8mpL/riYOwUHE0qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by SA2PR11MB5019.namprd11.prod.outlook.com (2603:10b6:806:f8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Tue, 30 Jul
 2024 09:45:08 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::4bea:b8f6:b86f:6942]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::4bea:b8f6:b86f:6942%6]) with mapi id 15.20.7807.026; Tue, 30 Jul 2024
 09:45:08 +0000
Message-ID: <c8020dae-50ec-436b-b3df-a4ceab259806@intel.com>
Date: Tue, 30 Jul 2024 11:45:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 6/8] net/mlx5e: Require mlx5 tc classifier action
 support for IPsec prio capability
To: Tariq Toukan <tariqt@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Eric
 Dumazet" <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Rahul Rameshbabu
	<rrameshbabu@nvidia.com>
References: <20240730061638.1831002-1-tariqt@nvidia.com>
 <20240730061638.1831002-7-tariqt@nvidia.com>
Content-Language: en-US
From: Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <20240730061638.1831002-7-tariqt@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0082.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:22::15) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|SA2PR11MB5019:EE_
X-MS-Office365-Filtering-Correlation-Id: 24591290-deab-4b80-db39-08dcb07c4c26
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YWQ3MTNuT3UzdzZJVldhcDcvTDlTVTZEeTFPT2dTd1JkSmRGaGovSlhsMkZU?=
 =?utf-8?B?VGNtRVNrTVlOajBVczVLV2VYZGlEUDEzRjcwSkNGRWJoWWNBMEp0aWpLSXZm?=
 =?utf-8?B?enRGVHRUaTFOTG5QRFpiRTcvNVg2eGF1LzhEYXJ3ZnE0VER6V2Zob28xd3o1?=
 =?utf-8?B?emxwOEhwR09pZWtqQTk2VHRaTFFpTDlGUUxZd0I4Y05GdXhCYW1ISnhSYXRZ?=
 =?utf-8?B?bnJ3R2V3cy9HS1hqSVRSckR2a2xJZVZLd0p6eGVZZk1GbHJ2RTlBb2hmMTVz?=
 =?utf-8?B?UDgrV3dsb2t4Q3hCQTlJaWU5ZXRNNlZCNzllTXh0R1BEVEJhOGpna3FiQ2s0?=
 =?utf-8?B?YUw0U2x1TjVNRmUybldzbXduSFlvR21yd2RNR3MrY2hqUVlCTUJISVdhMmov?=
 =?utf-8?B?WmhqUlRncG93WXdBYUNjcG43VDhOemJ2OE9qaGxaMHNSdVFCay95c0gxTGJv?=
 =?utf-8?B?K2ZQdzFuMDJvem5PSjNpRmxFS3BudmtGSi9PWTZJbjRZem15VUlaRHJ4bFVY?=
 =?utf-8?B?Umw5cjV4bEM1YUpiNlJNSXRMdExUV1NLUUlrQjRWblJKSm5LUWdzN1pZL0Za?=
 =?utf-8?B?UUdoY3ZsTmlTVUFpdXhQL2FFWDBPdVJDWjlZRFp6cWV3aTU1dm9iKzB4L3pM?=
 =?utf-8?B?WitrWFI3SkVwV3dnS1d3L240bjQ5TXYvQS9saTNvRUVZSlladzFOWE9rSldK?=
 =?utf-8?B?MDVMWmhYbFRMOU52aTQrQ2hkbTNsc1hjY1RCek1pL3UxdHFzS0wrWis0SVFF?=
 =?utf-8?B?WFZ3WjFqeElWYnNkalJxWVJHUlpRclpYSE9LUkVHRWNOQW9iUEx1eXphalJF?=
 =?utf-8?B?d1lUa2JZNmhRek5IbGNFOEZROXVrN0k4QTc3LytaQ0JQSzg5SGNsaVZCcEZI?=
 =?utf-8?B?bnZkNldqQnB4SnBqcUxFY2kzRFhZWjhsWVUrSzQxVTFVaTNGWWdNOE9ZY3V6?=
 =?utf-8?B?NnNxajNGcVgzOUlBUFFWKzZ3RkI4Q1E0UUhZMTV6UEk2QlJhN0xpa01WeDV1?=
 =?utf-8?B?ekM4SkFRMTFMSmpoWG5lZWRQakk4dXBYUFZRZittMDlJbjFnZEdEWit3bWFF?=
 =?utf-8?B?WGVjNFVpcGdhNnBPQldYUUR6dzl1V1ZhL3EvZzFGVG9WeXFMUkdiaWVyWlVy?=
 =?utf-8?B?NEw4cnNHajgyazF2VnpzZGVtYWorRFZRVEhlSDNTMmVUVVdNRnNiL3d0MlMw?=
 =?utf-8?B?ZUJnZ3B4TEE2QWdjU1crWUxZd3YwZHlQaVZTUWhpdi9HeUZuVlk5Q2prZGxY?=
 =?utf-8?B?SUorS09nMm5QOFJDTFF3U1kvdjFjNFRpRXRkeFNYUmExalBlTXVQV2ZZQVBy?=
 =?utf-8?B?RnYwdVd5NWtPMVVMUEpSTEROMUxCQ0VrN29KaHg1VkRPTlczYlZaVkNscHRl?=
 =?utf-8?B?NkowNTlmVGxZbzhLeEFubjFqd2lqUytETTV2aUl4c2xZNkdRT2FOMGJER3ho?=
 =?utf-8?B?M2ZGN2hhR2owUysrMG1MT0FtcEhBR2JHTDU3SkxkZ1NNVWJMb0o4WnUvamFP?=
 =?utf-8?B?M0dWY1UwMytHbDJSTkFPcHJTWEhhMEQzU2VGUTRjcGdKUWI1VDI1ay92aUQr?=
 =?utf-8?B?R043ZFdWTy9yWEhsRDMxY01oelluTG1yNFk3TzN3TXljK1NOeTBKdC8rZE1C?=
 =?utf-8?B?V1k3N0ZCUVdHa2tscjRWUVRhVUVBeUxoVmxNSSt5VURRYk1Ed28xQ0Nod1oy?=
 =?utf-8?B?cmZ2ckRLWHJMbXRZV1JoZGZEUDkwOElDSUhEOFlHa3UyMWk5VWxTUE5RY0Zr?=
 =?utf-8?B?bzdRQWJnaUN3MUtmVUhkcWM0NHJpc0tadGVnQ3hYRTU5NVFzVE85UkxFTzFL?=
 =?utf-8?B?a3E3THJYSFFwenkxVFNTdz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVh0SGJoNEhLUW1pUlZmUUJmWkY1bGcrRDNmeTJHM3RNd05xSDRlb2NIb2c4?=
 =?utf-8?B?c2liSklpRzZXcjk3R3pNVTNxWkZKSFg3aGFDT2dleEhiam1oMkdRZW5YeWND?=
 =?utf-8?B?elg1bWJhS1NBaC9EVHNLV3JaYnFJU2pYeS85dkxoNStiMFlwWnVkcHp1U2Qr?=
 =?utf-8?B?a2JBYTArYlVvN1pNcUVXbmx6MGdNdmtYTWVWWmZmT2daaGZ2S0t3N0RpQWVI?=
 =?utf-8?B?eDk4VjlsQ3RUK004SkpKS1kwY1BTang4b0g3OFREVERkekt1SkwrZXFiSTdT?=
 =?utf-8?B?T1Z6aEJ5ZEJKdmRzNXFSR3ZHQ1FrQjZTRk5ab2JoREMvNVJZV2N4Q1Zqd0ZF?=
 =?utf-8?B?VEFnREh0YWFKYnpHZjNhOGNoUGRObG1TQkE5dW9IanBwc0hRQ1F5QWF2VHJK?=
 =?utf-8?B?eks5N285cnQvVUNmdnVIWmNwMCsvdWNmTlRuSUI2ZWVScURGTVdtTytIRTVF?=
 =?utf-8?B?eWVlR1BBWWU5VTZRQURHK1FYdmdoejNLeXcwVTRaVTY2TTBjK09hbkcyem1H?=
 =?utf-8?B?OHhWanMrT05tQjBVUU5WenFxbG9pUGoyNk1PSFd3aklyRGVPOFlPTm9keFdh?=
 =?utf-8?B?YzI0K1VOTzV6bWpmOVZpbnBnMnlOQnMwN0gxOTlYRSsycVMyazlmMm94Nk5n?=
 =?utf-8?B?bTc3YmUzYWpURzFNbWM5Z2FZRnFaQnJBUDBEZGZQcldqeGZCWVBTQ1ZRT3Jk?=
 =?utf-8?B?WE9RVnIwNVR3L2w3cWN1Ykt3a1Nwd0JIM0Q3eHNhcE40R1lZdE1wNkdsbWUw?=
 =?utf-8?B?dnVCNkhHUlA3WGpEM0xzay9EUVBDV3oreXlPZ29yQTcyRlIwcmVmWmR6SGEw?=
 =?utf-8?B?MXkxSGZUZmd5VCtBeXRZT29OT3UvbHNyOFpyYyszbmlhK1oyUmU3UU1EWlRz?=
 =?utf-8?B?S0VLT1lYQTRBY3RrMUNEWXhCcnRNd1NkWWNsK0wxMjEvcTlwbWVqZWNEaWtu?=
 =?utf-8?B?RlJQL0VMZVVmTEtXYUNzS3lVVWRMZVlOR3k2a28zUEMveHRwRStUcnFIUXBW?=
 =?utf-8?B?bUdEY1MyaHdEbGI2bkI5YUNDY0hQRGhVK2dLYTVMbG9Kd1NWTktnQ1I1eEcw?=
 =?utf-8?B?R2gwSmVKMWc4WWxEUTk0MEl1QVhFUEhJaWRMa0o1ajNTTkc4bnpLaUppOFRl?=
 =?utf-8?B?UHM3bGNWcGtBQzlrcG5BbE5rQTlxZ2lWNU0rN0t1QVFNUWF2YTdnUmI1NFlT?=
 =?utf-8?B?QmdaampydUZkNG05RG5BQjFUS3BIampNYjI4N0orNitNRzU4dUdUNDFRVUdk?=
 =?utf-8?B?bVZLeHZOYnJiU2JoVkZ3WEx0cnJFRUVjWm1OSHJXdkx0VEpJc3l6dlg2SnJv?=
 =?utf-8?B?MDg0eXZBR1RrZHI3dENYUEMweHlleGxXZEswUHlCYS9zRGZHV3A4aW9UdE1r?=
 =?utf-8?B?Tm9HZVR4U014TzZzUE1Nck9XS2RUMjlHakgxWFgxLzVIVVVaYmdVd1dldFhP?=
 =?utf-8?B?b2YxRGlqaWZ4dnBBRGJ1eFJhbkorc3dEZk9kVTc1VCtJVG85ZTRaaWNqNjZt?=
 =?utf-8?B?WHdpR1ByWHgvc1RsZU5uUER2cjl4OStEcnZJM1lwY0tqUDJkUWJMWUNZd0dT?=
 =?utf-8?B?aDNNWmtNN3FxZDlVcnNPTExhbmhrVTd2QUo4eXlsb0RNbkVTYk5YcTFkVEds?=
 =?utf-8?B?ZmI1amdiRFpFMzZiV3RsMEM2TDJrYUNBNDVONUQvWDNaOE0vaGo3aktpZjQw?=
 =?utf-8?B?ay96NE1yOE4xUTMvMFA4encvMWN6eEF5b0lIb2V2MWh0WWJKM2p6SnRXengy?=
 =?utf-8?B?TzNsSCtWWUtIckZpYVZBZlhPaWNTQ0dLcm94VzZ4OHZKQjArTGoxVjlQbCtu?=
 =?utf-8?B?ZE1id3ZRcXB4Q2dDcksvdlF3anpGQ2ZZUERGRlBtZ0tEOWRWY0hxU0pHdnE1?=
 =?utf-8?B?NkkzTHRLQU5pTllnZ2IvRlY0SnpjL2JubzlhQ3R0MTdSeCs1bjRjbkVJa2tK?=
 =?utf-8?B?aHh5RlU0byszbGFGU01pd1lxTDQ4QlFDdXdxZEdxR0loeEtnbHVMYWVqcEZo?=
 =?utf-8?B?RWRFYUdQNytUV3lIZkl5dDVQcFpkdFRSTXFjN1R2dlhRa1R1YUNpeENHQ1FP?=
 =?utf-8?B?Snd6akV3V210US9JSDJEcmJ0YWFDWXpnUnFiS290aUltZEw4VlRkVXFPVDBi?=
 =?utf-8?Q?PoOlBq4pViKauhylv+vPYz9Mt?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 24591290-deab-4b80-db39-08dcb07c4c26
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 09:45:08.2070
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sisXX0BJmHUTfGHKVuETQQyVrpsNzyjXeYDcqjnskMZHc6IA/8+6U3GzjdQsIWBQyxtYFhvugAR1My3L7ptFseM8rqOCe7VZxcq/ANMYpT0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5019
X-OriginatorOrg: intel.com



On 30.07.2024 08:16, Tariq Toukan wrote:
> From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
> 
> Require mlx5 classifier action support when creating IPSec chains in
> offload path. MLX5_IPSEC_CAP_PRIO should only be set if CONFIG_MLX5_CLS_ACT
> is enabled. If CONFIG_MLX5_CLS_ACT=n and MLX5_IPSEC_CAP_PRIO is set,
> configuring IPsec offload will fail due to the mlxx5 ipsec chain rules
> failing to be created due to lack of classifier action support.
> 
> Fixes: fa5aa2f89073 ("net/mlx5e: Use chains for IPsec policy priority offload")
> Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>

>  .../ethernet/mellanox/mlx5/core/en_accel/ipsec_offload.c   | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_offload.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_offload.c
> index 6e00afe4671b..797db853de36 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_offload.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_offload.c
> @@ -51,9 +51,10 @@ u32 mlx5_ipsec_device_caps(struct mlx5_core_dev *mdev)
>  		    MLX5_CAP_FLOWTABLE_NIC_RX(mdev, decap))
>  			caps |= MLX5_IPSEC_CAP_PACKET_OFFLOAD;
>  
> -		if ((MLX5_CAP_FLOWTABLE_NIC_TX(mdev, ignore_flow_level) &&
> -		     MLX5_CAP_FLOWTABLE_NIC_RX(mdev, ignore_flow_level)) ||
> -		    MLX5_CAP_ESW_FLOWTABLE_FDB(mdev, ignore_flow_level))
> +		if (IS_ENABLED(CONFIG_MLX5_CLS_ACT) &&
> +		    ((MLX5_CAP_FLOWTABLE_NIC_TX(mdev, ignore_flow_level) &&
> +		      MLX5_CAP_FLOWTABLE_NIC_RX(mdev, ignore_flow_level)) ||
> +		     MLX5_CAP_ESW_FLOWTABLE_FDB(mdev, ignore_flow_level)))
>  			caps |= MLX5_IPSEC_CAP_PRIO;
>  
>  		if (MLX5_CAP_FLOWTABLE_NIC_TX(mdev,

