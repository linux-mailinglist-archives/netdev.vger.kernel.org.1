Return-Path: <netdev+bounces-70234-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4521F84E1E1
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 14:22:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F105C288084
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 13:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD10762F0;
	Thu,  8 Feb 2024 13:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Of+4BTad"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C757762C2
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 13:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707398446; cv=none; b=sOyurAwSGbHL4YYv6MSxRAhgqrU1vVdfh7E4UoBGjxxZfRwfJEGc0Qkg6wqbvRlTnly7prmA3tVliqmAc6S6aDg5ORH+QqK5uuR3fAxexNbjHcsrSPGDme13LEKqTwW+waSGd+Cre/4+U10VwlapGOIrYmDpdoIvltbKA/HwYc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707398446; c=relaxed/simple;
	bh=98h4qz1FtliwlpqSUSdEUzH961R62fBZSaXdQbTvJo0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IPYSKj0W+t4zJ3Yu/vRlJC8Vw4+q+ZyZd75nqm0fpUyALMYPgSwVgsNSp3aqZjgjLs6p4wtULfhMQ/fqZKhQklnEdaqiFyUSG8fXi6zQiAzR/QpIUPTtxrGRKyP6KSzT/ODpMU8h46u4VDG5b380B1m6Z1/WH8RE7c5/BJS+tp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Of+4BTad; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707398444; x=1738934444;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=98h4qz1FtliwlpqSUSdEUzH961R62fBZSaXdQbTvJo0=;
  b=Of+4BTadFr5vsn7ja/ME5TLYcwFM19YMkYiRvV/XZrGYb2IVTWeQewLw
   qtd+pCK9sS76E8wVUqGfUuhDFnXqpnusSKcT00Z3vQ6sJyOEk4LCYNJaC
   Yl9+CQ1BUaTIwUqIjEfBjuI88cVXZV6OoSndDKARIaSZmlw2DzCSbGnfM
   ldGVitLtp4LK0pE0zu73ETSl/qkFFF5YMOEjjDxNUky+ZesWb5+RK83wi
   8IToZL3ixmU4j86NBc8Wjbxgc5dc1D1Pan1oulYS/aQzMawowaGnBYcI8
   qelMRLT3HHZ0hlcVnAYG9MzzaUzKjm3mEKWl+x701oWkz4IAOPtn8k/Zn
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="11948570"
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="11948570"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 05:20:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="24896250"
Received: from lkp-server01.sh.intel.com (HELO 01f0647817ea) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 08 Feb 2024 05:20:41 -0800
Received: from kbuild by 01f0647817ea with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1rY4KV-0003lk-1i;
	Thu, 08 Feb 2024 13:20:39 +0000
Date: Thu, 8 Feb 2024 21:20:34 +0800
From: kernel test robot <lkp@intel.com>
To: Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next 10/13] net: add netdev_set_operstate() helper
Message-ID: <202402082151.O18ZoLSK-lkp@intel.com>
References: <20240207142629.3456570-11-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240207142629.3456570-11-edumazet@google.com>

