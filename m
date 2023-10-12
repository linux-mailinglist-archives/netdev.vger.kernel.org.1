Return-Path: <netdev+bounces-40501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 679E77C78A0
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 23:32:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89C901C20FA0
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 21:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06EDF3E49B;
	Thu, 12 Oct 2023 21:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nKYKlWSz"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEA33AC0C
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 21:32:20 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5EE1A9
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 14:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697146338; x=1728682338;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5wLZPLjyktPZTIQEo9PGsp6tWQtel7IkRul6EEeGqJE=;
  b=nKYKlWSzKrJe6nzjG4e2wf9YXkSQ/GTH4Hw6yXpgwadako5GPw3PbifT
   zhuhH3iPUQ0PzH5YGrsXH23HN1UOLtBcwqRqHlkOQNkD4errIIWBaITTz
   HbFa4Ug63Kn8+GmDmBEBl8qC5uP6POEiqw2s+mqyliuiKThVqU3wyQH1E
   y2MMZVwJMQkWtplU7BpF1bromcH/r5X1c0ILtMAwxpO8bZMkg3RTsv+x8
   6xtEr4eKju/OZ7xZfHCWKB/amIrZxg8FyxGGsYBmFeicv1lN7qmIYEGgO
   gtyo7227dVmEycU6T26KrPIemxbkr3YobBOZg95f3CXifDC7RbufFdb6z
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="384885763"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="384885763"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 14:32:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="754446915"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="754446915"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Oct 2023 14:32:17 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 12 Oct 2023 14:32:17 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 12 Oct 2023 14:32:17 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 12 Oct 2023 14:32:17 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 12 Oct 2023 14:32:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MbquyHPSZdb0b2H/XaBWllMjNa8f0vLalZLYYR3SGm6Cf2Q+3uakQuCJt0meudYj4jfG61bxCMqTGxk4ojwU6xxCvWMhwQlDgZvJHjdGADlnNEXCV2NsvgpG/OEFJ5R/B03CETw72H31m8khd1Fm69BzMdBAv1l7ncJiWDqRcNIbL7akATN5tvfFkW/D64FFUoEZoDhcfobHqmGexU5H6/sjuVZJXdvT6tU0VgBN5m4meERr/Bjr3L5E27rgv6lsq7ymbjE0uQepwc2IzC3AKB+gkRbZbwdcv7pXuzcgVwNwKMQK7PcugLMDxoDFrwJumoiZ9HqnqihGVkXOmPRLfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U2xslm2IFddtWE5ZjCNHI+P7X21panQTlxC03LPtwrc=;
 b=Oran4K/vDbCO1FnTGXbr67hjDJPwuzFPIjZZ6lC7IIaRYcbGiT6ph/QOwzWsZ1uGPoGgCKc9791cG9HA+UXH/guRgG50W7FuILE3/KKw81VJ4MaTufd79F6Cj3JevhCupNIY3lDVPiQZfK7eIn6bULUMZvzF91OnCju9/wZEA2h8ejDzZyFPEuacQWK2ExJa4vQLkBJwx7iJD+2YzSBjVIOY9uRI9oLpuujCbc6DjeAEsDJt6NHb2g3QsDBE72kDmHlQ29EBDd/oeL31v+Xby3xjdu8FA80Xbs097A4Fcif1VmKfjG3M+xoj595P7N1vGKPbGCHqFhVujDKodFlxIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SJ1PR11MB6132.namprd11.prod.outlook.com (2603:10b6:a03:45d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Thu, 12 Oct
 2023 21:32:14 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::9654:610d:227a:104f]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::9654:610d:227a:104f%5]) with mapi id 15.20.6863.043; Thu, 12 Oct 2023
 21:32:14 +0000
Message-ID: <14597f12-20a1-4822-bab8-454c2871fa83@intel.com>
Date: Thu, 12 Oct 2023 14:32:13 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next V2 11/15] net/mlx5e: Refactor mlx5e_rss_set_rxfh() and
 mlx5e_rss_get_rxfh()
Content-Language: en-US
To: Saeed Mahameed <saeed@kernel.org>, "David S. Miller"
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: Saeed Mahameed <saeedm@nvidia.com>, <netdev@vger.kernel.org>, Tariq Toukan
	<tariqt@nvidia.com>, Adham Faris <afaris@nvidia.com>
