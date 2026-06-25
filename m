Return-Path: <netdev+bounces-301922-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 89Z+HMT+PGoBvggAu9opvQ
	(envelope-from <netdev+bounces-301922-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 12:11:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF946C4831
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 12:11:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b="M2blws/v";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301922-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-301922-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AB6AD300B0B9
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 10:11:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC0D3CE084;
	Thu, 25 Jun 2026 10:11:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929153CE09C;
	Thu, 25 Jun 2026 10:11:08 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782382270; cv=fail; b=mYzI/PMGb7P/gA0N3C+wh1N0ihzgBcMEoJ/nepiLRJCY3W6otNsDh7Fp0rYBSh2ClUjDE5J2JVMX79x12i5lRgTPx/FOUHVerj/gtSnr0ZQ2gDd7BL3iGbqYDsB12/yexlArcJh5+nFFvlO6TmgMfU91iGgvdahkTVV053zuOtI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782382270; c=relaxed/simple;
	bh=SXTSUugRO2Vpzz40+lLlV+2iAE2y/8T+4rTb5jY/pOM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lEveTfOUj+fLFd+YpW+D4cT9dp2h4vUd+DkqswnuKesNtXb+3kTHow+geJdRRvswNnFEX7l46kTACB/Syazxs0wK3v26phPz0tDkcb4GVmGPq34xKtug4AL3oTvaGGMqiDtrvP+7Qk748P/+2hvnQuNp0cCaPvprBtBsaT3SUT4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M2blws/v; arc=fail smtp.client-ip=198.175.65.17
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782382268; x=1813918268;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=SXTSUugRO2Vpzz40+lLlV+2iAE2y/8T+4rTb5jY/pOM=;
  b=M2blws/v8gzmL9q/biDPpKftYyWt+ycBhuvA84pUBVT351YAOIB6mtls
   K6woMuaUtGHj27p6Jmmwhw23vl8x3iP65awFK6K2rBAJWHwro5ljq4ZR1
   VAzx0MuF8FyPkLYQVie9aG7xqxPl08EgYuVL2zHJtYdirX/ndL7MTRWR4
   LFd2qr6JZYx/ShfZKSTzMzLooabZgMwoIIEhI7Yv8es8PAjyuwIPegyhL
   xtYKUroyBupUBVpebuZ0s5RpAGi5Fr/jI8bQ0qjlRcHV4QwS+5QhJUXUL
   SxNLnAuEJJrjXmBd8jC41rQpqNjCDdFBWJiE8Qqi4367Jld1AKjqP4nQl
   g==;
X-CSE-ConnectionGUID: /mTlO5yRTyajgFPPFRC8XQ==
X-CSE-MsgGUID: qULBKILqRumPgM9wJjqxcA==
X-IronPort-AV: E=McAfee;i="6800,10657,11827"; a="83159233"
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; 
   d="scan'208";a="83159233"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 03:11:07 -0700
X-CSE-ConnectionGUID: gsunw1tKSFaGUIftu5r+hw==
X-CSE-MsgGUID: Q4C0UaZ+T1iLQd7tys9eLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,224,1774335600"; 
   d="scan'208";a="255220981"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2026 03:11:07 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 25 Jun 2026 03:11:07 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 25 Jun 2026 03:11:07 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.42) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 25 Jun 2026 03:11:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kBuGvO9Luh8CJYHI8KW0nknLsy5/5Ub2vhkp6QVOyCU6h1TbwR4dzTS7J5eQfwDkzChC6DIsa4cEN1GXrPo5MzEw1CyqAWoL1eKneVO8zpJblsZutWxwV83k5N/k7M+XZVE+b6VyiyLiauJyHXe+rbQmP6O/p3cH1zc0Atn0vWc7Efp4gAXkB4mTvqWBh6ouANOdi181WC8dZEZ0OeZutCNOfAeljdtRfhV65LMkuhtcxaNPyW4Aq4qjNoDSL1PzwyJkIdj3MnPhaP6ueIa3RVWwZvJtoPMvtMwemYzbbz6Ga3O0McEcfj3OajU7yVs+nt88FwOZ0cyvfyjdzenDBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bi+RuS6AAi81KnAc/9RPBWbLSxGLFkxOgnBRWyF60K8=;
 b=m7C9YLO82nA+3Kz2Q8uhyg8M5U/9yTnVKGTUUfXeHCwZ7LggBCSYMc0ukNGstMMmbIKss9CVKh0oAZjvQvQCYujEzuIIM8JYOEVh1kC5GS0F6OI+l8Bl8lpuECNJMpQkvV7Cpz69p44AmpOVotZDT6p4sPfmZ65U118olNYmJT78z21yacBvqdBir9zQilcgmNnlZVXR+71zOXlPtqKuy2KXWewg+0JRXhkSIz5rT0rpZl7saQIrtH6fHT5bplTiUWzExBslNqvVig9oaKSQVl3/gHzX1CvjVK6kv85ieHxLFO+dN6bIqdQ576D7vMbUQgTnZImaIf9nyGDGuYpOUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB2556.namprd11.prod.outlook.com (2603:10b6:5:c6::10) by
 PH0PR11MB4901.namprd11.prod.outlook.com (2603:10b6:510:3a::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.17; Thu, 25 Jun 2026 10:11:05 +0000
Received: from DM6PR11MB2556.namprd11.prod.outlook.com
 ([fe80::ab22:139c:b0e5:20ac]) by DM6PR11MB2556.namprd11.prod.outlook.com
 ([fe80::ab22:139c:b0e5:20ac%5]) with mapi id 15.21.0159.013; Thu, 25 Jun 2026
 10:11:05 +0000
Date: Thu, 25 Jun 2026 12:10:56 +0200
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Wentao Liang <vulab@iscas.ac.cn>
CC: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] net: mdio: airoha: fix reset control leak in error
 path
Message-ID: <ajz-sBFRyvjyV7gb@soc-5CG4396X81.clients.intel.com>
References: <20260622115403.39772-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260622115403.39772-1-vulab@iscas.ac.cn>
X-ClientProxiedBy: WA2P291CA0036.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::9) To DM6PR11MB2556.namprd11.prod.outlook.com
 (2603:10b6:5:c6::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB2556:EE_|PH0PR11MB4901:EE_
X-MS-Office365-Filtering-Correlation-Id: 228096f6-d4e0-4219-5ca6-08ded2a21136
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|7416014|376014|23010399003|366016|1800799024|6133799003|56012099006|11063799006|5023799004|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: RWBhbaCohIVr198J6agkQkvrOjJOp2VXytyHNWU+VnxSp6nZIS5AabWyVJT1jgLHzj9LRvJg9IP7mArAixLen+d9/w4YAsTdleqKfOGLxa5Q41v/LjafPm5nHVXoOMxZAL1j4K1AM8ZW/yPA35vVBh+OvlyM3zslTXHdExr3025x5bW8DZYhp5gVDO0XFmC+og72ti4po2Ar/ghgFzCpaP9P1Dq32LfwbsPYv0AEhbINLWmZ3tq9QVsVLEvmHXY2UAwq/aMCoByw+2ln+W9fQFA/pkHGCcgh5H/CoRqXHKf/9xrjv3N5eAC9XZp0ubZD/ISGvEW0zMx/hqpNL1215RTHpZTaFmCixI6xPr/YeYHTuBkq5oWu+1yc6i+5eWP+JhS246YZ3rXFGfzKskHiItfDM2RJJdfgD3+/SgQ0wr/fCURu6ZLCjBtRVEpzeWxJ4NHCNtu51bD2NA0OFmWSkmbmA4uGcQ49XyL+6NlF5CfeqwNjKc+wP3DnVjs2qsmfJ1s+qkWQC2vkDdv/r03RkZXIoAjhftP72JhOzS9oAp7DVp2rfjG/AQkIq+2KVpScEyoOq5SVtLikiyuf/VoBAwl47JhLxMoFbjpwoNvr73g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2556.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(376014)(23010399003)(366016)(1800799024)(6133799003)(56012099006)(11063799006)(5023799004)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Jm0lRcw87vEE6TeZr4j4c5OdpFK8sk/HkT416D5IzO1q3Gl74EqM01ku2rsY?=
 =?us-ascii?Q?tRNw00uiekWO8wVrtjkO66v8ALCp/umVR9ObEPhamjtouDlIPfDx7UL/k4Jy?=
 =?us-ascii?Q?RhL1ZGVDWBvKfNw0O6HvfPDQRW0ouus6jE4PFKVYdPPdb7yGjT10cDjal88O?=
 =?us-ascii?Q?CkZ3g4tAbR7S6mCI4dwrnZsL8ZpFaRiwcvUw6LIno4BYcq8iZUalU5t5A2eP?=
 =?us-ascii?Q?OCDOifHmfTQFIyrGBNDEmO1DQwS3DR4lCMT9l2eeaWfXGkJ3OlHHHgOd8Cdc?=
 =?us-ascii?Q?XTf/RG2vb+DoVRVTASXy56UvvDMHbgXrzbNqcTxT++I3dndbrIVzAvaP/nD6?=
 =?us-ascii?Q?Mot2el5gYzwjYx6JyGSj/e5BnwyZgIttcjATQTAA4IzD5FHZQNs/7ds3RGAl?=
 =?us-ascii?Q?C7gjxQ4o7IW28rpMKIUFGzl8QZg+WFObjSnlN3IFcn0t/lCPN65npKndJ49l?=
 =?us-ascii?Q?VdGDcCz7AJIg2brFbFsnqGpMbY5pjc4oE+gNwX5rxRDa57e7JlccKbMAkYCP?=
 =?us-ascii?Q?KCCIGol/agS/mUeXTOHv1YUlCrlAlfALmgENolJh9XypBMOLrlYsVJZOQWy9?=
 =?us-ascii?Q?IdegCrqOWKcADWg0/YWZYmUw1JJpd2MGqkQG3SHSzVN4RqDFLZBibmoINwZd?=
 =?us-ascii?Q?u4JyuOF8+68pXs/qHz8Hdaw1ACbY4UAZ+gPe4w4uhlolOEHL5er9YFgNIwU2?=
 =?us-ascii?Q?gblj4X+WDfQ7JGM0p7YU+EEUuCuxZdLO4xGop76qYto1c1FCmQNPX9EL86U1?=
 =?us-ascii?Q?B9UoVAsGsrlVcJ8EObkm4xhVP9QUINyqzNlPgBRjV64aOb2O6SDEQspmSyNu?=
 =?us-ascii?Q?SvdvuBkDaVG8zJPLaLkVJzyNK0fw2+A+VrzjVyOygmR5eROg65lCLObWwiiZ?=
 =?us-ascii?Q?I62GicSoERzyrhEmkhpf5FQjG4cU58oaOIABp0v/NGLQ9rujY2S+pWQzelUP?=
 =?us-ascii?Q?pfoCWjV5l5XB5ZwuDwO4tOldIpusoKeJJDb7H3UcLwy+ULVj5J1IrFPJyEAd?=
 =?us-ascii?Q?LrqGGSuPvSQgFRWdYNesugjOohzpcrAGZ1AUZGXHop4t/h0etC2v42l9vThT?=
 =?us-ascii?Q?I/oqV3TJGQixDVKC5WwWrCK+p5j0+wQm0Ymnu4rK+Wwrkkn4yBk1uLzs9uGN?=
 =?us-ascii?Q?pPs9OqDud8zQVsKpasJl1rXekegfEs8mKgTko50bMW+4QxhvTbQjTgqvTQX1?=
 =?us-ascii?Q?QFFbBHH55EZ26tE7Hbgsg43L2xgqC2CeG+sF602Lpr5vz6fHY2s0dIeXB3GD?=
 =?us-ascii?Q?lrVKf8RwAHQB3FA7iAtQiP8FuO6Er7BtjmwvjYfi5JN4v9S17KwmVgTudsyU?=
 =?us-ascii?Q?uFi0ElWnY6S6wpwwNS5aisdhuNVkp+eyScgglhVelZStZCAvv0Z+M8lggruf?=
 =?us-ascii?Q?W2tblIFA3lLtB7omY+VRCKyBx/mo7hq0lyOlr18OE9f6Erd8SReNHWWbn5B5?=
 =?us-ascii?Q?ITLfeY6QXvN5RhmvCuPwbHKEgabPrKfTFcgY1k4+8sLijP30R1l4PTkkvrMb?=
 =?us-ascii?Q?IhlIRbtyljjNVuK3Wpl9u0PVHiJip1oVFr7SmU+thlDC9fekKvn0XvhAPEdd?=
 =?us-ascii?Q?457dv+otPS6oy73+W6S4k2gkxXf/P8LmbyrTu8h3/onyF/mZ26Z8Jubcl3Xc?=
 =?us-ascii?Q?RL4l4trZKEkB0t4JI0xHH1sHroOZn5IP042vWKFEwiIu80GIPBvnJxzSTd0U?=
 =?us-ascii?Q?d2/2eKi74/6l7t3gFjskT9s2jVQViLuB6Urkm3/0RGZt1tIgfcXjXYAEFCJv?=
 =?us-ascii?Q?HVNFxjxvjHGh3D9By7fTDwCFIle7iP97vFz5r4MmWtVKs5HEzkKd9Zg/aiih?=
X-MS-Exchange-AntiSpam-MessageData-1: sTROuNiZnh/3LWuve0eEIod9ebAw1zybW3w=
X-Exchange-RoutingPolicyChecked: J/tf25sElJsT58+fA3R5EOVHQtWBUE6s7sY7TTqk7j9u3uUS9RgYIY033MBV1AZ/OXAxNGLyiNgZThmubq+wMNMqegj1YAZHOcfCXvDqJ1KOcRthZ0Q1DJA9LzjoP2RxRAfOuX7wIL2gcKT7ws/EJ/JPXmX1ZkA2876yp7B3hCcz6U9AWpYhGumgvkKAg/lbx6BVXM+pDIDc/E2wPs9HVkBK9asQIAMnF/rjuv3bSvwvW85YDtdzPymXYPEFL6nt/g9c7VTQv1hcbAgpCgVnv3YIKiYQIbCWwSyAca0WCRUlk4DivFaSPYHGRJihcJ1YPNrkcEihagKMTqS36reBqg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 228096f6-d4e0-4219-5ca6-08ded2a21136
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2556.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 10:11:05.1230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F2OUbIyYpPVsrVpnZ8naJ8XgrsnYbTNjIuWR3h3Fh17ltezttq4QJ3NvmCuegkOtfxuf7dlRYmRMByPWmirK5N22Jop/kueIxq4yRGew7CA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4901
X-OriginatorOrg: intel.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[intel.com:d:+,kernel.org:s:+];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,sashiko.dev:url,intel.com:dkim,intel.com:from_mime,vger.kernel.org:from_smtp,linux.dev:url,soc-5CG4396X81.clients.intel.com:mid];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-301922-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:vulab@iscas.ac.cn,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[larysa.zaremba@intel.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[larysa.zaremba@intel.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[10]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6FF946C4831


Please, specify the target tree (probably, net) via a subject prefix.
Also, looks like you are missing to many CCs [0]

[0] 
https://netdev-ctrl.bots.linux.dev/logs/build/1114710/14639274/cc_maintainers/summary

On Mon, Jun 22, 2026 at 07:54:03PM +0800, Wentao Liang wrote:
> In airoha_mdio_probe(), after calling reset_control_deassert(),
> if clk_set_rate() fails, the function returns immediately without
> calling reset_control_assert(). This leaves the reset line
> deasserted and causes a reference count leak on shared reset
> controllers.
>

Sashiko correctly points out that since the reset controller is exclusive, 
there is no refcount leak. [1]

So the problem is missing rstc->rcdev->ops->assert(rstc->rcdev, rstc->id) call. 
It would be great if you could describe, what problem this can cause.

> Fix this by reorganizing the error handling to use a goto label,
> ensuring reset_control_assert() is called on all error paths
> before returning.
> 
> Also add error checking for reset_control_deassert().

Sashiko correctly points out you do not actually do this, which is fine, just 
update the commit message. [1]

[1] https://sashiko.dev/#/patchset/20260622115403.39772-1-vulab%40iscas.ac.cn

> Fixes: 67e3ba978361 ("net: mdio: Add MDIO bus controller for Airoha AN7583")
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/net/mdio/mdio-airoha.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/mdio/mdio-airoha.c b/drivers/net/mdio/mdio-airoha.c
> index 52e7475121ea..4c1b2415687c 100644
> --- a/drivers/net/mdio/mdio-airoha.c
> +++ b/drivers/net/mdio/mdio-airoha.c
> @@ -246,15 +246,17 @@ static int airoha_mdio_probe(struct platform_device *pdev)
>  
>  	ret = clk_set_rate(priv->clk, freq);
>  	if (ret)
> -		return ret;
> +		goto err_reset_assert;
>  
>  	ret = devm_of_mdiobus_register(dev, bus, dev->of_node);
> -	if (ret) {
> -		reset_control_assert(priv->reset);
> -		return ret;
> -	}
> +	if (ret)
> +		goto err_reset_assert;
>  
>  	return 0;
> +
> +err_reset_assert:
> +	reset_control_assert(priv->reset);
> +	return ret;
>  }
>  
>  static const struct of_device_id airoha_mdio_dt_ids[] = {
> -- 
> 2.39.5 (Apple Git-154)
> 
> 

