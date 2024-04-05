Return-Path: <netdev+bounces-85263-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB422899EDF
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 15:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42201282BB6
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 13:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8CE916D9BB;
	Fri,  5 Apr 2024 13:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FpvTrxqY"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8227016D4D2
	for <netdev@vger.kernel.org>; Fri,  5 Apr 2024 13:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712325594; cv=none; b=tipfGuZyxJhamGutM1kJQTpaTq4ogyjO5eZlKTa8HZlksXY3IhYoK+wMQhYno9/KibX/M9qZYfby7QyXg0HRqrKIDUBvoBLQ3e49M2/80UULvKkjNKxK95IIibep6xLoxa5MRUkmkLR717qw0He+YFQjJhkkpnVVaYfMlD0i9W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712325594; c=relaxed/simple;
	bh=F85+f1rlvH5QrZHeUd9aBhK9Uht+YIMvPImsvnkMVnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Byh1y7KVCcHAxPJs79t5i3H4ZMRym5m0QEv0GHaVeO+iJp/SZE2mw+Tq8d1xhxagGPBlBvQiiI68+4yah9UdOFcwmZrPh2wwZrDPmQvT2yyh0RP5jkWuv9xRS+0B16+b2awYHm1zX/UffX+7raI36Q+cUo+MebaKm/6FaMNGbx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FpvTrxqY; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712325592; x=1743861592;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=F85+f1rlvH5QrZHeUd9aBhK9Uht+YIMvPImsvnkMVnE=;
  b=FpvTrxqYDU7KcGvgzf5Z6LzptjauurHUODu/oTRsZjExx3KsdNxrhLMZ
   4nj73TOnjLvvf2UCCjLZdATQeLSuVXRAksCLNP9/tGjCvSmx5wRAmQbsQ
   j55oYC/XMbUS2JT3y0zuiHfwFaarFZqZrnrj/S/dpyEpDJoyv8q4oNtJO
   r5YX3wD6udrR5lOD+px2epUVaVYz9mLJmPjgaLhF1q+dQL/t01LuFRb7Z
   xD+zrVbZZ/FseplVgNQjy0kECsP8++/Muu8sma3r/O144giCU/QLfpuLZ
   z8eGtL7BQy7a7A2lkr1BcxcEg/7A/2tphPeOnXfdqtIU6dIlImRaZXc7E
   w==;
X-CSE-ConnectionGUID: 84dcbuujQzyQDFJhylUoTQ==
X-CSE-MsgGUID: upwlCxInRXyK967WoGpPAg==
X-IronPort-AV: E=McAfee;i="6600,9927,11035"; a="10625019"
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="10625019"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2024 06:59:51 -0700
X-CSE-ConnectionGUID: BwDrBxxWQ82yQRx8HnmAug==
X-CSE-MsgGUID: VtAYIJv0QNmKeaVe/X/lwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,181,1708416000"; 
   d="scan'208";a="19194085"
Received: from lkp-server01.sh.intel.com (HELO e61807b1d151) ([10.239.97.150])
  by fmviesa009.fm.intel.com with ESMTP; 05 Apr 2024 06:59:48 -0700
Received: from kbuild by e61807b1d151 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rsk6c-0002LC-0U;
	Fri, 05 Apr 2024 13:59:46 +0000
Date: Fri, 5 Apr 2024 21:58:56 +0800
From: kernel test robot <lkp@intel.com>
To: Karol Kolacinski <karol.kolacinski@intel.com>,
	intel-wired-lan@lists.osuosl.org
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, jesse.brandeburg@intel.com,
	Sergey Temerkhanov <sergey.temerkhanov@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Karol Kolacinski <karol.kolacinski@intel.com>
Subject: Re: [PATCH v6 iwl-next 05/12] ice: Move CGU block
Message-ID: <202404052136.o9Cbreqn-lkp@intel.com>
References: <20240405100648.144756-19-karol.kolacinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405100648.144756-19-karol.kolacinski@intel.com>

Hi Karol,

kernel test robot noticed the following build warnings:

[auto build test WARNING on 0a3074e5b4b523fb60f4ae9fb32bb180ea1fb6ef]

