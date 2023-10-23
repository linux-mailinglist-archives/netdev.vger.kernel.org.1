Return-Path: <netdev+bounces-43635-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB4E7D40D7
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 22:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 019B628136B
	for <lists+netdev@lfdr.de>; Mon, 23 Oct 2023 20:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A30422F18;
	Mon, 23 Oct 2023 20:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XD35/nHn"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E3B1BDCF
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 20:24:26 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD8F4B3
	for <netdev@vger.kernel.org>; Mon, 23 Oct 2023 13:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698092664; x=1729628664;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=T07q9nP4cGoKegEFpJ31loNhkRzVwKgqwxIZqJdV864=;
  b=XD35/nHnz6ftUF4En386OWf+lBCVyPddn9+Nscy+XLZp+DrzsrJnyYet
   ys8z5HQ+l1HuF3xCly6ad7bBPKaIR5pI3Buw3Vdncvj6+erfC+kyoGn1d
   wnWLCDeLrlmOn0uL98axyGx73e7dSQS8XsExv8B+zLzT5zQ04UyRk/O9W
   1bHBrlwda6ALz20BiDKJ+sK5aaiXF9Q/CSkvBUUTwqyIVCiS7X+a4mQ0A
   UFWdjAwmCozzav417OEY1LMbvLQyaCKbrkk/NzzHTHserWHPkP+hfwEJH
   LKb6G5z/qSB0yAgE4mGDztChW9K409CyScx7XGvAGMaWN+YdMyEJ9LuYc
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="371989837"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="371989837"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 13:24:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="708040964"
X-IronPort-AV: E=Sophos;i="6.03,246,1694761200"; 
   d="scan'208";a="708040964"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Oct 2023 13:24:02 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 23 Oct 2023 13:24:01 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 23 Oct 2023 13:24:01 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 23 Oct 2023 13:24:01 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 23 Oct 2023 13:24:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JLlMxy2BV1RBaltuHtx7I/ccMXc7AfBIy6NRMR3eHKIBX+Yzi8J2FEUA53ynt1iSwIB8AyGvW9aTv1vcvL7+4NTG/UDTBSVQ156PkSojo/3w1Al3zOoBYCHKWepJzTGzd0zfHPYGmlae8O21pYrCZb4oXqgBWipxHE0PgZgJXolmwkjpySmrLLkNmGRI8ykRbkDseApCy4DYzbhocvs0/Mgfkn3TEAdU02SjfjNss83l/LY/ranvXqH2u15Pr5Ddo0PkuA8apSYs8Qhm9tvE/R6/zz3/al72F9Tx6G+XqkMHGhOd8g9EAywLUCx19nkXMumxYtDmGdeXKcYIWRqH4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F8W0+NKmKAeGY6dfD9m4PzxJX2sEmZjRY2p6Cc2Nomo=;
 b=QuR04L1LPVGBTESQklPvlhnGlewYYobepzJK7EeL8579ZGXmjo85CaFmz9VCwpyZF5/BBOUCqkQR29DWgK7O5/4xGwFUlSLf8P47kCdIyjgAF4HOutYNQucu+NactLei862bJcTwYWt9TQUgsG3lYcB4j12X2RsJIwrCp4jY9LUQROxuXRWb6slSuiH2ipLRMdGjvV3Y1AMDUjc4ubeDoE8K/vqme/z/TB6pw/mo+S+SU/s/RbuRbh1PTPxWE3vivFqGbYhL1QnC22DyBQ4xcGGyG7Qo5/RcVVsrD2xnDtaY99/Stw2oea4XUqTXjGuPkr+M6+E2ysiAcUvbEuQjdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by BL1PR11MB5381.namprd11.prod.outlook.com (2603:10b6:208:308::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.29; Mon, 23 Oct
 2023 20:23:58 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::f216:6b2b:3af0:35c1]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::f216:6b2b:3af0:35c1%4]) with mapi id 15.20.6907.032; Mon, 23 Oct 2023
 20:23:57 +0000
Message-ID: <e59c4744-65b7-4dbe-ab63-1eac550a498e@intel.com>
Date: Mon, 23 Oct 2023 13:23:55 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [patch net-next v3 00/10] devlink: finish conversion to generated
 split_ops
