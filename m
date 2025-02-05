Return-Path: <netdev+bounces-163282-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A456A29CCD
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 23:47:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A51F03A6979
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 22:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24CC2217645;
	Wed,  5 Feb 2025 22:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ec+G/b5b"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E8A215179;
	Wed,  5 Feb 2025 22:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738795647; cv=fail; b=M9IoyaBQC/QqhxRcRw/fULFjRzWsCfxsqWDg5tVX0aUmjQuIA6ipGRXHMhg96s90edgVLMCHTN0ZkrfGCW/csbyyLdRPsTEKgZ/Uc5uSo61s2XwAZkK9UdZAM+Zj51q3V1UvXtoxv1IZ2j33F9dDBSEHSj/73ktWvXxzGGjKFk8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738795647; c=relaxed/simple;
	bh=kkYhEx2TQMs4YQSJXfUVC1efEU1Nt01xnuX7JeMYzk4=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=A6j3OHGFu9kW6s+xWGQYFB+8aJZjIrS2c/BwgCwy8edE/KoV+H9y9rjdEILn8Sa0+4nJX5akrctT5LCOZLE2D4GB+akoG2i25aTcvFBkM86w6lXYDvXPcCzCDLSHQkEO/6ll9LfJy9TVeYXqFtlHqXtmgPQt4TN/RWbfYLZFs8A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ec+G/b5b; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738795645; x=1770331645;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=kkYhEx2TQMs4YQSJXfUVC1efEU1Nt01xnuX7JeMYzk4=;
  b=ec+G/b5b2Jm8phcxAhyeksrydXZfbc53if1W6qk/F9/L9kvq8k9pvZgd
   xR/GBFJoXCLLxl6c82K9KIlODR244A9TUj6Gt6D6V228Ccuh3uUNku+YB
   Ur92pQBzQs55l4fxHatqSWp31cch1sgM0TY5Jb4sEGcsKvQDd4iScDgNw
   g5lQN+eyuQJIkvS2zaUkgizfS30rx8F4FQ/+cXSSyVKN5+qVY8fLOxIUY
   YTMvRtEKfElg4ABkg/+IPGjY69uZ6bcxFIyAD1+1WQVxLW3iUGxNs2C86
   s/zNrPu9JhGS/hh8QgNSyy/DyOKm5phUvUD0gM/to3dED5aqYjq9kBfDT
   w==;
X-CSE-ConnectionGUID: zPRRip3aTGyHiiD4XQ6ziQ==
X-CSE-MsgGUID: zXT6+ezpQYugnIIwHn6jqA==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="50804776"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="50804776"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 14:47:24 -0800
X-CSE-ConnectionGUID: L7GoTkbJRHCfaPeiqihXZw==
X-CSE-MsgGUID: 2+tSe06+QBGmi+hqsAojhA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,262,1732608000"; 
   d="scan'208";a="110933162"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Feb 2025 14:47:24 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 5 Feb 2025 14:47:23 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 5 Feb 2025 14:47:23 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 5 Feb 2025 14:47:23 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MlxqUp2tfHF+8YdSbIOwoKtGuLgMjkqmv0Zp5/E5mhlOYnumwl+Vnu6OY/qOqI4It4hJdQ6vTkZvsWh6v0S07//YeuqCUrRJQoNCVMSvynXbQwQVayJ97fUSNbGpkWHOV+P5LpcMv0AMYGN8q53Fs0nREEFV/qtIoC6bYZfti4SDWuENJfDaSMPlHkjhaKpcb1FD5MJwo+KFB8ysWP0b1Cf7CABl6j6bTOv5MTtOyIcHKotIzz0LGM2m/50+BfjZhqn6Dqv3eRkxGi2Xhxoz82sFPn1J2mpN/BLGgiwmM7Hl9cf5P7UPONtYlikfBNXYlQ5xvQSRTZWJdPTRCkIj8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H5dYQ5vHoE70SM9wXEtMlbHpn6mMR7ZYPhz0yYI79Rw=;
 b=j9+dOR3Lkt1xwSCQj9ZwYiIOkC8BIKSZHX8Y9ILLiL98dHxZiQyerOCl8RjYA1Rqn//eyMw6+ZB11a6KW4woc5+PuhUEQhhzezrjtTvDnHYIRD4xPNQaIT/KbpvF8fsSvot/zBjKmNLe/RO46QYn2WMLNrEEFF4/+Y98Y7/ed6uZIpJ7PcLoDye+ZMS6ICdTQ2BHL4pBc2Cid0kP8xmkZcJ6IFkL7x73/Iw/z7AXRD09sY9jufkVGzzRMJlu4Yy6CC83yhhDMBXmmajCsbPzWjcD2MAZ2vQJ2JWrO5QvV1gV1TiKOPdrnCfdluVP23bjrEZMLk08eSEgcOx5FXxehw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH7PR11MB7097.namprd11.prod.outlook.com (2603:10b6:510:20c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Wed, 5 Feb
 2025 22:47:18 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%6]) with mapi id 15.20.8398.020; Wed, 5 Feb 2025
 22:47:18 +0000
