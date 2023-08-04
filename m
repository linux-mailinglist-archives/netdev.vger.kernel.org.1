Return-Path: <netdev+bounces-24456-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25AE97703A1
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 16:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 569C41C20EDD
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 14:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E24B9CA56;
	Fri,  4 Aug 2023 14:55:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD1D1C2D9
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 14:55:13 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F35B049C1
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 07:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691160911; x=1722696911;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xFDf/cCb9CzPQe1qHmeT6CzDjDsZuoqM+QaQOm8fPy8=;
  b=mVjz14XUdFiEs6kwoC2KD7E1L1oDG9NR3dz/5vCbKIVCOvQfsTVZ9WzU
   klBOgdB6jfX8ZGlWoFfaK/YvSsmss0QakxMJfkyLJGDVduSHsobtlGnDP
   qZa2f9WKcQxjmerxOxS6C+4DT5m8T9SKwMG55wFbtVOYlMbRU7SXGfjve
   AVUZdibY11798b5F0IoTluuH4jFwxZzZusGrjcSeud43CcIkAnhhBE6fc
   aZPho8aNHc0F+3niVSvihYUiat4VLhP7HCt7jD6IF0jFJzr1r6S6/QUOD
   a2SrppXhInkkENux0n2zwpBCQ7ikU7kFgKkobPgWPw0N0nUrgL0HG3kP6
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="350473266"
X-IronPort-AV: E=Sophos;i="6.01,255,1684825200"; 
   d="scan'208";a="350473266"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2023 07:54:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="873429273"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP; 04 Aug 2023 07:55:02 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 4 Aug 2023 07:54:59 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 4 Aug 2023 07:54:59 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 4 Aug 2023 07:54:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hG3QzUr8baY6hSnn8vowkeTm87ImTEmjiQKIqFGU9IUuDHOBfECRkSlBjdlGI8E8N7MJGQ0uymxSGGCCcIPe1iznwuL5Oe77SlRBvOEaPnD4+XN27A8syXPFlHA0MdpvNB99jzSb6WrDJjGBGBG6sY1oDSamFB0ee6Mjq0pFx5deH0OV/AMDb79u8+X7wNAuvQSXWkNJWyR2L/aJrs66jkcTO4imPjGGWwlYXXdTTwV9m9UoxIt+aa7qLdc6+DAdZ3qZ1JfWc6D5FALEVVfhHswMcoln2repGzVtcyWecNhPYeLDMYc437Ahx54imzDzH1t19Bh+yXTpQkofRMLKhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e/l6c43cMtDrYnGzHF53Rz72C6Ew0F0a1kQdHFUOvRY=;
 b=g3LPbBK3DKZM1wu58XGLa3C0TvcSXz95u0/iRkwy5oH6SHDvhPq3xqtvvPLNO+y8mpTOo5iJTicEZub9PAX020tT5HPsu8usMODzHDibZsHh7fkP8fmLWJAoREm9sQnDEEoXcCXTOQF4+Lh79mr7OQkGrmxwzvRYjhPrTRN+qfalarQTJZf+O9K45GOt71hSV/qrBPVsKP3kAQnORnAC7SfpOdu3DGD1dO2xXpFSLurLxvGfLOIbH9ngPVbGNI6C95CB83gCSDDAQmO0KpOgy1Sr4xMErOCazRCWnilgXgwsnF87+1BgEivHEkHL88TT5DNgI1sNl8BO1bkYnqrvlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3672.namprd11.prod.outlook.com (2603:10b6:a03:fa::30)
 by DS7PR11MB7950.namprd11.prod.outlook.com (2603:10b6:8:e0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.21; Fri, 4 Aug
 2023 14:54:57 +0000
Received: from BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::7ed4:d535:7f41:de71]) by BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::7ed4:d535:7f41:de71%6]) with mapi id 15.20.6652.021; Fri, 4 Aug 2023
 14:54:57 +0000
