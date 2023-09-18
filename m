Return-Path: <netdev+bounces-34586-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76DF47A4CCB
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 17:41:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67B8B1C21172
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 15:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB6D11F5FA;
	Mon, 18 Sep 2023 15:40:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166DF1CF8D
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 15:40:28 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 833F7E6C
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 08:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695051627; x=1726587627;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LI1FmvL3L5lbTxZ9y2lYCngA8fw695/CvaM9DDFqbDI=;
  b=M0vrJTl3JfYmLFmAzopPLdZH/MQDz3tApGtRDQy1ZoOXRSVX1pIMl7I8
   h7kqQ+66eu1z23oZwF1B/1mR7425RMr70y1E/RNZHTE0RWoIluHKGqNAc
   Lk2PRxScsfITl+e3LzHRBZJiT5RROj/pdGl6TPdnMWT5C/+25QBzuK4Fv
   YRLbwkIxCN8jSbvhGGxeegjDsN6AqWjtrJ2Y9I2xIAFDt7qaUks1bbOZM
   K07P94ndRe4fHICU8YBSorXtQxb+AyzeBBK8ZVC+qsOANNmJOSOYx3zKx
   fipytbCtcK4QjnkjSe8zUF3v5WWQXtZP5Hh+1P7Xaf0UNuOCoH0adjr6A
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="376984458"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="376984458"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 07:26:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="861088487"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="861088487"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Sep 2023 07:26:41 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 18 Sep 2023 07:26:41 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 18 Sep 2023 07:26:41 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 18 Sep 2023 07:26:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aoBQG1xerfKcrNitQMTIVgKetCQ8E31ZRXaAIizlLKJegy7u6MX4xLYC29G4g/q+XYxPnFqUiAZDdA170yD17ybd+qUYd02KNh0ujLa59rPl+W0CtewDqVIgaJ0uQG1UuiMXVq8lMb3Qee7xd59ZG+JVgjqKCSpL5qsA6FGwvA53p1uUHN8TpksjDpcwOAO++Xd7fjqLWrKPORzkZ0b6CMPF0l4pe5PYNw7K8lywOVNJhdSnaIInoTy9eOQSgFEbrexQi2fbOSZ9DTvuXkYdP9bO3OOghZa3boBBtXnT+vgVbmzzU6iTqlZWBmB+dZrmsGo7lgdEbPpROusEYDlxug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vEW1usxiGK9b7ASrX8KNMi/e87JZFE3pnPuXVQohJJY=;
 b=kzCwv9T46Lu66KFXSbqz3tHd9PsS9xfbr8aAQN+q3FVJM6EWg9P67VCffPWhdkduLgPco/AaRMvUMKiRQB3S/63+YBRQ0ypH/O0y2bO5Qu43mdSkNT5shaDePQLSqKZ+t4B1urMyAXj5nM+6MWn3A/63DMLl7HQ/Ya/y75SqcnNLcfERERmyeF1lYy8p1s800lhysVo8BrccKKPfmVhJgaEXrvJZuXnYSRlBDhldX5ItvuwO7TnSMD1zrlcY1AWMG8M5BeHnw1gpiqbzntZs3moO3vVp4qosnuIIKBpEMsswTk0BGM1sQldwiEu5BN+ehANQUptSbwAIgdcAQCUs1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by DM4PR11MB6381.namprd11.prod.outlook.com (2603:10b6:8:bd::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.24; Mon, 18 Sep
 2023 14:26:38 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::bede:bd20:31e9:fcb4]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::bede:bd20:31e9:fcb4%7]) with mapi id 15.20.6768.029; Mon, 18 Sep 2023
 14:26:37 +0000
Message-ID: <79b08cc9-fac0-ca87-2ea5-a86d9b28aa12@intel.com>
Date: Mon, 18 Sep 2023 16:25:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFCv8 PATCH net-next 00/55] net: extend the type of
 netdev_features_t to bitmap
