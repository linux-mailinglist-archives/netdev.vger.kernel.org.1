Return-Path: <netdev+bounces-194629-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB373ACB938
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 18:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FBCA1752F8
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 16:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F55C222582;
	Mon,  2 Jun 2025 16:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hatzy/pH"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72FA4221F3E;
	Mon,  2 Jun 2025 16:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748880199; cv=fail; b=AVmDyVgL5pOJZPvTxhKne7XnlVK8vShhzRhA7lf9swhFbJZG3Oq7G1xcmP+51GqC3JItn9CYJSNUtCNZgCuNXVzk/ee31V7P/Q5737wY3Fo0bJJTbN0ngIRyJ/J+xz9yHVRmAkUYkJy+slgmj43jfHFZ96zjFwVK4RHhlN6/lfo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748880199; c=relaxed/simple;
	bh=sMIZqCIg+nLJ3NEdo22MGCsRxnr8BW9u3xy1/MGERXA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DuAfP7BYUwAHpEHrpTzos30+bFwKzVGgvOjrv3FkC/5nTB1jNaUKfJ3EXwvzxs84LO9LuiwNXuUxdFpHyCsgN3VVIYXAqXAm2y5x1EZwme1eHtLj2d43u43mmY4ZN7b7JVDxN7nsI6IW19YQJQMEvIYyFWs6K+JQcSD+jrgmMC4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hatzy/pH; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748880197; x=1780416197;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=sMIZqCIg+nLJ3NEdo22MGCsRxnr8BW9u3xy1/MGERXA=;
  b=Hatzy/pHqjZSm69NpeYyanO0BHWtGFoCHiUfWGjkb1hpsD0Y5Y7dU5ey
   zLYt4sgl51lTN7N3LtWW7JkkNuKloKnhwyCdDduDNJ0XBEiGGHwuzxpgH
   14vTSsZ5R/EjzQkU1UAfOwdihYd575Y1DGYwPYFlCQtEb+sraoCowE3gM
   ZcdHYOiyp2Sgv2xdz80d1wXDECHsw1FihclIVo+C1p7HHQy89C09Op6YF
   04b63X9K2++C2goivm1M4m7pbasJ09OBA1Q4tqKz/73oYaW2kyVd1M9U5
   Hh9Jk/ekaMemA7DDDz3f96Oq7G3qM3GApMnEYyEVmR9UKCqcEqdpKvAAQ
   g==;
X-CSE-ConnectionGUID: x3iHxO7AS1KfjfojR0dLJg==
X-CSE-MsgGUID: DYuSiGwyQUmPV/AH4iF+aw==
X-IronPort-AV: E=McAfee;i="6700,10204,11451"; a="53521124"
X-IronPort-AV: E=Sophos;i="6.16,203,1744095600"; 
   d="scan'208";a="53521124"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2025 09:03:16 -0700
X-CSE-ConnectionGUID: yWvBfX5MRROwIMCbaxqbNQ==
X-CSE-MsgGUID: BCV7UmYCTiCCcCWC6vx7Ew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,203,1744095600"; 
   d="scan'208";a="144613607"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2025 09:03:16 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 2 Jun 2025 09:03:15 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 2 Jun 2025 09:03:15 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (40.107.223.75)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Mon, 2 Jun 2025 09:03:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HCvWz61oHn3ciC7qs1EQdfuBW1Zr47YN88msLWYbdNk+aEj5qeADEwFjCMDZ04EtMVtH1vAZkcaZwGhLR0z0VQ6pGwCLBxVCrh17trIXek4sPzSp8Xkbh4KzDUDoaCuO4lNVQil30GtT/hTbbJqnhHu4anRojKkQ88t9W9UgKnsXHhGR7c46fG1Alzhd5HCplAXMfYLgm0XXPwmgCjDWaMxg7fUUqsjW437ZN8LRlTCuIoj+QTiuBAafGdFlCGY9CXWLoDH3N+agasxEDMGjyPuqcQ61L9jer9ntVrrqGkfTD9GzXkUlzC6Cfjs1DLm3EWGg3zXtU8G8xmsUiS3/Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HQHf/8+b/NrYYWL4ZpBPCytXUkFYt9GJjRZlP7v3D5k=;
 b=yXw/q2C0fltWGnQ1DADm81XV3ajHaHGNW3Hm12T1/F57axSV12RAaNM2RIabpUYKCuryW6nGXSyYaRlrdeFnfwNwSknR0kmaCKfmoN7qCyScin8wG6G5BzaBTngWQwuh1ere77wHJV8KpyG89zolirJxdGU3DsPxrQ9NGOoqheIHirYAFkskzwgHABBEZRpFZslUTq77m04CN7XZUlgUIEgRHBok44MckdHzW7V3iDF37xSmGwDJv5L6RLNDCucmQghjAg+Peogq/1F24vOQNTRvbE1FBZeYsymBwhO+iRVBUWFxTam5I254uvS1xd6+4p0IDfsB82xxWITbx/0EYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 LV8PR11MB8678.namprd11.prod.outlook.com (2603:10b6:408:20b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.36; Mon, 2 Jun
 2025 16:03:07 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::d19:56fe:5841:77ca%4]) with mapi id 15.20.8769.022; Mon, 2 Jun 2025
 16:03:07 +0000
