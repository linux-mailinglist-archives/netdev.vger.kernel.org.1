Return-Path: <netdev+bounces-15637-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB055748E3B
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 21:48:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 872722810DE
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 19:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75546154B7;
	Wed,  5 Jul 2023 19:48:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E303233
	for <netdev@vger.kernel.org>; Wed,  5 Jul 2023 19:48:32 +0000 (UTC)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8180FE3
	for <netdev@vger.kernel.org>; Wed,  5 Jul 2023 12:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688586510; x=1720122510;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=dBt812A5TxUOrJUIvS/vYg0x0SI8nWdMxcl9rX+gIhM=;
  b=cLa573v3JQr/YY6wj/BvIyk+0P/y8choF+rZujp6rUCjgW4c4IiN0Bfu
   HD28Urca/1cHfBJa5cItjDh887bJAr+tluiKD2loYVbPqZEn1asB400VS
   inZulyJaX4mkDsIRxNFyKEnlqRykT8ToHuomi4RUOXi7Vb1meUwzHYKSx
   ZOnUhw4BVwoLrj+hHVEBUBqWbi+m0IknYGcLbPQNuHRKPu76qVDpMiUoh
   7sIdeHsY2R1YLFE6Qm5eIQhQ5Ilb4S3fuPEuDhVamOJeVx0QakcniHMPP
   S9D8Fa7TztGPjdZkOexKPz3t0YubNfqjaDlVme4QIICQcizgSQvcEedsC
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="343756032"
X-IronPort-AV: E=Sophos;i="6.01,184,1684825200"; 
   d="scan'208";a="343756032"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2023 12:48:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="696571887"
