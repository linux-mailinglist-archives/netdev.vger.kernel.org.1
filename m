Return-Path: <netdev+bounces-185642-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E02A9B30D
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 17:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36C663AA1E1
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 15:53:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A2C02206A4;
	Thu, 24 Apr 2025 15:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L9Yd4j8T"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8C0130AC8
	for <netdev@vger.kernel.org>; Thu, 24 Apr 2025 15:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745510004; cv=fail; b=stHEho99LqHRO+uZW5KK3RcpKTbTigdtzdvwDbCG9t2T5BM1esR+hYWIZ2+Z7NHhxKgQQ0MXhZtfe+Uvy0paENHDdhSEn8dlswbZVuSAyOICZP7yD4mNkhYq004S2V8oDqtni2nQz/IQ0/o+Ept7p9o03HRz0fNeEyoWmCMYics=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745510004; c=relaxed/simple;
	bh=rQ/D1a98cMxseEXG2srx0EXvQdDv2MU93kpv5Yx085I=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gu+MKXYouEf4fP8xKDa+kzSDzX4HwJtaNHi7gpEHum4UP7PIyBGpLZtUq6I3ZgwHgOT60QUI5kByOKXxdNSRopAMZsvF2IK144BKiAYLLuZD8Or55cVdE5Q7YFbMTZyp6P2/CFH6Z1WFctAL2FJowaVbsGx/6YW9V8wU9m+I0Zk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L9Yd4j8T; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745510003; x=1777046003;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rQ/D1a98cMxseEXG2srx0EXvQdDv2MU93kpv5Yx085I=;
  b=L9Yd4j8Tk6SYfpATLY7How1hFxHyWq7oqh+LWUzpPeiJA6bCpOLDf73P
   KTuCRz1fzQGX2cIxXc2KxWX9JB4bzvTp81HDTHzr4zTVqyre3zWpDB60Y
   1Hqhe6cuKF2eAoTqfvK3IkEwVhU7n3yBZ9eIAgR/bOxqwVUqpf7iuNEH7
   mdK/4hqXh34l43wmDa6SrqUeD7Yw6j5HoYRrTsNXI6pPwlnrJQ93kZlqE
   SRCGsBJyksis5sAsA2IsKRsb4GeoABm5WVBbx9fRGlBLXhp+JBY0Z7wrh
   qpTEucjmWNPeAUeP1COp6ejK/+4iYiuSsDpydDSdP9ca1hha7weZTURfJ
   w==;
X-CSE-ConnectionGUID: 1wpeL6P9QceJ2yOlnia0+Q==
X-CSE-MsgGUID: YDthipLZQ+CEE28xVw8vvg==
X-IronPort-AV: E=McAfee;i="6700,10204,11413"; a="46272936"
X-IronPort-AV: E=Sophos;i="6.15,236,1739865600"; 
   d="scan'208";a="46272936"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 08:53:22 -0700
X-CSE-ConnectionGUID: s4iUtvZgQPuTHOzft+Ny1A==
X-CSE-MsgGUID: GJNqTeDGSdm2RMUB+W7k8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,236,1739865600"; 
   d="scan'208";a="132963104"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 08:53:22 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 24 Apr 2025 08:53:21 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 24 Apr 2025 08:53:21 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 24 Apr 2025 08:53:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L1xMS2elU0ApZY1RmIfJNu+QKl5Xy8PzD4FT5Re8NOwe6nF+QVq0G/WhHm1mDbCq0FlRZmEA1XDmzjzA1GvGMvIdL/BOooDKi7Y5ItxPKn0BQxc+8/cOMNYcq6Qcbt/1zOX0hOqDsmnoVVGNS45UIwahbaRPR/8ZIwv3A1NOBRqz3bu7Z5x7dAD3rYR61a9wcWOxilLGzrHbiVtALkjPrTtp8HA3WSFblPoUf6YlsqSBH4Uv9D0G8YcaCRT1X4SP4BsjFjGwmTH5Lm2iiTBVonjtYWzjGadTCUA2wGIMzBFALan3tFvQeGXbQjqRPjx3fjyXVh+BB8usT1tvBr4lCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FPUmzmedrYku5dCaXgReodf/zR+S7YRmVssMfwceF7Y=;
 b=RxUIbiYgT1jppXTOJ9yOf3Uiees+epEVud7htm8YLtJdpHZ+/mFfGy7X3PzBjo7/YMtgfW7CEpjhR6bBsWbJAfSfvKwvGGf1cJveg3kHoSRjE2tey1pF7QWt+AcUMRQhrZq0fF5m8xpZdfpoWdAzxUXsrUnc3zG4/P4wJXVLWbmRHmRO+pGASfYTyrd4DW56ghPdTdyYMRfbheDJq7owGiZ7pcTWu0JIuiHDP8VlW9MF18eN6MLGT2KyAIootTZqDTcdYbjFHIeLNPflPULjiWpilIf5sPjccG9BxUGpvCmrnsgWqLCufF9XCybq7W8j8Ob3BN/Bk168iwnlP3hC7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5095.namprd11.prod.outlook.com (2603:10b6:510:3b::14)
 by SA1PR11MB8447.namprd11.prod.outlook.com (2603:10b6:806:3ac::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Thu, 24 Apr
 2025 15:52:44 +0000
Received: from PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::215b:e85e:1973:8189]) by PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::215b:e85e:1973:8189%3]) with mapi id 15.20.8655.025; Thu, 24 Apr 2025
 15:52:44 +0000
