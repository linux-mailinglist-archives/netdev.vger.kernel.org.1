Return-Path: <netdev+bounces-292737-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MP4OJ3hZGGq9jQgAu9opvQ
	(envelope-from <netdev+bounces-292737-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 17:04:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F03565F41AB
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 17:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E0DF030416AE
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 14:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 013732E7392;
	Thu, 28 May 2026 14:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lIab3aah"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4454EA38E
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 14:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779980167; cv=fail; b=GkbpuCJs/jOvhgx7mU01aUFJlP/4qHUaj25s38oX8JfZu0fLWIBGZ7SLR+VzwOULbG9U2jAZtIhRIgE0AtVEhGNPiJicjrwAlW47WXhL3HoUj44PMIOZ7bQTbX1HJZJBLdKSfJ+es8bR+Rp8NYUDIrK951f6nq75FsGCia7dZ8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779980167; c=relaxed/simple;
	bh=S7zkdM6BZYP2LK0yu3xzfyJDrn1R2aiM4iF64UDDU7A=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NColPt1ypSssw+IIvrODIu7TkbEzrk/Ot0WbcLeeJ4HZzKj1dt2FUkKqXvxPvid95GjCXpGSPslJVbxjAg58eXHHJpMtOzjK7YsRwQzmaEGAK/QIVwy8uCbAO89ekfY4eEw0rGzMeApIiMKsiwQPGQBaGc5BGazIBWpvDFCoqlE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lIab3aah; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779980166; x=1811516166;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=S7zkdM6BZYP2LK0yu3xzfyJDrn1R2aiM4iF64UDDU7A=;
  b=lIab3aaho/V9Clo/yfoCdxgPub2IQfnpo7iAzA73Ry4nbuzobpNNWwu+
   1MlxWtBtpkACuI5jxJu1vjawAIzJn7q1Gd8UVSBv+dfyW44MDU1ybiQ6f
   AI7qKhjphZAGIX3hunX4u4Qn1uiJZRW8DlMUH8QSImGPwqazIn885oQA+
   DAFswd2v46BRnADUhWcWFbdooGxx5+OkFOgQBI60Pb5jbcvDAfZR5JoRK
   G0i9RcqozQtJWD7gWoBWsIL6aLvh4AKjCHQDF5l91i2X+i+08QkVX+uno
   /DMYPg0pMGEBVA3DNpPyh+M7xqtnHqCrLb88xFo9byF4iWMUBuqehLylC
   Q==;
X-CSE-ConnectionGUID: 09PYRPTQR2iL4JJTZDVMvg==
X-CSE-MsgGUID: RyxlOM5NQXaro4EpKQLxNQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11800"; a="79972175"
X-IronPort-AV: E=Sophos;i="6.24,173,1774335600"; 
   d="scan'208";a="79972175"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 07:56:05 -0700
X-CSE-ConnectionGUID: JRG3qN2EQJKEfgkMaD2dhA==
X-CSE-MsgGUID: fytPuz3eRLS14F6HxauZ6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,173,1774335600"; 
   d="scan'208";a="241530551"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 07:56:05 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 28 May 2026 07:56:04 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 28 May 2026 07:56:04 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.30) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 28 May 2026 07:56:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nj6Mlg9agCKJ+ielsBsu9cBk8SyL/eYYHnd+smH4hztU2H6MFcYr/NgTNKuj1q1aSHEy20xeoNN7+SdHPhQxnA3uMBTbTeHQwKuRShktSMuxhelCIK5mg/vAACec68n5Sk1Kl6/9yLIFwd9ogVPeaDF8p4idsnvTPMsZVDIahukU1LU2Vq7PM3NKwSTQUVbdN7kT4d1MmOjsNzcKaRReBjt4EO50THeMF+EVBu2R3fkUjBUHlsyZxH7NLz6Dqvg/lzcLyJSX/VkllXUD6AdGyxkhGxH9aLpyhwjFvQepvqXLg5Sv21k7p0ycux9inBaV0GyMWaymMi+W/OdXl91kNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X8Hw6xWZuOjhAcG2v3uOqgzDBU5iOMEYO8dkqKyZNI8=;
 b=VLyExjd6E77ZtRbAngP5wwDkHNcL4EUf2EztbplcNjFCKMlUDW9bL/y05V/7HJGrhxQlmKmfc0Gh6qSp3AubiyAzKsinxUMS2NUd7c0xEn4AAvS0A5WekjRDtwbfqriehGCWOKW38/aUwPkU5VRnfJXFmPqBNof8J7u11wxW8fVKYyycGZ53WI+w+IAeklSXs242h2naVmxXeZX9CFGBZozLpOFYTDWOROzh0fZLEan+NlK8CbXeOfwIWOwB5y4m29GNaYX60ksXe/szFEY6I0U+fNWs8jbIO7Wa6LksEl+rnqXJz2sGqTSAsJrIYb7HhzZZPraXDvoFl2pi3MjBbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by IA0PR11MB7741.namprd11.prod.outlook.com (2603:10b6:208:400::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Thu, 28 May
 2026 14:56:00 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::6aa:411d:4bfa:619c%5]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 14:56:00 +0000