X-IronPort-AV: E=Sophos;i="6.01,184,1684825200"; 
   d="scan'208";a="696571887"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga006.jf.intel.com with ESMTP; 05 Jul 2023 12:48:29 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 5 Jul 2023 12:48:29 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 5 Jul 2023 12:48:29 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 5 Jul 2023 12:48:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KLrxseYNngiuJXXeymjy2mgpCOvw4WOzRNEb2KKTFB+yVc4GHeleYY0+2hmeY6DQNg7kiZ9syREi1BV//6yCdCvQnO6PHpeee0IS/D1Yqbg1K7uaXAYd7AfYCdTi0Ih3Wn7zMAcPtt/+KAdLe+7GtRcL2ke5ZnUg1qHM3fu41zscTRlSXaxmlWP3qnGGVHbDC7lJeFhuoSQqyqmmgt+PESJi+ttdQt9+cAryb4YBNTA1853Cmc+8T9C7RLC1pJbjzYFbduuk0my+XJqcwoHiEVYYDw3ekjZtmJ2wWX5JB6wuDb40UTkyCs44oX1Opyen1avW07dTe5bFjG9dyoi3RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Chw/ywXyLdsHIWwuMEy/up7JtjZhlO8swU7fh+iawV4=;
 b=EjR2ZRhbJfvnbsQyE4mCL+/vsEm9y0UQBrAeqKUIPpiThI6awFEDI0dfgPZH1PQYtrMqIrOdguu2JWh9gALSUzXANtmQ1x+LevCL8cPBzmAIJ9DI1uIowtKeQP1lFw5lecm4jzjedlFEAIxu9nxpJQ8Q5RIvJa/DKRPu2bxcrRLBCss1SDVGrVsMUGRzNFHVQmN2/pAZdnkY0kbhz+opXav2hbJsI1Qjrr1OUZKbjTZ2jRY1HpWakEsrz6G7Q0ZD8J4kw+yomVKSBct/zsCe/Q/L6qxcGwKJJztk+8QBI1Zg0dxPUT8JBHJDqvTk4oKXlKgCFp06H3hWHlglRYkCSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB2937.namprd11.prod.outlook.com (2603:10b6:5:62::13) by
 IA1PR11MB7388.namprd11.prod.outlook.com (2603:10b6:208:420::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6544.24; Wed, 5 Jul 2023 19:48:26 +0000
Received: from DM6PR11MB2937.namprd11.prod.outlook.com
 ([fe80::a5d6:4952:530c:f01f]) by DM6PR11MB2937.namprd11.prod.outlook.com
 ([fe80::a5d6:4952:530c:f01f%4]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 19:48:25 +0000
Date: Wed, 5 Jul 2023 21:48:08 +0200
From: Michal Kubiak <michal.kubiak@intel.com>
To: Saeed Mahameed <saeed@kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Saeed
 Mahameed" <saeedm@nvidia.com>, <netdev@vger.kernel.org>, Tariq Toukan
	<tariqt@nvidia.com>, Sandipan Patra <spatra@nvidia.com>
Subject: Re: [net V2 5/9] net/mlx5: Register a unique thermal zone per device
Message-ID: <ZKXI+Kf9Vjiuj9oZ@localhost.localdomain>
References: <20230705175757.284614-1-saeed@kernel.org>
 <20230705175757.284614-6-saeed@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230705175757.284614-6-saeed@kernel.org>
X-ClientProxiedBy: BE1P281CA0257.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:86::20) To DM6PR11MB2937.namprd11.prod.outlook.com
 (2603:10b6:5:62::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB2937:EE_|IA1PR11MB7388:EE_
X-MS-Office365-Filtering-Correlation-Id: 99ceb394-21d1-4c92-6ac6-08db7d90cbfd
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pgJ0+V0LbjiCk3zVozQK6QDUrlo/3Tn6xkMRNWZ6ih+V3m1rBk2HLL4gGTKTkbhTUiTrG3qsl1JgegPhLINLXI87W3SRIyP2um3mkuOvzJIN/vSykmOWG+mSuMfZ6TNp51s16sHJx9jk5KujLwiybFm/7cSlSpLzijKKwKBpVufMCaIlmdzJM/PT1BBB/dCsZN/jRqDiQ7yYHEOx9SyxTOx4h20RT7iQWbz3NEtGYGffoBeGnKTGgEp0FcA81KM+IwUODJxAjmb1sRtuGHC5KUzIOZ1e9ta/rLXsfOVPvRSxS2yINrArDy7ASErE2w70u9PzZD4ak56Os1EUD1iV0qkm1/afr/Iv7HFx/EaunasurP2TcHaYfcf3+4g4UHyAszB0gf6WAezWXsqMlmfcBPGmyqoE8ipBbAKd51wjLPHGkasDn7I7eOM9je9ddYZdAEO+viUkZ29I4jJzFkgD3EOurT8OXwG08H5XKH+rLFGLv246Y2uCImL4t60Su+vkPaWpDLCWZx9Jo+8/MpdCySmKH+724xowgI6K1nO6Jt5yDwY/jfN2Lx+C3KBSX/FKk9GFBy92Lk7rqfz2Swdkjmp3+VopIMBI1YuHyhBVXZQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2937.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(396003)(376002)(136003)(346002)(39860400002)(451199021)(8936002)(8676002)(54906003)(5660300002)(41300700001)(478600001)(316002)(6506007)(6512007)(26005)(186003)(9686003)(4326008)(6916009)(66476007)(66946007)(6486002)(66556008)(6666004)(44832011)(2906002)(83380400001)(38100700002)(82960400001)(86362001)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0QkDUle+RLuae1zLQ9dZTbDfccL7eVEu7h7c+NrTwe2gWn4r5O06A+YsLKLE?=
 =?us-ascii?Q?IDwhembQeAtSy4dEmNJffaKApTDZ5dsRz/EKYZ45N6KWWFJ6qdAngs0eA9i+?=
 =?us-ascii?Q?WhUhQ/2SHftrm/SzYcwk26krZm45Rlu2BLRNYvqxetAhk6Eqicwy1U3hSBbA?=
 =?us-ascii?Q?IW56XkaX2hcPvAZbU8tADmhn6z5YCoJ3ks5KfsaDfGk2vpx6zkOQcEYbUId8?=
 =?us-ascii?Q?haqVI4btEqCOscpBpD5g6TMZZGqRAt4SN1699Bulr5lnRMm8LoPve+Rp5X5Q?=
 =?us-ascii?Q?s4PLcHngwEkKE006GYUrH+vI5UMK7jvOATfrJWIpz3PdXMTAvYOn8Gy8atDy?=
 =?us-ascii?Q?4D0SK2X/tl5FPGuAVOAqRk3pgMkjr1eF/J3nyhfcJBpDUf5zB+YhGlSLN2jq?=
 =?us-ascii?Q?lGvJ0qF5jHzTMo9yMF7cZvQ9mpZxoDYs2BDFm2lm4uNsK9zoHPntp0axGgp+?=
 =?us-ascii?Q?IVnNsTxbwURLhBojZvOxqQRa4yA+8V6AhkbWBAq0POXLrWZUu/Pngih+KTqF?=
 =?us-ascii?Q?Zh/UsdwGKnngpRzSRAxU2CsVIK8dpfRiuW6kTUEtYv5Vh0L/GxLSW/YcIA6R?=
 =?us-ascii?Q?i2C2L3aUjhFJSItDxzeMWsVx/nxWSKoPENFyn6Gr+7eHY+jxtIEvs20YhdvL?=
 =?us-ascii?Q?RNSFGH2vlq1sBb7AH5gYIgsNRn8VmIHxZzCf8qqqSIa/owknibHPOmbsV+/d?=
 =?us-ascii?Q?SimIaU1QEGqjaFK9SDSR3C2MLXT1BNovDsjK9do5ZZcT9lTEZ1YCO/pw66ij?=
 =?us-ascii?Q?IKZGKfR1NXiZQzT02CBq53eU/zWXFiG1P/4f2cHjDkBkKh2eP+oYT70sRSf2?=
 =?us-ascii?Q?wU8EozJApshqq9aKHaV5C/DzpHFO/FIfzXTn1uJJkPr0W4Gt5RvJmglBiMin?=
 =?us-ascii?Q?rgc4BrRlYYITv/uohJbzYXhXhHQ7cgjdKZI3n6I5sGVT6eHaDR8gIUB1GfxR?=
 =?us-ascii?Q?6BIddmZpzLnRhoLmxAKmcIlKG44bsoL2lE3qYqi0Qw2GlD4rGQ0fxqI5M8wY?=
 =?us-ascii?Q?aK0eFfkuFTmTgXiApSi0DXjOXjstQKomL7AUvqu0NUqG7icgrMcivdCHfg2v?=
 =?us-ascii?Q?RxxbhyahFSLHw/dg1AHTilP/6qmUaKauTbbkChXGZlp/89/UwNHepGvHAd/N?=
 =?us-ascii?Q?CINRHFynO/+vGEjUR64AqhOFEo1qfOe3FSUDFwVE28tB88OmHObUziciqMEd?=
 =?us-ascii?Q?NDs9svvUoV0+XJbLCRoTHs8y5qqFnNVxV67z6UXC0BZ+z3KrzduzmNupp99L?=
 =?us-ascii?Q?W8di7Bh5QKe6lNfsdfXd6us8LTx1LMcUwfPubXAvwdIaWddnByb1JBxYN5FS?=
 =?us-ascii?Q?exH0kSfd0nuam41k7fgq0WgUJYRy1NjWCTOVyxt3lYtCP7LiiF+dvXZWF5+T?=
 =?us-ascii?Q?OAvrWx/ZPmRXZYGbu4E6GTob91CnngmOq28ejcu3DmxLQiVnnQUh2W/kdWR7?=
 =?us-ascii?Q?T+X9Mo6PgFYJMs9tTWgOR2+xXq6Vn590/ze6St4B5hy6Tb1x2IRoqvZbm4yZ?=
 =?us-ascii?Q?FY4MoePeXZ7sxjZ359QpNR6wKuggd7KpdnOFefhOkzxP7rUpEbce9gO8ooar?=
 =?us-ascii?Q?FZC6amj6ApUAMcp238mGDxvrJzV65KY+0I2zxNAp/2qARsmfAyOpwJqsLTYx?=
 =?us-ascii?Q?Xw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 99ceb394-21d1-4c92-6ac6-08db7d90cbfd
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2937.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 19:48:25.6907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pxdjQhfnHO7GGqG8UJ14gC4gD98cmHxilG0ilCJdIeODyn0LrrtP8BxyHHmci4CBzjSNWlLwiiL9LXWttyhCZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7388
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 05, 2023 at 10:57:53AM -0700, Saeed Mahameed wrote:
> From: Saeed Mahameed <saeedm@nvidia.com>
> 
> Prior to this patch only one "mlx5" thermal zone could have been
> registered regardless of the number of individual mlx5 devices in the
> system.
> 
> To fix this setup a unique name per device to register its own thermal
> zone.
> 
> In order to not register a thermal zone for a virtual device (VF/SF) add
> a check for PF device type.
> 
> The new name is a concatenation between "mlx5_" and "<PCI_DEV_BDF>", which
> will also help associating a thermal zone with its PCI device.
> 
> $ lspci | grep ConnectX
> 00:04.0 Ethernet controller: Mellanox Technologies MT2892 Family [ConnectX-6 Dx]
> 00:05.0 Ethernet controller: Mellanox Technologies MT2892 Family [ConnectX-6 Dx]
> 
> $ cat /sys/devices/virtual/thermal/thermal_zone0/type
> mlx5_0000:00:04.0
> $ cat /sys/devices/virtual/thermal/thermal_zone1/type
> mlx5_0000:00:05.0
> 
> Fixes: c1fef618d611 ("net/mlx5: Implement thermal zone")
> CC: Sandipan Patra <spatra@nvidia.com>
> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>


The patch looks good except 2 line length issues reported by Patchwork.

Thanks,
Michal

> ---
>  .../net/ethernet/mellanox/mlx5/core/thermal.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/thermal.c b/drivers/net/ethernet/mellanox/mlx5/core/thermal.c
> index 20bb5eb266c1..52199d39657e 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/thermal.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/thermal.c
> @@ -68,14 +68,19 @@ static struct thermal_zone_device_ops mlx5_thermal_ops = {
>  
>  int mlx5_thermal_init(struct mlx5_core_dev *mdev)
>  {
> +	char data[THERMAL_NAME_LENGTH];
>  	struct mlx5_thermal *thermal;
> -	struct thermal_zone_device *tzd;
> -	const char *data = "mlx5";
> +	int err;
>  
> -	tzd = thermal_zone_get_zone_by_name(data);
> -	if (!IS_ERR(tzd))
> +	if (!mlx5_core_is_pf(mdev) && !mlx5_core_is_ecpf(mdev))
>  		return 0;
>  
> +	err = snprintf(data, sizeof(data), "mlx5_%s", dev_name(mdev->device));
> +	if (err < 0 || err >= sizeof(data)) {
> +		mlx5_core_err(mdev, "Failed to setup thermal zone name, %d\n", err);

Line length exceeds 80 characters.
Please align to the format below:

		mlx5_core_err(mdev, "Failed to setup thermal zone name, %d\n",
			      err);

> +		return -EINVAL;
> +	}
> +
>  	thermal = kzalloc(sizeof(*thermal), GFP_KERNEL);
>  	if (!thermal)
>  		return -ENOMEM;
> @@ -89,10 +94,10 @@ int mlx5_thermal_init(struct mlx5_core_dev *mdev)
>  								 &mlx5_thermal_ops,
>  								 NULL, 0, MLX5_THERMAL_POLL_INT_MSEC);
>  	if (IS_ERR(thermal->tzdev)) {
> -		dev_err(mdev->device, "Failed to register thermal zone device (%s) %ld\n",
> -			data, PTR_ERR(thermal->tzdev));
> +		err = PTR_ERR(thermal->tzdev);
> +		mlx5_core_err(mdev, "Failed to register thermal zone device (%s) %d\n", data, err);

Line length exceeds 80 characters.
Please align to the format below:
		mlx5_core_err(mdev,
			      "Failed to register thermal zone device (%s) %d\n",
			      data, err);

>  		kfree(thermal);
> -		return -EINVAL;
> +		return err;
>  	}
>  
>  	mdev->thermal = thermal;
> -- 
> 2.41.0
> 
> 

