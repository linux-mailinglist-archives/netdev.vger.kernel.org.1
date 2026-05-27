Return-Path: <netdev+bounces-292445-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CCwQL7pVF2oPBQgAu9opvQ
	(envelope-from <netdev+bounces-292445-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 22:36:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B7FA55EA1D2
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 22:36:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8BEB3301FCAD
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 20:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24ABD38C406;
	Wed, 27 May 2026 20:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kO8jU6fZ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16B8314D18;
	Wed, 27 May 2026 20:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779914166; cv=fail; b=YsQ87R0eWNWZv5LGokOdDulami/YXaS4bQvvDI3Y5hvJi+rwN+zJ9ZoRWnlSVKIqEbx0KoydgUoTCwVsP7KR755PHyL3cxiOUbQfZmo1qB/ssIbWt9/K/aBu6LfYPiE+zwRVCoR3myNxAQ0RMM+Ig5cbrwLFf9kLTQiWgIhqxuw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779914166; c=relaxed/simple;
	bh=yoM3Pgj21Umk3mxH3O7g02nHy74DBoSQLcxyQtPLCMY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sIpyQGCW8A7LEMoZuMJeYkRMn8fk0eVAfOYeacRkuVOKsUnkINiZuMlmeTM+2/5D6I5EbBGTwh9/ydcOm3iHSlCxieOj6y7O2V53CkbGYwcNc2mgdS1uBAXL1yeVE5whQCQ4rtQyz6S4rtcfw1R3scNWI9hjNhhzFwJ3WYyojPo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kO8jU6fZ; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779914164; x=1811450164;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yoM3Pgj21Umk3mxH3O7g02nHy74DBoSQLcxyQtPLCMY=;
  b=kO8jU6fZ8Pm8vl63tRyA4Xj2SRIaMumu4k4lGwl5cQGU3fVZlMznAFKd
   WBfdBsUGWv2/AqwVl5ynN+pUimyCP2rfuLbAzWyRbgRTwJO0ASNBbKZBN
   +OCOz3o0Q8uLfdKMs5rejRqKys7uH6F+HHwmxBHGPl2npMKbSIPj+/geT
   tT3cFULcCruaKRnp4U2UsN+npzZggboMonrEWITQzoaKkXN6vkFYfKTxg
   6VnHhzJ/+w3vTBjivTMLCPmJnArf5EDdSw2vO8px3z1GSR3B+SFy6mGnY
   +sNxojUy8eWY6uFeybMcZQvBJVYhp0WepxYLMzNk9ApvTeljylTHT2Ebp
   g==;
X-CSE-ConnectionGUID: QZGtw15rTw+LudnPkjocIA==
X-CSE-MsgGUID: LjXqAA0nT4ifzjPVr2A6IA==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="84615176"
X-IronPort-AV: E=Sophos;i="6.24,172,1774335600"; 
   d="scan'208";a="84615176"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 13:36:03 -0700
X-CSE-ConnectionGUID: sQAWnsBOSHahxdD7G0e1ug==
X-CSE-MsgGUID: aR5+kU7UREugJ7A2aJ9DRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,172,1774335600"; 
   d="scan'208";a="265953071"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2026 13:36:03 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 27 May 2026 13:36:03 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 27 May 2026 13:36:03 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.16) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 27 May 2026 13:36:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ARnCEuZXUtQRATesQSAJ5DsCBvY/jfwH1AN9S26Oif7cgRSfTnNgwixSSJS7iNkB3Wkw1YlDgey3MSU0yLVeb0gDtmpxuhkjFqA1WiXUoW34c0GYfiiTs6SqUHyUTUnDI8YeVd9amWVvWgWNG7sTcHNtrLEzymlhRmkAChAgW/xe0pBByx8wM+1IsKDg/mXzjzSQYerFDauCHl824Z9VOVQkl5Zhj3mwslyTbyiVxzyx/WIwAEOlI5U6AOOiL1ucif46NkD5N47bG0doj3gl46kh5kwA+PK7CDuxU9dvO3vmbTKPuHRNnmAmmC5lUz/zLpc1MytDDWBYwRtgev0K8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hdi9vmP5fgv6kHkI8dzDn0wCyrsLxf7dGJq9mgKQ4HE=;
 b=ZD7CBOAOhk48sGIEYHCJD5xV1eE53UB5VV9G2/CWP3oH1jzZzAxuv2cKGmjm285t9LBD60+wNDDmAoZSSdhbIqyWm0ATRecoJq2MnRFBf1/LUtCWJc42IQ6dfXsX9fUCPlMap6/E9rFRZoC0K1g50a43kxLJIwIi2meBGz2Zj8Po/t+G/TmJfby7/uQ5GF4xHv3xXHrdX9RAxO+2wB01P5zXNMrTMRIRAYFgiF6u3RWoBiX1mAA/n6cR2BHqrZjNLGdRcI1cUCKiXyB/xK1DIWAwpQeSt0CI82m4ajV4i6Ls9O0OgESQgryo3iG8LcDnxcdbG60GvYPtytxFs33BcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by PH7PR11MB7606.namprd11.prod.outlook.com (2603:10b6:510:271::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Wed, 27 May
 2026 20:35:55 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%5]) with mapi id 15.21.0071.011; Wed, 27 May 2026
 20:35:55 +0000
