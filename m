Return-Path: <netdev+bounces-27531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD8A77C499
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 02:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13655281307
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 00:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D099615A9;
	Tue, 15 Aug 2023 00:45:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9FD15A7
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 00:45:20 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14F7A1723;
	Mon, 14 Aug 2023 17:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692060319; x=1723596319;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=JZoW7kCHphL0TBioJxUPDQJ/fRkoRlhVtUvl983FG+I=;
  b=NFdAXKmZ89bUo4kaRRa1AHOI6pz5+Uvd6v5OByQsqogwVIUTqq1QoOMd
   ClNttm0S+iX8w0VHvtd26SKycE5sccEl0w/pqkNWHPiTUjGbC01tmVH+7
   lDwmkeGbvlML/AwdLbvwQ1T2gpd8sfMBLZUd2BSoV/dmXiO1xvb44UzTP
   B6OllmB+2cZo8LvlVXJ9wH2znSDQeeRAvgmmQnoBIpPNue3ezUHg9cZ9d
   b5yke1KuxOvpwpvdCp6Jz9uVaIFOfrbMw/ka8kLW0Io7sLdQ6JOOeDD3L
   LN8pCandR+b/NK0b2zMkChSIM5LyoPJvU2Km41gliDflvtZSsJiwPrbW/
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="438511416"
X-IronPort-AV: E=Sophos;i="6.01,173,1684825200"; 
   d="scan'208";a="438511416"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 17:45:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="877160168"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP; 14 Aug 2023 17:45:22 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 14 Aug 2023 17:45:18 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 14 Aug 2023 17:45:17 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 14 Aug 2023 17:45:17 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 14 Aug 2023 17:45:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bluNwsH2OhR7Wgd7tar/NfZgdmo76Aq+6t99Ghicaj+hNNtXmdEbqDZBV6PqFCMXJJlwJCqyXRygfQenzYxVFYjfCFZc0F2hl4uEj7S/yg2VplTqU/Ep4GFcw25V9Lqybmolv5qM7tX4pf8wB9LWZcq28wSQVwep5wnoT3aMbm/LRKLgzQPUmB/iEtGQfQQk35SaphEVgGNrFxY6OOsviVlmkp0IQUGtZ7yT/EadXUrDWo2pstAIoGIskpescwMPoWj29GijSFPTFDVsJoiEL8eO/6pOogYxeagdIXJCvLEZLgqItC1C6nf83s5htEEgq/3m80elhhm54FEeL1wx7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lxKdyju3TejQFMqYJEEFrlSS66Enz4ch2rXDCFaccig=;
 b=K9kAmKf3CsL2x7v+Pqy8g0O1Y1ee3ax7mhuJ2JMsV2lDwMqJ8umhk9LRP+OgJJ627CilEWWUjNAWjOK0I8Mr1V0gwolEZkWLvTn9vEDxNxoG9lEO9kxbppX3M/YDrrBMFXMY25MzsbTw3u0i1oKWt8qDwEVcc2Z59NOuL48Va5/fziYxNUwo4MPHw7O0s5fmJnVZ9NPnHFRQvEN7Nrf9MMJFTVyRl2Gqxl2DgMdbVP3j4WbzizBQdigkFeiQoZ3+nwu8St5GjoaYGLyUbDa+b5O+YSmuwXeUvr43NChylvket+T1uxTePKFKJfWXQgSnZ4ZHpOSRrdP96yKVn+RZVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN7PR11MB2593.namprd11.prod.outlook.com (2603:10b6:406:ab::27)
 by DM8PR11MB5606.namprd11.prod.outlook.com (2603:10b6:8:3c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 00:45:15 +0000
Received: from BN7PR11MB2593.namprd11.prod.outlook.com
 ([fe80::f195:972c:b2bd:e542]) by BN7PR11MB2593.namprd11.prod.outlook.com
 ([fe80::f195:972c:b2bd:e542%5]) with mapi id 15.20.6652.026; Tue, 15 Aug 2023
 00:45:15 +0000
Message-ID: <d2e07a0a-8b5c-b7ba-686e-d206800fc9c3@intel.com>
Date: Mon, 14 Aug 2023 17:45:11 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [PATCH net-next v2 2/2] scripts: kernel-doc: fix macro handling
 in enums
Content-Language: en-US
To: Jonathan Corbet <corbet@lwn.net>, <netdev@vger.kernel.org>,
	<kuba@kernel.org>
CC: <linux-doc@vger.kernel.org>, <emil.s.tantilov@intel.com>,
	<joshua.a.hay@intel.com>, <sridhar.samudrala@intel.com>,
	<alan.brady@intel.com>, <madhu.chittim@intel.com>,
	<jesse.brandeburg@intel.com>, <anthony.l.nguyen@intel.com>,
	<willemb@google.com>, <decot@google.com>, <rdunlap@infradead.org>
References: <20230814170720.46229-1-pavan.kumar.linga@intel.com>
 <20230814170720.46229-3-pavan.kumar.linga@intel.com>
 <87ttt1v4a0.fsf@meer.lwn.net>
From: "Linga, Pavan Kumar" <pavan.kumar.linga@intel.com>
In-Reply-To: <87ttt1v4a0.fsf@meer.lwn.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P221CA0013.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::18) To BN7PR11MB2593.namprd11.prod.outlook.com
 (2603:10b6:406:ab::27)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PR11MB2593:EE_|DM8PR11MB5606:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c90c6c9-6365-4974-db00-08db9d28e41f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TBenfGrCHPJAsv0LWJnq47T+lkWlA5JpHtZnkAfYy7ZOc1E2Ve4Ee8jtD3sjrNCQUWxsHHt9aYkhXnpmoO7WrMyuWNsad59Kjzu1AaQDrDD/mQwcyoWFJUEHC7RAg+QIKvO+Td/reG9H/IHwwZoFu9hPUjUZCztwdnuvLhY7NyWdBLYrYfoLnH2JAnqavT1yxfgHc3jEEGf6eA77IjVl5nbF5KHf1vD4eyAbl+QzhPKbIMg1LsiD0KodI5mLeNERwSV5jz/K1zanROcwMP20xnHKi60YmAnD6rRLioWhEH6gsqsBeBkMlO1UtV6WTe7/dopzdj+n9f01Z+rhw6T8XLqUlNXq7EmApC+oSYikIDHzdR50yY0XlVKFyvmr9M4ji7qRoFHoiwbPniHXOOksp9IPOlrPkibTeB02ClzEkfadF/x4N9n5/U0uZV6Jor4KiJ/BMZUtaExwA5WQw2q3uOpn2weJ+t0sPn4whq7jtYxbqqo29LX6BZHnMLkFJ07nJyGf9IHDGMXxS3+AEPD4eNJ5bBgC9mR97o4cs86vdFjZ9ouhElJYU1umGdoz5is23H1YA4PZMqBcm2U34DkwKMjcETxwAd6FwZHv8YyfqaeCI0LlTTpexwwvbBDwc/a8EMMIniNvHGLY4MfRchytRw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR11MB2593.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(346002)(136003)(396003)(376002)(451199021)(1800799006)(186006)(6666004)(38100700002)(6486002)(478600001)(82960400001)(2906002)(5660300002)(36756003)(86362001)(31696002)(4326008)(66476007)(66556008)(66946007)(41300700001)(8936002)(8676002)(316002)(6506007)(53546011)(26005)(2616005)(83380400001)(31686004)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YTcxdU16YnBHQkZtKzJKcGVFV1NZbDB2RFdkMlFRVFFzRlo1eUZ2TUFzbHRs?=
 =?utf-8?B?emE0WVRhQUVreTFiUkRnbjREcEczOE9XdWpHRkpoVDJPSUNGZjhQRnBvS1BC?=
 =?utf-8?B?ZUZVU096VE5yRjQ0T3RkazdKRFV2SmNWSnRJSGZZZ21kMFFOQ1lWNWFobTVW?=
 =?utf-8?B?cG9PSDFaNDlta3JBVVc4Vi9MKzgrNE5GQUFPTVFIa2ViNUh4T21mY1NzcEVt?=
 =?utf-8?B?MHA2bm42bFVER0F6dTRuOUNwWkhHQ3NNYm1JaUtqRWpVVmh5OTREWVowaFdU?=
 =?utf-8?B?RDIxdE1iem0yU2FEM1p3Y04wYmZPbVZyNUYzVWZEVUJnaWVWTzRsS1d1ZThI?=
 =?utf-8?B?S0JkYU4wd3ZGNkM5UDNSbE5WdVRFUFlTdmZ1UnBXWXAybktZV1p0VDR0a0hF?=
 =?utf-8?B?Z2Nqd0lGUjF5eml1OVRhbkhkVVdIY0c4b3FNUmIvcER0Q1g2Wmd6Ym5LYit6?=
 =?utf-8?B?YkVBNGJKZmtmckphYjdyL204cHBTcFFUaEN1cFh3bGQ4cE51SGZXTThOVTVQ?=
 =?utf-8?B?TXRaMzhzaFFOTlhmVnQ3YjR1V2hzalYxcjhPK3J0Tk5GeFAxVEQ2THdzVDY4?=
 =?utf-8?B?R3ZpcG8yeWVYOGRUMHlGMHlNNU5jR2xjYVVENDhBU3Myamh0bTVKQmJlVk9F?=
 =?utf-8?B?UmVzTURkRkMxZzRpV2NJbndZVUhpbjRlRDRaVm1uakRFK1ozdmExSjR0Rm8z?=
 =?utf-8?B?aG52VUlkWHNPTGpwY29KaFJaTi9sU2sxRWlJTFhSdVFLMnRMSlFHZWp0T2lp?=
 =?utf-8?B?cWhNNjBYNjlzd1Y4anNlUGdrYnZIT1MvT2YxbXBSU1FCV0g4T1hibVZ6VHpB?=
 =?utf-8?B?QkdPVEJqZEJHRHFSL2ptVUlQOWFzUk9vWFZnL0cwNG5DVU9jMkY3RTBxY214?=
 =?utf-8?B?WkRyWHR2ZHVZUzNUM20yL29IeHptTVdQckJ0VTFaSnJuNjhwSjBBRCtEdTRF?=
 =?utf-8?B?SFNwZVpaa1o1b1N3RlVTNk9lNHphZXp6NTdRWFM2M0xxRHpyeC9KRmt0a1JE?=
 =?utf-8?B?aFhmUklHQS95UzVqU09aQWxsUGl3ekxzSHRZZ3hxY0lyUyt5VUFqZnJXQWlw?=
 =?utf-8?B?eUs1dDZUMWFmdTRQOVJhNC96ZGhpeXJoZUlFUjFrQVFGOGdSTjVscUgvdGI5?=
 =?utf-8?B?d1ErNGdLbjZrYmwvaFFEL2srQzEva3FkWGVSTzFqNWhMNmIzS212Q0VzQmZj?=
 =?utf-8?B?Zy80V1ZLRXFMWkg2NEtoRklyZ0hSTjJLejlYdGV2MVlaV1JOWThXbm5jU2lH?=
 =?utf-8?B?ajFhemNQK3FMMWc3SG5MMDZkdm04S29qVWdJRjgzSHhDNkdKTmsva1V2REhr?=
 =?utf-8?B?dDNIa0FFVEhMWjYyNnEwSlV1Q2RzQUdyRDBpQzM5S0JBbHVwN0JHUGgxRVBT?=
 =?utf-8?B?NXBkNm1RcUpuVjMzMityZ3FxVHVuTkcrRXhBMVVKK0sxeXNzN05xTUVnOVFa?=
 =?utf-8?B?MUdBdWtBWlR4UStFVC9PYlJrbGgvMHBPOHY1cklCbDRJQzA4NjB3SVg5a1Fq?=
 =?utf-8?B?aWovb2s3dzhjV3Z1ZFlBMlRkZmFKb0czQ240bjlYaVZVR3oxeVBSSEFvRkpI?=
 =?utf-8?B?a3lNU3IwUkRVVjIzUFNjQUtwdVRjWHNnYS9RU1FncVp6OHlFME40VWJ6QUhh?=
 =?utf-8?B?L21WV2hveEpjTUN2OEhZclpaSjljdk42Q2d3aWVLZUV3UEljY05TSjRrY0tL?=
 =?utf-8?B?TThtTzRNK1B6UUpvRFc5SlN1emZmTFE3U0x6TW9MYmU3UmVvMG8xYVljS0V6?=
 =?utf-8?B?ZUVZUFRhZDRGbUNSNE10WjdKbmRWZUt5a2JSUnJOMU1NVnF4RXh2dUdkRFVr?=
 =?utf-8?B?R0lleUhxTEdieU9UZWFyY05vekdrZTBQUDdCeDExR0RVV1ZHNkRrRlE4ZUJo?=
 =?utf-8?B?QTZrdTZrYmd0bnhTSTVRK2hSNlFrelNKNkZaRjN6a1BoVHZOc1pFMlRyYnVz?=
 =?utf-8?B?NEN4U29VWG1PMVhRek5LY3VLejdmOTdCUEd4NFpHblJCdkdSRktMcEQ5MDMz?=
 =?utf-8?B?T1VYK0FyUkNmOFR0ZWdzTHAzaCtuV1VNa1g5L0hFWjZHSTlBc2toNjhrUG9O?=
 =?utf-8?B?REp5QitRdDVFSDJDcTJwdmJqclZRRG8ydzJMOE8vR2ZhOGRkN3phWDlVcTZS?=
 =?utf-8?B?MGtYWndVSFJGb0JRL29RaW1OMVdaYWRaMmRMTzZCT3NCSmhPdHhRL3R2ai93?=
 =?utf-8?B?NXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c90c6c9-6365-4974-db00-08db9d28e41f
