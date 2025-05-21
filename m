Return-Path: <netdev+bounces-192426-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C6DABFD99
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 21:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51FF11BA4937
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 19:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE95223536B;
	Wed, 21 May 2025 19:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NAW6/N8m"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9F2322E;
	Wed, 21 May 2025 19:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747857424; cv=fail; b=axT9itRY6dxBi8hJ1BMtL2rXTntG1QzaYFLr/Zsx6sPvs1yfWSQaXYz9ndz6A7d1ynOI3Zhzhm8b+YH+shdJu01o3tOJV+h+A4bcalNy9/LnI9uMtebTiWL26+YtKwk7QYGjbOxEeRxaKMtj1pHDzGtQ7dyAHu0afCN0+iQchI4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747857424; c=relaxed/simple;
	bh=xFC4IG0nnxpLXkNoSOkKSYZNkPCg59GLnsiPKIb4HFY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LlBsuwq0VFY82YbNaSp1j9GKq4MzuTKvURPf0QJtzuDIB79R1CQaDLuAJ7gdOwS9Q+GXbJ7aNZofmgeVJQSNHfeS3LWf5EoBMKi0dpeRkhXAipJr11oOUWtINJ8yCK6gANf3Cz9X7R+8skJCnavd1SiQHNFFKW6eNCDEwpG5GKQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NAW6/N8m; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747857423; x=1779393423;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=xFC4IG0nnxpLXkNoSOkKSYZNkPCg59GLnsiPKIb4HFY=;
  b=NAW6/N8mq8DaDEIOPs/r87nzu0en+AezcKeb3azRV23YQHhzD/u+Rhc5
   NjtwVHPWhH73X0DZoI262sBHq3RGlzsvgSq4lBdlZpb0M8Ytwoya6/HcI
   jmvdnRcV78hwtzOKAXqLHWCGLB1C/7/nnmlkfJze9CPNC/ZNZmFmR+vko
   QiYRMHz0KyMKyxiE7wj72vnK2M4VubnZ+TIuQ25CNse7XH7dX7xSUFZHV
   SlJQIhuMp2NfxDDMswK+bwfp/VqNFs4rY6s/kqH1103ARrTCsdU5xVEmR
   tzFMA9BtBjxTeurkpDl+WsBESQnydLxMh/YPaNqSPYcsAqlht4LMecnqb
   g==;
X-CSE-ConnectionGUID: dIX3nfasQUGjBIhnsPXY4g==
X-CSE-MsgGUID: OvBhNwA8QD+3eLFoL1MQ9w==
X-IronPort-AV: E=McAfee;i="6700,10204,11440"; a="60903865"
X-IronPort-AV: E=Sophos;i="6.15,304,1739865600"; 
   d="scan'208";a="60903865"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 12:57:00 -0700