Date: Mon, 2 Jun 2025 18:03:01 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Stanislav Fomichev <stfomichev@gmail.com>
CC: Eryk Kubanski <e.kubanski@partner.samsung.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "bjorn@kernel.org" <bjorn@kernel.org>,
	"magnus.karlsson@intel.com" <magnus.karlsson@intel.com>,
	"jonathan.lemon@gmail.com" <jonathan.lemon@gmail.com>
Subject: Re: Re: [PATCH bpf v2] xsk: Fix out of order segment free in
 __xsk_generic_xmit()
Message-ID: <aD3LNcG0qHHwPbiw@boxer>
References: <aDnX3FVPZ3AIZDGg@mini-arch>
 <20250530103456.53564-1-e.kubanski@partner.samsung.com>
 <CGME20250530103506eucas1p1e4091678f4157b928ddfa6f6534a0009@eucms1p1>
 <20250602092754eucms1p1b99e467d1483531491c5b43b23495e14@eucms1p1>
 <aD3DM4elo_Xt82LE@mini-arch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aD3DM4elo_Xt82LE@mini-arch>
X-ClientProxiedBy: DB8P191CA0011.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:130::21) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|LV8PR11MB8678:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a18eb0e-fe29-489b-6046-08dda1eef691
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xahQI29d4Yb8oO9/C9PaZkN4NspkJsLy3e+EYtAEpeutzJt6r4Ulm15blkMs?=
 =?us-ascii?Q?rkXlZsL3XaMVaUSpM47YyTwszrmF7dOzBh3JDWoCJScHPgcjP3r8U9L4OKUA?=
 =?us-ascii?Q?rzXrs2nS7nedFBC8C3kd71jp9DUSecY7c0VbMMg49KriBC0xb1NRd8aQb5Y+?=
 =?us-ascii?Q?hUzdiaQo6sXXJ/od8sWYAh2zU5dlDCBM+0qlidVPw0ZD800ftlmXQ4GwAyMf?=
 =?us-ascii?Q?r5JgIrjZzGaOtrecTDk7OYXNrYtXympMKqRzdRvVXF86mnZ1CEDc6K+YDGpN?=
 =?us-ascii?Q?9aNVgEAqCwSsbylJ3j5IJ92cm5wqASMDSgnHc+by2/bT5N5PW/CO7z1RYx+M?=
 =?us-ascii?Q?MfGfOIaI6Ljx7b/XH6SljH9b6LFfZCPWPHpknyrh2sG1KJpqsYB8GNJ7P13y?=
 =?us-ascii?Q?Fx3smnQAYD2BtMFnyKx/orzgJdrv1MT4RdntGTWAbVyhT7ZgmX//rLihIVor?=
 =?us-ascii?Q?NF0NNqJSucKZ40xiwHNkcHSJE7V9xUx5Qrf+MrE/6SSASVFunXpcmOsFzvuL?=
 =?us-ascii?Q?CqKzDm3sA4LsGFKRhK1h9KNdhsiZfRjEjeY7IvfBUZJe2U2YgkdnEoC4E74j?=
 =?us-ascii?Q?PXlmkISRrOoit9mrvIyd/VPL1EDe86bVYNDl3DmYFA1msFnD38vG2RR8f6dx?=
 =?us-ascii?Q?T/MbEtN6VsvN1/cOMLNbKAXeam79nNhXZyaOpCpos34rDDyNZD/R1nX1uXTQ?=
 =?us-ascii?Q?r6oQc2DgoBpPp2ZDo5Q93TZvxjdoqEDReFQj24i6MSuAju7UGNquaBkC+jLC?=
 =?us-ascii?Q?5R9L9Zct/gj9G9EIRKmiJmTS7gvEmoBW6TqE4cobEF4FoHYavUk5jZVPKld4?=
 =?us-ascii?Q?Hj1EBFf7f6Z6lgIcoOarytvUtHAsUm6duhPnJTCrWIrW9Oyke6utk4MNqQCz?=
 =?us-ascii?Q?Bqtirl/BDDaX9ie8AQwMFGc55EvbTWIS6PXC53sxej1s1Z9SsER16gMBTPAm?=
 =?us-ascii?Q?wbIXSp3mr2eRNWlvqXGSn6/HMMsn1+Tdj3MKVQilTUKRUWwN1wo4LmWo+N8K?=
 =?us-ascii?Q?wyakAwL/qKD7izdi6thW84rG9NS+zDryUjEUQUFJPhAs7Hp70/h1dd4fy6eb?=
 =?us-ascii?Q?LQg4nYeoSv8K/9jRat/KipP6brzoFHRfZaloQfpW1C2Ts50YPBG79lBEHq5x?=
 =?us-ascii?Q?AB0J1JMv6J3rnNWEUqA/ZCqHD4zxGJGj+otBJMLtgVE/NOcGTdCUFJoHUvBU?=
 =?us-ascii?Q?ySeqjf/wGeyd7FzTBaMBvauVDhf33eW+QyqW8OLLUUHCXtfNmLQrpVEavfGh?=
 =?us-ascii?Q?H8FZ0txa3PJ1qyonVeWCLS2OIbTh1RC9HJts217bD1bTSVpLGAR+wkirv/Np?=
 =?us-ascii?Q?ua8HAbA4HnbID4iThvBevQdUBPBxW6V1vWAus0+p4rHrIW2T8bDsoQRi4ghy?=
 =?us-ascii?Q?i6IRz8EL6HudK5IKwFb/Xyj9MXT/YSwzc5d5nYhCe7yzj40a9Ce3LToap13U?=
 =?us-ascii?Q?ifv6bB563mk=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CFNXnNRMO2TUqE6IEtHzlPCKaigDt4SZ6R8w44Bk6hVVEAWtGbMi1iG0CVF5?=
 =?us-ascii?Q?W9JM/Ug9YQU3cfi4lt5MEJQbi+GQeDZadYB/mbb6mU9hwCMXV/AVAfgC7J9h?=
 =?us-ascii?Q?hf3DIHSXlHYRaqaNzAtxnJaWkNcceVnE1RQWW/XQRhzIq8DFbWAZESLi9l9D?=
 =?us-ascii?Q?CuRJLdY1H4C2wyM4ymcB7IhdSPxpl/VhG7nz6/nk5ouBQzTi0YkL+xtOmxkp?=
 =?us-ascii?Q?+psh09uP+Cxbq+s7hMUOwpn+J3mh3dt5c00qc60V+lTQzAme4Glr6TUJW+K2?=
 =?us-ascii?Q?3I6O6K94tdSzp3kAMSSDKmTaTjJZncqpAAv+i0xyvuE/Mcg5dfZkrI6bQe/y?=
 =?us-ascii?Q?TYUP3Hat8LqLmPlbvdTmLoR6DDqGQ0n7Z5nN5a6Sr/hbIIGHjMbveWIwkkQP?=
 =?us-ascii?Q?hrtkt2CN4V7hpUIbMhMAYHMgGTCSs0snhDC5bCosPOj1jf3UexcqNWiDDpOQ?=
 =?us-ascii?Q?wl+W4lI9RVPMBuYyHMFzbHa2YXkxYGGv2vsQQQZsN6RyMnrYecFEPsDQlf5P?=
 =?us-ascii?Q?+GAjI1vCbOdzjLpfYp7OSV/VKc3Oyn0G3qM0IDEnB4845ukkT1irgz3BaTHQ?=
 =?us-ascii?Q?BB3oDKESmvxko72nz8h6y7c2kUT3Barhr9XxeQw5nHrCzFUUbEWIWI53h3nj?=
 =?us-ascii?Q?y5KGFyBXt6t7JsR6qIiCZe5lQQNIlcKgYARXFWf/iQd/EcgEyRQyW8K6f1Fa?=
 =?us-ascii?Q?Y3voqA3CfIQIGufUPqwlu6PsI8knxs7M4tlP5vimMlS9oqRNB6mCP5TqgqfF?=
 =?us-ascii?Q?DQD0t30WmjA4P1Bf1otvK9GOf3j0/GiSm250Sfd04p0t67nhptcNSdHA7ycF?=
 =?us-ascii?Q?XoJZxTQP4zU/LaDg6+KpWb4WzqKwQpBzGNQCVGwVJQD5CGI0jtdNJjDV5yx8?=
 =?us-ascii?Q?hFAxHR6MKi9ZlDafA3JEdlDu+uhPZm5jduJF8IgnUPuLC/JmS9S6mVusZsVV?=
 =?us-ascii?Q?YtleJxqI4zUMIrwutiOYs+LV4cLum9r/i4Amjb04idrIrzX1ssjkzFaM3ley?=
 =?us-ascii?Q?HqYiRhHpJkX0F9B9IA1vlexF4Xs9vh7QBUFlgp1pciohziK8EKby9bnv5lLo?=
 =?us-ascii?Q?jmSlp2VkMVi63aL25xAczjjQ/04tui0Br8JRFXBxtqS10O1wSUVR0ejusAJR?=
 =?us-ascii?Q?ZQ/LUsPlL/gr2u2K9In8mplWJt+IIbJjpWIzugWu5QkjsuimXPksS8j88K2C?=
 =?us-ascii?Q?hffEzLW1To+c/tkP+abKbJDfhB05w4y1qGyMJoNhhFgftP6Qbi6isGAoeqLH?=
 =?us-ascii?Q?9rtvm9xLp2b96YSgEQbc4x5VgXkA4GekU/pm7ltYyGvChC+Uj17PR17hXlmk?=
 =?us-ascii?Q?RIP6N1mAUGm41VUAdNIwIYVbh0hPb1/GPqwiq/XqC3ztgTUYPytmOvzhpSLQ?=
 =?us-ascii?Q?M7ns/nWHSOOduHFn+wn71mIX1h7zV66WYezOnrEoc8zeJUgSd4FWhi9EI6xl?=
 =?us-ascii?Q?6JacnOM5/qNJ05H3riRQkuWKQRgDRzzWI/Zw8/fgV3adtua2zCnALa+wNyXe?=
 =?us-ascii?Q?PWn86ZrJZdXb+mDQytGwLSWScEOXUBf1hMbzBcwB58pnKOCvtgu9JEJG6s3E?=
 =?us-ascii?Q?KNgzFa7MuF5rHu0XixeI4o48n+l0LFsjZaniAI45IfEzJxfFQkqw3V/9OuH9?=
 =?us-ascii?Q?ww=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a18eb0e-fe29-489b-6046-08dda1eef691
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2025 16:03:06.9337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Go2GeMdP1bkeicCjkwaXBeVogbtHp7Vjn15y4SMnvOR978DJZTMIp0kp7EpmWMYd+xgTIz84gn5iWUDC2PW6GrLdKSaS7qWT5MY3WhWov5M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8678
X-OriginatorOrg: intel.com

