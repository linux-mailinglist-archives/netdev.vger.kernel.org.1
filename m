Return-Path: <netdev+bounces-108795-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7181F925820
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 12:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFA171F22034
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 10:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467E0142904;
	Wed,  3 Jul 2024 10:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T83mj9IZ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF5713D617
	for <netdev@vger.kernel.org>; Wed,  3 Jul 2024 10:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720001652; cv=fail; b=KAEONxhQxHPEu4RMgYH3HkFpc3pBp7Sfx/kb3bB78rBokAYN0f1+OclYftMf+HKzt0JZau6KDvqbZBSDeWAyFvCZPnRtFXl98DJiAL3ElULAv2+TZPQ942Z6EMAZ4etD/Su2o1mM36e+BIQOVX1yiCYg+//WBYugIFB/cJhNE5g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720001652; c=relaxed/simple;
	bh=q//5oTEMWIOFOCdyijlndF6WVMJCrfLzskLTDc3fjTU=;
	h=Message-ID:Date:From:To:CC:Subject:Content-Type:MIME-Version; b=JY9jvMkhi6bQ0HdsrXMrYI2VPFrXrOAmtFsEQkAdAi6IsK1AHnS60LBgGphkK4/xeRNSRR33alWFyyWZE9HrelztCcH5kAZbY64OhVsZoHdai9qKCMPMSfS5CiOtjteytl5WybAmJAAEQM5oG4A+XPFR5em1ifar+TzDyC6wWy0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T83mj9IZ; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720001650; x=1751537650;
  h=message-id:date:from:to:cc:subject:
   content-transfer-encoding:mime-version;
  bh=q//5oTEMWIOFOCdyijlndF6WVMJCrfLzskLTDc3fjTU=;
  b=T83mj9IZh6vPenSAsD92CUsj+A/X8KeCDjjmOa4y4lUqtrWt8tZHZmXu
   XGu4ZnYw34QaQwnsxo4rQP8hQNVvNxw8jzLalajxhHjBj0P7cJ6n0XDKP
   OL9YmeQ0vh/kvFhHloY+gTCzKLchAkueFsWg9DBGwbHc1z9QbnoHiuBDa
   jIs2MrxbeFzyp2ZxvibWcQhXfNm2dT7B6TTOkgnkyipoyVsHVlk6YKjeb
   sEphA7KkP21blD8mH6ROZs1uM7mZe+p6wXXXSJV2fbeMcvBQJWzKzaNdG
   0yPsbKcwBwbEXyDcp67SZDcg13uv7IsJymzKYpCefa/et7Csb5wAjaY0/
   Q==;
