Return-Path: <netdev+bounces-75972-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A796986BCFF
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 01:50:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB4841C2134A
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 00:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A32601643D;
	Thu, 29 Feb 2024 00:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E4No8HU7"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA222599
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 00:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709167823; cv=fail; b=TvALA3WJGgzOmZATV5i+Z5MCoyrgrsuOR0yoL04HzpS1NB3sSGllkuMTWjgrg7bsm6rM5Zm/dHWfWsjMDG8Q/58uHcOwjG9936zrxwJU/zOgyyZd1UOnOC8Ux2gmLUv5wGwCcZCCOKMaiHJC/Als+4jVXFo/0JOQ3KxuNxxXoXk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709167823; c=relaxed/simple;
	bh=voNwBykk3nfEQRrW4oDnuyXib8XYoNR4A7zrptOnGbc=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=c6yYsGsVbYNgvGe6S5fTkjZbMUudSD/KKpMKuJW245pAe6JDeSXXIUzy93l22Ejb4WUIKJYlf3kSewszRXme4CcYGy/dYdA5BXukHbhTf0KwI+zfxKdn6w6XS7BFaqidJ7TveRe11qS3YeW5qbyEzqhxtGKYivlqeEMIdb0gCL4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E4No8HU7; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709167821; x=1740703821;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=voNwBykk3nfEQRrW4oDnuyXib8XYoNR4A7zrptOnGbc=;
  b=E4No8HU7uEh6pOHFMBxi0mt4OQeVedYqLBrM4AiwnsZHSD9bDQelAOCk
   HzAoNTz9SvbYNjnmUln8LQnhvdavtj9leT38dfmtVYUWsdjkO9/+szsUB
   L4QFG6vKjPwfsBlFtndbS0KUIhuCRM1rGoyNtP6PFBAh/tlRKyqrOgp6z
   o4waMYRBt+oQxwJb6tOzkHd263MReLco6/RLMxcfDqPdVG+WYlREVxptN
   f2/q+aL34mbvZp0zq+sSnEiqkeYF54ZkUIp8GN2x1OEQTd7b254l5ACxo
   DY2i5JHstzIMoxNTxXNbK/s9xx4LGik9PUI38px7tjpM1Q10H/FjkalYq
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="3458892"
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="3458892"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 16:50:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="8180538"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Feb 2024 16:50:21 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 28 Feb 2024 16:50:20 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 28 Feb 2024 16:50:20 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 28 Feb 2024 16:50:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NZDGQquwiC4geBHdIbF6pCSHt0XKB1p22Xqui8Tt9mqCI/OcuOkdv7usOlUEjiTc6YDZIkg9OGfq7A34IcMDkRsxlHEs/4K8kXcWVAQx9DL5uWDjiR4I//PxWVf6HqfIgXnRkahZnoLpRf9JMKMCH9qzv/LhYKoQoyyZ6CWwbFeEGno84rUynQ2Wd4CJKgKbfwBgty0gLJKixGt6PkLw/YCOAsOtz5eq9oxiM69L8EWU0nD/KhbXbhmVF9Hl1Uf7sqziVC+ZO+JmN2PISvdT2BHTyil4f6ojO5S2pr1xM403WyyMNk7MKGD67G5RMtnKMyCCHSMnpeTSKeTFqUmuWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n5dzT5dqVUS7GUVSSr82/HDx/N2FKkAaPDWlT4xMRu0=;
 b=CyAdtS1KnW1OuA/PxRNLXkngBZOKxSlrj9Ccczq35MiXkCgieROLY61ohwfWVx6Y/OpM1KPK5gsLaoCGUtY6AD3pn0+r6ZPouZS/XAYWMjbqnoqmsQR6QrwNOIZDJGo3oVot3y8zJO6s4Z7NlRxjUSz8MzFwJ0408Dv+hffFfp4U1sFqqq+v9EALTeyijZtlHxn4r3jnFUpocr/27rdYzvl1rjEa6Bd2ocZh4zD1ZQOuV5d2YI9kFnF6obFAF5ibtFPaFsLD83BsRLdYccyjJ5uVhG+EQsrzw5D1kxx7JgK5rkaO7bAHYJcC7fV4hlpCo/c2CXRGegwS3O57zFJ7zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6435.namprd11.prod.outlook.com (2603:10b6:208:3bb::9)
 by BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.25; Thu, 29 Feb
 2024 00:50:18 +0000
Received: from BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::9c80:a200:48a2:b308]) by BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::9c80:a200:48a2:b308%4]) with mapi id 15.20.7339.024; Thu, 29 Feb 2024
 00:50:18 +0000
