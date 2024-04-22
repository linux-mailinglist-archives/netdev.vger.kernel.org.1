Return-Path: <netdev+bounces-90306-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 308858AD947
	for <lists+netdev@lfdr.de>; Tue, 23 Apr 2024 01:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B17C91F2159D
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 23:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA11244C9C;
	Mon, 22 Apr 2024 23:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L4u+PdlQ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF2D46521
	for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 23:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713829597; cv=fail; b=kgPLOAyljOhyKtUiqPwp7L6F+KGJEirvf2CuxfaM4MLgrfmZrCZwZdEgiiJ6QFGc7byyvzzOszRIjTfh/VR7qVfHrt6ksewhiE8XUR0nkM26ooZhttBk6i9/zTwUmFpHNvwebCOW9sgk/GWZejLJNf+Uaif2msRaasOj8KPpqIs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713829597; c=relaxed/simple;
	bh=8Tlj7fNk3NFihrsHByfyx5lHFtNO0cyuG0OIjZJ5tS0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MkL/GhhNYJsXjAcrt2TRFFo/EulG9+BfCGBiHY+DioPyayvHoriqXg9XQfQIm7uic8JL54LQkQt+VjjKavsCYkjZNgMcBCrzqM+sJb8x4O3x6e9XrkQBe8/leKYuZc88FE4TRZaIaNsySeL7oRf/dV8SSk2gSP2z2APm32yHbJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L4u+PdlQ; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713829597; x=1745365597;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8Tlj7fNk3NFihrsHByfyx5lHFtNO0cyuG0OIjZJ5tS0=;
  b=L4u+PdlQ1Vg8b9w56N1Lk9IOvr30oTAxO95yGplaIkpUVB+LqZ2UVztj
   6cxTllcB8+gKZSGxbWt6anXvoxSYQB/km6Ce+pWsnnoylJgMpEi+wTjsg
   IkE0ujFTsy1EAKV1wFOHLEWPu1+an7XGmUseuZ6b63QEq4r9Y5i5eYozY
   l27pSqinLnTSZ0dJh1LDB8CDG5lGLoLcReFp2hpJLpdWnVDFMOzT2/Jrw
   tFIsid0/TBH57cmJp77BPbMzitMnzUEThVWC9i1y0Ssq8Cx7ioVUN9Xi0
   NJRVQ0WujlDuQXMoyPbUJxS3AlO0+aXEs2skQ/NysvSjrl+Q2KNOWGkBC
   w==;
X-CSE-ConnectionGUID: fNauVMv0RhSZl1URuaA2Gg==
X-CSE-MsgGUID: lFY7wz2YSEeuvVS381nAkw==
X-IronPort-AV: E=McAfee;i="6600,9927,11052"; a="12329926"
X-IronPort-AV: E=Sophos;i="6.07,221,1708416000"; 
   d="scan'208";a="12329926"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 16:46:36 -0700
