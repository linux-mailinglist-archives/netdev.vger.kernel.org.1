Return-Path: <netdev+bounces-192831-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C91C4AC153F
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 22:05:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F32C6A23E02
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 20:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A5C148827;
	Thu, 22 May 2025 20:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aHMz8/48"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87EA6190696;
	Thu, 22 May 2025 20:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747944323; cv=fail; b=fJ4GYnFJBD3bJwc+P/9p+WGCOlfcp1kgokdlfA3WZk2cS9TFl1Y1Kobt3I6CO45pTlkZII84COz3xtndFywYpIHHJVC2K3i0VZV1ajCLvXGC800VyctW0HKxvfcplXDUbFxieHbJMrcCQ82Z5WbAmAOzf2IKLVHQwLz+1yIv/Qs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747944323; c=relaxed/simple;
	bh=djX/ka6rALcIL0OCbQCRSQ7hwmplV/c8uIyilp2ThZU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RFnRzDkrGFYM+KwPwhfTdYp8u4+mKH7t+fE8g4a1/Ii2CEdL+sr2Y692bAlgD9m9du8kx7MHS0+YHu5+CuKHQsEpqtO9McgAY1Jw5mvX9TANnZ5L5uKq5kDNsTG2D/R5DxDRX6N6lSpnBSYZOsf66gbCwRz4GcmNB+MLiXuwXV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aHMz8/48; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747944321; x=1779480321;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=djX/ka6rALcIL0OCbQCRSQ7hwmplV/c8uIyilp2ThZU=;
  b=aHMz8/48fdAvhgRCtHrRJ4pfZG4VFz4OSc6IeBScWeW+OTltXZ2Mthhr
   uYVXvTYotA9VQbxUStCURv0bEAjcWoEMERjtSpXVZYm6Pxb9dmj3CpK7/
   HPvg/QCBJleXAW/UIK9wPORx8kCZ/W1EXvdlVwN66HmJPL3JvJr6ClUgX
   rAvPUY0GwP5qnGctOkfPYjgQHVGK21tCJaqsSsQHpVFq74YQzqlMPjbiz
   naM0VbdOW8PhJLgTWCFikicTp9gF50aDNjHAvcQxkn0NzCijfE3OiDM89
   zzVNz8Ne44pp6q09NK5WEMfUPO9LIEv4aqBTv5PasxEH7eeRRYXnpuep0
   g==;
X-CSE-ConnectionGUID: zwIY4pmCQ9y/or/sgq8eXQ==
X-CSE-MsgGUID: /LcV7RHQR0+51zPUHxmFHA==
X-IronPort-AV: E=McAfee;i="6700,10204,11441"; a="49242984"
X-IronPort-AV: E=Sophos;i="6.15,306,1739865600"; 
   d="scan'208";a="49242984"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 13:05:20 -0700
