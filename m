Return-Path: <netdev+bounces-232756-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE731C088F7
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 04:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6480E3B507D
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 02:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA69F246797;
	Sat, 25 Oct 2025 02:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FyySNbGf"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A797214A79;
	Sat, 25 Oct 2025 02:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761360046; cv=none; b=acUB4Ki0VDw9+KW+OO9YgTzKT3b0fY6oNl9cuP06aC/9Z+rVTEWPvGQ3gMMVjnNLHGXbjp+X7PejTTZJI5NjI4nce7fl1qHBkC2JNqBw2bDZXToCbBs8x93Rb8ptxYuv2s2nZdHrSnwXS9Gk4sWBSDC7TdehPF1LWhI3s1+xWeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761360046; c=relaxed/simple;
	bh=pkqZpQTw07IyRw14CjOHm2sj/zWG/xttdrIZjGNASak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pZsAFir0lys7E/05S7SPjtF6McW5BLYM1HPtNvyqskaxysrYHa3+Z2TfJc1khSBoQ4J6FQ2g5Zh34FAfmHZ4mx5XUF01wHMXAath40ogN1Aq31WqKOFGdDDWTt7RDn9c1goZP1ziQZaWX06fFUd19VRNU2mQfgXjZMQWDCYRk4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FyySNbGf; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761360045; x=1792896045;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pkqZpQTw07IyRw14CjOHm2sj/zWG/xttdrIZjGNASak=;
  b=FyySNbGffHQk/XH2u0B+XIi6isr87MOtB3Vjes4T3JOinTRyv2Sr4qC3
   hXx0TyV1JQJvVtgYJM3uQIG+1Gqt4Y6vPwuB9VAlPWYuHwvIMVs6P/ccI
   1/PekMi4YdsxP6KZKfD7njWraTb+qfoALk1+iAmT9Vx4e9IWwmofgX8lQ
   ZLB/jlcaCfZtig4z0nNWJJ5xxqttVqo38S9BaL7KueSfbooobNmdgx3ht
   FOO+KkeZDrY3BcBpPDqd4AwiyUrARo6Jz6XkOtpdzFVIiTz/TEwKdr4hz
   H8izKb18jfakv7dNq0jb669pSmZOrVApHnlXzRMEGmvxU8m02uPdWje49
   w==;
X-CSE-ConnectionGUID: o56SyHA6SXqvnZUiGv1aug==
X-CSE-MsgGUID: i2skOabyR0yDjgJKWIbV5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="67183073"
X-IronPort-AV: E=Sophos;i="6.19,254,1754982000"; 
   d="scan'208";a="67183073"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2025 19:40:44 -0700
X-CSE-ConnectionGUID: nX56QVeHRGSF1M94CCwtOA==
X-CSE-MsgGUID: 7KbtqPDQS6mKv7pUJRxwCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,254,1754982000"; 
   d="scan'208";a="183751346"
Received: from lkp-server02.sh.intel.com (HELO 66d7546c76b2) ([10.239.97.151])
  by orviesa006.jf.intel.com with ESMTP; 24 Oct 2025 19:40:41 -0700
Received: from kbuild by 66d7546c76b2 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1vCUCs-000F5N-1A;
	Sat, 25 Oct 2025 02:40:38 +0000
Date: Sat, 25 Oct 2025 10:39:35 +0800
From: kernel test robot <lkp@intel.com>
To: David Yang <mmyangfl@gmail.com>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/3] net: dsa: yt921x: Add STP/MST support
Message-ID: <202510251005.LlcQkR59-lkp@intel.com>
References: <20251024033237.1336249-2-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024033237.1336249-2-mmyangfl@gmail.com>

