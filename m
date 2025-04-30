Return-Path: <netdev+bounces-187163-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD00AA565C
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 23:03:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C180418919CB
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 21:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BC5B2C0335;
	Wed, 30 Apr 2025 20:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ht+7Dz2e"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668EE2C0336;
	Wed, 30 Apr 2025 20:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746046657; cv=fail; b=D2imSuDXcRZfKG89rd3nv9Lw9JqD+vp5iCY34/pltuJf7SntVxnfkqCgz0Wc64CTsZNFbJ2/dYzSuU4mC1LU3/JYC6T413dphV2jWjceyOHc250r6txlQfJq/7Viyg2VoLV8WwVfDFXS/Rj24skOMh9gvune1pK7xsEFBt/Ugc8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746046657; c=relaxed/simple;
	bh=m417F1dt/LYuGAmmGbgcXkfyfq1tbSH89TRmd+zX/5U=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=t5hx2ZxfiC3NwIqITU3nVna6xVFZoV+xNxWYvByEnhI4/mhOJIYcHoIPjXI6eMN0IkYuQgIUEDcZCSHil/qoBo18BxfHMN7BOh2Dazqo+poxpKggoEA5akiN8CDqMbSTbACG1jcl5wwG2GhYW7yj9ECQrjbw3Olw/cRCOozPMjQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ht+7Dz2e; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746046656; x=1777582656;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=m417F1dt/LYuGAmmGbgcXkfyfq1tbSH89TRmd+zX/5U=;
  b=ht+7Dz2eG5va9wuoOLzQsuLi2R65tiLk/go3B9ERBsO2Wt3+O2PM/jQU
   5QddvtFUwMqyawo4uegp5l0dA86ZCesRYjuYoEdUHSJzMDdeVN8GjbCpG
   Z4H6ndFRykTeOYF+y3e9PS5mB2o1qIrogf1ejcj4eIjjPIuFldYOJGo9J
   mThthQ7/AFZ3HDVzUV3CPITEp1xMJ1LQMMYRMGoFWZnsWiZxgeVgXLw9r
   0PEwPjWxBQG1p+OqVAFif0VJRrMgllJWV5rpX0DVLCgARy8Uvjy76aQ5q
   Ht4aKaQ0aEGiwJTLFKraDS56EM9U/oFSkxe6Yq9d5D61SxX42s3kTfgY/
   w==;
X-CSE-ConnectionGUID: ji0Ux/oCRh2pvHBJFnxPgA==
X-CSE-MsgGUID: revaAS3pQ6qNW3y1slPyzA==
X-IronPort-AV: E=McAfee;i="6700,10204,11419"; a="51389212"
X-IronPort-AV: E=Sophos;i="6.15,252,1739865600"; 
   d="scan'208";a="51389212"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 13:57:35 -0700
