Return-Path: <netdev+bounces-31029-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A3F378AE72
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 13:07:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95D8D280E14
	for <lists+netdev@lfdr.de>; Mon, 28 Aug 2023 11:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F06211C8E;
	Mon, 28 Aug 2023 11:07:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A496116
	for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 11:07:27 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C9CC5
	for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 04:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693220845; x=1724756845;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UHSgbN5MjuNcWNkXiKe06FnyWgljS2O8BCnFP6oCm8Y=;
  b=APEQLTOkr+PMAWjKBEqhHPZ25wrv0NugOYC4sPnd9SheWK6+nsSRRQ2R
   eflJemqQZngLWmSEePJbMXQOeOv+LEohVl8OgPyTyQlQv85RECjQ4x4Zq
   y5bKJL8W1YaiCn6a1tbHS4jhhU9vQBF8mozXC9O0VBM59Dbo3RSkxDJek
   HvFL+Y+CNJVhkQCOglIEARQfVQgcKIJger4hmqqSTqiKZU1wil+TIStKX
   BHjHAfYyCRpvfV+3ABbWWKcHjRfYgvzeMoknIZSQmIv104BJNPqWUbLX4
   9D9LEU8gOzMMHGDhFJ9kOFh05x4MqDUGkqhFfnfD6dJvprTfdxq4YEGUW
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10815"; a="372480993"
X-IronPort-AV: E=Sophos;i="6.02,207,1688454000"; 
   d="scan'208";a="372480993"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 04:07:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10815"; a="912016763"
X-IronPort-AV: E=Sophos;i="6.02,207,1688454000"; 
   d="scan'208";a="912016763"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP; 28 Aug 2023 04:07:22 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 28 Aug 2023 04:07:22 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 28 Aug 2023 04:07:21 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 28 Aug 2023 04:07:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nTHZUQhijYIhOtPQM2zMeU6WAIh7FPyzopZTVQz57SKT5zhjpOBlz5t3k6PBT9QdeAOmZNfLUasK4UioEgmvKqC0IECwVMX7Kl0L/C09xFI5SfPojq3KtV+cKKLILl1BQvjL0eBZHShCNMSOX8S4duI8/9nafaGtkm4qpb+EcjTAkFpX8bcU/8L4y2WBilURK7ITCQaEa97htqTEJ3eVBnGSgep9pmtoEKvDwoUKasqwLSWDb+u9zMMy21I5HmbgL4ofoT5FTL1JCg0JeGz5s6KlnGSpIX9g/AzLwKxw6Egwzkl1zkRg1ktv/aC2xA3htXaRNeuvCR6dhWS+kSfsgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7WQ0eNylFbYETX0wvGA/WmnWY3YJ+Pl8CcKrZH9WE+E=;
 b=NrGMiT01xXVf6JcJNY+SMlqu+KuL+rclRW4Dxn+tWi4n9/h7doOZvitACbABSamJ5GodQSdDTZitkxTiLcHL8pGIvWOGONTfuoz3ZjsEKSOZ4FsTayGmCi1CyhM8xmzoU4KBJyVCFXe8OxFDb0G1Dbm83t7MhFtsf2WZMHT/9gWP0dMfDc1PIlpt+yz6omVFdcwD7+pnEJ6Apef7YsVt14Cxn2Ii3aQaAdaZgf8Z/2hqJuXJcxuC3LbNTHFHawFf0zZQPQPJ/AghbFSNFOhgSNaLLJBcAo3no4iYVPS/HA7xSI32gCBCsPg3vMNVXiRwTp7DQxqJRWEUnKncfGObLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by SJ1PR11MB6155.namprd11.prod.outlook.com (2603:10b6:a03:45e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 11:07:19 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::bede:bd20:31e9:fcb4]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::bede:bd20:31e9:fcb4%7]) with mapi id 15.20.6699.034; Mon, 28 Aug 2023
 11:07:19 +0000
