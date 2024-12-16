Return-Path: <netdev+bounces-152075-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99ECC9F2969
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 06:09:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C58A716163B
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 05:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B811154C0F;
	Mon, 16 Dec 2024 05:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JClnMbJl"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352D025632
	for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 05:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734325775; cv=fail; b=Te5qJNnI4MS5EaYZjv/shBm55zaZZafmGJzS+j4li6eol+krf2LqSphAJs8WYXpYEHVCqhqv6rauBgVNE+us2YjQSFsdKlAzA2CkvoCYXnIJSPk77AapM2aSCU/TXKz2KtXkwEgL/aCfQJuvg+NgzVxd12VineCW90ohSw7ATe0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734325775; c=relaxed/simple;
	bh=t0dQWGgW/5OlEvaINvxRJnnqoWFm4FrNmuH/+K9ZcmA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PP86blM8RE9DwYb65qc4sCjUJxHi9Tjabg7AFsRxN6Jpe+QhiruoUlWcpqKVbLo5ZgN3PGpkYHBUCS3uBqLl1JmMAmva6S5yAD2AyW/AzjK7FI3wRhrs0MIspkiGywjiVu+XQNehyn7tKS0XL0oepvGrGE2bQ/RamO4YiVXlz68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JClnMbJl; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734325774; x=1765861774;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=t0dQWGgW/5OlEvaINvxRJnnqoWFm4FrNmuH/+K9ZcmA=;
  b=JClnMbJlRKPdCxC5kvkZD2a7jvY1bOo1QvnfcEr7VmDSu7dB5dm+JvBw
   rmC1cWFOwpH+Y3s4QwPt5AVcO79QK80+oup3SXgf11xIpExyyEmmY0NJw
   zsteUigeRWLa0XbIqv0Qfrdc2mue8vCXXOnTOaD4+vE0fry/GvAg5+RcK
   1PTbFZbyWoPbOHIv5aZ/OfCTztNA7Md2Nofl7rL1u1OPOiLmpmfpsYUTW
   An7uWfO+tPpMyaYZn0NjDfp6E5AB/boSc6brwm7kkwEygC9DE3ojyK1oI
   lYRUSuYHTAHR5NHmZCjAoM7mWrylsevk+zCYlXiWSb+t0+ftthuIx2j2S
   w==;
X-CSE-ConnectionGUID: cF/PfO+7R+Sh7w6Xn3gJJA==
X-CSE-MsgGUID: oewN89R5Sgq4ulp8+VyN6Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11287"; a="34612647"
X-IronPort-AV: E=Sophos;i="6.12,237,1728975600"; 
   d="scan'208";a="34612647"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2024 21:09:33 -0800
X-CSE-ConnectionGUID: EOb0KxWKS12gpV2QoAbUZg==
X-CSE-MsgGUID: XeypM2sXTf6xiV2g1bpGeQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="128078897"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Dec 2024 21:09:32 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Sun, 15 Dec 2024 21:09:31 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Sun, 15 Dec 2024 21:09:31 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Sun, 15 Dec 2024 21:09:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M7DA49ESf8dVJrvqxp15N1wivPKemz6+wDmAADgFjnTnT44qqxEgy827xI1LwuXwJzMrk+RFzpmCuG37sJoPqmXNq0/kmTP2odAY5sNwwLcz0O10QBo323T7FbrvWou5aFukPDZ3ZKLsgIt2mN752kRWWYnnhFFEwM/W2f7X0c3lZ1hqaQB3pvpiwKYFdKK+tSwmCDoFgnI8KCsngiwHBxAX6n5RnI8bd0o59cieycxcg4b3LbnlP94yX4aOVU34XNeDUhOMVBvpgUYUdYoXfDANxCBnLIQ3/H4GLgwKuITU0ibWq8HAfJEOUHmyjMZvH1nlhPwIkoNSMx1BVJgPAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k8YfUR6rGwveGe2omoZh824WPt62nZE3UirSu/7xd0A=;
 b=TuXxP27Nt2UDFT3zWu/cNm3oNp0VGbF0V+Ui94DvVLYOpJLkEre7rdf0hlNuCXsfz4ODlYJj2dmLxmHD4gc5lG15reAyxIsNkMx2jqxmEboOjccdRdSv50PgLo45zvQYfVBZMHZCFCo2rGuqXk072Pu9pCmy+KTyEaun39Rg/x8ZK3Ehb5nDVbR7KySnGXSq5c4kWm69t2T2jqLvt/GLUhyGxO3ZI2fo//t65g0s3eNJpCmeiA45TiGOJqWZ+YXBuhtlcgj/RdCxkTDjnudt4sRnVF9p15QukPKd+6tvZ9mSE/Oqu2HE+R1TRvtmyCV5+3IQ1N1+6j4iPxZvoA4Grg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by CH3PR11MB7345.namprd11.prod.outlook.com (2603:10b6:610:14a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 05:09:26 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%4]) with mapi id 15.20.8251.015; Mon, 16 Dec 2024
 05:09:26 +0000