X-CSE-ConnectionGUID: 0u9UO4XRTD6V5V2dB70R5g==
X-CSE-MsgGUID: 0KUprdErQ8ewwn/iURRQoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,221,1708416000"; 
   d="scan'208";a="47458999"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Apr 2024 16:46:35 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Apr 2024 16:46:35 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 22 Apr 2024 16:46:35 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 22 Apr 2024 16:46:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H2rmwZdJgwrHOJAldDePqYAyjZhOOABhAzGeph65fjdvQ8k2KFepDsvZOrvgvnzVLFxeSCD0bB6O4iU/xsVIwkXHnSWx+WW7/3ksiHofnYoqpQOcUUJ/kstYernk29LIBXmbCrc4Q8KdnJ607F53XBybIKUNo5hrA2G0BhNn5AqGFmsSHjhlPlx7oMN/Au8tG5f/6bR82z5vf/cZjVaNxxxqDsZ5TXcq+FWewJGV/neT13wbr7M+1Srfq3IpkxwCbRzgHXa3UvQ+ra204y4IzpGT7c/Zd+dE0pDaG3/HMv5SUs9kdnHML35qbK8IMw+8EmU2w1k6sCnZICJGCPkyRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8bWX8fuxLHgnAT7N5q4sAj2WP7egOuAKUKyfLcKdYL0=;
 b=awx1Qx2IceemvtuPSYdnDrsnugro8eSrBQAoKB9527el/UHUaBOeCPuecvFJiDFzVvbAQTxq6PJb9fPY0WHvCyJ0MS3Fth/LpSjtWiOCYmvxgu4P0nWCKTtHsXtcyyZLMr/cp2Rrr7L78Wz1edgaG8xU2+2N4QXfrW+nrzTMXxK57QeDCFoZuMnEgnaSIYCKHcEKeqNvSv9CKtjyo8/sGa/hDJAMvuMJu9EcxSeUHPxqXJH/2pZarnCggC6VoPsxOTZeOESP0wOAs3JbRpNZbDH4aL7lGGSIldxc+286BDCaOv6UeiUoRxMde8V0LBYZkv9fpUQWnRBwMjZmgbHGkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DS7PR11MB6150.namprd11.prod.outlook.com (2603:10b6:8:9d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.20; Mon, 22 Apr
 2024 23:46:31 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::b383:e86d:874:245a]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::b383:e86d:874:245a%5]) with mapi id 15.20.7519.020; Mon, 22 Apr 2024
 23:46:30 +0000
Message-ID: <a356d2a0-e573-4e31-bae3-2a361476f937@intel.com>
Date: Mon, 22 Apr 2024 16:46:28 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] igc: Fix LED-related deadlock on driver unbind
To: =?UTF-8?Q?Marek_Marczykowski-G=C3=B3recki?=
	<marmarek@invisiblethingslab.com>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<netdev@vger.kernel.org>, Lukas Wunner <lukas@wunner.de>,
	<sasha.neftin@intel.com>, Roman Lozko <lozko.roma@gmail.com>, Kurt Kanzenbach
	<kurt@linutronix.de>, Heiner Kallweit <hkallweit1@gmail.com>, Simon Horman
	<horms@kernel.org>, Naama Meir <naamax.meir@linux.intel.com>
References: <20240422204503.225448-1-anthony.l.nguyen@intel.com>
 <96939b80-b789-41a6-bea6-78f16833bbc9@intel.com> <Zib0veVgvgTg7Mq6@mail-itl>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <Zib0veVgvgTg7Mq6@mail-itl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR05CA0050.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::25) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DS7PR11MB6150:EE_
