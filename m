Return-Path: <netdev+bounces-153274-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3135C9F7828
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 10:17:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04A52188A59E
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 09:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD14216E23;
	Thu, 19 Dec 2024 09:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UeIx/zHJ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8B5149DF4
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 09:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734599844; cv=fail; b=EmfC0xlH7+PmP6C1Ep2eUxQdjJ4P/cLl6UcERTpP6w3vp6+fv5iPL7T0Rn+3rc7qbnBljJ0B2lOkdQ133ZnzkmjtmnQJXTTBTzVRtKxZ5P5Vq0C2jbBwujduz5KzqyrD1i+9nlJMMdNMhW0IB1GPwKlrI1iYo87TM52a3qwvI8M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734599844; c=relaxed/simple;
	bh=NOsLis7hLbkkVRe/+tbR6pSvvRobF8/9xUtbgHHXcD8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sOzVRhmIVgytYb+d7mfnegAteBAefqubMUC2joKe4EYCAYOXcnrL0eImq5/ZN9JlNArN4hOuygoim9uyKi6xmlgsW96n/vBWb9hknnOoSFj/LypCenpcrajkkaGxEqbqEEmA79b3zF1GjO2tiCUp39UTiPY03OwZEnjeM+zPMpA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UeIx/zHJ; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734599842; x=1766135842;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NOsLis7hLbkkVRe/+tbR6pSvvRobF8/9xUtbgHHXcD8=;
  b=UeIx/zHJExTcjK+4eQmL8XYM/npDHaKju+gWB0b8oCiDbSuEj5RvFTOl
   8U5oR/X0xiO9N26EadfLr1nBO44GL5rjN8x994WzDmYgC//n5omShz2OA
   a0QPvw9qFSVIssTqSfFYrHkPN9aTvV4d6o+ip6zRTaZAyplFfRqgo2Vjb
   ZRRXQVUWgTXrbtrla52eNbdwVd1mHG6x6xiaz2FF2s2cp3rxkLQjSPlAN
   OMVVflnu5OtuZaNGHgiB4X/8/kIPAueFj8tzh1Hyh+GG2lMkS5XpSuD3J
   PvSV/MWtpqhK0y59ZSEZmRItuuiT4903xmnlvet8dwvphvC0Eu+tlfF+s
   w==;
X-CSE-ConnectionGUID: efulnupgTYSFPh7Rt6qfpw==
X-CSE-MsgGUID: NwHBG2UHSU6AP4QsrhLNuw==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="52627119"
X-IronPort-AV: E=Sophos;i="6.12,247,1728975600"; 
   d="scan'208";a="52627119"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2024 01:17:21 -0800
X-CSE-ConnectionGUID: pUvvrDTtTPGVcxTU/4owng==
X-CSE-MsgGUID: Z0XjhJWZQ7yuU38BQW+BTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="97964362"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Dec 2024 01:17:21 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 19 Dec 2024 01:17:20 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 19 Dec 2024 01:17:20 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.49) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 19 Dec 2024 01:17:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x8jwJcVzKl1MQ6a+2K1JizWooH91TESqYyrLo6uCAprJX7ds5usoSfnyzMA4AyTY5+HLdfhs4ZHRYmwxNH8HUfRTt29h33EM3yVCIShrZknMZIgtylGmGWSLzoLn/dNQMuQFM27a4RE1z2dQs9RzgTodM60UBwPwvZuyX/2ClXI3W4Ijbk/UybrLpGP8HfSEmO5SAfFcCroTJ/qfzJD5ZQNcdM/HJuL91JqCiE32Ftcgw35vj3gaZqq0FZxrga0Fk6GrAI6270TMehNu7/RSRC8AdRZm4gzDSwomsmEY4qytdrhepz5c6DJ6xLgYM6MyOc3WGr8NJz1B2F2CVIUJJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XLOzpcrJL8WELhm2e3CZQp8Bn7/sCxXTWC7PbYP3RuI=;
 b=kws28MecmoFhcgQIgjYcTJorqoX350COuyASkMiWyJFo9BV1asME3uRJMtQkarPvcpPLpGWlw9k3Q8qEQe4KCMwD882aOVzaMy2Rr1zpWmDQphOB9YbjgvwlFohPRG5Ax6b5dZEPngmkaORwQr8G1oiBLGYMwRPP+XJ+rb0+43FCS5dqm57DHPLsoegNNqbpqI1mEMDzh6PlnqNYBeed0AHCcrsK57d0nCw1GgSg4eDe68ga39pXcCL3I/wv85WcNt72MCgCV0+Sn0QrGV3ULoPEfHJZ+qZJ0wu93jRU2qcMbLBJTo+EXP4ToaM/PslpsxTLFxoD6o/a4VHdB5GxjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by PH0PR11MB5000.namprd11.prod.outlook.com (2603:10b6:510:41::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Thu, 19 Dec
 2024 09:17:18 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%4]) with mapi id 15.20.8272.005; Thu, 19 Dec 2024
 09:17:18 +0000
