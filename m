Return-Path: <netdev+bounces-16598-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D7B674DFD0
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 22:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66ACD1C20BCA
	for <lists+netdev@lfdr.de>; Mon, 10 Jul 2023 20:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B571429A;
	Mon, 10 Jul 2023 20:50:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2698913AC2
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 20:50:05 +0000 (UTC)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBCE930DA
	for <netdev@vger.kernel.org>; Mon, 10 Jul 2023 13:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689022180; x=1720558180;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TnvmrwUqPmVJyZXjQwswBoqJOGSUFD8gWW3cY8BnlaM=;
  b=YurD3qfPKuNfZVVVMyo65ASQJBPaZafOA7tIPACflwp/75W9vI4Gj8jx
   iZul3d99/PLxQLkFmvn6bYEucAaF6qZhSRxhC2BInCJQdWxrCXCOyXwYl
   PvXs9kGsKaJOAgkdJDIKZukRTHYzbKditpj2xCxXcZ6qe9I3aoQGSS1Dw
   RqnNIhcIy1E3jQKmby+BS3X1c4G/orekq6BvrRzY2MRskRCdeX5hV7UTR
   uBtU6EUbWyM7ZXqegPvgXj8sQgtrAI2os44FdXUfFn5HZoua3y+dEAul2
   x43OyyYOrjQORvmeRMxmWW6fDeGGZRZumjzZ56WhcvckRrNJJAqVA5qcW
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="349258463"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="349258463"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 13:48:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="698151985"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="698151985"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga006.jf.intel.com with ESMTP; 10 Jul 2023 13:48:10 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 10 Jul 2023 13:48:10 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 10 Jul 2023 13:48:10 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 10 Jul 2023 13:48:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MX4iQTkpY7gc0kTMKH1hUsbvrSmA/lvdnpZQrVRB0i9w0emslTcw8GFdMD3nxcDchA83mgmKmrM0kqvTI3mSuCK7bcYs1PRC0IXc41hG4j0Afn4wZjACCBEYM23r0nlhTMTSJhZihBWcy2xzQ98x/iC6yOMEm+E2gNscg2tc6Nr/4WiU2VDqQ24Oe30F4m/EUHZu9zovDJ5k2Nuf1lmVNSBIKXlDeGdyx2Xqbd2ZsbcDtOyYiui4UZ+zXMc3PMXUTxuQ4NfsKmvxBHH5dgpaGBPUUGECcN7SolW7mCibDU9UMlEkJuYSdAelWiQMOnGqXyehBzAtaPsMjs0MVkFm/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ORR1vxjYYQydNaPc65yp9/sqioC9FS2S6sCQ7t25jvQ=;
 b=INUbjF+dt2CY6HmxDZXa7EHVzyPechB3qOvXf7NlrK8szcok8iV8uu4qnATxBKzRMrjJQMnbWcLu9/S8LNaqP7nqyjO/Xsj/NOLVF8L8OMC1Dbb0K8GMCSq5TjRVq7YWbRf0sqDZ1gFFRoHjuxJBVkTTXlTP5XakrSyGIc33XdhFdBOjQcpcMb8GZWwkZDrqhD82aq9kcNRXWnLLsX0u1y/rIp+dKRWiuNAgEJkkTjrN7B2ZGKNKzDCYH3DrQV5ZtPVZvsh7PZ6RppfMDUoHgwZ4huRIaGxKrKhU8hW+eYlOTZudMlB4SZx59hG2A1iLnyaqHpvkl9TwAdjjyPCWHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN6PR11MB3229.namprd11.prod.outlook.com (2603:10b6:805:ba::28)
 by PH7PR11MB7026.namprd11.prod.outlook.com (2603:10b6:510:209::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.26; Mon, 10 Jul
 2023 20:48:07 +0000
Received: from SN6PR11MB3229.namprd11.prod.outlook.com
 ([fe80::bd89:b8fc:2a2f:d617]) by SN6PR11MB3229.namprd11.prod.outlook.com
 ([fe80::bd89:b8fc:2a2f:d617%4]) with mapi id 15.20.6565.026; Mon, 10 Jul 2023
 20:48:07 +0000
Message-ID: <25d3cd3d-e3c6-d3ef-d15e-8db497b03849@intel.com>
Date: Mon, 10 Jul 2023 13:48:04 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH iwl-net v3] ice: Fix memory management in
 ice_ethtool_fdir.c
