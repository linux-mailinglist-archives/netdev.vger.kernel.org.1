Return-Path: <netdev+bounces-193094-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E039AC27F8
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 18:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5FB017AD57
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 16:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB25296D39;
	Fri, 23 May 2025 16:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="THVrQIsi"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE54A221547;
	Fri, 23 May 2025 16:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748019351; cv=fail; b=m4DkGuejPMiS+GpNWn/dPNnvB0WCTStSdxqplfWtM1DFHGYGyYRvzs6l48mkPe7401JfY05Dbe7adkuMZPtV/rtFurdQhMsMfqWS0UEbziwR53C9mMPRm+uIDlzKXudsPChu5QaEb6stSZv37oO7MszSXEq4EGtiSNYPSRlgg0M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748019351; c=relaxed/simple;
	bh=2JQMKSi1AKxANMDt8XsjfiR5RE38OI4n436VLO4lyGw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aZijET5Gzo6m5EKIuC3jI9ylZaTRbtvTTNDJlirhDqug0tu8nAPnZz49N0nDfhWkohMBJpUD12hdLVfTNnCswPa5GrLnM+WXzYtsScTFmg6Pxvs9mlcjkB6+yBqqY5PV39eXlqoP1indSES1JZhjnlJjMJ1vLFK+Vwk5NdgkHCc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=THVrQIsi; arc=fail smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748019350; x=1779555350;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=2JQMKSi1AKxANMDt8XsjfiR5RE38OI4n436VLO4lyGw=;
  b=THVrQIsiGQC9sgnumaRMjhW84ogF/C7c0pruTn05RibUNphez6B8Cj//
   mAd8Sz+Po4jLs3Qbongoj82X4ACPwRqkpyNEYIfRrCzdnp7aS4riANpaN
   IHFdGiNBviWg2vTrzbsFwmcH4uJMKbm+Ze0WpVirFpRNzXeUh10fscC22
   lKi4i0apsL9JBbDbK/BiFp0uKHmpgcz2x8ti0qUFDOUcql1RDteYW1YiZ
   yp0XF7C9jhRZ/gAgHOEOxkUMDIzA6VqG75XzTwbRCG53tGU9YhRf3XG4E
   dVBSuyyAGb5lJflSy7MmU6hW+KReUFeTPXeOkOby0IaLqbxjIoKSaXbnI
   A==;
X-CSE-ConnectionGUID: DOYVxKWxSFClptl8jSkGgw==
X-CSE-MsgGUID: GhBZIhRWR4aVZVVuIPWQ3A==
X-IronPort-AV: E=McAfee;i="6700,10204,11441"; a="75478030"
X-IronPort-AV: E=Sophos;i="6.15,309,1739865600"; 
   d="scan'208";a="75478030"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2025 09:55:49 -0700