Message-ID: <0c6d6368-85ab-4112-a423-828a51b703e1@intel.com>
Date: Thu, 19 Dec 2024 10:17:13 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V3 04/11] net/mlx5: fs, add mlx5_fs_pool API
To: Tariq Toukan <tariqt@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Yevgeny Kliteynik <kliteyn@nvidia.com>, "David S.
 Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>
References: <20241218150949.1037752-1-tariqt@nvidia.com>
 <20241218150949.1037752-5-tariqt@nvidia.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20241218150949.1037752-5-tariqt@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI1P293CA0017.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::13) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|PH0PR11MB5000:EE_
X-MS-Office365-Filtering-Correlation-Id: c1966e55-88fb-43c1-2f08-08dd200defae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?b05jM0l3MWJNRHpweHVWOXlab0J2MDdpOEJRdktOSWpseU9ITUM2TnphYXV5?=
 =?utf-8?B?cERLUWp0M2hhNEMyUTF0aTE3SzB3a092WjRqTVRvbEFlUk93dmdWcGl2eUQr?=
 =?utf-8?B?c2lvNTBVczR4c2tJZG9YNGV2ME50QnZJemxweXJ6QndmVDVJQjVQYUZ5eWk4?=
 =?utf-8?B?ZzlPNFZnaDJlcWp3K1BYSnVmZzI5VEV3US91V2xFeExxNFk0Ymxwa0FqVGxS?=
 =?utf-8?B?MUhnTEErMTkyYUZmR1BrMml0eW5PTm1JZy80RGNoL0pnSk1lUGpucWF4ZHM4?=
 =?utf-8?B?M3VBRXNwMTcvc0lGQkd1ZFRCaWg2eXNhcjRTWUhvZThrQjdNQzFHK0E5NHBV?=
 =?utf-8?B?RzNodkNjNmZhTDA3YlhRamh6SXZmRlhmdE4rTmpXWFp5b00xNkFmZzllcUJV?=
 =?utf-8?B?MFdTYlk0Y2U5bTgxYytqNGZ6eHp2dDFIVHJRRlhwL2ZIOFVuR1Z3a1lnbUFL?=
 =?utf-8?B?QmVGU2Zmb2J2ZjFIUlZZN3E1V2JSS2lsb1N2Uk5XUjFhMHFKYU5qekRnbTVt?=
 =?utf-8?B?L1RuanhZbk5MSHRVcVdJMy9zSGhjMjE0YXJHQ21obDlaWUErbC9MUjNuaCtX?=
 =?utf-8?B?R0xDM21BRG1IWWdicE5zUnlJRHQ5cjhHTlZUNTBkWnFIU2wxYTY0UThwWUhF?=
 =?utf-8?B?ckxMamJLdkZxSlpLN1RQWHBVSllMdlhDTmx5b3hBbzhkelI0Vnl6S3NzSWdE?=
 =?utf-8?B?b05hL2NZTGxpNHlVR1JYaVRXRFVLTmJVK3E2NE41bThrTkxSQmxHdDFId01I?=
 =?utf-8?B?bzlTdExNMmlFSTFSalN4M3NzdnlEVEZqdXdSbU9FNXAzbWtFblg0Vkd1ZzFK?=
 =?utf-8?B?bll5dzFRSHVjOTVDTmNVTG1QSmx1OTE4bDJ1MHptMWdHYXh3SklVb3duRmpT?=
 =?utf-8?B?eDBjdEczNk1ybkNHUnZmdHExNzlUNGtzeVdFN01EalhCS2paNUhRM0taanVR?=
 =?utf-8?B?V3VqWDc4WTU3NTJlZENBTzY1M2tmTE5UZENHcmVPbmI0bjJRMUFML1Y5UkFV?=
 =?utf-8?B?M3pDWTlHZWszeExndFNxM3VtNkx2VVJDVHprWSs1VE1pMmpva3BtaHI2b3Fy?=
 =?utf-8?B?U1VRR2lnUzRLMUtaK3FUWFpkbjU1THpDUWdINUhLL055MzJiUXRBZHdhdHZq?=
 =?utf-8?B?UXo1OE9qUVVNazE5bG54NDZ5Y3JpZklHVDJEWG5KbXlLLzd1V3N0Ym1pcmZV?=
 =?utf-8?B?ZndacXBEZnFrYWFqYVpEL0QrdEtlS01DZjFxQmRkbWRRNjBmcFo5a3M2UnZK?=
 =?utf-8?B?aHNkR0VCWUlnVU4wQmE1K05Pd0dKNGpGQnRmNGNsVS9sT05oU2MzZDdwRFBT?=
 =?utf-8?B?UGdYV1lhOTc2cVZQcEpiVHQ5Vk1aOWEwOEkvaWorVVIzRUdoNnljR1doLzBs?=
 =?utf-8?B?R0M0WFY5dzREUkNuamorN09uQ1NQRjJ4THlqZW5Td20rclNtU1BKVUxVU0pZ?=
 =?utf-8?B?ZUtSZ2NqZExWWXhEVkNZVm4rTWd3M2RLWVozUSsyT25xa2EyNUozS0thcEtK?=
 =?utf-8?B?ZTlEMFh1VWVoQk1ZZXpLbUhiUTNWSkRrNkhVbkFNK1RLRUg2MVFqdnBXMXBv?=
 =?utf-8?B?aEthSU5RSnRDYWRkeTJMT3YrMGYzbEg5Z0wyNXN0SUg2MmphczNVdHl2Vld0?=
 =?utf-8?B?dnpreThZcmxlSnhHb0pkMHhEVm5wMFAvSHVkRW1KMjRNTHY4S2ppME5vRDll?=
 =?utf-8?B?MWhxdmhGZVJoOXRTOHlFMWQ2WGM3QlNmY2NYTjBvVTBXN29xWTk4YjZZY1NR?=
 =?utf-8?B?OTZnWTlWT25ZRWsxRStLSnUxYVI3ZnduMW9qMjQ3eUtuSjNaSUlqUFE1WVQy?=
 =?utf-8?B?dHovVkVHd205YWdQWW82d1Y4VlpaQjBzQm83K1VZRzZDaU5PcjZUMkRlNXN2?=
 =?utf-8?Q?BuTq2HQff6VIq?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rm9rRitMend5ZjhSTk4yaUNpclc3MHZ2cHphZkp6Q1hEUWlTSi9DU25XdnMx?=
 =?utf-8?B?a2lnRFpaaU5PT0Z2MjhXL3JBdGhWYTdlOG9jbUZ4RkxNaE9UUUhKdVlMK0Ro?=
 =?utf-8?B?SkM3dFhtN1NMQjhuK2taWm54L0d5RGhRcW5ubTh5S1Bkb0JNQmlsaTdiRGRI?=
 =?utf-8?B?K1U1Y1lFUHJzeVJhaWpLUm9FN1VjVFhWYjdpQ0hZdUJHNzd4MWowVkJwTzMv?=
 =?utf-8?B?Qkc1b01TRWZnN2xxR1hpWS81WU1MV0k1TjdTWkJpcGFPTmxXYzF1R3FnQnZt?=
 =?utf-8?B?SkxEMnF3TURqRGlucXNtT2FabjdvZmNUWDhncjd3NHZnbDE2QlVWd2tmSDdL?=
 =?utf-8?B?Z0hwck5JOU1SUGJ6L2Y0bDRxMUEzQlFzTzlsaFNtNFFxbVUyRGRLZnYzMjlx?=
 =?utf-8?B?UzlkUVUvQktlNjRaeVNFNG9PbUIrZ2N3YUpUTjFDUlArK3NMSFhocy9URk9a?=
 =?utf-8?B?YkZCRjZYYWZnSDkzc1dRZVhEY0MxOTlLWk9YbUg0NUVYeDFtYldrZldKbkc1?=
 =?utf-8?B?QTAwcTlabWkrMVUzdWsvcjRrUmh2UWFDOEJsclBhRU1oYWNyRS9HV0RBZUlJ?=
 =?utf-8?B?RkZIam5FT2wvWXJma1lxL1ZnTHZyYkRFcUE1TVoyVk82eWVDVXhTR2k1QjJR?=
 =?utf-8?B?Q093WEZXVFpLTFVLak5vcXFXV1JMVFpwSTBwajJ3aTQ3ZjNheHc2RUYzYlN2?=
 =?utf-8?B?U0IzRG0rNENYZ1J2VkVuSW9NdWhXSm54SWxEdVpIOWRUVmF5WU1FRUVCRy9l?=
 =?utf-8?B?WkxUZHJ4VFAyeUVJVXA3YmZxNllPdkJIL3RhTFNIbGc2SXc2M29hdVdsZTBm?=
 =?utf-8?B?eENCWDJYVGlOVHhVWUpjWHp0cXJsRU9zV0JTVHBRU0lkUURWc3BTU2dvYnhD?=
 =?utf-8?B?cEF2Tm5DbjlINkMyMkwxdm02bVVBQ0hwWGxoVUFMaWpQbkppNTQ2bWsxdG9H?=
 =?utf-8?B?TkRQN3UxQnRQVXNRVHVodEpOcEFrWld3TmtCS1FFR25lZEFNckFvblUxSERK?=
 =?utf-8?B?clNCVjA1dU9WNTRkK1hSQzFmSU1zYjJTNWtGakxSc0RMdmRVZFlqTmdyRjJ1?=
 =?utf-8?B?Smxzb2RLSzBWdkMwenlWbW91RWFFNDZxalAyTVRMeFR2S3dEVUM0NTZ0VGYr?=
 =?utf-8?B?cnNod2hXVTgvVlF3OGlhdlVaWnJsWURTMm9WRk9Gc1Q4aXpCRkIrODFxQjNK?=
 =?utf-8?B?WWRxK3RFRklmQUxaUkp2Uk9oMUhwNDNMY2V4c0c4Y21HUXBWQTZIU0NGajZm?=
 =?utf-8?B?RkpiK0d4cTM1citUVDBBUlpPM2sxeVR3SkNhcTRWQ1NBdUV3a2NkUm1JNTdz?=
 =?utf-8?B?KzBkRWU1RG80TGQydkdpUGxaT0c4Y09CU3VZU2pyWCtPSS9jejhLdEFTZ0pZ?=
 =?utf-8?B?WWc4czUyRjM4Rzg5T0ZTSnBWS3VHUG8rdlIzaGo4M1kwd1ZVUTlVZ2NLVXVm?=
 =?utf-8?B?WUtVbEV6OU1KZkF5cFRZSDlLc3Q0cHZSMmlJN0NrbGttQnJYTzZ5RG1saXJ1?=
 =?utf-8?B?RGpqUkpRY3dQWUJIc29adStwNVZNNWRXb2VwVUNZLzNTbGhKc21aYzRQczFN?=
 =?utf-8?B?T3QvVEtRQzVHS2JKMUxsdHdPMSt1Y3NabUE2Ym1NRThjNk1TSGNkOFpvTWd6?=
 =?utf-8?B?cmoyZzE0VnhRbEljV0V4bHFkOWNoVHZCYTVHbm0rNEFTdndlanJtSGx3YnZO?=
 =?utf-8?B?YWx0WENOeHY3a0FUWWVVdUtLS2RFNlRHT0RibTliaUtnSi9kNVRLaW90am42?=
 =?utf-8?B?T1hKNDJaalpTT01YN3pMcllqSVpHNldwbHhEZU1YZDA3bTZrc3Vha0o4UDBn?=
 =?utf-8?B?Y3ZwcVVhMXpUOER0TjNZTlJrbE1wbHJxanhFQ1EvM2ttMWFBaWdPUE5HRHNH?=
 =?utf-8?B?NHZKcEtUSUZiMFZZVGdzajVabE94Z0NiZHIrVUsrQmRMeGNsQ2FHUHNGVUh1?=
 =?utf-8?B?alE3SzhyZWYrY0dDZnVaSHBucDZORFNGeGdUekJTMGQ5WTh0eUVzTlc3ZG14?=
 =?utf-8?B?NTg0ZXR6QWkxRzEvNnR0alR3Yzl3WGZZL0g5UzhVZkpWbFhsME5pbG5Gd09i?=
 =?utf-8?B?Z0lWMUVldlZ4SVVtalRaRmVRTmZCcklYTjhwVjAybWg3N1JJaGRiVE9WY0xz?=
 =?utf-8?B?VnNOeFZFY0dFQ3ZDZTNLTjU1WFF5VHloTzNydVpXOFE1MUlKT2JjWTMwVkc2?=
 =?utf-8?B?V3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c1966e55-88fb-43c1-2f08-08dd200defae
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2024 09:17:18.5340
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XRSGiJpgsriYlEZCAQMOcc91kz68GOgHGM9iukrvMIH7eJwazX23XEohzCAzP0tr6f573UBzFRQVSWS4zr8ZWhnAid+FQ2uDumXvv8PY1Po=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5000
X-OriginatorOrg: intel.com

