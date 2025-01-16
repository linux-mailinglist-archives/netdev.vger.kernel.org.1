Return-Path: <netdev+bounces-158932-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 899BEA13D99
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 16:27:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C396C188C671
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 15:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B46122B8B4;
	Thu, 16 Jan 2025 15:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XqSBIizD"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7ED22ACE7;
	Thu, 16 Jan 2025 15:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737041232; cv=fail; b=lSQX04Uq0CvbdnAgkVHOQSEZ6Puk26crMQ3KtTKgjdinYZbhq2PPsitVNJGK0OYhiJhRAY+4WviltcCIKj08FIPXX/tQ7EaVCNWFxGywBuz2LRRqzKszwZCWS731HaWYRdzW6JqQSS78eXBT2KZ6nwl5+CqRa7vodoa1gxztoks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737041232; c=relaxed/simple;
	bh=toWxaOVN8FX8o+C2QzfciuLgwAuAuV/WHQnLmz2bn3w=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jEFlYkGOSZjyiFqnQLLBwBgBoBNSz2kUIDEcFJ6RJfrXd/CUtKd2xWWWr4jkd+3m7dXkTqYk8xCMawN1ZL/mv1QFccimlHZMVSANLGKQHM4/Xu5enSsC9/TPxo/lyoCmE8E2miT0GwDy6noFdVlInAvWzvTf57I0H7a8jDtktqY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XqSBIizD; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737041230; x=1768577230;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=toWxaOVN8FX8o+C2QzfciuLgwAuAuV/WHQnLmz2bn3w=;
  b=XqSBIizDh3Gasqj+0mQBlt83QdL82X9Od/wBzh62a1Q9mi4jbCpHqdUx
   hbEou12qpUfn+4HSf0LqBBMBe+MwUU34815lbTpMPV2aosyoINcksmQ52
   4v1siahcmwOTEtBtVcYKImqg2vpqIRal0pGHDw6KjNnfyWqzZX7kW4B/Z
   bnewTIriUSGENqheH1kv0zCorTw6NoRR1CYDtQD4h9shI90bc8Nt49ABB
   i50UIZ6XSjfOfuCO93X25KdpoSpLM1uMtv3R5n9WquKMzdtMu+jXP4yz4
   L2cikXFy77ymosGlGnWGoAEgLKPNdlGr3dYsDAPX10EwvV29ePQfebWG4
   g==;
X-CSE-ConnectionGUID: cTz2j4/VS16lHJzovYa5PA==
X-CSE-MsgGUID: BlLgfkutS9COMyj6ssSvEQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11317"; a="41367985"
X-IronPort-AV: E=Sophos;i="6.13,209,1732608000"; 
   d="scan'208";a="41367985"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 07:27:07 -0800
X-CSE-ConnectionGUID: vlsopmZ2TNOokOWvg2R4BA==
X-CSE-MsgGUID: hNJmIBQMT+CQBjNcUuXVEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="136392949"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Jan 2025 07:27:06 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Thu, 16 Jan 2025 07:27:05 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 16 Jan 2025 07:27:05 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 16 Jan 2025 07:27:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v7eHjXcC2BkQIbdN8SsarQrM19HOIurbpSrIQzpJv3NeKlRBYdhySqNjYzwcPzpHkTTkhlX/GKRBH8V1IAUEiXxmCqEyl8JYlPT3grgJyAxzvvzEVam0eNP6ceZ3dE+2Ia6MCd2ZMopA4aTPjK1+vRt3GUghktrH8dNdfHD/l29oQJyx2dKbKJ1b4Iu13i+2pqnAaG1P74GYfYD4jZKdRvWW+SS0cofEqVCNp0MH8fgDipLvQlCcv9guPp9QJvoMHWBWB11wGohGNu8Xzn7IqHe3S/CYaZfED8w0QBA/Q8b0qFhUX9odUJE5VRcE0PBX/Y+UCtwFLfvGmw5G68lFrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vMBoZw7UrtN8OToS3sbJfgDE6uxtxN7WlxmYSM/WdCA=;
 b=GY5kpBnsqBc0EbeRPj9vVb3dOq2FRNRPHOZ1N9ii1pvZhHcU00NgAusjowFoUU9PLMY2mevkf9UZoMd7sHoeZY5lNzbrSZ5faiWt0sS9OmBa8POU1PzvkGgzIWD07DEKOnmZf+7jmCQ9sfmtBLbzFyowVj27izG85uqbCDKxO5Rn22GeP6X4U0XEmVkQYnhvwhUcES/Sk/0o1BhX5BRDOFKLav/6jskpHfhP7EE9LBG8H2dTwc9H87P3gHDpIKpBiFxfCYCq37eFScBcGDqpnodG/Cn0udQn2RQFi62nGNAij/41JRbGQlh7Y4ZcUqfVJDE+AHZUBkoDB5gt5Bkegg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by PH8PR11MB7142.namprd11.prod.outlook.com (2603:10b6:510:22e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Thu, 16 Jan
 2025 15:27:02 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::399f:ff7c:adb2:8d29%6]) with mapi id 15.20.8335.015; Thu, 16 Jan 2025
 15:27:02 +0000
