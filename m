Return-Path: <netdev+bounces-50243-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A2E7F500C
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 19:58:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44F412814AA
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 18:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C055D4AC;
	Wed, 22 Nov 2023 18:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TjLlJCNu"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB4EE3843
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 10:56:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700679386; x=1732215386;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Z9mon0MixRVxdOOX15BiI9K/cTCCV9ps4yRWdv7SSnc=;
  b=TjLlJCNuUzxqOXv4WdW8PWffGMCp9wwtuQF4KKGLTxgDFUdrWkZ1c1vZ
   O9SyNTQOrzfWMaM+Nno2MLomYeDAZsQWanB9/M+6PZYn4JFPwo8KeGMaQ
   9cLf+7YDE9uuEXabXf7MTCNDiwiICHfFecj4yICfpvMf4zXdj7H38YDVu
   ErZFKE/pkFhIEp6WJNsElEeBk3m7mlU5J6/XTyTp10/MzViN3essJnZUb
   bffTMgaaiukZ/+hSbrxeMQ94FHkpTZnbTGasgMNhhwO/lMdRBiE7fj2QX
   EKL5Jr1djfhLguTmFkbAnrtvKQYzqcz+ueBLj+u2Ko6+YIMdlVm2w58kn
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="377155408"
X-IronPort-AV: E=Sophos;i="6.04,219,1695711600"; 
   d="scan'208";a="377155408"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 10:56:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="884742331"
X-IronPort-AV: E=Sophos;i="6.04,219,1695711600"; 
   d="scan'208";a="884742331"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Nov 2023 10:56:24 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 22 Nov 2023 10:56:22 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 22 Nov 2023 10:56:21 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 22 Nov 2023 10:56:21 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 22 Nov 2023 10:56:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OAJM92KkuykmAh9PrAMwZJlVnSewUgnI48ST1RqV56aRzEVgHTm1vrl4fWIHE1u7+b/oHM4Kng+oDxgZgWBs5be1ddBN3iAoUX6f3DlmJ/XbtZBAun5RFxU8Q3bpjja/dlx6919J61tFMhZisp7YM0sMFOOg7+Ow/5/5DFpEj/CscNkDN15TEiylcsrO9z4sE94uTfg/Fc01mIOCH4Ah8bOKCfdHVK9iVqIFx1H+1b/oKCtMlGq+cNhZLA1+boiIESz0RmQ/875oXowH01wL9b/A0BMH0u7faLT+inQWPRJoYuSycKka/BFVapdIS6mlp4Fk2WGU9tlGHAPDJaYTHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=damYuqkirvNEOmD+MW7jIyaJmzJkin3Se+EL3wlVpm4=;
 b=YBWoc1U+3Z/2Alj6pMzQlokRckpsoDDD3/svb3fA4f4vJs4+FCtJ/q9zoFR2yA0UOeNkU+cmpxhF6+hxpvpkNaaVXxnkOxWDP4WgPcC4CwcsNXSTmeTBdXeT+cJ04s0WeKqPnQEWLiuPbzl2YwOOLKAyvGJ9N3UZGQe6ihWooW+Xs4ouvQOArhMzPQQxJI0mLVYeBLF5nxIiCf0iwGSF7pqNsjXxYR6U5ZaDYQdHnjFLOj8CtD/u+vZH+BAWBoC1RFRj+mDXSM4IgLXbG9+iLqvJjd7xcY7nXmK+j6NmoKErLf6pRNMvxfQ7wVm+yGefpapLIbVF2g7nVkSNsyxRog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7540.namprd11.prod.outlook.com (2603:10b6:806:340::7)
 by PH0PR11MB5000.namprd11.prod.outlook.com (2603:10b6:510:41::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.28; Wed, 22 Nov
 2023 18:56:20 +0000
Received: from SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::f37d:cbd6:9df8:d06d]) by SN7PR11MB7540.namprd11.prod.outlook.com
 ([fe80::f37d:cbd6:9df8:d06d%7]) with mapi id 15.20.7002.028; Wed, 22 Nov 2023
 18:56:20 +0000
