Return-Path: <netdev+bounces-295940-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xsqMLjMTI2rPhgEAu9opvQ
	(envelope-from <netdev+bounces-295940-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 20:19:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 57C8664A840
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 20:19:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=UPrdNqKr;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295940-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-295940-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5F49F3038B94
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 18:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC1A39E9DE;
	Fri,  5 Jun 2026 18:18:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35AAA399CF5
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 18:18:47 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780683529; cv=fail; b=Ql/HZmDvLZFlUcjWBEJg7ci/lQuyBjlvGDWfWv8xuXQOYaGTyY/CXuRyB7/ACMmX5/xD+9Bon1752YbS2OZrx0RTvWfUUpZvRNJp5/UE0KlREDtQYcBO3QeLcLCUO7eu06tYya7uFi/LQKVfKK84yzsnSv4azUtaBzA3xOK82bA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780683529; c=relaxed/simple;
	bh=Sds0zluHtLyCJqZYmlC0gHhqOHbTXvxTjC/ckZn6axI=;
	h=Message-ID:Date:From:To:Subject:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SCi1V41s5e4K9iZxWCeA3fKQVkjY/QgxR8AZogiQaOQxTSLOM9x53TuvxuBhh6JoOoTc1mk9yD/GU5iWpA70OD+waVAU+MRmm3YQ6myAkEcFnyHfATt371OnudCh8QS51szxRcNUpZzjJoXLw1cBpd1C4jypG9SDdO8WThzcmLQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UPrdNqKr; arc=fail smtp.client-ip=192.198.163.16
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780683528; x=1812219528;
  h=message-id:date:from:to:subject:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=Sds0zluHtLyCJqZYmlC0gHhqOHbTXvxTjC/ckZn6axI=;
  b=UPrdNqKrkU7zxnTNVxoiU9+X0DM9r1grTCUtsdCSvgOzlemHwr1svIfZ
   OGRb9HjnNbALSQg+klK9T1QhzO40dhDBUl1Gk6OA3/L8zCO5SsMmhfeVU
   RxaQNd+6IGn/kHBZzfA20LBdMQDGN03B/xZd3YhkXc3x0bNnRSi0+T5wZ
   XFZL8gTDqpuT867OW66ZJYc0hIbKoKQiWIbvMaQlsuiS4axLt+chPZ/Kp
   pbXkNEWd3ghjnWPWViuPM7lxAsTmmyJhRvwkmn1pbZsK5/2ZVQlFGZ/BJ
   PnnwXLWhMMxi3nJ6KznP08/GdAjximR6OkNNqDuE/h6aXfU5P9gEfttJi
   g==;
X-CSE-ConnectionGUID: 92kZMAzUTqiITbRuorS9Xw==
X-CSE-MsgGUID: XIK2M0IBRSyLWHTqqAcpyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11808"; a="69053884"
X-IronPort-AV: E=Sophos;i="6.24,189,1774335600"; 
   d="scan'208";a="69053884"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2026 11:18:47 -0700
X-CSE-ConnectionGUID: mXcXrQzMRjqPROru0YuSEg==
X-CSE-MsgGUID: 9kS3BTpcQ56B9V4nRlbpsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,189,1774335600"; 
   d="scan'208";a="275139362"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2026 11:18:48 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 5 Jun 2026 11:18:46 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 5 Jun 2026 11:18:46 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.28) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 5 Jun 2026 11:18:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QbU33yBQQtkkzGD014GFSP/oRzF69yGwgpj8NGilltN/DWljupB2TyTCEmF/G+vRxk1/Yp16I7HIvuXvevsILKaGfsuTOlPr4kKyzoihWs0oNBl3Hj8rCOOEGfhUQhDkbO466EsM7Ji7t9BI4uPqz8w16qbn4XQFPoMDCfn3u4I+y4gplcAvhUEUWMaOu31/sK/S1LICRM471BnUsTq6K00AKvKRME6zgiz4ngW6MVrQVCZoBl1yJEGi9nOSOwMg+QpPHyc4vyPsatK3lf601CM3rDiq9Elyr1vWTZb5fWBoPOuEAdnASYx8JR1vppkIxqnQFVsuS3z2b0nibuKWcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uoqbvUehCgkUyqtZgvzppIFHNrgmLseEYaHZ+abcPOk=;
 b=X31TPhPt3NYPWyfKs2tfEzE+2OSIomAveqvoTTi7ynYsRVS6ukQObSTEXv/URFbmNtTeIeO+sHgccW8n0Ptx0z6eANX5G5o/t9gzmJ0zKjK/goOcZWj2sUVWf75rG+Hux3eqp3JYaQ/Vo+Z9ggmZMd9qaYu6gmvTLfjcXSiLKOPfJCUYCJSfRDFdJdp/CALduRjke2K+/QZTKVurZHga8zC2zAfWCKuAbX525kHhy7QI+BJtlTs9IfniA4gNA+hqJjYBZl+n0+vinmul8T2/piqPJJoBdLmodc4WpjZVvWzrNRPHw6/d9NhDDa6UxZJ8/h1Gh8UW4KSP6xVnXtmzwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB8230.namprd11.prod.outlook.com (2603:10b6:8:158::21)
 by PH0PR11MB5063.namprd11.prod.outlook.com (2603:10b6:510:3d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.9; Fri, 5 Jun 2026
 18:18:44 +0000
Received: from DS0PR11MB8230.namprd11.prod.outlook.com
 ([fe80::2592:f5a9:a751:be40]) by DS0PR11MB8230.namprd11.prod.outlook.com
 ([fe80::2592:f5a9:a751:be40%3]) with mapi id 15.21.0092.006; Fri, 5 Jun 2026
 18:18:44 +0000
Message-ID: <f9dbaf47-39d0-41bd-976d-fc8dcecd44aa@intel.com>
Date: Fri, 5 Jun 2026 11:18:41 -0700
User-Agent: Mozilla Thunderbird
From: <anthony.l.nguyen@intel.com>
To: Jakub Kicinski <kuba@kernel.org>, <davem@davemloft.net>,
	<pabeni@redhat.com>, <edumazet@google.com>, <andrew+netdev@lunn.ch>,
	<netdev@vger.kernel.org>, <marcin.szycik@linux.intel.com>,
	<aleksandr.loktionov@intel.com>, <sandeep.penigalapati@intel.com>,
	<ananth.s@intel.com>, <alexander.duyck@gmail.com>
Subject: Re: [PATCH net-next 00/10][pull request] ice: Add ACL support
References: <20260603220828.829969-1-anthony.l.nguyen@intel.com>
 <20260604190505.14a40272@kernel.org>
In-Reply-To: <20260604190505.14a40272@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0241.namprd03.prod.outlook.com
 (2603:10b6:303:b4::6) To DS0PR11MB8230.namprd11.prod.outlook.com
 (2603:10b6:8:158::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8230:EE_|PH0PR11MB5063:EE_
X-MS-Office365-Filtering-Correlation-Id: 5130744e-6adf-4e65-695b-08dec32ee0ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|921020|3023799007|22082099003|56012099006|18002099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: gU17CPaw4GIOgNrh51jdNO4h8YmUd8lMZABXYyxeppTWCMbHmRmqPQEcxbWZ9eHz6jI/2QxIv7O2W3hXGYziTrCMu45C3E8VFY5nrRUryFytlwZi0VDEfdGll8QrqTarbeyFSrEADV4F3Ts/cYrWrDGSn5xx2fUHZRNu8Z3NLB2GMJV83Z9UEJHx+ObuR2qJwCxVDdKPtA/mDKgiDrS8LdmRSYPDYV9aF/35oMcOZmQ4rp328AzOXBdtjZ5zvvuMCyTv9Fv1U9PwQl9KvlguOpQr6P7D0YwryrR4hwdDCr4hxJ4M1tuGl7d7UKGPEOOU30c0oVZtSL4DKmG42GTbHIVCigQi9fxtudIMoD3H2PKyPNYMpghaUr0NIm4nUM0WnDOTBhOwm/u29iJQpcX7SsAkAhdA/3QRXm1Hh/UOymEdqV1t1zO0nqJNOnBA8yDiXEqWrh5TvPVZp6qKBjCdxmnlqBSR9OTnatE0iUmy3X+oLqCLj50fypjKbAs1Gm9d6AEK/lUtCojuIVlxJvUPau9nXjKIwFpH6jheIKnYnXACbRIeMhesTfLFrMBTYvrluJb8DsWobuVhSO4O/9YvIt/ti9ATCp+XN36TkiLQKQ1M1iG0ELyxks1z92g5liVhOYZzNq0L6GsUSBcj//q4kUjhgp88QSFNuC2xBQPnNPW3UE8CzBYzLQD51zRbbvPz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8230.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(921020)(3023799007)(22082099003)(56012099006)(18002099003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c29QTzh1VllsOEZUV3QvMHNUVjdqMFMrMlk5QWRDcm1aMlBIMkxtZmZQTFd3?=
 =?utf-8?B?YmxaVnkwbnc3eGlkdWxqSWQ4Zlp1K25BbFV3SXhyUXN1MWlVTjhza09tNTJs?=
 =?utf-8?B?Z2NXL0VMTzNabUVFaW91WVJXZDVjRXdrNG4rdDRXK0szcFQxMFFocWt0ME0z?=
 =?utf-8?B?ay8rWHo3eHpFK2VJQVAzOUM4OXdNTlVEcVFWWGxORmFld2tic2psWkhXa05J?=
 =?utf-8?B?SGFCK2x0RWd4KzFaK0duUGs3U0QrUWtRbzVSOGhVa1o2YTR4bjZiU1ZDYjhO?=
 =?utf-8?B?Sk9ocGxTa2M4ejJPWTFBTUNYU3cwSjE5Qm95NllBN21pUVpBYWkzUjBIMk94?=
 =?utf-8?B?a291WXJ6QWNkSkMyQkRobFU0am9yMlc3bHIxU0hFVkZzd2dTQk5CR0ZIT0ps?=
 =?utf-8?B?MVV3K0RpOGZFaE95bVVXUHRGWE8yMnJ0RU4vdzRKcVp5bk9uMXllSG50d1hO?=
 =?utf-8?B?blFsZ3M0RUlCM201bGdUQS9Rc3RJallsb2RxSVBXakFweEZ1UElaUDZZRFF4?=
 =?utf-8?B?ODRmUi9JbldmcVRNdk5BSU5EZEtNcHdUcUpCazZDREI2a1dCZWpCckh3eEtT?=
 =?utf-8?B?T2VHQktTOVVDeFNBZGZobEQ2RjEzaGNrYzRhVFU0OWxEcmRHb051UmM4eEV5?=
 =?utf-8?B?amJFcFBnK0NDaEI0ZlNNSVU5aGZ0K0hzWlFoQ2VYbmhpNEdaeG9vbmV1UStC?=
 =?utf-8?B?L2RWdUNWcnpTSW5uczBvKzBjVW16emxNUnpCY1VGRjBtK2krb2xBYlFuaXBM?=
 =?utf-8?B?SWR2VnBJOWllZ3VnMTlKeGJJcHJZeUV5VytlUVlua1ZiTm1FSzJxT3pESmg0?=
 =?utf-8?B?dXBqamhwU2xmb3phV1JKSnk5ZjhxUDY0ZHNxMVNyVDBYYXFCbWhReVVUSHFP?=
 =?utf-8?B?eDI4dHZnOGYzWkN3dUVkbk9vV0hZcmRqTlhHTERZSU9tMDNEc2tjMUdmRjJO?=
 =?utf-8?B?MnNiVVZpa3ZvOXBrV01pRzR3ZXlMUFJBQkZLYmthZWkxSFhLcFRMOUZubWtw?=
 =?utf-8?B?cmRMWlJ2Z1BUbnVFdDZZRjF4ZDdwZE5hbzRrL29OQllpWjNyWGpZVktaSnha?=
 =?utf-8?B?QXJHaUxOVnFtamRXRjJjMHZ1b0pBdGVRTVNnbzAzU3FnMlVoTkhVOFNzRjdE?=
 =?utf-8?B?QkJjOGJSRUw2L0FUeUJCd0dmbC9LK3VuZzcxZFRKZDJpUWFNbytnY2grQWdL?=
 =?utf-8?B?Q3N2STRhbENObVkwUDRJY3NXZUM2MU1GektXVVhTYkEwZmIxbVlEMWtlSFdT?=
 =?utf-8?B?WGJQaGVEbk9WQnVZaFhjUW16Zjg3Vi9yalFLTE85Wkk5YmVERVo0cGxPU2Iv?=
 =?utf-8?B?bUpPK3pvN3owVjBxckdxRnpORWNlZ3Y3d0hDcE5adUxlSmFmeTU4VHhEQTFT?=
 =?utf-8?B?VWphMFNYclJWdTc3UlhRV1NtTjkyMlhrVEwrVlIzL2xTcTgrSzFQZVNqNERH?=
 =?utf-8?B?U21MUWc1Vm93NC95emkwRFQwVk1hTE51UkNNYkZIU2gyNjFxdjlXZUxhOHJT?=
 =?utf-8?B?RTRDQlEyd0NyWEE2Zm92My9PZit5V2RWWjNmQjRDZ3EwSFp5TmVCanp4SG8z?=
 =?utf-8?B?aTJRa1A1bHFHMmN5eG9yOHZTODlaQ2hyQ0g2MzdDK0xKVktTMEU0Nk82bGRY?=
 =?utf-8?B?dytXc1g0cmN5c1ZDVERZZVBORmJyc0NDYWd2UXJmWUlpcU8rOHJQem5yZmhU?=
 =?utf-8?B?WEFGckpoU2Jnd3ZUM3UwYVp3bjNyRmN0aWJYbWdLcHZIL3h6NG9DRzIvcUlX?=
 =?utf-8?B?REN5cmp4eUFOYjQ3SjdBVm5zY3FUYXpTTzFZU1hnRkRPTjZ0aENVeUoyNkRh?=
 =?utf-8?B?TFNmRnN5VkNKYngzNVZrcytKcmttWE9jdTJOaUpWYXlMVVhLSUlCZXJaalUy?=
 =?utf-8?B?OXUxTGRZRC9jWlRRNTJoUWg4LzVOQ3JuWm9OcUhHazJSdjFYbnRLbDlwZCtr?=
 =?utf-8?B?WWFQR1ZadHZleVJkQk82NGs5Z3NRckY5Mk5IMUVJN0d3c05UQ0VsamFxMlF1?=
 =?utf-8?B?VjRneS9Ia1RnQkFPVnJ6RWpDckFlbmJCdEFITXdXUDBJNEt5WTJkekxrVmpE?=
 =?utf-8?B?Wnd2dG90NnVQdGQ3T25PeEtPMExPRTZFL0FOVnBCUU50S2s3UDM1cE5GZ3Zq?=
 =?utf-8?B?Mk1RaEVEd2krT09TbkNtR3JJWmhBakRYM25vOVh1MXFvVTY2NnpPZldGQVJV?=
 =?utf-8?B?NDY1UGxyd3R3ZkVRRmpTems3WnlmQ2xaRXp2Nnp3WGpiSTVPTVNVUUd1Z08w?=
 =?utf-8?B?WTBBNnVNSHJBSFhoOVkvSU9zYmFCM0ljbHBNUW02T0t2TVpBN2RzUjB2WTZi?=
 =?utf-8?B?Yjk5UVZpYXM5R25WYTZRNDVaSGdPUVNvOGJzdlZHVW5QeEQ5dG9Qa1RFQlpj?=
 =?utf-8?Q?SnZoip35lI2zsQCo=3D?=
X-Exchange-RoutingPolicyChecked: lF73qCU/SLtI5Sz51a/NKK8EKjg+fX++5P9LFgygTRlUBhlpcizbryITJyawtQPGq2H3Q3uuHa3SR7uNxjnBlRnulJIUpIcaMryCvygZH1dvQnoVB4w/NW3GLo6rp4bgucKwLmiVN66FKyhs58gRqcrQ41tmXue48y+GDgA2uxz955Ipdavjk8tU4+oNaB9q7Zsjy5ZZIyb3aUXgsU4/lBTEHn4DaYipFcYAMfod1kxlZwi/ckL/nzj4qFUY6CPAAtlJaJ9KlGBbo4FkilCmevVgJBMdKwz0oFdb9YwpyiSfI7VN4TUTw0JxQ+Ok4vVbgEhreXuNMx0Q1r7GNE4/Sg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5130744e-6adf-4e65-695b-08dec32ee0ca
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8230.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2026 18:18:44.2216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +iKkD1WFev7ClBHhG4VDdoRdKt9y7S4VukIa7SEptFgbelM3pDjlbLbBCcdRh6wVCnTyUR/IVOSDf8e1utBsNZKiu0S+BeG/l+VBn8Fxjcc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5063
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295940-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,davemloft.net,redhat.com,google.com,lunn.ch,vger.kernel.org,linux.intel.com,intel.com,gmail.com];
	FORGED_SENDER(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:davem@davemloft.net,m:pabeni@redhat.com,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:netdev@vger.kernel.org,m:marcin.szycik@linux.intel.com,m:aleksandr.loktionov@intel.com,m:sandeep.penigalapati@intel.com,m:ananth.s@intel.com,m:alexander.duyck@gmail.com,m:andrew@lunn.ch,m:alexanderduyck@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:mid,intel.com:from_mime,intel.com:dkim,linux.dev:url,sashiko.dev:url];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 57C8664A840



On 6/4/26 7:05 PM, Jakub Kicinski <kuba@kernel.org> wrote:
> On Wed,  3 Jun 2026 15:08:16 -0700 Tony Nguyen wrote:
> > The following are changes since commit dfcc2ff12925d99e858eaf539eaa4aaaf81fe2a6:
> >    selftests/net: bind_bhash: fix memory leak in bind_socket
> > and are available in the git repository at:
> >    git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 100GbE
> 
> There's seems to be 30 issues reported by both Sashikos.
> I'm going to assume that at least one of them is valid.
> Please LMK if that's not the case

Hi Jaukb,

I haven't taken an exhaustive look yet but your assumption looks correct.
We'll go over these reports.

Thanks,
Tony
 
> https://sashiko.dev/#/patchset/20260603220828.829969-4-anthony.l.nguyen@intel.com
> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260603220828.829969-4-anthony.l.nguyen@intel.com
> 

