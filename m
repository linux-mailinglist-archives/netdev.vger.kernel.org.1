Return-Path: <netdev+bounces-48765-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D197EF73E
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 18:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8C801C20A72
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 17:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3883E43169;
	Fri, 17 Nov 2023 17:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Eazx5hC6"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D20DBE5
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 09:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700243065; x=1731779065;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Jtj8253OqTGxFv/yvibjVt4JMCz+S2/Tgt2fvUIIEAw=;
  b=Eazx5hC60ANWTcb+s9JNsPjxXTJmCCzFkImGRU6q6JHLe7yUR+JngclW
   fdEuW1XuwXvExXPpPH7BPlejJh/1yU0QiAmee9ia4/iCetiF3aMe4r33z
   RTDoSpEImfrSr/hcYNp2tlhfvsEUCNhiBLMr0dZ/Wz/XayUEVI/MHcZOw
   JpUmSaNDDomVgnychZAliAPyb+uJwHfMI/9Mh1/TUIAN1XdBeKzkRsPmL
   T7KuVeuZaApHdougx+reHB5DNR/iN39+MQRHZYPYT0qjZP0/JU2vpUKaf
   a5kFNZ+q6G6jpLkwRtdD633z34ShuA3BgwoM3zKUnfsObeBhZJmZceK9i
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="381726689"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="381726689"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2023 09:44:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10897"; a="889311476"
X-IronPort-AV: E=Sophos;i="6.04,206,1695711600"; 
   d="scan'208";a="889311476"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Nov 2023 09:44:25 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 17 Nov 2023 09:44:24 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 17 Nov 2023 09:44:24 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 17 Nov 2023 09:44:24 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 17 Nov 2023 09:44:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lXls2CIWnvZKAc3nDfOp+1hZLf3+MuNUWpvW/FDjoBgVcLw/SaBpXgcGXLY677ymaJ76+0/voZCuq3GVq7NnHzrboX6Ue96S6RJtE+katDeHU9fyo1HWf6F8N4nlkU88OXbviVdvHx8KHW0f5k0vJCex5vmNfbj88fugel7T7hcHUOkaKF7oybRgKK9YOBwkGCG+JQAoV6NbHt/CuXU8u7RISJ7docbIOs1cW2e+KJkFJ5RCR0Stc7XXlKwvSF4XkUaClZsG6xKrdngsNQpeq7PvUuJDLD43zjj/0/OmHk5uzL5I8+GDj1NsPZqggJj8SCFuP5LY05i/ZYdRSDNtZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AAdagXCReF4GXWzkF3XJxyKm2tmSJGNU3CAnduXdCvU=;
 b=IsLkLRuS+OjAGq5Ppz/UpQwC7HZGl8zxTF4DsIAxzKX25/Li9ifUy3HqJ4Enf5Mq0XQy9IfLy5t5GJ715/eq1+DJt1Jvd/JNirDY48zrh9/8Cs5T5bM7VqbdFAzoJxXRsQr6FCx9VgWwUcrsahMSIrkENcsqTH1f6B2CVuBZuvGP5jxw/XSjylgRDPGoQhslQQ+2GSS4aT3QFEtQ44jFqwMiolxWythZzzlWoJKqJB8tmU4PN0YiLz7qWKSYFc59sYaWj/pUOV0YQEk2KDayizRZZ2yEmQ35S7wDAICIxeadzaBf7+3q7G2od02oh6lu8GZyy1+BWKpZI9CXEdmBew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 PH0PR11MB5175.namprd11.prod.outlook.com (2603:10b6:510:3d::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6977.31; Fri, 17 Nov 2023 17:44:22 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ee54:9452:634e:8c53]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ee54:9452:634e:8c53%7]) with mapi id 15.20.7002.021; Fri, 17 Nov 2023
 17:44:22 +0000