X-CSE-ConnectionGUID: BW1alAW7ReiharB1CclwOA==
X-CSE-MsgGUID: 3c0SEa2GRDaP6ZRif2iK3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,309,1739865600"; 
   d="scan'208";a="145175047"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2025 09:55:50 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 23 May 2025 09:55:48 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Fri, 23 May 2025 09:55:48 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.73)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Fri, 23 May 2025 09:55:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kX1lF3Jp62V1p5xIYXlagBkoTwGXNAjBGcJaUDzvAwsKwj3gh6h9BRIT4wo2R8bIaMkmjnMkKAUUlwdZPYJIiL4vqM5cx8mGnWOl1niJfZ9OyGbAppbkexVff72tsfZB20xvphm1wf3VTcUcWOGy4+nqxhWTeUHFkhzr4lthBOtvmlIp6DQhlW99lEedH5SNqCddpv3+SnU6VAOwwTFuTy9bawFwxZQraO/jGFMJ8nlvFyKCDhiQWvs/Ud08Sq+Gwi3ERxmSpLWxLCmwYNp/W401c1lidjnltGHbIrwpYXBXEVYGAi1xIDrVZb5FUF5KNMGN5yIdIXGBh8vaqpXplw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lyuw5UU9Ct5KGlYVxA6TAY3T5xK9Xo16KpAilqMwfb0=;
 b=f5FA2j3/1O1Zh+T3PnRhY/sqGEqFe3ygpAlFalaA0kTqvM4UPWLfBC2IY2lRviVynYQXfdkuaA1Xb7D5GIEg+damKP6TQ/hWdUkFK8oQhTXuILCVOTxQ2u7Lomnyfrt3PKNmOt7+U1lpRRJBpBScxqFGV5B4DEie9dEIy3REzlNFhBQJwrwc/Z9t2zO1XJjTV0hzkPE3+sAvqUiIcdO3NYKp1aDAYFPrqasWRAIH4pEImIUWeU0BrFOtzz4rY+sw+U9MXYO7PkO0Rhdwvno6RZZMwbMfRSvcQiC6ta8w7e2JDB+SzlrPrCpi7cTX2LJ7UYN55gZnrI+wlfp7XRppVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA0PR11MB7257.namprd11.prod.outlook.com (2603:10b6:208:43e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.22; Fri, 23 May
 2025 16:55:46 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8769.019; Fri, 23 May 2025
 16:55:46 +0000
Date: Fri, 23 May 2025 09:55:42 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Alejandro Lucero Palau <alucerop@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, <alejandro.lucero-palau@amd.com>,
	<linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dave.jiang@intel.com>
CC: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v16 04/22] cxl: Move register/capability check to driver
Message-ID: <6830a88ece2cf_3e701009b@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250514132743.523469-1-alejandro.lucero-palau@amd.com>
 <20250514132743.523469-5-alejandro.lucero-palau@amd.com>
 <682e1a27e285e_1626e100c9@dwillia2-xfh.jf.intel.com.notmuch>
 <0636c174-4633-4018-bf52-f7f53a82f71a@amd.com>
 <682f8048a40a6_3e701009c@dwillia2-xfh.jf.intel.com.notmuch>
 <e60307b8-f865-4e53-9ea6-13e198eae24d@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e60307b8-f865-4e53-9ea6-13e198eae24d@amd.com>
X-ClientProxiedBy: BYAPR05CA0051.namprd05.prod.outlook.com
 (2603:10b6:a03:74::28) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA0PR11MB7257:EE_
