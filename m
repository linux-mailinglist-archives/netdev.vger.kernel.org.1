Return-Path: <netdev+bounces-26024-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A4D776792
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 20:44:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59639281DD3
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 18:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C8024510;
	Wed,  9 Aug 2023 18:44:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C6524503
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 18:44:26 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F4F7C9
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 11:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691606665; x=1723142665;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PmVhURsf5bqfBP/nB8jw+6wtfiwB9IS2ikVqcGZeFfA=;
  b=WD8fm5hVi62ucQh5sDDp+UCfdKcLkRA9tnn8WOGMFm1vkG752jM+lsks
   aMLEzsXDSr4RoCD5VFRfs3teDpsM5xeIi7ejlX16goliYuK6cQIc3yCql
   OzufgwZ3vtc1aw/0SbjM2PJFOAmOVmuhgwdRwQbq7oLRbgEKFelTbZHQs
   BZ6A06wonnw6V0isj2+FwAuPI9FgjfnACa8VKDze/mOvWAt3D05I9/xRF
   aHunf/wuhtzfEpZOjOStF7tcCwaCiT8xbi50D4p8/wC/Na7rZJVhDt+C5
   YNycCyP5JQZWAuLK9IP758qLYZkR/8/hTi7bMrmIBRt3wJqNtY+d8LhFj
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="361334911"
X-IronPort-AV: E=Sophos;i="6.01,159,1684825200"; 
   d="scan'208";a="361334911"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 11:44:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="875390827"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga001.fm.intel.com with ESMTP; 09 Aug 2023 11:44:27 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 9 Aug 2023 11:44:24 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 9 Aug 2023 11:44:24 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 9 Aug 2023 11:44:24 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 9 Aug 2023 11:44:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ipXi5TwvPM+aXG/1KepZx2HX3t294+T4asrL+9uL3UeZsjvETniF1QejSp9SdYVZ5sILZJlbhxdc7g+sSS+gVrqH9ll7ZlBZYwrTS2S2uVkgnFTEzZccsg0rHN2pa9Al73ZnelAADnI+jFZlgDPSh0PXv9+go2cVsZAb6YLskz0lSnksRFY4/c4/3uyzqnN2xCOK4f/IU+8/xf7sbCXRytLV5EOIrTN55D2z8n/F5vAs1CfkM5cIIx2Cc+loh3IZVDSoBcmWCsEMRtko2/yjYSEe8R6h8Uby2/spjZaW4P3V9k9ORRZ0NNNoIvVaIOb85/X8k+eMa6w8xMQfh3enSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/gtHHypZdrOOpQ8YWo/igNqN8cxP7dszvj+PZmVinsc=;
 b=dd6iNdLmRII3OAabmOgTSTNiBhpRuXAOWMs/zpSwkp1/bSPJ4WSOqEhmodhjqw+/Tx5uBKDGMdqixHy16hbcZLKvhR8FJy/6+vuQFsQIAJYh7IqnmfgONFWxaFc3NVEqsJkcTcGQDbutTpmrkIvCQsw957ynqnRZL9edPjFAg70xUO9HsmMcehAJQynzpYakg4SqiZc97yY59cwFd3fp8qVhM04+AT2RY/5WKsa+EZoD6s3syNwvgpMTbwESYsFPDopixS1xExeuARfW3ysTzmyrzeV8lDkRV5noVkzoPUNUZO0ndncNllaGzIVK5j9QfNpgOE4ZFP3QfiH25AX/oA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3175.namprd11.prod.outlook.com (2603:10b6:a03:7c::23)
 by PH7PR11MB6930.namprd11.prod.outlook.com (2603:10b6:510:205::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Wed, 9 Aug
 2023 18:44:21 +0000
Received: from BYAPR11MB3175.namprd11.prod.outlook.com
 ([fe80::f212:bf09:e307:9b9c]) by BYAPR11MB3175.namprd11.prod.outlook.com
 ([fe80::f212:bf09:e307:9b9c%4]) with mapi id 15.20.6652.026; Wed, 9 Aug 2023
 18:44:21 +0000
Message-ID: <f62fc232-8bbf-253b-5eb2-3131d767d6df@intel.com>
Date: Wed, 9 Aug 2023 11:44:19 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH iwl-next v2 5/5] iavf: Add VIRTCHNL Opcodes Support for
 Queue bw Setting
