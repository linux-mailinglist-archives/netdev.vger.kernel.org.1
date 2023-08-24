Return-Path: <netdev+bounces-30424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48BE6787429
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 17:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CA421C20E97
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 15:28:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92FF2134A7;
	Thu, 24 Aug 2023 15:28:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A310125B4
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 15:28:06 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A646CEA
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 08:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692890883; x=1724426883;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=qBO1Fo0+2+Ghd44YPyxW5Z4kMTJ0dxvWtqqzFmWT6zo=;
  b=EKLwblwoOAg6Gulg5vEMl52VWz5ZbnNzBUyuL9pwSaunDei9ZM0EVmd2
   go8t4CIHHXhtJm/J78clikhZoRKOtCdWCzAKKeGgOvzyKPJbiDH0ZG5UW
   PttG8arzjBZ1Cc4m/kib1TvUnkiMBcqe1s00iKBpBufJ6k6WVUpz1yc4J
   HpPU4itnTYLnATGwrqOpdvuG6ZeKWdNtaqS03LYfUhiGjLnoavvhbUXri
   1ztWO8sDl2ySr4gMioMcrF/RxL1vGQdbJDS9FGC4kVV3SVB/8bRnh3Z3V
   fJcQ/Gfc8t2C6C2QJQ5wFm04JZa8Zu+trMoyqc61H5swA/bEboGoSj2vq
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="378249429"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="378249429"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 08:28:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="910940435"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="910940435"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP; 24 Aug 2023 08:28:00 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 24 Aug 2023 08:27:59 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 24 Aug 2023 08:27:59 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 24 Aug 2023 08:27:59 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.106)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 24 Aug 2023 08:27:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b9JXwUmPtN/pymDp11zQBvrju/Y37+1/qnvbv82kcliqqFjmhnOiImlA3iHV+4A7WS7NpjJ7MATDutD4qpEZxQSa9Ug8v+wsm+DKLdGrGPF602CPLWvuScqXVlYadLU42C/w088izTUPjosZL6FQWrtCt60BQb8DpVzgawlfG4sbShrIPg950TYmuyhKfrP4Y/vtRK6w04ntvngslu00CAsJGgj8n1iaQkSYqmCO9yjZ/CnZatUATFhbPISvWKOScgagv7tcbLU2LZPqyuTx8GdF0oscOt5efdlfAcreAIk+s53S2+33pGP4yECmWDilLyB5NxRN/+ZCr4q08s+BkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PWPLgH/gCL/vaB/IKfM74jlZfRtUGbn08lXPti8Xbyw=;
 b=Hw9v/FJXs9Mu+ROjGBRxuFpZSI6NSVgFPScJpFIR11e7Cv7fENvjeH/Mt/qdgoTkZsHj35RAtbDz4AGO/6i50p8m1yOGqVjiN/pJtlITv+0HKbkqKzBSjFw4yw1JWpC5Nhj3MAOmZzsCWTvZYgYm5rPjw88FQkdtVxV84BEgL5poHDnV9XQoTuW+510HW7zMFEEiYHyZarcFBpPHq8beWrM46NWfyh0nV7MJgpPW4UodpiBFV4iwNI2/PuDbKfrBUDuMOWsggcg8mUm0PWyslJV6Aaa58qQa1Qhf5fN6q7j+xKRh0PbIfU+eWeAyzBmrZVatS1hG/0Okb+QPNDaPwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by IA1PR11MB7728.namprd11.prod.outlook.com (2603:10b6:208:3f0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Thu, 24 Aug
 2023 15:27:57 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a%7]) with mapi id 15.20.6678.031; Thu, 24 Aug 2023
 15:27:57 +0000
