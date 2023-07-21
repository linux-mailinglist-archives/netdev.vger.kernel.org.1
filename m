Return-Path: <netdev+bounces-19958-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F8E275CFBF
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 18:38:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF3C328195A
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 16:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9485C20F89;
	Fri, 21 Jul 2023 16:37:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8107220F81
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 16:37:11 +0000 (UTC)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E976E4698
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 09:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689957407; x=1721493407;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OCVMI+c7K3tQbe9E7bpCuprmxzx3QNkQjMElv6rxgEc=;
  b=JbsvP50n9HSUs48OE4i7BP4vvEUMduPdIf+gD/nmS3E1Y5M3fNWUgGo2
   oogRsDC8AeKP/r6egLDopX2ecM8oJK0ugiXgkXX2wfjaPRN0tW5xt8pk/
   B45Z8JTH1Lf8OwNMAYQByEP/QV0TnWWycTFd8BSLWfr2ZkDaSMlGXYMQd
   DdeiyoFM3FLeqMv5LBmWWCruKVbeGGcdaJ9zsm+Y0G8A2DyGIkOe4UK0I
   OFSbpM36C2YWilbNZ93XnIWhkhwa99HSvnnHaCD6cc7AD9tix6t9Rj07z
   AoUGgLnLDBfeJuN6eJAHS/0wRB0NBvUK0r2z/Fb59Z8O5TVAXQchXIQRR
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="347355169"
X-IronPort-AV: E=Sophos;i="6.01,222,1684825200"; 
   d="scan'208";a="347355169"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 09:34:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="760007692"
X-IronPort-AV: E=Sophos;i="6.01,222,1684825200"; 
   d="scan'208";a="760007692"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP; 21 Jul 2023 09:34:51 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 21 Jul 2023 09:34:50 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 21 Jul 2023 09:34:50 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 21 Jul 2023 09:34:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a8af9XS7djfJaA9uYcwjtY5ICVjKK+o6bHg0QAXF/GFOwjNkXUCtGNf/nx+2ezqNXGmTnSzEVkflmYOW6mOr5gvaTz+3Ngo/+w1pGW0q3RXwnEPaEqyPdCYay5GB0us8ZLXmsaKDcKmj2FkEUFgLqFpZWqlOTgCj65lDmSmqFEF04v0md3dyYreYxKc+ICLmI53I0GTZuFx4YCuMPYxjkqU05W9kD5PXlVtv5JHfpDJSGRSv5ElDvTuihs3e1QWjp+GyOyXQy1iq/sc3UAu9bbV7jcSybp6yYJnqraQT+tooGAGFLreYneu9J4pXlpCkQ86ASSKyvEbugyNODF5Pmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YHK2xDkS9eyYKbgpYJqWyBe0ORct4la/iVYtlkLfPEc=;
 b=Q3PKwIRkjXOjQwbPl2x9Bc5yBZvDIKBW069YBasbOquQZjPiHCERB4Pzdkkierh8QFQUJBUz4+8U/wAHJwyR4tzFM0YIZzghm40l7Q7L4M6v2s3jnPFPRBz25uOEq2Xtfgdu3VC5usONARgaZhusnrRr2mX4bj+SUZPo/pQS/NxPIJFsyTw+mpW3pnQ043RGHNixjKDaj23r8UwBBNiqlYyksL+EFY1GeM4GdZ6ivUhiHoQ0oOd2wRXpbQ8Lw04nk8RGmH05kUPzGfkc1gscVl2pRzyAoA0NkFL5OxCTpa1H/H5mVBNVZlXErzxLLYMKZNZw3rycI39dkV8IqUg1ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by PH7PR11MB6676.namprd11.prod.outlook.com (2603:10b6:510:1ae::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Fri, 21 Jul
 2023 16:34:49 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a%7]) with mapi id 15.20.6609.026; Fri, 21 Jul 2023
 16:34:49 +0000
