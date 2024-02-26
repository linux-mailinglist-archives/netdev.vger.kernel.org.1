Return-Path: <netdev+bounces-75074-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64BF986814A
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 20:43:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D9F9B21D2A
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 19:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B8C612FB3A;
	Mon, 26 Feb 2024 19:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JCGF2gge"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206E1130ACC
	for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 19:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708976562; cv=fail; b=sTaSH1aWCZtTFLuBPiFKvnk4QsbDtRahCYEp89kLd+Gd5Ubay6BTudlOkT7xmSc313o2n+h7GGXWq4PoOfvLhA94vKaJQwEP6zhUXDUsT7TdOBZsCmkZngxBHO7CDdMMGMhbLhhAQUftm/1kHiEvij73MQKB5TbJmGZCfYn6T98=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708976562; c=relaxed/simple;
	bh=E3GZ5ofLR7bvG0meH/bGvsGjPIqqZ2BePXnewtrcNHw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TOTlRKOe50Nfo8YJU96ABqwtQwnk2qBFkb0tgtJybYaZXZ11Az+512XcuzuZSEmwtLk4SriweDWdLRXQAJFRgi/hi21siwmqOy55VTHxdRXIAorlrRE6o9HHqCvj5/OGXTUJ9NsBZyD0ixDAt9b86jBTcHEhobLI0cZvIWsQjmc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JCGF2gge; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708976561; x=1740512561;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=E3GZ5ofLR7bvG0meH/bGvsGjPIqqZ2BePXnewtrcNHw=;
  b=JCGF2ggexr3ksb5ek28xGPzNQ0D0STypgyCusI2N4HfAZH0AiYJCq4FX
   UVGmpRedmcH/KMPAkj/MDYSQh+p9AWL/6ZHu+5MZoY8opT9wL/ZwmGtv1
   CQQPSOZz/NjQnQU1jtVUIoi07rtYHzHSAgzWo9DkvkKp7bueKe0231to3
   aL9vu3VN7zgqEKHe2CleFMwz7VR8KLnfQn1mvOvvwn4A9fqcqKXn6BxUG
   NNre3U6Jax5JMPlT6iWJPqX2H+6idCFcTQf4UlpSo7trHV64nIyBhaB4u
   1fxxlC8UrBM7CAa+wJ+XLb3PoY1iCwf2yUeuh+SALIIiAjz8DG+v0L/E4
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="3214620"
X-IronPort-AV: E=Sophos;i="6.06,186,1705392000"; 
   d="scan'208";a="3214620"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 11:42:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,186,1705392000"; 
   d="scan'208";a="7143349"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Feb 2024 11:42:39 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 26 Feb 2024 11:42:38 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 26 Feb 2024 11:42:38 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 26 Feb 2024 11:42:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cL+Ecus4oH68j0fZ3h63FgS0sQFG1StqtZEyhUQhjWjqySU0Y8iOT3YrIxDFfvgIl0Q/5+eiyljoDrEP8NG2qncWwjS/9YISmgOlkHsrsnhJY9aYc+aT10mcoClQX9Ryv0SPFTs4QYfDNyZtz+LvEySqd+bgv10KF1nD0fc8vI9BhzhmSh91Kex4Dus5rUFWeMrsWd0eGgUmZDmWtNfNv+jqGOrzRUIUM9CLxfFGPplzmXZ16vWJKfDzmgI/P0d4Om9k/zAQ2IR0M/dPf9H9Ho24WJTKEJ8qD2xEfeLfdS/8qvYrGe5egV1T0Nn8qfUy7faLdfwZAuuUoAdt3WHBPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IUZNekiVnCyZpJpEYogjmRWYnHxTYLJZEgSPI6pr3gU=;
 b=QdoXb9TnyMN664MHSMS7DcOkMkp0R8rapYfp5/myyayGT5uJQyzghYOgqX84pdLD9U5CtvPm9L6SBjYLZ5vkQ01Rnt8TG8K1+xZLdqEkYGzhjslo6tHXnDtKfPFbLGr3q8/ZNPT8SjvtLoF+HjaEFGfULqlJPhajw/XvXFHrBxQr1lJHVUXJcPctnI/+xhQ+DA5+/gBbZGdQUZrgVyTzrQ7W6o2hO1maLky6R4eRQ7L8lE7ajvr2EP+mWN0TKyKgCb0k6MhV8+XA0IW1USyDUAUy4myCg87ewhm2zMCVSn5LHXDoGdrvLky5/8PthiYWk9KOPxFtWLwd6KQkd8y1Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7869.namprd11.prod.outlook.com (2603:10b6:208:3f6::7)
 by PH8PR11MB6610.namprd11.prod.outlook.com (2603:10b6:510:1cd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.22; Mon, 26 Feb
 2024 19:42:36 +0000
Received: from IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::4c76:f31a:2174:d509]) by IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::4c76:f31a:2174:d509%5]) with mapi id 15.20.7339.024; Mon, 26 Feb 2024
 19:42:36 +0000
