Return-Path: <netdev+bounces-21620-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F69C7640DE
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 23:02:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D3EE1C2139C
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 21:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 474661BEF8;
	Wed, 26 Jul 2023 21:02:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385FC1BEE1
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 21:02:01 +0000 (UTC)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 128021FFA
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 14:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690405319; x=1721941319;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Rxfo+u0liHbgyP2+hgthqTXy8AVnQlNOmJ42aLZ+fRk=;
  b=P0zb55sJHfP8Wdjio4oSjJp8KtLRg2mF1nc8EvbHy7HrAcDO6iTTYlOz
   9AjPGY3PM/mrHtNVbVnYppYljZzEMrUOk0/pLJxHs6m24pyQPj3XaiC7K
   pAexXO3IKhOs2qw3T2sAA+FfzDztr5xnRhDyG1Bv0UZY3AL15KIWJ20A6
   dBwGpiFXhhJwRN00UTkLNkiKLyxQQrs15Ke77syUoF+1+ZKTEKR3etV1p
   BoQiAccbxC9se2NGrbnb8gABPrOYDkZhLMcZx5U6BFce/vxRdb0DX7G9E
   SA4t2b3IoJJAHkG2ip4IWicaG6mItae9OUVbW8DfMErnU26Y2WiP1X2DT
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="365590792"
X-IronPort-AV: E=Sophos;i="6.01,233,1684825200"; 
   d="scan'208";a="365590792"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 14:01:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="792044718"
X-IronPort-AV: E=Sophos;i="6.01,233,1684825200"; 
   d="scan'208";a="792044718"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga008.fm.intel.com with ESMTP; 26 Jul 2023 14:01:36 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 26 Jul 2023 14:01:35 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 26 Jul 2023 14:01:29 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 26 Jul 2023 14:01:29 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 26 Jul 2023 14:01:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YeDwd6pX6tEyetUARJNximTPTnq+ig4GxfvmdnWX9SnF2HJtfwLFMm3iQMcVbOzaIDiq+CNPAFltZdmcvYd4V8AXyxoNvaUKUj0V0bwghKX1h7cQBBACV9Q9i1NYB7q0YgWFFMerRekra2/R/y6sTNl1Xd31U2JnQnOmpugPTC7AMJdZ/aja7En86jeggf0S/dKc2KAe+lzQ3wLgsXAH+CF0Tjn2tCaQ2JJ+Oapkfxl2JB0QazMXbJSgNtl5A8vCV8ZmhElr9mE/IWgLyMnVOpvy0HwMBuu896N+SRDwuvKw1I5dR+y+ZVzjlgn7D0JQudxZ3YXqJape5ozriYZLqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9lBZ5WwaaxOxceII5L108i9hulEmCbSvFsMwWgdxKEw=;
 b=Qj5ikRYqSWHeWW3EZoiBd0uq+AOcwxbOMzcFjyxBWJrc4grwM633yCcYLHSWeNZp7av5/jINhlKn3SU31+TnfFxfhn0MJdE6vri1CcyAUrt87UYnDhFYllyeKsby1szY+nqS53xPfN5yUuoJ/vPhUyPaHpWDYmnvWJUo8TF4r5kFLyt0U+8l9LM3VcDBKenxi7fX1bLXXHSDSqod5r8DnMW+BfZCd7VmFZI2Yr1LgHlJEuuORLn7+cLk2iA3lGuaLEfuvDoVGHbKXh6gagJysvF/xR/M6hSJ2j0ftfAx7/PFJGy+ycw1Tp9Izgf6dgMMBUgShVsLgfbAJYD/+2bcVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by BL1PR11MB5269.namprd11.prod.outlook.com (2603:10b6:208:310::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28; Wed, 26 Jul
 2023 21:01:27 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::cb4c:eb85:42f6:e3ae]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::cb4c:eb85:42f6:e3ae%7]) with mapi id 15.20.6631.026; Wed, 26 Jul 2023
 21:01:27 +0000
Message-ID: <ee09ecbc-b122-391c-bbf1-936c9b105192@intel.com>
Date: Wed, 26 Jul 2023 14:01:25 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH net-next v2 00/12][pull request] ice: switchdev bridge
 offload
