Return-Path: <netdev+bounces-22992-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27F5576A583
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 02:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF78528164E
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 00:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C44FB373;
	Tue,  1 Aug 2023 00:25:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B616536C
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 00:25:07 +0000 (UTC)
Received: from mgamail.intel.com (unknown [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D6A7199D
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 17:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690849506; x=1722385506;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UHOgr9/F74MeByhjHMuEi9s02wBTXFwQZFcoAXjgDrk=;
  b=Q+JIpaEKzAFRHubDN89wwHm9X3A5KRzK2qzwos9LD6pzW5SG+AI1z4Lm
   lqtIVwHkl0mjkXo8mLJLIqcNfXuce4nzmYAlwybTPQeUcUSEQLwqKrbd7
   Q/a9gYum2WdyQkFAit7Z7Qp9AGh1dY1UF01XlzdKhwXrH3UZF6CP5Xvhy
   S1je10bBVfDK/56cG/owA4bgsq+Pwt27/s1ftbrGv42ySfl2WPBSWFmEx
   kx+s/skxzQnBOkTQKr9AFuLJlOK49wc3Xu0GjRKs74eTAFdw7+ZJhJ1xI
   n3qkMMvXpwWlSGCk8IC99w8zajA/2x6eQFKAbbiXVdjC2oHsglf9iiswR
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="372780074"
X-IronPort-AV: E=Sophos;i="6.01,246,1684825200"; 
   d="scan'208";a="372780074"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 17:25:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="798445071"
X-IronPort-AV: E=Sophos;i="6.01,246,1684825200"; 
   d="scan'208";a="798445071"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga004.fm.intel.com with ESMTP; 31 Jul 2023 17:25:05 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 31 Jul 2023 17:25:05 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 31 Jul 2023 17:25:04 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 31 Jul 2023 17:25:04 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.103)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 31 Jul 2023 17:25:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M4nElqMJWH3NMyEUVys3WD4DxXCe0CawOkObReKag8jhmwgbatzZitiTi4oisG9O31EkmWC5VCA2yZoxBYObd+gZJcUrq4cFPBPYMcVoOALPF/qTTnS+Bi12FpZwk8pgkd3KumpeKvl/ZJjI+PFtZuPRaJpqwwBCNvUuXZjRzgDSE9k2WQ6Gg5OZY5uZcIYC1pOBdAnFdwvvVMxv6a3V9UHYoZjqrWmVLbe6N89miIhmkcNlHY71O/OXl5MeYYIoXt3l1tKr2dI8MXeYUGaIhO9ic74lrcXQBFCBm8Jdi5pcQpT+7kKUMm5SV3+c/gx+0/8kxa6g6xzxLQ8ETESLhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G5u08dGT7lpdtEKMNyxxld/FfkW0PNBQ1CVLl+M8X8E=;
 b=P6xTcw079HGfJoxdGpVapz7LAScVn/0pCWATO/J2UBjy5zk2zPJZneSeDhfR5R/FjX3swmS3ghUxQccX4M0crs9hK4HzXnqBi5WNqTu761Mg3jnfEpxU7FGJTcq+CGe1YorVXlwibUF5QrTuY0KB601EF9HsUBwHshYQOEK20PwPPfW3qgYR0rj8AvdEzZExZJSGzhAYhXuM5YoJ0X8Mh/qtWZilyfKJgCJjEgntvFDWGTrlYPeuc3w4yr94spyN3WgA5lfAdcbK+zF6Mt7KugOnqumUe6PdTA6FjD9/vSvkvE0urAsTlLF2L423i+UQYqKHGwyxvZpHyUB5+Eafcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7869.namprd11.prod.outlook.com (2603:10b6:208:3f6::7)
 by CY8PR11MB6818.namprd11.prod.outlook.com (2603:10b6:930:62::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44; Tue, 1 Aug
 2023 00:24:55 +0000
Received: from IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::12e4:637d:955d:a5f]) by IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::12e4:637d:955d:a5f%6]) with mapi id 15.20.6631.043; Tue, 1 Aug 2023
 00:24:55 +0000
