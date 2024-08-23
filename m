Return-Path: <netdev+bounces-121233-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A0B995C3FF
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 06:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79E88B21531
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 04:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7471CD32;
	Fri, 23 Aug 2024 04:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TJiMCwV9"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C708B849C
	for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 04:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724385631; cv=fail; b=Z0q+jSK+0XY3W5GBIASRJjjwQZEDP2yor2uRscKY2SvwQ51J7/EsK1elob2lhGwabCAVeG58vL7SeqN7Miv7ICeUXR1fs8avbOXNKWRmIYGFDwXoZLCVc2Hi1oZxoX8/nG4SMWCDe7/h+7fLi1kD4m54aFDNHepqcRtKQXMpyLo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724385631; c=relaxed/simple;
	bh=J+q5m8Z+Tt4Rtu3+rCO4LxmphKqQlf7F1lBZFQaDaTQ=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nW7mwK0enyHSz0pgVElkv3HgfstKS4ywy+mh2VOz8ouCimQ68IdsOVnyXQL6J6P0ostr7/YvbNDLpPNGtlRYwL5Q9dDqPEqUF5f1/KMSs6zGyS6dZlRaV1DeTCPE8YHtqKGRAmTSm7S9iWTi/PoLRrFXozm+P1lGWESfM1B9RbE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TJiMCwV9; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724385629; x=1755921629;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=J+q5m8Z+Tt4Rtu3+rCO4LxmphKqQlf7F1lBZFQaDaTQ=;
  b=TJiMCwV9rFZtMu76sFpvuVrHZpLpi8YM5aKCJyaaoYt773GOdtZ+ki+G
   IEO9c85RkQF0FUcTSE8zdAWR6idcTrqU60qqlMnnS2zpE2wfyGhpVRXGz
   AJQbe9ercRqcmTHFJ3lK0YEB8jGBjEZgkbpIAh+ixJOGMvPNiDh62ZT1r
   Snvi3auYO8u8M+nU0OcN6DgdZPC44J8uCJi+xND8hIikxGntyBSodU5Be
   g5WfjxJjzGA1+fdhxbUZCevspsVnmy36utCk3fMZisAk6gcOGTTCz/wbO
   IpiH2rN9lMCi60Enawed8muX8nMoi8DSb2bcUDSA/V+owPwogc1Yk6GKJ
   w==;
X-CSE-ConnectionGUID: ez7OP568T0ydkGfapOpKxA==
X-CSE-MsgGUID: f3d7z8RsRryux2Pyt1aysg==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="26705409"
X-IronPort-AV: E=Sophos;i="6.10,169,1719903600"; 
   d="scan'208";a="26705409"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 21:00:27 -0700
X-CSE-ConnectionGUID: B5xHqko6Qgqez2Kbbfya4Q==
X-CSE-MsgGUID: 06DghE4iT0K7NOoWBVhUNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,169,1719903600"; 
   d="scan'208";a="66598655"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Aug 2024 21:00:27 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 22 Aug 2024 21:00:26 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 22 Aug 2024 21:00:26 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.45) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 22 Aug 2024 21:00:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IXbAgOzlSVU2k7wMBpuOzk0wIg/i2y99XndnVwvVzPhiN7do5PTVj14sT9xSf4H59OokI1YpBPskjqcrNjP0qTZApEk7FJNuciW+rYXZ/0z/jpY5y9uDVHnmaP3WFh2rjk/o/Tm2X7K+hduYWUl4VBkmwNoPi4//8ocZeFzB77xbO/PwTGuAw+XUhXsB3TP5xeAdre5q/rG+1bqaGvMqpJ2CHW1bmwG4FgZ88Zj83zWD4ymGN7/vy/T0g1N9ZG+9xPN2gnHWFPFonws3PwXPcy7ccs73Qyjdiy9xK/oherWTe9Vy4A1xGD28quRlbyAGU4vh5sEMUCjBhziaJOWGug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e4KshqATvujBaPngjNNx3jiy9oOgWQizn2R9qb1SYjU=;
 b=kxfDcADZxztvUtdp44SgWaSatwMSNSf2kREYrSfRL5DpSFKhp0rcIMZ8CphR0NRzdloA8a/fUwuN+rJu5Sedp6E2uzXjAJyRBQYFMQhMuU63yPz8H437Mewlk+ExmA5nKpT5NThB5AxBQHFH7GIQff5xvepL1mQpkZArZjIWTthNr0w7k8eBSspxMqhK5/4IqZG+z3pgF3lIA6LC9O1UEx7yG2KLexuCQ5YbKkC+7SDVrrL4E07sWmL5KId7Px0B3eLXx1s4MGizgrgCKsc4vVeTm+3qX1xZqB7iWZ6HjfOIseqFfoG98pGxhwE2HgtjPWJw2B9wBqhlWy++/OI+Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH0PR11MB8086.namprd11.prod.outlook.com (2603:10b6:610:190::8)
 by DS0PR11MB8115.namprd11.prod.outlook.com (2603:10b6:8:12a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.26; Fri, 23 Aug
 2024 04:00:19 +0000
Received: from CH0PR11MB8086.namprd11.prod.outlook.com
 ([fe80::984b:141d:2923:8ae3]) by CH0PR11MB8086.namprd11.prod.outlook.com
 ([fe80::984b:141d:2923:8ae3%7]) with mapi id 15.20.7897.014; Fri, 23 Aug 2024
 04:00:19 +0000
Message-ID: <8c14cc3d-5da0-4649-add1-ea3e9f010677@intel.com>
Date: Fri, 23 Aug 2024 06:00:13 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] eth: fbnic: Add ethtool support for fbnic
To: Mohsin Bashir <mohsin.bashr@gmail.com>
CC: <alexanderduyck@fb.com>, <kuba@kernel.org>, <netdev@vger.kernel.org>,
	<andrew@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, <kernel-team@meta.com>, <sanmanpradhan@meta.com>
