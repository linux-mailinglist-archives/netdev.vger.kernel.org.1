Return-Path: <netdev+bounces-13351-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5FF73B52F
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 12:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDB98281A8F
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 10:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7941611A;
	Fri, 23 Jun 2023 10:23:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E8A610D
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 10:23:30 +0000 (UTC)
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40D5910F1
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 03:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687515800; x=1719051800;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=K1o6KoJgMeSXbTjRD8XQOY1GsqZI+poFLzhIWwe0Bp8=;
  b=hpyYQlr+kkuFY0MyLpeKdVXCYOEbrd+09wxejRT88Z0u7ULPxeoIPB1X
   zoxKvRcSIjW6dKZy5537PAho/cnDSisvZN0FQXh5aPVAQtZdc/HqykThK
   HzEcX/O0x/eZtYMpIBr4c+2UOG44L1CG2C5EpoI/gf2zqhpUoGJ047n/Y
   20koBMsJznpdcx7X2smAuiChGYpcJpGx8Mb5C7U9vHDpwCRARV1qk/bIS
   fJvVWud53ZxC+EA3mOGjt0LtxBVCnp1UBsf5A97Pt6HB3Picgxa/RZeFb
   9etlu+S9tFucVgNjFBqFiuAp4Uowj9SZTEn363+k8dVps1LX0PTGPyIVB
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="363288373"
X-IronPort-AV: E=Sophos;i="6.01,151,1684825200"; 
   d="scan'208";a="363288373"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2023 03:23:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="785294523"
X-IronPort-AV: E=Sophos;i="6.01,151,1684825200"; 
   d="scan'208";a="785294523"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga004.fm.intel.com with ESMTP; 23 Jun 2023 03:23:19 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 23 Jun 2023 03:23:18 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 23 Jun 2023 03:23:18 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 23 Jun 2023 03:23:18 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 23 Jun 2023 03:23:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cw0LcZWueMXpaGsppxif1UG5M75+2AjllSd86j8Y1WCGFd4rtiuzJPZvlgXonikqaHmHwLlNNs0kH7vDFIeFclGVM1Oh7XyIkCDXi5K0IS3X7sVewvJopRHe9Atr8oMSBtWrO7pWZ5VyoiE0qK3tO2dqTpKUOFwzL96PG719zeHj8O2NwE29o1OFUHECH4URWA3WY90w+EgUuHhwt+me/eNG84bWowOj+Ts7A1QBQTD5IzLKhPBmWeizEZht24FNCViRtuJhi0BhDS+KC0TaPNc/kqIcQqiIVqPsvlNWinh7W6tzyw9z9h9nU4I/qt8sWlTg99XSQr9LBuCloQydJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MkoMVoZStiw0cLuDtyp0WDMUxUsw8HX1n/RXmIzM7Z4=;
 b=CuhUIbu22OW3dhyaK5UFzQ4L4TJRlBNimiovcZa2EfoUH3nNGmTiJIgFif94T+l+BOwbPbCPAio+166jBmkOlAwfGUuYwaajPrcG3W2tXT74vOaHmz0qwncsHkKvlC17qNtfMVJaZP2+oBhP9Lfv8f0N5cwl2EMjNxUUgNbwjx1whZ4gCnPBOs0CfsSZLyZ6UA2W4FWRRs5K0dQAFW8V+0RFx5E8DuXpOg9/ucfo2anB6gdqtri00tdAfpVNB0di3CfmMmu69etX6YOusnf5L5wm4yFNQeKGbsMokqD/pzWwfpC1VXI5NnpgYBgPtS2/xtwXQhqQHf7bakXQnA3OsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 PH0PR11MB4872.namprd11.prod.outlook.com (2603:10b6:510:32::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.24; Fri, 23 Jun 2023 10:23:16 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::9e4f:80cc:e0aa:6809]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::9e4f:80cc:e0aa:6809%2]) with mapi id 15.20.6521.024; Fri, 23 Jun 2023
 10:23:15 +0000