Message-ID: <d1f43386-b337-db94-7d9d-d078cd20c927@intel.com>
Date: Mon, 28 Aug 2023 13:07:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [BUG] Possible unsafe page_pool usage in octeontx2
Content-Language: en-US
To: Jesper Dangaard Brouer <hawk@kernel.org>
CC: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	<netdev@vger.kernel.org>, Ratheesh Kannoth <rkannoth@marvell.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Geetha
 sowjanya" <gakula@marvell.com>, Ilias Apalodimas
	<ilias.apalodimas@linaro.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Subbaraya Sundeep <sbhatta@marvell.com>, Sunil Goutham
	<sgoutham@marvell.com>, Thomas Gleixner <tglx@linutronix.de>, hariprasad
	<hkelam@marvell.com>, Qingfang DENG <qingfang.deng@siflower.com.cn>
References: <20230823094757.gxvCEOBi@linutronix.de>
 <d34d4c1c-2436-3d4c-268c-b971c9cc473f@kernel.org>
 <923d74d4-3d43-8cac-9732-c55103f6dafb@intel.com>
 <044c90b6-4e38-9ae9-a462-def21649183d@kernel.org>
 <ce5627eb-5cae-7b9a-fed3-dc1ee725464a@intel.com>
 <2a31b2b2-cef7-f511-de2a-83ce88927033@kernel.org>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <2a31b2b2-cef7-f511-de2a-83ce88927033@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0161.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::8) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|SJ1PR11MB6155:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bc7ec6e-3505-46ac-9cc3-08dba7b6f227
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0tZpvWkU324rD7jG/4apM7fYDSFURA3WVgkThBuxXScpvV/qANZdLP96IBHVrp6c62u589WBj4lGmVD1/LpRdqC1xdQORNhhzQiCIINyZvAUsyMdQkpxbJR0g5NpsERoufoINqOIeZjGtMaL+8ml2NnTBB0LF+/Wx/EADJVAxP/6E1dOEpgvn4Ly47QRJ77129GBtl+ZHQ2fcya6T4vn9KrOz21/Yl35CeWnXXbbGJCXiIEjCtt/49ZwSZWMbcqfDYPDKIVE/TezS/KOECAjjoyUiSYVz6HQkpLbPA6wFOsReTdJFavhiZg6dbvcGoPWpgVL5pH4bqYCG6auFQoQk2yb3Oyq3gdTSi4S2AZ6pGz4gUZWIUXgRjDtVkymIlQTsvLhCgpdoLYHvnCkr/UhmphOYp0gGX0bNKfqvW3K8Vmo4Z9kF9vUIi1bDlIjhkBdv/t3HiVKi6sZBSbOy+uCR9qHWwcOuEPPxgr21tnEkV/pPrhRZkiA9RgPT41mKs2ST2fR+l2HFjU4e2awuvm5xodH7l6ZjIYd6OiEQSLuuaryps9FPpbEHkssFXbYjY2tnMxpTMHrHR8UnVFdbiluhciozWjsjA43xkxQMUqaTh+eY/0cb3SOVW8+sHpQrui4LAn1ZUHxZTQrXCxxyE/EgQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(346002)(376002)(136003)(451199024)(1800799009)(186009)(8676002)(8936002)(4326008)(2906002)(6916009)(36756003)(316002)(54906003)(66946007)(66556008)(66476007)(5660300002)(31686004)(7416002)(41300700001)(6486002)(6506007)(2616005)(26005)(6512007)(38100700002)(82960400001)(478600001)(83380400001)(31696002)(6666004)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGlDRC9tczkwRHlyZVAvR05RbE1LZ1crelRZZFF1dHJUVGtlaElJb1VMWitH?=
 =?utf-8?B?RHBaSGVEbW5VRitwOWNTcFpHaTFUV05MZ2FTNy9nNk5CSHhKYUk2ZlZ3NTl2?=
 =?utf-8?B?TVVPVjJMODFxV1VEL2dLU1VmTjJnU1h6aGRYMERNKzB4K2UrK3FkT3J0amc0?=
 =?utf-8?B?bGtKeGhIU1p3VG5jNUNSdHhsdUVvVjF6cVExTU9uSnpsc0wvdWZHNHIvZWNq?=
 =?utf-8?B?YzI1VWpwU0MzVlRrS1YwVmRsR2l1L1VxR1JRSDVlQmtKdTdoU2piU3UyYWhR?=
 =?utf-8?B?Rm10NDdYNmMzNG1MRlR3WldheHNCSzZkVE1aSnRUT1VPTkZHZkZsakszUlMw?=
 =?utf-8?B?aE9HcFJtd2pLbGpFQlZROXF6dHBWcFdJcnc3N0Z4Zk5WM1UzV2xObGplTUts?=
 =?utf-8?B?MnJ0TlY4cUhnbzVLTzVhVVVya2FBVVFYL2NDbFpEK2VRSmc5ZGcwTXF6LzZT?=
 =?utf-8?B?RytSYUhkQWFqdDl5U25XNWtkeWEralNpWEJ3dGMwZXJ4ak9yZU81Q1RRQUlF?=
 =?utf-8?B?RkhQTFRwMmFycTNHcjJPSUozSXlldmhCQ1liRGJldC9xanhXK0h5Wk5aTGhl?=
 =?utf-8?B?TFYxQlY3SkdXTFZPS2NHeXhKQ2JGTWJ6K3R5T2tyT3dwWWh0akt5RVplaFZj?=
 =?utf-8?B?dUpQWk9QbEd3dXowR0ZQUUErcG1oc3U4NkJEUUFXVktqWWFpZWRJRGFteWtr?=
 =?utf-8?B?bzZkd2JCNzcvN0JvaUtReUJGSnE3blI3RXl0ZTdxeE1PUjlCQ1pHOHhoY3lq?=
 =?utf-8?B?TGFnRjErWis4NGNZN2lsZkFQNS9hUnUxbFhZczJkbU51RUVDcUdLSmwxYnA3?=
 =?utf-8?B?bVJhSVdYT2JUTGQ2UHVvdkVtUFN0cFV3VFR2aUo2eEd5MVdmc2UzRlRndzFh?=
 =?utf-8?B?YURWTWJtbk03K2RtR3ZrcnFuODdwZnFKUUlLdG1tYk5QZFJsY0MzSjNqZWRC?=
 =?utf-8?B?cmRqVGJmR1FOZFJVdks3V01qcWZhQWJaUmNaOVRrT01GSWlOQmhUWFpGdi9Y?=
 =?utf-8?B?dS9nck1xUVpNOVNxc0RxVmQxcDJSRkVWN1FaNkhlUFRKS1VhVFY0VERRVy9N?=
 =?utf-8?B?ZWpPeGl6OHlybTgvZlQrQmUvVWJLVmhlQUczMG5QZ0RBVDhDcjVmQ08yMnh6?=
 =?utf-8?B?M1c4eUZIYThTelVVQUNpTnRGZEFoVXR1WFMxYStnK1RLLy9JMGE4MUowVjVK?=
 =?utf-8?B?a0docy9yZDh2WWhqbEFlYUJPQ2c3WE82enkrVTZWTmVyRm9PTEQ5S2xQdUdh?=
 =?utf-8?B?NGF5aHJJdHdFUjZKSWZQNjV6dU1vS0g5c0xSMG5PVHJ3eE03R2dhbGgrWVYy?=
 =?utf-8?B?ODUwWGRESnFvdXhQR1dnYk1taWwrZlprUVAvckhDaml3K1J0cElzR3VGWW9Y?=
 =?utf-8?B?RWh4VHVRTVZVSEZiTXB5eWY2MkIrUUx3M29sRDBsWFVWMHBSQWpxemdTVnZW?=
 =?utf-8?B?cTVjaFdlaFhOZ3NLblY5cTh0NjhmV29Kak1TbEFjRDIyZVVWMDhsWlBxdWQ0?=
 =?utf-8?B?bFJFaTJWYlZoQ1NCRW1ySDZBZEJRcnFoaFd0NHNOSUFBTGUvbkFRbDNEOXVJ?=
 =?utf-8?B?OGRCUTRmSklSNU53T1k3aUN2c0l1Z1RHUXRXL1RuV0ZYTWpYcm5iUlVlSElN?=
 =?utf-8?B?VFo4YjJUODFia3ZTN2pjMDIvTmxHcFlvOHFZU0NnZHc2cVMvVm0weUVpUGRG?=
 =?utf-8?B?OHpGcUxIaXlOd2JFTURzYW5LWjhTTjVqd1pUZDc4UUFCK1RHYnNiZTcwVm94?=
 =?utf-8?B?SXg4MHEzWXVRbyt6eUNpTkg5WjdMZy9YQUkvcnRVRlkxWmxzL2NuMHgzWDZa?=
 =?utf-8?B?MkV1SW1OOVQ3SkpBZ28rZ2hKL2NRQzZlTGhCTWYvZzgvNjI5c3dlSVlhT3Qw?=
 =?utf-8?B?TkRZQUN0Ymx1VmIzc294Qmt2VUlGMktwSjVvbnZMMGp5YnQ1dEZ4MklhcTVR?=
 =?utf-8?B?Nll1bEsrMVdhY2djZzBCNEtvV1o4dnBWRDFqcitwTUdnTXVLWmEvVnFHclVQ?=
 =?utf-8?B?Q05sZEtsSVc5K0FiNWg4enNyWllvUkZiUkd2OGlVeWJCTUowU2RSdWhoeUFB?=
 =?utf-8?B?ZEJVRVd0WHVKamJ4eVZZdjJEL2tIWVEzUHhqR0xIODN1eWg0UGxVWUkvZFg3?=
 =?utf-8?B?SjhYU1diZEJEekplcjFFWENrREdnQU0xdGR6RC9NV3V2K1FOQnlSMFhsanR2?=
 =?utf-8?B?WkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bc7ec6e-3505-46ac-9cc3-08dba7b6f227
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2023 11:07:19.3557
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wH21b86Mplbj8e7eOyoFH+AdTiNiAmBLsUW59RxP4f6Qs/AdW+dqe4ilUJ0FbGH7J8tH6gdA6mawNbFhpsLZ+qI6RTxo+gamZYqO5/Hb3PI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6155
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jesper Dangaard Brouer <hawk@kernel.org>
Date: Fri, 25 Aug 2023 19:25:42 +0200

