Return-Path: <netdev+bounces-13457-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0EFD73BA59
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 16:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5D1B281C90
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 14:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FDA93D9C;
	Fri, 23 Jun 2023 14:40:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6DA23101
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 14:40:39 +0000 (UTC)
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 239AAA1
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 07:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687531235; x=1719067235;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=mM3dvBu0GbtL5mJuLHb6mTjZ90dTNygEhKPDRSl0NWo=;
  b=OrP4p9xybwmVxtHXsT0vvoo/rua0PZwyWk0Rwkpq5GIHpgpCzSLHDauR
   kSwbxAopjUYrggb66a3nPpCmgqHZsheNPDC98AYU0/z7/IlGUG9C0arSd
   mfVCPWlFVI+lb1CfkX5EGlZ8r/L5A2By/jW7auFlIn5bAYSNcuIa0SbYS
   yk+CkywByOHCrwhWlzCdbpubiyL6lfT3EUA0ZZtdxQpzAzVZ3YpN08tER
   Pf5N15M/bYd2RZZa06P07aITPbol3hCzJqokB6d8pGiEHEcpLZDjyJxpY
   3qSWhiRvSpp9OGeGi1AVz62CzA7roPtOmRwGRwxWdTTKV6lYi0DDUNf8Q
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10750"; a="341118046"
X-IronPort-AV: E=Sophos;i="6.01,152,1684825200"; 
   d="scan'208";a="341118046"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2023 07:40:34 -0700
X-IronPort-AV: E=McAfee;i="6600,9927,10750"; a="749878936"
X-IronPort-AV: E=Sophos;i="6.01,152,1684825200"; 
   d="scan'208";a="749878936"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP; 23 Jun 2023 07:40:34 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 23 Jun 2023 07:40:34 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 23 Jun 2023 07:40:33 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 23 Jun 2023 07:40:33 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.106)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 23 Jun 2023 07:40:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hFgBiLf8hdf8zc+3/zRwoWM1Rg04wV6k5Rap3nbDbB7e8jCKGr508RlOpPPyxbCpk6x75OUjqBmmLI8A2e2O3TtOd8/YqDTrDSX2Kgj303kg5AruFJmLGIpy3d4lvBe9Miez7J3XmXobA/d3FX8EUkXL80DBdOSwKsQOqyI5YZHCMAoE3KImtiK8RmPJ78AFyC9xNW4j7/lWQBR3V51ZqbBZkjeL5Li3gz1WfzkDoFd3Rb2R3Vcsdh1P11AwpV8o8bp+FF4IigoXSCyoVIr8UcSVEr+zJSFONQsZsnwEB/ME4BLJIDpkLRWTp9c0UgQjlwhvGt05EmuaWY2m23VkoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v05dblSnnilrm1LRd6/hBqwt1KG040wge94lZnkzBB8=;
 b=C/q1EhPdSrRWSRugKb2blvUahTpRMOYsV+qPWA80jzLnOHaQ4NnElcDMPsNNzg/0ffW39Qj0QCXCOSwsgx+Ro3GgqGmJGn+nwrHzJVpvWpl+Kv2sqXZpN/0HbfXdoFabt5rFLyuFRw0f2CNnA2YxPUcmBOAxOn5wwO4UMXyfM2WY1CcSzuNE+ZpZxU8WW21ncMy+1JQjce38+5bB87FoFrcuTgkg/J80I1zVsLyhiNjKgAzZAwe5uvk+nnpbSvcbtHd7v1fZQnrz9a0EwVgcjHWulWbRDjx53NXzMYonegnz0GVIeWPDtu9BnizA/bbCDW4xZ5Y/pmzFrkhBqRgs7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 DS0PR11MB8206.namprd11.prod.outlook.com (2603:10b6:8:166::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.23; Fri, 23 Jun 2023 14:40:31 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::9e4f:80cc:e0aa:6809]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::9e4f:80cc:e0aa:6809%2]) with mapi id 15.20.6521.024; Fri, 23 Jun 2023
 14:40:30 +0000
Date: Fri, 23 Jun 2023 16:40:22 +0200
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<netdev@vger.kernel.org>, Michal Swiatkowski
	<michal.swiatkowski@linux.intel.com>, Michal Wilczynski
	<michal.wilczynski@intel.com>, Simon Horman <simon.horman@corigine.com>,
	Arpana Arland <arpanax.arland@intel.com>
Subject: Re: [PATCH net-next 4/6] ice: remove null checks before devm_kfree()
 calls
