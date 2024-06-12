Return-Path: <netdev+bounces-102891-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F13E2905552
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 16:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72DF51F2138A
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 14:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFEBB17E460;
	Wed, 12 Jun 2024 14:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JPCF2hgT"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA4E17DE39
	for <netdev@vger.kernel.org>; Wed, 12 Jun 2024 14:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718203137; cv=none; b=N8QtOI+qAh3QXHwP+v+N96xTrLCp3FY3GiSQ0chUsJ2SGTBofXJB7FpYdvgSIV0cnI5nzAgdW6JE55+39tcJOGIPCCXEBrWZmz0x7FLTtnse8QbeeUzV5J8kQRrx37jvEd89Wv7BhsejqM4hZLKCLRFqoVtaD9jSP8FpgHrUh7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718203137; c=relaxed/simple;
	bh=AHtyrNAaz8E2yK8VqdziN+klvjvgf0RMo+inp2JPpUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B37cJaglE8N16tCZklB35r2cXWAn39/aqii26xJbE7DxthQTzzbY49h1m+cljvj0ulkdnDv34cCwfgyIbLquL2YTZLLBS/Gcgaoz+/2xETa+Hvvc75ThIukZZABrU2ODNF3C2PW0j8ytuvS5EXH4d53/YM22Y6bIzpRVwT6Y+vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JPCF2hgT; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718203135; x=1749739135;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AHtyrNAaz8E2yK8VqdziN+klvjvgf0RMo+inp2JPpUQ=;
  b=JPCF2hgTuKjTdmWm3xGYislz0gHiq9q9WUe9nVsx0pX4l+g5u2NJAqkr
   G2upymtS73UklIFUkHJACg06UAvFjK4ZKugiWeuR89QbsqztENuujleeg
   V8G3u+dV/sqzYHMOUxIXoyjZB/FG2W4yj9O0Cg29/zzGABSYhZ7FYe0Hp
   Pj2BiLEOaKzg/jBVU82e9ZkMcWFhTdQea9dEf4Li5BiQ+kKIdUwpsX50y
   yj9G6SgYpogtn1MO0YWlbbZxCB4TC/Q9+usFmnXx48vJcV91ekKHvbcr5
   b1clwpNEdIxsF0ZyOwvkhIvN5eqfM4U5PzMiAZ35HVdZ6pWK+dC745dIn
   A==;
X-CSE-ConnectionGUID: rAKe4ClYRkaIq49bvcKEXw==
X-CSE-MsgGUID: ksgM7qSEQBWetrXgVMyntA==
X-IronPort-AV: E=McAfee;i="6700,10204,11101"; a="32516978"
X-IronPort-AV: E=Sophos;i="6.08,233,1712646000"; 
   d="scan'208";a="32516978"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 07:38:55 -0700
X-CSE-ConnectionGUID: LMAcOGVxT3Krq3DMqracTA==
X-CSE-MsgGUID: HYAXCjQnRTeIGIIjVbh1Eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,233,1712646000"; 
   d="scan'208";a="62990041"
Received: from lkp-server01.sh.intel.com (HELO 628d7d8b9fc6) ([10.239.97.150])
  by fmviesa002.fm.intel.com with ESMTP; 12 Jun 2024 07:38:53 -0700
Received: from kbuild by 628d7d8b9fc6 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sHP7j-0001cg-1O;
	Wed, 12 Jun 2024 14:38:51 +0000
Date: Wed, 12 Jun 2024 22:38:39 +0800
From: kernel test robot <lkp@intel.com>
To: Steffen Klassert <steffen.klassert@secunet.com>,
	Jianbo Liu <jianbol@nvidia.com>, Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH ipsec] xfrm: Fix unregister netdevice hang on hardware
 offload.
Message-ID: <202406122121.zejJ7IGG-lkp@intel.com>
References: <ZmlmTTYL6AkBel4P@gauss3.secunet.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmlmTTYL6AkBel4P@gauss3.secunet.de>

Hi Steffen,

kernel test robot noticed the following build errors:

