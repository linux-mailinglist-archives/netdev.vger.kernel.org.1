Return-Path: <netdev+bounces-108411-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0802A923B6F
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 12:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EF071C212F2
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 10:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4038414A4F1;
	Tue,  2 Jul 2024 10:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KmU7Ow4F"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77ED017BBB
	for <netdev@vger.kernel.org>; Tue,  2 Jul 2024 10:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719916274; cv=fail; b=jajZKdgXKp/bZtKfenvYBcEbaxdDbaAgpfXkgEDvZ5CTTBLob3nYrrg9aLSsYRdtaPKRSvbnNb7jGjmFmrk3kxR5G5TEJCzlXkkrmwqYamsyqR4x99wXSkz27va26dCAZEPN9+W2vUHD8x0i3mODRf74cTrsF4QyYWarD7D6n6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719916274; c=relaxed/simple;
	bh=PIF2Ny6tODJ2FMgeN57bc5HDdBXz66+0tyQ4PFrc3ig=;
	h=Message-ID:Date:Subject:To:References:From:CC:In-Reply-To:
	 Content-Type:MIME-Version; b=GnZUAv9Sw0BZXtQH94Xyk2xMBjg988FVr+4HfoS7Kr1VsfZC5I9fOqvDs5VTNjnK4UN3Xe5tfC+/B1XaEPhbCik1PNvYx1FYDiwlzojhgyN0uv7KXo8Z+UhJOoO4ROcKizIT0rqHfOW59oY7Uo+j81X0G9koj5A+n4BOOLMsCmw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KmU7Ow4F; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719916272; x=1751452272;
  h=message-id:date:subject:to:references:from:cc:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PIF2Ny6tODJ2FMgeN57bc5HDdBXz66+0tyQ4PFrc3ig=;
  b=KmU7Ow4FIG71K7HZk4p/zNForEXhVWg9gnftiehu3gYciXukTyyHoQm9
   yOTfVwXzGcm/n7+fzFxo4+PA4gMZFEXaHlGRaklbxP2X45BfxoQgWioCT
   XUWjBfgMvbmXOadE7Isg2SE14uEYkGf86cFJDbAWmHQLQcwsPsV9KnVAo
   92BL6M60EXXByjDBI8hyPuz+3cUZ7TdV6mUv8V/8FiAiRbS57r/FrNM4I
   TAGCc8QEdgZowBcU5gOUTdsyjYDugsaBXvtgB1mnnoQGyaZAmKKLzx1wJ
   Pt5/jxnWi8AGHXon7pQql/7FxofFmz2CBP0SSmrBYwZBXOrL1Xb7c5CvT
   g==;
X-CSE-ConnectionGUID: IbC5N2XgSuKbVb7zdskKMA==
X-CSE-MsgGUID: yn/sk0+3QfmCtBiY0YjVXw==
X-IronPort-AV: E=McAfee;i="6700,10204,11120"; a="34622728"
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="34622728"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2024 03:31:11 -0700
X-CSE-ConnectionGUID: 5FZLZTV7RLq81J8DrXDH/w==
X-CSE-MsgGUID: eAu9UuNARMOA48s6ZSh2lA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,178,1716274800"; 
   d="scan'208";a="46589437"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Jul 2024 03:31:11 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 2 Jul 2024 03:31:10 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 2 Jul 2024 03:31:10 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 2 Jul 2024 03:31:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oJ1/LpuGENHFvDwpz/o9WfnvrCe6WoRtwDC/G6Yx2toTM+iWanDznlcyWKzI/hCUZV+n1lRA82m4tUIpXJcyzY4DUtFKZT6RTJLzW1pHtj9IJb1I47l21ww6HFgPn3hjECKy8/eTplYxFCW2lEfvnroworxNwMXKaOhE5ooF1fFWjpD4656aJqFt6mdpCdMrbh0GTS8NG1W2KXPCJf6aNJGfvArRJ3qojGtGpEiYUlsRhTkK7j2HEPxdKOOmmUdiU6+hIsuo7J/2h7nhsbzIv0MBMjyADD2fZhjoITJT0gvOt24csBF7MR4KMhBDy6c/rl90QRxCaBA3Hty10aftQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IndVtRmg1BxCvoLqHrTosx239tlnHMC9wH/0UPcj8Vg=;
 b=OOYsMLR35Ld7DkW3S8svncPLWHZNs+AmIKP8bubSQsuAhHKe4C9GI5wqoN5EtmeyUXzl81QjEIB7nLT3nCZ+g7h7WP2b3+dPDu7Hj5mtjZqA+1TvaO/kCGdJ3kfh3FfYpOUsJxAVNx3mUdnsVPUZOo4aA7kA+jwvdXAVFS3D0apmYB3AYIkKinolxWgKiftuh7e5ianGeVM+FAb2avGw1ScOhUOYSO3ePNNLUDfgeItt6nCMa8SO2eAuWey880hvZf1m0YXj408XM2R/bjMbPtoL9b8rhobUXzCgezVl+XfraFr6xEdl75bkzFQP+y7YJZz7316oKEvtHWPuuOXp0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by MW5PR11MB5860.namprd11.prod.outlook.com (2603:10b6:303:19f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Tue, 2 Jul
 2024 10:31:08 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%7]) with mapi id 15.20.7719.028; Tue, 2 Jul 2024
 10:31:07 +0000