Message-ID: <fc51f6be-819c-7b42-e0e7-4b474a690a8e@intel.com>
Date: Fri, 21 Jul 2023 18:33:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH net-next] page_pool: add a lockdep check for recycling in
 hardirq
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <peterz@infradead.org>, <mingo@redhat.com>,
	<will@kernel.org>, <longman@redhat.com>, <boqun.feng@gmail.com>,
	<hawk@kernel.org>, <ilias.apalodimas@linaro.org>
References: <20230720173752.2038136-1-kuba@kernel.org>
 <4abeeded-536e-be28-5409-8ad502674217@intel.com>
 <20230721090538.57cfd15d@kernel.org>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20230721090538.57cfd15d@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0253.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::8) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|PH7PR11MB6676:EE_
X-MS-Office365-Filtering-Correlation-Id: e519419f-b8e7-475a-cd05-08db8a086682
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e313aAPG+aq86b6YI/xz6hza42eUJryAyxQfz63A+epW4XVRpSGVFB8ZUF2JYGIJdECOhBheqHnGYnTvAwKL1WFiFbMbPeQXyXqEodey96MkUOfYbg7cOflZxCPmfzbyP36mnSIQLcZSRwo/jLUExU9LYiLaaAfMMx59jYo6r8pfQX0OeJENL7Cc/Qdtg3JeR+2xTfkRegFh7scjHHjPaKqat+mV/X5E7KO2XcVOOC9nCCXXXKNY5Ba6DIQLuzVURpm8Ew35ovKq8rUqRUiYROMt1TW4/CZDkqp+uzZLFjb0g1Xd0KURSWtM2tZOE0OIB/b2fG+mRrSgGXeJHWw4PMYT0BfS1EYweemf7gIf5+0hamZuCtd8InrzawZQH4eNJJOgaU5uTq4/cYiw3ySxLdBB9dyfjz0+TxQuyjGlsmAu6NkAq07+dbnFydlvDtCVRzOuVf3AawOaLiRGQEJHi3Ju9KrfzQaDDr04ie3zwIFXNQehaW/XP3D8HNt7sKMEoBLpnZgYXtlL58dCrlCrIwu5/d7DhGdKx2xSJNQ9bj4lur+uEyCvMCYGZKj1wwleqT1u3lHGSqHpaxIaHOKbfyjSmHeo5uHeVNo4ZAEorubrdWllYHZELW8eTbP1o5nIyyIGLN9upU928S985GCdOg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(376002)(366004)(39860400002)(396003)(451199021)(2906002)(6512007)(31696002)(86362001)(82960400001)(2616005)(186003)(6506007)(83380400001)(26005)(38100700002)(36756003)(478600001)(6666004)(6486002)(316002)(66556008)(41300700001)(66476007)(4326008)(6916009)(7416002)(8676002)(31686004)(8936002)(5660300002)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUdacndTYXROdzVrMng2RklYWlZ3YkkzakVNdFZ1Q3hUWUVhTVU0WjhKNVo2?=
 =?utf-8?B?SmhTcWVLSm9aL1ZGbGZONDA4QXg3K0xGbW81b1FXVlVvWXhyNXhuTU81ckkw?=
 =?utf-8?B?ZEZxV29XNmFTdWVXd2VLYUdDR2dVQzdsUDd3bnJwV0wwdEs1dDdSaXc1TXpy?=
 =?utf-8?B?V2JVWUhBeUF3WC9EZS9zZ1YxdHBBREx6dUNScXFmaUZQN2crVElNdXpoV0JL?=
 =?utf-8?B?SFpwSjlZZGxYR2NEc1NqU3JpMUpoMUZoWlNYaDZmSzFkMnF6M2VyR2hqZHV5?=
 =?utf-8?B?V3haaVBpUHJmdW9Vc1g2R0cyOFZEbVN6UndlZFBLMWZ1R3BxdUl6NzJic2tR?=
 =?utf-8?B?YnhjVVgzLzQ5SjQ4NVNCeHAzUXFWem9uTzFLVGRISUg4NjF5UnZPTVRZNTVT?=
 =?utf-8?B?Ujc5aXJPRXE4eEFUTklVOHVnNldZVm1XSWYxam8vSEpCR1R6UjRwWlozN0RO?=
 =?utf-8?B?YTBIMHpCSFZWUjc5Q3VYc3M3dU0yR3BOWnZSY1NEZmpBaHNUQTVKV1hCcmNQ?=
 =?utf-8?B?eHJyZHlvSy96ODlPWjBpTUcyTktGTHNDWStoMXI4L0tGblhJN1l6eDFoa1hV?=
 =?utf-8?B?cmNmbVpvWGJDbE5MeEN1aWovSm9hMVZYaDdlNm1sbkZtVnArOXNPVHg4TjBs?=
 =?utf-8?B?NXBrWHRyYjU5MSszVUNjQ2RBeTU1bXNCdTF3R1cxSGE3UHlQUTJyMm45a2tW?=
 =?utf-8?B?Z2F5bFRIZmlzRWdHbnRTMjFYODFJTDNaZm1VWFhUVGlZK1JpZlRtMG0zdHh2?=
 =?utf-8?B?dVkya0djYm5XdlJxZ3p5YlgyTmJ2RnBoVU1ER3NrUlNvREtYNHloYXpaK3da?=
 =?utf-8?B?UkNqaERJUHFQenMwN2dqM0NvNkQwYUVkdVNMRWk3OUFuQWNFV0o1QUhuZktu?=
 =?utf-8?B?aHdQcm4veVhhTDFUeWM1VWsvOWpyMm02WnFXNC9HRzhkZHpxK0VTU0RKNG1Y?=
 =?utf-8?B?Y1FrRlJPR2VxSmRSRFRJVWhhMVZwT2kvZFZ3cjhYZ29QdHFrdjJlUTc4Qldz?=
 =?utf-8?B?cXVsc09PWUF0czRvdG0rMTdEV1UvRS85QlltSUdGS20vTW4zUEdtSHBMeGV2?=
 =?utf-8?B?clFXbUZtOW01MU1YdnZ6Si9tRmgvb0hlaG85Y2tJMFMwOVg1WmVtbFFMenZV?=
 =?utf-8?B?cUNYaUxKZzNOb0EwV3l6S015UDNJK2E1LzNyZHZadEhPUjRDU0orOWVCdXhD?=
 =?utf-8?B?aEYyenRWWGduYSs0ZVlYbWZsaEpMdVUzcGZzQTlzcytwOUFac3dsNjJ2YmZi?=
 =?utf-8?B?aVV5aUpteW5OWkxka1puS29BenhiZHNvUFdpUU0vUEFGVVdmbTZhMFArZ1Ir?=
 =?utf-8?B?SU93eC9ET2hsK3poYXhVNUk1dlk5d1BQVXM3SlN6MCsrcHJhVXBBTWwxYmpW?=
 =?utf-8?B?UlgwZGd4VmpYbFpCNHN3TGZVSTdLUEY3QUwzZXhvNUNiTGhZaC96aHdEb2dD?=
 =?utf-8?B?NWdHcDNlNDlpZjJ2WThPU21PY1loQlBHRS9YTFNpMStCVFdjTVAxZGFnSDlv?=
 =?utf-8?B?YzFycjRxQUVnd1FTc3dLMHRIRis2RFNVWU5DRnd6N0gvbjN6SWpmUDdqV21l?=
 =?utf-8?B?K1d5QmplYWYrUkp5T1JoMTlNU1U1QzloUTRvVktQd0pNM0lNUmthQ3p5UFhs?=
 =?utf-8?B?eTJNK3hVNThXQnhDeHhuWGpJNlA3VXdxT0liTUE5ZURxZVlwbWZsR21HNEVO?=
 =?utf-8?B?ZWhvWnR1RDdkUTZTR3VZVzN5amJoWGcwZVhFdDhyb1IxOWlMZXA1SXNlb2pO?=
 =?utf-8?B?OUZuTjdLeklEZzhGR3NQejZ2WkRycU1RZ055bzdkL1RkRjk0bC9SZkVpYnV6?=
 =?utf-8?B?WmE2Y2N5VjQ4dkREdzVsVVI2ODFzMTlIbW5WSFE3Z045VnNpWFFhdE5vL2lO?=
 =?utf-8?B?bkJEc2hCb3puek45WUFsdFJLYWQzNjU4L2l5cEkwd1AzK2RSWU1hQmszU01t?=
 =?utf-8?B?Umk4SVlqTGhOM3dkYWVZU2lNQlpXVHdiR1Y4RjZ1d1V0VHlDQUFXcTFQd0Nk?=
 =?utf-8?B?ai9qQm9NUTdFL0I4L0l6eXRRMWVKeXFVR3llaWVHaGdjTFhVOExhcXNnYzNO?=
 =?utf-8?B?YkcwUHZaa0lCVmRWZFBkNm55NkZpalhFTHR3UExURlJaWnhiWjNvbTVZaHpZ?=
 =?utf-8?B?TDBVNkkvTUc0NlIxdkxPSStlekNkcUlzWldpcjVHSlc1R0x5Mm9UN3UyUEt4?=
 =?utf-8?Q?TK6pOhKPOvpJ4omxYSu80/A=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e519419f-b8e7-475a-cd05-08db8a086682
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2023 16:34:48.9669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y/WxJll7GjyuOT4ucS+OJbQA9ubXv/LZoBlNNV079uzcmw0aowSDLZfZ3/hH5AgaJZDcxTm1TkA0w8P/Sa0NYWOw0f52Cel9asM0iJbuXe4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6676
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jakub Kicinski <kuba@kernel.org>
Date: Fri, 21 Jul 2023 09:05:38 -0700