Date: Wed, 5 Feb 2025 16:47:09 -0600
From: Ira Weiny <ira.weiny@intel.com>
To: <alucerop@amd.com>, <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v10 15/26] sfc: obtain root decoder with enough HPA free
 space
Message-ID: <67a3ea6d8432e_2ee27529434@iweiny-mobl.notmuch>
References: <20250205151950.25268-1-alucerop@amd.com>
 <20250205151950.25268-16-alucerop@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250205151950.25268-16-alucerop@amd.com>
X-ClientProxiedBy: MW4P220CA0011.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::16) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH7PR11MB7097:EE_
X-MS-Office365-Filtering-Correlation-Id: d85249b0-603f-4e3a-7029-08dd46370b4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GRnxnlk+he4+iz2WQ0j0XCG1unA3QdvR2qvQRMUa/o0vsX2aT6qOs5DTEJ7Z?=
 =?us-ascii?Q?sKUtZi16vL6ZGcfHpqCPhFETNX4iVXwWTZHcG77yygLw5QAGzeEbC3b9B/Dr?=
 =?us-ascii?Q?0gRvCebCuhuC9Vf2XcJ/A94jU5QMeuFE7Bnh1OrzbHk4aTJ7q8qgh83ynIla?=
 =?us-ascii?Q?beGOeEaoZSXQdk+uANLSG+SCupTLLxHwHqhngesqNGETLxP4fUmqWENBZslW?=
 =?us-ascii?Q?MtoickSK32+dHVpd4KmtyyQXsAU5q1nlOdIezeeCsYp+KEgvBuenJnQhEeoQ?=
 =?us-ascii?Q?kaOv4GrvDTwAOGWQMVb+U2ddNomF8DasSU8Mtlb6WXtefNecmi8RfvE86ewt?=
 =?us-ascii?Q?F0IS8W9b55CUnbDMSuURDVCeEw9UOIDuHogWcdToWvi/wFDNqGlvlZ4oORBs?=
 =?us-ascii?Q?O8ajgQ1N+NkqjVP9NY+6uBEfrFbZI2/HJE/zzbJajtl4X7Zej/GU7M9sO34A?=
 =?us-ascii?Q?zMoQcCOTN5AxvdrGOq+Rs1z0r9GNE095vPsA7tqyuPEkaq+AjJycquo51en+?=
 =?us-ascii?Q?CQFN/amJl6KsTdRgD0DPrvvn4xqS1pphJXniV8e5cI5jqCPj/lxvtVUduBUf?=
 =?us-ascii?Q?OXjACdojMKiHdeciJeTCMsBoklsOob/sZcDm6oj0oaN7X34fUDe5nqVuuLsJ?=
 =?us-ascii?Q?SRSfyIufs+OJH6djND+Y8KLFXHtPl43nWp7XQNvcV6Q/1JBVQHWq+QU/iYK/?=
 =?us-ascii?Q?IVWnOxnnWzB1NAqban1k28Lt3lKxPrIlyet5mWQt/DEdT/VGzc+bK/rh5ayi?=
 =?us-ascii?Q?dKJG5jDPbHLEtXCeL7umLFZgPrKaJydlxDDLSetoCRDYs50OS/piwwOGvcWH?=
 =?us-ascii?Q?1lmOJP0SlyS9/NwBklHH6bT6+H4P5kj3XMqTaH3YKkPsc0c709sNaqUYPAp+?=
 =?us-ascii?Q?wBaR0lUYivdNLRGpkodAm/zfMeyI29sRZpup40Dy2BzkGvBnvA2efrsgAtb2?=
 =?us-ascii?Q?1CK1uZwwTWENEU9mt9Oqs7y0M8Bqm9r78VwJkeqDaM+csQ9tn4nE7w9kefUC?=
 =?us-ascii?Q?P1MxUqk1EhKLHh6ozlTZvflT/kz8QyWEW/Hm7pPm1VeD9bmABGn7AtnHG17i?=
 =?us-ascii?Q?YWyviYQ9vCz+SiGo9Exolq53hg9+TzFSXovPlYPq7xYA2QAI9AVugS+/pwwn?=
 =?us-ascii?Q?wpCWaYQx1VzrtzeNWDGJmMmmp1L06dO2VT5CeSlJygddoUs0fR2+l23J0B6m?=
 =?us-ascii?Q?2WTfjwgN/UKWuRj4MkYXRVOjGQZ/RU2zVexzrRKUV5vQCQm5rSpykjSRVxzy?=
 =?us-ascii?Q?QRfY4OnAO3JT9Ekt/hTgOl0ouMk4DZJ0D/p1Qa+AKBUplKLMJB6cPvgwwQrK?=
 =?us-ascii?Q?QUjNE8E0FOUORCP/4/jRP5iNcuzSqIfd9zIJb0jmwZR5a0Mp7RR+WVx7ita6?=
 =?us-ascii?Q?2k81h/90TrxkH58kGIm895fYSrHtKas9NrHmE1aaSJgJgauPBSZreN3fVwaj?=
 =?us-ascii?Q?0J3+92nz6YY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?40z65gLLujEaLlUQosi1guVUTQbMalADdqLNmrXdmrTOWNXIQpKl9qjB6xBm?=
 =?us-ascii?Q?6xGnTH3ywwp57da6CPr1FT2aAK1/zIwxzwJSe1M7n8yML0YmAubO6mcods4I?=
 =?us-ascii?Q?HAWJ4+XkKhP0+zS7BTEMP5gZW1Z4TZ9CXZrSyAJ8blgsbStrw+lLdnXBQkdi?=
 =?us-ascii?Q?S6VaLd3thBHNcAhSeykqi36TWJLJ1Q6QoXfpR8v3BV174sZ8o7vWe8J2HzoV?=
 =?us-ascii?Q?/gHvAMAMVQ9YsnWy00gYXHbg2yzB/XfSczOmoWpruL3ovCgFf3eyLwDZspJa?=
 =?us-ascii?Q?q8xligKzJnQ2NlyWYXp/F2ZsCC/IPDHztbZ3VMNhkvyVvkQRuqq6+0VNpRgD?=
 =?us-ascii?Q?IwRk4xgSC7HvGPLNrlw7xCmFzd+84sy/2q1f1JmCcUmnIgepF+T9YtII47Ke?=
 =?us-ascii?Q?s5b1/32M/5YHAX2YmVejySd4drK1MmpCdAHSVDru3qeb/3gKieigPmi2ZYnt?=
 =?us-ascii?Q?7uMrozmnoR0Mgo6uK3JsE227w9wPAYwH2InIf0Kg5NnCXWQW48rrOU0sTLvW?=
 =?us-ascii?Q?v9wXKC1ynaZz245UY4d74VMRdNJuHBMo9n7FvzI2oweyYFES5q6zUvgVA/9K?=
 =?us-ascii?Q?XlNGu+9S0QKnDqda65VJDv+2/UJ+kITkbMwDZ1rQx31xo8Ag91fmc4tdwx7a?=
 =?us-ascii?Q?AN9d+L85SCK1KVsYCcV6lbYI2YiI+tqRIIsye/w6NiUi4s4rsh+rSRGnC4+9?=
 =?us-ascii?Q?/Ksa4n7Ku8VcRp5XBhT/Xf5zRtjYnJKvs1HEEGEntDhl4COdPaMrfR6JvpXB?=
 =?us-ascii?Q?l/bd1qcjiyP0pfz3Zpui5O21DEYLt6N6ltY5/w3VeH9kZbARDcu3GqU4WGoo?=
 =?us-ascii?Q?jRTm1kSG58WJpeNBGAsWKVe0xsa0S2MmxUSlqGHruknnm8Ltqkh9zzND8orM?=
 =?us-ascii?Q?1VR1AaDRgrJ79fWVbFs7o9phrJe5s+qDCr2zS1u/KgEI50fs/5Xg3ZQCTbFo?=
 =?us-ascii?Q?52iNYgDCvxSALPST+DDcqc7ocmz4lSwsEW80kkid8mhjJ/qQAfKrqPfRpKgh?=
 =?us-ascii?Q?llMgqoXPaRlD7kO+o9EtBAyF/OTOh3coJhx9nLdvQC6tCpx4l3E4EaE5HeZf?=
 =?us-ascii?Q?NGPhWKdFTyxLKfChtOUIaAb8Ws7bFbyr6O+7GTiMXuFJCAegAZ9B+V6EFEJe?=
 =?us-ascii?Q?g7+uxSlTuBpILrz04/V/v1dLLgOIzl+JTA6RneMozrlsTJfrQhd7VLivL965?=
 =?us-ascii?Q?9gactt6M4+0NIGJ4SFYqOM7zSddkTz2CzBGgLJNbJTgEi8SVRjyzXB2EyN5H?=
 =?us-ascii?Q?m6h212qVdNFvmjzKGio4djOuNdoqsjMkmgs3c6RHn6qMBM2bVbNywpxNHgay?=
 =?us-ascii?Q?PqlblCoqhJhlszv4S5p8c7m1Idmb511KvzX4JK36Oz2zIjNmgXRH6Sr6YX4k?=
 =?us-ascii?Q?79OWeP1nulpr1OvI1VzpNHwjzTKbbkBPw2OBzieddCJMUUFsFoTNfClELBh7?=
 =?us-ascii?Q?TuRHmWO8e4+mvh4FhnGmPhS2y3UWbzLi5vepMRtbOgmJnF83Nn4MwXM57TGZ?=
 =?us-ascii?Q?zUdVxmvmTT6DRqG5DLCozokSpzpJIcyBWjQOPEOLQe7hAGcEilrzd2SWQK2m?=
 =?us-ascii?Q?drF1CwmP8fPQB5xdJQI67XeQu+vYlxI+uVTeB0nV?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d85249b0-603f-4e3a-7029-08dd46370b4b
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 22:47:18.5701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iBGADTtLNcummWRZTfNZDTYGNExaNWsK8lUZbKb5NvMqGPfGP8mnvadaPnFK+Na/tsmYsmQ2tJ300RCSQwmVHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7097
X-OriginatorOrg: intel.com

alucerop@ wrote:
> From: Alejandro Lucero <alucerop@amd.com>

[snip]

> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
> index 774e1cb4b1cb..a9ff84143e5d 100644
> --- a/drivers/net/ethernet/sfc/efx_cxl.c
> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> @@ -25,6 +25,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  	struct pci_dev *pci_dev = efx->pci_dev;
>  	DECLARE_BITMAP(expected, CXL_MAX_CAPS);
>  	DECLARE_BITMAP(found, CXL_MAX_CAPS);
> +	resource_size_t max_size;
>  	struct mds_info sfc_mds_info;
>  	struct efx_cxl *cxl;
>  
> @@ -102,6 +103,24 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  		goto err_regs;
>  	}
>  
> +	cxl->cxlrd = cxl_get_hpa_freespace(cxl->cxlmd, 1,
> +					   CXL_DECODER_F_RAM | CXL_DECODER_F_TYPE2,

Won't the addition of CXL_DECODER_F_TYPE2 cause this to fail?  I'm not
seeing CXL_DECODER_F_TYPE2 set on a decoder in any of the patches.  So
won't that make the flags check fail?  Why is CXL_DECODER_F_RAM not
enough?

Ira

[snip]

