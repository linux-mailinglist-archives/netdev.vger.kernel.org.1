Return-Path: <netdev+bounces-164385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 047E3A2DA15
	for <lists+netdev@lfdr.de>; Sun,  9 Feb 2025 02:07:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7AF33A6547
	for <lists+netdev@lfdr.de>; Sun,  9 Feb 2025 01:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B75D136A;
	Sun,  9 Feb 2025 01:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TjB03VDw"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4755D20EB
	for <netdev@vger.kernel.org>; Sun,  9 Feb 2025 01:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739063254; cv=none; b=LkdnvZzx8EDVP1BxLCWEoMm4LRDOZ9SxbA7/8TDjggwiYhfkOqK5bmqMjL7UM+sgU9t7lwi5uyCJTZ1kF+ndq2hNCwMUMuSgKYkSiHO6E4sbsvBlkDLenCrj/DqlHz+PLYIg2uAL/tO/7mBy0WY6ug2kXH2C/WU3rRpfpRU1Dqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739063254; c=relaxed/simple;
	bh=GagNFPV8JejHjIviqa+VzkxXEWsJgLQeKr85KRKN7D8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NOcoCJzyX/q07Z78bK9SY1eBFaX7Pz6IzCxA+Hy4yCB0gPCjoyVTKq5oxEWkR4k8ReJVwm7jIxR8SM/PypGQcB8G64XgcwnLlBWW8YmWlWhbnoMduFArU3NAwpLRfJEPU2RrtLUxNylsraSyjB7dqogoILThnIup4v+b5FjeQAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TjB03VDw; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739063253; x=1770599253;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GagNFPV8JejHjIviqa+VzkxXEWsJgLQeKr85KRKN7D8=;
  b=TjB03VDwEnyrB4Gp3ng6SeiU4KUMFZvD9Wn3l9c2Snah9qCeKG/5Xxhz
   /WMoq5uAgGn5gFGIYjLlUxUx+jZUvMPZJROGpW004+LrSwdmgCBgGOK3M
   b1P4LsFfS3hydpDQIDFc9LlZxwq/HTNobGye+Mm7ixbARJpRHdb4FLdy0
   o2tEwoR47qVB5sxIMuK7b7PYZrPjZcu3iBlTjitvhUaEPDVZf99+Ko3Wv
   KeUaPJyAIaZI+bTBOX8QIdMv6GZpE6WQGukL/RZ3XPXaXHBRVWK1KZA+e
   kXe9Jn367KTltp0X0yvdlhpd5GNDmT0Nv1hUg2hcSoCnBtcqNAZmp8aqs
   g==;
X-CSE-ConnectionGUID: jTpYJF6GTbC7JN7J+Zd8kQ==
X-CSE-MsgGUID: wfauAg+VRPKtsTzpiImH5Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="39789312"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="39789312"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2025 17:07:32 -0800
X-CSE-ConnectionGUID: sE2cqiLMQee6QwNe1KQ0Eg==
X-CSE-MsgGUID: aD+nPeTzSRebzwimPT6Mww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="135097059"
Received: from lkp-server01.sh.intel.com (HELO d63d4d77d921) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 08 Feb 2025 17:07:30 -0800
Received: from kbuild by d63d4d77d921 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tgvnD-0010rr-1A;
	Sun, 09 Feb 2025 01:07:27 +0000
Date: Sun, 9 Feb 2025 09:06:53 +0800
From: kernel test robot <lkp@intel.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH net-next] xfrm: Use rcuref_t for xfrm_state' reference
 counting.
Message-ID: <202502090827.R1HaLYSt-lkp@intel.com>
References: <20250207210248.qy4i5Wkl@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207210248.qy4i5Wkl@linutronix.de>

Hi Sebastian,

kernel test robot noticed the following build warnings:

[auto build test WARNING on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/Sebastian-Andrzej-Siewior/xfrm-Use-rcuref_t-for-xfrm_state-reference-counting/20250208-050716
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250207210248.qy4i5Wkl%40linutronix.de
patch subject: [PATCH net-next] xfrm: Use rcuref_t for xfrm_state' reference counting.
config: i386-randconfig-r122-20250209 (https://download.01.org/0day-ci/archive/20250209/202502090827.R1HaLYSt-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250209/202502090827.R1HaLYSt-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202502090827.R1HaLYSt-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
   net/xfrm/xfrm_state.c:1866:17: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1866:17: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1866:17: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1866:17: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1866:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct hlist_head *h @@     got struct hlist_head [noderef] __rcu * @@
   net/xfrm/xfrm_state.c:1866:17: sparse:     expected struct hlist_head *h
   net/xfrm/xfrm_state.c:1866:17: sparse:     got struct hlist_head [noderef] __rcu *
   net/xfrm/xfrm_state.c:1869:17: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1869:17: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1869:17: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1869:17: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1869:17: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1869:17: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1869:17: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1869:17: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1869:17: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1869:17: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:1869:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct hlist_head *h @@     got struct hlist_head [noderef] __rcu * @@
   net/xfrm/xfrm_state.c:1869:17: sparse:     expected struct hlist_head *h
   net/xfrm/xfrm_state.c:1869:17: sparse:     got struct hlist_head [noderef] __rcu *
   net/xfrm/xfrm_state.c:2479:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:2479:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:2479:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:2479:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:2479:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:2479:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:2479:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:2479:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:2479:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:2479:9: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:2593:17: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:2593:17: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:2593:17: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:2593:17: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:2593:17: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:2593:17: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:2593:17: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:2593:17: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:2593:17: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:2593:17: sparse: sparse: cast removes address space '__rcu' of expression
   net/xfrm/xfrm_state.c:2593:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected struct hlist_head *h @@     got struct hlist_head [noderef] __rcu * @@
   net/xfrm/xfrm_state.c:2593:17: sparse:     expected struct hlist_head *h
   net/xfrm/xfrm_state.c:2593:17: sparse:     got struct hlist_head [noderef] __rcu *
   net/xfrm/xfrm_state.c:3253:31: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct hlist_head [noderef] __rcu *state_bydst @@     got struct hlist_head * @@
   net/xfrm/xfrm_state.c:3253:31: sparse:     expected struct hlist_head [noderef] __rcu *state_bydst
   net/xfrm/xfrm_state.c:3253:31: sparse:     got struct hlist_head *
   net/xfrm/xfrm_state.c:3256:31: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct hlist_head [noderef] __rcu *state_bysrc @@     got struct hlist_head * @@
   net/xfrm/xfrm_state.c:3256:31: sparse:     expected struct hlist_head [noderef] __rcu *state_bysrc
   net/xfrm/xfrm_state.c:3256:31: sparse:     got struct hlist_head *
   net/xfrm/xfrm_state.c:3259:31: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct hlist_head [noderef] __rcu *state_byspi @@     got struct hlist_head * @@
   net/xfrm/xfrm_state.c:3259:31: sparse:     expected struct hlist_head [noderef] __rcu *state_byspi
   net/xfrm/xfrm_state.c:3259:31: sparse:     got struct hlist_head *
   net/xfrm/xfrm_state.c:3262:31: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct hlist_head [noderef] __rcu *state_byseq @@     got struct hlist_head * @@
   net/xfrm/xfrm_state.c:3262:31: sparse:     expected struct hlist_head [noderef] __rcu *state_byseq
   net/xfrm/xfrm_state.c:3262:31: sparse:     got struct hlist_head *
   net/xfrm/xfrm_state.c:3280:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct hlist_head *n @@     got struct hlist_head [noderef] __rcu *state_byseq @@
   net/xfrm/xfrm_state.c:3280:33: sparse:     expected struct hlist_head *n
   net/xfrm/xfrm_state.c:3280:33: sparse:     got struct hlist_head [noderef] __rcu *state_byseq
   net/xfrm/xfrm_state.c:3282:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct hlist_head *n @@     got struct hlist_head [noderef] __rcu *state_byspi @@
   net/xfrm/xfrm_state.c:3282:33: sparse:     expected struct hlist_head *n
   net/xfrm/xfrm_state.c:3282:33: sparse:     got struct hlist_head [noderef] __rcu *state_byspi
   net/xfrm/xfrm_state.c:3284:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct hlist_head *n @@     got struct hlist_head [noderef] __rcu *state_bysrc @@
   net/xfrm/xfrm_state.c:3284:33: sparse:     expected struct hlist_head *n
   net/xfrm/xfrm_state.c:3284:33: sparse:     got struct hlist_head [noderef] __rcu *state_bysrc
   net/xfrm/xfrm_state.c:3286:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct hlist_head *n @@     got struct hlist_head [noderef] __rcu *state_bydst @@
   net/xfrm/xfrm_state.c:3286:33: sparse:     expected struct hlist_head *n
   net/xfrm/xfrm_state.c:3286:33: sparse:     got struct hlist_head [noderef] __rcu *state_bydst
   net/xfrm/xfrm_state.c:3302:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct hlist_head const *h @@     got struct hlist_head [noderef] __rcu *state_byseq @@
   net/xfrm/xfrm_state.c:3302:9: sparse:     expected struct hlist_head const *h
   net/xfrm/xfrm_state.c:3302:9: sparse:     got struct hlist_head [noderef] __rcu *state_byseq
   net/xfrm/xfrm_state.c:3303:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct hlist_head *n @@     got struct hlist_head [noderef] __rcu *state_byseq @@
   net/xfrm/xfrm_state.c:3303:33: sparse:     expected struct hlist_head *n
   net/xfrm/xfrm_state.c:3303:33: sparse:     got struct hlist_head [noderef] __rcu *state_byseq
   net/xfrm/xfrm_state.c:3304:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct hlist_head const *h @@     got struct hlist_head [noderef] __rcu *state_byspi @@
   net/xfrm/xfrm_state.c:3304:9: sparse:     expected struct hlist_head const *h
   net/xfrm/xfrm_state.c:3304:9: sparse:     got struct hlist_head [noderef] __rcu *state_byspi
   net/xfrm/xfrm_state.c:3305:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct hlist_head *n @@     got struct hlist_head [noderef] __rcu *state_byspi @@
   net/xfrm/xfrm_state.c:3305:33: sparse:     expected struct hlist_head *n
   net/xfrm/xfrm_state.c:3305:33: sparse:     got struct hlist_head [noderef] __rcu *state_byspi
   net/xfrm/xfrm_state.c:3306:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct hlist_head const *h @@     got struct hlist_head [noderef] __rcu *state_bysrc @@
   net/xfrm/xfrm_state.c:3306:9: sparse:     expected struct hlist_head const *h
   net/xfrm/xfrm_state.c:3306:9: sparse:     got struct hlist_head [noderef] __rcu *state_bysrc
   net/xfrm/xfrm_state.c:3307:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct hlist_head *n @@     got struct hlist_head [noderef] __rcu *state_bysrc @@
   net/xfrm/xfrm_state.c:3307:33: sparse:     expected struct hlist_head *n
   net/xfrm/xfrm_state.c:3307:33: sparse:     got struct hlist_head [noderef] __rcu *state_bysrc
   net/xfrm/xfrm_state.c:3308:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct hlist_head const *h @@     got struct hlist_head [noderef] __rcu *state_bydst @@
   net/xfrm/xfrm_state.c:3308:9: sparse:     expected struct hlist_head const *h
   net/xfrm/xfrm_state.c:3308:9: sparse:     got struct hlist_head [noderef] __rcu *state_bydst
   net/xfrm/xfrm_state.c:3309:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct hlist_head *n @@     got struct hlist_head [noderef] __rcu *state_bydst @@
   net/xfrm/xfrm_state.c:3309:33: sparse:     expected struct hlist_head *n
   net/xfrm/xfrm_state.c:3309:33: sparse:     got struct hlist_head [noderef] __rcu *state_bydst
   net/xfrm/xfrm_state.c: note: in included file (through include/linux/rbtree.h, include/linux/mm_types.h, include/linux/uio.h, ...):
   include/linux/rcupdate.h:880:25: sparse: sparse: context imbalance in 'xfrm_register_type' - unexpected unlock
   include/linux/rcupdate.h:880:25: sparse: sparse: context imbalance in 'xfrm_unregister_type' - unexpected unlock
   include/linux/rcupdate.h:880:25: sparse: sparse: context imbalance in 'xfrm_get_type' - unexpected unlock
   include/linux/rcupdate.h:880:25: sparse: sparse: context imbalance in 'xfrm_register_type_offload' - unexpected unlock
   include/linux/rcupdate.h:880:25: sparse: sparse: context imbalance in 'xfrm_unregister_type_offload' - unexpected unlock
   include/linux/rcupdate.h:880:25: sparse: sparse: context imbalance in 'xfrm_get_type_offload' - unexpected unlock
   net/xfrm/xfrm_state.c:942:17: sparse: sparse: dereference of noderef expression
   net/xfrm/xfrm_state.c:987:17: sparse: sparse: dereference of noderef expression
>> net/xfrm/xfrm_state.c:58:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct rcuref_t [usertype] *ref @@     got struct rcuref_t [noderef] __rcu * @@
   net/xfrm/xfrm_state.c:58:28: sparse:     expected struct rcuref_t [usertype] *ref
   net/xfrm/xfrm_state.c:58:28: sparse:     got struct rcuref_t [noderef] __rcu *
>> net/xfrm/xfrm_state.c:58:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct rcuref_t [usertype] *ref @@     got struct rcuref_t [noderef] __rcu * @@
   net/xfrm/xfrm_state.c:58:28: sparse:     expected struct rcuref_t [usertype] *ref
   net/xfrm/xfrm_state.c:58:28: sparse:     got struct rcuref_t [noderef] __rcu *
>> net/xfrm/xfrm_state.c:58:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct rcuref_t [usertype] *ref @@     got struct rcuref_t [noderef] __rcu * @@
   net/xfrm/xfrm_state.c:58:28: sparse:     expected struct rcuref_t [usertype] *ref
   net/xfrm/xfrm_state.c:58:28: sparse:     got struct rcuref_t [noderef] __rcu *
>> net/xfrm/xfrm_state.c:58:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct rcuref_t [usertype] *ref @@     got struct rcuref_t [noderef] __rcu * @@
   net/xfrm/xfrm_state.c:58:28: sparse:     expected struct rcuref_t [usertype] *ref
   net/xfrm/xfrm_state.c:58:28: sparse:     got struct rcuref_t [noderef] __rcu *
>> net/xfrm/xfrm_state.c:58:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct rcuref_t [usertype] *ref @@     got struct rcuref_t [noderef] __rcu * @@
   net/xfrm/xfrm_state.c:58:28: sparse:     expected struct rcuref_t [usertype] *ref
   net/xfrm/xfrm_state.c:58:28: sparse:     got struct rcuref_t [noderef] __rcu *
   net/xfrm/xfrm_state.c: note: in included file (through include/linux/smp.h, include/linux/alloc_tag.h, include/linux/percpu.h, ...):
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   net/xfrm/xfrm_state.c:1673:9: sparse: sparse: dereference of noderef expression
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   net/xfrm/xfrm_state.c:1773:9: sparse: sparse: dereference of noderef expression
   net/xfrm/xfrm_state.c:1809:9: sparse: sparse: dereference of noderef expression
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   net/xfrm/xfrm_state.c:2082:17: sparse: sparse: dereference of noderef expression
   net/xfrm/xfrm_state.c:2101:17: sparse: sparse: dereference of noderef expression
   net/xfrm/xfrm_state.c:2288:17: sparse: sparse: dereference of noderef expression
   include/linux/list.h:83:21: sparse: sparse: self-comparison always evaluates to true
   net/xfrm/xfrm_state.c: note: in included file:
   include/net/xfrm.h:1947:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   include/net/xfrm.h:1947:16: sparse:    struct sock [noderef] __rcu *
   include/net/xfrm.h:1947:16: sparse:    struct sock *

vim +58 net/xfrm/xfrm_state.c

    55	
    56	static inline bool xfrm_state_hold_rcu(struct xfrm_state __rcu *x)
    57	{
  > 58		return rcuref_get(&x->ref);
    59	}
    60	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

