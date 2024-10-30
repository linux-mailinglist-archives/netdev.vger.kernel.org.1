Return-Path: <netdev+bounces-140218-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0577A9B58F5
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 02:09:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A57A2283EE9
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 01:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C1BD126BF7;
	Wed, 30 Oct 2024 01:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="huQWjN89"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D0803C14
	for <netdev@vger.kernel.org>; Wed, 30 Oct 2024 01:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730250584; cv=none; b=awxc6G8EtJpetAo1Cte4SjSEc8mTLGPaF6LWTeFDWyxMZx8wnTUP/03L0bdc80xdbPjwFanX18qjJvqPNzqFdmNTfK+uVSJxRRBjujHuRjEnSifWqQe44P+zP+Gp7KaMLETWi2KIIPBWTTv02qDHeDdujqi+ixRtKtblLIq3IsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730250584; c=relaxed/simple;
	bh=kOpppAgcjKffUoV/4Sr67QwhaAVhvZ0Y3r860MP5374=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uzo3kthGBGxiZmbMBZRuLVcVZf9Y14ohCHhI6uFwdJb7YZIOwuG+tK3y4GVK3II1xoszl6umGzAw69zuv7rl4xjjQTU6TLz/aJs9OYMGcBCiPJPAFK4SRK3PiWmIHM+MHa/lF3ZxcRl7vkVW0bTHWrnwYdaRF0VIyv3fSygX/v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=huQWjN89; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730250581; x=1761786581;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kOpppAgcjKffUoV/4Sr67QwhaAVhvZ0Y3r860MP5374=;
  b=huQWjN89MJlXhL0rUTv1y+7zLUxCb+F3EqntIIJB4/XNSLEIK6hsCgIJ
   vxbpim1qsrNsUwLEeaAcsfxK4uC02RSakqeaDY+/j/Pw8g64Mxhr1kiBA
   0waNu9UY1AF74C7GcQAKZDugnyPSOBi11WvuqEpcOfrSW0zRBBcWB+7rk
   a1jT602fgzlHMzj+9oiuKbNmxjSEd0Wrx4Qrf2uZQNgFaMS9ABsnfVOOL
   71yeeEN2cbya5j+QqVTTxp1WM1zB+CPVKaOy5tAjAkJkvLF1Emj1eJmKi
   8ZnKooXwy3YkFSObZjDLmEIWaiQCnVYG3dab3bT9mlreAH71xBk2ZL7o5
   w==;
X-CSE-ConnectionGUID: QIxEKdsCTTKdhlXWOAgzyA==
X-CSE-MsgGUID: LteniXjFSKGCInPdti7LiQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11240"; a="30140057"
X-IronPort-AV: E=Sophos;i="6.11,243,1725346800"; 
   d="scan'208";a="30140057"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2024 18:09:40 -0700
X-CSE-ConnectionGUID: bPB/FKJoSwe4RFw9I7PRRw==
X-CSE-MsgGUID: AHCtC4K4T6Kx8RtBf0029Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,243,1725346800"; 
   d="scan'208";a="112979480"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 29 Oct 2024 18:09:38 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1t5xDM-000eM2-1l;
	Wed, 30 Oct 2024 01:09:36 +0000
Date: Wed, 30 Oct 2024 09:09:11 +0800
From: kernel test robot <lkp@intel.com>
To: John Ousterhout <ouster@cs.stanford.edu>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, John Ousterhout <ouster@cs.stanford.edu>
Subject: Re: [PATCH net-next 12/12] net: homa: create Makefile and Kconfig
Message-ID: <202410300823.rFSVqCH5-lkp@intel.com>
References: <20241028213541.1529-13-ouster@cs.stanford.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241028213541.1529-13-ouster@cs.stanford.edu>

