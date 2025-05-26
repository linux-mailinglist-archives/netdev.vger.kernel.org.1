Return-Path: <netdev+bounces-193407-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E79CAC3D4D
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 11:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4DEB3A6942
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 09:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9921F12F8;
	Mon, 26 May 2025 09:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JGQyd2ay"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6960A1E47C7;
	Mon, 26 May 2025 09:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748253033; cv=none; b=RrljF/CexShG+UG+I80wApOloszCoEMhuQTtq4S9ft95FXv/d4M+uVMS0PBYZFsxCiHGB9p9+HB54Qqt1bmkAmex6rSBkb8YbjKrtwBaEUmhL7P8jTU9T4tk/QF/zUqMB7QcB+iBXSuThlLtHTA4cQ8SQx9zoTXAIhmOgdpQjqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748253033; c=relaxed/simple;
	bh=k8W9IMWqlg3awBaLy/B4M+WCIrs4yjbjsrjIkPtZEqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f3YwQQ81VNUJG5bShBB8OMCEgkd6t/9EKrx3B7Ru72urCfASkTc9flnEoCr+WGk9z2UL5vet+prDeG2fY5b8i1vgcO12iyckFnj+2o5EOnPRWok1Qoz9AQD/gklGn+pwuUht5MuosjZAi5PSh4sBAcVKzrhbUD8Jy9aDtNes9uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JGQyd2ay; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748253032; x=1779789032;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=k8W9IMWqlg3awBaLy/B4M+WCIrs4yjbjsrjIkPtZEqs=;
  b=JGQyd2aySsQUUbsbYe/RXMM+5awI02pYLTF6LCvgAlFWb7wAj63ND1h+
   tDp4GE8tdPwhPO/zoThWmOG8us04xsRCqtD3GoO/kxmybr/rV8zF9+YK8
   PRF6dsfZCjXWfLsiJpv8z9Ri8L18Ps5xXQmgMxjfacdYhFTxZ8ADziZK/
   bCzudKhXT4ic33fclcyfdkCxSbm9GqX4s2giqZ44w8soSZ0L5EexUGMzd
   oL9RRGZIvgHbkMcZL3BLg+A5EMUFdPIw+uvonJWosx68fbJGv5+27L72Z
   zTTnJ2bWPRAbCo74j/YtpoVsb0QfBKkqZILi71SRRfApoEv4nJvv3RIlU
   A==;
X-CSE-ConnectionGUID: N9Z6agALRUSMjs8JFgfDgg==
X-CSE-MsgGUID: 6h8bR0//TTSZqrk6gLtYCw==
X-IronPort-AV: E=McAfee;i="6700,10204,11444"; a="60881381"
X-IronPort-AV: E=Sophos;i="6.15,315,1739865600"; 
   d="scan'208";a="60881381"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2025 02:50:31 -0700
X-CSE-ConnectionGUID: /5J6CnMpQbeq8ptkzvtP9Q==
X-CSE-MsgGUID: 8o5re7M0REW+IMUDEjJ8Sg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,315,1739865600"; 
   d="scan'208";a="147526393"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa005.jf.intel.com with ESMTP; 26 May 2025 02:50:27 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uJUTQ-000SHY-0V;
	Mon, 26 May 2025 09:50:24 +0000
Date: Mon, 26 May 2025 17:49:36 +0800
From: kernel test robot <lkp@intel.com>
To: yangtengteng@bytedance.com, edumazet@google.com, kuniyu@amazon.com,
	pabeni@redhat.com, willemb@google.com, davem@davemloft.net,
	kuba@kernel.org, horms@kernel.org, wuyun.abel@bytedance.com,
	shakeel.butt@linux.dev
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	zhoufeng.zf@bytedance.com, wangdongdong.6@bytedance.com,
	zhangrui.rod@bytedance.com, yangzhenze@bytedance.com,
	yangtengteng@bytedance.com
Subject: Re: [PATCH net-next] Fix sock_exceed_buf_limit not being triggered
 in __sk_mem_raise_allocated
Message-ID: <202505261743.n48LBgti-lkp@intel.com>
References: <20250526064619.5412-1-yangtengteng@bytedance.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250526064619.5412-1-yangtengteng@bytedance.com>

