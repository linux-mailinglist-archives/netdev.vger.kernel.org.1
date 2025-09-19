Return-Path: <netdev+bounces-224775-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25470B89907
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 15:01:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3C515A4480
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 13:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9696D30ACFC;
	Fri, 19 Sep 2025 13:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="baVflcet"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851FE2F83D4
	for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 13:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758286844; cv=fail; b=fibBvJdcmPP3qTcjOMNKM5cImkJ7OhOxxppZ3lynthXw55KjxZMbWJF5RpH5RsroaEpM+DPy3ROxtEJN5e0SqWTycJitDk+fEOl7xRB0B1Z88YCT4Mbxg87KE7xYy5DF9z4QG2Z6MbkaeidbQvi/XxqSh7k41z3r6NMzKrWsNBw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758286844; c=relaxed/simple;
	bh=cb67/maXfAB/M2OkM4b7wtiAktO71kDNnAllTkZl0XM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pIv78dX5nSJ45P3Wn4oRgvxgsQHtOgvwFTcWcJKLB0F8jsyTXl6uEcDpZIhHGcVS8N4qYxr+YtsLVP+MCWys6ln4idjITJIfCcHxOYeLgP5/IfXVODJ6TkqW0SHU4RvqRUDJNtUWzNsMvTiLL2jpdDZV4THpEm4/sToDR6bTjt4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=baVflcet; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758286841; x=1789822841;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cb67/maXfAB/M2OkM4b7wtiAktO71kDNnAllTkZl0XM=;
  b=baVflcetDsmLcF8vDclE24vDU3XqOUPU1/ugAiJuwBHYDvPQkqm2iMzo
   ABZpbByqmLQ9sXYw7/Rf1re37UvfBnbadstF2oxa6bphUPwwQ9tfRbTHr
   OmccZr0mzQJgqfIlvVa8GKK1sEweemde7dZkMYCAMNWUMTup741YZ9ijy
   2Iibd3NfEABVdSvU0loo03c0uf7xP6dg3uVwcPb8g4ydKBJZdh5RrHnVl
   NvbLhcE2Vws/R1pCqivAViR/gJDpFyvlesCnIrlQVXHj+nMMiDsdbsYV9
   Xv4CkT1dxd72cFipeK1rK8F5s54X6VvQJJCjzm/0roWSI3fgHi4TujXrQ
   A==;
X-CSE-ConnectionGUID: w9K3bdiySiq2Wmob7fK0HA==
X-CSE-MsgGUID: royb3JPMQPOmbVjYQHlEYA==
X-IronPort-AV: E=McAfee;i="6800,10657,11557"; a="48209962"
X-IronPort-AV: E=Sophos;i="6.18,278,1751266800"; 
   d="scan'208";a="48209962"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 06:00:40 -0700
X-CSE-ConnectionGUID: 1NaoRz9zQlyHrxQm8XGJ8w==
X-CSE-MsgGUID: +X9Pt76ITNKnIxE+4Od7OQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,278,1751266800"; 
   d="scan'208";a="175447503"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 06:00:40 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 19 Sep 2025 06:00:39 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 19 Sep 2025 06:00:39 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.20) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 19 Sep 2025 06:00:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pMAk+c+hdgETBcUzzKRuKSpoNBpAYU0sGhl+12VNoSS6YMjQPny2TubjRNmuNa6m3/l1VtsNnvasdtrJPQQd+WRdjya7Qw9mKdI22HyMFqThEZklZYiGWaerBeKlWLr7vup+VoDn87HCCanCIZNdogDRIYuH9EJzX5dosqITWS1XEDBb8HIPBbcF8RMLyAxUU17+N3/IUy6iW87u92GOMl+7FVHVv0FEWFwObGjOJzIv/INmyPKVKVnUecc+GhD8wANjozElAGB/dSa9MHd+QDbYEbRGkgSBrEVLogsIp/dU3PPNxq2WctX99R4hhIYTSaYIYx9m0xVJykxBH/385A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=giIeGmBq5TeLQSAroZH5ZlmGOIkjrb1ObxxNdwYt/10=;
 b=JxLAmIw5fYx77mo69MZmJ/UFku3oCKT5ErAuRSwGMOem3mErUFuyyLLYXNoDT+TmFs8IM7qHGgVE4PFqmzLgA2eDKSg15GhTHUro1XlClGZtynveUWOKgGouORhF7ICIVdn1vADXfTExSY25+EPR20D8sD19jlPj8y97zyfs+swCiWh57BeMTCKtMC71+ofObJW8srTgPiXeDfIv4l/AxoY4vQOcBxu88KA/9Ui0P35ZdGZNGJqK9yMW/Lt9osMf2xaIjT7lhAnF2BqEkMiaG6TPxKAPeiMh49Deo2BuVdoYaigkZVz7lcFRCixcik3DBM0iies9yZo3QjPoRo6UkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by DM4PR11MB6549.namprd11.prod.outlook.com (2603:10b6:8:8e::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.17; Fri, 19 Sep 2025 13:00:34 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::15b2:ee05:2ae7:cfd6%6]) with mapi id 15.20.9137.012; Fri, 19 Sep 2025
 13:00:34 +0000
Message-ID: <cfae046e-106d-4963-88be-8ca116859538@intel.com>
Date: Fri, 19 Sep 2025 15:00:29 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3] eea: Add basic driver framework for Alibaba
 Elastic Ethernet Adaptor
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, <netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Wen Gu <guwen@linux.alibaba.com>, Philo Lu <lulie@linux.alibaba.com>,
	"Lorenzo Bianconi" <lorenzo@kernel.org>, Vadim Fedorenko
	<vadim.fedorenko@linux.dev>, Lukas Bulwahn <lukas.bulwahn@redhat.com>, Geert
 Uytterhoeven <geert+renesas@glider.be>, Vivian Wang
	<wangruikang@iscas.ac.cn>, "Troy Mitchell"
	<troy.mitchell@linux.spacemit.com>, Dust Li <dust.li@linux.alibaba.com>