X-CSE-ConnectionGUID: D4vp/vpwQ3CbbJDlIPAKOg==
X-CSE-MsgGUID: DMYKBRJLQZivlHfWr/iFkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,306,1739865600"; 
   d="scan'208";a="145620133"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 13:05:20 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 22 May 2025 13:05:20 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Thu, 22 May 2025 13:05:20 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (40.107.212.54)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Thu, 22 May 2025 13:05:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BLXkB5B8PZQ33h48Jy9yBaEiVjLTMiMg9LrmgB61aRBDTqf26yMZ7dXbKyLwYPR0xLS1IBxhyMm5v36yKKsiBUCnBjjTJJhQmYzymOPF8XfGeZ+xlb/5I6wPF9iaUPDGJWWBO9ez8pMNVsP8z+mqQF39bHG2gyPWJQj4Fn2ATZl5YZ+lx2AxRVpFXN/eRXZ6M+oGDOJoWLcaU4u0pMR2F/+NNU2OPPJOmZ2xalZlt/BmjFrfCswDR7CDZjcnL4dVrbgm022ozLriMpqLaN68TbuSrpVp/BHCwhAK4AWhORlUM602JHSiz8zue955KW0EbQspkb/WcOIPR9d+KFXtKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aalOKOk9JSVkItK7jJoDrprq4tTLLA/eEs29ArRfrlM=;
 b=lIWj4Gz6XnGvkNPUGrSJgpyci0K/PTO+siBPvhWSli3SUA+0HdACZ2RIH4jpra6DqRdmRj+/dDYuxgp27ecnoGCB/TcZsKmszcCE8fTTdSMPs5N2mmWrZjWIremvpPLvb5AFyuoIQyldcpIbk7biMLrLZrDb/UcKBxdoxHYBGnpXX6L9sMEB0BXoboOh08NbYrjVpiA84qhFX45i3xE/mImrlpmXdcQvEFchxP5K3p9nWkHf0WxfxKzF2d7HQaaa7bwWgKxek8k36KiuHPZySgwHH+NXDlKXxgOcdv5esvyh8vrWRwmcF5TnUOoQqlvvG0ehfduI2P12YOgDBMS5Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB6994.namprd11.prod.outlook.com (2603:10b6:806:2ad::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Thu, 22 May
 2025 20:04:49 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8769.019; Thu, 22 May 2025
 20:04:49 +0000
Date: Thu, 22 May 2025 13:04:47 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Alejandro Lucero Palau <alucerop@amd.com>, Dan Williams
	<dan.j.williams@intel.com>, <alejandro.lucero-palau@amd.com>,
	<linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dave.jiang@intel.com>
CC: Ben Cheatham <benjamin.cheatham@amd.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v16 05/22] cxl: Add function for type2 cxl regs setup
Message-ID: <682f835fba701_3e70100a5@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250514132743.523469-1-alejandro.lucero-palau@amd.com>
 <20250514132743.523469-6-alejandro.lucero-palau@amd.com>
 <682e1b368fc8_1626e100c3@dwillia2-xfh.jf.intel.com.notmuch>
 <d64fad40-20f9-44ff-867a-8caacd70767b@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <d64fad40-20f9-44ff-867a-8caacd70767b@amd.com>
