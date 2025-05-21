Return-Path: <netdev+bounces-192413-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F01D5ABFCBF
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 20:23:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B71F1893811
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 18:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3756922FF42;
	Wed, 21 May 2025 18:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ADDZZkQn"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161AF1E3DED;
	Wed, 21 May 2025 18:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747851827; cv=fail; b=vFzKXTHzMmXZRUxZIwMuCr0i9lRo02lHJXXBmDXnSi0yz1DD6xdJxcd1cWrEgFcIwUFUBKlEPkx3Mmqz5/la6fnUuy0fEsicLmEwAfraJnVLu2PFI/VRWTWWcxYO3lMEF/9ROlufF1j3Ft/IT6SC9NWXCQRW8i9+lP/8u6NstVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747851827; c=relaxed/simple;
	bh=CtYSBuXpONqhaxX1wFzKyqwK2rXaC2+MJ5nWA6BzU5c=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=u9o2CbgPmeGmL/6jPf5/9hl69g0KFPMUTbqPific16rCV4203fWX3ukzDExB9BTaC2uFjui7m9PMKdr07HwppIpaDv5VVucppExwMbXRWGVQ/0k63il1/9RiHmIvNuO9mtROaaHdRYnd/QTExyWteh4FH8S8R/y41r1/OVNf638=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ADDZZkQn; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747851825; x=1779387825;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=CtYSBuXpONqhaxX1wFzKyqwK2rXaC2+MJ5nWA6BzU5c=;
  b=ADDZZkQn/TnoUSFNsIbsIs1VSW9oECn2Wo2CUuz/6UhuesimtIuhCG8J
   YkDveZ4rNioNDVSWAeB0AsxuACQd0wrFEyybUIwenm1PMkJIiUBR8kdQr
   5R4NJowhhm+tDDe3jl8LTQOOSt5Gyb4slANKeKob6gcHd447wI1lge6eM
   sTCxwFBPSO4SNdENZhDmoefCh52Wfd279Qvj7eELLYY+/TWgorhPK/0dE
   4qFIh5lkdBpe031IeKwfyGJgMZDPcxIKxRDjHHi/tRtaXvtkuVmTrHL0P
   G/Bts0+0PnaiwiuhCAKJVC5y8p/40vy2Nsud7DcUAytHmso0oCyIFsSdQ
   w==;
X-CSE-ConnectionGUID: sOgzFAPJTqK1WrJ/c2kEVA==
X-CSE-MsgGUID: EjX2RGeSRuOZ3JWqnSa4gA==
X-IronPort-AV: E=McAfee;i="6700,10204,11440"; a="61255831"
X-IronPort-AV: E=Sophos;i="6.15,304,1739865600"; 
   d="scan'208";a="61255831"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 11:23:43 -0700
