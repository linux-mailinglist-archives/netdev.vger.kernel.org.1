Return-Path: <netdev+bounces-50018-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27AC17F444F
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 11:51:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 588E61C209E6
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 10:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA304AF82;
	Wed, 22 Nov 2023 10:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UA2OFFrW"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEC66BC
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 02:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700650263; x=1732186263;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VpPEQv0Jpb+HZhiXBbSBrGOYwQOJd7mSZhZgOHSxkd8=;
  b=UA2OFFrW/Pm662fzUqoBMdZ9DB1VBei38/vBAFcCD6SC7bhFJenWdpOd
   VvntPSpVTwU9xIEJQ9tGG8BOSGHxEW5OhxPnwV9ccTlVq3QP1fyo1w6MU
   F4SnRYEMVm+2FPQs/R51Bx6CFE2ijkzjYdM2gQkkjV0pOQ9KoMHcR8Jg4
   GYdKYpxW1SS1SBTXS+pGwJt8j2unuOrvPGWeakdmFzPxvlLbxrDPoDTlg
   wgBrbSj8TvkFoSVuxdjv20xODQAuidInjSVNaJmL1txJ4GExutHt48U57
   66ZRUQf+fGMiO/Pvl6Z29Yssh0+KyqCAnDYk+sMvxgKLPaRpL3HrQ+iGs
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="377060166"
X-IronPort-AV: E=Sophos;i="6.04,218,1695711600"; 
   d="scan'208";a="377060166"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 02:51:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="910751921"
X-IronPort-AV: E=Sophos;i="6.04,218,1695711600"; 
   d="scan'208";a="910751921"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Nov 2023 02:51:02 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 22 Nov 2023 02:51:02 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 22 Nov 2023 02:51:02 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 22 Nov 2023 02:51:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YGSCXjZowbUTiUD18xx6iNFa3yvhUdLSAYP4MyN9QsdoihVoCt1Te7xyLXycH5OWZnYzr1ux4RUdLOIPWd97IxjDiiAUDL+AEJzfbm6tI5eikoU0jj70eC8uAhn2PCuuVTmiKiepkxPm8K+elcamvyWUj87mqrb/4y6JFaw2af/BpAZ9un5lbfZ2doh6iTy8zaJI83fG+XCq0LfGd0WtdoNvcP8YhJUP8W3nCytoDS0Tlcb6jIjFRDl8/ygVFEIwKlFhOhXnuhTaytYcdffSqwhxJW4QVsCbVcwzlYDlMx/6sinaaIGk/AkvkrQgiN3Te46/34MN2ABU2sx9VriGTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=feRuprbVGgazO8atKnHZ5zYndADfS3bFNVV73tuNlx8=;
 b=m9c9DgMaJtiAP2ZM4QVgQ6RqMjP5P4RWVaWdYtMnHtYxXkOMVZvyDCvvprHa1Mn4aRZtp1MYlVf3lPVjvlsQqgbZuLHb2MjKmNcUIXgXILNWKL4ejJ07TMwEpT47ZDi/Pcv9f83k+MqytNwzArvHRTo1padQ9bYGmkNH7EwKymmpU/I6RFhM01H3vjRUnfkaI1eexag2HfvPpwOXLU/TGLY9dNQ9VSgYXyp9VZ058aiCc31cgGWyhIjawnzt/c1GfbET6QASw3JQiB8EEhHR9IugbylUaRMz1hZMXvT6ZkHYVq9xbam1MKzfBvbxBxJOoh1aj0DmHV8FQyTvsHvKAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB5776.namprd11.prod.outlook.com (2603:10b6:303:183::9)
 by DS0PR11MB7971.namprd11.prod.outlook.com (2603:10b6:8:122::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.19; Wed, 22 Nov
 2023 10:51:00 +0000
Received: from MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::49fc:ba56:787e:1fb3]) by MW4PR11MB5776.namprd11.prod.outlook.com
 ([fe80::49fc:ba56:787e:1fb3%7]) with mapi id 15.20.7025.019; Wed, 22 Nov 2023
 10:51:00 +0000
