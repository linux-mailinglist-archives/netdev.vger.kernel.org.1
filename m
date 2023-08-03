Return-Path: <netdev+bounces-23819-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6044E76DBE4
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 02:02:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EF731C21323
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 00:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 277B2847A;
	Thu,  3 Aug 2023 00:02:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1935B5C82
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 00:02:17 +0000 (UTC)
Received: from mgamail.intel.com (unknown [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C1A30D2
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 17:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691020936; x=1722556936;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=zU3kc2ji7W2zyV9AYX001Z+Xmc3fMTOfyMZSIuYSIIk=;
  b=jANymh1YRptZPeOkjCdbt+2MN18JhEepUikWQVewk5Z6EHK6wjlSe6QX
   rWD5CDQrPSD0USXLqVH+CShvu1gJSTMpmIt4qAglylkrdS1QhrTz/9o3d
   2WgeUmHfpgi2COd9zEaFl/TFbcD6j/uwL/PzxinMiVb0MzvzczVnz9DvT
   SuntFQBU48sZUXcvGPDuzMulFT+aHcg/bi/k4HZSStNzd+PFI3V2vv/xz
   f+hVI+7Bd2fcBBO2OONcHRc9Jbys7xfpmjYFstL5D79+lTPRabspRPjvB
   Aa9LLY3miASirNzEy+m+xR6R/WZjpsOl49AzXfgETAB7+C0NOGYB5vQix
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="373365162"
X-IronPort-AV: E=Sophos;i="6.01,250,1684825200"; 
   d="scan'208";a="373365162"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 17:01:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="872712751"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga001.fm.intel.com with ESMTP; 02 Aug 2023 17:01:54 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 2 Aug 2023 17:01:51 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 2 Aug 2023 17:01:51 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.176)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 2 Aug 2023 17:01:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N5PI1mkFSrJgvxhXaRhRMB5fImrndeS0mWbjH/Rv1uGAW4st/+LThtmU4+cxYAkR5EwhC6D5t6bn4JOrJJBeNpj5qKcZkkSD8MdslFH/s1jkoG6XqcASwfLJ/qwkLABdw66tW5UA8UCJ/xH5NymhIHgevhD5zZYFXKyzhObRhb9is33O/44uY37cTHBsuvDB07G5QdUAiuCNUvMFFttsYr5skZkNvEdl5JbDEoKdOByP6kkI2IKxaTxnERb0ChlXYHdn1qaDltRpfR8CmYGplwiQYS/VBBcZ6mEK2C/hQh63KxDiZY3IscAJR1pQEU9UQ3tFegfeDgT/P+PG2xTHuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O3K55Wsu/QIqWKwjMRjR43flG8evYzedyoR1VdcY0JI=;
 b=Kvf4kOUKRpkqsn4FjwBFwS14PtqAKMorVRLDHDqcMGKO/8Q6zoRx4mNkeFfQDfLu/189zx/al/nFQgunILucepA+ocQAPDXh8iuzTmDf3Z8v2pYIyyE3hlg3ci8KZ3eBJ1J80KcGPA8mRt97fomqvwvRLRy4hO3FAbsWKCw4iBZmlzywe7DfoMZM3XX7JomFHSkhVBAyaDR0kzbtnfSKhtV0mXkfyqAlLVY8xK/Igluiy8jvei3qBMkVqSMeUR6XBvfGEudKnYmvQKTvA6ybYkmIfFzATM+GLx/JH+c3W4dDqmwyBfXOQSbb2jD9gJ4BTvO68jb6hBWTrbLbJuOTpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4914.namprd11.prod.outlook.com (2603:10b6:303:90::24)
 by LV3PR11MB8579.namprd11.prod.outlook.com (2603:10b6:408:1b6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.47; Thu, 3 Aug
 2023 00:01:50 +0000
Received: from CO1PR11MB4914.namprd11.prod.outlook.com
 ([fe80::9c1c:5c49:de36:1cda]) by CO1PR11MB4914.namprd11.prod.outlook.com
 ([fe80::9c1c:5c49:de36:1cda%3]) with mapi id 15.20.6631.046; Thu, 3 Aug 2023
 00:01:49 +0000
Message-ID: <3148339d-cb12-368c-7d29-01ab39a9d879@intel.com>
Date: Wed, 2 Aug 2023 17:01:48 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH net-next] net: gemini: Do not check for 0 return after
 calling platform_get_irq()
Content-Language: en-US
To: Ruan Jinjie <ruanjinjie@huawei.com>, <ulli.kroll@googlemail.com>,
	<linus.walleij@linaro.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>,
	<linux-arm-kernel@lists.infradead.org>, <netdev@vger.kernel.org>
References: <20230802085216.659238-1-ruanjinjie@huawei.com>
From: Jesse Brandeburg <jesse.brandeburg@intel.com>
In-Reply-To: <20230802085216.659238-1-ruanjinjie@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P220CA0004.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::9) To CO1PR11MB4914.namprd11.prod.outlook.com
 (2603:10b6:303:90::24)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4914:EE_|LV3PR11MB8579:EE_
