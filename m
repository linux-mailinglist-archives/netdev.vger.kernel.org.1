Return-Path: <netdev+bounces-131140-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 141C198CE5B
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 10:07:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2E211F235EC
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 08:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81298193430;
	Wed,  2 Oct 2024 08:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hzQ3hNCd"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A8746BA;
	Wed,  2 Oct 2024 08:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727856465; cv=fail; b=cugSm1WliliGYqkXtxFR5YwXk502hSC8tVA2SXgMv/x9I8PCNOfEYQ2QTvF6ZEFmUxNseH1Zu1uuzkJSWEXSXuY/qLG+uQH0XbZFqkzb4Tqcu+byyALAj3Yk7T7Ew49le6ioFmpOmeh0nS4ARUDhqK6uVQ1DZsr6VktNo1TBTo8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727856465; c=relaxed/simple;
	bh=n3cvQJiEldl3KeCWgwfjBJiZtvuY90TBoUkiepUe56M=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ePGyOIikbWOLYU36oYwZPaFChd6TWk/2vTGPo+Gv69E2v8HJ7OmckCJzUrNBX/yHjg2fHipRXkW97YB+UCdw/TVTi35OHrPeakVV22NjPOr/lOxaLscPRORO0mAzP7Hwusb3O+RZY/uQatjPToTF+xF8NsEzlw98OCifR07OcE4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hzQ3hNCd; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727856464; x=1759392464;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=n3cvQJiEldl3KeCWgwfjBJiZtvuY90TBoUkiepUe56M=;
  b=hzQ3hNCdiq5a6SJYWZNXY+ks2vensZBTGew3/DfExxQO6wUkerxai/ev
   8TkYuESpmKbeM5qsk1w2IsAT2ftcQvZyI2RZTCFVZ4NTo5Yu0KxnnFq50
   VVfHxIn0wodWTjGST8ufiBZIUGPFKhlU3p6/eBiuzwFvwaTz91ZMwe8+s
   Z5EVO+XbFvA/KZvXKsCrMM15wXfH8q5mlM8r4MBSRNBBP+NRnjozwM9RX
   XndWg5kL7KoYH8gX4wngBLlzhX1HgJZIMEsSxCLZGe30ojtqm1uQy1bbf
   sFaMCwouC+YwFM6uma1fXVHOB8NUFa3npqUhflqOe5tR4eGCdJhwQxUjA
   w==;
X-CSE-ConnectionGUID: sct261TFQFKbxB/ErJ6w5g==
X-CSE-MsgGUID: R0Hx2v+WTkmymQDyu+5YSw==
X-IronPort-AV: E=McAfee;i="6700,10204,11212"; a="44537968"
X-IronPort-AV: E=Sophos;i="6.11,171,1725346800"; 
   d="scan'208";a="44537968"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2024 01:07:43 -0700