X-CSE-ConnectionGUID: 9SYvERySRb+G/6gL9iCJyw==
X-CSE-MsgGUID: 7F9O/QKpRkC5xatwh47u/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,304,1739865600"; 
   d="scan'208";a="145063457"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 11:23:43 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 21 May 2025 11:23:42 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 21 May 2025 11:23:42 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.45) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Wed, 21 May 2025 11:23:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bmScna3/7waBrQ4r1xFXVLhyMxQfiLjtj74Wz1IB+b8UCKAd6+/gtkhR1sihD37UVKaqJFUEsoyOorCy+0+jPXtrDFmU4DrJF0X3+P4tErSIl65DtK6omaByMT3NHFEb3KQ7ke0zb1AtCbE/Tk0nZE1C2uF/rV9HppLTrhl4Npm0xWjBoBHrFloByOZfxLF3XCEijLpDMfd0zHHXLvLTY49Z1LmhwugZdvvSRlL8DBvbdnI86qg/g8nqTBulIdY5WNhoYXLh81CTpgkHvEu6hfsA3FSiJAhC27lkGj+2TA7Vc8rFaFuZS1O4RkWVAuMbkewRy3Jo0iCMXYMXaBcUxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yjP2TLKc7nPQMiC+4tmhQK59cK7/7aWr3OzfFJ+Rwog=;
 b=cqU6uWFm36CG7iR1YdSuPvTyW8sWHEbcvpa7D0/8LYJdf0H0/MAsfQdjhswAuGAtie009HwE8n5kIBIND7jxblCQBQcNgJYMYpHtndBE+DjlEvIZ3Zc+bq95tHjT6L84Yw20cRB+wTqY1g92BBikeGj5ubRL1nayQAUzzUXdTV01D0Rtefmy0MyrOmAcKVWDXHOoVL0HaNMJyquHhmhEFXZd/xCOrrBJTpd9/yVdS70yK5/9x480wI4yCP38q6+ECpkwtyBV2Dr/f19YqCDocMgTX+nSYw5bbufnKI0bC/+uZqbyT2RR7UoizxQZgIQGGeWbo6vfec5Pq7SalYHZ5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY8PR11MB7009.namprd11.prod.outlook.com (2603:10b6:930:57::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Wed, 21 May
 2025 18:23:38 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8746.030; Wed, 21 May 2025
 18:23:38 +0000
Date: Wed, 21 May 2025 11:23:35 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: <alejandro.lucero-palau@amd.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dan.j.williams@intel.com>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v16 04/22] cxl: Move register/capability check to driver
Message-ID: <682e1a27e285e_1626e100c9@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250514132743.523469-1-alejandro.lucero-palau@amd.com>
 <20250514132743.523469-5-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250514132743.523469-5-alejandro.lucero-palau@amd.com>