X-MS-Office365-Filtering-Correlation-Id: f672fcc2-fa32-4039-e7cb-08db93b4d60b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GNadvbY7qPETTDFz0nDTdJWIQSdZJAIYtVqXdHqjomCS7VqJd/lFav70K9uunKInik4Zg1zTwvnbA+1rTSjxJkZnCxvv7xcZUj7XW+LmcxRqQ8e/mnoCEvLnX9sWKAW0yoFwsxd7RfzvPkDQrLs3NcWWaIbnnHrhpgjL0G0q+ngD8Z5w4JO3DyQvNekTDttsBD9rzoJQ8MnMFXyeN+S/zwiguIONt62LpA7xePl8Qh2OvWb+4CFAJ8RblR0d9oXRFuccRIjXs2bFntd0+tpyR8uye0Fwp3uCdKzi4ZzZuN7t/EsGtb3Dda8D9Dj4J215a+pl8BHSE42eD7Nup7kW1j3dBmVc2jyVoaWObEicL1IPXSI2j9ufcJe8Ama+lNIQgG7k+XgGMNzaQjJtjLYZqfk/cxWtkMLwUnvi6SX64uGhJeUc6tHgDHAaQuakh3hwnJITUE+ghd35IQMLGcRRK14aTvZmX2jHKqXCGzu1MCiBt8u3fad15rMpOoGKswByx+cukisnq511q5RHUFbjg38A2iM9DE7ZDXyQTf+TJatqhDbVgyvEyI2wijy3MtNycmwx7VWSssCHAUCf++gN1MjMHKj3+rZFX/D5BVoAmoyGwcCqPoFj+CLL+C2sk67O3m7t1GHki/jvxWTdLfWJLA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4914.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(346002)(366004)(396003)(136003)(451199021)(2616005)(53546011)(6506007)(26005)(186003)(4744005)(316002)(2906002)(66946007)(66476007)(66556008)(5660300002)(44832011)(41300700001)(8676002)(8936002)(6486002)(6512007)(478600001)(38100700002)(82960400001)(36756003)(31696002)(86362001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0d3Tzc4THdHS0V6TXNDY211VjYzRTUxK2s3Vm1zVTJQZHhqeC9HUVZKejlj?=
 =?utf-8?B?aFZZWlZRN1ZQbEFTUUs3VVBnN2Y2bmNRYmtSRnFJdEplelBHMTNtaFhwVDNh?=
 =?utf-8?B?SGlFMUtKVGpvVzF6L2hiYTRyU0c1TXlqb1RuWFZqV2JjQ1BZbm9WbkZoUncr?=
 =?utf-8?B?MzNyNFRvc0pvbklXRGY4emlWaU5oeWRUQ0l5KzFRbkNiVTRCb0xNRWJNTmVo?=
 =?utf-8?B?dTRrYkhXVGZucUFibkY0bXVzZTlkQUVDZjhFSGNzNE1XMGlJZWlibms1OTFu?=
 =?utf-8?B?NkU4QVRWOFhWemtnaHFVMFhRTGZ3Z1BXbmlRWWdPQVZSaWdWYXl1MVdhQzRB?=
 =?utf-8?B?V0tnb3Z2bGlxaFRVQXArc3dJaUo0RlE5VWVJRVdvNVlHRy9PdWIrZ0xjUDZl?=
 =?utf-8?B?WndtRUVJL3JHSitRRkNkZHp5SGhQeGhJczRQK2ZGOThqU0lxelIzKzRJM0VO?=
 =?utf-8?B?RDM2Q0dmSnJFenppNUdyS21NV3pUdThhYTBwNnIxbjRqbHd5WVZ3Qlp1Rkdj?=
 =?utf-8?B?azFZTk1vd2ovQ2JGT2ZOelV1bG41Zm4yWjBRTWxtcDBsa2pkclJMT3h0MTEz?=
 =?utf-8?B?cGxkUkRIRWNHVFRXcmpBRFkvRVdvTmN4WFhuRDkzaTZOVk0yN1J2QmJTOGdU?=
 =?utf-8?B?aEpOTk5vcEp5TmI0VU40M2syQXN1M1FaY1c2bWFkLytVS1JRTEFJRWVOSmR5?=
 =?utf-8?B?SktSeE5YUUhoRmNzWUhhSHprRWUrU0J4dWRWZUR5OFBrRUNWM0J2aGl6RmxO?=
 =?utf-8?B?dzZPUUhMamJyUGczWmpoV0tYRVlnZ2VRODFvOUhubERnd3QvU1lnVEdQQThj?=
 =?utf-8?B?QmxmVVZtVFJOTE80UnFIdEJTYlFyQ1dyTGpyTDdXN3J2M1RZNDc3MVlmcmJZ?=
 =?utf-8?B?WDBaTGRadUlqTkRocDd1alVQeURQNlRUNkh2ZndnNjU4bmhRTlFITHFZZXAr?=
 =?utf-8?B?YUEvMUV4a3RkTzBjU2FLN2ZKRTNQZGpCSmltUGs4L3o4UmwyK0l4aFQ4czI1?=
 =?utf-8?B?cThYdmdjRnVhREtnTnMxVjlBL1BXRkFWNUJiWE9DVG1acUN3MkJtTnBQWGVY?=
 =?utf-8?B?WnFNMEVDTkpOK1JRVjJ2NDN3MHZucS81VEl3a2dxeFFmOTl5a2phZGhMQXZX?=
 =?utf-8?B?cDI1ZHJQcEdCTDJab1FPZFo0WFdFUjJGL1lBYVVXOU0zelR2S3pWNTRjdU9R?=
 =?utf-8?B?ZW5vbjJYSjNqelI3eUFLRkxvN3Z6OGJqT3Rjb3pDbFJXOEtxS2lIRExuTTAz?=
 =?utf-8?B?RFJ0ZGRhK3crWldnM0JjdUJSN0ZQZHA2UG82blV3MENMY3VHWENCZzVRVTFu?=
 =?utf-8?B?TkxyQXJsYzNEZE9zYnpnWFRkbnFSN1o0TmxpaDVDblByZFpCRktjWTVDUmlN?=
 =?utf-8?B?bTZRLzhoQ1d6RlJtVVpNcWEvZklrT0htdjZrbHl6cXJUMDlmd0ZTT2NjdlRj?=
 =?utf-8?B?RFA3Y2p5L2RXYzNJTnZsZHZBTG0yTTM4aTdrQkxZOS9IMXprQ2tkRlRvU0wv?=
 =?utf-8?B?N0dTWGdBZ1lZRjdOazYyU0VKTmZCZC9PMGh4a3llQUlGdis1Um05eEpLVTBi?=
 =?utf-8?B?YkQ3Zk5WMjdtVk1zektjeWhnQ1BGV25OR1NHdmVveU00TndwTXlrZGhOT0Y0?=
 =?utf-8?B?bWFBQmRLcVc0SHlKVTh1Z1BXK2xCZE00UURGSWt0YkdYUCs3MWxOaDBOQ0c3?=
 =?utf-8?B?U3ZrcFRMRkYrZnFDcEZIalIvWURzTXBqQmdUbzRma3BpZXRsd0MxTnpiODRz?=
 =?utf-8?B?VFhpSUtkaVZEVEc2NEdoMy8vNm1wTmNNQVlxcjQ1WUdqblR0aFdDQno2d0JF?=
 =?utf-8?B?bXkrOC9RMmwvelgwNnpjNTFSa0ZlbzhqODJ0K3ZEc0NyaVhlbjJSOXJ4bTB5?=
 =?utf-8?B?RCtaejNIT1h3dFBzekRUWmRWaWN6OWpMQnVQUVg0cjExbU1OOW5xVWw2bDMz?=
 =?utf-8?B?azExY2I1U21sREw4ckVNaHdaZ0gxQm1qaC81NHlUcklsMFZQUCt6N3ZLTkI5?=
 =?utf-8?B?eWZMRVBNaEZ3T0NEc2RGOXFYQlcrNlp5TFRlVU05S3VyakJIT3VkclRoU25R?=
 =?utf-8?B?ZlpDYVlvL3QyL3IxSjZTZEVIYTZocHZSMVlWeEF0UmkreC9CZk1QQXlpSGlI?=
 =?utf-8?B?VnU3QnlJelJVdC8xbkVKOVNzVyt3RUo4cDJvZGhtejNLSFBJUTAyTGprazEv?=
 =?utf-8?B?T0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f672fcc2-fa32-4039-e7cb-08db93b4d60b
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4914.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 00:01:49.8858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /6u8aaDBLulijtcLKv5Uhrrr9lWbwXVmLHZK7AMxD//C7mJCLzhNdovU/keVQ/ycEXkNz/Greivx+kcR3W5cFJZp58EP6vZ6iAkVrQh5ACs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8579
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/2/2023 1:52 AM, Ruan Jinjie wrote:
> It is not possible for platform_get_irq() to return 0. Use the
> return value from platform_get_irq().
> 
> Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>

These would likely have been better sent as a series (with the right
maintainers added to each patch) instead of 1 by 1 patches for all the
changes with platform_get_irq() code.

Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>






