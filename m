Return-Path: <netdev+bounces-153519-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7ED39F8769
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 22:59:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 368D516EF72
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 21:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 897B01C5CB6;
	Thu, 19 Dec 2024 21:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bZ1jbZUH"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0BD8F6D
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 21:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734645565; cv=fail; b=eTdhYMvvU29zRt4LgOhQj72/MOkUGC1BjGbYJbUj62LCSDenF+IMhn6yFvrJLkGIEcq9PtGZrVm9/6OGOJprOEom5W8xjnFNOuKP7kc8SsOoxrZtZb5XjhXfcF9p6/yMI0bCFA3VFcBvyPB9Vq/INbzaVIuYDD1hYFlbw8+XVg4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734645565; c=relaxed/simple;
	bh=EDp6XY1cFhBGRBUJrhgYYCo4p1ONIoB6a5o0uIGE76I=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LvxS9DklViy/O23jbqpMkqDYTtacFDuv890cGryfFSYTDbOmNrTjWg9YoWdnegv2u7nkYxPLG9mkxdWWbbWUfXbiWcFoYkEroSgHZUxgI8KjWoWs5TxVH3tXfwdhgQAQUby8TB57WfA1NKtgDiHHL+u3BLRVcLMZ2guShEelID8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bZ1jbZUH; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734645564; x=1766181564;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EDp6XY1cFhBGRBUJrhgYYCo4p1ONIoB6a5o0uIGE76I=;
  b=bZ1jbZUHlL1+TcdrH5a3tU3yJYXoLvm3WWNPIG7vbyOfnc/pH/+F7h5B
   0Le668qd5nbIEPmjgBtuFN+/cxlK+PmEDfAQdg+HXsU1Y5yn5pPcK2OQV
   MffcZT05dGrPb3+WX0CXKPfgd3z5xQK9ePOoz7Ytr4Wm1+DYEIa56i+gm
   5TYUWL9LHUuDClWEPOPTTGe+Pv6bTVvBHWxZa4mjrerof0WAmSLsc/h7G
   GDo+s4FOCiilPgHpwTl4nF8OhRuYAd1PWAeN433RoiNwUM4OWEHZl1BHZ
   aIAAnd0nxgEM4tBuTjX5GyN2JabzmMIBXJXEfdEtgZdSf7ZUzOLc0QOIt
   w==;
X-CSE-ConnectionGUID: 4q6d3DhkRx2ixh3xjJWHgA==
X-CSE-MsgGUID: Iqvgk9+mQSGq3jjHny3VmQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11291"; a="38867739"
X-IronPort-AV: E=Sophos;i="6.12,248,1728975600"; 
   d="scan'208";a="38867739"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2024 13:57:26 -0800
X-CSE-ConnectionGUID: an/B4K3wS+6r4dU30VreBQ==
X-CSE-MsgGUID: o8wtdWiVSBCzS/xubuYvQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,248,1728975600"; 
   d="scan'208";a="98162331"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Dec 2024 13:57:25 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 19 Dec 2024 13:57:24 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 19 Dec 2024 13:57:24 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 19 Dec 2024 13:57:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RkQ9V0VLYBl/kfVyqYy+GIxuKpTHiu6FpZDRng8SvD7C1Fm4eyWxt/9ikajYaTiBYfAnCEb+z8+ziKEpDujuZWRLxC5TEyjfN3r0cgdn1XJGyaVjWSWm9F80z51ATK2jIh33npV8iFSwq0ArLQtbXPgao1h3+nT4seOyGaiUzdJ7fQoNZjIovcrjGg8TeydN4ItXlaA/TsVl4BBna04i0RCgxo8iu4e7cb95YDBL1L0Gv+IH8q6c7sx8kudOiJC29UOaXgBWAWQNoydwP/WOFbsko1olvxiB8rQRJ+QJ+RrQIaiyXILlPdHS81mE+v4hCG2vkikfLJVGBJ9n07hBRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LKw4AZiuUAu5+iFEvmjnUyzHSxH65Ramhq8CB8ChGmo=;
 b=SYb/lS37hCO/CTIQi2fqEh8rNr7OuMTCtxc1pPD6Eg6XXrwAo38yPGBA3sF8ZWZ44F2YCBxZxE2EdvzorPi1ltsT214V2GoQvVcKYoBjL/iENrWayXnP9RFo6tc8TDJG8D+X23FFYKmy1UA8hmNj6x8gBBeYN8UAE0pVcgVdi/Cb7YdA8owWY7w9aClV5zO868ScJ71+2A2A8ijWUXBMbOA0mbroh8Bnrltl1jxTDi3akPNR2YAgOQGa0+szUty66z7vhRatOfecwa99ICfK/iqeRTGv3N6hyeyHV288JRfEqJ+0C9bUYs8ELGGP/O0C99Rx3sOB05L1hfA25XXyZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by DM4PR11MB6144.namprd11.prod.outlook.com (2603:10b6:8:af::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.13; Thu, 19 Dec
 2024 21:57:09 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%4]) with mapi id 15.20.8272.005; Thu, 19 Dec 2024
 21:57:09 +0000
Message-ID: <93052a8a-826e-49a1-b5d3-3fbdc0f26c41@intel.com>
Date: Thu, 19 Dec 2024 22:57:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 01/12] inet: homa: define user-visible API for
 Homa
To: Jakub Kicinski <kuba@kernel.org>, John Ousterhout <ouster@cs.stanford.edu>
CC: <netdev@vger.kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<horms@kernel.org>
References: <20241217000626.2958-1-ouster@cs.stanford.edu>
 <20241217000626.2958-2-ouster@cs.stanford.edu>
 <20241218174345.453907db@kernel.org>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20241218174345.453907db@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR04CA0119.eurprd04.prod.outlook.com
 (2603:10a6:803:f0::17) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|DM4PR11MB6144:EE_
X-MS-Office365-Filtering-Correlation-Id: d17e74b8-9259-4480-a559-08dd2078160d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?N0t3NFM5SUhnencrL2ZiZ1RqMVV4bWxpaFJpeDFWdnBzMVhSRzZpS0tYWXQ5?=
 =?utf-8?B?UGVJZk5wSkJHWWduUmluVmM2bVo4b1F3V3lVYWViQlBONG9ESnNlRG5GNnE1?=
 =?utf-8?B?U0JqOWEwQUlBbkQrSzlmWmtsTzJBUjNHTTZtZVJhNytKTExNWmtOWkRQTmJT?=
 =?utf-8?B?SGpyc3dPMmJQWDl1dHVFbFpGMUVIRXJlZVdUN2RORVFKQmoyNFZwa1AyeWhR?=
 =?utf-8?B?VmY2cWo2OUhhQU1jdzFpUG9vQS9jZUcwN3JSTGx1ZTdJT3k2STNmVTIyR08r?=
 =?utf-8?B?QklsRjY0TlpIVHpmcEV1Y1dkaGthcUEwdVV0b05hVEdqcEIyVzBpQk8wSTBt?=
 =?utf-8?B?bG5HQ3VFcmZRaUFPL1FGWElUZ0p1bXEwS2txMUV2U2xqSVF4K1dTa1NQUUFZ?=
 =?utf-8?B?dERjZ0k0Z3NlSjVPQWkzc1hhVEF2MDRvZ2Y5OE9lb01BSVRCeVJsUzZtZ0Va?=
 =?utf-8?B?blNuVDlrQ0VURHJDYnFKalZvaTZ0RjZiWkdLbVNScUNjYXg1anNsUk1zczNE?=
 =?utf-8?B?T2NpeTkzUWdJNldaZ3FiWjZ1eW4zQTA1ZG5MSDliUW9GMHN3Q1J6ZUQ1dXg0?=
 =?utf-8?B?YnBIN1YrbitlRVVEbTFNODJxTDRDKytKN1Bya0t5V2xtN011SkdBQ3hWVkRD?=
 =?utf-8?B?djNqRnE3VGJPM1FIZ0loQ040dDRadWxESW05MkwzVkxBU2tHcEwwUGxVUFBH?=
 =?utf-8?B?Vlk1UmNwY0tGb3hJYzZNWEc5cUQ4WVFnTUFJYW84YmcyVWJnVHJuY1IzVmcv?=
 =?utf-8?B?WEgxS0pGUGRUcTZQZE10S09vR29kTVRQalhZZ01rY3VWZmYrbGhCbmlrUk9B?=
 =?utf-8?B?WkFndHRDTzA0eDVDTk9keEFVS0o0VTZFU1V3a1poMC85aWhiVUtuZUg5a1pp?=
 =?utf-8?B?TnlJelRxeFJxbG9vc2tBS2EybDJjNll2bTVPOG1aTVRpZXpMVWVJbmhrbW9o?=
 =?utf-8?B?a3VreGZ4MVZQWEQ1d0trWGx4eXp6OXRyZkIrZGVRVzEyZGJGcjQzZnB5dzgr?=
 =?utf-8?B?WlBwN1VRVjh5MU5nQ2RkWVJWbnBTbkFZZUl3OG4wUVI3Q3lrQjJxN3d6SWxs?=
 =?utf-8?B?WXhtcTVmYU12WTRZeElsWkxBVFhLenZ1SXl6ZkRkOWExTU5rUUI2UzBMdkpF?=
 =?utf-8?B?blpZUWtXc2Ixa2dFSlU0YU04NGFNRW84alBFU2VaTldEWlA1Rk1QUUU2TnNi?=
 =?utf-8?B?YVBtcnZFYWtLV0dIc3MvemxFYU1ra1JtdGdSNDVFaEh3djc5TzRPTnBXbjN1?=
 =?utf-8?B?SFNvWUdScVo0TGhOTGlpTVpEcWFPaEVkZkdhQzZkSlJBeS9UeGtsV3ZZY2lu?=
 =?utf-8?B?N3VDbDBESU5VYWJHVktJV1hReVRvT2t4eE03WlhHMmZEblNONjJvQlVhbnRK?=
 =?utf-8?B?S0l5dzZjZHZjSXRGSUpoNTAzdUx1SUFNWUFsVkJybjgyUjViMGFHZzcydlpF?=
 =?utf-8?B?R0FyNEtLZk0wMEhiVGtCTTJLRzg3YXhDT3M2aVh4RjhoVk82UEx0T2dnSG5B?=
 =?utf-8?B?MlU0cnlUQUtyVW9jS0RDUUNZdXNaSE9OaFBxbm9mczdsMlpGYVlBR1ZsV0tu?=
 =?utf-8?B?SXJGQmlvYmczbU1ocExYWHdRVks5UnR1ZFZFVDBtRjVlZTNGZU9SNHppbUsr?=
 =?utf-8?B?YXhrd2dxN2wxZmJrRHNZWndzL2FMUjJiRmNxU1ZZeWZBb24yUVhNT3ByV0hz?=
 =?utf-8?B?U3Q1Mlp5Z2hURU9Dc1hEK0Q4WkVTMDE0Y0ZsbzJQM09odkFRWlE1b1ZGVEgv?=
 =?utf-8?B?WVpRYk9yajMyMWE3b3h0dE5QS1lBMWdYS2tzTHpob2x4eVlPbVNWVFFqZGt2?=
 =?utf-8?B?djJoaWdYeHV0T3lmN2luQ2ZUU2NGWnhCUEViTGJ4R1pwZHJkT0trN3hYeXdn?=
 =?utf-8?Q?hEYJ7qGyEsp/E?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M3pIeGF2TnlKczUzQWpvemJUVGw3OUVzZUtHcWpZdDZYc09pMWh5MUl0c0FN?=
 =?utf-8?B?MXVtYmZtUFB6MEIreG9hRXVoaVY4bTJWUVhyS0RYMEY4aXpGZTh4SWtYdUlG?=
 =?utf-8?B?Nk10K1dCSzVCUFJuSjV1OXRrYTlibDJ5SFhybWdYcmp2Z2lRMU95Mng4NGtU?=
 =?utf-8?B?SUc2YTZhMDU0YzZ4L0JRQm5CMUxEOHhaZ0lqSUZVQmdDYnhydWhLMkl4Q3lu?=
 =?utf-8?B?cjlybEpQRkwrZzhMTzZ1bW95N2EvemZjRUJiTkl3VG1NSUdlOWhEZlIrYVhO?=
 =?utf-8?B?NldkaFhTR1l0K04rYnV3Zk1UeVhKL052NnhHSDdlalM2TFBUM0ZwZjJDd3lN?=
 =?utf-8?B?RGFoei9jVllvVTE4eHFWV0pqeDFZZEUxaXFXUmdEb2VHa2gzRXpOaWNwWVJE?=
 =?utf-8?B?Z055b3ZFb2FkR3NUSWR5ZC9DeGtXd082VVZRWUtaNzFPWGE5N0pSdXNlb0JY?=
 =?utf-8?B?L1l6OFBFZVAzMThrM3NJRVJ3UGhHWmVBSnlvbXBLVGNCSlFyVWtraUthbU0w?=
 =?utf-8?B?Q3RzTXRvWWE1cHlEbFViL2xXczRsUHhxVjJMT0lhdms5R0ZYUi9LTE1zMGky?=
 =?utf-8?B?azJqZEc3emtCQ1h5emhsMHJpNzZjYnVnbFhrK1I0WEdTVUw4K1BwSC9ydHgv?=
 =?utf-8?B?Nitad1A2a2MrS3B1eVdUZ1ZRTVZXdklvYUN2SFBSM1hDWVBTa1JNaURQT3hD?=
 =?utf-8?B?RW82UGpFdHliZFh1ZG5MN0VLQXRzVlFHeFZNR1htR1NiK004T0MxZTMyN3Jy?=
 =?utf-8?B?ak8xdWZIMTZMeGJHUkNXTjgwY010d1lmaUpPaFNqWmI3L0dvZSs1NjNwYmxD?=
 =?utf-8?B?OFIxcGErRkh3OHp0SUcvZGFuUFhTSDcza1F0SHlzOWhtYkRoYjZweVJyb3lr?=
 =?utf-8?B?QWFOOWVPSFhZeGJsMHNVT1Z1ZjgzMXArcUdiNVFYNXUwampYREc3ckszaEEr?=
 =?utf-8?B?MHJubXY2bkFSNE9WUmRRWDhSem1aVTFpcnViUzY0ZFNieDBPb3hPSmtvWDEv?=
 =?utf-8?B?MllBNW1SN05sNmxkcjJqSURoQWxGWE1lUkk4eUxDUWN4Z0VtejdJa3BNOUNN?=
 =?utf-8?B?Y2VFTGtoakJOVzJyNmhJeDBPbyt0U2p0VHQ0MllnVE4zVUMyT2tyMGFWVW1l?=
 =?utf-8?B?eDhsOHNueUtBYitRaWJ5eXkyelVQZWxCaGpRWThPNHF4dFRueTZScjczbm9k?=
 =?utf-8?B?TmFLUjIxVy85eERRa3UvM0pET283ejIxNGp4SUh5MFo4Q25jM09Ob3d5RFhl?=
 =?utf-8?B?S3hzbmJLY2JIaGhRU1FNczFPZ3dXenNQQ1REd1dRTFpyWmpIbmJPQ0hJYlFk?=
 =?utf-8?B?WFJkb3hpQitZWm0vQ01YN1hVb0hXUnpTOUtkZ1FFVVBrSGVad240bmNaaFhS?=
 =?utf-8?B?WFZ1blNsY2dRRWhTRlJ0M29mb09Ha2lNVld6QTdhRUMza2ZaL2JKaWdvYks0?=
 =?utf-8?B?MmdYZVFFeWo4NVBXUS9EcDhOajJpdGJ5U2wyM2Z4UFNIdWZWVGF5bktSK1FV?=
 =?utf-8?B?bVhmby9maXZyajczSVltY0tIcDYzZXh0N0FaQmFhbGVwaFZ1ZXRvRUZ2SS9j?=
 =?utf-8?B?MEV3UENBd3hBVVpveUdDN3F3RVYzL3FRSi9tSyt1K0k4K0NyN3RKTndDOGp3?=
 =?utf-8?B?aWUzeDRwcE1xd2RTWjVMYS9wVVRrQ0JoTWEwNklCMzR0QVd2Rm5oTkhVajd4?=
 =?utf-8?B?LzN0ZmpEZGtiY3NuaG5qQTZrTmNidTZwSVNXVzBsdXZkSTRzd3A1ZFllNkFJ?=
 =?utf-8?B?RFRYT0NrcXpNUDVpVi84Wkl3UjFaNU1mOXkvQzk2TlF5U2UvZnkzV01ZaTNk?=
 =?utf-8?B?SUg5VDhNVGMwWGZNeWtybUI2dE5FYTlQRFQvcXpBdldZeklER1RMRDEyWWFV?=
 =?utf-8?B?djcwU29WOFhnQlpxbXJmUGtpWlR3cDBYbzNiSlhuTldXbWZaYWhLblNGMSsx?=
 =?utf-8?B?cG9yMmtPZWVyUjlYcmx1V3NKdzlzZDFHdXhmYXUveEJLVHZlVHZHazdyNzgr?=
 =?utf-8?B?R2p1MDBycldRc01PRlZSanBCQzhVZWQvVjBEUnNOeS9OMmRZSTB2NjhJdW51?=
 =?utf-8?B?MUY2aWx2RFR5U0RWaEJ2RVdFbHU1NDV3Q3ZDNEt5TkN2TytSd1pzVG55NTZ2?=
 =?utf-8?B?cC91cDgyOU10dzlqdjJUWjlBY0t4WEgzTkdVVXkvOVQySFFQQkpLLzJvaUVB?=
 =?utf-8?B?S2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d17e74b8-9259-4480-a559-08dd2078160d
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2024 21:57:09.6829
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QqrAHknl3PWdzZFt3DzzOo3taJbSITDHmuKE2siRLa7leVnUVxrh+E37amLeyExCz4aH13EZrjC+fXc2kb9Z5LLXjpX/tBQXdGWJl2qEcMw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6144
X-OriginatorOrg: intel.com

