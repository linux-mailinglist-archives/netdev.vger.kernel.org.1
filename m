Return-Path: <netdev+bounces-30686-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC9C17888CD
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 15:40:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6E4E1C20FE6
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 13:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B5FDDC6;
	Fri, 25 Aug 2023 13:40:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1574E20E7
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 13:40:44 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C78C4212B
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 06:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692970843; x=1724506843;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SYKy/XLEH3A85ejBl00ijJo6p5UQzvBY6sXGa2NRxY4=;
  b=NTZkNrrRE/AwuOsiCk59BZ8/TU5iyg6eJB6MpeK3WywR/+HMRsFZr6c6
   RLodPPUvzTSup+Pb8Q4mttSD6rx5GZ2S7fFsWgfBxLBKMVmhVEEh94OuJ
   Kk/efEb79wSTL5kJCw44GVT9tWu+Pm5fGxpIAjY7PoUlcJmQjRQL4lfzc
   nqNFKNxNrP3G64nSPgnxcLGyQ+huIaTiLzXw0XjNOXECG1qn4TVSXsr/2
   ty6pShJF0T6WoRS5eDepEkMjzL26S5ul9tL0J8YtHLI9Y2ss7+0nQXldZ
   1rYJ/NxLxILUedu59e1Thsh4SJpD2qs5Dqp20x8sj3+sq+dLfv8rK+y5O
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="441063489"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="441063489"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2023 06:40:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="802970380"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="802970380"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga008.fm.intel.com with ESMTP; 25 Aug 2023 06:40:42 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 25 Aug 2023 06:40:42 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 25 Aug 2023 06:40:41 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 25 Aug 2023 06:40:41 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.45) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 25 Aug 2023 06:40:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EcCwHgJsYJ9cLWvi7kQHnSN0UMIwW2TeWv2lnmSHdu/TDAqV2kJuUAKrN+R2vxbemQKbrrfPIThgjVK5H10hkwf3LVAHPtEBELmu5lIvYgu4/s3cwBdFTO2LlnOmeick8w1lqsoa9ISwbhLtgnvydFPxTxJpDRYGvv3kn3KD4D5sOq4tkEgMBdjB0GwwIv7flbkF3K4rozcP7PFkbeCU82NO84i2ZN1bgOtrJF+94VMtpLi2Quqf6Gjx3ZOfjXxf2HFff6JULXKDvlmcDCme5ayUro9LiBdVHBs9YmRm0eEj2e7gDO0wHmlTp5V6yoCYAqYiSCxJqigX6IAin0oI0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wfy7clcTQtEAPL52e1+nVRQ+la3n53w9iJZc7N38qqA=;
 b=iuFGgcQP3ksaOV6ZxFA+wVP8VqwQ97ert9NXmOoK7b0+W91lhjC0YbyDWNgJJ5PE2xUYBYTM4dT50Yw7YRI97csOe9R7ylhQngxPF4sy2LoRenl64M+keR/5GBvuD2HPt7dJf9FJ+RSzR8vIfwokGzhoCJdk4236FAnDMwKkRJ76gVWeWKJVZ44w13L571SaoujnlPc//9nWRD9T07MgSvQZZI5HpGpV4rvAMYMTOS0lvHsrhQ998qTQb+lq1P77u3vqrsNSzIseYFSxSOdiNPLMAYtWVkdCkQ1sp2ZL35gV3BAR6ceHajuSwFeKFw+rgJ9FB9xTwcS2+i9+eJeHDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by SJ0PR11MB5087.namprd11.prod.outlook.com (2603:10b6:a03:2ad::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.29; Fri, 25 Aug
 2023 13:40:39 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a%7]) with mapi id 15.20.6678.031; Fri, 25 Aug 2023
 13:40:39 +0000