On Mon, Jun 02, 2025 at 08:28:51AM -0700, Stanislav Fomichev wrote:
> On 06/02, Eryk Kubanski wrote:
> > > I'm not sure I understand what's the issue here. If you're using the
> > > same XSK from different CPUs, you should take care of the ordering
> > > yourself on the userspace side?
> > 
> > It's not a problem with user-space Completion Queue READER side.
> > Im talking exclusively about kernel-space Completion Queue WRITE side.
> > 
> > This problem can occur when multiple sockets are bound to the same
> > umem, device, queue id. In this situation Completion Queue is shared.
> > This means it can be accessed by multiple threads on kernel-side.
> > Any use is indeed protected by spinlock, however any write sequence
> > (Acquire write slot as writer, write to slot, submit write slot to reader)
> > isn't atomic in any way and it's possible to submit not-yet-sent packet
> > descriptors back to user-space as TX completed.
> > 
> > Up untill now, all write-back operations had two phases, each phase
> > locks the spinlock and unlocks it:
> > 1) Acquire slot + Write descriptor (increase cached-writer by N + write values)
> > 2) Submit slot to the reader (increase writer by N)
> > 
> > Slot submission was solely based on the timing. Let's consider situation,
> > where two different threads issue a syscall for two different AF_XDP sockets
> > that are bound to the same umem, dev, queue-id.
> > 
> > AF_XDP setup:
> >                                                             
> >                              kernel-space                   
> >                                                             
> >            Write   Read                                     
> >             +--+   +--+                                     
> >             |  |   |  |                                     
> >             |  |   |  |                                     
> >             |  |   |  |                                     
> >  Completion |  |   |  | Fill                                
> >  Queue      |  |   |  | Queue                               
> >             |  |   |  |                                     
> >             |  |   |  |                                     
> >             |  |   |  |                                     
> >             |  |   |  |                                     
> >             +--+   +--+                                     
> >             Read   Write                                    
> >                              user-space                     
> >                                                             
> >                                                             
> >    +--------+         +--------+                            
> >    | AF_XDP |         | AF_XDP |                            
> >    +--------+         +--------+                            
> >                                                             
> >                                                             
> >                                                             
> >                                                             
> > 
> > Possible out-of-order scenario:
> >                                                                                                                                        
> >                                                                                                                                        
> >                               writer         cached_writer1                      cached_writer2                                        
> >                                  |                 |                                   |                                               
> >                                  |                 |                                   |                                               
> >                                  |                 |                                   |                                               
> >                                  |                 |                                   |                                               
> >                   +--------------|--------|--------|--------|--------|--------|--------|----------------------------------------------+
> >                   |              |        |        |        |        |        |        |                                              |
> >  Completion Queue |              |        |        |        |        |        |        |                                              |
> >                   |              |        |        |        |        |        |        |                                              |
> >                   +--------------|--------|--------|--------|--------|--------|--------|----------------------------------------------+
> >                                  |                 |                                   |                                               
> >                                  |                 |                                   |                                               
> >                                  |-----------------|                                   |                                               
> >                                   A) T1 syscall    |                                   |                                               
> >                                   writes 2         |                                   |                                               
> >                                   descriptors      |-----------------------------------|                                               
> >                                                     B) T2 syscall writes 4 descriptors                                                 
> >                                                                                                                                        
> >                                                                                                                                        
> >                                                                                                                                        
> >                                                                                                                                        
> >                  Notes:                                                                                                                
> >                  1) T1 and T2 AF_XDP sockets are two different sockets,                                                                
> >                     __xsk_generic_xmit will obtain two different mutexes.                                                              
> >                  2) T1 and T2 can be executed simultaneously, there is no                                                              
> >                     critical section whatsoever between them.                                                                          
> 
> XSK represents a single queue and each queue is single producer single
> consumer. The fact that you can dup a socket and call sendmsg from
> different threads/processes does not lift that restriction. I think
> if you add synchronization on the userspace (lock(); sendmsg();
> unlock();), that should help, right?

Eryk, can you tell us a bit more about HW you're using? The problem you
described simply can not happen for HW with in-order completions. You
can't complete descriptor from slot 5 without going through completion of
slot 3. So our assumption is you're using HW with out-of-order
completions, correct?

If that is the case then we have to think about possible solutions which
probably won't be straight-forward. As Stan said current fix is a no-go.

