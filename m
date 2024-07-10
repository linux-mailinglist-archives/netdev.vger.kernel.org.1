Return-Path: <netdev+bounces-110611-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CDE992D733
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 19:10:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 134642807BC
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 17:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E37D194C79;
	Wed, 10 Jul 2024 17:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XjB7ON+m"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E63918FC93
	for <netdev@vger.kernel.org>; Wed, 10 Jul 2024 17:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720631442; cv=none; b=ZdA15P+yM7D/cCNEFzpgZwQlM/uHAy+nP13vWcf971VgGjwbEXfuPC19aluqDuXQJMw9TcHucOmS73oMW4VzWQNLaGtKV/OfI5RtjHvryYWC0W1mXpYTnfJ1+dGeY70GA0eMPVajV6On1n9uP10Gd1knMKV4KLSn0ugNhlgPQuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720631442; c=relaxed/simple;
	bh=p4Gl9a++9hldLPmE/boFd47IvYZskyOh8zHYSOXBl8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gKMRVV1JrSfkmKHf+vN3C1UtDVIWL7FeX79HMJFCkdlncOYzMwuDeZ18cPtndx7QfZ3lCY3Xtzi43nhvDVhHbRVtKXsY3zgTFeO2LIScwMUW91A5h2oLk1Wm3L7lKj7lsJBzQRW611FN09bP2nuGWrXVcLQTW22YMQv3PBwWFjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XjB7ON+m; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720631440; x=1752167440;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=p4Gl9a++9hldLPmE/boFd47IvYZskyOh8zHYSOXBl8c=;
  b=XjB7ON+m5h7kVw19EwQUZ1WUZrO1M11bl7T1gj86wdh5uet+paKqeSe8
   ItiGx1gsnjKEOyKyZUJx5gvcTjT7UrigW+V58v5bXknpy2dFVJTbB6C78
   /x0tpuaodX79ND1huTrlq8QsP4WKNzOnEK/YlpulOojgdOe+7IJe7mZI8
   aWMZnBVwJzoS4fQ6l+kWP2X/y9AKuoAGVB09ixhzEWYxFXIQC/Id694pQ
   45mFcgO4e1GjgD5OaTp3tawMPvFJmzA0sRnTp0fB4YRBkCVIRjZPrvSCM
   rPzKpnQU64WLK4L2PqzdqXrgI8OjQ42BugzJLKh/+9pvoEwkwv520cx+N
   A==;
X-CSE-ConnectionGUID: 0wZoW2OGSxKhouwPdwwGFw==
X-CSE-MsgGUID: sWPaTceiSReuj3GkIYomOQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11129"; a="18113809"
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="18113809"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 10:10:39 -0700
X-CSE-ConnectionGUID: xwTzK0HuSAifD2kh3MB91w==
X-CSE-MsgGUID: jNZFVDLOQKK6oZZY1s39Kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="48300081"
Received: from lkp-server01.sh.intel.com (HELO 68891e0c336b) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 10 Jul 2024 10:10:36 -0700
Received: from kbuild by 68891e0c336b with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sRapu-000Y3y-1i;
	Wed, 10 Jul 2024 17:10:34 +0000
Date: Thu, 11 Jul 2024 01:10:06 +0800
From: kernel test robot <lkp@intel.com>
To: Karol Kolacinski <karol.kolacinski@intel.com>,
	intel-wired-lan@lists.osuosl.org
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	Michal Michalik <michal.michalik@intel.com>,
	Milena Olech <milena.olech@intel.com>,
	Paul Greenwalt <paul.greenwalt@intel.com>,
	Karol Kolacinski <karol.kolacinski@intel.com>
Subject: Re: [PATCH iwl-next 1/4] ice: Implement PTP support for E830 devices
Message-ID: <202407110019.Tv1TxdCA-lkp@intel.com>
References: <20240709123629.666151-7-karol.kolacinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240709123629.666151-7-karol.kolacinski@intel.com>

Hi Karol,

kernel test robot noticed the following build errors:

[auto build test ERROR on 529314adcbceca0e0ec72b3ea94fe4a54ae61ca6]

