Return-Path: <netdev+bounces-80009-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3042287C748
	for <lists+netdev@lfdr.de>; Fri, 15 Mar 2024 02:40:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A68FA1F22AEE
	for <lists+netdev@lfdr.de>; Fri, 15 Mar 2024 01:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E951417E9;
	Fri, 15 Mar 2024 01:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PLDxjuyp"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5C279C1
	for <netdev@vger.kernel.org>; Fri, 15 Mar 2024 01:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710466799; cv=fail; b=gGtq+TESsGdB9X+7bVFCUJXZarf08zgNL3bgu5C9ENjk24XMj74Bu9VfZTLjwMqqtqgZQec9j5R4Wyslf4B44gRG29ru829d78FKebYastRu8k8flIbcVxDD/HBLjL7LP7qBkAgcyTIVCPvWjueM7QAst7dl6D6OBgmdjEeKlIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710466799; c=relaxed/simple;
	bh=aRFRohfZWjAn2srKDnqf4lHXy8NV7q0TjjN9+FjQL4g=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GhncAf31xIBWPxPH1rX8EDMkRhV6omkip+CEr9y9ho4qWd4gLpes59ErhYU4KlrZuiozN4z4VeyNLGxHd++tS+Csx/FTJJgvdqrvlVfcmY2dB7kktDhHzYTczBHrSg/yjPyJjdnkLg/k15PYJzNJQ234tFM4pWbiDjrlpdKoG7Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PLDxjuyp; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710466797; x=1742002797;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=aRFRohfZWjAn2srKDnqf4lHXy8NV7q0TjjN9+FjQL4g=;
  b=PLDxjuypAhTV719GGHt7/WNrYZoCW9Pp5BEeDHORqHDEEQy5WBvpC/BR
   UT7HOtS0EEsTM9m8snqpQWU96Kn24GZOlDZkKnVJLZsvj/CT5mnnY0pcE
   zv0Ai+b7AZK0uP3X+EUCENzxm4trim132coSMaorlgPO/GCeBmxMee3Bc
   ekjXbwaZDFP+6a8UK+ICIND5ofkw4w3WVBmO/SiEKgpCgxsrRsc13ilbo
   U7Is+zi33OdoDKyk9kSelSBzu79tte8W95DoSECRdNmoCHJUbJ7bs+8XH
   dA/YoRJ76o0F5K+SDkbuyZtO4vbovT/m+ycTqEH3AiJ+G7Zf7cQHjTZIA
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11013"; a="5449532"
X-IronPort-AV: E=Sophos;i="6.07,127,1708416000"; 
   d="scan'208";a="5449532"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2024 18:39:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,127,1708416000"; 
   d="scan'208";a="35627301"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Mar 2024 18:39:56 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Mar 2024 18:39:55 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 14 Mar 2024 18:39:55 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 14 Mar 2024 18:39:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K+4A12hiw4aXESDOwh9ZXaA8F2Sj3cZD5moGx6ZAptMAlWtpnixEDn2l+XJywLbNTdEZrrK0MA6quwQz/nz3dogT7kAUW5K9GdWGe0OBAA8oPsJmuRPRboSNhpXlHJ5xOzbTVHoehaCzBxfq8Ehn2oXA8b34eEu0lqI+BhQjiGXbmUKADHrx1vjXN8H/jRU75bCsVCYLTlE2a3060/WHCr4Cq6IcOJwLFc47CqrzxIuIPodWoUjYYQVzJBppH31ATExd+6cSCUpBWgXwOvyVsQFeQcxOFH8ABolqWvfuHCPJqWUMxahvC+vYYp2k7yTO3CZvo6Rlnfslsy9dzVqXVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kDudb7ufx3x4jTIug/ixDntxgUyrg4/1I+oQjut0KHg=;
 b=LeVFdAtsoimuWXWoQQe5JdxDYnshDHRQ4XwFjtmmfNN7GNUW72Kztj4o+sbsOzKhay4jAlraokKHIMa8ZsSyP3ncUSzDrFhrPDxttwOG2NmLE8JJrPhrN0GzwdBUWGMLAN1hsILQquBQmeaz4qScOjMu0uLSZKEmVRyXQG/yENA6PmY9D+caOgx5mnvA9HlqPrl11ulUDsybBPbB+BJ2QxIJwTUsqc+3m3wk5+iH6wRGzQfZcfz40xg4vdR3fSSddnwwfoxr83WarIcMFB1hCLtaV0kdyrGif9WVV2lM2yo7OA9p3z5EkvNI6lKxHbgQ0VzQSDEalmzYcLlHA29EVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15)
 by CY8PR11MB7897.namprd11.prod.outlook.com (2603:10b6:930:7d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.17; Fri, 15 Mar
 2024 01:39:48 +0000
Received: from CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::7118:c3d4:7001:cf9d]) by CY5PR11MB6392.namprd11.prod.outlook.com
 ([fe80::7118:c3d4:7001:cf9d%6]) with mapi id 15.20.7386.017; Fri, 15 Mar 2024
 01:39:48 +0000
