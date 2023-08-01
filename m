Return-Path: <netdev+bounces-23348-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8081076BADC
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 19:11:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A04F281A55
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 17:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F58321D20;
	Tue,  1 Aug 2023 17:11:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE752CA5
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 17:11:21 +0000 (UTC)
Received: from mgamail.intel.com (unknown [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DCDF30C3
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 10:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690909863; x=1722445863;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SzlHGGA/fKfmRQEpuN9sfh+VaTRDK0EafuBCLif5ssw=;
  b=YE8mwBDPwgMEyJGQq0pW/bhpO7aXT+EO/xYv17yqvr779WxwVaz/SeK1
   tr0vEr7OHqQPHTmjHSt6N1HnQpr1B8mSSiijOsq6OKLkTENP8LfAdEf8d
   eC6INhE+4BG84+Y2YGAGjSgSg1VN0Y4VwI8GZHpuOCyEJ8ti5K2O0mHqV
   aIVCdIa+/o//NqPSbyP0IpS0xELca1rk7HmnOLGTRnp7YqPPNFKkONzWr
   fmI3+rPoJ/T09ya7zifm7ziF/Omg6OoCZhHbWGE/8ih2dRVrumCBm8Aw/
   P+gK3BM93XRPEqBn9xi0nLpzUz0Gxkyt2uYepgBjIw61XJeLUvCKR4YbR
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="359403155"
X-IronPort-AV: E=Sophos;i="6.01,247,1684825200"; 
   d="scan'208";a="359403155"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 10:05:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="975378637"
X-IronPort-AV: E=Sophos;i="6.01,247,1684825200"; 
   d="scan'208";a="975378637"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP; 01 Aug 2023 10:05:45 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 1 Aug 2023 10:05:45 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 1 Aug 2023 10:05:45 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.102)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 1 Aug 2023 10:05:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fvJd7ROBIhkR2OPPqEO6WmUvl+xTrBiFZFAjlXpbt0iFMAfCKbHM1RHWmJivy5Rzu0BXCDbTM+wMMY1Y/iXnh8+pqQaCX3aPIbJeu0P0tYF841LIo9gwt+9HpGf/jigXE17qF0xWi+SRNSHLx828gGpkERuvNBUZxEYUW6+39yMz7BncDNhM/TLgYmqeLwB+YpAY8bPsdh9uf+lY1fsC3+BDo57xO6h87OwSRofhKkDdmYmlRJzDJs298OMz63mUQkJAdUsXzkrskpXasIrQsbAI3Ay1etLVEzq566PEvzETgnIZ7n0U9UKq3eW8O/Zuw8uqHaq60una/LBDzVwliw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=202Id9PscutiZ0TJHd7msuLArz2ymcowLpgF9wUtQoo=;
 b=ZnI5oeL4Bqhmfe5z6ioXRLVNaF505Orn8gR92W3QVcpntguvaPkGT8r8rXuDdTZXh/WNh6A1zU/oTA/tIJfnP2EeqWZ7+s+mkRSgtskIzs96sogNJMHGbrR3RecxxTMi2vDtib9pvuZhAkGluhW3Sz5B4mtXKKNwJeTvyGqYGWVco0hMs+e1N4Tmu2mMxBmzkiSlYid10jloZUuOB4lkvIrMOAC3b2kW+ZVhvH4HyPSsv/4iqC2LVsXvOG0uXj1Aa15jweBUeSt6fQQlG1Wy+qSV+lewRtc2QJU7mZK5/O4PeG60q6VYFt7h4CQcBjsCqVho4xsQ7jWI+h0QVJeSUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by CH3PR11MB8383.namprd11.prod.outlook.com (2603:10b6:610:171::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44; Tue, 1 Aug
 2023 17:05:43 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a%7]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 17:05:43 +0000
Message-ID: <5dd6005a-31cd-242b-f48b-2b5c4e0567da@intel.com>
Date: Tue, 1 Aug 2023 19:03:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [alobakin:iavf-pp-frag 11/28] net/core/page_pool.c:582:9: sparse:
 sparse: incorrect type in argument 1 (different address spaces)
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
CC: kernel test robot <lkp@intel.com>, <oe-kbuild-all@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	<loongarch@lists.linux.dev>
References: <202307292029.cFz0s8Hh-lkp@intel.com>
 <217dc739-05f5-a708-d358-ba331325d0cd@intel.com>
 <20230801095321.3ce734c1@kernel.org>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20230801095321.3ce734c1@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0131.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7a::8) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|CH3PR11MB8383:EE_
