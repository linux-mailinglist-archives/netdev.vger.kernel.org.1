Return-Path: <netdev+bounces-189053-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60816AB017E
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 19:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 899AB18965FE
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 17:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4401620969A;
	Thu,  8 May 2025 17:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eAoiw+8f"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F43258A;
	Thu,  8 May 2025 17:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746725521; cv=fail; b=Oxy1hFZ+0k6MscLVS5lTT4PieL0paam+7WHj2D8V3xWYPqmpL7apHYgz+ZJULkc3AhDCaAOL7HFb4rzOtC+uXovSbYq9Unt5FNgNnJ1eKhEjztwBX5UYBOph/WFZ4EzgLOMYJ6cpkrNrB4lHeIq9pLzDAfC68oMBoguqxkPzsn0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746725521; c=relaxed/simple;
	bh=Nywar9iA4Zfmnuk1ikSEaIySiliODAZwZf95V5kNY6s=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=edYhvIfbMhxrKsgloT/KvFyzYdKQEv+2LsCa1tllVplwyOvVn+Xts5cFBZCnY5yz6qKA3JaYw+F8FI11cl+h8zLZaVQBfCUHvBXJEnuG32BkITTSmY5tv94rygDqqq0yWkIwKmqEkVvsH11ObtyHgjXc+J6d6nX3T7LcHo7g6LQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eAoiw+8f; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746725519; x=1778261519;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Nywar9iA4Zfmnuk1ikSEaIySiliODAZwZf95V5kNY6s=;
  b=eAoiw+8fu2ZP738lugZV5GaXPZdJOccsjQ+9yr6SBoZAF1xyupcfdZeK
   e/0zWQc9d8RoBBWpRACAgvGL2n2Xr2T7IjMpEpghFm0t4LzTVp6lhfZLC
   5u7ihf/ax8EM6aZEmasjf80YDRptzA4rOBu8YeUbq6uuEwQwJuqepObwL
   B0CqF3VNXkDQMXDfUgLbDmA79/j2yc1NQd1XEPUYsmDzphgPQindxz+dO
   vLKqkFwytLu6pbst50iJi/u3xrb/hryEC4DbW33A26adgOWeGXPoA3CiR
   gDmcBIGXZB7PBMWUxsEUuqur5VUv1/xHXWABlujxXCGqJv7E4sN1YzAkG
   Q==;
X-CSE-ConnectionGUID: cTaG95DZS/KQNDfNISaFOg==
X-CSE-MsgGUID: p3ng0KI+RMSm95kWUYt+sQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="51188509"
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; 
   d="scan'208";a="51188509"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 10:31:58 -0700
X-CSE-ConnectionGUID: 4K8Wt8yISAy3RbnN253dQQ==
X-CSE-MsgGUID: PYj8sQRGQSiEScFwxidQwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; 
   d="scan'208";a="136298784"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 10:31:56 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 8 May 2025 10:31:56 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 8 May 2025 10:31:56 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 8 May 2025 10:31:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C6uhoAW2RK0LnQNtic2sg4Rlv51soc/SkfGX8crUofHc2kXhFCkzOHtfXOHGr0JCWoT+LiW7Bs+SQWM0quturIzxgjaXoykwSGkrEX9xkXNPdpMjCWKdEPnpiSPVlGFvdSu0d+/DZclDxA+/1M7zws1Nd1QgCJVl3Bvl5EBtz0ZGZFsPhNCMbCdPUz47rkm/0WUB+ZxiDbgCXDjjHuZ0Bv1BucMNu+CSpAxDrqaSqbBWVBIgUd1+EU9W1b2vM79t/aSz+CcRC4cUn8axLm/dYOBS+/ESWrMCulUw2DxOeXhXMgSimjrrr1fhx5RBwo5PUkLybCC3/PbA5fzXwjAC7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DRxYZJDFAn+1scwvwsTm2+QcnC88KObF/2Q2PyCpgg8=;
 b=XYOv7RZSaSgfHQznOaD+It7NL9LOlPoIzTeOkw0Khz43/8gfhiCGQ+xzQxCOKPjWDh4R6rTodqCMaju5Hu30OaTLhQj2MDqsQ274sOndQPtDZRXTZHB/NjJ7IfsEXCrYJy8O9thSDMHZIAwAsRCcQDekwDkIabohyQlbVD3BV6P+QULfEclphtDdVH1hy1BIt58QXa8s52z0tm+ltrzoC9A7rPt4jMFLNXpCdfJTjAs6U07j5j7bbQyg3gPQJZy5E/z/Z+RL6jAJ2Diq1Q2MiuD6cGNlvPBvu6b+5E1p58e3oseEeQUBAFFIxGOrSTmYxxXvQQW8hBZ5tinybuGwyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8794.namprd11.prod.outlook.com (2603:10b6:806:46a::5)
 by DM4PR11MB5293.namprd11.prod.outlook.com (2603:10b6:5:390::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.23; Thu, 8 May
 2025 17:31:51 +0000
Received: from SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720]) by SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720%5]) with mapi id 15.20.8722.020; Thu, 8 May 2025
 17:31:51 +0000
