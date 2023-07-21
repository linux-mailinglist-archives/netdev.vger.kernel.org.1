Return-Path: <netdev+bounces-19904-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AAD075CC71
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 17:49:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 972252822CA
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 15:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F5A1ED24;
	Fri, 21 Jul 2023 15:49:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A211ED22
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 15:49:41 +0000 (UTC)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD830E6F
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 08:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689954577; x=1721490577;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KhbJ2lACso3maKXBFQmgGIlU28jYC4M9wG/5Q9RBC18=;
  b=lYrA9gpcI6x7CDfgJ7Rj9LVipGdlYA2t8Qmh7SadarFoc4ZN9T58JRSB
   qRGEcr+lrnuF3QXyGI9vB7PqIjZf7sUoxGaLWikdd82/lHFrLr6/x5KOx
   UDUfkQYm5r+zio2C+Psgi98vmvPnbfbfNuo5edOIznUFO4WKG1PMPk1kg
   s1nY85g7B9gcKPlmySi7ua/BEE/8FWR9AgSm2H9Q1TsufN2vF0OxTQ+7f
   wSzJiJhQ727eX1I4BjUfeAbCAGK9hkRkxilG5VV7cGtntV8PdHnwKJoCF
   wY8+ce0gTZbUnnZnolmjh3EvoDW6yX15a5ImSU5GPaIvhi8yHkyFRfxcJ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="369722717"
X-IronPort-AV: E=Sophos;i="6.01,222,1684825200"; 
   d="scan'208";a="369722717"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 08:49:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="1055597445"
X-IronPort-AV: E=Sophos;i="6.01,222,1684825200"; 
   d="scan'208";a="1055597445"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga005.fm.intel.com with ESMTP; 21 Jul 2023 08:49:37 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 21 Jul 2023 08:49:36 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 21 Jul 2023 08:49:36 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 21 Jul 2023 08:49:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SKcYcN0YOFOx0V3QBXJa5q9sqK06RGB+7bNsfAzOE31xpIcpswjo4dEPL4aiD71rmTBweZCEOwbL/mfYcWa/fOxIkQTB0zL7kq/d6FSbcWl2JYt9nCv45O5+QIgCpdBH6Rvf2FQGqwx2d7BZ62eofdE60IAyVSwmuFQCaCCm78FTCCZ2h8xvQBUM/c3R6VQsk+LVtS+A8jkmN61jdyazkzb4ShMdLZUyRciEMBfOhR3EkT6ZTyAJU3RoM7TeDhy+ROXEsqfI3XbqnBAf9MrAK59bUbI7NAOxdjhcx+ciMgUmZlXjLQ8ZG5Ozx0O4HnMgYlZgAqqAAX4ia7NKNta5xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=szSuOzEJCRrOCsB9pY9EbcRs1GtTEsuaOOvXabqXs/o=;
 b=FcX4Cr40jpfBRKLTl3Fowg2ZMWSBPRouH7YxDmeATW8dsC5DrrUe+UCYWMFjdwdb05ME4SJf6BnLRp0tyT6MuyyCodG0qJDQR9bFlgsCxHgDT7TmCYctQQrjSWSvagXFGYjn/3xg+ap1OCMOeu2roNAcSflyIgDytgUi5l+vXrVnzFyUnNRMEmkqX8+ZJuDu5J+wIEC5Ri7k935M43JHbjwzXEhc367HK3FCNIaBmRlGmTqwTVFL8qHz+Ko5S3JPRLbWRIFJOF704AFS6QmJus5pHO4RkPqRlQocVwcMfUI9UCjBvKY4Dd27MktUhEXtuZJSquF+wpFq4WhhzJilTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by IA1PR11MB7753.namprd11.prod.outlook.com (2603:10b6:208:421::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28; Fri, 21 Jul
 2023 15:49:34 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a%7]) with mapi id 15.20.6609.026; Fri, 21 Jul 2023
 15:49:34 +0000
Message-ID: <4abeeded-536e-be28-5409-8ad502674217@intel.com>
Date: Fri, 21 Jul 2023 17:48:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH net-next] page_pool: add a lockdep check for recycling in
 hardirq
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <peterz@infradead.org>, <mingo@redhat.com>,
	<will@kernel.org>, <longman@redhat.com>, <boqun.feng@gmail.com>,
	<hawk@kernel.org>, <ilias.apalodimas@linaro.org>
