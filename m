Return-Path: <netdev+bounces-79828-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F412F87BAA6
	for <lists+netdev@lfdr.de>; Thu, 14 Mar 2024 10:47:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5EFA282A35
	for <lists+netdev@lfdr.de>; Thu, 14 Mar 2024 09:47:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E69A6CDD7;
	Thu, 14 Mar 2024 09:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="emdThMpl"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09726CDD3
	for <netdev@vger.kernel.org>; Thu, 14 Mar 2024 09:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710409675; cv=fail; b=Hqf5IaUyvJRoq93Uo4iTfM4Al5hqiyDv3CC9fZsbAbM7ufiYMlUfmKcBSK8rpE7HNYLyzcpX0sUB5SyUpi4Yi0ZmjQjtk3SmnX6D8HytzDHP1WiYCuCrepg0jw3+SkYpMFFazqqB4/9/h1xBhy6Br+kvKorTbOg/fAMlxVd799k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710409675; c=relaxed/simple;
	bh=dkAuOXLEihjYJIiglYimeraCVa4Q7M4TKgyoMj9hJck=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mZcwrxxjF/fWEplgwFipbG/qpKbmlyP2b8P5o9kgkt/43aLvURLURvcJRCC0UmgNHhNf11VvPj/LeCSDqzGb8QPFnLS0sxynBwBgB52wt3PKbsq7x5VlrjOWirQR0NwPfDLcPZ5FTYJrDgiRVzKtF/pWTUAOXWJIPywcCYex0f0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=emdThMpl; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710409673; x=1741945673;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=dkAuOXLEihjYJIiglYimeraCVa4Q7M4TKgyoMj9hJck=;
  b=emdThMplwLSehTIgPv7V0PUqP4n8ExyGwtz8joz4nWz8QtYTugFVna7M
   WmroMDrGZumHX2QwY+7Fz5i1QLpZX0bqgWmHHxR2poYOvWRWcf4gi/844
   6Fr4UfPzOEMisXfl/aBx/DXYpK+TKW6OJQYUq4nfMp0nlKFtpHl79cyyQ
   zdbP6hQ40Yn9WJfY2R/JI3i7spUD4mzknvCRPBIXmpuxCRTdQ/5sHgI0O
   mfWPYpk9mwwqgzDD3wUFPXPYsfGiRvqvlDrR7uaDdh0glPDWBBMK1F6Qe
   Rxo7uuAwiUGuu2rC/ny8rEUrjlSedBXZIJy98U4xa1GlkbFPaDJpLqlsd
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11012"; a="5069087"
X-IronPort-AV: E=Sophos;i="6.07,125,1708416000"; 
   d="scan'208";a="5069087"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 02:47:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,125,1708416000"; 
   d="scan'208";a="12626848"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Mar 2024 02:47:52 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Mar 2024 02:47:51 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Mar 2024 02:47:50 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 14 Mar 2024 02:47:50 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 14 Mar 2024 02:47:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RnsIKjnFewnZyIq0PhphaoYISgVtFvgDy9ispRkto7gUJWiFO34F/5+x85+v1VOAI6r29ZV50zSBI379bOqC33SoT5L1cXHAsCeZ9ldN+PINaw2193Cb/UrJ7Ni3mVbYedYVr6rkTosh+QWZ7UGYlsHxe5iVl5sIwLzzqs/1Ryv1gkzPib8S9z69/craqTeVxYlkw36yVn91TBx+GYobJcBwGv7ADZ7JKc9vZhGEgz5NmItzszQ5ndt8nTYIi+sWeJgDdh+Ouso8NHc6rvG2Ea3KFQ1SrT4JNG1PP9sD1carot54G7tMCKjPao2BPgwQTW2y8PDu2kZWIKJZTHpBQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RF2S56FcOSSCJPoZHxhevHWQeF4+JE51rQLPCwcetwk=;
 b=Um/9ShxktpjmgEiWU7+eoBNRRJ2CA4isTPdjB6oNxxvtaEHfvUOT37E6KAQSqjyuml3y3abRIDC+bkRtPLOrVuJ2hjbB+JbWAQ5nDhJ4mU3P6b/01hhUeD8vP939yRlNp9xRSqcH3iDgtvWwKMWERAKKQrSM7Tvs6j2j41BGb4kfOxt5Dvr89RnUCGogtGhl7KPpZTZ65rXNUD39YfSuAiJaXDoYmX29j/olkmEr1BdcRKHo5H1B8SZ2bZSGmwuji5UsLjpKCONAG2Ju3LXX3IVZ5P6zLzqMUjzfFZm8JRMn4IBxwucW+eKvBH4uGClxnExRgJgcMgWZbiVuL+th1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by SN7PR11MB8066.namprd11.prod.outlook.com (2603:10b6:806:2df::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.20; Thu, 14 Mar
 2024 09:47:48 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::7118:c3d4:7001:cf9d]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::7118:c3d4:7001:cf9d%6]) with mapi id 15.20.7386.017; Thu, 14 Mar 2024
 09:47:48 +0000
