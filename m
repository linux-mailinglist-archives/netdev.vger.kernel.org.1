Return-Path: <netdev+bounces-40487-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2AD57C7869
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 23:14:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98347282B23
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 21:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B21B63E464;
	Thu, 12 Oct 2023 21:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PdkuFp0f"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7269E34CE2
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 21:14:01 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD169D
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 14:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697145239; x=1728681239;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TrX/6+B2SclrWIBb14SJWl8CCEE7a2rcR9qzzWr3TfM=;
  b=PdkuFp0fpQlDxgEYNVxdsm1uP7bQBtikDM93Sdl03uQdrdgM9r+G+c1F
   KQi505HLF3IWZzoVjFNXChVcyeBhXwHyz0CHTwmGp9yKLtXpOG6Omv1fl
   zmX1Lu7jLsCDo5CLGkVdwhJP8xJ3cvzK11iuJqXrqzRq2bamKHUK/zVpF
   HxBDXpm4dq4pfDbmDma5DCyqJQBYENOLzfodXQcYUbKMPKNPgDRUGHLIk
   AUZ1bcoJaoXenxhtyRfkfdsfNIN2cq7FCAlr9ufv9BMO7R3jQsXFqtcch
   hNm9PIWbtUu3Up/rZW6AMaBF8ziFsNjLNyNdZHgpUSlWpHIa38apQiChP
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="375393128"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="375393128"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 14:13:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="824763401"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="824763401"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Oct 2023 14:13:57 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 12 Oct 2023 14:13:57 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 12 Oct 2023 14:13:57 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 12 Oct 2023 14:13:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gR7wa70uCNvSSjOcUNnWva8FBsE6qe1MrxzgLj+WFll6zia/WoQ4HcWTK7kuWVjV0LfUobPMwBuABxE1LRotIACrOXqyxHtWU+w8YtOXuOB1Mq4lG9oUTHs7C5fzlCNBd3EoALrLKfk0pCpDgU/efKp7aXndbBxaDw8mV3j4or7iCci+RltydP8Pv1j9oFxGC0kJAb7aEzymo1MnQW8PK/ymiZNy1OeovO53Y0fUl7eHMZAqhrB3RZfKTXJ/fCaUH8wnYaPuo/OuEN9K+CzUPKU2ZD0pm4P9qkeSd+aTbwZpRXfbqoELxxa6PKFSxrNKuurQIOBfMJPCyARUf3Socw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/V0wiEKnRRGVk7iO3Nah3hoZ8wDTUWYQzENvfrm6sKk=;
 b=AXunxeNxahFxFYS+uNReUm/IiSIppZged2SuCxV/Wbbi8+SVvP74LWhk5YgS1EYH9dRjoIVofGPX1X3MhcNT8GlAIDmTVFUNmUlWHnf++GbBq2bn7pCpKe3WshbAnJBxWM2fb7xZr+09w7JKflGAIXleFko1tFjDQDAh3K63XzwHK17njVNf42duSJZBSMCkCmgwL9KgjW5lrrxQ/YxfW2P+3ewVOyMJ+sDmXsYRe7l3mcx9Wkv1z1zaVRzsygth1fIMjPPC3zqBkn/lR1FaIRwUJs4HuqztsVYdQZJr1+5wLDDpitx50gZFF3hwKEH5vqJo+wlrMFbnZgfA7JuAIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SA0PR11MB4671.namprd11.prod.outlook.com (2603:10b6:806:9f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Thu, 12 Oct
 2023 21:13:55 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::9654:610d:227a:104f]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::9654:610d:227a:104f%5]) with mapi id 15.20.6863.043; Thu, 12 Oct 2023
 21:13:54 +0000
Message-ID: <16b9f9c1-2df9-4242-b610-d7c20ac5a7e5@intel.com>
Date: Thu, 12 Oct 2023 14:13:52 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next V2 01/15] net/mlx5: Parallelize vhca event handling
Content-Language: en-US
To: Saeed Mahameed <saeed@kernel.org>, "David S. Miller"
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: Saeed Mahameed <saeedm@nvidia.com>, <netdev@vger.kernel.org>, Tariq Toukan
	<tariqt@nvidia.com>, Wei Zhang <weizhang@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Shay Drory <shayd@nvidia.com>
References: <20231012192750.124945-1-saeed@kernel.org>
 <20231012192750.124945-2-saeed@kernel.org>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20231012192750.124945-2-saeed@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0053.namprd03.prod.outlook.com
 (2603:10b6:303:8e::28) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SA0PR11MB4671:EE_
