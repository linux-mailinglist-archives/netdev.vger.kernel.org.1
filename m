Return-Path: <netdev+bounces-287726-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OFpgNY/oBGqnQQIAu9opvQ
	(envelope-from <netdev+bounces-287726-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 23:09:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E6053ADC0
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 23:09:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 597873038BAC
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 21:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2770388396;
	Wed, 13 May 2026 21:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LD0jhuK2"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9475E21D596
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 21:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778706308; cv=fail; b=ppTTkBiZQNGgebrnuKcPsWzih88aCluZYFRQpUMwEO6RBUhH6Dy06L3zBbBj6xWH1+9xTvj4k4uIm7iYejieuZxCDkqgCPLytLEGTaepUHGVG6cql8SfUOvLxD2EDGlQJWSIzFpoJ3IwmfpIfDWJJKplWbdJVL3e03k0OTJuGFY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778706308; c=relaxed/simple;
	bh=wmuPLkoOAlt5+leYhTNOgiT+HakP5ERaWgNVlr8JWY4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JIFy8gHdF3h0UhxD8V74YVZlIVV0sYn5ikasuG4HQpULEd/prhetFz5hWGECLr4pY4yaFkvLck/HlVune5KBH6uBRdxkY8iizN3MFVHycVqcGLl5RUN3s9FgUtT9i7pJqSoTPjl1da/zCprFF4vw3jyHGdBxZJjWwIjk3Uxwmb0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LD0jhuK2; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778706307; x=1810242307;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wmuPLkoOAlt5+leYhTNOgiT+HakP5ERaWgNVlr8JWY4=;
  b=LD0jhuK296iTJTFPM/YpC9URmoKsXERmlm8wz13DNc0/266tLuzN5Srl
   XOgZ2nCGAhEE+4UmplEvC7+25jlWOQ1ViygvcIWo871ZTjxXkjb+FVvCu
   fnlK4yCoMJT/JrIkPjyMx1IVGYvURMi2Jp6zsaygtWaY+3P4H7UCMMNG/
   zJcJH7SZxaT0FgaKj/zeHfcJRDEdhR3E1kbMM4VezrqSDJvEmwiKnFeW0
   j19twmcPVXfUOafp+NhXwkx37SvDFChk02V89SXhx3RlCuT0mYGYkXR9Z
   mZL8mUXDsVUVF+YS4wFibGLSnazsjxGCaHEbxxcUH5Vzpbled1WUXwAx3
   g==;
X-CSE-ConnectionGUID: rfIz/WX4T5iSqJrFad2i+A==
X-CSE-MsgGUID: 3xvJs8BBSrOjQCylv6my6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11785"; a="90219351"
X-IronPort-AV: E=Sophos;i="6.23,233,1770624000"; 
   d="scan'208";a="90219351"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 14:05:06 -0700
X-CSE-ConnectionGUID: qQm5d4oHTuScCP1/6y5bZQ==
X-CSE-MsgGUID: YNRbUEHERDycNUxvUNHwuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,233,1770624000"; 
   d="scan'208";a="237329951"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 14:05:07 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 13 May 2026 14:05:06 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 13 May 2026 14:05:06 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.5) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 13 May 2026 14:05:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ok4AvDSYjiajjAVbqXMy5/P4tDdVaK1OTxrsy0cnp+aHiv9jWdLeCAHB5ysabj2LDQOZjQVckhKMGxnqCCDjllyY4Cf3WbBenK+XQ3acO2JZlto5DR3BPLXJQJbOo+i2JVZCz1uiZ38Ri9mDM+Jq+j2ZUEGjf+jXPMoQ5sdQ6cLjOW9JC9UG0SKl6vf0usY0QBgTUCPWTo051Eb8JxdOhn8+nuq9HrAoj+DYLJsJGRNbinY6o92dZfjQySZHxeavK+2M/BwW/KKtWO8B7uXEqGSEa+ZQwwFv/y2uH1S55ieZeR2cv3+Lwoxp4SAHRxjFKK9Lp8+Hf2dQoZblV2oa0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wmuPLkoOAlt5+leYhTNOgiT+HakP5ERaWgNVlr8JWY4=;
 b=CvkwjY/JCUm4I4YUIQXFmGHLstMujy9rx4EfpPZbVAOogCDyXHcbMN/5YonGT+iLccoO87GpBk+KjLIZPqN/6tQy39Kn0J1tcMEs5MwiZm2nqTBO0GYfn1SiiAelNWHRP65U8sLvjFcKANd5VZM88yY/51KaSPD2Odc7rIIiJ7FBXlMBKnTovOlQZwwJ6KMadMqEJGcg2OgseUaoHvMPFxESdh+FzfOLSoT0J7LcDrClEiizpwmht+m8kFPhqLWaMl3g2u6AiZ+qSKCCMGxTlKSKq2azHjelbCQzMg7Ex2RLzprRW+m/VYiOmtn4ZfeY5+hLHak3s1Q1PVHuaiIwDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8241.namprd11.prod.outlook.com (2603:10b6:208:473::9)
 by SJ5PPF8AFAE74CF.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::841) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.22; Wed, 13 May
 2026 21:04:58 +0000