X-CSE-ConnectionGUID: HoxpwcJXTEukQrhIkBGakw==
X-CSE-MsgGUID: CRKXo3wzQC6prqfWnlUe9Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="17356415"
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="17356415"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 03:14:08 -0700
X-CSE-ConnectionGUID: Y3u+RlAES9KS3w30ThkpGw==
X-CSE-MsgGUID: 8HlQ5vo7TWuKCcZRMoNi6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,181,1716274800"; 
   d="scan'208";a="83759682"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Jul 2024 03:14:08 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 3 Jul 2024 03:14:08 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 3 Jul 2024 03:14:08 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.176)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 3 Jul 2024 03:14:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fow3g95oEYeqjXUKIcVZkpetp2dGX/hY4WL8QK3BQFe01D7KHaaC4m934Fb5YwMr+m7InNp7XZJQZgcE3rnqz0LHiSoXwWkoUZS4Gevz6HliXXbKpQNfCBI0jppvzGK+o/CB6Ewurs3xCYCimAJ6EV0OfA6tqqtSLVogkykOKKRsmLLMAo01wputrwRuBhkEE82lUtFjRsIoqra5ywzsxEdAlsA9ifJE7w3G2L2NWAv1fqYjZooGO0AaQTtI59BRm7uZSHSFnBG2IGzxRM3HLVY5LNHn9MDfI5/CaQRB3hNbFU0RjUiyhTzU/3xiYEe4WZ5RaTd6zqGYeBVf1vYprw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HPE0YOv76DikMZJLRPUxlPbXR0UhmK3dBw6E2C5avPQ=;
 b=Cf1kUkNniYAE2hQ9iGQ4Go63f1R/mracB2cKzBwDR4vHFC+H/wI1q46YiCFaJ1nhw3XS1JlqpnILnMb3aOPeGmn3lwXf4EhTAEkgO/R2kn4PiA8g9qMi6idaACg1xPzKEdqmN0R7CznpEZr+AArRtwQB4fSjj0TW43fnUD5jA7sS3rvmHZu0CFDvhnIvVPFeEt8fDDq+RtVHij/0ckIF/yGAvFTVAzBE8HtzUiYaY+Km21lcy2KnWDihALVeabI2h0NwTA3SWSoWYvUfSGIYxBeQ2n/6NkvSqQruEJm02At3AvKBRmBDD0f3SzpiOI11A66H2blb7Vq2SBIFt3paZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by MW5PR11MB5882.namprd11.prod.outlook.com (2603:10b6:303:19e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.23; Wed, 3 Jul
 2024 10:14:04 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%7]) with mapi id 15.20.7741.017; Wed, 3 Jul 2024
 10:14:04 +0000
