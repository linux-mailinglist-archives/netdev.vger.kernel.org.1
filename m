Return-Path: <netdev+bounces-51703-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA08C7FBC7E
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 15:15:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A59EB281D63
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 14:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C32745AB9A;
	Tue, 28 Nov 2023 14:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gxyBxQoa"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8962B5
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 06:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701180934; x=1732716934;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VuHISRW4TGusXCYfl4lNbv1YKcey7uKM5lWBvXbYwns=;
  b=gxyBxQoaWM3j2L3AdL/JZxotgpmkOylVc0axCLKdUAoGQJ7h5AmAOzDN
   8F7Nqxf8HiBOyNITVzSiWAJf7FZ46R86Y+oNuOkPWGRZV2bQyyANSwVzf
   5C6WKxRHHqSC6sQ3z98QeyeizYaoUzCn/PSn8kC9LFyD/gWrQrBwh+prf
   haDNVuBC0UPPMt1/oqdiAPR9xibYbK/bWJ+EbZR5MPkBczk4E+4MkYYkw
   /WFendEAm1Xvw0LdOEqp4pOxmK3RN+aUxPFlvLwHpyB/mp5KTPqU1sWJ+
   Q8TCpVKM3jqQBjjPdPY8mizTaRLz6bFZGz82HO5rlaXcE/2b9FxhjBwUR
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="395749487"
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="395749487"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 06:15:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,234,1695711600"; 
   d="scan'208";a="16948622"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Nov 2023 06:15:34 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 28 Nov 2023 06:15:33 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 28 Nov 2023 06:15:33 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 28 Nov 2023 06:15:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NZlvrgSa7cAvGQqY2FNqyzDagJY81NbXc8Hjd86Ag6j89lvfQ3fQhoLmxDZoRzb9LDviWjzAjW+5wP0tVarEgRvvl2Veyc7JPUrurJvIEgrb79KxPL44UC4hjuty71iDqegECbGASzhoDJbcWllGlbhaDBfT45ObyqmWTXAZKkiLdFovn9WxJNb1AahmbOXGsZSrshNGayKB5Kkl6jK4RedRO+VLl7gqUxX0B/7hQIrFugbJqFqqrdu/IUihFuirORgITmQU0xf6a888abp4zws8q84E8km4h+532AUXb0PpWIfePTLcnNUQn46axUAT+P9LRmxHZa0GI+/ZypNFcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YC3dK5+oKp4uFawO2g++093xiABc5NK73LT82GJV+6Y=;
 b=AoNvuKIRGFiFhFNxQZXtZSqLqZ5GBOLmsQE9XhzGUIh9EeyxfWCbp6iqBGtEjdH8zCnu+TWbWFETcSLMHdc647CTtsSNb4URJfiQ54IxLXG96skgcWA5aHpb4mA8B/mt6+qqm+jQE1JTzIG9k+NbsBOOrHBbvZdNPtcFfksjF18GUqoaP2IRBLhxc2bIhf5bj+bMNKhPxm9bu0+yNtygEZUVJ9Bx1MHNLSk9EcQsTdtZo9gYhtWi/OkpjRj0IiL/MmbZPLUERl5OOgf+dQtk94LNnf1TWP8LTxibt2kUN9SEwP+pzfmjM9BafB8IAThNOWm5U3nnbLe+aIv3Uc1vCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3672.namprd11.prod.outlook.com (2603:10b6:a03:fa::30)
 by CH3PR11MB7203.namprd11.prod.outlook.com (2603:10b6:610:148::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Tue, 28 Nov
 2023 14:15:30 +0000
Received: from BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::5112:5e76:3f72:38f7]) by BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::5112:5e76:3f72:38f7%5]) with mapi id 15.20.7025.022; Tue, 28 Nov 2023
 14:15:30 +0000
Message-ID: <6b0dc84f-dae6-3acd-5ee0-1b51e7abf5af@intel.com>
Date: Tue, 28 Nov 2023 15:15:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [patch net-next 2/2] devlink: warn about existing entities during
 reload-reinit
