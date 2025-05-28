Return-Path: <netdev+bounces-193875-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 237B2AC61F6
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 08:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B684B1BA4800
	for <lists+netdev@lfdr.de>; Wed, 28 May 2025 06:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC816242D8E;
	Wed, 28 May 2025 06:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aIZJpH3+"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056531E1A3B;
	Wed, 28 May 2025 06:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748414173; cv=fail; b=fV84gaGrlvAumYQKobNSI7KGStFeoS6NeKYnFtLvm/HhmA2EyviL5JevN+6+u2uokg/I/KL/yiZIdekST1C9tslmUaH8JC/C7bR/5JZvZrgQvn4gKxcOwSFkr/+JDZxesPtXJOyr7ze7GqrZzyJaHLx94CWOW8IRRcKleZiQxD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748414173; c=relaxed/simple;
	bh=OK38Okz2VAZsrwPYxNzbDtfSedtAny//zRn0qiwDg6A=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Cfn4x8aKeXIaMjKpqSpWx93Cv0+elHBINZ1yyMX3S6JcX7p1pHozwbqty5KDQh2k+U6x8iz7p5ByokxePI7VNDN0Xr+9XTq6W95SWlImJ0w3lxWfUb3O15DkCWVrXQDRFksro5+8v9qFowMQ9wWs3cmfk3d82+2w9uq8khdxaLk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aIZJpH3+; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748414172; x=1779950172;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=OK38Okz2VAZsrwPYxNzbDtfSedtAny//zRn0qiwDg6A=;
  b=aIZJpH3+idppn6C4owa1wRLk9NrVIqC84gWp8KeL6N+BOGY3eGGbDAAf
   y5EktNQhkvTTYrhvz9P+jKI0h4JN4rlN30EKDz0pyx1YFPHQAgD9CERt2
   rh7PVU8I34ydjE35XnGa9HVCxkeDrz0/mg9M1fnFDi0IJQPEx9uuthpEK
   zimKQ4MkoY8p7As8gGNhbZFls4NUU2xKz0/r4siUebf1jGH+pQuibXs3I
   7EGDMif91YjfjD8yQaZWoScZQZvY/30TeYcAiayxZeYd20sdly5s+T1qT
   ZmORwdWwUAv9MknKFCyNVF8NDRe4Amj/5sUfvOx6MalpZDnUKC9d9mWWB
   g==;
X-CSE-ConnectionGUID: 8mBb8ILMRfSW1iPU/Y27SA==
X-CSE-MsgGUID: FKR7aGlbS4qsPKON5EW3Nw==
X-IronPort-AV: E=McAfee;i="6700,10204,11446"; a="50124178"
X-IronPort-AV: E=Sophos;i="6.15,320,1739865600"; 
   d="scan'208";a="50124178"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2025 23:36:12 -0700
