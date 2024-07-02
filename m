Return-Path: <netdev+bounces-108546-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3565A92423F
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 17:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58ED81C20B07
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 15:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534BE1B5831;
	Tue,  2 Jul 2024 15:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JHwVVu6l"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFF71AD9E7
	for <netdev@vger.kernel.org>; Tue,  2 Jul 2024 15:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719933727; cv=fail; b=c8LJ9aabilAZY4fduWUddG7vNmyCLuQHSnSEXjW6qd/l5PsF8wlE/CMSn47v6SLUEHDlw4tzfPUyDteO5J7x/CmZNlTkEx3UgcmdknN66eBqxTbk/KTvXDQRKGee4RfdT85jlnAZNR4DFULy8QBthQ0A6pYAFsnUXcC0SoXKkx0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719933727; c=relaxed/simple;
	bh=uz3zUVZvCTQAwHgSuCsCUi+6ROh399XFMd9eY8k7HAE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=A9/Mje7wWMhFLKPubzLTlWubp+7e12VTAjrSSB4JFiUSm1QO9Fy/NlgEJVTSk7wLMSA3Qs4KMGHTWdWeyYaMXMJ65wThkjKOuRfSKmEL1ztGighjYNuNsoGyVXVb45iGSLrXZu7zJqlgdNWIN9kC84U4BVZEKIflTnVnciQMW7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JHwVVu6l; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719933725; x=1751469725;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=uz3zUVZvCTQAwHgSuCsCUi+6ROh399XFMd9eY8k7HAE=;
  b=JHwVVu6lHBn+s5YuVVNQTvDOLHKqcSRp/2K6BL/adKuS0/bEPjMUf3NL
   HBj1uNIGTIXI5CqkflXv0KxL01sy2PmmwxXrQOIA61DBzqjruVef+1lgd
   ggB6MZpbRtNqgF+5i5e29x4rQA2EvMWMK5upl8GHHQRdtMxV7p9HILkQR
   KSFhiR03/IV3R5+sF7NK6Og0CHA7zxOoKZIxgvdxgM+6M13BHnmFjaZmx
   m2o+FgCrDtJezYZCTCGOMIVvHMFj/9afl41gwgUF+MluBho7hp1pvm+eD
   JKS0tl335brRpz8D4ntQ0DtqS9slIrsGjvh4pPu+8w3a5PomLAMFNJIRK
   w==;
