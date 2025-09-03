Return-Path: <netdev+bounces-219623-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8F59B42630
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 18:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94E243B4586
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 16:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1727D292B4B;
	Wed,  3 Sep 2025 16:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JI1fQ9zz"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70EF029A9FE
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 16:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756915413; cv=fail; b=Mfc2L1zwaEvrzFqNBBNdt439llQebbwWHOCg2uVNAMhhg3Z2ZGKztijjAHwyXm+gjCqBvD1xsGeOBna5MXu2hrMFzE942w/uJ1ARRCk/DDp6U8Bh9j3j8e/w2/EcN8FfM/yT8TlaCR9bjBFvZ+E6jMylauuYhS/hnBJYz78yUxA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756915413; c=relaxed/simple;
	bh=HZM+i9mgwk7cUTpqioON3P9pKPfBmxQFBJCQGE3RxKE=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ey/FnotZDr4aaGIu3dLn0+NvtczQJM3Rmhfi4Oxg3L0tHJvkHz8F4XPwnyLgHuwygyG2u3mZMO4UXQxWPeBVHbGswXgZ9xFrKxJmARfY8jBvJon55LQSnzjfEk6BG/khygbG9v1BHKO7TACnil5cue4LnMNbKJk0q7m3g8RM6+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JI1fQ9zz; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756915411; x=1788451411;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=HZM+i9mgwk7cUTpqioON3P9pKPfBmxQFBJCQGE3RxKE=;
  b=JI1fQ9zzjj+w6CWJw22DJTEMFSh7d77hZNpqFM591KbBk8DOCEOTYbg4
   4UjXVIyuoLJxzAa54+dYOrL9CagU1UL5/nJsdbrwFDijPkBp9CE5GCLUh
   eXhTSpD0vJi2UcYpwN0WMxXOKnpj9pNFseCds4VsFaY+B8lLEczfMit6i
   Vz+UZUzmIaQJ20CbGhjOJ3MAzs+LBz4zdcWcCUklbUXygCe4BbBjEuKYj
   u7/hOI5SVqC4dWq+hDCqfSTScwA5vXlycfyBO31vLguMbVGsB8OwIFnSj
   NHuxlV6oD7wEvqy7xiCUpXjV0lZttxN1bFEo9Kf7rQH7yyZylLCYh+cVc
   Q==;
X-CSE-ConnectionGUID: odAhXDOOTwiABTXMYmMLYw==
X-CSE-MsgGUID: e74yK7tfRMW4oM9JGpX6Sw==
X-IronPort-AV: E=McAfee;i="6800,10657,11542"; a="59380864"
X-IronPort-AV: E=Sophos;i="6.18,236,1751266800"; 
   d="scan'208";a="59380864"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 09:03:21 -0700
