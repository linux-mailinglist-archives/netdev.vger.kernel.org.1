Return-Path: <netdev+bounces-25643-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E22D774FBF
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 02:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FE382819F2
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 00:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84002363;
	Wed,  9 Aug 2023 00:17:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D75362
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 00:17:44 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 387841996
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 17:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691540263; x=1723076263;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QttN1hOgAWZwLXff/J+LNV0ouz6CeJYx4l3c6wCBFP8=;
  b=gQnpgsptGB5sSCAUidYrfQnLSl2ws8l1veEEvFDBOg53Kln6DhFVccSk
   0yVFaC2KeVw05DE9CwGKkDEwvFQxAQPv8tqIpboOQw06AazO6rNIZ8N3J
   As1UlRtKOrep0PbeSmVrnRg18M+VpmkPcgeUuH5mUJvQKCHAORLT+KZQb
   rPJQJKZEHLN5vAZkPA2f/GTCfF2eMSD0aWocOld7pwQUJ1BKoIMVzVS0u
   d/DftUTtp6pSYllfzrskdmwrp09337MfQP8ONIdiFWRJw/VovErtgt2XP
   iqVXbWYjo0ZIod8lu+sP6EwPbRqFX0M9ELtJjTXJWcX7SXkBXlZPxaTif
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="437351070"
X-IronPort-AV: E=Sophos;i="6.01,157,1684825200"; 
   d="scan'208";a="437351070"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 17:17:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="725152622"
X-IronPort-AV: E=Sophos;i="6.01,157,1684825200"; 
   d="scan'208";a="725152622"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP; 08 Aug 2023 17:17:42 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 8 Aug 2023 17:17:42 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 8 Aug 2023 17:17:41 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 8 Aug 2023 17:17:41 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.45) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 8 Aug 2023 17:17:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ggL+4FYakSfzNFm244ta9Fr7EQXbAg9PPFaviPCIG9Wp57S2kpDkiANEDt1rw1uAZ+g1M3wCXUA+Y0XW+57Fbd0zj/Amunac2qsJJYhfd5c2/hGDysTSnzjhXPz9S4uExw4cH+UGflirFPEa5+Fc/WKKHattjhzIuhq5Orp05ioKPoHuDJ6B8/y934F9aDqa+D7KxZHahguzD9CtSFqwjDZ7qlN3BzBC5iYnLJrzotfUo0Yh6bDq+U58JO4L/+0Eh2NZvf9MrilrbSsUESFueVxgqT0OXBp+WNMljGtfnbTrUCuiG9b1MCywIagozW1VvZDOqA8BIX75jHJJ162ScQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gr2NS6SVtyeYHHuMoQcmrS7dAawS4wp2pdSZO/AonVk=;
 b=IdTARxOR1le+kG0iSdUw6myoSy7pNaQXfrv4sUdNnKHVdw6GrM4+PItyxAyScWI0OCy5FiVgwVUVUzBSU66Pnybqd1YIeXqq19vBhRuGSsn6hpfseqzHL750es0eVBuAvIDbyPc8R9aqTehZzGFSI0PZHjP6qpnWDgFLdWYB1jOouEonVLYwpWS0AV0KA7eWMbiavd58ML6G1S6G8faMllR9qM9yoG8BuEvWx/7bqPwFvAGnF2Tq+w1NCww94DNS3mQ6NQfHOzqfrBZ8gANTL9yzjNqX2PeNFW2Dz5GklZsgPmb+mFYgiVMUPyiNo+Gt4Lj/l4biusIWp8Ugdw5t8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7869.namprd11.prod.outlook.com (2603:10b6:208:3f6::7)
 by DM8PR11MB5573.namprd11.prod.outlook.com (2603:10b6:8:3b::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.27; Wed, 9 Aug 2023 00:17:39 +0000
Received: from IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::12e4:637d:955d:a5f]) by IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::12e4:637d:955d:a5f%6]) with mapi id 15.20.6652.026; Wed, 9 Aug 2023
 00:17:39 +0000