X-CSE-ConnectionGUID: FccDcWw8Q9yyapwUm7cVWg==
X-CSE-MsgGUID: 1HRxOW9nR1uz97CYZBoH9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,320,1739865600"; 
   d="scan'208";a="143124585"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2025 23:36:01 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 27 May 2025 23:35:48 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Tue, 27 May 2025 23:35:48 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (40.107.96.63) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Tue, 27 May 2025 23:35:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iop4fjY6RSHNvVxjc6Es5yusPrZXq2wdJ4uIDHoiKYVe3SSPVzWFscdqkBbQoKAKdi1ynQ9HOWHPyh+eAKgPGzHwo/TZ0AmvBVmjO1pg2isro8ZmyJBz29otPMqOeZDpjeeOBVH58IbcoI4H5dCRCd7Zhh6/Rad72MzsqLc12aqSnkHhmKX+5VFPRUTTq8BTyhp7xKIezsBULOAHIlIjYENtKP/nhI++ZDSH82hEcGZ28amHFsQhvupgxuV3GU7wGCF+gtLht20cFHYakICJTgtuBr1oWzobcXvqOpiO8Xui6R68ozEHWpHONPo2Y400Li/byhyDZxzozoavNTZlJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G3JBJCWYPm6b1eJrsdCAe8wuzc5wz6XUnO9Quo/E8Ew=;
 b=ufJ50hKd7AHPlDKoAu6/5h87c5OHxMY/lCPoXD67+GDj0IvIw6uV3eiO5Sdjk8SuG59qlPlaglUqbwvjdJSU2Kk8sSU0HE9zOKCvo4bMNPA/nwJspNIiVCFeId9A+3XQMwLD6r3elSk27R3nd4g+fbdxXPxiLWI3Yw8comKChNDAtxxR0Vyzd7y+/mJQEmMOtBTD5o6VW1+s/GmM6BXKjUu1Z0vZvqLBVkW+lhrmxERIgS6IQGrG/Nk6yy38p4Qp5cv0H5GyAOT8fX15+tLZYsaGipwZs3WxE3Uehg47v+cu0HCa3f6r64btbPbYqYlvOf9dJoZInC8BTI8Hu3QTwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by DM4PR11MB6261.namprd11.prod.outlook.com (2603:10b6:8:a8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.27; Wed, 28 May
 2025 06:35:17 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%5]) with mapi id 15.20.8746.030; Wed, 28 May 2025
 06:35:17 +0000
Date: Wed, 28 May 2025 14:35:05 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Yajun Deng <yajun.deng@linux.dev>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <netdev@vger.kernel.org>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <linux-kernel@vger.kernel.org>, Yajun Deng
	<yajun.deng@linux.dev>, <oliver.sang@intel.com>
