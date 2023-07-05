Return-Path: <netdev+bounces-15632-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7555748DD2
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 21:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5053E2810D0
	for <lists+netdev@lfdr.de>; Wed,  5 Jul 2023 19:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8639E1549B;
	Wed,  5 Jul 2023 19:31:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730271548E
	for <netdev@vger.kernel.org>; Wed,  5 Jul 2023 19:31:38 +0000 (UTC)
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD521183
	for <netdev@vger.kernel.org>; Wed,  5 Jul 2023 12:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688585495; x=1720121495;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=999CEGNTI+aV4RHOj51JFkEPutOvAK5TTaW7dz/QRHk=;
  b=XydgkCcukDTIEU9ujKMqmQ1eymZ+D2akrpwBdDGS6AXm5Rty/6QeTw3c
   6YoUXDyefTyjyQaNuEPmFsSBlczQPVM3Bhn6ZSZJddplOXJgt6GY8MSMC
   Q0ck2tMVEPwV7efQOfc+pPps5N64tzM1C5LAvoFLReLxijIaveHE07F0H
   1d2//jdf660+DPFytvxTSHJWQJx+b+OxWhTcl0qU8fa3dPDDDvtUrNNwn
   3L0ke85rDnuUK4MSs4ar7VzpYCEkp9KPw2z77oNv7Qmd8T4UQYALgOhnt
   bHjUmUHD9EVAll88MNFa8tjQhdoB85/HaVQyh367Q5bsT+b6x8o3xJLEo
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="366912250"
X-IronPort-AV: E=Sophos;i="6.01,184,1684825200"; 
   d="scan'208";a="366912250"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2023 12:31:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10762"; a="713294249"
