Return-Path: <netdev+bounces-132910-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6874993B6F
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 01:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA5331C2297E
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 23:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6AE18DF65;
	Mon,  7 Oct 2024 23:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kvFdVZUQ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B074317E
	for <netdev@vger.kernel.org>; Mon,  7 Oct 2024 23:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728345176; cv=fail; b=Uhw3vwVxGhq6AalHN1mzq6G5i70hrMTT4WaXnK03vmCjWhfNkq/6h8zajrn5q5XZSKNtMVCXKZEdaQ5BSIEwArOlazQH57pwaff/O03FMuVcBlsCq+bYxQVkaNl7kUb5tsHHO6kWAceZneZGV8ndoFjd07ro2ZVI0v9HX04B4P8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728345176; c=relaxed/simple;
	bh=PDmlJ1uRE6rzcgtlHsi7CPACq0IsqmVweFGVTGZudCc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GlsEuA2a1znESeOja1fxIzcnnzHmvtm6JuRVUSTHUIGH5TwdDUB/AP4BsVFcdPjNdTxgb7Xz3edXqqtpR+piWx0al8JgGyj7mf1z+Sr1CUPUxjqTnTTFSqr6jLRMXlSJkgBy2yzkVV0piL0oswzVd5Qf5q1bn/GTdmCfGn0LGXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kvFdVZUQ; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728345175; x=1759881175;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PDmlJ1uRE6rzcgtlHsi7CPACq0IsqmVweFGVTGZudCc=;
  b=kvFdVZUQecuY+4s8+rKkzJUSKXMQG/KZGaKmDpyGzokiaYzAnj5cZ1iL
   sTCGgytAOSE8LmevB2ksFzsPMKPkHFIlXl6FIH2l/+5RfYA6d+zlcN3TC
   iI4KZGkek+OrhwarGbCIrAgcSbeARvYky0UR7iH3rSF3o9xDsVu5xUvgf
   vOyJSujnlXPA74YJwhgXQYsCS1I7r2/jMynMpJDWaJUkaY3O3TW0Ot2Uo
   yNBP7h6WcRGyN7ZTW2R2KsGlCETS0VzWxsd2eR0vDmTRMzcGkAl9oQ+PD
   hJorXCagx/ujdbF2VDhOAagpNwOLvkGz8WYERiVxYQ3JJFWtJMf85nswG
   g==;
X-CSE-ConnectionGUID: KUdbzN9USJOpP80un7mVPg==
X-CSE-MsgGUID: YMdMGnWBTW+c9RVd7tviPg==
X-IronPort-AV: E=McAfee;i="6700,10204,11218"; a="30399350"
X-IronPort-AV: E=Sophos;i="6.11,185,1725346800"; 
   d="scan'208";a="30399350"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2024 16:52:55 -0700
