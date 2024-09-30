Return-Path: <netdev+bounces-130356-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2D598A28E
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 14:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76531281AB8
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 12:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9828B18BBBC;
	Mon, 30 Sep 2024 12:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HCbNHwgW"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49671684AC;
	Mon, 30 Sep 2024 12:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727699624; cv=fail; b=kRbEM39gY/0/tRj/L0fV5ZfN/+0JPWxwrmV04nX/cp4x9BgFohwhjv7YKCULdjfesPp/xaDx8nHf9fxwap5gx1Jc2MYSvPsWtIv6iGBow/ALvI35hL+0pVvLWcxS2TYxUfVNE6sRFiJFjgYogzDWty2R6GIxR4Yq+5IhABoE6Tg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727699624; c=relaxed/simple;
	bh=SgpLTYnmDK833CJvRPcm54VbmaOcCAmZwE630755QIw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=j7ARQPuPABnOSdlD1h8xHJ7A5PDd6ThNWXNyl98CaThcqnBFlxRjhlf3MvWEzKS4lB7aghktZ0LhGN+V76F0XwwAVd0/ds+p6s+a6alvUu8CaSiREkj/8JEA8OGM5+mrlnwXakF/vs1/yqzgN68oizeO+GzHPWS6MbirvZmSil4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HCbNHwgW; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727699623; x=1759235623;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SgpLTYnmDK833CJvRPcm54VbmaOcCAmZwE630755QIw=;
  b=HCbNHwgW9lArpD3NDcDcYL9UWv5Gk37qdbn3kOKs1IaWSBcGtSEV01qW
   wJ200uY0x2Bu0tr0jo7wgSoccAZ1l4sQqT92eKQloYeUYLl1UlUkTJYIb
   K6aF1TKiUT3Q5uFx8yjgFXI8cFF2FK6g12i+jHGLyviL2iLw0PCHC8wmy
   8yZxA8v2SJ22GmStZ5kQ/efwNNBwcGNal5WRJJ9uwMqL1qOnl5bMQx8my
   xZlXAKXflxTwxKHujut55tQk7xuVgrlSBH5uBsCXjEqwIrD2S1SS5Lb6I
   cgWnZb+PzUH/Anwvp9AixIqPNi6pkq5bouohp8Jihcaf2HHpYWlpR4DtA
   w==;
