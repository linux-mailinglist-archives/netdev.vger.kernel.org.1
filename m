Return-Path: <netdev+bounces-122959-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A72B3963499
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 00:21:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC2551C216F7
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 22:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFFF81A76B9;
	Wed, 28 Aug 2024 22:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nY0Pr2fM"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E883214A4D4
	for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 22:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724883666; cv=fail; b=DCQkh/1g/x8trJMxfklfbbvVkwqAMRjEuCtjIhnPOUH4R14syzAcUGECkrB1mbtlNkyKJTm/+InzDQdf4gQGvqE6dAc/4Kofsu3zmX7sjYdKaMcdf6hwV2ZmGnYX+mGx+OrJV/7GvK1SbM32W7mhQGrcSdyfjRJkETAyv50g2y0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724883666; c=relaxed/simple;
	bh=Rx6eTp4Nd7oyzimxULo5eHQfGRzQ5fkE9I6wARUNguw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eGvsbL1/Qqd18DpPJET8OlL6ClRbahuSg0ZJefwJomCaNnV+Tg59tGbJ+bUeJZztzLjajXkGgyTNtIxB0wOyoweVDf3d8Rh8hrYUKUxpAfx/NC69/2VUFezEjNWZFUYqF9oo+5FXqiPzM+044Sn6lkCKxzn8agXcIvme36ri5s0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nY0Pr2fM; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724883666; x=1756419666;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Rx6eTp4Nd7oyzimxULo5eHQfGRzQ5fkE9I6wARUNguw=;
  b=nY0Pr2fMBrVdg8icYF82Zcg7jpRPaGS5FZzpDw5M7W5zCGRLeheKDmS0
   gdX7pr8lSzgkTDYACxy/fE5Xs1+BQKRe1rbqgBSIO1H1dwMOT5WYZ9MX2
   Qq8PenCGUQbUy2DZDEz0p5t9LcvD5zTSGO1ILz5J59zZx/zk1a7+SyS2t
   EIsobGWEuAdzyemfjlBbcLxuoT5w2hGuzC1ZTqyoGWxwYAtr5Nro+6O4s
   9gb5AICmAL0qOWKOgGo5YPiL5AKtaitzwP4B+53hTnUNU8RvcI+NvwNu0
   4o9F1vyjxpY73TD4XmJXEbDHYApLjc8YEveSZP4lu2AQ4nqXgR6gNppmL
   g==;
X-CSE-ConnectionGUID: uJiPWsPjTpuI5vpQGT3sFQ==
X-CSE-MsgGUID: lg/wZ+04ShmSazXAGQYpQA==
X-IronPort-AV: E=McAfee;i="6700,10204,11178"; a="23405821"
X-IronPort-AV: E=Sophos;i="6.10,184,1719903600"; 
   d="scan'208";a="23405821"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 15:21:00 -0700