Message-ID: <ZJWu1hbpZOxRz3fe@boxer>
References: <20230622183601.2406499-1-anthony.l.nguyen@intel.com>
 <20230622183601.2406499-5-anthony.l.nguyen@intel.com>
 <ZJVyiOwdVQ6btr53@boxer>
 <ffe3bbdf-eb26-5223-c1ed-1bdbaf577d84@intel.com>
 <ZJV+dUvm4Mg1QNeR@boxer>
 <4278f944-57fe-6382-132d-728fa8c8f582@intel.com>
 <ZJWdP+RPaF+mYYPM@boxer>
 <0e9ae896-82c1-6ddb-c1a0-e233f8a9d7f0@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <0e9ae896-82c1-6ddb-c1a0-e233f8a9d7f0@intel.com>
X-ClientProxiedBy: BE1P281CA0341.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:7d::18) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|DS0PR11MB8206:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d016a9f-9dd5-4f17-2a16-08db73f7caf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X/EbPPoFcwo7sXQXZJ2zrQkRt93McJLnMBp5bH90QRwDajC8ltF/Pzrwg8Adf1ctPG8dW7CFl+xw9mkYyAG5hKl6iyhEhciAluJqV0+sGdBmvBkK02X1SBQ6s6sU4oneDvb6099puZlGerTjUAif3tun9HfbTQkfg9OpPmH0EyIMqwd1qggYf5tnE2wAZsEp8fQ0P9Ek7lRAjK0uPegugrBlVZxvUVhzKnejsWamtlNeAk/UEvZMGDMUBC7OLgkHNDPRMBJ8K4at3cLKZd0XVdy6gLay1Y7d6ZVgUP+SYpdLmMvN1LR4HHfi/y5ZcPv9s2lW169pVO+sYsyi8iNy9EJ2yYNZj6cXIrJ9kASn9M16OCSHDaOP0JInlhxw4rWt0unwRTH9r4KBrqI44NuJP/FMKi3JdOB4URmu2N0EbR1AKSMYDvlY6Dqf1hYYTsl3M3elu0W6/9c8kx3QTAmd0ujQ7Hi7r6uNUTeUPJ4BedqnyIbzdw2BSccEqnJZ/UcZc2HhFoI+Nz3sbWpVuAxo04Fm21wBj6pKrT3YA2WVSqmAZhHtDdznwXfng7dN3mzOICP5lNbIN7vfhcoG1NYc3w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(39860400002)(346002)(376002)(366004)(396003)(136003)(451199021)(86362001)(82960400001)(38100700002)(33716001)(66899021)(8676002)(6486002)(6862004)(966005)(41300700001)(26005)(53546011)(8936002)(44832011)(5660300002)(478600001)(6506007)(186003)(2906002)(83380400001)(316002)(54906003)(66556008)(4326008)(6636002)(66476007)(6666004)(9686003)(6512007)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r0raDK4vNZnyLfHnbNxpAO1YkU/HtgX8gyUACy+JbgoD8ltho/hEeJWuEEbc?=
 =?us-ascii?Q?AJgEURnyFxxBh0alQHM3/fRyEDZs7B7Muqt5IuRHcs1bIGpmahBHqnFsmXA2?=
 =?us-ascii?Q?iRlsNEWKK1bTZ9aYAnVmG782wIyz0RYFOrfnhQsU63qN2aCkozpMYBmpjS0e?=
 =?us-ascii?Q?4DM80gzGUP/bzI/LqnRXQj7xZrLsfDvFB+NlHzA7t2I+F3+kEoeg1X2awGu2?=
 =?us-ascii?Q?AleoWaYqMeFU29hXpVgm51ifm+rSXwX8yC156vVqpJAErltRUoymf6fdP+Ws?=
 =?us-ascii?Q?CBthnpa69KhVP69PVBoSU8zlbGXzRDvyZhGmDvP5l7NVoJC4xEgXSwGisCFZ?=
 =?us-ascii?Q?oAgR4Qae2tlwXNCBwcOHT+gegDAGOy2OzvELVRWfNG5gdusn0HllBljkO9CR?=
 =?us-ascii?Q?5dhcr8ZcLJjhs5cI9KIbz6uhGYoJGjsa/J5TbB+WJB/uQbosD/3pKc0a9QKw?=
 =?us-ascii?Q?EcQbsNyELRwpJE6/JOdOHu2ksU7IprLJF9kKeKizNeVbxH9hc7dlxv+Rgksp?=
 =?us-ascii?Q?gqINoUGJE0nVZ4dGjSrgkGzqmLuMeV0yqKs34X7I1NBAqu6SsvVNjIIblyrt?=
 =?us-ascii?Q?oX6GhDb5eEgiKL0IYYl2Dq/fdyZY41J1IAaX+ygOT1yWC9TpHUdy21DNNFMC?=
 =?us-ascii?Q?GRmFk/oNXLQqOtjRWTrWjIGmM4p7fg3JCqkh6VyE6+Vo7HCxRuo6OpWhLVui?=
 =?us-ascii?Q?qQ2+06UBKPNGZiFiqhnIzfnK+rdRV1vkGS4SYdJwk2WJDLtCc+vMThAogBC6?=
 =?us-ascii?Q?OoyF4o3mWE93fIUtBGOeuahaUKZ6TFSXg03nuPohywCOx9cPxS0dG11cSn+k?=
 =?us-ascii?Q?7VuchOpghctBHuPMNorQjUFCMp9h8ZNzil7RzMoWCBsywjNafn6vHbboCKA6?=
 =?us-ascii?Q?IyoNSRbVu4VlEAAcrWucS5b6AS5lfQ1pdIpw/XEq8l3dJncLK0LuTdI3LWgK?=
 =?us-ascii?Q?vkWIRBlXsAMwJqAxB/5TVRhhdIYHjQluh8l0OxfqAlEEP9pttyF96r8NlJ3S?=
 =?us-ascii?Q?8jU2V0dpc1phZAujsLhRBu6glWpA++HDd9PYxFalf1xk/gpSV9BsYLmWrApj?=
 =?us-ascii?Q?Prem7jhK9DVdMUqwahDCLFo1jfAq4TIDH2XkJtJpwRzLr1lICxEFzokBNvQD?=
 =?us-ascii?Q?L75EJtbNWFWknD8P/t8JBeM3HeMKxQEwcIZnY4bWW9vjB5SmN2YnQus3gu0L?=
 =?us-ascii?Q?M+y42Wg8VOsCkBRygxX9rrx6np0b5tX3Xyc8IB7Vg8wVDccvENrmZgxFB5Dj?=
 =?us-ascii?Q?kfCCED0ObMGCdlnSHzCtFWC+XUj3SoNaZI9lABjQme+xtWATDqx8LaTSTQiu?=
 =?us-ascii?Q?NKMDfWaaCawvpII/bBZyuCZSxgoj8ruRkqjTgBk81yAdGj8HPu3tYWpx8ZNe?=
 =?us-ascii?Q?6tD/gcgQkJsv0oRulOkHtcZS5u05Q8V+uvKjH29qEXUOEBAWIEWkUwsnu+VI?=
 =?us-ascii?Q?1y4QOkSm98q2dXd7QPaToIZEDwfveUR57pTvsJHZ5/PtOREXVaDNmeqj2XE3?=
 =?us-ascii?Q?s9rxx4tWoTQf2/TXdGt2r0+Z7jF1JwCiusCNL8+Y3Uq46yw5fZGpNZs/A4PA?=
 =?us-ascii?Q?VHwDWyhZz7iw5FYNEH0SGuBejUbTwb//04HHJ4LlOo7NCif4RDBEYYA/K6Yc?=
 =?us-ascii?Q?kg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d016a9f-9dd5-4f17-2a16-08db73f7caf4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 14:40:30.3912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m5ntI/gyXrN2+BsWH8Pgk22E7hRmUCgzgUzFaf8ghd1TQdIJH9FboJRaB9vE7x36SIUnHfPk+/LpSW27CsvLK7tnO9TSbpjvqjzWZ18r374=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8206
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jun 23, 2023 at 04:28:08PM +0200, Przemek Kitszel wrote:
> On 6/23/23 15:25, Maciej Fijalkowski wrote:
> > On Fri, Jun 23, 2023 at 03:21:30PM +0200, Przemek Kitszel wrote:
> > > On 6/23/23 13:13, Maciej Fijalkowski wrote:
> > > > On Fri, Jun 23, 2023 at 12:44:29PM +0200, Przemek Kitszel wrote:
> > > > > On 6/23/23 12:23, Maciej Fijalkowski wrote:
> > > > > > On Thu, Jun 22, 2023 at 11:35:59AM -0700, Tony Nguyen wrote:
> > > > > > > From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> > > > > > > 
> > > > > > > We all know they are redundant.
> > > > > > 
> > > > > > Przemek,
> > > > > > 
> > > > > > Ok, they are redundant, but could you also audit the driver if these devm_
> > > > > > allocations could become a plain kzalloc/kfree calls?
> > > > > 
> > > > > Olek was also motivating such audit :)
> > > > > 
> > > > > I have some cases collected with intention to send in bulk for next window,
> > > > > list is not exhaustive though.
> > > > 
> > > > When rev-by count tag would be considered too much? I have a mixed
> > > > feelings about providing yet another one, however...
> > > > 
> > > > > 
> > > > > > 
> > > > > > > 
> > > > > > > Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> > > > > > > Reviewed-by: Michal Wilczynski <michal.wilczynski@intel.com>
> > > > > > > Reviewed-by: Simon Horman <simon.horman@corigine.com>
> > > > > > > Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> > > > > > > Tested-by: Arpana Arland <arpanax.arland@intel.com> (A Contingent worker at Intel)
> > > > > > > Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> > > > > > > ---
> > > > > > >     drivers/net/ethernet/intel/ice/ice_common.c   |  6 +--
> > > > > > >     drivers/net/ethernet/intel/ice/ice_controlq.c |  3 +-
> > > > > > >     drivers/net/ethernet/intel/ice/ice_flow.c     | 23 ++--------
> > > > > > >     drivers/net/ethernet/intel/ice/ice_lib.c      | 42 +++++++------------
> > > > > > >     drivers/net/ethernet/intel/ice/ice_sched.c    | 11 ++---
> > > > > > >     drivers/net/ethernet/intel/ice/ice_switch.c   | 19 +++------
> > > > > > >     6 files changed, 29 insertions(+), 75 deletions(-)
> > > > > > > 
> > > > > > > diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
> > > > > > > index eb2dc0983776..6acb40f3c202 100644
> > > > > > > --- a/drivers/net/ethernet/intel/ice/ice_common.c
> > > > > > > +++ b/drivers/net/ethernet/intel/ice/ice_common.c
> > > > > > > @@ -814,8 +814,7 @@ static void ice_cleanup_fltr_mgmt_struct(struct ice_hw *hw)
> > > > > > >     				devm_kfree(ice_hw_to_dev(hw), lst_itr);
> > > > > > >     			}
> > > > > > >     		}
> > > > > > > -		if (recps[i].root_buf)
> > > > > > > -			devm_kfree(ice_hw_to_dev(hw), recps[i].root_buf);
> > > > > > > +		devm_kfree(ice_hw_to_dev(hw), recps[i].root_buf);
> > > > > > >     	}
> > > > > > >     	ice_rm_all_sw_replay_rule_info(hw);
> > > > > > >     	devm_kfree(ice_hw_to_dev(hw), sw->recp_list);
> > > > > > > @@ -1011,8 +1010,7 @@ static int ice_cfg_fw_log(struct ice_hw *hw, bool enable)
> > > > > > >     	}
> > > > > > >     out:
> > > > > > > -	if (data)
> > > > > > > -		devm_kfree(ice_hw_to_dev(hw), data);
> > > > > > > +	devm_kfree(ice_hw_to_dev(hw), data);
> > > > > > >     	return status;
> > > > > > >     }
> > > > > > > diff --git a/drivers/net/ethernet/intel/ice/ice_controlq.c b/drivers/net/ethernet/intel/ice/ice_controlq.c
> > > > > > > index 385fd88831db..e7d2474c431c 100644
> > > > > > > --- a/drivers/net/ethernet/intel/ice/ice_controlq.c
> > > > > > > +++ b/drivers/net/ethernet/intel/ice/ice_controlq.c
> > > > > > > @@ -339,8 +339,7 @@ do {									\
> > > > > > >     		}							\
> > > > > > >     	}								\
> > > > > > >     	/* free the buffer info list */					\
> > > > > > > -	if ((qi)->ring.cmd_buf)						\
> > > > > > > -		devm_kfree(ice_hw_to_dev(hw), (qi)->ring.cmd_buf);	\
> > > > > > > +	devm_kfree(ice_hw_to_dev(hw), (qi)->ring.cmd_buf);		\
> > > > > > >     	/* free DMA head */						\
> > > > > > >     	devm_kfree(ice_hw_to_dev(hw), (qi)->ring.dma_head);		\
> > > > > > >     } while (0)
> > > > > > > diff --git a/drivers/net/ethernet/intel/ice/ice_flow.c b/drivers/net/ethernet/intel/ice/ice_flow.c
> > > > > > > index ef103e47a8dc..85cca572c22a 100644
> > > > > > > --- a/drivers/net/ethernet/intel/ice/ice_flow.c
> > > > > > > +++ b/drivers/net/ethernet/intel/ice/ice_flow.c
> > > > > > > @@ -1303,23 +1303,6 @@ ice_flow_find_prof_id(struct ice_hw *hw, enum ice_block blk, u64 prof_id)
> > > > > > >     	return NULL;
> > > > > > >     }
> > > > > > > -/**
> > > > > > > - * ice_dealloc_flow_entry - Deallocate flow entry memory
> > > > > > > - * @hw: pointer to the HW struct
> > > > > > > - * @entry: flow entry to be removed
> > > > > > > - */
> > > > > > > -static void
> > > > > > > -ice_dealloc_flow_entry(struct ice_hw *hw, struct ice_flow_entry *entry)
> > > > > > > -{
> > > > > > > -	if (!entry)
> > > > > > > -		return;
> > > > > > > -
> > > > > > > -	if (entry->entry)
> > > > 
> > > > ...would you be able to point me to the chunk of code that actually sets
> > > > ice_flow_entry::entry? because from a quick glance I can't seem to find
> > > > it.
> > > 
> > > Simon was asking very similar question [1],
> > > albeit "where is the *check* for entry not being null?" (not set),
> > > and it is just above the default three lines of context provided by git
> > > (pasted below for your convenience, [3])
> > > 
> > > To answer, "where it's set?", see ice_flow_add_entry(), [2].
> > 
> > I was referring to 'entry' member from ice_flow_entry struct. You're
> > pointing me to init of whole ice_flow_entry.
> > 
> > I am trying to say that if ice_flow_entry::entry is never set, then
> > probably it could be removed from struct.
> 
> You are totally right, I have compile-checked it and that's good idea.
> I will post a followup patch for that.

Good, then let's push another entry to rev-by stack tags:
Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

> 
> The field itself originates from One Of The our internal demo drivers (:T)

:)