X-CSE-ConnectionGUID: UuBq6K7yTcuN6OcZtc5U+w==
X-CSE-MsgGUID: KmivOvEbTBiEzSZDOwFC/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,252,1739865600"; 
   d="scan'208";a="138249657"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 13:57:34 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 30 Apr 2025 13:57:33 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 30 Apr 2025 13:57:33 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 30 Apr 2025 13:57:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iM5QBdj3mUkOI4dThEp9ciZ432uRq2thQcgs8krsNHhgZbeOidyZeu0zu2mMHbsvslThiEBKaxs6d1cltRA9ULaB/cCbSybRoHm5zIpI+fLxY03dhp8H0B4azVQ0XhrayDDtGye5KwSE/BWGu4gYvqGsqvehXbpzB4bM4gWHC52djG0nfyo98nZugMZXvG3sQWIw0uyygWo45Gy9bgFz4Abk9QxFhnQySUZm9u1LgP5m+CVt6TrHW1+cB/pjf2GXf7wJSBpgsJSTE4rLz5a8txfCTSFlPN63xTJyQB+oCl6LlgcaS7Tm8XTLL2KXkp/Ov7mdtsJK5DQO/zWTjr0zsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nkSokS5Z1OHPcHPVMQdgooWZv3OvCUuNkyppIqNMe+g=;
 b=vPAuhZxBdIW6FIMtKYtRFRmmV6D5WRUDuEvnT10G898Gnf205wt6uS5AIYU2zXipcAXNIr1WYNAKjjO9DbAsJeUih0J5PUf7QqP1BbaqKPcSKrWtJhECML7NIm8SrC3x7+8h1NoqR4VcNe5MMamL2aLc3OlRee5uVxkzYl1IYjNV+OKbn2BeqhBEHIZdG/VMme8gv4QAUXnCFINNBtJ47o8nsBj3Sn5kkpf62zsHFl9nhtBIsEHHAqcpUsTZyi8v20Ivp1NvvO3/avVTltuP2/aFokYc2ksdreNYwFstWKuW4NCQFb950uLYMWmz2qzJczYlHXlY44I/tuydDmysrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SJ0PR11MB5200.namprd11.prod.outlook.com (2603:10b6:a03:2df::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Wed, 30 Apr
 2025 20:56:58 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.8699.019; Wed, 30 Apr 2025
 20:56:58 +0000
Message-ID: <201a41c5-da0d-43eb-87c0-023ebf34e309@intel.com>
Date: Wed, 30 Apr 2025 13:56:56 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] net: use sock_gen_put() when sk_state is TCP_TIME_WAIT
To: Shiming Cheng <shiming.cheng@mediatek.com>, <edumazet@google.com>,
	<davem@davemloft.net>, <dsahern@kernel.org>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <matthias.bgg@gmail.com>,
	<angelogioacchino.delregno@collabora.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mediatek@lists.infradead.org>