X-MS-Office365-Filtering-Correlation-Id: 92f7ae0c-30c9-4e1e-6664-08dbcb68243d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5NaF8TXzaT7ZmkCbPQGVOPfo0QUDR1KlzHY5M7pxlru5Ilo1Nnt/OhlPiwlyncdFQ6ylMWrcgAIyjJbMebbC3GUnUz/BugHoc6ngvTZyz2BGqSeESTzHYRDJbeT574btAONTNHa/vNRtna0U9gWDlL2yDgXF+BD/zqnhAb4yvMkqqv87pM+fbYZpTv6Akl/Q5M7eoCZJ7fIKoMixZy2Vpy3lxNSPOJrdHJHjpIcvXPESx2ULn/yZEfz8nQzgLGwNTVEs3aUPAMP4FkjFi87j78zSlfWfPzU+W+gSVCQKrciQpTIiRSFP9LKbLcA77+lixxcJQnfwgFIJDL7+7BHjuihj0e5Xzu1z/RsOm+MXld3tEiEqZXJecD6ib6BwSUlfhbmGjxS/M382c+rUhgRF6snQzI2ncxisiwYv7JhfrAvmpq5YMAn/eg9BGHBLmTXcN/gWot39rY5/y98NFlCaQfZZsuQTwpxCMBnhWa6m9LjBYreL7zd2GOiIKpW8cMlkF0pFhtyiaiwm03K4SQ9wmGH/0hRTUAGUglBLBL9t2mMNurSTZ6ZCJ0h5YewMq45VlAEpUhq+Sj6FBNGstLmlXDWqJtlWp7GvHUADzJMAMbzwY67ThoSJp25RnPln6ELrWCuvkRoWZC0Wj26sDVHOiw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(366004)(396003)(376002)(39860400002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(6506007)(53546011)(83380400001)(31686004)(26005)(6512007)(38100700002)(7416002)(86362001)(8936002)(2906002)(31696002)(6486002)(5660300002)(4326008)(8676002)(316002)(36756003)(66556008)(110136005)(66946007)(54906003)(66476007)(41300700001)(2616005)(82960400001)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a1VKT3BQTms2NDNnbGdXM2djb294YXMvUUFSam95T0lXQTFUMTB0OFFIWDRP?=
 =?utf-8?B?V1JjaVlMVkdTd1F5NFhaVVA1d2JqUUEyejA5R3M3WGVReDFISFEvazdKWXBz?=
 =?utf-8?B?VzNVKzJNQzc4bENuSDVEVm5jN2VZaGpiUzlFTWVIRWtSZkRPK0FoMVNvQjFG?=
 =?utf-8?B?WmNXYmljanRrWjJaT2phZEtVeXZyaXVHb0JXdzNIMUgrVWN2Wis3Zlpkc3ds?=
 =?utf-8?B?RjZncm1WNEFuSVRZcUFVNndzTDBiaHV0dnlUWUtibmRvY0xHNWVOOXJUOFJP?=
 =?utf-8?B?Ym5Ta0pEa1h5RldEakR1Q3JEQmZhT0Q4VG9mY0RYMm9JR1hYbXBuQlo3eW5Z?=
 =?utf-8?B?MEZveWp4dm1WTzB4NjVWL0xOTkRTZnEzMU16RUNPVDdpTnorSG10ZmJQZzlu?=
 =?utf-8?B?eVM1VndNTDBYOHdDVVkxOG1YbTlWMk5Db1c5MDEyWDlVbTdEcVBZM0RPRjk5?=
 =?utf-8?B?L25sMVZYS0JVbThsYU5VbUdnNzB3VmYrMWdSckV0N21PL2xINTQ4dzJhODZp?=
 =?utf-8?B?SjlVNGpncXJDSkZtYWN5VnA5OHJwYkFrd2wxQ2w2SDZSaStzTFROOTFKV1JI?=
 =?utf-8?B?TWpLZFRuYUZtM3c1RHo5T0RySGhNTTlsSzhoS0tvQ25hblhKMmlUNzQrVENX?=
 =?utf-8?B?U2Fzc2g0L2p1bHMxRkgybTVqdHp5bzREREE1RmJocGkxVllKUkpDTk5DVmV4?=
 =?utf-8?B?cTNtOVBUWmNRNHFIbVlvNlNCVFFXeG1MaEVoSzRIZUhROTN2M3RnQXZqNnVR?=
 =?utf-8?B?dSsyTHRuUFV5ZWhEd25JamljTzMvUy9sOWlKdmVCZmMzdFR6Wjc2QTFJNGZ3?=
 =?utf-8?B?WGp5UXY1MTc1ZHpuVWJRR09mUjZEUmVCVWV0UG9aM1loZHRMR1Q3SXEwcFRE?=
 =?utf-8?B?ck0rWEtEL2puSHJBUDdUTEg3VEhub2Q5d3Z4N01PUlRnWmxleWJ0c0dHelBB?=
 =?utf-8?B?bUpFTElSWGZLbE5IaUNHR2dxelNrcHdzNHN1bEUyRFVCb1ZlTEt6OTQ5Y2pU?=
 =?utf-8?B?eDVLSlhtVzIzWWxEM2VjQUU1QVppSXNOaE05cW9zdnN4YnFFdTg1bWliTy9o?=
 =?utf-8?B?SFFhMlJ0RnlMSXVCeWFkMWk0cnBUVFNsaUNwK1V0eDVxQmllZWx1RGlHOU1l?=
 =?utf-8?B?eHlUMEswYTArN20rTTJaQmdMSHZDQ2p5ekxFUzN5V0hyeC96Y2s3M0NPbXJ1?=
 =?utf-8?B?Z3RFWEJhdVM5MEYxWTRYUFZKN0pkYzM4Si9FeGZmMEF4MHR2MmZTdlpNUlBN?=
 =?utf-8?B?Qm9oajMyZHE2NjJQejNvQlQ3ZlFOdGNaSTFNdGZUSU04dGpvT3pxZ3cvSmtE?=
 =?utf-8?B?OVBuMTk4NkpCREVicFVJZmdOOTV4MkUxWFVZaHd3b0RqR0FxQlVOT0NReC9V?=
 =?utf-8?B?V3lRNWpUZUlOUHVyaTlzUU9WQlFmVGpyNzJWeTk2TW9NeGpVQjA2UFhOcFRN?=
 =?utf-8?B?dHp1cnYrZnNvK0pkSUY0UlV2cHNqOHNpODc2UzdMcjBRN0tkbTkyamlmNjNX?=
 =?utf-8?B?bEtxdld6K21WQTNnYytLbVJaRnhQdHFSTnFFVTYwRXRucFhqTmNPdE1qbmt0?=
 =?utf-8?B?NVZHYjYwNGpqVmlHT05ZWldlSFBQNXRkQkQ3bWszbzhFR2x3a1pjKzhRTzNG?=
 =?utf-8?B?WnYvTWJ3ZlhmTUFVS0UxcWJrdnJia2pCYmd5YWpFS1BTUGtuZ3IvUjV3MWEz?=
 =?utf-8?B?dkRaanh1SWRoSyt4YWt3TEdRVTA1bjRSWjZpdlEzdi9zQUNJS2NHeGRoeFlI?=
 =?utf-8?B?aWQ5Slo3MWtxWU1RTVU2MTZhSW1yVDE0M3JwVnJ0RlI3dDJxRzhaZWpPbDVH?=
 =?utf-8?B?a0hSL0ZKbXRNN0xTSjEvQ3dvUjhjTy8rOGl4S0lnZ2liaVBoQTIwR2syMmVN?=
 =?utf-8?B?K0g0ZmNpbHVlRTUvdXBjaDkyYW9yMVZVRmN1ckNVbDhYeFJCU0l0YWpvZlRD?=
 =?utf-8?B?SDVZS1cycTBhMEFnMDB1dkI3SGk2cWRlUWEzSzVCR3ZJYyt2dmdOa2ZmRlhU?=
 =?utf-8?B?V1ZScXpSekN5WnlJQ3NKUHlsc2VZbVQ0QTFVSzJGM3NzUmxmSzZzTVo1RjNZ?=
 =?utf-8?B?QlhXbC92RXN5R21GZUdsYXMxRkZKMW9MQ09kcGFLOC9naDF1d25NaUlpaWZw?=
 =?utf-8?B?VGtLNFIyQmtyekRRRFcrajY0eVZjdTNFY0FiMmJoNTVhYzRQSWlRWDFyVmln?=
 =?utf-8?B?dXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 92f7ae0c-30c9-4e1e-6664-08dbcb68243d
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 21:13:54.9295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N2GcuKp8loXCXhdZQFOILCtrhZa7NzU/Ir07a6oSgJ5uVqu1FTUIs7fjuXUb3p4RJ1DpAoLmsY+k6CXrMIhPL7hvmxhDmYBEPy3G1WNk1Kw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4671
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 10/12/2023 12:27 PM, Saeed Mahameed wrote:
> From: Wei Zhang <weizhang@nvidia.com>
> 
> At present, mlx5 driver have a general purpose
> event handler which not only handles vhca event
> but also many other events. This incurs a huge
> bottleneck because the event handler is
> implemented by single threaded workqueue and all
> events are forced to be handled in serial manner
> even though application tries to create multiple
> SFs simultaneously.
> 
> Introduce a dedicated vhca event handler which
> manages SFs parallel creation.
> 
> Signed-off-by: Wei Zhang <weizhang@nvidia.com>
> Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
> Reviewed-by: Shay Drory <shayd@nvidia.com>
> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
> ---
>  .../net/ethernet/mellanox/mlx5/core/events.c  |  5 --
>  .../ethernet/mellanox/mlx5/core/mlx5_core.h   |  3 +-
>  .../mellanox/mlx5/core/sf/vhca_event.c        | 57 ++++++++++++++++++-
>  include/linux/mlx5/driver.h                   |  1 +
>  4 files changed, 57 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/events.c b/drivers/net/ethernet/mellanox/mlx5/core/events.c
> index 3ec892d51f57..d91ea53eb394 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/events.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/events.c
> @@ -441,8 +441,3 @@ int mlx5_blocking_notifier_call_chain(struct mlx5_core_dev *dev, unsigned int ev
>  
>  	return blocking_notifier_call_chain(&events->sw_nh, event, data);
>  }
> -
> -void mlx5_events_work_enqueue(struct mlx5_core_dev *dev, struct work_struct *work)
> -{
> -	queue_work(dev->priv.events->wq, work);
> -}
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
> index 124352459c23..94f809f52f27 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
> @@ -143,6 +143,8 @@ enum mlx5_semaphore_space_address {
>  
>  #define MLX5_DEFAULT_PROF       2
>  #define MLX5_SF_PROF		3
> +#define MLX5_NUM_FW_CMD_THREADS 8
> +#define MLX5_DEV_MAX_WQS	MLX5_NUM_FW_CMD_THREADS
>  
>  static inline int mlx5_flexible_inlen(struct mlx5_core_dev *dev, size_t fixed,
>  				      size_t item_size, size_t num_items,
> @@ -331,7 +333,6 @@ int mlx5_vport_set_other_func_cap(struct mlx5_core_dev *dev, const void *hca_cap
>  #define mlx5_vport_get_other_func_general_cap(dev, vport, out)		\
>  	mlx5_vport_get_other_func_cap(dev, vport, out, MLX5_CAP_GENERAL)
>  
> -void mlx5_events_work_enqueue(struct mlx5_core_dev *dev, struct work_struct *work);
>  static inline u32 mlx5_sriov_get_vf_total_msix(struct pci_dev *pdev)
>  {
>  	struct mlx5_core_dev *dev = pci_get_drvdata(pdev);
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sf/vhca_event.c b/drivers/net/ethernet/mellanox/mlx5/core/sf/vhca_event.c
> index d908fba968f0..c6fd729de8b2 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/sf/vhca_event.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/sf/vhca_event.c
> @@ -21,6 +21,15 @@ struct mlx5_vhca_event_work {
>  	struct mlx5_vhca_state_event event;
>  };
>  
> +struct mlx5_vhca_event_handler {
> +	struct workqueue_struct *wq;
> +};
> +
> +struct mlx5_vhca_events {
> +	struct mlx5_core_dev *dev;
> +	struct mlx5_vhca_event_handler handler[MLX5_DEV_MAX_WQS];
> +};
> +
>  int mlx5_cmd_query_vhca_state(struct mlx5_core_dev *dev, u16 function_id, u32 *out, u32 outlen)
>  {
>  	u32 in[MLX5_ST_SZ_DW(query_vhca_state_in)] = {};
> @@ -99,6 +108,12 @@ static void mlx5_vhca_state_work_handler(struct work_struct *_work)
>  	kfree(work);
>  }
>  
> +static void
> +mlx5_vhca_events_work_enqueue(struct mlx5_core_dev *dev, int idx, struct work_struct *work)
> +{
> +	queue_work(dev->priv.vhca_events->handler[idx].wq, work);
> +}

I guess you need seprate single-threaded work queues because each
sequence of vhca work items on a given index need to be serialized, but
you don't need to serialize between different vhca index? Makes sense
enough.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

