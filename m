Return-Path: <netdev+bounces-210466-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E33C1B1376B
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 11:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18BCC168DE8
	for <lists+netdev@lfdr.de>; Mon, 28 Jul 2025 09:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C905B22126E;
	Mon, 28 Jul 2025 09:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AsG1Nlop"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065861E4AB
	for <netdev@vger.kernel.org>; Mon, 28 Jul 2025 09:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753694521; cv=fail; b=Dkt7mnMsRbimiwH5IZih8ZYrF9BZhMz7Nq6V7fgWjfCaDE1ZAFL4YWYgz4KW43C65ly8B4N5FCAnzrdEFl5LN9ePm7YOEeD8Zvc1Aa246r/5vxX8wAINYg2vAPjDb8KSDWxYnP3+v3EXuHf9FiTpcaWVrldOaQwkGOVwvCD+uy0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753694521; c=relaxed/simple;
	bh=+18CQdoDjCOTZvh6Rm1d0vUqYxKRvVnRB+0nlcK4s30=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=nSnummQGTOtl4Pv3Il3TxCgtQC7ZfaNkihosU8fYeYAMbHk7RF+r8OxkohCnt9slKMlchdJ9zH+upr/hGKMjYiLGysNrKB0gAv9N5RpSzr6xIkdhMyY6ukrXi+Fzm8fv5qKxiVrt0KthP9UVryUZ27/6sv0fo8rftNI0djj/who=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AsG1Nlop; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753694520; x=1785230520;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=+18CQdoDjCOTZvh6Rm1d0vUqYxKRvVnRB+0nlcK4s30=;
  b=AsG1NlopR/0L8ygoJ6vQcbyjNApzBcFQbN/xAMRgY35ecfubLTr0MLLX
   evC+OA/VG/u9s+MwQIxO81dX7WMK5016Ubb6VPiXoZgDD6SHqliWV5IfO
   Vl07BtzZBE2k5YaQPYgEIdCp+DMotb5Y+ZWZAPiDQtHYnh4NBLZXZ/O9Y
   P7XYXaVEudiCmSIffwKEGolFrlbvzQi4DfUmrpN5Qtv5lRSlT+Fblxcpu
   sqyp/WCNJLCAU0zddFnd6LFur7SjaQO08On2IoccZxw2wFEXHWPs4KR7B
   7NceoT6rTF4eFO95PGBx96bIRiyXrCpSkkU1k4XJ/de6lXz61abakiuWh
   g==;
