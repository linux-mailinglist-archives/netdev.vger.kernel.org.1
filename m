Return-Path: <netdev+bounces-122214-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB7ED960645
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 11:53:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CE241C221DA
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 09:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC8351993BE;
	Tue, 27 Aug 2024 09:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nbMuZOOi"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63DB82D91;
	Tue, 27 Aug 2024 09:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724752400; cv=fail; b=NuZhZnJp96bDk31G8xGC5A8Sgu+e9W18c1unly9Kpo5XrhjAAmevF9e1XUG1g5N/kOrk+mffd8k5XCN4tIz8ZhSJA8poL49BuiKoOI5ruCZr73FpHx6Xlf2R/WzYK8cZg8SBVkdxk5sAnj1YedNiE69fUoN7XC2cTa05BWIdWhE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724752400; c=relaxed/simple;
	bh=QNKejeiYEC7EVa5DVsH9C45a8PYuyyxCT05ufQVG9MQ=;
	h=Message-ID:Date:Subject:To:References:From:CC:In-Reply-To:
	 Content-Type:MIME-Version; b=n0gM9MdHyl24LaWIU1pkyGf4QE5BLQISc6pehCB7XpNX0O4SlQpLpvtRKXoiDnznz1VgQBcIt1ylc+xRuUP+UePPwnMoKhdxmf7YW0kK+cL6MOWayx1XQXY/uyLzijXAysR22KgwAvwg0WqO3shn6K26tJqws+AUKTSB7C+Rrq0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nbMuZOOi; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724752398; x=1756288398;
  h=message-id:date:subject:to:references:from:cc:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QNKejeiYEC7EVa5DVsH9C45a8PYuyyxCT05ufQVG9MQ=;
  b=nbMuZOOij9S6Abzx/2lLOZ1mr2rpVHGuH7iNvbWC7rkryQ2qggS4jJx5
   wlZTGStKoDGxP4FzbDcTAGmbnKFKDrI4P3JIKsEc3d0Q82kCL3aa1cPzJ
   3eh7qH5aP2XnxivrYGim/NMWM4o4kOJ+VTXmmKo3RZl6c5JnvW4ZpVwY1
   KzqDL1/js/eWvneW91jqO4TUiEiZAaIzZS6HwCqL5eHMRr3LBiHs32WHR
   4ptBh7yEtgEKV0p6JWFweMRnE5m/9gSs85mPUr5K6ZcSR0fFsav7+4F1+
   exQmhXCbNak7HRxCKzElpByt72GO8HAaQaD9LSVA4vsDH5bNdo7zMRTvJ
   w==;
X-CSE-ConnectionGUID: wPsPs9yVQemuTsPspTcZ7g==
X-CSE-MsgGUID: 7ElfCpqrRnKvtaUYk91Hdw==
X-IronPort-AV: E=McAfee;i="6700,10204,11176"; a="27015457"
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="27015457"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2024 02:53:17 -0700
X-CSE-ConnectionGUID: 4xNnjKmTRdKZEmailLVHnA==
X-CSE-MsgGUID: Zh6PgViMQku1d1Yhex7v7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,180,1719903600"; 
   d="scan'208";a="93606543"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Aug 2024 02:53:15 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 27 Aug 2024 02:53:15 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 27 Aug 2024 02:53:14 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 27 Aug 2024 02:53:14 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.171)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 27 Aug 2024 02:53:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l/Ph+TlPQYuhI5wmYNOBliCUkqXfnUEhHCNAozjVjqWvl5i24CzipiQLTWsBMiwMpQbb+xhb9Ac84GzZi7+t1eTpxJG+P/Y1ESEkKTGlN8sd44vGqTVQV0suWVLH9OFgIG7sSmqjTO+zN5j0Xer1I5IOqyullD5fcrahC5Qnw1/0Ni6eakPg+v/W9z3z7Oj3QOnFgpFBPITFW/ejgeCiNC0mKe6ilE19Bo+uGdzTcWtLbRkrm2cvYaEsYAX86k30P1IyjyFlOfJfNVKHKXgzBiiXzR0ayDTn2Fz5mJJZGfD5lGxn6Y7muBBQjxpVA1ZhIQ1OFMcMdN0u37df+W7vxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qS8XsqHAUSvJu125FjYwFmNuJh2phon+C9OWir6afV4=;
 b=oagulnyzVaTEjctIx80LB5ayWc7T8Oy4TbRnoyrnjEcLLVVLRCKXCu14Vl4Atgl0LFko5Tma5OuvMIfICNDlY/sTAGEwt3gk49OTDBb6BUUXYaT4r/JocgO0RZCg7ruB09YzZIYLt05yrchRgWBHv0LIzz+Lcmwgmqc9pSrKo5eF03Ip6R/TT17DLb2t1ffQH+RM31B1TBerXjGZDlMBd7UUgDMCTHAfU/JwqX4IrKfN8xOkNFCUHui83w+1mglv7bSQ/4dYT03CSXBqUqvf54qK898b0qoBZPgra2wgCSEtgpx0QO7lHVAM0AlFwBMCJx1xuRdF6sP5rodqn1GOBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by SN7PR11MB6560.namprd11.prod.outlook.com (2603:10b6:806:26c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Tue, 27 Aug
 2024 09:53:00 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%4]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 09:53:00 +0000
