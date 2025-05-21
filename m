Return-Path: <netdev+bounces-192434-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83AB2ABFE19
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 22:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5ECA9E6AE8
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 20:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D8E222F762;
	Wed, 21 May 2025 20:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FKKq/rUc"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E35F4B1E5E;
	Wed, 21 May 2025 20:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747860368; cv=fail; b=HQlDItZeVgTsemU+yeYSZgIOPM+VQWjAucqT9ES3niZbuo4NM0mU59auxdTptGuQ8fX00yUcQ0pCOAKE4b1/iVvty/CkNA60sO5WxHMlaNYbCsZshzBAXY27z46hl9EiuE1P7M4w7ia2V17ux9HhRf+XJTXz1U31hBEVJkzDSsQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747860368; c=relaxed/simple;
	bh=ZunOs76BL2QDVrvHqW5KfLl0Q55pp6uKd4amoc0MTZA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sZi0auM+k0CbD1v9blJywhjHH0U0TUf57p5PF/+ApIFi3xVPXvayzf/pLN43eT6HsLb4csaUflKMpr0sdqLXOUVIJ9pJi/XJpOr1VeD1Fc+ES34URwSjZqUwfvtKJow0CNEXmu5bbxgKfXddWtVdF1xRxPlGzkkfYTs543Trm7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FKKq/rUc; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747860366; x=1779396366;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ZunOs76BL2QDVrvHqW5KfLl0Q55pp6uKd4amoc0MTZA=;
  b=FKKq/rUcd/BuZQh/puzTwe/LovOCX4x0nC6W3qveM1G8ShHF3tSipIn7
   Q/Hse03P3+MIRi9P/PuLiXg1EIXqia6Wp5eE0/xUCePmYV2YnXhtmrZ1H
   cmkmem4AizdjvZt9vqzz2GGHUZWl1LWV5HAH9IhPniyR4Ee6Nhv5/wnX0
   BYTzDLWlkCYeRy5A2hPDXGsXFoHdXD3l/WTavy2zELurKWHZJEn7fj9O1
   gyz3Edh7cTuZo0LGNoxKc5R+8fL2dxkFhGoFpvyw+PI327i+U5ao8cOco
   Xc0LOG5znMl00CcIJ9/Z5uSykuhrFKjahVuOiqjqi7tlgoBegpBq7NktJ
   w==;
X-CSE-ConnectionGUID: LUKY4VoGT0uMEwA9IVW7Vw==
X-CSE-MsgGUID: lWMNDaenSmi00id7KqEiSg==
X-IronPort-AV: E=McAfee;i="6700,10204,11440"; a="49997412"
X-IronPort-AV: E=Sophos;i="6.15,304,1739865600"; 
   d="scan'208";a="49997412"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 13:45:59 -0700