X-MS-Office365-Filtering-Correlation-Id: a423c957-591d-4ce8-ce31-08dc63266f51
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N1pvSU9xV0x0WjVFMyt5dm10Tk5aZWJQV1dyMG9Eb1pjdHFUc1N0QitwVFBt?=
 =?utf-8?B?aEEvTDlBWG50WDdmUkJ5UkY1OXA3eFZVSnNJQVlheWRtM0tRYkdteUFQY1hB?=
 =?utf-8?B?UWc2N0huUjdsZ0NLaVQyb2pvNjMzRnQ5b01POG9RYW85Zm9kQlNBOUd3cC9a?=
 =?utf-8?B?RkorOFNId1RaWFltVFVZQkI5Ulc0RTFnWHQxQ21SNlBUS0JHSFFpY1dIeFdz?=
 =?utf-8?B?YWlITlEwNHFPWmhSb1BSdko3RkRUdGM0cTVSWk1EeEowR1ZYM01KVnhpWHgr?=
 =?utf-8?B?MFQrSTJyMkFsdTljeUpYWXhEWTR4cVRIN1ZzSXlabFkwbkZZMzdBdlplZmFy?=
 =?utf-8?B?ZDJ4TThJcHFuQWFNcDVjUzBEdVZlL09Ka0JyVGJzMkRZNm12bnRZZzhybVA2?=
 =?utf-8?B?bU1pTzl3S1JsUzJkV3Ryd1loQkR4RElGZ2d4UFFqY2FNZFNka3R1OTZWVXdT?=
 =?utf-8?B?TXhLc2hhTTFiVnJNQXZreUhCVWRXMlNqc2VJWktHMEJxdmo0ZER2WEpkZytQ?=
 =?utf-8?B?TDNaTnhweGg5eGRvR3BFS2JmaTlxT2hFSDFtYjdEMlEyVGJJUmM0QlVLZWQ2?=
 =?utf-8?B?NDV2cnN1REhvNjBlMjZmWFZVaGJ4NkFUdWNRSFRRRmVPOGdYNDRSRVZXSGda?=
 =?utf-8?B?V2w4UUdQSTdYZlduc0trMy9JcHR0NVZJSkpzcVhoNVFISkVOa3d5YVRMVnE5?=
 =?utf-8?B?Y0JISWRmQTVoWUdTR3E1VDVmcVNvdUdjWTZPNWFtbDBFQkVKR3hGWG0ydWh0?=
 =?utf-8?B?R01OZDUwaFYvRW9jWk5LUFdoc25LcFVITGRteERDM1JZSU9GRVlTd1BwNXdt?=
 =?utf-8?B?eHFRd1lmZDR3TEJ4VXNwdVNiaHZvZ0UyN1l1MTByS2tEczBMUVdRczI0M2pq?=
 =?utf-8?B?em9PNG04ZXlIenpOSXlURUFNOXJMaWI3M0lKNFhTNS9SSEJTMUoyTU9mWFgz?=
 =?utf-8?B?Q0NUVmtSS2VsR29nWk4xV0l6M0FuZmRzWURoU3oralgxSUl2RU9MRmlkZGl1?=
 =?utf-8?B?S28vNTR4aDZnNnJMaXcwUHVIWnNnS2hmZUwvYjNFeDhrNEEzNi80S203QlNC?=
 =?utf-8?B?Qm5rOVRkRkd6elV2bmQ4bi9pRHRLRk5QV2ttZGl4WXh4YnB3R3QrZ21jd3FP?=
 =?utf-8?B?ZlRmSXZQV3dTRDJtUXVaanVCYWlyOGxoa1lIRU0zMFlUcTBHOFplUElMUzZG?=
 =?utf-8?B?ZHU1WVFRcGp1WkREZTB4N3M3RVF4bFBkcTJlc0lEaTJxR0lXVGUyYjU3K1hk?=
 =?utf-8?B?ODVOR0ZQV3h3ZzRFazR6MTBWMVZLajZUSHZaeW44TisrS2UwaXpCL0doNjA2?=
 =?utf-8?B?RGVueHdWU1A0dWtaZVMrckVZUzlSaXNlaGF1QkRuNERkRXlnVHl5WDA0ZDBD?=
 =?utf-8?B?QXZHcFI4ODlmdThXMExDcXA2VDI4cDVlb1pNbkV2dUN5UjM4QVRpU0tHSENG?=
 =?utf-8?B?TElsSTd4MWF3aEJaa0cwMEJ2Vk96eWN4RnlpOVVxVlc4OUNDM0NNRGpqa29k?=
 =?utf-8?B?bzhiZGloVGdWM1YrMk90NUM1MERiVjViaGh0MWlTWGFJZUlMQ3hacnovSFJ6?=
 =?utf-8?B?NHFxZFp6NlNCOUU5RlAyV3JoYXo2MzVnWEhvRXRBVUFBRVBrZjN2K0RqSDdt?=
 =?utf-8?B?d1R6NFZ2WlRRakl5VlB6NnNUcFBTcFFOWUlVcTBQYUR5NVZzVWRTVVRvampQ?=
 =?utf-8?B?Y1B0L044VVRrNS9GZ0JsVjlIRWJlejY2MXRtOFdXblNsbHc0QUtSVUxnPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SU92Rkc2bi9vL1I3ZjNmYWtlL2VIK3c3MERoNW0vamVIQ3oxSFEzK1FUNUVv?=
 =?utf-8?B?TEVPcTFtUVFGMHM5UVhOMW9LczY3eGxQd0wyMEpycCtHQWpESWJYK2hrQmlR?=
 =?utf-8?B?STRsbEFQak1FcFdJRHlaNWh4YTZPaXA0d0JUWDZDa2ZMMWF5bStXR0RtNFV6?=
 =?utf-8?B?ZHJjaXVkWE85bWpJUGtFUTl5VnBYK2dzV2g5dlllN3h0U0NkdTNSOEhDZ0Ft?=
 =?utf-8?B?M0twVUVTa0o0alZjNEN4c3A2Tng1UmVOMGtQRjFZRXZUTTFaamRHckhUWG9s?=
 =?utf-8?B?UmtaSDJCSytWMHBSOWoybU5LTEZoRU4rSGc5NG1mN1gyMGpYa2x3MHhDOHNu?=
 =?utf-8?B?Nk1ZRVptQnkwVTdzUEJ0VzNpZnI5TGpmeENGcWU2cWJpajkyQXZKY0U5bFAx?=
 =?utf-8?B?eC9WMUZScnJxRWVKR1lOcHcyS3dTNVBwUmxoOHRNTWg4OUlzQXp1WWY0TEVD?=
 =?utf-8?B?b214Z0wreHpXNEtiZnhENDhZVW9HM3V4b3hzZ2ZXK3JGTk9FSkpldGVQUnJi?=
 =?utf-8?B?bjduclQzN3BzZEtnSVh6NmxYaEJJc0NoaVVybzNyY1kwMWorYW5aZVRLSmpB?=
 =?utf-8?B?SERmQjdEVHQybk1tc3diQUt6QjFCdVdSZW5SbXpQT2Fxa2R1SStRUDVCcFlI?=
 =?utf-8?B?azBUeTN0dHp3b29HV28rd045bkxxZjVRbzFvREdWaXA1UHF1d3pocnpBZkho?=
 =?utf-8?B?czRvMUFCQ1RkWW1senQxRnlFamxzVHYrN2prVGN6Y012K0ptNnNRV2dBUlVI?=
 =?utf-8?B?NitSVG1ybDQzeVVTbXh0OEwvSHJ4RGlOeVRuRmlpSWZ2YWloNDNmQi8vWFJm?=
 =?utf-8?B?SjFtOEtyZnhaZlBsYXp6YVFLS2t4SVZjcWtsT2NkSkJSa1FoSW53VU1hYlor?=
 =?utf-8?B?c0M2aTlkakJyN3BqeHFkWEpkcm02WG5KMDAvZkxkYUU1L3NsSGZIU2tiYUND?=
 =?utf-8?B?OFNaN1Y1bUpEYXpEcUd5dGsvNExwdk12R0VZSUFibWw2aExlY1hpTDAxNGRI?=
 =?utf-8?B?d3RNdWlxKy9GaUd1Y242TEpna2RlQ1lkVjI1WUJmdTZWYUlNR09YbVhCUkdP?=
 =?utf-8?B?WXBSVTE5dE9mSWNKcnRsVHpwdnN0WkVxSG9KOER0MlU0MTloeFFuRXV0V3dY?=
 =?utf-8?B?R1pKd1dlVmJHRWlYL0hrNllkSUdnWGZIRzE1U1VFenNuSmZWSE1zNHBiTFo5?=
 =?utf-8?B?dUZQdHQzeGxKcmxyTE4xbE5hdUxUeXVHcCtSdU43QnJjeHBFOWhGWExMU0U4?=
 =?utf-8?B?bS9oSXI0bUc2ZGoyRndIWFMzd2I2cGhScE9XQ2FyZVF3YWVyS3U5eWk0WURT?=
 =?utf-8?B?VVYwTi9LazhtVUh5cW1Bb2xSdzZqUUJ5OGFwejhnOFlteTZMUnhZclN5LzJr?=
 =?utf-8?B?YmF6Zkl4aXBtVjRTMG9nZXlZLytLbko3R0ZIRE55MnIzWkcxSFpHOEZ4Qm0r?=
 =?utf-8?B?djhaMG8veUU4am10QUdZQm5mY0JtY2hlbFl6SFRFTHIrYWlud2x6UjFNQ3Jq?=
 =?utf-8?B?NkgwYnVoem9HejVWSVNVeXdjbmYrQy9kR05TSUhYQUlwTUk2dkI2SlhxODcz?=
 =?utf-8?B?NkZRT2Q5Q2dpNEVlb2V0dmpPdEhLVWg1V2N5K24ySlNORlR5MkFrNW1GV1Ux?=
 =?utf-8?B?RHpOSUdwckNxWklRSlA0TDVRaWR1WTVyTGQrbzBJdjk3UFBtSXI2QTV4N2or?=
 =?utf-8?B?VTlOWk1acEVrU3MzM3diZjd2dDVTelU4ZFF6TkYzQ0NDemtuMnNCQVNWTFhI?=
 =?utf-8?B?eXpvQ0tiZDZ1d2laaFpzN3FndWxDN0xOQXl3MlR4dnY1ckZZS0NwREFCcDNH?=
 =?utf-8?B?cy8zRlVicDEzQ1JaWkx2QWdzSndGRm90SEVkMkgxSDMwanFlVUNGR0lNdUhy?=
 =?utf-8?B?aG1xa2RyOHVVeUpnVnRWOGlVcFUyc1NBVk4xU3lBK0hXTldVWnNaOXh5Z2hm?=
 =?utf-8?B?U2R4a25uTXBRdm5FMkl0eXY5R2pkN1FHSGNhUmtDMTFjMG4vZnN1eWU3SFNi?=
 =?utf-8?B?SnpmTVI5M1lIMkZwczA1aXJ3MGJ0Q3paRDJVdGdsc0ZkN3lwSjNXT1BtMWpw?=
 =?utf-8?B?UkpNeDNBRFE3N203T1A2SWtTdklDbTk1YWlQSDd6d0lWNG1aNkNLd28xa0N5?=
 =?utf-8?B?Qzh0b3BPZHZFMnZaMlFrR3JUajIrY2pNUlNRb2JkNDF6ZzNiNkRiQWpHYWpr?=
 =?utf-8?B?SUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a423c957-591d-4ce8-ce31-08dc63266f51
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 23:46:30.8761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 91XOjYKM4jnwj7S5X3vJrZiMVmGXEo+9geM+NCw9+gde0vrgo5Uvz/QQAl95eCJXK+ehAbeEDLqbaMBSWDxXhpSYg2jfXMz5CbfjzPM2TU4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6150
X-OriginatorOrg: intel.com



