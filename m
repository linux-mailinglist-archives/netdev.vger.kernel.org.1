Return-Path: <netdev+bounces-153306-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D169F7924
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 11:04:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBDA3169623
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 10:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6144B221DB1;
	Thu, 19 Dec 2024 10:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A3zWolAg"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1329A222565
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 10:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734602637; cv=fail; b=qmkFD1PIJT8HHq4wgwp43wPmd9zXG5zHzCz9ZgbDmUxecAaRxO6Zlg851UQeQL/yBUm66JOUvHlBM5qsTldqqnopxQvRTd9n8UYWoKnoD+SGgpZOYubzKp2q5CkwxR4gMB5nQQ8M5ePU25iNFYCAZMOH3c+bXBkrJ3ZIgJzEcso=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734602637; c=relaxed/simple;
	bh=FNNTQtgzs1tJb9p6r+jrhffmHvvvvQOlVwT/f8T+hrc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=A5QEynIoJqm6aTsoUCMenkHmwtxyEGm+aV3UyGkPwjBlNQIn3hhy2POpW8E4nIhMw0Oauipl+GNabAhMJju7HHL6Seqk2azHjybnoenmUAutQ8hJGdQOgiwLn2TAAxILay+MU723lPiy1Xi8hUgBGA+JMyBrr6mLRnjJ4sxRv3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A3zWolAg; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734602635; x=1766138635;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=FNNTQtgzs1tJb9p6r+jrhffmHvvvvQOlVwT/f8T+hrc=;
  b=A3zWolAgU7NKTKxsAjsBddIZC4Daiye3EGRjO3lMffs8OU0Altv2Wwre
   MlUZDdlMi2h8qBAUDh4d+ouhd7xTInVSYAphsuVlAIgfB4wS/dwq03R5K
   hd5I5kSpz4Ti8qIulCzXIhG0w6R4JK3r2c46kn6+c9o3zRuGvH3dw2qGz
   xlqks5ERvtH3dWh+eqbwHOfjzP3RFxhAhKBX+jQaAeMPV69tE8NfAEBZx
   x5FDAKundBOeeDbS12VWAt3H+5gxovePc8smiI1DqesZyxCvWv/R16FQv
   PoUchdputBsTjtzHS88blepa0LJVrD5t/Emv21l/YNo5m3UWIYYOCHOMt
   w==;
X-CSE-ConnectionGUID: Hdw+9Qr/Sfa6/E6kCnGOyw==
X-CSE-MsgGUID: BraXOhYLTEWbvHnBIiV0EQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11290"; a="22695489"
X-IronPort-AV: E=Sophos;i="6.12,247,1728975600"; 
   d="scan'208";a="22695489"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2024 02:03:54 -0800
