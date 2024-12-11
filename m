Return-Path: <netdev+bounces-150909-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8CA99EC0CB
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 01:32:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B561163C6D
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 00:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF90B65C;
	Wed, 11 Dec 2024 00:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cIXAeBdz"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E0CC139
	for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 00:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733877167; cv=none; b=aYbPPQQnFov7/gyR09YZQNEnSc+aR7wI/U06ZnArM9Ht1jbLZ3QtDVlMqcJ7xmjAx2MMhSoaBvDICm8oa5qAS4lpoml8KfBRthRHNv3tPvogzS5wem70j0CINWGQYrL2LWa+mDC4G40QhtqBs9/u+paM1yZG+gAi09Qmej0VlqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733877167; c=relaxed/simple;
	bh=Zp9l2yuYpqCiHZMggGN0FR4ThvNAvbPrnjASuwaPQS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SsO9M33zPIK/3i+OYtlnkO4T4klbhpoN+sd0wG7knqzYqlZrCViBe+ADpX/mojvyidiRbzHUNp6usdff1Aj+k6ibKvEgeUtVMca2Qi1C8/X7vZtV0Bl5afw2OdpTJRRnV0KSRkhBZ7/iwNqS4RPGD8AM8v0YmjtleRvj4DZVddw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cIXAeBdz; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733877165; x=1765413165;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Zp9l2yuYpqCiHZMggGN0FR4ThvNAvbPrnjASuwaPQS4=;
  b=cIXAeBdzvU4NzqGzs9mS82Z6nTChZfNg1rApfl2h+GTIIv0Ts8YI6PI5
   F0BOT3pkVsMeOhn1kCPKCmy7manszuo53cQGnQUNYocECa+26028gE6PX
   s8/QCqjD9cR+4qy7IH6pi4mO4gfYvX3C0TpsSn+0EDsofL6cGT1ismkCU
   tc3QKATrpMHjqdyxDMwbxIZJFeLCpS7VBugb7sSoEC9LPWFs3ytLDSvC7
   9JdV5pxvq03cNBLPPjqOFVOVEhC7UH/fdJKIOe+r6PbprusnyX6VIR/rU
   hoWkSN9Dpn1MAN70AKqv1qJEgYkoXNOzi1v4C5n1wkV/0UM913WoXeUeG
   g==;
X-CSE-ConnectionGUID: ZpeJMnUTQo2IeFjgTXhTGw==
X-CSE-MsgGUID: 8tDwLy5kRmWMbnvSzcJwZg==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="38025959"
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="38025959"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 16:32:45 -0800
X-CSE-ConnectionGUID: qoKVF0DyQDK45CSL7worTA==
X-CSE-MsgGUID: ZQyfS/cQTdGC7fotOMS5Hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="100643145"
Received: from lkp-server01.sh.intel.com (HELO 82a3f569d0cb) ([10.239.97.150])
  by orviesa003.jf.intel.com with ESMTP; 10 Dec 2024 16:32:42 -0800
Received: from kbuild by 82a3f569d0cb with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tLAed-00065l-22;
	Wed, 11 Dec 2024 00:32:39 +0000
Date: Wed, 11 Dec 2024 08:32:06 +0800
From: kernel test robot <lkp@intel.com>
To: John Ousterhout <ouster@cs.stanford.edu>, netdev@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	John Ousterhout <ouster@cs.stanford.edu>
Subject: Re: [PATCH net-next v3 12/12] net: homa: create Makefile and Kconfig
Message-ID: <202412110709.Kdjua3Pc-lkp@intel.com>
References: <20241209175131.3839-14-ouster@cs.stanford.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209175131.3839-14-ouster@cs.stanford.edu>

