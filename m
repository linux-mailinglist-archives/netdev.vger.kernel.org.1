Return-Path: <netdev+bounces-85277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43CA989A035
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 16:52:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED8D4282643
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 14:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9008716F82A;
	Fri,  5 Apr 2024 14:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SI9aGuPw"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6A316F299
	for <netdev@vger.kernel.org>; Fri,  5 Apr 2024 14:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712328714; cv=none; b=INOhn+mpIoVYj0OvXD2XCjXQUzN8rXTGdSYxFdXLpEfTaav9/YuI16AD0Ie/o0yMP7l+MST+X7CfSaUboe7gwGLKV5AXvRKBcJdJpMuIEZ5xZBevPaV3bw2HIVmoG47zTQsD5UyScQ95wYShzFP2qfuZiXrDgg30WohPaJMoPkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712328714; c=relaxed/simple;
	bh=y6aGInTAAg2qclybmOt7SjTmo6OZ/1NUmOKqsUgiqCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oltsw+uYN0YdBJ2dzWfNWN5xQ76WV20g7JlgJSTVfZB61NeXkvmHefTpjmLKHvuqvk10BY42syAV0ykazZ/57D17FcoNqPMciDd1vU9dDIFlMhlWYcSdzazea0MRIIMkWd9xZ9QK2SVxna3UiPxrl8c0yH9Pcx4qbEPNw3W2Z2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SI9aGuPw; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712328712; x=1743864712;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=y6aGInTAAg2qclybmOt7SjTmo6OZ/1NUmOKqsUgiqCY=;
  b=SI9aGuPwAXaDzvihOBk8nBc9rIM5oqxoiKTHeHn2EMWxWTzDT2g4HD6E
   6GugxzQvoq3WxnewCFFYFtPTT5R2S/gN2NTUZMxdMNF4oaHOnLp0Ju680
   P1Igm4L7QqQpRLJeHO4aThJmC8XEli0xDGmEr7v/QtgVLpfQWPGfZPLjv
   0EaBora/tuFmkJEsnIL9ui/M8J40gQVFWzD4BuUzZiINk55R7ku17wxvT
   0FshsyyfhPpfU7hDGA3h5VVqYY0f9X/r2jk+0Vce5OtaT6GQyE18i0CxH
   OT/NBxW+yGONmejKrdMPO3vMSzabB7U8OPh6JvymSOPUnk98Fl6yV9orc
   A==;
X-CSE-ConnectionGUID: PS74jUVuTiKbQN6cgAhkZg==
X-CSE-MsgGUID: c8StdFQjRCucn6hYAa5yPA==
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="18269597"
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="18269597"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 07:51:52 -0700
X-CSE-ConnectionGUID: k/EOB6jQRkOU6RidrNjgCQ==
X-CSE-MsgGUID: /uoJ8pIiTsWQlpgRF2lYVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="19285030"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 05 Apr 2024 07:51:49 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rskux-0002NR-12;
	Fri, 05 Apr 2024 14:51:47 +0000
Date: Fri, 5 Apr 2024 22:51:15 +0800
From: kernel test robot <lkp@intel.com>
To: Karol Kolacinski <karol.kolacinski@intel.com>,
	intel-wired-lan@lists.osuosl.org
Cc: oe-kbuild-all@lists.linux.dev,
	Michal Michalik <michal.michalik@intel.com>,
	Sergey Temerkhanov <sergey.temerkhanov@intel.com>,
	netdev@vger.kernel.org,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Karol Kolacinski <karol.kolacinski@intel.com>,
	anthony.l.nguyen@intel.com,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH v6 iwl-next 07/12] ice: Introduce
 ETH56G PHY model for E825C products
Message-ID: <202404052227.vqijAkBX-lkp@intel.com>
References: <20240405100648.144756-21-karol.kolacinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405100648.144756-21-karol.kolacinski@intel.com>

Hi Karol,

kernel test robot noticed the following build errors:

[auto build test ERROR on 0a3074e5b4b523fb60f4ae9fb32bb180ea1fb6ef]

