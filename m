Return-Path: <netdev+bounces-15631-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2C54748DC9
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 21:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E6FA2810F8
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 19:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C9115497;
	Wed,  5 Jul 2023 19:30:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBA0DF43
	for <netdev@vger.kernel.org>; Wed,  5 Jul 2023 19:30:14 +0000 (UTC)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 130DC183
	for <netdev@vger.kernel.org>; Wed,  5 Jul 2023 12:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688585412; x=1720121412;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ua3nbc43mP5HFHLuWiJHn2DgMoLNQSjk/JFLGgLQJkI=;
  b=oHNtCgOEbm/Xq5wPZCczZA2+uWG3Dy4ng261G0heEaVTTTioZiqsFfEz
   U0yHiJ8+ZVEFEff4gQEOoSWh7WlaYDghqNNzJjLdn/Aj3wgTw998bpk0/
   OVVqq2usuunUDx4wFiJy872IqVYOhBdGMlhZF+6z5KxS/1qo6YcXjdBM2
   h1V8um1mENaY8EfJi8dV5X0a48iTzL42bNnEOM3EYMXJ+Xdc7d+78kJYG
   hF50GIjH/MP+lDt21/s+pws0ba2t7OYOXaDd+botc57xo5I6M5D1lPqVY
   wepH2G8qPEFHs+gKiRrQuXlJRwFEGxFQPE7tqYp5XiVxkJSf9Ga5mjEL1
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="429467124"
X-IronPort-AV: E=Sophos;i="6.01,184,1684825200"; 
   d="scan'208";a="429467124"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2023 12:30:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="669507597"
