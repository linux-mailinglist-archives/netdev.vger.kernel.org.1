Return-Path: <netdev+bounces-31066-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C33E78B35D
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 16:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 651292809E1
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 14:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F0CD12B75;
	Mon, 28 Aug 2023 14:41:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A79811C98
	for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 14:41:40 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B6E110;
	Mon, 28 Aug 2023 07:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693233694; x=1724769694;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=58SHGYpAr22tnjMZ2hUwGAT21KQstHrqrBIBRMqoaSc=;
  b=nuYl6WnQ67QCzdj4zM+bmnGi0K+DrNlkpMSMJYK1qGKiCHcZUkU9cpa4
   eWVwPKzg1CffIAEZxLXI1qLu6oXRfcClVNC0+KcgFmCQ43CGHzADHQl7m
   QUWAeAX1/24lXOxMzgnqBSLLYsugYqFFD+vs7yHIUBKziWSOsSO9koyVV
   79dWN3DJlfFn4lBy4emMVoCfyUb5QiYhJcu2cyM83QdtmIyZmguFuTttF
   qnaSXcFfU7r1CEaRFRqRdk3D3XkYU9eYWXT6aeJ6iKaNV+wCXwMwclRbw
   gXd2J04Ne6CB32ZQxCTAmKSf5RDMFTFBI1IXxjqnFNa4ZYDjjO4e+eO7N
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="360120024"
X-IronPort-AV: E=Sophos;i="6.02,207,1688454000"; 
   d="scan'208";a="360120024"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 07:41:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="738254950"
X-IronPort-AV: E=Sophos;i="6.02,207,1688454000"; 
   d="scan'208";a="738254950"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP; 28 Aug 2023 07:41:28 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 28 Aug 2023 07:41:27 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 28 Aug 2023 07:41:26 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 28 Aug 2023 07:41:26 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 28 Aug 2023 07:41:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HUIiJSEuQV2Ipb3EElMKniHb4oQyL+th1Mf7zRtaPZlft2sZZWa9wjQHfuAePPqB1EfILN7vtG31bvq4c/X+HCekxHKnAz+XFVsH+DNF/8gyBULBkl9yk5YDqULHG8Dt1dsXzHpH7OhawaZquSaHvDfSft7NQhtasuXud8JJdL2PN9jGnlzcepJrxGSLokddQwFxGT84Ca5kv+tx2Tl3YwNSrPKOGpHtZwo7Vt5CWhPiCb4B1TzAdlCK7pgcIm/3KhPLH1KeaFjca56OG2Uw9rp5wyKhKWaVR7mEBJwJoz6aBW8qwk6dqcxF7wOce2uCWys/lKtrjahA9CCsGlqHkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NuNYE0NlDWSmg9gnE5phiJ4OifxNuL+AVXUJDiPA05Y=;
 b=geRLBIZstdFS3H6s/PNuBFmrgqvyf+4fyJbnzw0ub1aqSPozR9NL3b6XQ+8htiAt0hbUdBzN1P9phoMk5UC+5TqlbdmWwiKna83zHrbtrr841HAjXgb/OaItHVVdq7yl5Zs8m+4LJ6wh1CX18wN2argHQyPUAhObtAx22pwroXckxqizi9htkYuEqo1CTL5BgqIi96mLHGVWC3zSPrJsHhNlmfgVdmecEFOZvbp37AWj7LCh9AaN2BTYmBNTiWXdVPWxwjHjDwC03Zy5wAmEsgMQQOg2BiRH7oEdjurhj2w/yJkAyN4MIF4yqKm5NyC8Fc2HlPp51Q1wuv5JiKF7DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3672.namprd11.prod.outlook.com (2603:10b6:a03:fa::30)
 by CY8PR11MB7337.namprd11.prod.outlook.com (2603:10b6:930:9d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 14:41:25 +0000
Received: from BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::5ef8:e902:182c:c41e]) by BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::5ef8:e902:182c:c41e%4]) with mapi id 15.20.6699.034; Mon, 28 Aug 2023
 14:41:25 +0000
