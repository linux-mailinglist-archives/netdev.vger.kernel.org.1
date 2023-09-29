Return-Path: <netdev+bounces-37123-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFB8A7B3B2B
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 22:19:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 8142028303C
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 20:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E5B6726C;
	Fri, 29 Sep 2023 20:19:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8FE66DF9
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 20:19:10 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE49A113
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 13:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696018749; x=1727554749;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+3/q08TQjh+5Wcy8t/X4Zw/cTs7pWo2rlS34h8k93sk=;
  b=eEa5ATAsUWWxm3aH3usZRyEDt1zt1DvmBCMNHHiPwGx6tA4Zkwd/Pam2
   BksbnP/rGdlmJdMrHd4Nbb02DmZgPEHQ0doLC7UeVNoZ/JWY5+RqYth/Q
   RuRRqGYn+LJbMkmYwM6AjBAiuOMnkgqufpDLL1ve/91qLRNMuXO9Wn/Y2
   w5/udjsqUAi2MBitRvgSwr5fxodtMkTstGPjD/2CJWtXSRsrsTGGJevOH
   VMBX3t2hJn8Liexh53GCiSVCXEA4RNXigJ6OiKx+1xcPiIZheMuNn2YmM
   eiuX+qMhjQ6HFF76vk/mK5a90HFXrfjyI3twVnwGXqLOPiXhSsn2kuo3E
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="372711643"
X-IronPort-AV: E=Sophos;i="6.03,188,1694761200"; 
   d="scan'208";a="372711643"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 11:27:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="1081013415"
X-IronPort-AV: E=Sophos;i="6.03,188,1694761200"; 
   d="scan'208";a="1081013415"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Sep 2023 11:27:27 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 29 Sep 2023 11:27:27 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 29 Sep 2023 11:27:26 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 29 Sep 2023 11:27:26 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 29 Sep 2023 11:27:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SRXCK9minS4W5LQMfFhUM8GpJR9sVsQr5dxHTPs8ZJvPesCS8JQ+VgVzIC3wJmZwc9GQ8z33TE5lCxUbGDDq6d58lxYdQOO7Ak4tyMgGINf7cUU5WdKcMNUoZGW8uflarU3qs15xSTp8TsPoTMMQsty2aQQMw7MvZOLJCL5uiJRdPSVlOtlVQ/JOZIaaUaac5p1GHjsBKId52U7MAiVkHQSJiGM4MDQQ0yoDpNLb6VPFrLVFU7R9cY+QffTlKCJ0kmQ7wIbzCQ1yBOvcc/KcfmG+/YgWkFI/2vlk87l6aNeiUfmxRHSckQN0dHmDolzx/4KiXaY0F7i7izvu8QEQtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LnXXJOdRHswfroo++0cBYxsmLOzS1ApMrKHAr0iSJWA=;
 b=kdyhDoG/dDCbqHJje+6vNx5hcrH79yJQjf2MWFu8CI/f2HFOjvht5OrcPYeOY//lIUYZMn5AgJSZwSfjIhfGVHJUKB13yAgKK2uVfPjLf2zibkheoKTEe64IhaHqudHa2P7aJi0Insh+zyKIuVqnsn5DAhkOl3n4cAu9VS3azMIuhRch4wwmtNvq/plkKNp8omkiWiSnM6X/wNbIesAE0r/nHyPvLTtqPRkYVnj2OmYSYIosymHOAR4SlVj46/SpEWUqGf3yzi6h0ICiSG4H7XOygX2l2ag0ZydHQC7z7NU448i9hJGUX7zRkTFllGSvhP/aUKh0yGFThgrUDV8eLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by IA0PR11MB8398.namprd11.prod.outlook.com (2603:10b6:208:487::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Fri, 29 Sep
 2023 18:27:23 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::9654:610d:227a:104f]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::9654:610d:227a:104f%5]) with mapi id 15.20.6838.024; Fri, 29 Sep 2023
 18:27:23 +0000
Message-ID: <2b5430bd-566e-c6b8-d796-80d9a675e736@intel.com>
Date: Fri, 29 Sep 2023 11:27:19 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4 net-next 6/7] net: ethtool: add a mutex protecting RSS
 contexts
Content-Language: en-US
To: <edward.cree@amd.com>, <linux-net-drivers@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>,
	<habetsm.xilinx@gmail.com>, <sudheer.mogilappagari@intel.com>,
	<jdamato@fastly.com>, <andrew@lunn.ch>, <mw@semihalf.com>,
	<linux@armlinux.org.uk>, <sgoutham@marvell.com>, <gakula@marvell.com>,
	<sbhatta@marvell.com>, <hkelam@marvell.com>, <saeedm@nvidia.com>,
	<leon@kernel.org>