Content-Language: en-US
To: Jiri Pirko <jiri@resnulli.us>, <netdev@vger.kernel.org>
CC: <kuba@kernel.org>, <pabeni@redhat.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <jacob.e.keller@intel.com>, <corbet@lwn.net>,
	<sachin.bahadur@intel.com>
References: <20231128115255.773377-1-jiri@resnulli.us>
 <20231128115255.773377-3-jiri@resnulli.us>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <20231128115255.773377-3-jiri@resnulli.us>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0103.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::19) To BYAPR11MB3672.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::30)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3672:EE_|CH3PR11MB7203:EE_
X-MS-Office365-Filtering-Correlation-Id: c0f59ead-341b-4cd5-2b8b-08dbf01c7a40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9gyYIBsISUPKB+++gBGT2YXB4f8L+P+FvglTFUSB0IF0Ir0b1OdN/rZU6WQEpgJrPF+cw9jPoI0HoO4dWgsLvhX/WjrMbRlYvwYo6y/33ENzH2e8zJgmf0pCUb4RwRYbj9e1W0Qe7R7ZLoNBIArM5NSqKvRuoKc5ZeruUbUjTcnlqMrCVhhkbVGYcJyS0q+0lcLWtjS0/zaQzmsBO4WRaKCDg10mLW8k06P2V4bwOoW8wms1umo7a4Yiw8hAfZ0H980VqAJ+NXrCCYowN1DUneJmmo5476Lw+wWfLH+UUvuPJDCFRYkyTfpiweADjzMpgc0Fc6jHSM1HegD2giDOkxDm2eniKmxTwgBbuKZuF08rdTTlis09Fe/BjTPtWqOcdST/x0W+E+iH1tvxCbIApHltG+Ro1px5i/TmiomaXT2477kMoIo0XaAyHRLTNP9kVaZK2SYRrfQBiq7FT0wooySldF6X+c8Rh4S4vyP1WoaQNNWmm9gO6L1XD20u1+JbVChvgdQqBEvutTPd2MdG5Rhpus2EcKVIeHIRJ09zKXv/VDvqfftRfBdF0gbuxITwK7QqWC7Okv9n66FoJ+44u9fCpioK8LbSHilwLtP1+ePxauVE/Hlp+Qy7L600BVJ0Tc20jXdbfS1jWP4DiAc+t5iDguOUuJ/fpHVLu7QZja4rX1ntMXHlahU/ll6nBGPVfQMutYxLTpPNWs1eQ+RRwzEojVxDmDLw+dv4W/c/94A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3672.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(376002)(396003)(39860400002)(346002)(230173577357003)(230273577357003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(31686004)(41300700001)(31696002)(6666004)(86362001)(5660300002)(2906002)(83380400001)(66476007)(66556008)(4326008)(2616005)(36756003)(8936002)(66946007)(8676002)(6486002)(107886003)(53546011)(316002)(26005)(6512007)(38100700002)(82960400001)(6506007)(478600001)(43740500002)(45980500001)(309714004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QkthZGVBOGpPUDFMNW1DNUN6T3lUWUUvcUVoajliZ1ZJNlcxQnd2VDI5ZnBF?=
 =?utf-8?B?cUY0Z0NqT1U4Mlo3Vk5yQmtvOWNSY1hvODFzR3RUQzNtSnhmdXJQNHppN01N?=
 =?utf-8?B?aXZlMytQem5FLzArUnY3NVpCMk5FNlYyRVk3eTVaaXNpdFkxOEJVTWJWWXlE?=
 =?utf-8?B?T0YwRy9kUEI5RTZ0cm12bm5wNGpEUXVpM1NXWlM3UXM1ck9tVlBNL1pzRkJu?=
 =?utf-8?B?ckpnOWpsVDZCUEpJVkk5Yjl5M3gwUDgwSzR5NytWdXM4OXVYcC9lZHJNZ1or?=
 =?utf-8?B?NkswcXVnNTdyeW43OFpuVVFUcTVIZ1lFOGY1YXgybWkxZFlCV3RVM3luZmw2?=
 =?utf-8?B?ME9ZdS9vVVFlMEN1RnRYQXRmRjZlM1NsTWcvNjdQbE45NDhkS1MzdUNnNGJE?=
 =?utf-8?B?eHY3VkNIZEZsMnAwNWtBSzVPb2UxbmJNbFBaQ0psTDMyanFqam9TTnlSOFFi?=
 =?utf-8?B?d285b2FRb25QR2dGS3kxMWpkbFUzeFhMM1lRelJ5SnJtMWVsWGttQTAyVklh?=
 =?utf-8?B?M0NnQyt2UTdrV0NFankvaE1YdEhGTEVqcGppZUJRSFZlc2xIZjc1RFNnVVFq?=
 =?utf-8?B?cHdFc1EyeGNWVkhKZ0RpVytrdGVNbllqb0dKNHFSaExjSHd2V3N1ZjZlR05I?=
 =?utf-8?B?d2xtdWtraEkySmlmVURLS01EK1V3N2s4cnU3M0haVVllTXNsWEx2dU81dnA0?=
 =?utf-8?B?NVdtN3MrbXAwSi9wajdKZFVlZUdacEdhRHU5TUFybW9FVDBNQk9obkk4RitP?=
 =?utf-8?B?WmdvV3B1WEs1WUsxemNBU3dZeUpXRm44RnBKaG9QRmF0NnVwMlorMzNCN0lS?=
 =?utf-8?B?ZzN3cXBnVSs0bGdXa3ZnVlozOThjZ2EwUmpma0k0VitrYStkay9SY3pXelhF?=
 =?utf-8?B?dDdzU09GdTFVaEJiZnQ3S25rUWQ0YTZwZEZkelVUb2x0N0NNRyt6dkhYa0Np?=
 =?utf-8?B?RTBydWxRKy92cDJ2V0FUZWJGLzNXVE5sZkhVNTVLMkxYbnFGeFIwNS9FUGNp?=
 =?utf-8?B?Z04vSlI4c3o3cHdMN2ZJOExlUks0R3pFYnBtc2hVeEh5Z2lNRjlqMU54R05w?=
 =?utf-8?B?ZVhPV0lhOEYxSC9DK2huVEwwbGJqOWxkVnc4by9vRjFEZFUrNzBWKzAyTmov?=
 =?utf-8?B?Uzd5RVc4NkMwbUdBbmM4OFBZZ2VrODlJNWFPNUV0eWJ3dElVdVQ3Mkw5aTA3?=
 =?utf-8?B?ZXRHbURIeCt4N1NRdk1pSkkvSG1LVXNBNzZoNU9SWk5FaVArTFBQYlA5V1dJ?=
 =?utf-8?B?V0ZwZW9xNTQ3bjM5blF1ZjF4K3N3azdvMG1Ca2FLeURjRG1DZzNvalhVK2Fx?=
 =?utf-8?B?TnlRc0RrTHBnOEVUSTlOMGtIV05sTlpmajhpSFJ1VFBHRmh1cVgwWHVHeG41?=
 =?utf-8?B?YVJlbHVybk90OWJhUW9DV2NWcmJ3VWNwWGtCYVFjQmFpbEEzTlpuUDNkaEdN?=
 =?utf-8?B?bkhONU05OGhtenNJRUdnemFRbkJJTUFSaFJQTW1udkhKdmw1RHRMVUNCbkU0?=
 =?utf-8?B?bEVnZ0g3YXpVSC81a2RLUkJkVisvQk0ycGNXaUlqMllUVkpyL2FuZFVRK1hR?=
 =?utf-8?B?NW00N2x0d0tPOUVhUmhNN3E3Q3Y2MWl0My9SbytHQ2FzUWRubEZhOEh4NnRH?=
 =?utf-8?B?cGswczdTdE15K0l5RndEbVVCM2FscXhLOUVpeWo1eUsvNjhDZ1BFVWMwN2dw?=
 =?utf-8?B?VlZLYkxvVVBYM2s0OEJNTlRiTk9CbE95a1FHQUN6SkdRaGIySzdHZnhoQlFJ?=
 =?utf-8?B?OENJWWR4TVBxNEMyUFpDZVpqc0hreXFlN0Iwcko0UDVldVF1REhSMUJJd2c0?=
 =?utf-8?B?ZFJZN0pqNjRBS0lUQ01CT0N5N3dRZTdwMEYvZnRyME9tVDMvb1g5YWZDeUJP?=
 =?utf-8?B?Q1FBSFkzWG1YYXovUDF2ZzFXZnF1R0Fwb2VmRTB6SEdJaVg5Y3kwZG10M2Zk?=
 =?utf-8?B?dFN6MjZjODR2QW80YmNRVEFpZktTL09hYXIzK2ljeHZMUERhcFAxNXYxUHZR?=
 =?utf-8?B?RDlmRGRUcXQrWXJHRFl1RG1TMU9hMkU5MTdyMVg3OEd1cWx3amt6M1RDcGJ3?=
 =?utf-8?B?bWRHa3F2SExYaEs5cUtXRWsvR0VQaTA3dkhRRW9sMHJPOENQNFNDWllxUHB2?=
 =?utf-8?B?RUd6dGxtTC9mZ1dXQlZFMHNpNjZ3NEY3dGFqTzkzcWg5ajVPSjJkQWlpd1NI?=
 =?utf-8?Q?IVZ6yAZ15x6liWU53cYQgWE=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c0f59ead-341b-4cd5-2b8b-08dbf01c7a40
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3672.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 14:15:30.6668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MGvdRtiqcXezi73eViZ+nmDJgVkagIBut3ea/Q1m9c5rXo2CJN2m/U8WFffDh+IVj1RoyQWY49AhyUJCPTlWbBps9kS3zI8NREaJyGLq8Qk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7203
X-OriginatorOrg: intel.com

On 11/28/23 12:52, Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> During reload-reinit, all entities except for params, resources, regions
> and health reporter should be removed and re-added. Add a warning to
> be triggered in case the driver behaves differently.
> 
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> ---
>   net/devlink/dev.c | 16 +++++++++++++++-
>   1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/net/devlink/dev.c b/net/devlink/dev.c
> index ea6a92f2e6a2..918a0395b03e 100644
> --- a/net/devlink/dev.c
> +++ b/net/devlink/dev.c
> @@ -425,6 +425,18 @@ static void devlink_reload_netns_change(struct devlink *devlink,
>   	devlink_rel_nested_in_notify(devlink);
>   }
>   
> +static void devlink_reload_reinit_sanity_check(struct devlink *devlink)
> +{
> +	WARN_ON(!list_empty(&devlink->trap_policer_list));
> +	WARN_ON(!list_empty(&devlink->trap_group_list));
> +	WARN_ON(!list_empty(&devlink->trap_list));
> +	WARN_ON(!list_empty(&devlink->dpipe_table_list));
> +	WARN_ON(!list_empty(&devlink->sb_list));
> +	WARN_ON(!list_empty(&devlink->rate_list));
> +	WARN_ON(!list_empty(&devlink->linecard_list));
> +	WARN_ON(!xa_empty(&devlink->ports));
> +}
> +
>   int devlink_reload(struct devlink *devlink, struct net *dest_net,
>   		   enum devlink_reload_action action,
>   		   enum devlink_reload_limit limit,
> @@ -452,8 +464,10 @@ int devlink_reload(struct devlink *devlink, struct net *dest_net,
>   	if (dest_net && !net_eq(dest_net, curr_net))
>   		devlink_reload_netns_change(devlink, curr_net, dest_net);
>   
> -	if (action == DEVLINK_RELOAD_ACTION_DRIVER_REINIT)
> +	if (action == DEVLINK_RELOAD_ACTION_DRIVER_REINIT) {
>   		devlink_params_driverinit_load_new(devlink);
> +		devlink_reload_reinit_sanity_check(devlink);
> +	}
>   
>   	err = devlink->ops->reload_up(devlink, action, limit, actions_performed, extack);
>   	devlink_reload_failed_set(devlink, !!err);

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>