X-CSE-ConnectionGUID: gHy1APUaQK67jLD9kR0PWQ==
X-CSE-MsgGUID: nX23HoKbQAGexyvfcydyig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,304,1739865600"; 
   d="scan'208";a="144970742"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 13:46:00 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 21 May 2025 13:45:58 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 21 May 2025 13:45:58 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Wed, 21 May 2025 13:45:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f77xEaK2vLMmQ4UM8Xzz12l4juh+fiaC75wfUZw5juin0b+W0R1fRTnMekGs5cmGtAzx724v+KQJ+D9dsct4NShUQJ/q9uKQobPRxSagC3BuIQffQx9FCXo3v82JJsxPWdFz224REymAJlWIX9T5n547Vz2iCTW61Q72Gzsj+2TosMo1aPzS/mGL7SCMvhNYJf7XW4+2JEgXGRXYngIEmBb05vNiEgf916LrHnOjhib9dlXSQP76dPhlpVyyi5iYZT41nqkZFqDR/eU36mwvFC3Oo72gPEzEylbxVjJ1+WSz2n/VQfqjiR2pWzCJEqc5m/a46j+pP0MoFuxop8akyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tx4A13mI/ge/UIjuCpeP2rt7/QMD+n6QjXPg7ZM/kGE=;
 b=ZWOgv4wjI/GX1r9RL9qT1DQLHRlnncLCyqCbet/fzRjDBoTR5S/5nxGTXGaF14WVHxGVibm6GueauOkpnykhX4Mru4Iz2Mp4wYKGf4u2HDhhpVUOEWusImlUB0iqV0Qo+q+S9FD4iBuQKkucLJP8IighaKSRV8JiWrl2xjd3V2E4zGym8HqtFBLkbF2DP7U0WKV7ZQqGuWTszKYOG7c4IUgm62MdJZ3lPulFDGQNfkQ4sbzGWvZgGQf1bMI0/Zuda/mcoI7Gk7U9SQPtNz1VHT8fakTAGKTxtJ5bOMSobN08Wo0hPetk7n/7j1FHlghprXoApaQOzw1LSzMbYwuLPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA1PR11MB8393.namprd11.prod.outlook.com (2603:10b6:806:373::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.20; Wed, 21 May
 2025 20:45:50 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8746.030; Wed, 21 May 2025
 20:45:50 +0000
Date: Wed, 21 May 2025 13:45:48 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: <alejandro.lucero-palau@amd.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dan.j.williams@intel.com>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v16 18/22] cxl: Allow region creation by type2 drivers
Message-ID: <682e3b7cf2b2_1626e100ce@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250514132743.523469-1-alejandro.lucero-palau@amd.com>
 <20250514132743.523469-19-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250514132743.523469-19-alejandro.lucero-palau@amd.com>