To: Jiri Pirko <jiri@resnulli.us>, <netdev@vger.kernel.org>
CC: <kuba@kernel.org>, <pabeni@redhat.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <johannes@sipsolutions.net>
References: <20231021112711.660606-1-jiri@resnulli.us>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20231021112711.660606-1-jiri@resnulli.us>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0176.namprd03.prod.outlook.com
 (2603:10b6:303:8d::31) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|BL1PR11MB5381:EE_
X-MS-Office365-Filtering-Correlation-Id: 0da421d0-3a27-4a29-bcd4-08dbd405fc33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 52BQuOrYUiywqXOKc0ImFaYlaQyyXO5gEM3boHRhDNi4ERPEQfaQRR2zaqpKdicMiTb3CPF2sJym/oF1k4/nmlc9YKcK1n3GOpA92U9Nh1rs+q8HtPnQCZgsCOniAisktXUMU9lO5XQvcGSpMuT578bEIWF0G876fPrY1S0ZOzDHut28nMXbAJOz6cm1yxDZTS4zNTfbiMPntPLvCyevb8aWF7rSFVY1NH8Ugld9CmqSWrPS4mGM4+gj1IhRiKBo2w8PwpygbjY8JL8FJrl5gqA33gJkRXq1/2beEfn7i4qzgWtVm173eMj/lcRaxah6RFJR8TqQLqcVeUO9cJ2mmHfJ8aN+NcPEav21x4JXZCmAR6iMrYFEc6e3IfSwKjBvA1ZgT0rM0oP2WP6yAtaoTolxMWCzOYDdGJ83iBISDpKh/EMNGx2/2fKmVSu0wNi1ZvsUl5Xdaorr6zwtfC6qbDXU43KDRWeHfGAV9PbeahMBVsH4Cdg/3GADp9A/KQW+G6sHx25KTplGoVVK2nJceuBKGyo9JUfyrq/Vbe7GhlLYATg78V13PdUf096XDTi/4pipeVtJEv8q1a/JgW1wpspbiWrPYeMVWx1KDtp8OCkJN+8ppq6qqm7axXIf5wdpImNoujb/KKzXXTgmicUuww==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(396003)(376002)(346002)(136003)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(2906002)(38100700002)(316002)(2616005)(66946007)(66476007)(82960400001)(66556008)(6506007)(478600001)(6486002)(53546011)(6512007)(83380400001)(36756003)(4326008)(41300700001)(86362001)(31696002)(5660300002)(8936002)(8676002)(26005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d1I5MmE1QjBucDErVk95VFFPWXFBYlA5U1NLazNrLy9KK0d4MHZYYzhZYVBN?=
 =?utf-8?B?T3BzNUNJelZZckMxZVJubms5MEhLWisvbmp5MVNFaXlWOFNtSUcxT2ZaK3Rj?=
 =?utf-8?B?N1lob2d1L295d2preXhDRHVNYkxPTnpBNnFZTjNVU1RJTFRzKy9RRUdPN1My?=
 =?utf-8?B?bERyOE0zL2lzWU1oRUNCYXBYdktoNkdrMWtPbVRwNGgwK1cyeFZBUktob1RP?=
 =?utf-8?B?MVJ5enJFMEZaQUhGK3NWMFVtWERnZnNrcXBuWmZySGRwbmxwNXFPQWRPaDR1?=
 =?utf-8?B?YmczRnVmZTVQWUY4MUV6L2RJTVhINE1qNlVQYWVDaytYQUZGRHdKSHlyUktG?=
 =?utf-8?B?TWZsc2J2cWhaNkFqMWhqOCtrRTRpTGY4MWVraklOK0M0QnFoa2M1NGF3Um15?=
 =?utf-8?B?WUJPVkRwSHcrQk04REMrYlg4dVVuNUFwbmYvOGplZTQxNlZ0ZjF1Ukk0OVB5?=
 =?utf-8?B?K1ByWVpETUJmWUVrUCtOZm9mazVtSDhuRng2QUFyYjMwcm4zYnJZaHBUaHN0?=
 =?utf-8?B?YzgyV01YYXJSRWhkQ2REdnVKTnkwUjBzTDJqRjd0NStTNy8rME9tekVlVXg5?=
 =?utf-8?B?UjRiRDFOcHcvRTJnSkpZUFEyclFML0lGZzNrS0FwTFBEejhwZHYvTndXN2dt?=
 =?utf-8?B?Mi9lVzNyOFlkZUZVQWlTaGJMK3lLRUM2V3hzUGtPcG56ZUE3L2RVVnh5L29m?=
 =?utf-8?B?TzRRNC8vQ3ZJd3g0b0dMd3dNQyt4cnB5QVBYRWZEUERWSVJ5NjU5Q1V5ak44?=
 =?utf-8?B?WVk4bW53T1NIbFdNK1dwVlhzMDhSN3VyRjQ4SUs2aTc4LzRjcmtWVEd1cVo1?=
 =?utf-8?B?Z3dITnk2cFJUdHpCZFhYdUlRWjhFWHprMTBkSzZzc2RjY1l3Uk91aGpldEVU?=
 =?utf-8?B?SDV1ZDRpTEYzZDFJTUFObFUxUWgxNlhFWnBPOU9qUkxGbFJhWWlkZEowT1Zp?=
 =?utf-8?B?NUd0dnZyay9GWGRIc1o2empIWFBYbzIvK0trczZCT2EySHhSaFVOSU5IK3JG?=
 =?utf-8?B?T1U3L1FQUU9WS0pCaDhycy9zVWJpYUJXNkt1dythclpzZEo3MXJjdmdRSVlp?=
 =?utf-8?B?aXRtY2Y2OFI0eXVsaVo3NjdpTkVTOUl6N0d3NVh3ZUFKbzVnd3JuUjVJdHh5?=
 =?utf-8?B?WXYvNWhydC9zYzllM2JuOEFNN20xTXZCR1lNWjFHUGFrc2loeUJUakxibGZN?=
 =?utf-8?B?YzdTNVlQMDUxaTZXSUtmemh6V3JzU3AxeDUzdUpMS21HSGNtU1lzMFFScXlP?=
 =?utf-8?B?d1hGYmZNWXdPeWg3akFPQm9RWnJSdWtnWFgzbjJ2Tzl6aG1WTjdZTzgxWnRC?=
 =?utf-8?B?Wnphd3NlMlNNVlRvTWpEQzdOUmlQMWk3TTQ4NDVMN3EzbVlYTUxCYWFObG9q?=
 =?utf-8?B?STZ2eVpKL2lNaUM5MWVZQjh4eHFXcDZWeXhOUjVhR0toOTJFVHI4b0J4dDB3?=
 =?utf-8?B?WmVTbHpSdjNIUTlHZ2VIcWlZL1d6V0FwcnYwZHVrL25ManM1UTMwY3N3WGtp?=
 =?utf-8?B?MFFSMnY1V2hkSVBieVY3NHBBeUh4cEV5RnQvOWtaMG5SS2NqTDhjbFFlZG55?=
 =?utf-8?B?eVRjQVJwdmRoRVJWTWw0d0ZUVmFxbDVOanpKYmRqa1RqK09yN3dpblJmQkRO?=
 =?utf-8?B?UVd2WGdpWFV5TXhSSXowd0NZeGpjMjk1Wk1Ta1FUOGd5a2J1NUJqNUpzcXlB?=
 =?utf-8?B?cVV0b3FxMW9aQjg1Nzk4K3VSblpWZjl4ZGYySGUzRFd2L2xrSGpUSGJPRjgx?=
 =?utf-8?B?MVJjV0dhZkFEc29udnNCYVkwUDhrM2VjazVkRUVubTdGSjgvMVFPRWdUS1F4?=
 =?utf-8?B?cnlKclhsVlhieXcyZTlLRU92UTk2MXlOcm5XVXdhRWlWZVZKdWprQngyTkVK?=
 =?utf-8?B?ZlJhbnNXdmZaQ3R5VE9VRWlieVdtWFVUcVpYK2g4cE9HUERieGt2VG01Ty9F?=
 =?utf-8?B?eG8xRWNOTTR5aExueWhUeXBFVXN2aFVuOFJHQW1Mb292dGZuaG02RFZuMDNk?=
 =?utf-8?B?bXVtOEMzZS9nNndhamxDeWlhK2hLMEZaaUYwaGxEakxldXFFdmJxTktiSUhu?=
 =?utf-8?B?THM3YlpEQzhPQmFQNzRMaEFEbFNhYkdhaGVqUWhCbXlLWGFzL0ZNYWphZ2d5?=
 =?utf-8?B?clh4L0hBMU9kR0d0UGkrWGlNdWtGMUZIK2QyNjlYSVM5T0hsSzBTYTdRcWJl?=
 =?utf-8?B?T2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0da421d0-3a27-4a29-bcd4-08dbd405fc33
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2023 20:23:57.8880
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Lgk08IOJY+7kxboGmeeDOsC7zwZvQ5kLvhtVkx+UlI57Zhjh534BRpqrs2C6oUmu8SQr1suf7/cItseAC0Sbe1p/WCUCs7o8kF0vLRqxv6I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5381
X-OriginatorOrg: intel.com



On 10/21/2023 4:27 AM, Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> This patchset converts the remaining genetlink commands to generated
> split_ops and removes the existing small_ops arrays entirely
> alongside with shared netlink attribute policy.
> 
> Patches #1-#6 are just small preparations and small fixes on multiple
>               places. Note that couple of patches contain the "Fixes"
>               tag but no need to put them into -net tree.
> Patch #7 is a simple rename preparation
> Patch #8 is the main one in this set and adds actual definitions of cmds
>          in to yaml file.
> Patches #9-#10 finalize the change removing bits that are no longer in
>                use.
> 
> ---

Everything in this version looks good to me.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

> v2->v3:
> - just small fix and rebase in patch #2
> v1->v2:
> - see individual patches for changelog
> - patch #3 is new
> - patch "netlink: specs: devlink: fix reply command values" was removed
>   from the set and sent separately to -net
> 
> Jiri Pirko (10):
>   genetlink: don't merge dumpit split op for different cmds into single
>     iter
>   tools: ynl-gen: introduce support for bitfield32 attribute type
>   tools: ynl-gen: render rsp_parse() helpers if cmd has only dump op
>   netlink: specs: devlink: remove reload-action from devlink-get cmd
>     reply
>   netlink: specs: devlink: make dont-validate single line
>   devlink: make devlink_flash_overwrite enum named one
>   devlink: rename netlink callback to be aligned with the generated ones
>   netlink: specs: devlink: add the remaining command to generate
>     complete split_ops
>   devlink: remove duplicated netlink callback prototypes
>   devlink: remove netlink small_ops
> 
>  Documentation/netlink/genetlink-legacy.yaml   |    2 +-
>  Documentation/netlink/specs/devlink.yaml      | 1604 +++++-
>  .../netlink/genetlink-legacy.rst              |    2 +-
>  include/uapi/linux/devlink.h                  |    2 +-
>  net/devlink/dev.c                             |   10 +-
>  net/devlink/devl_internal.h                   |   64 -
>  net/devlink/dpipe.c                           |   14 +-
>  net/devlink/health.c                          |   24 +-
>  net/devlink/linecard.c                        |    3 +-
>  net/devlink/netlink.c                         |  328 +-
>  net/devlink/netlink_gen.c                     |  757 ++-
>  net/devlink/netlink_gen.h                     |   64 +-
>  net/devlink/param.c                           |   14 +-
>  net/devlink/port.c                            |   11 +-
>  net/devlink/rate.c                            |    6 +-
>  net/devlink/region.c                          |    8 +-
>  net/devlink/resource.c                        |    4 +-
>  net/devlink/sb.c                              |   17 +-
>  net/devlink/trap.c                            |    9 +-
>  net/netlink/genetlink.c                       |    3 +-
>  tools/net/ynl/generated/devlink-user.c        | 5075 +++++++++++++++--
>  tools/net/ynl/generated/devlink-user.h        | 4213 ++++++++++++--
>  tools/net/ynl/lib/ynl.c                       |    6 +
>  tools/net/ynl/lib/ynl.h                       |    1 +
>  tools/net/ynl/lib/ynl.py                      |   13 +-
>  tools/net/ynl/ynl-gen-c.py                    |   50 +-
>  26 files changed, 10644 insertions(+), 1660 deletions(-)
> 

