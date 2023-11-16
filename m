Return-Path: <netdev+bounces-48371-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFEBD7EE2AA
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 15:22:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60C6E280CF5
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 14:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 219E631A76;
	Thu, 16 Nov 2023 14:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f09PlHsk"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A09A5187
	for <netdev@vger.kernel.org>; Thu, 16 Nov 2023 06:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700144558; x=1731680558;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=2AjTxExKgm3JfSLAN/eoI64p/Q+GnMB5n6aJAh3mxNY=;
  b=f09PlHskoFSZtlShk1Qi2js8YKrwbo53dujpNZN8yQndYd8muY/h3yAn
   2wHi4KhJDUnRU2b1o6VmK2dBAdMKWYdfQeu5ghkGUQYslFvJlXvfUNQeX
   EpBoZggQZVA8gNz3TThENGLL2/lfnx06fjygO0Fb6q6l75ZtUIsZOgexU
   6MzBXhNQ1TRocljzvb7pUyVDp+IgUiiPPZrYQWwCwTBo+bI7Hai9+XVq9
   fdLfm+4gXOHXoJKiUERYiVhwh9Blc+9E5sFQLkIuPJs1OaYq2zusfLRIL
   ztZyBVwUkeN/EEnNF/YAkqX4/JXXz+TROBufi3DPij9cAA3DjzD8CrziU
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="457588329"
X-IronPort-AV: E=Sophos;i="6.04,308,1695711600"; 
   d="scan'208";a="457588329"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2023 06:22:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10896"; a="831276319"
X-IronPort-AV: E=Sophos;i="6.04,308,1695711600"; 
   d="scan'208";a="831276319"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 16 Nov 2023 06:22:26 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 16 Nov 2023 06:22:26 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 16 Nov 2023 06:22:26 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Thu, 16 Nov 2023 06:22:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G/igZGQ9usOZwz3jTfdk9ZUDbF8jmmQH/xNnooWUVW6KbKmtjbFSOnDLTRuAJAj9IhOipC2j3GsMBKPtMm9Tbq/GQ3fLXAfXkSvIPeWxLYkZSlzPW/3p6DOw4c6HbvdhYDycrp2MXrhBEyEgHiG5bG7xaHzjBJ+XYWCBnaUUA26jm7CxKJeUd24kaxvCamp8epafDsWxfa6GcBi6VaO3+W4JE809spnuujqvNaw9PQzi+f5gN7Cir9nY3y9R+Y27EA4OBZyfdXEKDm1L5E4FVCkYkIk5mVuTx/evcTHj1utPeggH+1s8whDgNcMJV0X55TTaCa1eDOYQFu6Z9I3MPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9o6PtYLXjf8YeZPAc6Gj9IKH5D/WkBUjmkV148XfnZQ=;
 b=XPQmfaXPy5RP6ZzNSSgWSu2cb8pE5syTk5HZvcIShRWgylCIkY4R1m1OSeULefaPRS6WQJrhgkGw039rbJY90LY7UP5BBQr00ZJfvYw9V3eL6LBv7Wth43kT3pM4uEKkpwwXmNaFALf5TajRZJ0b0gnzKJMJkYKRybNCapb6s+8s4UOgb33rBFRbd3VrmBD0t54de2NAuYU6315BWCs5I7Zpehb1MeKok8cfJHT4F9OyYRafmxFnSCF30C1HWRD2T7dsFyTpEVCzryLPCzx6AopDuaBIDr5CoFkyd26T84ivbWjPFEcHJAAPMw5tXVje8xnu2filb5LJOFmajysx+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 PH0PR11MB5062.namprd11.prod.outlook.com (2603:10b6:510:3e::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7002.17; Thu, 16 Nov 2023 14:22:24 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ee54:9452:634e:8c53]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ee54:9452:634e:8c53%7]) with mapi id 15.20.7002.021; Thu, 16 Nov 2023
 14:22:24 +0000
Date: Thu, 16 Nov 2023 15:22:12 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <netdev@vger.kernel.org>, Dave Ertman
	<david.m.ertman@intel.com>, <carolyn.wyborny@intel.com>,
	<daniel.machon@microchip.com>, Przemek Kitszel
	<przemyslaw.kitszel@intel.com>, Sujai Buvaneswaran
	<sujai.buvaneswaran@intel.com>
Subject: Re: [PATCH net] ice: Fix VF Reset paths when interface in a failed
 over aggregate