X-ClientProxiedBy: SJ0PR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::32) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY8PR11MB7009:EE_
X-MS-Office365-Filtering-Correlation-Id: 84e2a959-c951-45a8-1317-08dd98949b61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4lgaLorpZwsH0Rdtc1ZA0XGH85K5yNoGZ0DKae2VXIrHKiHeTNExiFDcvKP0?=
 =?us-ascii?Q?JzvRPNIslzp1rjtUR6UGc57Oeo4Iti5F6M6SzwED0eSvmxNg6A1sqBBHMm+d?=
 =?us-ascii?Q?gSL4KCo8PryrNmpFisXVO6UR2ZCqe6JaB88WEnNzDx3RXiwlqaDkWvt5hhyg?=
 =?us-ascii?Q?mQY2NMr2dyqENNt2b6nTa+S9ljWcgOiXvwtlOHF2kAULENMy1CWn+WKLGom9?=
 =?us-ascii?Q?IGUForT7HsunzN15nWBBd9KQD3chbAHUSybIE/RVavydaMAMUcVTbgvgcHOH?=
 =?us-ascii?Q?pwU1hRk4BfBzqT99epU0SQNzfJjpN2MHHAErYcE7S7abePZaXDB4PVOee7+8?=
 =?us-ascii?Q?FuwUEPjHKsyXTtBojy7hr9nGb+C5sLo3EcA5mfMJ4r621iLBHU0DErzU1+Re?=
 =?us-ascii?Q?IFukDR2aU7EZGJRC7b+PVql8CTKOSclO/0fvxlQtJg7AUaXgpkK5WljQxlNK?=
 =?us-ascii?Q?I+YbjRGAN+HfcC/ALPBguSL5gxwTHyTE7ztiRfO4gaz+Ym2pXXDWautapuLq?=
 =?us-ascii?Q?ZvoC3rvyHsFqkV1H7OuCv82XNQ31h/lNv8/ZEMOISuwAA95Bdr3G83OUu7Ak?=
 =?us-ascii?Q?k8Ejb2cFGh6Eb7vfBLNjmysUvVzGtA7N6xkCL6JtLQaW63LH2T0ICu81uLXD?=
 =?us-ascii?Q?rFcH6GB4gURrvqfTeJXZZt3FSQA34YKMmGRSlczHt0nvkcUsF4TifX0kGgT8?=
 =?us-ascii?Q?UBYDTETq52+7/OALfHUWwySU6gS2lxBKLVmFkMgbxJfmBjIkILd5DTO356h6?=
 =?us-ascii?Q?FOWPsBhiKAEBWUvgV4FGRDFJL0eApiyu6tIkFbPFvODAwWdzAKSdALKd6ZO1?=
 =?us-ascii?Q?SUKnImAwRcoevttyxzlnU1SBvvVxSvTlnBizHPFj4LPOZiN2AFECO7Ruxfmw?=
 =?us-ascii?Q?RglOa/6p3e6L88xEgDeKG0H9MUs2B6QGsuLQL72snvYAFznzhAlO1yRdlAmB?=
 =?us-ascii?Q?8H9JRh59Br6NlVY9sGrSCXMZars3Yh2MTDwn+1JuurfjevSFLs0OJQynPgZw?=
 =?us-ascii?Q?yLslltMKU6ca+uM5qcMSp5W/AiEzw9SMspbg+OHXuM4z/5i81uCVn112m50G?=
 =?us-ascii?Q?MCZ8eXFHYPMCjIBJ/t0JL2xoLoCu1Z3DOpXkt1o9OdnG8fKKyJsuCyCHvTkF?=
 =?us-ascii?Q?snkEoyhFZl3KkoFfPsoSdFbo0pIH5MtWSRtsmTXPFZU+Ifczoctl9PdmDUlt?=
 =?us-ascii?Q?GZrfcUpIIkTLXLcwzSzZw/9PeuVhGPl9522SCqn7IKxANRw+0aaZCokVTGCF?=
 =?us-ascii?Q?45MuXLztoAknytKDZvJbDe8nPXSpfsWKBSxIopiI83FyZJMiJcfcd6lCOrWU?=
 =?us-ascii?Q?w16Lp17tcX/0kOwVzw90wx+KW++Pk/X7Qx0fLhHyKJHgVr+Fbhc4MoO4CbtT?=
 =?us-ascii?Q?ahSG7lvAV2Zijf/FoVBtqb7phR3vlSE2OnanKrKqiBZh3cGZvw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?P4vBAJsTFDZq8qgTSsMddRLGtAsFQJQSYcgQXkd4x0ZHWUOODEdzv64yi0sN?=
 =?us-ascii?Q?J9DsVyvboELX8z/Tm02rAG+NvprqB9Otpl6vSgbr/+fwSi+d3LPFMQH/aU4W?=
 =?us-ascii?Q?0LL4+VWkSaRfJmrKVUWPzeax0SYZQpnmMDG0fB4HRHD3PgtWqkg1k/GKUMUN?=
 =?us-ascii?Q?w4WrBGF+sUSnN+J8yUfRrWCocJhgXhn1yjua12p6UDXBxdgMAZTujuZ9tsI6?=
 =?us-ascii?Q?/puCwQe3uFqsFtapej4clYRgFoPVKL/Ge5zf66ezrpsQFD5atm2CuEYQMu3m?=
 =?us-ascii?Q?XLt/XU5YnTqBpR2b0cI5CuaSVlr4vM+RjTp1ZBIXrulomv5pt1bpb5m0AF6T?=
 =?us-ascii?Q?dWiGW86qAw3N62b+5fyGZ3MelFuvHn8g8YZflhoG3liwLA4ypQaJoiAA4ffk?=
 =?us-ascii?Q?zQ/aFvmcqfwL/oAG3RntaP4Gu6GSWpOlMugpHTjH/Hjn5OgYp15nnvTXMdkg?=
 =?us-ascii?Q?RZW9SChW6F6rl2VYc59wi0R2jvzjt7E94a5RO42krCGQdkzpUo/HSdOMd0j/?=
 =?us-ascii?Q?5BW8VcYP61Zh6tJtJMl/UVNLj8zQwY39zLYrVwXqPZvaheNCmw1kNopV+R+5?=
 =?us-ascii?Q?PN5Z/7bsMP2Sj/EJ0DvOXxMzG9XRjgUihdCa7oq9gzut3WyrPPPJh47q6PmN?=
 =?us-ascii?Q?B3FmubKT1j0/TNPx/HCDqzP41DuReuVf71YQHULjWMzKQhFt3uUoDlmkeZh7?=
 =?us-ascii?Q?czYvbPgOb0f0GnC0lQxfdfXKeMK2YZ43+byax6jdRuG0iHclgAfBswb4PjJ4?=
 =?us-ascii?Q?D/O0wwi0XWu2IfPcA5OMmAIxjqI/GgASdcoAff8tRBy3YG8R2GFJ05nm+Eoh?=
 =?us-ascii?Q?BQEb5+qAvnOlvpUPOEbGN+57m64a+jESFJQ/KQGjp9sxy6gscPzsL4t9pnSS?=
 =?us-ascii?Q?478UeXPUesFADDLnc4jlJ0kdV+4rSXwRfZ/gq9nwviscND4ndcGhrI5IDOF3?=
 =?us-ascii?Q?WyLmtdyU4+nEDrhtQ8DFcFwhnORlzJW4s/PBfuQJPiya+Mc+uY7ojKKeCt8n?=
 =?us-ascii?Q?f8tTa8+92d0C2jXAWKpZ8YQxQnNiginOBJWXulxaibnOMeJEaktK4Cej6MB0?=
 =?us-ascii?Q?dx3cI3q4JZUF77QFHlH1iR3/f4ZblITZtpk0IdXiLlMbsEYFl/8KV4BzCl/t?=
 =?us-ascii?Q?rH+AtePevmIq5VOSgC+Lrr3P/5P8xtnfUK2w7MiQZtFIFZK9R3lZZOyiymj/?=
 =?us-ascii?Q?eJ56cYYS0Rqcmkg0KhRlN7ZwHG4q0aqos4orwtBhaK8MDl7DzvtNAH3a6vyL?=
 =?us-ascii?Q?DcqWmjEt332XyaC0qjNWi8cmiRn7QLYazUxWSgEAyBdgCj6pgodHRN6+0+Yb?=
 =?us-ascii?Q?u7elRYarcURjLXuBYVDpHRQOW6kpBeEJhAAerddLYrBrI/Q59SypNzxnV3yB?=
 =?us-ascii?Q?OE/gxg9kMPUhIDoQ5kXlyMzrVSkszOMlc/KAn91pYz16BGwno6xFSsAi+z6E?=
 =?us-ascii?Q?9sghWaT05LC7u+QQzW5J8CFJBXeCiyubPFZoOZQD1DBnbrkyKCAa6RSFb4Qs?=
 =?us-ascii?Q?JRMjGT5DUiG361nsreFB2x548/rWWWkmORJ3UYfbKgMZHYKRLGhoSCpxAIyf?=
 =?us-ascii?Q?7UGEb9xfbChFWiOMwHVLyuaZsFo3pomDrFn/NhyDE00hZEKZ7T3rG2fzbuoZ?=
 =?us-ascii?Q?2A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 84e2a959-c951-45a8-1317-08dd98949b61
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 18:23:38.7317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lHxZz928R207qOQOY/cFyh/HoGBHUXwHUavY0wCJS5YrN794iGY1uGiyOZZsj3+mLVT0ryRUbfdKgLtLPjljJRWnWINdNtdw/ANqwvGlfoA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7009
X-OriginatorOrg: intel.com

