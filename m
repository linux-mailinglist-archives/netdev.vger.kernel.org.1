Return-Path: <netdev+bounces-156919-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17BCDA084A4
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 02:15:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C3893A585D
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 01:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8410B1E103B;
	Fri, 10 Jan 2025 01:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ypb/PrhR"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D996B1534F7
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 01:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736471685; cv=fail; b=a6s3rvajR77k7JDVoq3WFTwUFYzHxDEwVGKn9ykEHnQi3Aj0xsX9knKgi27Bl7bQXhCP/fOhH34X3MuAPfuY/v20gaKyuNLKPgemUntW7Q2EMPjPi1YyqIw+ROLs7RLO4V3F7+/gfTvCWy9WngZ0Tys9VGmS/29D933wgOw2WUE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736471685; c=relaxed/simple;
	bh=4b8u7ZX/HgyJlZnbJ2gjsiXwb/oqGz//ogZifGYvhxU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fEdmhJIapZLaHQL9Lb5voHkoCN0gMFPhQnHh3B+MoH8ATNBfcdGsNKAMgQOvOyNecv55pRUVM0IvyisbddnNsN4+B8ZZNDY9kmnhoChAr52xFvqlRAcnAR657+oKQilbvGR/tN4E4ISjy37ByORvCvqU1T1g3+DoJ+3GdskJpuw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ypb/PrhR; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736471683; x=1768007683;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4b8u7ZX/HgyJlZnbJ2gjsiXwb/oqGz//ogZifGYvhxU=;
  b=Ypb/PrhRALZsbAouBIxJdUr45KWVpZQX4F02zqc1pJzV+UMWPKle1dX6
   eDRbG4Kk3k1YiuD5aq9Oq21pzHJP0geLsqFy3PcWOmumgMRgO+h5zFX2g
   HODYsE8/MeShHzoMSA/K5lLVpsksJyvSyFu357JDxG32iLGu64SYiT8hw
   EVsUhkVRZJvdD7Tp1ABVvRPSVC3IZZczApFtLTrr+2j0g3CQTOGZOXYvN
   ZCTowGphv/tBaOjn2qFZS1YeTGdBjF+XnSqniZezbFK7UZbIaff/FExhE
   Lc/QVjMVyvCnsFvXPYxS65iWp9RQcsfHjzSR1FCcL3lNGTGUEyKwYOcG6
   w==;
X-CSE-ConnectionGUID: PAZQtb0JSlS9fjUyYjOuzQ==
X-CSE-MsgGUID: YbjDN6+2S3yNfSIdEmua5A==
X-IronPort-AV: E=McAfee;i="6700,10204,11310"; a="36638693"
X-IronPort-AV: E=Sophos;i="6.12,302,1728975600"; 
   d="scan'208";a="36638693"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2025 17:14:43 -0800
X-CSE-ConnectionGUID: tzA6VMl6T4a7pr+GmhR21g==
X-CSE-MsgGUID: h/zCAJumSr+2ud8x4zAAFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,302,1728975600"; 
   d="scan'208";a="104122825"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa009.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Jan 2025 17:14:43 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 9 Jan 2025 17:14:42 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 9 Jan 2025 17:14:42 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 9 Jan 2025 17:14:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M4P4J+h0YDuIx4+x+bmlBiwml1wayL/SLe/V14+S5kKbYXVLRRBeKpeeWD9j5fey4lmKvsVxOO+1T4Zsmgrxls/q6qMOOhsvCFP+5rCUBA+ozfc1YGbwRkIcA3bMFKz8C4GJcFE3brJZ/HztIxjW5D7bwE83oX+oGEL2Un1so96S2/TeKYpLieH5sg+VAJmBXphX0JaqPIBlxbybohluiH2Y6q/lKBtVXv2qzas2j30RGpCeMSu3uT2wd1H1G+QzEZxTxF41gbX9osCoXTzRpC1gYy3YwXH9LFj9xg02Zirmoea5mutCJBil4vfaeVwrRsp2SeJNKwfVqSVfHAcPhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oaeDpg6eBbZUwvnHqMrH/67zfrQTjF+NdwBKfBvKzkQ=;
 b=SKYMl7eY/VOCZlxf6O0zjhIfZDH337TErqMzUafndsXHocmART7iS7Y0VUDsbQFL7uyhlYEDWYEbXGa1vpvJX6yoy257Air8Ygw0JjbactbUS9mrqEXdHryv1OfE7zHYEO9h+OIfQZ5V3gsDujm6+lFNLOUb4qB+jrriELBMJB7lNyUAc2DdXTKcpNUKvJbddNZYchG9RpB8ah1g3gICCkumtDGeBXv9Q7kIpGmaJPmZUr2yCKXVGff4fYsqBp2VOLSNDOS5zG+P7HaX3nuSliTkktF7UmpC9ClyKoIt90FNA3F3/iBGcrxH2T1wTuMknQ+Pj4IBAaNr6G3rE5p6kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by MW4PR11MB5892.namprd11.prod.outlook.com (2603:10b6:303:16a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Fri, 10 Jan
 2025 01:14:12 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.8335.012; Fri, 10 Jan 2025
 01:14:12 +0000
Message-ID: <c7e6dbfb-b5ae-4953-ad35-899341083723@intel.com>
Date: Thu, 9 Jan 2025 17:14:10 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net] r8169: remove redundant hwmon support
To: Heiner Kallweit <hkallweit1@gmail.com>, Realtek linux nic maintainers
	<nic_swsd@realtek.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Paolo Abeni
	<pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, David Miller
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Simon Horman
	<horms@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <afba85f5-987b-4449-83cc-350438af7fe7@gmail.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <afba85f5-987b-4449-83cc-350438af7fe7@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0173.namprd03.prod.outlook.com
 (2603:10b6:a03:338::28) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|MW4PR11MB5892:EE_
