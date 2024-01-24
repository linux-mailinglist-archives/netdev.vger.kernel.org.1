Return-Path: <netdev+bounces-65464-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCBA083AAE1
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 14:26:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E208A1C25C5E
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 13:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4CA2BB03;
	Wed, 24 Jan 2024 13:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FifQ8jxz"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97208BE1
	for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 13:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706102769; cv=fail; b=tbxksgX+oT8TClQZakZ6VM2jDU4ZbhK9MhU25An+fDqZj9uab5vd/HcYWXBYg4iBUcWCbNZ5WB4brDPeVr5h5B73oKL1G667lzDN7QgeKVTVVuJZ8CquSPEJBm/nk8QsKcokGjZbZR9Cqnn6/8tDYLeMRELng2aTToOZLiTbgks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706102769; c=relaxed/simple;
	bh=P9aoCKIpAkwihUS1VxhmxU1qI5SZ6UjwDbRacJq+xCg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TkPY+xNBYGpjmHMf6P5AmenJxc2gLAlCQvlksv6EZzunvBSRmaXxOLqPNhJ9HfFBx8kXY3rXZRWIp+PTD6GpkvLGHBdqR6aOc1R4hT/3aTdJi9RWFpq/EZ98C+RGwqtSlD1o77CxAZIyZO7ab4lGFXZWUPciRPvetYZf1Pa9VsE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FifQ8jxz; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706102768; x=1737638768;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=P9aoCKIpAkwihUS1VxhmxU1qI5SZ6UjwDbRacJq+xCg=;
  b=FifQ8jxzO7RhkCUPD2M96xdTWlFhJLzWboBcBXxYunYNX2wdVICXCW3g
   QQ1NSNdO1ODXhFRUj7wifhenRx3d/3l6rpf6zOPz3WEk1qEQktdcx/2Vu
   ++B99fR4LTED40WAaWkLIYiCATcYx4rLush4Yk63hPsqPpI6KiD+8epg6
   6rOKLOLL9IDIg8vnhzmaBa9hslgoOxQNKuhSP4H+QXO+jFYlIARAwitKd
   vgPAYIgS5tx50eaMDZSrA6HHc9JwUB7W2QVJ2vr0ce8vWTj8J8F4u2agh
   OwxQ/bNGEoHJRJijMjc9MPxlvt5WIOs7iEqad10wbD+QM6kgqlBS4hExk
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="8493603"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="8493603"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 05:26:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="786416741"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="786416741"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Jan 2024 05:26:06 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Jan 2024 05:26:05 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 24 Jan 2024 05:26:05 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 24 Jan 2024 05:26:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c6nximJfj6plaRvGzjsMluDkIR7nCkq20Q6fjHSCPwvxUbmnwyvlYvS9jF3EXeEcJdJuOtV6l3dspmTaYOPWGlkAMT5UbgDHXXI0vOBbdRimC5/KMFDi05sMNq9f7ygmCa7AFMgMZDkxRfeuem8mfWpzFd6O7xyd7Hg19HsiFEtjQxWUyz6hE0oaQ9v3d6jAISDJtkXRtjK6ouFJ0cjCKq3gb123eYT0jBGJ+F0IuIAMpm2nYH9zmNYxec6SRExBhgzTOBIu3+xMuFDV/l2BirWmLJiTKYN8zBn4sWNqiUz86jCnRbjej1PEGVEV8kkvy5V4bhVbTFu83Hg+IVuo2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DdmUKhkIU1iE5zT35yw3wgqj08cfjyR6c7dRcyVYk4U=;
 b=Mu5TVYRwAGaUz7nzUJYvAshFEzk5DRJA7S9y5D0Hf/qY8IOHW+qG6fJvUxXJBV1huOwJ9750QCLKsqNBnX8KnQf2Lc1NgryirNhXYBBL9NNMjnKML5hrtr419HQFLXb2U+JsqbOxeBIjLcJBmBkFJ7z2dT2mZ7kSwmqbz2yEPU2GKZslkOYK2bzhRMgerctPfzB9TcZlGhDPBFADGbsHGh6gRBvOz+uSZQDp/t7Eg9ukq2lhAsQBw1ZpcHBPxCOeSQsOvK05ZAerVn/vLRUPeWtzy506NXMRQ31KxIlFyI0lFu9Dm/BGK/qHuGykVGRXPYsgMwLjL6H+TPd2u2HgGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by DM4PR11MB5406.namprd11.prod.outlook.com (2603:10b6:5:395::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Wed, 24 Jan
 2024 13:26:04 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::b1b8:dbaa:aa04:a6bf]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::b1b8:dbaa:aa04:a6bf%7]) with mapi id 15.20.7228.022; Wed, 24 Jan 2024
 13:26:04 +0000