Message-ID: <7afa4b93-59da-4063-9a4b-6f958555d4b3@intel.com>
Date: Mon, 16 Dec 2024 06:09:21 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][net-next] net/mlx5e: avoid to call net_dim and
 dim_update_sample
To: Li RongQing <lirongqing@baidu.com>, Shuo Li <lishuo02@baidu.com>,
	<saeedm@nvidia.com>
CC: <tariqt@nvidia.com>, <leon@kernel.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
	<davem@davemloft.net>, <andrew+netdev@lunn.ch>
References: <20241212114723.38844-1-lirongqing@baidu.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20241212114723.38844-1-lirongqing@baidu.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI1P293CA0001.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:2::8)
 To MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|CH3PR11MB7345:EE_
X-MS-Office365-Filtering-Correlation-Id: fcbbe98f-50e8-4919-9e5a-08dd1d8fcff5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aU5tNUE5Mlg5RndSYng3d3EycS84c3BnZ0djY0dOblkwelcvYXUvN3hDVk9P?=
 =?utf-8?B?RHN3ZjlPRHNldUQvWW01K2pONjdGaitZL0Q4NGVmZ29KMzQ5YS9kY1UwRzJG?=
 =?utf-8?B?S3gzdU0zQ3U2RElVMnlaT2lrY3VrOWhwRXk3ZFZ1YndLRTlFbnZSandTOUVJ?=
 =?utf-8?B?aG1xcUpXV1BONzZBZE9EeTZOQk16L0ZwQ0ludTZVY3NxVXpWb0pxQ3dadmFw?=
 =?utf-8?B?QXRGVW5kVDUzZFl5c1FYZmtWSTV0MjZQbDl6cFBDaUZJb28yNWoxYmw4NXhH?=
 =?utf-8?B?QjdmbEtnM3huMlZNSERiQlRQRDJTemxQaXRtQ2UxTE5MczVDRzJYWnBtYTNL?=
 =?utf-8?B?dHVhZ3dWc29TcGltSU5PM0JQa1hNOTZMSW45TFNBd05jWG5ldStOTmloQ1ph?=
 =?utf-8?B?RWs5QTZuNXhVbE5vRzhXczZYNXllRm1yZ1FsSER5dlUwUExMUTllamlreW04?=
 =?utf-8?B?NDJndG05YlhQTVlHOWFuQUMrN0ZMQlNKeFJGUW1XeVI4TW1XZUx5V01Ja2RJ?=
 =?utf-8?B?QzJoUGhjSmdZb2ZaNGZCUHlwU09sdnV0eENTaElydUpVRHhjQ0xERmM2Mjcw?=
 =?utf-8?B?bzU0eC9nMUhlcUVMZTNkNVN3cEFMYlJLMjFhRWpBdE9ITTR1cUZBR29aVk1s?=
 =?utf-8?B?MG1kK1BTUGNDTkpCdFg1RkZFdmV3V25BZFc0UVVyRWtWMjZLMTdDNWx0WVhL?=
 =?utf-8?B?V2VhVElSSHF5RWFWUThPaHlkNy9UcFFzWlZvTjhwa1VzNHlTU1I4Lys0cm10?=
 =?utf-8?B?T2dYNnV1cFUvTnhWMlk2cmdZS3NlT2wxZjVFZmRZL0FBYVYvdUlVZWNUZU9x?=
 =?utf-8?B?WnNtT29tdGg3UEI5em5obW9UQytiZDRoK21UMFhxUGlWbDdtaXhHRlBXVUx2?=
 =?utf-8?B?OVFJVS9JVEFCTmxSdXB5aGZGaVgwK1Vtalc5V043UnRub1FCK1VHeVgrcmxp?=
 =?utf-8?B?SnVHQXpxcG5scEEwVlpEb0F4SDgvNHU3Zjd6NU5IckR6dzhhcU5DNFN0WFN4?=
 =?utf-8?B?cjhuZVdaaTZOT21ybWJzb1k2NEZIeXZSRnlHdjFCRVZzQkR1eW56dWl5cU1r?=
 =?utf-8?B?U3hvczJuU0pKbGRmZWRsSmtzMlhLZkxOdk52eFppaWRCSUdTVFVvY0Iwdzlq?=
 =?utf-8?B?OW85eTlFRmIyNUdsTkJhSGc2aTlvZXZJNCtURmNqVS8zZWNFeHAyY3I0a0Fi?=
 =?utf-8?B?OEJQWFZETFE3UE1kREdwZE5CdEZSUUFwZDM0MG04ZGJJU2VQQ01EYjJYN0p4?=
 =?utf-8?B?ZjIrRWVjbDJaK0dGbVkzMCsvSkNsQ0ZUVHJ4WUc4WkVxVmp0eDRhb0hhQ0Uy?=
 =?utf-8?B?UWJ1OXQyRFdLTDNnQ1oxZFAwelRaaTJsS3RLaUR1SkplU3djSWcwd1V4U0Qx?=
 =?utf-8?B?bkQ4RzljNEVpSmNPUzB2WU51TTQyZ1E1MXVOT3hRNW5zQjdQMHkzdWhEZVln?=
 =?utf-8?B?dmwvSzR1WWxlYkJ1L2ZGOEhzQ0FWck9MMEptTGtIVndGNTgyQkd6d2xKalpB?=
 =?utf-8?B?NkVXUWFBcFUzZ0lvMm83UnBLTnA2bEEreXF5Tmw0UEZxSTJWdm8zTFJGcG9Z?=
 =?utf-8?B?cnVnRUNkaWdmb2d6eEpraHJnNGpHbUxxY0plVk9GdERCQVBVSWZIY1ZCRGg2?=
 =?utf-8?B?OWRENjhabmxuaFFJem5tZEtwaHZiTEdXQjRzc1FLRFNaYm55c3R1SGh1dXJv?=
 =?utf-8?B?NEhXcEhxT1ZqVFh2K1BUR1dnMzhFYU9yK1hVVnAxM2krMllPV2kxeGZ6NG9t?=
 =?utf-8?B?NEVWQVpjVysrRXJTaURPLzBnSG5BclhRdldEd0lJeVF0TVZQdGRHZk9TT3c1?=
 =?utf-8?B?MVNyV1gxTURqMUVWL0RsV3lSNUcxOTZ0UGVRSU9YTitoRUFJTTZNWGx6a2Zm?=
 =?utf-8?Q?ZMNYY21VQYdqR?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGpMTDdoY0pMZStjcGZsNjlPT1lmbWJNQmg3VWpTdExJNlJtc1l3bEhaMlMv?=
 =?utf-8?B?WVp4bkJsT1N4OFlzM0pIcE5vZjRGTU54UHZIbzBPNDdUR1ltOTlDcnZvcDlN?=
 =?utf-8?B?aCtNTHAzMjBzNk9qUEJZcGlnZXl3bkNEbExlaFh0RHZ1OXBNanBWdldGWnJU?=
 =?utf-8?B?ek5lMHNnNFZvbHFhcisvK01EZjdURlNQbzdUY29GMVVBV2t5VnlwYjd6a0ZO?=
 =?utf-8?B?N284VlVWYk9qUGNRYzI1VURmd2I5N2lUQXJITkpmM01BdkluUS8yUFdvUzRO?=
 =?utf-8?B?RVl6MmNGZ214NFJEcklMbGJmUnpRZ3ZXbmt2andXT2tuaVhSMnR6L0o2bjk2?=
 =?utf-8?B?UnNJSGw3TFBDZStqbWJuM3pVVE9pQnZpdndSMkg0ckhFcUdqV0xaVUR5VUF2?=
 =?utf-8?B?Vzc1dWxoL0ZFd1FSNFJyd2NRaHdJM1V0dll5azVEYzdVYVBJZXI4NjBPeXZO?=
 =?utf-8?B?U0cveEZYZ1pTRnp3ZHRXa3NLT0x3VXB6cGkyQkcrNGZyZ01GWHR1SWszUGhO?=
 =?utf-8?B?ZlV4b05IRjQ2QmJOOUxWUWVWd3liRHUvek9YYXVVemJhcXpBcjBSLzZGZHRD?=
 =?utf-8?B?cVlFcVZvUndIaE9mNml4eW41YTFvL2R4bVEyUWdPanlJZlVHUk40TytWaHZ3?=
 =?utf-8?B?ZC9yVDQ2clBqNVM3dG4xakFJbnlVVGtENFdMZ1lsU1ZtckZCMEF1dnlpcnBH?=
 =?utf-8?B?QnBHU2dkaW16MjgrejdPTkRIVkJnbWlKUlh1L3pQOG9PR2ovTVBqUXZxRnk5?=
 =?utf-8?B?Q2JWVnNoZFJ6MWVucGVUT3hrVk5IQ0ZacUQ1Ty9EeGFuZlNUQkNyUVBkYXEr?=
 =?utf-8?B?Vk9DVDRwMFJaSjRKME1EN3NDK1RFZUZFWFd1eWFiSDZUSDhsRHRXMEo2REZv?=
 =?utf-8?B?MkZkZUFDSksyVG1zeEUxOFJ5ZXRHR0loWUdzWnNGQW1xWTM5cThKUjcrMjVt?=
 =?utf-8?B?MFpqQ1RvUmRHNWFXVkdZc0t2SEhqbFJ3MTZiVEVmZkFoUExlUVF5WjE1VlhN?=
 =?utf-8?B?QVNJYitKZkdZVTlBQ3pycGJub1E2Z3BqQ0YveVBWc2h4aHhUTnFNUUl4THRU?=
 =?utf-8?B?a0ljN0xRTjNxTWxQdVFVM0ZCdkxBRmFveVgzMHpFYVl0K0RFNHRMYk1RaVJL?=
 =?utf-8?B?L29WYjBtVm1iZ05BNWhlRjA3aTZGd0UzaFRra1lRa1VmVjRLRzFYNHpwaFBP?=
 =?utf-8?B?SjVvSXdSdStjZzV4QjkwTGs4NmVldnZjcG9QelNHa09iVklzb3FOMnZJaGFs?=
 =?utf-8?B?YUt2aFJMMndwRWszS3g1enZsR1c2Zk0wMGlDOW05VTJMdGFvVjNWRVh3VC8y?=
 =?utf-8?B?d0FLUjBUQ3ZzN2RjcHpxdFNiZ2VtVFZBMkMyUCtIeVlLaktndVRLMGdSaDNN?=
 =?utf-8?B?cVUvOFBNM0ZsUURGUnlMSW5VY0gyTlpnZ0lCNDBxTTdSN0VpaUVGbTRab2Nr?=
 =?utf-8?B?YUVRWnUwZTY5YXR4aVdHR3BOZmJVaEFEMmRUalR3a21uTThVbDN3a05rWGR0?=
 =?utf-8?B?Zk5vKzRURG11N1BEK0Y4cjV0RWRVU01nQkdkT2ZhQUxsRUh5ek5qQjNSSWtj?=
 =?utf-8?B?WnA4dWpwRFhFMEZWUWNMR3IwcTVtNzh0cFVpbE5HU2xsRXZuZSs5d3JTMjYv?=
 =?utf-8?B?cFlqOG5mVSs4Wk45TEdEUGtITElYYmlKUXAzSFJwNmtjaXBFaGJxOUE0UDc3?=
 =?utf-8?B?WGd4dENLRUIrcHlHZlJxRnFVZk45aGV2aCtyQUNiZ2dWNkhtakhrMUF1R0t3?=
 =?utf-8?B?ZWNFYm12NEprbWhZL1Bwa3dDbTZnVjh0S3FIL0EwSDVsMzl5NE1jQkFyMC9F?=
 =?utf-8?B?S2hpcDlQeEZsUXdLekExNWRxQzVEeUordUg4K0o1LzcraWhaZkxkVVhUdTNV?=
 =?utf-8?B?dzJNRWoydzltTEp0Wnhjcmk2Smg5YkJnUkR6M0cyV1RuT1oyU2swUjEwbjZJ?=
 =?utf-8?B?UVVBOWs2MW1qQnNmc2xRTHZXVVlvMzhKZmpLb0NITGc1a0lCd0JxR1FBb1Ra?=
 =?utf-8?B?R01MT3ZPN2dRdDVtcTRDTzFQMmZHKzEyNXUxUERXUkE0WGlheFgrajlZSFVs?=
 =?utf-8?B?NVNuR3MyS2M0RHJTVU50bXUrU3BkcStKVUNteWVmTVpmNVYzYjh6M1ZsdzJT?=
 =?utf-8?B?STBDZThMVStPckJkS1FpUlU5ODNjWVRJeThYSEgzRURWTVlQT2psWmUwbGNM?=
 =?utf-8?B?OFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fcbbe98f-50e8-4919-9e5a-08dd1d8fcff5
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 05:09:26.3931
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sZBBneY/pGMBn1jFWoXdJhfcvfGHY461tfEMHbzmoUJyWzumY8gEIAvS+Iig0jpn1qTdWaJ91Gbd4ZdMGhUlph5czvFxBsx/PC9uzckKEqw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7345
X-OriginatorOrg: intel.com

