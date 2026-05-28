Return-Path: <netdev+bounces-292697-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4JJkMtFHGGoUiggAu9opvQ
	(envelope-from <netdev+bounces-292697-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 15:49:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E99A5F2FDB
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 15:49:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A7263055421
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 13:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9716D3F39CC;
	Thu, 28 May 2026 13:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kskDVqXg"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6803CE0B8
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 13:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779975755; cv=fail; b=bYKOOYIPZ4C2WrU0mQR7Kb+ysAJwRoVt20LRXogl1wqNAf6kqv3hvLc8Ye+lPTb5/CirTvwJuBUEV9h8q5+E1sODFy4LDTqStFSUyn7ZeLIJnt/n61cQ7ai6PliukZvTmSLw5Y+Zgs9u5xllUte3tv/AuaZs6ghILOIrQqDJTkM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779975755; c=relaxed/simple;
	bh=fsH2tVcVISWYC17P2a4z1DQ/1dQVU+cruUm0NciGbrA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UO1V4pqdslm6i3ik7M4huuvBjKVUBVT9FCEOjXI6JR0hDG30wGg33qN++s51Y0EX6GMpWOu5/xAwkGKTyi7BqbKJsHyM3Tzlp8SiZwg/x6qB4J2LJPas6NNstK7vwpGZMQ0LM7m/nfPvtrocgjwJTtkGrBTf8O8M2D2io7PmFd0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kskDVqXg; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779975753; x=1811511753;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fsH2tVcVISWYC17P2a4z1DQ/1dQVU+cruUm0NciGbrA=;
  b=kskDVqXg6dc1d3v8U4aGz/2rEctWs31kpqYt4kb1JvXqhERZtx+FZgud
   Kqc3qCJru7UpdHs9E08FT/skTsKAoiOLk5Y2yH9pqQvjKvgb0J/WIzqdv
   T2wDSrDnTZT2j/YGWVZhmCjH7dLvQwoxKLUYVqz8d6W3tIPQQkzf38qap
   4iOCBE2mWZq7C/NtYumBm4GW/qTX1u1HCt0XOpYoA6+6Emn5prFWSTkBt
   gcDnYZUTG24fOTkYKq1Qh2Ku2ZupaHj/VOjZ/1jSpQhjuDdz9DIt4cZp4
   B7lJZD71EgDCmK0Ip6dWKpSg+nHxaDe5vo/A/DOURxlvHga079pFT9NUk
   Q==;
X-CSE-ConnectionGUID: b3RSqR3JQ+iCjbAcLhh/rw==
X-CSE-MsgGUID: eW62JDR8SO2UZzJXwQmZNQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="80809380"
X-IronPort-AV: E=Sophos;i="6.24,173,1774335600"; 
   d="scan'208";a="80809380"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 06:42:32 -0700
X-CSE-ConnectionGUID: gOy+CWT1RACUdJJzdnBJMQ==
X-CSE-MsgGUID: Uo9Vw152T4yaMsfmP2Z3Ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,173,1774335600"; 
   d="scan'208";a="244377481"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 06:42:32 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 28 May 2026 06:42:32 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 28 May 2026 06:42:32 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.22) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 28 May 2026 06:42:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FsJRO038vk06q3EMytk7BbFI5K8A+3zWEByK+ee/MPZTwoBLFdhAraDH7ZC1nyCJTTpoSGelCv0upEf6YqwSuS4AYUkbO5Iz+2FnBXAxHDX4D0QVC6Y+2Lrt3T1MDqgNVfSy2JfIzAOvRsGBkMl9K6jEHu8j4i1PUaYtmG2jpLAyhCbnlUBGnKZJjz/0y+40g84GEV7fkwgQg/tPpyX/yYe24lMGSQjxBLdUrAhGxZ4zR0GzhNicH4bPIRNdoWnAw7VPhloQlZPAE18keqrisQEtNo79dw1Ve9qV7dIPVZ8T69oO/QmgHG7kZAsfOjHJzaNfSEURkKwvd+8Nj0cGUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gd1DHxxfGusL+vMhQNbMsasLYwmdeR0Mm6edwsg+rDQ=;
 b=UUYtz7vaDWAWpqDjFXkMn8wDcp0+GB6YW9jzvO+YZ3PjeMQe8/i4r4tw+SiVYz3pbTgD4k8gT/Ce8vtm199GEpMAmeMEZ2pooD0M926AHd3loiJlHHJ5s16qCc4Futae3dOGmwVqTpsSKIiALosLFxGgXu8kVotlFON7YAQUSg2P1ctgUtJrTm5u/03FJfVnFlhRK54EYXsdUIGcEr1/eH2oD5OHrUMMEzgci1w232NfYCP7unALPaMPjpqC6c3i17WzEjnxTUl81xqTM4LN7gWsgDD8WRAKKdlNIVJVfLPwPUmwOjxPRVu1ke6hIvf0KTr60YQD7ibpDKtJhmj+7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by DSSPR11MB9666.namprd11.prod.outlook.com (2603:10b6:8:377::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Thu, 28 May
 2026 13:42:24 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c%5]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 13:42:23 +0000
