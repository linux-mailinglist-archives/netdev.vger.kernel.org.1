Return-Path: <netdev+bounces-15629-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 456C1748DB3
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 21:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35BB01C2095B
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 19:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B532815485;
	Wed,  5 Jul 2023 19:24:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF7412B96
	for <netdev@vger.kernel.org>; Wed,  5 Jul 2023 19:24:02 +0000 (UTC)
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7670B1FEF
	for <netdev@vger.kernel.org>; Wed,  5 Jul 2023 12:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688585018; x=1720121018;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=IjS5YzggG/E+SzIfz1ITbPNYMGdlSzIHjnnqebRQ7xM=;
  b=fjLBr+xqkbllYMdbdy/9xc/RCavXPxJIgAoqoe1nDEypv25QOUnSY6qs
   U77r4sn+Yd6RZzzDAKcmKmYPkAfEIk0+/n/9cDqYBZXAqumO/zzQpnMck
   lYZML09N9ry7nNEQY7Z1LpgaFJ/kl0aABFlDCJ3u/8sf1U89ElryAfitI
   Qf20jjrz8J1tkXDShO0RXjCXTBd/gG1eHUM19KlwfZyjA3xxsPsuAEW5A
   SQ39ttIEww+mY3XaeoGSj8HpfLYBn7MYu09tm3itg2YsVB2DMOwboCMZd
   ZEBSM11mN8MsTb+ou9NSvUP2rl1UvUDkHW/yakBfWLvPIe+a3+N3kYit0
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="348214275"
X-IronPort-AV: E=Sophos;i="6.01,184,1684825200"; 
   d="scan'208";a="348214275"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2023 12:23:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="832665198"
