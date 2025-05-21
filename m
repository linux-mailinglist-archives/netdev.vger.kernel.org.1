Return-Path: <netdev+bounces-192427-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83216ABFDD1
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 22:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC4C99E4373
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 20:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C96828FAB9;
	Wed, 21 May 2025 20:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BZyWx9vB"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D769E28FA98;
	Wed, 21 May 2025 20:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747859028; cv=fail; b=ONMw86J9iEOvNhBtx5wka/noQ6qdozuc8qrl7DieEH9dOmpMqVakpD0ToMn+aNK6dhcUnRwY7sNfp0LxyoTq8bTR5oQUuN0lq2MKExCxJ1VCRcPMa/KhCtOi9Lj+lijWJxOsvgaM6HMimA742pZmGHU0Qymd8TIMG+KGrDeyWIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747859028; c=relaxed/simple;
	bh=Q3lFzeyDZoubkRvOjHcTDG2FjNotF3uBPlWtWf56j0U=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=F+r4Tx4Vh/MxvPr4JtPmgwsf5oTTDhyyQ6l3zg5rU16wu+HTEIvqD5G18EapFcYiYjePNt7rCyOO7vYo0v6VNu4nVSqwgrUvz2ua9FQICfx5nx3e7VqwiWVDnbIWhiEogT/lqjUpva1ZZMkAgiq0/KyYTMgZeHZeFH5d6Kl+E0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BZyWx9vB; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747859027; x=1779395027;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Q3lFzeyDZoubkRvOjHcTDG2FjNotF3uBPlWtWf56j0U=;
  b=BZyWx9vBgGmZwYvHA9NU7RpsQVXFxLZnos8n8Fm2qBLqu8LDaxHeAA9/
   FZ/frkf5jnVg1ofAMKcNmvavg98CcvTGXKaohWWY4hTzZ3VNbMR7yh1cV
   TvVeU4RvOGzETAjrCaPPA5aE6fCv2kRxYrxVlaIN6wHPRwJs9u0Cpnjpz
   QfFkPvJHWtDZkHX5nTILaP/2eJrE/eTKQAt/a7vjLMsKPUx7PvjEEy1zW
   utLD/kmRfaOcibkmdBWWXtOVvKUdSw2x2MkZE3+VmmRHm5/ge2xksSG9z
   V+WZ5WDlNOFIXtyWH/KHTr6AgSCHAQ3gd+wBHk9/TV+tHUywY1YvK8cJj
   w==;
X-CSE-ConnectionGUID: T07eCdV0RQ+dZoFtozCscQ==
X-CSE-MsgGUID: Mc4d+ub5SWeqSlhL3wUNRg==
X-IronPort-AV: E=McAfee;i="6700,10204,11440"; a="49957306"
X-IronPort-AV: E=Sophos;i="6.15,304,1739865600"; 
   d="scan'208";a="49957306"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 13:23:46 -0700
X-CSE-ConnectionGUID: 9qVtXoFeQiG7ILVYdhu/Tg==
X-CSE-MsgGUID: a8oeqrYzRue5EJtHP1z//g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,304,1739865600"; 
   d="scan'208";a="139993594"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 13:23:45 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 21 May 2025 13:23:44 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 21 May 2025 13:23:44 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.175)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Wed, 21 May 2025 13:23:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P2+vkwQCZViVl7z271lymB2s9s2G31ospKlHGv+EopoYPMvCtjDc4j4SACHRw7tlr8ELR273YrWtCb1dS0mV0m0qBY0qmpUdGQhCTSaok/Njj+kF+4Cwn7Cr9YZtwCfggl70eJ8HmXFRgX73RfqVMziG1nnLx3t8RL1lM8aL8fs+Zobm2/7LKtATGVJ95Q/DdEjp3JxuPHHffV/BmN2Oh4bpGPDq9/PMmoSP3eINt2jUOXtdwmH4mqdjDmsLZ2AHESMp1uo06Wd8d7c3Ri5FuLV5hEXnEeEylCtw1hLoV9FF10MaM6S6nJKG0qJUoF5BsiLIEYNcLqlGtnjbE4nFdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DXOYag7lFxWq/OIu3rRKBBNRi7ujyMjo0iO+Sb8jWMM=;
 b=tCLtJ2uRVH0JOVF5SgPujqMi1NPtipR+bM8D++sH3vB/q1/I1fG6ellU6hggRmWxGXceg9kffxA+0B+DbNgignWueEzUA25t+JI7A291zs0P/nS6cI5CvNmXe6lbRCvmEpNo1WJ6qJA8wp1hQuo4qQPRvJW9f9lLtcHXvZ+j4AIthKIMl9lkkPxsSEGWFIobKfrxNI8OyLJ5+D8mLm9a02LtIJa4r7E3w+l5rH8jKnkafIVYoV9q/23DW/YNRI2fRmXAYHXosSRkxc3sxQefAfgSA2dfbdtjvXmAfdWjC/yohT1fLvWYq4kHbP/4b395POXbFPEAsPwNT/eu8EbplA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA1PR11MB6220.namprd11.prod.outlook.com (2603:10b6:208:3e8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Wed, 21 May
 2025 20:23:42 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8746.030; Wed, 21 May 2025
 20:23:41 +0000
Date: Wed, 21 May 2025 13:23:39 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: <alejandro.lucero-palau@amd.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dan.j.williams@intel.com>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v16 13/22] cxl: Define a driver interface for DPA
 allocation