Message-ID: <4886830b-73fe-47f5-9635-0f3910c8e205@intel.com>
Date: Wed, 3 Jul 2024 12:13:58 +0200
User-Agent: Mozilla Thunderbird
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: [RFC net-next] generate boilerplate impls such as
 devlink_resource_register()
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MI2P293CA0009.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:45::6) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|MW5PR11MB5882:EE_
X-MS-Office365-Filtering-Correlation-Id: 36b66c46-e020-449a-babf-08dc9b48ddca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?K1BCZGdRRlN4T3JBZmt6ck50ZGI5QXBZZmtHMHhEclZ1VlRjVDk5dWtMZnZQ?=
 =?utf-8?B?RzNIbWM0d1ZxUUdjRFBveVRpcUNHMUp4d21IeTBqUVY3aTNxbGhOK3p0VVNU?=
 =?utf-8?B?N29jbkc2WTd2K2xNN3FtM2h6elVnV1NoRHBKSWVKbnNhL2dLVlJZRXpkbkQz?=
 =?utf-8?B?T0ZhV2hoVExXeXovUEpUZE5IMnkrMDJPVXBjYTR3ZjV0Y2daQStoNjVMdzhi?=
 =?utf-8?B?bEpmNWYzd1UwWXpHelg0Ulg5N2Qrc05VcFFIM21ILzcvNlRaVjNJS1RiRFRM?=
 =?utf-8?B?MUdjNm5qNGkwVnVPQkxITGxjQVpBV1R5Zkt6Nms5bTMwODJEMHZLM1N0SUt6?=
 =?utf-8?B?NzJyd0UwZTN5V3dKMHJmaWhJVGU0ZlpuSzBjUWpQc2EyMmErNnVhUExsckRu?=
 =?utf-8?B?QkdpcnpKZzBtNTJZTjZzZm1CNUxOeXpKc2NLckpxdUJjUXFKRmN5djBSVUkz?=
 =?utf-8?B?ZTZUWFM0ZkhNSE1icVM2ZDZWRU9nS1JTNldTQTVmZ25LeU90eEUwcStpVENG?=
 =?utf-8?B?a09pQjFyZzVMemlPbnhZOEtlUkxWRUxjVnpIanBZK1ZDR0JWSHY1dUVtYzBI?=
 =?utf-8?B?ZE5RRlJQclNYQm40NDlEeG9iYmcvWDVOdzM1K0doeTk1UVkrak9LaGdJMzM4?=
 =?utf-8?B?RndycHJlb2g0SkRaSE4wMVlhNEJERzU1YWdSaDE3ajNWMU16VEJ0dUNNM2x0?=
 =?utf-8?B?Qlp2VEpLN2dWNXVKSG9UL1F5ZUhCNkI0UEpMdEVOMExUUnRFcnJHNlRKbGlJ?=
 =?utf-8?B?UC8vYlRwcEFXbUNpYVFTRzh6dFZDTWVsNVBCeTZGRVl5NlIvL3JUNUFPL05h?=
 =?utf-8?B?WGN6L2hEQ1dxM01xUHljS3FPa1l3c05sMnVwRmxwa2IvenJkdGZyM0ZRYUpF?=
 =?utf-8?B?eUNWR2tUTUZ5dExkdHFaVUZDSmNiTWNmN1k1aXB2ZkhvaitmQTNPc0VBam5p?=
 =?utf-8?B?M3VoZDVwSXphaWFac0VxV2NidjFFM0FRR2xXRUFPQ25iUjRoOFF3YW8vaHBp?=
 =?utf-8?B?ZXI5czQvQXF0QVpKRitGdzdGcVowYzJtWkd5VVBBeVdqbEhlbEo2Z2xKZnVw?=
 =?utf-8?B?SmtmeWJ3TWtxdVhEMTlSbWk0R1RGMXNmUWVhZzRTa3lWdVRpYlMwejVBeWlC?=
 =?utf-8?B?REpsZWltKzUvUkdDRlZ2SkpFaktJVk1YdGhVbm9VTDdKbGI5YlArV0UxeVE3?=
 =?utf-8?B?bFU2Q2xYS2VkUnR1ME1oVzhuSzhBVEVibVc2Z1Z6c1FHbjA0emxjeE5EQnJo?=
 =?utf-8?B?V1ZZSzFpRXIwcThuVjNCL1l6Z3VxL1ZyS2dTenppSnd1UElmVW8rdkRyVTBr?=
 =?utf-8?B?WEhBWjFOakdHK2o4emNUODVzRUVUYVh5aU93R3o1QkoxdkM5aCtlVTlEMVph?=
 =?utf-8?B?aFV2V0xJZUFxTjEveUZtNFA5d0w3R1ZyQk9WNjlRb3dGRFg4eldHT1Z2aDI5?=
 =?utf-8?B?OVlSSFpMRElDZ3NQMittTm9pS2hnUWZncnBlSTMvUGJuejNwdHJReE9ra1Vy?=
 =?utf-8?B?Kys4TmJCOG8zdkNGRVFDVE5Wa1ZVRGNzNVliTWZIb1Y4UU1DMWdBcWlHbjl5?=
 =?utf-8?B?NXExbXc2d3lxdGh6M0hLZEFtd1piUmRWMWs1SFFwb2puazNjendnejI5c1N3?=
 =?utf-8?B?aS9XVXgwOHpsZGU5dnNaTkRFYnhwTW9qblhaL3lIUXdUYWlhcnlRV01QRFdy?=
 =?utf-8?B?cUR6bVBIMkJZY0ZqajJnWlRMQVhsaGZVZmh2cTVXVDlFREdJTFJwOEJjbTk5?=
 =?utf-8?B?WERHUWt3Y0h0dlJidWNXMDRwUGVFMVhmalJGL0ZlMDhBWWVBZ3p6b29ZNGlq?=
 =?utf-8?B?dUVBdlNieTNiTjhGZnErUT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MlA5Zm5ja0FySDFhSmFGakt5Rk1obVdsbTJ3S2NOaTg0ajVEbWR3VU5qSUZQ?=
 =?utf-8?B?N3hPU21iUWd0NzN0dUFoUEFIWmpjTkw5VDBFS09namhib2dVd2pQNUtQaHJU?=
 =?utf-8?B?azJrenBDRU05RFUwa0J6Y1VqQTg0VmFNSjluWmJtVW9KQkNhai80WldSQWdj?=
 =?utf-8?B?bHJpQXV5YXByc1o2TzhBNjJtV0pSMFBlWjYrU0JCMkZnVXFHS1hiRVhsdU5R?=
 =?utf-8?B?Y2tsT0ZBNGNYeFZlMVlFR1Q0SDhHNzBiL0FOeXlQMmp0NFpKUFhidGZWMFRq?=
 =?utf-8?B?SFhnUWk0S1dzUkN1bExrdDBoUWNVellRQ284SHRHRnNUSGNMRlRwelZwcTBj?=
 =?utf-8?B?YTYwemp6NHVkSUpOSVA5RmtGR3JEUFNBQUtDMElkemVVaXRycDY1aTByNndU?=
 =?utf-8?B?MkZORittWlJDS1E5bzN0V0JzOG84MEV1SDJ3eVVicjNkR2pONjdkTml2U04x?=
 =?utf-8?B?NlFNYXpCREV6OEpTSU56VldIb0lnMFVDa1FaYU5TVDZTN3ZQUDhDeURzc1Ur?=
 =?utf-8?B?ckMydTNscU13Qng3V0ErSXNaa2x6MjNpUUpKbENTbytENW1YMGdUekMwdXMx?=
 =?utf-8?B?R2VkQ0JOOVk0MGRmV1p0VGcyY0FWUzJBNzRGSnZvU0tXWmJ1RXMzQytINGFr?=
 =?utf-8?B?MU5UMkZURDY5V2hGSW5QS1o5YVpGelVGTmFTdmpnMzh5ZTgwd08rU0VEMGda?=
 =?utf-8?B?aFVhcXIxbm1MSUc1ZXUxV0k4MFJyeWlUUHY1SDlXUE50aDMraVp2QlBueHdF?=
 =?utf-8?B?Qys5ZXRROUM1ZzdPZUF4TGZiM1p2Vjk4eGprcVhUWnNXZFhoVjUxV2Rsdnpj?=
 =?utf-8?B?OWxQT1ZWVUlTMHY2dkJFSHdhZng3KytoN0hwRmhwa3FOcXRJZ0FUZkNoNWw2?=
 =?utf-8?B?d1ExbU9RTjJRd3JRNHpXNXpqWG5JamhUQ1RHSkxPR01RT2lmaks2ZCtMY1A1?=
 =?utf-8?B?VG0vTEZmRFZsMURrb1Y3bXhWYlBvSldvamxUdHVXM2dVa1Vhdy9IWDRVVHhB?=
 =?utf-8?B?SitWWHRHdWo3SGVMRTFhcUx5L0NQQjdZM2N4YjVTUW50NmltK21RTENCMXg4?=
 =?utf-8?B?eEZVRi9QOHVPMjZXZDVKaUdsRDlrTGVDTzlTTnJsL0NwQ1JiRGI4alA2c0VD?=
 =?utf-8?B?b0V5L05PT0NSK01nSVNCc3QwV254M3JXQTUzSmlUR2EzN3U2Zy9EekZyeVdr?=
 =?utf-8?B?b1F2NklDRnVySURSV1BZb3JSbjhrS2dYRjNSSmNta1ZrY3hvQ3VROW1CbUZZ?=
 =?utf-8?B?b2xhaHdQdmJISGhQejdhWllHZGdtQkliK3RmVHNjaFUvaXNiUHlpSUlIVS8w?=
 =?utf-8?B?dlRnRWsveWZvMC92aW9mcDJNaStSd3kzMnpZc2tRZ2dSMnYrTGN1Tlo4ZldM?=
 =?utf-8?B?NmJuYlBCUGFvaCtrbVlMOGdaQm1Ba3poNFFVaHdMazFid2FwTlBHemNvZFA2?=
 =?utf-8?B?a1VMYmlFZDFad1NNM29sZWlqMDlyM3cxdjdoL3R0QnA2SGliZkhPRkI5Q2dP?=
 =?utf-8?B?QytlemlNVXVXNlp6aE9WREJxM1lycjJIdTBubklUTmhhZVBRaHoyM1dJWEYw?=
 =?utf-8?B?UFNWU0w3UW5UYVZUbjQzV2llU2pTZEJsUEhPVk5mVGJLN20wMTMxQlNWUEEv?=
 =?utf-8?B?dHRnYzNHcTdCQXNXOTk1Nnk0TnV0SGhnVDJpWmg5UFROdWxrSS9wdnVCRmtC?=
 =?utf-8?B?TTZYeXpSRjhHdjZYbnFpeGZhbmt4ZlJ0cEhxb3o1S1RRa3hkWmh3cUVVUTFh?=
 =?utf-8?B?TVdGTXVydXlhTncvejE1WkxaWkN3TlQraThjMEhEUUY0a0tqZE5pdENSQTEw?=
 =?utf-8?B?WFRIMHVtR01zcEl6dHcyTEc0QnR2M01Bajc2QS83TlZxTklFNlhvdDE0K1Fs?=
 =?utf-8?B?ekIySEVTMWlBanNnSTZ3eitoaEhXczR6REhHV3I1LzJBQXFLYThGUThiblYv?=
 =?utf-8?B?TURJcE41K3htc3d6WlRzL1I2dGpWaUIrSEZsd3FjWjZmZUlVUjBmbVNTNXg0?=
 =?utf-8?B?Q3lVRlpPbTlYM3B6UTdXNTBNb2Z6YmJRWnUwUStrbVVoSFBRa05xZ1JzSmNM?=
 =?utf-8?B?NkFNdkcxeDhUczN4b2xEdCs2NDJERnJuRUFMZzF4c3AxazNSbW1mWHcwMVNn?=
 =?utf-8?B?L0hJTUFNNjhGMzJ1UzNQMmpUNlo1MXA0VW84MHNrbzYxaDAxZlBsZVVydnR2?=
 =?utf-8?B?NFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 36b66c46-e020-449a-babf-08dc9b48ddca
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 10:14:04.2533
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V0NyZX3wPZ6Q5pJmh4Pe4nVadhauyQjtsF48/OWKRdwsD2rTY0QOggpearQlq6zM/1z7Ppq+iuOVcqKEvpTdSZWTtNUOBqM7TZZeFa7Vsu8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5882
X-OriginatorOrg: intel.com