X-CSE-ConnectionGUID: 3afeb7zKT12UlOcUHdC+Jg==
X-CSE-MsgGUID: 7Mz/1OtETn+4Bs8r6utU8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="97979175"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Dec 2024 02:03:54 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 19 Dec 2024 02:03:53 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 19 Dec 2024 02:03:53 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 19 Dec 2024 02:03:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dBuq4sm7Hu79mBfEzSVhcbLKYHepg5wtVMnUqAyUKo5O7/SS6RqMbANgYCHKcBTQKjZF+UzDGQl9a1PbT4JpgeUEC4QlJrgwrCacPSAnP7oQV52GV+uJ7uuiLe+OSOUH4loumdzUV//Gfx74Y56fTIDg+La1zWcfG17JlLdwDGgunpqDjiPV0JLy4htsmdcKv7wfoqnhkqi+4QGcB+4ydre0PeUtHTzi3EdYrTf8nHglZOdtpyhKh4CnLUJS/AB2NMtPaD0NkGYjMDN3UunEunFEBiD05I8ZgXkJHF937K/M8ZWTwbjjjQVYWrFtpk381bkPjk0ssaYeaiy1MLzw4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GcMU7+Dwpdfy/PpHlxbf30iIvoXiqe8qwvMMS+y8DCA=;
 b=Rox0288pD8aBBH4MU3xjSzfqg6W6MkpCn8NjUHNaWw9aAeLJPTjT7SOPYN4WkapetDXgunj4MHx7caZWcLajR6rJNkhdr0P4hmZCpUvWcLhN5WNqfEI+VfYW9uapRoeQiFyCCfWvDKVLvdlF02d93oH/1Ru/8s5iMZWTdSB7J52UaPxKkQfcTWBl7daTXvEho4vqqis1OWJD0Gg3vHYAyux3trVW0s/UwFDKPYRtmBKxrW+/hxTtPc0WRQDkVQwXNG7Fp6wjHP8869KQ3P12p+sdn+Ww7Z4LPX02FvOrxNe/WqXtjFXF3YCbtB9ex6okaYUypuZsFH/KPXMeAa8wBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by SA1PR11MB8277.namprd11.prod.outlook.com (2603:10b6:806:25a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Thu, 19 Dec
 2024 10:03:37 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%4]) with mapi id 15.20.8272.005; Thu, 19 Dec 2024
 10:03:37 +0000
Message-ID: <5c2e8b25-3987-4d8b-a7ac-e756cc60e2d8@intel.com>
Date: Thu, 19 Dec 2024 11:03:30 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V3 05/11] net/mlx5: fs, retry insertion to hash
 table on EBUSY
To: Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, "David S. Miller"
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>
References: <20241218150949.1037752-1-tariqt@nvidia.com>
 <20241218150949.1037752-6-tariqt@nvidia.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20241218150949.1037752-6-tariqt@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0102CA0076.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::17) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|SA1PR11MB8277:EE_