References: <20250919014856.20267-1-xuanzhuo@linux.alibaba.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Language: en-US
In-Reply-To: <20250919014856.20267-1-xuanzhuo@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0109.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bb::28) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|DM4PR11MB6549:EE_
X-MS-Office365-Filtering-Correlation-Id: e9249b03-2eca-49fe-27a0-08ddf77c854d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?REpmSk43SGpLL0hVazhUNzZnb0lpVWFCUlphQ1ltcEo2Z1c5OWE3aHArUkM2?=
 =?utf-8?B?cDhadzlUMndROFo3b1RIeVFNUExYMzF4VlF0SUxSbmFOeXJFMFEyQlBEM3o1?=
 =?utf-8?B?dUw1QXExcjRKM1l5SE9QUlRXRmRwbm5UbFdaNU1ESDh5bTNoRG5UVm9lbWM4?=
 =?utf-8?B?ekNaaUtjNUNOQzErUmV6TG1OR1VzZ3RQd2tjMVVtRmFrcU9QSk13aXQ3TEh0?=
 =?utf-8?B?NVFLVEpncFZJd3lHM1F4OTFqcm1WWVh3R3ZOeUY0RE1EeHd4MnhZZUVTRUh1?=
 =?utf-8?B?UmwreFVDZlBYRnhDUDdCNXhONzBDdzRxSHFWejBOWTNvcGFSUFpEVUF0NVAr?=
 =?utf-8?B?N25acUJIUWNYbDg4aW1OYnNuOGZYVlJxSGxmWjd0dk5tOEJvSit3bmhtRTVK?=
 =?utf-8?B?VnhlYVBvelFiN2FUSFY2YUkvblZDUGtTTnBJNFNqU3hOVTJtdkd3Q1Ezc0Z2?=
 =?utf-8?B?ZnVQMjdoOFVsRU9taE5rUXl5a3hNVmlmMGxKRDQ1SWVweVF5aDhCTjNDMFlh?=
 =?utf-8?B?ZFA2cUZUNDZOenNKKy9nZEtFM013UGJpM3VvdVNzM0lkMkM0MVNCYVN2bm5u?=
 =?utf-8?B?TStLSEpvbCt1YjhZMjBCWG9PSU9YL1Y1QUJ2YmtRRUh0eU8wbUFJNHh0MENN?=
 =?utf-8?B?VlF4ZTZ1djVmQ0hVengyWUR1SjFEZmJUbGN6c3loYW9LNTlSQW1lRFBySkx0?=
 =?utf-8?B?RU0rbXhhSW5KMTFSZjQ1bXd2WUJMOE8rT1FxaU5Tc2NnQ3Zxem5RQzRlQkJw?=
 =?utf-8?B?QmdiODZpL0RuUnlDaFJJYVZqUndvZEw3MTgybmNWT3QwbysxQWNYRWlmT0I2?=
 =?utf-8?B?aExqaVR0RmNrVVhNOHVZbWFBb0x3WUQzTjNReTZwRnJ0eklpanpFc3E3K2ZD?=
 =?utf-8?B?MnoyKzN5WHFZWGJUSHlCWmYvU05qcUp1cHBVMGJwUzRXZkhCZ0lrVWkrVEJC?=
 =?utf-8?B?dFBYM0drUjNEaXl4L3FqMlBGNS9rUzlKdDIyenE4eCs4SGVyUnBoOEhGVEkz?=
 =?utf-8?B?Vm93SjIwazRURHp2TEtaVzNDT1BWNktsMEJWdzcxdlhBSnhqTUVtUEVHVExE?=
 =?utf-8?B?Q2ZScjBMQVhCR3M1M3VTMExZQklMb2VqN3VVNmpLcHp4V1F0cFo2K29yVHhN?=
 =?utf-8?B?ZmZ3c01xS05jc1NZc3dzdjYrcVJxeTJFZXlzYlJQd01kMVNVSStzVGRLdWJ3?=
 =?utf-8?B?VUJ4eWZwMkVLVW5XOE1jVjRqNG16WGZ3NGlySitrZXpJejlCZ3R2eVdkRUlW?=
 =?utf-8?B?Z3pLM0loc0N5UFdmOG1CaUFmVytiRDRZbU5pSFFOY3BMckdQM0RPeXZoamor?=
 =?utf-8?B?M1hOQ3RrT3VMYzA2c1dVYjJBYVFLQmpQaEp2bHRMcjlCSnVyV1I2YUhma2JH?=
 =?utf-8?B?Q2IzNFJWbHBrWWdIRTlPMjJreSs0VzdrWkh3NzZNODBjcFVHVzhHUURkQ2xo?=
 =?utf-8?B?eE9KTTVocWwzSHRmbVlvby9IQW1oZ2FmMElBQUZZaVI0UXZVU3k0ZHFMSnp3?=
 =?utf-8?B?bXloTnlPY1hXelpNUnloRGhGTDF2VHIrZmRPZElrWEdsdGEraFlBeExkTW5x?=
 =?utf-8?B?VGpITWtPdlRON2Q5MGwvK2N0QWg0YTlrRGtDd1dlcjlBNGFLYmFQdEhWVERw?=
 =?utf-8?B?OGxLWkk0RXFMM241akkra3kwcnJyeldiN0ErSVpIMWVtelZFa2FacWV5c1Rw?=
 =?utf-8?B?TjNHZ0M0WW92dnRpWFh4SitkZ3FLclhOSHFNMlh4cDZyc2FaMVpBYzNvY0sz?=
 =?utf-8?B?NlZjdXZDbkV2ZllzdkxLaHBxbmVaMFd1TXJYbndFY1BiUUtPc2ZMNkRzT1Vw?=
 =?utf-8?B?UlI0SUErYU4wSWgxTW9xS2tmOXM3ZW5YTTc5V01FL05XeWpOSms1c3R6US9Q?=
 =?utf-8?B?blFkVVpEeHVKaDNKOHBteDlHZGZFdTJPaGswVXB2akZvUjFNbjl5NEhJZG54?=
 =?utf-8?Q?EQBxgNETajM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Uko2MmxFOGFKT01oQkNFa3o2ZFRkY3Zob3FJbHhoUDRjUmhwZFc5eFNIYk9q?=
 =?utf-8?B?dUZvakMvT1M3OHFMaitZbGgyOEtZRVQxekxjT25heGNXbVdrS3Q4TU1NN3ow?=
 =?utf-8?B?S1FkR1hDZ2UzWG1OYTY4SGEwcmdrUVY4Tnk3YkFqM3FMaXVkNmZuS082Nk1I?=
 =?utf-8?B?ZUVabXdVQUZPbTFmWUhKdDdaeTc2aXRRNmt0ai8xeUd6dVdIVTAwcmpRd0NQ?=
 =?utf-8?B?RVVDczJZZzV0M1dGM3k5V29wa212NGhGMkFVcDQ3ZFdNRFVvUE9HN3ZTV1gr?=
 =?utf-8?B?dWJoai9ObTRZbE50Q3lrMGZYeEZNMzU3Nmh4L010dkFmYytwYzZiZFp1a1hM?=
 =?utf-8?B?VnJ0Q3k5NUVwNjd0Z1NzY2cxck5XTHdtVDhlKzBNZmM3ZmFDbHNEWWcwcS9q?=
 =?utf-8?B?SFh3Q2Fwck9hTDlhcUdMRlBSa3htdUxjU1doLzlZbFg2a1BES05NQlJsTTNl?=
 =?utf-8?B?QUlJSnRqTHhLdHV0UGh6R1h6YmQ3c1ZzVU5aWWlLQlBMbFlqdEFvVm1oZ3BK?=
 =?utf-8?B?SjdTZ051UlVQalJ0ajhYbHFLclZWemJkbkZOTXk2aXdkT1NxSDN5TmJadC9i?=
 =?utf-8?B?Nm0yQWY1aGhybkJYbG5CWlNpam41RWRVQ3FUUnhSUFUyeks2Y25vcnFsbFpN?=
 =?utf-8?B?MWFaTW5nei9BZWNuY0Z4NHlxeDFrRVBOaEZSQ2g2d1JDZ0lRVXUzUGVzOEFD?=
 =?utf-8?B?bVZPdmFQOUxCOEJvNU1BUWdUSHYvVkFyT3NBYmVMU1lhZWVWQTR0bUNhdFZh?=
 =?utf-8?B?enFYYlZCekhpMkU0NXJrTkI1UjhkQVZJU0ZwYVpJOGp2ZFZZbUpYNG9GQVZS?=
 =?utf-8?B?YmxhbXA2TmNWa3hPR09vTzNvcjZOZ2NWWnNlQTdNQjVmZCt6Um1lTW9tUGh1?=
 =?utf-8?B?MFlTWlF6M2VmczlBY3d0L0JYb0ZxWnBnWUlOd1FaaHhEWHBYUGZSVWZuUno4?=
 =?utf-8?B?Z2NGVkZJeStOS2hhbUphcDAyVldDUDRQcnlQSnJDS2YweXp0VmVzRzkwcXgr?=
 =?utf-8?B?ZmpwamV6NGNSZVVacFA2aXU0eHdtN2RUTkRBSFUrUnVMbk1mcTVnMkNKa0lW?=
 =?utf-8?B?bGQzb1ZURWNYUUtIVTF0RlZzNkZnWlAzRzgyNitaZVVrekF0eG5xLzlyT3lp?=
 =?utf-8?B?aTByekJheFNYdThhRHVtclhMcys4QVc0UUx2SlU3SGdGNlpwWTJ3UkpXalRV?=
 =?utf-8?B?V0g1bWx3aFBCYlpralZjZ0VYWllnaTRsVTg0c0tBME4rYWVYcUpDVFRiVjJG?=
 =?utf-8?B?TE15eGkyeXBhcmFVUWRzSitEb1dCbjcydFB1WnB0czg3Z1l2RGlBclBrZE9S?=
 =?utf-8?B?RnRQKzFzRGt6cnVmYmhaZ2ZKOENlVUU2MndhaU9CVlo2dFJPRGk4L0lkWUdN?=
 =?utf-8?B?MzcxcFhicWZLMTlTc3BvVFdTVk1PQU9zV21NdzZ2T0RBbmk4ZjhId2c0cU90?=
 =?utf-8?B?YmtvVW13cnFCSy9kcmRCYjN1RFBFRzgwWkh5TzJFa0lxTEpnZnhJZjF4cm52?=
 =?utf-8?B?Q250bThzeWVjaWhWRUJCaWg0Z0pka2s4MkNpd3dORUMzVmdnTkZsSTlYeTRB?=
 =?utf-8?B?SFE1Tko0NGpzMDdTQXFFYkZnODA2QlVqcW43TEltYmpXUUxIbU1lMlFGSy9D?=
 =?utf-8?B?V3JxMDFhWURkTEkxMUVZQXRQWFVtK1dZZjJVWlg5dktwZ3FnU282Y2YxZ1Fm?=
 =?utf-8?B?ZTlmNjMrVVUwcEVVVDdzYmlRaDdXWjJKaVlrWWhvUFRRQUIwVWJNaXlnbjZL?=
 =?utf-8?B?R2cycXh0eHVPaTdwYklrK3lLby9DMXI3Nmp5d2Rkb3lUZVA0TGJzTTk3dFNV?=
 =?utf-8?B?V3JrZXZpWjdBMEJ2U3ZrQXd0MncxOVlqNERiTmxxOXFUQzNHVWNpankrZVFE?=
 =?utf-8?B?WkErbzRiZ3Z6M1UrVUloOHNKN1V2WDlMWWZROUhEQTBVZDZpc2hTMzE3b3pI?=
 =?utf-8?B?OC93UzV1VnF2ZUVvajhRdnRLN3BFVFlCMnBFK0VHZ1BuUjlBeG9LOTJ2RlZO?=
 =?utf-8?B?UUp0MXZ6V0hYc3I0NTg0RXBvQXZmYUtLa05NSGN0YytBS05aZTczaVRxdDVw?=
 =?utf-8?B?ODNpdXJCMzV2dEZGdFlZYnZZNGhRVGFvM0JHcFdvY09oblYzT1hCbW0rY29x?=
 =?utf-8?B?UDM3RlV3SHRXZWdJQVdNLzJlRyt1S2hCTjdKdjM5SmV2MkQ1aHlwT04vZHZB?=
 =?utf-8?B?S2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e9249b03-2eca-49fe-27a0-08ddf77c854d
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 13:00:34.3249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CH5aTc1zpvsd08EF62DL3mA9kH3hZjVPuGtkAaf91R3snaQ3aHibVxz9ZhDcYuul+QOD9ijkCUsv4QtxtOUWZSAz8eKTi2WOEw3U5IHyw6c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6549
X-OriginatorOrg: intel.com

