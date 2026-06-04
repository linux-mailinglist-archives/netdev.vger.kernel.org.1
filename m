Return-Path: <netdev+bounces-295423-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fl+1CbXvIWrUQgEAu9opvQ
	(envelope-from <netdev+bounces-295423-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 23:35:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D92643A27
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 23:35:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b="m7p/+0kb";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295423-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295423-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 07A913014546
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 21:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 924783D331C;
	Thu,  4 Jun 2026 21:31:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75603FCC;
	Thu,  4 Jun 2026 21:31:52 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780608714; cv=fail; b=SW3MEhTIu9FQU39Ccwj6/HDWgt1VoKjJx8wSBc8dK6KcRyTgZGRA/iGSbJEMP6brsfNjUb5bhI+1P1hgM+WPKMLu3FtkJfLLziJUY9NTEh4nb0ln3PukHWYobRKjN3jfhh5MObLH3Ic7Gg/h/2vFHA5IigCB6/fzZR+blG3rC70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780608714; c=relaxed/simple;
	bh=HpvS6nBajtMaf607tTWevi4mEGGiX81e/28oQgjkLws=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=R6unfhi6c/1tTZacTQrWxa5MPPic4qvORvAUavuaEJv0U82DyGdVKCl0au/pLEalBxo8livpqqoSgZVQjo1PlzyFdl4E9PTTi7C7o/CCwmiOeKBNxWhzsWpS4cu/MXzt7bvAIwBIO0SQsxQAm8q9hYWNa2QnmOe5vT0RvyZstf0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m7p/+0kb; arc=fail smtp.client-ip=198.175.65.9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780608713; x=1812144713;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HpvS6nBajtMaf607tTWevi4mEGGiX81e/28oQgjkLws=;
  b=m7p/+0kb4rP+SOh0ne2QjjCqnz76ijxbQYxVkH4TPtzHriN28a75zbkC
   2Mg+vq2Axdi3GaQOtMW6PXJa/gLunuuaB8EACfBV8AFxVwuT3qWnh0YpO
   dyypYSa8moqKVtHnI8J/+qeMGPJTyDk+Zjohu1ezrZW8YveQ9HpEzpuJK
   NqNq7YYz9eFJP/jYT1+xcCGcqpvZ3qCIbabiktSjFCL9q1VV4knOz1kMJ
   Jv7i7J+3nvdbwTTfXmqjM5EUJ+1d+MKfLqa0ynsuLYQz4gMzUXasxWh8a
   akkwTEqVrKnOOgNqv9J65jfzcNALonPltDUyLI4n8rtieDpE/yEICm8k7
   g==;
X-CSE-ConnectionGUID: V5Y0wEVKSTqFnW8oNS813g==
X-CSE-MsgGUID: t8ZT4l5zSK+mwtxmKFw8QQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="104106521"
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; 
   d="scan'208";a="104106521"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 14:31:52 -0700
X-CSE-ConnectionGUID: kRc/a/wtTmG7CzNGoRZnKQ==
X-CSE-MsgGUID: 7HRBBdACSNSSLi/vZOXnsA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; 
   d="scan'208";a="243575676"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 14:31:52 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 4 Jun 2026 14:31:51 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 4 Jun 2026 14:31:51 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.22) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 4 Jun 2026 14:31:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rcDqs8nAx33r7/IcN6+bBSyZZeDsXlOMwST6AM20b/dDLQGJvS3zPVkyWMcABAwARAm532b/rklajM4g6vFz7gjKetX+7DzfST9wl7w/1uJyeW3RfYcEObUu7TUc/bqBVXgXzaB7nPCZL3thyoW+OVW7B5uat0wkl4Jscy3uJgJSTg6Am6kY7D0Hi663mlvddaqaq/LVjt0OKEBH8U1SZvod/Pm15imhwLEKwl9X3wsvLjMPwguIWeJzOCtspbzYzf5Z2Os/BAz+d18UCwQhMhgN2ALixCIbutC91Jh4AvAEc9OxPI95HMWuA8XpJN39DEEGdmXzqm9s8XOimoUz+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ECJBf1JunfhSfqq1UN7+lUYNFKkmpXTTWwnz2c82QgM=;
 b=gbuK2oYsOodruAtJDb6wRr6puJOcZH1fK2v5FM0lQoUcEH+PN01VmcqUEmdvqrbH7rM9t06q+tMcpoiTwFnMxAr4benPkJQJCwP+AagZjrjEF7pCVJs1qa9AZSMRjffYreeXRT/m9HyP55HXS4ohcCg4lwcBICpu3bHTlDQdbe2DhzC9it74yGgI3vZnDkygu65p/ut8xconmul0xnmFdW1SsnGGLU6938YtzlK9d7I+SbyGp24zKt6pYhyIbLf+jjG1fc15CBOnUDXwE+ROugZTzJeuVRXu8txM89k2uldEJLsod6/g9z7BFhPzZNDCxUxV9780LQIbwIMTdYhDKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7381.namprd11.prod.outlook.com (2603:10b6:8:134::14)
 by PH8PR11MB6731.namprd11.prod.outlook.com (2603:10b6:510:1c7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Thu, 4 Jun 2026
 21:31:46 +0000
Received: from DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58]) by DS0PR11MB7381.namprd11.prod.outlook.com
 ([fe80::4c39:dfe6:d6dc:6f58%5]) with mapi id 15.21.0092.007; Thu, 4 Jun 2026
 21:31:46 +0000