url:    https://github.com/intel-lab-lkp/linux/commits/Karol-Kolacinski/ice-Introduce-ice_ptp_hw-struct/20240405-180941
base:   0a3074e5b4b523fb60f4ae9fb32bb180ea1fb6ef
patch link:    https://lore.kernel.org/r/20240405100648.144756-21-karol.kolacinski%40intel.com
patch subject: [Intel-wired-lan] [PATCH v6 iwl-next 07/12] ice: Introduce ETH56G PHY model for E825C products
config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20240405/202404052227.vqijAkBX-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240405/202404052227.vqijAkBX-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404052227.vqijAkBX-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/net/ethernet/intel/ice/ice_ptp_hw.c: In function 'ice_read_cgu_reg_e82x':
   drivers/net/ethernet/intel/ice/ice_ptp_hw.c:245:25: warning: initialization of 'unsigned int' from 'u32 *' {aka 'unsigned int *'} makes integer from pointer without a cast [-Wint-conversion]
     245 |                 .data = val
         |                         ^~~
   drivers/net/ethernet/intel/ice/ice_ptp_hw.c:245:25: note: (near initialization for 'cgu_msg.data')
   drivers/net/ethernet/intel/ice/ice_ptp_hw.c: In function 'ice_write_40b_phy_reg_eth56g':
>> drivers/net/ethernet/intel/ice/ice_ptp_hw.c:1035:27: error: 'P_REG_40B_HIGH_S' undeclared (first use in this function); did you mean 'P_REG_40B_HIGH_M'?
    1035 |         hi = (u32)(val >> P_REG_40B_HIGH_S);
         |                           ^~~~~~~~~~~~~~~~
         |                           P_REG_40B_HIGH_M
   drivers/net/ethernet/intel/ice/ice_ptp_hw.c:1035:27: note: each undeclared identifier is reported only once for each function it appears in
   In file included from <command-line>:
   drivers/net/ethernet/intel/ice/ice_ptp_hw.c: In function 'ice_write_40b_phy_reg_e82x':
   include/uapi/linux/bits.h:9:19: warning: right shift count is negative [-Wshift-count-negative]
       9 |          (~_UL(0) >> (__BITS_PER_LONG - 1 - (h))))
         |                   ^~
   include/linux/compiler_types.h:440:23: note: in definition of macro '__compiletime_assert'
     440 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:460:9: note: in expansion of macro '_compiletime_assert'
     460 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:65:17: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      65 |                 BUILD_BUG_ON_MSG(!__builtin_constant_p(_mask),          \
         |                 ^~~~~~~~~~~~~~~~
   include/linux/bitfield.h:155:17: note: in expansion of macro '__BF_FIELD_CHECK'
     155 |                 __BF_FIELD_CHECK(_mask, _reg, 0U, "FIELD_GET: ");       \
         |                 ^~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/ice/ice_ptp_hw.c:2529:16: note: in expansion of macro 'FIELD_GET'
    2529 |         high = FIELD_GET(P_REG_40B_HIGH_M, val);
         |                ^~~~~~~~~
   include/linux/bits.h:35:38: note: in expansion of macro '__GENMASK'
      35 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   drivers/net/ethernet/intel/ice/ice_ptp_hw.h:521:41: note: in expansion of macro 'GENMASK'
     521 | #define P_REG_40B_HIGH_M                GENMASK(39, 8)
         |                                         ^~~~~~~
   drivers/net/ethernet/intel/ice/ice_ptp_hw.c:2529:26: note: in expansion of macro 'P_REG_40B_HIGH_M'
    2529 |         high = FIELD_GET(P_REG_40B_HIGH_M, val);
         |                          ^~~~~~~~~~~~~~~~
   include/uapi/linux/bits.h:9:19: warning: right shift count is negative [-Wshift-count-negative]
       9 |          (~_UL(0) >> (__BITS_PER_LONG - 1 - (h))))
         |                   ^~
   include/linux/compiler_types.h:440:23: note: in definition of macro '__compiletime_assert'
     440 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:460:9: note: in expansion of macro '_compiletime_assert'
     460 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:67:17: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      67 |                 BUILD_BUG_ON_MSG((_mask) == 0, _pfx "mask is zero");    \
         |                 ^~~~~~~~~~~~~~~~
   include/linux/bitfield.h:155:17: note: in expansion of macro '__BF_FIELD_CHECK'
     155 |                 __BF_FIELD_CHECK(_mask, _reg, 0U, "FIELD_GET: ");       \
         |                 ^~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/ice/ice_ptp_hw.c:2529:16: note: in expansion of macro 'FIELD_GET'
    2529 |         high = FIELD_GET(P_REG_40B_HIGH_M, val);
         |                ^~~~~~~~~
   include/linux/bits.h:35:38: note: in expansion of macro '__GENMASK'
      35 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   drivers/net/ethernet/intel/ice/ice_ptp_hw.h:521:41: note: in expansion of macro 'GENMASK'
     521 | #define P_REG_40B_HIGH_M                GENMASK(39, 8)
         |                                         ^~~~~~~
   drivers/net/ethernet/intel/ice/ice_ptp_hw.c:2529:26: note: in expansion of macro 'P_REG_40B_HIGH_M'
    2529 |         high = FIELD_GET(P_REG_40B_HIGH_M, val);
         |                          ^~~~~~~~~~~~~~~~
   include/uapi/linux/bits.h:9:19: warning: right shift count is negative [-Wshift-count-negative]
       9 |          (~_UL(0) >> (__BITS_PER_LONG - 1 - (h))))
         |                   ^~
   include/linux/compiler_types.h:440:23: note: in definition of macro '__compiletime_assert'
     440 |                 if (!(condition))                                       \
         |                       ^~~~~~~~~
   include/linux/compiler_types.h:460:9: note: in expansion of macro '_compiletime_assert'
     460 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/bitfield.h:68:17: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      68 |                 BUILD_BUG_ON_MSG(__builtin_constant_p(_val) ?           \
         |                 ^~~~~~~~~~~~~~~~
   include/linux/bitfield.h:155:17: note: in expansion of macro '__BF_FIELD_CHECK'
     155 |                 __BF_FIELD_CHECK(_mask, _reg, 0U, "FIELD_GET: ");       \
         |                 ^~~~~~~~~~~~~~~~
   drivers/net/ethernet/intel/ice/ice_ptp_hw.c:2529:16: note: in expansion of macro 'FIELD_GET'
    2529 |         high = FIELD_GET(P_REG_40B_HIGH_M, val);
         |                ^~~~~~~~~
   include/linux/bits.h:35:38: note: in expansion of macro '__GENMASK'
      35 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   drivers/net/ethernet/intel/ice/ice_ptp_hw.h:521:41: note: in expansion of macro 'GENMASK'
     521 | #define P_REG_40B_HIGH_M                GENMASK(39, 8)
         |                                         ^~~~~~~
   drivers/net/ethernet/intel/ice/ice_ptp_hw.c:2529:26: note: in expansion of macro 'P_REG_40B_HIGH_M'
    2529 |         high = FIELD_GET(P_REG_40B_HIGH_M, val);
         |                          ^~~~~~~~~~~~~~~~
   include/uapi/linux/bits.h:9:19: warning: right shift count is negative [-Wshift-count-negative]
       9 |          (~_UL(0) >> (__BITS_PER_LONG - 1 - (h))))
         |                   ^~
   include/linux/compiler_types.h:440:23: note: in definition of macro '__compiletime_assert'