Message-ID: <682e364b9dc25_1626e100f8@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250514132743.523469-1-alejandro.lucero-palau@amd.com>
 <20250514132743.523469-14-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250514132743.523469-14-alejandro.lucero-palau@amd.com>
X-ClientProxiedBy: SJ0PR13CA0083.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::28) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA1PR11MB6220:EE_
X-MS-Office365-Filtering-Correlation-Id: 11f987f7-b2ac-43df-48e8-08dd98a560cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UFUqUtpl9WeZMttP3xK5zIX2926n/kHCLkEwI77pA85RCe0+PLgiylvN5Xij?=
 =?us-ascii?Q?GLqgk1kjRvop0dq8DIRO+8AIStOwCgPJCio4YVO07rLHc2T/EKd7TUanmeTi?=
 =?us-ascii?Q?udKu4AiOWXPEL5yX3lx7GmzI9haTtJZ8IEL4bZlsIDjFf3dsELRf48gQbaRj?=
 =?us-ascii?Q?kNhCfqe2kE59xTq0RL1AeMZ7F0vUheCq/vw2SkLFToap8mEcfeVmkwGF9yci?=
 =?us-ascii?Q?iWbGR5rN3LgHGZpgcBJuT3YTyN5MFWPOBfRz5CaOGgJWV29HAGYt9VqgutEP?=
 =?us-ascii?Q?VdEjAudxIGWgwtmUYE8o1WOnoRNG8iTRBRwIy6rHOn7fhOKjW2VsbkLVGxCj?=
 =?us-ascii?Q?vQJbmr9/bMmNew0airr44M4ZZMeMQf7R3fIZLyA5/8TEQAc10CW1AH/LN8pn?=
 =?us-ascii?Q?qOR1dQc4QCKrXgk/D0n33CwUyQ6wdUNlhJwMDWqUHE2CStAFjH4V6S+f7T7x?=
 =?us-ascii?Q?SGusZjCkRkThp215ihYWZysjMxKMPM1uqCbNef05a4qQaLRSnhB2Ew5KiIZw?=
 =?us-ascii?Q?mh8o0x1XkglvGccmkBhj3ERZYG81v5WzlYMzl5tDzWcQokp3uBNJw3BFD63b?=
 =?us-ascii?Q?nzwwchOqqqZ9/3qFKS4MvGDOOoixlp6/XU/mXp/EPSi44cREAiE8lQccyazM?=
 =?us-ascii?Q?sT7ovXQJ3t9xvQSC0ICYuYqE5sXcwM+Ivo+l0HUQjHgqG5TnkDHjwQW8rf32?=
 =?us-ascii?Q?g7zeSs1DlXa/BAYrQYOiQQEbaJ+3tbHm9cnUBc3m3shxahGbVKZKU7+TnSc6?=
 =?us-ascii?Q?NuGAHCcj5/HAn8Qjrt8gTbml9hWVoKvc4+mgXLluJGwKDGUxqCznBi1Y3Hkc?=
 =?us-ascii?Q?A/5ZK3mfjYDWq5mPbzQMaNb4976bdLb8is9Mn8eLo/SUGjmNO1s1FMlIygfj?=
 =?us-ascii?Q?gKDoGuH5gB+pyY2DFGw1CHIX995Y8zrsGq2Huuh+J7czJ2rq/xDc3o3ZxLXL?=
 =?us-ascii?Q?4O5enHA1i3knSH0hvFj/e1Uioo/DWgBYEW/CO6Hzp8/OCgh9rGyQ0ZKvaD7J?=
 =?us-ascii?Q?eiZg4bHcqkL/IFvGAEzpK3tJEX5OE1NyKAhxyx3OfNi494E/JZSHgLouW7fw?=
 =?us-ascii?Q?F/fG7vIVGh2bjjLRNPfvZmN11dPx+FeXAHtS5gSAwPblG/tNvmSN9aVKfk7n?=
 =?us-ascii?Q?OuFBOd91X4S0wxILkp5bbMbdtnUFACNNeoK+eYlSTYoBgK9ahkK4Acs8Dthg?=
 =?us-ascii?Q?DPnzPm5NNJgI3DPTfOnJtJ7bkDBgmqDiixYls5zMuQfNBD3h4dOnYbEhKPMl?=
 =?us-ascii?Q?gi0NXEC7rwe7rQ0azEC4gmYupCz63p1lVPWuqcwcyxEEZeRSFs8hAVcjazM8?=
 =?us-ascii?Q?zcsSVMMPuy9v0WH5HEQPo8C0WD+1ahg/6xxtLRCDrFOOSCiczoPlxDnI17Nt?=
 =?us-ascii?Q?eHnyZNMBdwLiSVakv57fy1chJbIvE/7FcV4vvngE8HZHXcLXivqiRvIWaREy?=
 =?us-ascii?Q?B7bxg+PUEuQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qKaZWjPjsngtXuP8f/BpBJBjQVllLyPiXn0NumoBBnjBeHqSWE77+uJ9J/QD?=
 =?us-ascii?Q?s7FFp/yIcGNyBABnEU9UlkN8NJtE69eB0pcGyu0GDjNnR569YHnzFMrurn1r?=
 =?us-ascii?Q?jIkwWSWXmS9zx59S6NIpSLe8FvXxBe1JiGd0fMUlwAf0Sq7pgR/i+IO9u9lJ?=
 =?us-ascii?Q?lIJt71gAkBh+jMydticiCU0ae815tXEn3eyb9WntF8LbSarvxRKRYs56mx5X?=
 =?us-ascii?Q?9bOXQd/InhDEgSfwaSGwi2LHkNSlN06MgBavcL9AeohWTag/5rv8keUWPkIm?=
 =?us-ascii?Q?Fva6czGsiOOh19NoTLGBCqpe0UWPM3XzZexfzTasYkVUsPcMwTAqmXYKTx/r?=
 =?us-ascii?Q?6IK02rq3Kqpihip4E0kZbwXc+7Li8ZC8aMaEVG+UFP5xYCmixH9DTAeLy3zJ?=
 =?us-ascii?Q?lqG8br8IUmQKrqNZpqbv78sXAaeGW6+niCoDIRgMOqzZq+kjzUOMHyv07gN9?=
 =?us-ascii?Q?xKZFld86Lzy0OhuqiYdvytfjG1+ingoREKFXozOWc8i3iPJfcUQBw2OYIju7?=
 =?us-ascii?Q?3BYOU4ITFODTMx+htMYT/DtriQTqSMT3OTdfCFq2RJO/cj/qby1wYBYbhUjw?=
 =?us-ascii?Q?DIOxZAYMn3JnJ9LgceoKl0y0a0cK7IIIaqrVOBLXbF4ztuJ2dG+MnB/+ljaj?=
 =?us-ascii?Q?fYBlL1HZ4IOwqByr4ncz0t8ZxXWdXlrEt/9Yy5c+jQVDVCEt/q7sAUdXO65Q?=
 =?us-ascii?Q?jPdKK0S8vCbOvi45lj7hP8U4QnHFPw6rNfLwOY9SYQiwrMs7I+JK2CD9XJbQ?=
 =?us-ascii?Q?wcXf4ZuY2tFytYw5E4LiZRHs/GCGriMX1e1sBhMnFcuLeioWU9NN+yEPgc+X?=
 =?us-ascii?Q?wOkeA9cf8x7DqDIWgVZB2tKEJYcEiYfVBKI29C6fsFdxhigu+arOzVtVLOsB?=
 =?us-ascii?Q?mBkeETveYdNppGVPCv0jEIJ4fqr9IX1lOJpvzs0WTZh3DXemmMxC8KwuRWa1?=
 =?us-ascii?Q?01Fdveb1n7Ow/tZhuZOVBLgUQrefySL8eJpxTDKxBTuLdKaq37Q4KHljzOz1?=
 =?us-ascii?Q?AboMUN6E82nDsg//V7SiUOXxcyJsgEqdL7+jmA9kRZdmW57BK7LrQPFNPEk8?=
 =?us-ascii?Q?8E+Vi3Bfm/sz3+R7V9b3si5SPotpOIMUoBZCBxxYsiFOTHZAA6Swymcdgxk/?=
 =?us-ascii?Q?9fmIHjJwo7m8W4ml8oYinzfkFTIul3lOFmP709sA84KyvGke74lqOTfj5JDh?=
 =?us-ascii?Q?fKu4bvYJjfpHsmvrm4POE8pekLnqRQbVty1cYzj2a2tdhOdumwRf/YEaNAQf?=
 =?us-ascii?Q?atLvHp5oXmdN2wQtpa+HeVOkKVoU4dzf+8K5Fp8NyL+Y/+ShdZMaQ2HVpP+f?=
 =?us-ascii?Q?do7Op1opaONQIsNo7rHrkCWfIJl0KAjCROSDbdhzJdV3z8J8EUXpmyXH9Z5p?=
 =?us-ascii?Q?YzFFcQavuJf51/DZFZ6t+qPloCmaK9HzWRwo5dK0CyE441+dWRm/AfSNpxmM?=
 =?us-ascii?Q?hlXjrwPp4mfRA13rN6BSIsBa+ORQPNXLjKHmG4hKTLxEWKhX4/1Qwkn/Gy+x?=
 =?us-ascii?Q?ih0jMqg2rGY4o86Mh/BQclsK+kkmxhh+u0TlRVgSRcbJLC/tb5JkEJqbniey?=
 =?us-ascii?Q?xyBYj2y7B44h08gu5oUbQ3scAbSP0ag/+FoOW1TKBtJb/Z4r+jQPYj0ZTyXo?=
 =?us-ascii?Q?7A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 11f987f7-b2ac-43df-48e8-08dd98a560cb
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 20:23:41.8944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u288jnzLcm+z70iRoTCrrtExp/QbGXtPPZbQjTklyldo2zujqZMbaWtwPLbjTLt3ynlxBclGTFUn1HNUk3ade1KBnzaZSn9FM/vLjfZkAOQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6220
X-OriginatorOrg: intel.com