Date: Fri, 17 Nov 2023 18:44:11 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: "Ertman, David M" <david.m.ertman@intel.com>
CC: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "edumazet@google.com"
	<edumazet@google.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"Wyborny, Carolyn" <carolyn.wyborny@intel.com>, "daniel.machon@microchip.com"
	<daniel.machon@microchip.com>, "Kitszel, Przemyslaw"
	<przemyslaw.kitszel@intel.com>, "Buvaneswaran, Sujai"
	<sujai.buvaneswaran@intel.com>
Subject: Re: [PATCH net] ice: Fix VF Reset paths when interface in a failed
 over aggregate
Message-ID: <ZVema0m2Pw6+VYTF@boxer>
References: <20231115211242.1747810-1-anthony.l.nguyen@intel.com>
 <ZVYllBDzdLIB97e2@boxer>
 <MW5PR11MB5811FEDAF2D1E3113C3ADCD9DDB0A@MW5PR11MB5811.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <MW5PR11MB5811FEDAF2D1E3113C3ADCD9DDB0A@MW5PR11MB5811.namprd11.prod.outlook.com>
X-ClientProxiedBy: FR3P281CA0086.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::13) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|PH0PR11MB5175:EE_
X-MS-Office365-Filtering-Correlation-Id: 001ba1e3-529c-43fc-e824-08dbe794d563
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hDAkvNe+hEAg5vNpVCs+/tx87XQWbx+FUc7FYsWDXWWCo4ixT8N7SAqQV80lkJzPoCucHLHBP5RWR5YYq2qB5dXKUGKaNnXVK4sozbUwYhSl5cdbcPLNs4UPDyUwmwwcMcMfvgtG6bS1N+vcCf2KF6Vxsr92dd/MU6s33lPvUgo5jzVOSJy504oyuBvFb6QL7KXLUXSNNn24WJjUBjMqOKKhuf7+Ax9eYqEEGexX9OwJSx43H7qXmbANyjxqtCVTQg2tJBgp6sldUyGk1fL/Ctv+5pkirjJno5jBSoHmiMQmImQXp47UrmHMRC3m3bN/leo/FHTv8u5+9rg+uOHUShS6xUcYS5FxGCDRuGE/s4TS0ORDIm+WHi/wJlWTie1SLAFWdOk2Zy3rs5gPCyrQ0pDOrMThZGPGHuJ2aNRk99K4d/3HG/yetxVKpKHwPuv9EdEpxW4qwfwrPb9VCFr+odWlnRybMviI9Qeg5So7x3V+hkufByBMtTisV7kgAeGTu/l3Pp6GgmHf6KZ1TW1MkEy0b12IDGzJSKa+uG6fDzTzkQWCDu7VcTMFGdmwEylq6FcLZ1bEW6T0CmRKHOrdaIMlkg23Fwb91Fnyf5dXpBg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(376002)(346002)(396003)(136003)(366004)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(9686003)(107886003)(6512007)(2906002)(966005)(44832011)(82960400001)(26005)(6486002)(478600001)(4326008)(8676002)(5660300002)(8936002)(6862004)(86362001)(316002)(66556008)(66946007)(66476007)(6636002)(41300700001)(6506007)(6666004)(33716001)(53546011)(54906003)(38100700002)(83380400001)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zdJom+lTSp5bDbCUFRXK92mX7hrATrh8D1WM8hML6cWVZlspS4xYoVJOl/6V?=
 =?us-ascii?Q?8wRJZV1ikPt+neuUH4U6bVGo7BuypSqQJ7DtrSXlfx65Hq/3wTDsGmRzOcvD?=
 =?us-ascii?Q?i0IDb5cXS32Pvg0SqGmA8jakz4Y6vwqvDrViAdPM1ov3AdWke33LDuWucSaZ?=
 =?us-ascii?Q?x2cfpiBwqogVA4jcSaesJlS64crF1S3gf9jPd61+Ea4qqEW2huXup7r06xnM?=
 =?us-ascii?Q?D+sUzIJm7mLnbSlcMHSzSlkJwQ8yBbwcRinsgXs55jlsx3SuEQOL8uMXm1+c?=
 =?us-ascii?Q?XhuzLoW6w5KE390wnbVizFzkCpfo+LILOKgZLycpBCn3WsNcbXpQt4MMNpVF?=
 =?us-ascii?Q?cluPz5HwRIyz1whkFyPL5tYkKp3zu5zVhz6JGf8dnp6hVzRZnX5dN3RRpQ9j?=
 =?us-ascii?Q?6hqnfHtmXRMP5l12vGQ2C1A4pRBcJjEdkxp2bn3QiLg3mqBq/CJ7RnRWwpgh?=
 =?us-ascii?Q?V/DlaSrkwslaOVXfh0S+ekLeIIb3vCVc+o0qzeUI6X1k4+8s+zA3rQh5oF+R?=
 =?us-ascii?Q?zyBJJIqnp0E9dgRFMMB+UW54popKMHHLSNfBEiKzT/1ybHZ6ywcffXhO1pzf?=
 =?us-ascii?Q?4DDx9M7+Yxh+p03A3Bmyyc7eAq06lsDggiK9TxbpLrSgtYaI5aAsG0ZNJeXl?=
 =?us-ascii?Q?tL1koKtiHaHGhkTekOA60PyBdcYgM1xka5pz57F+6tLz4yL+5vvHTJ8Mk95A?=
 =?us-ascii?Q?GQnmfeUT5NhlUUXgoswyRR7hTK3m2HTlIf9CalQrBzvdE9bSHOclgmo7gAJl?=
 =?us-ascii?Q?jYWmBrU8KnQs05YXrlTjTvetMZBncX7LOTX2QOijf9EtMUKCPI/nDHOmzOkI?=
 =?us-ascii?Q?kRrRcGi00sAhwL0FTlxAVeHt92kHmNkGqPMRT1qbHqLViL6T5UzNydLhUl1B?=
 =?us-ascii?Q?NPN5VOkK/SKCFRTUvIgYxKTZIfgQ2cVuUX5d+r6IO4joKDBizFgI1QFsKNgH?=
 =?us-ascii?Q?1wrpwOwd8Jc5mXBhgJH48ZoSBMDZVUN5ECdfyuYN08UaJ1XclYwJ7enD12Fk?=
 =?us-ascii?Q?FOrlelTslk1CKg3hmKrc2drXBgxO3OrInX3dHJOrSWjqciXypwk2oQB6lIJ/?=
 =?us-ascii?Q?0va3ZWJ334yU8wFLTYR6ehTYr0D/ZX5kNs9NFiFW9UI268WIMeIEkTozFYlS?=
 =?us-ascii?Q?Rpb6pZyPZBFhPfeLjf2PQJSmV1Zam05XrNhGRm9tjVBWjeiCnTddKTwgnHAW?=
 =?us-ascii?Q?snRDM6aGC+QnQLHcFrHESo5Lf9hIT5vuKE1uvRvCew7K5tILrRkIzdt4o83j?=
 =?us-ascii?Q?BgTiIEZ+LLTJr5S3rhUiEytvKFVe2J0JAtZgbH0A4ZAQU1YJaHEFRVJx5wVq?=
 =?us-ascii?Q?M2TVIVuD877XEsp9U2Yzsin1aTjIsG74PXo2MZVZ9WzIkBBdO2MjuOyhlLKj?=
 =?us-ascii?Q?7/psrEdzzokyqd4cwc3HF3HsY9AorVLdu4EL/vHaQFzYo/EY12KezGlFXRK4?=
 =?us-ascii?Q?Ak3GEyQ7zc1QMcDRZrZMSzC7EnRRfE0qtL16L6R1eeKxGgFhMD43BY/khvBB?=
 =?us-ascii?Q?H7OBSapJCfzpRg3LBlTNHCEXxrGOvHYsgw7WkXzGSfNx3p12CWh9v4cDM6Ph?=
 =?us-ascii?Q?M64v1AvBVE705dsqQOm/7shghkpu4av7Tql50T7d+csC4MWT817heogpILxJ?=
 =?us-ascii?Q?mg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 001ba1e3-529c-43fc-e824-08dbe794d563
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2023 17:44:22.5580
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v4q0ksbqjiVTuOb+NzNGYbmoZQgQGOIUfWXco1m41foD3zLdz2SrRm2fdrtrBQOSnRN/McBLAepPj6GnMPCalHu7XjiIqVgnZAwat9Uz2aE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5175
X-OriginatorOrg: intel.com