References: <cover.1695838185.git.ecree.xilinx@gmail.com>
 <b5d7b8e243178d63643c8efc1f1c48b3b2468dc7.1695838185.git.ecree.xilinx@gmail.com>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <b5d7b8e243178d63643c8efc1f1c48b3b2468dc7.1695838185.git.ecree.xilinx@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P220CA0006.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::11) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|IA0PR11MB8398:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dad8801-a59e-4831-1db7-08dbc119b937
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a1dKktuXViBVjEiM61hMPCZs2BWAbiTHGanwi1MzC+GSzpKxS0FyJOWQllCL5qwxRQ1tl6AqrDJq6YDg7nJvLL7GMXjjCWpls830r39xwAMIkXoI0JJe2hyxUlUYvgACGXzPXAVMlIklSUPQXfcz3SVSDx9D+xn73mPW8etEBX64tgfNYady5QUHs5sPpC1bURm7ThFlZNl9iE9CLjP/oVMU10jJ8JEyLycikig1RskwI4lsULp+0Fm6rLMcS7Cm7An5HPi1c1vhiYjhIoKdRm8BqOe5WKWpbCyJPFFpaXKK0Bt7ct144lgzNkzxDwo6+M96AM4feuradycWi/PvQuGducbhMEKOH2mytWNPWwgAS6swaJjEpzuh97JgqUJyg7rvhB4AY+PstElhCD2CEKq/GQoyZukdS/WU1YY4eVNZEVsjV5jbBn+VaTWt/zAeocjxiDYBeyhgBvK0m1fQlkWX3+4HkgpacPfCLP7gMGF17xqM3wJLGXquxuq6dQ3XZjqcBxR496lr99B3bBbEWonpI1cAmi8o9VMxoiQwfpwQkWEDPpqkmdgoa1Lyy/tp+EdcvYfP/jnAKeZ0279n4vhqf1I+63jh0emwOoVVKUnbimkwvfILCzIHeMzxgadiiNQq097Wv2MUjNybVclfJA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(39860400002)(396003)(366004)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(31686004)(83380400001)(7416002)(6486002)(26005)(8936002)(86362001)(31696002)(5660300002)(8676002)(4326008)(36756003)(478600001)(66946007)(6666004)(38100700002)(2906002)(41300700001)(66476007)(316002)(66556008)(6506007)(82960400001)(53546011)(2616005)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MjIrSm9tZ2sxU0djWkl0clUrWklJNmdpZkJHTGtoNmNNT0FSVFlkUnFweUdj?=
 =?utf-8?B?UUxiZFlGN2dTY1NUYkxqMmIvR0tUdmNZckpWeHIyOWQ4YXFzSFVGU2YreDdl?=
 =?utf-8?B?SmlEOWVCeWp2M0VOUXpVVG9GaWFoa0I4NjA5U2lEa3MyYUtFZ0YrRTRmT0xr?=
 =?utf-8?B?UW05bnNMT0MweVN4NWFwSXo3L3NMS0Z5aFdsakg1S1JuZ3hScGVXUHIzSStm?=
 =?utf-8?B?RGt2NnQ5cEo3YWZYMzVXQ0Z2WmR5R2d1ZkNhaE5DZndGeXRoQWQ3RVpRa01m?=
 =?utf-8?B?Tkg5ekxJYVFqM0pJK3FjMGsvbnN6WHZjNGg2UktDcW52NVNRaUMwb3FaWWI4?=
 =?utf-8?B?dUhWa1NCZHZtcVVrU0ppemptdEhkbzdWcGxwVjRETUw5V2M1UldoNGVTUm9v?=
 =?utf-8?B?VEQvV3EwQmdqTTFyemF2ODRuWXRFQ0tVOXQ1Mit2TDhRZytZWUpOVUtZSFdu?=
 =?utf-8?B?S3BITXkwS05UbGw3KytiNGhrUXBDd0thVktSY0ZXbzl1bXM2dVFmNWgrOU5U?=
 =?utf-8?B?MldTN0lURmhVN1lSQWlXZmU5VXFyQ3dJWWVwVXVraGVIblUrK2JXYWwvWi9K?=
 =?utf-8?B?N2ZVUzZpYm8xM2xUVy9TUExhZ1pKMkp4Sjd1dUNoMnQzTWZ3QzBUMGI3Mmd5?=
 =?utf-8?B?SnlnanJxVEpET1NZbURiY2lVRFRPSHp1ajB4YXdiT2xwVGdYT3M3UnpXcUZ2?=
 =?utf-8?B?U2x0eFNGdFFvdENUNjVXdUpGMFRDa01GeXF2MTF4ODBBRUs1SkN5MUtmMWx3?=
 =?utf-8?B?TE1qWDlhRWtkODRzM1doeWhJdHRwL25GQit3cGFMSExqQkVmYzJSL3lkUVp1?=
 =?utf-8?B?Z2FMcWhzeFpRSnFVaXIyZ0g2bExRZC94Y0xRRkhZMm1jNldGRnhsbC91WnJO?=
 =?utf-8?B?V0dEVy9wZm8yTy9pYmhBTFFJRmczV1d2NmpzZVd4K0VXa0l1b1FtSms1aXVF?=
 =?utf-8?B?WHJDalF1Q1F3LzNKZEtWTVlOOWlYUy9YKzZtbWlveFFCM24rK1VQMC9jMHNP?=
 =?utf-8?B?c2RGL2w1SnZ5azBRMmUva0crOXlOb3poRGpWZUdJM2gyVUVkTmpqbXpKT2pz?=
 =?utf-8?B?ZDBWb1dFdi9hc0JoUWRQQkxXQTViOW5YaFZLbE5IZzZ5RlhnbXR5SmU3TnpW?=
 =?utf-8?B?QkZ3WTN2ckxOY3ZCdzYyek9wSTJCTUROYzNBdmZPWkkxMXo1Ykl3WDdmYUd1?=
 =?utf-8?B?N2liK3FhNW53UVUyblRjTkhpdUdaRXpocTdnTXRZNVVaZnF0ZUhmTE8vcHdQ?=
 =?utf-8?B?NlBYc3c1YXBwWEtBL3Z0aVNTM3kwNVZWWUFSeG1Nb2VQKzJhOHltUlROV0tt?=
 =?utf-8?B?WnNlZFBzMHZaMVBvZWdPcE1YQ1paZ3J2T1JheVRyRC82cFRiNUgvSFBJNXJR?=
 =?utf-8?B?dG1WK3hnSE1ESUsvMGVPWnlUc2xpSVZ3SWduNTc2UkZWTlM2RmZPeksyTzNy?=
 =?utf-8?B?WWcrcjY4eDc5blBEekZJa0hXaU1RSnJDN3Z5UmU2ODlMNDZhMzczYzNnTzJq?=
 =?utf-8?B?SDhHaW1lU0RUVUJZYXV0UFoxbzNvMHZka2JTS1BKaUJuWjhZS0x6STlRUk9s?=
 =?utf-8?B?SWZOdlZhbmgzclRZa1lXeE41cTRmOUdBVXZCbUc0bFVjTVZwdUZFdVpyeXBy?=
 =?utf-8?B?WFExWXRtSzRJUWZsZ21JUFF0UXJoeUNZbnhiQ3lCUnlzelBKWmFycmk2QlFu?=
 =?utf-8?B?WjZMWFNCN09Jc3FOd1cyRG1tSmUwMVBXeFB2SVl4S2ExMTdtbG5BUnJ3NEZD?=
 =?utf-8?B?d2FhRklFUm80eHNXU0N5YVRFaWtlWlk5MlBNNU96R0JsRS9YQ3o5UGRPMllL?=
 =?utf-8?B?VmpXNmczbjQ3aFVPYUJiV0RPUXEvOTBNSzIwdUJBQ1BXZXlLS3Z5akZ4MzRC?=
 =?utf-8?B?OFFGNW8yQTJmSWliWFNxeUVGMWE3bmdZK0xEVHg1Uk1lNnovcCtHWDRUeHFK?=
 =?utf-8?B?V3RMWThjMVJKeU9NR2JnT3lyblhyVm9ncDhTUWY4U0RNeUxwQ1VBeURkUi9M?=
 =?utf-8?B?aGtxYVVQS1RGY0UyV29HWHNoUUNuNEo1Uk1jY2dGUnh6d0hHU3JQbjdORzZW?=
 =?utf-8?B?WWRoUm5PK280aUZjTVhpUXZkdFZkVjN5SmJVamh4ZkRBaWRpMWRSd3EvNWdJ?=
 =?utf-8?B?bDhHTjlkSFR6YXNCeWYwdDFHMmFxYXJJUXJYY2JtZkJ4alpVcGZJVmlvb2Nw?=
 =?utf-8?B?YlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dad8801-a59e-4831-1db7-08dbc119b937
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 18:27:23.0778
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hAelFo+oLTedOqSLbRFVJcUfq5CYJgu4rBs0+PbMD1smtMc/wF0q235yHqk/qnIwsqrci0CTs4vnb+dmcbE/1XPUNXswx/n1QwON4rPgBZw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8398
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 9/27/2023 11:13 AM, edward.cree@amd.com wrote:
> From: Edward Cree <ecree.xilinx@gmail.com>
> 
> While this is not needed to serialise the ethtool entry points (which
>  are all under RTNL), drivers may have cause to asynchronously access
>  dev->ethtool->rss_ctx; taking dev->ethtool->rss_lock allows them to
>  do this safely without needing to take the RTNL.
> 
> Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