On 9/19/25 03:48, Xuan Zhuo wrote:
> Add a driver framework for EEA that will be available in the future.
> 
> This driver is currently quite minimal, implementing only fundamental
> core functionalities. Key features include: I/O queue management via
> adminq, basic PCI-layer operations, and essential RX/TX data
> communication capabilities. It also supports the creation,
> initialization, and management of network devices (netdev). Furthermore,
> the ring structures for both I/O queues and adminq have been abstracted
> into a simple, unified, and reusable library implementation,
> facilitating future extension and maintenance.
> 
> This commit is indeed quite large, but further splitting it would not be
> meaningful. Historically, many similar drivers have been introduced with
> commits of similar size and scope, so we chose not to invest excessive
> effort into finer-grained splitting.
> 
> Reviewed-by: Dust Li <dust.li@linux.alibaba.com>
> Reviewed-by: Philo Lu <lulie@linux.alibaba.com>
> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

if, by any chance, there were more than you developing this
driver, it is the best moment to give some credit via Co-developed-by
tags to major contributors

please find my feedback inline, sorry for it being in random places,
otherwise it would take a whole day
(but please apply fix for each type of issue per whole series)

> ---
> 
> v3: Thanks for the comments from Paolo Abenchi
> v2: Thanks for the comments from Simon Horman and Andrew Lunn
> v1: Thanks for the comments from Simon Horman and Andrew Lunn
> 
>   MAINTAINERS                                   |   8 +
>   drivers/net/ethernet/Kconfig                  |   1 +
>   drivers/net/ethernet/Makefile                 |   1 +
>   drivers/net/ethernet/alibaba/Kconfig          |  29 +
>   drivers/net/ethernet/alibaba/Makefile         |   5 +
>   drivers/net/ethernet/alibaba/eea/Makefile     |   9 +
>   drivers/net/ethernet/alibaba/eea/eea_adminq.c | 452 ++++++++++
>   drivers/net/ethernet/alibaba/eea/eea_adminq.h |  70 ++
>   drivers/net/ethernet/alibaba/eea/eea_desc.h   | 155 ++++
>   .../net/ethernet/alibaba/eea/eea_ethtool.c    | 310 +++++++
>   .../net/ethernet/alibaba/eea/eea_ethtool.h    |  51 ++
>   drivers/net/ethernet/alibaba/eea/eea_net.c    | 575 +++++++++++++
>   drivers/net/ethernet/alibaba/eea/eea_net.h    | 196 +++++
>   drivers/net/ethernet/alibaba/eea/eea_pci.c    | 574 +++++++++++++
>   drivers/net/ethernet/alibaba/eea/eea_pci.h    |  67 ++
>   drivers/net/ethernet/alibaba/eea/eea_ring.c   | 267 ++++++
>   drivers/net/ethernet/alibaba/eea/eea_ring.h   |  89 ++
>   drivers/net/ethernet/alibaba/eea/eea_rx.c     | 784 ++++++++++++++++++
>   drivers/net/ethernet/alibaba/eea/eea_tx.c     | 405 +++++++++
>   19 files changed, 4048 insertions(+)
>   create mode 100644 drivers/net/ethernet/alibaba/Kconfig
>   create mode 100644 drivers/net/ethernet/alibaba/Makefile
>   create mode 100644 drivers/net/ethernet/alibaba/eea/Makefile
>   create mode 100644 drivers/net/ethernet/alibaba/eea/eea_adminq.c
>   create mode 100644 drivers/net/ethernet/alibaba/eea/eea_adminq.h
>   create mode 100644 drivers/net/ethernet/alibaba/eea/eea_desc.h
>   create mode 100644 drivers/net/ethernet/alibaba/eea/eea_ethtool.c
>   create mode 100644 drivers/net/ethernet/alibaba/eea/eea_ethtool.h
>   create mode 100644 drivers/net/ethernet/alibaba/eea/eea_net.c
>   create mode 100644 drivers/net/ethernet/alibaba/eea/eea_net.h
>   create mode 100644 drivers/net/ethernet/alibaba/eea/eea_pci.c
>   create mode 100644 drivers/net/ethernet/alibaba/eea/eea_pci.h
>   create mode 100644 drivers/net/ethernet/alibaba/eea/eea_ring.c
>   create mode 100644 drivers/net/ethernet/alibaba/eea/eea_ring.h
>   create mode 100644 drivers/net/ethernet/alibaba/eea/eea_rx.c
>   create mode 100644 drivers/net/ethernet/alibaba/eea/eea_tx.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a8a770714101..9ffc6a753842 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -789,6 +789,14 @@ S:	Maintained
>   F:	Documentation/i2c/busses/i2c-ali1563.rst
>   F:	drivers/i2c/busses/i2c-ali1563.c
> 
> +ALIBABA ELASTIC ETHERNET ADAPTOR DRIVER
> +M:	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> +M:	Wen Gu <guwen@linux.alibaba.com>
> +R:	Philo Lu <lulie@linux.alibaba.com>
> +L:	netdev@vger.kernel.org
> +S:	Supported

this is reserved for companies that run netdev-ci tests on their HW