X-MS-Office365-Filtering-Correlation-Id: 0be09ddc-d616-40c2-52a4-08db92b18a60
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7ms7+dBiopcuzObcw2lMyUyTUKvGQcUD0m0ZzQLeEhKO1x1riisO18m7367nDWe/A0TNjFO1GxrokWMW8zLqHyH61cVUIZOG/nWI+rPqZRQgKSouHfhG++bQDR4+HcQpsAUwe6VhXxh8Gcqq0D7YBh1ssPvgUly3ug4xRJv5xy5AZjtvzQ5Zuw0X9XiFVyX2GIGqoez9cMb1bRnG4BTPKCzwh0+lXDlA47rEvGHqFTuqwgb4+76YZ+V2kOrq4fba5GZ7kfGwRCEID/OpA9FkwrA3BLHAxwIE7QzIoSGdZcBcnEGQyPK1+FGRqS7arM8Qd3SXs/kRdEQp2bOI5ee0Ae/PgxBSLnOsWMELc86Y8lKz7WG/6eLnFzs+nJ2Z05btx+YcxjKm8YFNki46m8L6gw9gY/azvPY2orvVGu8zZTLQQ70i2E0AUIOthw2TgVMvkXWS3pj4f7AYsO+aJC2F/lS/JtGCFdgcU2qs+V/L9prZwOTwKTIEV0FGQF8UPnpp004loCYDjRjL6VCWd05p/7AXNLWXRA75fYLJxRG2PBXbnUetOQmzdNnpam7v1HmDrT+ETsathvHUZ3l9ipaeh/5nTl8rUis7Ms8K+22O0y++uGemFVm8b2ITZHAeWdwv6+IJTedJLily+oCK7WzjLg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(346002)(136003)(376002)(366004)(451199021)(38100700002)(6506007)(5660300002)(6916009)(4326008)(66946007)(66476007)(66556008)(82960400001)(54906003)(6512007)(966005)(478600001)(2906002)(2616005)(8936002)(8676002)(6486002)(41300700001)(31686004)(36756003)(31696002)(186003)(316002)(86362001)(6666004)(26005)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cXNwRVBxKzRtaE5xRkg3OTBZdGtOTWFWcFlQaDBva0ErSjJmNHgrM1FWT3FF?=
 =?utf-8?B?cVFrcU9RZ1QvZmtYV3laaG1DbkVreDJ3K25pcER3MGVkWjk0VzRaOEY2ZVdI?=
 =?utf-8?B?V1ZYa2tYbTM4REFKb3JSOEUveUlCZmUzaEhWN3kxdUhRanVhSEZydzNIVkFU?=
 =?utf-8?B?dENTY0gzdDYveUxzdFpUanZNdDh5L3hmeDhmbHIxc0wrcE50MWFBRjZGNVNu?=
 =?utf-8?B?Q1NqWGR0THMxRDFUaXJ6UlJBSXFZY0FRMXZURkRwbG43dlY4SU5oQlVqQXRV?=
 =?utf-8?B?c01NQ09QYWR5eHRpMHBLeUJLSG9KTGVXWVdsN0Q1VWxaWHRTeGpFN08yS0Nk?=
 =?utf-8?B?Q2pNV3J3OFRrZUo1YUJuc1VSWjI3VVl5YXlMOUlYS1YyMFUxWDNaeUcvaFVy?=
 =?utf-8?B?ZnFvQlA5eUZqSGVFRys5WjJ0NDBUQWl6N3VYeEJZZ3I3ODdNd3gxUFNDbTgx?=
 =?utf-8?B?UGRJTW1LQnZVZkxhYWIrVmxaUTFQbnVtOEFudDN1L1VzQ1hlRVVEaUNvdis4?=
 =?utf-8?B?MXBaR2lqL3VQZnFjSXkrZStwbXBZTExsRitFTU5sM3JnUzRHb3FWemNiMFl6?=
 =?utf-8?B?YTlIOUk1L0RHbjROU2RQL1hYZkwzczhiSER1Y3JKY2xJZ3FZMytSVFRINnFt?=
 =?utf-8?B?ejBDZFZwdHlwNGtxM2dadWVtNEZDdmJXRlpXN0UvQXh2c3kxL0dHU1M4Q3Vn?=
 =?utf-8?B?ZUpRUWsrMFhUR0hDQ1FaWW9MeERNamlwSVNjWm00REtDdU14YjBSOTVraDNr?=
 =?utf-8?B?cG9sOUJnNHRZd1hscGhPRU51c2MrNmhudHFGajR2ekx1QnlzZDAxSENQdXA4?=
 =?utf-8?B?d3l2cVJKeDlWUWpONlNIN3pNenAwQ2hLdCs0QTBQeHlHUjlWd2VpRjJ6ZkZ3?=
 =?utf-8?B?ZkZoMmV2U1RxZTJndlVnYnp5Rjh3azZmQVgvTVlNc2JyZDNLVUludVpIZjhv?=
 =?utf-8?B?K1BBM1FQdUdQcGtoV2lFTHM5UXZSWUJYUUMxWWt6MW9vZHp5dERpUFVrcFZ1?=
 =?utf-8?B?RkltYUIreHdUaUxZSERURldReVQyckU1VE5ZZFJoYTNWRWU3Umwzb2Ureklm?=
 =?utf-8?B?NmlXa3gzVEJwaHBHSm1vSnZ0eGZEY0kxZ1JGOXlRVzE5VGdzMmVCWFlNbDdU?=
 =?utf-8?B?R3lwZnowOUkwWXVPVEtCNDFYeFRRT2FrclltL2psT3pTNld6WW5hclJJWWYv?=
 =?utf-8?B?TTIyUUdFLzFydFJXQllzWXE1MEMyZGwyck5SdWd0eG96bS9Ja0lQaTY4L3Jv?=
 =?utf-8?B?VnE2SlVUTGpwRUZac3B3NlFuT3JBZGZwV2FvUno3YXE5OVFNaXBPQ21NRWZM?=
 =?utf-8?B?VnZrRmlMZkF0UEV3cjRDZytUck9seGMwU0YvaHhhVS9sQ0FjQW9CV1Q3UEty?=
 =?utf-8?B?aW5wUFlQZVQ5Uk5vQmlWZjY1UWNJYk5qODZVam5iWVlXUDdsRVRSOC9XQnVX?=
 =?utf-8?B?eHBOSlFGa1d4S1hqSUIxWjAyK0R0WXNpdUkybUloRW5PTXJNSTYrWFlIcGRm?=
 =?utf-8?B?U0NzS2JkaDdubWU3NFBZL28yN1huUGJhVFI2THhObG5PNVJPa0M3WjFyMWVx?=
 =?utf-8?B?MndSR1N0c1Z5SmRsU0ttZHpwOXF1VnI5VHlSWE9DK0pueUEyc0UxTjBHZm1N?=
 =?utf-8?B?dVJ4OXM3Uzc2MmxMdjZ4ZGN6SUZnZG56aFFoblpHcFRBZ2p6eVJ5NjR1S3hV?=
 =?utf-8?B?ZTlsSjd4MTE0Qm15dm9jSjY3TDdRblE0QTlPdVNOMlpmVGdaa1JnQW5xYlUw?=
 =?utf-8?B?bm9Fa2xLT0xzcERNcHF5NkxNYTU5ZW80dWlKa1hQWHdja093OUpWVmo3dWl6?=
 =?utf-8?B?UTM3ZWpVRnloZXZ3TmR0Sy9RY29SSkNpQzNKeXplWjRXa2U2TldKUGczeXBM?=
 =?utf-8?B?SEM0OEM0YjU0VVdUVG4vRmcydHJaWFl3b2l0Slk5OTJtams2N0FDRHdDaGMy?=
 =?utf-8?B?cXJKUUR5ZUlMUE01VHZvQW1MVnJSNHZtRzYydTZwR1ROcTJzRlpoaDZ6VEkx?=
 =?utf-8?B?bnFkWDVyaTl1UVdCRVczekJzS1Q3QndxdERMZmFVUWhWY0cyWm1mL21KODMr?=
 =?utf-8?B?dk5KYXRGMWtoQ3NTaE5oTUVWMW4zSFJlZHJsOUNZZUFCWlVxOEhmYmdoL2tZ?=
 =?utf-8?B?MGM1K1RJd3FxQ3VONkIrelFkMXlLQ0t0eFhldDlHZEN5UTNVYm44RDJhR1pX?=
 =?utf-8?Q?Z/2bE1B834nNkJOEXdAauMM=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0be09ddc-d616-40c2-52a4-08db92b18a60
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 17:05:43.4110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mS3dxvU6kNGryRYWTfLcAtqkOcryFE5uQUOzbWo0tBAqTW4l53/50sH3mW/m4KnX7p6keuHfXMyV/3PBQVnPPbsKrF2cgx49n/7eJK8K5qY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8383
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jakub Kicinski <kuba@kernel.org>
Date: Tue, 1 Aug 2023 09:53:21 -0700

> On Tue, 1 Aug 2023 15:46:22 +0200 Alexander Lobakin wrote:
>>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>>> the same patch/commit), kindly add following tags
>>> | Reported-by: kernel test robot <lkp@intel.com>
>>> | Closes: https://lore.kernel.org/oe-kbuild-all/202307292029.cFz0s8Hh-lkp@intel.com/  
>>
>> Jakub, could you take a look, is this warning reasonable?
> 
> Doesn't look legit to me. I can't repro it on x86 and:
> 
> $ head .config
> #
> # Automatically generated file; DO NOT EDIT.
> # Linux/loongarch 6.5.0-rc3 Kernel Configuration
> #
> CONFIG_CC_VERSION_TEXT="loongarch64-linux-gcc (GCC) 12.3.0"
> 
> Adding loongarch to CC, it must be arch specific ?

Took a look, sounds like something's wrong inside this_cpu_read() on
this architecture (probably with some not-widely-used options enabled),
dunno. Will wait for the architecture folks, there's nothing to fix in
your patch (fully legit and ordinary lockdep expression).

Thanks,
Olek

