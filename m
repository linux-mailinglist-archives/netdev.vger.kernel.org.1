Return-Path: <netdev+bounces-191709-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C80D1ABCD56
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 04:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4046D3A43D9
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 02:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709AD19EEBF;
	Tue, 20 May 2025 02:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LNq/UTXJ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC17E1E492;
	Tue, 20 May 2025 02:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747708862; cv=fail; b=rDJOcQ689evBaySkcIrjOdE8j3V+qaT6UM1E99GAArTQiw4vLaVaJe8htIcfxTJE6dF8lj32Dplrv7zWzcdBTvguU1UD5/epGt/XEsbe+md6Xp+r8L4LYPtrN0aSQci8eH+CB5pYwM4qqOdPMdTRi4oJ2TQOBrevS+LV7PQ1qa8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747708862; c=relaxed/simple;
	bh=pG1pd/nA2S41kwKyPlMSimMyyx2g2rMXEMAFUSGFLeA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iVbyrYe6G2nPpuJ3uNdUdgqq0fM75MfDR7P31IePCpiRHN/b5aPGSW4OA7DAelnt1EhNZdD7KicgvbIFeqdFtmRkPrSLfe9Xd9qU7piVRG9wVDX9x2+yf9moIexv6JQA1wH82yen13l4U4Whzg73eEDDP5lQLqzKif/hNikRPOU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LNq/UTXJ; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747708861; x=1779244861;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=pG1pd/nA2S41kwKyPlMSimMyyx2g2rMXEMAFUSGFLeA=;
  b=LNq/UTXJ5b+E/iVRIaF0Nh3OFuyKWFhMKlBJvhiEiymCSOuwalLEnjiR
   GnJe8tBrPBZzPDJmHKwVDjG9lCypjddDsPZkfI+TuKpYgP4N3WOXU0wGk
   AZN7wed9t0qteBEGFKYb5rLvPIsOrwfCI0WxjWQQn82D4tSpGhSS2Szh/
   pAcAo/On6KHKpRuMnQ7X11t6OkBEfycPr1eTN2WEI4NxildZAvlocM3b0
   Ncd5ej47ZY69s7X9twXIdr3zujg89BUwDqRYrlmzZYby8q2xjvCSLDnKE
   XBPhZRkRMhthOLHCJr9AgPJiJuckDo8UmdJpcsoFYSwDI7/FaHWyi+pNL
   A==;
X-CSE-ConnectionGUID: ZXVMapEiT7SyWZPFy+hhuQ==
X-CSE-MsgGUID: 1pInefRQQcOf/fDK/Sj1/g==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="49780448"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="49780448"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 19:41:01 -0700
X-CSE-ConnectionGUID: Szmr9qz1S4qTRWkuhGTYwA==
X-CSE-MsgGUID: gwLTVmg0RRKcK0lV/nyBfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="140558772"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 19:41:00 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 19 May 2025 19:40:59 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Mon, 19 May 2025 19:40:59 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 19 May 2025 19:40:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DXXqbQ1PI9B5aim+PNfM1egGY3sAhOGYDCBEUi6EVXLtMugK80MNitROOvVo0IRgjdHHT5x0Ntdd9vdaZt+VJ1Yd8VWvh3Qu8R6o5l1e/ROqox9ztisZXreQPFarHfiJTe2o41eHMn+R8rs3GEM/WCc2pxNibRy8Q0lOG+oJincrRxxEOKSY2cUf9PBA2fYZsiPqIaT153Jvk19OSiw4g8KZ2JbUvN6zMNpyTfKPBv2tr0MWVgzK9RLiMux7a4oZQlPNjE69WhQsjO0DeS4ZKSCDxEbR4NiBYWbUH5FD19eDHjzsD7JGfYbgB9Uk4nv2LU56trC53S4niJHqYOyUJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6zkYxmo38NY5oo5WUIg4k1q8rTZNgFDn9yve7UVtR7Q=;
 b=E3ePxQXIFafIfymyHFd5tP5LmcHSqxYLQW0KZi3r3m3qDSfdKuQvJfQUamE7Xi6GkegEFQtVrIVilgCytJwguSJD0MEHGStlF7DSchg1H6QujM4BVJWLlnuPfqbgHznbGGmgDiNmWeopCuV7H570xhIbSBNUjXPmOXuvUfMthDXLDSqA+KXjFoVAk9A1U6ACA6syzWrssczu8K2bZTK6fGotx1kwFAlVQIDt1SKYZiRZ03CrtHNUWwR08WLps8s55aT2HE7n2/qYpcmypFXMUzc6w+CXqbuDtkAmec2P6DYGsH8JKMsMNDlVe3D9f8SdewalilukvbSoujHurCSAXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8794.namprd11.prod.outlook.com (2603:10b6:806:46a::5)
 by DM4PR11MB7207.namprd11.prod.outlook.com (2603:10b6:8:111::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Tue, 20 May
 2025 02:40:56 +0000
Received: from SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720]) by SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720%5]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 02:40:56 +0000
Date: Mon, 19 May 2025 19:40:52 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>, Alejandro Lucero <alucerop@amd.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v16 07/22] cxl: Support dpa initialization without a
 mailbox