References: <20240822184944.3882360-1-mohsin.bashr@gmail.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20240822184944.3882360-1-mohsin.bashr@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0186.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:8d::10) To CH0PR11MB8086.namprd11.prod.outlook.com
 (2603:10b6:610:190::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR11MB8086:EE_|DS0PR11MB8115:EE_
X-MS-Office365-Filtering-Correlation-Id: 3768162d-016d-49fd-2f0f-08dcc3281ac3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bGFRTXhuZkQ3OGFFemtwYWtHSkdqQlJjeksxc0g4Vlh5U3BjNGx3T2RCQ3FZ?=
 =?utf-8?B?emR6UnVaWjdHa2RVNjFtSUhHQlVUbWhSUVNoRmFXMGh1NjUyRit3Q3dwYUx3?=
 =?utf-8?B?b3RlcGc5cndmNUZ4K1FSaENCVWxyZkJlUFBqM1V5TnBNS1ZsSU00QzBUemc4?=
 =?utf-8?B?T0EwdVZWaXhHTDJ5Yis3Z3VDTm9GRXBYNU52bGVqYTE4eEViNTFxbjY5NnVv?=
 =?utf-8?B?ZHNYZGYxOThIQjZVVEkwdFBGU2VoM2x3ZlV0SkgzblRPY0hBV2R0dmIxZHdz?=
 =?utf-8?B?eDMrUGErc2ZoUDdyMDRxTEMreTVLQ2FXUWI3M2F6TnpvRjF4UGVIak5QWVpM?=
 =?utf-8?B?SlE5bkdnUVZ1Zk9TblJNeUpTVU5pTTNEYkFVN29BS081ZFM1aEVpVHVQSDdk?=
 =?utf-8?B?TFEvc2V0WWhQckVXNjF0U3ZERE9QM3lGeW1USGdjem10QkdiRTVTRGdDV3k4?=
 =?utf-8?B?N3ZTNnh0KzhWRm9YMXJEK3F5L1NHTnc1b0JjTDdjbWxwY1RuMFVDRjcveFFO?=
 =?utf-8?B?NmE1TzU0L20vdmhYT3FNcTk4YUIrSUZkekRtb3FuUXBxSzY1NGNlci92Sk9P?=
 =?utf-8?B?YVp6TXQxWEFBa0l1MEJ5WVVlV01UYTBaNnBlRlFBS3NkOEhmaHo1ZVJJWWdC?=
 =?utf-8?B?MkF5RnBpem9KcXV4dEQ4RXluMVdpNWh0bUJjUm9KVWFjZHdoVlArTk1iRWx3?=
 =?utf-8?B?WFM3eUpmS2NuTmZlRXRnRXp2WXBjclNsM2JTSzFURG5SMnZYRXYrdG54OU9w?=
 =?utf-8?B?M2hJMFB5dXlRUFV4bmJZL29SMWpuSkdhZzVHRDQ4cjFseHloR3RPS2ZLdStj?=
 =?utf-8?B?bFcrU2NsMitvZ0V4a0M3T2t6VmlFYUtVUzJmUzI2cXJkdHVzeFh1SHNKY3k4?=
 =?utf-8?B?RUhGNlQxb0tjVnR0bmIwUjhjTmFqOHJtenI0UEtkRkdsamRwU0VrN2Zkcmw2?=
 =?utf-8?B?eWhobTJjTUxYN2VNQ0c0RGVpaWxicjBwM2xSbFduQm94Q0VNWUN3Z2JFT01M?=
 =?utf-8?B?Q0kxWXhvSWl5UDRWNDdYVmF0R1lSc3hNeW4rNHNJTzcycFNSM29HZVpFUjM5?=
 =?utf-8?B?UXM4VzZ2NE1sUTcwMGFIcGxPSVhHRWF5VWFuVHNvMDV2cmhUZno1RUhsN3B1?=
 =?utf-8?B?aTVaLytmc1FuOWZKdjFsS3RsY2tLVzlrWjc4R3R2OWNINlE0VUJOQU56QzQw?=
 =?utf-8?B?V1JxR3hzQThmZlM0YW80bGVraDJnUStnMm44Q0JvOEEvVi9HRHpFa0xBN0Ez?=
 =?utf-8?B?Ykp3MXdyLzdsWHhqTE5jUFBBdkMwOTgzbjNzdC93bWdUejNsVEpUWWNkcjFJ?=
 =?utf-8?B?eGtiV1g0bk5leWlrVy9CcVB5ZEpKbHNqRHZram5FZDg1U0R2b1V2VXRteEQ4?=
 =?utf-8?B?aGRNa1RLMmttcHFRTDN0eVM0VW13KzRWbk43NmJ5WnQyNm5pdUtLVVYzd05W?=
 =?utf-8?B?ZmNGb2tCc0FSNnlhWmVrY1RkWTExeGZtQ2NNbzlDMWkrSnVpaUNheXZFMkVq?=
 =?utf-8?B?bTIyTDJYNzVPNm5DTndYQ3B1eVY4QXg3SW9jNjdFQkVCS0FrN2k5L3dob0J3?=
 =?utf-8?B?UWdkclQzVE1PSWNJSTVOZUFQeWpkZWhuWDVHY1dEV3FMQ25EY0diUzkzcVpX?=
 =?utf-8?B?cWhJNU8xNlFTZXRRTGNhSHhTUE5oRVpwcnhLU2RjcUtWQTBUcUpFNVluOEVs?=
 =?utf-8?B?ejRUZEt5ZE43OGdrMW1PVExsQVdZbHM1TVJsQncyVTBCNUwrVHVHc2RRK1dJ?=
 =?utf-8?B?WXAwVEZHS24yQnZnUVlyOUNob3doMXBVaW5icnZvQk1jZWp5OGVYVFU3b1VU?=
 =?utf-8?B?MldOM0JycmFWK0VRZDJVQT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB8086.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QjNCNGJzV2JrYVhSRVNzV05PZFhzSlk4Q3cwcHdqUDh1VWZVRVdKOHI3c0pI?=
 =?utf-8?B?SjZlejJQZ0c5dUgrWVcxQkJDVDQxbm16RDh6RC9GZHdHemduVjVwQ3pSSVhZ?=
 =?utf-8?B?YjRxd1ZDaUR3MFg5Y09JdVpaa0Q3U1B3QTRHbVdEaEM2ZkVUcTQxWUNjNm1r?=
 =?utf-8?B?dWEyMGhVZU84Z0NwVFJqaUdqdVVidU1ydTRjVXVJMW43bjA2b0xkT1RnVWla?=
 =?utf-8?B?ckZ3cXYrdUV5dWcxK3YxS1Q2elVUQWwrOFVLWGdQNXJaUXhaa0RaWDAzNUVh?=
 =?utf-8?B?ZWRjUnlNYksycUFaM2hLOU5mS1FIdVlIWVllY1UxVHFGZzJBNjZkM2c3WTRK?=
 =?utf-8?B?c3ZiT29kdkdPTzdpNDZIaU5wVnUwakxpcjVxRDVBOFNkMFljRXM3RTRJQzky?=
 =?utf-8?B?ZDJzYU94ZHFTZUFXTlFBeEVwV3BqbHdZT3JKbFJyZk42QmhDQkNDUjVhaUxl?=
 =?utf-8?B?YTRjU2w1eVo3SUdsMU9pQ3dPQjhxWUdmcnJnMTkzS3NvTE9DZCtQZUowcHpD?=
 =?utf-8?B?d1Q2MUJlZXQ4Y3pFSGpxWE5Ua3NIVW5JdllKd2dBUFpwVUkwaWk5UmtEYkho?=
 =?utf-8?B?eWwyVldDclZNdGpxZ2JpMWlKN0ZFRmpYOGNST28ySEErSHI0aXlTTTFWTDIx?=
 =?utf-8?B?Z0E5dHNnTWRrdGJRaWVuaVBSYjRMbkliSTNCdm8yQ2pES2dQNnZDUnJnLzQ4?=
 =?utf-8?B?WnRScVY4VkEvcmdJdkpHSmpqZTJ0bDBnLzZZeHhDdnQ1MkViSDBPMk8wQ2F4?=
 =?utf-8?B?amlaQVJPbU90QnpMbi9vcHpYQW9XKzJ5RGtPMk5vY05jWmxTZll6ZXpqVlli?=
 =?utf-8?B?UUtNNDZDNThUeFUrUkJYcVFXZDNuMEorS1B5M29SYTJNaUNzWGo3ZE8rS0hT?=
 =?utf-8?B?M1AzY0VqUDJnYlN6eDBERDhHQ05NaXFUbXlJNUM1UkhGMDZvRUM4MmJLUnNE?=
 =?utf-8?B?aXcydFJyTkEyMXF1djJFang4ZzVTVEdaRld3VTNuQUlTaUxKOUtpNEdRUTJT?=
 =?utf-8?B?UG04QnFGbmRUMWhQQ0VvL24vVVg3bi9CUDBPU0RxQmJYMy9kTUU5SFQyVVcv?=
 =?utf-8?B?QzROQmJLdnVSaG9rNkszcmluTFNKNGhXMUt6WU1xMnVzZXVOOExLWGlrZi96?=
 =?utf-8?B?bXhuOWtHRE16NlFEZnMxOFYxQlNrY21YQ0lCdmNqeElhSHU0MEk0TGpsVFha?=
 =?utf-8?B?OVRGYlhOaGxGRDZ1bkpNZUpXLzVzbGc2T3BId0FtNnA1MTJUcmRMcUplZ0Rn?=
 =?utf-8?B?ZDVBWnFHY3YxeDlibDNZVGlVNmxxaXN2SEhpT2RXMmZSaWswVDV1emxoRWg1?=
 =?utf-8?B?Yk5JUVlZaFFEdFBCenVaNTNsdldXRUEycG9UMkovZDIzUm9OZWtUYU9NN1c2?=
 =?utf-8?B?S2t0aUJLanV3QmdsS3lyaW5VcEI4em8wNlE3U3FLUTN3Z1BWTWxnMjdxcExR?=
 =?utf-8?B?OXh3cGN1dXdXRHNQV0RHbFUxMFQ0WkM3MnJybG95OU91Sk9XY0R3ekcxM3dh?=
 =?utf-8?B?S056ZVkyYmxHOHlyNkRxK3puWVNBdE9VQmQ4aHhJdURyT2ZJMkdxQXVodnFv?=
 =?utf-8?B?ZTV1R3RwYWN2dkZiaHhjMUs4ZmxCMnhCNjV2S3lyRjVVbU1FaEdEbC9Bcm8v?=
 =?utf-8?B?Q1JnNThEVGkvOC8zZUUyWUJxa3BsNWJIb3lmZGViblE2aUd1V2FXcXBPZGZJ?=
 =?utf-8?B?ZmVmcDFWUHIyUVdxOWdBR0FzcE01VjRWRy9pUW1SdzFveFpvTVJLcHhRdXVG?=
 =?utf-8?B?SnFJSFJGOU1paWVxSjJNanpCejY3SFpzOHUyNjNUeDdqdDhoekFiaVVyby9V?=
 =?utf-8?B?aHRGbGNXV2hydlYzNG45UGRKcmNFMlppT1BhYjY4Ny9FMWRJdEdPaXNBUHFB?=
 =?utf-8?B?WEpKWmFBVE1DMFFTcXRpd2twRFQ3WXByNG83QnVMaUo3TDJTVGRrWUE5L2Mz?=
 =?utf-8?B?VW9lUXRCKzFJeHg2MWtaU2NOdDlQZ3dWeXdORlJXNUpJRlVqUWxuU0hGOGZO?=
 =?utf-8?B?dFBQaExTa2x2SklMOC93YllRL1VaN0wrMkxhUWg1U0ttT1FlTmwycHZ5M3Vn?=
 =?utf-8?B?ajRGZDYxY2tWWGdWUCtOci9mSWxUZ0E2YkxuR1FnMmI4T28zak4xeHZRRzhZ?=
 =?utf-8?B?NGZ6bVUwRWhzRVgrTXd4ZVVOVzJMY0xiVzlPQ21ENFlUUXZRUEZlUTlrcklw?=
 =?utf-8?B?aVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3768162d-016d-49fd-2f0f-08dcc3281ac3
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB8086.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 04:00:19.6007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SefmHsW0hWyePbRC003/H1EYoPUejSGW0HiVoaRBrNhNFbakLBkJ2OtlEuF9eyVVYlQfqZVnbD0i9hNw3smrK5QSe+r9pKzCIg7kNYie4Gs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8115
X-OriginatorOrg: intel.com

On 8/22/24 20:49, Mohsin Bashir wrote:
> Add ethtool ops support and enable 'get_drvinfo' for fbnic. The driver
> provides firmware version information while the driver name and bus
> information is provided by ethtool_get_drvinfo().
> 
> Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
> ---
>   drivers/net/ethernet/meta/fbnic/Makefile      |  1 +
>   drivers/net/ethernet/meta/fbnic/fbnic.h       |  3 +++
>   .../net/ethernet/meta/fbnic/fbnic_ethtool.c   | 26 +++++++++++++++++++
>   drivers/net/ethernet/meta/fbnic/fbnic_fw.c    | 13 ++++++++++
>   drivers/net/ethernet/meta/fbnic/fbnic_fw.h    |  6 ++---
>   .../net/ethernet/meta/fbnic/fbnic_netdev.c    |  2 ++
>   .../net/ethernet/meta/fbnic/fbnic_netdev.h    |  1 +
>   7 files changed, 49 insertions(+), 3 deletions(-)
>   create mode 100644 drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
> 
> diff --git a/drivers/net/ethernet/meta/fbnic/Makefile b/drivers/net/ethernet/meta/fbnic/Makefile
> index 9373b558fdc9..37cfc34a5118 100644
> --- a/drivers/net/ethernet/meta/fbnic/Makefile
> +++ b/drivers/net/ethernet/meta/fbnic/Makefile
> @@ -8,6 +8,7 @@
>   obj-$(CONFIG_FBNIC) += fbnic.o
>   
>   fbnic-y := fbnic_devlink.o \
> +	   fbnic_ethtool.o \
>   	   fbnic_fw.o \
>   	   fbnic_irq.o \
>   	   fbnic_mac.o \
> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic.h b/drivers/net/ethernet/meta/fbnic/fbnic.h
> index ad2689bfd6cb..28d970f81bfc 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic.h
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic.h
> @@ -132,6 +132,9 @@ void fbnic_free_irq(struct fbnic_dev *dev, int nr, void *data);
>   void fbnic_free_irqs(struct fbnic_dev *fbd);
>   int fbnic_alloc_irqs(struct fbnic_dev *fbd);
>   
> +void fbnic_get_fw_ver_commit_str(struct fbnic_dev *fbd, char *fw_version,
> +				 const size_t str_sz);
> +
>   enum fbnic_boards {
>   	fbnic_board_asic
>   };
> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
> new file mode 100644
> index 000000000000..0dc083fd1878
> --- /dev/null
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
> @@ -0,0 +1,26 @@
> +#include <linux/ethtool.h>
> +#include <linux/netdevice.h>
> +#include <linux/pci.h>
> +
> +#include "fbnic.h"
> +#include "fbnic_netdev.h"
> +#include "fbnic_tlv.h"
> +
> +static void
> +fbnic_get_drvinfo(struct net_device *netdev, struct ethtool_drvinfo *drvinfo)
> +{
> +	struct fbnic_net *fbn = netdev_priv(netdev);
> +	struct fbnic_dev *fbd = fbn->fbd;
> +
> +	fbnic_get_fw_ver_commit_str(fbd, drvinfo->fw_version,
> +				    sizeof(drvinfo->fw_version));
> +}
> +
> +static const struct ethtool_ops fbnic_ethtool_ops = {
> +	.get_drvinfo		= fbnic_get_drvinfo,
> +};
> +
> +void fbnic_set_ethtool_ops(struct net_device *dev)
> +{
> +	dev->ethtool_ops = &fbnic_ethtool_ops;
> +}
> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
> index 0c6e1b4c119b..5825b69f4638 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
> @@ -789,3 +789,16 @@ void fbnic_mbx_flush_tx(struct fbnic_dev *fbd)
>   		count += (tx_mbx->head - head) % FBNIC_IPC_MBX_DESC_LEN;
>   	} while (count < FBNIC_IPC_MBX_DESC_LEN && --attempts);
>   }
> +
> +void fbnic_get_fw_ver_commit_str(struct fbnic_dev *fbd, char *fw_version,
> +				 const size_t str_sz)
> +{
> +	struct fbnic_fw_ver *mgmt = &fbd->fw_cap.running.mgmt;
> +	const char *delim = "";
> +
> +	if (strlen(mgmt->commit) > 0)

isn't @str_sz holding the size already?
anyway, non-emptiness check should be just mgmt->commit[0]

> +		delim = "_";
> +
> +	fbnic_mk_full_fw_ver_str(mgmt->version, delim, mgmt->commit,
> +				 fw_version, str_sz);
> +}
> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.h b/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
> index c65bca613665..221faf8c6756 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.h
> @@ -53,10 +53,10 @@ int fbnic_fw_xmit_ownership_msg(struct fbnic_dev *fbd, bool take_ownership);
>   int fbnic_fw_init_heartbeat(struct fbnic_dev *fbd, bool poll);
>   void fbnic_fw_check_heartbeat(struct fbnic_dev *fbd);
>   
> -#define fbnic_mk_full_fw_ver_str(_rev_id, _delim, _commit, _str)	\
> +#define fbnic_mk_full_fw_ver_str(_rev_id, _delim, _commit, _str, _str_sz) \
>   do {									\
>   	const u32 __rev_id = _rev_id;					\
> -	snprintf(_str, sizeof(_str), "%02lu.%02lu.%02lu-%03lu%s%s",	\
> +	snprintf(_str, _str_sz, "%02lu.%02lu.%02lu-%03lu%s%s",	\
>   		 FIELD_GET(FBNIC_FW_CAP_RESP_VERSION_MAJOR, __rev_id),	\
>   		 FIELD_GET(FBNIC_FW_CAP_RESP_VERSION_MINOR, __rev_id),	\
>   		 FIELD_GET(FBNIC_FW_CAP_RESP_VERSION_PATCH, __rev_id),	\
> @@ -65,7 +65,7 @@ do {									\
>   } while (0)
>   
>   #define fbnic_mk_fw_ver_str(_rev_id, _str) \
> -	fbnic_mk_full_fw_ver_str(_rev_id, "", "", _str)
> +	fbnic_mk_full_fw_ver_str(_rev_id, "", "", _str, sizeof(_str))
>   
>   #define FW_HEARTBEAT_PERIOD		(10 * HZ)
>   
> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
> index b7ce6da68543..921325de8d8a 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
> @@ -385,6 +385,8 @@ struct net_device *fbnic_netdev_alloc(struct fbnic_dev *fbd)
>   
>   	netdev->netdev_ops = &fbnic_netdev_ops;
>   
> +	fbnic_set_ethtool_ops(netdev);
> +
>   	fbn = netdev_priv(netdev);
>   
>   	fbn->netdev = netdev;
> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
> index 6bc0ebeb8182..d1abc67f340d 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
> @@ -55,6 +55,7 @@ int fbnic_netdev_register(struct net_device *netdev);
>   void fbnic_netdev_unregister(struct net_device *netdev);
>   void fbnic_reset_queues(struct fbnic_net *fbn,
>   			unsigned int tx, unsigned int rx);
> +void fbnic_set_ethtool_ops(struct net_device *dev);
>   
>   void __fbnic_set_rx_mode(struct net_device *netdev);
>   void fbnic_clear_rx_mode(struct net_device *netdev);