Message-ID: <385c8607-bc52-af0b-829a-5b058f4a152d@intel.com>
Date: Fri, 4 Aug 2023 16:54:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH iwl-next v2] ice: split ice_aq_wait_for_event() func into
 two
Content-Language: en-US
To: Simon Horman <horms@kernel.org>
CC: <intel-wired-lan@lists.osuosl.org>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, <netdev@vger.kernel.org>, Jacob Keller
	<jacob.e.keller@intel.com>, Jesse Brandeburg <jesse.brandeburg@intel.com>
References: <20230803151347.23322-1-przemyslaw.kitszel@intel.com>
 <ZM0MlhZduLVa6YZV@kernel.org>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <ZM0MlhZduLVa6YZV@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0109.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a3::9) To BYAPR11MB3672.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::30)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3672:EE_|DS7PR11MB7950:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ee5316c-2eb7-4d84-ff5e-08db94fac4f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ngJaV9Ac4sD0vprmsXRQ+10KdoaaR8+VXFMQ6w87iNIHO9x4cLXqZQ5tPW88vcXlDT+/5+EEknmvJN2Cm4VkmZHdKlbeo110AOwHVk3U7kfqLg4leuSFEYSxytLA+E0p+JYj6xjw9XgWG9WQZ6lVDn5Wgj5rxeh7jO4SBRPc5Ar7VbSkEID6GYPH0+gv6Tm+f+Aq8nQZXodOx1/LuueSX+WJ5ynotl/5svbNVF5AdUvoy1afJ53/jyU1yCiHq+3LK3H4UZuWk3QyiXCYlkPges2G7CE3EPvI2CjtxKL4mLvj4CzusczQU7sFd677vNyFzfpN0iYN6e1mi8QH/giZYfHzAjp6lAKVfow6LN9GgxFAa5mcYVoqO/NzkuNRT2AD6Rb6M29YnDkSDaygvLpE3wVKfsq5i9vNsCTCctY0ejEtJmWErn+WsUy6xTJolVlDNCwG+rs3Matoukx2AaV+k6mehO1fiYrC32YcDMyt7dUL4kjVT5pRXnCHyHVX8DMwC0oU9ujfu++nEzHU5JCcqcYg8aaQROh0HeHq8B9Zn5OMk5TsY7qumtpxU1GvGhaJL2Bt++w6WHdGRnydH6E1+zFYqrAAnAtjnDZ+ZxWBmB3rrPsoNya22th6lMf8F5hlw0LxydsQpBAbelIGwQQ7Jw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3672.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(376002)(366004)(346002)(396003)(451199021)(186006)(1800799003)(6666004)(6486002)(6512007)(86362001)(31696002)(6506007)(26005)(107886003)(36756003)(2616005)(53546011)(83380400001)(38100700002)(82960400001)(5660300002)(41300700001)(8936002)(8676002)(31686004)(4326008)(6916009)(2906002)(66556008)(66476007)(66946007)(316002)(478600001)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2MyTzg5Y0JwZEQ1UXVkZnJUR2dOTmJqcVA2UkxYUE1IcUdYRENVNjNZMlJZ?=
 =?utf-8?B?aHJVL2laWXVZSmRoVTAzT1d0SVFtUXNaM3paOGs3SGkvczFxK3UreWhUT201?=
 =?utf-8?B?SXJobG0yMXJvTWx5UHo5RXpNMVpVVmxFQ1F4cjdSK201SU1yYk5BZWZ1RjFO?=
 =?utf-8?B?YnczNDFrbXprdXMycVZXYXFSMVRycnZRVmViWXpGVmp1eVRjODc5eU9TWWVY?=
 =?utf-8?B?eC9FdG4vektIUGhneFgrZFd0UGhEdDhmcEVCNHFLYUhiZENGZ21jUHdyTXpS?=
 =?utf-8?B?UDAvdUNKZnZOQ3dDaHJxMjRJWFNqNktWQzRQWkVmaGpEeU1uVm52ZkdndDBB?=
 =?utf-8?B?R29TKzZwWlg1dGxxb2ZDaWdYU0NVTzRVZXF4SDRkQnFBNDE0cnUyL3QvRDUx?=
 =?utf-8?B?b09xVmVlQ25QdVJ2UHM5MlBrMUYwUjkrZ3JleEE1ZlJDSTJRYW4yQVF6eVZ3?=
 =?utf-8?B?ZHpXMitBbGNJNE5Zd1VuOGx0MTZBN0hjMUZHT242eEZlbzZzYzZVczRweHNy?=
 =?utf-8?B?Q2thL2FTNkpHbG1NSUdESXc0ZGZmM0pmUFVGWnR2RDc2UWxVUVFsakFITnpB?=
 =?utf-8?B?dDlhenVGREs5eDNVSTczOG5IVXVINW9CemRSdFN0ZjBIVHRjTG9HZTN1Tk1T?=
 =?utf-8?B?ekUxdTVNbFdVUUU1Ri9hbGJUSG9JTVdnVkpsZHJLNkE4NzNuZHRQWFpPT0Fo?=
 =?utf-8?B?bnovUU8yc0NNS2tDV005cFdmS2wyUTY5T3hPSnkxR3ZwK0llaGg4MDIyVXRB?=
 =?utf-8?B?RTE5MjVkS1RxU3lnbk1udmxOVC9TMm1NTWQzbzRmL3gwclBtOVVZdnhMWHk1?=
 =?utf-8?B?dnFZdnpPTjBSSE4zTHpLbUFqa2xiRExRQnlRQnR2bmNpRnFyWDVCbTVNWTU4?=
 =?utf-8?B?L1FHVG00SGJlTlZHVDFQMlEzTzVKN2RLb1Y5Y2YxVlZVUXVDK3prOHZEUGc4?=
 =?utf-8?B?SWs1eFI5NXhRR01kQ3VPd1ZjRE1uS1pmdmdncFZkZzRCcVl1OFhmY1RMd28v?=
 =?utf-8?B?UlRteGpZQXlIWnN3MFJPdmJOeUtRY2tvYkJvVzQ0bW0ySGRjNDVDSEJsSVR5?=
 =?utf-8?B?RTNEdUEwdE5aTW5iU0wya1p6TnJtT3V5dTBvbnZtZ0hHZmJ6Vm5nZmVKczNZ?=
 =?utf-8?B?d3I0YThYRlo1dVpONDZEdGxDUUxpUTNWTnJlbXBoTDZ5R0k4SDllWVhKZFlB?=
 =?utf-8?B?U3dDaUJuVWFKb0dEQTdOKy9pWlZBUFdzcmFHQWJ2WjNzeTJ3UU51RHN3bmpS?=
 =?utf-8?B?WDZ5eVlQQkZCcmlpcGo3SlFMUUtOa3hxYmFuamVCQkxYS09GN2hrZkpKVURB?=
 =?utf-8?B?ZUJ2OFF4cFY4cUk5YU81UE51dE5LRGhTSlAvQjkxemU0djVsc25GVEJJU29I?=
 =?utf-8?B?eU0vbTNmUjVZMTJHR0xHNUFJU014WVlVTlJJOERic2Ewc1VKeWdFa2hBZloz?=
 =?utf-8?B?NnZSbEcwYU5SaDV5bXJFeVd6Q0QxUkFIekVJWEdSeVJoek1jYXNLalRyMVUw?=
 =?utf-8?B?ODcwdXJ3UVpmN3dQTlZVa1hxWHdEVXgzUmFWWlNxRHM5R29JZzZuYzZoNTdH?=
 =?utf-8?B?cFJWd0o0ZC8xd3NWTlJvQ1ZpZmFmTnBTNEU2cTZ0OTV6UVo3Vlc0b21FbHhm?=
 =?utf-8?B?RGVoSFdzTk5weHlpRU1hNmtwWlpTV2FhRVNOanpyQ09ZRnpTMU9RME9KQnVy?=
 =?utf-8?B?U2gwWEpRNmpaNDlMQk9jdGoyS21LcEdmbGZodUR6ekJoQUlEVFQyYW5ZRFBY?=
 =?utf-8?B?SExSQ2ZXc1UzbHFDMnlmRkFCazhmdWNmaFVmYW8ydHBDMVhWUng0bGdYZDdk?=
 =?utf-8?B?NnhFUFdDcFBrTDR3NTRSSlA5YU54eGpYYzU0NHZwMmFpVUZNaDVJVnR4bHlk?=
 =?utf-8?B?MnEzS21FZlN3Y1RoRUQ3ckRmczF2allzVXRQTjg1M085ZTduSm5SdDlCYTdY?=
 =?utf-8?B?T2Jva1YzQWIrWk1LbW9kb1REUHFOdnVFNWxZSmxsaEpBNEdGRUFEbTVpRUJ5?=
 =?utf-8?B?dGhEM213SmttendZakV3YzlWcmI3K1FnWG9EY0s1TWs4T3lBbGtaeWFDcXN0?=
 =?utf-8?B?elRmL2dNWndLMnpUSDBUN2lKek5laVpEQ3VnTTN2K2ZQSjN5cWxlaExQNjB6?=
 =?utf-8?B?bXRiajEwcEZEZlpJVGw2ZlkxNTg2WDdUMjQxdzBwMGxJbmhzemVQK3VnWHVv?=
 =?utf-8?B?cmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ee5316c-2eb7-4d84-ff5e-08db94fac4f0
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3672.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 14:54:57.2559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wpOoXejh6HV2NaCZ7zluX4cuRgyPUviwYWmxLF91AvLjHK+ADttpBzzOcC3HM97OMvKnfEDaDBa1AoebpB/YiunuiW73kxjm0TYHsL9L5/s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7950
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/4/23 16:35, Simon Horman wrote:
> On Thu, Aug 03, 2023 at 11:13:47AM -0400, Przemek Kitszel wrote:
>> Mitigate race between registering on wait list and receiving
>> AQ Response from FW.
>>
>> ice_aq_prep_for_event() should be called before sending AQ command,
>> ice_aq_wait_for_event() should be called after sending AQ command,
>> to wait for AQ Response.
>>
>> struct ice_aq_task is exposed to callers, what takes burden of memory
>> ownership out from AQ-wait family of functions.
>>
>> Embed struct ice_rq_event_info event into struct ice_aq_task
>> (instead of it being a ptr), to remove some more code from the callers.

