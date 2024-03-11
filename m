Return-Path: <netdev+bounces-79193-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 966958783B0
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 16:31:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AC551C21B55
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 15:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C81446D5;
	Mon, 11 Mar 2024 15:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IT/Tcx5q"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912F944C6E
	for <netdev@vger.kernel.org>; Mon, 11 Mar 2024 15:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710170509; cv=fail; b=DjYqDCj/fOq6RfBXD3AHxSzuvu2blF7eehavlyGj+g+h5TQ+jeEcxSlZxBUQvtng9TQVoabbeHm9h/Awzv0/kvrG+V/fceNxNQUpTOTPqdI/1gLjYwSmURgVBtuyBDA0r6Ykmup3EBTXFsSX/qwEnTJyPuKfWoFzx3ZmgRlcVlA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710170509; c=relaxed/simple;
	bh=YH3lXi8TROIyFGdRvg7Zwoiu936VIAOq15dlXl4CYWo=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ALV0znZMtT/HC0+6YpJX+JCOeRLVZVwywHTPDQyeEDCyqtDbIyZTTAOgxLYS5wDscRUH6AoVMnjkFgb29VFo9tqD+TnCgSRO8jZDuam5CXG1JQca2cBUozWTbrwPidCPXbVEYsAANjJt+NuhPHREvTLqFMnePU+6CJotPmOGYyA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IT/Tcx5q; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710170508; x=1741706508;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YH3lXi8TROIyFGdRvg7Zwoiu936VIAOq15dlXl4CYWo=;
  b=IT/Tcx5qRlFiFkNjjnKdh10yv1sRpxyqxmNINvAnEFf2NZy1Ycogdx+6
   D8xFpcziWW5MHXYsYAR+3+Rl6oiAX7kd+UYk+u9mT9tW66DyazqoOOCQ0
   g1UkMOdRtAv7aBGTTAO2W9NectnBklne4+a66FMFcFJGzIl4fPd89/+La
   gFpo3DmRgmRvx5VwCC51/6zQEcT/NBlfK/+QMWtGHetDZzMdvVjrBMGw+
   dsHxrYvUTvBuooTSvjIOnOs1Y4PyhJVlL7fqdSgPP4P90FhsXQP9Zm+rX
   pa45KXkcMMMpZjiuB5LUn+QL5hJsyPFe6GksNr73SKJpJTv4Ki4LEyzjf
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11010"; a="5006098"
X-IronPort-AV: E=Sophos;i="6.07,117,1708416000"; 
   d="scan'208";a="5006098"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 08:12:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,117,1708416000"; 
   d="scan'208";a="11773967"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Mar 2024 08:12:17 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 11 Mar 2024 08:12:16 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 11 Mar 2024 08:12:16 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 11 Mar 2024 08:12:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ul0h6tU13KPSKIwXkAb81/8IbnD/yYuf7yEM3MrfkmHo+UaEblDDmtm/i2QcrHzlhCvfxIBzDjD4dcgrnIsv96DVpM7GLVm9dbLFu6luF/dH3DhfkT0zPhiU/EDhi7TWBz8wJQ8yv6GijA0nHMhERT01i5hVy25ULmpFrdexWpBlDXxZ1SdCyS+dxGDAs+G1CluZMTgX9qq/WxFdjEu2XNTvVuLKvDhB1qICjLQ3x6fWc4mP4BQrrMs29RLPrfC06v6lutTDqoaYFvhQ+vgSgKntKH780pFf83IKuCmWCT4ptGNPw3a6NqKBtaPgd+VaSZFXtm2JBpu+YwGKODGT7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aPecmhyGVGrqdlIB7r42bvT2EdIMxtkCpBZ4qmxLDfo=;
 b=KccrDSEBZlgoLik+XQkqmv1A5H/wn7/cm9Tl4ho+xhyrD5Q63jRDO/Kjx5GbJ14m6kgyyzwkzjNLCmDEm1V3usfW+esoNeQWNXeHu7edeeIFlyo+adVlXlumUxZNKHoCTqTFRmVBn0KEmTXs3hFlPoQ486MoeOh9jXli5RsAftOKH092zZZ6m7o01Nz5gmTRweTTywrjuvXccjc2N9daUcMtWHE10i1gOfoRf8BoEaoQkwIiUbG/iEU4wy4RHHhFFFK4ilnFRRp0NjF+ljC3xWd6zKZGKKFFw9pNJn/zWWIAAXC1My7XMEo2ra4GXXdkYZ0Pzb5iR0AKIcohFfe2bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7420.namprd11.prod.outlook.com (2603:10b6:806:328::20)
 by BN9PR11MB5258.namprd11.prod.outlook.com (2603:10b6:408:133::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.17; Mon, 11 Mar
 2024 15:12:14 +0000
Received: from SN7PR11MB7420.namprd11.prod.outlook.com
 ([fe80::13c8:bbc8:40bd:128b]) by SN7PR11MB7420.namprd11.prod.outlook.com
 ([fe80::13c8:bbc8:40bd:128b%7]) with mapi id 15.20.7386.016; Mon, 11 Mar 2024
 15:12:14 +0000
Message-ID: <6e397de5-5337-4e74-9311-4e4b8415c869@intel.com>
Date: Mon, 11 Mar 2024 09:12:06 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ethtool v2] ethtool: add support for RSS input
 transformation
