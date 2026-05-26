Return-Path: <netdev+bounces-291800-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CH+DHQrIFWqMbAcAu9opvQ
	(envelope-from <netdev+bounces-291800-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 18:19:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E8515D98B1
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 18:19:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D6783300F26E
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 16:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB7833AE195;
	Tue, 26 May 2026 16:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dQBrLifq"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBE53AEF2E
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 16:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779811498; cv=fail; b=Qdzs1JM3dqaXvrD28SkXsst9AweBeXVpmGgdVb8GQDdcF/8ZY50cysRjEB83bIK7McW+O5e4LcuKqD6nTjq396LtiHOlWQKu2apG4AnRq0fJjpZEheD4JTE/5utwVU2n4OUxz+KDYYGwJTirF0+UgLAOwhKQ9f8GsRS8XwtV11Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779811498; c=relaxed/simple;
	bh=fbWoYEZLRj6P9NXZ2wny3oHHCG+OHQewmo8zJJVEuEI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ly+oBaeDAZWVZsYOvF2S6dYklLfXo2YDqRNSNlgvhKFuA9A0AxImXAY50zWNCqy7geFEBperrSsQ4hklyinyakNtf+/4B/6gWMhK3YLzJzl8w8z0ntsAAHUiIbl/j5M1gJArXD0sso45Y8r4IRZ7TLeqDAgX2rM4j3aWrvF1D70=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dQBrLifq; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779811496; x=1811347496;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fbWoYEZLRj6P9NXZ2wny3oHHCG+OHQewmo8zJJVEuEI=;
  b=dQBrLifqUprWLcp5UXpv3JfqLw8P5Ai4hPOs6W4/nPrxhwyBwvg9W7KH
   meUFyIljg4zz01yrr/pxt/+a69JWTW21R6QFosU02UWQfvsEQYFY1Sx9y
   hGx2/jnUjlktG9Dx5dQ2ChkFqctShn/Nougg7IysWZ95pO3s92Tmxwcx2
   +PtGJBrGtsSoUQfS62vmMrWhNjYLSNyKnZlJCzjTs/CdXHKH6EW6V5ZwW
   bGzkQZiD+olbXy71kB+pCjQl3xDlbZJ/IMDaE/zUv4VhFY/lo6tKL8Fi4
   P4Oemq+YJd1K9dcaEYivsEHL41z0OslMkAGoy/GuXsKM8ODIehO6YayuQ
   g==;
X-CSE-ConnectionGUID: P1HC2hM7TCqzbO0EhjuLeQ==
X-CSE-MsgGUID: jWZNM1NkQn6j8082ge7v+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11797"; a="80688355"
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; 
   d="scan'208";a="80688355"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 09:04:55 -0700
X-CSE-ConnectionGUID: huG4JZcFRySirrhPkLHuzg==
X-CSE-MsgGUID: A17bd2lITOWYc8qNr9sztA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; 
   d="scan'208";a="245989405"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2026 09:04:55 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 26 May 2026 09:04:54 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 26 May 2026 09:04:54 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.39) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 26 May 2026 09:04:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=USB7C82n4t8fLxrlMkI45NkYfx7K8vJuDSuK0ECLpZ+phZahnitngpUT2WLeIeAP3h2dF0UW1bVNGW1Ipjmaz/tijXE7jdBVgQv4ib1mT7YpRpkMmbWatc87mP27Wi5+NXANrfchTqiQTJdyFIVRZAbRkXHqg+PcrBssTiOJCI/cCyuqd5xJqTifoquwvos8jNZzRYblusCh5Y7/5/6wbXz+ZzWIL3EH/julEHLCbVb1+ihQwGOuNr2oSjqNd5UgMZAYllYK4ay+sCkjfvqNaUGl+gQeLATSOtYj3881mDbmLS96vhfBfT6wSSc1Ia+JvEq9Vx+zvjjzOkjPIwu1WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tdIq96M3Q2t3KQmJDGGmAyG2DKlvhbVjfSiM9JaL9fY=;
 b=ldz1AzD6PbnXDDlqKAOPdfvqwDcyX366QvKliGChwQ2O7fMwyBUqNeVwGj6ODwIfMzCSLzu8huTF4tt3NpEVPvGaxwlE8x/C3wdKyx9FXAdFw5UJtk7LbDQRiPapEp+vthUsBXlDfkZEF9Uh1Lkr9mwAtBxrlTaePOtUbmDb4Hqe0Vslc7V0/pctkoQxb70c7yUADr4T1ZOZQS1Cv5dJR/qaU4ImdvuMCHKjKok6UmH9vAVD+oggq32BXusP6CFom0jzQtcWI75A1s/RsSSt3tYQbeANvc0inRF8dCwXKUc9rMOCveWtk46qmbbubVe4MsJaE6cTJVdbgmUUvJfdvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by DS0PR11MB8763.namprd11.prod.outlook.com (2603:10b6:8:1bb::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Tue, 26 May
 2026 16:04:49 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c%5]) with mapi id 15.21.0071.011; Tue, 26 May 2026
 16:04:49 +0000