X-MS-Exchange-CrossTenant-AuthSource: BN7PR11MB2593.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 00:45:15.7090
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cKvWF4jiEOOFsOJR+2u+9Cogoqmwh76/o0Wu266JAYlLE4TiLJoceTWPwSkG0YVxfbUSALAilYwNCLpZP8HniZ0WIesp3QZydISb5eMOmw8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5606
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 8/14/2023 11:59 AM, Jonathan Corbet wrote:
> Pavan Kumar Linga <pavan.kumar.linga@intel.com> writes:
> 
>> drivers/net/ethernet/intel/idpf/idpf.h uses offsetof to
>> initialize the enum enumerators:
>>
>> enum {
>> 	IDPF_BASE_CAPS = -1,
>> 	IDPF_CSUM_CAPS = offsetof(struct virtchnl2_get_capabilities,
>> 				  csum_caps),
>> 	IDPF_SEG_CAPS = offsetof(struct virtchnl2_get_capabilities,
>> 				 seg_caps),
>> 	IDPF_RSS_CAPS = offsetof(struct virtchnl2_get_capabilities,
>> 				 rss_caps),
>> 	IDPF_HSPLIT_CAPS = offsetof(struct virtchnl2_get_capabilities,
>> 				    hsplit_caps),
>> 	IDPF_RSC_CAPS = offsetof(struct virtchnl2_get_capabilities,
>> 				 rsc_caps),
>> 	IDPF_OTHER_CAPS = offsetof(struct virtchnl2_get_capabilities,
>> 				   other_caps),
>> };
>>
>> kernel-doc parses the above enumerator with a ',' inside the
>> macro and treats 'csum_caps', 'seg_caps' etc. also as enumerators
>> resulting in the warnings:
>>
>> drivers/net/ethernet/intel/idpf/idpf.h:130: warning: Enum value
>> 'csum_caps' not described in enum 'idpf_cap_field'
>> drivers/net/ethernet/intel/idpf/idpf.h:130: warning: Enum value
>> 'seg_caps' not described in enum 'idpf_cap_field'
>> drivers/net/ethernet/intel/idpf/idpf.h:130: warning: Enum value
>> 'rss_caps' not described in enum 'idpf_cap_field'
>> drivers/net/ethernet/intel/idpf/idpf.h:130: warning: Enum value
>> 'hsplit_caps' not described in enum 'idpf_cap_field'
>> drivers/net/ethernet/intel/idpf/idpf.h:130: warning: Enum value
>> 'rsc_caps' not described in enum 'idpf_cap_field'
>> drivers/net/ethernet/intel/idpf/idpf.h:130: warning: Enum value
>> 'other_caps' not described in enum 'idpf_cap_field'
>>
>> Fix it by removing the macro arguments within the parentheses.
>>
>> Signed-off-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
>> ---
>>   scripts/kernel-doc | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/scripts/kernel-doc b/scripts/kernel-doc
>> index cfb1cb223508..bc008f30f3c9 100755
>> --- a/scripts/kernel-doc
>> +++ b/scripts/kernel-doc
>> @@ -1353,6 +1353,7 @@ sub dump_enum($$) {
>>   	my %_members;
>>   
>>   	$members =~ s/\s+$//;
>> +	$members =~ s/\(.*?[\)]//g;
> 
> ".*" matches the empty string, so * think the "?" is unnecessary.
> 

As suggested, tried without "?" in the below updated regex and it 
doesn't parse right. It substitutes everything from the 1st "(" to the 
last ")" with empty string whereas using "?" substitutes each "( )" with 
empty string.

> I do worry that this regex could match more than expected, disappearing
> everything up to a final parenthesis.  It doesn't cause any changes in
> the current docs build, but still ... How do you feel about replacing
> ".*" with "[^;]*" ?
>

Thanks for the suggestion and that works for me. After the update, the 
regex would look like:

"$members =~ s/\([^;]*?[\)]//g;"

Will update this in the next revision.

> Thanks,
> 
> jon

Regards,
Pavan

