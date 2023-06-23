Return-Path: <netdev+bounces-13365-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D46473B5A2
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 12:44:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5A8F1C2102E
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 10:44:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67405230E2;
	Fri, 23 Jun 2023 10:44:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536D515A2
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 10:44:47 +0000 (UTC)
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C4210C1
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 03:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687517085; x=1719053085;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Uv5d3Q32ScV0tv/DePyvvHE0g+2FzHxel24QMw9sqfc=;
  b=DybZkV4ea1+X+ZOpkdWH3cPP+SQy5pL2NWOee9cHloK3O1BCXncIw6ou
   wHxzxSCTmMrj593Bi0mfelB7W0XCY8ITqtktaEh6jPFtN7ag4TEhQGzoq
   Fv+CRkAMtI1ntWt0h+H6/AAbgES5pUXxmj7rTGiIvTqGQlLLXv30Ie/EU
   zYuwQF2lhJRr+UOUniczMii2xVpkafy5I7fqm+8uCATcKyjcPex9MdGjS
   A6vyXv0mo/odqbjJSLNYgfL72reRhpxZFehT6cMU92dfPY5BI2gwuc8gg
   d0IZVdQMrGyRs0u54NV1zppFFkhGaUtavc8+YkZvg+vRaC1eDYPDD8dYl
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="390691698"
X-IronPort-AV: E=Sophos;i="6.01,151,1684825200"; 
   d="scan'208";a="390691698"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2023 03:44:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="692628868"
X-IronPort-AV: E=Sophos;i="6.01,151,1684825200"; 
   d="scan'208";a="692628868"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP; 23 Jun 2023 03:44:44 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 23 Jun 2023 03:44:43 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 23 Jun 2023 03:44:43 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 23 Jun 2023 03:44:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TKlhDgbFRu6QEZ/cxBe1LOfAzHEbcnEhbnBUvL0DX+XpPFkqACDuIioINF42n04PMF7AyIIkkWrhea38pkJ4LkMU76I09V1wrMnpGaqMyWJlYfbhnRGpvZ50Xbh0l98V3srBiaSfYAq8jIwYTz6Gdfgx+Q2Vvz89xb0df5PDByjp9Mz38FpFgRftWXrZs5SLAkeAPUwQah3nhQWJTwTawgdEXQZ+mUpGfsWWc4BatjqxXpsvgvmo9P3gTPOzKyudfFgpMaa/tlVwsITo0OuedfU8pdauHb30gV0oIArRhYA0mjUDIIS6J0jfGtVq06Jes+cWnR+PZbkQuG0s2F9yVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0/FvHUOa2dDrCBHAKFG8FbRwHgwyxT3h87C2u+//RC0=;
 b=E7aH/Fvc5EHqscjT2Ei8M64j8ZLXGG5solM0RPtGyfBrXL1Rz5UMjHE/+d9eTSH9NAIDkeT6/TO+lQ7pxOwq1s2Dml3Y7nnnCLdZmqyQgpYLYktQpk+ILWF3QaYvziGB/qNaRtnDA7nhW7bSy5D9FekH5p9poQdxlv2YhhYa2WGHnMecHYqkrik+lFynWbeEKpOWM4zog+3fbLJLWhQueh2Nh0e0ltmJCwOooF/qDNID0RVssir0crja9oQyr9mDl2FB1yAl91H2pGnD8mx1yJG8um1w8kwCIEdL8A30IJijN3kiolIcGGL7tp6TPfFg8n5+8G7hblMJj5gHUNTS+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3672.namprd11.prod.outlook.com (2603:10b6:a03:fa::30)
 by BL1PR11MB5336.namprd11.prod.outlook.com (2603:10b6:208:316::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Fri, 23 Jun
 2023 10:44:40 +0000
Received: from BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::87ad:6b1:f9f4:9299]) by BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::87ad:6b1:f9f4:9299%5]) with mapi id 15.20.6521.024; Fri, 23 Jun 2023
 10:44:39 +0000
Message-ID: <ffe3bbdf-eb26-5223-c1ed-1bdbaf577d84@intel.com>
Date: Fri, 23 Jun 2023 12:44:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH net-next 4/6] ice: remove null checks before devm_kfree()
 calls
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Tony Nguyen
	<anthony.l.nguyen@intel.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <netdev@vger.kernel.org>, Michal Swiatkowski
	<michal.swiatkowski@linux.intel.com>, Michal Wilczynski
	<michal.wilczynski@intel.com>, Simon Horman <simon.horman@corigine.com>,
	Arpana Arland <arpanax.arland@intel.com>