Date: Fri, 23 Jun 2023 12:23:07 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <netdev@vger.kernel.org>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Michal Swiatkowski
	<michal.swiatkowski@linux.intel.com>, Michal Wilczynski
	<michal.wilczynski@intel.com>, Simon Horman <simon.horman@corigine.com>,
	Arpana Arland <arpanax.arland@intel.com>
Subject: Re: [PATCH net-next 4/6] ice: remove null checks before devm_kfree()
 calls
Message-ID: <ZJVyiOwdVQ6btr53@boxer>
References: <20230622183601.2406499-1-anthony.l.nguyen@intel.com>
 <20230622183601.2406499-5-anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230622183601.2406499-5-anthony.l.nguyen@intel.com>
X-ClientProxiedBy: BE1P281CA0034.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:22::16) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|PH0PR11MB4872:EE_
X-MS-Office365-Filtering-Correlation-Id: f38dbc0a-5588-4c72-9420-08db73d3daef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: USTxFJ4MiKMMxzMZyygqbzcZciLH7+yZeuV1XOSaOiGtEaC6Pzy69JP7CAsmk/NH3VXdQF5z5unNh0TwCgorc/dzsY1BCuHDRQisKzhpMXR9WdDF2+pBGqCVn18vgOrRpSH5aKDH/ViZD3w3D4ZX7GdzV4rffLujd4ktKaJQaeda8xL7iaFQlk9IeAH2dy8LAdJ3kXUGe+JuegRPiU1Gv1T8CDNQBlI0rxpgOVLiefEXJ3cnYWvKOtKFEHoroIvhUeawN2VNwU9YxxQaoLGwIXI46z22fEATGRO8CtYHkOJF87s0wPQpjkavwFh+4mwcuT1lS8Yoq6/GcL9wQNP9xVojwyELBBb97gJSzjb31a3Qj1FvaYP0tTyapkpvOhBByH7vO1sS+qUPV0D+gIq5SO5T4SeFHJ7ba+Z6AFoTQjo81Jn4MlmT6oIWl9bv2SJQvL5HyOb1us2ihjFWbKITjvuIqhNdSunIMv4qKNQysVq1Q2g18U8s/W2l3Y+CCKpti3nqkeKESZpVbG9AAzTs9lOXUdqyNGGQSs6us+BM18w3xrQcUyQiWijSwQas0Wxv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(39860400002)(376002)(396003)(346002)(366004)(136003)(451199021)(8936002)(2906002)(6862004)(38100700002)(66946007)(66556008)(66476007)(6636002)(86362001)(4326008)(316002)(6486002)(83380400001)(54906003)(41300700001)(8676002)(186003)(5660300002)(82960400001)(9686003)(6666004)(6512007)(44832011)(26005)(33716001)(66899021)(6506007)(478600001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ANVnd6vTjA+FD4ULlwyhMXTgtkWd//8AsVXc9fbG5Hki2Zk0bGUAh4by/Vvr?=
 =?us-ascii?Q?O9nbDrWFMjA6yWilSg1uFuhNvhZ7Dji5K+MWToR5xHxKVW4x5+ID2geJxj9r?=
 =?us-ascii?Q?2mhPOvcJ/E+b0eyJlPtDYyC9byE1JgG0Ucj31Thbs1BiikNR573L2dInbpZO?=
 =?us-ascii?Q?lNEY5b7VjkotwWZfe2zEJc2gvIBp0GVBXS7FlGvthjl2ftkt0uQ3pmkc0xOR?=
 =?us-ascii?Q?m1B379HesVU+xmlRYIWgKfd1jUOmqpsLXwJ/zBzDlNcbwwtSEvdsfbggDYfB?=
 =?us-ascii?Q?Kw5lD5VuKecrE9XoEuFo9be6OWU9pL2EfkZyEADAdo0SUmXUlnlnWOc25rJe?=
 =?us-ascii?Q?XJ+6RDslGR8XamqR8CHum7s2ZOR1+y5ERxPwz4E2Xkc1qmlJUDfhqyA0Fev3?=
 =?us-ascii?Q?cyaEp0zeEriSLfmPskMhEja3nJhPKZ5dvIz6SmvbqR0FA5z9soiJgky7pWyg?=
 =?us-ascii?Q?gr/c+DVoI7+FQkcl/1xF8I/HtVlbsEqRu3vOqH2W3QYuDrJJG3fiKTpZ5sVu?=
 =?us-ascii?Q?GIa5E60gyrAqHuoew5h52FQE8QZWnisXL0mDXjNka8EWyk99sd1i+SKmPFJI?=
 =?us-ascii?Q?cBy5Se+SgM3s50wlqTb1hB/vWJccjeCl9VCdpGykkCKXZzpB46DqeefChv+d?=
 =?us-ascii?Q?vWtQlZVGBwF74YiT3eHo0iMwnBT56Fcgtrps+rDutG1jle+smyQiSwW1FknU?=
 =?us-ascii?Q?m48+B9vPd2dRjrM/Ebp38nOiF7mq5t1w5S0JyVwNDlStmt1R0TU7+KnMDtj5?=
 =?us-ascii?Q?SZ2n4bVTe44ExqrvJlGBPDic2qgXoEznbDR5/xWqv1XxwqVFMwUEtS4PjDxl?=
 =?us-ascii?Q?6nqXfpqhc6hhSJ755HoCQ1E1kZz+zhTFjyDMqRYPh9C/QisIhBXlMPrdROT8?=
 =?us-ascii?Q?t2tWXXxcdH7THF2X5VHmkWCzb7omiR/OYmF70Aqkin8+qiUt2cluVQf8Azlx?=
 =?us-ascii?Q?lhWgIN6Rq1pLpQqgI3x+5aVxbWXZWS0v5o/VOgkpGF7Y/FgKzcZasIjQKJrA?=
 =?us-ascii?Q?Kco0hK5CBXkQ9Sgzp2NrEVf0YZ6fVBYRggB85i+D6IPOaFx8JLbyRWpgXfmC?=
 =?us-ascii?Q?EZS/qx/FTKuy0Fn8lnwupo5djQfpszatMMb83xghuXLR35N4qIryi+CbEUSX?=
 =?us-ascii?Q?XhX0YOeO8RYl7HwMFnsmj1Qp+wedrgpTLboYzsjarkogq5mVi2/+m68+S+bf?=
 =?us-ascii?Q?vfeSdg7z8ICY1iZaQ5gGaFvKmxoswT/J07IK/RcJeZJSWOsgMKO+F3jeLFNq?=
 =?us-ascii?Q?cN3u2l1y01k0lzs7nYjxQdF6UIhQJmrkUERW0QoMWbb3Pca6/uPD6eWC4Z0l?=
 =?us-ascii?Q?nlxpumEDjMWuPBUsYyvDABSQoNjFRlEOtfsgTZ7ttfc7iHyWml84DJB3R2uY?=
 =?us-ascii?Q?KsSqzaG85MPTwszz8mq6xX9dQ1JCnHbtA/W//eSejrppwFAG6ALAKJK/2JBr?=
 =?us-ascii?Q?Sv1NYKCmGIAc109FZGw5HmynKAVPZOuJBTNHnBmXQ56lFrYoSAbIjZl7k6Mo?=
 =?us-ascii?Q?zdypJekXI93FwTXPIuJmUAbN42ekXMFF5UiIODwIPQypeuhb7qor51bnI4kO?=
 =?us-ascii?Q?Titgce7f0TJkQAvp1zeSrLuzh6oifkljzjEIzZdvqPWKi5sNNt3Nc3sZYr/d?=
 =?us-ascii?Q?lw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f38dbc0a-5588-4c72-9420-08db73d3daef
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 10:23:15.3318
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R/aAAytbMyVRBXNUKehX6CfouS0CuCAUNnznNogDF9H7ssVlWt0IlPzsaeb9JmjqC0KXm2QeTNzWIXd6RiuioYFcdJbNCDwgjNZTiMNO+/Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4872
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jun 22, 2023 at 11:35:59AM -0700, Tony Nguyen wrote:
> From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> 
> We all know they are redundant.

Przemek,

Ok, they are redundant, but could you also audit the driver if these devm_
allocations could become a plain kzalloc/kfree calls?

> 
> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Reviewed-by: Michal Wilczynski <michal.wilczynski@intel.com>
> Reviewed-by: Simon Horman <simon.horman@corigine.com>
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Tested-by: Arpana Arland <arpanax.arland@intel.com> (A Contingent worker at Intel)
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_common.c   |  6 +--
>  drivers/net/ethernet/intel/ice/ice_controlq.c |  3 +-
>  drivers/net/ethernet/intel/ice/ice_flow.c     | 23 ++--------
>  drivers/net/ethernet/intel/ice/ice_lib.c      | 42 +++++++------------
>  drivers/net/ethernet/intel/ice/ice_sched.c    | 11 ++---
>  drivers/net/ethernet/intel/ice/ice_switch.c   | 19 +++------
>  6 files changed, 29 insertions(+), 75 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
> index eb2dc0983776..6acb40f3c202 100644
> --- a/drivers/net/ethernet/intel/ice/ice_common.c
> +++ b/drivers/net/ethernet/intel/ice/ice_common.c
> @@ -814,8 +814,7 @@ static void ice_cleanup_fltr_mgmt_struct(struct ice_hw *hw)
>  				devm_kfree(ice_hw_to_dev(hw), lst_itr);
>  			}
>  		}
> -		if (recps[i].root_buf)
> -			devm_kfree(ice_hw_to_dev(hw), recps[i].root_buf);
> +		devm_kfree(ice_hw_to_dev(hw), recps[i].root_buf);
>  	}
>  	ice_rm_all_sw_replay_rule_info(hw);
>  	devm_kfree(ice_hw_to_dev(hw), sw->recp_list);
> @@ -1011,8 +1010,7 @@ static int ice_cfg_fw_log(struct ice_hw *hw, bool enable)
>  	}
>  
>  out:
> -	if (data)
> -		devm_kfree(ice_hw_to_dev(hw), data);
> +	devm_kfree(ice_hw_to_dev(hw), data);
>  
>  	return status;
>  }
> diff --git a/drivers/net/ethernet/intel/ice/ice_controlq.c b/drivers/net/ethernet/intel/ice/ice_controlq.c
> index 385fd88831db..e7d2474c431c 100644
> --- a/drivers/net/ethernet/intel/ice/ice_controlq.c
> +++ b/drivers/net/ethernet/intel/ice/ice_controlq.c
> @@ -339,8 +339,7 @@ do {									\
>  		}							\
>  	}								\
>  	/* free the buffer info list */					\
> -	if ((qi)->ring.cmd_buf)						\
> -		devm_kfree(ice_hw_to_dev(hw), (qi)->ring.cmd_buf);	\
> +	devm_kfree(ice_hw_to_dev(hw), (qi)->ring.cmd_buf);		\
>  	/* free DMA head */						\
>  	devm_kfree(ice_hw_to_dev(hw), (qi)->ring.dma_head);		\
>  } while (0)
> diff --git a/drivers/net/ethernet/intel/ice/ice_flow.c b/drivers/net/ethernet/intel/ice/ice_flow.c
> index ef103e47a8dc..85cca572c22a 100644
> --- a/drivers/net/ethernet/intel/ice/ice_flow.c
> +++ b/drivers/net/ethernet/intel/ice/ice_flow.c
> @@ -1303,23 +1303,6 @@ ice_flow_find_prof_id(struct ice_hw *hw, enum ice_block blk, u64 prof_id)
>  	return NULL;
>  }
>  
> -/**
> - * ice_dealloc_flow_entry - Deallocate flow entry memory
> - * @hw: pointer to the HW struct
> - * @entry: flow entry to be removed
> - */
> -static void
> -ice_dealloc_flow_entry(struct ice_hw *hw, struct ice_flow_entry *entry)
> -{
> -	if (!entry)
> -		return;
> -
> -	if (entry->entry)
> -		devm_kfree(ice_hw_to_dev(hw), entry->entry);
> -
> -	devm_kfree(ice_hw_to_dev(hw), entry);
> -}
> -
>  /**
>   * ice_flow_rem_entry_sync - Remove a flow entry
>   * @hw: pointer to the HW struct
> @@ -1335,7 +1318,8 @@ ice_flow_rem_entry_sync(struct ice_hw *hw, enum ice_block __always_unused blk,
>  
>  	list_del(&entry->l_entry);
>  
> -	ice_dealloc_flow_entry(hw, entry);
> +	devm_kfree(ice_hw_to_dev(hw), entry->entry);
> +	devm_kfree(ice_hw_to_dev(hw), entry);
>  
>  	return 0;
>  }
> @@ -1662,8 +1646,7 @@ ice_flow_add_entry(struct ice_hw *hw, enum ice_block blk, u64 prof_id,
>  
>  out:
>  	if (status && e) {
> -		if (e->entry)
> -			devm_kfree(ice_hw_to_dev(hw), e->entry);
> +		devm_kfree(ice_hw_to_dev(hw), e->entry);
>  		devm_kfree(ice_hw_to_dev(hw), e);
>  	}
>  
> diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
> index 5ddb95d1073a..00e3afd507a4 100644
> --- a/drivers/net/ethernet/intel/ice/ice_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
> @@ -321,31 +321,19 @@ static void ice_vsi_free_arrays(struct ice_vsi *vsi)
>  
>  	dev = ice_pf_to_dev(pf);
>  
> -	if (vsi->af_xdp_zc_qps) {
> -		bitmap_free(vsi->af_xdp_zc_qps);
> -		vsi->af_xdp_zc_qps = NULL;
> -	}
> +	bitmap_free(vsi->af_xdp_zc_qps);
> +	vsi->af_xdp_zc_qps = NULL;
>  	/* free the ring and vector containers */
> -	if (vsi->q_vectors) {
> -		devm_kfree(dev, vsi->q_vectors);
> -		vsi->q_vectors = NULL;
> -	}
> -	if (vsi->tx_rings) {
> -		devm_kfree(dev, vsi->tx_rings);
> -		vsi->tx_rings = NULL;
> -	}
> -	if (vsi->rx_rings) {
> -		devm_kfree(dev, vsi->rx_rings);
> -		vsi->rx_rings = NULL;
> -	}
> -	if (vsi->txq_map) {
> -		devm_kfree(dev, vsi->txq_map);
> -		vsi->txq_map = NULL;
> -	}
> -	if (vsi->rxq_map) {
> -		devm_kfree(dev, vsi->rxq_map);
> -		vsi->rxq_map = NULL;
> -	}
> +	devm_kfree(dev, vsi->q_vectors);
> +	vsi->q_vectors = NULL;
> +	devm_kfree(dev, vsi->tx_rings);
> +	vsi->tx_rings = NULL;
> +	devm_kfree(dev, vsi->rx_rings);
> +	vsi->rx_rings = NULL;
> +	devm_kfree(dev, vsi->txq_map);
> +	vsi->txq_map = NULL;
> +	devm_kfree(dev, vsi->rxq_map);
> +	vsi->rxq_map = NULL;
>  }
>  
>  /**
> @@ -902,10 +890,8 @@ static void ice_rss_clean(struct ice_vsi *vsi)
>  
>  	dev = ice_pf_to_dev(pf);
>  
> -	if (vsi->rss_hkey_user)
> -		devm_kfree(dev, vsi->rss_hkey_user);
> -	if (vsi->rss_lut_user)
> -		devm_kfree(dev, vsi->rss_lut_user);
> +	devm_kfree(dev, vsi->rss_hkey_user);
> +	devm_kfree(dev, vsi->rss_lut_user);
>  
>  	ice_vsi_clean_rss_flow_fld(vsi);
>  	/* remove RSS replay list */
> diff --git a/drivers/net/ethernet/intel/ice/ice_sched.c b/drivers/net/ethernet/intel/ice/ice_sched.c
> index b7682de0ae05..b664d60fd037 100644
> --- a/drivers/net/ethernet/intel/ice/ice_sched.c
> +++ b/drivers/net/ethernet/intel/ice/ice_sched.c
> @@ -358,10 +358,7 @@ void ice_free_sched_node(struct ice_port_info *pi, struct ice_sched_node *node)
>  				node->sibling;
>  	}
>  
> -	/* leaf nodes have no children */
> -	if (node->children)
> -		devm_kfree(ice_hw_to_dev(hw), node->children);
> -
> +	devm_kfree(ice_hw_to_dev(hw), node->children);
>  	kfree(node->name);
>  	xa_erase(&pi->sched_node_ids, node->id);
>  	devm_kfree(ice_hw_to_dev(hw), node);
> @@ -859,10 +856,8 @@ void ice_sched_cleanup_all(struct ice_hw *hw)
>  	if (!hw)
>  		return;
>  
> -	if (hw->layer_info) {
> -		devm_kfree(ice_hw_to_dev(hw), hw->layer_info);
> -		hw->layer_info = NULL;
> -	}
> +	devm_kfree(ice_hw_to_dev(hw), hw->layer_info);
> +	hw->layer_info = NULL;
>  
>  	ice_sched_clear_port(hw->port_info);
>  
> diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c b/drivers/net/ethernet/intel/ice/ice_switch.c
> index 2ea9e1ae5517..6db4ca7978cb 100644
> --- a/drivers/net/ethernet/intel/ice/ice_switch.c
> +++ b/drivers/net/ethernet/intel/ice/ice_switch.c
> @@ -1636,21 +1636,16 @@ ice_save_vsi_ctx(struct ice_hw *hw, u16 vsi_handle, struct ice_vsi_ctx *vsi)
>   */
>  static void ice_clear_vsi_q_ctx(struct ice_hw *hw, u16 vsi_handle)
>  {
> -	struct ice_vsi_ctx *vsi;
> +	struct ice_vsi_ctx *vsi = ice_get_vsi_ctx(hw, vsi_handle);
>  	u8 i;
>  
> -	vsi = ice_get_vsi_ctx(hw, vsi_handle);
>  	if (!vsi)
>  		return;
>  	ice_for_each_traffic_class(i) {
> -		if (vsi->lan_q_ctx[i]) {
> -			devm_kfree(ice_hw_to_dev(hw), vsi->lan_q_ctx[i]);
> -			vsi->lan_q_ctx[i] = NULL;
> -		}
> -		if (vsi->rdma_q_ctx[i]) {
> -			devm_kfree(ice_hw_to_dev(hw), vsi->rdma_q_ctx[i]);
> -			vsi->rdma_q_ctx[i] = NULL;
> -		}
> +		devm_kfree(ice_hw_to_dev(hw), vsi->lan_q_ctx[i]);
> +		vsi->lan_q_ctx[i] = NULL;
> +		devm_kfree(ice_hw_to_dev(hw), vsi->rdma_q_ctx[i]);
> +		vsi->rdma_q_ctx[i] = NULL;
>  	}
>  }
>  
> @@ -5468,9 +5463,7 @@ ice_add_adv_recipe(struct ice_hw *hw, struct ice_adv_lkup_elem *lkups,
>  		devm_kfree(ice_hw_to_dev(hw), fvit);
>  	}
>  
> -	if (rm->root_buf)
> -		devm_kfree(ice_hw_to_dev(hw), rm->root_buf);
> -
> +	devm_kfree(ice_hw_to_dev(hw), rm->root_buf);
>  	kfree(rm);
>  
>  err_free_lkup_exts:
> -- 
> 2.38.1
> 
> 