Message-ID: <433b9d9a-bd7c-44ad-b387-a789b326488e@intel.com>
Date: Thu, 28 May 2026 15:42:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/6] net: airoha: Introduce airoha_gdm_dev struct
To: Lorenzo Bianconi <lorenzo@kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>, <netdev@vger.kernel.org>, Xuegang Lu
	<xuegang.lu@airoha.com>
References: <20260527-airoha-eth-multi-serdes-preliminary-v1-0-ec6ed73ef7fc@kernel.org>
 <20260527-airoha-eth-multi-serdes-preliminary-v1-1-ec6ed73ef7fc@kernel.org>
Content-Language: en-US
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20260527-airoha-eth-multi-serdes-preliminary-v1-1-ec6ed73ef7fc@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0090.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46a::8) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|DSSPR11MB9666:EE_
X-MS-Office365-Filtering-Correlation-Id: 948e62f1-ea66-490b-c10d-08debcbef297
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|56012099006|4143699003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: QKEtRq1BBoypbA1LvI+xgdHgD552KP2nD51ywDgLiJCnLMWO/Kdqc33ZB23EVcXqUtZpZ+CRqxXHsdHZEDcjObjd18T9LzqDtF/d5OCj7JKeOZF4sE2iw5glpUU11mixV3D5NbId1GQBcIFQei9dNGI2Fl8brX/SOvYzo/XOdYPnG+UFKxzTVyiyD8UkW2D+j/W9StkLNDhSQCbNOZP1z96o/4glZ+/dF3hphM8O6zTcjDb4rX7DgkxeWQ4aa293gv2NH0akrMd6Cp6ooqkoKAu7kgagc5bt7AdftrMHr9WLvBKyopyF34z0SSKCXcp8x7Ul6oofwAvfBRt7tNavBG3QKu9vxeRiTrHG/c4XA+k61d+a1j/Kg5R4Rhal7bzE/DNVNdvOA/G7B/o47xLh+0kGSsJQMncovnhp6E4Sl6GCl2GUVXc/bw4p1B8qfDCidrfzJPpuVmyWbOhItdpqpo99DJ8evgX8wILD259pf4AoO9+3blDKAvcdsS4znugmMiB0+bPqV9d5EgA6htoCWVA8Tvy9GNlwz+/Z9qM4shHtVU4iugYyJOwbMqdppdO+GSISooImPZXaP82Lfwtwj/A3+9q22ehzDygXUE5dasoOY2inu0C5KG2Mb0XvLj7rNt3OepOnsa3BymzJynhq3lr378mekQTOPvxzLWSbOx14aY9z1eoSTTXOzJRtWoIn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NUdwN3JOaFM2VDZTc3lOb1lkcVdyMXZuOHd4M1BVR1BuMGN3bGgrbUd1c3hB?=
 =?utf-8?B?bFFGVG5Rajc4MERNWGFON2tTcGV6SGJacldHNmdkaEJvb2ZtUS9FeG10eVZR?=
 =?utf-8?B?NEhVdzkrSmsxQ3RQb3FYbUtjUnFZNUlEa1JWRXFOeFQwRmtTeFN3M3J3ZVYz?=
 =?utf-8?B?VjBhVGl1K0ljdUJFWG1iR1QvdkZBQjhzVHIwQ2ZOaXRZTTdzdzgxeHk1RlBD?=
 =?utf-8?B?VEFWUUlOWXNwRFFiVERRaWtBcGxZSHB1cU1oTW12R056bEY2cGdYSHdDdkV2?=
 =?utf-8?B?aWVsbGhNMEZPVXhhK1R3bG15djVjazhlSEYwNTdBTmcvSlVoVXpTenZBMHJm?=
 =?utf-8?B?UU9QUEFxNnlyR1lnVk1HalFJL2tXcXlDWWl2RnlObklUbkU2eUlNSEdNcDhD?=
 =?utf-8?B?V1RZUUJTTDE2UGxodHBjVUxrbzg3cEFqZUIwYTBzNEtGVFRkdDhnOGczTy8w?=
 =?utf-8?B?ZkM5VmQ1bWtreUd0WGo5Vlg2TVBNNitTMHJDOUJmVGdrTWg2eVlvT3IyM2hR?=
 =?utf-8?B?M2VjRmwvUW1KRXNOUUxCemRnVk1mcHNGaXVIYkhtSlBmekZ3dE9MNkdiVCtp?=
 =?utf-8?B?RmhPd3ZYMndRUWZGOTBHd3lzT1JWaFIwcHlobDlrS1JjWTZpRi9mdHdiMi9I?=
 =?utf-8?B?Zlp1bXh0VjFQdXBWL1BrbGZwanFCUUFVVCtGUlhxQU1KUG8wRGFNZThMT0pE?=
 =?utf-8?B?ZXZLVFZLWUkwbVpnNXpLek5KajFKSkVZd3hqZmx5SU9RbmNwRTlGdGpVSkxM?=
 =?utf-8?B?NlJkcG1rd2wrU2I5UVRQS21PSlg3aHErNER2WTVBMUxQRlBLSU1kR3hpbXBE?=
 =?utf-8?B?V3lIUndKaXRtaE1sZnhPek5jelM2NUtzOCtXRi9OL01MRDJ3U0ZtZWNQYVBh?=
 =?utf-8?B?bTNZNFdqL0Urb0VuVFRGbDI4Y3Vwc25uLzNkMG1kaEM3NTMzZUwxNDhSYmxS?=
 =?utf-8?B?cnlwQ2swNHVQTE1oOFdSS3VjUGJzZ2RnYXozZFRlNmhiNGhJTi9WRmxVOXdK?=
 =?utf-8?B?dXRadXVDQ0FnakV2dy8wYTlLMk9VMnFGeDl3V29kajE2aUkyQkU1YU5vUmx1?=
 =?utf-8?B?YnBVS0l0WjM4U0g1Z3QwOWlpanBsYk5kTHhzbmFkVnFnWGNSZWZBc2xhZWJE?=
 =?utf-8?B?R3lNSGNDY0pGTkNvaGRvTzBnRzRLcjY2OUk4UFVpcTlqZDFVWHV2blZXZmdK?=
 =?utf-8?B?VHZUSVF6b3I0TXZQcWtKZjVRbDhDZFZuOVROK3BvcEdFcmFQY283T1d1eTNU?=
 =?utf-8?B?NXc4RlZpaUxhSUIrTFJ2SWpDbjhXVzZOOFg4ckE5ekdGNVVKaVpUQ2lydEhC?=
 =?utf-8?B?VUJDbUpsMmpqalp3Wi9ERVVRNVRwUnBOdk5DdG1ib2dPK3p0TVRianF6M2Zq?=
 =?utf-8?B?T20yWWZuaVVTcW5aQjZkQm9ncTVzL0l4eU84UTJmQy9OTXA4TmU1N29LV1M0?=
 =?utf-8?B?Y0NUY2UvcHZIQlVKUkVGa0dHYzRIbmEvb3VET1NTVFpwUWZXUnVvNm9tZWVz?=
 =?utf-8?B?ekZXcTA1RmZqQ1N5azhqTEFJcFRUblVmRjd1QThQTUk5a25MVkNzeFJnY2Z3?=
 =?utf-8?B?WXhrb1J1VlpMY0wwSEhRajdmZU5hRm0wOHIvcE02Y0ZHVGx3Nm1tWFovc09X?=
 =?utf-8?B?K3VKTGE5cU5sejdubTFBeHFNVmRXSFJ2a0xndndEOWFhNWV6WDJoODAwdXFI?=
 =?utf-8?B?Um1qY3lJZmczMy8rV1BnekZqN0V3MUwydmhGQTJqVmVUak9BMlBUdlE0V056?=
 =?utf-8?B?VENiMnFRd3ltR25xcjdHdkwrNW8wL0FJbXNEUGMyR2FUeGVZdWFqSVUxa1l6?=
 =?utf-8?B?ZWxkNUFYUEJLd0FUUi81RTBVZVNNYmRSM2k5QkxjVmhtSVFZT3h6SHJWcHFZ?=
 =?utf-8?B?dVFUcGN0bXZHZE1ERkxoZG9CWXhaendndUg1MnNGT2dXQnJia0dJQWZrT2Jt?=
 =?utf-8?B?SG1HRy9QbVMzK1RkZFRoZXVqb0x4RzFaR0Nvbktab0ROd2Z2ajBLUkNTZG9j?=
 =?utf-8?B?MUFLN2szS1Y3VHRTZjN5OXlocnpJdThBbFBFOEZkR3doUWQwZ2FJZVhlVHN4?=
 =?utf-8?B?ZVY3TFBTQ2FmMUM4Q0Jzd2NYM0E4bTlsYVVNSUxaaEh1L3gzMkVmQWUvS0Vu?=
 =?utf-8?B?aUIrY3hGeW9rVzkyMzlnY3RiKy9zTkgrdzlOS3RSbUhTc1JDUlptMXNwOGlx?=
 =?utf-8?B?S28vajFUb1RQaVNBcUV5WU1rb2VHZ3NJNEwvUE1QcDVWazhRMGJuNjhZdG8x?=
 =?utf-8?B?ZjhnY0t2RWtMVkcxU3Fpd1plbzhHZWpNRDFCbDZkSXhHMGxOdEltd0JTRllW?=
 =?utf-8?B?RWtmT1ZSTGJkWHhWcDU2NERSOTNyOXlhV2N5YTZXZmJoaXBxOVlQbGoybE55?=
 =?utf-8?Q?mDqZ+xSsTYK1oGoM=3D?=