References: <20230622183601.2406499-1-anthony.l.nguyen@intel.com>
 <20230622183601.2406499-5-anthony.l.nguyen@intel.com>
 <ZJVyiOwdVQ6btr53@boxer>
Content-Language: en-US
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <ZJVyiOwdVQ6btr53@boxer>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P302CA0033.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:317::8) To BYAPR11MB3672.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::30)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3672:EE_|BL1PR11MB5336:EE_
X-MS-Office365-Filtering-Correlation-Id: 91d0868b-0d54-4c2b-49f4-08db73d6d820
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hK8RXcJQiLzk7W/bIo5bs3xVVbW4hd31l2OKtEwYpnmEHwpPPsVsq1DTBn70ujMWpBzbWltO6+75wlYs2Az4HYvY/I5e9WCkcxvMZd7Z6tVfUSGoua1zcawPVt+UbU9sEFH+y1qz0aqsj6x4lfFvrLXyiD3py5/knbxA2hctm1JkuSliutsbSm1OS/gecN3OwRPUJnwVK+UTDAYNr1CWGeZsYXU1mea8Yep1rSVGiJMKvguSBNjekUTqP/tRiBwvbW74EKbLDuJNnA0XK/yLrbHRkdFN3OtOVzU3fL0UoWN7hLKS/KwuxkvsgZCuTfPFmCuMiKLueMVQhgtGMVpo8Nh6UU2U4aItC8ymvkoM9Zrl634MCLvHc/ij6oIE8VOQyy3p+3jVhCMfz0G2x7lf3J9rDjf/YPYUVmdSqwl0GAdXzegYjFyf5sOGMvvloJVNrRQeJlPcHkaNED3//5nv+IVJWmlK7T+trpyeMu9mx2Jwl+qUqG6vTjWvY8apxu5boAMb7kQBYqZ5K2p6oqDqiUB0XXnnemaWxvcLOQ/I4RL3LX35XCBt/80wEzfyBk/iSdjIzDBxUH/dtNnzdVcG+YpAJL8Xuo7FD6d3B550yEsTFMxb10NvdSm/HJQUszkY4yxn0i5rx+rhOi8XcpEl/Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3672.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(366004)(136003)(376002)(346002)(451199021)(54906003)(110136005)(478600001)(66899021)(6512007)(26005)(6506007)(53546011)(6666004)(6486002)(5660300002)(2906002)(36756003)(4326008)(66556008)(66476007)(6636002)(66946007)(31696002)(86362001)(8936002)(8676002)(41300700001)(83380400001)(316002)(31686004)(82960400001)(38100700002)(2616005)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M3g3Q1dydG56a1VTVFFEeTVZWk0yYWNkaUhlMXlmYzNNL0dOMXd3NEoxWHR3?=
 =?utf-8?B?cjVESERlUU1GQ3d3S1hDNDY4MWFOK0RUd2VUdktZd0VKeEJCakJvbUdEWjlJ?=
 =?utf-8?B?VGNyQ1F3Vms0OUhkaDlRc3VCRDlYM0JQd2lRK21wamNCa1VpUExLTENQd2Ja?=
 =?utf-8?B?Zm5yYWl3T1VMaG8wS3FTdlNVMkJUOHp5QkFkRStJOXVjOG9jTWo5UG9SWWht?=
 =?utf-8?B?L2djY25QVWdSU0ExRXh0aUN3OVVMTDd3TGJuZ1RYamVSVVBTNXpEeklIV05w?=
 =?utf-8?B?Q1VFcFc2V0VmOWpsSzlQeFphQWZkYUpSRE4yZFpoNmJwYWRkWjBxVnpib0cy?=
 =?utf-8?B?OGp1SjRESFh2djFTUU9DWEtNZjA5UGQrazRMc0xLeTQwa21vOEY5bDdYbWE0?=
 =?utf-8?B?N3pudEhYclEwd2lZTUZEMVBZclVHUlJML284d29BelFFaFBJcWFkZDYyN29W?=
 =?utf-8?B?SEFCVjhzcXlSSjJOZktLL3RzRHNkQ2dHdTZZSHBobmtGL0psT2gvUE9xTDV0?=
 =?utf-8?B?TXlaVnNkSnZLQXhKRjdRSFJSVmd6a2Q0T1JmYWVwYW1vcVhBdGdXOThXNmI1?=
 =?utf-8?B?dVRtWitwNGVwTkx1dzNKcnE2b0dDdk53VmJVUjhCalRHOGYyZXlrdlBkSkRD?=
 =?utf-8?B?a3NQaVdVOUl3MW1zTVYvbTFzajRsOFpnOHliVUUraFV3QUtXbjdhVVhmK2RM?=
 =?utf-8?B?WWRTTEs4UGY5S1JYQWZ2aEE1NFI5UUl4bC9TT2I1NjBiMDBqUkJnNXZoR3Yr?=
 =?utf-8?B?NmZOMXMzVUJQM1NDbVR6YmZXRmluWHRmdGtOR2FVNmxiUVZlRkFrMlpXWHFt?=
 =?utf-8?B?cWtMMG52UFhVUXdkVUx6SFZSZzNKRTdWeDc1bllNOFQ5TU1UaWovSUpuR3k1?=
 =?utf-8?B?TUdIVlRtN05MT0M2MUwxSlhzaytPS1RJZ3R3Wi9BYUNiUE1XNEtuV0p2U0NK?=
 =?utf-8?B?MHJTd0xsdHN1cVYzR2FLRFl1ck1JQkowaWlJWmNqbFFLYXRiNHZJVnBNbFR5?=
 =?utf-8?B?TnRDSEJsSXQyS3VhdFQ4Y3hYc3BOM3c0OFNWSDFHUEJndzk4bGJSSXNCWXhC?=
 =?utf-8?B?MklUZCtFOVdnOHh1RE42MXoyQ1NGQi9laEk2YTNVV0xxWTc0ZDJpV0d4ZjRY?=
 =?utf-8?B?N1VzL0M2dm9DVmM5alJyUHFqUkZsemhKUTJTbHhXWlpnL0lWcDhtN1RqQzNa?=
 =?utf-8?B?bWwwcENMVlZ1RDFUNk52UFBMWmRGZjhPaGdFUkZkOVllMVZCaDNTUjBQQW5k?=
 =?utf-8?B?SUV6LzQvMkhYUFJNdHRBeWUzK2J1Y1ZYL0NPT2hNZ2VXTjBmS3pVcUpmUzFD?=
 =?utf-8?B?RnB4S2ZiV1l4QUpnZEdqdmtXSEtxQlBIR2tSa3AvaVN5WWtFYWFhK1VBMzhG?=
 =?utf-8?B?Z280TW5vQkFQNEorYStVVlpNTTNOeUNrWkI0WkdHRlJ1OGJ4Tm5KbmtCQjVU?=
 =?utf-8?B?bnFUL1NHTFNwNkN1Q0w2YktndEkvNkN0d0VsRU9YOTlTYW8vcFRCMjhqYThU?=
 =?utf-8?B?bTlDeVFSUkIvZE50Mm4vdGFTOGowYkJ1emhlLzN0a2Y4REdYdDdSbFgvTnIv?=
 =?utf-8?B?b2VXUlFQd010R1J5eUwxUzhsenE1dFo4SU1MN3dtR25DekVnY0dmd1BpK0JW?=
 =?utf-8?B?bjJlM21hU2Yvc2VDd05Wa3hYdWxialNTVTZFcWt0OXB3cFBINnN6RENBMldn?=
 =?utf-8?B?YXV4TFBKcFN5dG5DdU5KSmI0MnBOTS9pWmtBZkJoeDVVMFd1eG53TEZOZFpt?=
 =?utf-8?B?UzIybllXaWtBQjJMeWk4VkVmOGw1Uk5LbndDMmx2S3NVaC92SS9oUVNPblZN?=
 =?utf-8?B?SXlDMlNSY3JDaFdEVE8weGJhVjhyM25hMW8xQXlOMnFNQmc3d0t2K1dBUTFV?=
 =?utf-8?B?akcxbHhzSzVHTlBjQjNtNjFVT0V0UmhtOHhJQUFhM3JLWThMSCs5ckdYVWhF?=
 =?utf-8?B?S09JdXpxcGlQdmJ1TysvUTlmejBuTTc1Q1hGdHRHbmxnOGJmQUFNaVdaTVk0?=
 =?utf-8?B?VkZ2cnY5dkJab25ncTV4NzltYXpUSnFJN0l4RFhpT09PcG9EN2JxMExsZmc0?=
 =?utf-8?B?SkhXSFYxdGdUblRCdjJPd1NtVHNWTU51Ymh0M09vc0psa2ZnSTVVTnpzeGo2?=
 =?utf-8?B?WUJSdFg5dVoxZEFlbHcxVzRMYXlKUndmRlJ1L0VQQncxQmlKTUtvWFBhOXNL?=
 =?utf-8?B?QUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 91d0868b-0d54-4c2b-49f4-08db73d6d820
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3672.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 10:44:39.1853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cpU4qzO5QO3ctoL/wtWl5O+bbl4gEH7ElwTm4FYZDOTbw7UakbWFCp8Ow7u5OdnTeuVPeVG80i5hVKiJY10CrL97XKeOL6WVJ9hitHi3tAc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5336
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 6/23/23 12:23, Maciej Fijalkowski wrote:
> On Thu, Jun 22, 2023 at 11:35:59AM -0700, Tony Nguyen wrote:
>> From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>>
>> We all know they are redundant.
> 
> Przemek,
> 
> Ok, they are redundant, but could you also audit the driver if these devm_
> allocations could become a plain kzalloc/kfree calls?

