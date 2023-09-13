Return-Path: <netdev+bounces-33506-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FCA179E4EC
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 12:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6FE42819AF
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 10:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C32C41DDD4;
	Wed, 13 Sep 2023 10:29:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4E618C1A
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 10:29:33 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F61F1989
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 03:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694600973; x=1726136973;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MdL8Xy3CE2XDjYQ3/t1bbVqE8CX06EO+yjVr+kQFClc=;
  b=S9AkJDmU2ZPRK7wiagkbfb82+sRi6/akTX2MEtqD5rDMwbtxGXw0Re3a
   v3vvkq7kWNJcIzL5/oYjPSBBR3ovMXn+5xKnKpVzYxYaReUpXuvpRPhX4
   rXAL2PlZff2bmAwebvSSFL8KzaY5SXxqrnja4AGZe6bi51c+aXU8DUBpr
   4pmGVvdbQJwWf2a99s0DQmBDTH7wbNyjmAAn6do5T0fND+a667tp+O0yj
   Y9TAcafjSC5tnflmuk9dh+BgOo1tAETCimjgcwESsgDPgfFaOgD6gBgUs
   on0rng+KcUB6fjeZvYwpTm1a4OTyIcvDQRREKJmKjDZ//OEqZpyMmz5d7
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="363652795"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; 
   d="scan'208";a="363652795"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 03:29:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="773412388"
X-IronPort-AV: E=Sophos;i="6.02,142,1688454000"; 
   d="scan'208";a="773412388"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Sep 2023 03:29:32 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 13 Sep 2023 03:29:31 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 13 Sep 2023 03:29:31 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 13 Sep 2023 03:29:31 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 13 Sep 2023 03:29:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f8NYrfQ134KEQA20IHxuioKV1DJh14EAsjB7/VokmhQ55ZIaXDxhCsOFjqP5THrsW1IzFDimIreUJ7oZKHfNWWZPrXzV5DCfWpJOsilLlGIfBnRVIKdJ5GdcIa+aPoGE6jHQErkJ8mEOZ4yPbGzpb0Bl3GaQoaUMX+tMAmloAWxSTjAq7ImabhN22EyYD3jsDbT69BGieyMtTygadVpyJbI5/D+BDTYMFkeQziafMsYyQsL/V7KXn8jXhWEanMTA1lRk6OD7tGRFLXRQJKLb030f7WVgoUywrY/tTEznGoVb0+AqaQ0uBuCqKL88bPIPiNFIkBvqacctmYo5SMxXnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PPLBQPukbRi0vg+nfmX3DiLCMP51V37UlGZ25JyDhZk=;
 b=F+gKp91sHgBTnBRk6lneTZXWMtZyHqXRyqerxbNXPqObZAmjkWTS5MaFTxKbxm0aqZA6kclEOaVwwUIy7q1Gx11b/l4tfVW2rIvmppK5vWjJtFklbVxZ94iNqVBaI4Wf30yUpQo5rdxqELNgHC7yWQMjsHgQ3k47T1WYeMYTcH3XzYv/iJu4erC44mO5/kr53fNLFiwcKmsJpyI+d49r33j2X5h49qaLt2KdFdOS+mRXKIdgjR8Pk8dqlijf7gFgzo12R3xmMLVJPoMGuDc4oOvoKVASegvs/lnhjHULXchaFfS9Wf8HxmjBpPgzVck9jzvUMlocCwgHM42Liaejlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by SA1PR11MB7132.namprd11.prod.outlook.com (2603:10b6:806:29e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.34; Wed, 13 Sep
 2023 10:29:23 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::bede:bd20:31e9:fcb4]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::bede:bd20:31e9:fcb4%7]) with mapi id 15.20.6768.029; Wed, 13 Sep 2023
 10:29:22 +0000
Message-ID: <d250f3b2-a63e-f0c5-fb48-52210922a846@intel.com>
Date: Wed, 13 Sep 2023 12:28:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFCv8 PATCH net-next 00/55] net: extend the type of
 netdev_features_t to bitmap
