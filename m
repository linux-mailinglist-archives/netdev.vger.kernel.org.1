Return-Path: <netdev+bounces-180461-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC63A81620
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 21:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90C2D7AA951
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 19:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47C022F167;
	Tue,  8 Apr 2025 19:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QI3aUjno"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DCE1FC7CA
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 19:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744142266; cv=fail; b=Dqjf/a74kODiuJ45sGGbSl+JOOSzSS4L5443iR0FKMvigWSIfX1peVUx/BjHyhGiIznERWsjlNu9kV4kjLg52o5FYFiJ76a5GU/6dZQ+AetDKT0sksJDSI9MclpXwj1R89WB9JnSbdpjLuPDiLasIIHCi86nCVO2AF0hOQbMnfo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744142266; c=relaxed/simple;
	bh=Jiqv8SEpFYX6SwxxyhOkYs0CHLQ0g093Sa6h7LN4I1E=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ttup835xHKS6m/gKDE7kxAbLaGVD7oZ+dkk8Ww/LHDZx5WGe5xgPD7VLti8udT32rB2LMgQolKYM1x1mRPBac3gOOmkrad9hipb3CA5pg1KCjjiXlABqlQkCPJ+lWpkiTy5J8RhtocrAH5RzKcsxQK9KpfnWcuYrvlPoHW81G1s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QI3aUjno; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744142265; x=1775678265;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Jiqv8SEpFYX6SwxxyhOkYs0CHLQ0g093Sa6h7LN4I1E=;
  b=QI3aUjnoNyyq5eI0JALuIkABuf2ub/GC8MQtFP9YThhCCcY1GuEXBWdg
   ya5MLcx5keactxNpXYItWX2JEUTysIOtf5xPz5VpbZ+pLB2RoamZxEhDs
   WmYv5eFNgZNcrKvZqCMZ/2lLR5crvgzoViBhQXiSamVtFIpL0gHWIu4l4
   UTjxy52QwA8eZOSlzbssnt8j/lHnoAmX0KQOAjIqNlsKcNUbPMdNXPp9R
   rbSHgJxuA2NZN+EHf6XQ76bs3yZCUvWuwAbx168uJ6FfuoFvNsf5akzQU
   T2COVzCBwDU6rgnx0xqbRWCQjkYhEKJ6PKE28yCSogFLNLNQVMMfVft2H
   g==;
X-CSE-ConnectionGUID: eCWgLmreRzSNqesKyUq8zw==
X-CSE-MsgGUID: SAo+sCXkRjuthL3FVx3msg==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="45312060"
X-IronPort-AV: E=Sophos;i="6.15,198,1739865600"; 
   d="scan'208";a="45312060"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 12:57:44 -0700
