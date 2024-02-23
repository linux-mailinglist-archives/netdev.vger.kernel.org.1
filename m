Return-Path: <netdev+bounces-74437-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B53A861535
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 16:08:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B76341F253D2
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 15:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B02224E6;
	Fri, 23 Feb 2024 15:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K9f4nNCZ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F0F20B02
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 15:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708700868; cv=fail; b=E3fc4S/1R6hECWiyo6wqHh4nZaJiSTLEl4FE59dZK0L+cOfI8Em+QlNoR4GR2Ai4ou4L6dlEi7pN1MIYoikMGUvTxmJ1gQfX6MWXSjJGMQcq5cg8eh3Kg5xrZQDU/mxiQ5B4cZm0YPGOfMFDwotvYLeFqnQ2ljFlEhbPeeon818=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708700868; c=relaxed/simple;
	bh=dvNIxq+9nJRQlYMWSqyFXj67GRLzWiG5YRwgf/B/ruY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=F1XPlncUQob2mvnM/LKZkj1/xpuFlcBtMkqmjZlnenQ36APFRz71noGIjeV4okobX9UprskHqVP/uqw+eIG05KZr0sTHLs11vxYpJmGnalFoLBGO5in0DTCC8xVvJMYBGBCNIpnRfi0Yij5JEt9MAgswDIIJCJ4rwBgddw42Q0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K9f4nNCZ; arc=fail smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708700866; x=1740236866;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=dvNIxq+9nJRQlYMWSqyFXj67GRLzWiG5YRwgf/B/ruY=;
  b=K9f4nNCZTZi3RYed+ntj4SPVPNa0+SEXq7rh/JabnWK2wMJ8cLOAgZBs
   5lNOD/XnD0wHbh0QloWhZq6IIA6jjJoC4T5TF9J+jmQN9EwLcrg/jidAs
   rYRI/F6h0DcrKkxBZym8QNxVv/oGhsIjvhQilm6WLVH1SQBMPhGVOy/L4
   X0XDKwfYOR+od4pysbUjjK6U7unq+tZnbdNyI8E46ffMzw7Uf9c0Pmof+
   vczt2T3MR7roWQ63u2pOn6sy/+lF3aON/FRkZMfzMLlJ5v90vXErhNnV2
   kriII/T7vi0smW2CXTIaIrZO1WCnhKX5kOFXI8rYxFWHekMQ6Kam4+h+B
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="2887625"
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="2887625"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 07:03:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="10592207"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Feb 2024 07:03:27 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 23 Feb 2024 07:03:26 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 23 Feb 2024 07:03:26 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 23 Feb 2024 07:03:26 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 23 Feb 2024 07:03:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TLHbJYW7aGVwLx9rZCjnj1Ter3qZAOASgOReZmblvXzIOcHdQ83UiAmmlLuTczJwmgF45fF50wudjsRdNmfHIEXvgjPhTbhYBuB51Ad8EXwIMmMeS01h5TxH2fAQfMxQlfRdC0EYTfsZVGC56LI2EloOnPxxK2wzNBF/6E+9vm93Pgh+/Xo5WwZ6eBvnzJf6oGXwoHJU/LdvW0Tpi3GoWzo7YrDBQo229Z1NnUCrPVVyrmkSQcZTejp4gLfNinn7dYAbHlO6Dw0ZPRU3qaSvVTCmMH7VXBQfkBGvMfGTC3Zj/6JQFzXRSofyKTkKhgUJ+jOXp/UpCKbyT740GRCq+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x4fZtZAGvb6zmcDEtlKYFgqUQ/sxqbTOje1KsB0CXZ8=;
 b=kPYZNYfDfJVKyjq5NMqTtFid5D4xRTa46JfxYQf6kIa/T8lNNE8RrFz+pt+pMgNI/My6q+qkIiXmTLNsLvTMG00G49FBwNw8LQKbkqDOoyWOFAtMYg6gmeR9A/1Tlpk4xiMTtyJ/uRkd4+/6VmMy9Ml1RWgvNqCL+akKHxPmrt/ZKva9iE6mXMsA53fcdrPU67yymeoB8JSOhZ14AINpA6kaK4m+8slYRNsTp+Dz5wB28ZzloJN9XvB4DNLzoASYLiqHWVdgM5PJMRdQB2ASB6aTTlHvEWvmv3ufJ5A8w1ra01RalxjBT8vzM2aFthRY5fJaMv0RQJEjq80cvVmW7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 CO1PR11MB5188.namprd11.prod.outlook.com (2603:10b6:303:95::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7339.10; Fri, 23 Feb 2024 15:03:08 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ccab:b5f4:e200:ee47]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ccab:b5f4:e200:ee47%6]) with mapi id 15.20.7339.009; Fri, 23 Feb 2024
 15:03:08 +0000