Message-ID: <31c8afe0-86fe-4b39-ba7d-a26d157972c9@intel.com>
Date: Wed, 24 Jan 2024 14:25:57 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/4] selftests/net/forwarding: add slowwait
 functions
To: Hangbin Liu <liuhangbin@gmail.com>, <netdev@vger.kernel.org>
CC: Jay Vosburgh <j.vosburgh@gmail.com>, "David S . Miller"
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, Liang Li
	<liali@redhat.com>
References: <20240124095814.1882509-1-liuhangbin@gmail.com>
 <20240124095814.1882509-2-liuhangbin@gmail.com>
Content-Language: en-US
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <20240124095814.1882509-2-liuhangbin@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0119.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::19) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|DM4PR11MB5406:EE_
X-MS-Office365-Filtering-Correlation-Id: 4df6595a-3cca-46f7-2f78-08dc1ce0038d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EDPGuKSDMATjpp/b/f75oWk8RXePVAYW5dWB07H4XExSBkJEk163kNIYBG5nqi8cGU14UtThWO4p+0kFoENdUgHIL82Tn9s4KCe0mTfPxktpND/W3O4AX1EmZqVYnrE73FPVh2BsmbbBo/PdkrAYsA/7sMaE9oK74Q/QKOE168WLg5yRkApv5KH9RXXiDeqPLsMZBJNab+4BjLDxP5ToMOb0q3Z89tF3zppDPXukc+HwGi4gz9pXVKDxr1c/NgmQbz/ZTfKOQ8gqg4YjTO18JgzDrn1jwHTp2S6gJOW87xa1m5jzvOO0uMBwvpTYxGlykZMymmEa0IwfxjDOY+6yLZ+k8kRASA4/9K787LtGaVWoUwmLjaYXCsrtnqDfcsyfeCu255r0say3j548rUjU77bRrwOjQAQk1IMIRUOOghK2d3r7rOGEWtytJKPKhzNS8XeeLVYmwMiuMZ03U10yuZYtc8CnsEJo/kfuc21/F5NSiIIXhTcDTxqMbjVEmjBBp9vM0WWrcLQoBBYjVG6U6jNQsIBSpqXgGoNxwqhTj56MvVZU4U6eSuwqtfShO2jyNfHe2/eRnZBg5CGE+HORCpgVpbQm/FyzVkQxOOiIvM+PLN1mywTMrsST9ol+wKSoCAQ5VlZvHe5sZVVwmEpeYA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(396003)(366004)(136003)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(31686004)(66476007)(54906003)(66556008)(66946007)(316002)(5660300002)(2906002)(83380400001)(8676002)(26005)(2616005)(4326008)(8936002)(6666004)(6512007)(478600001)(53546011)(6486002)(41300700001)(36756003)(6506007)(86362001)(31696002)(38100700002)(82960400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGRiKzZNeGVCR0JRQ2VaUWdCWXlUUUNLZlNMSktXUFJ2ejBWdDVxZzN6RXRz?=
 =?utf-8?B?aWJJL0VvbHIvV010OE1iUlBqMFp6NzY0TU4vaEQ5dFBYeXdtOXdHWjFvZHBj?=
 =?utf-8?B?ZXpVcFYrZlZiRzY4bkpYdHRJS0FFcHNDdlA0S0w2cTJ0WmVJcUduV2FXb1dT?=
 =?utf-8?B?YzZ4QVBQUUR1eGxGc0JEYlhZVi9JbnVtMGlkRGdrUHNJUTJ5VVRYZzhPSUhv?=
 =?utf-8?B?ZnlLNlpjOU1aWTlVMmk4NitPVGJSZVZqa1EzMFVhWGhOY2g5V3Z1OWRwcklq?=
 =?utf-8?B?cnlUWkdTNGxGbTRkak0wN2tYY1F0c2ZTRzNBc043b1NuaGZCMXA0ZEExR2tU?=
 =?utf-8?B?VlNpK1dpNFdhWVRYVWJXL01oMXI4cmt4bktON0lSdDVQNWhyTkl0N1ErMTlN?=
 =?utf-8?B?bDllQ2FuVE91RjBZSGNwOWNQVU40YXFVZTBTVExsc3orMy9aTSs1N0tYSUFU?=
 =?utf-8?B?VjluTnhnOEtKMlZlY0lqbmxNdkZaSzNlV3JFMjFVcWJqNUFBeXVaR1Jkc3M1?=
 =?utf-8?B?MkZ2WXd1aEpnb09rVjFidXA1OHZOQndzTUpWN3pnSG92dC9jYmtUNWRZVWta?=
 =?utf-8?B?RkFJeFVGUjUvZkFabW8wWGJmRkg5WENQVDUrUHJRZGpJYnYxKzhiWlc5MWR4?=
 =?utf-8?B?UHhzUVgrTTd4YUNid2YycXgxVkpTTzVlWktlSGxDMUFBTnQvMmI5bFZxcTBY?=
 =?utf-8?B?bWk1QUtVSFlKNVFGL2NFTTFKYktCOXRQV3FsVGJIMzlIQU1rV2JXUG0zSTlq?=
 =?utf-8?B?VHI3RlVMczM0UjN5V2pQTEFKZ096UXV5cGZZbWcyQTRHNXFuVS93KzlNTnZD?=
 =?utf-8?B?eWlvR3BXYlZoSXNLUkZpZVNSNkhBYlI3Ym1VbWRsZlNJNVY0UmY5bFRRelhU?=
 =?utf-8?B?VHdjZSs3a0RnVkhsU0xmYmlmMW5TaERBSXJ0MnF6TDNLeUN1YkxXWmV2ZC9U?=
 =?utf-8?B?WnErOG1raWNCZXZrUUdLTFhtVDZmcUc2blphcFhWMmpNcWlJOFBjVk5pL01v?=
 =?utf-8?B?Y29WS3ZMYnk4VUR0QytZSzZNcEZtWWtZek5Wbk9JM0NJK0JTRVNPOTRmMjZG?=
 =?utf-8?B?eWJUbVRDbnZFTzFBMjlxMHVDeUhsTjZRUjVxcm5Ra3ZHeGM4c2tPZW5ib1hH?=
 =?utf-8?B?dTVOWGRRejlWejZFbERUMG1la0R1U3lWWlVDK1hzOGp0Rnd3RmN5VmZJV2cv?=
 =?utf-8?B?QjRENkxMZVgxWjNnd2hpdSt1RnlzNnpKaUMwRUdtRzJCM3FNSEJlOE5jcEtq?=
 =?utf-8?B?bTRFcnNiNUJXWllhS2wzN1NQWXMwSHlEcWZ4Sm13MDZic1RnbXVVWk92OTVv?=
 =?utf-8?B?ZVRpVHo4c0Irei9QRldlQ3hMTlk1MHJxdk1Jc2RySm9HWnNHM1NsWFJBbVRB?=
 =?utf-8?B?V1B4Qm9TTlZ2U0tKWlZyeVVQR1Yzb016YThhak92R3hoOFhlVHhoMnd2Y0xx?=
 =?utf-8?B?MlZEd1ExQlNDcGJFSmFTQjQrTkxMeHgzQTgvd0V5a092cE5YZjMrN1dncmR5?=
 =?utf-8?B?WU1xVlBRd2xxU2poR29yTkp0YVVnaFlsVXRoQ2ovN2FnS28zUWh1c3NQZkhs?=
 =?utf-8?B?RGNqQWhqRC8wM3Fpc0lWL2FLNlBQK0xCc1pYOGRmdkZKN3JhVVY1UWIxOFhj?=
 =?utf-8?B?Rk9mTzIxQm5rWlVnaG5GY3NhNHB0S1pyam1KR0UyMG1NQ3lQN0ZwUkd5TkdP?=
 =?utf-8?B?MkptZTAxS1pQeGlQWC9rZmRXbjJaRncxaEZ5N3RUeE5KVVRnV2JUWnhPc2dL?=
 =?utf-8?B?a2pSWVMrdi8vbG45UTQyUHFRMThUR0haSXpBMS9XSWgrMXB0c2VmdHFTY3ZL?=
 =?utf-8?B?OTVETVZZTk9OWnBwUzFXUVArQWxuTXQ5UldFOXlxY1ZJNmFucGF6NzJrWnR3?=
 =?utf-8?B?TS8wVW0yMmF6SlpRendPeW04ekc5bXZ1WVFQcTA5WWVoK1pVeHl5anA0WW5z?=
 =?utf-8?B?elVhR0k4eTZidWhQUE9rdUkybjFhSGQyM0Z3MnZUSUZ3bEIxdmhkNVNBZkR6?=
 =?utf-8?B?b0lPcE8xYnI4OVJ3aWE5M0FzQ2JQKzVuMEtPSHRwOXd4VnNmNVc2SnUyT3U0?=
 =?utf-8?B?SmtJcElGdm5VU2ZLa21XRll2MXdFRDYyTk9uQXB3a0pjcU5xVVJBYm9Vc1da?=
 =?utf-8?B?UEZya2tEcmlFc003YVJEdE96eCt4TisvVUNteWdKaUhyQVpzRis5emtsWnVh?=
 =?utf-8?B?Snc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4df6595a-3cca-46f7-2f78-08dc1ce0038d
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 13:26:03.9433
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HTtE8rfZ6MFQ2MqDHpHp4y1Iq4DoUAyMwNBNu1WFYiMwR50i/E87h4qMN0R8hmcoKGOC9G1O+n/HJUGRvKtqOKd8TY6hqFpymRZTdM+e0XM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5406
X-OriginatorOrg: intel.com

On 1/24/24 10:58, Hangbin Liu wrote:
> Add slowwait functions to wait for some operations that may need a long time
> to finish. The busywait executes the cmd too fast, which is kind of wasting
> cpu in this scenario. At the same time, if shell debugging is enabled with
> `set -x`. the busywait will output too much logs.
> 
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
> ---
>   tools/testing/selftests/net/forwarding/lib.sh | 36 +++++++++++++++++++
>   1 file changed, 36 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/forwarding/lib.sh b/tools/testing/selftests/net/forwarding/lib.sh
> index 8a61464ab6eb..07faedc2071b 100644
> --- a/tools/testing/selftests/net/forwarding/lib.sh
> +++ b/tools/testing/selftests/net/forwarding/lib.sh
> @@ -41,6 +41,7 @@ fi
>   # Kselftest framework requirement - SKIP code is 4.
>   ksft_skip=4
>   
> +# timeout in milliseconds
>   busywait()
>   {
>   	local timeout=$1; shift
> @@ -64,6 +65,32 @@ busywait()
>   	done
>   }
>   
> +# timeout in seconds
> +slowwait()
> +{
> +	local timeout=$1; shift
> +
> +	local start_time="$(date -u +%s)"
> +	while true
> +	do
> +		local out
> +		out=$("$@")
> +		local ret=$?
> +		if ((!ret)); then

it would be nice to have some exit code used (or just reserved) for
"operation failed, no need to wait, fail the test please"
similar to the xargs, eg:
               126    if the command cannot be run

> +			echo -n "$out"
> +			return 0
> +		fi
> +
> +		local current_time="$(date -u +%s)"
> +		if ((current_time - start_time > timeout)); then
> +			echo -n "$out"
> +			return 1
> +		fi
> +
> +		sleep 1

I see that `sleep 1` is simplest correct impl, but it's tempting to
suggest exponential back-off, perhaps with saturation at 15

(but then you will have to cap last sleep to don't exceed timeout by
more than 1).

> +	done
> +}
> +
>   ##############################################################################
>   # Sanity checks
>   
> @@ -505,6 +532,15 @@ busywait_for_counter()
>   	busywait "$timeout" until_counter_is ">= $((base + delta))" "$@"
>   }
>   
> +slowwait_for_counter()
> +{
> +	local timeout=$1; shift
> +	local delta=$1; shift
> +
> +	local base=$("$@")
> +	slowwait "$timeout" until_counter_is ">= $((base + delta))" "$@"
> +}
> +
>   setup_wait_dev()
>   {
>   	local dev=$1; shift

just nitpicks so I will provide my RB in case you want to ignore ;)