Date: Thu, 16 Jan 2025 16:26:18 +0100
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Shinas Rasheed <srasheed@marvell.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<hgani@marvell.com>, <sedara@marvell.com>, <vimleshk@marvell.com>,
	<thaller@redhat.com>, <wizhao@redhat.com>, <kheib@redhat.com>,
	<konguyen@redhat.com>, <horms@kernel.org>, <einstein.xue@synaxg.com>,
	Veerasenareddy Burru <vburru@marvell.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
Subject: Re: [PATCH net v8 2/4] octeon_ep: update tx/rx stats locally for
 persistence
Message-ID: <Z4klGpVVsxOPR3RZ@lzaremba-mobl.ger.corp.intel.com>
References: <20250116083825.2581885-1-srasheed@marvell.com>
 <20250116083825.2581885-3-srasheed@marvell.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250116083825.2581885-3-srasheed@marvell.com>
X-ClientProxiedBy: MI1P293CA0012.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:2::10) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|PH8PR11MB7142:EE_
X-MS-Office365-Filtering-Correlation-Id: 882e5bb8-ee76-43c4-67a7-08dd36423a16
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LSUqMuN6+v478OvTT7AVSEp7U3RVRZHM3VZGo61lRzKDo5XX/T1hLflyym/f?=
 =?us-ascii?Q?wE1ntgwsUSClaeZ7x7Il9ibWEWrinqX5/W1cYChsE+h8IjSWcF2vSGG7ViyJ?=
 =?us-ascii?Q?vPf88ypvWHCGneXkOxW7mcAsFjjN1m/PBTlqqijG62uMreQscpzkW/XC/LDw?=
 =?us-ascii?Q?MWjF3RFkUaVhcpeHFK2tK40EhCEJzIr70JChDsp644L2DIDsOeCbZD6i56ib?=
 =?us-ascii?Q?36LfbPRTIviFg7Q9TyELJ42U9ROV/lRTfzOX0HeazZuJZww4OxSo8gXdiSH3?=
 =?us-ascii?Q?93636ueF9YxjnttORUJffMJztGZq7pyG1/mnNvuk1FXU6+NXbknJ25u87GPM?=
 =?us-ascii?Q?kY6AeacIMwZoaQ2aQrRU/+ccNB7E9SFokvbv6ZmT42oHrZN9m1VFxMjwUYyA?=
 =?us-ascii?Q?9IVwzYux5qVHXVvnmbakP2YezeVgHiaT907lXzh8+VoBwwoBXkr5cw32r4VK?=
 =?us-ascii?Q?nZW4xP8z8f4nfHIancQ6IYT5ttnAH37kUq85Bcephbf3v0OqumVNhqc6VcKj?=
 =?us-ascii?Q?cXYNAHIlASwXAM+pVAT27fyVOkceF0wLxOBx+RVclOOydEDlZ5uF+bhsERZp?=
 =?us-ascii?Q?AT+tLLXOppPOniTRrEdCI9lSoF4FlZRT8tfjGwHrt8XPWPjR6llkdCrSU+uX?=
 =?us-ascii?Q?evLmmWnU0euf+YUufGcYcNH6Ce/jUU40MEmpuCZnHcBCjN9S2ctHoD9UTjEJ?=
 =?us-ascii?Q?ZOuk9wcs1ube5t+GAAOHvRDL8FI94XzwlnbyEMWD/wEHYs68bxa308gEa5xZ?=
 =?us-ascii?Q?yc0dXQ2FPUeWkgJtEIlOA6FdTc+A9GXgI+IWgV3s0V780vtHLTg9SUWjSsuj?=
 =?us-ascii?Q?YqYX9sjCw/exShMKZRcQB0ZB6EQgqW6mXAhJfI7G5yR9H2sOfJAmG8qZJOgj?=
 =?us-ascii?Q?XfWQVhEJIeyiiqzYQXw1CACjWMB0ObfLbwld7oJQR/Z0BSuuJZSvk24RFPNa?=
 =?us-ascii?Q?ZV87F5A99eGWILIr3YSr8cDj56zuFVD+QhCOG1PPE6uDDzOuWuMa1Tn1C5tr?=
 =?us-ascii?Q?Pxc54xdZY1PmAyLaVcYNfIqAjk9hcTC0hdFibLYqdsivXL9cyet/zFOQStvA?=
 =?us-ascii?Q?zy0Xobpt6dMjQW3N+frKAiILvrI+sG8tMZtoSc8g/WACPss0Hlzt8/bvLpb+?=
 =?us-ascii?Q?f19roCu8paCQToPXgRIjhXQOHS/XPd3EWQAbDTj/PLgd9rMZBpBOQHWu7U/b?=
 =?us-ascii?Q?285mXgDWagmLslPQJjLWcnWtUxI89riooBWTlwKgdLL8anq7wy45Xcrqln6Z?=
 =?us-ascii?Q?VEg10ZLKhIN9Djr0eO1VJhgs3kFDPLPa3K/85Y83IGezctNMDkcyEnQay2Bj?=
 =?us-ascii?Q?vxVtWHDlzykvnmSyEDsQubZ89YUdhvTqOIVtfrmh+NtK+5VpNpeZ03yqrizS?=
 =?us-ascii?Q?3uTZwHw0aYlkDprkmTV7acGBihN5KmF4mHaPjKVF+YFXpn/CfA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wey+GKMGAAjE5Cj/jo6sUdBlDI0ZeFg1ACtoINLJdF6cqhXzxE8/CwyiqgAl?=
 =?us-ascii?Q?W0oMEagK3MBtkPGm2yynfBMyaXfIhqqrIKctKW4cWbuGWURu2Bp1zlA3/dBD?=
 =?us-ascii?Q?xhRwm+FsW29E9bM2Px/Z/L/MLZxXZwTqEh1TWlbp2yv8bhlZiAb8vFQ9SFG9?=
 =?us-ascii?Q?lJg1tufXhhVbG25q5oRHoz0ZKxOGuGXLiDntcP29DAaxmM51VEQM3gHWbmC0?=
 =?us-ascii?Q?IZDc53/lr8nswDIOzFW9um7kNdE3EhWj2fE96J1/yLqRodYBmu0LQVacoF2p?=
 =?us-ascii?Q?HpYNFQDXWDRoMnv45ejekTFmfHKhIlSPSyRJzWDG2Q6IWxJpBrNlXt3tgECZ?=
 =?us-ascii?Q?arV6m6iUFUBwYDlUthKD1mlE40aMH5ud7YpicACcaZTkbB5fnxBz7M+qVwK7?=
 =?us-ascii?Q?D/shwM45ddXNsLs6G1Z1ss8fusIYeNqSkGJiJWI2cwLf0+HNBQFdAAyYjTPO?=
 =?us-ascii?Q?G8+CsQWjLf/BKXvehilNowzLAOIjikNHCypzmq+hT5b6tghyW4U6598nA44p?=
 =?us-ascii?Q?8Hem/PE6jYhqQlNIHHR9ZXP6SxHGWm3cb4UBf8GXSxeuMJGs01APHCy12DAO?=
 =?us-ascii?Q?DxpMhPTfQodVefFK8WWeAspFwk4dDNlVwn5d8TVZw/r6QFMEKPk/lYlnfN7M?=
 =?us-ascii?Q?LPfcQ6sgNHpmvhhBiUXZjDIm9znu5lEBhp/4mZrLyXBo6y1MiFs12mB9cMBW?=
 =?us-ascii?Q?jN+tuzp23rHtdJUzLiiSGWwvkkFd7FwqJRO3+5C9/WTeW5c9NfSiQeoPbcWY?=
 =?us-ascii?Q?30WEBAlKEfi90YxU8ul3UMRZhYRgGlMmQzgB8CgqXt+v5lD/+whGaLHr38wi?=
 =?us-ascii?Q?KQ5wKHrknxSoJRFDyAM7zfor3uKKIF9O+EqgCOGGJ2bDxmvbFFvaEvBeuNBY?=
 =?us-ascii?Q?43VCqR+wVNEAXnO51WnfIy2+zM5OW0MLmrDdzfRmJ6rSvHu+gaxdOKIxW4ua?=
 =?us-ascii?Q?U6D2iMitn//JXgxq3LsgNinh65HAUj0qvQxHhxuuVhZGs/wq/TxCwLxHyB7+?=
 =?us-ascii?Q?hVkTLK0X8pw1jJtjuMOaYKsZdmVmybA1G3xc1oJgPdtyK5Ot6YQfJ9lioHXA?=
 =?us-ascii?Q?U/vxmj1BtmH3TqDQ6+xi3u+uStFTXmtvRHKltbCWIkVaOMBTw8SGr+EUmdxL?=
 =?us-ascii?Q?T4UQeYtiIxRunJqRgzzcwfc1QUOAZPkohu2wrYoS6qxE7q0BKCpY8Ve1glRY?=
 =?us-ascii?Q?C9f1H5bhRnnCOpvWNjXXEKarbFgDvokBV+4TmKz+tZ/nkxlhpL+wDL7O9sLQ?=
 =?us-ascii?Q?wJvc++yOM+LIc/T5JIwlPku7R+IH3m9JQ6TZNfGf693eDaHd2tDNn6PSGeGH?=
 =?us-ascii?Q?5fD4BE5MSVg9UjLTQfIh3CbQ/zP1X2Hm2qYdybBsMxbojJQfsb4998jkn+nY?=
 =?us-ascii?Q?3lM/fb9lJEnM8zxJFc5efFS2uIF11Ylp7vrke9NaFOiSb2yPJfbMHoncRv5l?=
 =?us-ascii?Q?LW8QAdcB79jpcd2z0dvesnHY4rVDdwzZr8YSuC2erXVeLyodywPfxx9p0gk/?=
 =?us-ascii?Q?y3Y/g7+rbAwmyKrbX8iY3YW10W5mX9XjaCAlOfos5RLSjwtKoexmGqoU7PMq?=
 =?us-ascii?Q?q9u1pWnlRJrjv0yFWz5PM2TaFtGJveKzlxd/b1aGbpTEmTOa1RVJimqmaKJb?=
 =?us-ascii?Q?Ew=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 882e5bb8-ee76-43c4-67a7-08dd36423a16
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2025 15:27:02.7835
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pYx2c3IfSN5rgbX9WaGj/o4vnSzkoSZXMIMANMi2P75LHVhv1r1CQ8VIBXdMtTFW2ysuAXPT81ABYBbBRbAMW9oZgjPhYqI6BeMYJU5sMJk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7142
X-OriginatorOrg: intel.com

