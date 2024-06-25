Return-Path: <netdev+bounces-106303-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8439E915BA9
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 03:27:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7824B217A2
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 01:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5ACA17727;
	Tue, 25 Jun 2024 01:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gAinn1Pl"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0026F15491
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 01:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719278829; cv=fail; b=iQQOgRcywqchyC4SChGOoJtOpvQZ5bZeKg6xtXyieRivVtY8niTwAoQXUT9Donwm6LCZT2ExJeeui3qtQZcn8u22fTZvDjLmnmJVBryujdv/wIF3NJzDfrPbXgWZgkvpemqPN/HGdk2PHBoUsSCyocZjiofEnzeREHamlsQHMjE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719278829; c=relaxed/simple;
	bh=d0UYT58BHAzWNu2xi6lsGfX/f8y3XaXm/5/g9MY4FQU=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=VnPFq+UBRzU6YKAFFurWjR/UA/y1dHHVU7Dhha+Ctalfn3ohANeFBWCv7nbWp8TUAv1BEoXZo6F1uOGXafQRtXMMGheJZbcua3rnffBWRJwcTTvC0KPGy+L8wREOgyyg38yeRNHlFy3umG13eVtuy7ZZPdtbcAVzUyz8ZJ4lFt0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gAinn1Pl; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719278828; x=1750814828;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=d0UYT58BHAzWNu2xi6lsGfX/f8y3XaXm/5/g9MY4FQU=;
  b=gAinn1PlW+cmf78Xj7pSXj56Xe2XwEekFakcDWdDEoB7viRM5o+N2aBx
   //ANW//ZkIHOJ7qkQarFh8q88SCeFIT74cl0hC5fUvwty9gvG0IGqZ3jb
   JePcymTGgNS803dMbSuWdL9tui6NQjvg0+8Up56AmMhnIaA23Kk4yBuPq
   IUpBi22avGQqHu86+uuM7/73sY3NfOuHykvUrGH9H1fsEzOG1fDeIpfrf
   5LXtnY1pVvK5v++SPjzGFb6TKN6eSIOaX5doKNstv/9KX75M206nKAXbY
   HIKmDcvNGmDLegrMcHckYDPWL95xOmfqjL6wxLUOfK8yT5xBs7g/+O9I1
   A==;
X-CSE-ConnectionGUID: vNZDOeo4SiG1Y+79YgMh4A==
X-CSE-MsgGUID: /8mZvbciTm+6GKEKzXc59g==
X-IronPort-AV: E=McAfee;i="6700,10204,11113"; a="26863986"
X-IronPort-AV: E=Sophos;i="6.08,263,1712646000"; 
   d="scan'208";a="26863986"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 18:27:08 -0700
