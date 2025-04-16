Return-Path: <netdev+bounces-183482-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA0DA90CD2
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 22:13:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E75D448054
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 20:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19935226CF1;
	Wed, 16 Apr 2025 20:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IpeweuQD"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394021E1C29;
	Wed, 16 Apr 2025 20:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744834403; cv=fail; b=qMS5/gHg3rImNgv4OTNBe+lj85lQMJzOmi+h1EckeMMNKhfjlnvn7Or9ElW50luxU5gPI3RQihYLA9y/X2DWtnNp96G+YAQEp+Ww0Fm0QdrnjIsNjWG4Nj1hfDtaPM/a1uW61l3RR4XkfVQx0374sJXOaW710cwYZVmZAyHJEwE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744834403; c=relaxed/simple;
	bh=ZzshFCRIMrGhosoESreLfXp5glretgPhVHqwU4Znmng=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hRJYd7CaFvlslozj4N0LThYme0iq0ZkXDRPbrnqJlPuk4EbLv23CboHOz9LVyFlo7gpwq9L+HoXUAWQIya9GwC2FmhqjlYgalT56ArNhWyHmhDpGC1+smJQZJRGo4l0cnofIZ9QT0jet1+qdNBwQZsOkDgIzEykEO9jtOa00+A0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IpeweuQD; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744834401; x=1776370401;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=ZzshFCRIMrGhosoESreLfXp5glretgPhVHqwU4Znmng=;
  b=IpeweuQDGnU9wXtaBJrqTucJc2PhT2ZA4iC3Bi0Hms071zqdUlIlEGNP
   xKZONi3caeSb3hSLirVw+8EQaGg/U3hSG5o3zVp52a+KlWXugFzvMVAoy
   NRLffNUUeWc70dGRX+WufKmprV1e5GJ55gGJ5lrhoRNM/6xYJGnDj82la
   rquEZCfwkxw80uszQyLntRmT5IP66fymO9aju4VKbl6Z9GqEEylTZfT5w
   NoYPOtm4C1kHd7/a604varRpeWcIhlxNlfMT9ZuG/xMh4izSAGbinK2W5
   0TwrgM703877wOZPRzTFr+InK9XJ51aIjRnkXH4HVgtBywg1i489NmRhA
   w==;
X-CSE-ConnectionGUID: tszn2PahTPS3zbepw5+91g==
X-CSE-MsgGUID: GMFH9w5XToaFzbQJd43LtA==
X-IronPort-AV: E=McAfee;i="6700,10204,11405"; a="46326019"
X-IronPort-AV: E=Sophos;i="6.15,217,1739865600"; 
   d="scan'208";a="46326019"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 13:13:21 -0700
X-CSE-ConnectionGUID: DHze5Da7QxOdamI8gRIYAQ==
X-CSE-MsgGUID: +3LTHqwkR/eTRtNzaZtnDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,217,1739865600"; 
   d="scan'208";a="131564831"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 13:13:21 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 16 Apr 2025 13:13:19 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 16 Apr 2025 13:13:19 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 16 Apr 2025 13:13:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SOaG3rPBQhbGR5qQ50/8e3SRHy02BvyoUzBOkuhooIKJiLhFrbetIz3MmYXLnyKYk4pf6zmaSAiGo5mcZsQV/hRqb/k+Gu0UZD7YXJnnFXJjAi5MawQiOJ00UFptPt0IH/eNPzp6Vb9osMiKer23L05A5ZRnt7hmNaUndrDwdN8xnCZcUbiygii0MpmH9RC2h05rkv/D1TyEEmg4onrRcYYvQYjqB/I2Z99c/uUNotbHWmvWLzJiq/UH50u7LLEf217ekW4LWBAiMC65MZUsCArsoYa6U0qcrXfQRk1EogYJOALptF/QGCiyEcTNxJklGTVgsCuuwzMSgOnZ3W9qNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NXjowcbP2iL5FWdzBJ8hBBGXj66sSPwpIy8Ygs+EMYs=;
 b=CQLEPYK1CFTrpLHl3m89IF7G4tTVY8yKk0/yBFtERL1U4PXed8s+Qfu5SgE7kAMmekCafqOLU3hKFwYmTnqW7YwF+7/33UEC5fPbt9zMs6ntmo6wpsV7hJUChUGmGwlI6+5xc3H470wqyU/7YNHkDOpxOOT6Q670z35Phvi16YAN0+3lAu6tQ6D1MdIKYSE0E7yH6TUJzE+8a43ntiv7+G8fnomdMLSt1JyeSQMMERc7UxzxbUuc8u1ylCT7vnlBhZhcowJayUiDmAIiq3EfIfZJlkviRfX2bss5HnZoObPemtZjoRCu8nu6iRZ4SXyrGzc9fAB4/U4Q6vsmnptLVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by IA4PR11MB9251.namprd11.prod.outlook.com (2603:10b6:208:56f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.36; Wed, 16 Apr
 2025 20:13:04 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8632.025; Wed, 16 Apr 2025
 20:13:03 +0000
Message-ID: <61b952ee-d4e4-4e1a-bee6-4bde45ec1025@intel.com>
Date: Wed, 16 Apr 2025 13:13:02 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net 1/4] pds_core: Prevent possible adminq
 overflow/stuck condition