References: <20231012192750.124945-1-saeed@kernel.org>
 <20231012192750.124945-12-saeed@kernel.org>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20231012192750.124945-12-saeed@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0389.namprd04.prod.outlook.com
 (2603:10b6:303:81::34) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SJ1PR11MB6132:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d1fa72a-bfbe-431a-7741-08dbcb6ab356
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bHIwNupvOlWzpf/WPPEMJAXwDSlMWXpxJWmvV+R1vEBl0kNkiViVxgxh5RpExaRGNsECKbmxO4J96biY/E55swWvtM1eMiNcZMDrZjszj/USCW4GIM3yWsYT/WkdthCFergV0KK8JFbgP4xStHOmkILMNu49NGtfMI4ga3XOc28CYy6GFZF9pH5IqLlvpSoxXe5mCs6DuukOYX7dPSOE0LB8ZQeMU2vjkeZtaixo4eRVqjRS9X2wVDmxVpjRb8yuzhoAIO+OoZICkvimsMIkXgTqm0zZ1VrkppnB4700xTe+q6LMOl65nJqjdp5G5QK+Wqw0HF12A1FI2GyCwmBGiQZXxmKGlevH19GQkgdMx36G/2OZeJi9GUn3/mMOXNiLTwCTZM+3tzF8ojoeNloGmWfngLM6gwBo9ucQoFndBzNce1C2B5u1/MQHY7cqw35uYli8aisNY6ZqGSxRqp1ostEsn5OUgN2zpC6ozAHVx9YrUNTt3Nf24Nb72Sbc6pW4J9tivA1q9rrTRxFw+OJDNYthq3LXpr7MsJnox3J3I7Tdpv3HsUjnO/9JP6sWNWNtwkN0UTeFbrfkJWaUAqaaOVtEcrpxm64rO0lgxwKz65t2qIGAYM/mIPV/q1DuyXJl7yUIFynVHXyof4mYGnJ0Sw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(39860400002)(376002)(136003)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(26005)(82960400001)(6506007)(36756003)(316002)(66946007)(66476007)(54906003)(66556008)(110136005)(53546011)(2616005)(86362001)(38100700002)(6512007)(31686004)(6486002)(478600001)(31696002)(2906002)(5660300002)(4326008)(8936002)(8676002)(4744005)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NW90bVZRTmdncVBDNWJ5dC84SFMvam5uMWVncE5mNzJrM0NhNnBRYUhlUytC?=
 =?utf-8?B?WHc4cjROcEt6VTQ5YzRRamJvemlKa3ZLSUppTEJVZE5USlFjQTlKcUZ4aFV0?=
 =?utf-8?B?YzR2SGlTVDBzSDYyeThJdllVQlZvQ3lRTTd1VmladVZYcDNVd0s5eUlZcStF?=
 =?utf-8?B?WHkrU1RrVi8xN2pZbnJLcHBVZ2lmYXAvdHZQenpkSXZrUmVFT3ZhY1FONS8w?=
 =?utf-8?B?NTFOeG5odnI0Q1JZZk9sbzhUbzY3MkY1d3BEcDRBSTdQdkk0dGZTVzdtMW1S?=
 =?utf-8?B?eTBPa05JVGJvS3ZlZGRRNTFZaUxVMVNoeFgzSEdhb0kwdW42Z2RXRmZUWVB3?=
 =?utf-8?B?S0xiazlnZ3k2SDh1Q3ZXL256T21RcTVKVlN2VERoemxIYU9NRWtsY2VMbGxG?=
 =?utf-8?B?SExzVDJnbVE5eDl0UjF0alp6QkZ0MytHbCt4U0c1eHA1cERTTklpcm9VNWpt?=
 =?utf-8?B?OGFZMmZwN2hVTlZTWlJ5ays0MGRxUFA0M2RNQlZNdjJ6MWdCTFVLemhQT0tz?=
 =?utf-8?B?ekpXeDVlN2RadGxDbzRpKzQ2c0J0czNZdlJObi9hR2RTUnVSVVlxMERJajZV?=
 =?utf-8?B?aE96TllTbDdueDR2bDV4RU1oQ1lxL1BaWHJZUmJ6Tm9aRmZuUVBST1oyOTJF?=
 =?utf-8?B?WWNESHFlTkNlWXc4UHBqKysvemJtb3krcU03L3RNVXpBVW9mbDR3VE1FZGdx?=
 =?utf-8?B?ZnQ5cCszOTkxaXRPa2ZwdTBLbWhtb082aTloUG54ZUh6YW91ZER5MnA4SXVQ?=
 =?utf-8?B?elR2ckI4em9ZYXRRSE9jK3l4OGJDbmN6cTlFcGRkU0dvUmpZOFVVaEJYL2tS?=
 =?utf-8?B?U1Z1WjhESjlIMTUxUVJseHJUQzUxTGVXc1ovMVREMURydDNxYnpyNUVhZ3FU?=
 =?utf-8?B?WkUxdlV2Y3ZjcUJmd0pRV1RHblBsS0E1MlpXSjVXempDRFF3OHEzVEpINDl1?=
 =?utf-8?B?UGZVZXdFbXV0dlJUSXUvbXJXV3JvcjJCdENXVjB3a2d3dEJnSStJMXFHMGNT?=
 =?utf-8?B?T3dWVFA1MkJ0UjNPRjdOV1ZQeTJDZWZpMVhUZG5WYkpxNGR5bHdpS1Z5bnlE?=
 =?utf-8?B?RUlQNWl5R04zZC9mWi9abDY2MDZVMjRXcEtCWmZZQjJHcXJGSDF6UENDSjBi?=
 =?utf-8?B?Z2xtWWU1dk93UEpOUENubW95ZlhKcXl2K0l3aDYxMnhwWjdiQ3Y3RTA1UFc5?=
 =?utf-8?B?bUNhMWZQUUFuN3grMlFINkszOThCcnJpbmN6WjlENmt3VGJvS2paMkZkaDJF?=
 =?utf-8?B?VENTNW5mTDFOckgyZHlHOHA4UWpxRWFITEVvcHFTQi9KRmtSY3IxOC9odnkx?=
 =?utf-8?B?Z1hGaFhZNW1VN0RVUVNCOHNwN2UvRG4zcmMzczB6UzFGc3d0NElUb3AzdjVx?=
 =?utf-8?B?UzlHZEhqRlRHSENoTHV2YmdyR3RXQ2E0Y3lxM3pENEJUVWxlTkp6Mno4eEdY?=
 =?utf-8?B?UjgvUDJDTTQyVXBCSENyemJxd216aE55QWZva0JHM0NBYnVXUnZzWlRQQmwv?=
 =?utf-8?B?VWVONm0raW1Qd2EyV0liQlhiL1YrczM4TUhaOEdpWlRkb3k5dW5FeXIvcEVl?=
 =?utf-8?B?MHNxTk9GRXJBSGZtRlgzZnVNY3ZXNzVaanNTa2hocWowdWpaemYrVXM0NTFx?=
 =?utf-8?B?VGphbU1JN2czTWc1eGhVb3IzcVJkK0dKQXRHM2VoWDM1L1J0M2ZXekYyaWpF?=
 =?utf-8?B?U3VIRkpsYzlhbWNGV3pMSXc0QzNCSHh5R0EvOC9GVlRBR0lPZk83NzAvTlRj?=
 =?utf-8?B?ZEhZVWJnYStLc1U0V1JVVTVHclZhY05nbGx5Q2hLZXRHN09nMExEMkhybWZl?=
 =?utf-8?B?RlcrdTBVRU4vNWh6ZlFGTkZGR3hrd3hXRlJMckU4dTFEdEd5ekRjdEhnN3ox?=
 =?utf-8?B?SEZCWFFMQmF2clpNSjlsb2oxR0M1TktzTGZFeXgwUkJGQUw2bEZzNnRVcDAv?=
 =?utf-8?B?VTZ3emRudk5RR1c5UDcrNXhheG14NmgyVGNpcEh4SEZrbUZqVGQxVGFhZkxG?=
 =?utf-8?B?VHRJVnIrbFRyejZNWnpndHY4OGJlZ255UmtsaG50MWZCZmF3a2V3SFBFYlNx?=
 =?utf-8?B?R0djR2paN0JaL0xudkFqc2dNRWN4T3ZZbXEvOFBXeTl3dWxyemc0WUU2M1BO?=
 =?utf-8?B?QjJQZG5VTUd3RGRFMnhlTXEreUFZK0tRUE1pRVpqMmRXZ1hnZVcyMjNaZ1Rs?=
 =?utf-8?B?TEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d1fa72a-bfbe-431a-7741-08dbcb6ab356
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 21:32:13.9743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0sxrkyCMK33Ir82yrTEvnt1rh8KWwfsMciZ1xPHR2cHYHBEer8rIRWljc6u8DPYx0V6w3y6SrhAg/2NsGB8MgKlsP1rPxvUJOj3n51ggcg8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6132
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 10/12/2023 12:27 PM, Saeed Mahameed wrote:
> From: Adham Faris <afaris@nvidia.com>
> 
> Initialize indirect table array with memcpy rather than for loop.
> This change has made for two reasons:
> 1) To be consistent with the indirect table array init in
>    mlx5e_rss_set_rxfh().
> 2) In general, prefer to use memcpy for array initializing rather than
>    for loop.
> 
> Signed-off-by: Adham Faris <afaris@nvidia.com>
> Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

