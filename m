Return-Path: <netdev+bounces-30112-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C23637860B9
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 21:36:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3FCC1C20AA6
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 19:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D9EB1FB2F;
	Wed, 23 Aug 2023 19:36:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598D7156E6
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 19:36:54 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5595CE5F;
	Wed, 23 Aug 2023 12:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692819413; x=1724355413;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=vmQi7bQqkufb/LlmDKtwYxN8q2fjSkuVU9eOpFsEyTo=;
  b=gG5qNiwtbX6O+KaS0Euf42fMwSgPqjLQlrqcg/MpEfZBmYfI4kDf4QgR
   cTN4X63jOMLygcgJ08/DZ/1UhC34ct2bLoS8WD/DwP1cft1FhLzUfx5gs
   NCN1Dcot41jPa7s51AcWof1ajAs/9OWS6PWusQXN/Npvf2YZecU74Wnrp
   Ee5voO+9XYNE8/S4NYaAQUftQA3w6uW4bOlrw86kDMRH22kNlnjawVM7K
   gO8YofZOxNiq1wXdy+vHK6EKfVOJPrTSvdjkRAf2V1jOf4K20FZXJuaSv
   oCmLGbiQM7/OKUhAwo/iWzXlnmZc+YbFsWGvCskpeq6tKEN9rJeZ8iAXG
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="405257246"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="405257246"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 12:36:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="851165202"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="851165202"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP; 23 Aug 2023 12:36:52 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 23 Aug 2023 12:36:52 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 23 Aug 2023 12:36:52 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.42) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 23 Aug 2023 12:36:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TecKdNejdTzertziWq48QwKqT+Ptn8BvV/KHEAxEMBnklibLIEriRR9uugi8vZmr7qTEiR6B+vYplpRhSQSW2RCHCsBEvfkirIDqe2sw4VaDtAa+S0/16WX9BITgLZhrvxwHaPWT0Lf/Fm70dksrnxlo2Fi/iAV7C0nFM9PrfrTjYrvAUsXDSiw369fLaymFC+r5547eCVTRvg6yAIBiTOAnX7w4wqKeF7RkePeqp6LgPN1HSODLbx0QSx28ER14kcgc0vpdT2O64dXjK0tHRZB8q9jBbPRqIk9nrCIApG4KIo8iqlNWUQ16yI7tS387o84WdXDGzwp11V7newl7Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IhwOnldcMOQzGLyLE2GPohKg+t/3WqSnJIE+q8DJcwY=;
 b=jgLegJljpqJA1R5bngqGb1d4zVidKmwmhjupBBxF42x5FApEoQy16h4JSAhUIUcio0DopXEuzzvxa6mX9Q0BNE6gQvZ/hrCO4ju7JJ3z+/THM1tObCLPZfsNpx1DZapdfq8H1P9f8OuVSppPhduVMjRTyMA5X/ozueEIfU5Q+SUreCUa+2XUBrenSFkI8fj2KrwTDgM5+lH0hwo7qiOtmx9xSJpNkmmXgr9tmWT2jWC9mfEmy5VyPc/FenKMwmeGM9zs9hu5mDNSb0ywCnocUsX4+EidYxYWzOvREy/X/cTN6J3ci87jgDSEr9oI4+cloidhKFnvVPItQCr0UY2JCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by IA1PR11MB7173.namprd11.prod.outlook.com (2603:10b6:208:41b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26; Wed, 23 Aug
 2023 19:36:49 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::6a23:786d:65f7:ef0b]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::6a23:786d:65f7:ef0b%6]) with mapi id 15.20.6699.022; Wed, 23 Aug 2023
 19:36:49 +0000
Message-ID: <201f1e3b-5636-5dd4-0819-3244b82c737e@intel.com>
Date: Wed, 23 Aug 2023 12:36:47 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH net-next v4 06/12] tools/net/ynl: Fix extack parsing with
 fixed header genlmsg
Content-Language: en-US
To: Donald Hunter <donald.hunter@gmail.com>, <netdev@vger.kernel.org>, "Jakub
 Kicinski" <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "Jonathan
 Corbet" <corbet@lwn.net>, <linux-doc@vger.kernel.org>, Stanislav Fomichev
	<sdf@google.com>, Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
CC: <donald.hunter@redhat.com>
References: <20230823114202.5862-1-donald.hunter@gmail.com>
 <20230823114202.5862-7-donald.hunter@gmail.com>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20230823114202.5862-7-donald.hunter@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR02CA0014.namprd02.prod.outlook.com
 (2603:10b6:303:16d::29) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|IA1PR11MB7173:EE_
