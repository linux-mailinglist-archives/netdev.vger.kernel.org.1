Return-Path: <netdev+bounces-192419-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB2C8ABFD05
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 20:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B4931BC1CDF
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 18:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A09B8234966;
	Wed, 21 May 2025 18:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Oj1oOvlr"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4BD28150D;
	Wed, 21 May 2025 18:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747853407; cv=fail; b=EUgHngk/5WvRsHvmCWAnTiirM9FJzQclfwDN3rRD0b+rT/aae1TsPUNoXxGVsUyGd+jRa8gvZl4w9GumuzNzgN8ijzWWfe0MZ03JTQ/47hCB+pl8Ld3s+kh1segtg9teSk/9iyZorrO5R1jdnyMHZ27D+lZHGj2lgJqchZPYIWI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747853407; c=relaxed/simple;
	bh=X6CnG+mPirm0pZzUwHmFvW5p3AzqEDe/lb0XPIYvFmQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=omsjs2cTlVxioVltqNy5GmZngmbizgkfO45Jp+HtehVtjF8HVHkeiyIoTfYyYYjAeTtq6tUthAIvQ2LsgB408JvduoWpGfFVzo28G5kxl8Yl+6OK2sKwLXY4M+L+32A6xJLBjYojdWK0TvR0z8jZAvqcBOCDN/ESAc3mtEwYoHw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Oj1oOvlr; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747853405; x=1779389405;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=X6CnG+mPirm0pZzUwHmFvW5p3AzqEDe/lb0XPIYvFmQ=;
  b=Oj1oOvlr0gIzp74+2mA622rVX9a0UumBvm+fQUuBopwvXZYk0eOWKcqF
   oJt23XyspzBw0AjYlYBXOZKTemR7FTB4lXSbyJAaQ4Vprdf3K4e3teAVn
   3EFaxQLJUF+V0j/VYmSMAcYkfQYHYB86M9r9Js+L61xl7U0HD96oWh1ox
   YWjWo9B/RqPhmhV3oUC6lB/zIoc/KLLUTm04AatFWhKFKWNRzSk56y69n
   OqYFkeKizSPoEtg7W7GaEc93ekJJpM9y713wuYLgOCatoVY+rvBZOtBiT
   PVGOYnmbKIc8a+EmRu+C3ANi/wpwcNxyQJ+3aHJXwlLKk/rC68H901e1+
   Q==;
X-CSE-ConnectionGUID: NbJvTV12TN+DiHgsMg77JQ==
X-CSE-MsgGUID: Ln8xr2FnR8GiVlByNAmBkQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11440"; a="49108311"
X-IronPort-AV: E=Sophos;i="6.15,304,1739865600"; 
   d="scan'208";a="49108311"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 11:50:04 -0700
X-CSE-ConnectionGUID: h0hsL5uLTC+cbkH94cukuA==
X-CSE-MsgGUID: zO1NG6WgR3O/c56NPGi8PA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,304,1739865600"; 
   d="scan'208";a="140047492"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 11:50:03 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Wed, 21 May 2025 11:50:02 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25 via Frontend Transport; Wed, 21 May 2025 11:50:02 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.55; Wed, 21 May 2025 11:50:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eSAFNDyvrIN/n8OmMRMY83hWRBLYTtidFsegSGZWjWhmMwEb1hsNWqR9EXuRrIjrf0tFi0LyZ1Xo/mi2tY/xdfRZVQSXXH4aEp3k8joA4ftt45UjkfnRJ493LdLJlKV0hK0yest81Uu35mo4U5CoCNxio3jNbykilT/YTQnPR6k6dtnJS8QNc+piTtRlg9B0EN4N9KGhrmliszHBUTDU1QpXP+sbIZpKjkJN06HDpJOh56PWzuQIH7QZZkagF4iqYs1yTH9cJW8s8p03bErIBYrIS7E9FgYR23sUo2cSAJDCImmWgOyDm3/wlxwJKx/97zAYovIxFSbGuJ9szGjaZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FsnyLZeOMB29qIlqU3z9tvBWr7I3AoCLWA3rc7jjK4c=;
 b=IZ7XkRO5TWYh2uyMMtAOgS+c2l93o0UXP2SdHGll1ItE1chpaQ0chQnCFbj6Y1pyTr3pdzcMFsHasI2yP1Dxs/8WDkxeTPi0bfz7atR/cG6A0Zw0mht4lk9hn6LCOmI9/3JC8xqD8o3vstcIi5osXxsMM8TstgpZsAJYxGplOQMBaQj2yJNp+BBI9CUmO0HOg1ZmH1OYBu2kJgFND8aLzcrG24Z+CX5z8lhThBMXRUW2nv5zSqzC9ZWXnohAFyMGaEX/Hp0e8wKEdoyKKbbEUR8t2XV3tFw9QVG2R+0oES10J652Es7Ko3fRKxWz/c4/bRW4iuZcc7kJChcu1csBQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ5PPF09F392AFF.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::808) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.20; Wed, 21 May
 2025 18:49:46 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8746.030; Wed, 21 May 2025
 18:49:46 +0000