X-CSE-ConnectionGUID: wYnMd4LYQGiXdJK4w9kqCg==
X-CSE-MsgGUID: w3GwY2fQQymMtqVIPB/yxg==
X-IronPort-AV: E=McAfee;i="6700,10204,11210"; a="30667146"
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="30667146"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2024 05:33:41 -0700
X-CSE-ConnectionGUID: g3ILIPZLTQyAHcahR5aqpQ==
X-CSE-MsgGUID: h4/C2K69Q1mCXL2o8Q9Zog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="78112780"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Sep 2024 05:33:40 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 30 Sep 2024 05:33:40 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 30 Sep 2024 05:33:39 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 30 Sep 2024 05:33:39 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 30 Sep 2024 05:33:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZlLHMbAVvmKsxwWExoqcRrh3SWS+vBOYklyBOCaviCZ/C1ND+cCbcBcXueZQ9Qr03gloMWRwlDkSjmdMc9oYRBYlrv7vsZbjPRy6SZo9+XBQknRf5IdP3tIHf4yrnd2ib9+3GNH5VdmTCq3Xk/zJJEq3IW73HbhRYM5s+oaAZSQbHNu0OVk7WxEcP3rnTH922wKvr4b175hqlluCWHMBhsTPyTaD+dGDqXQcMaRxzWFP0GP8+LLlII6HNQVUQq1MjoVwIvw0LI+vvf96W8LxQIG3A/37/qTjQxyFxZ+rqG7KsEU/f56qSgIjoG/+SMNIvaBYHqfbzCYjvgIQKlJ1hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WV1yW9wooquFA5Nx6DO6EEnH+J6BaypYkpzevbYKDg4=;
 b=Dh6CzWQZuy5vIgucb6ixjKREEcNIniwzqCjNlcBdoEloj/z/HlJuecFW6NZdUl3OuByTxF4BqOlXC4jdTivhuCORtOO6bOSvJPVHgxXYfNlptxcsiD6kAzgXX6nYPoVtCjSXEzwi2K4zpUrhoMS37bF3R6FM/mO/fqyFdpZC/UvrPgcmrqddz2b32JmIuPUn7axqxuzRQWb83DzZ8O6jj/eq5hA4IyMtxpaRfNI2jxa4NYhXFZwUu1jqQgeCUcp/OCWJRQilYweWRIZns6noJVcqlrhvaa0m8a9FFcGPjcSy4LGE3pMlqj9kHpGF6JzvTH62uB7CewU/ytcSrUB3iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by BL1PR11MB5254.namprd11.prod.outlook.com (2603:10b6:208:313::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Mon, 30 Sep
 2024 12:33:36 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.8005.024; Mon, 30 Sep 2024
 12:33:35 +0000
Message-ID: <34d2f916-3551-4b75-b87a-9d413662369b@intel.com>
Date: Mon, 30 Sep 2024 14:33:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] cleanup: make scoped_guard() to be return-friendly
To: Markus Elfring <Markus.Elfring@web.de>
CC: LKML <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<kernel-janitors@vger.kernel.org>,
	<nex.sw.ncis.osdt.itp.upstreaming@intel.com>,
	=?UTF-8?Q?Amadeusz_S=C5=82awi=C5=84ski?=
	<amadeuszx.slawinski@linux.intel.com>, Andy Shevchenko
	<andriy.shevchenko@intel.com>, Simon Horman <horms@kernel.org>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, Peter Zijlstra <peterz@infradead.org>
References: <20240926134347.19371-1-przemyslaw.kitszel@intel.com>
 <21be0ed9-7b72-42fb-a2fb-b655a7ebc072@web.de>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <21be0ed9-7b72-42fb-a2fb-b655a7ebc072@web.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: WA1P291CA0023.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::7) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|BL1PR11MB5254:EE_
