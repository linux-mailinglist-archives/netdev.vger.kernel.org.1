Return-Path: <netdev+bounces-22986-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4545076A4CB
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 01:22:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC4C3281510
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 23:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E235E1EA7A;
	Mon, 31 Jul 2023 23:22:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4EFE1DDC1
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 23:22:52 +0000 (UTC)
Received: from mgamail.intel.com (unknown [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 703B7B0
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 16:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690845769; x=1722381769;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xyi5logLtOgXC+lO59Vc39GKSY4CEzDOZZXI8Dtx0Bg=;
  b=iDH/4qyJOmATC9hrx++3lemY+97ifQJc1OA1JuJNpMhAo03ZGiyBIP5Q
   2AOxaPrWGryRbLg61ohYcB9ReUQ5RHVngZtwm1kEKFpscEsll++Bafg72
   0/g3p8/eCXTuS98HY3iWIRknnAGOBDac2qMQSe4nsfsOJpPnKLojHxF6O
   QFAAn/0qwFqqYP62o6Nu2ux7RuKY9M5llD6Z40HXXqs4+XT5fQexMoGPe
   hdNnNWdEJYQSPoifp0dblmeLZL2xXYGCXUaGY1BfVe2qP3l86o6Mv7Xpv
   SQpy9GQ/eo01JPDszKkwQi/Nls2Bqv3mikmXMiScApMSv3NW8XkTWcZGW
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="455526547"
X-IronPort-AV: E=Sophos;i="6.01,245,1684825200"; 
   d="scan'208";a="455526547"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 16:22:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="818556864"
X-IronPort-AV: E=Sophos;i="6.01,245,1684825200"; 
   d="scan'208";a="818556864"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by FMSMGA003.fm.intel.com with ESMTP; 31 Jul 2023 16:22:43 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 31 Jul 2023 16:22:39 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 31 Jul 2023 16:22:39 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 31 Jul 2023 16:22:39 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.102)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 31 Jul 2023 16:22:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=laNvuGhKF0FOvuwKtfEFltLRKxO41a/8HNg1cf8NsAQTo9K+UJisCz2Fcr8PY8hfrFkPlU9IfhYVnesNRQdyunCmZVG+M0B8HdA7ULunDKUx4C9gptlSRPoAxiv1UQxpoYUIKj3T8gzP9VcKDBKrnCHLefoPNrLIcl00y5ADesu/vCj46DWh/BkcgsqdPaUqWBCQPlEz2w1nobGz4fRuEV/o9orpT1bgpxyWo+DGxRkQZInAnTArNfjR0CtQtnhZaUF4I0tHGEsu/gNoF0+qs1PENNabxxqygm0xcetIXHIPgFX0cD2fCUj9svCA6L93u7EAk8uyslhvpWJkd1titQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1OI6Lalnfb724YZ0RC4yd/r/2XsWW3nIeZZuQdEDIr8=;
 b=H+S+6t0tr6s7xUq4f4M1kNp9NFhtVsew+b9c5OwTLorBMGnjO7cjTbLcHqFnA5V0rVrHUrvprlpzPq8FzxY9f3CiCmzIsc9cAzdeBHACj/sonzqyThbRiRYRlRfemGL9siFrWM5CajtmYldMEQ362F2dXwQKez7ZoUuM7GObjQzbOBF76hQZkWRKpyoPWu+qQBXg2jtHdeeOhizowJG9jH5TM52o/V4j1CdTeUufJJ5ABq/MWG6GJTnhdVbmdsgCU3268InVbrihZ400XU/A294tizz/knEyz1pMs4ApWMEZu0Jnova5psFGxO9prwsAY32SEZy7E6lkYmXtNiye5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7869.namprd11.prod.outlook.com (2603:10b6:208:3f6::7)
 by CY8PR11MB7172.namprd11.prod.outlook.com (2603:10b6:930:93::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Mon, 31 Jul
 2023 23:22:37 +0000
Received: from IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::12e4:637d:955d:a5f]) by IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::12e4:637d:955d:a5f%6]) with mapi id 15.20.6631.043; Mon, 31 Jul 2023
 23:22:37 +0000