CC: <lena.wang@mediatek.com>, Jibin Zhang <jibin.zhang@mediatek.com>
References: <20250429020412.14163-1-shiming.cheng@mediatek.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250429020412.14163-1-shiming.cheng@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR06CA0015.namprd06.prod.outlook.com
 (2603:10b6:303:2a::20) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SJ0PR11MB5200:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f3131b9-b9d9-4ebd-0371-08dd88298be9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?cjB4dkM3QTJnRVErRDFPZUU1S2NqbnRzMGlzYjJxVGErakRoYnVzYVNCVm8z?=
 =?utf-8?B?UnRFSWZuTjNCQ1BFTVNzS2xQQTNVaEhFRmVWRnZuTVAweFkxU2pKd1kvZWRw?=
 =?utf-8?B?bXE4TS9oaCtpS1BxRlVKb3lwaEF5cHZtdFNROWd5a3N1TXdqdlZPODJSbWN3?=
 =?utf-8?B?YXBMN2VaRy9zV005aTBkTVlDUnJOVU1LYU5sRlM5cHFSWkNGN3o4ZE1pUHk1?=
 =?utf-8?B?ZEEwSWwwUSsydStuU0xkQVhhRmV6ekhpRWUxdU9oOVl6ekx2RnpWQUlIc2s1?=
 =?utf-8?B?NFpzSURQS1JROXFPNjVtc000QjBFT21oZC9OVWVwK3dkbnZHWE5MOFBqemdM?=
 =?utf-8?B?Y3ROTk5CT0FUa3A2cFBpeVhmZmpGMzNmR1dMZ0ROR3JSczJ2cFVxU1NHNGZ5?=
 =?utf-8?B?TUlIZm10aEJlQjYxUHJqOTlodjJ4SEtsYlFuY1VHbGdib1B3QW5ybEpFNXAy?=
 =?utf-8?B?SDExaHppb2V4TXpoYTdzUWhlNWwrTEk5WkVYemF1V2ttay84cG9PZkJtdDdl?=
 =?utf-8?B?VFBSdG95K1loTGZzTkNPSU5ibDc0T1pFSVVMR21ZOGVOem1ud3dzaExhaUxN?=
 =?utf-8?B?bGNkNXBuQWxyNXhPOGxFeWZlRnUxSFNxWjZGLzJHQ1N0K1B5bENhSlhlWDJj?=
 =?utf-8?B?dnNWeWVXMG1JYkk0Vkt4cEpZMkdIOXJCWTZRdnNLUVJKMFR4LzdLSnQ1Wklj?=
 =?utf-8?B?ZEdjVTZFN3E1OXpqYkVoK1NCOHc0QnZkM3dYejZkUTVWRTV6RnAzVFFiRjh2?=
 =?utf-8?B?MmY0UElGb2x4Zkx3bWFwODFrcE9VVXUyem5sbEpwSUFSWndiei9kenhobG9y?=
 =?utf-8?B?S0h6QkR1a0tVb0ZKMm1yZ1FTMVZXbGlYSERYbC9UOFJoL29xV1QxeGx4cXVn?=
 =?utf-8?B?QS9NMUVudHB0K2R2dU5WK0FmUWRtWHdmN21TNDIvZVZvV1k4OHYxYmsyVmR4?=
 =?utf-8?B?UC9XQ09qMU1sVTA4T25qVWQrcnRxc08yQWhSR1JnN0hxOXRxai9McDlzRG9V?=
 =?utf-8?B?UUkvK2JoYXFWMUgyZlVaY3BWVkRDdHBRTFgwYzRNK0UreW0rbEFUQkY3NW9Z?=
 =?utf-8?B?OUE1VlBOSnBUd2hGSjhpR2Z1K1NpSVR5SHV6cUR2NXBpMi9JVGhSZ1J6YXFh?=
 =?utf-8?B?MEdiU0xWZjNBOHJxNUdBZVJLREJTcGNLYnk2THZQcDhacGhWaVR4cXdWYy81?=
 =?utf-8?B?UW9qMVVoN3dvR050dW1vRlkyRjdnbmptUFlodVc0VndsTWp1dUtKS3J6aEFP?=
 =?utf-8?B?YWh3UmhybCtIS0Z4NWJsUzZYRE1CZkZidmVNbXRSaVhNUnNyVytZRnBtRk1G?=
 =?utf-8?B?QmV2ZjEvY2wxN1hpNEFtc0prTzdFZHFxblBRUExmTFJRRXZWZjhEc3NGTmpv?=
 =?utf-8?B?U1loRkRwMFBlZk5nM002bktUdTJ1dXdxVS80SWpMenhlUktDZHI4dmtmWDRT?=
 =?utf-8?B?VlVucXcwWldSUmE2dll1S1VDOWoxTUYxRVlIYVZ3akgwTUJVYkQ0YU55VU5t?=
 =?utf-8?B?ZTdXWERFQ0V1VzNRYkw0bmprbWYybENEWFpPYWY0aVU4QnV0MXJQYTc2ZTFi?=
 =?utf-8?B?c0dmN1h4ZDBMTHgrRzRLUnMyc1NsQk5zVnprVE5vazZpazRwNnd6OWcwbHBC?=
 =?utf-8?B?V09iSXJlemJTK0o3UXliMkIyZDUrRWNKZGJrSzJtUHhGcmFNZHhMNmo5TWM3?=
 =?utf-8?B?L2p2T3dPODJIeHBZRmxDWXdMcENjb3pMYlRlT2hZY3NkUDBaaHBxSm9TVmlV?=
 =?utf-8?B?ZWhxY3BhbVVpeUFuS3hTSG1jcjhXczdZYU5KYkJsQ0pqVGE5eTBOLzNHTTJD?=
 =?utf-8?B?QVlQN2dlTnN1ZU04VjYwL2s4NnU0MUFaYTUrWGVrVG5BYnN2SS9DZExVaWJ5?=
 =?utf-8?B?ZUtPRGRFQmJaU3Z1dXdVTW1GTllFSUU4SE5QalRKbXpEb2pPTjdTYktyK2Ra?=
 =?utf-8?B?MUhUZVlHVDdkOGZFNXVNQ256MUd3Z1gvMUNsaDl1NThRbHY1djBEUEhWSldv?=
 =?utf-8?B?WXhPclpCeWF3PT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YU5OZWU2cDdvZUVybUlOYWFOTFJUaWRUNE9PQTVmM0hTNTh0L3c0R3pUdjlp?=
 =?utf-8?B?MzdvU0ttQmZhNXZ2aDdDTlZOYkVvMWZmWkhUeGdKYWRuYjM4clluODV4d05M?=
 =?utf-8?B?c2ZGTEU5V0ZvV3NSVWtUbFcwMS90QksxaDAwWW5GQjlpYnpoV3NtTjhnUUtY?=
 =?utf-8?B?MWx2TDlvYndLZHR4dFJQL2V4WFVKMVVGT1crRWxiT0huYzFNenZGaDBYL21a?=
 =?utf-8?B?djZMUytKYTB3eWFBSGdRZWh6bU1tcHRwZmF4WWx6ZFo0enIyTmdTbHkzaUhq?=
 =?utf-8?B?TzNxK2FWU2N3TVlkRmFTSlNRaTBUQkJSOW9UR3p5ejZHZjJIZHI5TEIzQWFi?=
 =?utf-8?B?Z3haUDZOdGVGOGZ5VmhZN2pwQkNzTjduVFJMWnhRMHVGTk9IVkdLaVRoN0Vx?=
 =?utf-8?B?N1F0c05XOStacUhVY213a1ZzK3lRK00yV2ZZOWxabHdwSU1UeVhQVHF3YTJY?=
 =?utf-8?B?bGVoV1ZYekQ3bG5CcTErQmdsanFUY2lJdnJ3c2dMakRrUStpWlRaY1lhajlC?=
 =?utf-8?B?Q29zaVpwS2owQmsrdFZpVDdEcFhUU3NyNjBKeE1peE1tZEI3d21ubXNraDVN?=
 =?utf-8?B?WDZGSnp6R3VrSkVxNkx1VmJkUTAxbVNwdXA0SUtDeE5vT0pqQW5wcHFuNzZX?=
 =?utf-8?B?a0hLalo2SHYvelZuVXNmUHpKWHV2Z2p4TU5KMjc2eWdLL3BDVXVBcVhnbHB0?=
 =?utf-8?B?aWNRWjdzd3pYRDV6MzFGVlZraGxZYmtqUk1uMFNNaXhqMmpkaHplVkFKSzhI?=
 =?utf-8?B?WGtnaGJhY0Y1YnFpQTJYRzBETkpSUnVnalhZUDNkN3dQekloRGxOMWFpK3Bq?=
 =?utf-8?B?enhpMDNxaXVYMFZheHRzUzhYK3lObW1ZbUZIRTJFaW5sV3ppZmVqdU5ZK0Uz?=
 =?utf-8?B?aVRrbG5TNEVqdWNaTkZCbnJLUmIxd1J6aDluUS9hS2RndGd5OUEwMUgxdHhP?=
 =?utf-8?B?QVNVUVdXRzUwdloxd1ZlVnE3cXdHVzB3cW9QQzA2bnZGL2k3L2dQNlNWVm9E?=
 =?utf-8?B?dm81Q3JsdzBBZ1pKb1NTN0ZuV015ZFFjMlo5UzhDUWJyenVmNzFzNWloL1ly?=
 =?utf-8?B?ZjQwSzRPa0JrM0RQV2VRNmZlbDA5YnZQTHB0d2pSTjRNcGhIZm1ZSDRvTER1?=
 =?utf-8?B?TU9GUDNSTUZzUW1odmJZQTlVZzNOdVVRbHBaazVheGFqcDlxYUthOFVOck1v?=
 =?utf-8?B?dDJqSVVLNlhuVFN1Y2RtS2hPd1Rvd0YyOXlHMDVHM3hvSEF3SnF0S1Qyd2NO?=
 =?utf-8?B?T1BtYW50UmpNaDQ0dWpNZzdwVmVoVGwzZnVFQWZDM255NDBScUUzS1Z3QXkw?=
 =?utf-8?B?RUdRQzFhOHZySE9VR2hFWjNQN1RKcU5Ia21kM3FNRWZxMC9MNkhtb2laNFRO?=
 =?utf-8?B?bVRRQzhQY3l2THVTMm1yS253cEoySjJxN2p3WWlMVzJ1K0Q0d041SXNJekpU?=
 =?utf-8?B?QzBoLzZMYW1WeTR2c1VZMVIyVFRVUjgvRmRPUGxTeDR6TVZmakxaR3d1QVRB?=
 =?utf-8?B?ZWtqU0hyQ2l3VHVTa0lza2NKTHhKRFZtR29idC96QVFCVzhGTGNVM2hqUGpL?=
 =?utf-8?B?UVZiczFsQzN3R2l2dDJoUnFnekZUWXdzRG92M2xXMTlsVjBQeVF0Wm53ZEdG?=
 =?utf-8?B?c3A1d2V6eWt5TDVlakZVREdTTjhnaVpCODQ3V2hLZzRrNStESmJvNEJiR2tk?=
 =?utf-8?B?V3h3ZHY2N2F1dysrWEhYajlzc29sZjBOTE1PV2xPS2ZTQ216TTNRMnh3dVFV?=
 =?utf-8?B?bUt2UlB4enJuRW9WNkk4ZnFmdXIrSWdyTTQwZUU1NEtwYmhWeVFYS0FhV3dC?=
 =?utf-8?B?NjN6RGpCckp5NGlrcVBhUFdNSnF1eTV4eWRTWW1BVU16SWdCNk8wSVZZbDc3?=
 =?utf-8?B?UnR2M01vdnJlS2d0RTBlUHBNRGptRGlWbGxXaDIrZXdjd0N3bU1HNzI0b2NP?=
 =?utf-8?B?MFJSejZ6SUIzbjkvWlBaRTJCNlZCZmJCWjJEK3BTWTNBUDUxcTB1dXpXamgv?=
 =?utf-8?B?U0krRDAwZlZuZFZ5RVM2UGNsWVVCUW9VVjdjUm9UNzdIL292aU5VanBSczAy?=
 =?utf-8?B?dW8yZEZLem8wOUdGR0tOSTROYlJvbXY1MGdEYjFnWERvUm5NeVJHVGJGcDdi?=
 =?utf-8?B?Rm5SYjJYR1pJcmh2dndMUVZNNkFYSE5LejZVZkFBTEpBbHVYVnE2NlhMYXFr?=
 =?utf-8?B?Rmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f3131b9-b9d9-4ebd-0371-08dd88298be9
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 20:56:57.9920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9UtXEoZORaY/Zpi1x8eY7NNe5ttCB+UwuvnQncDtGsca3GlJFA3WhDNRk485aeprE78Dl1330UfuJEZDQp42CBob2rZ7x/JuAB+tHKukkwQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5200
X-OriginatorOrg: intel.com