Subject: Re: [PATCH net-next] net: phy: Synchronize c45_ids to phy_id
Message-ID: <202505281424.ee78ec7d-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250522131918.31454-1-yajun.deng@linux.dev>
X-ClientProxiedBy: KU0P306CA0023.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:16::18) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|DM4PR11MB6261:EE_
X-MS-Office365-Filtering-Correlation-Id: ed4a1815-6457-44a9-cf9c-08dd9db1cf6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?eIWrVxU2NHBr78rKvx69Vgzv2WNj/UqyWr+vlN7NwL3wWdMPPI7gMWuhDgRn?=
 =?us-ascii?Q?tSb8IMyAanNi7XPc3RypZKPiwDUrIX8sfcsE4LU1hem/kMBNyiu3u9Xb35Bx?=
 =?us-ascii?Q?V3HQFbI26wvMesEYFE4wyLVH2D9byZkQpLQ4hRREELMXVnKuYdnXfD9kGuN0?=
 =?us-ascii?Q?MdTV1bdFNIeDj37hhhhbNjTrPMfh9m9D+U2uy/XHuX6UIRV8QiF9Ab4H0ZN/?=
 =?us-ascii?Q?lS/0eLcz5rS3nxcS69VQ0FZCXGB2XfXphKmwyh6YgTQdOn5LhZ4cNLzGG2xT?=
 =?us-ascii?Q?Fuh6JlcNOhnmG3SkHJ/80mYGKhobUGA6lCTi8OiZrhPB4o5tz4kb0q32B/tb?=
 =?us-ascii?Q?tsGIzgbshXibYTgrarig9Ed3wweUyo61WfpzXq6gLc8jwnbCG0Qo4erVEIjy?=
 =?us-ascii?Q?gnTCijeRYD2sY6DcMAmT3AvI7nnx4jp8KZWSOgj/O/FazOyKw10E2OBSuQII?=
 =?us-ascii?Q?PqjSfBghSM6AjdPTR7F3DyRIS97Y2m1O1ASFhJs0S9Ygz6+GsuAgcoIaBJ37?=
 =?us-ascii?Q?MZ0Npd64XoTV/YNcLSjdyixpBVyDPrgdr441L0BPP/bfyuhsKHSxktDFN0GE?=
 =?us-ascii?Q?8w8dQk2ZIdF8v/zcGmyiT6MMNQMgTpJ+qNOmtx7OLiykMxpwj3BQ6wcbia3B?=
 =?us-ascii?Q?iCCexfO0MejG/iYIhEXEfapPFHHQ8Stv5yya9bUICx5l6lS82aoKXdaVDJBW?=
 =?us-ascii?Q?JCCFPqwN9DicDPjbfHOq4DY5fhnPk291vsdgi1AHjwiOGYaGRn/7RDSGUNDZ?=
 =?us-ascii?Q?+HPAgRQSBo/bAV6MoAjVIf4pH5a8q+G99RYWtGH8Lm+I4AxD+JDK0WhWlMF/?=
 =?us-ascii?Q?eu8VBV2lMG/D0ZbFArmyS08i/Lo32puIxr0Y025Ne88p0kD4/AJrJei7+FyF?=
 =?us-ascii?Q?52r2EYdKXQyLcGCHQE/yvX+o55u3b9LON7wMe80ESek8lv6Vf3zKPo4NlD+o?=
 =?us-ascii?Q?28t2yLQbQkdbvPWQNJ0mxulSOPRtUjCEtXNK1ZI0fP8q/+GiHoC2A7fLt0at?=
 =?us-ascii?Q?O6phMWghNRkTL2goSMNoeLMSSczbViDJuT4goTtgotf+av5W30AwdUFqB3ZE?=
 =?us-ascii?Q?cSIO08Idd9mSJWFH5gH/aBTAnNEXFeZuWhb39Zi4e0j6l4uTNRIjnt4N6hbj?=
 =?us-ascii?Q?prM8vymHh0GdK+P24ryWzTn920coo1XVywlgkJlfgKYeRVxJXwYISt0vcfZ0?=
 =?us-ascii?Q?3q6huR1ixuRuc2VkVZKVhLqS6ljouGxwkRirrXcdFy0ZyPBArLyvx7P6B3K/?=
 =?us-ascii?Q?MCyCvZM3rdnaD/gUpP+0R+0P0Gk4WT9EfMraHnExvk6ChxW5dJiJl1htANPe?=
 =?us-ascii?Q?YD8wE7wQlBR5gq+VPH3wnVqi3y4UFhKkrqPErjbnp1KyEhgj7U1R8yUhUF23?=
 =?us-ascii?Q?8ETrJGM+hSLTPK2KcWvGodTOdSmd?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2O2XIUga5QXojZv9LKyJJQK6MOOtUe/jIcFZahmHDjHeGpc3OrvrAw6rIQtf?=
 =?us-ascii?Q?iSAI8HVb5QM7w+d8cA2Y4eZ6GfgLYu+mGbQe4G2kYfLyvWis/ED+wLxfNhHe?=
 =?us-ascii?Q?fZoY4LfuBy0/lVZMJ0H6YLrnOt6wwDt4QI149TlEqbNaMzFfm0Tfx/mQJj5i?=
 =?us-ascii?Q?nInvFbsoAAu5Rwlp167pB8TNPq2zxz5Up/9N7cUDI2/dj2nZWLShZkxo2P61?=
 =?us-ascii?Q?SJd1e3a3xUnPaEnehxK1/7Jo/U9G8SB+6adtH2MRBxP1oJnzVVos7phTxRH2?=
 =?us-ascii?Q?drYM1mDH3WTFxY4bYtXSF7hizYRVqV5yjr7dZYvo78nIZOgQEfQqJRyh/fku?=
 =?us-ascii?Q?PenKLq+l343L3O7brRtFHw6ystCpUKjPoJ1kD7vnsav2Q5VrYChdW6qB5F/X?=
 =?us-ascii?Q?fe/vf5JIkKaP0hJVvrWDGFJIGZPvsIrhGpA18IZ9gu4OZ4L6EjzMgTH0GwJt?=
 =?us-ascii?Q?8Zb2r8t54G/RtBU8adQXUNuiuRDEvBW80ctvTaRjWbaT3qzfKU710rluiZRP?=
 =?us-ascii?Q?beBZ+nZuEl6v7fBaJ5NKLlhdjtja248qw2biqbOO3hJqKEiafT1U33YrQjY/?=
 =?us-ascii?Q?r4qbKOJh/FdRhN+Cjl8oD/WPHFto0ATGj+oAMVgcsp+gzjHoN+XMjYFE0+TX?=
 =?us-ascii?Q?ncTqkvvS977D0jw0SO1kdlTx4tDDtEVcO89Z3IhVC3eZ2n9vQVl3Q0z+hQSu?=
 =?us-ascii?Q?JP4QupwMiF8H7zca3FaeLmHSIc8cMZT0o124jUJitI5YQqzSJn3Xh5QPS4YP?=
 =?us-ascii?Q?mAMxSxwkdt1sPfS3ihRPxWBMdj6/9YJLFiUEGr9xQP0pTD68d+JUPLFxs1g1?=
 =?us-ascii?Q?zsXokW+09HopNKuRFCW8UvHZqMuMSyAXD7wuexWaIh/WDAf+IgkDsJyFS6v/?=
 =?us-ascii?Q?V2Md9VjO+unxkdmnkn+JZmpbieg9GubIqpZoQnaW3RPRHuhqM1c0YfzrZjuQ?=
 =?us-ascii?Q?rkdAHLPFi+tsXYS8j41+GrTy2Mnj8QpBrwcp0goH2xo81iClxXq2SBHfdKQf?=
 =?us-ascii?Q?6eZbVspf9c9RrL6gR4eI2c1f4ypescQSqio5xLzyscq5D6U2CBDLTUS70E1h?=
 =?us-ascii?Q?6Hs9LCRgRL0GfCm/nHQc9MKHmUygJgbShTA7gBe5tacRAS8ELKKzIBopMxGq?=
 =?us-ascii?Q?tP5wlgwqvRotWBpfdkLglq5myGmmwnopqayNwl6Uqsrpx2tZBEtIXIEaFDic?=
 =?us-ascii?Q?Q9js4w8bQ6TVIYCln8ErIBUY67viQFIquHHK7UaznCD5yTKrZvaGv+NPDcN/?=
 =?us-ascii?Q?d+lx/5ZG3LbH2rnyjZCxm/INmzOuua0eYavbR2UTuynNkSLfNrffqQIMYv3Z?=
 =?us-ascii?Q?XXyGyr6yxOVfPM+rq5Dnd7Lq7kslpAbicaHgbWMLiWsSSEc8wGRriLVrpv6d?=
 =?us-ascii?Q?iRnlDh1crXDF6LO8TzrkV+rLIze1UW77pzbD9BKTTzB9OdlKUPNzWZ6Cdo+f?=
 =?us-ascii?Q?3VhuyI9+xa86Aaal7GPyvr2CH0Xf/1VSlc7zn77EO3Gd7rMjEre/UYjxBpKG?=
 =?us-ascii?Q?ygVrksRXOAoevZ4SgmalrIFWd213Wyz4jfvdCnizBYeHIQT7HFbSZ/hUjJh9?=
 =?us-ascii?Q?+nedOFW+ANRxpTiZUDku+RHgrH828tYifOUJyBcS4q1DCgoWtMgPb18NhV3c?=
 =?us-ascii?Q?Vw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ed4a1815-6457-44a9-cf9c-08dd9db1cf6b
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2025 06:35:17.2234
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HxZUsAHuQNiR0qLNytD3/ybEvWJPKd+ecPqZl/RD5Rxq+Oz79HilPQJuZaK2w4+WFFEeMXcOzZ0KQpaV5h8oNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6261
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "WARNING:at_drivers/net/phy/phy.c:#_phy_state_machine" on:

commit: 5ba1925a399bc2393c503a70406edea488b549ff ("[PATCH net-next] net: phy: Synchronize c45_ids to phy_id")
url: https://github.com/intel-lab-lkp/linux/commits/Yajun-Deng/net-phy-Synchronize-c45_ids-to-phy_id/20250522-212043
base: https://git.kernel.org/cgit/linux/kernel/git/davem/net-next.git 3da895b23901964fcf23450f10b529d45069f333
patch link: https://lore.kernel.org/all/20250522131918.31454-1-yajun.deng@linux.dev/
patch subject: [PATCH net-next] net: phy: Synchronize c45_ids to phy_id

in testcase: rcutorture
version: 
with following parameters:

	runtime: 300s
	test: cpuhotplug
	torture_type: tasks



config: x86_64-randconfig-121-20250524
compiler: clang-20
test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -m 16G

(please refer to attached dmesg/kmsg for entire log/backtrace)


+------------------------------------------------------+------------+------------+
|                                                      | 3da895b239 | 5ba1925a39 |
+------------------------------------------------------+------------+------------+
| WARNING:at_drivers/net/phy/phy.c:#_phy_state_machine | 0          | 18         |
| RIP:_phy_state_machine                               | 0          | 18         |
+------------------------------------------------------+------------+------------+


