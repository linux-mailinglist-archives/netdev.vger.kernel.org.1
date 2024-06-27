Return-Path: <netdev+bounces-107310-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC7991A89F
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 16:05:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E644F280FDB
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 14:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E04219580A;
	Thu, 27 Jun 2024 14:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZLnifpAa"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A32195803
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 14:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719497149; cv=fail; b=X0B9HJnW9i+/lrnnJ9Aq4vgMs/ETnMXSxwQVZXrl7iR8J6JotPqRQxLrFgp+grSDQxc2xnNzvf+D5TnNImzZHYwHGgfzAVYBqx/gPhh2FqODj0E5yBFNOYDbiPDDqUGPjJLXU20Ndu5tqqeXYfq56kg/L6A6R/jkKlgBAPB52OA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719497149; c=relaxed/simple;
	bh=HkizH20B6i4+Vp7aW8NB7SsvsQfmfwo3FWac7ao+qkw=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Hyo0u15WOYG1kq6tmxfib5W6ACiEGKJ6zErPUr2PFP/0qj90/nWowISCiRXUPEU1Bo0G2wFDbEImx+4vJ/+kvF3Kgv9WfhnQCPPWobQZjxebnurHKwb7duxwenNrWS9+rKE6uhn1miL4vmQb3O+slrr9geQZk3iqhKZ5D4iN+7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZLnifpAa; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719497148; x=1751033148;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=HkizH20B6i4+Vp7aW8NB7SsvsQfmfwo3FWac7ao+qkw=;
  b=ZLnifpAaTzJL8C5A8jt3ed8GwIQMQroMhLZYZupftW4YG6+mGxY0PC7u
   wxvHW4WLk7wT2Wfg8IJmknvOKegh7ZEsW2jgXAqDFzYdrA/fveZrqHHPP
   Rr4rw9TB6eN/zLj6U33L/4RZ7XXczkm9V8fexuzSOSgpfFL1BhabcFzJA
   18V6nyqayiWsXI8Llkmz0an9Ka6nsGMm8eaxZyKKZddj8vMcOMA3qUp1/
   XUh+JVzaQ3AvI2Y2KQ0ixxiNyJdrShsM3Au9Dt/g/xqMe9Fj4QH0X2kph
   /m0qpnbRpOfilRayuD0wkIlR+ZRRUj00da9L9v0uTLnvWxS1/IIfsQwb5
   Q==;
X-CSE-ConnectionGUID: qy4h+4mNQCe++PCZ47x2Dg==
X-CSE-MsgGUID: eUEGPjrWQLSHCAqoIIdk+Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11115"; a="16582938"
X-IronPort-AV: E=Sophos;i="6.09,166,1716274800"; 
   d="scan'208";a="16582938"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2024 07:05:48 -0700