Hi,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/yangtengteng-bytedance-com/Fix-sock_exceed_buf_limit-not-being-triggered-in-__sk_mem_raise_allocated/20250526-144725
base:   net-next/main
patch link:    https://lore.kernel.org/r/20250526064619.5412-1-yangtengteng%40bytedance.com
patch subject: [PATCH net-next] Fix sock_exceed_buf_limit not being triggered in __sk_mem_raise_allocated
config: i386-buildonly-randconfig-002-20250526 (https://download.01.org/0day-ci/archive/20250526/202505261743.n48LBgti-lkp@intel.com/config)
compiler: clang version 20.1.2 (https://github.com/llvm/llvm-project 58df0ef89dd64126512e4ee27b4ac3fd8ddf6247)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250526/202505261743.n48LBgti-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505261743.n48LBgti-lkp@intel.com/

All errors (new ones prefixed by >>):

>> net/core/sock.c:3284:67: error: expected ')'
    3284 |                 charged = mem_cgroup_charge_skmem(memcg, amt, gfp_memcg_charge();
         |                                                                                 ^
   net/core/sock.c:3284:36: note: to match this '('
    3284 |                 charged = mem_cgroup_charge_skmem(memcg, amt, gfp_memcg_charge();
         |                                                  ^
   1 error generated.


vim +3284 net/core/sock.c

  3257	
  3258	/**
  3259	 *	__sk_mem_raise_allocated - increase memory_allocated
  3260	 *	@sk: socket
  3261	 *	@size: memory size to allocate
  3262	 *	@amt: pages to allocate
  3263	 *	@kind: allocation type
  3264	 *
  3265	 *	Similar to __sk_mem_schedule(), but does not update sk_forward_alloc.
  3266	 *
  3267	 *	Unlike the globally shared limits among the sockets under same protocol,
  3268	 *	consuming the budget of a memcg won't have direct effect on other ones.
  3269	 *	So be optimistic about memcg's tolerance, and leave the callers to decide
  3270	 *	whether or not to raise allocated through sk_under_memory_pressure() or
  3271	 *	its variants.
  3272	 */
  3273	int __sk_mem_raise_allocated(struct sock *sk, int size, int amt, int kind)
  3274	{
  3275		struct mem_cgroup *memcg = mem_cgroup_sockets_enabled ? sk->sk_memcg : NULL;
  3276		struct proto *prot = sk->sk_prot;
  3277		bool charged = true;
  3278		long allocated;
  3279	
  3280		sk_memory_allocated_add(sk, amt);
  3281		allocated = sk_memory_allocated(sk);
  3282	
  3283		if (memcg) {
> 3284			charged = mem_cgroup_charge_skmem(memcg, amt, gfp_memcg_charge();
  3285			if (!charged)
  3286				goto suppress_allocation;
  3287		}
  3288	
  3289		/* Under limit. */
  3290		if (allocated <= sk_prot_mem_limits(sk, 0)) {
  3291			sk_leave_memory_pressure(sk);
  3292			return 1;
  3293		}
  3294	
  3295		/* Under pressure. */
  3296		if (allocated > sk_prot_mem_limits(sk, 1))
  3297			sk_enter_memory_pressure(sk);
  3298	
  3299		/* Over hard limit. */
  3300		if (allocated > sk_prot_mem_limits(sk, 2))
  3301			goto suppress_allocation;
  3302	
  3303		/* Guarantee minimum buffer size under pressure (either global
  3304		 * or memcg) to make sure features described in RFC 7323 (TCP
  3305		 * Extensions for High Performance) work properly.
  3306		 *
  3307		 * This rule does NOT stand when exceeds global or memcg's hard
  3308		 * limit, or else a DoS attack can be taken place by spawning
  3309		 * lots of sockets whose usage are under minimum buffer size.
  3310		 */
  3311		if (kind == SK_MEM_RECV) {
  3312			if (atomic_read(&sk->sk_rmem_alloc) < sk_get_rmem0(sk, prot))
  3313				return 1;
  3314	
  3315		} else { /* SK_MEM_SEND */
  3316			int wmem0 = sk_get_wmem0(sk, prot);
  3317	
  3318			if (sk->sk_type == SOCK_STREAM) {
  3319				if (sk->sk_wmem_queued < wmem0)
  3320					return 1;
  3321			} else if (refcount_read(&sk->sk_wmem_alloc) < wmem0) {
  3322					return 1;
  3323			}
  3324		}
  3325	
  3326		if (sk_has_memory_pressure(sk)) {
  3327			u64 alloc;
  3328	
  3329			/* The following 'average' heuristic is within the
  3330			 * scope of global accounting, so it only makes
  3331			 * sense for global memory pressure.
  3332			 */
  3333			if (!sk_under_global_memory_pressure(sk))
  3334				return 1;
  3335	
  3336			/* Try to be fair among all the sockets under global
  3337			 * pressure by allowing the ones that below average
  3338			 * usage to raise.
  3339			 */
  3340			alloc = sk_sockets_allocated_read_positive(sk);
  3341			if (sk_prot_mem_limits(sk, 2) > alloc *
  3342			    sk_mem_pages(sk->sk_wmem_queued +
  3343					 atomic_read(&sk->sk_rmem_alloc) +
  3344					 sk->sk_forward_alloc))
  3345				return 1;
  3346		}
  3347	
  3348	suppress_allocation:
  3349	
  3350		if (kind == SK_MEM_SEND && sk->sk_type == SOCK_STREAM) {
  3351			sk_stream_moderate_sndbuf(sk);
  3352	
  3353			/* Fail only if socket is _under_ its sndbuf.
  3354			 * In this case we cannot block, so that we have to fail.
  3355			 */
  3356			if (sk->sk_wmem_queued + size >= sk->sk_sndbuf) {
  3357				/* Force charge with __GFP_NOFAIL */
  3358				if (memcg && !charged) {
  3359					mem_cgroup_charge_skmem(memcg, amt,
  3360						gfp_memcg_charge() | __GFP_NOFAIL);
  3361				}
  3362				return 1;
  3363			}
  3364		}
  3365	
  3366		if (kind == SK_MEM_SEND || (kind == SK_MEM_RECV && charged))
  3367			trace_sock_exceed_buf_limit(sk, prot, allocated, kind);
  3368	
  3369		sk_memory_allocated_sub(sk, amt);
  3370	
  3371		if (memcg && charged)
  3372			mem_cgroup_uncharge_skmem(memcg, amt);
  3373	
  3374		return 0;
  3375	}
  3376	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

