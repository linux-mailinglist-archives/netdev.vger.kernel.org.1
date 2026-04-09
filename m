Return-Path: <netdev+bounces-277042-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iBzcJKHC12mdSQgAu9opvQ
	(envelope-from <netdev+bounces-277042-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 17:15:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EFCFE3CC7BE
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 17:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A838A309624F
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 15:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5091F3BA236;
	Thu,  9 Apr 2026 15:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TQx9FBLp"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D12B3DD51E;
	Thu,  9 Apr 2026 15:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775747465; cv=fail; b=Urhi4iHpmK2CBasDoAwTtE7KMzhO6pCsP3XEmJ3wRRx+iWGOS2sp4H8/F+f3XZROVaIoyXDf4XzhFcRYC1e4xSPQgo6SwxPUICwfFXAsdHwZl9Xse27MMaWDH1KY1iS7/uuS7+RlQ6VkinpKSjLdqqXUbAmS51soM4q/+w/DcLo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775747465; c=relaxed/simple;
	bh=b7oBT5EQLbPjmcX6BKF7gS0uS1+Vh85C0jBtmxSOKfY=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HSuMMLjB4uhzVP+MB/164k41WsECY7+oEuvQWpozwtON7C9HakVyRjE4uEtU5LThyzEeHFCt+aJN5NZktBRFyieuxH1Mjn6rO1MRDWf0yln/jEZC1qYpB9rYcIDrXXR1sZhNoBlSf826cxBq3n/DmAiSlJawVzk6ZYZLnnccmJk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TQx9FBLp; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775747463; x=1807283463;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=b7oBT5EQLbPjmcX6BKF7gS0uS1+Vh85C0jBtmxSOKfY=;
  b=TQx9FBLpg5hwUkxuVWeVD+seGG/326T8b8h+AMTQiJIgN6B2neLN4Mr7
   aZxkCmen9anCf8hFjbhJjA1k+rfntSmd0/CQBZF1JgJvXU1UXa7Ah3JzO
   CGCRvmJwsIrF65dwK/hm2VOUofKxnzh+YVtiKIs0uzMRBTwunCkbi1FA0
   J3HA9JzuWGwKWbU8ctUFaSUozzg3watFGe4KK7iIH8weQBUW9u1XmcWGP
   A91o7uAu386J6gQL8D8ezjVHRCVwYQtqJLDMHW5uN9/vAg7569AuRdnr0
   Ikyl2OHBug/TheeZ0XCd/u1+T7YLLVJzeeJDoG+/yF136RTmT1YieEY/P
   g==;
X-CSE-ConnectionGUID: mBt8uqjvR7OibV3eGjGhTQ==
X-CSE-MsgGUID: L/pgSR+PSTG8cGpMfnCYmQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11754"; a="87379213"
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; 
   d="scan'208";a="87379213"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 08:11:01 -0700
X-CSE-ConnectionGUID: sZjnR/CdR9G/4ZcUgHR/sQ==
X-CSE-MsgGUID: Xs2T5L71TguWhurDaVpLTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; 
   d="scan'208";a="226041360"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2026 08:11:01 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 9 Apr 2026 08:11:00 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 9 Apr 2026 08:11:00 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.27) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 9 Apr 2026 08:10:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MHmQXUkQ2dRrgfsNChl2DoC8ADTsXus94Hsv09H2Jj+Eyu/giNF2OaBGWdeVBuINUV2dBho081awFkrQnh7zIFM1bMQwwJ0kVW6JlgB7r1gvcb+lNJV7oy/2sm2hU9Bbs9pZ+EoyoPb2Y+QwtG/+NRKCwEm0WGvS9JzPOm1QvL1k6EZnclPjBrUDITKok+HePvx6o1HhhkQLAkc4yH7hIXW3p4EPSgF1AWizGQ715KCDwfCNoNnuHaMzztvF1D5r5Y/lFtMPsgIsONLqimKJ9VMMRRhluAC6zMtuibhsz1S8jnVynaZtMPuOPzXIoeEJmiFnYZUHEHBo6xT0vg8XSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JscRQH0Sj/dcGTuJHDfh4+blE72+IUAQwAACVQjAs70=;
 b=LfdXRfvrLEeoLn3tRygxQJ7t5w9AKr7nfH+5h0dTs23vQtyxZMeWVYzqxDbv0O4EMxD8I3Hg8TOl3rnLR1HeSUxurJ6Tfsni/CKSOQUSwGUzdw9HZecHHl78WAIo6AyxqdI8d9Sryhqej6gNzMgjPEAW4bxJFUUfisOFmCJs7bK1ko47sJrQWAIGKMP1y93Rm0ws88Env3I/fMNe59OHbIcs/l8EtLoWAaBQtrx33upkH7oHysQTuUWYl/npmYhmskuMH6Q/Ruy+yf2PDuQP0rbGYo3ifGf0/KezTjVGHgwoNaaFrngJIVycPvYchuxy/F5rm5QkpmXCkzXzhi4Kfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by LV0PR11MB9864.namprd11.prod.outlook.com (2603:10b6:408:384::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Thu, 9 Apr
 2026 15:10:56 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c%5]) with mapi id 15.20.9769.020; Thu, 9 Apr 2026
 15:10:54 +0000