Message-ID: <ZVYllBDzdLIB97e2@boxer>
References: <20231115211242.1747810-1-anthony.l.nguyen@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231115211242.1747810-1-anthony.l.nguyen@intel.com>
X-ClientProxiedBy: DUZPR01CA0333.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::27) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|PH0PR11MB5062:EE_
X-MS-Office365-Filtering-Correlation-Id: e683e250-462c-47f8-88e2-08dbe6af73df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gz+9TIWBd9gio/cBBAJajVwSCpibK0lCkC5cJTAYb/WsA8k2eWwmcxpefOjZwfjg2sVNQyFFvPEm2y15s93W/v9dUTB/92dIko6aQuuR9OgPlHz1XS+0eveY0oKwYU+sulLTLFHIkupyzKQoUXcU1sApCaJyvUxyDCl3QwhZIRM3yQRXrWrqTUSs717kpLgxG0e2J5RPjkL0tTAJbwukA/wlCbpEbRf08A7DQj9VU2ShVyB9EScuz5egI5Ujv6YMOnxjaa0hMGd7USq7WiMLPINt67qmXOUl/Xf/wFx564sCBTAH+/0JH11ZR5qZ73HO7Z0LGHdEMXSyYHb1TEab7L6M0ALLPuzGJptf/4xOSXCl7YGW0RX7otoq4iUbpnzF/HO+lFNsy7kUj0+Y8YX4X4B0aCEowJ3Vb7m5vTAeZef+ufzyVCyxE8yAKqfGve96UVz8HmHP0y62GdBBlm9orsLDfGl22GDmzoTJWSsC5O6thg0kiiTRkcEHWrb0OkCKlZvh8J7033Tb3XMgz8RADAG0L3CKCzWcuxDFu1yJWXg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(376002)(39860400002)(136003)(396003)(346002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(966005)(6486002)(66946007)(54906003)(66556008)(107886003)(66476007)(316002)(6636002)(478600001)(8936002)(8676002)(6862004)(6666004)(6506007)(6512007)(44832011)(9686003)(4326008)(86362001)(33716001)(41300700001)(83380400001)(82960400001)(5660300002)(26005)(38100700002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nocDkEsJi8zoUfi2gMM4K8AYXjhpm/TzTEbkSDUbkVQKHu6kFMJTFG2zqKCu?=
 =?us-ascii?Q?gf/+QBTEYPCvv68HEWaG71PoKu8FIDEetRk2u5tSQujCth2l37K0Pyy+7Use?=
 =?us-ascii?Q?rEpomP85OxHb21rTPdFStIpxPX+lyk32TJ1HSwsMNIiI86E0C9kwqmvdc6eu?=
 =?us-ascii?Q?I4FUm8Lloeetnl2sTCaAEMNs2pysgwFWvEYU3GypyF12S/DL5iaQVdyUBJgc?=
 =?us-ascii?Q?bk+EDg/5ysCi6DpuIsUb5FHVYUsabI7LP5C7qLpVGbBRt2Z7vLp7+NfWynvE?=
 =?us-ascii?Q?XhNdVI12Dv4f0trBUmjCdLQ/0nb9viyHeQw948WPj3ICIb0Ltd77Ke5V2QsM?=
 =?us-ascii?Q?sVMoAv38JNdHHzFhSFQGZQEZXapgQActcj5IXYvu2HRLdSqwrzDG+zzmTpe3?=
 =?us-ascii?Q?3jCkPeYRbn7poIkM3Fftrg6kX47sDqowbYMGH7Fm5ZSd62Z+bqQDQWxquzd7?=
 =?us-ascii?Q?WbOy1+P2lJlU3pi3H5fify2MtYAdWe52IKcnkQEYIwK8x1rIHkIfkm2KVD6v?=
 =?us-ascii?Q?dHkBP6ZAUIYxgpRbY0/edNTNat0odm6oxio3zgUxL2eisr/uW6CUC2Ud5rF3?=
 =?us-ascii?Q?EliEP8jAHOE5odWGSVCxp8ImdT4+1tuIIBcta+gNipn/v3fZAGOv9NmYeB3h?=
 =?us-ascii?Q?+HYDGRBzC6AWe+EjH7zY0aUC/XfOJ1IpF7yT9bzLdnPHIUELCmgbURtTs0OM?=
 =?us-ascii?Q?GgFudvI4cwo3JMKuAlyPOQNxeayXnVQYo7+S0hCrUXxNGoN0Eyfe9WiBP5Ek?=
 =?us-ascii?Q?yHEURp5vTkiwpxm3SV3aUkYrVQpWF8wX5RqWsWrmwxVPvx5N6ky2EENgUNG+?=
 =?us-ascii?Q?cBNtfp11d6xJjlts+1SqyQifAYANF+uP5ps+hXcOk8IkF5BU/eSBpNGJ552y?=
 =?us-ascii?Q?PyTJ+pLC+6FojBBfw+3em4SOtt/UHFud3/n/iJ1N8fEVNpxyzRRu4LCYS7BQ?=
 =?us-ascii?Q?Ci11+N2LF7+ahFKRSqzstWf9va+S7bhIdv5Eq7YiRL7iHOaULyAjsnqLSczf?=
 =?us-ascii?Q?S68khXbAFYtBK2R6ZBq1Lf3pFuxIxynF5PXcAol5HYOjk8z5+tyNHo03iTup?=
 =?us-ascii?Q?7eS2ge10CsZXybkR1wOAbkDvrk3XDg3pg9TEYV+cmndIlqSHdZQmPAiRI4R+?=
 =?us-ascii?Q?hs5TrGO4PKveM1/V6ptLGQfbW849W7NEoJ+YTShQZJlD0HgmzBamaWlGALIM?=
 =?us-ascii?Q?ToErYFJ7jBmNu08QlPHOwlW+zu1y3xI0J0oUcy8K7GeUV4b+FeqAULC4Zz0M?=
 =?us-ascii?Q?Kgg8PfztKXy/fy6sRYnVogQDRvlxD9ZH4C8p54RZEm6LE5vmtSVFD+df7u2o?=
 =?us-ascii?Q?peLb2XzXo0j4Sge3M02Xm6oKk4pBzfXbBbqrfy4GaZ1VQ6MaGhlPSdRtIw2N?=
 =?us-ascii?Q?IyPLPvGrLROKiUwQeFajsuF9QXo9Os3T9eHpwYuaCZNeIIXdFiNuu58aasuF?=
 =?us-ascii?Q?y5MtuOgxThwUXThMT3ztb9Xz3W+tUcdQyKmaSW9TK5Y6ZhPRCnNcSpasRLUE?=
 =?us-ascii?Q?S0H39AmF99Lw24x5nUJfzju+YvJ/dgYpQFbTxkh7yPIa2UKFQ6yW/jGXTNej?=
 =?us-ascii?Q?GiG955+6IQ6jpLe4NxBFYpfrRNOgK67l8NqaqjGyXj5+iLUHLROfBF9UYOAR?=
 =?us-ascii?Q?ng=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e683e250-462c-47f8-88e2-08dbe6af73df
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2023 14:22:24.2005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TP5JGOvYNA22bqlu5oP9LM/wDFbE2V1yfb1dhvL31etuWvLQPQn5+qHtKMuUUFbNpZDqG1WCr5xvOY7N95ItaxcyaZxJZ39l5wTpnZ4A6mM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5062
X-OriginatorOrg: intel.com

On Wed, Nov 15, 2023 at 01:12:41PM -0800, Tony Nguyen wrote:
> From: Dave Ertman <david.m.ertman@intel.com>
> 
> There is an error when an interface has the following conditions:
> - PF is in an aggregate (bond)
> - PF has VFs created on it
> - bond is in a state where it is failed-over to the secondary interface
> - A VF reset is issued on one or more of those VFs
> 
> The issue is generated by the originating PF trying to rebuild or
> reconfigure the VF resources.  Since the bond is failed over to the
> secondary interface the queue contexts are in a modified state.
> 
> To fix this issue, have the originating interface reclaim its resources
> prior to the tear-down and rebuild or reconfigure.  Then after the process
> is complete, move the resources back to the currently active interface.
> 
> There are multiple paths that can be used depending on what triggered the
> event, so create a helper function to move the queues and use paired calls
> to the helper (back to origin, process, then move back to active interface)
> under the same lag_mutex lock.
> 
> Fixes: 1e0f9881ef79 ("ice: Flesh out implementation of support for SRIOV on bonded interface")
> Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
> This is the net patch mentioned yesterday:
> https://lore.kernel.org/netdev/71058999-50d9-cc17-d940-3f043734e0ee@intel.com/
> 
>  drivers/net/ethernet/intel/ice/ice_lag.c      | 42 +++++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_lag.h      |  1 +
>  drivers/net/ethernet/intel/ice/ice_vf_lib.c   | 20 +++++++++
>  drivers/net/ethernet/intel/ice/ice_virtchnl.c | 25 +++++++++++
>  4 files changed, 88 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_lag.c b/drivers/net/ethernet/intel/ice/ice_lag.c
> index cd065ec48c87..9eed93baa59b 100644
> --- a/drivers/net/ethernet/intel/ice/ice_lag.c
> +++ b/drivers/net/ethernet/intel/ice/ice_lag.c
> @@ -679,6 +679,48 @@ static void ice_lag_move_vf_nodes(struct ice_lag *lag, u8 oldport, u8 newport)
>  			ice_lag_move_single_vf_nodes(lag, oldport, newport, i);
>  }
>  
> +/**
> + * ice_lag_move_vf_nodes_cfg - move VF nodes outside LAG netdev event context
> + * @lag: local lag struct
> + * @src_prt: lport value for source port
> + * @dst_prt: lport value for destination port
> + *
> + * This function is used to move nodes during an out-of-netdev-event situation,
> + * primarily when the driver needs to reconfigure or recreate resources.
> + *
> + * Must be called while holding the lag_mutex to avoid lag events from
> + * processing while out-of-sync moves are happening.  Also, paired moves,
> + * such as used in a reset flow, should both be called under the same mutex
> + * lock to avoid changes between start of reset and end of reset.
> + */
> +void ice_lag_move_vf_nodes_cfg(struct ice_lag *lag, u8 src_prt, u8 dst_prt)
> +{
> +	struct ice_lag_netdev_list ndlist, *nl;
> +	struct list_head *tmp, *n;
> +	struct net_device *tmp_nd;
> +
> +	INIT_LIST_HEAD(&ndlist.node);
> +	rcu_read_lock();
> +	for_each_netdev_in_bond_rcu(lag->upper_netdev, tmp_nd) {

Why do you need rcu section for that?

under mutex? lacking context here.

> +		nl = kzalloc(sizeof(*nl), GFP_ATOMIC);

do these have to be new allocations or could you just use list_move?

> +		if (!nl)
> +			break;
> +
> +		nl->netdev = tmp_nd;
> +		list_add(&nl->node, &ndlist.node);

list_add_rcu ?

> +	}
> +	rcu_read_unlock();

you have the very same chunk of code in ice_lag_move_new_vf_nodes(). pull
this out to common function?

...and in ice_lag_rebuild().

> +	lag->netdev_head = &ndlist.node;
> +	ice_lag_move_vf_nodes(lag, src_prt, dst_prt);
> +
> +	list_for_each_safe(tmp, n, &ndlist.node) {

use list_for_each_entry_safe()

> +		nl = list_entry(tmp, struct ice_lag_netdev_list, node);
> +		list_del(&nl->node);
> +		kfree(nl);
> +	}
> +	lag->netdev_head = NULL;
> +}
> +
>  #define ICE_LAG_SRIOV_CP_RECIPE		10
>  #define ICE_LAG_SRIOV_TRAIN_PKT_LEN	16
>  
> diff --git a/drivers/net/ethernet/intel/ice/ice_lag.h b/drivers/net/ethernet/intel/ice/ice_lag.h
> index 9557e8605a07..ede833dfa658 100644
> --- a/drivers/net/ethernet/intel/ice/ice_lag.h
> +++ b/drivers/net/ethernet/intel/ice/ice_lag.h
> @@ -65,4 +65,5 @@ int ice_init_lag(struct ice_pf *pf);
>  void ice_deinit_lag(struct ice_pf *pf);
>  void ice_lag_rebuild(struct ice_pf *pf);
>  bool ice_lag_is_switchdev_running(struct ice_pf *pf);
> +void ice_lag_move_vf_nodes_cfg(struct ice_lag *lag, u8 src_prt, u8 dst_prt);
>  #endif /* _ICE_LAG_H_ */
> diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.c b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
> index aca1f2ea5034..b7ae09952156 100644
> --- a/drivers/net/ethernet/intel/ice/ice_vf_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
> @@ -829,12 +829,16 @@ static void ice_notify_vf_reset(struct ice_vf *vf)
>  int ice_reset_vf(struct ice_vf *vf, u32 flags)
>  {
>  	struct ice_pf *pf = vf->pf;
> +	struct ice_lag *lag;
>  	struct ice_vsi *vsi;
> +	u8 act_prt, pri_prt;
>  	struct device *dev;
>  	int err = 0;
>  	bool rsd;
>  
>  	dev = ice_pf_to_dev(pf);
> +	act_prt = ICE_LAG_INVALID_PORT;
> +	pri_prt = pf->hw.port_info->lport;
>  
>  	if (flags & ICE_VF_RESET_NOTIFY)
>  		ice_notify_vf_reset(vf);
> @@ -845,6 +849,17 @@ int ice_reset_vf(struct ice_vf *vf, u32 flags)
>  		return 0;
>  	}
>  
> +	lag = pf->lag;
> +	mutex_lock(&pf->lag_mutex);
> +	if (lag && lag->bonded && lag->primary) {
> +		act_prt = lag->active_port;
> +		if (act_prt != pri_prt && act_prt != ICE_LAG_INVALID_PORT &&
> +		    lag->upper_netdev)
> +			ice_lag_move_vf_nodes_cfg(lag, act_prt, pri_prt);
> +		else
> +			act_prt = ICE_LAG_INVALID_PORT;
> +	}
> +
>  	if (flags & ICE_VF_RESET_LOCK)
>  		mutex_lock(&vf->cfg_lock);
>  	else
> @@ -937,6 +952,11 @@ int ice_reset_vf(struct ice_vf *vf, u32 flags)
>  	if (flags & ICE_VF_RESET_LOCK)
>  		mutex_unlock(&vf->cfg_lock);
>  
> +	if (lag && lag->bonded && lag->primary &&
> +	    act_prt != ICE_LAG_INVALID_PORT)
> +		ice_lag_move_vf_nodes_cfg(lag, pri_prt, act_prt);
> +	mutex_unlock(&pf->lag_mutex);
> +
>  	return err;
>  }
>  
> diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl.c b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
> index cdf17b1e2f25..de11b3186bd7 100644
> --- a/drivers/net/ethernet/intel/ice/ice_virtchnl.c
> +++ b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
> @@ -1603,9 +1603,24 @@ static int ice_vc_cfg_qs_msg(struct ice_vf *vf, u8 *msg)
>  	    (struct virtchnl_vsi_queue_config_info *)msg;
>  	struct virtchnl_queue_pair_info *qpi;
>  	struct ice_pf *pf = vf->pf;
> +	struct ice_lag *lag;
>  	struct ice_vsi *vsi;
> +	u8 act_prt, pri_prt;
>  	int i = -1, q_idx;
>  
> +	lag = pf->lag;
> +	mutex_lock(&pf->lag_mutex);
> +	act_prt = ICE_LAG_INVALID_PORT;
> +	pri_prt = pf->hw.port_info->lport;
> +	if (lag && lag->bonded && lag->primary) {
> +		act_prt = lag->active_port;
> +		if (act_prt != pri_prt && act_prt != ICE_LAG_INVALID_PORT &&
> +		    lag->upper_netdev)
> +			ice_lag_move_vf_nodes_cfg(lag, act_prt, pri_prt);
> +		else
> +			act_prt = ICE_LAG_INVALID_PORT;
> +	}
> +
>  	if (!test_bit(ICE_VF_STATE_ACTIVE, vf->vf_states))
>  		goto error_param;
>  
> @@ -1729,6 +1744,11 @@ static int ice_vc_cfg_qs_msg(struct ice_vf *vf, u8 *msg)
>  		}
>  	}
>  
> +	if (lag && lag->bonded && lag->primary &&
> +	    act_prt != ICE_LAG_INVALID_PORT)
> +		ice_lag_move_vf_nodes_cfg(lag, pri_prt, act_prt);
> +	mutex_unlock(&pf->lag_mutex);
> +
>  	/* send the response to the VF */
>  	return ice_vc_send_msg_to_vf(vf, VIRTCHNL_OP_CONFIG_VSI_QUEUES,
>  				     VIRTCHNL_STATUS_SUCCESS, NULL, 0);
> @@ -1743,6 +1763,11 @@ static int ice_vc_cfg_qs_msg(struct ice_vf *vf, u8 *msg)
>  				vf->vf_id, i);
>  	}
>  
> +	if (lag && lag->bonded && lag->primary &&
> +	    act_prt != ICE_LAG_INVALID_PORT)
> +		ice_lag_move_vf_nodes_cfg(lag, pri_prt, act_prt);
> +	mutex_unlock(&pf->lag_mutex);
> +
>  	ice_lag_move_new_vf_nodes(vf);
>  
>  	/* send the response to the VF */
> -- 
> 2.41.0
> 
> 

