Return-Path: <netdev+bounces-300364-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GoG/LuCxM2qjFAYAu9opvQ
	(envelope-from <netdev+bounces-300364-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 10:52:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 32FE369E9D2
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 10:52:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=FKhBTqGs;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300364-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-300364-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BACFB30DCF31
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 08:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A4C3B777F;
	Thu, 18 Jun 2026 08:51:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A073BED1E;
	Thu, 18 Jun 2026 08:51:52 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781772714; cv=fail; b=RRq1u1SxrRZcwkQRBxEHXFFEjgR7cjZooD8jKk5xXlkQrc4k79xL5BQbqnRAVtwDWKuiYeRlAQLc9l6Xw1ox8XeTWhVsychtEr0EbZQuxegADF+k3VgUSA5DQExjtNRDW0bHo/w+1uaK2K/vx9PgKvn4JDnf+l7SuTOWNd0FPHU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781772714; c=relaxed/simple;
	bh=F8jh054/yp1bx1J3sWAbb+ItdkS9mjw4OjymM3Or44g=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=K+IPrBHBgej+2SQYUFe+uyi7+TV7mAkYTVaAVDDaCq1V8tmRmeoCxbIrAMxVdWAwaqvrKwoIBdEgF41VlLrcBn78ll86XOCgpG8OmqEixfXt3iviGJx1CXfqNooeI62EX1gPPJyOLO+ewz8BENSHoXMteA2hroZ5gLRwSwx0Ttw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FKhBTqGs; arc=fail smtp.client-ip=198.175.65.11
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781772713; x=1813308713;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=F8jh054/yp1bx1J3sWAbb+ItdkS9mjw4OjymM3Or44g=;
  b=FKhBTqGsXPDaDIplsMm2AtEhpwAV3a75S+B4NuQ78UJBCo6603tEwEev
   z9UQ4mPYFaL3y64hKw9RBume4zgZ2gas7lqcu1giP1hjvFb5gwIex75Pc
   00wbQKO08f6bR9aFP56BqNQD7+NOPHwMsvf4nQpX7md+36U7F32s3URqM
   /sFriFXcyB5C6MdbkGJ7qKdfKcivqAFmwiYVyCb4E3Wl0s2m0yox5ciKp
   P9c+aC5J3lGz5Ks25SuGp6pubVUqCfpV2H/kyueUUuNreX6Ed494z8FGe
   zJAcjFRq8YhjJBFk1u/CYNJGUwXA25W2TXoOngT9+CORxPbeNpZTrrGnH
   Q==;
X-CSE-ConnectionGUID: nPJfOOflRUSPkY95FLEBeQ==
X-CSE-MsgGUID: xVenbKEjTSmN4GYQNSxuVw==
X-IronPort-AV: E=McAfee;i="6800,10657,11820"; a="92939018"
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; 
   d="scan'208";a="92939018"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2026 01:51:52 -0700
X-CSE-ConnectionGUID: BWHRsaTQSbqPB6tbSyvFAQ==
X-CSE-MsgGUID: iNo/kBAuRJ2+ztTE/qm/hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; 
   d="scan'208";a="248394997"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2026 01:51:51 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 18 Jun 2026 01:51:50 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 18 Jun 2026 01:51:50 -0700
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.22) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 18 Jun 2026 01:51:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N6+uOJsAmbSFDQVec4GYTER88SvkN9xsuXGTiu+mOf3ej90GsK83mB4WzAZu4D40dqfWimm3qgIIxLI040J7m62jL6Iq/BFYhnjoFWrbD5qQWofJU7j9TRu+31upIzjqsfgZmy4Kd/3Md6S1GhvlN5lPl4QxcgJOBLcSFeAxkg9FMlAffChgyNtg3U5Sb3bX2GUJfPK3i+OvuP20C6Oz3BzISCCmUnvRYsE5ekAUp8oeEnXH6X5vDfLlko0WLeDb0qQ3yziLdSPna7q8YdqefjOz28UfWHYpe/anGVy/M6JXTlvQ5G8jeM1mH9iplGIoE9syusj9eWdJIqhnsWst1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JaxH15IyaZGrs13Qk5i1W7m3Oy/Pe3bXT3o2EQiu0GQ=;
 b=th4w32mwl0/PnKnTqMHUy0epQZPokLF4qaE+MRAAQSicMQY1icA9ZU2BLvBOz8X7cWaZLm78ehyvDAq9VyEs3/kSq2yfr7AkHc1d1H7Ms7SwmI/y85SyMgP2S02qooKeLytR0SyfJEMmAFbQi0gG8znQZFAKAaYg1l5mCUTdTurlFKGz7Jsr8VdVohKbRiitMPo0NVumC9wyV+r4KrTZ9As4jtOZvecRPniLYU8vAgRRQutWuRQJ2Hu+lwbZyKC7PR7rcAXXS0TPloWdGxtQoddNyWyI8/RV80ngnfvJI6lvvX4mv816l9t8L1ThfRpkukJ2S0EDYjsi0pfLw0j3qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS7PR11MB9498.namprd11.prod.outlook.com (2603:10b6:8:261::10)
 by DM4PR11MB6525.namprd11.prod.outlook.com (2603:10b6:8:8c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Thu, 18 Jun
 2026 08:51:42 +0000
Received: from DS7PR11MB9498.namprd11.prod.outlook.com
 ([fe80::e3fc:2bca:409f:b925]) by DS7PR11MB9498.namprd11.prod.outlook.com
 ([fe80::e3fc:2bca:409f:b925%5]) with mapi id 15.21.0139.011; Thu, 18 Jun 2026
 08:51:42 +0000
Message-ID: <c3030882-55c8-486f-8ff3-571d001b99a1@intel.com>
Date: Thu, 18 Jun 2026 11:51:35 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH 1/2] igc: Wait for MAC passthrough after
 reset
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>, "kao, acelan"
	<acelan.kao@canonical.com>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20260618073324.1843310-1-acelan.kao@canonical.com>
 <IA3PR11MB8986B77F49DF672178FEE4BCE5E32@IA3PR11MB8986.namprd11.prod.outlook.com>