Date: Thu, 8 May 2025 10:31:43 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Alejandro Lucero Palau <alucerop@amd.com>
CC: <alejandro.lucero-palau@amd.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dan.j.williams@intel.com>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dave.jiang@intel.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v14 11/22] cxl: define a driver interface for HPA free
 space enumeration
Message-ID: <aBzqf92hI-CIfBGG@aschofie-mobl2.lan>
References: <20250417212926.1343268-1-alejandro.lucero-palau@amd.com>
 <20250417212926.1343268-12-alejandro.lucero-palau@amd.com>
 <aBwFVdyGIis5fncS@aschofie-mobl2.lan>
 <0087470d-9f1b-42e6-bdc9-00b7329b8fbe@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0087470d-9f1b-42e6-bdc9-00b7329b8fbe@amd.com>
X-ClientProxiedBy: MW4PR03CA0315.namprd03.prod.outlook.com
 (2603:10b6:303:dd::20) To SA1PR11MB8794.namprd11.prod.outlook.com
 (2603:10b6:806:46a::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8794:EE_|DM4PR11MB5293:EE_
X-MS-Office365-Filtering-Correlation-Id: 5399507d-5c10-4ff5-227e-08dd8e5637af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PHTIeBdDfyZAxWUmkqXVciteqGXULIRna6SrE3Qk+2gL2cj19nfnfA/Woma6?=
 =?us-ascii?Q?Amaz58K5sqXHIucxu4bPszGwD1dTlqjCUn0kpjVDhJfIHz7z3d/YkxxkomTv?=
 =?us-ascii?Q?of1CFen3FXf91KJBpcPoiOHkOB7EfqKDz8j1ZLj//WBtd7ZfjpalasMYGP/Y?=
 =?us-ascii?Q?l88sH6Ee0L+gZxBRK6h2YS9HuuTVnDrhTpn6NjCDAIu+sKhHm8MrPNTGu7Vh?=
 =?us-ascii?Q?Kd2RskhBDaF2sy1liy2GXRHHyfJh+4jANGnYH7XfRD7+s54748JDw9PlUO/m?=
 =?us-ascii?Q?94bI1mvkOghSxJedtCkfli5m1AIG5ZEUFbvvQZWJOumPvN41vxbhCKEyeFU6?=
 =?us-ascii?Q?We8P4t1rkKug7V3U/mwHZ+8BQCVNPM48+bvEAMpZ1B17EE6p3raWEPQ4eCkd?=
 =?us-ascii?Q?6N6v8GL7cDqDi1tPUd4WaC6Vl8F04pyiJCOxQyn2N7SaNwq46/cR373vZsy+?=
 =?us-ascii?Q?WWFA8Pg6gdndE6NSVtJXEWj1z9vhF5tka8oYrLE0PsGpccptHtZfdQitxIwk?=
 =?us-ascii?Q?IDpPqY2tKNhfClIMprgl/D5SOEgXFUby7X7HB4T6GcNhxqOIuruQmFCo4Msp?=
 =?us-ascii?Q?QX4iNkKO1XRuImW91J6LSdLc4vZ3QzavfGliijk1Ghryy/jAQjwsZPn/4qJQ?=
 =?us-ascii?Q?9c9koqb0jWu7dRAi5/8U4I+/BwNt5M7sRKOlj/gQ6/vD3cpu41yE6uHg24+D?=
 =?us-ascii?Q?+x1UhNaC6DuVJ8Qvg3TdSfkNrbSw+OVSA5W4XFRcepIvZ0bf/bFaOjpC2ohl?=
 =?us-ascii?Q?T/0CPU7RV2djVu65ZBst/z0QYgYjlZgNqld0Pf2p6Bxbi5lWlxVjmWl7EYdO?=
 =?us-ascii?Q?+1BgwaRW/SOYvB/8nqFF45bzARU/1l6qsZfy+pegwZG3CM1N1EVqgI5iBz0V?=
 =?us-ascii?Q?kf8a262kmAM6WiBuFtRwDgmJUYdv3TYLNnqrG78qqgflAOJnuved3ck4qV3q?=
 =?us-ascii?Q?72s+fiuIR+nw/cbCcOYMQMBc8GxJJJtKNWBSN7JdYkzfpM6KM8s/Tq4ANUNE?=
 =?us-ascii?Q?qLe34UCGszZlYSr2fueha9g5rFTEJpVvFHdurQHVcjObicDedDAZtuBYuiA9?=
 =?us-ascii?Q?2hHGZDQ6LCwbbsGKchppDtUMEg9jBZppSaZ4hnT8J6WazHEw8M5my0PDcwbG?=
 =?us-ascii?Q?ZlM8M9g0OOdAVwPRzByDpcKItFuBXr1XU+vDYEowQAX0EMJPecWjngliHSM4?=
 =?us-ascii?Q?S9xVjf98kxDpIoLUxCcHezrQ8Sho6VdyoY3qb43rnMjBpb+oxmxtfyPsnHde?=
 =?us-ascii?Q?VEBF4iiI7lF9dxUQCNy9mZSjZjbDqCq+xHXcGVCpfu4yUm/ZMmMC7XvoXJ9o?=
 =?us-ascii?Q?W3JRO00Jjk4gRxf1sLlZKs6EMzUS6kC2i6P0QTIv6cAd4z4hoKUcydvCG1U2?=
 =?us-ascii?Q?M5K9/bYt4bQlLdEodZjhxxkd83bu9xAOzWUcuCE5dkBIsE8/nBsZQYRaq9zC?=
 =?us-ascii?Q?Qx7hnqcdg34=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8794.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jXD2SW3f5mXBAsnH5fqIOCa90eYf/YQDKsjQ1pEbMObdb7qkTk587lqmVNAj?=
 =?us-ascii?Q?u5R+nowV8VZtndCg4TK447LQtygnMu1TmccXtsmQFAPtTrPU4y8eZgAjtGIy?=
 =?us-ascii?Q?k5NUjUq8NGyUn2ip8ZR3pi6gZiA+owSqkOjZb6DynWUTSJRSTAr8Sjf9NIyA?=
 =?us-ascii?Q?We4y5EAzpa8oCnhwpS/R61xACpQM0J+Wmfg2VIqoqsGMf/LqnIMZii2mXPUW?=
 =?us-ascii?Q?9TzYxz1vSwYOynImWIOWxGa18wKWDp4I7/I+zfTbM61vJrH+1xAgyOF4gVrF?=
 =?us-ascii?Q?y/RDQbybVG+iQ30wNFMQCyVymiyn/nw4/himJlEfjD70BjHX99AHo96h047z?=
 =?us-ascii?Q?GzSKdlfypZ1nuU9EIkRZvRboQM+XVNvvQSIDEBpk6ZkaraWmkbX59Sqcwb5F?=
 =?us-ascii?Q?r4UY/8nBuuaDxypF/384Zkw8vwJSAgq2kgcYwnSuleKqtdsIMXNSrXhqHwwW?=
 =?us-ascii?Q?S4I/GtrPRNquj9coxuHeF5XxPDJ5XEobya7UzoPABBTMbGPMZRbk2uHsy1y/?=
 =?us-ascii?Q?jA4RJNP+aaGCVQN56Opud0lL65XuPLshv9NKsVScIuyehMmFce68W72FHow6?=
 =?us-ascii?Q?yz2UdCyhPj0++V2S7D9DuVutI/3nlRF/fTwVz64zAFT0KdiHptPmPGV+gIPF?=
 =?us-ascii?Q?zZK6UuaWlN0HLBuXz0dgDS0Uu/4uNpy7kSa0P2VYmWwOt/g0rlQdf3h3KC5+?=
 =?us-ascii?Q?CM9ArVzxlscFGuHwry8c8IMnCN9kJzrjQLevfaEmw+4bZHtTcg0mUoSTUvGv?=
 =?us-ascii?Q?h9kykl/xRpyN2FMzasp+alL1dzzeJXQ1BjtSk81QM3duSMuZ7oH/XyvTniB1?=
 =?us-ascii?Q?SksSq8Zji0lS3fErqaHKI09gG/PbXExz+IbpgJovJkmBXqrf09UVAd5lLECo?=
 =?us-ascii?Q?P+ok5A8PAjbNYAgEVlAqmmXZVif/ygpzmW+gHVQploVXDyGTrOjwvlQqWLAP?=
 =?us-ascii?Q?wxJ3jpvHU9Gw+Xjo7lCMzN/qr0sokG3GQz4G7lwybft7nZ4dar9AI1SUNOZg?=
 =?us-ascii?Q?E3HHpNDi8o9w7P/XAN2D/9ZQkooVs1Qdk1Jk6G3kJnhytaKFlUpaEZXiOlCF?=
 =?us-ascii?Q?rQvWysg5yntXj3QOSY7betfof5GEoGnwWq/kbBrwiJ1tpEThsmHXA6lQNuaE?=
 =?us-ascii?Q?t2uZ6xOP1WRlYGOZjAgJdIXC7yFh+M8vUWAsjfsd0JW6zgAuTnrvE+H5PM0f?=
 =?us-ascii?Q?/+YzLWdjM0AmUsaeELiwZSPuJ2xcW62l+PctBOxqxA3v2og12oiLQm4UTi0z?=
 =?us-ascii?Q?8R6ctuO9Dx8ZjJHizzZk/U1Nbswx4bwBIKI/nmkKQj4WcPSJW2rSSKojibzs?=
 =?us-ascii?Q?oRQJXpeFloGvNC5E8+oQfbAYjtrcsbr0kxAncUTk/7v7IPktEURjPJQk39ZJ?=
 =?us-ascii?Q?8FUi9+BGC7CBqigwRLoltKtDbwPm013/2F88LNw/DJ4mhREvCWGrVfBj5h/H?=
 =?us-ascii?Q?hQ3yJ/JWRRgsvTrvtENzfIZOkUi9cA8p9+dP0589MeZtv1ZtihHQeKYJBJd3?=
 =?us-ascii?Q?K88LFluVhk2C8K+CfSiz4jAcSg9pCYOTWRvrt0yKQP6D4VH785etPSAyDTHV?=
 =?us-ascii?Q?DbzpFUf6jWtU4nBjvz5+Ye+3nuoxjzJ0TImaXEkv3ldazJOQ3dowRznuYOCN?=
 =?us-ascii?Q?Gw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5399507d-5c10-4ff5-227e-08dd8e5637af
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8794.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 17:31:51.1154
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cLYemzBT3Zap2ZUGKsZrPE5Ejm96Ab81E4G5Ay/kbWTiFR8rvSRrZg1vIkHv7kCoQDqrPAvvjbmNvSOCrQHwQIADcEclSSnYlt0AUkuUGGM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5293
X-OriginatorOrg: intel.com

On Thu, May 08, 2025 at 03:09:03PM +0100, Alejandro Lucero Palau wrote:
> 
> On 5/8/25 02:13, Alison Schofield wrote:
> > On Thu, Apr 17, 2025 at 10:29:14PM +0100, alejandro.lucero-palau@amd.com wrote:
> > > From: Alejandro Lucero <alucerop@amd.com>
> > > 
> > > CXL region creation involves allocating capacity from device DPA
> > > (device-physical-address space) and assigning it to decode a given HPA
> > > (host-physical-address space). Before determining how much DPA to
> > > allocate the amount of available HPA must be determined. Also, not all
> > > HPA is created equal, some specifically targets RAM, some target PMEM,
> > > some is prepared for device-memory flows like HDM-D and HDM-DB, and some
> > > is host-only (HDM-H).
> > > 
> > > Wrap all of those concerns into an API that retrieves a root decoder
> > > (platform CXL window) that fits the specified constraints and the
> > > capacity available for a new region.
> > > 
> > > Add a complementary function for releasing the reference to such root
> > > decoder.
> > This commit message lacks a why.
> > 
> > It would be useful to state whether or not it makes any functional
> > changes to the existing cxl driver hpa handling. Seems not.
> > 
> 
> I have had to think about the why and I'm not sure I have the right answer,
> so maybe other should comment on this.
> 
> 
> I think with Type2 support, regions can be created from the drivers now,
> what requires more awareness and to find the proper HPA/cxl root port. Until
> now regions are created from user space, and those sysfs files hide the
> already established link to the cxl root port ... but I can not tell now for
> sure how this is being performed at decoder init time where a region is
> created for committed decoders (by the BIOS).
> 
> 
> A comment from Dan will be helpful here.

My question on this patch is just specific to this patch. I think I have
my answer - that these new functions have no affect on the behavior of
the cxl region driver when used for Type3.


> 
> 
> > > Based on https://lore.kernel.org/linux-cxl/168592159290.1948938.13522227102445462976.stgit@dwillia2-xfh.jf.intel.com/
> > > 
> > > Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> > > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > ---
> > >   drivers/cxl/core/region.c | 164 ++++++++++++++++++++++++++++++++++++++
> > >   drivers/cxl/cxl.h         |   3 +
> > >   include/cxl/cxl.h         |  11 +++
> > >   3 files changed, 178 insertions(+)
> > > 
> > > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > > index 80caaf14d08a..0a9eab4f8e2e 100644
> > > --- a/drivers/cxl/core/region.c
> > > +++ b/drivers/cxl/core/region.c
> > > @@ -695,6 +695,170 @@ static int free_hpa(struct cxl_region *cxlr)
> > >   	return 0;
> > >   }
> > > +struct cxlrd_max_context {
> > > +	struct device * const *host_bridges;
> > > +	int interleave_ways;
> > > +	unsigned long flags;
> > > +	resource_size_t max_hpa;
> > > +	struct cxl_root_decoder *cxlrd;
> > > +};
> > > +
> > > +static int find_max_hpa(struct device *dev, void *data)
> > > +{
> > > +	struct cxlrd_max_context *ctx = data;
> > > +	struct cxl_switch_decoder *cxlsd;
> > > +	struct cxl_root_decoder *cxlrd;
> > > +	struct resource *res, *prev;
> > > +	struct cxl_decoder *cxld;
> > > +	resource_size_t max;
> > > +	int found = 0;
> > > +
> > > +	if (!is_root_decoder(dev))
> > > +		return 0;
> > > +
> > > +	cxlrd = to_cxl_root_decoder(dev);
> > > +	cxlsd = &cxlrd->cxlsd;
> > > +	cxld = &cxlsd->cxld;
> > > +
> > > +	/*
> > > +	 * None flags are declared as bitmaps but for the sake of better code
> > > +	 * used here as such, restricting the bitmap size to those bits used by
> > > +	 * any Type2 device driver requester.
> > > +	 */
> > > +	if (!bitmap_subset(&ctx->flags, &cxld->flags, CXL_DECODER_F_MAX)) {
> > > +		dev_dbg(dev, "flags not matching: %08lx vs %08lx\n",
> > > +			cxld->flags, ctx->flags);
> > > +		return 0;
> > > +	}
> > > +
> > > +	for (int i = 0; i < ctx->interleave_ways; i++) {
> > > +		for (int j = 0; j < ctx->interleave_ways; j++) {
> > > +			if (ctx->host_bridges[i] == cxlsd->target[j]->dport_dev) {
> > > +				found++;
> > > +				break;
> > > +			}
> > > +		}
> > > +	}
> > > +
> > > +	if (found != ctx->interleave_ways) {
> > > +		dev_dbg(dev, "Not enough host bridges found(%d) for interleave ways requested (%d)\n",
> > > +			found, ctx->interleave_ways);
> > > +		return 0;
> > > +	}
> > > +
> > > +	/*
> > > +	 * Walk the root decoder resource range relying on cxl_region_rwsem to
> > > +	 * preclude sibling arrival/departure and find the largest free space
> > > +	 * gap.
> > > +	 */
> > > +	lockdep_assert_held_read(&cxl_region_rwsem);
> > > +	res = cxlrd->res->child;
> > > +
> > > +	/* With no resource child the whole parent resource is available */
> > > +	if (!res)
> > > +		max = resource_size(cxlrd->res);
> > > +	else
> > > +		max = 0;
> > > +
> > > +	for (prev = NULL; res; prev = res, res = res->sibling) {
> > > +		struct resource *next = res->sibling;
> > > +		resource_size_t free = 0;
> > > +
> > > +		/*
> > > +		 * Sanity check for preventing arithmetic problems below as a
> > > +		 * resource with size 0 could imply using the end field below
> > > +		 * when set to unsigned zero - 1 or all f in hex.
> > > +		 */
> > > +		if (prev && !resource_size(prev))
> > > +			continue;
> > > +
> > > +		if (!prev && res->start > cxlrd->res->start) {
> > > +			free = res->start - cxlrd->res->start;
> > > +			max = max(free, max);
> > > +		}
> > > +		if (prev && res->start > prev->end + 1) {
> > > +			free = res->start - prev->end + 1;
> > > +			max = max(free, max);
> > > +		}
> > > +		if (next && res->end + 1 < next->start) {
> > > +			free = next->start - res->end + 1;
> > > +			max = max(free, max);
> > > +		}
> > > +		if (!next && res->end + 1 < cxlrd->res->end + 1) {
> > > +			free = cxlrd->res->end + 1 - res->end + 1;
> > > +			max = max(free, max);
> > > +		}
> > > +	}
> > > +
> > > +	dev_dbg(CXLRD_DEV(cxlrd), "found %pa bytes of free space\n", &max);
> > > +	if (max > ctx->max_hpa) {
> > > +		if (ctx->cxlrd)
> > > +			put_device(CXLRD_DEV(ctx->cxlrd));
> > > +		get_device(CXLRD_DEV(cxlrd));
> > > +		ctx->cxlrd = cxlrd;
> > > +		ctx->max_hpa = max;
> > > +	}
> > > +	return 0;
> > > +}
> > > +
> > > +/**
> > > + * cxl_get_hpa_freespace - find a root decoder with free capacity per constraints
> > > + * @cxlmd: the CXL memory device with an endpoint that is mapped by the returned
> > > + *	    decoder
> > > + * @interleave_ways: number of entries in @host_bridges
> > > + * @flags: CXL_DECODER_F flags for selecting RAM vs PMEM, and Type2 device
> > > + * @max_avail_contig: output parameter of max contiguous bytes available in the
> > > + *		      returned decoder
> > > + *
> > > + * The return tuple of a 'struct cxl_root_decoder' and 'bytes available given
> > > + * in (@max_avail_contig))' is a point in time snapshot. If by the time the
> > > + * caller goes to use this root decoder's capacity the capacity is reduced then
> > > + * caller needs to loop and retry.
> > > + *
> > > + * The returned root decoder has an elevated reference count that needs to be
> > > + * put with cxl_put_root_decoder(cxlrd).
> > > + */
> > > +struct cxl_root_decoder *cxl_get_hpa_freespace(struct cxl_memdev *cxlmd,
> > > +					       int interleave_ways,
> > > +					       unsigned long flags,
> > > +					       resource_size_t *max_avail_contig)
> > > +{
> > > +	struct cxl_port *endpoint = cxlmd->endpoint;
> > > +	struct cxlrd_max_context ctx = {
> > > +		.host_bridges = &endpoint->host_bridge,
> > > +		.flags = flags,
> > > +	};
> > > +	struct cxl_port *root_port;
> > > +	struct cxl_root *root __free(put_cxl_root) = find_cxl_root(endpoint);
> > > +
> > > +	if (!is_cxl_endpoint(endpoint)) {
> > > +		dev_dbg(&endpoint->dev, "hpa requestor is not an endpoint\n");
> > > +		return ERR_PTR(-EINVAL);
> > > +	}
> > > +
> > > +	if (!root) {
> > > +		dev_dbg(&endpoint->dev, "endpoint can not be related to a root port\n");
> > > +		return ERR_PTR(-ENXIO);
> > > +	}
> > > +
> > > +	root_port = &root->port;
> > > +	scoped_guard(rwsem_read, &cxl_region_rwsem)
> > > +		device_for_each_child(&root_port->dev, &ctx, find_max_hpa);
> > > +
> > > +	if (!ctx.cxlrd)
> > > +		return ERR_PTR(-ENOMEM);
> > > +
> > > +	*max_avail_contig = ctx.max_hpa;
> > > +	return ctx.cxlrd;
> > > +}
> > > +EXPORT_SYMBOL_NS_GPL(cxl_get_hpa_freespace, "CXL");
> > > +
> > > +void cxl_put_root_decoder(struct cxl_root_decoder *cxlrd)
> > > +{
> > > +	put_device(CXLRD_DEV(cxlrd));
> > > +}
> > > +EXPORT_SYMBOL_NS_GPL(cxl_put_root_decoder, "CXL");
> > > +
> > >   static ssize_t size_store(struct device *dev, struct device_attribute *attr,
> > >   			  const char *buf, size_t len)
> > >   {
> > > diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> > > index 4523864eebd2..c35620c24c8f 100644
> > > --- a/drivers/cxl/cxl.h
> > > +++ b/drivers/cxl/cxl.h
> > > @@ -672,6 +672,9 @@ struct cxl_root_decoder *to_cxl_root_decoder(struct device *dev);
> > >   struct cxl_switch_decoder *to_cxl_switch_decoder(struct device *dev);
> > >   struct cxl_endpoint_decoder *to_cxl_endpoint_decoder(struct device *dev);
> > >   bool is_root_decoder(struct device *dev);
> > > +
> > > +#define CXLRD_DEV(cxlrd) (&(cxlrd)->cxlsd.cxld.dev)
> > > +
> > >   bool is_switch_decoder(struct device *dev);
> > >   bool is_endpoint_decoder(struct device *dev);
> > >   struct cxl_root_decoder *cxl_root_decoder_alloc(struct cxl_port *port,
> > > diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> > > index 9c0f097ca6be..e9ae7eff2393 100644
> > > --- a/include/cxl/cxl.h
> > > +++ b/include/cxl/cxl.h
> > > @@ -26,6 +26,11 @@ enum cxl_devtype {
> > >   struct device;
> > > +#define CXL_DECODER_F_RAM   BIT(0)
> > > +#define CXL_DECODER_F_PMEM  BIT(1)
> > > +#define CXL_DECODER_F_TYPE2 BIT(2)
> > > +#define CXL_DECODER_F_MAX 3
> > > +
> > >   /*
> > >    * Capabilities as defined for:
> > >    *
> > > @@ -250,4 +255,10 @@ void cxl_mem_dpa_init(struct cxl_dpa_info *info, u64 volatile_bytes,
> > >   int cxl_dpa_setup(struct cxl_dev_state *cxlds, const struct cxl_dpa_info *info);
> > >   struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
> > >   				       struct cxl_dev_state *cxlmds);
> > > +struct cxl_port;
> > > +struct cxl_root_decoder *cxl_get_hpa_freespace(struct cxl_memdev *cxlmd,
> > > +					       int interleave_ways,
> > > +					       unsigned long flags,
> > > +					       resource_size_t *max);
> > > +void cxl_put_root_decoder(struct cxl_root_decoder *cxlrd);
> > >   #endif /* __CXL_CXL_H__ */
> > > -- 
> > > 2.34.1
> > > 
> > > 

