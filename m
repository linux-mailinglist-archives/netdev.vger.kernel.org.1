Return-Path: <netdev+bounces-188828-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF5AAAF08E
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 03:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8ADBE9C7BB0
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 01:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94BEEB667;
	Thu,  8 May 2025 01:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A/u75ifF"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212D220B22;
	Thu,  8 May 2025 01:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746667065; cv=fail; b=p4XdeysBJpfZQoqkezLn9LAdlvWhf+kjIMsWtbT4y05j7g0Qwgc4w/exgq1+GeTvlkUtxBL4OhLBRzCFXhWgiNNPhAUorZqdA99pvK5l+I/obDdcSYpA+Jq8YooBoqFyUbfObMiz8/dzNYWVxw0DkgPm8WfHYk7ZlHKTV0khKXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746667065; c=relaxed/simple;
	bh=gpaBpKGpPHxP9pT6Ey22diijuFaRILvhoRltWavKPqg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Sn9BK26PcgqOGLxpndJuSBdFDYdb9e0cEspWjytABUUF2yWbC48c1yND5kEekhLFvRmoQsKx2R88bfChX+4UbdgMyqp5RUhNkpNvBeuVKQ/dmRIsRulIz34yv8ZOrapbEygI1BwIAizgZIwYiz3MG0DKNPLzgxbkVkjaWQp8DjE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A/u75ifF; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746667063; x=1778203063;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=gpaBpKGpPHxP9pT6Ey22diijuFaRILvhoRltWavKPqg=;
  b=A/u75ifF6Zw3BJMfUw+WFb45EPGGDRPfXPJI8qfjvj1naPmYZ7Gth3rL
   Z0hD/iMwqSScKiIKDl619sXLSmYYsuPBsw/+TM0Fr1p+7qizsNRrXT7Qg
   DzXDNvYq6WMfKHZIhXBpN87Ug2NX8XhmmWZh0OVgX6LS4q4KoW+8CkO+Q
   ZSJ9EOLnAq/LCWuWwS2S/G5uFPVrd1hgozaO8Cg2zYnKI6hjh8hLmSTex
   3NEw3WsZIT+SUqr8JQB7UyCDjRlyAPtzL5gXiXQ6Y38+wZXhRGms99x9U
   28EdHNBulgO3QK1+6cgBjIN0jmxk+VdK9RWmMKgkj+ByY1wo5m32EzHpu
   A==;
X-CSE-ConnectionGUID: BUmDNFyhQEi/WluDvM4YKw==
X-CSE-MsgGUID: MRlzpO8PS5ClsnuFHPH7dA==
X-IronPort-AV: E=McAfee;i="6700,10204,11426"; a="48335616"
X-IronPort-AV: E=Sophos;i="6.15,271,1739865600"; 
   d="scan'208";a="48335616"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 18:17:41 -0700
X-CSE-ConnectionGUID: L5UDl/4OSGuAXcc8FYAEQQ==
X-CSE-MsgGUID: 1XEgUYnkT7aqk6t29vRBmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,271,1739865600"; 
   d="scan'208";a="140903704"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 18:17:41 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 7 May 2025 18:17:40 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 7 May 2025 18:17:40 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 7 May 2025 18:17:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TeHVE+ICkQqo4v6SWcB/Pw0VSXWFi423JJWBVqEMZtOavkohAmkOTryLYEfx+c47kUFekN48pnA9yqCGmktQv3GQHLtf8OQvHkovvdGMzoGvQ8HO1mMfDZ02Hnmal+nxNwcHq/d9VjqlUwjPSgAyKmxcfxUi3aFGiFt3IE4GyYC5iVqgTrDM9fbhRrwmKv2qaChDhlnBrfAXSsccMk9Gq3z1uS/G1uDpn53/YecjXv8PvP1IxUqAhxAJ7H4UeUZPbsKKH/ddSqkel0E4Kw+Ts6YYVczaN/+TdX3hdaxCZKWjNAqlkIMWsBL+ZZ1EBu8Bl7v+mtdMGoPDVl1MT1N7Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s3LMVxMAckBvK7W2Q6Q7imTDI2AbjdaSQEb3bi74ULQ=;
 b=MwQyh462bwFmVVWaKQYiAo5cX0CTa3PIvZmR7MBcjcTj9BMywSJjVN35REjFh45x+rthxdPW7uPUXIP0UBhR47/dzlIh/Npehl32i1+U95KXsCtKoWiRq129t374dhxYFqedLuFa+QTpgrJC4Pbcxkzri6prp6bMoAN59kyxkbFW2OWpLFDxFdrRr+fo6kEMzmCRhKr65qL4fY06XD9kVnKpP2u1miA0+l88JxAaGomhy4OvNcXIGPggTZQyK8JcZESgM3do4k7KkJ2u6/djVjddOoNehXamiR8CMXqznrGn5Fy6Ptap0//tOBG0fghtXqIaH5c5fJR6BQdntWPj/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8794.namprd11.prod.outlook.com (2603:10b6:806:46a::5)
 by PH8PR11MB7992.namprd11.prod.outlook.com (2603:10b6:510:25b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Thu, 8 May
 2025 01:16:53 +0000
Received: from SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720]) by SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720%5]) with mapi id 15.20.8722.020; Thu, 8 May 2025
 01:16:53 +0000
