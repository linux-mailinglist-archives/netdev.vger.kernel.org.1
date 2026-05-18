Return-Path: <netdev+bounces-288942-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GPc2MqTRCmou8gQAu9opvQ
	(envelope-from <netdev+bounces-288942-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 10:45:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3777E5690FF
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 10:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 53FC730254AC
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 08:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436C422D7A1;
	Mon, 18 May 2026 08:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MZKCPCDV"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC863D0926;
	Mon, 18 May 2026 08:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779093163; cv=fail; b=lzdSTVuI0jCL13M1GciBV0xONClKOXeJrgs3qC9NhOOXLiGmhRCOhH6jNYWEK2tqctbvYMLyvy3RPEvaI3cQ9M40rax+VNGEhzzJP6C6akdH34wQVODezPM/O3OKPDZTlScJTrBu2qFzGUNtgDCdQSQ9/UjxVC8H/w0QBPrL2Fs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779093163; c=relaxed/simple;
	bh=jWnOVsb9rtNaq+qFuV1UprvOjgpEMd3OCa7gvDJezos=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=D4EZG3Sf4v86dgV+lYoHYp3/9tIg4Po/hs0c1O9rIuG0aGvjEhY9LjrXUTVudkJxM+EEeR9dKykoON8d7pjA+1SdhCn2eSpBcXXY+uxtvUIvXKaoJs2Ki8XKFkTuCuMwPE+wBCPJm4/kaEM4mGVaQOvbWvbSbFC8Xzj3BXLjaek=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MZKCPCDV; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779093160; x=1810629160;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=jWnOVsb9rtNaq+qFuV1UprvOjgpEMd3OCa7gvDJezos=;
  b=MZKCPCDVKbLC6421sorw1Dv7gk86J99P4tddsFMeih2B3iO90mT54hCI
   Y6Wmmvzt//4KN2AJnpx1bZT3KSAebr3rCOczLLXvGKkSh22WAcRhytwKZ
   7OkkJlwEhZPdDyKsbZBwIEgrMfib7iVTvTyTFF19/CzRzFwDmziZmNQoc
   SIbp983uFt7iZKKvE1+k4x6tJuRsaiNhnoELXOMVUnFPbawTg+IQsA8ZR
   W+KBTl7H0or4B38uxXEBQNjrbYYS8WY92w/G2ZEMme7LrqLgrV4M06ARq
   h+jhU7foxz8Slzzq312qg3ulifDd6Qm+mhXdXXhIWhbUOzB7L9Rwt753c
   w==;
X-CSE-ConnectionGUID: iu8dQaUiQGKhxtCaKG+5vg==
X-CSE-MsgGUID: p+r70/sdQe23NJNX0KqHWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11789"; a="79078267"
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; 
   d="scan'208";a="79078267"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 01:32:39 -0700
X-CSE-ConnectionGUID: 4bijM2f9RICwCEisZhI3Dw==
X-CSE-MsgGUID: hOhbQPa/RBmPQaQdFgZEkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,241,1770624000"; 
   d="scan'208";a="241180763"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2026 01:32:39 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 18 May 2026 01:32:38 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 18 May 2026 01:32:38 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.22) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 18 May 2026 01:32:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G1S93w63DEd99Ktb6yAIIBtX7/PiplDev7yx+hFoAAtupscMmvjvLXVjWiHqx8Yt8AHB5Xe7/EDhcgNljVa0GTSulJRGe5gmUPBB3Q925wEKuWEqhW1xRrAdvnJEKtVaqbXZAMv9Ezz70j2SO+7KROUM1ZOzQf1BX39avYLbyAb+fg6q4nICGCHMPMhcinjzi7gWRexGdKhjXOuoCsBZcsxtzI/s2Qty7gTIyRO7Swb4brDMWCJssexEbUN4R5n0BmuBVKMHmtgRp6ihE4PR/49KROgDfAirdH7cqUrZ+EETiLHuaBvXPu5u6O/WZy3jPpcoWYKBqLl404sCi/yUMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3BIym4ZZOEaPWYD3RB2jb+J/Jvaa91x7i92WU3PNVv8=;
 b=iIoxJn5Xf6ZZxCfqnXztXYXuWLfa1m6wTvoHxvWegy15xuqD5rcy3/DZ9eHMjJ6RwI8SjrtHT09ax/ykDtk3Fkux88YZYop1GCm6ONChnxm7HUKIn6OZb/2BaIk1UIgRHTvoIpEk2w/MXz6KC28w0honqNBmEh2M5gqtoMU1kPAEK3YyQTCXMxl63d9z8TcG/1ktAtKecksr6vGuGh8+g3KTF9jMePbLa7LrAxmK6OedDBMpyKGCqqQ3M8jKJgQt0zu89S0vqKPlH89rv6rgtX5K1ShXdrkb5RIom7QxaiFiOhtoegAkb78DFQIIAkagT3lptVuEGoW1B99pRGd7rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by DS4PPF1C4B3BAB7.namprd11.prod.outlook.com (2603:10b6:f:fc02::f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Mon, 18 May
 2026 08:32:31 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::2edd:5c6d:169c:389b]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::2edd:5c6d:169c:389b%6]) with mapi id 15.21.0025.022; Mon, 18 May 2026
 08:32:30 +0000