Received: from MN6PR11MB8241.namprd11.prod.outlook.com
 ([fe80::cf79:ceec:e277:9d46]) by MN6PR11MB8241.namprd11.prod.outlook.com
 ([fe80::cf79:ceec:e277:9d46%7]) with mapi id 15.20.9913.009; Wed, 13 May 2026
 21:04:58 +0000
Message-ID: <213a9d4a-c126-4084-92ac-6bab3ea02b8c@intel.com>
Date: Wed, 13 May 2026 14:04:55 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net v3 2/6] ixgbe: add bounds check for debugfs
 register access
To: Larysa Zaremba <larysa.zaremba@intel.com>, Aleksandr Loktionov
	<aleksandr.loktionov@intel.com>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>, "Paul
 Greenwalt" <paul.greenwalt@intel.com>, Simon Horman <horms@kernel.org>
References: <20260415142841.3222399-1-aleksandr.loktionov@intel.com>
 <20260415142841.3222399-3-aleksandr.loktionov@intel.com>
 <agQsYBo3JqyTiEIx@soc-5CG4396X81.clients.intel.com>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <agQsYBo3JqyTiEIx@soc-5CG4396X81.clients.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0116.namprd03.prod.outlook.com
 (2603:10b6:303:b7::31) To MN6PR11MB8241.namprd11.prod.outlook.com
 (2603:10b6:208:473::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8241:EE_|SJ5PPF8AFAE74CF:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c73a246-f9da-4791-4221-08deb1334a29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|11063799003|4143699003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: b7biCInXa20gvzz/ERxjV+3Ie2tiFNMun0Oz93rvsvLO1Y/8whijVOugQjVnSNgys2a65r1BWFP2n+anxj5cHmD3Mfdb4VwQYfjIzwPIGfS4/dzvCRiZUOGQfrosX6MJb2z6fg08EDGLg0iJzI7O01cmAupMZDh1TiaHw/jGGKaK1FTdFGDq2ZJeemqdOchRsNHdVlAoHrHwklRZ68tdcqIwDAGSAvWy9zITG0SfRskElCo3qDwIsWBFKJt5DwXOOOsUFNyNtqiPljaXUdjgoT80CP0QHSTU58cIHsynzNOQCkWYv7gjJH6PZ/FyYxvaRKDVKfjLkc9pTnkzALmKovBXymMjAt8AZ1DLY5gyP5uuFyXsdGm5/UVK1B6Wv9ueV8aY3ulGcQ0EI2NPsikNriYDuhL9bWc0ZxKXi/n7HoXnorUeP2JbpoGxBIsH4yoanPSi4oGPaLkZBf7TB4Vp0EfZ9W91H2kTPcqUgAQXtcqZBCxSipLSZRMdnAjyWN5tK6gwJYE/XmREvPWPB40LThMrXp5pvyUd89FUs6Cl2YtkODGLZXyiaOs0Oc4FeWn3oBHooRKrUKy6kbIs87LpLpRxy0AOqXIvzqu7cZNs1NDWHGHGZNm4GOC7CWDC5X+J1H9+8Y9MWngn4XG60TI7KILCcyrICbbYhP4Vh1oSFlfvlR8pAjsFi16Za52hB3Ss
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(11063799003)(4143699003)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WlhQeFBsZmYxRTRLV1B6ZFpFc0txYWJ2TlROVXd6ZXN2K2ZDSndCbVpMWlZt?=
 =?utf-8?B?QlA1cU5yNmR0N1BBbzNybmJhZjhNV1dkV3FGeGYyNUZpWURnckZqMzYwT3Ux?=
 =?utf-8?B?S1djdHRjL3A3TXZhUmtlVkFpRFl1RTloVytPcUw2ZkNMSk1uYXNVZVd5R2tv?=
 =?utf-8?B?eWNweGxmWXBtRFBmS25pOHI5QU1VTS9TekpGTDRyY0J6a2VsR1hOK001N0JV?=
 =?utf-8?B?WTFKTVhFUFJoRFFOWFdPNWN3OFpFMUgvb245OXgxcjhGQllPa3haWnlLenpP?=
 =?utf-8?B?bzdTQURlcnpaWmEveGVpaGcraUdqay82Qjk2T2FXT1ZBM3BDbGhwRkphaGYz?=
 =?utf-8?B?RVhBYzllQ25INlJIU3ZGK3RBLzdpVk5XdWJVa1JGaURSSkpZalJSMGNWVFQ1?=
 =?utf-8?B?aTBzS3BrNGIwRXVmVFc2R1lIeDZUZVFxVi94dVF6Rm04Q3ZFcDRkVTc2SEJP?=
 =?utf-8?B?RWZsZTRUUVZERlBMZGxwV2NRTUYxRDV0MVpOREVUclJzUnRFTC9LaktkU0Za?=
 =?utf-8?B?UHZXSmE1cVVDSHNBb3psTXBoa3RBYlROOTBhQUdIMm9oc0pYV0dpUXp0SERH?=
 =?utf-8?B?am5Ca0Q5dWh0Skc1NCtSdlJYNmczc2ovVXJ2VFlHWVduQzNUTm84aTdodzgy?=
 =?utf-8?B?SUtSZnBJaFUvRVFzUDZEK0hvYUkrRTRTWktqTlUrWTdWTjBackVwY29RTFVN?=
 =?utf-8?B?QUt6eTFTVXFRYVBRcWtIeGJNa3krZTg5VXFYalc5VnlnNWp0RFJjczJGbkNw?=
 =?utf-8?B?Z1A0ZmRFUERxUTNRSWE5YjloMVd0dDQ0VnU4Q1FFZ1c1NzhYRjJQWkZLL1Br?=
 =?utf-8?B?bWJ1elJaZVNPWWpKWnYwbDFVMStmM2FUMlZXKzU0dkRqTTJ3RVVldk1EN1pV?=
 =?utf-8?B?YkQ3Uk1VL2tLcVF6aWxaSlVBYU1Fb1Jsb2QwVjdXWWhqQ0xoclVQUlFINTBU?=
 =?utf-8?B?c2VDU210djlkL3c3b1JFbnVTZFBrZ2pmUEFMOFp6RDUveEFoSkh1N2U0ZXFq?=
 =?utf-8?B?aVpZNU1sNllMeG9IZVpwcFRXcnVlVjBlVXY2Unpka3k5aUEzU2hYNVRMU1A1?=
 =?utf-8?B?ZW45RHR4aUpDVXZEa3IzcDhPSjZSWFI5SmxLSEJrWm1FMGtMVTNYajk1YTNl?=
 =?utf-8?B?eGRzZkdadk5YbEZXZGRRSzhzVlU0cU1GS0hDZ3NqWGtSQTRzTlVmdWV5K3Zl?=
 =?utf-8?B?Q0tzS09LenMwV2R2UGFPSzZRY0MvTkdCcml5SHJvZ1FwU1FBUVNXMTFESEMx?=
 =?utf-8?B?dXZVYWRkSmhSVFhKM3BWcWw3dU92eEhCVGFDRjRmcHY4UnNwN0V6dWZzZlVJ?=
 =?utf-8?B?djFTLzVaMkZpQU9CNVNqTXJsUStTdjJxbVlUS3NlRk1wVDJEZTZJVCtFS2Ni?=
 =?utf-8?B?b0lzQXB1d0xSbzF1MDBQaUNwQmRDTi9DakpPdjU1czNvNVQ4T1M1Yjc1c3Q5?=
 =?utf-8?B?cUJTSFpENy84RVRncGQvKzhGU2ZTd25rVXUxTmhiclJqamFqcDdmWElpNTgw?=
 =?utf-8?B?NXNNNnBXZjViN2tML1BLa3B3ZUlnTlpQTkZJZzZlSkprRXNXTU5NdXlJK05U?=
 =?utf-8?B?VzdHRkJtNnBBWXUvQkNRZlBhR2dOMlRFQVNmTnlOWDJyMG9PcWdrZnJzazU1?=
 =?utf-8?B?MXJraTVBUStTaWxyY0hZcmFVaFd1VEZsYUhETE1ZZzdiWUdjZWUyTXdWdHRY?=
 =?utf-8?B?YUJQd01TUkNNRTRsZWt4NGx0LzUwRENsanl2aU5SWWJqUkZuY3IwNGxBVUE4?=
 =?utf-8?B?Y0xGVXpWTjdRZTh4Z3pkQmVRbVdKSVgwWWdRMnBtQU1yMEErSlI3bjcyQ1JL?=
 =?utf-8?B?NitvdkVGcXkwaWNnQmtTeUhrTlJRNG1Sdy9XdTZ2anRHN3Y1Sk5YV2IzK3Y4?=
 =?utf-8?B?c05iY3BUNCtwVFNENG8xS2RwNERBa1RDSnBlNWFrS1U0elUvaGpCb0ZVTTZK?=
 =?utf-8?B?K21zV3hub3ZuRFl0TGhjRGNraDlHWWJCR0hrMm9VWGRxendFc1Zyc3Bid0hu?=
 =?utf-8?B?UnhCMlQzL250QkhCU3Q0Z21yaGp5RitGN1F1c1YvL2YvTExNU3BwZC9GaDJq?=
 =?utf-8?B?c0l2M1hNYy82aWpzSzNlRUpGQnRVOU5qV29mUWdEaW8vNzR2WVNCYXhKeWJQ?=
 =?utf-8?B?U1poZ3QxU1NxMDZld3RUeWxaTURIS3ptRHdDbGQzVlhLdDMzeTBjbWtNS1ZY?=
 =?utf-8?B?U0ZTVVRMaTgxTnpxMWorbFp0L25pQ05Pb1l5VzBJcG04WmdzeUY5TklSemY1?=
 =?utf-8?B?cURzVUtGeHJ3TnBlb3dnajhBNk1CdzhhN1dYT0dPR3U2T1VxcUhDblNtcnln?=
 =?utf-8?B?Nkh5eDMzdkkrR0Z5K21TQVJxak5yUXd1YzhlZEV5dlY2NkkrR1ZhZm9UR0V5?=
 =?utf-8?Q?2TRX6LHuzjaAqVds=3D?=
X-Exchange-RoutingPolicyChecked: PusAjnu4Tf+FJtUvtl76qs3ggcO4aM4X8gxSVngSwUIABiBr4SFvzGEX942Ex9TNrZx3uNcIM0as2XX0cmt8gxc5H19UBclJK2oKTUlsuAYoS70XQL4jLuN0vzYBACZxzo3yLuix/8sMRv869uclUSRsyNpk4ciTnQnHTJGDM8nc9EziRmd5o00fAk/QDNYbgl11J2Xi1K8BY78NEReKDGZOTp9bIXbms9ipMDz+ae18BymP13pzEIwmwnONqvro4s1+FsJu09PJLv+b8JireLVpEHBv0h7amjvcO3BtCmgyM7u17XfFhlmrM2cVhoGLhQWxzR+qxfi4fU24bX3mlA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c73a246-f9da-4791-4221-08deb1334a29
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2026 21:04:58.2067
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AeA3BKzaD7rZ8ZkzuOQnab4QOtrs4/TrFiF2PlzwRpXfcoF/zjZYafic+NS/2dw4lUdxNcx8h8S+2ZckMn+QPMXv/ridVhz5JNfNdSK5Cto=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF8AFAE74CF
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 56E6053ADC0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287726-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:mid,intel.com:dkim];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[anthony.l.nguyen@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action



On 5/13/2026 12:46 AM, Larysa Zaremba wrote:
> Tony, please take this patch off the dev-queue, it is conceptually wrong and
> prevents probe on E610 and other adapters most probably

Thanks for the report Larysa. I've dropped it off of dev-qeueue.

Thanks,
Tony