X-Exchange-RoutingPolicyChecked: MzCRj5MVrv2UbGwCVpP1bnD7A1cSZL2HF+GGA1IGPEtZnVT5KUkdPfLJbtkLS3zUahfot9MnVRq7+WAsiY5C+l5HqpvNnR9BvhMNizqjEechbN4ATyL2aOIkso6XztQydQphA0yqDcEayFEzUt3KGaUuC9s4Her2iy4fguS0KzZyzfdLFGcEOlppVSU44IMgiPALbEiLmaKINz4pe5ZN2OItVi68Jno9jqHz0SGBuQibflIPThnOx+M0k235S4/StudFiu/BWD2Z4blLVk/n13mdtxIVrLN5eJZX6U4B4FX0eAaSyzm3UKm6kuzca2pwCbqbgXkdvZw/vJLzVw0WOQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 948e62f1-ea66-490b-c10d-08debcbef297
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 13:42:23.7287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: efhUnCs8bsDT6SamyC0FP7MQ2M7FS+sS+lH6FinpZRnRtlicG4TqfJn/RPOxmlRFdRVlygDPwC/gn4ViABsM99fKF7SEpqgh9ypNy7NW47k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSSPR11MB9666
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292697-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,airoha.com:email];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksander.lobakin@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: 2E99A5F2FDB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 27 May 2026 12:21:15 +0200