Message-ID: <60438b0d-e664-4c86-b4f6-27343fe2fc7a@intel.com>
Date: Thu, 28 May 2026 16:55:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] pcnet32: stop holding device spin lock during
 napi_complete_done
To: Oscar Maes <oscmaes92@gmail.com>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew@lunn.ch>
References: <20260528140320.5556-1-oscmaes92@gmail.com>
Content-Language: en-US
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20260528140320.5556-1-oscmaes92@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB8P191CA0006.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:130::16) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|IA0PR11MB7741:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e147f85-9ba9-4e55-20ae-08debcc93b3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: nwpVvHzuugvUd1ZWniEJXLOiOqE8IFdGBtV3Rwve8Pq45vMaY7hdoDbs+BWtqG8SQC62r6c7uybm2OaQK7T9KalRTTawADHEz1UGaSMwrzzkHE+eyTcQo7LbDVMg0myI7bwNhSsHFOYPxvfX/Kt2ByKR4BlXRO1hzSudVDAKvjT8Uvq/acFHTXdQeNoUHf2eyrfYImJsXUpxyqp8Q4yG8++o1+WXrSDN9M+dzN1U+WsAIvapBErdBh33zGRadGuy7WjnhHi5tBSBi2OX0SzA0HeasciKKN+QBNLF2C6bWtswv8gOcXricobCd4mW7z7nOV/uv0YQu/4dEdNzpGxLmasU5plbMenheJnk+kh2HvRbfZfMFBaJjRfg2fqaJKlVnheIJbQnegdalkaHv9KYds9H6sqNmZEjJQaTQYHOaEe3O1hc+DESAr365FFDIS3NyAcJ83OOJqDXC+vVpHHJNY5tK12OziUdh7ignOP1hDAcugb7OL/XlYD0rYXtAHoUId7yHzkK1FdnGZjdzrPMtvslentRm1cnAZF+JIjgtWIOxIxn5mL6IQm+hiU9z1CeGT5TbV739kgQ8LHswPaeiKHUWH14zOXrdJ7PWMUcgG7hECbACMGNJLz35ZLVgXFg03sWhytB4p0EjdY72UtYzA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aFdJRUNlRHFzTi91ZnZ0akNDY2lOUk1rV09ZeDd6dWUxS0N3ampYMi9DbVAv?=
 =?utf-8?B?RkZxTE81b2xHWGN5TFE0UmhLSm8yMzhBb1RTZHdtb0xVa3lTd1l0bVEwajBI?=
 =?utf-8?B?WnNSMHlXZ2hVaDdpQlRQVzNtenFraU4rbG0yeHI0am1BSWlBaWhZZWFRZ2V2?=
 =?utf-8?B?QURlSThoMFdXL3BuSWNtYUlPMy9OYWhVenZZS2dJeEdxaDBMTWNKQVRnK05K?=
 =?utf-8?B?NUtVOXU1WFpZRGh2eWhwbjBjV2NFUVJ2Tk1sb09lQnlvamYvcEg5aWEvWnpp?=
 =?utf-8?B?c1drMjZ3aXpERlFuVyttOUJlZE0rRFMwcjhRSGpCUUR1UGcxVVNhRzVSMUJo?=
 =?utf-8?B?MzlWa0puVlRnWnpJc1AxdVZSYnlEcGNnWVJzUEtDQXFmRUdSRnRhY2xoMkQz?=
 =?utf-8?B?WW1Jb05jOEpEeEdoR01vcFVtZm1uQldWL0Fac3g0SG9pdGFZczVPamVERmFL?=
 =?utf-8?B?SUFDTnpaUllHWEZBeTVMdU83WllDWnVtTVBRQk1oclpWbFBoMjFNYjQ4ZFV1?=
 =?utf-8?B?ZTVrM25OUzdZYmdhQk9SVFdyVTZNQ05naHpRQW4zanhaT2l6VTNwSEg0U1dk?=
 =?utf-8?B?WFZFRzFlRUpWaDNVQytDaEQ5cjF2Q1lyVHd3SEplUklETVVzQkMvcVlYM3B0?=
 =?utf-8?B?bDQvRDI2NTk2MFZjYzZoMWtSekVmSG1hbm5oRkJNaGhzM2kxQVpSKzhJV3J0?=
 =?utf-8?B?a1p4UTVIWFRwWTJMWFJrSWdwOEJjalltNDlzM21XczhwV21ZU0tjbXdzMHc1?=
 =?utf-8?B?M2R6WUZiZXlDaUQ2Z1BkQ3BGU2tnZWJxOHZXNGprZ245cjZVVURpR1pvanYy?=
 =?utf-8?B?ZXNLK3R2a01tTkU5b0FwKzhrMEVqRnNNNXlOY2ZlODZnZ3hBN2pUYUZlZkN6?=
 =?utf-8?B?bGZ1RXoxd2xxZ1p6MlowNUh6RktXV0lHdm9oTktkeGozZWFFdndINFBoYzNB?=
 =?utf-8?B?OWRNWlNvSEZkQTBSUmRYK2JlbHY2bUw1UUJIcThHbk4yVU5SRzBIQ2F5b0hE?=
 =?utf-8?B?U1Rway9IV0RiMUxXZmRrNE1iMGJEeEE2eTQwbGV2UTR2a25najBFZFhwVmJU?=
 =?utf-8?B?MHgyNjA1SDRWUHR1T1NWU3NMeU5UUU1NWnNZNWVGcm9ITlpzMTlyaitlWTNy?=
 =?utf-8?B?OXI0Z1BYa0hPNGNrbjdVTFBYUFRnQW1VaFJJNmdkalRsdVhIN0dUaGNTU2Rj?=
 =?utf-8?B?UjliRFFKdjkrRjRhQklNQXAzV0JoWmNSTEtjb1BkbjlacmwycCtQSUxSQUk0?=
 =?utf-8?B?VHhCYjN2QmliQmhocEx1bkFsTXlpV0N6RG51ak9vM1ZwT1FrUmF2T1B4VTNO?=
 =?utf-8?B?bU5lTWgzRjlMWkd0Y1NTUllMUXlZNzNPSHBseFl0aVRnL0ltSzR1OGo4VU1r?=
 =?utf-8?B?eGNjTlRnNmNJU3dRN2w3OHpYVjhIaUxHRUJDUVVRYk9wd1pmdHFwOXZZVnNY?=
 =?utf-8?B?c3FTRkYwK2Yvc1JGWng3bHhVM2lYaU1CWWxVUFlka2NNeVZSY2NEaXhIUjRG?=
 =?utf-8?B?QXZnTkMwMEprcWNRL2Mya3pBU0luNVRiOXFIdHY5TTJUdVpyNnh3SVpNOGlR?=
 =?utf-8?B?MWpseGRrU3d0QkgreGpEd2Q1SzNrVHJCdkZ0QXBzS0VoNExPL1JLNmYycmRT?=
 =?utf-8?B?MExpNlNHT2VIRUNwS0dKSk5GM2hmMTZWNnhtUEpGVTkzdXRTaEF0dk5NVGdS?=
 =?utf-8?B?ZEZ5L3NUWVBCUnozaGdFdjVrSGl2RXRyOTJpVmZHeG9BUjdjZklBZE5NTUhD?=
 =?utf-8?B?b01SK0pzb1Z1Mml4cXh1S0pqTU5HWWFsc2ErZjRjTjdMbGFRMGc5N3FWUE1H?=
 =?utf-8?B?STRtei9MT25Nbk8xOFhaQXdETXhCcWVreE8ybWlFMVpGSEp3Q3kwYU1rNTYy?=
 =?utf-8?B?d1E3VzN3MlI2UTUrRkZkZVNWTEk1MXNwcXE1b3A3N2IwcUJwcFZBUlpyTHVx?=
 =?utf-8?B?Nmt4Q3lMcis5MWVHUGtTV3hRVW4vc01SMitLUjlRQnZlYndVdG1mMFVoeDA1?=
 =?utf-8?B?RTJ6M3RTYms4eHZwNFQzV0M5YStkRGNvbFhrTVNJaU9sNVl2N1luTnZPMzZi?=
 =?utf-8?B?end2UXZ6SXhyRmZrbnJCZTlWWlU4NkFwemN1MWV1b1JBSGxxeFpMMWlPdVdX?=
 =?utf-8?B?ZnNMcVN1QVB2N2FHZjJkMDhLZzZKeTJpbndKSDltOUs5K3BYL0dDRlo2QzBa?=
 =?utf-8?B?UFA2U0M5a0N3ajloRHNRZHF1K3dpR05CZ05zRVk5bFQ2NjFETzdDenBtSEdC?=
 =?utf-8?B?SHAvWW1iNFJrY1BCMkpxc1F0eDJGaHpkeWpBZ3N3T2lyaVNjOHQrdXQ2R0JB?=
 =?utf-8?B?bXFNQ1NYbi9UQUNCUERmNXlpNFlJcmpreGZDb2tZVGg0QUljTnFUM2NBTm8y?=
 =?utf-8?Q?VTAsOqt/uYNTaOAM=3D?=