X-CSE-ConnectionGUID: i0+JwfH4SzmoKnjp0GrAUA==
X-CSE-MsgGUID: YURAoqvxRr+aLf7j4/TnYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,263,1712646000"; 
   d="scan'208";a="81018366"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Jun 2024 18:27:03 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 24 Jun 2024 18:27:01 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 24 Jun 2024 18:27:01 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 24 Jun 2024 18:27:01 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 24 Jun 2024 18:27:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eXYYZH0xIzhfklzaHyzwVV6f1ZjCjjCb5Y5r9kIvB7DZhIPHhYQvtGpuqEfm277tob70TJI+vFFGfWHDFgjTDEw1BEmy0ROCGI5UUV4JYgKlemR6S1UKi4xss7m45h/D82vgot+ZElSeS5Ykx6ElgYugtkd4ow3mLkWOHRaNOwJdNieTOSWBSB0jAn3K4JhRt06RiH94TNQQ6C9M/AE6s93x/y3soYKK3ZOjuuljOlzl4qM59ldcEX/DCvwNHP/5bEhrsAc0vvIHG2/HmIYrWPpt7OSNtNrrIqnfwWNx+EmgJBWv3AtL7urYKRmYkNLg2wAwJVMDIc6LQautvjvK6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v/Vi1HzAvSWq+dLLN+wVaiIHLVx4FsCVoP6nmnbPu+k=;
 b=UH6KipksJElRvT9TX6dHWjgUKHOjF1wK9i65Y4z5PWAPwzwfdzF1HZ1KjBThNVeZnTg0lRUjvBw2WIELY6TeIlVILhpOoc3zze4lyqyuDSIrdtUYr7BAoVg9Aeo4yRRedQc+udWX+BWALAs/wR+W0LgcZHs1Xx0QgW4UAMjaNKogeNXnMupRGjmPBgtj2Tfk9Qd0eQWpbmHiTBOX3x2llDRXbUQtIwTtZ+C/8hmbz14Ib++pw3DPXxENFbz2tO0PONrEyrGLPq/asAf+wvAzkyJ42pWUFrfLUnVwq3KmJapOeQjqcjkiWio0q8EAPwK0yGN9yDDrt2GBL2gj8mrveQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LV3PR11MB8603.namprd11.prod.outlook.com (2603:10b6:408:1b6::9)
 by MW4PR11MB8267.namprd11.prod.outlook.com (2603:10b6:303:1e2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.28; Tue, 25 Jun
 2024 01:26:59 +0000
Received: from LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c]) by LV3PR11MB8603.namprd11.prod.outlook.com
 ([fe80::4622:29cf:32b:7e5c%2]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 01:26:59 +0000
Date: Tue, 25 Jun 2024 09:26:49 +0800
From: kernel test robot <oliver.sang@intel.com>
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
CC: <oe-lkp@lists.linux.dev>, <lkp@intel.com>, Linux Memory Management List
	<linux-mm@kvack.org>, <netdev@vger.kernel.org>, <oliver.sang@intel.com>
Subject: [linux-next:master] [rtnetlink]  5210cbe9a4:
 hwsim.mesh_sae_failure.fail
Message-ID: <202406250935.f0f05c9f-oliver.sang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI2PR02CA0008.apcprd02.prod.outlook.com
 (2603:1096:4:194::12) To LV3PR11MB8603.namprd11.prod.outlook.com
 (2603:10b6:408:1b6::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR11MB8603:EE_|MW4PR11MB8267:EE_
X-MS-Office365-Filtering-Correlation-Id: dfbb8210-2f71-4ecc-7ddf-08dc94b5e8bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|376011|366013;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xNeXiYAx4fDpo7HMDtzhbmd17EEQH6Dj4c9CiV1P5cisVDtWIojsHzPykTWO?=
 =?us-ascii?Q?tsGC+HefHGvu6YCxzk+/Vz8nRkjiin38AAS1vno9gJih06qgkdSPQ5YZ7Hp3?=
 =?us-ascii?Q?tvvAwVrajCck/K1rRrjhOKdLYleU9pFXIuNOfFbGAPjUCViuogeSJ2yi+OS+?=
 =?us-ascii?Q?j3NatdfK84u7Ckgg3zhCUNzGMvTw4su+cM+ef10nj1CfxW4MPh0cs8MjjwQ/?=
 =?us-ascii?Q?71LCmt62V29cJOPru6eo4GssirqVt/EGh/0i/UJ0iECTtWeP3TcETso4xHUY?=
 =?us-ascii?Q?Y5oCxoqs6q8uLsoLnMyS3RmpfzgChI/lS/G7dM+oyjn/cZPIkG5Rla7t/gUf?=
 =?us-ascii?Q?0ez53cfDIX8hlUbIg28p1Xy3/TaztLEkE4GfKHq5rek16KITCVPVqw1GRhjg?=
 =?us-ascii?Q?/cyqggl+dmtur34aR1PODfQogGVjUhqKYezNkanZwfmwL3GhEepBaKrjOOwW?=
 =?us-ascii?Q?zYdTptnBxDlfMLB/lUvNVlMX0PeXT5+cu+s2egPdqyWOy5FGrbY/BiRNMZpg?=
 =?us-ascii?Q?lxUAucJsNT934jUbcHKWpWFz/eh4FP804UxLH2J9bIGKY+tvdXsItsUNxjwg?=
 =?us-ascii?Q?lxIDCFkXzfGWjwLEeOaWYWuy6ZRiwlLddYJ3Kgc6atkmMtjEwsszJIkNCzZ3?=
 =?us-ascii?Q?cz5YM0i2wBke2VO9tVG0Qc7BLZVdT1STmrKUb/MJabLAlmJkeaxV+CR/QxWF?=
 =?us-ascii?Q?18XokeU3CNzDABBrWnrVdWUyKUyBRuKZAGaQZDwDCpboj3FLvi7/q9KivDcN?=
 =?us-ascii?Q?3T01jezgqCygLuE0NcOLPV+cpn6JHaK0PkpK5Q9nyWgZinI6/KTGODlJjboI?=
 =?us-ascii?Q?amO8grkOAj/dormJ5GR16MW3pop2BtN3YMo+B8BLATI15RFUnIemA67daz+2?=
 =?us-ascii?Q?2rJeBG9pU8B+bOCHJ7vBYgtt2AQQU+PSUGmMVhQW40fnR8Ype0XQDTZT65xj?=
 =?us-ascii?Q?fkS8j0LoGScr/EGv3LoFD6bdkuBD4ipLJw7MCK9xI0b/oVyJ6igQ9P+gHaRO?=
 =?us-ascii?Q?80JoMY5YNL1uo+gpmpTxfpLg85D1xMhXfqFJRYc44Q4FKCCXVoapzxXoVXBW?=
 =?us-ascii?Q?z0soJxTbNm7zhw6mzd8QFE4ldN3cEAAB1GAMP5r3koxgVsXX5aAitYFIH/J+?=
 =?us-ascii?Q?TRtdfaKhWHk2SLR8KwaZl//ZJDY5TkQ+MW1me8XKIGD/y+wdkmABG84xjF9N?=
 =?us-ascii?Q?FdeGoeleao56652lXGGbAjXs8CSN48Rm34r7nT5M+T9+pPsyGX4zCIbrDo4Z?=
 =?us-ascii?Q?7NgORQ3Wbud8dzx2g7SXvgiJ8HyS7g/5p1f4dfw47w=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR11MB8603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(376011)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KLG2WbaG3F8sQy/8PNuy6JD9rCLpLWh+NjCXDOITm7DK+o9a9atnuxHIvqeK?=
 =?us-ascii?Q?i80wRhhx3nXJD5qCVZoPLWL4ttLnlOpUXNPdQrCyzg6KqmpCLD5j4yCy25Pe?=
 =?us-ascii?Q?466Kcd0fizA1OBY9ajs3Tj9c+zXo3GLXXgEhLPrsUza7mBxb6tbJvr6fJ5/a?=
 =?us-ascii?Q?qmAUKCYeboDEijoFjC5MzLu4zlBTC4Jq52bOJ7AJPxf+4886Wh133QvTl2bK?=
 =?us-ascii?Q?E5OoX1Bw2LBVOB1AU87W3ip6cwdAXFaOfzIcu8MnpjOLVVNJvVfkXF444mQ+?=
 =?us-ascii?Q?vx1GW7zFWzixrvJ3aczlC41faXoPCzncbtVTN4ajXXk6mlX0aDtcQkeXUgKI?=
 =?us-ascii?Q?eqmFFcZgZo2q71ImZnZ/u/8X2vdNhpLYyUwIdYnu9cLTDJab77+VHVd4hWng?=
 =?us-ascii?Q?kgkEq5dvo5v0Y6BEjJ1UTSUxvAc3PI2pELWlMK7FCT7VBnzYe0j8vr03bbwU?=
 =?us-ascii?Q?F638QSDbwH8qsXi1K+iHYaD0xEL8KrZFFSRyCK3DEZ5ymCmZ4QDR/dD0tGbC?=
 =?us-ascii?Q?KpiR8KhmsmqthfKgjuN+gU1VfHiGro2QhzxjBVbq6tnQsPaVWt0VQSXi+rKt?=
 =?us-ascii?Q?gEFejXJZiMsBPgjKqRc4RQn0maSS4wd3hA/cyBoKlaoLz7Nn4FEY1H10MQrU?=
 =?us-ascii?Q?agfBqcUZ0UCzZNFXMAxEEgutU/bYMmITt+QSNlWeqYpnTuKdh4QA9crvwaT3?=
 =?us-ascii?Q?eotJyX+2ZogwqhUNxaPDoiTbeiQT/bsPxEybEegZ9gXSOWRXwtKUXMv8/iOH?=
 =?us-ascii?Q?SqYDZyNwQ9kIeQoF6YUEXIylTnEEIFHJRNlznjs7h5DnnW5jpRYNFKeOvgXa?=
 =?us-ascii?Q?qlyz66UgF/ikGF8rcHombSk30u4Ih4MZofU2F8orMO8Pfvpc7C1jHFabV6nX?=
 =?us-ascii?Q?bqfeLfrA16U6wOkmCvwmakebaga5NxgbNYzsYP8KDRIDfsYsk2WYYoWqcpRf?=
 =?us-ascii?Q?fFvvZ+1F5y0HHIkHqS4KomO+Q6bSvcDdJnFLO2WYlx8HUge1WIMAI0kkt1dk?=
 =?us-ascii?Q?9E2szOKpnAsvmNN2NdfClOpcUv87M5bQjRiqz+ev+UY8rXMuv+RtUmJE4p2M?=
 =?us-ascii?Q?esbPGEysn6WK11yzpq2zfkfW//lj6Iw/Y9FQLVaHcTPA3Za3fi8mPfayDxrT?=
 =?us-ascii?Q?etb0HVT0LJn3ftfZluzk6p8ZtaYa35loRAb3PKwTKImiUwVdZMSIPg6rMV+F?=
 =?us-ascii?Q?OzUQxtanlKEo0oLCAg5zEOqusysITsv8wlv2o421aJj2nOWdfItj1ABQkaR9?=
 =?us-ascii?Q?8Q5WiN9YgoTwPkJVnG+dnsbgn1q0/Dn062qQSRQGoEObpOaQxYdboTKw/MPV?=
 =?us-ascii?Q?jLwa7YCtiHYxdkiYTS4rtdp///t7N0qU1x8yfTm9AdLWewJ+mehJS+anMu4l?=
 =?us-ascii?Q?kNV4iCj8smAD/YHE8y6tbhuwhBngaryWGXc7oavQlz+1DylQZSd9yCjBYQrm?=
 =?us-ascii?Q?h9xVQIRVHny20jnW81KP4HkpobqYgMgSNiUo6VaKeMpJTStIGxxPY0ntQARx?=
 =?us-ascii?Q?sIURFgaRqK6Tfg0FrBBQDpg0Yqa0efnZfk9QtTfYrqUSJGRGloEgOJ5Cmzu5?=
 =?us-ascii?Q?LqPAeDtgOC0cYly7d2szOfw4XweQoAm7VCKUcwq16X14dKtv1fDhKC0PH5bI?=
 =?us-ascii?Q?1w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dfbb8210-2f71-4ecc-7ddf-08dc94b5e8bc
X-MS-Exchange-CrossTenant-AuthSource: LV3PR11MB8603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 01:26:59.5162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C6PMOdNzelA5EH5SMutQErMYzqdwv8MC06pFMSHNkMmGM4gNYWUV6vuDpyKa3V+c4v0kVOWj9/5g40LFW8KfBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB8267
X-OriginatorOrg: intel.com



Hello,

kernel test robot noticed "hwsim.mesh_sae_failure.fail" on:

commit: 5210cbe9a47fc5c1f43ba16d481e6335f3e2f345 ("rtnetlink: print rtnl_mutex holder/waiter for debug purpose")
https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

[test failed on linux-next/master f76698bd9a8ca01d3581236082d786e9a6b72bb7]

in testcase: hwsim
version: hwsim-x86_64-07c9f183e-1_20240402
with following parameters:

	test: mesh_sae_failure



compiler: gcc-13
test machine: 16 threads 1 sockets Intel(R) Xeon(R) E-2278G CPU @ 3.40GHz (Coffee Lake) with 32G memory

(please refer to attached dmesg/kmsg for entire log/backtrace)




If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <oliver.sang@intel.com>
| Closes: https://lore.kernel.org/oe-lkp/202406250935.f0f05c9f-oliver.sang@intel.com

group: group-20, test: mesh_sae_failure
2024-06-22 21:28:13 export USER=root
2024-06-22 21:28:13 ./build.sh
Building TNC testing tools
Building wlantest
Building hs20-osu-client
Building hostapd
Building wpa_supplicant
2024-06-22 21:28:46 ./start.sh
2024-06-22 21:28:50 ./run-tests.py mesh_sae_failure
DEV: wlan0: 02:00:00:00:00:00
DEV: wlan1: 02:00:00:00:01:00
DEV: wlan2: 02:00:00:00:02:00
APDEV: wlan3
APDEV: wlan4
START mesh_sae_failure 1/1
Test: Mesh and local SAE failures
Pending failures at time of exception: 0:=mesh_rsn_auth_sae_sta
Test exception: Remote peer did not connect.
Traceback (most recent call last):
  File "/lkp/benchmarks/hwsim/tests/hwsim/./run-tests.py", line 591, in main
    t(dev, apdev)
  File "/lkp/benchmarks/hwsim/tests/hwsim/test_wpas_mesh.py", line 1942, in test_mesh_sae_failure
    check_mesh_connected2(dev)
  File "/lkp/benchmarks/hwsim/tests/hwsim/test_wpas_mesh.py", line 135, in check_mesh_connected2
    check_mesh_peer_connected(dev[0], timeout=timeout0)
  File "/lkp/benchmarks/hwsim/tests/hwsim/test_wpas_mesh.py", line 122, in check_mesh_peer_connected
    raise Exception("Test exception: Remote peer did not connect.")
Exception: Test exception: Remote peer did not connect.
FAIL mesh_sae_failure 26.680785 2024-06-22 21:29:32.211654
passed 0 test case(s)
skipped 0 test case(s)
failed tests: mesh_sae_failure
2024-06-22 21:29:32 ./stop.sh



The kernel config and materials to reproduce are available at:
https://download.01.org/0day-ci/archive/20240625/202406250935.f0f05c9f-oliver.sang@intel.com



-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki


