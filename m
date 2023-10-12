Return-Path: <netdev+bounces-40216-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 028067C61F5
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 02:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 336311C209AA
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 00:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9D7641;
	Thu, 12 Oct 2023 00:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P1ahFWb+"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99E662A;
	Thu, 12 Oct 2023 00:43:20 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6ED190;
	Wed, 11 Oct 2023 17:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697071399; x=1728607399;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OT0fZiHS8BLMPZ45OXu2M6lLgocTuYtdSej57024fRI=;
  b=P1ahFWb+gxV34S/2zc6XmXFxG60TlOPO+y/crjVJh5bjZt7SYRYs9Tkk
   6CSqO8jZVHcBOX4paGi9Kq6WiImfqaw34lYvWb8yIUeM/ikaHYx2/pen0
   dE+an/NvAJc3k3+TgIL3L/Hi1xL7OcLXFW3aUeNooKIxbKVxRjjZv3m7R
   OZOJYvnLOQWlvl7b0Wx65XRJMM6BvZV5Zt7CXqPB9Q2RX98w+Mn20Rzwg
   R18LQDKqzZ+zDuzI0hCSITj7yk5keiYonJWKhX33qF48y8geCRg2b71/m
   P9Ba/6dWi/snc7hGoWG2GIqDp4Nd4TxeyeO2p0hIeGkTiqdaIXrm1N6I2
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="451296705"
X-IronPort-AV: E=Sophos;i="6.03,217,1694761200"; 
   d="scan'208";a="451296705"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 17:43:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="747675538"
X-IronPort-AV: E=Sophos;i="6.03,217,1694761200"; 
   d="scan'208";a="747675538"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Oct 2023 17:43:19 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 11 Oct 2023 17:43:18 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 11 Oct 2023 17:43:18 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 11 Oct 2023 17:43:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h843SBqQMcAfO69/q4se8qmok6prV+cjGNg4w1PEGInZZYGueEbNX1E+ELPAhYPCMjBYmAqSuziO6wQhRne10+gmZl5C0y2qUM5H8mwLNLjcErlREJGHElK6p+wuesu/8W3bqyLmv+ClLU4kW6x/rRaCDe15nI0tzDrDPyLpsubw6JZeC0rY5HlECrX+ZmlATTIQfQs7dXvgdRPv5ckEhLR1B4KwrM9GEwaThWZb49AP4AlPffmyCryrqG5tc1lRqoA9ENlMwW6zVdl9/JWbAdRbnS7HhS/LK624bpp7IGYaJsqxLtH1i308jZUfTTdVvkgTRSQisND9kk+n/hCAgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QrkmeJsFN+6Rtx2H9i3E71FnoFyY9NsTbhd0drX6Y0A=;
 b=DLlzKL+QU8b5btqFA9GjeL6d54p31amK9URy8qUjbjsJyjFxoQQo/yvVTp15Iyh73QGkpsEP/XbsjMH0kILoMIs45mRXW5ZDRpAQI7w2pXHHRSCO1DVLqJImA4YdgjAX/WNWNcPp3fhe/8UMUy+Rp83jIplKs4pPAbmsso08rXGHB/E25RRrgU6VQIVYYHqb8/RzMIzyk4POmrDQxhsd2MST5qTNFudZ3AYiBnQboawGIfF8QLptWDySeqZVIifS84nM66NwD/Vv2rMoCCGSQ1o2J2Tmj4edQzhwPJ3wOQSrxIqEMXX9NRQCUDiTj+JaxPQhRfNBpwGA5l4/iPaYow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO6PR11MB5636.namprd11.prod.outlook.com (2603:10b6:5:357::21)
 by PH8PR11MB7120.namprd11.prod.outlook.com (2603:10b6:510:214::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Thu, 12 Oct
 2023 00:43:08 +0000
Received: from CO6PR11MB5636.namprd11.prod.outlook.com
 ([fe80::f6a3:b59a:1d7a:2937]) by CO6PR11MB5636.namprd11.prod.outlook.com
 ([fe80::f6a3:b59a:1d7a:2937%4]) with mapi id 15.20.6863.043; Thu, 12 Oct 2023
 00:43:08 +0000
Message-ID: <2a529cbe-75f6-0fdf-cdfb-8409965c1a16@intel.com>
Date: Wed, 11 Oct 2023 17:43:05 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH net-next v4 5/5] ice: add documentation for FW logging
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, <davem@davemloft.net>,
	<pabeni@redhat.com>, <edumazet@google.com>, <netdev@vger.kernel.org>,
	<jacob.e.keller@intel.com>, <vaishnavi.tipireddy@intel.com>,
	<horms@kernel.org>, <leon@kernel.org>, <corbet@lwn.net>,
	<linux-doc@vger.kernel.org>, <rdunlap@infradead.org>
