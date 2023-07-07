Return-Path: <netdev+bounces-16098-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E3D74B63B
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 20:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 844BC1C20FE8
	for <lists+netdev@lfdr.de>; Fri,  7 Jul 2023 18:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF2B171C3;
	Fri,  7 Jul 2023 18:27:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57FC2171B9
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 18:27:10 +0000 (UTC)
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3289268A
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 11:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688754424; x=1720290424;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=D97uzIVkYR8iWF2sZCecZICt5m+Ih6GRVCRjy85cTIc=;
  b=H5w1Z4Hr7P9V7d3hb5mfp2Fn52hA0Bb3v98juz+AVTgtFf0vC1ZIvdTa
   D3IhIub4UsUXP9obRG7Al70PSGnI69sjBwCzDiKbXXkOUpogwU/vWAkT3
   O+sitw8fBE6BKk5amS/2aa8yUqqHY05jKfeLq8pwOypKGIskRDQlg0Vg7
   Bhe9RxqoO/lrycriFUSJ592Xeh27evwDxcOhOGcpUJOtnpoEg6MUTUQox
   LPECHZosUEB8HeqOa3Dz2qyjaq4q5eJ4anjyrNze/p4UWDy1/gya6rVPr
   rP8kMahRLmlmevb6dlGSQCFVmPJDE1McZXguiX6e2XlSVmQrPeh1K6XUk
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10764"; a="430017756"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="430017756"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2023 11:27:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10764"; a="755268485"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="755268485"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga001.jf.intel.com with ESMTP; 07 Jul 2023 11:27:02 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 7 Jul 2023 11:27:01 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 7 Jul 2023 11:27:01 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 7 Jul 2023 11:27:01 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 7 Jul 2023 11:27:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kypVJmjOtuh3OVJBiOV4DF8N7hvW2eqHxT3XVasmXbQo0dYDShtH9oufKwpWBKhQw0UBpzAQsqxs0sP62sdzY9pI2Em6Ci3vLdooefD3k77ulwJaMFaucxgW8n8HVo5d4Eot/wJNcd+98TJ9PwadOeYRjvdOEACIys37O7XRKPfNgl3NMH+IZpiJrLcX2XWxkYZChFi4Vgdy51k1/yOKtjcv0/4C8Uhv1ncCb1452IdZbCyQV/mnpsblwO/5RuJ4H8Rdq/SoxevfW4VMxdeWYK5wjIyJKjJYLp1UvIogpZ6DCUvfOIIZCvTX/sl54sRN92nrytYmV1oDGKxj7Tb2yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iFl2Q/4ArjCjEfTuHxE0ATwJfJVHtwYQitru6XmU77E=;
 b=BU9r+coVkVh1O3wm1rvv47Aut0bjd/j0tNP1uNRl1jjVJShPONJxAsHBeZFAWdg/YpiwSD8LH/NAQvZdkP0g4zS+Iej++5HN3JyDuiv9/Hk44GfKnm56IwZr9na4nlacK9A2U0m6XKJmDsGk8aXfUWM+6ybRdlhSC/KSd9ZOv/dXfejc8OOHF49W200cGqc2D5d/pOoWj+wPDTtRYZQMxkirthklOgT3bPseSnS5O4iZyG31bHC2g632uFTxVhpJOmWbgu3FcL85WVJf8ScHuqachVh5pJbWx5eEbFQHM2JyAFw+zk1JHIGYEsiy3H47okI+5i/Gk0Aym0mTsN6Ghg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN6PR11MB2943.namprd11.prod.outlook.com (2603:10b6:805:d3::26)
 by DS0PR11MB8135.namprd11.prod.outlook.com (2603:10b6:8:155::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.26; Fri, 7 Jul
 2023 18:26:59 +0000
Received: from SN6PR11MB2943.namprd11.prod.outlook.com
 ([fe80::af65:2282:23bf:d2d3]) by SN6PR11MB2943.namprd11.prod.outlook.com
 ([fe80::af65:2282:23bf:d2d3%7]) with mapi id 15.20.6565.016; Fri, 7 Jul 2023
 18:26:58 +0000
Date: Fri, 7 Jul 2023 20:26:45 +0200
From: Michal Kubiak <michal.kubiak@intel.com>
To: Junfeng Guo <junfeng.guo@intel.com>
CC: <netdev@vger.kernel.org>, <jeroendb@google.com>,
	<pkaligineedi@google.com>, <shailend@google.com>, <haiyue.wang@intel.com>,
	<kuba@kernel.org>, <awogbemila@google.com>, <davem@davemloft.net>,
	<pabeni@redhat.com>, <yangchun@google.com>, <edumazet@google.com>,
	<csully@google.com>
Subject: Re: [PATCH net] gve: unify driver name usage
Message-ID: <ZKhY5Y0C5ySmkp1w@localhost.localdomain>
References: <20230707103710.3946651-1-junfeng.guo@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230707103710.3946651-1-junfeng.guo@intel.com>
X-ClientProxiedBy: DUZPR01CA0033.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:468::8) To SN6PR11MB2943.namprd11.prod.outlook.com
 (2603:10b6:805:d3::26)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR11MB2943:EE_|DS0PR11MB8135:EE_