Message-ID: <923d74d4-3d43-8cac-9732-c55103f6dafb@intel.com>
Date: Thu, 24 Aug 2023 17:26:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [BUG] Possible unsafe page_pool usage in octeontx2
Content-Language: en-US
To: Jesper Dangaard Brouer <hawk@kernel.org>
CC: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	<netdev@vger.kernel.org>, Ratheesh Kannoth <rkannoth@marvell.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Geetha
 sowjanya" <gakula@marvell.com>, Ilias Apalodimas
	<ilias.apalodimas@linaro.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Subbaraya Sundeep <sbhatta@marvell.com>, Sunil Goutham
	<sgoutham@marvell.com>, Thomas Gleixner <tglx@linutronix.de>, hariprasad
	<hkelam@marvell.com>, Qingfang DENG <qingfang.deng@siflower.com.cn>
References: <20230823094757.gxvCEOBi@linutronix.de>
 <d34d4c1c-2436-3d4c-268c-b971c9cc473f@kernel.org>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <d34d4c1c-2436-3d4c-268c-b971c9cc473f@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DB8PR06CA0057.eurprd06.prod.outlook.com
 (2603:10a6:10:120::31) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|IA1PR11MB7728:EE_
X-MS-Office365-Filtering-Correlation-Id: beb0f4d9-5def-4938-1e5d-08dba4b6b16c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: T+iTZUqWRmF6DoW5KHyvHeOjcCFQ4t9PdJqIKgueoivl2K3R+MNjtHe9QtACE/RuqoUuCAnlTggM/zT9d7bLil/8QJOMnbus/kBK7OuUB3b7m8+/+i/3exBMdCwqcR2i9CTqttQJsYeGENo5FwIU5ecMvm+dVkMijHdv2kmUS9jZxK/Ly0ziVC1eKqCoDOP3EcxrvNtWaVn3tCFMrkqRZ5+Kn7HGMLkUM7XUEQJRKycDIoqby6I5XMsshvPCTtI+GK+tGvCfaa46RcYLvhlmTTRmNp5sGnecZoDqd1ale+PeUFv8UmbVRC95A4qDE8lscS+wKcd1jAO6uqfkTTHCKPOXIZ7Rh1a1kgvhk7ePbw9odZNFd2RdwQUSyteRx410pUYxI6ZBQIyIA3AoQv+McWCR91CRS8vuOTgxLCwAkDczXHOl9y+ka4npTmg1d4TCsk/pzFb73bxVEE6Qppcex4Dna5S2bKTVhFzt8JN86+46bz7PwffzJpqgxjzEbBPa0Qa3ZBWzA/ueiIkVKfs/S6+uPIf0waLQFdWy2HHOvWsbYSTLeQvYR0sVnVUUOtiVgt6ygPaMqMj5BrLqZ+Ry6QAeDHaWQLMZFRLx8ziRdFureJylsDre7Wa6wdFcUkkTYDpv7xTghYUu90D5V5dA5w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(39860400002)(366004)(346002)(451199024)(1800799009)(186009)(31686004)(86362001)(31696002)(38100700002)(82960400001)(36756003)(6506007)(6666004)(478600001)(6486002)(5660300002)(54906003)(6916009)(316002)(2906002)(4326008)(8676002)(8936002)(26005)(6512007)(83380400001)(66946007)(7416002)(66556008)(66476007)(41300700001)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVJMK1ByclB4ZGVNNTdUU0tHZ05mYUpMeFFxOTVIZFYzd0hEUUlyNEJ5MkJX?=
 =?utf-8?B?dWd2cnllbHFyOFpBek51UDV5OG9GQzdnMnJKejJ1WmN4RDFhaERmbDlKMm1F?=
 =?utf-8?B?VDZBWTRZS0p4YlVzWEdneFZBRjBKRlF3aXYrdXRrMXRscmZBT2EzUXIyaFYz?=
 =?utf-8?B?eWtSUjZyQzBHQmRiR2t5c29zVlpBZjdCZ3k5VktQWktxM0JuVXBRV1FmRnBH?=
 =?utf-8?B?QlZiNlJrNmdUZzZmZGFuUzFqY0RpMEpuRGRPMnFWWUx4VUpReTRoUVNuYkJU?=
 =?utf-8?B?Rmx5Nzl0UVRyKzFnRk84L2hEZzZZWDVKWVU3QkdwRi9nd1dJcWRIQ2FYQ1NN?=
 =?utf-8?B?Q2VKclZWSDkzWWVyZXp4SnU4S1NkSm10Y3BmcmkwV1ZsY0JvaGVOUWcwZWNJ?=
 =?utf-8?B?VUcrWWJvQmgxQUhnN0NnS0YwZ2dXL3RYakFjcGZFYWZYWVM1SjVCQUZ2SFE5?=
 =?utf-8?B?QnVyWEUrdCtjWXMzcWJxOVZnV3hBM1dQZTJncGdJN2lNYnMybkRSaU1JdUVF?=
 =?utf-8?B?T2I3S3dFbEtMWUxXM0sxSEI1a3k3b3E2bi9oK0c4akV2TGc1S0xIUTd5bHBL?=
 =?utf-8?B?ejY0SmpSd3F5elBUdW9pckwxRTY4a3J5K0I4b1I3dUI3Q215enJPTWM2WDhl?=
 =?utf-8?B?M2c5M0R2S1YxSnU1ZEM5S0FGbkcyeGl1L0FjVllzVlN3QUdFK1hhNWVLdG5P?=
 =?utf-8?B?MmlwR3d6OXAwdTRHREcycU51VVBwZE00dmZQMEFsVFVIT2lNYkcvemx0aHBE?=
 =?utf-8?B?QSszSVRTc1o0cUE4L3UzSzBHTUxhSW1UYWNCYU95eUQvZmpJOHpVZCt4amZu?=
 =?utf-8?B?SUJ2QmJ4VFZNUVhDK3p3cTF6VnF1VUVRZnA0aWx4SWJqUUZySjJTaG12MGdE?=
 =?utf-8?B?OVFtSk9EZmFrY1dvTlQ0THBIc0RxT2U0TEs4ZFlxdkJobEVZcDFIQ1EwUDlH?=
 =?utf-8?B?ZHBSdlc4ckdKcUQ3MUV5YnRmbzY5ODgvRVB4Y0EwZkdQTkhva2l2N0tiY3Yw?=
 =?utf-8?B?T3BPUTBZWEp6MXZISmZqdm9qcDdtc2lPdEFudGlvWXg4QnIrMlNoY1BKdGpK?=
 =?utf-8?B?VmNxQmQ3UXRFWXFtM1FHeko0YU9GV0YrcitxSTJ1eTh0Z3pZbzJaRWJYKzlB?=
 =?utf-8?B?SWl2VVJtRGRrYlNpc3ZxMU5ReVRXZS9aRjd1Qjg3UnJvNHhSaWh4MDk4Vis1?=
 =?utf-8?B?RHpZQW9kYzk2WjhLOTR2QlBSaHlWdnh4ME1vTktsSEE0UlFuOGtVNDRxaWhG?=
 =?utf-8?B?QTRDR2VwQ0l2UnZ3U2xqWndlVmlHWXFUK1o2Q3VHSXpoU1IzTWFlT1J3Q1ZD?=
 =?utf-8?B?ZHJxamNGYkQwMmp1UmtRZUI4Y1FxUlVyWVEvNHBUU1EzcFpTUURCQktkS0xl?=
 =?utf-8?B?V0diVkVIUnp0czNaSGhXU04wWVl5M0RSWVVZZDVyOGsrQ0lhTjFiV3Z1Y1Ur?=
 =?utf-8?B?OW9qSDdNZHJSeGJ3SEVQcW5IZk5wZDJCWUpPc241eWpXTTl2VHRYb1Mzd0lJ?=
 =?utf-8?B?VE9jR25xSnFRdCt6ZVVTbTNNOWZ4anBjVUZmWVdyY2FheEYzNW5ZY01uUDl4?=
 =?utf-8?B?VlFycDNvdGVOYXNSc0lyMXBLM1B5Rjk3ZGl0WnJZaXAvZDFIODNTSjhIT0dX?=
 =?utf-8?B?L2RmRWJjZjJUVDNOeE5oZ3V5OWtoaGgySFJHS3NjeExxOXpUMXArMXY4U1pX?=
 =?utf-8?B?WjQ3Zk9jQVZxdzk1dzJCY0RZelFnZ0gyRGtkaFYrZlVlcUNnODVoQmRLOHZ5?=
 =?utf-8?B?UGtWa2ZLcmo3Q1hRc0ZNRDg3QnBXVFIwZjJFWWtCTEpCeDdDcDFWNkM5UDdF?=
 =?utf-8?B?UnVlVXdVaDNNOENsWXR3Mmh4L2JvRWJoT0F6SDNrVXVBSWRwZFF0c1BrbWR0?=
 =?utf-8?B?ZUJqTEJWdnVpNWFROE13VmlxMEFUaGs5Z3JJM1VMN05ZRTdUd3FlazEwQ0cz?=
 =?utf-8?B?Vnlodm1wLytjaElXcmJyYTUxdlRKN2RFeUpxRzFpSGpSUlBRZlRydmtTYk1V?=
 =?utf-8?B?V0tKdGdacEhJZ1prYnNOelh1QVBrZ1BsNE94MmZVTHNwQy9xWXVvMExmWEg5?=
 =?utf-8?B?Ui9RMDRNYWtGMkRaZDIzUFB4QS95aTJCK040TzJyM2xuUXQ1dGlweXJLcVlX?=
 =?utf-8?B?MUZjM0x0Zk1BVG1LSTc1cHlabGRySEVYQ1pZOU5vWjZjak5wMlFmSmQzT0Rq?=
 =?utf-8?B?NlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: beb0f4d9-5def-4938-1e5d-08dba4b6b16c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 15:27:57.2807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qhJYp7gxwEd9gv97X3gmeNfP8P0zTEPVF+SAx9qt10MDLIEKGbGdP11OffMkxRx1ky+jrZJ0qaZVY8S16yvwAE/wIAnYey7Iqodu6bQolBs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7728
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jesper Dangaard Brouer <hawk@kernel.org>
Date: Wed, 23 Aug 2023 21:45:04 +0200

