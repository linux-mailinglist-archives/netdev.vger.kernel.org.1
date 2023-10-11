Return-Path: <netdev+bounces-40191-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A44A7C6146
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 01:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 545AB1C20A08
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 23:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D2D22B76A;
	Wed, 11 Oct 2023 23:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ffgmi4u4"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7098521A09
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 23:55:35 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82DA90
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 16:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697068533; x=1728604533;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7FvYTsP1xNG3gxnr3W4oV50Pdq60I5PI3gDo3ELcSog=;
  b=Ffgmi4u4BRAgKBL7SujGDMIIyMzArlH1SYI2b/n28hRo6evsAfRuj8wt
   gFybza08X6bGwCdwBcS3GlLIdYmuxTeD9RZS05Q9qCFhWRhnDp21ie/3j
   yxvrc/rJymREdcmAKfDkOxRa5N3yw1eNdX0Qhd+G/R6j66BRtLiuh6GM4
   LGJCFys0ji5GklZ/k3QOT/VbkpmKTQ/2+106yxKrwx4Lx+J5gth+HrQNM
   GZ3svppSu1VnGg2PlQB0t51InsyUXwem6R5hiUAbm0CDuXQaHgMYURH01
   Y7ovJ1xMdtcDCQpOZpjk0kUqRMIC9Qm9YXtBUAWA6OU5Pi8J3G65azA6V
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="369865040"
X-IronPort-AV: E=Sophos;i="6.03,217,1694761200"; 
   d="scan'208";a="369865040"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 16:55:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="703932971"
X-IronPort-AV: E=Sophos;i="6.03,217,1694761200"; 
   d="scan'208";a="703932971"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Oct 2023 16:55:33 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 11 Oct 2023 16:55:32 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 11 Oct 2023 16:55:32 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 11 Oct 2023 16:55:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VE3y4y3/5ZRZI/5PUSiKdBOBXbG4UEPTjGKP++rgps/U2sqRE43mbGqpGTd7V2gn/ugY0x7FNC2FjB7BhFzl3tvfI2d8yZq6gsn6OPF7EJNxBRQAJbUzMsYc6E7xCzTtunIH2H6pfDCR75HFKcqtPjY9dEQYtlJwdya+MqDTeyfTRBmgQpbHuqTbrbxGIQy7hUwrsJLDYj3ctV/Y9X28tMXeeITSKIA8nE4GvKrNK1ZrYWxsN559e3DMxAN/I/RVsVt9RMpVPsLIfjLsIGrWkagW1pW40yN4GkTd6iJyIXiEhoQDViSPPysoJeetbReivOBUQWnnqmkTHPRm+ZpeGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4q1QHbUHo/IYDwFEM2Zk2LJFzMQNilbbDjCchREgYKI=;
 b=aHJrHG3vcC713RE4KsO1wl9ZJPrqA4k/R3dkaOPUQa1WeCwXa2G/r1uy7d/o2H/5q7nAuFox8tpfi8n29gMy65IYRpl3qeTX4ugiLkQkbNsRy9BM0nJ6qMQoxHp/L95JTbDztXIez7pUiSXBt8FVrLIavfriP3LHpb0nYlZM+Oq/g6lRdZYFuNSEbtducdENpH9naGS6TMGIo/vnVpxbxPrqgZQTiiA6kJyJdRNfnusfA7veOPXQ4ZM3M+JWBD6ralGyE8hucbQJu4rikH0pg+j1stLx48c1F+d7IoGucTdK9bPdx0oWiBVzFtuozbTV73OR3uB+qBLAnujW89dpUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7869.namprd11.prod.outlook.com (2603:10b6:208:3f6::7)
 by DS7PR11MB7886.namprd11.prod.outlook.com (2603:10b6:8:d8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.42; Wed, 11 Oct
 2023 23:55:25 +0000
Received: from IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::9817:7895:8897:6741]) by IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::9817:7895:8897:6741%3]) with mapi id 15.20.6863.043; Wed, 11 Oct 2023
 23:55:25 +0000
