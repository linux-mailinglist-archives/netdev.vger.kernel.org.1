Return-Path: <netdev+bounces-37121-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CFD77B3B29
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 22:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id F1A4F282FB4
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 20:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F380167262;
	Fri, 29 Sep 2023 20:18:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C223166DF1
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 20:18:08 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F7FF1B4
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 13:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696018686; x=1727554686;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=57FMx49+rKPNlK4IzlLTZwM4EiuflFmcFOWQ98tXbX4=;
  b=Dsra1tizeDu8dT2+u7bJ7VtMY4zAUDvY3gD2SsPXYWZsvFK2R4rMDkpM
   3rX7Ufa4OdC9+TsPAYzsQXcjgfxAZ3E/IUyLpo5leMre0rGasu7yQrikD
   9kabKxlhGeisVF3yNppacdNKnYfiKPminsBTG3JgkK3FP3cr9bK2NkiZQ
   GhdbmNldaNRg8w+BCldClLCjDao1DgQepOcsCbP0ZBIfSiF6KvtNmK5h7
   B7PdWN0cDJ/dPl/eE4/YDaEaEo88oP8oamjOaYbT/I3T5St0SzkPEss6H
   R0yYctw22l/JADU6dSDKMwd63Tc4Rpe0RrKs/JQy//RIZukmqA9UeYi1r
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="386222014"
X-IronPort-AV: E=Sophos;i="6.03,188,1694761200"; 
   d="scan'208";a="386222014"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 11:23:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="743503484"
X-IronPort-AV: E=Sophos;i="6.03,188,1694761200"; 
   d="scan'208";a="743503484"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Sep 2023 11:23:56 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 29 Sep 2023 11:23:55 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 29 Sep 2023 11:23:55 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 29 Sep 2023 11:23:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dqnjVx3L2WH5+Dkk/xkF69W021EL3ClP7w0/xtx5s5CocanRvjfs9z7Ks4c6QIomF2lcfBFg52gASksmABFEIbYze4sQUBJyllQ0YUwHeA2d/0/b5BE8uESBP/VCFA17iy/MuRNeJR1B4vz3QFmx/Y2xxvH2aB0sz9mQHAKcpZ2pussiashCeUCxI/P0wWr/zeyXsCfOWIBluruETUYsFYs6odW92YycfaaVfrgaevk+owHLuxN3QvKI7ydk9+wYSbgSVECWzyKffsRDQRDJzVYirhzt0w4ujsy1o9p8YYtJWL1Jav7nJ8nH68Zi834aecaBvuHBY2Kux1BHCt7Smg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zUogU/I1S6Eqwzzv7TaS1Y4PSTtHHznfdEeejv8sv7E=;
 b=Jzd4Od4zc8il/Vbjs2r5M33tC7+s1DvVAXdJb67XVo1PXLEzssMe7fQJyCFSXke4lMm58o1wfO67xtiGQ1F6UXVOh8928enBrrqXBC7TnIasAFF3N0oiDnrYWBJ+6REhTjAPEvrgyieXpE1G5N+B9Pvgwmt2o1COhZG+1TkSzGghLcaSVXik/IcZ3QF3gHvLpGSGvSKWc14sEXTEYtwJssLFyGLhtGYbLBIumoqqMR9D/gJPcUQB5RQnWk75k+p+WuRFFXN8w7dltlDAwgZzyTuBCFziLQp27n5twFWHzGm6nANN1scVA5VVY7RzHNUQZ8rWxmj+NBjxIVydU7+Ypw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by IA1PR11MB6196.namprd11.prod.outlook.com (2603:10b6:208:3e8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.26; Fri, 29 Sep
 2023 18:23:52 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::9654:610d:227a:104f]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::9654:610d:227a:104f%5]) with mapi id 15.20.6838.024; Fri, 29 Sep 2023
 18:23:52 +0000
Message-ID: <b4b68e04-c2d5-19ef-3c33-7d97736c951f@intel.com>
Date: Fri, 29 Sep 2023 11:23:49 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4 net-next 4/7] net: ethtool: let the core choose RSS
 context IDs
Content-Language: en-US
To: <edward.cree@amd.com>, <linux-net-drivers@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>,
	<habetsm.xilinx@gmail.com>, <sudheer.mogilappagari@intel.com>,
	<jdamato@fastly.com>, <andrew@lunn.ch>, <mw@semihalf.com>,
	<linux@armlinux.org.uk>, <sgoutham@marvell.com>, <gakula@marvell.com>,
	<sbhatta@marvell.com>, <hkelam@marvell.com>, <saeedm@nvidia.com>,
	<leon@kernel.org>
References: <cover.1695838185.git.ecree.xilinx@gmail.com>
 <692201a4fd89cdf8ead6517fe0166d47385767ec.1695838185.git.ecree.xilinx@gmail.com>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <692201a4fd89cdf8ead6517fe0166d47385767ec.1695838185.git.ecree.xilinx@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0004.namprd03.prod.outlook.com
 (2603:10b6:303:8f::9) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|IA1PR11MB6196:EE_
X-MS-Office365-Filtering-Correlation-Id: 72df68ed-8670-4b5c-097b-08dbc1193bab
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uL+z5b7K7z5MSfA5RAH9BkhD10Rrn6zTmCg9JwXRyHTDfvoUvIHferOqISR5PKNHLgS+UlagnonPBv4Tb0R0Y+u9SNIxPBdYVsKBaJKMZCRGf71qYQlse2sMrGimi4p1cgQkn3c7bu+6+PJmKzu385z7M1G6KQFs0GqZ1Pa+UB30hyPuGtEDhl2PyI/0Bp9SYVn69Q60v79H9AmOinO4XwDuBHqQJZa2dX/T1YmNilUyqu5Vt51v9IIK0jYAge/OD4kKkvWW83sBU4VshlQJBRuIhkNZt4MourUwWnFNzHt4AQwS5AH+KB3nfEuhEBgVSSMw5qty6ECCu/6DXp8Zau2Iov+H4Z6n0KPnZ70JtTJN+LX/FkV/3FiOw0maApSj1yYjqEpx3wHd2i0n4uil3QHS0aIqgNibp1HF5PbMFKl0kkj9QELSFQu7L8fGdBsQdGph2iT6hFswLwZ3RqJuJ4estJhU0VuqUPRwn2rqjeAYGd6RkX8cRTpR117Kq9fBZOpe4aATdeT3R5rjIsKLvRIkpFBFyEw+Nx3KVcbi7XeXdty2YvudhJvtNa9KsgJZ6Y6vkOCDiM2zQWp0Um4a/+jN2t0z1gxJ17+RYClMbt4oNX8q0Qk0mJbMJ/qm+BO4qnNumfUhR4bqWbcIL/+oCw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(346002)(366004)(396003)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(316002)(66946007)(66556008)(66476007)(6512007)(66899024)(8676002)(4326008)(8936002)(41300700001)(26005)(36756003)(2616005)(83380400001)(478600001)(6486002)(6666004)(82960400001)(86362001)(31696002)(38100700002)(53546011)(6506007)(2906002)(7416002)(31686004)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2E1cytlTUU3b2N5RkVseTdMMjQwbk5BaGZHK2RGdW5kMzE2TEh5Z1dHdCtl?=
 =?utf-8?B?MHBHS3dxR2hVZHU2MUhsTm1hNE9jblN0cE5rYmxLaENYWE5PZXhvdjZvRCtt?=
 =?utf-8?B?NHorWjluRytxV2RuNWphbXhuUDVSTTI5RS9UQTVpS041MlFwM1ZFS2hjbkZk?=
 =?utf-8?B?Rm1UVFovdVhDSmdBRzBqU21STC9KZUxJL3FWZHVIKzNEOHVhN0RlRkRkdExU?=
 =?utf-8?B?SGVjNlFFdEFlaU5ZMmtZQ3BpdCtOVUV2dzhueDNPcTF2L21SelhGMk0xSEdB?=
 =?utf-8?B?ajFhRCtlbXMwb0xqbENLUE1uaXVnUGsvWFZEQ0ZnZUxpdThaTVJheUJOSU1L?=
 =?utf-8?B?Y2RBbXF5VVlrdmo4SS9DZ3c2UFFISGRONTRWM282K2NpYmE5ZmJEYzVoanAy?=
 =?utf-8?B?WWZLK0RtRHQ5M2NWK0hjb2w0UTlBOEZYMERmUnpJdmZOVng5YUVxdTRrRWx4?=
 =?utf-8?B?QTE5dFF5MjRMZFVuekFYcVdOc3o1eVA2RDhRSURDTWpIR1VzbENOcXJaMXBo?=
 =?utf-8?B?ZVczTGxwREVqMmJNelZDYlltUVVMK2dERjlWRC9OaHJVN2hzeSt0L2poWFls?=
 =?utf-8?B?RVd3YnhnYUVGM1VmY1NKK1o4VkN0UkZhK25UcGttWkY2YVdJRW9zdHhaT2Fi?=
 =?utf-8?B?N0hSNExwTFBPd0ZGdVllUktuT2pWNGw1V0thdDVjNEowNzgzSDd5M1IrNGdM?=
 =?utf-8?B?Vk5XNi9LNHJFRXBIazVmM1l6QW4wZGJpWDloOUJ0NGcwelVrTFc5MnRBT0hi?=
 =?utf-8?B?ekZqUGZ4eVVhZzMveXhQL20rMlkwMkM3SURjVDFKSGtvaE90WEs1aitEWXFm?=
 =?utf-8?B?YWszMFpyVkgwY3J2ZndUMGNGSGJKdThqSXhBWFBHSE1KQ2ZsOEdFY012V1ly?=
 =?utf-8?B?ZWZuMEtHVGVEczJ4Y3hKeEhaMjNaUXNQQU5SQlI5V3NQSDhTdnNsYUgrTWc1?=
 =?utf-8?B?aWdTWm91RWtPZUxQL1hnTTA4Z0hmazFmTmJZUFdqWnAwaDJ3anFJL2FPVENO?=
 =?utf-8?B?dUZhUTlrYjZncVo0czh3dFhRalhtYkF2NU1zQWFpZU0zS09RUHlkajJZWEhJ?=
 =?utf-8?B?UnV2UG5VUDdGeWF5ZGZwUytxKy9ZaldiNEY4ZllqM2hnbTRNUmRyMjZ3Ny9Y?=
 =?utf-8?B?azdyWnRaOHFGTDEyTGJNS01Zb3U4aWpISU9mRjdrVmR6clJjcHhxSlZ0TUJV?=
 =?utf-8?B?NFhmTTZvckY3STlrY0JlYUtWSXJ6M1lvZldDSzJkMldMUGlaSThpL3FBTVdl?=
 =?utf-8?B?RXZLNUw2Zk5BWFNrNnc3S1RZMTAxMUVVZ3RqeG1kQVJVQ3hDdkMwa3ZTUTFN?=
 =?utf-8?B?Vk52RmhOVzFERDA1Tm1BT1Z4VWJVM3hEOXZxV3lVdE44TUhIbHYyYUl6U1Fp?=
 =?utf-8?B?elNyNU5CVDN2TzZOdU5KTThmbHFoMDcrVjIwWTdnb05DRFpUTFdNTGZqdHdR?=
 =?utf-8?B?NWd6VlFXWUw4MkhmeXpkY2tYUVBIS0Z6aXhaZ09zZnlJUHFKbTdONEorM0xT?=
 =?utf-8?B?Q2F1czNzMFJ6UUE5UFViV3gvSEROZm13VkVCVVduRVBiZHUreDJQZ3RYYjg0?=
 =?utf-8?B?azJKTTA1Z3dVN1BpcFRUR0g4RW16ZlA5QVV3TE42RWwyRnRmcWpVaXlyMEQ3?=
 =?utf-8?B?SGxDRmtTR201cE5RK1IzaG5CMU5iNkphd3B1U3BsZVdudXhZcXN5K3FSV3hC?=
 =?utf-8?B?UDlpMGc1eloycUV1ck8xRDREUStGTXhZM2NVbUtjSnZ6MURrYlQ0OWFicDhX?=
 =?utf-8?B?RjBJWjZPcEJDeHJJQ25xa2tJS3FOWVpvSGlLQ3NMTzR4NTlWRWxiNzU0YXhR?=
 =?utf-8?B?QjlPYVZMcGVKS3lSMzM3TFRybDdNaks4RkU0ZW1nQldHWlUwY0JoTFFpQU9j?=
 =?utf-8?B?eTNabFdzUUV4NnVCWi9WMlUzS0JUczZtNCtWaTBZSXZNZkxQdDZwVE5Ec0Vs?=
 =?utf-8?B?QTB5Vk5DV2JXODBUNlNQVk1kcTV3UFNpb1BKZis2WmpkVTlodS9WUm91d2RC?=
 =?utf-8?B?R0ZNSzczbnR6VmUrUXlCTVZESVgwcEhKZktKdGlvTzZMS1VYRFRMVi9JbDBZ?=
 =?utf-8?B?ZmVLY3ZBSnhZOVVVNUdVTDdUR3BYcmE4RExpazY3ZG9xTllVOTJhNWN0dVR2?=
 =?utf-8?B?NExmWUl2ckJDMjVKWjB1azIwN3RvZFJXd2g0SmRIOEZxLzFtQWRvbDA3T1BM?=
 =?utf-8?B?UGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 72df68ed-8670-4b5c-097b-08dbc1193bab
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 18:23:52.3698
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KMORp0T5EGvkTGbpomBU9L8VpTf5Z2Jt5WjN/hLxDbI7+90GfzhTp3TiJWjK0KqyF0kFTibjVStqr9z/wOFFgF3/YI80gj9R6NoMS33OyS8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6196
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 9/27/2023 11:13 AM, edward.cree@amd.com wrote:
> From: Edward Cree <ecree.xilinx@gmail.com>
> 
> Add a new API to create/modify/remove RSS contexts, that passes in the
>  newly-chosen context ID (not as a pointer) rather than leaving the
>  driver to choose it on create.  Also pass in the ctx, allowing drivers
>  to easily use its private data area to store their hardware-specific
>  state.
> Keep the existing .set_rxfh_context API for now as a fallback, but
>  deprecate it.
> 
> Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

