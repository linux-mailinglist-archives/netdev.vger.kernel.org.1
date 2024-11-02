Return-Path: <netdev+bounces-141243-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E15C79BA308
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 00:31:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 095401C20FC3
	for <lists+netdev@lfdr.de>; Sat,  2 Nov 2024 23:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C443C166F34;
	Sat,  2 Nov 2024 23:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NFLFJGkv"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89679380;
	Sat,  2 Nov 2024 23:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730590272; cv=fail; b=FEv/rz3gU/+u//X9UvJIwwY9sseuHrQuzP79Wx0Aaj0LnBZn9HTfLCqi2r1CLlifgXh4OOG6QbR5cq67Dnmy6OU0HREjpMDH4ludHl33ta7s7c7ZN/wOm3lAHgamlX/GG+HifBz6XliaG01MDx1LoI2EDoJ0bur+3y+ZE8eXHX0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730590272; c=relaxed/simple;
	bh=uOJFxjtwEvJ/AyVrRUa7fWMG9YEwA9vMGNpgPJM78z4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=S4gosjEK35A4y2a0+6pPpOb0SLZ5UUrVEsMMlmCNpeKIBny2B08hUMs3yQOkrefsiLDaH7MT2nyipYxZgVMfECDRIWR5JqEOmFOZgFitKBf27SDbOPqGphYvyVsOA48eiO4pVPhCa24KqogHyia62VxkrHP5T1SdOm4DXqClDrU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NFLFJGkv; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730590270; x=1762126270;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uOJFxjtwEvJ/AyVrRUa7fWMG9YEwA9vMGNpgPJM78z4=;
  b=NFLFJGkv9cQih1tHRH54Ubn/JMeXn323wTL5mYMGdKPCfWp/K3RI+vpY
   ITWJr2+8yWSTgyE3qMZSCsYPtDXevveRGWZrnCDzIMJHOCwogVPPwj3Jv
   Ewponsu+QVFpEWlZfk6njs7/lWZdLETWa5kmeYP8XGb7sFFIBdpDQRcgK
   lMZQ3vXk/zxd+Tc2vlVlWrtvWTQfMilsmKp8hHVONdxAhBUUvhYTAfwrK
   oD8FnqE+RkUErlgXFD9vUT/1KfJ4HZiEjh0DS8BCO5IRh+IFZHuc7XRz2
   GUDdJQ0jpVUJQIHD+9ZcOT9q3CYqHifVvW8J1ha00xfywtRp9FqZKMAs0
   Q==;
X-CSE-ConnectionGUID: pLp0dDfARUO2SoYML0LEXQ==
X-CSE-MsgGUID: u6irBDOnSFOVdEbXjy/HOw==
X-IronPort-AV: E=McAfee;i="6700,10204,11244"; a="30541431"
X-IronPort-AV: E=Sophos;i="6.11,253,1725346800"; 
   d="scan'208";a="30541431"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2024 16:31:09 -0700
X-CSE-ConnectionGUID: 7yNq8nYhRwGVisdGnSSWCg==
X-CSE-MsgGUID: ngo5O3vtTMyWnF6f6bFYFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,253,1725346800"; 
   d="scan'208";a="82956330"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Nov 2024 16:31:09 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Sat, 2 Nov 2024 16:31:09 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sat, 2 Nov 2024 16:31:09 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 2 Nov 2024 16:31:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fFAH4n3VWnSCtF/0BdXgmpNs/TmfaFSA/+Bo+CONBaR7E7aN04pQwuzvze8wW4Y5DAaN210MECkmeHPRDZhsCyEKKM3+oEZ8Lp9eKjKh+Rjk4g09xEpywAtl1uwJAu9/tn4B9z/3RPxitua+HL/c8o8eO4bMucQ/RTSBpVWNuqhcikeObWaiNPnHn0o5hTOMeKi0N9MH6zxbNVU6oWsfAMxoFoQAsKzjjvFUncSTpcY7VZwGzPP5HvteVMEBSm/4BEztwq42zALcG4B4Gwl9nvaCY0wN1X6Zohu5/klglGXPfusoPe3z2lAcnQCbkYxvZy6a98/HyP0cXUHOsBKlvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e/2cAtSCWl/vD/Ya50l7FKMz2oyun6Rh8eiSPkplPYA=;
 b=etC72g8ex6Z8Rb5ZhJF7dDLaF2RvgFIbJHGr/WNc4en34VgWR9r2YucmPCTOa0qdgcQdEVDlxjZlZbDNV6Kg3xAVKUELn8qKfD14QNeAkzFF5kPz2J5RnKrTsR5eaTyjdo5cUuAyzdQWXcSmuH8MMFaHP5TjEl0Uh32C0y6p8bCtNpk3UiTml4S6Rfgj+sVOFzMw7/FZ0DE1wKfKWSZ+E3N/8iXvA/REvia+3NXm3Q5wB6ek2bFjkBhkPHu+lLQX2m9BHt3bJDfaxpm81zmfYwXbesRn4r/XBQb1dCQLA2Ob+GWkiBeHsDNQUjpv9d1GOxXSX1CVEORulWx012KrHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB4886.namprd11.prod.outlook.com (2603:10b6:510:33::22)
 by PH7PR11MB7516.namprd11.prod.outlook.com (2603:10b6:510:275::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.29; Sat, 2 Nov
 2024 23:31:06 +0000
Received: from PH0PR11MB4886.namprd11.prod.outlook.com
 ([fe80::9251:427c:2735:9fd3]) by PH0PR11MB4886.namprd11.prod.outlook.com
 ([fe80::9251:427c:2735:9fd3%3]) with mapi id 15.20.8114.028; Sat, 2 Nov 2024
 23:31:06 +0000
Message-ID: <a7bddab1-ae24-4e38-97b0-9f7467084c15@intel.com>
Date: Sat, 2 Nov 2024 18:30:47 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 1/7] net: Add napi_struct parameter
 irq_suspend_timeout
To: Joe Damato <jdamato@fastly.com>, <netdev@vger.kernel.org>
CC: <bagasdotme@gmail.com>, <pabeni@redhat.com>, <namangulati@google.com>,
	<edumazet@google.com>, <amritha.nambiar@intel.com>, <sdf@fomichev.me>,
	<peter@typeblog.net>, <m2shafiei@uwaterloo.ca>, <bjorn@rivosinc.com>,
	<hch@infradead.org>, <willy@infradead.org>,
	<willemdebruijn.kernel@gmail.com>, <skhawaja@google.com>, <kuba@kernel.org>,
	Martin Karsten <mkarsten@uwaterloo.ca>, Donald Hunter
	<donald.hunter@gmail.com>, "David S. Miller" <davem@davemloft.net>, "Simon
 Horman" <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "Jesper
 Dangaard Brouer" <hawk@kernel.org>, Mina Almasry <almasrymina@google.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, David Ahern <dsahern@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Lorenzo Bianconi
	<lorenzo@kernel.org>, Alexander Lobakin <aleksander.lobakin@intel.com>, "Jiri
 Pirko" <jiri@resnulli.us>, Johannes Berg <johannes.berg@intel.com>, open list
	<linux-kernel@vger.kernel.org>
References: <20241102005214.32443-1-jdamato@fastly.com>
 <20241102005214.32443-2-jdamato@fastly.com>
Content-Language: en-US
From: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
In-Reply-To: <20241102005214.32443-2-jdamato@fastly.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0055.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::32) To PH0PR11MB4886.namprd11.prod.outlook.com
 (2603:10b6:510:33::22)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB4886:EE_|PH7PR11MB7516:EE_
