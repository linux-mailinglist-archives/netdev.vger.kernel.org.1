Return-Path: <netdev+bounces-158942-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD0DA13E0B
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 16:43:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 393E416B847
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 15:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC49322B8DF;
	Thu, 16 Jan 2025 15:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IZmF0XI2"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E179A22BAA6;
	Thu, 16 Jan 2025 15:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737042187; cv=fail; b=JKBmRy6Ynry5A9Glbckg+lot414jv8DKnQ8Ul3dnUjCbl2wt0IJrNnn3yu4bngQh44NHPftIEzEfUn2Andqr3xssCbZsjnVCr60xSIm0nrK+xy59pdrs2fW/imIMEiu/ubxBhDYENhV902xOya8sI02K9js9EtnM7d5hNA9xllo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737042187; c=relaxed/simple;
	bh=NIyA/XLEvnQvYIV8J9u+6b/GpbjH3ds6IKKe8onn6gA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=X125nEcam2huj1HVgDSfDnLScCqC5qv7yl73FIfwCzYKQ4V7ZLxNX0Jna6SmwWWbDK7UgCWTQsh1VmeL+lYKLgxBLq1rxmlNTIFgxJQZtPg1Fi0h38plMBnvFMmrHc/jgifEuUGH25nwzc7yPRIAL04NbQ7PFQE7yedw/OauVdg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IZmF0XI2; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737042186; x=1768578186;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=NIyA/XLEvnQvYIV8J9u+6b/GpbjH3ds6IKKe8onn6gA=;
  b=IZmF0XI2vZr1QtVQGIwZ6nCsvvJqsZx7sK0l4eyC9S02AvQsPX2ynfyV
   GwYhRLayr1UldpGd17TOnOfPsa/drt54SEg2hwIcdCZL0kTqeu24FZyrI
   KsvVfvxLqwZIY5DjaxRVySsAFC7rxFwRwWIzM6LmkXFtt+hGo8B+DcnCv
   rAU3YkZ4pyjei0bJ3g3NFyrSUNjblUpEZO93xCf5YQt+Qk1PSB9OubCug
   x1UcGqrudOk71D4Q1jSNYTCanev1Blvtwq+1QhhUf3K4Svrr7sqwhr67N
   UnGy3Ud6j+XlPdul+jQgYBUHaneHcbLJFEo6f8gIm7RTY4atqYZRRUvEk
   w==;
X-CSE-ConnectionGUID: +26ZP5kxT5SpZD3UNaKpkg==
X-CSE-MsgGUID: OzE5jYavRVOzIHie5Iemrw==
X-IronPort-AV: E=McAfee;i="6700,10204,11317"; a="37318801"
X-IronPort-AV: E=Sophos;i="6.13,209,1732608000"; 
   d="scan'208";a="37318801"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 07:43:05 -0800
X-CSE-ConnectionGUID: L3PVBIPzSpasPxJtsZvVPQ==
X-CSE-MsgGUID: 2dXO5g0mQwiCOscUolUHZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="105380984"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Jan 2025 07:43:06 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 16 Jan 2025 07:43:05 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 16 Jan 2025 07:43:05 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 16 Jan 2025 07:43:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CpnBrMlfBtmGTA3Lu1LzLtDEP7h/gnmIhbeih/T0a4GzAIQAegAzrQpvQtHOLWLXeZidLB5O3FKtSHUFkeS2o/Q3hnqnpkT0ULz5yRWgtP/ihJylRrc3vXvUS7NuuDyHx6DfgtyBbMLIvjijHtQlavDoHf3OAVi4c83PQMiV3hf6SBYGJgd4PKPT9/bXP6YS3fIbRCWDCGvwSWXnoT7r1TqtsFmU24tpGplb1w8NHMWydd1C8uAJmIOo94togtajldi1BnZyEEY4CBj4/1Q7zcQZP3hPm8/pIuXvE03tVJiJtfDb7bPp6L3qpfB7cMpLS6Z68Xdv2iQwN1lt3p/UfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HGg/IEmVQWZM75F+0RY9SOo+PtzEqCZ9jEuNICqrX4E=;
 b=m0d39cm+n4BLALuVv1SKq09rp/qaC55cfVJPotFzRKG7kemapDlGxDcKZQaEoGbPmQmt96x/esQ1uRylRaUvEUxaDsSWOjax01KAi9nPkvvqnhZ8lLhlnjaU6JhyoxZgM75vSxBwxNLerDBW+E7U0ZK/wGjibAYdrhRD7mYhdNtHOSqZoT59cRwYD8F47I8rlNYHSjFlh6sFjhEy77UXLNS9pt572cyrK7t/cNGkeYLo7l6oTRXykQHY92a2xh+jN2kCwnmZSObwVR6lhy4Rc9RpdWHiGG69IELDbQCoaqX9S7rIiALvkwa4MP5xoxYqYV+dON2CQMe1C4VV+8ezdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by IA1PR11MB6419.namprd11.prod.outlook.com (2603:10b6:208:3a9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Thu, 16 Jan
 2025 15:42:47 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29%6]) with mapi id 15.20.8335.015; Thu, 16 Jan 2025
 15:42:47 +0000
