Return-Path: <netdev+bounces-188833-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61045AAF09E
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 03:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54ADC9E1175
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 01:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544B81957FF;
	Thu,  8 May 2025 01:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l7FjJXFX"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589E63FD1;
	Thu,  8 May 2025 01:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746667547; cv=fail; b=ri/k6wbrvQw+oHvN2aLaaMVhxOX7Ti1C/yJaRJ4yseDRTdcJw/ebrIpOW5EfyJ9Z5AFLwy1IGd7EfXknj+ON94LW8+UbAk49Kh8HJHl+wwAFutjuDBWoD6fJfApcpnfMETUYlQQ7eRJkEqAh2KaioCIOZeMiCSDElaiUaw7kPx4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746667547; c=relaxed/simple;
	bh=jpMha+foh8mJgP00TYa7PsHmfY4W4LmYCavnQZECMzA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=imqb/t7E2GVIE4ZjICwAgVd9NuwZI6SmfjdXCNJmCajhHuuN//4YMu8vkxEunTVn7uCoqq9rgBpnDwq3s2VvTD+Bj8domP95KGoohbMh1E4Yf1dNKEITckHszylFWKMhkO34w6dgBk86D34qfAOJ2Uhp4si5+Vsdi9+dbOA7I6g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l7FjJXFX; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746667544; x=1778203544;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=jpMha+foh8mJgP00TYa7PsHmfY4W4LmYCavnQZECMzA=;
  b=l7FjJXFXyoO47ZrWJ/I7TZ0qmQEHLAu7qhySFzY3snft25D8tNaOUOGw
   athH0VqVsfWIxV9dqscQXxNCaP2dZhl4FjwVCEqB/lTLcJjkTzTDwgs3f
   wpIyxDbwCBNL+AeVOG/WcCgIw3ADZgsqewudEU4h3URnAJkYEeKehwJkK
   MJuCNbK7bPMhPrYGGS/vNHnrYHm7hcojaohINGqFZ+b10jPA+4yjRO9Os
   UHrkmhV+YSJ9PNt6JlHe8+PzDgASE45eSmjlEAxzWXsAoLshK7o9VNX7d
   NrLb/siwnD6SfIve96gD7o/hlx3+SopOOJDbsu+7E7A0+L2liuUEKrD0U
   g==;
X-CSE-ConnectionGUID: 6l01x4EfTPeliFGqfv5ZFQ==
X-CSE-MsgGUID: SBvOvCftQm6TuNC/Cwtffw==
X-IronPort-AV: E=McAfee;i="6700,10204,11426"; a="48574290"
X-IronPort-AV: E=Sophos;i="6.15,271,1739865600"; 
   d="scan'208";a="48574290"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 18:25:40 -0700
X-CSE-ConnectionGUID: 3xRcRXdZQL+iRdGdxsVINg==
X-CSE-MsgGUID: R8ZDc8BkTN+IWN7rGHGt9Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,271,1739865600"; 
   d="scan'208";a="141091512"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2025 18:25:39 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 7 May 2025 18:25:38 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 7 May 2025 18:25:38 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 7 May 2025 18:25:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZJvPXgbriCPR4zS/U/42TIHAm8W22NxGUHrHa3wE5L2+BiwBRJbkvT5K+qYQKd4N0DIHob2LxKJhnzvfALsdivG4iYbBtx0K/3zO4uKJHhBtIu2G9Xdv54dKzR+5yZh68zkzSP7XLoXavGTwWSeo4iA2kxTAR6+Z7W6fAWMR1s5bK0KrbS5emHoZyo9qVKYsDb/7nsiYATxcjAo7WtBI/pPjAuI0gcckyK/Zb0CcY0pyz5OiAOoYMQgYLfWUmEZnF9jKsJHIyjyAlN7kBTcrZOjQz2ep8k979RG52ZF+vwrfxuc87zK5rhoKjboq6jf+HjZXgWeNPdABJ/uTJ8Wv3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W8KVg/XxlytK9bMF25Efi5VTzwjBzLrJHcQu++5Wxus=;
 b=kVSE74+lkOsWKP+r6XV23+bnoGJbo/djXkmGc1zgxS6GoIEE1DQEyK+5uNejvH2rUrzYJnoK/+QlYg6K6gZYncPtNF7Y7dfWVtjIfj8/56yM1tzRWaJIr71Vh/0aRYjaIi8O5o4tHwwotvkwlkapUp8bnjM8+2WihJ4sPp3Ux42EYEA9IJ4/gfQVmLKe04wpVXDSSxpr0lsqpvA8+Oy5uQGv7JL0ox8MHRSjM/XjLywvmPX1VgqM1JcEr+1aQ4n0sX1lXgZcu1mn4ogAKhqXaRneGlmil47kF/DHkqbRSp52AZxspOg6+gUYJb5uOdZafjjol9tKiTrVGfKXba6lkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8794.namprd11.prod.outlook.com (2603:10b6:806:46a::5)
 by IA3PR11MB9208.namprd11.prod.outlook.com (2603:10b6:208:57c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Thu, 8 May
 2025 01:24:49 +0000
Received: from SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720]) by SA1PR11MB8794.namprd11.prod.outlook.com
 ([fe80::a3d4:9d67:2f5d:6720%5]) with mapi id 15.20.8722.020; Thu, 8 May 2025
 01:24:49 +0000