X-CSE-ConnectionGUID: sIkwijpMT3KxHqv3Qqnz/g==
X-CSE-MsgGUID: C4YXqSsdTtyVULm+diXqXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,184,1719903600"; 
   d="scan'208";a="68271161"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Aug 2024 15:20:59 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 28 Aug 2024 15:20:58 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 28 Aug 2024 15:20:58 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 28 Aug 2024 15:20:58 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 28 Aug 2024 15:20:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vdeKLsAhlbFX+vC9T0Wak5xiva+0cYgMf5MSlHDnCgp/dNPvWfSvTEGiY+6kWJFi/xSjoRtG89CKXPqZmwg4+2EDeAQNXkMxRSGkR3YkfCKQ58oHu/IMvsjnTfrDs/l/uLSPQ0rzXI1XBDhfMpGX59TRq0Ycr+8W7pD5FLoz1syzmZSu354fZR9BjPK2dM5ZKCYARrQgLwkK0WPvG6gJ0nOgmR8WCF1qMYhH84mWt0kWCalu5VjPU2VwbeK7MCHzLHEHTam7QBlH91QtuIUWeskCqRq8ckCsp2ZNR+TArULRqguEh3PViLxzWTFiwqqyfMkkgWxQS3MZDl9zi5QcDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HqrwtR/ssHeT8Qbd942cZIZElA/3uSKWp01Ljp3XOu8=;
 b=QU64CCj1nT9HNw+zrk/ZvhbMl1B7zIz0xZyC+iUK3t5fBuyMc9rBcGDl89rgCn+fV2i0gpDzmWZMg40ZZlbZCGxPftq/ynOQbwrn5EfBT2lMyVJmWF4aOf64UB0lPiUU84c7fM4bTNXDQZbPRPHgba35sDFKCcYvaLwQUirPFLeM52ddSzFx+T2uZr2Zp5X3D+fsJWbJ+tdC58TShW8BjaKqQ+gqT2ETlgQu2Iy/51Pm8nQPtLtRJIxX37KCYngDDTg9lM9F/T+i3wk1NjWbyc0Z5eBcIrC6ZAB0WCxOnwHi9aACyDCQazar2W2NLkIUADqAcFCIPsg+CPJlHwyUAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CO1PR11MB5186.namprd11.prod.outlook.com (2603:10b6:303:9b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.28; Wed, 28 Aug
 2024 22:20:55 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%2]) with mapi id 15.20.7897.021; Wed, 28 Aug 2024
 22:20:55 +0000
Message-ID: <d521cec8-a112-48b1-8368-f7ff406502fb@intel.com>
Date: Wed, 28 Aug 2024 15:20:53 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/6] sfc: implement basic per-queue stats
To: <edward.cree@amd.com>, <linux-net-drivers@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>
References: <cover.1724852597.git.ecree.xilinx@gmail.com>
 <54cf35ea0d5c0ec46e0717a6181daaa2419ca91e.1724852597.git.ecree.xilinx@gmail.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <54cf35ea0d5c0ec46e0717a6181daaa2419ca91e.1724852597.git.ecree.xilinx@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR05CA0001.namprd05.prod.outlook.com
 (2603:10b6:303:2b::6) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CO1PR11MB5186:EE_