> ---
>  include/linux/ethtool.h | 3 +++
>  net/core/dev.c          | 5 +++++
>  net/ethtool/ioctl.c     | 7 +++++++
>  3 files changed, 15 insertions(+)
> 
> diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
> index c8963bde9289..d15a21bd6f12 100644
> --- a/include/linux/ethtool.h
> +++ b/include/linux/ethtool.h
> @@ -1026,11 +1026,14 @@ int ethtool_virtdev_set_link_ksettings(struct net_device *dev,
>  /**
>   * struct ethtool_netdev_state - per-netdevice state for ethtool features
>   * @rss_ctx:		XArray of custom RSS contexts
> + * @rss_lock:		Protects entries in @rss_ctx.  May be taken from
> + *			within RTNL.
>   * @rss_ctx_max_id:	maximum (exclusive) supported RSS context ID
>   * @wol_enabled:	Wake-on-LAN is enabled
>   */
>  struct ethtool_netdev_state {
>  	struct xarray		rss_ctx;
> +	struct mutex		rss_lock;
>  	u32			rss_ctx_max_id;
>  	u32			wol_enabled:1;
>  };
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 69579d9cd7ba..c57456ed4be8 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -10074,6 +10074,7 @@ int register_netdevice(struct net_device *dev)
>  
>  	/* rss ctx ID 0 is reserved for the default context, start from 1 */
>  	xa_init_flags(&dev->ethtool->rss_ctx, XA_FLAGS_ALLOC1);
> +	mutex_init(&dev->ethtool->rss_lock);
>  
>  	spin_lock_init(&dev->addr_list_lock);
>  	netdev_set_addr_lockdep_class(dev);
> @@ -10882,6 +10883,7 @@ static void netdev_rss_contexts_free(struct net_device *dev)
>  	struct ethtool_rxfh_context *ctx;
>  	unsigned long context;
>  
> +	mutex_lock(&dev->ethtool->rss_lock);
>  	if (dev->ethtool_ops->create_rxfh_context ||
>  	    dev->ethtool_ops->set_rxfh_context)
>  		xa_for_each(&dev->ethtool->rss_ctx, context, ctx) {
> @@ -10903,6 +10905,7 @@ static void netdev_rss_contexts_free(struct net_device *dev)
>  			kfree(ctx);
>  		}
>  	xa_destroy(&dev->ethtool->rss_ctx);
> +	mutex_unlock(&dev->ethtool->rss_lock);
>  }
>  
>  /**
> @@ -11016,6 +11019,8 @@ void unregister_netdevice_many_notify(struct list_head *head,
>  		if (dev->netdev_ops->ndo_uninit)
>  			dev->netdev_ops->ndo_uninit(dev);
>  
> +		mutex_destroy(&dev->ethtool->rss_lock);
> +
>  		if (skb)
>  			rtmsg_ifinfo_send(skb, dev, GFP_KERNEL, portid, nlh);
>  
> diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
> index 3920ddee3ee2..d21bbc92e6fc 100644
> --- a/net/ethtool/ioctl.c
> +++ b/net/ethtool/ioctl.c
> @@ -1258,6 +1258,7 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
>  	u8 *rss_config;
>  	u32 rss_cfg_offset = offsetof(struct ethtool_rxfh, rss_config[0]);
>  	bool create = false, delete = false;
> +	bool locked = false; /* dev->ethtool->rss_lock taken */
>  
>  	if (!ops->get_rxnfc || !ops->set_rxfh)
>  		return -EOPNOTSUPP;
> @@ -1335,6 +1336,10 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
>  		}
>  	}
>  
> +	if (rxfh.rss_context) {
> +		mutex_lock(&dev->ethtool->rss_lock);
> +		locked = true;
> +	}
>  	if (create) {
>  		if (delete) {
>  			ret = -EINVAL;
> @@ -1455,6 +1460,8 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
>  	}
>  
>  out:
> +	if (locked)
> +		mutex_unlock(&dev->ethtool->rss_lock);
>  	kfree(rss_config);
>  	return ret;
>  }
> 