alejandro.lucero-palau@ wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Type3 has some mandatory capabilities which are optional for Type2.
> 
> In order to support same register/capability discovery code for both
> types, avoid any assumption about what capabilities should be there, and
> export the capabilities found for the caller doing the capabilities
> check based on the expected ones.
> 
> Add a function for facilitating the report of capabilities missing the
> expected ones.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/cxl/core/pci.c  | 41 +++++++++++++++++++++++++++++++++++++++--
>  drivers/cxl/core/port.c |  8 ++++----
>  drivers/cxl/core/regs.c | 38 ++++++++++++++++++++++----------------
>  drivers/cxl/cxl.h       |  6 +++---
>  drivers/cxl/cxlpci.h    |  2 +-
>  drivers/cxl/pci.c       | 24 +++++++++++++++++++++---
>  include/cxl/cxl.h       | 24 ++++++++++++++++++++++++
>  7 files changed, 114 insertions(+), 29 deletions(-)
[..]
> 
> @@ -434,7 +449,7 @@ static void cxl_unmap_regblock(struct cxl_register_map *map)
>  	map->base = NULL;
>  }
>  
> -static int cxl_probe_regs(struct cxl_register_map *map)
> +static int cxl_probe_regs(struct cxl_register_map *map, unsigned long *caps)
>  {
>  	struct cxl_component_reg_map *comp_map;
>  	struct cxl_device_reg_map *dev_map;
> @@ -444,21 +459,12 @@ static int cxl_probe_regs(struct cxl_register_map *map)
>  	switch (map->reg_type) {
>  	case CXL_REGLOC_RBI_COMPONENT:
>  		comp_map = &map->component_map;
> -		cxl_probe_component_regs(host, base, comp_map);
> +		cxl_probe_component_regs(host, base, comp_map, caps);
>  		dev_dbg(host, "Set up component registers\n");
>  		break;
>  	case CXL_REGLOC_RBI_MEMDEV:
>  		dev_map = &map->device_map;
> -		cxl_probe_device_regs(host, base, dev_map);
> -		if (!dev_map->status.valid || !dev_map->mbox.valid ||
> -		    !dev_map->memdev.valid) {
> -			dev_err(host, "registers not found: %s%s%s\n",
> -				!dev_map->status.valid ? "status " : "",
> -				!dev_map->mbox.valid ? "mbox " : "",
> -				!dev_map->memdev.valid ? "memdev " : "");
> -			return -ENXIO;
> -		}
> -
> +		cxl_probe_device_regs(host, base, dev_map, caps);

I thought we talked about this before [1] , i.e. that there is no need
to pass @caps through the stack.

[1]: http://lore.kernel.org/678b06a26cddc_20fa29492@dwillia2-xfh.jf.intel.com.notmuch

Here is the proposal that moves this simple check to the leaf consumer
where it belongs vs plumbing @caps everywhere, note how this removes
burden from the core, not add burden to support more use cases:

diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index ecdb22ae6952..5f511cf4bab0 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -434,7 +434,7 @@ static void cxl_unmap_regblock(struct cxl_register_map *map)
 	map->base = NULL;
 }
 
-static int cxl_probe_regs(struct cxl_register_map *map)
+static void cxl_probe_regs(struct cxl_register_map *map)
 {
 	struct cxl_component_reg_map *comp_map;
 	struct cxl_device_reg_map *dev_map;
@@ -450,22 +450,11 @@ static int cxl_probe_regs(struct cxl_register_map *map)
 	case CXL_REGLOC_RBI_MEMDEV:
 		dev_map = &map->device_map;
 		cxl_probe_device_regs(host, base, dev_map);
-		if (!dev_map->status.valid || !dev_map->mbox.valid ||
-		    !dev_map->memdev.valid) {
-			dev_err(host, "registers not found: %s%s%s\n",
-				!dev_map->status.valid ? "status " : "",
-				!dev_map->mbox.valid ? "mbox " : "",
-				!dev_map->memdev.valid ? "memdev " : "");
-			return -ENXIO;
-		}
-
 		dev_dbg(host, "Probing device registers...\n");
 		break;
 	default:
 		break;
 	}
-
-	return 0;
 }
 
 int cxl_setup_regs(struct cxl_register_map *map)
@@ -476,10 +465,10 @@ int cxl_setup_regs(struct cxl_register_map *map)
 	if (rc)
 		return rc;
 
-	rc = cxl_probe_regs(map);
+	cxl_probe_regs(map);
 	cxl_unmap_regblock(map);
 
-	return rc;
+	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_setup_regs, "CXL");
 
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index d5447c7d540f..cfe4b5fa948a 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -945,6 +945,16 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (rc)
 		return rc;
 
+	/* Check for mandatory CXL Memory Class Device capabilities */
+	if (!map.device_map.status.valid || !map.device_map.mbox.valid ||
+	    !map.device_map.memdev.valid) {
+		dev_err(&pdev->dev, "registers not found: %s%s%s\n",
+			!map.device_map.status.valid ? "status " : "",
+			!map.device_map.mbox.valid ? "mbox " : "",
+			!map.device_map.memdev.valid ? "memdev " : "");
+		return -ENXIO;
+	}
+
 	rc = cxl_map_device_regs(&map, &cxlds->regs.device_regs);
 	if (rc)
 		return rc;

