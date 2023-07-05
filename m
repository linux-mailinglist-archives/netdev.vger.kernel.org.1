Return-Path: <netdev+bounces-15638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99891748E60
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 21:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F14862810BE
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 19:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4BC8154B8;
	Wed,  5 Jul 2023 19:53:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD73154A5
	for <netdev@vger.kernel.org>; Wed,  5 Jul 2023 19:53:17 +0000 (UTC)
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 481411998
	for <netdev@vger.kernel.org>; Wed,  5 Jul 2023 12:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688586794; x=1720122794;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=x+1op9UkD7M4ynXONbk/cRcmABdJiZKWi8dtbW9RDB0=;
  b=GPJjPuwTL9aQVlgWrTjQuHg1xyt1OFF/s9zyLCfzqVJiyvtjK/NkpmBM
   3ZdvdbobxRYJe7tKWDVqN8Nld2eYaSduWmRpkQyIIW35F2v8ExD+UnHft
   ykWDvUvMiUDJM7Vs4N7AQGLvv3JeXpkmhLy8cJn9dL/Ea7Mxehj0Ifxz9
   vS+RAP58dvtUE8FT4G2Sw63Thu1JmBLLjcc2l57mZq0SB4iUQoSQ5gicP
   tk4W/rncEoQx8vT2t7/V1e01SgG06aZxqGMFpxzQtNYwvUZC334uZ0HlY
   cijIv02YCc3gyEnb7lU9r+aqjF0Micj3ywKy183G4LpcGcJgPGCDAwLGL
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="360902232"
X-IronPort-AV: E=Sophos;i="6.01,184,1684825200"; 
   d="scan'208";a="360902232"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2023 12:51:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="713299142"