X-CSE-ConnectionGUID: PEmIWPURQyCTL4YHyCliTw==
X-CSE-MsgGUID: Cx0X/iqxSXOoaglu17h5KA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,185,1725346800"; 
   d="scan'208";a="98966399"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Oct 2024 16:52:55 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 7 Oct 2024 16:52:54 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 7 Oct 2024 16:52:54 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 7 Oct 2024 16:52:54 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 7 Oct 2024 16:52:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QH3ZfirZI9LfJLZ2AcH5va18Fb9ek+9n01PGjg59wKKqXGDnr0JWBe8MVgjBIEdMSRNYYZRFdRoWxGltcU//Il/ddnABcuzUEMYAdsOXA06a0EMozGC7vBr5xE6rwPPM/0/m9N+/W3+UPJ79Zcsv9NEdWAzwPWeh6LhMR73eAxnw3uYy8NTmHcyhwwwLH1uh74YWGbfaKDcXadI7iDwvOZTSmAzPVspAfRV959CaZ0Uc3BTrH2UjfOunRY8MXEDTfSWEZV/i/PRFPPNh+iMACAoEjXBzRyI57wrdBI2F1LrUp15JqrqQ+zUlmzFbmqT42Z8dPjH4DhAgemvdfTenrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gss3VSHoC+kt5/mOpcKVsHEw8aX2FflvyEOsPFAfNdY=;
 b=WLCY+/VsdGSETB+KcC2jsAdXVRVY+paWA/W5lWHMqC38AmK8RYml9YX4n3y8uearOMsIHc/S1b2ldnsnnFoPbAfM00Csexw5o174Pl9uAVGXBKu8rbvk1ZGmgAZXXclc7eonOBU5Oc/yX4UCG+HxycG+kogbmo7iy40caTwNp1vR0zm+7JKKZzsit1RRmOEbpTUViFH3Noy54K8Y4gf0hV1wlHHJjXxzsBu0yIheNm4JvOK7S6AXz0WfcWiIHWpstrbrSGMFGQgWECTOaBDkB3z71ydlm+1oI2keMUVnhQmaihDopxkHMdbQUUD42VDEUgXmUJ0ddtswlsxbyW8UMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH8PR11MB8257.namprd11.prod.outlook.com (2603:10b6:510:1c0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.23; Mon, 7 Oct
 2024 23:52:43 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 23:52:43 +0000
Message-ID: <2828a21f-780f-4a27-97ad-0628fe6eb85a@intel.com>
Date: Mon, 7 Oct 2024 16:52:41 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 1/5] eth: fbnic: add software TX timestamping
 support
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>, Vadim Fedorenko
	<vadfed@meta.com>, Jakub Kicinski <kuba@kernel.org>, David Ahern
	<dsahern@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David S. Miller"
	<davem@davemloft.net>, Alexander Duyck <alexanderduyck@fb.com>