Date: Wed, 22 Nov 2023 19:56:12 +0100
From: Larysa Zaremba <larysa.zaremba@intel.com>
To: Ioana Ciornei <ioana.ciornei@nxp.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew@lunn.ch>, <netdev@vger.kernel.org>
Subject: Re: [PATCH net 0/3] dpaa2-eth: various fixes
Message-ID: <ZV5OzJ70dW1WxeyQ@lzaremba-mobl.ger.corp.intel.com>
References: <20231122155117.2816724-1-ioana.ciornei@nxp.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231122155117.2816724-1-ioana.ciornei@nxp.com>
X-ClientProxiedBy: VI1PR07CA0140.eurprd07.prod.outlook.com
 (2603:10a6:802:16::27) To SN7PR11MB7540.namprd11.prod.outlook.com
 (2603:10b6:806:340::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7540:EE_|PH0PR11MB5000:EE_
X-MS-Office365-Filtering-Correlation-Id: 043d8e2e-921b-4ae8-2603-08dbeb8cb6ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dVtFuEldVI/IovhNmDbf3ySrUZa5Gt5uaZB4UITONLINnw0dOq7GRhgqTV5k3BQ85YC22/l7k8Vp43K5Y9Bvt8iGAy5dysqeD8Uv8LkZg3qcOOjBgpLNvEG8WZQRfmIyzHaIaolPMpebLnD74ABPOC1+APIT2CICBKz1nmo9QATvpk3vO0KwMEqRf3d7JQ2ntiWy6QUPTh6+hUZkrIfw6C0AzweWc38GLJUkQmK8QijNih5w+0KK3q5yYEcK0u8HPb8bGxTbI9GMToclTTiS4htvcETO5PBfhNMBKcxYrvH/DV35zaT+g5s6+G8VmEoCU1WnDtanKZHYs+Eulfflg8OAPZHHecFC4NnFPveC6YyRYMtS5dwVDf16e4ZZFK/S8LPdCLOSP/j4wurE6rvD74salG+qYvduYG2e4ETQgKfO25WMUQRJZdQpAxfBX0K26Tgpc4uAdxm9B15wkhLHChlCjDyYeIrQ0BEX7QoDmTMqV/XHGoV1ZPFlDYsnTcLfCdAN+JdSOzSUycrC1hmZ/MWPWOXnBBAyfLqKO8Opeim9JDiPymHMivyORkbi6AA3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7540.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(39860400002)(366004)(396003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(6512007)(6486002)(478600001)(26005)(66476007)(66946007)(66556008)(6666004)(6916009)(316002)(38100700002)(6506007)(82960400001)(83380400001)(8936002)(4326008)(8676002)(44832011)(86362001)(5660300002)(41300700001)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Q7577hcWoDqosi7tIA01/zzRLg/0pA48hVEjlfN8Gg5mlPtgQIVkvbBqVr2C?=
 =?us-ascii?Q?6Q1GR8m1Hldmen6SFH0JF7W7keWUChW1qJ5gWHj4sMjcHvGuSMgj9JTBQZkr?=
 =?us-ascii?Q?BsCaXJlXQB8+j7CqxX5aYmdhX+6sD5AO+b6uespASMYHbgdDqFRk5cNCMOvN?=
 =?us-ascii?Q?gHp+ZLNhxV2w0p/pguGEd0gwRkln6vZxjZMc3ifTw8BLJCZ3+ojlYrqyXTs5?=
 =?us-ascii?Q?x48n3A+ZOEiA0EIqE6bAY9SJn08VzcTImqV+ld1Qvyx6OPVVGrEEC/GKIjBq?=
 =?us-ascii?Q?oBusDSPIuUFQfwOG78oSLZTg7krgs1Yy0nG6cNnouWIBEYCkVhf7mJz6dxgB?=
 =?us-ascii?Q?oOi10kbI4TkQL5G0KH/aymrSno/igsc+7U1gNpErXv2hkWHqdTY60sMUkchK?=
 =?us-ascii?Q?7DXxEMYZ54lCdg9g1R/UM8wJkHZsTVmbGum8ck4ys9Tr6qLJEAkYi3j6BvvL?=
 =?us-ascii?Q?3rqQSx1iFjaMg+bcUFG7QBOCsv4NI0I8HysBWvdT0IVh0Et6FnR6OJgDHeJu?=
 =?us-ascii?Q?VDdZjqdQB+ullVohLBiNSt+ucK70yD1qNf9ZEzTV6EgQCkrN0JWa64VHTuv0?=
 =?us-ascii?Q?p6HHRPPwYeAUqDFoRKrJPQZVu4UKCV15nQ0oOPLbHg/vFMze58aEszNGHp5z?=
 =?us-ascii?Q?ZNeKVn44aqHq3vixYZ9JuDQ6jdY8C+llMM8zBRGYxuOExsrQv5ukmBwxEikU?=
 =?us-ascii?Q?4SIkG+VsJzchDw17EOd5hxrF7d/UuvLnoqEy4qoXxD0YF10ccDsMbaDfpvWG?=
 =?us-ascii?Q?I6vj7j7BA9u4jAqp+OnZpNCj/2IN79pFxYleWNRRHBECMwNqB84U2MKK91fh?=
 =?us-ascii?Q?1FRQK46zdtbF8rJr0UOIhyr2GV+0Er6YHY5V4bXZyJCkeA6wx8IlWFgJMJy3?=
 =?us-ascii?Q?P7hvIFTCWe79twhvkgex/ZmManEIPVybfRr8JcCBNtQ3AisYgYof8pIXcqqb?=
 =?us-ascii?Q?kns40JGKxxAtsNUwVxjxTEHgxiWb9Vc3T4OeCCy7l0Nt04/vy3oIKvvQX32u?=
 =?us-ascii?Q?YRaChEi03Y+t4JCbO6oAYPoF8PTP+XoV6F/9y+/mTfOCkVbwxgUapcgJuiC4?=
 =?us-ascii?Q?mjfED/93K7kqIlIfG8ryHyfAHgCbPk3VcR9s3izl2mG5knTFU+fyW9tia+Kl?=
 =?us-ascii?Q?CuEFQ3GEA3s1zoy4N2ysIjdZv8pOwv0ArehH8E+0hWRU4LaI2EfuQ0Ma7IMJ?=
 =?us-ascii?Q?k8JeVne+itDa2jIzGTpBcfmDBFoJzjZ/kRmUlIuOFzkZBeEEY8Ck/ASUj0UO?=
 =?us-ascii?Q?chpsgPWRmem+gSEdB4G3ItErE4MIgl1JS3neqlJDEK7f7xZb9QWqnjOzZEHP?=
 =?us-ascii?Q?UKwLMZ+3yx1LrFYPEUWYSGRr1xmhrMtH9io176vUbKLRx3BpCKeB1FEjfplq?=
 =?us-ascii?Q?N+GCN/FiOqYlOPvEH28V3ta6UjZkE71lo7F6KtLpRLklVnKr12mh9G53xZcX?=
 =?us-ascii?Q?YBHVrm0c3x5ikKLsaV2U1Npf8nV+N+WE+61Z861AY9lbnj+HJZvB6I2claxm?=
 =?us-ascii?Q?3WRZZn6JJnba4pzSOeDwvYicYhnazZJsr4AWfyaL4YmYpVjyJ7KEPrEZnheY?=
 =?us-ascii?Q?/DqVJtwIfelNuOEMFXkejq06qDAbIT5uxZJq8yo21tTTTjPRbp5VHc2wHSXq?=
 =?us-ascii?Q?zg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 043d8e2e-921b-4ae8-2603-08dbeb8cb6ed
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7540.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 18:56:20.1144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bhDtqDW5qRWDuNDEIBV3RYAIwPebxFmWWRwOQJJn53LPLnVNYvDZ+12XONQf0D//EcoEdAulBdv1T7yUmsdlzQmvqxcP0IW1dBjcfqC/79g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5000
X-OriginatorOrg: intel.com

On Wed, Nov 22, 2023 at 05:51:14PM +0200, Ioana Ciornei wrote:
> The first two patches fix a memory corruption issue happening between
> the Tx and Tx confirmation of a packet by making the Tx alignment at
> 64bytes mandatory instead of optional as it was previously.
> 
> The third patch fixes the Rx copybreak code path which recycled the
> initial data buffer before all processing was done on the packet.
>

I think patches 1&2 should form a single patch, because they are supposed to be 
backported to older stable kernels and this is hard to do, if one of patches 
lacks "Fixes" tag. At the same time, they clearly complement each other.
 
> Ioana Ciornei (3):
>   dpaa2-eth: increase the needed headroom to account for alignment
>   dpaa2-eth: set needed_headroom for net_device
>   dpaa2-eth: recycle the RX buffer only after all processing done
> 
>  drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c | 16 ++++++++++------
>  drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.h |  2 +-
>  2 files changed, 11 insertions(+), 7 deletions(-)
> 
> -- 
> 2.25.1
> 
> 