X-MS-Office365-Filtering-Correlation-Id: f21952e5-2c94-421b-16a3-08dba4104b64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8gZxB6F8VRJmElRAt3Xx7ty5cQq1gBsGIq+/SLiqhCHAPFPvbl8rZdtoenRvFNMNZkMUxvLPRDxqo8bd1mbNuBGny8/24Nbixb4fyZ7tYgDd3fCVYhuvXkN16oWP0z+iHeaR0rL6uWcG9DNGUNJimq5GVTJ2a3WFmNpvXvSz9Af+U99FQnqOGvBGrP0Q3jEDon0bUSwSAl0IbaNfJDH7OKRA9pXA3dPeA9WJt1WmWEHCE5i5RMRzKwylseN0l02aK1PQQH782GnBA7WB+7+T7lq7lipck1SdAex5N8vpv2B2DT3kd9daLsWZ4aTFRuhuTUf/bIq/kHrpNuGVUCxwHz2OGy2Da8o2CgdLSe7/f2BD7+FwtE/VgTWVxtyXxwRi6nBYRcQawHXZ9zXEVZ8gUVkmwSYOH6jRf2P1B4ZDKXOVmF6yyC7+YgCsNfqunnnKVzocjXrU2DGxM7kCMO5OdAOLKuTJ8pN4UK1rc9FVfzS4sPEurNpwOx2BfUrKu/G6qh3UE0KTcxcMt4HfRHn3helOqnvHTIkA+YtvOH5L0B0AqOsNLDfpwUdFFAaBeqvE1WomsqAH2GbwuzXagG8+rX+r+mnR2iNmWr3uSA2dpMm5fqmtsQ2ZU4k9ZWm6VT3sxVT/iBQDgPj4rduQ7BD+O/pN1zCKClWSBX1A8HGj6ng=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(366004)(136003)(39860400002)(186009)(451199024)(1800799009)(2616005)(6506007)(6486002)(316002)(6636002)(53546011)(8936002)(8676002)(4326008)(110136005)(66556008)(66946007)(66476007)(6512007)(41300700001)(26005)(7416002)(5660300002)(478600001)(31686004)(36756003)(31696002)(558084003)(86362001)(82960400001)(2906002)(921005)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aHhycEx6aXpadG9jTGhJMWYrbDVoSnRmVkdpVURtOUJoMGRkb0p6MjcxU3k2?=
 =?utf-8?B?N1VNTnorZlNLbFhnVzlhb1VQY05LcjlBMkVRbmlrZ0Z6VUFZTlk4aHlRTmZO?=
 =?utf-8?B?Y1FtYWVFaUtqS1pCY2xRTEtmYlNwaDFoNzJVTkpyVnZ2TzhUWG5TRHA5WERR?=
 =?utf-8?B?SGZvTjVoWTlTdi9iNGE5dXg1QU9iQWovcmpEVWNnMHBuanFWdzdzbjZhb0FG?=
 =?utf-8?B?b2FVdkE4Wk5hMW11V3hYSEs1Y3hHMHFremZkNzlrdzhId1NzYlhSRmZTM0hh?=
 =?utf-8?B?TEV6SnJZNlQyTmtPRml2QjdVNncxM1BoWnVZbzJ4emFLRlB4dEEwc1FZRVAr?=
 =?utf-8?B?KzZ5VWVrNEFUNUtza2JnSVRka3M5OEFhK0RRSjI1MVNFa1l1Y1lkWnMzcnVJ?=
 =?utf-8?B?c0djbWlNdEdBTmVDWllySmlsNkFVTHJDdEtOMm8rMWNVL09pYTV1ZHBXQVl2?=
 =?utf-8?B?WFpxNHEyNU83YWNDYy9QUE02U3o1OWkzT2Q3YW95bUtUb2ZuR2pwbUVSd3pz?=
 =?utf-8?B?OXB6blR2UmZJZG5QZjR1ZG1FdGZFSVpjT0xSWkwrRG5PdlVJc3ZOWlNyL1RY?=
 =?utf-8?B?Q2I0MWdqYjRqSDhDNTdIeTAyN09ITHh2eGpqa25YbVk3K0xpU24vdTF0MVVX?=
 =?utf-8?B?VHBqalVpMlQyMm50Q0lXalBSaEtaaGpEYTJSaTJHWnlUOW9VSjhVcDNKUmU2?=
 =?utf-8?B?TUpabUxWY2tBSU83c0wzenB1TWdrZm53QnpTYVlUcUYreE5vZnl0aVhuV1o1?=
 =?utf-8?B?cXlTZzIrNlBET0wwOWlwdGlOK3cyc0pDeXBDUU9EQlVYL203YU4yWnVkU3pj?=
 =?utf-8?B?RW5GV1dEZUpxZWROYitlSTJDb2FYMmI0N0dPWHJWS0hzMC93S20vTFRYbW5U?=
 =?utf-8?B?ZFNTUUJScFd0OW9mQ3o4aE92SGRHZmRWTEgxQ0JrKzhLbERidVUvWlY5MzAw?=
 =?utf-8?B?ZTQzOE5kRkMxZk51YzZ3U1dTd2lRc0FtZXB3S3hwRkVtaGhzVmpDMCsvdTlh?=
 =?utf-8?B?M2ZjZTYvQU1lNVNKNE4vbnF4a0pjNW5lVldJOTdkZ2JjTHZxaDRLUzRVUGwy?=
 =?utf-8?B?dE8xR2hQeFB2VHVNYnlRT0xDSGhMRmlpaHI5L1ZjYlhydGl6NUU1cEhHWEZ1?=
 =?utf-8?B?WHh5ZmhMN1dlT1VZREpKNURtSTlVMUFxcWRYTzF5ZE1tT3NvWC9wMXBCKzIz?=
 =?utf-8?B?VGh3SHl3amhhdTNsYWhkV3o5K1E1QzZqMVF2bEFkVEVyeGVkeFh1eFRNS21V?=
 =?utf-8?B?V0tGdXhQeTEyRXdVMVArTGhtc2R6aWZqZ1FnOGIzb1NnN0RJWU1jcEpBQ1JT?=
 =?utf-8?B?NGNTOXRpc3VJUUg3b3hFS3Vtb1Yrb3pwUVNVSWF4OXVqbDBxWGQxaWU0R0RH?=
 =?utf-8?B?ZGhZcXFwNlhyOFBjNTlLdllLUHo5RUwwWS9Gcm53QUhFd1NJbkhnQjJvYzJ6?=
 =?utf-8?B?UUdkdk02emxtMXZ0V05ld1BmZXNlOEFmaHZTUndWSzdvdE0zOEkrVWhwTllp?=
 =?utf-8?B?RlVXZ0NwV1FrMFgwRCtRVlA4ekllWUZZSkpzQ1RaM0dPMFlyUno2a1VEUmpP?=
 =?utf-8?B?eTNpRTBuQWRqZEI5M1d4ZU5jZEdzbmlEeEpuQmNQZDlsbTRENXJFQWhHTkxI?=
 =?utf-8?B?cDJqS09Oam1WNURqVVJ6ZDlVL2hhMTI5T28xYmt1SUpaMXBBL0FjTUZlbE1n?=
 =?utf-8?B?TVRHdlpGUlZmRHJ3RmtEVTYzUFkzUFg3dHIzYU43MmxHYXVMWXMzS01CUDFo?=
 =?utf-8?B?Ym0wSjhKNjBiZXVqQkROby8wNTVNRktGdUZLOGRlcC9zR2tqT0Jsb1pVTmdT?=
 =?utf-8?B?ZUdOV2t0RUhQMGV5OThzOUZBOXFGMWwzMWM0Wi9ORWo0TDh6UnJDUHNmUnJt?=
 =?utf-8?B?bGJUZTVuaStLVFRLRm1CcDYvcHVRRG5DQTlVNGE2VlAvMkFZMzRWL2ZQaUY3?=
 =?utf-8?B?eHhROUNQMmdSbnJqa2pOTVNkcjBZZlh0RTgxZGEya3QvUHBZNHc4NFBHeWgx?=
 =?utf-8?B?dVdyeFkwV3g5WlU0SnptRjFIckpHaDJ0M2tUakpqc1BCUU5TSnlTbkdZVVAr?=
 =?utf-8?B?dzFlZEY0OUtETGh5SzUvNldONmIzbUczY2ZnakxyT0h1Wm1JZnRneTBZL2tU?=
 =?utf-8?B?SjIvZXdxV05pbjFhNHh6d011ZnNEby8xc2dyaW42c0s3SXdSUXh5STNBTTdx?=
 =?utf-8?B?OEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f21952e5-2c94-421b-16a3-08dba4104b64
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 19:36:49.5436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lrXjtMB+0e5+8sUeW57aqQPf6qVNziqv5ld95NpcXsbt+v0zMbRCUrhyXssqGzCizR1xP5pPagMPFLrn1KEYDDR8hw4JlDMiBGXEACAFFW4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7173
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/23/2023 4:41 AM, Donald Hunter wrote:
> Move decode_fixed_header into YnlFamily and add a _fixed_header_size
> method to allow extack decoding to skip the fixed header.
> 
> Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