> +F:	drivers/net/ethernet/alibaba/eea
> +
>   ALIBABA ELASTIC RDMA DRIVER
>   M:	Cheng Xu <chengyou@linux.alibaba.com>
>   M:	Kai Shen <kaishen@linux.alibaba.com>
> diff --git a/drivers/net/ethernet/Kconfig b/drivers/net/ethernet/Kconfig
> index aead145dd91d..307c68a4fd53 100644
> --- a/drivers/net/ethernet/Kconfig
> +++ b/drivers/net/ethernet/Kconfig
> @@ -22,6 +22,7 @@ source "drivers/net/ethernet/aeroflex/Kconfig"
>   source "drivers/net/ethernet/agere/Kconfig"
>   source "drivers/net/ethernet/airoha/Kconfig"
>   source "drivers/net/ethernet/alacritech/Kconfig"
> +source "drivers/net/ethernet/alibaba/Kconfig"
>   source "drivers/net/ethernet/allwinner/Kconfig"
>   source "drivers/net/ethernet/alteon/Kconfig"
>   source "drivers/net/ethernet/altera/Kconfig"
> diff --git a/drivers/net/ethernet/Makefile b/drivers/net/ethernet/Makefile
> index 998dd628b202..358d88613cf4 100644
> --- a/drivers/net/ethernet/Makefile
> +++ b/drivers/net/ethernet/Makefile
> @@ -12,6 +12,7 @@ obj-$(CONFIG_NET_VENDOR_ADI) += adi/
>   obj-$(CONFIG_NET_VENDOR_AGERE) += agere/
>   obj-$(CONFIG_NET_VENDOR_AIROHA) += airoha/
>   obj-$(CONFIG_NET_VENDOR_ALACRITECH) += alacritech/
> +obj-$(CONFIG_NET_VENDOR_ALIBABA) += alibaba/
>   obj-$(CONFIG_NET_VENDOR_ALLWINNER) += allwinner/
>   obj-$(CONFIG_NET_VENDOR_ALTEON) += alteon/
>   obj-$(CONFIG_ALTERA_TSE) += altera/
> diff --git a/drivers/net/ethernet/alibaba/Kconfig b/drivers/net/ethernet/alibaba/Kconfig
> new file mode 100644
> index 000000000000..4040666ce129
> --- /dev/null
> +++ b/drivers/net/ethernet/alibaba/Kconfig
> @@ -0,0 +1,29 @@
> +#
> +# Alibaba network device configuration
> +#
> +
> +config NET_VENDOR_ALIBABA
> +	bool "Alibaba Devices"
> +	default y
> +	help
> +	  If you have a network (Ethernet) device belonging to this class, say Y.
> +
> +	  Note that the answer to this question doesn't directly affect the

I would say it does (at least with your proposed `default m` below)

> +	  kernel: saying N will just cause the configurator to skip all
> +	  the questions about Alibaba devices. If you say Y, you will be asked
> +	  for your specific device in the following questions.
> +
> +if NET_VENDOR_ALIBABA
> +
> +config EEA
> +	tristate "Alibaba Elastic Ethernet Adaptor support"
> +	depends on PCI_MSI
> +	depends on 64BIT
> +	select PAGE_POOL
> +	default m
> +	help
> +	  This driver supports Alibaba Elastic Ethernet Adaptor"
> +
> +	  To compile this driver as a module, choose M here.
> +
> +endif #NET_VENDOR_ALIBABA
> diff --git a/drivers/net/ethernet/alibaba/Makefile b/drivers/net/ethernet/alibaba/Makefile
> new file mode 100644
> index 000000000000..7980525cb086
> --- /dev/null
> +++ b/drivers/net/ethernet/alibaba/Makefile
> @@ -0,0 +1,5 @@
> +#
> +# Makefile for the Alibaba network device drivers.
> +#
> +
> +obj-$(CONFIG_EEA) += eea/
> diff --git a/drivers/net/ethernet/alibaba/eea/Makefile b/drivers/net/ethernet/alibaba/eea/Makefile
> new file mode 100644
> index 000000000000..bf2dad05e09a
> --- /dev/null
> +++ b/drivers/net/ethernet/alibaba/eea/Makefile
> @@ -0,0 +1,9 @@
> +
> +obj-$(CONFIG_EEA) += eea.o
> +eea-objs := eea_ring.o \

eea-y := ...
as *-objs suffix is reserved rather for (user-space) host programs while
     usually *-y suffix is used for kernel drivers (although *-objs works
     for that purpose for now).

