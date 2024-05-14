Return-Path: <netdev+bounces-96292-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F0A58C4D59
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 09:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 252A728404D
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 07:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D23C915E81;
	Tue, 14 May 2024 07:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H+fk/F58"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13ED1DA2F
	for <netdev@vger.kernel.org>; Tue, 14 May 2024 07:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715673270; cv=none; b=fR5FOMYJl9la0Z43t+VMdHI49qntOrqz8GEQtAy+F4ovwnezwwDsT+FKFShB+2w9ok75b7IYx69mpmEW3vzdsoySwDpFOu4M0g/IgAp+EHjUdhl1aQ+FMmD2iPim8dRQtLdvjsn5BM+R6eys+h3ks6H94HklqfO6zqP/wFeubbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715673270; c=relaxed/simple;
	bh=nFV9P5PmqwN0LGDD4wRoEcVA8c0CeiBOf5pQ4B6h+wA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=uT6BdJl+z4Q8eVnaYeBXqBm/mKP/XzxK99TtG6WbSjgkTijkoBpo8cHpyH7LKGtYC9oILzBQju2GetMadd6XisUU/WahOqUx0fVMh75lhuEpGms3lKLJNNgG52Uaq74/1A8FejQIwfd9Ilqx1JtncHE0O2aS5alkOMDwloMkpo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H+fk/F58; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715673269; x=1747209269;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=nFV9P5PmqwN0LGDD4wRoEcVA8c0CeiBOf5pQ4B6h+wA=;
  b=H+fk/F58TwVFwvFyf3b2YMEyk+DHNxTSoikaTaDwekFYyEya4hIwtNjP
   NDEHjzOKLGGYSf1bVm2BMD5zfoIb/PgIWBMm8FVbDpRHatoaPb+q6iWdH
   EWf4/KPSLfx6Z1Ul906opaPUG+rQIRYvW2x92zc+3fJjw/4CeqEwNja73
   E+i2wAA1km7Hi1THpZSE5pnajb2oNL554dMi5hB6shIwIRV5DHCsIUwhP
   WMMDvJvMLthVKiOSMRRuySbEPPc4HbTezNhA+pqItgxJ+BY9+ghVgN5eT
   VHe9VL7BAG8BTNBHisrRFCWzZ5f10TU4ZHv6cEtM7idV1dm2WZjYVojLN
   Q==;
X-CSE-ConnectionGUID: I9eANqIiTkKvtd2q7iYVsA==
X-CSE-MsgGUID: kd631XT3Q36GVvzB677agg==
X-IronPort-AV: E=McAfee;i="6600,9927,11072"; a="11771738"
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="11771738"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2024 00:54:28 -0700
X-CSE-ConnectionGUID: KrxyDT2JQMeQKpLGyLi0UA==
X-CSE-MsgGUID: Gtn2NvRDTdSWzRtRa4kASQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="30615008"
Received: from lkp-server01.sh.intel.com (HELO f8b243fe6e68) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 14 May 2024 00:54:26 -0700
Received: from kbuild by f8b243fe6e68 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1s6mzQ-000BGH-1q;
	Tue, 14 May 2024 07:54:24 +0000
Date: Tue, 14 May 2024 15:53:43 +0800
From: kernel test robot <lkp@intel.com>
To: Richard Gobert <richardbgobert@gmail.com>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Willem de Bruijn <willemb@google.com>
Subject: [net-next:main 13/66] include/linux/compiler_types.h:460:45: error:
 call to '__compiletime_assert_654' declared with attribute error:
 BUILD_BUG_ON failed: !IS_ALIGNED(offsetof(struct napi_gro_cb, zeroed),
 sizeof(u32))
Message-ID: <202405141504.J6WdljEp-lkp@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git main
head:   5c1672705a1a2389f5ad78e0fea6f08ed32d6f18
commit: 4b0ebbca3e1679765c06d5c466ee7f3228d4b156 [13/66] net: gro: move L3 flush checks to tcp_gro_receive and udp_gro_receive_segment
config: m68k-mvme16x_defconfig (https://download.01.org/0day-ci/archive/20240514/202405141504.J6WdljEp-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240514/202405141504.J6WdljEp-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405141504.J6WdljEp-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from <command-line>:
   net/core/gro.c: In function 'dev_gro_receive':
>> include/linux/compiler_types.h:460:45: error: call to '__compiletime_assert_654' declared with attribute error: BUILD_BUG_ON failed: !IS_ALIGNED(offsetof(struct napi_gro_cb, zeroed), sizeof(u32))
     460 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                             ^
   include/linux/compiler_types.h:441:25: note: in definition of macro '__compiletime_assert'
     441 |                         prefix ## suffix();                             \
         |                         ^~~~~~
   include/linux/compiler_types.h:460:9: note: in expansion of macro '_compiletime_assert'
     460 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   net/core/gro.c:496:9: note: in expansion of macro 'BUILD_BUG_ON'
     496 |         BUILD_BUG_ON(!IS_ALIGNED(offsetof(struct napi_gro_cb, zeroed),
         |         ^~~~~~~~~~~~


vim +/__compiletime_assert_654 +460 include/linux/compiler_types.h

eb5c2d4b45e3d2 Will Deacon 2020-07-21  446  
eb5c2d4b45e3d2 Will Deacon 2020-07-21  447  #define _compiletime_assert(condition, msg, prefix, suffix) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21  448  	__compiletime_assert(condition, msg, prefix, suffix)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  449  
eb5c2d4b45e3d2 Will Deacon 2020-07-21  450  /**
eb5c2d4b45e3d2 Will Deacon 2020-07-21  451   * compiletime_assert - break build and emit msg if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  452   * @condition: a compile-time constant condition to check
eb5c2d4b45e3d2 Will Deacon 2020-07-21  453   * @msg:       a message to emit if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  454   *
eb5c2d4b45e3d2 Will Deacon 2020-07-21  455   * In tradition of POSIX assert, this macro will break the build if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  456   * supplied condition is *false*, emitting the supplied error message if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  457   * compiler has support to do so.
eb5c2d4b45e3d2 Will Deacon 2020-07-21  458   */
eb5c2d4b45e3d2 Will Deacon 2020-07-21  459  #define compiletime_assert(condition, msg) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21 @460  	_compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  461  

:::::: The code at line 460 was first introduced by commit
:::::: eb5c2d4b45e3d2d5d052ea6b8f1463976b1020d5 compiler.h: Move compiletime_assert() macros into compiler_types.h

:::::: TO: Will Deacon <will@kernel.org>
:::::: CC: Will Deacon <will@kernel.org>

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