References: <20231005170110.3221306-1-anthony.l.nguyen@intel.com>
 <20231005170110.3221306-6-anthony.l.nguyen@intel.com>
 <20231006164623.6c09c4e5@kernel.org>
 <bc8fe848-b590-fa4c-cc6b-5ccdf89ce0fa@intel.com>
 <20231010181832.176d9e2b@kernel.org>
From: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
In-Reply-To: <20231010181832.176d9e2b@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR10CA0009.namprd10.prod.outlook.com
 (2603:10b6:a03:255::14) To CO6PR11MB5636.namprd11.prod.outlook.com
 (2603:10b6:5:357::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5636:EE_|PH8PR11MB7120:EE_
X-MS-Office365-Filtering-Correlation-Id: 23febb59-d126-4aac-5875-08dbcabc3464
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 97pGced2bFz9IIjXbpJETUPZTk0bfAn256kzpgopalZuZOpN7bDc648aTlfnjC0v/lqWuY6ZSA5F+gUZMcas/aP+Vu2juhTUkVHdocUmd+QyhwjQeyzoIqFaH5e8PD+VDzXcZ7gUr9btGFfEPKtPPAjj7CnEQX0dqDjmLGZaaqOPq7UPBKkhLWwQ2C/cwb0WlfgofPSr9aZJHN2PkvqDKoKDc5iJszqyWJbCKCrx2wBXo6NmGJoBFRc8cojWFKVqk8HV25lKaEE2K3m7o7FiFdGleN4dgQ1x8gY+v4/ZEAoJsZgWf+IW+uRZ6H0rXFAkRT3g7upFUj26FFzJMNep85eIz7eN7qwicSFXapyUwStOPCM8PkOeLsgBdviAGxS2Bv1zgJI1+ecIGYpEzpU/+49MoMA2rgcOpvX2oMlAIulVyRRJJc4xIErBDZ+85FvwTxxUjubo3Q06+Aw3eSl3lH+K8ddlyj4gGjxLMszDnVxm3OTrdQmT3t1iB4v+8jDDQHhwMg/9rrC+5rfVVostbKp2vFreSV+UC2c8xL+/ZHOXJ1PavzjldJ8HlaHP5gqCVjciUsLkcBOb8LdU6pHwUgX7ytckcZTnEHTmFqbQ20RW6Q5RRlNTdFX2bApEBAhAHgc214pVjy/dvEniJ4vuDQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5636.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(346002)(366004)(39860400002)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(6512007)(53546011)(6486002)(6666004)(478600001)(82960400001)(2616005)(83380400001)(66556008)(8936002)(7416002)(2906002)(5660300002)(316002)(66946007)(66476007)(8676002)(6916009)(4326008)(41300700001)(31696002)(26005)(6506007)(36756003)(86362001)(38100700002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dUVzNVl5VzBaZ0JlUFhKMVA3cmZnSXNaZXhjQWxGOEQvYU0rS1hQTTdwM0NJ?=
 =?utf-8?B?YTdsT291NGZpMFRXZWpCQkxJcXNFUk85YW45eFd5dHlZUms1UDM5ZHFMWWlt?=
 =?utf-8?B?ZUFSRkNsM0pUMUt2dHpuUUpUK3BJazMvY1hyUFA4NmRTTDEvYUgxakN2bTNB?=
 =?utf-8?B?SHBNS0RyRUNNMG1teSs3ek0yVnN3KzJYMGMxY0xvZDdBZENuQXFrRVBNeGhM?=
 =?utf-8?B?MG5acExtcnZKblA2RGpZK3o0ZElhdmxUbGZ2UWxCQjNhWGY2b29rdHl4V1pI?=
 =?utf-8?B?THZsSmhSOXlKR2I5Q0hIb1BacXowVDRpaUROYkdpdWFTbCtxSDh6Ti91TS9I?=
 =?utf-8?B?aEtndGVsSk92Q0xGaGFja2o3aTBKcm45bnRKc29FUnFFSTNScktXaTJYaTB2?=
 =?utf-8?B?Y1dxMFZHS2JvQU03VE9NaEFNckJ0MU9vdXV3dXd3VXFFMXc5eW9YQnRabHN2?=
 =?utf-8?B?VVJxRWMyN1dhakVQK0xvbFZreU5uTWpBeXBoTjZrdlZtWUNFYmIwUHlUL2Za?=
 =?utf-8?B?ZVZaMERrMXYzLzhZNVRnUHhKbUJNbm1uK25BVUdzNlRwT3VtSVdNQXN5Tjlo?=
 =?utf-8?B?OG5haFE4V096VE5yWDRnbmx4L3BJcDZzaDJWekVYNG5JdElLNytQSFFCWUZV?=
 =?utf-8?B?dk5YQmtuajZiYWhmdnA3NHFBc2daeDEydVhiaUQyaVpaaVZvSWpiTVNDVFFn?=
 =?utf-8?B?MitTeUR5VEZlUVUvS2M3UlM1RWlpbDdPWG43aHBMYUlNMzdmZXlrUXZvd2lG?=
 =?utf-8?B?YVJBUEtrSVVqUVhudFY5UFRSeWs3VnlSRUpXYklNbDlmWkFUK1ZJZ2JLaERw?=
 =?utf-8?B?VWhpblZ3ZnFVSzd1MWthWkc3RCtCeFJKNGYvYU4yQ01CQkkrZGR5OWlzcmI2?=
 =?utf-8?B?R2s5VlRFMlc0KytUVkxwd0tSTVdtaEJYU0Vmejd4MTc4NTNXdHI3djA2YmQz?=
 =?utf-8?B?NVhZdll3eVZGQWxjdlRBL0tNa2FZVTFMY0l0QlhyK29mUnNBeVF4VGJScXla?=
 =?utf-8?B?ZzJpL0VHbld0Zmk2cVp4YUY4MngyNDR4cVFPSllGSW9QYUJyQVF5QWk4cWdI?=
 =?utf-8?B?T1NoL1JTWXBrUkNtdDVObHY3OVpZZFpGVDR1QXhPaVdQeDYyUEFtV3AzMmZl?=
 =?utf-8?B?NDJuLzZ6M3ZlNkFMYzFXZmprVmFsdlByaG5LNFdCRHA0SWE4YzRkVy9mVWx5?=
 =?utf-8?B?L3p6ZGtuUkpLNk1sOWxNaWNOaHlja3FaN0VneE5zR082TEhWN3MwaHpqNVZ5?=
 =?utf-8?B?NGd0L042ZXZDYyt1N1lWS3orWUQ4UUcrbmVRMG5KMW54TzE4Q05oa2RMekJK?=
 =?utf-8?B?S0szTHM3LzRnblZHc1gzbG9acjl4bGsycVBHTGZCRVNGQk1Hb3YvMUxhM1Qz?=
 =?utf-8?B?SU54WW10SC95UGZ5SVhYUHFrSEdUMG05WVpOWXBxdHllTUFFQi9SMXlZY21m?=
 =?utf-8?B?VHcyc2FMKzZXTUFiUW00NmFwNWc2REtEc0RwWkRNd3lTWHVMME1IUnhRR3M3?=
 =?utf-8?B?L1QwdVFNQ0MxeS82SVQybjd6S2hWYUlxY1MrOVJ1STlWUUpyY2NYMFdBRitO?=
 =?utf-8?B?TndwT2tGeGs2SWxWTlFSOUVHOWl4Rjg5QTBwQWZYV0xLblgybnBFYlhiUUJj?=
 =?utf-8?B?aURENTFyK0lTWVVzd1JLUFFraG96azQrTW1aQjFTYmFnV3lCZXBKVTJIanJi?=
 =?utf-8?B?dGYyNWVydGUreVk3eWJzWWlncVpNVTczUTVTWkRFRitscFRWa3oxQWtTMHNz?=
 =?utf-8?B?TUE0TGM1RTUrZ3QxdUdielRSWWdzNksyMVJpNXBRWTIvTkx3cGYwaWxtRk9U?=
 =?utf-8?B?N29VOVRIcjFrVHg2TUFaNU1xakRFUndtTTIwcnFWNmRMbkVpR0pFQzlHNWNz?=
 =?utf-8?B?UXNueWFzTW5BeWh0dmE0a3VBQzRZazFwaDVOdW9WRjlnWkUwcy9HRkhEOHBr?=
 =?utf-8?B?WEdjdXk0UVc2NkFkWCtwMXNnb1FrcE1xL1NWOHlEOUlUZndxeVhSRDIxL25p?=
 =?utf-8?B?Qmp5ZytsczBONjA2YWw1cEU1Q2Zta3RXQWcybVB3RksvVnQvM2RQZEo4dGxo?=
 =?utf-8?B?SEwzMFEzRFZTdmRhelAxSjhQVll4VncvblVWeHhuNU9QMmhrdzAxZFVhLzlk?=
 =?utf-8?B?cGtqaTdEa3J0YzladFhDeEFLb2FBYkN4ODhERlhIMkpjTHVyWFRwVUkwTlNH?=
 =?utf-8?B?aWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 23febb59-d126-4aac-5875-08dbcabc3464
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5636.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 00:43:08.5891
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qTTqT+Cw3NLAV5VlYXnQt0VnFbXLyRar5791LFZrxer5GsaB8QBu8SM4PAxZHVk1KfxnCP+9gySMlFaDuhjMGVpuvzunJ0X7zsbPLSbYFn8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7120
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/10/2023 6:18 PM, Jakub Kicinski wrote:
> On Tue, 10 Oct 2023 16:00:13 -0700 Paul M Stillwell Jr wrote:
>>>> +Retrieving FW log data
>>>> +~~~~~~~~~~~~~~~~~~~~~~
>>>> +The FW log data can be retrieved by reading from 'fwlog/data'. The user can
>>>> +write to 'fwlog/data' to clear the data. The data can only be cleared when FW
>>>> +logging is disabled.
>>>
>>> Oh, now it sounds like only one thing can be enabled at a time.
>>> Can you clarify?
>>>    
>>
>> What I'm trying to describe here is a mechanism to read all the data
>> (whatever modules have been enabled) as it's coming in and to also be
>> able to clear the data in case the user wants to start fresh (by writing
>> 0 to the file). Does that make sense?
> 
> Yes that part does.
> 
>> I probably wasn't clear in the
>> previous section that the user can enable many modules at the same time.
> 
> Probably best if you describe enabling of multiple modules in the
> example. I'm not sure how one disables a module with the current API.
> 

Will do

>>> Why 4K? The number of buffers is irrelevant to the user, why not let
>>> the user configure the size in bytes (which his how much DRAM the
>>> driver will hold hostage)?
>>
>> I'm trying to keep the numbers small for the user :). I could say
>> 1048576 bytes (256 x 4096), but those kinds of numbers get unwieldy to a
>> user (IMO).
> 
> echo $((256 * 4096)) >> $the_file
> 

I'll change it to be a bytes of data to store instead of number of buffers

> But also...
> 
>> The FW logs generate a LOT of data depending on what modules are enabled
>> so we typically need a lot of buffers to handle them.
>>
>> In the past we have tried to use the syslog mechanism, but we generate
>> SO much data that we overwhelm that and lose data. That's why the idea
>> of using static buffers is appealing to us. We could still overrun the
>> buffers, but at least we will have contiguous data. The problem then
>> becomes one of allocating enough space for what the user is trying to
>> catch instead of trying to start/stop logging and hoping you get all the
>> events in the log.
>>
>> I can drop the mention of 4K buffers in the documentation. Or we could
>> use terms like 1M, 2M, 512K, et al. That would require string parsing in
>> the driver though and I'm trying to avoid that if possible. What do you
>> think?
> 
> .. I thought such helpers already existed.

If you are referring to helpers to handle 1M et al, I couldn't find 
anything. I found the kstrto<x> stuff, but that doesn't handle this case 
correctly I don't think.

