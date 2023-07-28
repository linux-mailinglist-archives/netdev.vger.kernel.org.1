Return-Path: <netdev+bounces-22445-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0663767887
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 00:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D2E82827E5
	for <lists+netdev@lfdr.de>; Fri, 28 Jul 2023 22:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F8EE16407;
	Fri, 28 Jul 2023 22:37:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666DE525C
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 22:37:32 +0000 (UTC)
Received: from mgamail.intel.com (unknown [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D099D44A0
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 15:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690583843; x=1722119843;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0d5OP0WtKdWt/auqSD0YjXKJ1d4kn5kO/KlUo8hkDos=;
  b=IkNCrdJTWXfGl7hkeJ5KVbSXXFzrec4P+dtyIw/G3gQ7ba+xaVpueKHB
   dvNYYHrcswcfZkYIYqTjfmGGVWVWRHy9+y/P/LziuMc4qkI4I0C44BfZY
   S/7HTQ+tuQDtZ9rurg9NEyFkpH2OCNuHrvourUsaMIYa12l0pjXARR1QW
   KSkPwHobhco5seorUjjtAJamktKxzbu5DjoJqlu4k4nL1OV+wdFvl+rV2
   0bCPg8Y8BmR8SlXPzTJS/ExNpiLa+a/SfkaaQgxhyJYum/qpbm6ft7mIh
   7ewE6ftD1li2zf5cbSCaWoOFv6b2w4TF6CBTqJRpllNrkr0hmNx0zeLAX
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10785"; a="434986469"
X-IronPort-AV: E=Sophos;i="6.01,238,1684825200"; 
   d="scan'208";a="434986469"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2023 15:37:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10785"; a="704731773"
X-IronPort-AV: E=Sophos;i="6.01,238,1684825200"; 
   d="scan'208";a="704731773"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga006.jf.intel.com with ESMTP; 28 Jul 2023 15:37:23 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 28 Jul 2023 15:37:23 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 28 Jul 2023 15:37:23 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 28 Jul 2023 15:37:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mIdcxefAHu+lEqaozzUxL0XHNypj6LRwWBjDvEoRPw85LroqDRZsEFW9xSVkft/UU7cRia9pLyHQMpJRHFqRTxVcLPPT3rMujkzwSmUvfHARiTQLwo0TQKdnvT1QWKuaQ3jPcAdektFgUIIIfBee5EGIx87YfW0RN6bmkXaVNe5uy+84V/i6AzMZxuJshwD+Uc50BIo9ZoHKBHkEhUvcF2hpjVqXO2a8v1dZrRfIkVh22QLUoLWElqM8mMdnFyLSKstPDDjTR4TzzIIuAwCh28yMBIgtq3TjYwpCamt9pIyIub3yuOdj9fHAQBCuKEtglKJJQbEilWaqR8zXbe0JRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s/esEE/v/EAq1aZvYi6oz1zEEaZZqXgMpsrueLN1mQ4=;
 b=SVzX85T25Ou2xnezOJgs1VNMA1AdvNY3Cpz71L1QHow9eYr2pqSsoN3fbydjd/2UM81iwXLUs9HQc23/byK/T2Pg3SzCEHnihYbk9X/9bgV8uYM93E8nJwpAZIH3yumWweKIjwZ59TjUUErHazjsDK7hGeaqG82qx1PGg77jKv89Rsj/Io2rPE43p0efu3A5MrQwi9pwwqliVupv1kxTywulRdZ25AMkizFZbY7LXFZ0KQBzboT8X5+YF4vzEjydBLPpZden0orgw5mTVk223fPA7f0n/1jR/aAakhpHAf/j5R2sU6r+kl4gQK7nJ9OPZL2mTKwePUXXBLvliUAaug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7869.namprd11.prod.outlook.com (2603:10b6:208:3f6::7)
 by BN9PR11MB5403.namprd11.prod.outlook.com (2603:10b6:408:11c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 22:37:19 +0000
Received: from IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::12e4:637d:955d:a5f]) by IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::12e4:637d:955d:a5f%6]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 22:37:19 +0000
Message-ID: <44c5024a-d533-0ae4-355a-c568b67b1964@intel.com>
Date: Fri, 28 Jul 2023 15:37:14 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [net-next/RFC PATCH v1 1/4] net: Introduce new napi fields for
 rx/tx queues
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <davem@davemloft.net>,
	<sridhar.samudrala@intel.com>