would be also good to start with this (and other, like #includes) lists
sorted

> +	eea_net.o \
> +	eea_pci.o \
> +	eea_adminq.o \
> +	eea_ethtool.o \
> +	eea_tx.o \
> +	eea_rx.o
> diff --git a/drivers/net/ethernet/alibaba/eea/eea_adminq.c b/drivers/net/ethernet/alibaba/eea/eea_adminq.c
> new file mode 100644
> index 000000000000..625dd27bfb5d
> --- /dev/null
> +++ b/drivers/net/ethernet/alibaba/eea/eea_adminq.c
> @@ -0,0 +1,452 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Driver for Alibaba Elastic Ethernet Adaptor.
> + *
> + * Copyright (C) 2025 Alibaba Inc.
> + */
> +
> +#include <linux/etherdevice.h>
> +#include <linux/utsname.h>
> +#include <linux/iopoll.h>
> +#include <linux/version.h>

would be great to sort includes
BTW, do you need version.h? (IWYU, but not more)

> +
> +#include "eea_net.h"
> +#include "eea_ring.h"
> +#include "eea_adminq.h"
> +#include "eea_pci.h"
> +
> +#define EEA_AQ_CMD_CFG_QUERY         ((0 << 8) | 0)
> +
> +#define EEA_AQ_CMD_QUEUE_CREATE      ((1 << 8) | 0)
> +#define EEA_AQ_CMD_QUEUE_DESTROY_ALL ((1 << 8) | 1)
> +#define EEA_AQ_CMD_QUEUE_DESTROY_Q   ((1 << 8) | 2)
> +
> +#define EEA_AQ_CMD_HOST_INFO         ((2 << 8) | 0)
> +
> +#define EEA_AQ_CMD_DEV_STATUS        ((3 << 8) | 0)
> +
> +#define ERING_DESC_F_AQ_PHASE	     (BIT(15) | BIT(7))

EEA_ prefix

> +
> +struct eea_aq_create {
> +#define EEA_QUEUE_FLAGS_HW_SPLIT_HDR BIT(0)
> +#define EEA_QUEUE_FLAGS_SQCQ         BIT(1)
> +#define EEA_QUEUE_FLAGS_HWTS         BIT(2)

move #defines out ouf struct definitions

> +	__le32 flags;
> +	/* queue index.
> +	 * rx: 0 == qidx % 2
> +	 * tx: 1 == qidx % 2
> +	 */
> +	__le16 qidx;
> +	/* the depth of the queue */
> +	__le16 depth;
> +	/*  0: without SPLIT HDR
> +	 *  1: 128B
> +	 *  2: 256B
> +	 *  3: 512B
> +	 */
> +	u8 hdr_buf_size;
> +	u8 sq_desc_size;
> +	u8 cq_desc_size;
> +	u8 reserve0;
> +	/* The vector for the irq. rx,tx share the same vector */
> +	__le16 msix_vector;
> +	__le16 reserve;
> +	/* sq ring cfg. */
> +	__le32 sq_addr_low;
> +	__le32 sq_addr_high;
> +	/* cq ring cfg. Just valid when flags include EEA_QUEUE_FLAGS_SQCQ. */
> +	__le32 cq_addr_low;
> +	__le32 cq_addr_high;
> +};
> +
> +struct aq_queue_drv_status {

add eea_ prefix to all your structs, fuctions, and defines

> +	__le16 qidx;
> +
> +	__le16 sq_head;
> +	__le16 cq_head;
> +	__le16 reserved;
> +};
> +
> +struct eea_aq_host_info_cfg {
> +#define EEA_OS_DISTRO		0
> +#define EEA_DRV_TYPE		0
> +#define EEA_OS_LINUX		1
> +#define EEA_SPEC_VER_MAJOR	1
> +#define EEA_SPEC_VER_MINOR	0
> +	__le16	os_type;        /* Linux, Win.. */

really?

> +	__le16	os_dist;
> +	__le16	drv_type;
> +
> +	__le16	kern_ver_major;
> +	__le16	kern_ver_minor;
> +	__le16	kern_ver_sub_minor;
> +
> +	__le16	drv_ver_major;
> +	__le16	drv_ver_minor;
> +	__le16	drv_ver_sub_minor;
> +
> +	__le16	spec_ver_major;
> +	__le16	spec_ver_minor;
> +	__le16	pci_bdf;
> +	__le32	pci_domain;
> +
> +	u8      os_ver_str[64];
> +	u8      isa_str[64];
> +};
> +
> +struct eea_aq_host_info_rep {
> +#define EEA_HINFO_MAX_REP_LEN	1024
> +#define EEA_HINFO_REP_PASS	1
> +#define EEA_HINFO_REP_REJECT	2
> +	u8	op_code;
> +	u8	has_reply;
> +	u8	reply_str[EEA_HINFO_MAX_REP_LEN];
> +};
> +
> +static struct ering *qid_to_ering(struct eea_net *enet, u32 qid)
> +{
> +	struct ering *ering;
> +
> +	if (qid % 2 == 0)
> +		ering = enet->rx[qid / 2]->ering;
> +	else
> +		ering = enet->tx[qid / 2].ering;
> +
> +	return ering;
> +}
> +
> +#define EEA_AQ_TIMEOUT_US (60 * 1000 * 1000)
> +
> +static int eea_adminq_submit(struct eea_net *enet, u16 cmd,
> +			     dma_addr_t req_addr, dma_addr_t res_addr,
> +			     u32 req_size, u32 res_size)
> +{
> +	struct eea_aq_cdesc *cdesc;
> +	struct eea_aq_desc *desc;
> +	int ret;
> +
> +	desc = ering_aq_alloc_desc(enet->adminq.ring);
> +
> +	desc->classid = cmd >> 8;
> +	desc->command = cmd & 0xff;
> +
> +	desc->data_addr = cpu_to_le64(req_addr);
> +	desc->data_len = cpu_to_le32(req_size);
> +
> +	desc->reply_addr = cpu_to_le64(res_addr);
> +	desc->reply_len = cpu_to_le32(res_size);
> +
> +	/* for update flags */
> +	wmb();
> +
> +	desc->flags = cpu_to_le16(enet->adminq.phase);
> +
> +	ering_sq_commit_desc(enet->adminq.ring);
> +
> +	ering_kick(enet->adminq.ring);
> +
> +	++enet->adminq.num;
> +
> +	if ((enet->adminq.num % enet->adminq.ring->num) == 0)
> +		enet->adminq.phase ^= ERING_DESC_F_AQ_PHASE;
> +
> +	ret = read_poll_timeout(ering_cq_get_desc, cdesc, cdesc, 0,
> +				EEA_AQ_TIMEOUT_US, false, enet->adminq.ring);
> +	if (ret)
> +		return ret;
> +
> +	ret = le32_to_cpu(cdesc->status);
> +
> +	ering_cq_ack_desc(enet->adminq.ring, 1);
> +
> +	if (ret)
> +		netdev_err(enet->netdev,
> +			   "adminq exec failed. cmd: %d ret %d\n", cmd, ret);
> +
> +	return ret;
> +}
> +
> +static int eea_adminq_exec(struct eea_net *enet, u16 cmd,
> +			   void *req, u32 req_size, void *res, u32 res_size)
> +{
> +	dma_addr_t req_addr, res_addr;
> +	struct device *dma;
> +	int ret;
> +
> +	dma = enet->edev->dma_dev;
> +
> +	req_addr = 0;
> +	res_addr = 0;
> +
> +	if (req) {
> +		req_addr = dma_map_single(dma, req, req_size, DMA_TO_DEVICE);

no idea how much adminq you need to send, but it feels wrong to do dma
mapping each time

> +		if (unlikely(dma_mapping_error(dma, req_addr)))
> +			return -ENOMEM;
> +	}
> +
> +	if (res) {
> +		res_addr = dma_map_single(dma, res, res_size, DMA_FROM_DEVICE);
> +		if (unlikely(dma_mapping_error(dma, res_addr))) {
> +			ret = -ENOMEM;
> +			goto err_map_res;
> +		}
> +	}
> +
> +	ret = eea_adminq_submit(enet, cmd, req_addr, res_addr,
> +				req_size, res_size);
> +
> +	if (res)
> +		dma_unmap_single(dma, res_addr, res_size, DMA_FROM_DEVICE);
> +
> +err_map_res:
> +	if (req)
> +		dma_unmap_single(dma, req_addr, req_size, DMA_TO_DEVICE);
> +
> +	return ret;
> +}
> +
> +void eea_destroy_adminq(struct eea_net *enet)
> +{
> +	/* Unactive adminq by device reset. So the device reset should be called

s/Unactive/Deactivate/
but this comment does not belong here, rather to the caller/s

> +	 * before this.
> +	 */
> +	if (enet->adminq.ring) {
> +		ering_free(enet->adminq.ring);
> +		enet->adminq.ring = NULL;
> +		enet->adminq.phase = 0;
> +	}
> +}
> +
> +int eea_create_adminq(struct eea_net *enet, u32 qid)
> +{
> +	struct ering *ering;
> +	int err;
> +
> +	ering = ering_alloc(qid, 64, enet->edev, sizeof(struct eea_aq_desc),
> +			    sizeof(struct eea_aq_desc), "adminq");
> +	if (!ering)
> +		return -ENOMEM;
> +
> +	err = eea_pci_active_aq(ering);
> +	if (err) {
> +		ering_free(ering);
> +		return -EBUSY;
> +	}
> +
> +	enet->adminq.ring = ering;
> +	enet->adminq.phase = BIT(7);
> +	enet->adminq.num = 0;
> +
> +	/* set device ready to active adminq */
> +	eea_device_ready(enet->edev);
> +
> +	return 0;
> +}
> +
> +int eea_adminq_query_cfg(struct eea_net *enet, struct eea_aq_cfg *cfg)
> +{
> +	return eea_adminq_exec(enet, EEA_AQ_CMD_CFG_QUERY, NULL, 0, cfg,
> +			       sizeof(*cfg));
> +}
> +
> +static void qcfg_fill(struct eea_aq_create *qcfg, struct ering *ering,
> +		      u32 flags)
> +{
> +	qcfg->flags = cpu_to_le32(flags);
> +	qcfg->qidx = cpu_to_le16(ering->index);
> +	qcfg->depth = cpu_to_le16(ering->num);
> +
> +	qcfg->hdr_buf_size = flags & EEA_QUEUE_FLAGS_HW_SPLIT_HDR ? 1 : 0;

x = !!y instead of x = y ? 1 : 0
(when needed to map to 0/1)

> +	qcfg->sq_desc_size = ering->sq.desc_size;
> +	qcfg->cq_desc_size = ering->cq.desc_size;
> +	qcfg->msix_vector = cpu_to_le16(ering->msix_vec);
> +
> +	qcfg->sq_addr_low = cpu_to_le32(ering->sq.dma_addr);
> +	qcfg->sq_addr_high = cpu_to_le32(ering->sq.dma_addr >> 32);
> +
> +	qcfg->cq_addr_low = cpu_to_le32(ering->cq.dma_addr);
> +	qcfg->cq_addr_high = cpu_to_le32(ering->cq.dma_addr >> 32);
> +}
> +
> +int eea_adminq_create_q(struct eea_net *enet, u32 qidx, u32 num, u32 flags)
> +{
> +	struct device *dev = enet->edev->dma_dev;
> +	int i, err, db_size, q_size, qid;
> +	struct eea_aq_create *q_buf;
> +	dma_addr_t db_dma, q_dma;
> +	struct eea_net_cfg *cfg;
> +	struct ering *ering;
> +	__le32 *db_buf;
> +
> +	err = -ENOMEM;
> +
> +	cfg = &enet->cfg;
> +
> +	if (cfg->split_hdr)
> +		flags |= EEA_QUEUE_FLAGS_HW_SPLIT_HDR;
> +
> +	flags |= EEA_QUEUE_FLAGS_SQCQ;
> +	flags |= EEA_QUEUE_FLAGS_HWTS;
> +
> +	db_size = sizeof(int) * num;
> +	q_size = sizeof(struct eea_aq_create) * num;

would be best to use struct_size()

> +
> +	db_buf = dma_alloc_coherent(dev, db_size, &db_dma, GFP_KERNEL);
> +	if (!db_buf)
> +		return err;
> +
> +	q_buf = dma_alloc_coherent(dev, q_size, &q_dma, GFP_KERNEL);
> +	if (!q_buf)
> +		goto err_db;
> +
> +	qid = qidx;
> +	for (i = 0; i < num; i++, qid++)
> +		qcfg_fill(q_buf + i, qid_to_ering(enet, qid), flags);
> +
> +	err = eea_adminq_exec(enet, EEA_AQ_CMD_QUEUE_CREATE,
> +			      q_buf, q_size, db_buf, db_size);
> +	if (err)
> +		goto err;
> +	err = 0;

this assignement makes no sense (please check if there is something
missing in your source)

> +
> +	qid = qidx;
> +	for (i = 0; i < num; i++, qid++) {
> +		ering = qid_to_ering(enet, qid);
> +		ering->db = eea_pci_db_addr(ering->edev,
> +					    le32_to_cpu(db_buf[i]));
> +	}
> +
> +err:
> +	dma_free_coherent(dev, q_size, q_buf, q_dma);
> +err_db:
> +	dma_free_coherent(dev, db_size, db_buf, db_dma);
> +	return err;
> +}
> +
> +int eea_adminq_destroy_q(struct eea_net *enet, u32 qidx, int num)
> +{
> +	struct device *dev = enet->edev->dma_dev;
> +	dma_addr_t dma_addr;
> +	__le16 *buf;
> +	u32 size;
> +	int i;
> +
> +	if (qidx == 0 && num == -1)
> +		return eea_adminq_exec(enet, EEA_AQ_CMD_QUEUE_DESTROY_ALL,
> +				       NULL, 0, NULL, 0);
> +
> +	size = sizeof(__le16) * num;
> +	buf = dma_alloc_coherent(dev, size, &dma_addr, GFP_KERNEL);
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < num; ++i)
> +		buf[i] = cpu_to_le16(qidx++);
> +
> +	return eea_adminq_exec(enet, EEA_AQ_CMD_QUEUE_DESTROY_Q,
> +			       buf, size, NULL, 0);
> +}
> +
> +struct aq_dev_status *eea_adminq_dev_status(struct eea_net *enet)
> +{
> +	struct aq_queue_drv_status *drv_status;
> +	struct aq_dev_status *dev_status;
> +	int err, i, num, size;
> +	struct ering *ering;
> +	void *rep, *req;
> +
> +	num = enet->cfg.tx_ring_num * 2 + 1;
> +
> +	req = kcalloc(num, sizeof(struct aq_queue_drv_status), GFP_KERNEL);

sizeof(*ptr) instead of sizeof(type) when possible

> +	if (!req)
> +		return NULL;
> +
> +	size = struct_size(dev_status, q_status, num);
> +
> +	rep = kmalloc(size, GFP_KERNEL);
> +	if (!rep) {
> +		kfree(req);
> +		return NULL;
> +	}
> +
> +	drv_status = req;
> +	for (i = 0; i < enet->cfg.rx_ring_num * 2; ++i, ++drv_status) {
> +		ering = qid_to_ering(enet, i);
> +		drv_status->qidx = cpu_to_le16(i);
> +		drv_status->cq_head = cpu_to_le16(ering->cq.head);
> +		drv_status->sq_head = cpu_to_le16(ering->sq.head);
> +	}
> +
> +	drv_status->qidx = cpu_to_le16(i);
> +	drv_status->cq_head = cpu_to_le16(enet->adminq.ring->cq.head);
> +	drv_status->sq_head = cpu_to_le16(enet->adminq.ring->sq.head);
> +
> +	err = eea_adminq_exec(enet, EEA_AQ_CMD_DEV_STATUS,
> +			      req, num * sizeof(struct aq_queue_drv_status),
> +			      rep, size);
> +	kfree(req);
> +	if (err) {
> +		kfree(rep);
> +		return NULL;
> +	}
> +
> +	return rep;
> +}
> +
> +int eea_adminq_config_host_info(struct eea_net *enet)
> +{
> +	struct device *dev = enet->edev->dma_dev;
> +	struct eea_aq_host_info_cfg *cfg;
> +	struct eea_aq_host_info_rep *rep;
> +	int rc = -ENOMEM;
> +
> +	cfg = kzalloc(sizeof(*cfg), GFP_KERNEL);
> +	if (!cfg)
> +		return rc;
> +
> +	rep = kzalloc(sizeof(*rep), GFP_KERNEL);
> +	if (!rep)
> +		goto free_cfg;
> +
> +	cfg->os_type            = cpu_to_le16(EEA_OS_LINUX);
> +	cfg->os_dist            = cpu_to_le16(EEA_OS_DISTRO);
> +	cfg->drv_type           = cpu_to_le16(EEA_DRV_TYPE);
> +
> +	cfg->kern_ver_major     = cpu_to_le16(LINUX_VERSION_MAJOR);
> +	cfg->kern_ver_minor     = cpu_to_le16(LINUX_VERSION_PATCHLEVEL);
> +	cfg->kern_ver_sub_minor = cpu_to_le16(LINUX_VERSION_SUBLEVEL);
> +
> +	cfg->drv_ver_major      = cpu_to_le16(EEA_VER_MAJOR);
> +	cfg->drv_ver_minor      = cpu_to_le16(EEA_VER_MINOR);
> +	cfg->drv_ver_sub_minor  = cpu_to_le16(EEA_VER_SUB_MINOR);
> +
> +	cfg->spec_ver_major     = cpu_to_le16(EEA_SPEC_VER_MAJOR);
> +	cfg->spec_ver_minor     = cpu_to_le16(EEA_SPEC_VER_MINOR);
> +
> +	cfg->pci_bdf            = cpu_to_le16(eea_pci_dev_id(enet->edev));
> +	cfg->pci_domain         = cpu_to_le32(eea_pci_domain_nr(enet->edev));
> +
> +	strscpy(cfg->os_ver_str, utsname()->release, sizeof(cfg->os_ver_str));
> +	strscpy(cfg->isa_str, utsname()->machine, sizeof(cfg->isa_str));

what is the benefit of this?

> +
> +	rc = eea_adminq_exec(enet, EEA_AQ_CMD_HOST_INFO,
> +			     cfg, sizeof(*cfg), rep, sizeof(*rep));
> +
> +	if (!rc) {
> +		if (rep->op_code == EEA_HINFO_REP_REJECT) {
> +			dev_err(dev, "Device has refused the initialization "
> +				"due to provided host information\n");

do not break strings that users are supposed to grep for

> +			rc = -ENODEV;
> +		}
> +		if (rep->has_reply) {
> +			rep->reply_str[EEA_HINFO_MAX_REP_LEN - 1] = '\0';
> +			dev_warn(dev, "Device replied in host_info config: %s",
> +				 rep->reply_str);
> +		}
> +	}
> +
> +	kfree(rep);
> +free_cfg:
> +	kfree(cfg);
> +	return rc;
> +}