Message-ID: <c21aa836-a197-6c63-2843-ec6db4faa3be@intel.com>
Date: Mon, 31 Jul 2023 17:24:51 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [net-next PATCH v1 3/9] netdev-genl: spec: Extend netdev netlink
 spec in YAML for NAPI
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <davem@davemloft.net>,
	<sridhar.samudrala@intel.com>
References: <169059098829.3736.381753570945338022.stgit@anambiarhost.jf.intel.com>
 <169059162756.3736.16797255590375805440.stgit@anambiarhost.jf.intel.com>
 <20230731123651.45b33c89@kernel.org>
 <6cb18abe-89aa-a8a8-a7e1-8856acaaef64@intel.com>
 <20230731171308.230bf737@kernel.org>
From: "Nambiar, Amritha" <amritha.nambiar@intel.com>
In-Reply-To: <20230731171308.230bf737@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P220CA0014.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::19) To IA1PR11MB7869.namprd11.prod.outlook.com
 (2603:10b6:208:3f6::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7869:EE_|CY8PR11MB6818:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f2d8604-1313-49cc-53a4-08db9225bb04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HX30I0UYndrimy0zxMAXUGNRmsjnrbYHylcCXKmMYDbki09CUQJwzAYj1dm5lxxWSrVzdrXcEkavJP24HZSlo1JMg8hV9UF8km+0epAVemSokHqRfCzzRMYd8bwCjqHQ75LfcYwCO0mQFRYYgTgRFehmPk+TGnYx1/GY4CPNP1KiPXzjzHyTlNuKdgQwDNRawLNbDzaztuu01JWC8/1jqj3Wf9pMha32FOuCi7owF96jGq+UHDNrYbeZzis425FsLijjDi3nQfJ74df/J7g2QhbSokS5X9S8Edik+x7d3+ELjrdVNaDIuRUqUFil2WLoscT9Ss+WtcRhGOyT+VQKpNiKqkXjmEkLOG2CEZ8ZvLScvQz6s7y4W+t04iKU84bpxySgH48pbNWDQqjiv/BggHVI12bj6UWvLnQshyiwk8N6I4/hs4oPsavMdETDUHHCQaesRG5OFKml/qkx9aNVRsSfiFgRkKzR7wwDCnCXeVaMe1zYJmFN5P74fjzq1FiEdQ6aFDuVzDfcUO1wvXqaiKXxds2xHf2rwdadvuF4zehTjaN4DWdJdq7/JjwlkR9U/76OhJOriXnIX5dv6S3vktwoN2Zkj9tEbMt9Wnn4AupRXAWitq1L2/7+luWuefnqt/RYqluDRkhJrIWwyYPbsQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7869.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(346002)(396003)(376002)(136003)(451199021)(6512007)(6486002)(36756003)(53546011)(2616005)(26005)(6506007)(107886003)(186003)(66946007)(66556008)(41300700001)(38100700002)(82960400001)(31696002)(66476007)(86362001)(316002)(4326008)(5660300002)(8936002)(6916009)(8676002)(31686004)(2906002)(6666004)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y2U4Y0RxV2VEM1IzTENmYnBHYUxvellhTE1jb3VvaTlTRGJhQ3RvOU4reDR4?=
 =?utf-8?B?dGNPMzhkaHRuV0hSMkJVWE92WStYMWtBbk5qZGYxdzR4R2tlOHdUckRmY0d5?=
 =?utf-8?B?NHZiZ1haelBoNGZHZ2lVMlYvaFFZYTZLeEpNWlAyUFV6SVNmTXQ5QXBuNWF6?=
 =?utf-8?B?WUczTzh3bFhZL2wzYUZRd0JsUU94d1c4eUNlTE5lQld3S3YvemhpUDVCc1RW?=
 =?utf-8?B?VHFvR2Fmc3ljM0I2aFVleXBvODhFMnE3cUtEOGRnVURMNHFFSkMvVVdmQkY5?=
 =?utf-8?B?LzhSYXNGcHJMdjlOZ1A5d2JHN1pRam8yTzJGVXBqQUNjaFVkaVBBN2VtM21v?=
 =?utf-8?B?cmgvcFUycTl4NTQybGNVS29XeXJMdU1BTmNXLzE5Nkh3aHF4OWl6b3RmUkI3?=
 =?utf-8?B?cHRZZ3VucnQ1TnVsZ0tWSnAzS3AvZisrQklDeHpkZ2lzSWY1TzVhVVVwTExp?=
 =?utf-8?B?cmJwOFczclE1K3UrSkpNMk5lZ2lyNUlna1hYK3NJNXcxNGwvczltcWFPNXBB?=
 =?utf-8?B?NWcyTlMwVFcrM1JzelpwVUl5WmhEOENVajdTcHZsc2tjUVo0UWNuSHVDK213?=
 =?utf-8?B?dnM0azM3QUcyVUdNd1hlRVdkY3NnV0t4OWdKL3RPemh0dTM4WTAxbGRWUXV3?=
 =?utf-8?B?YUNqQ0lHSG5lbXNNSFVibWd4SHlLVDUxZzJvSXp2OHErMHdmUHM3ajhsWmUx?=
 =?utf-8?B?aWVvRzJuN3hLbXM5NGZySHNrQzgrcUNDWXQ3b2ZObU5pNFNXL2JqYXl0Y0tH?=
 =?utf-8?B?Z3pwYmFCK200aGpPYzZXZHNndmxNYVlGcFVXbDRIVloxc2M4OEdCNWVBU0hJ?=
 =?utf-8?B?bUwwQ3ZvOFIwdDQ1d1h6aG0vOTlJRmVKaDBTMWlSdjJ6U0lQUUJvbkNGU3JJ?=
 =?utf-8?B?eE82cnJyTWc2R0RUT0pNWGRTRG5HdnNqb05OMlJCczJoZUgxclRLdmM1c3Js?=
 =?utf-8?B?SThiRGk1clJpaEZiZ0VIYVN3UUFKZFdsSlpFelhnQXhtV21YOGV5TG1jd3R3?=
 =?utf-8?B?OWU3Sy9HOGNUT1AvUlBLeGtiZGdodk5GN2syU3RHOUpNTmJEWE9wbTIrRm53?=
 =?utf-8?B?c0w0dFR6WDhsUHNwYnZHK0txMGF6WlQxTEdpeVdDb01rdk1lWmxyN3dRZkZO?=
 =?utf-8?B?WDBLTGs0WjlXZjgrb21CZmFDL2Z6a0g5REJ4R2M1UzcrZ2cwYVdUUzRvMWgr?=
 =?utf-8?B?dTQwbWMvNWpLTFhVcjhxd0VPRXNUckhXWUpkSU9DVjZjNDV1QjYwOW1uQTkv?=
 =?utf-8?B?RkFLTDZVR3o3V2xXOWk5bzVUQmtFVEpwdDREYzF2L0g0NWJvV2hQdStyTS90?=
 =?utf-8?B?MllhQUNoT1NVZmZxaW5DTW5pMk5xN04yUWk2cTlPOU5ZbVoyMitLeGwwb2cr?=
 =?utf-8?B?dkhiNWFxTkE4dDREUS9TL0d2SnhYd05pVVo1M0tlbU9kR01RdFFrVWJ5blFO?=
 =?utf-8?B?U1ZhMzhHeU9NYkFUVzZzdTI0QW1QQzNkUnNodjNiZFJqRzRuQjAva3hZVUxu?=
 =?utf-8?B?cm11RGlDY1BoVDdoRm9ISmJFZmN6K0tmMzZvQmFWQW9HRUtCc09VY1VWN2Ey?=
 =?utf-8?B?bFk4Z3BiQ1NpNzZkSnBXVG4wYXNDUU9icldKcGlsQzlEQktNTUd1cHU2T0Iv?=
 =?utf-8?B?UGpLUXRsM2R0Sll4WVdKRk1TQnpQbzY0a1huY3BmT0JONlFpR2lSSkVUdGlY?=
 =?utf-8?B?SUpmL01Qbk1FaGJsaEpuaW9HWkxyS1RCeHo1b0FkeGRFbmFST1p3M255YXJ1?=
 =?utf-8?B?QytxUlNySVVDcTNUdUZ3UC9wR0ZZajl1Q0dnQjNyZndQVitBeDlweWtoU1pX?=
 =?utf-8?B?RlhDRyt4QjBCN3l3elZpTXYzMzl0bHU5RktkMnJRd0xXYlE5NW1XdzRUMC9n?=
 =?utf-8?B?clkzNmkzWVJ5UUlvYXJkK0xqWGQ0Zk9mdDBibzRHcjM5Y0VkcWgzZ29tT1Zn?=
 =?utf-8?B?K2hCRWxZOThXWUw0M0RtaGFQaHppUENZTEtiNjhQNUpkb2pOOHcyY2MxVUE0?=
 =?utf-8?B?MGFhK25ldkUwSnZuVnZBVHBwQnNTMmhNRXREbnhCOFlVUjQwTTVKYVBlOFl2?=
 =?utf-8?B?dVpiRU11UE41TGl4SlhJM2FEZlNIOHFlK3FmZ3Q5YzdKUjVKN2RnSzFYWHFG?=
 =?utf-8?B?Y3pTbWhWQXlqSXNmaVRCbHJoWWpJVXdSZVEyc2EzRFBDZVFQazZYRi8rV2Nh?=
 =?utf-8?B?dGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f2d8604-1313-49cc-53a4-08db9225bb04
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7869.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2023 00:24:55.4541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KrLkril1YAyjrqc14wYOH4HWnoDDW9rWu1aW+yXQ8QuFPVUfW4Iu/ok1jSYactnKInVPeLLP90QxWnW1m3MHrYBcFYzjqXZTS+8kDpBE6ic=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6818
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 7/31/2023 5:13 PM, Jakub Kicinski wrote:
> On Mon, 31 Jul 2023 16:12:23 -0700 Nambiar, Amritha wrote:
>>> Every NAPI instance should be dumped as a separate object. We can
>>> implemented filtered dump to get NAPIs of a single netdev.
>>
>> Today, the 'do napi-get <ifindex>' will show all the NAPIs for a single
>> netdev:
>> Example: --do napi-get --json='{"ifindex": 6}'
>>
>> and the 'dump napi-get' will dump all the NAPIs for all the netdevs.
>> Example: netdev.yaml  --dump napi-get
>>
>> Are you suggesting that we also dump each NAPI instance individually,
>> 'do napi-get <ifindex> <NAPI_ID>'
>>
>> Example:
>> netdev.yaml  --do napi-get --json='{"ifindex": 6, "napi-id": 390}'
>>
>> [{'ifindex': 6},
>>    {'napi-info': [{'irq': 296,
>>                    'napi-id': 390,
>>                    'pid': 3475,
>>                    'rx-queues': [5],
>>                    'tx-queues': [5]}]}]
> 
> Dumps can be filtered, I'm saying:
> 
> $ netdev.yaml --dump napi-get --json='{"ifindex": 6}'
>                  ^^^^
> 
> [{'napi-id': 390, 'ifindex': 6, 'irq': 296, ...},
>   {'napi-id': 391, 'ifindex': 6, 'irq': 297, ...}]

I see. Okay. Looks like this needs to be supported for "dump dev-get 
ifindex" as well.


