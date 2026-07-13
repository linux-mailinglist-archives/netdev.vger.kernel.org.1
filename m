Return-Path: <netdev+bounces-307253-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 58t8LAMdVWphkAAAu9opvQ
	(envelope-from <netdev+bounces-307253-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 19:14:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 49B8B74DE9C
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 19:14:43 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=MHnI9Mqo;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307253-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307253-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 017F730C638B
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 17:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6410A343887;
	Mon, 13 Jul 2026 17:10:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329D0327C0D;
	Mon, 13 Jul 2026 17:10:24 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783962627; cv=fail; b=q0MdiktmjF6tgz3TYSzDVM8LSFzNinAv5Eofl0+urJqbO0C8mFbePE3YUMdmWJRKGntQFTLSpPNyLhig3qoihxB4faLenx8p3gNdfZeA2lX2jPHUYMYrpKHgqhkNw/Dyil2siKuT5pSg0+S6TZrqVEO3bps5AIsN0yZm8Cf1A9k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783962627; c=relaxed/simple;
	bh=TkBgNb5Pu2D9a+OVr+wm3iYRSiM81VB+qW7wo0hDCAI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qGZsacTgxNuwJiCN71Y2Zuqd9/ifAjQPZ81/4KmYEDXmkrdKmrRDNDvxEpmEZ6nvqT0LIaeoRZgYK4RjG4R9T05NJrAbiWA5GCk+uUQpg0wqCcI2egf/PYKVMZ4dNcZSjEQEzR6ZeOJTgitH9hB/U+bxJaPj+S51CtowTiFBBqg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MHnI9Mqo; arc=fail smtp.client-ip=192.198.163.13
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783962625; x=1815498625;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=TkBgNb5Pu2D9a+OVr+wm3iYRSiM81VB+qW7wo0hDCAI=;
  b=MHnI9MqorunOACYP5EqJSEbMcvp08EQWGeUHlTWEYNcQTsbJpnB41HU/
   07X7FatMhZxBtrhUE6YJXFXi2BKJBJn1yaAI38IcHNhJBVjKzcb2zQq39
   pZB5WnkezB2MkoDvqtXj8gYIKeQk7zliw4njHihCC28N1dIA3PWsafJSe
   5Xq6KO2pG5oQLbmRyZAOGjUewo3Atx51RqRncFy0/MD+ShyQVWQPQhl85
   exfPwK87clKjbqfQV9PsBhmwygY+p5uINYp84yQcg8xDuuI/UQwA1Ayae
   YNfmtXp4C31BCPByT0jQs546IW4OlvbM/vDedRsqC48khZHyXH/4NKH1O
   g==;
X-CSE-ConnectionGUID: gIwFds/mSK2AyC/9DdP1Qg==
X-CSE-MsgGUID: DogC8NA4SNW3dSq/gUBs9w==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="87119655"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="87119655"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 10:10:24 -0700
X-CSE-ConnectionGUID: wW61EkW6RpiHbAxJAWBB3w==
X-CSE-MsgGUID: sWfe7D9IQhyie/yzx4Ytlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="254474579"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 10:10:24 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 13 Jul 2026 10:10:24 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 13 Jul 2026 10:10:24 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.58) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 13 Jul 2026 10:10:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hsQwmLfEtldi0NXfl1Dv2d2DEoukw+Gen6AX1W8VNBkem4EJ/CUn7oS06QzhxsOPmEcWDm/poVUytg6PSjPvBvK4am0S714AHIMi/OxcjQTrRWc7+TNZDCsI1ZNwMswYk8EvO2fl4dTXnSfCWnRVntMLXikIMMBbNCIz/r58Vd013T1L2LSOywRzXWcr/98PpUiqUjZPvqWpbyWGXkr06uIAHHZq/WfnaoaJJ5a5kh4PGXRSnHDKy+9Las2esKmyJxQkr8+DR+rnrgBZVvjgGgMsbnoaFtpTbdLS9afuGjFDwS1QaMMi49y+QnPq57W7oEEWcoQsvoUtwyRIgXn2PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=psKle4nVKk+78EkhJv/SsPbrVGsgvvMkUZFV4+6VwE4=;
 b=Uxwgf5rK7fQX2ldBFf1mpXcewOZ98SHYpcPAwf0gFivFlDUMzVtB6BBGQEHMKRKwvxHXeatxzflWzrqJjeY6THZ5V6kAEi1CCysnfP13RVsRm1ngmfQqKJfPx2nIQrgRJfVe/baGHbE5re1KI3P9EvUHPrauSGrbhiMOG+v8p5yX5Yj2FUbibYcCbAHQdVo8bi9WWpyig8TRFwiDpp+n4Awe095jrHXOlYiuNU57VbrIykt253WvF7C8lTmpT2z0sgyUAXhl9xZeHrS7Oa3e2fkOQu8OuybQ3pocFhuBuv1C1bXAEDYUs9HGHXP3y4kLTNUWfK2/TQ5PiLPGKO7LfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB3949.namprd11.prod.outlook.com (2603:10b6:208:138::31)
 by PH0PR11MB7709.namprd11.prod.outlook.com (2603:10b6:510:296::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Mon, 13 Jul
 2026 17:10:20 +0000
Received: from MN2PR11MB3949.namprd11.prod.outlook.com
 ([fe80::dfbf:4563:6676:e23d]) by MN2PR11MB3949.namprd11.prod.outlook.com
 ([fe80::dfbf:4563:6676:e23d%7]) with mapi id 15.21.0181.019; Mon, 13 Jul 2026
 17:10:20 +0000
Date: Mon, 13 Jul 2026 19:10:08 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>,
	Phani R Burra <phani.r.burra@intel.com>, <przemyslaw.kitszel@intel.com>,
	<aleksander.lobakin@intel.com>, <sridhar.samudrala@intel.com>,
	<anjali.singhai@intel.com>, <michal.swiatkowski@linux.intel.com>,
	<maciej.fijalkowski@intel.com>, <emil.s.tantilov@intel.com>,
	<madhu.chittim@intel.com>, <joshua.a.hay@intel.com>,
	<jacob.e.keller@intel.com>, <jayaprakash.shanmugam@intel.com>,
	<jiri@resnulli.us>, <horms@kernel.org>, <corbet@lwn.net>,
	<richardcochran@gmail.com>, <linux-doc@vger.kernel.org>, Samuel Salin
	<Samuel.salin@intel.com>, Bharath R <bharath.r@intel.com>
Subject: Re: [PATCH net-next v4 04/15] libie: add control queue support
Message-ID: <alUb8FSrX_YliAIe@soc-5CG4396X81.clients.intel.com>
References: <20260710215313.1475803-1-anthony.l.nguyen@intel.com>
 <20260710215313.1475803-5-anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260710215313.1475803-5-anthony.l.nguyen@intel.com>
X-ClientProxiedBy: VI1PR09CA0128.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::12) To MN2PR11MB3949.namprd11.prod.outlook.com
 (2603:10b6:208:138::31)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR11MB3949:EE_|PH0PR11MB7709:EE_
