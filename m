Return-Path: <netdev+bounces-127927-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E020977117
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 21:09:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF576B247BB
	for <lists+netdev@lfdr.de>; Thu, 12 Sep 2024 19:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C187D1C1736;
	Thu, 12 Sep 2024 19:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lkY0+64p"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AFD1C1738
	for <netdev@vger.kernel.org>; Thu, 12 Sep 2024 19:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726168118; cv=fail; b=COvJyVgr+uFnZAj/FNR8bYvyOms3D4Q/N+fvjTj0CKUun37C5hufFzKpmQ3NRmXIb93jhfMFQEPEwXgCHyHoTCmuPhQtkfXtH27RbKuPplQvmx17JiX8z689UjuZj5t3DXCNxNvTN2mp5tRf++WYYbjgXr9CDBM8PoDMIT0BU10=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726168118; c=relaxed/simple;
	bh=krc1FArCk79TVPIMe1fgliLv3Eytdf9IrmD7FIc+RW8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Lm89t3ytS0eIK8C+cMquLunAew7DkZfdgAusI6E0KdM5XA12hiU6tbqR14IiVaC47V0ERmLIZBLMYPcCvKvkXS59lsQzJdiGpRjdVNMxwFOrX74ug9fifbRPqYu9Hhw3QjAU82FWvNEr05EgIs+Ro6Gulwe6Eq7zrx6JjuZQDvw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lkY0+64p; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726168117; x=1757704117;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=krc1FArCk79TVPIMe1fgliLv3Eytdf9IrmD7FIc+RW8=;
  b=lkY0+64prtXoi0gutORgxknRoGpPo1Dkr6p9rGtNkmqekjLFJnF4mxV/
   xieHRFuBfjlGBY21MBVwNgjvWbQlQbM5kQNZVoVaxRXDZ2Q4fyCbmNZaO
   pADc/NaGQJnCLsRSWRr1B40WPZksA5qZtGsZDqjTh2F4L64jzVxs6SVqK
   BAgAri2aO5SDnLrA4ATNbSBPolWe6FLTJZk/kKQO23jbmkY/JZtWw/BBU
   75i8q2e0/Ad7W1g0H71VE/jbnT67pFB1AX28a6R8vtC8FLNtLWE96jD2Y
   Vp3Uc++sw9FDV5tSsHHOah5hYxMkFH21RDgVWSOYQRVvK0rPLuXz2E4qH
   Q==;
X-CSE-ConnectionGUID: MMHoRal/Ttm7Lsdd2mE2+w==
X-CSE-MsgGUID: J2BTA1mvQcmylQzwfbtklw==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="25204569"
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="25204569"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 12:08:36 -0700
X-CSE-ConnectionGUID: CLMPRSABTsq/4L+UnotkTA==
X-CSE-MsgGUID: 3IyrcdgJTXmKZ6wcFgZNzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="105268923"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Sep 2024 12:08:36 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 12 Sep 2024 12:08:35 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 12 Sep 2024 12:08:35 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.173)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 12 Sep 2024 12:08:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FeI/1gLaaFTAqqU8VnSRvWU4awiW6VSOc6J0OQPHM7mGEtyV9XpU68595sSKQJklxvfKfDRS398TZkkz3WBGRuLis4QdQCly/VEL31YkzUfdXsvmH8yfg0EaO4byGYM6fgSFDD8j7BggT3kzevZLFbrlHt5RYjEeB699ITmuuReioHRFELdraB1YKObiWKmpfC1M1zXYXaxZoUk7uo3QjGhL0kutmbwdpsJ/7sI9OF6mf8OROAHbhh22CGA5NY2uNTkBi44rWeBc6CkImFC/0vN/byUZBSIKhQn5Dk0FC0z3birBcZmu10+HyAAYSe7/diBrQR1986z3ZAGXMzeBxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ltWnGhPP6lzKjtdaVBoOwMS5ECUN17C/NyWV/zt6uOs=;
 b=zHkiKYBIDIXSe53k/z0Vm/aX/r33kPoMS2G2F3zQE70R/u9I7UnXpndk9o5wFbbmwyTbrH1n4O2kiWhu+jA2LG/0EGN8TLn0ATiMjwV7Ze5tg3izCQWb1ErMfKKUf42/z/cZU1WNPyDgKzWSHlqO460bpT70iId8Ur/UEw4EjMaDfbzgDvfrpaI6w85QCQkFJVz17IKeuklt1RkGhDi7XJ/5UVrNsDZGOFItO4UiVYO0m0JObxrbflJrXt6xcrHn72QkXa3j2XecaSvUd1FJ6V6OgsEtV2r1143whtoaTTph2w9kJlTAu4Tz6lfM2HE7nNEfkQeYiL8CUC0vDYRntw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by IA1PR11MB7725.namprd11.prod.outlook.com (2603:10b6:208:3fd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.17; Thu, 12 Sep
 2024 19:08:21 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.7962.017; Thu, 12 Sep 2024
 19:08:21 +0000
Message-ID: <c7d65647-660d-4222-b943-74136f85d30a@intel.com>
Date: Thu, 12 Sep 2024 12:08:20 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next 07/15] net/mlx5: fs, separate action and destination
 into distinct struct