Hi David,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/David-Yang/net-dsa-yt921x-Add-STP-MST-support/20251024-113613
base:   net-next/main
patch link:    https://lore.kernel.org/r/20251024033237.1336249-2-mmyangfl%40gmail.com
patch subject: [PATCH net-next 1/3] net: dsa: yt921x: Add STP/MST support
config: arm-allmodconfig (https://download.01.org/0day-ci/archive/20251025/202510251005.LlcQkR59-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251025/202510251005.LlcQkR59-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202510251005.LlcQkR59-lkp@intel.com/

All errors (new ones prefixed by >>):

     115 |                 __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
         |                 ^~~~~~~~~~~~~~~~
   drivers/net/dsa/yt921x.h:342:57: note: in expansion of macro 'FIELD_PREP'
     342 | #define   YT921X_VLAN_CTRL_STP_ID(x)                    FIELD_PREP(YT921X_VLAN_CTRL_STP_ID_M, (x))
         |                                                         ^~~~~~~~~~
   include/linux/bits.h:51:33: note: in expansion of macro 'GENMASK_TYPE'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~
   drivers/net/dsa/yt921x.h:341:49: note: in expansion of macro 'GENMASK'
     341 | #define  YT921X_VLAN_CTRL_STP_ID_M              GENMASK(39, 36)
         |                                                 ^~~~~~~
   drivers/net/dsa/yt921x.h:342:68: note: in expansion of macro 'YT921X_VLAN_CTRL_STP_ID_M'
     342 | #define   YT921X_VLAN_CTRL_STP_ID(x)                    FIELD_PREP(YT921X_VLAN_CTRL_STP_ID_M, (x))
         |                                                                    ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/dsa/yt921x.c:2155:18: note: in expansion of macro 'YT921X_VLAN_CTRL_STP_ID'
    2155 |         ctrl64 = YT921X_VLAN_CTRL_STP_ID(msti->msti);
         |                  ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from arch/arm/include/asm/ptrace.h:13,
                    from arch/arm/include/asm/irqflags.h:7,
                    from include/linux/irqflags.h:18,
                    from arch/arm/include/asm/bitops.h:28,
                    from include/linux/bitops.h:67:
   include/linux/bits.h:48:27: warning: left shift count >= width of type [-Wshift-count-overflow]
      48 |              (type_max(t) << (l) &                              \
         |                           ^~
   include/linux/bitfield.h:45:38: note: in definition of macro '__bf_shf'
      45 | #define __bf_shf(x) (__builtin_ffsll(x) - 1)
         |                                      ^
   drivers/net/dsa/yt921x.h:342:57: note: in expansion of macro 'FIELD_PREP'
     342 | #define   YT921X_VLAN_CTRL_STP_ID(x)                    FIELD_PREP(YT921X_VLAN_CTRL_STP_ID_M, (x))
         |                                                         ^~~~~~~~~~
   include/linux/bits.h:51:33: note: in expansion of macro 'GENMASK_TYPE'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~
   drivers/net/dsa/yt921x.h:341:49: note: in expansion of macro 'GENMASK'
     341 | #define  YT921X_VLAN_CTRL_STP_ID_M              GENMASK(39, 36)
         |                                                 ^~~~~~~
   drivers/net/dsa/yt921x.h:342:68: note: in expansion of macro 'YT921X_VLAN_CTRL_STP_ID_M'
     342 | #define   YT921X_VLAN_CTRL_STP_ID(x)                    FIELD_PREP(YT921X_VLAN_CTRL_STP_ID_M, (x))
         |                                                                    ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/dsa/yt921x.c:2155:18: note: in expansion of macro 'YT921X_VLAN_CTRL_STP_ID'
    2155 |         ctrl64 = YT921X_VLAN_CTRL_STP_ID(msti->msti);
         |                  ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bits.h:49:27: warning: right shift count >= width of type [-Wshift-count-overflow]
      49 |               type_max(t) >> (BITS_PER_TYPE(t) - 1 - (h)))))
         |                           ^~
   include/linux/bitfield.h:45:38: note: in definition of macro '__bf_shf'
      45 | #define __bf_shf(x) (__builtin_ffsll(x) - 1)
         |                                      ^
   drivers/net/dsa/yt921x.h:342:57: note: in expansion of macro 'FIELD_PREP'
     342 | #define   YT921X_VLAN_CTRL_STP_ID(x)                    FIELD_PREP(YT921X_VLAN_CTRL_STP_ID_M, (x))
         |                                                         ^~~~~~~~~~
   include/linux/bits.h:51:33: note: in expansion of macro 'GENMASK_TYPE'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~
   drivers/net/dsa/yt921x.h:341:49: note: in expansion of macro 'GENMASK'
     341 | #define  YT921X_VLAN_CTRL_STP_ID_M              GENMASK(39, 36)
         |                                                 ^~~~~~~
   drivers/net/dsa/yt921x.h:342:68: note: in expansion of macro 'YT921X_VLAN_CTRL_STP_ID_M'
     342 | #define   YT921X_VLAN_CTRL_STP_ID(x)                    FIELD_PREP(YT921X_VLAN_CTRL_STP_ID_M, (x))
         |                                                                    ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/dsa/yt921x.c:2155:18: note: in expansion of macro 'YT921X_VLAN_CTRL_STP_ID'
    2155 |         ctrl64 = YT921X_VLAN_CTRL_STP_ID(msti->msti);
         |                  ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bits.h:48:27: warning: left shift count >= width of type [-Wshift-count-overflow]
      48 |              (type_max(t) << (l) &                              \
         |                           ^~
   include/linux/bitfield.h:116:63: note: in definition of macro 'FIELD_PREP'
     116 |                 ((typeof(_mask))(_val) << __bf_shf(_mask)) & (_mask);   \
         |                                                               ^~~~~
   include/linux/bits.h:51:33: note: in expansion of macro 'GENMASK_TYPE'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~
   drivers/net/dsa/yt921x.h:341:49: note: in expansion of macro 'GENMASK'
     341 | #define  YT921X_VLAN_CTRL_STP_ID_M              GENMASK(39, 36)
         |                                                 ^~~~~~~
   drivers/net/dsa/yt921x.h:342:68: note: in expansion of macro 'YT921X_VLAN_CTRL_STP_ID_M'
     342 | #define   YT921X_VLAN_CTRL_STP_ID(x)                    FIELD_PREP(YT921X_VLAN_CTRL_STP_ID_M, (x))
         |                                                                    ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/dsa/yt921x.c:2155:18: note: in expansion of macro 'YT921X_VLAN_CTRL_STP_ID'
    2155 |         ctrl64 = YT921X_VLAN_CTRL_STP_ID(msti->msti);
         |                  ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bits.h:49:27: warning: right shift count >= width of type [-Wshift-count-overflow]
      49 |               type_max(t) >> (BITS_PER_TYPE(t) - 1 - (h)))))
         |                           ^~
   include/linux/bitfield.h:116:63: note: in definition of macro 'FIELD_PREP'
     116 |                 ((typeof(_mask))(_val) << __bf_shf(_mask)) & (_mask);   \
         |                                                               ^~~~~
   include/linux/bits.h:51:33: note: in expansion of macro 'GENMASK_TYPE'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~
   drivers/net/dsa/yt921x.h:341:49: note: in expansion of macro 'GENMASK'
     341 | #define  YT921X_VLAN_CTRL_STP_ID_M              GENMASK(39, 36)
         |                                                 ^~~~~~~
   drivers/net/dsa/yt921x.h:342:68: note: in expansion of macro 'YT921X_VLAN_CTRL_STP_ID_M'
     342 | #define   YT921X_VLAN_CTRL_STP_ID(x)                    FIELD_PREP(YT921X_VLAN_CTRL_STP_ID_M, (x))
         |                                                                    ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/dsa/yt921x.c:2155:18: note: in expansion of macro 'YT921X_VLAN_CTRL_STP_ID'
    2155 |         ctrl64 = YT921X_VLAN_CTRL_STP_ID(msti->msti);
         |                  ^~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/compiler_types.h:597:45: error: call to '__compiletime_assert_1178' declared with attribute error: FIELD_PREP: mask is not constant
     597 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                             ^
   include/linux/compiler_types.h:578:25: note: in definition of macro '__compiletime_assert'
     578 |                         prefix ## suffix();                             \
         |                         ^~~~~~
   include/linux/compiler_types.h:597:9: note: in expansion of macro '_compiletime_assert'
     597 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
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
   drivers/net/dsa/yt921x.h:342:57: note: in expansion of macro 'FIELD_PREP'
     342 | #define   YT921X_VLAN_CTRL_STP_ID(x)                    FIELD_PREP(YT921X_VLAN_CTRL_STP_ID_M, (x))
         |                                                         ^~~~~~~~~~
   drivers/net/dsa/yt921x.c:2155:18: note: in expansion of macro 'YT921X_VLAN_CTRL_STP_ID'
    2155 |         ctrl64 = YT921X_VLAN_CTRL_STP_ID(msti->msti);
         |                  ^~~~~~~~~~~~~~~~~~~~~~~
