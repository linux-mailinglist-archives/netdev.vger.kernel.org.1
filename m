Return-Path: <netdev+bounces-87203-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A6478A223F
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 01:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B13C628AA30
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 23:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D3747F59;
	Thu, 11 Apr 2024 23:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GWxyn7sh"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A45524C
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 23:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712877843; cv=none; b=EABe6unUiUXlOiuaGFxPCDnPc/ZpgakcopmE2WKxEZYHdRDMmbo4/z7F4mmZRTJ4ZzJSCVJRzV976ltc+3j5EXI3yRcWmpwijfNBPRmIo75NeYtXkcYrF3YWccu1rghIkho+tVKWSlOqVFTi+vlR2WIpVsEJIid0BEvX32Irk0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712877843; c=relaxed/simple;
	bh=G7tNbr/pyOlZ4/hL1mcrTmWV4w+ePVYtzpFLZe0MG5k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HJWY1GBLPv9MpG8sChGcCbcWpPo80aL52ek4iPbmNqQEUtF3lRk2yJJhzVbzjyhSyevjhSuhjOrXBcVCkZ66nNHJKfnhHhaJ6VfTxqZULqZ7JxGwE1TWIT93UEIF09UlfezPX0x/Z6DNBzE3a4MLvGdIaTNVpY3EjLrRWiNvkzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GWxyn7sh; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712877841; x=1744413841;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=G7tNbr/pyOlZ4/hL1mcrTmWV4w+ePVYtzpFLZe0MG5k=;
  b=GWxyn7shjCyrIBqKVOX1TtLgYZLRjX/iT6qMvhrh/L+1Pei3VJ0HN6eK
   22P694/zhaU6bfisSu9CSWBch7vKQo06TjN2HJbfMzeONVpG7rfV9Gj7i
   uRYxzub9UygywRULUuSR/vTVkf+ugOxVPwnYYlkHcXzsUOvN9FzvbuvcH
   0EE57nmb3txzCHDa+PvO0BVvV5z6YAN6NY3RVYbCPTFSfsAC7jFGfy3nt
   XwtWVv6vj2ce6/enaNYy1Seh/c/NmF9EJ2cFg3V9TWxuASbzgKzhmslBP
   lME57y3Xr1v09XM92PPhMnT7+wE/sqlIJCV6EuZvI3q1jezt/1Qbr9XXt
   A==;
X-CSE-ConnectionGUID: itPruR4gTbS9DTI70tTgFw==
X-CSE-MsgGUID: 9feUJ8dLTNeiRS4qfOVkOw==
X-IronPort-AV: E=McAfee;i="6600,9927,11041"; a="33718230"
X-IronPort-AV: E=Sophos;i="6.07,194,1708416000"; 
   d="scan'208";a="33718230"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 16:24:00 -0700
X-CSE-ConnectionGUID: QMh1Uu/hT9K6z1I2m6JpxQ==
X-CSE-MsgGUID: 0wbBKrQRQ8qHlYEwzObFPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,194,1708416000"; 
   d="scan'208";a="21104175"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 11 Apr 2024 16:23:58 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rv3lr-00095X-0o;
	Thu, 11 Apr 2024 23:23:55 +0000
Date: Fri, 12 Apr 2024 07:23:51 +0800
From: kernel test robot <lkp@intel.com>
To: Karol Kolacinski <karol.kolacinski@intel.com>,
	intel-wired-lan@lists.osuosl.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, anthony.l.nguyen@intel.com,
	jesse.brandeburg@intel.com,
	Sergey Temerkhanov <sergey.temerkhanov@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Karol Kolacinski <karol.kolacinski@intel.com>
Subject: Re: [PATCH v7 iwl-next 05/12] ice: Move CGU block
Message-ID: <202404120744.ROMZFi55-lkp@intel.com>
References: <20240408111814.404583-19-karol.kolacinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240408111814.404583-19-karol.kolacinski@intel.com>

Hi Karol,

kernel test robot noticed the following build warnings:

[auto build test WARNING on c6f2492cda380a8bce00f61c3a4272401fbb9043]