Message-ID: <51b220a9-3304-4baf-a2fc-8da8d765aff7@intel.com>
Date: Tue, 27 Aug 2024 11:52:53 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net] ice: Fix NULL pointer access, if PF doesn't
 support SRIOV_LAG
To: Thomas Bogendoerfer <tbogendoerfer@suse.de>
References: <20240827071602.66954-1-tbogendoerfer@suse.de>
Content-Language: en-US
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
CC: "David S. Miller" <davem@davemloft.net>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Daniel Machon
	<daniel.machon@microchip.com>, Dave Ertman <david.m.ertman@intel.com>,
	<intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
In-Reply-To: <20240827071602.66954-1-tbogendoerfer@suse.de>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P195CA0087.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:59::40) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|SN7PR11MB6560:EE_
X-MS-Office365-Filtering-Correlation-Id: 6154cee2-6b02-4717-937b-08dcc67e08ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?M05MZFBqT1kxZFFrY0M4V1EvRGwvdHVydDE4RXhLWjhtNE5zNzBxajZLSEtn?=
 =?utf-8?B?RkQ2N054RU5GQmRvU3NOcGJ6VTJwb3BxaTJMdGZ0MzZaVXVjdXdVUUFkZTNU?=
 =?utf-8?B?YzF6eTErMGpTVEhsNGVwckpRVzFhWWtQYSs3QkxlZzJ4aDM5czltVGFPY00z?=
 =?utf-8?B?bXdoa3BkN0d2eGNwYXgvdXBwTTllSDEvWEU0WVZaODZJLy93UlE5SndiU2hq?=
 =?utf-8?B?cUlqcFFkVmlCUFJiSkoyZE1aeVkyWkh0ejVtQkUyS2o0NExKSHEyZ2NnTHl2?=
 =?utf-8?B?SGNpcXRWdDhHYnFjZ09TR2RSQk0xWElBdGxpNXV5UHdHcjN1a25TdEVmTjlM?=
 =?utf-8?B?Y3Z0cWJqY1BRVWlwanFaRkJnUWlQaUNHSkN4WGpUUmU5M3NyRVl6K21PVHZH?=
 =?utf-8?B?ZWxEd2VrbC9MbnlSaFRHeFdyUWxNNmhUZTZVTVYwZ2VlN0lhN2pwRmdJRE9H?=
 =?utf-8?B?eWRGeXRZMFFIK1ZJalloVGZ5UVhMRWxTQ2J3R3o4RWtkRG5ZWk02cERUdWFS?=
 =?utf-8?B?VitocXlEd243UGFlMC9zS3N1aDVDNnF1ZWRRUG9LaGZ1WGtlcUMyMzdrS3hR?=
 =?utf-8?B?SG5SVFhPN01TVHJMdXY0enQ4VXhKTG9ldUlmRE0xbkpJZXdTVFBiR1JnTEhv?=
 =?utf-8?B?QVdwVlpzc3JsUG5FMEprQWdvNjRuSVRGeUI0aFJSRW5yd1BNbmd5T21Xajhh?=
 =?utf-8?B?dGtoZDFBeHJtdFFlRzgwamFQSUdrQkd6aVZVNEFvZ0lJaUFsazhwcHFaZnlR?=
 =?utf-8?B?TWdpM2pZRFJoeldNaG0zSVU1MlpJU1Z6OGk3VXN5Y0lidkNTWmJHYzdqdFdk?=
 =?utf-8?B?czFjYlk2MGIrcGVYR0NoRHh5S0ZXTVliTkdqYTZoU1RkMnZFTGVJdFlKdGR4?=
 =?utf-8?B?YjRIRndCOFdJT25aMmhMYWk2bk5zaEh4bmFPemwrTzllMHNPZEw1OFVCMGtM?=
 =?utf-8?B?NHZrdkN6YXRPcVpLcWFEdWJXeDZvd1lkalFycEFFVXNiVnhRVEoveXk1T25T?=
 =?utf-8?B?REFEUE5jOVdHWDJHSjRVS2pETXNMSnJQbURuZmhEQmxwcWxabFlmOHNPMExL?=
 =?utf-8?B?UWZPWld3M2J6TDMwSkcvS2VmTUVLUXpDS1Nnb3UwUmxYN0JvR0R4U2VrZ040?=
 =?utf-8?B?aE5EanVyQUlZUTdMNXlWa1ZJMlBjR2JySkdUUXBmL1kycVJVcFJGTkNlNUlN?=
 =?utf-8?B?UzhHNVRmbEJpUGRkMmNIM0FYcmJxMGE0R2plTjBEZ1E2RE1WRWYxeU5YZEp1?=
 =?utf-8?B?WWVtS3hsTFV4a0V5ZEowYmFMOGpHMCtXTno1dWFGVm9kRWl4bFJKZm5ZSU9l?=
 =?utf-8?B?SmdaQlJYdnRqZHlKa1A3NW10TEZXOUs1dmh4eFRZeUU5UnZMa0ZpWDFVSjFD?=
 =?utf-8?B?dDhYaHBjejVYNTlkcXJNdmhEQWVidjB1eCtLc29vK1lTZW5JaXlZcENXRkl0?=
 =?utf-8?B?M3YrQkJiSkRPVDlraGdzZDU0cWdDcXlGeXpWUkNiQWpNRXdUNmF4dTZ2aXda?=
 =?utf-8?B?Zm1MaXlHakZURFR6dnBjRDlNZENTWWE2M3hXVWF6VTkrTHpoWTY1ejJqVG83?=
 =?utf-8?B?YllzOVdQQlFmMmdLQTlTaWYwZFJGLysvR2xKY0dGaWtBcW5uK1liQmhkUWkx?=
 =?utf-8?B?eDRlblg0dDIzU1Z6QVV1VkVSSUZlZXJHN0lNSmE0blF1UXNCVWp0SFk0U3Mw?=
 =?utf-8?B?aXA2SWhkWHF2dG9Sb21MWFZXZEpsZU9VQ2t2aFEwQ1ZPVGppcm9NVGlHMmRo?=
 =?utf-8?B?bzZRQnFXaGcvdUZpQ1hORXIxcTlkV2FGNEN3bFY4Nm9RMlRNd2FQTEcxWE9w?=
 =?utf-8?B?OG1IRGwvL0YzUHdpWTRndz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cnpGSWcxSVJMNm1jL29YbWdJc3A0emdNc3ZQZUlNQTN2SVE0U0kwSHFITXlN?=
 =?utf-8?B?KzhBREFuVGVGVGdnNzNEemhzTEltQTFsZjZmYS95Z1hNUi9sRGVtK0xndC9G?=
 =?utf-8?B?K2xxamVzcy9xbFI4dzd1Q3lwTit6TEZRS1F3ZDZORVppSHhPOUNmS1NoZXdt?=
 =?utf-8?B?RjJCMEZOMXMxZU5nWWFKczdjMk5iWjlqVkZPeVY2OTVMYUNJelJEdDd4TXNL?=
 =?utf-8?B?TXBMVXhKdE52RXdoSGFERUQ3MDFyNDVSZnBmcWlaOHVuWlVSUTlNNGV2ZTR3?=
 =?utf-8?B?OGRZWGthYXZrNU5aM0xBbDFhcS9UeFNOZ2gzeWdQbGU4ZVVET3A3WlFvQVAz?=
 =?utf-8?B?c0tFTjY2bVFQVGUyMHlLUFVJZVZSaEFLd3ZVbGRYZ3NsNGNkUGI1RFFadG9L?=
 =?utf-8?B?WEVialdEZjJ3czFkbE9tdmdwYjB1RnU3bGl2SXh4bEY1b1RRT3JxVFZvcDNz?=
 =?utf-8?B?TjVhbjFZaWJZWC8xQzNHWlRBbnRkdEhSamNsTUU5Mzd4MDJRdWdUTjV0M2Z4?=
 =?utf-8?B?Rmc3ZE8yUWdyUythSlZ2VXoyakgxd0x5bEdnNExWdjNLQ2QrZWhzelV4RWh3?=
 =?utf-8?B?dmtrOE5FZDM2SE90bTA5ck9zaEZJQkxzWmMvaWxOYWtPbFFmVEdPYnBXcytT?=
 =?utf-8?B?YVUxdnN5M293SHpJRlVyRXJ1WTVXWCtjYWpBUEIxV09PbzM2MmZkaElkUS9L?=
 =?utf-8?B?R3kxS2dFSitFSUpXOHpNWkNzNEtld2xNbklJTENndkhncHBkcjdsSkpHV05o?=
 =?utf-8?B?MmZYWFd1OFVUZ1NGUys4OXlNUmlUSzJvTWxXZ3hBOVBtcXJXR01jejVYKzg0?=
 =?utf-8?B?RkpQK1JJNk5WcEVlc3ZaWFhSMXlNTnhGYndpZ1FvVVlLM3RaZWtJVjFiOFJi?=
 =?utf-8?B?TUJ4TDRsT1pSTTNBM3JTUTBsV1dqbmZiZ2pTQnQ4blVDL0RRY2NhaVg1c1k4?=
 =?utf-8?B?MlcvVTVhK2tHeWxGMVlEbTFhaVBUdCtMVHZldHNtUkJ6T1ZVQmRYUG1kaE40?=
 =?utf-8?B?MHlmb3E0aUFLUVVuKzRmUWVJRUVCcGIzeTVxdFYwRVRGREU3NGd0c3dCZkJX?=
 =?utf-8?B?SDV3bStUd3YyNUZVbnc4L1paZG0zREpWb0dUK3V6bEhaZ1FyN0d5emxRN2ky?=
 =?utf-8?B?VEpnVFRhVnJtallHODdOTldmRDlvdFNyRDVMS3M1c0s4bEFjRGNzTy8yL0Yy?=
 =?utf-8?B?VS95S0VDNlNhUlhXb0lLYzgvaVNpVTNhMmNXSFpZdk9jQ1lGeTVpTEhaRThS?=
 =?utf-8?B?bFcvYjZCcnlESitjVDBwR3ErSk9RMFU2K2xubUlpQnp6L3RTbGY1TkZHVGI1?=
 =?utf-8?B?YnNzSGc2WlpsWHlzaC9DRWRYU1FzTHJXQXpiMFh3TFJYbzJJeVpiNzFhejRr?=
 =?utf-8?B?eHF3Tzk2WWNhc0Y5aWdYd01GNWNEaHd4bXEydktSVWp3K0FTWGhPSEp6T0pH?=
 =?utf-8?B?dWdoa2tPaWN0YndiNEJORFdDM2tMU3ZqZExBWkJYTm5JY1RKZzVyeC8zUEZs?=
 =?utf-8?B?ZnpaME5xWGVubzRIaVJKVW4rSDRBVXVLUTVRMkRjMTlUc0g3WkFnVktkT2Jy?=
 =?utf-8?B?ZEc4R0JpNU1sQjJxbkJ6Z0l3bmx2NG03T2M0cFpzYW5tbDEyREdraXlaTHVq?=
 =?utf-8?B?a3lLTWluQ3FzRDdxWVF4a0ZZMWZSRWlSbVQzRk9kWFJMQWFrQnVhMWdJUnEv?=
 =?utf-8?B?Y25sL1Y2MFlWYkNmTVZ1V2JWaGtsQm1xSjZwaFFoUGh4Yy85SEgzRG9NWjFD?=
 =?utf-8?B?NzVRUnA3dURMU1hSQVB0NG1jOU1jU25FdUJOTkZQTHowSk9DcG5ja09oS292?=
 =?utf-8?B?ZzJ6dk5ERkdKbWZIa2NHWDZraHFrOElwb1AxdmdQbDdHcjYrNW9uMzQ4U05M?=
 =?utf-8?B?blNiUFl3N1RIUVdneksreXJuV3NYaVdmVEFBWDVtREJJaU9vZnRCNzkwVjFv?=
 =?utf-8?B?ZkJwa3BaTWpiWE9rU0ppMzN0Ry9zMC93VlY1aElWTkJDQU4wV3M5M0tjdUZq?=
 =?utf-8?B?d0JRWlFxZTJRK2NYRlJxbmNqMjdFQmtPdUtpUlloRHV1OHh2ZmtoMTk2RUZj?=
 =?utf-8?B?dzcxZHZwZU1pdS9DTzkwdHdndG5TOGE3Mm5jTllWUUVuUU02Y2hiMnF3U2I5?=
 =?utf-8?B?enUzRHZLc0ZPdmxlK0Y5c1VpZGJnV0xydXJGRjdaOUJEYlBudkllNG83d284?=
 =?utf-8?B?MVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6154cee2-6b02-4717-937b-08dcc67e08ef
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 09:52:59.9752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JL/z7LCrfXmd6gJbWRcJOOQ59xPWm2OjjOPZ0bbZE+z1SQ75yYgK21Vl93LIcYNhHFryWwaC4krkFSSetu+hCbXI/mpjOV3hPWlgNve7rOw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6560
X-OriginatorOrg: intel.com