X-CSE-ConnectionGUID: 1ugYF7cgR5C2f362xAAlUw==
X-CSE-MsgGUID: A1vhvPaySf6+pTnh4sKU1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,236,1751266800"; 
   d="scan'208";a="170881313"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 09:03:21 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 3 Sep 2025 09:03:20 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 3 Sep 2025 09:03:20 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (40.107.237.44)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 3 Sep 2025 09:03:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VQgz0Bzn+gS7KB6AXPIy7D3O4v2zXda1mV6CwrCQKMiqtj3A3KKL/R4XKyxXFuhGPbmRWFFsaeb8L/G7B5HG9iKBaLgB+m1tpl/dGNSxXVELoRBYXTRoH0niln09x8gmPE1563K0VudbBGlvSakde919p7QdP/qmxAs0m9PwG7o09/G9Osb4ENdZaS7hiCq3vtz5kMTl/n06csZ0k5mcvJrPiB6F0+iwZkwaI/7qBCu3sKyOsQ1aKb2JnGC/qjty2SFb1LBleCQplqspMYMJTz1pKtPPx1ja/9A+JiwEpUSZ+YhXLqUYqbTiwdlJ6j24I4bkhtRnn99tPq9Kt66cnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GLtSDMfY6FRaZWRp6yK1PtKlKFrTK/E+/Ektvlr/xkA=;
 b=TqFubDSqbx2vB2b/n5bFwfdHlmRs4hF5KvEJCWKlIItJr9hgvV2AQy1Guw78QAWqtkj0UGsYgu+bcSaXr7v79h/augds0aDA/hqbWCaBNUvXRQekbj926+OJMQmQdlC7nQlaUF9n6pdENPtyqy73Es6dHXSf9ggzihSCgCFVQ22DRjg7He1m9uVVwnUkMDwMFJ2dRdQqIj9z35oXh20kYrFTqRlXGH6uQ0IP+Im9wN7t3XNVja5vs6xq8aPhkOVzROysaK39Gi48v4tH7LFR+7LHv8cCqWf8Q4XkiXmCsZqNi0lkVA41JwuL2WdW2ot3/KwMsxmG3UBYokhrRDuKIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8665.namprd11.prod.outlook.com (2603:10b6:8:1b8::6) by
 MN0PR11MB6133.namprd11.prod.outlook.com (2603:10b6:208:3cb::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Wed, 3 Sep
 2025 16:03:15 +0000
Received: from DS0PR11MB8665.namprd11.prod.outlook.com
 ([fe80::8e7e:4f8:f7e4:3955]) by DS0PR11MB8665.namprd11.prod.outlook.com
 ([fe80::8e7e:4f8:f7e4:3955%3]) with mapi id 15.20.9073.026; Wed, 3 Sep 2025
 16:03:15 +0000
Date: Wed, 3 Sep 2025 18:03:09 +0200
From: Michal Kubiak <michal.kubiak@intel.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
CC: <intel-wired-lan@lists.osuosl.org>, <maciej.fijalkowski@intel.com>,
	<jacob.e.keller@intel.com>, <larysa.zaremba@intel.com>,
	<netdev@vger.kernel.org>, <przemyslaw.kitszel@intel.com>,
	<pmenzel@molgen.mpg.de>, <anthony.l.nguyen@intel.com>
Subject: Re: [PATCH iwl-next v2 1/3] ice: remove legacy Rx and construct SKB
Message-ID: <aLhmvbZ_XXEFzNxW@localhost.localdomain>
References: <20250808155659.1053560-1-michal.kubiak@intel.com>
 <20250808155659.1053560-2-michal.kubiak@intel.com>
 <644cab8d-948d-4a32-a5b9-d47b3441eb97@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <644cab8d-948d-4a32-a5b9-d47b3441eb97@intel.com>
X-ClientProxiedBy: WA2P291CA0014.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1e::25) To DS0PR11MB8665.namprd11.prod.outlook.com
 (2603:10b6:8:1b8::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8665:EE_|MN0PR11MB6133:EE_
X-MS-Office365-Filtering-Correlation-Id: b56c2b16-1f58-4ca5-3e7a-08ddeb0363dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0wB+eHlJ9IB4VS7NZoJYhVFcVYCYOx2NcYZ4QJ/J0y7laYsMa7l4ae9RJLSS?=
 =?us-ascii?Q?HfBkdpJypb/5xWxqxvmYoHj7/ZL+ENVQ1M5TPYXjjutsXpxP+sbKjqXLMaMx?=
 =?us-ascii?Q?De/UaRAArOx2J+BB5+7/Qaz/bWy5v3Wqr3tt+RNQNTKgBaThxRnJBQIkC2mL?=
 =?us-ascii?Q?QA071yl55aO/7O3SvTg8AQr1uVyRMNCE94EJxVrD7C6jc8+diFkgZMV6yiqc?=
 =?us-ascii?Q?gspXvE3iJCt6zAw2Xy1Z2W4bTaRYlJWqp1ITVSkMFtNUE+HSDXYquunLql02?=
 =?us-ascii?Q?5rjSIyce7MO3vxWdwLuJD6xRR/ilc84eVC7UJQD2ZoMQ41aqw8mNsPUo9OZ2?=
 =?us-ascii?Q?75IgIYp1TQ1ZJkJaVdroDOO/A23X/khqmPWYjg7/iesTzk7FzFgpduKV3+VG?=
 =?us-ascii?Q?18ChrCXNs9Wmm9HY9Xsdi1duN0S2FWnr8hZW4S5FMuQDwVq/BwUMweY14XfR?=
 =?us-ascii?Q?fTdFTEeeiXsgd+bnC0+E6XiIXDgkkNArGmX1cLMl1da7+vXF0Y2gUCVfjbyh?=
 =?us-ascii?Q?FKwDCp4bQcjZpJtkr9F3Kf7yUJAB+JsMsIre5iWK7mOxqDPAztmE8Z2y4kYM?=
 =?us-ascii?Q?jJC2jBug6cngyVNqGZG8FB2OxangxD5kKDCjnOkJLK2ddhmXfSv52lDOE27g?=
 =?us-ascii?Q?nlZ6ioqj+g0mKpA4SxkJenlXtSLcHZimbFBNllKS78VPu1rERJ5flnZ3kN7p?=
 =?us-ascii?Q?jdOStjQDawrrxqOtAQ+dMLP1yy0LCzWCMvzoVtYK/1DcHV4etJS0tRgdpf4B?=
 =?us-ascii?Q?cJm5xlaHHC4VI0LCj/DM7/mqdbElXruc+jArPyKjboxOzJTqDnp6FE+GSKuz?=
 =?us-ascii?Q?MkDgr/wfS87C+8UqpAIq7SrRAnvlrB7FXS/EiGn+N4okuXQKUHwatPYguCB1?=
 =?us-ascii?Q?BcPdLq+4fIAZUyTK3/sKfehf8ZdvXIoZZysSSOQOEPXOjTlgBuJQpHu2eBui?=
 =?us-ascii?Q?HjKs5gXb/B9f/vbjvKVTbicW6DMAE1wAzQKNn6n0G0xb8owbOnWSZ8ze7M04?=
 =?us-ascii?Q?5XNzeLp/mqhvVlju1kFVmjxrTuYsFnFd/qqCseu7vBfm6hyfzgmg2ttRObT8?=
 =?us-ascii?Q?MrqrSGhR0d+N6w+rY4EQ+hKY+cdAS2o797xtaEQgg3g2ossf+iaGToDx2biy?=
 =?us-ascii?Q?oDXFJ6qY8ZntHbPKCz1jByKVmsaartDGwylHYF8KJj4wXgf4kaewxr2Gxubf?=
 =?us-ascii?Q?EgwbJkpxwgjmX4VSmvFdIiv9AgaJBGVc/YXGvK7dulsRc9LsCaAsxaHurBSe?=
 =?us-ascii?Q?TBGFfl060Nzc+kzKXR5h9JOwvoK0994kontDPFXM2AXUY1C/VRBzzWn133a7?=
 =?us-ascii?Q?iM6xP+D8X0jjqtEgS/ymeGP0cf/nIyBnZcmGGjFS6tNp1J/9r7eQ543chtw/?=
 =?us-ascii?Q?XvNKOIqKwga01YQegnqVkODdWSnVJ74tZdmuurZNiEY60HoS/Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8665.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?13RJph9JBKOM0T0r52KDqg4IhKuKVKR1PS1gGYc80VvS6dKCPKZDwGKRKtKP?=
 =?us-ascii?Q?P+FZeKGWVIvTwZOmW2MKQnl87v64VICNI5d0Zn8FHWt36bWnZDpnYn3NdWS1?=
 =?us-ascii?Q?EDgSuXU3oEeaF+2poxtQqWkUNmVL6RPRC8MOa1uulnidY0Vqd3FJPDZFO/AQ?=
 =?us-ascii?Q?v+RhglrLP2H6mXmeq9Wqu//OItO3I0FUVXLGJGo8JlFwTX3kj2UiFWaIpllh?=
 =?us-ascii?Q?UgDKFUeJXWjUzWqytEIrk3cI5AGeznouKNIdFIy555fmk8ha5JVu/opHdxMA?=
 =?us-ascii?Q?XInxt9GnE15+zIIluAs2sOPBJ4wM8hWIg4Aut66fUzhv2Yjr+X6Hd6kErb3U?=
 =?us-ascii?Q?3xvEPihbPbfEoZy9bO4nlmIf2rQU6sG6QqpBa5QtXlLMidh+amAcZLLvzteB?=
 =?us-ascii?Q?DblwShtGQJLqZkVUHQUeNmxpXspuGzhnKTYC/YZEOSmWRRHRbwLXXRSc7PfR?=
 =?us-ascii?Q?1QVjQpGNa0eVJxsLjkuoPCCTIFlUBspn0EV+q49SNw41B2CFHGTwicbZnk7O?=
 =?us-ascii?Q?mIDjy+iGkcCLMHFpAayeSD2hl+Bn7pj5mXgDPBrGBuFtWeWjHUjA6CXA7qxo?=
 =?us-ascii?Q?b5srv0PmCpkWEaxB8u/m07MGedUXsgwf3wgwo6DVX7ZRPocyy8KfigNfS7pV?=
 =?us-ascii?Q?lN5MiPli5thhAZl50HGOHsiuS5vpYtAHx6q9Du+Liu6cXJ8bjRT5uQ9p4YG4?=
 =?us-ascii?Q?R/zwgUG46EkcQ01XFyV4q1HR/RnxMk20fsBDtg8vGKYEv+abKEldgvLaqc7K?=
 =?us-ascii?Q?LN57IJ6QbmRaeuPLBMVOgyatBL5CmUy0+UPd6B+w7K2pd6PXo1CBI6/PwDSx?=
 =?us-ascii?Q?N798B23Zg1FQo1h2lTg5UBfS3liVSO0qy9T6EpCXrg+B2z2PuC9lKvHiD6PV?=
 =?us-ascii?Q?Oc12ubihG+7EVRaezDARHUiniQbzRv3VQafxew4S9h8/z0O4Oy83Qv59QTtp?=
 =?us-ascii?Q?E8mAgBLUUL4gXJPlLevdWQWbvF8liJDOijMHAeWF0ZoW18c/X9X+SmCpp/aK?=
 =?us-ascii?Q?56DBKS+H+gkdyPF3AvSrr7Efnk8Nsb0EmSvyQ8djc4O1VlKE2Jqki6M5g6BQ?=
 =?us-ascii?Q?3M7ZQX/b58VO4AAfTGVJdB5Zqq0jV1LN6pyiq2a8W8PEmhGNZ/IH4GYfPoh/?=
 =?us-ascii?Q?Yv+KOGBhteZkpt9hsNTEjUkC65lQ1U6JRK+rDZVQ9GNI6LAJljFjOazkp7ZK?=
 =?us-ascii?Q?cwFQtSaupue+yfn5R9nduI4caVuNRKHHQJ3CF+xuIN6NCva3uGAHzeqVsuY5?=
 =?us-ascii?Q?PL5nMeA37AiFVAVI3cVv53MfYE7mfEdXtlNf13lQOmEObVctYUgSY7wDgS1T?=
 =?us-ascii?Q?/yBqrM4lrp23grK6DpQCThqZz8PoIEZqveCid6YWiVdKPmoen/Tetxf/aT6o?=
 =?us-ascii?Q?XfCDgzloGkOXbP0JkhNGEB2U8gAkTriSE51DvM4H1HkvZqKRZ/i1cmthVy0M?=
 =?us-ascii?Q?Ks/X3x/+Oi7EfuC8HuvtUm8Trdfj93tNIg4eXud2gU7OxmQ37BDeJwfGz6ib?=
 =?us-ascii?Q?xLvZAPGyRBktBs7enzbEBnzip65FZqbyU8hb/x46Ho0iOX6/XMhTDiAIBUzD?=
 =?us-ascii?Q?kmUD8tckwCHMifq82osKchjAQj0TXbij5xnhnhrFYw02EazB7Oyjn30vxAf/?=
 =?us-ascii?Q?xw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b56c2b16-1f58-4ca5-3e7a-08ddeb0363dc
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8665.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 16:03:15.1534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +fSaRImafpoN4sgzf8CZYHZTc1LMfqEhel9TEIZxOPCeVHNhtfc8tzT3ln9hBBWwbvFsOCFtSXuYL2vJMunIZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6133
X-OriginatorOrg: intel.com

On Wed, Sep 03, 2025 at 05:09:41PM +0200, Alexander Lobakin wrote:
> From: Michal Kubiak <michal.kubiak@intel.com>
> Date: Fri, 8 Aug 2025 17:56:57 +0200
> 
> > The commit 53844673d555 ("iavf: kill 'legacy-rx' for good") removed
> > the legacy Rx path in the iavf driver. This change applies the same
> > rationale to the ice driver.
> 
> BTW you forgot to remove `ICE_RX_FLAGS_RING_BUILD_SKB` from ice_txrx.h
> and the corresponding inlines (now unused).
> 
> Thanks,
> Olek

Yeah, it makes sense. Thanks for reporting that.
I will most likely need to send out v3, as Larysa has identified a potentially
even more serious issue related to XDP_TX.
Therefore, I will remove the flag in v3.

Tony, please hold off on preparing the final pull request for this series
until further notice.

Thanks,
Michal