url:    https://github.com/intel-lab-lkp/linux/commits/Karol-Kolacinski/ice-Introduce-ice_ptp_hw-struct/20240408-192129
base:   c6f2492cda380a8bce00f61c3a4272401fbb9043
patch link:    https://lore.kernel.org/r/20240408111814.404583-19-karol.kolacinski%40intel.com
patch subject: [PATCH v7 iwl-next 05/12] ice: Move CGU block
config: arm-randconfig-002-20240412 (https://download.01.org/0day-ci/archive/20240412/202404120744.ROMZFi55-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240412/202404120744.ROMZFi55-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404120744.ROMZFi55-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/net/ethernet/intel/ice/ice_ptp_hw.c:902:19: warning: shift count is negative [-Wshift-count-negative]
           high = FIELD_GET(P_REG_40B_HIGH_M, val);
                  ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/ice/ice_ptp_hw.h:381:27: note: expanded from macro 'P_REG_40B_HIGH_M'
   #define P_REG_40B_HIGH_M                GENMASK(39, 8)
                                           ^
   include/linux/bits.h:35:31: note: expanded from macro 'GENMASK'
           (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
                                        ^
   include/uapi/linux/bits.h:9:19: note: expanded from macro '__GENMASK'
            (~_UL(0) >> (__BITS_PER_LONG - 1 - (h))))
                     ^
   note: (skipping 3 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:460:22: note: expanded from macro 'compiletime_assert'
           _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
           ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:448:23: note: expanded from macro '_compiletime_assert'
           __compiletime_assert(condition, msg, prefix, suffix)
           ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:440:9: note: expanded from macro '__compiletime_assert'
                   if (!(condition))                                       \
                         ^~~~~~~~~
>> drivers/net/ethernet/intel/ice/ice_ptp_hw.c:902:19: warning: shift count is negative [-Wshift-count-negative]
           high = FIELD_GET(P_REG_40B_HIGH_M, val);
                  ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/ice/ice_ptp_hw.h:381:27: note: expanded from macro 'P_REG_40B_HIGH_M'
   #define P_REG_40B_HIGH_M                GENMASK(39, 8)
                                           ^
   include/linux/bits.h:35:31: note: expanded from macro 'GENMASK'
           (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
                                        ^
   include/uapi/linux/bits.h:9:19: note: expanded from macro '__GENMASK'
            (~_UL(0) >> (__BITS_PER_LONG - 1 - (h))))
                     ^
   note: (skipping 3 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:460:22: note: expanded from macro 'compiletime_assert'
           _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
           ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:448:23: note: expanded from macro '_compiletime_assert'
           __compiletime_assert(condition, msg, prefix, suffix)
           ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:440:9: note: expanded from macro '__compiletime_assert'
                   if (!(condition))                                       \
                         ^~~~~~~~~
>> drivers/net/ethernet/intel/ice/ice_ptp_hw.c:902:19: warning: shift count is negative [-Wshift-count-negative]
           high = FIELD_GET(P_REG_40B_HIGH_M, val);
                  ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/ice/ice_ptp_hw.h:381:27: note: expanded from macro 'P_REG_40B_HIGH_M'
   #define P_REG_40B_HIGH_M                GENMASK(39, 8)
                                           ^
   include/linux/bits.h:35:31: note: expanded from macro 'GENMASK'
           (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
                                        ^
   include/uapi/linux/bits.h:9:19: note: expanded from macro '__GENMASK'
            (~_UL(0) >> (__BITS_PER_LONG - 1 - (h))))
                     ^
   note: (skipping 3 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:460:22: note: expanded from macro 'compiletime_assert'
           _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
           ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:448:23: note: expanded from macro '_compiletime_assert'
           __compiletime_assert(condition, msg, prefix, suffix)
           ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:440:9: note: expanded from macro '__compiletime_assert'
                   if (!(condition))                                       \
                         ^~~~~~~~~
>> drivers/net/ethernet/intel/ice/ice_ptp_hw.c:902:19: warning: shift count is negative [-Wshift-count-negative]
           high = FIELD_GET(P_REG_40B_HIGH_M, val);
                  ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/ice/ice_ptp_hw.h:381:27: note: expanded from macro 'P_REG_40B_HIGH_M'
   #define P_REG_40B_HIGH_M                GENMASK(39, 8)
                                           ^
   include/linux/bits.h:35:31: note: expanded from macro 'GENMASK'
           (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
                                        ^
   include/uapi/linux/bits.h:9:19: note: expanded from macro '__GENMASK'
            (~_UL(0) >> (__BITS_PER_LONG - 1 - (h))))
                     ^
   note: (skipping 4 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:460:22: note: expanded from macro 'compiletime_assert'
           _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
           ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:448:23: note: expanded from macro '_compiletime_assert'
           __compiletime_assert(condition, msg, prefix, suffix)
           ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:440:9: note: expanded from macro '__compiletime_assert'
                   if (!(condition))                                       \
                         ^~~~~~~~~
>> drivers/net/ethernet/intel/ice/ice_ptp_hw.c:902:19: warning: shift count is negative [-Wshift-count-negative]
           high = FIELD_GET(P_REG_40B_HIGH_M, val);
                  ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/ice/ice_ptp_hw.h:381:27: note: expanded from macro 'P_REG_40B_HIGH_M'
   #define P_REG_40B_HIGH_M                GENMASK(39, 8)
                                           ^
   include/linux/bits.h:35:31: note: expanded from macro 'GENMASK'
           (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
                                        ^
   include/uapi/linux/bits.h:9:19: note: expanded from macro '__GENMASK'
            (~_UL(0) >> (__BITS_PER_LONG - 1 - (h))))
                     ^
   note: (skipping 4 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:460:22: note: expanded from macro 'compiletime_assert'
           _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
           ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:448:23: note: expanded from macro '_compiletime_assert'
           __compiletime_assert(condition, msg, prefix, suffix)
           ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:440:9: note: expanded from macro '__compiletime_assert'
                   if (!(condition))                                       \
                         ^~~~~~~~~
>> drivers/net/ethernet/intel/ice/ice_ptp_hw.c:902:19: warning: shift count is negative [-Wshift-count-negative]
           high = FIELD_GET(P_REG_40B_HIGH_M, val);
                  ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/ice/ice_ptp_hw.h:381:27: note: expanded from macro 'P_REG_40B_HIGH_M'
   #define P_REG_40B_HIGH_M                GENMASK(39, 8)
                                           ^
   include/linux/bits.h:35:31: note: expanded from macro 'GENMASK'
           (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
                                        ^
   include/uapi/linux/bits.h:9:19: note: expanded from macro '__GENMASK'
            (~_UL(0) >> (__BITS_PER_LONG - 1 - (h))))
                     ^
   note: (skipping 5 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:460:22: note: expanded from macro 'compiletime_assert'
           _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
           ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:448:23: note: expanded from macro '_compiletime_assert'
           __compiletime_assert(condition, msg, prefix, suffix)
           ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:440:9: note: expanded from macro '__compiletime_assert'
                   if (!(condition))                                       \
                         ^~~~~~~~~
>> drivers/net/ethernet/intel/ice/ice_ptp_hw.c:902:19: warning: shift count is negative [-Wshift-count-negative]
           high = FIELD_GET(P_REG_40B_HIGH_M, val);
                  ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/ice/ice_ptp_hw.h:381:27: note: expanded from macro 'P_REG_40B_HIGH_M'
   #define P_REG_40B_HIGH_M                GENMASK(39, 8)
                                           ^
   include/linux/bits.h:35:31: note: expanded from macro 'GENMASK'
           (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
                                        ^
   include/uapi/linux/bits.h:9:19: note: expanded from macro '__GENMASK'
            (~_UL(0) >> (__BITS_PER_LONG - 1 - (h))))
                     ^
   note: (skipping 6 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:460:22: note: expanded from macro 'compiletime_assert'
           _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
           ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:448:23: note: expanded from macro '_compiletime_assert'
           __compiletime_assert(condition, msg, prefix, suffix)
           ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:440:9: note: expanded from macro '__compiletime_assert'
                   if (!(condition))                                       \
                         ^~~~~~~~~
>> drivers/net/ethernet/intel/ice/ice_ptp_hw.c:902:19: warning: shift count is negative [-Wshift-count-negative]
           high = FIELD_GET(P_REG_40B_HIGH_M, val);
                  ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/ice/ice_ptp_hw.h:381:27: note: expanded from macro 'P_REG_40B_HIGH_M'
   #define P_REG_40B_HIGH_M                GENMASK(39, 8)
                                           ^
   include/linux/bits.h:35:31: note: expanded from macro 'GENMASK'
           (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
                                        ^
   include/uapi/linux/bits.h:9:19: note: expanded from macro '__GENMASK'
            (~_UL(0) >> (__BITS_PER_LONG - 1 - (h))))
                     ^
   note: (skipping 5 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:460:22: note: expanded from macro 'compiletime_assert'
           _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
           ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:448:23: note: expanded from macro '_compiletime_assert'
           __compiletime_assert(condition, msg, prefix, suffix)
           ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:440:9: note: expanded from macro '__compiletime_assert'
                   if (!(condition))                                       \
                         ^~~~~~~~~
>> drivers/net/ethernet/intel/ice/ice_ptp_hw.c:902:19: warning: shift count is negative [-Wshift-count-negative]
           high = FIELD_GET(P_REG_40B_HIGH_M, val);
                  ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/ice/ice_ptp_hw.h:381:27: note: expanded from macro 'P_REG_40B_HIGH_M'
   #define P_REG_40B_HIGH_M                GENMASK(39, 8)
                                           ^
   include/linux/bits.h:35:31: note: expanded from macro 'GENMASK'
           (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
                                        ^
   include/uapi/linux/bits.h:9:19: note: expanded from macro '__GENMASK'
            (~_UL(0) >> (__BITS_PER_LONG - 1 - (h))))
                     ^
   note: (skipping 6 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:460:22: note: expanded from macro 'compiletime_assert'
           _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
           ~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:448:23: note: expanded from macro '_compiletime_assert'
           __compiletime_assert(condition, msg, prefix, suffix)
           ~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/compiler_types.h:440:9: note: expanded from macro '__compiletime_assert'
                   if (!(condition))                                       \
                         ^~~~~~~~~
>> drivers/net/ethernet/intel/ice/ice_ptp_hw.c:902:19: warning: shift count is negative [-Wshift-count-negative]
           high = FIELD_GET(P_REG_40B_HIGH_M, val);
                  ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/ice/ice_ptp_hw.h:381:27: note: expanded from macro 'P_REG_40B_HIGH_M'
   #define P_REG_40B_HIGH_M                GENMASK(39, 8)
                                           ^
   include/linux/bits.h:35:31: note: expanded from macro 'GENMASK'
           (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
                                        ^
   include/uapi/linux/bits.h:9:19: note: expanded from macro '__GENMASK'
            (~_UL(0) >> (__BITS_PER_LONG - 1 - (h))))
                     ^
   include/linux/bitfield.h:156:30: note: expanded from macro 'FIELD_GET'
                   (typeof(_mask))(((_reg) & (_mask)) >> __bf_shf(_mask)); \
                                              ^~~~~
>> drivers/net/ethernet/intel/ice/ice_ptp_hw.c:902:19: warning: shift count is negative [-Wshift-count-negative]
           high = FIELD_GET(P_REG_40B_HIGH_M, val);
                  ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/ice/ice_ptp_hw.h:381:27: note: expanded from macro 'P_REG_40B_HIGH_M'
   #define P_REG_40B_HIGH_M                GENMASK(39, 8)
                                           ^
   include/linux/bits.h:35:31: note: expanded from macro 'GENMASK'
           (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
                                        ^
   include/uapi/linux/bits.h:9:19: note: expanded from macro '__GENMASK'
            (~_UL(0) >> (__BITS_PER_LONG - 1 - (h))))
                     ^
   include/linux/bitfield.h:156:50: note: expanded from macro 'FIELD_GET'
                   (typeof(_mask))(((_reg) & (_mask)) >> __bf_shf(_mask)); \
                                                         ~~~~~~~~~^~~~~~
   include/linux/bitfield.h:45:38: note: expanded from macro '__bf_shf'
   #define __bf_shf(x) (__builtin_ffsll(x) - 1)
                                        ^
   11 warnings generated.


vim +902 drivers/net/ethernet/intel/ice/ice_ptp_hw.c

   875	
   876	/**
   877	 * ice_write_40b_phy_reg_e82x - Write a 40b value to the PHY
   878	 * @hw: pointer to the HW struct
   879	 * @port: port to write to
   880	 * @low_addr: offset of the low register
   881	 * @val: 40b value to write
   882	 *
   883	 * Write the provided 40b value to the two associated registers by splitting
   884	 * it up into two chunks, the lower 8 bits and the upper 32 bits.
   885	 */
   886	static int
   887	ice_write_40b_phy_reg_e82x(struct ice_hw *hw, u8 port, u16 low_addr, u64 val)
   888	{
   889		u32 low, high;
   890		u16 high_addr;
   891		int err;
   892	
   893		/* Only operate on registers known to be split into a lower 8 bit
   894		 * register and an upper 32 bit register.
   895		 */
   896		if (!ice_is_40b_phy_reg_e82x(low_addr, &high_addr)) {
   897			ice_debug(hw, ICE_DBG_PTP, "Invalid 40b register addr 0x%08x\n",
   898				  low_addr);
   899			return -EINVAL;
   900		}
   901		low = FIELD_GET(P_REG_40B_LOW_M, val);
 > 902		high = FIELD_GET(P_REG_40B_HIGH_M, val);
   903	
   904		err = ice_write_phy_reg_e82x(hw, port, low_addr, low);
   905		if (err) {
   906			ice_debug(hw, ICE_DBG_PTP, "Failed to write to low register 0x%08x\n, err %d",
   907				  low_addr, err);
   908			return err;
   909		}
   910	
   911		err = ice_write_phy_reg_e82x(hw, port, high_addr, high);
   912		if (err) {
   913			ice_debug(hw, ICE_DBG_PTP, "Failed to write to high register 0x%08x\n, err %d",
   914				  high_addr, err);
   915			return err;
   916		}
   917	
   918		return 0;
   919	}
   920	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