Date: Thu, 16 Jan 2025 16:42:37 +0100
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Shinas Rasheed <srasheed@marvell.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<hgani@marvell.com>, <sedara@marvell.com>, <vimleshk@marvell.com>,
	<thaller@redhat.com>, <wizhao@redhat.com>, <kheib@redhat.com>,
	<konguyen@redhat.com>, <horms@kernel.org>, <einstein.xue@synaxg.com>,
	Veerasenareddy Burru <vburru@marvell.com>, Satananda Burla
	<sburla@marvell.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net v8 3/4] octeon_ep_vf: remove firmware stats fetch in
 ndo_get_stats64
Message-ID: <Z4ko7cYyMbMzGkAC@lzaremba-mobl.ger.corp.intel.com>
References: <20250116083825.2581885-1-srasheed@marvell.com>
 <20250116083825.2581885-4-srasheed@marvell.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250116083825.2581885-4-srasheed@marvell.com>
X-ClientProxiedBy: VI1P195CA0049.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:802:5a::38) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|IA1PR11MB6419:EE_
X-MS-Office365-Filtering-Correlation-Id: f80fc1bc-f942-495c-9af3-08dd36446cf6
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UeexbQa97HoChYB4YVXANMpfeO2WzSChdRGhfiMQ2F1ssX0wT+ZFv44be0DD?=
 =?us-ascii?Q?FzotIp82y0XOHjAB5Q85aaa0C9P89pIAxiFmr6Czj+4YD8hFG4yO+K9vgC7e?=
 =?us-ascii?Q?CD2Fn8dNfQ/qGmtYZXGZVPRBfEkfLYs8BH7tXkrkJF6i3048SFrVTU5S/fzN?=
 =?us-ascii?Q?ef7Rm6OEmMYHpJwEAb/+HJ7ETMul/7eFz/jC2t5jwUwoAdTAizdk2xhihgsc?=
 =?us-ascii?Q?s+ygV+t5HYlMvjaNouf5fDoXmTkOKJG9Jo5JMaOkHYG8Ht15XZyBnxSv0+EK?=
 =?us-ascii?Q?R3NrnplqSDBBHixoKD45FqcSPJmhml3EuIjL4cdAWkxIGYaPfrdcswoF4ZSH?=
 =?us-ascii?Q?PN12sIUAu4rbfA2KZYPxm0f638uQ/QCQcIUuJDtfwN7JhX7E/wxH/rg8xMwU?=
 =?us-ascii?Q?hxsL2STRXoo3rjchYEGbaGFvcPpv02gKgipRRHt9iM3gPaPI/+IOsIYqbhct?=
 =?us-ascii?Q?auVI5xkU2JoO38azygsVggzlfQ1P55lCh5CkQM9G7wNP9jo+Hc38H69zoIl0?=
 =?us-ascii?Q?v9oE7bPtqekx3ysKdPJpfqn7UintwGKK6omGJSX5He8dHnTa1mrMmPGfmTh3?=
 =?us-ascii?Q?yz8Xce+mKQdcs5q5qsu6SpxNnLBufDAV4p4BMhexiYY+WxkPGQ3zFQH+9AwN?=
 =?us-ascii?Q?Jkx0lvS0BwamY2PfrA7SpxvhaYXXk0AabL0qXLPSbQTz9DhwakP4zW+nGPLn?=
 =?us-ascii?Q?jk2dtS83x/DjFEgWrBLN8J3MR9Tws5k1VH+Yq1XQqaozuzZkxqZ4v9N+3wCD?=
 =?us-ascii?Q?PRKCNwgJNnRiTvFc/vwWFSeRkVA5OK/E4LCL1jRfWp0QPNa3w+97naOi8LAi?=
 =?us-ascii?Q?R16VFX378euOVhGUScQVNgbXKFcbO38LMCPA1eZO+n4Xm6Ot4vnjTayShQp9?=
 =?us-ascii?Q?v68E46W42/PNcQgkXdl2Ydo7YRdkONXcgMD+7d9yMw7AKlFOYII8NhUkO41o?=
 =?us-ascii?Q?LLoU2713kS4SEgUPX+iKejSV5xgb9H88mWOCbz9CWdjvdqdSqfE3gAd/GqHD?=
 =?us-ascii?Q?ML+q7lHzr0DPg608MtQ8bIL3JS2f+fil0KefjD0d2xTkL8P4zN356KulvXAe?=
 =?us-ascii?Q?Mg0Hkldw5NuHEctVGQL3NdDngd3/f3QFQZIP8E7MxOspuKZKkcA4ZBoeUhLb?=
 =?us-ascii?Q?/91ihm351AR5VWG+om89cWi3czYI2QKi634tDp+azH3QNwhYvmUCbnDAv1UD?=
 =?us-ascii?Q?sod6/cR4BvzdeDxulE+sOBxVOnXiVkEEf/nSUJ4mL1w3nK9U8JWCJR5mckFZ?=
 =?us-ascii?Q?fFcgRg2o3vKc4X+OTfwXBVdI9bgXKFy+y8yB4Z4XAsu/cdmfOm3XyX3pSNWm?=
 =?us-ascii?Q?jJobd6xr3fk+HBZh6U03iChLtPYJ62BNHdJyCShewzYjIbUyNYyLo/UZRi9y?=
 =?us-ascii?Q?IcR8t+WB/mBfWgWg+sbn9huPneHStI5EtVDflgnw8GOEyOqdKw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?k1BPJEMKGxRUcFoaTh9o4UakjnOpqEcfxSX56kECVE3lGrPRPUPYk/HReG1y?=
 =?us-ascii?Q?jNaK2ucMNTIOsUnuBlm8ub+WD8WIWnaspVsufJ1f/kTcOUjhd9g9VrwGSa5K?=
 =?us-ascii?Q?7JO783eigp0KG0kPN8mLVTHXUXFPWr9deGMhJDOhTdElOEIlvU9ubfYJTbm0?=
 =?us-ascii?Q?VfNY/t++OLfNLGqWg0EKXb5kEUpSNA2928msJqvqtNw+f+6f+4QgkSZY0bLg?=
 =?us-ascii?Q?ju6ulQH5972T1JqTDDptbQ/wt/CF7ebyAjAdw4vwRVH3EecCFvXp+pTR8hnk?=
 =?us-ascii?Q?ECsSbAsEBSUW1vP7VAt1omvbgeJYHVFvYW13zb5gj1JDetj/n/1/oq/tmqSz?=
 =?us-ascii?Q?Ecv3PbBkpFloiC9jd+5myrwJRmkIF7PN3xz2USw01/tf14ozxlHXo3CfpTXg?=
 =?us-ascii?Q?CZAWLLYxV+e9YKF7AYseAjcDWuJKWQI7XhZ9xCdQaBExmONlCqqxKuI7JdQ6?=
 =?us-ascii?Q?LEShxcwCHP1UL6K/CdL6kxeZEyloW+P6tMnG+4vTYFxAIFXHpQQqoCPsZow8?=
 =?us-ascii?Q?YS9OvBH9i5XNvo7sHYA3uStqHpLZB6eUqAWSsxj4P04x8iC2i7Ktf15l2uWq?=
 =?us-ascii?Q?l2MF+mHqwYd61W6CufhYfvzHXaXvIUydephEgAZHrtA04nyPRI1RZaeHEBF2?=
 =?us-ascii?Q?iyFAg5Ohbnpx10ZCOZjJNUB8mABQwKs03THFTsAkiUbU0yf6SYpiEK3l9x+T?=
 =?us-ascii?Q?7qe798aIQs6dvLscogze52gVWi0oDGFlZc+mWIUgOjMynhRw0SPeNihXKZMp?=
 =?us-ascii?Q?DXkMiqpRwXnOZPtvCbq4fxPt1HOrpCO+irrY3fuTaL0ApS/LSH1VwUKVMBOV?=
 =?us-ascii?Q?MFjeOAaukrod4cDk2NldkkZ+LqxVkgSF4Irz0fn5VZ7ClArC8WLs8NCmm6j+?=
 =?us-ascii?Q?jCI3Q+W23WEFWEHtRevtzoSH1584bSFyjQqFaHnbiZEYoLZ5PRfe3oHhMxq0?=
 =?us-ascii?Q?5aDudHi23ehVv5ta+EhKJKQUBkVjjDPtljDQ6ih+/9lC8SFKeh23NBOJ1pWA?=
 =?us-ascii?Q?JMzri+N6ybogffW5e56HjFB4KOzoS/eSelsbgnwEnDB8RJmN0Tsp3fMpSsoG?=
 =?us-ascii?Q?gUNlDTYen3AbP68dv6sVZ0mvMVHHi4+ZKREr8mauByCl0cD+NsZnc7evEoFI?=
 =?us-ascii?Q?IoUs8Duvcig58KUnPuIJPL8O1bqzbHkQ6XbqjcTLRdzhIXRxMLMQCBkULDWw?=
 =?us-ascii?Q?gY3gjaZJPOqOZ72VXfQ1hQid64zKDLmNsS9rqE6eUT7MENFWdhS9SG71vzUZ?=
 =?us-ascii?Q?CCy13wrbeEogJbWbL476JCHZ33dReM2MEhTZMyWwOZUYeONeRpn2hFe7xCKM?=
 =?us-ascii?Q?A68fYPmt87QNwPeOQjjsbBDopW4pIj0y6VO6T7mS1a2PWZnrZ3qlTppwmVHx?=
 =?us-ascii?Q?cDkNMvXbkvtxPgDDoVa/9dqoo4/B+J/vS2rVTotSFSNsF2ugMQwT+vGdjerE?=
 =?us-ascii?Q?4FU2b7CNN6pZt5Tfc+sICRfRScm3DgdCohiAmbbohXoFaFo3f6jZpqE+YiZp?=
 =?us-ascii?Q?0L49AiXyfsK6TPB5YUgES7FsL3nAmFwSABjxraD2iOoNlJ9n72NjF5YMDSrC?=
 =?us-ascii?Q?c4FG2et1XDncjrk4sxyl8syqivcr/dBvNSs7yRRKLytKWqR9uS9BzdvLbGLp?=
 =?us-ascii?Q?FQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f80fc1bc-f942-495c-9af3-08dd36446cf6
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 15:42:47.1209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pFnY2n9vvxWdmerj3hsNq/K9GxGjt3694z0jUxVrtw6i4HOOM45hrzpzutqKFOVlbI5TpDg3xgjRGNKTvGlet32+uv5dlGUwmbgp+DTiXlk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6419
X-OriginatorOrg: intel.com