X-MS-Office365-Filtering-Correlation-Id: 99befe99-8b38-40e1-5928-08dce14c1a6a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZXhlbjVMUzRJSTBRNmdzQWg4RU5xcEdVc2FLTTN1WmxLemtDVDU4NFlJRUI5?=
 =?utf-8?B?aDN5Z3pzbWYrc3FVdDNoR2dLaVZrMVZST0R3SUZiODhqb0w0WWp4bDJnbXVw?=
 =?utf-8?B?RnFLMDhjT3FBMExlOHBTcUd6MEpoUHpNYkhwMmNyZ3BPSEQzUUxXWCtVaitz?=
 =?utf-8?B?VmR6ZTZiTzdkOHlIZHlXdUtQUG02WXBQbHEyS1c0QzBsQ0pONFllb0Q3Wnl2?=
 =?utf-8?B?UXRTNWdjeFU3enJydmhTOHNraHJUc29NdGhoREpzRTY3ODVldDhTMWk3NGEv?=
 =?utf-8?B?QS9oeXlVWWtHcGp0ZGVlbmJkaHBJMUlLckpycnExdWlhbVpOd3dneDdaMjFO?=
 =?utf-8?B?Y25ybXZOZXVkNFpXc0NnVGVOTVZ3aHJ2eVRUa21XTDEra3hRVGtKRVJaaU1L?=
 =?utf-8?B?STFGOFpmbVd5emtRVnFyRHV2Um5XWWVRR2F1TUdRS3ZLbXdLQzV0RzlOaDlU?=
 =?utf-8?B?eTBid0pWQlo1cGdBK2lPdzZwemhFRExZbDdxWVBhS1hmNDNCblZwaXVOT0Jk?=
 =?utf-8?B?Q1J3dkpPV05vdGlwVkgvT2lTdW1yNDNRaStHeDNCbGF5NHpuRk1FSno2YnA0?=
 =?utf-8?B?RGlZVDdWd1NvYm5TaXJVMVYvZnJhSlVhTTB0UlNzUkRoT0ZVWDdqY0JwL1pj?=
 =?utf-8?B?b0xSYVRuTUxTOXFNRCttKzF4dHUzTDJZaWJDcUZMRGV5S1pUdTZ5MFUwUVl0?=
 =?utf-8?B?VVVjYUlPQ2dMUWtoeHpnWDRYOUZXTnZ5NW9lQXlGZVBHY0psaWlRb3VNc3NQ?=
 =?utf-8?B?bFpKVXc3TUQ0RnJENzZxamhJMXVmTVJzOHJaU0l4RkYzN1h2NkI0SjYvcjd1?=
 =?utf-8?B?VFJCN3c2L2xKNzdIcUgrSG4vOFY1SGNFL1pZYlJPbFN1L2V0WU5WZGU0a0Q4?=
 =?utf-8?B?M1hZRmJUbWE5cnZ5WVJ3ZUQwUVpTUnNnYlRxd1llY08rK1pTZ210eTh3QjAw?=
 =?utf-8?B?ZnhReVlUOUp1VlhGdllzeXJ5T1dVSWRheTJnamN5Sk83QTVVM0lZOHFVY1I5?=
 =?utf-8?B?WThqTVN4ckFVOERPT0xyaWJ1bktSbHZKR2wzVDRHVWs5clNPVVFFZUtoazdm?=
 =?utf-8?B?VG1hQjFucVhBOHFzTFR5ME9rN0hGMHRYUXR5MTVCbndod1JGa1pHL29zN1hS?=
 =?utf-8?B?V3Z6TExvUGZvV3lWWCtUTUhkSjdMdCszWkN4QS9YNHI1MmNtQmRMalN1cGNN?=
 =?utf-8?B?alY4MjZ5TnI3MllzQUJQS1VmUWd0ZHZ0TjdkZ3ZVQjgrclFWWit4RUhQM1VP?=
 =?utf-8?B?U1FHRGoxMGM0bTg5MFZSTVdVMGpnZFgrVFhXL2gxODJleks5czVtSHYvUjZX?=
 =?utf-8?B?TW55cWttSU45bUQ5MWZ6d1NIVnZWVXFmUHNKUUNoejhVTnAyczYySDlTaGRD?=
 =?utf-8?B?WmRpVm4yL2FpM1FwMEZBWjEyWkh4RXdZZWIzTFZDbmRaVDVxM3BXSnIwNlBy?=
 =?utf-8?B?TzRXb1BKeFhhdTlPRzloZXptRzhDQ01jMWw0c2FSUFJjMWhqVURyZitPeVpW?=
 =?utf-8?B?OVhLbGRzT3d6MWZQaFhkU3BJZDZRTnk0eVdtRGkxdmNwbjhYUStSaDFzSm5x?=
 =?utf-8?B?YnNSczMvcmx6RFRQbW9uV3ozS2JlZ2k3OTc1Um1uTjV6UGhDMTZydHNyRG5R?=
 =?utf-8?B?dXR4d2ZpVGVBSVhvU0NtRjdKVFdQditkUUlQL0JXcDkvd3JKd3kyaGtYZ2NY?=
 =?utf-8?B?MmZsaExOQk9Oc1RJZGcwbHgxeldOdFcwaTl6OUtJdGNLRVhsZVhnZmV3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aEdsRi9RalgrYnU3eHVuN3JOTk1ESVpPRjk0TE1CUlRuUVR0cHpYZjFZNkZB?=
 =?utf-8?B?V2FEWDhYR3NEbm80bFo3TjI3dGRxUkFPSTBOb3o3TDBiY2FnMWdxMUdKdlFU?=
 =?utf-8?B?WEFTUTY4S3Bza2pHdjFqRnZyREhpR1JvVUdpVmZ4d3VIbzN5WGFTVDVNSHk4?=
 =?utf-8?B?VmFPcEJrdHl1Rmlwdkl0Yms3cFFGaUp2eS8zWTkwSkZScUl4aFVkbkp4a1ly?=
 =?utf-8?B?VEQzRWR3bU8wU283YzhYc2NIMFhpOHkxMFFhQ3VIdExEMU5vdGxnUERLWXk5?=
 =?utf-8?B?anJaYVl1Q2FXMkh3aUhnclE4KzFSeVF0a0g2QU5RSktpWDJKUHNuL1NxbkVD?=
 =?utf-8?B?UjRMNkxaN09kNGRjdUxGbEhzYk91RHI5SWhISXZXVzRKdFQ5c3MySS9xTVJW?=
 =?utf-8?B?SWgxRnIyeklFQ0NWbU5jNVhZQkIxT240alpuZ3N3ZVZ2ZklhcE9VQU1HbkFt?=
 =?utf-8?B?Q01ydFVxMnh5VkROT1h4dmhHdkcvMi9OeFpQajVIN2RvZFhIUllYTXdkdmNH?=
 =?utf-8?B?SVpSTHBoekl6LzFsTzBWSVVWWHVqSzYybmQrMC9RLzFHZGpRelFwTk5haDlS?=
 =?utf-8?B?eFh4S0J1RDFNTEtUcmh0NUJQMFdqSXRYV0ZKempPK0NiWTE2Z2orRXplVi9N?=
 =?utf-8?B?RU83ZjJDbXVoNHViODVBSVV3ZlMwRjVPUVFHNE96MGx2NnFYaHlqSGoya1pW?=
 =?utf-8?B?b29YV3Exby9WUWVubHFtbjRJUENJZTRpdjNTWER3eVJlY0hmZGt0RG81ZmZU?=
 =?utf-8?B?cm16dXFueXdoZlYveDZBTnpvcElSM1AzUTJCMjZZQmtkYVBKR1ZQTEZVZzRw?=
 =?utf-8?B?N2RrV1hXQU41UlNQR2FWVURnM1VDVGVvUmtZS3BYRjhUSkRZQXU2LzV3TVBz?=
 =?utf-8?B?ZkV3c0lVQ1lzWHpQU2d4dFNhMjZjQzRVMEExU0x4TjlVSUo5SGxyMzkxbTQr?=
 =?utf-8?B?c1hIb05aTVJsLzNYQ0w0dHQ0cFdOV3VOYitybFhVdm9NdndJd0ttM0RNQjdH?=
 =?utf-8?B?TVJWMDgvMkJleG1XeTc2Z3oxOWFJQUd2UThOS2JOSHBCY0dYcm5OV2VwN1JN?=
 =?utf-8?B?RmEwb2JSUGRBZHk4dUd5REJNVUZKYVhwcFZ5bXNTMVBMbkxOSEhMcFlOZkRz?=
 =?utf-8?B?YXVSTXozcEMyRkR3YkdVRkQ3aXF5RWJicGZCRjJ6cFAwNEYyQ3RxeVdhSm1v?=
 =?utf-8?B?S3FSa0lkdkZlUmsvQisyQTc2US9JdkdPekUrWHNzelY0K1FtN0tTa2dQU0RX?=
 =?utf-8?B?ZHNvYmFVNXRFMndoL2cyb3lWdjNydGxSbFp0QW5pVk00cnhDVldIajB3bnJz?=
 =?utf-8?B?Rm95K2RvOHJORm1Sdm0rMC9lQ0huL0JFcXFSRmNqeTFzL3hvTUtNVEx4d0hh?=
 =?utf-8?B?UjRDQWVvRTR5NytYV0ZzS21ZcmFsck1GUEo2NGJ2ZlV1U28rUXNnRTRhLy9h?=
 =?utf-8?B?Rm0xNUdkOGxlSVBialNqOXJib0hFWVY0VHhmanE2cmd5SFpQcHZSb3NCTDNy?=
 =?utf-8?B?T3VlTStqRUlyeHBOYWZHeWJ0eUpZeTBzYUJyZk81WkdvTXZzd1dOSUx2Y3pF?=
 =?utf-8?B?cnh2dTNxQ3FxY3lTQ3E0TmdOTFVId1BNNms3NndLcFFEdkplWmhHQUY0MDA4?=
 =?utf-8?B?QUNHcUNzUVI1VVJXWWdZQUV6M052Y3djTVgrTnc4SzhjL1hBdVM5Z2tiZHZu?=
 =?utf-8?B?ZnhRN2xvdTd0SUhlZzhNRFBoMGJXNjFNUmRsNGltTm1KWlVpRWJocm8zQThY?=
 =?utf-8?B?UU52OEdyMFJZUStBK25abjdjSXB5N3pTY2NSaHpXbmJxY1RtcklsMUVkMkRB?=
 =?utf-8?B?RVRzQVh2bVFSU29FcVlnYm9RUE1mVXEwblpIcmtjeDdzTjJHQ2hKaTZmdkFG?=
 =?utf-8?B?V2Y5OWNUVjh1bm1wUnFqd0ttSFBhUXZLMFZmSUxIQm9SMEd5eFBLcFpGMGRY?=
 =?utf-8?B?cFlZaWx4cDdLck5pMU80SCtvVTJ5UkV5bVNjOGtRK1Z3UEgxT1hEQzNmT0px?=
 =?utf-8?B?UUkxbkdlUzdTVjFiU0dnK3BBM3V0dXlHYmsxczNSQzJmWDhpcGMvdFNNdnp4?=
 =?utf-8?B?a3RCRndOWFNzVFBuSS9MSkdTdjZBTVM5WDB0V0FrcjVGSUZIMzhweEFwRDNG?=
 =?utf-8?B?R1A3cXh5bU9YZ0VwSUJoQUZWS0RBK3ZVMTBrS2x0RVJpcTErQncrTHp0Tlh0?=
 =?utf-8?B?M1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 99befe99-8b38-40e1-5928-08dce14c1a6a
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 12:33:35.7715
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AMRtlJiCF6JV7FHlF/AD6CW0Xjtal+iRhtq91p3SwalxJs23kTGpKjWkQglog1QM+RPIQPjHsmYFDz5QIlWyYyLQ/tUNtV8dGFMh86D8PLY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5254
X-OriginatorOrg: intel.com