Olek was also motivating such audit :)

I have some cases collected with intention to send in bulk for next 
window, list is not exhaustive though.

> 
>>
>> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
>> Reviewed-by: Michal Wilczynski <michal.wilczynski@intel.com>
>> Reviewed-by: Simon Horman <simon.horman@corigine.com>
>> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>> Tested-by: Arpana Arland <arpanax.arland@intel.com> (A Contingent worker at Intel)
>> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
>> ---
>>   drivers/net/ethernet/intel/ice/ice_common.c   |  6 +--
>>   drivers/net/ethernet/intel/ice/ice_controlq.c |  3 +-
>>   drivers/net/ethernet/intel/ice/ice_flow.c     | 23 ++--------
>>   drivers/net/ethernet/intel/ice/ice_lib.c      | 42 +++++++------------
>>   drivers/net/ethernet/intel/ice/ice_sched.c    | 11 ++---
>>   drivers/net/ethernet/intel/ice/ice_switch.c   | 19 +++------
>>   6 files changed, 29 insertions(+), 75 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
>> index eb2dc0983776..6acb40f3c202 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_common.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_common.c
>> @@ -814,8 +814,7 @@ static void ice_cleanup_fltr_mgmt_struct(struct ice_hw *hw)
>>   				devm_kfree(ice_hw_to_dev(hw), lst_itr);
>>   			}
>>   		}
>> -		if (recps[i].root_buf)
>> -			devm_kfree(ice_hw_to_dev(hw), recps[i].root_buf);
>> +		devm_kfree(ice_hw_to_dev(hw), recps[i].root_buf);
>>   	}
>>   	ice_rm_all_sw_replay_rule_info(hw);
>>   	devm_kfree(ice_hw_to_dev(hw), sw->recp_list);
>> @@ -1011,8 +1010,7 @@ static int ice_cfg_fw_log(struct ice_hw *hw, bool enable)
>>   	}
>>   
>>   out:
>> -	if (data)
>> -		devm_kfree(ice_hw_to_dev(hw), data);
>> +	devm_kfree(ice_hw_to_dev(hw), data);
>>   
>>   	return status;
>>   }
>> diff --git a/drivers/net/ethernet/intel/ice/ice_controlq.c b/drivers/net/ethernet/intel/ice/ice_controlq.c
>> index 385fd88831db..e7d2474c431c 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_controlq.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_controlq.c
>> @@ -339,8 +339,7 @@ do {									\
>>   		}							\
>>   	}								\
>>   	/* free the buffer info list */					\
>> -	if ((qi)->ring.cmd_buf)						\
>> -		devm_kfree(ice_hw_to_dev(hw), (qi)->ring.cmd_buf);	\
>> +	devm_kfree(ice_hw_to_dev(hw), (qi)->ring.cmd_buf);		\
>>   	/* free DMA head */						\
>>   	devm_kfree(ice_hw_to_dev(hw), (qi)->ring.dma_head);		\
>>   } while (0)
>> diff --git a/drivers/net/ethernet/intel/ice/ice_flow.c b/drivers/net/ethernet/intel/ice/ice_flow.c
>> index ef103e47a8dc..85cca572c22a 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_flow.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_flow.c
>> @@ -1303,23 +1303,6 @@ ice_flow_find_prof_id(struct ice_hw *hw, enum ice_block blk, u64 prof_id)
>>   	return NULL;
>>   }
>>   
>> -/**
>> - * ice_dealloc_flow_entry - Deallocate flow entry memory
>> - * @hw: pointer to the HW struct
>> - * @entry: flow entry to be removed
>> - */
>> -static void
>> -ice_dealloc_flow_entry(struct ice_hw *hw, struct ice_flow_entry *entry)
>> -{
>> -	if (!entry)
>> -		return;
>> -
>> -	if (entry->entry)
>> -		devm_kfree(ice_hw_to_dev(hw), entry->entry);
>> -
>> -	devm_kfree(ice_hw_to_dev(hw), entry);
>> -}
>> -
>>   /**
>>    * ice_flow_rem_entry_sync - Remove a flow entry
>>    * @hw: pointer to the HW struct
>> @@ -1335,7 +1318,8 @@ ice_flow_rem_entry_sync(struct ice_hw *hw, enum ice_block __always_unused blk,
>>   
>>   	list_del(&entry->l_entry);
>>   
>> -	ice_dealloc_flow_entry(hw, entry);
>> +	devm_kfree(ice_hw_to_dev(hw), entry->entry);
>> +	devm_kfree(ice_hw_to_dev(hw), entry);
>>   
>>   	return 0;
>>   }
>> @@ -1662,8 +1646,7 @@ ice_flow_add_entry(struct ice_hw *hw, enum ice_block blk, u64 prof_id,
>>   
>>   out:
>>   	if (status && e) {
>> -		if (e->entry)
>> -			devm_kfree(ice_hw_to_dev(hw), e->entry);
>> +		devm_kfree(ice_hw_to_dev(hw), e->entry);
>>   		devm_kfree(ice_hw_to_dev(hw), e);
>>   	}
>>   
>> diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
>> index 5ddb95d1073a..00e3afd507a4 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_lib.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
>> @@ -321,31 +321,19 @@ static void ice_vsi_free_arrays(struct ice_vsi *vsi)
>>   
>>   	dev = ice_pf_to_dev(pf);
>>   
>> -	if (vsi->af_xdp_zc_qps) {
>> -		bitmap_free(vsi->af_xdp_zc_qps);
>> -		vsi->af_xdp_zc_qps = NULL;
>> -	}
>> +	bitmap_free(vsi->af_xdp_zc_qps);
>> +	vsi->af_xdp_zc_qps = NULL;
>>   	/* free the ring and vector containers */
>> -	if (vsi->q_vectors) {
>> -		devm_kfree(dev, vsi->q_vectors);
>> -		vsi->q_vectors = NULL;
>> -	}
>> -	if (vsi->tx_rings) {
>> -		devm_kfree(dev, vsi->tx_rings);
>> -		vsi->tx_rings = NULL;
>> -	}
>> -	if (vsi->rx_rings) {
>> -		devm_kfree(dev, vsi->rx_rings);
>> -		vsi->rx_rings = NULL;
>> -	}
>> -	if (vsi->txq_map) {
>> -		devm_kfree(dev, vsi->txq_map);
>> -		vsi->txq_map = NULL;
>> -	}
>> -	if (vsi->rxq_map) {
>> -		devm_kfree(dev, vsi->rxq_map);
>> -		vsi->rxq_map = NULL;
>> -	}
>> +	devm_kfree(dev, vsi->q_vectors);
>> +	vsi->q_vectors = NULL;
>> +	devm_kfree(dev, vsi->tx_rings);
>> +	vsi->tx_rings = NULL;
>> +	devm_kfree(dev, vsi->rx_rings);
>> +	vsi->rx_rings = NULL;
>> +	devm_kfree(dev, vsi->txq_map);
>> +	vsi->txq_map = NULL;
>> +	devm_kfree(dev, vsi->rxq_map);
>> +	vsi->rxq_map = NULL;
>>   }
>>   
>>   /**
>> @@ -902,10 +890,8 @@ static void ice_rss_clean(struct ice_vsi *vsi)
>>   
>>   	dev = ice_pf_to_dev(pf);
>>   
>> -	if (vsi->rss_hkey_user)
>> -		devm_kfree(dev, vsi->rss_hkey_user);
>> -	if (vsi->rss_lut_user)
>> -		devm_kfree(dev, vsi->rss_lut_user);
>> +	devm_kfree(dev, vsi->rss_hkey_user);
>> +	devm_kfree(dev, vsi->rss_lut_user);
>>   
>>   	ice_vsi_clean_rss_flow_fld(vsi);
>>   	/* remove RSS replay list */
>> diff --git a/drivers/net/ethernet/intel/ice/ice_sched.c b/drivers/net/ethernet/intel/ice/ice_sched.c
>> index b7682de0ae05..b664d60fd037 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_sched.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_sched.c
>> @@ -358,10 +358,7 @@ void ice_free_sched_node(struct ice_port_info *pi, struct ice_sched_node *node)
>>   				node->sibling;
>>   	}
>>   
>> -	/* leaf nodes have no children */
>> -	if (node->children)
>> -		devm_kfree(ice_hw_to_dev(hw), node->children);
>> -
>> +	devm_kfree(ice_hw_to_dev(hw), node->children);
>>   	kfree(node->name);
>>   	xa_erase(&pi->sched_node_ids, node->id);
>>   	devm_kfree(ice_hw_to_dev(hw), node);
>> @@ -859,10 +856,8 @@ void ice_sched_cleanup_all(struct ice_hw *hw)
>>   	if (!hw)
>>   		return;
>>   
>> -	if (hw->layer_info) {
>> -		devm_kfree(ice_hw_to_dev(hw), hw->layer_info);
>> -		hw->layer_info = NULL;
>> -	}
>> +	devm_kfree(ice_hw_to_dev(hw), hw->layer_info);
>> +	hw->layer_info = NULL;
>>   
>>   	ice_sched_clear_port(hw->port_info);
>>   
>> diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c b/drivers/net/ethernet/intel/ice/ice_switch.c
>> index 2ea9e1ae5517..6db4ca7978cb 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_switch.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_switch.c
>> @@ -1636,21 +1636,16 @@ ice_save_vsi_ctx(struct ice_hw *hw, u16 vsi_handle, struct ice_vsi_ctx *vsi)
>>    */
>>   static void ice_clear_vsi_q_ctx(struct ice_hw *hw, u16 vsi_handle)
>>   {
>> -	struct ice_vsi_ctx *vsi;
>> +	struct ice_vsi_ctx *vsi = ice_get_vsi_ctx(hw, vsi_handle);
>>   	u8 i;
>>   
>> -	vsi = ice_get_vsi_ctx(hw, vsi_handle);
>>   	if (!vsi)
>>   		return;
>>   	ice_for_each_traffic_class(i) {
>> -		if (vsi->lan_q_ctx[i]) {
>> -			devm_kfree(ice_hw_to_dev(hw), vsi->lan_q_ctx[i]);
>> -			vsi->lan_q_ctx[i] = NULL;
>> -		}
>> -		if (vsi->rdma_q_ctx[i]) {
>> -			devm_kfree(ice_hw_to_dev(hw), vsi->rdma_q_ctx[i]);
>> -			vsi->rdma_q_ctx[i] = NULL;
>> -		}
>> +		devm_kfree(ice_hw_to_dev(hw), vsi->lan_q_ctx[i]);
>> +		vsi->lan_q_ctx[i] = NULL;
>> +		devm_kfree(ice_hw_to_dev(hw), vsi->rdma_q_ctx[i]);
>> +		vsi->rdma_q_ctx[i] = NULL;
>>   	}
>>   }
>>   
>> @@ -5468,9 +5463,7 @@ ice_add_adv_recipe(struct ice_hw *hw, struct ice_adv_lkup_elem *lkups,
>>   		devm_kfree(ice_hw_to_dev(hw), fvit);
>>   	}
>>   
>> -	if (rm->root_buf)
>> -		devm_kfree(ice_hw_to_dev(hw), rm->root_buf);
>> -
>> +	devm_kfree(ice_hw_to_dev(hw), rm->root_buf);
>>   	kfree(rm);
>>   
>>   err_free_lkup_exts:
>> -- 
>> 2.38.1
>>
>>