X-CSE-ConnectionGUID: RyI5aN89Q9GVbfBAgMFzCA==
X-CSE-MsgGUID: /w3Q/WehQP2i+NlsnmZxNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,171,1725346800"; 
   d="scan'208";a="104742548"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 02 Oct 2024 01:07:43 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 2 Oct 2024 01:07:42 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 2 Oct 2024 01:07:42 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 2 Oct 2024 01:07:42 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 2 Oct 2024 01:07:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fn45zkkFrd3eOii+SbsT1wGMqbS5oYXb7pHe6wFd5f9vPt0H62CruwIg32RmhAM7DzjNpkIKRljJqCUWIfhK6JNLHxoZrafPBnYdink2ZR2CU14BNlTttG9oqBZToN1hOeELHT1WDEGU6/db9TI4oLcyo/4qgitia+vZ53alhUwYwNkq686v/nQrlF2wbPtTrFBdShifU8GTU4nouHVqKBn4E4nL+5SGbos/+w86IGSz5TXZst92464u8dAxYgm/qeeYsqadwT2EqTw0P4qpniT2XWfmIg1pSwGRyAuHZngZHh+29akQaOCEoO/aqtfopm9GKpVvnP46XKidhbi2oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EkXSEsmfhYLJOklrkXvFBHvudC4mNZbjVVZ0QkfmOA0=;
 b=OLVdCEa9G3wPPBhC8PbGvC+tdSyb/b1IAaM8wA4Squ5UL5bakS54K4tCRV8pjtKwdkI5UJQlA9hUVMZqkNLHmwUZP2qZx84L1uv+T/n2Z5HJsHOXUtGuhwy/lA8rJBQh5wPUNzqNw0+7B4vo84jfF0Y0ks2xbq9Ic+YvHJzm0/h+thmAMUGpmuOiIoRVEwyTwSJekNrtxiiQUVUdKY0Pc5qXdBj8vkg1ZzZBwjA2mIVXOiyWforn8LX90+K8Z6ijR4QTm6n6uFSFDXnYu6gyfOeJHsDqnQ6sdLbvMQ2kziuKB7GztyTuDZCSEzeodrfQUO2GAcuM44ON0r8DW005xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by BY1PR11MB8126.namprd11.prod.outlook.com (2603:10b6:a03:52e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.28; Wed, 2 Oct
 2024 08:07:38 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.8026.016; Wed, 2 Oct 2024
 08:07:38 +0000
Message-ID: <0bf84a9c-f274-4b92-8545-7e1418c00ffa@intel.com>
Date: Wed, 2 Oct 2024 10:07:33 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2] Simply enable one to write code like:
To: Andy Shevchenko <andriy.shevchenko@intel.com>
CC: <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	<amadeuszx.slawinski@linux.intel.com>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, <nex.sw.ncis.osdt.itp.upstreaming@intel.com>,
	<netdev@vger.kernel.org>, Markus Elfring <Markus.Elfring@web.de>, "Dmitry
 Torokhov" <dmitry.torokhov@gmail.com>, Dan Carpenter
	<dan.carpenter@linaro.org>
References: <20241001145718.8962-1-przemyslaw.kitszel@intel.com>
 <ZvwQjMwdDVviQL2P@smile.fi.intel.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <ZvwQjMwdDVviQL2P@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA2P291CA0035.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:1f::11) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|BY1PR11MB8126:EE_