Message-ID: <00fc6c1e-638a-4e80-b3c4-14e4dfa3651a@intel.com>
Date: Thu, 9 Apr 2026 17:09:02 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH v5 1/4] octeontx2-af: npa: cn20k: Add NPA Halo
 support
To: Subbaraya Sundeep <sbhatta@marvell.com>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <sgoutham@marvell.com>,
	<gakula@marvell.com>, <bbhushan2@marvell.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Linu Cherian <lcherian@marvell.com>
References: <1775728404-28451-1-git-send-email-sbhatta@marvell.com>
 <1775728404-28451-2-git-send-email-sbhatta@marvell.com>
Content-Language: en-US
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <1775728404-28451-2-git-send-email-sbhatta@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0012.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::10) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|LV0PR11MB9864:EE_
X-MS-Office365-Filtering-Correlation-Id: 29ee2848-1fb8-4f7f-11cb-08de964a31d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: j0VUT5M1+A4CNTq8im1zulHIGCK/Raz1VtZlKqjbnNe/38HcJbnXiTx/j8ExbJ/YOEY24otBYNrcgbzqhVUgpYE/NuJO/uZacs+mhWNHyvKlR6rkYNjwYc+6bl55pjd2y/gwRIerb2KR8dC3D58FUY5hrF7U4KShU9ECxKLYMSIb+7IwZolSi3pAtP+Jtvd2AHAhf2v08muTX3yW+sm0mwPrZ+pHDjWE42Rv5PKDdaThdkQhDGKg9Sr1eCtr/c8BGejnDsriZmWLnEKVDBfAEpUCRgUGPZ0vIRAj4+i3OAH1TgXE7/29maZKZMG6eJ9HXzEWfnGYye+VpAv77EZwBR/vPV6sPZ6HJfSfgnL2afSc1quQtbbEa9ZTxfTJrgqqj0sR4tQRwybL0nEUB8zK8oDQ3joUnloM1kfeH0Dm3uXIu7W0Mo1qeBpbX0YMpSNKVc9BAn7f4PpKGlcfiA+tMZeGD/68YcBtE3ndqr2z6f5CGEM/LbpQDIlVJXol4DUi+109tkn7OXl8yUzKiaa64iF58JM8V79eApUYgVemeXaM9eDV0X+wFb00sSfLS5GZ8UI9TDqPpcyzZ5xFMVvFCEAywqqVDkt9j24TXNvdYh3RJM+dAxfXv6RxDQu981lqNxV9ha3ATU+ZnN6AZUAdPP+2xvlZmCzvE4KVXAJfSvU28imRp29weWg5my4PHe3ksshVT5jR9LUr5f+DgtO8DJPJIlbYdGVmQCx+TetmTy0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VHNiN3lMWE9IVTFjZU1BdmdTZVZkTmZRYjhFYmJoREdNaFZSKzR6NnR1U25M?=
 =?utf-8?B?eFV1Mm54bzBhZHB5OTdML21raXRMUk1LQ1lja1NxcDliSllPYlAwZGJjMFhm?=
 =?utf-8?B?bEtFaTZMUlNLbWlEVkdhdnFiN3N0L1E0OGJTUU1WdlRyZ3c3SHlrbkt5WFpm?=
 =?utf-8?B?YmdxbHFKL0RwTk9DRUdJU0ZyUVhZVWRNKzgrNjRnalBIS0RZQWlkUExDS3dQ?=
 =?utf-8?B?WG82NzRRUnZkRE1ObFdHR3JOVFA5QWZ1aUJWMWJ5bUo5OXNaeVB5QVhndGs1?=
 =?utf-8?B?a2I0TVJkV3RFMEFaemYvMVN5Qkt4VGZ5TkwyZC9lU2lES3QvNlRkR2EwejhR?=
 =?utf-8?B?MnYvTjNKaGVEZ01STUNJSmRqbFhIdmtXODFVOTlkT20rZlRXek10bkh1ckRF?=
 =?utf-8?B?dGUzSmlLNmdTSFR1Sjh2R3MrMUE4bDlIT2h4ZXVTUXp0NkdoRmlBZHByV1JC?=
 =?utf-8?B?QVIxbmJ5aFloSGFzVGVwSXhDZ09RdEZWdFBqRFlFUFFmcTJ3U2lWTUhBNzda?=
 =?utf-8?B?ajlNRFMwZlErOVdzMGhTRy9uUytjSFNnUmVneE81L0RlQkh5OTZlRjlsV1p3?=
 =?utf-8?B?Y0pkYkxzVndadGFyK1Q0OWFLQnlxSzBBQkxhbHlXdmVOaUJQYTZwYWxuSWN0?=
 =?utf-8?B?YnVHMW9xb0lkaVFIWmJnZEpsUEI1dFBSUXdLb1p6WjIraHRCd3RKcWdnUDV1?=
 =?utf-8?B?Ui9DME51V3haUlhNNGlxeGs4cE52VE9RTTBSSklueFJHVnFjZEwxUEZySVVV?=
 =?utf-8?B?N2VzVUhKbEhuOEJHTVlGT3pQZWUvYkxLbzNLclE5azR5eXRYUXVOMWdlOG4y?=
 =?utf-8?B?dENGNXp4UXZOSjB4VU1SVlBNSndWMjdYV3poTWppSlZNaS8zTytMVWxLUnJ4?=
 =?utf-8?B?Qnk3TFhIZXNxRC9kQTZzMGFtUVlJOFFVOEtyMmhGN09LZmlsQVFwR0xzRWd4?=
 =?utf-8?B?RlZyNWlXU2ViRzJoY1VhcUZ5bTlPVFJvNE41UlRQVGZNUWlZb2RpSWtwNzJm?=
 =?utf-8?B?d0l6d3ZuaHAwYmFGdjFsZGwydEJOcTk0bUFrQk90dTNrbDVYTVMzQ2tCcVBP?=
 =?utf-8?B?UnZhc3Ryb3FnL2ZZdEtMdE1iQUFXbUgyOXJSeXdJZ2ozdEp3M2FFTE9DSmc4?=
 =?utf-8?B?b2lpbm5DTlRoNjlDOXZKUkhyeUNMOGNNM2hwenNBZnR4aU8xS3NxZlNFSjhp?=
 =?utf-8?B?dGE2OGRISDcrM08yV3ZidUU1ZzBiZ21uWDB4Z0dicGwrM0ViRkdpbGlJcmJN?=
 =?utf-8?B?eEgwdTBaR0g4dVdyTnR0MnZqL1RaeExnVFZPbG8wR3VMNDlEaXVxWW1GVFhV?=
 =?utf-8?B?cm12QlR2aTFJMHE3dXpadHNBRHNTL3BWb2p2VFJDZ1BKLzZITFIvYTE4REVF?=
 =?utf-8?B?eHo1cC93UnI5d2s0cW9EZFVaNDk5YzhBUXpmU1VueERNVVJSU2Vma013WEhm?=
 =?utf-8?B?dlpLTUsxektWdFFDTGdCSFRncjFHWmdCcS9jZEVacXEzMTRhcDM3dXRvdEVq?=
 =?utf-8?B?VjlYNDR3bS9nb201SHZCbU9NdFQ4akZBVERETm9yZnhQZk1welNmVE45clMy?=
 =?utf-8?B?ZlRiaVRqemJNYnVubVdPaVJGSGFPdUdMSCtyZHNnZUFUUnByS1huS2ZOQk4x?=
 =?utf-8?B?SnNGU2lZVG9kMEFIT1dIM3lNZkoyT0VpS3BpMDBNc1BNbUNQSDdTS1o2T3hU?=
 =?utf-8?B?aEkrUFpBTnQ1eHhzbVNEOWM0YkFXZlQvZVlqNjhlcjZsSnJpdlAxaGtoTFFJ?=
 =?utf-8?B?cjhCNmxscWtiQnFoRkhzNkR1bnhMcVdMNUNjT0JpWHh4MU5HVHptZGNoWjZJ?=
 =?utf-8?B?TUpLZ3BUVEEwZy9OY1FiT2FRN29sSWdLN2VSN2FMdlorM0VhVjZFZ2RQT0Qz?=
 =?utf-8?B?NTNManRrOXJBT3A4aXUyaHk5d1FpcDE0aXJUMWlSTjQ4OUd1UkV1Y3dWVXRz?=
 =?utf-8?B?WFlZQzdYYUNUMlFLV3hlcncvSHFOcDdCR28zbVBKbmg5YUhNVjRhZDBCUzBF?=
 =?utf-8?B?amRQeWptQ1JzMHBVUGl4bGxpeStZOFNIZHREdkt0MGt1MkhyM0NUdUMwZGVL?=
 =?utf-8?B?U0VQZklRRDEvVEhWakRJSTRSeU9Gdmw5QnVWdHlLSDZ4RFYrZHg5MG0wWFRj?=
 =?utf-8?B?TkxTRGI1UzF6TUVKenp6WmVqZ2NrcFlFYS90SkNsSFltMUNtUlVRcEJGNHRG?=
 =?utf-8?B?YVVtaGJZRDBVY1p0VDg3bDVEazBTVHZqR0liWmZsSnNMdWptc3dxZ0xHcG9Q?=
 =?utf-8?B?Y29PYS9ya2hjTi9JSkJYb1lsRi9yd2YrdHRrdDBweG9LMnYxNGl1VXc0NWxo?=
 =?utf-8?B?dVllR2xSN0FBVjlQNU5Jbi9EckU2bEptcFFETEVPUURWakU0NnF4M2FqTExy?=
 =?utf-8?Q?BJ7EunVF/HklQqM0=3D?=