X-ClientProxiedBy: SJ0PR13CA0081.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::26) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB6994:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d2b8364-752d-495e-5f7d-08dd996be865
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?lqmc6E0I/tb+v3R+jAHW56wfHg9HpCMjtFx0LWiG4iUZFoihpDJ7kQ/vsWTx?=
 =?us-ascii?Q?yYe1hD4LdhbM7mG/dYuv3trbDMzPZKffLh5cXYquiid4rl7JWoCodX+fUV4H?=
 =?us-ascii?Q?/rjDSptklFPdsnS5ZRPIEWh2FuqgIu6Sjnn95jS0MPmyAyFljLYZQk/rkRNu?=
 =?us-ascii?Q?9y2YPWkerowIjMVGEzoE+x+K/t59f1RTL3+u8a+2BKPntiFqMi9obiNaHzbA?=
 =?us-ascii?Q?usPSFQevsEMPwD0nZdjeGXbCYidvL0TN18MXxPb4CtJ1teKtAs7R0glqSvWP?=
 =?us-ascii?Q?Ebbud4Dvfwa2CasWFF3rBgEQe0Tv4DU1u4jHI8aWD1b/usn5VqYGkjhslCtx?=
 =?us-ascii?Q?NIHGGj/UXNWtNvO9uaI5OXcTjRHjgBk+JRny0xz+8xycWWLpNYzNY5q/94Nh?=
 =?us-ascii?Q?uN//Y7yPlVR9xdT0FQOeSYrLkHrNneNoR5nprD1ptAVNclhjqljXs4ssfhry?=
 =?us-ascii?Q?DJ3i0MhMJkMJm1Q3Q3CAVWJSPPbu24jEeLN3hBzU02yfkQ1FOJU9oX3Eu8A2?=
 =?us-ascii?Q?7wG6bd5swCP8EA2X6Y7CPR1e8peeh8tfnIMMIdCnlrw2P76QwnT8/4C99miZ?=
 =?us-ascii?Q?R9I7Tmi+Wa911Qb77TjXovX9CYkgaYf/tTnfgCliDTUaGA5wBRMTvzauKj6j?=
 =?us-ascii?Q?kANVEIUON/SpHrzzvAa6A/1dByh4d+cGJH69n+WSw6PEHkwk1Lu0eEP++Gvj?=
 =?us-ascii?Q?juxvASAjw/xHwennMZoEg1hzxITiAC+IHSmgfBB+5m4dGlpgy1GqLK3Kl9LY?=
 =?us-ascii?Q?mJiGXCeiaE8FyCU7LFlK4IOea4h50+GvYcPZ5y044Ou8CK52axwxxXWgjCwu?=
 =?us-ascii?Q?A9Av67DW9xvpkouhtMkwcJhUVNp47yvB1Fz9cvqNH8w8ZJ2YvsIHn9jB7F6Y?=
 =?us-ascii?Q?uNPZUY6YFRZ/IcKJRN/GH2iuIDRvyB6LeK+7fotHKyX0v6Ov4u93qId7aYc3?=
 =?us-ascii?Q?R3vDFiyu8JKl5EApOUbz1UR/lIogZ5jg96lb7F20GJ6Uo6Tm3Ju/UzTnK2oU?=
 =?us-ascii?Q?zW+1R7tfBoXEI4nE8ZnWlG+FusgHHPTgS6yBRq4lBQv1FYf0FbuyspoWFuCo?=
 =?us-ascii?Q?zHCXrvjn+QTByLuhtKvG9nKY9CeL5ZfN8rJbRQiKdMAMyrMJcVJmkwlAiSdc?=
 =?us-ascii?Q?85ALzBifQecvxz3ExKvzPvUEfK0qfQVl3m5dWTDGyFb0j2eN9hXi14Ian8JC?=
 =?us-ascii?Q?cfMuIZTjffpk0nvVkHAXByl6k79thJ/1w7Ro2jVhOgM3GfjCwRaF8tP5aW/E?=
 =?us-ascii?Q?9/r/tLSvvCZL7316tuSfZfQS3HJRA+wfSx9JG1pi+x5IIuJqAX4nwEWdD66b?=
 =?us-ascii?Q?fZslqsj68RzcRXOYTOCWAq8k2GC3jvpueiwVzuL+BqWxHo9OUIp1aW7BrKGj?=
 =?us-ascii?Q?7EMFbkL6ob6rweQ3LnaRAcMH1JWYhIxS5mBiVzxg+81zR2TOTQvst9Tz1ilP?=
 =?us-ascii?Q?MsPy6ke9PFUPjvIC5sgQys+lhMkg25eNuV2lzYBSZcRlwLgtVWe0kg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fFhZRcEeWYQ8o9h/adpsb4Gg2PkcKz565gdJjYbTNzS0VnMCDiukF+inHYva?=
 =?us-ascii?Q?xZWdK/czmYC51xxnhaCvLBsa/QFlfFnklSKOgfbRfF7l/IC7ucWpiASoL/RO?=
 =?us-ascii?Q?UJx7RcNoKnv3pBQ4HQUyi7GQbNOmKjwPaF7ScVyOc6hM34en2kANVcwXmEO/?=
 =?us-ascii?Q?D7ZXF8Oi15Va3mfSYM0R08YAJqdiRlrlWQZNqQLDDcaMyZqxGh+uf20Gk3kA?=
 =?us-ascii?Q?VHR0USEf3CXVTH69G/P1ZxEhmoLVEZrW6f1nSFiyaHuN60ivOGCRjCFxcIiy?=
 =?us-ascii?Q?KWSC7bxOPxYv5AmviXW3UpiLnZuliLoYKgNiwaXPIAOSADdL99xwnzZw/kiv?=
 =?us-ascii?Q?U9O3Xd4OgZKjUEJsFtt/PZNb8gcBP+W+50RMe7YJn8mue8+Jj22Slwtq1wt5?=
 =?us-ascii?Q?74ebKuAXbB/V1d+lqnZPsP+7ndUIQ0DcvecF3JB1EAfPRDWo1jufLO8sGcTc?=
 =?us-ascii?Q?EAYnymgudsKbPgYydSDpHXtWey9uleAr4AFoLikEtlRECqKSnkhBGNv263Q6?=
 =?us-ascii?Q?na06ecwXw75NJUMp/x2KQHy0W6EQqOjkCJ7hTnaHX5bN6UA1on2HYnaLPNSo?=
 =?us-ascii?Q?+qAV3fYRR3kU9SeWaXISKHpmrLkS5995nAbfZx8uZ2/tWbw3LnvYbHg/r8FK?=
 =?us-ascii?Q?GXTNfc8T0RKf2VkwF+K+YVO/68gvT8tRFWudo6d+BZeVUWBVAlt88Dgx4i3P?=
 =?us-ascii?Q?fULcmbnmc67XTEoeWAhF7ECicx3T++LK5xlWvxjp9jgiHHuU0owCSJxtZ1Ex?=
 =?us-ascii?Q?xSDdE0PlxbWGoAKP5u4D7A5qtFQDQO2qgg7Z0DLPYqGhpCUe9Glg3+8RNV81?=
 =?us-ascii?Q?2HKLsxTdmjEEbXDMp5hGSOL9dU2b6gvgqdFpqxb/ksm53/gbvhLbYGUxw/29?=
 =?us-ascii?Q?KqmbcGgDC3ycx8GgR06TDYIwyKsvtG1EryCRbFG6XN4XmrM7gHeb/AyKT3zP?=
 =?us-ascii?Q?1tnjPoSU9MLnxPFS65kc/j02RRfuQxV4o2ZFXZWoHyEXMCA6MbxI3yfaBk3D?=
 =?us-ascii?Q?RyGaBaK9817Js2OgloFJRqSZ+BLN+KA9tnAQMSamE1WAFRRa22Rp8OHnIceC?=
 =?us-ascii?Q?5bAfYurJtykhjntZi7n3LNncd6xroHnojZUjhcroP4VpQfBoeIF2I0OmzMZo?=
 =?us-ascii?Q?dAmqR+SudXcyXs0G2gXeFfTW1oczmak2JfXF17zgc36ONUh6/FjVGkDF3MVC?=
 =?us-ascii?Q?winQTr32OrJTsSM0RNI2y+863y/ajbKF/ysEVIvtCbhgaYQTiL1C47aCs+jp?=
 =?us-ascii?Q?ji7V3C/WtANB9kLS9otkoOTNF4qM/Jgjsj1UFN42I2P/z/VJxBPcnyHabWWJ?=
 =?us-ascii?Q?QxbdoDk3hmb3X+Mg2z+nmZ9z2NTIiQ4gHfdb/7KHrEMDmaQw8XGjuKer35Rh?=
 =?us-ascii?Q?AeUWmuAaIoVpIzg0AHoZOtUHkpiqUB7iAo3NNwOsMXNEeq9vNbjdci5dpP5o?=
 =?us-ascii?Q?zigfmeKX7SHIaRz1tBC/NlUIVzaUtUOuhWdWchj6+00RraZSP8goiW7x3Qmf?=
 =?us-ascii?Q?kXgv81z/fH1Vw2woZaX/upcoDAfgomPvbxYptBZhzTUez8qrbeJ9vwBDffpy?=
 =?us-ascii?Q?EQUT/U2gHiPZEbbuhVRaMBiB3xU11a5MZnIAXPU+8b0BPh71nI69lf6h/t5A?=
 =?us-ascii?Q?ew=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d2b8364-752d-495e-5f7d-08dd996be865
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2025 20:04:49.7651
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tJhJMSeScE09ldHUySMn+lRBOUc+aqnKjJ/nNfr731LPmG4OYhFwGO7ln3MIXEb+zjbNYaYmK2+GiAuddusg6g9f/1eIl1OwnDMhAObY4cU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6994
X-OriginatorOrg: intel.com

Alejandro Lucero Palau wrote:
[..]
> > The driver should know in advance if calling:
> >
> >      cxl_pci_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map);
> >
> > ...will fail. Put that logic where it belongs in the probe function of
> > the type-2 driver directly. This helper is not helping, it is just
> > obfuscating.
> 
> 
> As I said in the previous email, I disagree. The CXL API should be 
> handling all this. A client only cares about certain things, let's say 
> manageable things like capabilities, without going deep into CXL specs 
> about how all that needs to be implemented. This patch introduces a 
> function embedding different calls for those innerworkings which should 
> only be handled by the CXL core.

No. Please keep this policy out of the core. Do not invent a new
"capabilities" contract that the CXL core needs to maintain, and do not
add thin "cxl_pci_accel_" helpers that just wrap existing core
functionality. Call existing core functions directly and only augment
them at the point where fundamental assumptions are violated between
the "Type-3" and "Type-2" device models.

If the fundamental assumption violation boils down to a policy
difference between Type-2 and Type-3 then move that policy out of the
core. For example, register discovery is a mechanism, what the client
does with the result of that mechanism is policy and belongs in the
leaf/client. It was an accident of implementation that mandatory Type-3
register blocks were validated in the core not in cxl_pci from the
outset.