see [1] below

>>
>> Additional fix: one of the checks in ice_aq_check_events() was off by one.
> 
> Hi Przemek,
> 
> This patch seems to be doing three things:
> 
> 1. Refactoring code, in order to allow
> 2. Addressing a race condition

those two are hard to split, perhaps some shuffling of code prior to 
actual 2., eg [1] above.

> 3. Correcting an off-by-one error

That's literally one line-fix, which would be overwritten/touched by 
next patch then.

> 
> All good stuff. But all complex, and 1 somewhat buries 2 and 3.
> I'm wondering if the patch could be broken up into smaller patches
> to aid both review new and inspection later.

Overall, I've started with more patches locally when developing that, 
and with "avoid trashing" principle concluded to squash.
Still, I agree that next attempt at splitting would be beneficial, will 
post v3.

> 
> The above notwithstanding, the code does seems fine to me.
> 
>> Please note, that this was found by reading the code,
>> an actual race has not yet materialized.
> 
> Sure. But I do wonder if a fixes tag might be appropriate anyway.

For this off-by-one, (3. on your list) sure.

For the race (2.), I think it's not so good - ice_aq_wait_for_event() 
was introduced to handle FW update that is counted in seconds, so the 
race was theoretical in that scenario. Later we started adding new 
usages to (general, in principle) waiting "API", with more to come, so 
still worth "fixing".

> 
>> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

Anyway, let's see what v3 will bring :)