> 
> 
> On 25/08/2023 15.38, Alexander Lobakin wrote:
>> From: Jesper Dangaard Brouer <hawk@kernel.org>
>> Date: Fri, 25 Aug 2023 15:22:05 +0200
>>
>>>
>>>
>>> On 24/08/2023 17.26, Alexander Lobakin wrote:
>>>> From: Jesper Dangaard Brouer<hawk@kernel.org>
>>>> Date: Wed, 23 Aug 2023 21:45:04 +0200
>>>>
>>>>> (Cc Olek as he have changes in this code path)
>>>> Thanks! I was reading the thread a bit on LKML, but being in the CC
>>>> list
>>>> is more convenient :D
>>>>
>>>
>>> :D
>>>
>>>>> On 23/08/2023 11.47, Sebastian Andrzej Siewior wrote:
>>>>>> Hi,
>>>>>>
>>>>>> I've been looking at the page_pool locking.
>>>>>>
>>>>>> page_pool_alloc_frag() -> page_pool_alloc_pages() ->
>>>>>> __page_pool_get_cached():
>>>>>>
>>>>>> There core of the allocation is:
>>>>>> |         /* Caller MUST guarantee safe non-concurrent access, e.g.
>>>>>> softirq */
>>>>>> |         if (likely(pool->alloc.count)) {
>>>>>> |                 /* Fast-path */
>>>>>> |                 page = pool->alloc.cache[--pool->alloc.count];
>>>>>>
>>>>>> The access to the `cache' array and the `count' variable is not
>>>>>> locked.
>>>>>> This is fine as long as there only one consumer per pool. In my
>>>>>> understanding the intention is to have one page_pool per NAPI
>>>>>> callback
>>>>>> to ensure this.
>>>>>>
>>>>> Yes, the intention is a single PP instance is "bound" to one RX-NAPI.
>>>>
>>>> Isn't that also a misuse of page_pool->p.napi? I thought it can be set
>>>> only when page allocation and cache refill happen both inside the same
>>>> NAPI polling function. Otx2 uses workqueues to refill the queues,
>>>> meaning that consumer and producer can happen in different contexts or
>>>> even threads and it shouldn't set p.napi.
>>>>
>>>
>>> As Jakub wrote this otx2 driver doesn't set p.napi (so that part of the
>>> problem cannot happen).
>>
>> Oh I'm dumb :z
>>
>>>
>>> That said using workqueues to refill the queues is not compatible with
>>> using page_pool_alloc APIs.  This need to be fixed in driver!
>>
>> Hmmm I'm wondering now, how should we use Page Pool if we want to run
>> consume and alloc routines separately? Do you want to say we can't use
>> Page Pool in that case at all? Quoting other your reply:
>>
>>> This WQ process is not allowed to use the page_pool_alloc() API this
>>> way (from a work-queue).  The PP alloc-side API must only be used
>>> under NAPI protection.
>>
>> Who did say that? If I don't set p.napi, how is Page Pool then tied to
>> NAPI?
> 
> *I* say that (as the PP inventor) as that was the design and intent,