Content-Language: en-US
To: "shenjian (K)" <shenjian15@huawei.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <ecree.xilinx@gmail.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <saeed@kernel.org>,
	<leon@kernel.org>, <netdev@vger.kernel.org>, <linuxarm@huawei.com>, "Sabrina
 Dubroca" <sd@queasysnail.net>
References: <20220918094336.28958-1-shenjian15@huawei.com>
 <20221125154421.82829-1-alexandr.lobakin@intel.com>
 <724a884e-d5ca-8192-b3be-bf68711be515@huawei.com>
 <20221128155127.2101925-1-alexandr.lobakin@intel.com>
 <d250f3b2-a63e-f0c5-fb48-52210922a846@intel.com>
 <0352cd0e-9721-514d-0683-0eed91f711d7@huawei.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <0352cd0e-9721-514d-0683-0eed91f711d7@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0057.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::17) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|DM4PR11MB6381:EE_
X-MS-Office365-Filtering-Correlation-Id: 8970724d-d2e1-455e-f380-08dbb853446d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QnbOeqRoDtCuZY/Sv39EfOAcYP+PKkHzP2OJjQN2V9Nkqeou6rEuS2wVLXaLnKuUoOMvq5r2Z0FhFhiLUi2BgJDPDzASvtNyf2nPkytFifPeg8BOgBOJNZR2zUXEGRncf3wj2P8h8rghj3Su5Gx2SDfXMILnxs6uiwjh/UdTVmtevBJoaGusFK75zB4lb21nVS1Y3cooqiTlLRYWvgfkLLbUDCOMkp5Fio+gplXks41T5vCKZlleFFbNqpBDR7dpBXHwLvaG8hXXXqoT5zAgHgCqnE34QmZsRYY2jF9k2iub6JNuoQv0jlaA1vEJvwM1iGz3UWJ8UbY7URPurg/YZzDkGuq86w8K7FVbc4Tx8NmkIGK01z3YKR1+JGEpZdUHGDSsSM1lxfE3qZg2M3RKKjkfJawAqAgRj636hAviJNaaKDh3UbqcF1Nfqmkyk/TyGtGY4LyhRu3vsRPg/2qZLDHRgaPlzYfMwmWk1nYraoJ496G9bppbQ0NsJDJcR0AqTYPOsWR8MlBT8E8RImxGPveKSkpL/3Vrdg1Btt8ZkxMG12bATDGVt3+CzJ8nYPjdFEovy7YlMc3zP1N+SySs4BFd2lXzD7zrO4Gncb2L9vCE4TobS2v3JfEcB6D9Pg8Ns9hIv92bZRKL+V7j5o0fjA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(396003)(39860400002)(136003)(376002)(186009)(1800799009)(451199024)(26005)(82960400001)(2616005)(8936002)(8676002)(4326008)(66899024)(7416002)(83380400001)(2906002)(36756003)(31696002)(5660300002)(86362001)(6506007)(6486002)(478600001)(6666004)(31686004)(6916009)(316002)(6512007)(38100700002)(66946007)(66476007)(41300700001)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?c0hSMXpRcSswYW02eERHejFzK3lBSEtnU1d6UGlsbGFaU1VYQUxtQ1A5WVlK?=
 =?utf-8?B?SDFOcXZHUFdZY3kyUlJncm9yTGVSK3FYbnVOd0pNQzBPUFZWcElLSEQ2VGJn?=
 =?utf-8?B?bGNFSEtOTjhyQ1A4bjNSTnRhNGw4bHlnRDZDbHBmVzgwK1dpZytJMGFyb2tV?=
 =?utf-8?B?a1FLUnQ3VjJDWkJlMUtoaEd3NWFkWm1XRFVFTXFvZXFqS3NTUGNldlk0NTZ1?=
 =?utf-8?B?L0orWC95cXZsaFdKcmN5WlFTbkRveEFsa0VTclJGR0xBWnhwRGxwM1lLeVJC?=
 =?utf-8?B?aXFZcnk2dVRjRzVrK0pzZGZWanN0VnNDd1FlclRtQ01GRHVaVDBtT3NHVi9F?=
 =?utf-8?B?L2hhazlBK1BVQTN6NzJVNFZIYmJDbkZnK2ZPNy83MnY5OW1NRTlLRk13TGNY?=
 =?utf-8?B?WFRydmNHNmlrbThISjRkQmhXQ1lqT1d5bVQvZkZiWVVuNjZuYXFyNkdRWnE5?=
 =?utf-8?B?azk1V2Eza3MyVEE2alVlZ08rcDQxblBZOGt0ZjV1QytHdW05c0g2ZnFwM2VP?=
 =?utf-8?B?aVdHdDRIMjB6bS9lNlg1UkVvSVEvdzhPQWU5RnNjV0VZY3E3VWYxWlFGZXFE?=
 =?utf-8?B?NkFnNERTTUZObWZhVS9yRGVOanJGRVhBbTBnc3NyYi9GKytzQW9KSjN0aVM0?=
 =?utf-8?B?YkRhN2lIdCtFQml5WlgwQTI3L2Z2WXBYSUFkNVltOVJXUUhHemVxaDRXQUUw?=
 =?utf-8?B?eXNFZW4wbTdPZmZGZGdkR2xyNWxSTUh1MDZkRjBMMjNna0hOcnd2dDBpMTBP?=
 =?utf-8?B?V0RUU0VrSFhkL25NeWZLOUJENHhpZEpUMU94Z2Z3SmNCeVMzY1ZENUxVenQ5?=
 =?utf-8?B?ODBUUU9iV2k2MkoyenVPUkdhMHhvVXIzeEZVRllTUjFhWE9JaTNmYllPRjIr?=
 =?utf-8?B?TCs0RGRxYnpQeXZwMXZXZUJNODBSRXJxMDVLZ1dLUUtHQVZoYzZsaTlBSzlY?=
 =?utf-8?B?eGxvNmVKMDdoTFNoT3M4NmlCT1Q1c1BDK3NDSnlzbFZXa0tiS2puWWRzb0pG?=
 =?utf-8?B?c3NrWWhYQmIrVGkrUTBMTXVDcWpxTUlPRTlnQ3Y2N3E0SVArTCt1UVcvd2pk?=
 =?utf-8?B?VGVRNi83VGVaTWhSaUFybDk0L3VZcWcwZW5JVkdtZkplYUh1empBQTljY1lu?=
 =?utf-8?B?SGtZZDYwYUpRNkJjY0xET1lHakNlbU1oc1NzdHNlVmhQaUorTkl0dk1GNlJF?=
 =?utf-8?B?ZVRSNlQ3QWx1QU1ZUzI0VXRPUGU0b1F2VGZQVzMzV3pRR3Z1aVZZYUQ4c0t0?=
 =?utf-8?B?eVhTMXhJcHRSUHdWNW5NTHkzWTkrM0N5OUF2MmlLbG9mNDdVczJxQ3NtaVRI?=
 =?utf-8?B?TE51c0VPemRqUGVhcHExR0hzNTlRZ1NnemNmR0dSQUVNdyszUFpiU2YybU9L?=
 =?utf-8?B?QWcyUC9qdXd6dkpkUG03aUdtUFNtUFJoU3I0MjNVV1UzZE10ZGQrUE5CRmZk?=
 =?utf-8?B?aC9qM00yL01GaTVLSno5YzZpUEQ3djFibXBIZlhQZitVZTU5NFhkT0MwWElG?=
 =?utf-8?B?aFJUR2lXUFBSUVBEKzUzS3kxMzNSOHk5dXdCdmdLdEpKL2l0RUdsMWtxcmF5?=
 =?utf-8?B?RGN3OGh0Z3JHMXBENCtkd2d1SUlnUmNTM2ROQW1zTkJNdWl6U2VmcHd4NTN6?=
 =?utf-8?B?NnIrTSswTFBGbk9aSEwyNXNKUUtyTEt1Smp4NUphdG9NSTNhYmV6Nm9kaG9l?=
 =?utf-8?B?SW5RVE5ZUTd3NDd5bHBRdlppTE0zWkcvYWVYZDBteFM1dHd4Y3VvYWJ2alF2?=
 =?utf-8?B?ek9yL0dMQ085ZFB0ZjE5SEZLM1pva3JVWi9xNlJUd1lHOE5GUVM0Y0IvNW9q?=
 =?utf-8?B?VFB0T2NIb3E4NUFBbHI5ZW1jVmNhQ1ArKzk2RlhKazhvNFVEOGhzek00STF5?=
 =?utf-8?B?cWhwcGdxOHVqQy9CRG5NL2VudVVUZTYxV3FueGxYV3c3QXIxd2JuZncwNm16?=
 =?utf-8?B?MkZkRHR3dktrZTJ2a0FPQ2lsV2krdnE0aWZsaXNYaWU5ZmQ2L1ZLQVFxOHI5?=
 =?utf-8?B?Wlp4V2FTUDdOUHNqcFNlNk0yK3hFdHp5blk3b0ZQVXNsZlYxL3QrbHhBazRT?=
 =?utf-8?B?WlY3Ym04bjl6WU84blZESEJYNms0K2hiTnV5VkNtV1JiRG9aYjl2Qk1IVHJE?=
 =?utf-8?B?djFuM013U1RvMXQ0VVpha0x6NGp5OUZCRE1mVCt6dXN0aWcraDhMRS9qUG9M?=
 =?utf-8?B?eUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8970724d-d2e1-455e-f380-08dbb853446d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 14:26:37.5617
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qRQFX8Cv5fQtNRYfvd9iFNkgg2TdOkCESZuE35nDKXMtymBsHoSnV5Jolg+1VyiWYqsO3FqieCTLANp3sJ7BVGUaaM6tOBqhXiw98eKLtok=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6381
X-OriginatorOrg: intel.com

From: Shenjian (K) <shenjian15@huawei.com>
Date: Sat, 16 Sep 2023 15:20:27 +0800

> 
> 
> 在 2023/9/13 18:28, Alexander Lobakin 写道:
>> From: Alexander Lobakin <alexandr.lobakin@intel.com>
>> Date: Mon, 28 Nov 2022 16:51:27 +0100
>>
>>> From: "shenjian (K)" <shenjian15@huawei.com>
>>> Date: Mon, 28 Nov 2022 23:22:28 +0800
>>>
>>>> 2022/11/25 23:44, Alexander Lobakin:
>>>>> From: Jian Shen <shenjian15@huawei.com>
>>>>> Date: Sun, 18 Sep 2022 09:42:41 +0000
>>>>>
>>>>>> For the prototype of netdev_features_t is u64, and the number
>>>>>> of netdevice feature bits is 64 now. So there is no space to
>>>>>> introduce new feature bit.
>>>>>>
>>>>>> This patchset try to solve it by change the prototype of
>>>>>> netdev_features_t from u64 to structure below:
>>>>>>     typedef struct {
>>>>>>         DECLARE_BITMAP(bits, NETDEV_FEATURE_COUNT);
>>>>>>     } netdev_features_t;
>>>>>>
>>>>>> With this change, it's necessary to introduce a set of bitmap
>>>>>> operation helpers for netdev features. [patch 1]
>>>>> Hey,
>>>>>
>>>>> what's the current status, how's going?
>>>>>
>>>>> [...]
>>>> Hi, Alexander
>>>>
>>>> Sorry to reply late, I'm still working on this, dealing with split the
>>>> patchset.
>>> Hey, no worries. Just curious as I believe lots of new features are
>>> waiting for new bits to be available :D
>> Hey,
>>
>> Any news?
> Sorry， Olek .
> 
> Would you like to continue the work ? I thought I could finish this work
> as soon as possible, but in fact, there is a serious time conflict.

Oh well, I'm kinda overloaded as well (as always) and at the same time
won't work with the code during the next month due to conferences and
a vacation :z :D
Would I take this project over, I'd start working on it no sooner than
January 2024, so I don't think that would be a good idea.

Anyone else? +Cc Sabrina, there's "netdev_features_t extension"
mentioned next to her name in one interesting spreadsheet :D

> 
> Jian

[...]

Thanks,
Olek