Date: Fri, 23 Feb 2024 16:03:02 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<anthony.l.nguyen@intel.com>, <magnus.karlsson@intel.com>
Subject: Re: [PATCH iwl-next 2/3] ice: avoid unnecessary devm_ usage
Message-ID: <Zdizphq09RItsiaA@boxer>
References: <20240222145025.722515-1-maciej.fijalkowski@intel.com>
 <20240222145025.722515-3-maciej.fijalkowski@intel.com>
 <b50229cb-e3b0-44f8-9725-6592b74dfebf@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <b50229cb-e3b0-44f8-9725-6592b74dfebf@intel.com>
X-ClientProxiedBy: DUZP191CA0005.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:4f9::19) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|CO1PR11MB5188:EE_
X-MS-Office365-Filtering-Correlation-Id: be49e20a-76a4-4aea-2921-08dc34808b5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: biyB+/7sR4N3OmPrV7WA4ad4wktQHwJGNibZvxnxyY4IP4W83cBE/VvFeeaR9K7EitKE7RX1HmrDD3LmGccjGeF0Kjvrv41HCCa+89RE4EeVWQWRd74WUj5lysmNiGuaP351aJ4rXNuqlbv9Q7bLLHlQ2aWKjX0Py7GkP4NHH1+ZfCadXw8AN9LgyGY9TIuJrWytclDz1kDV2WoziH0p9z2GbFT4AUZMMo9+5HGHLOiEU3a9YYsuq+aHDr6w+KVP9yOBM6TuRPfE1XYtSYZ3QNAmESA6So29dsR2aCwt0EGSzRTVZ/sg1vqISLiVToyenAK/UCL7bEinieDFXNqorNuwCcB6x5VKLCmZeU+hNCXMi/tZRNaY2uM+qJ8VGrlUT3mFnUDalp34E/sVdFWNPa/bVJRJPxqtv1VpXL/byMzBe9kpzvsJAqNhn5QmhfCz3lEZBNwQYFRJfIdbIlkzdsiPWt3ObtgGvAb6fPnEWi4nnygezsumSTw8XdUc040wi2+gjOKL2wU3BrvRqICwlQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ux8s7akDyikwUhBGx2MIqbF0j3j8XmJw33joDvv0u99lGEBjnZocTiMcqYvQ?=
 =?us-ascii?Q?++1TmzD79JTFhlYKzDq3sGKyjCQEIetM0CHvrBgI1AY9akwUeEfJns5QG98D?=
 =?us-ascii?Q?WyThvAaj6L5xQeUQ4vz39U196nEmXMUOohsajIKKvzic/waj10sLN9YxLur2?=
 =?us-ascii?Q?jEiUZssLuDeUGuM2rrl0imwmWDq00RMCjTK+9UdNHUj0BK/qt8ydMhWTWe/i?=
 =?us-ascii?Q?k0pU7+xJ4NRu7AeCRRf1tRSEKGTXJ+KwUU3atqTA6s+vkFFbtZ5GD5cLT2To?=
 =?us-ascii?Q?zCB2T8FCkunSR8Yj6aRxAsXhQe3hL738Ffn4yaPH6pO5NlBQLupasl9urfzy?=
 =?us-ascii?Q?2JiUP1SSo2cieBRDSgvfVg8xFInTRyBNQCYY6v5+dpRTdVtfWUjBVNFsCIpr?=
 =?us-ascii?Q?n97/P0Sc5/vPXrmxpOfXkuQFarjgsuXG/KEoRB1PtewD5sf6HWrE7jTIbF89?=
 =?us-ascii?Q?3IJF6z09d5uH40/8Z9ns8lNlTLNmIXThR8fF0UdhYv3AZ4kKvSVxi2vz2Tnf?=
 =?us-ascii?Q?KjUwji+ObaveLEYjt8qNOLWq6VSTSlX9tFOo7aRCfQqCrRrQiuJh3Ct9BMlF?=
 =?us-ascii?Q?AcTmd3REEP5j/JmZmpago9O4kNpFJDrAwPrfpS02t4r34uAudd2dcmlMMRsB?=
 =?us-ascii?Q?2WRcK87ygOJ1C0By2PaKSyf6fM6gxFEeGyp23QlXztNIHmsxz6lnL+dFVe6k?=
 =?us-ascii?Q?cFgkGs2kMncKaDUGgOCxQxwiW0KvRByphbNxAmx+8d6oF6RAQDvIJgobqlj2?=
 =?us-ascii?Q?tK42GJ/95sFzeFC7QepjIPOXjeWlEbPqO7yqWYPTzZqNOILvJJGFu01QkeJO?=
 =?us-ascii?Q?XMvMRU38VZnazSa9hxbtS5xGluOp+/47Xeh/wCz9NMsRVyvxqCo5xQAYC6jU?=
 =?us-ascii?Q?uaFUTFsNWnSZdp1Vn/Uej7FqAze0H0ApyMN1KFx2jAQ+q9AQizESTCbNNX+3?=
 =?us-ascii?Q?p7aigAcqUaaaQv5R6n4zkYxWi9YTCbs1TFIWK11eHVUPUHHjxD4EC1+mgUeY?=
 =?us-ascii?Q?FFdUnXsamp5Kb6uSj1aIVIsXGNT3OWVz7RxqHqxmLpmADG9SxWtIRBk8W3pR?=
 =?us-ascii?Q?UnS1t2faqb3HaD4+pmoVUIMpsEq+9xjXcHQ/9HxQMUI5MkkdMfusOQdnjfo9?=
 =?us-ascii?Q?AgjG6knN6uSgS30pAclQlH9PWGNFqR2s7MJFMxu4AaiJMTimEjq209HNR5Wv?=
 =?us-ascii?Q?a1y4QjKpa2bA0fa49gjKEINbcf+Ujfg7pdphrukTdPwA7I1ndbCVnOXNcFs6?=
 =?us-ascii?Q?8oEKUx6cDspPtz+6/XrXpKb2+dCqBEwqGWJjzGVRXSQchm8k/LhWgJkSSPsr?=
 =?us-ascii?Q?Ns+2sz6oJkbs+eDvB3zqDr87GNKJ+0bZ4OopUGwxgfSAS7sDVr2GhMYHIYQH?=
 =?us-ascii?Q?Tnt2zpA8MUupDwtyZoM6ZHf6hA9cz/4nCL8kPD8tJ4qS53eEpjP9Opl2I8i3?=
 =?us-ascii?Q?MU1AoB+BgND/PClmjYPVJk0T14I/DPpGdWVsi3vIIbFap0iHMW2Cdc2rw78+?=
 =?us-ascii?Q?aoo6dQ1MyQlE5Vd8NgY/gXlkLH0ICmCml2+RJdZI3xMxbapkWunXhOKaCeIp?=
 =?us-ascii?Q?nKd0y+EjVFdQ233JtSaBctJyjXnVlpJzwLoSUhz40b6xEMdzghAtQ8mUVmIV?=
 =?us-ascii?Q?VQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: be49e20a-76a4-4aea-2921-08dc34808b5a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 15:03:08.0261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 43lKxMDnyQeNQiEeFqFVy+wJUR1EHhfCYSQQK0ed/hq5JTxOshOBWOcYqO2ym261tcdRALhGBc2cpYBLADH9sZK3wLoz0DWtYxZ1KIeDeIY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5188
X-OriginatorOrg: intel.com

On Fri, Feb 23, 2024 at 08:45:20AM +0100, Przemek Kitszel wrote:
> On 2/22/24 15:50, Maciej Fijalkowski wrote:
> > 1. pcaps are free'd right after AQ routines are done, no need for
> >     devm_'s
> > 2. a test frame for loopback test in ethtool -t is destroyed at the end
> >     of the test so we don't need devm_ here either.
> > 
> > Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> > ---
> >   drivers/net/ethernet/intel/ice/ice_common.c  | 23 +++++++++-----------
> >   drivers/net/ethernet/intel/ice/ice_ethtool.c |  4 ++--
> >   2 files changed, 12 insertions(+), 15 deletions(-)
> > 
> 
> nice, thank you!
> 
> BTW, we are committed to using Scope Based Resource Management [1] even
> in the OOT driver, so you could consider that for future IWL submissions
> :)

Thanks for reminding me about this, will do that.

> 
> [1] https://lwn.net/Articles/934679/
> 
> 
> I'm also happy with this as-is too, so:
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

