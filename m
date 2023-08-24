Return-Path: <netdev+bounces-30173-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7947578644D
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 02:46:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D72E7281081
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 00:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A593D15AE;
	Thu, 24 Aug 2023 00:46:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950927F
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 00:46:36 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 380CECED
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 17:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692837995; x=1724373995;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yJR7IjD03RfNQ+s8bl6EcNTX/FC2T2Ftuv1VTeR/Ahw=;
  b=mpRovh4mF+28QRk6hPTXLQ+awsOucEH94qy2EWWGI9/Mt78PgtEY9tnY
   Lz2HKvCz8v5PIqCz9cL6ZU450Qqsjssgxp8x3sPrSKlXg5xWTfyMN1jbD
   3Y3vifT8ANktVfCk5hFJ1qQaz/e0t12wuZNVigaUwINpAFOyrs/JAbPv6
   J7DzJ9YBtyrKiYqFkiU2Q15ENVfzaWZQoElsOMZd+pb7m47gIqulGnor9
   JHvlWX7F5mMZZskjoQKEE8b6ZnOhJCsmVKuFcm2WHO35Wu1qwfivYsWk+
   uAu/pJpE/Mk0EK0v5mG5n8i/6bsCteoh/RSxtOXLh9r1vuQsaJDcQkfmi
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="359295219"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="359295219"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 17:46:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="806892566"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="806892566"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga004.fm.intel.com with ESMTP; 23 Aug 2023 17:46:34 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 23 Aug 2023 17:46:33 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 23 Aug 2023 17:46:32 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 23 Aug 2023 17:46:32 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 23 Aug 2023 17:46:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UQyNaCjRsH4py57nMLEtdLnbsJq389v076Pp9cFxs4ld/L5EwGBKRBsZKzKwWwh1vsq6pcWA+8FwXP1L7aaG/7AMSjxw5hFcGMXBRdw/2KUO6DzTdQBs574Ml9BVeQ4xSEBK/q2v8c08LCn1tjjvosrZfzPWerhC0XWs1c9o3jxbgDRZpq4FaxGq66J/gElh4u4YU0J3igZmkblPoPwAqbINSayM/3sIpLVjPk7UCm074Pc2EXPe281Re2IJviERNXVlKvX4l5mxpytlE+0GJQk5VzICit/2dxKBBXVoZjhj10MFiKtgyFsxHN4qWamYlOKlxiWT0Qh20ujybXfrkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ba81N0lAG4THLqs6MmIBP0eYwuUMrPhMmwCqAd1/rY4=;
 b=WKqYkUf+hoR8SWGeCTMAj090nysPwXVA5TdQDtlG2M69AnA6yFnj1KfoqgNdeWfhjmAIZ8pMDF+7hukM3J2j2a+SJTT5fTFk0rO1Ybc46DQIyX4ljGszF5Ugl1yIlf/mHlXe8wkVJrDbnepPuUTciIPSBTq+Xvg/sTVGBg0lyVY1O7bTILl29JZsnuT0xur0jNg0EYJROi3+3+HHOPGxeU3nmcYEykx0BIIJKbbty6FQiQe3FgXupLUnEGokgrjvDQCDWG1J0TW1kOZfmguCSLvm7uWFY+OfDuQHEvo28NvfbKYS3UFK0RGF8fA62wNLEQelcfq04RZtycUCE/NRug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7869.namprd11.prod.outlook.com (2603:10b6:208:3f6::7)
 by DM3PR11MB8716.namprd11.prod.outlook.com (2603:10b6:0:43::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.25; Thu, 24 Aug
 2023 00:46:25 +0000
Received: from IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::12e4:637d:955d:a5f]) by IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::12e4:637d:955d:a5f%6]) with mapi id 15.20.6699.026; Thu, 24 Aug 2023
 00:46:25 +0000
Message-ID: <d4957350-bdca-4290-819a-aa00434aa814@intel.com>
Date: Wed, 23 Aug 2023 17:46:20 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH v2 3/9] netdev-genl: spec: Extend netdev netlink
 spec in YAML for NAPI
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <davem@davemloft.net>,
	<sridhar.samudrala@intel.com>
