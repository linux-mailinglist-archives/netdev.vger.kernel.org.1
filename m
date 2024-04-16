Return-Path: <netdev+bounces-88155-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A02E8A6118
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 04:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7288FB215DF
	for <lists+netdev@lfdr.de>; Tue, 16 Apr 2024 02:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D78A35;
	Tue, 16 Apr 2024 02:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="InyQ9EjD"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4F311182
	for <netdev@vger.kernel.org>; Tue, 16 Apr 2024 02:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713235229; cv=fail; b=blSkLopv3Ezf6oxzE7hmtb4XWcTXURKemfMJ0ypobEUnBcBSRZ7TONUJNUQOvwc0S/T6ROytuDwEW7Nv46TL5KZK5AywI5Jc9C+idkD2Kb0Zzq0vLh/8yF4HmvEZM1BG+tiPaKp5IVS5SS4XVie5KU+DF7FGHYzKBrkk3NwvL60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713235229; c=relaxed/simple;
	bh=k7RaOMnx1VQSzuk9Fryu8K9z+YfLAc1OhOBEulsfUos=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=A2HYWRtiG2nBxQRxfSqJoLBBxJTJPt+j7kv8GVECNiFuCG4X0Ib0YVzrhq9byv4etJD5av+7NCfAcPJtLZ3MX19srvyOvs6CncTkpmcufG/HBWVPODG9JAxn8TUQtvsgF05GWYexGrx0rnsHABLZVwhq462hwwckz5QwlrxVN3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=InyQ9EjD; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713235228; x=1744771228;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   mime-version;
  bh=k7RaOMnx1VQSzuk9Fryu8K9z+YfLAc1OhOBEulsfUos=;
  b=InyQ9EjDsDPFhand3eAjUdlRRgLI/zZjvwNE8XbUjRq6171v55Vy57jl
   glzS1vrwadSggYPGFN2UxWnNjQg8TjPp3RUueYWMxiKCEk+IKhAa+5Qn/
   BxxKYWFF1S4lXEEfn0xyO2Jh+fiXXrwcEySP26KbiCp/oBAfxdrjTW3Po
   nWMF+9BHOXnun3reNnwzYiTwFNf9Ugheaq365YSJsUT7ZE+IgIH7bVWa/
   /CynIlUOhYtYdznPIgoGY+yK6Yx/utHuo1ezuR8jm4gKErWSHgOV+PBfY
   zS05soa+QV3rXlYtax8e1Vaq/L5CjaQeoOcR5LKES1S/2cT8w/aV/QuCK
   g==;
X-CSE-ConnectionGUID: zNw4/Db3SSC/dUTWbiBW7Q==
X-CSE-MsgGUID: I9EQL5KyQlW55xu/qwpw2Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11045"; a="8510508"
X-IronPort-AV: E=Sophos;i="6.07,204,1708416000"; 
   d="scan'208";a="8510508"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 19:40:27 -0700
