Return-Path: <netdev+bounces-157400-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 898AEA0A267
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 10:49:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E2AB3A2DA4
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 09:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B64C18E743;
	Sat, 11 Jan 2025 09:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FV+LnLt6"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3581F18A931;
	Sat, 11 Jan 2025 09:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736588973; cv=none; b=YNwH+0adhr8zAqIDzXRTenANr3o8mHc9RfCNG8RP1LMTaeB/S7dv+ImgMJL7AXBvbxlW3KcDMX3XCmkajrbOqjv88qPoQn7xoih0HheVx3khFVjptKXpKwqRNjhxDRB9y7KihCPYxtcOH2Iq4nG1YUnheIOQVS5YMiOXAetfQLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736588973; c=relaxed/simple;
	bh=fJneAG2e2IjqcWED90SuaOpGkKAmPjMZPoMSb92OI7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RYrzlcjxMWJhNEYJVQoyDVAV5mWoPYdcI5uFtAWS/fBf0D3BjpdinkWt9nKGNx1XnLpnrWJUPvM+g7/XLlZdbDeNUGYCdvi315+4KK9SGO2I7cRrUz1qZWIaU/iP10yF3ZnGuc9UytWC6WRdE5EHggghv5m+TBlSB03LC5OHmCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FV+LnLt6; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736588973; x=1768124973;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fJneAG2e2IjqcWED90SuaOpGkKAmPjMZPoMSb92OI7I=;
  b=FV+LnLt698HZdvL0awOde+jXItmWtqj+bX8tVlhvzjWbY2uxIMFelbic
   AefFjUUYdB28lWmkZVbcCH0jGxzsbda0crFiCY6e9czCUs7UgtoQ1Fuuu
   p/FvdwSuQOXGs5QwX+LTyaGvOsJD7n3IU0n1jncoNjxw54bDQz7z6mQZh
   RV/fh6A9Kbt8DH3JAfj4O2ftmdTltjuUcItAwtsx+TIxTRxNTHw71lupJ
   K+GwQTC+hd7+Co1LcG/mDt597inoBST8nVTl5v6WAhRIfKaqz0PHRbx12
   HaHo9J6CO5HMXAyHfsG4NU6PI4relTyoCrBLjgwoR9StSBCq0BGgK9NuI
   w==;
X-CSE-ConnectionGUID: sbYoViubT3ysNSFH6mtfxA==
X-CSE-MsgGUID: Hr+Tn9SvRla5e9dO5KCMEg==
X-IronPort-AV: E=McAfee;i="6700,10204,11311"; a="40646920"
X-IronPort-AV: E=Sophos;i="6.12,306,1728975600"; 
   d="scan'208";a="40646920"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2025 01:49:30 -0800
X-CSE-ConnectionGUID: 8yBD54+gSJ2eZrN1HyEkig==
X-CSE-MsgGUID: 14ORSzlgSyahUj2kOy/9Tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,306,1728975600"; 
   d="scan'208";a="103766866"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa006.fm.intel.com with ESMTP; 11 Jan 2025 01:49:26 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tWY7Q-000KSP-0u;
	Sat, 11 Jan 2025 09:49:24 +0000
Date: Sat, 11 Jan 2025 17:48:58 +0800
From: kernel test robot <lkp@intel.com>
To: Heiner Kallweit <hkallweit1@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
	Russell King - ARM Linux <linux@armlinux.org.uk>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org,
	"linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Jean Delvare <jdelvare@suse.com>
Subject: Re: [PATCH net-next 3/3] net: phy: realtek: add hwmon support for
 temp sensor on RTL822x
Message-ID: <202501111711.i1W0TGwl-lkp@intel.com>
References: <dbfeb139-808f-4345-afe8-830b7f4da26a@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dbfeb139-808f-4345-afe8-830b7f4da26a@gmail.com>