> +static void eea_stats_fill_for_q(struct u64_stats_sync *syncp, u32 num,
> +				 const struct eea_stat_desc *desc,
> +				 u64 *data, u32 idx)
> +{
> +	void *stats_base = (void *)syncp;

needles cast

> +	u32 start, i;
> +
> +	do {
> +		start = u64_stats_fetch_begin(syncp);
> +		for (i = 0; i < num; i++)
> +			data[idx + i] =
> +				u64_stats_read(stats_base + desc[i].offset);

nice trick

> +
> +	} while (u64_stats_fetch_retry(syncp, start));
> +}
> +



> +static int eea_netdev_init_features(struct net_device *netdev,
> +				    struct eea_net *enet,
> +				    struct eea_device *edev)
> +{
> +	struct eea_aq_cfg *cfg __free(kfree) = NULL;
> +	int err;
> +	u32 mtu;
> +
> +	cfg = kmalloc(sizeof(*cfg), GFP_KERNEL);
> +
> +	err = eea_adminq_query_cfg(enet, cfg);
> +

no blank line between value assignement and error check

> +	if (err)
> +		return err;
> +
> +	eea_update_cfg(enet, edev, cfg);
> +
> +	netdev->priv_flags |= IFF_UNICAST_FLT;
> +	netdev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
> +
> +	netdev->hw_features |= NETIF_F_HW_CSUM;
> +	netdev->hw_features |= NETIF_F_GRO_HW;
> +	netdev->hw_features |= NETIF_F_SG;
> +	netdev->hw_features |= NETIF_F_TSO;
> +	netdev->hw_features |= NETIF_F_TSO_ECN;
> +	netdev->hw_features |= NETIF_F_TSO6;
> +	netdev->hw_features |= NETIF_F_GSO_UDP_L4;
> +
> +	netdev->features |= NETIF_F_HIGHDMA;
> +	netdev->features |= NETIF_F_HW_CSUM;
> +	netdev->features |= NETIF_F_SG;
> +	netdev->features |= NETIF_F_GSO_ROBUST;
> +	netdev->features |= netdev->hw_features & NETIF_F_ALL_TSO;
> +	netdev->features |= NETIF_F_RXCSUM;
> +	netdev->features |= NETIF_F_GRO_HW;
> +
> +	netdev->vlan_features = netdev->features;
> +
> +	eth_hw_addr_set(netdev, cfg->mac);
> +
> +	enet->speed = SPEED_UNKNOWN;
> +	enet->duplex = DUPLEX_UNKNOWN;
> +
> +	netdev->min_mtu = ETH_MIN_MTU;
> +
> +	mtu = le16_to_cpu(cfg->mtu);
> +	if (mtu < netdev->min_mtu) {
> +		dev_err(edev->dma_dev, "The device gave us an invalid MTU. "
> +			"Here we can only exit the initialization. %d < %d",
> +			mtu, netdev->min_mtu);
> +		return -EINVAL;
> +	}
> +
> +	netdev->mtu = mtu;
> +
> +	/* If jumbo frames are already enabled, then the returned MTU will be a
> +	 * jumbo MTU, and the driver will automatically enable jumbo frame
> +	 * support by default.
> +	 */
> +	netdev->max_mtu = mtu;
> +
> +	netif_carrier_on(netdev);
> +
> +	return 0;
> +}
> +
> +static const struct net_device_ops eea_netdev = {
> +	.ndo_open           = eea_netdev_open,
> +	.ndo_stop           = eea_netdev_stop,
> +	.ndo_start_xmit     = eea_tx_xmit,
> +	.ndo_validate_addr  = eth_validate_addr,
> +	.ndo_get_stats64    = eea_stats,
> +	.ndo_features_check = passthru_features_check,
> +	.ndo_tx_timeout     = eea_tx_timeout,
> +};
> +
> +static struct eea_net *eea_netdev_alloc(struct eea_device *edev, u32 pairs)
> +{
> +	struct net_device *netdev;
> +	struct eea_net *enet;
> +
> +	netdev = alloc_etherdev_mq(sizeof(struct eea_net), pairs);
> +	if (!netdev) {
> +		dev_err(edev->dma_dev,
> +			"alloc_etherdev_mq failed with pairs %d\n", pairs);
> +		return NULL;
> +	}
> +
> +	netdev->netdev_ops = &eea_netdev;
> +	netdev->ethtool_ops = &eea_ethtool_ops;
> +	SET_NETDEV_DEV(netdev, edev->dma_dev);
> +
> +	enet = netdev_priv(netdev);
> +	enet->netdev = netdev;
> +	enet->edev = edev;
> +	edev->enet = enet;
> +
> +	return enet;
> +}
> +
> +static void eea_update_ts_off(struct eea_device *edev, struct eea_net *enet)
> +{
> +	u64 ts;
> +
> +	ts = eea_pci_device_ts(edev);
> +
> +	enet->hw_ts_offset = ktime_get_real() - ts;
> +}
> +
> +static int eea_net_reprobe(struct eea_device *edev)
> +{
> +	struct eea_net *enet = edev->enet;
> +	int err = 0;
> +
> +	enet->edev = edev;
> +
> +	if (!enet->adminq.ring) {
> +		err = eea_create_adminq(enet, edev->rx_num + edev->tx_num);
> +		if (err)
> +			return err;
> +	}
> +
> +	eea_update_ts_off(edev, enet);
> +
> +	if (edev->ha_reset_netdev_running) {
> +		rtnl_lock();
> +		enet->link_err = 0;
> +		err = eea_netdev_open(enet->netdev);
> +		rtnl_unlock();
> +	}
> +
> +	return err;
> +}
> +
> +int eea_net_probe(struct eea_device *edev)
> +{
> +	struct eea_net *enet;
> +	int err = -ENOMEM;
> +
> +	if (edev->ha_reset)
> +		return eea_net_reprobe(edev);
> +
> +	enet = eea_netdev_alloc(edev, edev->rx_num);
> +	if (!enet)
> +		return -ENOMEM;
> +
> +	err = eea_create_adminq(enet, edev->rx_num + edev->tx_num);
> +	if (err)
> +		goto err_adminq;

would be best to name goto labels after what they do instead of
from-where-you-jump-there

> +
> +	err = eea_adminq_config_host_info(enet);
> +	if (err)
> +		goto err_hinfo;
> +
> +	err = eea_netdev_init_features(enet->netdev, enet, edev);
> +	if (err)
> +		goto err_feature;
> +
> +	err = register_netdev(enet->netdev);
> +	if (err)
> +		goto err_ready;
> +
> +	eea_update_ts_off(edev, enet);
> +	netif_carrier_off(enet->netdev);
> +
> +	netdev_dbg(enet->netdev, "eea probe success.\n");
> +
> +	return 0;
> +
> +err_ready:
> +err_feature:
> +err_hinfo:
> +	eea_device_reset(edev);
> +	eea_destroy_adminq(enet);
> +
> +err_adminq:
> +	free_netdev(enet->netdev);
> +	return err;
> +}
> +
> +void eea_net_remove(struct eea_device *edev)
> +{
> +	struct net_device *netdev;
> +	struct eea_net *enet;
> +
> +	enet = edev->enet;
> +	netdev = enet->netdev;
> +
> +	if (edev->ha_reset) {
> +		edev->ha_reset_netdev_running = false;
> +		if (netif_running(enet->netdev)) {
> +			rtnl_lock();
> +			eea_netdev_stop(enet->netdev);
> +			enet->link_err = EEA_LINK_ERR_HA_RESET_DEV;
> +			enet->edev = NULL;
> +			rtnl_unlock();
> +			edev->ha_reset_netdev_running = true;
> +		}
> +	} else {
> +		unregister_netdev(netdev);
> +		netdev_dbg(enet->netdev, "eea removed.\n");
> +	}
> +
> +	eea_device_reset(edev);
> +
> +	/* free adminq */

please remove comments that say nothing more that code around

> +	eea_destroy_adminq(enet);
> +
> +	if (!edev->ha_reset)
> +		free_netdev(netdev);
> +}
> diff --git a/drivers/net/ethernet/alibaba/eea/eea_net.h b/drivers/net/ethernet/alibaba/eea/eea_net.h
> new file mode 100644
> index 000000000000..74e6a76c1f7f
> --- /dev/null
> +++ b/drivers/net/ethernet/alibaba/eea/eea_net.h
> @@ -0,0 +1,196 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Driver for Alibaba Elastic Ethernet Adaptor.
> + *
> + * Copyright (C) 2025 Alibaba Inc.
> + */
> +
> +#ifndef __EEA_NET_H__
> +#define __EEA_NET_H__
> +
> +#include <linux/netdevice.h>
> +#include <linux/ethtool.h>
> +
> +#include "eea_ring.h"
> +#include "eea_ethtool.h"
> +#include "eea_adminq.h"
> +
> +#define EEA_VER_MAJOR		1
> +#define EEA_VER_MINOR		0
> +#define EEA_VER_SUB_MINOR	0
> +
> +struct eea_tx_meta;
> +
> +struct eea_reprobe {

would be best to name structs as nouns, and reserve verbs for functions

> +	struct eea_net *enet;
> +	bool running_before_reprobe;
> +};
> +
> +struct enet_tx {
> +	struct eea_net *enet;
> +
> +	struct ering *ering;
> +
> +	struct eea_tx_meta *meta;
> +	struct eea_tx_meta *free;
> +
> +	struct device *dma_dev;
> +
> +	u32 index;
> +
> +	char name[16];
> +
> +	struct eea_tx_stats stats;
> +};
> +
> +struct eea_rx_meta {
> +	struct eea_rx_meta *next;
> +
> +	struct page *page;
> +	dma_addr_t dma;
> +	u32 offset;
> +	u32 frags;
> +
> +	struct page *hdr_page;
> +	void *hdr_addr;
> +	dma_addr_t hdr_dma;
> +
> +	u32 id;
> +
> +	u32 truesize;
> +	u32 headroom;
> +	u32 tailroom;
> +	u32 room;
> +
> +	u32 len;
> +};
> +
> +struct enet_rx_pkt_ctx {
> +	u16 idx;
> +
> +	bool data_valid;
> +	bool do_drop;
> +
> +	struct sk_buff *head_skb;
> +	struct sk_buff *curr_skb;
> +};
> +
> +struct enet_rx {
> +	struct eea_net *enet;
> +
> +	struct ering *ering;
> +
> +	struct eea_rx_meta *meta;
> +	struct eea_rx_meta *free;
> +
> +	struct device *dma_dev;
> +
> +	u32 index;
> +
> +	u32 flags;
> +
> +	u32 headroom;
> +
> +	struct napi_struct napi;
> +
> +	struct eea_rx_stats stats;
> +
> +	u16 irq_n;
> +
> +	char name[16];

IFNAMSIZ?

> +
> +	struct enet_rx_pkt_ctx pkt;
> +
> +	struct page_pool *pp;
> +};
> +
> +struct eea_net_cfg {
> +	u32 rx_ring_depth;
> +	u32 tx_ring_depth;
> +	u32 rx_ring_num;
> +	u32 tx_ring_num;
> +
> +	u8 rx_sq_desc_size;
> +	u8 rx_cq_desc_size;
> +	u8 tx_sq_desc_size;
> +	u8 tx_cq_desc_size;
> +
> +	u32 split_hdr;
> +
> +	struct hwtstamp_config ts_cfg;
> +};
> +
> +struct eea_net_tmp {
> +	struct eea_net_cfg   cfg;
> +
> +	struct enet_tx      *tx;
> +	struct enet_rx     **rx;
> +
> +	struct net_device   *netdev;
> +	struct eea_device   *edev;
> +};
> +
> +enum {
> +	EEA_LINK_ERR_NONE,
> +	EEA_LINK_ERR_HA_RESET_DEV,
> +	EEA_LINK_ERR_LINK_DOWN,
> +};
> +
> +struct eea_net {
> +	struct eea_device *edev;
> +	struct net_device *netdev;
> +
> +	struct eea_aq adminq;
> +
> +	struct enet_tx *tx;
> +	struct enet_rx **rx;
> +
> +	struct eea_net_cfg cfg;
> +	struct eea_net_cfg cfg_hw;
> +
> +	u32 link_err;
> +
> +	bool started;
> +	bool cpu_aff_set;
> +
> +	u8 duplex;
> +	u32 speed;
> +
> +	u64 hw_ts_offset;
> +};
> +
> +int eea_tx_resize(struct eea_net *enet, struct enet_tx *tx, u32 ring_num);
> +
> +int eea_net_probe(struct eea_device *edev);
> +void eea_net_remove(struct eea_device *edev);
> +int eea_net_freeze(struct eea_device *edev);
> +int eea_net_restore(struct eea_device *edev);
> +
> +int eea_reset_hw_resources(struct eea_net *enet, struct eea_net_tmp *tmp);
> +void enet_mk_tmp_cfg(struct eea_net *enet, struct eea_net_tmp *tmp);
> +int eea_queues_check_and_reset(struct eea_device *edev);
> +
> +/* rx apis */
> +int eea_poll(struct napi_struct *napi, int budget);
> +
> +void enet_rx_stop(struct enet_rx *rx);
> +int enet_rx_start(struct enet_rx *rx);
> +
> +void eea_free_rx(struct enet_rx *rx);
> +struct enet_rx *eea_alloc_rx(struct eea_net_tmp *tmp, u32 idx);
> +
> +int eea_irq_free(struct enet_rx *rx);
> +
> +int enet_rxtx_irq_setup(struct eea_net *enet, u32 qid, u32 num);
> +
> +/* tx apis */
> +int eea_poll_tx(struct enet_tx *tx, int budget);
> +void eea_poll_cleantx(struct enet_rx *rx);
> +netdev_tx_t eea_tx_xmit(struct sk_buff *skb, struct net_device *netdev);
> +
> +void eea_tx_timeout(struct net_device *netdev, u32 txqueue);
> +
> +void eea_free_tx(struct enet_tx *tx);
> +int eea_alloc_tx(struct eea_net_tmp *tmp, struct enet_tx *tx, u32 idx);
> +
> +#endif
> diff --git a/drivers/net/ethernet/alibaba/eea/eea_pci.c b/drivers/net/ethernet/alibaba/eea/eea_pci.c
> new file mode 100644
> index 000000000000..df84f9a9c543
> --- /dev/null
> +++ b/drivers/net/ethernet/alibaba/eea/eea_pci.c
> @@ -0,0 +1,574 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Driver for Alibaba Elastic Ethernet Adaptor.
> + *
> + * Copyright (C) 2025 Alibaba Inc.
> + */
> +
> +#include <linux/iopoll.h>
> +#include <linux/io-64-nonatomic-lo-hi.h>
> +
> +#include "eea_pci.h"
> +#include "eea_net.h"
> +
> +#define EEA_PCI_DB_OFFSET 4096
> +
> +#define EEA_PCI_CAP_RESET_DEVICE 0xFA
> +#define EEA_PCI_CAP_RESET_FLAG BIT(1)
> +
> +struct eea_pci_cfg {
> +	__le32 reserve0;
> +	__le32 reserve1;
> +	__le32 drv_f_idx;
> +	__le32 drv_f;
> +
> +#define EEA_S_OK           BIT(2)
> +#define EEA_S_FEATURE_DONE BIT(3)
> +#define EEA_S_FAILED       BIT(7)
> +	u8   device_status;
> +	u8   reserved[7];
> +
> +	__le32 rx_num_max;
> +	__le32 tx_num_max;
> +	__le32 db_blk_size;
> +
> +	/* admin queue cfg */
> +	__le16 aq_size;
> +	__le16 aq_msix_vector;
> +	__le32 aq_db_off;
> +
> +	__le32 aq_sq_addr;
> +	__le32 aq_sq_addr_hi;
> +	__le32 aq_cq_addr;
> +	__le32 aq_cq_addr_hi;
> +
> +	__le64 hw_ts;
> +};
> +
> +struct eea_pci_device {
> +	struct eea_device edev;
> +	struct pci_dev *pci_dev;
> +
> +	u32 msix_vec_n;
> +
> +	void __iomem *reg;
> +	void __iomem *db_base;
> +
> +	struct work_struct ha_handle_work;
> +	char ha_irq_name[32];
> +	u8 reset_pos;
> +};
> +
> +#define cfg_pointer(reg, item) \
> +	((void __iomem *)((reg) + offsetof(struct eea_pci_cfg, item)))
> +
> +#define cfg_write8(reg, item, val) iowrite8(val, cfg_pointer(reg, item))
> +#define cfg_write16(reg, item, val) iowrite16(val, cfg_pointer(reg, item))
> +#define cfg_write32(reg, item, val) iowrite32(val, cfg_pointer(reg, item))
> +#define cfg_write64(reg, item, val) iowrite64_lo_hi(val, cfg_pointer(reg, item))
> +
> +#define cfg_read8(reg, item) ioread8(cfg_pointer(reg, item))
> +#define cfg_read32(reg, item) ioread32(cfg_pointer(reg, item))
> +#define cfg_readq(reg, item) readq(cfg_pointer(reg, item))
> +
> +/* Due to circular references, we have to add function definitions here. */
> +static int __eea_pci_probe(struct pci_dev *pci_dev,
> +			   struct eea_pci_device *ep_dev);
> +static void __eea_pci_remove(struct pci_dev *pci_dev, bool flush_ha_work);
> +
> +const char *eea_pci_name(struct eea_device *edev)