CC: <netdev@vger.kernel.org>, Richard Cochran <richardcochran@gmail.com>
References: <20241003123933.2589036-1-vadfed@meta.com>
 <20241003123933.2589036-2-vadfed@meta.com>
 <57d913bb-a320-4885-9477-a2e287f3f027@intel.com>
 <ac195016-a05a-4757-9876-94d076937af7@linux.dev>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <ac195016-a05a-4757-9876-94d076937af7@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0003.namprd05.prod.outlook.com
 (2603:10b6:a03:254::8) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|PH8PR11MB8257:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ffca303-f4d6-4e1c-fc92-08dce72b2293
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NXRMRzBuR28wWHBXUkNmcWhKZXdPNUgvVUo5WU5TVmpYY2JDQ2QzbzVnKzFK?=
 =?utf-8?B?bisyWmxEWU9NNmtKT3k4ZUsvOGlhdmNTRm9oYi9CVUh1Qk9iSWxWQ2RzSS9p?=
 =?utf-8?B?RkloSHFMd090cWpmc00vZE1IOVlWdllmQnpqMjh4dUlBRUkyZVVOcDgyV0Qv?=
 =?utf-8?B?aUJhN0swcS9ZOVRsd0VUNTk2U1pmUksxKzdiOGQ0Sk5MTFZ1QkhwNUFUR1Iw?=
 =?utf-8?B?WVdiV01KbEZOeFNrdzU3dml5V2hyMzZ5a29RWjA2MVQ0K1pGQU1GVTROckNr?=
 =?utf-8?B?MVVsbDluaEtoNlZ2ZGNkV0lUM1R0L25aNXE4eU8yZFh3UkhVNEtSays3QmZ2?=
 =?utf-8?B?R1pHQkJVVHNiMk5kQTRQVkkwbHRuZXFKc1c4VERnL0N0eVNpUXo0U0RyMjVI?=
 =?utf-8?B?b1A3UkVGblhqellyUWZoUFhiMUNXUUJTTmNWendFUEcvTUJWY0JEUE0xa2Iw?=
 =?utf-8?B?RGNsbHUzYXBPMldDK0ZtaHpDeVBkRGhlYWwrbFJUN25YUHZFMEFLMnlPeTNy?=
 =?utf-8?B?QkNnRWlpL2cwdHloYzgzZTVaaEhCTmdhSDhXVm5nTGd6cTRkNS82ejdIYnZ0?=
 =?utf-8?B?QkpwTDNwcll0eXNyRFBHc0dDVGlKV29jb3pqQ0cxSkk4c2ZXSFpGcW9LbitX?=
 =?utf-8?B?dVBaeGhTVUVRSEVlWWhLOTB1ZzlxcGg0N1hKRVhGRmUxWjJZV2RlUXl0QzQv?=
 =?utf-8?B?YUxXZ2g4V3Zhb1RoZDMvSXhYSUZKVkQ2N1l6VG1xZmg5cVcxaFVJdmNMUzlq?=
 =?utf-8?B?R3FhZHFZU0JhYW5jeDdPUE55VTdGZG1FNURyVzZ4OVZ3dVVOeHY2WGZ2OUFZ?=
 =?utf-8?B?ZXp4eDZtdzB3VU9uMEo5SHU2ajNpSXJhMUdyNHk1MGhlQjRXYmttbjNnR016?=
 =?utf-8?B?WEN0bEJsZDFDNW1ud24yaFp3N3gvZUdNZk1JbTkzR2RBbXo4U2psUjAyL3Jl?=
 =?utf-8?B?QnA2Wjh4SUI1ZVZBYm1xekVseTJtR3kxbi9Ub1A0Z1lnU2JBNlJYRnpNRmlZ?=
 =?utf-8?B?RitnOXl0alBraml0UUtmek9IV0N5VjU3MC9nRTd6VHNYbVo3dHBXMkM1MWJL?=
 =?utf-8?B?UFZBRDVvUjlqMExOSFo4TmNTWW1EQlJkRkJsN2N2eE93T0RBZ2pjOTVGZ1JJ?=
 =?utf-8?B?dE5sY2dPTVQ0YnU2SzZ3SFN5clBTdmY3a0M4YXNjSkxuYkZmd3pvaE0waW1z?=
 =?utf-8?B?WFVvTzVvWHArQjlaR1RVNjVsZStFNG9obXdxUUFKa0RHdEs2YmJ0SXJQemg3?=
 =?utf-8?B?Y1QrYzh3UElCNEloRzIwb0NXUGRmN0lRaEZWSldXN3Fyc25hWUU4VzV4UDht?=
 =?utf-8?B?UXEwN3JmMSsxRFdkSmluSWZRQU53Wll0dm1lUFdmM1ErazJsK1ZIYUJOOXBD?=
 =?utf-8?B?bktoUUpBQmVJUHRWVThGUHVSTys2TEVIMG54SC80SkVhNkw5d3ZRQU44NjA1?=
 =?utf-8?B?L1B2dlluQ1JqNFloS2hmZ2d2bjRKbXlRZzdicCsvZnRnMUlGREdveGdEQk83?=
 =?utf-8?B?VnUraDlFREtEMms4dUF3am4wRm51N3dyUTBHcnBaNmcvcElmR2R0UzdIUmNR?=
 =?utf-8?B?Qy9mcFUrMzhoSG5MdERDQkhpQXB4Mi9kYW51ZVRrQmFGUFk1dE9ESW5zdkFj?=
 =?utf-8?B?ZXpHOGdoeGJ0MzUvQys1eGduaXM1b0t0U1NOSDE0enRtcjlWR0svSVVGWEcx?=
 =?utf-8?B?RlY4VnFCUDY4NnVRS2tGVE9wc0xFcVFtTzh3dUJWQ3dORnhSNTRNOFh3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1BpL2U5eHV5cG92MElYOUxLR0dlalc2TXVGT3pOZDNxbVJZejRuNDNWNWVu?=
 =?utf-8?B?ME9YSmJLeHdncE1MWTZoRnIrQ2M0ekVVWXdvdHdwUytkSGNWVnR0U2JWQmpk?=
 =?utf-8?B?L09WdlFiU2pWYnZRZUErSXMrL1EvMnJ2UitLaHNLOEM3RTc2UllpZWVHYXJq?=
 =?utf-8?B?UHFvSlVXNmN2ZTlMenVYWHVXa2NMQzlPLzZmaDJEeiswbTkrbWNtUndNZWRY?=
 =?utf-8?B?a3dLZjV3TXJIR1lSU1FyL1luTDVzMkxyNnJHb2pqdkJQbmFvK0FyN1lCcDdL?=
 =?utf-8?B?MlI4emhuRTdzalRCM2lhTHd1N2Jzd0hDbGpoSUhHRkZ4OWdjZVp0dldxbytN?=
 =?utf-8?B?RXlJbm00REFUMjA0a0hMTHZVMnQvYXM2V21vSTd3UDdtREdadXdqeFlTNGs3?=
 =?utf-8?B?TDRlTHNKQXVPSGcxWHJJTmhFQWI3cVBVWUVqYmZpZFY2N0cxWklib0Q2a0VT?=
 =?utf-8?B?WWhFOW1TVFJKR0hENG5OdWNHcHloNTc0Z0dCbTdBRXlLR0Nub0NpU2t3QTBG?=
 =?utf-8?B?YkhuQmZPckdad3k3N3BTVysvY3BrWUVrNk9Ic3V5SXFGWHhYaGd1OTl0cHJP?=
 =?utf-8?B?dHBhenBCUURtaEJ6QW91N2RPWVh5ZkMxUFk4NldsS083Y3JsdTlHMXoxMlBV?=
 =?utf-8?B?eE8rTE1mWkFJV0lEbm5pcmlNclBzTXlUK1NSVWdNVC9CRlFrWmhYa0hZUmZL?=
 =?utf-8?B?YngydVd3clkxL3ZNT1JrbGlTQllYWUQxTmdSYlU4dmVHN0VTd0RTNGhvMlFQ?=
 =?utf-8?B?U1BvR2JoM3NMMXhaRDdvQmpBYXk0SDZDQkVwWDZ0L0NYdkwyOUVheTMvaE9D?=
 =?utf-8?B?cEVLZEc0aCtFZWtjYTNmQ0VxYnhCenFQeTU0SGovTGtqcGRxd3VKWGlmc2dZ?=
 =?utf-8?B?YUtUajZRanRKYnJpUExRNWFodXoxdHRRZEtzYUVUdHVtUUdaYWMxa0xOZ1BE?=
 =?utf-8?B?RFN1SXMyNmR3ZG1xdHZESnRvakQxRVdhNlpCZUJSU1lWNzBSbjNZR2g4dFp2?=
 =?utf-8?B?bXFMN245VEZWMG1yYldwUUdNNHE1WTluY2l4OGtXd0crdEZRVDRaWW91Z2pR?=
 =?utf-8?B?TWk3aENFS0lDb3hzU0k2YlFXRWtST0lJS29YVy9mVUQ4SHpnTUFjRzdvVjYy?=
 =?utf-8?B?S0FpZ1JZUWx4LzJxbXMzWlBudjVmbjJ6dWJrNGFraHYvcGNyUkkyWm5tWHpR?=
 =?utf-8?B?SFJDZWFoMVhTNHJCT29Vaithc1BuQlN1aUZJNWlXREdxZTFrR2hsRzZ6TGlG?=
 =?utf-8?B?NU1DMmFnK1p1MDU5MGNBMzllRGZhb3N2TnhlYUwycTE3V2xsdmhYQ0JWMTN0?=
 =?utf-8?B?aTFpaDdZTGtrU1pwdnREaDFLZDBvYXZkZmY0UnhVS08yV0VPZ3RxWWt3azZM?=
 =?utf-8?B?T0k0QWVrUlk4b2Q3RDhLNm9zMGtsdGVROW1SOCs1U25ma2lYUGV1NDFqU29q?=
 =?utf-8?B?emJqaGIrb0pjekRFQWgyME1Bc2ZKcm15aXJFbkh2YzNYaTFqY2pRbjlhM3pj?=
 =?utf-8?B?U2JMYTI0aC9lWm1qY3RHRHkzVlhoWC9vampRa05RYW9HUmtSeHZEM3RWWTJV?=
 =?utf-8?B?REF4VHFlZHR4eHVKRmVwc1U3b0t4aE9UYnZvbWtJV1pjWHMyeUdXQTdtN2lC?=
 =?utf-8?B?d0h2UHA1Q0djTmZIbmg4Qno3Y0RPOFB0UFdnZFlGUkN3RGIrUjV4b3VyQk5T?=
 =?utf-8?B?TFltcjVGSXh1N2lTTUpQVnE3djl4ZFZuUDhjYXBPbCt4d0gwQzVDRWF5TjV2?=
 =?utf-8?B?SzlIYnV4T1JJRzlQTkpOT2xMVXZBSnYybzRicFRWN1VjL25CVCtEMS8yRnRy?=
 =?utf-8?B?N2xVMnRFc0ZqZXpKVmZXZ1dBeEpnc3l3WlIzUXlKTktWQmdMcmJOUkdNVE5Y?=
 =?utf-8?B?OVZWNDNzQTJRdTFsNUsrREZUQ2hXcFQ5N2VRMHVTVEdyVFByblRmWUliUkYx?=
 =?utf-8?B?UnU4S3paVzVjSDl3UThPT3VOd0QybWR2eTVvSldYVkxsZ092Yk56ZTZBbFVW?=
 =?utf-8?B?d1NzdGdldEc3TitlNDdPa2JRWUl0dHVHNWRvQmEyVHVZT1lLV0hTb2packlO?=
 =?utf-8?B?dHU4andHYnJpL1J2alpWbVlBZ240K1hZM0o1bzEzd2RVcCtzZ0YyQUdjSEN6?=
 =?utf-8?B?QTlLTXoraUxsM09ILzZwU1JpcGZLS1A2S3o0UmtjemdlVnlqcDFaVnlsaXVl?=
 =?utf-8?B?V2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ffca303-f4d6-4e1c-fc92-08dce72b2293
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 23:52:43.0440
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2TL5KyKenai7sSPaHA3PFPc2pXFFDa8AREpOj/Awe7tTQv3lB8zhyTTH4pExAc25sSM6kwyBhuks92bHsuEL90ReUh8rHV1o23gxRm7OYFU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB8257
X-OriginatorOrg: intel.com