Message-ID: <ab3e6312-cf67-47bb-b30f-d425f7914053@intel.com>
Date: Tue, 2 Jul 2024 12:31:01 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 0/7] drivers: Fix drivers doing TX csum
 offload with EH
To: Tom Herbert <tom@herbertland.com>, <anthony.l.nguyen@intel.com>
References: <20240701195507.256374-1-tom@herbertland.com>
Content-Language: en-US
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <jesse.brandeburg@intel.com>,
	<cai.huoqing@linux.dev>, <netdev@vger.kernel.org>, <felipe@sipanda.io>,
	<justin.iurman@uliege.be>, Paul Greenwalt <paul.greenwalt@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20240701195507.256374-1-tom@herbertland.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0049.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1d::18) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|MW5PR11MB5860:EE_
X-MS-Office365-Filtering-Correlation-Id: d6337da8-d455-4061-0f73-08dc9a821577
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?VXhFYUF6bkF2dEQxYXl4YkFzSzRESERDYThxRkV6SWlYa0JkRUV0dEpLTlJ1?=
 =?utf-8?B?NG5PUWRrZzNZbkRnVlhhSzNCSnh1V2JLWjB5ZFV2SmNiM3p6cWRiVXV2Y2JB?=
 =?utf-8?B?VThsbEVza3hXdjBsWXlxYW92RkhiWHhPN1psRDlzVWc0T0dYVGRUNi9YZDVO?=
 =?utf-8?B?OXhYWE5Ock5nK2tEWFg0bzJTajR3bm1IQnB2cjdISDRRUDJLcG5NeUF3OWxk?=
 =?utf-8?B?Y1ZmS0ordU94UDh6cjNDc2JFWEpURmVIZFM4TmE1ZEdqS0UwNGJ0N0M5dzJX?=
 =?utf-8?B?UUtOUEZUVFJ0YTVKeTBwbkdPaCtkZGVldnVhYWQ4YWJOZ1k1Z2V3R1BweGI0?=
 =?utf-8?B?TW8vNGNTVEl2UVMwc1Vxa1pKdEpORTdhSzN0dVQzZW52bHExT09md2UvcTJm?=
 =?utf-8?B?WlBsTEZwOVRaTTRSYkRYREtRKzZGSWYzVkhkNkRjNDk4RHJmN3RkUHk4VGdG?=
 =?utf-8?B?amgwaHloMzdST0owQXoyS0lSR1pucWE3eWg3ejVkSjhxV2N5dFhXMEp6MTlT?=
 =?utf-8?B?Q3ZOdjJnN295WGh3OTRBMUFvOTU5Z2JxUGp1RVVaclFkZWpnWkhBVGVzMHFk?=
 =?utf-8?B?V0ROY1RJVVBCYU9HTTllQUNocWsrM0huc0lZOUhsbC9NYmJTbGNFUXdOM3Z5?=
 =?utf-8?B?QVlzeERicGJFTnNZQ1hSWHBMRmdnaGhKcWFDR1RTZGVhRG5SVkZwaW9mRUFW?=
 =?utf-8?B?YW41VVVBZzhRK2VMQnlrbE1LeUJzZ1BLYWNpUnQzeUpJS0ZwamZ2TVMvdUd4?=
 =?utf-8?B?SjdTZGdscUlGL1RyUjNUemhxRmVTZlhNdTBRWWgrVXBqTEhyRjlqYUpPbzJw?=
 =?utf-8?B?V3pJODJ5L1ZCTndvRXA2QStaOGg4bUY5NUo2Sm01dGtwRUJVQm1kRm1LUXB1?=
 =?utf-8?B?RThhVVBMV1dTNzZ0VHdFWFFlWGQ2Z2t6REtyWjFqQUNWLzZrYWlyOFJkRGpX?=
 =?utf-8?B?cFM4ZXNuaUlhVXNYWFJJLzk0RTVvWDVRTFYyMlhpRk9aaTZSOXYwMmFNbkxB?=
 =?utf-8?B?VERscmR0WHp6TGpqd1lmYTZzZUtTcjhjUFExQkduSDAyRkh6NUg2RGl6MndU?=
 =?utf-8?B?NVVuQkF1TjB1NlpEUnRPbWtFQ2FpeGE0RWh4bVhFckxycnFoaFpVaWkzT1Q2?=
 =?utf-8?B?U08rVzdNN3FCNkJSeTZvQjBxSkNxWk1jQmdQaDhkMkJRV2FrR3F1Nnl2WGYv?=
 =?utf-8?B?VEhVQW9MUmxLRmNyeVFpSThlM2Z4SjA5d01QQXEyS0Y3MExqK2pYUm04dXVF?=
 =?utf-8?B?cWovOUgwbHk4WlE4SmpteUZ1UFBFRW5Ua1hybEZFU1hoczVwNWxHNWl2blJW?=
 =?utf-8?B?eTg3ZHhiaEgxZS9mMktvd3E1eHVHeDZSL0J5UDFnNG5OV05uelhYODgyTS9v?=
 =?utf-8?B?YTRMa2hpZzR6ZlUxN0JLbk8vK091VklJNy9CQUtpQUVlQm1UcTdFbmkvVlUy?=
 =?utf-8?B?OEpMMDArMUhiUkRVVzUyOVpmakR2S0RTNkFUNlhSRTFMMUk1T3lsd3RWcXdZ?=
 =?utf-8?B?Zkhwc3hHVjRHdURDS1dkVUZteEUzamRjUFpuV2p0MGsrSitNZklCM1ZGb2Rp?=
 =?utf-8?B?M3JPWjVwTmw5WGRTbW5lNURZTlk4TTBWNmRGczZ1VU4yQ2R5Q0Rhd3J5OFVh?=
 =?utf-8?B?b01LYkN4eVJKbFY3UGlIbllVUEo4dDFOMXViL201dFNzREhnR0dKcllrMGlw?=
 =?utf-8?B?M1IyeEpwU014aThSQVphVS9IaTVaT3FmSE9xR1M1VjkxcE5TbDVrNVNEM1FW?=
 =?utf-8?B?eEx1MUswQ2FiNVpTcnpETmJNc09XZVVpaHYxc0dHdGU3QkxsaUdybDhkTzhr?=
 =?utf-8?B?N0syTDQrWm81ZjUzd1UvZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NXdtOXVwNGdiT1htbnJzbDlKdmNFdkdFdlhpZGtxYjZrQnh1RmxFQ0lUZ3Na?=
 =?utf-8?B?NWJtdXh3Rys3dU9Mdk1FQ0NuQkNsR0NYM0d6NUdQYXo2MmRkemg4dENPSk5Z?=
 =?utf-8?B?dXh1d2prSUlTdmxHUG85SHYrSUJRRjVpS2NZbUhlelNrSHRLd1hwd0lzS2tG?=
 =?utf-8?B?NkJ3cXE3UUY4aElvK3hCVHh1QWIveHhzTlFma2dzei80UHExZ0JsaHNWczV3?=
 =?utf-8?B?M3cvR01FaVh5RWdTSmRtRThOMStIUHpnNXlCSFp6dUlReHNkcFk4TFdHZEVV?=
 =?utf-8?B?RHpqaXNEWjZkNDJlbkhQZEx5V2oyUC9zandKYy9BNkJoOUZkaVlGMm9hNjZC?=
 =?utf-8?B?SXB0emxaQjFqb2NIU1d3WWhIbW43MFlEajhmUGlNd2lUQk11NU9YSi9MVVlp?=
 =?utf-8?B?cGxWbW02RE9wZ0VIUlNYSmJ5dmFMaFJEdXVxYk02M0FhL2I5Y0FHQmRJbUFQ?=
 =?utf-8?B?eDZsejdrcHZzdDRCamZGVTlRYnRITERaOC9xTXduNUUrTWw1TWJPTGdFUjdT?=
 =?utf-8?B?SjdYd2xDL1RSblhXNXY0amM4aFg1Z2oxVTFKay9INU1oYTZoVXd6czBoa21K?=
 =?utf-8?B?VHZSUkFmYjdjYXg5MDFWLy9ia2JwZ01vdzMxWFZaZ1pGQmhxcUFjZjZ6N0xE?=
 =?utf-8?B?aFBuSzBqS250WnRBckdTdVllRmxON2EzcXdEMlpHMlR0YWRDS3VWRzZySHho?=
 =?utf-8?B?Q1ZkUURjTFZ1NkQwUnM3andobnUzU1pObWVTK0JBSjhIMVc2VC8xY1A2enAx?=
 =?utf-8?B?VmdBaHNEa09FUDNyL002VDk2RHBPNzgvTHg1RWtFbEQ1Ujh3RndBb1JaalEy?=
 =?utf-8?B?ZS9yVm5rSTZzcVJ5blBtb0gzSTRwNTNxYlNNQnEyUi82dElyY3dCK0d4eUFw?=
 =?utf-8?B?dUJmcWlYY3hnUUVSSUQyVm5ORlB3YzJhMFlTbHMvbzI4OG1QVExoL0VJcjVL?=
 =?utf-8?B?clZmVHVVYXRzejA5aTFyM04vU2d0eWROdFhYL24zVFNDeEIzRExqc0ZzSS9r?=
 =?utf-8?B?MzZoL2NabWR1VjEwb0VkTWNmc1BiTURLYzdBRFVTMHFPU3dINkcxZFp3Q0RQ?=
 =?utf-8?B?Z1RjVEZDOVBacVVIbXJSTEEvV2JZVk5BcmdpRjlQL1V0bmF3N1BLZnlGWlY3?=
 =?utf-8?B?bVZqTVY0NlJCL2F5RmFsQmJ0WkJNTkZGSit4Z0NrYnNGYW9SRGs1UXp2RnpG?=
 =?utf-8?B?b3pVZXgvdkNMa1BsRWgzc01ZTFk4WktWQVZyaVdFVExGcUVmWmtlZUhYTk1n?=
 =?utf-8?B?UUt6enZVMmlmWGFhVTc1Vm1SS2FzTTNkUGYyd21pYVZIb2dieUx6WTRWbmFn?=
 =?utf-8?B?SXVSLzZXQ3JwdkNKK2RDVEpoRDFKY0tQODBTMjZOZUZCVExJUXRGL0dPZVZz?=
 =?utf-8?B?cnVENmpuMEM5UnhGbG4xUmlpUmM1RjNucllHOCsva1BuRm9TSmNCZFJpbUt1?=
 =?utf-8?B?ZmJMRXQ3eE5VQVhndjRGZDJPTjZFd1JNZ3JwVlNvRWkvOVlvbUpqVGlzYW1p?=
 =?utf-8?B?YWZUbHZyaU1xMmJ1THQ1VDBiWkZpMlhUTGUwWitSbjlqdEhFRjhxZXEvTVQy?=
 =?utf-8?B?emozZGxiait2eDJnNXMwU1UzcUllM0ZYVHZEQlRvMktXQ0tjRG9heHB6djN1?=
 =?utf-8?B?eFQyVG1KdEJMZ2R6Q0p2M0NMQVpybms4UExoQkE2c2d5cVJRSnhob2pEaStD?=
 =?utf-8?B?SEs0WklsZ1o3N3p4azZNcjhVSys0SjFsN0gxT0puYTI3d1ZSbDN5NS91M0JX?=
 =?utf-8?B?c2NHcnhaMnVYaHQ5L21MbTRRa2NrUENKV2tsM1NUZm4rb2UzT0wwMjc4eXRZ?=
 =?utf-8?B?bWlSSjNpbmJ0M0doVUdDclR1ZjBLTGFDbUNtdmJBWHRRdHhxc042N01Xc291?=
 =?utf-8?B?b0xPZC9oVmNBWmRvak8zZmdyMENZWUVMWkpoQitmV1F3UXdyZiszUlJZVHkw?=
 =?utf-8?B?QVFRMFNNbVlDamFWZjJ3cFJUQzlkYllLTmxSREZCK0RDS2k0R1A1Y3daTklj?=
 =?utf-8?B?d0kzTTNpR0djWi9VZHkzdmNtWkRHWE9HWTM3aGRBaG9ValUwWXBSTEE3UlRL?=
 =?utf-8?B?QWdIZkJnSjlRY2hJY0NrR0VMSHFGUlB6TC9majAzSVRsQXJyWjNOeGNUdU9S?=
 =?utf-8?B?Q25Tanp6elo2bjFXTWVwVUVnc0laZ3YvSG9JREJFMC9GUlMwNFI3VTc0R3Fl?=
 =?utf-8?Q?3ypgLasS/TiMwUe3TNOKD3I=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d6337da8-d455-4061-0f73-08dc9a821577
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2024 10:31:07.8185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cs4Qi3tHWQNh7XTFzpHhDzwJOcnfpSKhl/VdDscuHzCl5yXwnIgKvgtrcey1Iac+evj7YN6hJJZ+MKa/VnpKoD25rTgYEMTO9/L+ZO9rE6w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5860
X-OriginatorOrg: intel.com

