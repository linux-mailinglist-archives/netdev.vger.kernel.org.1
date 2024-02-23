Return-Path: <netdev+bounces-74218-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA22C86082B
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 02:23:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF4E1B21646
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 01:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A61947A;
	Fri, 23 Feb 2024 01:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TyufcjDw"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07F71847E
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 01:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708651424; cv=fail; b=gAXmIcE7LRVsMMQay+mV3WtzBGfohzwZGcHCDXanzUqLAnM9NvSIBkPZYGC1Ojwjx5W81JQeuf7q0YxdJMaZQisblgco1VZ0/Ejv4Rk4GTLEqaEtxeIQh7uAHGo/Ye9tQjX5YkHtMQxJvHdZu+U085cKd3NYbeKB8cV6NS3PQno=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708651424; c=relaxed/simple;
	bh=hRUVaNjJh3MX6K72PBBeO28AQOY9CdHK6kHVcSPf6hU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=X4BeYs6B/0lyRI9ES9ScVMl6lroQ4+1WD3FeJngH6t2RCGePB1sLCCj2yDQH29vlKju2UBO7lS4u8DEHA1eZx03KEl0GTqDP6nQDomyFblLXaHy19Fdwx37l36oWFTnWpL0ofaNSUURwyjPYZ/G1jvtixxoYD4fX5mZvYrm9qww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TyufcjDw; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708651422; x=1740187422;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=hRUVaNjJh3MX6K72PBBeO28AQOY9CdHK6kHVcSPf6hU=;
  b=TyufcjDwKW1Db7XucuQuubl77rUTT6HTvWzoSf6XO2PT6IXGg6waucPO
   Y7JcStA4cnKSeFcEyWBIIWfFnT1IScB0m2p14EnGHZHoF7NMKc35Qnc40
   7s6ML0gBZIt/IjZ8JPq7sFU+ljcr9vwX8qIhBpT66ykFjuEml5DKJUCxA
   n31WfKCQ9UKexmVUaa/Fti4ehJmKV9MIq8uwjpdN4b8OWrPSv7mIYM0lG
   FHPHg9wfl+wq0KX6S2PoUORrUVoXRgD+yIlPm+HAk1PLjmjosmQThq0MW
   qdb0vNKlYeh0WbVkrupxLvCOBA9W6DlkHktT7EMU/gcW4xQlQWBDjEhhu
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="2830108"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="2830108"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 17:23:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="10468746"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Feb 2024 17:23:40 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 22 Feb 2024 17:23:40 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 22 Feb 2024 17:23:40 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 22 Feb 2024 17:23:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=URdBGPBMkmUNcGQ1hMbbDqI1EGwqjPnGFY6krZXY24mDR9svI8TRz2BNY7kpKYn9ZK7erKpcDJdWGUiKM7BJ2x38diF/PDYBWoHKaVDI+e5kTkgJumKUSIm8Qli8NHjX1esyzfXwMdpzrL6kbQodSi1sRQLpu7/BJFsXF8A7FPU4TLIlE00twde1QGcyy+DSyOrRE1z2TL2Lmks/lhm2yf//I9k874oXJnGZC/K5sdX8Vy4reCLsMEPufBZOwtEkOg2LvSixaKqSvFpwCUeyCtHR6MZnj67tacAKnfsJIrR8jVQiEA0S09D0VuQcUg1SnKf1lG+7N1llAsNdRdHzPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bvvjbA/ePS1OInM0BGhqv7v0amQz5vmcLoV+SdlePfc=;
 b=e5Aptr6DKK9dmHLP5qalNXEkT1bI/G8TOtrXHAD0E4IvVg1F1IHfTQxRWFaZABZQBaz+Dg8i8jZ7ZlB5Ob5qWyuadoB8oDVQXhHaCNx5PxFSrU4FCYg0FcfTA7pteT62qxjVLpcHLWZOYwIsem7m7CxyapJGfRlv7uZPWu/TiWaIQDzLuQSxeTURnMUNSwdBmt8N51wW+IWri75O1tvoTVXj48v7cgvEJIXz5UqKPG/h6lklaTejPWJpWuXvgbjD8qL6EIGNBQRYfc9mVGqHlmLEfYkAb8VaVr68Lo6x6tmDKUQ7AqPWYmhoaU3LdSKUNYO1WnyE/0JbI/imc4vcbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ0PR11MB4893.namprd11.prod.outlook.com (2603:10b6:a03:2ac::17)
 by PH0PR11MB7168.namprd11.prod.outlook.com (2603:10b6:510:1e9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.10; Fri, 23 Feb
 2024 01:23:36 +0000
Received: from SJ0PR11MB4893.namprd11.prod.outlook.com
 ([fe80::28cf:cc9d:777:add1]) by SJ0PR11MB4893.namprd11.prod.outlook.com
 ([fe80::28cf:cc9d:777:add1%4]) with mapi id 15.20.7339.009; Fri, 23 Feb 2024
 01:23:36 +0000
Message-ID: <de852162-faad-40fa-9a73-c7cf2e710105@intel.com>
Date: Thu, 22 Feb 2024 19:23:32 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next V3 15/15] Documentation: networking: Add description
 for multi-pf netdev
