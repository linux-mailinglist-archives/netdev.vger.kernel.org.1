Return-Path: <netdev+bounces-188808-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D81A0AAEFFD
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 02:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA7953A6F11
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 00:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F6AC84D13;
	Thu,  8 May 2025 00:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W9kSdlLH"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DD578F4E;
	Thu,  8 May 2025 00:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746663972; cv=fail; b=K2NtW9CkjXQ+3ZHPwB36z696zWbey5o3g1MKH2OzZr/cA/P4BDaG5+5SBLlX+RvLGNy/tcNn7fAN+eq45X5NzEcjcr++yjV2NPV6e+L3lU9y5+8Ivw3NaW7BZVMGEAZZ7KnvHeLT1f4L9w2+XpC7b6u4eRVM61FHsn+CKb1mK+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746663972; c=relaxed/simple;
	bh=pw/B0cRKnkewkMZF5xRPNw6nH4ZaowlFR8VwroicBm8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CwEePwqEj3TMPOh3InMlFBa89ZdEIaIL3rQGCIM77GCHJ6U5KfhW4bADtemT09M+PPHNoaTzTQbqTszQPG968GWepn48xtHwKTMucn9PWljToKcU36W7EweB4F0nJHZzYWu1pkfwEyd7SFxvbVsCtAbNm7xYj8wIbBwmZvy9hRg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W9kSdlLH; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746663970; x=1778199970;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=pw/B0cRKnkewkMZF5xRPNw6nH4ZaowlFR8VwroicBm8=;
  b=W9kSdlLH58o0i2ShzhwwfJWX14eOgwFZJFjTjFFK/Rn8+fIz/yZ3Y3qY
   t1JPMBRz8J4m2JYMQEXyFAvFFzUXZNBy3GpxrNAEqWHtm8hmCCBhVer7Q
   yCiXvq7RR4p57G1vuFf+4/+Irsbvl59IU+rztLx8r/lXH5VCBfUNA2hms
   Z9zMwyo1ycINYqLtCg84mgH6a+HHMXiW/E2lz8rrshwYeb1o/Vwg1cHJM
   viKRu67drGUFz4c16U7wJ3emdk1lCyijgtnNCNZWHhWrB0FH6BQ7lnf2l
   5yYfzcX7hTCzd+85D5DMpcowpAAKUB6wG4ExJklZ8p6Cd1zUg2xNhbC8F
   A==;
X-CSE-ConnectionGUID: NOsbVCVrTK2heLm6ly4yXw==
X-CSE-MsgGUID: /BtYA5JzSVqB/7/JTRIwIA==
X-IronPort-AV: E=McAfee;i="6700,10204,11426"; a="58621323"
X-IronPort-AV: E=Sophos;i="6.15,270,1739865600"; 
   d="scan'208";a="58621323"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 17:26:09 -0700
X-CSE-ConnectionGUID: jI/E5gEGRt2vF5ueqnZQ/A==
X-CSE-MsgGUID: 8ROvx1rxRB65dVW5U7E2xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,270,1739865600"; 
   d="scan'208";a="167071094"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 17:26:08 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 7 May 2025 17:26:08 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 7 May 2025 17:26:08 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 7 May 2025 17:26:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZNF/pcoje9N1MFsiQPLZDOH/xC5N0B+bpt6Sh7DJyWRmRYBvwwep0x6qcrMS80/Ta/Pq2a+RPjBsrsPbHwVdpAQe0FOxBRVD63MmtYt4UO1L7UEHyRClZO/Pytt0527tj/4vJM87zluvAICmeejCYrDr5aO4hIrumaAKVysSfqvsQd3VwjtUo3gWJqDaBRj11XrES6ZgTJRfWoHC/OPhy+9vWgo9ZLR1rm7B1+ijbfIzYytyhWh5mJjwSnpKmBCYATXKeZHP9Bv5cDiJLKlIPJfejyARCDRVLVhg/uFnN3fCigD9s8z65PgHBJz56+E3RWK9QDD288cRFt66Qy/buA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rg/ZqtwbqeRSH2WORaFfk+uXde1PRDVci9GhHqHlAEw=;
 b=NpQhbACfs+aSlClku67gtGS8LoocJrYIA9Tb2VLmAXYaH5VLwDossT0i8plpNd1lWgIv8xfVhU5+MHHx2TBSwoqXBKcVA6h75mYjvX+9ipiO6J/BWDgs7QR/aI0/IzRKzqcZXTXPJt9stGHLyBXARCoGMcfrZCmzwgZ8faq/CoK3yyfusblsWpfwjOU7tEU/tx4iv6jNnylY713VCfbUp588kW4J4wqGEyTgIa67z7rcJaE7Iv3n6BRTshzER4KmOntEDh4YaOxRdqAId0UZHMIVtMoZwjyy5DtwA+e6ujRAnzw9fPlnn/Q/s1DAif5S0RyKA36LgDwT4hWNspTerw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8794.namprd11.prod.outlook.com (2603:10b6:806:46a::5)
 by MN0PR11MB5962.namprd11.prod.outlook.com (2603:10b6:208:371::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Thu, 8 May
 2025 00:25:41 +0000
Received: from SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720]) by SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720%5]) with mapi id 15.20.8722.020; Thu, 8 May 2025
 00:25:41 +0000