X-CSE-ConnectionGUID: cexhC/8DQCqiKW7UxvZU2A==
X-CSE-MsgGUID: I1k98P5gR7qsm5QrK7J+Rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,166,1716274800"; 
   d="scan'208";a="75572720"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Jun 2024 07:05:47 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 27 Jun 2024 07:05:34 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 27 Jun 2024 07:05:34 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.49) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 27 Jun 2024 07:05:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kWF8cXwkPKsOr6wYfmkOLI9Kwt+DI9ubFsNCpZ8G1ZwDd4YZbeFYs28afJ+3yKzJWpR9s6ZbHa8kVMcP6vRGhW24kSJk9kfb+zuhDNVHAACOCusj5wPexdnA9tNgiF7f734mHbqKWb7qtoKTlpJXFnWpZqLC+OOPSvEm/LbDDkoOHyzOBd99zh+IQs1ejp7xM7RKyQ0r1VZTfcO70AprGRFel3BhC1XjWFAFp0ttu2ZAlt2s/lOfOJ00yzrzxpE9mSrT6UFVifncmTt+BS77sV8s8lnlm4iYjbf7m/5Y/8ed3Sxo9rFmYlOAPrZWEB3/MXs20/IEvHnK2Xi/TqEfPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AoD5PPrqL2JGMWeVnKL+P9Sawce8tyy3/j0AdgqQADE=;
 b=Fxfb9QsnvADtrRbbgoL9KqjvM9f/MiRMJi+99lxAoZf55iOrotZA4AA6zwa1BRMlapqHDB+DwimIsEUwJtf5hbI5hqlU1rOtGguHXqYlomdZX/Sg3ENTrUxWBLi1ICQE8cWeVAKw+QJubaGjeogQMS2tC/OLT9UhYZlqEzvJqexKNTokAt4zBvHH+QDTr9dgoTX5km/BRdWJ6GYir/W0bTqI16rEPN60wlssYJUxu3eTijplwT6UGyK9wsasTqUDuiA1loKkMsi3BGKbXznoBM4mYuMv73wMNbVm9LLyJbzOCDY4QyEU09oDniOPnLD+KeSidSm2pjvmaAwxz0Q33A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB6039.namprd11.prod.outlook.com (2603:10b6:8:76::6) by
 DM6PR11MB4706.namprd11.prod.outlook.com (2603:10b6:5:2a5::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7719.26; Thu, 27 Jun 2024 14:05:25 +0000
Received: from DS7PR11MB6039.namprd11.prod.outlook.com
 ([fe80::3f0c:a44c:f6a2:d3a9]) by DS7PR11MB6039.namprd11.prod.outlook.com
 ([fe80::3f0c:a44c:f6a2:d3a9%3]) with mapi id 15.20.7698.033; Thu, 27 Jun 2024
 14:05:25 +0000
Date: Thu, 27 Jun 2024 22:05:14 +0800
From: kernel test robot <lkp@intel.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: <oe-kbuild-all@lists.linux.dev>, <netdev@vger.kernel.org>, Rao Shoaib
	<Rao.Shoaib@oracle.com>, Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: Re: [PATCH v1 net 02/11] selftest: af_unix: Add msg_oob.c.
Message-ID: <Zn1xmmvdJLFebg2i@rli9-mobl>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240625013645.45034-3-kuniyu@amazon.com>
X-ClientProxiedBy: SG2PR04CA0174.apcprd04.prod.outlook.com (2603:1096:4::36)
 To DS7PR11MB6039.namprd11.prod.outlook.com (2603:10b6:8:76::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB6039:EE_|DM6PR11MB4706:EE_
X-MS-Office365-Filtering-Correlation-Id: dbaacec5-90fd-434d-c0dd-08dc96b230fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?O/TW0/kexMGzQ2er/8P/0uXByvFMd0moOqioicAN93BxbV6JG89btSlPP8LL?=
 =?us-ascii?Q?Jn+BirDec93cVP1IYwdEU7RhQ9OwbKrYbakVmEoQPfJfZXBB2l5DJbKOD8sM?=
 =?us-ascii?Q?LZ+8ukLN5w7qaFSnXW/RSuLwgohz2Ab6ePDux6lHjg5ouDgkvoKbgvd9SwPx?=
 =?us-ascii?Q?R3B4Plwo3VeobTi+TwV5Or+u+pqlY656UQYow7Xo2xhiUrzNlnUqX5kshvxk?=
 =?us-ascii?Q?nJOXNm+4LVwUx0o3CENtXfn5QSdbkCjDHDHXQa+P3OCp0tTHWTnci6keo+Vn?=
 =?us-ascii?Q?STiwZqC9iKqfj9PTL/25HXGIfVm0RHQU2OjZfYqq8TMajcWEdNgciqlO9RPO?=
 =?us-ascii?Q?U1zUynx0nZC+qurtvHoscE6hhWMJw64h8vJCe9cHybdXPB20+OXk0kGz/IWx?=
 =?us-ascii?Q?UP/Ij3MYBXK7HpPpr+ws4pvQT856AInBEMZHuvMDCVIPcOtNvmJnmDrRjB28?=
 =?us-ascii?Q?IziE1ZHagOgRy1aVRA8+Eg4DhbqARpw6M7OXv64/U1XlRPh4EGDchwr8t0D1?=
 =?us-ascii?Q?2/DfP2Hf0qq9+5xTmkFxDsbOg7Svwb5PM59o3kUNRBuGBBh8aWoY26hZFgJs?=
 =?us-ascii?Q?a9uquBrRtve4Bd1vR0YwO4tRZuwgxfmpVfmGGd2NdOBTBm+cuUmiyjRdzh2n?=
 =?us-ascii?Q?DWszuItVwMIGqnrWcKR4NqBVlU0SuCdWKpNU7vZHIVrpMc3Qrq7IoePGyo0p?=
 =?us-ascii?Q?t2M+vSbUrZe1utwTFH4HEdhaRWDus44XoyyDrlEv9prQDKy6e3QTuX3rNfj7?=
 =?us-ascii?Q?MCG/1TE5GokIKW+Z1KsXjKrtLZhnK4YDf41y2JMZcSF6r1ojRmyTNh91A9Ow?=
 =?us-ascii?Q?Wsm7xFJTk0lAcy59RUmY1Q7VNWmFK1dZ1Tat5+H71JgsRFavHBFDkRjVdpsR?=
 =?us-ascii?Q?9HOBz0JA7DPmRvml/fEgOWKYgjyN87MZI7xHcuVyoTYBHIpkdG5D2Hq/Ydpq?=
 =?us-ascii?Q?QVidK/DNJ7PFXZyD5RXvBd2RVarJHg39UFhQh6kudt8L4exdh3FSK7am0YVH?=
 =?us-ascii?Q?azKlejfI7lick3hef56h+HeVsGRJI5GXAcFTeURRCb3uMQADaaIuG6yjpGsj?=
 =?us-ascii?Q?BGruc8LtlUqdzC1zc+oK3vyGOtVm54Sv9Az4UHCF3s5yYwJ032/7GWKtP7rW?=
 =?us-ascii?Q?pzUAYYrV1TB6mpNVuYIbm5frMPqYgjHre9JHCX/69bdktF4OPTIslzsTcHpo?=
 =?us-ascii?Q?e9j2LMcR7xrxnssmphoEcUMNA10ZrBz2n2xt+7SSWdg78p3bVvR7W/x9QRuy?=
 =?us-ascii?Q?ANR+bDpG6u3waAmIRP0MsHXiyvoQ6H16i/muTuDWBdsSytyjpiKqo5/h7hf9?=
 =?us-ascii?Q?sLn3a+2wR5GWGbJlEgDLnRLE?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR11MB6039.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?c+vofw1ETs1xo5R1N/3Q045bPxNXfu4UKCvejYIDHyi5hrPyToTpaaxQNhhF?=
 =?us-ascii?Q?6HtedmPMTi/izPU4CjxduFXu0SgdAd8Wu4/OvTHoi1DQPOa/UY7cmnFpxSH8?=
 =?us-ascii?Q?jFJ47lEPZTDlfWNTf0YsdB9m20nVJkhpQLVCwBT2NhrhDaghAxxO7tyf68HE?=
 =?us-ascii?Q?yfKzw4Q1z9HMzsXG95O2AIvu39zFQpdD7xxR4XbnYdkteL9CHGfv090lG23f?=
 =?us-ascii?Q?YyKXaQNLj/QzoGWQ0iGhN+1YNH52+0hA7BfqSA/uc0vy/pVGIPG898LcVjMu?=
 =?us-ascii?Q?FftgSRpeYay8SSW71T5dfOn53ZWOm01MLJnQNx38dz1984ZJ/ehZFG1FQgdT?=
 =?us-ascii?Q?qAmI3f8AeJOxvb3oji7sAc9ynD2NOMBWzQaKcdzuuaNhppJk7DFiAePlyual?=
 =?us-ascii?Q?JqvM7YIIxq6dLo1fSEVmF5otS2BW66Db+J8nG0UJOd0YM4lFYm5xqq9O9RJC?=
 =?us-ascii?Q?jwLocrsYZMKpG2vao2BuXGf45XSWB5d/gWNDBHrccbvGCXN6+ykMaGdwfCaq?=
 =?us-ascii?Q?RHkOUvMZcXQvk3gRpuWiKAXIAFT6pQ0FexJheP0yrQBgKXc3EAYhAp5OdyTA?=
 =?us-ascii?Q?DN+PUQugqJWHyPbqjdLoXwOPrGn5TU2VkTgdLtrSfMpBGpq2/0gjQ3ClplH1?=
 =?us-ascii?Q?Lb0YerYrObhvJDDcWCO3PdkKvVqyPo0wb6HoxjRONMD6QwTYVQyGRyKoYlXp?=
 =?us-ascii?Q?1ZSuqSV5FmFMAHOrNxYJ1URsYNO7f9l1PrYvpJOMwPw6U9ua3DDbBiuIxFFg?=
 =?us-ascii?Q?CP0lLLwatyDcQPipULG3LzLDMk+akGExr+ZdeKohJchPglHq6ZLC7X85vRF3?=
 =?us-ascii?Q?i+0Eg7/1b3KaeHuKBpxj2DDD4YmNEmgbgG1Z3vsg3S/FddRVozozvMH+tnRt?=
 =?us-ascii?Q?lHXYeUpFutA3StWDCIdbB7GuKxLssmKgKzK3TUqf4VSL2vHI4EJT3yGV83pj?=
 =?us-ascii?Q?0hENU9eDMUQgs4LoesRHJKv+ZgvKlkWgkQYSYbK+9T9J1B4l36IMesUFqNX6?=
 =?us-ascii?Q?ycN1WO7tCH5SV0NhO2lFrzVC1P2UhcDlDidON0lLATshzKTec/zHFIBTszWf?=
 =?us-ascii?Q?HaveSKY/k5G8JEYnu5/GVO43BYgZMikD6rJYOQgNbc5QqCrYAg9MeP73fDjT?=
 =?us-ascii?Q?a478ELOOQqGrzpbKMlM2e7vtRTIsmhuHwf5bGNCUOvmea0UV81/g9vwyirgq?=
 =?us-ascii?Q?TCVTfIYI+cF7v04ZkNntL9OYKRFlgASrRL96chOxtH1VDvUVheCg2M0n/fbB?=
 =?us-ascii?Q?SokQLIYSQdjPxaXXT74plJMZz2IUcNgsxSVjCrWJOUaXc6LZcOiVtKOq+I3r?=
 =?us-ascii?Q?Y0dGYaizmkBOuPH5VNh/GoBXBdzLaq7Ta9VNaKpJwLCAiIJJ/wEaOHhl5HzR?=
 =?us-ascii?Q?KtwlLPi8BXB0jItuZG9ENPvMQgog1Uwl7Hnv1OtBby+j4EaH5cDEN4Wgya5I?=
 =?us-ascii?Q?CokDeXRiQCUt3Sdn3UZTnlaSV4QJDSdV+YtPyhVtbqFHPb7QuyruYs4ksqSD?=
 =?us-ascii?Q?oi85hrmT0Cnk4vAsj0Dm1O9g8kTXFlCZ1jZlu16XOeHN523qEaofnBr0qu8L?=
 =?us-ascii?Q?G2dtgYFxKPrIFpzngeoKD3sf8j26N3lxkFFpXPyk?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dbaacec5-90fd-434d-c0dd-08dc96b230fe
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB6039.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 14:05:25.3460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KqjX6dH9er4P1A6n0yO/Phq64XbWegU/WsI1GK6ZBzXM/zjTdk21uBNvgklwWXCqhwrIwl5BAjKoGhZdXN/S9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4706
X-OriginatorOrg: intel.com

Hi Kuniyuki,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Kuniyuki-Iwashima/selftest-af_unix-Remove-test_unix_oob-c/20240626-033725
base:   net/main
patch link:    https://lore.kernel.org/r/20240625013645.45034-3-kuniyu%40amazon.com
patch subject: [PATCH v1 net 02/11] selftest: af_unix: Add msg_oob.c.
:::::: branch date: 22 hours ago
:::::: commit date: 22 hours ago
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240627/202406270118.ajdL2qcN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/r/202406270118.ajdL2qcN-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from msg_oob.c:11:
   msg_oob.c: In function '__recvpair':
>> ../../kselftest_harness.h:119:40: warning: format '%s' expects argument of type 'char *', but argument 6 has type 'const void *' [-Wformat=]
     119 |                 fprintf(TH_LOG_STREAM, "# %s:%d:%s:" fmt "\n", \
         |                                        ^~~~~~~~~~~~~
   ../../kselftest_harness.h:114:17: note: in expansion of macro '__TH_LOG'
     114 |                 __TH_LOG(fmt, ##__VA_ARGS__); \
         |                 ^~~~~~~~
   msg_oob.c:120:17: note: in expansion of macro 'TH_LOG'
     120 |                 TH_LOG("Expected:%s", expected_errno ? strerror(expected_errno) : expected_buf);
         |                 ^~~~~~
>> ../../kselftest_harness.h:119:40: warning: format '%s' expects argument of type 'char *', but argument 6 has type 'const void *' [-Wformat=]
     119 |                 fprintf(TH_LOG_STREAM, "# %s:%d:%s:" fmt "\n", \
         |                                        ^~~~~~~~~~~~~
   ../../kselftest_harness.h:114:17: note: in expansion of macro '__TH_LOG'
     114 |                 __TH_LOG(fmt, ##__VA_ARGS__); \
         |                 ^~~~~~~~
   msg_oob.c:140:25: note: in expansion of macro 'TH_LOG'
     140 |                         TH_LOG("Expected:%s", expected_errno ? strerror(expected_errno) : expected_buf);
         |                         ^~~~~~

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