On 7/1/24 21:55, Tom Herbert wrote:
> Several NICs would seem to support protocol specific TX checksum offload
> and allow for cases where an IPv6 packet contains extension headers.
> When deciding whether to offload a packet, ipv6_skip_exthdr is called
> to skip extension headers. The problem is that if a packet contains an
> IPv6 Routing Header then protocol specific checksum offload can't work,
> the destination IP address in the IPv6 header is not the same one that
> is used in the pseudo header for TCP or UDP. The correct address is
> derived from the last segment in the routing list (which itself might
> be obfuscated so that a device could even read it).

feels like there is a missing "not" after "could" - with it added, reads
fine (not a request to change, just being verbose about assumptions)

> 
> This patch set adds a new function ipv6_skip_exthdr_no_rthdr to be
> called in lieu of ipv6_skip_exthdr. If a routing header is present in
> a packet then ipv6_skip_exthdr_no_rthdr returns a value less than
> zero, this is an indication to the driver that TX checksum offload
> is not viable and it should call skb_checksum_help instead of
> offloading the checksum.
> 
> The i40e, iavf, ice, idpf, hinic, and fm10k are updated accordingly
> to call ipv6_skip_exthdr_no_rthdr.
> 
> Testing: The code compiles, but is otherwise untested due to lack of
> NIC hardware. It would be appreciated if someone with access to the
> hardware could test.