X-CSE-ConnectionGUID: naMrtfnkR/iE5j6tAyIz4g==
X-CSE-MsgGUID: cNF5JgDGS9iStwdiTN8Mlw==
X-IronPort-AV: E=McAfee;i="6800,10657,11504"; a="55638583"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="55638583"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2025 02:22:00 -0700
X-CSE-ConnectionGUID: /+aGFADRRLea8n110pBaFg==
X-CSE-MsgGUID: Pgf58F2LRi+vxWM25OOnyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="185998124"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2025 02:21:59 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 28 Jul 2025 02:21:58 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26 via Frontend Transport; Mon, 28 Jul 2025 02:21:58 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (40.107.92.81) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Mon, 28 Jul 2025 02:21:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l1Q/CDH7MrmqLKQrQNGnotIq0fYD6xg2CSVaPpXfXIke3Ib3BbYb3Wa2OSVTwS0ginnOj5AT4Xhqhp38kWWjRyMlTzFtzswnFrGjPr4w+1/vihNBja0JHpTGZ9qx9gT3YF2c1dkr+xLT3RFU+MtaqTHkFoFk4DPcA19hkZvkIsm/BL/qJ3d6bAWjZI4yVE8nRLlr4YEKAqveu93vwNHy7yR1SK1AXJk8MDaq4z3MohSMuko4UOGkAUes9Ny2SPXO0TXBSF4zoGA3Fh4NNPIfo5hvFtohD6Ih+/fFdZOvYJZ++R9aBNjzwOTo1DJ7KT6HwYIK2P6FXrtcEmz5Th/rLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ep99tvhbCcUdpwMkRF4TK0kvCgWHqWaPvIVGF+/bvWM=;
 b=FY/xUpDkINJdEqZmBT+9cxtfP4eGEfh/VqWup5MAeuTHYlCXFMBxU7RguDIhIYifB8pkXQrOBZ/K6fZpz1SIk+j3thdEn/9JpSYyhvyunXzUSWF3pt51cUaJGgKOr3T4xV4PW/pOA32HlTe4lucv7gxzmg5k1ZZdkigi6nSnIoJl3GVu1OCYMGvQsUJbn5sIsZe1VlBicKFaeNzGycwNENmoh2DRQp4UvPB16yxki1SUTK2Xx0tYnNFo4n6uHAME4SBa7U37J4xUU05qSP1Vn+rUFGxndWe7swGQh5p/pMhcxouatxlRhls+9/ZQcVxguHO4tnNyRlJrtdGw4ZiZbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5674.namprd11.prod.outlook.com (2603:10b6:510:ec::10)
 by SA1PR11MB5825.namprd11.prod.outlook.com (2603:10b6:806:234::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.24; Mon, 28 Jul
 2025 09:21:55 +0000
Received: from PH0PR11MB5674.namprd11.prod.outlook.com
 ([fe80::77d3:dfb2:3bd:e02a]) by PH0PR11MB5674.namprd11.prod.outlook.com
 ([fe80::77d3:dfb2:3bd:e02a%3]) with mapi id 15.20.8964.025; Mon, 28 Jul 2025
 09:21:55 +0000
Date: Mon, 28 Jul 2025 17:21:47 +0800
From: Philip Li <philip.li@intel.com>
To: Oliver Sang <oliver.sang@intel.com>
CC: Jakub Kicinski <kuba@kernel.org>, Carolina Jubran <cjubran@nvidia.com>,
	<oe-lkp@lists.linux.dev>, <lkp@intel.com>, Cosmin Ratiu <cratiu@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>
Subject: Re: [linux-next:master] [selftest]  236156d80d:
 kernel-selftests.drivers/net/netdevsim.devlink.sh.rate_test.fail
Message-ID: <aIdBK8xnUErsvBKS@rli9-mobl>
References: <202507251144.b4d9d40b-lkp@intel.com>
 <20250725080818.3b1581c5@kernel.org>
 <aIbUkbxK+urvmg8+@xsang-OptiPlex-9020>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aIbUkbxK+urvmg8+@xsang-OptiPlex-9020>
X-ClientProxiedBy: SG2PR04CA0169.apcprd04.prod.outlook.com (2603:1096:4::31)
 To PH0PR11MB5674.namprd11.prod.outlook.com (2603:10b6:510:ec::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5674:EE_|SA1PR11MB5825:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f2f5306-aabf-4b93-d75c-08ddcdb8321f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|13003099007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5cHpnj7VznQfDJTi/eKKDu3gfFCnEQvzoZDJAYuwqm3F8npkVJnVgfjVXfKB?=
 =?us-ascii?Q?1C3yKKufHqQ32ikwolKn3Ecn50XYerQuQdbKP04BfXIalFpIcwIuS0zcWzci?=
 =?us-ascii?Q?DxKVufUv1NR1yXRVq1LfIwjGG8XqsvmAA81PWCHwLLNbKsZbEG/RJ7BGIusF?=
 =?us-ascii?Q?TN0Ab2tdZzcSf939wXjZPRtYsdb5uiXmCqutDDGIv1KjlHFpy83BWC2h1JoH?=
 =?us-ascii?Q?HPZnG1Vbsxzi59t8tO0qU5qEiDoIR2r2OTZeoB6+tiKTYk+zlLaUH/imCzV8?=
 =?us-ascii?Q?tUeuQ0xwR/GteHfDOiKBXsXhpVbYeAaq2XkflrddR2KCONwxtA9bSMAPyLqF?=
 =?us-ascii?Q?k7F1R7cM6PWJblaKn43zl+64akDh7CyT5VTK7yIn2Hl2AyTaXs7Mwz36RMJl?=
 =?us-ascii?Q?2S0w3TgEK43L9YPsoJiSfEcayp8TF2LRXjkaljlUaIbqBguMAkXh6VqvQaXY?=
 =?us-ascii?Q?N+Qgik3Oh99a3eZQTJ7V8xioQRXH6yvWeoX9VZwDai+rhwVdrxoS3IbxFk+d?=
 =?us-ascii?Q?Kn3lERHqG5FpNzm9JHNd7d4tz+G1xo3JsR487XAQLkInJexwQvdc6XgAsPvH?=
 =?us-ascii?Q?D8ln1hpGTJ/XxuDSKrIs1fFYkvCTfmAWszdmUAWE9+oZQkK5DaS1Pe0hfH5F?=
 =?us-ascii?Q?9bhd4yoUxlFJBGuiBqYG2aWclgEHbeEzhTX7+q7gn+bOTNZ07tnY8pvqXE5U?=
 =?us-ascii?Q?IFqXgX7tlbGYacmcTseRna1SD096PHRivvJRCmtUbQPS7yFODKBzxJ1/8IS4?=
 =?us-ascii?Q?es2nnrPqgkI9zqVJ8RVnGFyYhvL6/8hFZHY1qhaO7xWy4UMII3/yCWlzbums?=
 =?us-ascii?Q?gB+afrtZ08RJc9DN5wOuNMDfKk4Sow/vweem+UCroORi6hHoSJRrf0OrUWyT?=
 =?us-ascii?Q?JP3S8ectJyANHJvdq6liAY7Ee1j/gqA1pzrEtehS70l1qGHz/HVd7M041tbW?=
 =?us-ascii?Q?hTy/QHMj6rloVRChGx4vHXP07TMwoyQCTA+7UHSfOqKYwp2fI8nLQOqbMVf+?=
 =?us-ascii?Q?SVO4ocFYAkM2i9vV/jetjOKmJk0EifzSSp80UmcbZtyr5RQomGfBgXdtYiB5?=
 =?us-ascii?Q?9UfHRGe1G96ykacWa+bw3lvAJiwZdhBMKEz/LuW6orhMXifd3nbJHUzEIcd/?=
 =?us-ascii?Q?PZIKKLVrUkiq8y1WUBIKj/sD+PpcJdH0//bBFSCDAIQb84ngHj6KQvSAa1Eb?=
 =?us-ascii?Q?OY3G6aO6UDiHHxwm+102ZloazVAlxE2CMie2YA4Zx8PwRHyXxFEuGmRGzCGN?=
 =?us-ascii?Q?LfKUzL/Jm5aXpf31tmyKPISBgp6VQ3azKgZc7s1DcRMV3edqn0ZiUT1j7SrV?=
 =?us-ascii?Q?W+O7t5KkyC/74BJpzl7SGkI+7bpVz5WisYIKZm6/eplNbzClBbc4QGa0oxyS?=
 =?us-ascii?Q?nQL0OVjhEqJwVfUmnWoDf70+wn61?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5674.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dzwjvWJ5GbzAzF9VBLg4SwcPKb+9BT5TqeKcLQ1Dnv0c8yuzUat+LAuIxtry?=
 =?us-ascii?Q?XfQxPCV8HGFBNsapBm+kQvuENVx6KKDyoJWkQdqi4cYgilUXgW4FSgTf9T/K?=
 =?us-ascii?Q?VyfVX9MiHwvQ14Q+qXLkBWuTZGg/jtpo0t4azGMutnH7egl+Ibv1rGkdMvdK?=
 =?us-ascii?Q?fhAMatnvUjhti/JFiPRzgUzER64GUdRVYQ16z955W3ier/Fg3RUUfh7C7+F8?=
 =?us-ascii?Q?3A1m8DsUod1yJkwUQ/NUTPOctkCqSOaYRhF3mtq8qXrd4g6hm4wrC5RgpRxR?=
 =?us-ascii?Q?pNxfAONjsr1UtBjABHGysJFtwm7xoU8749vzZKH7jmHvKBc+N2SE71GfMzcC?=
 =?us-ascii?Q?BUiHHcX2Culw+O/ThSQ9EtPcbqnykonuQfRVHf5e4FhMsM8BKIKX70okA1aA?=
 =?us-ascii?Q?IDpOMhZ3BmU3TlrrZpGujqPD6LbUEAuIXKGnFzRaaoQkq7heKRbLnN2Gjbii?=
 =?us-ascii?Q?0lSGu/JeLGE7YqVQWY63Fh5njKiwGVbOQFMO1IYptYGJUpUiNn1psBTwpEzU?=
 =?us-ascii?Q?WQf/25LohuWrfzzmqJjycKUjWDU509WSC4Ljok5UZh8yHkANWIfM1qCI9W03?=
 =?us-ascii?Q?wefSKU3EdPIS1/yk66bJWXvfaAf3EyEN8rR/XI4CdRd06m+a6fBe4fujt9AJ?=
 =?us-ascii?Q?aCEGl/8ghbu4EDZFylR+ZMuhleXC7feZox4VONF2AxEEapWrXPMgUCoaIJc1?=
 =?us-ascii?Q?M0izueVFZSPZK/fch/anBUEDeqTDxQoLIOpohmMkK/Kf8rQ+28+XhVXl0a2t?=
 =?us-ascii?Q?e51MYJhJsOdv6s4wHxtE2JpCaFQa9ryWuLkgv6pZohc3Jv2YPCD6cfIKMlKY?=
 =?us-ascii?Q?iv+aZIC1p2RWalh7gbaIjMCt+DNRmPBE/DooBr1FGks05arEP7GUSvk1wV9p?=
 =?us-ascii?Q?ev5VSp+V08d6boPY3Zox/mFrBMS59n8MTJjajeyZDj+YZHJnNRz/XxUn10UF?=
 =?us-ascii?Q?or1LZ8dzYf1+Wk18J0Av1Bkxzxt9wIqg9FLMk3stYJchRl7NKvIHpgkvuTX6?=
 =?us-ascii?Q?u+5jOZ4bTSxBlsZDZ2O5lkF8+t5bTz1CkRHW3rlrFjeKDw9agVSPEWG6Ffee?=
 =?us-ascii?Q?tCyha9GzK45MV8G5f59nuvq6qe0Nsg0835ruquZW5SUO28jAA1BsuOglY8/N?=
 =?us-ascii?Q?NnhV8wUJNzjwhIhNOtCWOqixT497S61Lrq3FxkI4BdEpB5UqPWiueWlr8Vxv?=
 =?us-ascii?Q?5Hl6HCTLu0uzwwBS83ieKM8sYul31HevlNom1R86WnxXwc8qf24VEbRHO9u0?=
 =?us-ascii?Q?OVssI+l34kOFZKtdFs/l0MGlaSen6YK8/0gfcHf4x2ltg3l/d9kY2DOweA2y?=
 =?us-ascii?Q?cjB0jC1uR0AlTThwFPr7LN3mMia8Yyhd813aARWftBe/Qwe5dennKH1x6mKA?=
 =?us-ascii?Q?tTOzJK/DWAdHLKAlFqim2MfUz8cceScVRoAy8uPHmpbzQuh3xLnCMzdFKLnF?=
 =?us-ascii?Q?E06f3FX8q15zvk2xzsZ06WzfCpqHAdxoS8wUzumcJYS03e1o+dUBiY/MWS6l?=
 =?us-ascii?Q?/Qa4s1575ZqNLLbOi+uTAzBpxaQKhSNgre94ddkIkQPJWvv8COTwmOIi/1dm?=
 =?us-ascii?Q?2zdkbc22ZJ6JPR2UcVoucdMee+lSRXfuqzSEWbex?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f2f5306-aabf-4b93-d75c-08ddcdb8321f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5674.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2025 09:21:55.6973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AhuOEoA8GdB4+UvwiuwtJFdJc3WT1QrbmXhPjqmJJ86fCcSlrVDcRJPdvdSoZ7HsPeR/YWnorLQ+3rAoeXZWNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5825
X-OriginatorOrg: intel.com

On Mon, Jul 28, 2025 at 09:38:25AM +0800, Oliver Sang wrote:
> hi, Jakub Kicinski,
> 
> On Fri, Jul 25, 2025 at 08:08:18AM -0700, Jakub Kicinski wrote:
> > On Fri, 25 Jul 2025 20:34:58 +0800 kernel test robot wrote:
> > > kernel test robot noticed "kernel-selftests.drivers/net/netdevsim.devlink.sh.rate_test.fail" on:
> > > 
> > > commit: 236156d80d5efd942fc395a078d6ec6d810c2c40 ("selftest: netdevsim: Add devlink rate tc-bw test")
> > > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> > > 
> > > [test failed on linux-next/master 97987520025658f30bb787a99ffbd9bbff9ffc9d]
> > 
> > This is not helpful, you have old tools in your environment.
> 
> thanks a lot for information! any special tools need to be upgraded for the
> new test by this commit? we will update our environment.

hi Jakub, after further check, it is an issue of 0day environment that the iproute2 used
is out of dated which doesn't support the 'tc-bw' option.

Sorry for this false positive, we will resolve the issue asap and consider how
to do appropriate upgrade of various tools.

Thanks

> 
> > 
> > Ideally you'd report regressions in existing test _cases_ 
> > (I mean an individial [ OK ] turning into a [FAIL]).
> 
> yeah, we are confused by below,
> 
> from parent:
> 
> # TEST: dummy reporter test                                           [ OK ]
> # TEST: rate test                                                     [ OK ]   <-----
> ok 1 selftests: drivers/net/netdevsim: devlink.sh
> 
> 
> but by this commit:
> 
> # TEST: dummy reporter test                                           [ OK ]
> # Unknown option "tc-bw"
> # Unknown option "tc-bw"
> # Unknown option "tc-bw"
> # Unknown option "tc-bw"
> # Unknown option "tc-bw"
> # TEST: rate test                                                     [FAIL]   <-----
> # 	Unexpected tc-bw value for tc6: 0 != 60
> not ok 1 selftests: drivers/net/netdevsim: devlink.sh # exit=1
> 
> 
> 
> > 
> > The bash tests depend on too many CLI tools to be expected
> > to pass. Having to detect the tool versions is an unnecessary
> > burden on the test author. Tools usually get updated within
> > 3 months and then all these checks become dead code for the
> > rest of time...
> > 
> 
> got it, we will try to study how keep our env up-to-date.
> 
> 
> 