X-CSE-ConnectionGUID: Lijts6QgRZSzZHDwx4XGAg==
X-CSE-MsgGUID: quzveK54QbmayzUt+7BcBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,304,1739865600"; 
   d="scan'208";a="144956534"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 12:56:57 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 21 May 2025 12:56:56 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 21 May 2025 12:56:56 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Wed, 21 May 2025 12:56:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AXENEGLnCzgzvAk3aIia8ZLlUNMzIe7QvOThYLSztgGvvh+rQDmTredARqezKKdFgEUJAfUyZfT8gRzQAOnCm62uHudOZlFpM//4MfleH7xlmncWkSu9s2+8nfhxbpWqGTLUrFYXev4eGyern5LoWXpNVE+APg9l58NWE2WaJpBr4usgS+stPVMS26Mlx/b9S6haaVAAWSy/RGgK60FK1vMfUzMow9NZqzAZmrxMQ9xjYIPwIZtFT7S9H7Qm1dKzhRlA7wpC94wfeAJc9Mm9UW6sdUi3dgyByRiIbga80iWSGFbryvjtf4ddCZ9HbCJ+epB9kllhmka4B4clQjKhAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OhusqDEfx4obc2G8kVMNbHAdKFs0FYjw3VsuW7UhQ+s=;
 b=TLwlgUE4cYbqAady/6SxD4GGa97eBhezhdpXXAZ6PIogz3UFwSXBQTBxQpDjnqN5MzEvaiVZzbwry/fIwnG/T5fieqo5gTs5cImXmTy8jpi4G0lsahijMLMFz6R5FV5NxnRw+EZJ8QnzXuRBwVrZwMQbKumH+dDeUWku1ioadHOTWE/A/JtqJbCoKu7Qq8m9127mqXV8tile5auny8PAZmx52tKBlv0hWDEc1XmANs+/TEvhJv2zrZ6c+HD8G/ihKBEfiKOCh7npcp2ZSzYBmc5DwwBDujT7MfQXd7Ae+BNzP7lrDX69NufiKx/uSqBmow/5vya5hq9EN1w0WUI3eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CYYPR11MB8432.namprd11.prod.outlook.com (2603:10b6:930:be::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Wed, 21 May
 2025 19:56:54 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8746.030; Wed, 21 May 2025
 19:56:54 +0000
Date: Wed, 21 May 2025 12:56:51 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: <alejandro.lucero-palau@amd.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dan.j.williams@intel.com>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Martin Habets
	<habetsm.xilinx@gmail.com>, Edward Cree <ecree.xilinx@gmail.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v16 12/22] sfc: obtain root decoder with enough HPA free
 space
Message-ID: <682e300371a0_1626e1003@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250514132743.523469-1-alejandro.lucero-palau@amd.com>
 <20250514132743.523469-13-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250514132743.523469-13-alejandro.lucero-palau@amd.com>