url:    https://github.com/intel-lab-lkp/linux/commits/Karol-Kolacinski/ice-Implement-PTP-support-for-E830-devices/20240710-034725
base:   529314adcbceca0e0ec72b3ea94fe4a54ae61ca6
patch link:    https://lore.kernel.org/r/20240709123629.666151-7-karol.kolacinski%40intel.com
patch subject: [PATCH iwl-next 1/4] ice: Implement PTP support for E830 devices
config: mips-allyesconfig (https://download.01.org/0day-ci/archive/20240711/202407110019.Tv1TxdCA-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 13.3.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240711/202407110019.Tv1TxdCA-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202407110019.Tv1TxdCA-lkp@intel.com/

All errors (new ones prefixed by >>):

   include/linux/compiler_types.h:510:9: note: in expansion of macro '_compiletime_assert'
     510 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   include/linux/build_bug.h:21:9: note: in expansion of macro 'BUILD_BUG_ON'
      21 |         BUILD_BUG_ON(((n) & ((n) - 1)) != 0)
         |         ^~~~~~~~~~~~
   include/linux/bitfield.h:75:17: note: in expansion of macro '__BUILD_BUG_ON_NOT_POWER_OF_2'
      75 |                 __BUILD_BUG_ON_NOT_POWER_OF_2((_mask) +                 \
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:76:56: note: in expansion of macro '__bf_shf'
      76 |                                               (1ULL << __bf_shf(_mask))); \
         |                                                        ^~~~~~~~
   include/linux/bitfield.h:115:17: note: in expansion of macro '__BF_FIELD_CHECK'
     115 |                 __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
         |                 ^~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/ice/ice_ptp_hw.c:5436:19: note: in expansion of macro 'FIELD_PREP'
    5436 |         *tstamp = FIELD_PREP(PHY_EXT_40B_HIGH_M, hi) |
         |                   ^~~~~~~~~~
   include/linux/bits.h:35:38: note: in expansion of macro '__GENMASK'
      35 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   drivers/net/ethernet/intel/ice/ice_ptp_hw.h:688:41: note: in expansion of macro 'GENMASK'
     688 | #define PHY_EXT_40B_HIGH_M              GENMASK(39, 32)
         |                                         ^~~~~~~
   drivers/net/ethernet/intel/ice/ice_ptp_hw.c:5436:30: note: in expansion of macro 'PHY_EXT_40B_HIGH_M'
    5436 |         *tstamp = FIELD_PREP(PHY_EXT_40B_HIGH_M, hi) |
         |                              ^~~~~~~~~~~~~~~~~~
   include/uapi/linux/bits.h:8:31: warning: left shift count >= width of type [-Wshift-count-overflow]
       8 |         (((~_UL(0)) - (_UL(1) << (l)) + 1) & \
         |                               ^~
   include/linux/bitfield.h:45:38: note: in definition of macro '__bf_shf'
      45 | #define __bf_shf(x) (__builtin_ffsll(x) - 1)
         |                                      ^
   drivers/net/ethernet/intel/ice/ice_ptp_hw.c:5436:19: note: in expansion of macro 'FIELD_PREP'
    5436 |         *tstamp = FIELD_PREP(PHY_EXT_40B_HIGH_M, hi) |
         |                   ^~~~~~~~~~
   include/linux/bits.h:35:38: note: in expansion of macro '__GENMASK'
      35 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   drivers/net/ethernet/intel/ice/ice_ptp_hw.h:688:41: note: in expansion of macro 'GENMASK'
     688 | #define PHY_EXT_40B_HIGH_M              GENMASK(39, 32)
         |                                         ^~~~~~~
   drivers/net/ethernet/intel/ice/ice_ptp_hw.c:5436:30: note: in expansion of macro 'PHY_EXT_40B_HIGH_M'
    5436 |         *tstamp = FIELD_PREP(PHY_EXT_40B_HIGH_M, hi) |
         |                              ^~~~~~~~~~~~~~~~~~
   include/uapi/linux/bits.h:9:19: warning: right shift count is negative [-Wshift-count-negative]
       9 |          (~_UL(0) >> (__BITS_PER_LONG - 1 - (h))))
         |                   ^~
   include/linux/bitfield.h:45:38: note: in definition of macro '__bf_shf'
      45 | #define __bf_shf(x) (__builtin_ffsll(x) - 1)
         |                                      ^
   drivers/net/ethernet/intel/ice/ice_ptp_hw.c:5436:19: note: in expansion of macro 'FIELD_PREP'
    5436 |         *tstamp = FIELD_PREP(PHY_EXT_40B_HIGH_M, hi) |
         |                   ^~~~~~~~~~
   include/linux/bits.h:35:38: note: in expansion of macro '__GENMASK'
      35 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   drivers/net/ethernet/intel/ice/ice_ptp_hw.h:688:41: note: in expansion of macro 'GENMASK'
     688 | #define PHY_EXT_40B_HIGH_M              GENMASK(39, 32)
         |                                         ^~~~~~~
   drivers/net/ethernet/intel/ice/ice_ptp_hw.c:5436:30: note: in expansion of macro 'PHY_EXT_40B_HIGH_M'
    5436 |         *tstamp = FIELD_PREP(PHY_EXT_40B_HIGH_M, hi) |
         |                              ^~~~~~~~~~~~~~~~~~
   include/uapi/linux/bits.h:8:31: warning: left shift count >= width of type [-Wshift-count-overflow]
       8 |         (((~_UL(0)) - (_UL(1) << (l)) + 1) & \
         |                               ^~
   include/linux/bitfield.h:116:63: note: in definition of macro 'FIELD_PREP'
     116 |                 ((typeof(_mask))(_val) << __bf_shf(_mask)) & (_mask);   \
         |                                                               ^~~~~
   include/linux/bits.h:35:38: note: in expansion of macro '__GENMASK'
      35 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   drivers/net/ethernet/intel/ice/ice_ptp_hw.h:688:41: note: in expansion of macro 'GENMASK'
     688 | #define PHY_EXT_40B_HIGH_M              GENMASK(39, 32)
         |                                         ^~~~~~~
   drivers/net/ethernet/intel/ice/ice_ptp_hw.c:5436:30: note: in expansion of macro 'PHY_EXT_40B_HIGH_M'
    5436 |         *tstamp = FIELD_PREP(PHY_EXT_40B_HIGH_M, hi) |
         |                              ^~~~~~~~~~~~~~~~~~
   include/uapi/linux/bits.h:9:19: warning: right shift count is negative [-Wshift-count-negative]
       9 |          (~_UL(0) >> (__BITS_PER_LONG - 1 - (h))))
         |                   ^~
   include/linux/bitfield.h:116:63: note: in definition of macro 'FIELD_PREP'
     116 |                 ((typeof(_mask))(_val) << __bf_shf(_mask)) & (_mask);   \
         |                                                               ^~~~~
   include/linux/bits.h:35:38: note: in expansion of macro '__GENMASK'
      35 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   drivers/net/ethernet/intel/ice/ice_ptp_hw.h:688:41: note: in expansion of macro 'GENMASK'
     688 | #define PHY_EXT_40B_HIGH_M              GENMASK(39, 32)
         |                                         ^~~~~~~
   drivers/net/ethernet/intel/ice/ice_ptp_hw.c:5436:30: note: in expansion of macro 'PHY_EXT_40B_HIGH_M'
    5436 |         *tstamp = FIELD_PREP(PHY_EXT_40B_HIGH_M, hi) |
         |                              ^~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/ice/ice_ptp_hw.c: In function 'ice_read_ptp_tstamp_eth56g.isra':
>> include/linux/compiler_types.h:510:45: error: call to '__compiletime_assert_978' declared with attribute error: FIELD_PREP: mask is not constant
     510 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                             ^
   include/linux/compiler_types.h:491:25: note: in definition of macro '__compiletime_assert'
     491 |                         prefix ## suffix();                             \
         |                         ^~~~~~
   include/linux/compiler_types.h:510:9: note: in expansion of macro '_compiletime_assert'
     510 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:65:17: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      65 |                 BUILD_BUG_ON_MSG(!__builtin_constant_p(_mask),          \
         |                 ^~~~~~~~~~~~~~~~
   include/linux/bitfield.h:115:17: note: in expansion of macro '__BF_FIELD_CHECK'
     115 |                 __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
         |                 ^~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/ice/ice_ptp_hw.c:1511:19: note: in expansion of macro 'FIELD_PREP'
    1511 |         *tstamp = FIELD_PREP(PHY_40B_HIGH_M, hi) |
         |                   ^~~~~~~~~~
   drivers/net/ethernet/intel/ice/ice_ptp_hw.c: In function 'ice_read_phy_tstamp_e810.isra':
   include/linux/compiler_types.h:510:45: error: call to '__compiletime_assert_1260' declared with attribute error: FIELD_PREP: mask is not constant
     510 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                             ^
   include/linux/compiler_types.h:491:25: note: in definition of macro '__compiletime_assert'
     491 |                         prefix ## suffix();                             \
         |                         ^~~~~~
   include/linux/compiler_types.h:510:9: note: in expansion of macro '_compiletime_assert'
     510 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:65:17: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      65 |                 BUILD_BUG_ON_MSG(!__builtin_constant_p(_mask),          \
         |                 ^~~~~~~~~~~~~~~~
   include/linux/bitfield.h:115:17: note: in expansion of macro '__BF_FIELD_CHECK'
     115 |                 __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
         |                 ^~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/ice/ice_ptp_hw.c:4948:19: note: in expansion of macro 'FIELD_PREP'
    4948 |         *tstamp = FIELD_PREP(PHY_EXT_40B_HIGH_M, hi) |
         |                   ^~~~~~~~~~
   drivers/net/ethernet/intel/ice/ice_ptp_hw.c: In function 'ice_read_phy_tstamp_e82x.isra':
   include/linux/compiler_types.h:510:45: error: call to '__compiletime_assert_1160' declared with attribute error: FIELD_PREP: mask is not constant
     510 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                             ^
   include/linux/compiler_types.h:491:25: note: in definition of macro '__compiletime_assert'
     491 |                         prefix ## suffix();                             \
         |                         ^~~~~~
   include/linux/compiler_types.h:510:9: note: in expansion of macro '_compiletime_assert'
     510 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:65:17: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      65 |                 BUILD_BUG_ON_MSG(!__builtin_constant_p(_mask),          \
         |                 ^~~~~~~~~~~~~~~~
   include/linux/bitfield.h:115:17: note: in expansion of macro '__BF_FIELD_CHECK'
     115 |                 __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
         |                 ^~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/ice/ice_ptp_hw.c:3193:19: note: in expansion of macro 'FIELD_PREP'
    3193 |         *tstamp = FIELD_PREP(PHY_40B_HIGH_M, hi) |
         |                   ^~~~~~~~~~
   In function 'ice_read_phy_tstamp_e830',
       inlined from 'ice_read_phy_tstamp' at drivers/net/ethernet/intel/ice/ice_ptp_hw.c:5874:10:
   include/linux/compiler_types.h:510:45: error: call to '__compiletime_assert_1295' declared with attribute error: FIELD_PREP: mask is not constant
     510 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                             ^
   include/linux/compiler_types.h:491:25: note: in definition of macro '__compiletime_assert'
     491 |                         prefix ## suffix();                             \
         |                         ^~~~~~
   include/linux/compiler_types.h:510:9: note: in expansion of macro '_compiletime_assert'
     510 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:65:17: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      65 |                 BUILD_BUG_ON_MSG(!__builtin_constant_p(_mask),          \
         |                 ^~~~~~~~~~~~~~~~
   include/linux/bitfield.h:115:17: note: in expansion of macro '__BF_FIELD_CHECK'
     115 |                 __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
         |                 ^~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/ice/ice_ptp_hw.c:5436:19: note: in expansion of macro 'FIELD_PREP'
    5436 |         *tstamp = FIELD_PREP(PHY_EXT_40B_HIGH_M, hi) |
         |                   ^~~~~~~~~~


vim +/__compiletime_assert_978 +510 include/linux/compiler_types.h

eb5c2d4b45e3d2 Will Deacon 2020-07-21  496  
eb5c2d4b45e3d2 Will Deacon 2020-07-21  497  #define _compiletime_assert(condition, msg, prefix, suffix) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21  498  	__compiletime_assert(condition, msg, prefix, suffix)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  499  
eb5c2d4b45e3d2 Will Deacon 2020-07-21  500  /**
eb5c2d4b45e3d2 Will Deacon 2020-07-21  501   * compiletime_assert - break build and emit msg if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  502   * @condition: a compile-time constant condition to check
eb5c2d4b45e3d2 Will Deacon 2020-07-21  503   * @msg:       a message to emit if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  504   *
eb5c2d4b45e3d2 Will Deacon 2020-07-21  505   * In tradition of POSIX assert, this macro will break the build if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  506   * supplied condition is *false*, emitting the supplied error message if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  507   * compiler has support to do so.
eb5c2d4b45e3d2 Will Deacon 2020-07-21  508   */
eb5c2d4b45e3d2 Will Deacon 2020-07-21  509  #define compiletime_assert(condition, msg) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21 @510  	_compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  511  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