X-IronPort-AV: E=Sophos;i="6.01,184,1684825200"; 
   d="scan'208";a="713299142"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga007.jf.intel.com with ESMTP; 05 Jul 2023 12:51:12 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 5 Jul 2023 12:51:12 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 5 Jul 2023 12:51:12 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.172)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 5 Jul 2023 12:51:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aBt/1rhKTX7stCEHdYwzNQUeig3yz5D1fzTELB1dI5VemExNR4Oc18POZjm3Vli3K3SoWScWLtzyrr3Yyj2f/KIVDklNGzAjZANw/7Oqmho7TSFVm2oNCpUVXk9OHP2SAwoUUewmOwGcIk1MIRmutE9S1MJJq0sD/7wpjRJ1EwCHONYNJN1c91cBW+pb5rp165u6tpB7q8VRHvPnbp7x6Llm3r9m/q3YqVHRHth5Xd8Hd2DNzFrHdOImKMrcCfpNysuuX4dVlh6RVZ2Bl6GannC3+UDJm+9LiDdU1qKO+O0S/pzhObvsXDRCVhLTc4PSYvqErNF/Ml4NWkUoe24ZZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gQnIYx8lt+5aLem6OaQDnYwbmuUDgg5S5QuTSsZp6KQ=;
 b=Lg/spfKt+ydYXbiNveitPQT6r3vtMhNE7Ig/aaLAoYZsiFV1CnziAyDBze/y5MPUYbHSAXAX/aQbKQAzrtEWIZjGUbdFtUHipMi5olOGyM9zmu+q7FflZj6m/9cKmY8dLCp8wxEXfAATSBF0RrZU9AFC8IgoJeD3gYjZacf5MTQlixv0UTqdF6XgKACzB6/ZLDjKRNCbuRXbscvzyo/2vgnHJpm8ppxqWzsem6ELfWCJ+3f4ffaajsTRbWd2sqKIzEpZLN+MaRx+PcKgBN5PowG7uBye8hqusMGYeLKHdhD78Vrwel81rUUQDaaMSpxMTSPS4Zld703Pp3Pn0pcNqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB2937.namprd11.prod.outlook.com (2603:10b6:5:62::13) by
 DM4PR11MB6238.namprd11.prod.outlook.com (2603:10b6:8:a8::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6565.17; Wed, 5 Jul 2023 19:51:10 +0000
Received: from DM6PR11MB2937.namprd11.prod.outlook.com
 ([fe80::a5d6:4952:530c:f01f]) by DM6PR11MB2937.namprd11.prod.outlook.com
 ([fe80::a5d6:4952:530c:f01f%4]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 19:51:10 +0000
Date: Wed, 5 Jul 2023 21:51:03 +0200
From: Michal Kubiak <michal.kubiak@intel.com>
To: Saeed Mahameed <saeed@kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Saeed
 Mahameed" <saeedm@nvidia.com>, <netdev@vger.kernel.org>, Tariq Toukan
	<tariqt@nvidia.com>, Maher Sanalla <msanalla@nvidia.com>, Shay Drory
	<shayd@nvidia.com>
Subject: Re: [net V2 8/9] net/mlx5: Query hca_cap_2 only when supported
Message-ID: <ZKXJpwGP1VITMm8i@localhost.localdomain>
References: <20230705175757.284614-1-saeed@kernel.org>
 <20230705175757.284614-9-saeed@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230705175757.284614-9-saeed@kernel.org>
X-ClientProxiedBy: FR2P281CA0075.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::17) To DM6PR11MB2937.namprd11.prod.outlook.com
 (2603:10b6:5:62::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB2937:EE_|DM4PR11MB6238:EE_
X-MS-Office365-Filtering-Correlation-Id: eb4a04d1-8f26-4f37-404d-08db7d912dee
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1UmlTKC/wrEIRIHXso8NDL+YYojiB/uOSm0oZSHt2EtmMeM2wU2xEPDjtyRmcnCpDkD8tYB5qpK56WuofVGhr1pId7ZhDYlMZR/SYHpFNwpKeQWMBWcHPtI1lK0tNit9gxnrlGsR3JhONwFFEDJmMtlpB/rWd016shhU4qJtAYF8/tIcwQbdTBbPprsJ7asSP1l4b4Z8NB0s0y+ZchrSf8204QgDq/4/9uWrELyQhR+7WkmUxYs9oDr5bJNgN9fzc5jLm95w21w/JfyTwTpRtMiQWe1nVKYJHZsq+vubeie4XUej2zYTK4ux22ERr6nJqUMmbr6YMLZh9txirJF19TilHvG0/2DnYDiAf2H7M7E+phQ0sZkSvZrcE12sf2kYrhcLZcee9IEW5de7xPfwGiy+nKccvfnA8CHptxcD3C/fz3Hso8aUedJLTQJtVCmqb3GgFuDY8FUbjZE1uj/peLAnplhzeJVdHbaVQRPxJ7QwPeBe0ctInOTE0rgYGxEk9lMxBkYV+1l+Q2Y6t4GcrtmH7k4nwwSKNgTnrkLZPl2/KLW9jcHZWipPQX9dzKDJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2937.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(346002)(39860400002)(366004)(136003)(451199021)(4326008)(83380400001)(6506007)(54906003)(82960400001)(478600001)(66556008)(66476007)(6916009)(8676002)(41300700001)(66946007)(8936002)(26005)(6486002)(6512007)(9686003)(6666004)(186003)(316002)(5660300002)(44832011)(2906002)(7416002)(38100700002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8xCvGK58MJPiHivmDteGU96tH4D/9NyB4WCdksCVt21zHRgw32jd+R/8L+Gy?=
 =?us-ascii?Q?J5nbPNkMH8FfeCsv0quzLt3yol3/HhcdulbnZ5x3jbKBDOZOUm1TTbiixmRM?=
 =?us-ascii?Q?9Jl2RbtZ62bPr+C3UuHTP2cWkTEesPOwRir4c1Gfs/hj5aHGIHncPCQr0ZD2?=
 =?us-ascii?Q?LkacjQ1nEXjEdHKGwtnqx7kCvq1pYwFEuF7QVT2VZx5auRamT8Ez/ecvacdF?=
 =?us-ascii?Q?UHJUxITcR0lRqCDzaO+GLR38bTeOK7smpQYO4EYmZe8YGJ9d1hRXWD1ssLIE?=
 =?us-ascii?Q?F4OtrTqAO41J1R7FW5tFFvT4ddpDbdphhAuKmH7PYehm6SaIe4UzmcYQGhs0?=
 =?us-ascii?Q?r72fz+xS9vBOgJdJVYKer32klxxWwlZ9ThlzZxeYfKukV/G05md0mYFwIj0s?=
 =?us-ascii?Q?AIkokBmmStizF7qhuALQRPt8PQ08Sz1U0L/uDvcSK6GV+CPlXgM8GzN/Lf15?=
 =?us-ascii?Q?3IG3CRcg2N/lCIOFK2f0KjVZp5HgPBPs2WZ0Qo+HNKF1IHcQb+zBDtgOSNf0?=
 =?us-ascii?Q?9fc9dmiHRlHbylAbqhuVCcUnuZS8R5GIddOWTVwrBbXMmfJkRcJ1PW/n8PqX?=
 =?us-ascii?Q?uiH8aG4qgGtdyMLpNYYke1Q86r1fA1nxCAttELmm//UViV4SBt2r8toSQbrR?=
 =?us-ascii?Q?VnXR+uc41MjMz84BxpE3ScxaPzGI8/NFRfbzXbE+i9pL0sfTNiAxcUfVrGbc?=
 =?us-ascii?Q?C834+sGJ0wTiUgPfQY8kFvr8tX3ltqkwlxqEYfIlHPGgYgTyQZPnTDBNydqp?=
 =?us-ascii?Q?s4oB7iZkz0lgRrDzSaMxgl11iMhUI/CSpUtyjF9INZbneLlo5+IczBKKGlfP?=
 =?us-ascii?Q?9EVOV4RdQX6u90YUjbtjAfyeIu56M6Q86eJLcczi1o1y5lESr4PrOxgpv9TM?=
 =?us-ascii?Q?/VdIqEGTQzkTZiSMjc3EkFHINRgTXMJebFh8JsmRJzLiamCCgnkjYugU6+f4?=
 =?us-ascii?Q?78A9XZ+DebGnJuwAIC+dQqd2qVGjVPDPab8/nmQpQBSOQWkwP4/JEw4cqdGL?=
 =?us-ascii?Q?pnHUw8RCwm45rjNcFebk4T0e3EbQNK4MXUirMJIZVwTfhWhBSgtaPaS19/Jt?=
 =?us-ascii?Q?7+N94EbFgItbffaExNFAi/qFeY1kKKnSTqbKk3CGWbcY/YM07rWr4ZHD+rkQ?=
 =?us-ascii?Q?fG3KE7tBcKP6+iDuz1QAUqeui+OF7tR9pd3alAT5L1pnkAQSIWP6CfsbiZ0m?=
 =?us-ascii?Q?ABlWWtrLh3VVcfOuCSddQNG3Hdmfnkkzdw7TRiaz57iOLsp3OvZmHiL9E0v+?=
 =?us-ascii?Q?TOBhYP5e9wTSeWuQKEeX7FKFR0jO0vtgRzKAnkBwzdUBpIkUYZ59osxGU89i?=
 =?us-ascii?Q?KxkzitwoejAZe89LKTopH3EG+2ogOGMWZ9jJOszBAvIKKyIWuz1OepQ1r8bS?=
 =?us-ascii?Q?lpgjM0ToxGzAkijoYAVHrWb5ZxMsW2VMBItPrrhzqtKwtHp5mX1leF3gADvv?=
 =?us-ascii?Q?UlfT4WUu9CUDvC6eBeOqJCwuTj0hO73UHsTXBCMOA8s+c8BH1NRzeumbKTEN?=
 =?us-ascii?Q?wkPp0a0ad3tS2me4GBdocwlXmK+bp3jyBBezXWHvJLw/AvFeUJQci1wLKK7u?=
 =?us-ascii?Q?2JjLmZ14jfGgEDy7Xdbg3qYTrKm4X9Gt10E9n6GstKpB3OEDHb3bSsg54GU+?=
 =?us-ascii?Q?Bg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: eb4a04d1-8f26-4f37-404d-08db7d912dee
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2937.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 19:51:09.9569
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EKwdr5HE4Mjp6Rou17mzi2TF7ckPkXbntengE2urHqQVTLdZUef2CraBy9rlwHEZi94f5usQLDDzPiPCV6UQHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6238
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 05, 2023 at 10:57:56AM -0700, Saeed Mahameed wrote:
> From: Maher Sanalla <msanalla@nvidia.com>
> 
> On vport enable, where fw's hca caps are queried, the driver queries
> hca_caps_2 without checking if fw truly supports them, causing a false
> failure of vfs vport load and blocking SRIOV enablement on old devices
> such as CX4 where hca_caps_2 support is missing.
> 
> Thus, add a check for the said caps support before accessing them.
> 
> Fixes: e5b9642a33be ("net/mlx5: E-Switch, Implement devlink port function cmds to control migratable")
> Signed-off-by: Maher Sanalla <msanalla@nvidia.com>
> Reviewed-by: Shay Drory <shayd@nvidia.com>
> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/eswitch.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
> index faec7d7a4400..243c455f1029 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
> @@ -807,6 +807,9 @@ static int mlx5_esw_vport_caps_get(struct mlx5_eswitch *esw, struct mlx5_vport *
>  	hca_caps = MLX5_ADDR_OF(query_hca_cap_out, query_ctx, capability);
>  	vport->info.roce_enabled = MLX5_GET(cmd_hca_cap, hca_caps, roce);
>  
> +	if (!MLX5_CAP_GEN_MAX(esw->dev, hca_cap_2))
> +		goto out_free;
> +
>  	memset(query_ctx, 0, query_out_sz);
>  	err = mlx5_vport_get_other_func_cap(esw->dev, vport->vport, query_ctx,
>  					    MLX5_CAP_GENERAL_2);
> -- 
> 2.41.0
> 
> 

LGTM

Thanks,
Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>

