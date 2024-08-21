Return-Path: <netdev+bounces-120630-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0CE95A0D7
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 17:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FF28283468
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 15:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B2F139D1E;
	Wed, 21 Aug 2024 15:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KHwEa+w8"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B32C2AD31
	for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 15:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724252646; cv=fail; b=lTvpihYVhmw5c4lZ+bqyM4K4Uvp/6oDzHIxqQelrhccl0LT98bESw9ftno7o62L7fr0vahJwdCbfPbqmrMsCXiqnil6RG7poT5lVzBPChgnn59a11SmWOrfgUYk7/rzHOiXBh3ETq4eDnDYJAkmIJ2lCfQaKhMR7hcSrVrln0a0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724252646; c=relaxed/simple;
	bh=/wUFS7NnPp29Xeg1KRTX/zM7CS+2TFLFe29hZd5H5n8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Fqq0izxg/gIivu0PcVnCYgqu6qTAuxBnDtZXXXo7U1Ngo4EKLGZUnqdLwgW8LWg+D7Incl676PxmiUEjQ0dLzFtmm9ihQMKP+FZ9YsRhexIKKpGZFijz6WNMMsO5EhJ2I6j2LdS3kfN5SHM1R5ONPzXq6FO6zZ+nwXZ13guIXSM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KHwEa+w8; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724252644; x=1755788644;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/wUFS7NnPp29Xeg1KRTX/zM7CS+2TFLFe29hZd5H5n8=;
  b=KHwEa+w8NMDfJRlz7ObI67uVlu+qtZZcIlkwFfpIWHb2MO3d2baBYE20
   N9+zgX4rvRiku/BXpRJRt9gMNE3mFaHT7QepHcOruUK9lvtYoTOCSVHJw
   SbcmdoxWEli2+JE8m7i8MEu80oPKEG4yvkNRi7rOOeBYohEzI+undk4xT
   8mJBuGpJxBi2PanW4caf9f1JY/U+Wxoo5omgvaefConqef1vEiByPIGOV
   3Wzb9RRAMl2iM73Q1gHOpu2u1VpwtPSdWhdCqT1NWbqo9ImQaipPhjQAV
   +MAPaOA0DCgLdin/B1nJZ0M1O/E7sHGciagtVITaecfLhBkLMBoM6eagj
   Q==;
X-CSE-ConnectionGUID: zIjVc/pDQhSSxgyWPpp35Q==
X-CSE-MsgGUID: shq4X5iFTkywlbH9XxPebw==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="40131846"
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="40131846"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 08:04:03 -0700
X-CSE-ConnectionGUID: +56iGrPiRKuNzVK6aOFrzw==
X-CSE-MsgGUID: ZbQrVn0pT8eiGDSvU2NaQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="65806715"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Aug 2024 08:04:02 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 21 Aug 2024 08:04:02 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 21 Aug 2024 08:04:02 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 21 Aug 2024 08:04:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RPmVbvrXcGtCa9xGI0ePgHutr2kgs7mswzEXRnCZHrf1+7OlgFb3t03NqrQjDNK7Ahr+RvgdUjqxTdIdUTv/CSY0VVXAE87HlMYHl6sd1XGFc1d7ZONo63k4n1WndOibUliw+dWqEgY/PknLuJU4sBVthM9n9S7FPc4y73obpUMSewOq9hho3rbUdd4rjHI3WNLtd8IvhDYTog2MZAbXBFsFc96Ji7XeXivaJjFk+xfNssQSiSHbhcRvxnr3baqCYHkl12BoP9XFmNVgRNOFHz6ufj9aIl3coqWk0Gx6I5QQNvbPpeg9iEE9SynYBNtQXgRSlUVaqnH7Mx4yEjjtSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WBHInO/ZfGTUZ2bDFsybdX/6HVbf0Kuyk7X02+lUlhU=;
 b=oEZMof6Sm6rAD/4R/XFxAf91d/4eYhOBCPhApu3X2ETRknCr4o2g0gLtzUD6Z1/oeCcDp2Vim9P4fltF3MU1WA4KIbCcPO2FEHt3JXczTqQh0QQ7Ubb6ynL+Cr2YNbYBsF5QI0kJZtUsZlR3reqLgyuMNH/IBN+giSVkGZhlTg7TXx5hK4CG1G5tD30iEJaWQDQucEpoY8aoQj4325vWy1m8B/sGdAVRfJri2lXzLhFr3Ln7y6y7+ahcZDTDyPjirFOGLLfJxAkCiiEdgkF/oS2tXV6aYXvaTvQ9rk4XiBjGrjdL7xSEWOwpCxAaA9mzBOtonLvMBARzou82ZFcM4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by PH0PR11MB7521.namprd11.prod.outlook.com (2603:10b6:510:283::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.18; Wed, 21 Aug
 2024 15:03:56 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::4b3b:9dbe:f68c:d808%5]) with mapi id 15.20.7875.019; Wed, 21 Aug 2024
 15:03:54 +0000