Content-Language: en-US
To: Simon Horman <horms@kernel.org>, Wenjun Wu <wenjun1.wu@intel.com>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<madhu.chittim@intel.com>, <qi.z.zhang@intel.com>,
	<anthony.l.nguyen@intel.com>
References: <20230727021021.961119-1-wenjun1.wu@intel.com>
 <20230808015734.1060525-1-wenjun1.wu@intel.com>
 <20230808015734.1060525-6-wenjun1.wu@intel.com>
 <ZNKrc6xchj8Jkct+@vergenet.net>
From: "Zhang, Xuejun" <xuejun.zhang@intel.com>
In-Reply-To: <ZNKrc6xchj8Jkct+@vergenet.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0033.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::46) To BYAPR11MB3175.namprd11.prod.outlook.com
 (2603:10b6:a03:7c::23)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3175:EE_|PH7PR11MB6930:EE_
X-MS-Office365-Filtering-Correlation-Id: 821e3d0b-c4fd-4af1-eac9-08db9908a564
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pgNiOwi6GVnviFr9iPhGxcQ+96aDzTL6g/HJhgMCqWhRQfpPAjm+DksHH4ZEYPQS86mhml4xYUjLaAJexUlONYta0L2rW+s3w0KpSx7wKs4zVEaMBeL+s6agXpWUEmm/veaUsuXtnAswzkmhg9k0BxUjsBlOjDEb56JZ+pkhlpjXXpFYmE8yQoyUzx0WomKCb/XijOpNv99k3ylYYju8Pw5vwHmq0Jy58bzWomCAJAIyF2Az6sH9DgzGHsk0NWVy9tYf1NDbrMX+WlVjXxVPhmXXq0dKVVgKhwvzY0IOyofKyLPFX8yMx3JO/NXKT95fNsMEMQRzjhX5T6OcdvSZ8xH71XWB2H/hJ0iuiKh/ifKah1IdqH9WVkVOr4ZhKY591Ivl0s/6SrFniQuklZTXL7z+QtbHW7N0bPp+WVUZi4aPFGj+pFCClhfkJBrS/QIvaTaBU2nYbpe+IgelTlMz4jk0oC1qpbRiUY+qS4BV4d11iZwE8KqPW5miYfCMMdhCfrg9X1cNt4yBj00ZjdcQ7kFRAH2UFA9Js+8jEZZTKjfsDc0onjlBX31221VJcr+XzyEAtyoOF6Wz1hRujzJ7NiL1zlS9RY28dbB1LVh8QHl1wT9hMtkdMw4F+z72BL9XGzniMMh8e1EGQc4xLlbAuA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3175.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(39860400002)(346002)(136003)(396003)(1800799006)(186006)(451199021)(66556008)(316002)(66476007)(41300700001)(66946007)(6636002)(4326008)(478600001)(110136005)(6506007)(53546011)(2906002)(31686004)(107886003)(26005)(8676002)(8936002)(5660300002)(6512007)(6486002)(2616005)(83380400001)(36756003)(31696002)(86362001)(38100700002)(82960400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RWlKdTFiZ01GUzZlLzAyOFcvUzY2b0hJTnJzaW9rS1dCcnFTRG50a3V5TG0w?=
 =?utf-8?B?VVlvdm15dWFxRUxiVVZScXNNUmxBZU9lWTJNYnEvNGVKMEdhcGZORFBFUjBN?=
 =?utf-8?B?a2czek5qQ0QvNm9tRExWUFlKMldGaUV1bXc4VkpYTHpaS1c1bnM5RnVlOXF4?=
 =?utf-8?B?R1QrTTRISEpkU24vdjZxTE5EVWh3TGduc3FKdnBDVGM2SjhDNHp3REczaW0y?=
 =?utf-8?B?N2E0cFh3dnFBV3ZrSytaQjlxcnJSM2ordENYb2VGNmNzTGZZTGQyVDRYZ2J4?=
 =?utf-8?B?em9IK2RESFJ0cjI4VnZTb3FRQjZhOEFOR0lWaW9xZWJDODhvSDRsbW9LRGF3?=
 =?utf-8?B?aGJKZm55UVF5VmQ0VVV5SDdLMStxUzMrQ3lVNHh5cld4MlR0Z2h6cW1VNzd4?=
 =?utf-8?B?Sm55L0FxZGlqQjNXWjQzVGJwSWhBdlFBT21tL2hRcTlKNlFUVDY3Rk5Vd3Uv?=
 =?utf-8?B?K05Ea2FqdnkvSG0zRnpEaE8rUTViaU44YUt3a3lxZkVYK2Y0UFNrc3I2TkJ0?=
 =?utf-8?B?bS9wbE0rcDRFUjUzNk9TYUR6WHdOWUl3cllnczR0YXRsemhnNUt3MW9oeFBl?=
 =?utf-8?B?Y25lVGFXODQzQjdQRHhRbkwrYmRaRFlPL1lTb25Ec0pObEF4bGJwVzVYWGNH?=
 =?utf-8?B?SStLVnhDeVFpK3htZElUc1B6V29xT0dnUUVHVFF5YS9mT2JlbDU3N05lOGpV?=
 =?utf-8?B?bjZ4amZCYUw2cFVzRzBsMlpIWjJybWZlT2g1SzNSYW5rT0ZvQmJMVEs3U1Rs?=
 =?utf-8?B?T2RVWFhieUVmYlVNckcyemJPemt5akNnMUdLdWEzMW80dGM5bk5QRC83MTMz?=
 =?utf-8?B?K2svK0Y2Z1grbDcyVXJyWjByUVlHZS9zOWZsVjBrMy93aXc0STlFaFoxWVcz?=
 =?utf-8?B?K09GSCsrVm9hUDdoTlZXTFR6Wjc2WFNTMDJwNkJJeWVQZ2Jtb1VtUEVPRm9Z?=
 =?utf-8?B?YndEZ1AvNmQ1UytXTUs3WUcxWEcwQmhpbURIWVlKdlRveFJtZ2lCdTFJdktQ?=
 =?utf-8?B?WWJCcjkwRHE1N3NjZGRJSG8ydFdqYWFQb1ZyeVZ1NTZhdXVSMEV3QUNvWjFq?=
 =?utf-8?B?bCsvbkZaVi9sc3g3bDg3b3JaS2N4akR1cUI0dWtRVlFnUExsV1ZZaUhLaW1Q?=
 =?utf-8?B?SzFPeHlZVmxBWFMxcGdrdTR1dTIrUUZUdEVNaVF3UWR6ZGlLMXRiY0FDWGtJ?=
 =?utf-8?B?QjEwMXFmR2NiSVB3R1NoaG9LSzA5citiMWR1S2tDdmVnYUEydFdSaUtldVRy?=
 =?utf-8?B?S3B0MmZhMkxrNjlIZW5yeGdlYk95MGV1VTRPTG5nQjB4LzQ5RUY1cHVIVzRL?=
 =?utf-8?B?Q2dUZWdsbFh1VXQ0VzRHaGdDMUJONXMvZ2xXSXlVbHFqOElLMkZaVllDVHYv?=
 =?utf-8?B?aEI2QjhjMVB6LzQ1NVl0Z2tqSWNRZFV2N0J0SmFNNDl2UUVtY1dGTXVxcDYx?=
 =?utf-8?B?Q0xHZjhDcFcrQ0MyTnJvRFpFTTAyaGhWTTRPQ2tPalhkYjk5VzFGVFl0UXZM?=
 =?utf-8?B?aFB4SHdMdmlhLys3ZEdEZTQ2eXFneXFZMGF2RWpKeHdLMlFzZXBCWVNyTGtY?=
 =?utf-8?B?dWhnSkFyRmlpdjVzaE5wMG5laWhTaWExejhEM0ZvNUp1aTd0amlCcHM3VzNz?=
 =?utf-8?B?ZG8ydVY4VlNSbnI0UldZc2x6aUttc2NmdDdLbnc1eEFFbE9RVTYwak9pR004?=
 =?utf-8?B?TnBqSnQ0N3FmeDNSUll0Q2ZrUHpjZXRibEk1U2RHTC9KdWVqbzlweU8za0VI?=
 =?utf-8?B?V04vckJQRjlDYjhpUnh3cTNZc0ZhSUcrL2xQTmc2cXEyN3FxbWhlREgxaHc2?=
 =?utf-8?B?aG5kcnRxVnRLYzlzcnliT3lxa0NKb2lWa20zZ3dHdkV1cHBFcFhoazY1Z1l5?=
 =?utf-8?B?cGw2ZkljQ1JyeGVkNUFZU1JUb09NNDJsOVZEZ01GMU0xbi9ySDJuRnJlc0cr?=
 =?utf-8?B?ZkFvRWZYc3UyMGgwUVplMGtYRnVqbVpLMEdFZDNMRjBqVnQzTU1qTForVFFm?=
 =?utf-8?B?eURDUWNsbWYyZkhvN2VFMXRiYTJZblVJR0t6UVlQb0RPbFJvVWx3RWU2ZnpF?=
 =?utf-8?B?WGdRQndsR1FLTGt2KzZmQkhsSWJHRE9lQ0hObXJ1cUdCeGF0b1AybjRCSCs2?=
 =?utf-8?Q?xoW0j/r9EtP+epvErqqgJkCrh?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 821e3d0b-c4fd-4af1-eac9-08db9908a564
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3175.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 18:44:21.7808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NbNwh3D/HPx8RGCwXw0iTMEPHcH6/KSG0OrjWcGJrOMTZXapr0lzPmvVvOBEjEUehCjNYH0n1H2ud6ggiK9EMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6930
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


On 8/8/2023 1:54 PM, Simon Horman wrote:
> On Tue, Aug 08, 2023 at 09:57:34AM +0800, Wenjun Wu wrote:
>> From: Jun Zhang <xuejun.zhang@intel.com>
> ...
>
>> @@ -2471,6 +2687,16 @@ void iavf_virtchnl_completion(struct iavf_adapter *adapter,
>>   		if (!v_retval)
>>   			iavf_netdev_features_vlan_strip_set(netdev, false);
>>   		break;
>> +	case VIRTCHNL_OP_GET_QOS_CAPS:
>> +		u16 len = struct_size(adapter->qos_caps, cap,
>> +				      IAVF_MAX_QOS_TC_NUM);
> Hi Jun Zhang and Wenju Wu,
>
> clang-16 complains about this quite a lot.
> I think it is because it wants the declaration of len - and thus
> the rest of this case - inside a block ({}).
>
>   .../iavf_virtchnl.c:2691:3: error: expected expression
>                   u16 len = struct_size(adapter->qos_caps, cap,
>                   ^
>   .../iavf_virtchnl.c:2693:46: error: use of undeclared identifier 'len'
>                   memcpy(adapter->qos_caps, msg, min(msglen, len));
>                                                              ^
>   .../iavf_virtchnl.c:2693:46: error: use of undeclared identifier 'len'
Thanks for the solution.
>> +		memcpy(adapter->qos_caps, msg, min(msglen, len));
>> +		break;
>> +	case VIRTCHNL_OP_CONFIG_QUANTA:
>> +		iavf_notify_queue_config_complete(adapter);
>> +		break;
>> +	case VIRTCHNL_OP_CONFIG_QUEUE_BW:
>> +		break;
>>   	default:
>>   		if (adapter->current_op && (v_opcode != adapter->current_op))
>>   			dev_warn(&adapter->pdev->dev, "Expected response %d from PF, received %d\n",
>> -- 
>> 2.34.1
>>
>>