Message-ID: <3a16e1ec-313d-431e-8960-abf55701ac5a@intel.com>
Date: Tue, 26 May 2026 18:04:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: page_pool: check nla_nest_start() return value in
 page_pool_nl_stats_fill()
To: Zhao Dongdong <winter91@foxmail.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, Zhao Dongdong <zhaodongdong@kylinos.cn>
References: <tencent_A82EBAB365A8B888B66FDCF115A3DCB8880A@qq.com>
Content-Language: en-US
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <tencent_A82EBAB365A8B888B66FDCF115A3DCB8880A@qq.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR0502CA0031.eurprd05.prod.outlook.com
 (2603:10a6:803:1::44) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|DS0PR11MB8763:EE_
X-MS-Office365-Filtering-Correlation-Id: 01ab7905-08d4-4e2b-4ed6-08debb408385
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|11063799006|6133799003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: GHWXogXb1zUSs1Vcz6LYfiWUP1iIz6lXr7AjgM6UZCWD5nKBhrXqLgi+x0Z3MWGKVSEv78i7fu72IRN8ZVhwj3dNLwP0Gs003KyjYmNsdzkQHLU/D737Fj+vLHL5nAMwfxIuWZiGplgqMrQbefLYJDPXZ1UhKLFZhNDS4w1K8WyriU5hVox8SMGICriFTuf74T9OMdcE4VOqMSEU4m4EDCiG+y5vylfr0sLTtrcB9qA+hRsWu99bK6k6d00KDN9KGJ80asuxJNYCKlNaSByvPOSdaJIBXasFOEoJLxjvIpIsqfh/O2i7GBDjUMojmfOupGpp6iJAlvSBRpKHYIIb8Qcrphi3IbkFBKiWIk+Wt80gGQp6XoMgDd10uwLzyX413jI2g9j9fZJzGuk3QkuKqS306bX17iuLJCA+J5yBuUy5yfSgtIvDPgFjRR7SqBlpjnDYUFpZqaLUtaG3h/e/3GHP3Vx/Tn4u1tCuL4Ogi8sURUb/MjBVL/tGcywa/ceXue3hWw4BpztyHD17dmdyfbJKxjhDvYXCZKMV8xuDWJcXLC6xke0tfpXgu4qb5PZZBWkquaW0XMUsQ375DJ6pgFd/AO8y9bZG7GE8oqsypa+Dl168icteBiJ+yI3BFDSDqFGPIuLQZZqBbIiGwPoaTrNX/j1aeUweqozcp1ynsjWJSMVaF1KJJ9Cbns97uwpb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(11063799006)(6133799003)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TVZqdTI3RWdmMlVKT2w3K3BVa1JwY3FFcFlrUjcrUkpGaWN1KzRTaDIzVW9x?=
 =?utf-8?B?TlJDU1ZSWHhOSW1WdXpRV243ekNYM0k0S1p6bVFEL0FCS0IrV0lZLzZ3dnQx?=
 =?utf-8?B?VjJuRStscUZCZDN2SjYxMGZWd0VORGRqR1BJcmltK0F3QzY1WUdZU0tUa0hx?=
 =?utf-8?B?aXBqNnhVV2xKczAwUGNUVnVGbVkvMzFCY3FFc3BOektWbUJuSUJwRHpHQ292?=
 =?utf-8?B?cWZXV0puL2I5MWkvK1FtNnR2bzRuNXVpNGtZcy8xS0svTS9zdll4UWl6dU1O?=
 =?utf-8?B?WG1MTWtDYmh1R2FBTFh0a2dEUHBkNkdrQ3lVNGZYMDQ2TUhqd1lNN0JmSENO?=
 =?utf-8?B?aWJGSndBTlVxaUROMXpmdHQzQXE1bXNaRHE2VkdGTE1xTkpjbXpnUzlEdDZT?=
 =?utf-8?B?RmhOZnU4c041MXBqdkhWd3ZQSVd3R09zYnc1VEFoTTBqWlFKTHdpYVp4NjRl?=
 =?utf-8?B?b0Y1UExuOGFHT20yR0hya0U1T0MwUWphZjArbXFLMmN2YUM0RDJ1WVJBWTh6?=
 =?utf-8?B?czUrTlRvSWhhOEkrOWNkZnZjbXVIZDdWZkdlUzlTQndsR2hmSytIdGhEQkVI?=
 =?utf-8?B?dXpWK0FVRUJHVnJpYWxGUjVhMk5wNU5GOUx5UlBRNWdGR0NtdCtOcVZrd1VU?=
 =?utf-8?B?NWNXS3hHSjQ1Rzk5WWl4THpnSkJGUW9WajZFQnRlaDBYbGROc2luM25RSkZG?=
 =?utf-8?B?SzRSSFVRT1pyZDFjcUFES1V5RjJlZG9FZWF6TVYzYlBZajI5UUp5ajBmWFpq?=
 =?utf-8?B?SUJScVdOYlUrNzBzRlZhdW81VTI3M1pmT052ajFoZGF0V3BZbEo0R3VjYnVK?=
 =?utf-8?B?YmY0SVRzenJMZUxLWUlUMHQyUXpkaTEwUW5uZE1RL09DdXhJU2NvWTBHYlMv?=
 =?utf-8?B?QTlLUVhyYk9vaVNUTlhYNDJSQlYvNVM3a3hUYkFWVTN5Y3J6NHh6TDNtODhE?=
 =?utf-8?B?Vk5ZOU56SUx6ek5NQW9DQm01bFN6cGx4YnJ6YWVja2V1V0JiZGFGRDVCOHhk?=
 =?utf-8?B?NDVWU01vS2s2YmtlYWFreEpzTGxNd3JKdGJYbUlLK25RUGR2T0ZOQmdlMSsr?=
 =?utf-8?B?c3dHMzBSNS9DTnpaV1ZFcUgvUDl5cjQ3TnJaU3JsY3BIWTB0ckp6UU1FYzBi?=
 =?utf-8?B?ZGdXbHQxWHVrRjhJa0d0OTFyQmxjN3dNa25FWDRLZTZaazJDbkI5Q29JVHlR?=
 =?utf-8?B?cEFHOEovNEMyc2c1Y3ova1g2dnB0b2dzK001VmV4NDlaYStXVU8vTFZvN3R4?=
 =?utf-8?B?RDcrK2NYRkUyS0RoWlJTQzRFWGhVdnlGZUhoNUhtaTZlTThmMnV5cmNqZzEz?=
 =?utf-8?B?aGVkYUl4YlhFZE9DdVJCdDBqYXZOQzg2U2hVeDBXRDJ6eC9EcUt6Yk9kYjdS?=
 =?utf-8?B?NFZmbmhkVWgxdStickduRnUxbXp3V1lVb2pYQStON0paT3E4SDJMNjBBOVlq?=
 =?utf-8?B?OWhLdExsNWdoZDg1Mm41bExaTjZwQ1ExVUdQbWEwbTI1Y2dybDkxdEpObzE4?=
 =?utf-8?B?VVBzYWNJMnI4VGJSb3FvcmdrQit1NzhGdFQ1MTJYZk0vVUFpSDdnYzlhOWVH?=
 =?utf-8?B?VmJQUkJ0MDhmeUdyY0pPcC9OR21GcjVoaWJvMkRoRnpOMHZhTVV1eXdxMjha?=
 =?utf-8?B?TzFjTmUzdmNqVGlCR0s0eTBlbzc0bk8xRGdra0NxZVFNZC95cXVkR0tnRVFS?=
 =?utf-8?B?V3dRNG4xM1Q5aEsrQjZxYU85QnBRSFZWN2dzTDQ2S2p4M1pmU2RUZ3ZoZmh1?=
 =?utf-8?B?aStjN255QnFEeXpnU3VYTEZtTzhLN0xjM3dBZkcxdnhhbTV4VkNQQkcydDJU?=
 =?utf-8?B?bGxCM0lQbnlvWitBTUV6K3FpT0N6dDEvTUsrdStlamZpVTFtOTI5RjNkRW9o?=
 =?utf-8?B?VGhQZWVOR3NoUlY2eS81czY5anlSbVNUb0JaNXZzVVl6QzRZclI5eGZ0ODRp?=
 =?utf-8?B?ZU1VYWladmFyRi9rdVArbzQ4Yk03QWNJTWdqcmRqL2ZRTU43QnQvU2FtKzd2?=
 =?utf-8?B?cGZuZjhNZjdob2s3aUxtR0lRM3M2WmhkeUdiUzlMbUFyeEQvOCtlWDBEaENt?=
 =?utf-8?B?bm9reExMbGZiTzhRckU4Z3IrYlRLTG54QlJkNXVyMFNMQ3ljRTNJbUk3eFUy?=
 =?utf-8?B?RHZubTBWOTVGd0ZXZE9xWEF5SDgrQmIzRk91elJzQUZFSGgrbzR0VzAweFJH?=
 =?utf-8?B?THRzWm8yWW5SMC9mSVVpaTZnWER3U0I2NjI3dzU3U3FMTmNmYUxZN0NvMDRl?=
 =?utf-8?B?OW1tZ3Y5LzN1SGtka0NPclNmeG5mbEpWeUZaTnNvSGprZ09za0YwUllPdkp2?=
 =?utf-8?B?M1ptMnhKbEhUSjJSV0lEc2t3c2UwZ0U3ZWQweGQ0VmJUczI1WjEwSUh4SHRH?=
 =?utf-8?Q?Wo6NzAZH3+vY6UoM=3D?=
