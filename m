Return-Path: <netdev+bounces-156925-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18785A084E4
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 02:31:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12131168F85
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 01:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939DC1E4919;
	Fri, 10 Jan 2025 01:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gmZXHoZC"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19CFF1E25FC
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 01:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736472613; cv=fail; b=Wg3rue27gaS/FRKMP3/2RP5y2NV6OYwcIX8XKhihVOAPbq6uVwIQgwmfDaRB0qn/7NGSEH0rgSDC/Iug3kqcCuRgA9JH1RGyN8WCeuOXFMUu6RJYu1ldESCpAh0StkYrFxH481xSEQ28Z8U31Dt/dyA3C9qn/UY2tyLbiFGHWqg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736472613; c=relaxed/simple;
	bh=ARh2jzPtv2f3mFmxSvDWfX4nO9NbzB039XgF2SxET+Y=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=IuTgNiJPjuMr7pZT9DL55Srp7c0jgl5js+gnyT3WPK73Tj/OKA6izmg6RBYZvIIZ9wWAPkJ+8Dltc59OpJL16KC9YmUKhP4lPUNq1fJ8dOACpbWTlV4zrlB1jp/zOlVVJn2UUaUwWfxi6RkNfncq8ZRKunOrLoZx+0k6pCR+zcQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gmZXHoZC; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736472611; x=1768008611;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ARh2jzPtv2f3mFmxSvDWfX4nO9NbzB039XgF2SxET+Y=;
  b=gmZXHoZCsz/3bEer+ccbyUBvg0VMwV12wVfWLx9CNunfN0RpwLR06eVZ
   szvm8BGZGaFw1Aq8ZUfMYp+AL5I3Ru98s7adjPZSGpS1CtSzUPUGW5KuN
   kw+vEgdtMATSkCLdHRsMOiErCcRKvyRCd3izCMTTupOn2/S7shYyo5vqe
   MqYMOE1q/cBZvYdh9n6koMRa48Hx/75yooghWDfq/EognkAbuLxHYjD+7
   tDRlCUWdDjJK/79PKVS37c7ggyWhbaX04qCeIY241qRowyrtZQ/A6/TXn
   hj4Bx8vwR1LqHuRAWCiCdeeEtfhAq/z9fn+3PC3akyU7ScX4uUnlVQhK2
   g==;
X-CSE-ConnectionGUID: qS2dIrXUQGuY0EIGb0tvAw==
X-CSE-MsgGUID: KFQbshV5QUqlaVGst8kcoQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11310"; a="36657571"
X-IronPort-AV: E=Sophos;i="6.12,302,1728975600"; 
   d="scan'208";a="36657571"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2025 17:30:10 -0800