X-CSE-ConnectionGUID: aNXhpWl6TNuniGsJ5XQBdg==
X-CSE-MsgGUID: rzLXN1pBT7+5ugywKxrLiw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,198,1739865600"; 
   d="scan'208";a="133236145"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 12:57:44 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 8 Apr 2025 12:57:43 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 8 Apr 2025 12:57:43 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 8 Apr 2025 12:57:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d1NeTJrCTHMHDFwJQyChmlcYeVl76MUhuOFUhLtH2KM5OEXA2hNYG9GqE3xkXyAYYZ/4lJYAsDvBhfDmwK7LYBAyuVaTR1G57TZpgdz4JGj4XPr54cxaMZdKPIseq5yO70cpINJ1+QVsYafxZQ0OQsPskxLM/DywGXy+DLb9jPIbhODeIO+exULOLw7EyTjzpcQR8Td5LpuUP6SWQwi7TggUJD+w5DpsEjNtcOl28l0LgFYmuC+IEZBg6maBM5LdZeI6CzUSDXDMQJvmWeR67loe9v1XFNwBetD+HKmreZVZs5kL4eYKfgILWVUyBUVM0xvG5AMZMCCh+wEdkKo/8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vh84+CBhMGtpOXwlmBr5bpr2Gm/sSPvGOTBORXK3kdk=;
 b=gI84wRiqJx4qhjVOEPfoqiO98GykEliIGQQDzfyAgf6DlnZucTzSo58c+zb8RaAKvs/c/MCu/4vpggFceeJA9isi4qELknBcpku3gj0NYrBMy1KGIcRh74uycfeW0XPsaJ7nuwiOksp25LhICI9TbrBBkEsUGOhs0vVbrTcsAC9WK338VLyp5LU5EP32QhM+wx9RzxaWIT3yhePYzhCMLQXDe5AiTvoc7QmfZEv/QuemjMlULkMAGi9lielYo4c7lLBUK/p7Qal1mEp2pQeP+bvbBzKo8vmawa3BIBbyoiiEnAmJSsHa/oKM9G2isMlB7ke9Y+B8zIlgtGOv4zW5rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8665.namprd11.prod.outlook.com (2603:10b6:8:1b8::6) by
 CYXPR11MB8663.namprd11.prod.outlook.com (2603:10b6:930:da::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8606.34; Tue, 8 Apr 2025 19:57:12 +0000
Received: from DS0PR11MB8665.namprd11.prod.outlook.com
 ([fe80::8e7e:4f8:f7e4:3955]) by DS0PR11MB8665.namprd11.prod.outlook.com
 ([fe80::8e7e:4f8:f7e4:3955%5]) with mapi id 15.20.8632.021; Tue, 8 Apr 2025
 19:57:12 +0000
Date: Tue, 8 Apr 2025 21:56:58 +0200
From: Michal Kubiak <michal.kubiak@intel.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>,
	<netdev@vger.kernel.org>
Subject: Re: [PATCH net-next 3/3] net: airoha: Add L2 hw acceleration support
Message-ID: <Z/V/ip/dA+aw+dCW@localhost.localdomain>
References: <20250407-airoha-flowtable-l2b-v1-0-18777778e568@kernel.org>
 <20250407-airoha-flowtable-l2b-v1-3-18777778e568@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250407-airoha-flowtable-l2b-v1-3-18777778e568@kernel.org>
X-ClientProxiedBy: ZR0P278CA0122.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:20::19) To DS0PR11MB8665.namprd11.prod.outlook.com
 (2603:10b6:8:1b8::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8665:EE_|CYXPR11MB8663:EE_
X-MS-Office365-Filtering-Correlation-Id: e166eca3-1554-492a-7670-08dd76d78d74
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5dyEwpJ3t2WVzR/R1qSWt0Bi0f+AQaBH6gTjqoHmNF+bHaHJWixxEqkHQx87?=
 =?us-ascii?Q?U5QBA7d0OTUKphR2dH2Z3ifisB54Ta9HTNxqiw/W5tWS3FHpJqH66uyA1dih?=
 =?us-ascii?Q?G7XdesSKmVfvzFlM0h8GaYFHjif6Ny5oO0PytxkcWrYwsxvGbgNrvBKkCo8t?=
 =?us-ascii?Q?bcb1luRfnifH2xR+bzK0MpNCAgiTiOvZTzZ37SGpnJiiblNbUhNsuJ0BZRit?=
 =?us-ascii?Q?wjSaZbQcSI2s83reJjfPNVSCDiM20SQKmy7731k1/eiRp5XaqOOnTOI8TBJk?=
 =?us-ascii?Q?79nR/fdSIt9Yz3CsEPZLfqqw/qnPvt9uevfGfnBjqJ+NwFfdE5Pl+grxRStf?=
 =?us-ascii?Q?faFwjXv6OeedPVQ6FeOhJc4a8rgngHJlfF22o9QgiCpVDNw+MkXKNACxR7Ma?=
 =?us-ascii?Q?zHdHoLKNTPk4d+Fc+T/vHDd3VJOFYT3LQZS/RiVHgo+kjdx5DaabGAsRvtrs?=
 =?us-ascii?Q?KGCXoCygHUlesuhhKmYOgjs7DwTnqjr1KmGiRtZXg0XQG0SGITOHYWdQx8oh?=
 =?us-ascii?Q?JjCVlzLxQvFKzXE8oyCAntjsaBxPfJP01sEbmt8/yoURHUgBNMr1LYWKW4KW?=
 =?us-ascii?Q?ZTofzfosUSLJutsmWnMgNg4iYdVv/xIwkF9EqQcCq1lJqjRnHgApzcid0M5A?=
 =?us-ascii?Q?f7VLaMdpJip9mpJFUgXHczexIDZZtKBSE0RKfVdkCFeUAYaF2ciuY4R9fBkW?=
 =?us-ascii?Q?PvEOk8WQ43ELrB5fjVymhB0I7McgCgdE8JQPy6TY+SvD1sW1FY2/AJgxoWRb?=
 =?us-ascii?Q?8k+sXjizTpMqDwC49I/HDksfBqbNESaBObmp+Jy6dJkdJUHwQySQ1Wc/KqLe?=
 =?us-ascii?Q?TCdNfFQbTubMBTumPIWukPgvbyVdIyDThEGK0eNky0Ms7qfGWtflqtsRfyi1?=
 =?us-ascii?Q?ssW2OTV8IZLIJNzrd38T2mo+/4fFt/k/KoXKRBM0oIP9xFAdBhh6Tlm8MQZF?=
 =?us-ascii?Q?5xif6UDtumL18DxxOJJBTIHhQAUAzQxKFQuls0cg6A1ZxE7ZACFDKM8K2XCA?=
 =?us-ascii?Q?V0jVzJ8KxrpxNnOoSYJvfIqel66z5NUJbMqcvtJQdx2RpW+4XFuGLykYDsDG?=
 =?us-ascii?Q?FJh90LKOZxSgysSmU8dGhBYB1vlMIHSQB5z9/Ggl13k9HyUG0w5kcABfHijc?=
 =?us-ascii?Q?QE/qBqXQabT1skCy3ZmIetSLnZ2s+pIisBVRjjCA8aN37oLQ1O/GIQZsEEZR?=
 =?us-ascii?Q?8Zg6amqDc94lWPFw2P+0eCbnNXT+M4SGQBi2xmKRfKhGKNnYXCKTKB9Zqs9k?=
 =?us-ascii?Q?mw6kkKnseihim9rTU1HJqOcXjgO6obtQv0bFk6ZHGk70ZUSzVknH2pwzYsIn?=
 =?us-ascii?Q?PpaVTKcvIecKaRNxO3K76ArNjwlIrHKw7C4B2+Nco0P38wXLsNM8GdTehSd5?=
 =?us-ascii?Q?y9uCL6VgiDeidljjTnRgdJQsxadG?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8665.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lkbo5SDRNs4/ZF8vK4u5rER4CxZh18z9d0qg6dVbiZp3c/6Y7pAIdC2Wb3IE?=
 =?us-ascii?Q?G1om+gz288+sW75FFCAaVY8u/jTozefTMQZwmFMjLStUCQO/1hPMui/LOwgt?=
 =?us-ascii?Q?vM6lDx/f1uZnOSxrkoNhIk4XVaVanpGT3Ut1kKXTnumShgwxnaOy2FJ1tjFv?=
 =?us-ascii?Q?1p03wfrPI+K5E5Gl/NkDQDIYQ2pTg7cDohh7fOP75pr0MLIP3aPQlxqrQsAh?=
 =?us-ascii?Q?nt1ofFWe9jq9QWhDwFUte8IPmoKLyTUamWAorBU822CgAIzuwHK7h7D5Sfkc?=
 =?us-ascii?Q?64xpIOaxZTGzqzpejIFYfqLfRjJO+xdH1oJFGSuBudyWc6yl5dby/POauvXN?=
 =?us-ascii?Q?ya5UTQo0mZDabGQo86SKTxNb/+718xuXRKIHE8AbJUWbBPX/cIn4FOElHjU7?=
 =?us-ascii?Q?7LTrOfX0HXcKHSCtHDCksM9s4pveskq3wi7sqUPXqILL/NlKvGPuHaPfgOJ6?=
 =?us-ascii?Q?qJd8S3+CL21oPhzCNMXI04UWsvRdQY6ZqoZ1GjPfPFfLnRZUZLh143u/oX+W?=
 =?us-ascii?Q?hPb1NHc7L0UvBy6H1B741KrDiO820onqOAUVch+VczfPqCpQ6nKpAAwFEEmY?=
 =?us-ascii?Q?99HDqjDNANcGH8O15GtqpuAneW3ucJwy0TpdOjQBIeJLHS2Y9ZcmPYOmDyvG?=
 =?us-ascii?Q?VE6rv9ePhX0A5lb0Z6N1eR0W/6V2mRcFsNpFkLXm6Bo8UNTYML74yMP7w+kt?=
 =?us-ascii?Q?tRvo2HMgO2e0kq3vHp216ggkkaJMbJEkuwNpYww+G8l6XyvCRaW3IMzTS5GA?=
 =?us-ascii?Q?hvEnCF45jOcg3rQ2oY3FVVOPOcDzahiLLH4gnGmTnLz9Do+BJ/c1S3HqYhT7?=
 =?us-ascii?Q?KtdlqImQ6qz+2tN1pnY5d4opXVT78yxpJdczBORX4jVa8yU73LAaZtL0igTr?=
 =?us-ascii?Q?wbm/JAGUxOCEZFw1svzLwd7GV3ViTu7Ls/G2Wa3vl6yxflhkn0NeoyVS1fZa?=
 =?us-ascii?Q?DoWlvSHm0b40xVVK0KM33eelbi2GJyKoSjpDR+Bq3xEA3/J7Y6Ejr+WaSaam?=
 =?us-ascii?Q?WsVK5C6VZfwmOwfqptXu6EWpCB7ZV2SZrqTwPlBEnwGL/ZddCVR/d5sJ2J8Y?=
 =?us-ascii?Q?fLwOWicCJ6mqERfyLmjjHzSOIISc3XZKtI8OZY029SMb/Lv1UAVUrTPtTdwO?=
 =?us-ascii?Q?gERvAYFsFLHsb4ZCvKo+ewuCTc/di+3SwZtk6k9wqKnsx0qaJjv432pbZKJv?=
 =?us-ascii?Q?PjGpQLj9XF57a3gO1kFcp+eVvHdaPQ/hEB6k2pF2KMWlq8uPuLSxj0SDf4tt?=
 =?us-ascii?Q?9VEbvBnxCZIQEFZtqoctajjZaVfD1m4yu2iHmcPB+0Y7XPuw+RYaQxV8UqyB?=
 =?us-ascii?Q?K08FT+1Kbv2P76vF9QxVUye5bP2YnMjGrJn52PAlMQZimemws+eZTEVBBUqZ?=
 =?us-ascii?Q?aqI8T54yk96FJoowksM+HHiLnR4ZgxIdsMcWR1W4+sP+cDjgUDdVj6MnG0bE?=
 =?us-ascii?Q?D40fmaAT+1LVCCCQR0NU7nmw+LUqxCuL/W+AuQ8e6yfI6I2RIQVgIY5h6d6G?=
 =?us-ascii?Q?53co7t/62vByYFCh1DL4dQ1N63YHTrHds49DVX4WZdjuO5SVuwjtNyzMC95i?=
 =?us-ascii?Q?KwsrP5E9yrCqPNxc72Iz+B5JLMdXPjMMeMgG7I+UYxYlgf9Z4C0NB70Ru9BR?=
 =?us-ascii?Q?3g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e166eca3-1554-492a-7670-08dd76d78d74
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8665.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 19:57:12.1091
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7njl+Q2HjfDElvfZBgk4wlv5981sjX1akXI5gGM/g9WlGDBJoUHEyha4gZMZX0XTVIkSGYQ9rjgkqN1uSs3ikA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR11MB8663
X-OriginatorOrg: intel.com

On Mon, Apr 07, 2025 at 04:18:32PM +0200, Lorenzo Bianconi wrote:
> Similar to mtk driver, introduce the capability to offload L2 traffic
> defining flower rules in the PSE/PPE engine available on EN7581 SoC.
> Since the hw always reports L2/L3/L4 flower rules, link all L2 rules
> sharing the same L2 info (with different L3/L4 info) in the L2 subflows
> list of a given L2 PPE entry.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/net/ethernet/airoha/airoha_eth.c |   2 +-
>  drivers/net/ethernet/airoha/airoha_eth.h |  11 ++-
>  drivers/net/ethernet/airoha/airoha_ppe.c | 162 +++++++++++++++++++++++++------
>  3 files changed, 144 insertions(+), 31 deletions(-)
> 

[...]

> +static void airoha_ppe_foe_remove_flow(struct airoha_ppe *ppe,
> +				       struct airoha_flow_table_entry *e)
> +{
> +	lockdep_assert_held(&ppe_lock);
> +
> +	hlist_del_init(&e->list);
> +	if (e->hash != 0xffff) {
> +		e->data.ib1 &= ~AIROHA_FOE_IB1_BIND_STATE;
> +		e->data.ib1 |= FIELD_PREP(AIROHA_FOE_IB1_BIND_STATE,
> +					  AIROHA_FOE_STATE_INVALID);
> +		airoha_ppe_foe_commit_entry(ppe, &e->data, e->hash);
> +		e->hash = 0xffff;
> +	}
> +	if (e->type == FLOW_TYPE_L2_SUBFLOW) {
> +		hlist_del_init(&e->l2_subflow_node);
> +		kfree(e);
> +	}
> +}
> +
> +static void airoha_ppe_foe_remove_l2_flow(struct airoha_ppe *ppe,
> +					  struct airoha_flow_table_entry *e)
> +{
> +	struct hlist_head *head = &e->l2_flows;
> +	struct hlist_node *n;
> +
> +	lockdep_assert_held(&ppe_lock);
> +
> +	rhashtable_remove_fast(&ppe->l2_flows, &e->l2_node,
> +			       airoha_l2_flow_table_params);
> +	hlist_for_each_entry_safe(e, n, head, l2_subflow_node)
> +		airoha_ppe_foe_remove_flow(ppe, e);
> +}
> +
>  static void airoha_ppe_foe_flow_remove_entry(struct airoha_ppe *ppe,
>  					     struct airoha_flow_table_entry *e)
>  {
>  	lockdep_assert_held(&ppe_lock);
>  
> -	if (e->type == FLOW_TYPE_L2) {
> -		rhashtable_remove_fast(&ppe->l2_flows, &e->l2_node,
> -				       airoha_l2_flow_table_params);
> -	} else {
> -		hlist_del_init(&e->list);
> -		if (e->hash != 0xffff) {
> -			e->data.ib1 &= ~AIROHA_FOE_IB1_BIND_STATE;
> -			e->data.ib1 |= FIELD_PREP(AIROHA_FOE_IB1_BIND_STATE,
> -						  AIROHA_FOE_STATE_INVALID);
> -			airoha_ppe_foe_commit_entry(ppe, &e->data, e->hash);
> -			e->hash = 0xffff;
> -		}
> -	}
> +	if (e->type == FLOW_TYPE_L2)
> +		airoha_ppe_foe_remove_l2_flow(ppe, e);
> +	else
> +		airoha_ppe_foe_remove_flow(ppe, e);

It's not a hard request, more of a question: wouldn't it be better to
introduce "airoha_ppe_foe_remove_l2_flow()" and
"airoha_ppe_foe_remove_flow()" in the patch #2?
It looks like reorganizing the code can be part of the preliminary
patch and the current patch can just add the feature, e.g. L2_SUBFLOW.

Thanks,
Michal