Date: Mon, 18 May 2026 10:32:14 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>,
	<przemyslaw.kitszel@intel.com>, <aleksander.lobakin@intel.com>,
	<sridhar.samudrala@intel.com>, <anjali.singhai@intel.com>,
	<michal.swiatkowski@linux.intel.com>, <maciej.fijalkowski@intel.com>,
	<emil.s.tantilov@intel.com>, <madhu.chittim@intel.com>,
	<joshua.a.hay@intel.com>, <jacob.e.keller@intel.com>,
	<jayaprakash.shanmugam@intel.com>, <jiri@resnulli.us>, <horms@kernel.org>,
	<corbet@lwn.net>, <richardcochran@gmail.com>, <linux-doc@vger.kernel.org>,
	Bharath R <Bharath.r@intel.com>, Aleksandr Loktionov
	<aleksandr.loktionov@intel.com>
Subject: Re: [PATCH net-next v3 11/14] ixd: add basic driver framework for
 Intel(R) Control Plane Function
Message-ID: <agrOjsuklQGg7lpt@soc-5CG4396X81.clients.intel.com>
References: <20260515224443.2772147-1-anthony.l.nguyen@intel.com>
 <20260515224443.2772147-12-anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260515224443.2772147-12-anthony.l.nguyen@intel.com>