Message-ID: <6d67f88f-8240-4564-b98c-5bcc957fc589@intel.com>
Date: Wed, 21 Aug 2024 17:03:49 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-next v10 09/14] libeth: move idpf_rx_csum_decoded and
 idpf_rx_extracted
To: Wojciech Drewek <wojciech.drewek@intel.com>
CC: <netdev@vger.kernel.org>, <intel-wired-lan@lists.osuosl.org>,
	<horms@kernel.org>, <anthony.l.nguyen@intel.com>, <kuba@kernel.org>,
	<alexandr.lobakin@intel.com>
References: <20240821121539.374343-1-wojciech.drewek@intel.com>
 <20240821121539.374343-10-wojciech.drewek@intel.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <20240821121539.374343-10-wojciech.drewek@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0026.eurprd04.prod.outlook.com
 (2603:10a6:10:3b::31) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|PH0PR11MB7521:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bda785c-8236-4348-826c-08dcc1f27921
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?NWZCa2hoTzhQYkQxd0JvOXQ1RW9tME1pcDFVYXZGbWczQnlEbFhqUTBielUv?=
 =?utf-8?B?WVEzbG9xbno4cGs4VVd1KzdzbUh5bERVWEpqWkZhdFZZUE44dWZFanhIWXd3?=
 =?utf-8?B?dUtLQU9jNWlWZm9GdFJwbzVIQ0xsYnVaaFFYaTJmTWR3VEJuZXdPblJVcjhx?=
 =?utf-8?B?SDliQ2kyZW1jVHRNbCtWdUt6bzcrNFBGRyt3WFI2Y0haNDRLUFI1ZjJHZEJQ?=
 =?utf-8?B?UEFnTHN5S0NlOURHWVBDTGJNK1h5MnhQZ25XQUdDcXA4bDJHb2ZmNXlpNmN3?=
 =?utf-8?B?UDZVSm8xVGwrd1B3aldWeTgxd1o0d3B0S2p6ak1wVEh1RTNkclN6TVMwSzVv?=
 =?utf-8?B?UGQxWHFOQTNSSXNFbUNvaDZQaUY2YmpnYWw3YkJudW1LdHh1SUxJQ0gxQ09T?=
 =?utf-8?B?VzgxakZzNlZwUVB1RE1uU1FiZk50NHdmNys4NTRDWEpzVENabUN3SmxXN056?=
 =?utf-8?B?TFNwSyttVkhJbUdMS3d6WDhzWjVxQ010c2ltNXlCNlZiQ3ZqZUlNUkdzdjB2?=
 =?utf-8?B?Vlc3WkpMT0xpY254cml4YXpoQ0tSSWRaZnZvU1QvbTdFUGd1S0J4c1c1VGEv?=
 =?utf-8?B?S2F6dkdaWnJrU2JWZHlkYjl2UHVtaXlWTVpJemxyUHU3UU1IUVAwTWR0bGdN?=
 =?utf-8?B?Ym9JaGJyYWU4ZmdhYjY5Z1Q4ams0eDRtdkptTXhRbDhKcjNwTmRvK2g5bmpx?=
 =?utf-8?B?VFhWTnZEV2FVODZpbHlWems4M3A4eEIrT1lTcVFLSE1uQ3FVY2RaSC9ITGFE?=
 =?utf-8?B?MmxNbWVCYzhUdHdPUGh3Y3JITUpkcURaS0NEaSsrWVRNNG9HSkYwcmFvTjZU?=
 =?utf-8?B?TUREazdnUk9zU1Q3OUhtRmlzR0xMZ01jK1BzM2d5ZnJFYkFBb2dMekgzeVFP?=
 =?utf-8?B?YmlDY0JkQXpEdXBLQ3F3ajQvUEFsdS9SdTlvOExZUVF3TVhTdmJXUVNyUHFm?=
 =?utf-8?B?eW51cGdyOW5qbG1oQVpQTmxySXBBdkFGb0lnNDlIUzlnRTh2QjVZanFUVDZK?=
 =?utf-8?B?UWt6eFVUL056T1dmZXU5RGtiQ21oOGZ1Z3BWcmlLQklhWTB6cXBJb2ZDWnFY?=
 =?utf-8?B?NjNMb1pnbmZ1U3V6ZkpydjdvTGoxSGdOb0czNHhMR2ZEQS8yWnZaQ2hRVFh1?=
 =?utf-8?B?NlY2dUJRTDhnWEJDc0pnMG9RcW1jd09VM1RtdnlZVmo1M0N2YTZsd01YYmNX?=
 =?utf-8?B?ZUluZjRBanVvcFdreHlQQm0zU213WjhtQnRKZ3UrMEU5STJrVzFTRWdQODEy?=
 =?utf-8?B?anpGa2JCYnVvWGw5MHZGSld0bjNCZU9TU2JZVUFyYWRRK3Y5RWpjK0h2dERp?=
 =?utf-8?B?VG14U29YdkxBUTJoZWN4aHBvQjFCc25Sa1ZFL1lPQ1pVYVJsaXRZc3JBTTFh?=
 =?utf-8?B?eFJwTXNyR0FSclZWeFRqaVZhTVNwSkVpWjZ2WklVZDVJYkxmdy9QZVVXL09o?=
 =?utf-8?B?SjMxd1dZeW1nYzlwWnA1QzdUbWVaR3gxenVVL3RyMFBrQjhDUmdjOUN5a2xi?=
 =?utf-8?B?akpsZHJXSnVwQVQ0N3VCU05jU2t5MENWMTFhbFlYU1gvUUtPV2JEa1hLV1R1?=
 =?utf-8?B?Ky9GRlhoemJSSktTNG0ySEo5UjY1UTByekVZbHl6Rnh4ZGRjbjgzbkp1Z1dY?=
 =?utf-8?B?YUUyYW9weThWSHJBZGFSNWFuVVBJeWFqdS9tREhpL2tZMElsaVgvNjdZT2N3?=
 =?utf-8?B?U0w4RnZyZHk0R2g4a0NIVFpZc1RjTFVmNzQwL2tBcEM1WkZYUGEvR1VSNjNs?=
 =?utf-8?B?bFRlOENSMUF1cjNadWdsSmFEQjUvUHZKZ1QxT29pNnB1eWZyWlBUZ1ZGa1RI?=
 =?utf-8?B?NlY3SUZoU0VGYVBVc2ViZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TkN6NjgvTm95VGFEZWhlcmZjNlNnSS81VFVTRkh5ODkzdzFhVUp5MTdDMURj?=
 =?utf-8?B?bU92bW1FMkxGck1WVHB0Wk8rVVFERTRVY1YyRVV6UWJsbzltWDd1emErdHZ4?=
 =?utf-8?B?REhqcE95Mmc1NjRkUExwR1NwSk9YS2VrSjlzVWROcGJqRFFMMC8yZTRkRmxQ?=
 =?utf-8?B?UzVXUHRlb0N5eThOTXpZWjhlRTAxVFFnd3RrNlEyeDFHRUo5ZUdRRWd3aWp6?=
 =?utf-8?B?b29lSEtmTzdTeXhNT0RkbGlnaUlSdFNQSzRRU0gvTnVkdmFPd0trclB1aEZS?=
 =?utf-8?B?K0RzSGtIb2Z4TW5CSGN0MWJqTXkwcWdHaTN5b2tFeDVQd1IyN0ttalhiY2dR?=
 =?utf-8?B?dFlDbWVlRTVGNFBWWE10Y2RadEdoYk5aQWNQdFRpRndJa28zUk16a2tTUkN0?=
 =?utf-8?B?M1RNVjF5bVdjU2I4dkRxdXhTaUZqT2xhajFwUDlRQ2Y3Q1JidElHVFdhUm92?=
 =?utf-8?B?VFBDR2dWeXlaNFdiTFNiQjE3QjI1UE5zL1MyNkd3WGpEWXpNelNFZ2ZiUFlR?=
 =?utf-8?B?RDNtc1Yzb1RvdEFNY0VuczBTTVNKNm1LN3ZKZ0pZTUxCOGxEcU1UMVU4NHJQ?=
 =?utf-8?B?Mm5XbkhUeXU3OUhxV2xmUjhWQlpBR3gxUmlLYll2b0hmQU82UzNZaExHVEU2?=
 =?utf-8?B?eG9aL0VwaDBrQ3AyTnJ6am9JYXRuL1VJUXQ2NjUrNm1DSUhwWVA5cWZpbEM2?=
 =?utf-8?B?YzhaUTdwcnM2K0g1aDZiOVFwMmdSNnZqVGhLTXRUcnJaOThOMlo4ZWxTR0d4?=
 =?utf-8?B?TEMvV0puZDFUQ2wrVzRTOGFmTGxlajZHN01uaHRXRjRNVkJ1YmtjVzZKTHcv?=
 =?utf-8?B?NUxKQ04wczUyNmQ1M1ZsYWdlRUptc09mZzV6V2haeXhkM3hxN2dFRVlVTkJt?=
 =?utf-8?B?Ni94YUtPczZBUHVnUjMzbTBGK3c4Z1FrNy9wbThtVjI5d1VaL2xmbm16ZDZa?=
 =?utf-8?B?ZTdoMXhKU01tM0VxUC80ZThXaWhrOUpSVUU5WDFkaWM2RkgyR3VwRXhyd21X?=
 =?utf-8?B?anI4eStrYm5CZzNMV1BpaVVBbC85UE1tVHhHc0lRTFpyMk9oNXRsWlV5YlZw?=
 =?utf-8?B?cE5BZWtOVzFmaFcvVGVrQlR6THFBR2dMQTgrNmhlSmdkUFBmdXZ3YUZJQm1s?=
 =?utf-8?B?MnlJbWk1cGtqcHBBQ1RLR0wxQ1VyclRoWlZhc0tkVG1GMDZoTytBK1VHZDB3?=
 =?utf-8?B?V21CNUZrZ1lWeDJseHRUbitrS0wzdWlRSEorenZhbm9QZmt0ZlNlT1FWcDMx?=
 =?utf-8?B?eFgrTTBCVjY1MWhNOWM3UEVveVhOMW5TRTN0Q1dabG9UV2J5cHN1UmZnc2xs?=
 =?utf-8?B?VTdwREUwYWxJQ0M2UWJ4elVyMkpKcG9qVlN1SEk5emN6Tm9OSWlhZWJsdlR1?=
 =?utf-8?B?NUFSZU1oeTZUNUhMa1RKS3EzTFNWbkh5UEVYREhhQ1JhWUJ2VFh6V3FzRE0y?=
 =?utf-8?B?eU9PdTZnUWlkMkkzMkxuM0VBTHQwSGtOVkQzcHZrdXVvZFVITWNTZEEyaHZL?=
 =?utf-8?B?T1llUnBuVXhteFErZW9uYUIvdnhDbDhrY3p0ZU5memhXOWxJU3pJVFluSThS?=
 =?utf-8?B?aVZrU0hRb3dGSWhSeEFQTk84bE9nbDdIcDJySDlFNUFpb25ueVZVVG4yY2lT?=
 =?utf-8?B?QmZ6SDFrSGw5MW1VbWV6eHFkZmFHSUI3cHZrM0FaZVFZWEwxNFB2OWk2Szh6?=
 =?utf-8?B?elZ2eXJOZkFqT3lqVzVnR1FIV1ZQT3B3SFdBb2tCY2Fva2Z2WEtEWGN1Y0lo?=
 =?utf-8?B?ek5RUXQzN0pFc1UwdHJMQldxMDhncmtYT1RMem04bjlFZHpzWVZUeWYwMi94?=
 =?utf-8?B?ZS9WT0ZJQlNiL0JWTjdEUm5KaEVmd2FITlA1K0tQdjFYY2ZzSXRTajh4aVRt?=
 =?utf-8?B?a2x2djUrNEsyUDFHbHo5MG4xWm5iMWVwQjlLdkJNSHNWTEo2KytNa29KenZj?=
 =?utf-8?B?V2xuNUp2SERDMUszZm5ZQkQ0OHRtckVZMlF0ZHdUOHpzQ05XSlhrTzZRR0Mw?=
 =?utf-8?B?ZisvanVrMndRNmpRZThQbHo2VXl6eCtTV0ZhcWVQRmVianZDOG91TjB0ZnZE?=
 =?utf-8?B?Y2FTcDZNaWxuSk0wcERsRDB5SUltWDZTMkdqOUx5VEVCVEYzK2dJWTJYeWNI?=
 =?utf-8?B?NXNUMHhlNW15WnFKamRnQ09OQVgvU2h2d1NKblhRcWJoblo0MXJuTHpsZUk5?=
 =?utf-8?Q?OFL+tNvkFFs/iDWYMMoRIxA=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bda785c-8236-4348-826c-08dcc1f27921
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2024 15:03:54.0643
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gC0+M3g/zReJsS0CJ4IBPPXZtkdHWC9iy3hvWyIDpZNllIkxHkRY/jgBLtUpmPVO+sBmDQV5iylPFa/RJWOltzW2rbKrSmji405FN4cWPqw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7521
X-OriginatorOrg: intel.com