X-ClientProxiedBy: BY3PR03CA0014.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::19) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CYYPR11MB8432:EE_
X-MS-Office365-Filtering-Correlation-Id: e3aba6d5-dd63-468a-c821-08dd98a1a276
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fAdp5IwIAYfdAkIw+v0qNVIp3yIGM7YbrdvSEsR1ke1Ad94fSvFLc7bWat75?=
 =?us-ascii?Q?YjZd5nQahef+kqwdgg+m1fhW442PXEbsMzjR6MZcvpXg6fR08BqBDdaXVea3?=
 =?us-ascii?Q?KDqbdvG7yl3EHa6DyREQKTU2P0bIPWxpp1xZwZBXhT2iGAsu3/9/pRtQpZ5/?=
 =?us-ascii?Q?TbrFndgt2kVkj0jKkQflqA+KJVJEooT341bpMb1ilF685N+4O6XyeDkFJqYq?=
 =?us-ascii?Q?LHzvTa3HDgiJnUgUBXZoXJ7uODsgvpvDYRhQFcUBrtKpZD2PMyQ4qWjtrtNG?=
 =?us-ascii?Q?hA+vvQYwpfZWbf3gTGlEcWhh8Iv8/M+rLEldUEQx6FC22gWDUeZefHjtMYzV?=
 =?us-ascii?Q?p+yFpurvPLUbJHh7lejQk8eNpLjSWq1ctQUPnEx0j/CbyGEh3GAa+2IYVfeR?=
 =?us-ascii?Q?nOfUiCQy72F8MPc7aN9AnOirPgmzE0z5LzPPD75qqlEeapRGPn7vuugU2thN?=
 =?us-ascii?Q?X7wqfOeFdQkVB/vAEBmabLc20mHwRFjwnwc3yrPOWCtwhflm8dR0ncw8A8iA?=
 =?us-ascii?Q?44GLAuEjX97aJHvpAKZ6LRrR5ykxpq6sR6sDgQdk/vJxAFJst0fSPq3ksfsM?=
 =?us-ascii?Q?sXKjxCDD1vwH10mjkfA43Xzo0gEV6tyxRUTzvfoVmae/YByNUlua1eSSHWP1?=
 =?us-ascii?Q?W1XwF4tubpvKDvRDGtznq5zHSQcTrn25aFDuxODUVSR91m9T+MuW9DeHLxzU?=
 =?us-ascii?Q?ExuhX3mN5hM53mqe9I77yOlCMJO8lkjCNgOkdJmw/eLCBl+KXOONWRzo5ZhA?=
 =?us-ascii?Q?IhU21Joy6T48Fgd01QZpqX2tB1JM/ZXPT7jSa4SCZyK6puUwFI556nQetisw?=
 =?us-ascii?Q?rqD7b2iK0a3BTArL5ZOCL4s0007C7By431T2DP8UjB/ZjLMuUJzlWcnds1Ot?=
 =?us-ascii?Q?dwlsVZMHzQHzZTQEZ20ugGmGkaZasFRGp9b9Qs1DO5HoYoJuxBntk2WgAx5V?=
 =?us-ascii?Q?H6hNUujFjWDEz6oTVN0T51+gUiZbYRqptT5gqX3BaaIuNmpyLo5QkE7gxqd/?=
 =?us-ascii?Q?88ZpataK4+niWCurN1VDpgGmk5FqGsVwn4vGLQitX6AZIQp/yj5Qjmh2d35H?=
 =?us-ascii?Q?ERAH1ARODYDF4G1PbVH1C/Kz1aMxUvmt11fghSLKJLm2NLnz6A3mkcJxcAnx?=
 =?us-ascii?Q?gpqZRFhbDlsAWPrCSLPugHSxWUsAwVNeY4xE/GqX1vjDbuPNXlAhbceJdNoS?=
 =?us-ascii?Q?M05xGse+oYHdOLlPIcwrdLI8k5vl4gPA/kS9AyHZOGlKNuz8sOs2F8eloC0Z?=
 =?us-ascii?Q?FDQ1SfsyP30a9P9G4Fj5z6C4ZFX1jB1VvW1iMIP91SlNIrh1NDhdWZU+Ihye?=
 =?us-ascii?Q?aDOteOWzBN0e0WgwgwgNdz8ZbQs0fLJbETm04rElUXojBFY1mwFoeEfFh3Zi?=
 =?us-ascii?Q?SSJKm0wz1JpGRqxUJyEnmk6cDwOfQKSsGT5/rszhuKzxGNtAVG60NDsiVwj1?=
 =?us-ascii?Q?nrGM3vxh/BjfCT4sW5o684B3COsVo/yvKeEkuS97pv433ATXfSKGAA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?j8nOqIYbpRHy6NjDNMSZIadicdbUNkFc6UgG9wQY30mrEbM8CN7tnTsCWjlA?=
 =?us-ascii?Q?FaCJi8+M2cW+wOTj5D+/N/QOZxqQ7TQw+Yf9BT/Ju05I87f5fdxpwKtuMQ2G?=
 =?us-ascii?Q?JKvzGvBCH4JX/9TO4OJVuzo3eJsqh3PsUgnu+0ttVo1ztXdzibi3U7NCquFu?=
 =?us-ascii?Q?r+8FPrp79Tvx2a0J1fXSaz3/8kx9ELblmuTMGcy2uZ+fjREkwuEMoy8qJKos?=
 =?us-ascii?Q?PCKxgxNuIkBc2z9913UiRZMtvciv25Rw6O4Y0LDFWpvP8KXJzKxS5HV2xrQt?=
 =?us-ascii?Q?58kyK/QfkqjbBW0Hf5s7cDoPg/wH10W6rdMQRtpUduTI/PuBuRbbEVIn9dp7?=
 =?us-ascii?Q?iGRRRnaLYAslI2LUYnxkUOan42iDiKefwvnbDFmMYhKxWSEeA0Mq5+0CiZCw?=
 =?us-ascii?Q?mMevQNpqt5/mVKs9NNy7QcMbwyJuFQKOOyX6xYbFQ+vqJPYfdKO7cTdBjjbw?=
 =?us-ascii?Q?FwH7R6kXiP9g9HST11Ri0OEZC8fy9c3UIQNO6WxNRyPSbJ8klU6YGZSls4s2?=
 =?us-ascii?Q?Ggj2IyiZWL3LfU4C/nlKIAdVKTxR7qnGY6WXefTqbspGAAtlC3KIRr2mEpSg?=
 =?us-ascii?Q?888WXmfSilx3SulWgEkGw2uS7w8sZ323bOpfzD4tJ3/UjSyAdlfixArKSTtj?=
 =?us-ascii?Q?O1vpzV5+5cn6x/4IjTa6WJkEfgP4/5jhq6TMKgBefuTNdk+xTUTIDj5MQlJ4?=
 =?us-ascii?Q?d9V6HgAy4KPb+Gewcw8gBnCIx3WoEvQIafJ70zcYgu9/X9mD28Dh8WkbFjyy?=
 =?us-ascii?Q?QKK7AGxml6ZfZalMluazzTRY2lFVVOBFpIbIG3i2N8mAa3BFkvT04kC6R3u1?=
 =?us-ascii?Q?Da5klfMmTQhB5Wzr6gAw+wVKvHZPNIErrcyL4IYqsMDZ327LZs5PtRjtSQEY?=
 =?us-ascii?Q?m3yYEgMrEpqW1cqR+g4ngu54ABEXyyJs5xbLx7qdtrnyrIbLNx1kNUF8+t7Q?=
 =?us-ascii?Q?1/rWIsKAkl/Rmv5Zq2IuAEQfTiP+Ai2wVFKOazQCI5nQmir/sStpkOxaGjfC?=
 =?us-ascii?Q?bZcxq03zXQ9X+CE77Qwa8zoJrMbj+AhgkdkC/C8QC0NwFFkZvOzYkO3f1JFJ?=
 =?us-ascii?Q?xQcxqnbFna9A3ZQpe+Y+F72dgDwIYilBVqPjqIyOvT4IC72gpRcshvdOOg7h?=
 =?us-ascii?Q?A6jfPxz+wy/9kbJqKJxfjpJXyPtaX/SwEBvrrlbQDsOW2AKzlAG6JagDbUUv?=
 =?us-ascii?Q?BL0Vwp3zXLFdkmfTgrOHj21MT3qWuNpDy2sy6AFC3KcGd9enhi2XsZGyN1XV?=
 =?us-ascii?Q?9aKBNeQ0KJfFNYiTAshkwQcR5nb2Ev+DZjK0JjukSssH/yIxOAMXxgtCLiJ5?=
 =?us-ascii?Q?g3twLsKOHMWZxgT2oRIwNbFP2sxpZVcv+C5xtH2ibuS5+BHnYrVQBPgEb1UQ?=
 =?us-ascii?Q?5bG+OMbG7VbC0ePqBDktceM2ywuCUVW+N7Am6f8gO6hk42UrpgBp2rvJBnT5?=
 =?us-ascii?Q?t0Tn7eqPkz02SVyvp5gdxEx0SnxFGZpJQmMFpBF8LscsUosO7XxZGBe2BX+j?=
 =?us-ascii?Q?9frWuZQy/dmoQMdAy3WBmiJRreTKz6Wiz7uOWuwuKAvNZ0nY+ymtP/To486l?=
 =?us-ascii?Q?eTC1HknCAULXqDv0bkGTBCwhoYztySAr/wWlSg1MVQg5lS9sDav9o2lpkMBg?=
 =?us-ascii?Q?jQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e3aba6d5-dd63-468a-c821-08dd98a1a276
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 19:56:54.0762
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m/3UstgNtLrTGLBEdP7l7JrjqMQs+DEhCZTifvrMJ8xlA9Z5ULfEcav1HdGiSvTHSqTXkXXXSADnpGgC1LKihAyI8w5oUE/v7/8h7nTHdlw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8432
X-OriginatorOrg: intel.com