To: Shannon Nelson <shannon.nelson@amd.com>, <andrew+netdev@lunn.ch>,
	<brett.creeley@amd.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <michal.swiatkowski@linux.intel.com>,
	<horms@kernel.org>, <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
References: <20250415232931.59693-1-shannon.nelson@amd.com>
 <20250415232931.59693-2-shannon.nelson@amd.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250415232931.59693-2-shannon.nelson@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0233.namprd03.prod.outlook.com
 (2603:10b6:303:b9::28) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|IA4PR11MB9251:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bbc0f11-e252-4d72-7d67-08dd7d231812
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014|921020;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?YVowWGpDa2o4Z080UmhCdmtYakxTdEVITFgyZkRkakRHNlEvR3FOVEtjQ2lm?=
 =?utf-8?B?QnE2eHFzZkJKelFNTzJGNCswWHYrdkFna2VYb3V0NTF6V3FLQ3drMFE4OGVY?=
 =?utf-8?B?VEJzTXZtT1JJWEdKd0E2RFIwQnJ6TVBMSk9ubytNUHg3eHp0VjdBWXN5N3V3?=
 =?utf-8?B?emxXeWZ0YTdmdDB4UWtac0NJTEJhZ2tCRDJaY3RiQ3BMWTJxSUFhZ25FVmZ2?=
 =?utf-8?B?QUkwVGVvQVNIRFN0VDg0eVIvaWliMnBMZTBCMWQ4U0RabnpQNVJmY01CdXNo?=
 =?utf-8?B?MFdRL1NVWTgyd09vQkNNTytnVGIybXoyK1ZTbkt0SjhxbWNpNlNEMEZ4Ulhh?=
 =?utf-8?B?ckRBTlRRUzNKMjIrUnorUkRoQm5yUUZHN2dWSjVUZ1B3Z212T2hUUHpxU1hX?=
 =?utf-8?B?RVJ6WXludTBjbjFSK1RVZGpRMW1mdldYRFg1UVFoU1lpNkcvNXdsSXMrcW1p?=
 =?utf-8?B?cEpDdm5nL1BrdlVtS2x1QjNMS3B3SE4wZXROb0RzS0p0TkFMOHBBVHUra0RS?=
 =?utf-8?B?NDI1K3pZRVRhelFYeUxZSnFmVEJMTWZFb3h2cDNwRStzRGh4WE5KRnkrYWxx?=
 =?utf-8?B?WkZBQWMyMEZTUDhNckhRNnQzZ0RtOCtJdEo5d0Z5aDZZeWtvdHhML2ZCa1pt?=
 =?utf-8?B?OUdMTXRwM1YreTdVYmFCajBRQVQ5ZFErckh4cDh5Vm9GR3Y3RG9CV0VDYS9L?=
 =?utf-8?B?MzI5N0V3M0ZUK2dlSzI4RU9USmpZLzJ1enJyNU80anV1dE03Y0IrUndhOHJM?=
 =?utf-8?B?a0VkNmtTV3dBV01Tek5MTmt1SkNKTmwwOXI2QUNBMHBSWm00Uk1IUVp3dFA2?=
 =?utf-8?B?VXlMMEhjVFU1aE0yWitQT1U1RDdkcjd3OGpMa0VseElYbVU3NEI4MXp6TFYx?=
 =?utf-8?B?Rmp6QjRVNllOVmZGakRTR1A2Wmo0U1FPckJIbnhhWUdBMWI2TFZuVng3VzVZ?=
 =?utf-8?B?NjA0bkMwSjI4dU0rak1KUExvVmRlcEJFVGtFU3hRam80V2Ewbi9aTnBqYkQ5?=
 =?utf-8?B?OCs4VWZlWEJINTB1cWNrd3VjeGlTWEpxQzJXcGJCWmxRSGV2azFvRXpUdGRR?=
 =?utf-8?B?cFdRQU13MTFRM1VqZm5tVGJjR3hub1hFU0I2Y0ZtRGRpNlFUdnh0amZpek0w?=
 =?utf-8?B?emM4N1FlMngzamtOSCszWDlzbWlwajhNajF4cEhwMmV1d2NNdTlRL1FLWHkw?=
 =?utf-8?B?TzhtWUM4RXJ6SjZ1Z3c1Tm1JTlFxcmNNbmdtQTM3Z05EaWdJdFpvQkZlOUR6?=
 =?utf-8?B?ell4bk9nMFdaRUs1STVzMmVuNC9WZmVrYWl6ZUpzZ0JwTXp5eFU1SUJaRmx0?=
 =?utf-8?B?Skp2UjgzZ2hSYlFiMlVWVU9yTTNhbUh0TW8rMUtQNU02Sm9wTjNzQk1jSXM3?=
 =?utf-8?B?eDdmWDhrQlE4Q1p4RENqb1JLSWRsN1hDRFFoaUJFcDd6ZEJ1K3B5QXM2R2Rm?=
 =?utf-8?B?MWhyNkppeFNBelE3YWdvdE54Y2gvWjBpMDhTRnI0aXU4RHpWd1hLUmJkZWVT?=
 =?utf-8?B?NUcwSk1WTEFNaG5sdnQzL0FwazNOSlpBQ2JYWnFLVm5ZK3ZhUlMxWmR0WUhK?=
 =?utf-8?B?dWVjbDhSQVAzWHowemFFaXJSdTlybnBJelI0Y3oxWGszNUN0eWhudUJXVEM3?=
 =?utf-8?B?MWV4RnhJQ1ZlWEZ4RkpYZXJwOTl0dkJmSDRnWnVsVm9QVEY5L3J5eXc1SEVJ?=
 =?utf-8?B?djhXa2lPVDJNY3pqYlpiMmtXYzV5dGkwMnloMWZlbEdDL1ZNMGZEcjZkTDJT?=
 =?utf-8?B?MTZJTFJpcWRtSG9va0VxTlk0bWRWaHplUnBsTDU5K1NXMWJjWnpNYkNvUDlN?=
 =?utf-8?B?NUpjdnVac2ovSU4wbkw3TkV1Vjd5ODRMLytmQlBuVEZhZUt1VkhSN2JtZmx4?=
 =?utf-8?B?dzl5M2FvVG1jYndGT3dCT2crLzMrWXpJdTVETWNYd2NZbWEvYVFxTzVVYWRR?=
 =?utf-8?B?TThXdDdla2tKbEJvWEM3bnRZVHl2emxqZ2ZyVjgrYnovWVhwdTZ2ZU0wbFI3?=
 =?utf-8?B?UjM3bzJaUytRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZEw0cHdGRFAyekZEN21sZWNBZDRnVVZzdmhiSlJxdlRBSi9FT1RZL25KdG5k?=
 =?utf-8?B?c3BpNlNEWUcxcVZUaHkrc3kxM0ZQNVlTaTdwZ3gxb2doRUo1eDl1OVNOYjg4?=
 =?utf-8?B?MnRnVUF5K0hBZzU1UzRDUi9yM0VmMU9Qd2VOdEdJeXcwSlZ1Ty9pUC9uNFhP?=
 =?utf-8?B?cytVZUsxanhwNW9EZjNYbDlUL3V3aUhPV2p5Y2FkR1pLTDRDeXZQZ3JuQVpX?=
 =?utf-8?B?U0ZYblk5MFlaWWJqaHFyR2U3UzQ0ejZXMjNpOG9GaVMxTUsxL2NRcUkzZGNn?=
 =?utf-8?B?V0ZJVStpK3RxWGYxcllQa1lmc25GQVMzMFJHVVZqMXIvaGc5RXFNYm5Ic1NI?=
 =?utf-8?B?OXkzSVkydVFXbVJGa0lUZTNhM1BHTXdyaWdMemZGOW1qR0NlQ2lBWXE1VFZC?=
 =?utf-8?B?K3lqQVZ2M0psZm5ldTdpZDZpREVwektneVBkZWlEUkVqWEduSEJwdTEzZzNR?=
 =?utf-8?B?dGkzYkdGWnBvaEhaQkwveEdXYk5lQUUzbzNkRzBwQ0p1YUNMM2pLM01jaGZk?=
 =?utf-8?B?TlJIS245b2U5RUVBM09BZitSN3g2OE9ZaUkxY0pDTlhTMHVCdHFBcWJqMnp3?=
 =?utf-8?B?MkFhaHFTVGEvS0FoZjN4ZytBVUxzZW9ML1djWXhmWG1RTC9HSzNkWldVTWVB?=
 =?utf-8?B?WEk5dWNXSzIxd2ppUmd2VkdmaTl6K2JpcENtVHg5YkZocVIvOUV2TTYyc2p0?=
 =?utf-8?B?QlpiQjNZeUFMaXZnanRFTzl6NjJwMVdZbW1nRDZmb21wTS9OYlFsdVhsbDRy?=
 =?utf-8?B?cW5hYXZiYWsxdWJPRm5VK3ZQOGVIY0hrVWhaQjcxVGR5eWppM281Z0Y0MU9o?=
 =?utf-8?B?MUQ1SjhqSnl6bDEvNkVYK0FzZlJ5L3dBZjQ2T2t1eUtrU2ZvMzRDeSsxNTZI?=
 =?utf-8?B?Zm5FVGFMellEM1BRQyt6RUN0cVJSNjlBaUcxQVRseUd3WithcW1xZTJLUHBw?=
 =?utf-8?B?WWN0ejkyN1NGZzI5SVoyRXhSbmJNZ3JPWmNpNWFQTGtHRkdJNWdrampkQlpL?=
 =?utf-8?B?RHlVdytVTytCSVRUZCtBd2JtbWtiZXJlRTg4UGsvQXBGd0FZNUlyOXpUbmx6?=
 =?utf-8?B?Q2xaT3ZNYVpHTlNReHVxdkM2YTZoL3YwMDcvUmFIYkFaeFFrR2RGZWpMbis2?=
 =?utf-8?B?MmNGT3lkVFlGV3pnRDdqSFFkNXhXSWgrdmo0Ynp0S2xFU0MzMEhwMGZWUGFa?=
 =?utf-8?B?K21YVEE1TW5DcU1oZ1NvZ1BldDNJU053U3QzdHFVYVpySCtxTUJNT1p4MHVK?=
 =?utf-8?B?dDRFVklzUmhQS2VFRGpKd0VDSmNJR2xtMXF0VjlsUkhuOVpoSkFBZmJYQzFI?=
 =?utf-8?B?M0hVMjlESytZYVRNbkxGNG4raFlNWktkNHVEQTlhalNTOU9QekVUWmRkeTg4?=
 =?utf-8?B?cXhJQndReTRCdDVYV2NHelk3am83WDZvb3BLZ1RCMTQ5NlltZHNUWnFzL3V4?=
 =?utf-8?B?a2d4anhOSWNNU3Q1QXlTTmR6TU9HL25HckdRRC9QMGRraHZKSHNqQkI5L0Rw?=
 =?utf-8?B?dWE4OTRHN0dEeEdlcXdTT3FBWHJ6N2c4MjFqY2pFNnJLM0JtbzdvRm84YzVS?=
 =?utf-8?B?Q0hKSzFlbTQyRVkydndtWU5CcHo0MmpwUWpZdDF2cTlEa0F6OHhSNi9ncTVU?=
 =?utf-8?B?ZHB6RXNuOXVUM3U4NWc0dDFqWFhwa3JMTDRTQzZNTG1acXJxTUdicWF0OEhG?=
 =?utf-8?B?SDZVTG4xNEVFR3BMMjNXZGp4aDhhWjhnZ09uTUdPRkI4ckprb2pZd0hrcWZD?=
 =?utf-8?B?UFA2a1UzRlptRFUrT21pMHY5UjQ2Tm1RdG1xSXZ5NVBkNmdrREpXL3BQYW1j?=
 =?utf-8?B?SUhRNWlxR3lZalZRL3FoNWpuNVRiTHAvQm9Ua2MyYzUzTlJab1I2MkxqajFz?=
 =?utf-8?B?a1ZtREpNekFsMzR6am9mcTNKMXl5S2pKTHdac3hyeUp3SUJ6Q2EwU3RpL240?=
 =?utf-8?B?Q2lmOW1LMHdoMzh4WDlLNHhVWWlXd0paZFgvdEJZQnpxTGZIaFBVYmRhaUQr?=
 =?utf-8?B?OHY2UmdPU3EwaWM3aVY5aFI4cUVTTjRGNlJhc0ZWNW5Ta1QvcFkvN1VOYnY5?=
 =?utf-8?B?cis4RFhCSm0rWjhoSDRsL2Z2OEU4MThxZFlXemNZK2hzU3VFZDZ5OFJoS1pW?=
 =?utf-8?B?SFVNTm1zSDU1RmpsZkUxN2Zlb3dGUEFLeThvZHpmazJTYlgrSC8ydXo2Q1Zm?=
 =?utf-8?B?T3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bbc0f11-e252-4d72-7d67-08dd7d231812
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 20:13:03.8735
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AM8Dmvz0dMtuFlST09viXmwaEIElUzSTJhuve502fpcPgSeutt4BR3oryKdx+jt1Wf7kIEZv0GhN5ECnt6QczGsObVQGAYUBzjsh+diK9Yg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9251
X-OriginatorOrg: intel.com



On 4/15/2025 4:29 PM, Shannon Nelson wrote:
> From: Brett Creeley <brett.creeley@amd.com>
> 
> The pds_core's adminq is protected by the adminq_lock, which prevents
> more than 1 command to be posted onto it at any one time. This makes it
> so the client drivers cannot simultaneously post adminq commands.
> However, the completions happen in a different context, which means
> multiple adminq commands can be posted sequentially and all waiting
> on completion.
> 
> On the FW side, the backing adminq request queue is only 16 entries
> long and the retry mechanism and/or overflow/stuck prevention is
> lacking. This can cause the adminq to get stuck, so commands are no
> longer processed and completions are no longer sent by the FW.
> 
> As an initial fix, prevent more than 16 outstanding adminq commands so
> there's no way to cause the adminq from getting stuck. This works
> because the backing adminq request queue will never have more than 16
> pending adminq commands, so it will never overflow. This is done by
> reducing the adminq depth to 16.
> 

What happens if a client driver tries to enqueue a request when the
adminq is full? Does it just block until there is space, presumably
holding the adminq_lock the entire time to prevent someone else from
inserting?