X-IronPort-AV: E=Sophos;i="6.01,184,1684825200"; 
   d="scan'208";a="669507597"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga003.jf.intel.com with ESMTP; 05 Jul 2023 12:30:11 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 5 Jul 2023 12:30:10 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 5 Jul 2023 12:30:10 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 5 Jul 2023 12:30:10 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 5 Jul 2023 12:30:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CYO0uRxW0J8HfrF2PRRk8qfCugUmwOBifplrbXdeOtiRBMAmippDqcWPOOdmNMZRfJXi7S8NQj5Xpoa8hiL7wEoL84jvZ5fhUC0Kl5fwKvZDUj58omH3mzBT/gdd+HXvprJ6zJlJvunu/zt7nU2NzL6urBc5DelqNQ/mU+zD3xQnGJSosJReUMBv64sDSOR96xZt5CuTgfJVPtiaKlVWpFbcViKCiE6pjZQv67PJy33E68Ew7iCb21ri5AeqmqBxSsNAsQMvbmbet23QBsaTKepwZuah4csaW59lbPwEBfOSeLvFsEE5mejXb7N0wHJH++wmUJtaHSksmZOaj+I/Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RqYz7ebNLPU96WHic0YeB5hsbLGZLbeC1q3jHv8GuaA=;
 b=niIvOc5YFa7PxlxCH23gBRJL35Jyjf17t7Cjd05+0AbdFXHk2JBWtKuAAPEVUYeMU5P+tsOCUB2uMwLqiI91KlaV+I0//JA4fhrquqY3B52CnJAfEVtfpjqgs+XvmN7pKk3XSMu+PIJZ3g5wAD+qiYYAt4s902XaI7UZ7pd1P54ONS4iVaH1On3XktrAI6W8Cvi5gcAt97fRJmCdz4mWh1Woq/ZOzxrFoyDWHG+ewau5wI5PDMcSGwjcG0kwWX9rRPUzMvBRrSSbF8uj7tMShxfXV0iBPuleJefVHvIwhMbajClCv50IWXeiKl7PtyCQzb+Qc5xzjfB+tQEkEN+b3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB2937.namprd11.prod.outlook.com (2603:10b6:5:62::13) by
 BN9PR11MB5403.namprd11.prod.outlook.com (2603:10b6:408:11c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 19:29:33 +0000
Received: from DM6PR11MB2937.namprd11.prod.outlook.com
 ([fe80::a5d6:4952:530c:f01f]) by DM6PR11MB2937.namprd11.prod.outlook.com
 ([fe80::a5d6:4952:530c:f01f%4]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 19:29:33 +0000
Date: Wed, 5 Jul 2023 21:29:27 +0200
From: Michal Kubiak <michal.kubiak@intel.com>
To: Saeed Mahameed <saeed@kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Saeed
 Mahameed" <saeedm@nvidia.com>, <netdev@vger.kernel.org>, Tariq Toukan
	<tariqt@nvidia.com>, Zhengchao Shao <shaozhengchao@huawei.com>, Simon Horman
	<simon.horman@corigine.com>, Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: Re: [net V2 2/9] net/mlx5e: fix memory leak in
 mlx5e_fs_tt_redirect_any_create
Message-ID: <ZKXEl3NOQhjrrbrV@localhost.localdomain>
References: <20230705175757.284614-1-saeed@kernel.org>
 <20230705175757.284614-3-saeed@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230705175757.284614-3-saeed@kernel.org>
X-ClientProxiedBy: FR3P281CA0052.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4a::23) To DM6PR11MB2937.namprd11.prod.outlook.com
 (2603:10b6:5:62::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB2937:EE_|BN9PR11MB5403:EE_
X-MS-Office365-Filtering-Correlation-Id: 80a44aae-feb3-4dd0-9d30-08db7d8e292b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vps8ONgEK+XytYP8hbtRfVt2U4Snjc3FAJgOhUaBkKd+wsUsdchI4YWD3re9VtqNYecr2OpzOZKrgKRg4vEl3TjRJaEhuUmnyJS+Bcdfgoa+Kf3FW4Hh/Bd6qeAn+br5SHx5TZRF4Y8L4u4YybsJX0EYmDhAZGhVyGRwY4IRomux8PM5d1i2YDMuXxN6ZGxIhzY8ize5efrZGEYwi2qw2PogtivPflUGuxvIA16g7fhbzZLBcQ2uTP6rH6s8HprhouRj90iRAKDCswwEDe/lDD6Bd8frYK2CagPuz0eI3xgkcXEancoMZMRJlnIHHxV+ZNiFJqqwCx0r1PihXBlwSLoPztcY80Gp36YdQGOzpEKwh/1n3NJw+o/h3BfbtsZyBqDbyb3XRF+8mQ3VHARXB+BmWcbysoRXoJla4T+z+VIbPZO82wvadDz3ip4lXZzX36AZbyqKdUAOQ70Y/cTmEJnd4Rn26ltWDV43Q01yRJjKS+jG+ownnSh6wFmc3TCk0xEUM3Rcak2lB0McXu74GKThowZoIJjGw8f9F7TFk2OnOQpMrXklz7r+VRXQcM6K
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2937.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(376002)(136003)(39860400002)(366004)(451199021)(54906003)(478600001)(6666004)(6486002)(6506007)(26005)(9686003)(186003)(6512007)(66946007)(66476007)(6916009)(41300700001)(8936002)(4326008)(66556008)(316002)(7416002)(5660300002)(44832011)(8676002)(38100700002)(82960400001)(86362001)(83380400001)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?41z7N6NF+FtPnxUsfP1hsrqe5rl9MwedDQPM3KXhFUWL8sWgZ4XP347Zbm+K?=
 =?us-ascii?Q?0bd5kBUPj2PcFQEXYRdQ2NeE8RlYCODnm9h3qwYtlpH47O+RikQ1Z+BLwQov?=
 =?us-ascii?Q?gGaT/WVTSe/Q0HDhVg6Pj9BfMCYM6UqTHOmGiVOLWVtuSlb3e6W1/MYnMwjF?=
 =?us-ascii?Q?kR6wcMQ0n1tJ6L8o18Zxzej/CzpMN+oYMGVkuWd6h1lncP2K82nLE/3wmAKf?=
 =?us-ascii?Q?6cbzsegnqMDp3dZWNfXCfv+33B05SyfGBTo3ED7sQutPtIdL19IQJoJjmz8P?=
 =?us-ascii?Q?Cg6l7Ls40AF1mEmIfcVRj1RIM0dKuPVOkE0sIy5XrLmJYbeWQzSTUl1rOKkD?=
 =?us-ascii?Q?Lyvh+Qe5idZgxBLH3LLZei9yrxqmExK6Eowk/xRWXwdq/J2rAUZIvAHE8sy/?=
 =?us-ascii?Q?ESHw42BC5OpKte+eGgjWQtgFKSL2zHFlmVg4Xzp4hrySrQY/DD3PhsLnwP0f?=
 =?us-ascii?Q?CBtJRKZona9xK3s202YqoUP0OCZwkcGUbH3gdE9gm00NkYqCJySjPYRPx8yv?=
 =?us-ascii?Q?I0JXF/3lvuN6Fxx2zQ9x4QzGORPj4BwDv5k4aBh0lXEEtLk3bkg7TGD2bRtX?=
 =?us-ascii?Q?DAPY4Gka/uHaNVDoldziWdJb2Vo2PjeA1mNxL/D7Q/0oM0GvCi7h1vaD1l6Y?=
 =?us-ascii?Q?62gjh4AWLndnFveulzul8m5aWtf0bcktlOzNS++N0B5kPJKmEtBeJb7a5C+s?=
 =?us-ascii?Q?nDDXkWmUmbvhkizBxcrhhuskbmZ+CuyFYJHSLem8v5ecBGhV9z60bO+wYH1P?=
 =?us-ascii?Q?DRyHFr4v71WPu24BhZVqpKIdqG5/alHsFdo2lhrVJwokcCQoZp5uXb6hdNgk?=
 =?us-ascii?Q?xpCA5VxEDruE7v1N/RK6VO70foX2Bpp6ucWp6aMDD0SIb5sZziDQb767DOJb?=
 =?us-ascii?Q?SugBiBX310GyAw2NnF7ti/P1qLzl5sJgMensx377+wm6N3H4a+XDOosoBYFm?=
 =?us-ascii?Q?gaXuCskWpt4TsNkWAIzBaaAP3zlAP6sQ8Ca1UUGHrdHf7kCsVJOvdxv5Mmag?=
 =?us-ascii?Q?Hp+RYxx72rfxV1VXzJtv9f+1tY9fZwW6W8OWW0t9S+KohaJId32QkYhvwQ84?=
 =?us-ascii?Q?nHBK/0k/yYxZuusRAD35EgCrsBg525fF8emKzvdV8YKQYmGIzAWbqI7cT5RN?=
 =?us-ascii?Q?ymYlafM8J0rfUweztspsAOKHkoPdGamZh4i571jPkG6lRtx10AyR/KOrKzCJ?=
 =?us-ascii?Q?1XEh0Mj7YSG2/ekrSqixkjCObyDqXmq0+ySuFQ3icTG6TyW0iRbS/A4BWqQE?=
 =?us-ascii?Q?7zK5TtpZG0oePb8FYKvbD2llzCapjjaLKy7iByzykPg0+V4NSuW5QK5i6k95?=
 =?us-ascii?Q?x8mxsiqUj6MT18bndpD3mBaVM0zN5e4U0O/DJ4gkz6+3lAH59sZYd9WTZiLB?=
 =?us-ascii?Q?NAdt765CYl70ZSWZZsH1ngkKQxvukRS+XF4LzY+gO0PETnnS8lqfC8gvjEGm?=
 =?us-ascii?Q?kMm3uUDob657QUzT0wlwb1G+djUopwronOPVwCWb4ItXqeEHWElfHKHoNuNl?=
 =?us-ascii?Q?j2cMKyxjUc1zy48OYsEl3XvtkHePpgc6YHWiLtpC/+ceb5ztuX+qhJvMmdEs?=
 =?us-ascii?Q?qz7r73z3lHZYzNpq/S/MXfXYqvaSqBWwfe2ZjU5JVARoCTgcMUDu0LrBHjNp?=
 =?us-ascii?Q?Rw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 80a44aae-feb3-4dd0-9d30-08db7d8e292b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2937.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 19:29:33.3779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yJK2YzlpufCPg8Kyovgn3lwSqpDiok25XzIkwhkZB2Da36xH8bWmAITQz+2Km14qVbeGMh7BwCIMvlje14CSaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5403
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 05, 2023 at 10:57:50AM -0700, Saeed Mahameed wrote:
> From: Zhengchao Shao <shaozhengchao@huawei.com>
> 
> The memory pointed to by the fs->any pointer is not freed in the error
> path of mlx5e_fs_tt_redirect_any_create, which can lead to a memory leak.
> Fix by freeing the memory in the error path, thereby making the error path
> identical to mlx5e_fs_tt_redirect_any_destroy().
> 
> Fixes: 0f575c20bf06 ("net/mlx5e: Introduce Flow Steering ANY API")
> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
> Reviewed-by: Simon Horman <simon.horman@corigine.com>
> Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/en/fs_tt_redirect.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/fs_tt_redirect.c b/drivers/net/ethernet/mellanox/mlx5/core/en/fs_tt_redirect.c
> index 03cb79adf912..be83ad9db82a 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/fs_tt_redirect.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/fs_tt_redirect.c
> @@ -594,7 +594,7 @@ int mlx5e_fs_tt_redirect_any_create(struct mlx5e_flow_steering *fs)
>  
>  	err = fs_any_create_table(fs);
>  	if (err)
> -		return err;
> +		goto err_free_any;
>  
>  	err = fs_any_enable(fs);
>  	if (err)
> @@ -606,8 +606,8 @@ int mlx5e_fs_tt_redirect_any_create(struct mlx5e_flow_steering *fs)
>  
>  err_destroy_table:
>  	fs_any_destroy_table(fs_any);
> -
> -	kfree(fs_any);
> +err_free_any:
>  	mlx5e_fs_set_any(fs, NULL);
> +	kfree(fs_any);
>  	return err;
>  }


Looks OK to me.

Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>


