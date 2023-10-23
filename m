Return-Path: <netdev+bounces-43603-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F967D3FDA
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 21:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBF151C20865
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 19:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A89A22321;
	Mon, 23 Oct 2023 19:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C7XABWDH"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE834125B0
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 19:09:43 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFB66FD
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 12:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698088180; x=1729624180;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6mjSSUqsiXTfUfE0Q4v4LWR1Ih8dTYLkyhyPoOedn2Y=;
  b=C7XABWDHwC2jgFzIjlf0WBSh4relSbx1YeqFqAdx85bCcOlP8cqZDsT1
   6VV8Dj3+ndOHEEAo6A0UvJyagv6ariECxgpVQ/n2bVQ7xWIg0w+1f27h8
   NQKQerSwyfp10zJX3FTLrobfFLNWqe3IfzlhgjKVd3jFyyz+CIw/iEzaa
   HT1oUXCd8xJGzXpXE2Fvq9OdtnP8+QgBHtvZjZm5Ls+m46GP5rmFSQ9tn
   pEhFBEM20/6OALWdu7Lwz1zCesv4wt9HXVRzlJJOuQBpaEx7knSxdVgGO
   TSELIxAfLTOPDBCT93dy7qbKz8On1dE5Iz2tPTnFY+A+b1bBQqvFWlM07
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="366255514"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="366255514"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 12:09:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="758219031"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="758219031"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Oct 2023 12:09:40 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 23 Oct 2023 12:09:39 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 23 Oct 2023 12:09:39 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 23 Oct 2023 12:09:39 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 23 Oct 2023 12:09:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZhwbKUQiWK16s718UKsXBstKdJvljtO0uLd5qP0/7R19iVVfbOi4WeeLjbcjHrm/kswlvqTZzPZWsDTxxfGUZp0hsiRdq2XKCK/J/wV3BqFuP2ebE45JxgcErhdx380iNlDeJBvgaQFS5GuPJT1cFjH2p/tslLRiuqm7f382oUydCDC8GJzy4XEoi74lzYIqj5vzxqgTBnOrBBo0KyH0QYobOwkV0SVRHaAT/7PmMfC+WNJ9BjZZZpWoaey7BlWkKOIWusaKPoKgJBy/3cNWAElEYMgpsKjy4Vj0mLlBw/83YQRpQHXMmhIMijtohHMC2GbcD3Eyrt8SzVhWaYPaoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e7sYAUjbwGXO5unz8e3+exhtGBKFSJGxbGlfuuK/SX4=;
 b=KTRNp75gJUuEKTRoXs92LW6xUCSSVy/3Gh1qsHfPoh0rpvY0CIzZ6a04NtxuLzI/GWacPc1mKsi9m9Ud3fSm+lKrAvbQDN6nshDVeoObcUSLsAEZSL0B+fRfQSYE9iPM7HfnNAyZl9ZAlUOEKIe3905pOsogX3IoL4XZcHEwRbG0M0hPxvbwcsCgKHwoOlDNZneqBIufMJO9NNyAuELtpBof23q4b8zluztyU28nWnGSFYmu5Pi74QpTAZW4RXym7bgGbW2xW/3hiBplN6dGapU5TiFHirYK91ZMXKVCNxljzVQEQqh6D3SsZ9yvb5ujAQ6QIsmUgYwXe7cyQvalsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7869.namprd11.prod.outlook.com (2603:10b6:208:3f6::7)
 by SA1PR11MB8325.namprd11.prod.outlook.com (2603:10b6:806:38c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.46; Mon, 23 Oct
 2023 19:09:36 +0000
Received: from IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::7ace:90c8:4593:f962]) by IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::7ace:90c8:4593:f962%7]) with mapi id 15.20.6907.025; Mon, 23 Oct 2023
 19:09:36 +0000
Message-ID: <8df14e3a-7eb3-412f-89da-69c9e4dee7d4@intel.com>
Date: Mon, 23 Oct 2023 12:09:33 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH v5 01/10] netdev-genl: spec: Extend netdev
 netlink spec in YAML for queue