vim +1035 drivers/net/ethernet/intel/ice/ice_ptp_hw.c

  1010	
  1011	/**
  1012	 * ice_write_40b_phy_reg_eth56g - Write a 40b value to the PHY
  1013	 * @hw: pointer to the HW struct
  1014	 * @port: port to write to
  1015	 * @low_addr: offset of the low register
  1016	 * @val: 40b value to write
  1017	 * @res_type: resource type
  1018	 *
  1019	 * Check if the caller has specified a known 40 bit register offset and write
  1020	 * provided 40b value to the two associated registers by splitting it up into
  1021	 * two chunks, the lower 8 bits and the upper 32 bits.
  1022	 */
  1023	static int ice_write_40b_phy_reg_eth56g(struct ice_hw *hw, u8 port,
  1024						u16 low_addr, u64 val,
  1025						enum eth56g_res_type res_type)
  1026	{
  1027		u16 high_addr;
  1028		u32 lo, hi;
  1029		int err;
  1030	
  1031		if (!ice_is_40b_phy_reg_eth56g(low_addr, &high_addr))
  1032			return -EINVAL;
  1033	
  1034		lo = (u32)(val & P_REG_40B_LOW_M);
> 1035		hi = (u32)(val >> P_REG_40B_HIGH_S);
  1036	
  1037		err = ice_write_port_eth56g(hw, port, low_addr, lo, res_type);
  1038		if (err) {
  1039			ice_debug(hw, ICE_DBG_PTP, "Failed to write to low register 0x%08x\n, err %d",
  1040				  low_addr, err);
  1041			return err;
  1042		}
  1043	
  1044		err = ice_write_port_eth56g(hw, port, high_addr, hi, res_type);
  1045		if (err) {
  1046			ice_debug(hw, ICE_DBG_PTP, "Failed to write to high register 0x%08x\n, err %d",
  1047				  high_addr, err);
  1048			return err;
  1049		}
  1050	
  1051		return 0;
  1052	}
  1053	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