Hi Heiner,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Heiner-Kallweit/net-phy-realtek-add-support-for-reading-MDIO_MMD_VEND2-regs-on-RTL8125-RTL8126/20250110-195043
base:   net-next/main
patch link:    https://lore.kernel.org/r/dbfeb139-808f-4345-afe8-830b7f4da26a%40gmail.com
patch subject: [PATCH net-next 3/3] net: phy: realtek: add hwmon support for temp sensor on RTL822x
config: i386-randconfig-013-20250111 (https://download.01.org/0day-ci/archive/20250111/202501111711.i1W0TGwl-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250111/202501111711.i1W0TGwl-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202501111711.i1W0TGwl-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/net/phy/realtek_hwmon.c:3:4: error: type specifier missing, defaults to 'int'; ISO C99 and later do not support implicit int [-Wimplicit-int]
       2 |  *
         |  int
       3 |  * HWMON support for Realtek PHY's
         |    ^
>> drivers/net/phy/realtek_hwmon.c:3:9: error: expected ';' after top level declarator
       3 |  * HWMON support for Realtek PHY's
         |         ^
         |         ;
   drivers/net/phy/realtek_hwmon.c:3:33: warning: missing terminating ' character [-Winvalid-pp-token]
       3 |  * HWMON support for Realtek PHY's
         |                                 ^
   In file included from drivers/net/phy/realtek_hwmon.c:8:
   In file included from include/linux/hwmon.h:15:
   In file included from include/linux/bitops.h:5:
   In file included from ./arch/x86/include/generated/uapi/asm/types.h:1:
   In file included from include/uapi/asm-generic/types.h:7:
   include/asm-generic/int-ll64.h:16:9: error: unknown type name '__s8'; did you mean '__u8'?
      16 | typedef __s8  s8;
         |         ^~~~
         |         __u8
   include/uapi/asm-generic/int-ll64.h:21:23: note: '__u8' declared here
      21 | typedef unsigned char __u8;
         |                       ^
   In file included from drivers/net/phy/realtek_hwmon.c:9:
   In file included from include/linux/phy.h:15:
   In file included from include/linux/spinlock.h:60:
   In file included from include/linux/thread_info.h:60:
   In file included from arch/x86/include/asm/thread_info.h:59:
   In file included from arch/x86/include/asm/cpufeature.h:5:
   In file included from arch/x86/include/asm/processor.h:35:
   In file included from include/linux/math64.h:6:
   include/linux/math.h:115:1: error: unknown type name '__s8'; did you mean '__u8'?
     115 | __STRUCT_FRACT(s8)
         | ^
   include/linux/math.h:112:2: note: expanded from macro '__STRUCT_FRACT'
     112 |         __##type numerator;                             \
         |         ^
   <scratch space>:221:1: note: expanded from here
     221 | __s8
         | ^
   include/uapi/asm-generic/int-ll64.h:21:23: note: '__u8' declared here
      21 | typedef unsigned char __u8;
         |                       ^
   In file included from drivers/net/phy/realtek_hwmon.c:9:
   In file included from include/linux/phy.h:15:
   In file included from include/linux/spinlock.h:60:
   In file included from include/linux/thread_info.h:60:
   In file included from arch/x86/include/asm/thread_info.h:59:
   In file included from arch/x86/include/asm/cpufeature.h:5:
   In file included from arch/x86/include/asm/processor.h:35:
   In file included from include/linux/math64.h:6:
   include/linux/math.h:115:1: error: unknown type name '__s8'; did you mean '__u8'?
     115 | __STRUCT_FRACT(s8)
         | ^
   include/linux/math.h:113:2: note: expanded from macro '__STRUCT_FRACT'
     113 |         __##type denominator;                           \
         |         ^
   <scratch space>:222:1: note: expanded from here
     222 | __s8
         | ^
   include/uapi/asm-generic/int-ll64.h:21:23: note: '__u8' declared here
      21 | typedef unsigned char __u8;
         |                       ^
   In file included from drivers/net/phy/realtek_hwmon.c:9:
   In file included from include/linux/phy.h:16:
   In file included from include/linux/ethtool.h:17:
   In file included from include/linux/compat.h:17:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:98:11: warning: array index 3 is past the end of the array (that has type 'unsigned long[2]') [-Warray-bounds]
      98 |                 return (set->sig[3] | set->sig[2] |
         |                         ^        ~
   arch/x86/include/asm/signal.h:24:2: note: array 'sig' declared here
      24 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from drivers/net/phy/realtek_hwmon.c:9:
   In file included from include/linux/phy.h:16:
   In file included from include/linux/ethtool.h:17:
   In file included from include/linux/compat.h:17:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:98:25: warning: array index 2 is past the end of the array (that has type 'unsigned long[2]') [-Warray-bounds]
      98 |                 return (set->sig[3] | set->sig[2] |
         |                                       ^        ~
   arch/x86/include/asm/signal.h:24:2: note: array 'sig' declared here
      24 |         unsigned long sig[_NSIG_WORDS];
         |         ^
   In file included from drivers/net/phy/realtek_hwmon.c:9:
   In file included from include/linux/phy.h:16:
   In file included from include/linux/ethtool.h:17:
   In file included from include/linux/compat.h:17:
   In file included from include/linux/fs.h:33:
   In file included from include/linux/percpu-rwsem.h:7:
   In file included from include/linux/rcuwait.h:6:
   In file included from include/linux/sched/signal.h:6:
   include/linux/signal.h:114:11: warning: array index 3 is past the end of the array (that has type 'const unsigned long[2]') [-Warray-bounds]
     114 |                 return  (set1->sig[3] == set2->sig[3]) &&
         |                          ^         ~
   arch/x86/include/asm/signal.h:24:2: note: array 'sig' declared here
      24 |         unsigned long sig[_NSIG_WORDS];
         |         ^


vim +/int +3 drivers/net/phy/realtek_hwmon.c

   > 3	 * HWMON support for Realtek PHY's
     4	 *
     5	 * Author: Heiner Kallweit <hkallweit1@gmail.com>
     6	 */
     7	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