Message-ID: <ac4374d5-0d39-c15b-15d1-f79c4c0ab3fe@intel.com>
Date: Tue, 8 Aug 2023 17:17:34 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH v1 3/9] netdev-genl: spec: Extend netdev netlink
 spec in YAML for NAPI
To: Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <davem@davemloft.net>,
	<sridhar.samudrala@intel.com>
References: <169059098829.3736.381753570945338022.stgit@anambiarhost.jf.intel.com>
 <169059162756.3736.16797255590375805440.stgit@anambiarhost.jf.intel.com>
 <20230731123651.45b33c89@kernel.org>
 <6cb18abe-89aa-a8a8-a7e1-8856acaaef64@intel.com>
 <20230731171308.230bf737@kernel.org>
 <c21aa836-a197-6c63-2843-ec6db4faa3be@intel.com>
 <20230731173512.55ca051d@kernel.org>
Content-Language: en-US
From: "Nambiar, Amritha" <amritha.nambiar@intel.com>
In-Reply-To: <20230731173512.55ca051d@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P221CA0008.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::13) To IA1PR11MB7869.namprd11.prod.outlook.com
 (2603:10b6:208:3f6::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7869:EE_|DM8PR11MB5573:EE_
X-MS-Office365-Filtering-Correlation-Id: eadc561b-0fb8-4e41-a351-08db986e0a3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0Ozb4yWBHP5Gt/dgwRDfgEyDaILoGWZJ1L2PQ6lO3SoLsydhspamgW4kP8UjB9bbDIFxGktMv9nN9bcBG1x3feVcUK1c1jQSxKYj0lYHHyPxPtWwF+EUl0aNm7Z8evoaRCy14a+sU/97tKTQkeu/TGnBnSpnKSqDWo3VVzAHXL4jOYiNeJgyALOucUoFIBPtiXzWL5WjKhqZFx+VHWNhH0HF/Gdu2BArSdjevQS6A1KQNf/27Oj4uPDJjYNo6t9dN+sqUsTOnjODtzP5BzlCruxhYzEm1K0b+kC7HOpmHri4IVjX7JubhqB4UG5d+pp+XZ+r3ykb7DZD8jnY5CP3JJq23t3DRkmQKQuuZVtbVWplvjBR3Fw1zPeqAWpuNYzL8W3i0/QF+8T66dSIpBdWlQbSV+w9twlr0WORPbsKCOVxFl3G8DwfuOgRwygyRzHuyWegyBbsIVG9b/t7tMQtMc94KYSJEByTZ+5JInudpkSieIvfklYReCPTxH4MZRJHo+GuDddJNU6s751Zu1GFzcUTUVjuI8ajE36wI7UjBmYSylDT4P1/1VcznqP23fbYUpubKXkUQuAjpnVJAbCY96bSLyNslV/4u0xrY89v9EFikoNmqcOjpc4Ev0dWgrGurMJKINWYtNMqgN/yDJqB9g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7869.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(39860400002)(346002)(136003)(376002)(1800799006)(451199021)(186006)(8936002)(8676002)(5660300002)(4326008)(316002)(41300700001)(86362001)(31696002)(6916009)(2906002)(6486002)(107886003)(6512007)(6666004)(6506007)(2616005)(53546011)(26005)(36756003)(66476007)(66556008)(66946007)(82960400001)(478600001)(31686004)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NFUvdDR3UXpCb0R4ck5VZ056S2VqYm1xYy9QaXNMeTRYU2xPVUY1Z1dqbHk1?=
 =?utf-8?B?YmxSaVV5cEtjbXBrMzJYTCt0U1dvQmNjVjRtYlhpY2ZRcXRkL2ZNK1dzbWJx?=
 =?utf-8?B?aGMrQThmRTUvQlJWUHlKVVJqNlBPTnlaTHMwSDREbUw0K3FUclFGTVRmK0VL?=
 =?utf-8?B?YnBkVXZua1pXb1VNL2JuNmFOV3hkTVhMWjZBakJtazJGK0pUbjZjR0tuQ0VD?=
 =?utf-8?B?YVFLTUhDS2M3dUZBdDlud0FyUWFFTDJaTkM1WnFYd04xYTByaTIzNWVVQVhO?=
 =?utf-8?B?NFRXR3p6YTA1eXpqcVB0bmpzc2o2bWZMZnY3NU5XVWI1Z3lDSjAvKzRNcVh4?=
 =?utf-8?B?RlBhTWNKQzlQOVlkUkpFVk1JTGNxU1Fva2o5Szd0TkFOTmlLamdOVTQzM1U2?=
 =?utf-8?B?OW5ndk5mclEvdmd0SkROTmdjVXFYcmxBMkQ4MVVnY0RuanhaVlFrOFJTaVls?=
 =?utf-8?B?VUFqQUtWeTVlYTFJUndNZk9Za0cxM1FhR0ZyVjBHZVFoNEtDcGF3YnBhNE81?=
 =?utf-8?B?d1RDYlZyWm50M0toTzFxRm00QWdhMDg2bmIvWmxCRG4xenJnalVBT2J0R1FL?=
 =?utf-8?B?YjJ3L0tpSzBObmtTNEZOa0kxRXRoSHJUQVhUY2orZmVDVDlnSW9xZmtpMkgx?=
 =?utf-8?B?MTBnaFNHcGRZNkN6anRwZ3FGRE1RMW9MVUdWaGNFK0c0Z3JGVzRab0dRVnRU?=
 =?utf-8?B?Y0N0RVBQanp2dHhsZWFhSytjRTRaUUdMVGtjUmpjb0pCY3hIb2xyWVY3RG1u?=
 =?utf-8?B?T1MxdmFpeWZaZHFHN0NJSUFWQ1BxekRRVHV2ZnVSaG93Mk9ib0h2NUY2VWdT?=
 =?utf-8?B?akxNNXAzT0xrMEhQUXBPZTR5OXJRNXczZ2dTckdtdjZwV2xQMHJFU2VBZS8w?=
 =?utf-8?B?NDdsL0J6UGU3aHFmc1R2dUpVQ0J5REoxLzkwMDBUYVc4WWlYUlhOTnQrM2xk?=
 =?utf-8?B?K3pDbm9YNzdFdGN3cll6WFhqMkV6UWNOa2tFM1NJVDZBR1U4ZE1rSXErSFFr?=
 =?utf-8?B?d1ZvVkFIOCtTbEZJd09PQU41NHdtODlROFpjYW1UMUR1NGYyZmMrWXBuMjlV?=
 =?utf-8?B?Uzd3dDRxL05IR1FvSCtMd2Z6YkduV3hVdkd4R1ppU29PQTlRa1ovR1dNMXYx?=
 =?utf-8?B?SXA4b3BZNDJSYUpETUo3NVp1TnZvd3hBOW1XaVFZdTJQaDJQQ2tMbWVsYS8x?=
 =?utf-8?B?Z296NVYwWXFqSzZReFljT2s4K1F6dHFYZGtNTVJ4ZklXWWFCVEh5dklkV0E2?=
 =?utf-8?B?QkVLWS9ycmY1MzFBNjBvaWZuc1RMWjlXeDJiMG1zUG5oUlREVTRnaThFaG9t?=
 =?utf-8?B?S1g2b2NvV0VZUTh5WkRjTFRHOG1BL21IVy9ENnBqc1RCTFB4QmF0SWpla1Br?=
 =?utf-8?B?Z0xpMm1EUDJJTUM1MW1obnhKK09tRjgxM1Qvak5FeHFyb0h2R1JMQ3FGMGpY?=
 =?utf-8?B?cGwxR2ROOXJSU2l2VGp0REx2Yi9GRXROSE52clkyZWVScDNVZnE5bWoxbFho?=
 =?utf-8?B?VTAwSEZSaEZJM0J3azMreUVDNFpFV3o1ZUt4TWlFYTJ5aFUxYVQ5S2t6aHZa?=
 =?utf-8?B?V1FCeWlvazNXekxPMWYwSDR2MTFSL3JtTWhQcjIraktZZ3lPZVlBRFNaM1ph?=
 =?utf-8?B?UkVIaS9HTTE4Yml5U01FTzhVMTFTMFhNMU1UZDlVZXRDV1hvcWc4UEhqaWdP?=
 =?utf-8?B?U1pYYlRGN0gwMEFuUU1pbU1MakwxelZ2UlhIZk5KR1I4NndGUzN6UytxYXR3?=
 =?utf-8?B?Q1F2UVpYY2tzNGxRYTFyQjZFVVowNEtRUnhRZ21UeitqWFh0bGJkWWRHT3Bk?=
 =?utf-8?B?aktwbnFHOTd5bS82TndtTWliTGtrRzRUTGtMS3JyNzBZc3dabGwxMXZ0bE1m?=
 =?utf-8?B?a2FmV0xoN2svTjVQVU5icjkxQXhqTEU0WCtxOGhlaDdTcGZ6SDR4VVcvSDZr?=
 =?utf-8?B?UkozMFRjVEIxMW42RTUvNE10N2taRTV5RWp2MGVHYjhheFBZRnNlaktsSCth?=
 =?utf-8?B?MTdVQTgxdWlHUE9NM0d3aUFtdWY4RHV3YXZoMHB0UGR6Y1lRTjlaNERvSWZy?=
 =?utf-8?B?QVZrZ0RDSWNNYk1BR3c4aWFaZmhuOE14c05WUGFneVJpd2VaU1AxMnh5Vzhi?=
 =?utf-8?B?TWlSSXpGd2hmSENHOUFPWWF0Y1RmZFJ2Qi9LSk0weTlUMDVHYUplZ29WRG9l?=
 =?utf-8?B?OWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: eadc561b-0fb8-4e41-a351-08db986e0a3d
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7869.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 00:17:39.0573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YIvABM+5YDaaw2OBQAokEwlpL84RxtGU6fsXzuwIgjyfqYlIVJHriZV1B9sNufM4SWMAwLfsW4nQk/HFjgrF7S8BeI0USpowDBQ4ZUHZW2Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5573
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 7/31/2023 5:35 PM, Jakub Kicinski wrote:
> On Mon, 31 Jul 2023 17:24:51 -0700 Nambiar, Amritha wrote:
>>>> [{'ifindex': 6},
>>>>     {'napi-info': [{'irq': 296,
>>>>                     'napi-id': 390,
>>>>                     'pid': 3475,
>>>>                     'rx-queues': [5],
>>>>                     'tx-queues': [5]}]}]
>>>
>>> Dumps can be filtered, I'm saying:
>>>
>>> $ netdev.yaml --dump napi-get --json='{"ifindex": 6}'
>>>                   ^^^^
>>>
>>> [{'napi-id': 390, 'ifindex': 6, 'irq': 296, ...},
>>>    {'napi-id': 391, 'ifindex': 6, 'irq': 297, ...}]
>>
>> I see. Okay. Looks like this needs to be supported for "dump dev-get
>> ifindex" as well.
> 
> The main thing to focus on for next version is to make the NAPI objects
> "flat" and individual, rather than entries in multi-attr nest within
> per-netdev object.
> 

Would this be acceptable:
$ netdev.yaml  --do napi-get --json='{"ifindex": 12}'

{'napi-info': [{'ifindex': 12, 'irq': 293, 'napi-id': 595, ...},
                {'ifindex': 12, 'irq': 292, 'napi-id': 594, ...},
                {'ifindex': 12, 'irq': 291, 'napi-id': 593, ...}]}

Here, "napi-info" represents a list of NAPI objects. A NAPI object is an 
individual element in the list, and are not within per-netdev object. 
The ifindex is just another attribute that is part of the NAPI object. 
The result for non-NAPI devices will just be empty.

I am not sure how to totally avoid multi-attr nest in this case. For the 
'do napi-get' command, the response is a list of elements with multiple 
attributes and not an individual entry. This transforms to a struct 
array of NAPI objects in the 'do' response, and is achieved with the 
multi-attr nest in the YAML. Subsequently, the 'dump napi-get' response 
is a list of the 'NAPI objects struct list' for all netdevs. Am I 
missing any special type in the YAML that can also give out a 
struct-array in the 'do' response besides using multi-attr nest ?


> I'm 100% sure implementing the filtering by ifindex will be doable as
> a follow up so we can defer it.