Content-Language: en-US
To: "shenjian (K)" <shenjian15@huawei.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <ecree.xilinx@gmail.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <saeed@kernel.org>,
	<leon@kernel.org>, <netdev@vger.kernel.org>, <linuxarm@huawei.com>
References: <20220918094336.28958-1-shenjian15@huawei.com>
 <20221125154421.82829-1-alexandr.lobakin@intel.com>
 <724a884e-d5ca-8192-b3be-bf68711be515@huawei.com>
 <20221128155127.2101925-1-alexandr.lobakin@intel.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20221128155127.2101925-1-alexandr.lobakin@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0113.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9d::8) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|SA1PR11MB7132:EE_
X-MS-Office365-Filtering-Correlation-Id: 195caa2f-f25b-427e-70b5-08dbb4444b6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 60F7c4bIx3CFgrk76UxOkBdBnEQNL/Pynn2jsFNNOi1pAKpFtRWUHp5hT9c7WTutq92v7s6ihaXnD6h8XdfedIcakarJohyq5ZeHHUt4zrt48h6Ktr4ROqcYb0yYozrwyz7Y46WSgKpczrtRmMRZChvxyO58aSUDrw1cvzPbY6NCj8H2jxI4RG2pF3l5rpP85UQ4gOXTMjYkSaoTA+bPMMl/+oOQNKSC/8ilrqH6cTf8LJ8f7Ccjzhg+dUkgMRLchDuyIO7ImKP9H4M/XMfVTCy4BbrItQf2EnsuDy6FIT9tpKVw+2eO6M8NjycigjTFZYQAFbv2QXPFbZ9guUBKzD/3E4DVi4HW9t40HZ5zlIfp2a57vXsr31za/wOVKy3JQhPMvXTPJL9+Uw1Q0dSyf/zuKkSDTckpiS56KW2l5nEBe+SKHFl9vFL7IldkAKaCSx4P8QExuUvb1q3ox1223gEh1/RxNM2pmrCrRk0bc85fbMqIomHgHHHSxDgPxpu8Xm2TyR/K0aHOcKuJukPHJjfBMa5GVfE3/MxjzPFR5U0jYUvhMP1WnN+FiGeXSUguesEDLKskiGuj4KqIBomL1ZKC54Wai5/l2itGyAsvOutWlPSxjSmaW1Nly9oeux/wjIRsQ1v+zdOf4mBjwBfYkw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(136003)(366004)(396003)(186009)(1800799009)(451199024)(66899024)(316002)(6916009)(66556008)(66946007)(66476007)(6486002)(26005)(36756003)(6506007)(6512007)(6666004)(82960400001)(31696002)(478600001)(38100700002)(2616005)(86362001)(7416002)(2906002)(8676002)(31686004)(41300700001)(5660300002)(4326008)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NkhkOU5DVUpJNHRQWGNsTG16eXJwaU1nZVNZTVVEMnVwcHFjQW9Ea0k0bjBD?=
 =?utf-8?B?d3VUeVo3UjBOWldTMmtTdjBiaFcwS1Z2UlMxTDd6b0p4TlBXdWxKYW5JYzZC?=
 =?utf-8?B?bHI3Sno2UHVzcTdMUU9wUjZYaHM2Z2hpQldVUENGRENrTGVGOXVENDRsNGtq?=
 =?utf-8?B?YmpGd0pPSGp6NVp3SENYd2wzMlFka1JxQjRYMDJWaWNFS0x5WllGSmJwNnZj?=
 =?utf-8?B?aHM0YkdsWGNhVmh1Qm5XOE5nY1VoREVlRURQazFUc3JtU1lKL1hXQ1ZkOWs2?=
 =?utf-8?B?cG01MENWTmNQTTZaS0F2ODQ4NnpyWTkxT09lQnRscURQVlc5NzljamUzQ1lU?=
 =?utf-8?B?Rk04Wm5kVy9GUHRycnZwSkRnRUtTYVFLMlF6Z3Z4TDRLb1c3RlRvclNJSVZk?=
 =?utf-8?B?a2NpM0piRmViZFRCSDlZYkk5ODdtK2VhK2ZLeUJ0eGppcFI5RXNYeWZPd2RK?=
 =?utf-8?B?NTBwNlgxUjZVeEJoNGJzV3hHS3R0eFo3MTE0cDQ5Y0hQa1NWRzRLK2YwVU9o?=
 =?utf-8?B?bDNzWjdYdHhDTmd5Szh2WTZyUTh1R1ovcURKQWdMZW1yRUtvQTM2MExVcXpS?=
 =?utf-8?B?d1dNd05Hem84YUNZcW1QNy84WDVJQm9DVmtBWUdPQzVZWjc2Q29rTnFNRzZj?=
 =?utf-8?B?UitGdENiZlZ6RUF0MFVRK1laRWgwNHczQzdCeWE0aTVzZnlnNkhiVEI4T3JU?=
 =?utf-8?B?Yk80ZzRpN1JSaWU5NHlZOWdrNlZsYTlhMlhtaTAvaTVyNHpwZkY2QUVJbjNo?=
 =?utf-8?B?NUJ5MlBnSExlM3k4V2UrK0FObTBTN1Q3aWtwOUwzbFhlVTZqdWRwY3Vlalc5?=
 =?utf-8?B?dDcrMDRkekw1cTNtdTdsQ0FKUFRrdXVtQ1hWTzdMM0V5eEtTeG9EUHQ2aG9B?=
 =?utf-8?B?OUpId2hTTUl2QVlKQ2NhTGs0L3ptaWFlWDdLeHI3RlR0UWRpMHRlamJKVG93?=
 =?utf-8?B?TG55d0NmdGtJK2pkeit1UWg3bDgrL2xzejM4eTVKdGwyS2FhWUd2eUpUTXBY?=
 =?utf-8?B?VHUvOHJybXlGc0N3OEtGajFvTmlkNEQ5U1dHSHlPV25nQ05iQXRLR1YvWXhI?=
 =?utf-8?B?a1ZKTnhBQlc3djFOalhZQnMraVliaGsyQjJ3bTRHOVNKTEV1dzZsckZhQTAz?=
 =?utf-8?B?TTN2TTY1T2Z3K0I2L1o4TEgvRDczNlVINDhwWkpWK3NrU3dSRTVoMU0vYXMx?=
 =?utf-8?B?eDRUbEdGckM0alpSaTk3N3RmYy9RVkFQQWN6Qjg2QUJnZE1MWUNmSXNCRXpG?=
 =?utf-8?B?MEZZSDVsZkpEMnNrb1F4aGROaC9kZXZsQW9MMXkwWmRDREUwUUlaQndXeVJI?=
 =?utf-8?B?aWpmbVp1TU1hc0ZjY1VBZmZjbWh0V3hYMkJlNS84YTdjRThNdHBPblNzTUVl?=
 =?utf-8?B?bkxydVZDckk5N2VEdzFrR1gveWI3VkxnUTFjb3JaZGI4UFZWUFhHZnBkaFl2?=
 =?utf-8?B?M2YxYTl3WmpVSHBnbkVoVS9rUUhNdkh5NXJRa2ZhOXc0NEw1d1k4YitWdWZO?=
 =?utf-8?B?U2JKYVpZbmRYc0gzejF4M3d3T2o0VWNFdWMvWm9HcEkxZlhUU0lEUHhFRXBE?=
 =?utf-8?B?NUdVMVBMcitQREk5dnAwTDBVRmFQVnlWUGttaDVSK3pjUjV0bWxUSFJKdk44?=
 =?utf-8?B?VHozRmswOXIzL0M4RHphU0hlNSs3akx6NlRPRUVlek5DN2pvNll1U3ZjR1N1?=
 =?utf-8?B?ZXR5c2NENjQ2b2g3b2VHMDFValhGeWk4OEFYRnZKWHhJalpOQklCZDRRU1NZ?=
 =?utf-8?B?Qkg4aFhoNFJjelBzM1Rrei9hQ3FxcU1FeEtRYkZGK2pIOHQremdvVndJclhy?=
 =?utf-8?B?Z2J4TTk5MDI5VE55V2c5Sm0zLzMrTmRIZkI2cXJKUlM1eWVtSHhGdndkOTNU?=
 =?utf-8?B?ZzlLdzBaVTh2Y3FFczBXOUVuR05yYnZUN3oyY2k2cGxKbkplNTZOdi9HcnRG?=
 =?utf-8?B?V3BySllMTWI1L2Y0ekpaeFFZVG1oNnpRU2xKWXhmejc0Rk1ya0lLcXp1aC84?=
 =?utf-8?B?WWJ3Z0I0bFp5SEV4NElnTmZ4VTZIT2szWjAyRjJHdFlQMFJYQzN2THRSMHRj?=
 =?utf-8?B?Y05XcE02UTFHUElRYS9IQllTeUVtc2ZvMkhJdGNkQVV5dXcvY09FWW9DOVAx?=
 =?utf-8?B?eUcxcFE3R0VLcFA1TlR4b1djKzUvQzF5Ry9GZ1p6cVFkRkRjdXZlUEF6NGtD?=
 =?utf-8?Q?YYoLWYdXBr3LehBLOnW1eBc=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 195caa2f-f25b-427e-70b5-08dbb4444b6c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2023 10:29:22.3238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4DWGRYwkkZ/wLlADXSnGDu1CdGeVt81bEJAGuWMBqdBBmQbuRan5Ilkpt3o2/v118lywV319b1/oAsIdgCt1+kSWakhzeExnI3lPAp3MhFc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7132
X-OriginatorOrg: intel.com

From: Alexander Lobakin <alexandr.lobakin@intel.com>
Date: Mon, 28 Nov 2022 16:51:27 +0100

> From: "shenjian (K)" <shenjian15@huawei.com>
> Date: Mon, 28 Nov 2022 23:22:28 +0800
> 
>> 2022/11/25 23:44, Alexander Lobakin:
>>> From: Jian Shen <shenjian15@huawei.com>
>>> Date: Sun, 18 Sep 2022 09:42:41 +0000
>>>
>>>> For the prototype of netdev_features_t is u64, and the number
>>>> of netdevice feature bits is 64 now. So there is no space to
>>>> introduce new feature bit.
>>>>
>>>> This patchset try to solve it by change the prototype of
>>>> netdev_features_t from u64 to structure below:
>>>> 	typedef struct {
>>>> 		DECLARE_BITMAP(bits, NETDEV_FEATURE_COUNT);
>>>> 	} netdev_features_t;
>>>>
>>>> With this change, it's necessary to introduce a set of bitmap
>>>> operation helpers for netdev features. [patch 1]
>>> Hey,
>>>
>>> what's the current status, how's going?
>>>
>>> [...]
>> Hi, Alexander
>>
>> Sorry to reply late, I'm still working on this, dealing with split the 
>> patchset.
> 
> Hey, no worries. Just curious as I believe lots of new features are
> waiting for new bits to be available :D

Hey,

Any news?

> 
>>
>> Btw, could you kindly review this V8 set? I have adjusted the protocol 
>> of many interfaces and helpers,
> 
> I'll try to find some time to review it this week, will see.
> 
>> to avoiding return or pass data large than 64bits. Hope to get more 
> 
> Yes, I'd prefer to not pass more than 64 bits in one function
> argument, which means functions operating with netdev_features_t
> must start take pointers. Otherwise, with passing netdev_features_t
> directly as a struct, the very first newly added feature will do
> 8 -> 16 bytes on the stack per argument, boom.
> 
>> opinions.
>>
>> Thanks!
>>
>> Jian
>>>> -- 
>>>> 2.33.0
>>> Thanks,
>>> Olek
> 
> Thanks,
> Olek

Thanks,
Olek