alejandro.lucero-palau@ wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Asking for available HPA space is the previous step to try to obtain
> an HPA range suitable to accel driver purposes.
> 
> Add this call to efx cxl initialization.
> 
> Make sfc cxl build dependent on CXL region.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Martin Habets <habetsm.xilinx@gmail.com>
> Acked-by: Edward Cree <ecree.xilinx@gmail.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/net/ethernet/sfc/Kconfig   |  1 +
>  drivers/net/ethernet/sfc/efx_cxl.c | 19 +++++++++++++++++++
>  2 files changed, 20 insertions(+)
> 
> diff --git a/drivers/net/ethernet/sfc/Kconfig b/drivers/net/ethernet/sfc/Kconfig
> index 979f2801e2a8..e959d9b4f4ce 100644
> --- a/drivers/net/ethernet/sfc/Kconfig
> +++ b/drivers/net/ethernet/sfc/Kconfig
> @@ -69,6 +69,7 @@ config SFC_MCDI_LOGGING
>  config SFC_CXL
>  	bool "Solarflare SFC9100-family CXL support"
>  	depends on SFC && CXL_BUS >= SFC
> +	depends on CXL_REGION
>  	default SFC
>  	help
>  	  This enables SFC CXL support if the kernel is configuring CXL for
> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
> index 53ff97ad07f5..5635672b3fc3 100644
> --- a/drivers/net/ethernet/sfc/efx_cxl.c
> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> @@ -26,6 +26,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  	struct cxl_dpa_info sfc_dpa_info = {
>  		.size = EFX_CTPIO_BUFFER_SIZE
>  	};
> +	resource_size_t max_size;
>  	struct efx_cxl *cxl;
>  	u16 dvsec;
>  	int rc;
> @@ -84,6 +85,22 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  		return PTR_ERR(cxl->cxlmd);
>  	}
>  
> +	cxl->cxlrd = cxl_get_hpa_freespace(cxl->cxlmd, 1,
> +					   CXL_DECODER_F_RAM | CXL_DECODER_F_TYPE2,
> +					   &max_size);
> +
> +	if (IS_ERR(cxl->cxlrd)) {
> +		pci_err(pci_dev, "cxl_get_hpa_freespace failed\n");
> +		return PTR_ERR(cxl->cxlrd);
> +	}