X-IronPort-AV: E=Sophos;i="6.01,184,1684825200"; 
   d="scan'208";a="832665198"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga002.fm.intel.com with ESMTP; 05 Jul 2023 12:23:35 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 5 Jul 2023 12:23:35 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 5 Jul 2023 12:23:35 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.104)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 5 Jul 2023 12:23:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bjM3qerRQPns0rpfQRzAEpdR9SZ06kMvDZ0k0/TOAnE5+ewScsG61oC+A4UOFM7Cf2HOv8ZIlqYz9L1oiw/4hDyaYGv4gIXgZvXcJBJ4JV3Jmlo2Mk0LYL/HokH4lrQrc0LYZ27IXQ+dbBt3umSB2sePToxb5jgS4xr1mh4MIWJbTq9xLeSmwY4NYbb9lVsJvm8IpCovXJ4swIrd/xMKn67E3EJaz4HMHdR1ViMyZNbjiAxRwqeJ2mXViD2NHd1csq7AmfQ5UmWzoy6OEuMX5TvfLj2hJiifkdI695OVo74l281/oSs5BmgpP0Shcs0W/V63/ffc9NdBhYEL1D8v0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GVcavU5jtELF1rG9ofOjslA6hzn4XriZKYWtvEmWQ/0=;
 b=DpHFrJT6GoQjsZPr+KLhs1fo4WpbDBa8IM59GPX1hW5SWGbI917APqgDs/MzI8WEKMjRddrF4doA7tdGat7YiZPk/8Yibi0DFKgd8FXzKRw26AoukYFz13AI6gyK6UPiZL/rkGlHBC2bJz4qdCHJctTM77S8IzgajDCZmk5cIspta1lmIOHmjs+BFi/pw6qmTKRE7mExcFQfwvJAbiMdfmLKrLE5uiUeeZBIBqp6k4aBoaGkdCvimxWCodW6kU96oiwHd77mDIDyMHLHTSmFK2EYeHEp0RSOzS5+nibJN9ClikV3MnscHY5yV8EzO8gx022M2REFyYXlVmdt7WtQ8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB2937.namprd11.prod.outlook.com (2603:10b6:5:62::13) by
 SN7PR11MB6751.namprd11.prod.outlook.com (2603:10b6:806:265::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Wed, 5 Jul
 2023 19:23:32 +0000
Received: from DM6PR11MB2937.namprd11.prod.outlook.com
 ([fe80::a5d6:4952:530c:f01f]) by DM6PR11MB2937.namprd11.prod.outlook.com
 ([fe80::a5d6:4952:530c:f01f%4]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 19:23:31 +0000
Date: Wed, 5 Jul 2023 21:23:18 +0200
From: Michal Kubiak <michal.kubiak@intel.com>
To: Saeed Mahameed <saeed@kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Saeed
 Mahameed" <saeedm@nvidia.com>, <netdev@vger.kernel.org>, Tariq Toukan
	<tariqt@nvidia.com>, Zhengchao Shao <shaozhengchao@huawei.com>
Subject: Re: [net V2 1/9] net/mlx5e: fix double free in
 mlx5e_destroy_flow_table
Message-ID: <ZKXDJhDNMjEPUzC0@localhost.localdomain>
References: <20230705175757.284614-1-saeed@kernel.org>
 <20230705175757.284614-2-saeed@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230705175757.284614-2-saeed@kernel.org>
X-ClientProxiedBy: BE1P281CA0125.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7a::9) To DM6PR11MB2937.namprd11.prod.outlook.com
 (2603:10b6:5:62::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB2937:EE_|SN7PR11MB6751:EE_
X-MS-Office365-Filtering-Correlation-Id: ff750761-1677-4297-d801-08db7d8d516c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TiATKnM+RlVArAjWhe2T7aandkTrbWtkhSO0rQW44uXy0i0ZgAHZX3aiVBiCvqB42ISmLpw0iu68j0HPVQlSMPAQ+3eLioUPh8y5udj8zPA/SHhuagxsuPPICHIF7hN2cIIfFAw6QBZEcAgqrXEsBy8+Rl+dtPxlRsV2iyOlbOUChcV8X0qzJjy6Dpv1gkp6fzL9iARSuFA/Mqfz5GwHiNVj+Ii4FIJ+MAQ9+QB1oGsu3hADB6+JGzgPHnUsieWgvoorkW4pOYfpVH4rMdizd3I69pl4YbbueLDPLahul7lkRZZ6SakRY5SIJlB4gKuEYhMdtztNFtFT3fZU3nrTWyqp/z8es4QecDtgE6DTQXnjyrVZI+zSQ455uu7zm+55pAU+N/m34Zr2zKLPLasoQoOanxC4diQxuOIJbc89+IHImQYCtv05j2RmmbWhxElmQnfQZYJVJHB6OsxNc5LC7d3h1R5jnL+ba2BMnPOkThJ00JW696Bn4lAEZ7tDFrAz6u3JIOEwITsXpcCBOq43vGDiBkImBhXAM+pl4Km2cV9dYfSRnHRc/9OKJ8z9WpoN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2937.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(39860400002)(396003)(136003)(366004)(451199021)(41300700001)(54906003)(38100700002)(6666004)(6506007)(186003)(82960400001)(6512007)(9686003)(86362001)(6486002)(478600001)(316002)(66946007)(66476007)(4326008)(8936002)(66556008)(6916009)(8676002)(26005)(44832011)(5660300002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mMIrT4Iau2wVWnCQBGBWTxcgTJ1vdjt33BSWutN16h8MTOQUPUV1rqIRv04R?=
 =?us-ascii?Q?BkBZr64M+7Ybqt/RbnrPCZajzuCoWOKYn02o5cBCUXQXssfxF6hw8LSdQy7R?=
 =?us-ascii?Q?6oVNdcVVS7YkJI5Fhmcc2B2qwE0A4Hy2YIwCycGoszlixPIDYV2qxWVObnpw?=
 =?us-ascii?Q?V8HXOSYucaMaEBnx8jl6ftie+r/7RTqk/jp0aoMOBxsgCRegkZ3zGc6CM568?=
 =?us-ascii?Q?dnPuJrjuUKEcML5Lk5UJESdiAkqYxwg0qmS7xyVf3BwpJPe+FvYidEx6/Hzj?=
 =?us-ascii?Q?D1shm1Z40rovv/9C2uxS/XJcgCwVwBdI7nJFEoOxXkwtA5W76dTghBYrv80/?=
 =?us-ascii?Q?cl/D332SUKWSyUH6vwrEpiaEOSWGpHiduSiU09ydgRqLQX6j4msSnMpNqng0?=
 =?us-ascii?Q?r6sHq0V5ecthR4a556lNWPtHdFGWw/aU/OQKlmufWa+83MlJNPbsUD4swes4?=
 =?us-ascii?Q?jWnv7QZ0PHa9PXuHIjvPjcDGeQcVbmGo6PhXOLCNgy9jcgkHu3GkUm7BlcUw?=
 =?us-ascii?Q?jPbOZVSdmK8ne8YA/k9FH1Lf5px79srQesbIKvQ9R9raLEVKXbzWyV/gL4wd?=
 =?us-ascii?Q?lP40TfR5MPcEQZ4+Wb4JAaPRHPZEac6h+6mYCFaPsPe/nDjFOBDqVpm8j0Ub?=
 =?us-ascii?Q?Jg9Kz9u0QN+TpM7jNRizJtVvQFnDgQDhg12/ZTPjDxXoofxTt64m+CRRD+qL?=
 =?us-ascii?Q?ydIhpoHNVQdeAiyhertGolFMJWNSB4af/5Bbpow4s+pAiH2VdqL5pgaPAdbv?=
 =?us-ascii?Q?YzLczZTVdWethhFGE8heJ3YBWXSgFEtc0mPL1bZXd/UKcFkl1BhQIaop6yUC?=
 =?us-ascii?Q?GgCcd+TgP0xq5JDrtN7YsD3Knnt+pri77cTmMeRHQyoJaS/opt64WAdxFcVf?=
 =?us-ascii?Q?KPe+Rulurrpw9Eyu2GUy2U1DNqEECqwdgsuC1NskW4XOQ77krZzAiZ1lPZDx?=
 =?us-ascii?Q?3yplgcI+XGqiSLdq8GcjenQAXYAOz2BnNTLNyfvoBi3AJhC8H/TQmMWx6Xpz?=
 =?us-ascii?Q?NiIFbQ4dBgpi0JmaoxYtgcZ4GJE6skOU9RuhD8vtYH1ktPrv+2B0hPLp9+ZN?=
 =?us-ascii?Q?7/kmHhgi3NXLPZCCEhh+rdckGBcdduLZRIpDSKQn0lGX3gvrAbZMuKLpCPhF?=
 =?us-ascii?Q?ebhaTnARPveoN6pnN93RxZa3slMrhbSDr5uINyz2fYpGtuuJfgkT24c7aYG/?=
 =?us-ascii?Q?Zxw3fMD4IJTUa54sW65vXfxw7Qh5nEXMc5vdq3AzZEQb6RwFu+td3X16hstn?=
 =?us-ascii?Q?bdxNXrTehnhyMbHIKbA79atbUdAkhPPztOTi5Y/1OIhEr76XQB/kwHpdQn/G?=
 =?us-ascii?Q?C1HTxCEY036lLpacw43yvbbloFCSw0k4p0jMoEZy1AuVEpUmwG7nedd5wwB7?=
 =?us-ascii?Q?bUBxjfa2OPsPvDOwhGL44E+GkXDArte+pIAwYc1H5kIiT5mlqBXcmeHSCxwn?=
 =?us-ascii?Q?2qxA1173N6FtaV6iOs4dezb67eUgNOYgnjAYuh1/2fDfGUBAC2oyRf4LVYD4?=
 =?us-ascii?Q?C0pTUKroB38vEtAcjLmFjPft5V/kQ8oJ64Bmp5Ylo0eaiHdwjmpWv9cXhKRK?=
 =?us-ascii?Q?WRJQZJKoz+gPzFWVgkrilNYuxiq4HKLLXJwZg0txKaLf+Sx+mVVtscLZ0xJM?=
 =?us-ascii?Q?Qg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ff750761-1677-4297-d801-08db7d8d516c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2937.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 19:23:31.4273
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FdIMeATrOBra1LnggZRZecBZJJkN6vaKJ5ieVSFhoRcyPuTI6NGTJkf8tkWhiXV7fbCy3TMMAYbpJhO2jLLnYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6751
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 05, 2023 at 10:57:49AM -0700, Saeed Mahameed wrote:
> From: Zhengchao Shao <shaozhengchao@huawei.com>
> 
> In function accel_fs_tcp_create_groups(), when the ft->g memory is
> successfully allocated but the 'in' memory fails to be allocated, the
> memory pointed to by ft->g is released once. And in function
> accel_fs_tcp_create_table, mlx5e_destroy_flow_table is called to release
> the memory pointed to by ft->g again. This will cause double free problem.
> 
> Fixes: c062d52ac24c ("net/mlx5e: Receive flow steering framework for accelerated TCP flows")
> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>

LGTM

Thanks,
Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>

> ---
>  drivers/net/ethernet/mellanox/mlx5/core/en_accel/fs_tcp.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/fs_tcp.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/fs_tcp.c
> index 88a5aed9d678..c7d191f66ad1 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/fs_tcp.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/fs_tcp.c
> @@ -190,6 +190,7 @@ static int accel_fs_tcp_create_groups(struct mlx5e_flow_table *ft,
>  	in = kvzalloc(inlen, GFP_KERNEL);
>  	if  (!in || !ft->g) {
>  		kfree(ft->g);
> +		ft->g = NULL;
>  		kvfree(in);
>  		return -ENOMEM;
>  	}
> -- 
> 2.41.0
> 
> 

