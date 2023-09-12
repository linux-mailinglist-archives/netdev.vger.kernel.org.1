Return-Path: <netdev+bounces-33385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C95779DA97
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 23:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9975281A03
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 21:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE6BB65C;
	Tue, 12 Sep 2023 21:13:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539F333E9
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 21:13:39 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F5F910D0
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 14:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694553217; x=1726089217;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kAMepv+eFtbFP39DGVk1hRLDF3WkUIPsA3t9pWX4IwE=;
  b=dpRVV8MAXoUIA+5GsxcHthX9QyuAXNLKf25ZxhK6pw4JwbNSTDOAyhXv
   hdnmaH8YANrDLa8Y2EtI6oW+0KbeOXLlFfyUusuap6uYEsj7E5Hzi+VIt
   XKrGnH/zlp3HJ7/AVE2xQ0gOQ34sjQLZXHjsVp0cpxfSyy7PNsyCFvNnz
   9HYZBga6AeBFdRK7hYoC4i8eEjzQmg0FBo/EQMnlu4ubkxF1J7rY+RN04
   LoMc5MKBdZD7SHOqrqRfnFhFAe4g/J6Qix1IJ7VceFX+zLTI9l+16tF/X
   sXGiwC9H3ZIGgGWTahegJOnE8/pTbMM8j4JC7j49jj+y+JpAk4uQmgTh9
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="382301941"
X-IronPort-AV: E=Sophos;i="6.02,141,1688454000"; 
   d="scan'208";a="382301941"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 14:13:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="743858552"
X-IronPort-AV: E=Sophos;i="6.02,141,1688454000"; 
   d="scan'208";a="743858552"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Sep 2023 14:13:36 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 12 Sep 2023 14:13:36 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 12 Sep 2023 14:13:36 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 12 Sep 2023 14:13:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JL3OH172ksZi7ix0igpfhS0hZuyTpkuapzF5vJ8J9kWhYWQLu2nnJPG+ykB8rd8N/1WwaRUqQTmvxCJFi7PJIZ2AWNga6wQY5edUxn/OwOUdSc1p6KLxJd+69i3+z2jFqj6pDYeuq0k4oEZ2bN2A1XR15WQVXJ77K4fWYu3mWKkCV6czbu3WBFqMcfJXq6oV2h/fHVqXRU33bidUHEp8Pc2ZqYRetRiiNzMrS/je9TvwS7DV7nf+66g8mgbcbk/01u/1JNr1a7BuS7h3Qe8qqoXzP8dFTuqWCbfqb9ex5AeEpH9oWqXJ8WQgqjpwk9NaDPL2QfJ6xV0x3WZTbl57uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zjaDYLO7JcgUFTX9AdU/WVw46nmnL6AUjeRPHdG56bI=;
 b=AO0SwWIAjqt6snGAL7vDCyPsU7qUYEDQnAPGgGXQV7HSuWht6l4pEyVwy7sgFBMr0THn9Zds0NAbBLLWKwq7cI/WO2AcWx4bL7GkXbsiRza0tFAHVrD/qxcDnqbJUBhXZIXkUe52FtTxZdpv/6MPy/GJeCOPoeUkh5mNqkrYRGV/tHHhZoIiGbbVP8cT4wgUF7oIi4aof/FYNoO3klzeY+hbovuin3DuTDApmeaTf+zf3tXQvQoM8VIWqb+qZVA7Nj/5K/a5EWSDjnQIvVM2+xuyERXYbPJ75zVwbI4De6prtcJ5+mjx1zG2IRERxekBTR93uAXAwck1VMCUM6GTQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SN7PR11MB7116.namprd11.prod.outlook.com (2603:10b6:806:29b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Tue, 12 Sep
 2023 21:13:33 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::6a23:786d:65f7:ef0b]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::6a23:786d:65f7:ef0b%6]) with mapi id 15.20.6768.036; Tue, 12 Sep 2023
 21:13:33 +0000