Content-Language: en-US
To: <mkubecek@suse.cz>, Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <alexander.duyck@gmail.com>,
	<willemdebruijn.kernel@gmail.com>, <gal@nvidia.com>,
	<jesse.brandeburg@intel.com>, <anthony.l.nguyen@intel.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <horms@kernel.org>,
	<pabeni@redhat.com>, <andrew@lunn.ch>, Aleksandr Loktionov
	<aleksandr.loktionov@intel.com>, Michal Swiatkowski
	<michal.swiatkowski@linux.intel.com>
References: <20240202202520.70162-1-ahmed.zaki@intel.com>
 <20240202183326.160f0678@kernel.org>
 <cbd0173c-8d32-4e08-abaf-073db12729ab@intel.com>
 <20240221102401.4b3ad429@kernel.org>
From: Ahmed Zaki <ahmed.zaki@intel.com>
In-Reply-To: <20240221102401.4b3ad429@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB9PR01CA0017.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:1d8::22) To SN7PR11MB7420.namprd11.prod.outlook.com
 (2603:10b6:806:328::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7420:EE_|BN9PR11MB5258:EE_
X-MS-Office365-Filtering-Correlation-Id: 57a0c8a0-ffb7-4df8-60d7-08dc41dda1d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mvVsK37pCPKQ1wYDHNEunxE4BirTxReMGxYwyOxlQ8UnGs0bqDdAYjIWW2u988fCvzujUF5dngg+qSh/2TdVv10TQLOFTlkAbOeLKL2i+GVIFyG0YSB6a95Vz30ZPZL853iEbKplJqpYj6NcH7u8gKnHizMvkayjrj759KbWl/BfCfBdNk/Wa3rc8IuAo9Yxd9q8LYgdzBRIVrN8ztvF2FkdcRU9VCdlsxoOq0xtsCb7SfUEb+RXuMY90efqor+PNcS1l0g2LWF/I4Q25jEwCD1aIc6izDVUSaylxo65GmFFwGYJ8YcFxpHG5qkQjUYsqWjXNf+H/N+sE+N13iAb2pDG/v4olf+t5ju56yaHw41poqVoq7/ga/9jlE5DhdXbp1AHoV6ds2QQ/hZXlyucDJZETQM5P8vpqj17QvaVnbvqaqoSOHF1Pt1saBpb4Ajd6iHLBpxWBW2UI0q5+LD0wkeQDdStEOT5AbMFu4DkzcIi1UdEGWLS8t3mojLbA5RuOpq2c0EAdFWBK2ps03GSMWny6ExFueR2z4V3nMyu1JrPyyZ2zorevXRvdwO0868/t7HRM3QwPYJwPnOxnkq9wkLEdpa8l0fRP/73jj4Hkyk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7420.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QTk1S1d0bTErYWMwQ3RJMDZCMmthRDFSb0RUdnlweHlvVWUrVTRlRCsyWmJQ?=
 =?utf-8?B?MHI1TnI5ckpyYXptN3RlNllmQ0RPTG1BUVpGTHVHUE05ZnFPamhNMlZjZDg1?=
 =?utf-8?B?ZmJhVUFWZ0dBTW9PVnFTVTVlNVF3eDdMdDBZNlA2MVN3dWVvc2NDT01YWlYz?=
 =?utf-8?B?L2szb0NrWmxkU0tNWWF1Y28yUkRiN0kzN3dDR3VpNzhiU3NxaTZocSsxVGZh?=
 =?utf-8?B?dHJ2dVBSRW4wNEZSTC95ZG82Ny9yS2FSeVd1UWpLTXBzS2dvclRzb1RUQWY5?=
 =?utf-8?B?bER5TjEyOEdmSThiUlk4NzBTUHhhS3N2UENwSDF0VS9EeGJJS2Z5QlFiSHBn?=
 =?utf-8?B?ekhJclYvMGZpOExKektDUUpIb2RUcFUxSk8ydysrSzh4RXFRRjFqTzBNN2Ez?=
 =?utf-8?B?aHJUaUlLYklLbmJDRGw2K1Zwelp1VWc5YjdVVzdEQzR0NjV2Y0lOazBUSlFa?=
 =?utf-8?B?SVl5QWNGL3Q5VkRBWEFObWpKQzdzcFEzMWNWck4vQjNKMVdwZWhIb2o2WHkr?=
 =?utf-8?B?VWpSNUZ6amZKbTVISmpYbmszNUlEeGwybXlZRUJNSWdDUVlkUUlnVzJIbVJ0?=
 =?utf-8?B?RlBNNU9zZG4raWZyeFRNU0IrWDJQNExFUjI1M0NBSWtHQzdoUXlyRXJFTmdF?=
 =?utf-8?B?djY2Q3V0NkdHa0RmWTJYSkNmQzMzNkRNeUVpUEdDM1BFNDN1U3NFREdyUExF?=
 =?utf-8?B?ei9SZm52Mm5aVVQ3MEpFRkdtN1h4UklRRm43VS9Ub3JSSU40MnM0a0hOWkVP?=
 =?utf-8?B?dzR4Vis5OElnNVZNZ3A1UFdabDVFTUwrd2lZWGRDMGpEUHduYm9VOWRSczFa?=
 =?utf-8?B?cm1MTjJqbWNNMlpPdm44YzdnclBjWXk2NkxEQ0ZpYjBmRFNnSHV1b25JcDI2?=
 =?utf-8?B?bGdzRGp1dmxZQkxFTkJodjhaRlFDUWE4RmtyVTlJdm5pTTdKOVMyTSsySmpE?=
 =?utf-8?B?SVl4cFliWlNzS0tTSWRyeGVudnk2WHNVb0RIVExaU2tNQ09lakwvT3RWemky?=
 =?utf-8?B?MG10bzlEOHpXRTI5RVJhVVdpSjB0aTk3NTNvTXo2bjFLRzIzVkpCMlZYYUJM?=
 =?utf-8?B?YjRWTFd1aGM4QTNwM28ydEpWcDRwZHByNngvL2xXYjJLL0wzMzJzQWVCUXRm?=
 =?utf-8?B?ZFgxVkEyWnY5SHBwZXRJN2tmSVkxQk5ONE1oWmtqTzI5KzZ4a0xUVUNsMitX?=
 =?utf-8?B?cDJCUWNvRWEwbFU1czJqekJ2aGpNRzBucytjU1dMNlAwTXpaM2lrZGRaNjlO?=
 =?utf-8?B?WVBqVTdkMlpBdVBEQW1sdzVzRVZpc1BXYXBPN2tsdGxpY3JTRWpkM0c0T1dT?=
 =?utf-8?B?RVV2ZmM2dzBUajRzSWhrMnIrdWtua2sybDNwSHVwdDVNbGR1Uld2WlpWRisz?=
 =?utf-8?B?aDZhZXNnNzN2K3pCMEJYM0NxS3M4OFdKQ04yOUF6eHMxU0s5bmg0VDVkRTdQ?=
 =?utf-8?B?N250SDVKamRCRWhVOEZ1dzI3b1FDMC9jU3JQR2ptNG0vWHpiUldkZlJzamhX?=
 =?utf-8?B?cVl0Rm41WXJjcU1BUFd2NHo2VjVzV083aWhpb0NzL0R2Skw4NlR5UUs3ckx1?=
 =?utf-8?B?eUxzTGFGUkFUZnpld3U2NXA3bWJnd0dWbHQ3ZEx4YW4wSXhFNzBoemgwUjlU?=
 =?utf-8?B?NVZpMFNCQ3N5MnBwU0ZHY1poQ2hLcnhvcWtlcGtzMlVrai94S2NnUlY4RHpQ?=
 =?utf-8?B?OXNXTDlDZUZjdWZvSk93R3d5WGNXRWVRamg4clZEYno3ZHM2dmpQV3hwcGpF?=
 =?utf-8?B?TWgwQUxtZDBORE5ScTRTei9xdTUrZFBTaDZZOFBSZHN3SC9RemFsT2QyZ0o4?=
 =?utf-8?B?SXRLZFQ2bzMvcGhsenVRNHFnRUJXRVlycVIrRW9hTld3OTJHWU9mbTNQdUNx?=
 =?utf-8?B?VlVQM04rYWZYWkh1WVVheXNoN3lQNHRST3E1d0VaQ2lqdXdwSVgwOVhhSnJs?=
 =?utf-8?B?SXdQNTA4R1UrdmFCenIyZzhjR2ttYnJNNGE1Q3k0U29uZlZOVDY3WS9LcHpI?=
 =?utf-8?B?MjE5YWFZUjdRdkc1UzlpUWNwS2s0cVIzUXVuVkZlWjlpVGVOcVRwQ0xpblRF?=
 =?utf-8?B?MGJKNkd5czdoMVdCcUladE1hTXhTM1E0VHM5NzU2RlltckM4eGxPZENCb1Fk?=
 =?utf-8?Q?33xrEYnyusRH/gi4VL2lxEFy2?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 57a0c8a0-ffb7-4df8-60d7-08dc41dda1d5
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7420.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 15:12:14.1086
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B1YGGNs2SAqc0V5uh3c3/nK3KgGGp1Ol8YRbGF3YeBYfkiALXoa0yL0YM/RWIXUYcrg08K6wj50BKSEPaS5tug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5258
X-OriginatorOrg: intel.com



On 2024-02-21 11:24 a.m., Jakub Kicinski wrote:
> On Wed, 21 Feb 2024 07:54:13 -0700 Ahmed Zaki wrote:
>> On 2024-02-02 7:33 p.m., Jakub Kicinski wrote:
>>> On Fri,  2 Feb 2024 13:25:20 -0700 Ahmed Zaki wrote:
>>>> Add support for RSS input transformation [1]. Currently, only symmetric-xor
>>>> is supported. The user can set the RSS input transformation via:
>>>>
>>>>       # ethtool -X <dev> xfrm symmetric-xor
>>>>
>>>> and sets it off (default) by:
>>>>
>>>>       # ethtool -X <dev> xfrm none
>>>>
>>>> The status of the transformation is reported by a new section at the end
>>>> of "ethtool -x":
>>>>
>>>>       # ethtool -x <dev>
>>>>         .
>>>>         .
>>>>         .
>>>>         .
>>>>         RSS hash function:
>>>>             toeplitz: on
>>>>             xor: off
>>>>             crc32: off
>>>>         RSS input transformation:
>>>>             symmetric-xor: on
>>>>
>>>> Link: https://lore.kernel.org/netdev/20231213003321.605376-1-ahmed.zaki@intel.com/
>>>> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
>>>> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
>>>> Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
>>>
>>> Acked-by: Jakub Kicinski <kuba@kernel.org>
>>>
>>> Thanks!
>>
>> I am not sure what is the status with this. patchwork is showing it as
>> archived.
>>
>> We are close to the end of the release cycle and I am worried there
>> might be last minute requests.
> 
> patchwork auto-archives after a month. Michal, would you be able to
> scan thru ethtool patches at least once every three weeks to avoid this?

Hello Michal,

This was auto-archived a while ago by patchwork, but it should be 
included in ethtool 6.8.

Please let me know if you need a RESEND or any other changes.

Thanks.