Message-ID: <3a5841c8-f43b-3c6d-ea00-ac9a2b310490@intel.com>
Date: Mon, 31 Jul 2023 16:22:33 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [net-next PATCH v1 7/9] net: Add NAPI IRQ support
Content-Language: en-US
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <netdev@vger.kernel.org>, <kuba@kernel.org>, <davem@davemloft.net>,
	<sridhar.samudrala@intel.com>
References: <169059098829.3736.381753570945338022.stgit@anambiarhost.jf.intel.com>
 <169059164799.3736.4793522919350631917.stgit@anambiarhost.jf.intel.com>
 <20230728210545.279f092b@hermes.local>
From: "Nambiar, Amritha" <amritha.nambiar@intel.com>
In-Reply-To: <20230728210545.279f092b@hermes.local>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0310.namprd03.prod.outlook.com
 (2603:10b6:303:dd::15) To IA1PR11MB7869.namprd11.prod.outlook.com
 (2603:10b6:208:3f6::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7869:EE_|CY8PR11MB7172:EE_
X-MS-Office365-Filtering-Correlation-Id: 36b9e2f0-0c78-4bb1-7ba5-08db921d06c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e4a0mVyHINltwInQqPkhaUmO4PNclEqrMWvMkE6lIBNX9/dexJ+wP4bjPmwDT8De+emh6vHnu9tqGHDgubYc8xylQFQoEVT9mxJYhzLWnptMrm/WgnE8ns+RUnBMCHbgF9U7R5oJyMkt5CY8IbKjpIxIoL7jJTviTR8hLr805ywfmJmX1xvCTHDg4xMYEbEWmeRmkFtSSenHJbjU3fzM7mp8fXxuzTo7f9AheH10q6A1UHOqo5jGM29CkwS7k9eT0+vFvjyQpp6hi+6wvOxwORDYfi78Rg2qO7RrFgrjNooWBYujOv8N1u43/74VbTcO4A+vTcnKqMPl4LpYKCf770a4qG7+DfbvjOHEQXXbZWjBLWVpGMjQrOyBBvJSE+FCoudDYxggRqtaMMFkgSUFvAk7ik9JRcX6m9aX41hb4Q5kx/PGXLwwViYcaWUGvVSYY74j6WBtoMlX2rd+zi/uFPEueuYn1URyuMlq8ub8EhgQ5jjwFxQGTKimiSMBL9p0uTEfEpZiJXszOnOl2a7l6Q6i8s6+IeTBSOFXNzKug/v3s22xWhiDKi3mGCymdS3BUV0QKt4l9rNRWVs12678XEZpdjY01r3+kf+pLV5ZJBLCBF++nWQzrr77qDD1nlPqlkoe4v5Ur1LtYyS/V0s35A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7869.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(346002)(396003)(376002)(136003)(451199021)(6916009)(66476007)(66946007)(66556008)(2906002)(4326008)(31686004)(5660300002)(41300700001)(316002)(2616005)(6666004)(6486002)(8936002)(6506007)(8676002)(26005)(53546011)(186003)(107886003)(82960400001)(478600001)(36756003)(38100700002)(6512007)(31696002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWdnVExZSGYxL3hKdHhQN0tUY1JleEVtVHV2YVBKSytpOGoyZjVMOVcwZC9H?=
 =?utf-8?B?dkxMQlZQVE9ObEc5bXZKN3RhbFJDT0JUN3orTEhBdzdBM1QrU1RYTlAvUnVy?=
 =?utf-8?B?eWVaR1RJdlQ3Z3VvaExhbk9WQ3AyT3lwMGFLNlVSMjZ4NVM1c0Z3RU1kTnFk?=
 =?utf-8?B?MnNYbklFSmhmOFl0eU1aVU1GblRNYnlud0R6N1loR2tYQStoQUo5VS9VOXkz?=
 =?utf-8?B?d281di9mcTlXNXYvcmNEOHFxV1ZIRWIzRG1PYnNjSUpyNTNodWxLTk0yQUxt?=
 =?utf-8?B?czdqSG1nYlZYQUV5Njl6a3BEV1I0QWFZYU5OYitZZlhUeHR3OWNZdU1OL3BQ?=
 =?utf-8?B?MmFRRnc0b0FRSjEzMDV4dWl2VkthK09aMmpKZktCakR1V2RnYTZ5QU9RZ0oz?=
 =?utf-8?B?d2hnRG9ZTGo3UWZUMk1JZjU4REN6dDNnUUpSL0ZwNkRWbDNxbVk4R3B4ZEpN?=
 =?utf-8?B?bWYrMU03VDJPSk1id0hkZTVDL1FoalBYL3ZSRGEyQW5ISlFDZ1Z3cDB1ZG5N?=
 =?utf-8?B?Y1JiOXY0ZGNVYlh5UHVzTXFoZG1PaDNNcGJIOW11S3pJTmIrdW5vVEFYamVF?=
 =?utf-8?B?d0JzVVd0bXN2NHpvUDN1cDBLWVZpUGo2eVd6cGtUWVhEUlNFNUx6MEJybjJW?=
 =?utf-8?B?NkxWcW5QQnB2QlkvWG54dlJmYzM3YW9xcE5ubVo4RjJrTlVCa2VQZWtaemdV?=
 =?utf-8?B?WVJXS0hCSEVLRGZsR0JPdE85cFVLZTR5ekFlbTZXcVVkZTZZV3IydE1JWllT?=
 =?utf-8?B?YWhyaVIzTy9USnFWVFZpM2RETVpFV0R2aXRRMkhJMWF4VjMzcTFJZTZIZFVP?=
 =?utf-8?B?dERlOUdRWVg0SmZMOVdUdEFCTW1Ga2UydkN1QTFwZ1Y0dzhhNkFTeXZUa2dt?=
 =?utf-8?B?NFozTlV0MDNnQXMzbldSdHRHaVo2QTk0VFYwYmMwUmRtUml0U3FZRHd0azRZ?=
 =?utf-8?B?NVU1bEJFSjdjSHVqZXZwOVJuSHo4RFVqcXdUa3RrYUVIU3MwUEhDMDgwZVc3?=
 =?utf-8?B?eWlpS29TaVUxSUNyTmd0K3dHQ210eTZNNS81RnlGWGNjaW5qZVpuYmg2VkJC?=
 =?utf-8?B?R01aRnV5aEFFdVY4WnZ6eFdFUEttM1pzOWgwU3RmYzI3bXVpRU1GUDZZUXk0?=
 =?utf-8?B?cEVkWE1USmhSL2M5b3JDOXlRYjNYdUZlNFlwSnZLOG1YWmFmVmlmSFkzaVlD?=
 =?utf-8?B?cnhPeEdTOWt6YkJONzZ2RFdIYWxLVXcxRmZvNXcyK0Z2VzVMdFl1Nzc3dDh0?=
 =?utf-8?B?Mys2N1k5OE4ydDNhWVhKRVllbElPUG5xQyttejZTK3pjT0RyY1NqRUptZFhm?=
 =?utf-8?B?UmtmeWUxR1NGUHl6OERNYXRacmVIZzRNc1o4Q05nOXErR3FCak8xRlVHTzhm?=
 =?utf-8?B?RnVzSGpnclhTZXFFQTFUMmJqN3NucTlnQXp5elJkZ2J5TkRtM08vVzZwNzQ5?=
 =?utf-8?B?Ky9odmUxMXBsL1FocWsxSFVkYUhnNmtOOTNUblR4NkZIejVuOVdoUXFRQThP?=
 =?utf-8?B?WUdVSGNNZ3dTTlEwKzRDUmNOTis4QXlwN2xDMG9sUHFIaUZ6UENTNXZPZFNF?=
 =?utf-8?B?N3N1dmNCWXRFbFpqaTJMVytXd21YQjhQbXBOTm5iOWxQWTZzSDlHRTdONlNL?=
 =?utf-8?B?OXV4SmRvWGZ1dVJMUzhQYythWVgxYVRTK05sMHJLNnZUU2dsRGpycFhvSnA3?=
 =?utf-8?B?UVNXKzJ6VW1ZTmVjTGlZeTZsVWNGRnhtV3M4RTc2Ly9zejN2NmNZVVRSTzdD?=
 =?utf-8?B?bXgrL0xtUWNXQkc0L2xsNGgvWTBYZUVGcmFxeXRHbHBWMktpYUs0SU9kb21X?=
 =?utf-8?B?MDhudEtLSlZwc2J5R1dWcU9LdTVkMy9DTUc0VUoyLzl1V09SSkF6UHJqV05N?=
 =?utf-8?B?MWEwelRrSDNmcjJsQXY0RVJkYlFrWGY2VkN3SXR1alRqdXI5QXpyeENObzEx?=
 =?utf-8?B?anM0M3RsNDRCNzQrQlEyK1JGbFJ3dDJLcG9nS3pBY20vRG5lV1E4L0x2Q21R?=
 =?utf-8?B?cTNZeGtCSEkyazl4RTVjR2R2Y0RzNENFbWp1SHp6V0VqdnpsTkY4VTFFYnRX?=
 =?utf-8?B?UGVRbnJPc2xCek8xS2VoTFF6b0NWejVVNE9xWkdNWW05VnJITk1MSVphR3Rs?=
 =?utf-8?B?S2hJVlFuWkpMWlY3bWNhSmltczErWVFJMEFPNE9qZm1XWkJnbWczUFlwc245?=
 =?utf-8?B?UlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 36b9e2f0-0c78-4bb1-7ba5-08db921d06c2
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7869.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 23:22:36.9860
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zsSk6QZZi0ZNbaEGRHTziPrdVr1PVLFcs0fCb3Ns2Q+pWA0KXpdn5CuIBhtX1lNHDlls4c2aJVK8XNf7Ix8AGcllt9U57/EX2RN/MBAKQZc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7172
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 7/28/2023 9:05 PM, Stephen Hemminger wrote:
> On Fri, 28 Jul 2023 17:47:28 -0700
> Amritha Nambiar <amritha.nambiar@intel.com> wrote:
> 
>> Add support to associate the interrupt vector number for a
>> NAPI instance.
>>
>> Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
>> ---
>>   drivers/net/ethernet/intel/ice/ice_lib.c |    3 +++
>>   include/linux/netdevice.h                |    6 ++++++
>>   net/core/dev.c                           |    1 +
>>   net/core/netdev-genl.c                   |    4 ++++
>>   4 files changed, 14 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
>> index 171177db8fb4..1ebd293ca7de 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_lib.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
>> @@ -2975,6 +2975,9 @@ int ice_q_vector_add_napi_queues(struct ice_q_vector *q_vector)
>>   			return ret;
>>   	}
>>   
>> +	/* Also set the interrupt number for the NAPI */
>> +	napi_set_irq(&q_vector->napi, q_vector->irq.virq);
>> +
>>   	return ret;
>>   }
> 
> Doing this for only one device seems like a potential problem.

For devices that does not call napi_set_irq(), irq will be initialized 
to -1 as part of netif_napi_add_weight().

> Also, there are some weird devices where there may not be a 1:1:1 mapping
> between IRQ, NAPI, and netdev.
> 

IIUC, there's a 1:1 mapping between IRQ and NAPI, and need not be mapped 
:1 with netdev.