> EN7581 and AN7583 SoCs support connecting multiple external SerDes to GDM3
> or GDM4 ports via a hw arbiter that manages the traffic in a TDM manner.
> As a result multiple net_devices can connect to the same GDM{3,4} port
> and there is a theoretical "1:n" relation between GDM port and
> net_devices.
> Introduce airoha_gdm_dev struct to collect net_device related info (e.g.
> net_device and external phy pointer). Please note this is just a
> preliminary patch and we are still supporting a single net_device for
> each GDM port. Subsequent patches will add support for multiple net_devices
> connected to the same GDM port.
> 
> Tested-by: Xuegang Lu <xuegang.lu@airoha.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

[...]

> diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
> index d3781103abb5..c78cabbec753 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.h
> +++ b/drivers/net/ethernet/airoha/airoha_eth.h
> @@ -535,10 +535,15 @@ struct airoha_qdma {
>  	struct airoha_queue q_rx[AIROHA_NUM_RX_RING];
>  };
>  
> +struct airoha_gdm_dev {
> +	struct airoha_gdm_port *port;
> +	struct net_device *dev;

Nit: we now have priv_to_netdev() (I hope I remember its name
correctly), so that we no longer need to store a netdev backpointer in
netdev_priv structures.
Just an option, up to you.

> +	struct airoha_eth *eth;
> +};
> +
>  struct airoha_gdm_port {
>  	struct airoha_qdma *qdma;
> -	struct airoha_eth *eth;
> -	struct net_device *dev;
> +	struct airoha_gdm_dev *dev;
>  	int id;
>  	int nbq;
>  
Thanks,
Olek