> ---
>  include/linux/ethtool.h | 40 ++++++++++++++++++++++++---
>  net/core/dev.c          | 15 ++++++++---
>  net/ethtool/ioctl.c     | 60 ++++++++++++++++++++++++++++++-----------
>  3 files changed, 93 insertions(+), 22 deletions(-)
> 
> diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
> index 229a23571008..975fda7218f8 100644
> --- a/include/linux/ethtool.h
> +++ b/include/linux/ethtool.h
> @@ -747,10 +747,33 @@ struct ethtool_mm_stats {
>   * @get_rxfh_context: Get the contents of the RX flow hash indirection table,
>   *	hash key, and/or hash function assiciated to the given rss context.
>   *	Returns a negative error code or zero.
> - * @set_rxfh_context: Create, remove and configure RSS contexts. Allows setting
> + * @create_rxfh_context: Create a new RSS context with the specified RX flow
> + *	hash indirection table, hash key, and hash function.
> + *	Arguments which are set to %NULL or zero will be populated to
> + *	appropriate defaults by the driver.
> + *	The &struct ethtool_rxfh_context for this context is passed in @ctx;
> + *	note that the indir table, hkey and hfunc are not yet populated as
> + *	of this call.  The driver does not need to update these; the core
> + *	will do so if this op succeeds.
> + *	If the driver provides this method, it must also provide
> + *	@modify_rxfh_context and @remove_rxfh_context.
> + *	Returns a negative error code or zero.
> + * @modify_rxfh_context: Reconfigure the specified RSS context.  Allows setting
>   *	the contents of the RX flow hash indirection table, hash key, and/or
> - *	hash function associated to the given context. Arguments which are set
> - *	to %NULL or zero will remain unchanged.
> + *	hash function associated with the given context.
> + *	Arguments which are set to %NULL or zero will remain unchanged.
> + *	The &struct ethtool_rxfh_context for this context is passed in @ctx;
> + *	note that it will still contain the *old* settings.  The driver does
> + *	not need to update these; the core will do so if this op succeeds.
> + *	Returns a negative error code or zero. An error code must be returned
> + *	if at least one unsupported change was requested.
> + * @remove_rxfh_context: Remove the specified RSS context.
> + *	The &struct ethtool_rxfh_context for this context is passed in @ctx.
> + *	Returns a negative error code or zero.
> + * @set_rxfh_context: Deprecated API to create, remove and configure RSS
> + *	contexts. Allows setting the contents of the RX flow hash indirection
> + *	table, hash key, and/or hash function associated to the given context.
> + *	Arguments which are set to %NULL or zero will remain unchanged.
>   *	Returns a negative error code or zero. An error code must be returned
>   *	if at least one unsupported change was requested.
>   * @get_channels: Get number of channels.
> @@ -901,6 +924,17 @@ struct ethtool_ops {
>  			    const u8 *key, const u8 hfunc);
>  	int	(*get_rxfh_context)(struct net_device *, u32 *indir, u8 *key,
>  				    u8 *hfunc, u32 rss_context);
> +	int	(*create_rxfh_context)(struct net_device *,
> +				       struct ethtool_rxfh_context *ctx,
> +				       const u32 *indir, const u8 *key,
> +				       const u8 hfunc, u32 rss_context);
> +	int	(*modify_rxfh_context)(struct net_device *,
> +				       struct ethtool_rxfh_context *ctx,
> +				       const u32 *indir, const u8 *key,
> +				       const u8 hfunc, u32 rss_context);
> +	int	(*remove_rxfh_context)(struct net_device *,
> +				       struct ethtool_rxfh_context *ctx,
> +				       u32 rss_context);
>  	int	(*set_rxfh_context)(struct net_device *, const u32 *indir,
>  				    const u8 *key, const u8 hfunc,
>  				    u32 *rss_context, bool delete);
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 05e95abdfd17..637218adca22 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -10882,16 +10882,23 @@ static void netdev_rss_contexts_free(struct net_device *dev)
>  	struct ethtool_rxfh_context *ctx;
>  	unsigned long context;
>  
> -	if (dev->ethtool_ops->set_rxfh_context)
> +	if (dev->ethtool_ops->create_rxfh_context ||
> +	    dev->ethtool_ops->set_rxfh_context)
>  		xa_for_each(&dev->ethtool->rss_ctx, context, ctx) {
>  			u32 *indir = ethtool_rxfh_context_indir(ctx);
>  			u8 *key = ethtool_rxfh_context_key(ctx);
>  			u32 concast = context;
>  
>  			xa_erase(&dev->ethtool->rss_ctx, context);
> -			dev->ethtool_ops->set_rxfh_context(dev, indir, key,
> -							   ctx->hfunc, &concast,
> -							   true);
> +			if (dev->ethtool_ops->create_rxfh_context)
> +				dev->ethtool_ops->remove_rxfh_context(dev, ctx,
> +								      context);

A bit weird here, but the idea is that you must support both create,
remove, and modify, so we only check the presence of "create". Ok.

> +			else
> +				dev->ethtool_ops->set_rxfh_context(dev, indir,
> +								   key,
> +								   ctx->hfunc,
> +								   &concast,
> +								   true);
>  			kfree(ctx);
>  		}
>  	xa_destroy(&dev->ethtool->rss_ctx);
> diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
> index 1d13bc8fbb75..c23d2bd3cd2a 100644
> --- a/net/ethtool/ioctl.c
> +++ b/net/ethtool/ioctl.c
> @@ -1274,7 +1274,8 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
>  	if (rxfh.rsvd8[0] || rxfh.rsvd8[1] || rxfh.rsvd8[2] || rxfh.rsvd32)
>  		return -EINVAL;
>  	/* Most drivers don't handle rss_context, check it's 0 as well */
> -	if (rxfh.rss_context && !ops->set_rxfh_context)
> +	if (rxfh.rss_context && !(ops->create_rxfh_context ||
> +				  ops->set_rxfh_context))
>  		return -EOPNOTSUPP;
>  	create = rxfh.rss_context == ETH_RXFH_CONTEXT_ALLOC;
>  
> @@ -1349,8 +1350,24 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
>  		}
>  		ctx->indir_size = dev_indir_size;
>  		ctx->key_size = dev_key_size;
> -		ctx->hfunc = rxfh.hfunc;
>  		ctx->priv_size = ops->rxfh_priv_size;
> +		/* Initialise to an empty context */
> +		ctx->indir_no_change = ctx->key_no_change = 1;
> +		ctx->hfunc = ETH_RSS_HASH_NO_CHANGE;
> +		if (ops->create_rxfh_context) {
> +			u32 limit = dev->ethtool->rss_ctx_max_id ?: U32_MAX;
> +			u32 ctx_id;
> +
> +			/* driver uses new API, core allocates ID */
> +			ret = xa_alloc(&dev->ethtool->rss_ctx, &ctx_id, ctx,
> +				       XA_LIMIT(1, limit), GFP_KERNEL_ACCOUNT);
> +			if (ret < 0) {
> +				kfree(ctx);
> +				goto out;
> +			}
> +			WARN_ON(!ctx_id); /* can't happen */
> +			rxfh.rss_context = ctx_id;
> +		}
>  	} else if (rxfh.rss_context) {
>  		ctx = xa_load(&dev->ethtool->rss_ctx, rxfh.rss_context);
>  		if (!ctx) {
> @@ -1359,15 +1376,34 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
>  		}
>  	}
>  
> -	if (rxfh.rss_context)
> -		ret = ops->set_rxfh_context(dev, indir, hkey, rxfh.hfunc,
> -					    &rxfh.rss_context, delete);
> -	else
> +	if (rxfh.rss_context) {
> +		if (ops->create_rxfh_context) {
> +			if (create)
> +				ret = ops->create_rxfh_context(dev, ctx, indir,
> +							       hkey, rxfh.hfunc,
> +							       rxfh.rss_context);
> +			else if (delete)
> +				ret = ops->remove_rxfh_context(dev, ctx,
> +							       rxfh.rss_context);
> +			else
> +				ret = ops->modify_rxfh_context(dev, ctx, indir,
> +							       hkey, rxfh.hfunc,
> +							       rxfh.rss_context);
> +		} else {
> +			ret = ops->set_rxfh_context(dev, indir, hkey,
> +						    rxfh.hfunc,
> +						    &rxfh.rss_context, delete);
> +		}
> +	} else {
>  		ret = ops->set_rxfh(dev, indir, hkey, rxfh.hfunc);
> +	}
>  	if (ret) {
> -		if (create)
> +		if (create) {
>  			/* failed to create, free our new tracking entry */
> +			if (ops->create_rxfh_context)
> +				xa_erase(&dev->ethtool->rss_ctx, rxfh.rss_context);
>  			kfree(ctx);
> +		}
>  		goto out;
>  	}
>  
> @@ -1383,12 +1419,8 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
>  			dev->priv_flags |= IFF_RXFH_CONFIGURED;
>  	}
>  	/* Update rss_ctx tracking */
> -	if (create) {
> -		/* Ideally this should happen before calling the driver,
> -		 * so that we can fail more cleanly; but we don't have the
> -		 * context ID until the driver picks it, so we have to
> -		 * wait until after.
> -		 */
> +	if (create && !ops->create_rxfh_context) {
> +		/* driver uses old API, it chose context ID */
>  		if (WARN_ON(xa_load(&dev->ethtool->rss_ctx, rxfh.rss_context))) {
>  			/* context ID reused, our tracking is screwed */
>  			kfree(ctx);
> @@ -1400,8 +1432,6 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
>  			kfree(ctx);
>  			goto out;
>  		}
> -		ctx->indir_no_change = rxfh.indir_size == ETH_RXFH_INDIR_NO_CHANGE;
> -		ctx->key_no_change = !rxfh.key_size;
>  	}
>  	if (delete) {
>  		WARN_ON(xa_erase(&dev->ethtool->rss_ctx, rxfh.rss_context) != ctx);
> 

