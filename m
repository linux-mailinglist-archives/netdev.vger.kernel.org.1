Return-Path: <netdev+bounces-130977-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABDF098C4F7
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 20:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65D492824BE
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 18:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A7B01CBE9D;
	Tue,  1 Oct 2024 18:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IGT3Us//"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DE81BBBC6;
	Tue,  1 Oct 2024 18:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727805623; cv=fail; b=ItO7QNlJHgWwwAatpgQe/fQ43JdrT9TupG4aobzBQ08nvBPV58XfqEUCi7sFqiyPzH2wBhkcTYv+tU10iY2k0mThxg/MDxMf4ZGk0MnvzEUT3mdVQQrVR762ZT7AnhngKPHOSWXUoZCzL85Y98EtFFLrZutInDdD8J1n7zyt7c8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727805623; c=relaxed/simple;
	bh=AT4wX1SJ3gYLfKTn5z6jVOMiXSw3WcNuVLKexTvJ/7o=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Jg1OkrND7ZqE9F15f/RrXiC6V6v/eB1G2WE4X5LiNPOHW+DVv0Uf+NvJAo/0DcYB2af30SSMWLnT0fMuIDBXtM2nLxmQb5MllORzfZr3YrNCVM6qPBjSayPuYtxeyPlogm9Vh1tlSY5ZKM7+7g/z1Wd/Nmkqd9kBJXY/4R9GvQY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IGT3Us//; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727805622; x=1759341622;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=AT4wX1SJ3gYLfKTn5z6jVOMiXSw3WcNuVLKexTvJ/7o=;
  b=IGT3Us//l4Zu+rhokCy4BtyZZoqGRJHI5XQXjQxVfjpujGe/5teKcux2
   O2xWMg1gmZkF4jKad3Bcw2hNK++evvj+bhP6De2OzV0GLyAfnGEHA1djh
   BKthWeUNdepInv1GAcv0stSPZEZELJ70BDXjsgtKvWmOMfhqWOXsu58v/
   p4zWlSzlDn+j+HIqViTDT398KxqgpIRdonsvJDEOY0r+ZRJstyVTjBmWQ
   iqtidD18tVoVHS2Fxti4PO+6ZqCVwulkHMsx02ZlFJCjMLixSlgaYo+kx
   bWnVjuhrqjNKaXiDygIpuRZ9X848PPwK4yJpsBJ8jTFNVH2zCKfmRMfDJ
   Q==;
X-CSE-ConnectionGUID: Ilgc7gkBTpWHrWm6Ye2ZOw==
X-CSE-MsgGUID: IbAcQpn7Q8a7s6Hsitbj9A==
X-IronPort-AV: E=McAfee;i="6700,10204,11212"; a="38087847"
X-IronPort-AV: E=Sophos;i="6.11,169,1725346800"; 
   d="scan'208";a="38087847"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 11:00:21 -0700