Message-ID: <25ff3f7a-b1fe-15ab-ce41-1f1a62eeb624@intel.com>
Date: Mon, 28 Aug 2023 16:41:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH net-next v3 1/7] overflow: add DEFINE_FLEX() for on-stack
 allocs
Content-Language: en-US
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: David Laight <David.Laight@ACULAB.COM>, 'Kees Cook'
	<keescook@chromium.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, Jacob Keller
	<jacob.e.keller@intel.com>, "intel-wired-lan@lists.osuosl.org"
	<intel-wired-lan@lists.osuosl.org>, Alexander Lobakin
	<aleksander.lobakin@intel.com>, "linux-hardening@vger.kernel.org"
	<linux-hardening@vger.kernel.org>, Steven Zou <steven.zou@intel.com>
References: <20230816140623.452869-1-przemyslaw.kitszel@intel.com>
 <20230816140623.452869-2-przemyslaw.kitszel@intel.com>
 <1f9cb37f21294c31a01af62fd920f070@AcuMS.aculab.com>
 <202308170957.F511E69@keescook>
 <e8e109712a1b42288951c958d2f503a5@AcuMS.aculab.com>
 <3f61b3bc-61d4-6568-9bcb-6fd50553157c@intel.com>
 <8c5fcd66086a4354b30f15dd488a9fe5@AcuMS.aculab.com>
 <33c1819b-7c26-ea3b-a8a4-9b14cde425d5@intel.com>