X-ClientProxiedBy: BY5PR20CA0014.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::27) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA1PR11MB8393:EE_
X-MS-Office365-Filtering-Correlation-Id: c2c7e902-c8b1-45f7-1c43-08dd98a8786f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0+UPfIxh+VhXOjgZNpDyS2goTLLueFdE4YO0IMA1/ZQWJQk9V0QjFNjrIgii?=
 =?us-ascii?Q?dsfshOIg144tEY4geLGZlijuXvKqzVgCotzjIB5S8nPkbdqBY/P3Z+lcBwv/?=
 =?us-ascii?Q?AFYGfesH/wQ+Qmm5rggL8cfXgojRkH4414egRelRMj8ORgdPNmx2dEwUCm5E?=
 =?us-ascii?Q?QBCGTtPpDjiF63YNxBLCB9/mRENyPDQVpu3djWd0IqXVhkFlDswujQRH8Qrh?=
 =?us-ascii?Q?1QpPuGCo2Bdly7UVNXLWsm1grgpo6rTH/PXtpxDge1EHGij4zYRKLEzc8RnR?=
 =?us-ascii?Q?CkMwMHZos0J8tPuENZAysokfQZtNREpYly8qJX0Q0QCb+5b43+yPVKmD26k9?=
 =?us-ascii?Q?VtRBoolIXQZkyEy2XW2kG5z9Arq0kIEBlq8HCJs2SDbddK8zQxgry0HzVfvt?=
 =?us-ascii?Q?V8BienXkUhr1/63CGoeUR0CZi5k+sRz/PT8RwP6Y4uRG0RAIxqZxOPjpgnDV?=
 =?us-ascii?Q?LoRh9ZvoeSlJLrrLk2yNSobg3GYdNT0BpvclMgQ+qH89DgA3GIjay7cSciQC?=
 =?us-ascii?Q?y1BfECzkZ4Cl4zeU5G2p1sZFBjXVpM+cEor64r48KReoVNa8qNGjNSFRmlpq?=
 =?us-ascii?Q?3tFECAEtDJE/BaqfzK1DUjLWAOOeoLJmrUdkhH1fg7l687Beza5uVb6WOpI6?=
 =?us-ascii?Q?VlcApZLOHVJFdDXd56NAdU/X4OV4iNdZNsgaSbq1MQftQjjUZ7erwmC/MDGX?=
 =?us-ascii?Q?8pP8LvOCsXwKgduIyPBTjB6n41pPXwmRxxVu8PNL/ixgSgxrT+hrLQ+KQZ0b?=
 =?us-ascii?Q?QQH+tv2nZ8hg46DeU9/h5aSmQoYHm6ifonoL7TvR7R3G2AI3mIHvk6Lk5tKA?=
 =?us-ascii?Q?ERndvLHnUga3enebs/HpBxrNZoIDxqGS5bPTTCV73W5gFP1uF9X0LqkWYleS?=
 =?us-ascii?Q?wqGeGw6LMD2H1GNMjqSjhZw8KrQQ5yEZOcRPJKHNf01wXDyslIWGcBbXpAXZ?=
 =?us-ascii?Q?6N3S8sLWCE66POMGSWz+k+TmWVoMrTExI/ZteG1bpt81+ZwHS6zVqUS7lybO?=
 =?us-ascii?Q?FwwEHs2pLUTc5SJjU2sQPJbFd1BbBqYPo7u5F0GKBp9yYCogVvBpd7tPCYvA?=
 =?us-ascii?Q?DjPLe9PAXFB6YzlNf80Ulfd6yU6YEe+DjB4dMgHSGmfXRSipnO0C32D+CrXI?=
 =?us-ascii?Q?1mRchwZwhZdOH5jI3te7z777Sx8+JcjtPK89RdXmrsEWJsObCNmiMnnmM5Zo?=
 =?us-ascii?Q?+TDmwq3MyVG3J96OJxADfUprOlRT9MipD2rlO/pDLmwpWSt+kQYCT8ciOUEG?=
 =?us-ascii?Q?4tigfOMktJQE++JV3R0KWGCvq5aAAjmVGw487aiby9CtAUdosqtztXll1YN/?=
 =?us-ascii?Q?7kzchU0iiYZxr6in2MKsD0tx8PCeA6aDYWRjvSKzYTlOUcDiHlhaF6ZUmttb?=
 =?us-ascii?Q?eVU1GgEN3hPfvSf5a73fGuLuqdfGECUg2kBxPPYmj8hzaMtVKRWCWQZfWFG2?=
 =?us-ascii?Q?v+vL0Vy1yLUvWfYDiHk3/YZoObmfYzPJsgiBMgioGa0oViZ6RPHEpw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8616v5eiHzhmiksYdr9UNtJFjR46TOfcN4M8dGsgmxaWSOogbbTkx/mCOjF7?=
 =?us-ascii?Q?OOkwTOya4cxXrx/vDLm2wtJljC3GmFIUpC+n1wtPAiWoox896+lh5sMNgF8R?=
 =?us-ascii?Q?uIi6h9Kp1fR3LLpshGkPM6jrWAJvtDMmD3WQkxBCLEYz7dD56X3ojwk57Pv5?=
 =?us-ascii?Q?dw8CTu6ePhToIIjwDQKtp653wvQkRuAS/i6jyHhzNcJP0YhOy9iOMt8p46an?=
 =?us-ascii?Q?IkfTyQkMR2+QPZYczdvub15HlLhfDzB4ILnI1JNtSWRb1djie1WKDNNSdI7h?=
 =?us-ascii?Q?XBxQK7fjSWiUAgGPv0sOnnat7YaUjIdo8hRoavxe/Mygld7ZZmODjQxt/OiK?=
 =?us-ascii?Q?3OocXVvDxD8qGIa0WXGOfXOmahEAiKyRLuLA5psAcjh+23wHNYfkYjuZWCJW?=
 =?us-ascii?Q?oSFYsjEVENCpN1z2nMlEuouKeYzWEHfcIiu6kVPU2vu7EMDXHDAW6DOuzl5H?=
 =?us-ascii?Q?Lgi7SYxFbLcIk6lG0Sl0fekUo3waodD7Wgixn19s3M2sDB+biteUJWianCO4?=
 =?us-ascii?Q?1n7IlX5QKmCydK6lx8NjrvVaBDFuPryEXFw0/PqvuJHPyv6gdPSNFMqZgimd?=
 =?us-ascii?Q?elQUsUgf9FY4QCHi+QeUhKN6GNBbBV0N3datJFfdurkvEabbRvYC9TdkicH9?=
 =?us-ascii?Q?Kw63H66ae6AwehiLxO4atUgEjWrloJk8nxt1Mx+oZitgJ6FPKL1gS28uvtwW?=
 =?us-ascii?Q?p77nlRCLTvGszWNur9vDZBogalc3QwnAcDZADar0Nij11B06kVH2ZMgzqVCn?=
 =?us-ascii?Q?c1Qlk69AulB0DOgSXvPPFIqnyXUI6jJy9dV3BX/GdDi/B94zDc+DAqBoeABY?=
 =?us-ascii?Q?cC9rpQYYi+5vJOzSl01sjEMQy2o3RmOBLYxgJmUf2SORPeLlX2fUJMte64QE?=
 =?us-ascii?Q?o2stARqVs+RzMBK2BV6ZVGKWp7/whIJ1qIWBTbRj52CpIkpAnE8u2+2qtisx?=
 =?us-ascii?Q?8272xCHGaTbsXZTpvcf4XTTCTkUvIBKHYGkb+EOpG6vlDWN0dY5+TYekPx8g?=
 =?us-ascii?Q?ZGqQSBKLyt6kfUdFD9BXv5Wu/FLOwOKySS0Fch3VG8gx94wPrl2vsbJ3SzOB?=
 =?us-ascii?Q?u161e3wAX+ecvO4FYRuaiK3FQQ8niCMOD1n0B3EJr+pUDsUO33n8qhoWe2sb?=
 =?us-ascii?Q?vlYnNHpOV1nuYUKM7EAbAbJAlxQR0LyfDPzSGzKZ9eJM48mCOoBd50uL3vSI?=
 =?us-ascii?Q?TUXdbKLOrqZi93Mcq+jcLhEnBT8LoEsIgZyP4E6qftij/UrZCSPhi/FIdpub?=
 =?us-ascii?Q?ecVlW9af6mcp8IxAtVq9qtStcIen+m0+ws0A56J+4V4qQ0LMDbYk8t34ctjh?=
 =?us-ascii?Q?CPFQUd6oLYh0Zixtrii3pddN/irR+fpbnEKjmyO6dXyOKB+oqAmU7+SrcTpU?=
 =?us-ascii?Q?0jpkAVXxwdnikSczOO0xuu+wUiegmUNtMudNe5F7T2qcWDyB1Cntd5URP5Uh?=
 =?us-ascii?Q?10zrt4nCCb+O8lHaZKEfbw4fai+zpQ1pB6+GKZa3fhQCGifAGwxCbXfhTa/1?=
 =?us-ascii?Q?45nsmmclVyEPHjunaOOilf60Ou9x4hBrGWqlSOvBz2CKWOfYBkidzRfgnv+g?=
 =?us-ascii?Q?Gab3aJ0uhoqdsxJT75n2DHmlLNDEoO9gkfCE8S92W5CIlEqp8Jr8fvhVYbVy?=
 =?us-ascii?Q?MQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c2c7e902-c8b1-45f7-1c43-08dd98a8786f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 20:45:50.0465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GvIdPC/MAulbi8YNcjcbDHW+W2AtK2YcqutSvnMXTqGzvIKbG8gMXU2qXWF5DN9l/wTNdD3Tc6noD0Un33ekMRpw8HSBbhl+QF2LS+MAMSY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8393