X-MS-Office365-Filtering-Correlation-Id: 9534e348-3987-4fbe-19e3-08dd9a1aa98b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?L9W7X6CgbJZrwePzmps4I66RgXoEr3OqAhKZ9pr/srcYXnL7/IIjEg00aAd1?=
 =?us-ascii?Q?UsNheuFPHGEaskGBcJqaNewwCXYgkFm7YHinmdo6sMhoOmM7IguC9TXfIvid?=
 =?us-ascii?Q?0EeZLz7yde/MfgpWm35bZsJyFfxP95OmPwv6ZrhtJTtDTAAwUZiA1MVsRL81?=
 =?us-ascii?Q?Ol5gcZ1gOVdQwdI3KWfyDgLnMtdXSWLWxKQmTWbQdouHyYLB1G0VeOG3kZaL?=
 =?us-ascii?Q?JBqmWID0u41RRL7wr+M3uQPAfqhHiG6HwUbhGJtKfQF6Y/uUeP9bg7V+5pZs?=
 =?us-ascii?Q?1qQEws7jmWjLxZ/lPSX4RlS+Hls+PnJuhNJtNZ15YhMwm1+K2LNqmv1sES9r?=
 =?us-ascii?Q?RV2n9Yr2b0uCxHYwQCDNZflaONArDSws5uTLf+mABKMnupuaD4w0dO+zRjQ8?=
 =?us-ascii?Q?arNCR1mZRrARNRqweGgMWm5CYHjqcIfThAyt1YNSmJR5cK5vymlB+ogr8vm/?=
 =?us-ascii?Q?gDyctU/nyRlKLeIxdWtgVJjOoRYoqRXYEyYjpJQE1lL8uv8ptBbGEN6yhLBj?=
 =?us-ascii?Q?LA9o900U3ImqVY+tCz4bPo7okPHMzQ2L4qndNZ0CeyYXoX1b2uddpGxD9dAK?=
 =?us-ascii?Q?JwJmKvk7zkkoCeCOATUS7N2stLJby0+PStLdwd9owtiaeMbPSvBdNLtkRoEv?=
 =?us-ascii?Q?+46DFPgSrW3OEHNQq5BUKAAGwfMqdXt5i0uIbrwMDNsWHIV57SVeWM6cB/Ai?=
 =?us-ascii?Q?36Bg+vRg0KncahEmbzVeRfMRJNpYodKR9MtGEZKqMXe5hEv28uzxKhylZYpy?=
 =?us-ascii?Q?nnfdx7s6LKYdLMxrLUSUXk+yLWFpTcKzNwkH3GLrBPJ/RpFYn7KfgXxh7zgk?=
 =?us-ascii?Q?KYQtZeSSTs5sQlhPyhni1UJUNAHwkASt5z0jCVQgMIQPRpxf7t+cp64TISeH?=
 =?us-ascii?Q?a0Yd1CqHQVyD+1OGAPA2v8p3PG5rcJXGZCwPAJj8ijBvXfTm1G1kuwUaes2W?=
 =?us-ascii?Q?m879uV7/gTkvCug+XHGm72oyPSobpctZJ//+VBtASSSYo+StOTzwiW7FHAca?=
 =?us-ascii?Q?RJtPh8ZOjX9sC5Bd5GpxFQP31DqVpcxsdssQigO0c3b2G0QUWf5vufhlJ4sx?=
 =?us-ascii?Q?ZRQD5S35+p4dL+zwNkfpw3lE00EmZANA/ZsVrIhpiDnB8CUSr3gU1rUAVIi/?=
 =?us-ascii?Q?OCjh0oFG9iwR+ADsyMcl+m+fqHj+REwCZrD7Ox1uEfbLvYj616hv0e7XAIJQ?=
 =?us-ascii?Q?5z6hGxyj70uWJVVh7xfGjmPULR1ss4waOn90K0cWTcVHN4ouZS2+3AkCeYCY?=
 =?us-ascii?Q?y8CsTcchWAe4c1CxnaPPZxgE+nntU1SyE2X6FDwN4Ksjod7MTrOZRIIymwDl?=
 =?us-ascii?Q?D9rUQJYHoflmmeKfAylYlQon3MrkCNso+3B7LqaEtGOES2AX1KGd3bp5M/mJ?=
 =?us-ascii?Q?kJHLF08JyvCihalN14w+2taGbGZOmcS6JWuK4eTPXPPkqhASUJ90KqStTWps?=
 =?us-ascii?Q?H60KtZm5nCI4s4ZmdJvEiYv7vjvViOXzypjit87UYRaB5qhHwRCGNw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XuPTnV1DuPNP9xGF2HWtRntOZeUl/C3xRLqHx0HbJ/XXz3b3SJJhFdA/2PPI?=
 =?us-ascii?Q?l238FLJ/g/13AWxZ7TGcdg0PM+VKdu332H/vBc2CxRsg7C1gdRQ9+ZRhBaWs?=
 =?us-ascii?Q?ZMh5OkMByiE81EbYgh0CbGWg1oSMMpRKM6blAsGQ7h1jP2Y1NIQ5cZgvGYPa?=
 =?us-ascii?Q?2hhluw9JezRVFXaXVnGJTAje6VPL5P3zedbiiBTJRDJMOHFe6iUShW7nGslQ?=
 =?us-ascii?Q?VGanz9JeKkasB6fiORZG8boERhD3JXoUFE6HLgdo9tANKCdDAy1/6PhpgUJx?=
 =?us-ascii?Q?LnrxpW5ovZTLn12auqPhPoxTWjFeGSbXvDOwkdM7SVRQYedMtYFM0dBUHGQx?=
 =?us-ascii?Q?QPf6Lr8NrCebcG5Dbe9t61ttLgoQ78aahexICNJzmBN34i1du0vGuNt/w2Ww?=
 =?us-ascii?Q?djOpFRemrM3IMH7d9nbcvTNYTpTiYQ0LcrUsbTIEsBIknxQgQNRaX7RhcNNF?=
 =?us-ascii?Q?lprL2WKdVhrHrzPp/GKBIuPF2Y+cRCk+To3uXH7tSlotP4uE6nVVmNtgOKyw?=
 =?us-ascii?Q?JyU2Hb/BSkoIRaxlqZZvuKKn5/G69/EYy6san3Y5y461P/vqShBq4TxVxEqH?=
 =?us-ascii?Q?+OU5gtE3FS+u3EbQEP1E6Pz8M3QI6lpUOzDVwsYTkJT0Xe09Fz2xQUZ7327K?=
 =?us-ascii?Q?/YBEX6Tmp6vzc7dpBsCg4UEprQ3C6Sv0Bjn6PKlzCGsvzPzvdk4rSiJWFBmx?=
 =?us-ascii?Q?H2Qlkl0Yho6Tmb+NyNuHyLjtaHi67COSFSIWLWSV7fV8YSDTT1X1/by5NttI?=
 =?us-ascii?Q?UZjhLXuFgYxk5MvsQGdxGJGO19pMJjUT9HQPspPIOUAuOKG9k7ey9xxtiLcQ?=
 =?us-ascii?Q?DRDQdmXjoEackKsd9e4/Ba9cN2SW3r9I1LudEbn/vawsvhcy9S73gZCIu8bM?=
 =?us-ascii?Q?OGCuEA4siHBaCZ8dHoL3dJvSWrJa9dHK/2SJWfQaqYp1Ti1kl/Y32W2ao+RA?=
 =?us-ascii?Q?vqoz2JLYHLglf/R9VGdHyvKjX9qmb3+mnvKoh6n+fRl42A++IgavyH4AmK72?=
 =?us-ascii?Q?CeYfSnrSnAQRP+3GaaF9kuwIo/l3QPn+v5OZ2kN7CpQCeTttcp/rG1E4/RCM?=
 =?us-ascii?Q?rkrj9y6+QT+rPap8xrygFECAhZdSsY3hMncZ0EQgVuFtLBYWjo6bGOIgM5vW?=
 =?us-ascii?Q?TNrgf2ROKXIoUlL6XPt65z/rNnTXGDtSnLshjIOcU2HUSIE2NRZ60TMkCGD5?=
 =?us-ascii?Q?9Ie+TXtFZu9UF2avFVemVUDBWU0ttd/PvNHTAg1zmjIu/1pxI9KgPftdKRh3?=
 =?us-ascii?Q?p1y/ozi2C+/SShTZ/L/HILPfC6cZefSbXGavir7MRT0ijdmLsBoM0EOR7qRW?=
 =?us-ascii?Q?sGLYWszgFDufGHfZaT6gGcv98N9rP58UuPn9hL7cB8RIoixWW70xU7U/k/9E?=
 =?us-ascii?Q?Ah4xhYaii1jpk3Y1V4ROYRQoQoh8RHenEXr5KaFRxKDO52g5mcdJehW5hSSU?=
 =?us-ascii?Q?UhgaeJdtV0QoN8sEYi9/nrV0MnzM4pQdWzDbHXBTkSJpnnxCvECHd536aj4C?=
 =?us-ascii?Q?m6K6lcwSE2s/ZvCG8alcTvPvZPDkukb0ht8mafg7V/4CXHLDNAdqoRVijTmX?=
 =?us-ascii?Q?vS8UT2a2QlCbZGRhTlvE3NJwQk0lFK+ey/6An0ZJfifqLJN4xmPa+fOUN71I?=
 =?us-ascii?Q?fg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9534e348-3987-4fbe-19e3-08dd9a1aa98b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2025 16:55:46.2352
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S2WigiL67KJDx0nKRL4h0d6V/r0A5p6b/Y4Arw411P0q/qNkzCC4Wt/k2n4adZmRKdluXkg8XHOGaKw5mK1pKHZUKDfhS27l2xpEbneri0s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7257
X-OriginatorOrg: intel.com