Message-ID: <8edf68af-f911-4c3f-ac37-9a9cfc820b50@intel.com>
Date: Wed, 22 Nov 2023 11:50:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/3] amd-xgbe: handle the corner-case during tx
 completion
Content-Language: en-US
To: Raju Rangoju <Raju.Rangoju@amd.com>, <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <Thomas.Lendacky@amd.com>, <Shyam-sundar.S-k@amd.com>
References: <20231121191435.4049995-1-Raju.Rangoju@amd.com>
 <20231121191435.4049995-3-Raju.Rangoju@amd.com>
From: Wojciech Drewek <wojciech.drewek@intel.com>
In-Reply-To: <20231121191435.4049995-3-Raju.Rangoju@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: WA1P291CA0007.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d0:19::11) To MW4PR11MB5776.namprd11.prod.outlook.com
 (2603:10b6:303:183::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB5776:EE_|DS0PR11MB7971:EE_
X-MS-Office365-Filtering-Correlation-Id: e68b100d-e4dc-46a4-696b-08dbeb48e9e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f5SzY2AmCJ5F3kQYPJtVA1OrEaD+dJiBvxYCQ0Ue6QtH23FTBOA2GhqQ61RKqBN/MNKWvpF+sbFNKenVQ/LuTMxCjzaVQBKknI7UMZp/Oe68hLCdxJH5PCHfCqEGQGpVkRQzhkb93CQjCyNvaLbQyQHwOSpCJk3Wz66VcVLlrmWTSX/KCUXLNVW63hVtT00PZ7QyINUHvj+MRUQW33ywuQTPJnr7CKh7eH5wW+6teLn2KjJOsHP1v2e9I1a1GxuR52LHg2RBI1m90XLfdi1t7pNvVn7FzhfwCLQ7OV/R+0huiNsjKacZg8UFQtrNQ+LZSGRx32dEdvHlBaGdMYhOjeRQBg6RPCVSJ52iQ3EiPO5tHi8r4oa6rZUNPzjwNBJb6qWYeXTfqrqQmDzNRgZIou31PvRhkpLgNfvARZuvHoh36wftkoUTQAJz1LDLcwr9yVyy5W9Rd7nh0NVQcdadwh+KB7Ydad6kwDOp6BBf45f9p2hjhiw7mS4nnfYKQY/hiv/j/rcacppkuaKym1P0jKpdGhVO3MCH6Xqn5j8Js5wOrcEBV7sL8YtkFE9ieDwBdEpGjiIEJfDNo6tCKNIj4BiCunSmXGGlq5pzqwE3U/VCmm40pVJ6Sn3QkMlOJZkXG1rIb7J9HeyrwLiA3ih0LA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5776.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(346002)(136003)(366004)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(26005)(83380400001)(53546011)(6666004)(6506007)(2616005)(6512007)(44832011)(5660300002)(4326008)(8676002)(8936002)(41300700001)(2906002)(6486002)(478600001)(316002)(66476007)(66556008)(66946007)(31696002)(86362001)(38100700002)(36756003)(82960400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WmR0c1gyUHdLcTBVZVNiRVl3M1pyV2ZZVFNTelAyMVpKeldkcUUra3I2azVV?=
 =?utf-8?B?a0xYalpCNWhYQ0dkL0gvYTZzOUowK0V1cWZMUTdKRXMzVUJmNWdwSDdpdFJS?=
 =?utf-8?B?ZUJhZnF0NTNOK01OQi82YWdzdWZLT0g3RnAyb3ZHQVlNQmhLVmdlclphT1p6?=
 =?utf-8?B?THpIMVByeHlyL3pMSnZzWm9LU2dpV3I0YjlLbVJmT0dpWG5FM1lOcTdCOTVC?=
 =?utf-8?B?bFJqSUZ0RldXVkF5TEpKTTJ3Ym9oWFNpMHU5TnhYWWlSeWVUdTFuNmM4ZFRr?=
 =?utf-8?B?cDhiYitTbk01M0JKbnpjY0JLZHkveVpZSEorakc3aGI0dDJWbDIwOGg2NWM4?=
 =?utf-8?B?T2JYeXM4MUN0YjV3YWZNYlRWVUxmQVZCWndwK0xTbGxGQ1ZRcUlYcHZwZldW?=
 =?utf-8?B?dldVMVFjY1NzaWV4NGFFZTdNSUV3MGUvekhUbU8xcVljZ1VHcXRsanluVE9s?=
 =?utf-8?B?c2N4aXdPRjZVWFNCMU1EK3duaE5lLzUvdzRhVnp6ZGk3Y1RMcVJBQ2lVZXlT?=
 =?utf-8?B?ZXh4Vk04Sko3OWQzcUVvTjZxd2hzRWNMYXR3VGJUZ3dteW4xZUZwTDJmSVFU?=
 =?utf-8?B?OU1rUm5sWWgvMVpuUExwVHFPMWlOQTllN2NBd3VoUUZFRjlPMjg4anR5NExy?=
 =?utf-8?B?L1MvVythODkreTdSWEF4Sy8rMHA5MEJYem54RUtPMWNKdm1TWVlwV3o1MXdK?=
 =?utf-8?B?US83eE8yYzV3d09YSkdmRndRZlZmcTc0cE9Md1ZXdVVaSDg4NUt1b0pTSFV6?=
 =?utf-8?B?WHhPREdPaHcraFArWVJOOVJLWG56U05Cdk5lblBlQzh4Z1FlTjRkbzJ4UWtE?=
 =?utf-8?B?S25NSSs5aXZuT0JxUlpVY2ZmZFBWWWpCYjdrZEhNU2pHQkd5VnUvakJFb2dm?=
 =?utf-8?B?VkY5Wjc2clM1YXhRL3pRM2lwN3E2Q1FwOVNBa1ZsL0JFeUlIR2xMN3dEejdQ?=
 =?utf-8?B?MWkvYUJoeXdUN0RFRjh1RUI4RW1lUlp2anA3TnVPWnFPZEJJemVjVk9Gd1dl?=
 =?utf-8?B?K0FKNWN4dmszMVZodEI2R3g0WGxqT3pUMTFpV2Z4TGFLalRsRkRrTXpjOFhH?=
 =?utf-8?B?di94L0tUdCtTc2dVeTJIRXpUZGZkTG05SWJxcjVheXMwRXlQTEJoaHhoYm9V?=
 =?utf-8?B?TlhncmVBV1kwZmpZNXdNNGJ5NnpoUjdRTTVQdHIrdTNPb213NlUyOFc2UzlN?=
 =?utf-8?B?dENGM0lqQXR5VEpoWXRLalp2TWF0Z3Z2bkl1YXN1RHRzVERweC9vVTZYcExh?=
 =?utf-8?B?aUQ3ZWFHZVNmOW12YmwxNnJ5VEZRb25PVlJwN1lrZnVKb3U3OHh0TWI0enZa?=
 =?utf-8?B?eHlHS1pBMGJhSnNhejAvdndMOEFhb2EyVG10QlpqbGRaMmY0ODBYVmU5MC83?=
 =?utf-8?B?YTZYNzJGY3dZMFI3K2wxRjB4d0daeHZSNFg0NHVQRVhDUHJrM0VYTGhaRDFa?=
 =?utf-8?B?bm85Q0QvclFIM3NUL0x1NkxBRnVERmpvK2swcmg0UUxoWExzdkg5TGlJeVdq?=
 =?utf-8?B?YndkS3dUcWFtb0NEV0xaQzBiSkpuTk9rVmJzbWVxS2Q4b0pMYnRDMEs2NW12?=
 =?utf-8?B?K2JsR2x6ZG5RcytLdG9FQlorZ0xuZVVGQmgvbzVHV3FSODdiQldqVWVxUkhP?=
 =?utf-8?B?V1E3WUl2TGxrRDFwckFhL2dFbVIxQlRhbXVjTUtTVm5vZnY1eTc0dVIwcmVD?=
 =?utf-8?B?YjEzeTJmNUQzMHFkSmhhVjJKQUI2WVF3MFVxS2pSRUQ1YS9VZi9JOUZZZzE2?=
 =?utf-8?B?RFRxeW8zaTV4aXV6eUI0OFlhazViYnlpaDczOUhNVmx0S1lNZzhJTVB4RXJS?=
 =?utf-8?B?MjdKQTdzWjlYTjQ3ckxtakE1cHM5eWUxUjdWZU1lY0dQbDV1dy9lV3hhR0dR?=
 =?utf-8?B?Q2Ztb0J5SHZZNE5KemVvUEg5b1h2ZllTVGxibk15K3cxNkZvT3JNMzY4WmUr?=
 =?utf-8?B?NkpFdmdFM3F1WWhlWDZiOER3Q0xWdUE1MEw2K2l2dWwrZjVJTlN6ZEZnbWhS?=
 =?utf-8?B?L1lMM2xWMGU4L3ZEN0RKcE1QNkhRNm5LY2JwUHhnTllJZGw1d3pNUms1SEZT?=
 =?utf-8?B?bkEzcEo3SGdHQ04zVktFMlpidlNrZmNpV1dqNk1tM1JNek12REdjdkNEOXA2?=
 =?utf-8?B?RU5GT3lkNVFidXpaOUM4aUlCRTV2bkJHQk1qVDRZUllmZTA0a1dtSHV2VFFH?=
 =?utf-8?B?WkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e68b100d-e4dc-46a4-696b-08dbeb48e9e1
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5776.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 10:50:59.9458
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TYMcptpOqbmGdYc56owfd/hztQQ+7obZAhsvZmmSWg8Xt5lYiBq0jGlkrMyzBWiMYkdh1QUnztNngQ4hfIcTuhzjoW4cRwzz/QDqycXlLeA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7971
X-OriginatorOrg: intel.com



On 21.11.2023 20:14, Raju Rangoju wrote:
> The existing implementation uses software logic to accumulate tx
> completions until the specified time (1ms) is met and then poll them.
> However, there exists a tiny gap which leads to a race between
> resetting and checking the tx_activate flag. Due to this the tx
> completions are not reported to upper layer and tx queue timeout
> kicks-in restarting the device.
> 
> To address this, introduce a tx cleanup mechanism as part of the
> periodic maintenance process.
> 
> Fixes: c5aa9e3b8156 ("amd-xgbe: Initial AMD 10GbE platform driver")
> Acked-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
> Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
> ---

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>

>  drivers/net/ethernet/amd/xgbe/xgbe-drv.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
> index 614c0278419b..6b73648b3779 100644
> --- a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
> +++ b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
> @@ -682,10 +682,24 @@ static void xgbe_service(struct work_struct *work)
>  static void xgbe_service_timer(struct timer_list *t)
>  {
>  	struct xgbe_prv_data *pdata = from_timer(pdata, t, service_timer);
> +	struct xgbe_channel *channel;
> +	unsigned int i;
>  
>  	queue_work(pdata->dev_workqueue, &pdata->service_work);
>  
>  	mod_timer(&pdata->service_timer, jiffies + HZ);
> +
> +	if (!pdata->tx_usecs)
> +		return;
> +
> +	for (i = 0; i < pdata->channel_count; i++) {
> +		channel = pdata->channel[i];
> +		if (!channel->tx_ring || channel->tx_timer_active)
> +			break;
> +		channel->tx_timer_active = 1;
> +		mod_timer(&channel->tx_timer,
> +			  jiffies + usecs_to_jiffies(pdata->tx_usecs));
> +	}
>  }
>  
>  static void xgbe_init_timers(struct xgbe_prv_data *pdata)

