Return-Path: <netdev+bounces-40497-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA3D07C789A
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 23:29:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60151282B7D
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 21:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B303E48E;
	Thu, 12 Oct 2023 21:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HW8HWr7K"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10CA3AC0C
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 21:28:58 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14454A9
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 14:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697146137; x=1728682137;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=skKLnul5ybXZ1OWYeH8VuYCEekpF8oSH73weFIoEu+Q=;
  b=HW8HWr7KtpG5z3GIVew1W6NXZXAerc1oYQ7ssYu+R72ub3JeZa039VQv
   2dZnIvtTQOCDb/PuqWJ3Od+liokg33822jziDJ8C4dYKNrb8X9wn53ujn
   4EETA6mtznG6ABeCAwsFgrHH+KsLhm4kXPIPA/HRiYyDSWzgLpT5rcaGx
   IMW1z16eAJqsvcp5gYrVhzDeU9v6KF06GzWbGEzozGEnzxDsNwH4s7hak
   QPHpOWyWjXFWdPUPsB8W4taGiIoGdulZSZY3qjGTaZVRMXP10cu/R0jcD
   YdZb5jDNrQPZ+TzKs6qVJ97KSPpTqDfKuLi+LGhlK7+eZsiMBnCPmL0J6
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="449236812"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="449236812"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 14:28:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="845144929"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="845144929"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Oct 2023 14:28:56 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 12 Oct 2023 14:28:56 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 12 Oct 2023 14:28:56 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 12 Oct 2023 14:28:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MhVfILP4l1fut/M/4IKXpC86GBtFWyv2gQclyjVkMg83KE4G+jBK/OuE9yb6sR5KW7yycoWDFiD3AJQQL2FPMh9XJtApzHLK8EZQfIwjBy14eeImYWz+itEyq+ocxlQ0E3ZR66AUxFey6PQk7HyYkLEPnb+9Trzj3kbrK7t8lS3mjy8wYnmA6SeGNRL16hZS8NjQANsDBWWS0nXpg4hB39JA1K2UPqNqXOlJwlGZq43HHIQExJ+7vC8HZrw8cjOcGZc9DRgxqiIdEU+k4eAIsMpW2P6jgQ5c16o0kTZkDRIzh5yUFVqmMItefq18nQBSAWtnH+2p0P+b+glbkD4ivA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SyQ7SRG8RZb65pAQwzFUA45YilJ+jF5et63Na1l3Mbo=;
 b=gtWGLs6tv2VaU+j6H7rNroxJLVbC1PhjCoiYi/owqwlbu3BWvBiNXDHhImwJeKaKmIQTygEFyZNhXMRS9PhVz6yBYTxLfFl1h1NAyu++lRQOrwxSA81/3+y1tmjc9UfmdxesFaEgXv0dYR74JcfGJDWS6b13BAxNsVvo8IKPxZuVCxG3tzFQiNfAAZG+sXflHOqOTqvRZ5b2H1uEOSjtTEWrxKXyenbYSA6ExdINpuaHYy/HzSJA1NgGyvyrlDoPKgeF1mdjwd1iynDx5t7Q/A6I3HscYBayQCWpgSHqUD5rkNGPoxQMehG8W1Mqs7DXmP1H7jYSjn7fK/bf3Za8cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH7PR11MB7551.namprd11.prod.outlook.com (2603:10b6:510:27c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Thu, 12 Oct
 2023 21:28:51 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::9654:610d:227a:104f]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::9654:610d:227a:104f%5]) with mapi id 15.20.6863.043; Thu, 12 Oct 2023
 21:28:51 +0000
Message-ID: <e38a2974-086e-4865-ba96-c34ef33a390f@intel.com>
Date: Thu, 12 Oct 2023 14:28:49 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next V2 05/15] net/mlx5: Replace global mlx5_intf_lock with
 HCA devcom component lock
Content-Language: en-US
To: Saeed Mahameed <saeed@kernel.org>, "David S. Miller"
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: Saeed Mahameed <saeedm@nvidia.com>, <netdev@vger.kernel.org>, Tariq Toukan
	<tariqt@nvidia.com>, Shay Drory <shayd@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>