Message-ID: <9bfaf886-3aad-4ea1-b576-f822666316e6@intel.com>
Date: Wed, 27 May 2026 13:35:52 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/2] net: lan743x: add "message level" module
 parameter
To: David Thompson <davthompson@nvidia.com>, <bryan.whitehead@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <cover.1779903597.git.davthompson@nvidia.com>
 <4c240063db57c93541e3de61900a5d7adffdfd27.1779903597.git.davthompson@nvidia.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <4c240063db57c93541e3de61900a5d7adffdfd27.1779903597.git.davthompson@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0134.namprd03.prod.outlook.com
 (2603:10b6:303:8c::19) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|PH7PR11MB7606:EE_
X-MS-Office365-Filtering-Correlation-Id: 73febcb5-a43d-4129-bb43-08debc2f8d1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|5023799004|11063799006|6133799003|22082099003|18002099003|4143699003|3023799007|56012099006;
X-Microsoft-Antispam-Message-Info: pOsY6vplVcn7unC2q9bgNeIaPyQt/YdDY0cR4fyx/XN+drugth9HF/bCzBth7u7sYaE6yX95UdRs6mH6z3bRn1tZocIHkTymN9jqCofFCDvJBWh7cnKNnfLcq8yFOG0gxXzz1UKMTeFlQhNLs6YM7qFIZkfAjj+WV8L1Y7F6OybSzvf5rOBIL/fI8KsK1/lKtbd1BGNMGashrH/mpeNtSZmw8lty413MhrNHdhnl7LXCi0kPEjEe/JW43qJDTDLWZwupMly+4P0ESvKFs1Hxay+ayQ6Osrqoc3gxwVQnlMV3L1Uh01RbDVBYHECMWbFeMGpUaCLpTY/Zb76Vo5cry+lLGb7wgadr1SRpvXrgAxqv1NnBqSPdErsf9pjGWIHcCsWHOyiGUm81MdRqU9qeMc9RLoNMycRCW6qQVnF+rnGmgtbWLlUxB8uP8/VWi5sihby1dtEx23TYidKa8DHJyw/3nkJaIF/kVLKe5cMjTTOBM/Xn340ZR1r1dk/Maysj1kurWiUs6ItHPRrDZh+j1sAlzZp9eON+37oZDx0fNtxK21o0HUHxopDSuVDaHNLYuqJwOHNQhQnQNPh5Gx1YlUqvyTc1N7Ow4hsD8q2S6EZxcYFbVYSdZEu/uJiTjq7V3dTcig7ru3B1/jnk0Aj9MRl613e3XeG2x6NLPRW/Wx7osjzAsiToqcpmOM4i7kV9
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(5023799004)(11063799006)(6133799003)(22082099003)(18002099003)(4143699003)(3023799007)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aVAvYmpNYUZ5M0lxWUkxVzA5eXlsK1Awa3JjekNrT29qWnRGRFdPcDdrSVp6?=
 =?utf-8?B?WlowajZSSXEvMkwrM0dnTFppZG8zdGNuMUc2ZkJqNDVXRG9FaFc0Ukp3VFVh?=
 =?utf-8?B?b04wVjNCb212dFN0NzV3dVBJanpuaEhMMXMyS2FEMU56M0xwQ0RabFhTcmxY?=
 =?utf-8?B?V1pMZlBmN2hNTzMrZmpvMXZhTmQwb29vdzErK0hNZHcvSWIyMmJ4bmRPNVFp?=
 =?utf-8?B?Q3AwMUxxcWVIa3lQT292eXl0VDhYK3pydHFUQWtuZFczNW9rYVMrTEU0QzV0?=
 =?utf-8?B?NmVBYk1xOWVLczJ0UVYxbUx5cklndFlzaUdUbjVwZjNJcEpEMjB1b3BTTFJ4?=
 =?utf-8?B?dXQxZGE0ZDFRUm1UYk51TS96V3J0a0pEZytDR1pWWGEvSzNJR1FkU29iY1F3?=
 =?utf-8?B?U2lhenk2OHBMT2tjUmtnZkpRQmpYQmNwSS9PdmVENlBacVJkeUtlS2kzQ3Yv?=
 =?utf-8?B?bDhTbkpxSmkweUhmb3k4d1VtUEY5WCtjUjczWXdKY0NrMGw1dktYYnIxbjlr?=
 =?utf-8?B?QXExeWtSS0pTUzloNWJLTWNHUVhucXRDS0hTQ3R6Mkx1ZFlaSVlLN1hSRDI4?=
 =?utf-8?B?cDlHcWtlc01rek5wNFNjV0hncGFBeFlOZTBUV041WjZScHN4dXRDbVNVZ0ds?=
 =?utf-8?B?elloSHAxRVQrcnV6akg1RnljeWlhYktiRGpBWTc2T1lKWmdlbTg0Y1gzd3BL?=
 =?utf-8?B?OEI5WnZESkt0dlFEV0x5WXV0WDJUVXBjamN2eTdUOTFQZjVJYm82azF1T2xU?=
 =?utf-8?B?SGZ1U1VkUnMrR1h1TnlvNHhiZUYxTll0c3p3dHNDS2dMRUpTM2MrVGh3ZjI4?=
 =?utf-8?B?VE5WR2xBd1VuZSttRnVNdys0L0I5RVNlVXN0YzE5WDFRUXJUNkxmeUoxS2dF?=
 =?utf-8?B?dUJhMlJuMlVzZVI0OTJUNzlYUHlVYk9LMVArYzlWSTBzYm5LOEkrTzdTb2g2?=
 =?utf-8?B?MU9LOERhZTB1SGlHZnFySDE5TnFBVHJPaDF2M2pwZ2VaMk51cXJzeS8yak1X?=
 =?utf-8?B?cFozWEVsYjlLVWUxUWFiYW9iVE1uNUkva0czdSt6ZU91VFBiK3NQcWViR1J3?=
 =?utf-8?B?ckgweGQ0c24vSnoxbUk5QktNckZmVEhqM1BWSitSeWszcHlGNmpkeDE0S2dp?=
 =?utf-8?B?dndkNldyR2taQkMxTlVBMEloWFhnY0txT2F1S1ZkZEdpbWtwNkIxOHZRMThJ?=
 =?utf-8?B?NnpRZWJLT2RvZnhYTUQ3MmozTC9CcnZTUU9jSk5ieFpCVFZja0dKZWxzcFpI?=
 =?utf-8?B?Z2ZDOXQycDRVYk45Qit6OW9IRkxwL1VxQ2lPcUNsL09BT1JRaDdSamNsanVR?=
 =?utf-8?B?MHBEbnlIK0c2UExsa21BTDUrc2hpSkgrUDVGQVZBanJHWmF5WlR6VWY3MWdu?=
 =?utf-8?B?VlprdWRBK2k5a2dzcUdpUXE1WGM3VUF5Z3FsRFUrc29Jck9TTnk1aTBQNGVL?=
 =?utf-8?B?aURsU1BtMWoxRi9aNmRsa2p0YVMvbUxmTnRDYTBpWmExS0tUVUpvWXgvNDBK?=
 =?utf-8?B?Ynk4bEtBeElLbDQ1MkU0RWN2VTV5MTVQR2FNZTltMk5pVzB6dUw2aXV2bDR0?=
 =?utf-8?B?RFRBWnJTN2s4WWlVOGU2UENWb0o5dlRoY3o4YTh3WklZN3VLQUpQamJyWEto?=
 =?utf-8?B?YlptdC9RMytIa0R4TFJuZ1h6QXMrK0w2bnYzNHpCMllkT3kxZWh1OVc3aS90?=
 =?utf-8?B?eEFZOVVKMDVzeU03aWdqR0RRQmtIaXlNeFVjZnRubDVsbTVycFlRUE1UZzl2?=
 =?utf-8?B?WThpNTl3aXllRTVnQzRsTnY2ZXhhQ3JUTFJrMlo3L0g4aHZDYndseTBXK3R5?=
 =?utf-8?B?RmdXTnhGeG01WVF3elo5eHNTaWUzRDhyWTFnbTlwbjRaekhWUzkxbDZoZFp0?=
 =?utf-8?B?MjhQQkxubU9ldkVVRWk5MlhPRUxXOGxSR2dnb05JSlFQcWExV04vUy9tajhI?=
 =?utf-8?B?TVIyZlZSbHBaMjI2dFZTZDNEQVFxUWNVUHVWZXAwcjh1U1dVWWJON1pUMWlh?=
 =?utf-8?B?M3JQa2pZcGUxS0RWbnpoY2trMFpzMFV5U3Z4TTNRTUJ2ckUwaWtCT04rVkdQ?=
 =?utf-8?B?T2s3cXhaV1ZPc2duYUV5bWtjYjFRWXM2Z2FYTktaVDJqRlc1M3UzbFIrMXJ6?=
 =?utf-8?B?NkdWeXhpNkwweTYwSkhKNzhmRm9ybUY2c0gvZ0pQeUtsK2JGSm9TZlNMTVVp?=
 =?utf-8?B?aFVxY25HenE5cUFqS01HSTRkU25IVGZIZE9kTTZsakhXTWhLcEpheW5hWnZw?=
 =?utf-8?B?Q2F5KzN3V29BaklLUk1UQVVWQUNObjU2VjFudXRvdjA0amFPWE9Ua1pwTDFs?=
 =?utf-8?B?Vm56ZitGTE5pQ0kzZjNtdzA2eGZ5ZVptdExMOEFtVmpwNnljS1ZFZz09?=