On 4/28/2025 6:59 PM, Shiming Cheng wrote:
> From: Jibin Zhang <jibin.zhang@mediatek.com>
> 
> It is possible for a pointer of type struct inet_timewait_sock to be
> returned from the functions __inet_lookup_established() and
> __inet6_lookup_established(). This can cause a crash when the
> returned pointer is of type struct inet_timewait_sock and
> sock_put() is called on it. The following is a crash call stack that
> shows sk->sk_wmem_alloc being accessed in sk_free() during the call to
> sock_put() on a struct inet_timewait_sock pointer. To avoid this issue,
> use sock_gen_put() instead of sock_put() when sk->sk_state
> is TCP_TIME_WAIT.
> 
> mrdump.ko        ipanic() + 120
> vmlinux          notifier_call_chain(nr_to_call=-1, nr_calls=0) + 132
> vmlinux          atomic_notifier_call_chain(val=0) + 56
> vmlinux          panic() + 344
> vmlinux          add_taint() + 164
> vmlinux          end_report() + 136
> vmlinux          kasan_report(size=0) + 236
> vmlinux          report_tag_fault() + 16
> vmlinux          do_tag_recovery() + 16
> vmlinux          __do_kernel_fault() + 88
> vmlinux          do_bad_area() + 28
> vmlinux          do_tag_check_fault() + 60
> vmlinux          do_mem_abort() + 80
> vmlinux          el1_abort() + 56
> vmlinux          el1h_64_sync_handler() + 124
> vmlinux        > 0xFFFFFFC080011294()
> vmlinux          __lse_atomic_fetch_add_release(v=0xF2FFFF82A896087C)
> vmlinux          __lse_atomic_fetch_sub_release(v=0xF2FFFF82A896087C)
> vmlinux          arch_atomic_fetch_sub_release(i=1, v=0xF2FFFF82A896087C)
> + 8
> vmlinux          raw_atomic_fetch_sub_release(i=1, v=0xF2FFFF82A896087C)
> + 8
> vmlinux          atomic_fetch_sub_release(i=1, v=0xF2FFFF82A896087C) + 8
> vmlinux          __refcount_sub_and_test(i=1, r=0xF2FFFF82A896087C,
> oldp=0) + 8
> vmlinux          __refcount_dec_and_test(r=0xF2FFFF82A896087C, oldp=0) + 8
> vmlinux          refcount_dec_and_test(r=0xF2FFFF82A896087C) + 8
> vmlinux          sk_free(sk=0xF2FFFF82A8960700) + 28
> vmlinux          sock_put() + 48
> vmlinux          tcp6_check_fraglist_gro() + 236
> vmlinux          tcp6_gro_receive() + 624
> vmlinux          ipv6_gro_receive() + 912
> vmlinux          dev_gro_receive() + 1116
> vmlinux          napi_gro_receive() + 196
> ccmni.ko         ccmni_rx_callback() + 208
> ccmni.ko         ccmni_queue_recv_skb() + 388
> ccci_dpmaif.ko   dpmaif_rxq_push_thread() + 1088
> vmlinux          kthread() + 268
> vmlinux          0xFFFFFFC08001F30C()
> 
> Fixes: c9d1d23e5239 ("net: add heuristic for enabling TCP fraglist GRO")
> Signed-off-by: Jibin Zhang <jibin.zhang@mediatek.com>
> Signed-off-by: Shiming Cheng <shiming.cheng@mediatek.com>
> ---