Date: Fri, 15 Mar 2024 09:33:01 +0800
From: Yujie Liu <yujie.liu@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: kernel test robot <lkp@intel.com>, <jcmvbkbc@gcc.gnu.org>,
	<oe-kbuild-all@lists.linux.dev>, <netdev@vger.kernel.org>, Herve Codina
	<herve.codina@bootlin.com>
Subject: Re: [net-next:main 4/19] WARNING: modpost: vmlinux: section mismatch
 in reference: bitmap_copy_clear_tail+0x58 (section: .text.unlikely) ->
 __setup_str_initcall_blacklist (section: .init.rodata)
Message-ID: <ZfOlTaxFIeUvCj91@yujie-X299>
References: <202403121032.WDY8ftKq-lkp@intel.com>
 <ZfH85ScHmojydKlw@smile.fi.intel.com>
 <ZfLGLmb3QAsIGlbB@yujie-X299>
 <ZfL4amLH5W9Zc_MS@smile.fi.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZfL4amLH5W9Zc_MS@smile.fi.intel.com>
X-ClientProxiedBy: SG2PR02CA0091.apcprd02.prod.outlook.com
 (2603:1096:4:90::31) To CY5PR11MB6392.namprd11.prod.outlook.com
 (2603:10b6:930:37::15)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6392:EE_|CY8PR11MB7897:EE_