If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202505281424.ee78ec7d-lkp@intel.com


[   12.608484][   T25] ------------[ cut here ]------------
[ 12.609643][ T25] _phy_start_aneg+0x0/0xf0: returned: -1 
[ 12.610888][ T25] WARNING: CPU: 1 PID: 25 at drivers/net/phy/phy.c:1350 _phy_state_machine (drivers/net/phy/phy.c:1350) 
[   12.612870][   T25] Modules linked in:
[   12.613775][   T25] CPU: 1 UID: 0 PID: 25 Comm: kworker/1:0 Tainted: G                T   6.15.0-rc6-01307-g5ba1925a399b #1 PREEMPT(voluntary)
[   12.614298][    T7] e1000: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX
[   12.616470][   T25] Tainted: [T]=RANDSTRUCT
[   12.619076][   T25] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[   12.624259][    T1] dsa-loop fixed-0:1f lan2: configuring for phy/gmii link mode
[   12.626882][   T25] Workqueue: events_power_efficient phy_state_machine
[   12.628568][    T7] ------------[ cut here ]------------
[ 12.629750][ T25] RIP: 0010:_phy_state_machine (drivers/net/phy/phy.c:1350) 
[ 12.630847][ T7] _phy_start_aneg+0x0/0xf0: returned: -1 
[ 12.632047][ T25] Code: 49 c7 c6 c0 e3 1d 82 bd 01 00 00 00 83 f8 ed 0f 84 21 01 00 00 85 c0 79 6b 48 c7 c7 96 7b ec 83 4c 89 f6 89 c2 e8 21 7e 0f ff <0f> 0b 48 8d bb f8 05 00 00 e8 63 43 17 ff 84 c0 0f 84 0c 01 00 00
All code
========
   0:	49 c7 c6 c0 e3 1d 82 	mov    $0xffffffff821de3c0,%r14
   7:	bd 01 00 00 00       	mov    $0x1,%ebp
   c:	83 f8 ed             	cmp    $0xffffffed,%eax
   f:	0f 84 21 01 00 00    	je     0x136
  15:	85 c0                	test   %eax,%eax
  17:	79 6b                	jns    0x84
  19:	48 c7 c7 96 7b ec 83 	mov    $0xffffffff83ec7b96,%rdi
  20:	4c 89 f6             	mov    %r14,%rsi
  23:	89 c2                	mov    %eax,%edx
  25:	e8 21 7e 0f ff       	call   0xffffffffff0f7e4b
  2a:*	0f 0b                	ud2		<-- trapping instruction
  2c:	48 8d bb f8 05 00 00 	lea    0x5f8(%rbx),%rdi
  33:	e8 63 43 17 ff       	call   0xffffffffff17439b
  38:	84 c0                	test   %al,%al
  3a:	0f 84 0c 01 00 00    	je     0x14c

Code starting with the faulting instruction
===========================================
   0:	0f 0b                	ud2
   2:	48 8d bb f8 05 00 00 	lea    0x5f8(%rbx),%rdi
   9:	e8 63 43 17 ff       	call   0xffffffffff174371
   e:	84 c0                	test   %al,%al
  10:	0f 84 0c 01 00 00    	je     0x122