On 12/19/24 02:43, Jakub Kicinski wrote:
> On Mon, 16 Dec 2024 16:06:14 -0800 John Ousterhout wrote:


>> + * define HOMA_MIN_DEFAULT_PORT - The 16-bit port space is divided into
>> + * two nonoverlapping regions. Ports 1-32767 are reserved exclusively
>> + * for well-defined server ports. The remaining ports are used for client
>> + * ports; these are allocated automatically by Homa. Port 0 is reserved.
>> + */
>> +#define HOMA_MIN_DEFAULT_PORT 0x8000
> 
> Not sure why but ./scripts/kernel-doc does not like this:
> 
> include/uapi/linux/homa.h:51: warning: expecting prototype for HOMA_MIN_DEFAULT_PORT - The 16(). Prototype was for HOMA_MIN_DEFAULT_PORT() instead
> 


>> +/**
>> + * define HOMA_FLAG_DONT_THROTTLE - disable the output throttling mechanism:
>> + * always send all packets immediately.
>> + */
> 
> Also makes kernel-doc unhappy:
> 
> include/uapi/linux/homa.h:159: warning: expecting prototype for HOMA_FLAG_DONT_THROTTLE - disable the output throttling mechanism(). Prototype was for HOMA_FLAG_DONT_THROTTLE() instead
> 
> Note that next patch adds more kernel-doc warnings, you probably want
> to TAL at those as well. Use
> 
>    ./scripts/kernel-doc -none -Wall $file
> 
turns out that when you have the word "define" at the front
and then a colon (:) or two dashes (-) it complains (?!!)

my advice is to remove the word "define" from the first kdoc line,
as it does not happen to bring any value (the emitted doc still has
a "function" instead of "define" used as a type)