X-Exchange-RoutingPolicyChecked: jFshBGspIWyKu0vG0zMmZCUREuI2DmtlKlnfLEkIa+Nx1+IGJTGu5u6GredODe3FjoiE0BdX7ytRNnWL0pC5XPmY6uq82FHpySGwj0dNG/sdOU7Aq7yW+8gybjirQHPTWaG02ZD/14Xng/yDUeM/qYrpVF7Hm7zpbGv/FyML2efXU1hP3MXnUFNW5ZTa+Nb7kTu4d5kfbbpkrAxzUGW3YkCwlzUh4hWVuQtBYcI9pzgVuzNCbhM/beWJeh8MK302FGxAxAif+Q9XrcPyaowEZBpc6raM2h6+OAn4X7Skv/FWhNGWYcT32LEb1Arl9iN2s/2jpQGif0LRCab4zWqqyg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 01ab7905-08d4-4e2b-4ed6-08debb408385
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 16:04:49.5364
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6xnviwM0s/iDLbaZZys5S+a63bZGHVjwFWAg1cCRZHLlV0kFNE9KmBley6YPofCu1Xz3LAMh6+SdzFr7t7VNS7+24R0t8Z9vBEDc3Svb6pQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8763
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-291800-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[foxmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,intel.com:email,intel.com:mid,intel.com:dkim,kylinos.cn:email,foxmail.com:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksander.lobakin@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 7E8515D98B1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Zhao Dongdong <winter91@foxmail.com>
Date: Tue, 26 May 2026 14:51:56 +0800

> From: Zhao Dongdong <zhaodongdong@kylinos.cn>
> 
> nla_nest_start() can return NULL if the skb runs out of space.
> page_pool_nl_stats_fill() does not check the return value before
> calling nla_nest_end(), which can lead to a NULL pointer dereference.
> Add a NULL check after nla_nest_start() and abort the message if it fails.
> 
> Fixes: d49010adae73 ("net: page_pool: expose page pool stats via netlink")

A "Cc: stable@vger.kernel.org" candidate?

> Signed-off-by: Zhao Dongdong <zhaodongdong@kylinos.cn>

Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Thanks,
Olek