Alejandro Lucero Palau wrote:
> 
> On 5/22/25 20:51, Dan Williams wrote:
> > Alejandro Lucero Palau wrote:
> > [..]
> >> You did not like to add a new capability field to current structs
> >> because the information needed was already there in the map. I think it
> >> was a fair comment, so the caps, a variable the caller gives, is set
> >> during the discovery without any internal struct added.
> > The objection was not limited to data structure changes, it also
> > includes sprinkling an @caps argument throughout the stack for an
> > as yet to be determined benefit.
> >
> >> Regarding what you suggest below, I have to disagree. This change was
> >> introduced for dealing with a driver using CXL, that is a Type2 or
> >> future Type1 driver. IMO, most of the innerworkings should be hidden to
> >> those clients and therefore working with the map struct is far from
> >> ideal, and it is not currently accessible from those drivers.
> > Checking a couple validity flags in a now public (in include/cxl/pci.h)
> > data-structure is far from ideal?
> >
> >> With these new drivers the core does not know what should be there, so
> >> the check is delayed and left to the driver.
> > Correct, left to the driver to read from an existing mechanism.
> >
> >> IMO, from a Type2/Type1 driver perspective, it is better to deal with
> >> caps expected/found than being aware of those internal CXL register
> >> discovery and maps.
> > Not if a maintainer of the CXL register discovery and maps remains
> > unconvinced to merge a parallel redundant mechanism to achieve the exact
> > same goal.
> 
> 
> OK. You are the maintainer and you'll get what you want. I'm not going 
> to fight this if none else back me up.
> 
> 
> Because you refer to your maintainer position, let me just say, in a 
> critical but constructive way, I'm a bit pissed off with this.
> 
> 
> It is not because we disagree nor because you as the maintainer have a 
> weight on this I don't. I accept that and I am also happy to discuss all 
> this with you even if I end up doing the things your way. I'm pissed off 
> because you have been silent during months, with other people in the CXL 
> kernel community reviewing the patches, commenting and raising concerns. 
> I think it is discouraging that you, as the maintainer, allow me and 
> these people involved in those reviews, going through a path you 
> disagree with and say nothing. Again, it is not because you have another 
> view, surely more relevant than those less used to the code involved, 
> but because you disappear for so long.