On Thu, Jan 16, 2025 at 12:38:24AM -0800, Shinas Rasheed wrote:
> The per queue stats are available already and are retrieved
> from register reads during ndo_get_stats64.

Please update this after changing the patch order.

> The firmware stats
> fetch call that happens in ndo_get_stats64() is currently not
> required
> 
> The warn log is given below:
> 

This is not a call trace for VF functions, you should probably mention that in 
the commit message.

Other than that, I think the series is on the right track, though patches 2/4 
and 4/4 may need more attention.

Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>

> [  123.316837] ------------[ cut here ]------------
> [  123.316840] Voluntary context switch within RCU read-side critical section!
> [  123.316917] pc : rcu_note_context_switch+0x2e4/0x300
> [  123.316919] lr : rcu_note_context_switch+0x2e4/0x300
> [  123.316947] Call trace:
> [  123.316949]  rcu_note_context_switch+0x2e4/0x300
> [  123.316952]  __schedule+0x84/0x584
> [  123.316955]  schedule+0x38/0x90
> [  123.316956]  schedule_timeout+0xa0/0x1d4
> [  123.316959]  octep_send_mbox_req+0x190/0x230 [octeon_ep]
> [  123.316966]  octep_ctrl_net_get_if_stats+0x78/0x100 [octeon_ep]
> [  123.316970]  octep_get_stats64+0xd4/0xf0 [octeon_ep]
> [  123.316975]  dev_get_stats+0x4c/0x114
> [  123.316977]  dev_seq_printf_stats+0x3c/0x11c
> [  123.316980]  dev_seq_show+0x1c/0x40
> [  123.316982]  seq_read_iter+0x3cc/0x4e0
> [  123.316985]  seq_read+0xc8/0x110
> [  123.316987]  proc_reg_read+0x9c/0xec
> [  123.316990]  vfs_read+0xc8/0x2ec
> [  123.316993]  ksys_read+0x70/0x100
> [  123.316995]  __arm64_sys_read+0x20/0x30
> [  123.316997]  invoke_syscall.constprop.0+0x7c/0xd0
> [  123.317000]  do_el0_svc+0xb4/0xd0
> [  123.317002]  el0_svc+0xe8/0x1f4
> [  123.317005]  el0t_64_sync_handler+0x134/0x150
> [  123.317006]  el0t_64_sync+0x17c/0x180
> [  123.317008] ---[ end trace 63399811432ab69b ]---
> 
> Fixes: c3fad23cdc06 ("octeon_ep_vf: add support for ndo ops")
> Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
> ---
> V8:
>   - Reordered patch
> 
> V7: https://lore.kernel.org/all/20250114125124.2570660-5-srasheed@marvell.com/
>   - No changes
> 
> V6: https://lore.kernel.org/all/20250110122730.2551863-5-srasheed@marvell.com/
>   - No changes
> 
> V5: https://lore.kernel.org/all/20250109103221.2544467-5-srasheed@marvell.com/
>   - No changes
> 
> V4: https://lore.kernel.org/all/20250102112246.2494230-5-srasheed@marvell.com/
>   - No changes
> 
> V3: https://lore.kernel.org/all/20241218115111.2407958-5-srasheed@marvell.com/
>   - Added warn log that happened due to rcu_read_lock in commit message
> 
> V2: https://lore.kernel.org/all/20241216075842.2394606-5-srasheed@marvell.com/
>   - No changes
> 
> V1: https://lore.kernel.org/all/20241203072130.2316913-5-srasheed@marvell.com/
> 
>  drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c
> index 7e6771c9cdbb..4c699514fd57 100644
> --- a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c
> +++ b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_main.c
> @@ -799,14 +799,6 @@ static void octep_vf_get_stats64(struct net_device *netdev,
>  	stats->tx_bytes = tx_bytes;
>  	stats->rx_packets = rx_packets;
>  	stats->rx_bytes = rx_bytes;
> -	if (!octep_vf_get_if_stats(oct)) {
> -		stats->multicast = oct->iface_rx_stats.mcast_pkts;
> -		stats->rx_errors = oct->iface_rx_stats.err_pkts;
> -		stats->rx_dropped = oct->iface_rx_stats.dropped_pkts_fifo_full +
> -				    oct->iface_rx_stats.err_pkts;
> -		stats->rx_missed_errors = oct->iface_rx_stats.dropped_pkts_fifo_full;
> -		stats->tx_dropped = oct->iface_tx_stats.dropped;
> -	}
>  }
>  
>  /**
> -- 
> 2.25.1
> 
> 