On 12/18/24 16:09, Tariq Toukan wrote:
> From: Moshe Shemesh <moshe@nvidia.com>
> 
> Refactor fc_pool API to create generic fs_pool API, as HW steering has
> more flow steering elements which can take advantage of the same pool of
> bulks API. Change fs_counters code to use the fs_pool API.
> 
> Note, removed __counted_by from struct mlx5_fc_bulk as bulk_len is now
> inner struct member. It will be added back once __counted_by can support
> inner struct members.
> 
> Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
> Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
> Reviewed-by: Mark Bloch <mbloch@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>   .../net/ethernet/mellanox/mlx5/core/Makefile  |   2 +-
>   .../ethernet/mellanox/mlx5/core/fs_counters.c | 294 +++++-------------
>   .../net/ethernet/mellanox/mlx5/core/fs_pool.c | 194 ++++++++++++
>   .../net/ethernet/mellanox/mlx5/core/fs_pool.h |  54 ++++
>   4 files changed, 331 insertions(+), 213 deletions(-)
>   create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/fs_pool.c
>   create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/fs_pool.h
> 

[...]

> +static struct mlx5_fs_bulk *mlx5_fc_bulk_create(struct mlx5_core_dev *dev)
>   {
>   	enum mlx5_fc_bulk_alloc_bitmask alloc_bitmask;
> -	struct mlx5_fc_bulk *bulk;
> -	int err = -ENOMEM;
> +	struct mlx5_fc_bulk *fc_bulk;
>   	int bulk_len;
>   	u32 base_id;
>   	int i;
> @@ -478,71 +460,97 @@ static struct mlx5_fc_bulk *mlx5_fc_bulk_create(struct mlx5_core_dev *dev)
>   	alloc_bitmask = MLX5_CAP_GEN(dev, flow_counter_bulk_alloc);
>   	bulk_len = alloc_bitmask > 0 ? MLX5_FC_BULK_NUM_FCS(alloc_bitmask) : 1;
>   
> -	bulk = kvzalloc(struct_size(bulk, fcs, bulk_len), GFP_KERNEL);
> -	if (!bulk)
> -		goto err_alloc_bulk;
> +	fc_bulk = kvzalloc(struct_size(fc_bulk, fcs, bulk_len), GFP_KERNEL);
> +	if (!fc_bulk)
> +		return NULL;
>   
> -	bulk->bitmask = kvcalloc(BITS_TO_LONGS(bulk_len), sizeof(unsigned long),
> -				 GFP_KERNEL);
> -	if (!bulk->bitmask)
> -		goto err_alloc_bitmask;
> +	if (mlx5_fs_bulk_init(dev, &fc_bulk->fs_bulk, bulk_len))
> +		goto err_fs_bulk_init;

Locally (say two lines above) your label name is obvious.
But please imagine it in the context of whole function, it is much
better to name labels after what they jump to (instead of what they
jump from). It is not only easier to reason about, but also more
future proof. I think Simon would agree.
I'm fine with keeping existing code as-is, but for new code, it's
always better to write it up to the best practices known.

>   
> -	err = mlx5_cmd_fc_bulk_alloc(dev, alloc_bitmask, &base_id);
> -	if (err)
> -		goto err_mlx5_cmd_bulk_alloc;
> +	if (mlx5_cmd_fc_bulk_alloc(dev, alloc_bitmask, &base_id))
> +		goto err_cmd_bulk_alloc;
> +	fc_bulk->base_id = base_id;
> +	for (i = 0; i < bulk_len; i++)
> +		mlx5_fc_init(&fc_bulk->fcs[i], fc_bulk, base_id + i);
>   
> -	bulk->base_id = base_id;
> -	bulk->bulk_len = bulk_len;
> -	for (i = 0; i < bulk_len; i++) {
> -		mlx5_fc_init(&bulk->fcs[i], bulk, base_id + i);
> -		set_bit(i, bulk->bitmask);
> -	}
> +	return &fc_bulk->fs_bulk;
>   
> -	return bulk;
> -
> -err_mlx5_cmd_bulk_alloc:
> -	kvfree(bulk->bitmask);
> -err_alloc_bitmask:
> -	kvfree(bulk);
> -err_alloc_bulk:
> -	return ERR_PTR(err);
> +err_cmd_bulk_alloc:

fs_bulk_cleanup:

> +	mlx5_fs_bulk_cleanup(&fc_bulk->fs_bulk);
> +err_fs_bulk_init:

fs_bulk_free:

> +	kvfree(fc_bulk);
> +	return NULL;
>   }