X-MS-Office365-Filtering-Correlation-Id: cf9a3286-eb9b-491c-af78-08dce2b947f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SE9rSk1XMVRhZmdXdmdWUFNoU2hsNHoxV1RUeVVtMzJKazVLZHRxUElYY1pU?=
 =?utf-8?B?QjlIZ2I5dDJCQ1dPQWdvZzdNc0EzclFIeHlWS3h1OGwyTjcwQng2SXc2OE5u?=
 =?utf-8?B?NksrR3BicE1TS0s4QWZvNzh6RWd6Qmc3M0V5SW50SjRVdW5NWlA4NGJoZFZ3?=
 =?utf-8?B?YnZxNEsyVWRLUTg4VnAzZnp5VWhhOTNESjZ4TnBkeHQxVytiOThyYWNGblNY?=
 =?utf-8?B?MExIUEZNQis4UWRUeDRpMDdBWEpIbkdnMHMxRjZKWmVTSUU4d2xyczlORmFk?=
 =?utf-8?B?NUtxZVFaV2U2YkQyQnppejBLQWJOQS9BS09OTXByeUlNdk9mTHgwZ3J5SU0x?=
 =?utf-8?B?ZXYwb25IWVN5dkFtSXh2azF1emQvS05ha3NmVHZ3TGQvTkt5Y2x6dGRDd3ZN?=
 =?utf-8?B?OU5rWW15SUhjS01uTEE5a3hCWjhvdHgxbUR5anZnUG1kMGR0VzlNck5DWUxQ?=
 =?utf-8?B?OGVZMHczNG1TWmRKMHlCVDNvUEYzM21tdGFJazNURTgzZlZGVUcrZit2SWxt?=
 =?utf-8?B?ZkFxYWwwZUlhczhaZkZGRVZvSjJTK0U2dXBHN0VwSWVvY2lpV1RJUzVtbW50?=
 =?utf-8?B?WndKMzRzVDV4UXNQNEVRb1ZmcUxacXY1UGljYkdBWURrUklLejdxbEJ3ODFJ?=
 =?utf-8?B?eXpnZTV4a21PczZ0OFNYZ3ZOek4vdXEyeHJwdHNTYmtvTHhRaWs5WXhrYVlk?=
 =?utf-8?B?a1pZUHg3OWRnc0VMM1ZpbTJqMmxjN1Z2SVZwNVNEWHlteHpoNk12YjFONVZm?=
 =?utf-8?B?bEdKaWk4L1drOTZ3L2xBRXhkY2lnWUFYR09TZ1p6S2J6RUMvMFM5cHFIczBH?=
 =?utf-8?B?UjVUN2FFeUd1S3JHM2tyeHFtS0lnZU1PZVllTHRrRW8vd2JtRmhTVVhMM1pX?=
 =?utf-8?B?SXFIdStsWDB1RS9IOFlxMEJHazdjRnBUNzJrakpNVHNHUkwwKy9jNXdITjFY?=
 =?utf-8?B?TS9OLzM3OXl0RWszeDdXalM2SkJOVG1YR3BMWjNlYjJGQlhZNFJ0cXZxNng3?=
 =?utf-8?B?dDRRMk91bVQ1bUJvbFdtdk5nZmVGbXRQSXNUWFlKNUFLM0RBSktITmN1WDBi?=
 =?utf-8?B?eHNGVXZKY0p4U2xEUmFtZXpIZHJMYnB5RkhsQWh3eUVUWFZPMHFnOG00UkdG?=
 =?utf-8?B?VFpYQm5FY2xCT1l2REFFYVY2a3dtNktKRGF2Qy9qSTNxSzZkQ3pVNlVPRVla?=
 =?utf-8?B?RjhFL1Y3a0I0cHkreTVrTEJ2MnBvWTh3NnNtOEk1OW9WQWZiOEdncWFaWGZi?=
 =?utf-8?B?WjRsSXpGZ0w1Ym9vaCtVWHYrc3F1RzBjZERmdVZGUEp0cFFtQ3R4R0gyRVBE?=
 =?utf-8?B?OGVQREdzTjRRY0tvZGFwM1dEUWJha1NORlBMYUcwMFZmQlpXNDM5UVRGdFVY?=
 =?utf-8?B?OXlScjUzcUc5RWkyTG0vTkt0cjRxa3JkWVpDUVNOS0ZvNElnbU1nK2FnVmg1?=
 =?utf-8?B?SGY4VjFUQllhaHM0aklpZ0hsa2FhdWVOTStzeHh2bk92M1djUXZlVzZoRkJu?=
 =?utf-8?B?UVlmcXZoZ2lEWHhPOU93SlBVVVRQVHdUVGUvaklJeFJIQUNuQkpscmRidG1m?=
 =?utf-8?B?RWVWUWJQUVNCQlpVaHhTbFVzNlYyN1ViSDN1WUZRemtObmt4U1Q4NDBQNG5z?=
 =?utf-8?B?N2ZnNlFDSWJ4UW02MlgvbjBmRUhNQTJySkhOd3o4Zy9IUkNKVkpJTm5YK0Fl?=
 =?utf-8?B?V3FFU1Y1R3p4bmxQbTZUTnFFUVRSZnMvR0YzL2NTbE1CNE5KOHBpandBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZlRlWkM4QTNwRU5HN1hhZ1BpbnFQdUhEcFFXMXc2UDZaVHpNSzJJYnJtYTVr?=
 =?utf-8?B?Zk16TmFYWk5GK0JhZWdNU3FRcTJzVm9KVjFmQi9ZQ2p0WVk5SnhPdWovblZy?=
 =?utf-8?B?NWVZeWVsYUJ0RGptREdUUEJLNzZ2UmtwQ051dnBVaEdPdU1LaUx4QXh0WXlC?=
 =?utf-8?B?T0dFYXg4eU1pSXY0UXpQaEZjbzFLYmh4L0pRcWo1SkZaRGFTbW0zT3Z6NXZp?=
 =?utf-8?B?bmpSTndQVjN2RUswV1VsTjlUWkpWRFp5TVNtSHB2WWVyeFdpTWdWOWowK3lp?=
 =?utf-8?B?cEhaS3p2c2Znd1pUeDQydFFGSnhaaEh6NzdoL1VnOUIzUjY3TCtmMlB5a2JH?=
 =?utf-8?B?dHlIOW5BN0lQMTZJdG1TZkJsalVvSWwwNHQ2bVkrbVF1eFJhZzFxd01hU2JV?=
 =?utf-8?B?SEFWZ0VyNHMyaUN4VEM0UzkwSWl3NzRGYnlPSDJsd1JCek04dUVoWFVkTm81?=
 =?utf-8?B?d2hidUFDY2s4QTNKTGt5TjMxTnBUYVR6SDRxK1NhS1NubzJYYnN6WXczSndk?=
 =?utf-8?B?a0lZNmRQM0VOR2lkUHlseXg3Zmt4aUhQbERXMWZETEJCTGI0eTdmL2ZoOGlK?=
 =?utf-8?B?bEJrQUlQWGJFeFR1TS81eHRIRzZJZ2hYU3BpVlMrVFN5K3pxaHF2UEdZZ1hO?=
 =?utf-8?B?Q1d1UFJFOWxOM1l4NjV2TWtkbnFxWE1rS3plaXNtbmVsS3hmUnVNOUgvZmlS?=
 =?utf-8?B?azhvbTlPSEM0dzVDWi9ZbVlHZTlQcE5hR2dQbkZqWVBXUy9FdkNDVE4wdWhH?=
 =?utf-8?B?aEJGalN6ZE02OGFWUWNvaWhqNjAzSitBWXN5OVZlV3puQldLeS9ON3lEZWdB?=
 =?utf-8?B?bDFTbk9RWlJxVUVSVjN4cjZiZCtWMzZVQUhDRzBqSWZONlZtQW1UNmdJT1o0?=
 =?utf-8?B?YW9NMkNSY2JCOWx4ZDd2cDFHdlV5VHpqWlg5NDRkbDlBUzRvUDlsUDY5V1BR?=
 =?utf-8?B?RWhRTFlRdW50cWJMbGF0VEx4Q0tZcjUyWWxLbEVwY0M1V3U5ZHN3a1pjVUkv?=
 =?utf-8?B?a01ucDVxZFlMeUo4OXJhUXlMVjFYaSt5V1IzL2g0amtzYzZTNTVLTGVxYVBu?=
 =?utf-8?B?ZDg3U2phSHV6ak9VNUFyNmxSeG9YZlJtaWNOV2xNdkhGMUcyQ3FYcU1uYVkx?=
 =?utf-8?B?UVJ6cTNEem9XeXdZVytDTDdtMHVma1FuUVNoSXdxWWxoSnEwSHNDRUJ3N2tE?=
 =?utf-8?B?ZVpYS3JORnc5UHRzN0ZRVGFKTnF2UFk3b1NZSnFOSklqNm9Lb0dBOEFzdHpl?=
 =?utf-8?B?cGJkRDVnZkl6WHRkUUJrOUN0Y29ZdWxGaENpd2JKMlZDL1dUejk2dHlhVFZE?=
 =?utf-8?B?YmhkZmRwWHR0VFQrRkNHTTZXSFlXQzJYYlNXVWtCUENvUG9JbVVCcnBlYWFy?=
 =?utf-8?B?aitxODdndGFPbGhIUTAvSFJIUWRNb3ZJNWNNR2pFYkVFOG9sMjRSZ3RTbFpZ?=
 =?utf-8?B?Z3RoTGg0REpXOEpzeThLZ1BveHBrL3Nlb2xHYTlGcHFPUFd5eUZ0WjZGOHBM?=
 =?utf-8?B?cTdFWklVRnRxYzh0OU9vNmtlRXpORVhZMzhYeEpicEtaVHNFT2F1YzJuTWZD?=
 =?utf-8?B?clR4REZaSUJVWTZFbW9pWkxNMXFzZXQyVUlzalh3aWxYYWpRZjZBSEl2U0pR?=
 =?utf-8?B?b3lISE9jVU5NK1hvMGprVHV0Q2diZVJHN3paL3lFOFRGOWh1U3liWFArekoy?=
 =?utf-8?B?dkFJNVcxNFI5eDV3T0NYWHRhLzdTK1d0dVVjbUQwS3d4UklKa3NkckYzd0x6?=
 =?utf-8?B?b1d3TnppQ05NZjZhbytWQnBkbVZNRjE4TVZWZWJ0aWtNaDNhZVJZVmIrNHVj?=
 =?utf-8?B?aFNuajhoWWtobGN3UCs1Vytmd2tiRnNpWGE3Z0NGSk15R1FmS0VZQUxvMkM4?=
 =?utf-8?B?V1JhNkVrT3hUb0VUK1doSW9Oek1CNk9YR0pjTlpzQzkyRmYrMWR3YkFySFAr?=
 =?utf-8?B?QkwrRWszTzlWMFBTS29qb3o3Q1V4MVJMS2t0Rlp4T2lWVVltZWlCQ0dMUnQ4?=
 =?utf-8?B?L2UvK0lYVUovTGRicG1nak1JT2tiY1pJUDI3SWpGbnRWWUpRcFh1eDhNSUpj?=
 =?utf-8?B?TjhlcVhuS2JDc2YwMVhMWTRraCtDZStIM0xJdi9Qam44by9jQXRBVTB0Qm1h?=
 =?utf-8?B?ZksxSkxKbjQvTTdXb25LY2ozeno3WFk2MkR3RWhieHBjZ3VYK29Zb2E5b253?=
 =?utf-8?B?THc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cf9a3286-eb9b-491c-af78-08dce2b947f5
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 08:07:38.5837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L/K71MCrK8eYElCVH8n55Cyku696lrWqSuHy7wOZopP+BkWEhRLfFmqlqfpJIXNhW08prZAKADXYzbf+LW6ijsjJ657400T8ZmFdXaubSdo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8126
X-OriginatorOrg: intel.com

On 10/1/24 17:09, Andy Shevchenko wrote:
> On Tue, Oct 01, 2024 at 04:57:18PM +0200, Przemek Kitszel wrote:
> 
> ...
> 
>> NAKed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 
> And still NAKed.
> 
>> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>> ---
>> Andy believes that this change is completely wrong C, the reasons
>> (that I disagree with of course, are in v1, below the commit message).
> 
> Have you retested the macro expansion for this version?

yeah, I basically work with the expanded version, still linear
expansion, just ~dozen bytes more than v1

> 
> ...
> 
>>    */
>>   
>> +
> 
> Too many blank lines.

thanks!

> 
>> +#define DEFINE_CLASS_IS_CONDITIONAL(_name, _is_cond)	\
>> +static __maybe_unused const bool class_##_name##_is_conditional = _is_cond
> 
> ...
> 
>> +	DEFINE_CLASS_IS_CONDITIONAL(_name, 0); \
> 
> Here and everywhere else, boolean has values true and false.

sure, thanks