References: <168564116688.7284.6877238631049679250.stgit@anambiarhost.jf.intel.com>
 <168564134580.7284.16867711571036004706.stgit@anambiarhost.jf.intel.com>
 <20230602230635.773b8f87@kernel.org>
 <717fbdd6-9ef7-3ad6-0c29-d0f3798ced8e@intel.com>
 <20230712141442.44989fa7@kernel.org>
 <4c659729-32dc-491e-d712-2aa1bb99d26f@intel.com>
 <20230712165326.71c3a8ad@kernel.org> <20230728145908.2d94c01f@kernel.org>
From: "Nambiar, Amritha" <amritha.nambiar@intel.com>
In-Reply-To: <20230728145908.2d94c01f@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWH0EPF00056D0B.namprd21.prod.outlook.com
 (2603:10b6:30f:fff2:0:1:0:b) To IA1PR11MB7869.namprd11.prod.outlook.com
 (2603:10b6:208:3f6::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7869:EE_|BN9PR11MB5403:EE_
X-MS-Office365-Filtering-Correlation-Id: 88af4cd8-70a5-4c67-187e-08db8fbb335c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TvXokpLJN2LxsGf6A0g3asoibNJKUBDvqolX6yezTmFaCEC31DlWascQ3CdusidaMjh+wrnHE+XxWe3nH04dbhWu2D3roOFWbqGAadOvMiUQlrLmcKF9qQ4OIW2gjFrxLBVf6uou6K3Ha0kUMK8UXOA5G3y3XwAYX6g+CLFzo3pb2Su/T/FvcYZsBghuEvSQIVpmFUNNKfBNYsWjXplq5gbQqLnP0NzrV0YzByPO21s/a57UOkWYpaO8qbVZ/wiF3Bm7YtJP3n3YXF360+cVY2LTBxfiUXLt8Ty8SUjDg7qpwb6UcqQHkixvk8HD8HdLOv1Ul6M0BRM9ib6pDsqjYAgT5kyK2+ZkmywPxB4QQeqvXSR+tqyaYFcSAMuzxxTmJdWyhmobzFP4jgQPQkzGm16XiO49JfAxJjNtcbO4mdboxfpEWs7RmiQZ3H40ZWsyOU/Iqjlecez0+V31jLOG4i+xgPNNt//9nGPG8XNTCy/QSkpgEk0Vd2l29z/LwcyE2GPNOLaCrrbsRapx8+ATs4bZFOs4lkIt14gIYGMK6juPfapFu19Erbp18jceIQPAXQaXQ5KI73D8SI4Hz0y7yy9tEoT9/zBOLTD4BPYJSI0n2W03GgfmGsDtnCEfm4WyelRFZja5HMSCL2pZKpjHPA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7869.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(136003)(346002)(39860400002)(366004)(451199021)(6512007)(6666004)(6486002)(186003)(31696002)(38100700002)(86362001)(82960400001)(36756003)(2616005)(26005)(53546011)(6506007)(6916009)(4326008)(107886003)(66946007)(66476007)(316002)(2906002)(66556008)(5660300002)(31686004)(41300700001)(478600001)(8936002)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dDR1NnNuekpTcTZHN1c1UDZob3IrTENqeWZZVi9xM2xTbFMzdGwzMFRlUVBn?=
 =?utf-8?B?RUY4RVE5RkJHbWUwSHhNNThZc3FsV3VDMk9MYzc4ZkdzNHF4OUczLzN4MkdW?=
 =?utf-8?B?ckNjcmFSc29oZXBaOXBjcnhuZ0praGtWNTFhZENhUkcyaGZiYjYyTmxsdHRv?=
 =?utf-8?B?TzdOdzFFWUpKK21kekk1ajQzOVhsYk5jcjA3RjBOMm1YN0Fudm1Sdkd6M3lP?=
 =?utf-8?B?Z3RMUGRBYkdXYlhYV0xxLy9TQkw0ZGszM0g2SHgvTWF0ZE8vOXB5QzRJbVEy?=
 =?utf-8?B?bjBTZm9CVFlnOTRmU0FFOC9DalZMRnZJeUFRaDE1K1k3cmV4am9LbHJHcTJz?=
 =?utf-8?B?K0FsYjZybVBmb3lUT2JVREJQZXFIMEFBRWovdXdqMzNCc1g1MjkrWHQ2TVpq?=
 =?utf-8?B?VHNJdjdheHZjaHNaVVlJZTlMclB2U3c4OXpxU1pYa2VHZmpiY2VEWC96c1lh?=
 =?utf-8?B?TzVqZDRiODhsTVN4WDJFNFhaczE4aUVzbE5jalJZbGlJT0F4VFZhVzhsS2NT?=
 =?utf-8?B?WlFTdS9FMGxoUUNyanJnUFViSk9sL3lvck9IRFc1ckVTK05sbDI0NE5YUWpE?=
 =?utf-8?B?dDY2aWVYYkRCZFlRaSs2b3VNaE5sbENUbVVsWVZBb3d2MW9VMjQ5TGFWenF5?=
 =?utf-8?B?QjVUQnU0VEpwUVlYOUJ2RzdRdmdIckZOcmFOZXFSYW9NcjluckI3MDkxY3ZO?=
 =?utf-8?B?UXlOMk14WDEyaElkUThKMFZQLzJwOENuUmNvZlU0QVQ4Vm00Ym05SGsxa0h0?=
 =?utf-8?B?QmNDRWtkZ3FHaFJPNnlZNmNRQnlOVGJpOU95UUdidXQ1aU5oRUNyUFdFYlIy?=
 =?utf-8?B?SmRVZTNxS292c3pESWZWbnJhR2J5SVFXdHpYM1E0cWZybVArbGxZZ1R0K3Rn?=
 =?utf-8?B?Zmh0L3dNSCsvbERHYXR1RFhSQnQ1YXlxMzVaRnpGUUgyaDdGRFlXbkE2K1lK?=
 =?utf-8?B?WjZCOXdHWWdWeGswMGt6Wk9IeXBjYU14MUVpSFFINEp3RjVpelZRWDlEOUxn?=
 =?utf-8?B?eXc2NEM2dkxwOGk4emRJcjV1V1dvQWpGWjdkV1QwTHZqdUswd3FKMCt0MTF1?=
 =?utf-8?B?eUhMY0xNaHRIKzUyNEg3VkwxaXZ5di9Hek5BaFBHc3VNa0YxdGt2OElRMXVB?=
 =?utf-8?B?Y0FKQ0VSZHp2SXFqclNWbXdBVnkxQllXY29MU1ZwVjlsZmphZ1hCOEtTZ2Yz?=
 =?utf-8?B?VElZWGRneUNoL3dlMzlzUmcyeTMwbkVuZ0QwMWw1MlhycUlwOEc4Yko1L1Rr?=
 =?utf-8?B?RGZhQWxCYThFQmZNUmtWd3h0bHF6NWJEb3EzVEpsT2h0RUhKL2ZpMXZnNnox?=
 =?utf-8?B?T0hyUStiaEhaSDlZSHBDSEdlVzZrYWpydzFhV0VOSTZTeERna2U2NWl5ZWFn?=
 =?utf-8?B?QkU4K3ZHa2NvRjRMOXd1Nk5QU3RoMjdLRzlOMDF6SmNiWDFDTldWa01Td1FF?=
 =?utf-8?B?OFhmR2JiQ252ZWlQbHQxaEcvamRxeVplNERyb25qYWtuc0dhL3pOWHNhaEcx?=
 =?utf-8?B?ZDFqd1dhNGptU0NxR01LamMreHpoeEMxM1JoT1pqNXhEWm53U2V2VGU0clY3?=
 =?utf-8?B?UU15c0REdnlpY2tBeUxxODdQdmZ2N3cycTlIeGtFdVp3c0IyQ2lYUmlYTGli?=
 =?utf-8?B?U25xZHlZeEdBNmNCbDQxS3FsNWJYM0ZyUVV4NFVXUlFXYWtLZ0E1OUZGV3l3?=
 =?utf-8?B?REczNnE4YUtyL1JpRW1RNkF4QVNOR3g0YkF1K1YxR3FBcTJmdngrdXhCdnZp?=
 =?utf-8?B?QW5SWTJjMnp4YitMQUlTYSt3WjFzWnRqMVZTZEVRTGFHR0NmSnJjN0dpQUlq?=
 =?utf-8?B?Q1FMRHhpYmFFVnYwT2tXdXcwNnlxSHp2eVpTYXlWSTlhWjZqWEFDcGhOdHMv?=
 =?utf-8?B?cVBzWVB5SndXNzFKWEs1NTE3R0RhV05FNGdHV1QwM2R4U0ZpVHhhVDNkOHds?=
 =?utf-8?B?UWdabGJGcjd2Q3VsT0JlNEVidWRDWmN4bkVWdTh0NWoxR1BjR1hWVDdmaldY?=
 =?utf-8?B?ZnhGTGNoSXFVMkt3SlAyUXB4WXN3UTNFRmVTYUlTZGNyT3VFdXNyQnFzZ214?=
 =?utf-8?B?cXlQZndxbys2bllRYXMvdlB6WFI1SE1tenJhTjlXMElTK241VUVhTFg4cGVL?=
 =?utf-8?B?RXVTZ3c5Z0d5QzNmMmxTZlRiV0REQUsxRWorc2R3eWlGMkgybFdlNk5wbEU0?=
 =?utf-8?B?RGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 88af4cd8-70a5-4c67-187e-08db8fbb335c
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7869.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 22:37:18.8457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cTh9XC6nxjNgON3PgMeRVtSS66bSxIXO4VSszXs11/ee4FKPpncZNa6nBE8qDkg6E1mLJhBO49o3ZVKivg2mH/nVbCHpjRPQhqB5RxJ9Tgs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5403
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 7/28/2023 2:59 PM, Jakub Kicinski wrote:
> On Wed, 12 Jul 2023 16:53:26 -0700 Jakub Kicinski wrote:
>>> The napi pointer in the queue structs would give the napi<->queue
>>> mapping, I still need to walk the queues of a NAPI (when there are
>>> multiple queues for the NAPI), example:
>>> 'napi-id': 600, 'rx-queues': [7,6,5], 'tx-queues': [7,6,5]
>>>
>>> in which case I would have a list of netdev queue structs within the
>>> napi_struct (instead of the list of queue indices that I currently have)
>>> to avoid memory allocation.
>>>
>>> Does this sound right?
>>
>> yes, I think that's fine.
>>
>> If we store the NAPI pointer in the queue struct, we can still generate
>> the same dump with the time complexity of #napis * (#max_rx + #max_tx).
>> Which I don't think is too bad. Up to you.
> 
> The more I think about it the more I feel like we should dump queues
> and NAPIs separately. And the queue can list the NAPI id of the NAPI
> instance which services it.
> 
> Are you actively working on this or should I take a stab?

Hi Jakub, I have the next version of patches ready (I'll send that in a 
bit). I suggest if you could take a look at it and let me know your 
thoughts and then we can proceed from there.

About dumping queues and NAPIs separately, are you thinking about having 
both per-NAPI and per-queue instances, or do you think only one will 
suffice. The plan was to follow this work with a 'set-napi' series, 
something like,
set-napi <napi_id> queues <q_id1, q_id2, ...>
to configure the queue[s] that are to be serviced by the napi instance.

In this case, dumping the NAPIs would be beneficial especially when 
there are multiple queues on the NAPI.

WRT per-queue, are there a set of parameters that needs to exposed 
besides what's already handled by ethtool... Also, to configure a queue 
on a NAPI, set-queue <qid> <napi_id>, the existing NAPIs would have to 
be looked up from the queue parameters dumped.

-Amritha

