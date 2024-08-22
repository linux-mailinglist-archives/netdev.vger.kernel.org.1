Return-Path: <netdev+bounces-121193-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72BB795C18B
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 01:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 973111C21CE6
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 23:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 531FC18308E;
	Thu, 22 Aug 2024 23:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dtoilp6v"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC9117C217
	for <netdev@vger.kernel.org>; Thu, 22 Aug 2024 23:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724369767; cv=fail; b=p220W8gO7/1OOwGtRshpBGBCqS3gi1syEdInFSNCGVy6YQW+6gF5S9YaPWGZub8MM2i9sp3Xdvy/8959VYUYwj7vQ0BKjLckGGnqfjhBwJeubbxUwcwDvUMU1ZhR4VcEWAHaLfrd/C0sMiY83xezEUPOIv/CyzdqDFkyHDRR0LU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724369767; c=relaxed/simple;
	bh=ibFbQNKHp7vggizGFjv9xp4iFUol7P+zidp0AmuVyO4=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CccBWi5xQGMXPBX66v8AU0B1fhHnwZL5Qo8zMVRr+9gu9vhF90g+JDlw5mM4ikkKxF7kYl0p+WDH6sBNnR/Nr8m/8Asy1a2QMRlSxur0wtWB9B4H/CFi0l9lDpCi0iXSyEDmlFRZH7RshkrRGakTcGkngzVz/nbjJdUhR9VTJ0Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dtoilp6v; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724369765; x=1755905765;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ibFbQNKHp7vggizGFjv9xp4iFUol7P+zidp0AmuVyO4=;
  b=dtoilp6vKgNuwvpAx38G6ScGbQWQ/Quyuo6coliQu+eSwN3QxnPDgwsS
   aS45ROWDuCtVfv6T8dGfTrKpKhmWBQkbJHRiaHOI0N1WwHb1IKhpBhtqQ
   BGlv6pPTOCamqUk8dZzRNQjbSa7Kmp53OvzIAoZdVajx9JVN6lKzYHxV+
   quTsxSGZo7VzOCQcnLrJFf/+cb+Kv20Y+sjovTBNiYetEtbOviBGzSrX6
   ASJblA9rOiqkHyPQlr+C7MyVKjD0tOmfb/u61bb4ho+BgvVF25dv71Nnu
   3HKTxGLS9y1BZIUQmHh4o9ejSL5XSb9GzSpJcW+O37qPDS0xTux2C4iUs
   w==;
X-CSE-ConnectionGUID: E4tGYwU5S2OZlVkaIs0ZLQ==
X-CSE-MsgGUID: 5DRuYo22QpWAYa25FONQzg==
X-IronPort-AV: E=McAfee;i="6700,10204,11172"; a="40284968"
X-IronPort-AV: E=Sophos;i="6.10,168,1719903600"; 
   d="scan'208";a="40284968"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2024 16:36:05 -0700