Message-ID: <d3588021-7a89-44ec-99e2-dbbf1fbfa474@intel.com>
Date: Mon, 26 Feb 2024 11:42:32 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next 1/3] netdev: add per-queue statistics
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <danielj@nvidia.com>, <mst@redhat.com>,
	<michael.chan@broadcom.com>
References: <20240222223629.158254-1-kuba@kernel.org>
 <20240222223629.158254-2-kuba@kernel.org>
 <e6699bcd-e550-4282-85b4-ecf030ccdc2e@intel.com>
 <20240222174407.5949cf90@kernel.org>
 <de03710a-8409-49c6-bc62-c49e8291cb73@intel.com>
 <20240223161322.32c645e9@kernel.org>
From: "Nambiar, Amritha" <amritha.nambiar@intel.com>
In-Reply-To: <20240223161322.32c645e9@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR16CA0024.namprd16.prod.outlook.com (2603:10b6:907::37)
 To IA1PR11MB7869.namprd11.prod.outlook.com (2603:10b6:208:3f6::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7869:EE_|PH8PR11MB6610:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ba074f9-9657-438a-380b-08dc3703150c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lCel49Lb/jhQvEg9JqbHIODvklXz8Sncvjyxn/vdhCow83vNOaVJD6LjoYJ5h+mOt0xA0zMOTXe11sP4YhH6YZHSO4k/Vpc5NyEPkwgxRR95HV8GmBqXNna7BuhX6/8mwehDsGaqiyRGqBSKKA4hxsYgs9/zvVlbRtzohdMPjk05JYcvn14OxMnV3trFrIdYwBSQL22UJ/iO3JyRVCUBrLgDzFmmzYfuA6nug5y4iO3Pt4JCx6co43pLUbZRKHdYQgOaQY1dV//ZFtt4ScBkbAALsFI8yRKonYbr7+c+PP4TDdACqMitPoDnm2GUFvt/ViWL0NRyVgt8QRq2+liIZdALI07o7ualr5WicbMTYqQPLHTYjM2HdxY46Lxow4lsLYpKMBe2ZO245Qm2m/FNMvVxChkSnrmKHwOXfvcak8FzzD+s1VKo9nLyzl2ZT2hUwhTL4A5ZyVMWWBCFNJg6O+wCgVCc7IUB3EDeHuKTHjfn2nTL/c0S0yOXjO7ilfpncei9pj0z/FCeSK88anGbAYZiso0qe1VQlEjuSm81orTay1QHpV/Ek2dp45yUsXC5iUqbOu12X2mD+9dZAigXq/KfVgyqbPIC5m4EACw/iimKum6GrlLXLxM9BNKifqAcQJHkrNLrRmUDWCCb3/lszA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7869.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mm9LalhZd2w2Smh5bWtDNjVsSE53NEwwYkptZnp0SFZPVHZDWU5ucDZ2MWtK?=
 =?utf-8?B?bHJSeFJPd2NYQ2tMRGlTbUpZMW91Nlo4NFRtRThMVXVkZDhFTVpZVjJDRWdB?=
 =?utf-8?B?N09GRlYzRnBwUXBEN0pvdTN3dFZsTS9qTTRobitDRnU5cnlLSkdleEp3Z3JV?=
 =?utf-8?B?ckhDQW5vTVJUbFc4T0dHZE5DY1VuNjI1eFFBMHd3N2doNzd0M0c2VlFyRTgr?=
 =?utf-8?B?OFJOWkR0MFlHVUhoSUxaWGU1dGxRRTR5d1psdXc1NVpjSkEzOEljSFp2Q0JZ?=
 =?utf-8?B?Z3B2RkkwUFltZnJGSWpCbVRxSmxhT0JvZDNhT0REOGRMaXVRa1RlUktXMEJv?=
 =?utf-8?B?cEZwMDloLzlrZlVOWnNBb0Q4Q3Bjd0N1SkFSZTFrdnZqSDAzZk94STRjTGNR?=
 =?utf-8?B?bzMwcDJGbEl2bWV1aHBSUC9MVUxpRnpNUXcvaDVHMnhEQWphZkhkSW1Oa3Ri?=
 =?utf-8?B?MUNRdmNVRGt5Vm1NcDlmbkdielNJKytCd1JRZDcyZWlZVlU2S09BNlQ3c1ZU?=
 =?utf-8?B?UlNMQ2kydzh1bUt6RFJ4Y2pGMTBKclpBdW1NNVVaSkxtNGFJMWhra3dKNWVZ?=
 =?utf-8?B?WEZyMmJPaWhLLzhXdFZMZnpmVTd3RFBQSGo1WVVqNVNGdnY4WU5ocmN0Umh2?=
 =?utf-8?B?K1BiaFRJUiszWVJUYkRxcFk4VlQ5Q2FLSVpZYng4dkxlNFA0L2lnai9wMUJ4?=
 =?utf-8?B?Q2k4dG02cTZxWjIvMm8ycDhVOHlCaERyMEg5M3grUGFueUx4Mzh5cnNxZmpJ?=
 =?utf-8?B?c1VmdmVSNjhVU21OaWIvb1lCWUxHN0NRU05VYm81Zk8yRVJ4dFRnUlhyNThF?=
 =?utf-8?B?MXNCeXU4ZzV0ZERSOTdQWFE5OWg1amZudTUvcWRsSUZvRUc3aGtla1hWRmdp?=
 =?utf-8?B?dUhUM2NDQjlTcElFYWg3eEJua0VqUlNuOXZUNjZhZDI1WUJDNjhPeXlLV05l?=
 =?utf-8?B?dm45Rlo2cUcwdkZSN2NBQmNNTTArZG81bUxoakxWRGJ6ZklUWmd4NE1LTFNz?=
 =?utf-8?B?bXhuTFlWVGw1L2c0T2diUDhBS2tyaHJHZE5MUFdhL0ZuMkY4MDhCbU53RmRl?=
 =?utf-8?B?SC9YRXRrajU0blJ3VHR2VkdNbGd2UE9BMnM3NFprQU5WVjFtbWpLUWJ2MGda?=
 =?utf-8?B?eTJYS2dubHR2ejd1MGYzLzVYZm5ObklJdytVYmRwZjcrRmhKNUNvVSs3L1Vo?=
 =?utf-8?B?b1E3Qlp5aHYydkt3cHdGWTdGOHJ4SjQvSXlGL2NHZUJwbXR2QjRzRzE0K2h4?=
 =?utf-8?B?dE9wYmkvMkQ0aU05STZ3M0xGRFMzdDFRdzBsN3lJU2IwbnBJWWNwRC9uQ3c1?=
 =?utf-8?B?SE9oWUFLUHFlYTJYaVBnQ1cyVTFucElseHJnbHUrNUlBYS9vczBpbFVaTWRj?=
 =?utf-8?B?K1hXNFh0MFhxbmM4ZmF3bUhZb21tM3ZzNmh5WnMrQW84QlpZRmRmTHlkL2J0?=
 =?utf-8?B?RDBnazgyYjAyR0pjNDd0VHRXTUlhOTVua3NMYUwvSlVIaTlpWUpQd1lwR2M2?=
 =?utf-8?B?Vngrd0VTa3lTSnhzc09BdG9pMndyU3FtWElPNGR4TFZYeWlXYkIxWnJHWkxP?=
 =?utf-8?B?SlRldUJmY29uN0cxRHcvbkdGcGhQUlQwWUUxQXRDQWlBcE5Mb2tTZnhSMXdR?=
 =?utf-8?B?Q2ozbndTSWxOdjcvdGJJNm9TYTdOdmt2SFJLSGxVMWlka3F6WFVsZm42OHVt?=
 =?utf-8?B?aDZrY1ZFK3FXK1FuSzlsaGtNL1BqZkdCZVBicUJRNVhJZElvNWtTeTdVWnBI?=
 =?utf-8?B?MWY1cGV0a0FsNk5OSkViVkRnSk56UWFQVkU0WDBDVkpNRHFKR1BYcGE0ZlVB?=
 =?utf-8?B?UzJzWkQ5cm9wK0xwQ3VNbUdpWXZKUlBIYURzZXl5T1ppYTFoc20yazVFTWor?=
 =?utf-8?B?RjVEaENPR0lGUGxEWnFmazAvVFRHM09aNkhKSFpsaGg3enRkRWlURnl6OGgv?=
 =?utf-8?B?WC93SmtoUG5KU3Z4Z0R5bXJIUjZXOHJraWJXQjEvckVHanB3emdhSkJEMkZJ?=
 =?utf-8?B?ZURGME1NUHE4YTZrMTNkK0kwSVlSMXdWV3RRQjVuS0hWM1lpaW5OOUt5SnJj?=
 =?utf-8?B?NzI3M1ppVGZDeHE2TW5KcWxHZGpUTCtweDhPSGRUUlVYTWtZVHp5d09Td1h0?=
 =?utf-8?B?SnY0SERRcS9SRE8xdm4xWStuY0RaUFc4OERTK0E5b1ZXV05YL1FMaE1OaEJx?=
 =?utf-8?B?SWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ba074f9-9657-438a-380b-08dc3703150c
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7869.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 19:42:35.9224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w2AbpMwl2SBmBfuOnFrASXnXDMaNvnF4Ewll3qPNaGwXegEzKg1Se+8QUOxiliJqup7BjYxkZ/iYqgZmM3RuWgAHd8QjQOYUdnPMHqBTBBI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6610
X-OriginatorOrg: intel.com

On 2/23/2024 4:13 PM, Jakub Kicinski wrote:
> On Fri, 23 Feb 2024 12:51:51 -0800 Nambiar, Amritha wrote:
>> So I understand splitting a netdev object into component queues, but do
>> you have anything in mind WRT to splitting a queue, what could be the
>> components for a queue object?
> 
> HW vs SW stats was something that come to mind when I was writing
> the code. More speculatively speaking - there could also be queues
> fed from multiple buffer pool, so split per buffer pool could maybe
> one day make some sense?

Okay, HW/SW stats SGTM. Split per buffer pool also could be useful, 
queue+id+projection/scope/view would return multiple objects based on 
the pool.