X-IronPort-AV: E=Sophos;i="6.01,184,1684825200"; 
   d="scan'208";a="713294249"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga007.jf.intel.com with ESMTP; 05 Jul 2023 12:31:35 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 5 Jul 2023 12:31:34 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 5 Jul 2023 12:31:34 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 5 Jul 2023 12:31:34 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 5 Jul 2023 12:31:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YBur3Nj5BLoveVtRLp5vqnxLMwrreW4QXBMO49MtZ9JWUgz7HCe6TZNn3g7yXHPerEZ7njJnyXol/3Cd42JI6nFsQ/TP/Ir98YXklEI/sJQxFWMVeJloH3W1eDSVuctWtGrMPZgY3LjznzIYyPbz2XN34hsuoTHwKL+x+C16oZfpjrwEyoIaNLxxPiXnvnKdzuyZQ87xyLCFFsEIeXn8f6TJeKxy0Ht1K1KaXqkWXvzCB72kfiFkFT7vx+qYjg5KroJ4ob95SsqXY/8VKyRrgRbxTvuUgW6mSP9wUAOnByt5hemG7F0j5BrX1E1pajUfTwkoMa3mBtBALp0gXpLEkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RhIft5p3DTZQ8rr5r52kQlkB8xpOoszhOqYUgSVbBIo=;
 b=iSD9ikZzohzJlGBJV0Rtxiq5s8p5+LekRAEYD0/CmdTEXgYhSEVxSi2IjJPjJ5W4QDSkAf8I/DCrp63tv5DxzjMEZ/2nTBcXzT8shtsfaajFC0qnlqUDNfEDBbrdneH6EmKT3ImQlTpRwH7XDYPhMHM5crtmUreDYILKWJCo3wZa6HD5ZhhsZH4vlbEoNaoM4/Mjsnso/7r+8KHy9UUARs9D5d5d7HZFw6KS+XvcBvkVI6CxOR8DPcAWv7wbTEDT/mf9r+EdC9WB+bMA1eSD7WGAJeBOeK/FcNUtIpVgTM0apUHZkmFdXpeNBWsuwmv1A9u/jo4IxlclSyc2N2aGEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB2937.namprd11.prod.outlook.com (2603:10b6:5:62::13) by
 LV2PR11MB6048.namprd11.prod.outlook.com (2603:10b6:408:178::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Wed, 5 Jul
 2023 19:31:25 +0000
Received: from DM6PR11MB2937.namprd11.prod.outlook.com
 ([fe80::a5d6:4952:530c:f01f]) by DM6PR11MB2937.namprd11.prod.outlook.com
 ([fe80::a5d6:4952:530c:f01f%4]) with mapi id 15.20.6565.016; Wed, 5 Jul 2023
 19:31:25 +0000
Date: Wed, 5 Jul 2023 21:31:19 +0200
From: Michal Kubiak <michal.kubiak@intel.com>
To: Saeed Mahameed <saeed@kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Saeed
 Mahameed" <saeedm@nvidia.com>, <netdev@vger.kernel.org>, Tariq Toukan
	<tariqt@nvidia.com>, Zhengchao Shao <shaozhengchao@huawei.com>, "Rahul
 Rameshbabu" <rrameshbabu@nvidia.com>, Gal Pressman <gal@nvidia.com>, "Simon
 Horman" <simon.horman@corigine.com>
Subject: Re: [net V2 3/9] net/mlx5e: fix memory leak in mlx5e_ptp_open
Message-ID: <ZKXFBxUk32hLnueu@localhost.localdomain>
References: <20230705175757.284614-1-saeed@kernel.org>
 <20230705175757.284614-4-saeed@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230705175757.284614-4-saeed@kernel.org>
X-ClientProxiedBy: FR0P281CA0267.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b5::13) To DM6PR11MB2937.namprd11.prod.outlook.com
 (2603:10b6:5:62::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB2937:EE_|LV2PR11MB6048:EE_
X-MS-Office365-Filtering-Correlation-Id: c3a47ccf-0b3a-4203-dc3b-08db7d8e6c14
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: udFamXR7WLFF5XHwZVqf7yOzdryKLfT3VuiOT4TKVbI7M5p0IrZb6QgD80/IcBba1WPYMESJzNeC+xafd2CDqKNFNmgNs2jfi49uxDkFUsGf0j0J+eJiGMiynphmR2zNnmOUbVQHsMlsWWTRpJjDLtnEQr1HY4TCq+BZOnj5mN+pSuA4LAs1cpkIy17PPFrQM5cSv8IngZbpanhGRLOKF2CBMHbXUM8cjhJtXW+L5b2l0of1ib7S4kf9jJDaGWAnmAbTE0gN3H2YrkDDu60Cfh85v23X24UscBpadbkjGJlKN2r66cRTfp2gtGBxHKZLHxNa2lWxGPBeNMXQmKcWgqunsTTpiW2mXR1151M86yspPowPd9bpIBN5LRwzX6THtxn3YB3nlEZfAw+eBASOor5ZDzbpJC+9svhqMUgGCnsxs2H3cOCarTxuFRllW7GLBz6fcpWoupdqJYmqDXmVkeb18G4h2fRyUyJDElKGfnMH1N2EKvXu+N02QOuM+hrGCvdMseBswl4CInlr/n00ZC+3FFJ+PdGBia2kaxrBVytDxTOE6E81dHiYqRse3WAR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB2937.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(366004)(136003)(346002)(376002)(396003)(451199021)(316002)(4326008)(9686003)(6916009)(66556008)(66946007)(86362001)(66476007)(6506007)(6512007)(186003)(26005)(83380400001)(82960400001)(2906002)(6486002)(38100700002)(41300700001)(478600001)(7416002)(6666004)(44832011)(5660300002)(54906003)(8936002)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kyoc+zfteEH6Y41Guf8qQTTC1dLnfHBPkFHXBUoL0r1o2qArFDoO0ED7MbjA?=
 =?us-ascii?Q?PP9SGaEfCNVGAs8bwmOIk5hjCKzsV7XJMUpjXWFXtl7IFeDkeYP+TTQwAUqu?=
 =?us-ascii?Q?0swDQhBiGMvKbieRBnYO4PfPrC8QCyT7LBuNqtzS9OGx4NSlVBzq5ZQusx9+?=
 =?us-ascii?Q?w6SsfhUEVtIMi58g6J0Xb93lhmlIZ4FYB9oTT3EIjWUF1ZkJ2WtBVmawpEf5?=
 =?us-ascii?Q?i4kOtLQR9IBxc3zP4EPdi+9VSiNRWWLyc+LZen19ipQNj3UCHuE0mkCbQVYw?=
 =?us-ascii?Q?yahEnKJG2nH1kaxB5k93hbF4fQQ7E2ploM/YWEKzMPNISoRLklXd63MRzr0u?=
 =?us-ascii?Q?r84qsXsf8uqXQpCf+gf48wJlamEYQLNI6qWTxbQ1qFi3x8agg+vgRvVhl7Nj?=
 =?us-ascii?Q?engi2pRgAMCSpgAGoQD5OHYb51KRfvbgN2CKuIkOit+NSXMTkftfzOPPJsi8?=
 =?us-ascii?Q?EvzBLCcN1HgW863UWdMLnZD6edhq5jAtCz75fqgxNC7ml4D4nMQ6p97WhTMY?=
 =?us-ascii?Q?wadLZ5nkAvQDVZOIQQIwtfHlZ0PWnEa8lEHgu+Fbor8cniNMRDoThz1sJHu2?=
 =?us-ascii?Q?Yfl6SRMVeOIC5rQ+5hD6TVZiC8edaZpxtVPEwljWW064lC9u+UEphbj32S4G?=
 =?us-ascii?Q?bTm4bornTl7uTzAxHSxsDerWWJLWPlthWPAEL7qIPtCXFrP2FX0QGlG7ObTm?=
 =?us-ascii?Q?JXIfsQA520Jcnr+j4hAU34zf+ccNX7OyjPZrENnQbeUk9+S0F2GxRxm8uuCe?=
 =?us-ascii?Q?jT3pOCrFJQMh2dzLpHIL/bPDUAh6KIV2P8GXOvsTarkmskAWXjcuzRE4Sm5A?=
 =?us-ascii?Q?4TpZUEdxkgzVSekDz84GvpvdAtZKXTV+xzPK9s9NJpq70LPOGuhCoVMpgK19?=
 =?us-ascii?Q?y8lkuo3dfhVq8wwyX/kS69BI9qixuhQDliaxKZi7CwPVZiYaKMCVhX4MDQr3?=
 =?us-ascii?Q?WHekQruEBIGRt8bCgbkZRdmSNdwsjYgsBn/uUlDjC85DqBAugTmISdkW5ICX?=
 =?us-ascii?Q?NAlRICjs6vx7sz/WNBpB9sBnytiICRaapVXtf7Cchp6V+YgH0ODoqhUOibMn?=
 =?us-ascii?Q?RXE+MZzsK0NpxCSVP6qT2cFTJQIi4ZtxnnDzLzQg+HRijN9E2uxz5wxUBs34?=
 =?us-ascii?Q?1ZiRX6/jztOk+e15xoERR14R8b2tiAvIO0VvkYlfAF9ObwyieHFi2F1Mj/Ii?=
 =?us-ascii?Q?mbQCiqffY3TrzdtNrccPJjcQsbbcPN72u5zYslVnf2uW8ywu5ongXqB0hLp/?=
 =?us-ascii?Q?EK+Cc8TiZmWnnzCgL1z2fkSQPlEcWpI6yZ7RcgKCH55WDzTc3l9a00xCqCHh?=
 =?us-ascii?Q?DCyCqTlq53Dgd2896zalXdpCf3LTKTBb9YKS5wj2X3NTAx6isIj6tUzIfLJ4?=
 =?us-ascii?Q?eoo3cXbbg99N/F26TYbRy/zQNd9aswcYCJpRPzk3x6CpV2bOIdT/rSP9X+4j?=
 =?us-ascii?Q?ok9zF3KAw3fdbup6R2W2UI+bCejziLSBvdgHcl9BVN3N2qNDXO97gx054PVe?=
 =?us-ascii?Q?x5BR0MXKVV2eyrFhTJBC5A8ga71TyKV8XIcmz49pokhyyN0k3c9ge3ks27Ie?=
 =?us-ascii?Q?CQYtVj4h34HS7C6wpSIuoz6vzo0Jwy9osH1qF6TAj7hnrmimUts1d0fysVyl?=
 =?us-ascii?Q?vg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c3a47ccf-0b3a-4203-dc3b-08db7d8e6c14
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB2937.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2023 19:31:25.6430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wc3aCv7sQg6rRuQB/lBpLZa2OWxvBzVf+kJJ8G+Kz8P2Pvuqh1AD9sJszSrHv2HwXGaAeZikgl7uH1fJJLrvZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6048
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 05, 2023 at 10:57:51AM -0700, Saeed Mahameed wrote:
> From: Zhengchao Shao <shaozhengchao@huawei.com>
> 
> When kvzalloc_node or kvzalloc failed in mlx5e_ptp_open, the memory
> pointed by "c" or "cparams" is not freed, which can lead to a memory
> leak. Fix by freeing the array in the error path.
> 
> Fixes: 145e5637d941 ("net/mlx5e: Add TX PTP port object support")
> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
> Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
> Reviewed-by: Gal Pressman <gal@nvidia.com>
> Reviewed-by: Simon Horman <simon.horman@corigine.com>
> Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c b/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
> index 3cbebfba582b..b0b429a0321e 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
> @@ -729,8 +729,10 @@ int mlx5e_ptp_open(struct mlx5e_priv *priv, struct mlx5e_params *params,
>  
>  	c = kvzalloc_node(sizeof(*c), GFP_KERNEL, dev_to_node(mlx5_core_dma_dev(mdev)));
>  	cparams = kvzalloc(sizeof(*cparams), GFP_KERNEL);
> -	if (!c || !cparams)
> -		return -ENOMEM;
> +	if (!c || !cparams) {
> +		err = -ENOMEM;
> +		goto err_free;
> +	}
>  
>  	c->priv     = priv;
>  	c->mdev     = priv->mdev;
> -- 
> 2.41.0
> 
> 

Looks OK to me.

Thanks,
Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>

