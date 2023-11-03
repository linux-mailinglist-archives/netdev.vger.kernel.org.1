Return-Path: <netdev+bounces-45907-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6EAB7E03ED
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 14:47:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E66E11C20A17
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 13:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A08DC18623;
	Fri,  3 Nov 2023 13:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gWg0z6Ze"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67A216410
	for <netdev@vger.kernel.org>; Fri,  3 Nov 2023 13:47:17 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A4C11A8
	for <netdev@vger.kernel.org>; Fri,  3 Nov 2023 06:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699019233; x=1730555233;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=TjuOc0FL2vJXS8xpi0ldiT1X/AAp1qPU22gXG9uFfso=;
  b=gWg0z6ZeRpibdibMtV79jFsKEJeGBIWMklP7iaZAWvkrGFarlWvhEtb9
   biLvnFvK8rIPQoSWsA6IxDknCHMbBaT3xvGvI3II9yFMkBEUb5tdgC9hn
   Ng2V5NMfueaheyouIp3KA/IPz61jAqZtjc4+/roRZG1fI9yW7CyZiGOoL
   8QUAVkmm67TXZdIlGOmM6ssyUQNJ8OIDbp0v14kSYZM2rBYmKtpDi36Fn
   YWoAKCtjt6BHUiuEhrirLFRHVZKXQpdDbpst1+6DI8NWN2VU1mQwZ+1cd
   cB7UaCycqQU3O7HshrBUEjYojj38VwYjphNQfZtAlwzndfyQXN0xcQatG
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10883"; a="388772860"
X-IronPort-AV: E=Sophos;i="6.03,273,1694761200"; 
   d="scan'208";a="388772860"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2023 06:47:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,273,1694761200"; 
   d="scan'208";a="9383819"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Nov 2023 06:47:13 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 3 Nov 2023 06:47:12 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 3 Nov 2023 06:47:11 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 3 Nov 2023 06:47:11 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 3 Nov 2023 06:47:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LnEB0jKF65euxOm+7mSH5W4s934R67BvINUnQ8X7A574PyzNLhMH0AmrnuIchAg3g0QJR43flT7LMJbEl+/Nn77VkbkrjSmB0Tlj/vH5nxEHlPz/jJAwu5Kg9SXi1vN/85Zvs9/BrUsiwPbC5BZ3QgaraQNDSLO5HBeoWwsc+og4uabSyeWF4GSy24a6Wk98nCH2ymiXPL/ZA34GoN7FNdzK2cQd/Q6T/WZ8itcMwTRc7bpz+wV8ovABTBp4TKzajPVyUNkOK1mGMIUgu0b0PpxBxOtYtBwQT/Cr4R2fPX4g5lkhu7jjjTAieHDuMphibRZwg7gMZHVNFxa9nS/fZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0JuCQ8A/K3vvFGGCF5jTfG6QC0nMddSxFJ7vmVTgy0U=;
 b=AkhLEdYScQty8uIWaljjDgVQM/2XCi+BjMC4XyUG6w3S8KYSsE17ueaDOaLLUYxUFWSKSk8CHs4zzPVTSH8/bqpZnKuJtUrghR4NpREK13CRi2J+jX9xYuAjvpPwMkjnhu20JhyS67U5UdWjRPbr+81hEBcgHb8pqSRecBOzFEiKNE/eXHErnT/6LtiGbDAacgaUFpXkASeu5upRuLjMZZKwqsPx/2mhM1ewz7dZjXUI2BD1wf9DVOXl1E6d7zXZtn/M1RXfAh7/aDrVe4dxGwbcuNPtGTpbnha9EZoG0yojraEJZCoRDd/l1KzodELeUrQFaU7Mp9BjVSGVR0AnXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6117.namprd11.prod.outlook.com (2603:10b6:8:b3::19) by
 SN7PR11MB6728.namprd11.prod.outlook.com (2603:10b6:806:264::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.21; Fri, 3 Nov 2023 13:47:08 +0000
Received: from DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ee54:9452:634e:8c53]) by DM4PR11MB6117.namprd11.prod.outlook.com
 ([fe80::ee54:9452:634e:8c53%6]) with mapi id 15.20.6954.019; Fri, 3 Nov 2023
 13:47:08 +0000
Date: Fri, 3 Nov 2023 14:46:57 +0100
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: Jacob Keller <jacob.e.keller@intel.com>
CC: <netdev@vger.kernel.org>, David Miller <davem@davemloft.net>, "Jakub
 Kicinski" <kuba@kernel.org>, Dan Nowlin <dan.nowlin@intel.com>, "Jesse
 Brandeburg" <jesse.brandeburg@intel.com>, Paul Greenwalt
	<paul.greenwalt@intel.com>, Simon Horman <horms@kernel.org>, Tony Brelinski
	<tony.brelinski@intel.com>