> (Cc Olek as he have changes in this code path)

Thanks! I was reading the thread a bit on LKML, but being in the CC list
is more convenient :D

> 
> On 23/08/2023 11.47, Sebastian Andrzej Siewior wrote:
>> Hi,
>>
>> I've been looking at the page_pool locking.
>>
>> page_pool_alloc_frag() -> page_pool_alloc_pages() ->
>> __page_pool_get_cached():
>>
>> There core of the allocation is:
>> |         /* Caller MUST guarantee safe non-concurrent access, e.g.
>> softirq */
>> |         if (likely(pool->alloc.count)) {
>> |                 /* Fast-path */
>> |                 page = pool->alloc.cache[--pool->alloc.count];
>>
>> The access to the `cache' array and the `count' variable is not locked.
>> This is fine as long as there only one consumer per pool. In my
>> understanding the intention is to have one page_pool per NAPI callback
>> to ensure this.
>>
> 
> Yes, the intention is a single PP instance is "bound" to one RX-NAPI.

Isn't that also a misuse of page_pool->p.napi? I thought it can be set
only when page allocation and cache refill happen both inside the same
NAPI polling function. Otx2 uses workqueues to refill the queues,
meaning that consumer and producer can happen in different contexts or
even threads and it shouldn't set p.napi.

> 
> 
>> The pool can be filled in the same context (within allocation if the
>> pool is empty). There is also page_pool_recycle_in_cache() which fills
>> the pool from within skb free, for instance:
>>   napi_consume_skb() -> skb_release_all() -> skb_release_data() ->
>>   napi_frag_unref() -> page_pool_return_skb_page().
>>
>> The last one has the following check here:
>> |         napi = READ_ONCE(pp->p.napi);
>> |         allow_direct = napi_safe && napi &&
>> |                 READ_ONCE(napi->list_owner) == smp_processor_id();
>>
>> This eventually ends in page_pool_recycle_in_cache() where it adds the
>> page to the cache buffer if the check above is true (and BH is disabled).
>>
>> napi->list_owner is set once NAPI is scheduled until the poll callback
>> completed. It is safe to add items to list because only one of the two
>> can run on a single CPU and the completion of them ensured by having BH
>> disabled the whole time.
>>
>> This breaks in octeontx2 where a worker is used to fill the buffer:
>>    otx2_pool_refill_task() -> otx2_alloc_rbuf() -> __otx2_alloc_rbuf() ->
>>    otx2_alloc_pool_buf() -> page_pool_alloc_frag().
>>
> 
> This seems problematic! - this is NOT allowed.
> 
> But otx2_pool_refill_task() is a work-queue, and I though it runs in
> process-context.  This WQ process is not allowed to use the lockless PP
> cache.  This seems to be a bug!
> 
> The problematic part is otx2_alloc_rbuf() that disables BH:
> 
>  int otx2_alloc_rbuf(struct otx2_nic *pfvf, struct otx2_pool *pool,
>             dma_addr_t *dma)
>  {
>     int ret;
> 
>     local_bh_disable();
>     ret = __otx2_alloc_rbuf(pfvf, pool, dma);
>     local_bh_enable();
>     return ret;
>  }
> 
> The fix, can be to not do this local_bh_disable() in this driver?
> 
>> BH is disabled but the add of a page can still happen while NAPI
>> callback runs on a remote CPU and so corrupting the index/ array.
>>
>> API wise I would suggest to
>>
>> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
>> index 7ff80b80a6f9f..b50e219470a36 100644
>> --- a/net/core/page_pool.c
>> +++ b/net/core/page_pool.c
>> @@ -612,7 +612,7 @@ __page_pool_put_page(struct page_pool *pool,
>> struct page *page,
>>               page_pool_dma_sync_for_device(pool, page,
>>                                 dma_sync_size);
>>   -        if (allow_direct && in_softirq() &&
>> +        if (allow_direct && in_serving_softirq() &&
> 
> This is the "return/free/put" code path, where we have "allow_direct" as
> a protection in the API.  API users are suppose to use
> page_pool_recycle_direct() to indicate this, but as some point we
> allowed APIs to expose 'allow_direct'.
> 
> The PP-alloc side is more fragile, and maybe the in_serving_softirq()
> belongs there.
> 
>>               page_pool_recycle_in_cache(page, pool))
>>               return NULL;
>>   because the intention (as I understand it) is to be invoked from within
>> the NAPI callback (while softirq is served) and not if BH is just
>> disabled due to a lock or so.
>>
> 
> True, and it used-to-be like this (in_serving_softirq), but as Ilias
> wrote it was changed recently.  This was to support threaded-NAPI (in
> 542bcea4be866b ("net: page_pool: use in_softirq() instead")), which
> I understood was one of your (Sebastian's) use-cases.
> 
> 
>> It would also make sense to a add WARN_ON_ONCE(!in_serving_softirq()) to
>> page_pool_alloc_pages() to spot usage outside of softirq. But this will
>> trigger in every driver since the same function is used in the open
>> callback to initially setup the HW.
>>
> 
> I'm very open to ideas of detecting this.  Since mentioned commit PP is
> open to these kind of miss-uses of the API.
> 
> One idea would be to leverage that NAPI napi->list_owner will have been
> set to something else than -1, when this is NAPI context.  Getting hold
> of napi object, could be done via pp->p.napi (but as Jakub wrote this is
> opt-in ATM).
> 
> --Jesper

Thanks,
Olek