Date: Wed, 7 May 2025 18:24:45 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>, Alejandro Lucero <alucerop@amd.com>, Zhi Wang
	<zhiw@nvidia.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v14 21/22] cxl: add function for obtaining region range
Message-ID: <aBwH3UjxOpJel_xh@aschofie-mobl2.lan>
References: <20250417212926.1343268-1-alejandro.lucero-palau@amd.com>
 <20250417212926.1343268-22-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250417212926.1343268-22-alejandro.lucero-palau@amd.com>
X-ClientProxiedBy: MW4PR04CA0034.namprd04.prod.outlook.com
 (2603:10b6:303:6a::9) To SA1PR11MB8794.namprd11.prod.outlook.com
 (2603:10b6:806:46a::5)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8794:EE_|IA3PR11MB9208:EE_
X-MS-Office365-Filtering-Correlation-Id: 111889d8-a2c5-4f4e-5f21-08dd8dcf203d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8UPg21hnYxLxgaaA1wXiupZNsZBcMFVaScIT9FeXlcpeNqqvSkKW6qLs78vc?=
 =?us-ascii?Q?EzsaGrgucuWC1UczQ6Ilgsr+LOvahVGZ4monVg9AiP/6CAom+WPVu/T1bUCZ?=
 =?us-ascii?Q?W2p9xciUkc/2+Yo8lWPiMXym2757wDD5ELs0pBvRqk9/WLs2JmALceTcHWzd?=
 =?us-ascii?Q?eoBQ9MPzA59Y3lrqY93YZkE1ZtxMbXurhoEofAHKqXodGGuQwEu722Y0937J?=
 =?us-ascii?Q?htyRrt0s7ntnp77gnckL21rA7XP7SDBB0e9lJ5r/1iuOfK+PiVMtc28KdhmO?=
 =?us-ascii?Q?+yal+Q97Mnql3YK5jqvMNTbkVjtQjy/hpOTJo5BbM/u68KUTRXAMl0NQRNO7?=
 =?us-ascii?Q?kew/o3U4eTzt6Y05sviP9lorbA0d/i9ADDBgZIs4J6AAa85M8ULR/EVpSvXm?=
 =?us-ascii?Q?AVEckan0fDnX/khHWZjjyqnzPPQqow6T3BzsSvr/lAIZI3iNqbbMtNAWKMee?=
 =?us-ascii?Q?iL9K2yzdcZb7/lkct/50zsbM/AS8EaxFU4hKnoVM7KwAvROu4P3l+ubKy6wg?=
 =?us-ascii?Q?TlKwfG2wYnWS2BSI17hYi93v3LtmTAWyhi+ABN1YOjQaGGqSmCU1ue4D9aQJ?=
 =?us-ascii?Q?XoNOvF+dTUMECtOhnmFWQTiV8gdpFFEglKlYEsCiKt7PFYqXLsiOyEBJy5Al?=
 =?us-ascii?Q?uisxcYjb8w5wc51V5wuAZU6+HTizd9Rr43Bg2TE5Th5VW9hWWsIXuuVQ7iDl?=
 =?us-ascii?Q?L952nh5EjppFSsgROk5RbOX60yZHMm+LNn7mmYzhFpN9W6MnIOBkktJj1OSG?=
 =?us-ascii?Q?39d/Q8wyRP7bZqCazxE9/adxQ7jwvtru97haZXjBHJUkDT7tUdIXUA5YD/xb?=
 =?us-ascii?Q?WYqRPfgvyLQnJ/8eYg9ZpRM4ObQTvFWEF4ZOAbJEXNocMMGNWy3J7rOsDxn6?=
 =?us-ascii?Q?a0iZAtZKxbcTPwc90xFCHc2RcLg6WxGs6Wrigbr+Ay3/70a++EhGCAKuRPML?=
 =?us-ascii?Q?0WDz+4xYxIU9uAwPQiy4DnqxdxRkAuHDVjDFWzg22wrjO0xt3HZT1TPpM5KM?=
 =?us-ascii?Q?VYa4/nk7HlWTo4AI0rcocDUtY/ILrbTxNnNlahW51GHpXIIFMOSteewPa1zQ?=
 =?us-ascii?Q?mz1Cqxy0BFpk/26WGwQnt154b5JWDd2CbU6jPiEhaTrCRCbKqizbnNw9WmRT?=
 =?us-ascii?Q?kIR1cbFTFeVivU/0F0I+tlN8np3klnHpQ1kM2JtNyf0FIdIe8CYnJfZxcZcQ?=
 =?us-ascii?Q?DOCx25fbzunHkVWcoF+dAqFsA2XDTYpZMt6cMyVV+x2qEsVxTG+NVvdrVb4m?=
 =?us-ascii?Q?NEgYP71JyzP1AD+GcYUcG65CujwsAeP71LRwd7uhmJZXIcwt5Bbxnxzvh4dP?=
 =?us-ascii?Q?aZgZe5PNinBo4ComWw6QlsNyGqutsv0jClnJBhm9j4h2oJ4ehPFxkRXmYKN9?=
 =?us-ascii?Q?S5qZvSJ37fN0Nld7BZWAbMQyiknO2qxWZygk/O/S91dVhwWN+THPeAEUwqlZ?=
 =?us-ascii?Q?Xk1QuFLwncY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8794.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KUauVUC2tJ28z6E2/fAMIEECyDgrOz2fvehu9M1hWmPVr4TCeAEeTiDiYUf/?=
 =?us-ascii?Q?wylyTXuc7K6ln7s59WHfgY7jxJae7hd6N15XqlcXMLD1XfnvInztw7uOxaD8?=
 =?us-ascii?Q?BUv8KmfvGA21HRHT537fhNJNTW8lI79VLY7JzY9dWptzERF0bp9TP/5+0ZHN?=
 =?us-ascii?Q?IA5sYSPA5zLFf+Dyso30I2k4YFSHbbD+XQVwRP4L2N2PQ76X1Gx88oUQFaUQ?=
 =?us-ascii?Q?LZ5ncygA+SNFd2CtkYovICI+o3q8OwQ/K4KaIsRw6L/YtIl6b6aAoOGV5qm7?=
 =?us-ascii?Q?WSFRFC+gD833ms6J+VP6CBCC5mgKN+0ls3hx9xXTe16bu0xJD+wZbhAVdB2H?=
 =?us-ascii?Q?YdhzWCRlObOixLx+0uYMUohxUzQjF3O7PclGpsILt9FTYq5hvvG77fvrCoCq?=
 =?us-ascii?Q?Re7NPDgbRK9k+yMseBKbpNIZ7uk5nLP1rxtMkTcbNw51vRWhtFhxsc5t/Z/Z?=
 =?us-ascii?Q?r3yaloReXKyCEzV7qdWAhvKcHp8kpxhJbelX9Fs5M1fmgNN8wP/62rEhrcpB?=
 =?us-ascii?Q?xgoNPuY3XAhahHbvTlXKIZ7LS/emDtrAPOoWrviOppnjRbbAu3Ik/wiu+lzr?=
 =?us-ascii?Q?25xO3XegfKbgPF+no9E+MpbXgnHUKteQxJinu0BbgPSlygkxL0hwgBZlxq2K?=
 =?us-ascii?Q?7FDbh5B9UxxWnZBdVm0XP66agW0qeEVvAio6I4qWAX6KpNwI5yW6H45ddECY?=
 =?us-ascii?Q?7HI2WFdy1vE6NFyomZV16qGV6UEnm0EIZfvtv6UIYI/8XbuNswyGWft0DHk9?=
 =?us-ascii?Q?VnfPqGlNqBviuFB6nnlSs9u7BqFfd7wLLjMs7KM7dRthuzGQAAqXa6Xaz18L?=
 =?us-ascii?Q?VEEE9XIHsIm2mqBAgdn8UwVWUW4VNpe+1sR8Mcr36hgKlh/HDRMraUAUlWAR?=
 =?us-ascii?Q?eEgxCjCUHEDunmwMkg8GmMNLweIqOFhJqfkI86POWocigDmP4FOcb2T/ec/V?=
 =?us-ascii?Q?49KJZc5IXwe5joCpMlfFKcjMJs93fwik+25fbg3U0o99bF1QXuZyGdRFhYVS?=
 =?us-ascii?Q?CkgvntHt+uwWsCn4XUHOSfNEXxRPlumxRqP1mF1OkdfxX/L9pb7MaBV/KuzP?=
 =?us-ascii?Q?mj3vU490entnsr3JPcbCg8ZhNgu+xxQ2M+/1mfbkJ9b8StYh9jWPIZN/sbdQ?=
 =?us-ascii?Q?A5uk05t2P+jIcP7MwG3punR6KWGKf86xdWqR8dq/zTRZ3Dm1ZHVYe8/iedpm?=
 =?us-ascii?Q?fP5qObp05c6/Z3hf3tGvHb2xvA+Wpyaa5CJx2TLcsQlv1y06zIHSOd9mzvOd?=
 =?us-ascii?Q?Cbwa/nW+xZQXwCGH+90qDhPos5N/n3V9d3rTOhoBotkc3QBAQSVI6KteOso3?=
 =?us-ascii?Q?sTPhmFXCTRwZ6l9nTLnrALANL5QoQQ/8VfbMXG5GdPrkNobuOM5MRTi+6H/p?=
 =?us-ascii?Q?odHv3kXPWpvjSsQMU62LNOFdJYmZs0wvQHGQmThVO2NjpIuEHA6RcIPXk6P+?=
 =?us-ascii?Q?oQeSPLmrVFOEPtzGSOYjwUZDbUBv4pKA1axzY/IVOiBUgq+lYBEdoU1DBMl1?=
 =?us-ascii?Q?hz2QKIn6y1c4w8E3D6m5ihRYX3nXQA5FlnbPJTJCZuP5415bAai60LRIOCzO?=
 =?us-ascii?Q?wViriC+zv9dUstg0P3rm5SSJmEeudyg0BfcNMKlaVfTM3VgznhTqhaLmg16M?=
 =?us-ascii?Q?dw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 111889d8-a2c5-4f4e-5f21-08dd8dcf203d
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8794.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 01:24:49.7225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EkrVK4LyYdNIWYqidGjniEj6xvFzUANajQJPwl8npB8DciUGXEbYyzGWHN3L6RUI2SoA0hYdWBRq01qQ1zL9x3Hjw+laKL10GJMEWNjhXEI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR11MB9208
X-OriginatorOrg: intel.com