Date: Thu, 14 Mar 2024 17:41:02 +0800
From: Yujie Liu <yujie.liu@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: kernel test robot <lkp@intel.com>, <jcmvbkbc@gcc.gnu.org>,
	<oe-kbuild-all@lists.linux.dev>, <netdev@vger.kernel.org>, Herve Codina
	<herve.codina@bootlin.com>
Subject: Re: [net-next:main 4/19] WARNING: modpost: vmlinux: section mismatch
 in reference: bitmap_copy_clear_tail+0x58 (section: .text.unlikely) ->
 __setup_str_initcall_blacklist (section: .init.rodata)
Message-ID: <ZfLGLmb3QAsIGlbB@yujie-X299>
References: <202403121032.WDY8ftKq-lkp@intel.com>
 <ZfH85ScHmojydKlw@smile.fi.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZfH85ScHmojydKlw@smile.fi.intel.com>
X-ClientProxiedBy: SI2P153CA0032.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::23) To CY5PR11MB6392.namprd11.prod.outlook.com
 (2603:10b6:930:37::15)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|SN7PR11MB8066:EE_
X-MS-Office365-Filtering-Correlation-Id: 295a5418-f47e-4f7b-9233-08dc440bcee8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +RaYDjHqmKkd1ihOGx/e9fglCv3hwbY/wfcHlruyOOckXtxqzjbzzsqp4JxQ1tv1dGMEPdMFYVPWU1/tFX1NpWUoi+VCIcr/xZLgNtySGZ62Ig0Ici6E4101HKSM5Pxppc3LIiSGWLiTgeAV6XeqbicCGasIRy8NNgnflHfb1SZMXy8uaG5qyFV3lFof8OGIjSH8udYwiYdvDwm/EbvCqgisX7ZjAI3+RSuTIQEJcwEstiUukFUfC5lcZmNL2lFH/P6sK1FN+rnXqEn7qaEjEu814CZ0iu6cKsSj7enL3bbRPPTs6e48zu7Z2pLcchh/mIJSnVcODvmpuy+/4rtyHHPaY6Ti1XyKUEKt1/KcMOONwJGEGwIpkqh6x4YDdzyDhAatdnftYFNeve65e9IuEB07dYlcDarhERP2UnODfPQbvj00dbOwIhRoAnZm9tR9NyyquMqV92pWa57WppJfiPZ2O9/LRZRIGx45Q+mBK42RN/KAOaks++CUOBy4/eRYGilzzFlq8gkJ5un7hbJP/qDuhu0znMGNNguWD3H3Np0w7YW0GJQ6+h5L5jc5LCoJ5dM2+RZymffCKt+8L83mSEbkwvGs3tYT7/TkZYPYFXLFZS4xdWReds0AE7gFxn39
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0+oZorGvbPK2VWzL1c7mQXEwNjw/8m1o+8eoTirxiw+K4DQZtQF/P0clUYu5?=
 =?us-ascii?Q?uVkSp3UbE5vbwTHAJvxWvcFcFnkv25otnXenOOiOA+QmNSv+uZ++DeY63ts3?=
 =?us-ascii?Q?B0eHQ7ItUu2rayqd/8HTRhWykY2VJv03wLpPDuWnWUKXEmSJd4O/VZHNuEoq?=
 =?us-ascii?Q?NfF7SJ1w+nkQ7bZEy0gdnbRsVHmamIwj0pQsEJHqULGjT3whFOsRGAeTHFB6?=
 =?us-ascii?Q?UvqaUD5eGy8KryVchyxDVp6yImg34aLJ+RwoEy4CKfIwzqMYAX4ysIbWarOg?=
 =?us-ascii?Q?S2O7xLYfZnVkCU7p2yrjBfrjeV/zgE1vuYU70Rg+EX+N/gqTrRVxzAw0RlYi?=
 =?us-ascii?Q?qTEc5/aZCjMIdQbty7h/e+nfZZHEwsRswUx7Ep/fuREdAPc0Pyds7qTPF6iC?=
 =?us-ascii?Q?vTTJ4GhKEhNXk1rDTvvBfFfvDNqvJ6ZoyrsXopfmLz4J5InBXrZgK6zGr05u?=
 =?us-ascii?Q?Hft+Yc3yxolZs0WgxGwl3z4+C+aXEJsOMz/Xx+HrWJYchAoqAKWDtgyZUii2?=
 =?us-ascii?Q?Kw5cGfiPz+U6f0m733t4TJBtTuw+q3qllwHNZTCFHiYNqUiTo7xlkLP92bHa?=
 =?us-ascii?Q?Wb1CBE3i+GOHLQy8i3v/qQvKySzICZJdIF/uRfwE7sDnDkc1Kpr7/PdgESqU?=
 =?us-ascii?Q?KicD0EO6ipZI2207cAEP7WbOAm1On4+pA920ADbyFOmjJpJljQLhtdVI2wmU?=
 =?us-ascii?Q?IMlaiwyg1iWoaQtZMQaSOIWgVgSj+I19F0yG1thLV/5e4KqBy1/TRuOxFIGT?=
 =?us-ascii?Q?TU52Hopeb6yL06jjsJ/fWylKb0/KfE5/6vZ9GvvOxYpWGfe2ktA+2Z8+t8tS?=
 =?us-ascii?Q?TdQXY+b9DA6oaUIb+7Q3JdjkbixFTfMDd+ij5AXvnsfkrwZIFNDzcKCDh4hS?=
 =?us-ascii?Q?/AI6S1yDcuWYevujhyV3Upy7tF5r2YTFg19nKOgoRmt14/lp+YZhvpjcHDvu?=
 =?us-ascii?Q?SK4Y87cc7WZyq5uGD/E4O+u2figcwyFmQFVn2Qmlb5vAqZqjYyQvETk7Fh0u?=
 =?us-ascii?Q?IKz+iXIWZ6RWprvSy33YAyTaQ9GUN0jmGCH/MPHujVC8bL3os9Duo+CXrixg?=
 =?us-ascii?Q?lkkTScY3zTPnA82k6VcTzWkQn/1m6Z4I8wtoGdu1BiCzVzsIikIUmmjiTcjX?=
 =?us-ascii?Q?yqiuOJtfFehkEimDI0LWg/+x0G6yTmHr2CfYkCyKOVvBcF3wNhbMkiX6SJSu?=
 =?us-ascii?Q?8csnAmPpo9uLG4cKGyFxqRcipPxSK7JIgqjHv2azdtcEy+N4wMn0qshyJE4Z?=
 =?us-ascii?Q?5JSJf9JIDHglgKrp50b/m6tdrn0PGCl2rQ1f0+X13OG1V/qLuN5ZNY0V/Aog?=
 =?us-ascii?Q?KOZ9EGzWTjlzfQwj10fnf+P2fRu8HQTLd4sle7+ULfbqGF1HY7rdbIPPoXd7?=
 =?us-ascii?Q?dYK+K1mYf2wyKlPvfJ0/3LamHHU6Jhg5AjjqFmyPPEEOhc+CrT/dJwbCZiqf?=
 =?us-ascii?Q?rLzwzp28L21RtcdBNJ1g7ZwfkwlGOk+k+r/vACLLVLguPF2WgNjILSrIHGHC?=
 =?us-ascii?Q?R8a3Dd0qdOgVXpokjA4Rt6eco4AJwxNUn/8+D2TPpVzD8CUVhKatg9+Xj3ss?=
 =?us-ascii?Q?qR+hsiGjSLwQ3YiLvKUAhjlsyUXJ+pexpDK7/p2X?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 295a5418-f47e-4f7b-9233-08dc440bcee8
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2024 09:47:48.7411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1O/20AbPPSByzVUqq9y0IChR0WaYRa7s+BGRCr+AJKoxC8L8bPOttoZRr//gmnZ/T9NTlnNKPWbL4RzwHsVrsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8066
X-OriginatorOrg: intel.com