On 8/27/24 09:16, Thomas Bogendoerfer wrote:
> For PFs, which don't support SRIOV_LAG, there is no pf->lag struct
> allocated. So before accessing pf->lag a NULL pointer check is needed.
> 
> Fixes: 1e0f9881ef79 ("ice: Flesh out implementation of support for SRIOV on bonded interface")
> Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
> ---
> v2:
>   - Added Fixes tag
> v1: https://lore.kernel.org/netdev/20240826085830.28136-1-tbogendoerfer@suse.de/

Please see my reply to v1, unfortunately sent at the same time as your
v2. The fixes tag should be different. The check that you have
introduced here repeats the check in the only caller (was not effective
though).

> 
>   drivers/net/ethernet/intel/ice/ice_lag.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_lag.c b/drivers/net/ethernet/intel/ice/ice_lag.c
> index 1ccb572ce285..916a16a379a8 100644
> --- a/drivers/net/ethernet/intel/ice/ice_lag.c
> +++ b/drivers/net/ethernet/intel/ice/ice_lag.c
> @@ -704,7 +704,7 @@ void ice_lag_move_new_vf_nodes(struct ice_vf *vf)
>   	lag = pf->lag;
>   
>   	mutex_lock(&pf->lag_mutex);
> -	if (!lag->bonded)
> +	if (!lag || !lag->bonded)
>   		goto new_vf_unlock;
>   
>   	pri_port = pf->hw.port_info->lport;