X-CSE-ConnectionGUID: ADRGSdjtRMOxhVak+dtbuw==
X-CSE-MsgGUID: A70xuNX9RhmMNI70J6c2yw==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="16943647"
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="16943647"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 08:22:05 -0700
X-CSE-ConnectionGUID: htfCiAmaTnW7QaIprruhPg==
X-CSE-MsgGUID: GlhoutMxTQW2NwjNUjTklw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="69130534"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Jul 2024 08:22:05 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 2 Jul 2024 08:22:04 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 2 Jul 2024 08:22:03 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 2 Jul 2024 08:22:03 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 2 Jul 2024 08:22:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EM+e+hDuLMlp7Jq6ydo+MykisvARMivBQuocQx0eOfQg4lTxPhnGnQGwCRb/sitMogdD/+xf9nwy69mctJ6zllKEjYJ1jj6dzaVYripS3kDUf4TAeAG2cR00hkkb24fGm1/XhjVP0oUDvDOgKAgzSZnr3dzRpU/0pLHBce67drdGS2uQAuWUjPlv0TL0JhEL4SZOgaltM3FzwTQRjQpRsulqdqbiuBkm2SPxXxrBgb2oC4GpgpGpzUzkgIFSbCtMfXhSIp8NBCtwPePRQYOKcRKOcCHGOEbZoAnt9RqwFJFjtCjFl94Ar/AlhK6wDzBAbpndQqoYfOLHw9UVekB/JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zYle1FroHwC9hBk1ARrXOz7KtPpLMCVHo+jZir/HtAA=;
 b=PRu37deMMVDyZR0mG2N5qW5KeDaiKFKknvAbQt9BONAMmBqfITHSxACWZA2AGA4k/JysBBN4a6eloTWA25LQtn2Q86l1c+CMfPeyxbsJAqwxXzF/gzDEaVzLsyQHlYzx+CzABJvyHhp2lARzGNd6brSTL8leC5h4eM+dMMm3ry8zcM49cbFnstqI4uJ9c3e9K0YWzJT3QE3mOBTgd/gHHE5Fa18WB2fpcY96rU+XxAc3hinvlQKiJjkEKKpDkAQ4mtXWuldInU7YRE38YVdcQAYXGbWOYoowkESpizpxgDHeV4iCd+1UmoP0v6KDEQbjQ7lP8xuqi1kfAv2wtO4tmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5782.namprd11.prod.outlook.com (2603:10b6:510:147::11)
 by SJ0PR11MB6743.namprd11.prod.outlook.com (2603:10b6:a03:47c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.26; Tue, 2 Jul
 2024 15:21:59 +0000
Received: from PH0PR11MB5782.namprd11.prod.outlook.com
 ([fe80::9696:a886:f70a:4e01]) by PH0PR11MB5782.namprd11.prod.outlook.com
 ([fe80::9696:a886:f70a:4e01%7]) with mapi id 15.20.7698.038; Tue, 2 Jul 2024
 15:21:58 +0000
Date: Tue, 2 Jul 2024 17:21:46 +0200
From: Michal Kubiak <michal.kubiak@intel.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <andrew@lunn.ch>,
	<netdev@vger.kernel.org>, <przemyslaw.kitszel@intel.com>,
	<mengyuanlou@net-swift.com>, <duanqiangwen@net-swift.com>
Subject: Re: [PATCH net v3 1/4] net: txgbe: initialize num_q_vectors for
 MSI/INTx interrupts
Message-ID: <ZoQbChC5gTNxBNtI@localhost.localdomain>
References: <20240701071416.8468-1-jiawenwu@trustnetic.com>
 <20240701071416.8468-2-jiawenwu@trustnetic.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240701071416.8468-2-jiawenwu@trustnetic.com>
X-ClientProxiedBy: DU2PR04CA0151.eurprd04.prod.outlook.com
 (2603:10a6:10:2b0::6) To PH0PR11MB5782.namprd11.prod.outlook.com
 (2603:10b6:510:147::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5782:EE_|SJ0PR11MB6743:EE_
X-MS-Office365-Filtering-Correlation-Id: aacf2ca9-62a7-43a7-d995-08dc9aaab716
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dQerD/2UWUY5r8EzPkVld3wVGfW78PHV1Otp33obUpXXnqS7wvebfC7cJiAU?=
 =?us-ascii?Q?PUNS+gZKo5Lv2qfSi1ZoNzkWTWReL1U0JyUsSmpR9Z19EgKRPMNpfkmthmcd?=
 =?us-ascii?Q?Tn0KxjBM6qi3hgT2VXx+sT7Ludo9w0Q975Sgh7HZGl6tQLG2uuKcS8Ald8Cr?=
 =?us-ascii?Q?sjEvHSfurkl+DU11gMDAUChDkmrDXneoDlFAB3XgSeMfQUf/1TwpqbUBjs9e?=
 =?us-ascii?Q?glAVnDTk/5LfDyVDR2vRimWa6Eta0ZFO++tQZ9RRw8xyUlxpN5jtP6kRJl6+?=
 =?us-ascii?Q?myWpYMAc++M+Cg7gLYY5ArPiwJhHjni6ID2SRGZ+j44Yl/R8lAIOoekr3YV9?=
 =?us-ascii?Q?c3ksNsAACtj1uyFFTyAW/5/8SG0jP0niArPfIzdvrbAYhTjiEOFZCUCi9TUD?=
 =?us-ascii?Q?xmkrYGtRcAsUoWLQTJwUF2iiWBvO+KYWpCbwD4Gs8mxK63IQiasidavgUDMp?=
 =?us-ascii?Q?sehEYsdI8rg3llVXuLL3lR2uCI4eZ5Lch3Q8pxi83CQUL5YmattKDuunsqtl?=
 =?us-ascii?Q?lNHh6/c8pYQWj2cfaeAk6sdHQRGBEv3jkiQVSj4cth24zIOntQdTqDc6b08x?=
 =?us-ascii?Q?+c/63aN84uXs3GFZH9M70GdPHF/Fbs85vP6+JlzrUrm4RisTZ125qHtO0/z8?=
 =?us-ascii?Q?2LZBOp3pHRSy6FAXfn+i71UPLlWQUpS3IW5Tu3UlZ9ebAJld/CxIw5sPzkTF?=
 =?us-ascii?Q?pGGerEq7LH9Q5lN5pzaXij3pkbeXLMo49Y/A/a0XMBeGGQ2ptTym2cbWbZMz?=
 =?us-ascii?Q?IUhDXiT2vSE9V0FeoNAM96E110pj8ferLB4YWk34kxGgKKjI8jPq4aSTHGHJ?=
 =?us-ascii?Q?FS7GUqeFptZ8k66WnbKrXpjQMQhbUP2QOQKZQ7gu/rCYtRnUQm+WLe3zXbIv?=
 =?us-ascii?Q?/KXpiiJJmeeWwOhZ84CCvaGPliH2YsMMxxYj+gds9zBlpM0SFqgYSuv/NblJ?=
 =?us-ascii?Q?I/DM2KlLebP66tRgcGSXrN+1/hoMaQEFPXQgfWfKXoU7q15glkbs86cf9Usk?=
 =?us-ascii?Q?C6fPSyGpWPzRTja2S7Tv4sHmYQPT4mCVi2byfJIqq1qo3wdIH43JPsSgQe1s?=
 =?us-ascii?Q?k5ZDrBm4J6HnmTV3+HprFeZiwga2miqTNty2VmqGF9Y5b8fVJsIJxjPKmcQz?=
 =?us-ascii?Q?9/W2rNhxRpKmt4UN5wrO9KfYADp9+yNLkAZ8OkhhBD8wYJqi5GWRZw3wia/d?=
 =?us-ascii?Q?C8ewYjww5AeCWfqVF/tYrc2zk2QI2fa8BH+nbCc5QT6hIfJrL/svMASBKjw0?=
 =?us-ascii?Q?Q25i/WK/GJSRFxEpKkxmdbHyDp2RCbiEJ676pJDI3VFbPej6ZCBv01zPbjCU?=
 =?us-ascii?Q?NzhKssG2fCVhLjIaenM0ypqn5SowZ4QItPHYTUMhIgsf0w=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5782.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kfJ67F4iik6PBOF26EFGTXj/RDhz79Ehhn9jKT3UCdlor0O0WcXAVk5QY32u?=
 =?us-ascii?Q?o0cTWatXC1SShAlUfrw2MBKxIpiGNqKMJPsLWkllqslhdwkkM7HnWleNfQEx?=
 =?us-ascii?Q?3wklqyJbAg72Azbl47O8nmE5Sr71iR8+LL7k31MCFYhX/FE5Tt6OjwldIM2s?=
 =?us-ascii?Q?lnX2kSFVA9ePN3L0eEVznLAZPg/uYsT6uXPZxgg0iA01SHNWSQ0bPcujX1HF?=
 =?us-ascii?Q?0IFb/HOU86KYiko9gSskJAHYUgpEHzSOzRIsKFVf1W54Yf2VGP4lz5pQHyxE?=
 =?us-ascii?Q?sATlYr3kZJ4Mzq8sSqqwbyYUDygwk9bF+X1zHtC2+EepOIs/jd2MGy30gC+k?=
 =?us-ascii?Q?EXpooQFutB3VyuVtv5LhVI/hq0Jcn5A12g9qr/tv0wzlNJHQeQN6wkdzeTbN?=
 =?us-ascii?Q?MXKSmknUSPYDQ5aaPippd1eE1R9jbxonpupJZfBIYZ6YFmIrOLaMaecjkVJT?=
 =?us-ascii?Q?YRBTXUo0yxy3x6iPICiVHgB9460DRCS+Cddu36SmGJoRgADmKOfRgoJIzWv6?=
 =?us-ascii?Q?eiDPD6P4OmNSLmxIEfPeIsZg33ca8scnkAuqQsMfiB69t1p3Cgriwul67opW?=
 =?us-ascii?Q?U/Ju7k+R/g6ovciztGz/I6fknEbe8sRAdwSqvj3dtgyr5/dyVhtjjs58gIpX?=
 =?us-ascii?Q?2D3YOP+BLj1ACktOxtVEgv+kmwPsuymlVEF2Db9GX5sM+pjwPuVX7I/VdFXq?=
 =?us-ascii?Q?Bm66baQVvnkvJl1hVOFiL8+s/CT7Z1owKp5frNMwSG61Z0PYvxq+cgxVRdSa?=
 =?us-ascii?Q?H0bNBQgvkrID4JcSvHKdKvnIxpc3JynhJ4hOQxiBpqG/Fvrg8+h3mjl8OWnK?=
 =?us-ascii?Q?DPPxtxPaIC0sxxFMpYFMq733tE2FA+dgpLcN3RO4lfKlMWMVX6y+nS88A6yL?=
 =?us-ascii?Q?iuGHCzegm6uZPW2C3Im8rF+BmJ4KpFJ9BOjc+fStBgUJtSn0UKU3khRIxC6s?=
 =?us-ascii?Q?MOaJy7K3L6JsFVoA3qL/FGdNlpcEAXNAISU12vtH62SwkdG88ekr1rNzDQds?=
 =?us-ascii?Q?ynO4FHEggo6Yokp5x0RCr4M7QjxBkz9LfLGADqQ8E5bpxUNDucwFY6jtzJQK?=
 =?us-ascii?Q?dbDQpokJj1y2p9vZE/yRU9ohhjozHxIPqU4pZ9jNf8Uao6pNas/f3i4fhwA7?=
 =?us-ascii?Q?7X5bmzJOa9rgQyeVzc2T233rYvrrYoZhdHNyECwkZDPWvdxL+yep2lE5IBQT?=
 =?us-ascii?Q?6f/CDZp5z0HvI7cEINWKkrlayyoCv6TdmLSzeFYnJkbqDbCoMtbJQU/SXGaS?=
 =?us-ascii?Q?nQmaqJA4LbCyMf3kM38O2r1PeegD1P+PHiixnybqO5iCnd5sj2XC0tEn0s1+?=
 =?us-ascii?Q?nxEVWzhLylA0zHVPvv5ayyIRH+zaQ68an4US9zU/7IAxApyimPn5KdODaYc8?=
 =?us-ascii?Q?9R8O+hCr8Uu7yHubU9luiiAECX46nO7ilhCngZCMyV+KjqXv9+OUrABLiZeA?=
 =?us-ascii?Q?MJwTQNrSNxgCNXiw73Sz5ssCy6zcvQhciHt/0PVENw2OqCg0KvK3LUYcsG4A?=
 =?us-ascii?Q?2JVUwlQMDk/SSkrchLcJNnCtl/BltOpH6wIwHWgkkVkmItH/I5PIE2JPMRuL?=
 =?us-ascii?Q?lbLkz7TCJhmnGrOeXj2CDX+ZJNUBNJZtEompeHy1/AJkr5i7tUJNpPOM9Ijt?=
 =?us-ascii?Q?kQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: aacf2ca9-62a7-43a7-d995-08dc9aaab716
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5782.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 15:21:58.7953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 12zJS0ORfmqQp2ceK3vh8F912hHQugPVxxrKziQKx2unoKS0wAyqa+RDh5PKgjfi4GdBVnG86B4loAgldxtHxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6743
X-OriginatorOrg: intel.com

On Mon, Jul 01, 2024 at 03:14:13PM +0800, Jiawen Wu wrote:
> When using MSI/INTx interrupts, wx->num_q_vectors is uninitialized.
> Thus there will be kernel panic in wx_alloc_q_vectors() to allocate
> queue vectors.
> 
> Fixes: 3f703186113f ("net: libwx: Add irq flow functions")
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> ---
>  drivers/net/ethernet/wangxun/libwx/wx_lib.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> index 68bde91b67a0..f53776877f71 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> @@ -1686,6 +1686,7 @@ static int wx_set_interrupt_capability(struct wx *wx)
>  	}
>  
>  	pdev->irq = pci_irq_vector(pdev, 0);
> +	wx->num_q_vectors = 1;

I would suggest improving readability of that logic. TBH, initially it wasn't
obvious to me why you assign 1 to num_q_vectors (instead of nvecs variable).
Maybe you just want to exit with an error when nvecs != 1 and avoid some nesting.
I think that should make that logic easier to read. For example:

        /* minmum one for queue, one for misc*/
        nvecs = 1;
        nvecs = pci_alloc_irq_vectors(pdev, nvecs,
                                      nvecs, PCI_IRQ_MSI | PCI_IRQ_INTX);
        if (nvecs != 1) {
                wx_err(wx, "Failed to allocate MSI/INTx interrupts. Error: %d\n", nvecs);
                return nvecs;
        }

        if (pdev->msi_enabled)
                wx_err(wx, "Fallback to MSI.\n");
        else
                wx_err(wx, "Fallback to INTx.\n");

        pdev->irq = pci_irq_vector(pdev, 0);
	wx->num_q_vectors = 1;

(Please consider it as a suggestion only).
>  
>  	return 0;
>  }
> -- 
> 2.27.0
> 
> 

Thanks,
Michal