The code change looks good to me.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

One note is that it helps reviewers if you could include a terse summary
of the changes between versions. This is marked as v3, but there's no
mention of what changed.

>  net/ipv4/tcp_offload.c   | 2 +-
>  net/ipv6/tcpv6_offload.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
> index 2308665b51c5..f55026b597ff 100644
> --- a/net/ipv4/tcp_offload.c
> +++ b/net/ipv4/tcp_offload.c
> @@ -432,7 +432,7 @@ static void tcp4_check_fraglist_gro(struct list_head *head, struct sk_buff *skb,
>  				       iif, sdif);
>  	NAPI_GRO_CB(skb)->is_flist = !sk;
>  	if (sk)
> -		sock_put(sk);
> +		sock_gen_put(sk);
>  }
>  
>  INDIRECT_CALLABLE_SCOPE
> diff --git a/net/ipv6/tcpv6_offload.c b/net/ipv6/tcpv6_offload.c
> index a45bf17cb2a1..b1f284e0c15a 100644
> --- a/net/ipv6/tcpv6_offload.c
> +++ b/net/ipv6/tcpv6_offload.c
> @@ -42,7 +42,7 @@ static void tcp6_check_fraglist_gro(struct list_head *head, struct sk_buff *skb,
>  					iif, sdif);
>  	NAPI_GRO_CB(skb)->is_flist = !sk;
>  	if (sk)
> -		sock_put(sk);
> +		sock_gen_put(sk);
>  #endif /* IS_ENABLED(CONFIG_IPV6) */
>  }
>  


