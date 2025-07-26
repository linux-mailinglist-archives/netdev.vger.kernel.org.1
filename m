Return-Path: <netdev+bounces-210344-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58727B12D00
	for <lists+netdev@lfdr.de>; Sun, 27 Jul 2025 00:41:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A616C7A9124
	for <lists+netdev@lfdr.de>; Sat, 26 Jul 2025 22:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0EAE21C9E4;
	Sat, 26 Jul 2025 22:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a1OZuzfE"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B4F21ABA4
	for <netdev@vger.kernel.org>; Sat, 26 Jul 2025 22:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753569695; cv=none; b=Gn4PUnL3L7BLUdGWQhFiMPow3xzQfS5jLZqNyYcYzQnfGEAXI+qFnpewN523PznlqO/UhKH9fjKx0V7fFgpdxKrRozvsWp0kuxa43z3kWucV5Ani9GUzkFd58kxJqgosFn4ArHBpIdfXKNgR1OyMoccwaqHFOp3bf74lNheZJ/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753569695; c=relaxed/simple;
	bh=q2XdIWOte2Yuu7wVkJSMzXfZJX2opq6lkisZsgBpRkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M9fnsQEWpKlViOV0d/Vv5x+IqawAIw1LaithFafp2yp3rdi4VWJyrhBeqcyk2kfcyVNBexzERsWg9BSoQ3nbqD6AJbnWUW/q9GrQfZunHRTm03lAjNvr2SOp1OhVsuf0WhIZxdPnxZgt7ELvN+ysAGEmmzXTe8Y9izusBS5FTqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a1OZuzfE; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753569693; x=1785105693;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=q2XdIWOte2Yuu7wVkJSMzXfZJX2opq6lkisZsgBpRkU=;
  b=a1OZuzfE2078PBzZo6kBJ8NIruVEJGhst3AQ03dEzXGRF1tEtraIqeuP
   bYAbLb09FzTablTq1wjFTbjfjp4T3GQT65BYM4Flqzc/zvlJzZf9R4iJs
   ZNC4vcQGCXO0vixtL2IG/IF1Jjoo7hgRYWjzGIdKrEQHSGzDde13A6W5R
   0N9Q8GKSyjIQglT7yOnsaiBf6erlmk+K2Lj7ijEIqe0EZWpRsXX3jscqh
   ZFPGCcrPQD7cmm2332kWafxBYCsq4ttHsSeJZixPOhCM1YOi1ymCvZK5x
   6jS4mD0xxJvGRafOnXpHs/n5Iq+50OZ+NqTTXGA6T/SV9RMaszeGJezQE
   Q==;
X-CSE-ConnectionGUID: /xGaB/y3THyskRO1EE4iwQ==
X-CSE-MsgGUID: WIcBOuMkSKGeDJbdFeGSDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11504"; a="66565736"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="66565736"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2025 15:41:33 -0700
X-CSE-ConnectionGUID: PJJco16NR4Wk8fSAXDZdTA==
X-CSE-MsgGUID: 3vMdi+PgQ6CwsVJKCLVbXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; 
   d="scan'208";a="162087174"
Received: from lkp-server01.sh.intel.com (HELO 9ee84586c615) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 26 Jul 2025 15:41:31 -0700
Received: from kbuild by 9ee84586c615 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1ufna5-000MK3-2U;
	Sat, 26 Jul 2025 22:41:29 +0000
Date: Sun, 27 Jul 2025 06:41:06 +0800
From: kernel test robot <lkp@intel.com>
To: John Ousterhout <ouster@cs.stanford.edu>, netdev@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev, pabeni@redhat.com,
	edumazet@google.com, horms@kernel.org, kuba@kernel.org,
	John Ousterhout <ouster@cs.stanford.edu>
Subject: Re: [PATCH net-next v12 15/15] net: homa: create Makefile and Kconfig
Message-ID: <202507270639.OBQsePz1-lkp@intel.com>
References: <20250724184050.3130-16-ouster@cs.stanford.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250724184050.3130-16-ouster@cs.stanford.edu>

Hi John,

kernel test robot noticed the following build errors:

[auto build test ERROR on net/main]
[also build test ERROR on linus/master v6.16-rc7 next-20250725]
[cannot apply to net-next/main horms-ipvs/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/John-Ousterhout/net-homa-define-user-visible-API-for-Homa/20250725-024511
base:   net/main
patch link:    https://lore.kernel.org/r/20250724184050.3130-16-ouster%40cs.stanford.edu
patch subject: [PATCH net-next v12 15/15] net: homa: create Makefile and Kconfig
config: um-allmodconfig (https://download.01.org/0day-ci/archive/20250727/202507270639.OBQsePz1-lkp@intel.com/config)
compiler: clang version 19.1.7 (https://github.com/llvm/llvm-project cd708029e0b2869e80abe31ddb175f7c35361f90)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250727/202507270639.OBQsePz1-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202507270639.OBQsePz1-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from net/homa/homa_incoming.c:5:
   In file included from net/homa/homa_impl.h:13:
   In file included from include/linux/icmp.h:16:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/um/include/asm/hardirq.h:5:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:12:
   In file included from arch/um/include/asm/io.h:24:
   include/asm-generic/io.h:1175:55: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
    1175 |         return (port > MMIO_UPPER_LIMIT) ? NULL : PCI_IOBASE + port;
         |                                                   ~~~~~~~~~~ ^
   In file included from net/homa/homa_incoming.c:5:
>> net/homa/homa_impl.h:557:9: error: use of undeclared identifier 'tsc_khz'
     557 |         return tsc_khz;
         |                ^
   1 warning and 1 error generated.


vim +/tsc_khz +557 net/homa/homa_impl.h

4d2ad8007f1c33 John Ousterhout 2025-07-24  548  
4d2ad8007f1c33 John Ousterhout 2025-07-24  549  /**
4d2ad8007f1c33 John Ousterhout 2025-07-24  550   * homa_clock_khz() - Return the frequency of the values returned by
4d2ad8007f1c33 John Ousterhout 2025-07-24  551   * homa_clock, in units of KHz.
4d2ad8007f1c33 John Ousterhout 2025-07-24  552   * Return: see above.
4d2ad8007f1c33 John Ousterhout 2025-07-24  553   */
4d2ad8007f1c33 John Ousterhout 2025-07-24  554  static inline u64 homa_clock_khz(void)
4d2ad8007f1c33 John Ousterhout 2025-07-24  555  {
4d2ad8007f1c33 John Ousterhout 2025-07-24  556  #ifdef CONFIG_X86_TSC
4d2ad8007f1c33 John Ousterhout 2025-07-24 @557  	return tsc_khz;
4d2ad8007f1c33 John Ousterhout 2025-07-24  558  #else
4d2ad8007f1c33 John Ousterhout 2025-07-24  559  	return 1000000;
4d2ad8007f1c33 John Ousterhout 2025-07-24  560  #endif /* CONFIG_X86_TSC */
4d2ad8007f1c33 John Ousterhout 2025-07-24  561  }
4d2ad8007f1c33 John Ousterhout 2025-07-24  562  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