X-Exchange-RoutingPolicyChecked: afSqJvFxnT6qTmO0GrfvYF9C2BDoEXpDvTf5R5kI2iWNSKp1piYvg5qluV5Vb0hp8HoyKVWGIloEKEApqijARYozy9hPXjGnGRBjIInsLv4v2AWGOnZu511FDTD6C/TnQrsYOpUzFsTqJtWrQjHykQnippxP5W7zAQU6Y//8aUWl+0Op+m91Ez4ZAn84lE4tWLXde67yjCuVqvNvyLfwDt4qefx3yrFxr+cMO4VbrP/AYERU92A4doTFYjbBNpB1NprS8+EFKWnTip4rx46btg8dRYk0NiJAuAf3jqiTl8vD/oHu+jE22JTo7zmAl0eSfSDCWa7m/LzNxPg00kmPMA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 73febcb5-a43d-4129-bb43-08debc2f8d1b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 20:35:55.1562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fEGwvV0RYs+rMNqJmv8H38wPcvinrdnlX809mA6rgux4wOMKBQ+emak84NSDIAm3wZC41N2T8XND7temA0/w7AsWl2s36xhnLvXYKpnIWkQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7606
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292445-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: B7FA55EA1D2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/27/2026 11:18 AM, David Thompson wrote:
> The lan743x driver currently hardcodes the initial value of the msg_enable
> parameter during probe(), and uses this value for netdev message logging.
> Instead, the driver should provide a "message level" module parameter to
> allow users to configure the logging level at load time.
> 
> Signed-off-by: David Thompson <davthompson@nvidia.com>
> ---
> v2:
> - new patch added in v2
> ---
>  drivers/net/ethernet/microchip/lan743x_main.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
> index f3332417162e..793633cced19 100644
> --- a/drivers/net/ethernet/microchip/lan743x_main.c
> +++ b/drivers/net/ethernet/microchip/lan743x_main.c
> @@ -28,6 +28,17 @@
>  
>  #define RFE_RD_FIFO_TH_3_DWORDS	0x3
>  
> +#define LAN743X_DEF_MSG_ENABLE \
> +	(NETIF_MSG_DRV      | \
> +	 NETIF_MSG_PROBE    | \
> +	 NETIF_MSG_LINK     | \
> +	 NETIF_MSG_IFUP     | \
> +	 NETIF_MSG_IFDOWN   | \
> +	 NETIF_MSG_TX_QUEUED)
> +static int lan743x_msg_enable = -1;
> +module_param(lan743x_msg_enable, int, 0);
> +MODULE_PARM_DESC(lan743x_msg_enable, "Debug message level");
> +