Hi John,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/John-Ousterhout/inet-homa-define-user-visible-API-for-Homa/20241210-055415
base:   net-next/main
patch link:    https://lore.kernel.org/r/20241209175131.3839-14-ouster%40cs.stanford.edu
patch subject: [PATCH net-next v3 12/12] net: homa: create Makefile and Kconfig
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20241211/202412110709.Kdjua3Pc-lkp@intel.com/config)
compiler: clang version 19.1.3 (https://github.com/llvm/llvm-project ab51eccf88f5321e7c60591c5546b254b6afab99)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241211/202412110709.Kdjua3Pc-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202412110709.Kdjua3Pc-lkp@intel.com/

All warnings (new ones prefixed by >>):

   In file included from net/homa/homa_outgoing.c:7:
   In file included from net/homa/homa_impl.h:12:
   In file included from include/linux/audit.h:13:
   In file included from include/linux/ptrace.h:10:
   In file included from include/linux/pid_namespace.h:7:
   In file included from include/linux/mm.h:2223:
   include/linux/vmstat.h:504:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     504 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     505 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:511:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     511 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     512 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   include/linux/vmstat.h:524:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     524 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     525 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
>> net/homa/homa_outgoing.c:809:6: warning: variable 'checks' set but not used [-Wunused-but-set-variable]
     809 |         int checks = 0;
         |             ^
   5 warnings generated.
--
   In file included from net/homa/homa_sock.c:5:
   In file included from net/homa/homa_impl.h:12:
   In file included from include/linux/audit.h:13:
   In file included from include/linux/ptrace.h:10:
   In file included from include/linux/pid_namespace.h:7:
   In file included from include/linux/mm.h:2223:
   include/linux/vmstat.h:504:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     504 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     505 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:511:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     511 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     512 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   include/linux/vmstat.h:524:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     524 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     525 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
>> net/homa/homa_sock.c:224:6: warning: variable 'i' set but not used [-Wunused-but-set-variable]
     224 |         int i;
         |             ^
   5 warnings generated.
--
   In file included from net/homa/homa_timer.c:7:
   In file included from net/homa/homa_impl.h:12:
   In file included from include/linux/audit.h:13:
   In file included from include/linux/ptrace.h:10:
   In file included from include/linux/pid_namespace.h:7:
   In file included from include/linux/mm.h:2223:
   include/linux/vmstat.h:504:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     504 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     505 |                            item];
         |                            ~~~~
   include/linux/vmstat.h:511:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     511 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     512 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   include/linux/vmstat.h:524:43: warning: arithmetic between different enumeration types ('enum zone_stat_item' and 'enum numa_stat_item') [-Wenum-enum-conversion]
     524 |         return vmstat_text[NR_VM_ZONE_STAT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~ ^
     525 |                            NR_VM_NUMA_EVENT_ITEMS +
         |                            ~~~~~~~~~~~~~~~~~~~~~~
>> net/homa/homa_timer.c:106:6: warning: variable 'total_rpcs' set but not used [-Wunused-but-set-variable]
     106 |         int total_rpcs = 0;
         |             ^
   5 warnings generated.


vim +/checks +809 net/homa/homa_outgoing.c

537f41147b3131 John Ousterhout 2024-12-09  796  
537f41147b3131 John Ousterhout 2024-12-09  797  /**
537f41147b3131 John Ousterhout 2024-12-09  798   * homa_add_to_throttled() - Make sure that an RPC is on the throttled list
537f41147b3131 John Ousterhout 2024-12-09  799   * and wake up the pacer thread if necessary.
537f41147b3131 John Ousterhout 2024-12-09  800   * @rpc:     RPC with outbound packets that have been granted but can't be
537f41147b3131 John Ousterhout 2024-12-09  801   *           sent because of NIC queue restrictions. Must be locked by caller.
537f41147b3131 John Ousterhout 2024-12-09  802   */
537f41147b3131 John Ousterhout 2024-12-09  803  void homa_add_to_throttled(struct homa_rpc *rpc)
537f41147b3131 John Ousterhout 2024-12-09  804  	__must_hold(&rpc->bucket->lock)
537f41147b3131 John Ousterhout 2024-12-09  805  {
537f41147b3131 John Ousterhout 2024-12-09  806  	struct homa *homa = rpc->hsk->homa;
537f41147b3131 John Ousterhout 2024-12-09  807  	struct homa_rpc *candidate;
537f41147b3131 John Ousterhout 2024-12-09  808  	int bytes_left;
537f41147b3131 John Ousterhout 2024-12-09 @809  	int checks = 0;
537f41147b3131 John Ousterhout 2024-12-09  810  	__u64 now;
537f41147b3131 John Ousterhout 2024-12-09  811  
537f41147b3131 John Ousterhout 2024-12-09  812  	if (!list_empty(&rpc->throttled_links))
537f41147b3131 John Ousterhout 2024-12-09  813  		return;
537f41147b3131 John Ousterhout 2024-12-09  814  	now = sched_clock();
537f41147b3131 John Ousterhout 2024-12-09  815  	homa->throttle_add = now;
537f41147b3131 John Ousterhout 2024-12-09  816  	bytes_left = rpc->msgout.length - rpc->msgout.next_xmit_offset;
537f41147b3131 John Ousterhout 2024-12-09  817  	homa_throttle_lock(homa);
537f41147b3131 John Ousterhout 2024-12-09  818  	list_for_each_entry_rcu(candidate, &homa->throttled_rpcs,
537f41147b3131 John Ousterhout 2024-12-09  819  				throttled_links) {
537f41147b3131 John Ousterhout 2024-12-09  820  		int bytes_left_cand;
537f41147b3131 John Ousterhout 2024-12-09  821  
537f41147b3131 John Ousterhout 2024-12-09  822  		checks++;
537f41147b3131 John Ousterhout 2024-12-09  823  
537f41147b3131 John Ousterhout 2024-12-09  824  		/* Watch out: the pacer might have just transmitted the last
537f41147b3131 John Ousterhout 2024-12-09  825  		 * packet from candidate.
537f41147b3131 John Ousterhout 2024-12-09  826  		 */
537f41147b3131 John Ousterhout 2024-12-09  827  		bytes_left_cand = candidate->msgout.length -
537f41147b3131 John Ousterhout 2024-12-09  828  				candidate->msgout.next_xmit_offset;
537f41147b3131 John Ousterhout 2024-12-09  829  		if (bytes_left_cand > bytes_left) {
537f41147b3131 John Ousterhout 2024-12-09  830  			list_add_tail_rcu(&rpc->throttled_links,
537f41147b3131 John Ousterhout 2024-12-09  831  					  &candidate->throttled_links);
537f41147b3131 John Ousterhout 2024-12-09  832  			goto done;
537f41147b3131 John Ousterhout 2024-12-09  833  		}
537f41147b3131 John Ousterhout 2024-12-09  834  	}
537f41147b3131 John Ousterhout 2024-12-09  835  	list_add_tail_rcu(&rpc->throttled_links, &homa->throttled_rpcs);
537f41147b3131 John Ousterhout 2024-12-09  836  done:
537f41147b3131 John Ousterhout 2024-12-09  837  	homa_throttle_unlock(homa);
537f41147b3131 John Ousterhout 2024-12-09  838  	wake_up_process(homa->pacer_kthread);
537f41147b3131 John Ousterhout 2024-12-09  839  }
537f41147b3131 John Ousterhout 2024-12-09  840  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