Message-ID: <ced9cb91-dad7-6a7c-1ee6-ab3e2620f677@intel.com>
Date: Wed, 28 Feb 2024 16:50:14 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH net-next 2/4] ixgbe: Add 1000BASE-BX support
To: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <netdev@vger.kernel.org>
CC: Ernesto Castellotti <ernesto@castellotti.net>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Sunitha Mekala <sunithax.d.mekala@intel.com>
References: <20240229004135.741586-1-anthony.l.nguyen@intel.com>
 <20240229004135.741586-3-anthony.l.nguyen@intel.com>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <20240229004135.741586-3-anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P220CA0014.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::19) To BL3PR11MB6435.namprd11.prod.outlook.com
 (2603:10b6:208:3bb::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6435:EE_|BL1PR11MB5978:EE_
X-MS-Office365-Filtering-Correlation-Id: a9f98d07-bd04-478f-b8ab-08dc38c06629
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jGWkCnx9df/++A8jcPVqzgKecm0/v3+dPDzHpfAghJW2rE4DIB8HqjTE7LEEsCsB8h3Npoa2IHysCsIjDI6n90+wscuH+CGl2tDgNZ6drRWCt89+oJ4YTkOeTuhBjAAtfjiSnSRmAs0kQrau2nUlZUF+luA/+uguvFnUt+oXp5MncPvl5RRsxkIV2Qo22g7YH0UyY6FLzOxxnVfsOPWYISuaPpy8dEExpCzcimRuMf/+D1u0leqmETXGgF0FgfaLlet9zy5g2UdOC++uRTNgRc5olcQgM9vxWh2picQpnHPus8Me8/SjfyjwmbDr4cHV1moCPNDCF0hrbmreX/PNH7EFm9f4CKXsWD+a32RmLZM+SUOy/5XePZOWV1sa31hsA+RYDIHgG4b4W0mckr4hOJWIFmMK0XrnGVFxUfwMnQAF5w1znAHBmt25YmsufDXd49boiIwtiH2uKEa2n76SxEUzDFWYh3bNaGQFuXBHV4QDnMKbbOqim+k77ZA3wpnrXV6ncTOQy9vFTzZeH+PtDAQ4H29M1e5L/1A+hGpoOqzME6epn9RQc2fEaXRN8JXUSDPmdRDyt9+jzr7JE97zyEH6RSasDpmkqkrQ5wSeDeYAGnQrxEaq0M4lbqw3UqZykxwBHjsS4E8Af4aGASEOeg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6435.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eTl6YXJOZkV6b1l2SFBLWEh1NmZNN3Ivd2FDZFpCbFNsZUVHRUh6cWNIeU1Q?=
 =?utf-8?B?Z01ZakxlQkZlWU91WkloNVVNbTJWbW9VbVlveThKT2Q4RWVIWXJBMGM3ei96?=
 =?utf-8?B?c1J3MHJXaDM2OHd2bjdZUFU4MXo0QWJtd0dsUWdFTGFnN2o2aTRpdzlXeTJl?=
 =?utf-8?B?YjFXYkFtMndWZGxiVld3WHBCYjdXNG50U0lhVkNraVVRUW1lUUpOQ0U4TDho?=
 =?utf-8?B?Yzl2LzAwOG1uUks0U3YwbUY4OHhTUkdsdUNBVk1NaU1kQ2FmNmJBUVl4WGNo?=
 =?utf-8?B?bEdDc1lHaGNPNVM1dDVvN0NRZTI0dzBzbms3UStnNWtNV29XMk5DRjV1VE9y?=
 =?utf-8?B?d2JSaHp2d1IySFcvN0w5cjA0NGVKVURIc2NqTk1FeDJPRlhCT3BDNmIzOXJh?=
 =?utf-8?B?cWVzMWF6R3FhYi9GSktKYm1QVzJrNXFmTVNaRlRMb25hSjhZR1lqSFZDN2pZ?=
 =?utf-8?B?THpUVHVCZ0NyZkZsK3NBczQzM0hWZ3c4TWVQMEwrOUVYYk1kMFNiQktldUJ2?=
 =?utf-8?B?L1kwY3YrdWRRbEgzTDhBdkJiQ0hjWFdvQStVUzMwY1VBUGFtbEdBR1NENE5C?=
 =?utf-8?B?VkMzZWFWMENrZUVYQllyM25tbWtHeWVNblZ2R2dDTjc5RzJTZERXR0xaMGls?=
 =?utf-8?B?eW9XMHc0MURndzRyazNseEpneU5seC9tZkxQeE1QcVlobmdvMmdDTHhqcFJn?=
 =?utf-8?B?L0tFQ01ybzFxYnpNRVVZZStTeWtSZExzbmRWQzJzZG5ZSXpJZFRZVVIwL2p2?=
 =?utf-8?B?QVV6c1lwLzNiQkxxbjlieHpRZnFKcGJFdXVKVU1zektHUkM3TmFrUGQ1T1hz?=
 =?utf-8?B?MmtlZ2xjZDNrWXNVWjEyQWZObk83ejNVMEZ5K2w4RitBYkp1S2VSYnFDRU54?=
 =?utf-8?B?NHVYektPSWdveWdCaS8yY1UzVTNkUS9HK0lqNjh5NUV5dFdUZ2tzaHV4THk3?=
 =?utf-8?B?OUhBMFFPbWZ1emJwcExub1NzSUViWUpEa1RxTVB5OERwemI3UDFzcUdVUHVI?=
 =?utf-8?B?WkVJRHNzUkYzTFo4UDYxWXd6RU5rTWVUZ1ovdWlDVkZsdU5LNExwWUtLRkFr?=
 =?utf-8?B?aTV0djRreHVLQUNtVU5lU0sxZGVkcG9YMWpQd1lFemN2SVNvMUw4U3ROS0pF?=
 =?utf-8?B?KzF4U0hGYm5xZExIRGJkdXczUFdsV3FlVjRqc2JwWEV6ZXFDWkR1ejBtVFNO?=
 =?utf-8?B?UFdzM2wxQ3Q2b2FEcnZKK3J3Y1BSMVJZSHBYeUVXeGxob3pRb0hGV01CNlFI?=
 =?utf-8?B?UmQxRDRtbW05aXZHZEhaL3hHeHdEWnAwUFN6dGJxOGxXaFdHNjVhNUVzbEtj?=
 =?utf-8?B?TUJjeTlFSEZGVytHRWhqditXSUtRRVVoNHV6MGlEdHFxc1grRHVlZE1vMzJE?=
 =?utf-8?B?Vm4zZjRranlkc3MvU0d4Rkp6d0R0TFFSNS9iSE5JaXVXaUJENzRzakh4RVNS?=
 =?utf-8?B?TnpaNzNTMGN1YlkzUHMrbVBjcURESVNGNXZERFkrbkdPaHJYZ3A1UWhsemJS?=
 =?utf-8?B?aGk0M0NuSUVLZ1hjbENPd3ZPb1ltakZKMFJ0UmdJeEYzUnl2aENLUEh2UUFk?=
 =?utf-8?B?SkNmL0lmMzJreWxsd1BKVGdYUVdKWDRFZnhiTnFGelRRSnhJcGJ2b09PSi9P?=
 =?utf-8?B?RHpjMXh1c3pSTnJQd0hXV1V4WmpNV2dwNXFwMnBHNHlTRlJRcHhhQXhHTEFR?=
 =?utf-8?B?c01CQlErZ2FMZ3o5b2R0YUNDbnFkejdKMUVkK29LTFVGOERrM1NUVW1IUUx0?=
 =?utf-8?B?VEVwdmlUOUdRZm9hczk2aThQSkd5QmpEL0crME5YdzN6elBxOVUxZGpSbjBN?=
 =?utf-8?B?UVFwdlZlUEZFdHBjQTZJY1BTczVmMVNZNGZEbTJTWVcrQkhJcldlL2hzdWhj?=
 =?utf-8?B?Um4rdXNLOTNvLzZKYjdWR3R2QklRenJya2RQLzBTa2QzaDBkUnVZZDlZeVNh?=
 =?utf-8?B?Vk80cmRGQmlwRnhEUG9TdXJJTXNiODEwNGpCT1djSXdlTGtFcWh3RURDN3M1?=
 =?utf-8?B?VVNJdzFKdWFnL05kbUM4SzVwM2xLUUJJZytHNnIxa3UzeFViMk5rUkE2RUdm?=
 =?utf-8?B?clNEZUgyR1AwKy92RnpveDFRemRhalo2WGpMakdGV0VhV1VmSnlRT2R0MGVG?=
 =?utf-8?B?aC9IY1U3Zjc1b0ZNMk1MclA1OFowWHpVbForWGRoVXphV2tWVWc0L2tPQjhI?=
 =?utf-8?B?UHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a9f98d07-bd04-478f-b8ab-08dc38c06629
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 00:50:18.0302
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bJ9QiiQvC6m+WuqKiZWFCEfFPA1y4Qfmlr8yzP1hMHzsVhyWlK+U8wC0xkPoHWUaWk8mrK/NTxM1usZ0bgt/c1FpsGaOkIHTytPluv3kKs4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5978
X-OriginatorOrg: intel.com



On 2/28/2024 4:41 PM, Tony Nguyen wrote:
> From: Ernesto Castellotti <ernesto@castellotti.net>
> 
> Added support for 1000BASE-BX, i.e. Gigabit Ethernet over single strand
> of single-mode fiber.
> The initialization of a 1000BASE-BX SFP is the same as 1000BASE-SX/LX
> with the only difference that the Bit Rate Nominal Value must be
> checked to make sure it is a Gigabit Ethernet transceiver, as described
> by the SFF-8472 specification.

...

I just noticed I missed portions from the original patch. Please 
disregard I'll try again in 24 hours :(

pw-bot: cr