[ 12.633319][ T7] WARNING: CPU: 0 PID: 7 at drivers/net/phy/phy.c:1350 _phy_state_machine (drivers/net/phy/phy.c:1350) 
[   12.637175][   T25] RSP: 0018:ffff888102e5fdc8 EFLAGS: 00010246
[   12.638506][    T7] Modules linked in:
[   12.639158][   T25]
[   12.639576][    T7] CPU: 0 UID: 0 PID: 7 Comm: kworker/0:1 Tainted: G                T   6.15.0-rc6-01307-g5ba1925a399b #1 PREEMPT(voluntary)
[   12.639823][   T25] RAX: 0000000000000000 RBX: ffff88813a422000 RCX: 0000000000000000
[   12.641190][    T7] Tainted: [T]=RANDSTRUCT
[   12.642046][   T25] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[   12.642049][   T25] RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
[   12.642052][   T25] R10: 0000000000000000 R11: 0000000000000000 R12: ffff888100079800
[   12.642054][   T25] R13: ffff88842fdea840 R14: ffffffff821de3c0 R15: 0000000000000004
[   12.642057][   T25] FS:  0000000000000000(0000) GS:ffff8884aa5fc000(0000) knlGS:0000000000000000
[   12.642060][   T25] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   12.642062][   T25] CR2: 00007fc38285a160 CR3: 0000000004296000 CR4: 00000000000006b0
[   12.642067][   T25] Call Trace:
[   12.642072][   T25]  <TASK>
[ 12.642079][ T25] ? process_scheduled_works (kernel/workqueue.c:3214) 
[ 12.642086][ T25] phy_state_machine (drivers/net/phy/phy.c:1612) 
[ 12.642093][ T25] ? process_scheduled_works (kernel/workqueue.c:3214) 
[ 12.642097][ T25] process_scheduled_works (kernel/workqueue.c:3243) 
[ 12.642117][ T25] worker_thread (include/linux/list.h:373 kernel/workqueue.c:946 kernel/workqueue.c:3401) 
[ 12.642127][ T25] ? pr_cont_work (kernel/workqueue.c:3346) 
[ 12.642130][ T25] kthread (kernel/kthread.c:466) 
[ 12.642138][ T25] ? kthread_unuse_mm (kernel/kthread.c:413) 
[ 12.642144][ T25] ret_from_fork (arch/x86/kernel/process.c:159) 
[ 12.642149][ T25] ? kthread_unuse_mm (kernel/kthread.c:413) 
[ 12.642155][ T25] ret_from_fork_asm (arch/x86/entry/entry_64.S:258) 
[   12.642178][   T25]  </TASK>
[   12.642180][   T25] irq event stamp: 14831
[ 12.642182][ T25] hardirqs last enabled at (14837): vprintk_emit (arch/x86/include/asm/irqflags.h:26 arch/x86/include/asm/irqflags.h:109 arch/x86/include/asm/irqflags.h:151 kernel/printk/printk.c:2043 kernel/printk/printk.c:2449) 
[ 12.642187][ T25] hardirqs last disabled at (14842): vprintk_emit (kernel/printk/printk.c:2022) 
[ 12.642192][ T25] softirqs last enabled at (14648): __irq_exit_rcu (arch/x86/include/asm/jump_label.h:36 kernel/softirq.c:682) 
[ 12.642197][ T25] softirqs last disabled at (14643): __irq_exit_rcu (arch/x86/include/asm/jump_label.h:36 kernel/softirq.c:682) 
[   12.642201][   T25] ---[ end trace 0000000000000000 ]---
[   12.645728][    T1] dsa-loop fixed-0:1f lan3: configuring for phy/gmii link mode
[   12.648032][    T1] dsa-loop fixed-0:1f lan4: configuring for phy/gmii link mode
[   12.648206][    T7] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014


The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20250528/202505281424.ee78ec7d-lkp@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