On 9/30/24 13:30, Markus Elfring wrote:
> …
>> Current scoped_guard() implementation does not support that,
>> due to compiler complaining:
> …
>> +++ b/include/linux/cleanup.h
>> @@ -168,9 +168,16 @@ static inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
>>
>>   #define __guard_ptr(_name) class_##_name##_lock_ptr
>>
>> -#define scoped_guard(_name, args...)					\
>> -	for (CLASS(_name, scope)(args),					\
>> -	     *done = NULL; __guard_ptr(_name)(&scope) && !done; done = (void *)1)
>> +#define scoped_guard(_name, args...)	\
>> +	__scoped_guard_labeled(__UNIQUE_ID(label), _name, args)
>> +
>> +#define __scoped_guard_labeled(_label, _name, args...)	\
>> +	if (0)						\
>> +		_label: ;				\
>> +	else						\
>> +		for (CLASS(_name, scope)(args);		\
>> +		     __guard_ptr(_name)(&scope), 1;	\
>> +		     ({ goto _label; }))
>>
>>   #define scoped_cond_guard(_name, _fail, args...) \
>>   	for (CLASS(_name, scope)(args), \
> 
> * How do you think about to define such macros before their use?

will do, no problem

> 
> * Would you ever like to avoid reserved identifiers in such source code?
>    https://wiki.sei.cmu.edu/confluence/display/c/DCL37-C.+Do+not+declare+or+define+a+reserved+identifier

we already don't care about this guideline (see __guard_ptr())

OTOH there is DCL37-C-EX3 that says "does not apply for std lib",
and here (in the kernel) we don' need stdlib, (or for the purpose of
bureaucracy we ARE the stdlib for ourselves)

> 
> 
> Regards,
> Markus