That is fair, and you are justified in being upset.

I cringed when realizing that here we are yet again at a late hour and I
have fundamental comments that postpone the merge.

It is also the case that my time is contended and I need to make
priority calls. My criteria for keeping this at the bottom of the queue,
wrongly or rightly, was that I had the sense that this is still a
performance optimization not a fundamental blocker for end users. Where
making progress on other priorities unblocked a larger number of
stakeholders or had a larger impact on end users.

There is also something missing in the CXL patch review process. It
should not be the case that we have this many review tags and versions
yet still have a memory leak in patch1, and mismatched object validity
expectations throughout. For my part I am going to take ownership of the
fact that the lifetime and locking rules of the CXL object model are not
well understood and will offer a presentation of that at the next CXL
collab meeting. If the review load for lifetime and locking can scale to
more people that hopefully helps me be less of a bottleneck ("pain in
the neck?") going forward.

> I need some days off now, what is well-aligned with a four-day long 
> weekend for me, but I'll be back with new energy next week for 
> addressing all those concerns.

Your time and effort here are appreciated. Our discussion on the
register enumeration did make me realize the shaky foundations you were
looking to enhance. That back and forth revealed a path to get to what
we both want which is less complexity exported to leaf drivers *and*
minimal incremental burden on top of the core. I.e. a minimal
devm_cxl_add_memdev() is likely all SFC needs to do for basic CXL init.
Lets work towards that.

Again, apologies for the late rug pull.