On Thu, Apr 17, 2025 at 10:29:24PM +0100, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> A CXL region struct contains the physical address to work with.
> 
> Add a function for getting the cxl region range to be used for mapping
> such memory range.

Worth adding that it is being exported for use by a Type 2 driver.

> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Zhi Wang <zhiw@nvidia.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/region.c | 15 +++++++++++++++
>  include/cxl/cxl.h         |  2 ++
>  2 files changed, 17 insertions(+)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index cec168a26efb..253ec4e384a6 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2717,6 +2717,21 @@ static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
>  	return ERR_PTR(rc);
>  }
>  
> +int cxl_get_region_range(struct cxl_region *region, struct range *range)
> +{
> +	if (WARN_ON_ONCE(!region))
> +		return -ENODEV;
> +
> +	if (!region->params.res)
> +		return -ENOSPC;
> +
> +	range->start = region->params.res->start;
> +	range->end = region->params.res->end;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_get_region_range, "CXL");
> +
>  static ssize_t __create_region_show(struct cxl_root_decoder *cxlrd, char *buf)
>  {
>  	return sysfs_emit(buf, "region%u\n", atomic_read(&cxlrd->region_id));
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 5d30d775966b..2adc21e8ad44 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -271,4 +271,6 @@ struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
>  				     bool no_dax);
>  
>  int cxl_accel_region_detach(struct cxl_endpoint_decoder *cxled);
> +struct range;
> +int cxl_get_region_range(struct cxl_region *region, struct range *range);
>  #endif /* __CXL_CXL_H__ */
> -- 
> 2.34.1
> 
> 

