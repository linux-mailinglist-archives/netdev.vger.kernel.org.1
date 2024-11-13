Return-Path: <netdev+bounces-144427-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D09BE9C72F8
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 15:12:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F375281068
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 14:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D031DDA15;
	Wed, 13 Nov 2024 14:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S/+oTkQj"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698FB44C7C;
	Wed, 13 Nov 2024 14:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731507135; cv=fail; b=oCdfANZG9J454AmnhbLl4N/uSy6/Mv2sc1ZanMZ0bM5QsIV3NH2sVx2cQIkAYqQySFgMOIALJdwQ2x3gGnnXRcjESVbYLfew4oYUa7QyvqX0p08bjKOfEg3j3pdDkt1DYR/8xaoQGfVqjCNpw1lhJIBJ9yIY6PdzrtIjukexTl4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731507135; c=relaxed/simple;
	bh=a5yyFP2+MsHfDd21+8b0U4NCqcqUoBJa0bYHCWCh/60=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KSnX2TjHvZ7mJ9//ID2xq5p7UvFtZ5RWFdSO8bxWtw9CBvxLlLYN90mx78WFJw3HJQyY68hLkiqW/n613ppu9kgSEuO/TA2pU0dMVKGWCg36mdLGWkTNWqV+kYyq0jPMwZ7N2zDSlDlcItP9pJsjcfX35z8zTCEvsa2EWM+EDR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S/+oTkQj; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731507134; x=1763043134;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=a5yyFP2+MsHfDd21+8b0U4NCqcqUoBJa0bYHCWCh/60=;
  b=S/+oTkQjHxs1m30KVNBIfPgZtxQg3jhnJpAxW4DIgZ8o3RbalkwBIyrA
   PySvyvPjkku2o8G+4Mz3+G9dWkQiCx/3z6rt9i0xBK5lerw+AxAMqLmkN
   qPHtXld4/cPQvnhswtYbEU6u5ETRYQgjiFWUxGP72nTzm3MnW3W0osxwJ
   YKpsMj7+atRwDVyEilJDmto5qAgEcP4HBnulvd9uFsq3m2crDOVuHSjJL
   114k0AlPjyFIr0zPA//YXpfzmhNiGiy8UKcr15RZvrZrooUsIg6uCK1GI
   R4MAthhiujfiiHoxdSbfVFawlPt8b+Ae3J3F/ILkIorPsUD9taTXHFngc
   Q==;
X-CSE-ConnectionGUID: dtY72vTqQVW6tGNeGH24gg==
X-CSE-MsgGUID: hkmGQhY9T9ep3oOu3s6A0g==
X-IronPort-AV: E=McAfee;i="6700,10204,11254"; a="31510639"
X-IronPort-AV: E=Sophos;i="6.12,151,1728975600"; 
   d="scan'208";a="31510639"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 06:12:13 -0800