--
     115 |                 __BF_FIELD_CHECK(_mask, 0ULL, _val, "FIELD_PREP: ");    \
         |                 ^~~~~~~~~~~~~~~~
   yt921x.h:342:57: note: in expansion of macro 'FIELD_PREP'
     342 | #define   YT921X_VLAN_CTRL_STP_ID(x)                    FIELD_PREP(YT921X_VLAN_CTRL_STP_ID_M, (x))
         |                                                         ^~~~~~~~~~
   include/linux/bits.h:51:33: note: in expansion of macro 'GENMASK_TYPE'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~
   yt921x.h:341:49: note: in expansion of macro 'GENMASK'
     341 | #define  YT921X_VLAN_CTRL_STP_ID_M              GENMASK(39, 36)
         |                                                 ^~~~~~~
   yt921x.h:342:68: note: in expansion of macro 'YT921X_VLAN_CTRL_STP_ID_M'
     342 | #define   YT921X_VLAN_CTRL_STP_ID(x)                    FIELD_PREP(YT921X_VLAN_CTRL_STP_ID_M, (x))
         |                                                                    ^~~~~~~~~~~~~~~~~~~~~~~~~
   yt921x.c:2155:18: note: in expansion of macro 'YT921X_VLAN_CTRL_STP_ID'
    2155 |         ctrl64 = YT921X_VLAN_CTRL_STP_ID(msti->msti);
         |                  ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from arch/arm/include/asm/ptrace.h:13,
                    from arch/arm/include/asm/irqflags.h:7,
                    from include/linux/irqflags.h:18,
                    from arch/arm/include/asm/bitops.h:28,
                    from include/linux/bitops.h:67:
   include/linux/bits.h:48:27: warning: left shift count >= width of type [-Wshift-count-overflow]
      48 |              (type_max(t) << (l) &                              \
         |                           ^~
   include/linux/bitfield.h:45:38: note: in definition of macro '__bf_shf'
      45 | #define __bf_shf(x) (__builtin_ffsll(x) - 1)
         |                                      ^
   yt921x.h:342:57: note: in expansion of macro 'FIELD_PREP'
     342 | #define   YT921X_VLAN_CTRL_STP_ID(x)                    FIELD_PREP(YT921X_VLAN_CTRL_STP_ID_M, (x))
         |                                                         ^~~~~~~~~~
   include/linux/bits.h:51:33: note: in expansion of macro 'GENMASK_TYPE'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~
   yt921x.h:341:49: note: in expansion of macro 'GENMASK'
     341 | #define  YT921X_VLAN_CTRL_STP_ID_M              GENMASK(39, 36)
         |                                                 ^~~~~~~
   yt921x.h:342:68: note: in expansion of macro 'YT921X_VLAN_CTRL_STP_ID_M'
     342 | #define   YT921X_VLAN_CTRL_STP_ID(x)                    FIELD_PREP(YT921X_VLAN_CTRL_STP_ID_M, (x))
         |                                                                    ^~~~~~~~~~~~~~~~~~~~~~~~~
   yt921x.c:2155:18: note: in expansion of macro 'YT921X_VLAN_CTRL_STP_ID'
    2155 |         ctrl64 = YT921X_VLAN_CTRL_STP_ID(msti->msti);
         |                  ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bits.h:49:27: warning: right shift count >= width of type [-Wshift-count-overflow]
      49 |               type_max(t) >> (BITS_PER_TYPE(t) - 1 - (h)))))
         |                           ^~
   include/linux/bitfield.h:45:38: note: in definition of macro '__bf_shf'
      45 | #define __bf_shf(x) (__builtin_ffsll(x) - 1)
         |                                      ^
   yt921x.h:342:57: note: in expansion of macro 'FIELD_PREP'
     342 | #define   YT921X_VLAN_CTRL_STP_ID(x)                    FIELD_PREP(YT921X_VLAN_CTRL_STP_ID_M, (x))
         |                                                         ^~~~~~~~~~
   include/linux/bits.h:51:33: note: in expansion of macro 'GENMASK_TYPE'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~
   yt921x.h:341:49: note: in expansion of macro 'GENMASK'
     341 | #define  YT921X_VLAN_CTRL_STP_ID_M              GENMASK(39, 36)
         |                                                 ^~~~~~~
   yt921x.h:342:68: note: in expansion of macro 'YT921X_VLAN_CTRL_STP_ID_M'
     342 | #define   YT921X_VLAN_CTRL_STP_ID(x)                    FIELD_PREP(YT921X_VLAN_CTRL_STP_ID_M, (x))
         |                                                                    ^~~~~~~~~~~~~~~~~~~~~~~~~
   yt921x.c:2155:18: note: in expansion of macro 'YT921X_VLAN_CTRL_STP_ID'
    2155 |         ctrl64 = YT921X_VLAN_CTRL_STP_ID(msti->msti);
         |                  ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bits.h:48:27: warning: left shift count >= width of type [-Wshift-count-overflow]
      48 |              (type_max(t) << (l) &                              \
         |                           ^~
   include/linux/bitfield.h:116:63: note: in definition of macro 'FIELD_PREP'
     116 |                 ((typeof(_mask))(_val) << __bf_shf(_mask)) & (_mask);   \
         |                                                               ^~~~~
   include/linux/bits.h:51:33: note: in expansion of macro 'GENMASK_TYPE'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~
   yt921x.h:341:49: note: in expansion of macro 'GENMASK'
     341 | #define  YT921X_VLAN_CTRL_STP_ID_M              GENMASK(39, 36)
         |                                                 ^~~~~~~
   yt921x.h:342:68: note: in expansion of macro 'YT921X_VLAN_CTRL_STP_ID_M'
     342 | #define   YT921X_VLAN_CTRL_STP_ID(x)                    FIELD_PREP(YT921X_VLAN_CTRL_STP_ID_M, (x))
         |                                                                    ^~~~~~~~~~~~~~~~~~~~~~~~~
   yt921x.c:2155:18: note: in expansion of macro 'YT921X_VLAN_CTRL_STP_ID'
    2155 |         ctrl64 = YT921X_VLAN_CTRL_STP_ID(msti->msti);
         |                  ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/bits.h:49:27: warning: right shift count >= width of type [-Wshift-count-overflow]
      49 |               type_max(t) >> (BITS_PER_TYPE(t) - 1 - (h)))))
         |                           ^~
   include/linux/bitfield.h:116:63: note: in definition of macro 'FIELD_PREP'
     116 |                 ((typeof(_mask))(_val) << __bf_shf(_mask)) & (_mask);   \
         |                                                               ^~~~~
   include/linux/bits.h:51:33: note: in expansion of macro 'GENMASK_TYPE'
      51 | #define GENMASK(h, l)           GENMASK_TYPE(unsigned long, h, l)
         |                                 ^~~~~~~~~~~~
   yt921x.h:341:49: note: in expansion of macro 'GENMASK'
     341 | #define  YT921X_VLAN_CTRL_STP_ID_M              GENMASK(39, 36)
         |                                                 ^~~~~~~
   yt921x.h:342:68: note: in expansion of macro 'YT921X_VLAN_CTRL_STP_ID_M'
     342 | #define   YT921X_VLAN_CTRL_STP_ID(x)                    FIELD_PREP(YT921X_VLAN_CTRL_STP_ID_M, (x))
         |                                                                    ^~~~~~~~~~~~~~~~~~~~~~~~~
   yt921x.c:2155:18: note: in expansion of macro 'YT921X_VLAN_CTRL_STP_ID'
    2155 |         ctrl64 = YT921X_VLAN_CTRL_STP_ID(msti->msti);
         |                  ^~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/compiler_types.h:597:45: error: call to '__compiletime_assert_1178' declared with attribute error: FIELD_PREP: mask is not constant
     597 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                             ^
   include/linux/compiler_types.h:578:25: note: in definition of macro '__compiletime_assert'
     578 |                         prefix ## suffix();                             \
         |                         ^~~~~~
   include/linux/compiler_types.h:597:9: note: in expansion of macro '_compiletime_assert'
     597 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
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
   yt921x.h:342:57: note: in expansion of macro 'FIELD_PREP'
     342 | #define   YT921X_VLAN_CTRL_STP_ID(x)                    FIELD_PREP(YT921X_VLAN_CTRL_STP_ID_M, (x))
         |                                                         ^~~~~~~~~~
   yt921x.c:2155:18: note: in expansion of macro 'YT921X_VLAN_CTRL_STP_ID'
    2155 |         ctrl64 = YT921X_VLAN_CTRL_STP_ID(msti->msti);
         |                  ^~~~~~~~~~~~~~~~~~~~~~~


vim +/__compiletime_assert_1178 +597 include/linux/compiler_types.h

eb5c2d4b45e3d2 Will Deacon 2020-07-21  583  
eb5c2d4b45e3d2 Will Deacon 2020-07-21  584  #define _compiletime_assert(condition, msg, prefix, suffix) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21  585  	__compiletime_assert(condition, msg, prefix, suffix)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  586  
eb5c2d4b45e3d2 Will Deacon 2020-07-21  587  /**
eb5c2d4b45e3d2 Will Deacon 2020-07-21  588   * compiletime_assert - break build and emit msg if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  589   * @condition: a compile-time constant condition to check
eb5c2d4b45e3d2 Will Deacon 2020-07-21  590   * @msg:       a message to emit if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  591   *
eb5c2d4b45e3d2 Will Deacon 2020-07-21  592   * In tradition of POSIX assert, this macro will break the build if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  593   * supplied condition is *false*, emitting the supplied error message if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  594   * compiler has support to do so.
eb5c2d4b45e3d2 Will Deacon 2020-07-21  595   */
eb5c2d4b45e3d2 Will Deacon 2020-07-21  596  #define compiletime_assert(condition, msg) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21 @597  	_compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  598  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

