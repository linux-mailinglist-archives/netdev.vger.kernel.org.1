Return-Path: <netdev+bounces-130722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A97D98B516
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 09:03:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3DFEB20E4C
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 07:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39EA81BB6B6;
	Tue,  1 Oct 2024 07:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n6a9FT6L"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE2C1B86DC
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 07:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727766184; cv=none; b=Tgq9uN6TOhW3pCwHsVtSKcYzP3JygiJUPLGas+oq4LUype1bWPEtRaujeVCcsNczORrjIwLlSgf6yPVECmPBHtmDhxsiAs7hPnjjAvi/9w8Xt9pZ2lLrlPeP0VqGRdqF2GjPzG9eWqbhdOPrTXtMapOPCHWn5znzkbr6BzbR+Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727766184; c=relaxed/simple;
	bh=5pjTwgYOmqpBB0LjumlV0nwBjHebEZDkgDLmmEgKPQo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iStLSv15ZH0eoNfSqsFz85YYPQ0Xljc9RKRQNiSOVPBPR1eOAHTnZxyGOXbrWlHFjc866xS9jrtYPkdXt7JrKYUc3DTwR8PIwZEBYvfajJnpkDGvkYnPzlmzYvr93JpX2nLkktoBfIRaKuMCMHXMDdmoAKuhPcu0Tt8xQFVcc+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n6a9FT6L; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727766182; x=1759302182;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5pjTwgYOmqpBB0LjumlV0nwBjHebEZDkgDLmmEgKPQo=;
  b=n6a9FT6LIttb574O1yG9KbvZHqT96TicZlIokEe14LWyiUVmGYiEn14A
   EHuYozKlHqKsDPmD9Jj8FWy8jbKsomv38ePvVhr+2ZbU7YZypOAuVUbH5
   3aTKsmI84FV5HGsjgCA/V6D5Gb4RTEPSd9IhD6FFWLOYOMDJAf5Ip6ZIB
   4sWDTAlpvt+BZ2G2ju64K/5h5erFwEoEKXquNm69g5qjM4qSNsKOkm1NL
   AaoW+kmeTmZqs3BQm1kWosh3E3s4xRkT8uk0tJ71HWGE2C+kB8yKyWfXD
   /4j/0DVx+bT//RRTDR0bGTbsc0caDBxogQE6cLk5/E04b1RDgs/8uDknQ
   w==;
X-CSE-ConnectionGUID: AJfGmeZkRPuot39KFHo0Zg==
X-CSE-MsgGUID: XhFb98qHRSynnPM2x+/8pQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11211"; a="30582540"
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="30582540"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 00:03:01 -0700
X-CSE-ConnectionGUID: Gu0nZ05ESieXFp8v+6G8Ag==
X-CSE-MsgGUID: 1cefmXJ2Sim6Dt3eE1xM2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,167,1725346800"; 
   d="scan'208";a="78525863"
Received: from lkp-server01.sh.intel.com (HELO 53e96f405c61) ([10.239.97.150])
  by orviesa004.jf.intel.com with ESMTP; 01 Oct 2024 00:03:00 -0700
Received: from kbuild by 53e96f405c61 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1svWuP-000QMH-08;
	Tue, 01 Oct 2024 07:02:57 +0000
Date: Tue, 1 Oct 2024 15:02:00 +0800
From: kernel test robot <lkp@intel.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, netdev@vger.kernel.org,
	Kuniyuki Iwashima <kuniyu@amazon.com>
Subject: Re: [PATCH v1 net-next 1/3] rtnetlink: Add per-net RTNL.
Message-ID: <202410011447.gX9yfZVj-lkp@intel.com>
References: <20240930202524.59357-2-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930202524.59357-2-kuniyu@amazon.com>

Hi Kuniyuki,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Kuniyuki-Iwashima/rtnetlink-Add-per-net-RTNL/20241001-043219
base:   net-next/main
patch link:    https://lore.kernel.org/r/20240930202524.59357-2-kuniyu%40amazon.com
patch subject: [PATCH v1 net-next 1/3] rtnetlink: Add per-net RTNL.
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20241001/202410011447.gX9yfZVj-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241001/202410011447.gX9yfZVj-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410011447.gX9yfZVj-lkp@intel.com/

All errors (new ones prefixed by >>):

   WARNING: unmet direct dependencies detected for GET_FREE_REGION
   Depends on [n]: SPARSEMEM [=n]
   Selected by [m]:
   - RESOURCE_KUNIT_TEST [=m] && RUNTIME_TESTING_MENU [=y] && KUNIT [=m]
   In file included from include/linux/spinlock.h:63,
   from include/linux/sched.h:2140,
   from arch/m68k/kernel/asm-offsets.c:15:
>> include/linux/lockdep.h:413:52: error: unknown type name 'lock_cmp_fn'
   413 | void lockdep_set_lock_cmp_fn(struct lockdep_map *, lock_cmp_fn, lock_print_fn);
   |                                                    ^~~~~~~~~~~
>> include/linux/lockdep.h:413:65: error: unknown type name 'lock_print_fn'
   413 | void lockdep_set_lock_cmp_fn(struct lockdep_map *, lock_cmp_fn, lock_print_fn);
   |                                                                 ^~~~~~~~~~~~~
   make[3]: *** [scripts/Makefile.build:102: arch/m68k/kernel/asm-offsets.s] Error 1
   make[3]: Target 'prepare' not remade because of errors.
   make[2]: *** [Makefile:1203: prepare0] Error 2
   make[2]: Target 'prepare' not remade because of errors.
   make[1]: *** [Makefile:224: __sub-make] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:224: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for PROVE_LOCKING
   Depends on [n]: DEBUG_KERNEL [=y] && LOCK_DEBUGGING_SUPPORT [=n]
   Selected by [y]:
   - DEBUG_NET_SMALL_RTNL [=y]
   WARNING: unmet direct dependencies detected for GET_FREE_REGION
   Depends on [n]: SPARSEMEM [=n]
   Selected by [m]:
   - RESOURCE_KUNIT_TEST [=m] && RUNTIME_TESTING_MENU [=y] && KUNIT [=m]


vim +/lock_cmp_fn +413 include/linux/lockdep.h

fbb9ce9530fd9b6 Ingo Molnar     2006-07-03  411  
eb1cfd09f788e39 Kent Overstreet 2023-05-09  412  #ifdef CONFIG_PROVE_LOCKING
eb1cfd09f788e39 Kent Overstreet 2023-05-09 @413  void lockdep_set_lock_cmp_fn(struct lockdep_map *, lock_cmp_fn, lock_print_fn);
eb1cfd09f788e39 Kent Overstreet 2023-05-09  414  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