X-CSE-ConnectionGUID: zCi+vfSVS/GdGZOzir7egg==
X-CSE-MsgGUID: JV+w2Y+mQOqYuZA9lX5WRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,169,1725346800"; 
   d="scan'208";a="73629085"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa010.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Oct 2024 11:00:21 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 1 Oct 2024 11:00:20 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 1 Oct 2024 11:00:20 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.174)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 1 Oct 2024 11:00:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OcbeIZEpTAd5LAqSPHsaFqiZ809d2drFGtvAM83s/M/YH9QlgwLd4xdUiz9zucXCNGPa2waS04hvYSNtY+OFUsNt4vas1oQYIvf/79Gl4563WCxw37Pie0+n5+zqUKhPlc6jsqtNIyBw/sc7OR3XVSGfZL7aapSVTP5DhRgT2+kGK/2FRzLMr8TxXpiJR2EONlTf5rADFM0Oati/hbdxLD1gau/CYuLNfBGKCBSJxiZ6G0PGLmksJEtx4zN5M3EunTN7HVNkvWvi5kaTOxAkfKlVQ6/oT9PfR9zuHG1mfbzBzPe+esmC+gWFHEj1rJeAJ7zCAJVnFXEn/7bgKzBjmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3JM5TjOTZnz5ipg+SGIhEpqoszrgg0A4DlPaB5r/kRE=;
 b=ntNN/XQ2GOiiJHM4tG5sH0EgxWB+gpsGhN3DclLP7rpJan1Cr7MOQI0jav6sPtUXQd1b8AeACx2NcNnjOpb+j4PdAq3ghZxixfIbZwyaBqAgHuKUfoM2Mxx3Vucb5nDHHPzV17DYJP1r9ZK1QB0vt7dYgrBx5MMrX8F2cqVjCgp3ue8lr6j6Ey7kd+T37UbbIGq6hELsbZjyvso0pwjMH/TcLzTu/ni2l7c89U8LeEP2yUGhoGo/JFA438iFvOlpNkepzpVVLrtbtmdlQdZ8/2xxEOBmh1SoBxJk4nqJWQqyCIj3XC0PrkC9YfLtxht/jwTfDrNjejHSlVHBqU9pww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SJ2PR11MB8401.namprd11.prod.outlook.com (2603:10b6:a03:539::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Tue, 1 Oct
 2024 18:00:17 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8005.026; Tue, 1 Oct 2024
 18:00:17 +0000
Message-ID: <d3964902-ac02-4fac-a0e8-f820fe56eed1@intel.com>
Date: Tue, 1 Oct 2024 11:00:11 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 10/15] net: sparx5: ops out chip port to device
 index/bit functions
To: Daniel Machon <daniel.machon@microchip.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Lars Povlsen
	<lars.povlsen@microchip.com>, Steen Hegelund <Steen.Hegelund@microchip.com>,
	<horatiu.vultur@microchip.com>, <jensemil.schulzostergaard@microchip.com>,
	<UNGLinuxDriver@microchip.com>, Richard Cochran <richardcochran@gmail.com>,
	<horms@kernel.org>, <justinstitt@google.com>, <gal@nvidia.com>,
	<aakash.r.menon@gmail.com>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
References: <20241001-b4-sparx5-lan969x-switch-driver-v1-0-8c6896fdce66@microchip.com>
 <20241001-b4-sparx5-lan969x-switch-driver-v1-10-8c6896fdce66@microchip.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20241001-b4-sparx5-lan969x-switch-driver-v1-10-8c6896fdce66@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0084.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::25) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SJ2PR11MB8401:EE_