Message-ID: <aCvrtOD46oiKIwpR@aschofie-mobl2.lan>
References: <20250514132743.523469-1-alejandro.lucero-palau@amd.com>
 <20250514132743.523469-8-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250514132743.523469-8-alejandro.lucero-palau@amd.com>
X-ClientProxiedBy: SJ0PR13CA0189.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::14) To SA1PR11MB8794.namprd11.prod.outlook.com
 (2603:10b6:806:46a::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8794:EE_|DM4PR11MB7207:EE_
X-MS-Office365-Filtering-Correlation-Id: 6340a4da-f196-4187-5d86-08dd9747bf40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NT94Vy+FRFn9SXtARuQRmsKzNBTmDGAqPCloLgRvvly+MCkEyUKdE1KaLtFd?=
 =?us-ascii?Q?UPu5lJfUvpbSQTFvjLXf6qYWHEaEWzOz5QgLSiK3WN5GDNW19f7PII2iKQsq?=
 =?us-ascii?Q?4dnfxgzQGYWGEJbCUfn8qD9x8hK4w8CxXMoKj7wyRhaTDc3z1i6C+VnB/S+W?=
 =?us-ascii?Q?zD0rOwFt1/oaYPhSeTSdp1YiY0d/bUnKnJ8KBGZ4ga5MT3Cgb/h5k8INuupU?=
 =?us-ascii?Q?w+a5e/Z4Iugui3YCxKMu88lcQDoBKaff5/jEgc83yG4Pj35ysXaFAMO/Jjxs?=
 =?us-ascii?Q?DHBkOH76cUiEPSfLwrKEBjHNIRxyeeqmKqP9BdcZr7wEgLOkOJPE8q/fvJNf?=
 =?us-ascii?Q?N5RZCPzSSQt5aD2GDvrG25+C8DBfiB6HYPEwbrS2/B2VeaumWMBiE/kQaCU0?=
 =?us-ascii?Q?YIDU/aFCHmPDVOoPMvt7j4BKP/k/vDqsuq4vb8BrSXe+ypszunnK7K9th9fk?=
 =?us-ascii?Q?rQLYp9UNeq3zyDw0p/2p2d2uMY5YfZaq1VxR9babE8J8v/hLFg7FCwjQXRh/?=
 =?us-ascii?Q?AkHCUcE5hebLC2TJ/bQAO3HVTqSz2LcTzta3GD9P5oRx+qE9fT5j7AJz1Dg8?=
 =?us-ascii?Q?mC9/RW+RIigicjyx6OY1qZjo9AcFPKC/pLzffXZvE4y8hWF/WsgO1AY/9cp9?=
 =?us-ascii?Q?QTm4W480UxsaJX6k9sCYryCQgh5QPRBQISxbtmWmHqZJG9C7AvCRQ+WNZctN?=
 =?us-ascii?Q?OIdZnsC6R1QxPsgYas8I2YLr2sYFvtf2XwFPVyMPJByRLpBbnS3Yimc5b9uc?=
 =?us-ascii?Q?Y7y4kcM8vTrW1n7ChU6RD6/IepzJlJnhn1DYCGGOjc1oH3UM1YlJqobY35rV?=
 =?us-ascii?Q?FUElb5CTgLcrxgH14zBqNhLazIbuyebt0f2/RoVata5bjwS3joYvj+k0Hh9p?=
 =?us-ascii?Q?k0vjwK4w8S7Ka+ot6xMoGjtABVNtfaHUptvjEHZKYWAbCIjYAvHnaj5jWakY?=
 =?us-ascii?Q?4QKytEgNk0iLrZGUb1JvjR9zP+mOa7WKvkbLY1ZUE64tqYqATN5+S5gx33EF?=
 =?us-ascii?Q?4/WgMuADtOeUB75BdKA8SCfT4eDXzTlqFXTBjsax4V8RD8Zyj1ZYvfRPA082?=
 =?us-ascii?Q?tGS5ve3CxEVhhPfCy9jFsPP5y8rxBa6k1nTA51rCohxn3cDFAT5zetkpMEDH?=
 =?us-ascii?Q?DBpyEJXpZ0gw/k8lGEWB2OyK17tKN17HPGyrXrV4dIqzYl0aZ7rDbBhOee5M?=
 =?us-ascii?Q?1fs8AbCtZrsbI5moiF7vfXanEogl3ZY7OL0qCsfts8lkmIOQdXKRoIi2jqqA?=
 =?us-ascii?Q?UG8i+dHfYKgwaTYJ69ymD7vQIIywa1EHRdJpjqAGE7RtvI/9N5rZVUO+5DRQ?=
 =?us-ascii?Q?LIThr09oJH9wXOqC6bj8dFzHEIB6ufLcoRgSzkP1fFF82sLG0i2m8J57kb1A?=
 =?us-ascii?Q?gnMc40oKpZ3noMvzQuCogPoLDtc2QU4aXHXi9rj+/A8qnoxL3kwR4gB4u0Ki?=
 =?us-ascii?Q?J4XmhiMyouw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8794.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?chNih5OcAIzFLAaBAYGyjrqb24q7WaORpRv2epNpPPc/jTMu57AgHbUJ5tpy?=
 =?us-ascii?Q?kAZIj4qsMFGGFl5VqzKmKlrk2ZLm/gy9u1xJrlFtij7Nhk2hKNv/QxpQBy72?=
 =?us-ascii?Q?lFTs3b3Y+jHT5x4J6vMQ0k3PIfaqVQBXCike86sMc5jrLSfM17yBKp2SXmuk?=
 =?us-ascii?Q?2OLWpsFyuvtrF9uV9+PJ4appGqy5WEep8xnzrE9yFB5VigaySKahx8XMD+fw?=
 =?us-ascii?Q?nVZNhl+EASqmdtLUzwv/KguZeJSRVFGa1ObryQbkhr36A3rOfCTOx4FX3EXE?=
 =?us-ascii?Q?6z24KjyFd8cjbp/mW+Pnmi/xMYpJ9Z0KeSKlbHtSm5UnJSSYJiyQiQY83wBh?=
 =?us-ascii?Q?3KEpjb998ikeOvsOe1LcJLsr4ufHkTMmmjfzAGNp+Z3l+V7JHRnMfHl9+jF1?=
 =?us-ascii?Q?PKN9l/tXVlC21pDQtJAvDHI8nNOCona805rF4ZukXWp9qYE3jxnZo4fHWP0P?=
 =?us-ascii?Q?6Ake41tjHCXZj0CfH8k3M3pquf5IpwVH/30L7kAtvojZNSEfnTNb6/sNAPJQ?=
 =?us-ascii?Q?gVNLV2RWNihNr7fygrBD/BOzx86NqmhVgSSJLQ+Et0wEI0jB0jZsdhJ72g7I?=
 =?us-ascii?Q?LdtrIdtEZlPCxW+B6oxLTuYz2ySWJUygx1k4bk3wf7D2YXcFXUih/aAENjWr?=
 =?us-ascii?Q?X+tVu6ign7lt7gjvKcLwYzHhaXiZl99rbEZpzbDhleYUK6iugqhyjgzf3tL4?=
 =?us-ascii?Q?+0xzegQej44OeUKFc6H6gEZPGWkvJGS1Q9N+3duVQiBuasRcqdwSSuM4wP/M?=
 =?us-ascii?Q?LkVqA06lKm5tfQwRdh06/81eqK5E+fl9KtInK2tYYNf6WUfvnMlHIHbV/kFx?=
 =?us-ascii?Q?X/Fobv49VMSxzlVIeKrmNyn5AgWuaGGeiplypYhAnl00vy6Wol+VRBl6oRLI?=
 =?us-ascii?Q?n5Xd1njH8CGYGwQK4Hvg/OgdkkaWXCb6bIIM6R5XQfIPPedneTK2+B8eiOpk?=
 =?us-ascii?Q?cBMRiuD/kEozNLon2dhPjNaunNX6K0E8UuRbDUrNJ29LN5dWA1od4oxMqj18?=
 =?us-ascii?Q?CUqwt9YPcGtrxWYxlHrwVdXxO6udrebQL6adhtDCH47emzh7xb3985wnXHM3?=
 =?us-ascii?Q?YIk1oCQcnJouOgLD4nRafPQ87hEVAd/WjRESqMvsqFVoPGYrVTS3q604XeFn?=
 =?us-ascii?Q?y+izU8kxpb+E397CaVW+JIo4eaLCR8oVTq4d2NfutCPvx3nBmP8aarTDFrNY?=
 =?us-ascii?Q?L1oU9Ole7cNQkzhPFSXg8Jl6aE+Q3X426/VQWN9y8EYmobQyQ+P3YaB6OLKv?=
 =?us-ascii?Q?F92njtcWt3L2aHLkWXDB2H2XU/azp8XXZY/dQoea4aA/n+kWldjGxAh1fhPj?=
 =?us-ascii?Q?9MiHgNkcERKqJQ5z17TbxbckQqRthGkXxe6gyUklv7GQ0LLI1tspaQParE/r?=
 =?us-ascii?Q?sVmOS8fapXJVNAYM6ru918RX85+Ie/T9znyiQYvKxCLYq692YGS4TGUAoABp?=
 =?us-ascii?Q?AnQsa9flAZMrD6VtnQkUBb+UeP+QZODb/3VGDNjBcPqNfXChCo4IyRlL9T9z?=
 =?us-ascii?Q?1p7FJRTvuSeA82zPKtzvxdI5pxtLuZTszxZaBEhIdmXBlEF40V9dFTRztrjT?=
 =?us-ascii?Q?vD/HXpvffTvrpmrhkMnNSFAjyzDEl2CofCFg3tcgV9R3jAmjQhkz5IYX4cSK?=
 =?us-ascii?Q?pg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6340a4da-f196-4187-5d86-08dd9747bf40
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8794.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 02:40:56.5916
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: swiwoRh4+cgaOQ/QXXSTPQc+lhoAXVY+suyNhFgk8ZfNbawh8v1bFrVjRxaqtsAtfFsHARzl180jVaggNefSv12DYh3H8GlUkv5lA1l7DS8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7207
X-OriginatorOrg: intel.com

On Wed, May 14, 2025 at 02:27:28PM +0100, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Type3 relies on mailbox CXL_MBOX_OP_IDENTIFY command for initializing
> memdev state params which end up being used for DMA initialization.
> 
> Allow a Type2 driver to initialize DPA simply by giving the size of its
> volatile and/or non-volatile hardware partitions.
> 
> Export cxl_dpa_setup as well for initializing those added DPA partitions
> with the proper resources.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

snip

