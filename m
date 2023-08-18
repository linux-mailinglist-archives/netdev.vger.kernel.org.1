Return-Path: <netdev+bounces-28858-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C38781067
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 18:31:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C85E3281FAB
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 16:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 294FE18C19;
	Fri, 18 Aug 2023 16:31:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16A8D19BB1
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 16:31:46 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEAC73C0F
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 09:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692376304; x=1723912304;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=k8CXuXTQCVRILULEwyiNDQ53snTLmPAyk4eJuWZZgkk=;
  b=FVZYWBAiuy6EYDPHBlP54fjccP6bDKjyD0U++g/uewv9ZAP/3OqPy6El
   1JVVfDO4IHBjn7ce3qif70E16UqfBsPNrOZ/b1i8ElC1Skoj+s2VWyEZO
   IN4GgPYRexTrj/KvEL8e8ZQuq9Hcj4wOqEAfHabTi/x4Do7naw49tjC2x
   AymhvX+66BKrsmrxHlbLrW6Nnvqlz8T1YfKkPvYj0zy/EXb5XxHIau5VY
   67tc/wv+zi2kogBQRiMH38HDBo0F6L8UuJFb/Pg4F2/IbnvHDLajx739e
   xqFHr5rjIUo5WNHm+AWMHlquvCxftMPrw3peeFeQjkunBB78/hqdqSs3c
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10806"; a="372043110"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="372043110"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2023 09:31:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10806"; a="800531451"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="800531451"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP; 18 Aug 2023 09:31:30 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 18 Aug 2023 09:31:30 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 18 Aug 2023 09:31:30 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 18 Aug 2023 09:31:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lKMmx6M41/jLsQwHWtWPqfmEerjjHkxwOrGHZiGVEIjGRbLbgSF/zrV36R9AuT9D/6jYVT4alZ4Pri7LUWHOidbnvLxaBKL7ICYVawnJSr2ZgLei3EIKovB6UB8i+I/pWQmb6OkKFYhpG2l5/Q/tSY09Wp60McN6bYLAo8KjtK3QhMc/nlNh7I9UNnW6sxKKAEZkcov6KnotDpd1p2TJkXTMKPxMaA1VKhpj521eHnT2ckVqvovpaykmmxogUX+XviRioV6Y1BVLu5cgdbD5tVfrwxS0iXQQ5/X/38dRn9HDMZxrqVIddO272RHqLMZVYC95iMCSoZrywu6Xilu05w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mo6q9izLJTSqR2dlRhEmELXJw5RUEW9x5PeIzE2y1ls=;
 b=axxuXtmzYGAkXpO0i0adopB1LjyMQ34jM/z0/2lTF8AFGQ7gvmgo4yU5xQBQDsA7vcT927QSUcWtbhLKwhUlpJK6mT+dvomeWwPVckg9gSPHh66KkM8yM6gULHdF1ropSRMEcJUQFAgAFsHKkBTsxXn7qLgQWfrpMzO5//wxauqx36FHM90l8YMk/OrezW+Gdy+rMAnzmEgWcuepfITrHvjcqX3GgAkVtth9Ke7QfF9gEQmcHDf7WEhyac9XcWaH1zh9hfN9+B7lBTJMFEdCpL2e7QM9WBPEPrMMgyB6/mWmJFr/HQIoVmhxv5LPDAmwdghn0djUVlYdLke13eEdjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6435.namprd11.prod.outlook.com (2603:10b6:208:3bb::9)
 by CH3PR11MB8413.namprd11.prod.outlook.com (2603:10b6:610:170::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Fri, 18 Aug
 2023 16:31:28 +0000
Received: from BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::91f3:3879:b47d:a1c3]) by BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::91f3:3879:b47d:a1c3%3]) with mapi id 15.20.6678.029; Fri, 18 Aug 2023
 16:31:28 +0000
Message-ID: <0a874b95-b9d8-4379-bda9-4067f01cc7ea@intel.com>
Date: Fri, 18 Aug 2023 09:31:23 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH net-next v2] e1000e: Use PME poll to circumvent unreliable
 ACPI wake
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <pabeni@redhat.com>, <edumazet@google.com>,
	<netdev@vger.kernel.org>, Kai-Heng Feng <kai.heng.feng@canonical.com>, "Naama
 Meir" <naamax.meir@linux.intel.com>, Sasha Neftin <sasha.neftin@intel.com>,
	Simon Horman <simon.horman@corigine.com>, Leon Romanovsky <leonro@nvidia.com>