Message-ID: <ce5627eb-5cae-7b9a-fed3-dc1ee725464a@intel.com>
Date: Fri, 25 Aug 2023 15:38:54 +0200
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
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <044c90b6-4e38-9ae9-a462-def21649183d@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BE1P281CA0100.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:79::11) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|SJ0PR11MB5087:EE_
X-MS-Office365-Filtering-Correlation-Id: ded4107d-5a70-4cab-7f60-08dba570de64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7xi5cpRDDIH59Ne+tAYi1HMyg1iriwNto+jlbcQPK1xkrXf2bm4YEhTy/ao7Bwz7gd9+wEuoJSYsb2Y00KHArA4cmgk1+XsbHZ5zHvT2n1JA3BjW9dHehWnNjg2X33iuJZglaAyYnAxvThnibu20TCyTRnEUyuETskFb+n2y62lgvtKEcavONUg/XaGlxFplG2kP/XYClnW/ooSJgzzNg//ccNChw1XSoq2S2Gu+7oarWtCpAwTRtOgShsEhxn4ysWg4P7WUAfSQYYhAL//9VyMbnVeCH6TmyGteyatYgnvrCSCFmLS7CbyODAL0KTtaNFEmhvoBGf1hYTHmPUWS/wXp2rCXyQRxd2nt5quBG3L2MQq3K10vN43jIVXx8rp/N1W/mjGnj0iod7new7mlgm63/49zzC8YRSL4esXW3J9JQBDW8RakpNt/iCnIb0e6H/DJF8isaW2jmZt3iOqkmqBhLIOQG/Q2XjOB8xSmNzrA/InMWXwImu6nqbfXl5wbxbEiuFGm1ib0dJU5rBfXHOFoqVR0m0x+nMJtPTEOzjDertIHpibm28n3oHnmfjwYqnW0oh9cuXjEDTh/Y0qgrC/1d+ZnEUoRxDHd0p5BA9QxjloENs4Y/nQBWb+MZjw29pwBHYxsDeDNO2tjgFxqjg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(346002)(366004)(39860400002)(376002)(1800799009)(451199024)(186009)(7416002)(83380400001)(6512007)(478600001)(26005)(2616005)(5660300002)(31686004)(2906002)(8676002)(8936002)(4326008)(82960400001)(38100700002)(66556008)(66946007)(66476007)(6916009)(86362001)(41300700001)(54906003)(31696002)(6486002)(36756003)(6666004)(316002)(6506007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aU5lU3ZRMDljZVJnekd3RzZnaXlIalN4eVY3UEJ6WHVVbHFFamJ3YkJSWC9v?=
 =?utf-8?B?NWhDQWpUdnJsL1FVMHNvSFkwWnkwb28yTFNoTGthdXJIMHU0blhKL3A2WEV0?=
 =?utf-8?B?SVlhUk1lSThuRnJDRmpBSndPZHZCTzh4N2FYY3JrM3Zta0lQRjEwNTJTQ3ht?=
 =?utf-8?B?a0FCVjhFZGhOOWRaMUN1Rjc5V1ZUQ3ZvSmxYc2N1enRuQU5vV1hTdFZEQXNT?=
 =?utf-8?B?QS9FR3IwcVFFK1BzWWgremIwS3pOK2s2cHBVY205aHJ0bHphNUlXOVpqNWQ4?=
 =?utf-8?B?OXJVcTF1NGVRb0J5SFNhM1VoL01Fa1MzS0t5MWcwaThuTnFBQmx1L3NZZWp6?=
 =?utf-8?B?U054d1lMaE9SQzFUYzJDYUIxcHorbFVqdXpYT0Q2RURRVXJERWtoRm5GSUcy?=
 =?utf-8?B?c3g1U1g3T1NjalMxS2U1RmdaSVpEallxSXBBL1RLL0ExbWRMYlVqaEZtb1l2?=
 =?utf-8?B?V2E0VnIxaElFTEdKZkhucUdQdi9jRHFMdit1WDBWTDlIeVQ4SmZ4akhGcDRS?=
 =?utf-8?B?ZWcrN1VpT1VxU1F1eGJYamZYYkZIcUQ1cWRodzBTbUlSQ3BJWjhSTDdRa1Zu?=
 =?utf-8?B?dTIvZVBneWFwTnJndzlsTEl1WnBXb0RKZ0pNaTFvSEdjYUwyVkNOY3ZLWldp?=
 =?utf-8?B?aDZDbFZuSmVHdDBrQmpBTUtBbklyaU50NXE2a0pCTmhINkV3dmhpR3F5Mnlq?=
 =?utf-8?B?TFNlUmlOQzJ4bEI1V1BYZmlLV2lTZ0JCVTBYdVIzM25qZlJsazVtcDFGeTEz?=
 =?utf-8?B?bFptQkhKcEdXeDVhVE5RWlB4NTVBMTRuSGl4S0tuMkRkdHhqdjFJemdaRmlv?=
 =?utf-8?B?andESFZRZ0NDRGxZQTRaeENnZmFkNWt6UVNLa2k1MEtkSzZJYjlBdS9rVTNa?=
 =?utf-8?B?cXJjRmczYWZoT0dreHdWOVR4YnBuNGJqOVFNSmNMc0FLNmpTaDhocTdhbEpl?=
 =?utf-8?B?UkJrZ2hSN3VsUjFTUnZQWjMyeWxhbk9ySXJxVXdtKzZmZjViRnNSclZGc3dx?=
 =?utf-8?B?ZUVHWmRRbU9PV0t1bXc5WThzYUhPOGhEVEJ2dUdiSjdZSGNrOCtVZktScHJW?=
 =?utf-8?B?K1FjSjVpTlluZTBEQWxSckRyZ3FxV2VDbzAwUmZsMVNCVjIxMnlxeU83a01o?=
 =?utf-8?B?NjFUbVhQNVhXZEVLTVM2cW92TWI5ek0remJydEsrVWV3bGsyenhMZU5iWHh4?=
 =?utf-8?B?eGxvcWpkU0xPNytNNXdYRTcwWmw5eHFEaFBvUi9SMnBUNjVhN05JbEpPMUpk?=
 =?utf-8?B?TVV1U1M0eGM3TGNsM1h1MStETHJCMTMvWS8wVk82Vm5ocFNlTVhBOWx3RXpa?=
 =?utf-8?B?Wi9zZUpIT3pnbHlEZ0VuV203bHBTb3FiQ0c0UE13QlNjL2ZLRjhYQ2xDK0lM?=
 =?utf-8?B?dGYvaGxicFh0cXgwTmdUQXpjeFl0OFJ6djYvZzUraXdrZHJ0ZkdTZWpIKzE4?=
 =?utf-8?B?M1lZcXJpNExQSDFqZ1oyT1cwYitsTWVIcXdTS3Y2eTZ3RVpiQ01VUnRXMng3?=
 =?utf-8?B?QVQ0QXdRbnhaSk5yQ1pTaTdTbzBzd2dvWmtCang3TUpqbEJsdkE1SEFYN2pX?=
 =?utf-8?B?K2lQRjc5MzVqL0VaTG1mOGVheXFHekR3TWFTVmRGUTJSNnhDVWVLc25hMk5l?=
 =?utf-8?B?cm41Wnl3OC8wcWUvNmpZUmdnZllFcHI0YU5zaXpvMGtnNkNWRVptd2RqVlIr?=
 =?utf-8?B?OHZoZXBLcXJoK3pPaFpZYlhXdVRnMFVsZi9yeXlnemhvaUtmbWV5NjBoYnc1?=
 =?utf-8?B?QmZNYUJxcjY2ejdyOW9paHFkN05xZmxBL0VQMU42VzFKeHFDb3RwMVVvMXA0?=
 =?utf-8?B?YTVOb0Q4UmFCN1NMQnMrd2JKUnFteUwrRU10QVVJeGJiNnB6MzRQYlFJTUJw?=
 =?utf-8?B?bDE1bHBFcjZhVGM4QVZ2RFZ5RXJzaFQyUjFiMEhqQWJ3TUJJaUNBaFR5R2Vk?=
 =?utf-8?B?OE5MUjhOcEdPUUZ4MzZtakxZUGl2cXBoNjhJSG15TUM5QnFNUjIrMklINWw3?=
 =?utf-8?B?M1hxVzhtek1wSXUxWUxvbnVRdlBoU0MyWjQwc1pVeERaVkRWL2M2M0gzQllG?=
 =?utf-8?B?cmkzcXE3aWxwTHZiVHBUMTUySzFWVndsZWUyZ0hoV0ZXdkQ2SW84S3Z4NEpj?=
 =?utf-8?B?c013dzFZYmZVdjJYZVRwam9peXc5RHdYTXRNc0FqenB3WnhaWm9CdWo1UWhl?=
 =?utf-8?Q?KaJeKK0KDu8in6+jPrD0LW4=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ded4107d-5a70-4cab-7f60-08dba570de64
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 13:40:39.1506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ejiN3e/z4AyqoMCzIgUWnnb6dXb7PbWBELPcQEqsEXDZuPR6mreLkJRSP1qKL0AJ1UU2e4DHLXmdxf0PRg4BcynjBC2+zGHHzkqHN0fMPg4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5087
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jesper Dangaard Brouer <hawk@kernel.org>
Date: Fri, 25 Aug 2023 15:22:05 +0200