X-CSE-ConnectionGUID: k8YHUnPuRYCRLeWqO+79CA==
X-CSE-MsgGUID: GK7+sOG3SXmjlw+H5poLhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,151,1728975600"; 
   d="scan'208";a="87782276"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Nov 2024 06:12:12 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 13 Nov 2024 06:12:12 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 13 Nov 2024 06:12:12 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.176)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 13 Nov 2024 06:12:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JYyT6GAu0Lik+c23b0Ck32BnT1MnEsyCSgYtdd7iMN3HvvUibLQJsgo2vdTsKMaHQnHaOOJGh8m7abiWXemBDwdd3BTpf084Je/x0AfhzgdwX23tYnc8fW9LHDb0YQ8ZsBH7jhfGDYpFvNPWFChwbnw51GobFksdckEdfXowCiwyAbd1ZUMtOfcA8NpspDnPpxzqa77XLxAI/4c/LVP/IT9EGCtbDhK51A6OOx4GPUTS5Lw1XUrmgbDmA4CTpWP4ST67qUnjpUD/Zerq3edDPSksQmAJ8NGkB0yJXrsDKES9SAT6cOlb9ThKOIos6cvZb8a5q5feRiB9C3jmFR7UUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ak65fDEj7An/FkS9193Amr3Z7tBTVNnf7s+B5qQZre4=;
 b=AR+IrTC7p4mbFvvi+Mk3QoJei+KM2SslAOJ2TGaXkru134Tt00/JGJSKsjkr3A4Mu8QqS/3cw7UcHknacQlYKJMyH3J2Xhap2jneem6QtvOu5gyljVVliOHYdHbxhFiQjwTux7LdMTnjGK6aQvn9usBY52+MEH+GDM9UIul21GaL+qzDrVwzSI8mdqcTJgIM59TE7Z+pT5sbUUq6yZedYZD+5bbFI8ZehJxrMtWzKUUejd+0DiKvM1QEU0vFtqLWfpl0uE6LPWCldTucUPGhaqKwqZObsCHVHrxKleSf4lyGokhYl+tG65kK7ZekhY0xchkMkio/LMPBbKjj5ShVHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH0PR11MB8086.namprd11.prod.outlook.com (2603:10b6:610:190::8)
 by SJ0PR11MB5055.namprd11.prod.outlook.com (2603:10b6:a03:2d9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Wed, 13 Nov
 2024 14:12:08 +0000
Received: from CH0PR11MB8086.namprd11.prod.outlook.com
 ([fe80::984b:141d:2923:8ae3]) by CH0PR11MB8086.namprd11.prod.outlook.com
 ([fe80::984b:141d:2923:8ae3%6]) with mapi id 15.20.8158.013; Wed, 13 Nov 2024
 14:12:08 +0000
Message-ID: <2092f824-b60e-4d78-991b-61b35a312597@intel.com>
Date: Wed, 13 Nov 2024 15:12:02 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] xfrm: Add error handling when nla_put_u32() returns
 an error
To: Everest K.C. <everestkc@everestkc.com.np>, <horms@kernel.org>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <steffen.klassert@secunet.com>,
	<herbert@gondor.apana.org.au>