X-MS-Office365-Filtering-Correlation-Id: 909a32a2-e67e-4675-332e-08dcc7afaf30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?dVA3UVd5QXFTU0hHRjkyb0R1MFo2bElRZkdERVRBZ2UzV2lWM0crRk1qTjNC?=
 =?utf-8?B?RFRQMmg4Q3dHMG0rWk1vYVB1eTNXMU9pUzV0eVlGVWhTallsc0l3TjZhSUg3?=
 =?utf-8?B?YUVjMTdUUndtTzBzK0tBdVFGWTl2QkdIdjhTampiVTFyT01BM3VFV2FOcWd0?=
 =?utf-8?B?bGR5Q3N5Q0RMMFNCWUlOVzFaTnZCR1BWMEt2Z1F6KzNpdmY5cFNCVUZ6MVBI?=
 =?utf-8?B?dVlmc0R4OEllcTl0Nk1tTGwzZ002TVZLSDJwdFM1RXFHM1BCaXpUQ3kvQWsz?=
 =?utf-8?B?ZWpGaVBtZHJzNk85d3RqMk81bzJWQTJmVkhJdWtRT1FJMzF2MG8yWDF1cXVW?=
 =?utf-8?B?a0pXa1BjcmpwOUdYSC90aFBDbzVUMDBsVVE0V2JwaFVXMmIyU0NNMzBjcEZl?=
 =?utf-8?B?L09PTFN3WE5OTTJkNmV3c213dGZuK2FaZnRCbDJOd0xVTmRjMEhueWdXa1pT?=
 =?utf-8?B?OU11dFNzUVJpTWlKbzV6aFZ5K05mM2sveHNoUG1oNm5QMTRvQUd2THJNdVgv?=
 =?utf-8?B?ZWE0eUNLd0pLcGxXcjdGSU5RRnhEWnRvV1ZXT2ZNbWl1ODVFOFRBZUR0ckdz?=
 =?utf-8?B?bGUyV1AxU3UzUWJZamhMOTRoSEJDSUl2enhBZXNkM0s4U3ZMMXRoakJuNlpl?=
 =?utf-8?B?ZGpwMEh0bmwydEJ6ekl0VWpSYytqVU11TzAzN2l1VjdhNUNQenFrbEUzY0Ri?=
 =?utf-8?B?cTlZb1FFWnh0RDlWbTF4SzBENEl0VzNQY3RyRnFLV29YQ1VaTXZJN3RsNDg2?=
 =?utf-8?B?M1piN1NMT1o3N0xEMHBoRm9FcEZoTDg2YWU0TWtPVXRmOEFJRkNXTFU0SldD?=
 =?utf-8?B?c2VpcEp4YmxrU1NwT3lITGR1aGNGMVBKdW0yK1ZzU0tZbTFyeXFzaERLUlcw?=
 =?utf-8?B?b2JCUWVkZDF0SDVWVmdwQkhhVXpIRTUwNCtXakRFVncrNHV6MFhpcnVIUENh?=
 =?utf-8?B?dUFpbjlPTTFCU3hXMmg4N1ZmbEVjWUJFa1RZN0toYjYrZVRlb3ZPRUhDdHBZ?=
 =?utf-8?B?N3R0ZE5qN0xJSVhqUlBzRnh0enE1eFJoM0tVQ2p1bmFRQmQ0NDZFQ3B1a21o?=
 =?utf-8?B?Q3poREJVN2Z4MFNZSWFoM2xnd2hZSFZrejZXakV1NStFV1lMRk1rNTNEK0Nx?=
 =?utf-8?B?M3U4clNPZUdRZFNGUlBlRFcwRzZyS0FKK013Y3NsMktlV2JUWEpOTDZOUHlW?=
 =?utf-8?B?aktKL1Noc3p5Mjd3OWl0R2JBWWQwQ3c5bUpiL1hGQTJ0Zmc1R3JVVzJvaG5N?=
 =?utf-8?B?aGNwc1p0QTZZNmdNSnE5aldZQzRSK1VRRTRSeHNzUmdPM1dwUWJ5cmtWZTRq?=
 =?utf-8?B?L0kzSTJjaEJ2cFREd2RNQlBOVS9IL1ByZ0hReS9ZeFNlcE4zMjQyWHdNUUhL?=
 =?utf-8?B?SWlBcVZNQ1AzdjZSdGNkckZPQStqS2QrQ040Q1ZXdGZBa05iajhKOENIc2hx?=
 =?utf-8?B?b1lHRk5VN0ZnZGFzS1dZcGRjalNVcUpkUG9IMzlTdnNxSndhU0FIQ1MrZUdF?=
 =?utf-8?B?MnRyK3VLUHNZUjhIRVJsZzNxeGdyajl2Rks5V04zSHBKL1hlb3RBT0pGbXNB?=
 =?utf-8?B?dHVzMThIT0MzS29IRm9tSDNvL0l2VVk1amxTS3loMG4zdU1kMEJZOTV1YXRH?=
 =?utf-8?B?QkhLR2xHYWFXWmlpcWgyc0xLYThNV3VCeDVBWVM5TzU5Z3ZEZVRkcGFqRWE0?=
 =?utf-8?B?Tmx2a2swUjF2OE1ubjMwZ0tWRVZSVndld3FkeVdOL0NlK2FnL2pSSXhyL09q?=
 =?utf-8?B?dDVGcE5wdFR0aGQwblEvMjhRNWg3TW1yU1VsL1ZiQnFmUHVER1VzaUN4Nlc5?=
 =?utf-8?B?SG5EcTczSHozSWpXeXFBUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dVN1MnljeGw3bkZhVzhMQzBieXdXdmdNdGY0Vm9DUzBwbXdnbnl2bkdFamEv?=
 =?utf-8?B?S0REVUxyNEo4TC9EbUp4bEk4YTJ6bTlSQVY2RFBWRytPclIrMWUvQ1FtR0xE?=
 =?utf-8?B?dGxtQjBHbVpTOHVLM0RMY0haTkcvdWYwc0xhWVRUbk5LdHhmT0FoVFVwV1cr?=
 =?utf-8?B?WVVwMzJ3Z2N1RXVBT2tUWis1dktVbk0xRk1aQkMzL1ZIQ0hTSlVTbWtvT3ZK?=
 =?utf-8?B?R1ltQUprUjA1WGJzVVd4emFqRDBKWkVKNExCTEM0L3lnai9qbDVwdlZNWFdO?=
 =?utf-8?B?RmJXOERBZW9qdC8rR3NMNmNHcUVTTUh0T1hTdE5SZXlwWXRtbHdLNm5BUG1T?=
 =?utf-8?B?eHhvTGFxTUw5VUtHNkl3dExvYzVrRWRoTlVZbkVJalcxUkczMUs0T0FSZStk?=
 =?utf-8?B?bnp6cjJGUTVqSnUzZW4yRmlHR1RSSC9BeGhqN3BOUDVJVXM5dGR5VWdCOGZO?=
 =?utf-8?B?YWl2ZDRKeTQzMzM0bkZrRmNjVFFST0VrTDFZS2lseWN5dHZmczI2cVJnSVZZ?=
 =?utf-8?B?cmRDR3ozKzBqSGZ3OVNVQVNxcDlRSndkckoyRm4xSVdnSGpqL0NwYXlsT3lE?=
 =?utf-8?B?WEZlZFBZR1NnK01Nd0FWRGEwa25uUEw3a0RnMzF2Rk50QTQ4eTFUakhrdTVE?=
 =?utf-8?B?b0FUOEVuTGplU0U3UWNhVkhwZWZJUjVLWTFUM2k3UUlXOTFHM1hGb253Vk5H?=
 =?utf-8?B?NXZQTnk2NEthaEVuL2RjNHpVMk5FemV3MWo2M0FrNU5vTWVCQytxSktBbjJB?=
 =?utf-8?B?VkpXYVJvTURCSFp2T3lWYXk5SGdpUW9wSWlCekRRelZFVmNObk16Nk02R3lR?=
 =?utf-8?B?MDFDdmRaRmlyeUJLVk8yWlJJZTNNNG8zUGtWVE9oclVQcmZoWHcrdnZCL1Rp?=
 =?utf-8?B?dURkbHUwNUlzSHlFOHBsUXhZcTdncVVFcE8rU0dSQW0wdmdvU2NnOFVoeFBw?=
 =?utf-8?B?Q2JiQm9UNjdscGpGTEk1RnZqai8yaWtEM3lwMlg2Nm51SDJaclVFbG50R2ls?=
 =?utf-8?B?ZFV2WmlWVXVhRWovaDlLbVVIZHhoWU15Tjk0YU1BdlBtbTRrZ25aeWhHRGJG?=
 =?utf-8?B?OGI4RU5EVElOSlNvVkZrQUV1eElFOGtGckdwNWZtSVdsVTVKV0dSa0Q5OUVF?=
 =?utf-8?B?YTk4SG1GWjNUM1hSMVNkYnJlZ05LUzBBTFVjRHNaU0ZyQVBnL0I5ZmJZTkgw?=
 =?utf-8?B?Njg2QW8wWEJOdm1QV3NNSFVvRHB1NlhBSnk1bzlacUxHd3dSM1pLcnprRGEy?=
 =?utf-8?B?WjhLVHdMd1RDSFJpM0laV3IyZFlYSjZScGh3SlUxdWpMVzk1VWowTFJ5ZEh6?=
 =?utf-8?B?UnA0R0F3VGhTYisrZzZPUDlycHRRMFlUZlA5U1pzRmR0QzV6UXd4cnZ0OWtl?=
 =?utf-8?B?ZmlTQ1BxLzVZajhJQ3dTQmNSNEVueGVodUFuSEJnYWNPVmFQMTZtcVhsL3pO?=
 =?utf-8?B?Z3RITmZpaVM0cVJtQ0lQQ0ZBSy9vaEtDQkRndXlYZU82QWpQN0RxOVdhMUY0?=
 =?utf-8?B?K3lERENHZzcxTU50VVVFVzVDNXF0U1IrTjY1anFwTkFsVkQxKzdiUEhWY0Jx?=
 =?utf-8?B?cVdWTlRZVmRqanFnMWV3Y3ptZEhYemRyUERQWTJFVFZ0bnFJVDVuV2ZjVTNU?=
 =?utf-8?B?cE4vNFRPMDRyd0lBcldqRFBVVG84WktGdjJScDF2TkJsbm1XNFhyeHROUExW?=
 =?utf-8?B?MEVpbjdwNjZrTTB3dkZhL2FIc1A4b1lvTDJtbE1SUzVOaGhpdW5HK21VSWtr?=
 =?utf-8?B?aE4zYTE0WjlYd2RLaktybWNkZmNtQngvUEorOXRyM0xUdmh3T1U4ZWtnblhH?=
 =?utf-8?B?bWdmMHBzR2xSdmdxaGtTbHlTOEQrU3VDcUU0SnlwR1kvdVFiL3JPSG5McjlL?=
 =?utf-8?B?d0ZqdHZoUXEySGdoMWdpTlNuZ3YyZzl0VHltNHladDY5ZUROUnEzMVZ1R2tV?=
 =?utf-8?B?ZDBiZnJOcVRlUFEzQmlzbFlTejBQaG9tNmZhcjBrT29IOEtrcW84ZjhUR1Y0?=
 =?utf-8?B?eDNFNStzdkg2WjZaSG56ZDJZdjdpUUpobnVGUTl5THRBUXNqQ04ycEZ2Y0c2?=
 =?utf-8?B?WnBFQW54NS9SMURSdEhkZDVSS090bExCQWh2SGM0d0dySlpZNlhLQVJwM3dP?=
 =?utf-8?B?L0ZHMHJ4SUExdFc1V1lUeHZabERLWEc0R0tNZndHNnRzR05SNnFycVlCR2RI?=
 =?utf-8?B?Q1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 909a32a2-e67e-4675-332e-08dcc7afaf30
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 22:20:55.3461
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wJCoJ4DFmIcDQi9yrjUG6K+QsVrOUmJR3R16cHrp5x0GLZ0Q64FW/jJSsuadAwLvQJkbQq9habFl5Bbg8REacd8PSDCgQnPTmsgvD+X3T2w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5186
X-OriginatorOrg: intel.com



On 8/28/2024 6:45 AM, edward.cree@amd.com wrote:
> From: Edward Cree <ecree.xilinx@gmail.com>
> 
> Just RX and TX packet counts for now.  We do not have per-queue
>  byte counts, which causes us to fail stats.pkt_byte_sum selftest
>  with "Drivers should always report basic keys" error.

Seems like the self tests here should be fixed for this?

> Per-queue counts are since the last time the queue was inited
>  (typically by efx_start_datapath(), on ifup or reconfiguration);
>  device-wide total (efx_get_base_stats()) is since driver probe.
>  This is not the same lifetime as rtnl_link_stats64, which uses
>  firmware stats which count since FW (re)booted; this can cause a
>  "Qstats are lower" or "RTNL stats are lower" failure in
>  stats.pkt_byte_sum selftest.

Could we have software somehow manage this so that the actual reported
stats correctly survive the lifetime of the FW instead of surviving only
from the queue initialization?

> Move the increment of rx_queue->rx_packets to match the semantics
>  specified for netdev per-queue stats, i.e. just before handing
>  the packet to XDP (if present) or the netstack (through GRO).
>  This will affect the existing ethtool -S output which also
>  reports these counters.
> 
Seems reasonable.