X-MS-Office365-Filtering-Correlation-Id: b96f110e-c130-4c0a-58f3-08dee1019dea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|10070799003|376014|23010399003|22082099003|18002099003|11063799006|56012099006|6133799003|4143699003;
X-Microsoft-Antispam-Message-Info: H74xBGawV9UIZVaIq411G/540AKbqXI5wlhbRgXxMTdK5U/8+Xvi7uKo5KzzcDOqAo1ed5m/rYFOK8GnlWeqPinvQXGZ0JGqCe4KhqjtOIB31jycJ4bJhRqaGFvuDmhk8NZdCBRV26yT8N6R1K5TlX0rlBGNiRBB+GDOnVgTyh+Z5v87Fk5OdSjv3SGy4NI/tcrbN62lwUslxuE9GjFv5ycDQ2uW9W6QevtjJITq3wxaj9L8Gl9aQTy2iwv3FQaY3ZYMX/ksqsYNzS/VCvJ/FstjQZ9QEH4eH41wQp8P+JBTT7Y8ZTxSDYsYW+8KpqJAoKDOsY3/0FOSOZZEGuBGZ2QtMDkFipUfAmuzm/jXb32gfC71iGBQwTtm0gtlePHak/X2dHJyqS54RahbURnu+0paa6sZc1d5GmbydF0aiPfi9TcVvPnYPQQl6YeUGTuOkU/aGpIk+YwFgqrslThl4Pn7z1SQ8jDsX1/W/T9Ov9xx73XVdAndphTiPzTqxWGSewYG03V3Sq0Mu37tFmC7pz4IAbkhBM550r9cdpgp0Cd/mZKdsOMv+Ed3IysgIUuOGv73OdqtVtSRPe2PfK9kcQK8ey4GsATEm0mfJjf3Ja09AIfbHJyAvtOEzrdiNme/xZLhyJIIVqIJCaWXMhi5uk7bEasEgQFZG35ZkeveKB4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3949.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(10070799003)(376014)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006)(6133799003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?y/7GZzVuLKWLCCCbhHz+fD4h2AcPEsXfRZP/fIo3ojj+0JQzPP0O7QO1kDUp?=
 =?us-ascii?Q?EUvY+ax8/BW0EdqFcCeiueraocSzPnvMB4yeyU1WQsRrRdH5gKqhU9QDiWpy?=
 =?us-ascii?Q?Ss6i7EC7yK/EUHP2kjzFJqJdGlTT3Ria3OOsuCa30cjZPwVN0P3KTm0qAKiE?=
 =?us-ascii?Q?8bcPr6ulLmjeLVoZQjC6utE6UK7QieFahjn4GM8nLlltV19P2rY+FcDgsqOp?=
 =?us-ascii?Q?70J2sScI/QdHzZgXCNGkuMxHz9Thqmucw0L9EuAziXLHuoh8KoirC6wb7zOE?=
 =?us-ascii?Q?J6lkm2OU4reb0FpE+m0qscqMSr7g1hdM+/vS5VBvwiP0OK2KDMGueyZClSL8?=
 =?us-ascii?Q?WSXgeRpvqhBLGqZrPYqddEkIauPRjw9qQ/PlfcVcI0BpH/NJPfbG0hb8jny8?=
 =?us-ascii?Q?a/8bkIXnnKpQLf35/rl5vDFX/epZ18wfGAgN+OWnDYm+rPkSXVZqu/FKfau1?=
 =?us-ascii?Q?oP0I/xBrfyeJ30w5nGAsAcHBnj2dqkFd2ucbhNFaHk1lHQRP27a7Pd+rct3Y?=
 =?us-ascii?Q?8PRGzJds9jywqVSNeR2idNSmoNOPyXhhkcHDLTjzPef4P1OnC4oq8VvKv5MV?=
 =?us-ascii?Q?HtTFFU6gddjYla7iNT5tE8W4v/NOvjWP9TrF6nJ93POQZOvJ1d8O+KFq8ypN?=
 =?us-ascii?Q?ZA4gLg051p6AtnwQNdkZLJ4GEmot9WeG9pPkiLjyVeUta+twqowakcWj3LFw?=
 =?us-ascii?Q?uws8tUQSCZg8hHElDyzEyOxbA1IuHdtOiHQTldeE15y4jnvzpjRgd+8KPRzN?=
 =?us-ascii?Q?oahQm5YkCbQvyGfgnqEjVIrZ4AonuajJVwWtiukAHT61ZhrsxgVR1TeQlYtZ?=
 =?us-ascii?Q?GuJijIBQhuvFBF+9h5bfZpnEqYQjR/y/hk4OQA0uRBjlt2waMDJrEVV0812h?=
 =?us-ascii?Q?/Q/mRnk9+Eb0BoyOIkG54iSn0yRsgWV7ZgYenoxtVboSO6z5qb6BfaD/IqBw?=
 =?us-ascii?Q?j21ET1GEG1r1YZsTttn3d9k96hJDS9EA8yjwyIKXU/cyxl5QvexFBrIUNvPZ?=
 =?us-ascii?Q?Cl8xG1qi+zK5nZIALozA+1J769OgK6fTuI1DjMldeHWcK4SpNlv97DVoUwVh?=
 =?us-ascii?Q?v6MRgdhqa4k9UNi/ShCrPBN759yfYhcn4jCXNFAiBTrPpsON9a+qkEkySXdI?=
 =?us-ascii?Q?8dL2ejTuMVbu7AtDrswmWHY1tcofOU29LtCERDG8EtgdcEzTcNRXMa1eRHX+?=
 =?us-ascii?Q?WnvRedQu4o1O3d1OUpsrisql7Oi1a8mLS2YKFwXAmO0rWj8O+Qg6Shfv2IB/?=
 =?us-ascii?Q?e8yfL0oUkBWkbI2ORINs951z7+zROUGT03tw0wP1ySIVRh/JcKwfcfeJrTW7?=
 =?us-ascii?Q?LOObAZT3aQ/U6AwNnwXClUxB5f6+jyfXtem6IB4Kd4R5tBG6e2/Ea8DAAnL8?=
 =?us-ascii?Q?ZQ+rx7PlZnjxuwmjSGtPtIdyl7eB/njMcCHcvmIdju3PEAWdbVXYdxfdYGLe?=
 =?us-ascii?Q?FYWb107gEXOgyH3RKb3gLAD5jlOWHiMd5zoPwDrf1jK8jKPKXk+msPxorvFu?=
 =?us-ascii?Q?N4/tKtRs0+fkCF7YwEXa6rdhyt8V/wUedsD/u6jiVZnCFDEIkeaDql+8BvIC?=
 =?us-ascii?Q?g4fZlCxTUchs0L6NI3woaYc/SPKjY+WciHWsZGFq26JIwUwcpqXXZTGYq+qy?=
 =?us-ascii?Q?zhzRlPS2DlcPNV3RPyyPz5XMCipzqZFFgb2T+a/9scEcJvcS8siznX35wybF?=
 =?us-ascii?Q?dCNG8PC9NDxfdJl00Uu5LMH/EFBwPZcav9pu1nesd+Fu+bslg7ni5HuzzV2G?=
 =?us-ascii?Q?YybU6diLKkExzmGOMJfM2js9ZIRY5hdHTDNM374V1ZikK+DhBTgKbZZ5ReoP?=
X-MS-Exchange-AntiSpam-MessageData-1: UeqMxwIA3q5E/fvA7xWp2Wdmb+LQQAGeOBU=
X-Exchange-RoutingPolicyChecked: BPybpBeX269su6IVyLz3mIPEuGZ2KGk9EdsJ+YsVHV/oykKQNsGMAEGqWz0NKyyeR6Cd3nKhVeIKASwcRJDJfJQi0fK976+x29eSmX8V64x5al+jNxAtbL0OTXE0muzxpfvj9d8oWkfmCaFmMTFFAwRh2n7zsPA7jzykpGniYW7JNZibA1rbv5rg7rEZ5aaKkH/vyndxzw/3rs+KlmaArq4wLk0RFB72BNugNxj8466dQxmYoTliEriItMqqo5DFFF0/5eqCjK4rEK4HBo74U03SP9EY9J42QFnUBQQOU5fyIigRqFluV/7G4z+xFOl+D01irwixB1q3SuI+Hl/6Yw==
X-MS-Exchange-CrossTenant-Network-Message-Id: b96f110e-c130-4c0a-58f3-08dee1019dea
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3949.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 17:10:20.5049
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bj2qiSBwEdUYFIQEmE7GmXB5qzJEykuy8+yrFHCj7pYK/uzENbXkRhS8v5SkQO6qZGDbxG6jKO6dG1xBAdKOA/rAtE7ZQA9Wt1W2ZZ8PcJo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7709
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-307253-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:from_mime,intel.com:email,intel.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp];
	FORGED_SENDER(0.00)[larysa.zaremba@intel.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[26];
	FORGED_RECIPIENTS(0.00)[m:anthony.l.nguyen@intel.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:andrew+netdev@lunn.ch,m:netdev@vger.kernel.org,m:phani.r.burra@intel.com,m:przemyslaw.kitszel@intel.com,m:aleksander.lobakin@intel.com,m:sridhar.samudrala@intel.com,m:anjali.singhai@intel.com,m:michal.swiatkowski@linux.intel.com,m:maciej.fijalkowski@intel.com,m:emil.s.tantilov@intel.com,m:madhu.chittim@intel.com,m:joshua.a.hay@intel.com,m:jacob.e.keller@intel.com,m:jayaprakash.shanmugam@intel.com,m:jiri@resnulli.us,m:horms@kernel.org,m:corbet@lwn.net,m:richardcochran@gmail.com,m:linux-doc@vger.kernel.org,m:Samuel.salin@intel.com,m:bharath.r@intel.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,lunn.ch,vger.kernel.org,intel.com,linux.intel.com,resnulli.us,lwn.net,gmail.com];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[larysa.zaremba@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 49B8B74DE9C

Sashiko has some concerns about this patch.
There are some improvements that I think are nice to have based on that:

commit 1da5bb5c7a7be66fc6226afa94c0f25bb52a57a0
Author: Larysa Zaremba <larysa.zaremba@intel.com>
Date:   Mon Jul 13 15:59:55 2026 +0200

    fixup! libie: add control queue support

diff --git a/drivers/net/ethernet/intel/libie/controlq.c b/drivers/net/ethernet/intel/libie/controlq.c
index 885b4437b4f0..c043c07dbb89 100644
--- a/drivers/net/ethernet/intel/libie/controlq.c
+++ b/drivers/net/ethernet/intel/libie/controlq.c
@@ -327,7 +327,8 @@ libie_ctlq_add(struct libie_ctlq_ctx *ctx,
 {
        struct libie_ctlq_info *ctlq;

-       if (qinfo->id != LIBIE_CTLQ_MBX_ID)
+       if (qinfo->id != LIBIE_CTLQ_MBX_ID ||
+           qinfo->len > FIELD_MAX(LIBIE_CTLQ_MBX_ATQ_LEN))
                return ERR_PTR(-EOPNOTSUPP);

        /* libie_ctlq_init was not called */
@@ -493,8 +494,6 @@ EXPORT_SYMBOL_NS_GPL(libie_ctlq_send_desc_avail, "LIBIE_CP");
  * The caller must hold ctlq->lock. The intended pattern is to first check
  * the number of descriptors available, then fill in the messages and perform
  * send within a single critical section.
- *
- * Return: %0 on success, -%errno on failure.
  */
 void libie_ctlq_send(struct libie_ctlq_info *ctlq, u32 num_q_msg)
 {
@@ -510,6 +509,7 @@ void libie_ctlq_send(struct libie_ctlq_info *ctlq, u32 num_q_msg)
                if (unlikely(++ntu == ctlq->ring_len))
                        ntu = 0;
        }
+       dma_wmb();
        writel(ntu, ctlq->reg.tail);
        ctlq->next_to_use = ntu;
 }

Other than that, I would put feedback into the following categories:
* worrying about patterns not employed by idpf or ixd

> libie_ctlq_recv() only breaks the loop on DD=0, but DD is never
> cleared on consumption. It is cleared only when the slot is
> re-posted by libie_ctlq_post_rx_buffs(), and even there the zeroing
> happens for descriptors that get freshly filled:
> 	while (num_to_post--) {
> 		...
> 		ctlq->descs[ntp] = (struct libie_ctlq_desc) {};
> 		...
> 		libie_ctlq_prep_rx_desc(&ctlq->descs[ntp], addr, fq.truesize);
> 		if (unlikely(++ntp == ctlq->ring_len))
> 			ntp = 0;
> 	}
> The final barrier slot between next_to_clean and next_to_post is
> never zeroed, so it retains DD=1 from the previous rotation.
> With ring_len = 4, after one full cycle ntc=3 and ntp=3; post_rx_buffs
> refills slots 3, 0, 1 and leaves slot 2 (the new barrier) with stale
> DD=1. If a caller then calls libie_ctlq_recv() with
> num_q_msg >= ring_len, the loop can wrap and re-process the stale
> descriptor at slot 2.
> 
If caller calls libie_ctlq_recv() with num_q_msg >= ring_len, this is caller's
programming error, direct ctlq APIs are not exactly safe, and queue cannot
contain more than ring_len - 1 messages. So maybe worth mentioning in the kdoc.
So the stale slot is not a valid concern.

[...]

> Can this returned pointer be freed concurrently by another thread?
> The pointer is returned without acquiring a reference, and the lock that
> protected it (ctlqs_lock) is released immediately before returning.
> If a concurrent thread initiates teardown via libie_ctlq_deinit(), it could
> remove and free the queue while the caller of libie_find_ctlq() is actively
> accessing it, causing a use-after-free.
> 
idpf and ixd do not do that

* Worrying about impossible libeth configurations

> If the page pool uses compound pages and the offset places iov_base into a
> subsequent 4K frame, calling virt_to_netmem(rx_buf->iov_base) yields the tail
> page rather than the head page.
> Page pool metadata is only valid on the head page, so calling
> page_pool_put_full_netmem() on this tail page could read garbage data.
> 
page_pool in libie_cp is created in a way that makes compound pages impossible

> If the page pool ever returns a smaller truesize (for example via
> libeth_rx_page_pool_params_zc), would a hardware-provided data_len
> up to 4K let iov_len point past the end of the actual buffer?
> 
page_pool via libeth is configured exactly in a way that disables any headroom 
or tailroom, so truesize will never be less than data_len.

* Some parts of code that I agree look semi-ugly (like defines vs virtchnl2 
enums, limiting id to LIBIE_CTLQ_MBX_ID, and lack of low-level completion 
function for Tx control queue), but those I think are best addressed withing 
non-default-mailbox-ctlq development, as currently the best way is unclear, but 
how is looks currently is perfectly acceptable.

* Concerns about HW doorbells and such. Same as with previous versions, the flow 
is consistent with what was in idpf beforehand.

* This one is an outlier:

> 	if (unlikely(msg->data_len > LIBIE_CTLQ_MAX_BUF_LEN)) {
> 		msg->data_len = LIBIE_CTLQ_MAX_BUF_LEN;
> 		msg->chnl_retval = U32_MAX;
> 	}
> Can callers distinguish "hardware returned U32_MAX" from "libie
> truncated the buffer"?
> 

Yes, U32_MAX was chosen, so that it never intersects with the valid HW codes