generally such a thin wrappers for kernel API are discouraged
(this driver would be part of the kernel, if someone will change
function that you call in a way that requires change of caller, they
will also change your driver;
it is also easier for reviewers and maintainers to see something
common to them instead of eea_pci_dev_id())

> +{
> +	return pci_name(edev->ep_dev->pci_dev);
> +}
> +
> +int eea_pci_domain_nr(struct eea_device *edev)
> +{
> +	return pci_domain_nr(edev->ep_dev->pci_dev->bus);
> +}
> +
> +u16 eea_pci_dev_id(struct eea_device *edev)
> +{
> +	return pci_dev_id(edev->ep_dev->pci_dev);
> +}
> +
> +static void eea_pci_io_set_status(struct eea_device *edev, u8 status)
> +{
> +	struct eea_pci_device *ep_dev = edev->ep_dev;
> +
> +	cfg_write8(ep_dev->reg, device_status, status);
> +}
> +
> +static u8 eea_pci_io_get_status(struct eea_device *edev)
> +{
> +	struct eea_pci_device *ep_dev = edev->ep_dev;
> +
> +	return cfg_read8(ep_dev->reg, device_status);
> +}
> +
> +static void eea_add_status(struct eea_device *dev, u32 status)
> +{
> +	eea_pci_io_set_status(dev, eea_pci_io_get_status(dev) | status);
> +}
> +