Hi Andy,

On Wed, Mar 13, 2024 at 09:22:13PM +0200, Andy Shevchenko wrote:
> On Tue, Mar 12, 2024 at 10:29:16AM +0800, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git main
> > head:   f095fefacdd35b4ea97dc6d88d054f2749a73d07
> > commit: de5f84338970815b9fdd3497a975fb572d11e0b5 [4/19] lib/bitmap: Introduce bitmap_scatter() and bitmap_gather() helpers
> > config: xtensa-randconfig-001-20240311 (https://download.01.org/0day-ci/archive/20240312/202403121032.WDY8ftKq-lkp@intel.com/config)
> > compiler: xtensa-linux-gcc (GCC) 13.2.0
> > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240312/202403121032.WDY8ftKq-lkp@intel.com/reproduce)
> > 
> > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > the same patch/commit), kindly add following tags
> > | Reported-by: kernel test robot <lkp@intel.com>
> > | Closes: https://lore.kernel.org/oe-kbuild-all/202403121032.WDY8ftKq-lkp@intel.com/
> > 
> > All warnings (new ones prefixed by >>, old ones prefixed by <<):
> > 
> > WARNING: modpost: missing MODULE_DESCRIPTION() in vmlinux.o
> > WARNING: modpost: vmlinux: section mismatch in reference: put_page+0x58 (section: .text.unlikely) -> initcall_level_names (section: .init.data)
> > >> WARNING: modpost: vmlinux: section mismatch in reference: bitmap_copy_clear_tail+0x58 (section: .text.unlikely) -> __setup_str_initcall_blacklist (section: .init.rodata)
> 
> Reminds me of https://gcc.gnu.org/bugzilla/show_bug.cgi?id=92938

Thanks for the information. We will configure the bot to ignore this
pattern thus to avoid false reports.

Best Regards,
Yujie