On 4/22/2024 4:37 PM, Marek Marczykowski-Górecki wrote:
> On Mon, Apr 22, 2024 at 04:32:01PM -0700, Jacob Keller wrote:
>> On 4/22/2024 1:45 PM, Tony Nguyen wrote:
>>> From: Lukas Wunner <lukas@wunner.de>
>>>
>>> Roman reports a deadlock on unplug of a Thunderbolt docking station
>>> containing an Intel I225 Ethernet adapter.
>>>
>>> The root cause is that led_classdev's for LEDs on the adapter are
>>> registered such that they're device-managed by the netdev.  That
>>> results in recursive acquisition of the rtnl_lock() mutex on unplug:
>>>
>>> When the driver calls unregister_netdev(), it acquires rtnl_lock(),
>>> then frees the device-managed resources.  Upon unregistering the LEDs,
>>> netdev_trig_deactivate() invokes unregister_netdevice_notifier(),
>>> which tries to acquire rtnl_lock() again.
>>>
>>> Avoid by using non-device-managed LED registration.
>>
>> Could we instead switch to using devm with the PCI device struct instead
>> of the netdev struct? That would make it still get automatically cleaned
>> up, but by cleaning it up only when the PCIe device goes away, which
>> should be after rtnl_lock() is released..
> 
> Wouldn't that effectively leak memory if driver is unbound from the
> device and then bound back (and possibly repeated multiple times)?
>

My understanding of devm is that when you unload the driver it calls the
devm teardowns so you only leak until driver remove.

In the netdev case, you're releasing during unregister_netdev() instead
of at the end of the .remove() callback of the PCI driver.

To me, using devm from the PCI device should be equivalent to managing
it manually within the igc_remove() function.

I could be mis-understanding how devm works, or the order and flow for
how and when igc allocates these?