alejandro.lucero-palau@ wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Region creation involves finding available DPA (device-physical-address)
> capacity to map into HPA (host-physical-address) space.
> 
> In order to support CXL Type2 devices, define an API, cxl_request_dpa(),
> that tries to allocate the DPA memory the driver requires to operate.The
> memory requested should not be bigger than the max available HPA obtained
> previously with cxl_get_hpa_freespace.
> 
> Based on https://lore.kernel.org/linux-cxl/168592158743.1948938.7622563891193802610.stgit@dwillia2-xfh.jf.intel.com/
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/cxl/core/hdm.c | 86 ++++++++++++++++++++++++++++++++++++++++++
>  include/cxl/cxl.h      |  5 +++
>  2 files changed, 91 insertions(+)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 70cae4ebf8a4..500df2deceef 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -3,6 +3,7 @@
>  #include <linux/seq_file.h>
>  #include <linux/device.h>
>  #include <linux/delay.h>
> +#include <cxl/cxl.h>
>  
>  #include "cxlmem.h"
>  #include "core.h"
> @@ -546,6 +547,13 @@ resource_size_t cxl_dpa_resource_start(struct cxl_endpoint_decoder *cxled)
>  	return base;
>  }
>  
> +/**
> + * cxl_dpa_free - release DPA (Device Physical Address)
> + *
> + * @cxled: endpoint decoder linked to the DPA
> + *
> + * Returns 0 or error.
> + */
>  int cxl_dpa_free(struct cxl_endpoint_decoder *cxled)
>  {
>  	struct cxl_port *port = cxled_to_port(cxled);
> @@ -572,6 +580,7 @@ int cxl_dpa_free(struct cxl_endpoint_decoder *cxled)
>  	devm_cxl_dpa_release(cxled);
>  	return 0;
>  }
> +EXPORT_SYMBOL_NS_GPL(cxl_dpa_free, "CXL");
>  
>  int cxl_dpa_set_part(struct cxl_endpoint_decoder *cxled,
>  		     enum cxl_partition_mode mode)
> @@ -686,6 +695,83 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
>  	return devm_add_action_or_reset(&port->dev, cxl_dpa_release, cxled);
>  }
>  
> +static int find_free_decoder(struct device *dev, const void *data)
> +{
> +	struct cxl_endpoint_decoder *cxled;
> +	struct cxl_port *port;
> +
> +	if (!is_endpoint_decoder(dev))
> +		return 0;
> +
> +	cxled = to_cxl_endpoint_decoder(dev);
> +	port = cxled_to_port(cxled);
> +
> +	if (cxled->cxld.id != port->hdm_end + 1)
> +		return 0;
> +
> +	return 1;
> +}
> +
> +/**
> + * cxl_request_dpa - search and reserve DPA given input constraints
> + * @cxlmd: memdev with an endpoint port with available decoders
> + * @mode: DPA operation mode (ram vs pmem)
> + * @alloc: dpa size required
> + *
> + * Returns a pointer to a cxl_endpoint_decoder struct or an error
> + *
> + * Given that a region needs to allocate from limited HPA capacity it
> + * may be the case that a device has more mappable DPA capacity than
> + * available HPA. The expectation is that @alloc is a driver known
> + * value based on the device capacity but it could not be available
> + * due to HPA constraints.
> + *
> + * Returns a pinned cxl_decoder with at least @alloc bytes of capacity
> + * reserved, or an error pointer. The caller is also expected to own the
> + * lifetime of the memdev registration associated with the endpoint to
> + * pin the decoder registered as well.
> + */
> +struct cxl_endpoint_decoder *cxl_request_dpa(struct cxl_memdev *cxlmd,
> +					     enum cxl_partition_mode mode,
> +					     resource_size_t alloc)
> +{
> +	struct cxl_port *endpoint = cxlmd->endpoint;
> +	struct cxl_endpoint_decoder *cxled;
> +	struct device *cxled_dev;
> +	int rc;
> +
> +	if (!IS_ALIGNED(alloc, SZ_256M))
> +		return ERR_PTR(-EINVAL);
> +
> +	down_read(&cxl_dpa_rwsem);
> +	cxled_dev = device_find_child(&endpoint->dev, NULL, find_free_decoder);
> +	up_read(&cxl_dpa_rwsem);

In another effort [1] I am trying to get rid of all explicit unlock
management of cxl_dpa_rwsem and cxl_region_rwsem, and ultimately get rid
of all "goto" use in the CXL core. 

[1]: http://lore.kernel.org/20250507072145.3614298-1-dan.j.williams@intel.com

So that conversion here would be:

DEFINE_FREE(put_cxled, struct cxl_endpoint_decoder *, if (_T) put_device(&cxled->cxld.dev))
struct cxl_endpoint_decoder *cxl_find_free_decoder(struct cxl_memdev *cxlmd)
{
	struct device *dev;

	scoped_guard(rwsem_read, &cxl_dpa_rwsem)
		dev = device_find_child(&endpoint->dev, NULL, find_free_decoder);
	if (dev)
		return to_cxl_endpoint_decoder(dev);
	return NULL;
}

...and then:

struct cxl_endpoint_decoder *cxled __free(put_cxled) = cxl_find_free_decoder(cxlmd);

> +
> +	if (!cxled_dev)
> +		return ERR_PTR(-ENXIO);
> +
> +	cxled = to_cxl_endpoint_decoder(cxled_dev);
> +
> +	if (!cxled) {
> +		rc = -ENODEV;
> +		goto err;
> +	}
> +
> +	rc = cxl_dpa_set_part(cxled, mode);
> +	if (rc)
> +		goto err;
> +
> +	rc = cxl_dpa_alloc(cxled, alloc);

The current user of this interface is sysfs. The expecation there is
that if 2 userspace threads are racing to allocate DPA space, the kernel
will protect itself and not get confused, but the result will be that
one thread loses the race and needs to redo its allocation.

That's not an interface that the kernel can support, so there needs to
be some locking to enforce that 2 threads racing cxl_request_dpa() each
end up with independent allocations. That likely needs to be a
syncrhonization primitive over the entire process due to the way that
CXL requires in-order allocation of DPA and HPA. Effectively you need to
complete the entire HPA allocatcion, DPA allocation, and decoder
programming in one atomic unit.

I think to start since there is only 1 Type-2 driver in the kernel and
it's only use case is single-threaded setup this is not yet an immediate
problem.