[...]

> @@ -558,22 +566,22 @@ static int mlx5_fc_bulk_release_fc(struct mlx5_fc_bulk *bulk, struct mlx5_fc *fc
>   struct mlx5_fc *
>   mlx5_fc_local_create(u32 counter_id, u32 offset, u32 bulk_size)
>   {
> -	struct mlx5_fc_bulk *bulk;
> +	struct mlx5_fc_bulk *fc_bulk;

there is really no need to rename this variable in this patch
either drop the rename or name it like that in prev patch

#avoid-trashing

>   	struct mlx5_fc *counter;
>   
>   	counter = kzalloc(sizeof(*counter), GFP_KERNEL);
>   	if (!counter)
>   		return ERR_PTR(-ENOMEM);
> -	bulk = kzalloc(sizeof(*bulk), GFP_KERNEL);
> -	if (!bulk) {
> +	fc_bulk = kzalloc(sizeof(*fc_bulk), GFP_KERNEL);
> +	if (!fc_bulk) {
>   		kfree(counter);
>   		return ERR_PTR(-ENOMEM);
>   	}
>   
>   	counter->type = MLX5_FC_TYPE_LOCAL;
>   	counter->id = counter_id;
> -	bulk->base_id = counter_id - offset;
> -	bulk->bulk_len = bulk_size;
> +	fc_bulk->base_id = counter_id - offset;
> +	fc_bulk->fs_bulk.bulk_len = bulk_size;
>   	return counter;
>   }
>   EXPORT_SYMBOL(mlx5_fc_local_create);


