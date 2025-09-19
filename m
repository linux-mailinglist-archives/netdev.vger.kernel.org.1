Return-Path: <netdev+bounces-224715-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE30FB88C3F
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 12:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EAC25A0094
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 10:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C80B2F49EB;
	Fri, 19 Sep 2025 10:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lY9hX4dS"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A514C2EC08A
	for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 10:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758276623; cv=none; b=bxIPQBrst796nRi58+BaZ9rmEZMIuQ1hxMXh1Jy8LgQBmFs/y3muSEp4vYYojfyZjJUmhDcslE8mtEcy5w7fKOnRgPFjrqdqUT3PNFiKOHhBWybffRlk6CaVSIbDEy8Lqdk/Pla/0qSEch0tPqY3S9brQY4QQ8OK0SL2xm0oz0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758276623; c=relaxed/simple;
	bh=T81hpHtClbzCSMopKan4eUgA2AWFd4Jyyhy1ER8FvsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZwqEpQiLTUaxr+dqE23liapAmF78UEu/ooMqQKs2/SuTzAxTvNRNWb1PCRgF7KGFEM4RrYiFw4SfR+8c2sFj2hpx6DHCjjBeqbu7TEZstuZZyqG4QIoRFh/wYowpBAhL9Oloxsv5kDTloFOoujIuAWGL42W7Y2wg3Djsp/UJguQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lY9hX4dS; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758276621; x=1789812621;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=T81hpHtClbzCSMopKan4eUgA2AWFd4Jyyhy1ER8FvsM=;
  b=lY9hX4dStTC5/1gJ57nXNzHOr/QdklpEGISSBFRZNbZm7871v76laPBC
   JqP5aUoTDRoetiE233PJLI0PF8E9+BGQ07mHofZ3i3M2kroh8aUWWricT
   gfUBSlfQ3VXPvax9RcR5QA7WlIsVvp0hVbs+w6cfC3IzkXtW4kc5HH3cl
   a2L4Ol/6NMKg4YZd9n2P6CIbkxCpWNBIRrl4sNG2qbA1lO32a6QfmWKol
   qZccxziKF419tAxBn3qJWd+tRnwXOtV4rhUWutv9yZ3skGy/ZMOdWSRHn
   wmB8tG+Va3gIziOECyM4UGDDyeiOYPqaYzn1Fb/19JTGsxurLIlvBWazC
   g==;
X-CSE-ConnectionGUID: 5ESUkd86QbWSg8qEqK2Wmw==
X-CSE-MsgGUID: M32cvS1PQRm8a2U2lCl7xA==
X-IronPort-AV: E=McAfee;i="6800,10657,11557"; a="78227621"
X-IronPort-AV: E=Sophos;i="6.18,277,1751266800"; 
   d="scan'208";a="78227621"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2025 03:10:21 -0700
X-CSE-ConnectionGUID: 5W+6XjD1QLiw7Gfi0jG/aQ==
X-CSE-MsgGUID: oraggle/RhuHby0ZNcdpGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,277,1751266800"; 
   d="scan'208";a="175348230"
Received: from lkp-server01.sh.intel.com (HELO 84a20bd60769) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 19 Sep 2025 03:10:18 -0700
Received: from kbuild by 84a20bd60769 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uzY4F-0004Br-19;
	Fri, 19 Sep 2025 10:10:15 +0000
Date: Fri, 19 Sep 2025 18:09:52 +0800
From: kernel test robot <lkp@intel.com>
To: Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, Simon Horman <horms@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next 3/7] tcp: move tcp->rcv_tstamp to
 tcp_sock_write_txrx group
Message-ID: <202509191711.gDaSokkJ-lkp@intel.com>
References: <20250918155532.751173-4-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250918155532.751173-4-edumazet@google.com>

Hi Eric,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Eric-Dumazet/net-move-sk_uid-and-sk_protocol-to-sock_read_tx/20250919-000602
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250918155532.751173-4-edumazet%40google.com
patch subject: [PATCH net-next 3/7] tcp: move tcp->rcv_tstamp to tcp_sock_write_txrx group
config: powerpc-ge_imp3a_defconfig (https://download.01.org/0day-ci/archive/20250919/202509191711.gDaSokkJ-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250919/202509191711.gDaSokkJ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202509191711.gDaSokkJ-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from <command-line>:
   In function 'tcp_struct_check',
       inlined from 'tcp_init' at net/ipv4/tcp.c:5204:2:
>> include/linux/compiler_types.h:572:45: error: call to '__compiletime_assert_1129' declared with attribute error: BUILD_BUG_ON failed: offsetof(struct tcp_sock, __cacheline_group_end__tcp_sock_write_txrx) - offsetofend(struct tcp_sock, __cacheline_group_begin__tcp_sock_write_txrx) > 107 + 4
     572 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                             ^
   include/linux/compiler_types.h:553:25: note: in definition of macro '__compiletime_assert'
     553 |                         prefix ## suffix();                             \
         |                         ^~~~~~
   include/linux/compiler_types.h:572:9: note: in expansion of macro '_compiletime_assert'
     572 |         _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |         ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:9: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |         BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |         ^~~~~~~~~~~~~~~~
   include/linux/cache.h:160:9: note: in expansion of macro 'BUILD_BUG_ON'
     160 |         BUILD_BUG_ON(offsetof(TYPE, __cacheline_group_end__##GROUP) - \
         |         ^~~~~~~~~~~~
   net/ipv4/tcp.c:5173:9: note: in expansion of macro 'CACHELINE_ASSERT_GROUP_SIZE'
    5173 |         CACHELINE_ASSERT_GROUP_SIZE(struct tcp_sock, tcp_sock_write_txrx, 107 + 4);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/__compiletime_assert_1129 +572 include/linux/compiler_types.h

eb5c2d4b45e3d2 Will Deacon 2020-07-21  558  
eb5c2d4b45e3d2 Will Deacon 2020-07-21  559  #define _compiletime_assert(condition, msg, prefix, suffix) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21  560  	__compiletime_assert(condition, msg, prefix, suffix)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  561  
eb5c2d4b45e3d2 Will Deacon 2020-07-21  562  /**
eb5c2d4b45e3d2 Will Deacon 2020-07-21  563   * compiletime_assert - break build and emit msg if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  564   * @condition: a compile-time constant condition to check
eb5c2d4b45e3d2 Will Deacon 2020-07-21  565   * @msg:       a message to emit if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  566   *
eb5c2d4b45e3d2 Will Deacon 2020-07-21  567   * In tradition of POSIX assert, this macro will break the build if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  568   * supplied condition is *false*, emitting the supplied error message if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  569   * compiler has support to do so.
eb5c2d4b45e3d2 Will Deacon 2020-07-21  570   */
eb5c2d4b45e3d2 Will Deacon 2020-07-21  571  #define compiletime_assert(condition, msg) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21 @572  	_compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  573  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