url:    https://github.com/intel-lab-lkp/linux/commits/Karol-Kolacinski/ice-Introduce-ice_ptp_hw-struct/20240405-180941
base:   0a3074e5b4b523fb60f4ae9fb32bb180ea1fb6ef
patch link:    https://lore.kernel.org/r/20240405100648.144756-19-karol.kolacinski%40intel.com
patch subject: [PATCH v6 iwl-next 05/12] ice: Move CGU block
config: i386-allmodconfig (https://download.01.org/0day-ci/archive/20240405/202404052136.o9Cbreqn-lkp@intel.com/config)
compiler: gcc-13 (Ubuntu 13.2.0-4ubuntu3) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240405/202404052136.o9Cbreqn-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202404052136.o9Cbreqn-lkp@intel.com/

All warnings (new ones prefixed by >>):

   drivers/net/ethernet/intel/ice/ice_ptp_hw.c: In function 'ice_read_cgu_reg_e82x':
>> drivers/net/ethernet/intel/ice/ice_ptp_hw.c:244:25: warning: initialization of 'unsigned int' from 'u32 *' {aka 'unsigned int *'} makes integer from pointer without a cast [-Wint-conversion]
     244 |                 .data = val
         |                         ^~~
   drivers/net/ethernet/intel/ice/ice_ptp_hw.c:244:25: note: (near initialization for 'cgu_msg.data')
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
   drivers/net/ethernet/intel/ice/ice_ptp_hw.c:908:16: note: in expansion of macro 'FIELD_GET'
     908 |         high = FIELD_GET(P_REG_40B_HIGH_M, val);
         |                ^~~~~~~~~
   include/linux/bits.h:35:38: note: in expansion of macro '__GENMASK'
      35 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   drivers/net/ethernet/intel/ice/ice_ptp_hw.h:381:41: note: in expansion of macro 'GENMASK'
     381 | #define P_REG_40B_HIGH_M                GENMASK(39, 8)
         |                                         ^~~~~~~
   drivers/net/ethernet/intel/ice/ice_ptp_hw.c:908:26: note: in expansion of macro 'P_REG_40B_HIGH_M'
     908 |         high = FIELD_GET(P_REG_40B_HIGH_M, val);
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
   drivers/net/ethernet/intel/ice/ice_ptp_hw.c:908:16: note: in expansion of macro 'FIELD_GET'
     908 |         high = FIELD_GET(P_REG_40B_HIGH_M, val);
         |                ^~~~~~~~~
   include/linux/bits.h:35:38: note: in expansion of macro '__GENMASK'
      35 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   drivers/net/ethernet/intel/ice/ice_ptp_hw.h:381:41: note: in expansion of macro 'GENMASK'
     381 | #define P_REG_40B_HIGH_M                GENMASK(39, 8)
         |                                         ^~~~~~~
   drivers/net/ethernet/intel/ice/ice_ptp_hw.c:908:26: note: in expansion of macro 'P_REG_40B_HIGH_M'
     908 |         high = FIELD_GET(P_REG_40B_HIGH_M, val);
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
   drivers/net/ethernet/intel/ice/ice_ptp_hw.c:908:16: note: in expansion of macro 'FIELD_GET'
     908 |         high = FIELD_GET(P_REG_40B_HIGH_M, val);
         |                ^~~~~~~~~
   include/linux/bits.h:35:38: note: in expansion of macro '__GENMASK'
      35 |         (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
         |                                      ^~~~~~~~~
   drivers/net/ethernet/intel/ice/ice_ptp_hw.h:381:41: note: in expansion of macro 'GENMASK'
     381 | #define P_REG_40B_HIGH_M                GENMASK(39, 8)
         |                                         ^~~~~~~
   drivers/net/ethernet/intel/ice/ice_ptp_hw.c:908:26: note: in expansion of macro 'P_REG_40B_HIGH_M'
     908 |         high = FIELD_GET(P_REG_40B_HIGH_M, val);
         |                          ^~~~~~~~~~~~~~~~
   include/uapi/linux/bits.h:9:19: warning: right shift count is negative [-Wshift-count-negative]
       9 |          (~_UL(0) >> (__BITS_PER_LONG - 1 - (h))))
         |                   ^~
   include/linux/compiler_types.h:440:23: note: in definition of macro '__compiletime_assert'
     440 |                 if (!(condition))                                       \


vim +244 drivers/net/ethernet/intel/ice/ice_ptp_hw.c

   228	
   229	/**
   230	 * ice_read_cgu_reg_e82x - Read a CGU register
   231	 * @hw: pointer to the HW struct
   232	 * @addr: Register address to read
   233	 * @val: storage for register value read
   234	 *
   235	 * Read the contents of a register of the Clock Generation Unit. Only
   236	 * applicable to E822 devices.
   237	 */
   238	static int ice_read_cgu_reg_e82x(struct ice_hw *hw, u32 addr, u32 *val)
   239	{
   240		struct ice_sbq_msg_input cgu_msg = {
   241			.opcode = ice_sbq_msg_rd,
   242			.dest_dev = cgu,
   243			.msg_addr_low = addr,
 > 244			.data = val
   245		};
   246		int err;
   247	
   248		cgu_msg.opcode = ice_sbq_msg_rd;
   249		cgu_msg.dest_dev = cgu;
   250		cgu_msg.msg_addr_low = addr;
   251		cgu_msg.msg_addr_high = 0x0;
   252	
   253		err = ice_sbq_rw_reg(hw, &cgu_msg);
   254		if (err) {
   255			ice_debug(hw, ICE_DBG_PTP, "Failed to read CGU register 0x%04x, err %d\n",
   256				  addr, err);
   257			return err;
   258		}
   259	
   260		*val = cgu_msg.data;
   261	
   262		return 0;
   263	}
   264	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