Message-ID: <37cef70f-e859-23ad-580c-6eefd45c688d@intel.com>
Date: Tue, 12 Sep 2023 14:13:31 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] ionic: fix 16bit math issue when PAGE_SIZE >= 64KB
To: David Christensen <drc@linux.vnet.ibm.com>, <shannon.nelson@amd.com>,
	<brett.creeley@amd.com>, <drivers@pensando.io>
CC: <netdev@vger.kernel.org>
References: <20230911222212.103406-1-drc@linux.vnet.ibm.com>
 <943d2f39-b933-b77e-fb18-4c695c1c4bf8@intel.com>
 <331b81ab-7a19-0055-088f-d2f595c26303@linux.vnet.ibm.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <331b81ab-7a19-0055-088f-d2f595c26303@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR06CA0011.namprd06.prod.outlook.com
 (2603:10b6:303:2a::16) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SN7PR11MB7116:EE_
X-MS-Office365-Filtering-Correlation-Id: 771c4605-c819-4691-1ef9-08dbb3d51f36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L4NEz2To2G8O1qRiYN3NMnHd/uMXhNE+ZK+8NHeT9PRwei6l5kCmCHh+AdctJMScyO8+7Uc0K9kMRvR1EUHM53/F82nvyo/0R2LWe/hh7/hpaHJXzuvSpCfWZ7EHxMDWL8tZbjDIv/Kv7PSJTu/Mpyatmi5YJP9geJvuGdD/Y5I6LX5ls3KEomhB2Dsee3xuAXr0yWfBNi/eWbSlJvFminpTN9b2BDmikJxbTZhkTpM5tMIgBXjMd6zGl9hqO4szr7T2vkgS1VQujN3viqhJz6NVIk+Usej7545qAS5JFE6g9+t6wFin2T3fA8I23bvt4b56R6L+KzfkZzyMIS6dDnlYvxnpjHgxCMt0tciZishOPMqzlxHpFzG4dYd+oGloUgH0SpcPShIibZLZr+7Zg/emHckpr1TWzxSg8XJuWXhgZORQTvjD7v8ofMbi9e0C4g2SOb6jbj8qLZR4Q1ciBSUzaFj1siK102SIWiSc7neZ0OLLZwQG7L8v1dyKUDlAI/6sLZqPLTy+a0Xmkgl8jwoBZaMN2uNN/hiYs4U6T7IZPJOMSYO/246BhuOQfyA+4iX0o0ITkkNbCs1LhAlcVTu9D9S0X+lGte0IEc/LYYrM050KcV63WTcOuZN8SWaNmq+REo1XiUH12MGHmEyTlg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(366004)(39860400002)(136003)(1800799009)(186009)(451199024)(2906002)(83380400001)(66476007)(6512007)(26005)(66946007)(316002)(8936002)(8676002)(4326008)(5660300002)(41300700001)(6486002)(66556008)(6506007)(53546011)(478600001)(82960400001)(38100700002)(2616005)(31696002)(86362001)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YWVkRnNNRFNWKzAwZ2M5VjR5N3hjV2JoNFZ1aFdldFpGMEJUaERQWVNxTVZL?=
 =?utf-8?B?WDVtUUpmdU50MDVRSGlZN05kd3duNzlBQm1UWW84Umdid1htNThyNDNoRkFV?=
 =?utf-8?B?WXdRRzJFTnN4TWZDc3ZEUldEcHRGUXd1aVM1d2c5V0w3Tk1ab2ZKR25kREh4?=
 =?utf-8?B?bytTYmNKQjl4dVZrZ0h3NE9rMTU3ODlIVDZrK3RQcEM1cnNuSHV0MmI2bVRT?=
 =?utf-8?B?Nm9scjdURVZiMUhoWENiRktPZWRaSFRGQStFMnFsdGJpb01HeWIzdmFpNzY4?=
 =?utf-8?B?L3crMlFod05vaUUwdEh1RUs5MmttdTA5MlJ3OTBtOE1IcWF5Q3NtNDlNZGtt?=
 =?utf-8?B?TDZvbXVRQXRIMG5DYkFjYllVN1VRb3ByS09aenlXUUs5ajN2TUdldWJQLzlC?=
 =?utf-8?B?YVUrNGl4dktoblluR2g2eTV0SkMwMHJoWjJiUUw0TW9qanIzZVJnU0RIM2x6?=
 =?utf-8?B?UHF2SHdiNjR6WlNqYmRmaEtrU0tzaHgyYjVZVW1mWll4Q0ZVTVZDc1EzM0N0?=
 =?utf-8?B?aEtKKzNuaFUwSENreG1zZGRxeFBXbnI1TkhPQnIrejc1QWFrZ0VVd2pwUk9N?=
 =?utf-8?B?ZTA0L3drSGhmMGhxeU03UlBFdkZud05VSFVlWXVSOG1XdFVJRURKK1lFVDdW?=
 =?utf-8?B?bFAzOTFXY1ZQR2lsalJVU2tBY1dqY0NQYzE2Y0hKaHBTQWtxejNZaWljR0lp?=
 =?utf-8?B?Snl3RHRBSHA2Q1ltclN2dUkrZHExM21jZzAzUVV5L0Zya0xjV3BYMHo1M0Uy?=
 =?utf-8?B?RE9uUzhzUFBXVE4ra3JIV3hzc3Vvdmk2L2NTNy92TXJ4MzIvUFNKV1E5Z29I?=
 =?utf-8?B?SEI0MlhzakJZWVh2TzlWL2dRUzRMK2J1R0NjM0lhNmQ5YU42Wmw1U0FVK2Qr?=
 =?utf-8?B?b3FQaUVDZXpoTm5EdHhKUW9RV1pLMXBUZTdIaG52N0FqWjUrOGxqcStLbUYr?=
 =?utf-8?B?bkRLa0F1N1JJRStRbXBSTjBPakprZVorcFRZYlJCLytsOExzenFuYS8xQ0k3?=
 =?utf-8?B?Z25HZUlWZmlEdDJOWnkyWUJrSG5xY0pzcFMvcndCRWJzRGxNMUQ0UG4ydk9O?=
 =?utf-8?B?NEZoTmhzUGkyOWZnK1hrUVdnZ3oyK0pNTWhQbjl6c1pJWHRMeE94Q1hyTzhQ?=
 =?utf-8?B?NEJHM3ZaZFdRVENzQlV5Z080TjVrUXJmN0lLcnlXNHZFYm40ZVNsek5OZTcr?=
 =?utf-8?B?Y29NYklMWmdkdnJaOW1oRG12Z3Z2VDJCOURVNG4xa0NqWVh6RG5oRHB1WUR1?=
 =?utf-8?B?cm5MQVk1MDdIUVVvWkhEUnVocDhvanhEakI3UHBFTVl1N1A2b0tLUnJUWmFP?=
 =?utf-8?B?RmEzVitmMkpPV3BydGhPejBWVHZoTVFtUnI5aUhVd3JQdjcwb1NJZGdKSXkx?=
 =?utf-8?B?dTFSSlRWTFliK3UrNE90QjgyazMvMzZTZVJTd0gvdHBVN0FtMWlWRmphbldY?=
 =?utf-8?B?dmJuSk9iOW15UnFRbWhocTlhUlJKTkJMODFsZE43TitGelVOREhYWkhKdS8w?=
 =?utf-8?B?elgzalN2VEtPeWN4bk9DQzZ4ZXd5T1ZsNTJndXVkZ1RRZzlCNEJ0NjArbnR4?=
 =?utf-8?B?blZsMWk3MFNKMjBidGthNlZhem95TW96Tmg2enlOUkw3UkIzT3dKdWZuK2lk?=
 =?utf-8?B?aFVMdm9jUTJhYk4wU2Izb0ZqRytKL01aRCtOQmVmbi9uY0NVc0RMNFc4R3ln?=
 =?utf-8?B?NWNKWDJpS3VydTgrS0hFUzBYdHRvdkU5LytsV0dYdjI5ZkhPTkttR2wwUFVF?=
 =?utf-8?B?QmJtTXUyaytYM0xQSUR2anlQMjB0TzNEM1hBQ3Z1dWdBT25mUUlKWUp3eVBW?=
 =?utf-8?B?NXU2RXZzQUVjelhWcFFpakRCOXk1UlY0aWtFUkJqVFJ2S0R6ZlFIUldQc2oy?=
 =?utf-8?B?RTRpRzdQK2UyTnpORWVEaFVlVU50Z0RvaEtwVUs3OWtNUHZMZEptSlZJYkN3?=
 =?utf-8?B?cjZyR1ZnRjdmZWRpY2FhWXN6SFNsd0R6SlU5Ni9qSTk4aHZ4aytQa0g3ZXlF?=
 =?utf-8?B?dk5XeW5ESTJVcFBsT1BjUW5wdU1jZE1wbzF5Z1J0YysyNkxWKzFHdEJHaERq?=
 =?utf-8?B?K21jQTFDMXZWb2xUcGxFVUZHSmxRYUhqZzROTktqaHlYMldsZWFXV0QzcTBD?=
 =?utf-8?B?Q0ZxaWNKSlJUWVN6TkszeW1UY0hLVlV3N3h3V00xTVFFSzcrTzc4dlBYUWVL?=
 =?utf-8?B?SlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 771c4605-c819-4691-1ef9-08dbb3d51f36
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2023 21:13:33.7171
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VFrLHqBGnGiXMIhJIAeUQq+soc2nzp2XAPGKfDKk2qI4aFpRsclOkFG6TTzyWwzkn8+C+x4Hw5//rsmXrHDqNmjOEzcsE+LgA7T273TTyEY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7116
X-OriginatorOrg: intel.com