Message-ID: <0e91e02c-b7df-431b-b4a6-2c5bbac407da@intel.com>
Date: Thu, 24 Apr 2025 08:52:37 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 06/12] tools: ynl-gen: support CRUD-like
 notifications for classic Netlink
To: Jakub Kicinski <kuba@kernel.org>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
	<andrew+netdev@lunn.ch>, <horms@kernel.org>, <donald.hunter@gmail.com>,
	<sdf@fomichev.me>
References: <20250424021207.1167791-1-kuba@kernel.org>
 <20250424021207.1167791-7-kuba@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250424021207.1167791-7-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P223CA0001.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::6) To PH0PR11MB5095.namprd11.prod.outlook.com
 (2603:10b6:510:3b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5095:EE_|SA1PR11MB8447:EE_
X-MS-Office365-Filtering-Correlation-Id: 7572a3a3-84d6-45ec-76dc-08dd83480ab9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VzQzeUpteVpyRTFSQXFQK2swQWJ2UUFMclphaXFybWgwaWtxYmlxOXNPZGFy?=
 =?utf-8?B?SzE0TFl5REp1V29lMGZzbmtPcGtweUQ4WUgvOThGMEdnRThXRmY5SHhHK3F6?=
 =?utf-8?B?WmVtci9RSE5RUVVnWDg2K1R5SGwwMU0wZ3ROb1J0VjFqam9CZUwzSXRkM1hi?=
 =?utf-8?B?Ym5LRmdFMXF1MUlqQnBkb2dKYmp2MDNSL2dyVGZRZVFXc04vSHY5azdVQlJI?=
 =?utf-8?B?KzlJSytGNVphRFJJVzFzeGszSEJId2pFZGo2V2U2ay8xWDFwTktpNGFrc2JX?=
 =?utf-8?B?bGhIdGdTOU9qdWlFd2V3d0l0eCtOVGxmQ0t0aVlRT1JhNWxUNWxON3FaV2FL?=
 =?utf-8?B?STVFazhhT3V0TzVPSis0RkE0cWRTNHBRWU5Qdkd3NEtkK0NFSnBxVlZzYjB0?=
 =?utf-8?B?UDhyTkVDbDJTVCtXOHc1Lzcrc0pJRGp6YklRQkZDRGppdlBobEd2Vm9UYmMv?=
 =?utf-8?B?TVBRQ29lcWxySnFhUzdTWGRXYVlHZlFxQ1M5STNwdTI2L1hnUHA3c3Vob1JE?=
 =?utf-8?B?WWRLSlorQVhlRUdVK2RZUE9EL2dHUm9yOW0vQi96UGFQQTRGemZ2cGpqTzdr?=
 =?utf-8?B?MmlMQU00Ynh2SmtmUWNrbUlMbnZoRStjcUw3NFR0SmtYbFVITFRYZU4rcjlS?=
 =?utf-8?B?K1JlbnVjWnpFc2YrQUtBd3hTb0tpR1J3RmtFNStrVGhSMC9nUzVMOTVNd0lX?=
 =?utf-8?B?Y05aVnJ1K0ZJZXMyelltM0RvMU5RR3hRTndSbmxMQUdERlVMMzdHT0U5K0Jy?=
 =?utf-8?B?R2dSUVBWcVlCR3FOOWFyR0dxNWRPQ1h2YU9ZQm5RenFqTjV6RVRBeGpkelRx?=
 =?utf-8?B?V1l2S1l0ZDBRS296b09OcGowdFg3M0V4Q2hRZzJ2RGRQQ1JzZlRzL2l4ZXhl?=
 =?utf-8?B?MWhJVCtuRUZtUjJLeGJWaUZLYzJPSE1HMlliYVJ3R1htTWVNQkptUFFCMnJ5?=
 =?utf-8?B?cFM0dHk5Z1lpdkFjQXpMQU1QRnA2S3FvbjA4VzdyQXIxdUxIRG5qSzNWb3Vz?=
 =?utf-8?B?eEdQenlDWlNLNC8zTkttbEpkdTdSZ1FGRU9jMFRKVWxJY2gwa1huWVY5elhy?=
 =?utf-8?B?MEkwOFhkK2Z5ZGZXWHFxc2FDNVFsb1ROL0lRUmdZS1huQy8vY1Q0aUl4SGRv?=
 =?utf-8?B?elc1aGxIN0dnamM3RDNtS0E2NTAzRVR0U0xWbmdvUE1DbWZXdDBXYmtPSDdG?=
 =?utf-8?B?R0FzS3lGRVF3T3FicW1OMXU4SHQvUEVMNVU1U3E2bWdGVGJjQlZhYVVmWmZz?=
 =?utf-8?B?SUI1cStkTlRqeHBPbmd5Wi9vOUg5VU5TeVdXckZRRDFBdjEyOVpmaWZza3Nh?=
 =?utf-8?B?R3drSXFXa0NkUUd5cUY1WVVsV3NjYkw4clZqU1FnNHJ3SU1kNUwxcmVhV3Nh?=
 =?utf-8?B?bU1oSmJHOE9Md0Z3K2x4LzVMQXdnSzRaV3FsRi9hZTRNZjNPVXdaL202NkFk?=
 =?utf-8?B?ckxjTGVtSlZKSVpLR3FIUytOQ21rVFJwLzllY0syMldOZHp0YTRCSDMrVU1s?=
 =?utf-8?B?NW50SE42QUlGZDZMcDE4Q3ZYYW5mVmxDR3NkdGF2TjZvZTA2OG93Q1pQaHhl?=
 =?utf-8?B?K216WW5FN3FLeG5vUk9vVE1yeHBIWnZUOG1QOXBzOE1BOUVrOEZzV2ZWbE82?=
 =?utf-8?B?WVdxMDRZZG1WWXFsdTBmMzJZcU1VN0JqeFRKamRFa2ZZOFltYllqYUJkL3JT?=
 =?utf-8?B?RjdmTjQ5RHg0clRXU0ZsYm1kSk9La28yZ0lxRnhDVDVsZ0g3ei9pVTBXUUox?=
 =?utf-8?B?bHkxblF3UVZYalFSZFdBMVdnZ09sUWtZbGhOZDNDNHlUaTVMcXhlN0h1TGlJ?=
 =?utf-8?B?eWhINFRuaG92WmNITTdmYXh4K20raUFnbXZySDh1QjlIMS9VaGhxWXdKbTRF?=
 =?utf-8?B?QW11aUo4Um1JK1NXbFh6TytrTHorcjczd0dEeWlENUd0aGpFNVRieE9ldTZT?=
 =?utf-8?Q?jWEbyiBA3fE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5095.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bmZwcDZ1T09RU2IyQ1ZRcUZ3d2J0ZGNNUjBFdHFLbk9mMFNERmsxcnBycmpF?=
 =?utf-8?B?S0hXamxjcG1XQ2NxYmpQZXV0Z3JGa2ZMREpWUTQwVllxa0c1b3VVbERWMUdq?=
 =?utf-8?B?WkRnN29OMFNxR1pDeVFJbWlhYlQvNnU2UXF5V1pYVXp1cm85UWdwQytZNXNa?=
 =?utf-8?B?VTgrZkh2aWI3eTF1V2QxOFJNVXZjKzhCU1V1MDFHalFISFlrRVduM1YzZENB?=
 =?utf-8?B?dmFRWHFYQzJNMG9IWE5tc2Z4aTZ0dnBPMUZvKzlmQ3JWYXFnb0xmVzkyYjVw?=
 =?utf-8?B?ZllCR0lYT08reHVRV0U3RVY0MmJwVTZNTnJnMTRYeXYwTHU5d0ttbHFVWlNE?=
 =?utf-8?B?ZUhLRmE3UDdMUkxways0bWFNSHFlQkw2bHFuQStNcXdXOWV6NTZLeUFteTNq?=
 =?utf-8?B?S3RhT1U4TU9aYUJXZWZMMFVXYVI0VkdYVWd3bXpCS29vNFVBalVmbkZZQ1FO?=
 =?utf-8?B?dDNONHRCeFZEZW1uMGZTcWpZbm5NUmI1eUgyZW43WDJ4TmRSYzBQWkN0Z3Ba?=
 =?utf-8?B?cDRidjJJVGtvdVpVZGxoakxEcDNqVWR4ZDgvVVFiRlBmc0lHRmI2ZVdzY3ZM?=
 =?utf-8?B?Y251UUhFeUQ2RWsyY0pieUJmTGtMYzIwdVdQaVpQVUxUWlhWRkxabXpsNWp2?=
 =?utf-8?B?NlZwamVGQ3lhMWIwQTBGZFNGMGN3MlpEZE1SYk0vZ3M4NktrSWdxMjkrL3da?=
 =?utf-8?B?V0RxeXh6eEdTWG5VZEt2LzR4cjZuekk4UEEzSURBSGNsenh5YjVCdmxpZy9o?=
 =?utf-8?B?eDdHU1J5eElOcHVSRWg3Y3VuRnJFWlREVVVrRERtNmdqUWJnbzAzYXhiWWhn?=
 =?utf-8?B?d1BvWmhOTFBLT0p6Z3pBNDFzcDdrMkYzcVhoR1JsL1dCcDRNUENPTk05K3Zv?=
 =?utf-8?B?bnZiQ2JFRE04Rkt5V01VRm5RRUlWNHlCYW5qQVlaUXBPejM5dm0xbHlSSWRF?=
 =?utf-8?B?UnlzM2s0NVdPNVhYcVZxMVAycjZCbEowdzdXRnZNZ1NqYngvcHF4OE00YW5n?=
 =?utf-8?B?MldjRDV3SDA4SnRuZStsVDR1RXp3SEZuQk1FMWliY2VZT0ZHNG1zSE1QR0Yx?=
 =?utf-8?B?WGVsUXk1bkswTnpUTEE0TlgyRW9yMFQxa0t3cGpLS2l0d2lYVUI4QVArTXMv?=
 =?utf-8?B?RDlJdittaGxBZWNOV3NDR3AvcDdrTStJa0VPQmpuekdKVXBRM00wK1JTaTBW?=
 =?utf-8?B?Q2dqbForbWczYVNBTERNeU5jcElDdVFlZTRFOC9VRU5VazhEaUpHeitRSFAx?=
 =?utf-8?B?MUdjK0FTKzVDYXBJbTFjTlVIY1NjVlB6V3FWRkUzNURpRFpwZXBENTUwVnYr?=
 =?utf-8?B?cVd3ZnZxN2tCOGZGcVMwYVpWTEpMRVVpVy9LaTNEeFp1M05IQmVUeFVQVm4x?=
 =?utf-8?B?d3Z5OVNEYktFd3F2YTJ5NFhWZ29GTHNWYlBZS0F3SHdlanNxT1cySkNKUEIv?=
 =?utf-8?B?cEJweHJVcWhOLzFNR2NKUFNsWHFkWXR3dHU3NXArS0dLZDI4bUxXSTVCQmYx?=
 =?utf-8?B?ckJOdGZHWm5ZWTZ5TTVBb1dkSnR6SDJEVEFEQzNFZTRBajNYQlpXV05jUGQ2?=
 =?utf-8?B?NGZsb0kyQ2VsR29FL01pTmdUT3ZnQ0lxV25NR0dEUy9DYnhNSGFvV3BIQWcw?=
 =?utf-8?B?NmlGd2tEQzZpaTJYcEZqbG5TQzlaY1JhMmJZeXpRYlRXQ1BhazEyaTliMTVm?=
 =?utf-8?B?SVhtaEZxQ1lxdFlKbGU5Z0VmbnlTUUFVZHYxSXU4SVBEaDZkbFlmblZaRTBq?=
 =?utf-8?B?b244bkQrM3AxSnhNWGtNM0pmbE5hbTRmUkhuR0xjMUxMSGpBTnlpUXUxN2dC?=
 =?utf-8?B?ZjR5cEVKbjMrUFZoUTIxM2R3L1UzbmVoTnBQaXk3MlVBRkU5YTF6TmJwM1pV?=
 =?utf-8?B?UUdHcUZrNENLUFU5NDA4d3B2TDlzdEVuamttYit1ajUyNy9GSHA1WDIzdEd4?=
 =?utf-8?B?VUVTTFVwM1R5ZVNobVJuenI0NmdLYzlSdkYwa2ZNL0E4dHFKYzZ3VXg5ZkZN?=
 =?utf-8?B?ZUxFRXpFUEM4MlhmY3A5WDJJU0IzZ1pvUVBLeVVMSlVMTjhEcW5BK0haeU8x?=
 =?utf-8?B?UkNLRFQyOTZDYlh0Wk1OaURmSGpJVUQzWW1qa0hZcUl2OVZqS0JKN1BuNnVD?=
 =?utf-8?B?S0g2b3h6REdleGUwektuTk5JSkQ4T3lQS1IzSEZ6RVovQjN1UDQzbERtdnNn?=
 =?utf-8?B?ZEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7572a3a3-84d6-45ec-76dc-08dd83480ab9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5095.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 15:52:43.3090
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PhIyHQ7djry7+k1Dk5btgMKkEUKOZGzLSGk4Q/O6Lb9yovnB3F2Pi0yJv54fQ4OU9Rvxpyme21MtjgLi3vw4e18T+vXvFokJPlna4b2HY9k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8447
X-OriginatorOrg: intel.com



On 4/23/2025 7:12 PM, Jakub Kicinski wrote:
> Allow CRUD-style notification where the notification is more
> like the response to the request, which can optionally be
> looped back onto the requesting socket. Since the notification
> and request are different ops in the spec, for example:
> 
>     -
>       name: delrule
>       doc: Remove an existing FIB rule
>       attribute-set: fib-rule-attrs
>       do:
>         request:
>           value: 33
>           attributes: *fib-rule-all
>     -
>       name: delrule-ntf
>       doc: Notify a rule deletion
>       value: 33
>       notify: getrule
> 
> We need to find the request by ID. Ideally we'd detect this model
> from the spec properties, rather than assume that its what all
> classic netlink families do. But maybe that'd cause this model
> to spread and its easy to get wrong. For now assume CRUD == classic.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

> ---
>  tools/net/ynl/pyynl/ynl_gen_c.py | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
> index 2999a2953595..6e697d800875 100755
> --- a/tools/net/ynl/pyynl/ynl_gen_c.py
> +++ b/tools/net/ynl/pyynl/ynl_gen_c.py
> @@ -2789,7 +2789,11 @@ _C_KW = {
>  
>  
>  def _render_user_ntf_entry(ri, op):
> -    ri.cw.block_start(line=f"[{op.enum_name}] = ")
> +    if not ri.family.is_classic():
> +        ri.cw.block_start(line=f"[{op.enum_name}] = ")
> +    else:
> +        crud_op = ri.family.req_by_value[op.rsp_value]
> +        ri.cw.block_start(line=f"[{crud_op.enum_name}] = ")
>      ri.cw.p(f".alloc_sz\t= sizeof({type_name(ri, 'event')}),")
>      ri.cw.p(f".cb\t\t= {op_prefix(ri, 'reply', deref=True)}_parse,")
>      ri.cw.p(f".policy\t\t= &{ri.struct['reply'].render_name}_nest,")