X-MS-Office365-Filtering-Correlation-Id: 00091fc4-c25d-4a90-0633-08dce242e852
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bXNmOWVsbWVwR0xPVUZ0MmVTci8wc1FWWm9sa2ZYMnhMNytFQi9Ra0pjMmR0?=
 =?utf-8?B?VVp0amFEb1BJd2N5VHQxeS9nR1FEMnFxTjJkV3J6bVQrV3RNaEY5NUtiYzZn?=
 =?utf-8?B?V2wzbTVTSHAwWEpxWERWY3lXUUtpcDd5dUxDV3N0MDhWVGI2RTJzeGJldERQ?=
 =?utf-8?B?a1MyM0tnaTRJaFhGbVc5Y0hUZXBmWHJGOGZCaGwwL2l4NS92cjdVZCtYUWhm?=
 =?utf-8?B?a3RPeGlJVUNOZ2tPZE9vSzUreWRXa1E1eEl2bVdqaE9VaGFKdXUwa0FSSTZU?=
 =?utf-8?B?VXFRRkZwSHBrWXV5Q29URmlDV2doUHJMdWZoYmVKdENGNENZYzhzU2l0UEVy?=
 =?utf-8?B?WnNuMnpjNkorNlVxWHhDQkRlSk1nRFNIYzVhaDMvT3RMMkV2SGh0ZnhDSzBL?=
 =?utf-8?B?OHN0RldEbVlFMzRieldrQVVCa1NNNjduNUcxRlJMSXArSFVqaFpjRE1DaC94?=
 =?utf-8?B?TTJIUGwxaXdNZ2lpV3E1TDV3cGNZdDJreEg1c0Y2cTcyWXlnY2JNTmZpVnVW?=
 =?utf-8?B?R21jQ1VpWWZJZzFyTnU2UDlFNGtsbGpITjN5cDRFMVVySzd1K1RrRUE5N2xy?=
 =?utf-8?B?Smp1NkwvY1A3OVkyZnRhdEJtMjNNK1Y5UHpDRTE0bThLdk9WTC9pSGhWWmdW?=
 =?utf-8?B?Zm15MVViZHlGY0V1aVpMNjhPUXhTUGIwZ3hPdXAzUTVxSGdoUmhqVmxwcDRK?=
 =?utf-8?B?Q3IwSzFnNWVsQUJkM1U1dlQycXRUNlBPbi91NDhzUGlTRUpEUFNCOEdqSVpi?=
 =?utf-8?B?KzdaL1doSHQwZnViVTVVdHNaQ2ZWOUU2b2RZREdzR1R0a0VjdUFCQ2VtdXhP?=
 =?utf-8?B?R2Rqa1JNeGNJNmNEdE5SanloK1ZNOGl2YXl0Rit6d3ducFc1aEZxa0h0QURw?=
 =?utf-8?B?UjVJUnVKVnd6Yy9hbFd3QmhHb09EWDJCTDVyeFhTbUkyZWNraGE1amhHMCtk?=
 =?utf-8?B?Zy9PbjVOZ0pNUnc5dGFRT2FyM0ZQRVJYd0FoWUFtZlQ5UWwvU3NOb3pORDN4?=
 =?utf-8?B?NnNWdFdlRGdBWFRkSGsxRXpzM2dzU0p4d2Yxbko0b3dwSzdrN2Y5R3hPVitI?=
 =?utf-8?B?SytzWVlZMG1OVEtTVmp4MXg3UnEzektBWVlEMk1UdEg1My9KdWtVb09xWkYz?=
 =?utf-8?B?em9BVko4RXAyYXBJNWI5MXdLN3o1L3l4a0xHVnVHajVsMGJIZDJqbjZzbEVy?=
 =?utf-8?B?RDkzVWdmK1RhUWhUM3J1bHdrSmswRVdaN3FPanY2cUpMVlVtcHhxeEs4Y2Jw?=
 =?utf-8?B?REdVWmtoZkYwdUxBTFJxd2dOWmo2d0JNWGJzaUR3SW9EUFEvNlYweTMxaFo4?=
 =?utf-8?B?RTNRSzZTdHFZMWNzQXhuQUZsMGFvanB1SVVlaU1lNExtSG1lc3F6VXRUVUc0?=
 =?utf-8?B?NHZIM0xNUjEwUDhsSGptbDkxK2VBcFhFMTNPb0FFYklFRUtBZGQ0Z2RxaHJ3?=
 =?utf-8?B?cHlXd0ZSNGNTbzdtcHhnd29CUTBxOGVFWXdJT3FJYzZwTHE4VE5pYnc4Qnd0?=
 =?utf-8?B?VGl5MHJCSjJlSXpSank4UzFJSVdxN2pjQk5vNktoRGR2bWppeFpVKzg5RWlV?=
 =?utf-8?B?SFoyc1c0ZmRId0Frb3hOWllpK2tOT2YrME9FaXgvc0tiQUhBQzNMNlFCSyt3?=
 =?utf-8?B?dnNFWm9nV3M2bWF2MWl1VHFyeHhBSDUrZjZUMTBjdnNBRndwaVZPQURmZ091?=
 =?utf-8?B?VC9kOENUeWsyTlFLM3FZMkFyMGJvWVVBa0NuQkl0WVJ2bnRiY2lySjdPODJP?=
 =?utf-8?B?WDdSQjFKVzdsTGdSeEdTUVN0YUtPNmFaUHkwMytnUWlwaWs5OCtZeEdNVnFp?=
 =?utf-8?B?S2pwQnkyZG8xOFZza0dVV0JrNzZDVjFWN1lTN2RKY2ZaQWtFVm9MeUdGbDc5?=
 =?utf-8?Q?CiHHQC0T0uX8R?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0wrR2NZU09SMmpLUzdkeGtUUG96SkNLaEdBSVErTi9mWWlXVjhZNlM3OTJK?=
 =?utf-8?B?SVY5TWxjZlFxTWp0eHIwRDdMZkJrWDMrUk1qWVJrdnhjbnhXajQ2R3pvVEZQ?=
 =?utf-8?B?TXdPVTRxeXI2QnUwSE9lalUxNHJVN2FqczVua1l2cUk1R2RuSnU1bU8zSGlT?=
 =?utf-8?B?dmo3Yy9mcHZJVVJFb0xETW05MUVKZzkzc1c2b2lBYlhRM2JzOGpRdzJmNmhP?=
 =?utf-8?B?QlNRYmk0ZldtdjFkMi9peGxxMnJocVJZN0hKZ1h4SUlnL0x2Uk5iYk9jVVBt?=
 =?utf-8?B?NGg5N2pTYTNZUnAwWXk1dWY0ZDBRSlJiRVBqcytyLzVlbHhwMmpzREN4Q2dO?=
 =?utf-8?B?YXJUSmdnVzZNdUdYQTRYRDBianVGYW5hSEhQWWNJbnBvc2t6RFE3T3FZRXh4?=
 =?utf-8?B?bmJ6K1VsbzJWQnIvekJJOW5ybnY2Ty9VSVJKdGtQNHNhREN2aXFNZWN0QzR5?=
 =?utf-8?B?M3l4VU91Mk82dkl0a0hXQjVkUzZMQk9yUURsSE8zQTh1RkpzaVZtMElVYjNo?=
 =?utf-8?B?dTl1R1Y1bmV3dE5Oek9qeGU0SWxjT1dYTHRMSklxZVJSZWZOUE95YXcrMGNn?=
 =?utf-8?B?TjU0WFNPTjNYWitWWG5ZMVF2Z3V3dlhoQ0ozcGpFejFwbHdhRG9ldTlvNEFt?=
 =?utf-8?B?VTltL0xNQzFXN0hVcEtRL3pISGhWSFN1ZVZKZVozeDhKR2lsWFRjYXloVEI3?=
 =?utf-8?B?VlZ3ZzM1djh5WXJmRkI4Q2NjSVFuV05MZ3dKZnQxNzQvaEJxK1dWbDJCRG5Z?=
 =?utf-8?B?Qkt4OVZHNGhaOGxxSE5BS284M0tkOExTYXpxclBzRGxIQWtQSDhFdis3S2Vv?=
 =?utf-8?B?bndVNFFPN2t2cXJEWjRISFZRQmdRZ0UyUHBIeW5HajFCOE5hTjZrb0U3ZkV2?=
 =?utf-8?B?VlFFUS9LakRNTUpiazN3ODVNTFBLZjhyTzNaSklVZ29rSU1ZR1lZMzRvaDJL?=
 =?utf-8?B?T1FmQ2dWU1Y0ZVVUUU5yNnlkRjRodnJTNG9XN1ZJcUVidjFHeWhOMXBQVG1H?=
 =?utf-8?B?T2tHeTRRT2h3Q0wwNk9jWkZkQlEzS3VyekxuTzU1WjZZajE3MGZaTjhFQ3BY?=
 =?utf-8?B?SFduY0N4T3Y5T1NKTlJaVVVUUXpVajNEd3haTzhicjFhRUVnRmtXQ0dwcmZU?=
 =?utf-8?B?MUVTVlRHbmh5bEplRDRPRXNwbHAzRWZ2U21iVWx5enRzR2toZUtaa1UvMWJF?=
 =?utf-8?B?U2liRFpTSXF3WU5wT2tpUTkxVU10Z3pMYXc2OHhVT0xZTjViYzBhQkdWakRM?=
 =?utf-8?B?UzQzeTVwdkY1Z3UzcU1GNklWa1I4U3FBM2xRS1lmMTRSVzJ1eHQ5RGNkT3dk?=
 =?utf-8?B?d2l5Y3piN3JjdmkvZ1gvUUduOTVpKzRHUGo4MVdiU2t6cHlNaEFWeEJTYk9T?=
 =?utf-8?B?bXdxVFI1Y0prd0JSd1BBTjFBOXVxeHhHQ1EyNjNwT3dmT2tvRHR2STY0R2px?=
 =?utf-8?B?UENWTHBRaGhrK3FkOE9ZOVBzaHEzaWF3WGJVaTJNUXU2NDZwUzRnMm9mRi9M?=
 =?utf-8?B?bDBrd2xIaXZpRmh0bHBNUkFzbjlBb01pbHZLQlo5dzgwUklncVRQcUxwbklJ?=
 =?utf-8?B?dDN3NWJzdU5OSWV6YXFSZGpjZ0dCbyttNnR6cUN2dS9DVnZHOTE3QWw5enRX?=
 =?utf-8?B?ZW9JbWNWNWRCdkgzV3Z6cDBsTEZJV2JneWtWVkRmcy9jYlZqQ3E3a0FTbmRI?=
 =?utf-8?B?eTgxRURJWGQwVnZSMFVDeUMvRWd2bGJFc2dzbFAvL2ZSMmpZL2QxZWREWExm?=
 =?utf-8?B?MlZLQVVQNkUvMUJIbDVMZTdiVDQybVZCUURaOW9HVFpZMzhLNFZYcnRrUXNQ?=
 =?utf-8?B?YUlacFkvcGZBMG1TY1NGdFEzTUtqSU5TK29pbmdWMmQrUjJGRHE0R0crQUhp?=
 =?utf-8?B?R1lpbmJGSGNxc3l0THVJMjdYRnJsNzhGMUhzaUZadGZRQTRqc3AxUVFJOEJq?=
 =?utf-8?B?VXhmNXJESkRjaHFkeGZlVXQ4VmFNMUJYbithb0ZzdlVveVVBbktJditHcHND?=
 =?utf-8?B?MnJvMVAvT1JsaDBPTUR6bnlkVEVpeEkxVTMzcUc1ajF4ajJYV1pwcXlkWDBz?=
 =?utf-8?B?elZLMHl5clVZQ04xaVFMVUQ2a0NLYzZLb0ZKRVBRcHlPSVBUSUtUTmRqUkd0?=
 =?utf-8?B?Z1REbUE2cUFjMkNYcGFPellWVVNHN2JwVmVRREZ1QW5URUIyRDcyakthT3lU?=
 =?utf-8?B?NWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 00091fc4-c25d-4a90-0633-08dce242e852
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 18:00:17.4361
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UEYNk2cIYF8l4Utc7nD4sfoZD1F1Q3nJUE0C1Ted1u/kyXyzbqjFx/94+IO9UnGpd4fdrYiarQiB5FnpB3YtYt6QxEuoQ5EVsYcWRQbpu0Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8401
X-OriginatorOrg: intel.com