Content-Language: en-US
From: "Ruinskiy, Dima" <dima.ruinskiy@intel.com>
In-Reply-To: <IA3PR11MB8986B77F49DF672178FEE4BCE5E32@IA3PR11MB8986.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0005.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::15) To DS7PR11MB9498.namprd11.prod.outlook.com
 (2603:10b6:8:261::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB9498:EE_|DM4PR11MB6525:EE_
X-MS-Office365-Filtering-Correlation-Id: 009872b6-696f-4072-15b2-08decd16d191
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|56012099006|5023799004|4143699003|18002099003|11063799006|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: EdTOxazwidO4dxjvNaT0rK1xLCPV4ePKk3fFixGLhrujWzZo12DrDn/TZ4y+6/rWHIqK/7+CcMzWc+uUoNyd2hqh2K03Pf8IKTWLJXn+vrspfa2cgwBtFbdangzLTWoCepS+m7pIv+mHLFQto2ef0KjCEOdafXD5SjtPiOLAN1n7p+oWndrCbf6K6yEGubk71ddmKKmY6w8cBD1wmMQnISFwUfpuNWlJxkuXOdySGo+B030Z9/2U+I9cH2RQCWOo1djpsSKXfDiaiT+FP2Kqkkw3QP2seoklGehyS5BPyxZVUOqfqNjHaWBk+JDXJN6Dh7DypLb2lvh/x3HDYqq/9KX1eQm9meB4vd+NltlGNvZ7TaZKRjecIStcD9Ug4mhdZ5y057M0eTggb/WQ6ZkeOpfU2qH+NT/grka1DG56FSLNmBqab05Lcd/didyANIlDGmMSMU8RS8nwe26JdbR+KWAnqK3Paw5Tg6oJN8hDzevkx4D+da3t5QQ7IGNUDiGahcDGvU3eu7aOtgnmchgY9gH4vstX/VRccfuh5jH4SdyJAODIturC0rDA9ktQeB1pMCGZV93rWmXU1FZcHFM+6LNFxyefBkicVVBId5CIHEb2pobORfPkWqIuSeNBNVJWm63dIjEUH/JJibZOgj9aRy1gF8cHBS58t2XUwAlfvbH+xgcywYORL4l5PBM0GMiS
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB9498.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(56012099006)(5023799004)(4143699003)(18002099003)(11063799006)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dUs3ZVBDY0Rnb2FiaEZsU2FOK2x6NDJvbDBQQXU4UXQrRHY4Nk9tdkVldGxv?=
 =?utf-8?B?N3oxZFRyMDhJTi9sZERXRUdIcVQzQkZsS25CcnNTbWtMb0NaSytEUWRsNVlw?=
 =?utf-8?B?TklpNVJ1T0IzKzRRemRXTEp1amtVNDB5UWdmRlFpbUV2dVd0VjZNbE1FK0tI?=
 =?utf-8?B?TDdMVnBIRmE4OGFpd2wrbWxsbjdLd04rL3lrbGVkQXhxK1NSRUlIV1Z6cERB?=
 =?utf-8?B?WldCdmlmUUNJV1E0Ui93L1RsT0VsWHpPZUVjN3VkTjZSWVdUYUJsUzZwSmNs?=
 =?utf-8?B?Z3kycTB4RGFUWjBrWFMvQVZvSXZ6b2gxNmovdmc2dytoSWY4T0d0dUxnVjYy?=
 =?utf-8?B?N0x1VG1KOXRvM0xxVHVGMmRIT1FyQ09KUzhGS2MyczhqZEN1SzVuWmdCd0o0?=
 =?utf-8?B?R0lSVXNTd2xMUHRIaDNSbFd6NWVKUmtXRlVmYjlOQW95cFBvRld3ZFFHamg5?=
 =?utf-8?B?ako3cmk1UCtRMkdkK2MvVlQ5b3VTWXQzRGphcnl5SlJabzRzNlNzT3dlUUFz?=
 =?utf-8?B?cG1SVFdROTV5QkNUY3oyZ25sNnVlb3VMQ3dRZUI0WWNxeXBXbm4rSVZtL0RS?=
 =?utf-8?B?d0pINDBQVHYyZHBrbE1lb2NGcUtpcS9TOEpMT0IxcUtBVUV4MzJkV0o4NHNz?=
 =?utf-8?B?ZzRIZkdRamRFVXdaZVErTXZJNUdLNFFiUEtZN2t0YWdFZWF4YlU5ZE5EdHUw?=
 =?utf-8?B?TzIyMnRhK3ZlcnQ4MWZHelVwYzBPVzZ5aXRpcXpVTnh1Y0JIVXBaUGJKZjRp?=
 =?utf-8?B?NnJ3MFdWZTBINlVaUTMxR01ZZC9tdWFtUTlDMkNxSTdvalRCeW1zRDl0eUtZ?=
 =?utf-8?B?LzZJVmFRQldDRFllZlE4RG1jZkpFSlV1MFZmTXo2VnZ1TVR4N3Y4Zlk5YUd5?=
 =?utf-8?B?YVE2c2oreTR1T1pLUWh3c3l5akNBOUtEbmpFYk5obSs5N01iRG4wR0h3OVBJ?=
 =?utf-8?B?NjRrQlpPbWFuQmJBWjZDOU1jRjBxYnFMUzZwcVhDVDVQUkc4czduZjRVRXFW?=
 =?utf-8?B?Y1hWbTloTW11WVNLNzFZbDNMZGx3Q0ZVT0wrWkpUT01rTE1kY012Sm9MNEF3?=
 =?utf-8?B?R2FzL1dBbm5FaXYyWVlDc3AyNVd6VExuMkRZa05ucGVzWVNtWCswbmxISnBr?=
 =?utf-8?B?VGJweExxbDdTaEtYUGhQKzg4VURCS1IwLzBaSUc5bjhRVi9PV2VrK1FGdVdW?=
 =?utf-8?B?dmQ4WmwzVW1GcnNiY05taFRnNGRZNGNHMmE3eXFodjZHcFV3aytJMm5VQU1X?=
 =?utf-8?B?Q2FiV0pEdXo3bTlYbVdoemt3UXMzd3N6enVuaW8xemwxaUprckU4YVNUcGVI?=
 =?utf-8?B?b0R1SXhyZkYyUDN6d1kzcGxXbFBuTEVDUkFFLytDK2Y3aEtPQ3FJWlNBdVFG?=
 =?utf-8?B?YmFpSzVveUpmeGJCVktybnYveEtHUUpEd1RzaFQyWjQyTDFNZ1NmemlnMGVz?=
 =?utf-8?B?Wmw2NzlXYXZ3OWxvMEFwY05UUXg0ak9rSHFNSnp3dHBNSi8zVnZBM1JsM1hB?=
 =?utf-8?B?SzY5M2pDdC9JT3RiV09reWxIWlFGRDR1OFB3b2ord29hc2FWbS95bGRkUTgr?=
 =?utf-8?B?N3Y3Tm91VEhQYmVkcUJKN3VvTTRIQzZreE1zUkQ3ZDVFRlUwZUhUUEowUTE2?=
 =?utf-8?B?UHdab1VYWVZMbEhORHpPTXExQVdiNnRXalBjU0ZvRVJkK0NYWitHTitEMDlQ?=
 =?utf-8?B?L0diZzF6bTBITVBDbmh1blVlTG92SVRSWnpsalhjcFhHRjNVWERxRU92N00x?=
 =?utf-8?B?dWsrK1lIWjlqUnZsczNSNEFsSExTOVBta2NLU2RNUEEwLyt0Z0RtRmQ5RFI1?=
 =?utf-8?B?TUVSdVh6L2dnM01USzBYTWV4d1FocmxDa3VqbjlJL3piQ0ZERnBkcVpFcU5t?=
 =?utf-8?B?a2s0ZEZnZ21qOUFFSkJJVnNReG1GNGt5WnVETTE4UWJWcnZtbGdPcVJMN2J0?=
 =?utf-8?B?TTNBR1EzV25vN1hVTGNVK1JaaVJINzdUZkZpdUh2M3NVeWRVaFE5SW1vWU85?=
 =?utf-8?B?N0RiemZOZmNZUWcyVloyRUVIUGpmeWlWZXZDbko3VnA3TGxXOTh4YmlDR0lL?=
 =?utf-8?B?MlE1SmZUNzIxdThLSmp5dnZZL01qMGN1bGNrMFNXUWhuUUNPN29WdFBSb1JL?=
 =?utf-8?B?U2cvQVlQRnRKOGlyLzNKNUw3aC9Tc2NSSnFtNG90V1lyR0NjaER5aUkrQW50?=
 =?utf-8?B?VjEySnZ5ZW9UZnJMR0dWZUpZQkZhY011MVppVVdoMkNrVGQzSFo0ZG1lbXUx?=
 =?utf-8?B?OXBIa0ZUZ1gzVlpxSkxjY1crVGVRYmE0Wm9sVWwwSHhYMDRGZU5SM2UvSjFz?=
 =?utf-8?B?aFFFSHladzNaYTVWL0JWb3ZVMFFUbXEwWXdiTnE2dEFiYWZMcExOOEVUelBl?=
 =?utf-8?Q?pql+vqdy6MpI8UaU=3D?=
X-Exchange-RoutingPolicyChecked: DOgyb5W5jnupEF2vjaxZsT343B5rkTwCAMnCsIXrNhGuvjaVSK9k5/AAfg75gcf7sL/8l4QyKeYORK505bfuIQiakHWtvIzd6ygp3pDTsOfcqeY+MKCzK4Ca+wZNrAv0OYUmZeCgbjoHmwcoPxw2fOBy8tANNL3SNJ/2jffotjqod46Z8oVhwwG2MLdtt2g4GlOenuWPC12+/IsghnIUGDWs36M7Nnf+DR2JcBJxWO/Q4i3uIJesOLKwtVD2oVSTDsfDxpsRRNTIriKLaAdqf3elu4iC+JrnVYjfcUE7UpLQoOvdmrkq3UC2h6H/iA3L8L7tF+KKLJ34irlF7EE7Nw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 009872b6-696f-4072-15b2-08decd16d191
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB9498.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 08:51:42.4237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s8JtljaC/rQReHs+5znoKBtSsrvMx34xsVOwnKNf6MG1tmaErw1sjMBlNxOb0+Q0SyhNKG6iZvfFTb19bu45GQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6525
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER(0.00)[dima.ruinskiy@intel.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-300364-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:aleksandr.loktionov@intel.com,m:acelan.kao@canonical.com,m:anthony.l.nguyen@intel.com,m:przemyslaw.kitszel@intel.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:intel-wired-lan@lists.osuosl.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,intel.com:from_mime,vger.kernel.org:from_smtp,lunn.ch:email,canonical.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,osuosl.org:email,davemloft.net:email];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dima.ruinskiy@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 32FE369E9D2

On 18/06/2026 10:55, Loktionov, Aleksandr wrote:
> 
> 
>> -----Original Message-----
>> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
>> Of Chia-Lin Kao (AceLan) via Intel-wired-lan
>> Sent: Thursday, June 18, 2026 9:33 AM
>> To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
>> Przemyslaw <przemyslaw.kitszel@intel.com>
>> Cc: Andrew Lunn <andrew+netdev@lunn.ch>; David S. Miller
>> <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Jakub
>> Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; intel-
>> wired-lan@lists.osuosl.org; netdev@vger.kernel.org; linux-
>> kernel@vger.kernel.org
>> Subject: [Intel-wired-lan] [PATCH 1/2] igc: Wait for MAC passthrough
>> after reset
>>
>> Some systems support MAC passthrough for dock Ethernet controllers by
>> having firmware rewrite the receive address registers after the
>> controller reset completes.
>>
>> igc resets the controller before reading RAL0/RAH0, so that reset can
>> restore the controller native MAC address temporarily. If the driver
>> reads the registers immediately, it can race the firmware rewrite and
>> keep the native dock MAC instead of the host passthrough MAC.
>>
>> For LMVP devices, poll RAL0/RAH0 after reset and before reading the
>> MAC address. Stop once the address registers change to another valid
>> Ethernet address, allowing firmware a bounded window to complete the
>> passthrough update.
>>
> Good day, Chia-Lin
> 
> It'd be great if you could share more details on how to reproduce the issue.
> 
> What exact hardware setup is affected (dock model, NIC, system)?
> Which firmware/BIOS version?
> How often does the race trigger?
> Do you have a way to reliably reproduce it?
> 
> Also, what is the observed behavior vs. expected behavior? For example,
> which MAC address is seen and which one should be used?
> 
In addition to that - I would ask - when the race triggers - how much 
wait time do you need to reliably resolve it (i.e., for the FW to have 
completed the MAC update)?

Because 100 iterations of 100msec each - this translates to up-to 10 
seconds, no?
The weak spot here is what if you are on an LMvP system where MAC 
passthrough has not been enabled. You will always wait for the full 10 
seconds after every reset until you give up and just continue with the 
default MAC. Hardly desirable behavior.

We've implemented something like this in another driver at one point, 
and the default polling timeout there is 1 second (which does not affect 
the UX too much).

A better way may be using a FW interrupt to notify the driver when the 
MAC address has been updated. The usability of this approach depends on 
whether it is possible to update the MAC address up the stack after the 
device has already been initialized. Does the framework support this?

Thanks,
Dima.

> 
>> Signed-off-by: Chia-Lin Kao (AceLan) <acelan.kao@canonical.com>
>> ---
>>   drivers/net/ethernet/intel/igc/igc_main.c | 48
>> +++++++++++++++++++++++
>>   1 file changed, 48 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c
>> b/drivers/net/ethernet/intel/igc/igc_main.c
>> index 2c9e2dfd8499..fa9752ed8bc5 100644
>> --- a/drivers/net/ethernet/intel/igc/igc_main.c
>> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
>> @@ -11,6 +11,7 @@
>>   #include <net/pkt_sched.h>
>>   #include <linux/bpf_trace.h>
>>   #include <net/xdp_sock_drv.h>
>> +#include <linux/etherdevice.h>
>>   #include <linux/pci.h>
>>   #include <linux/mdio.h>
>>
>> @@ -69,6 +70,52 @@ static const struct pci_device_id igc_pci_tbl[] = {
>>
>>   MODULE_DEVICE_TABLE(pci, igc_pci_tbl);
>>
>> +static void igc_read_rar0(struct igc_hw *hw, u8 *addr, u32 *ral, u32
>> +*rah) {
>> +	*ral = rd32(IGC_RAL(0));
>> +	*rah = rd32(IGC_RAH(0));
>> +
>> +	addr[0] = *ral & 0xff;
>> +	addr[1] = (*ral >> 8) & 0xff;
>> +	addr[2] = (*ral >> 16) & 0xff;
>> +	addr[3] = (*ral >> 24) & 0xff;
>> +	addr[4] = *rah & 0xff;
>> +	addr[5] = (*rah >> 8) & 0xff;
>> +}
>> +
>> +static bool igc_is_lmvp_device(struct pci_dev *pdev) {
>> +	switch (pdev->device) {
>> +	case IGC_DEV_ID_I225_LMVP:
>> +	case IGC_DEV_ID_I226_LMVP:
>> +		return true;
>> +	default:
>> +		return false;
>> +	}
>> +}
>> +
>> +static void igc_wait_for_lmvp_mac_passthrough(struct pci_dev *pdev,
>> +					      struct igc_hw *hw)
>> +{
>> +	u8 addr[ETH_ALEN] __aligned(2);
>> +	u32 orig_ral, orig_rah;
>> +	u32 ral, rah;
>> +	int i;
>> +
>> +	if (!igc_is_lmvp_device(pdev))
>> +		return;
>> +
>> +	igc_read_rar0(hw, addr, &orig_ral, &orig_rah);
>> +
>> +	for (i = 0; i < 100; i++) {
>> +		msleep(100);
>> +		igc_read_rar0(hw, addr, &ral, &rah);
>> +		if ((ral != orig_ral || rah != orig_rah) &&
>> +		    is_valid_ether_addr(addr))
>> +			return;
>> +	}
>> +}
>> +
>>   enum latency_range {
>>   	lowest_latency = 0,
>>   	low_latency = 1,
>> @@ -7259,6 +7306,7 @@ static int igc_probe(struct pci_dev *pdev,
>>   	 * known good starting state
>>   	 */
>>   	hw->mac.ops.reset_hw(hw);
>> +	igc_wait_for_lmvp_mac_passthrough(pdev, hw);
>>
>>   	if (igc_get_flash_presence_i225(hw)) {
>>   		if (hw->nvm.ops.validate(hw) < 0) {
>> --
>> 2.53.0
> 