X-Exchange-RoutingPolicyChecked: O2eGupcVGwE6wP5LIxl6pc5bDBaN6IfPealit9B5nHYR8fF2WGQvpXfbEwAP5s9r9ZrkCl8Q3P5iEjEQ14E9F8XVpBB84Vx6y4O/sT2ytlszal5APdPfPbBOH+EIvAooNikYRb0Zkr/0EoFR8eh27Nm6HlqTbrZfjG52bxrfA345ccNIFcw9+tQSaxaakmoUBUgv2n0SPA6o5bhIMNAWMmRboHc1a8f50yPTkme/9hJua4RsgMf+tS45fKoa1Ao13WHApVOox+HD/ja7TNqxrcq9+xsNeY0kyGwIy4OK9CTrh4Qk1JOPRmr7tID2VYSS882nlXnG9SgDnO+dsiyNzA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 29ee2848-1fb8-4f7f-11cb-08de964a31d1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 15:10:54.3513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rfQ9yIzjH3XZ7zjWpaq6Z8wxKtEximE/4/jPmpgPqQCK2QC4PHpZS0ftefPn0V/mgLQb0mxfDpE+9usrs0iur/PCJ1PzzkCZ/j4/4KYfxnk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR11MB9864
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-277042-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksander.lobakin@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: EFCFE3CC7BE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Subbaraya Sundeep <sbhatta@marvell.com>
Date: Thu, 9 Apr 2026 15:23:21 +0530