Message-ID: <6f5544f0-a24a-4898-ac7d-004a29b3d204@intel.com>
Date: Thu, 4 Jun 2026 14:31:43 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: bcmgenet: convert RX path to page_pool
To: Nicolai Buchwitz <nb@tipi-net.de>, Simon Horman <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <justin.chen@broadcom.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <opendmb@gmail.com>,
	<florian.fainelli@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
	<vikas.gupta@broadcom.com>, <rajashekar.hudumula@broadcom.com>,
	<bhargava.marreddy@broadcom.com>, <fmancera@suse.de>, <markus@blochl.de>,
	<arnd@arndb.de>, <linux-kernel@vger.kernel.org>
References: <20260602094248.4130712-1-nb@tipi-net.de>
 <20260604173205.3989025-3-horms@kernel.org>
 <2373b19cef00246c737f687685f0ead7@tipi-net.de>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <2373b19cef00246c737f687685f0ead7@tipi-net.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0375.namprd04.prod.outlook.com
 (2603:10b6:303:81::20) To DS0PR11MB7381.namprd11.prod.outlook.com
 (2603:10b6:8:134::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7381:EE_|PH8PR11MB6731:EE_
X-MS-Office365-Filtering-Correlation-Id: af28308c-3697-46cc-0b43-08dec280addb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|56012099006|4143699003|11063799006|5023799004|6133799003|18002099003|3023799007|22082099003;
X-Microsoft-Antispam-Message-Info: 31K8SvxT4+2qUZewy3fGZkYf8wUJwkwsz5mmns8aa3URvuao+fRdOLfKFMAfJ98r0AEBCMTaMhi+m3doLd0CfBklyzEGWKn28sYwWDJTf2nZbv+LUBgptCW2e1OuUkwxt3jUsu8EfrBqqveJuMKm0SwV/uSjUTMqAJ/vdA7Wq+lMxnRY3LwBvFPwq3n6tD2yCY2HCdpmqAKxdhVHgHaeh1qZ/4/55En9MuOSjycCcJBX26K7PFLsCeH91rGPr7qIGjXArIWc+mgWCoGiGI7znLimPgmhDoYHbv3e6Mow05c7zNRkrpQ8XZB2N5bUnQdVQF8e292YpDZ3R+2UWjwY05qri9ArS2CAUIVjFooByAvhdFaG6+ekymy++aVzdtamvLDDpXM+Jw3XPFIUdkab5T8ahRJHgfbd5XP6aXqgVHdh8GTNVO1hQJTORNFjNRINFeh/8uPGsrDetfU4ZQX3YEVzgykKVjcbwGjL3kKLtvuCuELJ1AKJ2IeZreRIYJ9fVaFVlb4NXwIb13Zt/FaV8RcGMErx01SwXuQrb0PyOwMB3KUpg+on46xC3vxvoxArC7SfBIP7nXP5usAfDV6Vy81m7+jfWPH8rmPGQNqCl7rXOiCDVOmd4uKth/pmmlcf27iH77f/ZED6yyIDecZMXQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7381.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(56012099006)(4143699003)(11063799006)(5023799004)(6133799003)(18002099003)(3023799007)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?STBUdEZmaEQybUhhVEJ3RVZENHdyWWlKdG80czhvTlFGOEg4TGN1RXA0MkM1?=
 =?utf-8?B?Tm1oczJTblF4SEVvRytSdXB6Q3ludlRRN0VXUEhEZUpBeG5HandWdnBGQ2Q0?=
 =?utf-8?B?YnJ0cXNWbVlmRXovK1cvamg0ZDVXK2lBSFA4KzFFS0ljR0N0aTcyeDJwT0Jy?=
 =?utf-8?B?RzdWUmlITHJJd2drV0FCQWlzcmQxSHQrUDdxcmRRdTJMdTVnckN6OVRuNi9o?=
 =?utf-8?B?Wk04SU5qY2FOeEtJQk9KSkVsQXR1K3dKQlRNTngrczFIWXpVekMyS2ZEMHhJ?=
 =?utf-8?B?TUsrMzJ2Sjh3ZmJIUUFiV1VEOVNPRXMycCt6YVA0blN5NXd4NHlHeGdDZklN?=
 =?utf-8?B?ZUlVUGUvRGJGaGRlU3JmWVYvejRKV280NnN3NmhFRXQ2bzBlcjgwbTY5THBz?=
 =?utf-8?B?MDhHVWt5MFpFQW9DS2lBVDVFTW92SFM5TDN3UVhROFVZYWtISnJaRm81d0Rq?=
 =?utf-8?B?SSsyNVpCbHlPT0t0KzZVOWhXMUxNODlWMDV4SUFJV2hHcDRJVitqempqb1JK?=
 =?utf-8?B?UlJvVW9WQ3BzdFlBbVBsY1UvZis2bWJqak8vNFgyWFhQM1oxZTI1UmZ3RkRx?=
 =?utf-8?B?b0VMaHZvempsQUNEeU5NakZhT2M2TVAzSW8wQXdDdmJkNzc1ODZUZ2tBR3hD?=
 =?utf-8?B?RzNmSkl3VHlLdTJ2ck9ZeVdyY1J2MjRoMCsyRHRMWC91NTZaSEcvSTVuL1Ft?=
 =?utf-8?B?bURQMDZhNGNwMDJxb3JiRFhBL3UzajlaL2dEN0JKMVk0aGtyZGJRbWxza1Qz?=
 =?utf-8?B?d1NGZGRwdzVObE04SWc0d0JzUkxDdTlrWlFJR2hVWDBvb05uNWhZbUlJRjI3?=
 =?utf-8?B?QVY1VFd6WElLcnBkUFlMOUNtN1dJSlltRG9QRkM0RDRYaldHckZhNm5aMFAw?=
 =?utf-8?B?OXFTRjFXQWpYdzQvK1lOYlRkRE9TZ1VJUTcyKy9DL04xdTZtaU0wL1A4amZF?=
 =?utf-8?B?dFdCbjJZd00wd3lTVm9zU3hnbEVab1NOQUgzSk1pQnhWMGZzSHVIaW9qdWdp?=
 =?utf-8?B?MGE0RzNpMU5IMHgyYk1WN24rUFNzRS8vOUw3cFk4SXFPdTErWHAxNENXb1Qw?=
 =?utf-8?B?WXYrYnVIZDZGRnZaYkQ3cGtjSHB3a0pLdUdSdkdGMDY4cGtaSnZNU3BEWkR5?=
 =?utf-8?B?N2U5R0J6YXl0VnlVeVFPQ3V1RXQ0b1NRd3g5elJQQnZ2cnV4ZWI1MmNlbzZm?=
 =?utf-8?B?WXN4ZWtLdzBDZHJsWEVlcTRSdVl1YmFsR3ZENnloaHpQNnQ1TmFqakMrNGQ3?=
 =?utf-8?B?OWdYWW9wVkR5a2NIdEZqd1RLbHp1M0haMDRxakxvMWRXQVd2OFNHK2tDeE1l?=
 =?utf-8?B?bzlZNUJhMndiYXdTSWF2YXI1K0FRSDBkMy95eWJVaTdMOTBpVzdkd2pOY1BK?=
 =?utf-8?B?bkhSa29SQzBJR0VNZklZb1hhaWlnNTdWSW9jdEprZkk2cGowRVg4VUh0S0Vr?=
 =?utf-8?B?clFYLzZteFc4bkRLRERyN3FXTnhQYm5NWVpKZERtMWtraksrM0ZXUmROTU04?=
 =?utf-8?B?R2ticnF0ajZ3N1N4RTJ1UlVKNUZKZ29tUmNXVmxoREFhVWRNTmdwQnI5aUNj?=
 =?utf-8?B?cUVlZ3FYRGw0c1R6MUhIekpxaWdSQjFjdUFEekhqRVR1ekhHdEQ2L3poUStG?=
 =?utf-8?B?Y2FtRmhlRktRRmRJZVRQOGJ4T2NkS3hVclZ1R3N5Ylp6OHM2K1FCek1zQmFh?=
 =?utf-8?B?T29yTU5MYWdjcWx1cXJGSjRQKzRjaDc2K0NxK3dQQXFWZWs0cUlBbHphbWl6?=
 =?utf-8?B?V1Fad1AwK2tJeVBvRnpnOG1jZ0JlRE15ZXhJcW5VUmtMY3JSeWdhWmtQcUs3?=
 =?utf-8?B?SVhRQjdTcFNqc0NjalQ4cU5tYjRNenE4SlFmWFRhTFJKNlRZb240OHF0aWdO?=
 =?utf-8?B?cEd5WEZFeWFOZVJlcmc2ZlFZWVdxMDgxY0g2c1hSM3NJc0NXQTliZ3ZTY2dP?=
 =?utf-8?B?NWN0VXJDSzJibUYvZ3FoaGlCVmxFT2dkVWtDcnR1S2lQS09wU2JqdUFGU0R4?=
 =?utf-8?B?bkc4eUNwNGsxUThvVmx4UkxXM2lNSEpzTExIQmhTNjBXQVVPK1VkYzM2T25i?=
 =?utf-8?B?YkNNTDdLN1pYYUhsSncwNEMwRTN4NXYydG16YmFmQmJLVWFmTllLeWNjdURZ?=
 =?utf-8?B?U2ZETjNVeUlnZ0gxbVRUN0U5SzNoY3pCaUtmdWJ0b2hrNnVVcWdqdjJac2FI?=
 =?utf-8?B?WlBRc01oWDhTMURUMFgzd0Fyb3ZXS24vcTFoU0doR09PcTU2MFBvS3VRaVB0?=
 =?utf-8?B?RnExNnAwQ3pEeERUVisybmtFSnBmbTdBbzl5OHNKeHdVR1hJMTJUaDJIWTE1?=
 =?utf-8?B?YlRqU3BWcTZITTFHcjl4RXhaRGFUbEpiSTE4M3FaT2xtVXhBM1h3SlQ3aHVI?=
 =?utf-8?Q?0gpVA1XWJWNEDFWc=3D?=
X-Exchange-RoutingPolicyChecked: VEyws4tBWJh13iWMgH3Wxd2BlkfdmESbLZSUaZSGmdi6x4DJYD6xLmJI0UhnzJJSbMyiZLS+IKDz9jEMYekMeSS+eQDi47tGERqwOod9KZZXqbFmCYekwblz60xLcTxgFMe9VQlg7tH63/bz3V+dL4pV5vZ6rNcOcdaQCDH8Uc/wcjf9gaAaIIwwX82k3mSvpayuh6VRabNnAg5zd02QsZTrVV545WQrH1HwKrftC9nog+DfI7OSR1WeS2PvODZLxDrEFjOpLhA8anr6FcvZP4OeKdgoHph8XicdUQpa0r+n3gKrI3ZPwDVTEtGpylewY6MTMqjiURHt6Zo3Q5/IWA==
X-MS-Exchange-CrossTenant-Network-Message-Id: af28308c-3697-46cc-0b43-08dec280addb
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7381.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2026 21:31:46.3299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kmPffX4AUvlguu5aS/AoJwj61e4y27UENeeswd4t4Zw8vgFnRu7GBmQVkjDSF7cN80w8eoIBn/09Nd2T8jhKo8K6nY/lq+r1ZNzoDUFNaww=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6731
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295423-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FORGED_RECIPIENTS(0.00)[m:nb@tipi-net.de,m:horms@kernel.org,m:netdev@vger.kernel.org,m:justin.chen@broadcom.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:opendmb@gmail.com,m:florian.fainelli@broadcom.com,m:bcm-kernel-feedback-list@broadcom.com,m:vikas.gupta@broadcom.com,m:rajashekar.hudumula@broadcom.com,m:bhargava.marreddy@broadcom.com,m:fmancera@suse.de,m:markus@blochl.de,m:arnd@arndb.de,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jacob.e.keller@intel.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,broadcom.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,suse.de,blochl.de,arndb.de];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 65D92643A27

On 6/4/2026 12:39 PM, Nicolai Buchwitz wrote:
> Hi Simon
> 
> On 4.6.2026 19:32, Simon Horman wrote:
>> From: 'Simon Horman' <horms@kernel.org>
>>
>> This is an AI-generated review of your patch. The human sending this
>> email has considered the AI review valid, or at least plausible.
>> Full review at: https://netdev-ai.bots.linux.dev/sashiko/
> 
> Thanks, I will have a look and respond individually per addressed feedback.
> 
> Out of interest, how does this sashiko instance differs from sashiko.dev?
> The later doesn't flag anything in its review [1], so I'm just curious what
> I might can add to my local pre checks.
> 

Your review on sashiko.dev is here:
https://sashiko.dev/#/patchset/20260602094248.4130712-1-nb%40tipi-net.de

And on netdev its at here:

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260602094248.4130712-1-nb%40tipi-net.de

On sashiko.dev, the review used
gemini/gemini-3.1-pro-preview, but on the netdev instance it used
bedrock/global.anthropic.claude-opus-4-7

So at a minimum it definitely uses different models, but it might also
be using different context files as well, I know the netdev review had
its own context files from when it predated sashiko as a whole, so I
don't know if those are still fed in or differ.

Looking at the raw logs, the system prompts used are slightly different,
so that also likely plays a part in the differing results.

Additionally, repeating runs can sometimes end up with different/new
results because of the nature of LLMs relying on some randomness when
picking next tokens from its weighted outputs. Even using the same model
can give different results if you repeat the run.

> [1] https://sashiko.dev/#/patchset/20260602094248.4130712-1-nb%40tipi-
> net.de
> 
>> [...]
> 
> Regards,
> Nicolai
> 