X-ClientProxiedBy: VI1PR09CA0144.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::28) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|DS4PPF1C4B3BAB7:EE_
X-MS-Office365-Filtering-Correlation-Id: c93d083d-aad5-4b81-6180-08deb4b8003c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|7416014|13003099007|11063799003|22082099003|18002099003|56012099003|4143699003;
X-Microsoft-Antispam-Message-Info: l+4b/6gJbkXYuRqB2LKn1yMwzPRmzyzwpd1cqgbI8nVnpUG47nDwtPWJWthlJnYKPVrAWxm4/vV4J/pKNCl6V8bWrfO6J26bL8+2k1s7MsmdmV5AWSpRnXUXfu8kAotPhsttVxyJce3uCoyaTWbKgClETp1t7UlYRJPhOc2l39fHzLBslnuw9phmNkWmTDvbJqZCOWaZOtMwTBBm3cUOxJpN5lPzOFoOBPPv/+bRdyM4PHtZTRXecDALpAKcvSGiborVpMnBVW04vLYdiT0XO7wMACTE27HQ/eKmQjJt3Av4Ukv768pqxQJZu6aWt12xH6PcO5YY1m9siDtEfm5Z6XXY4sVJzY+Qw9ZBnqjITCgkBVIgNUQpms1ngO12P8mlZDfgkZCwdKpwR/eVgq855iVJ0pVoPZMifH2tF2hA2BK5iIwjXuhUeX/3kEMoE79VI5yk4+vS5QrJgzwm1Rjrmnkd+MMPZFp1eiwFl6XoKibyJ0pemwON/y34VSVA+WXLxRLu7Lx5OJiNxo6jitd9pLhyJKY0R1tg4bavnWBc7bb7FeVlC1Y+AzO1gilZ+4eCmEESMbAZH0ZRMfZOfLpLIoN/f+dJAsFywjEadlUQAglbysWRcFIJMawyA/4y4CwFJR7dYD4e6o1EHxUyCUpYDA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(7416014)(13003099007)(11063799003)(22082099003)(18002099003)(56012099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NT8vKOT8vz/uT2NXjmB8cGVIZN0uFqJAqrzsr2iZ631gM2Tv4wXiNml0Fsbm?=
 =?us-ascii?Q?6I1JCN0K4Mht92Z7sB24rUxEJw+BlBV4SNDc2gDStO8HQHUGZbx//QXGvmn5?=
 =?us-ascii?Q?0KcrbvAxGd/5d6TEXbm/L/jx9Kirf79KT5WgP8SlkC96DpD9qQFT2gusO5ec?=
 =?us-ascii?Q?VTceWoBVNhiY3KOkved8j7w2EOwCA6c30XhiOGnBqqPt671DV1iqXsHZe1Ot?=
 =?us-ascii?Q?jsRUKshhKxEppqC+TcIL2V+wdCH4dydFgG5ODc+oXT3cDqmh2+s15p85AWVr?=
 =?us-ascii?Q?JQ06MPsDoOfvpkAHRfzH1VvV2CNWCQIitjejGEZyuULMhRRdFoIcLnFXqULh?=
 =?us-ascii?Q?NIe0hxbCl24rlhRjDFHA1342IIRnlaFY10mlkCtXXGfZKwn2ihQHcwslC+vR?=
 =?us-ascii?Q?3+Yp806gHZuBzk6MR6LT52+6NER7vQgzLBRx9JPMu3QfiAoOXJUuQfxlY4mR?=
 =?us-ascii?Q?fP/YyCNtWxQtMgCAbPyN/Qp9OXTLO/bcTGgcUjV1HX3PymTR6xnjPhcjVo9b?=
 =?us-ascii?Q?odEob5/HwCsr13RKoAbU7LxgdX3sUGirFk2WiciiwPnoPl9Cej7ewNkXJ4nC?=
 =?us-ascii?Q?l73Io9spMG95yDfbqHduJCCtb+d/TabXS/iJ++YbsD3RhNVCOps19kcOeq1A?=
 =?us-ascii?Q?ywgD4P2SuzQDvcpUwCWzQ95cJqaf60t3Wce2K31wXXaOHtmqIdAyahxzTpV6?=
 =?us-ascii?Q?EkISq0xrphatOXXd01pGHHJkMHq96Ko+ziOTNwrMmG6miISjhrcgScxUNOFT?=
 =?us-ascii?Q?WU4bX/OpYXbHsv41eSvkMLa+Gau4pZuCZddI9TsxefX3KrJYa63hSq0mH24i?=
 =?us-ascii?Q?cep5pChJ/uYJf0iPkB/QK9X+OqL1is3zJEkhI1OzcHJP1rkXflaOLYXHBaew?=
 =?us-ascii?Q?YjVplwoJmJDdQSn8FuznGmRQeUmxIuOjtfS2SxLfZ+t1nkR9w7gf+HBmsdwn?=
 =?us-ascii?Q?zTQ2r3k4oNAbTh+09sDfppEutP1rDsvG3ptTx3rZaT1ZAmmTmhObdtYSYmki?=
 =?us-ascii?Q?Yx3TD4C++OUWEm/jxMRK8/JkocG296yfbbgcVTp4eA/008UgiE1ILlZPnMtZ?=
 =?us-ascii?Q?qewzjgrm/6sxUoCh9qW2v3JHO4mK9R5SucMlj/QLrIyGpWkUb5FzVOUJHsg0?=
 =?us-ascii?Q?ml7rLmANs+vTqRvOj711bf4o5yjUdxgqhTx7j9DpAk+Fl3sq52O5kcglGY2I?=
 =?us-ascii?Q?pVQWyL2tPTK6wuoytxQrI45lLgL42KsRJOVg+6w5zQ1EePZVoBYX06gQKU1/?=
 =?us-ascii?Q?Xd81tIoUPj55/+PWfweP3YL01FfgNhjd2APK1mwROIB4Dkmql1+/2y5GAqv8?=
 =?us-ascii?Q?FybIlYIQqEB0RPVjULfsDQ85GDt63SeEwpNXKUADBtHo2CdA7RwCMl5SoU62?=
 =?us-ascii?Q?AC0o2qKhNglzeZ3hRagXOJqGhWhiK8M6DnRXiGeQnR2Lsj4wcGc1ew9UMm/w?=
 =?us-ascii?Q?w50b5rCgMdxAbL0ciyj9EqezCVGjWorVWrLN+taf8Yvh9g3erjFDOXmZ+WuW?=
 =?us-ascii?Q?Wkrh5BzSSgZWmFXISWIu7fE4FqdJCGLeHtNBEk+y8WvOyqd1CBARGR3Px4rr?=
 =?us-ascii?Q?33MEX1h8Byvpn4DJD9IeZbJvMzDcD2Q0XjJKdm6fY18rfC0cVP4AtZlJOl0c?=
 =?us-ascii?Q?ujff7UJ82EjTotBQIKw6P6bAuQ5KPM0w9qWQz1LbQ3k28OpPONFMarSYFxtj?=
 =?us-ascii?Q?zoyOLdXXuMt+NDHEHPjOCF1wWyMRxMK4pf27DPy6VfLmFo7TEVq8Jlek78HY?=
 =?us-ascii?Q?0thA1sRz8/Z4CnjM73ym+OndREy34ddRwOPW6MhqkOoC0JKSbwCfWLb3KSXg?=
X-MS-Exchange-AntiSpam-MessageData-1: PC19x4UctgjRmh+PbrM3IbdFaf7MIeQoHfg=
X-Exchange-RoutingPolicyChecked: PTyCViur06WQiNDmE2z4ySxgqVVt/p9RWVWQys8egfGo3/xhJGAF/J9gLrZjAPxIo36TSYKelD1GH28ikH2f9EfNaUt8RG0EHcxn0JMJNnO7pB5JpS4VDOCAj8Qervt4iZYpRnUKvwQ+8np4F0XYq3RNEoFZCjphzXtPAZjRby59P6iH3LB4U8WsXhUtS5nJ+YbBWT0Nbq9fFP56EKquLyLm7Kg9nq8JSQ850dHIl+PhjSkP9p08TbVpqmIV4U+CQf9R1lkvcwdxz2RD8aALFENaENWpsMfV41x/34R7QK+As8k/3N/osRXr+mnEZB+Qv7AyS/V+Ahz25a3dOH7Itw==
X-MS-Exchange-CrossTenant-Network-Message-Id: c93d083d-aad5-4b81-6180-08deb4b8003c
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 08:32:30.7023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Jf26XwxCmh00gJ3czSHJcMnv3m2gTv4qQDKN2WVICo7XkMdA4RSOKEHqMSx3hPpCCEzCRIScCkQUD1/8VzrjXBBcEtfFU0UhLAX0NQM15E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF1C4B3BAB7
X-OriginatorOrg: intel.com
X-Rspamd-Queue-Id: 3777E5690FF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[31];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288942-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,lunn.ch,vger.kernel.org,intel.com,linux.intel.com,resnulli.us,lwn.net,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sashiko.dev:url];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[larysa.zaremba@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Action: no action

On Fri, May 15, 2026 at 03:44:35PM -0700, Tony Nguyen wrote:
> From: Larysa Zaremba <larysa.zaremba@intel.com>
> 
> Add module register and probe functionality. Add the required support to
> register IXD PCI driver, as well as probe and remove call backs. Enable the
> PCI device and request the kernel to reserve the memory resources that will
> be used by the driver. Finally map the BAR0 address space.
> 
> For now, use devm_alloc() to allocate adapter, as it requires the least
> amount of code. In a later commit, it will be replaced with a devlink
> alternative.

I had reviewed the Sashiko feedback [0]. Here are a few notes:

1. "Should this file explicitly include linux/module.h and linux/reboot.h?"
   we do not normally, do that, but if you want to, there is a diff below.
2. "Could leaving PCI bus mastering enabled during shutdown cause memory
    corruption or IOMMU faults during a kexec or warm reboot?" - Could it? 
   Current flow is the same as ice.

[0] https://sashiko.dev/#/patchset/20260515224443.2772147-1-anthony.l.nguyen%40intel.com

diff --git a/drivers/net/ethernet/intel/ixd/ixd_main.c b/drivers/net/ethernet/intel/ixd/ixd_main.c
index 75ee53152e61..a08c0076926a 100644
--- a/drivers/net/ethernet/intel/ixd/ixd_main.c
+++ b/drivers/net/ethernet/intel/ixd/ixd_main.c
@@ -1,6 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright (C) 2025 Intel Corporation */

+#include <linux/module.h>
+#include <linux/reboot.h>
+
 #include "ixd.h"
 #include "ixd_lan_regs.h"


> 
> Co-developed-by: Amritha Nambiar <amritha.nambiar@intel.com>
> Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
> Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Signed-off-by: Larysa Zaremba <larysa.zaremba@intel.com>
> Tested-by: Bharath R <Bharath.r@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  .../device_drivers/ethernet/index.rst         |   1 +
>  .../device_drivers/ethernet/intel/ixd.rst     |  39 ++++++
>  drivers/net/ethernet/intel/Kconfig            |   2 +
>  drivers/net/ethernet/intel/Makefile           |   1 +
>  drivers/net/ethernet/intel/ixd/Kconfig        |  13 ++
>  drivers/net/ethernet/intel/ixd/Makefile       |   8 ++
>  drivers/net/ethernet/intel/ixd/ixd.h          |  28 +++++
>  drivers/net/ethernet/intel/ixd/ixd_lan_regs.h |  28 +++++
>  drivers/net/ethernet/intel/ixd/ixd_main.c     | 112 ++++++++++++++++++
>  9 files changed, 232 insertions(+)
>  create mode 100644 Documentation/networking/device_drivers/ethernet/intel/ixd.rst
>  create mode 100644 drivers/net/ethernet/intel/ixd/Kconfig
>  create mode 100644 drivers/net/ethernet/intel/ixd/Makefile
>  create mode 100644 drivers/net/ethernet/intel/ixd/ixd.h
>  create mode 100644 drivers/net/ethernet/intel/ixd/ixd_lan_regs.h
>  create mode 100644 drivers/net/ethernet/intel/ixd/ixd_main.c
> 
> diff --git a/Documentation/networking/device_drivers/ethernet/index.rst b/Documentation/networking/device_drivers/ethernet/index.rst
> index fd3be5d20397..39d2ff526cd8 100644
> --- a/Documentation/networking/device_drivers/ethernet/index.rst
> +++ b/Documentation/networking/device_drivers/ethernet/index.rst
> @@ -36,6 +36,7 @@ Contents:
>     intel/igbvf
>     intel/ixgbe
>     intel/ixgbevf
> +   intel/ixd
>     intel/i40e
>     intel/iavf
>     intel/ice
> diff --git a/Documentation/networking/device_drivers/ethernet/intel/ixd.rst b/Documentation/networking/device_drivers/ethernet/intel/ixd.rst
> new file mode 100644
> index 000000000000..1387626e5d20
> --- /dev/null
> +++ b/Documentation/networking/device_drivers/ethernet/intel/ixd.rst
> @@ -0,0 +1,39 @@
> +.. SPDX-License-Identifier: GPL-2.0+
> +
> +==========================================================================
> +iXD Linux* Base Driver for the Intel(R) Control Plane Function
> +==========================================================================
> +
> +Intel iXD Linux driver.
> +Copyright(C) 2025 Intel Corporation.
> +
> +.. contents::
> +
> +For questions related to hardware requirements, refer to the documentation
> +supplied with your Intel adapter. All hardware requirements listed apply to use
> +with Linux.
> +
> +
> +Identifying Your Adapter
> +========================
> +For information on how to identify your adapter, and for the latest Intel
> +network drivers, refer to the Intel Support website:
> +http://www.intel.com/support
> +
> +
> +Support
> +=======
> +For general information, go to the Intel support website at:
> +http://www.intel.com/support/
> +
> +If an issue is identified with the released source code on a supported kernel
> +with a supported adapter, email the specific information related to the issue
> +to intel-wired-lan@lists.osuosl.org.
> +
> +
> +Trademarks
> +==========
> +Intel is a trademark or registered trademark of Intel Corporation or its
> +subsidiaries in the United States and/or other countries.
> +
> +* Other names and brands may be claimed as the property of others.
> diff --git a/drivers/net/ethernet/intel/Kconfig b/drivers/net/ethernet/intel/Kconfig
> index 288fa8ce53af..780f113986ea 100644
> --- a/drivers/net/ethernet/intel/Kconfig
> +++ b/drivers/net/ethernet/intel/Kconfig
> @@ -398,4 +398,6 @@ config IGC_LEDS
>  
>  source "drivers/net/ethernet/intel/idpf/Kconfig"
>  
> +source "drivers/net/ethernet/intel/ixd/Kconfig"
> +
>  endif # NET_VENDOR_INTEL
> diff --git a/drivers/net/ethernet/intel/Makefile b/drivers/net/ethernet/intel/Makefile
> index 9a37dc76aef0..08b29f3b6801 100644
> --- a/drivers/net/ethernet/intel/Makefile
> +++ b/drivers/net/ethernet/intel/Makefile
> @@ -19,3 +19,4 @@ obj-$(CONFIG_IAVF) += iavf/
>  obj-$(CONFIG_FM10K) += fm10k/
>  obj-$(CONFIG_ICE) += ice/
>  obj-$(CONFIG_IDPF) += idpf/
> +obj-$(CONFIG_IXD) += ixd/
> diff --git a/drivers/net/ethernet/intel/ixd/Kconfig b/drivers/net/ethernet/intel/ixd/Kconfig
> new file mode 100644
> index 000000000000..f5594efe292c
> --- /dev/null
> +++ b/drivers/net/ethernet/intel/ixd/Kconfig
> @@ -0,0 +1,13 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +# Copyright (C) 2025 Intel Corporation
> +
> +config IXD
> +	tristate "Intel(R) Control Plane Function Support"
> +	depends on PCI_MSI
> +	select LIBETH
> +	select LIBIE_PCI
> +	help
> +	  This driver supports Intel(R) Control Plane PCI Function
> +	  of Intel E2100 and later IPUs and FNICs.
> +	  It facilitates a centralized control over multiple IDPF PFs/VFs/SFs
> +	  exposed by the same card.
> diff --git a/drivers/net/ethernet/intel/ixd/Makefile b/drivers/net/ethernet/intel/ixd/Makefile
> new file mode 100644
> index 000000000000..3849bc240600
> --- /dev/null
> +++ b/drivers/net/ethernet/intel/ixd/Makefile
> @@ -0,0 +1,8 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +# Copyright (C) 2025 Intel Corporation
> +
> +# Intel(R) Control Plane Function Linux Driver
> +
> +obj-$(CONFIG_IXD) += ixd.o
> +
> +ixd-y := ixd_main.o
> diff --git a/drivers/net/ethernet/intel/ixd/ixd.h b/drivers/net/ethernet/intel/ixd/ixd.h
> new file mode 100644
> index 000000000000..d813c27941a5
> --- /dev/null
> +++ b/drivers/net/ethernet/intel/ixd/ixd.h
> @@ -0,0 +1,28 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/* Copyright (C) 2025 Intel Corporation */
> +
> +#ifndef _IXD_H_
> +#define _IXD_H_
> +
> +#include <linux/intel/libie/pci.h>
> +
> +/**
> + * struct ixd_adapter - Data structure representing a CPF
> + * @hw: Device access data
> + */
> +struct ixd_adapter {
> +	struct libie_mmio_info hw;
> +};
> +
> +/**
> + * ixd_to_dev - Get the corresponding device struct from an adapter
> + * @adapter: PCI device driver-specific private data
> + *
> + * Return: struct device corresponding to the given adapter
> + */
> +static inline struct device *ixd_to_dev(struct ixd_adapter *adapter)
> +{
> +	return &adapter->hw.pdev->dev;
> +}
> +
> +#endif /* _IXD_H_ */
> diff --git a/drivers/net/ethernet/intel/ixd/ixd_lan_regs.h b/drivers/net/ethernet/intel/ixd/ixd_lan_regs.h
> new file mode 100644
> index 000000000000..fbb88929d0de
> --- /dev/null
> +++ b/drivers/net/ethernet/intel/ixd/ixd_lan_regs.h
> @@ -0,0 +1,28 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/* Copyright (C) 2025 Intel Corporation */
> +
> +#ifndef _IXD_LAN_REGS_H_
> +#define _IXD_LAN_REGS_H_
> +
> +/* Control Plane Function PCI ID */
> +#define IXD_DEV_ID_CPF			0x1efe
> +
> +/* Control Queue (Mailbox) */
> +#define PF_FW_MBX_REG_LEN		4096
> +#define PF_FW_MBX			0x08400000
> +
> +/* Reset registers */
> +#define PFGEN_RTRIG_REG_LEN		2048
> +#define PFGEN_RTRIG			0x08407000	/* Device resets */
> +
> +/**
> + * struct ixd_bar_region - BAR region description
> + * @offset: BAR region offset
> + * @size: BAR region size
> + */
> +struct ixd_bar_region {
> +	resource_size_t offset;
> +	resource_size_t size;
> +};
> +
> +#endif /* _IXD_LAN_REGS_H_ */
> diff --git a/drivers/net/ethernet/intel/ixd/ixd_main.c b/drivers/net/ethernet/intel/ixd/ixd_main.c
> new file mode 100644
> index 000000000000..75ee53152e61
> --- /dev/null
> +++ b/drivers/net/ethernet/intel/ixd/ixd_main.c
> @@ -0,0 +1,112 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (C) 2025 Intel Corporation */
> +
> +#include "ixd.h"
> +#include "ixd_lan_regs.h"
> +
> +MODULE_DESCRIPTION("Intel(R) Control Plane Function Device Driver");
> +MODULE_IMPORT_NS("LIBIE_PCI");
> +MODULE_LICENSE("GPL");
> +
> +/**
> + * ixd_remove - remove a CPF PCI device
> + * @pdev: PCI device being removed
> + */
> +static void ixd_remove(struct pci_dev *pdev)
> +{
> +	struct ixd_adapter *adapter = pci_get_drvdata(pdev);
> +
> +	libie_pci_unmap_all_mmio_regions(&adapter->hw);
> +}
> +
> +/**
> + * ixd_shutdown - shut down a CPF PCI device
> + * @pdev: PCI device being shut down
> + */
> +static void ixd_shutdown(struct pci_dev *pdev)
> +{
> +	ixd_remove(pdev);
> +
> +	if (system_state == SYSTEM_POWER_OFF)
> +		pci_set_power_state(pdev, PCI_D3hot);
> +}
> +
> +/**
> + * ixd_iomap_regions - iomap PCI BARs
> + * @adapter: adapter to map memory regions for
> + *
> + * Returns: %0 on success, negative on failure
> + */
> +static int ixd_iomap_regions(struct ixd_adapter *adapter)
> +{
> +	const struct ixd_bar_region regions[] = {
> +		{
> +			.offset = PFGEN_RTRIG,
> +			.size = PFGEN_RTRIG_REG_LEN,
> +		},
> +		{
> +			.offset = PF_FW_MBX,
> +			.size = PF_FW_MBX_REG_LEN,
> +		},
> +	};
> +
> +	for (int i = 0; i < ARRAY_SIZE(regions); i++) {
> +		struct libie_mmio_info *mmio_info = &adapter->hw;
> +		bool map_ok;
> +
> +		map_ok = libie_pci_map_mmio_region(mmio_info,
> +						   regions[i].offset,
> +						   regions[i].size);
> +		if (!map_ok) {
> +			dev_err(ixd_to_dev(adapter),
> +				"Failed to map PCI device MMIO region\n");
> +
> +			libie_pci_unmap_all_mmio_regions(mmio_info);
> +			return -EIO;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * ixd_probe - probe a CPF PCI device
> + * @pdev: corresponding PCI device
> + * @ent: entry in ixd_pci_tbl
> + *
> + * Returns: %0 on success, negative errno code on failure
> + */
> +static int ixd_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
> +{
> +	struct ixd_adapter *adapter;
> +	int err;
> +
> +	adapter = devm_kzalloc(&pdev->dev, sizeof(*adapter), GFP_KERNEL);
> +	if (!adapter)
> +		return -ENOMEM;
> +	adapter->hw.pdev = pdev;
> +	INIT_LIST_HEAD(&adapter->hw.mmio_list);
> +
> +	err = libie_pci_init_dev(pdev);
> +	if (err)
> +		return err;
> +
> +	pci_set_drvdata(pdev, adapter);
> +
> +	return ixd_iomap_regions(adapter);
> +}
> +
> +static const struct pci_device_id ixd_pci_tbl[] = {
> +	{ PCI_VDEVICE(INTEL, IXD_DEV_ID_CPF) },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(pci, ixd_pci_tbl);
> +
> +static struct pci_driver ixd_driver = {
> +	.name			= KBUILD_MODNAME,
> +	.id_table		= ixd_pci_tbl,
> +	.probe			= ixd_probe,
> +	.remove			= ixd_remove,
> +	.shutdown		= ixd_shutdown,
> +};
> +module_pci_driver(ixd_driver);
> -- 
> 2.47.1
> 