[auto build test ERROR on klassert-ipsec-next/master]
[also build test ERROR on klassert-ipsec/master net/main net-next/main linus/master v6.10-rc3 next-20240612]
[cannot apply to horms-ipvs/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Steffen-Klassert/xfrm-Fix-unregister-netdevice-hang-on-hardware-offload/20240612-171414
base:   https://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec-next.git master
patch link:    https://lore.kernel.org/r/ZmlmTTYL6AkBel4P%40gauss3.secunet.de
patch subject: [PATCH ipsec] xfrm: Fix unregister netdevice hang on hardware offload.
config: riscv-defconfig (https://download.01.org/0day-ci/archive/20240612/202406122121.zejJ7IGG-lkp@intel.com/config)
compiler: clang version 19.0.0git (https://github.com/llvm/llvm-project 4403cdbaf01379de96f8d0d6ea4f51a085e37766)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240612/202406122121.zejJ7IGG-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406122121.zejJ7IGG-lkp@intel.com/

All errors (new ones prefixed by >>):

   In file included from net/xfrm/xfrm_state.c:19:
   In file included from include/net/xfrm.h:9:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:8:
   In file included from include/linux/cacheflush.h:5:
   In file included from arch/riscv/include/asm/cacheflush.h:9:
   In file included from include/linux/mm.h:2253:
   include/linux/vmstat.h:514:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     514 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   net/xfrm/xfrm_state.c:688:6: error: redefinition of 'xfrm_dev_state_delete'
     688 | void xfrm_dev_state_delete(struct xfrm_state *x)
         |      ^
   include/net/xfrm.h:2022:20: note: previous definition is here
    2022 | static inline void xfrm_dev_state_delete(struct xfrm_state *x)
         |                    ^
>> net/xfrm/xfrm_state.c:694:8: error: no member named 'xfrmdev_ops' in 'struct net_device'
     694 |                 dev->xfrmdev_ops->xdo_dev_state_delete(x);
         |                 ~~~  ^
   net/xfrm/xfrm_state.c:701:6: error: redefinition of 'xfrm_dev_state_free'
     701 | void xfrm_dev_state_free(struct xfrm_state *x)
         |      ^
   include/net/xfrm.h:2026:20: note: previous definition is here
    2026 | static inline void xfrm_dev_state_free(struct xfrm_state *x)
         |                    ^
   net/xfrm/xfrm_state.c:706:18: error: no member named 'xfrmdev_ops' in 'struct net_device'; did you mean 'l3mdev_ops'?
     706 |         if (dev && dev->xfrmdev_ops) {
         |                         ^~~~~~~~~~~
         |                         l3mdev_ops
   include/linux/netdevice.h:2171:27: note: 'l3mdev_ops' declared here
    2171 |         const struct l3mdev_ops *l3mdev_ops;
         |                                  ^
   net/xfrm/xfrm_state.c:712:12: error: no member named 'xfrmdev_ops' in 'struct net_device'
     712 |                 if (dev->xfrmdev_ops->xdo_dev_state_free)
         |                     ~~~  ^
   net/xfrm/xfrm_state.c:713:9: error: no member named 'xfrmdev_ops' in 'struct net_device'
     713 |                         dev->xfrmdev_ops->xdo_dev_state_free(x);
         |                         ~~~  ^
   1 warning and 6 errors generated.


vim +694 net/xfrm/xfrm_state.c

   687	
   688	void xfrm_dev_state_delete(struct xfrm_state *x)
   689	{
   690		struct xfrm_dev_offload *xso = &x->xso;
   691		struct net_device *dev = READ_ONCE(xso->dev);
   692	
   693		if (dev) {
 > 694			dev->xfrmdev_ops->xdo_dev_state_delete(x);
   695			spin_lock_bh(&xfrm_state_dev_gc_lock);
   696			hlist_add_head(&x->dev_gclist, &xfrm_state_dev_gc_list);
   697			spin_unlock_bh(&xfrm_state_dev_gc_lock);
   698		}
   699	}
   700	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