Message-ID: <89632a2a-1f6a-4c2e-aefc-337aa250549c@intel.com>
Date: Wed, 11 Oct 2023 16:55:24 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH v4 06/10] netdev-genl: Add netlink framework
 functions for napi
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <sridhar.samudrala@intel.com>
References: <169658340079.3683.13049063254569592908.stgit@anambiarhost.jf.intel.com>
 <169658371009.3683.2263972635869263084.stgit@anambiarhost.jf.intel.com>
 <20231010192926.6d938d4e@kernel.org>
From: "Nambiar, Amritha" <amritha.nambiar@intel.com>
In-Reply-To: <20231010192926.6d938d4e@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P220CA0022.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::27) To IA1PR11MB7869.namprd11.prod.outlook.com
 (2603:10b6:208:3f6::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7869:EE_|DS7PR11MB7886:EE_
X-MS-Office365-Filtering-Correlation-Id: 960afe23-588f-4325-97eb-08dbcab58976
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6vPA/xdhZnaHe8dV39wFQsz50AdDYgv+/c3VJ7kPib+3axTiBBcFHbjZzG3OEVuuhIaHXAOxvQARFKwf75YHeu7ZHowJBlJ/jqhoictidfrR7tewsyLYZ+5Nub1LawxdrHflEJC0SHuJ/KVkzHUL1Ti870i94KzB+XFG0ATD9j3hQdH5ZmreQlTDtOblc+pcqTxNV1UjDCxu64pGQwck7l84RBewp6KyGFo+dRv5xy3k9R89Okv9j4CxZrM+jcSrZHtA7je2/a9oiuQkVi0PqJyfu69ZYFzTGJcOD1IoHbQtngxh7Umq1PPhXIALcB8arsnpPfvYnsosU/PaPaHO7vmaTBDFbVPcdqId7KXHM0ZVY+CnL5d5oPiRc+7Xfl14nuL7FMT3bOFY64ZmhQD+/5WmUsrnzIoiAe3Iv9Jhnc9bFtXWRTFGWU/YimDI+YYr/bB7CpfvpENnWe3+NzPEJGRjL4RbcH8ZDVWVaeYMgkSBGPZz1f/THtHp8YCIkKQhEkrzEo9asCYgWdfac26hCuT3Ww5OWbVqdRxfTKIcn1Sjw2d6NYqAqMH5OfwyTOxkBy6L5t/Pmkh51TLHOYDT48KksxnjidzwTR8UNn3UT9gYOyJaBEokPtaY7mtuATUUeQA7mi1BzICFa9X30b3cVA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7869.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(366004)(346002)(396003)(136003)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(53546011)(6506007)(38100700002)(107886003)(2616005)(6512007)(41300700001)(26005)(82960400001)(66556008)(36756003)(31696002)(6916009)(86362001)(66476007)(66946007)(316002)(5660300002)(4326008)(2906002)(8936002)(8676002)(83380400001)(31686004)(478600001)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enJDamwrd0pEQ2dHV2UrQmV6ZG9OWXBTRXp0WlFmUDdlL2R3amxtUFVENUtK?=
 =?utf-8?B?QzY5bThBTjU1WUxuZk54bnJ6Y3IxTzBWR1grd2lWQ0d2dUVSSFRrOXU1NE4v?=
 =?utf-8?B?a2JrMWRVWmYrcTlKOXpRT202NUdidUwzNWphTmcyQkhTVVE5dHE1bjBNZUJi?=
 =?utf-8?B?RG0wNkhBRXBnL3lYZUREUGNMcVM1MEVwRHN5U1Q1THRMYjRRRXJGUGUxdjVZ?=
 =?utf-8?B?Znl6eWRnTnRYSU1ZNDFpOUpaV1pSQUNhRk1XTHVtRlZONS9BaXcyM3RXbzRm?=
 =?utf-8?B?N2xSUms0NWoySDh5S29HaGdVbUg4K2wxL0tVOVBkdm1FQkNpRzFjck1KeFpM?=
 =?utf-8?B?N1FJVlRMdEw2all1Vmk5cE5IcUhRekhjK1RjcmxoVWEvbHFSRGRkcHRhTFFT?=
 =?utf-8?B?NjR2UHRCLzhiaUJ2UlUwdFdlWTRvZklET0IzMVZvQTNTYTZyVTd3QlBjSU51?=
 =?utf-8?B?bVdyTWdJaXc5UjVMVWZGV1E2NFhwQTZBT3NoVXNSRnZyUEVBdi9HN3JpOGpO?=
 =?utf-8?B?RGJNeWxsSUpoREZvYnhRdmltV085Z1M3TWNFQmhZM3NxcWdTZy82Z1FwalVv?=
 =?utf-8?B?a3NyY3pVNU9xd1VSV0FUN3dTTTRvbUNUdFlhcEZBeW4vMndud0Foa2tTaTVZ?=
 =?utf-8?B?akhNaXBYNUdKZlFHalBIaHdpSGFjQmlxc05wa3BOUjA3T1REblV5NWlhZEU2?=
 =?utf-8?B?TE90UVNvTFpiU21VNTRYRG9JTnJVc0cwNVZmOWN6OGF5SEluUmxmM2d0OTJo?=
 =?utf-8?B?WUFvVlNiMkFiZ1ZZaEg3YlVmVWJ5emMzcEN4TmI0SXhwcWVCK3Rkekg2b2ht?=
 =?utf-8?B?TkxZZnBHbjl1eVI5a2Iwc1FjYytrd3k2WkNsZk56N0VBN3d0TGZDNU9peHdO?=
 =?utf-8?B?QkRKTEtkQXJBUzZwTUxvR0Q5TVd3cENnMmRIOElTVU11T2tDOGtzMHpDa0lr?=
 =?utf-8?B?YjhaV2hpQVVtR3N6aUVVbWN3VHpkZnowWTdBbHZNZ2pTQ05IaXJreldmVHkx?=
 =?utf-8?B?dWQ2VkF4bjR2RThiTHVObS9OZkRoa3VhV2wwZkNuZ0RtTTdKUVVJKzdrMlV0?=
 =?utf-8?B?VXdUQjJKZ0svVENPbGJnUW5wVzQwV2lBMjFyTnovaGNLeWdqNjNZWlNUWThs?=
 =?utf-8?B?aWNnbGhiVy83Y3VKQXh5SlJVbDVseVpvVFlEeUNUSVZiaTdJRVkranlqTURR?=
 =?utf-8?B?OHFPakd1QVgxcFR6eTJ2QnptR3IweDNrSXlDMVhPYm9adWpwRFdoZExrWXJO?=
 =?utf-8?B?VDhGd0pSRkxLcncwZzZRYjhURGNSOEIvbmhLakhCYnBCSS9ldmdHK041ZEwz?=
 =?utf-8?B?d2Z3V0ptMk00cDk0U2R3UFdJUis1bE1tbERoL1p3KzBMYnNNVG1vb1dWL3M4?=
 =?utf-8?B?ZmhnSm9qcjB4STBtVFh1d3hSZHFoQUQ4MGNEYVN3SUc4RFdFc21mUm1YSjkw?=
 =?utf-8?B?NFhONmxxaUluYzZOYjl0bkU2QWF5ZVVBMnp5ZnM4Z2RlMVJNcGkxUzBCNG1l?=
 =?utf-8?B?TjZkQTNPd1Zncjd0ZWlHTGRRYnk0NFdKQzhSajFXcVl5UjdDdEpEK09FWWdW?=
 =?utf-8?B?WXBpbk9aVGNRWHI5eW1FWGNUUERFU01tWitKRXF3M1hNRi96TFQ2RkZKS2tr?=
 =?utf-8?B?S0g3ekdiN0FocnJoT2RldnJ4TUZnTHBncEM3RVlCcllUa0w2YkprZ3FFeFlm?=
 =?utf-8?B?SHJXa2t1T1hUY2o2ZHE3OUJBTFZtaU0xM0hLN1BFdDJqbjNCRnZxcnY3OWxw?=
 =?utf-8?B?cGczYlZXWVhscFZKMXpSZndwSzdObEVRTnZ5S2FaOTRCcVBCRUk2K2Y0SC8v?=
 =?utf-8?B?dFUzV0p0WjEyVmdiK2NNbUFHdTJjVmZoZDJJTFZ3bjFvTmhLNXljUGcvNUhk?=
 =?utf-8?B?eTZZMHJUYklTMWRqMVh3bEpXVnVwL0l6Yk14dEU1U3l1MmNaNmREK0JXc2tM?=
 =?utf-8?B?VWNqT0p2Z3Y5dEFuRlBZYjAwS0xwaWJTZElsTGZuNE9MZXBMWkZjSEJyWk1D?=
 =?utf-8?B?MTdpSjJDWENqMTJjVlJsUmZOa1hMb2V5QmZ2UWJVb3BGaEhQdVE1MmYxUGNV?=
 =?utf-8?B?WW9PUUlySHdjNFZnYlZuT25LTTVnTS9MVG1ib2xpdlkzTFIrZFdFS3BWM0ly?=
 =?utf-8?B?M3c0U2Y2QVNlMGFqWVZLMWRhVDg4MG9qNUlyRUliYm1yU1ZnOWlBMnZZdkVT?=
 =?utf-8?B?VWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 960afe23-588f-4325-97eb-08dbcab58976
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7869.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 23:55:24.9092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6jPoCjRdd9MtlK+zwKgshf2/sybQ4DPmTF1O1xPAJWgcd3Pl22LlhLgmFagrqBcmDBErb9DBG/Nj4xe74T2gnZY+qSUoKa2XwNHtgEfWT2s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7886
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/10/2023 7:29 PM, Jakub Kicinski wrote:
> On Fri, 06 Oct 2023 02:15:10 -0700 Amritha Nambiar wrote:
>> Implement the netdev netlink framework functions for
>> napi support. The netdev structure tracks all the napi
>> instances and napi fields. The napi instances and associated
>> parameters can be retrieved this way.
>>
>> Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
>> Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
>> ---
>>   include/linux/netdevice.h |    2 +
>>   net/core/dev.c            |    4 +-
>>   net/core/netdev-genl.c    |  117 ++++++++++++++++++++++++++++++++++++++++++++-
>>   3 files changed, 119 insertions(+), 4 deletions(-)
>>
>> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
>> index 264ae0bdabe8..da211f4d81db 100644
>> --- a/include/linux/netdevice.h
>> +++ b/include/linux/netdevice.h
>> @@ -536,6 +536,8 @@ static inline bool napi_complete(struct napi_struct *n)
>>   	return napi_complete_done(n, 0);
>>   }
>>   
>> +struct napi_struct *napi_by_id(unsigned int napi_id);
> 
> this can go into net/core/dev.h ?
> 