On Thu, Nov 16, 2023 at 10:36:37PM +0100, Ertman, David M wrote:
> > -----Original Message-----
> > From: Fijalkowski, Maciej <maciej.fijalkowski@intel.com>
> > Sent: Thursday, November 16, 2023 6:22 AM
> > To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
> > Cc: davem@davemloft.net; kuba@kernel.org; pabeni@redhat.com;
> > edumazet@google.com; netdev@vger.kernel.org; Ertman, David M
> > <david.m.ertman@intel.com>; Wyborny, Carolyn
> > <carolyn.wyborny@intel.com>; daniel.machon@microchip.com; Kitszel,
> > Przemyslaw <przemyslaw.kitszel@intel.com>; Buvaneswaran, Sujai
> > <sujai.buvaneswaran@intel.com>
> > Subject: Re: [PATCH net] ice: Fix VF Reset paths when interface in a failed
> > over aggregate
> > 
> > On Wed, Nov 15, 2023 at 01:12:41PM -0800, Tony Nguyen wrote:
> > > From: Dave Ertman <david.m.ertman@intel.com>
> > >
> > > There is an error when an interface has the following conditions:
> > > - PF is in an aggregate (bond)
> > > - PF has VFs created on it
> > > - bond is in a state where it is failed-over to the secondary interface
> > > - A VF reset is issued on one or more of those VFs
> > >
> > > The issue is generated by the originating PF trying to rebuild or
> > > reconfigure the VF resources.  Since the bond is failed over to the
> > > secondary interface the queue contexts are in a modified state.
> > >
> > > To fix this issue, have the originating interface reclaim its resources
> > > prior to the tear-down and rebuild or reconfigure.  Then after the process
> > > is complete, move the resources back to the currently active interface.
> > >
> > > There are multiple paths that can be used depending on what triggered the
> > > event, so create a helper function to move the queues and use paired calls
> > > to the helper (back to origin, process, then move back to active interface)
> > > under the same lag_mutex lock.
> > >
> > > Fixes: 1e0f9881ef79 ("ice: Flesh out implementation of support for SRIOV
> > on bonded interface")
> > > Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
> > > Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> > > Tested-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
> > > Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> > > ---
> > > This is the net patch mentioned yesterday:
> > > https://lore.kernel.org/netdev/71058999-50d9-cc17-d940-
> > 3f043734e0ee@intel.com/
> > >
> > >  drivers/net/ethernet/intel/ice/ice_lag.c      | 42 +++++++++++++++++++
> > >  drivers/net/ethernet/intel/ice/ice_lag.h      |  1 +
> > >  drivers/net/ethernet/intel/ice/ice_vf_lib.c   | 20 +++++++++
> > >  drivers/net/ethernet/intel/ice/ice_virtchnl.c | 25 +++++++++++
> > >  4 files changed, 88 insertions(+)
> > >
> > > diff --git a/drivers/net/ethernet/intel/ice/ice_lag.c
> > b/drivers/net/ethernet/intel/ice/ice_lag.c
> > > index cd065ec48c87..9eed93baa59b 100644
> > > --- a/drivers/net/ethernet/intel/ice/ice_lag.c
> > > +++ b/drivers/net/ethernet/intel/ice/ice_lag.c
> > > @@ -679,6 +679,48 @@ static void ice_lag_move_vf_nodes(struct ice_lag
> > *lag, u8 oldport, u8 newport)
> > >  			ice_lag_move_single_vf_nodes(lag, oldport,
> > newport, i);
> > >  }
> > >
> > > +/**
> > > + * ice_lag_move_vf_nodes_cfg - move VF nodes outside LAG netdev
> > event context
> > > + * @lag: local lag struct
> > > + * @src_prt: lport value for source port
> > > + * @dst_prt: lport value for destination port
> > > + *
> > > + * This function is used to move nodes during an out-of-netdev-event
> > situation,
> > > + * primarily when the driver needs to reconfigure or recreate resources.
> > > + *
> > > + * Must be called while holding the lag_mutex to avoid lag events from
> > > + * processing while out-of-sync moves are happening.  Also, paired
> > moves,
> > > + * such as used in a reset flow, should both be called under the same
> > mutex
> > > + * lock to avoid changes between start of reset and end of reset.
> > > + */
> > > +void ice_lag_move_vf_nodes_cfg(struct ice_lag *lag, u8 src_prt, u8
> > dst_prt)
> > > +{
> > > +	struct ice_lag_netdev_list ndlist, *nl;
> > > +	struct list_head *tmp, *n;
> > > +	struct net_device *tmp_nd;
> > > +
> > > +	INIT_LIST_HEAD(&ndlist.node);
> > > +	rcu_read_lock();
> > > +	for_each_netdev_in_bond_rcu(lag->upper_netdev, tmp_nd) {
> > 
> > Why do you need rcu section for that?
> > 
> > under mutex? lacking context here.
> > 
> 
> Mutex lock is to stop lag event thread from processing any other event until
> after the asynchronous reset is processed.  RCU lock is to stop upper kernel
> bonding driver from changing elements while reset is building a list.

Can you point me to relevant piece of code for upper kernel bonding
driver? Is there synchronize_rcu() on updates?
> 
> > > +		nl = kzalloc(sizeof(*nl), GFP_ATOMIC);
> > 
> > do these have to be new allocations or could you just use list_move?
> > 
> 
> Building a list from scratch - nothing to move until it is created.

Sorry got confused.

Couldn't you keep the up-to-date list of netdevs instead? And avoid all
the building list and then deleting it after processing event?

> 
> > > +		if (!nl)
> > > +			break;
> > > +
> > > +		nl->netdev = tmp_nd;
> > > +		list_add(&nl->node, &ndlist.node);
> > 
> > list_add_rcu ?
> > 
> 
> I thought list_add_rcu was for internal list manipulation when prev and next
> Are both known and defined?

First time I hear this TBH but disregard the suggestion.

> 
> > > +	}
> > > +	rcu_read_unlock();
> > 
> > you have the very same chunk of code in ice_lag_move_new_vf_nodes().
> > pull
> > this out to common function?
> > 
> > ...and in ice_lag_rebuild().
> > 
> 
> Nice catch - for v2, pulled out code into two helper function:
> ice_lag_build_netdev_list()
> Iie_lag_destroy_netdev_list()
> 
> 
> > > +	lag->netdev_head = &ndlist.node;
> > > +	ice_lag_move_vf_nodes(lag, src_prt, dst_prt);
> > > +
> > > +	list_for_each_safe(tmp, n, &ndlist.node) {
> > 
> > use list_for_each_entry_safe()
> > 
> 
> Changed in v2.
> 
> > > +		nl = list_entry(tmp, struct ice_lag_netdev_list, node);
> > > +		list_del(&nl->node);
> > > +		kfree(nl);
> > > +	}
> > > +	lag->netdev_head = NULL;
> 
> Thanks for the review!
> DaveE