Content-Language: en-US
To: "Jagielski, Jedrzej" <jedrzej.jagielski@intel.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, mschmidt
	<mschmidt@redhat.com>, "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>
References: <20230706091910.124498-1-jedrzej.jagielski@intel.com>
 <4359387f-297a-7057-d7ed-770dc021086f@intel.com>
 <DM6PR11MB273133BC65028765D6739FB8F030A@DM6PR11MB2731.namprd11.prod.outlook.com>
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <DM6PR11MB273133BC65028765D6739FB8F030A@DM6PR11MB2731.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0115.namprd03.prod.outlook.com
 (2603:10b6:303:b7::30) To SN6PR11MB3229.namprd11.prod.outlook.com
 (2603:10b6:805:ba::28)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR11MB3229:EE_|PH7PR11MB7026:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b099c33-7d37-4dae-7c1e-08db8186f72d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: idBcWUIby9uJozn7mCDoZj/Rdo2y4NIyLVvMHo9CZuJyeLjymL3tbz7itMsdrAQ+X4aIwmevEpgw990Dsx3knHqaPJZoE4eUA4aZFVHhQrk00/IkRorpKbyT6CFJG+2kzpwYpfDyEFhCkd2kxFlz4M4SRZ6MJuN+gHIlWkTRYttarx1njsFn3RcIq9CamvyaM2fE1Kmdkuyf2ga6CZFysshCwA+Ah88RxzWO1SiNBv9eM5zAzxWXV+fiRClCrpCUf3sw9R5Y3s/d4Noo5KcH9Jvf9bJ6sl/bzy2bMsqqcHAwbqoCtWrFCMuTzGR4SSGl0WYKPnDUEpy7LUrk+LccU4Nynt4KNjvg4t7Nz5l1EWTv8Ck9Hy4boWVT9TH09a0O60mnnHfBqY8JRkc5RACRQfylzehCWiXbvanBAeBKIYwM7h/Axqgk7hr+WMocK9bf/RV1rLOxzLw1x9ABDc5MtCemaIn9Z/FM/hNADtpH5JrRiKqytYrTv3Y002s2MSnpYljCYbaIDurdFfGM8Ggyzto0xMEF4OXDctsRARg2zgUWiZbtz7VmwK8fUKg9LpJmOiF51H+wQjXC/iBU6f9m9F9/CAJwURX7OkhZBNmaOCQayYvMFepHPTaTfDPI0UPjrHn4rVrtfzX/5UnpxGU/aQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB3229.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(346002)(39860400002)(396003)(366004)(451199021)(41300700001)(5660300002)(31686004)(110136005)(54906003)(316002)(8936002)(8676002)(2906002)(6486002)(4326008)(66476007)(66556008)(66946007)(36756003)(6512007)(966005)(6666004)(478600001)(86362001)(186003)(31696002)(2616005)(38100700002)(53546011)(83380400001)(82960400001)(26005)(107886003)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cUtEaThDeE1EenJ6VGwwcXZ5M3l5WWtGM1N6Z1pIT3lDNUpHNzNsZDk3UTVY?=
 =?utf-8?B?OW9ZZnFoQldOYVEzN210c2NRaUp1YTkxaW15b3BRVlBKa01mMTFwL3FmT3A4?=
 =?utf-8?B?SVBBUzAvQkxwYXdDM2VkREhwTlRSTzUzYXN4dE8yMTIzUm0yNjNMeHJSbms4?=
 =?utf-8?B?ZEZYd3Z0L2RMZlFmbkp5MlJhd1AyOVRLR2hOdndHQWp1dUVTVUdiNHhCOXRB?=
 =?utf-8?B?dzA3Z1VkWjhSM1BCVTZ2R0lZQ2NwdzNqTXdVOXdZcUdIYXBHbmlheWM5MzBx?=
 =?utf-8?B?eFAyZ2hCU0dYOXBmRUpUOWpxZlh1MkdoUUtzbjhjbG9oZ29vbmg4OC9PZDJH?=
 =?utf-8?B?eW90V2lLNmR4RzVyYmM0djRZOGhLZnF3NFZEaElRL0Y3QlBNQ2lNeHUvbitz?=
 =?utf-8?B?aHl0NGFJTC84SzMvUEZaUkZ3UXlYZldwKzJ1b0dvU1dtREY1VEpMODBxczZz?=
 =?utf-8?B?SGkyTjNTOWpvSHpyeHJwZTFpZWdZUkt1eGtLbWVYUGt3SmpvTnZXOU5GQnYv?=
 =?utf-8?B?Q01mSGFVRG1DaSt2ckxFYW1jRzhOb2NNUHBQWlk4SG9Rd0c2dW9JOVkyaVRJ?=
 =?utf-8?B?WXNxakVPTnF4cnZkRmFSajZjdDlvWktJZVdhWmVlVit1K1U3QVluMXdLSUVI?=
 =?utf-8?B?SE02b1NDenRXM0ZueFlsVEI2UmxwcHBHV1FFQTZZK2tLc3A5dHhXdTVCdE51?=
 =?utf-8?B?Snk2YURGSXFmR2pCcjU4dy83VmVYTWJjbkU0K2piazRsemQrTTh0ekd1N1Vz?=
 =?utf-8?B?Vk5STENFL2lXbnRXejkxK3JGK0RzOGwvRFBJMTJNS2NFQXdEdDc2YUpqejFa?=
 =?utf-8?B?Y1FOekFVSTRLdmtwbGx6VGxaaHVoQlF1QWl5TG1YdVdkUUowczVBaloyQ3Ri?=
 =?utf-8?B?K0NmSEMzN1NqRTRPOVppcnB6UVp5bGg5UFhjei9rYWdEaENpcWJQSEZFdHJv?=
 =?utf-8?B?aXB3RjZjMkhyb2x4MjdQRkNhSHR5R2Z6ZHkzWUsybmxPZ012RjkwN25rNDdP?=
 =?utf-8?B?ZlBxd1BvME9QQUFzRm51S3d2UXFRaGNtRk5uWnVGSFpObFNJSlRBYjIzRFha?=
 =?utf-8?B?WkM0QjIzOWJjVkdvYzhMdE16Sk1DWU1zOWNWTWtxMUl6eVJEMlU1clRtWEVI?=
 =?utf-8?B?MmZaZW4xY3FrcXAvcVJFZTZKYUJ4NyszbDE1a2JMY09qYjgwU3E1T3VkaHZY?=
 =?utf-8?B?L0V1NEhSbE1lYkZoL1IrdFpXenV0ZzBOMWdDRUkyUDg5QkxDSnA0L0xDc1c1?=
 =?utf-8?B?ZnpEWWU1elcrVk12bkhRUDJEb2RxVUNHRW1ZcGswVDVmL0dzR2w2c1cvMjh3?=
 =?utf-8?B?UDY4WXBPVHYwZlVGckNSYm9MSlUzK2lXUFM2V1ptdWl6Rk9xckhSY0VNV09T?=
 =?utf-8?B?YTRnMVJGaU5rMjlYZ3hCcllwclhxZWhMRU53OUZOL01rVU0wZ2NGMWlCM21o?=
 =?utf-8?B?b1B6UkpuWmZHWVRhcmpRRXN4TXNYSU5JRlpnTFFuZzVtUmE0Rlh6UWU3dGpP?=
 =?utf-8?B?OWdsMHlNMXJ0QjV5WlRzbitKVkZGNmZhTjR3d00vOGdsOVdyR1FLVTBtc05G?=
 =?utf-8?B?KzAvZlF2RXlFZVRoL2VwVXlEeHdmbmVnOFgxaXgrUTZtbzYwK3BJRTNQOU56?=
 =?utf-8?B?bm9abjNwQ3c4c0pZVHhoM3BJQ25jM3V4S3ozZDRHdEJ5Sml2SW91SFA1SjJS?=
 =?utf-8?B?ZDZqMnFZRVBFRVVFRVZtOUt4bHhOSGtIYlFDaW53eG9LQ2RIaFpOb2FGU0dM?=
 =?utf-8?B?blU5N1dNUm9KUVhwYThxTVBWYjRqZ0FCTDA3bGpqUS8yNStkbWFkT1AvZnFD?=
 =?utf-8?B?M0JuN1FOWllxU1FEdExydHlsOGxyZCszbEJuMGpsSUxjY0E0RDVIaTY0R0hr?=
 =?utf-8?B?OEwrbnRxU2Z6WHhSSGljMitpU3lsQnVqa3hHbTUrSnVmU000SksrUEJjSVlr?=
 =?utf-8?B?MUJBR2l2Q0Y2aVpLeFZIanUrQTJUWUJ1WDVnWUN0NUZpSmJUQkxDcDdQQ3Z4?=
 =?utf-8?B?SWpyNGt0MWlNdFFwUmVWQlJYa2FmcWdJSkZFZktnOVJpaGFIb1BWMzJpUXo1?=
 =?utf-8?B?QUVURmFpd0NDNnl6bkx0K25JMzhwV2RSa09pL0VSTWlFQjNCZFFSQStnbWd0?=
 =?utf-8?B?QVhaNUFSZElSWWp0YzJIUEVqRlBhVFAxYjZzNTgySkhrUzQrbmlFZ3NVeGhG?=
 =?utf-8?B?SFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b099c33-7d37-4dae-7c1e-08db8186f72d
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB3229.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2023 20:48:07.7548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0opgCpGb4z+tgiqIbHkQuS0uFKSxWX9yQYySETUKaZEAJxyM+63MKNS+eepLNg2uPZHH3UvtoflfU8ETNaykoueH2HULVNIFmUL5b4HNpS0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7026
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 7/10/2023 5:53 AM, Jagielski, Jedrzej wrote:

...

>>> -	seg = devm_kzalloc(dev, sizeof(*seg), GFP_KERNEL);
>>> -	if (!seg)
>>> -		return -ENOMEM;
>>> -
>>> -	tun_seg = devm_kcalloc(dev, ICE_FD_HW_SEG_MAX, sizeof(*tun_seg),
>>> -			       GFP_KERNEL);
>>> -	if (!tun_seg) {
>>> -		devm_kfree(dev, seg);
>>> -		return -ENOMEM;
>>> +	seg = kzalloc(sizeof(*seg), GFP_KERNEL);
>>> +	tun_seg = kcalloc(ICE_FD_HW_SEG_MAX, sizeof(*tun_seg), GFP_KERNEL);
>>> +	if (!tun_seg || !seg) {
>>> +		ret = -ENOMEM;
>>> +		goto exit;
>>
>> IIRC individual checks and goto's are preferred over combining them.
> 
> For both cases there is the same behavior so it was done due to limit
> the line redundancy, but if you think it is better to split them up i
> can do this

Please go back to individual checks; I found the previous comment [1].

"Don't do combined error checking, add appropriate labels for each case."

Also, as you're changing the allocation to not use the managed 
allocation, you're going to need to find the related (non-error) free 
and change those to be "regular" kfree as well.

Thanks,
Tony

[1] https://lore.kernel.org/netdev/20221115210239.3a1c05ba@kernel.org/