To: Saeed Mahameed <saeed@kernel.org>, "David S. Miller"
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: Saeed Mahameed <saeedm@nvidia.com>, <netdev@vger.kernel.org>, Tariq Toukan
	<tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>, Leon Romanovsky
	<leonro@nvidia.com>, Mark Bloch <mbloch@nvidia.com>
References: <20240911201757.1505453-1-saeed@kernel.org>
 <20240911201757.1505453-8-saeed@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240911201757.1505453-8-saeed@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0265.namprd03.prod.outlook.com
 (2603:10b6:303:b4::30) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|IA1PR11MB7725:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f394540-df40-4a92-76ed-08dcd35e44b1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?S2drMlpIeHVyeWRVR0ZvcjNKQ2haN2F1cVJidEJ6b2ZKY2RFcklFdHlNeEpF?=
 =?utf-8?B?QXRjZmJzcTFPbmFkY2RwZm5aaG5uWTVRTFdzUW5vQjFLdVRvbWNLSklUb2Nl?=
 =?utf-8?B?aXVSSHpwM3NraUMwZUo3dU5HQjJTSkFabjJSSklUZE5OUXNRYlFBdTQ1cUZB?=
 =?utf-8?B?NVhUMEZJdTRjVGdNOERkS1dDOWdkZVdUdW1oRTg0TkZwZ3FXWk5FK0ozVXlv?=
 =?utf-8?B?eUFLQWFYREZQSFljUTJrNktLSWtZWlp2RzZXUVJ5aFdjRWRIcXI3ZDNnZEdw?=
 =?utf-8?B?Nmd2L0tKbURSVVN3YU82L0F1WnNIRjJZbFA2WFFQcnoxdW1QbW9xSGJqSGx0?=
 =?utf-8?B?a2VDTUFTb2V1bVBMUEtIcXFIUFUvb2VVYXQ3TTlINnhCVFJKc3A4Q1BFeGdN?=
 =?utf-8?B?U3hLV1NzU2h1UFFVTnhaTG5hRkRwd3JqOFJZd2NKMFBwbnVqZnZSbEdmaStr?=
 =?utf-8?B?RENrWGNUMXBOQm5ydmk5bnZJYnpTUStJaXdyd25CSXJZcU11N0ZKY0lFbTRZ?=
 =?utf-8?B?dWdLVWFyelVKYXhXMU9vUjgxcUpqYVlBTHFXU0puano4bHBpQlExcmloajhQ?=
 =?utf-8?B?L243NXc3T3FxelBWSU1GTHNxQUl5TldaYnhsanhDSVdrcXNZZERoa2pVUnpE?=
 =?utf-8?B?NmwwUDZKWW8wZHUyd2RYQzBOVzhnUm8vcWlBSzUxdjBnSHh2VjRxYmJBNVpF?=
 =?utf-8?B?QXE1Rkxrb2piaDNRMVJLNWxxYzBDNUVua3dRQi9PYVVOcTNtK01VYzh3V3FC?=
 =?utf-8?B?RWROL2xUUU96djVpckh0cEFkcGdYUGsvMzQ3dS9OTHAwWlZxNWNDY3hUY09F?=
 =?utf-8?B?d21uQzRuWk16YWdxbXBYRk9Dd3BRYlRWblRyZEx2dllCbjFxc0QxMk1nbGgy?=
 =?utf-8?B?bzRLRjhMbTl4MjhyVnZ2QTJpVmNMNTVJRkNFa0F2RTB2aU90MkJ2cnhnN1d6?=
 =?utf-8?B?NFFIR2g4d01tLzZnKzcxVmRZbjNkbnVndmdhNThFL09PTjBCQTM1Y0JYUFl4?=
 =?utf-8?B?SS9IU1ZmQzJMazRubUZMcmJBcTBWYlVvQWNON3NPR2xJQ1NkaVJKQ2pVWGR1?=
 =?utf-8?B?UVRTV1drZnV4VkFWcllIbUI2c2w2NTkvMTZJdmhpK2hrRGV3cXA4U2l3VW90?=
 =?utf-8?B?enpvQ0dsbDdzQUVrL2pOMUtXa1RPN3Z2NnZJTUhhemU4K0pta0NFV0d2YmR5?=
 =?utf-8?B?cEtGSGd3aGZLUUlyWHdGcjk0Q2syN3hrUEdBMWdQQ3JqbFNuTVBraTJTbE1B?=
 =?utf-8?B?bUpPdVdTeGtFcHNKd25XMXlldmRYandoNHlSTktLN1JlVTdhbUgyZjhTc2xz?=
 =?utf-8?B?YXl1QUEvN3haWUphMkw5ankrV0hMemM2Mm9oaDgxUkVLK2M0OTFDKzJpN0tF?=
 =?utf-8?B?MDdJeEoyc1BteGVtenV3Y2NTQ0lCTWw5QkJybW4zbVFNL2UzbG5TQmgyc20y?=
 =?utf-8?B?em1uTFBCTlc5Ni80SmNBRmJsY0s4UHpDMjB1eEVtYWM1ZEN0d3dEQW9MQUkx?=
 =?utf-8?B?b2ZrSTNnTlhSdVV2YVIrb2V5amw4S1FUVUZHcU95VGVidHpPZkI3c0wvNVNw?=
 =?utf-8?B?R2dYN3ZMMzczQzg1VTdTN0IrUmhRZjZKRTg4OExFNkRLOHpYSFFzdlByUXA4?=
 =?utf-8?B?bXR4M0h0QWl4d1NZbjJNVTFLalBXQ2ZjaDZSaVlPYkVNR0Z0c2ZPS0F2TmN2?=
 =?utf-8?B?eEVuYUNlWjBYVlhlQzhDMHZPN3Y5b0ZXanZHY2pHL3RUSGdxa0tUZXVyVy91?=
 =?utf-8?B?SG9SdEg2alpCUGI4ckJabDZhUVA2bE9NWXpuUDljc2NmTDcwaFFDVWY2ellH?=
 =?utf-8?B?KzJDaXhYN25ZamJ1aFp3Zz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejJTVmhWR0ZRbXJFK0dzU3JWRnBLVlBXaFdsandwZEdqR1ErK1dIYnd5YXo1?=
 =?utf-8?B?NWh1RitHS0ZYczJJVTl6aHh4UDB5cE9neWJqc3kvaXlmWTd5TFpIbjVOakRF?=
 =?utf-8?B?UTdWaUE1dVo3RkExVUx2VWFjNUtDOVNHTGFsQnczSHFrTHFJMjIrL0NXenB6?=
 =?utf-8?B?a1d5R05GRUwwTFZ3cmdWZEpuWTRYS0RLcUNxRllxR2JNYnpJVWdDOEUySW9t?=
 =?utf-8?B?QU5DY0dxdkV4cVVnVmpmZXRMK05iZ2Y0aCtjODVPTDR6RUx1bjBzMmlCREpW?=
 =?utf-8?B?RXVlTHJVUFRwWHF2eWpmT0E3dWdZeCtXVzI2UGIybVhOdjVVTXdNalRMYmY1?=
 =?utf-8?B?eUpNODZVa1dEQTdXSmV1a1hZeWVNQ1hWc25BN1RaUlhJZVBWOHJjSFRHZFhh?=
 =?utf-8?B?S2tZZXh6S25sRVlQK3daaFVaTGswT0NLVmdsWlQxNkUrQUdUR3NSMm1ORGlH?=
 =?utf-8?B?S1laSFpxUFZyQ2QyRDZrcm9KaW56aUVob2QyNGViaCsrY2N5eFpWWnoxZklk?=
 =?utf-8?B?MzJ2b1BPOFlYTjhud3hxVHRpQnEzYmFvL3lqYmt1VDZ2bVpKM3NZRjMvY05F?=
 =?utf-8?B?eG5obW8vTk1nRjhWOTRrWlZ0UHdHcEZrMnRQWklIcFduNmwzeVA3YzFTYXhJ?=
 =?utf-8?B?Ynl4Z3FqYzhtR2VoeGVFVEZLSFQrSjBUUW1PZjVxdmpQdkVMb2lYeGdKTHNE?=
 =?utf-8?B?bVNFMVdER0pSWHk2bUFXcGp4YU1xS0NmWHJyWGZGYnBuaFdXZWpjK2FzWWlp?=
 =?utf-8?B?emJ3cEVEVVR5ZXN2L3RZUG5zajYyNC9lZmQ1UC8vbFdwTklTUUI3OU9DUUNn?=
 =?utf-8?B?ZFR0VkdpUUY2VzI2WWVQT0ltb0hHVHlha3NtK01BLzY4ZWpJdXA5d1REdHhL?=
 =?utf-8?B?bTVyb1RqT2lMcW1VVFpHaWp3ZG5vMWNqYVU2SUdGbjhlbjJCeXBsQTZEemFH?=
 =?utf-8?B?dE5RVWt1WFFaSUV5Rm1INU1zL0ZmWmNHRjRmb0UvWGpUMGwwYmZTc0oyb3NL?=
 =?utf-8?B?RjU4OGhaVmFIQytXR3E0OUpYZWJlOFZYTmpySFJXNmZ0azRZQlpoSElqTVYx?=
 =?utf-8?B?UDJocEJuRk9RSEl3ai85NGpoRHBnVndaamFoai9qR2szU3lWTzF2VGdLWHUw?=
 =?utf-8?B?UjQwYm5VMkRwRytpa2JoTWRsdUx1MVhjSWQ0Q0lreEJNNHQ4UGpWK1Z4TWRy?=
 =?utf-8?B?cGE5bzRPNTlKOGgvdHRySDN0aDJ5Z1M1NEJJRjBjUU5NcWowalNqQ2J0QldQ?=
 =?utf-8?B?bFA0ektvSFJ1ZEFJRERKb2RsY2xNSDkreFQyUU1QR3BRQnIyQjJaRmRyUzli?=
 =?utf-8?B?QzB6eTZCZFJsU0oxVXdrR3I3RDhBcWtwbndHUjhyK2pXKzJIVnY5d2VyRlMr?=
 =?utf-8?B?VDJtcGtTR3k0WW9Wang5V0lHSVdRQ2dIdTNhL2Y0dFhlUCtsQ3E0bktaUVQz?=
 =?utf-8?B?YW92MTRFeXI1STByRG9mWElQdHFDWjJNRk4zM05qWTlkMnZvQ1dta3FSL1p5?=
 =?utf-8?B?UkVHZ1ViM1JBZ1N4c0hxRUZoYVBWb2VLK21BQ1ZINUlsZFBNK1h1SDZLTHJi?=
 =?utf-8?B?RHpma0s5WHFmOEJlTU8wc1l4ZTVlSlBtWnc5OTYzN1hpa0lsUG9XRDJneDl3?=
 =?utf-8?B?NTRpRU9Vb1lNRjlBcFpGaFJqaTFnS0RPNk1YS1d0TTNHRFJPbjdQa2Y1dGVS?=
 =?utf-8?B?YWxvSXRiNlJoeWoxOHkrcVZnU2hZSitvVkZaM2xWWjNOYjNROGsvbnVOVStN?=
 =?utf-8?B?akpnTkNvTnZOZ1BvaXdseHdWcFZiU3RYTWNBZ0ZpaGxLYitzM0tIeU9tbWZp?=
 =?utf-8?B?UUliaDg1eDU4dHd5M0g4YWhYMHE3U2NHaVdsd3lXc09QaUFqQW1OS28wT3VU?=
 =?utf-8?B?ZTFFZkVKSzBobnh6Zk95OTR4T1lnUVhldER5WHBsSUJDMExpbmNpbE5aT29m?=
 =?utf-8?B?b2lZT1NmUFl1dVhaL3g4eUNNQmtQTjV4NXJMYWI2VFhFMjR3cFNMTXVrVEhS?=
 =?utf-8?B?Q3A5UGsrc1dXN1pFMVBac3NvQjVqZGJhK2xaUzVjN0NLTEdUdnR6VGJ0NXBm?=
 =?utf-8?B?VEdRRW1RZWcvQkhGaXhZQUxpM0ptVTFwQjFwanppTWFuQldZeVVXMERlM0ln?=
 =?utf-8?B?bG1XRmlSaUZxaXRhTWVpMGpmUFdyY09Jb1lzaWhxTk02cXRadkZHNWZvWkp1?=
 =?utf-8?B?bWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f394540-df40-4a92-76ed-08dcd35e44b1
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 19:08:21.3601
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ARGPWyMNC9DuGztdwr1gE61oSDHcAeHFLdatMNozVp26to7S9gGKJwwQQjVCPBJlkM8NCi7tQcocUItbcYzNmvoYmz3JpPnXx4zS4H7dcdc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7725
X-OriginatorOrg: intel.com



On 9/11/2024 1:17 PM, Saeed Mahameed wrote:
> From: Mark Bloch <mbloch@nvidia.com>
> 
> Introduce a dedicated structure to encapsulate flow context, actions,
> destination count, and modification mask. This refactoring lays the
> groundwork for forthcoming patches that will integrate the NO APPEND
> software logic. Future modifications should focus solely on these
> specific fields.
> 
> Signed-off-by: Mark Bloch <mbloch@nvidia.com>
> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
> ---
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