On 12/12/24 12:47, Li RongQing wrote:
> High cpu usage for net_dim is seen still after commit 61bf0009a765

CPU

> ("dim: pass dim_sample to net_dim() by reference"), the calling
> net_dim can be avoid under network low throughput or pingpong mode by
> checking the event counter, even under high throughput, it maybe only

s/maybe/may be/

> rx or tx direction

Rx, Tx

> 
> And don't initialize dim_sample variable, since it will gets
> overwritten by dim_update_sample

Good point.

> 
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> Signed-off-by: Shuo Li <lishuo02@baidu.com>
> ---
>   drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c | 20 ++++++++++++++++++--
>   1 file changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
> index 7610829..7c525e9 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
> @@ -49,11 +49,19 @@ static inline bool mlx5e_channel_no_affinity_change(struct mlx5e_channel *c)
>   static void mlx5e_handle_tx_dim(struct mlx5e_txqsq *sq)
>   {
>   	struct mlx5e_sq_stats *stats = sq->stats;
> -	struct dim_sample dim_sample = {};
> +	struct dim_sample dim_sample;
> +	u16 nevents;
>   
>   	if (unlikely(!test_bit(MLX5E_SQ_STATE_DIM, &sq->state)))
>   		return;
>   
> +	if (sq->dim->state == DIM_MEASURE_IN_PROGRESS) {
> +		nevents = BIT_GAP(BITS_PER_TYPE(u16), sq->cq.event_ctr,
> +						  sq->dim->start_sample.event_ctr);

indentation is off

> +		if (nevents < DIM_NEVENTS)
> +			return;

this very piece of code is present in net_dim()...

> +	}
> +
>   	dim_update_sample(sq->cq.event_ctr, stats->packets, stats->bytes, &dim_sample);
>   	net_dim(sq->dim, &dim_sample);
>   }
> @@ -61,11 +69,19 @@ static void mlx5e_handle_tx_dim(struct mlx5e_txqsq *sq)
>   static void mlx5e_handle_rx_dim(struct mlx5e_rq *rq)
>   {
>   	struct mlx5e_rq_stats *stats = rq->stats;
> -	struct dim_sample dim_sample = {};
> +	struct dim_sample dim_sample;
> +	u16 nevents;
>   
>   	if (unlikely(!test_bit(MLX5E_RQ_STATE_DIM, &rq->state)))
>   		return;
>   
> +	if (rq->dim->state == DIM_MEASURE_IN_PROGRESS) {
> +		nevents = BIT_GAP(BITS_PER_TYPE(u16), rq->cq.event_ctr,
> +						  rq->dim->start_sample.event_ctr);
> +		if (nevents < DIM_NEVENTS)
> +			return;
> +	}

and you have copied it twice only to avoid ktime_get() call?

> +
>   	dim_update_sample(rq->cq.event_ctr, stats->packets, stats->bytes, &dim_sample);
>   	net_dim(rq->dim, &dim_sample);
>   }