> On Fri, 21 Jul 2023 17:48:25 +0200 Alexander Lobakin wrote:
>>> Page pool use in hardirq is prohibited, add debug checks
>>> to catch misuses. IIRC we previously discussed using
>>> DEBUG_NET_WARN_ON_ONCE() for this, but there were concerns
>>> that people will have DEBUG_NET enabled in perf testing.
>>> I don't think anyone enables lockdep in perf testing,
>>> so use lockdep to avoid pushback and arguing :)  
>>
>> +1 patch to add to my tree to base my current series on...
>> Time to create separate repo named "page-pool-next"? :D
> 
> You joke but I've been scheming how to expose the page pool stats
> via the netdev netlink family, which would be another conflict to
> be added to the pile :D When it rains it pours.
> 
> You should probably start sending uncontroversial stuff out even
> if it doesn't have in-tree users yet.
> 
>>>  # define lockdep_assert_preemption_enabled() do { } while (0)
>>>  # define lockdep_assert_preemption_disabled() do { } while (0)
>>> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
>>> index a3e12a61d456..3ac760fcdc22 100644
>>> --- a/net/core/page_pool.c
>>> +++ b/net/core/page_pool.c
>>> @@ -536,6 +536,8 @@ static void page_pool_return_page(struct page_pool *pool, struct page *page)
>>>  static bool page_pool_recycle_in_ring(struct page_pool *pool, struct page *page)  
>>
>> Crap can happen earlier. Imagine that some weird code asked for direct
>> recycling with IRQs disabled. Then, we can hit
>> __page_pool_put_page:page_pool_recycle_in_cache and who knows what can
>> happen.
>> Can't we add this assertion right to the beginning of
>> __page_pool_put_page()? It's reasonable enough, at least for me, and
>> wouldn't require any commentary splats. Unlike put_defragged_page() as
>> Yunsheng proposes :p
>>
>> Other than that (which is debatable), looks fine to me.
> 
> No strong preference. Would you mind taking over this one? 
> It'd also benefit from testing that the lockdep warning actually 
> fires as expected, I just tested that it doesn't false positive TBH :)

Sure! I'll add it to the optimization series as a pre-req to more
aggressive direct recycling, would that be fine?

Other than that, it's mostly Yunsheng's 2 submissions (PP header file
split and hybrid allocation) I'm basing both of my series on. The
optimization series can go without the allocation just fine, but as for
the header split, I'd like it to go first, it simplifies things :D

Thanks,
Olek

