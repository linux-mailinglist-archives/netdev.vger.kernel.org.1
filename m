Return-Path: <netdev+bounces-30163-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C6078641B
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 01:50:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00B5F1C20320
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 23:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD13200D9;
	Wed, 23 Aug 2023 23:49:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4191F17F
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 23:49:59 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6132410DB
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 16:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692834598; x=1724370598;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wnsmfN607+wpEhDn0Onw3XfW9IOAOzag/lHdaabDM3I=;
  b=VpWNzd9Cl/ZQM9nXpLC2v9yYwF8t2l9yQ8WYEVAvqn4VLTXq7LHJ/9ZT
   zHX+n6O/NMHSEfPFgsvfH7P4cNEjGdbD+tyWENVHd82HS6QIJwdNw00bX
   imXwM0UP6Xa/eGMgJ9O0VNVQESeKSyY84iYmEqFOuhm8vQwKkxGPWQfjZ
   mckysQ7IZ3dTMBVGLOWZR83zAGbm1bDzz5aRq/s8ZzzOJ70ZCFIbd1zGF
   zaNPJcR7ofiM4Y0xydMG1rEnifITsRcTRGTeudqR8/SACV4B2BNIwFaww
   VJf44pGdzbBZn3cxuLbVkXYmxSaF8a+cM+muDjMC/FE8yKpOKCDU8QthY
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="438230989"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="438230989"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 16:49:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="736827647"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="736827647"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga002.jf.intel.com with ESMTP; 23 Aug 2023 16:49:57 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 23 Aug 2023 16:49:57 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 23 Aug 2023 16:49:56 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 23 Aug 2023 16:49:56 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 23 Aug 2023 16:49:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zh0/tc08prnJYWA6wbcJBFxBzQjNXQjjhlNNNkqd9kMu/AH3Hj+KmBHg+bNycuA5GhN/KSvD6stKLlKQ9TMzM0rvyExVOxlWhyWYqeLOu+aP2OckZET9XfZH7au52vZXwomRQpjTpQOGDFGDasurp6lgtHjqSdr21oWHP2luYwVJRS5K4/bvSyJwW0KdcYw1qw3C7bvHp7v/aRdBKxpoCSiQwQXlcpv0p22spw4D+Ke2fdetjKbhjAVd9AtklkVs6r5yCLxEYpIqKhpprseXWfYAPPnk4Ydw2rLdevKZQySKfujV8CcndKM8lAM1Y0WrruTmBKXl9xUKd7ChKFO/LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/g/8O+XovGCIO7pT4315oDPQAw1LW6geA8U4pEkzZFs=;
 b=g2hkGgEg/bHTloNS0ppxiVqHa4xH2FxZzez4jkJpIqWTgqGXHz4BL/3dqP6zelg9JWZ/2WtvKgoFuQNLkbRHi9R/gdye4DIeNkd6HZruLuIjjnsQrJ/v9oAGP/jQrRKIYrjst4S/TXnAT5anNM8RYsHbDYGk972y4W2V7V77hwM1lOCqGwhQ/YNgkwsy/Yhjn8OqK44Ve1AbGyA+up6c5L6R5L+8xd4dJLKybaWYOrurOFXab5V6QrHo3yVdv+eQexGAK6alPttxgJ/0WH65fSy7/qoBN+sgx9z1mM8xNdks6F1SQ8H2ibZBB7Up4R6ML+a/FfF6TtxkyFp5U9vdiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7869.namprd11.prod.outlook.com (2603:10b6:208:3f6::7)
 by SA0PR11MB7159.namprd11.prod.outlook.com (2603:10b6:806:24b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Wed, 23 Aug
 2023 23:49:53 +0000
Received: from IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::12e4:637d:955d:a5f]) by IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::12e4:637d:955d:a5f%6]) with mapi id 15.20.6699.026; Wed, 23 Aug 2023
 23:49:53 +0000
Message-ID: <7b940fd5-2921-4c9b-b0b5-4148daadc68e@intel.com>
Date: Wed, 23 Aug 2023 16:49:52 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH v2 7/9] net: Add NAPI IRQ support
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <davem@davemloft.net>,
	<sridhar.samudrala@intel.com>
References: <169266003844.10199.10450480941022607696.stgit@anambiarhost.jf.intel.com>
 <169266034688.10199.12117427969821291880.stgit@anambiarhost.jf.intel.com>
 <20230822175207.17233a9e@kernel.org>
