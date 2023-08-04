Return-Path: <netdev+bounces-24484-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B69770532
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 17:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98E3828278A
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 15:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4941F1804E;
	Fri,  4 Aug 2023 15:49:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36EBF1804B
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 15:49:34 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB46249EB
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 08:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691164165; x=1722700165;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Wfc+MYdmLoipgJyCyoCZUAT8oi3mkS80zhAz7vOfjhI=;
  b=knhWhpDbzeeMJXC1nRrNRkFbqiyjTPMhJ/LQgM3ASGVtZHN0+Fht7gAh
   63vJTgtkjD/9wvnt35zPjo057fQjyU0oxm1tjlJWyLLTVixP3wuV1vP3C
   Zn9Rm7t0tbZty+EHwYaLqpd94jBh4tjdT0wLGDTJQrHZ7pfVV3InDQDz/
   PukUo8SpRgy+TGxQYfV1I1eVeWzUuFU4b+Ajr6XqiqTmCQhxRJ/nFluSW
   mgIn52xli03TEy0ghfkbCROmBiyikAWH1Bx+eoElq9RZU6Vbai2XfcRi3
   ucR5cQRu/QXgSfjZtCGAy5Hqkg06ThPkOkDwiguUBl7Px2ko2zAbkpw8I
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="456560781"
X-IronPort-AV: E=Sophos;i="6.01,255,1684825200"; 
   d="scan'208";a="456560781"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2023 08:49:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="1060783185"
X-IronPort-AV: E=Sophos;i="6.01,255,1684825200"; 
   d="scan'208";a="1060783185"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP; 04 Aug 2023 08:49:09 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 4 Aug 2023 08:49:09 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 4 Aug 2023 08:49:09 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.103)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 4 Aug 2023 08:49:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nd2SVWPr9LbhYXCSAnoyxd127MCkIePv/FPbtMmKYqwuHfBIMgaKSqFGg5uE8MUaLuX0HpEIW/B5YpPL1dvWlOnlFjxZcil41g9xs6JM0xMxYw3XAZJKuZ7cvU0ET2bv9SfNdyJYbPcNwy4P30uJCo66Cll9gFCH9aS78fSnONIUJ6SjW0W5JfNRcMK93PgvMPguwwwtNQYscKpLMLDwWjNIylNs+qqIn3YpROrecOxmaInifU7gJs0R00ZpFd2iZxXEwUBrDc45CrG7FaPXEdjbz8gKNVx0JZwcDLWTO9L7XkTddTLd3u+JFWFplb8nvgcu546pTD6OsX1gpAzzCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EZhMQusbwaz8f+p+9WTnBnNWQlh1qP2X7DA4qQswAeU=;
 b=DCfm7epkyVo+S6NFbR7ViN9rkHqdsst6s6iM3B2qB6oB93o6whDb73EEWh8mMHn0RDWbUB+PQaNEdQdLfbFkQBE8KVMeOFoRaoQfcmW/Pbtu0KonkFDZCzsXwtKC3RXBHLS0F4VACZPipPNSQ/PofBiYA6NrbocpWbaE7ILkiOm8m95cJN7PWJs/qjj6QxcM2f4In67JsSaNUgAHNZ1FzQ27fltFtykqXH3L3Vau2fC8qHxN/M6g+FcUyAkoaURH8c04gtb8DaY58KRg0eZUQyDkPqur5iMayldeJz8V8tv8rOnJGva5YyTDgcBDPlL/wcgcq/TNAefS7tlxbbzpmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by MW5PR11MB5881.namprd11.prod.outlook.com (2603:10b6:303:19d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20; Fri, 4 Aug
 2023 15:49:06 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a%7]) with mapi id 15.20.6631.046; Fri, 4 Aug 2023
 15:49:06 +0000
Message-ID: <ec63946a-c28e-8b3d-0efe-47b2638b846b@intel.com>
Date: Fri, 4 Aug 2023 17:49:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC net-next 1/2] overflow: add DECLARE_FLEX() for on-stack
 allocs
Content-Language: en-US
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>, Kees Cook
	<keescook@chromium.org>
CC: Jacob Keller <jacob.e.keller@intel.com>,
	<intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>
References: <20230801111923.118268-1-przemyslaw.kitszel@intel.com>
 <20230801111923.118268-2-przemyslaw.kitszel@intel.com>
 <202308011403.E0A8D25CE@keescook>
 <d67257c3-6f3d-7b69-9689-6437f91a5858@intel.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <d67257c3-6f3d-7b69-9689-6437f91a5858@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BE1P281CA0221.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:88::14) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|MW5PR11MB5881:EE_
X-MS-Office365-Filtering-Correlation-Id: 57e6402d-d5b5-4ae7-cb01-08db9502557c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nmTMAQvYbJGg+1Re/kcTILCQEMaJmocnxDQ68dk9bTedUr3zcLoivLRDA604uqZDe6Q1Ni0sAukMtNn/hslR5o+nce0EMxnIumTDG6CVYWp+7Tf1ci1NSJH2tNItVv1aNMvS5uqhC79/21k7RtUEgwPxcIjB1ODdaT2efH5s4JJVJ2/BcQESFj728evWwQ4GDEFzv+BguGF1Wp0ScZBbv87/QaisaE7fgs9bqaRHUoFqFCx9HX3TpZGaEPUeLH27iGyzTM2OqLd8lVsZieHbY9i9NtpMTPBVtRlSfBi4gWRDl6XmspmbmMzBGDIdN3+LXOqANAd0wNL9nGfLrl/8D9tUh3uBBaUSm1wDY00YvpIIZh8eJ5m+jJH7YrH6EFU2Rl8vndJyQUrv3U9gD3t0n/PZHYtu1FcMysM31EzpNhzJHDVELgRMOZqX8Cbu37OjFEvq6BWtwodSTWTPCPtTb1hvORScERD8WRZB4GQSVtiRDCA0bBngcTlgm0PtNQ3rZ3Nfu3FAIOqAcp+0Cl0VBqnqE7BPn9DCd7d2UhIaslwLiVxrPilz8ttrqq8shDWb2pOKCE7J3/AOW70aPcC0ZQrrqRR7Nu8D0rqPjvj1/UtFkbGSyIbQ8ZGYbkjIutyzpCB/L8dDmecuomdw5Sj8aA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(39860400002)(396003)(366004)(376002)(451199021)(1800799003)(186006)(2616005)(83380400001)(53546011)(26005)(6506007)(8676002)(66556008)(2906002)(316002)(66946007)(5660300002)(66476007)(4326008)(41300700001)(8936002)(6486002)(6512007)(6666004)(478600001)(110136005)(38100700002)(82960400001)(31696002)(86362001)(36756003)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U3Z1eTNvZ3RReWsrTkp1SXdxbzNsNE9XVTlYd2twN3lpZDJCVVJyMzJxOFIy?=
 =?utf-8?B?NlpxOXlwbGxvSHVzQ2pNSVNQMlRRaGRUaWtsSm02TVpUeUZValFFTTFLeEd1?=
 =?utf-8?B?NFRkbjZTTGJ6U0xuZ0pRSmtkMzBGWWxJb2tkakVWejNRdi9YOG5tREk1RkNZ?=
 =?utf-8?B?ZWhEZENNcWRJaS9Od1FsOVBDdHRDZkxseTd2WHRGZEdOTExDeGppZjBOQzVR?=
 =?utf-8?B?RmdMalJndnlHL1JyVEtxKzNtVlRIUVdMSEJyVlVBY2trQ09STzIzUmhPcmZp?=
 =?utf-8?B?TlRNeThOcEd4azFiT3NrLzNuQzUvbVlIRzd2bWtUNEZ5bkQ4N3JPeEN3UnNx?=
 =?utf-8?B?c0xpZ0pwQlVEUHlEc1NZTFRzV3lkSk5vMFExNjkzZ3k3N3hGTWd0dHArTkx3?=
 =?utf-8?B?TUVEUnJYa21adEI5N3FFMVJ3cDIwNTJYRzd1amxKOWlUblB3SFZGeHFCQnAy?=
 =?utf-8?B?ZVlzcTBCTzBPeElXbjJJcEhqYWlzcVgwdmtKcTZSTnUxS3d6M0c2OVFqWHhn?=
 =?utf-8?B?d0lEU0Z0QUtFMzNRdENMTXk3L1oyZU1wT1g3L01uZzdrN0ZhSEdZbFRSaUs1?=
 =?utf-8?B?aC9GTHVBbkFpUFFPTGg5dG45SWVnY1RxR3Y1UTllSCtsNU5mNG5Wck9FamRs?=
 =?utf-8?B?dlZDUGJHdDBXRnNXOCsza0lseGtsN1dTNm5NVXMrSzVtR0hnS3N6NjdzRG11?=
 =?utf-8?B?a24rQnVnRnB2S1ZVeHlFdndvcjZyZ1g3dVZwajVIcnZIS2ZhUHVEK0NJMm5V?=
 =?utf-8?B?NHhsVkJoUUp0SFAzVDl3ZCs0MFFXc1lOdEtKc29Ucit5TWk4QXNmenZkcXhX?=
 =?utf-8?B?dnZ6T0RpYVdXUzFhN1lERzdPc0V2NkJkaVo2SnUraTZOKzc4Q2JXYStMT0FY?=
 =?utf-8?B?VWIybDI1Y04rcHpoUkdyM2JBTlpKZ2hmd2pHNy9yQjZuamJJeUNBc0Fjc2VF?=
 =?utf-8?B?Mml2MGhxbzNxT2pYb1FUcmlIdXFNa1BUR3lrd3pmK0dyTkQ2OFBWTitlYjFq?=
 =?utf-8?B?SHZ5Y0VEYXV0M0lCSTNscmFhbGl2NTk5aklUeGVsTUgvdC80aTZkai90Mlov?=
 =?utf-8?B?c0ZoUWczaCtDOHdNS3dVNUdOOVFNSnJhQ25seUNqQitKR1VDdkNkRnBvemto?=
 =?utf-8?B?OStleUZRUTk2THl5MjROc2dHRHM0Q2RqM2NlWThwSEozVGVYVi81eUlaWkRG?=
 =?utf-8?B?U0JhUEd4K2dFMnB2R3NtWTRFM2h2cFhDaCt0V1RBYTJSa2FKMmU3N2EvdTJR?=
 =?utf-8?B?YzU0TDgvTllvemtNZ1dpalZuZG8rYUhTdWEzMnJSQTJ4RzczUEpGcGdSOUhk?=
 =?utf-8?B?N3lqcXMzdmhWalRBbncwdkRSb3d6Ti9Qd1NNNEsyeTVUTmg4Q1l0N2pOcnpZ?=
 =?utf-8?B?MThpbVo4bktOUU0ybFpXYkZKZ293amhrbWxDTlFKVWlWQXRQdGtkTjY1R3Bi?=
 =?utf-8?B?akNlYytxZWtsc1VQR1ErMXU2Q0hqL3lmMkFDUWdVQnhadjU2ekNSdTRVakJm?=
 =?utf-8?B?aEc2WEE4WGxqNTNPR3J6MGQrRXpNbi9SRW1uZG5HZVN2SmhadHpjVXpaZkVF?=
 =?utf-8?B?cHZoTy82Ry80QnVHMjV0NmEvaWZZbXR2dXVPRlEzd1BaVWozbnNHRWFUQy9B?=
 =?utf-8?B?bWM3cm0vbENOQlhyNC9UVEhnODhCNHNqeFFWZ05VbXZ0NHN1YklQZSt3Nndn?=
 =?utf-8?B?MHk2STdOeEQ0UlY2SGNyOWRoYWxrbitpL1ZWZEhVbytoWnpLNHQyVXNyeTZQ?=
 =?utf-8?B?cFE3VGFsVWVVbkhwaUU2TlZYdGRoaU45YkZaOXNmN0x6cjJXemJLa0pHT0oy?=
 =?utf-8?B?c1BJZ2p1bkxaOVFnREk0ekxqV1lRa21KdlowRUF3aUhnUjJ4c1ZlWFJXcmtF?=
 =?utf-8?B?NnFHZ0I1cUF0Umd6bmROcjd3T3ZkYXB1bjNmVmlkOVp4ckYzaXNGb0FqcWQx?=
 =?utf-8?B?d3MvanV6SW9zbU1yQ0NJaE9TNU9LS092RFI2TytEdzA0bXZ5c2tKUXVFemFV?=
 =?utf-8?B?TnRGQVRDRlhVb3N0MnlpMUR1YU1CY3JPUWx5RXBOcDNMMDlWMEozdjBoaDgy?=
 =?utf-8?B?anVmc01BZXZXc0o2WXYzTnhnVGdET2REdlhoNTJOZVM3WGtvcTZ5U1VmZXBL?=
 =?utf-8?B?d1dCU2ZYcWx6REpRVGZRM3Z5MHVlOUd4L2NDL1lCN2h4eFU5UW9SdU1aTEdL?=
 =?utf-8?B?SkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 57e6402d-d5b5-4ae7-cb01-08db9502557c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 15:49:06.2318
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8VSvP3iGUigISMaKiugizAiT5+PwRNYOOrYzuYEswWGh7X1ZovFpuPkXzfiA0QfJwF70NJhqDf9ZClD4ejPKS5L7/udKq+pMd+UjIdGnCGU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5881
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Date: Fri, 4 Aug 2023 12:59:08 +0200