Date: Wed, 7 May 2025 18:16:49 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>, Alejandro Lucero <alucerop@amd.com>, Zhi Wang
	<zhiw@nvidia.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, "Ben
 Cheatham" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v14 16/22] cxl/region: factor out interleave ways setup
Message-ID: <aBwGARkkDa1DmTkQ@aschofie-mobl2.lan>
References: <20250417212926.1343268-1-alejandro.lucero-palau@amd.com>
 <20250417212926.1343268-17-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250417212926.1343268-17-alejandro.lucero-palau@amd.com>
X-ClientProxiedBy: MW4PR04CA0044.namprd04.prod.outlook.com
 (2603:10b6:303:6a::19) To SA1PR11MB8794.namprd11.prod.outlook.com
 (2603:10b6:806:46a::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8794:EE_|PH8PR11MB7992:EE_
X-MS-Office365-Filtering-Correlation-Id: f2fa2516-24b2-423b-2d09-08dd8dce0478
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+cmEZ3U47GE6/TBPOwlgs0fLqm3zJiYiznnhjViPAHOa1FJt1lPdEqZ4i0Ve?=
 =?us-ascii?Q?MOhOIqyQTvi0Ej63SP3+rOBL3MW/UkMXMCiSFi7J0D09AMQdJbAjO0iLlL/V?=
 =?us-ascii?Q?wntZSy+CpnHRKlAwUTUg05padu2g9OTmYpzEMwdVmGy1FPhc/J872dmHzhD9?=
 =?us-ascii?Q?Biyt2QUtliuaJgKfowewaZRkpuF4ibeTzDe1iW6hHBtMDWbqHzdOTfZg/i8s?=
 =?us-ascii?Q?M2K1KSbUEgxDBiVtQlf4MVjjmDTkH+AmltTXRkX9qmKFyLaatKI8uhgeb3AB?=
 =?us-ascii?Q?pt6l5P1Mv0LDHfqdVvPPnhF998kZlcpIxxmg5hMQnG6PxQqs9Ah8UcjpuDl4?=
 =?us-ascii?Q?OFB9agwgkKxayp9eAQIeLJ9C78hoNqLggFXfaoXnbd6VtSIftknC4u1c0FsJ?=
 =?us-ascii?Q?SU658I1wPfZfPxue2HFdasm9RZv/YZPSAHoUZNmzCul+xN2nGZHqdGjCHYD3?=
 =?us-ascii?Q?kn5CukpNUeNys19/k1cMcg4Z/FttDOVFrxn7DZ9Sp94czuec1pFnr+qJOymm?=
 =?us-ascii?Q?gGj97opKSuC4/zlM77eivt3oyYzS0EHqAPwvcCey7XSdk1XCV6t3dZmtldF0?=
 =?us-ascii?Q?3isaWwpP34R9Z5B5fwkuyL95nlTMW0026r/x/sVbbjQgNmTGR01eprD2QhxP?=
 =?us-ascii?Q?WU/KqeeG0b+JatBLeVaIwmCKnpawsnP8/cOVVxvJVUREFl4CeZEEq6QrZbaX?=
 =?us-ascii?Q?h93SmQ+eHea9SK9AK3S3QuzactzV49B+mU9zeVlqBqlLwkKTnAQcKzkyDrVh?=
 =?us-ascii?Q?sYYaJipUiJ8ekHog5FLD3LaFuGv6jLxqZJh6iJCf39PEZNBQ1/KGXd6w+1zm?=
 =?us-ascii?Q?Udnh6NPDLU9PRRFoCetVJvtbqoePo7SFvqxDf9ogpv3oQ7fWxJAz45sQlI9D?=
 =?us-ascii?Q?ximyDej882x+1zv8zx5jh1lhE5zqgRn9RIFz36sdbJWS5+fqkirmTmygHzA/?=
 =?us-ascii?Q?EyPO38LvhnTyDYLCqsphErn2fW4TkZNDW0OJCv4U9h3JdMqTPEDvZAe/M9MJ?=
 =?us-ascii?Q?cXnOw78LDaMv1iDuiD2DUiWcXkvKPvZEGVupRaB1MT5fJrGwyH4JAEjD+nB2?=
 =?us-ascii?Q?I6OqeZt+oShSJ1paSWNtqfsceYH0FvOty66t5AbP2KbZ3fn+TtowQuWQOlE4?=
 =?us-ascii?Q?2HhY2ir309Xbl3NuOgDrx8DWb9NkoB8z6FDSybM5oKMp8Qvnx+FdGMRzCCzn?=
 =?us-ascii?Q?YfAE08WzdtN172OW4XhmYqt7i95ZOg22ep0VlsrLO8UtNwNUfZhfHbg7l6qZ?=
 =?us-ascii?Q?xq1MtNfQEsm5lFTSXxAXtU5hMnPjJLrR5Hpw4JqDrY1K1wZV/IGQDzqRKuqg?=
 =?us-ascii?Q?c7mI1It2Cfy3RkEOdv55+njsbmwNRKNZZRj35ovesqYQnJzwLmnRhWOj85r9?=
 =?us-ascii?Q?odxygKN9Ac+cIm3KUoV5xeaBRsASQHKP30CG05wYEMA3mvvu93LDMiFvFRZx?=
 =?us-ascii?Q?AChatIJd0h4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8794.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?O5zEk7G7Ep1F0qBjlmKSX5kdbVjiNC5nw9krD9J4LSI2/jWQh5QX/eXUk8+J?=
 =?us-ascii?Q?/mrk8sqqRKDbABHZ+83DTncyZDfXUNH/aW+R1+5zUGJF81AOvrrTyxm+Nx4K?=
 =?us-ascii?Q?6bgRWYuNzvsnjXvCbUdfkpI3uZhkfN6Rwtawpr0GmylBycCO+Ga5k8xgLKr4?=
 =?us-ascii?Q?9mnn25bpq7/dsLFr5fs2dmCfMBGk5YQTAizNbnivckR6oh14Eci9B0nThZgP?=
 =?us-ascii?Q?LD3p+mzrLkKMl/c8DufsqNgp3NcX7dnNmaX5MNgqruvnkDqbTXtv6EvnuVhP?=
 =?us-ascii?Q?4/AanMrIasTA30G/Nf4zWCO93kf19idem+H5yEOFWUtx6/WZansLx3uX6Dtj?=
 =?us-ascii?Q?WPZqZbXVBuoTzu19j/lVSRkTmgU2bBOald8Xk8blOHLF3RPlC8UnJ5qKvuhs?=
 =?us-ascii?Q?kh2W9Ue44Ao/tuMUbjnWIuCMui0hH9S1QefzVoFH+Mye+WB33ZxHbey051ce?=
 =?us-ascii?Q?QqC0eenUAYHcRojJnZFKP0TJAKL5Nmw6YkAa/glZ1prJrDkGi7c6JA2ZnKSh?=
 =?us-ascii?Q?906LgVI9yzO/+szIU7/9o8Ji/qGcY6ENx5A/lq8kavQ8xGXgJouLOCnL7SUp?=
 =?us-ascii?Q?dM9+PdCX5Dj3+Y84GX0fpb9RC4ocbVQz9OSVKuZ99Ad/poDJGq9a1DfLpIVT?=
 =?us-ascii?Q?pNcSNQvQACkjLYDTpHRWbKom9hwaD0yhXdN5b+CugEp7iHYEn05mc5FGdRYc?=
 =?us-ascii?Q?zJEpZyX3q+LgLM6NUqmQzHYrmVZo8m+xyzG6SCcpMelRvw57L/zAVg6yg8j+?=
 =?us-ascii?Q?9bagzw72MJNo4WL4daFUiLdD26XomjbtHpxeKxTM8wae5E/J/absLisRKcdq?=
 =?us-ascii?Q?RFxdpFjEHFiUds2LNBA2AjdSFhJlafNGB/bwRqCwrJ6G9dLqlwcBjWJXKK3/?=
 =?us-ascii?Q?Tww1VywwT1eu29O5ZeLg/cBpWrrb9tBz5ms0e9P6zvdC5WwFDEMcu4ZdIhZk?=
 =?us-ascii?Q?YMEzP2fSchyWIOD4Bixb1TbVAJxqQVm+gCwmNvEhTaytwdY2NHQaeIJgybJa?=
 =?us-ascii?Q?+fnrSU0XLZ2mRajlPEcRY+k1TQaENUDe8uwm+EZhDB3zIxBdrre9OxNZtMSN?=
 =?us-ascii?Q?JQ9Qa0BLaLCoiWOpHMHfaqJ3/fFHzyD6RnUxkdo7qCO8oOjNBuAj1VovgXP4?=
 =?us-ascii?Q?lhY8t6pIaKLn7pUvdOcqcCV/b4g0m6f8V4upt2++vIIWX4aW+KcX2drGSHGr?=
 =?us-ascii?Q?deP4U2BOaRtigfv3Lk65FJYj84jnFtivSHkN6yFfgE4mkwAzzy/Eni52aeQY?=
 =?us-ascii?Q?tzF2qUjeujREW2m14/Noo4wyI89U51aV4WyyIT5LYREgH+kGjM4VzcuKc1ed?=
 =?us-ascii?Q?fGWIqiR09Ror1CB09D40Phq8p04Uc6ldi08haZXvm/W8E4gCWiuHLHKj/LPe?=
 =?us-ascii?Q?o1qFTR3Q0iBk1IGqroBLuZ0CEcKa9eQg4fxEySLtsWapgnslk0UxOPkwgXH/?=
 =?us-ascii?Q?H/A7vat9WP1Q5Y5AQJeohK/sZvuNWbw7Ae/uZbgrc2xUeWnRhTqQR99Dv4s3?=
 =?us-ascii?Q?vMNWdsPva8cdYpQX1snd950p7g727Qko8V7KyL8xLcDfVS2fgM8gULdMvMEP?=
 =?us-ascii?Q?B4g+zku92BtLYPrTRLfszO4e/GeUb0qMWxHzus9a2dNVzC50UNTMk3r5ABwS?=
 =?us-ascii?Q?VA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f2fa2516-24b2-423b-2d09-08dd8dce0478
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8794.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 01:16:53.6747
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +52RGuLCJylz931RVA+7Y9z2skeA99PjOOrCSv3npBF3dU01wrYzXZtUKMr2n56BcMTfxzVI092db2at34d5QiQF66abFWkBTwbzIn4mZ2Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7992
X-OriginatorOrg: intel.com

On Thu, Apr 17, 2025 at 10:29:19PM +0100, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> In preparation for kernel driven region creation, factor out a common

Please define "kernel driven region creation".

Also, please keep repeating that these changes are introduced for Type 2
support and note whether there is any functional change to existing region
creation path.


> helper from the user-sysfs region setup for interleave ways.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Zhi Wang <zhiw@nvidia.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> ---
>  drivers/cxl/core/region.c | 46 +++++++++++++++++++++++----------------
>  1 file changed, 27 insertions(+), 19 deletions(-)


> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 6371284283b0..095e52237516 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -464,22 +464,14 @@ static ssize_t interleave_ways_show(struct device *dev,
>  
>  static const struct attribute_group *get_cxl_region_target_group(void);
>  
> -static ssize_t interleave_ways_store(struct device *dev,
> -				     struct device_attribute *attr,
> -				     const char *buf, size_t len)
> +static int set_interleave_ways(struct cxl_region *cxlr, int val)
>  {
> -	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev->parent);
> +	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
>  	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
> -	struct cxl_region *cxlr = to_cxl_region(dev);
>  	struct cxl_region_params *p = &cxlr->params;
> -	unsigned int val, save;
> -	int rc;
> +	int save, rc;
>  	u8 iw;
>  
> -	rc = kstrtouint(buf, 0, &val);
> -	if (rc)
> -		return rc;
> -
>  	rc = ways_to_eiw(val, &iw);
>  	if (rc)
>  		return rc;
> @@ -494,20 +486,36 @@ static ssize_t interleave_ways_store(struct device *dev,
>  		return -EINVAL;
>  	}
>  
> -	rc = down_write_killable(&cxl_region_rwsem);
> -	if (rc)
> -		return rc;
> -	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE) {
> -		rc = -EBUSY;
> -		goto out;
> -	}
> +	lockdep_assert_held_write(&cxl_region_rwsem);
> +	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE)
> +		return -EBUSY;
>  
>  	save = p->interleave_ways;
>  	p->interleave_ways = val;
>  	rc = sysfs_update_group(&cxlr->dev.kobj, get_cxl_region_target_group());
>  	if (rc)
>  		p->interleave_ways = save;
> -out:
> +
> +	return rc;
> +}
> +
> +static ssize_t interleave_ways_store(struct device *dev,
> +				     struct device_attribute *attr,
> +				     const char *buf, size_t len)
> +{
> +	struct cxl_region *cxlr = to_cxl_region(dev);
> +	unsigned int val;
> +	int rc;
> +
> +	rc = kstrtouint(buf, 0, &val);
> +	if (rc)
> +		return rc;
> +
> +	rc = down_write_killable(&cxl_region_rwsem);
> +	if (rc)
> +		return rc;
> +
> +	rc = set_interleave_ways(cxlr, val);
>  	up_write(&cxl_region_rwsem);
>  	if (rc)
>  		return rc;
> -- 
> 2.34.1
> 
> 