X-CSE-ConnectionGUID: b9r87AveQe+jm+pZBAtSjg==
X-CSE-MsgGUID: wPAmNYC/SPOHrxMRtKKCxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="103476395"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Jan 2025 17:30:10 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 9 Jan 2025 17:30:03 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 9 Jan 2025 17:30:03 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 9 Jan 2025 17:30:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E/ehmpo3hzNQrKiTbUO3F61Be0u+i+aL+XfnlDLOw36sAlYFDio6bLxB9eNizhKOq93X8FnS5nyyz3AOSmYXeoOzcg8PhUTmvHy3CiAuvriPeL2BvRI/h54Af22I4PgtsjcrZLZ7kncDwy51QU+v2HtzpcGl4svz8UqCH57hvYLjMplxtB2p0doKCDYBKLLvOzKxFFtrymdIBg5BOlPowZP0GsVJ/cTjhARZNKPRSRSkGhSbPVmcSDHYA70B0eH1eYBHnxhAMyQ84QBRtsrJaROcndr6+s+sww6yk8453T0xVOcHYhfsZMR/frg7IQB+5J/SZAK6SzLuEDP5VZLGAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sd+1Ew2w4HsNPXF/OF5PsE4G8AkEvFcVKybcBwzBGwo=;
 b=DBKvolIa6dO0/fk6YWKopqDIsb1HwukMIkWNFu/aU3rKCx57uBBpAVKOaCbljo/6VhUTLGIKE5Cu/ni8VLqIsDzI7N+RE+vPSuqjhK8XYMVB2Q15kl80sLk6rZkFF94lcqOgZsfRoB6OSvzrB+9U6T8SzmzNVp1bKYAPK4qPcoTSk1yLHkiR4b9KEeW079TzGwsxU6C2oJBfyKyiYyZoxO45Xjcm59+JHZO3kjINVIUAunR8Ct4p5n++Kb97Pn4Q+NvnvRtWJlQR/XY8u7yQ3tRPHUl8gx0boXq+TvAOfdRXLHd7u7+auIEpuL01ubd5n8rR7AQ0UmTIwFFMoiAAbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by MW3PR11MB4716.namprd11.prod.outlook.com (2603:10b6:303:53::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Fri, 10 Jan
 2025 01:29:24 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.8335.012; Fri, 10 Jan 2025
 01:29:24 +0000
Message-ID: <2d034f7e-ce2a-4e14-9a35-ec8a1dd3c8fa@intel.com>
Date: Thu, 9 Jan 2025 17:29:22 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: hide the definition of dev_get_by_napi_id()
To: Jakub Kicinski <kuba@kernel.org>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
	<andrew+netdev@lunn.ch>, <horms@kernel.org>, <jdamato@fastly.com>
References: <20250110004924.3212260-1-kuba@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250110004924.3212260-1-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR20CA0004.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::17) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|MW3PR11MB4716:EE_
X-MS-Office365-Filtering-Correlation-Id: 35498a53-202e-4954-9c0b-08dd31163776
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?eFIzVzllOUMxcjFGaDlHWjdqUUlmQkFkZkdia20rUGQvSUdPa3RMVXREZ0RO?=
 =?utf-8?B?SHp5b1BubGxRLzM5bFJlQ2NhUEJXY2NCb3ZWZy9MYzlMTVhJdTYycURJcmRx?=
 =?utf-8?B?RC9BVDJ4WFdjNzBTYk5ZVGFjbk5XLzBYRUZjbEJ5ZzBvWFlMNnNNOUY2bnFO?=
 =?utf-8?B?WW1tTFVQZFFvT29SejV1YmxDUmJzWklnQm9Ic2pEN0EzcUVQVlZiRVBXSnJp?=
 =?utf-8?B?Vk4yRzNrWjFCbk9iKzJvV2JiTWN4T21NVFlsZ0haOEdKSXVpY292QUdJTGxP?=
 =?utf-8?B?NFcrcm1UamR5NzBocll1WkxEQmhGVDNueVdlTU9zbHFldWVnQlFOVFNxZ3hH?=
 =?utf-8?B?c2R0T3Z1UFpKWWoxdnRVZVA2Yy9VZlBqb1hVTWFuS3VuaGp6WkpIbms4ZWpo?=
 =?utf-8?B?MzRiZkdSbEF4bkdwMjBmU3A4S2h0NWhUK0tkN3RIeVo3Wk1SVUxZRmRPa2hY?=
 =?utf-8?B?aitXanNDNTdMbVVCWmJxblhCWSttczhJRXQ4eXozeXduK3hId09PeTYrSWlP?=
 =?utf-8?B?UHpMK1ZKeEFxWjhzVEd3V2duZGZpbGFtMzR3YWhjVzc3bUZCdm1Xc2FSRXhW?=
 =?utf-8?B?L2o2V2crN1AwQW8rb0JoNjNEUDJkck9qazk4cE0xdVlnMUJDdEFIRTQxOWo3?=
 =?utf-8?B?U0hwVy92a3NzR3JGWTExSWpOU1BvcmhZL3hqK3FXcVFEaWRXUWNkMGVVSHJt?=
 =?utf-8?B?MWFQcUZLZWNTTkpXOTY1QnlPMTdkMVU3bVhTMHBFaG5ITnBncE9oaXBsWjlj?=
 =?utf-8?B?SW9BR1cvdjEwenpiRFdMbit2Q295K1NtK1kwSUFSQzlFOCtvakRiY05NK0Mv?=
 =?utf-8?B?dzhiZTgxbk1uNVA0QTBtZmpuMS9ZNGptRG5tMTNDSkZDR0Rhc1h2Mk00NDlX?=
 =?utf-8?B?Tlk3MzAyQXhLNWxnVk1xVmYzbUMzSUdlSlVac2d5eFZrSWc5L3lnUy9NN0Qy?=
 =?utf-8?B?Nng1WStZYXhINDEwejBzR1NuSVBObjZZbHdITkZIV2p6NEdqMWJJTS9TSnY0?=
 =?utf-8?B?WUN0enFNQXg1ME96a2lVNWs0MTErbnhPays1VVptblhPVkMxb2FyM3c5cnVp?=
 =?utf-8?B?OGtlU2tpZGYzQmE5dlRiYVY2VEI2cDZJSUEyZEVvUnNMUDAwa05lK3E2NEZR?=
 =?utf-8?B?YWR1c2R3Q1pyaUIxZGxhSlI0VXBhbTF1YnF0eHVHMCttMENGZmUzWFY5Z1Rl?=
 =?utf-8?B?RWdQSVRjTHhwcTU2Vy94NG5VanNiVkhobmY2ODVhd0tNRHc5RVMzK0pud0FR?=
 =?utf-8?B?NzA0UlFtekU5MTBDcXYzTWJEZjFwM1pjaWtOUzRnVk5NVG1PMVljbCtnekxN?=
 =?utf-8?B?cW9nT1ByM2R1UE5pSlByRGxqMVY4NlVnenFwZlZzclJlSmNaeEQyN2R1WW45?=
 =?utf-8?B?cUpTQzBpWVdzYXJPM2QvN2MxK21kRGpmSTYwOGU4S1BTZnFiM08wQ05wdXNm?=
 =?utf-8?B?OHFHV29vc1EvTEUwaUd5Vm42cG4rYytILzhEbWRWdy92SmlxTndQbDVJQlBu?=
 =?utf-8?B?R3VKT1kzQjR5WWVBZkREU3prSUdFUDM4c3RCQmJqRkw2VThMdEd0YjNQcE1u?=
 =?utf-8?B?ZndkWXU3RnNueEFoVjF5Qmh0Y2xYWTdrbGE1czFBRGk3bkd5aE4vMzZtWEdD?=
 =?utf-8?B?czUrRUdiL0hsK2ZybnJ2Wi9SbGVFRm1ROXVkTXNMUk41Y0w1M1M1SEVWNDda?=
 =?utf-8?B?K1dWKzBxbXF3M3FRUkpkRW1oVnhYSE13YlRjSGZvMVVsSVBTbnNZOVphdzYr?=
 =?utf-8?B?RXlyUC94dnpDdVYxbEorWDY4VEZOZFFMUGxtbHdKZzYvT09Gc0Q3SGtTRUVJ?=
 =?utf-8?B?TE8zb0puS3Y5R1d6aksyRlBwcmlpN1pzamhpUkJsazArUGpnM0hjTmEzS2pQ?=
 =?utf-8?Q?8zN8m3YombzGI?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SndRZGZQYVpFREpCdWtvbk1Tc1R2UW9KUEdnQUduS3VsdlM2SHpnWlNtaUo2?=
 =?utf-8?B?cDlnQmFZYitMKzE1NG05d082bDlqTmFxNThiWUdYVjA4VEtrZUZmLzZ5aUNE?=
 =?utf-8?B?cU1IOTVQNVh5Tjk0d09FY05JVk1kQmhEVkRINGRQWjBuSTgyc2ErclkveGVt?=
 =?utf-8?B?NTZVYld1OW5UNzRWeTc3dmJ6K1dZKzVuc3FSMFBTTkh2SnIyNHdDMlozZTZx?=
 =?utf-8?B?TmJRYlFSckUyd0EyYTVOZ3VwYjcxZEc3bmFKd1hwT2VsWGxXNzMxR2hpZ080?=
 =?utf-8?B?cFUrZDQwd21CQWY2S3ZnUERVbk9BZDZzTEQ1ZElZN0ZJWE9lakRFdG1YU1hZ?=
 =?utf-8?B?QUhKWnBPMTYzMGVva1l5K1F4SmlyWmdpSTh4c0RTZDI3UXEySEVMWnJnQmho?=
 =?utf-8?B?L2g0TVQ1T3R6RU1zcklCblJsQVhqdVVXdGplcDZZMzh1UmRySFlTUTQvaCtT?=
 =?utf-8?B?SFpDYVBSRmdQalR2ZDdxWnhhSUoraE9HQ2dEclhwWWxEL2JONDh5amVDckRm?=
 =?utf-8?B?cHBaKzVFdXFEODE0VGlkUWllN0lTNVBnSHpIKzkzNG9IaUdpaVVIVVVGYWx5?=
 =?utf-8?B?QVB2K0lFN21ESEFhZExBOVFQbUVkUkx1RGxaYTQ2TFBpeEsweVJkbWlmRnIx?=
 =?utf-8?B?MThZdkR4TWJKbE5FYWxEcTZWZ3pqSEJ4RGU4TEcyS3pabkRUZHhUQnd4YkhM?=
 =?utf-8?B?TS9nNTFOR0xZUllmMlJXYlY4cUJUZ3JLZ01FbE9LR2tuSGFqaDVNR2FqNFQw?=
 =?utf-8?B?bzJCUGZUMXVnRlhGcG53bTF0NDMydnRXT0ttUURBd3JBbEtRTTdlaTVETFkw?=
 =?utf-8?B?WWF6QjlhMjFhWmZQUFVZUkxIVHZHMnM3dkdONGhYcUhmUGgvdjJPa2lDclBJ?=
 =?utf-8?B?VERaaGJzdVhDTnZxWW0xZXF0dzlFOEdyMURQbW9DeExVT1FveXRTaFFDQ3ht?=
 =?utf-8?B?S1JBL1ovdGo0TXRpZmdiVWRrcURzYlpyS2FVNGNWcjhkdGFaQWRrUHlhQml1?=
 =?utf-8?B?M3NPVjVSOWd6TzI1TnpOVHdVUktNTnU2c1lLWjBQalZWTDVrOXpWZXMrU0g2?=
 =?utf-8?B?bnNrZEVQbFZoSDFmS0JSTzlPbGZkYVJRNUlWRFM3ako2bCs5cmppd2Ruc1Ar?=
 =?utf-8?B?MXh5aE1iOTJxZStoR1F4V1luV01SVkF6Zm0vdFZQM2htU0Qrb0dkRXBEM0hq?=
 =?utf-8?B?dnRFWjFMZnVDSWp0ZlRpVEpvWXVmdmhwNEhiMkVmYWZRNUszZjNkMUxuUEFZ?=
 =?utf-8?B?eWpGSCtWZUZBNzBGZmh2NUxXUmh0clJQbHVuSUZCSUtiaDFZWU9QclBwMUlk?=
 =?utf-8?B?RGdvUjFqclRQbVpERFcrNlc1cmZka0ZDdzl5bnkyYW90RmNGU05vWmtXZmJX?=
 =?utf-8?B?MVpxMVFBWlZlSFc4L29vZmg4Z050WCtsTDBtUzI3dWc5a1Nyalo2RGhJNmVi?=
 =?utf-8?B?dUtneXlnQmhJa0ZZejRTbXNVYjRFNXVQNmhyMUh6dzJOWlF1aUF5dUZBM0sw?=
 =?utf-8?B?Y1E5YnpMWnMyb0pEaGhlWG1ad09SbEFJWTkyUG5KSTRQMDNGSVlpOVlTcDBz?=
 =?utf-8?B?YVNzSXZhYmEvcWJ0Mks1Y0dQcitXOFBFK05CK3dNMDE5ZEJjMXVwZUtBOGRh?=
 =?utf-8?B?OWZaQWY5V1ZwN0VldHJXdXhIamNZMkxNd3l5L3lrVDV5N3BiVUZrVDRVb3Va?=
 =?utf-8?B?T0NjZzBNRW5xd1AvZ2c0eTROV3hqMS9PVmN4dXQwb3R3ZjA3N1FCeXA1VzJZ?=
 =?utf-8?B?bHZzOGE3a1BHdm9MSXl1QUc3WEduTVpQVGRtbm1vejBnZTBmU0w0OG1vUXFT?=
 =?utf-8?B?KzdhOStHVmpOTlVqYWVLV1NvYmVHLzFRdld1MVNyNFZmekJ4cmY4aS9SdUFP?=
 =?utf-8?B?cEIzWkRrV1VjMjVvRTdUbjluc2syajA2VmxwRjhNeEdnekZ5WkpaTk1GY05M?=
 =?utf-8?B?TXh2L3RVaEo1dUVwWDRpK2RjOEtwdjRwbDdsUDhwZTh3d09teGc1UmRFcHI4?=
 =?utf-8?B?RnNsT2c0U1ArUWJVNmJBb0NkNmlEdDkveTk1R3RIVytKU0U1SEhVdVdyOXpt?=
 =?utf-8?B?cmRPZGh6emdPK09zVUFRM2x5cmhjSkpCUXM0YnVLUndORjdnVzcwdFo4Mjla?=
 =?utf-8?Q?/deXOGMs1bOOycZRPiOiARpAu?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 35498a53-202e-4954-9c0b-08dd31163776
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2025 01:29:24.7325
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u2siBQqZcLulJnCSh5f7YVNyOYjw/HsHNmJH2CgUQoOqOR86/Jv9Tzxu0tjETFCRer9bSYBHFxchgWO/JLJ4kPEUdDSKOYgTGAKTApnySiA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4716
X-OriginatorOrg: intel.com