To: Jakub Kicinski <kuba@kernel.org>, Philip Li <philip.li@intel.com>
CC: <oe-kbuild-all@lists.linux.dev>, kernel test robot <lkp@intel.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
References: <169767396671.6692.9945461089943525792.stgit@anambiarhost.jf.intel.com>
 <202310190900.9Dzgkbev-lkp@intel.com>
 <b499663e-1982-4043-9242-39a661009c71@intel.com>
 <20231020150557.00af950d@kernel.org> <ZTMu/3okW8ZVKYHM@rli9-mobl>
 <20231023075221.0b873800@kernel.org>
Content-Language: en-US
From: "Nambiar, Amritha" <amritha.nambiar@intel.com>
In-Reply-To: <20231023075221.0b873800@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0350.namprd04.prod.outlook.com
 (2603:10b6:303:8a::25) To IA1PR11MB7869.namprd11.prod.outlook.com
 (2603:10b6:208:3f6::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7869:EE_|SA1PR11MB8325:EE_
X-MS-Office365-Filtering-Correlation-Id: 290a3c1f-afa6-4114-1d29-08dbd3fb993b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eA2e0w8GJco5FvNUeKeyrcJ31DvAQ7u9meRV36BIC8jbqZLWrtw2T+brdtO5X8ZmqpV0ABxwzzkd10ytdgMrzdll9wryQ9OB4dqmh/bgWukCDwdBInYO+GlBgKfamwKrImSXo/hZeYkoNqJq0nlFW0Y/0FjZIaENbXMWjV+ayXqYTYl/SBCgDc7rDh0BiZQpVq+GIgskseaqD9DjwWL3ja7M2O7I9TRXYvl8k3tzPDes0ANI9oBZc7E9C7L8RZ/iEFXdrKOXwhhMSNY0VT+PlcHvPFdxSagpzPvi1865N4O1wAwcJSKv3jQk9IoIfh9xMc0xF9FTokj/VTELv1egfLvMPqlLASvSX/p2r/TCkd8bRxTsm26jdxDTZBnxcFrRBLAQ94f6XLxVjchuA27jD36+KW574C2zllbb434ZmPnFVu/Qse4fVScU3z5O2X19CXG8g1IIk58RvED6p5R9uH3QLh1v+NWVhonsssVjJl42D0MHf+GwL83+lC2VzrlJfcrKRuvtkl0aes5jYJR2rEnRReojk/BCYxbbtXDGJopJ/Fm3sHMXNJbBzyfJFVpssbTHI9gwqANJxc+1TVfpxckOFX+mkZBqq6MBoo6zcSO40x22h0auJJwl6bGjfUK8Bh2ULmsUuh/a9HvDwe6TmyC0Kvtsj6r6zx24anfIxhw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7869.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(376002)(136003)(346002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(66476007)(2906002)(66556008)(316002)(6636002)(66946007)(86362001)(8936002)(83380400001)(41300700001)(5660300002)(8676002)(31696002)(2616005)(4326008)(478600001)(82960400001)(966005)(6486002)(6506007)(36756003)(6666004)(110136005)(53546011)(26005)(31686004)(6512007)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b001T3JSblpXQkcwM0tTbzdQbjRMczRYcVVLRENEVXo4L2VjcDdXNjVIaHNr?=
 =?utf-8?B?c05wNXcxSTR5Nnc1Y3RzOUY4NThIbmx4UmZWSk1sWHFWNjR4RWt0U01Hdmw1?=
 =?utf-8?B?VTRGc2VqOGZoL3RobHREVUlJV0ROc2tQaGJtbWtvR1hwZk1LSStyTnlRVjAy?=
 =?utf-8?B?d2NmOUY4dG11YVpZbndHYWlKVnFCaFNDeGE5UThJTU1rUitGUFREbzNoN1pj?=
 =?utf-8?B?b00xUlcvWjJyaWxncEs0TFVyYmx1VUJZL0svQVFHQk9HSVlBdG5haXk4eWRP?=
 =?utf-8?B?STd2anhWN0EyVHF6RktweTJwZkhNU05wd2FKT0JlZzd1eGdMc3lOSjFacFZv?=
 =?utf-8?B?Tnl4eDYxTUhjZGlOQllWNHp5REROUmVMSmFjRjc5NGRuL3dKN084bW5maHMx?=
 =?utf-8?B?b0lPWllvVDZ1akFTUTNrWVlqVncwTDgzZTc5NHBGbDZOM2gxdHNIeHFjQk9S?=
 =?utf-8?B?Y1VlZTBZY0tPR21DR0xaejRGZnZNNjVkcjM3MTVSODRjRnRQTEsyOUpKQTBP?=
 =?utf-8?B?Unp5ZUg1bGVUaGl4dW5YcE9heW5hTWlYUHl4ajNxUHA4YzFib3MvbGZCNnZF?=
 =?utf-8?B?cy9EL3V3QnF2K3QxTTNZVExQQ1hSNVpZUlJkc3puTDBobU91WWlvSmRUT3Bs?=
 =?utf-8?B?UHhhanRJUnZCY053WDBQaDhTYW9oeHBmUHd1M3lMcjdYYlhPVUk2WlZ5WnRy?=
 =?utf-8?B?L3pQK3NNOUpiU1NCbS9QMlF4bHJGVVdoUnU0TjdaZ21yajZkdFRSZzIzWTMz?=
 =?utf-8?B?NlJUYit6cjE0VVc1UHZyOVYvZ25odlhwQWw0VHMydWVKMnNweGQxME9Tekl3?=
 =?utf-8?B?OWVCRXpxMHlPb0ljM0Flc3Budlprc1FEOXFDV3NmUFlXZVhUSFNUWTBLWXZN?=
 =?utf-8?B?U0FkYTdEbldRZUR4NW5pVlA3T1dOczdHZzVxeFA5dEpjT1RLNEwwK1JyTHVB?=
 =?utf-8?B?dGxCZXNzb3gzUVh6d1pCeU5OMHBla0g3em11ZVFUcnZQT0hXR3ZjakxuMW9R?=
 =?utf-8?B?aSt1SmtvWVkwY3hxYzRBdXUrampmeGxxZ1N1OGRyNFUxZDQ0ektMeDAxSG5w?=
 =?utf-8?B?alh5d25ienlpbUw3WmVFZXU4bzN3bUxxa2N3NUpWb0toT0RHb3NUaklxQWha?=
 =?utf-8?B?MnMwQ0pCTFNuV253eis5YThkSU5jcFJaY0sreTZYUTVWd2I4cVFoRCtvTkx0?=
 =?utf-8?B?bnBpVmpkWVEzUWhGQktlYXVmT3pLdFg1bTVSaVBmY2dwVUNrajBuNTlWRmlu?=
 =?utf-8?B?aHhWajNqTEl1YnM4eTJ0dFhNVnFsakxDTmRtWm54Y2FRSXhlOVdIKzh4UHc1?=
 =?utf-8?B?TklHbm8xbVg1dmxWaFRySTJmQVJTSjRLamVuS3U5NHdEYXZqZUptdTlUUSt4?=
 =?utf-8?B?czVKcC93T09QaGdtZW41cUFrVGhadFpkbVlpL0h6bmVPMENQb0JiQmdOR3Rq?=
 =?utf-8?B?eG8yLzNnYXFyZmZaSjhCQkt6RStQeXBPajhoN005MEhFTC95cFRCaFNpb0xE?=
 =?utf-8?B?Z3R3dVQ5cDRnQ0RxaXJJTXBYcWRtanV4Rnc4bmNOV3RZYS84TkcrZHVGOE52?=
 =?utf-8?B?TVlyaklsTzh1RFVROWZsem52K3NrZEZ6NTF6Qi9tak1UT3hZRzRoaFdOTkhV?=
 =?utf-8?B?bnZpai9WQTYxWldYQ3ltNHZUbnNSaG91SmtZWVZtNTBKMUVnWjZ4Tk1XR0ZC?=
 =?utf-8?B?Q29iRXFZS0VQWEU3Z0xBVjB1dTFOdlFzaWF1SVB3RjgzY2ZsZVhlS05ScUJH?=
 =?utf-8?B?OXozZWY3T2hGQmxyb0c1cENEWWpMeTRNNXhEU0U0OExqWVdDU1N2SlVRdTdk?=
 =?utf-8?B?a3V6eGU0cVRwQUlpeVJzSllNZlR2MWpjc29KNm1LTC9FYnZGOEgzNXo2WkZQ?=
 =?utf-8?B?aGNpQ1Y3UjBkSjZORlVpdk5KL09HdHg2YkdXc0Y0clJvQWVwN25lTHRKTnBW?=
 =?utf-8?B?OGNqTUtoRjhTVWY4R0lHQmZYQVFxd0lmNStzLzJqa0RueW0wTm1RNlNmZWFM?=
 =?utf-8?B?WCtPekxmUDU5MFlHZ2hLT3RkemZjTS8rYWtxQnIvVUttS1RYZnFuQVZsQXFr?=
 =?utf-8?B?ZFNRY1JHdDVXb0FuU2hFYUhLRFlRUUIycllmMDloMU96NmVZOUdNa2I4dkFp?=
 =?utf-8?B?eDdveHBGeEVSOEpxZFMwYVR0THowQlU3QjJxUGFWWGRGcHRzeVFleG5hb0F2?=
 =?utf-8?B?aWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 290a3c1f-afa6-4114-1d29-08dbd3fb993b
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7869.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 19:09:36.6160
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SvlldtKDTofK9EuFAz1kRFvRI/L6Guv/7NG+ZtujnZzrFK8sZxYCg4at2rwRervBsKUjcPlPPczixmjywbGmqZWOVg87hRQjhCL5pApx5Os=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8325
X-OriginatorOrg: intel.com

On 10/23/2023 7:52 AM, Jakub Kicinski wrote:
> On Sat, 21 Oct 2023 09:53:03 +0800 Philip Li wrote:
>>> Some of them are bogus. TBH I'm not sure how much value running
>>> checkpatch in the bot adds. It's really trivial to run for the
>>
>> It is found there're quite some checkpatch related fix commits on
>> mainline.
> 
> Those changes are mostly for old code, aren't they?
> It'd be useful to do some analysis of how long ago the mis-formatted
> code has been introduced. Because if new code doesn't get fixes
> there's no point testing new patches..
> 
>> Thus the bot wants to extend the coverage and do shift
>> left testing on developer repos and mailing list patches.
> 
> I understand and appreciate the effort.
> 
> I think that false positive has about a 100x the negative effect of a
> true positive. If more than 1% of checkpatch warnings are ignored, we
> should *not* report them to the list. Currently in networking we fully
> trust the build bot and as soon as a patch set gets a reply from you it
> gets auto-dropped from our review queue.

Hi Jakub,

Just checking if this series is dropped from the review queue because of 
the build bot warnings...
should I submit a v6 with the single line fix for the warning (legit) on 
patch-3, or
should I wait for more feedback (if there is a chance this v5 series 
would still be reviewed) and address them all together submitting v6.

> It'd be quite bad if we have to double check the reports.
> 
> Speaking of false positive rate - we disabled some checks in our own
> use of checkpatch:
> https://github.com/kuba-moo/nipa/blob/master/tests/patch/checkpatch/checkpatch.sh#L6-L12
> and we still get about 26% false positive rate! (Count by looking at
> checks that failed and were ignored, because patch was merged anyway).
> A lot of those may be line length related (we still prefer 80 char
> limit) but even without that - checkpatch false positives a lot.
> 
> And the maintainer is not very receptive to improvements for false
> positives:
> https://lore.kernel.org/all/20231013172739.1113964-1-kuba@kernel.org/
> 
>> But as you mentioned above, we will take furture care to the output
>> of checkpatch to be conservative for the reporting.
> 
> FWIW the most issues that "get through" in networking are issues
> in documentation (warnings for make htmldocs) :(