Content-Language: en-US
To: Vlad Buslov <vladbu@nvidia.com>, Tony Nguyen <anthony.l.nguyen@intel.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <netdev@vger.kernel.org>, <wojciech.drewek@intel.com>,
	<jiri@resnulli.us>, <ivecera@redhat.com>, <simon.horman@corigine.com>
References: <20230724161152.2177196-1-anthony.l.nguyen@intel.com>
 <87pm4fss31.fsf@nvidia.com>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <87pm4fss31.fsf@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0190.namprd04.prod.outlook.com
 (2603:10b6:303:86::15) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|BL1PR11MB5269:EE_
X-MS-Office365-Filtering-Correlation-Id: 763ba9f4-b672-43c9-11cb-08db8e1b7a12
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U7oNSt/2iRBK4Rh3NG+HTzZc4kchwosR48RIdAspxaeFY4qiVhgARxj3zpz2VyHNRj2PMmgwJLtTT0bvG559arG5GAHB5A3xogDbc3XZroKDv1/dZm042Xr3lCoNU2LwawkR6oAAwYs5lfgcZc5dlhXLyTIHFHu8mqDRYt7to5YZ4CsYlR7/UpGplhVwnaYO8qXJvxmQZEH+Yjky9VwIjIh74g45QxkTzD0S0l2xGWZ9bhvy2LG8tdNSo+HiEbHYRGqFLLGFl6hx9HM+XYaiDv48V3M8zWay8sICAPeBuhqPfZJmUtawgJVMLtXHHT2rZcVjZl+2WFSKqcwHPwXBEI7OzCLECGFCkgldVJK42AmxTRjaQOc51kigC0dcziXuNg5t+ssxDWZVfPPtvrICqg8P5XL3Ax74VVWWFESkPX73glj25aBmRzVK+tCkyGEHA9bBwlhs0OKk1i/SeC1VQuTL94dlWJUUxWd/Ef5HZrUMgH8nNwWoojV8YLdlOKR6tdZujgsjkbgzVzY/Ul3YfhUXQpvjgDd/TbsOsMJKDgbwJp9Yf7FXIezt/A2XSwLT4zYXdJ5g3RPmxLEMsO/xrov+ZtCSgWL4v37KF7O286riCgRaZ5N80/7iLOMF3MoSwl/LYxqDyhPBe4DdwwUHww==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(366004)(396003)(39860400002)(376002)(451199021)(110136005)(6636002)(4326008)(6486002)(66476007)(66556008)(478600001)(2906002)(6512007)(316002)(66946007)(31686004)(8676002)(186003)(41300700001)(83380400001)(26005)(6506007)(8936002)(53546011)(38100700002)(36756003)(2616005)(86362001)(31696002)(5660300002)(82960400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1Zmb2dhazA4TjJucXNiZjBBb1lycFMwUG1KaDAzaHNCOWxKQlVQc3lFTkIr?=
 =?utf-8?B?ZU9rZG1PQUVUSVlRUExrMU91UmFzdmNFNG16N0VnRHN1c2RhMUNUYXpXN1Rk?=
 =?utf-8?B?OGVuY2I2UXc5UjMvS1Nwbnp1b2JBQ09ubGM4bWdyMk1CNEpSeWtHS1FkZ2d3?=
 =?utf-8?B?aXREWVU0bEg3ZHY0Uyt6SWxtdlRJeC8rWEVFZDZvKytiR3QxOHBNZkNMbVRH?=
 =?utf-8?B?ZEltTkk0dWQvMGFaMWt6RXNVOXNwUlZFODBLTFJJL2NSbXg3UDdNS29xVllt?=
 =?utf-8?B?aTByUW9IWlB0SHZGV0RjNHNCMWwrN0t4K3NLUHdVeWk1TmljRmY3MkZxaHZB?=
 =?utf-8?B?L1M4ZUxkdTIxV1Vpa0kySFhzaTBQWmhvdGQrZGpiYUt5TVZwWGx2Q1M2VXNU?=
 =?utf-8?B?c29RK1NjOTVRTzNERHEyV1djbFNjYmhieWphYWU3TGZiNnNaNi9YL1dyYTJE?=
 =?utf-8?B?WWpVS0NGajBWTUU2R21GN1NycVJOa21uczdUN0F4djJwWWdianh0dW5QUUtP?=
 =?utf-8?B?SW1EaURseTdIMVdoR2JiWWZRbEpSa2x4NVRQR0dyY1h2WWVLQThjWCt5OG4w?=
 =?utf-8?B?bmtwVHVXRzFNMmthb1JtMEZORzRTZ3BSWDRaZ1BCR3VDWjBhZUJUeVRMWm04?=
 =?utf-8?B?OUlTMFAvVHo0NDhQYkxTNzBRakVzZ3lDQ2o1ODlha3lOQmNlcTRoRnNwN2xn?=
 =?utf-8?B?TklhcVFCUHNGSTVtdG95SnFjd0taRS9RdkdQcTVlWWloLzhDdkxvSnl5MXQ1?=
 =?utf-8?B?WHZKNWdUSzV0R1hwS0R3RS8vTVJCcFFKU0xUdkwwQlJPa0pTWEhIQ1Z3Qksr?=
 =?utf-8?B?MnF0K2FYUmdrOHE3N3ZPRXRkMTBYTEtud01NS3pDcy9ZV0MyVnNIKzFuMFhz?=
 =?utf-8?B?cVZMMXlSbWdKVTgzVCtpTVFma1R2RmRXR0tjdExLZ09uUXp6bXJaZmdTRzhq?=
 =?utf-8?B?cFU3MnpxdnZlTXg5Z1hmcDVLaHZWNjFFb3dqTHloL29xRkhuOXBRTFBRS29v?=
 =?utf-8?B?Z1RyUkpnL1p1WW5mM1Q0RXpPTjZVS2Q5OE8zTkpqa1hscGpTSGlzanNmY1FR?=
 =?utf-8?B?UGtFMVNmT3c1SmcxZ1M3aVVGdDZHSThmK2txUkhoVG1hd1RoOTZNZHFCN1pt?=
 =?utf-8?B?R2NkbHZGYTlWR04xcE9NN1h3RU4vSUg4VmNUTEtJZXowNml0UmpMT3pqVjNk?=
 =?utf-8?B?aVgwT2hpWnlhQkZ1Z0FEWjlZSmlwb214WGZ2REZibEx3MDdkS1VjaElrK1V5?=
 =?utf-8?B?cnduNVluaWpWV0FrT3JSYXJ6UnphWkVLM0kyWjdwMDdNcUZxQlM3VlpUSjVT?=
 =?utf-8?B?VEFrL2tLYWprRGNxVk1IN1lLdEFEem1vSzFqb3g1TDNsWUIza3dIclVpR1RU?=
 =?utf-8?B?eEhEL1R0V2RPSHE2aFlYNmtYNWV2KzZQeENQSXpmYitZVThnUk55UEJUUFdC?=
 =?utf-8?B?VVBWYnRJekk4cGw0U3diSjk2YnVMZzNWS0RLenQ3d1dnM1dKR1dBcHpMRHBh?=
 =?utf-8?B?V1BzWjE3YndoRm9QT0wvWWJmTE9Ba0UzODZNY0UwWEdxSGVaSnpBMTZ6RzM1?=
 =?utf-8?B?Zy9kQmVDRENldUQ3citIQXIrZ3l1Y1M3TjBHNnpxanhuUEN6aVgxVEozVVFy?=
 =?utf-8?B?aE50M3ZjNjhBcExZUnNEMjlBVUdlNzNScElWd1hGVEVMV1E5cW1pTzlWWjNj?=
 =?utf-8?B?b3NLR2JJeXBVNnRYbnFPb3Y0d1p4WTh5WFFFSkFFT1ZiejlHbFM5Rlc1RkZz?=
 =?utf-8?B?clBxdzMrWHBtTWdWcmliV0JFbE5idG9KUlNPQkpXM3grUnN2NkxhQ240bXJC?=
 =?utf-8?B?YWVzZlB2eVdxdTB2cHp4aVZNa093cENObjVWaS9Dc3h1MlQ3RUZrSnJEd2k5?=
 =?utf-8?B?bGNvMkdSelFhNCtyMCt1cGxsKy81K3U2ZlYxY0JoZVFneGhFMHl2Zi8wUDhB?=
 =?utf-8?B?OTF2ZDRDTUlUWWxwZjVJek5FTzZRR3NKeStXS1FYRWQ4UW84dTlNbTdDdXNl?=
 =?utf-8?B?MlpKU1IxbU5XNzJSSEltZHgrZmNQT2E4VkZHdUtpTCszSGl5RWFtTGZKc25h?=
 =?utf-8?B?QWIrK1NDVUNmOVZvSnFzS2ZvZFcvZmlSL256OXFiNUhVSGlaT2tLQktaNmNV?=
 =?utf-8?B?YVp0WXBnM2h2a2JPRzZQK2REOURQbUFzNDIxQlhSVFF3aHdwTFF2WTFWRE8z?=
 =?utf-8?B?d0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 763ba9f4-b672-43c9-11cb-08db8e1b7a12
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 21:01:27.0148
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2rRnp4e8f1riA8kz8wsRwULzV0MNPDMWMQ4jeGSXZ4RUHfrerusvppF0sVpKOqA6Sy1RuMBU8BHQz9p13SWxPHjbfqNUhDPH9SJCf8XPMsc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5269
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 7/25/2023 12:32 PM, Vlad Buslov wrote:
> On Mon 24 Jul 2023 at 09:11, Tony Nguyen <anthony.l.nguyen@intel.com> wrote:
>> Wojciech Drewek says:
>>
>> Linux bridge provides ability to learn MAC addresses and vlans
>> detected on bridge's ports. As a result of this, FDB (forward data base)
>> entries are created and they can be offloaded to the HW. By adding
>> VF's port representors to the bridge together with the uplink netdev,
>> we can learn VF's and link partner's MAC addresses. This is achieved
>> by slow/exception-path, where packets that do not match any filters
>> (FDB entries in this case) are send to the bridge ports.
>>
>> Driver keeps track of the netdevs added to the bridge
>> by listening for NETDEV_CHANGEUPPER event. We distinguish two types
>> of bridge ports: uplink port and VF's representor port. Linux
>> bridge always learns src MAC of the packet on rx path. With the
>> current slow-path implementation, it means that we will learn
>> VF's MAC on port repr (when the VF transmits the packet) and
>> link partner's MAC on uplink (when we receive it on uplink from LAN).
>>
>> The driver is notified about learning of the MAC/VLAN by
>> SWITCHDEV_FDB_{ADD|DEL}_TO_DEVICE events. This is followed by creation
>> of the HW filter. The direction of the filter is based on port
>> type (uplink or VF repr). In case of the uplink, rule forwards
>> the packets to the LAN (matching on link partner's MAC). When the
>> notification is received on VF repr then the rule forwards the
>> packets to the associated VF (matching on VF's MAC).
>>
>> This approach would not work on its own however. This is because if
>> one of the directions is offloaded, then the bridge would not be able
>> to learn the other one. If the egress rule is added (learned on uplink)
>> then the response from the VF will be sent directly to the LAN.
>> The packet will not got through slow-path, it would not be seen on
>> VF's port repr. Because of that, the bridge would not learn VF's MAC.
>>
>> This is solved by introducing guard rule. It prevents forward rule from
>> working until the opposite direction is offloaded.
>>
>> Aging is not fully supported yet, aging time is static for now. The
>> follow up submissions will introduce counters that will allow us to
>> keep track if the rule is actually being used or not.
>>
>> A few fixes/changes are needed for this feature to work with ice driver.
>> These are introduced in first 5 patches.
>>
>> Reviewed-by: Vlad Buslov <vladbu@nvidia.com>
> 
> In my previous reply I meant reviewed-by for the whole series, not for
> the cover letter specifically. Sorry for not being more clear!
> 

For what its worth, it was my understanding that posting a "Reviewed-by"
to the cover letter for the series implies that you reviewed and have no
further comments to the whole series. I don't think you did anything
wrong here :)

Thanks,
Jake