To: Jakub Kicinski <kuba@kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
CC: Tariq Toukan <ttoukan.linux@gmail.com>, Saeed Mahameed <saeed@kernel.org>,
	"David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>, Saeed Mahameed <saeedm@nvidia.com>,
	<netdev@vger.kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
	<jay.vosburgh@canonical.com>
References: <20240215030814.451812-1-saeed@kernel.org>
 <20240215030814.451812-16-saeed@kernel.org>
 <20240215212353.3d6d17c4@kernel.org>
 <f3e1a1c2-f757-4150-a633-d4da63bacdcd@gmail.com>
 <20240220173309.4abef5af@kernel.org>
 <2024022214-alkalize-magnetize-dbbc@gregkh>
 <20240222150030.68879f04@kernel.org>
Content-Language: en-US
From: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
In-Reply-To: <20240222150030.68879f04@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0080.namprd03.prod.outlook.com
 (2603:10b6:a03:331::25) To SJ0PR11MB4893.namprd11.prod.outlook.com
 (2603:10b6:a03:2ac::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR11MB4893:EE_|PH0PR11MB7168:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e5b4bda-b979-4a1a-1594-08dc340e0ebb
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uGwJD7gCjpc6rEcJQjTW1gdYV7XD2mdx2pggxfJmR004jfeKtw5Z2vfzA14oNjgl8Z/884wAB1wHYsHAxrgiwwTqC9TViC8Kj2aRySzdCh/ksxAVeCLHR+oOUE5mFtUGKzqMVwVrt9agN/8FLkOEs6XHt4cGjad2Y7PclM22DJAxcAAJ0Bz+fRrplmFRT83QHdVUH2aMsNW1IdsdfuneJD1LC6XeYXb9jfoxKtgZmQgD+btEi1Som0lxPF+SUhbSna7vv83DwJ6C1fRR4IgqVmGA8SbxkCch7KPTqjIbqTHzOUCA1fJ3rmVI1uSThW8BzcR2YngnWldkjHNDxQduB+0FiF7KVHPBUKhQc7suzIn1Sn34vxyX4YxUxzIZZWnRsEjSWB4/cx18iYIUaYaFRx5lUQp9OwAkfbOWJBHtHTH8W7eBKRGuwXA3bgob8bauwUJOR0zas95omXS5cc/0ECmTlI/lEZ+/0I3O3HbCIsDinWOATlysXBlkTZnZZ+BMufE4h0AvaEe/sHrmFimNE3t6g6qgHIqJlprTlu3LzEI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB4893.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZDZ3dndueFNuelBFVzFvT1QwUzRwR2VIeXR5RDVtakp4MHZPMlZuRHpJaXM0?=
 =?utf-8?B?azVqNTF6ZVVJSTJWVGIyaVBMTjc2c1BVdmpaUTdDaitPRVRoeVZzdlRjNUhH?=
 =?utf-8?B?UFdWeUpNSm1IVlJrelQrakZTTEYwS2RGZmlVamkwNHI2ZTduMnNKR3p5TmFV?=
 =?utf-8?B?dlJuUTVBTTlhYzVaQlJZaTNLMXBPdnV1eE1aQmgzY00yVHc4L3B6Vm9NUVQr?=
 =?utf-8?B?REtJY0owdHhKT0JHWUxiNmlJL01INjhCQjY0c1lLUWtMd3BIeWdiRHlvVWUx?=
 =?utf-8?B?MWxqQXl6eFRDbCtCVFN0Y3ZLUmp6UjBOenl4TWYxay9KUlNXa04wdTBFeFZ3?=
 =?utf-8?B?YXovL00rK3NBMEpFMmdXaldZZngxNkFKd1NoWnNaYmRMbzV0Z3BNUlRTTzFt?=
 =?utf-8?B?bkxxOURud0Q1b3ZpRTljRVY1WTlNU2VhTHZIZXlkWTFlb293ckFscHQzQjNm?=
 =?utf-8?B?amRQS1R2WDZ6c1RLRVY2R0ZlODNFV2R1MWN5OVRFaWtNd2JDdlNjb25FZVkv?=
 =?utf-8?B?WTBESU5pT3J5alFRZHBkdS8xNTJiUytzREJXQmE3L3ZaT0l4STA0ZjVpOWRu?=
 =?utf-8?B?QU1xemM1V3h5djBwejQ4NHUwVjhFaVorN3NRaDJPQnRCaFZwMTlYZlhUSFhl?=
 =?utf-8?B?K0xQNSsyUGhlM3QvZ3Bydnp6ZUxHT21wRU1tZkdiTmUvejFXK2xuWXlSWHIy?=
 =?utf-8?B?K0lhaVRpMkRHK2FVWDRCUURia3FXWjhaWFQ4eGtSREtCTFRRcStlb0ZsOGZM?=
 =?utf-8?B?VjBDOEV0Z2EvNWRLQytzVGVUYmdhaG9aS1VrS3M2THpvdjZQUzRGN2NqYkNT?=
 =?utf-8?B?d3B4aUVCTUhNSEwrQ3Q1M2kvQ3ROMDA0UTU1dnJPWk5lWlcwSUJwYVhoMUZH?=
 =?utf-8?B?eVVUVlBUQ1U2ZXh5NktEZ0NrdS9FYklCMzZVVUdBOTNrOWg4WVlwQUtFbSsx?=
 =?utf-8?B?dGhhcm1KRGFCcERpbWQ5UFBYMTlwUkVlYkc0REtyQURYWm5PVzFpRS9qcjRO?=
 =?utf-8?B?bW5hTmM4Q1VXd1NVQVdpTUgyUjZhaGl4a2VDRS9HMjEvdFIwWWgrTFhLT25q?=
 =?utf-8?B?QXVVc2xIbTBpM0QxelNBRDRDais2dGNrUEI0ME9qb0VjQXA3a2wyMFhtZnBo?=
 =?utf-8?B?OWZiZVRrckYzajNYaVk2d0xkRll4MWdxV3Vydzc1YnB1c1hwdnNUY21tT2Rk?=
 =?utf-8?B?eXhwV1B2cWU1QmdVMkpIZHRPM3NTT0NzQnFoT2gvYVQyczd3amF6VU9Pd3Rw?=
 =?utf-8?B?WENYVXlzQ1RnalorVWgzdTA1cUwvc2RPRW9LZndGNWsvbG96cXhqZk9KZ3lS?=
 =?utf-8?B?MDdnclhJRXVaNCtLY2ZJTkEwN1NBY1BBRzhGZ1B3OWJ1Nkp2U2g1UzNLcGl3?=
 =?utf-8?B?d2RtNGFXKzdLZ1JHUzVoWlZCKzFtS2NZSGRaRDFJRzg0VG15dFZGVDFhbzdT?=
 =?utf-8?B?NVRjdHpUZUpQU2pBaElnR2kvRTYvdzlSZ0lCaEdZa3hEVU1saWQ4b1F3WUZ2?=
 =?utf-8?B?NkpLUDhsOVJOMWU1ZDZUdTlNSHdCSERURHFoNXVJNC9CdTVaQldJV2RQQ2xU?=
 =?utf-8?B?UTl5L2h3KzNsZkcyTUI3TWxwSmxPaU5JNnJKMWZFcm9PR3N3Tm93OTA4dG1Z?=
 =?utf-8?B?aHk2dXNYd3RyZWtIYTdqVVJmaWw1MlVsSE9GQ04yc1NwRW53ZGlDM2UrdU9k?=
 =?utf-8?B?QXhObmR0L2h1SW5mbGtQaUIvK3JqTlBxOGlRcDdQZDZFcWViajNyeTRYRzJM?=
 =?utf-8?B?QlpRcEdsZEp6QlVTMm5aUnZFdWlTdGN2Y01HbjVQMVovV2VLWjdEUGFKa09i?=
 =?utf-8?B?dHdYT25saGRVWm13Q0x2SmFaUldYdDdKYnkvTVBiK2hHT1lnTkwwdE5YNS9T?=
 =?utf-8?B?VzN0STNOdVpLMjVMOE5GZFE0UXpCRzdwRFBEckw5aDJDWENyMG1MeGthUkRj?=
 =?utf-8?B?a1FUb2NCNUJCM1FGYTZJaUxxRWFlaG1GL1dwUzVGOTNrVVVvRWQrVnFIN2lH?=
 =?utf-8?B?UE9yaTVHemlPZHZNeVVkcS9SaEJHS0dPRlNvaUhmbzcrQXJGNkl0NVhPWXVx?=
 =?utf-8?B?bGdlUmpOMWlFaTVwS2JsaGxWcWlIbUQ1dW9zR0dsYlhEOU9lZFRzM1AvRU5Y?=
 =?utf-8?B?VTNKcVdlU3lWK0pqNFlIc2tYSktVSE9UTGVQNHNvN1d2TU5HNWYwemJSczVp?=
 =?utf-8?B?eHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e5b4bda-b979-4a1a-1594-08dc340e0ebb
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4893.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 01:23:36.2240
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JeBcQEVsNZJljHOCS9+E2n4P+aeT61vXWLRvaPK3iKawWJKIUlhLqerB3VPud/qDEo2jRMMzEpl1Tw9fDtLDbkfx263LVG3kbXyX2dtS8JU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7168
X-OriginatorOrg: intel.com



On 2/22/2024 5:00 PM, Jakub Kicinski wrote:
> On Thu, 22 Feb 2024 08:51:36 +0100 Greg Kroah-Hartman wrote:
>> On Tue, Feb 20, 2024 at 05:33:09PM -0800, Jakub Kicinski wrote:
>>> Greg, we have a feature here where a single device of class net has
>>> multiple "bus parents". We used to have one attr under class net
>>> (device) which is a link to the bus parent. Now we either need to add
>>> more or not bother with the linking of the whole device. Is there any
>>> precedent / preference for solving this from the device model
>>> perspective?
>>
>> How, logically, can a netdevice be controlled properly from 2 parent
>> devices on two different busses?  How is that even possible from a
>> physical point-of-view?  What exact bus types are involved here?
> 
> Two PCIe buses, two endpoints, two networking ports. It's one piece

Isn't it only 1 networking port with multiple PFs?

> of silicon, tho, so the "slices" can talk to each other internally.
> The NVRAM configuration tells both endpoints that the user wants
> them "bonded", when the PCI drivers probe they "find each other"
> using some cookie or DSN or whatnot. And once they did, they spawn
> a single netdev.
> 
>> This "shouldn't" be possible as in the end, it's usually a PCI device
>> handling this all, right?
> 
> It's really a special type of bonding of two netdevs. Like you'd bond
> two ports to get twice the bandwidth. With the twist that the balancing
> is done on NUMA proximity, rather than traffic hash.
> 
> Well, plus, the major twist that it's all done magically "for you"
> in the vendor driver, and the two "lower" devices are not visible.
> You only see the resulting bond.
> 
> I personally think that the magic hides as many problems as it
> introduces and we'd be better off creating two separate netdevs.
> And then a new type of "device bond" on top. Small win that
> the "new device bond on top" can be shared code across vendors.

Yes. We have been exploring a small extension to bonding driver to 
enable a single numa-aware multi-threaded application to efficiently 
utilize multiple NICs across numa nodes.

Here is an early version of a patch we have been trying and seems to be 
working well.

=========================================================================
bonding: select tx device based on rx device of a flow

If napi_id is cached in the sk associated with skb, use the
device associated with napi_id as the transmit device.

Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>

diff --git a/drivers/net/bonding/bond_main.c 
b/drivers/net/bonding/bond_main.c
index 7a7d584f378a..77e3bf6c4502 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -5146,6 +5146,30 @@ static struct slave 
*bond_xmit_3ad_xor_slave_get(struct bonding *bond,
         unsigned int count;
         u32 hash;

+       if (skb->sk) {
+               int napi_id = skb->sk->sk_napi_id;
+               struct net_device *dev;
+               int idx;
+
+               rcu_read_lock();
+               dev = dev_get_by_napi_id(napi_id);
+               rcu_read_unlock();
+
+               if (!dev)
+                       goto hash;
+
+               count = slaves ? READ_ONCE(slaves->count) : 0;
+               if (unlikely(!count))
+                       return NULL;
+
+               for (idx = 0; idx < count; idx++) {
+                       slave = slaves->arr[idx];
+                       if (slave->dev->ifindex == dev->ifindex)
+                               return slave;
+               }
+       }
+
+hash:
         hash = bond_xmit_hash(bond, skb);
         count = slaves ? READ_ONCE(slaves->count) : 0;
         if (unlikely(!count))
=========================================================================

If we make this as a configurable bonding option, would this be an 
acceptable solution to accelerate numa-aware apps?

> 
> But there's only so many hours in the day to argue with vendors.
> 