X-CSE-ConnectionGUID: Sr8MwcQtRUuSAxSeS1LOog==
X-CSE-MsgGUID: Zdw42mt/Tn2Tw7eCxqwhuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,168,1719903600"; 
   d="scan'208";a="61637697"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Aug 2024 16:36:04 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 22 Aug 2024 16:36:03 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 22 Aug 2024 16:36:03 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 22 Aug 2024 16:36:03 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 22 Aug 2024 16:36:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=APMAXj5oTh/zUCFj3HL0qhXjx4yWnIcwlkHII1muIhJTg3v6t9oke7uP8JfKuuvNKaSBsoYGWmtn8md6p+5uqEHl3ofOeYseqi6pk0rCW5yd0iHcPlRhCk1zaOhHOdKDDOWeyP9YtaI+HmSgHBQwEIIu93PlEF1M+Wn4l2hPX6OrVMT3uTP1piZNYnSlrlySF+jEWCqJLB5vhpr77ts2aU2THO75/Qu97WejhsWn0mJjPw/Eu80IXe8gXQy/0GzND+gI/loLe/I5DULfNXwmxdUWuUfyfMyfkFK9dctFSSubS1lPGtQzdk/4P93MthMvzIBQPWyqIONXZYxuqJsXdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eYDPL8/WQKig8E+vjN2n9n+fp7iwvdd3TCuSyfOiBmk=;
 b=Wp0JC7SfZsXZYt0UES1jfdcc1k39EykCFRY6YYxnqqPQxp+buUNVi0KvN3OuHrNF6PEKf4CeAAKz9AEpcBb2Lfbn2k+6YZCODQcefis+UNLwc6lL6Hf6nr8fqcdgoMqe37bmcCHIwk2oP7of0+UapFWRj03mizs0WXdMb4NpJVnPvK8XK70gcZ887AJZ+hJ0AepgWFi+lHyDkGKop7Z86ZJHXm4gPPXKAo7Z9BFY5lYkgdbQOrN8t2gleYmoQBW77f+NdJpBr44f3X7uvc7AYBKw/8llF92AeBt98FcRCMOd49rQu4kZHB8UGtfqyrvlLWv5fBkN5Y3rfmxfRz96cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6435.namprd11.prod.outlook.com (2603:10b6:208:3bb::9)
 by SA1PR11MB6664.namprd11.prod.outlook.com (2603:10b6:806:258::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.19; Thu, 22 Aug
 2024 23:36:00 +0000
Received: from BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::23a7:1661:19d4:c1ab]) by BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::23a7:1661:19d4:c1ab%2]) with mapi id 15.20.7875.023; Thu, 22 Aug 2024
 23:36:00 +0000
Message-ID: <2c7daabe-7338-6d0c-1e82-d84b8239b442@intel.com>
Date: Thu, 22 Aug 2024 16:35:56 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH net-next v2 1/9] unroll: add generic loop unroll helpers
To: Jakub Kicinski <kuba@kernel.org>, Alexander Lobakin
	<aleksander.lobakin@intel.com>
CC: <davem@davemloft.net>, <pabeni@redhat.com>, <edumazet@google.com>,
	<netdev@vger.kernel.org>, <przemyslaw.kitszel@intel.com>,
	<joshua.a.hay@intel.com>, <michal.kubiak@intel.com>,
	<nex.sw.ncis.osdt.itp.upstreaming@intel.com>, "Jose E . Marchesi"
	<jose.marchesi@oracle.com>