Subject: Re: [PATCH net-next 4/6] ice: Add support for E830 DDP package
 segment
Message-ID: <ZUT50a94kk2pMGKb@boxer>
References: <20231025214157.1222758-1-jacob.e.keller@intel.com>
 <20231025214157.1222758-5-jacob.e.keller@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231025214157.1222758-5-jacob.e.keller@intel.com>
X-ClientProxiedBy: DU2PR04CA0213.eurprd04.prod.outlook.com
 (2603:10a6:10:2b1::8) To DM4PR11MB6117.namprd11.prod.outlook.com
 (2603:10b6:8:b3::19)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR11MB6117:EE_|SN7PR11MB6728:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a38634e-945e-4bab-dc7b-08dbdc735f5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: opd+EGble9zxn7MrZUXlLaDpVId1FplPcxEZi/g6sfdx/kyEQuzM406Wsq9gfYWbWpY+tJ09YiSUuzP0l7zbJRh6NvPcj1YMRNiC1SyGO5e6Wgqs1pnNRZ6nE6jykvHcYBg85qlgbdhI91SJNXBkR3UaH1ET2Md35OqIZA4PnA9NTO/JKw6muJQXGXgJLJxctY9sRwulYRU00RJpt9LGOCZHrqzZU/VfY38jHOCADcD7bbNQgMiEQ8iiiN2BTdPUhXnwvTlkjqby6FT+QmSAuJtsPR9X/aArB+C/Hi932f8LnfLmgksxEeUSH82qRHO9GP55iv2G4qQM8D9I6l/TRUVPLi2B0d+AedWJf4O5VMxZfAhJguVUi3zwkltUUjCPJ9HwSV4ZU25V/39RbZCmogpp0RvswD7LzRoy31UvGYB5yo1Gol+hy0G3fV5kC4xSXc+i9Wad7Gvitvf5w0TiQfVdHyrM2wC2ts1Bq8N/1kR3x33JuIFaMJCp8NXs5PI10tjctgNZFfrr78vla/z8y7+6htvvQojTinY7JmdWkZTSd+YHBPt4eMeJHj6XDZMA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6117.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(346002)(366004)(136003)(396003)(39860400002)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(5660300002)(9686003)(6512007)(38100700002)(86362001)(6506007)(6666004)(2906002)(33716001)(82960400001)(83380400001)(478600001)(26005)(6486002)(54906003)(107886003)(6636002)(41300700001)(66556008)(4326008)(44832011)(66946007)(316002)(66476007)(8676002)(6862004)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vzDsqJgOrYFCDhZSMa42Sde48RS6cwmcEbUb21FPtaHJEGxy7St9WC1c/vhM?=
 =?us-ascii?Q?FxHjkhFh9MFHUwrjPCx9GPBKkdceCUM4GKwXkyMHX/ezpuz6HYd0JftXUxaW?=
 =?us-ascii?Q?0BeGkoLFZEkLvQ0mLumreyZCErVrE7/Sead4RUjdHyvCqvxZifYcwCREeY8A?=
 =?us-ascii?Q?WHXsE32JxpCycfcX219x+bYF3aDJ/wYy/XXGoQABjbaHZZIOTKSM6Pd+eeTu?=
 =?us-ascii?Q?g0yKL6yaQ3BRsiAa5XhgXBLgEJ5BQ+kkJkmo+Io2Ejv+B6mo5vY7M+htqv9H?=
 =?us-ascii?Q?gKHeeS50MwupUqoczZKs2cXdxOUIMu9cGlPA9iPnUTy7kIPHJEwtwGgXMXXj?=
 =?us-ascii?Q?vgKe9ymplHglyB0jclP2+I96+6ULOxNzHGrgMjnt4njxT/2O2jNG6U0qoxza?=
 =?us-ascii?Q?PcRrbgkoSEpyKHMMir/+PBbs2CXftrNRIjxGY/Nzs21jYKXJqosd7+0n4aJU?=
 =?us-ascii?Q?wUKGeBe9CWORRzecrV7d4SxIysvjMxxckUsBQk0itJpAZGNDZTvV4bkYVR3a?=
 =?us-ascii?Q?+R/ekB5XcsMbe1++F2ZEv0+2pPc90/66wFxn3RRPip0pw4yXkwdu+AVTQM0E?=
 =?us-ascii?Q?bEzeJZoHawMq1Vq/sfea4A+ilYyrnNPRhlhqBybKuRDq1O7hJZY0LegQ3urs?=
 =?us-ascii?Q?aadLEtXQgNgw6KwHQ2AdthSej70pxv9S+CZUCEGCozp2p2IGAFarnSFtVwGL?=
 =?us-ascii?Q?DGN9KOC7IDcn+wce1hXvNst2H02pq2oP/fvGBPxIvuIdFb4x1dtIOw6fxbjl?=
 =?us-ascii?Q?viR2eui4OmnJ0KURVlK02yezfwdxLuIeCFeRAmJcb/5OQz+cWWGSpchK0hZ1?=
 =?us-ascii?Q?M/LP8TbQKgIlB+wsXcwCeZkXYLShVSU6Fv350Exc8Phqb2uWnVDG+DrulsHC?=
 =?us-ascii?Q?4iGWqjfVu3sKKlefIOg69zf7n/RaCti3tjvTjQ82F/Q1JqyWMSt5pmngQMne?=
 =?us-ascii?Q?WeGr865TUIVKMrfU9Ci/VjaS1njCqSNaGx0rs3EaJqinIez37NCzHc8VhVnh?=
 =?us-ascii?Q?aufEO1N1iZFMAkSMik2PfO0/py9kXbTMyxNBJtjXt+ifCCYS2TXct9Opy5a8?=
 =?us-ascii?Q?ze40CEdQWpOje4POUOf55H/00woS8VdZopyIzEGcoLeJMUGX1P2hsZBIDV6b?=
 =?us-ascii?Q?VU2fxw9VbPUf3J/usfWgw0Ev+Cf1hTFY/EcpaQYusSRWutcntvp+gz14k1po?=
 =?us-ascii?Q?MQQByiFetHbZVx/jlOUB/8WbCUCLGnDpmNObABuF1kGHNSxy2X6yZnBt4Ppm?=
 =?us-ascii?Q?76UK710leX8QXvBsnrkjOfjzGiDUskvj+zcZDpKx1xzkvPuQGDKbehNnx4TB?=
 =?us-ascii?Q?o8E0zfbHcyJWPvGw6KfTIQZtw0Hu5dVHJZGmn+2sF+2+JXAoPzqilPFQULyO?=
 =?us-ascii?Q?GdFb5ELi1M0/ax9rD+BjKyqbd8bAW/z9o2o/+bOAnOo//W5Fks1BFMzPU2MZ?=
 =?us-ascii?Q?hTY6iQ47mLOCuk/iZP9AMsiC9CbNPoO92KREf/ZbaR5CYczTDHDpkgbmRIyy?=
 =?us-ascii?Q?PCOd8ufs78fnw2V217/6TQaUxreY+zIL34/Umrn/MnPFRE7ip4MksqDilt05?=
 =?us-ascii?Q?yBT9w53CDAnjU98XxlSqJzGGKXLfneIoDZE7JjUE97IjCujzpl3R3pva2Eip?=
 =?us-ascii?Q?lQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a38634e-945e-4bab-dc7b-08dbdc735f5c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6117.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2023 13:47:08.4356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: akfi4GkQcJZtXnusE0oRkOPyg8gphzK+HJGVxEshAzR2bUpK3KMBMjnUY7WYTtaw3M4jWjvaREgOJWNije3JyySsL09fCt2DKpQgfqhZs+Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6728
X-OriginatorOrg: intel.com

On Wed, Oct 25, 2023 at 02:41:55PM -0700, Jacob Keller wrote:
> From: Dan Nowlin <dan.nowlin@intel.com>
> 
> Add support for E830 DDP package segment. For the E830 package,
> signature buffers will not be included inline in the configuration
> buffers. Instead, the signature buffers will be located in a
> signature segment.

This breaks E810 usage, they go into safe mode. I'll be sending a revert
to this commit or if you have any other idea how to address that I'm all
ears.

> 
> Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Signed-off-by: Dan Nowlin <dan.nowlin@intel.com>
> Co-developed-by: Paul Greenwalt <paul.greenwalt@intel.com>
> Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Tested-by: Tony Brelinski <tony.brelinski@intel.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_ddp.c  | 436 ++++++++++++++++++----
>  drivers/net/ethernet/intel/ice/ice_ddp.h  |  27 +-
>  drivers/net/ethernet/intel/ice/ice_type.h |   3 +
>  3 files changed, 387 insertions(+), 79 deletions(-)
> 