Okay, will move this to net/core/dev.h

>>   int dev_set_threaded(struct net_device *dev, bool threaded);
>>   
>>   /**
> 
>> @@ -6144,6 +6143,7 @@ static struct napi_struct *napi_by_id(unsigned int napi_id)
>>   
>>   	return NULL;
>>   }
>> +EXPORT_SYMBOL(napi_by_id);
> 
> Why is it exported? Exports are for use in modules.
> 

Will fix in v5.

>>   int netdev_nl_napi_get_doit(struct sk_buff *skb, struct genl_info *info)
>>   {
>> -	return -EOPNOTSUPP;
>> +	struct napi_struct *napi;
>> +	struct sk_buff *rsp;
>> +	u32 napi_id;
>> +	int err;
>> +
>> +	if (GENL_REQ_ATTR_CHECK(info, NETDEV_A_NAPI_NAPI_ID))
>> +		return -EINVAL;
>> +
>> +	napi_id = nla_get_u32(info->attrs[NETDEV_A_NAPI_NAPI_ID]);
>> +
>> +	rsp = genlmsg_new(GENLMSG_DEFAULT_SIZE, GFP_KERNEL);
>> +	if (!rsp)
>> +		return -ENOMEM;
>> +
>> +	rcu_read_lock();
>> +
>> +	napi = napi_by_id(napi_id);
>> +	if (napi)
>> +		err  = netdev_nl_napi_fill_one(rsp, napi, info);
> 
> double space

Will fix.

> 
>> +	else
>> +		err = -EINVAL;
> 