X-MS-Office365-Filtering-Correlation-Id: ac5d755e-c114-4ed9-ea4f-08db7f17c003
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2F/4SagMs0W467Ukusspf64B2CL7uc9Po7xe8MhbMD5SsUO2/4kiUKl2hzNkt+rQTEv1Aef6OH3UFSpitXN9ooAHj7qEqdvxNMEdsDGTgj+oCKiOftDpM3AEhirQ2RTaQQqcbP+d1Y1t2kNX87tMjgsemPXOlWJIChL5YNfe7YjkF1ctGaZYUgNkmOhtyUokaGPn+1zY2alIGBIWu/+4GfgzKd9kgT0wIiv2jCQZasurjLEQk43tDJGFaumkvJLTJFXNuX5ehzwKhJpa9fFALQerjT2VBvFTwUGD+Gyh6IjQgaJT01IQWxZJ00b6Ala2FoXZpd8iJBGOniqmoesMN5IRgeRZmyESL+FarKgrReXP6y/bcQIIwdA1ExvpS4mD0k2AhC868gF6c8/b9iP1Oj0KZUS8gQwk3291lVt0XFqLMaK9t35VtX89byko6SVQBo47exOcd6ANjkr9Ld/RUTKaJkqnqP2b/lNT5Ihyq3WWP8MqEFymgEc+XvwIJ5Kw1TU4aau2tQaut0nTLzR4EXpMixlBW78nsIs3x+ZS6PWEu1t6lObTKJnWBJYdr1zn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB2943.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(346002)(39860400002)(366004)(396003)(451199021)(41300700001)(44832011)(8676002)(316002)(4326008)(6636002)(5660300002)(6862004)(2906002)(4744005)(66556008)(66476007)(66946007)(478600001)(7416002)(8936002)(6666004)(9686003)(6512007)(6486002)(6506007)(186003)(26005)(38100700002)(82960400001)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QONCkDZmBCT/8OXnCzRH/tl/6et5Cdx2s4R48EoU5ziW/e4MF/9LN3gqQPMj?=
 =?us-ascii?Q?Mp/7mvxwPi8xNUitrcDS8rQM1HCwlAF1NQifHeHct4JjOsqb6nA+vWjeFmgN?=
 =?us-ascii?Q?fDR4xEbqUhYo/DMOWzxyDBmx4tn6g/XB/X95nxdBsba9YfZWPIsgSjsVuMd2?=
 =?us-ascii?Q?wQrP/hTBqwhXY5IKnobzn8HwCmv3LH65MsxzuppA12DN6WR/ncBOegzRwZNY?=
 =?us-ascii?Q?/RUyB6mWr9l2njUqiLAfOIt4VhWNNGoVzU29sptS+sqt4+kUwt5lauBa2En3?=
 =?us-ascii?Q?WogtvMRE+413def8P5UpbHNyu6aol11nkKMQyDAGHonZHyoQc1A0ACxcO/Ca?=
 =?us-ascii?Q?Mo/H+J6DcgNHU93zDam/tmbbeqoRZs/4dNOjgu0MA6e+6FTAe5hNpRk92wgk?=
 =?us-ascii?Q?7GbLiI9VuLQM5bbYKMVSvQ39uMhR5Xc+ILVMXHlNbZzWxG2s1wYVvMefXzEs?=
 =?us-ascii?Q?7buLv/+mcAvvCIc5ltyv7iRb4Kc2mP8v9NNx5FFh48ONc/fAdUfK70MQkCxF?=
 =?us-ascii?Q?UfbR7ZrJwoydJj/WOEabtsJF/AiZC6eEczK25vs4o9MafZJb4ygT1YNt89Jk?=
 =?us-ascii?Q?Qz2XBsNORu5tb6bbJRN9aUrvDrFcPP9hGfGhHS8RgWYutUulnN2J+79ivgjA?=
 =?us-ascii?Q?jPa/usTNTmxIBApML7MhXiiH0bB89+Ycit2B+kJnFAfdy3ocNS0EejuQFyPG?=
 =?us-ascii?Q?q/EJ8FOlwSRoufAB1Na5iHEH534Lql7J+FxPBfj4IUorcgQIaLBfon9SFIeJ?=
 =?us-ascii?Q?rNWNuoRFtde/w0PsK5CK8TeN7SaKhTNI/RhdrrSXnwWdsDCZSq1+DLreGNVK?=
 =?us-ascii?Q?6hFBardKLskFbkvHy7vGXQ9ZPeFdNNTnpbxfm8dvaXpVwyP+39hqveiRXA/H?=
 =?us-ascii?Q?dj1JRsbqdAhymN3LhTc1Od6+HHE+tqX30r6uLIMSLfjbsB+D63/Tj4CfFZDI?=
 =?us-ascii?Q?UJu8pNMxVg+nIU7NjrnY1F82bq4UT6BTGR3l5UQs6X3rC0N5OeZsPN+sphaq?=
 =?us-ascii?Q?iBw/es9DpMBNBt5AdMQNoM/jZZwy39G+XIbg8H8gLFw0Vd0c2v0G0AkQVTuY?=
 =?us-ascii?Q?1AzupuhqzZvFrpUCra0/cSxTvciCiIe++v/Bj2P+FilQIRymBvqZDOBDupu5?=
 =?us-ascii?Q?5Hjr3qjZqduh0WFj5faCYF4vfc3A79jRMT6+ugTXR5Gemnq6WEd73/MT8T6Z?=
 =?us-ascii?Q?tVzC0Iyq5+550hQtB1/f4qRew92WCmcU/lNXUVWcd4tFazZreAFX8sh0uJtM?=
 =?us-ascii?Q?53lfr5c9pZ2dE7VVIWdJ774RwIn/AFnPx1Qxpkxpuz1VpURzMAcVQ17JDZue?=
 =?us-ascii?Q?DdICbBBL4CUcCkbS+PHd1Op/rXcwAmPBPupUYW/Tc0mplQOb1QpWjicqpdbQ?=
 =?us-ascii?Q?q2EMFt07yMyY+sFwwfvwP5tJ7SyDx0Ngefpu7WYJPOOSVHKosECjdMQUmWEe?=
 =?us-ascii?Q?u1fGfAOiuYawlf4h18XLn8L9Kx6qAH/ZMmqFcQCGKeL0Q09BxqXotowG8LZP?=
 =?us-ascii?Q?TX4GddTRGdKIlfEYm+3Cg/to40DeciMM3eJJb0ijzvoWDxY9ypRkDjtESW4o?=
 =?us-ascii?Q?qMXSlCCoibhADdQDHYQrOH73sXwdGqs1xSsvX1ZWvB7y3HKBNXn1QXjmafJg?=
 =?us-ascii?Q?/Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ac5d755e-c114-4ed9-ea4f-08db7f17c003
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB2943.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2023 18:26:58.9111
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T1Si8FY+95vBlmrxgtBDmUpc7kxfL3S05cksigJPoU2amjqLSRSPl3xrFG+gOoSlTQwcnaXnT80N6EKvOKn/mA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8135
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jul 07, 2023 at 06:37:10PM +0800, Junfeng Guo wrote:
> Current codebase contained the usage of two different names for this
> driver (i.e., `gvnic` and `gve`), which is quite unfriendly for users
> to use, especially when trying to bind or unbind the driver manually.
> The corresponding kernel module is registered with the name of `gve`.
> It's more reasonable to align the name of the driver with the module.
> 
> Fixes: 893ce44df565 ("gve: Add basic driver framework for Compute Engine Virtual NIC")
> Cc: csully@google.com
> Signed-off-by: Junfeng Guo <junfeng.guo@intel.com>
> ---
>

The patch makes the driver strings much more consistent.
Looks good to me.

Thanks,
Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>