On 9/12/2023 1:48 PM, David Christensen wrote:
> 
> 
> On 9/11/23 5:14 PM, Jacob Keller wrote:
>>
>>
>> On 9/11/2023 3:22 PM, David Christensen wrote:
>>> The function ionic_rx_fill() uses 16bit math when calculating the
>>> the number of pages required for an RX descriptor given an interface
>>> MTU setting. If the system PAGE_SIZE >= 64KB, the frag_len and
>>> remain_len values will always be 0, causing unnecessary scatter-
>>> gather elements to be assigned to the RX descriptor, up to the
>>> maximum number of scatter-gather elements per descriptor.
>>>
>>> A similar change in ionic_rx_frags() is implemented for symmetry,
>>> but has not been observed as an issue since scatter-gather
>>> elements are not necessary for such larger page sizes.
>>>
>>> Fixes: 4b0a7539a372 ("ionic: implement Rx page reuse")
>>> Signed-off-by: David Christensen <drc@linux.vnet.ibm.com>
>>> ---
>>
>> Given this is a bug fix, it should probably have a subject of [PATCH
>> net] or [net] to indicate its targeting the net tree.
> 
> Will resend v2 with updated Subject line.
> 
>>
>> I'm not sure I follow the logic for frag_len and remain_len always being
>> zero, since typecasting unsigned values truncates the higher bytes
>> (technically its guaranteed by the standard to result in the smallest
>> value congruent modulo 2^16 for a 16bit typecast), so if page_offset was
>> non-zero then the resulting with the typecast should be as well.. but
>> either way its definitely not going to work as desired.
> 
> Sorry, tried condensing the explanation too much. I'm not sure how 
> frequently buf_info->page_offset is non-zero, but when 
> ionic_rx_page_alloc() allocates a new page, as happens during initial 
> driver load, it explicitly sets buf_info->page_offset to 0.  As a 
> result, the remain_len value never decreases from the original frame 
> size (e.g. 1522) while frag_len is always calculated as 0 ((min_t(u16, 
> 0x5F2, (0x1_0000 - 0) -> 0).
> 

Yea that makes sense. When the page offset is zero this definitely
results in a zero value (given that PAGE_SIZE is always a power of 2, so
its congruent value is 0). In either case if PAGE_SIZE > 16bits this
will produce incorrect and unexpected results regardless.

> I'll update the the description in v2.
> 
> Dave

Thanks!

-Jake