> 
> > 
> > > 
> > > [1] https://lore.kernel.org/netdev/ZHb5AIgL5SzBa5FA@corigine.com/
> > > [2] https://elixir.bootlin.com/linux/v6.4-rc7/source/drivers/net/ethernet/intel/ice/ice_flow.c#L1632
> > > 
> > > --
> > > 
> > > BTW, is there any option to add some of patch generation options (like,
> > > context size, anchored lines, etc), that there are my disposal locally, but
> > > in a way, that it would not be lost after patch is applied to one tree
> > > (Tony's) and then send again (here)?
> > > (My assumption is that Tony is (re)generating patches from git (opposed to
> > > copy-pasting+decorating of what he has received from me).
> > > 
> > > 
> > > 
> > > > 
> > > > > > > -		devm_kfree(ice_hw_to_dev(hw), entry->entry);
> > > > > > > -
> > > > > > > -	devm_kfree(ice_hw_to_dev(hw), entry);
> > > > > > > -}
> > > > > > > -
> > > > > > >     /**
> > > > > > >      * ice_flow_rem_entry_sync - Remove a flow entry
> > > > > > >      * @hw: pointer to the HW struct
> > > > > > > @@ -1335,7 +1318,8 @@ ice_flow_rem_entry_sync(struct ice_hw *hw, enum ice_block __always_unused blk,
> > > 
> > > [3] More context would include following:
> > > 
> > >           if (!entry)
> > >                   return -EINVAL;
> > > 
> > > > > > >     	list_del(&entry->l_entry);
> > > > > > > -	ice_dealloc_flow_entry(hw, entry);
> > > > > > > +	devm_kfree(ice_hw_to_dev(hw), entry->entry);
> > > > > > > +	devm_kfree(ice_hw_to_dev(hw), entry);
> > > > > > >     	return 0;
> > > > > > >     }
> > > > > > > @@ -1662,8 +1646,7 @@ ice_flow_add_entry(struct ice_hw *hw, enum ice_block blk, u64 prof_id,
> > > > > > >     out:
> > > > > > >     	if (status && e) {
> > > > > > > -		if (e->entry)
> > > > > > > -			devm_kfree(ice_hw_to_dev(hw), e->entry);
> > > > > > > +		devm_kfree(ice_hw_to_dev(hw), e->entry);
> > > > > > >     		devm_kfree(ice_hw_to_dev(hw), e);
> > > > > > >     	}
> > > > 
> > > > (...)
> > > 
> 