On 10/7/2024 2:56 AM, Vadim Fedorenko wrote:
> On 04/10/2024 23:55, Jacob Keller wrote:
>>
>>
>> On 10/3/2024 5:39 AM, Vadim Fedorenko wrote:
>>> Add software TX timestamping support. RX software timestamping is
>>> implemented in the core and there is no need to provide special flag
>>> in the driver anymore.
>>>
>>> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
>>> ---
>>>   drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c | 11 +++++++++++
>>>   drivers/net/ethernet/meta/fbnic/fbnic_txrx.c    |  3 +++
>>>   2 files changed, 14 insertions(+)
>>>
>>> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
>>> index 5d980e178941..ffc773014e0f 100644
>>> --- a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
>>> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
>>> @@ -6,6 +6,16 @@
>>>   #include "fbnic_netdev.h"
>>>   #include "fbnic_tlv.h"
>>>   
>>> +static int
>>> +fbnic_get_ts_info(struct net_device *netdev,
>>> +		  struct kernel_ethtool_ts_info *tsinfo)
>>> +{
>>> +	tsinfo->so_timestamping =
>>> +		SOF_TIMESTAMPING_TX_SOFTWARE;
>>> +
>>> +	return 0;
>>> +}
>>> +
>>
>> You could use ethtool_op_get_ts_info(), but I imagine future patches
>> will update this for hardware timestamping, so I don't think thats a big
>> deal.
>>
>> I think you *do* still want to report SOF_TIMESTAMPING_RX_SOFTWARE and
>> SOF_TIMESTAMPING_SOFTWARE to get the API correct... Perhaps that could
>> be improved in the core stack though.... Or did that already get changed
>> recently?
> 
> Yeah, as you found in the next mail, software RX timestamping was moved
> to the core recently.
> 
>> You should also set phc_index to -1 until you have a PTP clock device.
> 
> That's definitely missing, thanks! I'll add it to the next version.
> 

Since I had missed this, I reviewed the patch that changed Rx timestamp
to the core. It also initialized PHC index to -1 automatically so it
shouldn't be necessary.

Apologies for the misleading comment.