Date: Wed, 21 May 2025 11:49:44 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: <alejandro.lucero-palau@amd.com>, <linux-cxl@vger.kernel.org>,
	<netdev@vger.kernel.org>, <dan.j.williams@intel.com>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>, Ben Cheatham
	<benjamin.cheatham@amd.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v16 09/22] cxl: Prepare memdev creation for type2
Message-ID: <682e20481eb60_1626e100b5@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250514132743.523469-1-alejandro.lucero-palau@amd.com>
 <20250514132743.523469-10-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250514132743.523469-10-alejandro.lucero-palau@amd.com>
X-ClientProxiedBy: BYAPR08CA0043.namprd08.prod.outlook.com
 (2603:10b6:a03:117::20) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ5PPF09F392AFF:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c74b005-be52-4d93-5b3f-08dd989841b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DWmudlsd9gXTsF6riwfAdwKMmVt6NT8MVGH5GcWxwzsK+EtbWmRYQb40O0wR?=
 =?us-ascii?Q?5nqC7E7k04qvM1jAVEZg+Ls0UsiTsBhPxrb5xPd8ZeWBh+xFmS7/PsNUrU4R?=
 =?us-ascii?Q?UTvi5WKT9O4FP2sji0hCys98Paeq+eTgk8OTYJPDqogwPNIIYRXlWuc6uQxh?=
 =?us-ascii?Q?bOrvXj0fVHOR1PlrjDxaKWaCtq8ybrHuE4QmFeU5lcDJ2OFrkdqPPo0U5XV6?=
 =?us-ascii?Q?T8X85IRrBVUmTxBHbqRC9GReXYPdzPpXpnD6vhuadXWB1Ele2FcsqGQAmMtx?=
 =?us-ascii?Q?6xPm9aJmq+Gyjv9tYlKgLws8NTJpRV6mi5FIoh4J1yw2IB8LIc+C+QD0twDC?=
 =?us-ascii?Q?l68ZPhxjRNKh/DLMxnw7yRWC5en/MQCTB9dmOsmD/zbMUOG9uo6hpJF6RjhE?=
 =?us-ascii?Q?UH0lj5qN8gtj1XZLDc32Vp0Uj5rWIt4JhQ3d+aOUAfJihouZYv6A5OJR95Ab?=
 =?us-ascii?Q?0fcUMCV7zhXprC2+eEzUvjBBE/Y//M7qMG2v14siNdPQTMWiVDGO5UutYvwV?=
 =?us-ascii?Q?T4tAMejgX/Sa4j03nu4cgExBF80+7c53vf7HQptp5SkrFpLomzTRQ6iXnAfi?=
 =?us-ascii?Q?N+KVcnIDt4E7uhcSqnvtL42nzwaqvQWnRFfciOzZ+PEL7jpHx4X3O9rlmhQ4?=
 =?us-ascii?Q?/RVS9vtoMSaJ4mcDPIntVtGz8pIUojq/d18/fNbtdpmzZbCmwv5rPH8VQeiO?=
 =?us-ascii?Q?wN3eU6vVATwKB4pmOc5rXcIhnYiG9DywKO7eAsbfThKMrNjCH1M1/Ohpo/UD?=
 =?us-ascii?Q?lsK6AqdFGfX3VD3YCtvJYzKUZtYyBtLA/vCy8PkIxReS2hhaJolOa83b1y13?=
 =?us-ascii?Q?58t+tBNNjw1GZjFW9Kx0nu5gIPqeZnq36zXl6Z6khAH+VDMicXnthQZMOlOY?=
 =?us-ascii?Q?aIvGLhP02C6YELqThm6KpoJl1p0EKRfsueXNAkQC89zyOOLzCGyE/p7hup8L?=
 =?us-ascii?Q?JuX7kaECcj0HmldzXvJo1W16wrieFeednfhSKPlVwokuYjL17bkr/QPaCYV/?=
 =?us-ascii?Q?eD4goU8D1cyZ2W2lWiKjpr3RBs3bqU+4PcOLzn2zjAq6hhOS0stFa5zmsKU9?=
 =?us-ascii?Q?k9KxE08WaCkZhs1zzeM6ylLpzxgz/gM+AwLhMXvoaBn19aPyHz9qnP2fiqUN?=
 =?us-ascii?Q?dlQZEWFBivu9iM5YtRnRLolEIvM5j4aNy1qPOHXMFD8TD/BNJd2d+EM6/0vN?=
 =?us-ascii?Q?ppKfr8h79XArsW6SINA2jpzLa2xheYtkI22UwQo+3k7XjnaxNQgwCfD9qYw0?=
 =?us-ascii?Q?5OkT6yqWMcyVt5oC+BAWqtvYfVkgicF54shHAAJpxeIgbqjoV8YHKwJWCINU?=
 =?us-ascii?Q?9lX9/CkLa51sSpnN+jTKS/Uy2hg7Frl4bcGg6sZwJek0SgQTMnDxrFepohTT?=
 =?us-ascii?Q?z1Vy6US5EYcdqltnYZxu1pogR5I6GYh57V/JQu9Lxj44P6nqdG3wOIOkEE7U?=
 =?us-ascii?Q?KAVOQPMfAS/PCK33IG+c8tkJFldFlaeI75IUj3CBWCmHF3At15cJVQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?E8FlSzEd9M5Eap27i27lGJCW63TSqr16JwXCoxyPJOWcw6rWwUgjPfaB+wQb?=
 =?us-ascii?Q?EstmIabvAc5nVjlTRyq/V4H+Wtevqjitn6gTx3+rh+uCmNItlntNu9CHLeT2?=
 =?us-ascii?Q?4Ul8VQdduwAMJ6psMD1m3rnGrxoyTLK35ipDXm6uAAkY80/JRZr3S77bPOjF?=
 =?us-ascii?Q?sia8X78kNtQ9Yajk0P/kHd5rx6Tz5m3M9yu6BXMs4Gn1IzVlxzxUIlwwJvNt?=
 =?us-ascii?Q?Cc5K/NZrhEIV3DDNpYXr5AaEg1CXRGEYsSKwx8DiR4nFUZPMsxlV5y6+U1rp?=
 =?us-ascii?Q?nnYroLeEix7itqGNc4JoQL5DbRO9OZnhGkC/h85CnptH4cAyNbYZrLf6wkG8?=
 =?us-ascii?Q?IOLnANXCIaBzqf/Fya2A1t/bAT8W0buUJOjRcy9kBDmIrB8pE+TXE+jAwyE4?=
 =?us-ascii?Q?h5Umrd14VBqT5sDXEuV7nVa+w2Z7ZsdXiEBK4bSkte80SFbqbts3MdkVAfJb?=
 =?us-ascii?Q?jaF86WFqYKUvaAu2Gaf+tJEgiRBG4Lq2IznqibhryQ8O7a+eZUQPdaAYPWZy?=
 =?us-ascii?Q?FipWH9/8bJbT+x+/QixPZhCqIC8IMFXE6HmjoKALgPPVw4dREySWIQnces4X?=
 =?us-ascii?Q?yosNEnUSCwYifKXstyEif1SZWGCgpq8j2ZBAUpR4A9EuS3SZHNPTYHAqkQHo?=
 =?us-ascii?Q?exz9ubQ3P9vtgC9QPJwGOSKLv2bcw6BCVDD/Vic8hzEs0rW2NJeJHKo2EOVs?=
 =?us-ascii?Q?Ga0NDWXM+Y0JeDwsWm7ffKZCxwsp8DILP0Yx9ud8rw9IyQNfEA2MunYWEDkk?=
 =?us-ascii?Q?aW5youdiw3044volOUj3UNtWrCN5hbMAnhGnjdc3EmG2/LoByOMIfFt9TprV?=
 =?us-ascii?Q?CGZ7onaeiVRV1lQn4cK5liLcd3GDJxDF0GZf71sjEQ6GOy1SuwuEsViOvbwH?=
 =?us-ascii?Q?M+J+pax74mpRT/RJ92sXma6twafpgpCRU4TRUFZeBzXzBpbc2ILJUWF6uVU+?=
 =?us-ascii?Q?KV6PEu7FdzOzfyKfpy2iyhvlK2l8V6+nBSlO9xaHk+69RPsWwn4tkirFIvsw?=
 =?us-ascii?Q?C22K36z+BTdSLYxGKdifi00SnSnJ5LEb4WDHaka+jiUw00e9u5GBbk/s3Phr?=
 =?us-ascii?Q?O0RPKjmgcoJOdNnNejTZ+dcQmEARsfFrXjK/cVa6gEEKOwdeSjb8S0eiJEgB?=
 =?us-ascii?Q?KkMiqRzYhztHdKYWZfZN/YZFE9feHbX8AAcbwWElMSUMYnk1A3jWs56PRMXx?=
 =?us-ascii?Q?aaOqqcWckyBt0Rw3QVWr6iGQCT3ZqITGpjkZs1gM78IImRn4LA0uuldvK5Lj?=
 =?us-ascii?Q?KpCDlAMpg9YjSsPWXz1YfC6Y7dHGdGbz3LimH7lxx3Oa6zLfuVwHeEz/8o6s?=
 =?us-ascii?Q?CH+JFX1e1i+dWEiaRabXeJurHKo90Y4ahApdeXz1gYrtxrhkGmIL+VMAbENp?=
 =?us-ascii?Q?YK31pcOpwsVIlB82IAx3vZ6EUbrOolffEtBYHcKa5sozIDoXdyvXUOcDwpZa?=
 =?us-ascii?Q?nBAi/xpYIkUh4VK8EkZPNu0v3RPkj2cA416lUiMoPBoFPeMEslHwwJIRvgFI?=
 =?us-ascii?Q?emz/yHZLYU2ECDzyZkE8S/hUt/fUMutymIPGbAWfpgtiewhhhZwqubve7kPu?=
 =?us-ascii?Q?tweVkhcLJ7s8RPEDLTp3og7MPPLrQi670VfkWmQcNfVIxgL02uGvEnm/70Af?=
 =?us-ascii?Q?XQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c74b005-be52-4d93-5b3f-08dd989841b9
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 18:49:46.2885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rTN2J7PDTZ/AkO7eZ98asC2wj0AfQ+zd0YjDveCHrj7PxmizpqOSEWdzz+19HxRkJldmeOH9++jVMnBuc+ZmienuXsZAFZ4oE79nc4wX+Kg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF09F392AFF
X-OriginatorOrg: intel.com

alejandro.lucero-palau@ wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Current cxl core is relying on a CXL_DEVTYPE_CLASSMEM type device when
> creating a memdev leading to problems when obtaining cxl_memdev_state
> references from a CXL_DEVTYPE_DEVMEM type.
> 
> Modify check for obtaining cxl_memdev_state adding CXL_DEVTYPE_DEVMEM
> support.
> 
> Make devm_cxl_add_memdev accessible from a accel driver.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/memdev.c | 15 +++++++++++++--
>  drivers/cxl/cxlmem.h      |  2 --
>  drivers/cxl/mem.c         | 25 +++++++++++++++++++------
>  include/cxl/cxl.h         |  2 ++
>  4 files changed, 34 insertions(+), 10 deletions(-)

Makes sense

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