On Thu, Jan 16, 2025 at 12:38:23AM -0800, Shinas Rasheed wrote:
> Update tx/rx stats locally, so that ndo_get_stats64()
> can use that and not rely on per queue resources to obtain statistics.
> The latter used to cause race conditions when the device stopped.
> 
> Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
> ---
> V8:
>   - Reordered patch
> 
> V7: https://lore.kernel.org/all/20250114125124.2570660-2-srasheed@marvell.com/
>   - Updated octep_get_stats64() to be reentrant
> 
> V6: https://lore.kernel.org/all/20250110122730.2551863-2-srasheed@marvell.com/
>   - No changes
> 
> V5: https://lore.kernel.org/all/20250109103221.2544467-2-srasheed@marvell.com/
>   - Patch introduced
> 
>  .../marvell/octeon_ep/octep_ethtool.c         | 41 ++++++++-----------
>  .../ethernet/marvell/octeon_ep/octep_main.c   | 19 ++++-----
>  .../ethernet/marvell/octeon_ep/octep_main.h   | 11 +++++
>  .../net/ethernet/marvell/octeon_ep/octep_rx.c | 12 +++---
>  .../net/ethernet/marvell/octeon_ep/octep_rx.h |  4 +-
>  .../net/ethernet/marvell/octeon_ep/octep_tx.c |  7 ++--
>  .../net/ethernet/marvell/octeon_ep/octep_tx.h |  4 +-
>  7 files changed, 51 insertions(+), 47 deletions(-)
>