From: "Nambiar, Amritha" <amritha.nambiar@intel.com>
In-Reply-To: <20230822175207.17233a9e@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0151.namprd03.prod.outlook.com
 (2603:10b6:303:8d::6) To IA1PR11MB7869.namprd11.prod.outlook.com
 (2603:10b6:208:3f6::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7869:EE_|SA0PR11MB7159:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d22482b-e960-458f-b6e5-08dba433a5c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5O6vYQq7HH1x7ytOzydZU2myx5MJ+LLYe23W78s/+Nw1qm8ZId95mmMYIDbECMVEuAdApw9lQHeoY4KqtkAWH8hXii3XH/U8xR+sgDnIXGc2k4RnQHww6v+oK0I4lBcocxGtbkSdL8LC0dBTSXnxFiodnhbh3CNElPWNQubtxr5RVgR4iVS848cQfDkTo96DohsZGR+Wo4IXYIf2cz1e6elQDyma+eM3mta126m5v0ItpsYbAMUi7qdhucfYBhBtffE6HjrSifKW9UM+aAIImnj5k7uTrgKQZASQaKBTP34O/sCOv3sIJ9i/U7sCrN2417YntvBcvNv0+KcJ3TR1xtT8SEPgyc27NzNGrGx9qDDxQF0dS/p4A7YP3J64bg1w+tZh/rcnDyZgCnLf3KrQvunZ7tTQRfOTYI+DnyNL1ep2T15/Vys68BWEqUh1GE2XvXa5BjENgrxUH2jq1J7vg9lf2sewztpHVG3ta4xmuUU79dvpOLsBEifJudsLlTFHrpaGKDzODJMphf0WiGJ3qUAofsBH/4ecE0IEuqD3nKYDLh7ajiMkB/o55Es2k1F/gK++oW9/5St2JrrLNBQKrHynLWTo0w3oOeMM1+IGqOeSi6BQkodETwzLU3urolfzsbYXSBMl4JN8mpfSjvDXoQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7869.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39860400002)(376002)(366004)(346002)(186009)(1800799009)(451199024)(66476007)(6916009)(66946007)(6512007)(316002)(66556008)(82960400001)(8676002)(8936002)(107886003)(2616005)(4326008)(36756003)(41300700001)(478600001)(38100700002)(6506007)(53546011)(6486002)(558084003)(2906002)(31686004)(31696002)(86362001)(5660300002)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?alVXZW40NExwdUVwS1ZjMzg1ZDdDdmt1OHRweWM4YzF1L3Y2Vno0V2YvZm5s?=
 =?utf-8?B?aWd3ckFUcGVmdXE3TjVXdXVUVy9RUEU3dVlLSFhLbnhmZ0lMZStvaVlzeUFv?=
 =?utf-8?B?aEhJbnBQWXo0b3NtUHdCNGExak5KZWlPZVFOaVFqUEZvN0lGSnlncGZVWVNX?=
 =?utf-8?B?Rks1bVdsNGhEZzFSK3ViWWt1L3Mzd2ZQeWVtNFFWYnpZekxZZzR6bVBTY0xT?=
 =?utf-8?B?S2ZpTjBtaXJaUTV5cWErNndoT1JoeFN2ZjJ5RktFd1FjdERUUmx1endsTEJx?=
 =?utf-8?B?WVpDakNMWUJaZHh2N29JZEdhSWMyU0dJTXk4aHpBZTdNcEMyRmRaU2pDZk1k?=
 =?utf-8?B?STc5SEhjSFNoRnBQWlZMaWtHN1hObGg1Z0tkdHlBaFdCVWorSFhkbEYvTW1T?=
 =?utf-8?B?ZXRUTk1COTZWVHBWNDJxajMybERWdUNWL3d6Rlg1b09teDZwaTFmM3JrNXVM?=
 =?utf-8?B?TTZEMUZDQ0QwR29OTG5CSG9UMkloYkMzUFJHMDRXcXJzMjRET2hiZ3lpdUZ5?=
 =?utf-8?B?Nk9aWGw1dHVvOXFhN3IrbVg0VTRhcCtieEFHems3Zzd6UE9FNEZSRzZFODdO?=
 =?utf-8?B?VERaTGU1bWNoYkNWOHc3NGNHUldyWnk2T0JESXJPekoxSVpQdHllK1pjR1VY?=
 =?utf-8?B?a2ZKMFVnMi9iM01hOUk3RUd5VzN1Mmh6MUNYZ2VlYlJwZW5KaVpNY24zM21Q?=
 =?utf-8?B?TjNYbDdFbVhMekJTUkp1Q1ZtVDhOc2lOUFZHN3Nwck9NWnBJQlgxNWxaeVFs?=
 =?utf-8?B?SWtURUU2bFFGM1cremY1eldaKzcwL2pOb0QzOC8vOTY4T3B5bmR0TDgxdjZY?=
 =?utf-8?B?S2h0U1U2NFZ4R3EySFBTU2EwMk5YRS9ES0Uwd0xPbU9vNkx6K0RFNGFFVTU2?=
 =?utf-8?B?bEJ6anhJK0YveHBqU3NVcGRZZHV6QkVkZVRaV1VCK0NRNFQreWhjcXVCMzJo?=
 =?utf-8?B?bkJCRkU2aS9nZEY4eWVNZmxXbndONndVL09DMlQrQ0NlMUxvcGVrTkh0clpn?=
 =?utf-8?B?eFR5N2M0bVhJOTMzUzNxOHE4WEtuMUMrenNlb0xaYTNBVzAyNGpEN1RBMnF6?=
 =?utf-8?B?MkRZVlNiNHVjbjdMQW1zMTAxU01TSzVjRFFzdnZhcXZJVXBIL1p4R1lnZ25J?=
 =?utf-8?B?UHZNVU1yMEJrMkJaM1gzMWhEOXN1K2RJejV5UWo2b0k5WUFnNEp1YjVXVy9v?=
 =?utf-8?B?dGpCWVRiaVprc1dnSWhzUXVSZm8vMkZUN29wRmUwM0g2MkZONlhnUFhsRllQ?=
 =?utf-8?B?QzFXbEJMK0pMbEwwUWMwWTZJKzlmZm50WHEvRGVLWE0vdGFWemEyUTJwS2Fa?=
 =?utf-8?B?SWpSUGxXbGpacnYyWDBSeTRXT1NqL0owaHpkakxXejBPbEhSMTZjSmF6ZHFo?=
 =?utf-8?B?RFFMaXRuVXNtM21ZdHBvZnBsSlBORjh6ZFlyd0lKYXlaZ29XdDE1akZ2eW5w?=
 =?utf-8?B?WllqdVNZSS9NakVHbnluVzdCVkl4cWFoTnkzZ0NybGxDVVNTWC9EWVNDTDE3?=
 =?utf-8?B?clAwMzVTU0w1U0RKYi9TcklTSFg2eHlENnVnbE44K1BQV3AwajV6YTlpRGhN?=
 =?utf-8?B?dWNDallHSFBEOHRoMkpmN1pCMXNqTDVyMUF6NzNTWkpscnFjTmd0RWJiRVV6?=
 =?utf-8?B?Umx3TXFVMWJ5U1lKRWNXVktLdWhHanZEa1YzNnFwc3dnYXhqbjh2eHBmdjZr?=
 =?utf-8?B?VW1BVThOeGlyM0Zlc0NUazFVQ3VHZ3JrcXh2NTB6K212VHNibExFVzB2R2VK?=
 =?utf-8?B?T2RkOTVwK1VDNlVIcDc2Tno0WG9ZaTlKSGg3YjVhMWx0dzZFYTE1bzdSdkQ4?=
 =?utf-8?B?cDNoOEw0RVc0dTE2SEtaMWVBQzZHWjh3dk5PdXRaTm54UWhaTFhsL2NzN0xY?=
 =?utf-8?B?M1dnRndZYXBJdXplcnpLd3VGY2dSQ1lJRnc5YzBLZE8xWDBPd1dLdlF5WExr?=
 =?utf-8?B?SVk5Z2tuWG1pdjRKMjBrRmltMFZOUzFwQW5wbHYrdHQwT2tNQm9RRUZHb1RR?=
 =?utf-8?B?VWROZFQ3NXJXa1ZMcXU2S1ZsTEZCbGN0YjZLcFpZWHc1YjRIU0gxU0k4R1hD?=
 =?utf-8?B?alN5M2pXQjA0LzJPKy9tN3FPeE1Yd1E0VHpCS2pvUFNRR1RFNGx0eVNHeFg3?=
 =?utf-8?B?ekoxNkVIRXBFRXVvUnN3UXNQU3VlMWIxM1RWbkVGak44N1hDOG5hWHpwMU10?=
 =?utf-8?B?YkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d22482b-e960-458f-b6e5-08dba433a5c8
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7869.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 23:49:53.7244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yfjDV9oMKAdZm1y+CcTThEryC1RGBdYdRuF1JZKai7RjFjiA1KFhV7ARE63O9ByU0CVXEJmch2XpEsmL9+tOFHmZkxIduPiDy9azPMWGBlo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB7159
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/22/2023 5:52 PM, Jakub Kicinski wrote:
> On Mon, 21 Aug 2023 16:25:46 -0700 Amritha Nambiar wrote:
>> +	if (napi->irq >= 0 && (nla_put_u32(rsp, NETDEV_A_NAPI_IRQ, napi->irq)))
> 
> Unnecessary brackets around nla_put

Will fix in v3.