> From: Linu Cherian <lcherian@marvell.com>
> 
> CN20K silicon implements unified aura and pool context
> type called Halo for better resource usage. Add support to
> handle Halo context type operations.
> 
> Signed-off-by: Linu Cherian <lcherian@marvell.com>
> Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>

[...]

> diff --git a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/struct.h b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/struct.h
> index 763f6cabd7c2..2364bafd329d 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/af/cn20k/struct.h
> +++ b/drivers/net/ethernet/marvell/octeontx2/af/cn20k/struct.h
> @@ -377,4 +377,85 @@ struct npa_cn20k_pool_s {
>  
>  static_assert(sizeof(struct npa_cn20k_pool_s) == NIX_MAX_CTX_SIZE);
>  
> +struct npa_cn20k_halo_s {
> +	u64 stack_base                  : 64;

It's redundant to add : 64 to a 64-bit field.
Moreover, on 32-bit systems, the compilers sometimes complain on
bitfields > 32 bits.

> +	u64 ena                         :  1;
> +	u64 nat_align                   :  1;
> +	u64 reserved_66_67              :  2;
> +	u64 stack_caching               :  1;
> +	u64 reserved_69_71              :  3;
> +	u64 aura_drop_ena               :  1;
> +	u64 reserved_73_79              :  7;
> +	u64 aura_drop                   :  8;
> +	u64 buf_offset                  : 12;
> +	u64 reserved_100_103            :  4;
> +	u64 buf_size                    : 12;
> +	u64 reserved_116_119            :  4;
> +	u64 ref_cnt_prof                :  3;
> +	u64 reserved_123_127            :  5;
> +	u64 stack_max_pages             : 32;
> +	u64 stack_pages                 : 32;
> +	u64 bp_0                        :  7;
> +	u64 bp_1                        :  7;
> +	u64 bp_2                        :  7;
> +	u64 bp_3                        :  7;
> +	u64 bp_4                        :  7;
> +	u64 bp_5                        :  7;
> +	u64 bp_6                        :  7;
> +	u64 bp_7                        :  7;
> +	u64 bp_ena_0                    :  1;
> +	u64 bp_ena_1                    :  1;
> +	u64 bp_ena_2                    :  1;
> +	u64 bp_ena_3                    :  1;
> +	u64 bp_ena_4                    :  1;
> +	u64 bp_ena_5                    :  1;
> +	u64 bp_ena_6                    :  1;
> +	u64 bp_ena_7                    :  1;
> +	u64 stack_offset                :  4;
> +	u64 reserved_260_263            :  4;
> +	u64 shift                       :  6;
> +	u64 reserved_270_271            :  2;
> +	u64 avg_level                   :  8;
> +	u64 avg_con                     :  9;
> +	u64 fc_ena                      :  1;
> +	u64 fc_stype                    :  2;
> +	u64 fc_hyst_bits                :  4;
> +	u64 fc_up_crossing              :  1;
> +	u64 reserved_297_299            :  3;
> +	u64 update_time                 : 16;
> +	u64 reserved_316_319            :  4;
> +	u64 fc_addr                     : 64;
> +	u64 ptr_start                   : 64;
> +	u64 ptr_end                     : 64;
> +	u64 bpid_0                      : 12;
> +	u64 reserved_524_535            : 12;
> +	u64 err_int                     :  8;
> +	u64 err_int_ena                 :  8;
> +	u64 thresh_int                  :  1;
> +	u64 thresh_int_ena              :  1;
> +	u64 thresh_up                   :  1;
> +	u64 reserved_555                :  1;
> +	u64 thresh_qint_idx             :  7;
> +	u64 reserved_563                :  1;
> +	u64 err_qint_idx                :  7;
> +	u64 reserved_571_575            :  5;
> +	u64 thresh                      : 36;
> +	u64 reserved_612_615            :  4;
> +	u64 fc_msh_dst                  : 11;
> +	u64 reserved_627_630            :  4;
> +	u64 op_dpc_ena                  :  1;
> +	u64 op_dpc_set                  :  5;
> +	u64 reserved_637_637            :  1;
> +	u64 stream_ctx                  :  1;
> +	u64 unified_ctx                 :  1;
> +	u64 reserved_640_703            : 64;
> +	u64 reserved_704_767            : 64;
> +	u64 reserved_768_831            : 64;
> +	u64 reserved_832_895            : 64;
> +	u64 reserved_896_959            : 64;
> +	u64 reserved_960_1023           : 64;
> +};
> +
> +static_assert(sizeof(struct npa_cn20k_halo_s) == NIX_MAX_CTX_SIZE);

Now the main question:

Is mailbox's Endianness fixed (LE/BE)? Or is it always the same as the
host's ones (I doubt so)?
If not, these need to be __le{8,16,32,64} (or __be if it's Big Endian)
and you need to handle the conversions manually.

Thanks,
Olek