X-Exchange-RoutingPolicyChecked: nf9f9WslSVYhJu6YBcLHqsYIPMLP2sluW73zmMvprhQcGg98aIa4YEhu0q2SZ8nYYADKHsbrF/zoSwebiTLnFHGKa5y5GCWLDpW8B/3zEbE5r73CkWeINAYqtf/btWXE9ibJmUaHx2qQdQx1m6t1yuT7lUO5PV8Yoj1OjXfZwVxsFwfQsuAWKZXBZ3WseAlkP+Opu5GQUKCsqh3QEqS6r+cIqd5eQHZ0MWTy9sGcLvVEwzUjTTM/hg5ZrGrW/GKfMneiz6C7AsRNrcADXMqH+1FSvIA9YHYvMIWD9wm0w+BHz2CwXVzjER1W69NOPDhgcuXhZEAxcP7ofM4gMpyKeQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e147f85-9ba9-4e55-20ae-08debcc93b3c
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 14:56:00.4350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NqM8qwaWvY86KQ5V2Lk2zLaL0xMQcR6OD1DpSFpOWmUf48eN08ruMgH10bWiIpylIigWYD4RhrGom7lKxTHpQ2wfqfW8fQ+a+BckG6RNN40=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7741
X-OriginatorOrg: intel.com
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-292737-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:mid,intel.com:dkim,lunn.ch:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[aleksander.lobakin@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Queue-Id: F03565F41AB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Oscar Maes <oscmaes92@gmail.com>
Date: Thu, 28 May 2026 16:03:20 +0200

> napi_complete_done may call gro_flush_normal (though not currently, as GRO
> is unsupported at the moment), which may result in packet TX. This will
> eventually result in calling pcnet32_start_xmit - resulting in a deadlock
> while trying to re-acquire the already locked spin lock.
> 
> It is safe to split the spinlock block into two, because the hardware
> registers are still protected from concurrent access, and the two blocks
> perform unrelated operations that don't need to happen atomically.
> 
> Fixes: 5b2ec6f2be51 ("pcnet32: use napi_complete_done()")
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Oscar Maes <oscmaes92@gmail.com>
> ---
> NOTE: This patch was a part of the following net-next series:
> https://lore.kernel.org/netdev/20260525125437.4061-2-oscmaes92@gmail.com/
> 
>  drivers/net/ethernet/amd/pcnet32.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/amd/pcnet32.c b/drivers/net/ethernet/amd/pcnet32.c
> index 911808ab13a7..4f3076d4ea34 100644
> --- a/drivers/net/ethernet/amd/pcnet32.c
> +++ b/drivers/net/ethernet/amd/pcnet32.c
> @@ -1407,8 +1407,10 @@ static int pcnet32_poll(struct napi_struct *napi, int budget)
>  		pcnet32_restart(dev, CSR0_START);
>  		netif_wake_queue(dev);
>  	}
> +	spin_unlock_irqrestore(&lp->lock, flags);
>  
>  	if (work_done < budget && napi_complete_done(napi, work_done)) {
> +		spin_lock_irqsave(&lp->lock, flags);
>  		/* clear interrupt masks */
>  		val = lp->a->read_csr(ioaddr, CSR3);
>  		val &= 0x00ff;
> @@ -1416,9 +1418,9 @@ static int pcnet32_poll(struct napi_struct *napi, int budget)
>  
>  		/* Set interrupt enable. */
>  		lp->a->write_csr(ioaddr, CSR0, CSR0_INTEN);
> +		spin_unlock_irqrestore(&lp->lock, flags);
>  	}
>  
> -	spin_unlock_irqrestore(&lp->lock, flags);
>  	return work_done;

While this fix is valid, I'm wondering whether this needs a deeper
rework as it's generally a very bad idea to have IRQs disabled when
NAPI-polling (except for every short sections).

Could these irqoff sections get narrowed down to reading/writing
interrupt registers only?

Thanks,
Olek