X-CSE-ConnectionGUID: IVvzJFBgSZyB+LTM/4Gk+w==
X-CSE-MsgGUID: NQuf5v2YQQGrNsnfp4cLMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,204,1708416000"; 
   d="scan'208";a="45395716"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Apr 2024 19:40:27 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 15 Apr 2024 19:40:27 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 15 Apr 2024 19:40:27 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.170)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 15 Apr 2024 19:40:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g6QoGWpUbU4hPxE3pLkji/LLbAhGu5FerRgVOaaut5PyS1FmD45lQvaqC6vD9Ajx/oHtpDXSrWlRxHsRa2HoMPceel8zbaA8SP/LhvgPZzph1ys5CE87XHxKUq7OxDeuW38G/sI+kcp4KiiktUtDsT28/nL4sGGwZTRCCPGJZUvMcWpzykd/mEN+io4outxtHJ1p8iBAoZO9ObjoXK+hQeKX3qOCtP2q7Im43Y4yOph28pC8STuMSi9HRoZB6NiMpEIUyHojDGMjtwWYvITo10c3cslqVuGQuEN42BYprvs8gcUbfBXiQA9EUGrt82xlUmDUk3hJbul/I6sLCr18Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iOuanaCdaroswSrvTZIml3+emzvMwGQrez4mG5lVmGE=;
 b=Bp+tqljPukVEM1N/WmrhV5hEYy8PYBA4CVd3URdzLNw04Xybb2jr8ZO1eqeO9iKKzPRbBBUB15VaOPjgnGxI9IxSVtgwgKf+hCTcMoT8JDTB2TVF+OquOUlV7GceZpj7QC8kwLHckFC7l645qLzqKX/5IM6pJFbehyKOKQInl+dtKiX6/duyk6amMlCHyBt/Ncbf5cMhGA0+AvbbbAfkHjwPNUYzWJqonCu9pmglE6ihPj6RTWoSSTNUBEP6W3CPA8YrMMdiZTObfq/Ml7Hm2cpzDvOJdJnqmx4x2tM4OAUBKN7n7nE/1uuak+ISqWJKNTCI3PcBTSkDjOnpiSStQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB8393.namprd11.prod.outlook.com (2603:10b6:806:373::21)
 by CH3PR11MB7202.namprd11.prod.outlook.com (2603:10b6:610:142::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7430.46; Tue, 16 Apr
 2024 02:40:24 +0000
Received: from SA1PR11MB8393.namprd11.prod.outlook.com
 ([fe80::c0cf:689c:129c:4bcd]) by SA1PR11MB8393.namprd11.prod.outlook.com
 ([fe80::c0cf:689c:129c:4bcd%6]) with mapi id 15.20.7452.041; Tue, 16 Apr 2024
 02:40:24 +0000
Date: Tue, 16 Apr 2024 10:33:47 +0800
From: kernel test robot <yujie.liu@intel.com>
To: Steffen Klassert <steffen.klassert@secunet.com>, <netdev@vger.kernel.org>,
	<devel@linux-ipsec.org>, Paul Wouters <paul@nohats.ca>, Antony Antony
	<antony.antony@secunet.com>, Tobias Brunner <tobias@strongswan.org>, "Daniel
 Xu" <dxu@dxuuu.xyz>
CC: <oe-kbuild-all@lists.linux.dev>, Steffen Klassert
	<steffen.klassert@secunet.com>
Subject: Re: [PATCH ipsec-next 3/3] xfrm: Add an inbound percpu state cache.
Message-ID: <202404130802.rDxN3ijD-lkp@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240412060553.3483630-4-steffen.klassert@secunet.com>
X-ClientProxiedBy: SI2P153CA0004.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::23) To SA1PR11MB8393.namprd11.prod.outlook.com
 (2603:10b6:806:373::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB8393:EE_|CH3PR11MB7202:EE_
X-MS-Office365-Filtering-Correlation-Id: 96160675-5504-4ad9-219c-08dc5dbe914b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HzI7HW++qLfyfZHtakWaZ7f1T5lz2mCmeRoDzH40H6Xkf2MUk6wrbHaYKCU+aNCJpaaIP+UmaltfZhk/usfBud0HcEfwF/8CUg3HPC/GKFoTnY/QFhAVwFvbg9HP/EtEpEsnuqyvjPOCzR8cFqKCDQzP5uIeLEd4G86otA2rRoxAr2UBzgVeM31faGr74Ll5OpjhWbO/utNFNyAsGjerruIYtTmLRkkjuWLqqn8pGflaKDWryxOELzVTCteUcmhVEv4/+ha1H2p0vXUVvB9wRhdt9aT7Hmv3ahsNKdcdvx6ZZ2AFUfSGaHU3ZFRfPReecBc4wMMdIHUHyz9ZDA4LY923YynhRx2q1nUEw8eaVnTnNyOpYOPrcX6UgBruxCJOdpHiDT2/7aH3QbSAuXBVzKuB6i2FM+MtAP0hN6RDEYfBL+DtgnQlNeMN9tX7O79k8zGO2xhegYG1JsJ2hIqSjyfxvriyNVpTYaiuVKbUhVPbmRZNh0cyW2bVC9GfTmKbngaILd2iZ/VrELZRPOXW/+QhoLPoHt4DJQ9YSYO62IyusX87EC7JNIge1h36SZgkrbOUhdzxpHv3ViPAwcjyo8/NglOgXTKrtE1ObofDtjUxI9MjFzpRRXN90expCbIs
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB8393.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?O1O7voQarU7bl/+MVIGRF2MTw5GQu2GZucratI1baNkyjMnsgt6O5L+APunB?=
 =?us-ascii?Q?z3Q99wkmreo9WsKMoGxdwTSbs+nsSRzR58sh7+M19OLdLWU/tHv/BLnWxKjz?=
 =?us-ascii?Q?jCu+fVA9dir4WOJYJ7+i8B2Ks8zKYqYOz1G8kl7vLcL272i4DghqJhF8p00P?=
 =?us-ascii?Q?xMw+8rdlPcj/jMRh1Z7f8NPQ+dRKdoeXcJZRijpEpvQBUK0aNtrmMx/RMB65?=
 =?us-ascii?Q?HwBvPjXJjCUCOfxSYnXNU5Eyv6hT7j7dHLcUVd6NcHw3icRsxefAPfCc5P0x?=
 =?us-ascii?Q?3NFaIFn8nghtObHqvBB29v5RiI7CNxTPPsCD5DfJfTDQdVfH3fVwkhwzVU+Z?=
 =?us-ascii?Q?Fx5XNmUgfVVe10nJ8vcHASnOy+mw62Kq/zCM9ZvZGAIJyQbAIoSRI+W6BHE0?=
 =?us-ascii?Q?aUsO7PfrTNvtYe0iJ1q8o326v1PqfQ3wkIOsFj3k6KV2eVVjILvuwS6L7Mxu?=
 =?us-ascii?Q?4LVCZOJ5kyz9AZQoZ3/dv4VC6N29AYjl4JYdTmmMKPRDwscQInFJMKSH9SMg?=
 =?us-ascii?Q?+SygMAAJivBF2eM0MUQvzerPXI2IIi26Vc4sIpNnLsmuDwG8nGLBLRz+/aIy?=
 =?us-ascii?Q?xnosbzHfayYWl54SgUsPHCAUE6/u8dlZb5X1FmZnC8kiloKKHNEWj6sTYhuv?=
 =?us-ascii?Q?GF6apc1OOzJYOBbl9a1hbVHzjP+X2oQu+OKWv2P3ZnaP5wtXqPKt80qVBRgu?=
 =?us-ascii?Q?M9Rl6IVErbCPx/0VUJ3THpbuqeZLJeG2cAyNUFmZgBaoZ4ptFj2bVmEtnbXB?=
 =?us-ascii?Q?eJO7xaY7/mkGuBSgOWBGghgJN9Iwi2S1dJcbgRQBExiH+1VmBwibNmiXx/or?=
 =?us-ascii?Q?irSz/3FZKD+TrArRXdVD7s06Qn3EcWYU3LKX5KMvyGtYQbd3FZgleFGaiFM3?=
 =?us-ascii?Q?bt48iv0v2mml/x8VVf+StDgnPlaaVWHr3sZp2g4eXMTCBmf/dOw6G836En2i?=
 =?us-ascii?Q?y5XuESCCyJ/UHwFVs6FiIoJfkNVGkGv+MOG8Up17lY7TPnUwvoLFBBhwLx4Y?=
 =?us-ascii?Q?3uUGrIWCF02wGRkHFI4zXtVSMbDMVTVg7jxRpMCR3B77m9JpcwJfXt/36VWM?=
 =?us-ascii?Q?S5EbnhbLrEodjBZeTVLepd5vxA6PGh3PSyAT/Nfy3dkug2vhq9TSCpc3H47S?=
 =?us-ascii?Q?JuIwiDIdZU1yyaznc0Z8eIbEbacR76hDjNGwwU6pvN728JNRuhmnJCYMcg2o?=
 =?us-ascii?Q?CFvcLucJoge8/BwZdvgoYHLtHP3SSgCws7i2tciq+D4kbzzjGIhS10BGzI/c?=
 =?us-ascii?Q?+1KlZ0nPr1KeDTlsBXRNMmXyKS4zKekA8tvNVG/OyvSydteD+eXRt5Oa85Uh?=
 =?us-ascii?Q?IQOG8k/0kefPJ+bI/PdtOsm0YLD34Rl7VWS9+abXk2P0w3ElA6ZJ7xJh8bJo?=
 =?us-ascii?Q?yN3Melky159tf7lHAlnQdBlX9vPWlrqU6Mwzu8uOqmXmdB16bXquUNVtOkxT?=
 =?us-ascii?Q?g76qQcn8btKH9REbxK8mdjqHFaIDK62wR/l8YyvS1ND2T9fushcW8q9cpZpN?=
 =?us-ascii?Q?zgOjLWXVXOZ23xhGC6g/KzoWBwIAgvVmn8CmJ2NRUOfiJw4RfGCDQmyvv4oL?=
 =?us-ascii?Q?iT6LdFlK8h+B0Xb9yASyMW4Bufu0bmCOFBi8iTaJ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 96160675-5504-4ad9-219c-08dc5dbe914b
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8393.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2024 02:40:24.5760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nNfEj4TT3uuTeLFVrzomE+0E4Jt1RGtHCYoovAuGb2SmMA5b2xxDmeSnRDMcKoLWiTzGyfzZBR0qoa4/utWPQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7202
X-OriginatorOrg: intel.com

Hi Steffen,

kernel test robot noticed the following build warnings:

[auto build test WARNING on klassert-ipsec-next/master]
[also build test WARNING on klassert-ipsec/master net/main net-next/main linus/master v6.9-rc3 next-20240412]
[cannot apply to horms-ipvs/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Steffen-Klassert/xfrm-Add-support-for-per-cpu-xfrm-state-handling/20240412-140746
base:   https://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec-next.git master
patch link:    https://lore.kernel.org/r/20240412060553.3483630-4-steffen.klassert%40secunet.com
patch subject: [PATCH ipsec-next 3/3] xfrm: Add an inbound percpu state cache.
config: i386-randconfig-061-20240413 (https://download.01.org/0day-ci/archive/20240413/202404130802.rDxN3ijD-lkp@intel.com/config)
compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240413/202404130802.rDxN3ijD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <yujie.liu@intel.com>
| Closes: https://lore.kernel.org/r/202404130802.rDxN3ijD-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   drivers/net/ethernet/altera/altera_tse_ethtool.c: note: in included file (through include/net/net_namespace.h, include/linux/netdevice.h):
>> include/net/netns/xfrm.h:46:39: sparse: sparse: duplicate [noderef]
>> include/net/netns/xfrm.h:46:39: sparse: sparse: multiple address spaces given: __rcu & __percpu
--
   drivers/net/ethernet/altera/altera_msgdma.c: note: in included file (through include/net/net_namespace.h, include/linux/netdevice.h):
>> include/net/netns/xfrm.h:46:39: sparse: sparse: duplicate [noderef]
>> include/net/netns/xfrm.h:46:39: sparse: sparse: multiple address spaces given: __rcu & __percpu
--
   drivers/net/ethernet/altera/altera_utils.c: note: in included file (through include/net/net_namespace.h, include/linux/netdevice.h, include/linux/if_vlan.h, ...):
>> include/net/netns/xfrm.h:46:39: sparse: sparse: duplicate [noderef]
>> include/net/netns/xfrm.h:46:39: sparse: sparse: multiple address spaces given: __rcu & __percpu
--
   drivers/net/ethernet/altera/altera_sgdma.c: note: in included file (through include/net/net_namespace.h, include/linux/netdevice.h, include/linux/if_vlan.h, ...):
>> include/net/netns/xfrm.h:46:39: sparse: sparse: duplicate [noderef]
>> include/net/netns/xfrm.h:46:39: sparse: sparse: multiple address spaces given: __rcu & __percpu
--
   drivers/net/ethernet/altera/altera_tse_main.c: note: in included file (through include/net/net_namespace.h, include/linux/netdevice.h, include/linux/etherdevice.h):
>> include/net/netns/xfrm.h:46:39: sparse: sparse: duplicate [noderef]
>> include/net/netns/xfrm.h:46:39: sparse: sparse: multiple address spaces given: __rcu & __percpu

vim +46 include/net/netns/xfrm.h

880a6fab8f6ba5b Christophe Gouault 2014-08-29  31  
d62ddc21b674b5a Alexey Dobriyan    2008-11-25  32  struct netns_xfrm {
9d4139c76905833 Alexey Dobriyan    2008-11-25  33  	struct list_head	state_all;
73d189dce486cd6 Alexey Dobriyan    2008-11-25  34  	/*
73d189dce486cd6 Alexey Dobriyan    2008-11-25  35  	 * Hash table to find appropriate SA towards given target (endpoint of
73d189dce486cd6 Alexey Dobriyan    2008-11-25  36  	 * tunnel or destination of transport mode) allowed by selector.
73d189dce486cd6 Alexey Dobriyan    2008-11-25  37  	 *
73d189dce486cd6 Alexey Dobriyan    2008-11-25  38  	 * Main use is finding SA after policy selected tunnel or transport
73d189dce486cd6 Alexey Dobriyan    2008-11-25  39  	 * mode. Also, it can be used by ah/esp icmp error handler to find
73d189dce486cd6 Alexey Dobriyan    2008-11-25  40  	 * offending SA.
73d189dce486cd6 Alexey Dobriyan    2008-11-25  41  	 */
d737a5805581c6f Florian Westphal   2016-08-09  42  	struct hlist_head	__rcu *state_bydst;
d737a5805581c6f Florian Westphal   2016-08-09  43  	struct hlist_head	__rcu *state_bysrc;
d737a5805581c6f Florian Westphal   2016-08-09  44  	struct hlist_head	__rcu *state_byspi;
fe9f1d8779cb470 Sabrina Dubroca    2021-04-25  45  	struct hlist_head	__rcu *state_byseq;
042bf7320e286f6 Steffen Klassert   2024-04-12 @46  	struct hlist_head	__rcu __percpu *state_cache_input;
529983ecabeae3d Alexey Dobriyan    2008-11-25  47  	unsigned int		state_hmask;
0bf7c5b019518d3 Alexey Dobriyan    2008-11-25  48  	unsigned int		state_num;
630827338585022 Alexey Dobriyan    2008-11-25  49  	struct work_struct	state_hash_work;
50a30657fd7ee77 Alexey Dobriyan    2008-11-25  50  
adfcf0b27e87d16 Alexey Dobriyan    2008-11-25  51  	struct list_head	policy_all;
93b851c1c93c7d5 Alexey Dobriyan    2008-11-25  52  	struct hlist_head	*policy_byidx;
8100bea7d619e84 Alexey Dobriyan    2008-11-25  53  	unsigned int		policy_idx_hmask;
3e4bc23926b83c3 Eric Dumazet       2023-09-08  54  	unsigned int		idx_generator;
53c2e285f970300 Herbert Xu         2014-11-13  55  	struct hlist_head	policy_inexact[XFRM_POLICY_MAX];
53c2e285f970300 Herbert Xu         2014-11-13  56  	struct xfrm_policy_hash	policy_bydst[XFRM_POLICY_MAX];
dc2caba7b321289 Alexey Dobriyan    2008-11-25  57  	unsigned int		policy_count[XFRM_POLICY_MAX * 2];
66caf628c3b634c Alexey Dobriyan    2008-11-25  58  	struct work_struct	policy_hash_work;
880a6fab8f6ba5b Christophe Gouault 2014-08-29  59  	struct xfrm_policy_hthresh policy_hthresh;
24969facd704a5f Florian Westphal   2018-11-07  60  	struct list_head	inexact_bins;
a6483b790f8efcd Alexey Dobriyan    2008-11-25  61  
d7c7544c3d5f590 Alexey Dobriyan    2010-01-24  62  
a6483b790f8efcd Alexey Dobriyan    2008-11-25  63  	struct sock		*nlsk;
d79d792ef9f99cc Eric W. Biederman  2009-12-03  64  	struct sock		*nlsk_stash;
b27aeadb5948d40 Alexey Dobriyan    2008-11-25  65  
b27aeadb5948d40 Alexey Dobriyan    2008-11-25  66  	u32			sysctl_aevent_etime;
b27aeadb5948d40 Alexey Dobriyan    2008-11-25  67  	u32			sysctl_aevent_rseqth;
b27aeadb5948d40 Alexey Dobriyan    2008-11-25  68  	int			sysctl_larval_drop;
b27aeadb5948d40 Alexey Dobriyan    2008-11-25  69  	u32			sysctl_acq_expires;
2d151d39073aff4 Steffen Klassert   2021-07-18  70  
b58b1f563ab7895 Nicolas Dichtel    2022-03-14  71  	u8			policy_default[XFRM_POLICY_MAX];
2d151d39073aff4 Steffen Klassert   2021-07-18  72  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