This is a simple enough model, but it does mean that if async-driver
loading causes this driver to load before cxl_acpi or cxl_mem have
completed their init work, then it will die here.

It is also worth noting that nothing stops cxl_mem or cxl_acpi from
detaching immediately after passing the above check. So more work is
needed here (likely post-merge) to revoke and invalidate usage of that
freespace when that happens.

Otherwise you can do something like:

Driver1			Driver2			Notes
cxl_get_hpa_freespace()				"Driver1 gets rangeX"
	--- cxl_acpi unloaded ---		"forgets rangeX was assigned"	
	--- cxl_acpi reloaded ---			
			cxl_get_hpa_freespace() "Driver2 gets rangeX"
use_cxl(rangeX)		use_cxl(rangeX)		"...uh oh"

So longer term there needs to be notification back to the creator of the
memdev to require it to handle cleaning up when the CXL topology is torn
down either physically or logically.

To date the CXL subsystem has not reset decoders on unload because it
needs to handle coordinating with HDM decode established by platform
firmware. Type-2 driver however should be prepared to have their CXL
range revoked at any moment.

The Type-3 case handles this because cxl_mem is the driver itself, for
Type-2 that driver wants to coordinate with cxl_mem on these events. To
me that looks like cxl_mem error handler operation callbacks.