Hi Eric,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Eric-Dumazet/net-annotate-data-races-around-dev-name_assign_type/20240207-222903
base:   net-next/main
patch link:    https://lore.kernel.org/r/20240207142629.3456570-11-edumazet%40google.com
patch subject: [PATCH net-next 10/13] net: add netdev_set_operstate() helper
config: riscv-defconfig (https://download.01.org/0day-ci/archive/20240208/202402082151.O18ZoLSK-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 7dd790db8b77c4a833c06632e903dc4f13877a64)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240208/202402082151.O18ZoLSK-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202402082151.O18ZoLSK-lkp@intel.com/

All errors (new ones prefixed by >>):

>> net/core/rtnetlink.c:852:12: error: call to '__compiletime_assert_784' declared with 'error' attribute: BUILD_BUG failed
     852 |         } while (!try_cmpxchg(&dev->operstate, &old, newstate));
         |                   ^
   include/linux/atomic/atomic-instrumented.h:4838:2: note: expanded from macro 'try_cmpxchg'
    4838 |         raw_try_cmpxchg(__ai_ptr, __ai_oldp, __VA_ARGS__); \
         |         ^
   include/linux/atomic/atomic-arch-fallback.h:192:9: note: expanded from macro 'raw_try_cmpxchg'
     192 |         ___r = raw_cmpxchg((_ptr), ___o, (_new)); \
         |                ^
   include/linux/atomic/atomic-arch-fallback.h:55:21: note: expanded from macro 'raw_cmpxchg'
      55 | #define raw_cmpxchg arch_cmpxchg
         |                     ^
   note: (skipping 5 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:423:2: note: expanded from macro '_compiletime_assert'
     423 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ^
   include/linux/compiler_types.h:416:4: note: expanded from macro '__compiletime_assert'
     416 |                         prefix ## suffix();                             \
         |                         ^
   <scratch space>:50:1: note: expanded from here
      50 | __compiletime_assert_784
         | ^
>> net/core/rtnetlink.c:852:12: error: call to '__compiletime_assert_784' declared with 'error' attribute: BUILD_BUG failed
   include/linux/atomic/atomic-instrumented.h:4838:2: note: expanded from macro 'try_cmpxchg'
    4838 |         raw_try_cmpxchg(__ai_ptr, __ai_oldp, __VA_ARGS__); \
         |         ^
   include/linux/atomic/atomic-arch-fallback.h:192:9: note: expanded from macro 'raw_try_cmpxchg'
     192 |         ___r = raw_cmpxchg((_ptr), ___o, (_new)); \
         |                ^
   include/linux/atomic/atomic-arch-fallback.h:55:21: note: expanded from macro 'raw_cmpxchg'
      55 | #define raw_cmpxchg arch_cmpxchg
         |                     ^
   note: (skipping 5 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:423:2: note: expanded from macro '_compiletime_assert'
     423 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ^
   include/linux/compiler_types.h:416:4: note: expanded from macro '__compiletime_assert'
     416 |                         prefix ## suffix();                             \
         |                         ^
   <scratch space>:50:1: note: expanded from here
      50 | __compiletime_assert_784
         | ^
>> net/core/rtnetlink.c:852:12: error: call to '__compiletime_assert_784' declared with 'error' attribute: BUILD_BUG failed
   include/linux/atomic/atomic-instrumented.h:4838:2: note: expanded from macro 'try_cmpxchg'
    4838 |         raw_try_cmpxchg(__ai_ptr, __ai_oldp, __VA_ARGS__); \
         |         ^
   include/linux/atomic/atomic-arch-fallback.h:192:9: note: expanded from macro 'raw_try_cmpxchg'
     192 |         ___r = raw_cmpxchg((_ptr), ___o, (_new)); \
         |                ^
   include/linux/atomic/atomic-arch-fallback.h:55:21: note: expanded from macro 'raw_cmpxchg'
      55 | #define raw_cmpxchg arch_cmpxchg
         |                     ^
   note: (skipping 5 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/compiler_types.h:423:2: note: expanded from macro '_compiletime_assert'
     423 |         __compiletime_assert(condition, msg, prefix, suffix)
         |         ^
   include/linux/compiler_types.h:416:4: note: expanded from macro '__compiletime_assert'
     416 |                         prefix ## suffix();                             \
         |                         ^
   <scratch space>:50:1: note: expanded from here
      50 | __compiletime_assert_784
         | ^
   3 errors generated.


vim +852 net/core/rtnetlink.c

   844	
   845	void netdev_set_operstate(struct net_device *dev, int newstate)
   846	{
   847		unsigned char old = READ_ONCE(dev->operstate);
   848	
   849		do {
   850			if (old == newstate)
   851				return;
 > 852		} while (!try_cmpxchg(&dev->operstate, &old, newstate));
   853	
   854		netdev_state_change(dev);
   855	}
   856	EXPORT_SYMBOL(netdev_set_operstate);
   857	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

