Return-Path: <netdev+bounces-48167-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED6DE7ECAC9
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 19:51:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 938B0280F07
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 18:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4004033CDF;
	Wed, 15 Nov 2023 18:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D0gTru6o"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C119B
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 10:51:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700074307; x=1731610307;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Pdc77lZVnSXOxq4uxg7t9b51B8XI4SIEciMVAHu263o=;
  b=D0gTru6o11CzyHeS+6zBniXfHO3ZY1QnUl3WSdQhi8q/KHkdvmvnl8q/
   paqIkrTFlPKVU1/FYQHrvs1tBIghB+TbtmhSD+eAvF4f4cc31ntyneTHc
   TbEGj+Ee3/Xxjvm+CQ6kH2Amxa8QveqgtdZefVHwV9pn5GdKDSxMEj4/0
   sVgGEqT9KIJPN4rXrumKTOxVVTC+ZPzQr7U3jtpKz30KjRaY2G0BjNadD
   41kG2dpBtRosPsEgl9hKwkkHO8Yk70X0CMWWhGvTV8Osqq1DtwJVRMMx3
   b/VvwJvB3tLGA7yXGJjjAw6VZFWDwDh9Uj8KW3lg094PtiMt60Bune+Vj
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="388095109"
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="388095109"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 10:51:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="1096526445"
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="1096526445"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Nov 2023 10:51:46 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 15 Nov 2023 10:51:46 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 15 Nov 2023 10:51:46 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 15 Nov 2023 10:51:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DhBbYFpLjnVPZ1zLdbO7x0Ei9gX7VjpJ2+QOuOWbhV9UmdHrI4UO23BvtX4ZLqMNddPNKIr+CILergXu2NJLdsVS3tszIL/JwikZlbM+Q3DbWIUNIceixNS84wXcOvb6ERGiHEipJTxMVaaI5dSnrry9/nzi61btbt9jMfRoWzIAPVoFvtNFwRiFQYtidBBFobgAlOSJG3jBdc/W9sXYmhlFqxwnjaLOnOxsYygAu15ONdAjyzUcTo7aZBfa0sJAxagRzageniWKhQQVBdLrj5VziYy+yVMRbSEbndtzQu4sRM9TGsXnqXWsHi4EUsgCDcnm0gXMPQw9DPtjXc+GlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NmhX0j1l0FkHVl4XhXRzxLcB021dvwnmc8zucO9VZQc=;
 b=AvTMIIKphWuoOvwy4aoAp76KIp17u9xRT0jdvBC0Gc/aNmx1tudMtpazvN5Up8C/l9fCCgijg0GwkjCcNaBbFUk/+rSguGtl6U7B8ZDy5Msk62Q8dG+YhFYzz9VPZUhSkv2EawQYHCpHkaVYAsKJ+WuQDnmzNeI+2c3NAplnZgDPPfUDUvcHvgXeiOsU+Gs4YjyGG5oigSw0+zf6XpDdVJMIPYiwmfEIezr2D5hUvPD0KjQoRzQy7rm5Ck7Lo+DGFRCPlSZtB0cBINMvUP57Y6ISNoBKx63w8KThFbNxUu58xiZofE91P4hDsIIMUZf6pOhQ7xkt36C/IHB1XrX+dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5042.namprd11.prod.outlook.com (2603:10b6:303:99::14)
 by SN7PR11MB8042.namprd11.prod.outlook.com (2603:10b6:806:2ed::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.20; Wed, 15 Nov
 2023 18:51:43 +0000
Received: from CO1PR11MB5042.namprd11.prod.outlook.com
 ([fe80::dc90:ba:fcb1:4198]) by CO1PR11MB5042.namprd11.prod.outlook.com
 ([fe80::dc90:ba:fcb1:4198%6]) with mapi id 15.20.7002.015; Wed, 15 Nov 2023
 18:51:43 +0000
Message-ID: <54a7dd27-a612-46f1-80dd-b43e28f8e4ce@intel.com>
Date: Wed, 15 Nov 2023 10:51:38 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: sched: fix warn on htb offloaded class creation
To: Paolo Abeni <pabeni@redhat.com>, Maxim Mikityanskiy <maxtram95@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>
CC: <netdev@vger.kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang
	<xiyou.wangcong@gmail.com>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Tariq
 Toukan <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>, Saeed Mahameed
	<saeedm@nvidia.com>, <xuejun.zhang@intel.com>, <sridhar.samudrala@intel.com>
References: <ff51f20f596b01c6d12633e984881be555660ede.1698334391.git.pabeni@redhat.com>
 <ZTvBoQHfu23ynWf-@mail.gmail.com>
 <131da9645be5ef6ea584da27ecde795c52dfbb00.camel@redhat.com>
 <ZUEQzsKiIlgtbN-S@mail.gmail.com>
 <5d873c14-9d17-4c48-8e11-951b99270b75@intel.com>
 <ZU4PBY1g_-N7cd8A@mail.gmail.com>
 <63b9b3f40d0476ada2972ea8f6058b3613520ba8.camel@redhat.com>
 <ZVI3-w5dsLIhqHav@mail.gmail.com>
 <3fe99c1a283d564346742c3e3d820afcfd1f2634.camel@redhat.com>
Content-Language: en-US
From: "Chittim, Madhu" <madhu.chittim@intel.com>
In-Reply-To: <3fe99c1a283d564346742c3e3d820afcfd1f2634.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0349.namprd04.prod.outlook.com
 (2603:10b6:303:8a::24) To CO1PR11MB5042.namprd11.prod.outlook.com
 (2603:10b6:303:99::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5042:EE_|SN7PR11MB8042:EE_
X-MS-Office365-Filtering-Correlation-Id: bb5877f9-2d83-4274-c178-08dbe60be8f3
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AvwDfz4P+lBogymCW4o+WczFXsSdW4LJGT5U0p1uQV8ME0bjkZjrVCS2p6u4ldTS1Yk1vYY8GL/02li7+D0Q2+md1Cgog3MGaMzz2xFClYcsADerHOtkt14sFC3G2s3YLg9Z8Oc1kACItH0zPtjYbjjKAK0eSeCCRicbvYyTvbopgMHZ6eLk/EvtqlXfw8vnR9sTCqa5mNR1zPGqEGEb4kAVdbqUNTBozdfWL+OauGLASjq/ZoSXgsowhuxoz/lLGdcx88YgWi3dH3O5tjvzYAiAVU3l75q8gAWYnl0wt1C63DNYUVjmbECz+FJjBS0+f09cmFPy65KLaQsCa3/2T1+ASMypQ/VkZPIaNw19YAbQ/cYg79yVNgTyvZS3Q2xizQDSGh6sbDahKzXSzjsCNK4fc10ZNqPf1auNzAeFj4XLk76wV9wYDEH/upACans1lI4Vp9d1t6bGV4emH/tRZQplbVfWlYY5CTrnCeYLbs404ie3lAx//PROskjhHEVBxmaYZKCOtArvMYXL4U9qAlKjXIncxiJ6f5UPKobYzdKOcMOJKlFKLxJ5IWkfakAM/IaffdbGdCR9zoFA7VtQGvSDHiWOg1RtrsKCRrnSvcJbnKYVyT1gwVfb6gZ90bdqXd8wg5CfE1Qjt7uuVfb6vO3/8/ZLCk+j2/qxW1ydhmM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5042.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(39860400002)(366004)(396003)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(316002)(66556008)(66476007)(8676002)(4326008)(54906003)(66946007)(110136005)(8936002)(6666004)(966005)(36756003)(6486002)(478600001)(41300700001)(31696002)(86362001)(5660300002)(7416002)(4001150100001)(2906002)(38100700002)(107886003)(2616005)(26005)(53546011)(6512007)(82960400001)(83380400001)(6506007)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZUkxQkZMVVFQUENjTjRoM3FwNzNJdWEvRE5VRjRTaVVSbFR3dlJRekVtWFpI?=
 =?utf-8?B?VW5WTktKK1YrTEJTbGVuY01kYUJxanpGTjNEdlg3Um5hM3hOUlFmYUN1V0w1?=
 =?utf-8?B?bXJ5cUU2UE9XeEdDTE5sd3JBUkxYSFlkemJWaHlpV0dLdFRmRHdPeW8yRDI5?=
 =?utf-8?B?QzhVYk43OWNrd2RKNk50MUp5RU1pOVF5V3Boa1J0UEc1TXdKdVdZRjNXNnZr?=
 =?utf-8?B?TXVFeXBIM0s4YXprbmJPMjk4N0pDVllJcDY0VDhzd1hFdFhHc0RFS3dNSXpR?=
 =?utf-8?B?Y0RMVEJDSTlKWldwa094OEtLNWhBTlRTa3pacmZ3Z2RGMWVqTDZtZ2g4bHg5?=
 =?utf-8?B?M0hWY0FlaVhYM1ZhY0lQeXZKYUhRWEFqYTRMbzNCUldpaUYrTHczTDdDMFlC?=
 =?utf-8?B?THNKZmRXOVErMFdrakllZjJJS2V2aFNHTFNQLzA3OGFKZTYzZkExblFBWFR4?=
 =?utf-8?B?ZUYrQVo0L2dRYXR4eHdDREkydktVa29YUVduL3MwbmpvOGlPVXc4TFVNcFg1?=
 =?utf-8?B?T1pVbXN5ckVGZldLQW1ndDNwaXh6cWdJM1dQeEk3VURoTEZIV3V3REgyMVFK?=
 =?utf-8?B?MWJWelI5KzM4aTRqZUlBNkVaZ3VuTDdnZjV1NVYzVVgzNW1KcXFWRW8reEho?=
 =?utf-8?B?Q2pWWndRTng2V2VxaGNuc2V0VDBZSTJxWjd6cWtYbXp4TUNHVkh0dm1nOS9H?=
 =?utf-8?B?Y2ZoNkRQNEF4Rlp4TjI2eVVIYkU2R0t3M2VQaHR2OFpocS9Pc3NwKzk2Nnh3?=
 =?utf-8?B?cm9KUENyVHgxWGUrSmRHLzlSY2pVT3VRMWYxcXl0VDdaL2J5WUFuUTZEZFlP?=
 =?utf-8?B?aG1zUGM3UHIySTE5dVpOZ29aTEFNbnhKKzFOczNmUG1kVm82d01YdWVKMndk?=
 =?utf-8?B?U05tZWVrcy81b05CT1dPZmhqZDFOUlZuK0tQRTFjRUQvM3J3SEduY1Jldk9u?=
 =?utf-8?B?R21wNUNiQ2NNZzFjMGY1NHNaaGlrM3VTYmEwQ3ZvV1l1WWlGd1huK1NhdVFw?=
 =?utf-8?B?L1NVVVJXRjN5L2w2eGUrZnFUKzcrNEhDYXVTT2FQaHh2Z25helVlWTlRTTVr?=
 =?utf-8?B?ekJWbmc1OFJsd2NobHAyK2ZzZFMrSXFGRGdtMGlkNFpxZ1JWalNYNXAyTW02?=
 =?utf-8?B?OEttaEVUU2JOdlIrWmNMdjZrV2tWRjRGbWhIQ3JVbFNsVlcyd2JiVW9wZHI4?=
 =?utf-8?B?eWVNd0h1QlJ5dG9reHI4MHZBeWtVMU1YVXZSM0F3OFlaamtzOU1DdWd4NG5z?=
 =?utf-8?B?cllIM2xMS01pYWxLd2xkMXdXZGZGa0pHZ25YVkhUNW00YWt5em5uWTcweDVs?=
 =?utf-8?B?R2JqTXBOajdCd0dMUmUvdmdZTGhUMUUwbm1sMUZRV2FYVCtCaTE3NTlKZlVw?=
 =?utf-8?B?QkdvYkpYYlRSUzJhcFFLSjlwYWt1R1o4dVc4WXBFVUJVeWF1SGZDTHFsTXVC?=
 =?utf-8?B?L2lRL1Zzenp2MW5UVXJMa2czd2RxQ0dQSEJjZVVNYU4wYXYvWXZCYzB5Ykt4?=
 =?utf-8?B?M1BCak9mTkE2Z1VXaU5wTEU5NlVFV1Z2VWZ6WStReWhaSHpmRnhjdml0T0hL?=
 =?utf-8?B?VHdDYmd3VDNXYlpWWGREQ3I3aW5uWlZFeStYa2U1TU15NGkyLzNlQzNJQVZF?=
 =?utf-8?B?REY3L1Y5MlNKZkhrdTA3RVFkcklWckEwVmYxc3N2aUhPWHY5OTJrb2FHNHkz?=
 =?utf-8?B?ZEdJcENmVVBPbnduWTdnNzA2UCtFK0pKZVFVc0Rpb2I1Rnkvbm9RKytmOHlK?=
 =?utf-8?B?SExlOU4vS0FHdnkrMUpPSHBMVjhUK3h0M0poeFg2eTlDRWVPU0NHYktpb0lW?=
 =?utf-8?B?SWNTN1FwRHU2dVpZbTJZVVFDL2FueXJvTmFqZDNDb1puUzhHbm5Lc01yOUo3?=
 =?utf-8?B?T3Q2bm9Feks1YlBQN0EycGlZNUVaTWt5WFZRKzBwU1JZaytBOElGcDNXbXo1?=
 =?utf-8?B?RXVyS204Z2ZIRTU0b091WHNmTEtic2FLSEhmRVQvWVU1ei92YWN6dEpzTVgw?=
 =?utf-8?B?WUJrV3FUYjhqWDJUem1zcVZJVFprRmh2V0ZRYStaejdqaVd1Z0RhWGREazBt?=
 =?utf-8?B?ZXB4MTVTL2RFbVg2ZGlKWWF1cVAyL2trU3ZHL0k4MnpVU3hFTmN0aUp2N2E1?=
 =?utf-8?B?YisxbTNuV1IvV2NoVGZKbW8ybGUvVWZ2TEQ3NUMrZUZhQ0g2a1VHd2d5MmVK?=
 =?utf-8?B?cnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bb5877f9-2d83-4274-c178-08dbe60be8f3
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5042.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 18:51:43.1656
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yol1/vwsyB0iQyx34pw56wzBz5pqb0F+57zXk+OoUMli27aIjKcfqd0hU90ZbAFmHLNBWyinHYlsMX23JHMfZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8042
X-OriginatorOrg: intel.com



On 11/13/2023 7:21 AM, Paolo Abeni wrote:
> On Mon, 2023-11-13 at 16:51 +0200, Maxim Mikityanskiy wrote:
>> On Sun, 12 Nov 2023 at 09:48:19 +0100, Paolo Abeni wrote:
>>> On Fri, 2023-11-10 at 13:07 +0200, Maxim Mikityanskiy wrote:
>>>> On Thu, 09 Nov 2023 at 13:54:17 -0800, Chittim, Madhu wrote:
>>>>> We would like to enable Tx rate limiting using htb offload on all the
>>>>> existing queues.
>>>>
>>>> I don't seem to understand how you see it possible with HTB.
>>>
>>> I must admit I feel sorry for not being able to join any of the
>>> upcoming conferences, but to me it looks like there is some
>>> communication gap that could be filled by in-person discussion.
>>>
>>> Specifically the above to me sounds contradictory to what you stated
>>> here:
>>>
>>> https://lore.kernel.org/netdev/ZUEQzsKiIlgtbN-S@mail.gmail.com/
>>>
>>> """
>>>> Can HTB actually configure H/W shaping on
>>>> real_num_tx_queues?
>>>
>>> It will be on real_num_tx_queues, but after it's increased to add new
>>> HTB queues. The original queues [0, N) are used for direct traffic,
>>> same as the non-offloaded HTB's direct_queue (it's not shaped).
>>> """
>>
>> Sorry if that was confusing, there is actually no contradition, let me
>> rephrase. Queues number [0, orig_real_num_tx_queues) are direct, they
>> are not shaped, they correspond to HTB's unclassified traffic. Queues
>> number [orig_real_num_tx_queues, real_num_tx_queues) correspond to HTB
>> classes and are shaped. Here orig_real_num_tx_queues is how many queues
>> the netdev had before HTB offload was attached. It's basically the
>> standard set of queues, and HTB creates a new queue per class. Let me
>> know if that helps.
>>
>>>> What is your goal?
>>>
>>> We are looking for clean interface to configure individually min/max
>>> shaping on each TX queue for a given netdev (actually virtual
>>> function).
>>
>> Have you tried tc mqprio? If you set `mode channel` and create queue
>> groups with only one queue each, you can set min_rate and max_rate for
>> each group (==queue), and it works with the existing set of queues.
> 
> mqprio does not fit well here as:
> 
> * enforce an hard limit of 16 queues imposed by uAPI
> * traffic class/queue selection depends on skb priority. That does not
> fit well if e.g. the user would rely on a 1to1 CPU to queue mapping.
> 
> It looks like any existing scheduler would need some extension to fit
> this use case.
> 
> @Jiri: when you suggested TC do you have anything specific in your
> mind?
> 
> Otherwise it looks like extending /sys/class/net/eth0/queues/tx-
> */tx_maxrate would be more straight-forward to me.

We are planning to go with this approach of extending sysfs entry to 
have tx-maxrate and use this in our iAVF driver to support per queue Tx 
rate limiting

Below is the link to our original implementation using devlink interface 
which was rejected by Jiri
https://lore.kernel.org/netdev/20230822034003.31628-1-wenjun1.wu@intel.com/

@Jiri, @Jakub, Please advise

> 
> Thanks!
> 
> Paolo
> 