[...]
 
> diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
> index 730aa5632cce..133694a1658d 100644
> --- a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
> +++ b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c

[...]

> @@ -991,22 +991,19 @@ static netdev_tx_t octep_start_xmit(struct sk_buff *skb,
>  static void octep_get_stats64(struct net_device *netdev,
>  			      struct rtnl_link_stats64 *stats)
>  {
> -	u64 tx_packets, tx_bytes, rx_packets, rx_bytes;
>  	struct octep_device *oct = netdev_priv(netdev);
> +	u64 tx_packets, tx_bytes, rx_packets, rx_bytes;
>  	int q;
>  
>  	tx_packets = 0;
>  	tx_bytes = 0;
>  	rx_packets = 0;
>  	rx_bytes = 0;
> -	for (q = 0; q < oct->num_oqs; q++) {
> -		struct octep_iq *iq = oct->iq[q];
> -		struct octep_oq *oq = oct->oq[q];
> -
> -		tx_packets += iq->stats.instr_completed;
> -		tx_bytes += iq->stats.bytes_sent;
> -		rx_packets += oq->stats.packets;
> -		rx_bytes += oq->stats.bytes;
> +	for (q = 0; q < oct->num_ioq_stats; q++) {
> +		tx_packets += oct->stats_iq[q].instr_completed;
> +		tx_bytes += oct->stats_iq[q].bytes_sent;
> +		rx_packets += oct->stats_oq[q].packets;
> +		rx_bytes += oct->stats_oq[q].bytes;

Correct me if I am wrong, but the interface-wide statistics should not change 
when changing queue number. In such case maybe it would be a good idea to 
always iterate over all OCTEP_MAX_QUEUES queues when calculating the stats.

>  	}
>  	stats->tx_packets = tx_packets;
>  	stats->tx_bytes = tx_bytes;