Hi John,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/John-Ousterhout/net-homa-define-user-visible-API-for-Homa/20241029-095137
base:   net-next/main
patch link:    https://lore.kernel.org/r/20241028213541.1529-13-ouster%40cs.stanford.edu
patch subject: [PATCH net-next 12/12] net: homa: create Makefile and Kconfig
config: arc-randconfig-r132-20241029 (https://download.01.org/0day-ci/archive/20241030/202410300823.rFSVqCH5-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 13.2.0
reproduce: (https://download.01.org/0day-ci/archive/20241030/202410300823.rFSVqCH5-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410300823.rFSVqCH5-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   net/homa/homa_rpc.c: note: in included file:
>> net/homa/homa_impl.h:605:13: sparse: sparse: restricted __be32 degrades to integer
   net/homa/homa_rpc.c: note: in included file (through include/linux/smp.h, include/linux/lockdep.h, include/linux/spinlock.h, ...):
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   net/homa/homa_rpc.c:84:9: sparse: sparse: context imbalance in 'homa_rpc_new_client' - different lock contexts for basic block
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   net/homa/homa_rpc.c:104:17: sparse: sparse: context imbalance in 'homa_rpc_new_server' - wrong count at exit
   net/homa/homa_rpc.c: note: in included file (through include/linux/rculist.h, include/linux/sched/signal.h, include/linux/ptrace.h, ...):
   include/linux/rcupdate.h:881:9: sparse: sparse: context imbalance in 'homa_rpc_acked' - unexpected unlock
   net/homa/homa_rpc.c: note: in included file (through include/linux/smp.h, include/linux/lockdep.h, include/linux/spinlock.h, ...):
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   net/homa/homa_rpc.c:235:6: sparse: sparse: context imbalance in 'homa_rpc_free' - different lock contexts for basic block
   net/homa/homa_rpc.c:311:5: sparse: sparse: context imbalance in 'homa_rpc_reap' - wrong count at exit
   net/homa/homa_rpc.c:448:17: sparse: sparse: context imbalance in 'homa_find_client_rpc' - wrong count at exit
   net/homa/homa_rpc.c:474:17: sparse: sparse: context imbalance in 'homa_find_server_rpc' - wrong count at exit
--
>> net/homa/homa_sock.c:85:39: sparse: sparse: cast removes address space '__rcu' of expression
   net/homa/homa_sock.c:91:31: sparse: sparse: cast removes address space '__rcu' of expression
   net/homa/homa_sock.c:165:6: sparse: sparse: context imbalance in 'homa_sock_shutdown' - wrong count at exit
   net/homa/homa_sock.c:243:5: sparse: sparse: context imbalance in 'homa_sock_bind' - different lock contexts for basic block
   net/homa/homa_sock.c:312:6: sparse: sparse: context imbalance in 'homa_sock_lock_slow' - wrong count at exit
   net/homa/homa_sock.c:326:6: sparse: sparse: context imbalance in 'homa_bucket_lock_slow' - wrong count at exit

vim +605 net/homa/homa_impl.h

1416f12d4ea455 John Ousterhout 2024-10-28  595  
1416f12d4ea455 John Ousterhout 2024-10-28  596  /**
1416f12d4ea455 John Ousterhout 2024-10-28  597   * Given an IPv4 address, return an equivalent IPv6 address (an IPv4-mapped
1416f12d4ea455 John Ousterhout 2024-10-28  598   * one)
1416f12d4ea455 John Ousterhout 2024-10-28  599   * @ip4: IPv4 address, in network byte order.
1416f12d4ea455 John Ousterhout 2024-10-28  600   */
1416f12d4ea455 John Ousterhout 2024-10-28  601  static inline struct in6_addr ipv4_to_ipv6(__be32 ip4)
1416f12d4ea455 John Ousterhout 2024-10-28  602  {
1416f12d4ea455 John Ousterhout 2024-10-28  603  	struct in6_addr ret = {};
1416f12d4ea455 John Ousterhout 2024-10-28  604  
1416f12d4ea455 John Ousterhout 2024-10-28 @605  	if (ip4 == INADDR_ANY)
1416f12d4ea455 John Ousterhout 2024-10-28  606  		return in6addr_any;
1416f12d4ea455 John Ousterhout 2024-10-28  607  	ret.in6_u.u6_addr32[2] = htonl(0xffff);
1416f12d4ea455 John Ousterhout 2024-10-28  608  	ret.in6_u.u6_addr32[3] = ip4;
1416f12d4ea455 John Ousterhout 2024-10-28  609  	return ret;
1416f12d4ea455 John Ousterhout 2024-10-28  610  }
1416f12d4ea455 John Ousterhout 2024-10-28  611  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