X-MS-Office365-Filtering-Correlation-Id: 8eec05ed-fb14-437b-9f83-08dc4490ccc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ibvzJsXjY1UwxNc/4UFlBFKLtAK0234+YKj8LlT+TLFvFQ3gRCID8/jTmKkl9Z0IiVredgUhnm+BFr7XPc6doo0ooXpZ1kVGaRrBqAto7J9A/osTjknbQwDMCvmhstygqApS6QZK2p/tV3s4IosIVAjpkr++RmhCfWEGrEEKcTSHakyfvjEHGPd6gVR6GwBGVH08NtEXXJ4hdgp5gGkFI9M8qYaTTbudw7QsiyddHw3byZKTgG/NVgk7LxsgLKilwwc4T/RgZa6Kf2GL2lD50Lyk27NwVcE/Ncsrhxar0l+hbh+8Xq+hfPeKYfiNI9HtuisLxZwtdLv/a4va2rvRPAeQY+HY+J8CeeS6IXuf7S9LGc7TNIuiDiZvunJPsNv/J8VDp4pKz/5MV3YmpTVtEY3RAFjxYYzDfCVFH+yJCvvpX4m+Czywlkazg47ryO54fhRS6Xbfw+iSlUBBiS5rNg7FucvhPYL+KiLshcSeJPJuk5cFYSpN0z8t/CNQYZiwS+0badH2vvdDFY6l9TJSrSDEOK5suinKjuZev/ELaLBiLb7XNUQr7E/6cKov4ND0cLelz3nzj58FVc16VSiU+z5TYPX0TwIpooUJ/ObliVv3rrxJ7M78lpkJC9GGy/aW
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yIjpVsWEXUIfMTwRVlqrc6KM0Xhydt3g/ntiVfLPIbXXreBVfLm7YRnlID4w?=
 =?us-ascii?Q?0pBCBC1nNCwRbN71GgmR03BmVSltJbQuiYT1v0h51DkfyYesLuaBKClQMhG9?=
 =?us-ascii?Q?tYQm869upbv7Ncu7CUdLejfLNdLr6NtlCz4dLVf6+GBoJ8FVV6FsE4yE3feR?=
 =?us-ascii?Q?PiV6Zw7YlOYuC9aOJhMqtf/Er0GaxxZC5vRjDmJ/PCDzE3JJ2DWV0dJsR2Gr?=
 =?us-ascii?Q?fdD/yEljyo3UYGpQh5qe7Yy1S121bZHob0PXyT4HtiO8Ty5KiQSKmCW6eOyH?=
 =?us-ascii?Q?n/WWu4fqLE+FQXPAQQXtJLl3Pd7XPBXqViurnjQyNDnAz42MwR3OTuvQA6ur?=
 =?us-ascii?Q?uOTRByuGLRMm8nESnPRH9Tu6gf2uEMGu7NBP5to0uWTvby2JcedemBgktwtW?=
 =?us-ascii?Q?KcYGxhSP0ubeanQRc4POfhzAm6TanlCJ/5jCo14XXb8RykJmtRLy0zj1tglN?=
 =?us-ascii?Q?nXILPBBhOQIaUp3/63ErVmvzAgt2OteSv51QF1dmwKc+qZVatTFBQoxJ5tb0?=
 =?us-ascii?Q?QUkObTB7hpKlXo8AB3b98WB7BFsqwOGEJzKTiFfTr3tb8+87kXHzqI90YzyS?=
 =?us-ascii?Q?o1WCvtKBboqTTP/6x3t7JMAcOzCMsycsahuUFAdXDmaxasJokBNeZBRzRZw7?=
 =?us-ascii?Q?NIPPTSgv/kHY+SroJXKjgpr1e51rXMeONs8S2uMEsOtuY7kcwkAB5Nf5kq4C?=
 =?us-ascii?Q?mG53cfvkBMG/Ubz8G2Av8yNT+YesZnCcf5t46iYSeFl+L64vsQgn6ORTx500?=
 =?us-ascii?Q?daKNUEeYzqDUzFOUTDU6UfkgX9k7SnDMP3pbPq8U0LbXgjCVbV4b29MYbhhU?=
 =?us-ascii?Q?Kvgc8whSvUFYlUT1QViiJYZM42ZrbvFVlGLTp/EHCSf/7IOq0RjKd6AKBkMV?=
 =?us-ascii?Q?pU5b9JdUmcXQG11H+hhvbPOEc4R2bC+gjlgvYz9vIcQkyc58SQ1kOGFs2Rlq?=
 =?us-ascii?Q?GEkncoT6snILmjxQQ7BcFgIxWzLbAOJQb+UCHd/YNyHV0NvpZHblYjntOZlX?=
 =?us-ascii?Q?4jOAa0Zb9POfoXtcJ6frUGCF5stYjNvb+rHGkE2kPO30UC3ogGPQOn+dOVDW?=
 =?us-ascii?Q?o7fGwHn7Qm8DF40xJUTW8ZOJhe3adlX1f+EjNjolUhCFjcZdw4DneqqK6Us+?=
 =?us-ascii?Q?Y8j+b4Vn+rTu4iG0ozSCidclT5RboshHcwN1eL++zjyVvdzPrkbFeH6PWVKS?=
 =?us-ascii?Q?MXphlU0gt5mmL2JZMLbtyZiLpi49u4FqI/3R0jZHuhmHN8gvsCb+WRutScp3?=
 =?us-ascii?Q?bDfOEeX22S17/8fmCuOizWSdKmnt882I+yUeSEZIJKI/Juf4h23Ki8C6WNS8?=
 =?us-ascii?Q?fl1KfICopXSDWk8WU910+x30E5p7GgHiUY0pnMcb0QD5niukXY17KAwFlQFl?=
 =?us-ascii?Q?7tGShjboE+JFfOdm9Y9cjcod/PdJbuCo6mFU1bVOF86vZ1bubDqNfbRHX4gJ?=
 =?us-ascii?Q?Wwqq2gtj95EBBIXF+IMLee7zXX+bTXVjUj1EujbAJBKYH4fK0m8JjBt6PiIJ?=
 =?us-ascii?Q?bvZShEspHIaQ2kvD9McGU/xqi8fLqT4Ys4duHxm8OqHoaO43Tkkq4qJGd8jW?=
 =?us-ascii?Q?j26muHHy5/G8h6vzIupVU9PX6ReSP0iGkKCu4tQy?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eec05ed-fb14-437b-9f83-08dc4490ccc5
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 01:39:48.2451
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zcJvnVaACmAQ2Z8ehSigg00H67L3PCfRNXMgBHclDDKvzkwRo7mxYGZDDCqbHRsbyjeWqD5YvT6sO7fX6v50bA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7897
X-OriginatorOrg: intel.com