References: <20231012192750.124945-1-saeed@kernel.org>
 <20231012192750.124945-6-saeed@kernel.org>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20231012192750.124945-6-saeed@kernel.org>
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
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|PH7PR11MB7551:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c384c53-ecfe-4bbf-4faf-08dbcb6a3a8a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wgkYdlz15lme3MobGntk24kQ0uyXffVkDH0GqGVNc+R50Sopp9RxhHe8QZSqNR73cO73PQGs8Dj1r+rYkE9XtmBKrxSOQ2iL5lK5Tr7Mu1TGDsykL/UYKcnveMTYSnjyaZFWFbcfUJfFJ8rDx8qea1c6Yn5NrCVKnd3ebZ9Q8kC0F8Rj1vdlO5iHWAvGF7LwlP4OUHTFB7Vxm7+qrPe64u3gCo2StGEX156YrHeBMSGBkH5LVaC9ci3B3dWxuYOcDmsR/sG8yYwvjqKjnOp/xglXChL6wGns91sL29Cieb8ZuhxHNXdJeBjqGJ84jaYvQ6llhakVGMrV5WcBtsRbN5erD4MFkZ+OBQGh1SgJ0hh4UygjVgAJvz5McSUWKvrj9YBEAnKdaMuuj1nR4qiqagnc3v1rsaXvHhVcGn7ekCA2NYlpL7qJWMVogh70VcJSL5Y40WkGRT29H12biNklEmbzAanLzKNt/VEpAd1p74G3gCfRL2cIcKgMHyDQlBpgyq7a+t7ByoDwN9zyTuoT3u3TryWrZDGnhHwEGeg3tmP1mtPAi0EpfAAjeU8v1O/PmSZqNL24fU+WEAi16rrmxhvw4gevlKJRd9w78tCT+glDF225ugXJMaX5p2id1hfc/VSIjGvUQd+xC1DLpljtjw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(396003)(39860400002)(136003)(366004)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(2616005)(7416002)(53546011)(6506007)(4744005)(41300700001)(2906002)(66476007)(66556008)(66946007)(4326008)(31686004)(26005)(478600001)(5660300002)(6512007)(6486002)(83380400001)(316002)(54906003)(36756003)(38100700002)(110136005)(8676002)(82960400001)(86362001)(31696002)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?blRCczM4ZStIQlRkTXpwd2Y5MmxPeVBpUXpKR1BPNUZQTDFHWUxYWlZMQ1No?=
 =?utf-8?B?aWhwZ0pOWjJlRFlKQUJCU2ZvZ2pzdHJscTlPMGxHK1NqQlV5MDRnU3JobVNF?=
 =?utf-8?B?SkF6ZTVtZlB1Nm12RnJzZVI2UWJTTlhIYVV2T0FJRWl6QkVlMk5PRzQ1SkUv?=
 =?utf-8?B?QkIyemV5VmVoeDYvejJqRjRHM1l1aHMzMGVBSHNSVXlZWFFjRWQ4V3AyeERD?=
 =?utf-8?B?a0FPNktQWnlQNnZsVHFUSW9mQUtRS1pGSkk1TWJzWWVIVyt6QmN5dW0wZzAv?=
 =?utf-8?B?c1hMS2lyMTFDeEdEK0pLQWNBWkdKYnJ5QlY4RHlERUkwTFI2ZE5pVjI5a0NL?=
 =?utf-8?B?Z3FFUzVlbkdWcE1mWm9pSnBhSzkzNG93SE93alZaWmhzNTBRUkFwWFZBNG5x?=
 =?utf-8?B?dGhGbStYMG1xMGNGaFljcDdxZGFlcGx1ZG0xTzIwSmRHZTh3dHZyb0JRYXFT?=
 =?utf-8?B?cGtpcXVoWU9yTzMrNUlMVkxabW1VL2IzaFZ4cWl2aisvblRGN21WZll2TEZk?=
 =?utf-8?B?YU5uOE1XNGlnSk1rVUlXcTFNbXJBK0VEY0hYU25OclVzSjd0RE9CTEZMUnEr?=
 =?utf-8?B?bzJWaWphNWEvYkdSMzNQZFZUZHRtL2ZPaDQ4UWRqTnJ5L2VxM0xNMnBMdG1M?=
 =?utf-8?B?b0M1STZnaFg5aHR6UHpFNzhXYkhYY0hicUtYazlubkoyVTlLM3pzR0JjMVZV?=
 =?utf-8?B?NDdKQ1pzTWlrenFySE05N01yOEllSUUvNHVzSWZpZDQzUmVBNlNWUWRHbUp5?=
 =?utf-8?B?ay8vMzV5TWxaQ3ZLS0J1QmpieE9sTkxKNHovVStPd3QyOVNPREd3ci84VlBk?=
 =?utf-8?B?aWt4MEJTU0hTZjA5dkhMaHpkbm1XdWNqbGNZc2pMT2MxcERtSGxSMkhpN2lU?=
 =?utf-8?B?Vk9KT2ttZW9OdGU1NUVNMHRCb1NXa0ZONTAyS29RQ2JCbWYra0FsVmhVNkQr?=
 =?utf-8?B?cUlyb3lNUDBOaVNtRjlhcUlLQmxuODY3b1hKUWJmVksvOWZuTWs3U3FjUTZu?=
 =?utf-8?B?QmtBaW1TY3k4cFdUWVU1S1AwWDBNVmVwbENxcTZyM0xBNDhaTU9DaVNVMlA0?=
 =?utf-8?B?YUtLK0tKMnFWVnBoZEJwdmdwM3RvbTdkbURtd3Z2Sk8yaUl3WU5FaVphM1JW?=
 =?utf-8?B?bjZjMWxHOVNpUXczS1BmelFOaXhRcXo2cEdKVXUrUlhGZjdhTnFrN0lqdVRN?=
 =?utf-8?B?ZG1ML1dPOTBySmhmWW01bWtGaExTTEkzQmpUWXhEMHF6OWFzbXM0eHdoZkZP?=
 =?utf-8?B?K0UwZFN6Z21abWpEWmVvdVVSSStiOG54TSt1Z1grZnJNc0NCVXNvdTNqOCtn?=
 =?utf-8?B?UG5MekpTc0ozMFJkWFllaVBZU3ZhVC9zcVVkeHplRlZVVkovdEd4TmtGNVp3?=
 =?utf-8?B?cUF5UGM4N1NpLy84NVY4TWYwaXA1S0VDOEd3VTNna0dWUHZ3MVRnYWpHaUVl?=
 =?utf-8?B?U3k2OHNjVjNySDhxamxFN1BlZmpMdHFZY2xGTjRuc3YvZEJqQStSZzFiZ2VB?=
 =?utf-8?B?NGx5bUJlamszbytqV1U1Q1ZIRnZaWXlsdThmelhDQkNtNVdzZzFhVkFRRVJT?=
 =?utf-8?B?UVdyc2pxY09IOW9VYW14S0ZUdGZxTjBQdGNSaGZGRmNIbXlURVQ3eGJpQXhw?=
 =?utf-8?B?Q1llTjdnK0Rka1JETFB2ZVFRUjFmK3NiQXQ4dno3TzlMSFM0RWZsMkxjU0FR?=
 =?utf-8?B?YUc5WUoyMFpNOVpGOCtYSVRoaG1BZUlRVjVHNmh4MVYzTTZKR0x6aUtMWWNG?=
 =?utf-8?B?YUZtVnVRNURPZ0tQS0FZWCtVdS81cHhidlhaNUNvRXd5WUUyamZlRGNzcDRi?=
 =?utf-8?B?azhpV2Z4aTdVRXRpT0UzanFrS1NRVHpzLzFQQ2dqZ2NOMWJRN0ZETkk1R0h3?=
 =?utf-8?B?b2ljbVdoTHVMdGxDRCtvSEhLNEhkeE9Lb2hMZWNDVmFRc25obi93a1lNNWRR?=
 =?utf-8?B?aG9ONEhhOGNzaVoxVkUxL1czbkJHQTJ3b2RtcW9JUjlrY3hNWGZIU0NiUUt2?=
 =?utf-8?B?NVg0SW1VYTBsWXdTcjg2cDhpYm5RbmxpcGhlRjBtQjE4ZTJPbTBvMENIajR6?=
 =?utf-8?B?cEJhdkFRcDVUbFE5L2gyelNpVk1HUE1nT0RUOTdNOGlGVkpGaWRFUmo2ejhw?=
 =?utf-8?B?YUxpcDA4TnZMa0VMdGRELzMzL3dZUnZ4RnUwS1lmWXdibTA0Y05NTG1wL09N?=
 =?utf-8?B?ZHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c384c53-ecfe-4bbf-4faf-08dbcb6a3a8a
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 21:28:51.3119
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3EwHjEjoX1zpESxevpx0UfIpayPvasmMnRZSYEUjwu59857m34378BuKyrBLjYxMItruXkI+gzMnYsUVhG7NWqIA3QIhc9XoJr+7PPXRdvA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7551
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 10/12/2023 12:27 PM, Saeed Mahameed wrote:
> From: Shay Drory <shayd@nvidia.com>
> 
> mlx5_intf_lock is used to sync between LAG changes and its slaves
> mlx5 core dev aux devices changes, which means every time mlx5 core
> dev add/remove aux devices, mlx5 is taking this global lock, even if
> LAG functionality isn't supported over the core dev.
> This cause a bottleneck when probing VFs/SFs in parallel.
> 
> Hence, replace mlx5_intf_lock with HCA devcom component lock, or no
> lock if LAG functionality isn't supported.
> 
> Signed-off-by: Shay Drory <shayd@nvidia.com>
> Reviewed-by: Mark Bloch <mbloch@nvidia.com>
> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