On 1/9/2025 4:49 PM, Jakub Kicinski wrote:
> There are no module callers of dev_get_by_napi_id(),
> and commit d1cacd747768 ("netdev: prevent accessing NAPI instances
> from another namespace") proves that getting NAPI by id
> needs to be done with care. So hide dev_get_by_napi_id().
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

> ---
> CC: jdamato@fastly.com
> ---
>  include/linux/netdevice.h | 1 -
>  net/core/dev.c            | 2 --
>  net/core/dev.h            | 1 +
>  net/socket.c              | 2 ++
>  4 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 1812564b5204..aeb4a6cff171 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -3252,7 +3252,6 @@ struct net_device *netdev_get_by_index(struct net *net, int ifindex,
>  struct net_device *netdev_get_by_name(struct net *net, const char *name,
>  				      netdevice_tracker *tracker, gfp_t gfp);
>  struct net_device *dev_get_by_index_rcu(struct net *net, int ifindex);
> -struct net_device *dev_get_by_napi_id(unsigned int napi_id);
>  void netdev_copy_name(struct net_device *dev, char *name);
>  
>  static inline int dev_hard_header(struct sk_buff *skb, struct net_device *dev,
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 4452ca2c91ea..1a90ed8cc6cc 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -957,7 +957,6 @@ EXPORT_SYMBOL(netdev_get_by_index);
>   *	its reference counter increased so the caller must be careful
>   *	about locking. The caller must hold RCU lock.
>   */
> -
>  struct net_device *dev_get_by_napi_id(unsigned int napi_id)
>  {
>  	struct napi_struct *napi;
> @@ -971,7 +970,6 @@ struct net_device *dev_get_by_napi_id(unsigned int napi_id)
>  
>  	return napi ? napi->dev : NULL;
>  }
> -EXPORT_SYMBOL(dev_get_by_napi_id);
>  
>  static DEFINE_SEQLOCK(netdev_rename_lock);
>  
> diff --git a/net/core/dev.h b/net/core/dev.h
> index 08812a025a9b..d8966847794c 100644
> --- a/net/core/dev.h
> +++ b/net/core/dev.h
> @@ -23,6 +23,7 @@ struct sd_flow_limit {
>  extern int netdev_flow_limit_table_len;
>  
>  struct napi_struct *netdev_napi_by_id(struct net *net, unsigned int napi_id);
> +struct net_device *dev_get_by_napi_id(unsigned int napi_id);
>  
>  #ifdef CONFIG_PROC_FS
>  int __init dev_proc_init(void);
> diff --git a/net/socket.c b/net/socket.c
> index 16402b8be5a7..4afe31656a2b 100644
> --- a/net/socket.c
> +++ b/net/socket.c
> @@ -110,6 +110,8 @@
>  #include <linux/ptp_clock_kernel.h>
>  #include <trace/events/sock.h>
>  
> +#include "core/dev.h"
> +
>  #ifdef CONFIG_NET_RX_BUSY_POLL
>  unsigned int sysctl_net_busy_read __read_mostly;
>  unsigned int sysctl_net_busy_poll __read_mostly;