> *I*
> the PP inventor

Sure I got that a couple years ago, no need to keep reminding me that xD

> that this is tied to a NAPI instance and rely on the NAPI protection to
> make it safe to do lockless access to this cache array.
> 
>> Moreover, when you initially do an ifup/.ndo_open, you have to fill your
>> Rx queues. It's process context and it can happen on whichever CPU.
>> Do you mean I can't allocate pages in .ndo_open? :D
> 
> True, that all driver basically allocate from this *before* the RX-ring
> / NAPI is activated.  That is safe and "allowed" given the driver
> RX-ring is not active yet.  This use-case unfortunately also make it
> harder to add something to the PP API, that detect miss-usage of the API.
> 
> Looking again at the driver otx2_txrx.c NAPI code path also calls PP
> directly in otx2_napi_handler() will call refill_pool_ptrs() ->
> otx2_refill_pool_ptrs() -> otx2_alloc_buffer() -> __otx2_alloc_rbuf() ->
> if (pool->page_pool) otx2_alloc_pool_buf() -> page_pool_alloc_frag().
> 
> The function otx2_alloc_buffer() can also choose to start a WQ, that
> also called PP alloc API this time via otx2_alloc_rbuf() that have
> BH-disable.  Like Sebastian, I don't think this is safe!

Disabling BH doesn't look correct to me, but I don't see issues in
having consumer and producer working on different cores, as long as they
use ptr_ring with locks.

> 
> --Jesper
> 
> This can be a workaround fix:
> 
> $ git diff
> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> index dce3cea00032..ab7ca146fddf 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
> @@ -578,6 +578,10 @@ int otx2_alloc_buffer(struct otx2_nic *pfvf, struct
> otx2_cq_queue *cq,
>                 struct refill_work *work;
>                 struct delayed_work *dwork;
> 
> +               /* page_pool alloc API cannot be used from WQ */
> +               if (cq->rbpool->page_pool)
> +                       return -ENOMEM;

I believe that breaks the driver?

> +
>                 work = &pfvf->refill_wrk[cq->cq_idx];
>                 dwork = &work->pool_refill_work;
>                 /* Schedule a task if no other task is running */

Thanks,
Olek

