Return-Path: <netdev+bounces-131822-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D0498FA68
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 01:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA2F01C213CA
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 23:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F95E1D0170;
	Thu,  3 Oct 2024 23:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aJfMvs4i"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F3A1CF5CB;
	Thu,  3 Oct 2024 23:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727998023; cv=none; b=LYF9uNGtdVbj1Xu3+2q/d1psY37USaQq5D+I16JFBguxyjYtpkEh9UybJU6F5Q3BmsLCiEpFyZvfP1JMN1ECDSBixoapRjSOgxgZrba2qVm9v85b4SxaZGnucizDKBpvpSHKK9v0JV+nqRUr41iFh0jWmVqLb70JmuXFY4lZQ5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727998023; c=relaxed/simple;
	bh=yhI3MmARZz+BlGVKFN3RCDB7jHysNV6yUiatA4NcAcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pYyDH20M+YgHpBoOsArGGGF8GtUYodmogm+F95MO2PmQdev9FWbaidC+l9KnGzitCu4lBiWVyxEYj8n/shTht7l2s0SsAuVQbzvm7BB33RJE+laBqvVhWQkRGd/TvjlvfvzOtj4U+qgwx55dLC+TBGrJsNwc/zv5kVhPmxw0SlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aJfMvs4i; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727998021; x=1759534021;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yhI3MmARZz+BlGVKFN3RCDB7jHysNV6yUiatA4NcAcg=;
  b=aJfMvs4iv0q2dEtYYDf1nzhVwG+Ode4dhvu+BGFPLyJVHKFfgF5LgA19
   MxhUHk/n6Qisf7acD0AchOdZJZWeWGaIy2XCtbXvi7vrRdyOkOPv424vw
   XfaNd2ZdgctQGekZHY/qNlXgPHEsKTRSGt9kb6cNWTL8tgfot+cWQZl08
   udUssft3CYXhu1NIX8b+s0QtURBMgXGfyXhcW1NPSUPMePF+B2sb7lVgK
   DyO2TpWP2l9tXjG7SFEJTOIsuxD/nFPJD8hpnp17Hn14aSMW3pPw7QzRk
   PzxGdT9vHA1v82Js41nzldVIpYqK8unqS890yamBNWukro0y6S7f8OY9a
   g==;
X-CSE-ConnectionGUID: MBvsdWYSRWeVGinkfKGPCQ==
X-CSE-MsgGUID: roJCIltqSDa0Abt3ojS+AQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11214"; a="30093310"
X-IronPort-AV: E=Sophos;i="6.11,175,1725346800"; 
   d="scan'208";a="30093310"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 16:26:59 -0700
X-CSE-ConnectionGUID: xfmXsZR1SZuwSICxFHXxaA==
X-CSE-MsgGUID: RnjiBoM8RWa3W5Z9uYH07w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,175,1725346800"; 
   d="scan'208";a="79360359"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 03 Oct 2024 16:26:56 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1swVDh-000118-29;
	Thu, 03 Oct 2024 23:26:53 +0000
Date: Fri, 4 Oct 2024 07:26:33 +0800
From: kernel test robot <lkp@intel.com>
To: Rosen Penev <rosenp@gmail.com>, netdev@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, andrew@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linux-kernel@vger.kernel.org, olek2@wp.pl,
	shannon.nelson@amd.com
Subject: Re: [PATCHv2 net-next 08/10] net: lantiq_etop: use
 module_platform_driver_probe
Message-ID: <202410040710.C5horFtF-lkp@intel.com>
References: <20241001184607.193461-9-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001184607.193461-9-rosenp@gmail.com>

Hi Rosen,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Rosen-Penev/net-lantiq_etop-use-netif_receive_skb_list/20241002-025104
base:   net-next/main
patch link:    https://lore.kernel.org/r/20241001184607.193461-9-rosenp%40gmail.com
patch subject: [PATCHv2 net-next 08/10] net: lantiq_etop: use module_platform_driver_probe
config: mips-xway_defconfig (https://download.01.org/0day-ci/archive/20241004/202410040710.C5horFtF-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project fef3566a25ff0e34fb87339ba5e13eca17cec00f)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241004/202410040710.C5horFtF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410040710.C5horFtF-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from drivers/net/ethernet/lantiq_etop.c:14:
   In file included from include/linux/netdevice.h:38:
   In file included from include/net/net_namespace.h:43:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:8:
   In file included from include/linux/cacheflush.h:5:
   In file included from arch/mips/include/asm/cacheflush.h:13:
   In file included from include/linux/mm.h:2213:
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
>> drivers/net/ethernet/lantiq_etop.c:689:30: error: expected identifier or '('
     689 | module_platform_driver_probe(&ltq_mii_driver, ltq_etop_probe);
         |                              ^
>> drivers/net/ethernet/lantiq_etop.c:689:1: error: pasting formed '_&', an invalid preprocessing token
     689 | module_platform_driver_probe(&ltq_mii_driver, ltq_etop_probe);
         | ^
   include/linux/platform_device.h:324:3: note: expanded from macro 'module_platform_driver_probe'
     324 | } \
         |   ^
   include/linux/module.h:88:24: note: expanded from macro '\
   module_init'
      88 | #define module_init(x)  __initcall(x);
         |                         ^
   include/linux/init.h:316:24: note: expanded from macro '__initcall'
     316 | #define __initcall(fn) device_initcall(fn)
         |                        ^
   note: (skipping 3 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/init.h:214:2: note: expanded from macro '__initcall_id'
     214 |         __PASTE(_, fn))))))
         |         ^
   include/linux/compiler_types.h:84:22: note: expanded from macro '__PASTE'
      84 | #define __PASTE(a,b) ___PASTE(a,b)
         |                      ^
   include/linux/compiler_types.h:83:24: note: expanded from macro '___PASTE'
      83 | #define ___PASTE(a,b) a##b
         |                        ^
>> drivers/net/ethernet/lantiq_etop.c:689:30: error: expected ';' after top level declarator
     689 | module_platform_driver_probe(&ltq_mii_driver, ltq_etop_probe);
         |                              ^
>> drivers/net/ethernet/lantiq_etop.c:689:30: error: expected identifier or '('
>> drivers/net/ethernet/lantiq_etop.c:689:1: error: pasting formed '__exitcall_&', an invalid preprocessing token
     689 | module_platform_driver_probe(&ltq_mii_driver, ltq_etop_probe);
         | ^
   include/linux/platform_device.h:329:3: note: expanded from macro 'module_platform_driver_probe'
     329 | } \
         |   ^
   include/linux/module.h:100:24: note: expanded from macro '\
   module_exit'
     100 | #define module_exit(x)  __exitcall(x);
         |                         ^
   include/linux/init.h:319:31: note: expanded from macro '__exitcall'
     319 |         static exitcall_t __exitcall_##fn __exit_call = fn
         |                                      ^
>> drivers/net/ethernet/lantiq_etop.c:689:30: error: expected ';' after top level declarator
     689 | module_platform_driver_probe(&ltq_mii_driver, ltq_etop_probe);
         |                              ^
   1 warning and 6 errors generated.


vim +689 drivers/net/ethernet/lantiq_etop.c

   688	
 > 689	module_platform_driver_probe(&ltq_mii_driver, ltq_etop_probe);
   690	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