X-OriginatorOrg: intel.com

alejandro.lucero-palau@ wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Creating a CXL region requires userspace intervention through the cxl
> sysfs files. Type2 support should allow accelerator drivers to create
> such cxl region from kernel code.
> 
> Adding that functionality and integrating it with current support for
> memory expanders.
> 
> Based on https://lore.kernel.org/linux-cxl/168592159835.1948938.1647215579839222774.stgit@dwillia2-xfh.jf.intel.com/
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/cxl/core/region.c | 140 +++++++++++++++++++++++++++++++++++---
>  drivers/cxl/port.c        |   5 +-
>  include/cxl/cxl.h         |   4 ++
>  3 files changed, 140 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 4113ee6daec9..f82da914d125 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2316,6 +2316,21 @@ static int cxl_region_detach(struct cxl_endpoint_decoder *cxled)
>  	return rc;
>  }
>  
> +/**
> + * cxl_accel_region_detach -  detach a region from a Type2 device
> + *
> + * @cxled: Type2 endpoint decoder to detach the region from.
> + *
> + * Returns 0 or error.
> + */
> +int cxl_accel_region_detach(struct cxl_endpoint_decoder *cxled)
> +{
> +	guard(rwsem_write)(&cxl_region_rwsem);
> +	cxled->part = -1;
> +	return cxl_region_detach(cxled);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_accel_region_detach, "CXL");