References: <20240819223442.48013-1-anthony.l.nguyen@intel.com>
 <20240819223442.48013-2-anthony.l.nguyen@intel.com>
 <20240820175539.6b1cec2b@kernel.org>
 <66b571dc-19de-43ab-a10d-13cffdd82822@intel.com>
 <20240822155946.6e90fed7@kernel.org>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <20240822155946.6e90fed7@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0024.namprd05.prod.outlook.com
 (2603:10b6:a03:254::29) To BL3PR11MB6435.namprd11.prod.outlook.com
 (2603:10b6:208:3bb::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6435:EE_|SA1PR11MB6664:EE_
X-MS-Office365-Filtering-Correlation-Id: 55a0938d-847d-43c5-7e13-08dcc3032df7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aWd5YVhPRlFVVTg5YXVsbnc4WitmL2tvVFhyZzBDMFRFclJOSkRpekFIQlBM?=
 =?utf-8?B?c0N2NFMrRytCUGZTNzRQMTRJNDB2UWo1YlN5Q2hLcklzSHdMVXVlTnFQcHBI?=
 =?utf-8?B?TGE4cldRazNROXlhZnE5ZGxMTUpCZFVxZXFnOGxNM2RHRVVFbk5UWm83Wko5?=
 =?utf-8?B?SXRIWWh1bkxUcXJGM3c4ZWZJQzBBVS9YdG9oQzdrVHdseFFSSVIxOTVpWDhI?=
 =?utf-8?B?cU1OcFBoa1diNERsZWNmMjJGTUMxcVRReWhHOS85VWhLTUp5ZEh0ZzFHLzY3?=
 =?utf-8?B?a20wdWoybHlaQXgyUnRyQkt6SU9iZTAvOUh5UXhGVWZBVW5VMVJRT3ZRZ2cw?=
 =?utf-8?B?bGdzVGZ4emhIdVhSc1k4eTBndWRTM3JKeXpwUWlBNmhHbEJ2K2V0WnNvQUlT?=
 =?utf-8?B?N0F6ZUpFWlFWNmFvYWJDNzdyb09TU3paUk4xelVyZ25HNmdyUUhkMSsvQkRr?=
 =?utf-8?B?RkdUMzBNTE9KQm5YRFFCaGd2OHNHT0sxSEllVTBPYUdsNlVHaTdFZHNJcTJm?=
 =?utf-8?B?cGtVWFpJS25nZWhUK3ZKNVdRb0R4YWJmUVRlMTV0TkduNk5kcUhscFoySC9B?=
 =?utf-8?B?MzZxY2FGNDBHaGsvNzNkRmxDMHZFeCtQa1g2c3p4amEvYTFUV2pVU1QzbmRX?=
 =?utf-8?B?TXVmZGpIVlJHMHZ6YldpMmFNb05UVEpIaTc5SW9SSTVoL0U5a1Y3dnVRNkg5?=
 =?utf-8?B?a2xZMHVSMkkwTFVQMk9QYXczRDdwcHdMZ2JHb2xuMzBjRDRTeStKMnI0djY2?=
 =?utf-8?B?UHorekl3bDd5RUxLdEdzMzl0Q1gxRzFCYmNPVENsODU0bDR2Lyt0Z0k4TUlK?=
 =?utf-8?B?YS9MdHJLc05ZYWxmRkpMRHZLMnQzQ1I5d0NCTU15a3doNEUveHROcnMvM0lL?=
 =?utf-8?B?K29JSDRna2I4UTFGekY1a0ZtaVVlQ2lpa3Vma1VkdlhyRHdqK2JiZVhzL3I1?=
 =?utf-8?B?MEROUXhSaVJ1Wjd5c2RRbEVBc2FodGJPTHh1YzVwWGpDL2dqN0FZOGNyYWxL?=
 =?utf-8?B?U21sY3ExeVdORTM1d29PZFFnem8wSGY0NTdnc2xoeXBWRXN2Mld3VmFEdytN?=
 =?utf-8?B?U09sRzF6YjU1eEd4U3ZQanFFKzdqZE9DYXByOGkyUGV3bjZ4QmNXQnJwSy9D?=
 =?utf-8?B?R1VLSkpsUkpTVFdZd3VkeVJ2SlRHSDJLKzlBMW9TWEdEV2VYdnRLcmNTTjRY?=
 =?utf-8?B?SDdvRFRXNExnNlQ0d2h0bHhIdVU1T2RnVmlVYXZ2UnVIMTFqUkxpaW1TVTh5?=
 =?utf-8?B?elpYV0tmTnNaNTI3VkUzd3hpTlV1TktPaHRpSklhVHh5WmVRMjVsU0tSWXN6?=
 =?utf-8?B?Q3MrV2hmNXdQbmdBcDJLWmJyMkN0anZ2SG9XZmlrNXJuZGx2eVF3cGpoZTBQ?=
 =?utf-8?B?ZGpaSXlKVmM1QmFqcDEralhVaHNMQUl0Qm9Gd2xzZHp0eitYVjVUMWlLSmk5?=
 =?utf-8?B?WGdSTElVWmxVV1AxcXBtaTJ0dDdXNUllSGY0bEQ2UkJQbnQ3VEpzVWF3MGow?=
 =?utf-8?B?T1lHSlFSMDZhS0ZWYnBlNW1aaU51bE9xOHArSDdXOTFPcjhhdzY2UGhjakww?=
 =?utf-8?B?YkhmUnMwSyt5Rm9Vb29xaHJyZnNLYytMUnd0cGNqVjkxVExKWWFzbjAxMTND?=
 =?utf-8?B?TzhpcVJBOWVCeERXcisyblNlN1RoSzV5dUo2SkZzN1VHbUZ3cEdYYmZYakEv?=
 =?utf-8?B?TDcwb3NSbU82Y1QzRCtsMlZDeEdZUlNyeS9MUEhpblpraHAzalRtaDBlOU9R?=
 =?utf-8?B?OXpqNzhiZW1lUFRDRGR4MVNoVy9jOHdUT0RtWlVWalkvdkZzbkJ6L0lNL2dB?=
 =?utf-8?B?VkNlQmh0R3dpS1JEMkp5Zz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6435.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tk50a0E0L2k4Q2M4STRmK1RkVmNZdEJpNXl6dW4rUzhZQXBjUlJ0YVBuancx?=
 =?utf-8?B?MjB3U25hdjZQT05rcnpZRFNLK0Irc3F6NTkwRE5MUklKMGppd2lmVlVJalFn?=
 =?utf-8?B?aHRIR2VGZ2NhdkU0aDhDK3NIVkd0eUs1L2JOQ3lzRi9SYzYrV0hpR3ZxNWIy?=
 =?utf-8?B?LzB2aG5jY2U0R2F3VDdQZEw1ODJtQ2l2a0FjVFVjTCt0U1VDWXRmZ0tTdmdj?=
 =?utf-8?B?QVNsM2tOZDRvWVhvNWFHWFF1aHowei91bUdVNUloazdoYXNVOEl1VmNnRmdy?=
 =?utf-8?B?UmprMW14Wk81Y3lLZ3l4dE4wdm5OK0h5eXo1cXl3MXpIOC8wU2xEbTZId25m?=
 =?utf-8?B?aUZsQ0pmQ2lqT0d0eHhIYkN1N09KRE42Y2NLTnRkMDQ4RnVMQzY0QjJhcjAv?=
 =?utf-8?B?VXR2NVk0M1JWTjdDTENYVzJWK3IzWFI4RUxuRGc0UGpQdUxsZkcvMXk1eEFP?=
 =?utf-8?B?RmJudnkyZ0FCb045NWZLWk51bGhCZitKT1U3ZFpSS081Vjk4R2hJMnYwZlBG?=
 =?utf-8?B?NVU5L1ZUUG00RDdVT005UDJMTG9UVng4ZUFGTVh0dzdJVnNWWWY5MWFrWUk4?=
 =?utf-8?B?VldjRldQVmZITStkYnUvd2JVdW92NWZnTGR1aFI5NVRZOTQ1UXBON2JSU0lx?=
 =?utf-8?B?THhOUFpvMDlSVWs0SWd2cDJ3NCtiYlZKYWdQQnhFRUR5NFNrbXBCY0tqdnB6?=
 =?utf-8?B?aXJQV1JUWDFyVXVOR3NQNVpaVXMwTSthcGxRZ3pmZlN0TkxsdHRuUDJxNzNm?=
 =?utf-8?B?bDJ5eHB5bkR1TWtuc3VuWDhVM1llMS9BL2d4dEJWQjhlMXoyN0tQSjh6d0Qy?=
 =?utf-8?B?T0ZwN3hyc3AzcGoraUlOc1RJVkhzZVQzOXp6aUNyNC9tWGlJYk5jVHVaRFp1?=
 =?utf-8?B?Nm9jWG9aVGh5dEJydll4K3FIVkdFMkF4NU5NRmJWZVd0Qkorc1VUNjI3VE9C?=
 =?utf-8?B?TjVDTis5THlwdVY2VnFJL0lGVWlvYll5cEFyTnlIVk50Z2hEeDYvU0tKNmY3?=
 =?utf-8?B?OUtxVjJHd3VwWWoxREpBNjFwY1ZDM3ZIY1dZQ1EwUDhyQVN6clE0SDNMSGh1?=
 =?utf-8?B?c0Q4cU4zRWVTN213MjFmUUtLQ0ViZUN5Z1BEU0JmbTcyS0VPOHRJMmxUS051?=
 =?utf-8?B?MDY0bnREaUNZYmR5REFyaUh6eFBiREFmY1JLN0MrajZON2NHb0p0NStRWUJH?=
 =?utf-8?B?ei92ZU10Y2hlRU5xL2MrejNETEs2eGFHNnNuVGpiTUdSSnNmWE9XejlReElJ?=
 =?utf-8?B?TXhoa2ZpWThzNVBYTFZRQzFVa3VVL0tMei9ZV0JrQTZQVHJjRm5HT2VLQVJU?=
 =?utf-8?B?dHVtTGZRc1pzeWE1bitFbjE4RDVTKzdYclJpSXFZeGRLRUlCRnFiZ3psOHdi?=
 =?utf-8?B?RnMveVpmZExtYWN6NGtqa0lDa1REWUp0QXF4c3JjbWtwd3I1bC9UdExaeVAr?=
 =?utf-8?B?MHZveTlIeUhVOGdoOWd1ajRMVEFuUG9qdlE2VlVTYXl1ZU5ZZWlJcHpPdFhz?=
 =?utf-8?B?RFQwUDY0bGV4dEFwa2tQcVcwRmI1d25xZXlaNU9hakVINXVWczkyZHVaRGdh?=
 =?utf-8?B?L3FRVjFFTGxQeVBZQjhnSm5vNVhUMGNLWHhLQ3JRVGtXc1AwaUZrc1kvcy9T?=
 =?utf-8?B?REJXUmlxOStGc1pmYVVNL05sSWM4Y05QUm5XSWRRK0xjTldwb1JsaFhBRk1O?=
 =?utf-8?B?VHE0SEpvdmZrSkptZ3dFWkxXZ2EwOEF3aFYwVmtTaEt3R080bjhLcmNLV3Jx?=
 =?utf-8?B?WEZ1dU9XM0V6dnJwK3BWV0t5MWdTK2NHRWIwa2d3WFFoZDRMdDNYUUI5VXdV?=
 =?utf-8?B?MGU5QXVSY3F0TWF6OGN6Z1JxSU5LVmlLRzgwWERybHJtQUF0M0hGZTlUa1Vz?=
 =?utf-8?B?dHkxYlJoTGhVdm1xeFBSeUgvWjAxRWdsaWx4d0JXbmN3MjZpUm5sUXFoZUhz?=
 =?utf-8?B?Uy9vQ3R5NGlyRFlyYitYQVo2R0FOa2FaRUF1UHJtRndrR0pVVWdaMzdmeTdi?=
 =?utf-8?B?OXpSNkQrZ004OWxmV0ZDRHhEWnJxV3VxOUZWOHp0ZnZwQjRUZUQrdXVoeTBR?=
 =?utf-8?B?U1NwVWxtMlJFUVQ1VFdjN2Q5UTNnUmt4NjY5ZS94ZG5yZmJ6OHY5NmdXeGh6?=
 =?utf-8?B?Z2NCbERPc0hJVU4vZXFTYXh3SGxGUTF0SUZHZElrWFhpOVJPWlJGa0libTR0?=
 =?utf-8?B?OVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 55a0938d-847d-43c5-7e13-08dcc3032df7
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 23:36:00.5041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9pmiFdtssicGOUDdaiIj7axu+j3CDeTVFVISmHGDAfcMuYVUr6qaW5PP31pgx9CPW+Em0wTg/daToWPiJsN2dI2so7MBPQaf4qHIhsHNr9E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6664
X-OriginatorOrg: intel.com



On 8/22/2024 3:59 PM, Jakub Kicinski wrote:
> On Thu, 22 Aug 2024 17:15:25 +0200 Alexander Lobakin wrote:
>>> Please run the submissions thru get_maintainers
>>
>> I always do that. get_maintainers.pl gives nobody for linux/unroll.h.
> 
> You gotta feed it the *patch*, not the path. For keyword matching on the
> contents. I wanted to print a warning when people use get_maintainer
> with a path but Linus blocked it. I'm convinced 99% of such uses are
> misguided.
> 
> But TBH I was directing the message at Tony as well. Please just feed
> the patches to get_maintainer when posting.

Ack.

Thanks,
Tony