> 
> 
> On 24/08/2023 17.26, Alexander Lobakin wrote:
>> From: Jesper Dangaard Brouer<hawk@kernel.org>
>> Date: Wed, 23 Aug 2023 21:45:04 +0200
>>
>>> (Cc Olek as he have changes in this code path)
>> Thanks! I was reading the thread a bit on LKML, but being in the CC list
>> is more convenient :D
>>
> 
> :D
> 
>>> On 23/08/2023 11.47, Sebastian Andrzej Siewior wrote:
>>>> Hi,
>>>>
>>>> I've been looking at the page_pool locking.
>>>>
>>>> page_pool_alloc_frag() -> page_pool_alloc_pages() ->
>>>> __page_pool_get_cached():
>>>>
>>>> There core of the allocation is:
>>>> |         /* Caller MUST guarantee safe non-concurrent access, e.g.
>>>> softirq */
>>>> |         if (likely(pool->alloc.count)) {
>>>> |                 /* Fast-path */
>>>> |                 page = pool->alloc.cache[--pool->alloc.count];
>>>>
>>>> The access to the `cache' array and the `count' variable is not locked.
>>>> This is fine as long as there only one consumer per pool. In my
>>>> understanding the intention is to have one page_pool per NAPI callback
>>>> to ensure this.
>>>>
>>> Yes, the intention is a single PP instance is "bound" to one RX-NAPI.
>>
>> Isn't that also a misuse of page_pool->p.napi? I thought it can be set
>> only when page allocation and cache refill happen both inside the same
>> NAPI polling function. Otx2 uses workqueues to refill the queues,
>> meaning that consumer and producer can happen in different contexts or
>> even threads and it shouldn't set p.napi.
>>
> 
> As Jakub wrote this otx2 driver doesn't set p.napi (so that part of the
> problem cannot happen).

Oh I'm dumb :z

> 
> That said using workqueues to refill the queues is not compatible with
> using page_pool_alloc APIs.  This need to be fixed in driver!

Hmmm I'm wondering now, how should we use Page Pool if we want to run
consume and alloc routines separately? Do you want to say we can't use
Page Pool in that case at all? Quoting other your reply:

> This WQ process is not allowed to use the page_pool_alloc() API this
> way (from a work-queue).  The PP alloc-side API must only be used
> under NAPI protection.

Who did say that? If I don't set p.napi, how is Page Pool then tied to NAPI?
Moreover, when you initially do an ifup/.ndo_open, you have to fill your
Rx queues. It's process context and it can happen on whichever CPU.
Do you mean I can't allocate pages in .ndo_open? :D

> 
> --Jesper

Thanks,
Olek