There's nothing "accel" about the above sequence, it is nearly identical
to cxl_decoder_kill_region().

In general there does not need to be a parallel universe of "cxl_accel_"
helpers for Type-2, just use existing infrastructure and maybe enlighten
it a bit to accommodate a Type-2 nuance.

> +
>  void cxl_decoder_kill_region(struct cxl_endpoint_decoder *cxled)
>  {
>  	down_write(&cxl_region_rwsem);
> @@ -2822,6 +2837,14 @@ cxl_find_region_by_name(struct cxl_root_decoder *cxlrd, const char *name)
>  	return to_cxl_region(region_dev);
>  }
>  
> +static void drop_region(struct cxl_region *cxlr)
> +{
> +	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
> +	struct cxl_port *port = cxlrd_to_port(cxlrd);
> +
> +	devm_release_action(port->uport_dev, unregister_region, cxlr);
> +}
> +
>  static ssize_t delete_region_store(struct device *dev,
>  				   struct device_attribute *attr,
>  				   const char *buf, size_t len)
> @@ -3526,14 +3549,12 @@ static int __construct_region(struct cxl_region *cxlr,
>  	return 0;
>  }
>  
> -/* Establish an empty region covering the given HPA range */
> -static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
> -					   struct cxl_endpoint_decoder *cxled)
> +static struct cxl_region *construct_region_begin(struct cxl_root_decoder *cxlrd,
> +						 struct cxl_endpoint_decoder *cxled)
>  {
>  	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> -	struct cxl_port *port = cxlrd_to_port(cxlrd);
>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> -	int rc, part = READ_ONCE(cxled->part);
> +	int part = READ_ONCE(cxled->part);
>  	struct cxl_region *cxlr;
>  
>  	do {
> @@ -3542,13 +3563,23 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>  				       cxled->cxld.target_type);
>  	} while (IS_ERR(cxlr) && PTR_ERR(cxlr) == -EBUSY);
>  
> -	if (IS_ERR(cxlr)) {
> +	if (IS_ERR(cxlr))
>  		dev_err(cxlmd->dev.parent,
>  			"%s:%s: %s failed assign region: %ld\n",
>  			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
>  			__func__, PTR_ERR(cxlr));
> -		return cxlr;
> -	}
> +	return cxlr;
> +};
> +
> +/* Establish an empty region covering the given HPA range */
> +static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
> +					   struct cxl_endpoint_decoder *cxled)
> +{
> +	struct cxl_port *port = cxlrd_to_port(cxlrd);
> +	struct cxl_region *cxlr;
> +	int rc;
> +
> +	cxlr = construct_region_begin(cxlrd, cxled);
>  
>  	rc = __construct_region(cxlr, cxlrd, cxled);
>  	if (rc) {
> @@ -3559,6 +3590,99 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>  	return cxlr;
>  }
>  
> +static struct cxl_region *
> +__construct_new_region(struct cxl_root_decoder *cxlrd,
> +		       struct cxl_endpoint_decoder *cxled, int ways)

What is the point of an @ways argument when @cxled is not an array? It
was an array in the original proposal. Recall that this interface needs
to be useful not only to Type-2 but also the nascent CXL PMEM case which
will likely need to create interleave CXL PMEM regions from label data.