X-MS-Office365-Filtering-Correlation-Id: 6908256f-0ee3-4f7a-13b0-08dd201467f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QVgwcWNLTEIzVU42eHJ1cmMzTFFjNXpkaTI0SVh5eHVmUnR0cDEzT09EcjF1?=
 =?utf-8?B?MWZuVU5ZWkIxcUMvUFc0VjM5MldOSTk1d3RvTFFoL29UaGFtNHVSSGVJVmNS?=
 =?utf-8?B?eEt4dm91Um9JRWQ1MGhFUDhCNmlZcE9McXJYcXM2RmFzcmZSQ0tnM1ZKdDVs?=
 =?utf-8?B?MVk0Z3hORjBFeDgyTkNyOUZyd0p4a3hrK1ZjcGI2bERSc2N1N3hGZzV0bG5z?=
 =?utf-8?B?UllDSlpNZXZNSmxpWDR5Z0lLRTFoS0lSUWVqdG1IelMreHBMem90bXB0bmVx?=
 =?utf-8?B?aEVOZ2xsTzJ0VTVob3F2TlZGZmxTa0JKWTljcnlqTVVpSkRMZHFlQ0JVN0Uv?=
 =?utf-8?B?cEw4bWwxd2xxT3FVcE14eENjNkJWalYwRnFaMElRT3ZsQm9UM0g4d0Z2NGxM?=
 =?utf-8?B?bkI3dU5kdzU0Sk5GUmZyYkFSUW4wNnBPODF4SUljZElNRlBqYjB5UHU0dlQz?=
 =?utf-8?B?anBlVGFxV2xwVm93aE1sZFVyRE11MHR4UVZsb2hscWJJQkpzdUEzS29QVkNu?=
 =?utf-8?B?amF2dkp4cE5sVzViV2FwcVo4ZmtETG41THVMTk95dFlYOWY1U0tBRmkvYzUz?=
 =?utf-8?B?Qk9aYy9SS293ams4cklqeXM5M3hwY3Mvblo4L2x5UUEyVzZ1ZjRjN0ZLQm0v?=
 =?utf-8?B?ME9wckZFRDRDNXBVUHppZUZ2b1hFTDRjOGxsYzdBanpDNStITGVnam5iN2xT?=
 =?utf-8?B?V0tVdWZTbHUyMFc4cXUvUFFsKzRkelJYZkhoT2h1anZpdHRxTTQyWm0zaXZi?=
 =?utf-8?B?UU9DMnhWMS8wUmNQS1pYempoYUlreDN0MEcvekd0TXZaaUpoWE5nVjZMNjZ6?=
 =?utf-8?B?Z1QxMlVQSzllRGVNYU9HQmRQd1gzOXdaNjRaekRPOThoNGN3NnFJakhKYkNi?=
 =?utf-8?B?aThqUDBCOFV0akdyaFpJUFduSDNrQUJ5dzNkc08vTlhyYy82RVp3N0FhSnhl?=
 =?utf-8?B?UW9xckRUK3loL1pEdWlpQmp1K04yTXVGdktoRHpuRXhreTR2OENLVzhzaDl6?=
 =?utf-8?B?Q1JsdzhDblc0R3B4Wm1HR0pjeEsweGtjbkI5QlN3WkRPWWl6RnZWN2xKcWJk?=
 =?utf-8?B?LzJ2T3pBRlB3VGhja1ZRYXNGUGt0SitSajhpVTZER0ZNdElqQ0Z3Q040MWVl?=
 =?utf-8?B?QW9UT0g3c0puVDZ6L1M3Y0szZmJ1RmhlU2lOMFVoZ2E5Y3VocGZkS3JWR1dC?=
 =?utf-8?B?L1JXOHVwREx2UVR2UC9iUVZFbUhjNW1YUzNoRFNWWU4yK1Ztc3ZudGpVNlZ0?=
 =?utf-8?B?bjd1M2JBTEdTZklhMGR4am5peUsvUmpxMitmWVVjVGw3c0VQRUx2cXVQclRj?=
 =?utf-8?B?REJnUG1QMy9PY3NsUHNmVHA4WlpUUHFSYjB5a3VvV3B3QzNKK3hWZElqNkxP?=
 =?utf-8?B?ejBiODRuZ1pTeUVVRExPN0trN3lGbVpCRHlUMUgyUEs0Rk9HcWdPUXUzVDNJ?=
 =?utf-8?B?QVFDcnVaV3FtZndkMmxQZVVHM2oxRmJNVDJpUGQ1SVY1eFJWRzM2MUsvU2x6?=
 =?utf-8?B?Nmxqdng3MVpOWHJaeEtUQ2VFUnFQSm4ybEhQZ3F3TTh0UkVnTEJwTjB2eXBr?=
 =?utf-8?B?RGZDL1ptV0Vlb254bnVzaWVNVjNzMFNtdkJuTXhhWThYaXY3b21SanhkcFRE?=
 =?utf-8?B?V0d5UGk4ZG9WaEw2NXlkQXNMWkp3RnZxY2h4dUZvY2hvd3JRMFpFUjNJZjR3?=
 =?utf-8?B?RXowaDczMTNDNXJaS3pBdTlpL0VLTUVPT1cxUXhnUzR4a3VBZ09VOTBPRFJM?=
 =?utf-8?B?dm9LZkhDSjN4aGY1c2RvUEJuaHF5N1FMajRyVnErLzlmQkozVHg0bFRCVDk4?=
 =?utf-8?B?UGI2bGFoWDFOeVBnYVpxamtIM1JKM3F4WXdka3FPRllac0p5c0xsVXJMbTI5?=
 =?utf-8?Q?Pv1dbTGHNR/nx?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SWFJMEJCZXFkNllrUGkrVHo2TjhSY1pxRWVKYitOU1A4MHVlMjFBL3g5V0NV?=
 =?utf-8?B?ZXVuei9yUUFxZHlaS0Fnc2tKZGIvVDg5VlNxWFI0bVQ3cHdsMEhCVWx2VHUz?=
 =?utf-8?B?M3FPOURVQU5iUG5vQkRETFo1OERBTXR0RzhJTjVQaXBUaHQvN2Fqdm1pVW0v?=
 =?utf-8?B?eDhlSzNvZ1FzY29GdW5RdGRpMlN4OEpjeEdiakJyZzJjMGo0OUlPY1k3VENz?=
 =?utf-8?B?YjdDbjMzZktnODJncnFQYkd4QVl6UkxmZmVDeWlCUFlVV3FVOS95VVl1anhL?=
 =?utf-8?B?Y2h2ZENYUTFPKys0ZTNHdWFuYzRwSHk3ZzcxSnZlUzNEYzB0UGhUeHkrZVp5?=
 =?utf-8?B?eWEvaGRFdlkrNjZvNTMxbzJJajJBa2F3VDRmTFNrQ1BVbk5Va04xNEV6NEhV?=
 =?utf-8?B?Q0JVQ1hRQkIrbXpFeitDeEw1RE8raEtpZi9nZkZsaFhMcFQyZlEwR2E5QVBT?=
 =?utf-8?B?M0NmVmVxcW1ab2xsN2V0Z2pZQVRpVHJVUDRab3pqYXN4eG1SSE1mUXg0OUtO?=
 =?utf-8?B?SlVZWVdadW5xUVpqdnRTY2lmeDFkZjFUWTVjM3NaU2k4bHBXdzBva3RzbG45?=
 =?utf-8?B?V1hkVzNZSXRnZnQ1djFqWk5kZ3pIeXROOEJjbzF3UitFZDZlYWhKOWJVZGNs?=
 =?utf-8?B?c3lmK2NnbnQ3ckJEWmx6ZkRTVld3YmFHMWVkWjNqLzVzZ1Q3QUdPd1NrNFkv?=
 =?utf-8?B?aGduSGlxelN1akVBU1JYVFZGV3VkRUlBSk5UaWx0V0ZOekE3YXRmazFrWmNF?=
 =?utf-8?B?RC9zbHVhZEZiNk1vSVBPNHJOSkNJVnJCWDZWYzJPZyt4KzUvYUtOSE1pT25s?=
 =?utf-8?B?UDkyRndQdThkVVFuWTlQNXhrbWpQNTl5SjVHMXlxLzNGRjI5SW5vOE16b3lj?=
 =?utf-8?B?Vk42ek1pMHZlTDRCZkFOR0VnN0NJK3Y0eHJ0SDBGa25qbVpGOUtLMUVERjhB?=
 =?utf-8?B?ZjFJZWlIMUpucXpmb05mdVNYNlUxTW9tVVdzaVZ5L1lUV3RlV3FtbXppOG0z?=
 =?utf-8?B?VGwzcVZmeXJGbkxLaHdROEwwNXg4ZnVJR1FpdVVJZWFmdnJPNWRXNDRhRGRG?=
 =?utf-8?B?b0xjQ1FuSTMvNDJXSW5ha3lGN0Z2MFB5enAyeUxONGhLcDlvNDdlZ1lkZjhL?=
 =?utf-8?B?Z0FHWVRrTUY1R2ZXbzNEcE5MajBxSXltNHdlVGJXRWcyTWZ6UkRLdmtmT283?=
 =?utf-8?B?eEx2RTQvbEdUQjQxbkpIb1NIMENjK1doUUVJSGNHTVlkQWNiNlcxL1o3NlI3?=
 =?utf-8?B?ek5iSHovZGRYdk5GeVBjSUtpQ3I2Tm5LRTh6ZzdsUzRDTTM0dFZKd1NrYkM0?=
 =?utf-8?B?ZkNoZ05YWWRtSUo3MWlaaVk3M0MrRjRocVNjYVFnby81Mm1uVG1GRGJ5NkpX?=
 =?utf-8?B?Y0EyNUY3NUlFT2FuWUxObGJKbFlNeFlIRUM4WTgxQVFISEtxMWZRb3ZWVVVU?=
 =?utf-8?B?N0xJMGh1ejVsL3dPSVphRkZPY3kydTk2eHhVb285bENwVXlFczJjbEtqVmVT?=
 =?utf-8?B?ZTNKOGVqYkhEU1ByazhaSWl5V0xYQWdpdWtjRHJ4YWZ0OVg2WkdwUVZzdWF5?=
 =?utf-8?B?Y2M2SW5qUTVMZTQwQWVDOFRNeFgrZTVjR2xBQlczL2R0dTN6NU95M2hLQ2xI?=
 =?utf-8?B?MHZKSWw2NEozREdIK2lFQWM5L0ZwdDk0TVVRQno0ZG9DQmJpYmRESlpWVHd2?=
 =?utf-8?B?RWkyeEdEaGRMREI1Smg2WXd1WkY5OVNQUDlHZHpITm1kUWFtelBGRkk1VUsw?=
 =?utf-8?B?bTdLRHUvayt6MVdDT0tldnpzbVVBNmxvWUdUK1h0V2Z1M2tVUDI0TG5BSm5w?=
 =?utf-8?B?UzU4Qm5ZMEptUmVQZFZWMG4vd3VjODBFRFBPTVJ3VDdMalpyUlpVKzFoSzJD?=
 =?utf-8?B?bVBmamRUNVQzQjhmdUcvdy9HT3ZJK3IwTC84eXRGa0d4d05LZTZPTm9hbnBL?=
 =?utf-8?B?YmFmN3ZWM0pxQmMvNzBneTg1QVhNYmlqc2ozTzJBVlc1UUpHOHI0a2dvQWtm?=
 =?utf-8?B?UjFYQWVHUlFraXhMMnBXUXJCMU9qOTRjWmMwQlZIYkZBTjlJYmVZQ1I1U1Q0?=
 =?utf-8?B?WkZUcHBzR25VRUthT0FoN2I0VjFCUU1KUGFDNytXTDhmRncrRGJ4SHRuT2I5?=
 =?utf-8?B?eFZnSXAzZndOSXJVUTN6UWZNbDJyd1FWdEQzWG9wNkl0d3k5enpJYm9PMnlE?=
 =?utf-8?B?eHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6908256f-0ee3-4f7a-13b0-08dd201467f2
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2024 10:03:37.4117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tdrShT3MkBnz7UFDyC3CqRdC1nmJOo9PIMtvXiME2avnV7C7RhHZ+VYamixD2syQ2Z0+cxSMRptDHjOWljiw5HzHWreMm3jwQM+padLol4k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8277
X-OriginatorOrg: intel.com

On 12/18/24 16:09, Tariq Toukan wrote:
> From: Mark Bloch <mbloch@nvidia.com>
> 
> When inserting into an rhashtable faster than it can grow, an -EBUSY error
> may be encountered. Modify the insertion logic to retry on -EBUSY until
> either a successful insertion or a genuine error is returned.
> 
> Signed-off-by: Mark Bloch <mbloch@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>   drivers/net/ethernet/mellanox/mlx5/core/fs_core.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
> index f781f8f169b9..ae1a5705b26d 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
> @@ -821,11 +821,17 @@ static int insert_fte(struct mlx5_flow_group *fg, struct fs_fte *fte)
>   		return index;
>   
>   	fte->index = index + fg->start_index;
> +retry_insert:
>   	ret = rhashtable_insert_fast(&fg->ftes_hash,
>   				     &fte->hash,
>   				     rhash_fte);
> -	if (ret)
> +	if (ret) {
> +		if (ret == -EBUSY) {
> +			cond_resched();
> +			goto retry_insert;
> +		}
>   		goto err_ida_remove;
> +	}
>   
>   	tree_add_node(&fte->node, &fg->node);
>   	list_add_tail(&fte->node.list, &fg->node.children);

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