X-MS-Office365-Filtering-Correlation-Id: f5382df9-765c-478b-5428-08dcfb966c3a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VkNscnJsVkJ2RUFUREk0ZU5BbmRva2pGNUNmc0Vwd2dWVzdmS3VVZ21LWkxL?=
 =?utf-8?B?R0FjUGR6TklocFZmRHhDa3hGT2R6dTFBd3B5Vm1MRjUwckJ6THV1QUNWUXIv?=
 =?utf-8?B?akl2WFRXa1F6blJoajhVTDlRMnhtZVU2ZkVOU0ZMOFBrU2o4eGEwd293NkhX?=
 =?utf-8?B?cXhyR3p0WWZlTnVpZC9tcW1MZ2ZCaURBdmpJdlhZVFVveGhJMmxuWHZCWEYv?=
 =?utf-8?B?NlNqdnJsbVY4S24xYVdUMVpBczJ0N2xGRjlYaUpLQ0ZIblZDR1grVkVEMTR6?=
 =?utf-8?B?N1h5Y3NIdEh3VFQ3MnByY2F6NHgrcEtQclNXR1hoSHZmQlF6OWh2eksvY0Uw?=
 =?utf-8?B?cUtkU2dPa3dYM004b0NxTFhVZ1BUeUtKd2pYV0VPSGFmeDlEQjBPL1NIY2FJ?=
 =?utf-8?B?dExPL0dLd1J3UU5nS25iTjZSd0ZWZmRuTGlrMEgwOFFMcGhqajRxWFZSUGJv?=
 =?utf-8?B?MzRsejByZGFkWmVER0xwdGxkd2JDZGxmalBsSTBTSDFKSjBGV3MxR1Zxbmly?=
 =?utf-8?B?bzB6ZVpIcWtTclBCNGJ4NnRLSDVFTC92MlU4MkdpcmFEL1dmRWc2dDV2UWlU?=
 =?utf-8?B?UU9PWllHL0xrU2QzRVorZ2svNVlDdmxGQ1hMRGxzbHp0Tjk4b0NnVStwNTVr?=
 =?utf-8?B?UHRhNWxnRnNHNkdQOXZiNFFlRGp3UzRJR3FnWklSL2h3eWhVbkVUVDJ2WFla?=
 =?utf-8?B?eHhkdWd2L3dDN0hjMmsybThFeldLd2o1WXF6WDYwRWFWcUhlcDRkc1E1amFs?=
 =?utf-8?B?a2lYYlNydmpIUEhIZkh1c20yMlQwWTU0VGhIVGJWVEcwa3BCRzl1KzVpKzZU?=
 =?utf-8?B?emJ6WjBmQWtZTjNxbzFBdURTRmg3b2YvRDBSK2dydEJFNkg0blRRQ2VmNkcw?=
 =?utf-8?B?RTJCQWpkMndCNTg3N0VvbmRNK2VIODE1aEpUVHdkSDdtK25aTnVkTFZpSXE2?=
 =?utf-8?B?anphTFlWeE1sdHRJbXptV2JaSE1BRGpKcXFGT0xIb05hSm5pcGJEeUZEWUpM?=
 =?utf-8?B?YmFOQVJEUmYxdS80Y2x3NlJQcVo3UWYxNDRXM1E0OGwrYUlPb29ZTXZ4YkVM?=
 =?utf-8?B?dFplVGw1U0U5NTY1WGs0dzZtSjJJY096ZGc4R3N6eGhpWmIvNk0rbnliR0Np?=
 =?utf-8?B?c0cwTVE2QnJicjk3UHA4UEd3azJqU2svWi9vYWJUa25WaTY1WGVPR2hYVTRY?=
 =?utf-8?B?NGJBS2ZrWitEdngwa0piOUwxemE4bFBTNmduaStKQXhFeXd1bGh1cVpMMTcw?=
 =?utf-8?B?UnpwazJFTGtieXpSNmVNb1Z2V2duZXJTT1V1aUIyamp2eGp3dE1hTzhvODk3?=
 =?utf-8?B?ZGhLZzRlYUU2SWZZTHFRanU2Tk15K0YwdjdRSVRiWXRHOTUwSmZRN1ZGVnR6?=
 =?utf-8?B?dFlNdnRoSkJ6UFVKZmpIQnlrL045Ly9SditPMzJaUjgvbExTQ3FXaDZHeU04?=
 =?utf-8?B?UGxIQnp5QlpsNkF0NFlTTUMvTVV3ZWFadCtsNVNrVXUwM2p5M1hxMHF0emZa?=
 =?utf-8?B?d0hvZURPckVxYWhMdTAySkxuMEYvZUpGU3N3NCtrSEJvWXRXMWtzK2R2VUQ1?=
 =?utf-8?B?TnppbWR2djVncXlpV3JBUDhlejByZVo4bERZbTk3YUdEb0xDeUNOaWJoQkJ4?=
 =?utf-8?B?ZVF5OERxWDk3aFBSL2FtVnpzOEV4clNTcTh3M0lrYjVZalVsdDJ4TGtjWnV5?=
 =?utf-8?B?OGJvS0sySExyRDVtcWVldWFBdGQxS09uOHVDRnZLUE1tUmFlVWs0RTl3S0J2?=
 =?utf-8?Q?JUWciJxfe/0as1hd6tVBFlArEbzFwJ3m9du9IEA?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4886.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YkFOT2tZU0paN2VYckhuTy9GNzRUdSsxUTUxcVpzbWVOOHNaVldHSHRldXRx?=
 =?utf-8?B?Y3dPZElqeTZwdTM4Qjc3SUNSV2x0QytYaGJGcXZ6aVN2V1hrRExodmxCK2RC?=
 =?utf-8?B?N1RrakdCWU1jSXJobExJQVpmbVp3Q2RHMk5PNENIQ0dnM1pIR0hNVVVPOEJt?=
 =?utf-8?B?b0M3Y3l2a3phcm9YbytwaUJvdGRzSlQyOVhXb2hzNWE5TW9MaWs5ejdlSGo3?=
 =?utf-8?B?SDJtanhyOTBSam9TWVBFWFdmdTRWc0N6WmFiaWw3RVJCdm5ocElGb1N6U05s?=
 =?utf-8?B?TFIvWS9LbVhVL2xjZ3JBRmFPaFFuN3laVGZDNjEzdmVSaWtVWGk3VVZtUC9u?=
 =?utf-8?B?eGJvOFBSNWhKN1hKLzZWbTVJOElkV0o0N3hvK3JBQUFpSzBSVzY5R2Vpa2l3?=
 =?utf-8?B?cHhxN1J0RHBNQVhLNFhOQjBNNitVL2gybTFlOHlXbE8zMWFNWWhHVU0rcnZM?=
 =?utf-8?B?YUFrMFJSbkRiMW5SOXpVS2dYZ1U5RzlKS1VROXVpMjloK09Tdkt5NGh0Mzk1?=
 =?utf-8?B?UGVmY1JqaVR3RmNDVlZ3SXptK1NTMXF4cEUrR0ZvTDVLeHlieTlxQUQ0SE5x?=
 =?utf-8?B?K2RrSUlsNVhubHpicGdlZk9oUmNLYnFpWVBYYklxOS9UNzdHTWhuSXVmUHE0?=
 =?utf-8?B?YXFjTDQ2aXVkdlRkM3kwWlpNVHQ5UmNrMk9JQkxISnZ0VmZDRzJYOUY2ODBK?=
 =?utf-8?B?RzlYRjdjczcrZ3NORjQwZTY2V3FaeE9lRWFPMU5kOHhMYyt2WitZd3ZhcjFt?=
 =?utf-8?B?QWgrYmk2Umo2MHdKb3N0TTBNNEVUTHVTMnIraHZSek80UkR2L3JsN1Zxa2JS?=
 =?utf-8?B?YUZ4ZkdCVlF6Sm1OTlo5MU9NWFd4cFFaN1dUTVZmR1dLYUJ3bUEzNkt5eUlT?=
 =?utf-8?B?cUdiWU13czF6V1VwWGF0c2tBandGTllZV0JUaGk0dVpwcmg3SStOR0tZSGhk?=
 =?utf-8?B?cGZETnNWT1hLb1psRk9ocjRzVkc2SHg5bGZyNGZoQ1d6SXNHeXJoZ0pnRkFV?=
 =?utf-8?B?eTFzaHZjbm1yNXMyWE9abjJNVSs3YW1LaVJFNkp4TDc3b2pnWlpwUkpYZkpW?=
 =?utf-8?B?NkdreTNCZFkxMkhpbzJYbTFlK2hpb1NibzhmMndCNmZqTHVzVEk3Q2RTbUgz?=
 =?utf-8?B?aEh4VDNXWE1nZWdhdndoR0RrNDVFMFlDZWNZTnZTR2ZZK3hIcS84NlloREl0?=
 =?utf-8?B?RWZNRUhPdEZHL1lUWElPaHBnZGNXN3Y4QldnQ0ZUa29QczVoamJOeXhPRytT?=
 =?utf-8?B?akRqcEtIWmx6K1FieXNEN0xubmxLbTRNK0RDSExYYTlneEFDRUpqR1R0cFpw?=
 =?utf-8?B?WHZ0MHN2dHNzaUZtYTRrOWdrMEFtU0V1V0FlQ0FzclFDbEFUMEtHMHlVZ0tB?=
 =?utf-8?B?em5nQXRQUVpaclBDaThxUW1HZitDc3M3Sm1xblVJSEcyYnN0NHZDTnJjY3FE?=
 =?utf-8?B?a2p2OC9DT3p3RTRCVE9RN0dwMC90QjB4a2RVb3J6WkE5ZW0rbU4vUnR1d21t?=
 =?utf-8?B?bXloNW1ZS2NGS0dqRS9kQmsrYy96cTVoL1BRM2NsK1JCUVZEUkE5c1Nxa3Fy?=
 =?utf-8?B?Y0J0c3V1eHc2R1NaRFpqTDU0alp6bjVGQUtKUndrNDdWQlZKdDhVQ0V4dTgr?=
 =?utf-8?B?ZFc3bTFrdVkrcTY2alNzTktUK1dORm9iMGJOUklzMDkwRVdndURlMFlRRWdD?=
 =?utf-8?B?Ri9jTGF0WjZFS1dCRkxkeDdwMXNkSDBBYW12S2RsdENCOWh2TjcwcVFrZUpL?=
 =?utf-8?B?alhkL2N3MGRRd05Yelo5UVZyVXNhMnhHcSsyT0wrYlVpeWxWdkRielA3ejgv?=
 =?utf-8?B?Z1ZOU2JMaVNKZkVHQ0dXVjhrZzY0R2lkcG0vcFh0M3JRTWJsQU1vR2hUZWMz?=
 =?utf-8?B?Z1hGek1PakR1TTV4cEJPelBxZlM4WXN2SUp1c1VRSFJocnFqWlV2WFBGcTNO?=
 =?utf-8?B?bGxMRnNuL1g1azdxLzRMQzA4S1RIcWxqa1Q0MmhWL3UzZ0RjSlVMRm4xam5v?=
 =?utf-8?B?blN2Z1VmWFV4RHhWL3JJcG92ODA0WVVyYmZOSWhaUlBZQjBqSEtHMEM4R3JC?=
 =?utf-8?B?VGl2c0JkbUw2QlBqNERGSmJyR0FCVnZnN3lFVFV6blkvNkNDWm5kOVQxaE5h?=
 =?utf-8?B?SGlIdHhWMnRMVVY3UWVJMS9SditmZjQyVjhwczM1QWE5QXpFLzY4aDl0TUJU?=
 =?utf-8?B?d2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f5382df9-765c-478b-5428-08dcfb966c3a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4886.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2024 23:31:06.0788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rGygcvWojr2tbXt9KXdt3/lvLHqMM5zbaDyBvNh6rlALKeS5mTfMqGUQyxtDcjDrwnp/pubWxwrU+aEaWUNQHCHV9XxhgTJtzmNpfmGPOxE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7516
X-OriginatorOrg: intel.com



On 11/1/2024 7:51 PM, Joe Damato wrote:
> From: Martin Karsten <mkarsten@uwaterloo.ca>
> 
> Add a per-NAPI IRQ suspension parameter, which can be get/set with
> netdev-genl.
> 
> This patch doesn't change any behavior but prepares the code for other
> changes in the following commits which use irq_suspend_timeout as a
> timeout for IRQ suspension.
> 
> Signed-off-by: Martin Karsten <mkarsten@uwaterloo.ca>
> Co-developed-by: Joe Damato <jdamato@fastly.com>
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> Tested-by: Joe Damato <jdamato@fastly.com>
> Tested-by: Martin Karsten <mkarsten@uwaterloo.ca>
> Acked-by: Stanislav Fomichev <sdf@fomichev.me>
> ---

Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>