we could test intel ones (except fm10k) via @Tony's tree

> 
> v2: Fixed uninitialized variable in exthdrs_core.c
> 
> Tom Herbert (7):
>    ipv6: Add ipv6_skip_exthdr_no_rthdr
>    i40e: Don't do TX csum offload with routing header present
>    iavf: Don't do TX csum offload with routing header present
>    ice: Don't do TX csum offload with routing header present

sidenote:
our HW is supporting (among others) a GCO check-summing mode described
as: "Checksum 16bit (TCP/UDP) with no pseudo Header", but we have not
yet provided patches for that, and I don't even know if this mode
will be used (CC @Paul)

>    idpf: Don't do TX csum offload with routing header present
>    hinic: Don't do TX csum offload with routing header present
>    fm10k: Don't do TX csum offload with routing header present
> 
>   drivers/net/ethernet/huawei/hinic/hinic_tx.c  | 23 +++++++++++----
>   drivers/net/ethernet/intel/fm10k/fm10k_main.c |  9 ++++--
>   drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 22 ++++++---------
>   drivers/net/ethernet/intel/iavf/iavf_txrx.c   | 20 ++++++-------
>   drivers/net/ethernet/intel/ice/ice_txrx.c     | 22 ++++++---------
>   .../ethernet/intel/idpf/idpf_singleq_txrx.c   | 28 +++++++++----------
>   include/net/ipv6.h                            | 17 +++++++++--
>   net/ipv6/exthdrs_core.c                       | 25 ++++++++++++-----
>   8 files changed, 98 insertions(+), 68 deletions(-)
> 

I have reviewed the patches and they conform to commit message/intent,
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
(for the series)