Hi,

I have and idea that boilerplate devlink_ wrappers over devl_ functions
could be generated via short script, with the handcrafted .c code as the
only input. Take for example the following [one line] added to 
devlink/resource.c would replace the whole definition and kdoc, which 
would be placed in the generated file in about the same form as the
current code. This will be applied to all suitable functions of course.

The script will be short, but not so trivial to write it without prior
RFC. For those wondering if I don't have better things to do: yes, but
I have also some awk-time that will not be otherwise spend on more 
serious stuff anyway :)

[one line]
DEVLINK_GEN_SYMBOL_GPL(devlink_resource_register);

[removed part below]

/**
  *	devlink_resource_register - devlink resource register
  *
  *	@devlink: devlink
  *	@resource_name: resource's name
  *	@resource_size: resource's size
  *	@resource_id: resource's id
  *	@parent_resource_id: resource's parent id
  *	@size_params: size parameters
  *
  *	Generic resources should reuse the same names across drivers.
  *	Please see the generic resources list at:
  *	Documentation/networking/devlink/devlink-resource.rst
  *
  *	Context: Takes and release devlink->lock <mutex>.
  */
int devlink_resource_register(struct devlink *devlink,
			      const char *resource_name,
			      u64 resource_size,
			      u64 resource_id,
			      u64 parent_resource_id,
			      const struct devlink_resource_size_params *size_params)
{
	int err;

	devl_lock(devlink);
	err = devl_resource_register(devlink, resource_name, resource_size,
				     resource_id, parent_resource_id, size_params);
	devl_unlock(devlink);
	return err;
}
EXPORT_SYMBOL_GPL(devlink_resource_register);