References: <169266003844.10199.10450480941022607696.stgit@anambiarhost.jf.intel.com>
 <169266032552.10199.11622842596696957776.stgit@anambiarhost.jf.intel.com>
 <20230822173938.67cb148f@kernel.org>
From: "Nambiar, Amritha" <amritha.nambiar@intel.com>
In-Reply-To: <20230822173938.67cb148f@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0236.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::31) To IA1PR11MB7869.namprd11.prod.outlook.com
 (2603:10b6:208:3f6::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7869:EE_|DM3PR11MB8716:EE_
X-MS-Office365-Filtering-Correlation-Id: acfbba27-a5b8-456a-7aae-08dba43b8ac3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BbG/Xf3xf1uux8swtFAhEyTTztZ6oNq2YVZItlUo9exJa1VmtY9CmFdXtlNru6DWHu82JWoFhtOyhmB9pqFDJBX5yb2x473I+89sHWO39FFVCcceFUfR2h9WrkZYCnEMDWzI/k0uXgMeeT0zYn+kqR0pEsfYTczDgmfksNds3399/bhTtBdATpBrizc1uKtOH66cWPXCpFNhhTaLNDibpW8PSEBiYChEjPfscgArVuM+um8AE5s2k6UQZgVQ9GA6BnPSAUXEU6FvdAS213JSPGp5I1oLhlbfkD89OZYH9JbhQrp1csNt9ygkCNTpMRH++9fZIj68nLmnuGyltAJvFgJ/eUFbN5NnptRjNRU4aq9kOlAHOtIpHwCS2OgfvG74DjwL9TUNaHhN6Arpv3ykzOT24BVNa53o0MYBFdrHwXQ79ampnKPnjmp/EEViafs+I1OhyZv0CkK9d/R1myOHSyAvNYE8Waz7Ze7hBF6YOquhhB/z3zVKI1AFcy3V9Tpdn2fbdrMwSrs4T0QjGZgwVWa/4phYmXAUX1DQMXKqYN6kH6hdiEQhWU19MeZxvTEwnFiC+sA/sEYtKU5tYAZ3YTGCtYPw0OF62klzakjFrUUTR7iE9qJmKvxnUv/rJnnGmcNI/lJlWNViw4bfeo+fOg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7869.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(136003)(396003)(346002)(1800799009)(186009)(451199024)(6666004)(53546011)(2616005)(6486002)(6506007)(107886003)(6512007)(86362001)(66556008)(31696002)(5660300002)(4326008)(2906002)(38100700002)(82960400001)(8676002)(66946007)(8936002)(66476007)(36756003)(41300700001)(6916009)(316002)(478600001)(31686004)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ODQvNzhRdTh4ZjFodnhMWjA1M2ZGajdBS3h6S25vYVcveFp0WnphNVZRUzFw?=
 =?utf-8?B?czZucU5VWHVhWFNHeGVHLzAwWWhuc3FsYU8zbkw3VlRQNGN5eWZhS3U3S1Jp?=
 =?utf-8?B?d0wyMTcrRDZrd2NSN0Rud2FhaE9peFBDV1JIdjZ6SElNR24wem1zL2VRTWdE?=
 =?utf-8?B?KzBJQ2lLbW1ab3dFKy9OUnJKUFN1YUQzTytvZlQ0SjZzUjRjb0JnRXZrRGFN?=
 =?utf-8?B?NDI5aGxKYmRvdStMVVQvazYxMTVIU051WGtGN1drZE5JdnlPL2p4ZE55N0hG?=
 =?utf-8?B?cXNsOEtCVlF4WkpsM1NJMXJ3OFlTTmg4WldtcXppTVhaaFZydlNubzI4U0pB?=
 =?utf-8?B?YytqZGx6VVh2WEtjd2tJcDYrL1h5NUxPUlpnbmVtbm1WaFpMVXlpWHJZKzZq?=
 =?utf-8?B?MVIvTWJDcGJoR25IT3dZaFM1V29LZk5TZ1JheEdLbDFtRVJEdE54angvOStH?=
 =?utf-8?B?aVR1K3Q4YUl0L2kyWS9YOFk2emxQbVBKaThUNGdBMVVzYjFVQmxiRk0wMkVN?=
 =?utf-8?B?blRaU0NsQ3NVUDNYekRlWUh1NWd4ck01d2VHS3gwVEk1bjE1RWw4QmI3MXdt?=
 =?utf-8?B?ZjlHY2JGYjc0cEpCRTNtUjZQT0lCcURQYzlmeWxpb0xtSlNJY2hEcDJYOXRP?=
 =?utf-8?B?UEFPWUdsYSsydnpyR0k0MnlSWXBHbWtYTkF2NE9ua3pXS2Jja0F6WDFRQUQ1?=
 =?utf-8?B?eUlkWXl1VHBWOGNSeVZqMVVheFU2U2lBbjk2NVFsRnZLYXZCaG5Lc2pndEtT?=
 =?utf-8?B?dVFKY1ZYMUsxakhBV0pJem5RcTVpYVFCZE0rZStXMHRQQk53ZkpQWU5tc1lC?=
 =?utf-8?B?SW8rbHZ0QTc4bkkyVk1jMkJOMnhZanp6VkY3TGN0UTlwNzVRSWNPZ0g3RWph?=
 =?utf-8?B?T2pvQ1hEaDNKcmZ5MFlZWG1aZ3pnNURKaW9mcDVLcTU3OW13K0Qva2RjZDlP?=
 =?utf-8?B?bkxDMzFQaWNFMVJHMkdZb2JVVWJnNTR0cy9vZjJVS1k5Zk8vd3BSNStNV0ky?=
 =?utf-8?B?VzgwN213YU9IaFQwUVZOaHpqR1l6Lzc4QVVLb2YyZzJvOGIvNEMrMm9MaFVy?=
 =?utf-8?B?MzN6OHZyOG90Y0NoeVJCVGJBNm12UGFCYzdRMmFiM2RpQjRJZFF3dDVJMlQ4?=
 =?utf-8?B?bWVrdTFiaEkwTlRQR0F2L3dENy9wTGFpNHZ2d1ZYRWJFREtNbnZVV2ZYdDF5?=
 =?utf-8?B?Z3JRbDFQVFVMZFhaQlFLSTlnbnZNYSs1ZEkwTjhmWGJLTTloMldYWXBwN1JW?=
 =?utf-8?B?MG5VaVlPdDB3ODhOZFZPUU1rK0t4cG5DTmRJQ2pTYnFxWUJTUWwycndPNCs0?=
 =?utf-8?B?QXl2N3RDYkNRSTJCTk9wTXZWcWM2Y002ZFo4Tm9udmJmalV4NDYxdTBlMUxE?=
 =?utf-8?B?NmFQMXdEdGc1ek55My8zSzVOUFR4T2U5bWVhcGltbTg3Vng5Qm1BdUlSUGFP?=
 =?utf-8?B?MGpObWF6K3RsVVhjbzNqRS9mS2oyNERpSzlkSEtOeDU5LzRkbmFiRCtLRUlF?=
 =?utf-8?B?cmJMb3hzTnVDdXRhenNUWGx2S2J6Z0NiS3VWOWhkWEhGUzY2ZWc5R0pTSWlt?=
 =?utf-8?B?aHBHQ0FzV1RrMG8yVkxEeExiWTRxMUt3YnhRYXJ6QXBqMUxiOVRKMzdiOEZh?=
 =?utf-8?B?R3NtblhyWkVRV1VaOFZDZWlxMVlzOVZYMlRJU3dyY2FlNUIzWHRENlVYTWxZ?=
 =?utf-8?B?c2pSVkswaEsyb2h2VzlMeHBaZ0ZCUTh5elkyVHVmZzJsUVd4NnFIcFUzNlN1?=
 =?utf-8?B?dVdZT2V4UzFUdHkzUmdCd0doSnpzYW1GeXBGaUNaS0xPb1A5dFNJOGtkaG5u?=
 =?utf-8?B?cXRuakZ4SkNtL1FleFNtNzdmTmMwQzFwVnRDbWx5eHUwcCtwV1B4TkcrQVR5?=
 =?utf-8?B?K0YrdXBKMnFMZForaFpvVU9KQXBKRGIremRoV1Q0ZDlaWVlYak4xd1kwTjFx?=
 =?utf-8?B?dktqa1M1N0NlcFBHWkZuM0owZU9vaFpuUS9KWGhoRmZ2bUx2OTFvMGFua0pp?=
 =?utf-8?B?VTJjMFJmcmpnWWMvbVd5aGRYUWZIZ0xZam5LdnE2REJMblhUUHovWS8xNllQ?=
 =?utf-8?B?b3R3aFRjQlBtWjAybjJKU0s2TkNISnB1VERsQUJXNEhUenBBRnlwd2thVjdy?=
 =?utf-8?B?WVJnOGw3N0xKRDZXOGhiSlFnRXNYRlFqVEIyZnFXaDJCQU9kYUtJaURVcm5P?=
 =?utf-8?B?TXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: acfbba27-a5b8-456a-7aae-08dba43b8ac3
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7869.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2023 00:46:24.8466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RmDQFg4oxwwKCJMozD3frTgbdDY/u7mX+zWpDYOLVXP0nfnOXnj6H+C1xNMg8eGnJA/Ktq683RIyf4B8kQ6MTT7O0ywNNPbdHHT31pt5ttY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8716
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/22/2023 5:39 PM, Jakub Kicinski wrote:
> On Mon, 21 Aug 2023 16:25:25 -0700 Amritha Nambiar wrote:
>> +      -
>> +        name: rx-queues
>> +        doc: list of rx queues associated with a napi
>> +        type: u32
>> +        multi-attr: true
>> +      -
>> +        name: tx-queues
>> +        doc: list of tx queues associated with a napi
>> +        type: u32
>> +        multi-attr: true
> 
> Queues should be separate objects, with NAPI ID as their attr.
> That's much simpler - since the relation is 1:n it's easier
> to store it on the side of the "1".
> 

For the "napi-get" command to generate an output as below:

{'napi-id': 385, 'ifindex': 12, 'irq': 291, 'pid': 3614, 'rx-queues': 
[0,1,2], 'tx-queues': [0,1,2]},

wouldn't the napi attribute-set need an attribute for the list of queue 
IDs for the display ?

Internally, I can change the implementation in patch 1/9 to what we 
discussed previously (remove maintaining the napi_rxq/txq_list within 
napi, make use of the NAPI pointer in queue struct that stores the state 
on the side of "1" for 1:n. This would although change the complexity to 
#napis * (#max_rx + #max_tx). Currently it is #napis * 
(len(napi_rxq_list) + len(napi_txq_list)).

But, to display the list of queue IDs for the NAPI with napi-get, 
wouldn't the YAML still need such an attribute within the NAPI object? 
Or are you suggesting that the "napi-get" command does not need to show 
the queue-list associated with NAPI and a "queue-get" command which 
shows the NAPI_ID associated with the queue would suffice ?

Can we have both: "queue-get" (queue object with with NAPI-ID attr) and 
"napi-get" (NAPI object with "set of queue IDs" as an attribute), 
something like below (rx-queue is the queue object. rx-queues is the 
list attr within the NAPI object):

     name: rx-queue
     attributes:
       -
         name: qid
         doc: queue ID
         type: u32
       -
         name: ifindex
         doc: netdev ifindex
         type: u32
         checks:
           min: 1
       -
         name: napi-id
         doc: napi id
         type: u32

     name: napi
     attributes:
       -
         name: ifindex
         doc: netdev ifindex
         type: u32
         checks:
           min: 1
       -
         name: napi-id
         doc: napi id
         type: u32
       -
         name: rx-queues
         doc: list of rx queue ids associated with a napi
         type: u32
         multi-attr: true
       -
         name: tx-queues
         doc: list of tx queue ids associated with a napi
         type: u32
         multi-attr: true