Date: Wed, 7 May 2025 17:25:24 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>, Alejandro Lucero <alucerop@amd.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v14 01/22] cxl: add type2 device basic support
Message-ID: <aBv59PLYPD4MeDrE@aschofie-mobl2.lan>
References: <20250417212926.1343268-1-alejandro.lucero-palau@amd.com>
 <20250417212926.1343268-2-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250417212926.1343268-2-alejandro.lucero-palau@amd.com>
X-ClientProxiedBy: MW3PR06CA0029.namprd06.prod.outlook.com
 (2603:10b6:303:2a::34) To SA1PR11MB8794.namprd11.prod.outlook.com
 (2603:10b6:806:46a::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8794:EE_|MN0PR11MB5962:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dc7b94d-21d4-4b10-6880-08dd8dc6dd62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ADYXB+Q50/jm8r1eHheosienZJHh/LOc6/f9izaa8aBGdpkqBw9pg4YgY3ID?=
 =?us-ascii?Q?uupW9T7yI0xPKk4RrDfJBDjzhiU3F9b9g8I6KpNxhu7nDAumrXJ4zxlHDrI5?=
 =?us-ascii?Q?mhuz1ebKMNMMQaEiYc3Hvx1FWuiP8cm2zeBPQZHMBqlepEN2SY4eUvGazNg8?=
 =?us-ascii?Q?90kx9Obyk1w/rnOJtStsnaiDLHiJCQwDC8enuISJmN5Y5ngBVaeDA5n9uIdc?=
 =?us-ascii?Q?I+7O1YmCWY97gZtMx7UEvIGM1ZC2J4+g86SDcZlkQlr6rl4lbJlhNXG0uYUd?=
 =?us-ascii?Q?ZzvR1zT18vdkqH67xVK8iopd5iPv08dTIZKPx0KDaMrbx/imvftwIGomKRRV?=
 =?us-ascii?Q?161brcasBbpCrRkyv7V5hSCbDXHcod1C5EtwPF6G9cJ1R/bdLCIR72ACDAEU?=
 =?us-ascii?Q?7E3VyquWADUdq5r32OQ7kkavSo9muIBhdrSy+sRqdcH9UhoB4wj7Hah6/Pa8?=
 =?us-ascii?Q?Jshn2FbXft7yxc9tYwdxhIuZ5EjDUFy6z3mQs//iRXx+kw57UAPAu9sWuKO9?=
 =?us-ascii?Q?Y9Yg/uJGFNKFUFlmVZ+JCuGlYgwSDo4Xmd84B595jeZVKTy34WzjasvdKHPg?=
 =?us-ascii?Q?Qj0UUpfVIEw+pg+HuQrQMp1yGUc6HJGvpYcN9blFfG0EUSb5gr4hIMKLjC36?=
 =?us-ascii?Q?Fhin1tJFPihjd/ZAKLhmlrI8qEXIgQhXosqHnO60ES8PRsy/KU2X7Fc0HPm6?=
 =?us-ascii?Q?qQrEPUf8ybTcyREJ5VxJKrbSmpRD6L+SySjLsHYFq4/aG/Fuy9LXWyrzKThJ?=
 =?us-ascii?Q?WdImh4oS/futxaHvXuEpDYkWG9UmU56ULUKzcpIYzeZcBzWigAH7HlYlxgI0?=
 =?us-ascii?Q?F0Ea1gJALLIlmLsmoRi7lNtzjzo0MAGR510wYi1mlT/+6Q+KSbH+gL2mRPn3?=
 =?us-ascii?Q?TyowDik6Md72oSe6qcNCLmTim5sjEVg+JBkMGMy9urxy+B10Y6L+DM81yvN2?=
 =?us-ascii?Q?XqDwVQAjnoNjHxTeKS5tOchSj3rL441zmNhvkfkAoKGMvloA7TqYsiXThpLU?=
 =?us-ascii?Q?KR34PhOChgnt0tFpGtQN2zCyuyYcvwDo686UuwVnQSazHOpBiA9rlQ8lMY/B?=
 =?us-ascii?Q?cbEZysfthXqFl+0xulEirlrQOlsp1+aIwymcBtMDMvgVCxa69R04+L7KkOrN?=
 =?us-ascii?Q?97lEw7Xeq8EDn3Kd2Xy6Wek3dQqUUSTMROjlPzvZ/6bX2avEC0aRI6RdLFjT?=
 =?us-ascii?Q?owv7HgrxbpeGDjVMutiyuJnVkGi0xo30WtNnXjghJTv4UjqIlDUkeY5ICePo?=
 =?us-ascii?Q?j1GrgkxV9ZivEFJo6WPUSCNHdeUplmCFZ1TcyFzDd5KYLua3i1tYtz8futar?=
 =?us-ascii?Q?LPYTAfhtHnIHyHqP2WMI9TXCBvq8T54cEXpFlflFGQ549fbpoo9Z1UeaJaTw?=
 =?us-ascii?Q?W9KbpjHQs4CX7lP3iCqY8+ptAMKQtI797FNDwPRzFMxeUyVvc+ufuQ+LlkMD?=
 =?us-ascii?Q?Ni8l9Pb/Ph4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8794.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YdU8YNrSlY76HzOC6jfU4CXr/9PpRLh4UiSelRm+HXB6BSaCqBjYOYoa6ebc?=
 =?us-ascii?Q?Bwr7SSXxgcMomq1DuUuOAnCpNMlX4RTVf4VUCx4mVn1xvNL4rU0PMABfjmTY?=
 =?us-ascii?Q?z6whG0Lf5iW14/Fu3UoYgpPSDBh4B13OgtO2VG5fBKp+OWnNEwSVEEwfYDvU?=
 =?us-ascii?Q?kgTVBuJ0aRiRICv+gHQmsOHLS5pMW6nEFWdkkFJ+i+2u4BtCm9aAzzPbuWZG?=
 =?us-ascii?Q?vlVrHPSTFO/3iWMrqhWwDf2oOqQEfKcLANwo3VZs+F/mWvUI3s9WER5/Kqzj?=
 =?us-ascii?Q?jb2d8W8ij1dojKrX1dm2eqZ59fix4QwMAg283Qap+dCIQ1KE9rEW5KDdo9dH?=
 =?us-ascii?Q?Crf6LkUjZp78TcaUTw6CIE8YA1jRLXjGalWEn/861Qgr202cl2wsIQYDBwGX?=
 =?us-ascii?Q?i+OvyJLUp3kAMX+UOlBG9VC7YQbKm10kz0OzZMtV2b0q57u/mxsxQnzxj9sD?=
 =?us-ascii?Q?V5JTDod+c7GHhR10W+ybUt3fw3CU2/3qD9kzqpXHImVbXowSlUg6Y+oZZmno?=
 =?us-ascii?Q?HiyBeiWUJwh5kQXErijdvHLb/XBthEn4TnzfDO/xs0bs0Bpdf+w7Tev0JB/a?=
 =?us-ascii?Q?DtP2+VWtq6xZGRPtcYYlR4pxf50ldSHnfCv8QMT77Ll1nqFl86GravyIYt17?=
 =?us-ascii?Q?+00LofemwwI7iGNB23EuXto2uqGlwC2rwh6KCC/jko8DUKULnincb10qsmd8?=
 =?us-ascii?Q?4fosxIRABw12OD4BXHgehNPfPHaYHJrde3F7wY7JewX9fuEaaqvCc+hM//Y7?=
 =?us-ascii?Q?JT4iv33OMt5+HA8czugclPN2Tla/MnA7jyvjc1RNB7Ef8k/y00YJfp8TjKOM?=
 =?us-ascii?Q?pjrXxlcHYgcGDNBaR21LPAxcPXIxPYnJ/KCH5t9BYhWRfnouoEYBC1axAUdV?=
 =?us-ascii?Q?x6kZhflPSuHy7ssICYpF8jOHqm37E5z/NnHhE7WZ/qliUaK/Ki7WU/OpjpVN?=
 =?us-ascii?Q?mB3CG9pP6mEi9HEOUfdtZ22W+rv/bvCBGjdz/S+kTid5yGIPARDJIlhe2wk2?=
 =?us-ascii?Q?0PynbE5pXCbMiJPj7TOmCfWod1d+vaQLAJeiLeb2DAnohM1bG/FWlkqVkLTr?=
 =?us-ascii?Q?U+/9jVmTZ1BnyiwpjSj+wND167B/dV31L/RUeq2MlAu2MTY9wsKy59QZyHP5?=
 =?us-ascii?Q?6mmmjPyTrlNhgqU1IMsBjBSYnLequ+iEXFu6frmKF+VjBLVXUTmJEjfxpkre?=
 =?us-ascii?Q?uVxqg1JeXP79hC5wDeu5Eq1aazNFwJs8tEa9CmLJsLHg3FZiTa+oRRUmAz4P?=
 =?us-ascii?Q?YhsGXfsr7cP3lyTEaUlA32gr2b7ayD6Db5EOerggCPxDfxdQsnMxq9LDAvar?=
 =?us-ascii?Q?CYbajy+1xLqW67kfx3+JdFDKzpJ+cHQzviffIBPQ0LiDOal6rKvqg8qPAUMt?=
 =?us-ascii?Q?1D0MMUPqVg+P4pcnG5oMQGl00gf7sxSyQbUlQ6dfm2woa1C7i7EyyqdgIj/q?=
 =?us-ascii?Q?FwWnoWmZIQlHYMza36dY2gT0VmvJRgoXp5/QL1Xr5vInWGfpDqoZbXSIshWe?=
 =?us-ascii?Q?vbAI3U5HxAArX1kp3DdTutmlec6YPrZX60+yOfv4WZ5oELz+o7R10l34immN?=
 =?us-ascii?Q?LRwUXm6yKkaRxLeTNZ9WMGE8/oKjpKmAxxR1Tygb7KL2NSrmgCIgSjLnEbaJ?=
 =?us-ascii?Q?IA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dc7b94d-21d4-4b10-6880-08dd8dc6dd62
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8794.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 00:25:41.6205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iZsTd43pSCjb7VwfPBy+1cMZVoeWMShM6zKszKJa9tztk9CeTY7aF8LPFJppLClSzJg32hMlatxrtgleJSxwTh8lhHdYxsFfTIYBQ8h6voc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB5962
X-OriginatorOrg: intel.com

On Thu, Apr 17, 2025 at 10:29:04PM +0100, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Differentiate CXL memory expanders (type 3) from CXL device accelerators
> (type 2) with a new function for initializing cxl_dev_state and a macro
> for helping accel drivers to embed cxl_dev_state inside a private
> struct.
> 
> Move structs to include/cxl as the size of the accel driver private
> struct embedding cxl_dev_state needs to know the size of this struct.
> 
> Use same new initialization with the type3 pci driver.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>

snip


> +
> +struct cxl_dev_state *_cxl_dev_state_create(struct device *dev,
> +					    enum cxl_devtype type, u64 serial,
> +					    u16 dvsec, size_t size,
> +					    bool has_mbox);
> +
> +#define cxl_dev_state_create(parent, type, serial, dvsec, drv_struct, member, mbox)	\
> +	({										\
> +		static_assert(__same_type(struct cxl_dev_state,				\
> +			      ((drv_struct *)NULL)->member));				\
> +		static_assert(offsetof(drv_struct, member) == 0);			\
> +		(drv_struct *)_cxl_dev_state_create(parent, type, serial, dvsec,	\
> +						      sizeof(drv_struct), mbox);	\
> +	})

I spent a bit of time unravelling this macro and came to understand that
as a macro it can enforce compile time correctness, and that is all good.
However, a comment would be appreciated.
Perhaps: Safely create and cast a cxl dev state embedded in a driver
specific struct. Introduced for Type 2 driver support.




> 