From: Wojciech Drewek <wojciech.drewek@intel.com>
Date: Wed, 21 Aug 2024 14:15:34 +0200

> From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
> 
> Structs idpf_rx_csum_decoded and idpf_rx_extracted are used both in
> idpf and iavf Intel drivers. This commit changes the prefix from

Imperative. Like "change the prefix and move mentioned structs to...".

> idpf_* to libeth_* and moves mentioned structs to libeth's rx.h header
> file.
> 
> Usage in idpf driver has been adjusted.

[...]

> diff --git a/include/net/libeth/rx.h b/include/net/libeth/rx.h
> index 43574bd6612f..03e371633f4f 100644
> --- a/include/net/libeth/rx.h
> +++ b/include/net/libeth/rx.h
> @@ -198,6 +198,48 @@ struct libeth_rx_pt {
>  	enum xdp_rss_hash_type			hash_type:16;
>  };
>  
> +/**
> + * struct libeth_rx_csum - Checksum offload bits decoded from the Rx descriptor

Lowercase after '-' to be consistent with the rest.

 * struct libeth_rx_csum - checksum offload bits...

> + * @l3l4p: detectable L3 and L4 integrity check is processed by the hardware
> + * @ipe: IP checksum error
> + * @eipe: external (outermost) IP header (only for tunels)
> + * @eudpe: external (outermost) UDP checksum error (only for tunels)
> + * @ipv6exadd: IPv6 header with extension headers
> + * @l4e: L4 integrity error
> + * @pprs: set for packets that skip checksum calculation in the HW pre parser
> + * @nat: the packet is a UDP tunneled packet
> + * @raw_csum_valid: set if raw checksum is valid
> + * @pad: padding to naturally align raw_csum field
> + * @raw_csum: raw checksum
> + */
> +struct libeth_rx_csum {
> +	u32					l3l4p:1;
> +	u32					ipe:1;
> +	u32					eipe:1;
> +	u32					eudpe:1;
> +	u32					ipv6exadd:1;
> +	u32					l4e:1;
> +	u32					pprs:1;
> +	u32					nat:1;

I'd put an empty newline here after nat.

> +	u32					raw_csum_valid:1;
> +	u32					pad:7;
> +	u32					raw_csum:16;
> +};
> +
> +/**
> + * struct libeth_rqe_info - receive queue element info
> + * @len: packet length
> + * @vlan_tag: vlan tag

Again, which tag is this? C-VLAN, S-VLAN? If it depends on the
configuration, then I'd mention it accordingly, like (note that I'd
shorten the name to just 'vlan')

 * @vlan: C-VLAN or S-VLAN tag depending on the VLAN offload configuration
("VLAN", not "vlan" BTW)

> + * @eop: end of packet

I'd expand this a bit.

 * @eop: whether it's the last fragment of the packet

> + * @rxe: MAC errors: CRC, Alignment, Oversize, Undersizes, Length error
> + */
> +struct libeth_rqe_info {
> +	u32					len;
> +	u32					vlan_tag:16;
> +	u32					eop:1;
> +	u32					rxe:1;
> +};

Ok, sorry for confusing, but now after I read the changes above I really
think it would be better to add ptype here though =\

struct libeth_rqe_info {
	u32					len;

	u32					ptype:14;
	u32					eop:1;
	u32					rxe:1;

	u32					vlan_tag:16;
}

(+ reorder and empty newlines as suggested)

> +
>  void libeth_rx_pt_gen_hash_type(struct libeth_rx_pt *pt);
>  
>  /**

Thanks,
Olek