References: <20241112233613.6444-1-everestkc@everestkc.com.np>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20241112233613.6444-1-everestkc@everestkc.com.np>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0293.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:8a::8) To CH0PR11MB8086.namprd11.prod.outlook.com
 (2603:10b6:610:190::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR11MB8086:EE_|SJ0PR11MB5055:EE_
X-MS-Office365-Filtering-Correlation-Id: 04eea55f-1af1-4bda-c2e2-08dd03ed2899
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?TXNnTWEySTd3VDlsd3dXYWtLdGxVQ0x5d0UvaHF6M2F3NUNXVXNac04rNHlw?=
 =?utf-8?B?VnFtSStiMW96OU9ZZU9JVzROK3BOTnMxa1U1MXBnWnVTR1ZJVVlxNnk4TmhX?=
 =?utf-8?B?VVlLVFp1L0hzY3BkWnBOQlU5VkFmMHVYVzh0NWIybzA4bkZ6KzVtbm1tMEph?=
 =?utf-8?B?czNFbWNVS2NNZmZzY2k2d1ZtTkVVMWJKSko1S21kNlRKZTRlVlhHR2RicEJ5?=
 =?utf-8?B?NnVZWm0vd2dQaVNyVHZDWGIwb0MwT1RQcTFXbUI0dXp5NjlrY2M0aEUzL2ls?=
 =?utf-8?B?N21BdGRDMjQ1QzZEaVA1NHVhNE93YVJSSFErTXgyL0pBOGpGQTlIKzVHZ0pa?=
 =?utf-8?B?Uml0S290ZkRyNGVHN3ZaYWNhRzVLeEYya05JZUsrTmJyOTkwakNaT3UyUHNp?=
 =?utf-8?B?THh0aFEzRnlmWjdOaHA1anlWMWJnVC9hSEVRanNqZ2JqSWlOa1haTWJKVTRi?=
 =?utf-8?B?WnVTb3dQL1dmRitNSVVXRkV4Y2x1UkJrYnZuVDBLSGdvbjZZTlVBMFo5eWJH?=
 =?utf-8?B?Nm1GaksvcXc1Q1duaDBZaktLWjF3cGQ0SGhuejRkN0l3NnoyN2tlSHBjUGdX?=
 =?utf-8?B?RE8vV2tiZGxITDdDOHA3U0RSemJ3NUV6VCtNUitRNE9yZ2tndWFWdWI3LzBR?=
 =?utf-8?B?SVVabEZxaHo5alBMbXN3c0RCbUtnbHBEbldIL2dSMW8xd3djVE9ORVlSRzJk?=
 =?utf-8?B?OTZxODluZklEdGlyM05pSDhOR0E1Szd2SnQ2djlNbjQrMzdkc2hNQ1BUcUdE?=
 =?utf-8?B?c2k4NE8xeXR5d2o0aStMZ0h3Ky9LT1FIZGlFSXdlNXR4OUJRakI1L2hSVE1h?=
 =?utf-8?B?QXJnaUxyaXNyZzhhVTJKNVVyNnp2YWplZ0QvWmxweWZ1NFczMjZvck1Lb3JW?=
 =?utf-8?B?c1JaQ2g1Wkd2SGRLckd3bkthb2tGck4zYzZ5c3FLSEZhMi9VR3hkS2NPSVVV?=
 =?utf-8?B?RDJCOXFTd2RFRGN6akVQenpoTndSUTVKUVhsb0ZiQWUyS3RlcmhqWjR6Wk5y?=
 =?utf-8?B?VjIrOHlwTHhVRktMenBOSTN4bzhnTC9KZ1J4a1Uxd0dDK2dETWt0WG9iaWFr?=
 =?utf-8?B?bmdsNytoRC9nZHBpMW9JMGdyczlTNldSSHdabGVmUmdZSGx6Qy9hUWx6akpR?=
 =?utf-8?B?V1AxeVo5ZUx0QnFXcHQrOUdsV3QxY21NalozbFM4MkJ2aXdOR29Ta1RaUlBn?=
 =?utf-8?B?b00wVytPWklndWgwdE4rT1lkZ2pST29zNUhjZDhINmpDTVhsekZzTCtPU2lH?=
 =?utf-8?B?UURCUEJjNU4rWlJpWWpxcVRrZkdEeUQzQTlTV0VHWUF6ejdtZmpWQW1DYytr?=
 =?utf-8?B?akRuMGpkZ1h5dkNtSlIrS0lLaFlsYi9EZzNES2NrYkhCc0puNS9uQ21CQ0ow?=
 =?utf-8?B?L1RKQ1ZWdE5ienR1cG84VTBURVh1SmI5Vno5YlRibzUzeGhOWThRUy9ieHdo?=
 =?utf-8?B?emlVV1ZWRGd4eGxMSkpsOThvM3ZiR2xrOW1rNHBER0R1WGJ6eWV6aHJyVVdE?=
 =?utf-8?B?L3dqNTcyQVFZUmJEd3JUMkNyVjltaEpBdzhQekh1cHJHYXVCWlJZZzBjVXQ2?=
 =?utf-8?B?bGVPbkxQKzl6U0NFSnZob293SmtKM3I3SHVSVU5GU1hHSGlzSUcrcjNYczRw?=
 =?utf-8?B?a0JSbGRkL0t6b1BlelR0WDdhbUVzRm1XZjgxcEd6TC91ZUtIL0ZjcWs2SnRz?=
 =?utf-8?B?K3owMU11QjFEZmVNYkFKQXdyS0Uxc0IveVNWbnVPRlJkNTYzQkhVeHZwUnFj?=
 =?utf-8?Q?xHL5umUuW2Q/7Zmtex+GuAovZAsp7dbWcMxDwAI?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB8086.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZEU5R2l5U2RnMU1OOUpLT3VpNDRHRG1HVm5FV2xrd2hCZXkyTHhtSFkveHN0?=
 =?utf-8?B?Smprc1UrQWQ1NGxjbHdWR0luQzVwVzFXVUhMcnB5eG5KR3QxOVErbW5jWDFl?=
 =?utf-8?B?WFlwK0JiNUcxR2tERDJpNmI5NjZFRmxPNHhteEFNMFlGQml0YVVVSHFOYXEr?=
 =?utf-8?B?UjhCa1ZuRzdUcHhSYXNLN1Y1b1BWR1BBb2piRXN6UWgzOUlnK2V2VHVzTUp6?=
 =?utf-8?B?bzJ3enVDaWI2eENuWC82RzdHdmZ4SEN2OE8raGlxVHByaUJkZGRoM3dSRXZ1?=
 =?utf-8?B?eGpsaDJGY09STDlVWDdSYWptRmxyVmIyZFI1VGpFS3ZxKzQ0RU9mcjJwS01x?=
 =?utf-8?B?TXQ3QzFIY1IyWDFmY0NtckxXVU8rSG5mV29xUGhwZGQ1cHVxSGhETHZEMmEx?=
 =?utf-8?B?YU9mUml6Q0RSWkM3RDBGdHlubnJ2L0hlVVZDWHpyNkozaGNuQW9VQ1ZDYlA2?=
 =?utf-8?B?a1pUNWJEY0t4ZEdVd0JXZmYxUzlvOVdwZXJEWUNsNWNWSDBua3ZXdXZHd25o?=
 =?utf-8?B?TEJLclo3bzM0Qk1HbTU5emVXcXdkckw4WDBMUjUwakF1eGJqek9ESS9iOG9P?=
 =?utf-8?B?MnZlQ3ozWE9ZWkNnNVNGM2V5ZkRsNTlIQmZFamRUZXlabnlRVDBycHc2N2kv?=
 =?utf-8?B?YTg3ODRJUEhndGxNUW44NWZhOWJ0RVpIUlMrQ2g5NnhOK1FsUVVXQ3dRanI2?=
 =?utf-8?B?RkdRcGtmQStXOVlIUEhSWjY3cVRXRUpCN0FURTRnN0Z6WndKc0lYZys3d2VS?=
 =?utf-8?B?ejhtQ3MwUVZrOGN0a3AxdWxpSXlmUjlEN1dKNnpMWUhwNHh3Nkl2eVAyaDNw?=
 =?utf-8?B?TlJqOCtDWG52dVVEaHRQbnhKQ3RLV1JkU0JoN2lXc0tXYThGaDRoUmJoK012?=
 =?utf-8?B?Wmw0dXhpMklJMXk4K09tWldoclhGeUYxNXZzQ2FCNzFZTE1qcjk5U3dVcjJ6?=
 =?utf-8?B?OG5YczJ1Ym9PYkFmMUh3KzIrZ2E1ejJvaGJpanhaNWpqYm1TMFFnMHZnRGZO?=
 =?utf-8?B?N3d0QWprOVUzWXdiSXo4Q3QveTZhYlVlbFdyQjlISld1YjVzQ1dGTDEzVmhq?=
 =?utf-8?B?S1pMVG1QZytWZnJIT2hyb1REdWtuQnY1ZVJLN3JSZXB0L29ybDIybXZTSGx3?=
 =?utf-8?B?WlUyWkF2U3dScnpGcXF0WTBLZTgrS3J2ZkRYYzZFVUJZQTQxbktBamd2WVNq?=
 =?utf-8?B?VjBwQU5BMDA5cDA1a2VKTVhrVFhvSjFQSXZYRngwMiswWm1hRjFSUkl6NEg2?=
 =?utf-8?B?OThWLzkzdGdnN3VBQ09tQUp5VEpMREEvTHpMbWlKbHdKemNBL3ZtdjEzenFy?=
 =?utf-8?B?ck0wQXYvV0VYSStLTDU4WTRnRzB0cXhoOVd6S2Q1TXRrTy9wY0NGbnhWdE1G?=
 =?utf-8?B?U1Y0bm1VQlk5NEhSL0pSUElrcEpSMC83dzhoOFY2NWhEY0ZNaUlCNGNaYUQv?=
 =?utf-8?B?R3NXa2VyNjNsMHU0TWE2L09mblZuL1dzdEQ5NFJGdmhNWWs2SndJalVxQ3cx?=
 =?utf-8?B?VTZuWmNzY2twMUFLcytpTk5tekw3R3ExKzBCNi9tckl1dnhIclJ3SzhyUThk?=
 =?utf-8?B?alR0ejhjV1V6Vk84V0VPNFMvTTc0MGhhZnVqM292c2lVMXpQSTc5N2dLT1J4?=
 =?utf-8?B?S3AxU3FOTVVCdkNGMEQ3eExZaTYrci8zSDJXcDNYdWlhNDlqWThwVkdVZlor?=
 =?utf-8?B?UlI5eldjdFM0UW9RZVMwNEFWcGxiMC82U1RINE1taC9qU1JOemcwZGZwb2k2?=
 =?utf-8?B?RVVPdGxRSjBwNlBZV2VIdkFHZlhnZTJxcGk4TFlwbk1wUmMzTWg1aGRQc3ZW?=
 =?utf-8?B?U0dhbjNLakdNSGRJMmtkYlRMbnAzVXlCcm5LUU5EZmF4bU5uamVra3FFeVhI?=
 =?utf-8?B?aVNJTGxzbFhkYjVRQWpPNUZrOWlsZmJZN3QrWGlDVG51RTFvb3h0RjlpVHlw?=
 =?utf-8?B?dEdSbERueWMzL0JLamhOMWgzZVdFMnZMNCt4VFZ2bkpLNmdDSStqaFhDNkk3?=
 =?utf-8?B?cy9GUEpvcTlkZmFRYWs4NlJ3RTlJeVR4c3d0UnRveXc3UStLeEFTdUhwY2RW?=
 =?utf-8?B?V2lhc09yU2tweUY1ZnhyNzNLcWcwOTdUb0RJWVJ0RmZTekRkdWJ0QnVVc1E3?=
 =?utf-8?B?ZTU1K0k0bWVicnZMZlhjVmlXWUFmU3NLRkdpZWpMM2taRCtvT1Q3QlVLMFhn?=
 =?utf-8?B?MEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 04eea55f-1af1-4bda-c2e2-08dd03ed2899
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB8086.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 14:12:08.1225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w1eqFvSrsDjKO3XsBm8KtFDj3yqw6QFibkypZSbih8haBVd8u81Ae10lfab3+o/VJYDXVjjdEljpiiecA3gMJX8iWonJnzoI0wNEkYKEH5g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5055
X-OriginatorOrg: intel.com

On 11/13/24 00:36, Everest K.C. wrote:
> Error handling is missing when call to nla_put_u32() fails.
> Handle the error when the call to nla_put_u32() returns an error.
> 
> The error was reported by Coverity Scan.
> Report:
> CID 1601525: (#1 of 1): Unused value (UNUSED_VALUE)
> returned_value: Assigning value from nla_put_u32(skb, XFRMA_SA_PCPU, x->pcpu_num)
> to err here, but that stored value is overwritten before it can be used
> 
> Fixes: 1ddf9916ac09 ("xfrm: Add support for per cpu xfrm state handling.")
> Signed-off-by: Everest K.C. <everestkc@everestkc.com.np>
> ---
>   net/xfrm/xfrm_user.c | 7 +++++--
>   1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
> index f0ee0c7a59dd..a784598cc7cf 100644
> --- a/net/xfrm/xfrm_user.c
> +++ b/net/xfrm/xfrm_user.c
> @@ -2607,9 +2607,12 @@ static int build_aevent(struct sk_buff *skb, struct xfrm_state *x, const struct
>   	err = xfrm_if_id_put(skb, x->if_id);
>   	if (err)
>   		goto out_cancel;
> -	if (x->pcpu_num != UINT_MAX)
> +	if (x->pcpu_num != UINT_MAX) {
>   		err = nla_put_u32(skb, XFRMA_SA_PCPU, x->pcpu_num);
> -
> +		if (err)
> +			goto out_cancel;
> +	}
> +
>   	if (x->dir) {
>   		err = nla_put_u8(skb, XFRMA_SA_DIR, x->dir);
>   		if (err)

this is a fix indeed,
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
--
I find nla_put*() familiy error handling very ugly for the calling code,
especially given that some of the calls are conditional

I would like to refactor it some day, to give the caller possibility to
just put all the needed fields and check the error once at the end.
Nesting complicates things a bit, but perhaps it could be also covered
in such way (didn't checked yet).