On Thu, Mar 14, 2024 at 03:15:22PM +0200, Andy Shevchenko wrote:
> On Thu, Mar 14, 2024 at 05:41:02PM +0800, Yujie Liu wrote:
> > Hi Andy,
> > 
> > On Wed, Mar 13, 2024 at 09:22:13PM +0200, Andy Shevchenko wrote:
> > > On Tue, Mar 12, 2024 at 10:29:16AM +0800, kernel test robot wrote:
> > > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git main
> > > > head:   f095fefacdd35b4ea97dc6d88d054f2749a73d07
> > > > commit: de5f84338970815b9fdd3497a975fb572d11e0b5 [4/19] lib/bitmap: Introduce bitmap_scatter() and bitmap_gather() helpers
> > > > config: xtensa-randconfig-001-20240311 (https://download.01.org/0day-ci/archive/20240312/202403121032.WDY8ftKq-lkp@intel.com/config)
> > > > compiler: xtensa-linux-gcc (GCC) 13.2.0
> > > > reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240312/202403121032.WDY8ftKq-lkp@intel.com/reproduce)
> > > > 
> > > > If you fix the issue in a separate patch/commit (i.e. not just a new version of
> > > > the same patch/commit), kindly add following tags
> > > > | Reported-by: kernel test robot <lkp@intel.com>
> > > > | Closes: https://lore.kernel.org/oe-kbuild-all/202403121032.WDY8ftKq-lkp@intel.com/
> > > > 
> > > > All warnings (new ones prefixed by >>, old ones prefixed by <<):
> > > > 
> > > > WARNING: modpost: missing MODULE_DESCRIPTION() in vmlinux.o
> > > > WARNING: modpost: vmlinux: section mismatch in reference: put_page+0x58 (section: .text.unlikely) -> initcall_level_names (section: .init.data)
> > > > >> WARNING: modpost: vmlinux: section mismatch in reference: bitmap_copy_clear_tail+0x58 (section: .text.unlikely) -> __setup_str_initcall_blacklist (section: .init.rodata)
> > > 
> > > Reminds me of https://gcc.gnu.org/bugzilla/show_bug.cgi?id=92938
> > 
> > Thanks for the information. We will configure the bot to ignore this
> > pattern thus to avoid false reports.
> 
> I haven't told they are false.
> I Cc'ed Max who can shed a light on this.

Oh, sorry for the misunderstanding. We will let the bot keep capturing
this issue and stay tuned for comments from Max and GCC folks.

Best Regards,
Yujie