References: <20230815170111.2789869-1-anthony.l.nguyen@intel.com>
 <20230817191825.18711c80@kernel.org>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <20230817191825.18711c80@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P221CA0012.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::17) To BL3PR11MB6435.namprd11.prod.outlook.com
 (2603:10b6:208:3bb::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6435:EE_|CH3PR11MB8413:EE_
X-MS-Office365-Filtering-Correlation-Id: a6b98095-2cc6-486d-ac85-08dba0089279
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qEPc0BOhpq59WvqM+xkDiAPNZROF6FdjwoQ6A14th5yGmGxLsw6Pf+k+2HNtFb7k8EpHx10DSEHmYVO0gUJ8A/lFTmgmJ0a1wxJIJiDLJ5hQN6r3lizGMl3Ra7z6iIYIRqexa46BR1y+3cPv96hTvBgQsvYmBP7WzMhToYRMQHIqvjHCJ/17FesPbObDR4oime4VPANLWVto5/uUBDVq3VH7r12qWRksu1lRRVs4h2wpAs7pCQNQI2NeSvmmlM+KM/7j9ZJmIQdJ1Q/VViNcgyKOsFb0P+a9MpUXmwLnbEQXGDc4YmF/+lfPdAl2G3P9IFtzqBl4JSOlrCdau4hzFuRgjmcSsyF0QJXCVoDmJNrA/DiGOmpLL0dJ0E0rVvqT+E+Z9Oy3nap6bxYgYbJmGjI4rgD+px1Qd/ZtAwDDZ9oKYyPWzW7R6e3OxGmr5nzIAvou+Ne+XTOHtKV9+Sb4CpEbYm8dH83kvt10ozWmu5jwm3chIulfGdBusb6WbmaP5DKQGH3vagyCHSy3cak5joUv24m1gBwR2c6rPYLdVA2Qt6QWkNSUlQKOUHLUB/1UE4Ie450jZBOO+5aOjYMr1BlIpqlGGKcRTMeqPL/6V/ycYUk16XHeIuQAqJ0ygU0R4SPhYTivKMJgO7HH9NwhsQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6435.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(396003)(376002)(39860400002)(366004)(451199024)(1800799009)(186009)(31686004)(86362001)(36756003)(31696002)(82960400001)(38100700002)(5660300002)(2616005)(66946007)(6506007)(66476007)(478600001)(6486002)(6666004)(66556008)(53546011)(54906003)(316002)(6916009)(26005)(4326008)(6512007)(8936002)(8676002)(41300700001)(83380400001)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K2xmRGNJYUZvVytIb0pncXU4UGpVQWI3Y01vYm03RUorUk9vYlRaNEpXc2Q2?=
 =?utf-8?B?VU9BS1JtSjdxK0ZjbW1ZUTQzbTg2dm5xSFFUK1Q4RjFzTHhnMjU4M01RMTZV?=
 =?utf-8?B?RTRxdnFqVml6YUQzenBYSU9SU0hRTjNvcWEyMU96Y1ZhUThYK3gyd3VnOEVr?=
 =?utf-8?B?QjRiNHFRYUpqWUtLL0Q3QTdzMC9CL3EwejVOSzRpTkw1N2pxQ01xZS9TUnZR?=
 =?utf-8?B?dVNvcEoybnorOFpMWVIvK0Fjdk9zR3RhWnVSZ2hRS0xZbmIvbk11Z3dzWmtq?=
 =?utf-8?B?T1Q3VVczSDhwamxlcm9KU0hGK0pUMHZBZFBNVFp3RGVtMm9ueHVONDZpanZx?=
 =?utf-8?B?ZkJlS29XdGtlZHBYYk1xcG1tMFVxSnEyWWt4U1RNdThiTHE2RGVpWUxHVmo3?=
 =?utf-8?B?VFJUUDRaNkQ2amtCVWg4ZGY3NXY3QUd0aXExUm9MUnB2MWZYWTdoUTh4bE12?=
 =?utf-8?B?Mms2bGJWdHlUUEZ6amJGM1JOMTRVR2R2RHhnbmNSMjBFaWhsVjd2SDlDRXpB?=
 =?utf-8?B?OXNxS1BEVEExelVBb0lpSTZ5VVpSUXNrcHJEeVpybHl1dnBIdDRvQzFjcGNR?=
 =?utf-8?B?amlENGVtM1JvYlFkRXJJY29IZmFMSnhaNUVYbWJhaWJHN1FBclhYU1NPTGhx?=
 =?utf-8?B?dnFOQUN3SnY4dUdHUWJpU1pPQkFrQXhDaUpRQmZWQ0tMQmRaakIyeUIrQ1Bv?=
 =?utf-8?B?aFBiQjVHQXJac04vTmRuelVyb2JyUkFpNkJVVExJZkFsN1dBWEV2cUpqcncy?=
 =?utf-8?B?REI2VzlrUGJxenY1dG13d1dGR3hoQlR1K09HdGwyTkpyZFdIVGUvd25EUWI3?=
 =?utf-8?B?QlY0ejhXREs2bnUrdFJHditDRkxML3lmckJHOWIwWDROdjY5ZjA5MWVyYzZv?=
 =?utf-8?B?SW1rNzgyS1g3MCtZOHkwSFd4elptd0tzTVFnRThlNk5IVDFJMHN1WU1hYlJN?=
 =?utf-8?B?eHZoZnBRZzVBUExBK0YwcjZiejJuR3QrK3ozZTJsYnRuUG9ERlJhNG5BWVZy?=
 =?utf-8?B?aTFWQk5NQ0d1S1RVLzdZWm55T3V0UWdvR0NTR2RqekRkM0FyYm8zbDZSbU40?=
 =?utf-8?B?bG9oMkprc0MxNy9CTG56N0p4MytmSFIxQ2lBYzdqcDBTQnU2dDVKREovS0NR?=
 =?utf-8?B?NFFnbW5mZUZBZFl6QjEvMHhIR3U0SGk0aGc4K3U0Q1grT2l6cTdlUDJXRTNP?=
 =?utf-8?B?eW9SWUsvMzRpVnQ4YTdtYUZYdEZid3k2MlVOdWduUWE1ZW5tYjF1Rk1VdXBk?=
 =?utf-8?B?dSsyUGZFTzBiaFV2L1czUTFlNTN2N2NycGJhN0R3K1FsYldsRnZ4SEtSOEI5?=
 =?utf-8?B?aGdyM080L2E3bUxqOG9ZbjJlRzRNbEtDdTFIbnMxTzN3b0NvVXVjYVY3Ritq?=
 =?utf-8?B?N3pobytsNzM2WDZqa2xDV1JJVGIwLzNCZXpxWmZWUDFkcm8yRUp2T1dJTmhG?=
 =?utf-8?B?T0k4ZVNGeE53eC9KdVhRUjBjQW9zM0JDRkhqSEVKUW1aaFVnNWMrS0twMVBj?=
 =?utf-8?B?V05jNlZTNmZ3YjVGa21od0NneEhKN0czSTlKTHFkUXB3ZnFTbWdqUVRmYlly?=
 =?utf-8?B?aTVzdzhuK2hYME5SRkVxTk1NZ29qYzRWL0hoU29KaEVhUThlUVlqc05yOE91?=
 =?utf-8?B?cC85SkdFcHFBMjZIcVk3dCtrL29jcXBKejFSZWQxZ2lOQStvNjFVMEM5SmRN?=
 =?utf-8?B?OHZtbE5iMmVRSDFwRTRzaGkrTnI1NGdLQWtSZGltV1UzdDVZZ1NNRUhUalo5?=
 =?utf-8?B?R2JSYjhIK1oxWjhEK1U1clM4TlZHb2JIemtNQTgxOHNnUkY1MGhhKzJITis1?=
 =?utf-8?B?SzFvVTcvTGRqTTIwd0NyR3F5VmZ3WFN3QktHbUJ0b1JDZUtlNDdIYUJSU25x?=
 =?utf-8?B?VmREQWxxYTdoR29ubXVNRmU5c3JnWTBMQjdVTThuU3AwR1dEYm96aEpMajI3?=
 =?utf-8?B?ajAwL1N2dFgwS1JHVDNtRml3Umh0dGxTMWpuSWloNGpIMVJnbk9tUExPdWNV?=
 =?utf-8?B?UTZGNlhMZ250YkZsam9lTWFVc3AvWS9wNVRzNFdxeFVxU0Q2VVgxVXhmSkJh?=
 =?utf-8?B?UXJUdVBVUVMwM3E0elJCSDd0aWdKUEFuT1VXOXpMYWFoRVQwc1YzVTg2WENS?=
 =?utf-8?B?ZzdNVFVtaDhzVTJFM0dLbDZDSDZBb2ZlcHJWRGxtZHBidDJSZ3dGL0IzZkgx?=
 =?utf-8?B?TkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a6b98095-2cc6-486d-ac85-08dba0089279
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 16:31:28.2975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Aq/3wSQFo1n8qNmrEoJSj4Or5HRm6njnJr45dIZW5FrEjfTUGPnm9sxPtcnOngU6Tx+Ii6huTRS+HgT1/e6368Ae3ECzFr3noJ5PDmB5HU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8413
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/17/2023 7:18 PM, Jakub Kicinski wrote:
> On Tue, 15 Aug 2023 10:01:11 -0700 Tony Nguyen wrote:
>> From: Kai-Heng Feng <kai.heng.feng@canonical.com>
>>
>> On some I219 devices, ethernet cable plugging detection only works once
>> from PCI D3 state. Subsequent cable plugging does set PME bit correctly,
>> but device still doesn't get woken up.
>>
>> Since I219 connects to the root complex directly, it relies on platform
>> firmware (ACPI) to wake it up. In this case, the GPE from _PRW only
>> works for first cable plugging but fails to notify the driver for
>> subsequent plugging events.
>>
>> The issue was originally found on CNP, but the same issue can be found
>> on ADL too. So workaround the issue by continuing use PME poll after
>> first ACPI wake. As PME poll is always used, the runtime suspend
>> restriction for CNP can also be removed.
> 
> Applied, thanks!
> 
> I'm curious - why not treat it as a fix?

It came to IWL this way so I'm not sure if there was an initial reason 
from Kai-Heng, but there was discussions with this so I felt safer 
sticking with -next.

Thanks,
Tony