I guess many drivers have msg_enable parameters already so  this isn't
"new", but the netdev maintainers have frowned on adding any module
parameters for years.

You could handle this by just always using the dynamic debug capability
instead of the netdev msg_enable infrastructure, but the driver does
already use this infrastructure heavily, so I guess it makes sense to
expose it and allow changing the settings during early init prior to
when the netdevice is available to userspace..

Since this is a relatively common module parameter and not something
"new" or trying to do anything other than aid in debugging I suppose
this is likely acceptable.

Thanks,
Jake

>  static bool pci11x1x_is_a0(struct lan743x_adapter *adapter)
>  {
>  	u32 dev_rev = adapter->csr.id_rev & ID_REV_CHIP_REV_MASK_;
> @@ -3661,9 +3672,7 @@ static int lan743x_pcidev_probe(struct pci_dev *pdev,
>  	pci_set_drvdata(pdev, netdev);
>  	adapter = netdev_priv(netdev);
>  	adapter->netdev = netdev;
> -	adapter->msg_enable = NETIF_MSG_DRV | NETIF_MSG_PROBE |
> -			      NETIF_MSG_LINK | NETIF_MSG_IFUP |
> -			      NETIF_MSG_IFDOWN | NETIF_MSG_TX_QUEUED;
> +	adapter->msg_enable = netif_msg_init(lan743x_msg_enable, LAN743X_DEF_MSG_ENABLE);
>  	netdev->max_mtu = LAN743X_MAX_FRAME_SIZE;
>  
>  	of_get_mac_address(pdev->dev.of_node, adapter->mac_address);