In-Reply-To: <33c1819b-7c26-ea3b-a8a4-9b14cde425d5@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0125.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::19) To BYAPR11MB3672.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::30)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3672:EE_|CY8PR11MB7337:EE_
X-MS-Office365-Filtering-Correlation-Id: 88d5be94-0518-4480-cf60-08dba7d4dab2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZPlZ7stAYGVSSCLmSM+qKowCS/rxfjxIg290C4YMAr9il5a9uREAhiRKsApsze3EiLYP6x+pdU1vVPsJdflLi3XgbleofI97S0pVeKR00Dn0Zuh0kTZEEeCAnVsSpqMJpHn1m1t1O5MmA7or+/vP4g1qjNYvskxq5fMhDGnfcwPYAFPWUV1Pr6rMHXCNjuPcrBVWZU/zWHPATG26UxIS4lyCdTDqU0GAT4EeMGm7czrZSjLUZdh3yz6siqfL3KdzW7yV2guSa6oJwRBoZJPN2Ok3j18ZNmuD7OxdH08+0SWMvGrcK1U+eKeMn1ugwV9EKqz69w3/QWRw2LKPUDv4lwdE1eA+iEgcJpbq3kwgZyGPLpAB3LbiWTQ/wngFxiTKIgOXpzLidP9CUXYo4LBzJlp4w9Bgk5F2rjE8BMAnUjeY6TlUYeHcx34ADQNuO+8S0SrcAQ0hKGIT/9MeNW34Hg4anmuUJA1OWN0I8W8gXTeBfXxm2VCB/7FK2QFMSEHJa3Q6CdJx+Y9AlLuPz+SEdguajuRxWFZIztxUS7sFFEuh7eLsxHppy/oKTfbpR6d4BPQZ2Pw9cBGLEPo/WEQegOmMkPW1iJmqSMotuGm1JwMoXcTEEG5tblP6kC+1G3hLB9viPeQLjrd48f4+QqxxkQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3672.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(136003)(396003)(366004)(346002)(451199024)(1800799009)(186009)(8676002)(8936002)(4326008)(2906002)(36756003)(110136005)(54906003)(66946007)(66556008)(66476007)(316002)(5660300002)(31686004)(966005)(41300700001)(6486002)(6506007)(107886003)(53546011)(2616005)(26005)(6512007)(38100700002)(478600001)(82960400001)(31696002)(86362001)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bGswZkVEbThZUFVRNGk5c1lqME9vcHRtNWl6cVRrcWg4Qzk4dUhzTytjZTVO?=
 =?utf-8?B?bWtDRWVSRUVCTzcvT0dDNW9NdVFwRzlKeW1Hb2xxVEZRMHpGcUFpZ0xHdVJP?=
 =?utf-8?B?UzZ4b21TcEZxMUUvSTZOTG5BVnlWWlpEbGY1cnhtK2lCb1ZSS1oyVTZkM01Q?=
 =?utf-8?B?SllkeHRKUG9OYXlnS0JFMDI5cEU4WnpLZ0hnQVpWRnpxbzFJYmhZWXBMYVNn?=
 =?utf-8?B?MDRici93K3NPVFZLUGNXamFTaWRzMGg0dzlnenc3T3Mxbi9zTUladEEwOHZj?=
 =?utf-8?B?ZWppbTVYd1hkOVhidk1McnlxQVQwMkd0c1drQ21RQkVuZndxc1FJZzZZbGtK?=
 =?utf-8?B?UzNKWllIbE5vY3RDRDBURVAvcWkzL3drZWlkYmpXalp0a2JjekF6S1JlV0Jl?=
 =?utf-8?B?eWFoc1lSMVZCY2V5SXZVeEs1WnQrMGQxSFUvZ1VSUUZPcmo5cVhUUTk2U2h6?=
 =?utf-8?B?QXZwek9OWHF1M2FvWGY4T2NicE1aTXRvREpKS01xM2krTi9ONlVSZnVNdkdC?=
 =?utf-8?B?SHdpMEVnM29JeUZCYnh1N0pVdUFHSEJ4M21Ec0d1THZUWUJaK1lqejFGQ2tK?=
 =?utf-8?B?YTBRMEtzUFloaldrZzQ4Ym5pWFN5TXFQdzltdTdpcWZxY3VETzk5eUJ6Mnc5?=
 =?utf-8?B?MDVUWnJPNnR3NjBNa2MySE5RaTB0Q2s0cGl2eGlueWFFVzZ4VzVHTWRpTFIw?=
 =?utf-8?B?TUhod2dBd0I0YUQxMFEwS3kxQXAxYWd3SVRDUkpBTkZ4WVlPSzljdjRwNFZL?=
 =?utf-8?B?L3lhemRuQTFkanFnQ25Sa2VxdFlZek9nSXFicTVNcjJ6R1ZHWjZTc0xuc1pa?=
 =?utf-8?B?bXdGTW9mTnVucWZsVlR3REhmemNvS0FFcGk0TzZPUnJCY2ZFUXBBOG53ZnIx?=
 =?utf-8?B?bGxHY1dIcldKcEc3T1lRMnpXVE5YVHFZVWR4cmJQbHJIajB2aU51c09mR0RJ?=
 =?utf-8?B?RkZDS3dqREh6MWNRdU5pSG4xS1pZY1BCWlhwTEFoZU9VUys2MGNxMnEvWXZv?=
 =?utf-8?B?SnplMnBZTDRqYVg4MWI3VWEvMGlVSzAzTVJjRDZteVhKTmtFZlZkUzV5cG9q?=
 =?utf-8?B?WUZ5cEllb0cxdUZhRVdjMEdDeHFWMXJHb2ZMTU9hRyszRE5JVnFuUWRzU1Vv?=
 =?utf-8?B?dFJwNnRKcHFHbVRsOXBTZXVLZ1NsUGdLQURaaTJ0KytoNGUrS3ZOVkNjUnlZ?=
 =?utf-8?B?M09kMTdEajgvYTd1MVFwdFlkcDhkRlJEdHRjVE9CME9taHJiOUNUWFM4OW4r?=
 =?utf-8?B?WkRBT1Z5b3NLdGlrR1AzRHp2TEluRk8yVmc4N0dTbVRqVkpKY1VqSHdhc1Bn?=
 =?utf-8?B?V01FdHlVOWJKcnJNMzU0c000Wm1WM0ZnQ1l2Z1RuYUEvWERiVEhmaXM1bVMw?=
 =?utf-8?B?TmJocndQdXljYmN4UVMzTW9YbUlSMVFkNHVpTGdhNjZoSEZSMng1c2loM1VQ?=
 =?utf-8?B?eVhhZU11MUNvMVd2VWw4T200MzFGOVpWS2pZb3RUc3lHaUlXbUhQUnh1U1lJ?=
 =?utf-8?B?dVpDcTJ4RUVxaWNoSUdKK0tBUWFMQnFNMnczVkZ5K3ZBY3hxNUNXbzFQUWV2?=
 =?utf-8?B?MXZGL1BiMjR2eStvL2Npb3VHdUxlUE9Bb1Q1Ry92UTZkY3NtQVl0ZjN0RVQ3?=
 =?utf-8?B?MGhvZDh6eWUzaXo3R2ZoaTh2SGVoUDdaQ280ZGJlMi9TT29GditBdzVETStO?=
 =?utf-8?B?eVdXcFFqVm1DZitKVkZjNXFLYWQvdG1ORThKdUlWdGE5aDFyaVFBUG55Qlhj?=
 =?utf-8?B?dTJzaWkrZVhPUVIreHdPc0t5U1dFNXZuelNxdEVrRjh2LzB4d1U1STljdklj?=
 =?utf-8?B?MkQvUXBNeUdIM1JIcm0wMnpaODBheHZxY0RpZFIzQ2lsc1VxRCtHOEVId0dR?=
 =?utf-8?B?YnJHUWZsNldZUDJpMDFGNkk0cVJsSWlKOEpjMHJaRHU4eG1RMVlkWlBBNzZ5?=
 =?utf-8?B?RFM2S1FnMXRTS2pnbktKV1UxZ0NuM21rS1dMVW5GbGdDYU5aYTJIT1YxT085?=
 =?utf-8?B?V3FLNXFBb0ZmdjhabW95RVJseWtsaTlDZW1haUNHcFZ5c1cxdkQ4ZDhLQnVi?=
 =?utf-8?B?UjNpYkNEK1EyYnRiQjVWNUlhYUxTWVJBdXUxSklzekdXVXBHR3Z5KzR0NlMz?=
 =?utf-8?B?UUFCWnRpRmpLdlNlN0x1NFRjQm9ienQrSG1EL09BdU1oMFVWVHF5S0FhSks2?=
 =?utf-8?B?U2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 88d5be94-0518-4480-cf60-08dba7d4dab2
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3672.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 14:41:24.9017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: StiLJZEi++wU28VdtZke1RjF1kIn8nTsl2JG8FOONgx5cXj50TrDbnl61tfxWGEalJywFJq8Dx2b6hu5Eba+3pq0lb4Zp8BE45OusVhNYCU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7337
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/23/23 22:52, Przemek Kitszel wrote:
> On 8/18/23 12:49, David Laight wrote:
>> From: Przemek Kitszel
>>> Sent: Friday, August 18, 2023 11:28 AM
>> ...
>>>>>> I'm not sure you should be forcing the memset() either.
>>>>>
>>>>> This already got discussed: better to fail safe.
>>>>
>>>> Perhaps call it DEFINE_FLEX_Z() to make this clear and
>>>> give the option for a non-zeroing version later.
>>>> Not everyone wants the expense of zeroing everything.
>>>
>>> per Kees, zeroing should be removed by compiler when not needed:
>>> https://lore.kernel.org/intel-wired-lan/202308101128.C4F0FA235@keescook/
>>
>> Expect in the most trivial cases the compiler is pretty much never
>> going to remove the zeroing of the data[] part.
>>
>> I'm also not at all sure what happens if there is a function
>> call between the initialisation and any assignments.
>>
>> With a bit of effort you should be able to pass the '= {}'
>> through into an inner #define.
>> Possibly with the alternative of a caller-provider
>>   '= { .obj = call_supplied_initialiser }'
>> The 'not _Z' form would pass an empty argument.
>>
>>     David
> 
> Thanks, makes sense, there could be also DEFINE_FLEX_COUNTED
> (or DEFINE_FLEX_BOUNDED) to cover Kees's __counted_by() cases.
> 
> Would you like me to cover/convert any existing code/use cases (as with 
> other patches in the series, to have some examples/actual usage of newly 
> introduced macros)?

I did some manual searches and found no obvious candidate :/
will post next version/RFC without _NOINIT() variant.

> 
>>
>> -
>> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, 
>> MK1 1PT, UK
>> Registration No: 1397386 (Wales)
> 
> 