X-MS-Office365-Filtering-Correlation-Id: 297df80c-4e75-4380-ca07-08dd311417f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eG8zVUxFeU5keWxFMzk1VzNIMnJSQXNMVWp0UzN1TTVoaGFtZHBpUkd5dVgr?=
 =?utf-8?B?U0UweGg5VnRzNWN4UDVKT21ZVXM3YVA1UkpSSnhUcGNRenRFNlZYbnA4dGUz?=
 =?utf-8?B?VnluYUdhVjJLZHh6Wm04OW9VV2FHckx2Uk80dENla0EzS1ljZHZ6RUtFSk1u?=
 =?utf-8?B?dmhZb0FDT1NyZDkrNjlNamtNUVAyWTBuVVdEakhGbUQ1MXFxTStKbFFMRjhL?=
 =?utf-8?B?NHRtbDNFRkl5TXF2VkNiS2NBN0xQL2wwbFBRbDFOSS9Nd2NWTnN3RFBjdFh4?=
 =?utf-8?B?SjBsaTBSTGdFeUNwN0FMRFgzTFQ0OVcwQ1pKQTd4d3d0Q2hPcCt2TTBFOCtk?=
 =?utf-8?B?N21za25QeU5TeVdTYlRkUDRFazhSQXZQZUZqc0FVWExtSGtxSURneTFPVGVY?=
 =?utf-8?B?TXRSK3lmS081WjNHK3BFQXlLcU9TVnNOWE5DZDlVeXdDTlJ1bnI4Ymk2NTJp?=
 =?utf-8?B?ancyNWxTS3d2V1FvbWJEYTNxK3NwUWVmcTNLQkUzbTQwKzYzdjF3SkNzMGJa?=
 =?utf-8?B?WUZqcDVjWHFCWkN4eUJGcUQ1L25CQ01vUDl1dEhFSjVQaWVza0svNkU2RDRZ?=
 =?utf-8?B?R1YrcVlMWjVaWEJHenpJZlV2OFhTN3hETXNQWE92dU15YUtlNGpUc3Q1VmQv?=
 =?utf-8?B?Sm85VjlXQUNrOEp5Vnk2Q2UrWXI4WCsxcUhsOTZlbFRlZTNjdERoQUttRC9x?=
 =?utf-8?B?ZmNTdHNTWHhJa0piakhPVEtadlQvWVR1WWpqMXJUTGxCWGMxcjJ4eXNqZ2ZZ?=
 =?utf-8?B?cGhkdTdnRllwazN1dXJ2c2E3VzA3MTJhQnIzemhXOVNYdVYvTWEwYzIyUHRV?=
 =?utf-8?B?ak00d3pJbU9lOHNJZHNPSXdzQ2lHbU5FbWhYS0xlNE1YYzBRM1lVWnpxcjBj?=
 =?utf-8?B?K3ZDY3lDVk0rdWNSZ0F3aUM1ZDdnZTQwQ0dPZ3VBcUF4cjFabThXS2plSGpT?=
 =?utf-8?B?amF2T1VsVVpTTnp0ekx0bFdLY2RzRk5jbndMOEc4NlAwM0hTcCswVDV4UTda?=
 =?utf-8?B?OUVLQkQrbWFxazB0dnYweVl6ZSs3V0haakFJYjZFVnpyNEFCbEVwS2JwdHZa?=
 =?utf-8?B?UHpHem9XYkQrYUk3d3BZallnZ2M1dTBURksza0o3S1RpMjZWMlJLSzAvaHZJ?=
 =?utf-8?B?YWVLQ3J0TEM4UXEzSkJBYktmdG84ZTVIbWZMK1RFcEdmK2l0STVweUttdDdy?=
 =?utf-8?B?TkFsQytDSWtiYjVRQzZpQU1UNlRzU2IzSjhIUEFjR0EvcE52T25UeGdKK1JO?=
 =?utf-8?B?cXljb29qd2VvZXZnZUZaQnR1eG5CRHdYRGprcXRCQXU4N1BIUmlvMHZyTzJ4?=
 =?utf-8?B?WGs0dkVKUkU5ajU1SGI5YWlSMDNwTU5oT0hwbDlzOTFpNy9ZUGJCSFRPK204?=
 =?utf-8?B?eEU2cm1abVM1T3F4WDFUbEwzSkUxU0RnanZUTkk2bmZBbjF2TGp5WmNJKzMv?=
 =?utf-8?B?eDJ0MU16VTlJaHFsd2h3SmMwYlU5OUczU3hkM3ZOMjE4RWJ2SjJXVWFDOHA1?=
 =?utf-8?B?YjB5WWtDRE8xVDQvcCtacFFlazhSUlV1R1ptUmd6dm5Xd3VQVDF2Ny9yK3lB?=
 =?utf-8?B?S25BUkNaV0M1VTVHektpSllYYlB5SlY2cENpWDFLVUtpL0xCL3VjNnBhdzY0?=
 =?utf-8?B?UkExMm14cDl4TDIzajUyTEtZalZHRHBWMkh2Tzc0LzZPbXlDa21KVlIrOG9t?=
 =?utf-8?B?cjArSU80U3p0b0JxbnFEa1NSclM1QXd6QXRPaGR2ZzlSUmIrK2RGd3FnOTZl?=
 =?utf-8?B?b2NETnBFTDZmZm1DRHI3S1E3U2crSHZHbWpjUkd6c1BrUTBtT1pNN2pseWFP?=
 =?utf-8?B?SmppYk9vSTBEZFA1MG82ZDg3dkFhNFpua3BLdk9pUHoxSmw3czVzNUZKY2NQ?=
 =?utf-8?Q?xnOzeh1L6A1mZ?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0tvTERhSmNIa25WeVA2Skk4UU1EdnNaZzIwc3hiVHYzUlRWYS9YdFhCTDhQ?=
 =?utf-8?B?MG5UcC9UaE1OQWZoUndkN3d5cmM5VVBEaHA5OUowbVphU1NmRFZEbEY5clVl?=
 =?utf-8?B?UmtSRVpKVWFXeFFCN0xncDFHODVieW9jMXlhVmtuOGRJVUF3NkRRT05QbTNY?=
 =?utf-8?B?d3VUVnJXRm93UzJOWjZhOE1EcndLcEZOVndXS0pmdC9ZUWFtNUplYzZ0ZGxF?=
 =?utf-8?B?WDBpUVdzS1pGejFSNUNBR2MyTlRpSFY0NGh6SmQzS2xNL3dtTi9MSkNMRzUx?=
 =?utf-8?B?YUdiblN2V1cwRm5OK0p2SXUvZ3VndkJJNXYxdmVDcWIzRzg4YllSSVZPeEhu?=
 =?utf-8?B?RVAxZ1NRcS84WVExS0RZcE92T01rOVFCQmJhWjBOOXhrRTNhR2FBUVFiYU5P?=
 =?utf-8?B?emxGaE54S1U2eHR0VEFTZElXTUtRMzRiU0xHOXhvM3RLM1V6MEp5ZUkxaXk2?=
 =?utf-8?B?V2JyVTVKU1JOY0RYMm1ENk96bGxmRXNIaVNhSVZVUWxLQ09rRWg0NXdDcGlM?=
 =?utf-8?B?cER4MWwwUVhJMk05cWdld3ZFUTBjN1lIRnYzUUlZcFlmWCsvM3IxcGUyZmdz?=
 =?utf-8?B?cHhOOU41UmxsZXZnbGNMSXpiQytUSGprdDkwNlFLaTd1YnFiajJKQ1NnbjRs?=
 =?utf-8?B?REM0b1pHcktneEhJMytXcDZqYlJuV2t2QWNzR3pEcmZjeStZZVdZeVNud0xw?=
 =?utf-8?B?WWRsdHhINkU5QjdpdGxLdzR6Vkh5OFN4cDROUVgrMDdtRHY2SGlDK2YrWnJ4?=
 =?utf-8?B?ZHdibW1LWWZTWVJlemh5UnFoNklWd2FQaEIrTWhwNHg0ZnpzQnRFQWd0bmlM?=
 =?utf-8?B?TnZ6UVk0Yk54SUVvQk1TS1pObVltT0d5ZXNMbXpkS2R0ODlBNE95T3RVbkxX?=
 =?utf-8?B?ZHhuOE1ScTlOUmhPYjlZc1ZoVW41TlZwTmphMXVRcncvdVllY2ZudjdXMy9N?=
 =?utf-8?B?cmo4NmJVb25WSHlPTVpHb081Z0g0MHgxVFQxMlVreElsZVRCU1BoQTR6OFNM?=
 =?utf-8?B?RVdhSHRoLys4YmJ3ZDRaYkhTZkpUeW9HeFZMd2lYN0lTTDZCejNMY1Z4cmZO?=
 =?utf-8?B?dk03bkdkTnJoMGdFUjQvM1NSN290MGJiUVZzaC9EMDJnYXd3UkdTNHFGcXhy?=
 =?utf-8?B?S2orUlNITys4SGgzTUgrTGhTLy9VQXBwYzIvTVZ3WGE2SVdIVFVwbXUrY09J?=
 =?utf-8?B?c2s4K2o0c2htODhucGVUK0VVNEZnVks1Qk5VK2hoWmY2N0RVYkpaYy9ldG54?=
 =?utf-8?B?Vi8yZ3I1dVU5NkhTdk9Ua0hDSFJxYlYwQ0RwSlp3SXpwc3VpQ1AxZExFZCt6?=
 =?utf-8?B?bmFUYTNGWHYxR2VVTlFmb3VYZEtpV09jSXdYeklrSDlNUHFUTXVuU1NEZ2c4?=
 =?utf-8?B?Y1RldFRQNGxKWVJnZFN2ekZpWlFwZWJYVnV4RnpscmxOeGFYSk9BaUgwcElx?=
 =?utf-8?B?YndmM2p6VkFvVEswT2lmTEVRQlVFVDB5TXNCcEorV1ViQUJOcnBxNytpVlRv?=
 =?utf-8?B?WXR0ajNHN1BCaFlsTWtwbzNzVDFGYVdqZENYRmFpbDlibTdvSEhnbDg3WlhU?=
 =?utf-8?B?YnpQTUdZZkhkeXlnSzdGNEs2d0Z4bWVNWThucE5WdmlqbER4QWdGN2R3eEht?=
 =?utf-8?B?OTBZNkNqeW8rY3RLcWliczNxSWl0RldVVkdSR0FQdFVCcHhOYzA1enpQQlRJ?=
 =?utf-8?B?ZkZPWWc1aTdIMGVSdkxHZ0ttbzMrNzZKTG15UEtvblg4K0g1RHplWk1tbzAv?=
 =?utf-8?B?N2ZhMGNreHhPMW4yTFZ6N241RnQ2d1dnQVNiZDVkQzRDWFh0L2g3WE52Z0Fn?=
 =?utf-8?B?QWplamo5QS83VUMxMm01eWwwUFRVM1R4TzlNa1JCMW9DOTlrWVhpeFFmRHJB?=
 =?utf-8?B?VUpLVUM5eFdtTTVPMlBwKzFrVWROdnhxZndRam9RYUNzcDJPVWlHRHZpMEVa?=
 =?utf-8?B?R3dJZXFtdmY0NXFpS0lUMm9veWgrSmc2WG05TDJlK1A0cExxOHRQU0RrUmJx?=
 =?utf-8?B?aTZMUHFnd0gvMURMODdlbE5ML0x1dzZ3Z0dXQVg3VG1LRzNsNUtUSEM3ZmFx?=
 =?utf-8?B?OE5QOVpFcmxTT3JSV2lSU0R3MFNqa2JMR1g2UEljZTdCOC9qYW1yeG1sSUJV?=
 =?utf-8?B?NVVFTVFGNEdrWUFyUS9yS3FvWnFUWEIvdHFzYzNBN0ZjUXE2SmFPUlZsSUdH?=
 =?utf-8?B?ZFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 297df80c-4e75-4380-ca07-08dd311417f8
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 01:14:12.9066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wetArGLGIiJeu0VYbIVyBMEKGGI1fJnGBtS36KQedRkwthCiH2SOk34v6Hm14+sdgMrQvt9aDigS2pfp6noMULjOGfPbJWg2gR3aQU74eBA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5892
X-OriginatorOrg: intel.com



On 1/9/2025 2:43 PM, Heiner Kallweit wrote:
> The temperature sensor is actually part of the integrated PHY and available
> also on the standalone versions of the PHY. Therefore hwmon support will
> be added to the Realtek PHY driver and can be removed here.
> 
> Fixes: 1ffcc8d41306 ("r8169: add support for the temperature sensor being available from RTL8125B")
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---

Can you explain what user-facing issues this fixes? Do we get conflicts
when multiple hwmon sensors are registered? I'm not sure this counts as
a 'net' fix, unless we can identify the user-facing behavior that is
problematic?