On 10/1/2024 6:50 AM, Daniel Machon wrote:
> The chip port device index and mode bit can be obtained using the port
> number.  However the mapping of port number to chip device index and
> mode bit differs on Sparx5 and lan969x. Therefore ops out the function.
> 
> Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
> Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
> ---
>  drivers/net/ethernet/microchip/sparx5/sparx5_main.c | 2 ++
>  drivers/net/ethernet/microchip/sparx5/sparx5_main.h | 2 ++
>  drivers/net/ethernet/microchip/sparx5/sparx5_port.c | 4 +++-
>  drivers/net/ethernet/microchip/sparx5/sparx5_port.h | 7 ++++++-
>  4 files changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
> index 8b1033c49cfe..8617fc3983cc 100644
> --- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
> +++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
> @@ -982,6 +982,8 @@ static const struct sparx5_ops sparx5_ops = {
>  	.is_port_5g              = &sparx5_port_is_5g,
>  	.is_port_10g             = &sparx5_port_is_10g,
>  	.is_port_25g             = &sparx5_port_is_25g,
> +	.get_port_dev_index      = &sparx5_port_dev_mapping,
> +	.get_port_dev_bit        = &sparx5_port_dev_mapping,

So for sparx5, these are identical operations, but for lan969x these
will be different? Ok.