References: <20230720173752.2038136-1-kuba@kernel.org>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20230720173752.2038136-1-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0229.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b2::14) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|IA1PR11MB7753:EE_
X-MS-Office365-Filtering-Correlation-Id: dfa7d6ec-ad00-442c-c768-08db8a021431
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ++uafdcTBL7vK2VxZAzbC6e8lhnYT8rr7qAgWrre5H507MYa3ZipBB2zPQYFRO5zGpzcdJyjPZrrC2iow+fcchWsRY1Lk/UmoQXLYU5tIvrlgm1k2/UFaX0Z+2r6PZrxIlNP8LngLc98vt/+MuMYfCq+kkz3gi42DX6A8g9weh+FhRfnlqTzEcMDiTApMQqhg+8hDdmIbAN0QWviuqsIA289FRMebZ0qItWS1+mPECk26sPnpDucLQir0K5BMgFWMsPwvFKhEvZiFdwnxpJXSMV2ogMKAOD84FP9JkwvUdSTKXMXASPIEj2QNaQSXNnLKGJD8lvfNkChZhKQgPoGL7YOHZd3PHqOVYsx2fBcl0JIJKxhVop7wgU7ZHmv/89ewngET8BqR2fB3breHBQrcZ3hQImPcDf3jvIb4ItbYDOyl0DLtDd7NQq0/zlkFveafF0HsJRX7bap5peQH0ZweXSwJulpCKI8AY50ypYTY4XMy2TmhXzKd6dB5iENdsQ6UcZU5zS/PE64NYoprHybCzHKbt0ExFyTdEgqMt4IMrvxwXgG4NLRdTouippCqs9mSeFFiHYmWyHNlsK+iVAUkJnTA+3bm8FvmKlF43ATyIqwyxHlssici39oylqbmZT1RGqoGE9WNCL2rW0tZSehCg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(396003)(346002)(39860400002)(366004)(136003)(451199021)(316002)(6916009)(4326008)(66946007)(66556008)(66476007)(38100700002)(6512007)(6666004)(6486002)(31696002)(86362001)(478600001)(2906002)(82960400001)(36756003)(41300700001)(2616005)(31686004)(5660300002)(8936002)(8676002)(7416002)(186003)(6506007)(26005)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVk3VkI2WkdvSTlvS0NsRnZXWkVudHFLRkhZQXFrbkVQTVZGT0YwdDFhWVpl?=
 =?utf-8?B?ZCtqZ0dJOXZDSk9tU28zN2hxckZueCtEVU1VRFNKZklRWEFPRlpzbjM2K3hk?=
 =?utf-8?B?NHBrZnk1SmN2dVBrSUhNRDBZSVFxdXVrcWVxeXJUVkNJVzhaa1ZnSDFOTTYx?=
 =?utf-8?B?MDBUcUlrclpiengyVE01RlhxTkZVTnc1cDN3M3pnTjlaVC91ZjQ0bis5YjZT?=
 =?utf-8?B?Tyt6YWxhZ0lCaUFaRUdxRE9WNG5SMmI0QlpST0dmZU9WSTVMYTdVZkJsZUNX?=
 =?utf-8?B?NSs0K0VXajRTdVZXbUFPZm5GVDVnaHhSbXd1VUpqVWFTUEQ1ZjA2WnJjSzNv?=
 =?utf-8?B?VElscmp6MTN6Q1FLK1pVRngvOXRrbElHR3ZGaHVyNmZ1UGZPWVoyL0xkVVJN?=
 =?utf-8?B?QVlrdktYTFVzK0NWVFRNMkV0WmkvZjZpenJpV3d6elBTUkNhS0xKM0VCWlVO?=
 =?utf-8?B?MGEyY0lta3ZCVWtBMDFzdGpIZHJkR05CSldIZDFUbjJtWXVCTkgySW92amFh?=
 =?utf-8?B?Tmxzc3NSWk5HRUlsZUt0YnNQaWJTT2lrUm5xZGcyZ1g0ckNVZWVGeThGK0xJ?=
 =?utf-8?B?Q3QvaTlpRDVSWnRwVk8yZjluZ1FEakFSeUpjdHNXWmIwUEFwemVMMFZHV1ly?=
 =?utf-8?B?Y2pjdTQxUzhMZXYvWDlGTUVkd213blc1SWh2YmlHZlhKMnRXdjliMytLNU9o?=
 =?utf-8?B?eHljZHpmQU52SlF4T1I0bzRFSEh5V0pxS0RrZVF4Q1k5cVg1YWhPUURkU3Nx?=
 =?utf-8?B?d3N0c3ZMQkhMamlzUjNmNjZ1MGp5R25nQ044ZDdWZUl0dVhQL3E4STFTaVd6?=
 =?utf-8?B?d3UySCtVNldOdHppWnpoSnhQU3FTdFgrNmNSOEZxTDM2bnFnUGJJQm5KbnVa?=
 =?utf-8?B?V3V4QS9yUXEwaUJPaTYvaFAycG95UWFaUysvUXR0NmFhMXFHdEZtdk8xbjBo?=
 =?utf-8?B?N1Y0NTVRLzArZnQwZ0lmaERUanV4cDBOczBPVUQwVTBRdVUzUzZxQWM5ckRa?=
 =?utf-8?B?bi9hU2NPSEs4U1BuMkhXbmRQM3pkYjdPclpEeVN4WGJPUGhwTWM2bUI3ZEpS?=
 =?utf-8?B?Tk9vK1oxUm1wZ201V1JQYXBhdjBpUzNGSCtKK1ZkNzhBckFOQ2llUnJYQWZG?=
 =?utf-8?B?bEEwYzNKVElxNVloYWNuZGlFL0sxTlJqYW5ML05UYkl0OUEwNnBZVEd4RStj?=
 =?utf-8?B?M1c4Z2lZbXBmMXR6OXp3OEQ5SzBRVkRYUWxyVXY3TXNDVHFuSjZ0TEdteDgr?=
 =?utf-8?B?ODRpMVFveVRhelo0WmpGaWRjWW14Y01nWTJWSlBkQkZHNE0xQ3pvRThwRnN0?=
 =?utf-8?B?MGh0cGdnaGE0SGdKcFYrOFB5V1dPNnpDKzYzMnBORThjMVRzY1NxYnlQSmQr?=
 =?utf-8?B?YjF5SWU2ZkN1N2tNL0EzUE5iR1Q2L2YvVHA5UUIxV0d1SmlBbmU1UU9iYjZV?=
 =?utf-8?B?emI2UXVVYU9BMStsaGNlNGlHaFRCV1lmL0I2cEZpZ0JVUGwwSkR0Rjl1REFF?=
 =?utf-8?B?SFRuT2ZJZ2tTS0F2NGIyVlFUV0NZbndtZzdKOHlBeE5zUXZNbXVaWTR2djJZ?=
 =?utf-8?B?TTFYTUJCY3RPaHVRMEpqTmFyMVptOFVnMWJtMmJ1NUZkUTJ0TzN3bVVpNUgy?=
 =?utf-8?B?aTByeUVnc1dDY1RtQm80aDY2UFNaMHEzYUJsalVaQ3hhSnQxTytzUkhFdHlO?=
 =?utf-8?B?TTBiK0o3dTdHK1pPYnNNR0cwT1pYOEE3N283WmlHeFNNNWdHaFdTaGlLT2Q5?=
 =?utf-8?B?enNSamVzNkZSbGpwNEhwRGo5Y2QzUE1iY3A1NDFTTkpPYTRvUVJWS2tvL2tS?=
 =?utf-8?B?QlVYOHpXakFNQ2ZycG45eFlLajQ3N21oTmg4NkFqTGtQYlQ5MG1EQVR5NTJS?=
 =?utf-8?B?YitkY0RWRTBucTByb0pSbnMzYVI1THd6Sm13N0ZEblZmSC9WRG9KQTZKMjlV?=
 =?utf-8?B?eUdHb3FkOG42b0llZjdMTHBNTWpLd25zV2N4VGZjam50ekJmNGpsYzRCWXZ1?=
 =?utf-8?B?NWx2OStDRlBDM3JVZ0dPZ1BTYUFXSTU0UVRvV3Y0Um9nUHJMRkJiWXFjNzZN?=
 =?utf-8?B?UGV5VzFFRVJnMWFlWEl0emZzQzhHc0h6YWNId25iKzgrSUVUSVVlblB0eXNP?=
 =?utf-8?B?UGlXT2o0MVM1WmtLcDlleXZyWGZwUXpJa3pTaWFrR1ZqRmw1V0FoR2FLdDVh?=
 =?utf-8?Q?HTmJhPboXAH2Fehu/Mjppqo=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dfa7d6ec-ad00-442c-c768-08db8a021431
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2023 15:49:33.9994
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F0J7s6ghYIcGR7zeAiecDklLb77NLYIJepomBh6k2TLMl5+xj/73cisi6H51RNl8qLOeyGYLUbmCFAH6288+9fJ1mTB+D8Zo4j1eHFfY3Kk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7753
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jakub Kicinski <kuba@kernel.org>
Date: Thu, 20 Jul 2023 10:37:51 -0700

> Page pool use in hardirq is prohibited, add debug checks
> to catch misuses. IIRC we previously discussed using
> DEBUG_NET_WARN_ON_ONCE() for this, but there were concerns
> that people will have DEBUG_NET enabled in perf testing.
> I don't think anyone enables lockdep in perf testing,
> so use lockdep to avoid pushback and arguing :)

+1 patch to add to my tree to base my current series on...
Time to create separate repo named "page-pool-next"? :D

> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: peterz@infradead.org
> CC: mingo@redhat.com
> CC: will@kernel.org
> CC: longman@redhat.com
> CC: boqun.feng@gmail.com
> CC: hawk@kernel.org
> CC: ilias.apalodimas@linaro.org
> ---
>  include/linux/lockdep.h | 7 +++++++
>  net/core/page_pool.c    | 4 ++++
>  2 files changed, 11 insertions(+)
> 
> diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
> index 310f85903c91..dc2844b071c2 100644
> --- a/include/linux/lockdep.h
> +++ b/include/linux/lockdep.h
> @@ -625,6 +625,12 @@ do {									\
>  	WARN_ON_ONCE(__lockdep_enabled && !this_cpu_read(hardirq_context)); \
>  } while (0)
>  
> +#define lockdep_assert_no_hardirq()					\
> +do {									\
> +	WARN_ON_ONCE(__lockdep_enabled && (this_cpu_read(hardirq_context) || \
> +					   !this_cpu_read(hardirqs_enabled))); \
> +} while (0)
> +
>  #define lockdep_assert_preemption_enabled()				\
>  do {									\
>  	WARN_ON_ONCE(IS_ENABLED(CONFIG_PREEMPT_COUNT)	&&		\
> @@ -659,6 +665,7 @@ do {									\
>  # define lockdep_assert_irqs_enabled() do { } while (0)
>  # define lockdep_assert_irqs_disabled() do { } while (0)
>  # define lockdep_assert_in_irq() do { } while (0)
> +# define lockdep_assert_no_hardirq() do { } while (0)
>  
>  # define lockdep_assert_preemption_enabled() do { } while (0)
>  # define lockdep_assert_preemption_disabled() do { } while (0)
> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
> index a3e12a61d456..3ac760fcdc22 100644
> --- a/net/core/page_pool.c
> +++ b/net/core/page_pool.c
> @@ -536,6 +536,8 @@ static void page_pool_return_page(struct page_pool *pool, struct page *page)
>  static bool page_pool_recycle_in_ring(struct page_pool *pool, struct page *page)

Crap can happen earlier. Imagine that some weird code asked for direct
recycling with IRQs disabled. Then, we can hit
__page_pool_put_page:page_pool_recycle_in_cache and who knows what can
happen.
Can't we add this assertion right to the beginning of
__page_pool_put_page()? It's reasonable enough, at least for me, and
wouldn't require any commentary splats. Unlike put_defragged_page() as
Yunsheng proposes :p

Other than that (which is debatable), looks fine to me.

>  {
>  	int ret;
> +
> +	lockdep_assert_no_hardirq();
>  	/* BH protection not needed if current is softirq */
>  	if (in_softirq())
>  		ret = ptr_ring_produce(&pool->ring, page);
> @@ -642,6 +644,8 @@ void page_pool_put_page_bulk(struct page_pool *pool, void **data,
>  	int i, bulk_len = 0;
>  	bool in_softirq;
>  
> +	lockdep_assert_no_hardirq();
> +
>  	for (i = 0; i < count; i++) {
>  		struct page *page = virt_to_head_page(data[i]);
>  

Thanks,
Olek