> On 8/2/23 00:31, Kees Cook wrote:
>> On Tue, Aug 01, 2023 at 01:19:22PM +0200, Przemek Kitszel wrote:
>>> Add DECLARE_FLEX() macro for on-stack allocations of structs with
>>> flexible array member.
>>
>> I like this idea!
>>
>> One terminology nit: I think this should be called "DEFINE_...", since
>> it's a specific instantiation. Other macros in the kernel seem to confuse
>> this a lot, though. Yay naming.
> 
> Thanks, makes sense!
> 
>>
>>> Using underlying array for on-stack storage lets us to declare known
>>> on compile-time structures without kzalloc().
>>
>> Hmpf, this appears to immediately trip over any (future) use of
>> __counted_by()[1] for these (since the counted-by member would be
>> initialized to zero), but I think I have a solution. (See below.)
>>
>>>
>>> Actual usage for ice driver is in next patch of the series.
>>>
>>> Note that "struct" kw and "*" char is moved to the caller, to both:
>>> have shorter macro name, and have more natural type specification
>>> in the driver code (IOW not hiding an actual type of var).
>>>
>>> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>>> ---
>>>   include/linux/overflow.h | 14 ++++++++++++++
>>>   1 file changed, 14 insertions(+)
>>>
>>> diff --git a/include/linux/overflow.h b/include/linux/overflow.h
>>> index f9b60313eaea..403b7ec120a2 100644
>>> --- a/include/linux/overflow.h
>>> +++ b/include/linux/overflow.h
>>> @@ -309,4 +309,18 @@ static inline size_t __must_check
>>> size_sub(size_t minuend, size_t subtrahend)
>>>   #define struct_size_t(type, member, count)                    \
>>>       struct_size((type *)NULL, member, count)
>>>   +/**
>>> + * DECLARE_FLEX() - Declare an on-stack instance of structure with
>>> trailing
>>> + * flexible array.
>>> + * @type: Pointer to structure type, including "struct" keyword and
>>> "*" char.
>>> + * @name: Name for a (pointer) variable to create.
>>> + * @member: Name of the array member.
>>> + * @count: Number of elements in the array; must be compile-time const.
>>> + *
>>> + * Declare an instance of structure *@type with trailing flexible
>>> array.
>>> + */
>>> +#define DECLARE_FLEX(type, name, member, count)                    \
>>> +    u8 name##_buf[struct_size((type)NULL, member, count)]
>>> __aligned(8) = {};\
>>> +    type name = (type)&name##_buf
>>> +
>>>   #endif /* __LINUX_OVERFLOW_H */
>>
>> I was disappointed to discover that only global (static) initializers
>> would work for a flex array member. :(
>>
>> i.e. this works:
>>
>> struct foo {
>>      unsigned long flags;
>>      unsigned char count;
> 
> So bad that in the ice driver (perhaps others too), we have cases that
> there is no counter or it has different meaning.
> (potentially "complicated" meaning - ice' struct
> ice_aqc_alloc_free_res_elem has "__le16 num_elems", so could not be used
> verbatim, and it's not actual counter either :/ (I was fooled by such

Speaking of __le16 (we already discussed it 1:1): it's not a rare case
to define Endianness-sensitive structures with a flex array at the end,
so for those with __{be,le}* we could be adding __counted_by() attribute
only when the host Endianness matches the structure's to have at least
some coverage. By "some" I mean actually a lot when it comes to LE
structures, which usually is the case :)

> assumption here [2]). Perhaps recent series by Olek [3] is also good
> illustration of hard cases for __counted_by()
> 
>>      int array[] __counted_by(count);
>> };

Thanks,
Olek

